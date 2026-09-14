import 'package:flutter/material.dart';

class DubaiHsePart2AdvancedLearningPage extends StatelessWidget {
  final String topicTitle;
  final String sectionTitle;
  final String title;
  final String summary;

  const DubaiHsePart2AdvancedLearningPage({
    super.key,
    required this.topicTitle,
    required this.sectionTitle,
    required this.title,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final points = _pointsFor(topicTitle, title);
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: const Text('Advanced Learning'),
        backgroundColor: const Color(0xFF159447),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        children: [
          _header(),
          const SizedBox(height: 12),
          _card('Core Explanation', summary),
          _card('What to Verify in the Field', points[0]),
          _card('Critical Control Points', points[1]),
          _card('HSE Responsibility', points[2]),
          _card('Stop-Work Trigger', points[3]),
          _card('Practical Learning Scenario', points[4]),
          const SizedBox(height: 6),
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
            child: InkWell(
              borderRadius: BorderRadius.circular(17),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DubaiHsePart2DeepLearningPage(topicTitle: topicTitle, sectionTitle: sectionTitle, title: title))),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(children: [
                  Expanded(child: Text('Deeper Learning — Practical Decision Guide', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800))),
                  Icon(Icons.chevron_right_rounded, color: Color(0xFF237A5C)),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() => Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(topicTitle, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF237A5C))),
            const SizedBox(height: 5),
            Text(title, style: const TextStyle(fontSize: 23, height: 1.2, fontWeight: FontWeight.w800, color: Color(0xFF0B5D4B))),
            const SizedBox(height: 7),
            Text(sectionTitle, style: TextStyle(fontSize: 12.5, color: Colors.blueGrey.shade700)),
          ]),
        ),
      );

  Widget _card(String heading, String body) => Card(
        margin: const EdgeInsets.only(bottom: 10),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(heading, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(body, style: const TextStyle(fontSize: 15, height: 1.52)),
          ]),
        ),
      );

  static List<String> _pointsFor(String topic, String item) {
    final lower = '$topic $item'.toLowerCase();
    if (lower.contains('hot work') || lower.contains('welding') || lower.contains('grinding') || lower.contains('cutting')) {
      return [
        'Verify the work location, combustible materials, permit status where required, fire protection, screens, ventilation, equipment condition and fire-watch arrangement.',
        'Control ignition sources, combustibles, cylinders, fumes, sparks and adjacent/concealed spaces. Reassess when the work location changes.',
        'HSE verifies critical controls in the field, intervenes on failed fire prevention controls and ensures corrective actions are tracked.',
        'Stop for an uncontrolled combustible/flammable condition, failed fire protection, defective equipment, unsafe ventilation or invalid permit conditions.',
        'A welding team discovers combustible packaging below the work area. Work pauses, the area is cleared/protected and controls are reverified before restarting.',
      ];
    }
    if (lower.contains('traffic') || lower.contains('vehicle') || lower.contains('pedestrian') || lower.contains('reversing')) {
      return [
        'Verify route condition, segregation, barriers, signs, visibility, banksman/signaller arrangements and emergency access.',
        'Separate people and vehicles, control reversing, eliminate blind-spot exposure and maintain clear routes.',
        'HSE verifies physical segregation and traffic controls rather than relying only on the traffic plan.',
        'Stop movement when pedestrians enter the vehicle path, visibility is inadequate or segregation fails.',
        'A delivery route becomes congested. Vehicle movement is held while pedestrians are cleared and the route is restored.',
      ];
    }
    if (lower.contains('demolition') || lower.contains('collapse') || lower.contains('structural')) {
      return [
        'Verify survey, service isolation, exclusion zone, structural sequence, temporary supports and plant controls.',
        'Maintain structural stability and approved sequence; never improvise removal of load-bearing elements.',
        'HSE verifies exclusion, access, sequence and changing conditions and escalates technical uncertainty.',
        'Stop for unexpected movement, unidentified services, failed exclusion or deviation from the approved sequence.',
        'Unexpected cracking or movement appears. The area is cleared and competent engineering review is obtained before restart.',
      ];
    }
    if (lower.contains('temporary works') || lower.contains('formwork') || lower.contains('falsework') || lower.contains('shoring')) {
      return [
        'Verify approved design, drawings, checking status, foundation, connections, bracing, installation sequence and loading restrictions.',
        'Protect the designed load path and prevent unauthorised alteration or premature removal.',
        'HSE verifies implementation and escalates design or stability concerns to the responsible competent technical person.',
        'Stop for movement, damaged components, missing supports, overload or uncertainty about the approved configuration.',
        'A support is found altered from the drawing. Use is stopped until the arrangement is technically assessed and controlled.',
      ];
    }
    if (lower.contains('heat') || lower.contains('hydration') || lower.contains('shade') || lower.contains('rest')) {
      return [
        'Verify current heat conditions, work intensity, hydration, shade, rest arrangements, acclimatisation and worker condition.',
        'Adjust work-rest arrangements and environmental controls to the actual heat risk and task demand.',
        'HSE verifies implementation, worker awareness and early reporting of symptoms.',
        'Stop or modify work when symptoms occur or required heat controls are inadequate.',
        'A worker reports dizziness during heavy outdoor work. Work stops for the affected person and the emergency/medical response is activated as required.',
      ];
    }
    if (lower.contains('ppe') || lower.contains('helmet') || lower.contains('hand protection') || lower.contains('foot protection')) {
      return [
        'Verify hazard match, correct size/fit, compatibility, condition, availability and user understanding.',
        'PPE must complement higher-level controls and must not create new hazards through incompatibility or poor fit.',
        'HSE verifies correct use, condition and compliance and coaches workers on limitations.',
        'Stop or control the task when required PPE is missing, defective or unsuitable for the hazard.',
        'Two required PPE items interfere with each other. Work pauses until a compatible selection is provided.',
      ];
    }
    if (lower.contains('incident') || lower.contains('near miss') || lower.contains('investigation')) {
      return [
        'Verify scene safety, immediate notifications, evidence preservation, witnesses, records and initial classification.',
        'Focus on causes and failed controls, not only the person closest to the event.',
        'HSE coordinates evidence, analysis, corrective actions and effectiveness verification.',
        'Escalate immediately where serious or recurring uncontrolled risk remains.',
        'A near miss is reported; the area is made safe and the investigation identifies a failed control that is corrected and verified.',
      ];
    }
    if (lower.contains('contractor') || lower.contains('subcontractor')) {
      return [
        'Verify contractor competence, induction, HSE plan, method, risk assessment, permits and work-front supervision.',
        'Integrate contractor controls with project interfaces and simultaneous operations.',
        'HSE monitors field implementation and escalates critical nonconformance.',
        'Stop contractor work where critical controls are absent or ineffective.',
        'A subcontractor starts work with incomplete interface controls; work is held until the missing controls are verified.',
      ];
    }
    if (lower.contains('emergency') || lower.contains('alarm') || lower.contains('rescue')) {
      return [
        'Verify alarms, routes, assembly, emergency equipment, communications, contacts and rescue interfaces.',
        'Emergency arrangements must be practical, accessible and tested, not only documented.',
        'HSE checks readiness and supports drills, lessons learned and corrective actions.',
        'Escalate when credible work is proceeding without required emergency readiness.',
        'An emergency alarm is activated; work stops, people follow the planned route and accountability is completed.',
      ];
    }
    return [
      'Verify the approved risk assessment, method, competence, physical controls and inspection status for the selected item.',
      'Use the hierarchy of controls, maintain the approved method and reassess when site conditions change.',
      'HSE verifies critical controls in the field and records or escalates significant findings.',
      'Stop when a critical control is absent, ineffective or materially different from the approved arrangement.',
      'A critical control is found missing during a field check; work is held, the control is restored and effectiveness is verified before restart.',
    ];
  }
}

