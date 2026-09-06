import 'package:flutter/material.dart';

enum GuidelineCategory {
  all,
  uaeGeneral,
  abuDhabi,
  dubai,
}

extension GuidelineCategoryExtension on GuidelineCategory {
  String get label {
    switch (this) {
      case GuidelineCategory.all:
        return 'All';
      case GuidelineCategory.uaeGeneral:
        return 'UAE General';
      case GuidelineCategory.abuDhabi:
        return 'Abu Dhabi';
      case GuidelineCategory.dubai:
        return 'Dubai';
    }
  }

  Color get color {
    switch (this) {
      case GuidelineCategory.all:
        return const Color(0xFF159447);
      case GuidelineCategory.uaeGeneral:
        return const Color(0xFF0B5D4B);
      case GuidelineCategory.abuDhabi:
        return const Color(0xFF1565C0);
      case GuidelineCategory.dubai:
        return const Color(0xFF8E24AA);
    }
  }

  IconData get icon {
    switch (this) {
      case GuidelineCategory.all:
        return Icons.apps_rounded;
      case GuidelineCategory.uaeGeneral:
        return Icons.public_rounded;
      case GuidelineCategory.abuDhabi:
        return Icons.location_city_rounded;
      case GuidelineCategory.dubai:
        return Icons.apartment_rounded;
    }
  }
}

class ReferenceTopic {
  final String title;
  final GuidelineCategory category;
  final String sourceLabel;
  final String copNumber;
  final String version;
  final String effectiveDate;

  final String shortDescription;
  final String overview;
  final String hazards;
  final String controls;
  final String planning;
  final String safePractices;
  final String ppe;
  final String checklist;
  final String inspection;
  final String dos;
  final String donts;
  final String stopWork;
  final String emergency;
  final String malayalam;

  const ReferenceTopic({
    required this.title,
    required this.category,
    required this.sourceLabel,
    required this.copNumber,
    required this.version,
    required this.effectiveDate,
    required this.shortDescription,
    required this.overview,
    required this.hazards,
    required this.controls,
    required this.planning,
    required this.safePractices,
    required this.ppe,
    required this.checklist,
    required this.inspection,
    required this.dos,
    required this.donts,
    required this.stopWork,
    required this.emergency,
    required this.malayalam,
  });
}

class GuidelineDetailPage extends StatelessWidget {
  final ReferenceTopic topic;

