import 'package:flutter/material.dart';

import 'models/reference_topic.dart';
import 'data/abu_dhabi_hse_topic_profiles.dart';

class AbuDhabiHseTopicPage extends StatelessWidget {
  final ReferenceTopic topic;

  const AbuDhabiHseTopicPage({
    super.key,
    required this.topic,
  });

  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color primaryGreen = Color(0xFF159447);
  static const Color pageBackground = Color(0xFFF5F8F6);

  @override
  Widget build(BuildContext context) {
    final profile = abuDhabiHseTopicProfiles[topic.id];

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          topic.shortTitle.isEmpty ? topic.title : topic.shortTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        child: profile == null
            ? _FallbackTopic(topic: topic)
            : ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                children: [
                  _TopicHeader(
                    topic: topic,
                    profile: profile,
                  ),
                  const SizedBox(height: 14),

                  ...profile.sections.asMap().entries.map(
                    (entry) => _TopicSection(
                      number: entry.key + 1,
                      text: entry.value,
                    ),
                  ),

                  const SizedBox(height: 4),

                  _RegulatorySourceCard(
                    profile: profile,
                  ),
                ],
              ),
      ),
    );
  }
}

class _TopicHeader extends StatelessWidget {
  final ReferenceTopic topic;
  final AbuDhabiHseTopicProfile profile;

  const _TopicHeader({
    required this.topic,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_city_outlined,
                  color: AbuDhabiHseTopicPage.primaryGreen,
                  size: 28,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    topic.title,
                    style: const TextStyle(
                      color: AbuDhabiHseTopicPage.darkGreen,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              topic.description,
              style: const TextStyle(
                fontSize: 14.5,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _InfoChip(profile.cop),
                _InfoChip(profile.version),
                _InfoChip(profile.effectiveDate),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TopicSection extends StatelessWidget {
  final int number;
  final String text;

  const _TopicSection({
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.7,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor:
                  AbuDhabiHseTopicPage.primaryGreen.withValues(
                alpha: 0.10,
              ),
              child: Text(
                '$number',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: AbuDhabiHseTopicPage.darkGreen,
                ),
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String text;

  const _InfoChip(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AbuDhabiHseTopicPage.primaryGreen.withValues(
          alpha: 0.09,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AbuDhabiHseTopicPage.darkGreen,
          fontSize: 11.5,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _RegulatorySourceCard extends StatelessWidget {
  final AbuDhabiHseTopicProfile profile;

  const _RegulatorySourceCard({
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFEAF5EE),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.verified_outlined,
              color: AbuDhabiHseTopicPage.darkGreen,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Regulatory source: ${profile.cop}, '
                '${profile.version}, ${profile.effectiveDate}. '
                'Always verify the current official CoP and '
                'project-specific requirements before relying on '
                'a regulatory control.',
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FallbackTopic extends StatelessWidget {
  final ReferenceTopic topic;

  const _FallbackTopic({
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic.title,
                  style: const TextStyle(
                    color: AbuDhabiHseTopicPage.darkGreen,
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  topic.description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'This Abu Dhabi topic is connected to the common '
                  'HSE detail engine. Its verified regulatory profile '
                  'will be added before the topic is considered complete.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
