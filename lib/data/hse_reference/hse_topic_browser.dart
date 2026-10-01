import 'package:flutter/material.dart';

import 'hse_topics_01_25.dart';
import 'hse_topics_26_50.dart';

/// Public topic browser shared by the Home HSE Reference cards and Guidelines.
class HseTopicBrowserPage extends StatelessWidget {
  const HseTopicBrowserPage({super.key});

  static const List<HseTopic> _topics = <HseTopic>[
    ...hseTopics01To25,
    ...hseTopics26To50,
  ];

  @override
  Widget build(BuildContext context) {
    final first = _topics.where((topic) => topic.number <= 25).toList();
    final second = _topics.where((topic) => topic.number >= 26).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Specialist / Cross-Sector • Topics 01–50')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
        children: [
          _rangeHeader(context, 'Topics 01–25', 'Core and specialist handbook topics'),
          ...first.map((topic) => _topicTile(context, topic)),
          const SizedBox(height: 18),
          _rangeHeader(context, 'Topics 26–50', 'Specialist / Cross-Sector continuation'),
          ...second.map((topic) => _topicTile(context, topic)),
        ],
      ),
    );
  }

  Widget _rangeHeader(BuildContext context, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 12, 4, 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800, color: const Color(0xFF123047))),
        const SizedBox(height: 3),
        Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
      ]),
    );
  }

  Widget _topicTile(BuildContext context, HseTopic topic) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(child: Text(topic.number.toString().padLeft(2, '0'))),
        title: Text(topic.title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (_) => _HseTopicDetailPage(topic: topic),
        )),
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
      appBar: AppBar(title: Text('Topic ${topic.number.toString().padLeft(2, '0')}')),
      body: SelectionArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(topic.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(topic.content, style: const TextStyle(fontSize: 15, height: 1.55)),
          ]),
        ),
      ),
    );
  }
}
