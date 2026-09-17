import 'package:flutter/material.dart';

import 'data/abu_dhabi_hse_topic_content.dart';
import 'models/reference_topic.dart';

/// SafeNexus HSE — Abu Dhabi CoP learning/reference UI.
///
/// Design rule:
/// Official CoP structure is preserved. This page only adds learning depth,
/// field examples and navigation around the existing content.
class AbuDhabiHseTopicPage extends StatelessWidget {
  final ReferenceTopic topic;

  const AbuDhabiHseTopicPage({super.key, required this.topic});

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    final content = abuDhabiHseTopicContent[topic.id];
    if (content != null) {
      return AbuDhabiHseLearningPage(topic: topic, content: content);
    }
    return _LegacyTopicPage(topic: topic);
  }
}

class AbuDhabiHseLearningPage extends StatelessWidget {
  final ReferenceTopic topic;
  final AbuDhabiHseTopicContent content;

  const AbuDhabiHseLearningPage({
    super.key,
    required this.topic,
    required this.content,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  List<_StudySection> get sections => [
        _StudySection('Overview', content.overview, Icons.menu_book_outlined),
        _StudySection('Deep Study', _join(content.deepStudy), Icons.school_outlined),
        _StudySection('Micro-Detail', _join(content.microDetails), Icons.zoom_in_outlined),
        _StudySection('Field Practical', _join(content.fieldPractical), Icons.construction_outlined),
        _StudySection('Inspection Checklist', _join(content.inspectionChecklist), Icons.fact_check_outlined),
        _StudySection('Emergency / Response', _join(content.emergencyResponse), Icons.emergency_outlined),
        _StudySection('Records & Evidence', _join(content.records), Icons.folder_copy_outlined),
        _StudySection('Interview Questions', _join(content.interviewQuestions), Icons.question_answer_outlined),
        _StudySection('Regulatory Verification', _join(content.regulatoryVerification), Icons.verified_outlined),
      ].where((s) => s.text.trim().isNotEmpty).toList();

  static String _join(List<String> items) => items.join('\n');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: Text(
          '${topic.shortTitle} — Study',
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          _heroCard(),
          const SizedBox(height: 14),
          _learningBanner(),
          const SizedBox(height: 14),
          ...sections.asMap().entries.map(
                (entry) => _sectionCard(context, entry.key + 1, entry.value),
              ),
        ],
      ),
    );
  }

  Widget _heroCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topic.title,
              style: const TextStyle(
                fontSize: 23,
                height: 1.2,
                fontWeight: FontWeight.w800,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text(topic.shortTitle)),
                Chip(label: Text(topic.category)),
                Chip(label: Text(topic.jurisdiction)),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content.overview,
              style: const TextStyle(fontSize: 15.5, height: 1.55),
            ),
          ],
        ),
      ),
    );
  }

  Widget _learningBanner() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: primaryGreen.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: primaryGreen.withValues(alpha: 0.18)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.touch_app_outlined, color: darkGreen),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Tap a section → choose a point → open the point-specific study page. Use the examples and field checks as learning/reference support; verify mandatory values against the current official CoP before treating them as regulatory limits.',
              style: TextStyle(fontSize: 14.5, height: 1.45),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard(BuildContext context, int number, _StudySection section) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AbuDhabiHsePointListPage(
                topic: topic,
                section: section,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$number',
                  style: const TextStyle(fontWeight: FontWeight.w800, color: darkGreen),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(section.title, style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w800, color: darkGreen)),
                    const SizedBox(height: 4),
                    Text('${section.points.length} learning points', style: const TextStyle(fontSize: 13.5)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: darkGreen),
            ],
          ),
        ),
      ),
    );
  }
}

class AbuDhabiHsePointListPage extends StatelessWidget {
  final ReferenceTopic topic;
  final _StudySection section;

  const AbuDhabiHsePointListPage({
    super.key,
    required this.topic,
    required this.section,
  });

  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color primaryGreen = Color(0xFF159447);
  static const Color pageBackground = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: Text(section.title, overflow: TextOverflow.ellipsis),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        children: [
          Text(topic.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: primaryGreen)),
          const SizedBox(height: 6),
          Text(section.title, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w800, color: darkGreen)),
          const SizedBox(height: 6),
          const Text('Select a point to open its own explanation, practical example and field verification notes.', style: TextStyle(fontSize: 15, height: 1.45)),
          const SizedBox(height: 14),
          ...section.points.asMap().entries.map(
                (entry) => _pointCard(context, entry.key + 1, entry.value),
              ),
        ],
      ),
    );
  }

  Widget _pointCard(BuildContext context, int number, String point) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AbuDhabiHsePointDetailPage(
                topic: topic,
                sectionTitle: section.title,
                pointNumber: number,
                point: point,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 17,
                backgroundColor: primaryGreen.withValues(alpha: 0.12),
                child: Text('$number', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: darkGreen)),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(point, style: const TextStyle(fontSize: 16, height: 1.45, fontWeight: FontWeight.w700, color: darkGreen))),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right, color: darkGreen),
            ],
          ),
        ),
      ),
    );
  }
}

