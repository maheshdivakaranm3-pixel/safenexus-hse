import 'package:flutter/material.dart';
import 'models/reference_topic.dart';

/// SafeNexus HSE — Dubai HSE professional topic-by-topic learning and field reference.
/// Replace ONLY this file. Keep lib/data/dubai_guidelines.dart unchanged.
class DubaiHseDetailPage extends StatelessWidget {
  final ReferenceTopic topic;
  const DubaiHseDetailPage({super.key, required this.topic});
  static const Color primary = Color(0xFF0B6B4F);
  static const Color background = Color(0xFFF5F8F7);

  @override
  Widget build(BuildContext context) {
    final data = _topicData[topic.id];
    if (data == null) return _fallback(context);
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(title: Text(data.title, maxLines: 2, overflow: TextOverflow.ellipsis), backgroundColor: primary, foregroundColor: Colors.white),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        _intro(data),
        _section(context, '🏗️ Types / Systems', data.types, Icons.category_outlined),
        _section(context, '🔧 Components / Key Items', data.items, Icons.build_outlined),
        for (final entry in data.sections.entries) _section(context, entry.key, entry.value, Icons.menu_book_outlined),
      ]),
    );
  }

  Widget _intro(_TopicData data) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('📖 Introduction — What is it?', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)), const SizedBox(height: 10), Text(data.intro, style: const TextStyle(fontSize: 15, height: 1.6))])));

  Widget _section(BuildContext context, String title, List<_DetailItem> values, IconData icon) => Card(margin: const EdgeInsets.only(bottom: 10), child: ExpansionTile(leading: Icon(icon, color: primary), title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)), children: [for (int i=0;i<values.length;i++) ListTile(leading: CircleAvatar(radius: 15, backgroundColor: primary, child: Text('${i+1}', style: const TextStyle(color: Colors.white, fontSize: 12))), title: Text(values[i].title, style: const TextStyle(fontWeight: FontWeight.w600)), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => DubaiHseItemDetailPage(sectionTitle: title, item: values[i].title, detail: values[i].detail))))]));

  Widget _fallback(BuildContext context) => Scaffold(appBar: AppBar(title: Text(topic.title), backgroundColor: primary, foregroundColor: Colors.white), body: Padding(padding: const EdgeInsets.all(16), child: Text(topic.description.isNotEmpty ? topic.description : 'Dubai HSE learning reference.', style: const TextStyle(fontSize: 16, height: 1.5))));
}

class DubaiHseItemDetailPage extends StatelessWidget {
  final String sectionTitle; final String item; final String detail;
  const DubaiHseItemDetailPage({super.key, required this.sectionTitle, required this.item, required this.detail});
  static const Color primary = Color(0xFF0B6B4F);
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(item, maxLines: 2, overflow: TextOverflow.ellipsis), backgroundColor: primary, foregroundColor: Colors.white), body: ListView(padding: const EdgeInsets.all(16), children: [Text(sectionTitle, style: const TextStyle(color: primary, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(item, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)), const SizedBox(height: 16), Card(child: Padding(padding: const EdgeInsets.all(16), child: Text(detail, style: const TextStyle(fontSize: 15, height: 1.65)))), const SizedBox(height: 12), Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(14), child: Text('Use this item only within the approved task method, competent-person requirements, equipment instructions and site controls.', style: const TextStyle(height: 1.5))))]));
}

class _DetailItem { final String title; final String detail; const _DetailItem({required this.title, required this.detail}); }
class _TopicData { final String title; final String intro; final List<_DetailItem> types; final List<_DetailItem> items; final Map<String,List<_DetailItem>> sections; const _TopicData({required this.title,required this.intro,required this.types,required this.items,required this.sections}); }

