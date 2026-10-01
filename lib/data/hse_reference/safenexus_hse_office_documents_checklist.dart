import 'package:flutter/material.dart';

/// SafeNexus HSE — Specialist / Cross-Sector
/// Single-file master checklist for 40 office documents.
/// Add this page to navigation, for example:
/// Navigator.push(context, MaterialPageRoute(builder: (_) => const HseOfficeDocumentsPage()));
///
/// This is a standalone UI/data file. It does not yet persist checked status or export PDF/Word/Excel.

class HseOfficeDocumentsPage extends StatefulWidget {
  const HseOfficeDocumentsPage({super.key});

  @override
  State<HseOfficeDocumentsPage> createState() => _HseOfficeDocumentsPageState();
}

class _HseOfficeDocumentsPageState extends State<HseOfficeDocumentsPage> {
  final Set<int> _completed = <int>{};

  static const List<_DocumentGroup> _groups = <_DocumentGroup>[
    _DocumentGroup('Company & Project Administration', <_HseDocument>[
      _HseDocument('Company HSE Profile & Project Information', 'Company identity, trade licence, contacts, client, consultant, contractor, project, location, contract reference, project leadership and emergency contacts.'),
      _HseDocument('Project HSE Plan', 'Scope, objectives, legal/client requirements, organization, risk management, PTW, training, inspections, emergency response, incident reporting, environmental controls, contractor management, audit plan and approvals.'),
      _HseDocument('HSE Policy', 'Leadership commitment, compliance, hazard elimination, risk reduction, worker consultation, competence, environmental protection, stop-work authority, continual improvement, signature and review date.'),
      _HseDocument('HSE Organization Chart & Contact Directory', 'Reporting lines, names, designations, deputies, shift contacts, HSE team, first aiders, fire wardens, emergency coordinator, client and consultant contacts.'),
      _HseDocument('HSE Roles & Responsibility Matrix', 'Activity, accountable/responsible/consulted/informed roles, competency, evidence, escalation and authorization for management, HSE, supervisors, permit roles, operators and subcontractors.'),
    ]),
    _DocumentGroup('Risk & Work Control', <_HseDocument>[
      _HseDocument('HIRA / Risk Assessment', 'Activity, work steps, hazards, exposed persons, existing controls, initial likelihood/severity/risk, hierarchy-based additional controls, residual risk, action owner, due date and review triggers.'),
      _HseDocument('Job Safety Analysis (JSA)', 'Task, location, shift, crew, tools, permits, task sequence, hazards and controls per step, PPE, environmental aspects, emergency response, worker briefing and approvals.'),
      _HseDocument('Method Statement Review & Approval', 'Scope, work sequence, resources, plant, competence, risk references, permits, interfaces, inspection hold points, emergency plan, review comments, responses and approval status.'),
      _HseDocument('Permit to Work Request & Register', 'Permit type, task/location, validity, issuer/receiver, isolations, gas test values/time/tester, precautions, certificates, SIMOPS, suspension, revalidation, handback and closure.'),
      _HseDocument('Toolbox Talk / Safety Briefing Record', 'Topic, date/time, presenter, language, hazards, controls, questions, attendance names/IDs/signatures, understanding check, actions, owner and due date.'),
    ]),
    _DocumentGroup('Inspection & Compliance', <_HseDocument>[
      _HseDocument('Daily HSE Site Inspection', 'Area, date, inspector, housekeeping, access, PPE, work at height, scaffolds, lifting, electrical, excavation, fire, welfare, environment, findings, priority, owner, due date and closeout.'),
      _HseDocument('Weekly HSE Inspection', 'Inspection team, area, checklist category, observation, compliance, risk, corrective action, responsible person, target date, verification, trend and sign-off.'),
      _HseDocument('Monthly HSE Audit & Compliance Report', 'Scope, criteria, auditors, evidence, conformities, nonconformities, observations, root cause, action owners, deadlines, closure verification and management approval.'),
      _HseDocument('Plant, Tools & Equipment Inspection', 'Asset ID, type, make/model, serial, location, inspector, guards, emergency stop, cables/hoses, leaks, certificates, defects, fit/quarantine status and next due date.'),
      _HseDocument('Corrective & Preventive Action Register', 'Finding ID/source, containment, risk, root cause, corrective/preventive action, owner, priority, due date, evidence, effectiveness check, closure approver and escalation.'),
    ]),
    _DocumentGroup('Employee & Training', <_HseDocument>[
      _HseDocument('Employee HSE Induction Record', 'Employee ID, employer, role, supervisor, joining date, language, site rules, alarms/muster, PPE, PTW, stop-work, heat stress, incident reporting, assessment and acknowledgement.'),
      _HseDocument('HSE Training & Attendance Register', 'Course, objective, trainer/provider, qualification, date/duration, attendees, employer/role, language, assessment, result, certificate/expiry, refresher due and signatures.'),
      _HseDocument('Competency & Authorization Register', 'Role/task, required competency, employee, evidence/certificate, issuer, issue/expiry, practical assessment, authorization scope, restrictions, assessor, revalidation and status.'),
      _HseDocument('PPE Issue & Replacement Record', 'Employee, employer, job, PPE type/specification/size/quantity, issue date, condition, fit check, replacement reason/date, receipt signature, storekeeper and disposal.'),
      _HseDocument('Occupational Fitness / Medical Clearance Register', 'Restricted record: employee ID, role/exposure, fitness status only, validity/review date, provider, authorized restrictions, access control and retention. Do not record diagnoses in the general HSE register.'),
    ]),
    _DocumentGroup('Incident & Emergency', <_HseDocument>[
      _HseDocument('Incident, Injury & Property Damage Report', 'ID, date/time, location, event type, persons, injury/damage, task, response, notifications, witnesses, evidence, initial classification, investigation lead, actions and approvals.'),
      _HseDocument('Near Miss / Unsafe Condition Report', 'ID, date/time, location, reporter, task, event/condition, potential consequence, immediate action, risk priority, owner, due date, learning shared and closure.'),
      _HseDocument('Incident Investigation & Root Cause Analysis', 'Team, timeline, evidence, interviews, direct/system causes, barrier analysis, method, corrective/preventive actions, owner, due date, effectiveness, lessons and approval.'),
      _HseDocument('Emergency Drill Evaluation', 'Scenario, date/time, objectives, participants, observers, alarm, response time, headcount, communications, equipment, strengths/gaps, actions, owner, re-drill and approval.'),
      _HseDocument('First Aid & Medical Treatment Record', 'Restricted case ID, date/time, site, employee ID, event, first aid, first aider, referral, notifications, authorized work restrictions, custodian, confidentiality and retention.'),
    ]),
    _DocumentGroup('Environmental', <_HseDocument>[
      _HseDocument('Waste Management Register', 'Waste stream/classification, source, quantity/unit, container/label, storage, removal date, transporter, authorized facility/receipt, transfer note, responsible person and closeout.'),
      _HseDocument('Waste Transfer / Disposal Note', 'Consignor, project, waste type/classification, quantity, packaging, carrier/vehicle, licence reference, destination, date/time, signatures, weighbridge/receipt and exceptions.'),
      _HseDocument('Environmental Inspection & Compliance Checklist', 'Area/date/inspector, segregation, spill kits, bunding, drains, dust/noise, emissions, discharge, chemical storage, permits, findings, controls, owner, due date and verification.'),
      _HseDocument('Spill / Environmental Release Report', 'Substance, quantity estimate, time/location, pathway, receptors, notifications, source isolation, containment, PPE, cleanup, waste disposal, sampling, cause, remediation and closeout.'),
      _HseDocument('Environmental Monitoring Record', 'Parameter, location, date/time, instrument/calibration, method, weather, result/unit, permit-limit reference, exceedance response, laboratory, reviewer, trend and action.'),
    ]),
    _DocumentGroup('Contractor & Equipment', <_HseDocument>[
      _HseDocument('Contractor HSE Prequalification & Evaluation', 'Contractor/scope, workforce, dated HSE statistics, system, competent staff, training, plans, equipment, incident declarations, evaluation, gaps, conditions, approval and reassessment.'),
      _HseDocument('Equipment & Asset Register', 'Asset ID, description, owner, make/model, serial, capacity, location, criticality, inspection/certification, maintenance due, operator authorization, defect/status and custodian.'),
      _HseDocument('Third-Party Certification Register', 'Asset/accessory ID, certificate, inspection body, competence/accreditation, scope, issue/expiry, next examination, restrictions, file reference, alert owner and quarantine status.'),
      _HseDocument('Lifting Gear Register', 'Gear type, ID, WLL/SWL, serial, project colour code if applicable, certificate, inspection/next due, condition, storage, quarantine, inspector and lifting-plan reference.'),
      _HseDocument('Vehicle & Mobile Plant Daily Inspection', 'ID, operator authorization, date/shift, tyres, brakes, lights, alarm, seatbelt, mirrors/camera, leaks, extinguisher, documents, defects, out-of-service decision and release.'),
    ]),
    _DocumentGroup('Reporting & Document Control', <_HseDocument>[
      _HseDocument('Daily HSE Report', 'Project/date/shift, workforce, hours, activities, permits, talks, inspections, observations, incidents, environment, training, stop-work, actions, photos and review.'),
      _HseDocument('Monthly HSE Performance Report', 'Period, workforce/hours, incident categories/definitions, leading indicators, training, audits, overdue actions, environmental metrics, trends, lessons, targets and approvals.'),
      _HseDocument('HSE Statistics & KPI Dashboard Register', 'KPI definition, numerator/denominator, period, source, owner, target/actual/trend, validation, exclusions, trigger, action and reviewer.'),
      _HseDocument('HSE Document Register & Revision Log', 'ID/title, discipline, owner, revision/status, issue date, reviewer/approver, distribution, superseded version, review due, change summary, controlled location and retention.'),
      _HseDocument('HSE Management Review Minutes', 'Date, chair/attendees, previous actions, policy/objectives, audit/incident trends, legal/client changes, resources, competence, risk/barriers, worker feedback, decisions, owners and approval.'),
    ]),
  ];

