export default {
  async fetch(request, env) {
    // ============================================================
    // CORS / PREFLIGHT
    // ============================================================

    if (request.method === "OPTIONS") {
      return new Response(null, {
        status: 204,
        headers: corsHeaders(),
      });
    }

    // ============================================================
    // POST ONLY
    // ============================================================

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

    // ============================================================
    // ENDPOINT
    // ============================================================

    if (url.pathname !== "/analyze-hse") {
      return jsonResponse(
        {
          success: false,
          error: "Endpoint not found.",
        },
        404
      );
    }

    // ============================================================
    // OPENAI API KEY
    // ============================================================

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
      // ==========================================================
      // REQUEST BODY
      // ==========================================================

      let body;

      try {
        body = await request.json();
      } catch (_) {
        return jsonResponse(
          {
            success: false,
            error: "Invalid JSON request body.",
          },
          400
        );
      }

      const imageBase64 = body?.image_base64;
      const mimeType = body?.mime_type || "image/jpeg";
      const description =
        typeof body?.description === "string"
          ? body.description.trim()
          : "";
      const location =
        typeof body?.location === "string"
          ? body.location.trim()
          : "";

      // ==========================================================
      // IMAGE VALIDATION
      // ==========================================================

      if (
        !imageBase64 ||
        typeof imageBase64 !== "string"
      ) {
        return jsonResponse(
          {
            success: false,
            error: "image_base64 is required.",
          },
          400
        );
      }

      // Remove accidental data URL prefix if Flutter sends one.
      const cleanBase64 = imageBase64
        .replace(/^data:[^;]+;base64,/, "")
        .trim();

      if (!cleanBase64) {
        return jsonResponse(
          {
            success: false,
            error: "Image data is empty.",
          },
          400
        );
      }

      // ==========================================================
      // MIME TYPE VALIDATION
      // ==========================================================

      const allowedMimeTypes = [
        "image/jpeg",
        "image/png",
        "image/webp",
      ];

      if (!allowedMimeTypes.includes(mimeType)) {
        return jsonResponse(
          {
            success: false,
            error:
              "Unsupported image type. Use JPEG, PNG or WebP.",
          },
          400
        );
      }

      // ==========================================================
      // BASIC BASE64 VALIDATION
      // ==========================================================

      const base64Pattern =
        /^[A-Za-z0-9+/]+={0,2}$/;

      if (!base64Pattern.test(cleanBase64)) {
        return jsonResponse(
          {
            success: false,
            error: "Invalid base64 image data.",
          },
          400
        );
      }

      // ==========================================================
      // IMAGE SIZE PROTECTION
      // ==========================================================

      // Approximate decoded size.
      const estimatedBytes =
        Math.floor(
          (cleanBase64.length * 3) / 4
        );

      // 10 MB maximum.
      const maxImageBytes = 10 * 1024 * 1024;

      if (estimatedBytes > maxImageBytes) {
        return jsonResponse(
          {
            success: false,
            error:
              "Image is too large. Maximum allowed size is 10 MB.",
          },
          413
        );
      }

      // ==========================================================
      // IMAGE DATA URL
      // ==========================================================

      const imageUrl =
        `data:${mimeType};base64,${cleanBase64}`;

      // ==========================================================
      // HSE SYSTEM INSTRUCTIONS
      // ==========================================================

      const systemPrompt = `
You are an expert HSE Safety Observation Analyst.

Your job is to analyze workplace images for visible occupational
health, safety and environmental hazards.

IMPORTANT SAFETY RULES:

1. Do not identify people.
2. Do not guess personal identity.
3. Do not infer sensitive personal information.
4. Do not invent hazards that cannot reasonably be seen.
5. Only report hazards reasonably supported by the image.
6. If the image is unclear, state the limitation.
7. Give practical and realistic HSE corrective actions.
8. Risk level must be exactly:
   Low, Medium, High, or Critical.
9. Observation type must be exactly:
   Unsafe Act, Unsafe Condition, or Positive Observation.
10. Confidence must be a number from 0 to 1.
11. The HSE officer must review the AI result before taking action.
12. Do not claim that an unsafe condition is definitely present when
    the image does not provide enough evidence.

CHECK THE IMAGE FOR:

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
- Barricading
- Access and egress
- Emergency preparedness
- Fall protection
- Excavation safety
- Tools and equipment
- General workplace safety

RISK GUIDANCE:

Low:
Minor issue with limited potential consequence.

Medium:
Potential for injury or moderate operational consequence.

High:
Significant potential for serious injury, major incident or serious
property/environmental impact.

Critical:
Immediate and severe danger with potential for fatality, multiple
serious injuries or major catastrophic consequence.

IMPORTANT:
Do not automatically assign High or Critical simply because a hazard
category exists. Base the risk assessment on the visible conditions.
`;

      // ==========================================================
      // USER PROMPT
      // ==========================================================

      const userPrompt = `
Analyze the provided workplace image.

Additional observation description:
${description || "No additional description provided."}

Location:
${location || "Location not provided."}

Return one structured HSE observation based on the visible evidence.
`;

      // ==========================================================
      // OPENAI RESPONSES API
      // ==========================================================

      const openAIResponse = await fetch(
        "https://api.openai.com/v1/responses",
        {
          method: "POST",

          headers: {
            "Content-Type": "application/json",
            "Authorization":
              `Bearer ${env.OPENAI_API_KEY}`,
          },

          body: JSON.stringify({
            model: "gpt-5-mini",

            input: [
              {
                role: "system",
                content: [
                  {
                    type: "input_text",
                    text: systemPrompt,
                  },
                ],
              },

              {
                role: "user",
                content: [
                  {
                    type: "input_text",
                    text: userPrompt,
                  },

                  {
                    type: "input_image",
                    image_url: imageUrl,
                  },
                ],
              },
            ],

            // ====================================================
            // STRUCTURED JSON OUTPUT
            // ====================================================

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
                      minimum: 0,
                      maximum: 1,
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

      // ==========================================================
      // OPENAI RESPONSE
      // ==========================================================

      const data = await openAIResponse.json();

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

      // ==========================================================
      // EXTRACT OUTPUT TEXT
      // ==========================================================

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

      // ==========================================================
      // PARSE JSON
      // ==========================================================

      let result;

      try {
        result = JSON.parse(outputText);
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

      // ==========================================================
      // RESULT VALIDATION
      // ==========================================================

      const validationError =
        validateHSEResult(result);

      if (validationError) {
        return jsonResponse(
          {
            success: false,
            error:
              `Invalid AI result: ${validationError}`,
          },
          502
        );
      }

      // ==========================================================
      // SUCCESS RESPONSE
      // ==========================================================

      return jsonResponse({
        success: true,
        result,
      });

    } catch (error) {
      // ==========================================================
      // UNEXPECTED ERROR
      // ==========================================================

      console.error(
        "SafeNexus HSE Worker Error:",
        error
      );

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

// ================================================================
// EXTRACT OPENAI OUTPUT TEXT
// ================================================================

function extractOutputText(data) {
  if (!data?.output || !Array.isArray(data.output)) {
    return null;
  }

  for (const item of data.output) {
    if (item?.type !== "message") {
      continue;
    }

    if (!Array.isArray(item.content)) {
      continue;
    }

    for (const content of item.content) {
      if (
        content?.type === "output_text" &&
        typeof content.text === "string" &&
        content.text.trim()
      ) {
        return content.text.trim();
      }
    }
  }

  return null;
}

// ================================================================
// VALIDATE HSE RESULT
// ================================================================

function validateHSEResult(result) {
  if (!result || typeof result !== "object") {
    return "Result is not an object.";
  }

  const allowedObservationTypes = [
    "Unsafe Act",
    "Unsafe Condition",
    "Positive Observation",
  ];

  const allowedRiskLevels = [
    "Low",
    "Medium",
    "High",
    "Critical",
  ];

  if (
    !allowedObservationTypes.includes(
      result.observation_type
    )
  ) {
    return "Invalid observation_type.";
  }

  if (
    !allowedRiskLevels.includes(
      result.risk_level
    )
  ) {
    return "Invalid risk_level.";
  }

  const requiredStringFields = [
    "category",
    "hazard",
    "potential_consequence",
    "corrective_action",
    "explanation",
  ];

  for (const field of requiredStringFields) {
    if (
      typeof result[field] !== "string" ||
      !result[field].trim()
    ) {
      return `${field} is missing or invalid.`;
    }
  }

  if (
    typeof result.confidence !== "number" ||
    !Number.isFinite(result.confidence) ||
    result.confidence < 0 ||
    result.confidence > 1
  ) {
    return "Confidence must be a number between 0 and 1.";
  }

  return null;
}

// ================================================================
// CORS HEADERS
// ================================================================

function corsHeaders() {
  return {
    "Access-Control-Allow-Origin": "*",

    "Access-Control-Allow-Methods":
      "POST, OPTIONS",

    "Access-Control-Allow-Headers":
      "Content-Type",

    "Access-Control-Max-Age":
      "86400",
  };
}

// ================================================================
// JSON RESPONSE
// ================================================================

function jsonResponse(
  data,
  status = 200
) {
  return new Response(
    JSON.stringify(data),
    {
      status,

      headers: {
        "Content-Type":
          "application/json; charset=utf-8",

        ...corsHeaders(),
      },
    }
  );
  }
