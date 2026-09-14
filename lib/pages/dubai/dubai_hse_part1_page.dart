import 'package:flutter/material.dart';

import 'dubai_hse_part1_advanced_learning_page.dart';

class DubaiPart1Item {
  final String title;
  final String detail;

  const DubaiPart1Item({
    required this.title,
    required this.detail,
  });
}

class DubaiPart1Section {
  final String title;
  final String content;
  final List<DubaiPart1Item> items;
  final bool initiallyExpanded;

  const DubaiPart1Section({
    required this.title,
    required this.content,
    this.items = const [],
    this.initiallyExpanded = false,
  });
}

class DubaiHsePart1TopicPage extends StatelessWidget {
  final String topicId;

  const DubaiHsePart1TopicPage({
    super.key,
    required this.topicId,
  });

  static const _topics = <String, _Part1Topic>{
    'dubai_construction_safety': _Part1Topic(
      title: 'Dubai Construction Safety Framework',
      subtitle: 'Build Safe • Plan Safe • Control Every Risk',
      description:
          'A practical construction HSE framework covering site organization, risk control, work interfaces, supervision, inspection, emergency readiness and stop-work conditions.',
      icon: Icons.account_balance_rounded,
      sections: _constructionSafety,
    ),
    'dubai_hse_management': _Part1Topic(
      title: 'HSE Management System',
      subtitle: 'Lead • Plan • Implement • Assure',
      description:
          'A practical HSE management structure covering leadership, planning, responsibilities, competence, communication, monitoring, corrective action and continual improvement.',
      icon: Icons.health_and_safety_rounded,
      sections: _hseManagement,
    ),
    'dubai_risk_assessment': _Part1Topic(
      title: 'Health & Safety Risk Assessment',
      subtitle: 'Identify • Assess • Control • Review',
      description:
          'A field-focused risk assessment method for identifying hazards, evaluating risk, selecting controls, communicating them and reviewing them when conditions change.',
      icon: Icons.assessment_rounded,
      sections: _riskAssessment,
    ),
    'dubai_hse_plan': _Part1Topic(
      title: 'Construction HSE Plan',
      subtitle: 'Organize • Coordinate • Execute',
      description:
          'A project-level HSE planning structure connecting legal and project requirements with risk assessment, method statements, emergency response, welfare, inspection and performance monitoring.',
      icon: Icons.description_rounded,
      sections: _hsePlan,
    ),
    'dubai_work_at_height': _Part1Topic(
      title: 'Work at Height',
      subtitle: 'Plan Safe • Prevent Falls • Rescue',
      description:
          'A practical work-at-height framework covering access, platforms, scaffolds, ladders, fall prevention, fall protection, dropped objects, inspection and rescue.',
      icon: Icons.height_rounded,
      sections: _workAtHeight,
    ),
    'dubai_confined_space': _Part1Topic(
      title: 'Confined Space Entry',
      subtitle: 'Permit • Test • Isolate • Monitor • Rescue',
      description:
          'A practical confined-space control system covering entry assessment, permit, atmospheric testing, isolation, ventilation, communication, standby and emergency rescue.',
      icon: Icons.meeting_room_rounded,
      sections: _confinedSpace,
    ),
    'dubai_electrical': _Part1Topic(
      title: 'Electrical Safety',
      subtitle: 'Isolate • Verify • Protect',
      description:
          'A practical electrical safety framework covering electrical hazards, isolation, verification, temporary power, tools, inspections, competent persons and emergency response.',
      icon: Icons.electrical_services_rounded,
      sections: _electrical,
    ),
  };

