import 'package:flutter/material.dart';
import 'guidelines.dart';

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
        title: Text(
          topic.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(),
              const SizedBox(height: 16),

              _buildSection(
                icon: Icons.info_outline,
                title: 'Overview',
                content: topic.overview,
              ),

              _buildSection(
                icon: Icons.warning_amber_rounded,
                title: 'Hazards',
                content: topic.hazards,
              ),

              _buildSection(
                icon: Icons.shield_outlined,
                title: 'Controls',
                content: topic.controls,
              ),

              _buildSection(
                icon: Icons.event_note_outlined,
                title: 'Planning',
                content: topic.planning,
              ),

              _buildSection(
                icon: Icons.health_and_safety_outlined,
                title: 'Safe Practices',
                content: topic.safePractices,
              ),

              _buildSection(
                icon: Icons.construction_outlined,
                title: 'PPE',
                content: topic.ppe,
              ),

              _buildSection(
                icon: Icons.checklist_outlined,
                title: 'Checklist',
                content: topic.checklist,
              ),

              _buildSection(
                icon: Icons.fact_check_outlined,
                title: 'Inspection',
                content: topic.inspection,
              ),

              _buildSection(
                icon: Icons.thumb_up_alt_outlined,
                title: 'Do\'s',
                content: topic.dos,
              ),

              _buildSection(
                icon: Icons.block_outlined,
                title: 'Don\'ts',
                content: topic.donts,
              ),

              const SizedBox(height: 20),

              _buildSourceCard(),

              const SizedBox(height: 24),
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
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F766E),
            Color(0xFF115E59),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 5),
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
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.menu_book_outlined,
                  color: Colors.white,
                  size: 27,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  topic.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            topic.shortDescription,
            style: TextStyle(
              color: Colors.white.withOpacity(0.92),
              fontSize: 14,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 18),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _headerChip(topic.category),
              if (topic.sourceLabel.isNotEmpty)
                _headerChip(topic.sourceLabel),
              if (topic.copNumber.isNotEmpty)
                _headerChip(topic.copNumber),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headerChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.14),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.22),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    if (content.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
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
                  color: const Color(0xFFE6FFFB),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF0F766E),
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
          ),

          const SizedBox(height: 12),

          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.65,
              color: Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceCard() {
    final hasVersion = topic.version.isNotEmpty;
    final hasDate = topic.effectiveDate.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.source_outlined,
                size: 21,
                color: Color(0xFF475569),
              ),
              SizedBox(width: 9),
              Text(
                'Reference',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          if (topic.sourceLabel.isNotEmpty)
            _referenceRow(
              'Source',
              topic.sourceLabel,
            ),

          if (topic.copNumber.isNotEmpty)
            _referenceRow(
              'CoP / Reference',
              topic.copNumber,
            ),

          if (hasVersion)
            _referenceRow(
              'Version',
              topic.version,
            ),

          if (hasDate)
            _referenceRow(
              'Effective Date',
              topic.effectiveDate,
            ),
        ],
      ),
    );
  }

  Widget _referenceRow(
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF64748B),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF334155),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
