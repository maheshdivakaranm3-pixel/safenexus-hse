SafeNexus HSE - Dubai HSE detail page duplicate-key fix

Replace ONLY:
lib/dubai_hse_detail_page.dart

Do NOT replace or append:
lib/data/dubai_guidelines.dart

This fix removes duplicate constant-map section keys that caused equal_keys_in_const_map errors.
