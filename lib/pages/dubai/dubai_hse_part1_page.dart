import 'package:flutter/material.dart';

/// SafeNexus HSE — Dubai HSE Part 1
/// Topics 1–10
///
/// Professional, English-only Dubai HSE learning module.
/// Important technical/legal limits should always follow the applicable
/// current Dubai requirement, approved design, competent-person assessment,
/// and manufacturer instructions.

class DubaiPart1Item {
  final String title;
  final String subtitle;
  final List<String> details;

  const DubaiPart1Item({
    required this.title,
    required this.subtitle,
    required this.details,
  });
}

class DubaiPart1Section {
  final String title;
  final String body;
  final List<DubaiPart1Item> items;
  final bool initiallyExpanded;

  const DubaiPart1Section({
    required this.title,
    required this.body,
    this.items = const [],
    this.initiallyExpanded = false,
  });
}

class DubaiHsePart1Page extends StatelessWidget {
  const DubaiHsePart1Page({super.key});

  static const List<String> topicTitles = [
    '1. Dubai Construction Safety Framework',
    '2. HSE Management System',
    '3. Health & Safety Risk Assessment',
    '4. Construction HSE Plan',
    '5. Work at Height',
    '6. Scaffolding Safety',
    '7. Lifting Operations',
    '8. Excavation & Trenching',
    '9. Confined Space Entry',
    '10. Electrical Safety',
  ];

  static const List<String> topicDescriptions = [
    'Understand the Dubai construction safety framework, governance, site controls, supervision and compliance structure.',
    'Build a practical HSE management system covering leadership, planning, implementation, monitoring, corrective action and continual improvement.',
    'Identify hazards, evaluate risk, select controls and verify that controls remain effective before and during work.',
    'Understand how a project HSE plan converts legal, client and project requirements into site-level controls and responsibilities.',
    'Control falls, falling objects, fragile surfaces, access systems and rescue arrangements whenever work is performed at height.',
    'Control scaffold selection, erection, alteration, inspection, tagging, access, loading and dismantling.',
    'Plan and control lifting operations, lifting accessories, crane setup, rigging, communication, exclusion zones and emergency response.',
    'Control excavation collapse, underground services, access, water, plant interaction, spoil and protective systems.',
    'Control atmospheric, engulfment, access, isolation, rescue and supervision risks in confined spaces.',
    'Control electrical energy, temporary installations, isolation, inspection, competent persons, protection and emergency response.',
  ];

  static const List<String> topicEmojis = [
    '🏗️',
    '🦺',
    '⚠️',
    '📋',
    '🪜',
    '🏗️',
    '🏗️',
    '🕳️',
    '🫁',
    '⚡',
  ];

  static const List<String> topicIds = [
    'dubai_construction_safety_framework',
    'dubai_hse_management_system',
    'dubai_health_safety_risk_assessment',
    'dubai_construction_hse_plan',
    'dubai_work_at_height',
    'dubai_scaffolding_safety',
    'dubai_lifting_operations',
    'dubai_excavation_trenching',
    'dubai_confined_space_entry',
    'dubai_electrical_safety',
  ];

  static final List<DubaiPart1Section> _sections = [
    DubaiPart1Section(
      title: 'Part 1 — Topics 1–10',
      body:
          'Ten core Dubai construction HSE subjects covering management, risk, planning and major high-risk construction activities.',
      initiallyExpanded: true,
      items: [
        for (int i = 0; i < 10; i++)
          DubaiPart1Item(
            title: topicTitles[i],
            subtitle: topicDescriptions[i],
            details: _topicDetails[i],
          ),
      ],
    ),
  ];

