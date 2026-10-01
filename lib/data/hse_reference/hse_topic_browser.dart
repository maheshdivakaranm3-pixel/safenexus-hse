import 'package:flutter/material.dart';

import 'hse_topics_01_25.dart';
import 'hse_topics_26_50.dart';

/// Continuous 01–50 handbook list with icon tiles and a green app bar.
class HseTopicBrowserPage extends StatelessWidget {
  const HseTopicBrowserPage({super.key});

  static const List<HseTopic> _topics = <HseTopic>[
    ...hseTopics01To25,
    ...hseTopics26To50,
  ];

  static const Color _green = Color(0xFF075B45);

  static const List<IconData> _topicIcons = <IconData>[
    Icons.account_tree_rounded,
    Icons.gavel_rounded,
    Icons.warning_amber_rounded,
    Icons.assignment_turned_in_rounded,
    Icons.lock_rounded,
    Icons.height_rounded,
    Icons.science_rounded,
    Icons.precision_manufacturing_rounded,
    Icons.air_rounded,
    Icons.construction_rounded,
    Icons.electrical_services_rounded,
    Icons.local_fire_department_rounded,
    Icons.health_and_safety_rounded,
    Icons.factory_rounded,
    Icons.water_drop_rounded,
    Icons.eco_rounded,
    Icons.medical_services_rounded,
    Icons.groups_rounded,
    Icons.emergency_rounded,
    Icons.engineering_rounded,
    Icons.checklist_rounded,
    Icons.security_rounded,
    Icons.school_rounded,
    Icons.inventory_2_rounded,
    Icons.menu_book_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Specialist / Cross-Sector'),
        backgroundColor: _green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
        itemCount: _topics.length,
        itemBuilder: (context, index) => _topicTile(context, _topics[index]),
      ),
    );
  }

  Widget _topicTile(BuildContext context, HseTopic topic) {
    final iconIndex = (topic.number - 1) % _topicIcons.length;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: Colors.white,
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        minVerticalPadding: 16,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: const Color(0xFFE3F3EA),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(_topicIcons[iconIndex], color: _green, size: 29),
        ),
        title: Text(
          topic.title,
          style: const TextStyle(fontWeight: FontWeight.w600, height: 1.25),
        ),
        trailing: const Icon(Icons.chevron_right_rounded, color: _green),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => _HseTopicDetailPage(topic: topic),
          ),
        ),
      ),
    );
  }
}

class _HseTopicDetailPage extends StatelessWidget {
  const _HseTopicDetailPage({required this.topic});

  final HseTopic topic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Topic ${topic.number.toString().padLeft(2, '0')}'),
        backgroundColor: const Color(0xFF075B45),
        foregroundColor: Colors.white,
      ),
      body: SelectionArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                topic.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Text(topic.content,
                  style: const TextStyle(fontSize: 15, height: 1.55)),
            ],
          ),
        ),
      ),
    );
  }
}
