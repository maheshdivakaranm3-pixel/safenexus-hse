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
      title: 'Risk Assessment',
      description:
          'Identify hazards, assess risks and implement suitable controls before and during work.',
      ppe:
          'PPE must be selected according to the task-specific risk assessment.',
    ),
    _ReferenceTopic(
      title: 'Personal Protective Equipment',
      description:
          'Select, provide, use and maintain PPE appropriate to the hazards identified.',
      ppe:
          'Safety helmet • Safety footwear • Eye protection • Gloves • Task-specific PPE.',
    ),
    _ReferenceTopic(
      title: 'Heat Stress Management',
      description:
          'Reduce heat-related illness through hydration, rest, shade, work planning and worker awareness.',
      ppe:
          'Suitable work clothing • Safety footwear • Head protection • Task-specific PPE.',
    ),
    _ReferenceTopic(
      title: 'Fire Safety',
      description:
          'Prevent fire incidents and maintain suitable fire prevention, protection and emergency arrangements.',
      ppe:
          'Safety helmet • Safety footwear • Fire-resistant PPE where required.',
    ),
    _ReferenceTopic(
      title: 'Emergency Preparedness',
      description:
          'Prepare workers and workplaces to respond effectively to emergencies.',
      ppe:
          'Task-specific PPE according to the emergency and workplace risk.',
    ),
    _ReferenceTopic(
      title: 'First Aid',
      description:
          'Ensure suitable first-aid arrangements, trained personnel and timely medical response.',
      ppe:
          'PPE appropriate to first-aid activity and the identified hazard.',
    ),
    _ReferenceTopic(
      title: 'Occupational Health',
      description:
          'Identify occupational health risks and implement suitable health protection and monitoring.',
      ppe:
          'Task-specific PPE based on occupational exposure.',
    ),
    _ReferenceTopic(
      title: 'Working at Height',
      description:
          'Prevent falls through safe access, edge protection, fall protection and rescue planning.',
      ppe:
          'Safety helmet with chin strap • Safety footwear • Full body harness where required.',
    ),
    _ReferenceTopic(
      title: 'Confined Space Safety',
      description:
          'Control atmospheric, physical and emergency risks associated with confined-space work.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Eye protection • Respiratory protection where required • Harness where required.',
    ),
    _ReferenceTopic(
      title: 'Electrical Safety',
      description:
          'Prevent electric shock, burns, fire and equipment damage through competent electrical work and isolation.',
      ppe:
          'Electrical-rated PPE where required • Safety footwear • Eye protection • Arc-flash PPE where applicable.',
    ),
    _ReferenceTopic(
      title: 'Lifting & Rigging',
      description:
          'Plan lifting operations and control loads, equipment, people and exclusion zones.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Gloves • Task-specific PPE.',
    ),
    _ReferenceTopic(
      title: 'Chemical Safety',
      description:
          'Identify chemical hazards and control storage, handling, exposure and emergency response.',
      ppe:
          'Chemical-resistant gloves • Eye/face protection • Protective clothing • Respiratory protection where required.',
    ),
    _ReferenceTopic(
      title: 'Incident Investigation',
      description:
          'Ensure incidents are reported, investigated and followed by corrective and preventive actions.',
      ppe:
          'PPE appropriate to the incident location and investigation activity.',
    ),
    _ReferenceTopic(
      title: 'Environmental Safety',
      description:
          'Control environmental aspects of work to protect workers, the public and the surrounding environment.',
      ppe:
          'Task-specific PPE based on environmental hazards.',
    ),
    _ReferenceTopic(
      title: 'Manual Handling',
      description:
          'Reduce musculoskeletal injuries through task assessment, mechanical aids and safe handling techniques.',
      ppe:
          'Safety footwear • Suitable gloves • Other task-specific PPE.',
    ),
    _ReferenceTopic(
      title: 'Traffic & Vehicle Safety',
      description:
          'Control vehicle movement, reversing, speed, access and interaction between pedestrians and vehicles.',
      ppe:
          'High-visibility clothing • Safety footwear • Safety helmet • Task-specific PPE.',
    ),
    _ReferenceTopic(
      title: 'Worker Welfare',
      description:
          'Provide suitable welfare arrangements including drinking water, sanitation, rest facilities and hygiene.',
      ppe:
          'Task-specific PPE where work activities are involved.',
    ),
    _ReferenceTopic(
      title: 'Scaffolding Safety',
      description:
          'Provide safe temporary access and working platforms through competent erection, inspection and safe use.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Full body harness where required.',
    ),
    _ReferenceTopic(
      title: 'Power Tools Safety',
      description:
          'Prevent cuts, electric shock, flying particles, burns and other injuries through correct tool selection and use.',
      ppe:
          'Safety glasses • Hearing protection • Gloves where suitable • Safety footwear.',
    ),
    _ReferenceTopic(
      title: 'Formwork Safety',
      description:
          'Control formwork stability, erection, loading, concrete placement and stripping hazards.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Eye protection.',
    ),
    _ReferenceTopic(
      title: 'Permit to Work (PTW)',
      description:
          'Control high-risk activities through formal authorization, isolation, precautions and close-out.',
      ppe:
          'PPE determined by the permitted task and risk assessment.',
    ),
    _ReferenceTopic(
      title: 'Working Near Live Roads',
      description:
          'Protect workers and road users through traffic management, segregation, signs and controlled work zones.',
      ppe:
          'High-visibility clothing • Safety footwear • Safety helmet • Task-specific PPE.',
    ),
    _ReferenceTopic(
      title: 'Concreting Safety',
      description:
          'Control hazards from concrete delivery, pumping, placing, vibration and finishing activities.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Eye protection • Suitable protective clothing.',
    ),
    _ReferenceTopic(
      title: 'Barricading of Hazards',
      description:
          'Prevent unauthorized access to hazardous areas using suitable barricades and warning systems.',
      ppe:
          'PPE based on the hazard within the barricaded area.',
    ),
    _ReferenceTopic(
      title: 'Temporary Works',
      description:
          'Plan, design, inspect and control temporary structures and supporting systems.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Fall protection where required.',
    ),
    _ReferenceTopic(
      title: 'Hot Work Safety',
      description:
          'Control welding, cutting, grinding and other activities that generate heat, sparks or flames.',
      ppe:
          'Welding helmet/goggles • Welding gloves • Flame-resistant clothing • Safety footwear • Face shield where required.',
    ),
    _ReferenceTopic(
      title: 'Safe Forklift Operations',
      description:
          'Control operator competence, load handling, pedestrian interaction and equipment condition.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Seat belt.',
    ),
    _ReferenceTopic(
      title: 'Safe Storage',
      description:
          'Maintain stable and suitable storage arrangements to prevent falling objects, fire and access hazards.',
      ppe:
          'Safety footwear • Safety helmet • Gloves • Task-specific PPE.',
    ),
    _ReferenceTopic(
      title: 'Ladders & Safe Access',
      description:
          'Use suitable access equipment and maintain safe positioning, inspection and working practices.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Fall protection where required.',
    ),
    _ReferenceTopic(
      title: 'Machinery Safety',
      description:
          'Control moving machinery hazards through guarding, isolation, maintenance and competent operation.',
      ppe:
          'Safety helmet • Safety footwear • Eye protection • Hearing protection • Task-specific PPE.',
    ),
    _ReferenceTopic(
      title: 'Safety Signs',
      description:
          'Use clear and appropriate safety signs to warn, inform and direct workers and visitors.',
      ppe:
          'PPE based on the work area and associated hazards.',
    ),
    _ReferenceTopic(
      title: 'Indoor Air Quality',
      description:
          'Maintain suitable indoor air quality through ventilation, source control, cleaning and monitoring.',
      ppe:
          'Respiratory protection where required • Eye protection • Task-specific PPE.',
    ),
    _ReferenceTopic(
      title: 'Waste Management',
      description:
          'Segregate, store, handle and dispose of workplace waste safely.',
      ppe:
          'Safety gloves • Safety footwear • Eye protection • Task-specific PPE.',
    ),
    _ReferenceTopic(
      title: 'Occupational Noise',
      description:
          'Assess noise exposure and apply engineering, administrative and personal protective controls.',
      ppe:
          'Suitable hearing protection • Safety helmet • Safety footwear.',
    ),
    _ReferenceTopic(
      title: 'Vibration',
      description:
          'Assess vibration exposure and implement controls to reduce worker exposure and associated health risks.',
      ppe:
          'Task-specific PPE • Suitable gloves where appropriate • Safety footwear.',
    ),
    _ReferenceTopic(
      title: 'Asbestos Management',
      description:
          'Prevent exposure to asbestos fibres through identification, assessment and controlled work.',
      ppe:
          'Specialist respiratory protection • Disposable protective clothing • Gloves • Eye protection as required.',
    ),
    _ReferenceTopic(
      title: 'Lead Exposure',
      description:
          'Identify lead exposure risks and implement appropriate controls, monitoring and worker protection.',
      ppe:
          'Respiratory protection where required • Gloves • Protective clothing • Eye protection.',
    ),
    _ReferenceTopic(
      title: 'Underground Construction',
      description:
          'Assess underground construction hazards and implement suitable ground, access and emergency controls.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Eye protection • Task-specific PPE.',
    ),
    _ReferenceTopic(
      title: 'Audit & Inspection',
      description:
          'Use systematic inspections and audits to identify gaps, verify controls and improve HSE performance.',
      ppe:
          'PPE appropriate to the inspection area and identified hazards.',
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
          topic.ppe.toLowerCase().contains(query);
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

  String _purpose() {
    switch (topic.title) {
      case 'Risk Assessment':
        return 'Identify hazards, evaluate risks and implement effective controls before and during work.';

      case 'Personal Protective Equipment':
        return 'Select and use PPE based on the hazards identified through the task risk assessment.';

      case 'Heat Stress Management':
        return 'Reduce heat-related illness through hydration, rest, shade, work planning, acclimatization and worker awareness.';

      case 'Fire Safety':
        return 'Prevent fires and ensure suitable fire prevention, protection, evacuation and emergency response arrangements.';

      case 'Emergency Preparedness':
        return 'Prepare workers and workplaces to respond quickly and effectively during emergencies.';

      case 'First Aid':
        return 'Provide suitable first-aid arrangements, trained personnel and timely medical response.';

      case 'Occupational Health':
        return 'Identify occupational health hazards and implement suitable preventive and monitoring measures.';

      case 'Working at Height':
        return 'Prevent falls through planning, safe access, edge protection, fall protection and rescue arrangements.';

      case 'Confined Space Safety':
        return 'Control atmospheric, physical, engulfment and emergency risks associated with confined-space work.';

      case 'Electrical Safety':
        return 'Prevent electric shock, burns, fire and equipment damage through competent electrical work, inspection and isolation.';

      case 'Lifting & Rigging':
        return 'Plan lifting operations and control equipment, loads, personnel, exclusion zones and communication.';

      case 'Chemical Safety':
        return 'Control chemical exposure through identification, storage, handling, PPE, emergency response and disposal.';

      case 'Incident Investigation':
        return 'Understand what happened, identify root causes and implement corrective and preventive actions.';

      case 'Environmental Safety':
        return 'Control environmental impacts of workplace and construction activities.';

      case 'Manual Handling':
        return 'Reduce manual-handling injuries through assessment, mechanical aids, safe techniques and suitable work design.';

      case 'Traffic & Vehicle Safety':
        return 'Control vehicle movement and interaction between pedestrians, vehicles and mobile equipment.';

      case 'Worker Welfare':
        return 'Provide suitable drinking water, sanitation, rest areas, hygiene and welfare facilities.';

      case 'Scaffolding Safety':
        return 'Provide safe temporary working platforms through competent erection, inspection, access and controlled loading.';

      case 'Power Tools Safety':
        return 'Prevent tool-related injuries through correct selection, inspection, guards, maintenance and safe operation.';

      case 'Formwork Safety':
        return 'Control formwork stability during erection, concrete placement and stripping.';

      case 'Permit to Work (PTW)':
        return 'Control high-risk activities through authorization, hazard identification, isolation, precautions and close-out.';

      case 'Working Near Live Roads':
        return 'Protect workers and road users through traffic management, segregation, warning systems and controlled work zones.';

      case 'Concreting Safety':
        return 'Control hazards associated with concrete delivery, pumping, placing, vibration and finishing.';

      case 'Barricading of Hazards':
        return 'Prevent unauthorized access to hazardous areas using effective barricades, signs and access controls.';

      case 'Temporary Works':
        return 'Ensure temporary structures and support systems are properly planned, designed, installed, inspected and removed.';

      case 'Hot Work Safety':
        return 'Prevent fire, explosion, burns and other hazards from welding, cutting, grinding and spark-producing activities.';

      default:
        return 'Use this topic as a practical HSE reference and verify the latest applicable requirements before making compliance decisions.';
    }
  }

  String _controls() {
    switch (topic.title) {
      case 'Risk Assessment':
        return 'Hazard identification • Risk evaluation • Hierarchy of controls • Worker involvement • Control implementation • Review.';

      case 'Personal Protective Equipment':
        return 'Hazard-based selection • Correct fit • Inspection • Maintenance • Replacement • Worker training • Proper use.';

      case 'Heat Stress Management':
        return 'Water • Rest • Shade • Work/rest planning • Acclimatization • Heat awareness • Supervision • Early symptom reporting.';

      case 'Fire Safety':
        return 'Fire prevention • Suitable extinguishers • Emergency routes • Alarm systems • Fire risk assessment • Inspection • Training.';

      case 'Emergency Preparedness':
        return 'Emergency plan • Alarm • Evacuation routes • Assembly point • Emergency contacts • Training • Drills.';

      case 'First Aid':
        return 'First-aid equipment • Trained first aider • Emergency communication • Medical response • Incident recording.';

      case 'Occupational Health':
        return 'Health risk assessment • Exposure control • Occupational health monitoring • Worker awareness • Suitable welfare.';

      case 'Working at Height':
        return 'Avoid where possible • Safe access • Edge protection • Fall protection • Equipment inspection • Rescue planning.';

      case 'Confined Space Safety':
        return 'Risk assessment • Isolation • Atmospheric testing • Ventilation • Communication • Attendant • Rescue arrangements.';

      case 'Electrical Safety':
        return 'Isolation • Competent persons • Inspection • Suitable equipment • Protection from live parts • RCD/GFCI where applicable.';

      case 'Lifting & Rigging':
        return 'Lift plan • Competent personnel • Certified equipment • Load control • Exclusion zone • Communication • Weather consideration.';

      case 'Chemical Safety':
        return 'SDS • Labelling • Compatible storage • PPE • Exposure controls • Spill response • Emergency arrangements • Safe disposal.';

      case 'Incident Investigation':
        return 'Immediate response • Notification • Evidence preservation • Root-cause analysis • Corrective action • Preventive action • Follow-up.';

      case 'Environmental Safety':
        return 'Environmental risk assessment • Pollution prevention • Waste control • Spill prevention • Monitoring • Corrective action.';

      case 'Manual Handling':
        return 'Avoid unnecessary lifting • Mechanical aids • Reduce load • Good technique • Team lifting • Suitable work height.';

      case 'Traffic & Vehicle Safety':
        return 'Traffic management plan • Segregation • Speed control • Reversing controls • Warning signs • Trained drivers • Pedestrian routes.';

      case 'Worker Welfare':
        return 'Drinking water • Toilets • Washing facilities • Rest areas • Hygiene • Heat protection • Clean facilities.';

      case 'Scaffolding Safety':
        return 'Competent erection • Stable foundation • Guardrails • Toe boards • Safe access • Inspection • Safe loading.';

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

  String _practice() {
    return 'Use competent personnel, suitable procedures, appropriate PPE and effective supervision. Review the controls whenever the task, equipment, environment or risk changes.';
  }

  String _checklist() {
    switch (topic.title) {
      case 'Working at Height':
        return 'Plan work • Avoid height where possible • Safe access • Edge protection • Fall protection • Equipment inspection • Rescue plan • Worker briefing.';

      case 'Confined Space Safety':
        return 'Permit • Isolation • Gas testing • Ventilation • Attendant • Communication • Rescue equipment • Competent workers.';

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
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
                          'UAE HSE Safety Reference',
                          style: TextStyle(
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
              content: topic.ppe,
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
                  'This page provides general HSE awareness guidance. It is not a substitute for the latest applicable UAE legislation, regulator requirements, Codes of Practice or approved project procedures.',
            ),
            const SizedBox(height: 8),
            const Text(
              'Reference Area',
              style: TextStyle(
                color: Color(0xFF159447),
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'UAE HSE Safety Reference',
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
          const SizedBox(width: 1),
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
  final String ppe;

  const _ReferenceTopic({
    required this.title,
    required this.description,
    required this.ppe,
  });
}