  static const _constructionSafety = <DubaiPart1Section>[
    DubaiPart1Section(
      title: '1. Introduction — Construction Safety Framework',
      initiallyExpanded: true,
      content:
          'A construction safety framework establishes how a project identifies hazards, plans work, assigns responsibility, controls interfaces and verifies that work is carried out safely.',
      items: [
        DubaiPart1Item(
          title: 'Construction Safety Objective',
          detail:
              'Prevent injury, ill health, property damage, uncontrolled work and unsafe interaction between construction activities.',
        ),
        DubaiPart1Item(
          title: 'Site Safety Structure',
          detail:
              'Connect project leadership, construction supervision, HSE, engineering, contractors and workers through clear responsibilities.',
        ),
      ],
    ),
    DubaiPart1Section(
      title: '2. Construction Work Systems',
      content:
          'Different construction activities create different risk profiles. Controls must be matched to the work method and site interface.',
      items: [
        DubaiPart1Item(title: 'Civil & Structural Works', detail: 'Control excavation, formwork, reinforcement, concrete, access, lifting and temporary works interfaces.'),
        DubaiPart1Item(title: 'Building & Finishing Works', detail: 'Control work at height, access, tools, chemicals, electrical systems, housekeeping and simultaneous operations.'),
        DubaiPart1Item(title: 'Infrastructure Works', detail: 'Control traffic, excavation, utilities, plant, public interfaces and changing work fronts.'),
        DubaiPart1Item(title: 'Temporary Works', detail: 'Identify and control temporary structures, supports, platforms, access systems and construction-stage stability.'),
      ],
    ),
    DubaiPart1Section(
      title: '3. Site Safety Components',
      content:
          'The framework becomes effective only when its practical site components are visible and working.',
      items: [
        DubaiPart1Item(title: 'HSE Plan', detail: 'Defines project HSE arrangements, responsibilities, controls and assurance activities.'),
        DubaiPart1Item(title: 'Risk Assessment', detail: 'Identifies hazards and establishes proportionate controls for the actual task.'),
        DubaiPart1Item(title: 'Method Statement', detail: 'Explains the planned safe method and sequence for significant work.'),
        DubaiPart1Item(title: 'Permit to Work', detail: 'Provides controlled authorization where project procedures require formal permits.'),
        DubaiPart1Item(title: 'Inspection & Audit', detail: 'Verifies whether planned controls are implemented and effective.'),
        DubaiPart1Item(title: 'Emergency Arrangement', detail: 'Defines response, communication, access and escalation for foreseeable emergencies.'),
      ],
    ),
    DubaiPart1Section(
      title: '4. Technical & Planning Requirements',
      content:
          'Construction safety planning should reflect the actual project sequence, interfaces, resources, competence and site conditions.',
      items: [
        DubaiPart1Item(title: 'Work Sequence', detail: 'Review the sequence so one activity does not create an uncontrolled hazard for another.'),
        DubaiPart1Item(title: 'Interface Control', detail: 'Coordinate lifting, excavation, work at height, traffic, temporary works and electrical activities.'),
        DubaiPart1Item(title: 'Competence', detail: 'Assign competent personnel and define supervision appropriate to the risk.'),
        DubaiPart1Item(title: 'Change Management', detail: 'Reassess safety controls when design, method, location, workforce or site conditions change.'),
      ],
    ),
    DubaiPart1Section(
      title: '5. Main Construction Hazards',
      content:
          'Typical construction hazards include falls, struck-by events, lifting incidents, collapse, electrical contact, excavation failure, fire and uncontrolled plant movement.',
      items: [
        DubaiPart1Item(title: 'Fall from Height', detail: 'Control open edges, platforms, ladders, scaffolds, fragile surfaces and floor openings.'),
        DubaiPart1Item(title: 'Struck By / Caught Between', detail: 'Control moving plant, suspended loads, stored materials, pinch points and line-of-fire exposure.'),
        DubaiPart1Item(title: 'Collapse', detail: 'Assess excavation, temporary works, formwork, structures and unstable materials.'),
        DubaiPart1Item(title: 'Electrical Contact', detail: 'Control temporary power, tools, cables, isolation and overhead or buried services.'),
      ],
    ),
    DubaiPart1Section(
      title: '6. Safety Controls',
      content:
          'Use the hierarchy of controls and apply task-specific controls rather than relying only on PPE.',
      items: [
        DubaiPart1Item(title: 'Engineering Controls', detail: 'Use physical barriers, guarding, edge protection, isolation and engineered support systems.'),
        DubaiPart1Item(title: 'Administrative Controls', detail: 'Use planning, procedures, permits, supervision, training, toolbox talks and inspections.'),
        DubaiPart1Item(title: 'PPE', detail: 'Select PPE appropriate to the remaining risk and ensure correct use and condition.'),
        DubaiPart1Item(title: 'Exclusion & Barricading', detail: 'Prevent people from entering dangerous areas and make hazards visible.'),
      ],
    ),
    DubaiPart1Section(
      title: '7. Inspection & Verification',
      content:
          'Inspection verifies the actual workplace rather than only the paperwork.',
      items: [
        DubaiPart1Item(title: 'Daily Field Inspection', detail: 'Check critical controls, access, housekeeping, plant, work areas and changing hazards.'),
        DubaiPart1Item(title: 'Corrective Action', detail: 'Assign responsible persons, due dates and verification of effective closeout.'),
        DubaiPart1Item(title: 'Pre-Start Verification', detail: 'Confirm prerequisites are complete before high-risk work begins.'),
      ],
    ),
    DubaiPart1Section(
      title: '8. Stop-Work Conditions',
      content:
          'Stop work when a critical control is absent, ineffective or conditions differ materially from the approved method.',
      items: [
        DubaiPart1Item(title: 'Uncontrolled High-Risk Work', detail: 'Stop when required barriers, isolation, protection or supervision are missing.'),
        DubaiPart1Item(title: 'Unexpected Site Change', detail: 'Stop and reassess when ground, weather, design, access, plant or nearby work changes the risk.'),
        DubaiPart1Item(title: 'Immediate Danger', detail: 'Remove people from the danger area and activate the applicable emergency response.'),
      ],
    ),
    DubaiPart1Section(
      title: '9. Emergency Response',
      content:
          'Emergency readiness must cover alarm, communication, access, first response, rescue interfaces, medical support and escalation.',
      items: [
        DubaiPart1Item(title: 'Raise Alarm', detail: 'Communicate the emergency promptly using the site emergency system.'),
        DubaiPart1Item(title: 'Make Area Safe', detail: 'Isolate or control hazards where this can be done safely and by competent persons.'),
        DubaiPart1Item(title: 'Rescue & Medical Support', detail: 'Activate the planned rescue and medical arrangements without creating secondary casualties.'),
      ],
    ),
    DubaiPart1Section(
      title: '10. HSE Roles — Topic-wise Responsibilities',
      content:
          'Responsibilities are kept together at the end, following the Lifting Operations pattern.',
      items: [
        DubaiPart1Item(title: 'HSE Officer', detail: 'Field verification, observations, immediate intervention, corrective-action follow-up and reporting.'),
        DubaiPart1Item(title: 'HSE Supervisor', detail: 'Day-to-day HSE supervision, coordination, inspections, toolbox verification and escalation.'),
        DubaiPart1Item(title: 'Senior HSE', detail: 'Senior assurance, high-risk review, recurring-risk control and leadership escalation.'),
        DubaiPart1Item(title: 'HSE Coordinator', detail: 'Document coordination, action tracking, communication and contractor interface management.'),
        DubaiPart1Item(title: 'HSE Engineer', detail: 'Technical HSE review of engineering interfaces, temporary works, methods and changing conditions.'),
        DubaiPart1Item(title: 'HSE Manager', detail: 'Project HSE governance, major-risk assurance, management escalation and continual improvement.'),
      ],
    ),
  ];

