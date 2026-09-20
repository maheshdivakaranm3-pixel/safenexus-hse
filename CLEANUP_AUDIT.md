# SafeNexus HSE — Final Clean Audit / Stage 3B

Source basis: latest user-uploaded safenexus-hse-main.zip.

## Changes made
- Preserved the complete project structure and existing HSE content.
- Preserved the current Abu Dhabi Gold router and its Stage 3B mappings.
- Removed only verified unreferenced/obsolete duplicate Gold data files:
  - lib/data/abu_dhabi_plant_equipment_complete_gold.dart
  - lib/data/abu_dhabi_specialist_hse_complete_gold.dart
  - lib/data/abu_dhabi_steps_5N_to_5Q_gold.dart
  - lib/data/abu_dhabi_telehandler_gold.dart
  - lib/data/abu_dhabi_5AA_plant_equipment_gap_audit.dart
- Kept worker welfare, plant subchapter Gold files, generic Abu Dhabi content, and other modules because they are content/future-use assets rather than proven duplicates.
- Version changed from 1.0.1+2 to 1.0.2+3 to clearly identify the clean build.

## Important runtime architecture
- AbuDhabiHseTopicPage calls buildAbuDhabiGoldTopicPage(topic) first.
- Gold topics therefore take priority over generic Abu Dhabi topic content.
- CoP 29.0 remains on the dedicated Excavation Gold page.
- CoP 36.0 uses the Plant & Equipment Gold Index.
- Generic abu_dhabi_hse_topic_content.dart remains as fallback and was not deleted.

## Not claimed
- No Flutter analyze/build was run in this environment.
- This package should be pushed to GitHub as a complete replacement of the repository contents, then a fresh APK should be built.