  const GuidelineDetailPage({
    super.key,
    required this.topic,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        titleSpacing: 16,
        title: Text(
          topic.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 17,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroCard(),
              const SizedBox(height: 14),
              _buildReferenceCard(),
              _buildInfoCard(
                icon: Icons.menu_book_rounded,
                title: 'What is it?',
                content: topic.overview,
              ),
              _buildInfoCard(
                icon: Icons.warning_amber_rounded,
                title: 'Main Hazards',
                content: topic.hazards,
                bullets: true,
              ),
              _buildInfoCard(
                icon: Icons.shield_rounded,
                title: 'Risk Controls',
                content: topic.controls,
                bullets: true,
              ),
              _buildInfoCard(
                icon: Icons.assignment_rounded,
                title: 'Planning & Preparation',
                content: topic.planning,
              ),
              _buildInfoCard(
                icon: Icons.engineering_rounded,
                title: 'Safe Work Practices',
                content: topic.safePractices,
              ),
              _buildInfoCard(
                icon: Icons.health_and_safety_rounded,
                title: 'PPE',
                content: topic.ppe,
                bullets: true,
              ),
              _buildChecklistCard(),
              _buildInfoCard(
                icon: Icons.search_rounded,
                title: 'Inspection Points',
                content: topic.inspection,
                bullets: true,
              ),
              _buildDoDontCard(
                title: 'Do',
                icon: Icons.check_circle_outline_rounded,
                content: topic.dos,
                positive: true,
              ),
              _buildDoDontCard(
                title: 'Do Not',
                icon: Icons.cancel_outlined,
                content: topic.donts,
                positive: false,
              ),
              _buildStopWorkCard(),
              _buildInfoCard(
                icon: Icons.emergency_rounded,
                title: 'Emergency Response',
                content: topic.emergency,
              ),
              _buildMalayalamCard(),
              _buildReferenceNote(),
              const SizedBox(height: 8),
              const Text(
                'SafeNexus HSE',
                style: TextStyle(
                  color: primaryGreen,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'UAE HSE Safety Learning & Reference',
                style: TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [
            darkGreen,
            primaryGreen,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 14,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: const BoxDecoration(
                  color: Color(0x22FFFFFF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shield_rounded,
                  color: Colors.white,
                  size: 31,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        height: 1.2,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        topic.category.label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            topic.sourceLabel,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            topic.shortDescription,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferenceCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.verified_outlined,
                color: darkGreen,
                size: 23,
              ),
              SizedBox(width: 10),
              Text(
                'Reference Information',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _referenceRow('Category', topic.category.label),
          _referenceRow('Source', topic.sourceLabel),
          _referenceRow('CoP / Reference', topic.copNumber),
          _referenceRow('Version', topic.version),
          _referenceRow('Effective Date', topic.effectiveDate),
        ],
      ),
    );
  }

  Widget _referenceRow(String label, String value) {
    if (value.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 125,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF777777),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    bool bullets = false,
  }) {
    if (content.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: primaryGreen,
                size: 24,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (bullets)
            _bulletText(content)
          else
            Text(
              content,
              style: const TextStyle(
                color: Color(0xFF555555),
                fontSize: 12.5,
                height: 1.55,
              ),
            ),
        ],
      ),
    );
  }

  Widget _bulletText(String text) {
    final items = _splitLines(text);

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 9),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(
                  Icons.circle,
                  size: 6,
                  color: primaryGreen,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  item,
                  style: const TextStyle(
                    color: Color(0xFF555555),
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  List<String> _splitLines(String text) {
    return text
        .split('\n')
        .map((item) {
          var value = item.trim();

          if (value.startsWith('•')) {
            value = value.substring(1).trim();
          }

          if (value.startsWith('-')) {
            value = value.substring(1).trim();
          }

          if (RegExp(r'^\d+[\.\)]').hasMatch(value)) {
            value = value.replaceFirst(
              RegExp(r'^\d+[\.\)]\s*'),
              '',
            );
          }

          return value;
        })
        .where((item) => item.isNotEmpty)
        .toList();
  }

  Widget _buildChecklistCard() {
    if (topic.checklist.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    final items = _splitLines(topic.checklist);

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.checklist_rounded,
                color: primaryGreen,
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'HSE Checklist',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_box_outlined,
                    size: 19,
                    color: primaryGreen,
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Color(0xFF555555),
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoDontCard({
    required String title,
    required IconData icon,
    required String content,
    required bool positive,
  }) {
    if (content.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    final color = positive
        ? const Color(0xFF159447)
        : const Color(0xFFD32F2F);

    final background = positive
        ? const Color(0xFFF3FBF6)
        : const Color(0xFFFFF5F5);

    final border = positive
        ? const Color(0xFFD5ECDD)
        : const Color(0xFFF0D0D0);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: 25,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
                const SizedBox(height: 7),
                _bulletTextColored(
                  content,
                  color,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bulletTextColored(String text, Color color) {
    final items = _splitLines(text);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 7),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Icon(
                  Icons.circle,
                  size: 5,
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item,
                  style: const TextStyle(
                    color: Color(0xFF555555),
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStopWorkCard() {
    if (topic.stopWork.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F8),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFF0CACA),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.pan_tool_alt_rounded,
            color: Color(0xFFD32F2F),
            size: 25,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'When to Stop Work',
                  style: TextStyle(
                    color: Color(0xFFD32F2F),
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                _bulletTextColored(
                  topic.stopWork,
                  const Color(0xFFD32F2F),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMalayalamCard() {
    if (topic.malayalam.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF2),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFE9DDBD),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.translate_rounded,
            color: Color(0xFF8A6500),
            size: 25,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Malayalam – പ്രധാന സുരക്ഷാ നിർദ്ദേശങ്ങൾ',
                  style: TextStyle(
                    color: Color(0xFF765800),
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  topic.malayalam,
                  style: const TextStyle(
                    color: Color(0xFF665A42),
                    fontSize: 12.5,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferenceNote() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F7F5),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFD7E8E1),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: darkGreen,
            size: 24,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Important HSE Reference Note',
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'This Safety Guideline is provided for HSE learning and practical workplace reference. Always verify the latest official requirement, applicable legislation, authority requirements, project procedures, risk assessment, method statement and permit requirements before making a compliance decision.',
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: child,
    );
  }
}
