SafeNexus HSE - Step 20
Production Integration & Final App Shell

File:
lib/safenexus_production_app_shell.dart

Purpose:
- Production-style Home / Modules / Management shell.
- Bottom navigation.
- 16 phases + Steps 17, 18 and 19.
- Global module search and grouping.
- Favorites and recent modules.
- Quick access to critical HSE modules.
- HSE lifecycle overview.
- Safe builder-based connection to existing module pages.
- Does not modify existing phase files.

Dependency:
shared_preferences

Use:
1. Copy the Dart file into lib/.
2. Ensure shared_preferences is already present in pubspec.yaml.
3. Connect existing pages by passing SafeNexusProductionModule entries
   with builder callbacks from main.dart.
4. Run flutter pub get.
5. Run GitHub Actions / flutter analyze and build.

Note:
This file is intentionally an integration shell. The existing module files
remain independent to reduce regression risk.
