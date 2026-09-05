import 'package:flutter/material.dart';

class GuidelinesPage extends StatefulWidget {
  const GuidelinesPage({super.key});

  @override
  State<GuidelinesPage> createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  final TextEditingController _searchController =
      TextEditingController();

  String _query = '';

  // ============================================================
  // GENERAL UAE HSE REFERENCE LIBRARY
  // ============================================================

  final List<_ReferenceTopic> _referenceTopics = const [
    _ReferenceTopic(
      title: 'Code of Practice',
      description:
          'Understand applicable HSE Codes of Practice and use them together with current legal and project requirements.',
      ppe: 'PPE based on the task and identified hazards.',
    ),
    _ReferenceTopic(
      title: 'Excavation Safety',
      description:
          'Control excavation hazards including collapse, underground services, access, water and falling materials.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility vest • Eye protection • Gloves.',
    ),
    _ReferenceTopic(
      title: 'Scaffolding Safety',
      description:
          'Safe scaffold erection, inspection, access, loading and use.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Full body harness where required.',
    ),
    _ReferenceTopic(
      title: 'Working at Height',
      description:
          'Prevent falls through safe access, edge protection, fall protection and rescue planning.',
      ppe:
          'Safety helmet with chin strap • Safety footwear • Full body harness where required.',
    ),
    _ReferenceTopic(
      title: 'Power Tools Safety',
      description:
          'Safe selection, inspection, operation and maintenance of portable power tools.',
      ppe:
          'Safety glasses • Hearing protection • Gloves where suitable • Safety footwear.',
    ),
    _ReferenceTopic(
      title: 'Formwork Safety',
      description:
          'Control formwork stability, erection, loading, stripping and temporary support hazards.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Eye protection.',
    ),
    _ReferenceTopic(
      title: 'Permit to Work (PTW)',
      description:
          'Plan and control high-risk activities through an effective permit-to-work system.',
      ppe:
          'PPE determined by the permitted task and risk assessment.',
    ),
    _ReferenceTopic(
      title: 'Working in Hot & Humid Climate',
      description:
          'Manage heat exposure through hydration, rest, shade, planning, monitoring and worker awareness.',
      ppe:
          'Light suitable work clothing • Safety footwear • Head protection • Task-specific PPE.',
    ),
    _ReferenceTopic(
      title: 'Confined Space Safety',
      description:
          'Control atmospheric, physical and emergency risks associated with confined-space work.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Eye protection • Respiratory protection where required • Harness where required.',
    ),
    _ReferenceTopic(
      title: 'Working Near Live Roads',
      description:
          'Protect workers and road users through traffic management, segregation, signs and safe work zones.',
      ppe:
          'High-visibility clothing • Safety footwear • Safety helmet • Task-specific PPE.',
    ),
    _ReferenceTopic(
      title: 'Concreting Safety',
      description:
          'Control hazards associated with concrete delivery, pumping, placing, vibration and finishing.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Eye protection • Suitable protective clothing.',
    ),
    _ReferenceTopic(
      title: 'Barricading of Hazards',
      description:
          'Use effective barricading and warning systems to prevent unauthorized access to hazards.',
      ppe:
          'PPE based on the hazard within the barricaded area.',
    ),
    _ReferenceTopic(
      title: 'Worker Welfare',
      description:
          'Provide suitable welfare, sanitation, drinking water, rest areas and worker facilities.',
      ppe:
          'Task-specific PPE where work activities are involved.',
    ),
    _ReferenceTopic(
      title: 'Electricity on Site & Electrical Tools',
      description:
          'Control electrical shock, fire and equipment hazards through safe installation, inspection and use.',
      ppe:
          'Electrical-rated PPE as required • Safety footwear • Eye protection • Arc-flash PPE where applicable.',
    ),
    _ReferenceTopic(
      title: 'Temporary Works',
      description:
          'Plan, design, inspect and control temporary structures and supporting systems.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Fall protection where required.',
    ),
    _ReferenceTopic(
      title: 'Manual Handling',
      description:
          'Reduce manual-handling injuries through task assessment, mechanical aids and safe techniques.',
      ppe:
          'Safety footwear • Gloves appropriate to the material • Other task-specific PPE.',
    ),
    _ReferenceTopic(
      title: 'Hot Work Safety',
      description:
          'Control welding, cutting, grinding and other activities that generate heat, sparks or flames.',
      ppe:
          'Welding helmet/goggles • Gloves • Flame-resistant clothing • Safety footwear • Face shield where required.',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // HSE GUIDELINES PAGE
  //
  // IMPORTANT:
  // UAE / Dubai / Abu Dhabi region cards are intentionally NOT
  // displayed on this page.
  //
  // RegionalSafetyPage remains available below for other parts
  // of the application that may navigate to regional safety.
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final String query = _query.trim().toLowerCase();

    final List<_ReferenceTopic> entries =
        _referenceTopics.where((topic) {
      if (query.isEmpty) {
        return true;
      }

      return topic.title.toLowerCase().contains(query) ||
          topic.description.toLowerCase().contains(query) ||
          topic.ppe.toLowerCase().contains(query);
    }).toList();

    final bool searching = query.isNotEmpty;

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
        padding: const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          30,
        ),
        children: [
          // ======================================================
          // INTRO CARD
          // ======================================================

          _buildIntroCard(),

          const SizedBox(height: 18),

          // ======================================================
          // SEARCH
          // ======================================================

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
              prefixIcon: const Icon(
                Icons.search_rounded,
              ),
              suffixIcon: _query.isEmpty
                  ? null
                  : IconButton(
                      tooltip: 'Clear search',
                      icon: const Icon(
                        Icons.clear_rounded,
                      ),
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

          // ======================================================
          // SAFETY REFERENCE LIBRARY
          // ======================================================

          if (!searching) ...[
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
                  '${_referenceTopics.length} topics',
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
              'Practical UAE HSE reference topics',
              style: TextStyle(
                color: Color(0xFF777777),
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 10),
          ],

          // ======================================================
          // SEARCH RESULTS
          // ======================================================

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

          // ======================================================
          // REFERENCE TOPICS
          // ======================================================

          if (entries.isEmpty)
            _buildEmptySearchState()
          else
            ...entries.asMap().entries.map(
                  (entry) => _buildReferenceCard(
                    context,
                    entry.key + 1,
                    entry.value,
                  ),
                ),
        ],
      ),
    );
  }

  // ============================================================
  // INTRO CARD
  // ============================================================

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

  // ============================================================
  // REFERENCE CARD
  // ============================================================

  Widget _buildReferenceCard(
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
              builder: (_) => RegionalTopicPage(
                region: _generalRegion,
                topic: topic.title,
                topicData: topic,
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
                  '$number',
                  style: const TextStyle(
                    color: Color(0xFF0B5D4B),
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      topic.description,
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

  // ============================================================
  // EMPTY SEARCH
  // ============================================================

  Widget _buildEmptySearchState() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 48,
      ),
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

// ============================================================
// GENERAL UAE REGION
// ============================================================

const _SafetyRegion _generalRegion = _SafetyRegion(
  title: 'UAE HSE Safety',
  subtitle: 'UAE-wide practical HSE reference',
  icon: Icons.flag_rounded,
  color: Color(0xFF159447),
  description:
      'Practical HSE reference guidance for workplaces and construction activities across the UAE.',
  topics: [],
);

// ============================================================
// REGIONAL SAFETY PAGE
//
// Kept for other app sections that may open UAE / Dubai /
// Abu Dhabi regional safety pages.
// ============================================================

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
        padding: const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          30,
        ),
        children: [
          _buildRegionHeader(),

          const SizedBox(height: 20),

          Text(
            'SAFETY TOPICS',
            style: TextStyle(
              color: region.color,
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
              color: region.color.withValues(
                alpha: 0.10,
              ),
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
              crossAxisAlignment:
                  CrossAxisAlignment.start,
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
                  color: region.color.withValues(
                    alpha: 0.10,
                  ),
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

// ============================================================
// REGIONAL TOPIC DETAIL PAGE
// ============================================================

class RegionalTopicPage extends StatelessWidget {
  final _SafetyRegion region;
  final String topic;
  final _ReferenceTopic? topicData;

  const RegionalTopicPage({
    super.key,
    required this.region,
    required this.topic,
    this.topicData,
  });

  // ============================================================
  // PURPOSE
  // ============================================================

  String _purpose() {
    switch (topic) {
      case 'Code of Practice':
        return 'Understand and apply the relevant HSE Code of Practice together with current legislation, authority requirements and approved project procedures.';

      case 'Dubai HSE Framework':
        return 'Understand the overall HSE management approach applicable to workplaces and construction activities in Dubai and identify the authority requirements relevant to the activity.';

      case 'Dubai Municipality Safety':
        return 'Use Dubai Municipality-related safety requirements as a reference when planning and controlling applicable construction, workplace and environmental activities in Dubai.';

      case 'Construction Safety in Dubai':
        return 'Control construction hazards through proper planning, risk assessment, competent supervision, safe systems of work and compliance with applicable Dubai requirements.';

      case 'What is ADOSH?':
        return 'Understand the Abu Dhabi Occupational Safety and Health system and its role in establishing occupational safety and health requirements in Abu Dhabi.';

      case 'ADOSH-SF Overview':
        return 'Understand the Abu Dhabi Occupational Safety and Health System Framework and how its requirements are organised for occupational safety and health management.';

      case 'Risk Assessment':
      case 'Health & Safety Risk Assessment':
      case 'Risk Management':
        return 'Identify hazards, assess risks and implement suitable controls before and during work.';

      case 'Personal Protective Equipment':
      case 'PPE Requirements':
      case 'PPE':
        return 'Select, provide, use and maintain PPE appropriate to the hazards identified through the risk assessment.';

      case 'Heat Stress Management':
      case 'Heat Stress':
      case 'Working in Hot & Humid Climate':
        return 'Reduce heat-related illness through hydration, rest, shade, work planning, acclimatization, monitoring and early reporting of symptoms.';

      case 'Fire Safety':
        return 'Prevent fire incidents and ensure suitable fire prevention, protection, emergency response and evacuation arrangements.';

      case 'Emergency Preparedness':
      case 'Emergency Safety':
        return 'Prepare workers and workplaces to prevent emergencies and respond effectively when an emergency occurs.';

      case 'First Aid':
      case 'First Aid & Medical Emergency':
        return 'Ensure suitable first-aid arrangements, trained personnel and timely medical response for workplace injuries and illness.';

      case 'Occupational Health':
        return 'Identify occupational health risks and implement suitable health protection, monitoring and preventive measures.';

      case 'Working at Height':
      case 'Work at Height':
        return 'Prevent falls by planning the work, selecting suitable access systems and implementing effective fall-prevention and fall-protection controls.';

      case 'Confined Space Safety':
      case 'Confined Space':
        return 'Prevent atmospheric, engulfment, physical and emergency hazards through assessment, isolation, testing, ventilation, communication and rescue planning.';

      case 'Electrical Safety':
      case 'Electricity on Site & Electrical Tools':
        return 'Prevent electric shock, burns, fire and equipment damage through competent electrical work, inspection, isolation and suitable protection.';

      case 'Lifting & Rigging':
      case 'Lifting Operations':
        return 'Plan lifting operations, verify equipment condition and certification, and control people and loads throughout the lifting activity.';

      case 'Chemical Safety':
      case 'Hazardous Materials':
        return 'Identify chemical hazards and control storage, handling, exposure, emergency response and disposal.';

      case 'Incident Investigation':
      case 'Incident Notification & Reporting':
        return 'Ensure incidents are reported, investigated and followed by appropriate corrective and preventive actions.';

      case 'Environmental Safety':
        return 'Control environmental aspects of work to protect workers, the public and the surrounding environment.';

      case 'Manual Handling':
        return 'Reduce musculoskeletal injuries through task assessment, mechanical aids, suitable work design, team lifting and safe handling techniques.';

      case 'Traffic & Vehicle Safety':
      case 'Traffic Management':
        return 'Separate people and vehicles where practicable and control vehicle movement, reversing, speed, access and pedestrian interaction.';

      case 'Worker Welfare':
        return 'Provide suitable welfare arrangements including drinking water, sanitation, rest facilities, hygiene and suitable worker facilities.';

      case 'Scaffolding Safety':
        return 'Provide safe temporary access and working platforms through competent erection, inspection, safe access and controlled loading.';

      case 'Safe Forklift Operations':
        return 'Control vehicle movement, operator competence, load handling, pedestrian interaction and equipment condition.';

      case 'Safe Storage':
        return 'Maintain stable, suitable and clearly controlled storage arrangements to prevent falling objects, fire and access hazards.';

      case 'Ladders & Safe Access':
      case 'Ladders & Access':
        return 'Use suitable access equipment and maintain safe positioning, inspection and safe working practices.';

      case 'Machinery Safety':
        return 'Control moving machinery hazards through guarding, isolation, maintenance and competent operation.';

      case 'Safety Signs':
        return 'Use clear and appropriate safety signs and communication methods to warn, inform and direct workers and visitors.';

      case 'Indoor Air Quality':
        return 'Maintain suitable indoor air quality by identifying sources of contamination, controlling exposure and maintaining appropriate ventilation.';

      case 'Waste Management':
        return 'Segregate, store, handle and dispose of workplace waste safely through suitable arrangements.';

      case 'Occupational Noise':
        return 'Assess noise exposure and apply suitable engineering, administrative and personal protective controls.';

      case 'Vibration':
        return 'Assess vibration exposure and implement controls to reduce worker exposure and associated health risks.';

      case 'Asbestos Management':
        return 'Prevent exposure to asbestos fibres through identification, assessment, controlled work and competent management.';

      case 'Lead Exposure':
        return 'Identify lead exposure risks and implement appropriate controls, monitoring and worker protection.';

      case 'Underground Construction':
        return 'Assess underground construction hazards and implement controls appropriate to activities such as piling, tunnelling, excavation and shaft work.';

      case 'OSH Management During Construction':
      case 'Construction Safety':
        return 'Plan and manage construction activities so hazards are identified, controlled and monitored throughout the project.';

      case 'Audit & Inspection':
        return 'Use systematic inspections and audits to identify gaps, verify controls and drive continual HSE improvement.';

      case 'Power Tools Safety':
        return 'Prevent cuts, electric shock, flying particles, burns, noise and other injuries through correct tool selection, inspection and safe operation.';

      case 'Formwork Safety':
        return 'Maintain formwork stability during erection, concrete placement and stripping while controlling collapse and falling-object hazards.';

      case 'Permit to Work (PTW)':
        return 'Control high-risk activities through formal authorization, hazard identification, isolation, precautions, communication and close-out.';

      case 'Working Near Live Roads':
        return 'Protect workers, pedestrians and road users by implementing suitable traffic management, segregation, signs, lighting and controlled work zones.';

      case 'Concreting Safety':
        return 'Control hazards from concrete delivery, pumps, placing, vibration, reinforcement interfaces, equipment movement and wet concrete exposure.';

      case 'Barricading of Hazards':
        return 'Prevent people from entering hazardous areas by using suitable barricades, warning signs, access controls and regular inspection.';

      case 'Temporary Works':
        return 'Ensure temporary structures and support systems are properly planned, designed, installed, inspected, maintained and removed safely.';

      case 'Hot Work Safety':
        return 'Prevent fire, explosion, burns and exposure hazards from welding, cutting, grinding and other spark- or heat-producing activities.';

      default:
        return 'Use this topic as a practical HSE reference. Verify the latest applicable authority requirements, legislation, Codes of Practice and project procedures before making compliance decisions.';
    }
  }

  // ============================================================
  // KEY CONTROLS
  // ============================================================

  String _controls() {
    switch (topic) {
      case 'Code of Practice':
        return 'Identify applicable CoP • Check current revision • Understand scope • Apply requirements • Follow project procedures • Verify compliance.';

      case 'Dubai HSE Framework':
        return 'Identify applicable authority • Understand project requirements • Risk assessment • Safe systems of work • Competent supervision • Inspection • Records.';

      case 'Dubai Municipality Safety':
        return 'Identify applicable Dubai Municipality requirements • Verify current requirements • Risk assessment • Approved procedures • Competent supervision • Inspection.';

      case 'Construction Safety in Dubai':
        return 'Project planning • Risk assessment • Site inspection • Safe access • Plant control • Temporary works • Lifting control • Worker welfare.';

      case 'What is ADOSH?':
        return 'Understand ADOSH role • Identify applicable requirements • Follow OSH management arrangements • Use relevant Codes of Practice • Maintain records.';

      case 'ADOSH-SF Overview':
        return 'Identify applicable framework requirements • Review relevant CoPs • Establish OSH arrangements • Monitor compliance • Review performance.';

      case 'Risk Assessment':
      case 'Health & Safety Risk Assessment':
      case 'Risk Management':
        return 'Hazard identification • Risk evaluation • Hierarchy of controls • Worker involvement • Control implementation • Review when conditions change.';

      case 'Personal Protective Equipment':
      case 'PPE Requirements':
      case 'PPE':
        return 'Hazard-based selection • Correct fit • Inspection • Maintenance • Replacement • Worker training • Proper use.';

      case 'Heat Stress Management':
      case 'Heat Stress':
      case 'Working in Hot & Humid Climate':
        return 'Water • Rest • Shade • Work/rest planning • Acclimatization • Heat awareness • Supervision • Early symptom reporting.';

      case 'Fire Safety':
        return 'Fire prevention • Suitable extinguishers • Emergency routes • Alarm systems • Fire risk assessment • Inspection • Training.';

      case 'Emergency Preparedness':
      case 'Emergency Safety':
        return 'Emergency plan • Alarm • Evacuation routes • Assembly point • Emergency contacts • Training • Drills.';

      case 'First Aid':
      case 'First Aid & Medical Emergency':
        return 'First-aid equipment • Trained first aider • Emergency communication • Access for ambulance • Medical response • Incident recording.';

      case 'Occupational Health':
        return 'Health risk assessment • Exposure control • Occupational health monitoring • Worker awareness • Suitable welfare • Medical referral where required.';

      case 'Working at Height':
      case 'Work at Height':
        return 'Avoid where possible • Safe access • Edge protection • Fall protection • Equipment inspection • Rescue planning.';

      case 'Confined Space Safety':
      case 'Confined Space':
        return 'Risk assessment • Isolation • Atmospheric testing • Ventilation • Communication • Attendant • Rescue arrangements.';

      case 'Electrical Safety':
      case 'Electricity on Site & Electrical Tools':
        return 'Isolation • Competent persons • Inspection • Suitable equipment • Protection from live parts • RCD/GFCI where applicable • Controlled access.';

      case 'Lifting & Rigging':
      case 'Lifting Operations':
        return 'Lift plan • Competent personnel • Certified equipment • Load control • Exclusion zone • Communication • Weather consideration.';

      case 'Chemical Safety':
      case 'Hazardous Materials':
        return 'SDS • Labelling • Compatible storage • PPE • Exposure controls • Spill response • Emergency arrangements • Safe disposal.';

      case 'Incident Investigation':
      case 'Incident Notification & Reporting':
        return 'Immediate response • Notification • Evidence preservation • Root-cause analysis • Corrective action • Preventive action • Follow-up.';

      case 'Environmental Safety':
        return 'Environmental risk assessment • Pollution prevention • Waste control • Spill prevention • Monitoring • Corrective action.';

      case 'Manual Handling':
        return 'Avoid unnecessary lifting • Mechanical aids • Reduce load • Good technique • Team lifting • Suitable work height • Training.';

      case 'Traffic & Vehicle Safety':
      case 'Traffic Management':
        return 'Traffic management plan • Segregation • Speed control • Reversing controls • Warning signs • Trained drivers • Pedestrian routes.';

      case 'Worker Welfare':
        return 'Drinking water • Toilets • Washing facilities • Rest areas • Hygiene • Heat protection • Clean and maintained facilities.';

      case 'Scaffolding Safety':
        return 'Competent erection • Stable foundation • Guardrails • Toe boards • Safe access • Inspection • Safe loading.';

      case 'Safe Forklift Operations':
        return 'Competent operators • Pre-use checks • Safe loads • Speed control • Pedestrian segregation • Safe parking • Seat belt.';

      case 'Safe Storage':
        return 'Stable stacking • Load limits • Clear access • Fire controls • Chemical compatibility • Inspection • Housekeeping.';

      case 'Ladders & Safe Access':
      case 'Ladders & Access':
        return 'Suitable ladder • Correct angle • Stable footing • Three-point contact • Inspection • No overreaching • Safe access.';

      case 'Machinery Safety':
        return 'Guarding • Isolation • Emergency stops • Competent operators • Maintenance • Inspection • Lockout/tagout where applicable.';

      case 'Safety Signs':
        return 'Correct sign type • Good visibility • Suitable location • Clear meaning • Maintenance • Worker awareness.';

      case 'Indoor Air Quality':
        return 'Ventilation • Source control • Cleaning • Monitoring • HVAC maintenance • Exposure assessment.';

      case 'Waste Management':
        return 'Segregation • Suitable containers • Labelling • Safe storage • Licensed disposal where applicable • Housekeeping.';

      case 'Occupational Noise':
        return 'Noise assessment • Engineering controls • Administrative controls • Hearing protection • Audiometric monitoring where required.';

      case 'Vibration':
        return 'Exposure assessment • Equipment selection • Maintenance • Reduced exposure time • Job rotation where suitable • Monitoring.';

      case 'Asbestos Management':
        return 'Identify asbestos • Survey • Restrict access • Competent contractor • Controlled removal • Air monitoring where required • Waste control.';

      case 'Lead Exposure':
        return 'Exposure assessment • Engineering controls • Hygiene • PPE • Monitoring • Worker awareness • Medical surveillance where applicable.';

      case 'Underground Construction':
        return 'Site investigation • Service detection • Ground assessment • Access control • Structural support • Monitoring • Emergency response.';

      case 'OSH Management During Construction':
      case 'Construction Safety':
        return 'Planning • Risk assessment • Method statements • Competent supervision • Inspection • Worker consultation • Corrective action.';

      case 'Audit & Inspection':
        return 'Inspection plan • Competent inspectors • Findings • Corrective actions • Close-out • Trend analysis • Management review.';

      case 'Power Tools Safety':
        return 'Correct tool • Pre-use inspection • Guards • Electrical protection • Correct accessories • PPE • Competent operator.';

      case 'Formwork Safety':
        return 'Approved design • Stable supports • Correct erection • Inspection • Controlled concrete placement • Safe stripping sequence.';

      case 'Permit to Work (PTW)':
        return 'Task identification • Risk assessment • Isolation • Permit authorization • Precautions • Toolbox talk • Close-out.';

      case 'Working Near Live Roads':
        return 'Traffic management plan • Barriers • Warning signs • Lighting • Trained flaggers • High-visibility PPE • Safe pedestrian routes.';

      case 'Concreting Safety':
        return 'Pump inspection • Hose control • Exclusion zone • Safe access • Reinforcement protection • Eye/skin protection • Communication.';

      case 'Barricading of Hazards':
        return 'Identify hazard • Select suitable barrier • Warning signs • Restricted access • Night visibility where required • Inspection.';

      case 'Temporary Works':
        return 'Design approval • Competent supervision • Installation inspection • Load control • Monitoring • Modification control • Safe removal.';

      case 'Hot Work Safety':
        return 'Hot work permit • Fire watch • Remove combustibles • Fire extinguishers • Gas cylinder control • Screens • Post-work inspection.';

      default:
        return 'Identify hazards • Assess risk • Apply hierarchy of controls • Train workers • Inspect • Monitor • Review.';
    }
  }

  // ============================================================
  // PPE
  // ============================================================

  String _ppe() {
    if (topicData != null) {
      return topicData!.ppe;
    }

    switch (topic) {
      case 'Working at Height':
      case 'Work at Height':
        return 'Safety helmet with chin strap • Safety footwear • Full body harness where required • Task-specific PPE.';

      case 'Scaffolding Safety':
        return 'Safety helmet • Safety footwear • Gloves • Full body harness where required.';

      case 'Confined Space Safety':
      case 'Confined Space':
        return 'Safety helmet • Safety footwear • Gloves • Eye protection • Respiratory protection where required • Harness where required.';

      case 'Electrical Safety':
        return 'Electrical-rated PPE as required • Safety footwear • Eye protection • Arc-flash PPE where applicable.';

      case 'Hot Work Safety':
        return 'Welding helmet/goggles • Welding gloves • Flame-resistant clothing • Safety footwear • Face shield where required.';

      case 'Occupational Noise':
        return 'Suitable hearing protection • Safety helmet • Safety footwear • Task-specific PPE.';

      case 'Hazardous Materials':
      case 'Chemical Safety':
        return 'Chemical-resistant gloves • Eye/face protection • Protective clothing • Respiratory protection where required.';

      default:
        return 'PPE must be selected based on the task-specific risk assessment and identified hazards.';
    }
  }

  // ============================================================
  // HSE PRACTICE
  // ============================================================

  String _practice() {
    if (region.title == 'Dubai HSE Safety') {
      return 'Use competent personnel, approved procedures, suitable PPE and effective supervision. Confirm the latest applicable Dubai authority requirements before making compliance decisions.';
    }

    if (region.title == 'Abu Dhabi HSE Safety') {
      return 'Use competent personnel, suitable OSH procedures, applicable ADOSH-SF requirements, relevant Codes of Practice and effective supervision. Confirm the latest applicable Abu Dhabi requirements.';
    }

    return 'Use competent personnel, suitable procedures, appropriate PPE and effective supervision. Review conditions whenever the task, equipment, environment or risk changes.';
  }

  // ============================================================
  // QUICK CHECKLIST
  // ============================================================

  String _checklist() {
    switch (topic) {
      case 'Working at Height':
      case 'Work at Height':
        return 'Plan work • Avoid height where possible • Safe access • Edge protection • Fall protection • Equipment inspection • Rescue plan • Worker briefing.';

      case 'Confined Space Safety':
      case 'Confined Space':
        return 'Permit • Isolation • Gas testing • Ventilation • Attendant • Communication • Rescue equipment • Competent workers.';

      case 'Lifting Operations':
      case 'Lifting & Rigging':
        return 'Lift plan • Certified equipment • Competent team • Load weight • Ground condition • Exclusion zone • Communication • Weather.';

      case 'Hot Work Safety':
        return 'Permit • Remove combustibles • Fire extinguisher • Fire watch • Gas cylinder control • PPE • Post-work fire check.';

      case 'Electrical Safety':
        return 'Isolation • Competent electrician • Inspection • RCD/GFCI • Cable protection • Earthing • Lockout where applicable.';

      default:
        return 'Planning • Hazard identification • Risk assessment • Controls • Worker briefing • Inspection • Monitoring • Corrective action.';
    }
  }

  // ============================================================
  // DETAIL PAGE
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: Text(
          topic,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ======================================================
            // HEADER
            // ======================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    region.color,
                    region.color.withValues(
                      alpha: 0.78,
                    ),
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
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
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
              icon: Icons.construction_rounded,
              title: 'PPE',
              content: _ppe(),
            ),

            _infoCard(
              icon: Icons.engineering_rounded,
              title: 'HSE Practice',
              content: _practice(),
            ),

            _infoCard(
              icon: Icons.checklist_rounded,
              title: 'Quick Checklist',
              content: _checklist(),
            ),

            _infoCard(
              icon: Icons.warning_amber_rounded,
              title: 'Important',
              content:
                  'This page provides general HSE awareness guidance. It is not a substitute for the latest applicable UAE legislation, Dubai Municipality requirements, ADOSH-SF Codes of Practice, regulator requirements or approved project procedures.',
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

  // ============================================================
  // INFO CARD
  // ============================================================

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
              crossAxisAlignment:
                  CrossAxisAlignment.start,
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

// ============================================================
// REFERENCE TOPIC MODEL
// ============================================================

class _ReferenceTopic {
  final String title;
  final String description;
  final String ppe;

  const _ReferenceTopic({
    required this.title,
    required this.description,
    required this.ppe,
  });
}

// ============================================================
// SAFETY REGION MODEL
// ============================================================

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

// ============================================================
// UAE SAFETY REGION DATA
//
// This data is intentionally separate from GuidelinesPage.
// It is available for the regional safety navigation used
// elsewhere in the application.
// ============================================================

const _SafetyRegion _uaeSafetyRegion = _SafetyRegion(
  title: 'UAE HSE Safety',
  subtitle: 'UAE-wide HSE guidance',
  icon: Icons.flag_rounded,
  color: Color(0xFF159447),
  description:
      'General HSE guidance applicable across the United Arab Emirates. Use this section for broad workplace and construction safety principles. Always verify the latest requirements of the authority and project applicable to your location and activity.',
  topics: [
    'Risk Assessment',
    'Personal Protective Equipment',
    'Heat Stress Management',
    'Fire Safety',
    'Emergency Preparedness',
    'First Aid',
    'Occupational Health',
    'Working at Height',
    'Confined Space Safety',
    'Electrical Safety',
    'Lifting & Rigging',
    'Chemical Safety',
    'Incident Investigation',
    'Environmental Safety',
    'Manual Handling',
    'Traffic & Vehicle Safety',
    'Worker Welfare',
    'Scaffolding Safety',
  ],
);

const _SafetyRegion _dubaiSafetyRegion = _SafetyRegion(
  title: 'Dubai HSE Safety',
  subtitle: 'Dubai Municipality & Dubai guidance',
  icon: Icons.location_city_rounded,
  color: Color(0xFF1677C8),
  description:
      'Dubai-focused HSE guidance for workplace, construction, equipment, occupational and environmental safety. This section is specifically structured around Dubai-related safety subjects and should be checked against the latest Dubai Municipality and other applicable authority requirements.',
  topics: [
    'Dubai HSE Framework',
    'Dubai Municipality Safety',
    'Construction Safety in Dubai',
    'Health & Safety Risk Assessment',
    'Safe Forklift Operations',
    'Safe Storage',
    'Working at Height',
    'Confined Space Safety',
    'Scaffolding Safety',
    'Ladders & Safe Access',
    'Machinery Safety',
    'Lifting Operations',
    'PPE Requirements',
    'Heat Stress Management',
    'Safety Signs',
    'Indoor Air Quality',
    'Waste Management',
    'Emergency Safety',
    'Fire Safety',
    'Traffic Management',
  ],
);

const _SafetyRegion _abuDhabiSafetyRegion = _SafetyRegion(
  title: 'Abu Dhabi HSE Safety',
  subtitle: 'ADOSH-SF & Abu Dhabi guidance',
  icon: Icons.account_balance_rounded,
  color: Color(0xFF6736C8),
  description:
      'Abu Dhabi-focused occupational safety and health guidance aligned with the Abu Dhabi Occupational Safety and Health System Framework (ADOSH-SF) and applicable Codes of Practice.',
  topics: [
    'What is ADOSH?',
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
    'Scaffolding Safety',
    'Underground Construction',
    'Incident Notification & Reporting',
    'Audit & Inspection',
    'Heat Stress Management',
    'Lifting Operations',
    'Work at Height',
  ],
);

// ============================================================
// GENERAL UAE REGION FOR REFERENCE LIBRARY
// ============================================================

const _SafetyRegion _generalRegion = _SafetyRegion(
  title: 'UAE HSE Safety',
  subtitle: 'UAE-wide practical HSE reference',
  icon: Icons.flag_rounded,
  color: Color(0xFF159447),
  description:
      'Practical HSE reference guidance for workplaces and construction activities across the UAE.',
  topics: [],
);

// ============================================================
// REGIONAL SAFETY PAGE
// ============================================================

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
        padding: const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          30,
        ),
        children: [
          _buildRegionHeader(),

          const SizedBox(height: 20),

          Text(
            'SAFETY TOPICS',
            style: TextStyle(
              color: region.color,
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
              color: region.color.withValues(
                alpha: 0.10,
              ),
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
              crossAxisAlignment:
                  CrossAxisAlignment.start,
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
                  color: region.color.withValues(
                    alpha: 0.10,
                  ),
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

// ============================================================
// REGIONAL TOPIC DETAIL PAGE
// ============================================================

class RegionalTopicPage extends StatelessWidget {
  final _SafetyRegion region;
  final String topic;
  final _ReferenceTopic? topicData;

  const RegionalTopicPage({
    super.key,
    required this.region,
    required this.topic,
    this.topicData,
  });

  // ============================================================
  // PURPOSE
  // ============================================================

  String _purpose() {
    switch (topic) {
      case 'Code of Practice':
        return 'Understand and apply the relevant HSE Code of Practice together with current legislation, authority requirements and approved project procedures.';

      case 'Dubai HSE Framework':
        return 'Understand the overall HSE management approach applicable to workplaces and construction activities in Dubai and identify the authority requirements relevant to the activity.';

      case 'Dubai Municipality Safety':
        return 'Use Dubai Municipality-related safety requirements as a reference when planning and controlling applicable construction, workplace and environmental activities in Dubai.';

      case 'Construction Safety in Dubai':
        return 'Control construction hazards through proper planning, risk assessment, competent supervision, safe systems of work and compliance with applicable Dubai requirements.';

      case 'What is ADOSH?':
        return 'Understand the Abu Dhabi Occupational Safety and Health system and its role in establishing occupational safety and health requirements in Abu Dhabi.';

      case 'ADOSH-SF Overview':
        return 'Understand the Abu Dhabi Occupational Safety and Health System Framework and how its requirements are organised for occupational safety and health management.';

      case 'Risk Assessment':
      case 'Health & Safety Risk Assessment':
      case 'Risk Management':
        return 'Identify hazards, assess risks and implement suitable controls before and during work.';

      case 'Personal Protective Equipment':
      case 'PPE Requirements':
      case 'PPE':
        return 'Select, provide, use and maintain PPE appropriate to the hazards identified through the risk assessment.';

      case 'Heat Stress Management':
      case 'Heat Stress':
      case 'Working in Hot & Humid Climate':
        return 'Reduce heat-related illness through hydration, rest, shade, work planning, acclimatization, monitoring and early reporting of symptoms.';

      case 'Fire Safety':
        return 'Prevent fire incidents and ensure suitable fire prevention, protection, emergency response and evacuation arrangements.';

      case 'Emergency Preparedness':
      case 'Emergency Safety':
        return 'Prepare workers and workplaces to prevent emergencies and respond effectively when an emergency occurs.';

      case 'First Aid':
      case 'First Aid & Medical Emergency':
        return 'Ensure suitable first-aid arrangements, trained personnel and timely medical response for workplace injuries and illness.';

      case 'Occupational Health':
        return 'Identify occupational health risks and implement suitable health protection, monitoring and preventive measures.';

      case 'Working at Height':
      case 'Work at Height':
        return 'Prevent falls by planning the work, selecting suitable access systems and implementing effective fall-prevention and fall-protection controls.';

      case 'Confined Space Safety':
      case 'Confined Space':
        return 'Prevent atmospheric, engulfment, physical and emergency hazards through assessment, isolation, testing, ventilation, communication and rescue planning.';

      case 'Electrical Safety':
      case 'Electricity on Site & Electrical Tools':
        return 'Prevent electric shock, burns, fire and equipment damage through competent electrical work, inspection, isolation and suitable protection.';

      case 'Lifting & Rigging':
      case 'Lifting Operations':
        return 'Plan lifting operations, verify equipment condition and certification, and control people and loads throughout the lifting activity.';

      case 'Chemical Safety':
      case 'Hazardous Materials':
        return 'Identify chemical hazards and control storage, handling, exposure, emergency response and disposal.';

      case 'Incident Investigation':
      case 'Incident Notification & Reporting':
        return 'Ensure incidents are reported, investigated and followed by appropriate corrective and preventive actions.';

      case 'Environmental Safety':
        return 'Control environmental aspects of work to protect workers, the public and the surrounding environment.';

      case 'Manual Handling':
        return 'Reduce musculoskeletal injuries through task assessment, mechanical aids, suitable work design, team lifting and safe handling techniques.';

      case 'Traffic & Vehicle Safety':
      case 'Traffic Management':
        return 'Separate people and vehicles where practicable and control vehicle movement, reversing, speed, access and pedestrian interaction.';

      case 'Worker Welfare':
        return 'Provide suitable welfare arrangements including drinking water, sanitation, rest facilities, hygiene and suitable worker facilities.';

      case 'Scaffolding Safety':
        return 'Provide safe temporary access and working platforms through competent erection, inspection, safe access and controlled loading.';

      case 'Safe Forklift Operations':
        return 'Control vehicle movement, operator competence, load handling, pedestrian interaction and equipment condition.';

      case 'Safe Storage':
        return 'Maintain stable, suitable and clearly controlled storage arrangements to prevent falling objects, fire and access hazards.';

      case 'Ladders & Safe Access':
      case 'Ladders & Access':
        return 'Use suitable access equipment and maintain safe positioning, inspection and safe working practices.';

      case 'Machinery Safety':
        return 'Control moving machinery hazards through guarding, isolation, maintenance and competent operation.';

      case 'Safety Signs':
        return 'Use clear and appropriate safety signs and communication methods to warn, inform and direct workers and visitors.';

      case 'Indoor Air Quality':
        return 'Maintain suitable indoor air quality by identifying sources of contamination, controlling exposure and maintaining appropriate ventilation.';

      case 'Waste Management':
        return 'Segregate, store, handle and dispose of workplace waste safely through suitable arrangements.';

      case 'Occupational Noise':
        return 'Assess noise exposure and apply suitable engineering, administrative and personal protective controls.';

      case 'Vibration':
        return 'Assess vibration exposure and implement controls to reduce worker exposure and associated health risks.';

      case 'Asbestos Management':
        return 'Prevent exposure to asbestos fibres through identification, assessment, controlled work and competent management.';

      case 'Lead Exposure':
        return 'Identify lead exposure risks and implement appropriate controls, monitoring and worker protection.';

      case 'Underground Construction':
        return 'Assess underground construction hazards and implement controls appropriate to activities such as piling, tunnelling, excavation and shaft work.';

      case 'OSH Management During Construction':
      case 'Construction Safety':
        return 'Plan and manage construction activities so hazards are identified, controlled and monitored throughout the project.';

      case 'Audit & Inspection':
        return 'Use systematic inspections and audits to identify gaps, verify controls and drive continual HSE improvement.';

      case 'Power Tools Safety':
        return 'Prevent cuts, electric shock, flying particles, burns, noise and other injuries through correct tool selection, inspection and safe operation.';

      case 'Formwork Safety':
        return 'Maintain formwork stability during erection, concrete placement and stripping while controlling collapse and falling-object hazards.';

      case 'Permit to Work (PTW)':
        return 'Control high-risk activities through formal authorization, hazard identification, isolation, precautions, communication and close-out.';

      case 'Working Near Live Roads':
        return 'Protect workers, pedestrians and road users by implementing suitable traffic management, segregation, signs, lighting and controlled work zones.';

      case 'Concreting Safety':
        return 'Control hazards from concrete delivery, pumps, placing, vibration, reinforcement interfaces, equipment movement and wet concrete exposure.';

      case 'Barricading of Hazards':
        return 'Prevent people from entering hazardous areas by using suitable barricades, warning signs, access controls and regular inspection.';

      case 'Temporary Works':
        return 'Ensure temporary structures and support systems are properly planned, designed, installed, inspected, maintained and removed safely.';

      case 'Hot Work Safety':
        return 'Prevent fire, explosion, burns and exposure hazards from welding, cutting, grinding and other spark- or heat-producing activities.';

      default:
        return 'Use this topic as a practical HSE reference. Verify the latest applicable authority requirements, legislation, Codes of Practice and project procedures before making compliance decisions.';
    }
  }

  // ============================================================
  // KEY CONTROLS
  // ============================================================

  String _controls() {
    switch (topic) {
      case 'Code of Practice':
        return 'Identify applicable CoP • Check current revision • Understand scope • Apply requirements • Follow project procedures • Verify compliance.';

      case 'Dubai HSE Framework':
        return 'Identify applicable authority • Understand project requirements • Risk assessment • Safe systems of work • Competent supervision • Inspection • Records.';

      case 'Dubai Municipality Safety':
        return 'Identify applicable Dubai Municipality requirements • Verify current requirements • Risk assessment • Approved procedures • Competent supervision • Inspection.';

      case 'Construction Safety in Dubai':
        return 'Project planning • Risk assessment • Site inspection • Safe access • Plant control • Temporary works • Lifting control • Worker welfare.';

      case 'What is ADOSH?':
        return 'Understand ADOSH role • Identify applicable requirements • Follow OSH management arrangements • Use relevant Codes of Practice • Maintain records.';

      case 'ADOSH-SF Overview':
        return 'Identify applicable framework requirements • Review relevant CoPs • Establish OSH arrangements • Monitor compliance • Review performance.';

      case 'Risk Assessment':
      case 'Health & Safety Risk Assessment':
      case 'Risk Management':
        return 'Hazard identification • Risk evaluation • Hierarchy of controls • Worker involvement • Control implementation • Review when conditions change.';

      case 'Personal Protective Equipment':
      case 'PPE Requirements':
      case 'PPE':
        return 'Hazard-based selection • Correct fit • Inspection • Maintenance • Replacement • Worker training • Proper use.';

      case 'Heat Stress Management':
      case 'Heat Stress':
      case 'Working in Hot & Humid Climate':
        return 'Water • Rest • Shade • Work/rest planning • Acclimatization • Heat awareness • Supervision • Early symptom reporting.';

      case 'Fire Safety':
        return 'Fire prevention • Suitable extinguishers • Emergency routes • Alarm systems • Fire risk assessment • Inspection • Training.';

      case 'Emergency Preparedness':
      case 'Emergency Safety':
        return 'Emergency plan • Alarm • Evacuation routes • Assembly point • Emergency contacts • Training • Drills.';

      case 'First Aid':
      case 'First Aid & Medical Emergency':
        return 'First-aid equipment • Trained first aider • Emergency communication • Access for ambulance • Medical response • Incident recording.';

      case 'Occupational Health':
        return 'Health risk assessment • Exposure control • Occupational health monitoring • Worker awareness • Suitable welfare • Medical referral where required.';

      case 'Working at Height':
      case 'Work at Height':
        return 'Avoid where possible • Safe access • Edge protection • Fall protection • Equipment inspection • Rescue planning.';

      case 'Confined Space Safety':
      case 'Confined Space':
        return 'Risk assessment • Isolation • Atmospheric testing • Ventilation • Communication • Attendant • Rescue arrangements.';

      case 'Electrical Safety':
      case 'Electricity on Site & Electrical Tools':
        return 'Isolation • Competent persons • Inspection • Suitable equipment • Protection from live parts • RCD/GFCI where applicable • Controlled access.';

      case 'Lifting & Rigging':
      case 'Lifting Operations':
        return 'Lift plan • Competent personnel • Certified equipment • Load control • Exclusion zone • Communication • Weather consideration.';

      case 'Chemical Safety':
      case 'Hazardous Materials':
        return 'SDS • Labelling • Compatible storage • PPE • Exposure controls • Spill response • Emergency arrangements • Safe disposal.';

      case 'Incident Investigation':
      case 'Incident Notification & Reporting':
        return 'Immediate response • Notification • Evidence preservation • Root-cause analysis • Corrective action • Preventive action • Follow-up.';

      case 'Environmental Safety':
        return 'Environmental risk assessment • Pollution prevention • Waste control • Spill prevention • Monitoring • Corrective action.';

      case 'Manual Handling':
        return 'Avoid unnecessary lifting • Mechanical aids • Reduce load • Good technique • Team lifting • Suitable work height • Training.';

      case 'Traffic & Vehicle Safety':
      case 'Traffic Management':
        return 'Traffic management plan • Segregation • Speed control • Reversing controls • Warning signs • Trained drivers • Pedestrian routes.';

      case 'Worker Welfare':
        return 'Drinking water • Toilets • Washing facilities • Rest areas • Hygiene • Heat protection • Clean and maintained facilities.';

      case 'Scaffolding Safety':
        return 'Competent erection • Stable foundation • Guardrails • Toe boards • Safe access • Inspection • Safe loading.';

      case 'Safe Forklift Operations':
        return 'Competent operators • Pre-use checks • Safe loads • Speed control • Pedestrian segregation • Safe parking • Seat belt.';

      case 'Safe Storage':
        return 'Stable stacking • Load limits • Clear access • Fire controls • Chemical compatibility • Inspection • Housekeeping.';

      case 'Ladders & Safe Access':
      case 'Ladders & Access':
        return 'Suitable ladder • Correct angle • Stable footing • Three-point contact • Inspection • No overreaching • Safe access.';

      case 'Machinery Safety':
        return 'Guarding • Isolation • Emergency stops • Competent operators • Maintenance • Inspection • Lockout/tagout where applicable.';

      case 'Safety Signs':
        return 'Correct sign type • Good visibility • Suitable location • Clear meaning • Maintenance • Worker awareness.';

      case 'Indoor Air Quality':
        return 'Ventilation • Source control • Cleaning • Monitoring • HVAC maintenance • Exposure assessment.';

      case 'Waste Management':
        return 'Segregation • Suitable containers • Labelling • Safe storage • Licensed disposal where applicable • Housekeeping.';

      case 'Occupational Noise':
        return 'Noise assessment • Engineering controls • Administrative controls • Hearing protection • Audiometric monitoring where required.';

      case 'Vibration':
        return 'Exposure assessment • Equipment selection • Maintenance • Reduced exposure time • Job rotation where suitable • Monitoring.';

      case 'Asbestos Management':
        return 'Identify asbestos • Survey • Restrict access • Competent contractor • Controlled removal • Air monitoring where required • Waste control.';

      case 'Lead Exposure':
        return 'Exposure assessment • Engineering controls • Hygiene • PPE • Monitoring • Worker awareness • Medical surveillance where applicable.';

      case 'Underground Construction':
        return 'Site investigation • Service detection • Ground assessment • Access control • Structural support • Monitoring • Emergency response.';

      case 'OSH Management During Construction':
      case 'Construction Safety':
        return 'Planning • Risk assessment • Method statements • Competent supervision • Inspection • Worker consultation • Corrective action.';

      case 'Audit & Inspection':
        return 'Inspection plan • Competent inspectors • Findings • Corrective actions • Close-out • Trend analysis • Management review.';

      case 'Power Tools Safety':
        return 'Correct tool • Pre-use inspection • Guards • Electrical protection • Correct accessories • PPE • Competent operator.';

      case 'Formwork Safety':
        return 'Approved design • Stable supports • Correct erection • Inspection • Controlled concrete placement • Safe stripping sequence.';

      case 'Permit to Work (PTW)':
        return 'Task identification • Risk assessment • Isolation • Permit authorization • Precautions • Toolbox talk • Close-out.';

      case 'Working Near Live Roads':
        return 'Traffic management plan • Barriers • Warning signs • Lighting • Trained flaggers • High-visibility PPE • Safe pedestrian routes.';

      case 'Concreting Safety':
        return 'Pump inspection • Hose control • Exclusion zone • Safe access • Reinforcement protection • Eye/skin protection • Communication.';

      case 'Barricading of Hazards':
        return 'Identify hazard • Select suitable barrier • Warning signs • Restricted access • Night visibility where required • Inspection.';

      case 'Temporary Works':
        return 'Design approval • Competent supervision • Installation inspection • Load control • Monitoring • Modification control • Safe removal.';

      case 'Hot Work Safety':
        return 'Hot work permit • Fire watch • Remove combustibles • Fire extinguishers • Gas cylinder control • Screens • Post-work inspection.';

      default:
        return 'Identify hazards • Assess risk • Apply hierarchy of controls • Train workers • Inspect • Monitor • Review.';
    }
  }

  // ============================================================
  // PPE
  // ============================================================

  String _ppe() {
    if (topicData != null) {
      return topicData!.ppe;
    }

    switch (topic) {
      case 'Working at Height':
      case 'Work at Height':
        return 'Safety helmet with chin strap • Safety footwear • Full body harness where required • Task-specific PPE.';

      case 'Scaffolding Safety':
        return 'Safety helmet • Safety footwear • Gloves • Full body harness where required.';

      case 'Confined Space Safety':
      case 'Confined Space':
        return 'Safety helmet • Safety footwear • Gloves • Eye protection • Respiratory protection where required • Harness where required.';

      case 'Electrical Safety':
        return 'Electrical-rated PPE as required • Safety footwear • Eye protection • Arc-flash PPE where applicable.';

      case 'Hot Work Safety':
        return 'Welding helmet/goggles • Welding gloves • Flame-resistant clothing • Safety footwear • Face shield where required.';

      case 'Occupational Noise':
        return 'Suitable hearing protection • Safety helmet • Safety footwear • Task-specific PPE.';

      case 'Hazardous Materials':
      case 'Chemical Safety':
        return 'Chemical-resistant gloves • Eye/face protection • Protective clothing • Respiratory protection where required.';

      default:
        return 'PPE must be selected based on the task-specific risk assessment and identified hazards.';
    }
  }

  // ============================================================
  // HSE PRACTICE
  // ============================================================

  String _practice() {
    if (region.title == 'Dubai HSE Safety') {
      return 'Use competent personnel, approved procedures, suitable PPE and effective supervision. Confirm the latest applicable Dubai authority requirements before making compliance decisions.';
    }

    if (region.title == 'Abu Dhabi HSE Safety') {
      return 'Use competent personnel, suitable OSH procedures, applicable ADOSH-SF requirements, relevant Codes of Practice and effective supervision. Confirm the latest applicable Abu Dhabi requirements.';
    }

    return 'Use competent personnel, suitable procedures, appropriate PPE and effective supervision. Review conditions whenever the task, equipment, environment or risk changes.';
  }

  // ============================================================
  // QUICK CHECKLIST
  // ============================================================

  String _checklist() {
    switch (topic) {
      case 'Working at Height':
      case 'Work at Height':
        return 'Plan work • Avoid height where possible • Safe access • Edge protection • Fall protection • Equipment inspection • Rescue plan • Worker briefing.';

      case 'Confined Space Safety':
      case 'Confined Space':
        return 'Permit • Isolation • Gas testing • Ventilation • Attendant • Communication • Rescue equipment • Competent workers.';

      case 'Lifting Operations':
      case 'Lifting & Rigging':
        return 'Lift plan • Certified equipment • Competent team • Load weight • Ground condition • Exclusion zone • Communication • Weather.';

      case 'Hot Work Safety':
        return 'Permit • Remove combustibles • Fire extinguisher • Fire watch • Gas cylinder control • PPE • Post-work fire check.';

      case 'Electrical Safety':
        return 'Isolation • Competent electrician • Inspection • RCD/GFCI • Cable protection • Earthing • Lockout where applicable.';

      default:
        return 'Planning • Hazard identification • Risk assessment • Controls • Worker briefing • Inspection • Monitoring • Corrective action.';
    }
  }

  // ============================================================
  // DETAIL PAGE UI
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: Text(
          topic,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ======================================================
            // HEADER
            // ======================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    region.color,
                    region.color.withValues(
                      alpha: 0.78,
                    ),
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
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
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
              icon: Icons.construction_rounded,
              title: 'PPE',
              content: _ppe(),
            ),

            _infoCard(
              icon: Icons.engineering_rounded,
              title: 'HSE Practice',
              content: _practice(),
            ),

            _infoCard(
              icon: Icons.checklist_rounded,
              title: 'Quick Checklist',
              content: _checklist(),
            ),

            _infoCard(
              icon: Icons.warning_amber_rounded,
              title: 'Important',
              content:
                  'This page provides general HSE awareness guidance. It is not a substitute for the latest applicable UAE legislation, Dubai Municipality requirements, ADOSH-SF Codes of Practice, regulator requirements or approved project procedures.',
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

  // ============================================================
  // INFO CARD
  // ============================================================

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
              crossAxisAlignment:
                  CrossAxisAlignment.start,
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

// ============================================================
// DATA MODELS
// ============================================================

class _ReferenceTopic {
  final String title;
  final String description;
  final String ppe;

  const _ReferenceTopic({
    required this.title,
    required this.description,
    required this.ppe,
  });
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
