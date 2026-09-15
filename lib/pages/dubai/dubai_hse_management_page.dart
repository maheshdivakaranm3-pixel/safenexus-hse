import 'package:flutter/material.dart';

/// SafeNexus HSE
/// Dubai HSE — HSE Management System
///
/// ONE-FILE ARCHITECTURE:
/// - Main HSE Management System page
/// - Advanced Learning page
/// - Detailed modules, references, practical examples and role guidance
/// are all contained in this single Dart file.
///
/// The page is intentionally self-contained so that the topic does not
/// depend on Part 1 / Part 2 legacy pages.

class DubaiHseManagementPage extends StatelessWidget {
  const DubaiHseManagementPage({super.key});

  static const Color primary = Color(0xFF0B6B4F);
  static const Color green = Color(0xFF159447);
  static const Color background = Color(0xFFF5F8F6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'HSE Management System',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 16, 14, 30),
        children: [
          const _HeroCard(),
          const SizedBox(height: 14),
          const _LearningNotice(),
          const SizedBox(height: 14),
          const _SectionCard(
            icon: Icons.info_outline,
            title: 'What is an HSE Management System?',
            body:
                'An HSE Management System is a structured framework used to plan, implement, control, monitor and continually improve Health, Safety and Environmental performance. On a construction project it connects leadership, responsibilities, risk management, safe work methods, competence, permits, inspections, incident management, emergency preparedness, environmental controls and corrective actions.',
          ),
          const SizedBox(height: 10),
          const _SectionCard(
            icon: Icons.flag_outlined,
            title: 'Main Purpose',
            body:
                'The purpose is to prevent injury and ill health, control workplace hazards, protect people and property, reduce environmental impacts, meet applicable requirements and create a consistent process for identifying problems and improving controls.',
          ),
          const SizedBox(height: 14),
          _AdvancedButton(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const DubaiHseManagementAdvancedPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 14),
          const _QuickMapCard(),
        ],
      ),
    );
  }
}

class DubaiHseManagementAdvancedPage extends StatelessWidget {
  const DubaiHseManagementAdvancedPage({super.key});

  static const Color primary = Color(0xFF0B6B4F);
  static const Color background = Color(0xFFF5F8F6);