  static final List<List<String>> _topicDetails = [
    [
      'Purpose: establish the project safety framework before construction activities begin.',
      'Governance: define client, principal contractor, consultant, subcontractor and workforce HSE responsibilities.',
      'Planning: identify applicable Dubai requirements, project specifications, risk controls, permits and emergency arrangements.',
      'Site implementation: translate requirements into inductions, toolbox talks, inspections, permits, supervision and records.',
      'Leadership: provide visible management commitment, adequate resources and authority to stop unsafe work.',
      'Assurance: monitor compliance through inspections, audits, observations, incident learning and corrective actions.',
      'Field check: verify that the written system is actually implemented at the workface.',
    ],
    [
      'Leadership and commitment: management sets measurable HSE expectations and provides resources.',
      'Policy and objectives: define clear project HSE objectives, responsibilities and performance indicators.',
      'Planning: identify hazards, legal requirements, significant risks, controls and emergency needs.',
      'Implementation: establish competence, communication, permits, procedures, supervision and document control.',
      'Monitoring: use inspections, audits, observations, incident data and leading indicators.',
      'Corrective action: assign owners, deadlines and verification for findings.',
      'Continual improvement: use lessons learned and trend analysis to improve the system.',
    ],
    [
      'Scope the activity: define task, location, workforce, equipment, interfaces and sequence.',
      'Hazard identification: identify hazards from normal, abnormal, maintenance and emergency conditions.',
      'Risk evaluation: assess likelihood and consequence using the approved project risk matrix.',
      'Hierarchy of controls: prioritize elimination, substitution, engineering controls, administrative controls and PPE.',
      'Residual risk: confirm remaining risk is acceptable and communicate critical controls.',
      'Dynamic review: update the assessment when conditions, design, method, equipment or workforce changes.',
      'Field verification: supervisor and HSE personnel confirm controls are present before work starts.',
    ],
    [
      'Project profile: define scope, work phases, interfaces, workforce and high-risk activities.',
      'HSE organization: identify HSE leadership, competent persons, supervisors and operational responsibilities.',
      'Risk management: link risk assessments, method statements, RAMS and permit controls to actual work.',
      'Training and competence: establish induction, task-specific training, authorization and refresher needs.',
      'Emergency preparedness: define scenarios, alarms, communication, first aid, rescue and external response.',
      'Inspection and monitoring: set inspection schedules, audits, observations and performance indicators.',
      'Incident management: establish reporting, investigation, corrective action and lessons-learned processes.',
    ],
    [
      'Planning: identify all work-at-height tasks, access methods, fall hazards and rescue requirements.',
      'Access systems: select suitable scaffold, tower, MEWP, ladder or other approved access equipment.',
      'Fall prevention: prioritize collective protection such as guardrails, edge protection and safe platforms.',
      'Fall arrest: where required, use compatible systems with suitable anchorage and a practical rescue plan.',
      'Falling objects: control tools and materials with toe boards, exclusion zones, securing systems and housekeeping.',
      'Fragile surfaces: identify skylights, weak roofs, openings and other fragile areas before access.',
      'Inspection: verify equipment, access routes, edge protection and weather conditions before and during work.',
    ],
    [
      'Selection: choose a scaffold system suitable for height, configuration, loading, environment and intended use.',
      'Foundation: provide stable support using suitable base arrangements and prevent settlement or movement.',
      'Structure: ensure standards, ledgers, transoms, braces, ties, platforms and access are correctly installed.',
      'Edge protection: provide suitable guardrails, intermediate protection and toe boards where required.',
      'Access: maintain safe ladder, stair or other approved access without unsafe climbing on scaffold components.',
      'Inspection and tagging: inspect after erection, after relevant changes/events and at required intervals; maintain status identification.',
      'Modification: only authorized competent persons should alter scaffold; unauthorized removal of ties or components is prohibited.',
      'Loading: keep materials within the approved design load and prevent unsafe stacking or overloading.',
      'Dismantling: follow a controlled sequence with exclusion zones, supervision and prevention of falling components.',
    ],
    [
      'Lift planning: define load, weight, centre of gravity, lifting points, route, landing area and equipment selection.',
      'Crane setup: verify ground condition, outrigger support, clearance, configuration and manufacturer limitations.',
      'Lifting accessories: inspect and select slings, shackles, hooks, spreaders and other accessories suitable for the load.',
      'Rigging: ensure correct sling configuration, protection from sharp edges and secure connections.',
      'Communication: establish one recognized signaler/banksman system and reliable communication.',
      'Exclusion zone: prevent people from entering the suspended-load and line-of-fire area.',
      'Weather and environment: stop or modify the lift when wind, visibility, lightning or other conditions exceed safe limits.',
      'Pre-lift verification: confirm crane, accessories, permits, competence, plan and site conditions before lifting.',
      'Emergency: establish a clear response for dropped load, crane instability, contact, injury or equipment failure.',
    ],
    [
      'Planning: identify excavation depth, soil conditions, nearby structures, services, water and plant interfaces.',
      'Protective system: select an engineered shoring, trench box, benching or sloping arrangement appropriate to the conditions.',
      'Edge protection: prevent people, vehicles and materials from entering the excavation unintentionally.',
      'Access: provide safe ladder, stair or other approved means of entry and exit.',
      'Services: identify, verify and control underground utilities before excavation.',
      'Water control: assess groundwater, rainwater, leakage and dewatering effects on stability.',
      'Spoil control: keep excavated material and plant away from unstable edges in accordance with the approved design.',
      'Inspection: competent-person inspections are required before entry and whenever conditions could affect stability.',
      'Emergency: establish rescue arrangements for collapse, flooding, service strike, fall or atmospheric hazard.',
    ],
    [
      'Definition: identify spaces not designed for continuous occupancy that can create serious safety or health hazards.',
      'Entry authorization: use the project confined-space entry and permit process where applicable.',
      'Isolation: isolate and verify energy, process lines, gases, mechanical equipment and other hazards.',
      'Atmospheric testing: test oxygen, flammable gases/vapours and relevant toxic contaminants before entry and as required during work.',
      'Ventilation: provide suitable ventilation and prevent hazardous atmosphere accumulation.',
      'Personnel: ensure entrants, attendants and supervisors are trained and competent for their roles.',
      'Communication: maintain reliable communication between entrants and the attendant.',
      'Rescue: provide a site-specific rescue plan, equipment and trained responders; do not rely on improvised rescue.',
      'Stop work: immediately withdraw personnel when atmospheric or other conditions become unsafe.',
    ],
    [
      'Electrical planning: identify sources, circuits, temporary supplies, equipment and interfaces.',
      'Isolation: use an approved isolation and lockout/tagout process before work on hazardous energy.',
      'Competence: electrical work must be performed by appropriately competent and authorized personnel.',
      'Temporary installations: protect cables, distribution boards, sockets and connections from damage, water and unauthorized access.',
      'Protection: use suitable protective devices, earthing/bonding and residual-current protection as required by the installation.',
      'Inspection: inspect electrical equipment, leads, tools, panels and temporary systems at defined intervals.',
      'Environment: consider wet areas, conductive locations, heat, dust, mechanical damage and simultaneous operations.',
      'Emergency: establish response for electric shock, arc event, fire and damaged electrical infrastructure.',
      'Stop work: isolate the area when exposed live parts, damaged equipment or unsafe temporary arrangements are identified.',
    ],
  ];

