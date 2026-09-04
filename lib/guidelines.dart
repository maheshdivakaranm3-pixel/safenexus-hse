import 'package:flutter/material.dart';
import 'package:safenexus_hse/guideline_detail_page.dart';

class GuidelinesPage extends StatefulWidget {
  const GuidelinesPage({super.key});

  @override
  State<GuidelinesPage> createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  final List<_SafetyRegion> _regions = const [
    _SafetyRegion(
      title: 'UAE HSE Safety',
      subtitle: 'UAE-wide HSE guidance',
      icon: Icons.flag_rounded,
      color: Color(0xFF159447),
      description:
          'General workplace health and safety guidance applicable across the UAE. Always verify the latest authority requirements for your activity and location.',
      topics: [
        'Risk Assessment',
        'Personal Protective Equipment',
        'Heat Stress',
        'Fire Safety',
        'Emergency Preparedness',
        'First Aid',
        'Occupational Health',
        'Work at Height',
        'Confined Space',
        'Electrical Safety',
        'Lifting & Rigging',
        'Chemical Safety',
        'Incident Investigation',
        'Environmental Safety',
        'Manual Handling',
        'Traffic & Vehicle Safety',
      ],
    ),
    _SafetyRegion(
      title: 'Dubai HSE Safety',
      subtitle: 'Dubai Municipality & local guidance',
      icon: Icons.location_city_rounded,
      color: Color(0xFF1677C8),
      description:
          'Dubai-focused HSE guidance covering workplace, construction, equipment, risk and environmental safety topics. Check the latest Dubai Municipality requirements before compliance decisions.',
      topics: [
        'Health & Safety Risk Assessment',
        'Safe Forklift Operations',
        'Safe Storage',
        'Construction Safety',
        'Work at Height',
        'Confined Space',
        'Scaffolding Safety',
        'Ladders & Access',
        'Machinery Safety',
        'Lifting Operations',
        'PPE',
        'Heat Stress',
        'Safety Signs',
        'Indoor Air Quality',
        'Waste Management',
        'Emergency Safety',
      ],
    ),
    _SafetyRegion(
      title: 'Abu Dhabi HSE Safety',
      subtitle: 'ADOSH-SF guidance',
      icon: Icons.account_balance_rounded,
      color: Color(0xFF6736C8),
      description:
          'Abu Dhabi-focused occupational safety and health guidance aligned with the ADOSH-SF framework and its applicable Codes of Practice.',
      topics: [
        'ADOSH-SF Overview',
        'Risk Management',
        'OSH Management During Construction',
        'Personal Protective Equipment',
        'Occupational Noise',
        'Vibration',
        'First Aid & Medical Emergency',
        'Occupational Health',
        'Hazardous Materials',
        'Asbestos Management',
        'Lead Exposure',
        'Waste Management',
        'Scaffolding',
        'Underground Construction',
        'Incident Notification & Reporting',
        'Audit & Inspection',
      ],
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final details = GuidelineDetailPage(guideline: const {}).details;

    final entries = details.entries.where((entry) {
      if (_query.trim().isEmpty) return true;

      final query = _query.trim().toLowerCase();
      final title = (entry.value['what'] ?? '').toLowerCase();
      final description = (entry.value['whatText'] ?? '').toLowerCase();

      return entry.key.toLowerCase().contains(query) ||
          title.contains(query) ||
          description.contains(query);
    }).toList();

    final bool searching = _query.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: const Text(
          'HSE Guidelines',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        children: [
          _buildIntroCard(),

          const SizedBox(height: 18),

          TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _query = value;
              });
            },
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'Search HSE guidelines',
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
          ),

          const SizedBox(height: 22),

