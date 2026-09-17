import 'package:flutter/material.dart';

import 'models/reference_topic.dart';
import 'data/abu_dhabi_hse_topic_content.dart';
import 'data/abu_dhabi_hse_topics.dart';

/// Common detail renderer for Abu Dhabi ADPHC CoP topics.
/// It intentionally accepts the project's existing ReferenceTopic model so
/// GuidelinesPage can pass its existing topic objects without type conflicts.
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
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: darkGreen)),
            const SizedBox(height: 10),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, color: primaryGreen)),
                  Expanded(child: Text(item)),
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
    final content = abuDhabiHseTopicContent[topic.id] ?? const AbuDhabiHseTopicContent();
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: Text(topic.shortTitle),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(topic.title, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: darkGreen)),
                  const SizedBox(height: 10),
                  Text(topic.description),
                  const SizedBox(height: 12),
                  Wrap(spacing: 8, runSpacing: 8, children: [
                    Chip(label: Text(topic.shortTitle)),
                    Chip(label: Text(topic.authority)),
                    Chip(label: Text(topic.jurisdiction)),
                  ]),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(16), child: Text(content.overview))),
          _section('Key Areas', content.keyAreas.isNotEmpty ? content.keyAreas : topic.keyRequirements),
          _section('Field Practical', content.fieldPractice.isNotEmpty ? content.fieldPractice : topic.safetyControls),
          _section('Responsibilities', topic.responsibilities),
          _section('Records & References', content.records.isNotEmpty ? content.records : topic.references),
          _section('Regulatory Verification', content.verificationNotes),
          Card(elevation: 0, child: Padding(
            padding: const EdgeInsets.all(16),
            child: SelectableText('Official source:\n$abuDhabiHseOfficialSource'),
          )),
        ],
      ),
    );
  }
}