  static const _hseManagement = <DubaiPart1Section>[
    DubaiPart1Section(title: '1. Introduction — What is an HSE Management System?', initiallyExpanded: true, content: 'An HSE management system organizes leadership, planning, implementation, assurance and improvement so safety is managed as a controlled business process.', items: [
      DubaiPart1Item(title: 'Leadership & Accountability', detail: 'Define who owns HSE performance and how leadership demonstrates visible commitment.'),
      DubaiPart1Item(title: 'System Cycle', detail: 'PLAN → IMPLEMENT → CHECK → CORRECT → IMPROVE.'),
    ]),
    DubaiPart1Section(title: '2. Core HSE Elements', content: 'The system should connect policy, risk management, competence, communication, operational control and assurance.', items: [
      DubaiPart1Item(title: 'HSE Policy', detail: 'Establish project commitments, responsibilities and expectations.'),
      DubaiPart1Item(title: 'Risk Management', detail: 'Translate hazards into controlled work methods.'),
      DubaiPart1Item(title: 'Competence & Training', detail: 'Ensure people have the knowledge, skill and authorization required for their work.'),
      DubaiPart1Item(title: 'Communication', detail: 'Move critical HSE information from planning to the workforce.'),
    ]),
    DubaiPart1Section(title: '3. Planning & Operational Control', content: 'HSE planning must be linked to construction activities and changing site conditions.', items: [
      DubaiPart1Item(title: 'HSE Plan', detail: 'Set project HSE arrangements and resources.'),
      DubaiPart1Item(title: 'Method Statements', detail: 'Define safe execution for significant activities.'),
      DubaiPart1Item(title: 'Permit Controls', detail: 'Control specified high-risk work through authorization and verification.'),
      DubaiPart1Item(title: 'Contractor Control', detail: 'Ensure contractors understand and implement project HSE requirements.'),
    ]),
    DubaiPart1Section(title: '4. Monitoring & Assurance', content: 'Measure whether controls exist, are implemented and are effective.', items: [
      DubaiPart1Item(title: 'Inspection', detail: 'Verify workplace conditions and critical controls.'),
      DubaiPart1Item(title: 'Audit', detail: 'Test system implementation and effectiveness.'),
      DubaiPart1Item(title: 'Performance Indicators', detail: 'Track leading and lagging information relevant to project risk.'),
    ]),
    DubaiPart1Section(title: '5. Incident & Corrective Action', content: 'Learning from events and closing actions prevents recurrence.', items: [
      DubaiPart1Item(title: 'Incident Reporting', detail: 'Report and escalate incidents according to project requirements.'),
      DubaiPart1Item(title: 'Root Cause', detail: 'Look beyond immediate unsafe acts to management and system causes.'),
      DubaiPart1Item(title: 'Action Verification', detail: 'Confirm corrective actions are effective in the field.'),
    ]),
    DubaiPart1Section(title: '6. Emergency Preparedness', content: 'Emergency arrangements should be planned, communicated, tested and improved.', items: [
      DubaiPart1Item(title: 'Emergency Plan', detail: 'Define credible scenarios, roles, communications, access and response.'),
      DubaiPart1Item(title: 'Drills', detail: 'Use exercises to test readiness and identify gaps.'),
      DubaiPart1Item(title: 'Emergency Resources', detail: 'Maintain suitable equipment, contacts and access arrangements.'),
    ]),
    DubaiPart1Section(title: '7. Stop-Work & Escalation', content: 'The system must empower competent personnel to stop unsafe work and escalate unresolved risk.', items: [
      DubaiPart1Item(title: 'Stop Work', detail: 'Suspend work when critical controls fail.'),
      DubaiPart1Item(title: 'Escalation', detail: 'Move unresolved serious risk to the appropriate management level.'),
    ]),
    DubaiPart1Section(title: '8. Practical Site Example', content: 'A contractor begins structural work with multiple simultaneous activities.', items: [
      DubaiPart1Item(title: 'Control Sequence', detail: 'Review risk assessment, method statement, competence, interfaces, inspection and supervision before release.'),
    ]),
    DubaiPart1Section(title: '9. Quick Learning Formula', content: 'LEAD → PLAN → CONTROL → VERIFY → LEARN → IMPROVE.', items: [
      DubaiPart1Item(title: 'LEAD', detail: 'Set expectations and accountability.'),
      DubaiPart1Item(title: 'PLAN', detail: 'Identify risk and define controls.'),
      DubaiPart1Item(title: 'VERIFY', detail: 'Check actual field implementation.'),
      DubaiPart1Item(title: 'IMPROVE', detail: 'Learn from findings and events.'),
    ]),
    DubaiPart1Section(title: '10. HSE Roles — Topic-wise Responsibilities', content: 'Role responsibilities are consolidated here at the end.', items: [
      DubaiPart1Item(title: 'HSE Officer', detail: 'Field monitoring, inspections, observations and immediate corrective-action follow-up.'),
      DubaiPart1Item(title: 'HSE Supervisor', detail: 'Daily supervision, coordination, workforce briefing and escalation.'),
      DubaiPart1Item(title: 'Senior HSE', detail: 'Senior assurance, major-risk review and trend control.'),
      DubaiPart1Item(title: 'HSE Coordinator', detail: 'System coordination, records, actions and interfaces.'),
      DubaiPart1Item(title: 'HSE Engineer', detail: 'Technical HSE review and engineering interface control.'),
      DubaiPart1Item(title: 'HSE Manager', detail: 'Governance, leadership assurance, performance and continual improvement.'),
    ]),
  ];

