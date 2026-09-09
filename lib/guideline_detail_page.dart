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

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D3B);
  static const Color pageBackground = Color(0xFFF5F7FA);
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF374151);
  static const Color lightGreen = Color(0xFFE8F5EE);

  // ============================================================
  // SAFE TEXT
  // ============================================================

  String _clean(String value, String fallback) {
    final text = value.trim();
    return text.isEmpty ? fallback : text;
  }

  @override
  Widget build(BuildContext context) {
    final title = _clean(
      topic.title,
      'HSE Safety Guideline',
    );

    final shortTitle = _clean(
      topic.shortTitle,
      title,
    );

    final category = _clean(
      topic.category,
      'HSE Reference',
    );

    final authority = _clean(
      topic.authority,
      'Not specified',
    );

    final jurisdiction = _clean(
      topic.jurisdiction,
      'UAE',
    );

    final description = _clean(
      topic.description,
      'No overview information is available for this topic.',
    );

    return Scaffold(
      backgroundColor: pageBackground,

      // ==========================================================
      // APP BAR
      // ==========================================================

      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
        titleSpacing: 0,
        title: Text(
          shortTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      // ==========================================================
      // BODY
      // ==========================================================

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            16,
            16,
            16,
            32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ====================================================
              // HEADER CARD
              // ====================================================

              _buildHeaderCard(
                title: title,
                shortTitle: shortTitle,
                category: category,
              ),

              const SizedBox(height: 16),

              // ====================================================
              // AUTHORITY / JURISDICTION
              // ====================================================

              _InfoCard(
                title: 'Authority & Jurisdiction',
                icon: Icons.account_balance_outlined,
                children: [
                  _InfoRow(
                    label: 'Authority',
                    value: authority,
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
                    label: 'Jurisdiction',
                    value: jurisdiction,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ====================================================
              // OVERVIEW
              // ====================================================

              _SectionCard(
                title: 'Overview',
                icon: Icons.info_outline_rounded,
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.55,
                    color: textSecondary,
                  ),
                ),
              ),

              // ====================================================
              // KEY REQUIREMENTS
              // ====================================================

              if (topic.keyRequirements.isNotEmpty) ...[
                const SizedBox(height: 16),
                _ListSectionCard(
                  title: 'Key Requirements',
                  icon: Icons.checklist_outlined,
                  items: topic.keyRequirements,
                ),
              ],

              // ====================================================
              // SAFETY CONTROLS
              // ====================================================

              if (topic.safetyControls.isNotEmpty) ...[
                const SizedBox(height: 16),
                _ListSectionCard(
                  title: 'Safety Controls',
                  icon: Icons.health_and_safety_outlined,
                  items: topic.safetyControls,
                ),
              ],

              // ====================================================
              // RESPONSIBILITIES
              // ====================================================

              if (topic.responsibilities.isNotEmpty) ...[
                const SizedBox(height: 16),
                _ListSectionCard(
                  title: 'Responsibilities',
                  icon: Icons.groups_outlined,
                  items: topic.responsibilities,
                ),
              ],

              // ====================================================
              // REFERENCES
              // ====================================================

              if (topic.references.isNotEmpty) ...[
                const SizedBox(height: 16),
                _ReferenceSection(
                  references: topic.references,
                ),
              ],

              const SizedBox(height: 20),

              // ====================================================
              // DISCLAIMER
              // ====================================================

              _buildDisclaimer(),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HEADER CARD
  // ============================================================

  Widget _buildHeaderCard({
    required String title,
    required String shortTitle,
    required String category,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            darkGreen,
            Color(0xFF087F5B),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.10,
            ),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CATEGORY

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(
                alpha: 0.16,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              category,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // TITLE

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              height: 1.25,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 8),

          // SHORT TITLE

          if (shortTitle != title)
            Text(
              shortTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withValues(
                  alpha: 0.90,
                ),
                fontSize: 14.5,
                height: 1.35,
                fontWeight: FontWeight.w600,
              ),
            ),

          const SizedBox(height: 14),

          // UAE-WIDE LABEL

          Row(
            children: [
              const Icon(
                Icons.flag_outlined,
                color: Colors.white70,
                size: 17,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'UAE HSE Safety Reference',
                  style: TextStyle(
                    color: Colors.white.withValues(
                      alpha: 0.78,
                    ),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DISCLAIMER
  // ============================================================

  Widget _buildDisclaimer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Color(0xFFB7791F),
            size: 22,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'This reference is provided for general HSE information. '
              'Always verify the latest applicable UAE legislation, '
              'authority requirements, company procedures and '
              'project-specific controls.',
              style: TextStyle(
                fontSize: 12.5,
                height: 1.5,
                color: Color(0xFF4B5563),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// INFO CARD
// ============================================================================

class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _InfoCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(
            title: title,
            icon: icon,
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION CARD
// ============================================================================

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(
            title: title,
            icon: icon,
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

// ============================================================================
// LIST SECTION CARD
// ============================================================================

class _ListSectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> items;

  const _ListSectionCard({
    required this.title,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(
            title: title,
            icon: icon,
          ),
          const SizedBox(height: 14),

          ...List.generate(
            items.length,
            (index) {
              final text = items[index].trim();

              if (text.isEmpty) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: EdgeInsets.only(
                  bottom:
                      index == items.length - 1 ? 0 : 12,
                ),
                child: _BulletItem(
                  number: index + 1,
                  text: text,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// REFERENCE SECTION
// ============================================================================

class _ReferenceSection extends StatelessWidget {
  final List<String> references;

  const _ReferenceSection({
    required this.references,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CardTitle(
            title: 'References',
            icon: Icons.menu_book_outlined,
          ),

          const SizedBox(height: 14),

          ...List.generate(
            references.length,
            (index) {
              final reference =
                  references[index].trim();

              if (reference.isEmpty) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: EdgeInsets.only(
                  bottom:
                      index == references.length - 1
                          ? 0
                          : 10,
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
                        color: lightGreen,
                        borderRadius:
                            BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.link_rounded,
                        size: 15,
                        color: darkGreen,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        reference,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.45,
                          color: textSecondary,
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
    );
  }
}

// ============================================================================
// BASE CARD
// ============================================================================

class _BaseCard extends StatelessWidget {
  final Widget child;

  const _BaseCard({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.05,
            ),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ============================================================================
// CARD TITLE
// ============================================================================

class _CardTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const _CardTitle({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: lightGreen,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: darkGreen,
            size: 21,
          ),
        ),

        const SizedBox(width: 11),

        Expanded(
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 17,
              height: 1.2,
              fontWeight: FontWeight.w800,
              color: textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// INFO ROW
// ============================================================================

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF6B7280),
          ),
        ),

        const SizedBox(height: 4),

        Text(
          value.trim().isEmpty
              ? 'Not specified'
              : value.trim(),
          style: const TextStyle(
            fontSize: 14.5,
            height: 1.4,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1F2937),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// BULLET ITEM
// ============================================================================

class _BulletItem extends StatelessWidget {
  final int number;
  final String text;

  const _BulletItem({
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 27,
          height: 27,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: lightGreen,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$number',
            style: const TextStyle(
              color: darkGreen,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14.5,
              height: 1.5,
              color: textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
