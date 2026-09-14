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
      appBar: AppBar(title: Text(title), elevation: 0),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 28),
        children: [
          _heroCard(),
          const SizedBox(height: 12),
          _sectionCard(
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
          const SizedBox(height: 6),
          const Text(
            'Tap to Explain',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          const Text(
            'Tap any equipment, lifting role, method or technical topic for a focused explanation.',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$emoji Lifting Operations — Dubai HSE',
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            const Text(
              'PLAN SAFE • LIFT SAFE • CONTROL EVERY MOVEMENT',
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            const Text(
              'A practical professional reference covering lifting planning, equipment, rigging, competent roles, hazards, controls, inspection, execution and emergency response.',
              style: TextStyle(fontSize: 15, height: 1.45),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard(String title, String body, IconData icon) {
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
                  Text(
                    body,
                    style: const TextStyle(fontSize: 15, height: 1.5),
                  ),
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

  static const sections = <DubaiDetailSection>[
    DubaiDetailSection(
      '2. Types of Lifting Operations',
      'Common operations include mobile crane, tower crane, crawler crane, truck-mounted crane, hoist, material hoist, heavy lift, critical lift, tandem lift and approved personnel lifting arrangements. The selected method must match the load, site and equipment limitations.',
    ),
    DubaiDetailSection(
      '3. Lifting Equipment & Accessories',
      'The lifting system may include crane or hoist, hook and latch, wire-rope sling, web sling, round sling, chain sling, shackles, lifting beam, spreader beam, lifting frame, tag line, load-indicating devices and stabilisation equipment. Each component must be suitable, identifiable and inspected before use.',
    ),
    DubaiDetailSection(
      '4. Lifting Plan — How to Prepare It',
      'A lifting plan should describe the actual task and define the load, equipment, configuration, capacity, radius, ground conditions, lifting accessories, rigging arrangement, load path, exclusion zone, competent team, communication, weather controls, toolbox talk, emergency arrangements and pre-lift verification. Review the plan whenever the load, equipment, location or conditions change.',
    ),
    DubaiDetailSection(
      '5. Lifting Plan — Step-by-Step',
      '1. Define the lifting task.\\n2. Identify the load and confirm reliable weight information.\\n3. Identify centre of gravity and lifting points.\\n4. Select suitable crane or lifting appliance.\\n5. Determine operating radius and configuration.\\n6. Verify applicable capacity using the manufacturer/load chart.\\n7. Assess ground, excavation and underground-service risks.\\n8. Select and inspect lifting accessories.\\n9. Define the rigging method and protect sharp edges.\\n10. Map the load path and landing area.\\n11. Establish the exclusion zone.\\n12. Assign competent/authorized roles.\\n13. Establish communication and emergency signals.\\n14. Check weather and surrounding hazards.\\n15. Conduct toolbox talk and pre-lift verification.\\n16. Execute, monitor, land and close out the lift.',
    ),
    DubaiDetailSection(
      '6. Main Lifting Hazards',
      'Dropped loads, crane overturning, sling or shackle failure, overloading, unstable ground, load swing, crushing and pinch points, falling objects, poor communication, blind lifts, overhead services, collision, high wind, poor visibility and unauthorised access are key hazards requiring task-specific controls.',
    ),
    DubaiDetailSection(
      '7. Rigging & Load Control',
      'The rigger should confirm the load information, centre of gravity, lifting points, accessory suitability, WLL/SWL, sling configuration, connection security and edge protection. The load should be stable before the main lift. A controlled trial lift may be used where required by the lift plan to verify balance and rigging.',
    ),
    DubaiDetailSection(
      '8. Pre-Lift Inspection & Verification',
      'Verify crane condition and configuration, applicable certification/inspection status, load chart, hook and latch, ropes/chains, slings, shackles and beams, ground condition, outriggers/stabilisation, weather, load path, exclusion zone, communication, competent personnel and required authorization or permit arrangements.',
    ),
    DubaiDetailSection(
      '9. Stop-Work Conditions',
      'Stop the lift when load weight or configuration is uncertain, lifting accessories are defective, ground stability is doubtful, the load becomes uncontrolled, communication is lost, the exclusion zone is breached, weather exceeds safe limits, an overhead-service risk develops, or the actual conditions differ materially from the approved lifting arrangement.',
    ),
    DubaiDetailSection(
      '10. Lifting Near Excavation, Scaffolding & Temporary Works',
      'Near excavations, assess ground bearing, edge stability, crane positioning and underground services. Near scaffolding, prevent impact, overloading and unauthorised use of the scaffold as a lifting support. For temporary works and structural elements, confirm stability during lifting, transfer and landing. These interfaces should be identified in the risk assessment and lifting plan.',
    ),
    DubaiDetailSection(
      '11. HSE Roles During Lifting',
      'HSE Officer: site monitoring, verification of controls, intervention and stop-work escalation.\\nSenior HSE: senior oversight of high-risk lifts, major deviations and corrective actions.\\nHSE Coordinator: HSE documentation, contractor coordination, records and action tracking.\\nHSE Engineer: technical HSE interfaces involving ground, excavation, structure, temporary works and services.\\nHSE Manager: project-level HSE governance, escalation and management oversight.\\nThese HSE roles do not automatically replace the operational lifting roles.',
    ),
    DubaiDetailSection(
      '12. Operational Lifting Roles',
      'Lift Planner/Appointed Person (as applicable): develops the lifting arrangement and risk controls. Lift Supervisor: controls execution at the worksite. Crane Operator: operates the crane within the approved configuration and manufacturer limits. Rigger: prepares and connects the load using suitable accessories. Banksman/Signalman: controls movement through the agreed communication system.',
    ),
    DubaiDetailSection(
      '13. Communication & Exclusion Zone',
      'Use an agreed signalling and communication method. Maintain a controlled exclusion zone around the lifting operation and load path. People must not stand under suspended loads or enter the line of fire. If the operator cannot safely understand the signal or communication is lost, stop the lift until control is restored.',
    ),
    DubaiDetailSection(
      '14. Emergency Response',
      'For a dropped load, crane instability, equipment failure, injury or electrical contact: stop the operation, raise the alarm, isolate and control the area, contact the designated emergency response team, keep personnel away from suspended or potentially energised equipment, provide first aid only within competence, and preserve the scene when safe for subsequent reporting and investigation.',
    ),
    DubaiDetailSection(
      '15. Practical Site Example — HVAC Lift',
      'Confirm the HVAC unit identity, actual weight and dimensions → verify centre of gravity and lifting points → select crane/configuration → confirm radius and applicable capacity → assess ground and stabilisation → select and inspect slings/shackles → protect sharp edges → define load path and landing area → establish exclusion zone → brief the lifting team → conduct controlled trial lift where required → confirm balance → lift slowly with continuous communication → land on prepared supports → secure the unit → remove rigging safely → complete close-out inspection.',
    ),
    DubaiDetailSection(
      '16. Quick Learning Formula',
      'PLAN → ASSESS → SELECT → INSPECT → RIG → EXCLUDE → COMMUNICATE → TEST → LIFT → CONTROL → LAND → CLOSE OUT.',
    ),
  ];

  static const tappableItems = <DubaiDetailItem>[
    DubaiDetailItem(
      title: 'Rigger',
      subtitle: 'Load preparation, rigging and safe connection',
      details: [
        'Identify the load and confirm reliable weight information before rigging.',
        'Understand the centre of gravity and identify approved lifting points.',
        'Select suitable slings, shackles, hooks and beams for the planned configuration.',
        'Check identification, WLL/SWL, inspection status and physical condition.',
        'Protect slings from sharp edges and ensure connections are correctly seated.',
        'Maintain a safe position and never stand under a suspended load.',
        'Stop the lift if the rigging is defective, the load is unstable, communication is lost or conditions change.',
      ],
    ),
    DubaiDetailItem(
      title: 'Banksman / Signalman',
      subtitle: 'Controls crane movement through agreed signals',
      details: [
        'Use the agreed hand signals or reliable communication method.',
        'Maintain clear communication with the crane operator.',
        'Control access to the lifting area and help maintain the exclusion zone.',
        'Never give conflicting instructions to the operator.',
        'Give or support an emergency stop instruction whenever an immediate danger is identified.',
        'Stop the operation if visibility or communication is lost.',
      ],
    ),
    DubaiDetailItem(
      title: 'Lift Supervisor',
      subtitle: 'Controls safe execution at the worksite',
      details: [
        'Confirm the lifting team understands the approved plan, sequence and controls.',
        'Verify the work area, exclusion zone and communication arrangements before starting.',
        'Monitor the operation and actual site conditions continuously.',
        'Stop the lift when the operation becomes unsafe or differs materially from the approved arrangement.',
        'Coordinate safe landing and close-out of the lifting activity.',
      ],
    ),
    DubaiDetailItem(
      title: 'Appointed Person / Lift Planner',
      subtitle: 'Plans the lifting arrangement and risk controls',
      details: [
        'Define the task, load, equipment, configuration and lifting sequence.',
        'Assess load path, ground conditions, surrounding hazards and interfaces.',
        'Specify suitable lifting accessories and rigging arrangements.',
        'Define competent roles, communication, exclusion zones and emergency arrangements.',
        'Ensure the plan is reviewed when conditions or the lifting arrangement changes.',
      ],
    ),
    DubaiDetailItem(
      title: 'HSE Officer',
      subtitle: 'Site-level HSE monitoring and intervention',
      details: [
        'Verify that the lifting plan, risk assessment and required controls are available.',
        'Check inspection/certification and competency arrangements relevant to the activity.',
        'Monitor exclusion zones, line-of-fire controls and site conditions.',
        'Intervene when unsafe conditions or control failures are observed.',
        'Escalate or initiate stop-work for an immediate serious risk.',
        'Record observations, incidents, near misses and corrective actions.',
      ],
    ),
    DubaiDetailItem(
      title: 'Senior HSE',
      subtitle: 'Senior safety oversight for significant lifting activities',
      details: [
        'Review high-risk or critical lifting arrangements as required by the project.',
        'Verify major risk controls and contractor interfaces.',
        'Provide senior HSE oversight and support intervention on major deviations.',
        'Escalate significant non-compliance and follow corrective actions.',
        'Review lessons learned and recurring lifting risks.',
      ],
    ),
    DubaiDetailItem(
      title: 'HSE Coordinator',
      subtitle: 'Coordinates HSE records, contractors and actions',
      details: [
        'Coordinate lifting-related HSE documents and contractor submissions.',
        'Track toolbox talks, inspections, permits and competency records.',
        'Coordinate communication between project, contractor and HSE teams.',
        'Record documentation gaps and significant changes.',
        'Track closure of HSE actions.',
      ],
    ),
    DubaiDetailItem(
      title: 'HSE Engineer',
      subtitle: 'Technical HSE interface and engineering risk support',
      details: [
        'Review lifting risk assessments and engineering HSE interfaces.',
        'Assess ground, excavation, structural, temporary-works and service interfaces.',
        'Coordinate technical concerns with responsible lifting or engineering personnel.',
        'Monitor whether technical controls remain suitable as conditions change.',
        'Escalate instability or unexpected movement immediately.',
        'Document observations and recommend corrective actions.',
      ],
    ),
    DubaiDetailItem(
      title: 'HSE Manager',
      subtitle: 'Project-level HSE governance and escalation',
      details: [
        'Establish or review project HSE requirements for lifting operations.',
        'Verify suitable competent-person arrangements and contractor controls.',
        'Review escalated high-risk or critical lifting activities as required.',
        'Provide management-level HSE oversight and escalation.',
        'Support suspension where serious non-compliance exists.',
        'Review major incidents, trends and corrective actions.',
      ],
    ),
    DubaiDetailItem(
      title: 'Centre of Gravity',
      subtitle: 'Key factor in load balance and stability',
      details: [
        'Determine or obtain reliable information about the load centre of gravity.',
        'Position lifting points and accessories so the load remains stable.',
        'An incorrect arrangement can cause tilt, rotation, sliding or uncontrolled swing.',
        'If the centre of gravity is uncertain, obtain reliable information or competent engineering input before lifting.',
      ],
    ),
    DubaiDetailItem(
      title: 'Sling Angle',
      subtitle: 'Affects forces in multi-leg sling arrangements',
      details: [
        'Changes in sling angle can significantly change the forces carried by sling legs.',
        'Do not assume total sling capacity equals the load weight.',
        'Confirm the approved configuration, manufacturer guidance and applicable rigging calculation.',
        'Use an engineered arrangement when the load distribution or configuration is complex or uncertain.',
      ],
    ),
    DubaiDetailItem(
      title: 'Mobile Crane',
      subtitle: 'Mobile crane for planned construction lifting',
      details: [
        'Confirm load, radius, configuration and applicable load-chart limits.',
        'Assess ground bearing, outriggers, stabilisation and nearby excavations.',
        'Verify lifting accessories, exclusion zone, communication and weather controls.',
        'Operate only within the approved arrangement and manufacturer requirements.',
      ],
    ),
    DubaiDetailItem(
      title: 'Tower Crane',
      subtitle: 'Fixed crane for high-rise and general construction lifts',
      details: [
        'Check applicable load/radius limits and operating configuration.',
        'Verify hook, rope, safety devices, communication and wind conditions.',
        'Control the load path and keep personnel outside the exclusion zone.',
        'Stop when visibility, communication or operating conditions become unsafe.',
      ],
    ),
    DubaiDetailItem(
      title: 'Wire Rope Sling',
      subtitle: 'Steel wire-rope lifting accessory',
      details: [
        'Inspect for broken wires, kinks, crushing, birdcaging, corrosion and damaged end fittings.',
        'Confirm identification and applicable WLL/SWL.',
        'Use only in a suitable approved configuration.',
        'Remove from service when inspection criteria or manufacturer requirements indicate it is unsafe.',
      ],
    ),
    DubaiDetailItem(
      title: 'Web / Round Sling',
      subtitle: 'Flexible textile lifting accessory',
      details: [
        'Check identification, WLL, cuts, tears, abrasion, damaged stitching, heat and chemical damage.',
        'Protect the sling from sharp edges and unsuitable contact surfaces.',
        'Do not use damaged, unidentified or unsuitable textile slings.',
        'Follow manufacturer and inspection requirements for the selected configuration.',
      ],
    ),
    DubaiDetailItem(
      title: 'Shackle',
      subtitle: 'Connector between compatible lifting components',
      details: [
        'Check type, identification/WLL, body, bow, pin, threads and condition.',
        'Look for cracks, deformation, excessive wear or damaged threads.',
        'Use the shackle in the intended direction and configuration.',
        'Never improvise with an unidentified or unsuitable connector.',
      ],
    ),
    DubaiDetailItem(
      title: 'Hook & Safety Latch',
      subtitle: 'Primary crane connection point',
      details: [
        'Check hook condition, deformation, throat opening and safety latch function.',
        'Confirm identification and connection to the lifting appliance.',
        'Seat the load connection correctly in the hook.',
        'Do not side-load or use a damaged hook or latch.',
      ],
    ),
    DubaiDetailItem(
      title: 'Spreader / Lifting Beam',
      subtitle: 'Controls load distribution and lifting geometry',
      details: [
        'Confirm approved design/rating, identification and inspection status.',
        'Check lifting points, end connections and intended configuration.',
        'Ensure load distribution matches the approved arrangement.',
        'Use only within the design and manufacturer limitations.',
      ],
    ),
    DubaiDetailItem(
      title: 'Tag Line',
      subtitle: 'Helps control rotation and positioning',
      details: [
        'Use from a safe position when needed to control load rotation.',
        'Keep hands and body clear of pinch points and the line of fire.',
        'Do not wrap the line around a person or create a trapping hazard.',
        'Stop and reassess if the load becomes uncontrolled.',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DubaiTopicPage(
      title: 'Lifting Operations — Dubai HSE',
      emoji: '🏗️',
      introduction:
          'A lifting operation is a planned activity in which a load is raised, lowered, moved or positioned using a crane, hoist or other lifting appliance. Safe lifting depends on understanding the load, selecting suitable equipment and accessories, assessing the site, assigning competent people, controlling the load path and preventing exposure to suspended loads. This module covers the complete process from lifting-plan preparation and rigging to controlled execution, landing and emergency response.',
      sections: sections,
      tappableItems: tappableItems,
    );
  }
}
