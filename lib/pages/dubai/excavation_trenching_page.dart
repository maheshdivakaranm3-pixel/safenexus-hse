import 'package:flutter/material.dart';

class DubaiDetailItem {
  final String title;
  final String subtitle;
  final List<String> details;

  const DubaiDetailItem({
    required this.title,
    required this.subtitle,
    required this.details,
  });
}

class DubaiDetailSection {
  final String title;
  final String body;

  const DubaiDetailSection(this.title, this.body);
}

class DubaiTopicPage extends StatelessWidget {
  final String title;
  final String emoji;
  final String introduction;
  final List<DubaiDetailSection> sections;
  final List<DubaiDetailItem> tappableItems;

  const DubaiTopicPage({
    super.key,
    required this.title,
    required this.emoji,
    required this.introduction,
    required this.sections,
    required this.tappableItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
        backgroundColor: const Color(0xFFEAF4F0),
        foregroundColor: const Color(0xFF17231F),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          _card(
            '$emoji  Introduction — What is it?',
            introduction,
          ),
          const SizedBox(height: 12),
          ...sections.map((s) => _expandable(s)),
          if (tappableItems.isNotEmpty) ...[
            const SizedBox(height: 8),
            const Text(
              '🔎 Tap to explore in detail',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
                color: Color(0xFF17332A),
              ),
            ),
            const SizedBox(height: 8),
            ...tappableItems.map(
              (item) => Card(
                margin: const EdgeInsets.only(bottom: 9),
                elevation: 1,
                color: const Color(0xFFF4F8F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: Color(0xFFD7E7E0)),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  title: Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(item.subtitle),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    size: 26,
                    color: Color(0xFF4D5A55),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DubaiItemPage(item: item),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _card(String heading, String body) => Card(
        elevation: 1.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                body,
                style: const TextStyle(fontSize: 15, height: 1.5),
              ),
            ],
          ),
        ),
      );

  Widget _expandable(DubaiDetailSection section) => Card(
        margin: const EdgeInsets.only(bottom: 10),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          tilePadding:
              const EdgeInsets.symmetric(horizontal: 17, vertical: 4),
          childrenPadding:
              const EdgeInsets.fromLTRB(17, 0, 17, 17),
          title: Text(
            section.title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          children: [
            Text(
              section.body,
              style: const TextStyle(
                fontSize: 15,
                height: 1.55,
              ),
            ),
          ],
        ),
      );
}

class DubaiItemPage extends StatelessWidget {
  final DubaiDetailItem item;

  const DubaiItemPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        title: Text(
          item.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: const Color(0xFFEAF4F0),
        foregroundColor: const Color(0xFF17231F),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 32),
        children: [
          Card(
            elevation: 1.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF10231D),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    item.subtitle,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF075C45),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...item.details.asMap().entries.map(
                (entry) => Card(
                  margin: const EdgeInsets.only(bottom: 9),
                  elevation: 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(17),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${entry.key + 1}.',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0B7653),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.55,
                            ),
                          ),
                        ),
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

class ExcavationTrenchingPage extends StatelessWidget {
  const ExcavationTrenchingPage({super.key});

