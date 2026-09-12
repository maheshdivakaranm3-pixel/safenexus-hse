SafeNexus HSE - Step 22
Unified HSE Data Integration & Global Search

File:
lib/safenexus_step22_unified_data_center.dart

Purpose:
- Unified HSE record index/search layer.
- Search across Phase 1-16 and Step 17-21 sources.
- Project/site/date/status/priority filters.
- Overdue and critical record filters.
- Favourite records.
- Record details.
- Safe source loaders and SharedPreferences JSON sources.
- Source-level opener callbacks for real module navigation.
- Existing module logic remains untouched.

Integration:
Register each existing module's actual SharedPreferences key or loader
through SafeNexusRecordSource.

Important:
The default catalog contains all 16 phases + Steps 17-21, but no records
are invented. Actual records appear only after a real storage key or loader
is registered.

Dependency:
shared_preferences

Validation:
1. Copy the Dart file into lib/.
2. Register real storage keys/loaders in main.dart.
3. Run flutter pub get.
4. Run flutter analyze.
5. Run GitHub Actions Android build.
6. Only mark Step 22 GREEN after GitHub Actions is green.
