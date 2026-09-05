import 'package:flutter/material.dart';

class GuidelinesPage extends StatefulWidget {
  const GuidelinesPage({super.key});

  @override
  State<GuidelinesPage> createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  final TextEditingController _searchController = TextEditingController();

  String _query = '';

  static const List<_SafetyRegion> _regions = [
    _SafetyRegion(
      id: 'uae',
      title: 'UAE HSE Safety',
      subtitle: 'UAE-wide HSE guidance',
      icon: Icons.flag_rounded,
      color: Color(0xFF159447),
      description:
          'General HSE learning and field-reference guidance for workplaces and construction activities across the United Arab Emirates.',
      topics: _uaeTopics,
    ),
    _SafetyRegion(
      id: 'dubai',
      title: 'Dubai HSE Safety',
      subtitle: 'Dubai-focused HSE guidance',
      icon: Icons.location_city_rounded,
      color: Color(0xFF1677C8),
      description:
          'Dubai-focused HSE learning and reference material covering common workplace, construction, occupational and environmental safety subjects.',
      topics: _dubaiTopics,
    ),
    _SafetyRegion(
      id: 'abu_dhabi',
      title: 'Abu Dhabi HSE Safety',
      subtitle: 'ADOSH-SF & Abu Dhabi guidance',
      icon: Icons.account_balance_rounded,
      color: Color(0xFF6736C8),
      description:
          'Abu Dhabi-focused HSE learning and field reference covering OSH management, ADOSH-SF-related subjects and common construction safety requirements.',
      topics: _abuDhabiTopics,
    ),
  ];

