import 'package:flutter/material.dart';

// ============================================================
// SAFE NEXUS HSE
// DUBAI HSE PART 1 — ADVANCED LEARNING
// Same interaction philosophy as Lifting Advanced Learning.
// Each item from Topics 1–10 opens this deeper page.
// ============================================================

class DubaiHsePart1AdvancedLearningPage extends StatelessWidget {
  final String topicId;
  final String topicTitle;
  final String title;
  final String summary;

  const DubaiHsePart1AdvancedLearningPage({
    super.key,
    required this.topicId,
    required this.topicTitle,
    required this.title,
    required this.summary,
  });

  static const Color primary = Color(0xFF087F5B);
  static const Color dark = Color(0xFF17352B);
  static const Color background = Color(0xFFF5F8F7);

  List<String> get points {
    final specific = _advancedPoints['$topicId|$title'];
    if (specific != null) {
      return specific;
    }

    return [
      summary,
      'Confirm the approved method, task risk assessment and current site conditions before applying this control.',
      'Verify that the people, equipment, access, barriers and communication arrangements required for this item are physically available.',
      'Check interfaces with other work, plant, temporary works, services and public exposure where relevant.',
      'Monitor the control during execution and reassess when the task or environment changes.',
      'Stop the affected activity when the critical control for this item is missing, ineffective or no longer valid.',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final items = points;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8F3EF),
        foregroundColor: dark,
        elevation: 0,
        title: const Text(
          'Advanced Learning',
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
                  topicTitle,
                  style: const TextStyle(
                    color: dark,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 7),
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
                    items.length,
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
                              items[index],
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
          _AdvancedCard(
            title: 'Field Verification',
            icon: Icons.fact_check_rounded,
            text:
                'Compare the approved requirement with the actual workface. Verify physical controls, competent personnel, equipment condition, access and interfaces before exposure.',
          ),
          _AdvancedCard(
            title: 'Professional HSE Focus',
            icon: Icons.health_and_safety_rounded,
            text:
                'The purpose of HSE intervention is not only to identify a defect. Confirm the control is restored, effective and understood before the work continues.',
          ),
          Container(
            margin: const EdgeInsets.only(top: 2),
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
              'If the actual condition no longer matches the approved safe method or a critical control is missing, stop the affected activity and reassess before continuing.',
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

class _AdvancedCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String text;

  const _AdvancedCard({
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

const Map<String, List<String>> _advancedPoints = {
  'dubai_construction_safety|Purpose of the Framework': [
    'The framework establishes who is responsible for planning, controlling, supervising and verifying construction safety across the project.',
    'Define accountability from project management through contractor supervision and the workface.',
    'Confirm high-risk activities have task-specific planning, competent supervision and physical controls.',
    'Check that contractor and subcontractor arrangements integrate with the project HSE system.',
    'Field verification should test whether the written system is actually controlling the work.',
    'Stop affected work when a critical safety barrier cannot be demonstrated.',
  ],
  'dubai_hse_management|HSE Policy': [
    'The HSE policy sets leadership direction and expected standards for the project.',
    'Translate policy commitments into measurable objectives, programmes, responsibilities and resources.',
    'Verify that supervisors and workers understand what the policy means for daily work.',
    'Review whether recurring field findings indicate a gap between leadership expectations and implementation.',
    'Escalate serious or systemic failures through the management system.',
    'The policy becomes meaningful when leadership decisions, resources and field behaviour reflect it.',
  ],
  'dubai_risk_assessment|Hazard Identification': [
    'Identify hazards from the task sequence, energy sources, environment, people, equipment and interfaces.',
    'Consider normal work, abnormal conditions, foreseeable failures and simultaneous operations.',
    'Identify who may be exposed, including workers, contractors, visitors and members of the public where applicable.',
    'Do not stop at generic hazards; connect each hazard to a specific task step and exposure mechanism.',
    'Verify identified hazards in the actual workface before authorising the activity.',
    'If a significant new hazard appears, pause and reassess before continuing.',
  ],
  'dubai_hse_plan|RAMS Register': [
    'The RAMS register should identify the current approved work methods required for planned activities.',
    'Control revisions so supervisors and workers are not using superseded information.',
    'Link high-risk work methods to the relevant risk assessment, permits, inspection requirements and emergency arrangements.',
    'Check implementation in the field rather than treating document approval as proof of safe execution.',
    'Review RAMS when sequence, equipment, personnel or site conditions change materially.',
    'A missing or unsuitable current RAMS should trigger control of the affected activity before exposure.',
  ],
  'dubai_work_at_height|Guardrail': [
    'A guardrail is a collective fall-protection measure intended to prevent people from reaching a fall edge.',
    'Verify the system is suitable for the location, securely installed and compatible with the work platform or structure.',
    'Check for missing sections, damaged members, unintended openings and unauthorised modification.',
    'Consider the interface with access, materials, temporary works and dropped-object exposure.',
    'Do not remove or bypass protection without an approved controlled method and alternative protection.',
    'Stop work where required edge protection is absent or ineffective.',
  ],
  'dubai_confined_space|Gas Detector': [
    'Atmospheric monitoring is a critical control where confined-space hazards may arise from oxygen deficiency, toxic gases or flammable atmospheres.',
    'Use suitable equipment that is maintained and calibrated according to the applicable control system.',
    'Define the testing and monitoring regime from the hazard assessment rather than assuming one test is always sufficient.',
    'Consider atmosphere changes caused by process conditions, ventilation failure, cleaning agents or other work.',
    'Workers must understand the meaning of alarms and the immediate response.',
    'Stop entry when atmospheric conditions are outside the approved safe criteria.',
  ],
  'dubai_electrical|Isolation & Verification': [
    'Identify every relevant energy source and the correct isolation point before electrical work starts.',
    'Isolate the equipment or circuit using the approved process and prevent unintended restoration.',
    'Verify the safe state using the approved test method and suitable instrument before touching conductors.',
    'Control stored or back-fed energy and consider adjacent live systems.',
    'Maintain isolation until the work is complete and the authorised restoration process is followed.',
    'If isolation cannot be positively verified, do not proceed with the exposed work.',
  ],
};
