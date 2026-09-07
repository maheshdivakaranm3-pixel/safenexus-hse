import 'package:flutter/material.dart';

import 'models/reference_topic.dart';

class GuidelineDetailPage extends StatelessWidget {
  final ReferenceTopic topic;

  const GuidelineDetailPage({
    super.key,
    required this.topic,
  });

  // ============================================================
  // COLORS
  // ============================================================

  static const Color primaryGreen =
      Color(0xFF159447);

  static const Color darkGreen =
      Color(0xFF0B5D4B);

  static const Color pageBackground =
      Color(0xFFF6F8F7);

  // ============================================================
  // CATEGORY ICON
  // ============================================================

  IconData _categoryIcon() {
    switch (topic.category.trim().toLowerCase()) {
      case 'abu dhabi':
        return Icons.location_city;

      case 'dubai':
        return Icons.apartment;

      case 'uae':
      case 'uae general':
        return Icons.flag_outlined;

      default:
        return Icons.security_outlined;
    }
  }

  // ============================================================
  // CATEGORY LABEL
  // ============================================================

  String _categoryLabel() {
    switch (topic.guidelineCategory) {
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

  // ============================================================
  // SAFE LIST CHECK
  // ============================================================

  bool _hasItems(List<String> items) {
    return items.any(
      (item) => item.trim().isNotEmpty,
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final bottomSafeSpace =
        MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      backgroundColor: pageBackground,

      // ========================================================
      // COMPACT APP BAR
      // ========================================================

      appBar: AppBar(
        toolbarHeight: 48,
        elevation: 0,
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'Guideline Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: ListView(
        padding: EdgeInsets.fromLTRB(
          16,
          10,
          16,
          bottomSafeSpace + 32,
        ),
        children: [
          _buildTitleCard(),

          const SizedBox(height: 14),

          _buildOverviewCard(),

          if (_hasItems(topic.keyRequirements)) ...[
            const SizedBox(height: 14),
            _buildListCard(
              title: 'Key Requirements',
              icon: Icons.checklist_rounded,
              items: topic.keyRequirements,
            ),
          ],

          if (_hasItems(topic.safetyControls)) ...[
            const SizedBox(height: 14),
            _buildListCard(
              title: 'Safety Controls',
              icon: Icons.health_and_safety_outlined,
              items: topic.safetyControls,
            ),
          ],

          if (_hasItems(topic.responsibilities)) ...[
            const SizedBox(height: 14),
            _buildListCard(
              title: 'Responsibilities',
              icon: Icons.groups_outlined,
              items: topic.responsibilities,
            ),
          ],

          if (_hasItems(topic.references)) ...[
            const SizedBox(height: 14),
            _buildReferencesCard(),
          ],

          const SizedBox(height: 14),

          _buildProfessionalNote(),
        ],
      ),
    );
  }

  // ============================================================
  // TITLE CARD
  // ============================================================

  Widget _buildTitleCard() {
    return Card(
      elevation: 1.5,
      color: Colors.white,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: primaryGreen.withValues(
                      alpha: 0.10,
                    ),
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                  child: Icon(
                    _categoryIcon(),
                    color: primaryGreen,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        topic.title,
                        style: const TextStyle(
                          fontSize: 21,
                          height: 1.25,
                          fontWeight:
                              FontWeight.w800,
                          color: darkGreen,
                        ),
                      ),

                      if (topic.shortTitle
                          .trim()
                          .isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          topic.shortTitle,
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                Colors.grey.shade700,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              topic.description,
              style: TextStyle(
                fontSize: 14,
                height: 1.55,
                color: Colors.grey.shade800,
              ),
            ),

            const SizedBox(height: 16),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildTag(
                  _categoryLabel(),
                  primaryGreen,
                ),
                _buildTag(
                  topic.jurisdiction,
                  Colors.blueGrey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // OVERVIEW CARD
  // ============================================================

  Widget _buildOverviewCard() {
    return Card(
      elevation: 1.5,
      color: Colors.white,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              icon: Icons.info_outline_rounded,
              title: 'Reference Information',
            ),

            const SizedBox(height: 16),

            _buildInfoRow(
              icon: Icons.badge_outlined,
              label: 'Reference ID',
              value: topic.id,
            ),

            const SizedBox(height: 12),

            _buildInfoRow(
              icon: Icons.account_balance_outlined,
              label: 'Authority',
              value: topic.authority,
            ),

            const SizedBox(height: 12),

            _buildInfoRow(
              icon: Icons.location_on_outlined,
              label: 'Jurisdiction',
              value: topic.jurisdiction,
            ),

            const SizedBox(height: 12),

            _buildInfoRow(
              icon: Icons.category_outlined,
              label: 'Category',
              value: topic.category,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION HEADER
  // ============================================================

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
  }) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: primaryGreen.withValues(
              alpha: 0.10,
            ),
            borderRadius:
                BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: primaryGreen,
            size: 23,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: darkGreen,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // INFO ROW
  // ============================================================

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    final cleanValue = value.trim();

    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 21,
          color: primaryGreen,
        ),

        const SizedBox(width: 10),

        SizedBox(
          width: 92,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade700,
            ),
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Text(
            cleanValue.isEmpty
                ? 'Not specified'
                : cleanValue,
            style: const TextStyle(
              fontSize: 14,
              height: 1.35,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // LIST CARD
  // ============================================================

  Widget _buildListCard({
    required String title,
    required IconData icon,
    required List<String> items,
  }) {
    final visibleItems = items
        .where(
          (item) => item.trim().isNotEmpty,
        )
        .toList();

    return Card(
      elevation: 1.5,
      color: Colors.white,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              icon: icon,
              title: title,
            ),

            const SizedBox(height: 14),

            ...List.generate(
              visibleItems.length,
              (index) {
                return _buildBulletItem(
                  number: index + 1,
                  text: visibleItems[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BULLET ITEM
  // ============================================================

  Widget _buildBulletItem({
    required int number,
    required String text,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: pageBackground,
        borderRadius:
            BorderRadius.circular(14),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primaryGreen,
              borderRadius:
                  BorderRadius.circular(9),
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Text(
              text.trim(),
              style: const TextStyle(
                fontSize: 14,
                height: 1.45,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // REFERENCES CARD
  // ============================================================

  Widget _buildReferencesCard() {
    final visibleReferences = topic.references
        .where(
          (item) => item.trim().isNotEmpty,
        )
        .toList();

    return Card(
      elevation: 1.5,
      color: Colors.white,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              icon: Icons.menu_book_outlined,
              title: 'References',
            ),

            const SizedBox(height: 14),

            ...List.generate(
              visibleReferences.length,
              (index) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  padding:
                      const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(14),
                    border: Border.all(
                      color:
                          Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.link_rounded,
                        size: 20,
                        color: primaryGreen,
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          visibleReferences[index]
                              .trim(),
                          style:
                              const TextStyle(
                            fontSize: 13,
                            height: 1.45,
                            color:
                                Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // TAG
  // ============================================================

  Widget _buildTag(
    String text,
    Color color,
  ) {
    final cleanText = text.trim();

    if (cleanText.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      constraints:
          const BoxConstraints(
        maxWidth: 190,
      ),
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.09,
        ),
        borderRadius:
            BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(
            alpha: 0.18,
          ),
        ),
      ),
      child: Text(
        cleanText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  // ============================================================
  // PROFESSIONAL NOTE
  // ============================================================

  Widget _buildProfessionalNote() {
    return Card(
      elevation: 0,
      color: primaryGreen.withValues(
        alpha: 0.07,
      ),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(18),
        side: BorderSide(
          color: primaryGreen.withValues(
            alpha: 0.18,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.verified_outlined,
              color: primaryGreen,
              size: 25,
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                'Use this reference together with your organisation’s approved HSE procedures, risk assessments and applicable UAE requirements.',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.45,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