  int get _total => _groups.fold<int>(0, (sum, group) => sum + group.documents.length);

  @override
  Widget build(BuildContext context) {
    final progress = _total == 0 ? 0.0 : _completed.length / _total;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Office Documents & Checklist'),
        backgroundColor: Colors.green.shade800,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Colors.green.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('SafeNexus HSE • Specialist / Cross-Sector',
                    style: TextStyle(color: Colors.green.shade900, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('${_completed.length} / $_total documents completed',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                LinearProgressIndicator(value: progress, minHeight: 8,
                    color: Colors.green.shade700, backgroundColor: Colors.green.shade100),
                const SizedBox(height: 12),
                const Text('Project header fields for use in every form:'),
                const Text('Company • Client • Consultant • Main Contractor • Project • Location • Employee Name/ID/Designation • Document No. • Revision • Date • Prepared / Reviewed / Approved By'),
              ]),
            ),
          ),
          const SizedBox(height: 8),
          for (final group in _groups)
            Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ExpansionTile(
                initiallyExpanded: false,
                title: Text(group.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${group.documents.length} documents'),
                children: [
                  for (final doc in group.documents)
                    _DocumentTile(
                      document: doc,
                      checked: _completed.contains(doc.id),
                      onChanged: (value) => setState(() {
                        if (value) {
                          _completed.add(doc.id);
                        } else {
                          _completed.remove(doc.id);
                        }
                      }),
                    ),
                ],
              ),
            ),
          const SizedBox(height: 12),
          const Text('Final readiness checks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Text('☐ Current UAE/emirate/client requirements verified\n☐ Document numbers and revisions controlled\n☐ Authorized reviews and approvals recorded\n☐ Competent persons assigned for technical checks\n☐ Actions have owners, due dates and closure evidence\n☐ Confidential employee/medical records access-restricted\n☐ Superseded copies withdrawn from points of use'),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {
              final lines = <String>['SAFENEXUS HSE — 40 DOCUMENT CHECKLIST'];
              var n = 0;
              for (final group in _groups) {
                lines.add('\n${group.title}');
                for (final doc in group.documents) {
                  n++;
                  lines.add('${_completed.contains(n) ? '[x]' : '[ ]'} $n. ${doc.title}');
                }
              }
              // Use platform share/copy integration in the host app if required.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Checklist is shown on screen. Add clipboard/export integration to save it.')),
              );
            },
            icon: const Icon(Icons.checklist),
            label: const Text('Checklist ready for review'),
          ),
          const SizedBox(height: 24),
          const Text(
            'Note: This is a generic template framework, not a statement that every form is mandatory in every UAE emirate or sector. Verify current authority, client and contract requirements before controlled issue.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _DocumentTile extends StatelessWidget {
  const _DocumentTile({
    required this.document,
    required this.checked,
    required this.onChanged,
  });

  final _HseDocument document;
  final bool checked;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: checked,
      onChanged: (value) => onChanged(value ?? false),
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(document.title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(document.details),
      ),
      secondary: IconButton(
        tooltip: 'Document details',
        icon: const Icon(Icons.description_outlined),
        onPressed: () => showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(document.title),
            content: SingleChildScrollView(
              child: Text(
                'COMMON HEADER\nCompany Name\nClient Name\nConsultant Name\nMain Contractor / Subcontractor\nProject Name / Location\nEmployee Name / ID / Designation (where applicable)\nDocument Number / Revision / Date\nPrepared By / Reviewed By / Approved By\n\nDOCUMENT CONTENT\n${document.details}\n\nRECORD CONTROL\nAttachments / Evidence\nAction Owner / Due Date\nVerification / Closure\nSignature / Date',
              ),
            ),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
          ),
        ),
      ),
    );
  }
}

class _DocumentGroup {
  const _DocumentGroup(this.title, this.documents);
  final String title;
  final List<_HseDocument> documents;
}

class _HseDocument {
  const _HseDocument(this.title, this.details);
  final String title;
  final String details;
  int get id => _stableId(title);
}

int _stableId(String value) {
  // Stable deterministic ID within this fixed master list.
  var hash = 0;
  for (final code in value.codeUnits) {
    hash = (hash * 31 + code) & 0x7fffffff;
  }
  return hash;
}
