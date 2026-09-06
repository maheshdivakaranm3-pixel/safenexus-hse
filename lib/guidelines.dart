import 'package:flutter/material.dart';
import 'guideline_detail_page.dart';

class GuidelinesPage extends StatefulWidget {
  const GuidelinesPage({super.key});

  @override
  State<GuidelinesPage> createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  final TextEditingController _searchController = TextEditingController();

  String _query = '';
  GuidelineCategory _selectedCategory = GuidelineCategory.all;

  final List<ReferenceTopic> _topics = const [
    ReferenceTopic(
      title: 'Scaffolding Safety',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE Reference',
      copNumber: 'General HSE Practice',
      version: 'Current Reference',
      effectiveDate: 'Verify latest requirement',
      shortDescription:
          'Safe erection, inspection, use and dismantling of scaffolding systems.',
      overview:
          'Scaffolding is a temporary access and working platform used for construction, maintenance and other work at height. It must be properly designed, erected, inspected and used by competent persons.',
      hazards:
          'Falls from height\n'
          'Falling materials\n'
          'Scaffold collapse\n'
          'Unstable or incomplete platforms\n'
          'Unsafe access',
      controls:
          'Use competent scaffolders.\n'
          'Provide guardrails, midrails and toe boards.\n'
          'Provide safe access and egress.\n'
          'Inspect before first use and after alteration or adverse conditions.\n'
          'Prevent unauthorised modification.',
      planning:
          'Review the work-at-height risk assessment, scaffold design requirements, ground conditions, access arrangements and loading requirements before erection.',
      safePractices:
          'Keep platforms clean and free from unnecessary materials. Never remove scaffold components without authorisation. Maintain required clearances from electrical hazards.',
      ppe:
          'Safety helmet, safety footwear, gloves and suitable fall-protection equipment where required by the risk assessment and scaffold system.',
      checklist:
          'Foundation and base are stable\n'
          'Standards and braces are correctly installed\n'
          'Platforms are complete and secure\n'
          'Guardrails and toe boards are installed\n'
          'Safe access is provided\n'
          'Scaffold inspection status is visible',
      inspection:
          'Check foundations, standards, braces, platforms, guardrails, toe boards, access ladders/stairs, ties and signs of damage or unauthorised alteration.',
      dos:
          'Use only inspected and approved scaffolding. Follow the approved scaffold design and site procedure.',
      donts:
          'Do not use incomplete, damaged or untagged scaffolding. Do not climb outside designated access points.',
      stopWork:
          'Stop work if the scaffold is unstable, damaged, incomplete, overloaded or has been altered without approval.',
      emergency:
          'Prevent further access, isolate the affected area and report immediately. Arrange rescue and medical assistance according to the site emergency plan.',
      malayalam:
          'സ്കാഫോൾഡിംഗ് ഉപയോഗിക്കുന്നതിന് മുമ്പ് അത് ശരിയായി സ്ഥാപിച്ചിട്ടുണ്ടോ, ഗാർഡ്‌റെയിൽ, ടോ ബോർഡ്, സുരക്ഷിതമായ ആക്സസ് എന്നിവയുണ്ടോ എന്ന് പരിശോധിക്കുക. കേടായതോ incomplete ആയതോ ആയ scaffold ഉപയോഗിക്കരുത്.',
    ),

    ReferenceTopic(
      title: 'Work at Height',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE Reference',
      copNumber: 'Work at Height',
      version: 'Current Reference',
      effectiveDate: 'Verify latest requirement',
      shortDescription:
          'Controls for preventing falls while working at elevated locations.',
      overview:
          'Work at height includes work where a person could fall and suffer injury. The preferred approach is to eliminate work at height where reasonably practicable and use suitable collective protection where it cannot be eliminated.',
      hazards:
          'Falls from edges\n'
          'Falls through openings\n'
          'Falling objects\n'
          'Incorrect ladder use\n'
          'Failure of fall-protection systems',
      controls:
          'Plan the task before starting.\n'
          'Use suitable platforms and edge protection.\n'
          'Protect openings.\n'
          'Use fall-arrest or restraint systems where required.\n'
          'Control falling objects.',
      planning:
          'Complete risk assessment and method statement. Confirm access, rescue arrangements, weather conditions, equipment inspection and worker competency.',
      safePractices:
          'Maintain three points of contact on ladders where appropriate. Keep work areas clear. Use designated access systems and maintain edge protection.',
      ppe:
          'Safety helmet, safety footwear and appropriate fall-protection equipment where specified by the risk assessment.',
      checklist:
          'Risk assessment completed\n'
          'Safe access provided\n'
          'Edge protection installed\n'
          'Openings protected\n'
          'Fall-protection equipment inspected\n'
          'Rescue plan available',
      inspection:
          'Inspect platforms, ladders, guardrails, anchor points, harnesses, lanyards and access routes before use.',
      dos:
          'Use the safest practical access system and follow the approved work-at-height procedure.',
      donts:
          'Do not improvise platforms or remove edge protection without authorisation.',
      stopWork:
          'Stop work during unsafe weather, defective access equipment, missing edge protection or when rescue arrangements are not available.',
      emergency:
          'Raise the alarm, prevent secondary falls and activate the approved rescue plan. Do not create additional risk while attempting rescue.',
      malayalam:
          'ഉയരത്തിൽ ജോലി ചെയ്യുന്നതിന് മുമ്പ് സുരക്ഷിതമായ access, edge protection, fall protection, rescue plan എന്നിവ ഉറപ്പാക്കണം.',
    ),

    ReferenceTopic(
      title: 'Heat Stress Management',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE Reference',
      copNumber: 'Heat Stress',
      version: 'Current Reference',
      effectiveDate: 'Verify current seasonal requirements',
      shortDescription:
          'Prevention and management of heat-related illness in hot working environments.',
      overview:
          'Heat stress can occur when the body cannot effectively control its temperature. Outdoor and high-temperature work requires appropriate planning, hydration, rest and monitoring.',
      hazards:
          'Heat exhaustion\n'
          'Heat cramps\n'
          'Heat stroke\n'
          'Dehydration\n'
          'Reduced concentration and fatigue',
      controls:
          'Provide drinking water.\n'
          'Provide suitable shaded or cooled rest areas.\n'
          'Plan work to reduce exposure during extreme heat.\n'
          'Provide worker awareness and supervision.\n'
          'Monitor workers for symptoms.',
      planning:
          'Consider weather conditions, work intensity, worker acclimatisation, hydration, rest arrangements and emergency response before starting work.',
      safePractices:
          'Drink water regularly, take scheduled rest breaks and report symptoms early. Supervisors should monitor workers, particularly new or unacclimatised workers.',
      ppe:
          'Suitable work clothing, safety footwear, helmet and task-specific PPE. PPE should be selected with heat exposure in mind.',
      checklist:
          'Water available\n'
          'Rest/shade area available\n'
          'Heat-stress awareness completed\n'
          'Weather conditions reviewed\n'
          'Emergency arrangements available',
      inspection:
          'Check water availability, shaded rest facilities, work scheduling, worker condition and communication arrangements.',
      dos:
          'Drink water regularly and report dizziness, weakness, confusion or other symptoms immediately.',
      donts:
          'Do not ignore heat-stress symptoms or continue unsafe work because of production pressure.',
      stopWork:
          'Stop work and obtain assistance when a worker shows signs of serious heat illness or when conditions become unsafe.',
      emergency:
          'Move the affected worker to a cooler location, provide first aid and activate emergency medical assistance according to the site procedure.',
      malayalam:
          'ചൂട് കൂടുതലുള്ള സാഹചര്യത്തിൽ വെള്ളം കുടിക്കുക, നിശ്ചിത rest എടുക്കുക, heat-stress ലക്ഷണങ്ങൾ ഉടൻ report ചെയ്യുക. ഗുരുതരമായ ലക്ഷണങ്ങൾ കണ്ടാൽ ജോലി നിർത്തി അടിയന്തര സഹായം തേടണം.',
    ),

    ReferenceTopic(
      title: 'Lifting Operations',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE Reference',
      copNumber: 'Lifting Safety',
      version: 'Current Reference',
      effectiveDate: 'Verify latest requirement',
      shortDescription:
          'Safe planning and execution of crane and lifting operations.',
      overview:
          'Lifting operations require competent planning, suitable equipment, competent personnel and effective exclusion zones.',
      hazards:
          'Dropped loads\n'
          'Crane overturning\n'
          'Load swing\n'
          'Equipment failure\n'
          'People entering lifting zones',
      controls:
          'Use approved lifting plans.\n'
          'Confirm equipment capacity.\n'
          'Inspect lifting accessories.\n'
          'Use competent operators and riggers.\n'
          'Establish exclusion zones.',
      planning:
          'Confirm load weight, centre of gravity, lifting points, crane capacity, ground conditions, weather and communication arrangements.',
      safePractices:
          'Use certified lifting accessories and follow the approved lifting plan. Keep personnel away from suspended loads.',
      ppe:
          'Safety helmet, safety footwear, gloves, high-visibility clothing and task-specific PPE.',
      checklist:
          'Lift plan approved\n'
          'Equipment inspected\n'
          'Accessories inspected\n'
          'Load weight confirmed\n'
          'Exclusion zone established\n'
          'Competent lifting team available',
      inspection:
          'Inspect crane, lifting accessories, hooks, shackles, slings, ground conditions and exclusion zones.',
      dos:
          'Follow the lifting plan and maintain clear communication between the lifting team.',
      donts:
          'Never stand or work under a suspended load. Never exceed equipment capacity.',
      stopWork:
          'Stop the lifting operation if equipment defects, unstable ground, poor visibility, unsafe weather or communication failure occurs.',
      emergency:
          'Stop the operation, secure the load where possible and activate the site emergency procedure. Keep people away from the danger zone.',
      malayalam:
          'Lifting operation തുടങ്ങുന്നതിന് മുമ്പ് lifting plan, load weight, crane capacity, lifting accessories, ground condition, exclusion zone എന്നിവ പരിശോധിക്കണം.',
    ),

    ReferenceTopic(
      title: 'Excavation Safety',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE Reference',
      copNumber: 'Excavation Safety',
      version: 'Current Reference',
      effectiveDate: 'Verify latest requirement',
      shortDescription:
          'Controls for safe excavation, trenching and underground work.',
      overview:
          'Excavation work can expose workers to collapse, underground services, falls, flooding and hazardous atmospheres.',
      hazards:
          'Cave-in or collapse\n'
          'Underground services\n'
          'Falls into excavation\n'
          'Water ingress\n'
          'Hazardous atmosphere',
      controls:
          'Locate underground services before excavation.\n'
          'Provide suitable shoring, sloping or other protection.\n'
          'Control access.\n'
          'Provide safe access and egress.\n'
          'Keep spoil away from edges.',
      planning:
          'Review drawings and service information, conduct risk assessment and confirm excavation protection and emergency arrangements.',
      safePractices:
          'Inspect excavations regularly and after changes in conditions. Keep plant and materials away from excavation edges as required.',
      ppe:
          'Safety helmet, safety footwear, gloves, high-visibility clothing and task-specific PPE.',
      checklist:
          'Services identified\n'
          'Excavation protection provided\n'
          'Safe access provided\n'
          'Edges protected\n'
          'Spoil controlled\n'
          'Inspection completed',
      inspection:
          'Check excavation walls, access, water accumulation, edge protection, spoil placement and signs of ground movement.',
      dos:
          'Follow the approved excavation method and maintain required protective systems.',
      donts:
          'Do not enter an unsupported excavation where protection is required.',
      stopWork:
          'Stop work if ground movement, water ingress, unidentified services or unsafe access is identified.',
      emergency:
          'Keep people away from a collapsed or unstable excavation and call the emergency response team. Do not enter for an unplanned rescue.',
      malayalam:
          'Excavation തുടങ്ങുന്നതിന് മുമ്പ് underground services കണ്ടെത്തണം. ആവശ്യമായ shoring/sloping/protection, safe access, edge protection എന്നിവ ഉറപ്പാക്കണം.',
    ),

    ReferenceTopic(
      title: 'Electrical Safety',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE Reference',
      copNumber: 'Electrical Safety',
      version: 'Current Reference',
      effectiveDate: 'Verify latest requirement',
      shortDescription:
          'Basic controls for electrical hazards in construction and workplaces.',
      overview:
          'Electrical energy can cause shock, burns, arc flash, fire and fatal injury. Electrical work must be carried out by competent persons using approved systems.',
      hazards:
          'Electric shock\n'
          'Arc flash\n'
          'Electrical fire\n'
          'Damaged cables\n'
          'Contact with overhead or underground services',
      controls:
          'Isolate energy where possible.\n'
          'Use suitable protection devices.\n'
          'Inspect cables and equipment.\n'
          'Protect temporary electrical systems.\n'
          'Maintain safe distances from electrical services.',
      planning:
          'Identify electrical sources and services before work. Confirm isolation, permits, competent personnel and emergency arrangements.',
      safePractices:
          'Keep electrical equipment dry and protected. Report damaged cables, plugs, sockets and equipment immediately.',
      ppe:
          'Task-specific electrical PPE as determined by the risk assessment and authorised electrical procedure.',
      checklist:
          'Isolation confirmed\n'
          'Equipment inspected\n'
          'Cables protected\n'
          'Distribution boards protected\n'
          'Competent person assigned',
      inspection:
          'Inspect cables, plugs, sockets, distribution boards, protective devices and temporary electrical installations.',
      dos:
          'Use only approved equipment and follow isolation procedures.',
      donts:
          'Do not carry out unauthorised electrical work or use damaged electrical equipment.',
      stopWork:
          'Stop work if electrical equipment is damaged, isolation is uncertain or unsafe electrical conditions are identified.',
      emergency:
          'Do not touch a person who may still be energised. Isolate the electrical source if safe and activate emergency response.',
      malayalam:
          'Electrical work competent ആയ വ്യക്തികൾ മാത്രം ചെയ്യണം. Damaged cable/equipment ഉപയോഗിക്കരുത്. Isolation ഉറപ്പാക്കാതെ electrical work ആരംഭിക്കരുത്.',
    ),

    ReferenceTopic(
      title: 'Personal Protective Equipment',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE Reference',
      copNumber: 'PPE',
      version: 'Current Reference',
      effectiveDate: 'Verify latest requirement',
      shortDescription:
          'Selection, use and maintenance of personal protective equipment.',
      overview:
          'PPE is the last line of defence and should be selected based on the hazards and risk assessment. It does not replace engineering or administrative controls.',
      hazards:
          'Head injury\n'
          'Eye injury\n'
          'Foot injury\n'
          'Hand injury\n'
          'Hearing damage\n'
          'Respiratory exposure',
      controls:
          'Identify hazards first.\n'
          'Select suitable PPE.\n'
          'Provide training.\n'
          'Inspect PPE before use.\n'
          'Replace damaged PPE.',
      planning:
          'Determine PPE requirements from the risk assessment and task-specific procedure.',
      safePractices:
          'Wear PPE correctly, keep it clean and report defects immediately.',
      ppe:
          'Safety helmet, safety footwear, gloves, eye protection, hearing protection, respiratory protection and fall protection as required by the task.',
      checklist:
          'Correct PPE selected\n'
          'PPE available\n'
          'PPE inspected\n'
          'Worker trained\n'
          'Damaged PPE replaced',
      inspection:
          'Check condition, fit, cleanliness, certification where applicable and suitability for the task.',
      dos:
          'Use PPE as instructed and report defective equipment.',
      donts:
          'Do not modify PPE or use damaged or unsuitable PPE.',
      stopWork:
          'Stop the task if required PPE is unavailable or unsuitable for the identified hazard.',
      emergency:
          'Follow the task-specific emergency procedure and obtain medical assistance when required.',
      malayalam:
          'PPE risk assessment അടിസ്ഥാനമാക്കി തിരഞ്ഞെടുക്കണം. Damaged PPE ഉപയോഗിക്കരുത്. PPE മാത്രം ആശ്രയിക്കാതെ engineering/control measures ഉപയോഗിക്കണം.',
    ),

    ReferenceTopic(
      title: 'Abu Dhabi OSH Requirements',
      category: GuidelineCategory.abuDhabi,
      sourceLabel: 'Abu Dhabi OSH / ADOSH-SF Reference',
      copNumber: 'ADOSH-SF',
      version: 'Verify current revision',
      effectiveDate: 'Verify current official requirement',
      shortDescription:
          'Abu Dhabi-specific occupational safety and health reference.',
      overview:
          'Abu Dhabi workplaces may be subject to the Abu Dhabi Occupational Safety and Health System Framework and applicable Codes of Practice. Project and employer requirements must also be followed.',
      hazards:
          'Requirements vary by activity and work environment. Project-specific hazards must be identified through risk assessment.',
      controls:
          'Follow applicable Abu Dhabi OSH requirements.\n'
          'Use approved risk assessment and safe systems of work.\n'
          'Maintain required records and inspections.\n'
          'Follow project and employer procedures.',
      planning:
          'Identify the applicable Abu Dhabi OSH requirements and project-specific controls before starting work.',
      safePractices:
          'Workers and supervisors should follow approved procedures and report unsafe conditions promptly.',
      ppe:
          'Use PPE specified by the applicable risk assessment and project requirements.',
      checklist:
          'Applicable requirement identified\n'
          'Risk assessment completed\n'
          'Safe system available\n'
          'Workers briefed\n'
          'Inspections completed',
      inspection:
          'Verify workplace controls against applicable Abu Dhabi requirements and approved project procedures.',
      dos:
          'Always verify the latest applicable Abu Dhabi OSH requirement before making a compliance decision.',
      donts:
          'Do not assume a generic UAE control automatically satisfies an Abu Dhabi-specific requirement.',
      stopWork:
          'Stop work where a serious uncontrolled risk or significant compliance concern is identified.',
      emergency:
          'Follow the project emergency plan and applicable Abu Dhabi emergency arrangements.',
      malayalam:
          'Abu Dhabi-യിൽ ബാധകമായ ADOSH-SF requirements, Codes of Practice, project procedures എന്നിവ പരിശോധിച്ച ശേഷം മാത്രമേ compliance തീരുമാനം എടുക്കാവൂ.',
    ),

    ReferenceTopic(
      title: 'Dubai Code of Practice',
      category: GuidelineCategory.dubai,
      sourceLabel: 'Dubai HSE / Code of Practice Reference',
      copNumber: 'Dubai CoP',
      version: 'Verify current revision',
      effectiveDate: 'Verify current official requirement',
      shortDescription:
          'Dubai-specific HSE reference for workplace and construction activities.',
      overview:
          'Dubai projects may be governed by applicable Dubai authority requirements, Codes of Practice and project-specific HSE procedures. The exact requirement depends on the activity and authority jurisdiction.',
      hazards:
          'Hazards depend on the work activity and must be assessed through the project risk assessment.',
      controls:
          'Identify applicable Dubai authority requirements.\n'
          'Follow approved project procedures.\n'
          'Use competent personnel.\n'
          'Maintain inspection and training records.\n'
          'Implement suitable risk controls.',
      planning:
          'Confirm the applicable Dubai Code of Practice or authority requirement before work begins.',
      safePractices:
          'Follow approved method statements, risk assessments, permits and site HSE procedures.',
      ppe:
          'Use task-specific PPE according to the risk assessment and project requirements.',
      checklist:
          'Applicable Dubai requirement identified\n'
          'Risk assessment completed\n'
          'Permit requirements checked\n'
          'Workers briefed\n'
          'Inspection completed',
      inspection:
          'Verify controls against applicable Dubai requirements and project procedures.',
      dos:
          'Verify the current applicable Dubai authority requirement before compliance decisions.',
      donts:
          'Do not use an outdated Code of Practice or assume Abu Dhabi requirements are identical to Dubai requirements.',
      stopWork:
          'Stop work when serious uncontrolled risk or a significant compliance issue is identified.',
      emergency:
          'Follow the approved project emergency plan and applicable Dubai authority requirements.',
      malayalam:
          'Dubai-യിൽ ബാധകമായ authority requirements, Code of Practice, project procedures എന്നിവ പരിശോധിച്ച ശേഷമാണ് compliance തീരുമാനം എടുക്കേണ്ടത്.',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ReferenceTopic> get _filteredTopics {
    final query = _query.trim().toLowerCase();

    return _topics.where((topic) {
      final matchesCategory =
          _selectedCategory == GuidelineCategory.all ||
              topic.category == _selectedCategory;

      final matchesSearch =
          query.isEmpty ||
          topic.title.toLowerCase().contains(query) ||
          topic.sourceLabel.toLowerCase().contains(query) ||
          topic.shortDescription.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final topics = _filteredTopics;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: const Text(
          'HSE Guidelines',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildCategoryFilter(),
            Expanded(
              child: topics.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
                      itemCount: topics.length,
                      itemBuilder: (context, index) {
                        return _buildGuidelineCard(topics[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'UAE HSE Safety Reference',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0B5D4B),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'UAE General • Abu Dhabi • Dubai',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _query = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search guidelines...',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: _query.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _query = '';
                        });
                      },
                    )
                  : null,
              filled: true,
              fillColor: const Color(0xFFF3F5F4),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _filterChip('All', GuidelineCategory.all),
            _filterChip('UAE General', GuidelineCategory.uaeGeneral),
            _filterChip('Abu Dhabi', GuidelineCategory.abuDhabi),
            _filterChip('Dubai', GuidelineCategory.dubai),
          ],
        ),
      ),
    );
  }

