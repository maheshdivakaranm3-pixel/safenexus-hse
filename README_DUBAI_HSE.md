# SafeNexus HSE – Dubai HSE 37 Topics v4

## Purpose
Each Dubai HSE topic now routes to its own dedicated Flutter page class.

Examples:
- Excavation & Trenching → `DubaiExcavationDetailPage`
- Scaffolding Safety → `DubaiScaffoldingDetailPage`
- Lifting Operations → `DubaiLiftingDetailPage`
- Work at Height → `DubaiWorkAtHeightDetailPage`
- Confined Space Entry → `DubaiConfinedSpaceDetailPage`

The pages use the existing topic-specific records in `lib/data/dubai_guidelines.dart`, so each topic retains its own description, key requirements, safety controls, responsibilities and field verification checks.

The Dubai detail page contains no References section and no generic disclaimer box.

`DCP-01` to `DCP-37` remain internal SafeNexus navigation identifiers only.
