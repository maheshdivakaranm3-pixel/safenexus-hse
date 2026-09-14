import 'package:flutter/material.dart';

// ============================================================
// SAFE NEXUS HSE
// LIFTING OPERATIONS — DUBAI
// Single-file implementation
// ============================================================

class DubaiDetailItem {
  final String title;
  final String detail;

  const DubaiDetailItem({
    required this.title,
    required this.detail,
  });
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

// ============================================================
// COMMON TOPIC PAGE
// ============================================================

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
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          _HeaderCard(
            title: title,
            subtitle: subtitle,
            description: description,
            icon: icon,
          ),
          const SizedBox(height: 14),
          ...sections.map(
            (section) => _SectionCard(section: section),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HEADER
// ============================================================

class _HeaderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;

  const _HeaderCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
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
            Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B7653),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 31,
                  ),
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
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SECTION CARD
// ============================================================

class _SectionCard extends StatelessWidget {
  final DubaiDetailSection section;

  const _SectionCard({
    required this.section,
  });

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
        tilePadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 5,
        ),
        childrenPadding: const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          17,
        ),
        iconColor: const Color(0xFF237A5C),
        title: Text(
          section.title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        children: [
          if (section.content.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                4,
                0,
                4,
                12,
              ),
              child: Text(
                section.content,
                style: const TextStyle(
                  fontSize: 15.5,
                  height: 1.5,
                ),
              ),
            ),
          ...section.items.map(
            (item) => _DetailItemTile(item: item),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// DETAIL ITEM
// Small right chevron only — NO green round arrow
// ============================================================

class _DetailItemTile extends StatelessWidget {
  final DubaiDetailItem item;

  const _DetailItemTile({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: const Color(0xFFF4F8F6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(
          color: Color(0xFFD7E7E0),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => LiftingAdvancedLearningPage(
                title: item.title,
                summary: item.detail,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            18,
            15,
            12,
            15,
          ),
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

// ============================================================
// LIFTING OPERATIONS PAGE
// ============================================================

class LiftingOperationsPage extends StatelessWidget {
  const LiftingOperationsPage({
    super.key,
  });

  static const List<DubaiDetailSection> sections = [
    // ========================================================
    // 1
    // ========================================================

    DubaiDetailSection(
      title: '1. Introduction — What is Lifting?',
      initiallyExpanded: true,
      content:
          'A lifting operation is a planned activity in which a load is raised, lowered, moved or positioned using a crane, hoist or other lifting appliance. Safe lifting requires proper planning, suitable equipment, competent personnel, effective rigging, load-path control, exclusion zones and continuous monitoring.',
      items: [
        DubaiDetailItem(
          title: 'Purpose of Lifting Control',
          detail:
              'The objective is to move the load without injury, dropped-load events, equipment instability, property damage or uncontrolled movement.',
        ),
        DubaiDetailItem(
          title: 'Safe Lift Principle',
          detail:
              'PLAN → CHECK → RIG → EXCLUDE → COMMUNICATE → LIFT → MONITOR → LAND → SECURE → CLOSE OUT.',
        ),
      ],
    ),

    // ========================================================
    // 2
    // ========================================================

    DubaiDetailSection(
      title: '2. Types of Lifting Operations',
      content:
          'The lifting method must be selected according to the load, location, required reach, capacity, access, environment and approved lifting arrangement.',
      items: [
        DubaiDetailItem(
          title: 'Mobile Crane',
          detail:
              'Flexible crane used for construction lifting. Assess configuration, radius, capacity, ground conditions, outriggers and load path.',
        ),
        DubaiDetailItem(
          title: 'Tower Crane',
          detail:
              'Fixed crane used for repetitive construction lifts. Control load chart, radius, wind conditions, operator competency and exclusion zones.',
        ),
        DubaiDetailItem(
          title: 'Crawler Crane',
          detail:
              'Tracked crane requiring assessment of ground stability, travel route, crane configuration and planned lifting location.',
        ),
        DubaiDetailItem(
          title: 'Truck-Mounted Crane',
          detail:
              'Vehicle-mounted crane requiring suitable positioning, stabilization and operation within the approved configuration.',
        ),
        DubaiDetailItem(
          title: 'Hoist / Material Hoist',
          detail:
              'Vertical lifting system for materials. Verify capacity, anchorage, guarding, inspection and landing arrangements.',
        ),
        DubaiDetailItem(
          title: 'Personnel Lifting',
          detail:
              'Lifting people requires specifically approved equipment and additional controls. It must not be treated as an ordinary material lift.',
        ),
        DubaiDetailItem(
          title: 'Critical / Heavy Lift',
          detail:
              'Higher-risk lift requiring enhanced planning according to project criteria, load characteristics, equipment and consequences of failure.',
        ),
      ],
    ),

    // ========================================================
    // 3
    // ========================================================

    DubaiDetailSection(
      title: '3. Lifting Equipment & Accessories',
      content:
          'Every lifting appliance and accessory must be suitable for the intended task, identifiable, inspected and supported by applicable examination or certification records.',
      items: [
        DubaiDetailItem(
          title: 'Wire Rope Sling',
          detail:
              'Inspect for broken wires, kinking, crushing, corrosion, heat damage, deformation and identification.',
        ),
        DubaiDetailItem(
          title: 'Web / Round Sling',
          detail:
              'Inspect body, stitching, protective sleeve and identification. Check for cuts, abrasion, chemical and heat damage.',
        ),
        DubaiDetailItem(
          title: 'Shackle',
          detail:
              'Verify type, size, identification and rated capacity. Inspect body and pin for deformation, wear and damage.',
        ),
        DubaiDetailItem(
          title: 'Hook & Safety Latch',
          detail:
              'Check hook condition, deformation, throat opening and safety latch operation where fitted.',
        ),
        DubaiDetailItem(
          title: 'Spreader / Lifting Beam',
          detail:
              'Use only an identified and approved beam suitable for the load and configuration. Verify capacity and inspection status.',
        ),
        DubaiDetailItem(
          title: 'Tag Line',
          detail:
              'Used where appropriate to control rotation or movement while keeping personnel away from entanglement and snap-back hazards.',
        ),
        DubaiDetailItem(
          title: 'Centre of Gravity',
          detail:
              'The centre of gravity affects balance when suspended. Incorrect assessment can cause tilting or uncontrolled movement.',
        ),
        DubaiDetailItem(
          title: 'Sling Angle',
          detail:
              'Sling angle changes forces in the sling system. Use approved lifting guidance and remain within rated limits.',
        ),
      ],
    ),

    // ========================================================
    // 4
    // ========================================================

    DubaiDetailSection(
      title: '4. Technical Requirements',
      content:
          'The lift must be supported by a suitable method statement and risk assessment. Equipment configuration, capacity, accessories, ground conditions, competency and environmental conditions must match the planned lift.',
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
              'Confirm applicable examination, inspection, certification and personnel competency records.',
        ),
        DubaiDetailItem(
          title: 'Environmental Conditions',
          detail:
              'Assess wind, visibility, rain, lightning, dust and other conditions against applicable safe operating limits.',
        ),
      ],
    ),

    // ========================================================
    // 5 — LIFTING PLAN
    // ========================================================

    DubaiDetailSection(
      title: '5. Lifting Plan — How to Prepare It',
      initiallyExpanded: true,
      content:
          'A lifting plan defines how the lifting operation will be carried out safely. The plan should be appropriate to the complexity and risk of the lift and coordinated with the project risk assessment, method statement, permit arrangements and equipment requirements.',
      items: [
        DubaiDetailItem(
          title: '1',
          detail:
              'Define the lifting task — identify what is being lifted, the pick-up point, landing point, purpose and planned timing.',
        ),
        DubaiDetailItem(
          title: '2',
          detail:
              'Confirm load details — establish reliable weight, dimensions, centre of gravity, contents and special characteristics.',
        ),
        DubaiDetailItem(
          title: '3',
          detail:
              'Confirm lifting points — verify manufacturer or engineered lifting points and ensure they are suitable for the planned arrangement.',
        ),
        DubaiDetailItem(
          title: '4',
          detail:
              'Select the lifting appliance — choose a suitable crane, hoist or lifting equipment for the load and work environment.',
        ),
        DubaiDetailItem(
          title: '5',
          detail:
              'Determine crane position and operating radius — establish the exact operating location and configuration.',
        ),
        DubaiDetailItem(
          title: '6',
          detail:
              'Verify capacity — check the applicable manufacturer load chart for the actual configuration, radius and planned load.',
        ),
        DubaiDetailItem(
          title: '7',
          detail:
              'Assess ground conditions — verify bearing capacity, outrigger support, nearby excavation, voids, underground services and drainage.',
        ),
        DubaiDetailItem(
          title: '8',
          detail:
              'Select lifting accessories — choose suitable slings, shackles, hooks, lifting beams and other accessories.',
        ),
        DubaiDetailItem(
          title: '9',
          detail:
              'Verify accessory capacity — check identification, rated capacity, condition, configuration and applicable inspection status.',
        ),
        DubaiDetailItem(
          title: '10',
          detail:
              'Define the rigging arrangement — specify sling configuration, connection points, angles, edge protection and load-control method.',
        ),
        DubaiDetailItem(
          title: '11',
          detail:
              'Plan the load path — identify buildings, scaffolds, temporary works, power lines, services, vehicles and people.',
        ),
        DubaiDetailItem(
          title: '12',
          detail:
              'Establish exclusion zones — barricade and control the lifting area and prevent unauthorized access.',
        ),
        DubaiDetailItem(
          title: '13',
          detail:
              'Assign competent personnel — identify the lift planner/Appointed Person where applicable, Lift Supervisor, operator, rigger, banksman/signaller and HSE support.',
        ),
        DubaiDetailItem(
          title: '14',
          detail:
              'Establish communication — agree radio communication, hand signals and emergency stop arrangements.',
        ),
        DubaiDetailItem(
          title: '15',
          detail:
              'Conduct toolbox talk and final verification — confirm the team understands the method, hazards, controls and responsibilities.',
        ),
        DubaiDetailItem(
          title: '16',
          detail:
              'Execute and close out — conduct the lift under supervision, land the load safely, secure it, remove accessories safely and record relevant observations.',
        ),
      ],
    ),

    // ========================================================
    // 6
    // ========================================================

    DubaiDetailSection(
      title: '6. Main Lifting Hazards',
      content:
          'Identify hazards before the lift and reassess them whenever the task or site conditions change.',
      items: [
        DubaiDetailItem(
          title: 'Dropped Load',
          detail:
              'May result from incorrect rigging, overload, damaged accessories, unstable load or equipment failure.',
        ),
        DubaiDetailItem(
          title: 'Crane Instability',
          detail:
              'Can result from poor ground, incorrect configuration, excessive radius or overloading.',
        ),
        DubaiDetailItem(
          title: 'Suspended Load',
          detail:
              'Personnel can suffer fatal or serious injury from falling, swinging or moving loads.',
        ),
        DubaiDetailItem(
          title: 'Crushing / Pinch Points',
          detail:
              'Hands and body can become trapped during connection, guiding and landing.',
        ),
        DubaiDetailItem(
          title: 'Contact with Structures',
          detail:
              'Loads or crane components can strike buildings, scaffolds, temporary works or other structures.',
        ),
        DubaiDetailItem(
          title: 'Power Lines',
          detail:
              'Crane or load contact with electrical lines can create severe electrical hazards.',
        ),
        DubaiDetailItem(
          title: 'Uncontrolled Rotation',
          detail:
              'Wind or off-centre loads can rotate unexpectedly and strike people or structures.',
        ),
        DubaiDetailItem(
          title: 'Communication Failure',
          detail:
              'Conflicting or unclear instructions can result in unexpected crane movement.',
        ),
      ],
    ),

    // ========================================================
    // 7
    // ========================================================

    DubaiDetailSection(
      title: '7. Rigging & Load Control',
      content:
          'Rigging connects the load to the lifting appliance and controls the load during movement. The rigger must follow the approved lifting method and use suitable accessories.',
      items: [
        DubaiDetailItem(
          title: 'Rigger — Core Responsibility',
          detail:
              'Prepare the load, select suitable accessories, inspect them, connect the load correctly, confirm stability, control movement and disconnect only after the load is safely landed.',
        ),
        DubaiDetailItem(
          title: 'Rigging Arrangement',
          detail:
              'Define lifting points, sling arrangement, connection method, angles and edge protection before lifting.',
        ),
        DubaiDetailItem(
          title: 'Load Balance',
          detail:
              'Verify the load remains stable and balanced. A controlled trial lift may be used where required to confirm the arrangement.',
        ),
        DubaiDetailItem(
          title: 'Sharp Edge Protection',
          detail:
              'Protect slings against sharp or abrasive edges that could cut, crush or damage the sling.',
        ),
        DubaiDetailItem(
          title: 'Tag Line',
          detail:
              'Use an appropriate tag line where required while controlling entanglement and snap-back hazards.',
        ),
      ],
    ),

    // ========================================================
    // 8
    // ========================================================

    DubaiDetailSection(
      title: '8. Pre-Lift Inspection',
      content:
          'The pre-lift verification confirms that the approved controls are physically in place before lifting starts.',
      items: [
        DubaiDetailItem(
          title: 'Crane / Appliance',
          detail:
              'Check condition, examination status, configuration, load chart, controls and safety devices.',
        ),
        DubaiDetailItem(
          title: 'Lifting Accessories',
          detail:
              'Inspect slings, shackles, hooks, beams and other accessories for condition, identification and suitability.',
        ),
        DubaiDetailItem(
          title: 'Ground & Setup',
          detail:
              'Confirm stable support, safe access, adequate clearance and safe positioning near excavations.',
        ),
        DubaiDetailItem(
          title: 'Personnel',
          detail:
              'Confirm assigned personnel are competent and appropriately authorized for their roles.',
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

    // ========================================================
    // 9
    // ========================================================

    DubaiDetailSection(
      title: '9. Stop-Work Conditions',
      content:
          'Stop the lifting operation whenever critical controls are lost or conditions become unsafe.',
      items: [
        DubaiDetailItem(
          title: 'Unsafe Ground',
          detail:
              'Stop for settlement, instability, unexpected movement or loss of required support.',
        ),
        DubaiDetailItem(
          title: 'Unknown Load',
          detail:
              'Stop if load weight, centre of gravity or configuration cannot be reliably confirmed.',
        ),
        DubaiDetailItem(
          title: 'Damaged Equipment',
          detail:
              'Remove damaged, defective or unidentified lifting equipment from service.',
        ),
        DubaiDetailItem(
          title: 'Communication Lost',
          detail:
              'Stop when the operator and signalman cannot maintain clear communication.',
        ),
        DubaiDetailItem(
          title: 'Unsafe Weather',
          detail:
              'Stop when environmental conditions exceed applicable equipment or project limits.',
        ),
        DubaiDetailItem(
          title: 'Person Enters Exclusion Zone',
          detail:
              'Stop movement and regain control of the area before continuing.',
        ),
        DubaiDetailItem(
          title: 'Unexpected Movement',
          detail:
              'Stop for unexpected tilting, rotation, snagging or contact.',
        ),
      ],
    ),

    // ========================================================
    // 10
    // ========================================================

    DubaiDetailSection(
      title: '10. Lifting Near Excavation, Scaffolding & Temporary Works',
      content:
          'Lifting operations must be coordinated with other high-risk activities and structural interfaces.',
      items: [
        DubaiDetailItem(
          title: 'Near Excavation',
          detail:
              'Assess edge stability, crane or outrigger loading, ground bearing, buried services and temporary support.',
        ),
        DubaiDetailItem(
          title: 'Near Scaffolding',
          detail:
              'Maintain safe clearance. Do not use scaffold as part of the lifting arrangement unless specifically designed and approved for that purpose.',
        ),
        DubaiDetailItem(
          title: 'Near Temporary Works',
          detail:
              'Consider formwork, falsework, shoring and temporary platforms so lifting loads do not overload or destabilize them.',
        ),
        DubaiDetailItem(
          title: 'Simultaneous Operations',
          detail:
              'Coordinate lifting with excavation, work at height, concrete work, traffic, electrical work and other activities.',
        ),
      ],
    ),

    // ========================================================
    // 11
    // Operational roles only
    // HSE responsibilities moved to final section
    // ========================================================

    DubaiDetailSection(
      title: '11. Operational Lifting Roles',
      content:
          'Operational responsibilities must be clearly assigned in the approved lifting arrangement.',
      items: [
        DubaiDetailItem(
          title: 'Appointed Person / Lift Planner',
          detail:
              'Plans the lift, assesses risks, selects equipment and accessories, defines the method and establishes required controls.',
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
              'Selects, inspects and connects lifting accessories, prepares the load, monitors rigging and disconnects accessories safely after landing.',
        ),
      ],
    ),

    // ========================================================
    // 12
    // ========================================================

    DubaiDetailSection(
      title: '12. Communication & Exclusion Zone',
      content:
          'Effective communication and exclusion-zone control are essential during every lifting operation.',
      items: [
        DubaiDetailItem(
          title: 'One Clear Signal System',
          detail:
              'Use agreed hand signals or reliable radio communication and avoid conflicting instructions.',
        ),
        DubaiDetailItem(
          title: 'Emergency Stop',
          detail:
              'Everyone involved must understand the emergency stop command.',
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

    // ========================================================
    // 13
    // ========================================================

    DubaiDetailSection(
      title: '13. Emergency Response',
      content:
          'Emergency arrangements must be established before the lift and understood by the lifting team.',
      items: [
        DubaiDetailItem(
          title: 'Dropped / Unstable Load',
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
              'Treat as a serious electrical emergency. Keep people away and follow the site emergency procedure and specialist instructions.',
        ),
        DubaiDetailItem(
          title: 'Injury / Crush Incident',
          detail:
              'Stop the operation, make the area safe, activate emergency arrangements and provide response within the team’s competence.',
        ),
        DubaiDetailItem(
          title: 'Incident Preservation',
          detail:
              'After immediate danger is controlled, preserve relevant evidence and equipment condition for investigation.',
        ),
      ],
    ),

    // ========================================================
    // 14
    // ========================================================

    DubaiDetailSection(
      title: '14. Routine & Recurrent Lifting Duties',
      content:
          'Routine lifting is not automatically risk-free. The planned controls must remain valid every time the activity is performed.',
      items: [
        DubaiDetailItem(
          title: 'Pre-Use Check',
          detail:
              'Check lifting equipment and accessories before use for visible damage, abnormal wear, missing identification and defective safety devices.',
        ),
        DubaiDetailItem(
          title: 'Lift Readiness',
          detail:
              'Confirm load, lifting method, access, load path, exclusion zone, communication and competent personnel.',
        ),
        DubaiDetailItem(
          title: 'Toolbox Briefing',
          detail:
              'Brief the team on hazards, controls, roles, signals, exclusion zone and emergency arrangements.',
        ),
        DubaiDetailItem(
          title: 'Periodic Inspection',
          detail:
              'Maintain inspection, examination and certification arrangements required by applicable requirements, manufacturer instructions and project procedures.',
        ),
        DubaiDetailItem(
          title: 'Repeated Lift Review',
          detail:
              'Reassess when load, crane position, radius, ground, weather, access, rigging or nearby work changes.',
        ),
        DubaiDetailItem(
          title: 'After-Lift Closeout',
          detail:
              'Confirm the load is stable, remove rigging safely, control defective equipment and record significant observations.',
        ),
      ],
    ),

    // ========================================================
    // 15
    // ========================================================

    DubaiDetailSection(
      title: '15. Practical Site Example — HVAC Lift',
      content:
          'Example: a packaged HVAC unit is lifted from a delivery vehicle to a prepared installation area.',
      items: [
        DubaiDetailItem(
          title: '1. Planning',
          detail:
              'Confirm weight, dimensions, centre of gravity, lifting points, pick-up point, landing point and operating radius.',
        ),
        DubaiDetailItem(
          title: '2. Crane Selection',
          detail:
              'Select a suitable crane and verify actual configuration against the manufacturer load chart.',
        ),
        DubaiDetailItem(
          title: '3. Ground Assessment',
          detail:
              'Verify support conditions and the relationship between crane position, excavation and underground services.',
        ),
        DubaiDetailItem(
          title: '4. Rigging',
          detail:
              'Select suitable accessories, inspect them, protect sharp edges and establish the approved rigging arrangement.',
        ),
        DubaiDetailItem(
          title: '5. Execution',
          detail:
              'Brief the team, establish exclusion zone, confirm communication and conduct the lift under supervision.',
        ),
        DubaiDetailItem(
          title: '6. Closeout',
          detail:
              'Remove accessories only after the load is stable and secure, inspect equipment and record relevant observations.',
        ),
      ],
    ),

    // ========================================================
    // 16
    // ========================================================

    DubaiDetailSection(
      title: '16. Quick Learning Formula',
      content:
          'PLAN → CHECK → RIG → EXCLUDE → COMMUNICATE → LIFT → MONITOR → LAND → SECURE → CLOSE OUT',
      items: [
        DubaiDetailItem(
          title: 'PLAN',
          detail:
              'Understand task, load, equipment, ground, route and emergency arrangements.',
        ),
        DubaiDetailItem(
          title: 'CHECK',
          detail:
              'Verify capacity, configuration, certification, accessories, weather and site conditions.',
        ),
        DubaiDetailItem(
          title: 'RIG',
          detail:
              'Use the approved rigging method, correct accessories and suitable edge protection.',
        ),
        DubaiDetailItem(
          title: 'EXCLUDE',
          detail:
              'Control the lifting zone and keep people away from suspended loads.',
        ),
        DubaiDetailItem(
          title: 'COMMUNICATE',
          detail:
              'Use one clear signal system and confirm the emergency stop command.',
        ),
        DubaiDetailItem(
          title: 'LIFT & MONITOR',
          detail:
              'Lift in a controlled manner and continuously monitor load, equipment and surroundings.',
        ),
        DubaiDetailItem(
          title: 'LAND & SECURE',
          detail:
              'Land safely, confirm stability and remove accessories only when safe.',
        ),
        DubaiDetailItem(
          title: 'CLOSE OUT',
          detail:
              'Report defects or deviations and capture lessons learned.',
        ),
      ],
    ),

    // ========================================================
    // FINAL — RIGGER RESPONSIBILITIES
    // ========================================================

    DubaiDetailSection(
      title: '🪝 Rigger — Topic-wise Responsibilities',
      content:
          'The rigger’s responsibility changes according to the lifting topic. The following provides a practical topic-by-topic responsibility guide.',
      items: [
        DubaiDetailItem(
          title: '1. Introduction',
          detail:
              'Understand the lifting task, load characteristics, lifting method and personal limits before participating.',
        ),
        DubaiDetailItem(
          title: '2. Types of Lifting',
          detail:
              'Understand the selected lifting appliance and ensure the rigging method is compatible with the equipment and load.',
        ),
        DubaiDetailItem(
          title: '3. Equipment & Accessories',
          detail:
              'Select suitable accessories, verify identification and capacity, inspect condition and reject defective equipment.',
        ),
        DubaiDetailItem(
          title: '4. Technical Requirements',
          detail:
              'Follow the approved rigging arrangement, lifting points, accessory limitations and manufacturer/project requirements.',
        ),
        DubaiDetailItem(
          title: '5. Lifting Plan',
          detail:
              'Understand the approved lifting plan, load path, rigging arrangement, exclusion zone and communication system before starting.',
        ),
        DubaiDetailItem(
          title: '6. Hazards',
          detail:
              'Identify dropped-load, pinch-point, swinging-load, sharp-edge, snagging and uncontrolled-movement hazards.',
        ),
        DubaiDetailItem(
          title: '7. Rigging & Load Control',
          detail:
              'Correctly attach the load, protect slings, maintain balance and control movement during the lift.',
        ),
        DubaiDetailItem(
          title: '8. Pre-Lift Inspection',
          detail:
              'Inspect rigging accessories before use and confirm the arrangement is ready for lifting.',
        ),
        DubaiDetailItem(
          title: '9. Stop Work',
          detail:
              'Immediately stop or signal stop when rigging becomes unsafe, communication is lost, equipment is defective or the load behaves unexpectedly.',
        ),
        DubaiDetailItem(
          title: '10. Interfaces',
          detail:
              'Check that the load and rigging will not contact or overload excavation edges, scaffolds or temporary works.',
        ),
        DubaiDetailItem(
          title: '11. Operational Roles',
          detail:
              'Work under the approved lifting structure and coordinate with the Lift Supervisor, operator and banksman.',
        ),
        DubaiDetailItem(
          title: '12. Communication',
          detail:
              'Use the agreed signals and maintain communication with the banksman/operator throughout the operation.',
        ),
        DubaiDetailItem(
          title: '13. Emergency',
          detail:
              'Respond to emergency instructions, maintain safe positioning and never approach an unstable load without competent control.',
        ),
        DubaiDetailItem(
          title: '14. Recurrent Lifting',
          detail:
              'Repeat pre-use checks and confirm that the rigging arrangement remains suitable when conditions change.',
        ),
        DubaiDetailItem(
          title: '15. HVAC Lift',
          detail:
              'Confirm HVAC lifting points, accessory arrangement, balance, edge protection and safe landing before disconnecting.',
        ),
        DubaiDetailItem(
          title: '16. Learning Formula',
          detail:
              'PLAN → CHECK → RIG → EXCLUDE → COMMUNICATE → LIFT → MONITOR → LAND → SECURE.',
        ),
      ],
    ),

    // ========================================================
    // FINAL — HSE RESPONSIBILITIES
    // ========================================================

    DubaiDetailSection(
      title: '🦺 HSE Roles — Topic-wise Responsibilities',
      initiallyExpanded: false,
      content:
          'HSE responsibilities are consolidated here at the end of the Lifting Operations page, as requested. Each role supports safe implementation according to its level of responsibility and project organization.',
      items: [
        // ----------------------------------------------------
        // HSE OFFICER
        // ----------------------------------------------------

        DubaiDetailItem(
          title: 'HSE Officer — Topic-wise Responsibility',
          detail:
              'Introduction: verify that the lifting activity is recognized as a high-risk operation and that basic controls are understood.\n\n'
              'Types: observe whether the selected lifting method is suitable for the task and site conditions.\n\n'
              'Equipment & Accessories: verify visible condition, identification, inspection status and suitable use of lifting accessories.\n\n'
              'Technical Requirements: monitor implementation of approved risk controls, method statement and lifting arrangements.\n\n'
              'Lifting Plan: verify that the approved plan is available and field conditions are consistent with it.\n\n'
              'Hazards: monitor dropped-load, suspended-load, pinch-point, ground, electrical and interface hazards.\n\n'
              'Rigging: observe safe rigging practices and intervene where unsafe practices are identified.\n\n'
              'Pre-Lift Inspection: verify that required checks have been completed before lifting.\n\n'
              'Stop Work: initiate or support stop-work action when critical safety controls are absent or ineffective.\n\n'
              'Interfaces: monitor lifting near excavation, scaffolding and temporary works.\n\n'
              'Communication: verify exclusion-zone and communication controls.\n\n'
              'Emergency: confirm emergency arrangements are understood and accessible.\n\n'
              'Closeout: record significant observations, defects, incidents and corrective actions.',
        ),

        // ----------------------------------------------------
        // HSE SUPERVISOR
        // ----------------------------------------------------

        DubaiDetailItem(
          title: 'HSE Supervisor — Topic-wise Responsibility',
          detail:
              'Introduction: supervise day-to-day implementation of lifting safety requirements.\n\n'
              'Types: verify that operational controls are suitable for the selected lifting method.\n\n'
              'Equipment & Accessories: supervise equipment-control checks and follow up defective equipment.\n\n'
              'Technical Requirements: verify field implementation of approved HSE controls.\n\n'
              'Lifting Plan: check that the lifting team follows the approved arrangement and escalate deviations.\n\n'
              'Hazards: actively monitor lifting hazards and changing site conditions.\n\n'
              'Rigging: coordinate with the lifting team and challenge unsafe rigging practices.\n\n'
              'Pre-Lift Inspection: confirm pre-lift checks and toolbox briefing are completed.\n\n'
              'Stop Work: support immediate suspension of unsafe work and ensure controls are restored before restart.\n\n'
              'Interfaces: monitor nearby construction activities and temporary works.\n\n'
              'Communication: verify banksman/signaller and exclusion-zone arrangements.\n\n'
              'Emergency: coordinate HSE response actions during lifting emergencies.\n\n'
              'Closeout: follow up corrective actions and communicate lessons learned.',
        ),

        // ----------------------------------------------------
        // SENIOR HSE
        // ----------------------------------------------------

        DubaiDetailItem(
          title: 'Senior HSE — Topic-wise Responsibility',
          detail:
              'Introduction: provide senior HSE oversight for lifting activities.\n\n'
              'Types: challenge the suitability of high-risk lifting methods where necessary.\n\n'
              'Equipment: review significant equipment and certification concerns.\n\n'
              'Technical Requirements: provide senior assurance on critical HSE interfaces.\n\n'
              'Lifting Plan: review major or critical lifting arrangements according to project requirements.\n\n'
              'Hazards: identify systemic and high-consequence lifting risks.\n\n'
              'Rigging: challenge inadequate controls for complex or critical lifts.\n\n'
              'Inspection: verify that significant inspection findings are properly closed.\n\n'
              'Stop Work: support escalation of serious unsafe conditions.\n\n'
              'Interfaces: coordinate significant structural, excavation and temporary-works risks.\n\n'
              'Communication: ensure leadership visibility of major lifting risks.\n\n'
              'Emergency: support serious incident response and escalation.\n\n'
              'Closeout: review lessons learned and recurring trends.',
        ),

        // ----------------------------------------------------
        // HSE COORDINATOR
        // ----------------------------------------------------

        DubaiDetailItem(
          title: 'HSE Coordinator — Topic-wise Responsibility',
          detail:
              'Introduction: coordinate HSE documentation and planning interfaces.\n\n'
              'Types: maintain relevant lifting-method information within project HSE coordination.\n\n'
              'Equipment: coordinate inspection, certification and documentation records.\n\n'
              'Technical Requirements: coordinate technical HSE comments with responsible teams.\n\n'
              'Lifting Plan: coordinate submission, review and controlled distribution of approved documents.\n\n'
              'Hazards: ensure identified lifting hazards are reflected in project controls.\n\n'
              'Rigging: coordinate relevant competency and accessory records.\n\n'
              'Inspection: maintain inspection and action-tracking records.\n\n'
              'Stop Work: coordinate notification and corrective-action records.\n\n'
              'Interfaces: coordinate lifting activities with other contractors and work fronts.\n\n'
              'Communication: coordinate toolbox and briefing records.\n\n'
              'Emergency: maintain relevant emergency-contact and response information.\n\n'
              'Closeout: track actions, documentation and lessons learned.',
        ),

        // ----------------------------------------------------
        // HSE ENGINEER
        // ----------------------------------------------------

        DubaiDetailItem(
          title: 'HSE Engineer — Topic-wise Responsibility',
          detail:
              'Introduction: provide technical HSE input for lifting operations.\n\n'
              'Types: assess HSE implications of selected lifting equipment and methods.\n\n'
              'Equipment: review equipment-related technical safety interfaces.\n\n'
              'Technical Requirements: assess ground, structural, electrical, access and simultaneous-operation interfaces.\n\n'
              'Lifting Plan: review technical HSE aspects of the lifting plan and associated risk controls.\n\n'
              'Hazards: assess complex or non-routine hazards and control measures.\n\n'
              'Rigging: review complex rigging interfaces where engineering input is required.\n\n'
              'Inspection: verify that technical inspection concerns are addressed.\n\n'
              'Stop Work: recommend suspension where technical safety assumptions are no longer valid.\n\n'
              'Interfaces: coordinate excavation, scaffolding, temporary works and structural concerns.\n\n'
              'Communication: support technically complex lifting briefings.\n\n'
              'Emergency: provide technical input during abnormal or emergency conditions.\n\n'
              'Closeout: support technical investigation and corrective-action verification.',
        ),

        // ----------------------------------------------------
        // HSE MANAGER
        // ----------------------------------------------------

        DubaiDetailItem(
          title: 'HSE Manager — Topic-wise Responsibility',
          detail:
              'Introduction: establish project-level expectations for safe lifting operations.\n\n'
              'Types: ensure suitable governance exists for different lifting categories and risk levels.\n\n'
              'Equipment: oversee contractor controls for lifting equipment and certification systems.\n\n'
              'Technical Requirements: provide management assurance for critical HSE requirements.\n\n'
              'Lifting Plan: ensure appropriate review and approval arrangements exist for significant lifts.\n\n'
              'Hazards: monitor major lifting risks and project-wide trends.\n\n'
              'Rigging: ensure competent-person and contractor arrangements are effective.\n\n'
              'Inspection: review significant findings, trends and overdue corrective actions.\n\n'
              'Stop Work: provide management support for stop-work decisions and safe restart.\n\n'
              'Interfaces: ensure major lifting interfaces are coordinated across contractors and disciplines.\n\n'
              'Communication: promote consistent lifting-safety standards and leadership communication.\n\n'
              'Emergency: oversee escalation and management response to serious lifting incidents.\n\n'
              'Closeout: review performance, lessons learned, trends and continual-improvement actions.',
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
          'A professional practical reference covering lifting planning, equipment, rigging, competent roles, hazards, controls, inspection, execution, emergency response and HSE responsibilities.',
      icon: Icons.construction_rounded,
      sections: sections,
    );
  }
}

// ============================================================
// ADVANCED LEARNING PAGE
// SAME FILE — NO SEPARATE lifting_advanced_learning_page.dart
// ============================================================

class LiftingAdvancedLearningPage extends StatelessWidget {
  final String title;
  final String summary;

  const LiftingAdvancedLearningPage({
    super.key,
    required this.title,
    required this.summary,
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
          'Advanced Learning',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          32,
        ),
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0B7653),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.school_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF10231D),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Advanced Explanation',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF075C45),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    summary,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Color(0xFF293B35),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _LearningCard(
            title: 'Site Application',
            icon: Icons.engineering_rounded,
            text:
                'Apply this information together with the approved project lifting plan, risk assessment, method statement, equipment requirements and competent-person arrangements.',
          ),
          _LearningCard(
            title: 'Field Verification',
            icon: Icons.fact_check_rounded,
            text:
                'Before work starts, verify that the actual site conditions match the planned controls. Stop and reassess when significant conditions change.',
          ),
          _LearningCard(
            title: 'Professional HSE Mindset',
            icon: Icons.health_and_safety_rounded,
            text:
                'Do not rely only on paperwork. Compare the approved plan with the actual equipment, people, ground conditions, load path, exclusion zone and communication arrangements.',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// ADVANCED LEARNING SUPPORT CARD
// ============================================================

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
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: const Color(0xFF0B7653),
              size: 27,
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 14.5,
                      height: 1.5,
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
