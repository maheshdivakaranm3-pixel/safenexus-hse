SafeNexus HSE - Step 23
HSE Notification & Alert Center

File:
lib/safenexus_step23_alert_center.dart

Purpose:
- Central local HSE notification/alert register.
- Expiry and overdue alerts.
- Critical risk alerts.
- PTW, training, medical, equipment, legal, emergency,
  environment, incident, action and reporting alert types.
- Read/unread state.
- Resolve/close state.
- Priority handling.
- Search and filters.
- Alert details.
- Source-module opener callback.
- SharedPreferences persistence.
- Rule engine helpers for expiry, overdue and critical-risk alerts.

Important:
- No push-notification permission is required by this file.
- This is an in-app/local alert center.
- Existing Phase 1-16 and Step 17-22 files remain untouched.
- Demo alerts are NOT automatically inserted. Call
  SafeNexusAlertCenter.seedDemoAlerts() only for testing.

Integration:
Use SafeNexusAlertCenter.createAlert(...) from existing modules when an
important event occurs, or use SafeNexusAlertRuleEngine helpers.

Dependency:
shared_preferences

Validation:
1. Copy the Dart file into lib/.
2. Add real alert calls from existing modules where appropriate.
3. Run flutter pub get.
4. Run flutter analyze.
5. Run GitHub Actions Android build.
6. Only mark Step 23 GREEN after GitHub Actions is green.
