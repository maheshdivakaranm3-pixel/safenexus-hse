import 'package:flutter/material.dart';

import 'abu_dhabi_gold_topic_router.dart';
import 'abu_dhabi_hse_topic_page.dart';
import 'data/abu_dhabi_hse_topics.dart';
import 'models/reference_topic.dart';

/// SafeNexus HSE
/// Abu Dhabi HSE — Gold Standard Root Navigation
///
/// Central navigation point for all Abu Dhabi HSE topics.
///
/// Navigation rule:
/// 1. Selected topic is sent to the Gold Standard router.
/// 2. If a dedicated Gold module exists, that module opens.
/// 3. If no dedicated Gold module exists, the legacy generic
///    Abu Dhabi topic page remains available as the fallback.
///
/// This keeps the Abu Dhabi registry intact while ensuring that
/// dedicated Gold Standard modules are never bypassed.
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
    // If this page is opened for one specific topic,
    // route that topic through the central Gold Standard router.
    if (topic != null) {
      return _openTopic(context, topic!);
    }

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text(
          'Abu Dhabi HSE',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          16,
          18,
          16,
          32,
        ),
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
            'Select an Abu Dhabi HSE topic to open its dedicated Gold Standard field reference where available.',
            style: TextStyle(
              fontSize: 15,
              height: 1.45,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 16),

          ...abuDhabiHseTopics.map(
            (item) => _topicCard(
              context,
              item,
            ),
          ),
        ],
      ),
    );
  }

  /// Central topic navigation.
  ///
  /// IMPORTANT:
  /// Do not directly open AbuDhabiHseTopicPage first.
  ///
  /// The Gold router must get the first opportunity to handle
  /// the selected topic.
  Widget _openTopic(
    BuildContext context,
    ReferenceTopic selectedTopic,
  ) {
    final Widget? goldPage =
        buildAbuDhabiGoldTopicPage(selectedTopic);

    if (goldPage != null) {
      return goldPage;
    }

    // Fallback only for topics that do not yet have
    // a dedicated Gold Standard module.
    return AbuDhabiHseTopicPage(
      topic: selectedTopic,
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
            SizedBox(height: 10),
            Text(
              'Central Abu Dhabi HSE navigation with dedicated Gold Standard modules for verified topics.',
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topicCard(
    BuildContext context,
    ReferenceTopic item,
  ) {
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
            backgroundColor:
                primaryGreen.withValues(alpha: 0.10),
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
          trailing: const Icon(
            Icons.chevron_right_rounded,
          ),
          onTap: () {
            final Widget? goldPage =
                buildAbuDhabiGoldTopicPage(item);

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  // Dedicated Gold Standard page.
                  if (goldPage != null) {
                    return goldPage;
                  }

                  // Generic fallback for topics that have
                  // no dedicated Gold module yet.
                  return AbuDhabiHseTopicPage(
                    topic: item,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
