import 'package:flutter/material.dart';

import 'models/reference_topic.dart';

// ============================================================================
// SafeNexus HSE
// Guideline Detail Page
//
// Step 7 - Integration-safe version
//
// Data flow:
// ReferenceTopic
//     ↓
// GuidelinesPage
//     ↓
// GuidelineDetailPage(topic: topic)
//
// Compatible with the current ReferenceTopic model and category architecture.
// ============================================================================

// ============================================================================
// GLOBAL COLORS
// ============================================================================

const Color primaryGreen = Color(0xFF159447);
const Color darkGreen = Color(0xFF0B5D3B);
const Color lightGreen = Color(0xFFE8F5EE);

const Color textPrimary = Color(0xFF111827);
const Color textSecondary = Color(0xFF374151);
const Color textMuted = Color(0xFF6B7280);

const Color pageBackground = Color(0xFFF5F7FA);

// ============================================================================
// GUIDELINE DETAIL PAGE
// ============================================================================

class GuidelineDetailPage extends StatelessWidget {
  final ReferenceTopic topic;

  const GuidelineDetailPage({
    super.key,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,

      // ======================================================================
      // APP BAR
      // ======================================================================

      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          topic.shortTitle.trim().isEmpty
              ? 'HSE Safety Reference'
              : topic.shortTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),

      // ======================================================================
      // BODY
      // ======================================================================

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
              // ==============================================================
              // HEADER CARD
              // ==============================================================

              _buildHeaderCard(),

              const SizedBox(height: 16),

              // ==============================================================
              // AUTHORITY / JURISDICTION
              // ==============================================================

              _InfoCard(
                title: 'Authority & Jurisdiction',
                icon: Icons.account_balance_outlined,
                children: [
                  _InfoRow(
                    label: 'Authority',
                    value: topic.authority,
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
                    label: 'Jurisdiction',
                    value: topic.jurisdiction,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ==============================================================
              // OVERVIEW
              // ==============================================================

              _SectionCard(
                title: 'Overview',
                icon: Icons.info_outline,
                child: Text(
                  topic.description.trim().isEmpty
                      ? 'No overview information is available.'
                      : topic.description,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.55,
                    color: textSecondary,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ==============================================================
              // KEY REQUIREMENTS
              // ==============================================================

              if (topic.keyRequirements.isNotEmpty)
                _ListSectionCard(
                  title: 'Key Requirements',
                  icon: Icons.checklist_outlined,
                  items: topic.keyRequirements,
                ),

              if (topic.keyRequirements.isNotEmpty)
                const SizedBox(height: 16),

              // ==============================================================
              // SAFETY CONTROLS
              // ==============================================================

              if (topic.safetyControls.isNotEmpty)
                _ListSectionCard(
                  title: 'Safety Controls',
                  icon: Icons.health_and_safety_outlined,
                  items: topic.safetyControls,
                ),

              if (topic.safetyControls.isNotEmpty)
                const SizedBox(height: 16),

              // ==============================================================
              // RESPONSIBILITIES
              // ==============================================================

              if (topic.responsibilities.isNotEmpty)
                _ListSectionCard(
                  title: 'Responsibilities',
                  icon: Icons.groups_outlined,
                  items: topic.responsibilities,
                ),

              if (topic.responsibilities.isNotEmpty)
                const SizedBox(height: 16),

              // ==============================================================
              // REFERENCES
              // ==============================================================

              if (topic.references.isNotEmpty)
                _ReferenceSection(
                  references: topic.references,
                ),

              if (topic.references.isNotEmpty)
                const SizedBox(height: 20),

              // ==============================================================
              // DISCLAIMER
              // ==============================================================

              _buildDisclaimer(),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================================
  // HEADER CARD
  // ==========================================================================

  Widget _buildHeaderCard() {
    final category = topic.category.trim();
    final title = topic.title.trim();
    final shortTitle = topic.shortTitle.trim();

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
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ------------------------------------------------------------------
          // CATEGORY
          // ------------------------------------------------------------------

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              category.isEmpty ? 'HSE Reference' : category,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // ------------------------------------------------------------------
          // TITLE
          // ------------------------------------------------------------------

          Text(
            title.isEmpty ? 'HSE Safety Reference' : title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              height: 1.25,
              fontWeight: FontWeight.bold,
            ),
          ),

          // ------------------------------------------------------------------
          // SHORT TITLE
          // ------------------------------------------------------------------

          if (shortTitle.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              shortTitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.90),
                fontSize: 15,
                height: 1.3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ==========================================================================
  // DISCLAIMER
  // ==========================================================================

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
                color: textSecondary,
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
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
    final validItems = items
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();

    if (validItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(
            title: title,
            icon: icon,
          ),
          const SizedBox(height: 14),
          ...List.generate(
            validItems.length,
            (index) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == validItems.length - 1
                      ? 0
                      : 12,
                ),
                child: _BulletItem(
                  number: index + 1,
                  text: validItems[index],
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
    final validReferences = references
        .map((reference) => reference.trim())
        .where((reference) => reference.isNotEmpty)
        .toList();

    if (validReferences.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CardTitle(
            title: 'References',
            icon: Icons.menu_book_outlined,
          ),
          const SizedBox(height: 14),
          ...List.generate(
            validReferences.length,
            (index) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == validReferences.length - 1
                      ? 0
                      : 10,
                ),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: lightGreen,
                        borderRadius:
                            BorderRadius.circular(7),
                      ),
                      child: const Icon(
                        Icons.link,
                        size: 15,
                        color: darkGreen,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        validReferences[index],
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
              fontWeight: FontWeight.bold,
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
    final cleanValue = value.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: textMuted,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          cleanValue.isEmpty
              ? 'Not specified'
              : cleanValue,
          style: const TextStyle(
            fontSize: 14.5,
            height: 1.4,
            fontWeight: FontWeight.w500,
            color: textPrimary,
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
              fontWeight: FontWeight.bold,
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