  static const items = <DubaiDetailItem>[
    DubaiDetailItem(
      title: 'Open Excavation',
      subtitle: 'Large or open ground excavation',
      details: [
        'Typical use: foundations, civil works, infrastructure and site development.',
        'Plan the excavation profile and protective system according to ground conditions and the approved design.',
        'Provide edge protection, safe access, plant controls and inspection arrangements.',
        'Keep materials, spoil and equipment controlled so they do not create additional loading or falling-object hazards.',
      ],
    ),
    DubaiDetailItem(
      title: 'Trench Excavation',
      subtitle: 'Narrow or deep excavation',
      details: [
        'Principal risks include side-wall collapse, falls, underground services, water ingress and restricted access.',
        'Use an appropriate protective system such as designed shoring, suitable sloping/benching or a trench protection system where required.',
        'Provide safe entry and exit and keep workers outside unsupported or otherwise unsafe areas.',
        'Inspect before entry and again after events or changes that may affect stability.',
      ],
    ),
    DubaiDetailItem(
      title: 'Foundation Excavation',
      subtitle: 'Excavation for foundations and structural works',
      details: [
        'Assess ground stability, adjacent structures, existing services, access, plant movement and edge protection.',
        'Coordinate excavation with foundation, formwork, reinforcement and concrete activities.',
        'Control water and prevent undermining of nearby structures.',
      ],
    ),
    DubaiDetailItem(
      title: 'Deep Excavation',
      subtitle: 'Excavation requiring enhanced stability controls',
      details: [
        'Deep excavations may require engineered temporary works, support systems, monitoring and specialist review.',
        'Assess ground movement, groundwater, adjacent structures, surcharge loading and construction sequence.',
        'Maintain controlled access and emergency arrangements appropriate to the excavation.',
      ],
    ),
    DubaiDetailItem(
      title: 'Utility Excavation',
      subtitle: 'Excavation around underground services',
      details: [
        'Identify services before breaking ground using available drawings, records, detection methods and controlled verification.',
        'Establish service protection and exclusion controls before excavation.',
        'Use controlled excavation methods near known or suspected services.',
        'Stop work and escalate immediately if an unidentified or damaged service is encountered.',
      ],
    ),
    DubaiDetailItem(
      title: 'Manhole / Chamber Excavation',
      subtitle: 'Excavation associated with underground chambers',
      details: [
        'Consider excavation stability, access, atmospheric hazards, water, traffic and interaction with confined-space controls.',
        'Do not enter a confined-space environment without the applicable assessment, permit and controls.',
      ],
    ),
    DubaiDetailItem(
      title: 'Shoring',
      subtitle: 'Structural support to excavation sides',
      details: [
        'Purpose: reduce the risk of side-wall collapse and protect workers inside the excavation.',
        'Use a designed or approved system suitable for the actual ground and excavation conditions.',
        'Do not remove, modify or bypass shoring without authorization and appropriate technical control.',
        'Inspect the system and surrounding ground after changes, impact, water ingress or other events affecting stability.',
      ],
    ),
    DubaiDetailItem(
      title: 'Trench Box',
      subtitle: 'Protective trench system',
      details: [
        'Provides a protected working area inside a trench when correctly selected and installed.',
        'Use according to the manufacturer or approved design requirements.',
        'Position and progress the system in a manner that does not expose workers to unsupported ground.',
        'Maintain safe access and keep workers within the protected zone.',
      ],
    ),
    DubaiDetailItem(
      title: 'Benching',
      subtitle: 'Stepped excavation profile',
      details: [
        'Creates a stepped profile to reduce unsupported soil height where the ground and approved design permit.',
        'The configuration must be appropriate to actual ground conditions and project requirements.',
        'Do not treat benching as automatically safe without competent assessment.',
      ],
    ),
    DubaiDetailItem(
      title: 'Sloping',
      subtitle: 'Angled excavation sides',
      details: [
        'Changes the excavation profile to reduce the likelihood of collapse where suitable.',
        'Slope selection must be based on ground conditions and applicable requirements or engineering design.',
        'Monitor for cracking, sloughing, erosion, water effects and changes in soil condition.',
      ],
    ),
    DubaiDetailItem(
      title: 'Access Ladder',
      subtitle: 'Safe entry and exit',
      details: [
        'Provide suitable and secure access/egress appropriate to the excavation depth and task.',
        'Keep access clear and protected from plant, materials and water.',
        'Workers must never climb unstable excavation sides as an alternative to designated access.',
      ],
    ),
    DubaiDetailItem(
      title: 'Stair / Temporary Access',
      subtitle: 'Controlled pedestrian access',
      details: [
        'Provide suitable stairs or other approved access where required by the work arrangement.',
        'Maintain safe landings, handrails where required, clear width and good housekeeping.',
      ],
    ),
    DubaiDetailItem(
      title: 'Barricade & Edge Protection',
      subtitle: 'Fall and unauthorized-access control',
      details: [
        'Provide suitable barriers around exposed excavation edges and access points.',
        'Use warning signs and physical controls appropriate to the risk and site environment.',
        'Maintain the barrier system during the full period of exposure.',
      ],
    ),
    DubaiDetailItem(
      title: 'Spoil Pile Control',
      subtitle: 'Control of excavated material',
      details: [
        'Keep spoil, materials and equipment controlled so they do not overload excavation edges or fall into the excavation.',
        'Maintain the separation and edge-control arrangement required by the approved method and site conditions.',
      ],
    ),
    DubaiDetailItem(
      title: 'Dewatering',
      subtitle: 'Water control in excavations',
      details: [
        'Assess groundwater, rainwater, leakage and drainage before work begins.',
        'Use a suitable dewatering arrangement where required and prevent uncontrolled discharge or erosion.',
        'Water accumulation must not be allowed to compromise stability or safe access.',
      ],
    ),
    DubaiDetailItem(
      title: 'Plant & Vehicle Interface',
      subtitle: 'Control of mobile plant near excavation',
      details: [
        'Separate pedestrians and plant and establish controlled routes.',
        'Prevent unauthorized plant approach to excavation edges.',
        'Use banksman/signaller arrangements where required by the risk assessment.',
        'Consider vibration and surcharge effects on excavation stability.',
      ],
    ),
  ];