  static const List<_HseModule> modules = [
    _HseModule(
      number: '01',
      title: 'HSE Management System Fundamentals',
      icon: Icons.account_tree_outlined,
      summary:
          'Understand the structure, purpose, elements and operating cycle of an HSE management system.',
      sections: [
        _HseSection(
          'Definition',
          'An HSE Management System is a coordinated set of policies, processes, responsibilities, controls, records and review activities used to manage health, safety and environmental risks. It should connect management decisions with what actually happens at the workface.',
        ),
        _HseSection(
          'Why it matters',
          'A good system prevents safety from depending only on individual memory or personal experience. It establishes repeatable arrangements for planning work, controlling hazards, checking performance and learning from failures.',
        ),
        _HseSection(
          'Core cycle',
          'A useful learning model is Plan → Do → Check → Act. Plan the activity and controls; implement the controls; check whether the controls are working; then act on findings and improve the system.',
        ),
        _HseSection(
          'Construction example',
          'Before a lifting activity, the project identifies hazards, assesses risk, approves a lifting method, verifies competent people and equipment, establishes the exclusion zone, conducts the required briefing and permit checks, monitors the lift and closes any corrective actions. This is the management system operating at the workface.',
        ),
      ],
    ),
    _HseModule(
      number: '02',
      title: 'HSE Policy & Leadership',
      icon: Icons.policy_outlined,
      summary:
          'Learn how management commitment is translated into visible action.',
      sections: [
        _HseSection(
          'HSE Policy',
          'The policy communicates the organisation commitment to protecting people, preventing harm, complying with applicable requirements and improving HSE performance. It should be communicated to relevant personnel and reflected in project arrangements.',
        ),
        _HseSection(
          'Leadership commitment',
          'Management should provide appropriate resources, competent people, safe equipment, time for planning and authority for corrective action. Safety requirements should remain part of planning and decision-making rather than being treated as a separate activity.',
        ),
        _HseSection(
          'Visible leadership',
          'Effective leadership can include site visits, review of critical controls, discussions with workers, review of significant findings and timely decisions on resources or work restrictions.',
        ),
        _HseSection(
          'Worker participation',
          'Workers should have practical opportunities to raise hazards, ask questions, report near misses and contribute to improvement. A reporting culture is stronger when people receive feedback on what happened after they raised a concern.',
        ),
      ],
    ),
    _HseModule(
      number: '03',
      title: 'HSE Organisation & Responsibilities',
      icon: Icons.groups_outlined,
      summary:
          'Understand accountability from project leadership to the individual worker.',
      sections: [
        _HseSection(
          'Project / Construction Management',
          'Provides overall project direction, resources, priorities, competent personnel and authority needed to implement the HSE arrangements.',
        ),
        _HseSection(
          'HSE Manager',
          'Coordinates the HSE management system, advises project management, monitors performance, supports audits and investigations, reviews significant risks and tracks corrective actions.',
        ),
        _HseSection(
          'HSE Engineer / Officer',
          'Conducts field inspections, verifies controls, supports risk assessments, checks relevant permits and RAMS, communicates hazards, records observations, follows corrective actions and escalates significant uncontrolled risks.',
        ),
        _HseSection(
          'HSE Supervisor',
          'Maintains close workface monitoring, checks daily conditions, follows up unsafe acts and conditions and coordinates immediate corrective action with supervisors.',
        ),
        _HseSection(
          'Supervisor / Foreman',
          'Controls the work at the workface, briefs workers, verifies competence and equipment, implements the approved method and stops or escalates work when conditions are unsafe.',
        ),
        _HseSection(
          'Worker',
          'Follows the approved method and instructions, uses required controls and PPE, reports hazards and incidents, participates in briefings and raises concerns about unsafe conditions.',
        ),
      ],
    ),
    _HseModule(
      number: '04',
      title: 'Legal & Regulatory Compliance',
      icon: Icons.gavel_outlined,
      summary:
          'Build a disciplined process for identifying and verifying applicable requirements.',
      sections: [
        _HseSection(
          'Compliance register',
          'Maintain a controlled list of applicable legal, authority, client and project requirements relevant to the work. Assign ownership and define how compliance will be checked.',
        ),
        _HseSection(
          'Requirement hierarchy',
          'Distinguish legislation, authority requirements, guidance, client requirements, company procedures and project-specific controls. Do not automatically treat every guidance document as legislation.',
        ),
        _HseSection(
          'Verification',
          'For each important requirement ask: What applies? Where is it implemented? Who is responsible? What evidence demonstrates compliance? What action is required if it is not met?',
        ),
        _HseSection(
          'Dubai/UAE reference discipline',
          'The app should be used as a learning aid. For legal decisions, always verify the current applicable Dubai/UAE authority requirement, approved project procedure and competent technical advice before relying on a specific regulatory requirement.',
        ),
      ],
    ),
    _HseModule(
      number: '05',
      title: 'Hazard Identification & Risk Assessment',
      icon: Icons.warning_amber_outlined,
      summary:
          'Learn the complete process from identifying a hazard to verifying residual risk.',
      sections: [
        _HseSection(
          'Hazard vs risk',
          'A hazard is a source or situation with potential to cause harm. Risk considers the likelihood and consequence of that harm. The distinction helps the team select appropriate controls.',
        ),
        _HseSection(
          'Risk assessment sequence',
          'Define the activity; identify hazards; identify people who may be affected; evaluate the initial risk; identify existing controls; select additional controls; assign responsibilities; communicate the controls; verify implementation; review when conditions change.',
        ),
        _HseSection(
          'Hierarchy of controls',
          'Use the hierarchy as a control-selection principle: Elimination, Substitution, Engineering Controls, Administrative Controls and PPE. Stronger controls should be considered before relying mainly on administrative measures or PPE.',
        ),
        _HseSection(
          'Dynamic assessment',
          'Review risk when the work sequence, equipment, environment, personnel, access, interfaces or other important conditions change. The assessment must reflect actual work, not only the original paperwork.',
        ),
        _HseSection(
          'Practical example',
          'For an open excavation, consider collapse, falls, underground services, water, plant interface and access. Controls may include a suitable protective system, safe access, edge protection, service verification, plant segregation, inspection and emergency arrangements as applicable.',
        ),
      ],
    ),
    _HseModule(
      number: '06',
      title: 'HSE Plan & Project Planning',
      icon: Icons.assignment_outlined,
      summary:
          'Convert project requirements into an organised HSE delivery plan.',
      sections: [
        _HseSection(
          'Typical HSE Plan elements',
          'Project objectives, organisation, responsibilities, risk management, training, inspection, audit, incident reporting, emergency arrangements, environmental controls, contractor management, communication and performance reporting.',
        ),
        _HseSection(
          'Planning before mobilisation',
          'Identify major activities, high-risk work, interfaces, resources, competence needs, emergency arrangements and critical controls before the work reaches the field.',
        ),
        _HseSection(
          'Work package planning',
          'For each significant activity verify the approved method, risk assessment, competent personnel, equipment, access, exclusion zones, permits where required, environmental conditions and emergency arrangements.',
        ),
        _HseSection(
          'SIMOPS',
          'Simultaneous operations should be coordinated so that lifting, excavation, traffic, hot work, electrical work, work at height and other activities do not create uncontrolled interface risks for each other.',
        ),
      ],
    ),
    _HseModule(
      number: '07',
      title: 'RAMS — Risk Assessment & Method Statement',
      icon: Icons.description_outlined,
      summary:
          'Understand how RAMS controls the planned sequence of work.',
      sections: [
        _HseSection(
          'Purpose',
          'RAMS should describe the task sequence, hazards, controls, responsibilities, equipment, competence requirements and relevant emergency arrangements.',
        ),
        _HseSection(
          'Method statement',
          'The method should explain how the work will actually be carried out safely, including preparation, sequence, interfaces, inspection or hold points and completion requirements.',
        ),
        _HseSection(
          'Briefing',
          'Affected workers should receive the relevant briefing and understand the hazards, controls, sequence and stop-work arrangements. A signature alone is not proof that the worker understands the task.',
        ),
        _HseSection(
          'Change management',
          'If site conditions materially differ from the approved RAMS, the work should be controlled and the method/risk assessment reviewed before continuing.',
        ),
      ],
    ),
    _HseModule(
      number: '08',
      title: 'Permit to Work — PTW',
      icon: Icons.fact_check_outlined,
      summary:
          'Learn PTW as a formal control and communication system.',
      sections: [
        _HseSection(
          'Purpose',
          'A PTW system provides formal control for specified higher-risk or controlled activities. It identifies the work, location, precautions, authorisation and validity requirements applicable to that task.',
        ),
        _HseSection(
          'Before work',
          'Verify the correct permit, work boundary, isolations or tests where required, competent persons, precautions, communication and actual site conditions.',
        ),
        _HseSection(
          'Examples',
          'Depending on project arrangements, controlled activities may include hot work, confined space, excavation or electrical isolation. The exact permit categories must follow the current approved project PTW procedure.',
        ),
        _HseSection(
          'Suspension and closure',
          'Suspend when conditions are no longer safe or authorised conditions change. Close the permit according to the approved project procedure after the work is safely completed.',
        ),
      ],
    ),
    _HseModule(
      number: '09',
      title: 'Training, Competency & Authorisation',
      icon: Icons.school_outlined,
      summary:
          'Separate training attendance from actual competence and authorisation.',
      sections: [
        _HseSection(
          'Training matrix',
          'Maintain an appropriate matrix covering induction, task-specific training, emergency training, specialist competence and refresher requirements.',
        ),
        _HseSection(
          'Competence',
          'Competence depends on appropriate knowledge, skills, experience and authorisation for the task. Safety-critical activities should be performed only by suitably competent and authorised personnel.',
        ),
        _HseSection(
          'Verification',
          'Check certificates or records where required, but also verify practical ability, understanding of the task and compliance with project authorisation arrangements.',
        ),
        _HseSection(
          'Toolbox talks',
          'A good toolbox talk is task-specific and should cover today’s work, hazards, controls, interfaces, changing conditions, emergency arrangements and worker questions.',
        ),
      ],
    ),
    _HseModule(
      number: '10',
      title: 'Inspection & Field Monitoring',
      icon: Icons.search_outlined,
      summary:
          'Verify that documented controls exist and work at the actual workface.',
      sections: [
        _HseSection(
          'Daily field inspection',
          'Review active work fronts, access, housekeeping, barriers, PPE, temporary works, equipment condition and critical controls appropriate to the activity.',
        ),
        _HseSection(
          'Critical-control verification',
          'Do not only count inspections. Verify controls that prevent serious outcomes, such as lifting exclusion zones, excavation protection, work-at-height protection or electrical isolation as applicable.',
        ),
        _HseSection(
          'Observation process',
          'Record the unsafe condition or act, identify the risk, apply immediate control when necessary, assign an action, set a realistic due date and verify closure.',
        ),
        _HseSection(
          'Communication',
          'Significant findings should be communicated to the responsible supervisor and escalated through the project structure when the risk cannot be controlled immediately.',
        ),
      ],
    ),
    _HseModule(
      number: '11',
      title: 'HSE Audit',
      icon: Icons.fact_check_outlined,
      summary:
          'Learn the difference between an inspection and a management-system audit.',
      sections: [
        _HseSection(
          'Inspection vs audit',
          'An inspection mainly checks workplace conditions and controls. An audit evaluates whether the management arrangements are established, implemented and effective using documents, records, interviews and field evidence.',
        ),
        _HseSection(
          'Audit preparation',
          'Define scope, criteria, areas, activities, evidence and responsible participants before the audit.',
        ),
        _HseSection(
          'Findings',
          'Classify findings according to the approved project audit process. Explain the evidence, requirement or expectation, risk significance and required action clearly.',
        ),
        _HseSection(
          'Close-out',
          'Verify corrective actions and their effectiveness. Closing paperwork without fixing the underlying issue does not demonstrate effective close-out.',
        ),
      ],
    ),
    _HseModule(
      number: '12',
      title: 'Incident & Near-Miss Management',
      icon: Icons.report_problem_outlined,
      summary:
          'Manage events from immediate response through learning and prevention.',
      sections: [
        _HseSection(
          'Immediate response',
          'Make the area safe, provide appropriate emergency response, raise the alarm and prevent further exposure. Preserve relevant information and evidence where appropriate.',
        ),
        _HseSection(
          'Notification',
          'Follow the project incident-reporting procedure and applicable requirements for notification and escalation.',
        ),
        _HseSection(
          'Investigation',
          'Establish what happened and examine contributing and underlying causes. Consider planning, supervision, equipment, procedures, competence, communication and organisational factors.',
        ),
        _HseSection(
          'Near misses',
          'Near misses are valuable learning opportunities because they can reveal failed controls before serious harm occurs. Record, investigate proportionately and share relevant lessons.',
        ),
      ],
    ),
    _HseModule(
      number: '13',
      title: 'Emergency Preparedness & Response',
      icon: Icons.emergency_outlined,
      summary:
          'Prepare people, equipment and communication before emergencies occur.',
      sections: [
        _HseSection(
          'Emergency plan',
          'Identify credible emergencies and define alarm, communication, emergency contacts, evacuation, assembly points, first aid, fire response, rescue arrangements and responsibilities.',
        ),
        _HseSection(
          'Emergency equipment',
          'Ensure relevant emergency equipment and access arrangements are identified, available, maintained and not obstructed.',
        ),
        _HseSection(
          'Drills',
          'Drills should test practical response, communication and coordination. Record observations and improve arrangements based on lessons learned.',
        ),
        _HseSection(
          'Restart after emergency',
          'Do not automatically restart affected work after the immediate event. Reassess hazards, inspect the area, confirm controls and obtain required authorisation before resuming.',
        ),
      ],
    ),
    _HseModule(
      number: '14',
      title: 'Contractor & Subcontractor Management',
      icon: Icons.handshake_outlined,
      summary:
          'Control risks introduced through external companies and work groups.',
      sections: [
        _HseSection(
          'Prequalification',
          'Review relevant HSE capability, experience, competent personnel, procedures and resources appropriate to the scope before engagement.',
        ),
        _HseSection(
          'Mobilisation',
          'Verify induction, RAMS, competency, supervision, equipment, permits and project requirements before work starts.',
        ),
        _HseSection(
          'Interface management',
          'Coordinate contractor activities with the main contractor, client, other subcontractors and site operations so that interfaces are controlled.',
        ),
        _HseSection(
          'Performance management',
          'Monitor inspections, observations, incidents, corrective actions and repeated non-conformances. Escalate persistent failures through the project management process.',
        ),
      ],
    ),
    _HseModule(
      number: '15',
      title: 'Environmental Management',
      icon: Icons.eco_outlined,
      summary:
          'Integrate environmental risk into normal project planning and control.',
      sections: [
        _HseSection(
          'Environmental aspects',
          'Consider waste, dust, noise, spills, chemicals, water, fuel, emissions, pollution prevention and housekeeping according to applicable and project requirements.',
        ),
        _HseSection(
          'Waste management',
          'Use the project waste process, segregation arrangements and approved disposal routes. Prevent uncontrolled dumping or mixing of incompatible waste streams.',
        ),
        _HseSection(
          'Spill prevention',
          'Identify spill sources, provide appropriate prevention and response arrangements and ensure workers know the required reporting and containment process.',
        ),
        _HseSection(
          'Environmental inspections',
          'Verify actual site conditions, storage arrangements, waste areas, drainage protection and housekeeping rather than relying only on environmental paperwork.',
        ),
      ],
    ),
    _HseModule(
      number: '16',
      title: 'Occupational Health, Welfare & Heat Stress',
      icon: Icons.health_and_safety_outlined,
      summary:
          'Manage health and welfare risks as part of the HSE system.',
      sections: [
        _HseSection(
          'Worker welfare',
          'Plan suitable welfare facilities, sanitation, drinking water, rest arrangements and other controls appropriate to the project and applicable requirements.',
        ),
        _HseSection(
          'Occupational health',
          'Consider health risks associated with noise, dust, chemicals, ergonomics, vibration, heat and other exposures relevant to the work.',
        ),
        _HseSection(
          'Heat-stress management',
          'For hot-weather work, use applicable current requirements and project arrangements for hydration, shaded recovery, work/rest planning, acclimatisation, awareness and response to symptoms.',
        ),
        _HseSection(
          'Worker awareness',
          'Workers should know common warning signs, preventive measures and how to report symptoms or request assistance without delay.',
        ),
      ],
    ),
    _HseModule(
      number: '17',
      title: 'HSE Communication & Worker Engagement',
      icon: Icons.campaign_outlined,
      summary:
          'Make safety information understandable, timely and relevant to the work.',
      sections: [
        _HseSection(
          'Communication channels',
          'Use induction, toolbox talks, pre-task briefings, signage, meetings, safety alerts, observations and direct supervisor communication as appropriate.',
        ),
        _HseSection(
          'Language and understanding',
          'Where workers speak different languages, use suitable communication methods so that critical hazards and controls are genuinely understood.',
        ),
        _HseSection(
          'Feedback loop',
          'When workers report hazards or near misses, provide feedback on the action taken. This encourages continued participation and improves reporting quality.',
        ),
      ],
    ),
    _HseModule(
      number: '18',
      title: 'HSE KPI & Performance Management',
      icon: Icons.analytics_outlined,
      summary:
          'Use performance data to identify risk and improve decisions.',
      sections: [
        _HseSection(
          'Leading indicators',
          'Examples include planned inspections completed, toolbox talks, training completion, safety observations, critical-control checks and corrective-action closure.',
        ),
        _HseSection(
          'Lagging indicators',
          'Examples include injuries, lost-time events, recordable incidents, property damage and environmental incidents.',
        ),
        _HseSection(
          'Balanced interpretation',
          'Do not judge safety performance from one number. A low incident count with poor reporting or weak field verification can give a misleading picture.',
        ),
        _HseSection(
          'Trend analysis',
          'Review repeated findings, high-risk activities, overdue actions and changes in performance over time. Use trends to focus management attention.',
        ),
      ],
    ),
    _HseModule(
      number: '19',
      title: 'Corrective Action, CAPA & Root Cause',
      icon: Icons.build_circle_outlined,
      summary:
          'Move beyond fixing symptoms and prevent recurrence.',
      sections: [
        _HseSection(
          'Immediate correction',
          'Take appropriate immediate action to remove or control the identified unsafe condition or non-conformance.',
        ),
        _HseSection(
          'Corrective action',
          'Address the cause of the identified problem and restore the required control.',
        ),
        _HseSection(
          'Root-cause thinking',
          'For significant or repeated events, examine why the control failed. Consider planning, design, supervision, competence, equipment, procedures, communication and organisational factors.',
        ),
        _HseSection(
          'Effectiveness check',
          'After implementation, verify that the action actually controls the risk and that the same failure has not remained elsewhere on the project.',
        ),
      ],
    ),
    _HseModule(
      number: '20',
      title: 'Document & Record Control',
      icon: Icons.folder_copy_outlined,
      summary:
          'Keep HSE information controlled, current, accessible and traceable.',
      sections: [
        _HseSection(
          'Typical records',
          'HSE plan, risk assessments, RAMS, permits, inspections, training records, toolbox talks, equipment records, incident reports, audits, corrective actions and emergency drill records may form part of the project HSE record system.',
        ),
        _HseSection(
          'Revision control',
          'Use controlled versions so that personnel do not unknowingly work from obsolete procedures or methods.',
        ),
        _HseSection(
          'Evidence',
          'Records should provide credible evidence of what was planned, communicated, inspected, authorised, observed and corrected.',
        ),
        _HseSection(
          'Field availability',
          'Critical information should be accessible to the people who need it at the point of work, subject to the project document-control process.',
        ),
      ],
    ),
    _HseModule(
      number: '21',
      title: 'Management Review',
      icon: Icons.manage_accounts_outlined,
      summary:
          'Use HSE information to make management decisions and allocate resources.',
      sections: [
        _HseSection(
          'Review inputs',
          'Consider HSE performance, audit findings, incidents, trends, corrective actions, requirement changes, resources, competence and improvement opportunities.',
        ),
        _HseSection(
          'Management decisions',
          'The review should result in meaningful decisions where gaps or risks require changes to resources, controls, procedures, training or priorities.',
        ),
        _HseSection(
          'Follow-up',
          'Actions from management review should have owners, target dates and effectiveness verification where appropriate.',
        ),
      ],
    ),
    _HseModule(
      number: '22',
      title: 'Continual Improvement — PDCA',
      icon: Icons.autorenew_outlined,
      summary:
          'Turn lessons, findings and performance data into stronger controls.',
      sections: [
        _HseSection(
          'Plan',
          'Understand the activity, requirements, hazards, resources and controls before work starts.',
        ),
        _HseSection(
          'Do',
          'Implement the planned controls, communicate them and supervise the work.',
        ),
        _HseSection(
          'Check',
          'Inspect, audit, observe, measure performance and investigate failures.',
        ),
        _HseSection(
          'Act',
          'Correct problems, learn from events and improve the system so that performance becomes more reliable.',
        ),
      ],
    ),
    _HseModule(
      number: '23',
      title: 'Practical HSE Officer Daily Routine',
      icon: Icons.engineering_outlined,
      summary:
          'A practical sequence for daily construction-site HSE monitoring.',
      sections: [
        _HseSection(
          'Before site walk',
          'Review planned activities, high-risk work, permits, RAMS, manpower, competency, equipment, interfaces, previous findings, weather/environmental conditions and emergency arrangements as relevant.',
        ),
        _HseSection(
          'Morning work-front check',
          'Visit active work areas and verify access, housekeeping, barriers, PPE, equipment, critical controls and whether actual work matches the approved plan.',
        ),
        _HseSection(
          'During the shift',
          'Focus on high-risk activities and changing conditions. Speak with workers and supervisors, record observations, apply immediate controls and escalate serious uncontrolled risks.',
        ),
        _HseSection(
          'Action follow-up',
          'Check previous findings and overdue actions. Confirm that the corrective action is actually effective before marking it closed.',
        ),
        _HseSection(
          'End-of-day review',
          'Review incidents, near misses, outstanding actions, permit status, housekeeping, next-shift risks and issues requiring management attention.',
        ),
      ],
    ),
    _HseModule(
      number: '24',
      title: 'Practical Construction-Site Scenarios',
      icon: Icons.construction_outlined,
      summary:
          'Apply the management-system concepts to realistic work situations.',
      sections: [
        _HseSection(
          'Scenario — Open excavation',
          'The team plans excavation near a vehicle route. Before work, verify the risk assessment, underground-service information, protective system, safe access, edge protection, plant segregation, inspection arrangements and emergency plan as applicable.',
        ),
        _HseSection(
          'Scenario — Lifting operation',
          'Before a critical lift, verify the approved lifting arrangement, competent personnel, suitable equipment and accessories, ground conditions, exclusion zone, communication and weather/environmental conditions as applicable.',
        ),
        _HseSection(
          'Scenario — Work at height',
          'Verify the planned method, suitable access, edge protection or other required fall-prevention system, equipment condition, competence, dropped-object controls and rescue arrangements where applicable.',
        ),
        _HseSection(
          'Scenario — Hot work',
          'Verify the applicable permit process, work area, ignition-source controls, fire precautions, suitable equipment, housekeeping, gas testing where required and emergency arrangements.',
        ),
        _HseSection(
          'Scenario — Repeated unsafe condition',
          'If the same finding repeatedly appears, do not treat it only as a housekeeping issue. Investigate why the control is repeatedly failing and consider supervision, planning, training, resources and management-system causes.',
        ),
      ],
    ),
    _HseModule(
      number: '25',
      title: 'HSE Officer / Supervisor / Manager Reference',
      icon: Icons.badge_outlined,
      summary:
          'Role-focused reference for practical work and professional development.',
      sections: [
        _HseSection(
          'HSE Officer focus',
          'Field verification, risk communication, inspections, observations, permit/RAMS checks, training support, incident reporting, corrective-action follow-up and escalation.',
        ),
        _HseSection(
          'HSE Supervisor focus',
          'Close workface monitoring, supervisor coordination, immediate intervention, daily field conditions and follow-up of critical controls.',
        ),
        _HseSection(
          'HSE Manager focus',
          'System performance, resources, audits, significant risks, incident learning, management reporting, legal/compliance oversight and continual improvement.',
        ),
        _HseSection(
          'Golden rule',
          'The HSE function should not replace line-management responsibility. Supervisors and managers own safe execution of the work; the HSE team provides advice, monitoring, verification and escalation according to the project organisation.',
        ),
      ],
    ),
    _HseModule(
      number: '26',
      title: 'Common HSE Management Failures',
      icon: Icons.error_outline,
      summary:
          'Recognise weak-system patterns before they become serious events.',
      sections: [
        _HseSection(
          'Paper compliance',
          'A signed RAMS, checklist or toolbox sheet does not prove that controls exist in the field.',
        ),
        _HseSection(
          'Generic risk assessment',
          'A generic assessment can miss actual site conditions, interfaces, equipment and changing hazards.',
        ),
        _HseSection(
          'Weak supervision',
          'Controls can fail when supervisors do not verify the workface or intervene when conditions change.',
        ),
        _HseSection(
          'Closing actions too quickly',
          'An action should not be closed simply because a photograph or note was uploaded. Verify that the risk has actually been controlled.',
        ),
        _HseSection(
          'Production pressure',
          'Schedule or production pressure should not be used as a reason to bypass critical controls or required authorisations.',
        ),
      ],
    ),
    _HseModule(
      number: '27',
      title: 'Quick Reference — HSE Management Checklist',
      icon: Icons.checklist_outlined,
      summary:
          'Use this as a quick mental checklist before and during work.',
      sections: [
        _HseSection(
          'PLAN',
          'Is the activity identified? Are hazards assessed? Are controls defined? Is the RAMS approved? Are competent people and suitable equipment available?',
        ),
        _HseSection(
          'AUTHORISE',
          'Are required permits, isolations, approvals and work boundaries verified?',
        ),
        _HseSection(
          'BRIEF',
          'Have workers been briefed and do they understand the hazards, controls and emergency arrangements?',
        ),
        _HseSection(
          'CONTROL',
          'Are physical controls, access, exclusion zones, PPE and supervision in place at the workface?',
        ),
        _HseSection(
          'CHECK',
          'Are inspections, observations and critical-control verifications being completed?',
        ),
        _HseSection(
          'ACT',
          'Are findings corrected, assigned, followed up and verified for effectiveness?',
        ),
        _HseSection(
          'LEARN',
          'Are incidents, near misses, trends and lessons learned being used to improve the system?',
        ),
      ],
    ),
    _HseModule(
      number: '28',
      title: 'Interview & Professional Learning Questions',
      icon: Icons.quiz_outlined,
      summary:
          'Questions to test understanding for HSE Officer and Supervisor development.',
      sections: [
        _HseSection(
          'Q1 — What is an HSE Management System?',
          'A structured framework for planning, implementing, monitoring and improving health, safety and environmental performance.',
        ),
        _HseSection(
          'Q2 — What is the hierarchy of controls?',
          'Elimination, Substitution, Engineering Controls, Administrative Controls and PPE.',
        ),
        _HseSection(
          'Q3 — What should happen when site conditions change?',
          'Control or stop the affected work as appropriate, reassess the risk, update the method or controls where required, brief affected personnel and verify before restart.',
        ),
        _HseSection(
          'Q4 — What is the difference between inspection and audit?',
          'Inspection focuses mainly on workplace conditions and controls; an audit evaluates the management arrangements and their effectiveness using evidence.',
        ),
        _HseSection(
          'Q5 — When is corrective action really closed?',
          'When the required action is implemented and its effectiveness has been verified according to the project process.',
        ),
        _HseSection(
          'Q6 — Who owns safety at the workface?',
          'Safety is a line-management responsibility. HSE supports, advises, monitors and escalates according to the project organisation.',
        ),
        _HseSection(
          'Q7 — What should an HSE Officer do when a critical uncontrolled risk is found?',
          'Take or request immediate appropriate control, prevent further exposure, inform the responsible supervision/management and escalate according to the project process.',
        ),
      ],
    ),
    _HseModule(
      number: '29',
      title: 'Learning Method — How to Study This Topic',
      icon: Icons.menu_book_outlined,
      summary:
          'A simple method for building practical HSE knowledge.',
      sections: [
        _HseSection(
          'Step 1 — Understand',
          'Read the concept and make sure you can explain it in your own words.',
        ),
        _HseSection(
          'Step 2 — Connect',
          'Connect the concept with risk assessment, RAMS, PTW, inspection, supervision and incident prevention.',
        ),
        _HseSection(
          'Step 3 — Apply',
          'Imagine the same requirement at a real construction workface and identify what you would physically check.',
        ),
        _HseSection(
          'Step 4 — Verify',
          'Ask what document, observation, interview or physical evidence would demonstrate that the control is actually implemented.',
        ),
        _HseSection(
          'Step 5 — Review',
          'Use the quick-reference and interview questions to test yourself regularly.',
        ),
      ],
    ),
    _HseModule(
      number: '30',
      title: 'Final HSE Management System Reference',
      icon: Icons.verified_outlined,
      summary:
          'Bring the whole management system together into one practical model.',
      sections: [
        _HseSection(
          'One-line model',
          'Leadership sets direction → Planning identifies risks → Controls are implemented → Competence and communication support the work → Inspection and audit verify performance → Incidents and findings create learning → Management review drives improvement.',
        ),
        _HseSection(
          'Workface model',
          'Before work: Plan and verify. During work: Control and supervise. When conditions change: Stop/control and reassess. When a problem occurs: Respond, report, investigate and learn. After correction: Verify effectiveness.',
        ),
        _HseSection(
          'Professional mindset',
          'A strong HSE professional does not only look for violations. The professional understands the work, identifies critical risks, verifies controls, communicates clearly, supports supervisors and workers, follows actions through to effectiveness and uses lessons to prevent recurrence.',
        ),
        _HseSection(
          'Reference caution',
          'This learning module is an educational and field-reference aid. Specific legal, authority, client and project requirements must always be checked against the current applicable source and approved project documentation before making compliance decisions.',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'Advanced Learning',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 16, 14, 30),
        children: [
          const _AdvancedHero(),
          const SizedBox(height: 14),
          const _LearningNotice(),
          const SizedBox(height: 14),
          const Text(
            'HSE Management System — Detailed Modules',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: primary,
            ),
          ),
          const SizedBox(height: 10),
          for (final module in modules) ...[
            _ModuleCard(module: module),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0B6B4F),
            Color(0xFF159447),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.verified_user_outlined,
            color: Colors.white,
            size: 42,
          ),
          SizedBox(height: 12),
          Text(
            'Dubai HSE Management System',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'Professional learning and field-reference module for HSE Officers, Supervisors, Engineers and Managers.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _AdvancedHero extends StatelessWidget {
  const _AdvancedHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0B6B4F),
            Color(0xFF159447),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.menu_book_rounded,
            color: Colors.white,
            size: 40,
          ),
          SizedBox(height: 10),
          Text(
            'Advanced Learning & Field Reference',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'Study the complete HSE management cycle from leadership and planning to field control, monitoring, incident learning and continual improvement.',
            style: TextStyle(
              color: Colors.white,
              height: 1.55,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _LearningNotice extends StatelessWidget {
  const _LearningNotice();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Color(0xFFD8E6DE),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.info_outline,
              color: Color(0xFF0B6B4F),
            ),
            SizedBox(width: 11),
            Expanded(
              child: Text(
                'Learning and field-reference aid. For actual compliance decisions, always follow the current applicable Dubai/UAE requirements, approved project procedures, RAMS, permits and competent technical instructions.',
                style: TextStyle(
                  fontSize: 13.2,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdvancedButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AdvancedButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF0B6B4F),
                Color(0xFF159447),
              ],
            ),
          ),
          child: const Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.menu_book_rounded,
                  color: Color(0xFF0B6B4F),
                  size: 29,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📚 Advanced Learning',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Tap to open detailed study and field reference',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 19,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickMapCard extends StatelessWidget {
  const _QuickMapCard();

  @override
  Widget build(BuildContext context) {
    const items = [
      'Policy & Leadership',
      'Responsibilities',
      'Legal Compliance',
      'Risk Assessment',
      'HSE Plan',
      'RAMS',
      'PTW',
      'Training',
      'Inspection & Audit',
      'Incident Management',
      'Emergency',
      'Contractor Management',
      'Environment',
      'Occupational Health',
      'KPI',
      'CAPA',
      'Document Control',
      'Management Review',
      'Daily HSE Routine',
      'Interview Reference',
    ];

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Learning Roadmap',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: [
                for (final item in items)
                  Chip(
                    avatar: const Icon(
                      Icons.check_circle_outline,
                      size: 17,
                    ),
                    label: Text(item),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0.8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: const Color(0xFF0B6B4F),
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF0B6B4F),
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    body,
                    style: const TextStyle(
                      fontSize: 13.7,
                      height: 1.58,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final _HseModule module;

  const _ModuleCard({
    required this.module,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 1.2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 7,
        ),
        childrenPadding: const EdgeInsets.fromLTRB(
          14,
          0,
          14,
          13,
        ),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: const Color(0xFFE5F4EC),
          child: Icon(
            module.icon,
            color: const Color(0xFF0B6B4F),
            size: 25,
          ),
        ),
        title: Text(
          '${module.number}  ${module.title}',
          style: const TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w800,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            module.summary,
            style: const TextStyle(
              fontSize: 12.4,
              height: 1.4,
            ),
          ),
        ),
        children: [
          for (final section in module.sections)
            _LearningSectionCard(section: section),
        ],
      ),
    );
  }
}

class _LearningSectionCard extends StatelessWidget {
  final _HseSection section;

  const _LearningSectionCard({
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAF8),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: const Color(0xFFE0EBE4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style: const TextStyle(
              color: Color(0xFF0B6B4F),
              fontSize: 14.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            section.body,
            style: const TextStyle(
              fontSize: 13.4,
              height: 1.58,
            ),
          ),
        ],
      ),
    );
  }
}

class _HseModule {
  final String number;
  final String title;
  final IconData icon;
  final String summary;
  final List<_HseSection> sections;

  const _HseModule({
    required this.number,
    required this.title,
    required this.icon,
    required this.summary,
    required this.sections,
  });
}

class _HseSection {
  final String title;
  final String body;

  const _HseSection(
    this.title,
    this.body,
  );
}
