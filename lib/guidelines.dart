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
    // ============================================================
    // UAE GENERAL
    // ============================================================

    ReferenceTopic(
      title: 'Work at Height',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE General Reference',
      copNumber: 'Work at Height',
      version: 'Current Reference',
      effectiveDate: 'Verify applicable authority requirement',
      shortDescription:
          'Safe planning and control of work where a person could fall and suffer injury.',
      overview:
          'Work at height includes any work activity where a person could fall from one level to another and be injured. The safest approach is to eliminate work at height where reasonably practicable. Where work at height is necessary, suitable access systems, collective protection and fall-protection arrangements must be planned before work starts.',
      hazards:
          'Falls from open edges\n'
          'Falls through openings\n'
          'Falls from ladders or temporary access\n'
          'Falling tools and materials\n'
          'Failure or incorrect use of fall-protection equipment\n'
          'Unsafe weather conditions',
      controls:
          'Eliminate work at height where reasonably practicable.\n'
          'Use suitable working platforms and collective edge protection.\n'
          'Protect floor and wall openings.\n'
          'Use suitable restraint or fall-arrest systems where required.\n'
          'Control falling objects and establish exclusion zones.\n'
          'Ensure workers are competent and appropriately supervised.',
      planning:
          'Complete the risk assessment and method statement before starting. Confirm access arrangements, edge protection, anchor points, equipment inspection, weather conditions, worker competency and emergency rescue arrangements.',
      safePractices:
          'Use designated access systems. Maintain three points of contact on ladders where appropriate. Keep platforms clear. Never remove guardrails or other protection without an approved control and suitable alternative protection.',
      ppe:
          'Safety helmet, safety footwear and task-specific PPE. Full-body harness, lanyard or other fall-protection equipment must be selected according to the approved system and risk assessment.',
      checklist:
          'Risk assessment and method statement approved\n'
          'Safe access provided\n'
          'Edge protection installed\n'
          'Openings protected\n'
          'Fall-protection equipment inspected\n'
          'Anchor arrangements verified\n'
          'Rescue plan available',
      inspection:
          'Inspect access systems, platforms, guardrails, toe boards, ladders, anchor points, harnesses, lanyards and surrounding work areas before use.',
      dos:
          'Use the safest practical access method and follow the approved work-at-height procedure.',
      donts:
          'Do not work from improvised platforms or remove edge protection without authorisation.',
      stopWork:
          'Stop work when access is defective, edge protection is missing, fall-protection equipment is damaged, weather creates unacceptable risk or rescue arrangements are unavailable.',
      emergency:
          'Raise the alarm and activate the approved rescue plan. Prevent secondary falls and do not create additional risk during rescue activities.',
      malayalam:
          'ഉയരത്തിൽ ജോലി തുടങ്ങുന്നതിന് മുമ്പ് safe access, edge protection, fall protection, equipment inspection, rescue plan എന്നിവ ഉറപ്പാക്കണം. Improvised platform ഉപയോഗിക്കരുത്.',
    ),

    ReferenceTopic(
      title: 'Scaffolding Safety',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE General Reference',
      copNumber: 'Scaffolding Safety',
      version: 'Current Reference',
      effectiveDate: 'Verify applicable authority requirement',
      shortDescription:
          'Safe erection, inspection, modification, use and dismantling of scaffolding.',
      overview:
          'Scaffolding provides temporary access and working platforms. It must be properly designed where required, erected by competent persons, inspected and maintained throughout its use. Scaffold stability, access, loading and edge protection are critical controls.',
      hazards:
          'Scaffold collapse\n'
          'Falls from platforms\n'
          'Falling materials\n'
          'Unsafe access\n'
          'Overloading\n'
          'Unauthorised alteration',
      controls:
          'Use competent scaffolders.\n'
          'Provide stable foundations and adequate bracing.\n'
          'Provide guardrails, midrails and toe boards where required.\n'
          'Provide safe access and egress.\n'
          'Control scaffold loading.\n'
          'Prevent unauthorised modification.',
      planning:
          'Assess ground conditions, scaffold configuration, loading requirements, access, proximity to electrical hazards and environmental conditions before erection.',
      safePractices:
          'Keep platforms clean and unobstructed. Follow the approved scaffold configuration. Do not remove ties, braces, guardrails or other components without authorisation.',
      ppe:
          'Safety helmet, safety footwear, gloves and task-specific fall-protection equipment where required during erection, alteration or dismantling.',
      checklist:
          'Foundation stable\n'
          'Standards and braces installed correctly\n'
          'Platforms complete and secure\n'
          'Guardrails and toe boards provided\n'
          'Safe access provided\n'
          'Inspection status available\n'
          'No unauthorised alteration',
      inspection:
          'Check foundations, standards, braces, ties, platforms, guardrails, toe boards, access systems, loading condition and signs of damage or alteration.',
      dos:
          'Use only inspected and approved scaffolding and follow the approved configuration.',
      donts:
          'Do not use incomplete, damaged or unsafe scaffolding. Do not climb outside designated access.',
      stopWork:
          'Stop work if the scaffold is unstable, damaged, incomplete, overloaded or has been altered without approval.',
      emergency:
          'Prevent further access to the affected scaffold, isolate the area and activate the site emergency procedure.',
      malayalam:
          'Scaffold ഉപയോഗിക്കുന്നതിന് മുമ്പ് foundation, bracing, platform, guardrail, toe board, safe access, inspection എന്നിവ പരിശോധിക്കണം.',
    ),

    ReferenceTopic(
      title: 'Lifting Operations',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE General Reference',
      copNumber: 'Lifting Operations',
      version: 'Current Reference',
      effectiveDate: 'Verify applicable authority requirement',
      shortDescription:
          'Planning and safe execution of crane, rigging and lifting operations.',
      overview:
          'Lifting operations require competent planning, suitable lifting equipment, competent operators and riggers, verified load information and effective communication. The lifting area must be controlled to prevent people entering danger zones.',
      hazards:
          'Dropped loads\n'
          'Crane overturning\n'
          'Load swing\n'
          'Failure of lifting accessories\n'
          'Unstable ground\n'
          'People entering the lifting zone',
      controls:
          'Prepare an appropriate lifting plan.\n'
          'Confirm load weight and centre of gravity.\n'
          'Verify crane capacity and configuration.\n'
          'Inspect lifting accessories before use.\n'
          'Use competent lifting personnel.\n'
          'Establish and control exclusion zones.',
      planning:
          'Confirm load weight, lifting points, crane capacity, ground bearing conditions, weather, overhead hazards, communication method and landing area.',
      safePractices:
          'Use certified and suitable lifting accessories. Maintain clear communication. Keep people away from suspended loads and never exceed equipment capacity.',
      ppe:
          'Safety helmet, safety footwear, gloves, high-visibility clothing and task-specific PPE.',
      checklist:
          'Lifting plan approved\n'
          'Crane/equipment inspection valid\n'
          'Lifting accessories inspected\n'
          'Load weight confirmed\n'
          'Ground condition verified\n'
          'Exclusion zone established\n'
          'Competent lifting team available',
      inspection:
          'Inspect crane condition, hooks, shackles, slings, lifting points, ground conditions, outriggers and exclusion zone.',
      dos:
          'Follow the lifting plan and maintain effective communication between operator, rigger and signaler.',
      donts:
          'Never stand or work under a suspended load. Never exceed rated capacity.',
      stopWork:
          'Stop lifting if equipment defects, unstable ground, poor visibility, unsafe weather or communication failure occurs.',
      emergency:
          'Stop the operation, secure the load where possible and keep personnel outside the danger zone while the emergency procedure is activated.',
      malayalam:
          'Lifting operation-ന് മുമ്പ് lifting plan, load weight, crane capacity, accessories, ground condition, communication, exclusion zone എന്നിവ പരിശോധിക്കണം.',
    ),

    ReferenceTopic(
      title: 'Excavation & Trenching',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE General Reference',
      copNumber: 'Excavation Safety',
      version: 'Current Reference',
      effectiveDate: 'Verify applicable authority requirement',
      shortDescription:
          'Controls for excavation, trenching and underground work.',
      overview:
          'Excavation work can expose workers to collapse, underground utilities, falls, flooding, hazardous atmospheres and plant movement. Excavation must be planned and protected according to ground conditions and identified hazards.',
      hazards:
          'Cave-in or collapse\n'
          'Underground utilities\n'
          'Falls into excavation\n'
          'Water ingress\n'
          'Hazardous atmosphere\n'
          'Plant or vehicle movement',
      controls:
          'Identify underground services before excavation.\n'
          'Provide suitable shoring, shielding or safe battering where required.\n'
          'Provide safe access and egress.\n'
          'Protect excavation edges.\n'
          'Control plant and materials near edges.\n'
          'Inspect excavations regularly.',
      planning:
          'Review drawings, service information, ground conditions, excavation depth, access, protection method, plant movement and emergency arrangements.',
      safePractices:
          'Keep spoil and equipment away from unsafe edge areas. Inspect after significant changes, rain, vibration or other adverse conditions.',
      ppe:
          'Safety helmet, safety footwear, gloves, high-visibility clothing and task-specific PPE.',
      checklist:
          'Underground services identified\n'
          'Excavation protection provided\n'
          'Safe access provided\n'
          'Edges protected\n'
          'Spoil controlled\n'
          'Inspection completed',
      inspection:
          'Check excavation walls, protection systems, access, water accumulation, edge condition, spoil placement and signs of ground movement.',
      dos:
          'Follow the approved excavation method and maintain protective systems.',
      donts:
          'Do not enter an unsupported or unstable excavation where protection is required.',
      stopWork:
          'Stop work if ground movement, water ingress, unidentified services, unsafe access or structural instability is identified.',
      emergency:
          'Keep personnel away from a collapsed or unstable excavation and activate emergency response. Do not enter for an unplanned rescue.',
      malayalam:
          'Excavation തുടങ്ങുന്നതിന് മുമ്പ് underground services കണ്ടെത്തണം. ആവശ്യമായ shoring അല്ലെങ്കിൽ മറ്റ് protection, safe access, edge protection എന്നിവ ഉറപ്പാക്കണം.',
    ),

    ReferenceTopic(
      title: 'Electrical Safety',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE General Reference',
      copNumber: 'Electrical Safety',
      version: 'Current Reference',
      effectiveDate: 'Verify applicable authority requirement',
      shortDescription:
          'Prevention of electric shock, arc flash, fire and electrical incidents.',
      overview:
          'Electrical hazards can cause fatal shock, burns, arc flash and fire. Electrical work must be planned and performed by competent and authorised persons using suitable equipment and isolation arrangements.',
      hazards:
          'Electric shock\n'
          'Arc flash\n'
          'Electrical fire\n'
          'Damaged cables and equipment\n'
          'Overhead electrical services\n'
          'Underground electrical services',
      controls:
          'Isolate energy where practicable.\n'
          'Use suitable protective devices.\n'
          'Inspect cables and equipment.\n'
          'Protect temporary electrical systems.\n'
          'Maintain safe distances from electrical services.\n'
          'Restrict electrical work to authorised competent persons.',
      planning:
          'Identify electrical sources and services before work. Confirm isolation, permits, competent personnel and emergency arrangements.',
      safePractices:
          'Keep electrical equipment protected from water and physical damage. Report defective cables, plugs, sockets and equipment immediately.',
      ppe:
          'Task-specific electrical PPE as determined by the risk assessment and authorised electrical procedure.',
      checklist:
          'Isolation confirmed\n'
          'Equipment inspected\n'
          'Cables protected\n'
          'Distribution boards protected\n'
          'Competent person assigned',
      inspection:
          'Inspect cables, plugs, sockets, distribution boards, protective devices and temporary installations.',
      dos:
          'Use approved electrical equipment and follow the authorised isolation procedure.',
      donts:
          'Do not perform unauthorised electrical work or use damaged electrical equipment.',
      stopWork:
          'Stop work if isolation is uncertain, equipment is damaged or an unsafe electrical condition exists.',
      emergency:
          'Do not touch a person who may still be energised. Isolate the source if safe and activate emergency response.',
      malayalam:
          'Electrical work competent ആയ authorised persons മാത്രം ചെയ്യണം. Damaged cable/equipment ഉപയോഗിക്കരുത്. Isolation ഉറപ്പാക്കാതെ work ആരംഭിക്കരുത്.',
    ),

    ReferenceTopic(
      title: 'Heat Stress Management',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE General Reference',
      copNumber: 'Heat Stress Management',
      version: 'Current Reference',
      effectiveDate: 'Verify current seasonal requirements',
      shortDescription:
          'Prevention and response to heat stress in hot working environments.',
      overview:
          'Heat exposure can cause dehydration, heat cramps, heat exhaustion and life-threatening heat stroke. Effective heat-stress management combines work planning, hydration, rest, shade or cooling, acclimatisation, training and supervision.',
      hazards:
          'Dehydration\n'
          'Heat cramps\n'
          'Heat exhaustion\n'
          'Heat stroke\n'
          'Fatigue and reduced concentration',
      controls:
          'Provide drinking water.\n'
          'Provide suitable shaded or cooled rest areas.\n'
          'Plan work according to heat conditions.\n'
          'Provide worker awareness and supervision.\n'
          'Monitor workers for symptoms.',
      planning:
          'Consider weather, work intensity, PPE burden, worker acclimatisation, hydration, rest arrangements and emergency response.',
      safePractices:
          'Drink water regularly, take scheduled rest periods and report symptoms early. Supervisors should pay particular attention to new or unacclimatised workers.',
      ppe:
          'Task-appropriate protective clothing, safety helmet, safety footwear and required PPE while considering heat exposure.',
      checklist:
          'Water available\n'
          'Rest/shade area available\n'
          'Weather conditions reviewed\n'
          'Workers briefed\n'
          'Emergency arrangements available',
      inspection:
          'Check water availability, shade/rest facilities, work scheduling, worker condition and emergency communication.',
      dos:
          'Drink water regularly and report dizziness, weakness, confusion or other symptoms immediately.',
      donts:
          'Do not ignore heat-stress symptoms or continue unsafe work because of production pressure.',
      stopWork:
          'Stop work when serious heat-illness symptoms occur or environmental conditions create unacceptable risk.',
      emergency:
          'Move the affected worker to a cooler location, provide first aid and activate emergency medical assistance according to the site procedure.',
      malayalam:
          'ചൂട് കൂടുതലുള്ള സാഹചര്യത്തിൽ വെള്ളം കുടിക്കുക, scheduled rest എടുക്കുക, heat-stress ലക്ഷണങ്ങൾ ഉടൻ report ചെയ്യുക. ഗുരുതരമായ ലക്ഷണങ്ങൾ കണ്ടാൽ ജോലി നിർത്തി medical assistance തേടണം.',
    ),

    ReferenceTopic(
      title: 'Personal Protective Equipment',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE General Reference',
      copNumber: 'PPE',
      version: 'Current Reference',
      effectiveDate: 'Verify applicable authority requirement',
      shortDescription:
          'Selection, use, inspection and maintenance of personal protective equipment.',
      overview:
          'PPE is an important layer of protection but should not replace elimination, engineering or administrative controls. PPE must be selected according to the identified hazard, task and risk assessment.',
      hazards:
          'Head injury\n'
          'Eye and face injury\n'
          'Hand injury\n'
          'Foot injury\n'
          'Hearing damage\n'
          'Respiratory exposure\n'
          'Falls from height',
      controls:
          'Identify hazards first.\n'
          'Select suitable PPE.\n'
          'Ensure correct fit.\n'
          'Train workers in correct use.\n'
          'Inspect PPE before use.\n'
          'Replace defective PPE.',
      planning:
          'Determine PPE requirements from the task risk assessment, method statement and applicable workplace requirements.',
      safePractices:
          'Wear PPE correctly, maintain cleanliness and report defects immediately.',
      ppe:
          'Safety helmet, safety footwear, gloves, eye protection, hearing protection, respiratory protection and fall protection as required by the task.',
      checklist:
          'Correct PPE selected\n'
          'PPE available\n'
          'PPE inspected\n'
          'Worker trained\n'
          'Damaged PPE replaced',
      inspection:
          'Check condition, fit, cleanliness, compatibility and suitability for the task.',
      dos:
          'Use PPE as instructed and report defective equipment.',
      donts:
          'Do not modify PPE or use damaged or unsuitable PPE.',
      stopWork:
          'Stop the task if required PPE is unavailable or unsuitable for the identified hazard.',
      emergency:
          'Follow the task-specific emergency procedure and obtain medical assistance where required.',
      malayalam:
          'PPE risk assessment അടിസ്ഥാനമാക്കി തിരഞ്ഞെടുക്കണം. Damaged PPE ഉപയോഗിക്കരുത്. PPE മാത്രം ആശ്രയിക്കാതെ engineering/control measures ആദ്യം പരിഗണിക്കണം.',
    ),

    ReferenceTopic(
      title: 'Confined Space Safety',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE General Reference',
      copNumber: 'Confined Space',
      version: 'Current Reference',
      effectiveDate: 'Verify applicable authority requirement',
      shortDescription:
          'Controls for entry into tanks, pits, vessels and other confined spaces.',
      overview:
          'Confined spaces can contain serious hazards including oxygen deficiency, toxic or flammable atmospheres, engulfment and restricted escape. Entry must be planned and controlled by competent personnel.',
      hazards:
          'Oxygen deficiency\n'
          'Toxic gases\n'
          'Flammable atmosphere\n'
          'Engulfment\n'
          'Restricted access and rescue',
      controls:
          'Avoid entry where practicable.\n'
          'Use an approved entry permit where required.\n'
          'Test the atmosphere before and during entry as required.\n'
          'Provide ventilation where appropriate.\n'
          'Maintain communication and standby arrangements.\n'
          'Provide a suitable rescue plan.',
      planning:
          'Identify the space, hazards, isolation requirements, atmospheric testing, ventilation, entry team, standby person and rescue arrangements.',
      safePractices:
          'Follow the entry permit and maintain communication. Never enter alone where the procedure requires standby arrangements.',
      ppe:
          'Task-specific PPE including respiratory protection, harness and retrieval equipment where identified by the risk assessment.',
      checklist:
          'Confined space identified\n'
          'Permit requirements checked\n'
          'Isolation completed\n'
          'Atmosphere tested\n'
          'Ventilation provided where required\n'
          'Rescue plan available',
      inspection:
          'Check access, isolation, atmosphere, ventilation, communication equipment, rescue equipment and permit conditions.',
      dos:
          'Follow the approved confined-space entry procedure and continuously monitor conditions as required.',
      donts:
          'Never enter an unsafe confined space without the required controls and authorisation.',
      stopWork:
          'Stop entry immediately if atmospheric conditions become unsafe, communication fails or required controls are lost.',
      emergency:
          'Raise the alarm and activate the rescue plan. Do not enter to rescue another worker unless trained, authorised and properly equipped.',
      malayalam:
          'Confined space entry-ക്ക് മുമ്പ് permit, isolation, atmospheric testing, ventilation, communication, standby person, rescue plan എന്നിവ ഉറപ്പാക്കണം.',
    ),

    ReferenceTopic(
      title: 'Permit to Work',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE General Reference',
      copNumber: 'Permit to Work',
      version: 'Current Reference',
      effectiveDate: 'Verify project and authority requirements',
      shortDescription:
          'Controlled authorisation system for higher-risk work activities.',
      overview:
          'A Permit to Work system provides formal control for selected high-risk activities. A permit does not replace risk assessment or safe work procedures; it confirms that required controls have been considered and authorised before work starts.',
      hazards:
          'Uncontrolled high-risk work\n'
          'Unexpected energy release\n'
          'Simultaneous operations\n'
          'Hot work and fire risk\n'
          'Confined-space hazards',
      controls:
          'Identify permit-required activities.\n'
          'Complete risk assessment.\n'
          'Define precautions and isolations.\n'
          'Authorise the permit before work starts.\n'
          'Conduct toolbox briefing.\n'
          'Close or suspend the permit when conditions change.',
      planning:
          'Confirm scope, hazards, controls, isolations, responsible persons, validity period, simultaneous operations and emergency arrangements.',
      safePractices:
          'Display or maintain the permit as required. Workers must understand the permit conditions before starting work.',
      ppe:
          'PPE must be specified according to the task risk assessment and permit conditions.',
      checklist:
          'Scope defined\n'
          'Risk assessment completed\n'
          'Controls verified\n'
          'Isolation confirmed where required\n'
          'Permit authorised\n'
          'Workers briefed',
      inspection:
          'Verify permit conditions, work area controls, isolation status, barricading and housekeeping during the job.',
      dos:
          'Work only within the approved permit scope and conditions.',
      donts:
          'Do not start work on an expired, suspended or incorrectly authorised permit.',
      stopWork:
          'Stop work when conditions change, controls fail, the permit expires or the actual work differs from the approved scope.',
      emergency:
          'Stop work, make the area safe where possible and activate the applicable emergency procedure.',
      malayalam:
          'High-risk work തുടങ്ങുന്നതിന് മുമ്പ് applicable Permit to Work requirements, risk assessment, isolation, controls, authorisation എന്നിവ ഉറപ്പാക്കണം.',
    ),

    ReferenceTopic(
      title: 'Lockout / Tagout',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE General Reference',
      copNumber: 'Energy Isolation / LOTO',
      version: 'Current Reference',
      effectiveDate: 'Verify applicable authority requirement',
      shortDescription:
          'Isolation of hazardous energy before maintenance or intervention.',
      overview:
          'Lockout and tagout controls prevent unexpected energisation or release of hazardous energy during maintenance, inspection and repair. All relevant energy sources must be identified, isolated, locked or otherwise controlled according to the approved procedure.',
      hazards:
          'Unexpected machine start-up\n'
          'Electrical shock\n'
          'Stored pressure\n'
          'Hydraulic or pneumatic energy\n'
          'Mechanical movement\n'
          'Thermal or chemical energy',
      controls:
          'Identify all energy sources.\n'
          'Shut down equipment correctly.\n'
          'Isolate energy sources.\n'
          'Apply locks and tags according to procedure.\n'
          'Release or control stored energy.\n'
          'Verify zero-energy condition before work.',
      planning:
          'Review equipment isolation points, energy types, authorised persons, isolation procedure and verification method before intervention.',
      safePractices:
          'Only authorised persons should apply or remove locks where required. Verify isolation before touching hazardous equipment.',
      ppe:
          'Task-specific PPE based on the energy hazard and risk assessment.',
      checklist:
          'Energy sources identified\n'
          'Equipment shut down\n'
          'Isolation applied\n'
          'Locks/tags applied\n'
          'Stored energy controlled\n'
          'Zero-energy verification completed',
      inspection:
          'Verify isolation points, locks, tags, warning signs and equipment status before and during work.',
      dos:
          'Follow the approved isolation procedure and verify zero energy before work begins.',
      donts:
          'Do not bypass, remove or defeat another person’s isolation without the authorised procedure.',
      stopWork:
          'Stop work if isolation cannot be confirmed or unexpected energy is detected.',
      emergency:
          'Stop work, keep people clear and activate the site emergency response for unexpected energisation or energy release.',
      malayalam:
          'Maintenance തുടങ്ങുന്നതിന് മുമ്പ് എല്ലാ hazardous energy sources കണ്ടെത്തി isolate, lock, tag ചെയ്ത് zero-energy condition verify ചെയ്യണം.',
    ),

    ReferenceTopic(
      title: 'Fire Safety & Hot Work',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE General Reference',
      copNumber: 'Fire Prevention / Hot Work',
      version: 'Current Reference',
      effectiveDate: 'Verify applicable authority requirement',
      shortDescription:
          'Controls for welding, cutting, grinding and other ignition-producing work.',
      overview:
          'Hot work can ignite combustible materials, gases or vapours. Suitable permits, area preparation, fire prevention controls, fire extinguishers and post-work monitoring must be applied where required.',
      hazards:
          'Fire\n'
          'Explosion\n'
          'Hot metal and sparks\n'
          'Flammable vapours\n'
          'Smoke and fumes',
      controls:
          'Obtain required hot-work authorisation.\n'
          'Remove or protect combustible materials.\n'
          'Provide suitable fire extinguishing equipment.\n'
          'Control sparks and hot surfaces.\n'
          'Provide fire watch where required.\n'
          'Inspect the area after work.',
      planning:
          'Identify combustibles, gas sources, ventilation, fire protection, isolation and emergency arrangements before starting.',
      safePractices:
          'Maintain good housekeeping and control sparks. Keep cylinders and equipment appropriately positioned and secured.',
      ppe:
          'Safety helmet, safety footwear, gloves, eye/face protection, suitable protective clothing and respiratory protection where required.',
      checklist:
          'Hot-work authorisation checked\n'
          'Combustibles removed/protected\n'
          'Fire extinguisher available\n'
          'Gas cylinders secured\n'
          'Fire watch assigned where required\n'
          'Post-work inspection planned',
      inspection:
          'Inspect work area, nearby combustibles, extinguishers, cylinders, hoses, cables and post-work fire risk.',
      dos:
          'Control ignition sources and maintain required fire precautions throughout the task.',
      donts:
          'Do not perform hot work near uncontrolled flammable materials or atmospheres.',
      stopWork:
          'Stop work if fire controls are missing, flammable vapours are suspected or conditions change.',
      emergency:
          'Raise the alarm, stop the work, isolate sources where safe and use emergency fire procedures.',
      malayalam:
          'Hot work-ന് മുമ്പ് permit, combustible materials control, fire extinguisher, fire watch, gas cylinder safety എന്നിവ ഉറപ്പാക്കണം.',
    ),

    // ============================================================
    // ABU DHABI
    // ============================================================

    ReferenceTopic(
      title: 'ADOSH-SF Framework',
      category: GuidelineCategory.abuDhabi,
      sourceLabel: 'Abu Dhabi Public Health Centre – ADOSH-SF',
      copNumber: 'ADOSH-SF Manual',
      version: 'V4.0',
      effectiveDate: '15 July 2024',
      shortDescription:
          'Abu Dhabi Occupational Safety and Health System Framework reference.',
      overview:
          'The Abu Dhabi Occupational Safety and Health System Framework (ADOSH-SF) provides the framework for occupational safety and health management in the Emirate of Abu Dhabi. Organisations must identify and apply the requirements relevant to their activities and sector.',
      hazards:
          'Workplace hazards vary by sector and activity.\n'
          'Non-compliance with applicable OSH requirements\n'
          'Inadequate risk management\n'
          'Insufficient worker competency or supervision',
      controls:
          'Identify applicable ADOSH-SF requirements.\n'
          'Maintain an appropriate OSH management system.\n'
          'Implement risk assessment and control processes.\n'
          'Maintain required records and reporting arrangements.\n'
          'Follow applicable Codes of Practice and sector requirements.',
      planning:
          'Determine the applicable ADOSH-SF requirements, sector regulatory authority requirements, Codes of Practice and project-specific controls before work begins.',
      safePractices:
          'Use approved OSH procedures, risk assessments, training and inspection systems. Report incidents and unsafe conditions according to applicable requirements.',
      ppe:
          'PPE must be selected according to the applicable risk assessment, CoP and workplace requirements.',
      checklist:
          'Applicable ADOSH-SF requirements identified\n'
          'OSH management arrangements established\n'
          'Risk assessment completed\n'
          'Applicable CoPs identified\n'
          'Workers competent and briefed\n'
          'Records and inspections maintained',
      inspection:
          'Review workplace controls against applicable ADOSH-SF requirements, Codes of Practice and approved project procedures.',
      dos:
          'Always verify the latest official ADOSH-SF documents and applicable sector requirements before making a compliance decision.',
      donts:
          'Do not assume a generic UAE HSE practice automatically satisfies an Abu Dhabi-specific requirement.',
      stopWork:
          'Stop work where a serious uncontrolled risk exists or required safety controls are not implemented.',
      emergency:
          'Follow the approved site emergency plan and applicable Abu Dhabi incident notification and response requirements.',
      malayalam:
          'Abu Dhabi-യിൽ ADOSH-SF, applicable Codes of Practice, sector requirements, project procedures എന്നിവ പരിശോധിച്ച ശേഷമാണ് compliance തീരുമാനം എടുക്കേണ്ടത്.',
    ),

    ReferenceTopic(
      title: 'Abu Dhabi Working at Heights',
      category: GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC / ADOSH-SF Code of Practice',
      copNumber: 'CoP 23.0 – Working at Heights',
      version: 'V4.1',
      effectiveDate: '27 February 2026',
      shortDescription:
          'Abu Dhabi-specific reference for managing work-at-height risks.',
      overview:
          'Abu Dhabi applies specific ADOSH-SF requirements for work at heights. The current official Code of Practice listing identifies Working at Heights as CoP 23.0, with the listed current revision dated 27 February 2026.',
      hazards:
          'Falls from edges\n'
          'Falls through openings\n'
          'Falls from access equipment\n'
          'Falling objects\n'
          'Incorrect fall-protection use',
      controls:
          'Apply the applicable ADOSH-SF requirements.\n'
          'Plan work at height before starting.\n'
          'Provide suitable collective protection.\n'
          'Inspect fall-protection equipment.\n'
          'Provide suitable rescue arrangements.',
      planning:
          'Review the current applicable ADOSH-SF CoP, risk assessment, method statement, access arrangements, equipment inspection and rescue plan.',
      safePractices:
          'Use approved access systems and maintain edge protection. Workers must understand the site-specific work-at-height controls.',
      ppe:
          'Safety helmet, safety footwear and task-specific fall-protection equipment as required by the approved risk assessment and procedure.',
      checklist:
          'Applicable ADOSH-SF CoP identified\n'
          'Risk assessment approved\n'
          'Access system suitable\n'
          'Edge protection installed\n'
          'Fall-protection equipment inspected\n'
          'Rescue arrangements available',
      inspection:
          'Inspect platforms, guardrails, openings, ladders, anchor points and fall-protection equipment.',
      dos:
          'Verify the current ADOSH-SF requirements applicable to the project before work starts.',
      donts:
          'Do not rely only on generic work-at-height guidance when an Abu Dhabi-specific requirement applies.',
      stopWork:
          'Stop work when required controls are missing, defective or no longer effective.',
      emergency:
          'Activate the approved project rescue and emergency response arrangements.',
      malayalam:
          'Abu Dhabi work-at-height activities-ൽ current ADOSH-SF CoP 23.0 ഉൾപ്പെടെയുള്ള applicable requirements verify ചെയ്ത് site controls നടപ്പാക്കണം.',
    ),

    ReferenceTopic(
      title: 'Abu Dhabi Permit to Work',
      category: GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC / ADOSH-SF Reference',
      copNumber: 'CoP 21.0 – Permit to Work Systems',
      version: 'V4.0',
      effectiveDate: '15 July 2024',
      shortDescription:
          'Abu Dhabi reference for controlling permit-required high-risk work.',
      overview:
          'ADOSH-SF includes a Code of Practice for Permit to Work Systems. The permit process supports control of higher-risk activities by ensuring hazards, precautions, isolations and authorisation are addressed before work starts.',
      hazards:
          'Uncontrolled high-risk work\n'
          'Unexpected energy release\n'
          'Simultaneous operations\n'
          'Hot work and confined-space hazards',
      controls:
          'Identify permit-required activities.\n'
          'Complete risk assessment.\n'
          'Define precautions and isolations.\n'
          'Obtain required authorisation.\n'
          'Brief workers on permit conditions.\n'
          'Suspend or close permits when conditions change.',
      planning:
          'Check the applicable ADOSH-SF CoP, project procedure, risk assessment, isolation requirements and permit authority.',
      safePractices:
          'Keep work within the authorised scope and conditions. Reassess when conditions or scope change.',
      ppe:
          'Use PPE identified by the task risk assessment and permit conditions.',
      checklist:
          'Applicable CoP verified\n'
          'Risk assessment completed\n'
          'Isolation requirements checked\n'
          'Permit authorised\n'
          'Workers briefed\n'
          'Permit conditions monitored',
      inspection:
          'Verify permit conditions, isolations, barricading, work area controls and changes in site conditions.',
      dos:
          'Verify the current applicable Abu Dhabi requirements before issuing or accepting a permit.',
      donts:
          'Do not continue work outside permit scope or after permit suspension/expiry.',
      stopWork:
          'Stop work when permit conditions are no longer valid or required controls fail.',
      emergency:
          'Stop the work and activate the approved emergency response procedure.',
      malayalam:
          'Abu Dhabi-യിൽ Permit to Work system ഉപയോഗിക്കുമ്പോൾ applicable ADOSH-SF CoP, project procedure, risk assessment, isolation, authorisation എന്നിവ പരിശോധിക്കണം.',
    ),

    ReferenceTopic(
      title: 'Abu Dhabi LOTO / Energy Isolation',
      category: GuidelineCategory.abuDhabi,
      sourceLabel: 'ADPHC / ADOSH-SF Code of Practice',
      copNumber: 'CoP 24.0 – Lock-out Tag-out',
      version: 'V4.1',
      effectiveDate: '27 February 2026',
      shortDescription:
          'Abu Dhabi reference for hazardous-energy isolation during maintenance.',
      overview:
          'Energy isolation prevents unexpected energisation, movement or release of hazardous energy during maintenance and intervention. The current ADOSH-SF Code of Practice listing identifies CoP 24.0 for Lock-out Tag-out (Isolation).',
      hazards:
          'Unexpected start-up\n'
          'Electrical energy\n'
          'Hydraulic and pneumatic pressure\n'
          'Stored mechanical energy\n'
          'Thermal or chemical energy',
      controls:
          'Identify all energy sources.\n'
          'Shut down equipment.\n'
          'Isolate energy sources.\n'
          'Apply approved locks and tags.\n'
          'Release stored energy.\n'
          'Verify isolation before work.',
      planning:
          'Review the applicable ADOSH-SF CoP, equipment isolation points, authorised persons, lockout procedure and verification method.',
      safePractices:
          'Use personal or authorised isolation controls according to the site procedure. Verify zero-energy condition before intervention.',
      ppe:
          'Task-specific PPE based on the identified energy hazards.',
      checklist:
          'Energy sources identified\n'
          'Equipment shut down\n'
          'Isolation applied\n'
          'Lock and tag applied\n'
          'Stored energy controlled\n'
          'Zero-energy condition verified',
      inspection:
          'Verify isolation points, locks, tags, warning signs and equipment condition.',
      dos:
          'Follow the approved Abu Dhabi/project isolation procedure and verify zero energy.',
      donts:
          'Do not bypass or defeat another person’s isolation without authorised procedure.',
      stopWork:
          'Stop work immediately if isolation cannot be confirmed or unexpected energy is detected.',
      emergency:
          'Keep people clear, isolate the hazard where safe and activate emergency response.',
      malayalam:
          'Abu Dhabi project-ൽ LOTO ചെയ്യുമ്പോൾ current applicable ADOSH-SF requirement, isolation procedure, locks/tags, stored-energy control, zero-energy verification എന്നിവ ഉറപ്പാക്കണം.',
    ),

    // ============================================================
    // DUBAI
    // ============================================================

    ReferenceTopic(
      title: 'Dubai HSE Framework',
      category: GuidelineCategory.dubai,
      sourceLabel: 'Dubai HSE Reference',
      copNumber: 'Dubai Authority / Project Requirements',
      version: 'Verify current revision',
      effectiveDate: 'Verify applicable authority requirement',
      shortDescription:
          'Dubai-specific starting reference for occupational health and safety management.',
      overview:
          'Dubai workplaces and projects may be subject to requirements from the relevant Dubai authority, sector regulator and project-specific HSE procedures. The exact requirements depend on the activity, authority jurisdiction and type of workplace.',
      hazards:
          'Requirements vary by activity and sector.\n'
          'Unidentified legal or authority requirements\n'
          'Inadequate risk assessment\n'
          'Insufficient supervision or competency',
      controls:
          'Identify the applicable Dubai authority.\n'
          'Verify current requirements before work.\n'
          'Complete task risk assessments.\n'
          'Implement approved HSE procedures.\n'
          'Maintain training and inspection records.',
      planning:
          'Identify the project authority, applicable regulations, Codes of Practice, permits and client requirements before starting work.',
      safePractices:
          'Follow approved method statements, risk assessments, permits and site HSE procedures.',
      ppe:
          'Use task-specific PPE based on the risk assessment and applicable project requirements.',
      checklist:
          'Applicable Dubai authority identified\n'
          'Current requirement verified\n'
          'Risk assessment completed\n'
          'Permit requirements checked\n'
          'Workers briefed\n'
          'Inspection completed',
      inspection:
          'Verify workplace controls against applicable Dubai authority requirements and project procedures.',
      dos:
          'Confirm the current applicable Dubai authority requirement before making a compliance decision.',
      donts:
          'Do not assume Abu Dhabi requirements are automatically identical to Dubai requirements.',
      stopWork:
          'Stop work where a serious uncontrolled risk or significant compliance concern exists.',
      emergency:
          'Follow the approved project emergency plan and applicable Dubai authority requirements.',
      malayalam:
          'Dubai-യിൽ applicable authority, project requirements, permits, risk assessment, method statement എന്നിവ പരിശോധിച്ച ശേഷമാണ് compliance തീരുമാനം എടുക്കേണ്ടത്.',
    ),

    ReferenceTopic(
      title: 'Dubai Work at Height',
      category: GuidelineCategory.dubai,
      sourceLabel: 'Dubai HSE / Project Reference',
      copNumber: 'Work at Height',
      version: 'Verify current requirement',
      effectiveDate: 'Verify applicable authority requirement',
      shortDescription:
          'Dubai-specific practical controls for preventing falls from height.',
      overview:
          'Work at height in Dubai projects must be controlled according to the applicable authority, client and project requirements. The risk assessment should establish the safest access method and suitable collective or personal fall protection.',
      hazards:
          'Falls from edges\n'
          'Falls through openings\n'
          'Falls from ladders\n'
          'Falling objects\n'
          'Improper fall protection',
      controls:
          'Eliminate unnecessary work at height.\n'
          'Provide suitable platforms and edge protection.\n'
          'Protect openings.\n'
          'Inspect access and fall-protection equipment.\n'
          'Control dropped objects.',
      planning:
          'Review the Dubai project requirements, risk assessment, method statement, access arrangements and rescue plan.',
      safePractices:
          'Use approved access systems and maintain edge protection. Do not improvise working platforms.',
      ppe:
          'Safety helmet, safety footwear and task-specific fall-protection equipment where required.',
      checklist:
          'Risk assessment completed\n'
          'Safe access provided\n'
          'Edge protection installed\n'
          'Openings protected\n'
          'Equipment inspected\n'
          'Rescue arrangements available',
      inspection:
          'Inspect access systems, platforms, guardrails, anchor points and fall-protection equipment.',
      dos:
          'Follow the applicable Dubai authority and project work-at-height procedure.',
      donts:
          'Do not remove edge protection or use unsafe temporary access.',
      stopWork:
          'Stop work when required protection is missing, damaged or ineffective.',
      emergency:
          'Raise the alarm and activate the project rescue and emergency response procedure.',
      malayalam:
          'Dubai project-ൽ work at height ചെയ്യുമ്പോൾ applicable authority/project requirements, safe access, edge protection, fall protection, rescue plan എന്നിവ ഉറപ്പാക്കണം.',
    ),

    ReferenceTopic(
      title: 'Dubai Lifting Operations',
      category: GuidelineCategory.dubai,
      sourceLabel: 'Dubai HSE / Project Reference',
      copNumber: 'Lifting Operations',
      version: 'Verify current requirement',
      effectiveDate: 'Verify applicable authority requirement',
      shortDescription:
          'Safe planning and control of lifting activities on Dubai projects.',
      overview:
          'Lifting operations require competent planning, suitable equipment, qualified personnel and effective exclusion zones. Dubai projects may also have client, consultant or authority-specific requirements that must be verified before the lift.',
      hazards:
          'Dropped loads\n'
          'Crane overturning\n'
          'Load swing\n'
          'Defective lifting accessories\n'
          'People entering lifting zones',
      controls:
          'Prepare an approved lifting plan.\n'
          'Verify equipment capacity and certification.\n'
          'Inspect accessories.\n'
          'Use competent operators and riggers.\n'
          'Establish exclusion zones.',
      planning:
          'Confirm load weight, crane capacity, ground conditions, lifting points, weather, overhead hazards and communication arrangements.',
      safePractices:
          'Follow the lifting plan and maintain communication. Never allow people under suspended loads.',
      ppe:
          'Safety helmet, safety footwear, gloves, high-visibility clothing and task-specific PPE.',
      checklist:
          'Lift plan approved\n'
          'Crane inspection valid\n'
          'Accessories inspected\n'
          'Load weight confirmed\n'
          'Ground condition checked\n'
          'Exclusion zone established',
      inspection:
          'Inspect crane, hooks, slings, shackles, lifting points, outriggers, ground and exclusion zone.',
      dos:
          'Follow the approved Dubai project lifting procedure and lifting plan.',
      donts:
          'Do not exceed equipment capacity or allow personnel under suspended loads.',
      stopWork:
          'Stop lifting if equipment defects, unstable ground, poor visibility or unsafe weather occurs.',
      emergency:
          'Stop the operation, secure the load where possible and activate the emergency procedure.',
      malayalam:
          'Dubai lifting operation-ൽ lifting plan, crane capacity, accessories, ground condition, exclusion zone, competent lifting team എന്നിവ ഉറപ്പാക്കണം.',
    ),

    ReferenceTopic(
      title: 'Dubai Excavation Safety',
      category: GuidelineCategory.dubai,
      sourceLabel: 'Dubai HSE / Project Reference',
      copNumber: 'Excavation & Trenching',
      version: 'Verify current requirement',
      effectiveDate: 'Verify applicable authority requirement',
      shortDescription:
          'Controls for excavation and trenching activities in Dubai projects.',
      overview:
          'Excavation work requires careful planning because ground collapse, underground services, falls and plant movement can create serious risks. Project and authority requirements must be confirmed before excavation.',
      hazards:
          'Ground collapse\n'
          'Underground services\n'
          'Falls into excavation\n'
          'Water ingress\n'
          'Plant movement',
      controls:
          'Identify underground services.\n'
          'Provide suitable excavation protection.\n'
          'Provide safe access and egress.\n'
          'Protect excavation edges.\n'
          'Control plant and spoil near edges.\n'
          'Inspect the excavation regularly.',
      planning:
          'Review drawings, service information, excavation method, protection system, plant movement and emergency arrangements.',
      safePractices:
          'Maintain required protection and safe access. Do not enter unstable or unsupported excavations.',
      ppe:
          'Safety helmet, safety footwear, gloves, high-visibility clothing and task-specific PPE.',
      checklist:
          'Services identified\n'
          'Protection system provided\n'
          'Safe access provided\n'
          'Edges protected\n'
          'Plant controlled\n'
          'Inspection completed',
      inspection:
          'Check walls, protection systems, access, water, edge condition, spoil and plant location.',
      dos:
          'Follow the approved Dubai project excavation procedure.',
      donts:
          'Do not enter an unsupported or unstable excavation.',
      stopWork:
          'Stop work if ground movement, water ingress, unidentified services or unsafe access is identified.',
      emergency:
          'Keep personnel away from unstable areas and activate the project emergency response.',
      malayalam:
          'Dubai excavation-ൽ underground services, excavation protection, safe access, edge protection, plant movement എന്നിവ പ്രത്യേകം നിയന്ത്രിക്കണം.',
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
          topic.shortDescription.toLowerCase().contains(query) ||
          topic.copNumber.toLowerCase().contains(query);

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
