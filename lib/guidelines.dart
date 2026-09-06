import 'package:flutter/material.dart';

import 'models/reference_topic.dart';
import 'guideline_detail_page.dart';

class GuidelinesPage extends StatefulWidget {
  const GuidelinesPage({super.key});

  @override
  State<GuidelinesPage> createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  final TextEditingController _searchController =
      TextEditingController();

  String _searchQuery = '';
  GuidelineCategory _selectedCategory =
      GuidelineCategory.all;

  static const Color primaryGreen =
      Color(0xFF159447);

  static const Color darkGreen =
      Color(0xFF0B5D4B);

  static const Color pageBackground =
      Color(0xFFF6F8F7);

  final List<ReferenceTopic> _topics = const [
    ReferenceTopic(
      id: 'accident_incident_reporting',
      title: 'Accident & Incident Reporting',
      shortTitle: 'Accident & Incident Reporting',
      category: 'UAE General',
      authority: 'UAE HSE Practice',
      jurisdiction: 'UAE',
      description:
          'Guidance for reporting, recording, investigating and learning from workplace accidents, incidents, near misses and dangerous occurrences.',
      keyRequirements: [
        'Report workplace accidents and incidents promptly.',
        'Record near misses and dangerous occurrences.',
        'Preserve relevant evidence where required.',
        'Conduct appropriate incident investigation.',
        'Identify root and contributing causes.',
        'Implement corrective and preventive actions.',
      ],
      safetyControls: [
        'Establish a clear incident reporting procedure.',
        'Ensure workers know who to notify.',
        'Use an incident investigation process.',
        'Track corrective actions to closure.',
        'Share relevant lessons learned.',
      ],
      responsibilities: [
        'Management must provide an effective reporting system.',
        'Supervisors should ensure incidents are reported and controlled.',
        'Workers should immediately report incidents and unsafe conditions.',
        'HSE personnel should support investigation and corrective actions.',
      ],
      references: [
        'UAE occupational health and safety requirements',
        'Company HSE Management System',
        'Applicable Emirate-specific requirements',
      ],
    ),

    ReferenceTopic(
      id: 'confined_space',
      title: 'Confined Space Safety',
      shortTitle: 'Confined Space',
      category: 'UAE General',
      authority: 'UAE HSE Practice',
      jurisdiction: 'UAE',
      description:
          'Safety guidance for work in tanks, vessels, pits, chambers and other spaces where hazardous atmospheres or restricted access may create serious risks.',
      keyRequirements: [
        'Identify and classify confined spaces.',
        'Conduct a suitable risk assessment.',
        'Use a confined space entry permit where required.',
        'Test the atmosphere before and during entry.',
        'Provide suitable ventilation.',
        'Establish emergency rescue arrangements.',
      ],
      safetyControls: [
        'Gas testing',
        'Continuous atmospheric monitoring where necessary',
        'Isolation and lockout',
        'Forced ventilation',
        'Standby attendant',
        'Emergency rescue plan',
        'Suitable PPE and respiratory protection where required',
      ],
      responsibilities: [
        'Employers must provide safe systems of work.',
        'Supervisors must verify controls before entry.',
        'Authorized entrants must follow the entry procedure.',
        'Standby personnel must maintain communication and initiate emergency response.',
      ],
      references: [
        'UAE occupational safety requirements',
        'Company Confined Space Procedure',
        'Applicable permit-to-work system',
      ],
    ),

    ReferenceTopic(
      id: 'construction_safety',
      title: 'Construction Safety',
      shortTitle: 'Construction Safety',
      category: 'UAE General',
      authority: 'UAE HSE Practice',
      jurisdiction: 'UAE',
      description:
          'General HSE guidance for construction activities including site access, work at height, lifting, excavation, temporary works, plant and equipment.',
      keyRequirements: [
        'Provide site-specific risk assessments.',
        'Implement safe systems of work.',
        'Control construction traffic.',
        'Inspect plant and equipment.',
        'Control high-risk activities through permits where applicable.',
        'Provide competent supervision.',
      ],
      safetyControls: [
        'Site induction',
        'Risk assessment and method statement',
        'Permit to work',
        'Barricading and signage',
        'PPE',
        'Inspection and maintenance',
        'Emergency preparedness',
      ],
      responsibilities: [
        'Project management provides resources and safe systems.',
        'Supervisors implement controls at work fronts.',
        'Workers follow approved procedures and report hazards.',
        'HSE teams monitor compliance and provide guidance.',
      ],
      references: [
        'UAE construction HSE requirements',
        'Project HSE Plan',
        'Applicable Emirate requirements',
      ],
    ),

    ReferenceTopic(
      id: 'electrical_safety',
      title: 'Electrical Safety',
      shortTitle: 'Electrical Safety',
      category: 'UAE General',
      authority: 'UAE HSE Practice',
      jurisdiction: 'UAE',
      description:
          'Guidance for controlling electrical hazards including electric shock, arc flash, fire, damaged equipment and unauthorized electrical work.',
      keyRequirements: [
        'Electrical work must be carried out by competent persons.',
        'Use suitable isolation procedures.',
        'Protect cables and electrical equipment from damage.',
        'Inspect portable electrical equipment.',
        'Use appropriate residual-current protection where applicable.',
        'Maintain safe clearances.',
      ],
      safetyControls: [
        'Lockout/tagout',
        'Electrical isolation',
        'Inspection and testing',
        'Proper earthing',
        'Cable management',
        'Suitable PPE',
        'Restricted access to electrical rooms',
      ],
      responsibilities: [
        'Management must ensure competent electrical personnel.',
        'Supervisors must verify safe isolation.',
        'Workers must not use defective equipment.',
        'HSE personnel should monitor electrical safety controls.',
      ],
      references: [
        'UAE electrical safety requirements',
        'Applicable authority requirements',
        'Company Electrical Safety Procedure',
      ],
    ),

    ReferenceTopic(
      id: 'excavation_trenching',
      title: 'Excavation & Trenching Safety',
      shortTitle: 'Excavation & Trenching',
      category: 'UAE General',
      authority: 'UAE HSE Practice',
      jurisdiction: 'UAE',
      description:
          'Safety guidance for excavation and trenching activities to prevent collapse, falls, underground service strikes and equipment-related incidents.',
      keyRequirements: [
        'Obtain required approvals before excavation.',
        'Identify underground services.',
        'Assess soil and ground conditions.',
        'Provide suitable shoring, sloping or other protection.',
        'Provide safe access and egress.',
        'Keep spoil and equipment away from excavation edges.',
      ],
      safetyControls: [
        'Excavation permit',
        'Utility scanning',
        'Barricading',
        'Safe access',
        'Shoring or sloping',
        'Daily inspection',
        'Water control',
      ],
      responsibilities: [
        'Supervisors must inspect excavations.',
        'Workers must remain within designated safe areas.',
        'Plant operators must follow exclusion zones.',
        'HSE personnel should verify excavation controls.',
      ],
      references: [
        'UAE construction safety requirements',
        'Project excavation procedure',
        'Applicable utility authority requirements',
      ],
    ),

    ReferenceTopic(
      id: 'fire_safety',
      title: 'Fire Safety',
      shortTitle: 'Fire Safety',
      category: 'UAE General',
      authority: 'UAE Civil Defence / Applicable Authority',
      jurisdiction: 'UAE',
      description:
          'General workplace fire prevention and emergency preparedness guidance covering ignition sources, fire protection, evacuation and emergency response.',
      keyRequirements: [
        'Identify fire hazards.',
        'Maintain suitable fire prevention measures.',
        'Keep emergency exits clear.',
        'Provide appropriate fire protection equipment.',
        'Maintain emergency evacuation arrangements.',
        'Conduct fire drills as required.',
      ],
      safetyControls: [
        'Fire extinguishers',
        'Fire alarm systems',
        'Emergency exits',
        'Hot work controls',
        'Good housekeeping',
        'Emergency lighting',
        'Fire drills',
      ],
      responsibilities: [
        'Management provides suitable fire protection arrangements.',
        'Supervisors maintain clear escape routes.',
        'Workers follow fire prevention procedures.',
        'Emergency teams respond according to established plans.',
      ],
      references: [
        'UAE Fire and Life Safety requirements',
        'UAE Civil Defence requirements',
        'Site Emergency Response Plan',
      ],
    ),

    ReferenceTopic(
      id: 'heat_stress',
      title: 'Heat Stress Management',
      shortTitle: 'Heat Stress',
      category: 'UAE General',
      authority: 'UAE Labour / HSE Requirements',
      jurisdiction: 'UAE',
      description:
          'Guidance for preventing heat-related illness among workers exposed to high temperatures, humidity, radiant heat and physically demanding work.',
      keyRequirements: [
        'Identify workers exposed to heat stress.',
        'Provide adequate drinking water.',
        'Provide suitable rest arrangements.',
        'Implement heat stress awareness and training.',
        'Schedule work appropriately during high-risk periods.',
        'Recognize symptoms of heat-related illness.',
      ],
      safetyControls: [
        'Potable drinking water',
        'Shaded or cooled rest areas',
        'Work-rest cycles',
        'Heat stress monitoring',
        'Worker acclimatization',
        'Suitable PPE and clothing',
        'Emergency response arrangements',
      ],
      responsibilities: [
        'Management must implement a heat stress prevention programme.',
        'Supervisors must monitor workers and environmental conditions.',
        'Workers should maintain hydration and report symptoms.',
        'HSE teams should monitor programme implementation.',
      ],
      references: [
        'UAE Midday Break requirements where applicable',
        'UAE occupational health and safety requirements',
        'Company Heat Stress Management Plan',
      ],
    ),

    ReferenceTopic(
      id: 'lifting_operations',
      title: 'Lifting Operations',
      shortTitle: 'Lifting Operations',
      category: 'UAE General',
      authority: 'UAE HSE Practice',
      jurisdiction: 'UAE',
      description:
          'Guidance for safe crane, hoist and lifting operations including planning, equipment inspection, lifting accessories and exclusion zones.',
      keyRequirements: [
        'Plan lifting operations according to the risk.',
        'Use competent lifting personnel.',
        'Inspect lifting equipment and accessories.',
        'Confirm load weight and centre of gravity.',
        'Establish exclusion zones.',
        'Use suitable communication methods.',
      ],
      safetyControls: [
        'Lifting plan',
        'Crane inspection',
        'Lifting accessory inspection',
        'Certified operators',
        'Competent riggers',
        'Banksman/signaller',
        'Exclusion zone',
      ],
      responsibilities: [
        'Lifting supervisors coordinate lifting operations.',
        'Operators operate equipment safely.',
        'Riggers connect and secure loads correctly.',
        'HSE personnel monitor compliance.',
      ],
      references: [
        'UAE lifting equipment requirements',
        'Applicable equipment standards',
        'Project lifting procedure',
      ],
    ),

    ReferenceTopic(
      id: 'personal_protective_equipment',
      title: 'Personal Protective Equipment',
      shortTitle: 'PPE',
      category: 'UAE General',
      authority: 'UAE HSE Practice',
      jurisdiction: 'UAE',
      description:
          'Guidance for selecting, providing, using, inspecting and maintaining personal protective equipment based on workplace hazards.',
      keyRequirements: [
        'PPE should be selected based on risk assessment.',
        'Provide suitable PPE to workers.',
        'Ensure correct fit and compatibility.',
        'Train workers in correct use.',
        'Inspect PPE before use.',
        'Replace damaged or defective PPE.',
      ],
      safetyControls: [
        'Hazard assessment',
        'PPE selection',
        'Worker training',
        'Inspection',
        'Maintenance',
        'Replacement',
        'PPE compliance monitoring',
      ],
      responsibilities: [
        'Employers provide suitable PPE.',
        'Supervisors enforce PPE requirements.',
        'Workers correctly wear and maintain PPE.',
        'HSE teams monitor PPE compliance.',
      ],
      references: [
        'UAE occupational safety requirements',
        'Company PPE Procedure',
        'Applicable PPE standards',
      ],
    ),

    ReferenceTopic(
      id: 'scaffolding_safety',
      title: 'Scaffolding Safety',
      shortTitle: 'Scaffolding',
      category: 'UAE General',
      authority: 'UAE HSE Practice',
      jurisdiction: 'UAE',
      description:
          'Guidance for erection, inspection, modification and safe use of scaffolding systems used for temporary access and work platforms.',
      keyRequirements: [
        'Scaffolds must be erected by competent personnel.',
        'Provide stable foundations.',
        'Install suitable guardrails and toe boards.',
        'Provide safe access.',
        'Inspect scaffolds before use and after significant changes.',
        'Clearly identify scaffold status.',
      ],
      safetyControls: [
        'Competent erection',
        'Base plates',
        'Guardrails',
        'Toe boards',
        'Safe access',
        'Scaffold inspection',
        'Load control',
      ],
      responsibilities: [
        'Scaffolders erect and modify scaffolds safely.',
        'Supervisors prevent unauthorized modifications.',
        'Workers use scaffolds correctly.',
        'HSE personnel monitor scaffold condition.',
      ],
      references: [
        'UAE construction safety requirements',
        'Applicable scaffolding standards',
        'Project scaffolding procedure',
      ],
    ),

    ReferenceTopic(
      id: 'work_at_height',
      title: 'Work at Height',
      shortTitle: 'Work at Height',
      category: 'UAE General',
      authority: 'UAE HSE Practice',
      jurisdiction: 'UAE',
      description:
          'Guidance for preventing falls from height during construction, maintenance, access and other elevated work activities.',
      keyRequirements: [
        'Avoid work at height where reasonably practicable.',
        'Assess fall hazards before work.',
        'Use suitable collective protection.',
        'Provide safe access and work platforms.',
        'Use fall protection systems where required.',
        'Inspect equipment before use.',
      ],
      safetyControls: [
        'Guardrails',
        'Scaffolding',
        'MEWPs',
        'Fall arrest systems',
        'Lifelines',
        'Safe access',
        'Exclusion zones',
      ],
      responsibilities: [
        'Management provides safe systems.',
        'Supervisors verify controls before work starts.',
        'Workers use fall protection correctly.',
        'HSE personnel inspect and monitor work-at-height activities.',
      ],
      references: [
        'UAE occupational safety requirements',
        'Project work-at-height procedure',
        'Applicable access equipment standards',
      ],
    ),

    ReferenceTopic(
      id: 'adosh_sf',
      title: 'ADOSH-SF Occupational Safety & Health',
      shortTitle: 'ADOSH-SF',
      category: 'Abu Dhabi',
      authority:
          'Abu Dhabi Occupational Safety and Health Center',
      jurisdiction: 'Abu Dhabi',
      description:
          'Reference information for occupational safety and health requirements applicable within the Abu Dhabi Emirate under the Abu Dhabi OSH framework.',
      keyRequirements: [
        'Implement applicable OSH management requirements.',
        'Identify hazards and assess risks.',
        'Maintain appropriate OSH documentation.',
        'Provide competent supervision and training.',
        'Report applicable incidents and occupational events.',
        'Monitor compliance with applicable OSH requirements.',
      ],
      safetyControls: [
        'OSH management system',
        'Risk assessment',
        'Training and competency',
        'Inspection and audit',
        'Incident reporting',
        'Emergency preparedness',
        'Corrective action tracking',
      ],
      responsibilities: [
        'Employers must implement applicable OSH requirements.',
        'Managers and supervisors are responsible for workplace controls.',
        'Workers must follow safe work practices.',
        'HSE professionals support implementation, monitoring and continual improvement.',
      ],
      references: [
        'Abu Dhabi OSH System Framework',
        'Applicable ADOSH-SF Codes of Practice',
        'Relevant Abu Dhabi OSH regulatory requirements',
      ],
    ),

    ReferenceTopic(
      id: 'dubai_construction_safety',
      title: 'Dubai Construction Safety',
      shortTitle: 'Dubai Construction Safety',
      category: 'Dubai',
      authority:
          'Dubai Municipality / Applicable Authority',
      jurisdiction: 'Dubai',
      description:
          'Reference information for construction health and safety practices applicable to projects within the Emirate of Dubai.',
      keyRequirements: [
        'Comply with applicable Dubai construction requirements.',
        'Implement project-specific HSE plans.',
        'Control high-risk construction activities.',
        'Provide competent supervision.',
        'Maintain inspection and training records.',
        'Report applicable incidents.',
      ],
      safetyControls: [
        'Risk assessment',
        'Method statements',
        'Permit systems',
        'Site inspection',
        'Worker induction',
        'Emergency preparedness',
        'Corrective actions',
      ],
      responsibilities: [
        'Project management provides resources and safe systems.',
        'Supervisors implement controls.',
        'Workers follow site procedures.',
        'HSE teams monitor compliance.',
      ],
      references: [
        'Dubai Municipality requirements',
        'Applicable Dubai construction regulations',
        'Project HSE Plan',
      ],
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ReferenceTopic> get _filteredTopics {
    final query = _searchQuery.trim().toLowerCase();

    return _topics.where((topic) {
      final matchesCategory =
          _selectedCategory == GuidelineCategory.all ||
              topic.guidelineCategory ==
                  _selectedCategory;

      final matchesSearch =
          query.isEmpty ||
              topic.title
                  .toLowerCase()
                  .contains(query) ||
              topic.shortTitle
                  .toLowerCase()
                  .contains(query) ||
              topic.description
                  .toLowerCase()
                  .contains(query) ||
              topic.category
                  .toLowerCase()
                  .contains(query) ||
              topic.authority
                  .toLowerCase()
                  .contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _openTopic(ReferenceTopic topic) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            GuidelineDetailPage(topic: topic),
      ),
    );
  }

  String _categoryLabel(
    GuidelineCategory category,
  ) {
    switch (category) {
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

  Widget _buildCategoryButton(
    GuidelineCategory category,
  ) {
    final selected =
        _selectedCategory == category;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 3,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius:
                BorderRadius.circular(14),
            onTap: () {
              setState(() {
                _selectedCategory = category;
              });
            },
            child: AnimatedContainer(
              duration:
                  const Duration(milliseconds: 180),
              height: 46,
              decoration: BoxDecoration(
                color: selected
                    ? primaryGreen
                    : Colors.white,
                borderRadius:
                    BorderRadius.circular(14),
                border: Border.all(
                  color: selected
                      ? primaryGreen
                      : Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      if (selected) ...[
                        Icon(
                          Icons.check,
                          size: 18,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 5),
                      ],
                      Text(
                        _categoryLabel(category),
                        maxLines: 1,
                        style: TextStyle(
                          color: selected
                              ? Colors.white
                              : darkGreen,
                          fontSize: 14,
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return SizedBox(
      height: 50,
      child: LayoutBuilder(
        builder: (
          context,
          constraints,
        ) {
          final categories =
              GuidelineCategory.values;

          // Four categories currently fit on normal
          // phone screens. If more categories are
          // added later, horizontal scrolling starts
          // automatically.
          if (categories.length <= 4) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 13,
              ),
              child: Row(
                children: [
                  for (final category in categories)
                    _buildCategoryButton(
                      category,
                    ),
                ],
              ),
            );
          }

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            physics:
                const BouncingScrollPhysics(),
            itemCount: categories.length,
            separatorBuilder: (
              context,
              index,
            ) =>
                const SizedBox(width: 8),
            itemBuilder: (
              context,
              index,
            ) {
              final category =
                  categories[index];

              final selected =
                  _selectedCategory ==
                      category;

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(14),
                  onTap: () {
                    setState(() {
                      _selectedCategory =
                          category;
                    });
                  },
                  child: Container(
                    height: 46,
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? primaryGreen
                          : Colors.white,
                      borderRadius:
                          BorderRadius.circular(14),
                      border: Border.all(
                        color: selected
                            ? primaryGreen
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize:
                            MainAxisSize.min,
                        children: [
                          if (selected) ...[
                            const Icon(
                              Icons.check,
                              size: 18,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                          Text(
                            _categoryLabel(
                              category,
                            ),
                            style: TextStyle(
                              color: selected
                                  ? Colors.white
                                  : darkGreen,
                              fontWeight:
                                  FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topics = _filteredTopics;

    return Scaffold(
      backgroundColor: pageBackground,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'UAE HSE Guidelines',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // --------------------------------------------------
            // HEADER
            // --------------------------------------------------
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.fromLTRB(
                16,
                18,
                16,
                18,
              ),
              decoration:
                  const BoxDecoration(
                color: primaryGreen,
                borderRadius:
                    BorderRadius.only(
                  bottomLeft:
                      Radius.circular(24),
                  bottomRight:
                      Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Professional HSE Reference',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'UAE-wide safety guidance and emirate-specific references',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // SEARCH
                  TextField(
                    controller:
                        _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery =
                            value;
                      });
                    },
                    textInputAction:
                        TextInputAction.search,
                    decoration:
                        InputDecoration(
                      hintText:
                          'Search HSE guidelines...',
                      hintStyle:
                          TextStyle(
                        color:
                            Colors.grey.shade600,
                      ),
                      prefixIcon:
                          const Icon(
                        Icons.search,
                        size: 28,
                      ),
                      suffixIcon:
                          _searchQuery
                                  .isNotEmpty
                              ? IconButton(
                                  icon:
                                      const Icon(
                                    Icons.clear,
                                  ),
                                  onPressed:
                                      () {
                                    _searchController
                                        .clear();

                                    setState(() {
                                      _searchQuery =
                                          '';
                                    });
                                  },
                                )
                              : null,
                      filled: true,
                      fillColor:
                          Colors.white,
                      contentPadding:
                          const EdgeInsets
                              .symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          16,
                        ),
                        borderSide:
                            BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // --------------------------------------------------
            // CATEGORY SELECTOR
            // --------------------------------------------------
            _buildCategorySelector(),

            const SizedBox(height: 10),

            // --------------------------------------------------
            // SECTION HEADER
            // --------------------------------------------------
            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                children: [
                  const Text(
                    'Guidelines',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight:
                          FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    '${topics.length} topics',
                    style: TextStyle(
                      color:
                          Colors.grey.shade700,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // --------------------------------------------------
            // TOPIC LIST
            // --------------------------------------------------
            Expanded(
              child: topics.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior
                              .onDrag,
                      padding:
                          const EdgeInsets
                              .fromLTRB(
                        16,
                        4,
                        16,
                        24,
                      ),
                      itemCount:
                          topics.length,
                      itemBuilder:
                          (context, index) {
                        return _buildTopicCard(
                          topics[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicCard(
    ReferenceTopic topic,
  ) {
    return Card(
      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),
      elevation: 1.5,
      color: Colors.white,
      shadowColor:
          Colors.black12,
      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(
          18,
        ),
      ),
      child: InkWell(
        borderRadius:
            BorderRadius.circular(
          18,
        ),
        onTap: () =>
            _openTopic(topic),
        child: Padding(
          padding:
              const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              // ICON
              Container(
                width: 52,
                height: 52,
                decoration:
                    BoxDecoration(
                  color:
                      primaryGreen.withValues(
                    alpha: 0.10,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),
                child: Icon(
                  _categoryIcon(
                    topic.category,
                  ),
                  color:
                      primaryGreen,
                  size: 27,
                ),
              ),

              const SizedBox(width: 14),

              // CONTENT
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      topic.title,
                      maxLines: 2,
                      overflow:
                          TextOverflow
                              .ellipsis,
                      style:
                          const TextStyle(
                        fontSize: 16,
                        height: 1.25,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            darkGreen,
                      ),
                    ),

                    const SizedBox(
                      height: 7,
                    ),

                    Text(
                      topic.description,
                      maxLines: 3,
                      overflow:
                          TextOverflow
                              .ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.35,
                        color:
                            Colors.grey
                                .shade700,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Wrap(
                      spacing: 7,
                      runSpacing: 5,
                      children: [
                        _buildTag(
                          topic.category,
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

              const SizedBox(width: 6),

              // ARROW
              const Padding(
                padding:
                    EdgeInsets.only(
                  top: 2,
                ),
                child: Icon(
                  Icons
                      .arrow_forward_ios,
                  size: 16,
                  color:
                      Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(
    String text,
    Color color,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration:
          BoxDecoration(
        color:
            color.withValues(
          alpha: 0.09,
        ),
        borderRadius:
            BorderRadius.circular(
          20,
        ),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow:
            TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight:
              FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(
          30,
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color:
                  Colors.grey.shade400,
            ),

            const SizedBox(
              height: 14,
            ),

            const Text(
              'No guidelines found',
              style: TextStyle(
                fontSize: 19,
                fontWeight:
                    FontWeight.bold,
                color: darkGreen,
              ),
            ),

            const SizedBox(
              height: 7,
            ),

            Text(
              'Try another search term or category.',
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                color:
                    Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
