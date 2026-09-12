# SafeNexus HSE — Step 27

## HSE User, Role & Access Control Center

Single-file implementation covering:

- 27A User Master Register
- 27B User Role Management
- 27C HSE Role & Responsibility Mapping
- 27D Module Access / Permission Control
- 27E Project & Site Access
- 27F Approval Authority Matrix
- 27G User Activation / Suspension / Deactivation
- 27H Login / Session / Security Control register
- 27I Access Change Request & Approval
- 27J User Activity / Audit Log
- 27K Access Review & Recertification
- 27L Security & Access Intelligence Dashboard

## Core flow

User Created → Role Assigned → Project/Site Assigned → Permissions Assigned → Approval Authority → Active → Periodic Access Review → Suspend/Deactivate

## Features

- User master register
- Role and access level management
- Project/site/area scope
- Module permission register
- Approval authority matrix
- Active / pending / suspended / revoked lifecycle
- Access expiry and review due tracking
- Overdue access review
- Access change request and reason
- User activity / audit history
- Search and filters
- Dashboard and security intelligence
- CRUD operations
- SharedPreferences persistence
- Source-record opener callback
- Existing SafeNexus HSE modules remain untouched

## Production security note

This module is an app-level administration register. It does not implement actual password authentication, cryptographic storage, server-side authorization, SSO, MFA, or identity-provider integration. Those controls should be implemented with the production backend/identity system.

## Integration

Add:

`lib/safenexus_step27_user_access_control.dart`

and connect `SafeNexusStep27` to the existing navigation shell.

The project should already contain `shared_preferences` in its dependencies.
