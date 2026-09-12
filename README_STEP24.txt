SafeNexus HSE - Step 24
HSE Analytics & Management Intelligence Center

Main file:
lib/safenexus_step24_analytics_center.dart

Included:
24A HSE Analytics Dashboard
24B Risk & Critical Risk Analytics
24C PTW Analytics
24D Workforce & Competency Analytics
24E Equipment & Inspection Analytics
24F Daily HSE Performance Analytics
24G Incident & Near-Miss Analytics
24H Audit / CAPA Analytics
24I Environmental & Emergency Analytics
24J Legal Compliance Analytics
24K KPI Trend & Management Review
24L Management Priority & Action Intelligence

Architecture:
16 Phases + Steps 17-23 -> Analytics data -> KPI/trends ->
Management priorities.

Features:
- Standalone analytics data model.
- Source loader architecture.
- SharedPreferences persistence.
- Generic JSON record mapping.
- Search.
- Category / Phase / Priority filters.
- Total, critical, overdue and completed metrics.
- Completion percentage.
- KPI achievement percentage.
- Category distribution.
- 16-phase distribution.
- Priority distribution.
- Management intelligence triggers.
- Local record delete/clear.
- Safe loading: one failed source does not stop the dashboard.
- Existing modules are not modified.

Important:
This file does not automatically assume or invent real records.
For production integration, register the actual SharedPreferences keys or
loader callbacks used by the existing modules.

Dependency:
shared_preferences

Validation:
1. Copy the Dart file into lib/.
2. Ensure shared_preferences is already in pubspec.yaml.
3. Run flutter pub get.
4. Run flutter analyze.
5. Run GitHub Actions Android build.
6. Mark Step 24 GREEN only after GitHub Actions is green.