  static const sections = <DubaiDetailSection>[
    DubaiDetailSection(
      '2. Types of Excavation',
      'Common forms include open excavation, trench excavation, foundation excavation, deep excavation, utility excavation and manhole/chamber excavation. The protective method must be selected for the actual ground, geometry, surrounding structures and work sequence.',
    ),
    DubaiDetailSection(
      '3. Excavation Protection Systems',
      'Protection may include engineered shoring, trench boxes, suitable sloping, benching and other approved temporary works. The selected system must be appropriate to the ground and construction conditions and must not be modified without proper authorization.',
    ),
    DubaiDetailSection(
      '4. Technical Requirements',
      'Before excavation, establish the scope and sequence, assess ground conditions, identify underground services, assess adjacent structures and surcharge loads, determine the protective system, plan access and egress, control spoil and plant, manage water and establish inspection requirements. Exact dimensions, slopes, support arrangements and other technical values must follow applicable Dubai requirements, approved design, competent engineering assessment and manufacturer instructions.',
    ),
    DubaiDetailSection(
      '5. Excavation Risk Assessment & Planning',
      'Plan the excavation before breaking ground. Consider soil/ground condition, depth and geometry, service location, nearby structures, traffic, plant, weather, water, access, rescue arrangements, simultaneous operations and changes expected during the excavation sequence.',
    ),
    DubaiDetailSection(
      '6. Main Excavation Hazards',
      'Major hazards include collapse or ground movement, falls into excavations, underground service strikes, falling materials, plant interaction, water accumulation, hazardous atmospheres, poor access, adjacent-structure movement and uncontrolled public access.',
    ),
    DubaiDetailSection(
      '7. Shoring, Trench Box, Benching & Sloping',
      'Use a suitable protection system based on competent assessment and approved design. Workers must not enter unsupported or otherwise unsafe excavation areas. Protection must remain effective throughout the work and be inspected after relevant changes or events.',
    ),
    DubaiDetailSection(
      '8. Access & Egress',
      'Provide safe, suitable and maintained access and emergency egress. Keep ladders, stairs and routes clear. Access arrangements must match the excavation configuration and the work being performed.',
    ),
    DubaiDetailSection(
      '9. Underground Services',
      'Identify and locate buried electrical cables, gas lines, water lines, communication services and other utilities before excavation. Use controlled excavation methods and protect identified services. Stop work immediately when an unexpected service is found or suspected.',
    ),
    DubaiDetailSection(
      '10. Water & Dewatering',
      'Assess groundwater, rain, leakage and drainage. Water can weaken ground, reduce visibility, affect access and contribute to instability. Use suitable water-control measures and reassess conditions after significant rainfall or water ingress.',
    ),
    DubaiDetailSection(
      '11. Plant, Vehicles & Spoil',
      'Control plant routes, reversing, edge approach, vibration and surcharge loading. Keep spoil and materials controlled and prevent uncontrolled access to the excavation. Use banksman/signaller arrangements where required by the risk assessment.',
    ),
    DubaiDetailSection(
      '12. Inspection',
      'A competent person should inspect the excavation and protective arrangements before entry and whenever conditions may have changed. Check ground condition, protection, access, edge condition, water, spoil, plant interface, nearby structures and service controls.',
    ),
    DubaiDetailSection(
      '13. Stop-Work Conditions',
      'Stop work for signs of collapse or movement, damaged or displaced protection, unknown underground services, unsafe access, significant water ingress, uncontrolled plant near the edge, cracks or ground deformation, hazardous atmosphere or any condition outside the approved method.',
    ),
    DubaiDetailSection(
      '14. Competent Person Responsibilities',
      'Assess excavation conditions, verify the protection system, inspect the excavation, identify changes, control unsafe conditions, communicate findings and ensure corrective measures are completed before work resumes.',
    ),
    DubaiDetailSection(
      '15. Worker Responsibilities',
      'Use designated access, stay within protected areas, follow the exclusion system, do not remove or modify protection, maintain awareness of ground and water conditions, and immediately report cracks, movement, service concerns or other unsafe conditions.',
    ),
    DubaiDetailSection(
      '16. Emergency Response',
      'COLLAPSE / SERVICE STRIKE / FLOODING → STOP WORK → RAISE ALARM → ISOLATE THE AREA → KEEP PEOPLE OUT → CALL EMERGENCY RESPONSE → FOLLOW THE RESCUE PLAN → DO NOT ENTER AN UNSTABLE EXCAVATION.',
    ),
    DubaiDetailSection(
      '17. Practical Site Example',
      'Foundation excavation near an underground electrical service: review records → locate and verify the service → establish protection and exclusion controls → use controlled excavation → maintain competent supervision → inspect the excavation → stop and reassess if actual conditions differ from the plan.',
    ),
    DubaiDetailSection(
      '18. Quick Learning Formula',
      'PLAN → LOCATE → PROTECT → ACCESS → INSPECT → CONTROL → STOP → RESPOND. Never enter an excavation simply because it was previously safe; current conditions must remain suitable.',
    ),
    DubaiDetailSection(
      '🪝 Rigger / Plant Operator Responsibilities — Topic-wise',
      'Excavation often interfaces with excavators, dumpers, lifting operations and temporary works. The rigger or plant-related worker must follow the approved plant/lifting arrangement, maintain safe separation from excavation edges, follow banksman/signaller instructions, prevent suspended loads or plant from creating unsafe edge loading, and immediately stop and report unsafe ground, unexpected services, loss of communication or changing conditions. For lifting materials into or out of excavations, the approved lifting plan and exclusion-zone controls remain applicable.',
    ),
    DubaiDetailSection(
      '🦺 HSE Roles — Topic-wise Responsibilities',
      'HSE responsibilities are consolidated here at the end of the page. HSE Officer, HSE Supervisor, Senior HSE, HSE Coordinator, HSE Engineer and HSE Manager have different levels of assurance, coordination, technical review and management responsibility.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return const DubaiTopicPage(
      title: 'Excavation & Trenching',
      emoji: '🕳️',
      introduction:
          'Excavation is the removal of soil or ground to form trenches, pits, foundations or other openings. Principal risks include collapse, falls, underground services, falling materials, plant interaction, water ingress and hazardous atmospheres. Safe excavation requires planning, competent assessment, suitable protection, controlled access, inspection and emergency readiness.',
      sections: sections,
      tappableItems: items,
    );
  }
}


