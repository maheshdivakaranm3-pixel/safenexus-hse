import 'package:flutter/material.dart';

import 'data/abu_dhabi_excavation_gold.dart';
import 'data/abu_dhabi_hse_topic_content.dart';
import 'models/reference_topic.dart';

/// SafeNexus HSE — Abu Dhabi HSE reusable topic detail engine.
///
/// The generic CoP content layer remains intact for the wider registry.
/// Excavation is routed to its dedicated Gold Standard module so the first
/// topic can expose the complete locked 38-section field-handbook structure.
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
    if (topic.id == 'ad_excavation') {
      return AbuDhabiExcavationGoldStandardPage(topic: topic);
    }

    final content = abuDhabiHseTopicContent[topic.id];
    return AbuDhabiGenericGoldStandardPage(
      topic: topic,
      content: content ?? const AbuDhabiHseTopicContent(),
    );
  }
}

class AbuDhabiExcavationGoldStandardPage extends StatelessWidget {
  final ReferenceTopic topic;

  const AbuDhabiExcavationGoldStandardPage({
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
        title: const Text('Excavation'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          _hero(),
          const SizedBox(height: 12),
          _regulatoryCard(),
          const SizedBox(height: 14),
          const Text(
            'Gold Standard Field Handbook',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '38 structured sections. Tap any section for the requirement, hazards, controls, field checks, common mistakes, corrective action and evidence to retain.',
            style: TextStyle(fontSize: 14.8, height: 1.45),
          ),
          const SizedBox(height: 12),
          ...excavationGoldStandardSections.asMap().entries.map(
                (entry) => _sectionCard(context, entry.key, entry.value),
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
                fontSize: 25,
                height: 1.18,
                fontWeight: FontWeight.w900,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Abu Dhabi HSE • Gold Standard Field Safety Module',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: primaryGreen,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              topic.description,
              style: const TextStyle(fontSize: 15.2, height: 1.5),
            ),
            const SizedBox(height: 12),
            const Text(
              'IDENTIFY → ASSESS → ELIMINATE → CONTROL → VERIFY → MONITOR → REVIEW → IMPROVE',
              style: TextStyle(
                fontSize: 13.2,
                height: 1.45,
                fontWeight: FontWeight.w900,
                color: darkGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _regulatoryCard() {
    return Card(
      elevation: 0,
      color: const Color(0xFFEFF7F1),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Official regulatory baseline',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: darkGreen,
              ),
            ),
            SizedBox(height: 7),
            Text(
              'ADOSH-SF CoP 29.0 — Excavation Work • Version 4.1 • February 2026',
              style: TextStyle(
                fontSize: 14.8,
                height: 1.45,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 7),
            Text(
              'SafeNexus HSE is a learning and field-reference layer. Use the current official ADPHC publication as the controlling source for compliance decisions.',
              style: TextStyle(fontSize: 14.2, height: 1.45),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard(
    BuildContext context,
    int index,
    ExcavationGoldSection section,
  ) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AbuDhabiExcavationGoldSectionPage(
              section: section,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
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
                  '${index + 1}',
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
                        fontSize: 16.2,
                        fontWeight: FontWeight.w900,
                        color: darkGreen,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      section.introduction,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13.3,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: darkGreen),
            ],
          ),
        ),
      ),
    );
  }
}

class AbuDhabiExcavationGoldSectionPage extends StatelessWidget {
  final ExcavationGoldSection section;

  const AbuDhabiExcavationGoldSectionPage({
    super.key,
    required this.section,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    final point = section.point;

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
            color: const Color(0xFFEFF7F1),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SECTION ${section.number}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    section.title,
                    style: const TextStyle(
                      fontSize: 22,
                      height: 1.25,
                      fontWeight: FontWeight.w900,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    section.introduction,
                    style: const TextStyle(fontSize: 15, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _detailCard(Icons.menu_book_rounded, 'What this means', point.meaning),
          _detailCard(Icons.warning_amber_rounded, 'Hazards / Consequences', point.hazards),
          _detailCard(Icons.shield_outlined, 'Control Measures', point.controls),
          _detailCard(Icons.fact_check_outlined, 'HSE Officer Field Check', point.fieldCheck),
          _detailCard(Icons.error_outline_rounded, 'Common Mistake', point.commonMistake),
          _detailCard(Icons.task_alt_rounded, 'Corrective Action', point.action),
          _detailCard(Icons.folder_copy_outlined, 'Documents / Evidence', point.records),
        ],
      ),
    );
  }

  Widget _detailCard(IconData icon, String title, String text) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: primaryGreen, size: 23),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w900,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    text,
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
}

/// Existing generic Abu Dhabi CoP renderer. This remains available for the
/// wider registry so Step 5A does not disturb the other topics.
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
      _GenericGoldSection(
        'Overview',
        content.overview.isEmpty ? const <String>[] : <String>[content.overview],
      ),
      _GenericGoldSection('Deep Study', content.deepStudy),
      _GenericGoldSection('Micro-Detail', content.microDetails),
      _GenericGoldSection('Field Practical', content.fieldPractical),
      _GenericGoldSection('Inspection Checklist', content.inspectionChecklist),
      _GenericGoldSection('Emergency / Response', content.emergencyResponse),
      _GenericGoldSection('Records & Evidence', content.records),
    ];
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
          Card(
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
                      fontWeight: FontWeight.w900,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(topic.description, style: const TextStyle(fontSize: 15.2, height: 1.5)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          ..._sections.asMap().entries.map(
                (entry) => _genericSectionCard(context, entry.key + 1, entry.value),
              ),
        ],
      ),
    );
  }

  Widget _genericSectionCard(BuildContext context, int number, _GenericGoldSection section) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        leading: CircleAvatar(
          backgroundColor: primaryGreen.withValues(alpha: 0.12),
          child: Text('$number', style: const TextStyle(fontWeight: FontWeight.w900, color: darkGreen)),
        ),
        title: Text(section.title, style: const TextStyle(fontWeight: FontWeight.w900, color: darkGreen)),
        trailing: const Icon(Icons.chevron_right, color: darkGreen),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AbuDhabiGenericGoldSectionPage(topic: topic, section: section),
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
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          ...section.points.asMap().entries.map(
                (entry) => Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '${entry.key + 1}. ${entry.value}',
                      style: const TextStyle(fontSize: 15.2, height: 1.5),
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