  static const List<_ReferenceTopic> _referenceLibrary = [
    ..._uaeTopics,
    ..._dubaiTopics,
    ..._abuDhabiTopics,
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_TopicReference> _searchResults() {
    final query = _query.trim().toLowerCase();

    if (query.isEmpty) {
      return const [];
    }

    final results = <_TopicReference>[];
    final seen = <String>{};

    for (final topic in _referenceLibrary) {
      final searchable =
          '${topic.title} ${topic.description} ${topic.ppe} ${topic.hazards} ${topic.controls}'
              .toLowerCase();

      if (searchable.contains(query) && seen.add(topic.key)) {
        results.add(
          _TopicReference(
            topic: topic,
            region: _findRegion(topic),
          ),
        );
      }
    }

    return results;
  }

  _SafetyRegion _findRegion(_ReferenceTopic topic) {
    if (topic.regionId == 'dubai') {
      return _regions[1];
    }

    if (topic.regionId == 'abu_dhabi') {
      return _regions[2];
    }

    return _regions[0];
  }

  @override
  Widget build(BuildContext context) {
    final searching = _query.trim().isNotEmpty;
    final searchResults = _searchResults();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: const Text(
          'HSE Guidelines',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        children: [
          _buildIntroCard(),
          const SizedBox(height: 18),
          _buildSearchField(),
          const SizedBox(height: 22),

          if (searching)
            ...[
              _buildSectionHeader(
                'SEARCH RESULTS',
                '${searchResults.length} topic(s) found',
              ),
              const SizedBox(height: 12),
              if (searchResults.isEmpty)
                _buildEmptyState()
              else
                ...searchResults.asMap().entries.map(
                  (entry) => _buildSearchResultCard(
                    context,
                    entry.key + 1,
                    entry.value,
                  ),
                ),
            ]
          else
            ...[
              const Text(
                'SAFETY AREAS',
                style: TextStyle(
                  color: Color(0xFF087A38),
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Select a safety reference area',
                style: TextStyle(
                  color: Color(0xFF707070),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 12),
              ..._regions.map(
                (region) => _buildRegionCard(
                  context,
                  region,
                ),
              ),
            ],
        ],
      ),
    );
  }

  Widget _buildIntroCard() {
    return Container(
      padding: const EdgeInsets.all(19),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0x22FFFFFF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'UAE HSE Safety Centre',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Learn, understand and use practical HSE safety references for UAE workplaces and construction sites.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      onChanged: (value) {
        setState(() {
          _query = value;
        });
      },
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search HSE topics',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: _query.isEmpty
            ? null
            : IconButton(
                tooltip: 'Clear search',
                icon: const Icon(Icons.clear_rounded),
                onPressed: () {
                  _searchController.clear();
                  setState(() {
                    _query = '';
                  });
                },
              ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFF159447),
            width: 1.4,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF087A38),
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFF777777),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildRegionCard(
    BuildContext context,
    _SafetyRegion region,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RegionalSafetyPage(
                region: region,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: region.color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  region.icon,
                  color: region.color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      region.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      region.subtitle,
                      style: const TextStyle(
                        color: Color(0xFF777777),
                        fontSize: 11.5,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${region.topics.length} learning topics',
                      style: TextStyle(
                        color: region.color,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: region.color,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResultCard(
    BuildContext context,
    int number,
    _TopicReference result,
  ) {
    final topic = result.topic;
    final region = result.region;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => GuidelineDetailPage(
                topic: topic,
                region: region,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              _numberBox(
                number,
                region.color,
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      region.title,
                      style: TextStyle(
                        color: region.color,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      topic.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF777777),
                        fontSize: 12,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: region.color,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _numberBox(int number, Color color) {
    return Container(
      width: 46,
      height: 46,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Text(
        '$number',
        style: TextStyle(
          color: color,
          fontSize: 17,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 52,
            color: Colors.grey.shade500,
          ),
          const SizedBox(height: 12),
          const Text(
            'No guidelines found',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Try Risk Assessment, PPE, Heat Stress, Fire, Lifting or another HSE topic.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF777777),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// REGIONAL SAFETY PAGE
// ============================================================================

class RegionalSafetyPage extends StatelessWidget {
  final _SafetyRegion region;

  const RegionalSafetyPage({
    super.key,
    required this.region,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: Text(
          region.title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          Text(
            'LEARNING & REFERENCE TOPICS',
            style: TextStyle(
              color: region.color,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${region.topics.length} topics available',
            style: const TextStyle(
              color: Color(0xFF707070),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          ...region.topics.asMap().entries.map(
                (entry) => _buildTopicCard(
                  context,
                  entry.key + 1,
                  entry.value,
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: region.color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  region.icon,
                  color: region.color,
                  size: 29,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  region.title,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            region.description,
            style: const TextStyle(
              color: Color(0xFF666666),
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: region.color.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.lightbulb_outline_rounded,
                  color: region.color,
                  size: 20,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    'Tap any topic to learn the definition, hazards, controls, PPE, safe work practices, checklist and HSE supervisor points.',
                    style: TextStyle(
                      color: region.color,
                      fontSize: 11.5,
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicCard(
    BuildContext context,
    int number,
    _ReferenceTopic topic,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => GuidelineDetailPage(
                topic: topic,
                region: region,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: region.color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text(
                  '$number',
                  style: TextStyle(
                    color: region.color,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
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
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      topic.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF777777),
                        fontSize: 12,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: region.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// COMPLETE GUIDELINE DETAIL PAGE
// ============================================================================

class GuidelineDetailPage extends StatelessWidget {
  final _ReferenceTopic topic;
  final _SafetyRegion region;

  const GuidelineDetailPage({
    super.key,
    required this.topic,
    required this.region,
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroCard(),
            const SizedBox(height: 16),

            _infoCard(
              icon: Icons.menu_book_rounded,
              title: 'What is it?',
              content: topic.definition,
            ),

            _infoCard(
              icon: Icons.info_outline_rounded,
              title: 'Purpose',
              content: topic.purpose,
            ),

            _infoCard(
              icon: Icons.warning_amber_rounded,
              title: 'Main Hazards',
              content: topic.hazards,
            ),

            _infoCard(
              icon: Icons.rule_rounded,
              title: 'Key Controls',
              content: topic.controls,
            ),

            _infoCard(
              icon: Icons.construction_rounded,
              title: 'PPE',
              content: topic.ppe,
            ),

            _infoCard(
              icon: Icons.engineering_rounded,
              title: 'Safe Work Practice',
              content: topic.safePractice,
            ),

            _infoCard(
              icon: Icons.checklist_rounded,
              title: 'Before Work Checklist',
              content: topic.checklist,
            ),

            _infoCard(
              icon: Icons.visibility_rounded,
              title: 'HSE Supervisor Reference',
              content: topic.supervisorReference,
            ),

            _infoCard(
              icon: Icons.emergency_rounded,
              title: 'Emergency Response',
              content: topic.emergencyResponse,
            ),

            _infoCard(
              icon: Icons.error_outline_rounded,
              title: 'Common Unsafe Practices',
              content: topic.commonMistakes,
            ),

            _infoCard(
              icon: Icons.school_rounded,
              title: 'Worker Learning Point',
              content: topic.learningPoint,
            ),

            _infoCard(
              icon: Icons.warning_amber_rounded,
              title: 'Important',
              content:
                  'This page is an HSE awareness and field-reference resource. It does not replace current UAE legislation, authority requirements, applicable Codes of Practice, approved risk assessments, method statements, permits, manufacturer instructions or project procedures. Always verify the latest requirements applicable to the work location and activity.',
            ),

            const SizedBox(height: 8),

            Text(
              'REFERENCE AREA',
              style: TextStyle(
                color: region.color,
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              region.title,
              style: const TextStyle(
                color: Color(0xFF666666),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21),
        gradient: LinearGradient(
          colors: [
            region.color,
            region.color.withValues(alpha: 0.76),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.shield_rounded,
            color: Colors.white,
            size: 34,
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  region.title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 9),
                const Text(
                  'Learn • Understand • Apply • Verify',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String content,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: region.color,
            size: 24,
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
                  ),
                ),
                const SizedBox(height: 7),
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
}

// ============================================================================
// DATA MODELS
// ============================================================================

class _SafetyRegion {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String description;
  final List<_ReferenceTopic> topics;

  const _SafetyRegion({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.description,
    required this.topics,
  });
}

class _ReferenceTopic {
  final String key;
  final String regionId;
  final String title;
  final String description;
  final String definition;
  final String purpose;
  final String hazards;
  final String controls;
  final String ppe;
  final String safePractice;
  final String checklist;
  final String supervisorReference;
  final String emergencyResponse;
  final String commonMistakes;
  final String learningPoint;

  const _ReferenceTopic({
    required this.key,
    required this.regionId,
    required this.title,
    required this.description,
    required this.definition,
    required this.purpose,
    required this.hazards,
    required this.controls,
    required this.ppe,
    required this.safePractice,
    required this.checklist,
    required this.supervisorReference,
    required this.emergencyResponse,
    required this.commonMistakes,
    required this.learningPoint,
  });
}

class _TopicReference {
  final _ReferenceTopic topic;
  final _SafetyRegion region;

  const _TopicReference({
    required this.topic,
    required this.region,
  });
}

// ============================================================================
// UAE TOPICS
// ============================================================================

const List<_ReferenceTopic> _uaeTopics = [
  _ReferenceTopic(
    key: 'uae_risk_assessment',
    regionId: 'uae',
    title: 'Risk Assessment',
    description:
        'A systematic process for identifying hazards, evaluating risk and selecting effective controls.',
    definition:
        'Risk assessment is the process of identifying hazards associated with an activity, determining the likelihood and consequence of harm, evaluating the level of risk and selecting appropriate controls.',
    purpose:
        'The purpose is to understand what can cause harm before work starts and ensure risks are reduced to an acceptable level using the hierarchy of controls.',
    hazards:
        'Unidentified hazards • Changing site conditions • Poor access • Plant and machinery • Work at height • Electricity • Chemicals • Traffic • Simultaneous activities.',
    controls:
        'Identify hazards • Identify people at risk • Assess likelihood and consequence • Apply hierarchy of controls • Record controls • Communicate findings • Review when conditions change.',
    ppe:
        'PPE is the last line of defence and must be selected according to the task-specific hazards and risk assessment.',
    safePractice:
        'Use competent personnel. Review the work sequence, equipment, environment, people and interfaces. Update the assessment after significant changes, incidents or new hazards.',
    checklist:
        'Scope defined • Hazards identified • People at risk identified • Existing controls checked • Risk evaluated • Additional controls selected • Workers briefed • Assessment reviewed.',
    supervisorReference:
        'Check that the risk assessment matches the actual site activity. Verify controls are physically implemented rather than only documented.',
    emergencyResponse:
        'Stop unsafe work • Raise alarm if required • Protect people from further exposure • Contact emergency support • Provide first aid where appropriate • Report and investigate.',
    commonMistakes:
        'Copying generic risk assessments • Ignoring simultaneous activities • Not involving workers • Failing to review changes • Relying only on PPE.',
    learningPoint:
        'A good risk assessment describes the real job, real hazards and real controls—not only paperwork.',
  ),
  _ReferenceTopic(
    key: 'uae_ppe',
    regionId: 'uae',
    title: 'Personal Protective Equipment',
    description:
        'Selection, use, inspection and maintenance of PPE based on workplace hazards.',
    definition:
        'PPE is equipment worn or used by a worker to reduce exposure to hazards when risks cannot be adequately controlled by higher-level measures.',
    purpose:
        'PPE provides an additional barrier against hazards such as impact, chemicals, noise, heat, electricity and falling objects.',
    hazards:
        'Head injury • Eye injury • Hand injury • Foot injury • Hearing damage • Chemical exposure • Respiratory exposure • Fall hazards.',
    controls:
        'Identify hazard • Select suitable certified PPE • Correct size and fit • Train workers • Inspect before use • Maintain and replace damaged PPE.',
    ppe:
        'Safety helmet • Safety footwear • Eye protection • Gloves • High-visibility clothing • Hearing protection • Respiratory protection • Fall protection where required.',
    safePractice:
        'PPE must be compatible with the task and with other PPE being worn. Workers should understand limitations and correct storage requirements.',
    checklist:
        'Correct PPE selected • Good condition • Correct size • Clean • Properly fitted • Worker trained • Compatibility checked • Replacement available.',
    supervisorReference:
        'Observe actual PPE use in the work area. Do not assume PPE is effective simply because it has been issued.',
    emergencyResponse:
        'Stop exposure • Move to a safe location • Follow emergency procedures • Remove contaminated PPE safely where applicable • Seek medical assistance.',
    commonMistakes:
        'Wrong PPE • Damaged PPE • Poor fit • No inspection • Wearing unsuitable gloves around rotating equipment • Treating PPE as the primary control.',
    learningPoint:
        'PPE protects the worker only when it is correctly selected, correctly worn and maintained.',
  ),
  _ReferenceTopic(
    key: 'uae_heat_stress',
    regionId: 'uae',
    title: 'Heat Stress Management',
    description:
        'Controls for reducing heat-related illness in hot and humid working environments.',
    definition:
        'Heat stress occurs when the body cannot adequately control its temperature because of environmental heat, humidity, workload, clothing or other factors.',
    purpose:
        'The objective is to prevent heat exhaustion, heat stroke, dehydration and other heat-related illness.',
    hazards:
        'High temperature • High humidity • Direct sunlight • Heavy work • Poor ventilation • Dehydration • Inadequate acclimatization • Excessive PPE.',
    controls:
        'Provide drinking water • Suitable rest • Shade or cool areas • Plan demanding work • Acclimatize workers • Monitor conditions • Train workers • Encourage early reporting.',
    ppe:
        'Suitable work clothing • Safety footwear • Head protection • High-visibility clothing where required • Task-specific PPE.',
    safePractice:
        'Plan work around environmental conditions. Encourage regular hydration and rest. Supervisors should watch for behavioural and physical signs of heat illness.',
    checklist:
        'Water available • Shade/rest area • Heat awareness • Acclimatization • Work/rest arrangement • Emergency plan • Worker monitoring • Supervisor awareness.',
    supervisorReference:
        'Check workers continuously, particularly new or returning workers and those performing heavy work. Never ignore symptoms.',
    emergencyResponse:
        'Stop work • Move the affected person to a cool area • Cool the person • Call emergency medical support for serious symptoms • Do not delay treatment for suspected heat stroke.',
    commonMistakes:
        'Waiting until workers become thirsty • No shaded rest • Ignoring symptoms • Excessive work intensity • Poor acclimatization.',
    learningPoint:
        'Heat illness can become life-threatening quickly. Early recognition and immediate action are critical.',
  ),
  _ReferenceTopic(
    key: 'uae_fire',
    regionId: 'uae',
    title: 'Fire Safety',
    description:
        'Fire prevention, protection, evacuation and emergency response arrangements.',
    definition:
        'Fire safety involves preventing ignition, limiting fire spread, protecting people and providing effective alarm, evacuation and firefighting arrangements.',
    purpose:
        'The purpose is to protect life, property and the environment from fire and smoke.',
    hazards:
        'Flammable materials • Hot work • Electrical faults • Gas cylinders • Poor housekeeping • Ignition sources • Improper chemical storage.',
    controls:
        'Remove ignition sources • Control combustibles • Maintain fire equipment • Provide alarms • Keep escape routes clear • Conduct drills • Apply hot-work controls.',
    ppe:
        'Task-specific PPE • Safety footwear • Eye protection • Fire-resistant clothing for applicable hot work • Suitable gloves.',
    safePractice:
        'Maintain good housekeeping. Store flammables correctly. Keep exits accessible. Ensure workers know alarm, evacuation and assembly arrangements.',
    checklist:
        'Fire exits clear • Extinguishers accessible • Alarm arrangements checked • Combustibles controlled • Hot work controlled • Emergency contacts known • Assembly point identified.',
    supervisorReference:
        'Check fire equipment access, housekeeping, temporary electrical systems, gas cylinders and hot-work controls.',
    emergencyResponse:
        'Raise alarm • Stop work if safe • Evacuate • Do not re-enter • Call emergency services • Account for personnel • Only trained persons should attempt firefighting.',
    commonMistakes:
        'Blocked exits • Expired/damaged extinguishers • Uncontrolled hot work • Poor cylinder storage • Ignoring housekeeping.',
    learningPoint:
        'Fire prevention is stronger than firefighting. Control ignition and fuel before an emergency occurs.',
  ),
  _ReferenceTopic(
    key: 'uae_emergency',
    regionId: 'uae',
    title: 'Emergency Preparedness',
    description:
        'Planning and preparation for workplace emergencies.',
    definition:
        'Emergency preparedness is the process of planning people, equipment, communication and procedures for foreseeable emergencies.',
    purpose:
        'To reduce confusion and response time and protect workers, visitors, property and the environment.',
    hazards:
        'Fire • Medical emergency • Gas release • Chemical spill • Structural failure • Severe weather • Vehicle incident • Utility failure.',
    controls:
        'Emergency plan • Alarm system • Emergency contacts • Evacuation routes • Assembly points • Trained personnel • Drills • Emergency equipment.',
    ppe:
        'PPE depends on the emergency and hazard. Emergency responders may require specialised PPE.',
    safePractice:
        'Keep emergency routes clear and ensure workers know what to do, where to go and who to contact.',
    checklist:
        'Emergency plan • Alarm • Emergency numbers • Assembly point • First aid • Fire equipment • Rescue arrangements • Drill records.',
    supervisorReference:
        'Verify emergency arrangements physically at the workplace and ensure changes to site layout are reflected in the plan.',
    emergencyResponse:
        'Raise alarm • Protect yourself • Evacuate or shelter as required • Contact emergency services • Account for people • Follow the emergency plan.',
    commonMistakes:
        'No drills • Unknown assembly point • Blocked emergency access • Outdated emergency numbers • Poor communication.',
    learningPoint:
        'Emergency preparedness must be practical enough for workers to follow under stress.',
  ),
  _ReferenceTopic(
    key: 'uae_first_aid',
    regionId: 'uae',
    title: 'First Aid',
    description:
        'Immediate care and medical response for workplace injury and illness.',
    definition:
        'First aid is the immediate assistance provided to an injured or ill person before professional medical treatment is available.',
    purpose:
        'To preserve life, prevent deterioration and support recovery until appropriate medical care is provided.',
    hazards:
        'Cuts • Burns • Falls • Crushing • Chemical exposure • Heat illness • Electric shock • Eye injuries.',
    controls:
        'First-aid equipment • Trained first aiders • Emergency communication • Clear access • Medical arrangements • Incident reporting.',
    ppe:
        'Gloves • Eye protection • Other PPE appropriate to the hazard and first-aid situation.',
    safePractice:
        'Do not expose yourself to the same hazard. Make the scene safe before providing assistance and seek professional help when required.',
    checklist:
        'First-aid box • Trained first aider • Emergency contact • Access route • Medical facility information • Incident recording.',
    supervisorReference:
        'Check first-aid equipment, expiry dates, accessibility and availability of trained personnel.',
    emergencyResponse:
        'Make area safe • Call emergency medical support • Assess the casualty • Provide appropriate first aid within competence • Preserve evidence where applicable.',
    commonMistakes:
        'Entering an unsafe area • Delayed emergency call • Missing first-aid supplies • Untrained intervention.',
    learningPoint:
        'The first priority is life safety. Never become a second casualty.',
  ),
  _ReferenceTopic(
    key: 'uae_work_height',
    regionId: 'uae',
    title: 'Working at Height',
    description:
        'Controls to prevent falls from elevated work areas.',
    definition:
        'Work at height includes work where a person could fall from one level to another and suffer injury.',
    purpose:
        'Prevent falls, falling objects and related injuries through planning and effective fall prevention and protection.',
    hazards:
        'Open edges • Unprotected platforms • Fragile surfaces • Unsafe ladders • Scaffolds • Falling tools • Poor access.',
    controls:
        'Avoid work at height where possible • Safe access • Guardrails • Edge protection • Suitable platforms • Fall protection • Rescue planning.',
    ppe:
        'Safety helmet with chin strap where required • Safety footwear • Full body harness where required • Task-specific PPE.',
    safePractice:
        'Inspect access equipment before use. Maintain three-point contact on ladders where applicable. Never remove edge protection without an approved control.',
    checklist:
        'Risk assessment • Safe access • Platform inspected • Guardrails • Toe boards • Harness if required • Anchor point • Rescue plan • Worker competence.',
    supervisorReference:
        'Check actual edge protection, access, platform condition, anchorage and worker behaviour.',
    emergencyResponse:
        'Raise alarm • Prevent additional falls • Do not move an injured person unnecessarily • Activate rescue plan • Contact emergency medical support.',
    commonMistakes:
        'Improvised platforms • Overreaching • Missing guardrails • Unapproved anchor points • No rescue plan.',
    learningPoint:
        'Fall prevention should come before reliance on a harness.',
  ),
  _ReferenceTopic(
    key: 'uae_confined_space',
    regionId: 'uae',
    title: 'Confined Space Safety',
    description:
        'Controls for work in spaces with restricted entry or exit and potential serious hazards.',
    definition:
        'A confined space is a space with characteristics that may create serious risks due to restricted access, atmosphere, engulfment or other hazards.',
    purpose:
        'Prevent poisoning, asphyxiation, engulfment, fire, explosion and rescue-related fatalities.',
    hazards:
        'Oxygen deficiency • Toxic gases • Flammable atmosphere • Engulfment • Heat • Limited access • Mechanical energy • Flooding.',
    controls:
        'Risk assessment • Permit where required • Isolation • Gas testing • Ventilation • Attendant • Communication • Rescue plan.',
    ppe:
        'Helmet • Safety footwear • Gloves • Eye protection • Respiratory protection where required • Harness and retrieval equipment where required.',
    safePractice:
        'Never enter without understanding the hazards and required controls. Test the atmosphere using suitable equipment and maintain communication.',
    checklist:
        'Permit • Isolation • Gas test • Ventilation • Attendant • Communication • Rescue equipment • Competent workers • Emergency plan.',
    supervisorReference:
        'Verify testing, isolation, permit conditions and rescue readiness before entry.',
    emergencyResponse:
        'Raise alarm • Do not make an uncontrolled rescue entry • Activate the rescue plan • Contact emergency services • Use trained rescue personnel.',
    commonMistakes:
        'Entering without testing • No attendant • No isolation • Improvised rescue • Ignoring alarm readings.',
    learningPoint:
        'Many confined-space fatalities occur when untrained people attempt rescue. Never enter impulsively.',
  ),
  _ReferenceTopic(
    key: 'uae_electrical',
    regionId: 'uae',
    title: 'Electrical Safety',
    description:
        'Prevention of electric shock, burns, fire and electrical equipment incidents.',
    definition:
        'Electrical safety is the control of hazards arising from electrical installations, tools, temporary supplies and energised systems.',
    purpose:
        'Protect people from shock, arc flash, burns, fire and equipment damage.',
    hazards:
        'Live conductors • Damaged cables • Improper connections • Wet conditions • Overloading • Temporary supplies • Poor earthing.',
    controls:
        'Isolation • Competent electrical personnel • Inspection • Suitable protection • Cable management • RCD/GFCI where applicable • Controlled access.',
    ppe:
        'Electrical-rated PPE where required • Eye/face protection • Safety footwear • Arc-flash PPE where applicable.',
    safePractice:
        'Treat electrical systems as energised until correctly isolated and verified. Do not use damaged cables or improvised connections.',
    checklist:
        'Isolation • Competent person • Inspection • Earthing • RCD/GFCI where applicable • Cable protection • Distribution-board protection.',
    supervisorReference:
        'Look for damaged cables, open panels, overloaded outlets, poor connections and unauthorised electrical work.',
    emergencyResponse:
        'Do not touch a casualty while the circuit may be energised • Isolate power if safe • Call emergency services • Provide first aid when safe.',
    commonMistakes:
        'Using damaged leads • Bypassing protection • Unauthorised repairs • Wet electrical work • Poor cable routing.',
    learningPoint:
        'Electrical hazards may be invisible. Isolation and verification are essential.',
  ),
  _ReferenceTopic(
    key: 'uae_lifting',
    regionId: 'uae',
    title: 'Lifting & Rigging',
    description:
        'Safe planning and execution of lifting operations.',
    definition:
        'Lifting safety involves planning, equipment selection, competent personnel, load control and exclusion of people from danger zones.',
    purpose:
        'Prevent dropped loads, equipment failure, struck-by incidents and overturning.',
    hazards:
        'Dropped load • Overloading • Damaged slings • Poor ground • Suspended loads • Poor communication • Wind • Unauthorised access.',
    controls:
        'Lift plan • Competent lifting team • Certified equipment • Pre-use inspection • Load weight verification • Exclusion zone • Communication.',
    ppe:
        'Safety helmet • Safety footwear • High-visibility clothing • Gloves • Eye protection • Task-specific PPE.',
    safePractice:
        'Know the load weight and centre of gravity. Inspect lifting accessories. Never stand under a suspended load.',
    checklist:
        'Lift plan • Equipment certification • Sling inspection • Load weight • Ground condition • Exclusion zone • Signal communication • Weather.',
    supervisorReference:
        'Check equipment identification, inspection condition, lifting plan, exclusion zone and competence of the team.',
    emergencyResponse:
        'Stop lifting • Secure area • Prevent access • Raise alarm • Do not approach an unstable load • Follow emergency arrangements.',
    commonMistakes:
        'Improvised lifting accessories • No exclusion zone • Side loading • Overloading • Standing under loads.',
    learningPoint:
        'Every lift should be planned according to the load, equipment, environment and people involved.',
  ),
  _ReferenceTopic(
    key: 'uae_chemical',
    regionId: 'uae',
    title: 'Chemical Safety',
    description:
        'Safe identification, storage, handling and control of hazardous chemicals.',
    definition:
        'Chemical safety is the systematic control of exposure, storage, handling, transport and disposal of hazardous substances.',
    purpose:
        'Prevent poisoning, burns, respiratory exposure, fire, explosion and environmental contamination.',
    hazards:
        'Toxicity • Corrosivity • Flammability • Reactivity • Vapour exposure • Skin contact • Incompatible storage.',
    controls:
        'SDS availability • Labelling • Compatible storage • Ventilation • Exposure controls • Spill arrangements • Training • Safe disposal.',
    ppe:
        'Chemical-resistant gloves • Eye/face protection • Protective clothing • Respiratory protection where required.',
    safePractice:
        'Read the SDS before use. Keep containers labelled and closed. Never mix chemicals unless the procedure specifically permits it.',
    checklist:
        'SDS • Labels • Storage compatibility • Spill kit • Ventilation • PPE • Emergency information • Waste arrangements.',
    supervisorReference:
        'Check storage segregation, labels, containers, spill response equipment and worker knowledge.',
    emergencyResponse:
        'Stop source if safe • Isolate area • Avoid exposure • Follow SDS emergency instructions • Contact emergency support • Report spill.',
    commonMistakes:
        'Unlabelled containers • Chemical mixing • Poor storage • No SDS • Wrong gloves • Disposal into unsuitable drains.',
    learningPoint:
        'The SDS is a key source of information for understanding chemical hazards and emergency actions.',
  ),
  _ReferenceTopic(
    key: 'uae_manual_handling',
    regionId: 'uae',
    title: 'Manual Handling',
    description:
        'Safe movement and handling of materials to reduce musculoskeletal injuries.',
    definition:
        'Manual handling involves lifting, lowering, carrying, pushing, pulling or moving objects using physical effort.',
    purpose:
        'Reduce strains, sprains, back injuries and other musculoskeletal disorders.',
    hazards:
        'Heavy loads • Awkward posture • Repetitive work • Long carrying distance • Poor grip • Uneven surfaces.',
    controls:
        'Avoid unnecessary lifting • Use mechanical aids • Reduce load • Improve work height • Team lifting • Plan route • Training.',
    ppe:
        'Safety footwear • Suitable gloves • Eye protection where required • Other task-specific PPE.',
    safePractice:
        'Assess the load and route before lifting. Keep the load close to the body and avoid twisting while carrying.',
    checklist:
        'Load assessed • Route clear • Mechanical aid available • Load manageable • Grip suitable • Team lifting arranged where needed.',
    supervisorReference:
        'Observe actual handling techniques and identify tasks that should be redesigned or mechanised.',
    emergencyResponse:
        'Stop work after injury • Provide first aid • Seek medical assessment when needed • Report the incident.',
    commonMistakes:
        'Lifting beyond capacity • Twisting • Poor route planning • Carrying with blocked visibility • Ignoring mechanical aids.',
    learningPoint:
        'The safest manual lift is often the lift that can be eliminated or mechanised.',
  ),
  _ReferenceTopic(
    key: 'uae_traffic',
    regionId: 'uae',
    title: 'Traffic & Vehicle Safety',
    description:
        'Controls for workplace vehicles, mobile plant and pedestrian interaction.',
    definition:
        'Traffic safety involves managing movement of vehicles, mobile equipment and pedestrians to prevent collisions and struck-by incidents.',
    purpose:
        'Protect workers, drivers, visitors and road users from vehicle-related hazards.',
    hazards:
        'Reversing • Blind spots • Speed • Poor visibility • Pedestrian interaction • Uncontrolled routes • Untrained drivers.',
    controls:
        'Traffic management plan • Segregation • Speed control • Reversing controls • Signage • Trained drivers • Pedestrian routes.',
    ppe:
        'High-visibility clothing • Safety footwear • Safety helmet where required • Task-specific PPE.',
    safePractice:
        'Use designated routes. Avoid unnecessary reversing. Maintain communication and never assume a driver has seen a pedestrian.',
    checklist:
        'Traffic plan • Pedestrian route • Vehicle inspection • Driver competence • Speed controls • Reversing arrangement • Signage.',
    supervisorReference:
        'Observe vehicle-pedestrian interaction during actual operations, especially reversing and loading activities.',
    emergencyResponse:
        'Stop traffic • Secure area • Raise alarm • Call emergency support • Do not move seriously injured casualties unless necessary for safety.',
    commonMistakes:
        'Walking behind reversing vehicles • Excessive speed • Poor segregation • Unauthorised driving • Ignoring blind spots.',
    learningPoint:
        'Physical separation between people and vehicles is one of the strongest controls.',
  ),
  _ReferenceTopic(
    key: 'uae_worker_welfare',
    regionId: 'uae',
    title: 'Worker Welfare',
    description:
        'Suitable drinking water, sanitation, rest, hygiene and welfare arrangements.',
    definition:
        'Worker welfare refers to facilities and conditions that support workers’ health, hygiene, rest and basic needs.',
    purpose:
        'Protect health, dignity, wellbeing and work capacity.',
    hazards:
        'Dehydration • Poor sanitation • Inadequate rest • Poor hygiene • Insufficient drinking water • Unsuitable accommodation or welfare areas.',
    controls:
        'Safe drinking water • Toilets • Washing facilities • Rest areas • Clean facilities • Heat protection • Maintenance.',
    ppe:
        'PPE is task-specific; welfare areas should also be maintained hygienically and safely.',
    safePractice:
        'Keep facilities clean, accessible and adequately maintained. Ensure workers can take appropriate rest and hydration breaks.',
    checklist:
        'Drinking water • Toilets • Washing facilities • Rest area • Cleaning • Waste disposal • Heat protection.',
    supervisorReference:
        'Inspect welfare facilities routinely and address deficiencies promptly.',
    emergencyResponse:
        'Report welfare-related health concerns immediately. Provide medical support for serious illness and activate emergency arrangements.',
    commonMistakes:
        'Empty water dispensers • Dirty toilets • Poor waste management • Inadequate shade/rest facilities.',
    learningPoint:
        'Worker welfare is an essential part of HSE management, not an optional facility.',
  ),
  _ReferenceTopic(
    key: 'uae_scaffolding',
    regionId: 'uae',
    title: 'Scaffolding Safety',
    description:
        'Safe erection, inspection, access, use and dismantling of scaffolds.',
    definition:
        'A scaffold is a temporary structure providing access and a working platform. It must be designed, erected and used safely for its intended purpose.',
    purpose:
        'Provide stable access and working platforms while preventing falls, collapse and falling-object incidents.',
    hazards:
        'Collapse • Falls • Missing guardrails • Poor foundation • Overloading • Unsafe access • Falling materials.',
    controls:
        'Competent erection • Stable foundation • Guardrails • Toe boards • Safe access • Inspection • Load control.',
    ppe:
        'Safety helmet • Safety footwear • Gloves • Fall protection where required.',
    safePractice:
        'Do not modify scaffolding without authorisation. Inspect before use and after events that may affect stability.',
    checklist:
        'Foundation • Stability • Guardrails • Toe boards • Access • Platform condition • Inspection status • Load limits.',
    supervisorReference:
        'Check physical condition rather than relying only on scaffold tags or paperwork.',
    emergencyResponse:
        'Stop use • Isolate unsafe scaffold • Prevent access • Rescue injured persons safely • Call emergency support where required.',
    commonMistakes:
        'Removing guardrails • Overloading • Improvised access • Unauthorised modifications • Using incomplete scaffold.',
    learningPoint:
        'A scaffold is safe only when its structure, access, platform and protection are all maintained.',
  ),
  _ReferenceTopic(
    key: 'uae_power_tools',
    regionId: 'uae',
    title: 'Power Tools Safety',
    description:
        'Safe selection, inspection and operation of portable power tools.',
    definition:
        'Power tools include electrically, pneumatically, hydraulically or otherwise powered portable tools used for cutting, drilling, grinding and similar work.',
    purpose:
        'Prevent cuts, entanglement, flying particles, electric shock, burns and noise exposure.',
    hazards:
        'Rotating parts • Broken discs • Electric shock • Flying particles • Noise • Dust • Kickback.',
    controls:
        'Correct tool • Pre-use inspection • Guards • Suitable accessories • Electrical protection • Maintenance • Competent operator.',
    ppe:
        'Safety glasses/face shield • Hearing protection • Safety footwear • Suitable gloves where safe and appropriate • Respiratory protection where required.',
    safePractice:
        'Use the correct accessory and operating speed. Never remove guards. Disconnect power before changing accessories.',
    checklist:
        'Tool condition • Guard • Cable • Plug • Accessory • Correct rating • PPE • Operator competence.',
    supervisorReference:
        'Check guards and actual tool condition. Remove defective tools from service.',
    emergencyResponse:
        'Isolate power • Stop the tool • Provide first aid • Call medical support for serious injury • Secure defective equipment.',
    commonMistakes:
        'Removed guards • Wrong disc • Damaged cable • Loose clothing • No eye protection • Improper use.',
    learningPoint:
        'A small power tool can cause serious injury when the correct guard or accessory is missing.',
  ),
  _ReferenceTopic(
    key: 'uae_formwork',
    regionId: 'uae',
    title: 'Formwork Safety',
    description:
        'Safe planning, erection, loading, inspection and stripping of formwork.',
    definition:
        'Formwork is a temporary structure used to support fresh concrete until it gains sufficient strength.',
    purpose:
        'Prevent collapse, falling materials, struck-by incidents and uncontrolled stripping.',
    hazards:
        'Collapse • Overloading • Unstable supports • Falls • Falling materials • Premature stripping.',
    controls:
        'Approved design • Stable supports • Correct erection • Inspection • Controlled concrete placement • Safe stripping sequence.',
    ppe:
        'Safety helmet • Safety footwear • Gloves • Eye protection • Fall protection where required.',
    safePractice:
        'Follow the approved design and erection sequence. Do not alter supports without authorisation.',
    checklist:
        'Design available • Supports stable • Bracing • Access • Inspection • Load control • Concrete placement sequence.',
    supervisorReference:
        'Check supports, bracing, access and changes to the approved arrangement.',
    emergencyResponse:
        'Stop work • Evacuate danger zone • Prevent access • Call emergency support if collapse occurs.',
    commonMistakes:
        'Removing supports early • Unapproved modifications • Overloading • Poor bracing.',
    learningPoint:
        'Temporary structures require the same level of planning and control as permanent structures.',
  ),
  _ReferenceTopic(
    key: 'uae_ptw',
    regionId: 'uae',
    title: 'Permit to Work (PTW)',
    description:
        'Formal control system for specified high-risk activities.',
    definition:
        'A permit-to-work system is a formal process that authorises defined work after hazards, precautions and required controls have been verified.',
    purpose:
        'Prevent uncontrolled high-risk work and ensure responsible persons understand the conditions under which work may proceed.',
    hazards:
        'Energy release • Fire • Gas exposure • Confined space • Electrical work • Excavation • Simultaneous incompatible activities.',
    controls:
        'Task identification • Risk assessment • Isolation • Permit authorisation • Precautions • Toolbox briefing • Monitoring • Close-out.',
    ppe:
        'PPE is determined by the specific permitted task and risk assessment.',
    safePractice:
        'Workers must understand the permit conditions. Stop work when conditions change or permit controls are no longer valid.',
    checklist:
        'Correct permit • Risk assessment • Isolation • Gas test where applicable • Controls • Authorisation • Briefing • Close-out.',
    supervisorReference:
        'Compare the permit with the actual work. Verify controls before allowing work to continue.',
    emergencyResponse:
        'Stop work • Make area safe • Follow emergency plan • Inform permit authority • Call emergency services where required.',
    commonMistakes:
        'Working outside permit scope • Expired permit • Missing isolation • No briefing • Failure to close permit.',
    learningPoint:
        'A permit authorises work only under defined conditions; it does not make an unsafe task safe by itself.',
  ),
  _ReferenceTopic(
    key: 'uae_hot_work',
    regionId: 'uae',
    title: 'Hot Work Safety',
    description:
        'Controls for welding, cutting, grinding and other spark or heat-producing work.',
    definition:
        'Hot work is work that produces flame, heat, sparks or other ignition sources capable of starting a fire or explosion.',
    purpose:
        'Prevent fire, explosion, burns, smoke exposure and damage to nearby equipment.',
    hazards:
        'Sparks • Flames • Molten metal • Gas cylinders • Flammable materials • Vapours • Fire spread.',
    controls:
        'Hot-work permit • Remove combustibles • Fire watch • Fire extinguisher • Gas cylinder control • Screens • Post-work inspection.',
    ppe:
        'Welding helmet/goggles • Welding gloves • Flame-resistant clothing • Safety footwear • Face shield where required.',
    safePractice:
        'Inspect the work area before starting. Protect adjacent areas and maintain fire watch as required.',
    checklist:
        'Permit • Combustibles removed • Extinguisher • Fire watch • Gas cylinders secured • Screens • Post-work inspection.',
    supervisorReference:
        'Check surrounding areas, lower levels, hidden spaces and combustible materials before and after hot work.',
    emergencyResponse:
        'Stop hot work • Raise alarm • Use suitable extinguisher only if trained and safe • Evacuate if fire grows • Call emergency services.',
    commonMistakes:
        'No fire watch • Combustibles nearby • Poor cylinder storage • Grinding without controls • No post-work inspection.',
    learningPoint:
        'Hot-work sparks can travel beyond the immediate work area and ignite hidden combustibles.',
  ),
  _ReferenceTopic(
    key: 'uae_excavation',
    regionId: 'uae',
    title: 'Excavation Safety',
    description:
        'Controls for excavation collapse, underground services, access and falling materials.',
    definition:
        'Excavation safety covers the planning and control of open cuts, trenches and other ground-disturbance activities.',
    purpose:
        'Prevent collapse, burial, falls, service strikes, flooding and vehicle-related incidents.',
    hazards:
        'Ground collapse • Underground utilities • Falling materials • Water ingress • Plant movement • Falls into excavation.',
    controls:
        'Site investigation • Service detection • Ground assessment • Safe slope/shoring • Edge protection • Safe access • Inspection.',
    ppe:
        'Safety helmet • Safety footwear • High-visibility clothing • Gloves • Eye protection • Task-specific PPE.',
    safePractice:
        'Keep spoil and equipment away from edges as required. Provide safe access and inspect excavations after changes or adverse conditions.',
    checklist:
        'Permit where required • Utility information • Ground assessment • Protection system • Access • Edge control • Inspection.',
    supervisorReference:
        'Inspect excavation condition, access, edge loading, water accumulation and protection systems.',
    emergencyResponse:
        'Stop work • Keep people away from unstable ground • Call emergency/rescue services • Do not enter an unstable excavation for rescue.',
    commonMistakes:
        'No shoring/protection • Spoil at edge • Unsafe access • Ignoring cracks or water • Plant too close.',
    learningPoint:
        'Ground conditions can change rapidly. An excavation that was safe earlier may become unsafe later.',
  ),
  _ReferenceTopic(
    key: 'uae_temporary_works',
    regionId: 'uae',
    title: 'Temporary Works',
    description:
        'Planning and control of temporary structures and support systems.',
    definition:
        'Temporary works are structures or systems required temporarily to enable construction, access, support or protection.',
    purpose:
        'Prevent collapse and failure of temporary structures.',
    hazards:
        'Structural failure • Overloading • Poor installation • Unauthorised modification • Inadequate inspection.',
    controls:
        'Design approval • Competent supervision • Installation inspection • Load control • Monitoring • Modification control • Safe removal.',
    ppe:
        'Safety helmet • Safety footwear • Gloves • Fall protection where required.',
    safePractice:
        'Use approved designs and installation sequences. Do not modify temporary works without technical review and authorisation.',
    checklist:
        'Design • Approval • Competent installer • Inspection • Load limits • Monitoring • Modification control • Removal plan.',
    supervisorReference:
        'Verify the installed arrangement matches the approved design.',
    emergencyResponse:
        'Stop work • Evacuate affected area • Prevent access • Notify responsible engineering/HSE personnel • Call emergency services if required.',
    commonMistakes:
        'Unapproved changes • Missing supports • Overloading • No inspection • Poor removal sequence.',
    learningPoint:
        'Temporary does not mean low risk. Failure can have immediate and severe consequences.',
  ),
  _ReferenceTopic(
    key: 'uae_traffic_live_roads',
    regionId: 'uae',
    title: 'Working Near Live Roads',
    description:
        'Protection of workers and road users around active traffic.',
    definition:
        'Working near live roads involves activities where workers, equipment or work zones are exposed to moving public or site traffic.',
    purpose:
        'Prevent vehicle strikes, worker exposure and traffic disruption.',
    hazards:
        'Moving vehicles • Poor visibility • Speed • Lane encroachment • Night work • Pedestrian interaction.',
    controls:
        'Traffic management plan • Barriers • Warning signs • Lighting • Trained flaggers • High-visibility PPE • Safe pedestrian routes.',
    ppe:
        'High-visibility clothing • Safety footwear • Safety helmet • Task-specific PPE.',
    safePractice:
        'Maintain clear separation from traffic. Use approved signs and barriers and ensure workers understand traffic-control arrangements.',
    checklist:
        'Traffic plan • Approved signs • Barriers • Lighting • High-visibility clothing • Safe pedestrian route • Trained personnel.',
    supervisorReference:
        'Check that barriers, signs and traffic routes remain effective throughout the work.',
    emergencyResponse:
        'Stop work • Secure traffic area • Call emergency services for serious incidents • Provide first aid when safe.',
    commonMistakes:
        'Poor signs • Weak barriers • Workers standing in traffic lanes • Inadequate night lighting.',
    learningPoint:
        'Traffic control must account for real driver behaviour, visibility and changing site conditions.',
  ),
  _ReferenceTopic(
    key: 'uae_concreting',
    regionId: 'uae',
    title: 'Concreting Safety',
    description:
        'Safe concrete delivery, pumping, placing, vibration and finishing.',
    definition:
        'Concreting safety covers hazards associated with concrete trucks, pumps, hoses, reinforcement and wet concrete.',
    purpose:
        'Prevent struck-by incidents, hose movement, falls, crushing, skin burns and equipment incidents.',
    hazards:
        'Pump hose movement • Vehicle movement • Wet concrete • Reinforcement • Falls • Pinch points • Equipment pressure.',
    controls:
        'Pump inspection • Hose control • Exclusion zone • Safe access • Reinforcement protection • Communication • Suitable PPE.',
    ppe:
        'Safety helmet • Safety footwear • Gloves • Eye protection • Suitable protective clothing.',
    safePractice:
        'Maintain communication between pump operator and placing team. Keep workers away from uncontrolled hose movement.',
    checklist:
        'Pump inspection • Hose condition • Exclusion zone • Communication • Access • Reinforcement protection • PPE.',
    supervisorReference:
        'Observe hose movement, worker positioning and interaction between concrete equipment and other site activities.',
    emergencyResponse:
        'Stop pump • Isolate equipment where safe • Secure area • Provide first aid • Seek medical support for serious injury.',
    commonMistakes:
        'Standing in hose swing area • Poor communication • Unsafe access • Unprotected reinforcement.',
    learningPoint:
        'Concrete placement combines heavy equipment, pressure, moving vehicles and chemical exposure, so controls must work together.',
  ),
  _ReferenceTopic(
    key: 'uae_barricading',
    regionId: 'uae',
    title: 'Barricading of Hazards',
    description:
        'Use of barriers and warning systems to prevent access to hazardous areas.',
    definition:
        'Barricading is a physical or visual control used to identify and restrict access to an area containing hazards.',
    purpose:
        'Prevent people from entering areas where they may be exposed to falls, moving plant, electrical hazards or other dangers.',
    hazards:
        'Open edges • Excavations • Lifting zones • Electrical areas • Demolition • Restricted work areas.',
    controls:
        'Identify hazard • Select suitable barrier • Warning signs • Restricted access • Visibility • Inspection.',
    ppe:
        'PPE depends on the hazard within the controlled area.',
    safePractice:
        'Barricades should be strong enough for the hazard, clearly visible and maintained throughout the activity.',
    checklist:
        'Hazard identified • Suitable barrier • Warning sign • Access controlled • Visibility • Inspection • Removal after hazard ends.',
    supervisorReference:
        'Check whether the barrier actually prevents access rather than merely indicating the hazard.',
    emergencyResponse:
        'Keep people outside the hazard area • Raise alarm • Follow emergency arrangements • Do not cross the barricade without authorisation.',
    commonMistakes:
        'Weak tape for serious hazards • Missing signs • Broken barriers • Leaving obsolete barricades.',
    learningPoint:
        'A barricade is effective only when it matches the seriousness of the hazard and controls access.',
  ),
  _ReferenceTopic(
    key: 'uae_forklift',
    regionId: 'uae',
    title: 'Safe Forklift Operations',
    description:
        'Safe operation, loading and pedestrian control for forklifts.',
    definition:
        'Forklift safety covers the operation of powered industrial trucks used to lift, carry and position materials.',
    purpose:
        'Prevent overturning, dropped loads, collisions and pedestrian injuries.',
    hazards:
        'Overturning • Falling loads • Reversing • Blind spots • Speed • Poor load stability • Untrained operators.',
    controls:
        'Competent operators • Pre-use checks • Safe loads • Speed control • Pedestrian segregation • Seat belt • Safe parking.',
    ppe:
        'Safety footwear • High-visibility clothing • Safety helmet where required • Seat belt.',
    safePractice:
        'Keep loads stable and within rated capacity. Travel with the load positioned safely and maintain visibility.',
    checklist:
        'Operator competence • Pre-use inspection • Load within capacity • Seat belt • Horn/lights • Pedestrian route • Parking.',
    supervisorReference:
        'Observe actual driving and load handling. Verify that pedestrians are separated where practicable.',
    emergencyResponse:
        'Stop equipment • Secure area • Call emergency services for serious incidents • Do not move unstable loads unnecessarily.',
    commonMistakes:
        'Overloading • Carrying passengers • Speeding • Raised forks while travelling • Unauthorised operation.',
    learningPoint:
        'A forklift is a powerful mobile machine and must be treated as such at all times.',
  ),
  _ReferenceTopic(
    key: 'uae_audit',
    regionId: 'uae',
    title: 'Audit & Inspection',
    description:
        'Systematic verification of HSE controls and workplace conditions.',
    definition:
        'Inspection is a routine check of physical conditions and controls, while an audit systematically evaluates whether a management system or process meets defined requirements.',
    purpose:
        'Identify deficiencies, verify controls and improve HSE performance.',
    hazards:
        'Unidentified unsafe conditions • Repeated findings • Poor close-out • Inadequate management controls.',
    controls:
        'Inspection plan • Competent inspectors • Clear findings • Corrective actions • Close-out • Trend analysis • Management review.',
    ppe:
        'PPE appropriate to the inspection area and hazards.',
    safePractice:
        'Record factual findings, identify responsible persons and establish realistic close-out dates.',
    checklist:
        'Inspection scope • Competent inspector • Evidence • Findings • Action owner • Due date • Verification • Close-out.',
    supervisorReference:
        'Look for repeat findings and weak corrective actions rather than only counting observations.',
    emergencyResponse:
        'Immediately escalate serious or imminent danger. Stop affected work where necessary and implement urgent controls.',
    commonMistakes:
        'Paper-only inspections • Vague findings • No owner • No close-out • Repeating same observation.',
    learningPoint:
        'The value of an inspection is measured by the improvement it produces, not the number of forms completed.',
  ),
];

// ============================================================================
// DUBAI TOPICS
// ============================================================================

const List<_ReferenceTopic> _dubaiTopics = [
  _ReferenceTopic(
    key: 'dubai_hse_framework',
    regionId: 'dubai',
    title: 'Dubai HSE Framework',
    description:
        'General reference for managing HSE risks in Dubai workplaces and construction activities.',
    definition:
        'An HSE framework provides the management structure used to identify hazards, establish responsibilities, implement controls and monitor performance.',
    purpose:
        'Help organisations manage workplace risks systematically and comply with applicable Dubai requirements.',
    hazards:
        'Poor planning • Unclear responsibilities • Weak supervision • Inadequate risk assessment • Poor contractor control.',
    controls:
        'Leadership • Responsibility • Risk management • Competence • Communication • Inspection • Incident management • Continual improvement.',
    ppe:
        'PPE must be selected based on the specific work activity and risk assessment.',
    safePractice:
        'Establish clear HSE responsibilities and ensure site controls are implemented and monitored.',
    checklist:
        'HSE plan • Responsibilities • Risk assessment • Training • Inspections • Emergency plan • Incident reporting.',
    supervisorReference:
        'Verify that management arrangements are visible in actual site conditions.',
    emergencyResponse:
        'Follow the approved emergency plan and contact applicable emergency authorities.',
    commonMistakes:
        'Paper compliance • Weak supervision • Poor contractor coordination • Unclosed findings.',
    learningPoint:
        'An HSE framework should control real risks, not simply produce documentation.',
  ),
  _ReferenceTopic(
    key: 'dubai_municipality',
    regionId: 'dubai',
    title: 'Dubai Municipality Safety',
    description:
        'Reference area for safety considerations associated with applicable Dubai Municipality requirements.',
    definition:
        'Dubai Municipality-related requirements may apply to construction, buildings, environmental activities and other regulated areas depending on the project and activity.',
    purpose:
        'Help users identify when Dubai Municipality requirements may be relevant and encourage verification of current requirements.',
    hazards:
        'Non-compliant construction practices • Unsafe temporary works • Environmental impacts • Poor site controls.',
    controls:
        'Identify applicable requirements • Use approved drawings/procedures • Maintain records • Conduct inspections • Correct deficiencies.',
    ppe:
        'Task-specific PPE based on risk assessment and work activity.',
    safePractice:
        'Always verify the latest authority requirements applicable to the project rather than relying on old documents.',
    checklist:
        'Applicable authority identified • Current requirement checked • Approved documents • Site inspection • Records.',
    supervisorReference:
        'Check that field practices align with approved project documents and applicable authority requirements.',
    emergencyResponse:
        'Follow site emergency procedures and contact the appropriate emergency authority.',
    commonMistakes:
        'Using outdated requirements • Assuming one requirement applies to every project • Poor document control.',
    learningPoint:
        'Authority requirements can vary by activity; verify the current requirement before making compliance decisions.',
  ),
  _ReferenceTopic(
    key: 'dubai_construction',
    regionId: 'dubai',
    title: 'Construction Safety in Dubai',
    description:
        'Practical construction HSE controls for Dubai projects.',
    definition:
        'Construction safety covers the identification and control of hazards generated by construction activities, temporary works, plant, people and changing site conditions.',
    purpose:
        'Prevent injuries, occupational illness, property damage and environmental incidents during construction.',
    hazards:
        'Falls • Excavation • Lifting • Plant • Electrical • Temporary works • Hot work • Traffic • Dust • Heat.',
    controls:
        'Planning • Risk assessment • Method statements • Competent supervision • Inspection • Permit systems • Worker consultation.',
    ppe:
        'Helmet • Safety footwear • High-visibility clothing • Eye protection • Gloves • Task-specific PPE.',
    safePractice:
        'Coordinate simultaneous activities and update controls as the project progresses.',
    checklist:
        'Site induction • Risk assessment • Method statement • Access • Plant inspection • Temporary works • Emergency arrangements.',
    supervisorReference:
        'Focus on interfaces between trades, plant and changing site conditions.',
    emergencyResponse:
        'Stop affected work, secure the area and activate the site emergency response.',
    commonMistakes:
        'Poor housekeeping • Uncontrolled interfaces • Inadequate access • Weak supervision.',
    learningPoint:
        'Construction sites change every day; HSE controls must change with them.',
  ),
  _ReferenceTopic(
    key: 'dubai_risk',
    regionId: 'dubai',
    title: 'Health & Safety Risk Assessment',
    description:
        'Risk assessment applied to Dubai workplace and construction activities.',
    definition:
        'A risk assessment evaluates hazards associated with a task and identifies controls needed to prevent harm.',
    purpose:
        'Ensure hazards are controlled before work begins and whenever conditions change.',
    hazards:
        'Falls • Plant • Electrical • Lifting • Chemicals • Traffic • Heat • Simultaneous work.',
    controls:
        'Hazard identification • Risk rating • Hierarchy of controls • Worker consultation • Review.',
    ppe:
        'Task-specific PPE based on the assessment.',
    safePractice:
        'Use activity-specific assessments rather than copying generic documents.',
    checklist:
        'Task defined • Hazards identified • Controls selected • Workers briefed • Review completed.',
    supervisorReference:
        'Compare the assessment with the actual work sequence.',
    emergencyResponse:
        'Stop work and activate the applicable emergency arrangements for serious hazards.',
    commonMistakes:
        'Generic assessments • No worker involvement • Failure to update.',
    learningPoint:
        'Risk assessment should be a living process.',
  ),
  _ReferenceTopic(
    key: 'dubai_work_height',
    regionId: 'dubai',
    title: 'Working at Height',
    description:
        'Fall prevention and protection for Dubai construction and workplace activities.',
    definition:
        'Work at height includes activities where a person could fall from an elevated position.',
    purpose:
        'Prevent falls and falling-object incidents.',
    hazards:
        'Open edges • Scaffolds • Ladders • Roofs • Fragile surfaces • Falling tools.',
    controls:
        'Avoid • Guardrails • Edge protection • Safe platforms • Fall protection • Rescue planning.',
    ppe:
        'Helmet with chin strap where required • Safety footwear • Harness where required.',
    safePractice:
        'Use inspected access equipment and maintain protection throughout the activity.',
    checklist:
        'Access • Guardrails • Platform • Harness if required • Anchorage • Rescue plan.',
    supervisorReference:
        'Inspect edges and access physically before work.',
    emergencyResponse:
        'Activate rescue plan and contact emergency medical support.',
    commonMistakes:
        'Improvised platforms • Missing edge protection • Wrong anchorage.',
    learningPoint:
        'Prevent the fall before relying on fall arrest.',
  ),
  _ReferenceTopic(
    key: 'dubai_scaffolding',
    regionId: 'dubai',
    title: 'Scaffolding Safety',
    description:
        'Safe scaffold erection, inspection and use.',
    definition:
        'Scaffolding provides temporary working platforms and access and requires suitable design, erection and inspection.',
    purpose:
        'Prevent falls, collapse and falling objects.',
    hazards:
        'Collapse • Missing guardrails • Overloading • Poor access • Unstable base.',
    controls:
        'Competent erection • Stable base • Guardrails • Toe boards • Access • Inspection.',
    ppe:
        'Helmet • Safety footwear • Gloves • Harness where required.',
    safePractice:
        'Do not alter scaffold components without authorisation.',
    checklist:
        'Foundation • Guardrails • Toe boards • Access • Inspection • Load control.',
    supervisorReference:
        'Check physical condition and completeness.',
    emergencyResponse:
        'Stop use and isolate unsafe scaffold.',
    commonMistakes:
        'Removing protection • Overloading • Unauthorised changes.',
    learningPoint:
        'Scaffold integrity must be maintained throughout its use.',
  ),
  _ReferenceTopic(
    key: 'dubai_excavation',
    regionId: 'dubai',
    title: 'Excavation Safety',
    description:
        'Controls for trenches, excavations and ground disturbance.',
    definition:
        'Excavation safety manages collapse, underground services, falls, plant interaction and water-related hazards.',
    purpose:
        'Prevent burial, falls and service strikes.',
    hazards:
        'Collapse • Utilities • Falling materials • Plant • Water.',
    controls:
        'Service detection • Ground assessment • Shoring/slope • Access • Edge protection • Inspection.',
    ppe:
        'Helmet • Safety footwear • High-visibility clothing • Gloves • Eye protection.',
    safePractice:
        'Inspect excavation conditions regularly and after changes.',
    checklist:
        'Service information • Ground assessment • Protection • Access • Edge control • Inspection.',
    supervisorReference:
        'Check spoil, plant and personnel positioning.',
    emergencyResponse:
        'Keep people away from unstable ground and activate rescue arrangements.',
    commonMistakes:
        'No support system • Spoil too close • Unsafe access.',
    learningPoint:
        'Excavation conditions can deteriorate rapidly.',
  ),
  _ReferenceTopic(
    key: 'dubai_lifting',
    regionId: 'dubai',
    title: 'Lifting Operations',
    description:
        'Safe planning and control of cranes, lifting equipment and suspended loads.',
    definition:
        'Lifting operations involve moving loads using cranes, hoists or other lifting equipment.',
    purpose:
        'Prevent dropped loads, collisions and equipment failure.',
    hazards:
        'Dropped loads • Overload • Poor rigging • Wind • Suspended loads • Poor communication.',
    controls:
        'Lift plan • Competent team • Certified equipment • Inspection • Exclusion zone • Communication.',
    ppe:
        'Helmet • Safety footwear • High-visibility clothing • Gloves.',
    safePractice:
        'Never stand beneath suspended loads and verify load capacity before lifting.',
    checklist:
        'Plan • Equipment • Accessories • Load • Ground • Exclusion zone • Communication.',
    supervisorReference:
        'Verify lifting accessories and exclusion controls.',
    emergencyResponse:
        'Stop lifting and secure the area.',
    commonMistakes:
        'Improvised slings • No exclusion zone • Overloading.',
    learningPoint:
        'Good lifting starts before the crane moves.',
  ),
  _ReferenceTopic(
    key: 'dubai_forklift',
    regionId: 'dubai',
    title: 'Safe Forklift Operations',
    description:
        'Forklift operator, load and pedestrian safety.',
    definition:
        'Forklifts are powered industrial trucks used for material handling and require trained operation.',
    purpose:
        'Prevent collisions, overturning and dropped loads.',
    hazards:
        'Reversing • Blind spots • Overload • Unstable loads • Speed.',
    controls:
        'Competent operator • Pre-use check • Capacity control • Seat belt • Speed control • Segregation.',
    ppe:
        'Safety footwear • High-visibility clothing • Helmet where required.',
    safePractice:
        'Keep loads stable and drive according to site controls.',
    checklist:
        'Operator • Inspection • Capacity • Seat belt • Route • Pedestrian control.',
    supervisorReference:
        'Observe real operation and pedestrian interaction.',
    emergencyResponse:
        'Stop equipment and secure the area.',
    commonMistakes:
        'Passengers • Speeding • Overloading • Raised forks while travelling.',
    learningPoint:
        'Forklift incidents are often predictable and preventable.',
  ),
  _ReferenceTopic(
    key: 'dubai_machinery',
    regionId: 'dubai',
    title: 'Machinery Safety',
    description:
        'Controls for moving machinery, guards, maintenance and isolation.',
    definition:
        'Machinery safety protects workers from moving parts, stored energy and unexpected machine movement.',
    purpose:
        'Prevent crushing, entanglement, cutting and amputation injuries.',
    hazards:
        'Moving parts • Stored energy • Missing guards • Unexpected start-up • Maintenance exposure.',
    controls:
        'Guarding • Isolation • Emergency stops • Competent operators • Maintenance • Inspection.',
    ppe:
        'Eye protection • Safety footwear • Hearing protection • Helmet • Task-specific PPE.',
    safePractice:
        'Never bypass safety guards or reach into moving equipment.',
    checklist:
        'Guarding • Emergency stop • Isolation • Inspection • Competence.',
    supervisorReference:
        'Check guarding and maintenance activities.',
    emergencyResponse:
        'Stop/isolate machine if safe and activate emergency response.',
    commonMistakes:
        'Bypassing guards • Cleaning while moving • Unauthorised maintenance.',
    learningPoint:
        'Machine guards are engineered controls and should never be casually removed.',
  ),
  _ReferenceTopic(
    key: 'dubai_electrical',
    regionId: 'dubai',
    title: 'Electrical Safety',
    description:
        'Safe temporary and permanent electrical work.',
    definition:
        'Electrical safety controls exposure to live electrical energy and electrical equipment hazards.',
    purpose:
        'Prevent shock, burns and electrical fires.',
    hazards:
        'Live parts • Damaged cables • Overloading • Wet conditions • Poor connections.',
    controls:
        'Isolation • Competent persons • Inspection • Protection devices • Cable management • Controlled access.',
    ppe:
        'Electrical-rated PPE where required • Eye protection • Safety footwear.',
    safePractice:
        'Isolate and verify before working on electrical systems.',
    checklist:
        'Isolation • Inspection • Protection • Earthing • RCD/GFCI where applicable.',
    supervisorReference:
        'Check temporary distribution systems and cables.',
    emergencyResponse:
        'Isolate power safely before approaching a casualty and call emergency services.',
    commonMistakes:
        'Damaged cables • Improvised connections • Bypassed protection.',
    learningPoint:
        'Electrical safety depends on competent work and effective isolation.',
  ),
  _ReferenceTopic(
    key: 'dubai_traffic',
    regionId: 'dubai',
    title: 'Traffic Management',
    description:
        'Control of vehicles, pedestrians and site traffic routes.',
    definition:
        'Traffic management is the organised control of vehicle and pedestrian movement within and around work areas.',
    purpose:
        'Prevent vehicle collisions and pedestrian strikes.',
    hazards:
        'Reversing • Blind spots • Speed • Congestion • Poor signs.',
    controls:
        'Traffic plan • Segregation • Speed control • Signs • Lighting • Trained personnel.',
    ppe:
        'High-visibility clothing • Safety footwear • Helmet where required.',
    safePractice:
        'Use designated routes and separate people from vehicles wherever practicable.',
    checklist:
        'Traffic plan • Routes • Barriers • Signs • Lighting • Driver controls.',
    supervisorReference:
        'Observe traffic during peak activity, not only during quiet periods.',
    emergencyResponse:
        'Stop traffic and secure the incident area.',
    commonMistakes:
        'Poor segregation • Excess speed • Poor visibility.',
    learningPoint:
        'Traffic arrangements must work in real conditions, not just on a drawing.',
  ),
  _ReferenceTopic(
    key: 'dubai_heat',
    regionId: 'dubai',
    title: 'Heat Stress Management',
    description:
        'Heat illness prevention for Dubai outdoor and high-temperature work.',
    definition:
        'Heat stress occurs when the body cannot adequately dissipate heat generated by the environment and physical work.',
    purpose:
        'Prevent dehydration, heat exhaustion and heat stroke.',
    hazards:
        'Heat • Humidity • Sun • Heavy work • Dehydration • Poor acclimatization.',
    controls:
        'Water • Rest • Shade • Work planning • Acclimatization • Monitoring • Awareness.',
    ppe:
        'Suitable clothing • Safety footwear • Head protection • Task-specific PPE.',
    safePractice:
        'Plan demanding tasks appropriately and encourage early reporting of symptoms.',
    checklist:
        'Water • Shade • Rest • Acclimatization • Monitoring • Emergency response.',
    supervisorReference:
        'Watch workers for early symptoms and intervene promptly.',
    emergencyResponse:
        'Move affected worker to a cool area, cool the person and obtain medical support for serious symptoms.',
    commonMistakes:
        'Ignoring symptoms • Poor hydration • No rest/shade.',
    learningPoint:
        'Heat illness can progress rapidly and requires early action.',
  ),
  _ReferenceTopic(
    key: 'dubai_fire',
    regionId: 'dubai',
    title: 'Fire Safety',
    description:
        'Fire prevention and emergency protection for Dubai workplaces.',
    definition:
        'Fire safety controls ignition sources, fuel, fire spread, detection, evacuation and emergency response.',
    purpose:
        'Protect people and property from fire.',
    hazards:
        'Hot work • Flammables • Electrical faults • Gas • Poor housekeeping.',
    controls:
        'Fire prevention • Extinguishers • Alarm • Emergency routes • Hot-work controls • Training.',
    ppe:
        'Task-specific PPE and fire-resistant PPE where applicable.',
    safePractice:
        'Keep escape routes clear and control ignition sources.',
    checklist:
        'Extinguishers • Exits • Alarm • Hot work • Housekeeping • Assembly point.',
    supervisorReference:
        'Check fire controls and combustible storage.',
    emergencyResponse:
        'Raise alarm, evacuate and contact emergency services.',
    commonMistakes:
        'Blocked exits • Poor housekeeping • Uncontrolled hot work.',
    learningPoint:
        'Fire safety begins with prevention.',
  ),
  _ReferenceTopic(
    key: 'dubai_confined',
    regionId: 'dubai',
    title: 'Confined Space Safety',
    description:
        'Safe entry and work in confined or restricted spaces.',
    definition:
        'Confined spaces may present atmospheric, access, engulfment and emergency hazards.',
    purpose:
        'Prevent serious injury and fatalities during entry.',
    hazards:
        'Low oxygen • Toxic gases • Flammable atmosphere • Engulfment • Restricted rescue.',
    controls:
        'Assessment • Permit • Isolation • Gas testing • Ventilation • Attendant • Rescue.',
    ppe:
        'Helmet • Safety footwear • Gloves • Eye protection • Respiratory protection where required • Harness where required.',
    safePractice:
        'Never enter without required controls and rescue arrangements.',
    checklist:
        'Permit • Isolation • Testing • Ventilation • Attendant • Rescue.',
    supervisorReference:
        'Verify gas testing and rescue readiness.',
    emergencyResponse:
        'Never conduct uncontrolled rescue entry. Activate trained rescue arrangements.',
    commonMistakes:
        'No gas testing • No attendant • Improvised rescue.',
    learningPoint:
        'A confined space can become fatal before a worker realises there is a problem.',
  ),
  _ReferenceTopic(
    key: 'dubai_ppe',
    regionId: 'dubai',
    title: 'PPE Requirements',
    description:
        'Task-based PPE selection and use.',
    definition:
        'PPE is protective equipment selected to reduce residual risk after other controls are considered.',
    purpose:
        'Provide personal protection from remaining hazards.',
    hazards:
        'Impact • Chemicals • Noise • Dust • Eye hazards • Foot hazards.',
    controls:
        'Hazard identification • Correct selection • Fit • Training • Inspection • Maintenance.',
    ppe:
        'Helmet • Safety footwear • Eye protection • Gloves • High-visibility clothing • Hearing/respiratory protection where required.',
    safePractice:
        'Use PPE according to risk assessment and manufacturer instructions.',
    checklist:
        'Correct PPE • Fit • Condition • Training • Compatibility.',
    supervisorReference:
        'Verify actual PPE use and condition.',
    emergencyResponse:
        'Remove exposure safely and follow emergency arrangements.',
    commonMistakes:
        'Wrong PPE • Poor fit • Damaged equipment.',
    learningPoint:
        'PPE is effective only when correctly selected and used.',
  ),
  _ReferenceTopic(
    key: 'dubai_waste',
    regionId: 'dubai',
    title: 'Waste Management',
    description:
        'Safe segregation, storage, handling and disposal of workplace waste.',
    definition:
        'Waste management involves controlling waste from generation through segregation, storage, transport and disposal.',
    purpose:
        'Prevent injury, pollution, fire and poor housekeeping.',
    hazards:
        'Sharp waste • Chemicals • Fire • Spill • Poor segregation.',
    controls:
        'Segregation • Suitable containers • Labels • Storage • Safe handling • Appropriate disposal.',
    ppe:
        'Gloves • Safety footwear • Eye protection • Task-specific PPE.',
    safePractice:
        'Keep waste containers suitable, closed where required and clearly identified.',
    checklist:
        'Segregation • Containers • Labels • Storage • Collection • Housekeeping.',
    supervisorReference:
        'Check waste accumulation and incompatible waste storage.',
    emergencyResponse:
        'Control spills if safe and activate emergency environmental procedures where required.',
    commonMistakes:
        'Mixed waste • Overflowing containers • Unlabelled hazardous waste.',
    learningPoint:
        'Good waste management protects both people and the environment.',
  ),
];

// ============================================================================
// ABU DHABI TOPICS
// ============================================================================

const List<_ReferenceTopic> _abuDhabiTopics = [
  _ReferenceTopic(
    key: 'adosh_what_is',
    regionId: 'abu_dhabi',
    title: 'What is ADOSH?',
    description:
        'Introduction to the Abu Dhabi Occupational Safety and Health system.',
    definition:
        'ADOSH refers to the Abu Dhabi Occupational Safety and Health framework and system used to establish and manage occupational safety and health requirements in Abu Dhabi.',
    purpose:
        'Help organisations understand their OSH responsibilities and establish effective occupational safety and health management arrangements.',
    hazards:
        'Unmanaged workplace hazards • Weak OSH systems • Poor competence • Inadequate risk controls • Poor reporting.',
    controls:
        'Understand applicable requirements • Establish OSH responsibilities • Risk management • Training • Monitoring • Reporting.',
    ppe:
        'PPE depends on the workplace hazard and applicable task requirements.',
    safePractice:
        'Use current official ADOSH-SF requirements and applicable Codes of Practice when determining compliance.',
    checklist:
        'Applicable requirement identified • OSH responsibilities • Risk assessment • Training • Inspection • Reporting.',
    supervisorReference:
        'Ensure site practices reflect the organisation’s approved OSH arrangements.',
    emergencyResponse:
        'Follow the approved emergency plan and applicable authority reporting arrangements.',
    commonMistakes:
        'Using outdated references • Treating ADOSH as only paperwork • Poor field implementation.',
    learningPoint:
        'Understanding the OSH system helps supervisors connect site activities with management responsibilities.',
  ),
  _ReferenceTopic(
    key: 'adosh_overview',
    regionId: 'abu_dhabi',
    title: 'ADOSH-SF Overview',
    description:
        'Learning reference for the Abu Dhabi Occupational Safety and Health System Framework.',
    definition:
        'ADOSH-SF provides a structured occupational safety and health framework with requirements and supporting Codes of Practice for applicable activities.',
    purpose:
        'Provide a consistent approach to managing OSH risks and responsibilities in Abu Dhabi.',
    hazards:
        'Non-compliance • Inadequate risk management • Weak monitoring • Poor worker competence.',
    controls:
        'Identify applicable requirements • Review relevant Codes of Practice • Establish OSH arrangements • Monitor performance • Maintain records.',
    ppe:
        'PPE is determined by the specific hazard and applicable requirements.',
    safePractice:
        'Use the latest applicable official framework and Codes of Practice rather than relying on old copies.',
    checklist:
        'Applicable CoP identified • Current version checked • Responsibilities assigned • Controls implemented • Records maintained.',
    supervisorReference:
        'Check whether site controls reflect applicable OSH requirements.',
    emergencyResponse:
        'Follow site emergency arrangements and applicable incident notification requirements.',
    commonMistakes:
        'Using obsolete documents • Applying unrelated requirements • Poor document control.',
    learningPoint:
        'A Code of Practice should be understood in context and applied to the actual work activity.',
  ),
  _ReferenceTopic(
    key: 'adosh_risk',
    regionId: 'abu_dhabi',
    title: 'Risk Management',
    description:
        'Systematic management of occupational safety and health risks.',
    definition:
        'Risk management is the process of identifying hazards, evaluating risk, implementing controls and monitoring effectiveness.',
    purpose:
        'Prevent harm by ensuring hazards are systematically controlled.',
    hazards:
        'Construction hazards • Plant • Chemicals • Electricity • Work at height • Heat • Traffic.',
    controls:
        'Hazard identification • Risk evaluation • Hierarchy of controls • Worker involvement • Monitoring • Review.',
    ppe:
        'Task-specific PPE based on residual risk.',
    safePractice:
        'Review controls when the activity, equipment, environment or people change.',
    checklist:
        'Hazards • Risk rating • Controls • Responsibilities • Briefing • Review.',
    supervisorReference:
        'Verify controls in the field.',
    emergencyResponse:
        'Stop unsafe work and activate emergency procedures for serious risks.',
    commonMistakes:
        'Generic assessment • No review • Weak control verification.',
    learningPoint:
        'Risk management is continuous—not a one-time document.',
  ),
  _ReferenceTopic(
    key: 'adosh_construction',
    regionId: 'abu_dhabi',
    title: 'OSH Management During Construction',
    description:
        'Managing OSH risks throughout construction activities.',
    definition:
        'Construction OSH management coordinates planning, risk control, competence, supervision, inspection and incident management.',
    purpose:
        'Prevent injuries and occupational illness throughout changing construction activities.',
    hazards:
        'Falls • Lifting • Excavation • Temporary works • Traffic • Electrical • Hot work.',
    controls:
        'Planning • Risk assessment • Method statements • Competent supervision • Inspection • Worker consultation.',
    ppe:
        'Helmet • Safety footwear • High-visibility clothing • Eye protection • Gloves • Task-specific PPE.',
    safePractice:
        'Coordinate subcontractors and review interfaces between simultaneous activities.',
    checklist:
        'HSE plan • Risk assessments • Method statements • Competence • Inspections • Emergency plan.',
    supervisorReference:
        'Focus on changing conditions and interfaces.',
    emergencyResponse:
        'Activate project emergency arrangements and report incidents according to applicable procedures.',
    commonMistakes:
        'Poor coordination • Inadequate supervision • Outdated assessments.',
    learningPoint:
        'Construction OSH management must evolve with project phases.',
  ),
  _ReferenceTopic(
    key: 'adosh_ppe',
    regionId: 'abu_dhabi',
    title: 'Personal Protective Equipment',
    description:
        'Risk-based PPE selection and management in Abu Dhabi workplaces.',
    definition:
        'PPE provides personal protection against residual workplace hazards after considering other controls.',
    purpose:
        'Reduce exposure to injury and occupational health hazards.',
    hazards:
        'Impact • Chemical exposure • Noise • Dust • Falls • Electrical hazards.',
    controls:
        'Hazard assessment • Correct PPE • Fit • Training • Inspection • Maintenance.',
    ppe:
        'Helmet • Safety footwear • Eye protection • Gloves • Hearing protection • Respiratory/fall protection where required.',
    safePractice:
        'Select PPE based on task and applicable requirements and ensure compatibility.',
    checklist:
        'Selection • Fit • Condition • Training • Inspection • Replacement.',
    supervisorReference:
        'Check actual PPE use and suitability.',
    emergencyResponse:
        'Remove exposure safely and seek appropriate medical support.',
    commonMistakes:
        'Wrong PPE • Poor fit • Damaged equipment.',
    learningPoint:
        'PPE is one part of a wider control strategy.',
  ),
  _ReferenceTopic(
    key: 'adosh_noise',
    regionId: 'abu_dhabi',
    title: 'Occupational Noise',
    description:
        'Management of workplace noise exposure.',
    definition:
        'Occupational noise is unwanted or excessive sound that can affect hearing and worker wellbeing.',
    purpose:
        'Prevent noise-induced hearing damage and reduce harmful exposure.',
    hazards:
        'High noise levels • Continuous exposure • Impact noise • Poor maintenance • Multiple noise sources.',
    controls:
        'Noise assessment • Engineering controls • Administrative controls • Hearing protection • Monitoring.',
    ppe:
        'Suitable hearing protection • Safety helmet • Safety footwear • Task-specific PPE.',
    safePractice:
        'Reduce noise at source where practicable before relying on hearing protection.',
    checklist:
        'Noise assessed • Sources identified • Engineering control • Exposure time • Hearing protection • Monitoring.',
    supervisorReference:
        'Check workers in designated noisy areas and verify controls.',
    emergencyResponse:
        'Remove worker from excessive exposure and arrange assessment if acute exposure or injury occurs.',
    commonMistakes:
        'Relying only on earplugs • Poor fit • No noise assessment.',
    learningPoint:
        'Noise damage is often permanent and preventable.',
  ),
  _ReferenceTopic(
    key: 'adosh_vibration',
    regionId: 'abu_dhabi',
    title: 'Vibration',
    description:
        'Control of hand-arm and whole-body vibration exposure.',
    definition:
        'Vibration exposure occurs when workers use vibrating tools or operate equipment transmitting vibration to the body.',
    purpose:
        'Reduce health effects associated with excessive vibration exposure.',
    hazards:
        'Power tools • Heavy equipment • Long exposure duration • Poor equipment maintenance.',
    controls:
        'Exposure assessment • Equipment selection • Maintenance • Reduced exposure time • Job rotation where suitable • Monitoring.',
    ppe:
        'Task-specific PPE and suitable gloves where appropriate.',
    safePractice:
        'Use low-vibration equipment where practicable and maintain tools properly.',
    checklist:
        'Exposure identified • Equipment condition • Duration controlled • Maintenance • Worker awareness.',
    supervisorReference:
        'Observe exposure duration and equipment condition.',
    emergencyResponse:
        'Stop exposure and seek occupational health assessment for concerning symptoms.',
    commonMistakes:
        'Long continuous exposure • Poor maintenance • Assuming gloves eliminate vibration risk.',
    learningPoint:
        'Reducing vibration at source is more effective than relying solely on PPE.',
  ),
  _ReferenceTopic(
    key: 'adosh_first_aid',
    regionId: 'abu_dhabi',
    title: 'First Aid & Medical Emergency',
    description:
        'Workplace first-aid and medical emergency arrangements.',
    definition:
        'First-aid arrangements provide immediate assistance while medical emergency arrangements provide escalation to professional medical care.',
    purpose:
        'Protect life and reduce the severity of injury or illness.',
    hazards:
        'Trauma • Burns • Heat illness • Chemical exposure • Electrical injury • Falls.',
    controls:
        'First-aid facilities • Trained personnel • Emergency communication • Medical access • Clear procedures.',
    ppe:
        'Gloves • Eye protection • Task-specific PPE for the responder.',
    safePractice:
        'Make the scene safe before intervention and remain within your level of competence.',
    checklist:
        'First-aid box • Trained person • Emergency contact • Access • Medical arrangements • Records.',
    supervisorReference:
        'Verify availability and accessibility of first-aid arrangements.',
    emergencyResponse:
        'Raise alarm • Call emergency medical support • Provide appropriate first aid • Keep access clear for responders.',
    commonMistakes:
        'Delayed emergency call • Unsafe rescue • Empty first-aid supplies.',
    learningPoint:
        'Emergency response should be rehearsed before an emergency occurs.',
  ),
  _ReferenceTopic(
    key: 'adosh_hazardous_materials',
    regionId: 'abu_dhabi',
    title: 'Hazardous Materials',
    description:
        'Control of hazardous substances used or stored at work.',
    definition:
        'Hazardous materials are substances that can cause injury, illness, fire, explosion or environmental harm.',
    purpose:
        'Prevent exposure and uncontrolled release.',
    hazards:
        'Toxicity • Corrosivity • Flammability • Vapours • Reactive substances.',
    controls:
        'SDS • Labelling • Storage • Ventilation • PPE • Spill control • Training • Disposal.',
    ppe:
        'Chemical-resistant gloves • Eye/face protection • Protective clothing • Respiratory protection where required.',
    safePractice:
        'Understand the chemical before use and follow SDS and approved procedures.',
    checklist:
        'SDS • Label • Storage • PPE • Spill kit • Ventilation • Disposal.',
    supervisorReference:
        'Inspect chemical storage and worker practices.',
    emergencyResponse:
        'Isolate area • Prevent exposure • Follow SDS • Contact emergency support for serious releases.',
    commonMistakes:
        'Unlabelled containers • Incompatible storage • Wrong PPE.',
    learningPoint:
        'Chemical controls begin before the container is opened.',
  ),
  _ReferenceTopic(
    key: 'adosh_asbestos',
    regionId: 'abu_dhabi',
    title: 'Asbestos Management',
    description:
        'Controls for preventing exposure to asbestos fibres.',
    definition:
        'Asbestos management involves identifying asbestos-containing materials and controlling activities that could release hazardous fibres.',
    purpose:
        'Prevent occupational exposure to asbestos fibres and associated long-term health effects.',
    hazards:
        'Fibre release • Cutting • Drilling • Demolition • Poor containment • Uncontrolled removal.',
    controls:
        'Survey • Identification • Restricted access • Competent contractor • Controlled removal • Monitoring where required • Waste control.',
    ppe:
        'Specialist respiratory protection • Protective clothing • Gloves • Eye protection as required.',
    safePractice:
        'Do not disturb suspected asbestos-containing material. Stop work and obtain competent assessment.',
    checklist:
        'Survey • Material identified • Area controlled • Competent contractor • Method • PPE • Waste arrangements.',
    supervisorReference:
        'Stop unplanned disturbance of suspected asbestos materials.',
    emergencyResponse:
        'Stop work • Isolate area • Prevent spread • Notify responsible personnel • Obtain specialist advice.',
    commonMistakes:
        'Drilling unknown materials • Poor containment • Ordinary dust mask used as a substitute for specialist controls.',
    learningPoint:
        'Never assume an unknown building material is safe to disturb.',
  ),
  _ReferenceTopic(
    key: 'adosh_lead',
    regionId: 'abu_dhabi',
    title: 'Lead Exposure',
    description:
        'Control of occupational exposure to lead and lead-containing materials.',
    definition:
        'Lead exposure can occur through inhalation or ingestion of lead-containing dust, fumes or contaminated material.',
    purpose:
        'Prevent harmful occupational exposure and associated health effects.',
    hazards:
        'Lead dust • Fumes • Contaminated surfaces • Poor hygiene • Cutting/grinding lead-containing materials.',
    controls:
        'Exposure assessment • Engineering controls • Hygiene • PPE • Monitoring • Worker awareness • Medical surveillance where applicable.',
    ppe:
        'Respiratory protection where required • Gloves • Protective clothing • Eye protection.',
    safePractice:
        'Control dust at source and maintain strict hygiene to prevent ingestion.',
    checklist:
        'Material identified • Exposure assessed • Ventilation • Hygiene • PPE • Monitoring.',
    supervisorReference:
        'Check housekeeping and worker hygiene practices.',
    emergencyResponse:
        'Stop exposure, move to a safe area and seek appropriate medical/occupational health advice.',
    commonMistakes:
        'Poor hygiene • Dry sweeping contaminated dust • Inadequate respiratory protection.',
    learningPoint:
        'Lead exposure can occur without immediate symptoms, making prevention and monitoring important.',
  ),
  _ReferenceTopic(
    key: 'adosh_waste',
    regionId: 'abu_dhabi',
    title: 'Waste Management',
    description:
        'Safe and environmentally responsible workplace waste control.',
    definition:
        'Waste management controls waste generation, segregation, storage, handling and disposal.',
    purpose:
        'Prevent injury, pollution, fire and uncontrolled environmental impacts.',
    hazards:
        'Hazardous waste • Sharp objects • Chemicals • Spills • Poor storage.',
    controls:
        'Segregation • Containers • Labels • Storage • Safe transport • Appropriate disposal • Housekeeping.',
    ppe:
        'Gloves • Safety footwear • Eye protection • Task-specific PPE.',
    safePractice:
        'Identify hazardous waste and ensure it is managed through appropriate arrangements.',
    checklist:
        'Segregation • Labels • Containers • Storage • Collection • Disposal • Housekeeping.',
    supervisorReference:
        'Check waste accumulation and segregation.',
    emergencyResponse:
        'Control spills if safe and activate environmental emergency procedures where applicable.',
    commonMistakes:
        'Mixed waste • Unlabelled hazardous waste • Overflowing containers.',
    learningPoint:
        'Waste management is both an HSE and environmental responsibility.',
  ),
  _ReferenceTopic(
    key: 'adosh_underground',
    regionId: 'abu_dhabi',
    title: 'Underground Construction',
    description:
        'Safety controls for underground construction and related activities.',
    definition:
        'Underground construction includes activities such as tunnelling, shafts, underground excavation and other below-ground work.',
    purpose:
        'Control ground instability, atmosphere, access, water and emergency risks.',
    hazards:
        'Ground collapse • Poor atmosphere • Flooding • Restricted access • Equipment movement • Falling material.',
    controls:
        'Site investigation • Ground assessment • Support systems • Monitoring • Ventilation • Access • Emergency response.',
    ppe:
        'Helmet • Safety footwear • High-visibility clothing • Eye protection • Task-specific PPE.',
    safePractice:
        'Maintain monitoring and support systems according to approved engineering arrangements.',
    checklist:
        'Ground assessment • Support • Access • Ventilation • Monitoring • Communication • Emergency plan.',
    supervisorReference:
        'Check changes in ground, water and atmospheric conditions.',
    emergencyResponse:
        'Stop work • Account for workers • Activate rescue arrangements • Contact emergency services.',
    commonMistakes:
        'Ignoring ground movement • Poor access • Inadequate monitoring.',
    learningPoint:
        'Underground hazards can develop with little warning; monitoring and emergency readiness are essential.',
  ),
  _ReferenceTopic(
    key: 'adosh_incident',
    regionId: 'abu_dhabi',
    title: 'Incident Notification & Reporting',
    description:
        'Reporting, recording and learning from workplace incidents.',
    definition:
        'Incident reporting is the process of communicating workplace events, injuries, near misses and other reportable occurrences through defined procedures.',
    purpose:
        'Ensure timely response, regulatory compliance where applicable and organisational learning.',
    hazards:
        'Unreported incidents • Lost evidence • Repeated events • Delayed corrective action.',
    controls:
        'Immediate response • Notification • Evidence preservation • Investigation • Root-cause analysis • Corrective action • Follow-up.',
    ppe:
        'PPE appropriate to the incident area and investigation activity.',
    safePractice:
        'Make the area safe first, preserve evidence where practicable and report according to the applicable procedure.',
    checklist:
        'Immediate care • Notification • Scene control • Evidence • Investigation • Corrective action • Close-out.',
    supervisorReference:
        'Ensure actions address underlying causes, not only immediate unsafe acts.',
    emergencyResponse:
        'Provide immediate assistance and activate emergency services for serious incidents.',
    commonMistakes:
        'Delayed reporting • Blaming individuals • Poor evidence preservation • Weak corrective action.',
    learningPoint:
        'Incident investigation should prevent recurrence rather than simply assign blame.',
  ),
  _ReferenceTopic(
    key: 'adosh_audit',
    regionId: 'abu_dhabi',
    title: 'Audit & Inspection',
    description:
        'Systematic verification of OSH controls and continual improvement.',
    definition:
        'Audits and inspections provide structured methods for verifying compliance, identifying gaps and improving OSH performance.',
    purpose:
        'Confirm controls are working and identify opportunities for improvement.',
    hazards:
        'Repeated deficiencies • Weak corrective actions • False assurance.',
    controls:
        'Inspection plan • Competent personnel • Evidence • Findings • Corrective actions • Verification • Management review.',
    ppe:
        'PPE appropriate to the inspection area.',
    safePractice:
        'Record objective evidence and verify close-out.',
    checklist:
        'Scope • Evidence • Finding • Action • Owner • Due date • Verification.',
    supervisorReference:
        'Track repeat findings and overdue actions.',
    emergencyResponse:
        'Escalate imminent danger immediately and stop affected work where required.',
    commonMistakes:
        'Paper-only audits • Vague observations • No follow-up.',
    learningPoint:
        'Inspection finds the problem; corrective action prevents it from returning.',
  ),
  _ReferenceTopic(
    key: 'adosh_heat',
    regionId: 'abu_dhabi',
    title: 'Heat Stress Management',
    description:
        'Heat illness prevention for Abu Dhabi workplaces.',
    definition:
        'Heat stress results when environmental and workload conditions place excessive thermal strain on the body.',
    purpose:
        'Prevent dehydration, heat exhaustion and heat stroke.',
    hazards:
        'Heat • Humidity • Sun • Heavy work • Dehydration • Inadequate acclimatization.',
    controls:
        'Water • Rest • Shade • Work planning • Acclimatization • Monitoring • Training.',
    ppe:
        'Suitable clothing • Safety footwear • Head protection • Task-specific PPE.',
    safePractice:
        'Plan work around environmental conditions and ensure workers understand symptoms and reporting.',
    checklist:
        'Water • Rest • Shade • Acclimatization • Monitoring • Emergency response.',
    supervisorReference:
        'Monitor workers and intervene early when symptoms appear.',
    emergencyResponse:
        'Stop work, cool the affected worker and obtain emergency medical support for serious symptoms.',
    commonMistakes:
        'Ignoring symptoms • Poor hydration • Insufficient rest.',
    learningPoint:
        'Heat stress prevention requires active supervision, not only written instructions.',
  ),
  _ReferenceTopic(
    key: 'adosh_lifting',
    regionId: 'abu_dhabi',
    title: 'Lifting Operations',
    description:
        'Planning, inspection and control of lifting activities.',
    definition:
        'Lifting operations involve moving loads using lifting equipment and require competent planning and execution.',
    purpose:
        'Prevent dropped loads, collisions, equipment failure and injury.',
    hazards:
        'Dropped load • Overload • Poor rigging • Suspended load • Wind • Ground instability.',
    controls:
        'Lift plan • Competent personnel • Certified equipment • Inspection • Load control • Exclusion zone.',
    ppe:
        'Helmet • Safety footwear • High-visibility clothing • Gloves.',
    safePractice:
        'Confirm load characteristics and equipment suitability before lifting.',
    checklist:
        'Plan • Certification • Inspection • Load • Ground • Exclusion zone • Communication.',
    supervisorReference:
        'Verify lifting equipment and accessories before use.',
    emergencyResponse:
        'Stop operation and secure the danger zone.',
    commonMistakes:
        'Improvised rigging • No exclusion zone • Overloading.',
    learningPoint:
        'A lifting operation is a system involving people, equipment, load and environment.',
  ),
  _ReferenceTopic(
    key: 'adosh_work_height',
    regionId: 'abu_dhabi',
    title: 'Work at Height',
    description:
        'Fall prevention and protection for elevated work.',
    definition:
        'Work at height is work where a person may fall and suffer injury.',
    purpose:
        'Prevent falls and falling-object incidents.',
    hazards:
        'Open edges • Ladders • Scaffolds • Fragile surfaces • Falling tools.',
    controls:
        'Avoid height • Safe access • Edge protection • Fall protection • Inspection • Rescue planning.',
    ppe:
        'Helmet with chin strap where required • Safety footwear • Full body harness where required.',
    safePractice:
        'Use suitable access equipment and maintain protection throughout the job.',
    checklist:
        'Risk assessment • Access • Edge protection • Equipment inspection • Harness if required • Rescue plan.',
    supervisorReference:
        'Check actual protection systems and anchor arrangements.',
    emergencyResponse:
        'Activate rescue plan and obtain medical assistance.',
    commonMistakes:
        'Improvised access • No edge protection • Incorrect anchor point.',
    learningPoint:
        'The strongest fall control is prevention of the fall.',
  ),
  _ReferenceTopic(
    key: 'adosh_electrical',
    regionId: 'abu_dhabi',
    title: 'Electrical Safety',
    description:
        'Control of electrical shock, arc, fire and equipment hazards.',
    definition:
        'Electrical safety involves safe design, installation, operation, maintenance and isolation of electrical systems.',
    purpose:
        'Protect people and property from electrical energy.',
    hazards:
        'Live parts • Damaged cables • Arc flash • Overloading • Poor earthing • Wet environments.',
    controls:
        'Isolation • Competent persons • Inspection • Protection devices • Earthing • Controlled access.',
    ppe:
        'Electrical-rated PPE where required • Eye/face protection • Safety footwear • Arc-flash PPE where applicable.',
    safePractice:
        'Use competent electrical personnel and verify isolation before work.',
    checklist:
        'Isolation • Competence • Inspection • Earthing • Protection • Cable condition.',
    supervisorReference:
        'Check temporary electrical installations and work controls.',
    emergencyResponse:
        'Isolate the source safely and contact emergency services before approaching a casualty.',
    commonMistakes:
        'Damaged cables • Bypassed protection • Unauthorised work.',
    learningPoint:
        'Never assume an electrical system is dead without proper isolation and verification.',
  ),
  _ReferenceTopic(
    key: 'adosh_barricading',
    regionId: 'abu_dhabi',
    title: 'Barricading of Hazards',
    description:
        'Effective control of access to hazardous areas.',
    definition:
        'Barricading uses physical or visual barriers to restrict people from dangerous areas.',
    purpose:
        'Prevent unauthorised entry and exposure.',
    hazards:
        'Excavations • Open edges • Lifting zones • Electrical areas • Demolition.',
    controls:
        'Suitable barriers • Warning signs • Access control • Visibility • Inspection.',
    ppe:
        'PPE depends on the hazard inside the controlled area.',
    safePractice:
        'Use a barrier appropriate to the seriousness of the hazard and maintain it until the hazard is removed.',
    checklist:
        'Hazard identified • Barrier • Sign • Access control • Visibility • Inspection.',
    supervisorReference:
        'Ensure barriers are effective, not merely symbolic.',
    emergencyResponse:
        'Keep unauthorised people out and activate emergency arrangements.',
    commonMistakes:
        'Weak tape • Missing signs • Broken barriers.',
    learningPoint:
        'Barricading is an access-control measure, not just a warning.',
  ),
];
