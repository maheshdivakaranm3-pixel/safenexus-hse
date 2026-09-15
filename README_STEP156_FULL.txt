SafeNexus HSE — Step 156 FULL PACKAGE

UPLOAD/REPLACE THESE:
1. pubspec.yaml
2. lib/safenexus_dubai_construction_framework.dart

IMPORTANT:
- The pubspec includes the missing url_launcher dependency.
- The original flutter_launcher_icons configuration is restored:
    image_path: assets/images/safenexus_logo.png
    adaptive_icon_foreground: assets/images/safenexus_logo.png
    adaptive_icon_background: #FFFFFF
- Existing SafeNexus assets are declared.
- path_provider_foundation 2.5.1 override is retained for the previous objective_c build issue.
- Do NOT replace main.dart yet.
- Do NOT touch locked Steps 136–155.

GitHub Actions failure #1095/#1096 was caused by:
NoConfigFoundException from flutter_launcher_icons.

This package restores the configuration in pubspec.yaml, so
'dart run flutter_launcher_icons' can find its configuration.

After upload:
Commit → Actions → Analyze and Build APK.

If the next error says an asset file does not exist, do NOT create a random
replacement. Send the exact error/screenshot so the existing repository asset
can be checked first.
