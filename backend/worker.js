export default {
  async fetch(request, env) {
    if (request.method === "OPTIONS") {
      return new Response(null, {
        status: 204,
        headers: corsHeaders(),
      });
    }

    if (request.method !== "POST") {
      return jsonResponse(
        { error: "Only POST is allowed." },
        405
      );
    }

    const url = new URL(request.url);

    if (url.pathname !== "/analyze-hse") {
      return jsonResponse(
        { error: "Endpoint not found." },
        404
      );
    }

    if (!env.OPENAI_API_KEY) {
      return jsonResponse(
        { error: "OPENAI_API_KEY is not configured." },
        500
      );
    }

    try {
      const body = await request.json();

      const imageBase64 = body.image_base64;
      const mimeType =
          body.mime_type || "image/jpeg";
      const description =
          body.description || "";
      const location =
          body.location || "";

      if (!imageBase64) {
        return jsonResponse(
          { error: "image_base64 is required." },
          400
        );
      }

      const imageUrl =
          `data:${mimeType};base64,${imageBase64}`;

      const response = await fetch(
        "https://api.openai.com/v1/responses",
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "Authorization":
                `Bearer ${env.OPENAI_API_KEY}`,
          },
          body: JSON.stringify({
            model: "gpt-5.6-luna",

            input: [
              {
                role: "user",
                content: [
                  {
                    type: "input_text",
                    text: `
You are an expert HSE safety observation analyst.

Analyze the provided workplace photo.

Important:
- Do not invent hazards that cannot reasonably be observed.
- If the image is unclear, say so.
- Do not identify a person's identity.
- Focus only on workplace safety.
- Give practical corrective actions.
- Risk must be Low, Medium, High, or Critical.
- Observation type must be Unsafe Act, Unsafe Condition, or Positive Observation.

Additional observation description:
${description}

Location:
${location}
                    `,
                  },
                  {
                    type: "input_image",
                    image_url: imageUrl,
                  },
                ],
              },
            ],

            text: {
              format: {
                type: "json_schema",
                name: "hse_observation",
                strict: true,
                schema: {
                  type: "object",
                  additionalProperties: false,
                  properties: {
                    observation_type: {
                      type: "string",
                      enum: [
                        "Unsafe Act",
                        "Unsafe Condition",
                        "Positive Observation"
                      ]
                    },
                    category: {
                      type: "string"
                    },
                    hazard: {
                      type: "string"
                    },
                    risk_level: {
                      type: "string",
                      enum: [
                        "Low",
                        "Medium",
                        "High",
                        "Critical"
                      ]
                    },
                    potential_consequence: {
                      type: "string"
                    },
                    corrective_action: {
                      type: "string"
                    },
                    confidence: {
                      type: "number"
                    },
                    explanation: {
                      type: "string"
                    }
                  },
                  required: [
                    "observation_type",
                    "category",
                    "hazard",
                    "risk_level",
                    "potential_consequence",
                    "corrective_action",
                    "confidence",
                    "explanation"
                  ]
                }
              }
            }
          }),
        }
      );

      const data = await response.json();

      if (!response.ok) {
        return jsonResponse(
          {
            error:
                data.error?.message ||
                "OpenAI request failed."
          },
          response.status
        );
      }

      const outputText =
          extractOutputText(data);

      if (!outputText) {
        return jsonResponse(
          {
            error:
                "No structured AI response received."
          },
          502
        );
      }

      let result;

      try {
        result = JSON.parse(outputText);
      } catch (_) {
        return jsonResponse(
          {
            error:
                "AI returned invalid JSON.",
            raw: outputText
          },
          502
        );
      }

      return jsonResponse({
        success: true,
        result: result,
      });
    } catch (error) {
      return jsonResponse(
        {
          error:
              error?.message ||
              "Unexpected server error."
        },
        500
      );
    }
  },
};

function extractOutputText(data) {
  if (!data?.output) {
    return null;
  }

  for (const item of data.output) {
    if (item.type !== "message") {
      continue;
    }

    if (!item.content) {
      continue;
    }

    for (const content of item.content) {
      if (
        content.type === "output_text" &&
        content.text
      ) {
        return content.text;
      }
    }
  }

  return null;
}

function corsHeaders() {
  return {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods":
        "POST, OPTIONS",
    "Access-Control-Allow-Headers":
        "Content-Type",
  };
}

function jsonResponse(data, status = 200) {
  return new Response(
    JSON.stringify(data),
    {
      status: status,
      headers: {
        "Content-Type":
            "application/json",
        ...corsHeaders(),
      },
    }
  );
  }
