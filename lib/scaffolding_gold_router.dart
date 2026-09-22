
import 'package:flutter/material.dart';

import 'data/scaffolding_gold_standard_sections.dart';

/// SafeNexus HSE
/// Abu Dhabi Scaffolding Gold Standard router/page.
///
/// Designed to plug into the existing ReferenceTopic router.
///
/// If your project already contains a ReferenceTopic model, replace the
/// lightweight local adapter below with the existing model import/fields.

class ScaffoldingGoldBookPage extends StatelessWidget {
  final String topicTitle;

  const ScaffoldingGoldBookPage({
    super.key,
    this.topicTitle = 'Scaffolding',
  });

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Scaffolding — Abu Dhabi'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ABU DHABI HSE • GOLD STANDARD',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w900,
                      color: green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    topicTitle,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Complete field handbook',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'ADOSH-SF / ADPHC CoP 26.0 — Scaffolding, Version 4.1; '
                    'effective 27 February 2026.',
                    style: TextStyle(
                      fontSize: 14.5,
                      height: 1.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Use the applicable controlled CoP, approved design, '
                    'risk assessment, method statement, manufacturer '
                    'instructions and project requirements for actual work.',
                    style: TextStyle(
                      fontSize: 14.5,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            '${scaffoldingGoldStandardSections.length} structured chapters',
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w900,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Tap a chapter to open detailed field controls, checks and learning points.',
            style: TextStyle(fontSize: 14.5, height: 1.45),
          ),
          const SizedBox(height: 12),
          ...scaffoldingGoldStandardSections.asMap().entries.map(
                (entry) => _chapterCard(
                  context,
                  entry.key + 1,
                  entry.value,
                ),
              ),
        ],
      ),
    );
  }

  Widget _chapterCard(
    BuildContext context,
    int index,
    GoldSection section,
  ) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 9,
        ),
        leading: CircleAvatar(
          backgroundColor: green.withValues(alpha: 0.12),
          child: Text(
            '$index',
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: darkGreen,
            ),
          ),
        ),
        title: Text(
          '${section.number}  ${section.title}',
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            color: darkGreen,
          ),
        ),
        subtitle: Text(
          '${section.points.length} detailed field points • ${section.introduction}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: darkGreen,
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ScaffoldingChapterPage(
                section: section,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ScaffoldingChapterPage extends StatelessWidget {
  final GoldSection section;

  const ScaffoldingChapterPage({
    super.key,
    required this.section,
  });

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          section.title,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CHAPTER ${section.number}',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w900,
                      color: green,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    section.title,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    section.introduction,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.55,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...section.points.asMap().entries.map(
                (entry) => Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: green.withValues(alpha: 0.12),
                      child: Text(
                        '${entry.key + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: darkGreen,
                        ),
                      ),
                    ),
                    title: Text(
                      entry.value.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: darkGreen,
                      ),
                    ),
                    subtitle: Text(
                      _preview(entry.value),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: darkGreen,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ScaffoldingPointPage(
                            point: entry.value,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
        ],
      ),
    );
  }

  static String _preview(GoldFieldPoint point) {
    if (point.fields.isEmpty) {
      return 'Open detailed field explanation';
    }
    return point.fields.values.first;
  }
}

class ScaffoldingPointPage extends StatelessWidget {
  final GoldFieldPoint point;

  const ScaffoldingPointPage({
    super.key,
    required this.point,
  });

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          point.title,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'GOLD STANDARD FIELD EXPLANATION',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w900,
                      color: green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    point.title,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      color: darkGreen,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...point.fields.entries.map(
            (entry) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.shield_outlined,
                          color: green,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            entry.key,
                            style: const TextStyle(
                              fontSize: 16.5,
                              fontWeight: FontWeight.w900,
                              color: darkGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Text(
                      entry.value,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.55,
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
