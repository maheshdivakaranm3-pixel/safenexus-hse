import 'package:flutter/material.dart';

import 'models/reference_topic.dart';

class GuidelineDetailPage extends StatelessWidget {
  final ReferenceTopic topic;

  const GuidelineDetailPage({
    super.key,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0B5D3B),
        foregroundColor: Colors.white,
        title: Text(
          topic.shortTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ============================================================
              // HEADER CARD
              // ============================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF0B5D3B),
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
                    // Category badge
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
                        topic.category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      topic.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        height: 1.25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      topic.shortTitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.90),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ============================================================
              // AUTHORITY / JURISDICTION
              // ============================================================

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

              // ============================================================
              // DESCRIPTION
              // ============================================================

              _SectionCard(
                title: 'Overview',
                icon: Icons.info_outline,
                child: Text(
                  topic.description,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.55,
                    color: Color(0xFF374151),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ============================================================
              // KEY REQUIREMENTS
              // ============================================================

              if (topic.keyRequirements.isNotEmpty)
                _ListSectionCard(
                  title: 'Key Requirements',
                  icon: Icons.checklist_outlined,
                  items: topic.keyRequirements,
                ),

              if (topic.keyRequirements.isNotEmpty)
                const SizedBox(height: 16),

              // ============================================================
              // SAFETY CONTROLS
              // ============================================================

              if (topic.safetyControls.isNotEmpty)
                _ListSectionCard(
                  title: 'Safety Controls',
                  icon: Icons.health_and_safety_outlined,
                  items: topic.safetyControls,
                ),

              if (topic.safetyControls.isNotEmpty)
                const SizedBox(height: 16),

              // ============================================================
              // RESPONSIBILITIES
              // ============================================================

              if (topic.responsibilities.isNotEmpty)
                _ListSectionCard(
                  title: 'Responsibilities',
                  icon: Icons.groups_outlined,
                  items: topic.responsibilities,
                ),

              if (topic.responsibilities.isNotEmpty)
                const SizedBox(height: 16),

              // ============================================================
              // REFERENCES
              // ============================================================

              if (topic.references.isNotEmpty)
                _ReferenceSection(
                  references: topic.references,
                ),

              const SizedBox(height: 24),

              // ============================================================
              // FOOTER / DISCLAIMER
              // ============================================================

              Container(
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
                        'authority requirements, company procedures and project-specific controls.',
                        style: TextStyle(
                          fontSize: 12.5,
                          height: 1.5,
                          color: Color(0xFF4B5563),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
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
            items.length,
            (index) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == items.length - 1 ? 0 : 12,
                ),
                child: _BulletItem(
                  number: index + 1,
                  text: items[index],
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
            references.length,
            (index) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == references.length - 1 ? 0 : 10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5EE),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Icon(
                        Icons.link,
                        size: 15,
                        color: Color(0xFF0B5D3B),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        references[index],
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.45,
                          color: Color(0xFF374151),
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
            color: const Color(0xFFE8F5EE),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF0B5D3B),
            size: 21,
          ),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
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
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
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
            color: const Color(0xFFE8F5EE),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$number',
            style: const TextStyle(
              color: Color(0xFF0B5D3B),
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
              color: Color(0xFF374151),
            ),
          ),
        ),
      ],
    );
  }
}
