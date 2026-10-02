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
import 'environmental_documents/environmental_office_documents_page.dart';
import 'environmental_documents/environmental_checklist_page.dart';

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
      backgroundColor: const Color(0xFFF4F8F6),
      appBar: AppBar(
        title: const Text('Environmental HSE Reference'),
        backgroundColor: green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 24),
        children: [
          Row(
            children: [
              Expanded(
                child: _QuickAction(
                  icon: Icons.folder_copy_outlined,
                  label: 'Office Documents',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) => const EnvironmentalOfficeDocumentsPage(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _QuickAction(
                  icon: Icons.fact_check_outlined,
                  label: 'Checklists',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) => const EnvironmentalChecklistPage(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ...allTopics.map((topic) => _TopicTile(topic: topic)),
          const SizedBox(height: 12),
          const Text(
            'Reference use: verify current UAE federal and emirate requirements, '
            'permit/NOC conditions, approved EMP and project procedures. Do not '
            'treat generic guidance as a site-specific legal limit.',
            style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFDCE8E2)),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Icon(icon, color: const Color(0xFF0B5D4B), size: 26),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF173B31),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopicTile extends StatelessWidget {
  const _TopicTile({required this.topic});

  final EnvironmentalTopicDocument topic;

  static const Color green = Color(0xFF0B5D4B);

  IconData get _topicIcon {
    final text = '${topic.title} ${topic.purpose}'.toLowerCase();
    if (text.contains('waste') || text.contains('recycl')) {
      return Icons.recycling_rounded;
    }
    if (text.contains('water') || text.contains('groundwater')) {
      return Icons.water_drop_rounded;
    }
    if (text.contains('air') || text.contains('emission') || text.contains('dust')) {
      return Icons.air_rounded;
    }
    if (text.contains('noise') || text.contains('vibration')) {
      return Icons.volume_up_rounded;
    }
    if (text.contains('spill') || text.contains('chemical') || text.contains('fuel')) {
      return Icons.science_rounded;
    }
    if (text.contains('emergency') || text.contains('incident')) {
      return Icons.emergency_rounded;
    }
    if (text.contains('audit') || text.contains('document') || text.contains('record')) {
      return Icons.folder_open_rounded;
    }
    if (text.contains('training') || text.contains('competence')) {
      return Icons.school_rounded;
    }
    if (text.contains('wildlife') || text.contains('biodiversity') || text.contains('habitat')) {
      return Icons.nature_rounded;
    }
    if (text.contains('soil') || text.contains('land') || text.contains('excavat')) {
      return Icons.terrain_rounded;
    }
    return Icons.eco_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Color(0xFFE0EAE5)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        leading: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFFE5F3EC),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(_topicIcon, color: green, size: 25),
        ),
        title: Text(
          topic.title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
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
      MapEntry('01 • What is this topic?', topic.definition),
      MapEntry('02 • Purpose & Objectives', topic.purpose),
      MapEntry('03 • UAE / Emirate Regulatory Basis', topic.regulatoryBasis),
      MapEntry('04 • Procedure / Field Method', topic.procedure),
      MapEntry('05 • Office Documents & Records', topic.documents),
      MapEntry('06 • Document Ownership & Control', topic.documentOwnership),
      MapEntry('07 • Site Verification', topic.verification),
      MapEntry('08 • Common Errors', topic.commonErrors),
      MapEntry('09 • Practical Field Example', topic.fieldExample),
      MapEntry('10 • Field Checklist', topic.checklist),
      MapEntry('11 • Interview Preparation', topic.interview),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F6),
      appBar: AppBar(
        title: Text('ENV-${topic.number.toString().padLeft(2, '0')}'),
        backgroundColor: green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: green,
                foregroundColor: Colors.white,
                child: Text(
                  topic.number.toString().padLeft(2, '0'),
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.eco_rounded, color: green, size: 32),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  topic.title,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF17324D),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...sections.map(
            (section) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Color(0xFFE0EAE5)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section.key,
                      style: const TextStyle(
                        color: green,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 9),
                    SelectableText(
                      section.value,
                      style: const TextStyle(
                        height: 1.55,
                        fontSize: 14,
                        color: Color(0xFF263B35),
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
