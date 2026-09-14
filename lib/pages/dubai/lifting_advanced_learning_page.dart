import 'package:flutter/material.dart';

class LiftingAdvancedLearningPage extends StatelessWidget {
  final String title;
  final String summary;

  const LiftingAdvancedLearningPage({
    super.key,
    required this.title,
    required this.summary,
  });

  static const Color primary = Color(0xFF087F5B);
  static const Color dark = Color(0xFF17352B);
  static const Color background = Color(0xFFF5F8F7);

  static const Map<String, List<String>> _content = {
    'Rigger': [
      'Understand the approved lifting plan, load weight, dimensions, centre of gravity and designated lifting points before rigging starts.',
      'Select lifting accessories suitable for the load, connection arrangement, working conditions and planned lifting method.',
      'Check identification, rated capacity, condition and applicable inspection or certification status before use.',
      'Inspect slings, shackles, hooks and other accessories for cuts, abrasion, broken wires, kinks, crushing, deformation, heat or chemical damage as applicable.',
      'Use suitable edge protection where slings may contact sharp or abrasive edges.',
      'Confirm the rigging arrangement, sling angles, connection points and load stability before raising the load.',
      'Where appropriate, perform a controlled trial lift to confirm balance, security and unexpected movement.',
      'Stay clear of suspended loads, pinch points, crush zones and other line-of-fire areas.',
      'Monitor the rigging continuously for slipping, shifting, tilting, snagging or abnormal loading.',
      'Do not improvise a rigging method outside the approved lifting plan or equipment limitations.',
      'After landing, confirm the load is stable and secure before de-rigging.',
      'Report damaged or defective lifting accessories immediately and prevent unsafe equipment from being reused.',
    ],
    'Banksman / Signalman': [
      'Understand the lifting plan, agreed signals, load path, exclusion zone and emergency stop arrangement before the lift.',
      'Maintain a clear and reliable communication link with the crane operator and avoid conflicting instructions.',
      'Position yourself where signals can be given safely and maintain a suitable view of the load and travel path.',
      'Control personnel and plant interfaces around the lifting area and prevent unauthorized entry into the exclusion zone.',
      'Monitor blind spots, obstructions, structures, scaffolding, temporary works, vehicles and other changing hazards.',
      'Use the agreed hand signals or radio protocol consistently.',
      'Give the emergency stop instruction immediately when an unsafe condition develops.',
      'Never position yourself between the load and a fixed object or in another line-of-fire position.',
    ],
    'Lift Supervisor': [
      'Take operational control of the lifting activity and confirm that the approved lifting plan and method are being followed.',
      'Conduct the pre-lift briefing and confirm that the operator, rigger and banksman/signalman understand their roles.',
      'Verify critical controls including equipment readiness, exclusion zone, communication, access, ground condition and environmental conditions.',
      'Coordinate the lifting team and control simultaneous activities that could interfere with the lift.',
      'Observe the lift continuously and stop the operation if actual conditions differ from the approved method.',
      'Ensure the load is safely landed, secured and released before lifting accessories are disconnected.',
      'Escalate significant deviations, defects, incidents and near misses through the project process.',
    ],
    'Appointed Person / Lift Planner': [
      'Define the lifting task, planning assumptions and lifting method appropriate to the risk and complexity.',
      'Verify reliable information for load weight, dimensions, centre of gravity, lifting points and special characteristics.',
      'Select suitable lifting equipment and verify capacity, operating radius, configuration and manufacturer requirements.',
      'Assess ground bearing, crane position, excavation edges, underground services, structures, scaffolding and temporary works.',
      'Define the rigging arrangement, load path, landing area, exclusion zone and communication method.',
      'Identify competent and authorized personnel and define their responsibilities.',
      'Consider weather, visibility, wind, access, nearby work, public interfaces and emergency arrangements.',
      'Review the plan when the load, equipment, location, ground, method or other critical condition changes.',
      'For complex or critical lifts, coordinate required engineering, technical and management review before authorization.',
    ],
    'HSE Officer': [
      'Monitor field implementation of the approved lifting plan and task-specific risk assessment.',
      'Verify exclusion zones, PPE, access, housekeeping, communication arrangements and basic lifting controls.',
      'Check applicable competency, equipment documentation, inspection and examination records are available.',
      'Observe the operation and identify unsafe acts, unsafe conditions and deviations from the approved method.',
      'Intervene and initiate or recommend stop-work action when critical controls are missing or ineffective.',
      'Record observations, corrective actions, responsible persons and closeout status.',
      'Follow up corrective actions in the field and verify that closed actions are actually effective.',
    ],
    'HSE Supervisor': [
      'Provide day-to-day HSE supervision for lifting activities and verify consistent field implementation of controls.',
      'Coordinate with the Lift Supervisor, lifting team and contractor HSE personnel during planned and recurring lifting activities.',
      'Verify toolbox talks, exclusion zones, access control, PPE, housekeeping and immediate corrective actions.',
      'Monitor changing site conditions and ensure deviations are corrected without delay.',
      'Support field inspections and verify that repeated lifting observations are not becoming recurring risks.',
      'Escalate serious or repeated non-conformances to Senior HSE or HSE management.',
      'Support stop-work decisions when critical risk controls are not maintained.',
    ],
    'Senior HSE': [
      'Provide higher-level HSE oversight for high-risk, complex or critical lifting operations.',
      'Review major risk interfaces, significant deviations and the effectiveness of critical controls.',
      'Challenge weak or incomplete controls and ensure unresolved high-risk issues are escalated.',
      'Review trends, recurring lifting observations, incidents, near misses and lessons learned.',
      'Support project leadership in strengthening lifting assurance and preventing recurrence of significant failures.',
      'Provide senior HSE review where project procedures require escalation for high-risk lifting activities.',
    ],
    'HSE Coordinator': [
      'Coordinate lifting-related HSE submissions, records and communication across project teams and contractors.',
      'Track lifting plans, toolbox talks, inspections, permits where applicable, competency records and corrective actions.',
      'Maintain document coordination so the field team is working to the current approved information.',
      'Follow up outstanding actions and communicate status to responsible personnel.',
      'Coordinate interfaces between construction, lifting, HSE, engineering and subcontractor teams.',
      'Support reporting and document control for recurring lifting activities.',
    ],
    'HSE Engineer': [
      'Review technical HSE interfaces affecting lifting, including ground condition, excavation, temporary works, structures and access.',
      'Assess whether the proposed lifting methodology adequately addresses foreseeable technical hazards.',
      'Coordinate with engineering and construction teams where the lift may affect structures, services or temporary support systems.',
      'Review changes that may invalidate the original risk assessment or lifting assumptions.',
      'Review technical controls for crane setup, lifting zones, load path and interfaces where required by the project.',
      'Recommend technical corrective actions and escalate unresolved engineering-related safety concerns.',
    ],
    'HSE Manager': [
      'Provide overall project HSE governance and assurance for lifting operations.',
      'Establish project expectations for competent personnel, contractor controls, risk management and high-risk lifting assurance.',
      'Review significant or critical lifting arrangements according to the project approval and escalation process.',
      'Ensure serious deviations, incidents, trends and recurring failures receive appropriate management attention.',
      'Coordinate HSE performance review, lessons learned and continual improvement for lifting activities.',
      'Verify that contractor lifting controls are aligned with project HSE requirements.',
      'Ensure HSE assurance supports the operational lifting structure without replacing the Appointed Person, Lift Supervisor, Rigger or Banksman/Signalman.',
    ],
    'Lifting Plan — Step by Step': [
      '1. Define the lifting task — what is being lifted, why, from where to where, and when.',
      '2. Identify the load — confirm reliable weight, dimensions, contents and special characteristics.',
      '3. Identify centre of gravity and lifting points — confirm stability and approved attachment points.',
      '4. Select a suitable crane or lifting appliance — match capacity, reach, access and configuration to the task.',
      '5. Determine operating radius and configuration — establish the actual working geometry.',
      '6. Verify capacity — use the applicable manufacturer load chart and approved lifting information.',
      '7. Assess ground and interfaces — check ground condition, excavation, underground services, structures and temporary works.',
      '8. Select and inspect lifting accessories — confirm suitability, condition, identification and required status.',
      '9. Define the rigging method — establish sling arrangement, connections, angles and edge protection.',
      '10. Map the load path — identify obstacles, landing area, travel route and line-of-fire exposure.',
      '11. Establish the exclusion zone — prevent unauthorized personnel from entering the lifting danger area.',
      '12. Assign competent roles — Appointed Person/Lift Planner, Lift Supervisor, Operator, Rigger and Banksman/Signalman as applicable.',
      '13. Establish communication — agree signals, radio protocol and emergency stop communication.',
      '14. Check environmental conditions — weather, wind, visibility, lighting and surrounding hazards.',
      '15. Conduct toolbox talk and pre-lift verification — confirm everyone understands the method and critical controls.',
      '16. Execute, monitor and close out — lift under control, land safely, de-rig safely and record relevant observations.',
    ],
    'Main Lifting Hazards': [
      'Dropped or falling loads.',
      'Crane overturning, instability or excessive loading.',
      'Failure or misuse of slings, shackles, hooks or other lifting accessories.',
      'Load swing, uncontrolled rotation or unexpected movement.',
      'Personnel entering suspended-load or line-of-fire areas.',
      'Contact with structures, scaffolding, temporary works, vehicles or other plant.',
      'Poor ground conditions, excavation instability or loss of crane support.',
      'Contact with overhead services or other electrical hazards.',
      'Poor communication or conflicting signals.',
      'Adverse weather, wind, poor visibility or inadequate lighting.',
      'Incorrect load information, centre of gravity or lifting-point assumptions.',
    ],
    'Controls': [
      'Use an approved lifting plan and task-specific risk assessment appropriate to the operation.',
      'Use suitable, inspected and correctly rated lifting equipment and accessories.',
      'Maintain competent and authorized personnel for assigned lifting roles.',
      'Establish and maintain an effective exclusion zone and control access.',
      'Control the load path and keep people out of suspended-load and line-of-fire areas.',
      'Verify ground condition, crane setup and interfaces with excavation or temporary works.',
      'Use clear communication and one agreed signalling arrangement.',
      'Monitor environmental conditions and applicable manufacturer/project operating limits.',
      'Stop and reassess whenever critical conditions change.',
    ],
    'Pre-Lift Inspection & Verification': [
      'Confirm the approved lifting plan and current risk assessment are available to the team.',
      'Verify load information, lifting points, crane configuration and planned radius.',
      'Inspect the crane or lifting appliance according to applicable requirements and manufacturer instructions.',
      'Inspect lifting accessories and remove damaged or unidentified items from service.',
      'Verify competent personnel, communication arrangements and exclusion-zone controls.',
      'Check ground, excavation, underground-service and temporary-work interfaces.',
      'Confirm the landing area is prepared and the load can be safely released after landing.',
      'Complete the pre-lift briefing and final site verification before authorization.',
    ],
    'Emergency Response': [
      'Stop the lifting operation immediately when a serious or uncontrolled hazard develops.',
      'Keep personnel away from the suspended load, collapse zone, crane movement area and other line-of-fire hazards.',
      'Raise the alarm and activate the project emergency response arrangements.',
      'Do not approach a trapped, unstable or suspended load unless the area is made safe and the response is authorized.',
      'Where relevant, isolate energy sources and prevent further plant movement through the established emergency procedure.',
      'Provide first aid and emergency assistance within the limits of trained personnel.',
      'Secure the area and prevent unauthorized access.',
      'Report the incident through the project reporting process and preserve relevant evidence where safe.',
      'Do not resume lifting until the cause, condition and required controls have been reviewed and authorization is restored.',
    ],
    'Excavation & Scaffolding Interfaces': [
      'Do not position lifting equipment close to excavation edges without suitable assessment of ground stability and support requirements.',
      'Consider crane loads, outrigger reactions, vibration and surcharge effects on excavation stability.',
      'Identify underground services before positioning or operating lifting equipment where applicable.',
      'Keep suspended loads from striking scaffolding, access towers, platforms, guardrails or temporary structures.',
      'Do not use scaffolding as an improvised lifting support or attachment point unless specifically designed and approved for that purpose.',
      'Control the load path around temporary works and verify the lift will not overload or destabilize them.',
      'Coordinate lifting with excavation, scaffolding and temporary-works teams before starting.',
    ],
    'Routine & Recurrent Lifting Duties': [
      'Routine lifting is not automatically low risk. Each occurrence remains subject to suitable planning, competent supervision and current site conditions.',
      'Complete required pre-use checks before equipment and accessories are used.',
      'Confirm each recurring lift still matches the approved method, load, equipment, location and operating conditions.',
      'Refresh toolbox briefings when personnel, method, environment or risk changes.',
      'Maintain applicable inspection, examination, certification and competency records.',
      'Review recurring observations, defects, near misses and lessons learned.',
      'Stop and reassess if crane position, radius, ground, excavation, scaffolding, temporary works, weather or load changes.',
      'Close out the activity safely after landing, de-rigging and housekeeping.',
    ],
    'Practical Site Example — HVAC Lift': [
      'Task: lift an HVAC unit from the delivery area to a prepared roof-level installation location.',
      'Planning: confirm verified unit weight and dimensions, centre of gravity, approved lifting points and destination.',
      'Crane selection: establish required radius, configuration, capacity and setup using applicable manufacturer information.',
      'Ground interface: verify crane setup area, ground bearing, nearby excavation and underground-service risks.',
      'Rigging: select suitable accessories, protect edges and confirm the unit remains stable during the lift.',
      'Load path: remove or control obstructions and establish an exclusion zone below and around the load path.',
      'Team: appoint the required competent lifting personnel and agree communication signals before the lift.',
      'Trial lift: where appropriate, raise the load in a controlled manner to confirm balance and rigging security.',
      'Execution: lift under control, monitor the load and interfaces, and stop if approved conditions change.',
      'Landing: guide the unit into the prepared location without placing personnel between the load and fixed objects.',
      'Closeout: confirm stability, safely disconnect rigging, control equipment and record observations or lessons learned.',
    ],
  };

