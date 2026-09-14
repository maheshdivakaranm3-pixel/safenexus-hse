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
      'Select lifting accessories that are suitable for the load, connection arrangement, working conditions and planned lifting method.',
      'Check identification, rated capacity, condition and required inspection or certification status before use.',
      'Inspect slings, shackles, hooks and other accessories for cuts, abrasion, broken wires, kinks, crushing, deformation, heat or chemical damage as applicable.',
      'Use suitable edge protection where a sling may contact a sharp or abrasive edge. Do not allow the sling to be damaged by the load.',
      'Confirm the rigging arrangement, sling angles, connection points and load stability before the load is raised.',
      'Where appropriate, conduct a controlled trial lift to confirm balance, security and unexpected movement before proceeding with the main lift.',
      'Stay clear of suspended loads, pinch points, crush zones and other line-of-fire areas while controlling the load.',
      'Monitor the rigging continuously during the lift for slipping, shifting, tilting, snagging or abnormal loading.',
      'Do not improvise a rigging method that is outside the approved lifting plan or the limits of the selected equipment.',
      'After landing, confirm that the load is stable and secure before de-rigging.',
      'Report damaged or defective lifting accessories immediately and prevent unsafe equipment from being reused.',
    ],
    'Banksman / Signalman': [
      'Understand the lifting plan, agreed signals, load path, exclusion zone and emergency stop arrangement before the lift.',
      'Maintain a clear and reliable communication link with the crane operator. Avoid conflicting instructions from other personnel.',
      'Position yourself where signals can be given safely and, where required, maintain a clear view of the load and travel path.',
      'Control personnel and plant interfaces around the lifting area and prevent unauthorized entry into the exclusion zone.',
      'Monitor blind spots, obstructions, structures, scaffolding, temporary works, vehicles and other changing hazards.',
      'Give clear, deliberate signals and use the agreed radio protocol when radio communication is specified.',
      'Give the emergency stop instruction immediately if an unsafe condition develops. The stop signal must be understood and acted upon.',
      'Never place yourself between the load and a fixed object or in another line-of-fire position.',
    ],
    'Lift Supervisor': [
      'Take operational control of the lifting activity and confirm that the approved lifting plan and method are being followed.',
      'Conduct the pre-lift briefing and confirm that the operator, rigger and banksman/signalman understand their roles.',
      'Verify critical controls including equipment readiness, exclusion zone, communication, access, ground condition and environmental conditions.',
      'Coordinate the lifting team and control simultaneous activities that could interfere with the lift.',
      'Observe the lift continuously and stop the operation if the actual conditions differ from the approved method.',
      'Ensure the load is safely landed, secured and released before the lifting accessories are disconnected.',
      'Escalate significant deviations, equipment defects, incidents and near misses through the project HSE process.',
    ],
    'Appointed Person / Lift Planner': [
      'Define the lifting task, establish the planning assumptions and develop the lifting method appropriate to the risk and complexity of the operation.',
      'Verify reliable information for load weight, dimensions, centre of gravity, lifting points and any special characteristics.',
      'Select suitable lifting equipment and verify capacity, operating radius, configuration and manufacturer requirements.',
      'Assess ground bearing, crane position, excavation edges, underground services, structures, scaffolding and temporary works.',
      'Define the rigging arrangement, load path, landing area, exclusion zone and communication method.',
      'Identify competent and authorized personnel required for the operation and define their responsibilities.',
      'Consider weather, visibility, wind, access, nearby work, public interfaces and emergency arrangements.',
      'Ensure the plan is reviewed when the load, equipment, location, ground, method or other critical condition changes.',
      'For complex or critical lifts, coordinate the required engineering, technical and management reviews before authorization.',
    ],
    'HSE Officer': [
      'Monitor field implementation of the approved lifting plan and risk assessment.',
      'Verify exclusion zones, PPE, access, housekeeping, communication arrangements and basic lifting controls.',
      'Check that competency, equipment documentation and required inspection records are available as required by the project system.',
      'Observe the lifting operation and identify unsafe acts, unsafe conditions and deviations from the approved method.',
      'Intervene and recommend or initiate stop-work action when critical controls are missing or ineffective.',
      'Record observations, corrective actions and closeout status through the project HSE process.',
    ],
    'HSE Supervisor': [
      'Provide day-to-day HSE supervision for lifting activities and verify that field controls are consistently implemented.',
      'Coordinate with the Lift Supervisor, lifting team and contractor HSE personnel during planned and recurring lifting activities.',
      'Verify toolbox talks, exclusion zones, access control, PPE, housekeeping and immediate corrective actions.',
      'Monitor changing site conditions and ensure identified deviations are corrected without delay.',
      'Escalate serious or repeated non-conformances to Senior HSE or HSE management as required.',
      'Support stop-work decisions where critical risk controls are not maintained.',
    ],
    'Senior HSE': [
      'Provide higher-level HSE oversight for high-risk, complex or critical lifting operations.',
      'Review major risk interfaces, significant deviations and the effectiveness of critical controls.',
      'Challenge weak controls and ensure unresolved high-risk issues are escalated to appropriate management.',
      'Review trends, recurring lifting observations, incidents and lessons learned.',
      'Support project leadership in strengthening lifting assurance and preventing recurrence of significant failures.',
    ],
    'HSE Coordinator': [
      'Coordinate lifting-related HSE submissions, records and communication across project teams and contractors.',
      'Track lifting plans, toolbox talks, inspections, permits where applicable, competency records and corrective actions.',
      'Maintain document coordination so that the field team is working to the current approved information.',
      'Follow up outstanding actions and communicate status to responsible personnel.',
      'Support interfaces between construction, lifting, HSE, engineering and subcontractor teams.',
    ],
    'HSE Engineer': [
      'Review technical HSE interfaces affecting lifting, including ground condition, excavation, temporary works, structures and access.',
      'Assess whether the proposed lifting methodology adequately addresses foreseeable technical hazards.',
      'Coordinate with engineering and construction teams where the lift may affect structures, services or temporary support systems.',
      'Review changes in conditions that may invalidate the original risk assessment or lifting assumptions.',
      'Recommend technical corrective actions and escalate unresolved engineering-related safety concerns.',
    ],
    'HSE Manager': [
      'Provide overall project HSE governance and assurance for lifting operations.',
      'Establish project expectations for competent personnel, contractor controls, risk management and high-risk lifting assurance.',
      'Review significant or critical lifting arrangements according to the project approval and escalation process.',
      'Ensure serious deviations, incidents, trends and recurring failures receive appropriate management attention.',
      'Coordinate HSE performance review, lessons learned and continual improvement for lifting activities.',
      'Ensure HSE assurance supports the operational lifting structure without replacing the duties of the Appointed Person, Lift Supervisor, Rigger or Banksman/Signalman.',
    ],
    'Lifting Plan — Step by Step': [
      'Define the lifting task — identify what is being lifted, why it is being lifted, the pick-up point, destination and planned timing.',
      'Identify the load — confirm reliable weight, dimensions, contents and any special characteristics.',
      'Identify centre of gravity and lifting points — confirm stability and approved attachment points.',
      'Select the lifting appliance — match crane or lifting equipment to capacity, reach, access, configuration and manufacturer requirements.',
      'Determine operating radius and configuration — establish the actual working geometry for the planned lift.',
      'Verify capacity — use the applicable manufacturer load chart and approved lifting information.',
      'Assess ground and interfaces — check ground condition, excavation, underground services, structures and temporary works.',
      'Select and inspect lifting accessories — confirm suitability, condition, identification and required status.',
      'Define the rigging method — establish sling arrangement, connections, angles and edge protection.',
      'Map the load path — identify obstacles, landing area, travel route and potential line-of-fire exposure.',
      'Establish the exclusion zone — prevent unauthorized personnel from entering the lifting danger area.',
      'Assign competent roles — Appointed Person/Lift Planner, Lift Supervisor, Operator, Rigger and Banksman/Signalman as applicable.',
      'Establish communication — agree signals, radio protocol and emergency stop communication.',
      'Check environmental conditions — consider weather, wind, visibility, lighting and surrounding hazards.',
      'Conduct toolbox talk and pre-lift verification — confirm everyone understands the method and critical controls.',
      'Execute, monitor and close out — perform the lift under control, land safely, de-rig safely and record relevant observations.',
    ],
    'Main Lifting Hazards': [
      'Dropped or falling loads.',
      'Crane overturning, instability or excessive loading.',
      'Failure or misuse of slings, shackles, hooks or other lifting accessories.',
      'Load swing, uncontrolled rotation or unexpected movement.',
      'Personnel entering suspended-load or line-of-fire areas.',
      'Contact with structures, scaffolding, temporary works, vehicles or other plant.',
      'Poor ground conditions, excavation collapse or loss of crane support.',
      'Contact with overhead services or other electrical hazards.',
      'Poor communication or conflicting signals.',
      'Adverse weather, wind, poor visibility or inadequate lighting.',
      'Incorrect load information, centre of gravity or lifting-point assumptions.',
    ],
    'Controls': [
      'Use an approved lifting plan and task-specific risk assessment appropriate to the operation.',
      'Use suitable, inspected and correctly rated lifting equipment and accessories.',
      'Maintain competent and authorized personnel for the assigned lifting roles.',
      'Establish and maintain an effective exclusion zone and control access.',
      'Control the load path and keep people out of suspended-load and line-of-fire areas.',
      'Verify ground condition, crane setup and interfaces with excavation or temporary works.',
      'Use clear communication and a single agreed signalling arrangement.',
      'Monitor environmental conditions and manufacturer/project operating limits.',
      'Stop and reassess whenever critical conditions change.',
    ],
    'Pre-Lift Inspection & Verification': [
      'Confirm the approved lifting plan and current risk assessment are available to the team.',
      'Verify load information, lifting points, crane configuration and planned radius.',
      'Inspect the crane or lifting appliance in accordance with applicable requirements and manufacturer instructions.',
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
      'Do not approach a trapped, unstable or suspended load unless the area has been made safe and the response is authorized.',
      'Where relevant, isolate energy sources and prevent further plant movement through the established emergency procedure.',
      'Provide first aid and emergency assistance within the limits of trained personnel.',
      'Secure the area and prevent unauthorized access.',
      'Report the incident through the project reporting process and preserve relevant evidence where safe to do so.',
      'Do not resume lifting until the cause, condition and required controls have been reviewed and authorization is restored.',
    ],
    'Excavation & Scaffolding Interfaces': [
      'Do not position lifting equipment close to excavation edges without a suitable assessment of ground stability and support requirements.',
      'Consider crane loads, outrigger reactions, vibration and surcharge effects on excavation stability.',
      'Identify underground services before positioning or operating lifting equipment where applicable.',
      'Keep suspended loads from striking scaffolding, access towers, platforms, guardrails or temporary structures.',
      'Do not use scaffolding as an improvised lifting support or attachment point unless specifically designed and approved for that purpose.',
      'Control the load path around temporary works and verify that the lift will not overload or destabilize them.',
      'Coordinate lifting activities with excavation, scaffolding and temporary-works teams before starting the operation.',
    ],
    'Routine & Recurrent Lifting Duties': [
      'Routine lifting is not automatically low risk. Each occurrence must remain subject to suitable planning, competent supervision and current site conditions.',
      'Complete required pre-use checks before equipment and accessories are used.',
      'Confirm that the recurring lift still matches the approved method, load, equipment, location and operating conditions.',
      'Refresh toolbox briefings when personnel, method, environment or risk changes.',
      'Maintain applicable inspection, examination, certification and competency records.',
      'Review recurring observations, defects, near misses and lessons learned.',
      'Stop and reassess if the crane position, radius, ground, excavation, scaffolding, temporary works, weather or load changes.',
      'Close out the activity safely after landing, de-rigging and housekeeping.',
    ],
    'Practical Site Example — HVAC Lift': [
      'Task: lift an HVAC unit from the delivery area to a prepared roof-level installation location.',
      'Planning: confirm verified unit weight and dimensions, centre of gravity, approved lifting points and destination.',
      'Crane selection: establish the required radius, configuration, capacity and setup arrangement using applicable manufacturer information.',
      'Ground interface: verify crane setup area, ground bearing, nearby excavation and underground-service risks.',
      'Rigging: select suitable lifting accessories, protect edges and confirm the unit remains stable during the lift.',
      'Load path: remove or control obstructions and establish an exclusion zone below and around the load path.',
      'Team: appoint the required competent lifting personnel and agree communication signals before the lift.',
      'Trial lift: where appropriate, raise the load in a controlled manner to confirm balance and rigging security.',
      'Execution: lift slowly, monitor the load and surrounding interfaces, and stop if the approved conditions change.',
      'Landing: guide the unit into the prepared location without placing personnel between the load and fixed objects.',
      'Closeout: confirm stability, safely disconnect rigging, control equipment and record relevant observations or lessons learned.',
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
          'Lifting Operations',
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
                colors: [
                  Color(0xFFE3F4ED),
                  Color(0xFFF9FBFA),
                ],
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
                    'Professional Learning Points',
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
                            width: 30,
                            height: 30,
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
