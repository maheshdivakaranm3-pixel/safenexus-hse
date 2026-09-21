import 'package:flutter/material.dart';
import 'abu_dhabi_hse_topic_page.dart';
import 'models/reference_topic.dart';

/// SafeNexus HSE — Abu Dhabi Gold Topic Router.
/// Ensures all Abu Dhabi topic selections route to the new Gold Standard pages.
class AbuDhabiGoldTopicRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.arguments is ReferenceTopic) {
      final topic = settings.arguments as ReferenceTopic;
      return MaterialPageRoute(
        builder: (_) => AbuDhabiHseTopicPage(topic: topic),
      );
    }

    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Abu Dhabi HSE Gold Router'),
          backgroundColor: const Color(0xFF0B5D4B),
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Text(
            'Selected Abu Dhabi Gold topic not found.',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  /// Helper method to navigate directly to any Abu Dhabi Gold topic
  static void navigateToTopic(BuildContext context, ReferenceTopic topic) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AbuDhabiHseTopicPage(topic: topic),
      ),
    );
  }
}
