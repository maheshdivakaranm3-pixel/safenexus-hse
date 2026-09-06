import 'package:flutter/material.dart';

/// ============================================================
/// REFERENCE TOPIC MODEL
/// ============================================================

enum GuidelineCategory {
  uaeGeneral,
  abuDhabi,
  dubai,
}

extension GuidelineCategoryExtension on GuidelineCategory {
  String get label {
    switch (this) {
      case GuidelineCategory.uaeGeneral:
        return 'UAE General';
      case GuidelineCategory.abuDhabi:
        return 'Abu Dhabi';
      case GuidelineCategory.dubai:
        return 'Dubai';
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

/// ============================================================
/// GUIDELINE DETAIL PAGE
/// ============================================================

class GuidelineDetailPage extends StatelessWidget {
  final ReferenceTopic topic;

  const GuidelineDetailPage({
    super.key,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: Text(
          topic.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            16,
            16,
            16,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroCard(),
              const SizedBox(height: 16),

              _officialReferenceCard(),

              _infoCard(
                icon: Icons.menu_book_rounded,
                title: 'What is it?',
                content: topic.overview,
              ),

              _infoCard(
                icon: Icons.warning_amber_rounded,
                title: 'Main Hazards',
                content: topic.hazards,
                bulletStyle: true,
              ),

              _infoCard(
                icon: Icons.shield_rounded,
                title: 'Risk Controls',
                content: topic.controls,
                bulletStyle: true,
              ),

              _infoCard(
                icon: Icons.assignment_rounded,
                title: 'Planning & Preparation',
                content: topic.planning,
              ),

              _infoCard(
                icon: Icons.engineering_rounded,
                title: 'Safe Work Practices',
                content: topic.safePractices,
              ),

              _infoCard(
                icon: Icons.health_and_safety_rounded,
                title: 'PPE',
                content: topic.ppe,
                bulletStyle: true,
              ),

              _checklistCard(),

              _infoCard(
                icon: Icons.search_rounded,
                title: 'Inspection Points',
                content: topic.inspection,
                bulletStyle: true,
              ),

              _doDontCard(
                title: 'Do',
                icon: Icons.check_circle_outline_rounded,
                content: topic.dos,
                isPositive: true,
              ),

              _doDontCard(
                title: 'Do Not',
                icon: Icons.cancel_outlined,
                content: topic.donts,
                isPositive: false,
              ),

              _stopWorkCard(),

              _infoCard(
                icon: Icons.emergency_rounded,
                title: 'Emergency Response',
                content: topic.emergency,
              ),

              _malayalamCard(),

              _referenceNote(),

              const SizedBox(height: 8),

              const Text(
                'SafeNexus HSE',
                style: TextStyle(
                  color: Color(0xFF159447),
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

  /// ==========================================================
  /// HERO CARD
  /// ==========================================================

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0B5D4B),
            Color(0xFF159447),
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
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: Color(0x22FFFFFF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shield_rounded,
                  color: Colors.white,
                  size: 30,
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
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      topic.sourceLabel,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            topic.shortDescription,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),

          const SizedBox(height: 14),

          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: [
              _heroChip(topic.category.label),
              if (topic.copNumber.isNotEmpty)
                _heroChip(topic.copNumber),
              if (topic.version.isNotEmpty)
                _heroChip('Version ${topic.version}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0x22FFFFFF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0x33FFFFFF),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  /// ==========================================================
  /// OFFICIAL REFERENCE
  /// ==========================================================

  Widget _officialReferenceCard() {
    final isAbuDhabi =
        topic.category == GuidelineCategory.abuDhabi;

    final isDubai =
        topic.category == GuidelineCategory.dubai;

    final String authority;

    if (isAbuDhabi) {
      authority = 'ADPHC – ADOSH-SF Codes of Practice';
    } else if (isDubai) {
      authority = 'Dubai Municipality – Construction Safety';
    } else {
      authority = 'UAE General HSE Reference';
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF8F4),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFCBE3D8),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.verified_rounded,
            color: Color(0xFF0B5D4B),
            size: 27,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reference Source',
                  style: TextStyle(
                    color: Color(0xFF0B5D4B),
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  authority,
                  style: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                if (topic.sourceLabel.isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Text(
                    topic.sourceLabel,
                    style: const TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 12,
                    ),
                  ),
                ],

                if (topic.copNumber.isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Text(
                    topic.copNumber,
                    style: const TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],

                if (topic.version.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Version: ${topic.version}',
                    style: const TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 12,
                    ),
                  ),
                ],

                if (topic.effectiveDate.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Effective / Reference Date: '
                    '${topic.effectiveDate}',
                    style: const TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 12,
                    ),
                  ),
                ],

                const SizedBox(height: 10),

                Text(
                  isAbuDhabi
                      ? 'Authority: Abu Dhabi Public Health Centre'
                      : isDubai
                          ? 'Authority: Dubai Municipality'
                          : 'Scope: UAE General Reference',
                  style: const TextStyle(
                    color: Color(0xFF0B5D4B),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ==========================================================
  /// INFORMATION CARD
  /// ==========================================================

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String content,
    bool bulletStyle = false,
  }) {
    if (content.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    final items =
        bulletStyle ? _splitBullets(content) : <String>[];

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
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF5F0),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF159447),
              size: 21,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                  ),
                ),

                const SizedBox(height: 9),

                if (bulletStyle)
                  ...items.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: 7,
                      ),
                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Icon(
                              Icons.circle,
                              size: 5,
                              color: Color(0xFF159447),
                            ),
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(
                                color: Color(0xFF666666),
                                fontSize: 12,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Text(
                    content,
                    style: const TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 12,
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

  /// ==========================================================
  /// CHECKLIST
  /// ==========================================================

  Widget _checklistCard() {
    if (topic.checklist.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    final items = _splitBullets(topic.checklist);

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.checklist_rounded,
                color: Color(0xFF159447),
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
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_box_outlined,
                    size: 19,
                    color: Color(0xFF159447),
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

  /// ==========================================================
  /// DO / DO NOT
  /// ==========================================================

  Widget _doDontCard({
    required String title,
    required IconData icon,
    required String content,
    required bool isPositive,
  }) {
    if (content.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    final color = isPositive
        ? const Color(0xFF159447)
        : const Color(0xFFD32F2F);

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
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  content,
                  style: const TextStyle(
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

  /// ==========================================================
  /// STOP WORK
  /// ==========================================================

  Widget _stopWorkCard() {
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
              crossAxisAlignment:
                  CrossAxisAlignment.start,
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
                Text(
                  topic.stopWork,
                  style: const TextStyle(
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

  /// ==========================================================
  /// MALAYALAM
  /// ==========================================================

  Widget _malayalamCard() {
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.translate_rounded,
            color: Color(0xFF8A6500),
            size: 25,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
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

  /// ==========================================================
  /// REFERENCE NOTE
  /// ==========================================================

  Widget _referenceNote() {
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
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: Color(0xFF0B5D4B),
            size: 24,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Important HSE Reference Note',
                  style: TextStyle(
                    color: Color(0xFF0B5D4B),
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'This Safety Guideline is provided for HSE '
                  'learning and practical workplace reference. '
                  'Always verify the latest official requirement, '
                  'applicable legislation, authority requirements, '
                  'project procedures, risk assessment, method '
                  'statement and permit requirements before making '
                  'a compliance decision.',
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

  /// ==========================================================
  /// BULLET SPLITTER
  /// ==========================================================

  List<String> _splitBullets(String value) {
    return value
        .split('•')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();
  }
}
