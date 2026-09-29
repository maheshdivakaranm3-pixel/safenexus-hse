import 'package:flutter/material.dart';

/// Environmental office-document library. Applicability, authority, approval,
/// validity and retention must be confirmed against the live project requirements.
class EnvironmentalOfficeDocumentsPage extends StatelessWidget {
  const EnvironmentalOfficeDocumentsPage({super.key});
  static const Color green = Color(0xFF0B5D4B);

  static const List<_DocumentGroup> groups = [
    _DocumentGroup('Governance & document control', [
      'Environmental Policy and commitments',
      'Environmental Management Plan (EMP)',
      'Environmental aspects and impacts register',
      'Environmental legal / permit / NOC register',
      'Environmental objectives, targets and action plan',
      'Document master register, revision history and distribution list',
      'Management review minutes and action tracker',
    ]),
    _DocumentGroup('Permits, approvals & submissions', [
      'Environmental permit / approval and conditions register',
      'EIA / screening / authority submission and approval evidence',
      'NOC, utility and municipal approvals where applicable',
      'Permit-condition compliance matrix and due-date tracker',
      'Authority correspondence, notifications and approvals',
    ]),
    _DocumentGroup('Waste management', [
      'Waste management plan and waste stream inventory',
      'Waste classification / characterization evidence where needed',
      'Waste storage inspection and inventory log',
      'Carrier / contractor authorization and due diligence',
      'Waste transfer notes, manifests, weighbridge tickets',
      'Receiving facility acceptance, recycling or disposal certificates',
      'Monthly waste reconciliation and reporting',
    ]),
    _DocumentGroup('Pollution prevention & monitoring', [
      'Aspect-specific pollution prevention method statements',
      'Air / noise / vibration / water / soil monitoring plan as applicable',
      'Sampling plan, chain-of-custody and laboratory reports',
      'Instrument suitability, calibration and maintenance records',
      'Inspection, monitoring results, exceedance and response records',
      'Drain, bund, spill kit and pollution-control equipment checks',
    ]),
    _DocumentGroup('Training & competency', [
      'Environmental induction and toolbox talk materials',
      'Attendance and understanding / competency records',
      'Role-specific specialist competency evidence',
      'Contractor environmental briefing and acknowledgement',
    ]),
    _DocumentGroup('Emergency, incident & corrective action', [
      'Environmental emergency response plan and contact list',
      'Spill / release / complaint / incident reports',
      'Authority / client notification evidence where required',
      'Investigation, root-cause and corrective-action register',
      'Drill plan, attendance, evaluation and improvement actions',
    ]),
    _DocumentGroup('Inspection, audit & reporting', [
      'Daily / weekly / monthly inspection records as project-defined',
      'Internal and external audit plans, reports and findings',
      'Legal compliance evaluation and evidence matrix',
      'KPI definitions, validated data and periodic reports',
      'Corrective-action closure and effectiveness verification',
    ]),
    _DocumentGroup('Close-out & retention', [
      'Environmental handover / close-out dossier index',
      'Open obligations, permits and action handover',
      'Restoration / remediation verification and sign-off where applicable',
      'Records retention and archive index',
    ]),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF4F8F6),
    appBar: AppBar(title: const Text('Environmental Office Documents'), backgroundColor: green, foregroundColor: Colors.white),
    body: ListView(padding: const EdgeInsets.all(14), children: [
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFFE5F3EC), borderRadius: BorderRadius.circular(15)), child: const Text(
        'Document-by-document field guide. Each record explains its purpose, ownership, preparation and review, evidence, verification and control of revisions. Confirm legal, permit, client and contract applicability for the actual project; this library does not assign universal validity or retention periods.',
        style: TextStyle(color: Color(0xFF174D3D), height: 1.45))),
      const SizedBox(height: 12),
      ...groups.map((group) => Card(elevation: 0, margin: const EdgeInsets.only(bottom: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: const BorderSide(color: Color(0xFFE0EAE5))), child: ExpansionTile(
        iconColor: green, collapsedIconColor: green,
        title: Text(group.title, style: const TextStyle(color: green, fontWeight: FontWeight.w800)),
        children: group.items.map((name) => ListTile(
          leading: const Icon(Icons.description_outlined, color: green), title: Text(name),
          subtitle: const Text('Open the dedicated document guide'),
          trailing: const Icon(Icons.chevron_right, color: green),
          onTap: () => Navigator.push(context, MaterialPageRoute<void>(builder: (_) => _DocumentDetailPage(name: name, group: group.title))),
        )).toList(),
      ))),
    ]),
  );
}