  Widget _filterChip(String label, GuidelineCategory category) {
    final selected = _selectedCategory == category;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) {
          setState(() {
            _selectedCategory = category;
          });
        },
        selectedColor: const Color(0xFF159447),
        labelStyle: TextStyle(
          color: selected ? Colors.white : const Color(0xFF444444),
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildGuidelineCard(ReferenceTopic topic) {
    final categoryColor = _categoryColor(topic.category);

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
              builder: (_) => GuidelineDetailPage(topic: topic),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: categoryColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  _categoryIcon(topic.category),
                  color: categoryColor,
                  size: 25,
                ),
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
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF17201D),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      topic.shortDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: Color(0xFF666666),
                      ),
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: categoryColor.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            topic.category.label,
                            style: TextStyle(
                              color: categoryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: Color(0xFF999999),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 60,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 14),
            const Text(
              'No guidelines found',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Try another search or category.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF777777),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _categoryColor(GuidelineCategory category) {
    switch (category) {
      case GuidelineCategory.uaeGeneral:
        return const Color(0xFF0B5D4B);
      case GuidelineCategory.abuDhabi:
        return const Color(0xFF8A6500);
      case GuidelineCategory.dubai:
        return const Color(0xFF7B3F98);
      case GuidelineCategory.all:
        return const Color(0xFF159447);
    }
  }

  IconData _categoryIcon(GuidelineCategory category) {
    switch (category) {
      case GuidelineCategory.uaeGeneral:
        return Icons.shield_rounded;
      case GuidelineCategory.abuDhabi:
        return Icons.location_city_rounded;
      case GuidelineCategory.dubai:
        return Icons.business_rounded;
      case GuidelineCategory.all:
        return Icons.menu_book_rounded;
    }
  }
}