  static const _riskAssessment = <DubaiPart1Section>[
    DubaiPart1Section(title: '1. Introduction — What is Risk Assessment?', initiallyExpanded: true, content: 'Risk assessment is a structured process to identify hazards, assess risk, select controls and verify that controls remain suitable.', items: [
      DubaiPart1Item(title: 'Risk Assessment Purpose', detail: 'Convert hazard information into practical controls before people are exposed.'),
      DubaiPart1Item(title: 'Dynamic Risk Review', detail: 'Reassess when conditions, people, equipment or methods change.'),
    ]),
    DubaiPart1Section(title: '2. Assessment Types', content: 'Use the assessment level appropriate to the activity and risk.', items: [
      DubaiPart1Item(title: 'Task Risk Assessment', detail: 'Focuses on the specific job and work sequence.'),
      DubaiPart1Item(title: 'Activity / Project Assessment', detail: 'Covers broader construction activities and interfaces.'),
      DubaiPart1Item(title: 'Dynamic Review', detail: 'Checks whether actual conditions remain consistent with the planned assessment.'),
    ]),
    DubaiPart1Section(title: '3. Risk Assessment Components', content: 'A good assessment connects hazard, consequence, likelihood, controls and responsible persons.', items: [
      DubaiPart1Item(title: 'Hazard Identification', detail: 'Identify sources of potential harm and exposed persons.'),
      DubaiPart1Item(title: 'Risk Evaluation', detail: 'Evaluate risk using the project-approved method.'),
      DubaiPart1Item(title: 'Control Selection', detail: 'Prefer higher-level controls before relying on PPE.'),
      DubaiPart1Item(title: 'Residual Risk', detail: 'Confirm remaining risk is acceptable under the project process.'),
    ]),
    DubaiPart1Section(title: '4. Technical Assessment', content: 'Consider work sequence, equipment, energy, environment, interfaces and human factors.', items: [
      DubaiPart1Item(title: 'Energy Sources', detail: 'Identify electrical, mechanical, stored, pressure, gravity and other relevant energy.'),
      DubaiPart1Item(title: 'Interfaces', detail: 'Assess interaction with other workers, plant, structures and public areas.'),
      DubaiPart1Item(title: 'Human Factors', detail: 'Consider competence, fatigue, communication, supervision and foreseeable error.'),
    ]),
    DubaiPart1Section(title: '5. Main Risk Assessment Hazards', content: 'Common construction assessment areas include falls, lifting, excavation, electrical, fire, traffic and occupational health.', items: [
      DubaiPart1Item(title: 'High-Risk Activities', detail: 'Identify activities where loss of control could cause serious harm.'),
      DubaiPart1Item(title: 'Changing Conditions', detail: 'Include weather, work-front changes, design changes and simultaneous operations.'),
    ]),
    DubaiPart1Section(title: '6. Controls & Hierarchy', content: 'Select controls that remove or reduce the hazard as far as reasonably practicable within the approved system.', items: [
      DubaiPart1Item(title: 'Eliminate / Substitute', detail: 'Remove the hazard or use a safer alternative where feasible.'),
      DubaiPart1Item(title: 'Engineering', detail: 'Use physical protection, guarding, isolation or engineered support.'),
      DubaiPart1Item(title: 'Administrative', detail: 'Use procedures, permits, training, supervision and inspections.'),
      DubaiPart1Item(title: 'PPE', detail: 'Protect against residual exposure.'),
    ]),
    DubaiPart1Section(title: '7. Verification', content: 'Controls are not complete until field implementation is checked.', items: [
      DubaiPart1Item(title: 'Pre-Start Verification', detail: 'Confirm critical controls before work starts.'),
      DubaiPart1Item(title: 'Field Observation', detail: 'Compare actual practice with the assessment.'),
      DubaiPart1Item(title: 'Closeout', detail: 'Verify corrective actions and update the assessment where required.'),
    ]),
    DubaiPart1Section(title: '8. Stop-Work Conditions', content: 'Stop when the assessment no longer represents the actual risk or critical controls are missing.', items: [
      DubaiPart1Item(title: 'Unassessed Change', detail: 'Stop and reassess significant changes.'),
      DubaiPart1Item(title: 'Control Failure', detail: 'Stop where critical protection is absent or ineffective.'),
    ]),
    DubaiPart1Section(title: '9. Practical Site Example', content: 'A mobile crane is introduced near an excavation.', items: [
      DubaiPart1Item(title: 'Assessment Logic', detail: 'Assess ground bearing, excavation stability, crane setup, load path, lifting plan, exclusion zone and interfaces before lifting.'),
    ]),
    DubaiPart1Section(title: '10. HSE Roles — Topic-wise Responsibilities', content: 'Role responsibilities are consolidated here at the end.', items: [
      DubaiPart1Item(title: 'HSE Officer', detail: 'Verify field implementation, observations and immediate control of identified hazards.'),
      DubaiPart1Item(title: 'HSE Supervisor', detail: 'Coordinate assessment briefing, field checks and corrective actions.'),
      DubaiPart1Item(title: 'Senior HSE', detail: 'Review significant risks, trends and unresolved high-consequence controls.'),
      DubaiPart1Item(title: 'HSE Coordinator', detail: 'Coordinate assessment records, approvals, revisions and action tracking.'),
      DubaiPart1Item(title: 'HSE Engineer', detail: 'Provide technical risk input for engineering, temporary works and complex interfaces.'),
      DubaiPart1Item(title: 'HSE Manager', detail: 'Provide governance, escalation and assurance for project risk management.'),
    ]),
  ];

  static const _hsePlan = <DubaiPart1Section>[
    DubaiPart1Section(title: '1. Introduction — What is a Construction HSE Plan?', initiallyExpanded: true, content: 'A Construction HSE Plan explains how project HSE requirements will be organized, implemented, monitored and improved throughout construction.', items: [
      DubaiPart1Item(title: 'Purpose', detail: 'Translate project HSE requirements into practical management and field arrangements.'),
      DubaiPart1Item(title: 'Project Lifecycle', detail: 'The plan should evolve when scope, design, sequence, contractors or risks change.'),
    ]),
    DubaiPart1Section(title: '2. HSE Plan Structure', content: 'A professional plan links management controls to actual construction activities.', items: [
      DubaiPart1Item(title: 'Organization & Responsibilities', detail: 'Define HSE roles, authority, competence and reporting lines.'),
      DubaiPart1Item(title: 'Risk Management', detail: 'Set the process for risk assessment and control.'),
      DubaiPart1Item(title: 'Operational Controls', detail: 'Address high-risk work, permits, plant, access, temporary works and interfaces.'),
      DubaiPart1Item(title: 'Emergency', detail: 'Set emergency response, communication and rescue arrangements.'),
    ]),
    DubaiPart1Section(title: '3. Site Control Components', content: 'The plan should address the practical conditions workers encounter.', items: [
      DubaiPart1Item(title: 'Site Establishment', detail: 'Control access, welfare, traffic, storage and site arrangements.'),
      DubaiPart1Item(title: 'Work Fronts', detail: 'Coordinate activities, access and simultaneous operations.'),
      DubaiPart1Item(title: 'Contractors', detail: 'Define prequalification, onboarding, supervision and performance controls.'),
      DubaiPart1Item(title: 'Inspection & Audit', detail: 'Set assurance frequency and action management.'),
    ]),
    DubaiPart1Section(title: '4. Technical Requirements', content: 'Planning must match construction sequence, design information and site constraints.', items: [
      DubaiPart1Item(title: 'Construction Sequence', detail: 'Identify safety-critical stages and prerequisites.'),
      DubaiPart1Item(title: 'Temporary Works', detail: 'Coordinate temporary supports and construction-stage stability.'),
      DubaiPart1Item(title: 'Design Interface', detail: 'Ensure safety assumptions and changes are communicated to construction teams.'),
    ]),
    DubaiPart1Section(title: '5. Main HSE Risks', content: 'The HSE plan should focus resources on the project risk profile.', items: [
      DubaiPart1Item(title: 'High-Risk Activities', detail: 'Include lifting, work at height, excavation, confined space, electrical and hot work as applicable.'),
      DubaiPart1Item(title: 'Occupational Health', detail: 'Address heat, noise, dust, ergonomics and other relevant exposures.'),
      DubaiPart1Item(title: 'Environmental Risk', detail: 'Address waste, spills, dust, noise and other project impacts.'),
    ]),
    DubaiPart1Section(title: '6. Implementation & Communication', content: 'The plan is effective only when the workforce understands the relevant controls.', items: [
      DubaiPart1Item(title: 'Induction', detail: 'Provide project-specific HSE information before site access.'),
      DubaiPart1Item(title: 'Toolbox Talks', detail: 'Communicate task-specific hazards and controls.'),
      DubaiPart1Item(title: 'Notice & Signage', detail: 'Make critical site controls visible.'),
    ]),
    DubaiPart1Section(title: '7. Inspection & Performance', content: 'Use inspections, audits and performance information to verify implementation.', items: [
      DubaiPart1Item(title: 'Leading Indicators', detail: 'Track proactive activities such as inspections, training and action closure.'),
      DubaiPart1Item(title: 'Lagging Indicators', detail: 'Track incidents and other outcome information required by the project.'),
    ]),
    DubaiPart1Section(title: '8. Stop Work & Escalation', content: 'Define authority to stop work and a clear escalation path.', items: [
      DubaiPart1Item(title: 'Critical Control Failure', detail: 'Stop work where a serious uncontrolled risk exists.'),
      DubaiPart1Item(title: 'Management Escalation', detail: 'Escalate unresolved serious risk to the appropriate level.'),
    ]),
    DubaiPart1Section(title: '9. Practical Site Example', content: 'A project moves from structure to façade and MEP works with multiple contractors.', items: [
      DubaiPart1Item(title: 'HSE Plan Update', detail: 'Review new work interfaces, revise risk controls, brief contractors and verify readiness before release.'),
    ]),
    DubaiPart1Section(title: '10. HSE Roles — Topic-wise Responsibilities', content: 'Role responsibilities are consolidated here at the end.', items: [
      DubaiPart1Item(title: 'HSE Officer', detail: 'Verify field implementation and report deviations.'),
      DubaiPart1Item(title: 'HSE Supervisor', detail: 'Supervise daily implementation and coordinate contractors.'),
      DubaiPart1Item(title: 'Senior HSE', detail: 'Assure major-risk controls and escalation.'),
      DubaiPart1Item(title: 'HSE Coordinator', detail: 'Coordinate HSE plan revisions, records and actions.'),
      DubaiPart1Item(title: 'HSE Engineer', detail: 'Review technical interfaces and safety-critical construction stages.'),
      DubaiPart1Item(title: 'HSE Manager', detail: 'Own project-level HSE governance, assurance and continual improvement.'),
    ]),
  ];