  static const List<DubaiPart1Section> _roleSections = [
    DubaiPart1Section(
      title: '🦺 HSE Roles — Part 1 Topic Responsibilities',
      body:
          'The six HSE roles below are kept together at the end of Part 1. Tap a role to see topic-specific responsibilities.',
      items: [
        DubaiPart1Item(
          title: 'HSE Officer',
          subtitle: 'Field-level monitoring and verification across Topics 1–10.',
          details: [
            'Topic 1 — Framework: verify site implementation, inductions, inspections and critical controls.',
            'Topic 2 — HSE Management System: maintain field monitoring, records and corrective-action follow-up.',
            'Topic 3 — Risk Assessment: participate in hazard identification and verify critical controls at the workface.',
            'Topic 4 — HSE Plan: monitor implementation of project HSE procedures and report gaps.',
            'Topic 5 — Work at Height: inspect access, edge protection, fall protection and housekeeping.',
            'Topic 6 — Scaffolding: verify tagging, access, condition, loading and unauthorized modification controls.',
            'Topic 7 — Lifting: verify exclusion zones, rigging controls, permits, signaling and pre-lift requirements.',
            'Topic 8 — Excavation: verify protection systems, access, edge controls, services and inspection status.',
            'Topic 9 — Confined Space: verify permit, isolation, testing, attendant and rescue arrangements.',
            'Topic 10 — Electrical: verify temporary systems, protection, isolation controls and safe equipment condition.',
          ],
        ),
        DubaiPart1Item(
          title: 'HSE Supervisor',
          subtitle: 'Supervisory control, workforce compliance and immediate intervention.',
          details: [
            'Topic 1 — Framework: enforce site HSE requirements and intervene when controls fail.',
            'Topic 2 — HSE Management System: coordinate daily implementation and close field findings.',
            'Topic 3 — Risk Assessment: confirm crews understand task risks and critical controls.',
            'Topic 4 — HSE Plan: translate project requirements into daily site supervision.',
            'Topic 5 — Work at Height: verify safe access, fall prevention and rescue readiness.',
            'Topic 6 — Scaffolding: prevent unauthorized use or modification and verify safe status.',
            'Topic 7 — Lifting: control workface interfaces, banksman/signaler arrangements and exclusion zones.',
            'Topic 8 — Excavation: maintain protective systems, access, edge controls and safe plant separation.',
            'Topic 9 — Confined Space: confirm entry controls, communication and continuous supervision.',
            'Topic 10 — Electrical: stop unsafe temporary electrical work and coordinate isolation requirements.',
          ],
        ),
        DubaiPart1Item(
          title: 'Senior HSE',
          subtitle: 'Senior assurance, trend analysis and escalation of significant risk.',
          details: [
            'Topic 1 — Framework: assure project-wide compliance and escalate systemic gaps.',
            'Topic 2 — HSE Management System: review performance trends and management actions.',
            'Topic 3 — Risk Assessment: challenge high-risk assessments and verify control effectiveness.',
            'Topic 4 — HSE Plan: assure alignment between project execution and HSE strategy.',
            'Topic 5 — Work at Height: review high-risk work-at-height arrangements and rescue capability.',
            'Topic 6 — Scaffolding: assure competent erection, inspection, tagging and modification controls.',
            'Topic 7 — Lifting: review critical lifts, interfaces, planning and operational assurance.',
            'Topic 8 — Excavation: assure engineered protection and controls around critical excavations.',
            'Topic 9 — Confined Space: assure permit, isolation, atmospheric and rescue systems.',
            'Topic 10 — Electrical: assure energy isolation, temporary power and electrical safety governance.',
          ],
        ),
        DubaiPart1Item(
          title: 'HSE Coordinator',
          subtitle: 'Cross-discipline coordination, documentation and interface management.',
          details: [
            'Topic 1 — Framework: coordinate client, consultant, contractor and subcontractor HSE interfaces.',
            'Topic 2 — HSE Management System: coordinate reporting, action tracking and document control.',
            'Topic 3 — Risk Assessment: coordinate review of interface risks and control ownership.',
            'Topic 4 — HSE Plan: maintain alignment between project phases, contractors and HSE deliverables.',
            'Topic 5 — Work at Height: coordinate simultaneous operations and access-system interfaces.',
            'Topic 6 — Scaffolding: coordinate scaffold handover, tagging and interface controls.',
            'Topic 7 — Lifting: coordinate lifting plans, work permits, traffic and exclusion-zone interfaces.',
            'Topic 8 — Excavation: coordinate service information, plant, access and adjacent-work interfaces.',
            'Topic 9 — Confined Space: coordinate permits, isolation owners, rescue and emergency interfaces.',
            'Topic 10 — Electrical: coordinate isolation, temporary power interfaces and competent-person involvement.',
          ],
        ),
        DubaiPart1Item(
          title: 'HSE Engineer',
          subtitle: 'Technical HSE assurance, risk controls and engineering interfaces.',
          details: [
            'Topic 1 — Framework: provide technical interpretation and assurance of project HSE controls.',
            'Topic 2 — HSE Management System: support technical procedures, indicators and improvement actions.',
            'Topic 3 — Risk Assessment: review high-risk technical hazards and adequacy of control measures.',
            'Topic 4 — HSE Plan: support technical HSE planning and integration with construction methodology.',
            'Topic 5 — Work at Height: review engineered access, fall-protection and rescue arrangements.',
            'Topic 6 — Scaffolding: verify design/interface requirements, loading, stability and modification controls.',
            'Topic 7 — Lifting: review lifting equipment selection, ground/interface conditions and critical lift controls.',
            'Topic 8 — Excavation: review protective systems, adjacent structures, services and ground stability controls.',
            'Topic 9 — Confined Space: review isolation, atmospheric hazards, ventilation and rescue engineering.',
            'Topic 10 — Electrical: review isolation, protection, temporary distribution and electrical risk controls.',
          ],
        ),
        DubaiPart1Item(
          title: 'HSE Manager',
          subtitle: 'Project leadership, governance, resources and final HSE assurance.',
          details: [
            'Topic 1 — Framework: lead governance, compliance strategy, resources and management accountability.',
            'Topic 2 — HSE Management System: own system effectiveness, performance review and continual improvement.',
            'Topic 3 — Risk Assessment: ensure significant risks have competent review and adequate resources.',
            'Topic 4 — HSE Plan: approve and drive project HSE strategy and implementation.',
            'Topic 5 — Work at Height: assure high-risk work-at-height governance and emergency capability.',
            'Topic 6 — Scaffolding: assure competent-person arrangements, inspection governance and critical findings.',
            'Topic 7 — Lifting: assure critical-lift governance, competent teams and stop-work authority.',
            'Topic 8 — Excavation: assure engineered protection, competent inspection and emergency preparedness.',
            'Topic 9 — Confined Space: assure permit, isolation, testing, rescue and competence systems.',
            'Topic 10 — Electrical: assure electrical safety governance, isolation standards and emergency arrangements.',
          ],
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: const Text(
          'Dubai HSE — Part 1',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        children: [
          _introCard(),
          const SizedBox(height: 14),
          ..._buildTopicCards(context),
          const SizedBox(height: 10),
          ..._roleSections.map(
            (section) => _sectionCard(context, section),
          ),
        ],
      ),
    );
  }

  Widget _introCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Dubai HSE Topics 1–10',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 8),
            Text(
              'Core construction HSE management and high-risk activity controls.',
              style: TextStyle(fontSize: 14, height: 1.45),
            ),
            SizedBox(height: 12),
            Text(
              'Tap any topic to open Advanced Learning.',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTopicCards(BuildContext context) {
    return List<Widget>.generate(10, (index) {
      final item = _sections.first.items[index];
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: _tappableCard(
          context,
          item,
          emoji: topicEmojis[index],
        ),
      );
    });
  }

  Widget _sectionCard(
    BuildContext context,
    DubaiPart1Section section,
  ) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        initiallyExpanded: section.initiallyExpanded,
        title: Text(
          section.title,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              section.body,
              style: const TextStyle(height: 1.45),
            ),
          ),
          const SizedBox(height: 10),
          ...section.items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _tappableCard(context, item),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tappableCard(
    BuildContext context,
    DubaiPart1Item item, {
    String? emoji,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DubaiPart1AdvancedLearningPage(item: item),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xFFE2E8E5)),
          ),
          child: Row(
            children: [
              if (emoji != null) ...[
                Text(emoji, style: const TextStyle(fontSize: 23)),
                const SizedBox(width: 11),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: const TextStyle(
                        fontSize: 12.5,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right,
                size: 21,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DubaiPart1AdvancedLearningPage extends StatelessWidget {
  final DubaiPart1Item item;

  const DubaiPart1AdvancedLearningPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: const Text(
          'Advanced Learning',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.subtitle,
                    style: const TextStyle(height: 1.45),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          ...List<Widget>.generate(item.details.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: _numberedDetail(
                number: index + 1,
                text: item.details[index],
              ),
            );
          }),
          const SizedBox(height: 6),
          _fieldVerificationCard(),
        ],
      ),
    );
  }

  Widget _numberedDetail({
    required int number,
    required String text,
  }) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 28,
              child: Text(
                '$number',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fieldVerificationCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Field Verification',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Before work starts, verify the approved method, risk assessment, competent-person arrangements, required permits, equipment condition, site interfaces, emergency arrangements and actual work conditions.',
              style: TextStyle(height: 1.45),
            ),
            SizedBox(height: 10),
            Text(
              'Stop and escalate when a critical control is missing, ineffective or materially different from the approved method.',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
