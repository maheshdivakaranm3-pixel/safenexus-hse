import 'package:flutter/material.dart';

import 'data/environmental/environmental_topic_document.dart';
import 'data/environmental/environmental_part1.dart';
import 'data/environmental/environmental_part2.dart';
import 'data/environmental/environmental_part3.dart';
import 'data/environmental/environmental_part4.dart';
import 'data/environmental/environmental_part5.dart';
import 'data/environmental/environmental_part6.dart';
import 'data/environmental/environmental_part7.dart';
import 'data/environmental/environmental_part8.dart';
import 'data/environmental/environmental_part9.dart';
import 'data/environmental/environmental_part10.dart';

class EnvironmentalReferencePage extends StatelessWidget {
  const EnvironmentalReferencePage({super.key});

  static const Color green = Color(0xFF0B5D4B);

  static const List<EnvironmentalTopicDocument> allTopics = [
    ...environmentalPart1,
    ...environmentalPart2,
    ...environmentalPart3,
    ...environmentalPart4,
    ...environmentalPart5,
    ...environmentalPart6,
    ...environmentalPart7,
    ...environmentalPart8,
    ...environmentalPart9,
    ...environmentalPart10,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        title: const Text('Environmental HSE Reference'),
        backgroundColor: green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [green, Color(0xFF16865F)],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.eco, color: Colors.white, size: 32),
                SizedBox(height: 10),
                Text(
                  'Environmental Protection & Compliance',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Field handbook for environmental planning, pollution prevention, waste control, monitoring and records.',
                  style: TextStyle(color: Colors.white, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'ALL ENVIRONMENTAL TOPICS (${allTopics.length})',
            style: const TextStyle(
              color: green,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          ...allTopics.map((topic) => _tile(context, topic)),
          const SizedBox(height: 12),
          const Text(
            'Training reference only. Confirm applicable UAE/emirate authority '
            'requirements, permits, project EMP and approved plans. Legal limits '
            'and retention periods require current official verification.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(BuildContext context, EnvironmentalTopicDocument topic) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFE1EAE6)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE1F2E9),
          foregroundColor: green,
          child: Text(
            topic.number.toString().padLeft(2, '0'),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          topic.title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF17324D),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            topic.purpose,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: green),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => EnvironmentalTopicPage(topic: topic),
          ),
        ),
      ),
    );
  }
}

class EnvironmentalTopicPage extends StatelessWidget {
  const EnvironmentalTopicPage({super.key, required this.topic});

  final EnvironmentalTopicDocument topic;
  static const Color green = Color(0xFF0B5D4B);

  @override
  Widget build(BuildContext context) {
    final sections = <MapEntry<String, String>>[
      MapEntry('What is this topic?', topic.definition),
      MapEntry('Purpose & Objectives', topic.purpose),
      MapEntry('UAE / Emirate Regulatory Basis', topic.regulatoryBasis),
      MapEntry('Step-by-Step Procedure / Field Method', topic.procedure),
      MapEntry('Office Documents & Records', topic.documents),
      MapEntry('Document Ownership & Control', topic.documentOwnership),
      MapEntry('Site Verification', topic.verification),
      MapEntry('Common Errors', topic.commonErrors),
      MapEntry('Practical Field Example', topic.fieldExample),
      MapEntry('Field Checklist', topic.checklist),
      MapEntry('Supervisor Interview Preparation', topic.interview),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        title: Text('ENV-${topic.number.toString().padLeft(2, '0')}'),
        backgroundColor: green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          Text(
            topic.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF17324D),
            ),
          ),
          const SizedBox(height: 12),
          ...sections.map(
            (section) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: Color(0xFFE1EAE6)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section.key,
                      style: const TextStyle(
                        color: green,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      section.value,
                      style: const TextStyle(height: 1.5, fontSize: 14),
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