  List<String> _points() {
    return _content[title] ??
        [
          summary,
          'Review the applicable lifting plan and task-specific risk assessment.',
          'Use competent personnel and suitable inspected lifting equipment.',
          'Maintain exclusion zones, communication and line-of-fire controls.',
          'Stop and reassess when critical conditions change.',
        ];
  }

  @override
  Widget build(BuildContext context) {
    final points = _points();

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8F3EF),
        foregroundColor: dark,
        elevation: 0,
        title: const Text(
          'Advanced HSE Learning',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                colors: [Color(0xFFE3F4ED), Color(0xFFF9FBFA)],
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 8,
                  offset: Offset(0, 3),
                  color: Color(0x22000000),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ADVANCED HSE LEARNING',
                  style: TextStyle(
                    color: primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.7,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: dark,
                    fontSize: 27,
                    height: 1.18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  summary,
                  style: const TextStyle(
                    color: Color(0xFF40514A),
                    fontSize: 15.5,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detailed Professional Guidance',
                    style: TextStyle(
                      color: dark,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ...List.generate(
                    points.length,
                    (index) => Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7FAF9),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFFDDE9E4),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE1F3EC),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: primary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 11),
                          Expanded(
                            child: Text(
                              points[index],
                              style: const TextStyle(
                                color: Color(0xFF34443E),
                                fontSize: 15.5,
                                height: 1.5,
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
          Container(
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E7),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFFE8D8A8),
              ),
            ),
            child: const Text(
              'STOP-WORK PRINCIPLE\n'
              'If the actual load, equipment, ground, weather, personnel, load path or another critical condition differs from the approved method, stop the operation and reassess before continuing.',
              style: TextStyle(
                color: Color(0xFF4D432A),
                fontSize: 15,
                height: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
