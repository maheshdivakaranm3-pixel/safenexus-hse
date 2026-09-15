import 'package:flutter/material.dart';

class DubaiFrameworkItem {
  final String title;
  final String subtitle;
  final List<String> learning;
  final List<String> fieldChecks;
  final List<String> criticalControls;
  final List<String> stopWork;

  const DubaiFrameworkItem({
    required this.title,
    required this.subtitle,
    required this.learning,
    required this.fieldChecks,
    required this.criticalControls,
    required this.stopWork,
  });
}

class DubaiFrameworkSection {
  final String title;
  final String overview;
  final List<DubaiFrameworkItem> items;

  const DubaiFrameworkSection({
    required this.title,
    required this.overview,
    this.items = const [],
  });
}

class DubaiConstructionSafetyFrameworkPage extends StatelessWidget {
  const DubaiConstructionSafetyFrameworkPage({super.key});

  static const green = Color(0xFF0B7653);

  static const sections = <DubaiFrameworkSection>[
    DubaiFrameworkSection(
      title: '1. Introduction — What is Dubai Construction Safety Framework?',
      overview:
          'A project-wide system for planning, controlling, supervising and verifying construction safety. It connects management arrangements with practical workface controls.',
      items: [
        DubaiFrameworkItem(
          title: 'Purpose of the Framework',
          subtitle: 'Why the framework exists',
          learning: [
            'Protect workers, the public, property and the environment through organised risk control.',
            'Connect project management decisions with actual construction activities.',
            'Provide a consistent basis for planning, supervision, inspection and improvement.',
          ],
          fieldChecks: [
            'Project HSE requirements are communicated to the work teams.',
            'Responsibilities and escalation routes are clear.',
            'Workface controls match the planned activity.',
          ],
          criticalControls: [
            'Clear HSE leadership.',
            'Risk-based planning.',
            'Competent supervision.',
            'Verification at the workface.',
          ],
          stopWork: [
            'Critical controls are absent.',
            'The actual work is outside the approved safe method.',
            'A serious uncontrolled hazard is identified.',
          ],
        ),
      ],
    ),
    DubaiFrameworkSection(
      title: '2. Construction Safety Management System',
      overview:
          'The management system establishes the organisation, responsibilities, procedures, communication, assurance and continual-improvement process.',
      items: [
        DubaiFrameworkItem(
          title: 'HSE Organisation',
          subtitle: 'Define authority, accountability and interfaces',
          learning: [
            'Define who manages, supervises, verifies and escalates HSE matters.',
            'Ensure construction, engineering, HSE and subcontractor interfaces are understood.',
            'Give responsible personnel sufficient authority to intervene in unsafe work.',
          ],
          fieldChecks: [
            'Organisation and responsibilities are understood at site level.',
            'Supervisors know who to contact for technical HSE decisions.',
            'Escalation routes are functional.',
          ],
          criticalControls: [
            'Clear accountability.',
            'Competent supervision.',
            'Effective communication.',
          ],
          stopWork: [
            'Required competent supervision is unavailable.',
            'Responsibility for a safety-critical activity is unclear.',
          ],
        ),
        DubaiFrameworkItem(
          title: 'HSE Communication & Coordination',
          subtitle: 'Keep teams aligned before and during work',
          learning: [
            'Coordinate construction activities, interfaces and simultaneous operations.',
            'Use briefings and toolbox talks to communicate task-specific controls.',
            'Ensure changes are communicated before affected work continues.',
          ],
          fieldChecks: [
            'Affected teams have received the relevant briefing.',
            'SIMOPS interfaces have been discussed.',
            'Changes are communicated to the workface.',
          ],
          criticalControls: [
            'Clear communication.',
            'Interface coordination.',
            'Change management.',
          ],
          stopWork: [
            'Workers do not understand critical controls.',
            'Conflicting activities create an uncontrolled interface.',
          ],
        ),
      ],
    ),
    DubaiFrameworkSection(
      title: '3. Project HSE Plan',
      overview:
          'The project HSE plan establishes the project-specific arrangements for managing HSE risks, responsibilities, emergency response, monitoring and improvement.',
      items: [
        DubaiFrameworkItem(
          title: 'HSE Plan Implementation',
          subtitle: 'Turn the plan into field controls',
          learning: [
            'Define project HSE objectives, responsibilities, procedures and monitoring arrangements.',
            'Integrate high-risk activities, emergency arrangements and contractor controls.',
            'Review the plan when project scope or significant risks change.',
          ],
          fieldChecks: [
            'Current requirements are available to responsible teams.',
            'Planned controls are visible at the workface.',
            'Actions and inspections are being tracked.',
          ],
          criticalControls: [
            'Approved project arrangements.',
            'Implementation at site level.',
            'Periodic review.',
          ],
          stopWork: [
            'Critical project HSE controls have not been established.',
            'Work is proceeding under materially outdated arrangements.',
          ],
        ),
      ],
    ),
    DubaiFrameworkSection(
      title: '4. Risk Assessment & Planning',
      overview:
          'Risk assessment identifies hazards, evaluates exposure and establishes controls before work starts and whenever conditions change.',
      items: [
        DubaiFrameworkItem(
          title: 'Task Risk Assessment',
          subtitle: 'Assess the actual workface',
          learning: [
            'Consider task, location, people, plant, materials, energy sources and interfaces.',
            'Apply the hierarchy of controls when selecting measures.',
            'Reassess when conditions or the work sequence change.',
          ],
          fieldChecks: [
            'Risk assessment reflects actual site conditions.',
            'Workers understand critical controls.',
            'Changes are captured before exposure.',
          ],
          criticalControls: [
            'Hazard identification.',
            'Effective controls.',
            'Worker communication.',
            'Change management.',
          ],
          stopWork: [
            'A significant hazard is not assessed.',
            'Controls are ineffective or cannot be implemented.',
          ],
        ),
      ],
    ),
    DubaiFrameworkSection(
      title: '5. Method Statement / RAMS',
      overview:
          'RAMS converts risk controls into an approved, practical sequence for performing the work safely.',
      items: [
        DubaiFrameworkItem(
          title: 'RAMS Work Sequence',
          subtitle: 'Define how the job will actually be done',
          learning: [
            'Describe the work sequence, resources, equipment, controls and supervision.',
            'Include hold points and abnormal or emergency arrangements where relevant.',
            'Brief affected personnel before starting.',
          ],
          fieldChecks: [
            'Method matches the actual work.',
            'Workers have been briefed.',
            'Required resources and controls are available.',
          ],
          criticalControls: [
            'Approved method.',
            'Competent supervision.',
            'Workface briefing.',
          ],
          stopWork: [
            'Work differs materially from the approved method.',
            'Required control or resource is unavailable.',
          ],
        ),
      ],
    ),
    DubaiFrameworkSection(
      title: '6. Competent Persons & Supervision',
      overview:
          'Safety-critical work requires suitable competence, clear authority and supervision proportionate to the risk.',
      items: [
        DubaiFrameworkItem(
          title: 'Competent Person',
          subtitle: 'Knowledge, training, experience and authority',
          learning: [
            'Assign competent personnel for safety-critical activities.',
            'Competence must match the task and its hazards.',
            'Competent persons should identify changing conditions and intervene when necessary.',
          ],
          fieldChecks: [
            'Competence is verified for assigned duties.',
            'Supervision is present where required.',
            'Safety-critical decisions have clear ownership.',
          ],
          criticalControls: [
            'Suitable competence.',
            'Effective supervision.',
            'Authority to intervene.',
          ],
          stopWork: [
            'Required competent person is absent.',
            'Personnel are performing safety-critical work beyond their competence.',
          ],
        ),
      ],
    ),
    DubaiFrameworkSection(
      title: '7. High-Risk Activities',
      overview:
          'High-risk construction activities require enhanced planning, competent control and verification of critical barriers.',
      items: [
        DubaiFrameworkItem(
          title: 'High-Risk Activity Control',
          subtitle: 'Use activity-specific controls',
          learning: [
            'Examples include lifting, excavation, work at height, confined space, hot work and electrical work.',
            'Use task-specific RAMS, permits and competent supervision where applicable.',
            'Coordinate interfaces before simultaneous operations begin.',
          ],
          fieldChecks: [
            'Activity-specific controls are in place.',
            'Required permits and authorisations are valid.',
            'Critical barriers have been verified.',
          ],
          criticalControls: [
            'Planning.',
            'Competence.',
            'Permit/authorisation where applicable.',
            'Field verification.',
          ],
          stopWork: [
            'A critical barrier is missing.',
            'Required authorisation is absent or invalid.',
          ],
        ),
      ],
    ),
    DubaiFrameworkSection(
      title: '8. Temporary Works',
      overview:
          'Temporary structures and support systems must be appropriately designed, checked, installed, inspected and controlled.',
      items: [
        DubaiFrameworkItem(
          title: 'Temporary Works Control',
          subtitle: 'Control design, loading and modification',
          learning: [
            'Consider excavation support, formwork, falsework, temporary platforms and access systems.',
            'Prevent unauthorised modification or removal of safety-critical elements.',
            'Review when loads, sequence or conditions change.',
          ],
          fieldChecks: [
            'Current approved information is available.',
            'Installation matches the intended arrangement.',
            'Inspections and hold points are completed.',
          ],
          criticalControls: [
            'Design/checking.',
            'Correct installation.',
            'Inspection.',
            'Controlled modification.',
          ],
          stopWork: [
            'Temporary works show instability, damage or unexpected movement.',
            'Unauthorised modification is identified.',
          ],
        ),
      ],
    ),
    DubaiFrameworkSection(
      title: '9. Plant, Machinery & Equipment',
      overview:
          'Equipment must be suitable, maintained, inspected and operated by authorised competent personnel.',
      items: [
        DubaiFrameworkItem(
          title: 'Plant Safety',
          subtitle: 'Control equipment and people interfaces',
          learning: [
            'Verify suitability, condition, guarding, safety devices and inspection status.',
            'Control interaction between mobile plant and pedestrians.',
            'Remove defective equipment from service until corrected.',
          ],
          fieldChecks: [
            'Equipment is suitable and in acceptable condition.',
            'Operators are authorised and competent.',
            'Pedestrian segregation is effective.',
          ],
          criticalControls: [
            'Equipment integrity.',
            'Operator competence.',
            'Guarding and safety devices.',
            'Segregation.',
          ],
          stopWork: [
            'Safety-critical equipment defect is identified.',
            'Unsafe plant-person interaction cannot be controlled.',
          ],
        ),
      ],
    ),
    DubaiFrameworkSection(
      title: '10. Work at Height',
      overview:
          'Plan work at height to prevent falls and falling objects through suitable access, collective protection and fall-prevention controls.',
      items: [
        DubaiFrameworkItem(
          title: 'Work-at-Height Control',
          subtitle: 'Prevent falls before exposure',
          learning: [
            'Select suitable access and fall-prevention measures.',
            'Prefer collective protection where reasonably practicable.',
            'Control edges, openings, fragile surfaces and falling objects.',
          ],
          fieldChecks: [
            'Access and protection are suitable for the task.',
            'Edges and openings are protected.',
            'Falling-object controls are effective.',
          ],
          criticalControls: [
            'Safe access.',
            'Collective protection.',
            'Fall prevention.',
            'Dropped-object control.',
          ],
          stopWork: [
            'Required edge or fall protection is missing.',
            'Access system is unsafe or compromised.',
          ],
        ),
      ],
    ),
    DubaiFrameworkSection(
      title: '11. Excavation & Ground Works',
      overview:
          'Excavation requires control of ground stability, underground services, access, water, plant, spoil and adjacent structures.',
      items: [
        DubaiFrameworkItem(
          title: 'Excavation Safety',
          subtitle: 'Control ground-related hazards',
          learning: [
            'Assess ground conditions, excavation geometry and nearby structures.',
            'Use suitable protection systems based on the approved design and competent assessment.',
            'Control spoil, plant, water, access and public exposure.',
          ],
          fieldChecks: [
            'Protection system is suitable and intact.',
            'Access and egress are controlled.',
            'Spoil and plant are appropriately managed.',
          ],
          criticalControls: [
            'Ground stability.',
            'Protection system.',
            'Service identification.',
            'Safe access.',
          ],
          stopWork: [
            'Instability, unexpected movement or serious deterioration is observed.',
            'Underground service is exposed or damaged unexpectedly.',
          ],
        ),
      ],
    ),
    DubaiFrameworkSection(
      title: '12. Lifting Operations',
      overview:
          'Lifting operations require planned load handling, competent personnel, suitable equipment, communication and exclusion controls.',
      items: [
        DubaiFrameworkItem(
          title: 'Lifting Plan',
          subtitle: 'Plan the lift before load movement',
          learning: [
            'Define the load, lifting equipment, accessories, route, landing area and sequence.',
            'Consider ground conditions, overhead hazards, interfaces and exclusion zones.',
            'Assign competent lifting personnel and clear communication arrangements.',
          ],
          fieldChecks: [
            'Lifting plan is available and matches the actual lift.',
            'Equipment and accessories are suitable and inspected.',
            'Exclusion zone and communication are effective.',
          ],
          criticalControls: [
            'Approved lifting plan.',
            'Competent lifting team.',
            'Suitable equipment and accessories.',
            'Exclusion zone.',
          ],
          stopWork: [
            'Load information or lifting conditions are uncertain.',
            'Critical lifting control fails.',
            'People enter the controlled lifting zone.',
          ],
        ),
      ],
    ),
    DubaiFrameworkSection(
      title: '13. Traffic & Public Protection',
      overview:
          'Construction traffic controls protect workers, road users and the public from vehicle movement and site interfaces.',
      items: [
        DubaiFrameworkItem(
          title: 'Traffic Management',
          subtitle: 'Separate vehicles and pedestrians',
          learning: [
            'Establish suitable routes, barriers, signs and controlled crossings.',
            'Manage deliveries, reversing, blind spots and site gates.',
            'Review arrangements when site layout changes.',
          ],
          fieldChecks: [
            'Routes and barriers are maintained.',
            'Vehicle-person interaction is controlled.',
            'Public protection remains effective.',
          ],
          criticalControls: [
            'Segregation.',
            'Traffic control.',
            'Visibility.',
            'Public protection.',
          ],
          stopWork: [
            'Vehicle movement creates an uncontrolled serious exposure.',
            'Public protection is breached.',
          ],
        ),
      ],
    ),
    DubaiFrameworkSection(
      title: '14. Emergency Preparedness',
      overview:
          'Emergency arrangements must address credible project-specific events and provide clear alarm, communication, evacuation and rescue arrangements.',
      items: [
        DubaiFrameworkItem(
          title: 'Emergency Response',
          subtitle: 'Prepare before an emergency occurs',
          learning: [
            'Identify credible emergencies and define response arrangements.',
            'Provide suitable emergency equipment and access.',
            'Brief workers and relevant contractors and learn from drills or events.',
          ],
          fieldChecks: [
            'Emergency routes and access are available.',
            'Personnel know alarm and evacuation arrangements.',
            'Required equipment is accessible.',
          ],
          criticalControls: [
            'Alarm.',
            'Communication.',
            'Evacuation.',
            'Rescue readiness.',
          ],
          stopWork: [
            'Emergency access or escape is blocked.',
            'Required emergency arrangements are unavailable for a high-risk activity.',
          ],
        ),
      ],
    ),
    DubaiFrameworkSection(
      title: '15. Inspection, Audit & Monitoring',
      overview:
          'Inspection and audit verify whether planned controls are present, effective and maintained.',
      items: [
        DubaiFrameworkItem(
          title: 'Field Inspection',
          subtitle: 'Verify physical conditions',
          learning: [
            'Use planned and risk-based inspections.',
            'Check the physical workface rather than relying on paperwork alone.',
            'Assign, track and verify corrective actions.',
          ],
          fieldChecks: [
            'Findings are recorded clearly.',
            'Actions have responsible persons and priorities.',
            'Closure is verified for significant findings.',
          ],
          criticalControls: [
            'Field verification.',
            'Action ownership.',
            'Effectiveness check.',
          ],
          stopWork: [
            'Inspection identifies an immediate serious uncontrolled hazard.',
          ],
        ),
      ],
    ),
    DubaiFrameworkSection(
      title: '16. Incident / Near-Miss Reporting',
      overview:
          'Reporting and investigation provide learning that can prevent recurrence and improve the HSE system.',
      items: [
        DubaiFrameworkItem(
          title: 'Incident Learning',
          subtitle: 'Move from event to prevention',
          learning: [
            'Report incidents, near misses and significant unsafe conditions promptly.',
            'Preserve relevant information and support appropriate investigation.',
            'Identify causes and implement corrective and preventive actions.',
          ],
          fieldChecks: [
            'Events are reported through the project process.',
            'Actions are assigned and tracked.',
            'Lessons are communicated to affected teams.',
          ],
          criticalControls: [
            'Prompt reporting.',
            'Effective investigation.',
            'Corrective action.',
            'Learning communication.',
          ],
          stopWork: [
            'A serious event reveals an immediate continuing exposure.',
          ],
        ),
      ],
    ),
    DubaiFrameworkSection(
      title: '17. Contractor & Subcontractor HSE Management',
      overview:
          'HSE requirements must be coordinated across contractors and subcontractors through clear expectations, competence checks and field monitoring.',
      items: [
        DubaiFrameworkItem(
          title: 'Contractor Interface Control',
          subtitle: 'Manage the whole project supply chain',
          learning: [
            'Set clear HSE expectations before work starts.',
            'Verify competence, planning, supervision and field implementation.',
            'Coordinate shared work areas and simultaneous operations.',
          ],
          fieldChecks: [
            'Contractor controls are implemented at site level.',
            'Interfaces and responsibilities are clear.',
            'Performance is monitored.',
          ],
          criticalControls: [
            'Prequalification/competence.',
            'Clear responsibilities.',
            'Interface coordination.',
            'Performance monitoring.',
          ],
          stopWork: [
            'Contractor is performing critical work without required competence or controls.',
          ],
        ),
      ],
    ),
    DubaiFrameworkSection(
      title: '18. Stop-Work Conditions',
      overview:
          'Stop work whenever a serious uncontrolled hazard or failed critical barrier makes continued exposure unacceptable.',
      items: [
        DubaiFrameworkItem(
          title: 'Stop-Work Decision',
          subtitle: 'Know when work must not continue',
          learning: [
            'Stop when a critical safety barrier is missing or has failed.',
            'Stop when actual conditions materially differ from the approved method.',
            'Escalate, correct and verify before restarting.',
          ],
          fieldChecks: [
            'Hazard is controlled before restart.',
            'Responsible person authorises the revised safe approach.',
            'Affected workers are re-briefed.',
          ],
          criticalControls: [
            'Immediate intervention.',
            'Corrective action.',
            'Verification.',
            'Re-briefing.',
          ],
          stopWork: [
            'Serious uncontrolled hazard.',
            'Failed critical barrier.',
            'Unsafe changed condition.',
          ],
        ),
      ],
    ),
    DubaiFrameworkSection(
      title: '19. Practical Site Example',
      overview:
          'A crane lift, façade work and vehicle deliveries overlap in one workfront. The framework is applied through SIMOPS planning and workface verification.',
      items: [
        DubaiFrameworkItem(
          title: 'SIMOPS Decision',
          subtitle: 'Coordinate multiple activities safely',
          learning: [
            'Sequence activities so one operation does not create uncontrolled exposure for another.',
            'Verify lifting exclusion, work-at-height protection and traffic segregation.',
            'Brief all affected teams before the coordinated work starts.',
          ],
          fieldChecks: [
            'Interfaces have been reviewed.',
            'Exclusion zones are physically maintained.',
            'Supervision and communication are active.',
          ],
          criticalControls: [
            'SIMOPS coordination.',
            'Physical segregation.',
            'Competent supervision.',
            'Clear communication.',
          ],
          stopWork: [
            'One activity creates an uncontrolled exposure to another team.',
          ],
        ),
      ],
    ),
    DubaiFrameworkSection(
      title: '20. Quick Learning Formula',
      overview:
          'PLAN → ASSESS → CONTROL → AUTHORISE → BRIEF → SUPERVISE → INSPECT → CORRECT → VERIFY → STOP WHEN UNSAFE.',
      items: [
        DubaiFrameworkItem(
          title: '10-Step Field Formula',
          subtitle: 'A practical memory tool for HSE decision-making',
          learning: [
            'Plan the work.',
            'Assess the hazards.',
            'Select effective controls.',
            'Authorise where required.',
            'Brief the workforce.',
            'Supervise the activity.',
            'Inspect the workface.',
            'Correct deviations.',
            'Verify effectiveness.',
            'Stop whenever critical safety is not assured.',
          ],
          fieldChecks: [
            'Can the team explain the safe sequence?',
            'Can the supervisor identify critical controls?',
            'Can HSE verify the controls physically?',
          ],
          criticalControls: [
            'Planning.',
            'Risk control.',
            'Competence.',
            'Verification.',
          ],
          stopWork: [
            'Any critical step is missing where it is necessary to control the risk.',
          ],
        ),
      ],
    ),
    DubaiFrameworkSection(
      title: '21. HSE Roles — Topic-wise Responsibilities',
      overview:
          'HSE responsibilities are consolidated here so the framework remains clear without repeating the same role block throughout every topic.',
      items: [
        DubaiFrameworkItem(
          title: 'HSE Officer',
          subtitle: 'Front-line HSE verification',
          learning: [
            'Verify field implementation of approved controls.',
            'Conduct observations and inspections.',
            'Identify unsafe conditions and follow up actions.',
            'Support briefings, incident reporting and emergency readiness.',
          ],
          fieldChecks: [
            'Workface controls are present.',
            'Findings are recorded and followed up.',
          ],
          criticalControls: [
            'Field verification.',
            'Immediate escalation.',
          ],
          stopWork: [
            'Serious uncontrolled exposure is identified.',
          ],
        ),
        DubaiFrameworkItem(
          title: 'HSE Supervisor',
          subtitle: 'Daily HSE supervision and coordination',
          learning: [
            'Supervise daily HSE implementation.',
            'Coordinate controls with construction supervisors and subcontractors.',
            'Verify corrective actions.',
            'Intervene when critical controls fail.',
          ],
          fieldChecks: [
            'Supervision is active.',
            'Corrective actions are effective.',
          ],
          criticalControls: [
            'Supervision.',
            'Coordination.',
            'Action verification.',
          ],
          stopWork: [
            'Critical controls cannot be maintained.',
          ],
        ),
        DubaiFrameworkItem(
          title: 'Senior HSE',
          subtitle: 'Senior assurance for complex risks',
          learning: [
            'Provide assurance for high-risk activities and complex interfaces.',
            'Review recurring failures and significant findings.',
            'Challenge inadequate controls and support escalation.',
          ],
          fieldChecks: [
            'High-risk controls are consistent across work fronts.',
            'Recurring issues are addressed.',
          ],
          criticalControls: [
            'Senior assurance.',
            'Trend review.',
          ],
          stopWork: [
            'Major risk remains inadequately controlled.',
          ],
        ),
        DubaiFrameworkItem(
          title: 'HSE Coordinator',
          subtitle: 'HSE coordination and controlled information',
          learning: [
            'Coordinate HSE documentation, inspections, meetings and interfaces.',
            'Track actions, submissions and risk documents.',
            'Maintain controlled information flow.',
          ],
          fieldChecks: [
            'Current documents are available.',
            'Actions and submissions are tracked.',
          ],
          criticalControls: [
            'Coordination.',
            'Document control.',
            'Action tracking.',
          ],
          stopWork: [
            'Critical HSE information is unavailable or uncontrolled.',
          ],
        ),
        DubaiFrameworkItem(
          title: 'HSE Engineer',
          subtitle: 'Technical HSE assurance',
          learning: [
            'Provide technical HSE input to risk controls and high-risk activities.',
            'Review technical interfaces and changes affecting safety.',
            'Support complex HSE issue resolution and investigations.',
          ],
          fieldChecks: [
            'Technical controls match the actual work.',
            'Changes are technically reviewed where necessary.',
          ],
          criticalControls: [
            'Technical review.',
            'Interface assurance.',
          ],
          stopWork: [
            'Safety-critical technical control is inadequate or uncertain.',
          ],
        ),
        DubaiFrameworkItem(
          title: 'HSE Manager',
          subtitle: 'Project HSE governance and leadership',
          learning: [
            'Provide project-level HSE leadership, governance and resources.',
            'Review significant risks, trends and serious incidents.',
            'Ensure competence and contractor arrangements are effective.',
            'Support stop-work decisions and system improvement.',
          ],
          fieldChecks: [
            'Project HSE performance is reviewed.',
            'Major actions and resources are addressed.',
          ],
          criticalControls: [
            'Leadership.',
            'Governance.',
            'Resources.',
            'System improvement.',
          ],
          stopWork: [
            'Major project-level HSE risk cannot be acceptably controlled.',
          ],
        ),
      ],
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
          _header(),
          const SizedBox(height: 12),
          ...sections.map((section) => _section(context, section)),
        ],
      ),
    );
  }

  Widget _header() => Card(
        elevation: 1.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Padding(
          padding: EdgeInsets.all(19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('🏗️ Dubai Construction Safety Framework',
                  style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
              SizedBox(height: 9),
              Text(
                'Professional construction HSE learning structure: Introduction → Management → Planning → High-Risk Controls → Verification → Stop Work → HSE Roles.',
                style: TextStyle(fontSize: 15, height: 1.55),
              ),
            ],
          ),
        ),
      );

  Widget _section(BuildContext context, DubaiFrameworkSection section) {
    return Card(
      margin: const EdgeInsets.only(bottom: 11),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      child: ExpansionTile(
        title: Text(section.title,
            style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(section.overview, maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        children: section.items
            .map((item) => _item(context, item))
            .toList(),
      ),
    );
  }

  Widget _item(BuildContext context, DubaiFrameworkItem item) {
    return Card(
      margin: const EdgeInsets.only(top: 7),
      color: const Color(0xFFF4F8F6),
      child: ListTile(
        title: Text(item.title,
            style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text(item.subtitle),
        trailing: const Icon(Icons.chevron_right_rounded, size: 26),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DubaiConstructionSafetyAdvancedLearningPage(
              item: item,
            ),
          ),
        ),
      ),
    );
  }
}

