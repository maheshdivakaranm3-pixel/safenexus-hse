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
      title: 'Lifting',
      shortDescription:
          'Plan and control lifting operations involving cranes, lifting accessories, loads and personnel.',
      overview:
          'Lifting operations involve moving loads using cranes, hoists or other lifting equipment. Safe lifting requires proper planning, competent personnel, suitable equipment, load control, stable ground and effective communication.',
      hazards:
          'Dropped loads • Overloading • Equipment failure • Unstable ground • Suspended loads • Crushing • Struck-by incidents • Poor communication • Wind and weather.',
      controls:
          'Approved lift plan • Competent lifting team • Suitable inspected equipment • Correct lifting accessories • Load weight verification • Ground assessment • Exclusion zone • Communication system • Weather assessment.',
      planning:
          'Confirm the load weight, dimensions, lifting points and centre of gravity. Select suitable lifting equipment and accessories. Assess ground conditions and crane setup requirements. Establish the lifting route, exclusion zone and communication method before the lift.',
      safePractices:
          'Inspect lifting equipment and accessories before use. Confirm safe working load and load weight. Use suitable slings and shackles. Establish an exclusion zone. Keep people away from suspended loads. Use a competent signaler or banksman where required.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Gloves • Eye protection where required • Task-specific PPE.',
      checklist:
          'Lift plan • Competent operator • Competent rigger/banksman • Equipment inspection • SWL verified • Accessories inspected • Ground condition checked • Exclusion zone • Communication • Weather checked.',
      inspection:
          'Check crane or lifting equipment condition • Verify lifting accessories are suitable and undamaged • Check hooks, safety devices and connections • Confirm ground stability • Check exclusion zone and communication arrangements.',
      dos:
          'Use certified and suitable equipment. Maintain clear communication. Keep personnel outside the lifting danger zone. Stop the lift if conditions become unsafe.',
      donts:
          'Never exceed equipment capacity. Never stand under suspended loads. Do not use damaged lifting accessories. Do not lift when visibility or weather conditions make the operation unsafe.',
      stopWork:
          'Stop the lift for damaged equipment, uncertain load weight, unstable ground, loss of communication, people entering the exclusion zone, excessive wind or any unexpected change.',
      emergency:
          'Stop the lifting operation, isolate the area, prevent access, provide first aid or emergency response and report the incident according to the site procedure.',
    ),
    _ReferenceTopic(
      title: 'Excavation',
      shortDescription:
          'Control ground collapse, underground services, access and other excavation hazards.',
      overview:
          'Excavation work creates risks from ground collapse, underground services, falling materials, plant movement, water ingress and restricted access. Excavations must be properly planned and controlled before workers enter.',
      hazards:
          'Cave-in • Underground utilities • Falling materials • Plant/mobile equipment • Falls into excavation • Water ingress • Hazardous atmosphere • Access problems.',
      controls:
          'Excavation risk assessment • Service drawings and detection • Shoring or suitable battering/benching where required • Safe access • Edge protection • Spoil setback • Plant exclusion • Competent inspection.',
      planning:
          'Review drawings and underground service information before breaking ground. Assess soil and surrounding conditions. Select an appropriate protective system. Plan access, egress, spoil placement, plant movement, water control and emergency arrangements.',
      safePractices:
          'Confirm underground services before excavation. Keep spoil and equipment away from excavation edges as required by the approved method. Provide safe access and egress. Inspect excavations, especially after rain, vibration or changing conditions.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Gloves • Eye protection • Respiratory protection where required.',
      checklist:
          'Permit/authorization • Utility survey • Excavation plan • Ground assessment • Protective system • Safe access • Edge protection • Spoil control • Water control • Competent inspection.',
      inspection:
          'Check excavation walls and protective systems • Check edge protection • Check access and egress • Check spoil and plant position • Check water accumulation • Check for ground movement or cracking.',
      dos:
          'Inspect before entry. Maintain safe access. Keep unauthorized personnel away. Stop work if ground conditions change.',
      donts:
          'Do not enter an unsupported unsafe excavation. Do not place spoil or heavy equipment dangerously close to the edge. Do not ignore underground service information.',
      stopWork:
          'Stop work if ground movement, cracking, water ingress, damaged shoring, unknown services or unsafe access is identified.',
      emergency:
          'Raise the alarm, keep people away from a collapse area and never enter a collapsed excavation for rescue unless an approved rescue system and competent emergency team are in place.',
    ),
    _ReferenceTopic(
      title: 'Scaffolding',
      shortDescription:
          'Learn safe scaffold erection, inspection, access, loading and use.',
      overview:
          'Scaffolding provides temporary access and working platforms. It must be properly selected, erected, inspected, maintained and used by competent persons.',
      hazards:
          'Falls from height • Scaffold collapse • Falling objects • Overloading • Unsafe access • Missing guardrails • Unstable foundation • Unauthorized modification.',
      controls:
          'Competent erection • Stable foundation • Proper bracing • Guardrails • Toe boards • Safe access • Load control • Inspection • Tagging/control system • Protection from unauthorized alteration.',
      planning:
          'Select a scaffold suitable for the intended height, access and loading requirements. Confirm the foundation and supporting conditions. Plan erection, inspection, access, material loading and protection from falling objects.',
      safePractices:
          'Use only inspected and approved scaffolding. Maintain safe access. Keep platforms clear and within their intended loading capacity. Do not modify scaffolds unless authorized by competent personnel.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Full-body harness where required • High-visibility clothing.',
      checklist:
          'Foundation stable • Uprights/bracing secure • Guardrails • Toe boards • Platform condition • Safe access • Load capacity • Inspection status • Weather condition • Unauthorized alterations checked.',
      inspection:
          'Check foundation and stability • Bracing and connections • Platforms • Guardrails and toe boards • Access ladders or stairs • Signs/tags • Visible damage • Unauthorized alterations.',
      dos:
          'Use approved access. Report defects immediately. Keep platforms tidy. Respect scaffold loading limits.',
      donts:
          'Do not remove guardrails or braces without authorization. Do not use incomplete or damaged scaffolding. Do not overload platforms.',
      stopWork:
          'Stop scaffold use if it is incomplete, unstable, damaged, overloaded, missing required protection or has been altered without authorization.',
      emergency:
          'Stop use, isolate the affected scaffold and prevent access. If a fall occurs, activate the site emergency and rescue procedure.',
    ),
    _ReferenceTopic(
      title: 'Working at Height',
      shortDescription:
          'Prevent falls through planning, safe access, edge protection and fall protection.',
      overview:
          'Working at height means working where a person could fall and suffer injury. The preferred approach is to avoid work at height where reasonably possible and then control remaining risks.',
      hazards:
          'Falls • Falling objects • Open edges • Floor openings • Unsafe ladders • Poor platforms • Incorrect harness use • Rescue difficulties.',
      controls:
          'Avoid height work where possible • Safe platform • Guardrails • Edge protection • Proper access • Fall restraint/arrest where required • Equipment inspection • Rescue planning.',
      planning:
          'Determine whether the task can be completed from ground level. Select a suitable platform or access system. Assess edges, openings, falling objects, weather and rescue requirements before starting.',
      safePractices:
          'Use a suitable working platform rather than improvised access. Protect edges and openings. Inspect fall-protection equipment. Ensure workers understand the system and rescue arrangements.',
      ppe:
          'Safety helmet with chin strap where required • Safety footwear • Full-body harness where required • Gloves • Eye protection.',
      checklist:
          'Risk assessment • Safe access • Platform • Edge protection • Openings protected • Harness inspected • Anchorage suitable • Falling-object controls • Rescue plan • Competent workers.',
      inspection:
          'Check working platform • Guardrails and edge protection • Floor openings • Ladder/access condition • Harness and lanyard • Anchorage • Tool securing • Rescue equipment.',
      dos:
          'Plan before starting. Maintain three-point contact on ladders where applicable. Keep tools secured. Use fall protection according to the approved system.',
      donts:
          'Do not work from unstable surfaces. Do not use damaged harnesses. Do not attach to unsuitable anchor points. Do not remove edge protection without authorization.',
      stopWork:
          'Stop work if edge protection is missing, access is unsafe, fall protection is defective, anchorage is unsuitable or weather creates unsafe conditions.',
      emergency:
          'Activate the rescue plan immediately. Do not create a second casualty by attempting an uncontrolled rescue. Provide first aid and medical response.',
    ),
    _ReferenceTopic(
      title: 'Power Tools',
      shortDescription:
          'Use portable power tools safely through inspection, guarding, correct accessories and PPE.',
      overview:
          'Power tools can cause cuts, crushing, electric shock, burns, flying particles, noise and vibration injuries. Safe use depends on correct tool selection, condition and operator competence.',
      hazards:
          'Cuts • Flying particles • Electric shock • Burns • Entanglement • Noise • Vibration • Incorrect accessories.',
      controls:
          'Correct tool selection • Pre-use inspection • Guards • Electrical protection • Correct accessories • Preventive maintenance • Competent operators • Good housekeeping.',
      planning:
          'Select the correct tool for the task and material. Review manufacturer instructions. Check electrical supply and protection requirements. Assess dust, noise, vibration, sparks and nearby workers before starting.',
      safePractices:
          'Inspect tools before use. Use the correct accessory and guard. Keep cables protected. Disconnect power before changing accessories. Maintain a stable working position.',
      ppe:
          'Safety glasses or face protection • Safety footwear • Hearing protection • Gloves where appropriate • Safety helmet • Task-specific PPE.',
      checklist:
          'Tool condition • Guard • Cable/plug • Correct accessory • Electrical protection • Operator competence • PPE • Work area • Maintenance status.',
      inspection:
          'Check body and casing • Guards • Switches • Cable and plug • Accessories • Labels • Electrical protection • Signs of overheating or damage.',
      dos:
          'Use tools according to manufacturer instructions. Keep guards fitted. Remove defective tools from service.',
      donts:
          'Do not use damaged tools. Do not remove guards. Do not carry tools by cables. Do not use unsuitable accessories.',
      stopWork:
          'Stop using the tool if the guard, cable, plug, switch or accessory is damaged or if abnormal vibration, noise, overheating or sparking occurs.',
      emergency:
          'Isolate the energy source, provide first aid and obtain medical assistance for serious injury. Report defective equipment and preserve it for investigation where required.',
    ),
    _ReferenceTopic(
      title: 'Formwork',
      shortDescription:
          'Control formwork stability during erection, concrete placement and stripping.',
      overview:
          'Formwork supports concrete until the structure reaches the required condition. Failure can cause collapse, falling materials and serious injury. Design, erection, inspection and controlled loading are essential.',
      hazards:
          'Collapse • Structural instability • Falls • Falling materials • Overloading • Incorrect stripping • Concrete pressure.',
      controls:
          'Approved design • Competent erection • Stable supports • Correct bracing • Inspection • Load control • Controlled concrete placement • Safe stripping sequence.',
      planning:
          'Review the approved design and loading requirements. Confirm foundations, supports, bracing and access. Plan concrete placement sequence and controlled stripping. Establish an exclusion zone where necessary.',
      safePractices:
          'Follow the approved formwork design. Inspect before concrete placement. Control concrete pouring rate and sequence. Do not remove supports prematurely.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Eye protection • High-visibility clothing • Fall protection where required.',
      checklist:
          'Approved design • Foundation/support • Bracing • Connections • Alignment • Access • Inspection • Load/pressure control • Concrete placement plan • Stripping approval.',
      inspection:
          'Check supports • Bracing • Connections • Alignment • Base conditions • Platform/access • Signs of movement • Damage • Loading condition.',
      dos:
          'Follow engineering requirements. Inspect before loading. Maintain safe access and exclusion zones.',
      donts:
          'Do not modify designed supports without authorization. Do not overload. Do not strip formwork before approval.',
      stopWork:
          'Stop work if movement, instability, damaged supports, missing bracing or unexpected loading is observed.',
      emergency:
          'Stop work and evacuate the danger zone if instability is suspected. Do not approach a potentially collapsing structure until competent personnel make the area safe.',
    ),
    _ReferenceTopic(
      title: 'Permit to Work',
      shortDescription:
          'Control high-risk work through formal authorization, isolation and verification.',
      overview:
          'A Permit to Work system provides a controlled process for authorizing specified high-risk activities. It identifies hazards, precautions, responsibilities and conditions that must be satisfied before work starts.',
      hazards:
          'Uncontrolled energy • Fire • Toxic atmosphere • Simultaneous activities • Incorrect isolation • Unauthorized work • Poor communication.',
      controls:
          'Task identification • Risk assessment • Isolation • Permit authorization • Precautions • Toolbox talk • Worksite verification • Permit suspension/extension controls • Close-out.',
      planning:
          'Identify the exact task, location, equipment and hazards. Confirm required isolations and precautions. Ensure the permit issuer, performing authority and workers understand their responsibilities.',
      safePractices:
          'Verify that the permit matches the actual task and location. Confirm isolations before work. Ensure workers understand permit conditions. Suspend the permit if conditions change.',
      ppe:
          'PPE must be selected according to the permitted activity and risk assessment.',
      checklist:
          'Correct permit • Risk assessment • Method statement • Isolation • Gas testing where required • Precautions • Authorization • Toolbox talk • Site verification • Close-out.',
      inspection:
          'Check permit validity • Correct location • Correct task • Isolation status • Gas test where required • Barriers • PPE • Toolbox briefing • Permit display/control.',
      dos:
          'Follow permit conditions. Stop work when conditions change. Close the permit correctly after completion.',
      donts:
          'Do not work outside permit boundaries. Do not bypass isolation. Do not assume an expired or suspended permit remains valid.',
      stopWork:
          'Stop work if the permit is expired, suspended, incorrect, conditions have changed, isolation is uncertain or required precautions are missing.',
      emergency:
          'Stop work, raise the alarm and follow the emergency procedure. The permit must be reviewed before work resumes.',
    ),
    _ReferenceTopic(
      title: 'Working in Hot & Humid Climate',
      shortDescription:
          'Prevent heat-related illness through hydration, rest, shade, planning and worker awareness.',
      overview:
          'Hot and humid conditions can increase heat strain and reduce worker performance. Effective heat-stress management requires work planning, hydration, rest, shade or cooling, acclimatization and monitoring.',
      hazards:
          'Heat exhaustion • Heat stroke • Dehydration • Fatigue • Reduced concentration • Increased incident risk.',
      controls:
          'Hydration • Rest/cooling • Shade • Work scheduling • Acclimatization • Heat-stress awareness • Buddy monitoring • Emergency response.',
      planning:
          'Consider environmental conditions before assigning work. Plan demanding activities appropriately. Provide water, suitable rest/cooling arrangements and worker awareness. Identify workers who may require additional supervision.',
      safePractices:
          'Provide suitable drinking water and cooling arrangements. Schedule demanding work appropriately. Monitor workers for symptoms. Encourage early reporting of discomfort.',
      ppe:
          'Suitable work clothing • Safety helmet • Safety footwear • Task-specific PPE. PPE selection must also consider heat burden.',
      checklist:
          'Heat plan • Drinking water • Rest/shade • Work/rest arrangement • Acclimatization • Worker awareness • Supervision • Symptoms monitoring • Emergency arrangements.',
      inspection:
          'Check drinking water availability • Rest and shade facilities • Heat-stress communication • Worker condition • Work scheduling • Emergency arrangements.',
      dos:
          'Drink water regularly. Take planned recovery breaks. Report symptoms early. Follow the site heat-stress management plan.',
      donts:
          'Do not ignore symptoms. Do not rely on PPE alone to control heat stress. Do not allow workers to continue unsafe work when heat-related illness is suspected.',
      stopWork:
          'Stop or modify the task when workers show signs of heat illness, cooling arrangements are inadequate or environmental conditions exceed the site control limits.',
      emergency:
          'Treat suspected serious heat illness as an emergency. Stop work, move the person to a cooler safe area and activate medical or emergency response according to the site procedure.',
    ),
    _ReferenceTopic(
      title: 'Confined Space',
      shortDescription:
          'Control atmospheric, engulfment, access and rescue hazards in confined spaces.',
      overview:
          'Confined spaces may contain hazardous atmospheres, limited access, engulfment hazards or other conditions that can make rescue difficult. Entry must be planned and controlled.',
      hazards:
          'Oxygen deficiency or enrichment • Toxic gases • Flammable atmosphere • Engulfment • Heat • Restricted movement • Difficult rescue.',
      controls:
          'Permit • Isolation • Atmospheric testing • Ventilation • Communication • Attendant • Safe access • Rescue plan • Competent workers.',
      planning:
          'Determine whether entry can be avoided. Identify atmospheric, energy, material and physical hazards. Establish isolation, testing, ventilation, communication, attendant and rescue arrangements before entry.',
      safePractices:
          'Test the atmosphere using suitable equipment before and during entry as required. Isolate hazardous energy and material sources. Maintain communication and an effective rescue arrangement.',
      ppe:
          'Safety helmet • Safety footwear • Gloves • Eye protection • Respiratory protection where required • Harness where required.',
      checklist:
          'Permit • Isolation • Gas test • Ventilation • Attendant • Communication • Rescue equipment • Emergency plan • Competent entrants • Continuous monitoring where required.',
      inspection:
          'Check permit • Isolation • Gas-testing equipment • Ventilation • Access • Communication • Rescue equipment • Attendant position • Entry conditions.',
      dos:
          'Follow the permit. Maintain communication. Stop entry if conditions change. Keep rescue equipment ready.',
      donts:
          'Never enter an unsafe confined space to rescue someone without proper protection and rescue capability. Do not bypass atmospheric testing or isolation requirements.',
      stopWork:
          'Stop entry immediately if atmospheric conditions become unsafe, ventilation fails, communication is lost, isolation is uncertain or the rescue arrangement is unavailable.',
      emergency:
          'Raise the alarm and activate the approved rescue plan. Do not make an unprotected entry to rescue a casualty.',
    ),
    _ReferenceTopic(
      title: 'Working Near Live Road',
      shortDescription:
          'Protect workers and road users through traffic management, segregation and controlled work zones.',
      overview:
          'Work near live roads creates interaction between workers, vehicles and public traffic. A properly planned traffic management arrangement is essential.',
      hazards:
          'Vehicle strike • Reversing • Poor visibility • Unauthorized access • Night work • Traffic congestion • Falling objects into roadways.',
      controls:
          'Traffic management plan • Barriers • Signs • Cones • Safe pedestrian routes • Trained traffic controllers • High visibility • Lighting • Speed control.',
      planning:
          'Review the approved traffic management arrangement. Identify pedestrian and vehicle movements. Plan barriers, signs, lighting, access points and traffic-controller positions before work begins.',
      safePractices:
          'Separate pedestrians from traffic wherever possible. Maintain clear signs and barriers. Ensure traffic controllers understand the approved arrangement. Keep work zones tidy and visible.',
      ppe:
          'High-visibility clothing • Safety footwear • Safety helmet • Eye protection • Task-specific PPE.',
      checklist:
          'Approved traffic plan • Signs • Barriers • Lighting • Pedestrian route • Vehicle route • Traffic controller • High-visibility PPE • Inspection.',
      inspection:
          'Check signs • Barriers • Cones • Lighting • Pedestrian segregation • Vehicle routes • Work-zone visibility • Damaged traffic controls.',
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
      title: 'Concreting',
      shortDescription:
          'Control hazards from concrete delivery, pumping, placing, vibration and finishing.',
      overview:
          'Concrete work involves heavy equipment, moving vehicles, pumps, pressure, wet cement and work at height. Good planning and communication are essential.',
      hazards:
          'Concrete burns • Pump hose movement • Vehicle movement • Crushing • Falls • Struck-by incidents • Eye injury • Dust exposure during certain activities.',
      controls:
          'Concrete placement plan • Equipment inspection • Exclusion zone • Hose control • Safe access • Communication • Skin and eye protection • Good housekeeping.',
      planning:
          'Plan delivery routes, pump location, hose movement, placing sequence and access. Confirm formwork readiness and establish communication between pump operator and placing team.',
      safePractices:
          'Inspect pumps and hoses. Keep personnel away from uncontrolled hose movement. Protect workers from wet concrete contact. Maintain safe access around reinforcement and formwork.',
      ppe:
          'Safety helmet • Safety footwear • Suitable gloves • Eye protection • Protective clothing • Task-specific PPE.',
      checklist:
          'Pump inspection • Hose condition • Exclusion zone • Communication • Access • Formwork inspection • PPE • Wash facilities • Emergency arrangements.',
      inspection:
          'Check pump and hoses • Connections • Formwork • Access • Exclusion zone • Communication • PPE • Wash facilities • Vehicle movement.',
      dos:
          'Follow the concrete placement sequence. Wash exposed skin promptly. Maintain communication between pump operator and placing team.',
      donts:
          'Do not stand in front of an uncontrolled hose. Do not work around unstable formwork. Do not ignore cement contact with skin or eyes.',
      stopWork:
          'Stop concreting if formwork becomes unstable, hose movement is uncontrolled, communication is lost or the exclusion zone cannot be maintained.',
      emergency:
          'For cement contact, follow site first-aid arrangements and appropriate washing procedures. For serious injury, activate emergency medical response.',
    ),
    _ReferenceTopic(
      title: 'Barricading of Hazards',
      shortDescription:
          'Prevent unauthorized access to hazardous areas using suitable barriers, signs and controls.',
      overview:
          'Barricading is used to separate people from hazards such as excavations, openings, lifting zones, electrical hazards and demolition areas. The barrier must match the hazard and remain effective.',
      hazards:
          'Falls • Unauthorized entry • Struck-by incidents • Electrical contact • Vehicle interaction • Falling objects.',
      controls:
          'Identify hazard • Select suitable barrier • Warning signs • Controlled access • Visibility • Inspection • Maintain safe distance • Lighting where required.',
      planning:
          'Identify the hazard and determine the level of protection required. Select a suitable barrier and warning sign. Consider pedestrian movement, emergency access and night visibility.',
      safePractices:
          'Use a clear and stable barrier. Place warning signs where people can see them before entering the danger area. Inspect barricades after work changes, weather or impact.',
      ppe:
          'PPE depends on the hazard inside the barricaded area.',
      checklist:
          'Hazard identified • Barrier suitable • Stable • Visible • Warning sign • Access controlled • Safe distance • Night visibility • Regular inspection.',
      inspection:
          'Check barrier stability • Visibility • Warning signs • Safe distance • Access control • Damage • Lighting • Uncontrolled gaps.',
      dos:
          'Maintain barricades until the hazard is removed or controlled. Report damaged barriers immediately.',
      donts:
          'Do not use weak or unclear barriers for serious hazards. Do not remove barricades without authorization.',
      stopWork:
          'Stop the affected activity if the barrier is missing, damaged, unclear, unstable or allows unauthorized access to a serious hazard.',
      emergency:
          'Keep people away from the danger zone and activate the relevant emergency response procedure.',
    ),
    _ReferenceTopic(
      title: 'Worker Welfare',
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
    _ReferenceTopic(
      title: 'Mobile Elevated Working Platform (MEWP)',
      shortDescription:
          'Operate MEWPs safely through competent operators, inspections, ground assessment and fall protection.',
      overview:
          'MEWPs provide temporary elevated access. Risks include overturning, falls, crushing, collision and contact with overhead hazards. Only trained and authorized operators should operate the equipment.',
      hazards:
          'Falls • Overturning • Crushing • Collision • Overhead electrical hazards • Uneven ground • Falling objects.',
      controls:
          'Competent operator • Pre-use inspection • Ground assessment • Safe operating zone • Guardrails • Fall protection where required • Overhead hazard control • Emergency lowering/rescue plan.',
      planning:
          'Select the correct MEWP for height, reach and load. Assess ground conditions, overhead hazards, traffic, weather and emergency lowering arrangements before operation.',
      safePractices:
          'Follow manufacturer instructions and site rules. Check ground conditions. Maintain safe clearance from overhead hazards. Keep gates closed and do not climb on guardrails.',
      ppe:
          'Safety helmet • Safety footwear • High-visibility clothing • Harness/lanyard where required by the MEWP/system and risk assessment.',
      checklist:
          'Operator authorization • Pre-use inspection • Ground condition • Guardrails • Emergency controls • Battery/fuel • Tires/outriggers • Overhead hazards • Weather • Rescue plan.',
      inspection:
          'Check tires/outriggers • Controls • Emergency lowering • Guardrails • Gates • Hydraulic systems • Alarms • Battery/fuel • Ground conditions.',
      dos:
          'Use the correct MEWP for the task. Keep within rated capacity. Use emergency controls only as intended.',
      donts:
          'Do not exceed capacity. Do not use unstable ground without suitable controls. Do not climb guardrails. Do not operate with known defects.',
      stopWork:
          'Stop operation for equipment defects, unstable ground, excessive weather conditions, overhead hazards, overload or failure of emergency controls.',
      emergency:
          'Stop operation and use the approved emergency lowering or rescue procedure. Call emergency services when necessary.',
    ),
    _ReferenceTopic(
      title: 'Electricity on Site & Electrical Tools',
      shortDescription:
          'Prevent electric shock, burns and electrical fires through isolation, inspection and suitable protection.',
      overview:
          'Construction sites contain temporary electrical systems, portable tools, cables and distribution equipment. Electrical work must be controlled by competent persons and suitable protection systems.',
      hazards:
          'Electric shock • Burns • Arc flash • Fire • Damaged cables • Wet conditions • Incorrect connections • Unauthorized electrical work.',
      controls:
          'Competent persons • Isolation • Inspection • Earthing/grounding • Suitable protective devices • Cable protection • Lockout where applicable • Environmental protection.',
      planning:
          'Identify electrical sources and equipment before work. Plan isolation, protection, cable routing, temporary power arrangements and access. Electrical work should be performed by appropriately competent persons.',
      safePractices:
          'Inspect cables, plugs and tools before use. Keep electrical equipment protected from water and physical damage. Use suitable distribution equipment and protective devices. Isolate before maintenance.',
      ppe:
          'Safety footwear • Eye/face protection • Electrical-rated PPE where required • Arc-flash PPE where applicable.',
      checklist:
          'Competent electrician • Distribution board condition • Protection devices • Earthing • Cable routing • Tool inspection • Plugs • Wet-area controls • Isolation arrangements.',
      inspection:
          'Check cables • Plugs • Sockets • Distribution boards • Protective devices • Earthing • Physical protection • Water exposure • Signs of damage.',
      dos:
          'Report damaged electrical equipment immediately. Use only approved equipment. Keep connections protected.',
      donts:
          'Do not use damaged cables. Do not perform unauthorized electrical work. Do not bypass protective devices.',
      stopWork:
          'Stop electrical work if isolation is uncertain, equipment is damaged, protective devices are bypassed or unsafe environmental conditions exist.',
      emergency:
          'Do not touch a person who may still be electrically energized. Isolate the power source safely, call emergency assistance and provide first aid or CPR when safe and competent to do so.',
    ),
    _ReferenceTopic(
      title: 'Temporary Works',
      shortDescription:
          'Plan, design, install, inspect and control temporary structures and support systems.',
      overview:
          'Temporary works include structures or systems required temporarily during construction, such as temporary supports, access systems, formwork and other temporary arrangements. Failure can have serious consequences.',
      hazards:
          'Collapse • Overloading • Instability • Falls • Falling materials • Incorrect installation • Unauthorized modification.',
      controls:
          'Design • Approval • Competent supervision • Installation inspection • Load control • Monitoring • Change control • Safe removal.',
      planning:
          'Identify the temporary works and its intended function. Confirm design requirements, loads, support conditions, installation sequence, inspection requirements and removal arrangements.',
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
          'Do not modify temporary works without approval. Do not exceed design loading. Do not remove supports prematurely.',
      stopWork:
          'Stop work if temporary works show movement, instability, damage, overload or unauthorized modification.',
      emergency:
          'Evacuate the danger zone if instability is suspected. Prevent access until competent technical personnel confirm the area is safe.',
    ),
    _ReferenceTopic(
      title: 'Manual Handling',
      shortDescription:
          'Reduce musculoskeletal injuries through task assessment, mechanical aids and safe handling techniques.',
      overview:
          'Manual handling includes lifting, carrying, pushing and pulling. The best control is to avoid unnecessary manual handling and use mechanical assistance where reasonably practicable.',
      hazards:
          'Back injuries • Muscle strains • Crush injuries • Dropped loads • Awkward posture • Repetitive strain.',
      controls:
          'Avoid • Mechanical aids • Reduce load • Improve work height • Team handling • Good technique • Training • Task rotation where appropriate.',
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
      title: 'Hot Works',
      shortDescription:
          'Control welding, cutting, grinding and other activities that produce heat, flames or sparks.',
      overview:
          'Hot work can start fires or explosions and can cause burns, eye injuries, fumes and other hazards. It requires careful planning, combustible control, suitable PPE and fire protection.',
      hazards:
          'Fire • Explosion • Burns • Sparks • Fumes • Eye injury • Gas cylinder hazards • Heat.',
      controls:
          'Hot work permit where required • Remove or protect combustibles • Fire extinguisher • Fire watch • Gas cylinder control • Screens • Ventilation • Post-work inspection.',
      planning:
          'Identify combustible materials and nearby operations. Confirm the required permit. Establish fire protection, gas-cylinder controls, ventilation, screens and post-work monitoring before starting.',
      safePractices:
          'Inspect the work area before starting. Remove combustible materials or protect them effectively. Maintain suitable fire protection. Control gas cylinders and hoses. Check the area after completion.',
      ppe:
          'Welding helmet/goggles • Welding gloves • Flame-resistant clothing • Safety footwear • Face shield where required • Eye protection.',
      checklist:
          'Permit • Combustibles removed/protected • Fire extinguisher • Fire watch • Cylinders secured • Hoses/regulators • Screens • Ventilation • Post-work inspection.',
      inspection:
          'Check combustibles • Fire extinguisher • Welding leads • Gas cylinders • Hoses • Regulators • Screens • Ventilation • Fire-watch arrangements.',
      dos:
          'Maintain fire watch as required. Keep cylinders secured. Use correct PPE. Inspect the area after hot work.',
      donts:
          'Do not perform hot work near uncontrolled combustibles. Do not use damaged hoses or regulators. Do not leave hot work areas without required fire controls.',
      stopWork:
          'Stop hot work if combustible materials cannot be controlled, fire protection is unavailable, gas equipment is defective, ventilation is inadequate or the permit conditions are not satisfied.',
      emergency:
          'Stop work, raise the alarm and use appropriate fire-response equipment only if trained and it is safe to do so. Evacuate and call emergency services for uncontrolled fires.',
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
          const SizedBox(height: 18),
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
                  'Learn practical HSE controls, safe work practices and inspection points for UAE workplaces.',
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

            _infoCard(
              icon: Icons.info_outline_rounded,
              title: 'Important UAE HSE Reference Note',
              content:
                  'This page is intended for HSE learning and practical workplace reference. It does not replace applicable UAE legislation, regulator requirements, approved Codes of Practice, standards, risk assessments, method statements, permits or project procedures. Requirements can vary by emirate, activity and project. Always verify the latest applicable official requirement before making a compliance decision.',
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
                  topic.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'UAE HSE Learning & Reference',
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

  const _ReferenceTopic({
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
  });
}