  static const _workAtHeight = <DubaiPart1Section>[
    DubaiPart1Section(title: '1. Introduction — What is Work at Height?', initiallyExpanded: true, content: 'Work at height is work where a person could fall from one level to another and suffer injury. The focus is prevention first, then suitable protection and rescue.', items: [
      DubaiPart1Item(title: 'Fall Prevention Principle', detail: 'Avoid exposure where feasible, then use suitable platforms, edge protection and fall-protection systems.'),
      DubaiPart1Item(title: 'Dropped Objects', detail: 'Control tools and materials that could fall onto people below.'),
    ]),
    DubaiPart1Section(title: '2. Access & Work-at-Height Systems', content: 'Select access based on task duration, height, location and risk.', items: [
      DubaiPart1Item(title: 'Scaffold', detail: 'Use suitable designed and inspected scaffold with safe access and edge protection.'),
      DubaiPart1Item(title: 'Mobile Access Tower', detail: 'Use a suitable tower on stable ground and follow its configuration and manufacturer requirements.'),
      DubaiPart1Item(title: 'MEWP', detail: 'Use suitable equipment, competent operators and the required ground, exclusion and emergency controls.'),
      DubaiPart1Item(title: 'Ladder', detail: 'Use ladders only where appropriate and control stability, access and three-point contact.'),
      DubaiPart1Item(title: 'Fall-Arrest System', detail: 'Use suitable equipment with compatible anchorage, clearance and a planned rescue arrangement.'),
    ]),
    DubaiPart1Section(title: '3. Components & Protection', content: 'The protection system must be complete and compatible.', items: [
      DubaiPart1Item(title: 'Guardrail / Handrail', detail: 'Prevent people falling from exposed edges.'),
      DubaiPart1Item(title: 'Toe Board', detail: 'Help prevent materials and tools from falling where required.'),
      DubaiPart1Item(title: 'Harness & Lanyard', detail: 'Use compatible, inspected equipment with a suitable anchorage and fall-clearance assessment.'),
      DubaiPart1Item(title: 'Lifeline / Anchorage', detail: 'Use only suitable, approved systems designed for the intended application.'),
    ]),
    DubaiPart1Section(title: '4. Planning & Technical Requirements', content: 'Plan access, work position, edge protection, weather, rescue and dropped-object controls before starting.', items: [
      DubaiPart1Item(title: 'Task Assessment', detail: 'Assess height, surface, access, duration, tools, weather and fall consequences.'),
      DubaiPart1Item(title: 'Rescue Plan', detail: 'Plan how a fallen or suspended worker will be recovered without creating additional exposure.'),
      DubaiPart1Item(title: 'Clearance', detail: 'For fall-arrest systems, confirm adequate clearance based on the actual equipment and configuration.'),
    ]),
    DubaiPart1Section(title: '5. Main Hazards', content: 'Falls, dropped objects, unstable access equipment, fragile surfaces, weather and rescue failure are key hazards.', items: [
      DubaiPart1Item(title: 'Open Edge / Opening', detail: 'Control exposed edges and floor openings.'),
      DubaiPart1Item(title: 'Fragile Surface', detail: 'Identify and prevent access to surfaces that cannot safely support people.'),
      DubaiPart1Item(title: 'Dropped Objects', detail: 'Secure tools and materials and control areas below.'),
      DubaiPart1Item(title: 'Weather', detail: 'Review wind, rain, lightning, heat and visibility as applicable.'),
    ]),
    DubaiPart1Section(title: '6. Controls', content: 'Use suitable prevention and protection systems matched to the task.', items: [
      DubaiPart1Item(title: 'Collective Protection', detail: 'Prefer guardrails, protected platforms and other collective measures where feasible.'),
      DubaiPart1Item(title: 'Personal Protection', detail: 'Use compatible fall-protection equipment with training, inspection and rescue arrangements.'),
      DubaiPart1Item(title: 'Exclusion Zone', detail: 'Control people below or near overhead work.'),
    ]),
    DubaiPart1Section(title: '7. Inspection', content: 'Inspect access and fall-protection systems before use and after relevant changes or events.', items: [
      DubaiPart1Item(title: 'Scaffold / Tower', detail: 'Verify condition, access, stability and required protection.'),
      DubaiPart1Item(title: 'Harness', detail: 'Check webbing, stitching, hardware and identification before use.'),
      DubaiPart1Item(title: 'Work Area', detail: 'Check openings, edges, housekeeping and dropped-object controls.'),
    ]),
    DubaiPart1Section(title: '8. Stop-Work Conditions', content: 'Stop for missing edge protection, unstable access, defective fall protection, unsafe weather or lack of rescue capability.', items: [
      DubaiPart1Item(title: 'Missing Protection', detail: 'Do not expose workers to an uncontrolled fall hazard.'),
      DubaiPart1Item(title: 'Unsafe Access', detail: 'Stop when access equipment is unstable, defective or unsuitable.'),
      DubaiPart1Item(title: 'No Rescue Arrangement', detail: 'Do not proceed with a system that depends on rescue without a credible rescue plan.'),
    ]),
    DubaiPart1Section(title: '9. Emergency Response', content: 'Respond quickly to prevent secondary injury after a fall.', items: [
      DubaiPart1Item(title: 'Fall Event', detail: 'Raise alarm, secure the area and activate the planned rescue response.'),
      DubaiPart1Item(title: 'Suspension', detail: 'Treat a suspended worker as an emergency and use the planned rescue method.'),
      DubaiPart1Item(title: 'Dropped Object', detail: 'Control the area, account for people and report the event.'),
    ]),
    DubaiPart1Section(title: '10. HSE Roles — Topic-wise Responsibilities', content: 'Role responsibilities are consolidated here at the end.', items: [
      DubaiPart1Item(title: 'HSE Officer', detail: 'Inspect work-at-height controls, intervene on unsafe exposure and verify corrective actions.'),
      DubaiPart1Item(title: 'HSE Supervisor', detail: 'Supervise daily work-at-height controls, briefings and access-system checks.'),
      DubaiPart1Item(title: 'Senior HSE', detail: 'Assure high-risk work-at-height systems and recurring fall-risk trends.'),
      DubaiPart1Item(title: 'HSE Coordinator', detail: 'Coordinate training, inspection records, rescue information and contractor documentation.'),
      DubaiPart1Item(title: 'HSE Engineer', detail: 'Review technical interfaces such as temporary access, anchorage and engineered systems.'),
      DubaiPart1Item(title: 'HSE Manager', detail: 'Set project fall-prevention governance and assure major work-at-height risks.'),
    ]),
  ];

