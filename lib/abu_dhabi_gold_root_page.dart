import 'package:flutter/material.dart';

import 'abu_dhabi_gold_topic_router.dart';
import 'abu_dhabi_hse_topic_page.dart';
import 'data/abu_dhabi_hse_topics.dart';
import 'models/reference_topic.dart';

/// SafeNexus HSE — Abu Dhabi HSE Gold Standard root navigation.
///
/// Dedicated Gold modules are always given first priority. Topics without
/// a dedicated module use the existing Abu Dhabi generic reference page.
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
      return _topicPage(topic!);
    }

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text(
          'Abu Dhabi HSE',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 32),
        children: [
          _heroCard(),
          const SizedBox(height: 18),
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
            'Select an Abu Dhabi HSE topic. Dedicated Gold Standard modules are opened directly from the central Gold router.',
            style: TextStyle(fontSize: 15, height: 1.45),
          ),
          const SizedBox(height: 16),
          ...abuDhabiHseTopics.map((item) => _topicCard(context, item)),
        ],
      ),
    );
  }

  Widget _topicPage(ReferenceTopic selectedTopic) {
    final goldPage = buildAbuDhabiGoldTopicPage(selectedTopic);
    if (goldPage != null) return goldPage;

    return AbuDhabiHseTopicPage(topic: selectedTopic);
  }

  Widget _heroCard() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            SizedBox(height: 10),
            Text(
              'Professional field reference with dedicated Abu Dhabi Gold Standard modules.',
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: CircleAvatar(
            backgroundColor: primaryGreen.withValues(alpha: 0.10),
            child: const Icon(Icons.menu_book_rounded, color: primaryGreen),
          ),
          title: Text(
            item.shortTitle,
            style: const TextStyle(fontWeight: FontWeight.w900, color: darkGreen),
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
              MaterialPageRoute(builder: (_) => _topicPage(item)),
            );
          },
        ),
      ),
    );
  }
}