          if (!searching) ...[
            const Text(
              'UAE HSE SAFETY',
              style: TextStyle(
                color: Color(0xFF087A38),
                fontSize: 14,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Choose your UAE safety guidance area',
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

            const SizedBox(height: 18),

            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Safety Reference Library',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Text(
                  '${entries.length} topics',
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),

            const Text(
              'A–Z general HSE reference topics',
              style: TextStyle(
                color: Color(0xFF777777),
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 10),
          ],

          if (searching)
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Search Results',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Text(
                  '${entries.length} topics',
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

          const SizedBox(height: 8),

          if (entries.isEmpty)
            _buildEmptySearchState()
          else
            ...entries.map(
              (entry) => _buildGuidelineCard(
                context,
                entry,
              ),
            ),
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
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Color(0x22FFFFFF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.menu_book_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
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
                  'Practical HSE guidance for UAE workplaces, construction sites and safety professionals.',
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
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: region.color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  region.icon,
                  color: region.color,
                  size: 27,
                ),
              ),
              const SizedBox(width: 13),
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF777777),
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                color: region.color,
                size: 27,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuidelineCard(
    BuildContext context,
    MapEntry<String, Map<String, String>> entry,
  ) {
    final letter = entry.key;
    final data = entry.value;

    final title = data['what'] ?? 'Guideline $letter';
    final description = data['whatText'] ?? '';

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
                guideline: {
                  'letter': letter,
                  'title': title,
                  'desc': description,
                },
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
                  color: const Color(0xFFE7F3EF),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text(
                  letter,
                  style: const TextStyle(
                    color: Color(0xFF0B5D4B),
                    fontSize: 18,
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
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.35,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptySearchState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 52,
            color: Theme.of(context)
                .colorScheme
                .onSurfaceVariant,
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
          Text(
            'Try a different keyword or search by guideline topic.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

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
          _buildRegionHeader(),
          const SizedBox(height: 20),
          const Text(
            'SAFETY TOPICS',
            style: TextStyle(
              color: Color(0xFF087A38),
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${region.topics.length} safety topics',
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

  Widget _buildRegionHeader() {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  region.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  region.description,
                  style: const TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 12,
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

  Widget _buildTopicCard(
    BuildContext context,
    int number,
    String topic,
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
              builder: (_) => RegionalTopicPage(
                region: region,
                topic: topic,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 13,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: region.color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$number',
                  style: TextStyle(
                    color: region.color,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Text(
                  topic,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
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

class RegionalTopicPage extends StatelessWidget {
  final _SafetyRegion region;
  final String topic;

  const RegionalTopicPage({
    super.key,
    required this.region,
    required this.topic,
  });

  String _purpose() {
    switch (topic) {
      case 'Risk Assessment':
      case 'Health & Safety Risk Assessment':
      case 'Risk Management':
        return 'Identify hazards, assess risk and apply suitable controls before and during work.';
      case 'Personal Protective Equipment':
      case 'PPE':
        return 'Select, provide, use and maintain PPE appropriate to the identified hazards.';
      case 'Heat Stress':
        return 'Reduce worker exposure to excessive heat through planning, hydration, rest, shade, training and monitoring.';
      case 'Fire Safety':
      case 'Emergency Safety':
      case 'Emergency Preparedness':
        return 'Prepare workers and workplaces to prevent emergencies and respond effectively when they occur.';
      case 'First Aid':
      case 'First Aid & Medical Emergency':
        return 'Ensure suitable first-aid arrangements and timely medical response for workplace injuries and illness.';
      case 'Work at Height':
        return 'Prevent falls by planning work, selecting suitable access systems and implementing effective fall-prevention controls.';
      case 'Confined Space':
        return 'Prevent atmospheric, physical and other confined-space hazards through assessment, controls and emergency arrangements.';
      case 'Electrical Safety':
        return 'Prevent electric shock, burns, fire and other electrical incidents through competent work and effective controls.';
      case 'Safe Forklift Operations':
        return 'Control vehicle movement, operator competence, load handling, pedestrian interaction and equipment condition.';
      case 'Safe Storage':
        return 'Maintain stable, suitable and clearly controlled storage arrangements to prevent falling objects, fire and access hazards.';
      case 'Scaffolding Safety':
        return 'Control scaffold design, erection, inspection, access, loading and use to prevent falls and collapse.';
      case 'Ladders & Access':
        return 'Use suitable access equipment and maintain safe positioning, inspection and working practices.';
      case 'Machinery Safety':
        return 'Control moving machinery hazards through guarding, isolation, maintenance and competent operation.';
      case 'Lifting Operations':
      case 'Lifting & Rigging':
        return 'Plan lifting operations, verify equipment condition and certification, and control people and loads during lifting.';
      case 'Chemical Safety':
      case 'Hazardous Materials':
        return 'Identify chemical hazards and control storage, handling, exposure, emergency response and disposal.';
      case 'Occupational Noise':
        return 'Assess noise exposure and apply suitable engineering, administrative and personal protective controls.';
      case 'Vibration':
        return 'Assess vibration exposure and implement controls to reduce worker exposure and associated health risks.';
      case 'Occupational Health':
        return 'Identify occupational health risks and implement suitable health protection, monitoring and preventive measures.';
      case 'Asbestos Management':
        return 'Prevent exposure to asbestos fibres through identification, assessment, controlled work and competent management.';
      case 'Lead Exposure':
        return 'Identify lead exposure risks and implement appropriate controls, monitoring and worker protection.';
      case 'Waste Management':
        return 'Segregate, store, handle and dispose of workplace waste safely and through appropriate arrangements.';
      case 'Incident Investigation':
      case 'Incident Notification & Reporting':
        return 'Ensure incidents are reported, investigated and followed by appropriate corrective and preventive actions.';
      case 'Audit & Inspection':
        return 'Use systematic inspections and audits to identify gaps, verify controls and drive continual improvement.';
      case 'Construction Safety':
      case 'OSH Management During Construction':
        return 'Plan and manage construction activities so hazards are identified, controlled and monitored throughout the project.';
      case 'Underground Construction':
        return 'Assess underground construction hazards and implement controls appropriate to activities such as piling, tunnelling and shaft work.';
      case 'Environmental Safety':
      case 'Indoor Air Quality':
        return 'Control environmental and workplace conditions that may affect workers, the public or the surrounding environment.';
      case 'Manual Handling':
        return 'Reduce manual-handling injuries through task assessment, mechanical aids, good technique and suitable work design.';
      case 'Traffic & Vehicle Safety':
        return 'Separate people and vehicles where practicable and control vehicle movement, reversing, speed and access.';
      case 'Safety Signs':
        return 'Use clear and appropriate safety signs and communication methods to warn, inform and direct workers.';
      case 'ADOSH-SF Overview':
        return 'Understand the Abu Dhabi Occupational Safety and Health System Framework and how its requirements are organised.';
      default:
        return 'Use this topic as a practical HSE reference and verify the latest applicable authority requirements before making compliance decisions.';
    }
  }

  String _controls() {
    switch (topic) {
      case 'Risk Assessment':
      case 'Health & Safety Risk Assessment':
      case 'Risk Management':
        return 'Hazard identification • Risk evaluation • Hierarchy of controls • Worker involvement • Review when conditions change.';
      case 'Work at Height':
        return 'Avoid work at height where possible • Safe access • Edge protection • Fall protection • Inspection • Rescue planning.';
      case 'Confined Space':
        return 'Risk assessment • Isolation • Atmospheric testing • Ventilation • Communication • Attendant • Rescue arrangements.';
      case 'Safe Forklift Operations':
        return 'Competent operators • Pre-use checks • Safe loads • Speed control • Pedestrian segregation • Safe parking.';
      case 'Scaffolding Safety':
        return 'Competent erection • Stable foundation • Guardrails • Toe boards • Safe access • Inspection • Safe loading.';
      case 'Electrical Safety':
        return 'Isolation • Competent persons • Inspection • Suitable equipment • Protection from live parts • Controlled access.';
      case 'Heat Stress':
        return 'Water • Rest • Shade • Work/rest planning • Heat awareness • Supervision • Early reporting of symptoms.';
      case 'Lifting Operations':
      case 'Lifting & Rigging':
        return 'Lift plan • Competent personnel • Certified equipment • Load control • Exclusion zone • Communication.';
      default:
        return 'Identify hazards • Assess risk • Apply the hierarchy of controls • Train workers • Inspect • Monitor • Review.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: Text(
          topic,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    region.color,
                    region.color.withValues(alpha: 0.78),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.shield_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          topic,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          region.title,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _infoCard(
              icon: Icons.info_outline_rounded,
              title: 'Purpose',
              content: _purpose(),
            ),

            _infoCard(
              icon: Icons.rule_rounded,
              title: 'Key Controls',
              content: _controls(),
            ),

            _infoCard(
              icon: Icons.engineering_rounded,
              title: 'HSE Practice',
              content:
                  'Use competent personnel, suitable procedures, appropriate PPE and effective supervision. Conditions should be reviewed whenever the task, equipment, environment or risk changes.',
            ),

            _infoCard(
              icon: Icons.checklist_rounded,
              title: 'Quick Checklist',
              content:
                  'Planning • Hazard identification • Risk assessment • Controls • Worker briefing • Inspection • Monitoring • Corrective action.',
            ),

            _infoCard(
              icon: Icons.warning_amber_rounded,
              title: 'Important',
              content:
                  'This page provides general HSE awareness guidance. It is not a substitute for the latest applicable UAE legislation, Dubai Municipality requirements, ADOSH-SF Codes of Practice, regulator requirements or project procedures.',
            ),

            const SizedBox(height: 8),

            Text(
              'Reference Area',
              style: TextStyle(
                color: region.color,
                fontSize: 13,
                fontWeight: FontWeight.w800,
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
}

class _SafetyRegion {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String description;
  final List<String> topics;

  const _SafetyRegion({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.description,
    required this.topics,
  });
}