  static const _confinedSpace = <DubaiPart1Section>[
    DubaiPart1Section(title: '1. Introduction — What is Confined Space Entry?', initiallyExpanded: true, content: 'Confined-space work can expose people to atmospheric, engulfment, access, mechanical, electrical and other hazards. Entry requires controlled planning and emergency readiness.', items: [
      DubaiPart1Item(title: 'Entry Principle', detail: 'Avoid entry where feasible; where entry is necessary, establish formal controls before exposure.'),
      DubaiPart1Item(title: 'Atmospheric Hazard', detail: 'Atmospheres may be oxygen-deficient, toxic, flammable or otherwise unsafe.'),
    ]),
    DubaiPart1Section(title: '2. Confined Space Types', content: 'Examples include tanks, chambers, pits, manholes, vessels and other enclosed or restricted areas where specific hazards exist.', items: [
      DubaiPart1Item(title: 'Tank / Vessel', detail: 'Assess residual contents, isolation, atmosphere, access and rescue.'),
      DubaiPart1Item(title: 'Manhole / Chamber', detail: 'Control atmosphere, traffic interface, access and retrieval.'),
      DubaiPart1Item(title: 'Pit / Enclosure', detail: 'Assess gases, oxygen, flooding, access and potential engulfment.'),
    ]),
    DubaiPart1Section(title: '3. Entry Components', content: 'A safe entry system combines permit, isolation, testing, ventilation, communication, standby and rescue.', items: [
      DubaiPart1Item(title: 'Entry Permit', detail: 'Control authorization, hazards, precautions and responsible persons.'),
      DubaiPart1Item(title: 'Gas Detector', detail: 'Use suitable calibrated/tested monitoring equipment operated by competent personnel.'),
      DubaiPart1Item(title: 'Isolation', detail: 'Prevent hazardous energy, flow or material from entering the space.'),
      DubaiPart1Item(title: 'Ventilation', detail: 'Provide suitable ventilation where required by the assessment and work method.'),
      DubaiPart1Item(title: 'Standby Person', detail: 'Maintain required external monitoring and communication.'),
      DubaiPart1Item(title: 'Rescue Equipment', detail: 'Provide equipment and arrangements suitable for the identified rescue scenario.'),
    ]),
    DubaiPart1Section(title: '4. Technical Requirements', content: 'Entry controls must be based on the identified hazards and actual space conditions.', items: [
      DubaiPart1Item(title: 'Atmospheric Testing', detail: 'Test before entry and continue monitoring as required by the assessment and permit.'),
      DubaiPart1Item(title: 'Isolation', detail: 'Isolate process, electrical, mechanical and other hazardous energy or material sources as applicable.'),
      DubaiPart1Item(title: 'Ventilation', detail: 'Control atmospheric conditions without introducing additional hazards.'),
      DubaiPart1Item(title: 'Communication', detail: 'Maintain reliable communication between entrants and the standby person.'),
    ]),
    DubaiPart1Section(title: '5. Main Hazards', content: 'Key hazards include toxic gas, oxygen deficiency, flammable atmosphere, engulfment, flooding, mechanical energy and heat.', items: [
      DubaiPart1Item(title: 'Toxic Atmosphere', detail: 'Identify contaminants and establish suitable testing and controls.'),
      DubaiPart1Item(title: 'Oxygen Deficiency', detail: 'Treat unsafe oxygen levels as an immediate entry hazard.'),
      DubaiPart1Item(title: 'Engulfment / Flooding', detail: 'Prevent uncontrolled material or liquid entry.'),
      DubaiPart1Item(title: 'Mechanical / Electrical Energy', detail: 'Isolate hazardous equipment before entry.'),
    ]),
    DubaiPart1Section(title: '6. Controls', content: 'Use permit, isolation, testing, ventilation, supervision, communication and rescue controls as required.', items: [
      DubaiPart1Item(title: 'Permit Control', detail: 'Do not enter without the required authorization and verification.'),
      DubaiPart1Item(title: 'Continuous Monitoring', detail: 'Monitor atmospheric conditions as required by the risk assessment.'),
      DubaiPart1Item(title: 'Buddy / Standby', detail: 'Maintain external support and communication for the entry.'),
      DubaiPart1Item(title: 'Rescue Readiness', detail: 'Ensure rescue resources are available and suitable before entry.'),
    ]),
    DubaiPart1Section(title: '7. Inspection & Verification', content: 'Verify permit, isolation, testing, equipment and rescue arrangements before entry.', items: [
      DubaiPart1Item(title: 'Permit Check', detail: 'Confirm scope, precautions, testing and authorization.'),
      DubaiPart1Item(title: 'Gas Test', detail: 'Confirm instrument status and required readings before entry.'),
      DubaiPart1Item(title: 'Rescue Equipment', detail: 'Check availability, condition and suitability.'),
    ]),
    DubaiPart1Section(title: '8. Stop-Work Conditions', content: 'Stop entry for unsafe atmosphere, loss of communication, failed isolation, ventilation failure or changing conditions.', items: [
      DubaiPart1Item(title: 'Unsafe Atmosphere', detail: 'Evacuate or prevent entry according to the emergency procedure.'),
      DubaiPart1Item(title: 'Isolation Failure', detail: 'Stop work and restore positive control of hazardous energy or flow.'),
      DubaiPart1Item(title: 'Rescue Unavailable', detail: 'Do not continue an entry without the required rescue capability.'),
    ]),
    DubaiPart1Section(title: '9. Emergency Response', content: 'Confined-space rescue must be planned; unplanned entry by rescuers can create multiple casualties.', items: [
      DubaiPart1Item(title: 'Alarm & Evacuation', detail: 'Raise alarm and evacuate when required by the emergency plan.'),
      DubaiPart1Item(title: 'Non-Entry Rescue', detail: 'Use planned retrieval methods where suitable and safe.'),
      DubaiPart1Item(title: 'Emergency Services', detail: 'Activate site and external emergency support as required.'),
    ]),
    DubaiPart1Section(title: '10. HSE Roles — Topic-wise Responsibilities', content: 'Role responsibilities are consolidated here at the end.', items: [
      DubaiPart1Item(title: 'HSE Officer', detail: 'Verify permit, atmospheric-control, PPE, access and field conditions before and during entry.'),
      DubaiPart1Item(title: 'HSE Supervisor', detail: 'Coordinate field entry controls, briefings, monitoring and stop-work actions.'),
      DubaiPart1Item(title: 'Senior HSE', detail: 'Assure high-risk confined-space controls and emergency readiness.'),
      DubaiPart1Item(title: 'HSE Coordinator', detail: 'Coordinate permits, training, records, rescue information and contractor interfaces.'),
      DubaiPart1Item(title: 'HSE Engineer', detail: 'Review isolation, ventilation, atmosphere and technical interfaces.'),
      DubaiPart1Item(title: 'HSE Manager', detail: 'Provide governance and assurance for confined-space entry and emergency arrangements.'),
    ]),
  ];

