import 'package:flutter/material.dart';

import 'abu_dhabi_hse_topic_page.dart';
import 'data/abu_dhabi_hse_topics.dart';
import 'models/reference_topic.dart';

/// SafeNexus HSE — Abu Dhabi Gold Standard root.
///
/// This is the section-level entry point used from the main navigation.
/// A topic can also be supplied when this widget is used as the fallback
/// landing page for a non-dedicated Abu Dhabi topic.
class AbuDhabiGoldRootPage extends StatelessWidget {
  final ReferenceTopic? topic;

  const AbuDhabiGoldRootPage({
    super.key,
    this.topic,
  });

  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color primaryGreen = Color(0xFF159447);
  static const Color pageBackground = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    if (topic != null) {
      return _TopicGoldRoot(topic: topic!);
    }

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Abu Dhabi HSE'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 32),
        children: [
          _heroCard(),
          const SizedBox(height: 16),
          const Text(
            'Abu Dhabi HSE Reference',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Select an ADPHC Code of Practice topic to open its Gold Standard field reference.',
            style: TextStyle(fontSize: 15, height: 1.45),
          ),
          const SizedBox(height: 14),
          ...abuDhabiHseTopics.map(
            (item) => _topicCard(context, item),
          ),
        ],
      ),
    );
  }

  Widget _heroCard() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'ABU DHABI GOLD STANDARD',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.1,
                color: primaryGreen,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'UAE / Abu Dhabi HSE Field Reference',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w900,
                color: darkGreen,
              ),
            ),
            SizedBox(height: 9),
            Text(
              'Central Abu Dhabi topic navigation with dedicated Gold Standard modules where verified content is available.',
              style: TextStyle(fontSize: 15, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topicCard(BuildContext context, ReferenceTopic item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: CircleAvatar(
            backgroundColor: primaryGreen.withOpacity(.10),
            child: const Icon(
              Icons.menu_book_rounded,
              color: primaryGreen,
            ),
          ),
          title: Text(
            item.shortTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: darkGreen,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              item.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AbuDhabiHseTopicPage(topic: item),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TopicGoldRoot extends StatelessWidget {
  final ReferenceTopic topic;

  const _TopicGoldRoot({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AbuDhabiGoldRootPage.pageBackground,
      appBar: AppBar(
        title: Text(
          topic.shortTitle,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: AbuDhabiGoldRootPage.darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
        children: [
          Card(
            elevation: 0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    topic.title,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: AbuDhabiGoldRootPage.darkGreen,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Abu Dhabi HSE • Gold Standard Reference',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AbuDhabiGoldRootPage.darkGreen,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'This topic is connected to the Abu Dhabi Gold Standard routing layer. A dedicated verified Gold module opens automatically where one is available.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
