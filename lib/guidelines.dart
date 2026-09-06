import 'package:flutter/material.dart';

class GuidelinesPage extends StatefulWidget {
  const GuidelinesPage({super.key});

  @override
  State<GuidelinesPage> createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  final TextEditingController _searchController = TextEditingController();

  String _query = '';
  _GuidelineCategory _selectedCategory = _GuidelineCategory.all;

  static const List<_ReferenceTopic> _topics = [
    // ==========================================================
    // UAE GENERAL
    // ==========================================================

    _ReferenceTopic(
      title: 'Personal Protective Equipment (PPE)',
      category: _GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE • General Safety Reference',
      copNumber: 'UAE General HSE Reference – PPE',
      version: 'Current Reference',
      effectiveDate: 'Verify latest applicable requirement',
      shortDescription:
          'Basic PPE selection, use, inspection and maintenance for workplace hazards.',
      overview:
          'Personal Protective Equipment is the last line of defence after hazards have been eliminated or controlled through engineering and administrative measures. PPE must be selected according to the task, hazard, exposure and applicable site requirements.',
      hazards:
          'Head injury • Eye injury • Foot injury • Hand injury • Hearing damage • Respiratory exposure • Falling objects • Chemical exposure.',
      controls:
          'Identify hazards • Select suitable PPE • Ensure correct fit • Train workers • Inspect before use • Maintain PPE • Replace damaged PPE • Store correctly.',
      planning:
          'Complete a task risk assessment and determine the required PPE. Consider compatibility when multiple PPE items are used together.',
      safePractices:
          'Inspect PPE before use. Wear PPE correctly and continuously where required. Keep PPE clean and maintained. Report damaged or unsuitable PPE immediately.',
      ppe:
          'Safety helmet • Safety footwear • Safety glasses • Gloves • High-visibility clothing • Hearing protection • Respiratory protection • Fall protection as required.',
      checklist:
          'Hazard assessed • PPE selected • Correct size • PPE inspected • Worker trained • PPE compatible • Replacement available • Storage available.',
      inspection:
          'Helmet • Chin strap where required • Eye protection • Gloves • Footwear • Harness • Lanyard • Respirator • Damage or contamination.',
      dos:
          'Use the PPE specified for the task. Inspect before use. Report defects. Maintain PPE properly.',
      donts:
          'Do not use damaged PPE. Do not modify PPE without authorization. Do not rely on PPE when higher-level controls are reasonably practicable.',
      stopWork:
          'Stop the task when required PPE is unavailable, defective or unsuitable for the identified hazard.',
      emergency:
          'Move away from the hazard when safe and activate the site emergency procedure. Provide first aid or medical assistance as required.',
      malayalam:
          'PPE അപകടത്തിൽ നിന്ന് സംരക്ഷിക്കുന്ന അവസാന പ്രതിരോധമാണ്. ആദ്യം hazard eliminate/control ചെയ്യാൻ ശ്രമിക്കണം. Safety helmet, footwear, eye protection, gloves, hearing protection, respiratory protection, fall protection എന്നിവ task risk assessment അനുസരിച്ച് തിരഞ്ഞെടുക്കണം.',
    ),

    _ReferenceTopic(
      title: 'Risk Assessment',
      category: _GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE • General Safety Reference',
      copNumber: 'UAE General HSE Reference – Risk Assessment',
      version: 'Current Reference',
      effectiveDate: 'Verify latest applicable requirement',
      shortDescription:
          'Identify hazards, evaluate risks and establish effective controls before work begins.',
      overview:
          'Risk assessment is a systematic process used to identify hazards, evaluate the associated risks and determine appropriate control measures. It should be reviewed when conditions, methods or equipment change.',
      hazards:
          'Unidentified hazards • Inadequate controls • Changing site conditions • Simultaneous activities • Human factors • Equipment failure.',
      controls:
          'Hazard identification • Risk evaluation • Hierarchy of controls • Worker consultation • Control implementation • Review and monitoring.',
      planning:
          'Break the task into steps, identify hazards for each step and establish controls before work starts. Review the assessment when conditions change.',
      safePractices:
          'Communicate the assessment to affected workers. Confirm controls are implemented. Stop and reassess when unexpected hazards appear.',
      ppe:
          'PPE must be selected based on the residual risk after other controls have been considered.',
      checklist:
          'Task defined • Hazards identified • Risk evaluated • Controls selected • Responsible persons identified • Workers briefed • Review date/trigger defined.',
      inspection:
          'Control implementation • Site conditions • Worker understanding • Equipment • Changes in work method • New hazards.',
      dos:
          'Involve competent personnel. Review changing conditions. Make controls practical and effective.',
      donts:
          'Do not treat risk assessment as paperwork only. Do not continue when actual conditions differ significantly from the assessment.',
      stopWork:
          'Stop work when a significant uncontrolled hazard is identified or when the existing assessment no longer reflects actual conditions.',
      emergency:
          'Follow the site emergency procedure and reassess the task before restarting work.',
      malayalam:
          'Risk assessment വഴി work തുടങ്ങുന്നതിന് മുമ്പ് hazards കണ്ടെത്തി risk evaluate ചെയ്ത് controls നിശ്ചയിക്കണം. Site condition, work method, equipment അല്ലെങ്കിൽ people മാറുമ്പോൾ assessment review ചെയ്യണം.',
    ),

    // ==========================================================
    // ABU DHABI – ADPHC / ADOSH-SF
    // ==========================================================

    _ReferenceTopic(
      title: 'Excavation',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 29.0',
      copNumber: 'CoP 29.0 – Excavation Work',
      version: 'V4.1',
      effectiveDate: '27 February 2026',
      shortDescription:
          'Safety guidance for excavation planning, ground stability, underground services, access and protection.',
      overview:
          'Excavation work involves removing soil or other material from the ground and can expose workers to collapse, falling materials, underground services, mobile plant, water ingress and falls.',
      hazards:
          'Ground collapse • Cave-in • Underground services • Falls • Falling materials • Mobile plant • Water accumulation • Ground movement.',
      controls:
          'Risk assessment • Underground service identification • Protective system • Safe access and egress • Edge protection • Spoil control • Plant control • Inspection.',
      planning:
          'Review drawings, service information and site conditions. Assess soil, nearby structures, access, spoil placement, plant movement, water control and emergency arrangements.',
      safePractices:
          'Inspect before entry and after significant changes. Maintain safe access. Keep people and plant away from unsafe edges. Maintain barricading.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Gloves • Eye protection • Task-specific PPE.',
      checklist:
          'Risk assessment • Services identified • Method approved • Ground assessed • Protective system • Access/egress • Edge protection • Spoil controlled • Plant controlled • Inspection.',
      inspection:
          'Excavation walls • Protective system • Edge protection • Access • Spoil • Plant • Water • Cracks • Ground movement • Barricading.',
      dos:
          'Inspect before entry. Follow the approved excavation method. Maintain safe access. Report ground movement immediately.',
      donts:
          'Do not enter an unsafe excavation. Do not ignore service information. Do not place plant or materials near unsafe edges.',
      stopWork:
          'Stop work for collapse, cracking, unexpected movement, unknown services, water ingress, damaged protection or unsafe access.',
      emergency:
          'Raise the alarm and isolate the area. Keep people away from a collapse zone. Do not enter a collapsed excavation for rescue without approved rescue arrangements.',
      malayalam:
          'Excavation തുടങ്ങുന്നതിന് മുമ്പ് underground services കണ്ടെത്തുകയും ground stability പരിശോധിക്കുകയും വേണം. ആവശ്യമായിടത്ത് shoring, shielding അല്ലെങ്കിൽ battering നൽകണം. Ground movement, cracking അല്ലെങ്കിൽ water ingress കണ്ടാൽ work നിർത്തണം.',
    ),

    _ReferenceTopic(
      title: 'Scaffolding',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 26.0',
      copNumber: 'CoP 26.0 – Scaffolding',
      version: 'V4.1',
      effectiveDate: '27 February 2026',
      shortDescription:
          'Safe scaffold erection, inspection, access, loading, stability and use.',
      overview:
          'Scaffolding provides temporary access and working platforms. It must be selected, erected, inspected, maintained and used by competent personnel.',
      hazards:
          'Falls • Collapse • Falling objects • Overloading • Unsafe access • Missing guardrails • Unstable foundation • Unauthorized alteration.',
      controls:
          'Competent erection • Stable foundation • Bracing • Guardrails • Toe boards • Safe access • Load control • Inspection • Status control.',
      planning:
          'Select suitable scaffold for height, configuration, access and loading. Confirm foundation, erection, inspection, access, loading and dismantling arrangements.',
      safePractices:
          'Use only inspected scaffolding. Keep platforms tidy. Respect loading limits. Keep guardrails and toe boards in place.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • High-visibility clothing • Fall protection where required.',
      checklist:
          'Foundation • Uprights • Bracing • Guardrails • Toe boards • Platform • Access • Loading • Inspection status.',
      inspection:
          'Foundation • Uprights • Bracing • Connections • Platforms • Guardrails • Toe boards • Access • Tag/status • Damage.',
      dos:
          'Use inspected scaffolding. Respect loading limits. Report defects immediately.',
      donts:
          'Do not use incomplete or damaged scaffolding. Do not remove guardrails or braces without authorization. Do not overload.',
      stopWork:
          'Stop use if incomplete, unstable, damaged, overloaded or improperly modified.',
      emergency:
          'Prevent access to an unsafe scaffold and activate the site emergency procedure if an incident occurs.',
      malayalam:
          'Scaffolding competent personnel ഉപയോഗിച്ച് erect ചെയ്യുകയും inspect ചെയ്യുകയും വേണം. Foundation, bracing, guardrails, toe boards, platforms, safe access എന്നിവ ശരിയായിരിക്കണം. Overload ചെയ്യരുത്.',
    ),

    _ReferenceTopic(
      title: 'Working at Height',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 23.0',
      copNumber: 'CoP 23.0 – Working at Height',
      version: 'V4.1',
      effectiveDate: '27 February 2026',
      shortDescription:
          'Prevent falls through safe access, edge protection, platforms, fall protection and rescue planning.',
      overview:
          'Work at height can expose workers to falls from one level to another and falling objects. Work must be planned and controlled using suitable platforms, access systems and fall-protection arrangements.',
      hazards:
          'Falls • Falling objects • Open edges • Floor openings • Unsafe ladders • Unstable platforms • Incorrect harness use • Inadequate rescue.',
      controls:
          'Avoid unnecessary height work • Suitable platforms • Guardrails • Edge protection • Protected openings • Safe access • Fall protection • Rescue plan.',
      planning:
          'Consider whether the task can be completed from ground level. Select suitable access equipment and assess edges, openings, weather and rescue requirements.',
      safePractices:
          'Use approved access equipment. Protect edges and openings. Inspect harnesses and lanyards. Use suitable anchor points. Secure tools.',
      ppe:
          'Safety helmet • Safety footwear • Full-body harness where required • Gloves • Eye protection.',
      checklist:
          'Risk assessment • Safe access • Platform • Edge protection • Openings protected • Harness • Anchorage • Falling-object control • Rescue plan.',
      inspection:
          'Platform • Guardrails • Edge protection • Openings • Access equipment • Harness • Lanyard • Anchorage • Rescue arrangements.',
      dos:
          'Plan the task. Use approved access equipment. Maintain fall protection. Secure tools and materials.',
      donts:
          'Do not work from unstable surfaces. Do not use damaged fall protection. Do not use unsuitable anchor points.',
      stopWork:
          'Stop when safe access, edge protection, fall protection or suitable anchorage is unavailable.',
      emergency:
          'Activate the approved rescue plan. Avoid creating a second casualty. Provide first aid and medical assistance.',
      malayalam:
          'Height work തുടങ്ങുന്നതിന് മുമ്പ് ground-level alternative പരിശോധിക്കുക. Safe platform, guardrail, edge protection, suitable fall protection എന്നിവ ഉറപ്പാക്കണം. Harness suitable anchorage-ൽ മാത്രം ഉപയോഗിക്കുക.',
    ),

    _ReferenceTopic(
      title: 'Permit to Work',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 21.0',
      copNumber: 'CoP 21.0 – Permit to Work Systems',
      version: 'V4.0',
      effectiveDate: '15 July 2024',
      shortDescription:
          'Plan and authorize high-risk work through a controlled permit-to-work system.',
      overview:
          'A Permit to Work system formally controls specified high-risk activities by confirming hazards, precautions, isolations and authorization.',
      hazards:
          'Uncontrolled high-risk work • Conflicting activities • Energy release • Fire • Electrical hazards • Confined-space hazards • Excavation hazards.',
      controls:
          'Correct permit • Risk assessment • Isolation • Defined work area • Authorization • Gas testing where applicable • Toolbox briefing • Close-out.',
      planning:
          'Determine whether a permit is required. Confirm scope, hazards, isolations, precautions, responsible persons and validity before work begins.',
      safePractices:
          'Understand permit conditions. Do not start before authorization. Maintain controls throughout the permit validity. Revalidate when required.',
      ppe:
          'PPE must be selected according to the specific work and permit risk assessment.',
      checklist:
          'Correct permit • Risk assessment • Isolation • Controls • Authorization • Worker briefing • Permit status • Close-out.',
      inspection:
          'Permit conditions • Isolation • Work area • Controls • Gas testing • Worker understanding • Permit status.',
      dos:
          'Read and understand the permit. Follow every condition. Stop and seek reauthorization when conditions change.',
      donts:
          'Do not work without required authorization. Do not bypass isolations. Do not continue after expiry or suspension.',
      stopWork:
          'Stop when permit conditions are not satisfied, controls fail, scope changes or an unexpected hazard appears.',
      emergency:
          'Stop work, raise the alarm, isolate energy where safe and follow emergency procedures.',
      malayalam:
          'High-risk work തുടങ്ങുന്നതിന് മുമ്പ് applicable Permit to Work ആവശ്യമാണ്. Permit conditions, isolation, risk controls എന്നിവ clear ആയിരിക്കണം. Conditions മാറിയാൽ work stop ചെയ്ത് revalidation വേണം.',
    ),

    _ReferenceTopic(
      title: 'Hot Work',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 28.0',
      copNumber: 'CoP 28.0 – Hot Work Operations',
      version: 'V4.1',
      effectiveDate: '27 February 2026',
      shortDescription:
          'Control welding, cutting, grinding and other work producing heat, flames or sparks.',
      overview:
          'Hot work includes welding, cutting and processes producing heat, flame or sparks. It can cause fire, explosion, burns, fumes and eye injuries.',
      hazards:
          'Fire • Explosion • Burns • Sparks • Fumes • Eye injury • Gas cylinders • Ignition of combustibles.',
      controls:
          'Permit/authorization • Combustible control • Fire extinguishers • Fire watch • Cylinder control • Screens • Ventilation • Post-work check.',
      planning:
          'Identify combustibles and nearby operations. Establish fire protection, cylinder controls, ventilation and post-work monitoring.',
      safePractices:
          'Inspect the area. Remove/protect combustibles. Secure cylinders and hoses. Maintain fire protection and required fire watch.',
      ppe:
          'Welding helmet • Welding gloves • Flame-resistant clothing • Safety footwear • Face protection where required.',
      checklist:
          'Permit • Combustibles controlled • Extinguisher • Fire watch • Cylinders secured • Hoses • Screens • Ventilation • Post-work inspection.',
      inspection:
          'Combustibles • Fire protection • Leads • Cylinders • Hoses • Regulators • Screens • Ventilation.',
      dos:
          'Maintain fire watch where required. Secure cylinders. Use suitable PPE. Inspect after work.',
      donts:
          'Do not hot work near uncontrolled combustibles. Do not use damaged gas equipment.',
      stopWork:
          'Stop if combustibles cannot be controlled, fire protection is unavailable, gas equipment is defective or ventilation is inadequate.',
      emergency:
          'Raise the alarm. Use fire equipment only if trained and safe. Evacuate for uncontrolled fire.',
      malayalam:
          'Hot work-ൽ welding, cutting, grinding എന്നിവ ഉൾപ്പെടുന്നു. Fire, explosion, burns, fumes എന്നിവ പ്രധാന hazards ആണ്. Permit, combustible control, extinguisher, fire watch, ventilation എന്നിവ ഉറപ്പാക്കണം.',
    ),

    _ReferenceTopic(
      title: 'Confined Space',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 27.0',
      copNumber: 'CoP 27.0 – Confined Spaces',
      version: 'V4.0',
      effectiveDate: '15 July 2024',
      shortDescription:
          'Control atmospheric, access, engulfment, energy and rescue hazards.',
      overview:
          'Confined spaces may contain hazardous atmospheres, restricted access, engulfment risks or other conditions that can seriously endanger workers.',
      hazards:
          'Oxygen deficiency • Toxic gases • Flammable atmosphere • Engulfment • Restricted access • Heat • Mechanical/electrical energy.',
      controls:
          'Assessment • Entry authorization • Isolation • Atmospheric testing • Ventilation • Communication • Standby • Rescue plan.',
      planning:
          'Assess atmospheric, physical and energy hazards. Plan isolation, testing, ventilation, communication, entry control and rescue.',
      safePractices:
          'Do not enter without authorization. Test atmosphere as required. Maintain communication and entry control. Keep rescue equipment ready.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Eye protection • Respiratory protection where required • Retrieval equipment where required.',
      checklist:
          'Entry assessment • Authorization • Isolation • Gas testing • Ventilation • Communication • Standby • Rescue plan • PPE.',
      inspection:
          'Atmosphere • Ventilation • Isolation • Access • Communication • Rescue equipment • Entry register • PPE.',
      dos:
          'Test before entry. Maintain communication. Follow the approved entry procedure.',
      donts:
          'Do not enter an unknown atmosphere. Do not attempt an unplanned rescue entry.',
      stopWork:
          'Stop entry if atmosphere is unsafe, ventilation fails, communication is lost, isolation is compromised or rescue arrangements are unavailable.',
      emergency:
          'Raise the alarm and activate the confined-space rescue plan. Do not enter without suitable rescue equipment and competent support.',
      malayalam:
          'Confined space-ൽ oxygen deficiency, toxic gas, flammable atmosphere, engulfment തുടങ്ങിയ hazards ഉണ്ടാകാം. Entry authorization, isolation, gas testing, ventilation, communication, standby, rescue plan എന്നിവ നിർബന്ധമായും പരിഗണിക്കണം.',
    ),

    _ReferenceTopic(
      title: 'Electrical Safety',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 15.0',
      copNumber: 'CoP 15.0 – Electrical Safety',
      version: 'V4.0',
      effectiveDate: '15 July 2024',
      shortDescription:
          'Control electrical shock, arc, fire and equipment hazards.',
      overview:
          'Electrical systems and tools can cause shock, burns, arc flash, fire and equipment damage. Electrical work must be planned, installed, protected, inspected and maintained.',
      hazards:
          'Electric shock • Electrocution • Arc flash • Burns • Fire • Damaged cables • Poor earthing • Wet conditions.',
      controls:
          'Competent personnel • Isolation • Protection devices • Inspection • Earthing • RCD/GFCI where applicable • Cable protection • Lockout/tagout where required.',
      planning:
          'Identify electrical sources and circuits. Assess temporary power, wet areas, cables, tools and services. Plan isolation and inspection.',
      safePractices:
          'Inspect cables, plugs and tools. Protect cables from damage and water. Isolate before maintenance.',
      ppe:
          'Safety footwear • Safety helmet • Eye protection • Task-specific electrical PPE • Arc-rated PPE where required.',
      checklist:
          'Competent personnel • Isolation • Protection • Earthing • RCD/GFCI where required • Cable condition • Plug condition • Tool inspection.',
      inspection:
          'Distribution boards • Cables • Plugs • Sockets • Earthing • Protection devices • Temporary connections • Tools.',
      dos:
          'Use competent electrical personnel. Inspect equipment. Isolate before maintenance.',
      donts:
          'Do not use damaged cables. Do not bypass protection devices. Do not perform electrical work without competence and authorization.',
      stopWork:
          'Stop for exposed conductors, damaged cables, failed protection, water intrusion, overheating, arcing or uncertain isolation.',
      emergency:
          'Do not touch an electrically energized casualty. Isolate the source if safe, call emergency support and provide first aid only when safe.',
      malayalam:
          'Electrical safety-ൽ shock, electrocution, arc flash, fire എന്നിവ പ്രധാന hazards ആണ്. Cables, plugs, tools, distribution boards എന്നിവ inspect ചെയ്യണം. Maintenance മുമ്പ് isolation വേണം.',
    ),

    _ReferenceTopic(
      title: 'Working in Heat',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 11.0',
      copNumber: 'CoP 11.0 – Safety in the Heat',
      version: 'V4.0',
      effectiveDate: '15 July 2024',
      shortDescription:
          'Prevent heat stress through hydration, rest, acclimatization and monitoring.',
      overview:
          'Hot and humid conditions can cause dehydration, heat exhaustion and heat-related illness. Work should be planned according to environmental conditions and task demands.',
      hazards:
          'Dehydration • Heat exhaustion • Heat stroke • Fatigue • Reduced concentration • Increased accident risk.',
      controls:
          'Hydration • Rest • Shade/cooling • Acclimatization • Work-rest planning • Heat monitoring • Awareness • Emergency response.',
      planning:
          'Assess environmental conditions and task demands. Plan hydration, shaded or cooled rest areas, work-rest arrangements and emergency response.',
      safePractices:
          'Drink water regularly. Take planned rest. Use shaded/cool areas. Report symptoms early and watch coworkers.',
      ppe:
          'Suitable work clothing • Safety helmet with approved accessories where applicable • Safety footwear • Task PPE.',
      checklist:
          'Heat risk assessed • Water • Rest area • Worker briefing • Acclimatization • Work-rest plan • Heat monitoring • Emergency arrangements.',
      inspection:
          'Water supply • Rest area • Shade/cooling • Worker condition • Heat controls • Communication • Emergency access.',
      dos:
          'Hydrate regularly. Rest as planned. Report symptoms early.',
      donts:
          'Do not ignore dizziness, confusion, severe weakness or other heat-illness symptoms.',
      stopWork:
          'Stop affected work when heat controls are inadequate or workers show heat-illness symptoms.',
      emergency:
          'Move the affected worker to a cool area, provide appropriate first aid and activate medical/emergency procedures.',
      malayalam:
          'Hot and humid climate-ൽ dehydration, heat exhaustion, heat stroke എന്നിവയുടെ risk കൂടുതലാണ്. Water, rest, shade/cooling, acclimatization, heat monitoring എന്നിവ ഉറപ്പാക്കണം.',
    ),

    // ==========================================================
    // DUBAI
    // ==========================================================

    _ReferenceTopic(
      title: 'Construction Site Safety',
      category: _GuidelineCategory.dubai,
      sourceLabel: 'Dubai Municipality • Construction Safety',
      copNumber:
          'Administrative Resolution No. (112) of 2026 – Safety Guide for Construction Works in the Emirate of Dubai',
      version: '2026',
      effectiveDate: '2026',
      shortDescription:
          'Dubai construction safety reference covering site organization, hazard control, safe work and construction activities.',
      overview:
          'Construction work in Dubai must be planned and carried out with appropriate controls for workers, the public, equipment, temporary works and the surrounding environment. The applicable Dubai legislation, safety guide, approved project procedures and authority requirements must be followed.',
      hazards:
          'Falls • Falling objects • Excavation collapse • Plant movement • Electrical hazards • Fire • Lifting hazards • Temporary works failure • Public interface.',
      controls:
          'Approved construction arrangements • Risk assessment • Competent supervision • Safe access • Barricading • Plant control • Inspection • Emergency planning • Housekeeping.',
      planning:
          'Review applicable Dubai requirements and approved project documents. Plan work sequence, access, temporary works, lifting, excavation, traffic interface, emergency arrangements and public protection.',
      safePractices:
          'Follow approved method statements and site procedures. Maintain access routes, barricades and housekeeping. Keep workers and public separated from construction hazards.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Eye protection • Gloves • Task-specific PPE.',
      checklist:
          'Risk assessment • Approved method • Competent supervision • Access • Barricading • Plant control • Emergency plan • Housekeeping • PPE.',
      inspection:
          'Access routes • Barriers • Work areas • Plant • Temporary works • Electrical arrangements • Housekeeping • PPE.',
      dos:
          'Follow approved Dubai/project requirements. Report unsafe conditions. Maintain public and worker protection.',
      donts:
          'Do not bypass approved safety controls. Do not allow unauthorized persons into construction hazard areas.',
      stopWork:
          'Stop work when a serious uncontrolled hazard exists or when required safety arrangements are not in place.',
      emergency:
          'Raise the alarm, secure the affected area and follow the project emergency procedure and applicable Dubai authority requirements.',
      malayalam:
          'Dubai construction work ചെയ്യുമ്പോൾ Dubai Municipality-യുടെ applicable current requirements, approved project procedures, risk assessment, method statement എന്നിവ പാലിക്കണം. Workers, public, plant, temporary works എന്നിവയുടെ safety ഉറപ്പാക്കണം.',
    ),

    _ReferenceTopic(
      title: 'Dubai Excavation Safety',
      category: _GuidelineCategory.dubai,
      sourceLabel: 'Dubai Municipality • Construction Safety',
      copNumber:
          'Dubai Construction Safety Guide – Excavation / Earthworks Reference',
      version: '2026 Reference',
      effectiveDate: 'Verify latest applicable requirement',
      shortDescription:
          'Control excavation collapse, underground services, access, edge and plant hazards in Dubai.',
      overview:
          'Excavation activities in Dubai require proper planning, assessment of ground and surrounding conditions, identification of underground services and effective protection against collapse and falls.',
      hazards:
          'Collapse • Underground utilities • Falls • Falling materials • Plant interaction • Water ingress • Adjacent structure movement.',
      controls:
          'Risk assessment • Utility/service identification • Protective system • Edge protection • Safe access • Spoil control • Plant exclusion • Inspection.',
      planning:
          'Review drawings and service information. Assess soil and adjacent structures. Plan excavation sequence, protective measures, access, spoil placement and emergency arrangements.',
      safePractices:
          'Inspect before entry and after changes. Keep spoil and plant controlled. Maintain barriers and safe access.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Gloves • Eye protection.',
      checklist:
          'Services identified • Ground assessed • Protective system • Access • Edge protection • Spoil • Plant • Barricading • Inspection.',
      inspection:
          'Excavation face • Ground • Cracks • Edge • Spoil • Plant • Water • Access • Barricading.',
      dos:
          'Follow approved excavation procedures. Inspect conditions. Report movement or unexpected services.',
      donts:
          'Do not enter an unsafe excavation. Do not remove protection without authorization.',
      stopWork:
          'Stop for collapse risk, unexpected services, ground movement, water ingress or failed protection.',
      emergency:
          'Raise the alarm and isolate the excavation. Do not enter a collapse zone without an approved rescue arrangement.',
      malayalam:
          'Dubai-യിൽ excavation തുടങ്ങുന്നതിന് മുമ്പ് underground utilities/service information പരിശോധിക്കുകയും ground condition assess ചെയ്യുകയും വേണം. Edge protection, safe access, spoil control, barricading എന്നിവ ഉറപ്പാക്കണം.',
    ),

    _ReferenceTopic(
      title: 'Dubai Working at Height',
      category: _GuidelineCategory.dubai,
      sourceLabel: 'Dubai Municipality • Construction Safety',
      copNumber:
          'Dubai Construction Safety Guide – Work at Height Reference',
      version: '2026 Reference',
      effectiveDate: 'Verify latest applicable requirement',
      shortDescription:
          'Prevent falls and falling objects during elevated construction work in Dubai.',
      overview:
          'Work at height must be planned to prevent falls, falling objects and unsafe access. Suitable platforms, edge protection and fall-protection systems should be used according to the task and applicable requirements.',
      hazards:
          'Falls • Falling objects • Open edges • Openings • Unsafe ladders • Unstable platforms • Poor rescue arrangements.',
      controls:
          'Avoid height work where practicable • Safe platforms • Guardrails • Edge protection • Protected openings • Suitable fall protection • Rescue planning.',
      planning:
          'Assess whether ground-level work is possible. Select suitable access equipment and plan edge protection, falling-object controls and rescue.',
      safePractices:
          'Use inspected access equipment. Maintain guardrails. Secure tools. Use suitable fall protection where required.',
      ppe:
          'Safety helmet • Safety footwear • Harness/lanyard where required • Gloves • Eye protection.',
      checklist:
          'Access • Platform • Guardrails • Openings • Harness • Anchorage • Tool securing • Rescue arrangement.',
      inspection:
          'Platforms • Guardrails • Ladders • Harnesses • Anchorage • Openings • Falling-object controls.',
      dos:
          'Plan the task. Use approved equipment. Maintain protection.',
      donts:
          'Do not climb guardrails. Do not use damaged fall-protection equipment. Do not work from unstable surfaces.',
      stopWork:
          'Stop when safe access or required fall protection is unavailable.',
      emergency:
          'Activate the approved rescue arrangement and emergency response. Avoid secondary exposure.',
      malayalam:
          'Dubai-യിൽ work at height ചെയ്യുമ്പോൾ safe platform, guardrails, edge protection, protected openings, suitable fall protection എന്നിവ ഉറപ്പാക്കണം. Harness suitable anchorage-ൽ മാത്രം ഉപയോഗിക്കുക.',
    ),

    _ReferenceTopic(
      title: 'Dubai Scaffolding',
      category: _GuidelineCategory.dubai,
      sourceLabel: 'Dubai Municipality • Construction Safety',
      copNumber:
          'Dubai Construction Safety Guide – Scaffolding Reference',
      version: '2026 Reference',
      effectiveDate: 'Verify latest applicable requirement',
      shortDescription:
          'Safe scaffold erection, stability, access, inspection and use in Dubai.',
      overview:
          'Scaffolding used in Dubai construction activities must be suitable for the intended work, stable, properly erected and maintained, with safe access and fall protection.',
      hazards:
          'Collapse • Falls • Falling objects • Overloading • Unsafe access • Unstable foundation • Unauthorized alteration.',
      controls:
          'Competent erection • Stable foundation • Bracing • Guardrails • Toe boards • Safe access • Load control • Inspection.',
      planning:
          'Select suitable scaffold based on height, configuration and loading. Plan erection, inspection, access and dismantling.',
      safePractices:
          'Use inspected scaffold. Keep platforms tidy. Do not exceed intended loads. Maintain guardrails and toe boards.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • High-visibility clothing • Fall protection where required.',
      checklist:
          'Foundation • Bracing • Guardrails • Toe boards • Platform • Access • Loading • Inspection status.',
      inspection:
          'Foundation • Uprights • Bracing • Connections • Platforms • Guardrails • Access • Damage.',
      dos:
          'Use inspected scaffold. Report defects. Maintain access and protection.',
      donts:
          'Do not overload or modify without authorization. Do not use incomplete or damaged scaffold.',
      stopWork:
          'Stop scaffold use if instability, damage, missing protection or unauthorized modification is identified.',
      emergency:
          'Prevent access to unsafe scaffold and activate site emergency procedures.',
      malayalam:
          'Dubai-യിൽ scaffolding competent personnel ഉപയോഗിച്ച് erect/inspect ചെയ്യണം. Stable foundation, bracing, guardrails, toe boards, safe access എന്നിവ ഉറപ്പാക്കണം.',
    ),

    _ReferenceTopic(
      title: 'Dubai Hot Work',
      category: _GuidelineCategory.dubai,
      sourceLabel: 'Dubai Municipality • Construction Safety',
      copNumber:
          'Dubai Construction Safety Guide – Hot Work Reference',
      version: '2026 Reference',
      effectiveDate: 'Verify latest applicable requirement',
      shortDescription:
          'Control fire, explosion, burns and fumes from welding, cutting and other hot work.',
      overview:
          'Hot work in Dubai construction areas should be planned and controlled to prevent ignition of combustible materials, fire, explosion, burns and exposure to fumes.',
      hazards:
          'Fire • Explosion • Burns • Sparks • Fumes • Gas cylinders • Ignition of combustibles.',
      controls:
          'Permit/authorization where required • Combustible control • Fire extinguisher • Fire watch • Cylinder control • Ventilation • Post-work inspection.',
      planning:
          'Identify combustible materials and nearby operations. Establish fire protection and post-work monitoring arrangements.',
      safePractices:
          'Inspect the area. Remove or protect combustibles. Secure cylinders. Maintain fire controls.',
      ppe:
          'Welding helmet • Gloves • Flame-resistant clothing • Safety footwear • Face protection.',
      checklist:
          'Authorization • Combustibles controlled • Extinguisher • Fire watch • Cylinders • Hoses • Ventilation • Post-work inspection.',
      inspection:
          'Combustibles • Fire protection • Cylinders • Hoses • Regulators • Screens • Ventilation.',
      dos:
          'Maintain fire controls. Secure cylinders. Use correct PPE.',
      donts:
          'Do not hot work near uncontrolled combustibles. Do not use defective gas equipment.',
      stopWork:
          'Stop if fire controls are inadequate or unsafe conditions develop.',
      emergency:
          'Raise the alarm and evacuate for uncontrolled fire. Use fire equipment only if trained and safe.',
      malayalam:
          'Dubai-യിൽ hot work ചെയ്യുമ്പോൾ combustible materials control, fire extinguisher, fire watch, cylinder safety, ventilation എന്നിവ ഉറപ്പാക്കണം. Required authorization/permit പാലിക്കണം.',
    ),

    _ReferenceTopic(
      title: 'Dubai Lifting Operations',
      category: _GuidelineCategory.dubai,
      sourceLabel: 'Dubai Municipality • Construction Safety',
      copNumber:
          'Dubai Construction Safety Guide – Lifting Operations Reference',
      version: '2026 Reference',
      effectiveDate: 'Verify latest applicable requirement',
      shortDescription:
          'Control lifting equipment, suspended loads, lifting zones and communication.',
      overview:
          'Lifting operations can cause dropped loads, struck-by incidents, equipment failure and crushing. Lifting must be planned, supervised and performed with suitable equipment and competent personnel.',
      hazards:
          'Dropped loads • Crane instability • Overloading • Crushing • Struck-by • Poor communication • Damaged lifting accessories.',
      controls:
          'Lift plan • Suitable equipment • Competent operators • Certified/inspected accessories • Exclusion zone • Communication • Ground assessment.',
      planning:
          'Determine load weight and centre of gravity. Select suitable lifting equipment and accessories. Plan lifting route, exclusion zone and communication.',
      safePractices:
          'Inspect equipment and accessories. Keep people away from suspended loads. Follow the lifting plan and manufacturer limitations.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Gloves • Eye protection.',
      checklist:
          'Lift plan • Equipment capacity • Accessories • Inspection • Ground condition • Exclusion zone • Communication • Competent personnel.',
      inspection:
          'Crane/equipment • Hooks • Slings • Shackles • Ground • Outriggers • Exclusion zone • Communication.',
      dos:
          'Use suitable inspected equipment. Maintain exclusion zones. Follow the approved lift plan.',
      donts:
          'Do not stand under suspended loads. Do not exceed rated capacity. Do not use damaged accessories.',
      stopWork:
          'Stop lifting for overload, equipment defect, unstable ground, unsafe weather or loss of communication.',
      emergency:
          'Stop the operation safely and secure the area. Activate emergency response for dropped loads or serious injury.',
      malayalam:
          'Dubai-യിൽ lifting operation-ന് lift plan, suitable equipment, competent operator, inspected lifting accessories, exclusion zone, clear communication എന്നിവ ആവശ്യമാണ്. Suspended load-ന്റെ താഴെ നിൽക്കരുത്.',
    ),

    _ReferenceTopic(
      title: 'Dubai Traffic & Public Protection',
      category: _GuidelineCategory.dubai,
      sourceLabel: 'Dubai Municipality • Construction Safety',
      copNumber:
          'Dubai Construction Safety Guide – Traffic / Public Interface Reference',
      version: '2026 Reference',
      effectiveDate: 'Verify latest applicable requirement',
      shortDescription:
          'Protect workers, pedestrians and road users around construction activities.',
      overview:
          'Construction activities can interact with public roads and pedestrian routes. Effective segregation, barriers, signs, lighting and controlled access are required according to the approved traffic and project arrangements.',
      hazards:
          'Vehicle strike • Reversing • Pedestrian interaction • Poor visibility • Unauthorized access • Falling objects • Traffic congestion.',
      controls:
          'Approved traffic arrangement • Barriers • Signs • Lighting • Pedestrian segregation • Traffic control • High visibility • Access control.',
      planning:
          'Identify vehicle and pedestrian movements. Plan barriers, signs, lighting, access points and traffic-control arrangements.',
      safePractices:
          'Maintain clear barriers and signs. Keep pedestrian routes separated. Keep work zones visible and tidy.',
      ppe:
          'High-visibility clothing • Safety footwear • Safety helmet • Eye protection • Task-specific PPE.',
      checklist:
          'Traffic arrangement • Signs • Barriers • Lighting • Pedestrian route • Vehicle route • Traffic control • Work-zone inspection.',
      inspection:
          'Signs • Barriers • Cones • Lighting • Pedestrian route • Vehicle route • Visibility • Damaged controls.',
      dos:
          'Maintain approved traffic controls. Check visibility regularly. Keep barriers stable.',
      donts:
          'Do not remove traffic controls without authorization. Do not allow pedestrians into live traffic areas.',
      stopWork:
          'Stop if traffic controls are displaced, visibility is inadequate or pedestrian segregation fails.',
      emergency:
          'Stop affected work, protect the scene and activate emergency and traffic-control procedures.',
      malayalam:
          'Dubai construction site-ൽ public traffic, pedestrians, workers എന്നിവ തമ്മിൽ proper segregation വേണം. Barriers, signs, lighting, pedestrian routes, traffic controls എന്നിവ maintain ചെയ്യണം.',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_ReferenceTopic> _filteredTopics() {
    final query = _query.trim().toLowerCase();

    return _topics.where((topic) {
      final categoryMatches =
          _selectedCategory == _GuidelineCategory.all ||
          topic.category == _selectedCategory;

      if (!categoryMatches) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      final searchable = [
        topic.title,
        topic.category.label,
        topic.sourceLabel,
        topic.copNumber,
        topic.version,
        topic.effectiveDate,
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
        topic.malayalam,
      ].join(' ').toLowerCase();

      return searchable.contains(query);
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
          const SizedBox(height: 16),
          _buildCategorySelector(),
          const SizedBox(height: 16),
          _buildSearchField(),
          const SizedBox(height: 22),
          _buildSectionHeader(
            searching ? 'SEARCH RESULTS' : 'SAFETY GUIDELINES',
            searching
                ? '${topics.length} topics found'
                : '${topics.length} detailed safety topics',
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
                  'UAE-wide practical HSE guidance with separate Abu Dhabi and Dubai safety references.',
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

  Widget _buildCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'REFERENCE SCOPE',
          style: TextStyle(
            color: Color(0xFF087A38),
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 9),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _categoryChip(
                label: 'All',
                category: _GuidelineCategory.all,
                icon: Icons.apps_rounded,
              ),
              _categoryChip(
                label: 'UAE General',
                category: _GuidelineCategory.uaeGeneral,
                icon: Icons.flag_rounded,
              ),
              _categoryChip(
                label: 'Abu Dhabi',
                category: _GuidelineCategory.abuDhabi,
                icon: Icons.location_city_rounded,
              ),
              _categoryChip(
                label: 'Dubai',
                category: _GuidelineCategory.dubai,
                icon: Icons.apartment_rounded,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _categoryChip({
    required String label,
    required _GuidelineCategory category,
    required IconData icon,
  }) {
    final selected = _selectedCategory == category;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        selected: selected,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 17,
              color: selected
                  ? Colors.white
                  : const Color(0xFF0B5D4B),
            ),
            const SizedBox(width: 6),
            Text(label),
          ],
        ),
        selectedColor: const Color(0xFF0B5D4B),
        backgroundColor: Colors.white,
        side: BorderSide(
          color: selected
              ? const Color(0xFF0B5D4B)
              : Colors.grey.shade200,
        ),
        labelStyle: TextStyle(
          color: selected
              ? Colors.white
              : const Color(0xFF333333),
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        onSelected: (_) {
          setState(() {
            _selectedCategory = category;
          });
        },
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
        hintText: 'Search safety guidelines',
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
                    const SizedBox(height: 5),
                    _sourceBadge(topic),
                    const SizedBox(height: 5),
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

  Widget _sourceBadge(_ReferenceTopic topic) {
    String label;

    switch (topic.category) {
      case _GuidelineCategory.uaeGeneral:
        label = 'UAE • GENERAL';
        break;
      case _GuidelineCategory.abuDhabi:
        label = 'ABU DHABI • ADPHC';
        break;
      case _GuidelineCategory.dubai:
        label = 'DUBAI • MUNICIPALITY';
        break;
      case _GuidelineCategory.all:
        label = 'UAE HSE';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF5F0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF0B5D4B),
          fontSize: 9.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
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
            'No safety guideline found',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Try another keyword or select a different reference scope.',
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
// DETAIL PAGE
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
            _buildHeroCard(),
            const SizedBox(height: 16),
            _officialReferenceCard(),
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
            _malayalamCard(),
            _referenceNote(),
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

  Widget _buildHeroCard() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      topic.sourceLabel,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
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
    );
  }

  Widget _officialReferenceCard() {
    final bool isAbuDhabi =
        topic.category == _GuidelineCategory.abuDhabi;
    final bool isDubai =
        topic.category == _GuidelineCategory.dubai;

    final String authority;
    final String sourceText;

    if (isAbuDhabi) {
      authority = 'ADPHC – ADOSH-SF Codes of Practice';
      sourceText = topic.copNumber;
    } else if (isDubai) {
      authority = 'Dubai Municipality – Construction Safety';
      sourceText = topic.copNumber;
    } else {
      authority = 'UAE General HSE Reference';
      sourceText = topic.copNumber;
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF8F4),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFCBE3D8),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.verified_rounded,
            color: Color(0xFF0B5D4B),
            size: 27,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reference Source',
                  style: TextStyle(
                    color: Color(0xFF0B5D4B),
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  authority,
                  style: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  sourceText,
                  style: const TextStyle(
                    color: Color(0xFF555555),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Version: ${topic.version}',
                  style: const TextStyle(
                    color: Color(0xFF555555),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Effective / Reference Date: ${topic.effectiveDate}',
                  style: const TextStyle(
                    color: Color(0xFF555555),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  isAbuDhabi
                      ? 'Official source: ADPHC'
                      : isDubai
                          ? 'Official source: Dubai Municipality'
                          : 'Reference: UAE HSE',
                  style: const TextStyle(
                    color: Color(0xFF0B5D4B),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _malayalamCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF2),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFE9DDBD),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.translate_rounded,
            color: Color(0xFF8A6500),
            size: 25,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Malayalam – പ്രധാന സുരക്ഷാ നിർദ്ദേശങ്ങൾ',
                  style: TextStyle(
                    color: Color(0xFF765800),
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  topic.malayalam,
                  style: const TextStyle(
                    color: Color(0xFF665A42),
                    fontSize: 12.5,
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
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
              padding:
                  const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.pan_tool_alt_rounded,
            color: Color(0xFFD32F2F),
            size: 25,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
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

  Widget _referenceNote() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F7F5),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFD7E8E1),
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: Color(0xFF0B5D4B),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Important HSE Reference Note',
                  style: TextStyle(
                    color: Color(0xFF0B5D4B),
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'This Safety Guideline is provided for HSE learning and practical workplace reference. Always verify the latest official requirement, applicable legislation, authority requirements, project procedures, risk assessment, method statement and permit requirements before making a compliance decision.',
                  style: TextStyle(
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
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
              crossAxisAlignment:
                  CrossAxisAlignment.start,
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
    final items =
        bulletStyle ? _splitBullets(content) : <String>[];

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
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF159447),
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
                const SizedBox(height: 8),
                if (bulletStyle)
                  ...items.map(
                    (item) => Padding(
                      padding:
                          const EdgeInsets.only(bottom: 7),
                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 5),
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
// CATEGORY ENUM
// ============================================================

enum _GuidelineCategory {
  all,
  uaeGeneral,
  abuDhabi,
  dubai,
}

extension _GuidelineCategoryExtension on _GuidelineCategory {
  String get label {
    switch (this) {
      case _GuidelineCategory.all:
        return 'All';
      case _GuidelineCategory.uaeGeneral:
        return 'UAE General';
      case _GuidelineCategory.abuDhabi:
        return 'Abu Dhabi';
      case _GuidelineCategory.dubai:
        return 'Dubai';
    }
  }
}

// ============================================================
// DATA MODEL
// ============================================================

class _ReferenceTopic {
  final String title;
  final _GuidelineCategory category;
  final String sourceLabel;
  final String copNumber;
  final String version;
  final String effectiveDate;
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
  final String malayalam;

  const _ReferenceTopic({
    required this.title,
    required this.category,
    required this.sourceLabel,
    required this.copNumber,
    required this.version,
    required this.effectiveDate,
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
    required this.malayalam,
  });
}
