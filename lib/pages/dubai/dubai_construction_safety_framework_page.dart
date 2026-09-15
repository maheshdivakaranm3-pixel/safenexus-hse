import 'package:flutter/material.dart';

class ConstructionSafetyItem {
  final String title;
  final String subtitle;
  final List<String> points;

  const ConstructionSafetyItem({
    required this.title,
    required this.subtitle,
    required this.points,
  });
}

class ConstructionSafetySection {
  final String title;
  final String body;

  const ConstructionSafetySection(this.title, this.body);
}

class DubaiConstructionSafetyAdvancedLearningPage extends StatelessWidget {
  final ConstructionSafetyItem item;

  const DubaiConstructionSafetyAdvancedLearningPage({
    super.key,
    required this.item,
  });

  static const green = Color(0xFF0B7653);

  static const roles = <String, List<String>>{
    'HSE Officer': [
      'Verify field implementation of approved HSE controls.',
      'Conduct routine observations and inspections.',
      'Identify unsafe conditions and follow up corrective actions.',
      'Support toolbox talks, incident reporting and emergency readiness.',
    ],
    'HSE Supervisor': [
      'Supervise day-to-day HSE implementation.',
      'Coordinate workfront controls with construction supervisors and subcontractors.',
      'Verify corrective actions are implemented and effective.',
      'Intervene and stop unsafe work when critical controls fail.',
    ],
    'Senior HSE': [
      'Provide senior assurance for high-risk activities and complex interfaces.',
      'Review recurring failures and significant findings.',
      'Challenge inadequate controls and support escalation.',
      'Monitor consistency of HSE implementation across work fronts.',
    ],
    'HSE Coordinator': [
      'Coordinate HSE documentation, inspections, meetings and contractor interfaces.',
      'Track actions, submissions, risk assessments and method statements.',
      'Coordinate information flow between construction, engineering and HSE.',
      'Maintain controlled records and follow up outstanding actions.',
    ],
    'HSE Engineer': [
      'Provide technical HSE input to risk controls and high-risk activities.',
      'Review technical interfaces and changes affecting safety.',
      'Support engineering and construction teams with complex HSE issues.',
      'Contribute to investigations and technical corrective actions.',
    ],
    'HSE Manager': [
      'Provide project-level HSE governance, leadership and resources.',
      'Review significant risks, trends, serious incidents and major actions.',
      'Ensure competence and contractor-management arrangements are effective.',
      'Support stop-work decisions and system-level improvement.',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        title: const Text('Advanced Learning'),
        backgroundColor: green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 7),
                  Text(item.subtitle,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: green)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          _listCard('Core Explanation', item.points),
          const SizedBox(height: 10),
          _listCard('Field Verification', const [
            'Confirm the approved HSE controls are available to the responsible team.',
            'Check the actual workface against the planned sequence and risk controls.',
            'Verify competent supervision, equipment condition, access and exclusion arrangements.',
            'Record deviations and reassess significant changes before continuing.',
          ]),
          const SizedBox(height: 10),
          _listCard('Critical Control Points', const [
            'Approved planning and risk controls before exposure.',
            'Competent people with clear authority and supervision.',
            'Physical barriers and engineering controls where required.',
            'Effective communication and interface coordination.',
            'Inspection, corrective action and verification.',
          ]),
          const SizedBox(height: 10),
          _listCard('Stop-Work Triggers', const [
            'A serious hazard is uncontrolled.',
            'A critical safety barrier or protection system is missing or failed.',
            'Required competent supervision is absent.',
            'Actual conditions materially differ from the approved method.',
            'Continuing would expose people to unacceptable risk.',
          ]),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('HSE Roles — Topic-wise Responsibilities',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  ...roles.entries.map(
                    (entry) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(entry.key,
                          style:
                              const TextStyle(fontWeight: FontWeight.w700)),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ConstructionSafetyRolePage(
                            role: entry.key,
                            points: entry.value,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            color: const Color(0xFFEAF4F0),
            child: ListTile(
              title: const Text('Go Deeper — Practical Decision Guide',
                  style: TextStyle(fontWeight: FontWeight.w800)),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const DubaiConstructionSafetyDeepLearningPage(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listCard(String title, List<String> values) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            ...values.asMap().entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${e.key + 1}.',
                            style: const TextStyle(
                                fontWeight: FontWeight.w800, color: green)),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Text(e.value,
                                style: const TextStyle(
                                    fontSize: 15, height: 1.5))),
                      ],
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class ConstructionSafetyRolePage extends StatelessWidget {
  final String role;
  final List<String> points;

  const ConstructionSafetyRolePage({
    super.key,
    required this.role,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        title: Text(role),
        backgroundColor: const Color(0xFF0B7653),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('$role — Construction Safety Framework',
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          ...points.asMap().entries.map(
                (e) => Card(
                  margin: const EdgeInsets.only(bottom: 9),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${e.key + 1}.',
                            style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0B7653))),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Text(e.value,
                                style: const TextStyle(
                                    fontSize: 15, height: 1.5))),
                      ],
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class DubaiConstructionSafetyDeepLearningPage extends StatelessWidget {
  const DubaiConstructionSafetyDeepLearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        title: const Text('Practical Decision Guide'),
        backgroundColor: const Color(0xFF0B7653),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Scenario: SIMOPS at a construction workfront',
                      style: TextStyle(
                          fontSize: 21, fontWeight: FontWeight.w800)),
                  SizedBox(height: 12),
                  Text(
                    'A crane lift, façade work and vehicle deliveries are planned in overlapping areas. Before work starts, confirm the approved sequence, lifting controls, work-at-height protection, traffic segregation, exclusion zones, communication and supervision.',
                    style: TextStyle(fontSize: 15, height: 1.55),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: Padding(
              padding: EdgeInsets.all(17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Decision Check',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  SizedBox(height: 10),
                  Text('1. Are the risks assessed for the actual workface?'),
                  SizedBox(height: 8),
                  Text(
                      '2. Are critical physical controls installed and verified?'),
                  SizedBox(height: 8),
                  Text('3. Are responsibilities and communication clear?'),
                  SizedBox(height: 8),
                  Text('4. Are simultaneous activities coordinated?'),
                  SizedBox(height: 8),
                  Text(
                    '5. If a critical answer is no, stop and correct before exposure.',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DubaiConstructionSafetyFrameworkPage extends StatelessWidget {
  const DubaiConstructionSafetyFrameworkPage({super.key});

  static const green = Color(0xFF0B7653);

  static const items = <ConstructionSafetyItem>[
    ConstructionSafetyItem(
      title: 'Project HSE Plan',
      subtitle: 'Project-level framework for construction HSE',
      points: [
        'Define HSE organisation, responsibilities, procedures and emergency arrangements.',
        'Align the plan with project scope, construction sequence and applicable requirements.',
        'Implement controls at the workface, not only in documentation.',
        'Review the plan when scope, sequence or significant risks change.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Risk Assessment',
      subtitle: 'Identify hazards, assess risk and establish controls',
      points: [
        'Assess the actual task, location, people, plant, materials and interfaces.',
        'Use the hierarchy of controls when selecting risk controls.',
        'Brief affected workers before exposure.',
        'Reassess when conditions, sequence or equipment change.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Method Statement / RAMS',
      subtitle: 'Safe sequence and control of the activity',
      points: [
        'Define the work sequence, resources, equipment, hazards and controls.',
        'Include supervision, hold points and emergency arrangements.',
        'Brief the workforce before work starts and after significant changes.',
        'Stop and review when field conditions materially differ from the approved method.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Competent Persons & Supervision',
      subtitle: 'Suitable competence and effective field oversight',
      points: [
        'Assign people with appropriate knowledge, training and experience.',
        'Match supervision to the risk and complexity of the work.',
        'Verify changing conditions and critical controls.',
        'Intervene when unsafe work or failed controls are identified.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'High-Risk Activities',
      subtitle: 'Enhanced planning for safety-critical work',
      points: [
        'Typical examples include lifting, excavation, work at height, confined space, hot work and electrical work.',
        'Use activity-specific risk assessment, method statement and permit controls where applicable.',
        'Verify critical barriers before exposure.',
        'Coordinate simultaneous operations and interfaces.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Temporary Works',
      subtitle: 'Control of temporary structures and support systems',
      points: [
        'Ensure temporary works are appropriately designed, checked, installed and inspected.',
        'Control excavation support, formwork, falsework and temporary access systems.',
        'Prevent unauthorised modification or removal.',
        'Review controls when loading, sequence or conditions change.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Plant, Machinery & Equipment',
      subtitle: 'Safe selection, inspection and operation',
      points: [
        'Use suitable equipment operated by authorised and competent personnel.',
        'Verify guarding, safety devices, inspection status and condition.',
        'Separate pedestrians and mobile plant.',
        'Remove defective equipment from service until corrected.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Work at Height',
      subtitle: 'Prevent falls and falling-object exposure',
      points: [
        'Plan work at height and select suitable fall-prevention measures.',
        'Prefer collective protection where reasonably practicable.',
        'Control edges, openings, fragile surfaces and dropped objects.',
        'Stop work when protection is missing or compromised.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Excavation & Ground Works',
      subtitle: 'Control collapse, falls, services and ground movement',
      points: [
        'Assess ground conditions, excavation geometry, services and nearby structures.',
        'Use suitable approved protection systems.',
        'Control edge loading, spoil, plant, access, water and public exposure.',
        'Inspect before entry and after events or changes affecting stability.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Lifting Operations',
      subtitle: 'Plan and control lifting, rigging and load movement',
      points: [
        'Use an appropriate lifting plan and competent lifting team.',
        'Verify equipment, accessories, load information and ground conditions.',
        'Establish communication and exclusion zones.',
        'Stop the lift when the plan or critical controls are no longer valid.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Traffic & Public Protection',
      subtitle: 'Protect workers, road users and the public',
      points: [
        'Separate pedestrians and vehicles with suitable controls.',
        'Manage gates, deliveries, reversing and blind spots.',
        'Maintain public protection throughout construction.',
        'Review arrangements when site layout or traffic flow changes.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Emergency Preparedness',
      subtitle: 'Prepared response to foreseeable emergencies',
      points: [
        'Identify credible project-specific emergencies.',
        'Establish alarm, communication, evacuation and rescue arrangements.',
        'Provide suitable emergency equipment and access.',
        'Review drills, incidents and changed site conditions.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Inspection & Audit',
      subtitle: 'Verify that controls exist and work',
      points: [
        'Conduct planned and risk-based field inspections.',
        'Check physical workface conditions, not paperwork alone.',
        'Assign and track corrective actions.',
        'Verify effectiveness before closing significant findings.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Incident & Near-Miss Reporting',
      subtitle: 'Learn from events and prevent recurrence',
      points: [
        'Report incidents, near misses and significant unsafe conditions promptly.',
        'Preserve relevant information for investigation.',
        'Identify immediate, underlying and system causes where appropriate.',
        'Implement and verify corrective and preventive actions.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Contractor & Subcontractor Control',
      subtitle: 'Coordinate HSE requirements across the supply chain',
      points: [
        'Set clear HSE expectations and responsibilities.',
        'Verify competence, planning, documentation and field implementation.',
        'Coordinate shared work areas and simultaneous operations.',
        'Escalate repeated or serious control failures.',
      ],
    ),
  ];

  static const sections = <ConstructionSafetySection>[
    ConstructionSafetySection(
      '1. Introduction — What is Dubai Construction Safety Framework?',
      'A construction safety framework is the organised system used to plan, control, supervise and verify construction HSE controls. It connects project management arrangements with practical workface safety.',
    ),
    ConstructionSafetySection(
      '2. Construction Safety Management System',
      'Establish responsibilities, procedures, competent personnel, communication, inspection, incident management and continual improvement across the project.',
    ),
    ConstructionSafetySection(
      '3. Project HSE Plan',
      'Define the project HSE organisation, risk-management process, high-risk activity controls, emergency arrangements, welfare arrangements, inspection programme and performance monitoring.',
    ),
    ConstructionSafetySection(
      '4. Risk Assessment & Planning',
      'Assess the actual task and environment. Consider people, plant, materials, energy sources, access, public interfaces, simultaneous operations and foreseeable changes.',
    ),
    ConstructionSafetySection(
      '5. Method Statement / RAMS',
      'Convert risk controls into a practical work sequence. Define responsibilities, equipment, hold points and abnormal or emergency arrangements.',
    ),
    ConstructionSafetySection(
      '6. Competent Persons & Supervision',
      'Safety-critical activities require suitable competence and effective supervision. Supervisors verify implementation and intervene when conditions are unsafe.',
    ),
    ConstructionSafetySection(
      '7. High-Risk Activities',
      'Apply enhanced controls to activities with potentially serious consequences, including lifting, excavation, work at height, confined spaces, hot work and electrical activities.',
    ),
    ConstructionSafetySection(
      '8. Temporary Works',
      'Control design, checking, installation, loading, inspection and modification of temporary structures and support systems.',
    ),
    ConstructionSafetySection(
      '9. Plant, Machinery & Equipment',
      'Select suitable equipment, maintain it safely and ensure authorised operators use it correctly. Control interfaces between plant and pedestrians.',
    ),
    ConstructionSafetySection(
      '10. Work at Height',
      'Plan work at height to prevent falls and falling objects. Use suitable collective protection, safe access and fall-prevention systems.',
    ),
    ConstructionSafetySection(
      '11. Excavation & Ground Works',
      'Plan excavation considering ground conditions, services, adjacent structures, protection systems, access, water, spoil and plant.',
    ),
    ConstructionSafetySection(
      '12. Lifting Operations',
      'Plan and control lifting through competent personnel, suitable equipment, accessories, ground conditions, communication and exclusion zones.',
    ),
    ConstructionSafetySection(
      '13. Traffic & Public Protection',
      'Organise construction traffic to minimise vehicle-person interaction and protect the public through suitable routes, barriers and controlled access.',
    ),
    ConstructionSafetySection(
      '14. Emergency Preparedness',
      'Prepare for credible emergencies such as fire, collapse, service strike, serious injury and flooding, with clear alarm, evacuation and rescue arrangements.',
    ),
    ConstructionSafetySection(
      '15. Inspection, Audit & Monitoring',
      'Use field inspections, audits and performance monitoring to verify implementation. Prioritise, assign, track and verify corrective actions.',
    ),
    ConstructionSafetySection(
      '16. Incident / Near-Miss Reporting',
      'Prompt reporting and effective investigation help identify failures and prevent recurrence. Focus on causes and system improvements.',
    ),
    ConstructionSafetySection(
      '17. Contractor & Subcontractor HSE Management',
      'Coordinate HSE responsibilities across the supply chain and verify competence, planning, supervision and field implementation.',
    ),
    ConstructionSafetySection(
      '18. Stop-Work Conditions',
      'Stop work when a serious uncontrolled hazard exists, a critical barrier fails, required supervision is absent, or actual conditions materially differ from the approved method.',
    ),
    ConstructionSafetySection(
      '19. Practical Site Example',
      'A crane lift, façade work and vehicle deliveries overlap. The team coordinates the sequence, verifies exclusion zones and work-at-height protection, separates traffic and briefs affected teams before starting.',
    ),
    ConstructionSafetySection(
      '20. Quick Learning Formula',
      'PLAN → ASSESS → CONTROL → AUTHORISE → BRIEF → SUPERVISE → INSPECT → CORRECT → VERIFY → STOP WHEN UNSAFE.',
    ),
    ConstructionSafetySection(
      '21. HSE Roles — Topic-wise Responsibilities',
      'HSE Officer, HSE Supervisor, Senior HSE, HSE Coordinator, HSE Engineer and HSE Manager have different levels of field monitoring, coordination, technical assurance and governance responsibility. Detailed role responsibilities are available through Advanced Learning.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        title: const Text('Dubai Construction Safety Framework'),
        backgroundColor: green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          Card(
            elevation: 1.5,
            child: const Padding(
              padding: EdgeInsets.all(19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('🏗️ Introduction — What is it?',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
                  SizedBox(height: 10),
                  Text(
                    'The Dubai Construction Safety Framework is the organised approach used to plan, manage, supervise and verify construction HSE controls. It connects project management arrangements with practical workface safety.',
                    style: TextStyle(fontSize: 15, height: 1.55),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...sections.map(
            (section) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ExpansionTile(
                title: Text(section.title,
                    style: const TextStyle(fontWeight: FontWeight.w800)),
                childrenPadding:
                    const EdgeInsets.fromLTRB(17, 0, 17, 17),
                children: [
                  Text(section.body,
                      style: const TextStyle(fontSize: 15, height: 1.55)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Text('Advanced Learning',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Card(
              margin: const EdgeInsets.only(bottom: 9),
              color: const Color(0xFFF4F8F6),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                title: Text(item.title,
                    style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(item.subtitle),
                ),
                trailing: const Icon(Icons.chevron_right_rounded, size: 26),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        DubaiConstructionSafetyAdvancedLearningPage(
                      item: item,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
