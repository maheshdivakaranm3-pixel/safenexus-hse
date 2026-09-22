# SafeNexus HSE — Abu Dhabi Scaffolding Gold Standard

Files:
- `lib/data/scaffolding_gold_standard_sections.dart`
- `lib/scaffolding_gold_router.dart`

The content is organized as a field handbook with chapters, detailed field points,
controls, inspections, stop-work conditions, emergency/rescue, checklists,
toolbox talk and interview material.

Regulatory backbone:
ADOSH-SF / ADPHC CoP 26.0 — Scaffolding, Version 4.1, effective 27 February 2026.

Integration:
1. Copy the data file into your project's `lib/data/`.
2. Copy the router/page file into `lib/`.
3. In the existing Abu Dhabi router, connect `ad_cop_26_0` to
   `ScaffoldingGoldBookPage(...)`.
4. Keep your existing `ReferenceTopic` and master router architecture.

This package intentionally does not overwrite the user's existing project files.
