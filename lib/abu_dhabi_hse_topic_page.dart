import 'package:flutter/material.dart';

import 'data/abu_dhabi_hse_topic_content.dart';
import 'models/reference_topic.dart';

class AbuDhabiHseTopicPage extends StatelessWidget {
  final ReferenceTopic topic;

  const AbuDhabiHseTopicPage({
    super.key,
    required this.topic,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  

  @override
  Widget build(BuildContext context) {
    if (topic.id == 'ad_cop_1_0') {
      return AbuDhabiCop10GoldStandardPage(topic: topic);
    }
    if (topic.id == 'ad_cop_1_1') {
      return AbuDhabiCop11GoldStandardPage(topic: topic);
    }

    final content = abuDhabiHseTopicContent[topic.id];

    if (content == null) {
      return AbuDhabiGenericGoldStandardPage(
        topic: topic,
        content: const AbuDhabiHseTopicContent(),
      );
    }

    return AbuDhabiGenericGoldStandardPage(
      topic: topic,
      content: content,
    );
  }
}

class AbuDhabiGenericGoldStandardPage extends StatelessWidget {
  final ReferenceTopic topic;
  final AbuDhabiHseTopicContent content;

  const AbuDhabiGenericGoldStandardPage({
    super.key,
    required this.topic,
    required this.content,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  List<_GenericGoldSection> get _sections {
    final sections = <_GenericGoldSection>[
      _GenericGoldSection('Overview', content.overview.isEmpty ? <String>[] : <String>[content.overview]),
      _GenericGoldSection('Deep Study', content.deepStudy),
      _GenericGoldSection('Micro-Detail', content.microDetails),
      _GenericGoldSection('Field Practical', content.fieldPractical),
      _GenericGoldSection('Inspection Checklist', content.inspectionChecklist),
      _GenericGoldSection('Emergency / Response', content.emergencyResponse),
      _GenericGoldSection('Records & Evidence', content.records),
    ];

    // Existing interview/regulatory content is preserved in the data layer,
    // but these two sections are intentionally not displayed in the Gold UI.
    return sections.where((section) => section.points.isNotEmpty).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: Text(topic.shortTitle, overflow: TextOverflow.ellipsis),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          _hero(),
          const SizedBox(height: 14),
          ..._sections.asMap().entries.map(
            (entry) => _sectionCard(context, entry.key + 1, entry.value),
          ),
        ],
      ),
    );
  }

  Widget _hero() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topic.title,
              style: const TextStyle(
                fontSize: 24,
                height: 1.18,
                fontWeight: FontWeight.w900,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${topic.shortTitle} • Abu Dhabi HSE Gold Standard',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: primaryGreen,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              topic.description,
              style: const TextStyle(fontSize: 15.5, height: 1.5),
            ),
            const SizedBox(height: 12),
            const Text(
              'Tap a section, then tap a point to study the requirement with detailed explanation, field application, hazards, controls, checks, mistakes, corrective action and records.',
              style: TextStyle(fontSize: 15.2, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard(
    BuildContext context,
    int number,
    _GenericGoldSection section,
  ) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AbuDhabiGenericGoldSectionPage(
              topic: topic,
              section: section,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: primaryGreen.withValues(alpha: 0.12),
                child: Text(
                  '$number',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: darkGreen,
                  ),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Text(
                  section.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
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

class _GenericGoldSection {
  final String title;
  final List<String> points;

  const _GenericGoldSection(this.title, this.points);
}

class AbuDhabiGenericGoldSectionPage extends StatelessWidget {
  final ReferenceTopic topic;
  final _GenericGoldSection section;

  const AbuDhabiGenericGoldSectionPage({
    super.key,
    required this.topic,
    required this.section,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: Text(section.title, overflow: TextOverflow.ellipsis),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                '${topic.shortTitle} — ${section.title}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: darkGreen,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...section.points.asMap().entries.map(
            (entry) => _pointCard(context, entry.key + 1, entry.value),
          ),
        ],
      ),
    );
  }

  Widget _pointCard(BuildContext context, int number, String point) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AbuDhabiGenericGoldPointPage(
              topic: topic,
              section: section,
              pointNumber: number,
              point: point,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: primaryGreen.withValues(alpha: 0.12),
                child: Text(
                  '$number',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: darkGreen,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  point,
                  style: const TextStyle(
                    fontSize: 15.2,
                    height: 1.45,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right, color: darkGreen),
            ],
          ),
        ),
      ),
    );
  }
}

class AbuDhabiGenericGoldPointPage extends StatelessWidget {
  final ReferenceTopic topic;
  final _GenericGoldSection section;
  final int pointNumber;
  final String point;

