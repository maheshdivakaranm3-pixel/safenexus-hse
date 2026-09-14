
import 'package:flutter/material.dart';

class DubaiDetailItem {
  final String title;
  final String detail;
  const DubaiDetailItem({required this.title, required this.detail});
}

class DubaiDetailSection {
  final String title;
  final String content;
  final List<DubaiDetailItem> items;
  final bool initiallyExpanded;

  const DubaiDetailSection({
    required this.title,
    required this.content,
    this.items = const [],
    this.initiallyExpanded = false,
  });
}

class DubaiTopicPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final List<DubaiDetailSection> sections;

  const DubaiTopicPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAF4F0),
        foregroundColor: const Color(0xFF17231F),
        elevation: 0,
        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
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
                        child: Icon(icon, color: Colors.white, size: 31),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 27,
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
                    subtitle.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: .5,
                      color: Color(0xFF075C45),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          ...sections.map((s) => _SectionCard(section: s)),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final DubaiDetailSection section;
  const _SectionCard({required this.section});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        initiallyExpanded: section.initiallyExpanded,
        tilePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 17),
        iconColor: const Color(0xFF237A5C),
        title: Text(
          section.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
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
          ...section.items.map((item) => _DetailItemTile(item: item)),
        ],
      ),
    );
  }
}

class _DetailItemTile extends StatelessWidget {
  final DubaiDetailItem item;
  const _DetailItemTile({required this.item});

  bool get _isNumbered => RegExp(r'^\d+$').hasMatch(item.title.trim());

  String get _numberedTitle {
    final parts = item.detail.split(' — ');
    if (parts.isEmpty) return '${item.title}. ${item.detail}';
    return '${item.title}. ${parts.first}';
  }

  String get _numberedDetail {
    final parts = item.detail.split(' — ');
    if (parts.length < 2) return '';
    return parts.sublist(1).join(' — ');
  }