  static const _electrical = <DubaiPart1Section>[
    DubaiPart1Section(title: '1. Introduction — Electrical Safety', initiallyExpanded: true, content: 'Electrical safety controls prevent shock, burns, arc events, fire and unintended energization during construction and maintenance.', items: [
      DubaiPart1Item(title: 'Electrical Safety Objective', detail: 'Prevent contact with hazardous energy through isolation, verification, guarding and competent work.'),
      DubaiPart1Item(title: 'De-Energized Principle', detail: 'Where practicable, work should be performed in a safely isolated and verified condition.'),
    ]),
    DubaiPart1Section(title: '2. Electrical Work Systems', content: 'Construction sites include permanent systems, temporary power, tools, generators and distribution equipment.', items: [
      DubaiPart1Item(title: 'Temporary Electrical Distribution', detail: 'Control distribution boards, protection devices, cables, earthing and physical protection.'),
      DubaiPart1Item(title: 'Portable Tools', detail: 'Use suitable inspected tools and control damaged cords, plugs and enclosures.'),
      DubaiPart1Item(title: 'Generators', detail: 'Control fuel, exhaust, electrical connections, earthing and access.'),
      DubaiPart1Item(title: 'Electrical Maintenance', detail: 'Use competent personnel, isolation and verification before work.'),
    ]),
    DubaiPart1Section(title: '3. Electrical Safety Components', content: 'Protection depends on suitable devices and physical controls.', items: [
      DubaiPart1Item(title: 'Isolation Device', detail: 'Provide a means to isolate the relevant energy source.'),
      DubaiPart1Item(title: 'Protective Device', detail: 'Use suitable overcurrent and residual-current protection as applicable.'),
      DubaiPart1Item(title: 'Earthing / Bonding', detail: 'Maintain the required protective arrangements.'),
      DubaiPart1Item(title: 'Cable Protection', detail: 'Protect cables from mechanical damage, water, heat and vehicle movement.'),
      DubaiPart1Item(title: 'Guarding', detail: 'Prevent access to exposed energized parts.'),
    ]),
    DubaiPart1Section(title: '4. Technical Requirements', content: 'Electrical work must be planned around system condition, isolation, competence, protection and environmental exposure.', items: [
      DubaiPart1Item(title: 'Isolation & Lockout', detail: 'Identify and isolate the correct energy source using the project control system.'),
      DubaiPart1Item(title: 'Test Before Touch', detail: 'Verify the condition using suitable equipment and competent personnel before work.'),
      DubaiPart1Item(title: 'Temporary Power', detail: 'Control routing, protection, distribution and inspection.'),
      DubaiPart1Item(title: 'Overhead / Buried Services', detail: 'Identify services and establish safe controls before excavation or plant operation.'),
    ]),
    DubaiPart1Section(title: '5. Main Electrical Hazards', content: 'Shock, arc flash, fire, damaged cables, unexpected energization and service contact are key hazards.', items: [
      DubaiPart1Item(title: 'Electric Shock', detail: 'Prevent contact with energized parts through isolation and guarding.'),
      DubaiPart1Item(title: 'Arc / Thermal Event', detail: 'Control energized work and fault exposure according to the approved system.'),
      DubaiPart1Item(title: 'Fire', detail: 'Control overload, damaged equipment, unsuitable connections and combustible interfaces.'),
      DubaiPart1Item(title: 'Service Strike', detail: 'Identify overhead and underground services before work.'),
    ]),
    DubaiPart1Section(title: '6. Controls', content: 'Use isolation, physical protection, suitable equipment, competent personnel and inspection.', items: [
      DubaiPart1Item(title: 'Lockout / Tagout', detail: 'Prevent unintended energization during controlled work.'),
      DubaiPart1Item(title: 'Guarding', detail: 'Prevent access to energized components.'),
      DubaiPart1Item(title: 'Inspection', detail: 'Remove damaged electrical equipment from service.'),
      DubaiPart1Item(title: 'Work Area Control', detail: 'Control water, access, housekeeping and nearby work.'),
    ]),
    DubaiPart1Section(title: '7. Inspection & Verification', content: 'Verify electrical systems and tools before use and after relevant changes or damage.', items: [
      DubaiPart1Item(title: 'Distribution Board', detail: 'Check condition, protection, labeling, access and physical security.'),
      DubaiPart1Item(title: 'Cables & Plugs', detail: 'Check for damage, unsuitable joints and exposure to mechanical hazards.'),
      DubaiPart1Item(title: 'Portable Tools', detail: 'Verify inspection status and condition before use.'),
    ]),
    DubaiPart1Section(title: '8. Stop-Work Conditions', content: 'Stop for exposed energized parts, failed isolation, damaged equipment, unsafe temporary power or unknown services.', items: [
      DubaiPart1Item(title: 'Failed Isolation', detail: 'Do not proceed until the correct energy source is positively controlled and verified.'),
      DubaiPart1Item(title: 'Damaged Equipment', detail: 'Remove defective tools, cables or equipment from service.'),
      DubaiPart1Item(title: 'Unknown Service', detail: 'Stop excavation or plant work when service information is inadequate.'),
    ]),
    DubaiPart1Section(title: '9. Emergency Response', content: 'Electrical emergencies require isolation, scene control and medical response without creating another casualty.', items: [
      DubaiPart1Item(title: 'Electrical Contact', detail: 'Do not touch a casualty until the electrical hazard is safely isolated.'),
      DubaiPart1Item(title: 'Electrical Fire', detail: 'Raise alarm, isolate if safe and use the site fire response procedure.'),
      DubaiPart1Item(title: 'Medical Response', detail: 'Activate emergency medical support and provide trained first aid/CPR when safe and appropriate.'),
    ]),
    DubaiPart1Section(title: '10. HSE Roles — Topic-wise Responsibilities', content: 'Role responsibilities are consolidated here at the end.', items: [
      DubaiPart1Item(title: 'HSE Officer', detail: 'Monitor temporary power, tool condition, guarding, access and field compliance.'),
      DubaiPart1Item(title: 'HSE Supervisor', detail: 'Supervise daily electrical controls and coordinate corrective actions.'),
      DubaiPart1Item(title: 'Senior HSE', detail: 'Assure high-risk electrical controls, service interfaces and recurring findings.'),
      DubaiPart1Item(title: 'HSE Coordinator', detail: 'Coordinate records, contractor interfaces, training and action tracking.'),
      DubaiPart1Item(title: 'HSE Engineer', detail: 'Review technical electrical interfaces, isolation arrangements and service risks.'),
      DubaiPart1Item(title: 'HSE Manager', detail: 'Provide project-level electrical safety governance, escalation and assurance.'),
    ]),
  ];

