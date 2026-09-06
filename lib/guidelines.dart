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
      title: 'Code of Practice',
      category: _GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE General HSE Reference',
      shortDescription:
          'Understand how HSE Codes of Practice and approved safety guidance are used to plan and control workplace activities.',
      overview:
          'A Code of Practice provides practical guidance for managing health and safety risks associated with specific activities or workplaces. HSE personnel should consider applicable legislation, regulator requirements, approved Codes of Practice, standards, risk assessments, method statements and project procedures together when planning work.',
      hazards:
          'Incorrect interpretation of requirements • Outdated documents • Missing project-specific controls • Inadequate risk assessment • Poor implementation • Lack of competent supervision.',
      controls:
          'Identify applicable requirements • Use current approved documents • Complete risk assessment • Develop method statements • Define responsibilities • Train workers • Inspect implementation • Review controls when conditions change.',
      planning:
          'Identify the activity and applicable requirements before work starts. Confirm that the latest approved documents are available. Review the risk assessment and method statement against actual site conditions. Assign competent persons and communicate critical controls to the workforce.',
      safePractices:
          'Confirm the applicable requirement before starting work. Make sure the method statement and risk assessment reflect actual site conditions. Communicate important controls through toolbox talks and supervision. Maintain controlled documents and records where required.',
      ppe:
          'PPE is determined by the activity risk assessment and applicable requirements. Typical construction PPE may include safety helmet, safety footwear, high-visibility clothing, eye protection and task-specific PPE.',
      checklist:
          'Applicable requirements identified • Current documents verified • Risk assessment available • Method statement approved • Workers briefed • Competent supervision • Inspection completed • Changes reviewed.',
      inspection:
          'Verify that approved documents are current • Check implementation against the method statement • Confirm workers understand critical controls • Review inspection and training records • Check that changes are formally assessed.',
      dos:
          'Use current approved guidance. Follow project procedures. Ask competent HSE or technical personnel when requirements are unclear. Keep evidence of inspections, training and approvals.',
      donts:
          'Do not rely on outdated copies. Do not treat general guidance as a replacement for applicable law or project requirements. Do not ignore site-specific risks.',
      stopWork:
          'Stop work if required controls are missing, the approved method cannot be followed, site conditions have materially changed, or the applicable requirement is unclear.',
      emergency:
          'Stop unsafe work, make the area safe, provide emergency response and report the incident through the project emergency and reporting procedure.',
    ),

    _ReferenceTopic(
      title: 'Manual Handling',
      category: _GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE General HSE Reference',
      shortDescription:
          'Reduce musculoskeletal injuries through task assessment, mechanical aids and safe handling techniques.',
      overview:
          'Manual handling includes lifting, carrying, pushing and pulling. The preferred approach is to avoid unnecessary manual handling and use mechanical assistance where reasonably practicable.',
      hazards:
          'Back injuries • Muscle strains • Crush injuries • Dropped loads • Awkward posture • Repetitive strain.',
      controls:
          'Avoid unnecessary handling • Mechanical aids • Reduce load • Improve work height • Team handling • Good technique • Training • Task rotation where appropriate.',
      planning:
          'Assess the weight, size, shape, route, frequency and posture required. Consider whether a trolley, hoist, lifting aid or team handling can reduce the risk.',
      safePractices:
          'Assess the load and route before lifting. Use mechanical aids where available. Keep the load close to the body and avoid twisting while carrying.',
      ppe:
          'Safety footwear • Suitable gloves • Task-specific PPE.',
      checklist:
          'Load assessed • Weight known or estimated • Route clear • Mechanical aid considered • Team lift where required • Suitable posture • PPE • Worker capability.',
      inspection:
          'Check route • Floor condition • Obstacles • Load stability • Handling equipment • Worker position • Storage arrangements.',
      dos:
          'Plan the movement. Ask for assistance when required. Use trolleys, hoists or other suitable aids.',
      donts:
          'Do not attempt a load beyond your capability. Do not twist while lifting. Do not carry loads that block your view.',
      stopWork:
          'Stop and reassess if the load is beyond safe capability, the route is blocked, the mechanical aid is defective or the handling method creates excessive risk.',
      emergency:
          'Stop activity after injury and provide first aid or medical assessment as appropriate. Report the incident according to site procedures.',
    ),

    _ReferenceTopic(
      title: 'Worker Welfare',
      category: _GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE General HSE Reference',
      shortDescription:
          'Provide suitable welfare facilities that support worker health, hygiene, rest and wellbeing.',
      overview:
          'Worker welfare includes drinking water, sanitation, washing facilities, rest areas, hygiene, cleaning and protection from environmental conditions. Welfare controls support worker health and safe performance.',
      hazards:
          'Dehydration • Poor hygiene • Heat stress • Fatigue • Unsanitary conditions • Poor rest arrangements.',
      controls:
          'Safe drinking water • Toilets • Washing facilities • Rest areas • Hygiene • Cleaning • Heat protection • Suitable welfare monitoring.',
      planning:
          'Assess workforce size, work location and environmental conditions. Plan adequate access to drinking water, sanitation, washing, rest and cooling facilities.',
      safePractices:
          'Keep welfare facilities clean and accessible. Replenish drinking water. Monitor cleanliness and report deficiencies. Provide suitable arrangements for the workforce and site conditions.',
      ppe:
          'PPE is generally task-specific rather than a substitute for welfare controls.',
      checklist:
          'Drinking water • Toilets • Washing facilities • Rest area • Cleaning • Waste disposal • Heat protection • Accessibility • Inspection records where required.',
      inspection:
          'Check water supply • Toilets • Washing facilities • Rest areas • Cleanliness • Waste disposal • Cooling arrangements • Accessibility.',
      dos:
          'Maintain clean facilities. Ensure workers can access water and rest facilities. Report welfare deficiencies.',
      donts:
          'Do not block access to welfare facilities. Do not allow poor hygiene conditions to continue uncorrected.',
      stopWork:
          'Escalate or stop affected work when essential welfare arrangements are unavailable and worker health or safety could be adversely affected.',
      emergency:
          'For heat illness or other welfare-related emergencies, activate the site medical or emergency procedure immediately.',
    ),

    // ==========================================================
    // ABU DHABI / ADOSH-SF
    // ==========================================================

    _ReferenceTopic(
      title: 'Working at Height',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'Abu Dhabi – ADOSH-SF',
      shortDescription:
          'Control fall risks through suitable access, edge protection, fall protection and rescue planning.',
      overview:
          'Working at height creates a risk of falling from one level to another. Work should be properly planned, supervised and controlled using suitable platforms, access systems, edge protection and fall-protection arrangements.',
      hazards:
          'Falls from height • Falling objects • Open edges • Floor openings • Unsafe ladders • Inadequate platforms • Incorrect harness use • Difficult rescue.',
      controls:
          'Avoid work at height where reasonably practicable • Safe working platforms • Guardrails • Edge protection • Suitable access • Fall protection • Equipment inspection • Rescue planning.',
      planning:
          'Assess whether the work can be completed from ground level. Select suitable access equipment. Assess edges, openings, weather, falling objects and rescue requirements before starting.',
      safePractices:
          'Use suitable working platforms and access systems. Protect edges and openings. Inspect fall-protection equipment before use. Follow the approved method and site requirements.',
      ppe:
          'Safety helmet • Safety footwear • Full-body harness where required • Gloves • Eye protection • Task-specific PPE.',
      checklist:
          'Risk assessment • Safe access • Suitable platform • Edge protection • Openings protected • Harness inspected • Suitable anchorage • Falling-object controls • Rescue plan • Competent workers.',
      inspection:
          'Check working platform • Guardrails • Edge protection • Floor openings • Access equipment • Harness and lanyard • Anchorage • Tool securing • Rescue arrangements.',
      dos:
          'Plan work before starting. Use approved access equipment. Keep tools and materials secure. Follow the approved fall-protection system.',
      donts:
          'Do not work from unstable surfaces. Do not use damaged fall-protection equipment. Do not attach to unsuitable anchor points. Do not remove edge protection without authorization.',
      stopWork:
          'Stop work if edge protection is missing, access is unsafe, fall protection is defective, anchorage is unsuitable or conditions become unsafe.',
      emergency:
          'Activate the approved rescue plan. Avoid creating a second casualty during rescue. Provide first aid and medical assistance as required.',
    ),

    _ReferenceTopic(
      title: 'Scaffolding',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'Abu Dhabi – ADOSH-SF',
      shortDescription:
          'Control scaffold erection, inspection, access, loading, stability and use.',
      overview:
          'Scaffolding provides temporary access and working platforms. It must be appropriately designed or selected, erected, inspected, maintained and used by competent personnel.',
      hazards:
          'Falls from height • Scaffold collapse • Falling objects • Overloading • Unsafe access • Missing guardrails • Unstable foundation • Unauthorized modification.',
      controls:
          'Competent erection • Stable foundation • Bracing • Guardrails • Toe boards • Safe access • Load control • Inspection • Scaffold status control • Unauthorized modification prevention.',
      planning:
          'Select a scaffold suitable for the intended height, access and loading requirements. Confirm foundation and supporting conditions. Plan erection, inspection, access and material loading.',
      safePractices:
          'Use inspected and approved scaffolding. Maintain safe access. Keep platforms within their intended loading capacity. Do not modify scaffolding without authorization.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Full-body harness where required • High-visibility clothing.',
      checklist:
          'Foundation stable • Uprights secure • Bracing • Guardrails • Toe boards • Platform condition • Safe access • Load capacity • Inspection status • Unauthorized alterations checked.',
      inspection:
          'Check foundation and stability • Bracing and connections • Platforms • Guardrails and toe boards • Access • Scaffold status/tag • Damage • Unauthorized alterations.',
      dos:
          'Use approved access. Report defects immediately. Keep platforms tidy. Respect scaffold loading limits.',
      donts:
          'Do not remove guardrails or braces without authorization. Do not use incomplete or damaged scaffolding. Do not overload platforms.',
      stopWork:
          'Stop scaffold use if it is incomplete, unstable, damaged, overloaded, missing required protection or has been altered without authorization.',
      emergency:
          'Stop use, isolate the affected scaffold and prevent access. Activate the site emergency and rescue procedure if an incident occurs.',
    ),

    _ReferenceTopic(
      title: 'Lifting',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'Abu Dhabi – ADOSH-SF',
      shortDescription:
          'Plan and control lifting operations involving cranes, lifting accessories, loads and personnel.',
      overview:
          'Lifting operations involve moving loads using cranes, hoists or other lifting equipment. Safe lifting requires suitable planning, competent personnel, inspected equipment, load control, stable ground and effective communication.',
      hazards:
          'Dropped loads • Overloading • Equipment failure • Unstable ground • Suspended loads • Crushing • Struck-by incidents • Poor communication • Wind and weather.',
      controls:
          'Approved lift plan • Competent lifting team • Suitable inspected equipment • Correct lifting accessories • Load weight verification • Ground assessment • Exclusion zone • Communication • Weather assessment.',
      planning:
          'Confirm load weight, dimensions, lifting points and centre of gravity. Select suitable lifting equipment and accessories. Assess ground conditions and establish the lifting route and exclusion zone.',
      safePractices:
          'Inspect lifting equipment and accessories before use. Confirm safe working load and load weight. Use suitable slings and shackles. Keep people away from suspended loads.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Gloves • Eye protection where required • Task-specific PPE.',
      checklist:
          'Lift plan • Competent operator • Competent rigger/banksman • Equipment inspection • SWL verified • Accessories inspected • Ground condition checked • Exclusion zone • Communication • Weather checked.',
      inspection:
          'Check lifting equipment • Hooks and safety devices • Accessories • Ground stability • Connections • Exclusion zone • Communication arrangements.',
      dos:
          'Use suitable certified equipment. Maintain communication. Keep personnel outside the danger zone. Stop the lift when conditions become unsafe.',
      donts:
          'Never exceed equipment capacity. Never stand under suspended loads. Do not use damaged lifting accessories. Do not lift in unsafe conditions.',
      stopWork:
          'Stop the lift for damaged equipment, uncertain load weight, unstable ground, loss of communication, people entering the exclusion zone or unexpected conditions.',
      emergency:
          'Stop the lifting operation, isolate the area, prevent access and activate the site emergency response procedure.',
    ),

    _ReferenceTopic(
      title: 'Excavation',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'Abu Dhabi – ADOSH-SF',
      shortDescription:
          'Control ground collapse, underground services, access, plant and excavation hazards.',
      overview:
          'Excavation work creates risks from ground collapse, underground services, falling materials, plant movement, water ingress and restricted access. Excavations must be properly planned and controlled before workers enter.',
      hazards:
          'Cave-in • Underground utilities • Falling materials • Plant/mobile equipment • Falls into excavation • Water ingress • Hazardous atmosphere • Access problems.',
      controls:
          'Excavation risk assessment • Service information and detection • Suitable protective system • Safe access • Edge protection • Spoil control • Plant exclusion • Competent inspection.',
      planning:
          'Review drawings and underground service information before breaking ground. Assess soil and surrounding conditions. Select a suitable protective system. Plan access, spoil placement, plant movement and emergency arrangements.',
      safePractices:
          'Confirm underground services before excavation. Keep spoil and equipment away from excavation edges as required by the approved method. Provide safe access and egress. Inspect excavations after changing conditions.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Gloves • Eye protection • Respiratory protection where required.',
      checklist:
          'Permit/authorization • Utility survey • Excavation plan • Ground assessment • Protective system • Safe access • Edge protection • Spoil control • Water control • Competent inspection.',
      inspection:
          'Check excavation walls • Protective systems • Edge protection • Access • Spoil and plant position • Water accumulation • Ground movement • Cracking.',
      dos:
          'Inspect before entry. Maintain safe access. Keep unauthorized personnel away. Stop work when ground conditions change.',
      donts:
          'Do not enter an unsafe unsupported excavation. Do not place spoil or heavy equipment dangerously close to the edge. Do not ignore service information.',
      stopWork:
          'Stop work if ground movement, cracking, water ingress, damaged protection, unknown services or unsafe access is identified.',
      emergency:
          'Raise the alarm and keep people away from a collapse area. Do not enter a collapsed excavation for rescue without an approved rescue system and competent emergency team.',
    ),

    _ReferenceTopic(
      title: 'Hot Work',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'Abu Dhabi – ADOSH-SF',
      shortDescription:
          'Control welding, cutting, grinding and other activities producing heat, flames or sparks.',
      overview:
          'Hot work can cause fires, explosions, burns, fumes and eye injuries. The work must be planned and controlled with suitable permits, fire protection, combustible control, ventilation and PPE.',
      hazards:
          'Fire • Explosion • Burns • Sparks • Fumes • Eye injury • Gas-cylinder hazards • Heat.',
      controls:
          'Hot-work authorization where required • Combustible control • Fire extinguisher • Fire watch • Gas-cylinder control • Screens • Ventilation • Post-work inspection.',
      planning:
          'Identify combustible materials and nearby operations. Confirm the required authorization or permit. Establish fire protection, cylinder controls, ventilation and post-work monitoring.',
      safePractices:
          'Inspect the work area before starting. Remove or protect combustibles. Maintain fire protection. Secure cylinders and hoses. Inspect the area after completion.',
      ppe:
          'Welding helmet/goggles • Welding gloves • Flame-resistant clothing • Safety footwear • Face shield where required • Eye protection.',
      checklist:
          'Permit/authorization • Combustibles controlled • Fire extinguisher • Fire watch • Cylinders secured • Hoses/regulators • Screens • Ventilation • Post-work inspection.',
      inspection:
          'Check combustibles • Fire protection • Welding leads • Gas cylinders • Hoses • Regulators • Screens • Ventilation • Fire-watch arrangements.',
      dos:
          'Maintain fire watch where required. Keep cylinders secured. Use suitable PPE. Inspect the area after hot work.',
      donts:
          'Do not perform hot work near uncontrolled combustibles. Do not use damaged hoses or regulators. Do not leave without required fire controls.',
      stopWork:
          'Stop hot work if combustibles cannot be controlled, fire protection is unavailable, gas equipment is defective, ventilation is inadequate or permit conditions are not satisfied.',
      emergency:
          'Raise the alarm and use fire-response equipment only if trained and safe to do so. Evacuate and call emergency services for uncontrolled fires.',
    ),

    _ReferenceTopic(
      title: 'Portable Power Tools',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'Abu Dhabi – ADOSH-SF',
      shortDescription:
          'Use portable power tools safely through inspection, guarding, correct accessories and PPE.',
      overview:
          'Portable power tools can cause cuts, electric shock, burns, flying particles, noise and vibration injuries. Safe use depends on correct tool selection, condition, guarding and operator competence.',
      hazards:
          'Cuts • Flying particles • Electric shock • Burns • Entanglement • Noise • Vibration • Incorrect accessories.',
      controls:
          'Correct tool selection • Pre-use inspection • Guards • Electrical protection • Correct accessories • Maintenance • Competent operators • Good housekeeping.',
      planning:
          'Select the correct tool for the task. Review manufacturer instructions. Check electrical protection requirements. Assess dust, noise, vibration, sparks and nearby workers.',
      safePractices:
          'Inspect tools before use. Use the correct accessory and guard. Keep cables protected. Disconnect power before changing accessories. Maintain a stable working position.',
      ppe:
          'Safety glasses or face protection • Safety footwear • Hearing protection • Suitable gloves • Safety helmet • Task-specific PPE.',
      checklist:
          'Tool condition • Guard • Cable/plug • Correct accessory • Electrical protection • Operator competence • PPE • Work area • Maintenance status.',
      inspection:
          'Check casing • Guards • Switches • Cable and plug • Accessories • Labels • Electrical protection • Overheating or damage.',
      dos:
          'Use tools according to manufacturer instructions. Keep guards fitted. Remove defective tools from service.',
      donts:
          'Do not use damaged tools. Do not remove guards. Do not carry tools by cables. Do not use unsuitable accessories.',
      stopWork:
          'Stop using the tool if the guard, cable, plug, switch or accessory is damaged or abnormal vibration, noise, overheating or sparking occurs.',
      emergency:
          'Isolate the energy source, provide first aid and obtain medical assistance for serious injury. Report defective equipment.',
    ),

    _ReferenceTopic(
      title: 'Working On or Adjacent to a Road',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'Abu Dhabi – ADOSH-SF',
      shortDescription:
          'Protect workers and road users through traffic management, segregation, barriers and controlled work zones.',
      overview:
          'Work on, over or adjacent to roads creates interaction between workers, vehicles and public traffic. Proper traffic management and segregation are essential.',
      hazards:
          'Vehicle strike • Reversing • Poor visibility • Unauthorized access • Night work • Traffic congestion • Falling objects into roadways.',
      controls:
          'Traffic management arrangement • Barriers • Signs • Cones • Safe pedestrian routes • Trained traffic controllers • High visibility • Lighting • Speed control.',
      planning:
          'Review the approved traffic management arrangement. Identify pedestrian and vehicle movements. Plan barriers, signs, lighting, access points and traffic-controller positions.',
      safePractices:
          'Separate pedestrians from traffic wherever possible. Maintain clear signs and barriers. Keep work zones tidy and visible. Follow the approved traffic arrangement.',
      ppe:
          'High-visibility clothing • Safety footwear • Safety helmet • Eye protection • Task-specific PPE.',
      checklist:
          'Approved traffic plan • Signs • Barriers • Lighting • Pedestrian route • Vehicle route • Traffic controller • High-visibility PPE • Inspection.',
      inspection:
          'Check signs • Barriers • Cones • Lighting • Pedestrian segregation • Vehicle routes • Work-zone visibility • Damaged controls.',
      dos:
          'Maintain the approved traffic arrangement. Check visibility regularly. Keep barriers stable and correctly positioned.',
      donts:
          'Do not remove traffic controls without authorization. Do not allow pedestrians into live traffic areas. Do not obstruct road visibility.',
      stopWork:
          'Stop work if traffic controls are displaced, visibility is inadequate, unauthorized vehicles enter the work zone or pedestrian segregation fails.',
      emergency:
          'Stop affected activities, protect the scene, contact emergency services where required and control traffic according to the emergency plan.',
    ),

    _ReferenceTopic(
      title: 'Concrete Placing Equipment',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'Abu Dhabi – ADOSH-SF',
      shortDescription:
          'Control hazards from concrete pumps, delivery systems, hoses, pressure and placing operations.',
      overview:
          'Concrete placing equipment can create struck-by, crushing, hose-whip and pressure-related hazards. Equipment, hoses, connections and work areas must be inspected and controlled.',
      hazards:
          'Hose whip • Pressure release • Crushing • Struck-by incidents • Equipment failure • Vehicle movement • Concrete contact.',
      controls:
          'Equipment inspection • Hose inspection • Secure connections • Exclusion zone • Communication • Competent operators • Safe positioning • Emergency arrangements.',
      planning:
          'Plan pump location, delivery route, hose routing, exclusion zones and communication. Confirm that formwork and access arrangements are ready for concrete placement.',
      safePractices:
          'Inspect equipment and hoses before use. Keep workers clear of uncontrolled hose movement. Maintain communication between operator and placing team.',
      ppe:
          'Safety helmet • Safety footwear • Suitable gloves • Eye protection • Protective clothing • Task-specific PPE.',
      checklist:
          'Equipment inspected • Hoses checked • Connections secure • Exclusion zone • Communication • Operator competence • Access • Formwork readiness • PPE.',
      inspection:
          'Check pump • Hoses • Couplings • Clamps • Connections • Exclusion zone • Communication • Access • Signs of damage.',
      dos:
          'Follow the approved placing sequence. Maintain communication. Keep personnel outside hose danger zones.',
      donts:
          'Do not stand in front of an uncontrolled hose. Do not use damaged hoses or connections. Do not enter exclusion zones during unsafe conditions.',
      stopWork:
          'Stop placing operations if equipment or hoses are damaged, connections are unsafe, communication is lost or uncontrolled movement occurs.',
      emergency:
          'Stop equipment safely, isolate the affected area and activate emergency response for serious injury or equipment failure.',
    ),

    _ReferenceTopic(
      title: 'Temporary Structures',
      category: _GuidelineCategory.abuDhabi,
      sourceLabel: 'Abu Dhabi – ADOSH-SF',
      shortDescription:
          'Control temporary structures through design, approval, installation, inspection and change control.',
      overview:
          'Temporary structures and support systems can fail if incorrectly designed, installed, loaded or modified. Proper technical review and inspection are essential.',
      hazards:
          'Collapse • Overloading • Instability • Falls • Falling materials • Incorrect installation • Unauthorized modification.',
      controls:
          'Design • Approval • Competent supervision • Installation inspection • Load control • Monitoring • Change control • Safe removal.',
      planning:
          'Identify the temporary structure and intended function. Confirm design requirements, loads, support conditions, installation sequence, inspection and removal arrangements.',
      safePractices:
          'Use approved designs and drawings. Verify installation before loading. Control changes through the appropriate technical process. Maintain inspection records where required.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Eye protection • Fall protection where required.',
      checklist:
          'Design approved • Competent personnel • Foundation/support • Bracing • Connections • Load limits • Inspection • Change control • Removal plan.',
      inspection:
          'Check foundations • Supports • Bracing • Connections • Alignment • Load condition • Damage • Unauthorized modification • Signs of movement.',
      dos:
          'Follow approved design. Inspect before loading. Report movement, damage or instability immediately.',
      donts:
          'Do not modify temporary structures without approval. Do not exceed design loading. Do not remove supports prematurely.',
      stopWork:
          'Stop work if temporary structures show movement, instability, damage, overload or unauthorized modification.',
      emergency:
          'Evacuate the danger zone if instability is suspected. Prevent access until competent technical personnel confirm the area is safe.',
    ),

    // ==========================================================
    // DUBAI / DUBAI MUNICIPALITY
    // ==========================================================

    _ReferenceTopic(
      title: 'Construction Safety',
      category: _GuidelineCategory.dubai,
      sourceLabel: 'Dubai – Dubai Municipality',
      shortDescription:
          'Understand construction safety requirements applicable to construction activities in Dubai.',
      overview:
          'Construction activities in Dubai are subject to applicable Dubai legislation, Dubai Municipality requirements and the relevant Code of Construction Safety Practice. Contractors, consultants and site personnel should identify the current requirements applicable to their project and activity.',
      hazards:
          'Falls • Structural instability • Excavation collapse • Lifting incidents • Vehicle interaction • Electrical hazards • Fire • Falling objects • Poor site control.',
      controls:
          'Approved construction safety arrangements • Risk assessment • Competent supervision • Safe access • Traffic management • Equipment inspection • Emergency planning • Site housekeeping.',
      planning:
          'Identify the applicable Dubai requirements and project conditions before work starts. Review approved construction safety arrangements, risk assessments, method statements and permits.',
      safePractices:
          'Follow current Dubai Municipality and project requirements. Maintain safe access, segregation, housekeeping and equipment controls. Ensure workers understand site-specific safety arrangements.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Eye protection • Gloves • Task-specific PPE.',
      checklist:
          'Applicable Dubai requirements • Risk assessment • Method statement • Competent supervision • Safe access • Traffic controls • Equipment inspection • Emergency arrangements • Housekeeping.',
      inspection:
          'Check site access • Work areas • Barriers • Equipment • Excavations • Temporary works • Traffic arrangements • Housekeeping • Emergency provisions.',
      dos:
          'Use current approved Dubai requirements. Follow project procedures. Maintain inspection records. Escalate unclear requirements to competent personnel.',
      donts:
          'Do not assume a generic UAE guideline automatically satisfies Dubai-specific requirements. Do not use outdated documents. Do not ignore project-specific controls.',
      stopWork:
          'Stop affected work when required controls are missing, unsafe site conditions exist or the approved method cannot be followed.',
      emergency:
          'Raise the alarm, make the area safe, provide emergency response and follow the project emergency procedure.',
    ),

    _ReferenceTopic(
      title: 'Working at Height – Dubai',
      category: _GuidelineCategory.dubai,
      sourceLabel: 'Dubai – Dubai Municipality',
      shortDescription:
          'Apply safe working-at-height controls within Dubai construction work requirements.',
      overview:
          'Working at height in Dubai construction projects requires appropriate planning, safe access, edge protection, suitable working platforms and fall-protection measures based on the applicable Dubai requirements and project controls.',
      hazards:
          'Falls from height • Falling objects • Open edges • Unsafe ladders • Unsafe platforms • Improper fall protection.',
      controls:
          'Risk assessment • Safe access • Guardrails • Edge protection • Protected openings • Suitable platforms • Fall protection • Rescue planning.',
      planning:
          'Determine the safest method of access and work. Review the project method statement and applicable Dubai requirements before work begins.',
      safePractices:
          'Use approved platforms and access equipment. Protect edges and openings. Keep materials secure. Inspect access and fall-protection equipment.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Full-body harness where required • Gloves • Eye protection.',
      checklist:
          'Risk assessment • Access • Platform • Guardrails • Edge protection • Openings protected • Fall protection • Rescue plan • Inspection.',
      inspection:
          'Check platforms • Guardrails • Openings • Access • Harness • Anchorage • Falling-object controls • Rescue arrangements.',
      dos:
          'Follow the approved Dubai project method. Maintain fall protection. Report defects immediately.',
      donts:
          'Do not use unstable platforms. Do not remove edge protection without authorization. Do not use defective fall-protection equipment.',
      stopWork:
          'Stop work if safe access or fall protection is not available or if conditions become unsafe.',
      emergency:
          'Activate the approved rescue and emergency response procedure. Prevent further exposure to the hazard.',
    ),

    _ReferenceTopic(
      title: 'Scaffolding – Dubai',
      category: _GuidelineCategory.dubai,
      sourceLabel: 'Dubai – Dubai Municipality',
      shortDescription:
          'Control scaffold stability, access, inspection, loading and safe use in Dubai construction projects.',
      overview:
          'Scaffolds used for construction work in Dubai must be appropriately planned, erected, inspected and maintained according to applicable Dubai requirements and project controls.',
      hazards:
          'Falls • Collapse • Falling objects • Overloading • Unsafe access • Missing protection • Unauthorized modification.',
      controls:
          'Suitable scaffold system • Competent erection • Stable foundation • Bracing • Guardrails • Toe boards • Safe access • Inspection • Load control.',
      planning:
          'Confirm the intended use, height, loading and supporting conditions. Ensure erection and inspection arrangements are controlled by competent personnel.',
      safePractices:
          'Use only inspected scaffolding. Maintain safe access. Do not overload platforms. Prevent unauthorized alteration.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • High-visibility clothing • Fall protection where required.',
      checklist:
          'Foundation • Bracing • Guardrails • Toe boards • Platform • Access • Load capacity • Inspection status • Alteration control.',
      inspection:
          'Check stability • Connections • Platforms • Guardrails • Access • Tags/status • Damage • Unauthorized modification.',
      dos:
          'Follow the approved scaffold arrangement. Report defects. Keep platforms clean and within loading limits.',
      donts:
          'Do not use incomplete or damaged scaffolding. Do not remove protective components without authorization.',
      stopWork:
          'Stop scaffold use when stability, access, protection or inspection status is unacceptable.',
      emergency:
          'Isolate the affected scaffold, prevent access and follow the project emergency procedure.',
    ),

    _ReferenceTopic(
      title: 'Excavation – Dubai',
      category: _GuidelineCategory.dubai,
      sourceLabel: 'Dubai – Dubai Municipality',
      shortDescription:
          'Control excavation collapse, underground services, access, edge protection and plant interaction.',
      overview:
          'Excavation work in Dubai construction projects requires suitable planning and control of ground stability, underground services, access, plant movement, falling materials and other site-specific risks.',
      hazards:
          'Collapse • Underground services • Falls • Falling materials • Plant movement • Water ingress • Unsafe access.',
      controls:
          'Risk assessment • Service information • Protective system • Edge protection • Safe access • Spoil control • Plant segregation • Inspection.',
      planning:
          'Review drawings, service information and approved excavation arrangements. Assess ground conditions and plan access, plant movement, spoil placement and emergency arrangements.',
      safePractices:
          'Inspect excavations before entry and after significant changes. Maintain safe access and prevent unauthorized entry.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Gloves • Eye protection • Task-specific PPE.',
      checklist:
          'Excavation plan • Service information • Ground assessment • Protective system • Access • Edge protection • Spoil control • Plant control • Inspection.',
      inspection:
          'Check excavation condition • Protection • Edges • Access • Spoil • Plant position • Water • Ground movement.',
      dos:
          'Follow the approved excavation method. Inspect before entry. Report ground changes immediately.',
      donts:
          'Do not enter an unsafe excavation. Do not place plant or materials where they create an unacceptable edge risk.',
      stopWork:
          'Stop work if collapse risk, unknown services, water ingress, damaged protection or unsafe access is identified.',
      emergency:
          'Raise the alarm and isolate the area. Do not enter a collapsed excavation without a competent rescue arrangement.',
    ),

    _ReferenceTopic(
      title: 'Traffic Management & Site Logistics',
      category: _GuidelineCategory.dubai,
      sourceLabel: 'Dubai – Dubai Municipality',
      shortDescription:
          'Control vehicle, pedestrian and construction logistics interactions within Dubai projects.',
      overview:
          'Construction logistics and traffic management are important controls where vehicles, mobile plant, pedestrians and public roads interact. Project-specific traffic management arrangements must be followed.',
      hazards:
          'Vehicle collision • Reversing incidents • Pedestrian strike • Blind spots • Poor visibility • Congestion • Unauthorized access.',
      controls:
          'Traffic management plan • Pedestrian segregation • Vehicle routes • Banksman/traffic controller • Barriers • Signage • Lighting • Speed control • Delivery planning.',
      planning:
          'Map vehicle and pedestrian routes. Identify reversing areas, delivery points, access gates and interaction zones. Establish clear controls before work starts.',
      safePractices:
          'Separate pedestrians and vehicles wherever practicable. Maintain clear routes and signage. Use trained personnel for traffic control where required.',
      ppe:
          'High-visibility clothing • Safety helmet • Safety footwear • Eye protection • Task-specific PPE.',
      checklist:
          'Traffic plan • Vehicle routes • Pedestrian routes • Barriers • Signs • Lighting • Traffic controller • Reversing controls • Delivery arrangements.',
      inspection:
          'Check routes • Signs • Barriers • Lighting • Pedestrian segregation • Vehicle movements • Work-zone visibility.',
      dos:
          'Follow the approved traffic arrangement. Maintain clear routes. Report damaged traffic controls.',
      donts:
          'Do not remove barriers or signs without authorization. Do not allow uncontrolled vehicle-pedestrian interaction.',
      stopWork:
          'Stop affected work if traffic controls fail, visibility is inadequate or pedestrians and vehicles cannot be safely segregated.',
      emergency:
          'Stop movement in the affected area, protect the scene and activate the emergency response procedure.',
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
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
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
            searching ? 'SEARCH RESULTS' : 'HSE REFERENCE LIBRARY',
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
                  'UAE-wide HSE learning and reference with separate Abu Dhabi and Dubai guidance.',
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
                icon: Icons.public_rounded,
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
                    const SizedBox(height: 5),
                    _sourceBadge(topic.category),
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

  Widget _sourceBadge(_GuidelineCategory category) {
    String label;

    switch (category) {
      case _GuidelineCategory.uaeGeneral:
        label = 'UAE GENERAL';
        break;
      case _GuidelineCategory.abuDhabi:
        label = 'ABU DHABI • ADOSH-SF';
        break;
      case _GuidelineCategory.dubai:
        label = 'DUBAI • DUBAI MUNICIPALITY';
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
            'No HSE topic found',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Try another keyword or reference scope.',
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
            _buildHeroCard(),
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
                Text(
                  _referenceNoteText(),
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

  String _referenceNoteText() {
    switch (topic.category) {
      case _GuidelineCategory.uaeGeneral:
        return 'This UAE General reference is intended for HSE learning and practical workplace awareness. It does not replace applicable UAE legislation, regulator requirements, approved Codes of Practice, standards, risk assessments, method statements, permits or project procedures.';

      case _GuidelineCategory.abuDhabi:
        return 'This section is an Abu Dhabi / ADOSH-SF reference for learning and practical workplace awareness. It does not replace the current applicable ADOSH-SF requirements, legislation, Codes of Practice, mechanisms, project procedures, risk assessments or permits. Always verify the latest official requirement before making a compliance decision.';

      case _GuidelineCategory.dubai:
        return 'This section is a Dubai / Dubai Municipality reference for learning and practical workplace awareness. It does not replace current Dubai legislation, the applicable Code of Construction Safety Practice, Dubai Municipality requirements, project procedures, risk assessments or permits. Always verify the latest official requirement before making a compliance decision.';

      case _GuidelineCategory.all:
        return 'This page is intended for HSE learning and practical workplace reference. Requirements can vary by emirate, activity and project. Always verify the latest applicable official requirement before making a compliance decision.';
    }
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
// ENUMS
// ============================================================

enum _GuidelineCategory {
  all,
  uaeGeneral,
  abuDhabi,
  dubai,
}

// ============================================================
// DATA MODEL
// ============================================================

class _ReferenceTopic {
  final String title;
  final _GuidelineCategory category;
  final String sourceLabel;
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

  const _ReferenceTopic({
    required this.title,
    required this.category,
    required this.sourceLabel,
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
  });
}
