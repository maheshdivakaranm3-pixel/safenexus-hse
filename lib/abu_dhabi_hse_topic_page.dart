import 'package:flutter/material.dart';

import 'abu_dhabi_gold_topic_router.dart';
import 'models/reference_topic.dart';

/// Abu Dhabi HSE topic entry point.
///
/// The previous generic CoP content root has been removed from runtime.
/// Every Abu Dhabi topic now enters the central Gold router.
class AbuDhabiHseTopicPage extends StatelessWidget {
  final ReferenceTopic topic;

  const AbuDhabiHseTopicPage({
    super.key,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return buildAbuDhabiGoldTopicPage(topic);
  }
}
