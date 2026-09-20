import 'package:flutter/material.dart';

import 'models/reference_topic.dart';

/// Clean Gold-root landing page for Abu Dhabi topics that do not yet have
/// a dedicated Gold data module. This intentionally replaces the old
/// generic CoP renderer; it does not duplicate or fabricate regulatory text.
class AbuDhabiGoldRootPage extends StatelessWidget {
  final ReferenceTopic topic;

  const AbuDhabiGoldRootPage({
    super.key,
    required this.topic,
  });

  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: Text(topic.shortTitle, overflow: TextOverflow.ellipsis),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
        children: [
          Card(
            elevation: 0,
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
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Abu Dhabi HSE • Gold Standard Reference',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'This topic is now connected to the new Abu Dhabi Gold Standard root. A dedicated verified Gold content module is being added for this topic. The previous generic CoP content layer is no longer used at runtime.',
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
