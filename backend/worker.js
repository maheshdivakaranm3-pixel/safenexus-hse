export default {
  async fetch(request, env) {
    // ----------------------------------------------------------
    // CORS
    // ----------------------------------------------------------

    if (request.method === "OPTIONS") {
      return new Response(null, {
        status: 204,
        headers: corsHeaders(),
      });
    }

    // ----------------------------------------------------------
    // POST ONLY
    // ----------------------------------------------------------

    if (request.method !== "POST") {
      return jsonResponse(
        {
          success: false,
          error: "Only POST requests are allowed.",
        },
        405
      );
    }

    const url = new URL(request.url);

    // ----------------------------------------------------------
    // ENDPOINT
    // ----------------------------------------------------------

    if (url.pathname !== "/analyze-hse") {
      return jsonResponse(
        {
          success: false,
          error: "Endpoint not found.",
        },
        404
      );
    }

    // ----------------------------------------------------------
    // OPENAI KEY CHECK
    // ----------------------------------------------------------

    if (!env.OPENAI_API_KEY) {
      return jsonResponse(
        {
          success: false,
          error: "OPENAI_API_KEY is not configured.",
        },
        500
      );
    }

    try {
      // --------------------------------------------------------
      // REQUEST BODY
      // --------------------------------------------------------

      const body = await request.json();

      const imageBase64 =
        body.image_base64;

      const mimeType =
        body.mime_type || "image/jpeg";

      const description =
        body.description || "";

      const location =
        body.location || "";

      if (!imageBase64) {
        return jsonResponse(
          {
            success: false,
            error:
              "image_base64 is required.",
          },
          400
        );
      }

      // --------------------------------------------------------
      // IMAGE DATA URL
      // --------------------------------------------------------

      const imageUrl =
        `data:${mimeType};base64,${imageBase64}`;

      // --------------------------------------------------------
      // OPENAI RESPONSES API
      // --------------------------------------------------------

      const openAIResponse =
        await fetch(
          "https://api.openai.com/v1/responses",
          {
            method: "POST",

            headers: {
              "Content-Type":
                "application/json",

              "Authorization":
                `Bearer ${env.OPENAI_API_KEY}`,
            },

            body: JSON.stringify({
              model: "gpt-5.6",

              input: [
                {
                  role: "user",

                  content: [
                    {
                      type: "input_text",

                      text: `
You are an expert HSE safety observation analyst.

Analyze this workplace photo for safety hazards.

Focus on:
- PPE
- Work at height
- Scaffolding
- Electrical safety
- Fire safety
- Lifting and rigging
- Housekeeping
- Slip, trip and fall
- Vehicle and traffic safety
- Chemical safety
- Confined space
- Manual handling
- Machinery safety
- Heat stress
- Environmental safety
- Permit to work

Rules:
1. Do not identify people.
2. Do not guess personal identity.
3. Do not invent hazards that cannot reasonably be seen.
4. If the image is unclear, explain the limitation.
5. Give practical HSE corrective actions.
6. Risk must be Low, Medium, High or Critical.
7. Observation type must be Unsafe Act, Unsafe Condition or Positive Observation.
8. The HSE officer must review the AI result before taking action.

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

              // ------------------------------------------------
              // STRUCTURED JSON OUTPUT
              // ------------------------------------------------

              text: {
                format: {
                  type: "json_schema",

                  name: "hse_observation",

                  strict: true,

                  schema: {
                    type: "object",

                    additionalProperties:
                      false,

                    properties: {
                      observation_type: {
                        type: "string",

                        enum: [
                          "Unsafe Act",
                          "Unsafe Condition",
                          "Positive Observation",
                        ],
                      },

                      category: {
                        type: "string",
                      },

                      hazard: {
                        type: "string",
                      },

                      risk_level: {
                        type: "string",

                        enum: [
                          "Low",
                          "Medium",
                          "High",
                          "Critical",
                        ],
                      },

                      potential_consequence: {
                        type: "string",
                      },

                      corrective_action: {
                        type: "string",
                      },

                      confidence: {
                        type: "number",
                      },

                      explanation: {
                        type: "string",
                      },
                    },

                    required: [
                      "observation_type",
                      "category",
                      "hazard",
                      "risk_level",
                      "potential_consequence",
                      "corrective_action",
                      "confidence",
                      "explanation",
                    ],
                  },
                },
              },
            }),
          }
        );

      // --------------------------------------------------------
      // OPENAI RESPONSE
      // --------------------------------------------------------

      const data =
        await openAIResponse.json();

      if (!openAIResponse.ok) {
        return jsonResponse(
          {
            success: false,
            error:
              data?.error?.message ||
              "OpenAI request failed.",
          },
          openAIResponse.status
        );
      }

      // --------------------------------------------------------
      // EXTRACT TEXT
      // --------------------------------------------------------

      const outputText =
        extractOutputText(data);

      if (!outputText) {
        return jsonResponse(
          {
            success: false,
            error:
              "No AI output was returned.",
          },
          502
        );
      }

      // --------------------------------------------------------
      // PARSE JSON
      // --------------------------------------------------------

      let result;

      try {
        result =
          JSON.parse(outputText);
      } catch (_) {
        return jsonResponse(
          {
            success: false,
            error:
              "AI returned invalid JSON.",
          },
          502
        );
      }

      // --------------------------------------------------------
      // SUCCESS
      // --------------------------------------------------------

      return jsonResponse({
        success: true,
        result: result,
      });
    } catch (error) {
      return jsonResponse(
        {
          success: false,
          error:
            error?.message ||
            "Unexpected server error.",
        },
        500
      );
    }
  },
};

// ============================================================
// EXTRACT OPENAI OUTPUT TEXT
// ============================================================

function extractOutputText(data) {
  if (!data?.output) {
    return null;
  }

  for (const item of data.output) {
    if (item.type !== "message") {
      continue;
    }

    if (!Array.isArray(item.content)) {
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

// ============================================================
// CORS HEADERS
// ============================================================

function corsHeaders() {
  return {
    "Access-Control-Allow-Origin": "*",

    "Access-Control-Allow-Methods":
      "POST, OPTIONS",

    "Access-Control-Allow-Headers":
      "Content-Type",
  };
}

// ============================================================
// JSON RESPONSE
// ============================================================

function jsonResponse(
  data,
  status = 200
) {
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