const Map<String, _TopicData> _topicData = {
  'dubai_construction_safety': _TopicData(
    title: 'Dubai Construction Safety Framework',
    intro: 'A Dubai construction HSE framework for planning, organising, supervising and controlling construction activities so that workers, the public, property and the environment are protected throughout the project lifecycle.',
    types: [
      _DetailItem(title: 'Main Contractor HSE System', detail: 'The project-wide system used to define responsibilities, procedures, risk controls, inspections, reporting and improvement.'),
      _DetailItem(title: 'Project HSE Plan', detail: 'The project document that converts applicable requirements into site-specific arrangements, responsibilities and control programmes.'),
      _DetailItem(title: 'High-Risk Activity Control', detail: 'Enhanced planning and supervision for activities such as lifting, excavation, work at height, confined space and hot work.'),
      _DetailItem(title: 'Interface / SIMOPS Control', detail: 'Coordination of simultaneous or overlapping activities so that one work front does not create uncontrolled risk for another.'),
    ],
    items: [
      _DetailItem(title: 'HSE Plan', detail: 'Defines project HSE arrangements, resources, responsibilities, emergency arrangements and monitoring requirements.'),
      _DetailItem(title: 'Risk Assessment', detail: 'Identifies hazards, exposed people, existing controls, additional controls and residual risk before work.'),
      _DetailItem(title: 'Method Statement', detail: 'Describes the safe work sequence, equipment, manpower, hold points, supervision and emergency arrangements.'),
      _DetailItem(title: 'Permit', detail: 'Controls activities that require formal authorisation, isolation or special precautions.'),
      _DetailItem(title: 'Competent Person', detail: 'A person with suitable knowledge, training, experience and authority for the assigned safety-critical task.'),
      _DetailItem(title: 'Inspection Record', detail: 'Evidence that critical conditions and controls have been checked and actions tracked.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Establish consistent construction safety arrangements from mobilisation through construction, testing, handover and demobilisation.'),
        _DetailItem(title: 'Scope', detail: 'Apply controls to employees, contractors, subcontractors, visitors, plant, temporary works and public interfaces.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Define work packages, responsibilities, risk controls, permits, temporary works and emergency arrangements before execution.'),
        _DetailItem(title: 'Control hierarchy', detail: 'Prefer elimination, substitution and engineering controls before administrative controls and PPE.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate access, lifting, traffic, public protection and simultaneous operations at shared work fronts.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Uncontrolled work', detail: 'Work starting without approved planning, risk assessment, method statement or required permit.'),
        _DetailItem(title: 'Interface hazards', detail: 'Conflicting work fronts, plant movement, overhead work, public exposure and simultaneous operations.'),
        _DetailItem(title: 'Control failure', detail: 'Critical barriers missing, bypassed, damaged or not verified at the workface.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Pre-start', detail: 'Verify approved documents, competent people, equipment condition, access, exclusion zones and emergency arrangements.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision proportionate to the risk and intervene when site conditions differ from the plan.'),
        _DetailItem(title: 'Corrective action', detail: 'Record defects, assign owners, set due dates and verify effectiveness before closure.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Daily field checks', detail: 'Inspect critical work fronts, access, housekeeping, plant, temporary works and high-risk controls.'),
        _DetailItem(title: 'Formal inspections', detail: 'Use planned HSE inspections and targeted inspections for safety-critical systems.'),
        _DetailItem(title: 'Verification', detail: 'Check that documented controls are actually present and effective in the field.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Uncontrolled high-risk activity', detail: 'Stop when a significant hazard is present without effective controls.'),
        _DetailItem(title: 'Critical barrier failure', detail: 'Suspend the affected work when required protection, isolation, stability or supervision is absent.'),
        _DetailItem(title: 'Changed conditions', detail: 'Stop and reassess when site conditions, sequence, equipment or interfaces materially change.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide leadership, resources, competent personnel and authority to stop unsafe work.'),
        _DetailItem(title: 'HSE team', detail: 'Coordinate monitoring, advise management, verify controls and track corrective actions.'),
        _DetailItem(title: 'Supervisors', detail: 'Implement the approved method at the workface and stop work when controls fail.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the system', detail: 'Work only within approved procedures, permits and site controls.'),
        _DetailItem(title: 'Report hazards', detail: 'Report unsafe conditions, defects, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain exclusion zones, housekeeping and safe behaviour around shared work areas.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop work, raise the alarm, isolate hazards where safe and protect the area.'),
        _DetailItem(title: 'Rescue', detail: 'Use the project emergency and rescue plan; do not create secondary casualties.'),
        _DetailItem(title: 'Recovery', detail: 'Preserve relevant evidence, report the event and review controls before restart.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'SIMOPS conflict', detail: 'A crane lift is planned above an active façade work area. The lift is stopped until the lower work area is isolated, the lifting zone is controlled and the sequence is coordinated.'),
        _DetailItem(title: 'HSE response', detail: 'Verify the revised sequence, brief affected teams, establish exclusion zones and restart only after field verification.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'Plan before exposure', detail: 'Good construction HSE prevents people from being exposed before controls are ready.'),
        _DetailItem(title: 'Verify in the field', detail: 'A signed document is not proof that a control exists at the workface.'),
        _DetailItem(title: 'Stop early', detail: 'Stopping a task for a control failure is safer than continuing and hoping conditions improve.'),
      ],
    },
  ),
  'dubai_hse_management': _TopicData(
    title: 'HSE Management System',
    intro: 'A structured management system for leadership, accountability, risk control, competence, communication, monitoring, incident learning and continual improvement on Dubai construction projects.',
    types: [
      _DetailItem(title: 'Leadership & Policy', detail: 'Management direction, objectives, resources and visible commitment to health and safety.'),
      _DetailItem(title: 'Risk Management System', detail: 'The process for identifying hazards, assessing risks, implementing controls and reviewing effectiveness.'),
      _DetailItem(title: 'Assurance Programme', detail: 'Planned inspections, audits, observations, performance reviews and corrective action.'),
      _DetailItem(title: 'Worker Engagement', detail: 'Mechanisms for consultation, toolbox talks, reporting, feedback and participation in safety improvement.'),
    ],
    items: [
      _DetailItem(title: 'HSE Policy', detail: 'Sets management commitment, principles and expectations.'),
      _DetailItem(title: 'Organisation Chart', detail: 'Shows HSE accountability, reporting lines and authority.'),
      _DetailItem(title: 'Training Matrix', detail: 'Tracks induction, mandatory and task-specific competence.'),
      _DetailItem(title: 'Audit Plan', detail: 'Defines system and field audits based on risk and project stage.'),
      _DetailItem(title: 'Inspection Register', detail: 'Tracks planned inspections, findings and actions.'),
      _DetailItem(title: 'Corrective Action Register', detail: 'Controls ownership, due dates, evidence and effectiveness verification.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Create a controlled management framework that turns HSE requirements into daily work practices.'),
        _DetailItem(title: 'Scope', detail: 'Cover project leadership, contractors, workers, activities, equipment, emergencies and improvement processes.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Accountability', detail: 'Define who plans, approves, supervises, inspects and closes safety actions.'),
        _DetailItem(title: 'Document control', detail: 'Keep current procedures, risk assessments, permits and emergency information available at point of use.'),
        _DetailItem(title: 'Management of change', detail: 'Review HSE impacts when scope, sequence, plant, people or site conditions change.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'System gaps', detail: 'Responsibilities unclear, outdated documents, weak supervision or incomplete competence.'),
        _DetailItem(title: 'Normalisation', detail: 'Repeated unsafe conditions becoming accepted as normal practice.'),
        _DetailItem(title: 'Weak learning', detail: 'Incidents and observations closed without identifying underlying causes.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Leadership', detail: 'Management conducts field engagement, reviews critical risks and provides resources.'),
        _DetailItem(title: 'Competence', detail: 'Assign trained and authorised personnel to safety-critical tasks.'),
        _DetailItem(title: 'Assurance', detail: 'Combine inspections, audits, observations, incident learning and management review.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Field verification', detail: 'Check whether procedures are implemented, not merely available.'),
        _DetailItem(title: 'Audit', detail: 'Sample evidence, interview personnel and observe work to test system effectiveness.'),
        _DetailItem(title: 'Action closure', detail: 'Verify that corrective actions removed or reduced the underlying risk.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical system failure', detail: 'Suspend affected work where a critical control cannot be maintained.'),
        _DetailItem(title: 'Competence gap', detail: 'Do not proceed with safety-critical work without suitable competent personnel.'),
        _DetailItem(title: 'Uncontrolled change', detail: 'Stop when the actual task differs materially from the approved safe system.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Set expectations, provide resources and hold accountable persons responsible for performance.'),
        _DetailItem(title: 'HSE', detail: 'Coordinate the system, monitor implementation and advise on risk.'),
        _DetailItem(title: 'Supervisors', detail: 'Translate system requirements into field controls.'),
        _DetailItem(title: 'Workers', detail: 'Follow controls and participate in hazard reporting and improvement.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Participation', detail: 'Attend required induction, toolbox talks and task briefings.'),
        _DetailItem(title: 'Feedback', detail: 'Raise practical concerns and report changes in the work environment.'),
        _DetailItem(title: 'Compliance', detail: 'Use equipment and procedures as trained and authorised.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Preparedness', detail: 'Maintain current emergency plans, contacts, routes, assembly areas and trained responders.'),
        _DetailItem(title: 'Response', detail: 'Protect life first, raise the alarm and control escalation within competence.'),
        _DetailItem(title: 'Learning', detail: 'Review emergency performance and improve arrangements after exercises or events.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Repeated access issue', detail: 'Several inspections find workers using an unsafe temporary access route. Instead of repeatedly closing observations, management identifies a planning and supervision gap, installs a compliant access system and updates the work-front standard.'),
        _DetailItem(title: 'Learning', detail: 'The management system should remove recurring causes rather than repeatedly treat symptoms.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'Leadership matters', detail: 'Visible leadership influences whether HSE requirements are actually followed.'),
        _DetailItem(title: 'Assurance matters', detail: 'Inspection, audit and field verification provide evidence of performance.'),
        _DetailItem(title: 'Improve continuously', detail: 'Use trends, incidents and worker feedback to strengthen controls.'),
      ],
    },
  ),
  'dubai_risk_assessment': _TopicData(
    title: 'Health & Safety Risk Assessment',
    intro: 'A systematic process for identifying hazards, evaluating risk, selecting effective controls and reviewing residual risk before and during work. Dubai Municipality lists Technical Guideline 137 for Health and Safety Risk Assessment among its HSE technical guidelines.',
    types: [
      _DetailItem(title: 'Task Risk Assessment', detail: 'Detailed assessment for a defined job or task.'),
      _DetailItem(title: 'Activity Risk Assessment', detail: 'Broader assessment covering a work activity with multiple tasks and interfaces.'),
      _DetailItem(title: 'Dynamic Risk Assessment', detail: 'Field reassessment when conditions, sequence or hazards change.'),
      _DetailItem(title: 'Change / Interface Assessment', detail: 'Assessment of new risks created by changes, simultaneous operations or interfaces.'),
    ],
    items: [
      _DetailItem(title: 'Hazard Register', detail: 'Structured list of hazards relevant to the work and environment.'),
      _DetailItem(title: 'Risk Matrix', detail: 'Method used by the project to consistently evaluate likelihood and consequence.'),
      _DetailItem(title: 'Control Measure', detail: 'A barrier selected to eliminate, reduce or isolate the hazard.'),
      _DetailItem(title: 'Residual Risk', detail: 'Risk remaining after controls are implemented.'),
      _DetailItem(title: 'Action Owner', detail: 'Named person accountable for implementing a control or action.'),
      _DetailItem(title: 'Review Trigger', detail: 'An event requiring the assessment to be reviewed or revised.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Prevent harm by identifying hazards before exposure occurs and keeping controls aligned with changing conditions.'),
        _DetailItem(title: 'Scope', detail: 'Cover routine, non-routine, maintenance, emergency, construction and interface activities.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Hazard identification', detail: 'Consider people, equipment, energy, materials, environment, work sequence and interfaces.'),
        _DetailItem(title: 'Hierarchy of controls', detail: 'Prefer elimination, substitution and engineering controls; use administrative controls and PPE as supporting layers.'),
        _DetailItem(title: 'Residual risk', detail: 'Do not treat the assessment as complete until controls are implemented and residual risk is accepted by the authorised process.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Incomplete scope', detail: 'Important tasks, interfaces or affected people omitted from the assessment.'),
        _DetailItem(title: 'Paper control', detail: 'Controls listed on paper but not available at the workface.'),
        _DetailItem(title: 'Change', detail: 'New plant, weather, access, sequence or simultaneous operations invalidating the assessment.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Worker involvement', detail: 'Use the knowledge of people who perform the task.'),
        _DetailItem(title: 'Critical controls', detail: 'Identify barriers that must be present before exposure begins.'),
        _DetailItem(title: 'Field verification', detail: 'Compare the assessment with actual conditions before and during the work.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-start review', detail: 'Confirm controls, responsible persons, equipment and permits are ready.'),
        _DetailItem(title: 'Dynamic review', detail: 'Reassess after significant changes, incidents, near misses or deteriorating conditions.'),
        _DetailItem(title: 'Close actions', detail: 'Verify control implementation and effectiveness.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'New significant hazard', detail: 'Stop when a significant hazard is identified without an effective control.'),
        _DetailItem(title: 'Control failure', detail: 'Stop where a critical control is missing, ineffective or bypassed.'),
        _DetailItem(title: 'Changed conditions', detail: 'Pause and reassess when the work no longer matches the assessed method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Assessor', detail: 'Identify hazards, evaluate risk and propose controls within competence.'),
        _DetailItem(title: 'Supervisor', detail: 'Verify controls at the workface before allowing exposure.'),
        _DetailItem(title: 'HSE', detail: 'Facilitate, challenge and monitor the quality of assessments.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Participate', detail: 'Provide practical task knowledge and raise hazards.'),
        _DetailItem(title: 'Follow controls', detail: 'Apply the agreed method and report deviations.'),
        _DetailItem(title: 'Reassess', detail: 'Alert supervision when conditions change.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate control', detail: 'Stop exposure and make the area safe where possible.'),
        _DetailItem(title: 'Emergency', detail: 'Follow the project emergency plan and summon appropriate assistance.'),
        _DetailItem(title: 'Review', detail: 'Reassess the task before restarting.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Excavation', detail: 'An assessment identifies collapse, underground services, falling materials, plant interface, water ingress and access hazards. Protective systems, utility controls, exclusion zones and inspections are established before excavation.'),
        _DetailItem(title: 'Field check', detail: 'The supervisor compares actual soil and service conditions with the assessment before authorising the next stage.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'Identify first', detail: 'A good risk assessment begins with realistic hazard identification.'),
        _DetailItem(title: 'Control the source', detail: 'Prefer controls that physically remove or isolate the hazard.'),
        _DetailItem(title: 'Keep it live', detail: 'Risk assessment is a working tool, not a one-time document.'),
      ],
    },
  ),
  'dubai_hse_plan': _TopicData(
    title: 'Construction HSE Plan',
    intro: 'A project-specific HSE plan converts Dubai construction safety requirements and project risks into defined responsibilities, procedures, programmes, emergency arrangements and monitoring activities.',
    types: [
      _DetailItem(title: 'Project HSE Plan', detail: 'Project HSE Plan is a key type or application within construction hse plan. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Construction Phase Plan', detail: 'Construction Phase Plan is a key type or application within construction hse plan. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Activity Control Plan', detail: 'Activity Control Plan is a key type or application within construction hse plan. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Emergency Plan', detail: 'Emergency Plan is a key type or application within construction hse plan. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'HSE Plan', detail: 'HSE Plan is a key component or control item for construction hse plan. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Organisation Chart', detail: 'Organisation Chart is a key component or control item for construction hse plan. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Risk Register', detail: 'Risk Register is a key component or control item for construction hse plan. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Training Plan', detail: 'Training Plan is a key component or control item for construction hse plan. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Inspection Programme', detail: 'Inspection Programme is a key component or control item for construction hse plan. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Emergency Plan', detail: 'Emergency Plan is a key component or control item for construction hse plan. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Define project HSE arrangements and translate requirements into work-package controls.'),
        _DetailItem(title: 'Scope', detail: 'Apply construction hse plan across planning, execution, inspection, supervision and close-out.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Core requirement', detail: 'Approved plan, risk register, method statements, permits and emergency arrangements must align with actual site activities.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for construction hse plan.'),
        _DetailItem(title: 'Limits', detail: 'Follow approved procedures, equipment/system instructions and project-specific limits for construction hse plan.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary hazards', detail: 'Uncontrolled work, unclear responsibilities, missing emergency arrangements and outdated documents.'),
        _DetailItem(title: 'Interface hazards', detail: 'Consider people, plant, access, temporary works and simultaneous operations affecting construction hse plan.'),
        _DetailItem(title: 'Change', detail: 'Review controls when conditions affecting construction hse plan change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Control measures', detail: 'Verify documents before mobilisation, brief teams, monitor implementation and update when scope or conditions change.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk of construction hse plan.'),
        _DetailItem(title: 'Communication', detail: 'Brief affected personnel on the controls for construction hse plan before exposure.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-start', detail: 'Inspect the relevant area, equipment and controls before construction hse plan begins.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions during construction hse plan and after changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before restart.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical failure', detail: 'Stop affected work when critical controls or approved arrangements are missing.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when construction hse plan cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Changed conditions', detail: 'Pause and reassess when the actual construction hse plan activity differs materially from the plan.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for construction hse plan.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of construction hse plan.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for construction hse plan.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow method', detail: 'Perform construction hse plan only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report hazards, defects and changes affecting construction hse plan.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Response', detail: 'Use the project emergency arrangements relevant to construction hse plan.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Construction HSE Plan', detail: 'A control gap is identified during construction hse plan. The task is paused, the area is made safe, the responsible person corrects the condition and the work is rechecked before restart.'),
        _DetailItem(title: 'Verification', detail: 'HSE verifies the corrective action and records the learning related to construction hse plan.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of construction hse plan.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
      'Roles & Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Approve resources, responsibilities and HSE objectives.'),
        _DetailItem(title: 'HSE team', detail: 'Coordinate implementation and monitoring.'),
        _DetailItem(title: 'Supervisors', detail: 'Apply the plan at workface level.'),
      ],
    },
  ),
  'dubai_work_at_height': _TopicData(
    title: 'Work at Height',
    intro: 'Controls for preventing falls of people and objects during elevated construction, maintenance, inspection and access activities.',
    types: [
      _DetailItem(title: 'Scaffold Work', detail: 'Scaffold Work is a key type or application within work at height. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Mobile Access Tower', detail: 'Mobile Access Tower is a key type or application within work at height. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'MEWP Work', detail: 'MEWP Work is a key type or application within work at height. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Ladder Work', detail: 'Ladder Work is a key type or application within work at height. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Roof / Edge Work', detail: 'Roof / Edge Work is a key type or application within work at height. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Guardrail', detail: 'Guardrail is a key component or control item for work at height. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Working Platform', detail: 'Working Platform is a key component or control item for work at height. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Harness', detail: 'Harness is a key component or control item for work at height. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Lifeline', detail: 'Lifeline is a key component or control item for work at height. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Ladder', detail: 'Ladder is a key component or control item for work at height. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'MEWP', detail: 'MEWP is a key component or control item for work at height. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Rescue Plan', detail: 'Rescue Plan is a key component or control item for work at height. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control work at height through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Controls for preventing falls of people and objects during elevated construction, maintenance, inspection and access activities.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to work at height; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for work at height.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that work at height does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with work at height.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during work at height.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting work at height change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that work at height is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with work at height orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant work at height equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout work at height and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during work at height.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual work at height activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for work at height.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of work at height.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for work at height.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform work at height only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Work at Height', detail: 'A supervisor identifies a control gap during work at height. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of work at height.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_scaffolding': _TopicData(
    title: 'Scaffolding Safety',
    intro: 'Temporary structures used to provide safe access, working platforms and fall protection. Scaffolds must be selected, designed or configured as appropriate, erected, inspected, maintained, modified and dismantled by competent persons.',
    types: [
      _DetailItem(title: 'Fixed / Static Scaffold', detail: 'Fixed / Static Scaffold is a key type or application within scaffolding safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Independent Scaffold', detail: 'Independent Scaffold is a key type or application within scaffolding safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Tied Scaffold', detail: 'Tied Scaffold is a key type or application within scaffolding safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Mobile Scaffold', detail: 'Mobile Scaffold is a key type or application within scaffolding safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Tower Scaffold', detail: 'Tower Scaffold is a key type or application within scaffolding safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Access Scaffold', detail: 'Access Scaffold is a key type or application within scaffolding safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Birdcage Scaffold', detail: 'Birdcage Scaffold is a key type or application within scaffolding safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Suspended Scaffold', detail: 'Suspended Scaffold is a key type or application within scaffolding safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Cantilever Scaffold', detail: 'Cantilever Scaffold is a key type or application within scaffolding safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'System Scaffold', detail: 'System Scaffold is a key type or application within scaffolding safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Tube & Fitting Scaffold', detail: 'Tube & Fitting Scaffold is a key type or application within scaffolding safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Special-Purpose Scaffold', detail: 'Special-Purpose Scaffold is a key type or application within scaffolding safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Standard', detail: 'Standard is a key component or control item for scaffolding safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Ledger', detail: 'Ledger is a key component or control item for scaffolding safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Transom', detail: 'Transom is a key component or control item for scaffolding safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Base Plate', detail: 'Base Plate is a key component or control item for scaffolding safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Sole Board', detail: 'Sole Board is a key component or control item for scaffolding safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Brace', detail: 'Brace is a key component or control item for scaffolding safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Tie', detail: 'Tie is a key component or control item for scaffolding safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Coupler', detail: 'Coupler is a key component or control item for scaffolding safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Platform', detail: 'Platform is a key component or control item for scaffolding safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Guardrail / Handrail', detail: 'Guardrail / Handrail is a key component or control item for scaffolding safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Intermediate Rail', detail: 'Intermediate Rail is a key component or control item for scaffolding safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Toe Board', detail: 'Toe Board is a key component or control item for scaffolding safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Access Ladder', detail: 'Access Ladder is a key component or control item for scaffolding safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Scaffold Stair', detail: 'Scaffold Stair is a key component or control item for scaffolding safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Castor / Wheel', detail: 'Castor / Wheel is a key component or control item for scaffolding safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Base Jack', detail: 'Base Jack is a key component or control item for scaffolding safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Scaffold Tag', detail: 'Scaffold Tag is a key component or control item for scaffolding safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control scaffolding safety through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Temporary structures used to provide safe access, working platforms and fall protection. Scaffolds must be selected, designed or configured as appropriate, erected, inspected, maintained, modified and dismantled by competent persons.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to scaffolding safety; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for scaffolding safety.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that scaffolding safety does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with scaffolding safety.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during scaffolding safety.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting scaffolding safety change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that scaffolding safety is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with scaffolding safety orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant scaffolding safety equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout scaffolding safety and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during scaffolding safety.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual scaffolding safety activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for scaffolding safety.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of scaffolding safety.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for scaffolding safety.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform scaffolding safety only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Scaffolding Safety', detail: 'A supervisor identifies a control gap during scaffolding safety. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of scaffolding safety.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_lifting': _TopicData(
    title: 'Lifting Operations',
    intro: 'Planned lifting of materials, equipment or other loads using cranes, hoists and lifting accessories under controlled conditions.',
    types: [
      _DetailItem(title: 'Mobile Crane', detail: 'Mobile Crane is a key type or application within lifting operations. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Tower Crane', detail: 'Tower Crane is a key type or application within lifting operations. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Crawler Crane', detail: 'Crawler Crane is a key type or application within lifting operations. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Hoist', detail: 'Hoist is a key type or application within lifting operations. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Chain Block / Lever Hoist', detail: 'Chain Block / Lever Hoist is a key type or application within lifting operations. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Critical Lift', detail: 'Critical Lift is a key type or application within lifting operations. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Routine Lift', detail: 'Routine Lift is a key type or application within lifting operations. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Crane', detail: 'Crane is a key component or control item for lifting operations. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Hook Block', detail: 'Hook Block is a key component or control item for lifting operations. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Sling', detail: 'Sling is a key component or control item for lifting operations. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Shackle', detail: 'Shackle is a key component or control item for lifting operations. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Spreader Beam', detail: 'Spreader Beam is a key component or control item for lifting operations. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Rigger', detail: 'Rigger is a key component or control item for lifting operations. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Banksman / Signaller', detail: 'Banksman / Signaller is a key component or control item for lifting operations. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Exclusion Zone', detail: 'Exclusion Zone is a key component or control item for lifting operations. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Lifting Plan', detail: 'Lifting Plan is a key component or control item for lifting operations. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control lifting operations through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Planned lifting of materials, equipment or other loads using cranes, hoists and lifting accessories under controlled conditions.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to lifting operations; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for lifting operations.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that lifting operations does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with lifting operations.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during lifting operations.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting lifting operations change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that lifting operations is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with lifting operations orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant lifting operations equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout lifting operations and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during lifting operations.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual lifting operations activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for lifting operations.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of lifting operations.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for lifting operations.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform lifting operations only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Lifting Operations', detail: 'A supervisor identifies a control gap during lifting operations. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of lifting operations.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_excavation': _TopicData(
    title: 'Excavation & Trenching',
    intro: 'Controls for ground disturbance and open excavations, including collapse, underground services, falls, plant interaction, water ingress and access.',
    types: [
      _DetailItem(title: 'Open Excavation', detail: 'Open Excavation is a key type or application within excavation & trenching. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Trench', detail: 'Trench is a key type or application within excavation & trenching. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Deep Excavation', detail: 'Deep Excavation is a key type or application within excavation & trenching. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Shored Excavation', detail: 'Shored Excavation is a key type or application within excavation & trenching. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Battered / Sloped Excavation', detail: 'Battered / Sloped Excavation is a key type or application within excavation & trenching. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Utility Excavation', detail: 'Utility Excavation is a key type or application within excavation & trenching. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Shoring', detail: 'Shoring is a key component or control item for excavation & trenching. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Trench Box', detail: 'Trench Box is a key component or control item for excavation & trenching. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Batter / Slope', detail: 'Batter / Slope is a key component or control item for excavation & trenching. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Ladder Access', detail: 'Ladder Access is a key component or control item for excavation & trenching. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Barricade', detail: 'Barricade is a key component or control item for excavation & trenching. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Spoil Pile', detail: 'Spoil Pile is a key component or control item for excavation & trenching. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Utility Drawing', detail: 'Utility Drawing is a key component or control item for excavation & trenching. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Gas Test', detail: 'Gas Test is a key component or control item for excavation & trenching. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Prevent collapse, falls, service strikes and plant interaction during excavation.'),
        _DetailItem(title: 'Scope', detail: 'Apply excavation & trenching across planning, execution, inspection, supervision and close-out.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Core requirement', detail: 'Select protective systems according to ground conditions, depth, geometry, adjacent loads and engineering requirements.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for excavation & trenching.'),
        _DetailItem(title: 'Limits', detail: 'Follow approved procedures, equipment/system instructions and project-specific limits for excavation & trenching.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary hazards', detail: 'Collapse, buried services, falling materials, plant movement, water ingress and hazardous atmospheres.'),
        _DetailItem(title: 'Interface hazards', detail: 'Consider people, plant, access, temporary works and simultaneous operations affecting excavation & trenching.'),
        _DetailItem(title: 'Change', detail: 'Review controls when conditions affecting excavation & trenching change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Control measures', detail: 'Use utility information, safe access, edge protection, spoil control, inspection and protective systems.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk of excavation & trenching.'),
        _DetailItem(title: 'Communication', detail: 'Brief affected personnel on the controls for excavation & trenching before exposure.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-start', detail: 'Inspect the relevant area, equipment and controls before excavation & trenching begins.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions during excavation & trenching and after changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before restart.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical failure', detail: 'Stop for cracking, movement, unexpected services, water ingress, unsafe access or failed protective systems.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when excavation & trenching cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Changed conditions', detail: 'Pause and reassess when the actual excavation & trenching activity differs materially from the plan.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for excavation & trenching.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of excavation & trenching.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for excavation & trenching.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow method', detail: 'Perform excavation & trenching only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report hazards, defects and changes affecting excavation & trenching.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Response', detail: 'Use the project emergency arrangements relevant to excavation & trenching.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Excavation & Trenching', detail: 'A control gap is identified during excavation & trenching. The task is paused, the area is made safe, the responsible person corrects the condition and the work is rechecked before restart.'),
        _DetailItem(title: 'Verification', detail: 'HSE verifies the corrective action and records the learning related to excavation & trenching.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of excavation & trenching.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
      'Types / Systems': [
        _DetailItem(title: 'Open Excavation', detail: 'Broad excavation with suitable engineered or assessed side protection.'),
        _DetailItem(title: 'Trench', detail: 'Narrow excavation requiring appropriate protective measures and access.'),
        _DetailItem(title: 'Deep Excavation', detail: 'Excavation where ground, adjacent structures and temporary support require enhanced engineering control.'),
      ],
      'Components / Key Items': [
        _DetailItem(title: 'Shoring', detail: 'Support system resisting ground movement.'),
        _DetailItem(title: 'Trench Box', detail: 'Protective system designed to protect people within a trench.'),
        _DetailItem(title: 'Access', detail: 'Safe ladder, stair or other approved access arrangement.'),
      ],
    },
  ),
  'dubai_confined_space': _TopicData(
    title: 'Confined Space Entry',
    intro: 'Controls for entry into spaces where access is restricted and hazards may include oxygen deficiency, toxic or flammable atmospheres, engulfment, mechanical energy and difficult rescue.',
    types: [
      _DetailItem(title: 'Permit Entry', detail: 'Permit Entry is a key type or application within confined space entry. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Non-Entry Work', detail: 'Non-Entry Work is a key type or application within confined space entry. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Atmosphere-Dependent Entry', detail: 'Atmosphere-Dependent Entry is a key type or application within confined space entry. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Emergency Entry', detail: 'Emergency Entry is a key type or application within confined space entry. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Entry Permit', detail: 'Entry Permit is a key component or control item for confined space entry. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Gas Detector', detail: 'Gas Detector is a key component or control item for confined space entry. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Ventilation', detail: 'Ventilation is a key component or control item for confined space entry. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Isolation', detail: 'Isolation is a key component or control item for confined space entry. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Standby Person', detail: 'Standby Person is a key component or control item for confined space entry. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Harness / Lifeline', detail: 'Harness / Lifeline is a key component or control item for confined space entry. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Rescue Equipment', detail: 'Rescue Equipment is a key component or control item for confined space entry. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Communication', detail: 'Communication is a key component or control item for confined space entry. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control confined space entry through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Controls for entry into spaces where access is restricted and hazards may include oxygen deficiency, toxic or flammable atmospheres, engulfment, mechanical energy and difficult rescue.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to confined space entry; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for confined space entry.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that confined space entry does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with confined space entry.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during confined space entry.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting confined space entry change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that confined space entry is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with confined space entry orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant confined space entry equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout confined space entry and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during confined space entry.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual confined space entry activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for confined space entry.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of confined space entry.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for confined space entry.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform confined space entry only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Confined Space Entry', detail: 'A supervisor identifies a control gap during confined space entry. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of confined space entry.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_electrical': _TopicData(
    title: 'Electrical Safety',
    intro: 'Controls for electrical installation, temporary power, tools, distribution, isolation and work near electrical energy.',
    types: [
      _DetailItem(title: 'Temporary Electrical System', detail: 'Temporary Electrical System is a key type or application within electrical safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Fixed Installation', detail: 'Fixed Installation is a key type or application within electrical safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Electrical Maintenance', detail: 'Electrical Maintenance is a key type or application within electrical safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Live-Work Controlled Activity', detail: 'Live-Work Controlled Activity is a key type or application within electrical safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Work Near Electrical Services', detail: 'Work Near Electrical Services is a key type or application within electrical safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'DB / Distribution Board', detail: 'DB / Distribution Board is a key component or control item for electrical safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'RCD / RCBO', detail: 'RCD / RCBO is a key component or control item for electrical safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Cable', detail: 'Cable is a key component or control item for electrical safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Plug / Socket', detail: 'Plug / Socket is a key component or control item for electrical safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Earthing', detail: 'Earthing is a key component or control item for electrical safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Isolation Point', detail: 'Isolation Point is a key component or control item for electrical safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Lockout / Tagout', detail: 'Lockout / Tagout is a key component or control item for electrical safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Electrical Tool', detail: 'Electrical Tool is a key component or control item for electrical safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Prevent electric shock, burns, arc events, fires and unintended energisation.'),
        _DetailItem(title: 'Scope', detail: 'Apply electrical safety across planning, execution, inspection, supervision and close-out.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Core requirement', detail: 'Select suitable equipment, protect circuits, provide earthing and residual-current protection where required, and control isolation.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for electrical safety.'),
        _DetailItem(title: 'Limits', detail: 'Follow approved procedures, equipment/system instructions and project-specific limits for electrical safety.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary hazards', detail: 'Shock, arc flash, damaged cables, poor temporary power, water exposure and unexpected energisation.'),
        _DetailItem(title: 'Interface hazards', detail: 'Consider people, plant, access, temporary works and simultaneous operations affecting electrical safety.'),
        _DetailItem(title: 'Change', detail: 'Review controls when conditions affecting electrical safety change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Control measures', detail: 'Use competent persons, inspect equipment, protect cables, control access and apply isolation/lockout where required.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk of electrical safety.'),
        _DetailItem(title: 'Communication', detail: 'Brief affected personnel on the controls for electrical safety before exposure.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-start', detail: 'Inspect the relevant area, equipment and controls before electrical safety begins.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions during electrical safety and after changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before restart.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical failure', detail: 'Stop for exposed live parts, damaged cables, failed protection, unauthorised live work or lost isolation.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when electrical safety cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Changed conditions', detail: 'Pause and reassess when the actual electrical safety activity differs materially from the plan.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for electrical safety.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of electrical safety.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for electrical safety.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow method', detail: 'Perform electrical safety only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report hazards, defects and changes affecting electrical safety.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Response', detail: 'Use the project emergency arrangements relevant to electrical safety.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Electrical Safety', detail: 'A control gap is identified during electrical safety. The task is paused, the area is made safe, the responsible person corrects the condition and the work is rechecked before restart.'),
        _DetailItem(title: 'Verification', detail: 'HSE verifies the corrective action and records the learning related to electrical safety.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of electrical safety.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
      'Types / Systems': [
        _DetailItem(title: 'Temporary Power', detail: 'Construction distribution, temporary cables and portable equipment.'),
        _DetailItem(title: 'Fixed Installation', detail: 'Permanent distribution and installed electrical systems.'),
        _DetailItem(title: 'Isolation', detail: 'Controlled de-energisation for maintenance and work.'),
      ],
      'Components / Key Items': [
        _DetailItem(title: 'RCD / RCBO', detail: 'Provides additional protection against certain fault conditions where correctly selected and maintained.'),
        _DetailItem(title: 'Earthing', detail: 'Provides a controlled fault path as required by the electrical system.'),
        _DetailItem(title: 'Isolation Point', detail: 'Allows equipment or circuits to be made safe before work.'),
      ],
    },
  ),
  'dubai_hot_work': _TopicData(
    title: 'Hot Work Safety',
    intro: 'Controls for welding, cutting, grinding, brazing and other work capable of producing flame, sparks, heat or ignition sources.',
    types: [
      _DetailItem(title: 'Welding', detail: 'Welding is a key type or application within hot work safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Gas Cutting', detail: 'Gas Cutting is a key type or application within hot work safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Grinding', detail: 'Grinding is a key type or application within hot work safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Brazing / Soldering', detail: 'Brazing / Soldering is a key type or application within hot work safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Roofing Hot Work', detail: 'Roofing Hot Work is a key type or application within hot work safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Hot Work Permit', detail: 'Hot Work Permit is a key component or control item for hot work safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Welding Set', detail: 'Welding Set is a key component or control item for hot work safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Gas Cylinder', detail: 'Gas Cylinder is a key component or control item for hot work safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Flashback Arrestor', detail: 'Flashback Arrestor is a key component or control item for hot work safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Fire Watch', detail: 'Fire Watch is a key component or control item for hot work safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Fire Extinguisher', detail: 'Fire Extinguisher is a key component or control item for hot work safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Spark Containment', detail: 'Spark Containment is a key component or control item for hot work safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Gas Hose', detail: 'Gas Hose is a key component or control item for hot work safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Prevent fire, explosion, burns and exposure during spark- or flame-producing work.'),
        _DetailItem(title: 'Scope', detail: 'Apply hot work safety across planning, execution, inspection, supervision and close-out.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Core requirement', detail: 'Control ignition sources, combustible materials, gas cylinders, ventilation, screens and fire protection.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for hot work safety.'),
        _DetailItem(title: 'Limits', detail: 'Follow approved procedures, equipment/system instructions and project-specific limits for hot work safety.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary hazards', detail: 'Fire, explosion, burns, fumes, gas leaks and ignition of hidden combustibles.'),
        _DetailItem(title: 'Interface hazards', detail: 'Consider people, plant, access, temporary works and simultaneous operations affecting hot work safety.'),
        _DetailItem(title: 'Change', detail: 'Review controls when conditions affecting hot work safety change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Control measures', detail: 'Permit where required, remove/protect combustibles, provide fire watch, inspect adjacent areas and maintain extinguishing equipment.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk of hot work safety.'),
        _DetailItem(title: 'Communication', detail: 'Brief affected personnel on the controls for hot work safety before exposure.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-start', detail: 'Inspect the relevant area, equipment and controls before hot work safety begins.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions during hot work safety and after changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before restart.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical failure', detail: 'Stop for uncontrolled combustibles, gas leak, missing fire protection, unsafe cylinders or failed permit controls.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when hot work safety cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Changed conditions', detail: 'Pause and reassess when the actual hot work safety activity differs materially from the plan.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for hot work safety.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of hot work safety.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for hot work safety.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow method', detail: 'Perform hot work safety only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report hazards, defects and changes affecting hot work safety.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Response', detail: 'Use the project emergency arrangements relevant to hot work safety.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Hot Work Safety', detail: 'A control gap is identified during hot work safety. The task is paused, the area is made safe, the responsible person corrects the condition and the work is rechecked before restart.'),
        _DetailItem(title: 'Verification', detail: 'HSE verifies the corrective action and records the learning related to hot work safety.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of hot work safety.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
      'Types / Systems': [
        _DetailItem(title: 'Welding', detail: 'Arc-based joining with heat and sparks.'),
        _DetailItem(title: 'Gas Cutting', detail: 'Flame cutting using fuel gas and oxygen.'),
        _DetailItem(title: 'Grinding', detail: 'High-speed abrasive work producing sparks.'),
      ],
      'Components / Key Items': [
        _DetailItem(title: 'Permit', detail: 'Formal control for hot work where required.'),
        _DetailItem(title: 'Fire Watch', detail: 'Dedicated person monitoring for ignition during and after work as required.'),
        _DetailItem(title: 'Flashback Arrestor', detail: 'Protective device used in suitable gas systems to help prevent flame propagation.'),
      ],
    },
  ),
  'dubai_traffic': _TopicData(
    title: 'Construction Traffic Management',
    intro: 'Controls interaction between vehicles, mobile plant, pedestrians, deliveries and public traffic around construction sites.',
    types: [
      _DetailItem(title: 'Internal Site Traffic', detail: 'Internal Site Traffic is a key type or application within construction traffic management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Public Interface', detail: 'Public Interface is a key type or application within construction traffic management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Delivery Route', detail: 'Delivery Route is a key type or application within construction traffic management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Plant Movement', detail: 'Plant Movement is a key type or application within construction traffic management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Reversing Operation', detail: 'Reversing Operation is a key type or application within construction traffic management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Temporary Road Arrangement', detail: 'Temporary Road Arrangement is a key type or application within construction traffic management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Traffic Plan', detail: 'Traffic Plan is a key component or control item for construction traffic management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Banksman', detail: 'Banksman is a key component or control item for construction traffic management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Pedestrian Route', detail: 'Pedestrian Route is a key component or control item for construction traffic management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Barrier', detail: 'Barrier is a key component or control item for construction traffic management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Wheel Stop', detail: 'Wheel Stop is a key component or control item for construction traffic management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Warning Sign', detail: 'Warning Sign is a key component or control item for construction traffic management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Lighting', detail: 'Lighting is a key component or control item for construction traffic management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Vehicle Reversing Aid', detail: 'Vehicle Reversing Aid is a key component or control item for construction traffic management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control construction traffic management through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Controls interaction between vehicles, mobile plant, pedestrians, deliveries and public traffic around construction sites.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to construction traffic management; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for construction traffic management.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that construction traffic management does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with construction traffic management.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during construction traffic management.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting construction traffic management change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that construction traffic management is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with construction traffic management orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant construction traffic management equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout construction traffic management and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during construction traffic management.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual construction traffic management activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for construction traffic management.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of construction traffic management.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for construction traffic management.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform construction traffic management only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Construction Traffic Management', detail: 'A supervisor identifies a control gap during construction traffic management. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of construction traffic management.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_demolition': _TopicData(
    title: 'Demolition Safety',
    intro: 'Planned control of structural instability, falling materials, dust, services, plant, public exposure and unexpected building conditions during demolition.',
    types: [
      _DetailItem(title: 'Manual Demolition', detail: 'Manual Demolition is a key type or application within demolition safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Mechanical Demolition', detail: 'Mechanical Demolition is a key type or application within demolition safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Partial Demolition', detail: 'Partial Demolition is a key type or application within demolition safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Structural Demolition', detail: 'Structural Demolition is a key type or application within demolition safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Selective Demolition', detail: 'Selective Demolition is a key type or application within demolition safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Demolition Survey', detail: 'Demolition Survey is a key component or control item for demolition safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Sequence Plan', detail: 'Sequence Plan is a key component or control item for demolition safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Exclusion Zone', detail: 'Exclusion Zone is a key component or control item for demolition safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Temporary Support', detail: 'Temporary Support is a key component or control item for demolition safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Dust Control', detail: 'Dust Control is a key component or control item for demolition safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Service Isolation', detail: 'Service Isolation is a key component or control item for demolition safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Plant', detail: 'Plant is a key component or control item for demolition safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Debris Control', detail: 'Debris Control is a key component or control item for demolition safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control demolition safety through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Planned control of structural instability, falling materials, dust, services, plant, public exposure and unexpected building conditions during demolition.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to demolition safety; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for demolition safety.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that demolition safety does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with demolition safety.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during demolition safety.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting demolition safety change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that demolition safety is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with demolition safety orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant demolition safety equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout demolition safety and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during demolition safety.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual demolition safety activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for demolition safety.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of demolition safety.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for demolition safety.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform demolition safety only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Demolition Safety', detail: 'A supervisor identifies a control gap during demolition safety. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of demolition safety.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_temporary_works': _TopicData(
    title: 'Temporary Works Safety',
    intro: 'Safety of temporary structures and support systems such as formwork, falsework, shoring, access structures and temporary stability arrangements.',
    types: [
      _DetailItem(title: 'Formwork', detail: 'Formwork is a key type or application within temporary works safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Falsework', detail: 'Falsework is a key type or application within temporary works safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Shoring', detail: 'Shoring is a key type or application within temporary works safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Temporary Access', detail: 'Temporary Access is a key type or application within temporary works safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Temporary Stability', detail: 'Temporary Stability is a key type or application within temporary works safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Temporary Support', detail: 'Temporary Support is a key type or application within temporary works safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Design', detail: 'Design is a key component or control item for temporary works safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Drawing', detail: 'Drawing is a key component or control item for temporary works safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Load Path', detail: 'Load Path is a key component or control item for temporary works safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Prop', detail: 'Prop is a key component or control item for temporary works safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Brace', detail: 'Brace is a key component or control item for temporary works safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Tie', detail: 'Tie is a key component or control item for temporary works safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Bearing', detail: 'Bearing is a key component or control item for temporary works safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Inspection Hold Point', detail: 'Inspection Hold Point is a key component or control item for temporary works safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control temporary works safety through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Safety of temporary structures and support systems such as formwork, falsework, shoring, access structures and temporary stability arrangements.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to temporary works safety; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for temporary works safety.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that temporary works safety does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with temporary works safety.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during temporary works safety.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting temporary works safety change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that temporary works safety is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with temporary works safety orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant temporary works safety equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout temporary works safety and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during temporary works safety.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual temporary works safety activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for temporary works safety.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of temporary works safety.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for temporary works safety.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform temporary works safety only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Temporary Works Safety', detail: 'A supervisor identifies a control gap during temporary works safety. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of temporary works safety.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_heat_stress': _TopicData(
    title: 'Heat Stress Management',
    intro: 'Controls for heat exposure, hydration, work-rest planning, acclimatisation, shade, monitoring and early recognition of heat illness. Dubai Municipality lists Technical Guideline 38 for Management of Heat Stress at Work.',
    types: [
      _DetailItem(title: 'Outdoor Work', detail: 'Outdoor Work is a key type or application within heat stress management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Heavy Work', detail: 'Heavy Work is a key type or application within heat stress management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Direct Sun Work', detail: 'Direct Sun Work is a key type or application within heat stress management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Indoor Hot Area', detail: 'Indoor Hot Area is a key type or application within heat stress management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Night / Shift Work', detail: 'Night / Shift Work is a key type or application within heat stress management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Heat Index', detail: 'Heat Index is a key component or control item for heat stress management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Drinking Water', detail: 'Drinking Water is a key component or control item for heat stress management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Shade', detail: 'Shade is a key component or control item for heat stress management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Rest Area', detail: 'Rest Area is a key component or control item for heat stress management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Ventilation', detail: 'Ventilation is a key component or control item for heat stress management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Acclimatisation', detail: 'Acclimatisation is a key component or control item for heat stress management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Buddy System', detail: 'Buddy System is a key component or control item for heat stress management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Heat Illness Response', detail: 'Heat Illness Response is a key component or control item for heat stress management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Prevent heat illness through planning, hydration, acclimatisation, shade, work-rest arrangements and monitoring.'),
        _DetailItem(title: 'Scope', detail: 'Apply heat stress management across planning, execution, inspection, supervision and close-out.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Core requirement', detail: 'Use current heat conditions, workload, clothing, humidity, air movement and worker condition to determine controls.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for heat stress management.'),
        _DetailItem(title: 'Limits', detail: 'Follow approved procedures, equipment/system instructions and project-specific limits for heat stress management.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary hazards', detail: 'Heat cramps, exhaustion, heat stroke, dehydration and impaired judgement.'),
        _DetailItem(title: 'Interface hazards', detail: 'Consider people, plant, access, temporary works and simultaneous operations affecting heat stress management.'),
        _DetailItem(title: 'Change', detail: 'Review controls when conditions affecting heat stress management change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Control measures', detail: 'Provide cool drinking water, shaded/rest areas, acclimatisation, suitable work-rest arrangements and buddy monitoring.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk of heat stress management.'),
        _DetailItem(title: 'Communication', detail: 'Brief affected personnel on the controls for heat stress management before exposure.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-start', detail: 'Inspect the relevant area, equipment and controls before heat stress management begins.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions during heat stress management and after changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before restart.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical failure', detail: 'Stop or modify work for signs of heat illness, deteriorating conditions or ineffective cooling/hydration controls.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when heat stress management cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Changed conditions', detail: 'Pause and reassess when the actual heat stress management activity differs materially from the plan.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for heat stress management.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of heat stress management.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for heat stress management.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow method', detail: 'Perform heat stress management only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report hazards, defects and changes affecting heat stress management.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Response', detail: 'Use the project emergency arrangements relevant to heat stress management.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Heat Stress Management', detail: 'A control gap is identified during heat stress management. The task is paused, the area is made safe, the responsible person corrects the condition and the work is rechecked before restart.'),
        _DetailItem(title: 'Verification', detail: 'HSE verifies the corrective action and records the learning related to heat stress management.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of heat stress management.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
      'Types / Systems': [
        _DetailItem(title: 'Outdoor Work', detail: 'Direct solar and environmental heat exposure.'),
        _DetailItem(title: 'Heavy Work', detail: 'High metabolic workload producing additional heat.'),
        _DetailItem(title: 'Indoor Hot Area', detail: 'Heat exposure where ventilation or process conditions are poor.'),
      ],
      'Components / Key Items': [
        _DetailItem(title: 'Heat Index', detail: 'Use the applicable heat-index approach to understand combined temperature/humidity conditions.'),
        _DetailItem(title: 'Water', detail: 'Provide cool drinking water and encourage regular hydration.'),
        _DetailItem(title: 'Shade / Rest', detail: 'Provide suitable shaded or cooled recovery areas.'),
      ],
    },
  ),
  'dubai_occupational_health': _TopicData(
    title: 'Occupational Health',
    intro: 'Management of health risks arising from construction work, including noise, vibration, dust, chemicals, ergonomics, heat and occupational exposure.',
    types: [
      _DetailItem(title: 'Health Surveillance', detail: 'Health Surveillance is a key type or application within occupational health. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Exposure Monitoring', detail: 'Exposure Monitoring is a key type or application within occupational health. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Ergonomic Control', detail: 'Ergonomic Control is a key type or application within occupational health. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Chemical Exposure Control', detail: 'Chemical Exposure Control is a key type or application within occupational health. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Noise / Vibration Control', detail: 'Noise / Vibration Control is a key type or application within occupational health. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Health Assessment', detail: 'Health Assessment is a key component or control item for occupational health. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Exposure Register', detail: 'Exposure Register is a key component or control item for occupational health. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Noise Monitoring', detail: 'Noise Monitoring is a key component or control item for occupational health. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Dust Control', detail: 'Dust Control is a key component or control item for occupational health. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Hearing Protection', detail: 'Hearing Protection is a key component or control item for occupational health. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Respiratory Protection', detail: 'Respiratory Protection is a key component or control item for occupational health. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Ergonomic Assessment', detail: 'Ergonomic Assessment is a key component or control item for occupational health. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control occupational health through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Management of health risks arising from construction work, including noise, vibration, dust, chemicals, ergonomics, heat and occupational exposure.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to occupational health; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for occupational health.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that occupational health does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with occupational health.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during occupational health.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting occupational health change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that occupational health is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with occupational health orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant occupational health equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout occupational health and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during occupational health.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual occupational health activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for occupational health.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of occupational health.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for occupational health.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform occupational health only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Occupational Health', detail: 'A supervisor identifies a control gap during occupational health. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of occupational health.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_ppe': _TopicData(
    title: 'Personal Protective Equipment',
    intro: 'Selection, provision, inspection, use and maintenance of PPE as a supporting layer within a broader hierarchy of controls.',
    types: [
      _DetailItem(title: 'Head Protection', detail: 'Head Protection is a key type or application within personal protective equipment. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Eye / Face Protection', detail: 'Eye / Face Protection is a key type or application within personal protective equipment. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Hearing Protection', detail: 'Hearing Protection is a key type or application within personal protective equipment. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Hand Protection', detail: 'Hand Protection is a key type or application within personal protective equipment. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Foot Protection', detail: 'Foot Protection is a key type or application within personal protective equipment. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Protective Clothing', detail: 'Protective Clothing is a key type or application within personal protective equipment. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Fall Protection', detail: 'Fall Protection is a key type or application within personal protective equipment. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Respiratory Protection', detail: 'Respiratory Protection is a key type or application within personal protective equipment. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Helmet', detail: 'Helmet is a key component or control item for personal protective equipment. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Safety Glasses', detail: 'Safety Glasses is a key component or control item for personal protective equipment. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Face Shield', detail: 'Face Shield is a key component or control item for personal protective equipment. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Gloves', detail: 'Gloves is a key component or control item for personal protective equipment. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Safety Footwear', detail: 'Safety Footwear is a key component or control item for personal protective equipment. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'High-Visibility Clothing', detail: 'High-Visibility Clothing is a key component or control item for personal protective equipment. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Harness', detail: 'Harness is a key component or control item for personal protective equipment. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Respirator', detail: 'Respirator is a key component or control item for personal protective equipment. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Use PPE as a supporting barrier after hazards have been assessed and higher-level controls applied.'),
        _DetailItem(title: 'Scope', detail: 'Apply personal protective equipment across planning, execution, inspection, supervision and close-out.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Core requirement', detail: 'Select PPE for the hazard, compatibility, fit, task, environment and user.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for personal protective equipment.'),
        _DetailItem(title: 'Limits', detail: 'Follow approved procedures, equipment/system instructions and project-specific limits for personal protective equipment.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary hazards', detail: 'Wrong PPE, poor fit, damaged equipment, incompatible PPE and false reliance on PPE.'),
        _DetailItem(title: 'Interface hazards', detail: 'Consider people, plant, access, temporary works and simultaneous operations affecting personal protective equipment.'),
        _DetailItem(title: 'Change', detail: 'Review controls when conditions affecting personal protective equipment change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Control measures', detail: 'Provide suitable PPE, train users, inspect before use, maintain and replace defective equipment.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk of personal protective equipment.'),
        _DetailItem(title: 'Communication', detail: 'Brief affected personnel on the controls for personal protective equipment before exposure.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-start', detail: 'Inspect the relevant area, equipment and controls before personal protective equipment begins.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions during personal protective equipment and after changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before restart.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical failure', detail: 'Stop when required PPE is missing, unsuitable, damaged or incompatible with the task.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when personal protective equipment cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Changed conditions', detail: 'Pause and reassess when the actual personal protective equipment activity differs materially from the plan.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for personal protective equipment.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of personal protective equipment.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for personal protective equipment.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow method', detail: 'Perform personal protective equipment only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report hazards, defects and changes affecting personal protective equipment.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Response', detail: 'Use the project emergency arrangements relevant to personal protective equipment.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Personal Protective Equipment', detail: 'A control gap is identified during personal protective equipment. The task is paused, the area is made safe, the responsible person corrects the condition and the work is rechecked before restart.'),
        _DetailItem(title: 'Verification', detail: 'HSE verifies the corrective action and records the learning related to personal protective equipment.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of personal protective equipment.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
      'Types / Systems': [
        _DetailItem(title: 'Head Protection', detail: 'Protects against specified impact or falling-object hazards.'),
        _DetailItem(title: 'Eye / Face Protection', detail: 'Controls exposure to particles, splash, radiation or other task hazards.'),
        _DetailItem(title: 'Hand / Foot Protection', detail: 'Selected for mechanical, chemical, thermal or other identified hazards.'),
      ],
      'Components / Key Items': [
        _DetailItem(title: 'Helmet', detail: 'Select compatible head protection for the hazard and work environment.'),
        _DetailItem(title: 'Eye Protection', detail: 'Choose lens and design suitable for the exposure.'),
        _DetailItem(title: 'Harness', detail: 'Use only where a suitable fall-protection system requires it and with compatible equipment.'),
      ],
    },
  ),
  'dubai_emergency': _TopicData(
    title: 'Emergency Preparedness & Response',
    intro: 'Planning and readiness for fire, medical emergencies, collapse, rescue, chemical release, severe weather and other foreseeable construction emergencies.',
    types: [
      _DetailItem(title: 'Fire Emergency', detail: 'Fire Emergency is a key type or application within emergency preparedness & response. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Medical Emergency', detail: 'Medical Emergency is a key type or application within emergency preparedness & response. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Fall / Rescue', detail: 'Fall / Rescue is a key type or application within emergency preparedness & response. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Collapse', detail: 'Collapse is a key type or application within emergency preparedness & response. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Chemical Release', detail: 'Chemical Release is a key type or application within emergency preparedness & response. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Severe Weather', detail: 'Severe Weather is a key type or application within emergency preparedness & response. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Emergency Plan', detail: 'Emergency Plan is a key component or control item for emergency preparedness & response. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Alarm', detail: 'Alarm is a key component or control item for emergency preparedness & response. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Assembly Point', detail: 'Assembly Point is a key component or control item for emergency preparedness & response. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Fire Extinguisher', detail: 'Fire Extinguisher is a key component or control item for emergency preparedness & response. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'First Aid Kit', detail: 'First Aid Kit is a key component or control item for emergency preparedness & response. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Rescue Equipment', detail: 'Rescue Equipment is a key component or control item for emergency preparedness & response. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Emergency Contact', detail: 'Emergency Contact is a key component or control item for emergency preparedness & response. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Access Route', detail: 'Access Route is a key component or control item for emergency preparedness & response. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control emergency preparedness & response through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Planning and readiness for fire, medical emergencies, collapse, rescue, chemical release, severe weather and other foreseeable construction emergencies.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to emergency preparedness & response; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for emergency preparedness & response.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that emergency preparedness & response does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with emergency preparedness & response.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during emergency preparedness & response.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting emergency preparedness & response change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that emergency preparedness & response is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with emergency preparedness & response orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant emergency preparedness & response equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout emergency preparedness & response and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during emergency preparedness & response.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual emergency preparedness & response activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for emergency preparedness & response.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of emergency preparedness & response.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for emergency preparedness & response.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform emergency preparedness & response only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Emergency Preparedness & Response', detail: 'A supervisor identifies a control gap during emergency preparedness & response. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of emergency preparedness & response.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_incident': _TopicData(
    title: 'Incident Reporting & Investigation',
    intro: 'A structured process for reporting incidents and near misses, protecting evidence, identifying causes and implementing effective corrective actions.',
    types: [
      _DetailItem(title: 'Near Miss', detail: 'Near Miss is a key type or application within incident reporting & investigation. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'First Aid Case', detail: 'First Aid Case is a key type or application within incident reporting & investigation. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Recordable Injury', detail: 'Recordable Injury is a key type or application within incident reporting & investigation. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Property Damage', detail: 'Property Damage is a key type or application within incident reporting & investigation. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Environmental Event', detail: 'Environmental Event is a key type or application within incident reporting & investigation. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Serious Incident', detail: 'Serious Incident is a key type or application within incident reporting & investigation. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Initial Report', detail: 'Initial Report is a key component or control item for incident reporting & investigation. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Evidence', detail: 'Evidence is a key component or control item for incident reporting & investigation. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Witness Statement', detail: 'Witness Statement is a key component or control item for incident reporting & investigation. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Root Cause', detail: 'Root Cause is a key component or control item for incident reporting & investigation. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Corrective Action', detail: 'Corrective Action is a key component or control item for incident reporting & investigation. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Lessons Learned', detail: 'Lessons Learned is a key component or control item for incident reporting & investigation. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Close-Out', detail: 'Close-Out is a key component or control item for incident reporting & investigation. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control incident reporting & investigation through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'A structured process for reporting incidents and near misses, protecting evidence, identifying causes and implementing effective corrective actions.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to incident reporting & investigation; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for incident reporting & investigation.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that incident reporting & investigation does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with incident reporting & investigation.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during incident reporting & investigation.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting incident reporting & investigation change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that incident reporting & investigation is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with incident reporting & investigation orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant incident reporting & investigation equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout incident reporting & investigation and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during incident reporting & investigation.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual incident reporting & investigation activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for incident reporting & investigation.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of incident reporting & investigation.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for incident reporting & investigation.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform incident reporting & investigation only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Incident Reporting & Investigation', detail: 'A supervisor identifies a control gap during incident reporting & investigation. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of incident reporting & investigation.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_contractor': _TopicData(
    title: 'Contractor & Subcontractor HSE Management',
    intro: 'Controls for selecting, onboarding, coordinating, supervising and assuring contractors and subcontractors.',
    types: [
      _DetailItem(title: 'Prequalification', detail: 'Prequalification is a key type or application within contractor & subcontractor hse management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Mobilisation', detail: 'Mobilisation is a key type or application within contractor & subcontractor hse management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Subcontractor Control', detail: 'Subcontractor Control is a key type or application within contractor & subcontractor hse management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'High-Risk Specialist Contractor', detail: 'High-Risk Specialist Contractor is a key type or application within contractor & subcontractor hse management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Performance Review', detail: 'Performance Review is a key type or application within contractor & subcontractor hse management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Prequalification', detail: 'Prequalification is a key component or control item for contractor & subcontractor hse management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'HSE Plan', detail: 'HSE Plan is a key component or control item for contractor & subcontractor hse management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Induction', detail: 'Induction is a key component or control item for contractor & subcontractor hse management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Competence Record', detail: 'Competence Record is a key component or control item for contractor & subcontractor hse management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Method Statement', detail: 'Method Statement is a key component or control item for contractor & subcontractor hse management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Permit', detail: 'Permit is a key component or control item for contractor & subcontractor hse management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Inspection', detail: 'Inspection is a key component or control item for contractor & subcontractor hse management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Performance Scorecard', detail: 'Performance Scorecard is a key component or control item for contractor & subcontractor hse management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control contractor & subcontractor hse management through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Controls for selecting, onboarding, coordinating, supervising and assuring contractors and subcontractors.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to contractor & subcontractor hse management; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for contractor & subcontractor hse management.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that contractor & subcontractor hse management does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with contractor & subcontractor hse management.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during contractor & subcontractor hse management.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting contractor & subcontractor hse management change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that contractor & subcontractor hse management is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with contractor & subcontractor hse management orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant contractor & subcontractor hse management equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout contractor & subcontractor hse management and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during contractor & subcontractor hse management.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual contractor & subcontractor hse management activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for contractor & subcontractor hse management.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of contractor & subcontractor hse management.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for contractor & subcontractor hse management.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform contractor & subcontractor hse management only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Contractor & Subcontractor HSE Management', detail: 'A supervisor identifies a control gap during contractor & subcontractor hse management. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of contractor & subcontractor hse management.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_environment': _TopicData(
    title: 'Environmental & Waste Management',
    intro: 'Controls for construction waste, spills, dust, noise, water, hazardous materials, storage and environmental impacts.',
    types: [
      _DetailItem(title: 'General Waste', detail: 'General Waste is a key type or application within environmental & waste management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Construction Waste', detail: 'Construction Waste is a key type or application within environmental & waste management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Hazardous Waste', detail: 'Hazardous Waste is a key type or application within environmental & waste management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Spill Response', detail: 'Spill Response is a key type or application within environmental & waste management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Dust Control', detail: 'Dust Control is a key type or application within environmental & waste management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Water / Drainage Control', detail: 'Water / Drainage Control is a key type or application within environmental & waste management. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Waste Container', detail: 'Waste Container is a key component or control item for environmental & waste management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Segregation', detail: 'Segregation is a key component or control item for environmental & waste management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Spill Kit', detail: 'Spill Kit is a key component or control item for environmental & waste management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Chemical Storage', detail: 'Chemical Storage is a key component or control item for environmental & waste management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Dust Suppression', detail: 'Dust Suppression is a key component or control item for environmental & waste management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Drain Protection', detail: 'Drain Protection is a key component or control item for environmental & waste management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Waste Transfer Record', detail: 'Waste Transfer Record is a key component or control item for environmental & waste management. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control environmental & waste management through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Controls for construction waste, spills, dust, noise, water, hazardous materials, storage and environmental impacts.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to environmental & waste management; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for environmental & waste management.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that environmental & waste management does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with environmental & waste management.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during environmental & waste management.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting environmental & waste management change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that environmental & waste management is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with environmental & waste management orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant environmental & waste management equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout environmental & waste management and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during environmental & waste management.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual environmental & waste management activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for environmental & waste management.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of environmental & waste management.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for environmental & waste management.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform environmental & waste management only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Environmental & Waste Management', detail: 'A supervisor identifies a control gap during environmental & waste management. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of environmental & waste management.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_inspection': _TopicData(
    title: 'HSE Inspection & Audit',
    intro: 'Planned inspection and audit processes used to identify unsafe conditions, verify critical controls and drive corrective action.',
    types: [
      _DetailItem(title: 'Daily Inspection', detail: 'Daily Inspection is a key type or application within hse inspection & audit. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Weekly Inspection', detail: 'Weekly Inspection is a key type or application within hse inspection & audit. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Thematic Inspection', detail: 'Thematic Inspection is a key type or application within hse inspection & audit. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Management Inspection', detail: 'Management Inspection is a key type or application within hse inspection & audit. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'System Audit', detail: 'System Audit is a key type or application within hse inspection & audit. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Compliance Audit', detail: 'Compliance Audit is a key type or application within hse inspection & audit. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Inspection Checklist', detail: 'Inspection Checklist is a key component or control item for hse inspection & audit. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Finding', detail: 'Finding is a key component or control item for hse inspection & audit. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Action', detail: 'Action is a key component or control item for hse inspection & audit. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Evidence', detail: 'Evidence is a key component or control item for hse inspection & audit. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Audit Sample', detail: 'Audit Sample is a key component or control item for hse inspection & audit. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Close-Out', detail: 'Close-Out is a key component or control item for hse inspection & audit. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Trend', detail: 'Trend is a key component or control item for hse inspection & audit. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control hse inspection & audit through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Planned inspection and audit processes used to identify unsafe conditions, verify critical controls and drive corrective action.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to hse inspection & audit; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for hse inspection & audit.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that hse inspection & audit does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with hse inspection & audit.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during hse inspection & audit.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting hse inspection & audit change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that hse inspection & audit is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with hse inspection & audit orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant hse inspection & audit equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout hse inspection & audit and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during hse inspection & audit.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual hse inspection & audit activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for hse inspection & audit.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of hse inspection & audit.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for hse inspection & audit.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform hse inspection & audit only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'HSE Inspection & Audit', detail: 'A supervisor identifies a control gap during hse inspection & audit. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of hse inspection & audit.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_performance': _TopicData(
    title: 'HSE Performance Monitoring',
    intro: 'Measurement of leading and lagging indicators to understand whether HSE controls are working and where improvement is needed.',
    types: [
      _DetailItem(title: 'Leading Indicators', detail: 'Leading Indicators is a key type or application within hse performance monitoring. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Lagging Indicators', detail: 'Lagging Indicators is a key type or application within hse performance monitoring. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Project KPI', detail: 'Project KPI is a key type or application within hse performance monitoring. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Contractor KPI', detail: 'Contractor KPI is a key type or application within hse performance monitoring. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'High-Risk KPI', detail: 'High-Risk KPI is a key type or application within hse performance monitoring. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'KPI', detail: 'KPI is a key component or control item for hse performance monitoring. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Observation', detail: 'Observation is a key component or control item for hse performance monitoring. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Inspection Rate', detail: 'Inspection Rate is a key component or control item for hse performance monitoring. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Training Rate', detail: 'Training Rate is a key component or control item for hse performance monitoring. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Action Closure', detail: 'Action Closure is a key component or control item for hse performance monitoring. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Incident Rate', detail: 'Incident Rate is a key component or control item for hse performance monitoring. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Trend Chart', detail: 'Trend Chart is a key component or control item for hse performance monitoring. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control hse performance monitoring through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Measurement of leading and lagging indicators to understand whether HSE controls are working and where improvement is needed.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to hse performance monitoring; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for hse performance monitoring.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that hse performance monitoring does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with hse performance monitoring.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during hse performance monitoring.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting hse performance monitoring change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that hse performance monitoring is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with hse performance monitoring orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant hse performance monitoring equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout hse performance monitoring and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during hse performance monitoring.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual hse performance monitoring activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for hse performance monitoring.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of hse performance monitoring.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for hse performance monitoring.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform hse performance monitoring only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'HSE Performance Monitoring', detail: 'A supervisor identifies a control gap during hse performance monitoring. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of hse performance monitoring.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_building_code': _TopicData(
    title: 'Dubai Building Code & Safety',
    intro: 'Building-code related safety considerations that support minimum health, safety, welfare and building performance requirements in Dubai.',
    types: [
      _DetailItem(title: 'Building Design', detail: 'Building Design is a key type or application within dubai building code & safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Means of Egress', detail: 'Means of Egress is a key type or application within dubai building code & safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Fire / Life Safety', detail: 'Fire / Life Safety is a key type or application within dubai building code & safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Accessibility', detail: 'Accessibility is a key type or application within dubai building code & safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Building Services', detail: 'Building Services is a key type or application within dubai building code & safety. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Egress', detail: 'Egress is a key component or control item for dubai building code & safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Stair', detail: 'Stair is a key component or control item for dubai building code & safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Guardrail', detail: 'Guardrail is a key component or control item for dubai building code & safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Fire Compartment', detail: 'Fire Compartment is a key component or control item for dubai building code & safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Ventilation', detail: 'Ventilation is a key component or control item for dubai building code & safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Emergency Access', detail: 'Emergency Access is a key component or control item for dubai building code & safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Building Services', detail: 'Building Services is a key component or control item for dubai building code & safety. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control dubai building code & safety through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Building-code related safety considerations that support minimum health, safety, welfare and building performance requirements in Dubai.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to dubai building code & safety; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for dubai building code & safety.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that dubai building code & safety does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with dubai building code & safety.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during dubai building code & safety.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting dubai building code & safety change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that dubai building code & safety is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with dubai building code & safety orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant dubai building code & safety equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout dubai building code & safety and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during dubai building code & safety.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual dubai building code & safety activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for dubai building code & safety.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of dubai building code & safety.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for dubai building code & safety.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform dubai building code & safety only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Dubai Building Code & Safety', detail: 'A supervisor identifies a control gap during dubai building code & safety. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of dubai building code & safety.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_permit_to_work': _TopicData(
    title: 'Permit to Work System',
    intro: 'A formal control process for high-risk work requiring defined conditions, isolations, authorisation, communication and close-out.',
    types: [
      _DetailItem(title: 'Hot Work Permit', detail: 'Hot Work Permit is a key type or application within permit to work system. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Confined Space Permit', detail: 'Confined Space Permit is a key type or application within permit to work system. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Electrical Isolation', detail: 'Electrical Isolation is a key type or application within permit to work system. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Excavation Permit', detail: 'Excavation Permit is a key type or application within permit to work system. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Work at Height / Special Permit', detail: 'Work at Height / Special Permit is a key type or application within permit to work system. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Lifting / Critical Work Authorisation', detail: 'Lifting / Critical Work Authorisation is a key type or application within permit to work system. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Permit', detail: 'Permit is a key component or control item for permit to work system. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Isolation', detail: 'Isolation is a key component or control item for permit to work system. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Gas Test', detail: 'Gas Test is a key component or control item for permit to work system. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Authorised Person', detail: 'Authorised Person is a key component or control item for permit to work system. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Permit Receiver', detail: 'Permit Receiver is a key component or control item for permit to work system. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Display Point', detail: 'Display Point is a key component or control item for permit to work system. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Suspension', detail: 'Suspension is a key component or control item for permit to work system. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Close-Out', detail: 'Close-Out is a key component or control item for permit to work system. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Formal authorisation and control of high-risk work through defined conditions, isolations, testing, communication and close-out.'),
        _DetailItem(title: 'Scope', detail: 'Apply permit to work system across planning, execution, inspection, supervision and close-out.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Core requirement', detail: 'Each permit identifies the work, location, hazards, controls, validity, isolations and responsible persons.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for permit to work system.'),
        _DetailItem(title: 'Limits', detail: 'Follow approved procedures, equipment/system instructions and project-specific limits for permit to work system.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary hazards', detail: 'Permit mismatch, expired permit, incomplete isolation, poor handover and work outside permit scope.'),
        _DetailItem(title: 'Interface hazards', detail: 'Consider people, plant, access, temporary works and simultaneous operations affecting permit to work system.'),
        _DetailItem(title: 'Change', detail: 'Review controls when conditions affecting permit to work system change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Control measures', detail: 'Verify conditions at site, display/communicate permit status, suspend on change and close only after work is made safe.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk of permit to work system.'),
        _DetailItem(title: 'Communication', detail: 'Brief affected personnel on the controls for permit to work system before exposure.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-start', detail: 'Inspect the relevant area, equipment and controls before permit to work system begins.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions during permit to work system and after changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before restart.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical failure', detail: 'Stop for expired/invalid permit, changed conditions, failed isolation, failed gas test or work outside scope.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when permit to work system cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Changed conditions', detail: 'Pause and reassess when the actual permit to work system activity differs materially from the plan.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for permit to work system.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of permit to work system.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for permit to work system.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow method', detail: 'Perform permit to work system only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report hazards, defects and changes affecting permit to work system.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Response', detail: 'Use the project emergency arrangements relevant to permit to work system.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Permit to Work System', detail: 'A control gap is identified during permit to work system. The task is paused, the area is made safe, the responsible person corrects the condition and the work is rechecked before restart.'),
        _DetailItem(title: 'Verification', detail: 'HSE verifies the corrective action and records the learning related to permit to work system.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of permit to work system.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
      'Types / Systems': [
        _DetailItem(title: 'Hot Work Permit', detail: 'Controls ignition-producing work where formal permit control is required.'),
        _DetailItem(title: 'Confined Space Permit', detail: 'Controls entry conditions, isolation, testing, standby and rescue.'),
        _DetailItem(title: 'Excavation Permit', detail: 'Controls excavation hazards and service/interface requirements.'),
        _DetailItem(title: 'Electrical Isolation', detail: 'Controls hazardous electrical energy before work.'),
      ],
      'Components / Key Items': [
        _DetailItem(title: 'Permit', detail: 'Defines the authorised work and required conditions.'),
        _DetailItem(title: 'Isolation', detail: 'Confirms hazardous energy or flow has been controlled.'),
        _DetailItem(title: 'Gas Test', detail: 'Provides atmospheric information where relevant.'),
        _DetailItem(title: 'Close-Out', detail: 'Confirms work is complete, area is safe and permit is formally closed.'),
      ],
    },
  ),
  'dubai_cop_site_establishment': _TopicData(
    title: 'Site Establishment & General Arrangements',
    intro: 'Safe planning of site layout, access, welfare, storage, temporary facilities, boundaries and construction logistics.',
    types: [
      _DetailItem(title: 'Site Mobilisation', detail: 'Site Mobilisation is a key type or application within site establishment & general arrangements. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Site Compound', detail: 'Site Compound is a key type or application within site establishment & general arrangements. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Work Zones', detail: 'Work Zones is a key type or application within site establishment & general arrangements. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Temporary Facilities', detail: 'Temporary Facilities is a key type or application within site establishment & general arrangements. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Site Layout', detail: 'Site Layout is a key component or control item for site establishment & general arrangements. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Gate', detail: 'Gate is a key component or control item for site establishment & general arrangements. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Access Road', detail: 'Access Road is a key component or control item for site establishment & general arrangements. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Welfare Facility', detail: 'Welfare Facility is a key component or control item for site establishment & general arrangements. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Storage Area', detail: 'Storage Area is a key component or control item for site establishment & general arrangements. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Emergency Route', detail: 'Emergency Route is a key component or control item for site establishment & general arrangements. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Lighting', detail: 'Lighting is a key component or control item for site establishment & general arrangements. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Drainage', detail: 'Drainage is a key component or control item for site establishment & general arrangements. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control site establishment & general arrangements through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Safe planning of site layout, access, welfare, storage, temporary facilities, boundaries and construction logistics.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to site establishment & general arrangements; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for site establishment & general arrangements.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that site establishment & general arrangements does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with site establishment & general arrangements.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during site establishment & general arrangements.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting site establishment & general arrangements change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that site establishment & general arrangements is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with site establishment & general arrangements orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant site establishment & general arrangements equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout site establishment & general arrangements and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during site establishment & general arrangements.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual site establishment & general arrangements activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for site establishment & general arrangements.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of site establishment & general arrangements.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for site establishment & general arrangements.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform site establishment & general arrangements only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Site Establishment & General Arrangements', detail: 'A supervisor identifies a control gap during site establishment & general arrangements. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of site establishment & general arrangements.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_cop_public_protection': _TopicData(
    title: 'Site Security & Public Protection',
    intro: 'Controls to prevent unauthorised entry and protect the public from construction hazards, falling objects, vehicles and unsafe interfaces.',
    types: [
      _DetailItem(title: 'Perimeter Control', detail: 'Perimeter Control is a key type or application within site security & public protection. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Public Interface', detail: 'Public Interface is a key type or application within site security & public protection. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Pedestrian Protection', detail: 'Pedestrian Protection is a key type or application within site security & public protection. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Delivery Interface', detail: 'Delivery Interface is a key type or application within site security & public protection. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Hoarding', detail: 'Hoarding is a key component or control item for site security & public protection. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Gate', detail: 'Gate is a key component or control item for site security & public protection. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Security', detail: 'Security is a key component or control item for site security & public protection. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Covered Walkway', detail: 'Covered Walkway is a key component or control item for site security & public protection. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Barricade', detail: 'Barricade is a key component or control item for site security & public protection. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Warning Sign', detail: 'Warning Sign is a key component or control item for site security & public protection. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Exclusion Zone', detail: 'Exclusion Zone is a key component or control item for site security & public protection. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Traffic Marshal', detail: 'Traffic Marshal is a key component or control item for site security & public protection. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control site security & public protection through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Controls to prevent unauthorised entry and protect the public from construction hazards, falling objects, vehicles and unsafe interfaces.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to site security & public protection; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for site security & public protection.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that site security & public protection does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with site security & public protection.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during site security & public protection.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting site security & public protection change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that site security & public protection is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with site security & public protection orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant site security & public protection equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout site security & public protection and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during site security & public protection.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual site security & public protection activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for site security & public protection.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of site security & public protection.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for site security & public protection.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform site security & public protection only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Site Security & Public Protection', detail: 'A supervisor identifies a control gap during site security & public protection. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of site security & public protection.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_cop_access_housekeeping': _TopicData(
    title: 'Access, Egress & Housekeeping',
    intro: 'Maintaining clear, stable and adequately controlled routes, stairs, platforms and work areas free from preventable obstructions.',
    types: [
      _DetailItem(title: 'Pedestrian Access', detail: 'Pedestrian Access is a key type or application within access, egress & housekeeping. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Emergency Egress', detail: 'Emergency Egress is a key type or application within access, egress & housekeeping. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Workface Access', detail: 'Workface Access is a key type or application within access, egress & housekeeping. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Material Route', detail: 'Material Route is a key type or application within access, egress & housekeeping. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Stairway', detail: 'Stairway is a key component or control item for access, egress & housekeeping. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Walkway', detail: 'Walkway is a key component or control item for access, egress & housekeeping. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Ramp', detail: 'Ramp is a key component or control item for access, egress & housekeeping. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Handrail', detail: 'Handrail is a key component or control item for access, egress & housekeeping. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Lighting', detail: 'Lighting is a key component or control item for access, egress & housekeeping. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Housekeeping Zone', detail: 'Housekeeping Zone is a key component or control item for access, egress & housekeeping. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Access Gate', detail: 'Access Gate is a key component or control item for access, egress & housekeeping. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Trip Hazard', detail: 'Trip Hazard is a key component or control item for access, egress & housekeeping. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control access, egress & housekeeping through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Maintaining clear, stable and adequately controlled routes, stairs, platforms and work areas free from preventable obstructions.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to access, egress & housekeeping; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for access, egress & housekeeping.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that access, egress & housekeeping does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with access, egress & housekeeping.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during access, egress & housekeeping.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting access, egress & housekeeping change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that access, egress & housekeeping is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with access, egress & housekeeping orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant access, egress & housekeeping equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout access, egress & housekeeping and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during access, egress & housekeeping.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual access, egress & housekeeping activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for access, egress & housekeeping.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of access, egress & housekeeping.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for access, egress & housekeeping.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform access, egress & housekeeping only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Access, Egress & Housekeeping', detail: 'A supervisor identifies a control gap during access, egress & housekeeping. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of access, egress & housekeeping.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_cop_welfare_facilities': _TopicData(
    title: 'Worker Welfare & Site Facilities',
    intro: 'Provision and maintenance of suitable welfare, hygiene, drinking water, rest and related facilities for construction personnel.',
    types: [
      _DetailItem(title: 'Welfare Area', detail: 'Welfare Area is a key type or application within worker welfare & site facilities. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Rest Area', detail: 'Rest Area is a key type or application within worker welfare & site facilities. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Drinking Water', detail: 'Drinking Water is a key type or application within worker welfare & site facilities. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Sanitation', detail: 'Sanitation is a key type or application within worker welfare & site facilities. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Changing Area', detail: 'Changing Area is a key type or application within worker welfare & site facilities. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Toilet', detail: 'Toilet is a key component or control item for worker welfare & site facilities. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Wash Facility', detail: 'Wash Facility is a key component or control item for worker welfare & site facilities. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Drinking Water', detail: 'Drinking Water is a key component or control item for worker welfare & site facilities. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Rest Shelter', detail: 'Rest Shelter is a key component or control item for worker welfare & site facilities. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Canteen', detail: 'Canteen is a key component or control item for worker welfare & site facilities. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'First Aid Facility', detail: 'First Aid Facility is a key component or control item for worker welfare & site facilities. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Waste Bin', detail: 'Waste Bin is a key component or control item for worker welfare & site facilities. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control worker welfare & site facilities through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Provision and maintenance of suitable welfare, hygiene, drinking water, rest and related facilities for construction personnel.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to worker welfare & site facilities; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for worker welfare & site facilities.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that worker welfare & site facilities does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with worker welfare & site facilities.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during worker welfare & site facilities.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting worker welfare & site facilities change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that worker welfare & site facilities is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with worker welfare & site facilities orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant worker welfare & site facilities equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout worker welfare & site facilities and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during worker welfare & site facilities.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual worker welfare & site facilities activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for worker welfare & site facilities.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of worker welfare & site facilities.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for worker welfare & site facilities.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform worker welfare & site facilities only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Worker Welfare & Site Facilities', detail: 'A supervisor identifies a control gap during worker welfare & site facilities. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of worker welfare & site facilities.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_cop_material_storage': _TopicData(
    title: 'Material Storage & Handling',
    intro: 'Safe receipt, stacking, storage, movement and handling of construction materials to prevent collapse, struck-by events, manual-handling injuries and fire hazards.',
    types: [
      _DetailItem(title: 'General Storage', detail: 'General Storage is a key type or application within material storage & handling. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Pipe Storage', detail: 'Pipe Storage is a key type or application within material storage & handling. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Sheet / Panel Storage', detail: 'Sheet / Panel Storage is a key type or application within material storage & handling. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Chemical Storage', detail: 'Chemical Storage is a key type or application within material storage & handling. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Cylinder Storage', detail: 'Cylinder Storage is a key type or application within material storage & handling. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Laydown Area', detail: 'Laydown Area is a key type or application within material storage & handling. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Rack', detail: 'Rack is a key component or control item for material storage & handling. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Pallet', detail: 'Pallet is a key component or control item for material storage & handling. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Chock', detail: 'Chock is a key component or control item for material storage & handling. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Bund', detail: 'Bund is a key component or control item for material storage & handling. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Cylinder Cage', detail: 'Cylinder Cage is a key component or control item for material storage & handling. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Forklift', detail: 'Forklift is a key component or control item for material storage & handling. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Manual Handling Aid', detail: 'Manual Handling Aid is a key component or control item for material storage & handling. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Storage Sign', detail: 'Storage Sign is a key component or control item for material storage & handling. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control material storage & handling through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Safe receipt, stacking, storage, movement and handling of construction materials to prevent collapse, struck-by events, manual-handling injuries and fire hazards.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to material storage & handling; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for material storage & handling.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that material storage & handling does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with material storage & handling.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during material storage & handling.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting material storage & handling change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that material storage & handling is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with material storage & handling orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant material storage & handling equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout material storage & handling and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during material storage & handling.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual material storage & handling activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for material storage & handling.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of material storage & handling.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for material storage & handling.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform material storage & handling only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Material Storage & Handling', detail: 'A supervisor identifies a control gap during material storage & handling. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of material storage & handling.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_cop_formwork_falsework': _TopicData(
    title: 'Formwork, Falsework & Temporary Support',
    intro: 'Planning and control of temporary support systems that carry construction loads until the permanent structure can safely take them.',
    types: [
      _DetailItem(title: 'Wall Formwork', detail: 'Wall Formwork is a key type or application within formwork, falsework & temporary support. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Slab Formwork', detail: 'Slab Formwork is a key type or application within formwork, falsework & temporary support. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Falsework', detail: 'Falsework is a key type or application within formwork, falsework & temporary support. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Propping', detail: 'Propping is a key type or application within formwork, falsework & temporary support. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Shoring', detail: 'Shoring is a key type or application within formwork, falsework & temporary support. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Reshoring', detail: 'Reshoring is a key type or application within formwork, falsework & temporary support. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Formwork Panel', detail: 'Formwork Panel is a key component or control item for formwork, falsework & temporary support. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Prop', detail: 'Prop is a key component or control item for formwork, falsework & temporary support. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Sole Plate', detail: 'Sole Plate is a key component or control item for formwork, falsework & temporary support. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Brace', detail: 'Brace is a key component or control item for formwork, falsework & temporary support. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Tie Rod', detail: 'Tie Rod is a key component or control item for formwork, falsework & temporary support. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Platform', detail: 'Platform is a key component or control item for formwork, falsework & temporary support. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Access', detail: 'Access is a key component or control item for formwork, falsework & temporary support. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Inspection Hold Point', detail: 'Inspection Hold Point is a key component or control item for formwork, falsework & temporary support. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control formwork, falsework & temporary support through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Planning and control of temporary support systems that carry construction loads until the permanent structure can safely take them.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to formwork, falsework & temporary support; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for formwork, falsework & temporary support.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that formwork, falsework & temporary support does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with formwork, falsework & temporary support.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during formwork, falsework & temporary support.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting formwork, falsework & temporary support change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that formwork, falsework & temporary support is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with formwork, falsework & temporary support orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant formwork, falsework & temporary support equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout formwork, falsework & temporary support and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during formwork, falsework & temporary support.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual formwork, falsework & temporary support activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for formwork, falsework & temporary support.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of formwork, falsework & temporary support.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for formwork, falsework & temporary support.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform formwork, falsework & temporary support only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Formwork, Falsework & Temporary Support', detail: 'A supervisor identifies a control gap during formwork, falsework & temporary support. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of formwork, falsework & temporary support.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_cop_rebar_concrete': _TopicData(
    title: 'Reinforcement, Concrete & Construction Operations',
    intro: 'Controls for reinforcement fixing, concrete placement, pumping, vibration, curing and associated construction activities.',
    types: [
      _DetailItem(title: 'Rebar Fixing', detail: 'Rebar Fixing is a key type or application within reinforcement, concrete & construction operations. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Concrete Pour', detail: 'Concrete Pour is a key type or application within reinforcement, concrete & construction operations. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Concrete Pumping', detail: 'Concrete Pumping is a key type or application within reinforcement, concrete & construction operations. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Vibration', detail: 'Vibration is a key type or application within reinforcement, concrete & construction operations. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Curing', detail: 'Curing is a key type or application within reinforcement, concrete & construction operations. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Formwork Interface', detail: 'Formwork Interface is a key type or application within reinforcement, concrete & construction operations. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Rebar', detail: 'Rebar is a key component or control item for reinforcement, concrete & construction operations. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Coupler', detail: 'Coupler is a key component or control item for reinforcement, concrete & construction operations. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Concrete Pump', detail: 'Concrete Pump is a key component or control item for reinforcement, concrete & construction operations. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Hose', detail: 'Hose is a key component or control item for reinforcement, concrete & construction operations. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Vibrator', detail: 'Vibrator is a key component or control item for reinforcement, concrete & construction operations. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Pour Platform', detail: 'Pour Platform is a key component or control item for reinforcement, concrete & construction operations. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Edge Protection', detail: 'Edge Protection is a key component or control item for reinforcement, concrete & construction operations. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Curing Area', detail: 'Curing Area is a key component or control item for reinforcement, concrete & construction operations. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control reinforcement, concrete & construction operations through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Controls for reinforcement fixing, concrete placement, pumping, vibration, curing and associated construction activities.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to reinforcement, concrete & construction operations; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for reinforcement, concrete & construction operations.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that reinforcement, concrete & construction operations does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with reinforcement, concrete & construction operations.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during reinforcement, concrete & construction operations.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting reinforcement, concrete & construction operations change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that reinforcement, concrete & construction operations is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with reinforcement, concrete & construction operations orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant reinforcement, concrete & construction operations equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout reinforcement, concrete & construction operations and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during reinforcement, concrete & construction operations.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual reinforcement, concrete & construction operations activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for reinforcement, concrete & construction operations.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of reinforcement, concrete & construction operations.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for reinforcement, concrete & construction operations.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform reinforcement, concrete & construction operations only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Reinforcement, Concrete & Construction Operations', detail: 'A supervisor identifies a control gap during reinforcement, concrete & construction operations. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of reinforcement, concrete & construction operations.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_cop_plant_machinery': _TopicData(
    title: 'Plant, Machinery & Guarding',
    intro: 'Safe selection, guarding, operation, maintenance and isolation of construction plant and machinery.',
    types: [
      _DetailItem(title: 'Mobile Plant', detail: 'Mobile Plant is a key type or application within plant, machinery & guarding. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Fixed Machinery', detail: 'Fixed Machinery is a key type or application within plant, machinery & guarding. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Power Tools', detail: 'Power Tools is a key type or application within plant, machinery & guarding. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Material Handling Plant', detail: 'Material Handling Plant is a key type or application within plant, machinery & guarding. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Maintenance Activity', detail: 'Maintenance Activity is a key type or application within plant, machinery & guarding. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Guard', detail: 'Guard is a key component or control item for plant, machinery & guarding. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Emergency Stop', detail: 'Emergency Stop is a key component or control item for plant, machinery & guarding. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Isolation Point', detail: 'Isolation Point is a key component or control item for plant, machinery & guarding. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Interlock', detail: 'Interlock is a key component or control item for plant, machinery & guarding. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Operator Station', detail: 'Operator Station is a key component or control item for plant, machinery & guarding. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Maintenance Access', detail: 'Maintenance Access is a key component or control item for plant, machinery & guarding. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Reverse Alarm', detail: 'Reverse Alarm is a key component or control item for plant, machinery & guarding. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Inspection Record', detail: 'Inspection Record is a key component or control item for plant, machinery & guarding. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control plant, machinery & guarding through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Safe selection, guarding, operation, maintenance and isolation of construction plant and machinery.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to plant, machinery & guarding; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for plant, machinery & guarding.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that plant, machinery & guarding does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with plant, machinery & guarding.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during plant, machinery & guarding.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting plant, machinery & guarding change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that plant, machinery & guarding is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with plant, machinery & guarding orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant plant, machinery & guarding equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout plant, machinery & guarding and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during plant, machinery & guarding.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual plant, machinery & guarding activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for plant, machinery & guarding.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of plant, machinery & guarding.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for plant, machinery & guarding.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform plant, machinery & guarding only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Plant, Machinery & Guarding', detail: 'A supervisor identifies a control gap during plant, machinery & guarding. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of plant, machinery & guarding.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_cop_ladders_mobile_towers': _TopicData(
    title: 'Ladders & Mobile Access Towers',
    intro: 'Safe selection, set-up, use, inspection and maintenance of ladders and mobile access towers for work at height. Dubai Municipality publishes Technical Guidelines 73 and 74 for these subjects.',
    types: [
      _DetailItem(title: 'Single Ladder', detail: 'Single Ladder is a key type or application within ladders & mobile access towers. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Extension Ladder', detail: 'Extension Ladder is a key type or application within ladders & mobile access towers. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Step Ladder', detail: 'Step Ladder is a key type or application within ladders & mobile access towers. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Mobile Access Tower', detail: 'Mobile Access Tower is a key type or application within ladders & mobile access towers. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Tower Assembly / Dismantling', detail: 'Tower Assembly / Dismantling is a key type or application within ladders & mobile access towers. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Ladder', detail: 'Ladder is a key component or control item for ladders & mobile access towers. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Foot', detail: 'Foot is a key component or control item for ladders & mobile access towers. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Rung', detail: 'Rung is a key component or control item for ladders & mobile access towers. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Stabiliser', detail: 'Stabiliser is a key component or control item for ladders & mobile access towers. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Castor', detail: 'Castor is a key component or control item for ladders & mobile access towers. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Platform', detail: 'Platform is a key component or control item for ladders & mobile access towers. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Guardrail', detail: 'Guardrail is a key component or control item for ladders & mobile access towers. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Toe Board', detail: 'Toe Board is a key component or control item for ladders & mobile access towers. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Outrigger', detail: 'Outrigger is a key component or control item for ladders & mobile access towers. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Inspection Status', detail: 'Inspection Status is a key component or control item for ladders & mobile access towers. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Select, set up and use ladders and mobile access towers so that access and elevated work remain stable and protected.'),
        _DetailItem(title: 'Scope', detail: 'Apply ladders & mobile access towers across planning, execution, inspection, supervision and close-out.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Core requirement', detail: 'Choose ladder or tower type based on task, height, duration, reach and environment; follow manufacturer/system requirements.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for ladders & mobile access towers.'),
        _DetailItem(title: 'Limits', detail: 'Follow approved procedures, equipment/system instructions and project-specific limits for ladders & mobile access towers.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary hazards', detail: 'Falls, unstable ladders, movement, overreaching, damaged components and unsafe tower movement.'),
        _DetailItem(title: 'Interface hazards', detail: 'Consider people, plant, access, temporary works and simultaneous operations affecting ladders & mobile access towers.'),
        _DetailItem(title: 'Change', detail: 'Review controls when conditions affecting ladders & mobile access towers change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Control measures', detail: 'Inspect before use, set on suitable surfaces, secure/stabilise, maintain three-point contact where applicable and lock tower castors during use.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk of ladders & mobile access towers.'),
        _DetailItem(title: 'Communication', detail: 'Brief affected personnel on the controls for ladders & mobile access towers before exposure.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-start', detail: 'Inspect the relevant area, equipment and controls before ladders & mobile access towers begins.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions during ladders & mobile access towers and after changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before restart.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical failure', detail: 'Stop for damaged equipment, unstable setup, missing protection, unsafe movement or unsuitable conditions.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when ladders & mobile access towers cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Changed conditions', detail: 'Pause and reassess when the actual ladders & mobile access towers activity differs materially from the plan.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for ladders & mobile access towers.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of ladders & mobile access towers.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for ladders & mobile access towers.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow method', detail: 'Perform ladders & mobile access towers only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report hazards, defects and changes affecting ladders & mobile access towers.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Response', detail: 'Use the project emergency arrangements relevant to ladders & mobile access towers.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Ladders & Mobile Access Towers', detail: 'A control gap is identified during ladders & mobile access towers. The task is paused, the area is made safe, the responsible person corrects the condition and the work is rechecked before restart.'),
        _DetailItem(title: 'Verification', detail: 'HSE verifies the corrective action and records the learning related to ladders & mobile access towers.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of ladders & mobile access towers.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
      'Types / Systems': [
        _DetailItem(title: 'Single Ladder', detail: 'Portable ladder for suitable short-duration tasks and access.'),
        _DetailItem(title: 'Extension Ladder', detail: 'Adjustable-length ladder requiring secure setup and suitable use.'),
        _DetailItem(title: 'Step Ladder', detail: 'Self-supporting ladder used on stable surfaces.'),
        _DetailItem(title: 'Mobile Access Tower', detail: 'Prefabricated tower used for elevated access and work within its approved configuration.'),
      ],
      'Components / Key Items': [
        _DetailItem(title: 'Rung / Step', detail: 'Provides foot placement and must remain serviceable.'),
        _DetailItem(title: 'Stabiliser', detail: 'Improves stability where required by the equipment/system.'),
        _DetailItem(title: 'Castor', detail: 'Allows tower movement only when designed and controlled for it.'),
        _DetailItem(title: 'Platform / Guardrail', detail: 'Provides protected working position on a tower.'),
      ],
    },
  ),
  'dubai_cop_fire_emergency': _TopicData(
    title: 'Fire Prevention & Emergency Arrangements',
    intro: 'Controls for ignition sources, combustible materials, temporary fire protection, emergency routes and fire response on construction sites.',
    types: [
      _DetailItem(title: 'Hot Work Fire Control', detail: 'Hot Work Fire Control is a key type or application within fire prevention & emergency arrangements. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Temporary Electrical Fire Risk', detail: 'Temporary Electrical Fire Risk is a key type or application within fire prevention & emergency arrangements. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Fuel / Gas Storage', detail: 'Fuel / Gas Storage is a key type or application within fire prevention & emergency arrangements. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Construction Fire Emergency', detail: 'Construction Fire Emergency is a key type or application within fire prevention & emergency arrangements. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Fire Extinguisher', detail: 'Fire Extinguisher is a key component or control item for fire prevention & emergency arrangements. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Fire Point', detail: 'Fire Point is a key component or control item for fire prevention & emergency arrangements. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Fire Watch', detail: 'Fire Watch is a key component or control item for fire prevention & emergency arrangements. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Gas Cylinder', detail: 'Gas Cylinder is a key component or control item for fire prevention & emergency arrangements. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Fuel Store', detail: 'Fuel Store is a key component or control item for fire prevention & emergency arrangements. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Emergency Exit', detail: 'Emergency Exit is a key component or control item for fire prevention & emergency arrangements. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Alarm', detail: 'Alarm is a key component or control item for fire prevention & emergency arrangements. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Access Route', detail: 'Access Route is a key component or control item for fire prevention & emergency arrangements. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control fire prevention & emergency arrangements through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Controls for ignition sources, combustible materials, temporary fire protection, emergency routes and fire response on construction sites.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to fire prevention & emergency arrangements; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for fire prevention & emergency arrangements.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that fire prevention & emergency arrangements does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with fire prevention & emergency arrangements.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during fire prevention & emergency arrangements.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting fire prevention & emergency arrangements change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that fire prevention & emergency arrangements is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with fire prevention & emergency arrangements orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant fire prevention & emergency arrangements equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout fire prevention & emergency arrangements and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during fire prevention & emergency arrangements.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual fire prevention & emergency arrangements activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for fire prevention & emergency arrangements.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of fire prevention & emergency arrangements.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for fire prevention & emergency arrangements.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform fire prevention & emergency arrangements only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Fire Prevention & Emergency Arrangements', detail: 'A supervisor identifies a control gap during fire prevention & emergency arrangements. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of fire prevention & emergency arrangements.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_cop_signs_barricading': _TopicData(
    title: 'Safety Signs, Barricading & Exclusion Zones',
    intro: 'Use of signs, barriers and controlled areas to communicate hazards and prevent people entering unsafe zones.',
    types: [
      _DetailItem(title: 'Danger Zone', detail: 'Danger Zone is a key type or application within safety signs, barricading & exclusion zones. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Pedestrian Diversion', detail: 'Pedestrian Diversion is a key type or application within safety signs, barricading & exclusion zones. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Lifting Exclusion Zone', detail: 'Lifting Exclusion Zone is a key type or application within safety signs, barricading & exclusion zones. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Excavation Barricade', detail: 'Excavation Barricade is a key type or application within safety signs, barricading & exclusion zones. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Hot Work Zone', detail: 'Hot Work Zone is a key type or application within safety signs, barricading & exclusion zones. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Warning Sign', detail: 'Warning Sign is a key component or control item for safety signs, barricading & exclusion zones. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Mandatory Sign', detail: 'Mandatory Sign is a key component or control item for safety signs, barricading & exclusion zones. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Barrier', detail: 'Barrier is a key component or control item for safety signs, barricading & exclusion zones. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Bollard', detail: 'Bollard is a key component or control item for safety signs, barricading & exclusion zones. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Caution Tape', detail: 'Caution Tape is a key component or control item for safety signs, barricading & exclusion zones. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Gate', detail: 'Gate is a key component or control item for safety signs, barricading & exclusion zones. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Exclusion Zone', detail: 'Exclusion Zone is a key component or control item for safety signs, barricading & exclusion zones. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Signage Board', detail: 'Signage Board is a key component or control item for safety signs, barricading & exclusion zones. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Control safety signs, barricading & exclusion zones through planned selection, competent execution, inspection, supervision and corrective action.'),
        _DetailItem(title: 'Scope', detail: 'Use of signs, barriers and controlled areas to communicate hazards and prevent people entering unsafe zones.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Planning', detail: 'Apply the requirements of the approved design/procedure, equipment instructions and project controls relevant to safety signs, barricading & exclusion zones; verify critical limits before work.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for safety signs, barricading & exclusion zones.'),
        _DetailItem(title: 'Interfaces', detail: 'Coordinate adjacent activities and shared areas so that safety signs, barricading & exclusion zones does not create uncontrolled risk for others.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary risks', detail: 'Key risks include unsafe setup, unsuitable equipment, uncontrolled interfaces, human error, poor housekeeping and changing site conditions associated with safety signs, barricading & exclusion zones.'),
        _DetailItem(title: 'Interface risk', detail: 'Consider interactions with people, plant, temporary works, access and other activities during safety signs, barricading & exclusion zones.'),
        _DetailItem(title: 'Change', detail: 'Review controls when sequence, equipment, weather or site conditions affecting safety signs, barricading & exclusion zones change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Planning', detail: 'Use risk assessment, competent personnel, suitable equipment, defined work sequence, exclusion/segregation where needed, supervision and verification.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk and verify that safety signs, barricading & exclusion zones is being performed as planned.'),
        _DetailItem(title: 'Housekeeping', detail: 'Keep the work area, access routes and equipment associated with safety signs, barricading & exclusion zones orderly and free of preventable hazards.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-use / pre-start', detail: 'Inspect the relevant safety signs, barricading & exclusion zones equipment, area and controls before exposure.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions throughout safety signs, barricading & exclusion zones and after relevant changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before normal use resumes.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical control failure', detail: 'Stop affected work when a critical control is missing, equipment is defective, conditions change materially or the work cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when a condition creates unacceptable risk to people, property or the public during safety signs, barricading & exclusion zones.'),
        _DetailItem(title: 'Change', detail: 'Pause and reassess when the actual safety signs, barricading & exclusion zones activity differs materially from the approved method.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for safety signs, barricading & exclusion zones.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of safety signs, barricading & exclusion zones.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for safety signs, barricading & exclusion zones.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow the method', detail: 'Perform safety signs, barricading & exclusion zones only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report defects, hazards, near misses and changes immediately.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour around the work.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Rescue / medical', detail: 'Use the project emergency arrangements and trained responders appropriate to the event.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Safety Signs, Barricading & Exclusion Zones', detail: 'A supervisor identifies a control gap during safety signs, barricading & exclusion zones. The task is paused, the area is made safe, a competent person reviews the condition, the required control is restored and the work is rechecked before restart.'),
        _DetailItem(title: 'HSE verification', detail: 'The HSE team confirms the corrective action and records the learning for future work.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of safety signs, barricading & exclusion zones.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
    },
  ),
  'dubai_cop_lighting_weather': _TopicData(
    title: 'Construction Lighting, Weather & Visibility',
    intro: 'Controls for lighting, visibility, wind, rain, dust, heat and other environmental conditions that can affect safe construction operations.',
    types: [
      _DetailItem(title: 'Day Work', detail: 'Day Work is a key type or application within construction lighting, weather & visibility. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Night Work', detail: 'Night Work is a key type or application within construction lighting, weather & visibility. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Poor Visibility', detail: 'Poor Visibility is a key type or application within construction lighting, weather & visibility. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'High Wind', detail: 'High Wind is a key type or application within construction lighting, weather & visibility. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Dust / Sand Conditions', detail: 'Dust / Sand Conditions is a key type or application within construction lighting, weather & visibility. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
      _DetailItem(title: 'Weather Shutdown', detail: 'Weather Shutdown is a key type or application within construction lighting, weather & visibility. Its selection and use should match the task, risk assessment, approved method and applicable equipment or system requirements.'),
    ],
    items: [
      _DetailItem(title: 'Lighting Tower', detail: 'Lighting Tower is a key component or control item for construction lighting, weather & visibility. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Task Light', detail: 'Task Light is a key component or control item for construction lighting, weather & visibility. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Emergency Light', detail: 'Emergency Light is a key component or control item for construction lighting, weather & visibility. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Wind Monitoring', detail: 'Wind Monitoring is a key component or control item for construction lighting, weather & visibility. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Visibility Check', detail: 'Visibility Check is a key component or control item for construction lighting, weather & visibility. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Weather Alert', detail: 'Weather Alert is a key component or control item for construction lighting, weather & visibility. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
      _DetailItem(title: 'Reflective Marking', detail: 'Reflective Marking is a key component or control item for construction lighting, weather & visibility. Its purpose, condition, suitability and use must be checked against the task, approved system and competent-person requirements.'),
    ],
    sections: {
      'Purpose & Scope': [
        _DetailItem(title: 'Purpose', detail: 'Maintain safe construction operations when lighting, wind, heat, dust, rain or visibility changes.'),
        _DetailItem(title: 'Scope', detail: 'Apply construction lighting, weather & visibility across planning, execution, inspection, supervision and close-out.'),
      ],
      'Technical Requirements': [
        _DetailItem(title: 'Core requirement', detail: 'Assess conditions against the task, equipment limits, site controls and project criteria.'),
        _DetailItem(title: 'Competence', detail: 'Use personnel with suitable training, experience and authority for construction lighting, weather & visibility.'),
        _DetailItem(title: 'Limits', detail: 'Follow approved procedures, equipment/system instructions and project-specific limits for construction lighting, weather & visibility.'),
      ],
      'Main Hazards': [
        _DetailItem(title: 'Primary hazards', detail: 'Poor visibility, wind loading, heat stress, dust, slippery surfaces and reduced communication.'),
        _DetailItem(title: 'Interface hazards', detail: 'Consider people, plant, access, temporary works and simultaneous operations affecting construction lighting, weather & visibility.'),
        _DetailItem(title: 'Change', detail: 'Review controls when conditions affecting construction lighting, weather & visibility change.'),
      ],
      'Safety Controls': [
        _DetailItem(title: 'Control measures', detail: 'Provide adequate lighting, monitor weather, secure loose materials and modify or suspend work when required.'),
        _DetailItem(title: 'Supervision', detail: 'Maintain field supervision appropriate to the risk of construction lighting, weather & visibility.'),
        _DetailItem(title: 'Communication', detail: 'Brief affected personnel on the controls for construction lighting, weather & visibility before exposure.'),
      ],
      'Inspection & Verification': [
        _DetailItem(title: 'Pre-start', detail: 'Inspect the relevant area, equipment and controls before construction lighting, weather & visibility begins.'),
        _DetailItem(title: 'Ongoing checks', detail: 'Monitor critical conditions during construction lighting, weather & visibility and after changes.'),
        _DetailItem(title: 'Action closure', detail: 'Correct defects and verify effectiveness before restart.'),
      ],
      'Stop-Work Conditions': [
        _DetailItem(title: 'Critical failure', detail: 'Stop when environmental conditions exceed safe operating limits or compromise visibility/stability.'),
        _DetailItem(title: 'Unsafe condition', detail: 'Stop when construction lighting, weather & visibility cannot be performed within the approved safe system.'),
        _DetailItem(title: 'Changed conditions', detail: 'Pause and reassess when the actual construction lighting, weather & visibility activity differs materially from the plan.'),
      ],
      'Responsibilities': [
        _DetailItem(title: 'Management', detail: 'Provide resources and competent arrangements for construction lighting, weather & visibility.'),
        _DetailItem(title: 'Supervisor', detail: 'Control the workface and verify safe execution of construction lighting, weather & visibility.'),
        _DetailItem(title: 'HSE', detail: 'Monitor compliance and advise on risk controls for construction lighting, weather & visibility.'),
      ],
      'Worker Responsibilities': [
        _DetailItem(title: 'Follow method', detail: 'Perform construction lighting, weather & visibility only within approved instructions and competence.'),
        _DetailItem(title: 'Report', detail: 'Report hazards, defects and changes affecting construction lighting, weather & visibility.'),
        _DetailItem(title: 'Protect others', detail: 'Maintain segregation, housekeeping and safe behaviour.'),
      ],
      'Emergency Response': [
        _DetailItem(title: 'Immediate action', detail: 'Stop the task, raise the alarm and protect the area.'),
        _DetailItem(title: 'Response', detail: 'Use the project emergency arrangements relevant to construction lighting, weather & visibility.'),
        _DetailItem(title: 'Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
      ],
      'Practical Site Example': [
        _DetailItem(title: 'Construction Lighting, Weather & Visibility', detail: 'A control gap is identified during construction lighting, weather & visibility. The task is paused, the area is made safe, the responsible person corrects the condition and the work is rechecked before restart.'),
        _DetailItem(title: 'Verification', detail: 'HSE verifies the corrective action and records the learning related to construction lighting, weather & visibility.'),
      ],
      'Key Learning Points': [
        _DetailItem(title: 'PLAN → CONTROL → INSPECT → ACT', detail: 'Safe execution depends on active control throughout the task.'),
        _DetailItem(title: 'Verify in the field', detail: 'Documentation must match the real conditions of construction lighting, weather & visibility.'),
        _DetailItem(title: 'Stop early', detail: 'Early intervention prevents a control failure becoming an incident.'),
      ],
      'Types / Systems': [
        _DetailItem(title: 'Night Work', detail: 'Requires adequate lighting, visibility and traffic controls.'),
        _DetailItem(title: 'High Wind', detail: 'May affect cranes, scaffolds, loose materials and elevated work.'),
        _DetailItem(title: 'Dust / Sand', detail: 'Can reduce visibility and affect breathing and equipment.'),
        _DetailItem(title: 'Heat / Humidity', detail: 'Can increase heat-stress risk.'),
      ],
      'Components / Key Items': [
        _DetailItem(title: 'Lighting Tower', detail: 'Provides area illumination where fixed lighting is insufficient.'),
        _DetailItem(title: 'Wind Monitoring', detail: 'Used to assess conditions for weather-sensitive activities.'),
        _DetailItem(title: 'Reflective Marking', detail: 'Improves visibility of people, plant and barriers.'),
      ],
    },
  ),
};

class DubaiHseTopicRouter {
  static Widget pageFor(ReferenceTopic topic) => DubaiHseDetailPage(topic: topic);
}
