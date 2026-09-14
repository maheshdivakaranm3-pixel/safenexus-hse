
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

  void _openAdvanced(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DubaiAdvancedLearningPage(item: item),
      ),
    );
  }

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
        onTap: () => _openAdvanced(context),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 17,
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
                color: Color(0xFF465650),
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DubaiAdvancedLearningPage extends StatelessWidget {
  final DubaiDetailItem item;

  const DubaiAdvancedLearningPage({
    super.key,
    required this.item,
  });

  String _advancedLearning() {
    switch (item.title) {
      case 'Rigger — Role and Responsibilities':
        return 'Advanced learning: The rigger is a critical load-control person. Before the lift, review the approved lifting method, confirm the load and lifting points, select compatible accessories, check identification and condition, verify rated capacity, protect slings from sharp edges and establish the agreed rigging arrangement. During the lift, remain in a safe position, monitor sling seating and load behaviour, avoid pinch points and immediately communicate any abnormal movement. After landing, confirm the load is stable before releasing the rigging and report defects or deviations.';
      case 'Centre of Gravity':
        return 'Advanced learning: The suspended load will tend to move according to its centre of gravity. If the lifting points and rigging arrangement do not support the load correctly, the load can tilt or shift as soon as it leaves the ground. Confirm reliable load information, approved lifting points and a stable rigging arrangement before the main lift.';
      case 'Sling Angle':
        return 'Advanced learning: Sling geometry changes the forces carried by the sling system. Smaller included angles can increase sling-leg forces. The actual arrangement must therefore be checked against the applicable rated capacity, manufacturer information and approved lifting method rather than relying on a simple visual estimate.';
      case 'Load Balance':
        return 'Advanced learning: A controlled trial lift can reveal whether the load is balanced, whether slings are seated correctly and whether the equipment reacts as expected. Keep personnel clear, raise only enough to verify the condition and lower the load if instability or unexpected movement is observed.';
      case 'Sharp Edge Protection':
        return 'Advanced learning: Sharp edges can cut or damage synthetic slings and can also damage wire rope. Select protection that is suitable for the load and sling arrangement, position it so it cannot slip out during the lift and re-check it if the load moves or rotates.';
      case 'Tag Line Control':
        return 'Advanced learning: A tag line can help control rotation, but it can also create entanglement or snap-back hazards. Use it only where appropriate, keep the handler away from the suspended load and pinch points, and never wrap the line around a hand or body.';
      default:
        return 'Advanced learning: Apply this control to the actual site conditions, not only to the paperwork. Confirm the approved lifting method, competent personnel, equipment condition, exclusion zone, communication system and surrounding interfaces before proceeding. Reassess whenever the load, equipment, location or conditions change.';
    }
  }

  String _fieldApplication() {
    switch (item.title) {
      case 'Mobile Crane':
        return 'Field application: Confirm crane position, operating radius, boom configuration, outrigger/support arrangement, ground condition and nearby hazards before lifting. The operator must work within the approved configuration and manufacturer limits.';
      case 'Tower Crane':
        return 'Field application: Confirm the planned radius and load against the applicable load chart, maintain the required exclusion zone and coordinate the lift with nearby structures, trades and other crane activities.';
      case 'Rigger — Role and Responsibilities':
        return 'Field application: The rigger prepares the load, connects the accessories, checks balance and remains clear of danger zones while monitoring the rigging. The rigger must coordinate with the lift supervisor and signalman/banksman.';
      case 'Banksman / Signalman':
        return 'Field application: Establish one clear signal system. Maintain visibility where possible, control the movement area and use the agreed emergency stop signal whenever the lift becomes unsafe or communication is lost.';
      case 'Lift Supervisor':
        return 'Field application: Verify that the lift is being executed according to the approved plan, coordinate the lifting team, maintain control of the work area and stop or reassess when conditions deviate from the plan.';
      case 'Ground & Bearing Capacity':
        return 'Field application: Inspect the actual crane setup area for soft ground, voids, buried services, drainage problems and nearby excavations. Confirm the support arrangement is suitable before loading the crane.';
      default:
        return 'Field application: Verify the condition at the work location, brief the people involved and check that the control can be maintained throughout the lift. If conditions change, pause and reassess before continuing.';
    }
  }

  String _criticalChecks() {
    switch (item.title) {
      case 'Rigger — Role and Responsibilities':
        return 'Critical checks: load weight and centre of gravity; approved lifting points; sling and shackle condition; identification and rated capacity; correct sling arrangement; edge protection; safe body position; communication; exclusion zone; stable landing area.';
      case 'Crane / Appliance':
        return 'Critical checks: equipment identification; required examination status; configuration; load chart; safety devices; controls; support conditions; operating radius; weather and surrounding clearance.';
      case 'Lifting Accessories':
        return 'Critical checks: identification; rated capacity; visible condition; examination/certification status where applicable; compatibility with the load; correct connection; protection from sharp edges.';
      case 'Exclusion Zone':
        return 'Critical checks: access control; barriers/signs; load path; landing area; visibility; unauthorized personnel; nearby work groups; potential dropped-object exposure.';
      default:
        return 'Critical checks: approved method and risk assessment; competent personnel; suitable equipment; current inspection/certification where applicable; clear communication; exclusion zone; ground and environmental conditions; safe load path.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAF4F0),
        foregroundColor: const Color(0xFF17231F),
        elevation: 0,
        title: Text(
          item.title,
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
              borderRadius: BorderRadius.circular(22),
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFE8F6F0),
                    Color(0xFFF8FBFA),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ADVANCED HSE LEARNING',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: .7,
                      color: Color(0xFF075C45),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 27,
                      height: 1.15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF10231D),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _LearningCard(
            title: 'Core Understanding',
            icon: Icons.school_outlined,
            text: item.detail,
          ),
          _LearningCard(
            title: 'Advanced Learning',
            icon: Icons.workspace_premium_outlined,
            text: _advancedLearning(),
          ),
          _LearningCard(
            title: 'Practical Site Application',
            icon: Icons.engineering_outlined,
            text: _fieldApplication(),
          ),
          _LearningCard(
            title: 'Critical Checks',
            icon: Icons.fact_check_outlined,
            text: _criticalChecks(),
          ),
          _LearningCard(
            title: 'Stop / Reassess',
            icon: Icons.warning_amber_rounded,
            text:
                'Stop and reassess if the load, equipment, ground, weather, personnel, communication, exclusion zone or any other critical condition differs from the approved lifting method or becomes unsafe.',
          ),
        ],
      ),
    );
  }
}

class _LearningCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String text;

  const _LearningCard({
    required this.title,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0B7653),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 23,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF17332A),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              text,
              style: const TextStyle(
                fontSize: 15.5,
                height: 1.55,
                color: Color(0xFF3D4A45),
              ),
            ),
          ],
        ),
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
      title: 'Lifting Operations',
      subtitle: 'Plan Safe • Lift Safe • Control Every Movement',
      description:
          'A practical professional reference covering lifting planning, equipment, rigging, competent roles, hazards, controls, inspection, execution and emergency response.',
      icon: Icons.construction_rounded,
      sections: sections,
    );
  }
}
