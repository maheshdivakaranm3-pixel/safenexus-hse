# SafeNexus HSE - Step 32
## HSE Field Operations & Mobile Work Center

Single-file implementation:
`lib/safenexus_step32_field_operations.dart`

Modules:
32A Field Work Master
32B Daily HSE Field Plan
32C Site Walk / Field Observation
32D Hazard & Unsafe Condition Capture
32E Immediate Corrective Action
32F Worker / Contractor Engagement
32G Toolbox Talk Field Record
32H Permit / Risk / RAMS Field Verification
32I Equipment & PPE Field Verification
32J Finding Escalation & Follow-up
32K Field Action Closure & Verification
32L Field HSE Intelligence Dashboard

Workflow:
Plan -> Visit Site -> Observe -> Record Hazard -> Control Immediately
-> Assign Action -> Verify -> Close -> Analyze

Integration references:
Step 9 Daily HSE, Step 31 Smart Checklists, Risk, PTW, RAMS,
Workforce, Equipment, Incident, Action Center.

Storage:
SharedPreferences key:
`safenexus_hse_step32_field_operations`

Note:
This module is a local operational register. Actual cross-screen navigation
can be wired through the optional `sourceOpener` callback.
