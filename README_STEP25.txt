SafeNexus HSE - Step 25
HSE Document & Evidence Center

Main file:
lib/safenexus_step25_document_evidence_center.dart

Modules:
25A HSE Document Master
25B Document & Certificate Upload Register
25C HSE Evidence Repository
25D Inspection / Audit Evidence
25E Incident & Investigation Evidence
25F PTW / RAMS / Risk Evidence
25G Training / Competency Evidence
25H Equipment / Certificate Evidence
25I Legal / Compliance Evidence
25J Document Expiry & Review Tracking
25K Evidence Verification & Approval
25L Document Search & Evidence Intelligence

Features:
- Document metadata register.
- Evidence metadata register.
- Document category and status.
- Controlled document flag.
- Revision / issue tracking.
- Review and expiry dates.
- Expired / review due / expiring <=30 days indicators.
- Evidence verification status.
- Related record references.
- File name, local path and external URI/reference fields.
- Search.
- Category/status filters.
- Management intelligence panel.
- SharedPreferences persistence.
- Add and delete records.
- Document details page.
- Opener callback for integration with originating modules.
- Existing Phase 1-16 and Step 17-24 modules remain untouched.

Important:
This version manages document/evidence metadata and references.
It does NOT claim to upload binary files automatically.
A future file picker/cloud storage connector can populate filePath or
externalUri without changing the core data model.

Dependency:
shared_preferences

Validation:
1. Copy the Dart file into lib/.
2. Ensure shared_preferences is in pubspec.yaml.
3. Run flutter pub get.
4. Run flutter analyze.
5. Run GitHub Actions Android build.
6. Mark Step 25 GREEN only after GitHub Actions is green.
