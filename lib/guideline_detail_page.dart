import 'package:flutter/material.dart';

import 'models/reference_topic.dart';

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
        elevation: 0,
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        title: Text(
          topic.shortTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            16,
            18,
            16,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(),

              const SizedBox(height: 16),

              _buildSection(
                title: 'Overview',
                icon: Icons.info_outline,
                child: Text(
                  topic.description,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.55,
                    color: Color(0xFF37474F),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              _buildSection(
                title: 'Key Requirements',
                icon: Icons.check_circle_outline,
                child: _buildBulletList(
                  topic.keyRequirements,
                ),
              ),

              const SizedBox(height: 14),

              _buildSection(
                title: 'Safety Controls',
                icon: Icons.shield_outlined,
                child: _buildBulletList(
                  topic.safetyControls,
                ),
              ),

              const SizedBox(height: 14),

              _buildSection(
                title: 'Responsibilities',
                icon: Icons.people_outline,
                child: _buildBulletList(
                  topic.responsibilities,
                ),
              ),

              const SizedBox(height: 14),

              _buildSection(
                title: 'References',
                icon: Icons.menu_book_outlined,
                child: _buildReferenceList(
                  topic.references,
                ),
              ),

              const SizedBox(height: 20),

              _buildDisclaimer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
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
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(
                    alpha: 0.10,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  _categoryIcon(topic.category),
                  color: primaryGreen,
                  size: 30,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Text(
                  topic.title,
                  style: const TextStyle(
                    fontSize: 22,
                    height: 1.2,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildInfoChip(
                icon: Icons.category_outlined,
                label: topic.category,
              ),
              _buildInfoChip(
                icon: Icons.public,
                label: topic.jurisdiction,
              ),
            ],
          ),

          const SizedBox(height: 18),

          _buildMetadataRow(
            icon: Icons.account_balance_outlined,
            label: 'Authority',
            value: topic.authority,
          ),

          const SizedBox(height: 10),

          _buildMetadataRow(
            icon: Icons.location_on_outlined,
            label: 'Jurisdiction',
            value: topic.jurisdiction,
          ),
        ],
      ),
    );
  }

  Widget _buildMetadataRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: primaryGreen,
        ),
        const SizedBox(width: 10),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              height: 1.4,
              color: Color(0xFF455A64),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: primaryGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: primaryGreen,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: darkGreen,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(
                    alpha: 0.10,
                  ),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  icon,
                  color: primaryGreen,
                  size: 21,
                ),
              ),

              const SizedBox(width: 11),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          child,
        ],
      ),
    );
  }

  Widget _buildBulletList(List<String> items) {
    if (items.isEmpty) {
      return const Text(
        'No information available.',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      );
    }

    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 11,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 6,
                ),
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: primaryGreen,
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 11),

              Expanded(
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Color(0xFF37474F),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildReferenceList(List<String> references) {
    if (references.isEmpty) {
      return const Text(
        'No references available.',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      );
    }

    return Column(
      children: references.asMap().entries.map((entry) {
        final index = entry.key;
        final reference = entry.value;

        return Padding(
          padding: EdgeInsets.only(
            bottom: index == references.length - 1
                ? 0
                : 11,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(
                    alpha: 0.10,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: primaryGreen,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  reference,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.45,
                    color: Color(0xFF37474F),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDisclaimer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            color: Colors.orange,
            size: 21,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              'This content is provided as a professional HSE reference. '
              'Always verify the latest applicable UAE federal, emirate-level, '
              'authority and project-specific requirements before relying on '
              'this guidance.',
              style: TextStyle(
                fontSize: 12,
                height: 1.45,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _categoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'abu dhabi':
        return Icons.location_city;

      case 'dubai':
        return Icons.apartment;

      default:
        return Icons.flag_outlined;
    }
  }
}
