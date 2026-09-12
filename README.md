# SafeNexus HSE — Step 26

## HSE Workflow & Approval Control Center

Single-file implementation covering:

- 26A Workflow Master
- 26B Record Review & Approval
- 26C HSE Document Approval
- 26D Risk / RAMS Approval
- 26E PTW Approval Workflow
- 26F Training / Competency Approval
- 26G Inspection / Audit Approval
- 26H Incident / CAPA Approval
- 26I Legal / Compliance Approval
- 26J Management Approval
- 26K Rejection / Revision / Re-submission
- 26L Workflow History & Approval Intelligence

### Core workflow

Create → Submit → Review → Changes Required → Re-submit → Approve → Active → Review/Expiry → Close

### Features

- Central workflow register
- Role-based reviewer / approver fields
- Approval levels and workflow stages
- Due-date and overdue tracking
- Changes required / rejection / resubmission controls
- Revision tracking
- Workflow history
- Risk, RAMS, PTW, training, audit, incident and legal references
- Search and filters
- Status / priority / module filters
- Approval intelligence
- CRUD operations
- SharedPreferences persistence
- Source-record opener callback
- No modification of existing SafeNexus HSE modules

## Integration

Add:

`lib/safenexus_step26_workflow_approval.dart`

and route the `SafeNexusStep26` widget from the existing navigation shell.

This file expects `shared_preferences` in the project's existing dependencies.