// ============================================================
// FINAL HSE ROLE DETAIL PAGE
// ============================================================

class ExcavationHseRolesPage extends StatelessWidget {
  const ExcavationHseRolesPage({super.key});

  static const roles = <DubaiDetailItem>[
    DubaiDetailItem(
      title: 'HSE Officer',
      subtitle: 'Field-level excavation safety monitoring',
      details: [
        'Introduction: verify that excavation is treated as a high-risk activity and that workers understand the basic controls.',
        'Types: monitor whether the selected excavation method and protection arrangement are suitable for the task.',
        'Protection Systems: inspect visible condition of shoring, trench boxes, barriers, access and edge controls.',
        'Risk Assessment: verify field implementation of the approved risk assessment and method statement.',
        'Underground Services: verify service-identification controls and report unexpected services immediately.',
        'Plant & Spoil: monitor plant separation, edge loading, traffic controls and spoil management.',
        'Inspection: participate in or verify required field inspections and close observations.',
        'Stop Work: intervene when collapse indicators, unsafe access, service uncertainty or other critical conditions exist.',
        'Emergency: raise alarm and support isolation, exclusion and emergency response without entering an unstable excavation.',
      ],
    ),
    DubaiDetailItem(
      title: 'HSE Supervisor',
      subtitle: 'Day-to-day HSE supervision',
      details: [
        'Plan and supervise day-to-day implementation of excavation controls.',
        'Verify toolbox briefings, access, barriers, protective systems and service controls.',
        'Monitor changing ground, water, plant and weather conditions.',
        'Coordinate with the competent person, excavation supervisor and plant team.',
        'Ensure unsafe observations are corrected and escalated when necessary.',
        'Support stop-work and safe restart decisions.',
        'Follow up inspection findings and corrective actions.',
      ],
    ),
    DubaiDetailItem(
      title: 'Senior HSE',
      subtitle: 'Senior assurance and high-risk oversight',
      details: [
        'Provide senior HSE oversight for deep, complex or high-consequence excavations.',
        'Challenge inadequate controls and ensure significant risks are escalated.',
        'Review major interfaces with structures, temporary works, utilities, traffic and other contractors.',
        'Monitor recurring excavation findings and lessons learned.',
        'Support management decisions for stop-work, corrective action and safe restart.',
      ],
    ),
    DubaiDetailItem(
      title: 'HSE Coordinator',
      subtitle: 'HSE documentation and interface coordination',
      details: [
        'Coordinate excavation-related risk assessments, method statements, permits and inspection records.',
        'Coordinate service information and relevant contractor submissions.',
        'Track corrective actions and inspection closeouts.',
        'Coordinate excavation interfaces between contractors, disciplines and work fronts.',
        'Maintain controlled HSE records and communicate relevant changes to the project team.',
      ],
    ),
    DubaiDetailItem(
      title: 'HSE Engineer',
      subtitle: 'Technical HSE interface',
      details: [
        'Review technical HSE interfaces involving ground stability, temporary works, services, structures and water.',
        'Coordinate technical concerns with competent engineers and responsible construction teams.',
        'Assess changes that may invalidate the planned excavation controls.',
        'Support review of deep excavation, adjacent-structure and complex service risks.',
        'Provide technical HSE input to investigations and corrective actions.',
      ],
    ),
    DubaiDetailItem(
      title: 'HSE Manager',
      subtitle: 'Project-level HSE governance',
      details: [
        'Establish project-level expectations for safe excavation and trenching.',
        'Ensure appropriate competent-person, contractor and inspection arrangements exist.',
        'Review significant excavation risks and major incidents or near misses.',
        'Ensure serious stop-work decisions receive management support.',
        'Monitor project-wide trends, recurring failures and improvement actions.',
        'Ensure lessons learned are communicated and integrated into the HSE management system.',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        title: const Text('HSE Roles — Excavation'),
        backgroundColor: const Color(0xFFEAF4F0),
        foregroundColor: const Color(0xFF17231F),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 32),
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                'Topic-wise HSE responsibilities for Excavation & Trenching. '
                'Each role supports safe execution at its assigned level of responsibility.',
                style: TextStyle(fontSize: 15.5, height: 1.55),
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...roles.map(
            (role) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: Text(
                  role.title,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                subtitle: Text(role.subtitle),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DubaiItemPage(item: role),
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