  const AbuDhabiGenericGoldPointPage({
    super.key,
    required this.topic,
    required this.section,
    required this.pointNumber,
    required this.point,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: Text(topic.shortTitle, overflow: TextOverflow.ellipsis),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
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
                  Text(
                    '${section.title} • Point $pointNumber',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    point,
                    style: const TextStyle(
                      fontSize: 21,
                      height: 1.3,
                      fontWeight: FontWeight.w900,
                      color: darkGreen,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _detailCard('What This Point Means', point),
          _detailCard(
            'Detailed Study',
            'Study this requirement in the context of ${topic.title}. '
            'Confirm the applicable task, people exposed, equipment, work area, '
            'supervision and safe system of work before the activity starts.',
          ),
          _detailCard(
            'Practical Site Example',
            'During a site inspection, observe the actual activity covered by this point. '
            'Compare the field condition with the approved risk assessment, method statement, '
            'procedure and worker instructions. Correct gaps before work continues.',
          ),
          _detailCard(
            'Hazards & Consequences',
            'Failure to control this requirement can expose workers, contractors, visitors, '
            'equipment or the environment to foreseeable hazards. Consider injury, illness, '
            'property damage, environmental impact and escalation of the incident as applicable.',
          ),
          _detailCard(
            'Control Measures',
            'Apply the hierarchy of controls: eliminate the hazard where practicable, '
            'substitute or isolate it, use engineering controls, establish administrative '
            'controls and provide suitable PPE as the final layer.',
          ),
          _detailCard(
            'HSE Officer Field Check',
            'Verify the work area, responsible person, competence, controls, equipment condition, '
            'inspection status, access, housekeeping, signage and required records. '
            'Reassess when conditions or scope change.',
          ),
          _detailCard(
            'Common Mistakes',
            'Typical failures include relying only on PPE, using an outdated risk assessment, '
            'poor communication, incomplete inspection, inadequate supervision, missing records '
            'or continuing work after conditions have changed.',
          ),
          _detailCard(
            'Corrective Action',
            'Stop or control the unsafe condition where necessary, inform the responsible supervisor, '
            'make the area safe, correct the control failure, brief affected personnel and record '
            'the action and follow-up verification.',
          ),
          _detailCard(
            'Documents / Records',
            'Review the documents applicable to this topic, such as risk assessment, method statement, '
            'permit, inspection/checklist, training or competency evidence, maintenance records, '
            'monitoring records, incident records and corrective-action evidence.',
          ),
        ],
      ),
    );
  }

  Widget _detailCard(String title, String text) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: const TextStyle(fontSize: 15.2, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class AbuDhabiCop10GoldStandardPage extends StatelessWidget {
  final ReferenceTopic topic;

  const AbuDhabiCop10GoldStandardPage({
    super.key,
    required this.topic,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('CoP 1.0 — Hazardous Materials'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          _hero(),
          const SizedBox(height: 14),
          _sourceCard(),
          const SizedBox(height: 14),
          ...cop10GoldStandardSections.asMap().entries.map(
                (entry) => _sectionCard(context, entry.key + 1, entry.value),
              ),
        ],
      ),
    );
  }

  Widget _hero() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(topic.title, style: const TextStyle(fontSize: 24, height: 1.18, fontWeight: FontWeight.w900, color: darkGreen)),
            const SizedBox(height: 10),
            const Text('Gold-standard learning and field-reference pilot', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: primaryGreen)),
            const SizedBox(height: 14),
            const Text(
              'This module is built from the current official Abu Dhabi ADPHC CoP 1.0 structure. It preserves the regulatory subject while adding practical explanations, site examples, HSE field checks, records, common mistakes. Tap a section, then tap a point to study that exact requirement.',
              style: TextStyle(fontSize: 15.5, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sourceCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Regulatory baseline', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: darkGreen)),
            SizedBox(height: 8),
            Text('Abu Dhabi Occupational Safety and Health System Framework (ADOSH-SF) — Code of Practice 1.0: Hazardous Materials.', style: TextStyle(fontSize: 15.2, height: 1.45)),
            SizedBox(height: 6),
            Text('Version 4.0 • 15 July 2024', style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800, color: primaryGreen)),
            SizedBox(height: 8),
            Text('Use the official ADPHC publication as the controlling source for regulatory decisions. SafeNexus adds learning and field-reference material around the requirement; it does not replace the official CoP.', style: TextStyle(fontSize: 14.5, height: 1.45)),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard(BuildContext context, int number, CopGoldSection section) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AbuDhabiCop10GoldSectionPage(section: section))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: primaryGreen.withValues(alpha: 0.12), shape: BoxShape.circle),
                child: Text('$number', style: const TextStyle(fontWeight: FontWeight.w900, color: darkGreen)),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(section.title, style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w900, color: darkGreen)),
                    const SizedBox(height: 4),
                    Text('${section.points.length} study points', style: const TextStyle(fontSize: 13.5, color: primaryGreen, fontWeight: FontWeight.w700)),
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


