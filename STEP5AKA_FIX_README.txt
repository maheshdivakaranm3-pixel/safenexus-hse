STEP 5AK-A DIRECT INTEGRATION FIX

Replace:
lib/abu_dhabi_hse_topic_page.dart

This version integrates Portable Power Tools directly into the existing
AbuDhabiHseTopicPage engine.

IMPORTANT:
Do NOT add the previous abu_dhabi_gold_topic_router.dart patch.
The router approach is intentionally removed from this fix to avoid
undefined symbols / duplicate routing.

Expected route:
ReferenceTopic id 'ad_portable_power_tools'
    -> AbuDhabiPowerToolsGoldStandardPage
    -> portablePowerToolsGoldStandardSections
    -> AbuDhabiPowerToolsGoldSectionPage

Authoritative data:
lib/data/abu_dhabi_power_tools_gold.dart
