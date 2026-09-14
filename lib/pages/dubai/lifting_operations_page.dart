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
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 28),
        children: [
          _heroCard(),
          const SizedBox(height: 12),
          _sectionCard(
            context,
            '1. Introduction — What is Lifting?',
            introduction,
            Icons.info_outline,
          ),
          const SizedBox(height: 10),
          ...sections.asMap().entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _expandable(entry.value, entry.key + 2),
                ),
              ),
          const SizedBox(height: 4),
          const Text(
            'Tap to Explain',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          const Text(
            'Select any equipment, role or lifting method for a focused explanation.',
            style: TextStyle(fontSize: 14.5, height: 1.4),
          ),
          const SizedBox(height: 8),
          ...tappableItems.map(
                (item) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5,
                    ),
                    title: Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(item.subtitle),
                    ),
                    trailing: const Icon(Icons.chevron_right),
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
      ),
    );
  }

  Widget _heroCard() {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE8F5F1), Color(0xFFF7FAF9)],
          ),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🏗️ Lifting Operations',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 6),
            Text(
              'PLAN SAFE • LIFT SAFE • CONTROL EVERY MOVEMENT',
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 10),
            Text(
              'A practical Dubai HSE learning module covering lifting planning, cranes, rigging, competent persons, hazards, controls, inspections and emergency response.',
              style: TextStyle(fontSize: 15, height: 1.45),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard(
    BuildContext context,
    String title,
    String body,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 27),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Text(body, style: const TextStyle(fontSize: 15, height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _expandable(DubaiDetailSection section, int number) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 17),
        title: Text(
          '$number. ${section.title}',
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              section.body,
              style: const TextStyle(fontSize: 15, height: 1.52),
            ),
          ),
        ],
      ),
    );
  }
}

class DubaiItemPage extends StatelessWidget {
  final DubaiDetailItem item;

