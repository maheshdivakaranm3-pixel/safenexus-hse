import 'package:flutter/material.dart';

class LiftingAdvancedLearningPage extends StatelessWidget {
  final String title;
  final String summary;

  const LiftingAdvancedLearningPage({
    super.key,
    required this.title,
    required this.summary,
  });

  static const Map<String, List<String>> _specificLearning = {
    'Rigger': [
      'Before the lift, study the approved lifting plan and understand the load, lifting points and rigging method.',
      'Select accessories suitable for the load, connection arrangement and intended lifting configuration.',
      'Check identification, rated capacity, condition and applicable inspection or certification status.',
      'Inspect slings and hardware for damage, wear, deformation, cuts, broken wires, heat or chemical damage as applicable.',
      'Use suitable edge protection where slings can contact sharp or abrasive edges.',
      'Confirm the centre of gravity and expected load behaviour before the main lift.',
      'During lifting, remain in a safe position and keep clear of pinch points, suspended loads and snap-back zones.',
      'Monitor for slipping, shifting, tilting, rotation, snagging or unexpected movement.',
      'Immediately communicate an unsafe condition and stop the operation when the approved method is no longer valid.',
      'After landing, confirm the load is stable and secure before removing accessories.',
      'Report damaged equipment, defects, near misses and deviations and prevent defective accessories from further use.',
    ],
    'Rigger — Role and Responsibilities': [
      'Before Lift: review the lifting plan, verify load information, inspect attachment points and select the correct rigging arrangement.',
      'Rigging: connect accessories correctly, confirm rated capacity, protect sharp edges and maintain load stability.',
      'Trial Lift: where appropriate, raise the load in a controlled manner to verify balance, rigging security and unexpected movement.',
      'During Lift: maintain a safe body position, monitor the rigging and follow the agreed communication system.',
      'Stop Work: stop and inform the Lift Supervisor if the load shifts, rigging slips, an accessory is damaged or another unsafe condition appears.',
      'After Landing: confirm the load is stable before disconnecting, then inspect accessories and report defects.',
      'Professional Rule: never improvise a rigging arrangement outside the approved lifting method.',
    ],
    'Mobile Crane': [
      'Confirm crane type, configuration, capacity and operating radius are suitable for the planned lift.',
      'Verify the actual setup against the manufacturer load chart, including the applicable configuration and support arrangement.',
      'Assess ground bearing, nearby excavations, edges, voids and underground services before positioning the crane.',
      'Control the slew area, load path, exclusion zone and interfaces with other site activities.',
      'Stop and reassess if the ground, configuration, load or operating conditions change.',
    ],
    'Tower Crane': [
      'Confirm approved crane configuration, capacity information and operating limits.',
      'Plan the load path to avoid structures, scaffolds, power lines, other cranes and unauthorized personnel.',
      'Maintain clear communication between the operator and authorized signalman/banksman.',
      'Control environmental conditions in accordance with applicable limits and the approved lifting procedure.',
      'Stop and reassess when the actual lift differs from the approved plan.',
    ],
    'Lift Supervisor': [
      'Confirm the lifting operation follows the approved lifting plan and method.',
      'Coordinate the crane operator, rigger and banksman/signalman before and during the lift.',
      'Verify exclusion zones, communication and other critical controls remain effective.',
      'Stop the operation when conditions change or the lift deviates from the approved method.',
      'Confirm safe landing, securing and closeout of the operation.',
    ],
    'Banksman / Signalman': [
      'Use the agreed hand signals or radio communication and avoid conflicting instructions.',
      'Maintain awareness of the load path, crane movement, exclusion zone and surrounding activities.',
      'Position safely where the operator can reliably receive signals.',
      'Give the emergency stop signal immediately when an unsafe condition is observed.',
      'Help maintain the controlled lifting area and prevent unauthorized entry.',
    ],
    'Appointed Person / Lift Planner': [
      'Define the lifting method and assess foreseeable hazards before the operation.',
      'Select suitable lifting equipment and accessories for the actual load and operating conditions.',
      'Consider load weight, centre of gravity, lifting points, radius, configuration, ground and load path.',
      'Identify competent roles, communication arrangements, exclusion zones and emergency controls.',
      'Review and revise the plan when important assumptions or site conditions change.',
    ],
    'Centre of Gravity': [
      'Use reliable technical information to establish the centre of gravity.',
      'Consider how the centre of gravity affects balance once the load becomes suspended.',
      'Ensure lifting points and sling arrangement support the load without unexpected tipping or shifting.',
      'Where appropriate, use a controlled trial lift to confirm actual behaviour before continuing.',
    ],
    'Sling Angle': [
      'Understand that sling geometry changes forces within the rigging system.',
      'Use approved lifting guidance and manufacturer information for the selected arrangement.',
      'Do not exceed the rated capacity of the sling, connection or other lifting component.',
      'Avoid unstable arrangements and unintended side loading.',
    ],
  };

  List<String> _learningFor(String key) {
    final specific = _specificLearning[key];
    if (specific != null) return specific;

    if (key == 'Wire Rope Sling' ||
        key == 'Web / Round Sling' ||
        key == 'Shackle' ||
        key == 'Hook & Safety Latch' ||
        key == 'Spreader / Lifting Beam') {
      return [
        'Confirm the accessory is suitable for the load and intended connection.',
        'Check identification, rated capacity, condition and applicable inspection status.',
        'Inspect for damage, deformation, wear, cuts, broken wires, heat or chemical damage as applicable.',
        'Do not use damaged, unidentified or unsuitable lifting accessories.',
        'Protect accessories from conditions that could reduce safe performance.',
      ];
    }

    return [
      'Understand the purpose of this control and how it affects the lifting operation.',
      'Confirm the requirement during the pre-lift verification and toolbox talk.',
      'Apply the control according to the approved lifting plan and risk assessment.',
      'Stop and reassess when the load, equipment, ground, weather or method changes.',
      'Record defects, deviations and lessons learned through the project HSE process.',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final points = _learningFor(title);

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
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFFE8F6F0), Color(0xFFF8FBFA)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lifting Operations',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0B7653),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 27,
                      height: 1.15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF10231D),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    summary,
                    style: const TextStyle(
                      fontSize: 15.5,
                      height: 1.5,
                      color: Color(0xFF3D4A45),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Advanced Learning Points',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF17332A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(
                    points.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 13),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}.',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0B7653),
                            ),
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Text(
                              points[index],
                              style: const TextStyle(
                                fontSize: 15.5,
                                height: 1.5,
                                color: Color(0xFF34443E),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            color: const Color(0xFFFFF8E8),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: const BorderSide(color: Color(0xFFE9D9A7)),
            ),
            child: const Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                'Key HSE Rule\n'
                'If the actual load, equipment, ground, weather, personnel, load path or another critical condition differs from the approved plan, stop and reassess before continuing.',
                style: TextStyle(
                  fontSize: 15.5,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