class AbuDhabiHsePointDetailPage extends StatelessWidget {
  final ReferenceTopic topic;
  final String sectionTitle;
  final int pointNumber;
  final String point;

  const AbuDhabiHsePointDetailPage({
    super.key,
    required this.topic,
    required this.sectionTitle,
    required this.pointNumber,
    required this.point,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  bool get _isCop10 => topic.id == 'ad_cop_1_0';

  @override
  Widget build(BuildContext context) {
    final data = _buildPointStudy();
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: Text('Point $pointNumber', overflow: TextOverflow.ellipsis),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sectionTitle.toUpperCase(), style: const TextStyle(fontSize: 12.5, letterSpacing: .6, fontWeight: FontWeight.w800, color: primaryGreen)),
                  const SizedBox(height: 8),
                  Text(point, style: const TextStyle(fontSize: 21, height: 1.35, fontWeight: FontWeight.w800, color: darkGreen)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _info('What this point means', Icons.menu_book_outlined, data.meaning),
          _info('Practical site example', Icons.construction_outlined, data.example),
          _info('Hazards / consequences', Icons.warning_amber_rounded, data.hazards),
          _info('Control approach', Icons.shield_outlined, data.controls),
          _info('HSE Officer field check', Icons.fact_check_outlined, data.fieldCheck),
          _info('Common mistake', Icons.error_outline, data.commonMistake),
          _info('What to do', Icons.task_alt_outlined, data.action),
          _info('Study note', Icons.lightbulb_outline, data.studyNote),
          _info('Regulatory verification', Icons.verified_outlined, data.regulatory),
        ],
      ),
    );
  }

  Widget _info(String title, IconData icon, String text) {
    return Card(
      margin: const EdgeInsets.only(bottom: 11),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [Icon(icon, color: primaryGreen, size: 24), const SizedBox(width: 9), Expanded(child: Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: darkGreen)))]),
            const SizedBox(height: 10),
            Text(text, style: const TextStyle(fontSize: 15.5, height: 1.55)),
          ],
        ),
      ),
    );
  }

  _PointStudyData _buildPointStudy() {
    final lower = point.toLowerCase();
    if (_isCop10) return _cop10Study(lower);

    return _PointStudyData(
      meaning: 'This point is part of ${topic.title}. Study it together with the surrounding controls, the task risk assessment and the applicable safe system of work. The wording shown above is the existing SafeNexus learning point; the text on this page explains how to understand and apply that point in practice.',
      example: 'Example: before the relevant activity starts on a construction or industrial site, the supervisor reviews the task, identifies the hazards connected with this point, confirms the planned controls and checks the work area. During the activity, the control is rechecked whenever the task, people, equipment or conditions change.',
      hazards: 'If this point is not effectively controlled, the site may experience exposure, injury, equipment damage, environmental harm, loss of control or an emergency. The actual consequence depends on the task, material, equipment and surrounding conditions.',
      controls: 'Use the hierarchy of controls: eliminate the hazard where reasonably practicable, reduce it through engineering or design controls, establish clear procedures and supervision, and use suitable PPE as the final layer where required. Controls should be specific to the task rather than copied without checking site conditions.',
      fieldCheck: 'Ask: What is the hazard? Who can be exposed? What control is supposed to prevent the incident? Is that control physically present and working now? Is the worker competent and aware of the control? Has anything changed since the risk assessment was prepared? Record and close out findings.',
      commonMistake: 'Treating a document, toolbox talk or PPE as proof that the risk is controlled. HSE verification should confirm the actual field condition and the effectiveness of the critical control.',
      action: 'If the control is missing or ineffective, make the situation safe, inform the responsible supervisor, apply the required corrective action and verify closure. Where a serious uncontrolled risk exists, follow the site stop-work and escalation process.',
      studyNote: 'Remember: understand the requirement, understand the hazard, verify the control in the field, and reassess when conditions change.',
      regulatory: 'Use this page as learning and field-reference support. For mandatory Abu Dhabi requirements, verify the exact current wording, version, numeric criteria, exceptions and applicability against the current official ADPHC CoP and linked ADOSH-SF requirements before regulatory use.',
    );
  }

  _PointStudyData _cop10Study(String lower) {
    if (lower.contains('hazard') && lower.contains('ident')) {
      return const _PointStudyData(
        meaning: 'Hazard identification means recognising the hazardous properties of a material, the ways people or the environment can be exposed, and the circumstances in which harm could occur. The identification should consider the material, quantity, task, storage, handling method, workplace conditions and people who may be affected.',
        example: 'A painting team receives a solvent-based coating. Before use, the HSE Officer checks the product identity and available safety information, observes how the product will be stored and applied, and considers vapour, skin or eye contact and ignition hazards. Controls are then matched to the actual work area rather than assuming that PPE alone makes the task safe.',
        hazards: 'Possible consequences can include acute or chronic health effects, fire, chemical reaction, uncontrolled release, environmental contamination and secondary exposure of nearby workers.',
        controls: 'Identify the material first; understand its hazards and exposure routes; select suitable storage, handling, ventilation, segregation, work practices, emergency controls and PPE; communicate the controls to the people doing the work; and verify them in the field.',
        fieldCheck: 'Confirm the material identity, label and safety information; compare the planned task with the actual task; check exposure routes and ignition sources; verify controls and PPE; and ask workers to explain the main hazards and what they would do after a spill or exposure.',
        commonMistake: 'Assuming that a chemical is safe because the container is closed, a worker is wearing gloves, or the product is commonly used on site.',
        action: 'Pause the activity if the material cannot be identified or a critical control is missing. Establish the required information and controls before allowing the work to proceed.',
        studyNote: 'Think in this order: material → hazard → exposure route → people exposed → consequence → control → verification.',
        regulatory: 'For regulatory decisions, verify the current official Abu Dhabi ADPHC CoP 1.0 wording, version and applicability. Do not use this educational example as a substitute for the official CoP.',
      );
    }
    if (lower.contains('sds') || lower.contains('safety data')) {
      return const _PointStudyData(
        meaning: 'Safety information is used to understand a hazardous material before it is stored, handled, transferred or used. The HSE Officer should make sure the information is available to the people who need it and that the controls described for the material are reflected in the actual task.',
        example: 'A new cleaning chemical arrives at a facility. The responsible person reviews the product information before it is issued to workers, checks storage compatibility and required precautions, and communicates the relevant emergency and first-aid information to the team.',
        hazards: 'Using incomplete or incorrect information can lead to incompatible storage, unsuitable PPE, poor exposure control, incorrect spill response or unsafe emergency treatment.',
        controls: 'Maintain current product information, make it accessible, train relevant workers, and connect the information to the risk assessment, storage plan, handling procedure and emergency arrangements.',
        fieldCheck: 'Select a chemical from the work area and ask the worker where its safety information is kept and what the main precautions are. Check that the information corresponds to the actual product.',
        commonMistake: 'Keeping safety information only in an office while workers handling the material do not know where to obtain it or how to use it.',
        action: 'Stop uncontrolled use when the material cannot be positively identified or the necessary safety information is unavailable. Escalate and obtain the correct information before use.',
        studyNote: 'A document is useful only when the right information reaches the person performing the task.',
        regulatory: 'Verify current CoP 1.0 requirements for hazardous-material information and communication against the official ADPHC source.',
      );
    }
    if (lower.contains('stor') || lower.contains('segreg')) {
      return const _PointStudyData(
        meaning: 'Safe storage means keeping hazardous materials in conditions that prevent unwanted release, exposure, ignition, deterioration or interaction with incompatible materials. Storage arrangements should reflect the material properties, quantities, containers and surrounding activities.',
        example: 'During a site inspection, the HSE Officer finds several chemical containers stored together. Instead of checking only housekeeping, the officer verifies identification, container condition, compatibility, access, ignition sources, spill controls and whether the storage arrangement matches the material hazards.',
        hazards: 'Poor storage can cause leaks, fire, incompatible reactions, exposure, falling containers, blocked access and difficult emergency response.',
        controls: 'Use suitable storage areas and containers, maintain identification, segregate incompatible materials where required, control ignition and exposure sources, maintain housekeeping and provide appropriate spill/emergency arrangements.',
        fieldCheck: 'Inspect the storage area physically. Check labels, container condition, compatibility, access, ventilation where relevant, emergency equipment and housekeeping. Confirm that workers know the storage rules.',
        commonMistake: 'Treating all chemicals as if they have the same storage requirements.',
        action: 'Isolate an unsafe arrangement and obtain competent guidance for compatibility and storage before moving or combining materials.',
        studyNote: 'Storage control is a hazard-control activity, not simply a housekeeping activity.',
        regulatory: 'Verify exact Abu Dhabi storage, segregation and quantity requirements in the current official CoP 1.0 before regulatory use.',
      );
    }
    if (lower.contains('spill') || lower.contains('emergency')) {
      return const _PointStudyData(
        meaning: 'Emergency preparedness for hazardous materials means anticipating credible release, exposure, fire or other incidents and ensuring people know how to raise the alarm, isolate the danger, obtain help and use appropriate response arrangements.',
        example: 'A container is knocked over during material handling. The worker raises the alarm and follows the site response procedure instead of immediately touching the spill without knowing the material. The area is controlled, the material is identified and the response is carried out using suitable equipment and competent personnel.',
        hazards: 'An uncontrolled spill can expose workers, spread contamination, create fire or reaction hazards and make evacuation or rescue more difficult.',
        controls: 'Plan credible scenarios, provide suitable response equipment, train workers, establish communication and escalation routes, control access to the affected area and ensure emergency arrangements are compatible with the material hazard.',
        fieldCheck: 'Ask workers what they would do for a spill, splash, inhalation exposure or fire involving the material. Check response equipment, communication arrangements and access to emergency information.',
        commonMistake: 'Keeping spill kits on site without checking whether the kit is suitable for the actual materials or whether workers know how and when to use it.',
        action: 'Protect people first, raise the alarm, control access and follow the established emergency response process. Do not improvise a chemical response beyond the worker’s training and the site procedure.',
        studyNote: 'Emergency planning should be based on credible scenarios, not only on the most convenient response.',
        regulatory: 'Verify current CoP 1.0 emergency-response requirements and any linked site/emergency authority requirements.',
      );
    }
    return _PointStudyData(
      meaning: 'This CoP 1.0 point should be understood in the context of the hazardous material, task and exposure pathway. The objective is to prevent harm by translating material information into practical controls that workers can understand and follow.',
      example: 'Example: before a chemical task begins, the supervisor reviews the relevant control, briefs the team, checks the work area and verifies the critical controls. The HSE Officer then observes the activity and confirms that the planned precautions are actually being followed.',
      hazards: 'Failure to control the point can lead to chemical exposure, fire, reaction, release, environmental harm or secondary exposure. The actual risk depends on the material and task.',
      controls: 'Apply the hierarchy of controls and combine engineering, administrative and PPE measures as appropriate. Keep controls linked to the specific material and work method.',
      fieldCheck: 'Verify the material, task, workers, work area, controls, emergency arrangements and records. Ask the worker to explain the critical control in their own words.',
      commonMistake: 'Copying a generic chemical procedure without checking whether it matches the actual product, quantity, task and work environment.',
      action: 'Correct missing controls before exposure occurs and escalate serious uncontrolled hazards through the site process.',
      studyNote: 'Always connect the material property to the exposure route and then to the control.',
      regulatory: 'Verify the exact current Abu Dhabi ADPHC CoP 1.0 requirement before using this educational explanation as a mandatory instruction.',
    );
  }
}

