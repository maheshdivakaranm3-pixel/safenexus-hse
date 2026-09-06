import 'package:flutter/material.dart';

class GuidelinesPage extends StatefulWidget {
  const GuidelinesPage({super.key});

  @override
  State<GuidelinesPage> createState() => _GuidelinesPageState();
}

enum _GuidelineCategory {
  uae,
  abuDhabi,
  dubai,
  general,
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  final TextEditingController _searchController = TextEditingController();

  String _query = '';

  static const List<_ReferenceTopic> _topics = [
    // ==========================================================
    // 🇦🇪 UAE SAFETY — FEDERAL / UAE-WIDE
    // ==========================================================

    _ReferenceTopic(
      category: _GuidelineCategory.uae,
      title: 'UAE Workplace Safety',
      shortDescription:
          'Federal-level workplace health and safety responsibilities and general requirements applicable across the UAE.',
      overview:
          'This section provides a UAE-wide HSE baseline. Employers and workers must comply with applicable federal occupational health and safety requirements and with requirements issued by competent authorities.',
      hazards:
          'Occupational injuries • Unsafe work practices • Inadequate training • Missing PPE • Poor supervision • Failure to control workplace hazards.',
      controls:
          'Risk assessment • Worker training • Appropriate PPE • Safe work procedures • Competent supervision • Periodic inspection • Incident reporting.',
      planning:
          'Identify the applicable federal and competent-authority requirements for the activity. Review workplace hazards, risk controls, worker competence, emergency arrangements and project procedures before work starts.',
      safePractices:
          'Follow approved workplace procedures. Use required PPE. Report hazards and incidents. Follow instructions from competent supervisors and HSE personnel.',
      ppe:
          'PPE shall be selected according to the activity risk assessment and applicable requirements. Typical construction PPE includes safety helmet, safety footwear, high-visibility clothing and eye protection.',
      checklist:
          'Applicable requirements identified • Risk assessment available • Workers trained • PPE available • Emergency arrangements • Competent supervision • Inspection completed • Records maintained.',
      inspection:
          'Check workplace conditions • PPE • signage • access • housekeeping • emergency arrangements • training records • risk controls.',
      dos:
          'Follow applicable UAE requirements. Use approved procedures. Report hazards. Attend required training and toolbox talks.',
      donts:
          'Do not ignore workplace hazards. Do not bypass safety controls. Do not use defective PPE or equipment.',
      stopWork:
          'Stop work when an immediate serious danger exists, required controls are missing or conditions have changed significantly.',
      emergency:
          'Raise the alarm, protect people from further danger, contact the site emergency response team and follow the approved emergency procedure.',
      reference:
          'UAE Federal workplace HSE requirements / MoHRE and other competent-authority requirements.',
    ),

    _ReferenceTopic(
      category: _GuidelineCategory.uae,
      title: 'Heat Stress & Midday Break',
      shortDescription:
          'UAE-wide heat-stress prevention, hydration, rest and summer midday work restrictions.',
      overview:
          'Heat stress can affect worker health and safety, especially during outdoor work in hot and humid conditions. UAE requirements include specific summer work restrictions and worker protection measures.',
      hazards:
          'Heat exhaustion • Heat stroke • Dehydration • Fatigue • Reduced concentration • Increased incident risk.',
      controls:
          'Drinking water • Rest/cooling • Shade • Work planning • Acclimatization • Heat-stress awareness • Worker monitoring • Emergency response.',
      planning:
          'Plan outdoor work according to applicable UAE summer requirements and site conditions. Consider work intensity, environmental conditions, worker acclimatization and available cooling arrangements.',
      safePractices:
          'Drink water regularly. Use planned recovery periods. Use shaded or cooled rest areas. Report symptoms early. Follow the approved heat-stress management plan.',
      ppe:
          'Safety helmet • Safety footwear • Suitable work clothing • Task-specific PPE. PPE selection should also consider heat burden.',
      checklist:
          'Heat-stress plan • Drinking water • Rest/shade • Worker awareness • Work scheduling • Acclimatization • Supervision • Emergency arrangements.',
      inspection:
          'Check water • shade/rest facilities • worker condition • work schedule • heat-stress communication • emergency arrangements.',
      dos:
          'Follow applicable summer work restrictions. Hydrate regularly. Take planned recovery breaks. Report heat-stress symptoms immediately.',
      donts:
          'Do not ignore symptoms. Do not rely on PPE alone to control heat stress. Do not continue unsafe work when serious heat illness is suspected.',
      stopWork:
          'Stop or modify work when heat-related illness is suspected or required heat controls are unavailable.',
      emergency:
          'Move the affected worker to a safe cooler location and activate the site medical/emergency procedure. Suspected serious heat illness requires urgent medical attention.',
      reference:
          'UAE Government / MoHRE workplace health and safety requirements.',
    ),

    _ReferenceTopic(
      category: _GuidelineCategory.uae,
      title: 'Worker Welfare',
      shortDescription:
          'General worker welfare, hygiene, drinking water, sanitation and suitable rest arrangements.',
      overview:
          'Worker welfare facilities support health, hygiene and safe performance. Requirements can vary according to federal rules, competent authorities, project conditions and the nature of the workplace.',
      hazards:
          'Dehydration • Poor hygiene • Heat stress • Fatigue • Unsanitary conditions.',
      controls:
          'Safe drinking water • Toilets • Washing facilities • Rest areas • Cleaning • Waste management • Heat protection.',
      planning:
          'Assess workforce size, location, work duration and environmental conditions. Provide suitable welfare arrangements for the workforce.',
      safePractices:
          'Keep welfare facilities clean and accessible. Replenish drinking water. Report deficiencies promptly.',
      ppe:
          'PPE is task-specific and does not replace welfare controls.',
      checklist:
          'Drinking water • Toilets • Washing facilities • Rest area • Cleaning • Waste disposal • Heat protection • Accessibility.',
      inspection:
          'Check water supply • sanitation • washing facilities • rest areas • cleanliness • waste disposal.',
      dos:
          'Maintain clean welfare facilities. Ensure workers can access water and rest facilities.',
      donts:
          'Do not allow essential welfare facilities to remain unavailable or unhygienic.',
      stopWork:
          'Escalate or stop affected work where essential welfare controls are unavailable and worker health could be affected.',
      emergency:
          'Activate medical or emergency arrangements for heat illness, dehydration or other welfare-related emergencies.',
      reference:
          'Applicable UAE federal and competent-authority workplace requirements.',
    ),

    // ==========================================================
    // 🟣 ABU DHABI SAFETY — ADOSH-SF
    // ==========================================================

    _ReferenceTopic(
      category: _GuidelineCategory.abuDhabi,
      title: 'ADOSH-SF Framework',
      shortDescription:
          'Abu Dhabi Occupational Safety and Health System Framework and its Codes of Practice.',
      overview:
          'Abu Dhabi has its own Occupational Safety and Health framework known as ADOSH-SF. Its Codes of Practice establish mandatory OSH technical requirements for applicable subjects.',
      hazards:
          'Incorrect regulatory interpretation • Outdated documents • Missing applicable CoP • Inadequate OSH management • Poor implementation.',
      controls:
          'Identify applicable ADOSH-SF requirements • Use current versions • Implement OSH management controls • Maintain competent personnel • Verify compliance.',
      planning:
          'Determine whether the activity is subject to an ADOSH-SF Code of Practice. Confirm the current version and applicable requirements before preparing project controls.',
      safePractices:
          'Use the current official ADPHC/ADOSH-SF documents. Ensure project procedures and risk controls are consistent with applicable requirements.',
      ppe:
          'Use the PPE requirements applicable to the activity and the relevant ADOSH-SF Code of Practice.',
      checklist:
          'Applicable CoP identified • Current version verified • OSH requirements reviewed • Risk assessment • Procedures • Competent personnel • Records.',
      inspection:
          'Verify applicable CoPs • document versions • implementation • training • inspections • corrective actions.',
      dos:
          'Use current official ADOSH-SF documents. Verify emirate-specific requirements before compliance decisions.',
      donts:
          'Do not treat a generic UAE guideline as a substitute for an applicable Abu Dhabi requirement.',
      stopWork:
          'Stop or suspend work when required ADOSH-SF controls are absent or the work cannot be safely performed according to the approved system.',
      emergency:
          'Follow the project emergency arrangements and applicable Abu Dhabi OSH requirements.',
      reference:
          'Abu Dhabi Public Health Centre (ADPHC) — ADOSH-SF official legislation and Codes of Practice.',
    ),

    _ReferenceTopic(
      category: _GuidelineCategory.abuDhabi,
      title: 'Abu Dhabi Construction OSH',
      shortDescription:
          'Construction occupational safety management requirements specific to Abu Dhabi.',
      overview:
          'Construction activities in Abu Dhabi are subject to the applicable ADOSH-SF requirements, including construction OSH management requirements and relevant Codes of Practice.',
      hazards:
          'Falls • Struck-by incidents • Lifting hazards • Excavation collapse • Electrical hazards • Temporary works failure • Poor coordination.',
      controls:
          'OSH management system • Risk assessment • Construction OSH planning • Competent supervision • Inspections • Training • Corrective action.',
      planning:
          'Review the applicable ADOSH-SF construction requirements before project activities begin. Ensure the project OSH management arrangements reflect actual site risks.',
      safePractices:
          'Follow approved project OSH procedures. Maintain competent supervision and conduct planned inspections.',
      ppe:
          'PPE shall comply with the applicable risk assessment and relevant ADOSH-SF requirements.',
      checklist:
          'Construction OSH plan • Risk assessment • Competent personnel • Training • Inspection • Emergency arrangements • Corrective actions.',
      inspection:
          'Check implementation of the approved OSH system, site controls, inspections and corrective actions.',
      dos:
          'Verify current ADOSH-SF requirements. Maintain documented OSH arrangements.',
      donts:
          'Do not use outdated Abu Dhabi OSH documents as the sole basis for compliance.',
      stopWork:
          'Stop work where critical OSH controls required by the approved system are missing.',
      emergency:
          'Follow the project emergency plan and Abu Dhabi-specific emergency requirements.',
      reference:
          'ADOSH-SF CoP 53 / CoP 53.1 and other applicable ADOSH-SF requirements.',
    ),

    _ReferenceTopic(
      category: _GuidelineCategory.abuDhabi,
      title: 'Abu Dhabi Lifting Safety',
      shortDescription:
          'Lifting safety requirements to be considered with applicable ADOSH-SF requirements.',
      overview:
          'Lifting operations in Abu Dhabi must be planned and controlled using the applicable ADOSH-SF requirements together with equipment, manufacturer and project requirements.',
      hazards:
          'Dropped loads • Overloading • Equipment failure • Unstable ground • Suspended loads • Crushing • Poor communication.',
      controls:
          'Lift planning • Competent personnel • Suitable inspected equipment • Correct accessories • Load verification • Ground assessment • Exclusion zone • Communication.',
      planning:
          'Verify applicable Abu Dhabi requirements before preparing the lift plan. Confirm equipment capacity, load information, ground conditions, lifting route and emergency arrangements.',
      safePractices:
          'Use suitable inspected equipment and accessories. Maintain exclusion zones. Keep people away from suspended loads.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Gloves • Eye protection • Task-specific PPE.',
      checklist:
          'Lift plan • Competent team • Equipment inspection • SWL verification • Accessories • Ground condition • Exclusion zone • Communication.',
      inspection:
          'Check equipment, accessories, ground, exclusion zone and communication arrangements.',
      dos:
          'Follow the approved lift plan and applicable Abu Dhabi requirements.',
      donts:
          'Never exceed equipment capacity. Never stand under suspended loads.',
      stopWork:
          'Stop the lift for equipment defects, uncertain load information, unstable ground or loss of communication.',
      emergency:
          'Stop the operation, isolate the area and activate the site emergency response.',
      reference:
          'Applicable ADOSH-SF lifting requirements and current official ADPHC Codes of Practice.',
    ),

    // ==========================================================
    // 🟠 DUBAI SAFETY — DUBAI MUNICIPALITY
    // ==========================================================

    _ReferenceTopic(
      category: _GuidelineCategory.dubai,
      title: 'Dubai Construction Safety',
      shortDescription:
          'Dubai Municipality construction safety requirements and approved safety guidance.',
      overview:
          'Construction work in Dubai is subject to Dubai Municipality requirements, including the applicable Construction Works Safety Practice and the current Safety Guide for Construction Works in the Emirate of Dubai.',
      hazards:
          'Construction falls • Vehicle interaction • Falling objects • Unsafe excavation • Lifting hazards • Poor site access • Inadequate barriers.',
      controls:
          'Approved construction safety arrangements • Site inspections • Safe access • Traffic control • Barricading • Competent supervision • Housekeeping.',
      planning:
          'Identify the applicable Dubai Municipality requirements and current safety guide before construction work. Ensure the site safety arrangements reflect the approved project requirements.',
      safePractices:
          'Follow the approved Dubai construction safety arrangements. Maintain safe access, barriers, signage and site housekeeping.',
      ppe:
          'PPE shall be selected according to the task risk assessment and applicable Dubai requirements.',
      checklist:
          'Applicable Dubai requirements • Safety arrangements • Site access • Barriers • Signage • Traffic controls • PPE • Inspection.',
      inspection:
          'Check construction site controls, barriers, access, signage, lighting, housekeeping and traffic arrangements.',
      dos:
          'Use current Dubai Municipality guidance. Maintain site safety controls and required inspections.',
      donts:
          'Do not assume UAE-wide guidance automatically covers Dubai-specific construction requirements.',
      stopWork:
          'Stop affected work when critical site safety controls are missing or unsafe conditions create immediate risk.',
      emergency:
          'Follow the approved project emergency procedure and relevant Dubai requirements.',
      reference:
          'Dubai Municipality — Safety Guide for Construction Works in the Emirate of Dubai / Construction Works Safety Practice.',
    ),

    _ReferenceTopic(
      category: _GuidelineCategory.dubai,
      title: 'Dubai Site Barricading',
      shortDescription:
          'Dubai construction-site barriers, warning signs, access control and hazard segregation.',
      overview:
          'Construction sites in Dubai require effective control of hazards and unauthorized access. Barricading, fencing, warning signs and controlled access should be maintained according to applicable Dubai Municipality requirements.',
      hazards:
          'Unauthorized entry • Falls • Vehicle interaction • Falling objects • Public access to construction hazards.',
      controls:
          'Stable barriers • Site fencing • Warning signs • Controlled gates • Lighting • Regular inspection • Safe pedestrian routes.',
      planning:
          'Identify site hazards and public interfaces. Select barriers and signs appropriate to the hazard and maintain controlled access to the construction area.',
      safePractices:
          'Keep barriers stable and visible. Maintain controlled entry and exit points. Repair damaged fencing and barriers promptly.',
      ppe:
          'PPE depends on the hazard and task within the controlled area.',
      checklist:
          'Barrier • Fence • Warning signs • Gates • Lighting • Pedestrian control • Inspection • Damage control.',
      inspection:
          'Check barrier stability, visibility, access points, lighting and damaged sections.',
      dos:
          'Maintain barriers until the hazard is removed or controlled.',
      donts:
          'Do not remove construction barriers without authorization.',
      stopWork:
          'Stop affected work where the public or workers can enter an uncontrolled dangerous area.',
      emergency:
          'Secure the affected area and activate the applicable emergency procedure.',
      reference:
          'Dubai Municipality construction safety guidance and applicable circulars.',
    ),

    _ReferenceTopic(
      category: _GuidelineCategory.dubai,
      title: 'Dubai Traffic & Construction Interface',
      shortDescription:
          'Control interaction between construction activities, vehicles, pedestrians and public roads in Dubai.',
      overview:
          'Construction work near public roads requires careful coordination of traffic, pedestrians, site access and construction activities. Dubai-specific requirements should be verified before implementing traffic arrangements.',
      hazards:
          'Vehicle strike • Reversing • Poor visibility • Public access • Congestion • Night-work hazards.',
      controls:
          'Traffic management • Barriers • Signs • Lighting • Safe pedestrian routes • Trained traffic controllers • Controlled site entrances.',
      planning:
          'Review the approved traffic and construction arrangements. Coordinate site entrances, pedestrian movement, vehicle movement and public-road interfaces.',
      safePractices:
          'Maintain clear traffic controls. Keep pedestrian routes separated where possible. Ensure signs and barriers remain visible and correctly positioned.',
      ppe:
          'High-visibility clothing • Safety footwear • Safety helmet • Task-specific PPE.',
      checklist:
          'Traffic plan • Signs • Barriers • Lighting • Pedestrian route • Vehicle route • Site entrance • Inspection.',
      inspection:
          'Check signs, barriers, lighting, pedestrian routes, vehicle routes and work-zone visibility.',
      dos:
          'Follow the approved traffic arrangement and Dubai requirements.',
      donts:
          'Do not remove traffic controls without authorization.',
      stopWork:
          'Stop affected work if traffic controls are displaced or safe separation cannot be maintained.',
      emergency:
          'Protect the scene, control traffic and activate the applicable emergency response.',
      reference:
          'Dubai Municipality construction safety requirements and applicable traffic/site-control requirements.',
    ),

    // ==========================================================
    // 🟢 GENERAL HSE — PRACTICAL
    // ==========================================================

    _ReferenceTopic(
      category: _GuidelineCategory.general,
      title: 'Risk Assessment',
      shortDescription:
          'Identify hazards, evaluate risks and establish effective controls before work.',
      overview:
          'Risk assessment is a fundamental HSE process used to identify hazards, evaluate risk and determine suitable controls before and during work.',
      hazards:
          'Unidentified hazards • Inadequate controls • Changing site conditions • Poor communication.',
      controls:
          'Hazard identification • Risk evaluation • Hierarchy of controls • Worker consultation • Review.',
      planning:
          'Break the task into steps, identify hazards, determine risk and establish controls before work starts.',
      safePractices:
          'Review the assessment when conditions, equipment, people or methods change.',
      ppe:
          'PPE is the final layer of control and should be selected according to the risk assessment.',
      checklist:
          'Task identified • Hazards identified • Risk assessed • Controls defined • Workers briefed • Review completed.',
      inspection:
          'Verify that controls identified in the risk assessment are actually implemented.',
      dos:
          'Keep risk assessments current and practical.',
      donts:
          'Do not treat risk assessment as paperwork only.',
      stopWork:
          'Stop work if the actual conditions are significantly different from the assessed conditions.',
      emergency:
          'Follow the applicable emergency plan and report incidents and near misses.',
      reference:
          'General HSE good practice; always verify applicable UAE/emirate/project requirements.',
    ),

    _ReferenceTopic(
      category: _GuidelineCategory.general,
      title: 'Working at Height',
      shortDescription:
          'Prevent falls through safe access, platforms, edge protection and suitable fall protection.',
      overview:
          'Working at height requires careful planning and effective controls to prevent falls and falling objects.',
      hazards:
          'Falls • Falling objects • Open edges • Unsafe ladders • Poor platforms.',
      controls:
          'Avoid work at height where possible • Safe platforms • Guardrails • Edge protection • Fall protection • Rescue planning.',
      planning:
          'Select the safest access system and assess edges, openings, weather and rescue requirements.',
      safePractices:
          'Use suitable working platforms. Protect edges and openings. Inspect fall-protection equipment.',
      ppe:
          'Safety helmet • Safety footwear • Full-body harness where required • Eye protection.',
      checklist:
          'Risk assessment • Safe access • Platform • Edge protection • Harness • Anchorage • Rescue plan.',
      inspection:
          'Check platforms, guardrails, openings, ladders, harnesses and anchorages.',
      dos:
          'Plan before starting. Use approved access systems.',
      donts:
          'Do not work from unstable surfaces or unsuitable anchor points.',
      stopWork:
          'Stop work when fall protection or safe access is unavailable.',
      emergency:
          'Activate the rescue plan and emergency response.',
      reference:
          'General HSE guidance; verify applicable emirate-specific requirements.',
    ),

    _ReferenceTopic(
      category: _GuidelineCategory.general,
      title: 'Lifting Operations',
      shortDescription:
          'General principles for safe lifting, load control and exclusion zones.',
      overview:
          'Safe lifting requires proper planning, suitable equipment, competent personnel and control of the lifting area.',
      hazards:
          'Dropped loads • Overloading • Crushing • Struck-by incidents • Equipment failure.',
      controls:
          'Lift planning • Equipment inspection • Load verification • Exclusion zone • Communication.',
      planning:
          'Confirm load weight, lifting points, equipment capacity, ground conditions and lifting route.',
      safePractices:
          'Use inspected equipment and accessories. Keep people away from suspended loads.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Gloves • Eye protection.',
      checklist:
          'Lift plan • Competent team • Equipment • Accessories • SWL • Ground • Exclusion zone • Communication.',
      inspection:
          'Inspect equipment, accessories, ground and exclusion zones.',
      dos:
          'Follow the approved lifting plan.',
      donts:
          'Never stand under suspended loads.',
      stopWork:
          'Stop for equipment defects, uncertain loads or unsafe conditions.',
      emergency:
          'Stop the operation and activate emergency response.',
      reference:
          'General HSE guidance; verify applicable UAE/emirate-specific lifting requirements.',
    ),

    _ReferenceTopic(
      category: _GuidelineCategory.general,
      title: 'Confined Space',
      shortDescription:
          'Control atmospheric, access, isolation and rescue hazards in confined spaces.',
      overview:
          'Confined-space work can involve hazardous atmospheres, restricted access and difficult rescue conditions.',
      hazards:
          'Oxygen deficiency • Toxic gases • Flammable atmosphere • Engulfment • Heat • Difficult rescue.',
      controls:
          'Permit • Isolation • Atmospheric testing • Ventilation • Communication • Attendant • Rescue plan.',
      planning:
          'Determine whether entry can be avoided. Establish testing, isolation, ventilation, communication and rescue controls.',
      safePractices:
          'Test the atmosphere as required. Maintain communication and rescue readiness.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Eye protection • Respiratory protection where required • Harness where required.',
      checklist:
          'Permit • Isolation • Gas test • Ventilation • Attendant • Communication • Rescue equipment.',
      inspection:
          'Check permit, isolation, atmosphere, ventilation, access and rescue arrangements.',
      dos:
          'Follow the approved entry procedure.',
      donts:
          'Never perform an unprotected rescue entry.',
      stopWork:
          'Stop entry if atmospheric conditions become unsafe or rescue arrangements fail.',
      emergency:
          'Raise the alarm and activate the approved rescue plan.',
      reference:
          'General HSE guidance; verify applicable UAE/emirate-specific requirements.',
    ),

    _ReferenceTopic(
      category: _GuidelineCategory.general,
      title: 'Permit to Work',
      shortDescription:
          'Control high-risk work through authorization, isolation and verification.',
      overview:
          'A Permit to Work system provides a controlled process for authorizing specified high-risk activities.',
      hazards:
          'Uncontrolled energy • Fire • Toxic atmosphere • Simultaneous activities • Incorrect isolation.',
      controls:
          'Task identification • Risk assessment • Isolation • Authorization • Toolbox talk • Site verification • Close-out.',
      planning:
          'Identify the task, location, hazards, isolations and precautions before issuing the permit.',
      safePractices:
          'Verify that the permit matches the actual task and location. Stop when conditions change.',
      ppe:
          'PPE shall be selected according to the activity risk assessment.',
      checklist:
          'Permit • Risk assessment • Method statement • Isolation • Gas test where required • Authorization • Toolbox talk • Close-out.',
      inspection:
          'Check permit validity, location, task, isolation and precautions.',
      dos:
          'Follow permit conditions.',
      donts:
          'Do not work outside permit boundaries or bypass isolation.',
      stopWork:
          'Stop work if the permit is expired, incorrect, suspended or conditions have changed.',
      emergency:
          'Stop work, raise the alarm and follow the emergency procedure.',
      reference:
          'General HSE guidance; verify applicable project and emirate requirements.',
    ),

    _ReferenceTopic(
      category: _GuidelineCategory.general,
      title: 'Electrical Safety',
      shortDescription:
          'Prevent electric shock, burns and electrical fires through inspection and isolation.',
      overview:
          'Electrical hazards can cause shock, burns, fire and serious injury. Electrical work must be controlled by competent persons.',
      hazards:
          'Electric shock • Burns • Arc flash • Fire • Damaged cables • Wet conditions.',
      controls:
          'Competent persons • Isolation • Inspection • Protective devices • Earthing • Cable protection.',
      planning:
          'Identify electrical sources and equipment. Plan isolation and protection before work.',
      safePractices:
          'Inspect cables, plugs and tools. Keep equipment protected from water and damage.',
      ppe:
          'Safety footwear • Eye/face protection • Electrical-rated PPE where required.',
      checklist:
          'Competent person • Distribution board • Protection devices • Earthing • Cables • Tools • Isolation.',
      inspection:
          'Check cables, plugs, sockets, boards and protective devices.',
      dos:
          'Remove damaged electrical equipment from service.',
      donts:
          'Do not bypass protective devices or perform unauthorized electrical work.',
      stopWork:
          'Stop when isolation is uncertain or electrical equipment is damaged.',
      emergency:
          'Isolate the energy source safely and activate emergency response. Do not touch an energized casualty.',
      reference:
          'General HSE guidance; verify applicable UAE/emirate/project electrical requirements.',
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
      final searchable = [
        topic.title,
        topic.shortDescription,
        topic.overview,
        topic.hazards,
        topic.controls,
        topic.planning,
        topic.safePractices,
        topic.ppe,
        topic.checklist,
        topic.inspection,
        topic.dos,
        topic.donts,
        topic.stopWork,
        topic.emergency,
        topic.reference,
      ].join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();
  }

  String _categoryTitle(_GuidelineCategory category) {
    switch (category) {
      case _GuidelineCategory.uae:
        return '🇦🇪 UAE SAFETY';
      case _GuidelineCategory.abuDhabi:
        return '🟣 ABU DHABI SAFETY';
      case _GuidelineCategory.dubai:
        return '🟠 DUBAI SAFETY';
      case _GuidelineCategory.general:
        return '🟢 GENERAL HSE';
    }
  }

  String _categoryDescription(_GuidelineCategory category) {
    switch (category) {
      case _GuidelineCategory.uae:
        return 'Federal / UAE-wide HSE requirements';
      case _GuidelineCategory.abuDhabi:
        return 'ADOSH-SF and Abu Dhabi-specific requirements';
      case _GuidelineCategory.dubai:
        return 'Dubai Municipality and Dubai-specific requirements';
      case _GuidelineCategory.general:
        return 'Practical HSE learning and general safety guidance';
    }
  }

  Color _categoryColor(_GuidelineCategory category) {
    switch (category) {
      case _GuidelineCategory.uae:
        return const Color(0xFF087A38);
      case _GuidelineCategory.abuDhabi:
        return const Color(0xFF5E35B1);
      case _GuidelineCategory.dubai:
        return const Color(0xFFE65100);
      case _GuidelineCategory.general:
        return const Color(0xFF087A38);
    }
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
          _buildSectionHeader(
            searching ? 'SEARCH RESULTS' : 'HSE REFERENCE LIBRARY',
            searching
                ? '${topics.length} topics found'
                : '${topics.length} verified-structure topics',
          ),
          const SizedBox(height: 14),
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
                  'UAE HSE Safety Centre',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'UAE-wide, Abu Dhabi and Dubai HSE guidance in separate reference sections.',
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
        const Text(
          'UAE HSE',
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
    final categoryColor = _categoryColor(topic.category);

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
                  color: categoryColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text(
                  '$number',
                  style: TextStyle(
                    color: categoryColor,
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
                      _categoryTitle(topic.category),
                      style: TextStyle(
                        color: categoryColor,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
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
                      topic.shortDescription,
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
            'No HSE topic found',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Try another keyword.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF777777),
            ),
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
    final categoryColor = _categoryColor(topic.category);

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
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroCard(categoryColor),
            const SizedBox(height: 16),

            _infoCard(
              icon: Icons.menu_book_rounded,
              title: 'What is it?',
              content: topic.overview,
            ),

            _infoCard(
              icon: Icons.warning_amber_rounded,
              title: 'Main Hazards',
              content: topic.hazards,
              bulletStyle: true,
            ),

            _infoCard(
              icon: Icons.shield_rounded,
              title: 'Risk Controls',
              content: topic.controls,
              bulletStyle: true,
            ),

            _infoCard(
              icon: Icons.assignment_rounded,
              title: 'Planning & Preparation',
              content: topic.planning,
            ),

            _infoCard(
              icon: Icons.engineering_rounded,
              title: 'Safe Work Practices',
              content: topic.safePractices,
            ),

            _infoCard(
              icon: Icons.health_and_safety_rounded,
              title: 'PPE',
              content: topic.ppe,
              bulletStyle: true,
            ),

            _checklistCard(),

            _infoCard(
              icon: Icons.search_rounded,
              title: 'Inspection Points',
              content: topic.inspection,
              bulletStyle: true,
            ),

            _doDontCard(
              title: 'Do',
              icon: Icons.check_circle_outline_rounded,
              content: topic.dos,
              isPositive: true,
            ),

            _doDontCard(
              title: 'Do Not',
              icon: Icons.cancel_outlined,
              content: topic.donts,
              isPositive: false,
            ),

            _stopWorkCard(),

            _infoCard(
              icon: Icons.emergency_rounded,
              title: 'Emergency Response',
              content: topic.emergency,
            ),

            _referenceCard(categoryColor),

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
              'UAE HSE Safety Learning & Reference',
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

  Color _categoryColor(_GuidelineCategory category) {
    switch (category) {
      case _GuidelineCategory.uae:
        return const Color(0xFF087A38);
      case _GuidelineCategory.abuDhabi:
        return const Color(0xFF5E35B1);
      case _GuidelineCategory.dubai:
        return const Color(0xFFE65100);
      case _GuidelineCategory.general:
        return const Color(0xFF087A38);
    }
  }

  Widget _buildHeroCard(Color categoryColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: Color(0x22FFFFFF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shield_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _categoryTitle(topic.category),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  topic.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'HSE Learning & Reference',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  topic.shortDescription,
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

  String _categoryTitle(_GuidelineCategory category) {
    switch (category) {
      case _GuidelineCategory.uae:
        return '🇦🇪 UAE SAFETY';
      case _GuidelineCategory.abuDhabi:
        return '🟣 ABU DHABI SAFETY';
      case _GuidelineCategory.dubai:
        return '🟠 DUBAI SAFETY';
      case _GuidelineCategory.general:
        return '🟢 GENERAL HSE';
    }
  }

  Widget _referenceCard(Color categoryColor) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: categoryColor.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.library_books_outlined,
            color: categoryColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reference',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  topic.reference,
                  style: const TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Important: This app is a learning and practical reference tool. Always verify the latest official requirement before making a compliance decision.',
                  style: TextStyle(
                    color: Color(0xFF777777),
                    fontSize: 11,
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

  Widget _checklistCard() {
    final items = _splitBullets(topic.checklist);

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.checklist_rounded,
                color: Color(0xFF159447),
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'HSE Checklist',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_box_outlined,
                    size: 19,
                    color: Color(0xFF159447),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Color(0xFF555555),
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stopWorkCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F8),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFF0CACA),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.pan_tool_alt_rounded,
            color: Color(0xFFD32F2F),
            size: 25,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'When to Stop Work',
                  style: TextStyle(
                    color: Color(0xFFD32F2F),
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  topic.stopWork,
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

  Widget _doDontCard({
    required String title,
    required IconData icon,
    required String content,
    required bool isPositive,
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
            color: isPositive
                ? const Color(0xFF159447)
                : const Color(0xFFD32F2F),
            size: 25,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: isPositive
                        ? const Color(0xFF159447)
                        : const Color(0xFFD32F2F),
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

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String content,
    bool bulletStyle = false,
  }) {
    final items = bulletStyle ? _splitBullets(content) : <String>[];

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
                const SizedBox(height: 8),
                if (bulletStyle)
                  ...items.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Icon(
                              Icons.circle,
                              size: 5,
                              color: Color(0xFF159447),
                            ),
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(
                                color: Color(0xFF666666),
                                fontSize: 12,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
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

  List<String> _splitBullets(String value) {
    return value
        .split('•')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();
  }
}

// ============================================================
// DATA MODEL
// ============================================================

class _ReferenceTopic {
  final _GuidelineCategory category;
  final String title;
  final String shortDescription;
  final String overview;
  final String hazards;
  final String controls;
  final String planning;
  final String safePractices;
  final String ppe;
  final String checklist;
  final String inspection;
  final String dos;
  final String donts;
  final String stopWork;
  final String emergency;
  final String reference;

  const _ReferenceTopic({
    required this.category,
    required this.title,
    required this.shortDescription,
    required this.overview,
    required this.hazards,
    required this.controls,
    required this.planning,
    required this.safePractices,
    required this.ppe,
    required this.checklist,
    required this.inspection,
    required this.dos,
    required this.donts,
    required this.stopWork,
    required this.emergency,
    required this.reference,
  });
}