class _DocumentGroup { const _DocumentGroup(this.title, this.items); final String title; final List<String> items; }

class _DocumentDetailPage extends StatelessWidget {
  const _DocumentDetailPage({required this.name, required this.group});
  final String name; final String group;
  static const Color green = EnvironmentalOfficeDocumentsPage.green;

  String get _purpose {
    final s = name.toLowerCase();
    if (s.contains('policy')) return 'States the organization\'s environmental commitments, leadership expectations and principles for preventing pollution, meeting applicable obligations and improving performance.';
    if (s.contains('management plan') || s.contains('(emp)')) return 'Translates project commitments and assessed environmental risks into assigned controls, resources, monitoring, reporting and emergency arrangements for work execution.';
    if (s.contains('aspect') || s.contains('impact')) return 'Identifies activities and environmental interactions, evaluates potential consequences and records which aspects require operational controls or further evaluation.';
    if (s.contains('legal') || s.contains('permit') || s.contains('approval') || s.contains('noc') || s.contains('authority')) return 'Provides traceability from each applicable obligation or approval condition to its owner, required action, evidence, deadline and compliance status.';
    if (s.contains('waste') || s.contains('transfer') || s.contains('manifest') || s.contains('disposal') || s.contains('recycl')) return 'Maintains control and traceability of waste from generation and classification through segregation, temporary storage, authorized transport, receiving and final treatment or disposal.';
    if (s.contains('monitor') || s.contains('sampling') || s.contains('laboratory') || s.contains('calibration') || s.contains('instrument')) return 'Defines or preserves reliable environmental measurement evidence so results can be traced to the location, time, method, equipment, competent person and applicable acceptance criteria.';
    if (s.contains('training') || s.contains('competency') || s.contains('briefing') || s.contains('attendance')) return 'Demonstrates that affected personnel received task-relevant information and, where required, have the competence and authorization to perform assigned environmental duties.';
    if (s.contains('emergency') || s.contains('spill') || s.contains('incident') || s.contains('complaint') || s.contains('drill')) return 'Establishes preparedness or records an event, response, notification, investigation and corrective actions to prevent recurrence and limit environmental harm.';
    if (s.contains('audit') || s.contains('inspection') || s.contains('review') || s.contains('kpi') || s.contains('report')) return 'Provides planned assurance or performance evidence, identifies gaps against defined criteria and tracks actions through verified closure.';
    if (s.contains('close-out') || s.contains('handover') || s.contains('retention') || s.contains('archive') || s.contains('restoration')) return 'Ensures outstanding environmental commitments, evidence, restoration status and controlled records are handed over or archived in a traceable manner.';
    return 'Defines, records or verifies an environmental control or management decision for the project, with evidence that can be reviewed and traced.';
  }
  String get _preparer {
    final s = name.toLowerCase();
    if (s.contains('permit') || s.contains('legal') || s.contains('authority') || s.contains('noc')) return 'Normally coordinated by the Environmental Manager / HSE team with the project manager, document controller and relevant technical or permitting specialists. The legally designated applicant remains responsible where specified.';
    if (s.contains('waste') || s.contains('manifest') || s.contains('transfer')) return 'Prepared by the designated waste/environmental coordinator using verified site quantities, waste description, carrier and receiving-facility details; transport or facility records are completed by the responsible parties.';
    if (s.contains('monitor') || s.contains('sampling') || s.contains('laboratory') || s.contains('calibration')) return 'Prepared by the competent monitoring lead, approved contractor or laboratory, with site personnel supplying activity and location information.';
    if (s.contains('incident') || s.contains('spill') || s.contains('complaint')) return 'Initial facts are recorded by the discoverer or supervisor; the assigned incident investigator coordinates evidence and the Environmental Manager validates environmental aspects.';
    return 'Drafted by the assigned environmental/HSE owner with input from the work package owner, relevant engineering/operations staff and document control.';
  }
  String get _reviewer {
    final s = name.toLowerCase();
    if (s.contains('policy') || s.contains('management review') || s.contains('objectives')) return 'Reviewed by the Environmental Manager and relevant department heads; approved by the authorized senior management representative under the company approval matrix.';
    if (s.contains('permit') || s.contains('approval') || s.contains('noc') || s.contains('authority')) return 'Technical and compliance review by the Environmental Manager / permitting lead and project manager. Submit only through the authorized applicant and authority process; retain formal approval evidence.';
    if (s.contains('waste') || s.contains('transfer') || s.contains('disposal')) return 'Reviewed by the Environmental Manager or nominated waste owner; verify carrier and receiving facility details with current project/authority requirements before dispatch.';
    if (s.contains('incident') || s.contains('spill') || s.contains('corrective')) return 'Reviewed by the investigation lead and Environmental Manager; action closure is verified by a person independent of the action implementer where practicable.';
    return 'Reviewed by the responsible Environmental Manager/HSE lead and affected discipline or project manager; final approval follows the project document-control and authority matrix.';
  }
  String get _timing {
    final s = name.toLowerCase();
    if (s.contains('incident') || s.contains('spill') || s.contains('complaint')) return 'Open immediately after discovery, preserve facts and evidence, and complete reporting within the applicable authority, permit, client and company deadlines. Update after investigation and action closure.';
    if (s.contains('permit') || s.contains('approval') || s.contains('noc') || s.contains('eia')) return 'Initiate during planning and before the regulated activity or submission milestone. Update before scope, method, site condition or approval-condition changes and before expiry or renewal deadlines.';
    if (s.contains('waste') || s.contains('transfer') || s.contains('manifest')) return 'Use before and at each applicable waste movement; reconcile quantities and receiving evidence at the project-defined reporting interval.';
    if (s.contains('inspection') || s.contains('monitor')) return 'Follow the approved risk-based monitoring or inspection schedule, permit conditions and activity triggers; repeat after abnormal results, complaints, incidents or material changes.';
    return 'Prepare before the activity or management cycle it controls. Review at the approved interval and whenever scope, risk, law, permit condition, organization or site conditions change.';
  }
  String get _attachments {
    final s = name.toLowerCase();
    if (s.contains('waste') || s.contains('manifest') || s.contains('disposal') || s.contains('recycl')) return 'Attach waste stream descriptions/classification basis, photographs, inventory/quantity records, carrier and facility authorization evidence, transfer note/manifest, weighbridge ticket and receiving/treatment certificate as applicable.';
    if (s.contains('monitor') || s.contains('sampling') || s.contains('laboratory') || s.contains('calibration')) return 'Attach approved sampling locations and methods, field sheets, instrument identification and calibration evidence, chain-of-custody, laboratory accreditation/scope evidence where required, raw results and interpretation.';
    if (s.contains('permit') || s.contains('approval') || s.contains('noc') || s.contains('authority') || s.contains('eia')) return 'Attach application/submission, drawings and site plans, supporting assessments, correspondence, formal approval, conditions, expiry/review dates and evidence of condition discharge.';
    if (s.contains('incident') || s.contains('spill') || s.contains('drill')) return 'Attach chronology, location/photos, witness statements, quantities or affected receptors where known, notifications, response actions, investigation, drill attendance/evaluation and corrective-action evidence.';
    return 'Attach relevant approved plans, risk/aspect assessments, supporting calculations or data, consultation records, inspection photographs, approvals, action evidence and controlled revision history as relevant.';
  }
  String get _verification {
    final s = name.toLowerCase();
    if (s.contains('waste') || s.contains('manifest') || s.contains('disposal')) return 'Trace a sample record from the work area to the waste store, dispatch record, carrier and receiving-facility confirmation. Reconcile description, date, quantity and destination; investigate mismatches.';
    if (s.contains('monitor') || s.contains('sampling') || s.contains('laboratory')) return 'Check the actual monitoring location and activity, sampler competence, method, instrument status, chain-of-custody and whether results were compared with the correct approved criterion.';
    if (s.contains('training') || s.contains('competency') || s.contains('briefing')) return 'Interview a sample of workers and compare attendance with roster, language/accessibility, understanding and observed task practice; do not treat a signature alone as proof of competence.';
    if (s.contains('permit') || s.contains('approval') || s.contains('legal') || s.contains('noc')) return 'Cross-check the current official approval/condition against the activity, location, dates and field controls. Verify condition owners and objective evidence; escalate any uncertainty before work.';
    return 'Sample the document against current site conditions, interview the owner and affected workers, inspect supporting evidence and verify that recorded actions are actually implemented.';
  }
  String get _example {
    final s = name.toLowerCase();
    if (s.contains('waste') || s.contains('manifest') || s.contains('disposal')) return 'Example: before a scheduled waste collection, the coordinator checks the approved waste description, container labels, authorized route/provider and receiving destination; after collection, the signed transfer and facility receipt are reconciled to the site inventory.';
    if (s.contains('spill') || s.contains('incident')) return 'Example: after a hydraulic-oil release, the supervisor records time, source, drain proximity, containment and cleanup; the Environmental Manager checks notification triggers, investigates cause and verifies preventive actions in the work area.';
    if (s.contains('monitor') || s.contains('sampling')) return 'Example: a dust-monitoring record links the instrument and calibration status to a mapped receptor, work activity, date/time, weather, result, applicable criterion and documented response if a trigger is reached.';
    if (s.contains('permit') || s.contains('approval') || s.contains('noc')) return 'Example: before mobilization, the permit owner maps each condition to a responsible person, evidence and due date; the supervisor confirms the relevant condition is met before the associated task starts.';
    return 'Example: during a project review, the Environmental Manager selects a live work activity, checks this document against field conditions, records any gap with an owner and due date, then verifies implementation before closure.';
  }
  List<_GuideSection> get sections => [
    _GuideSection('What this document is', '$name is a controlled project record within the $group workstream. It provides an auditable source of information and decisions; it is not automatically an authority permit unless formally issued as one.'),
    _GuideSection('Purpose and why it matters', _purpose),
    _GuideSection('Applicability classification', 'Determine whether this is legally required, imposed by an environmental permit/NOC, required by client/contract/project procedure, or a recommended management record. Record the exact source, clause/condition and project applicability. Do not assume every project needs every record.'),
    _GuideSection('Minimum content to include', 'Use a unique title/ID, project and location, responsible owner, issue/revision/date, scope and activity, relevant environmental aspect or obligation, clear requirements/actions, evidence references, status, approvals and controlled attachments. Add document-specific technical data described below.'),
    _GuideSection('Preparer and information sources', _preparer),
    _GuideSection('Review and approval', _reviewer),
    _GuideSection('When to prepare and update', _timing),
    _GuideSection('Validity and review control', 'There is no universal validity period for this document type. Record the expiry/review date only where set by an authority, permit, contract or approved company procedure. Review sooner after a legal/permit change, incident, nonconformance, design or method change, new receptor, monitoring trigger or organizational change.'),
    _GuideSection('Attachments and evidence', _attachments),
    _GuideSection('Site verification', _verification),
    _GuideSection('Storage, access and retention', 'Store the approved current revision at the point of use and the controlled master in the project document system. Restrict personal or commercially sensitive data appropriately. Retention duration must follow applicable law, permit, contract and approved records schedule; record the actual source and archive/disposal authorization.'),
    _GuideSection('Common errors and corrective action', 'Typical failures include copied project data, obsolete revisions, missing signatures/attachments, unclear ownership, unsupported quantities, missed due dates, unverified contractor credentials, and closing actions from paperwork alone. Correct the source record, assess impact, notify affected users, preserve revision history and verify field effectiveness.'),
    _GuideSection('Practical field example', _example),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF4F8F6),
    appBar: AppBar(title: const Text('Document Guide'), backgroundColor: green, foregroundColor: Colors.white),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      Text(name, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w900, color: green)),
      const SizedBox(height: 5), Text(group, style: const TextStyle(color: Colors.black54)),
      const SizedBox(height: 12),
      ...sections.map((s) => Card(elevation: 0, margin: const EdgeInsets.only(bottom: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFFE0EAE5))), child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(s.title, style: const TextStyle(color: green, fontWeight: FontWeight.w800, fontSize: 15)), const SizedBox(height: 7), Text(s.body, style: const TextStyle(height: 1.48))])))),
      const SizedBox(height: 8),
      const Text('Regulatory caution: verify current UAE federal, emirate, authority, permit and contractual requirements from the official source applicable to this project. This guide intentionally does not invent numerical limits, approval names, expiry periods or retention durations.', style: TextStyle(color: Colors.black54, fontSize: 12, height: 1.45)),
    ]),
  );
}
class _GuideSection { const _GuideSection(this.title, this.body); final String title; final String body; }