  const DubaiItemPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 28),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.subtitle,
                    style: const TextStyle(fontSize: 15, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          ...item.details.asMap().entries.map(
                (entry) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${entry.key + 1}.',
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: const TextStyle(fontSize: 15, height: 1.5),
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

class LiftingOperationsPage extends StatelessWidget {
  const LiftingOperationsPage({super.key});

  static const items = <DubaiDetailItem>[
    DubaiDetailItem(
      title: 'Mobile Crane',
      subtitle: 'Mobile crane used for planned construction lifts',
      details: [
        'Purpose: Used to lift and position materials, plant and structural components where the crane can be safely positioned and configured.',
        'Pre-lift focus: Confirm load weight, radius, crane configuration, applicable load chart, ground condition, outrigger arrangement, lifting accessories, exclusion zone and communication.',
        'Key control: The operator must work within the approved configuration and applicable manufacturer/load-chart limits. Never estimate capacity from appearance.',
      ],
    ),
    DubaiDetailItem(
      title: 'Tower Crane',
      subtitle: 'Fixed crane commonly used for high-rise construction',
      details: [
        'Typical work: Moving reinforcement, formwork, concrete-related materials, MEP equipment and other construction loads within the approved operating area.',
        'Checks: Load/radius limits, hook and rope condition, limit/safety devices, wind conditions, communication, exclusion zones and approved operating arrangements.',
        'Control: Do not lift beyond the permitted configuration or continue when visibility, communication or site conditions become unsafe.',
      ],
    ),
    DubaiDetailItem(
      title: 'Crawler Crane',
      subtitle: 'Crawler-mounted crane for heavy or specialised lifting',
      details: [
        'Main considerations: Ground bearing, crane configuration, counterweight, boom arrangement, radius, load chart and travel/positioning plan.',
        'Control: The lift plan must account for the crane configuration and the actual site conditions. Ground suitability must be assessed before loading the crane.',
      ],
    ),
    DubaiDetailItem(
      title: 'Truck-Mounted Crane',
      subtitle: 'Vehicle-mounted lifting appliance',
      details: [
        'Before lifting: Park on a suitable surface, apply the required vehicle controls, deploy stabilisation/outriggers as designed and verify the lifting area.',
        'Never assume the vehicle alone provides sufficient stability. Follow the crane manufacturer instructions and approved lifting arrangement.',
      ],
    ),
    DubaiDetailItem(
      title: 'Hoist / Material Hoist',
      subtitle: 'Mechanical equipment for controlled vertical lifting',
      details: [
        'Check rated capacity, support/anchorage, rope or chain, hook, controls, brakes, limit devices and inspection status before use.',
        'The supporting structure and anchorage must be suitable for the intended load and arrangement. Keep people away from hazardous suspended-load areas.',
      ],
    ),
    DubaiDetailItem(
      title: 'Web Sling',
      subtitle: 'Flexible textile lifting accessory',
      details: [
        'Inspect identification/WLL, cuts, tears, abrasion, damaged stitching, heat or chemical damage, contamination and deformation.',
        'Use only in an approved configuration and protect against sharp edges. Do not use a sling that is damaged, unidentified or unsuitable for the load.',
      ],
    ),
    DubaiDetailItem(
      title: 'Wire Rope Sling',
      subtitle: 'Steel wire-rope lifting accessory',
      details: [
        'Inspect rope condition, broken wires, kinking, crushing, birdcaging, corrosion, end fittings and identification.',
        'Do not use a rope sling with defects that make it unsafe or outside the manufacturer/inspection criteria. Keep connections correctly seated.',
      ],
    ),
    DubaiDetailItem(
      title: 'Chain Sling',
      subtitle: 'Chain-based lifting accessory for suitable loads',
      details: [
        'Check chain links, hooks, shortening devices, identification and WLL. Look for elongation, deformation, cracks, gouges and excessive wear.',
        'Use only compatible components and configurations. Never improvise with damaged links, pins or fittings.',
      ],
    ),
    DubaiDetailItem(
      title: 'Shackle',
      subtitle: 'Connector used between lifting components',
      details: [
        'Check type, identification/WLL, body, bow, pin, threads and signs of deformation, cracking or excessive wear.',
        'Load the shackle in the intended direction and configuration. Do not substitute an unidentified or unsuitable connector.',
      ],
    ),
    DubaiDetailItem(
      title: 'Hook & Safety Latch',
      subtitle: 'Primary crane connection point',
      details: [
        'Check hook condition, deformation, throat opening, latch function, identification and connection to the lifting appliance.',
        'The load connection must be properly seated in the hook. Do not side-load or use a damaged hook/latch.',
      ],
    ),
    DubaiDetailItem(
      title: 'Spreader Beam / Lifting Beam',
      subtitle: 'Beam used to distribute or control lifting forces',
      details: [
        'Confirm approved design/rating, identification, lifting points, end connections and inspection status.',
        'Use only with the intended configuration and load arrangement. Ensure the load distribution matches the approved design.',
      ],
    ),
    DubaiDetailItem(
      title: 'Tag Line',
      subtitle: 'Line used to help control load rotation or positioning',
      details: [
        'Use from a safe position when needed to control rotation or guide the load without placing workers in the line of fire.',
        'Never wrap a tag line around a hand, body or fixed object in a way that could trap a person if the load moves unexpectedly.',
      ],
    ),
    DubaiDetailItem(
      title: 'Rigger',
      subtitle: 'Competent person responsible for safe load preparation and rigging',
      details: [
        'Role: Identify the load, confirm available load information, understand the centre of gravity, select suitable lifting accessories and prepare the load for lifting.',
        'Rigging: Select suitable sling type/configuration, verify identification and WLL, inspect accessories, protect sharp edges, secure connections and check that the load is stable.',
        'Before the lift: Confirm the lifting points, load path, landing area, exclusion zone and communication arrangement. Participate in a controlled trial lift where required by the lift plan.',
        'During the lift: Monitor the load, maintain a safe position, avoid suspended-load exposure and communicate immediately if the load behaves unexpectedly.',
        'Stop-work: Stop the operation when the load weight is uncertain, accessories are defective, the rigging arrangement is unsafe, communication is lost, people enter the exclusion zone or conditions differ from the approved plan.',
        'Professional rule: IDENTIFY → SELECT → INSPECT → RIG → CHECK → COMMUNICATE → TRIAL LIFT → CONTROL → LAND.',
      ],
    ),
    DubaiDetailItem(
      title: 'Banksman / Signalman',
      subtitle: 'Controls movement through agreed signals and communication',
      details: [
        'Use agreed hand signals or reliable communication and maintain a clear line of communication with the operator.',
        'Control access to the lifting area and give clear instructions. Only the designated signal arrangement should direct the operator unless an emergency stop is required.',
        'If communication or visibility is lost, the lift should be stopped until safe communication is restored.',
      ],
    ),
    DubaiDetailItem(
      title: 'Lift Supervisor',
      subtitle: 'Supervises execution of the approved lifting arrangement',
      details: [
        'Confirm the team understands the lift plan, roles, hazards, controls, exclusion zone and communication method.',
        'Monitor site conditions and stop the lift if the operation becomes unsafe or differs materially from the approved arrangement.',
      ],
    ),
    DubaiDetailItem(
      title: 'Appointed Person / Lift Planner',
      subtitle: 'Plans and coordinates complex lifting arrangements',
      details: [
        'The planning function should assess the load, equipment, lifting accessories, ground/site constraints, load path, hazards, controls, personnel and emergency arrangements.',
        'The lift plan should be suitable for the actual site and equipment configuration and should be reviewed when conditions or the lifting arrangement changes.',
      ],
    ),
    DubaiDetailItem(
      title: 'Centre of Gravity',
      subtitle: 'The balance point that affects load stability',
      details: [
        'The centre of gravity must be understood before selecting lifting points and sling arrangement.',
        'An incorrect rigging arrangement can cause the load to tilt, rotate, slide or swing during initial lifting.',
        'Where the centre of gravity is uncertain, obtain reliable load information or engineering input before lifting.',
      ],
    ),
    DubaiDetailItem(
      title: 'Sling Angle & Load Distribution',
      subtitle: 'Critical factor in multi-leg rigging',
      details: [
        'As the angle and configuration of sling legs change, the forces in the sling system can change significantly.',
        'Do not assume that the total sling WLL equals the load weight. Confirm the approved configuration, manufacturer guidance and applicable rigging calculation.',
        'Where a lift is complex or the load distribution is uncertain, use an engineered lifting arrangement.',
      ],
    ),
    DubaiDetailItem(
      title: 'Lifting Near Excavation',
      subtitle: 'Additional control required when cranes or loads interact with excavations',
      details: [
        'Assess ground stability, excavation geometry, edge loading, underground services and the crane/outrigger position before lifting.',
        'Keep crane loading and outriggers within the assessed safe arrangement. Do not rely on visual distance alone where ground stability is critical.',
        'Coordinate the lifting plan with the excavation control plan and competent persons.',
      ],
    ),
    DubaiDetailItem(
      title: 'Lifting Near Scaffolding',
      subtitle: 'Prevent impact, overloading and falling-object risks',
      details: [
        'Do not allow suspended loads to strike or overload scaffolding. Confirm the scaffold is suitable for any intended material loading arrangement.',
        'Maintain exclusion zones below and around the lift. Any planned loading onto scaffold must follow the approved design/arrangement.',
      ],
    ),
  ];

  static const sections = <DubaiDetailSection>[
    DubaiDetailSection(
      '🏗️ Lifting Operations — Scope',
      'Lifting operations include the planned raising, lowering, positioning or movement of loads using cranes, hoists or other lifting appliances. Safe lifting is a coordinated activity involving load information, equipment selection, rigging, ground/site conditions, competent people, communication, exclusion zones and emergency controls. The operation must match the actual site and equipment configuration.',
    ),
    DubaiDetailSection(
      '🧩 Types & Classification of Lifts',
      'Common categories include routine lifts, heavy lifts, critical/complex lifts, tandem or multiple-crane lifts and personnel lifting. The level of planning and engineering control should increase with the complexity and consequence of the lift. Personnel lifting requires specific approved equipment, procedures and controls and should never be treated as an ordinary material lift.',
    ),
    DubaiDetailSection(
      '📋 How to Prepare a Lifting Plan — Step by Step',
      '1) Define the task and destination. 2) Identify the load, dimensions, weight and centre of gravity. 3) Select a suitable crane/lifting appliance. 4) Determine the operating radius and configuration. 5) Verify capacity using the applicable load chart/manufacturer information. 6) Assess ground bearing, excavation, underground services and positioning. 7) Select and inspect lifting accessories. 8) Define lifting points and rigging method. 9) Map the load path and landing area. 10) Establish an exclusion zone and control access. 11) Assign competent roles: planner/appointed person as applicable, lift supervisor, operator, rigger and signalman. 12) Establish communication and emergency signals. 13) Consider weather, wind, visibility and nearby structures/services. 14) Brief the team through a toolbox talk. 15) Confirm pre-lift checks and authorization. 16) Conduct the lift in a controlled sequence and stop if conditions change. The exact plan format should follow the applicable Dubai requirements, project procedures, manufacturer instructions and the complexity of the lift.',
    ),
    DubaiDetailSection(
      '🧮 Load Assessment & Rigging Calculations',
      'The planning team should verify the actual load weight rather than relying on estimates. Consider the load centre of gravity, lifting points, accessory weights, sling configuration, angles, radius and crane configuration. For complex or non-standard lifts, use an appropriate engineering calculation or approved lifting design. Any uncertainty should be resolved before the lift starts.',
    ),
    DubaiDetailSection(
      '📏 Technical Requirements',
      'Use suitable and inspected lifting appliances and accessories. Verify identification, rated capacity/WLL and inspection status. Confirm the crane configuration, load chart, radius, ground condition, stabilisation/outriggers and safe operating area. Provide competent personnel, effective communication, a controlled exclusion zone and a suitable landing area. Exact capacity, dimensions and operational limits must come from the applicable equipment documentation, manufacturer instructions, approved design and current Dubai/project requirements rather than a generic fixed number.',
    ),
    DubaiDetailSection(
      '⚠️ Main Lifting Hazards',
      'Dropped loads; crane overturning; sling, shackle or hook failure; overload; unstable ground; load swing; uncontrolled rotation; crushing and pinch points; struck-by incidents; collision with structures or plant; contact with overhead services; poor visibility; high wind; communication failure; unauthorised persons entering the lifting zone; and unsafe interaction with excavations, scaffolds or temporary works.',
    ),
    DubaiDetailSection(
      '🛡️ Hierarchy of Safety Controls',
      'Start with safe planning and engineering controls. Select the right lifting equipment, reduce unnecessary suspended-load exposure, design the load path, isolate people from the line of fire, use competent personnel, inspect equipment and accessories, control access, maintain communication and provide suitable PPE. Administrative controls and PPE should support, not replace, sound planning and engineering controls.',
    ),
    DubaiDetailSection(
      '🔍 Pre-Lift Inspection & Readiness Check',
      'Confirm: load identity and weight; lifting points; crane/appliance condition; load chart/configuration; hook and latch; rope/chain; slings; shackles; beams/frames; stabilisers/outriggers; ground and crane position; excavation/edge conditions; overhead hazards; weather/wind; load path; landing area; exclusion zone; communication; competent team; required permits/authorisations; and emergency arrangements. If any critical item is not satisfactory, do not start the lift.',
    ),
    DubaiDetailSection(
      '🪝 Lifting Accessories — Selection & Inspection',
      'Accessories must be suitable for the load and configuration. Check identification and rated capacity/WLL, physical condition and compatibility. Inspect web slings for cuts/tears and damaged stitching; wire rope for broken wires, crushing, kinks and corrosion; chains for deformation/wear; shackles for damage and pin condition; hooks for deformation and latch condition; and beams/frames for identification, damage and approved configuration. Remove defective or unidentified equipment from service according to site procedure.',
    ),
    DubaiDetailSection(
      '🚧 Exclusion Zone & Load Path',
      'The lifting zone must be controlled so that workers and other persons are not exposed to suspended loads or moving equipment. The load path should be planned before the lift and should consider structures, scaffolding, excavations, temporary works, vehicles, electrical services, public areas and other simultaneous activities. The load should never travel over people where this can be avoided.',
    ),
    DubaiDetailSection(
      '👷 Lifting Team Responsibilities',
      'The planning function establishes the safe lifting arrangement; the lift supervisor controls execution; the crane operator operates the appliance within approved limits; the rigger selects, inspects and connects lifting accessories and monitors the load; and the banksman/signalman controls movement through agreed communication. HSE personnel support monitoring and intervention according to the project system. Everyone has a duty to stop an unsafe operation.',
    ),
    DubaiDetailSection(
      '🔄 Safe Lift Sequence',
      'BRIEF → INSPECT → POSITION → RIG → CLEAR AREA → TEST/SLIGHTLY LIFT → CHECK BALANCE → LIFT UNDER CONTROL → MONITOR LOAD PATH → POSITION → LOWER → STABILISE → RELEASE RIGGING SAFELY → CLOSE OUT. The actual sequence must follow the approved lift plan and equipment requirements.',
    ),
    DubaiDetailSection(
      '🛑 Stop-Work Conditions',
      'Stop the lift for unknown load weight, damaged or unidentified accessories, overload, unstable ground, unexpected crane movement, excessive or uncontrolled load swing, loss of communication, poor visibility, unsafe weather/wind, people entering the exclusion zone, contact/near-contact with services or structures, equipment alarms/defects, change in the approved lifting arrangement, or any condition that makes the lift different from the assessed safe plan.',
    ),
    DubaiDetailSection(
      '🚨 Emergency Response',
      'For a dropped load, crane instability, equipment failure, injury or electrical contact: STOP the operation, keep people away, isolate the area, raise the alarm, call the site emergency response, provide first aid only within competence, do not approach a potentially energised area, secure equipment when safe, preserve the scene as required and report/investigate the incident according to the project emergency and incident-management system.',
    ),
    DubaiDetailSection(
      '🏗️ Interaction with Excavation, Scaffolding & Temporary Works',
      'Lifting must be coordinated with other high-risk activities. Near excavations, assess ground and edge stability and crane positioning. Near scaffolding, prevent impact and unauthorised loading. For temporary works and structural components, confirm stability during lifting and landing. The lifting plan should identify these interfaces and assign controls before work begins.',
    ),
    DubaiDetailSection(
      '📍 Practical Site Example — HVAC Equipment Lift',
      'Task: lift an HVAC unit to a prepared landing area. Sequence: confirm unit identity and actual weight → identify centre of gravity and approved lifting points → select crane and configuration → confirm radius/capacity → assess ground and stabilisation → select/inspect slings and shackles → protect sharp edges → establish load path and exclusion zone → brief operator, rigger, signalman and supervisor → conduct controlled trial lift → verify balance and connections → lift slowly under continuous communication → position over the landing area → lower onto stable supports → secure the unit → remove rigging only when safe → complete close-out inspection.',
    ),
    DubaiDetailSection(
      '🧠 Quick Learning Formula',
      'PLAN → ASSESS → SELECT → INSPECT → RIG → EXCLUDE → COMMUNICATE → TEST → LIFT → CONTROL → LAND → CLOSE OUT. A safe lift is not just a crane movement; it is a planned system of people, equipment, load, environment and controls.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DubaiTopicPage(
      title: 'Lifting Operations — Dubai HSE',
      emoji: '🏗️',
      introduction:
          'A lifting operation is a planned activity in which a load is raised, lowered, moved or positioned using a crane, hoist or other lifting appliance. The safe outcome depends on understanding the load, selecting suitable equipment and accessories, assessing the site, assigning competent people, controlling the load path and preventing people from entering the line of fire. This module is designed to help an HSE professional understand the complete lifting process—from identifying the lift and preparing the lifting plan to rigging, execution, landing and emergency response.',
      sections: sections,
      tappableItems: items,
    );
  }
}