class AbuDhabiCop11GoldStandardPage extends StatelessWidget {
  final ReferenceTopic topic;

  const AbuDhabiCop11GoldStandardPage({
    super.key,
    required this.topic,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('CoP 1.1 — Asbestos'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          _hero(),
          const SizedBox(height: 14),
          _baselineCard(),
          const SizedBox(height: 14),
          ...cop11GoldStandardSections.asMap().entries.map(
                (entry) => _sectionCard(context, entry.key + 1, entry.value),
              ),
        ],
      ),
    );
  }

  Widget _hero() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topic.title,
              style: const TextStyle(
                fontSize: 24,
                height: 1.18,
                fontWeight: FontWeight.w900,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Gold-standard learning and field-reference module',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: primaryGreen,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'A detailed SafeNexus HSE study module for managing asbestos-containing materials in Abu Dhabi. The module follows the official CoP structure and expands each requirement into practical field learning without replacing the official publication.',
              style: TextStyle(fontSize: 15.5, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _baselineCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Official baseline',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: darkGreen,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Abu Dhabi Occupational Safety and Health System Framework (ADOSH-SF) — CoP 1.1: Management of Asbestos Containing Materials.',
              style: TextStyle(fontSize: 15.2, height: 1.45),
            ),
            SizedBox(height: 6),
            Text(
              'Version 4.1 • Effective 27 February 2026',
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w800,
                color: primaryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard(
    BuildContext context,
    int number,
    CopGoldSection section,
  ) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AbuDhabiCop10GoldSectionPage(section: section),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$number',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: darkGreen,
                  ),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section.title,
                      style: const TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w900,
                        color: darkGreen,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${section.points.length} study points',
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: primaryGreen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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

class AbuDhabiCop10GoldSectionPage extends StatelessWidget {
  final CopGoldSection section;

  const AbuDhabiCop10GoldSectionPage({
    super.key,
    required this.section,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: Text(section.title, overflow: TextOverflow.ellipsis),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text(section.introduction, style: const TextStyle(fontSize: 15.5, height: 1.5)),
            ),
          ),
          const SizedBox(height: 12),
          ...section.points.asMap().entries.map((entry) {
            final point = entry.value;
            return Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AbuDhabiCop10GoldPointPage(point: point))),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: primaryGreen.withValues(alpha: 0.12), shape: BoxShape.circle),
                        child: Text('${entry.key + 1}', style: const TextStyle(fontWeight: FontWeight.w900, color: darkGreen)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(point.clause, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: primaryGreen)),
                            const SizedBox(height: 4),
                            Text(point.title, style: const TextStyle(fontSize: 16, height: 1.35, fontWeight: FontWeight.w800, color: darkGreen)),
                          ],
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 6, top: 4), child: Icon(Icons.chevron_right, color: darkGreen)),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class AbuDhabiCop10GoldPointPage extends StatelessWidget {
  final CopGoldPoint point;

  const AbuDhabiCop10GoldPointPage({
    super.key,
    required this.point,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: Text(point.clause, overflow: TextOverflow.ellipsis),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          _header(),
          _detailCard(Icons.menu_book_rounded, 'What this point means', point.meaning),
          _detailCard(Icons.school_rounded, 'Detailed study', point.explanation),
          _detailCard(Icons.construction_rounded, 'Practical site example', point.example),
          _detailCard(Icons.warning_amber_rounded, 'Hazards / consequences', point.hazards),
          _detailCard(Icons.shield_outlined, 'Control approach', point.controls),
          _detailCard(Icons.fact_check_outlined, 'HSE Officer field check', point.fieldCheck),
          _detailCard(Icons.error_outline_rounded, 'Common mistakes', point.commonMistake),
          _detailCard(Icons.task_alt_rounded, 'What to do / corrective action', point.action),
          _detailCard(Icons.folder_copy_outlined, 'Documents / evidence', point.records),
        ],
      ),
    );
  }

  Widget _header() {
    return Card(
      elevation: 0,
      color: const Color(0xFFEFF7F1),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(point.clause, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: primaryGreen)),
            const SizedBox(height: 7),
            Text(point.title, style: const TextStyle(fontSize: 22, height: 1.25, fontWeight: FontWeight.w900, color: darkGreen)),
          ],
        ),
      ),
    );
  }

  Widget _detailCard(IconData icon, String title, String text) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(top: 12),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: primaryGreen, size: 25),
                const SizedBox(width: 10),
                Expanded(child: Text(title, style: const TextStyle(fontSize: 17.5, fontWeight: FontWeight.w900, color: darkGreen))),
              ],
            ),
            const SizedBox(height: 10),
            Text(text, style: const TextStyle(fontSize: 15.5, height: 1.55)),
          ],
        ),
      ),
    );
  }
}
