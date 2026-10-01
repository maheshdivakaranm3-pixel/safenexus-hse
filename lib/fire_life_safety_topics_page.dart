import 'package:flutter/material.dart';

import 'data/fire_life_safety/fire_science_prevention.dart';
import 'data/fire_life_safety/fire_science_prevention_11_20.dart';
import 'data/fire_life_safety/fire_science_prevention_21_30.dart';
import 'data/fire_life_safety/fire_science_prevention_31_40.dart';

class FireLifeSafetyTopicsPage extends StatelessWidget {
  const FireLifeSafetyTopicsPage({super.key});

  static const Color _green = Color(0xFF0B5D4B);

  @override
  Widget build(BuildContext context) {
    final topics = <FireSafetyTopic>[
      ...FireSciencePreventionTopics.topics,
      ...FireSciencePreventionTopics11To20.topics,
      ...FireSciencePreventionTopics21To30.topics,
      ...FireSciencePreventionTopics31To40.topics,
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: const Text('Fire & Life Safety'),
        backgroundColor: _green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          const SizedBox(height: 16),

          ...topics.map(
            (topic) => Padding(
              padding: const EdgeInsets.only(bottom: 11),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) =>
                          FireSafetyTopicDetailPage(topic: topic),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: topic.accent.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Icon(
                            topic.icon,
                            color: topic.accent,
                            size: 25,
                          ),
                        ),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                topic.title,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                topic.subtitle,
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: _green,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FireSafetyTopicDetailPage extends StatelessWidget {
  const FireSafetyTopicDetailPage({
    super.key,
    required this.topic,
  });

  final FireSafetyTopic topic;

  static const Color _green = Color(0xFF0B5D4B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: Text(topic.title),
        backgroundColor: _green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        children: [
          _section('Overview', [topic.overview]),
          ...topic.sections.map(
            (section) => _section(
              section.heading,
              section.points,
            ),
          ),
          _section(
            'Field Checklist',
            topic.checklist,
            checklist: true,
          ),
          _section(
            'Required Documents',
            topic.requiredDocuments,
          ),
          _section(
            'Interview Questions & Answers',
            topic.interviewQuestions
                .map(
                  (item) => '${item.question}\n${item.answer}',
                )
                .toList(),
          ),
          _section(
            'References',
            topic.references,
          ),
        ],
      ),
    );
  }

  Widget _section(
    String title,
    List<String> items, {
    bool checklist = false,
  }) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _green,
              ),
            ),
            const SizedBox(height: 9),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      checklist
                          ? Icons.check_box_outlined
                          : Icons.circle,
                      size: checklist ? 19 : 7,
                      color: _green,
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(height: 1.4),
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
}
