SafeNexus HSE — Dubai HSE Professional Detailed Module

FINAL STRUCTURE
- 37 Dubai HSE topics are included.
- Each topic has its own introduction, topic-specific types/applications, topic-specific components/items, and dedicated learning sections.
- Types, components and section items are tappable and open their own detail page.
- Scaffolding has the full professional structure requested: introduction, scaffold types, components/technical information, hazards, foundation/base, erection/dismantling, guardrails/toe boards, access, bracing/ties, platforms/loading, inspection/tagging, modification/weather, stop-work, competent-person duties, worker duties, emergency response, practical example and key learning points.
- Mobile-access-tower technical figures included from Dubai Municipality Technical Guideline TG 74: upper guardrail minimum 950 mm above platform, side opening maximum 470 mm, working-platform toe board minimum 150 mm. These are not presented as universal dimensions for every scaffold system.
- Dubai HSE content is English-only.
- No “References & Official Sources” section is added inside the app.
- No generic disclaimer section is added inside the app.

GITHUB INTEGRATION
Replace ONLY:
  lib/dubai_hse_detail_page.dart

Do NOT append or merge:
  lib/data/dubai_guidelines.dart

Keep the existing dubai_guidelines.dart as a separate file. It only needs to route Dubai topics to:
  DubaiHseTopicRouter.pageFor(topic)

This package does not modify TBT, Steps 136–145, or other existing modules.
