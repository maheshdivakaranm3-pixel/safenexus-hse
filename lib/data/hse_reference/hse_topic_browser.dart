import 'package:flutter/material.dart';

import 'hse_topics_01_25.dart';
import 'hse_topics_26_50.dart';

/// Continuous handbook list: Topics 01–50, without a section break at 25/26.
class HseTopicBrowserPage extends StatelessWidget {
  const HseTopicBrowserPage({super.key});

  static const List<HseTopic> _topics = <HseTopic>[
    ...hseTopics01To25,
    ...hseTopics26To50,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Specialist / Cross-Sector')),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
        itemCount: _topics.length,
        itemBuilder: (context, index) => _topicTile(context, _topics[index]),
      ),
    );
  }

  Widget _topicTile(BuildContext context, HseTopic topic) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(topic.number.toString().padLeft(2, '0')),
        ),
        title: Text(
          topic.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.chevron_right),
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
      ),
      body: SelectionArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                topic.title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                topic.content,
                style: const TextStyle(fontSize: 15, height: 1.55),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