class DubaiConstructionSafetyAdvancedLearningPage extends StatelessWidget {
  final DubaiFrameworkItem item;

  const DubaiConstructionSafetyAdvancedLearningPage({
    super.key,
    required this.item,
  });

  static const green = Color(0xFF0B7653);

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
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 7),
                  Text(item.subtitle,
                      style: const TextStyle(
                          color: green, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          _card(context, '1. Core Explanation', item.learning),
          _card(context, '2. Field Verification', item.fieldChecks),
          _card(context, '3. Critical Control Points', item.criticalControls),
          _card(context, '4. Stop-Work Triggers', item.stopWork),
          Card(
            color: const Color(0xFFEAF4F0),
            child: ListTile(
              title: const Text('5. Deeper Learning',
                  style: TextStyle(fontWeight: FontWeight.w800)),
              subtitle:
                  const Text('Open the practical decision guide for this topic.'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DubaiConstructionSafetyDeepLearningPage(
                    item: item,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(BuildContext context, String title, List<String> values) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
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
                    padding: const EdgeInsets.only(bottom: 9),
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

class DubaiConstructionSafetyDeepLearningPage extends StatelessWidget {
  final DubaiFrameworkItem item;

  const DubaiConstructionSafetyDeepLearningPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        title: const Text('Deeper Learning'),
        backgroundColor: const Color(0xFF0B7653),
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
                  Text('${item.title} — Practical Decision Guide',
                      style: const TextStyle(
                          fontSize: 21, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 12),
                  const Text(
                    'Before work starts, verify that the planned control can actually be implemented at the workface. If the condition is different from the approved arrangement, stop, reassess and establish a safe method before exposure.',
                    style: TextStyle(fontSize: 15, height: 1.55),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Decision Sequence',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  ...[
                    'Is the activity planned?',
                    'Are the hazards assessed?',
                    'Are critical controls physically available?',
                    'Are competent people and supervision in place?',
                    'Are interfaces and simultaneous operations controlled?',
                    'Does the actual work match the approved method?',
                    'If not, stop and correct before exposure.',
                  ].asMap().entries.map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 9),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${e.key + 1}.',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF0B7653))),
                              const SizedBox(width: 10),
                              Expanded(child: Text(e.value)),
                            ],
                          ),
                        ),
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
