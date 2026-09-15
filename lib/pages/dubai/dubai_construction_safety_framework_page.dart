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

class DubaiConstructionSafetyFrameworkPage extends StatelessWidget {
  const DubaiConstructionSafetyFrameworkPage({super.key});

  static const green = Color(0xFF0B7653);
  static const bg = Color(0xFFF5F8F7);

  static const items = <ConstructionSafetyItem>[
    ConstructionSafetyItem(
      title: 'Project HSE Plan',
      subtitle: 'The project-level framework for managing construction HSE',
      points: [
        'Defines the project HSE organisation, responsibilities, procedures, emergency arrangements and monitoring programme.',
        'Should be aligned with the project scope, construction sequence, applicable Dubai requirements and contractor arrangements.',
        'The plan must be implemented at the workface, not treated only as a document.',
        'Changes in scope, sequence or significant risk should trigger review and update.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Risk Assessment',
      subtitle: 'Identify hazards, assess risk and establish effective controls',
      points: [
        'Identify hazards associated with the actual task, location, people, plant, materials and interfaces.',
        'Consider existing controls and determine additional measures using the hierarchy of controls.',
        'Communicate the approved controls to the workforce before exposure.',
        'Reassess when conditions, sequence, equipment or interfaces change.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Method Statement / RAMS',
      subtitle: 'Safe sequence and control of the work activity',
      points: [
        'Describe the work sequence, resources, equipment, hazards, controls, supervision and emergency arrangements.',
        'Ensure the method reflects actual site conditions and interfaces.',
        'Brief affected workers before work starts and after significant changes.',
        'Do not continue when field conditions materially differ from the approved method without review.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Competent Person & Supervision',
      subtitle: 'Safety-critical activities require suitable competence and oversight',
      points: [
        'Assign people with suitable knowledge, training, experience and authority for safety-critical tasks.',
        'Supervision should be proportionate to the risk and complexity of the activity.',
        'Competent persons must identify changing conditions and take appropriate action.',
        'Unsafe work must be stopped and escalated when critical controls are absent.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'High-Risk Activities',
      subtitle: 'Enhanced planning and control for safety-critical work',
      points: [
        'Typical high-risk activities include lifting, excavation, work at height, confined-space entry, hot work and electrical work.',
        'Use task-specific risk assessments, method statements, permits and competent supervision as applicable.',
        'Verify critical barriers at the workface before exposure.',
        'Coordinate simultaneous operations to prevent interface hazards.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Temporary Works',
      subtitle: 'Control of temporary structures and support systems',
      points: [
        'Temporary works should be appropriately designed, checked, installed, inspected and controlled.',
        'Examples include excavation support, formwork, falsework, access systems and temporary platforms.',
        'Prevent unauthorised modification or removal of safety-critical elements.',
        'Review temporary works when loads, sequence or site conditions change.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Plant, Machinery & Equipment',
      subtitle: 'Safe selection, inspection and operation',
      points: [
        'Use suitable equipment operated by authorised and competent personnel.',
        'Verify condition, guarding, safety devices, inspection status and operating controls.',
        'Separate people and mobile plant through suitable traffic and exclusion arrangements.',
        'Remove defective equipment from service until the required corrective action is completed.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Work at Height',
      subtitle: 'Prevent falls and falling-object exposure',
      points: [
        'Plan work at height and select suitable access and fall-prevention measures.',
        'Prefer collective protection where reasonably practicable.',
        'Control openings, edges, fragile surfaces, dropped objects and access routes.',
        'Inspect systems and stop work when protection is missing or compromised.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Excavation & Ground Works',
      subtitle: 'Control collapse, falls, services and ground movement',
      points: [
        'Assess ground conditions, excavation geometry, underground services and nearby structures.',
        'Use suitable protection such as approved shoring, trench protection, benching or sloping where required.',
        'Control edge loading, spoil, plant, access, water and public exposure.',
        'Inspect before entry and after events or changes affecting stability.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Lifting Operations',
      subtitle: 'Plan and control lifting, rigging and load movement',
      points: [
        'Use an appropriate lifting plan and competent lifting team.',
        'Verify crane or lifting-equipment suitability, accessories, load information and ground conditions.',
        'Establish communication, exclusion zones and control of suspended loads.',
        'Stop the lift when conditions differ from the approved plan or a critical control fails.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Traffic & Public Protection',
      subtitle: 'Protect workers, road users and the public',
      points: [
        'Separate pedestrians and vehicles using suitable routes, barriers, signs and controlled crossings.',
        'Manage gates, deliveries, reversing, blind spots and interaction with public areas.',
        'Maintain public protection arrangements throughout the construction phase.',
        'Review controls when site layout or traffic flow changes.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Emergency Preparedness',
      subtitle: 'Prepared response to foreseeable construction emergencies',
      points: [
        'Identify credible emergencies and establish alarm, communication, evacuation and rescue arrangements.',
        'Provide suitable emergency equipment and access for response.',
        'Brief workers and relevant contractors on emergency arrangements.',
        'Review lessons from drills, incidents and changes to site conditions.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Inspection & Audit',
      subtitle: 'Verify that planned controls exist and work',
      points: [
        'Conduct planned and targeted inspections based on risk.',
        'Check physical conditions at the workface rather than relying only on paperwork.',
        'Record findings, assign responsibility and track corrective actions.',
        'Verify effectiveness before closing significant findings.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Incident & Near-Miss Reporting',
      subtitle: 'Learn from events and prevent recurrence',
      points: [
        'Report incidents, near misses and significant unsafe conditions promptly.',
        'Preserve relevant information and support appropriate investigation.',
        'Identify immediate, underlying and system-level causes where applicable.',
        'Implement and verify corrective and preventive actions.',
      ],
    ),
    ConstructionSafetyItem(
      title: 'Contractor & Subcontractor Control',
      subtitle: 'Coordinate HSE requirements across the project supply chain',
      points: [
        'Establish clear HSE expectations, responsibilities and interfaces before work starts.',
        'Verify competence, documentation, risk controls and site implementation.',
        'Coordinate simultaneous activities and shared work areas.',
        'Monitor performance and escalate repeated or serious control failures.',
      ],
    ),
  ];

  static const sections = <ConstructionSafetySection>[
    ConstructionSafetySection(
      '1. Introduction — What is Dubai Construction Safety Framework?',
      'A construction safety framework is the organised system used to plan, control, supervise and verify construction activities so workers, the public, property and the environment are protected. It connects management arrangements with practical workface controls.',
    ),
    ConstructionSafetySection(
      '2. Construction Safety Management System',
      'Establish clear responsibilities, procedures, competent personnel, communication, inspection, incident management and continual improvement. The system should be implemented consistently across contractors, subcontractors and work fronts.',
    ),
    ConstructionSafetySection(
      '3. Project HSE Plan',
      'Define the project HSE organisation, applicable requirements, risk-management process, high-risk activity controls, emergency arrangements, welfare arrangements, inspection programme, reporting and performance monitoring.',
    ),
    ConstructionSafetySection(
      '4. Risk Assessment & Planning',
      'Assess the actual task and environment before exposure. Consider people, plant, materials, ground conditions, energy sources, access, public interfaces, simultaneous operations and foreseeable changes. Controls should follow the hierarchy of controls.',
    ),
    ConstructionSafetySection(
      '5. Method Statement / RAMS',
      'Convert risk controls into a practical work sequence. The method should explain how the task will be executed safely, who is responsible, what equipment is required, what hold points apply and what happens during abnormal or emergency conditions.',
    ),
    ConstructionSafetySection(
      '6. Competent Persons & Supervision',
      'Safety-critical activities require suitable competence and effective supervision. Supervisors must verify implementation and intervene when conditions are unsafe or outside the approved method.',
    ),
    ConstructionSafetySection(
      '7. High-Risk Activities',
      'Apply enhanced controls to activities with potentially serious consequences. Typical examples include lifting, excavation, work at height, confined spaces, hot work and electrical activities. Use activity-specific controls rather than generic wording.',
    ),
    ConstructionSafetySection(
      '8. Temporary Works',
      'Temporary works can fail if design, installation, loading, inspection or modification is uncontrolled. Maintain an appropriate design/checking process and prevent unauthorised changes to safety-critical temporary works.',
    ),
    ConstructionSafetySection(
      '9. Plant, Machinery & Equipment',
      'Select suitable equipment, maintain it in safe condition and ensure authorised operators use it correctly. Control interfaces between plant and pedestrians and isolate defective equipment from use.',
    ),
    ConstructionSafetySection(
      '10. Work at Height',
      'Plan work at height to prevent falls and falling objects. Use suitable collective protection, safe access, fall-prevention systems and exclusion arrangements. Verify controls at the workface.',
    ),
    ConstructionSafetySection(
      '11. Excavation & Ground Works',
      'Plan excavation with consideration of soil/ground conditions, services, adjacent structures, protection systems, access, water, spoil and plant. Conditions must be inspected and reassessed when they change.',
    ),
    ConstructionSafetySection(
      '12. Lifting Operations',
      'Lifting must be planned and controlled by competent personnel. Verify equipment and accessories, load information, ground conditions, communication, exclusion zones and the approved lifting sequence.',
    ),
    ConstructionSafetySection(
      '13. Traffic & Public Protection',
      'Construction traffic must be organised to minimise vehicle-person interaction and protect the public. Maintain barriers, routes, signage, delivery controls and site access arrangements.',
    ),
    ConstructionSafetySection(
      '14. Emergency Preparedness',
      'Prepare for credible emergencies including fire, collapse, service strike, serious injury, flooding and other project-specific events. Ensure alarm, communication, evacuation, rescue and emergency access arrangements are understood.',
    ),
    ConstructionSafetySection(
      '15. Inspection, Audit & Monitoring',
      'Use field inspections, audits and performance monitoring to verify implementation. Findings should be prioritised, assigned, tracked and closed only after effectiveness is verified.',
    ),
    ConstructionSafetySection(
      '16. Incident / Near-Miss Reporting',
      'Prompt reporting and effective investigation help identify failures before recurrence. Focus on causes and system improvements, not only individual actions.',
    ),
    ConstructionSafetySection(
      '17. Contractor & Subcontractor HSE Management',
      'Coordinate HSE responsibilities across the supply chain. Verify competence, planning, supervision, documentation and field implementation and maintain effective interface management.',
    ),
    ConstructionSafetySection(
      '18. Stop-Work Conditions',
      'Stop work when a serious uncontrolled hazard exists, a critical safety barrier fails, required competent supervision is absent, conditions differ materially from the approved method, or continuing would expose people to unacceptable risk.',
    ),
    ConstructionSafetySection(
      '19. Practical Site Example',
      'A project plans simultaneous tower-crane lifting, façade work and vehicle deliveries. The HSE team coordinates the sequence, verifies lifting and exclusion zones, separates traffic and pedestrian routes, confirms work-at-height protection and briefs affected teams before starting.',
    ),
    ConstructionSafetySection(
      '20. Quick Learning Formula',
      'PLAN → ASSESS → CONTROL → AUTHORISE → BRIEF → SUPERVISE → INSPECT → CORRECT → VERIFY → STOP WHEN UNSAFE.',
    ),
    ConstructionSafetySection(
      '21. HSE Roles — Topic-wise Responsibilities',
      'HSE Officer, HSE Supervisor, Senior HSE, HSE Coordinator, HSE Engineer and HSE Manager have different levels of field monitoring, supervision, coordination, technical assurance and governance responsibility. These role responsibilities are consolidated in the Advanced Learning flow rather than repeated throughout every section.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('Dubai Construction Safety Framework'),
        backgroundColor: green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          _introCard(),
          const SizedBox(height: 12),
          ...sections.map((s) => _sectionCard(context, s)),
          const SizedBox(height: 6),
          const Text(
            'Explore in Advanced Learning',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: Color(0xFF17332A)),
          ),
          const SizedBox(height: 8),
          ...items.map((item) => _itemCard(context, item)),
        ],
      ),
    );
  }

  Widget _introCard() => Card(
        elevation: 1.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Padding(
          padding: EdgeInsets.all(19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('🏗️ Introduction — What is it?', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
              SizedBox(height: 10),
              Text(
                'The Dubai Construction Safety Framework is the organised approach used to plan, manage, supervise and verify construction HSE controls. It connects project management arrangements with practical workface safety.',
                style: TextStyle(fontSize: 15, height: 1.55),
              ),
            ],
          ),
        ),
      );

  Widget _sectionCard(BuildContext context, ConstructionSafetySection section) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      child: ExpansionTile(
        title: Text(section.title, style: const TextStyle(fontWeight: FontWeight.w800)),
        childrenPadding: const EdgeInsets.fromLTRB(17, 0, 17, 17),
        children: [
          Text(section.body, style: const TextStyle(fontSize: 15, height: 1.55)),
        ],
      ),
    );
  }

  Widget _itemCard(BuildContext context, ConstructionSafetyItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      elevation: 1,
      color: const Color(0xFFF4F8F6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFD7E7E0)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(item.subtitle),
        ),
        trailing: const Icon(Icons.chevron_right_rounded, size: 26),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DubaiConstructionSafetyAdvancedLearningPage(item: item),
          ),
        ),
      ),
    );
  }
}
