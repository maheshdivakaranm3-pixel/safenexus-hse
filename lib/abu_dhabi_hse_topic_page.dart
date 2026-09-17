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

  Widget _section(String title, List<String> items) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: darkGreen)),
            const SizedBox(height: 10),
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text('•', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: primaryGreen)),
                      ),
                      const SizedBox(width: 9),
                      Expanded(child: Text(item, style: const TextStyle(fontSize: 15.5, height: 1.45))),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (topic.id == 'ad_cop_1_0') {
      return AbuDhabiCop10GoldStandardPage(topic: topic);
    }

    final content = abuDhabiHseTopicContent[topic.id];
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: Text(topic.shortTitle, overflow: TextOverflow.ellipsis),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(topic.title, style: const TextStyle(fontSize: 21, height: 1.2, fontWeight: FontWeight.w800, color: darkGreen)),
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
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (content != null) ...[
            _section('Overview', [content.overview]),
            _section('Deep Study', content.deepStudy),
            _section('Micro-Detail', content.microDetails),
            _section('Field Practical', content.fieldPractical),
            _section('Inspection Checklist', content.inspectionChecklist),
            _section('Emergency / Response', content.emergencyResponse),
            _section('Records & Evidence', content.records),
            _section('Interview Questions', content.interviewQuestions),
            _section('Regulatory Verification', content.regulatoryVerification),
          ] else ...[
            _section('Overview', [topic.description]),
            _section('Key Requirements', topic.keyRequirements),
            _section('Safety Controls', topic.safetyControls),
            _section('Responsibilities', topic.responsibilities),
            _section('References', topic.references),
          ],
        ],
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
              'This module is built from the current official Abu Dhabi ADPHC CoP 1.0 structure. It preserves the regulatory subject while adding practical explanations, site examples, HSE field checks, records, common mistakes and interview preparation. Tap a section, then tap a point to study that exact requirement.',
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
          _detailCard(Icons.question_answer_outlined, 'Interview preparation', point.interview),
          _regulatoryCard(),
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

  Widget _regulatoryCard() {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(top: 12),
      color: const Color(0xFFF1F6ED),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Regulatory verification', style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w900, color: primaryGreen)),
            SizedBox(height: 10),
            Text('Source baseline: Abu Dhabi ADPHC, ADOSH-SF Code of Practice 1.0 — Hazardous Materials, Version 4.0, 15 July 2024. The clause reference on this page is a study locator; use the official publication for the controlling wording and for any regulatory decision.', style: TextStyle(fontSize: 14.5, height: 1.5)),
          ],
        ),
      ),
    );
  }
}