  @override
  Widget build(BuildContext context) {
    final title = _isNumbered ? _numberedTitle : item.title;
    final detail = _isNumbered ? _numberedDetail : item.detail;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: const Color(0xFFF4F8F6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFD7E7E0)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 7,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: _isNumbered ? 16.5 : 16,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF17332A),
          ),
        ),
        subtitle: detail.trim().isEmpty
            ? null
            : Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  detail,
                  style: const TextStyle(
                    fontSize: 14.5,
                    height: 1.45,
                  ),
                ),
              ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: Color(0xFF53635D),
          size: 28,
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => _AdvancedLearningPage(
                title: title,
                detail: item.detail,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AdvancedLearningPage extends StatelessWidget {
  final String title;
  final String detail;

  const _AdvancedLearningPage({
    required this.title,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAF4F0),
        foregroundColor: const Color(0xFF17231F),
        elevation: 0,
        title: const Text(
          'Advanced HSE Learning',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF12382C),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    detail,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.55,
                      color: Color(0xFF3D4A45),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Advanced Learning',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0B7653),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Review the approved lifting plan, risk assessment, equipment requirements, competency arrangements, site interfaces and applicable manufacturer instructions before applying this guidance on site.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
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

class LiftingOperationsPage extends StatelessWidget {
  const LiftingOperationsPage({super.key});

  static const List<DubaiDetailSection> sections = [
    DubaiDetailSection(
      title: '1. Introduction — What is Lifting?',
      initiallyExpanded: true,
      content:
          'A lifting operation is a planned activity in which a load is raised, lowered, moved or positioned using a crane, hoist or other lifting appliance. Safe lifting depends on understanding the load, selecting suitable equipment and accessories, assessing the site, assigning competent people, controlling the load path and preventing exposure to suspended loads.',
    ),
    DubaiDetailSection(
      title: '2. Types of Lifting Operations',
      content:
          'Select the lifting method according to the load, location, access, required reach, capacity, environment and approved lifting plan.',
      items: [
        DubaiDetailItem(
          title: 'Mobile Crane',
          detail:
              'Flexible lifting equipment used on many construction sites. Check capacity, radius, configuration, ground conditions and manufacturer requirements.',
        ),
        DubaiDetailItem(
          title: 'Tower Crane',
          detail:
              'Fixed lifting system used for repetitive construction lifts. Control configuration, load charts, operator competency, exclusion zones and surrounding interfaces.',
        ),
        DubaiDetailItem(
          title: 'Crawler Crane',
          detail:
              'Tracked crane suitable for planned lifting and, where permitted, movement on prepared ground. Assess ground stability, route and configuration.',
        ),
        DubaiDetailItem(
          title: 'Truck-Mounted Crane',
          detail:
              'Vehicle-mounted crane requiring correct positioning, stabilization and operation within the approved lifting configuration.',
        ),
        DubaiDetailItem(
          title: 'Hoist / Material Hoist',
          detail:
              'Vertical lifting equipment for materials. Verify capacity, anchorage, guarding, inspection, access and landing arrangements.',
        ),
        DubaiDetailItem(
          title: 'Personnel Lifting',
          detail:
              'Lifting people requires specifically approved equipment and additional controls. It must not be treated as an ordinary material lift.',
        ),
        DubaiDetailItem(
          title: 'Critical / Heavy Lift',
          detail:
              'Higher-risk lifting requiring enhanced planning based on project criteria, load characteristics, equipment, environment and consequences of failure.',
        ),
      ],
    ),
    DubaiDetailSection(
      title: '3. Lifting Equipment & Accessories',
      content:
          'Every lifting appliance and accessory must be suitable for the intended task, correctly identified, inspected and supported by the required examination or certification records.',
      items: [
        DubaiDetailItem(
          title: 'Wire Rope Sling',
          detail:
              'Check for broken wires, kinking, crushing, corrosion, heat damage, deformation and identification. Use within the applicable rated limit.',
        ),
        DubaiDetailItem(
          title: 'Web / Round Sling',
          detail:
              'Check the body, stitching, protective sleeve and identification. Look for cuts, abrasion, chemical damage and heat damage. Protect from sharp edges.',
        ),
        DubaiDetailItem(
          title: 'Shackle',
          detail:
              'Verify type, size, identification and rated capacity. Inspect body and pin for deformation, damage and excessive wear.',
        ),
        DubaiDetailItem(
          title: 'Hook & Safety Latch',
          detail:
              'Check the hook for damage or deformation and confirm the safety latch functions correctly where fitted.',
        ),
        DubaiDetailItem(
          title: 'Spreader / Lifting Beam',
          detail:
              'Use only an identified and approved beam suitable for the load and configuration. Verify capacity and inspection status.',
        ),
        DubaiDetailItem(
          title: 'Tag Line',
          detail:
              'Used where appropriate to help control rotation or movement. Keep clear of entanglement and snap-back hazards.',
        ),
        DubaiDetailItem(
          title: 'Centre of Gravity',
          detail:
              'The centre of gravity affects balance when suspended. Incorrect assessment can cause tilting, shifting or uncontrolled movement.',
        ),
        DubaiDetailItem(
          title: 'Sling Angle',
          detail:
              'Sling angle affects forces in the sling system. Select the arrangement using approved guidance and keep within rated limits.',
        ),
      ],
    ),
    DubaiDetailSection(
      title: '4. Technical Requirements',
      content:
          'The lift must be based on a suitable method statement and risk assessment. Equipment configuration, capacity, accessories, ground conditions, competency and environmental conditions must match the planned lift.',
      items: [
        DubaiDetailItem(
          title: 'Load Information',
          detail:
              'Confirm weight, dimensions, centre of gravity, lifting points, contents, stability and special characteristics.',
        ),
        DubaiDetailItem(
          title: 'Crane Configuration',
          detail:
              'Confirm crane type, boom arrangement, counterweight, support arrangement, radius and operating position against manufacturer requirements.',
        ),
        DubaiDetailItem(
          title: 'Ground & Bearing Capacity',
          detail:
              'Verify support conditions and consider soft ground, voids, buried services, drainage and nearby excavations.',
        ),
        DubaiDetailItem(
          title: 'Certification & Examination',
          detail:
              'Confirm applicable equipment examination, inspection, certification and personnel competency records are current.',
        ),
        DubaiDetailItem(
          title: 'Weather Conditions',
          detail:
              'Assess wind, visibility, rain, lightning, dust and other conditions against the applicable safe operating limits.',
        ),
      ],
    ),
    DubaiDetailSection(
      title: '5. Lifting Plan — Step by Step',
      initiallyExpanded: true,
      content:
          'Complete the planning sequence below before the lift is authorized. Each numbered point is a separate control step.',
      items: [
        DubaiDetailItem(
          title: '1',
          detail:
              'Define the lifting task — what is being lifted, why, from where to where, and when.',
        ),
        DubaiDetailItem(
          title: '2',
          detail:
              'Identify the load — confirm reliable weight, dimensions, contents and special characteristics.',
        ),
        DubaiDetailItem(
          title: '3',
          detail:
              'Identify centre of gravity and lifting points — confirm stability and approved attachment points.',
        ),
        DubaiDetailItem(
          title: '4',
          detail:
              'Select a suitable crane or lifting appliance — match capacity, reach, access and configuration to the task.',
        ),
        DubaiDetailItem(
          title: '5',
          detail:
              'Determine operating radius and configuration — establish crane position, boom arrangement and support setup.',
        ),
        DubaiDetailItem(
          title: '6',
          detail:
              'Verify capacity using the manufacturer/load chart for the exact configuration and planned lift.',
        ),
        DubaiDetailItem(
          title: '7',
          detail:
              'Assess ground, excavation and underground-service risks — verify stability, support and service interfaces.',
        ),
        DubaiDetailItem(
          title: '8',
          detail:
              'Select and inspect lifting accessories — confirm suitability, identification, condition and required certification.',
        ),
        DubaiDetailItem(
          title: '9',
          detail:
              'Define the rigging method — sling arrangement, connection method, sling angle, edge protection and stability.',
        ),
        DubaiDetailItem(
          title: '10',
          detail:
              'Map the load path and landing area — identify obstacles, structures, people, services and final position.',
        ),
        DubaiDetailItem(
          title: '11',
          detail:
              'Establish the exclusion zone — barricade/control the area and prevent unauthorized access.',
        ),
        DubaiDetailItem(
          title: '12',
          detail:
              'Assign competent/authorized roles — appointed person or lift planner where required, supervisor, operator, rigger, banksman/signalman and HSE support.',
        ),
        DubaiDetailItem(
          title: '13',
          detail:
              'Establish communication and emergency signals — agree radio communication, hand signals and emergency stop signal.',
        ),
        DubaiDetailItem(
          title: '14',
          detail:
              'Check weather and surrounding hazards — wind, visibility, rain, structures, power lines and simultaneous activities.',
        ),
        DubaiDetailItem(
          title: '15',
          detail:
              'Conduct toolbox talk and pre-lift verification — brief the team and confirm all critical controls and authorizations.',
        ),
        DubaiDetailItem(
          title: '16',
          detail:
              'Execute, monitor and close out the lift — control the movement, land the load safely, secure it and complete closeout.',
        ),
      ],
    ),
    DubaiDetailSection(
      title: '6. Main Lifting Hazards',
      content: 'Typical hazards to assess include:',
      items: [
        DubaiDetailItem(
          title: 'Dropped Load',
          detail:
              'Can result from incorrect rigging, overload, damaged accessories, unstable loads or equipment failure.',
        ),
        DubaiDetailItem(
          title: 'Crane Instability',
          detail:
              'Can result from poor ground, incorrect configuration, excessive radius or overloading.',
        ),
        DubaiDetailItem(
          title: 'Struck-by / Suspended Load',
          detail:
              'People can be seriously injured by falling, swinging or moving loads. Maintain the exclusion zone.',
        ),
        DubaiDetailItem(
          title: 'Crushing / Pinch Points',
          detail:
              'Control body and hand positions during connection, guiding and landing.',
        ),
        DubaiDetailItem(
          title: 'Contact with Structures or Services',
          detail:
              'Control clearances from buildings, temporary works, scaffolds, power lines and services.',
        ),
        DubaiDetailItem(
          title: 'Uncontrolled Rotation',
          detail:
              'Wind and off-centre loads can cause rotation. Use appropriate load-control methods.',
        ),
        DubaiDetailItem(
          title: 'Communication Failure',
          detail:
              'Conflicting or unclear signals can cause unexpected crane movement. Use one clear signal system.',
        ),
      ],
    ),
    DubaiDetailSection(
      title: '7. Rigging & Load Control',
      content:
          'Rigging is the controlled connection of the load to the lifting appliance. The rigger must understand the load, lifting points, accessory limitations and the approved rigging method.',
      items: [
        DubaiDetailItem(
          title: 'Rigger — Role and Responsibilities',
          detail:
              'A rigger is a trained, competent and authorized person responsible for preparing the load for lifting and correctly connecting and disconnecting lifting accessories. Before the lift, the rigger studies the approved lifting method, confirms the available load information, checks the load condition and lifting points, selects suitable accessories, verifies identification and rated capacity, inspects for damage or wear, establishes the correct sling arrangement and uses edge protection where required. The rigger checks that the load is balanced and that the rigging will not slip or damage the load. During the lift, the rigger keeps hands and body away from pinch points, stays outside the danger zone, follows the agreed communication system, watches for shifting, tilting, snagging or sling movement and immediately reports or stops the operation when conditions become unsafe. After landing, the rigger confirms the load is stable and secure before removing accessories, checks equipment after use and reports defects, damage, near misses or deviations.',
        ),
        DubaiDetailItem(
          title: 'Rigging Method',
          detail:
              'Define how the load will be attached and controlled, including lifting points, sling arrangement, connection hardware, angles and edge protection.',
        ),
        DubaiDetailItem(
          title: 'Load Balance',
          detail:
              'Where appropriate, conduct a controlled trial lift to confirm balance, rigging security and equipment response before continuing the main lift.',
        ),
        DubaiDetailItem(
          title: 'Sharp Edge Protection',
          detail:
              'Protect slings from sharp or abrasive edges with suitable protection and prevent contact that could damage the sling.',
        ),
        DubaiDetailItem(
          title: 'Tag Line Control',
          detail:
              'Use tag lines where appropriate to control rotation while keeping personnel away from entanglement and snap-back hazards.',
        ),
      ],
    ),
    DubaiDetailSection(
      title: '8. Pre-Lift Inspection & Verification',
      content:
          'The pre-lift check confirms that the approved controls are actually in place before the operation begins.',
      items: [
        DubaiDetailItem(
          title: 'Crane / Appliance',
          detail:
              'Confirm condition, examination status, configuration, load chart, controls and safety devices.',
        ),
        DubaiDetailItem(
          title: 'Lifting Accessories',
          detail:
              'Inspect slings, shackles, hooks, beams and other accessories for condition, identification and suitability.',
        ),
        DubaiDetailItem(
          title: 'Ground & Setup',
          detail:
              'Confirm stable support, safe access and adequate clearance from excavations and other hazards.',
        ),
        DubaiDetailItem(
          title: 'Personnel Competency',
          detail:
              'Confirm assigned personnel are competent and appropriately authorized or certified for their roles.',
        ),
        DubaiDetailItem(
          title: 'Communication',
          detail:
              'Confirm the signalman/banksman arrangement, communication method and emergency stop signal.',
        ),
        DubaiDetailItem(
          title: 'Exclusion Zone',
          detail:
              'Confirm barriers, signs and access controls are effective before lifting starts.',
        ),
      ],
    ),
    DubaiDetailSection(
      title: '9. Stop-Work Conditions',
      content:
          'Stop the lifting operation when the approved control conditions are no longer valid.',
      items: [
        DubaiDetailItem(
          title: 'Unsafe Ground or Settlement',
          detail:
              'Stop for instability, settlement, unexpected movement or loss of required support.',
        ),
        DubaiDetailItem(
          title: 'Overload or Unknown Load',
          detail:
              'Stop if load weight, configuration or capacity cannot be reliably confirmed.',
        ),
        DubaiDetailItem(
          title: 'Damaged Accessory',
          detail:
              'Stop if a critical accessory is damaged, unidentified or unsuitable.',
        ),
        DubaiDetailItem(
          title: 'Loss of Communication',
          detail:
              'Stop when the operator and signalman cannot maintain clear communication.',
        ),
        DubaiDetailItem(
          title: 'Weather Beyond Limits',
          detail:
              'Stop when environmental conditions exceed applicable equipment or project limits.',
        ),
        DubaiDetailItem(
          title: 'Person Enters Exclusion Zone',
          detail:
              'Stop movement and regain control of the area before continuing.',
        ),
        DubaiDetailItem(
          title: 'Unexpected Load Movement',
          detail:
              'Stop for unexpected tilting, rotation, snagging or contact with another object.',
        ),
      ],
    ),
    DubaiDetailSection(
      title: '10. Lifting Near Excavation, Scaffolding & Temporary Works',
      content:
          'Lifting must be coordinated with other high-risk activities. Ground and structural interfaces must be assessed before the lift.',
      items: [
        DubaiDetailItem(
          title: 'Near Excavation',
          detail:
              'Assess edge stability, crane or outrigger loading, ground bearing, buried services and temporary support requirements.',
        ),
        DubaiDetailItem(
          title: 'Near Scaffolding',
          detail:
              'Maintain safe clearance. Do not use or load scaffold as part of the lifting arrangement unless specifically designed and approved for that purpose.',
        ),
        DubaiDetailItem(
          title: 'Near Temporary Works',
          detail:
              'Consider formwork, falsework, shoring and temporary platforms so lifting loads do not overload or destabilize them.',
        ),
        DubaiDetailItem(
          title: 'Simultaneous Operations',
          detail:
              'Coordinate lifting with excavation, work at height, concrete work, vehicle movement, electrical work and other activities.',
        ),
      ],
    ),
    DubaiDetailSection(
      title: '11. HSE Roles During Lifting Operations',
      content:
          'HSE personnel provide safety assurance and monitoring. They do not automatically replace the operational lifting roles required by the approved lifting system.',
      items: [
        DubaiDetailItem(
          title: 'HSE Officer',
          detail:
              'Monitor implementation of the lifting plan and risk assessment; verify exclusion zones, PPE, access, competency and equipment documentation; observe the operation; intervene for unsafe conditions; and record observations and actions.',
        ),
        DubaiDetailItem(
          title: 'Senior HSE',
          detail:
              'Provide higher-level oversight for high-risk or critical lifts, review major interfaces, challenge deviations, support escalation and communicate lessons learned.',
        ),
        DubaiDetailItem(
          title: 'HSE Coordinator',
          detail:
              'Coordinate HSE submissions and records including lifting plans, toolbox talks, inspections, permits, competency documents and corrective actions.',
        ),
        DubaiDetailItem(
          title: 'HSE Engineer',
          detail:
              'Review technical HSE interfaces such as ground, excavations, temporary works, structures, services and simultaneous operations and coordinate concerns with responsible technical teams.',
        ),
        DubaiDetailItem(
          title: 'HSE Manager',
          detail:
              'Oversee project HSE expectations, contractor controls and competent-person arrangements, review significant lifting risks and manage escalation and performance improvement.',
        ),
      ],
    ),
    DubaiDetailSection(
      title: '12. Operational Lifting Roles',
      content:
          'Operational responsibilities must be assigned in the lifting plan and project procedure.',
      items: [
        DubaiDetailItem(
          title: 'Appointed Person / Lift Planner',
          detail:
              'Plans the lift, assesses risks, selects equipment and accessories, defines the lifting method and establishes required controls.',
        ),
        DubaiDetailItem(
          title: 'Lift Supervisor',
          detail:
              'Supervises execution in accordance with the approved lifting plan and coordinates the lifting team.',
        ),
        DubaiDetailItem(
          title: 'Crane Operator',
          detail:
              'Operates the lifting appliance within approved configuration and limits and follows authorized signals.',
        ),
        DubaiDetailItem(
          title: 'Banksman / Signalman',
          detail:
              'Directs crane movement using the agreed communication system and helps maintain a clear load path and exclusion zone.',
        ),
        DubaiDetailItem(
          title: 'Rigger',
          detail:
              'Selects, inspects and correctly connects lifting accessories, prepares the load, monitors rigging and disconnects accessories safely after landing.',
        ),
      ],
    ),
    DubaiDetailSection(
      title: '13. Communication & Exclusion Zone',
      content:
          'The team must use an agreed communication system and maintain effective control of the lifting area.',
      items: [
        DubaiDetailItem(
          title: 'One Clear Signal System',
          detail:
              'Use agreed hand signals or reliable radio communication and avoid conflicting instructions.',
        ),
        DubaiDetailItem(
          title: 'Emergency Stop',
          detail:
              'Everyone must understand the emergency stop signal and the operation must be reassessed before restart.',
        ),
        DubaiDetailItem(
          title: 'Exclusion Zone',
          detail:
              'Control access around the load path and prevent unnecessary exposure to suspended loads.',
        ),
        DubaiDetailItem(
          title: 'Visibility',
          detail:
              'Use suitable communication and additional controls when the operator cannot adequately see the load or signalman.',
        ),
      ],
    ),
    DubaiDetailSection(
      title: '14. Emergency Response',
      content:
          'Emergency arrangements must be established during planning. The team must know how to stop the lift, secure the area and obtain assistance.',
      items: [
        DubaiDetailItem(
          title: 'Dropped or Unstable Load',
          detail:
              'Stop, raise the alarm, maintain the exclusion zone and follow the site emergency procedure. Do not approach an unstable load without competent control.',
        ),
        DubaiDetailItem(
          title: 'Crane Instability',
          detail:
              'Stop movement where possible, keep people clear and follow the equipment and site emergency procedure.',
        ),
        DubaiDetailItem(
          title: 'Power-Line Contact',
          detail:
              'Treat as a serious electrical emergency. Keep people away and follow the site emergency procedure and specialist advice.',
        ),
        DubaiDetailItem(
          title: 'Injury / Crush Incident',
          detail:
              'Stop the operation, make the area safe, activate emergency arrangements and provide response within the team’s competence.',
        ),
        DubaiDetailItem(
          title: 'Incident Preservation',
          detail:
              'After immediate danger is controlled, preserve relevant evidence and equipment condition in accordance with the incident investigation process.',
        ),
      ],
    ),
    DubaiDetailSection(
      title: '15. Practical Site Example — HVAC Lift',
      content:
          'Example: a packaged HVAC unit is lifted from a delivery vehicle to a prepared roof-level installation area.',
      items: [
        DubaiDetailItem(
          title: 'Planning',
          detail:
              'Confirm weight, dimensions, centre of gravity, lifting points, pick-up point, landing point and operating radius.',
        ),
        DubaiDetailItem(
          title: 'Crane Selection',
          detail:
              'Select a suitable crane and verify the actual configuration against the manufacturer load chart.',
        ),
        DubaiDetailItem(
          title: 'Ground Assessment',
          detail:
              'Verify support conditions and the relationship between the crane position and nearby excavation or underground services.',
        ),
        DubaiDetailItem(
          title: 'Rigging',
          detail:
              'Select suitable lifting accessories, inspect them, protect sharp edges and establish the approved rigging arrangement.',
        ),
        DubaiDetailItem(
          title: 'Execution',
          detail:
              'Brief the team, establish the exclusion zone, confirm communication and conduct the lift under supervision.',
        ),
        DubaiDetailItem(
          title: 'Closeout',
          detail:
              'Remove accessories only after the load is stable and secure, inspect equipment after use and record defects or lessons learned.',
        ),
      ],
    ),
    DubaiDetailSection(
      title: '16. Quick Learning Formula',
      content:
          'PLAN → CHECK → RIG → EXCLUDE → COMMUNICATE → LIFT → MONITOR → LAND → SECURE → CLOSE OUT',
      items: [
        DubaiDetailItem(
          title: 'PLAN',
          detail: 'Understand the task, load, equipment, ground, route and emergency arrangements.',
        ),
        DubaiDetailItem(
          title: 'CHECK',
          detail: 'Verify capacity, configuration, certification, accessories, weather and site conditions.',
        ),
        DubaiDetailItem(
          title: 'RIG',
          detail: 'Use the approved rigging method, correct accessories and suitable edge protection.',
        ),
        DubaiDetailItem(
          title: 'EXCLUDE',
          detail: 'Control the lifting zone and keep people away from suspended loads.',
        ),
        DubaiDetailItem(
          title: 'COMMUNICATE',
          detail: 'Use one clear signal system and confirm the emergency stop command.',
        ),
        DubaiDetailItem(
          title: 'LIFT & MONITOR',
          detail: 'Lift in a controlled manner and continuously monitor load, equipment and surroundings.',
        ),
        DubaiDetailItem(
          title: 'LAND & SECURE',
          detail: 'Land safely, confirm stability and remove accessories only when safe.',
        ),
        DubaiDetailItem(
          title: 'CLOSE OUT',
          detail: 'Report defects or deviations and capture lessons learned.',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return const DubaiTopicPage(
      title: 'Lifting Operations — Dubai HSE',
      subtitle: 'Plan Safe • Lift Safe • Control Every Movement',
      description:
          'A practical professional reference covering lifting planning, equipment, rigging, competent roles, hazards, controls, inspection, execution and emergency response.',
      icon: Icons.construction_rounded,
      sections: sections,
    );
  }
}