class DubaiHsePart2DeepLearningPage extends StatelessWidget {
  final String topicTitle;
  final String sectionTitle;
  final String title;
  const DubaiHsePart2DeepLearningPage({super.key, required this.topicTitle, required this.sectionTitle, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(title: const Text('Practical Decision Guide'), backgroundColor: const Color(0xFF159447), foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        children: [
          _block('Decision 1 — Before Work', 'Confirm scope, risk assessment, approved method, competence, required permit/authorisation and physical controls.'),
          _block('Decision 2 — During Work', 'Compare the actual work front with the planned controls. Watch interfaces, changing conditions and worker exposure.'),
          _block('Decision 3 — When Conditions Change', 'Pause, make the area safe and reassess the task. Do not force the original method onto a changed work environment.'),
          _block('Decision 4 — When a Critical Control Fails', 'Stop work, protect people from the immediate hazard, notify the responsible supervisor/HSE function and restore the control before restart.'),
          _block('Decision 5 — After the Task', 'Confirm the area is left safe, remove temporary controls only when authorised and record significant findings or lessons learned.'),
          _block('Professional Reference Point', '$topicTitle → $sectionTitle → $title. Use the project-approved risk assessment, method statement, applicable requirements and competent-person direction for the actual site decision.'),
        ],
      ),
    );
  }

  Widget _block(String heading, String body) => Card(
        margin: const EdgeInsets.only(bottom: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(heading, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Color(0xFF0B5D4B))),
            const SizedBox(height: 8),
            Text(body, style: const TextStyle(fontSize: 15, height: 1.5)),
          ]),
        ),
      );
}