  static const _topics9to10 = <String, _Part1Topic>{
    'dubai_confined_space': _Part1Topic(
      title: 'Confined Space Entry',
      subtitle: 'Permit • Test • Isolate • Monitor • Rescue',
      description: 'A practical confined-space control system covering entry assessment, permit, atmospheric testing, isolation, ventilation, communication, standby and emergency rescue.',
      icon: Icons.meeting_room_rounded,
      sections: _confinedSpace,
    ),
    'dubai_electrical': _Part1Topic(
      title: 'Electrical Safety',
      subtitle: 'Isolate • Verify • Protect',
      description: 'A practical electrical safety framework covering electrical hazards, isolation, verification, temporary power, tools, inspections, competent persons and emergency response.',
      icon: Icons.electrical_services_rounded,
      sections: _electrical,
    ),
  };

  static _Part1Topic? _findTopic(String id) {
    return _topics[id] ?? _topics9to10[id];
  }

  @override
  Widget build(BuildContext context) {
    final topic = _findTopic(topicId);
    if (topic == null) {
      return const Scaffold(
        body: Center(child: Text('Dubai HSE topic not found')),
      );
    }

    return _Part1TopicShell(topic: topic);
  }
}

class _Part1Topic {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final List<DubaiPart1Section> sections;

  const _Part1Topic({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.sections,
  });
}

class _Part1TopicShell extends StatelessWidget {
  final _Part1Topic topic;

  const _Part1TopicShell({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAF4F0),
        foregroundColor: const Color(0xFF17231F),
        elevation: 0,
        title: Text(
          topic.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          _HeaderCard(topic: topic),
          const SizedBox(height: 14),
          ...topic.sections.map(
            (section) => _SectionCard(
              section: section,
              topicTitle: topic.title,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final _Part1Topic topic;

  const _HeaderCard({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            colors: [Color(0xFFE8F6F0), Color(0xFFF8FBFA)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B7653),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Icon(topic.icon, color: Colors.white, size: 31),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    topic.title,
                    style: const TextStyle(
                      fontSize: 25,
                      height: 1.12,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF10231D),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              topic.subtitle.toUpperCase(),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: .5,
                color: Color(0xFF075C45),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              topic.description,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final DubaiPart1Section section;
  final String topicTitle;

  const _SectionCard({
    required this.section,
    required this.topicTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        initiallyExpanded: section.initiallyExpanded,
        tilePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 17),
        iconColor: const Color(0xFF237A5C),
        title: Text(
          section.title,
          style: const TextStyle(fontSize: 18.5, fontWeight: FontWeight.w800),
        ),
        children: [
          if (section.content.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
              child: Text(
                section.content,
                style: const TextStyle(fontSize: 15.5, height: 1.5),
              ),
            ),
          ...section.items.map((item) => _DetailItemTile(
                item: item,
                topicTitle: topicTitle,
                sectionTitle: section.title,
              )),
        ],
      ),
    );
  }
}

class _DetailItemTile extends StatelessWidget {
  final DubaiPart1Item item;
  final String topicTitle;
  final String sectionTitle;

  const _DetailItemTile({
    required this.item,
    required this.topicTitle,
    required this.sectionTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: const Color(0xFFF4F8F6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFD7E7E0)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => DubaiHsePart1AdvancedLearningPage(
                topicTitle: topicTitle,
                sectionTitle: sectionTitle,
                title: item.title,
                summary: item.detail,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 15, 12, 15),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF17332A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.detail,
                      style: const TextStyle(
                        fontSize: 14.5,
                        height: 1.45,
                        color: Color(0xFF465650),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right_rounded,
                size: 25,
                color: Color(0xFF4D5A55),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
