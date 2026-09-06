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
    // ADPHC / ABU DHABI SAFETY GUIDELINES
    // ==========================================================

    _ReferenceTopic(
      title: 'Excavation',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 29.0',
      copNumber: 'CoP 29.0 – Excavation Work',
      version: 'V4.1',
      effectiveDate: '27 February 2026',
      shortDescription:
          'Detailed safety guidance for excavation planning, ground stability, underground services, access and protection.',
      overview:
          'Excavation work involves removing soil or other material from the ground and can expose workers to collapse, falling materials, underground services, mobile plant, water ingress and falls. Excavation must be properly planned, assessed and controlled before workers enter.',
      hazards:
          'Ground collapse • Cave-in • Underground electrical, gas or water services • Falls into excavation • Falling materials • Mobile plant interaction • Water accumulation • Ground movement • Unsafe access and egress.',
      controls:
          'Conduct a suitable risk assessment • Identify underground services before excavation • Use an appropriate protective system where required • Provide safe access and egress • Protect excavation edges • Control spoil and plant locations • Prevent unauthorized access • Inspect changing conditions.',
      planning:
          'Review drawings, service information and site conditions before breaking ground. Assess soil and surrounding structures. Determine the required protective system and plan access, spoil placement, plant movement, water control and emergency arrangements.',
      safePractices:
          'Inspect the excavation before entry and after significant changes. Maintain safe access and egress. Keep people and mobile plant away from unsafe edges. Maintain barricading and prevent unauthorized entry. Stop work when ground conditions become unsafe.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Suitable gloves • Eye protection • Task-specific PPE where required.',
      checklist:
          'Risk assessment completed • Underground services identified • Excavation method approved • Ground conditions assessed • Protective system provided where required • Safe access/egress • Edge protection • Spoil controlled • Plant controlled • Inspection completed.',
      inspection:
          'Excavation walls and ground condition • Protective system • Edge protection • Access and egress • Spoil position • Plant position • Water accumulation • Cracking or ground movement • Barricading.',
      dos:
          'Inspect before entry. Follow the approved excavation method. Maintain safe access. Keep the excavation protected. Report ground movement immediately.',
      donts:
          'Do not enter an unsafe excavation. Do not ignore underground service information. Do not place plant or materials where they create an unsafe edge condition. Do not remove protective systems without authorization.',
      stopWork:
          'Stop work immediately if collapse, cracking, unexpected ground movement, unknown underground services, water ingress, damaged protection or unsafe access is identified.',
      emergency:
          'Raise the alarm and isolate the danger area. Keep people away from a collapse zone. Do not enter a collapsed excavation for rescue unless an approved emergency rescue arrangement and competent rescue personnel are available.',
      malayalam:
          'Excavation തുടങ്ങുന്നതിന് മുമ്പ് underground services കണ്ടെത്തുകയും ground stability പരിശോധിക്കുകയും വേണം. ആവശ്യമായിടത്ത് suitable shoring, shielding അല്ലെങ്കിൽ battering നൽകണം. Safe access/egress, edge protection, barricading എന്നിവ ഉറപ്പാക്കണം. Ground condition മാറുകയോ cracking, water ingress അല്ലെങ്കിൽ movement കാണുകയോ ചെയ്താൽ work നിർത്തി വീണ്ടും assessment നടത്തണം.',
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
          'Scaffolding provides temporary access and working platforms. It must be appropriately selected, erected, inspected, maintained and used by competent personnel. Stability, foundation, access and edge protection are critical.',
      hazards:
          'Falls from height • Scaffold collapse • Falling objects • Overloading • Unsafe access • Missing guardrails or toe boards • Unstable foundation • Unauthorized alteration.',
      controls:
          'Competent erection • Stable foundation • Proper bracing • Guardrails • Toe boards • Safe access • Load control • Inspection • Scaffold status control • Prevention of unauthorized modification.',
      planning:
          'Select a scaffold suitable for the intended height, configuration, access and loading. Confirm the foundation and supporting conditions. Plan erection, inspection, access, material loading and dismantling.',
      safePractices:
          'Use only inspected and approved scaffolding. Keep access clear. Maintain platforms within their intended loading capacity. Keep guardrails and toe boards in place. Do not alter scaffolding without authorization.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • High-visibility clothing • Fall protection where required.',
      checklist:
          'Stable foundation • Uprights secure • Bracing provided • Guardrails • Toe boards • Platform condition • Safe access • Loading controlled • Inspection status • Unauthorized alteration controlled.',
      inspection:
          'Foundation • Uprights • Bracing • Connections • Platforms • Guardrails • Toe boards • Access • Scaffold status/tag • Damage • Unauthorized modification.',
      dos:
          'Use inspected scaffolding. Keep platforms tidy. Respect loading limits. Report defects immediately.',
      donts:
          'Do not use incomplete or damaged scaffolding. Do not remove guardrails, toe boards or braces without authorization. Do not overload platforms.',
      stopWork:
          'Stop scaffold use if it is incomplete, unstable, damaged, overloaded, missing required protection or altered without authorization.',
      emergency:
          'Prevent access to an unsafe scaffold. Isolate the affected area and activate the site emergency procedure if an incident occurs.',
      malayalam:
          'Scaffolding competent personnel ഉപയോഗിച്ച് erect ചെയ്യുകയും inspect ചെയ്യുകയും വേണം. Foundation, bracing, guardrails, toe boards, platforms, safe access എന്നിവ ശരിയായിരിക്കണം. Scaffold overload ചെയ്യരുത്. Unauthorized modification ഒരിക്കലും അനുവദിക്കരുത്.',
    ),

    _ReferenceTopic(
      title: 'Working at Height',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 23.0',
      copNumber: 'CoP 23.0 – Working at Heights',
      version: 'V4.1',
      effectiveDate: '27 February 2026',
      shortDescription:
          'Prevent falls through safe access, edge protection, suitable platforms, fall protection and rescue planning.',
      overview:
          'Work at height can expose workers to falls from one level to another and falling objects. Work must be planned and controlled using suitable working platforms, access systems, edge protection and fall-protection arrangements.',
      hazards:
          'Falls from height • Falling objects • Open edges • Floor openings • Unsafe ladders • Unstable platforms • Incorrect harness use • Inadequate rescue arrangements.',
      controls:
          'Avoid unnecessary work at height • Use suitable platforms • Provide guardrails and edge protection • Protect openings • Provide safe access • Use fall protection where required • Inspect equipment • Plan rescue.',
      planning:
          'Consider whether the task can be completed from ground level. Select appropriate access equipment. Assess edges, openings, weather, falling objects and rescue requirements before starting.',
      safePractices:
          'Use approved access equipment. Protect edges and openings. Inspect harnesses and lanyards before use. Use suitable anchor points. Keep tools and materials secure.',
      ppe:
          'Safety helmet • Safety footwear • Full-body harness where required • Gloves • Eye protection • Task-specific PPE.',
      checklist:
          'Risk assessment • Safe access • Suitable platform • Edge protection • Openings protected • Harness inspected • Suitable anchorage • Falling-object control • Rescue plan • Competent workers.',
      inspection:
          'Working platform • Guardrails • Edge protection • Floor openings • Access equipment • Harness • Lanyard • Anchorage • Tool securing • Rescue arrangements.',
      dos:
          'Plan the task. Use approved access equipment. Maintain fall protection. Secure tools and materials. Follow the rescue plan.',
      donts:
          'Do not work from unstable surfaces. Do not use damaged fall-protection equipment. Do not attach to unsuitable anchor points. Do not remove edge protection without authorization.',
      stopWork:
          'Stop work when safe access, edge protection, fall protection or suitable anchorage is unavailable or when weather/site conditions become unsafe.',
      emergency:
          'Activate the approved rescue plan and emergency response. Avoid creating a second casualty during rescue. Provide first aid and medical assistance.',
      malayalam:
          'Height work തുടങ്ങുന്നതിന് മുമ്പ് ground-level alternative സാധ്യമാണോ എന്ന് പരിശോധിക്കുക. Safe platform, guardrail, edge protection, protected openings, suitable fall protection എന്നിവ ഉറപ്പാക്കണം. Harness ശരിയായ anchorage-ൽ മാത്രം ഉപയോഗിക്കുക. Rescue plan ഉണ്ടായിരിക്കണം.',
    ),

    _ReferenceTopic(
      title: 'Portable Power Tools',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 35.0',
      copNumber: 'CoP 35.0 – Portable Power Tools',
      version: 'V4.1',
      effectiveDate: '27 February 2026',
      shortDescription:
          'Safe selection, inspection, guarding and use of portable power tools.',
      overview:
          'Portable power tools can cause cuts, electric shock, flying particles, burns, noise, vibration and entanglement. Safe use depends on correct tool selection, condition, guarding, accessories and operator competence.',
      hazards:
          'Cuts • Flying particles • Electric shock • Burns • Entanglement • Noise • Vibration • Incorrect accessories • Damaged cables.',
      controls:
          'Correct tool selection • Pre-use inspection • Guards • Electrical protection • Correct accessories • Maintenance • Competent operators • Good housekeeping.',
      planning:
          'Select the correct tool for the task. Review manufacturer instructions. Assess electrical protection, dust, noise, vibration, sparks and nearby workers before use.',
      safePractices:
          'Inspect the tool before use. Use the correct accessory and guard. Keep cables protected. Disconnect the power before changing accessories. Maintain stable footing and good control.',
      ppe:
          'Safety glasses or face protection • Safety footwear • Hearing protection • Suitable gloves • Safety helmet • Task-specific PPE.',
      checklist:
          'Tool condition • Guard • Cable and plug • Correct accessory • Electrical protection • Operator competence • PPE • Work area • Maintenance status.',
      inspection:
          'Casing • Guards • Switches • Cable • Plug • Accessories • Labels • Electrical protection • Overheating • Abnormal vibration or noise.',
      dos:
          'Use tools according to manufacturer instructions. Keep guards fitted. Remove defective tools from service and report them.',
      donts:
          'Do not use damaged tools. Do not remove guards. Do not carry tools by electrical cables. Do not use unsuitable accessories.',
      stopWork:
          'Stop using the tool if the guard, cable, plug, switch or accessory is damaged or if abnormal vibration, noise, overheating or sparking occurs.',
      emergency:
          'Isolate the energy source where safe. Provide first aid and obtain medical assistance for serious injury. Report defective equipment.',
      malayalam:
          'Power tool ഉപയോഗിക്കുന്നതിന് മുമ്പ് tool, guard, cable, plug, accessory എന്നിവ inspect ചെയ്യണം. Correct accessory മാത്രം ഉപയോഗിക്കുക. Guard remove ചെയ്യരുത്. Damage, abnormal vibration, overheating അല്ലെങ്കിൽ sparking ഉണ്ടായാൽ ഉടൻ tool ഉപയോഗിക്കുന്നത് നിർത്തണം.',
    ),

    _ReferenceTopic(
      title: 'Formwork / False Work',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 40.0',
      copNumber: 'CoP 40.0 – False Work (Formwork)',
      version: 'V4.1',
      effectiveDate: '27 February 2026',
      shortDescription:
          'Control formwork stability, support, loading, erection, inspection and striking.',
      overview:
          'Formwork and false work support concrete and construction loads during temporary stages. Failure can result in collapse, falling materials, crushing and serious injury. Design, installation, inspection and controlled removal are essential.',
      hazards:
          'Collapse • Overloading • Instability • Falling materials • Falls from height • Crushing • Incorrect erection • Premature striking.',
      controls:
          'Approved design • Competent installation • Stable supports • Bracing • Correct connections • Load control • Inspection • Controlled concrete placement • Authorized striking/removal.',
      planning:
          'Review the approved design and loading requirements. Confirm support conditions, erection sequence, concrete placement sequence, access, inspection and striking arrangements.',
      safePractices:
          'Follow approved drawings and method statements. Inspect before loading. Control concrete placement sequence. Prevent unauthorized modification. Remove supports only when authorized.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Eye protection • Fall protection where required.',
      checklist:
          'Approved design • Foundation/support • Bracing • Connections • Alignment • Load limits • Inspection • Concrete sequence • Striking authorization.',
      inspection:
          'Supports • Bracing • Connections • Alignment • Base condition • Decking • Load condition • Signs of movement • Damage • Unauthorized changes.',
      dos:
          'Follow approved design. Inspect before loading. Report movement or damage. Maintain controlled access.',
      donts:
          'Do not modify without authorization. Do not overload. Do not remove supports prematurely.',
      stopWork:
          'Stop work if movement, instability, damage, overload or unauthorized modification is identified.',
      emergency:
          'Evacuate the affected area if collapse or instability is suspected. Prevent access until competent technical personnel confirm safety.',
      malayalam:
          'Formwork/false work concrete load support ചെയ്യുന്നതിനാൽ design, support, bracing, connections എന്നിവ വളരെ പ്രധാനമാണ്. Approved drawing/method statement അനുസരിച്ച് മാത്രമേ erection ചെയ്യാവൂ. Unauthorized modification അല്ലെങ്കിൽ premature striking അനുവദിക്കരുത്.',
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
          'A Permit to Work system is a formal method for controlling specific high-risk activities. It confirms that hazards have been assessed, controls are established and responsible persons understand the conditions under which work may proceed.',
      hazards:
          'Uncontrolled high-risk work • Conflicting activities • Energy release • Fire • Electrical hazards • Confined space hazards • Excavation hazards • Poor communication.',
      controls:
          'Correct permit type • Risk assessment • Isolation • Defined work area • Authorization • Gas testing where applicable • Toolbox briefing • Permit display • Close-out.',
      planning:
          'Identify whether the activity requires a permit. Confirm the scope, hazards, isolations, precautions, responsible persons and validity period before work begins.',
      safePractices:
          'Workers must understand the permit conditions. Do not start work before authorization. Maintain controls throughout the permit validity. Suspend and revalidate when conditions change as required by the system.',
      ppe:
          'PPE must be selected according to the specific work and permit risk assessment.',
      checklist:
          'Correct permit • Risk assessment • Isolation • Controls • Authorization • Workers briefed • Permit displayed/available • Validity checked • Close-out.',
      inspection:
          'Check permit conditions • Isolation • Work area • Required controls • Gas testing where applicable • Worker understanding • Permit status.',
      dos:
          'Read and understand the permit. Follow every condition. Stop and seek reauthorization when conditions change.',
      donts:
          'Do not work without required authorization. Do not bypass isolations. Do not continue after permit expiry or suspension.',
      stopWork:
          'Stop work if permit conditions are not satisfied, controls fail, the permit expires, the scope changes or an unexpected hazard appears.',
      emergency:
          'Stop work, raise the alarm, isolate energy where safe and follow the emergency procedure. Permit controls do not replace emergency response.',
      malayalam:
          'High-risk work തുടങ്ങുന്നതിന് മുമ്പ് applicable Permit to Work ആവശ്യമാണ് എന്ന് പരിശോധിക്കണം. Permit conditions, isolation, risk controls, responsible persons എന്നിവ എല്ലാവർക്കും clear ആയിരിക്കണം. Conditions മാറിയാൽ work stop ചെയ്ത് permit system അനുസരിച്ച് revalidation വേണം.',
    ),

    _ReferenceTopic(
      title: 'Working in Hot & Humid Climate',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 11.0',
      copNumber: 'CoP 11.0 – Safety in the Heat',
      version: 'V4.0',
      effectiveDate: '15 July 2024',
      shortDescription:
          'Prevent heat stress through planning, hydration, rest, acclimatization and monitoring.',
      overview:
          'Working in hot and humid conditions can cause dehydration, heat exhaustion and heat-related illness. Employers and supervisors should plan work according to environmental conditions and provide suitable heat controls.',
      hazards:
          'Dehydration • Heat exhaustion • Heat stroke • Fatigue • Reduced concentration • Increased accident risk.',
      controls:
          'Hydration • Suitable rest arrangements • Shade/cooling • Acclimatization • Work-rest planning • Heat monitoring • Worker awareness • Emergency response.',
      planning:
          'Assess environmental conditions and task demands. Plan hydration, shaded or cooled rest areas, work-rest arrangements, acclimatization and emergency response before work begins.',
      safePractices:
          'Drink water regularly. Take planned rest periods. Use shaded or cooled rest areas. Watch for symptoms in yourself and colleagues. Follow site heat-stress procedures.',
      ppe:
          'Suitable work clothing • Safety helmet with approved accessories where applicable • Safety footwear • Task-specific PPE. PPE must not be relied upon as the only heat control.',
      checklist:
          'Heat risk assessed • Drinking water • Rest/shade • Worker briefing • Acclimatization • Work-rest arrangement • Heat monitoring • Emergency arrangements.',
      inspection:
          'Water supply • Rest area • Shade/cooling • Worker condition • Heat controls • Communication • Emergency access.',
      dos:
          'Hydrate regularly. Rest as planned. Report symptoms early. Look after coworkers. Follow the site heat-management procedure.',
      donts:
          'Do not ignore dizziness, confusion, severe weakness or other heat-illness symptoms. Do not continue unsafe work simply to meet production targets.',
      stopWork:
          'Stop affected work when heat controls are inadequate, workers show symptoms of heat illness or environmental conditions make the planned task unsafe.',
      emergency:
          'Move the affected worker to a cool area, provide appropriate first aid and activate the site medical/emergency procedure. Suspected severe heat illness requires urgent medical attention.',
      malayalam:
          'Hot and humid climate-ൽ dehydration, heat exhaustion, heat stroke എന്നിവയുടെ risk കൂടുതലാണ്. Regular hydration, suitable rest, shade/cooling, acclimatization, heat monitoring എന്നിവ ഉറപ്പാക്കണം. Worker-ന് dizziness, confusion, severe weakness തുടങ്ങിയ symptoms ഉണ്ടെങ്കിൽ work തുടരരുത്.',
    ),

    _ReferenceTopic(
      title: 'Confined Space',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 27.0',
      copNumber: 'CoP 27.0 – Confined Spaces',
      version: 'V4.0',
      effectiveDate: '15 July 2024',
      shortDescription:
          'Control atmospheric, access, engulfment, energy and rescue hazards in confined spaces.',
      overview:
          'Confined spaces may contain hazardous atmospheres, restricted access, engulfment risks or other conditions that can seriously endanger workers. Entry must be properly assessed, controlled and monitored.',
      hazards:
          'Oxygen deficiency • Toxic gases • Flammable atmosphere • Engulfment • Restricted access • Heat • Mechanical/electrical energy • Difficult rescue.',
      controls:
          'Confined-space assessment • Entry authorization • Isolation • Atmospheric testing • Ventilation • Communication • Standby arrangements • Rescue plan • Competent personnel.',
      planning:
          'Determine whether the space meets the project definition of a confined space. Assess atmospheric, physical and energy hazards. Plan isolation, testing, ventilation, communication, entry control and rescue.',
      safePractices:
          'Do not enter without required authorization. Test the atmosphere as required. Maintain communication and entry control. Keep rescue equipment ready. Follow the approved entry procedure.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Eye protection • Respiratory protection where required • Harness/retrieval equipment where required.',
      checklist:
          'Entry assessment • Permit/authorization • Isolation • Gas testing • Ventilation • Communication • Standby person • Rescue plan • PPE • Competent entrants.',
      inspection:
          'Atmospheric test • Ventilation • Isolation • Access • Communication • Rescue equipment • Entry register • PPE.',
      dos:
          'Test before entry. Maintain communication. Follow the entry permit/procedure. Keep rescue arrangements ready.',
      donts:
          'Do not enter an unknown atmosphere. Do not enter without required authorization. Do not attempt an unplanned rescue by entering the space.',
      stopWork:
          'Stop entry if atmospheric conditions are unsafe, ventilation fails, communication is lost, isolation is compromised or rescue arrangements are unavailable.',
      emergency:
          'Raise the alarm and activate the confined-space rescue plan. Do not enter to rescue without suitable equipment, training and competent rescue support.',
      malayalam:
          'Confined space-ൽ oxygen deficiency, toxic gas, flammable atmosphere, engulfment തുടങ്ങിയ അപകടങ്ങൾ ഉണ്ടാകാം. Entry authorization, isolation, atmospheric testing, ventilation, communication, standby person, rescue plan എന്നിവ ഉറപ്പാക്കാതെ entry ചെയ്യരുത്. Emergency rescue-ക്കായി unplanned entry നടത്തരുത്.',
    ),

    _ReferenceTopic(
      title: 'Working Near Live Road',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 33.0',
      copNumber: 'CoP 33.0 – Working On or Adjacent to a Road',
      version: 'V4.1',
      effectiveDate: '27 February 2026',
      shortDescription:
          'Protect workers and road users through traffic management, segregation, barriers and visibility.',
      overview:
          'Work on or adjacent to a road creates interaction between workers, vehicles and public traffic. Traffic management, physical separation, signs, lighting and controlled access are essential.',
      hazards:
          'Vehicle strike • Reversing • Poor visibility • Unauthorized access • Night work • Traffic congestion • Falling objects into roadways.',
      controls:
          'Approved traffic management arrangement • Barriers • Signs • Cones • Pedestrian segregation • Traffic controllers • High visibility • Lighting • Speed control.',
      planning:
          'Review the approved traffic arrangement. Identify pedestrian and vehicle movements. Plan barriers, signs, lighting, access points and traffic-controller positions before work starts.',
      safePractices:
          'Separate pedestrians from traffic wherever practicable. Maintain clear signs and barriers. Keep work zones tidy and visible. Follow the approved traffic arrangement.',
      ppe:
          'High-visibility clothing • Safety footwear • Safety helmet • Eye protection • Task-specific PPE.',
      checklist:
          'Traffic plan • Signs • Barriers • Lighting • Pedestrian route • Vehicle route • Traffic controller • High-visibility PPE • Work-zone inspection.',
      inspection:
          'Signs • Barriers • Cones • Lighting • Pedestrian segregation • Vehicle routes • Visibility • Damaged controls.',
      dos:
          'Maintain the approved traffic arrangement. Check visibility regularly. Keep barriers stable and correctly positioned.',
      donts:
          'Do not remove traffic controls without authorization. Do not allow pedestrians into live traffic areas. Do not obstruct road visibility.',
      stopWork:
          'Stop work if traffic controls are displaced, visibility is inadequate, unauthorized vehicles enter the work zone or pedestrian segregation fails.',
      emergency:
          'Stop affected activities, protect the scene, contact emergency services where required and control traffic according to the emergency plan.',
      malayalam:
          'Live road-ന്റെ സമീപം work ചെയ്യുമ്പോൾ workers-നും public traffic-നും തമ്മിൽ effective segregation വേണം. Barriers, signs, cones, lighting, high-visibility clothing, traffic controllers എന്നിവ approved traffic arrangement അനുസരിച്ച് maintain ചെയ്യണം.',
    ),

    _ReferenceTopic(
      title: 'Concreting',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 38.0',
      copNumber: 'CoP 38.0 – Concrete Placing Equipment',
      version: 'V4.1',
      effectiveDate: '27 February 2026',
      shortDescription:
          'Control concrete placing equipment, hoses, pressure, movement and placing operations.',
      overview:
          'Concrete placing equipment can create hose-whip, pressure-release, crushing, struck-by and vehicle movement hazards. Equipment, hoses, connections, work areas and communication must be controlled.',
      hazards:
          'Hose whip • Pressure release • Crushing • Struck-by incidents • Equipment failure • Vehicle movement • Concrete contact • Falls around formwork.',
      controls:
          'Equipment inspection • Hose inspection • Secure connections • Exclusion zones • Competent operators • Communication • Safe equipment positioning • PPE.',
      planning:
          'Plan pump location, hose route, exclusion zone, communication and concrete placing sequence. Confirm that formwork and access arrangements are ready.',
      safePractices:
          'Inspect pump, hoses and connections before use. Keep workers clear of hose danger zones. Maintain communication between operator and placing team. Follow the approved placing sequence.',
      ppe:
          'Safety helmet • Safety footwear • Suitable gloves • Eye protection • Protective clothing • Task-specific PPE.',
      checklist:
          'Equipment inspected • Hoses checked • Connections secure • Exclusion zone • Communication • Operator competence • Access • Formwork readiness • PPE.',
      inspection:
          'Pump • Hoses • Couplings • Clamps • Connections • Exclusion zone • Communication • Access • Damage.',
      dos:
          'Follow the placing sequence. Maintain communication. Keep personnel away from uncontrolled hose movement.',
      donts:
          'Do not stand in front of an uncontrolled hose. Do not use damaged hoses or connections. Do not enter exclusion zones during unsafe conditions.',
      stopWork:
          'Stop placing if equipment or hoses are damaged, connections are unsafe, communication is lost or uncontrolled movement occurs.',
      emergency:
          'Stop equipment safely, isolate the affected area and activate emergency response for serious injury or equipment failure.',
      malayalam:
          'Concrete placing സമയത്ത് pump, hoses, couplings, clamps എന്നിവ inspect ചെയ്യണം. Hose whip, pressure release, crushing എന്നിവ പ്രധാന hazards ആണ്. Hose danger zone-ൽ workers നിൽക്കരുത്. Operator-നും placing team-നും clear communication വേണം.',
    ),

    _ReferenceTopic(
      title: 'Barricading of Hazards',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 22.0',
      copNumber: 'CoP 22.0 – Barricading of Hazards',
      version: 'V4.0',
      effectiveDate: '15 July 2024',
      shortDescription:
          'Use suitable barricading and warning controls to protect people from workplace hazards.',
      overview:
          'Barricading is used to prevent people from entering hazardous areas and to clearly identify hazards. The type and arrangement of barricading should match the risk and site conditions.',
      hazards:
          'Falls • Open excavations • Moving plant • Electrical hazards • Falling objects • Restricted areas • Construction hazards.',
      controls:
          'Identify hazard • Select suitable barricade • Warning signs • Maintain clear boundaries • Access control • Regular inspection • Remove barricade only when hazard is eliminated.',
      planning:
          'Identify the hazard and required exclusion area before starting work. Select suitable physical barriers and signs. Define access points and responsible persons.',
      safePractices:
          'Install barricades before exposure begins. Keep them visible and stable. Maintain adequate distance from the hazard. Inspect after movement, weather or site changes.',
      ppe:
          'PPE depends on the underlying hazard. Barricading does not replace required PPE or engineering controls.',
      checklist:
          'Hazard identified • Suitable barricade • Warning signs • Exclusion area • Access controlled • Visibility • Stability • Inspection.',
      inspection:
          'Barrier condition • Position • Visibility • Signs • Access points • Distance from hazard • Damage • Unauthorized removal.',
      dos:
          'Use suitable physical protection for serious hazards. Keep signs visible. Report damaged or missing barricades.',
      donts:
          'Do not cross barricades without authorization. Do not use inadequate or damaged barriers for serious hazards. Do not remove barriers without authorization.',
      stopWork:
          'Stop affected work if required barricading is missing, damaged, displaced or unable to prevent exposure to the hazard.',
      emergency:
          'Keep people away from the hazardous area and activate the relevant emergency procedure.',
      malayalam:
          'Hazardous area-കളിൽ unauthorized entry തടയാൻ suitable barricading വേണം. Barrier visible, stable, properly positioned ആയിരിക്കണം. Hazard remove ചെയ്യുന്നതുവരെ barricade remove ചെയ്യരുത്.',
    ),

    _ReferenceTopic(
      title: 'Worker Welfare',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 8.0 / 9.0',
      copNumber:
          'CoP 8.0 – General Workplace Amenities / CoP 9.0 – Workplace Wellness',
      version: 'V4.0',
      effectiveDate: '15 July 2024',
      shortDescription:
          'Support worker health, hygiene, rest and wellbeing through suitable workplace welfare arrangements.',
      overview:
          'Worker welfare includes suitable drinking water, sanitation, washing facilities, rest arrangements, hygiene, cleaning and wellbeing controls. Welfare arrangements should be appropriate for workforce size, work location and environmental conditions.',
      hazards:
          'Dehydration • Poor hygiene • Heat stress • Fatigue • Unsanitary conditions • Poor rest arrangements.',
      controls:
          'Safe drinking water • Sanitation • Washing facilities • Rest areas • Cleaning • Waste management • Environmental protection • Welfare inspections.',
      planning:
          'Assess workforce size, work location, environmental conditions and work duration. Plan adequate access to water, sanitation, washing and rest facilities.',
      safePractices:
          'Keep welfare facilities clean and accessible. Maintain water supplies. Report deficiencies. Ensure workers can access welfare facilities without unnecessary barriers.',
      ppe:
          'PPE is task-specific and does not replace welfare controls.',
      checklist:
          'Drinking water • Toilets • Washing facilities • Rest area • Cleaning • Waste disposal • Heat protection • Accessibility • Welfare inspection.',
      inspection:
          'Water supply • Toilets • Washing facilities • Rest areas • Cleanliness • Waste disposal • Cooling/shade • Accessibility.',
      dos:
          'Maintain clean facilities. Ensure workers can access water and rest. Report welfare deficiencies promptly.',
      donts:
          'Do not block access to welfare facilities. Do not allow unsanitary conditions to continue uncorrected.',
      stopWork:
          'Escalate or stop affected work when essential welfare arrangements are unavailable and worker health or safety could be adversely affected.',
      emergency:
          'For heat illness or other welfare-related emergencies, activate the site medical or emergency procedure immediately.',
      malayalam:
          'Worker welfare-ൽ drinking water, toilets, washing facilities, rest areas, hygiene, cleaning എന്നിവ പ്രധാനമാണ്. Facilities clean, accessible, adequately supplied ആയിരിക്കണം. Welfare deficiency worker health-നെ ബാധിക്കുന്നുണ്ടെങ്കിൽ ഉടൻ corrective action വേണം.',
    ),

    _ReferenceTopic(
      title: 'Mobile Elevated Working Platform (MEWP)',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 36.0 + CoP 23.0',
      copNumber:
          'CoP 36.0 – Plant and Equipment / CoP 23.0 – Working at Heights',
      version: 'V4.1',
      effectiveDate: '27 February 2026',
      shortDescription:
          'Safe selection, inspection, operation and fall protection for MEWP activities.',
      overview:
          'MEWPs are mobile plant used to provide elevated work platforms. Their safe use depends on suitable equipment, competent operators, ground assessment, pre-use inspection, safe positioning, fall protection and emergency lowering arrangements.',
      hazards:
          'Falls from platform • Tip-over • Crushing • Entrapment • Collision • Overturning • Overhead hazards • Ground instability • Falling objects.',
      controls:
          'Suitable MEWP selection • Competent operator • Pre-use inspection • Stable ground • Safe positioning • Guardrails • Fall protection where required • Exclusion zone • Emergency lowering plan.',
      planning:
          'Select the correct MEWP for height, reach, load and environment. Assess ground conditions, overhead hazards, traffic, wind, electrical hazards and rescue arrangements.',
      safePractices:
          'Complete pre-use checks. Keep within rated capacity. Maintain guardrails. Use the manufacturer-approved access arrangement. Keep the platform clear and maintain safe separation from hazards.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Harness/lanyard where required by equipment and risk assessment • Eye protection.',
      checklist:
          'Operator competent • Pre-use inspection • Ground stable • Capacity verified • Guardrails • Fall protection • Overhead hazards • Exclusion zone • Emergency lowering.',
      inspection:
          'Tyres/wheels • Controls • Guardrails • Platform • Emergency stop • Emergency lowering • Alarms • Hydraulic/electrical systems • Ground condition.',
      dos:
          'Follow manufacturer instructions. Conduct pre-use checks. Maintain rated capacity. Keep gates/guardrails secured. Use approved fall protection.',
      donts:
          'Do not exceed capacity. Do not use on unsuitable ground. Do not climb guardrails. Do not use a defective MEWP.',
      stopWork:
          'Stop operation for equipment defects, unstable ground, excessive wind, loss of control, overload, unsafe overhead conditions or failed emergency systems.',
      emergency:
          'Use the emergency lowering/rescue procedure. Call emergency support when required. Do not create additional exposure during rescue.',
      malayalam:
          'MEWP ഉപയോഗിക്കുമ്പോൾ competent operator, pre-use inspection, stable ground, capacity verification, guardrails, fall protection, exclusion zone എന്നിവ ഉറപ്പാക്കണം. Guardrail കയറി work ചെയ്യരുത്. Defective MEWP ഉപയോഗിക്കരുത്.',
    ),

    _ReferenceTopic(
      title: 'Electricity on Site & Electrical Tools',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 15.0',
      copNumber: 'CoP 15.0 – Electrical Safety',
      version: 'V4.0',
      effectiveDate: '15 July 2024',
      shortDescription:
          'Control electrical shock, arc, fire and equipment hazards on construction sites.',
      overview:
          'Electrical systems and electrical tools can cause shock, burns, arc flash, fire and equipment damage. Electrical work must be properly planned, installed, protected, inspected and maintained.',
      hazards:
          'Electric shock • Electrocution • Arc flash • Burns • Electrical fire • Damaged cables • Improper earthing • Wet conditions.',
      controls:
          'Competent electrical personnel • Isolation • Suitable protection • Inspection • Earthing • RCD/GFCI where applicable • Cable protection • Lockout/tagout where required • Safe temporary power arrangements.',
      planning:
          'Identify electrical sources and circuits. Assess wet areas, temporary power, tools, cables and overhead/underground services. Plan isolation and inspection arrangements.',
      safePractices:
          'Inspect cables, plugs and tools before use. Protect cables from mechanical damage and water. Use appropriate electrical protection. Isolate before maintenance.',
      ppe:
          'Safety footwear • Safety helmet • Eye protection • Suitable electrical PPE for the specific task • Arc-rated PPE where required by assessment.',
      checklist:
          'Competent personnel • Isolation • Protection • Earthing • RCD/GFCI where required • Cable condition • Plug condition • Tool inspection • Temporary power control.',
      inspection:
          'Distribution boards • Cables • Plugs • Sockets • Earthing • Protection devices • Temporary connections • Electrical tools • Damage or overheating.',
      dos:
          'Use competent electrical personnel. Inspect equipment. Isolate before maintenance. Keep electrical equipment protected from water.',
      donts:
          'Do not use damaged cables or plugs. Do not bypass protection devices. Do not perform electrical work without authorization and competence.',
      stopWork:
          'Stop work for exposed conductors, damaged cables, failed protection, water intrusion, overheating, electrical arcing or uncertain isolation.',
      emergency:
          'Do not touch a person who may still be electrically energized. Isolate the source if safe, call emergency support and provide first aid/CPR only when the area is safe and trained to do so.',
      malayalam:
          'Site electrical safety-ൽ electric shock, electrocution, arc flash, fire എന്നിവ പ്രധാന hazards ആണ്. Cables, plugs, tools, distribution boards എന്നിവ inspect ചെയ്യണം. Maintenance മുമ്പ് isolation വേണം. Damaged cable/plug ഉപയോഗിക്കരുത്; protection devices bypass ചെയ്യരുത്.',
    ),

    _ReferenceTopic(
      title: 'Temporary Works',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 43.0',
      copNumber: 'CoP 43.0 – Temporary Structures',
      version: 'V4.1',
      effectiveDate: '27 February 2026',
      shortDescription:
          'Control temporary structures through design, approval, installation, inspection and change control.',
      overview:
          'Temporary structures and support systems can fail if incorrectly designed, installed, loaded or modified. Proper technical review, installation control and inspection are essential.',
      hazards:
          'Collapse • Overloading • Instability • Falls • Falling materials • Incorrect installation • Unauthorized modification.',
      controls:
          'Approved design • Competent supervision • Suitable foundations/supports • Bracing • Load control • Installation inspection • Monitoring • Change control • Safe removal.',
      planning:
          'Identify the temporary structure and its function. Confirm design requirements, loads, support conditions, installation sequence, inspection requirements and removal arrangements.',
      safePractices:
          'Use approved designs and drawings. Verify installation before loading. Control changes through the appropriate technical process. Maintain inspection records where required.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Eye protection • Fall protection where required.',
      checklist:
          'Design approved • Competent personnel • Foundation/support • Bracing • Connections • Load limits • Inspection • Change control • Removal plan.',
      inspection:
          'Foundations • Supports • Bracing • Connections • Alignment • Load condition • Damage • Unauthorized modification • Signs of movement.',
      dos:
          'Follow approved design. Inspect before loading. Report movement, damage or instability immediately.',
      donts:
          'Do not modify temporary works without approval. Do not exceed design loading. Do not remove supports prematurely.',
      stopWork:
          'Stop work if temporary works show movement, instability, damage, overload or unauthorized modification.',
      emergency:
          'Evacuate the danger zone if instability is suspected. Prevent access until competent technical personnel confirm the area is safe.',
      malayalam:
          'Temporary works/structures failure serious collapse ഉണ്ടാക്കാം. Approved design, competent installation, foundation/support, bracing, load control, inspection, change control എന്നിവ ഉറപ്പാക്കണം. Unauthorized modification അല്ലെങ്കിൽ premature removal അനുവദിക്കരുത്.',
    ),

    _ReferenceTopic(
      title: 'Manual Handling',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 14.0',
      copNumber: 'CoP 14.0 – Manual Handling and Ergonomics',
      version: 'V4.0',
      effectiveDate: '15 July 2024',
      shortDescription:
          'Reduce musculoskeletal injuries through task assessment, mechanical aids and safe handling techniques.',
      overview:
          'Manual handling includes lifting, carrying, pushing and pulling. The preferred approach is to avoid unnecessary manual handling and use mechanical assistance where reasonably practicable.',
      hazards:
          'Back injuries • Muscle strains • Crush injuries • Dropped loads • Awkward posture • Repetitive strain • Slips while carrying.',
      controls:
          'Avoid unnecessary handling • Mechanical aids • Reduce load • Improve work height • Team handling • Good technique • Training • Suitable work organization.',
      planning:
          'Assess weight, size, shape, route, frequency and posture. Consider whether a trolley, hoist, lifting aid or team handling can reduce the risk.',
      safePractices:
          'Assess the load and route before lifting. Use mechanical aids where available. Keep the load close to the body. Avoid twisting while carrying.',
      ppe:
          'Safety footwear • Suitable gloves • Task-specific PPE.',
      checklist:
          'Load assessed • Weight known/estimated • Route clear • Mechanical aid considered • Team lift where required • Suitable posture • PPE • Worker capability.',
      inspection:
          'Route • Floor condition • Obstacles • Load stability • Handling equipment • Worker position • Storage arrangements.',
      dos:
          'Plan the movement. Use mechanical aids. Ask for assistance when required. Keep the route clear.',
      donts:
          'Do not attempt a load beyond your capability. Do not twist while lifting. Do not carry loads that block your view.',
      stopWork:
          'Stop and reassess if the load is beyond safe capability, the route is blocked, the mechanical aid is defective or the handling method creates excessive risk.',
      emergency:
          'Stop activity after injury and provide first aid or medical assessment as appropriate. Report the incident according to site procedures.',
      malayalam:
          'Manual handling-ൽ ആദ്യം mechanical aid ഉപയോഗിക്കാൻ കഴിയുമോ എന്ന് നോക്കണം. Load weight, size, route, posture എന്നിവ assess ചെയ്യുക. കഴിയാത്ത load force ചെയ്ത് lift ചെയ്യരുത്. Lift ചെയ്യുമ്പോൾ twist ചെയ്യരുത്; route clear ആക്കണം.',
    ),

    _ReferenceTopic(
      title: 'Hot Works',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC • CoP 28.0',
      copNumber: 'CoP 28.0 – Hot Work Operations (e.g. Welding and Cutting)',
      version: 'V4.1',
      effectiveDate: '27 February 2026',
      shortDescription:
          'Control welding, cutting, grinding and other work producing heat, flames or sparks.',
      overview:
          'Hot work includes activities such as welding, cutting and other processes that produce heat, flame or sparks. It can cause fire, explosion, burns, fumes and eye injuries and requires suitable planning and controls.',
      hazards:
          'Fire • Explosion • Burns • Sparks • Fumes • Eye injury • Gas-cylinder hazards • Heat • Ignition of hidden combustibles.',
      controls:
          'Hot-work permit/authorization where required • Combustible control • Fire extinguishers • Fire watch • Gas-cylinder control • Screens • Ventilation • Post-work fire check.',
      planning:
          'Identify combustible materials and nearby operations. Confirm the required permit or authorization. Establish fire protection, cylinder controls, ventilation and post-work monitoring.',
      safePractices:
          'Inspect the area before starting. Remove or protect combustibles. Maintain fire protection. Secure cylinders and hoses. Conduct the required post-work inspection/fire watch.',
      ppe:
          'Welding helmet/goggles • Welding gloves • Flame-resistant clothing • Safety footwear • Face shield where required • Eye protection.',
      checklist:
          'Permit/authorization • Combustibles controlled • Fire extinguisher • Fire watch • Cylinders secured • Hoses/regulators • Screens • Ventilation • Post-work inspection.',
      inspection:
          'Combustibles • Fire protection • Welding leads • Gas cylinders • Hoses • Regulators • Screens • Ventilation • Fire-watch arrangements.',
      dos:
          'Maintain fire watch where required. Secure cylinders. Use suitable PPE. Inspect the area after hot work.',
      donts:
          'Do not perform hot work near uncontrolled combustibles. Do not use damaged hoses or regulators. Do not leave the area without required fire controls.',
      stopWork:
          'Stop hot work if combustibles cannot be controlled, fire protection is unavailable, gas equipment is defective, ventilation is inadequate or permit conditions are not satisfied.',
      emergency:
          'Raise the alarm and use fire-response equipment only if trained and safe to do so. Evacuate and contact emergency services for uncontrolled fires.',
      malayalam:
          'Hot work-ൽ welding, cutting, grinding തുടങ്ങിയ activities ഉൾപ്പെടുന്നു. Sparks, fire, explosion, burns, fumes എന്നിവ പ്രധാന hazards ആണ്. Required permit/authorization, combustible control, fire extinguisher, fire watch, ventilation, cylinder safety എന്നിവ ഉറപ്പാക്കണം.',
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
      final categoryMatches = _selectedCategory == _GuidelineCategory.all ||
          topic.category == _selectedCategory;

      if (!categoryMatches) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      final searchable = [
        topic.title,
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
                  'Detailed UAE HSE safety guidance with official Abu Dhabi ADPHC Code of Practice references.',
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
                label: 'Abu Dhabi',
                category: _GuidelineCategory.abuDhabi,
                icon: Icons.location_city_rounded,
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

  Widget _buildSectionHeader(String title, String subtitle) {
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
                    _sourceBadge(),
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

  Widget _sourceBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF5F0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'ABU DHABI • ADPHC',
        style: TextStyle(
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
            'Try another keyword.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF777777)),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Official Source',
                  style: TextStyle(
                    color: Color(0xFF0B5D4B),
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'ADPHC – Code of Practices',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  topic.copNumber,
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
                  'Effective Date: ${topic.effectiveDate}',
                  style: const TextStyle(
                    color: Color(0xFF555555),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Official website:',
                  style: TextStyle(
                    color: Color(0xFF0B5D4B),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'www.adphc.gov.ae/en/Legislation/Code-of-Practices',
                  style: TextStyle(
                    color: Color(0xFF0B5D4B),
                    fontSize: 11,
                    decoration: TextDecoration.underline,
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
        border: Border.all(color: Colors.grey.shade200),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: Color(0xFF0B5D4B),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  'This Safety Guideline is provided for HSE learning and practical workplace reference. The ADPHC Code of Practices provides minimum mandatory OSH technical requirements for applicable subjects. Always verify the latest official requirement, applicable legislation, project procedures, risk assessment, method statement and permit requirements before making a compliance decision.',
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
        border: Border.all(color: Colors.grey.shade200),
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
// ENUM
// ============================================================

enum _GuidelineCategory {
  all,
  abuDhabi,
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
