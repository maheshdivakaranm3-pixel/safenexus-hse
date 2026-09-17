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
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 10),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Text(
                        '•',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: primaryGreen,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 15.5,
                          height: 1.45,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = abuDhabiHseTopicContent[topic.id];

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: Text(
          topic.shortTitle,
          overflow: TextOverflow.ellipsis,
        ),
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
                  Text(
                    topic.title,
                    style: const TextStyle(
                      fontSize: 21,
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
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _section(
            'Overview',
            [content?.overview.isNotEmpty == true
                ? content!.overview
                : topic.description],
          ),
          if (content != null) ...[
            _section('Deep Study', content.deepStudy),
            _section('Micro-Detail', content.microDetails),
            _section('Field Practical', content.fieldPractical),
            _section('Inspection Checklist', content.inspectionChecklist),
            _section('Emergency / Response', content.emergencyResponse),
            _section('Records & Evidence', content.records),
            _section('Interview Questions', content.interviewQuestions),
            _section('Regulatory Verification', content.regulatoryVerification),
          ] else ...[
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
