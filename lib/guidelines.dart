import 'package:flutter/material.dart';

class GuidelinesPage extends StatefulWidget {
  const GuidelinesPage({super.key});

  @override
  State<GuidelinesPage> createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  final TextEditingController _searchController = TextEditingController();

  String _query = '';

  static const List<_ReferenceTopic> _topics = [
    _ReferenceTopic(
      title: 'Code of Practice',
      description:
          'Practical safety requirements and good working practices for HSE activities in UAE workplaces.',
      purpose:
          'Use applicable Codes of Practice, approved procedures and project requirements to establish safe systems of work.',
      hazards:
          'Non-compliance • Poor planning • Inadequate supervision • Incorrect work methods • Uncontrolled changes.',
      controls:
          'Identify applicable requirements • Review approved procedures • Risk assess the activity • Train workers • Supervise work • Inspect and review compliance.',
      ppe:
          'PPE must be selected according to the task risk assessment and applicable workplace requirements.',
      practice:
          'Always verify the latest applicable authority requirements, approved project procedures and employer standards before starting work.',
      checklist:
          'Applicable requirement identified • Procedure available • Risk assessment completed • Workers briefed • Competent supervision • Inspection and review.',
    ),
    _ReferenceTopic(
      title: 'Lifting',
      description:
          'Safe planning and control of lifting operations involving cranes, lifting equipment, accessories and loads.',
      purpose:
          'Prevent dropped loads, equipment failure, struck-by incidents and uncontrolled lifting operations.',
      hazards:
          'Dropped loads • Overloading • Equipment failure • Poor ground conditions • Suspended loads • Pinch points • Poor communication.',
      controls:
          'Approved lift plan • Competent lifting team • Certified equipment • Load assessment • Ground condition check • Exclusion zone • Clear communication • Weather monitoring.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Gloves • Eye protection and task-specific PPE.',
      practice:
          'Never stand under a suspended load. Inspect lifting accessories before use and ensure the load is within equipment capacity.',
      checklist:
          'Lift plan • Load weight known • Equipment certified • Accessories inspected • Ground checked • Exclusion zone established • Competent operator • Banksman/signaller.',
    ),
    _ReferenceTopic(
      title: 'Excavation',
      description:
          'Controls for excavation, trenching and underground work to prevent collapse, falls, service strikes and flooding.',
      purpose:
          'Protect workers from excavation collapse, falling materials, underground services and access hazards.',
      hazards:
          'Cave-in • Underground utilities • Falls into excavation • Falling materials • Water ingress • Plant movement • Hazardous atmosphere.',
      controls:
          'Permit where required • Service identification • Safe slope or shoring • Safe access • Edge protection • Spoil setback • Inspection • Water control.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Gloves • Eye protection • Task-specific PPE.',
      practice:
          'Excavations should be inspected by a competent person, particularly after changes in conditions, rain or other events that may affect stability.',
      checklist:
          'Services identified • Excavation assessed • Shoring/slope provided • Safe access • Edge protection • Spoil controlled • Plant separated • Inspection completed.',
    ),
    _ReferenceTopic(
      title: 'Scaffolding',
      description:
          'Safe erection, alteration, inspection and use of scaffolding and temporary access platforms.',
      purpose:
          'Provide stable and safe working platforms and prevent falls, collapse and falling objects.',
      hazards:
          'Falls from height • Scaffold collapse • Falling objects • Overloading • Unsafe access • Poor foundation.',
      controls:
          'Competent erection • Suitable foundation • Proper bracing • Guardrails • Toe boards • Safe access • Inspection • Load control • Tagging system.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Full body harness where required by the safe system of work.',
      practice:
          'Do not use incomplete, damaged or uninspected scaffolding. Do not modify scaffolding unless authorized and carried out by competent personnel.',
      checklist:
          'Foundation stable • Structure braced • Guardrails • Toe boards • Safe access • Load capacity known • Inspection/tag • No unauthorized modification.',
    ),
    _ReferenceTopic(
      title: 'Working at Height',
      description:
          'Controls to prevent falls while working at elevated locations or where a person could fall.',
      purpose:
          'Prevent falls through planning, safe access, collective protection and suitable fall protection.',
      hazards:
          'Falls • Falling objects • Fragile surfaces • Unsafe ladders • Open edges • Poor weather • Rescue difficulties.',
      controls:
          'Avoid work at height where possible • Safe access • Edge protection • Guardrails • Suitable platforms • Fall restraint/arrest • Inspection • Rescue plan.',
      ppe:
          'Safety helmet with chin strap where required • Safety footwear • Full body harness and suitable lanyard/fall protection equipment where required.',
      practice:
          'Use collective fall prevention before personal fall protection wherever reasonably practicable. Ensure rescue arrangements are available.',
      checklist:
          'Work planned • Height avoided where possible • Safe platform • Edge protection • Equipment inspected • Harness suitable • Anchor verified • Rescue plan.',
    ),
    _ReferenceTopic(
      title: 'Power Tools',
      description:
          'Safe selection, inspection, operation and maintenance of portable power tools.',
      purpose:
          'Prevent cuts, electric shock, flying particles, burns, noise and other tool-related injuries.',
      hazards:
          'Cuts • Entanglement • Electric shock • Flying particles • Noise • Vibration • Damaged accessories.',
      controls:
          'Correct tool selection • Pre-use inspection • Guards • Suitable accessories • Electrical protection • Maintenance • Competent operation.',
      ppe:
          'Safety glasses/face protection • Hearing protection • Safety footwear • Gloves where appropriate and safe for the specific tool.',
      practice:
          'Never remove guards or use damaged tools. Select accessories compatible with the tool and intended work.',
      checklist:
          'Correct tool • Guard fitted • Cable checked • Plug checked • Accessory suitable • Inspection completed • PPE • Competent user.',
    ),
    _ReferenceTopic(
      title: 'Formwork',
      description:
          'Safety controls for formwork erection, support, concrete placement and stripping operations.',
      purpose:
          'Prevent formwork collapse, falls, struck-by incidents and uncontrolled concrete loads.',
      hazards:
          'Collapse • Falls • Falling materials • Overloading • Concrete pressure • Unsafe stripping.',
      controls:
          'Approved design • Competent erection • Stable supports • Inspection • Controlled loading • Safe access • Controlled stripping sequence.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Eye protection • Fall protection where required.',
      practice:
          'Do not alter or overload formwork without authorization. Inspect before concrete placement and after significant changes.',
      checklist:
          'Design approved • Supports stable • Bracing checked • Access safe • Inspection completed • Load controlled • Stripping plan.',
    ),
    _ReferenceTopic(
      title: 'Permit to Work',
      description:
          'A formal system for controlling high-risk activities through authorization, precautions and close-out.',
      purpose:
          'Ensure high-risk work is properly assessed, authorized, isolated and controlled.',
      hazards:
          'Uncontrolled high-risk work • Inadequate isolation • Conflicting activities • Poor communication • Premature restart.',
      controls:
          'Task identification • Risk assessment • Isolation • Permit authorization • Toolbox talk • Precautions • Monitoring • Permit close-out.',
      ppe:
          'PPE must be based on the permitted task and risk assessment.',
      practice:
          'A permit does not replace risk assessment or supervision. Work must stop if conditions change or permit controls become invalid.',
      checklist:
          'Correct permit • Risk assessment • Isolation verified • Precautions applied • Workers briefed • Authorization • Monitoring • Close-out.',
    ),
    _ReferenceTopic(
      title: 'Working in Hot and Humid Climate',
      description:
          'Controls to reduce heat stress and heat-related illness during hot and humid working conditions.',
      purpose:
          'Protect workers from heat exhaustion, heat stroke, dehydration and reduced concentration.',
      hazards:
          'Heat exhaustion • Heat stroke • Dehydration • Fatigue • Reduced concentration • Increased accident risk.',
      controls:
          'Drinking water • Rest • Shade • Work/rest planning • Acclimatization • Heat awareness • Supervision • Early symptom reporting.',
      ppe:
          'Suitable work clothing • Safety footwear • Head protection • Task-specific PPE. PPE must not replace heat-control measures.',
      practice:
          'Encourage regular hydration and rest. Workers should immediately report symptoms such as dizziness, weakness, confusion or excessive fatigue.',
      checklist:
          'Water available • Rest/shade available • Heat plan • Worker briefing • Acclimatization • Work/rest schedule • Supervision • Emergency response.',
    ),
    _ReferenceTopic(
      title: 'Confined Space',
      description:
          'Safety controls for work in tanks, chambers, pits and other spaces with restricted entry or hazardous conditions.',
      purpose:
          'Prevent fatalities from oxygen deficiency, toxic gases, fire, engulfment and difficult rescue.',
      hazards:
          'Oxygen deficiency • Toxic gases • Flammable atmosphere • Engulfment • Restricted access • Heat • Difficult rescue.',
      controls:
          'Permit • Isolation • Atmospheric testing • Ventilation • Communication • Attendant • Rescue arrangements • Competent workers.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Eye protection • Respiratory protection where required • Harness where required.',
      practice:
          'Atmospheric testing must be appropriate to the identified hazards. Never enter a confined space to perform an unplanned rescue without suitable controls.',
      checklist:
          'Permit • Isolation • Gas test • Ventilation • Attendant • Communication • Rescue plan • Rescue equipment • Competent workers.',
    ),
    _ReferenceTopic(
      title: 'Working Near Live Road',
      description:
          'Traffic and pedestrian controls for construction and maintenance activities near live roads.',
      purpose:
          'Protect workers, pedestrians and road users from vehicle-related incidents.',
      hazards:
          'Vehicle collision • Reversing • Poor visibility • Unauthorized access • Speeding • Night work hazards.',
      controls:
          'Traffic management plan • Barriers • Warning signs • Lighting • Trained flaggers • High-visibility PPE • Safe pedestrian routes • Speed control.',
      ppe:
          'High-visibility clothing • Safety footwear • Safety helmet • Task-specific PPE.',
      practice:
          'Maintain clear separation between workers and moving traffic. Follow the approved traffic management arrangement and authority requirements.',
      checklist:
          'Traffic plan • Signs • Barriers • Lighting • Pedestrian route • Trained personnel • High visibility • Speed/reversing controls.',
    ),
    _ReferenceTopic(
      title: 'Concreting',
      description:
          'Safety controls for concrete delivery, pumping, placing, vibrating and finishing operations.',
      purpose:
          'Control hazards associated with concrete pumps, hoses, reinforcement, wet concrete and moving equipment.',
      hazards:
          'Hose movement • Pump failure • Concrete splash • Chemical burns • Trips • Falls • Vehicle movement.',
      controls:
          'Pump inspection • Hose control • Exclusion zone • Safe access • Reinforcement protection • Communication • Emergency arrangements.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Eye protection • Suitable protective clothing.',
      practice:
          'Keep personnel clear of uncontrolled pump hoses and establish communication between pump operator and placing team.',
      checklist:
          'Pump inspected • Hose secure • Exclusion zone • Communication • Safe access • Reinforcement protected • PPE • Wash facilities.',
    ),
    _ReferenceTopic(
      title: 'Barricading of Hazards',
      description:
          'Use of barriers, warning signs and access controls to prevent exposure to hazardous areas.',
      purpose:
          'Prevent unauthorized entry and clearly communicate hazards to workers and visitors.',
      hazards:
          'Falls • Openings • Moving equipment • Excavations • Electrical hazards • Restricted areas.',
      controls:
          'Identify hazard • Select suitable barrier • Warning signs • Restricted access • Visibility • Inspection • Maintain barriers.',
      ppe:
          'PPE must be based on the hazard within the controlled area.',
      practice:
          'Barricades must be strong enough and suitable for the hazard. A simple warning tape may not provide adequate protection for serious hazards.',
      checklist:
          'Hazard identified • Correct barrier • Warning sign • Access controlled • Visibility • Barrier inspected • Removed only when hazard eliminated.',
    ),
    _ReferenceTopic(
      title: 'Worker Welfare',
      description:
          'Workplace welfare arrangements covering drinking water, sanitation, rest, hygiene and worker wellbeing.',
      purpose:
          'Provide suitable basic welfare facilities that support worker health, hygiene and safe performance.',
      hazards:
          'Dehydration • Poor hygiene • Fatigue • Heat stress • Unsanitary conditions • Poor recovery.',
      controls:
          'Drinking water • Toilets • Washing facilities • Rest areas • Hygiene • Heat protection • Clean facilities.',
      ppe:
          'PPE is task-specific and does not replace suitable welfare facilities.',
      practice:
          'Facilities should be accessible, clean, maintained and suitable for the workforce and working environment.',
      checklist:
          'Drinking water • Toilets • Washing • Rest area • Hygiene • Cleaning • Heat protection • Facility inspection.',
    ),
    _ReferenceTopic(
      title: 'Mobile Elevated Working Platform (MEWP)',
      description:
          'Safe use of boom lifts, scissor lifts and other mobile elevated work platforms.',
      purpose:
          'Prevent falls, overturning, entrapment, collisions and equipment-related incidents.',
      hazards:
          'Falls • Overturning • Entrapment • Collision • Overhead hazards • Ground instability • Equipment failure.',
      controls:
          'Competent operator • Pre-use inspection • Ground assessment • Guardrails • Safe positioning • Exclusion zone • Emergency lowering plan.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Harness where required by equipment and safe system of work.',
      practice:
          'Operate only within manufacturer limits and site requirements. Never use a MEWP as a crane or exceed its rated capacity.',
      checklist:
          'Operator authorized • Pre-use inspection • Ground checked • Guardrails • Capacity known • Overhead hazards • Exclusion zone • Emergency lowering.',
    ),
    _ReferenceTopic(
      title: 'Electricity on Site & Electrical Tools',
      description:
          'Electrical safety controls for temporary site power, cables, distribution boards and electrical tools.',
      purpose:
          'Prevent electric shock, burns, fire and electrical equipment damage.',
      hazards:
          'Electric shock • Arc flash • Damaged cables • Overloading • Poor earthing • Water exposure • Unauthorized work.',
      controls:
          'Competent persons • Isolation • Inspection • Suitable distribution • RCD/GFCI where applicable • Cable protection • Earthing • Lockout where required.',
      ppe:
          'Electrical-rated PPE where required • Safety footwear • Eye/face protection • Arc-flash PPE where applicable.',
      practice:
          'Do not use damaged electrical tools, plugs or cables. Electrical work should be carried out only by suitably competent and authorized persons.',
      checklist:
          'Competent person • Isolation • Cable inspection • Plug inspection • Protection device • Earthing • Weather protection • Tool inspection.',
    ),
    _ReferenceTopic(
      title: 'Temporary Works',
      description:
          'Planning, design, installation, inspection and control of temporary structures and support systems.',
      purpose:
          'Prevent failure of temporary structures, supports and construction systems.',
      hazards:
          'Structural failure • Collapse • Overloading • Poor installation • Unauthorized modification • Inadequate inspection.',
      controls:
          'Design approval • Competent supervision • Installation inspection • Load control • Monitoring • Modification control • Safe removal.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Eye protection • Fall protection where required.',
      practice:
          'Temporary works should be designed and controlled according to the approved temporary works process and project requirements.',
      checklist:
          'Design approved • Competent supervision • Materials suitable • Installation checked • Load controlled • Inspection • Modification controlled.',
    ),
    _ReferenceTopic(
      title: 'Manual Handling',
      description:
          'Safe techniques and controls for lifting, carrying, pushing and pulling loads manually.',
      purpose:
          'Reduce strains, sprains and musculoskeletal injuries.',
      hazards:
          'Heavy loads • Awkward posture • Repetitive work • Poor grip • Long carrying distances • Unexpected load movement.',
      controls:
          'Avoid unnecessary manual handling • Mechanical aids • Reduce load • Team lifting • Good technique • Suitable work height.',
      ppe:
          'Safety footwear • Suitable gloves • Other task-specific PPE.',
      practice:
          'Assess the task before lifting. Use mechanical assistance whenever reasonably practicable and avoid twisting while carrying loads.',
      checklist:
          'Task assessed • Load weight known • Mechanical aid considered • Route clear • Team lift if required • Correct technique • PPE.',
    ),
    _ReferenceTopic(
      title: 'Hot Works',
      description:
          'Safety controls for welding, cutting, grinding and other activities producing heat, sparks or flames.',
      purpose:
          'Prevent fire, explosion, burns, smoke exposure and damage caused by hot work.',
      hazards:
          'Fire • Explosion • Burns • Sparks • Toxic fumes • Gas cylinder hazards • Eye injury.',
      controls:
          'Hot work permit • Fire watch • Remove combustibles • Fire extinguishers • Gas cylinder control • Screens • Ventilation • Post-work inspection.',
      ppe:
          'Welding helmet/goggles • Welding gloves • Flame-resistant clothing • Safety footwear • Face shield where required.',
      practice:
          'Inspect the work area before starting. Maintain suitable fire protection and continue fire watch/post-work checks according to the approved procedure.',
      checklist:
          'Permit • Area inspected • Combustibles removed • Fire extinguisher • Fire watch • Gas cylinders secured • PPE • Post-work inspection.',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_ReferenceTopic> _filteredTopics() {
    final query = _query.trim().toLowerCase();

    if (query.isEmpty) {
      return _topics;
    }

    return _topics.where((topic) {
      return topic.title.toLowerCase().contains(query) ||
          topic.description.toLowerCase().contains(query) ||
          topic.purpose.toLowerCase().contains(query) ||
          topic.hazards.toLowerCase().contains(query) ||
          topic.controls.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final topics = _filteredTopics();
    final searching = _query.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: const Text(
          'HSE Guidelines',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        children: [
          _buildIntroCard(),
          const SizedBox(height: 18),
          _buildSearchField(),
          const SizedBox(height: 22),
          _buildSectionHeader(
            searching ? 'SEARCH RESULTS' : 'SAFETY REFERENCE LIBRARY',
            searching
                ? '${topics.length} topics found'
                : '${topics.length} practical HSE topics',
          ),
          const SizedBox(height: 12),
          if (topics.isEmpty)
            _buildEmptyState()
          else
            ...topics.asMap().entries.map(
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
                  'UAE HSE Safety Reference',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Practical HSE guidance for learning, site reference and safety awareness.',
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
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFF159447),
            width: 1.4,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'HSE REFERENCE',
          style: TextStyle(
            color: Color(0xFF087A38),
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
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
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => GuidelineDetailPage(topic: topic),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
            'Try a different keyword or search by HSE topic.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF777777)),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// GUIDELINE DETAIL PAGE
// ============================================================

class GuidelineDetailPage extends StatelessWidget {
  final _ReferenceTopic topic;

  const GuidelineDetailPage({
    super.key,
    required this.topic,
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
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroCard(),
            const SizedBox(height: 16),
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
              content: topic.practice,
            ),
            _infoCard(
              icon: Icons.checklist_rounded,
              title: 'Quick Checklist',
              content: topic.checklist,
            ),
            _infoCard(
              icon: Icons.gavel_rounded,
              title: 'Important Reference Note',
              content:
                  'This page is intended for general HSE learning and workplace reference. Always verify the latest applicable UAE legislation, authority requirements, Code of Practice, approved project procedures, risk assessment and method statement before making compliance decisions.',
            ),
            const SizedBox(height: 8),
            const Text(
              'SafeNexus HSE',
              style: TextStyle(
                color: Color(0xFF159447),
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'UAE HSE Safety Reference Library',
              style: TextStyle(
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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0B5D4B),
            Color(0xFF159447),
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
                  topic.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'HSE Safety Reference',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  topic.description,
                  style: const TextStyle(
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
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF159447),
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

// ============================================================
// DATA MODEL
// ============================================================

class _ReferenceTopic {
  final String title;
  final String description;
  final String purpose;
  final String hazards;
  final String controls;
  final String ppe;
  final String practice;
  final String checklist;

  const _ReferenceTopic({
    required this.title,
    required this.description,
    required this.purpose,
    required this.hazards,
    required this.controls,
    required this.ppe,
    required this.practice,
    required this.checklist,
  });
}