class _LegacyTopicPage extends StatelessWidget {
  final ReferenceTopic topic;
  const _LegacyTopicPage({required this.topic});

  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  Widget _section(String title, List<String> items) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: darkGreen)),
          const SizedBox(height: 10),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('•', style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF159447), fontSize: 18)),
                  const SizedBox(width: 9),
                  Expanded(child: Text(item, style: const TextStyle(fontSize: 15.5, height: 1.45))),
                ]),
              )),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(title: Text(topic.shortTitle), backgroundColor: darkGreen, foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          _section('Overview', [topic.description]),
          _section('Key Requirements', topic.keyRequirements),
          _section('Safety Controls', topic.safetyControls),
          _section('Responsibilities', topic.responsibilities),
          _section('References', topic.references),
        ],
      ),
    );
  }
}

class _StudySection {
  final String title;
  final String text;
  final IconData icon;
  const _StudySection(this.title, this.text, this.icon);

  List<String> get points => text
      .split('\n')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();
}

class _PointStudyData {
  final String meaning;
  final String example;
  final String hazards;
  final String controls;
  final String fieldCheck;
  final String commonMistake;
  final String action;
  final String studyNote;
  final String regulatory;

  const _PointStudyData({
    required this.meaning,
    required this.example,
    required this.hazards,
    required this.controls,
    required this.fieldCheck,
    required this.commonMistake,
    required this.action,
    required this.studyNote,
    required this.regulatory,
  });
}
