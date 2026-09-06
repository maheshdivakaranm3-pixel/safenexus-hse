import 'package:flutter/material.dart';

import 'guideline_detail_page.dart';
import 'models/reference_topic.dart';

class GuidelinesPage extends StatefulWidget {
  const GuidelinesPage({super.key});

  @override
  State<GuidelinesPage> createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  final TextEditingController _searchController =
      TextEditingController();

  String _query = '';

  GuidelineCategory? _selectedCategory;

  static const List<ReferenceTopic> _topics = [
    ReferenceTopic(
      title: 'Scaffolding Safety',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE – Scaffolding Safety Reference',
      copNumber: 'Scaffolding / Work at Height Reference',
      version: 'Reference V1.0',
      effectiveDate: 'Verify current authority requirements',
      shortDescription:
          'Safe planning, erection, inspection and use of scaffolding in the workplace.',
      overview:
          'Scaffolding is a temporary access and work platform system used to provide safe access and working areas at height. It must be properly designed, erected, inspected, maintained and used by competent persons.',
      hazards:
          'Falls from height\n'
          'Falling objects and materials\n'
          'Scaffold collapse or instability\n'
          'Overloading of platforms\n'
          'Unsafe access and egress\n'
          'Adverse weather conditions',
      controls:
          'Use competent and trained scaffolders\n'
          'Provide proper foundations and stability\n'
          'Install guardrails, midrails and toe boards\n'
          'Provide safe access and egress\n'
          'Display inspection status where required\n'
          'Prevent unauthorised alteration\n'
          'Maintain safe platform loading limits',
      planning:
          'Assess the work area before erection. Confirm ground conditions, access, overhead hazards, nearby electrical services, loading requirements and environmental conditions. Ensure the scaffold arrangement is suitable for the intended work.',
      safePractices:
          'Do not remove guardrails or structural components without authorisation. Keep platforms clean and free from unnecessary materials. Maintain clear access routes and use approved access systems.',
      ppe:
          'Safety helmet\n'
          'Safety footwear\n'
          'High-visibility clothing\n'
          'Fall protection where required by the risk assessment\n'
          'Gloves suitable for the task',
      checklist:
          'Scaffold erected by competent persons\n'
          'Base and foundations are stable\n'
          'Guardrails and toe boards installed\n'
          'Access ladder or stair system provided\n'
          'Platform is complete and suitable\n'
          'Inspection completed before use\n'
          'No unauthorised modifications',
      inspection:
          'Check structural condition\n'
          'Check ties and stability\n'
          'Check platforms\n'
          'Check guardrails\n'
          'Check toe boards\n'
          'Check access\n'
          'Check for damage or unauthorised alteration',
      dos:
          'Use only inspected and approved scaffolding\n'
          'Keep platforms clear\n'
          'Report defects immediately\n'
          'Follow site access requirements',
      donts:
          'Do not use incomplete scaffolding\n'
          'Do not overload platforms\n'
          'Do not climb outside approved access\n'
          'Do not modify scaffolding without authorisation',
      stopWork:
          'Stop work if the scaffold is damaged, unstable, incomplete, overloaded or has missing critical protection.',
      emergency:
          'Stop work, prevent access to the affected area, inform the supervisor and HSE team, and follow the site emergency procedure. In case of injury, activate the site emergency response and seek medical assistance.',
      malayalam:
          'സ്കാഫോൾഡിംഗ് ഉപയോഗിക്കുന്നതിന് മുമ്പ് inspection പൂർത്തിയായിട്ടുണ്ടെന്ന് ഉറപ്പാക്കുക. Guardrail, toe board, safe access എന്നിവ ഉണ്ടായിരിക്കണം. കേടായതോ incomplete ആയതോ unstable ആയതോ ആയ scaffold ഉപയോഗിക്കരുത്.',
    ),

    ReferenceTopic(
      title: 'Work at Height Safety',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE – Work at Height Reference',
      copNumber: 'Work at Height Safety Reference',
      version: 'Reference V1.0',
      effectiveDate: 'Verify current authority requirements',
      shortDescription:
          'Essential controls for preventing falls while performing work at height.',
      overview:
          'Work at height includes any work where a person could fall and suffer personal injury. The preferred approach is to eliminate work at height where possible and then apply suitable collective and personal protection.',
      hazards:
          'Falls from edges\n'
          'Falls through openings\n'
          'Falls from ladders\n'
          'Falling tools and materials\n'
          'Unsafe temporary platforms\n'
          'Poor weather conditions',
      controls:
          'Avoid work at height where practicable\n'
          'Use suitable collective protection\n'
          'Provide safe access and working platforms\n'
          'Protect openings and edges\n'
          'Use fall protection when required\n'
          'Control dropped objects\n'
          'Ensure workers are competent',
      planning:
          'Complete a task-specific risk assessment and identify access requirements, rescue arrangements, weather conditions, equipment and competency requirements before work starts.',
      safePractices:
          'Maintain three points of contact on ladders where appropriate. Keep work platforms clean. Use approved anchor points and fall protection systems where required.',
      ppe:
          'Safety helmet with suitable retention where required\n'
          'Safety footwear\n'
          'High-visibility clothing\n'
          'Full body harness where required\n'
          'Suitable gloves',
      checklist:
          'Risk assessment completed\n'
          'Safe access provided\n'
          'Edges protected\n'
          'Openings protected\n'
          'Equipment inspected\n'
          'Rescue plan available\n'
          'Workers competent',
      inspection:
          'Check platforms\n'
          'Check ladders\n'
          'Check guardrails\n'
          'Check anchor points\n'
          'Check harness and lanyards\n'
          'Check openings and edges',
      dos:
          'Plan the work\n'
          'Use approved access equipment\n'
          'Maintain good housekeeping\n'
          'Follow the rescue plan',
      donts:
          'Do not work at height without suitable controls\n'
          'Do not use damaged equipment\n'
          'Do not improvise anchor points\n'
          'Do not throw materials from height',
      stopWork:
          'Stop work when fall protection is unavailable, damaged, incorrectly installed or when weather or site conditions create unacceptable risk.',
      emergency:
          'Prevent further exposure, raise the alarm and follow the site rescue procedure. Do not create additional risk during rescue operations.',
      malayalam:
          'ഉയരത്തിൽ ജോലി ചെയ്യുന്നതിന് മുമ്പ് fall risk വിലയിരുത്തണം. കഴിയുന്നിടത്ത് work at height ഒഴിവാക്കുക. Guardrail, safe platform, access, harness തുടങ്ങിയ ആവശ്യമായ controls ഉപയോഗിക്കുക.',
    ),

    ReferenceTopic(
      title: 'Heat Stress Management',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE – Heat Stress Reference',
      copNumber: 'Heat Stress Management',
      version: 'Reference V1.0',
      effectiveDate: 'Verify current UAE requirements',
      shortDescription:
          'Controls for reducing heat-related illness during outdoor and hot-environment work.',
      overview:
          'Heat stress can affect workers exposed to high temperatures, humidity and physical workload. Effective management requires planning, hydration, rest, shade, acclimatisation, monitoring and emergency response.',
      hazards:
          'Heat exhaustion\n'
          'Heat stroke\n'
          'Dehydration\n'
          'Fatigue\n'
          'Reduced concentration\n'
          'Loss of physical performance',
      controls:
          'Provide drinking water\n'
          'Provide suitable shaded rest areas\n'
          'Plan work to reduce heat exposure\n'
          'Use appropriate work-rest arrangements\n'
          'Monitor workers\n'
          'Provide acclimatisation\n'
          'Train workers to recognise symptoms',
      planning:
          'Plan high-risk activities considering temperature, humidity, workload, clothing, worker acclimatisation and availability of shade and drinking water.',
      safePractices:
          'Drink water regularly. Take scheduled rest periods. Report symptoms early. Avoid unnecessary physical exertion during extreme heat conditions.',
      ppe:
          'Lightweight suitable work clothing\n'
          'Safety helmet\n'
          'Safety footwear\n'
          'High-visibility clothing\n'
          'Task-specific PPE',
      checklist:
          'Drinking water available\n'
          'Shade/rest area available\n'
          'Workers briefed\n'
          'Heat condition monitored\n'
          'Work-rest arrangements implemented\n'
          'Emergency response available',
      inspection:
          'Check water supply\n'
          'Check shaded rest area\n'
          'Check worker welfare\n'
          'Check heat monitoring arrangements\n'
          'Check communication',
      dos:
          'Drink water regularly\n'
          'Take rest breaks\n'
          'Report symptoms immediately\n'
          'Look after co-workers',
      donts:
          'Do not ignore heat illness symptoms\n'
          'Do not restrict access to drinking water\n'
          'Do not continue unsafe work during severe symptoms',
      stopWork:
          'Stop work and seek assistance if a worker develops serious heat illness symptoms such as confusion, collapse or loss of consciousness.',
      emergency:
          'Move the affected worker to a cool area, raise the alarm and activate the site emergency response. Obtain medical assistance immediately for suspected serious heat illness.',
      malayalam:
          'ചൂട് കൂടുതലുള്ള സമയത്ത് വെള്ളം കുടിക്കുക, shade/rest area ഉപയോഗിക്കുക, ഇടവേളകൾ പാലിക്കുക. തലകറക്കം, weakness, confusion തുടങ്ങിയ ലക്ഷണങ്ങൾ ഉണ്ടായാൽ ഉടൻ supervisor/HSE-നെ അറിയിക്കുക.',
    ),

    ReferenceTopic(
      title: 'Personal Protective Equipment',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE – PPE Reference',
      copNumber: 'Personal Protective Equipment',
      version: 'Reference V1.0',
      effectiveDate: 'Verify current authority requirements',
      shortDescription:
          'Selection, inspection and correct use of personal protective equipment.',
      overview:
          'PPE is the last line of defence and should be selected based on the hazards and risk assessment. PPE must be suitable, correctly fitted, maintained and used properly.',
      hazards:
          'Head injury\n'
          'Eye injury\n'
          'Hand injury\n'
          'Foot injury\n'
          'Hearing damage\n'
          'Respiratory exposure\n'
          'Fall from height',
      controls:
          'Complete risk assessment\n'
          'Select suitable PPE\n'
          'Ensure correct fit\n'
          'Train workers\n'
          'Inspect PPE before use\n'
          'Replace damaged PPE\n'
          'Store PPE correctly',
      planning:
          'Identify hazards first and determine whether engineering or administrative controls can reduce the risk. Select PPE that provides appropriate protection for the remaining risk.',
      safePractices:
          'Wear PPE as required by the task. Inspect before use and report defective equipment. Keep PPE clean and properly stored.',
      ppe:
          'Safety helmet\n'
          'Safety glasses\n'
          'Safety footwear\n'
          'Gloves\n'
          'Hearing protection\n'
          'Respiratory protection where required\n'
          'Fall protection where required',
      checklist:
          'Correct PPE selected\n'
          'PPE fits correctly\n'
          'PPE inspected\n'
          'Worker trained\n'
          'Damaged PPE removed\n'
          'Storage available',
      inspection:
          'Check cracks\n'
          'Check straps\n'
          'Check lenses\n'
          'Check gloves\n'
          'Check soles\n'
          'Check harness components\n'
          'Check expiry or service requirements where applicable',
      dos:
          'Wear task-specific PPE\n'
          'Inspect before use\n'
          'Keep PPE clean\n'
          'Replace defective PPE',
      donts:
          'Do not use damaged PPE\n'
          'Do not share PPE where hygiene or fit makes this unsuitable\n'
          'Do not modify PPE',
      stopWork:
          'Stop the task when required PPE is unavailable, damaged or unsuitable for the identified hazard.',
      emergency:
          'Move away from the hazard where safe to do so and follow the site emergency procedure. Report exposure or injury immediately.',
      malayalam:
          'PPE അവസാനത്തെ protection layer ആണ്. Risk assessment അനുസരിച്ച് ശരിയായ PPE തിരഞ്ഞെടുക്കണം. ഉപയോഗിക്കുന്നതിന് മുമ്പ് PPE inspect ചെയ്യുകയും കേടായ PPE മാറ്റുകയും വേണം.',
    ),

    ReferenceTopic(
      title: 'Ladder Safety',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE – Ladder Safety Reference',
      copNumber: 'Ladder Safety',
      version: 'Reference V1.0',
      effectiveDate: 'Verify current authority requirements',
      shortDescription:
          'Safe selection, positioning and use of portable ladders.',
      overview:
          'Ladders are access equipment and should be used only when suitable for the task and conditions. They must be inspected and positioned securely.',
      hazards:
          'Falls from ladders\n'
          'Slipping\n'
          'Overreaching\n'
          'Electrical contact\n'
          'Unstable ground\n'
          'Incorrect ladder selection',
      controls:
          'Use suitable ladder type\n'
          'Inspect before use\n'
          'Place on stable ground\n'
          'Secure where necessary\n'
          'Maintain safe contact\n'
          'Keep away from electrical hazards',
      planning:
          'Assess whether a ladder is the correct access method. Consider duration, height, task requirements, ground condition and nearby hazards.',
      safePractices:
          'Maintain appropriate contact while climbing. Keep your body within the ladder profile and avoid overreaching. Do not carry loads that prevent safe climbing.',
      ppe:
          'Safety helmet\n'
          'Safety footwear\n'
          'Task-specific gloves\n'
          'Fall protection where specifically required',
      checklist:
          'Ladder inspected\n'
          'Correct type selected\n'
          'Stable base\n'
          'Secure position\n'
          'Access area clear\n'
          'No visible damage',
      inspection:
          'Check stiles\n'
          'Check rungs\n'
          'Check feet\n'
          'Check locks\n'
          'Check platform where applicable\n'
          'Check contamination or damage',
      dos:
          'Use a suitable ladder\n'
          'Inspect before use\n'
          'Maintain stable footing\n'
          'Keep access area clear',
      donts:
          'Do not use damaged ladders\n'
          'Do not overreach\n'
          'Do not stand on prohibited steps\n'
          'Do not use near electrical hazards without suitable controls',
      stopWork:
          'Stop work if the ladder is damaged, unstable, incorrectly positioned or unsuitable for the task.',
      emergency:
          'If a fall or injury occurs, stop work, raise the alarm and activate the site emergency procedure.',
      malayalam:
          'Ladder ഉപയോഗിക്കുന്നതിന് മുമ്പ് condition പരിശോധിക്കുക. Stable surface-ൽ സ്ഥാപിക്കുക. Overreach ചെയ്യരുത്. Damaged ladder ഉപയോഗിക്കരുത്.',
    ),

    ReferenceTopic(
      title: 'Confined Space Safety',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE – Confined Space Reference',
      copNumber: 'Confined Space Entry',
      version: 'Reference V1.0',
      effectiveDate: 'Verify current authority requirements',
      shortDescription:
          'Critical controls for safe entry into confined spaces.',
      overview:
          'Confined spaces can contain atmospheric, engulfment, access and rescue hazards. Entry must be planned, authorised and controlled.',
      hazards:
          'Oxygen deficiency\n'
          'Toxic gases\n'
          'Flammable atmosphere\n'
          'Engulfment\n'
          'Restricted access\n'
          'Difficult rescue',
      controls:
          'Permit where required\n'
          'Atmospheric testing\n'
          'Isolation\n'
          'Ventilation\n'
          'Competent personnel\n'
          'Standby arrangement\n'
          'Emergency rescue plan',
      planning:
          'Identify the space, hazards, isolation requirements, atmospheric testing, ventilation, communication and rescue arrangements before entry.',
      safePractices:
          'Follow the entry permit and site procedure. Continuously monitor atmosphere where required. Maintain communication with the attendant.',
      ppe:
          'Safety helmet\n'
          'Safety footwear\n'
          'Gloves\n'
          'Eye protection\n'
          'Respiratory protection where required\n'
          'Harness and retrieval equipment where required',
      checklist:
          'Permit approved\n'
          'Isolation completed\n'
          'Atmosphere tested\n'
          'Ventilation available\n'
          'Communication available\n'
          'Rescue plan ready\n'
          'Competent team available',
      inspection:
          'Check entry point\n'
          'Check atmosphere\n'
          'Check ventilation\n'
          'Check communication\n'
          'Check retrieval system\n'
          'Check isolation',
      dos:
          'Follow permit requirements\n'
          'Test atmosphere\n'
          'Maintain communication\n'
          'Keep rescue equipment ready',
      donts:
          'Do not enter without authorisation\n'
          'Do not enter an unsafe atmosphere\n'
          'Do not attempt an unplanned rescue',
      stopWork:
          'Stop entry immediately if atmospheric conditions become unsafe, communication is lost or required controls fail.',
      emergency:
          'Raise the alarm and activate the confined-space rescue plan. Untrained persons must not enter to perform an improvised rescue.',
      malayalam:
          'Confined space entry വളരെ high-risk activity ആണ്. Permit, gas testing, isolation, ventilation, communication, standby person, rescue plan എന്നിവ ഉറപ്പാക്കാതെ entry നടത്തരുത്.',
    ),

    ReferenceTopic(
      title: 'Hot Work Safety',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE – Hot Work Reference',
      copNumber: 'Hot Work / Fire Prevention',
      version: 'Reference V1.0',
      effectiveDate: 'Verify current authority requirements',
      shortDescription:
          'Controls for welding, cutting, grinding and other ignition-producing activities.',
      overview:
          'Hot work can create fire, explosion, fumes, radiation and burn hazards. Proper permits, isolation, fire prevention and monitoring are essential.',
      hazards:
          'Fire\n'
          'Explosion\n'
          'Burns\n'
          'Welding fumes\n'
          'Radiation\n'
          'Gas cylinder hazards',
      controls:
          'Hot work permit where required\n'
          'Remove combustible materials\n'
          'Provide fire extinguishers\n'
          'Use fire watch\n'
          'Control gas cylinders\n'
          'Provide ventilation\n'
          'Inspect equipment',
      planning:
          'Identify combustible materials, nearby processes, gas cylinders, fire protection, ventilation and emergency arrangements before starting.',
      safePractices:
          'Keep the work area controlled and clean. Use correct welding screens. Secure cylinders and maintain suitable separation and storage arrangements.',
      ppe:
          'Welding helmet or suitable eye protection\n'
          'Gloves\n'
          'Flame-resistant clothing\n'
          'Safety footwear\n'
          'Hearing protection where required\n'
          'Respiratory protection where required',
      checklist:
          'Permit available\n'
          'Combustibles controlled\n'
          'Fire extinguisher available\n'
          'Fire watch assigned\n'
          'Equipment inspected\n'
          'Gas cylinders secured\n'
          'Ventilation adequate',
      inspection:
          'Check hoses\n'
          'Check regulators\n'
          'Check cables\n'
          'Check cylinders\n'
          'Check fire extinguishers\n'
          'Check surrounding area',
      dos:
          'Obtain required permit\n'
          'Remove combustibles\n'
          'Maintain fire watch\n'
          'Inspect equipment',
      donts:
          'Do not start unauthorised hot work\n'
          'Do not leave ignition sources uncontrolled\n'
          'Do not use damaged hoses or cables',
      stopWork:
          'Stop work immediately if fire protection, permit controls, gas equipment or environmental controls become inadequate.',
      emergency:
          'Stop work, isolate the source if safe, raise the alarm and use the appropriate emergency procedure. Evacuate if required.',
      malayalam:
          'Hot work ആരംഭിക്കുന്നതിന് മുമ്പ് permit, fire extinguisher, fire watch, combustible material control എന്നിവ ഉറപ്പാക്കണം. Damaged welding cables/hoses ഉപയോഗിക്കരുത്.',
    ),

    ReferenceTopic(
      title: 'Excavation Safety',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE – Excavation Safety Reference',
      copNumber: 'Excavation / Trenching',
      version: 'Reference V1.0',
      effectiveDate: 'Verify current authority requirements',
      shortDescription:
          'Controls for excavation, trenching and ground disturbance activities.',
      overview:
          'Excavation work can expose workers to collapse, underground services, falling materials, water ingress and plant interaction hazards.',
      hazards:
          'Trench collapse\n'
          'Underground services\n'
          'Falling materials\n'
          'Plant movement\n'
          'Water ingress\n'
          'Falls into excavation',
      controls:
          'Permit and planning\n'
          'Service identification\n'
          'Suitable shoring or battering\n'
          'Safe access\n'
          'Edge protection\n'
          'Plant exclusion zones\n'
          'Regular inspection',
      planning:
          'Identify underground services and ground conditions. Determine protective systems, access, spoil placement, plant movement and emergency arrangements.',
      safePractices:
          'Keep spoil and materials away from excavation edges as required. Provide safe access. Prevent unauthorised entry and maintain suitable barriers.',
      ppe:
          'Safety helmet\n'
          'Safety footwear\n'
          'High-visibility clothing\n'
          'Gloves\n'
          'Eye protection where required',
      checklist:
          'Excavation inspected\n'
          'Services identified\n'
          'Protective system provided\n'
          'Safe access provided\n'
          'Edges protected\n'
          'Plant controlled\n'
          'Water controlled',
      inspection:
          'Check excavation walls\n'
          'Check protective systems\n'
          'Check access\n'
          'Check edge protection\n'
          'Check water ingress\n'
          'Check nearby plant',
      dos:
          'Inspect excavation before entry\n'
          'Maintain barriers\n'
          'Follow approved excavation controls\n'
          'Report ground movement',
      donts:
          'Do not enter unsupported unsafe excavation\n'
          'Do not place plant too close to edges\n'
          'Do not ignore ground movement or water ingress',
      stopWork:
          'Stop work immediately if there is evidence of collapse, ground movement, damaged protection or unidentified underground services.',
      emergency:
          'Keep personnel away from collapse zones, raise the alarm and activate the excavation emergency plan. Do not enter an unstable excavation for rescue.',
      malayalam:
          'Excavation-ൽ entry ചെയ്യുന്നതിന് മുമ്പ് ground condition, underground services, shoring/battering, safe access, edge protection എന്നിവ പരിശോധിക്കുക. Ground movement കണ്ടാൽ ഉടൻ work stop ചെയ്യുക.',
    ),

    ReferenceTopic(
      title: 'Lifting Operations Safety',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE – Lifting Operations Reference',
      copNumber: 'Lifting Operations',
      version: 'Reference V1.0',
      effectiveDate: 'Verify current authority requirements',
      shortDescription:
          'Safe planning and execution of lifting operations using cranes and lifting equipment.',
      overview:
          'Lifting operations require proper planning, competent personnel, suitable equipment and effective exclusion zones to prevent dropped loads and struck-by incidents.',
      hazards:
          'Dropped loads\n'
          'Crane overturning\n'
          'Load swing\n'
          'Equipment failure\n'
          'Struck-by incidents\n'
          'Overhead hazards',
      controls:
          'Approved lifting plan\n'
          'Competent lifting team\n'
          'Inspected equipment\n'
          'Suitable rigging\n'
          'Exclusion zone\n'
          'Clear communication\n'
          'Weather monitoring',
      planning:
          'Determine load weight, centre of gravity, lifting points, equipment capacity, ground conditions, lifting radius and communication arrangements before lifting.',
      safePractices:
          'Use approved lifting accessories. Establish an exclusion zone. Keep personnel away from suspended loads and maintain clear communication between the lifting team.',
      ppe:
          'Safety helmet\n'
          'Safety footwear\n'
          'High-visibility clothing\n'
          'Gloves\n'
          'Eye protection where required',
      checklist:
          'Lift planned\n'
          'Equipment inspected\n'
          'Accessories inspected\n'
          'Load capacity confirmed\n'
          'Ground condition suitable\n'
          'Exclusion zone established\n'
          'Communication confirmed',
      inspection:
          'Check crane/equipment\n'
          'Check slings\n'
          'Check shackles\n'
          'Check hooks\n'
          'Check lifting points\n'
          'Check ground condition',
      dos:
          'Use competent personnel\n'
          'Inspect lifting accessories\n'
          'Maintain exclusion zones\n'
          'Follow the lifting plan',
      donts:
          'Do not stand under suspended loads\n'
          'Do not exceed rated capacity\n'
          'Do not use damaged lifting accessories\n'
          'Do not lift without proper planning',
      stopWork:
          'Stop lifting if equipment becomes defective, weather conditions deteriorate, communication fails or the lift deviates from the approved plan.',
      emergency:
          'Stop the operation, secure the area and raise the alarm. Keep personnel away from suspended or unstable loads.',
      malayalam:
          'Lifting operation ആരംഭിക്കുന്നതിന് മുമ്പ് lifting plan, load weight, equipment capacity, rigging accessories, ground condition, exclusion zone എന്നിവ ഉറപ്പാക്കണം. Suspended load-ന്റെ താഴെ നിൽക്കരുത്.',
    ),

    ReferenceTopic(
      title: 'Electrical Safety',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE – Electrical Safety Reference',
      copNumber: 'Electrical Safety',
      version: 'Reference V1.0',
      effectiveDate: 'Verify current authority requirements',
      shortDescription:
          'Essential controls for preventing electrical shock, burns and fire.',
      overview:
          'Electrical work and electrical equipment can cause fatal shock, burns, arc flash and fire. Isolation, competent persons and suitable equipment are essential.',
      hazards:
          'Electric shock\n'
          'Arc flash\n'
          'Burns\n'
          'Electrical fire\n'
          'Damaged cables\n'
          'Contact with overhead services',
      controls:
          'Competent persons\n'
          'Isolation and lockout\n'
          'Suitable protection devices\n'
          'Inspection and testing\n'
          'Cable management\n'
          'Safe distances\n'
          'Permit requirements where applicable',
      planning:
          'Identify electrical sources and nearby services. Determine isolation requirements and ensure only authorised persons perform electrical work.',
      safePractices:
          'Do not use damaged cables or equipment. Keep electrical equipment away from water where appropriate. Maintain safe distances from overhead lines.',
      ppe:
          'Safety helmet\n'
          'Safety footwear\n'
          'Eye protection\n'
          'Electrical gloves where required\n'
          'Arc-rated PPE where required by risk assessment',
      checklist:
          'Isolation identified\n'
          'Equipment inspected\n'
          'Cables protected\n'
          'Authorised persons assigned\n'
          'Protection devices available\n'
          'Area controlled',
      inspection:
          'Check cables\n'
          'Check plugs\n'
          'Check sockets\n'
          'Check distribution boards\n'
          'Check earthing arrangements\n'
          'Check temporary electrical installations',
      dos:
          'Use authorised personnel\n'
          'Isolate before work\n'
          'Inspect equipment\n'
          'Report defects',
      donts:
          'Do not use damaged electrical equipment\n'
          'Do not bypass safety devices\n'
          'Do not work on live systems unless specifically authorised and controlled',
      stopWork:
          'Stop work immediately if electrical equipment is damaged, isolation cannot be confirmed or unsafe contact with electrical sources is possible.',
      emergency:
          'Do not touch a person in contact with an energised source until the supply is safely isolated. Raise the alarm and activate the emergency response.',
      malayalam:
          'Electrical work authorised/competent persons മാത്രം ചെയ്യണം. Isolation ഉറപ്പാക്കാതെ electrical equipment-ൽ ജോലി ചെയ്യരുത്. Damaged cable അല്ലെങ്കിൽ equipment ഉപയോഗിക്കരുത്.',
    ),

    ReferenceTopic(
      title: 'Fire Safety',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE – Fire Safety Reference',
      copNumber: 'Fire Prevention & Emergency',
      version: 'Reference V1.0',
      effectiveDate: 'Verify current authority requirements',
      shortDescription:
          'Workplace fire prevention, preparedness and emergency response.',
      overview:
          'Fire safety depends on prevention, early detection, suitable firefighting arrangements, clear escape routes and effective emergency response.',
      hazards:
          'Fire\n'
          'Smoke inhalation\n'
          'Explosion\n'
          'Blocked escape routes\n'
          'Flammable materials\n'
          'Ignition sources',
      controls:
          'Control ignition sources\n'
          'Store flammables correctly\n'
          'Maintain extinguishers\n'
          'Keep exits clear\n'
          'Provide alarms\n'
          'Conduct drills\n'
          'Train workers',
      planning:
          'Identify fire hazards, emergency exits, assembly points, firefighting equipment, alarm arrangements and emergency contacts.',
      safePractices:
          'Keep escape routes clear. Store flammable materials correctly. Report fire hazards and damaged firefighting equipment immediately.',
      ppe:
          'Safety helmet\n'
          'Safety footwear\n'
          'Task-specific PPE\n'
          'Fire-resistant PPE where required',
      checklist:
          'Fire exits clear\n'
          'Extinguishers available\n'
          'Alarm accessible\n'
          'Assembly point identified\n'
          'Flammable storage controlled\n'
          'Workers briefed',
      inspection:
          'Check extinguishers\n'
          'Check exits\n'
          'Check fire doors\n'
          'Check alarm systems\n'
          'Check emergency signage\n'
          'Check housekeeping',
      dos:
          'Keep exits clear\n'
          'Report fire hazards\n'
          'Know the assembly point\n'
          'Follow emergency instructions',
      donts:
          'Do not block emergency exits\n'
          'Do not misuse fire equipment\n'
          'Do not store flammables near uncontrolled ignition sources',
      stopWork:
          'Stop work when an immediate fire or explosion hazard is identified and cannot be adequately controlled.',
      emergency:
          'Raise the alarm, evacuate using the designated route and proceed to the assembly point. Do not re-enter until authorised.',
      malayalam:
          'Fire emergency ഉണ്ടായാൽ alarm raise ചെയ്യുക, safe evacuation route ഉപയോഗിക്കുക, assembly point-ൽ എത്തുക. Authorisation ഇല്ലാതെ building-ലേക്ക് തിരികെ പ്രവേശിക്കരുത്.',
    ),

    ReferenceTopic(
      title: 'Manual Handling Safety',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE – Manual Handling Reference',
      copNumber: 'Manual Handling',
      version: 'Reference V1.0',
      effectiveDate: 'Verify current authority requirements',
      shortDescription:
          'Safe techniques and controls for lifting, carrying and moving materials.',
      overview:
          'Manual handling can cause strains, sprains and other musculoskeletal injuries. The preferred approach is to eliminate or reduce manual handling through mechanical assistance and good task planning.',
      hazards:
          'Back injury\n'
          'Muscle strain\n'
          'Crushing injuries\n'
          'Dropped loads\n'
          'Poor posture\n'
          'Repetitive handling',
      controls:
          'Reduce load weight\n'
          'Use mechanical aids\n'
          'Team lifting where appropriate\n'
          'Improve workplace layout\n'
          'Train workers\n'
          'Plan the route',
      planning:
          'Assess load weight, shape, distance, route, frequency and worker capability before handling materials.',
      safePractices:
          'Keep the load close to the body. Avoid twisting while carrying. Use mechanical aids where practicable and ask for assistance for difficult loads.',
      ppe:
          'Safety footwear\n'
          'Suitable gloves\n'
          'High-visibility clothing where required',
      checklist:
          'Load assessed\n'
          'Route clear\n'
          'Mechanical aid available\n'
          'Team lift arranged where required\n'
          'Worker trained',
      inspection:
          'Check handling aids\n'
          'Check route\n'
          'Check storage arrangement\n'
          'Check load stability',
      dos:
          'Plan the lift\n'
          'Use mechanical assistance\n'
          'Keep load close\n'
          'Ask for assistance',
      donts:
          'Do not attempt unsafe loads alone\n'
          'Do not twist while lifting\n'
          'Do not carry loads that block your vision',
      stopWork:
          'Stop the task if the load is too heavy, unstable or the route is unsafe.',
      emergency:
          'Stop activity and seek first aid or medical assistance for injury. Report the incident according to site procedure.',
      malayalam:
          'Manual handling ചെയ്യുന്നതിന് മുമ്പ് load weight, shape, route എന്നിവ വിലയിരുത്തുക. കഴിയുന്നിടത്ത് trolley/hoist പോലുള്ള mechanical aid ഉപയോഗിക്കുക. Unsafe load ഒറ്റയ്ക്ക് ഉയർത്തരുത്.',
    ),

    ReferenceTopic(
      title: 'Permit to Work',
      category: GuidelineCategory.uaeGeneral,
      sourceLabel: 'UAE HSE – Permit to Work Reference',
      copNumber: 'Permit to Work System',
      version: 'Reference V1.0',
      effectiveDate: 'Verify current authority requirements',
      shortDescription:
          'A controlled system for managing high-risk work activities.',
      overview:
          'A Permit to Work system formally identifies hazards, controls, responsibilities and conditions for specified high-risk activities.',
      hazards:
          'Uncontrolled high-risk work\n'
          'Unexpected energy release\n'
          'Fire and explosion\n'
          'Conflicting activities\n'
          'Unauthorised work',
      controls:
          'Correct permit type\n'
          'Risk assessment\n'
          'Isolation\n'
          'Authorisation\n'
          'Site verification\n'
          'Permit display\n'
          'Permit close-out',
      planning:
          'Identify the work scope, hazards, controls, isolation requirements and responsible persons before issuing the permit.',
      safePractices:
          'Follow permit conditions exactly. Stop and revalidate if conditions change. Close the permit correctly after work completion.',
      ppe:
          'Task-specific PPE as defined by risk assessment and permit',
      checklist:
          'Correct permit selected\n'
          'Risk assessment completed\n'
          'Controls verified\n'
          'Isolation confirmed\n'
          'Authorisation obtained\n'
          'Permit displayed\n'
          'Close-out completed',
      inspection:
          'Check work area\n'
          'Check isolation\n'
          'Check controls\n'
          'Check permit conditions\n'
          'Check simultaneous activities',
      dos:
          'Read and understand permit conditions\n'
          'Follow controls\n'
          'Stop if conditions change\n'
          'Close permit correctly',
      donts:
          'Do not work outside permit scope\n'
          'Do not bypass controls\n'
          'Do not continue when permit conditions are no longer valid',
      stopWork:
          'Stop work immediately when permit conditions change, controls fail or the work scope changes.',
      emergency:
          'Stop the activity, make the area safe where possible and follow the site emergency procedure. Revalidate the permit before restarting work.',
      malayalam:
          'Permit to Work high-risk activities control ചെയ്യാനുള്ള പ്രധാന system ആണ്. Permit-ന്റെ conditions മനസ്സിലാക്കി അതനുസരിച്ച് മാത്രം ജോലി ചെയ്യുക. Conditions മാറിയാൽ work stop ചെയ്ത് permit revalidate ചെയ്യണം.',
    ),

    ReferenceTopic(
      title: 'Abu Dhabi OSH Requirements',
      category: GuidelineCategory.abuDhabi,
      sourceLabel: 'Abu Dhabi Occupational Safety & Health',
      copNumber: 'ADOSH-SF Reference',
      version: 'Reference V1.0',
      effectiveDate: 'Verify latest official requirements',
      shortDescription:
          'Abu Dhabi-specific occupational safety and health reference framework.',
      overview:
          'Abu Dhabi workplaces may be subject to emirate-specific occupational safety and health requirements. Organisations should maintain appropriate systems, procedures, risk assessments and records.',
      hazards:
          'Workplace-specific hazards\n'
          'High-risk activities\n'
          'Occupational health exposures\n'
          'Emergency risks\n'
          'Competency gaps',
      controls:
          'Implement an appropriate OSH management system\n'
          'Conduct risk assessments\n'
          'Provide competent supervision\n'
          'Maintain training and records\n'
          'Report and investigate incidents\n'
          'Monitor workplace conditions',
      planning:
          'Identify applicable Abu Dhabi OSH requirements and authority expectations for the specific activity, organisation and sector.',
      safePractices:
          'Follow approved company procedures, risk assessments, method statements and applicable Abu Dhabi requirements.',
      ppe:
          'PPE according to task risk assessment and applicable requirements',
      checklist:
          'Applicable requirements identified\n'
          'Risk assessment available\n'
          'Procedures implemented\n'
          'Competency verified\n'
          'Records maintained\n'
          'Emergency arrangements available',
      inspection:
          'Check workplace controls\n'
          'Check documentation\n'
          'Check training records\n'
          'Check emergency arrangements\n'
          'Check inspection records',
      dos:
          'Verify current requirements\n'
          'Maintain documented controls\n'
          'Ensure competent supervision\n'
          'Report incidents',
      donts:
          'Do not rely on outdated requirements\n'
          'Do not treat reference guidance as a substitute for official requirements',
      stopWork:
          'Stop work where a serious uncontrolled OSH risk exists or required controls are absent.',
      emergency:
          'Follow the organisation emergency plan and relevant Abu Dhabi authority requirements. Contact emergency services where required.',
      malayalam:
          'Abu Dhabi-യിലെ ജോലിസ്ഥലങ്ങളിൽ applicable OSH requirements, company procedures, risk assessment എന്നിവ പാലിക്കണം. Latest official requirements verify ചെയ്യുന്നത് പ്രധാനമാണ്.',
    ),

    ReferenceTopic(
      title: 'Dubai HSE & Construction Safety',
      category: GuidelineCategory.dubai,
      sourceLabel: 'Dubai HSE – Construction Safety Reference',
      copNumber: 'Dubai HSE / Construction Reference',
      version: 'Reference V1.0',
      effectiveDate: 'Verify latest Dubai requirements',
      shortDescription:
          'Dubai-specific HSE reference for construction and workplace activities.',
      overview:
          'Dubai projects may be subject to emirate-specific requirements, authority regulations, project specifications and approved HSE procedures.',
      hazards:
          'Construction hazards\n'
          'Work at height\n'
          'Lifting operations\n'
          'Excavation\n'
          'Electrical hazards\n'
          'Heat stress',
      controls:
          'Project HSE plan\n'
          'Risk assessment\n'
          'Method statement\n'
          'Permit systems\n'
          'Competent supervision\n'
          'Inspection and monitoring\n'
          'Emergency preparedness',
      planning:
          'Identify applicable Dubai authority requirements, project requirements and contractor responsibilities before starting work.',
      safePractices:
          'Follow approved project procedures, method statements, permits and risk controls. Maintain good housekeeping and effective site supervision.',
      ppe:
          'Safety helmet\n'
          'Safety footwear\n'
          'High-visibility clothing\n'
          'Eye protection\n'
          'Task-specific PPE',
      checklist:
          'Project HSE plan available\n'
          'Risk assessment approved\n'
          'Method statement available\n'
          'Permit requirements identified\n'
          'Competent supervision available\n'
          'Emergency plan available',
      inspection:
          'Check site conditions\n'
          'Check access\n'
          'Check work-at-height controls\n'
          'Check lifting controls\n'
          'Check housekeeping\n'
          'Check emergency arrangements',
      dos:
          'Follow approved project controls\n'
          'Maintain records\n'
          'Report hazards\n'
          'Follow Dubai-specific requirements',
      donts:
          'Do not assume one emirate requirement automatically applies everywhere\n'
          'Do not bypass project procedures',
      stopWork:
          'Stop work when a serious uncontrolled hazard is identified or required project controls are absent.',
      emergency:
          'Follow the project emergency response plan and contact the appropriate emergency services where necessary.',
      malayalam:
          'Dubai project-ുകളിൽ project HSE plan, risk assessment, method statement, permit requirements, authority requirements എന്നിവ പാലിക്കണം. Latest applicable requirements verify ചെയ്യുക.',
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
      final categoryMatches =
          _selectedCategory == null ||
          topic.category == _selectedCategory;

      if (!categoryMatches) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      return topic.title.toLowerCase().contains(query) ||
          topic.sourceLabel.toLowerCase().contains(query) ||
          topic.shortDescription.toLowerCase().contains(query) ||
          topic.copNumber.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final topics = _filteredTopics;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        title: const Text(
          'HSE Guidelines',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearch(),
            _buildCategoryFilters(),
            Expanded(
              child: topics.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        4,
                        16,
                        30,
                      ),
                      itemCount: topics.length,
                      itemBuilder: (context, index) {
                        return _buildTopicCard(
                          context,
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

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF7EF),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: Color(0xFF159447),
              size: 26,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'UAE HSE Reference',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Practical safety learning & workplace reference',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _query = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search HSE guidelines...',
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xFF159447),
          ),
          suffixIcon: _query.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _query = '';
                    });
                  },
                  icon: const Icon(Icons.clear_rounded),
                )
              : null,
          filled: true,
          fillColor: const Color(0xFFF6F8F7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    final categories = <GuidelineCategory?>[
      null,
      GuidelineCategory.uaeGeneral,
      GuidelineCategory.abuDhabi,
      GuidelineCategory.dubai,
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          separatorBuilder: (_, __) =>
              const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final category = categories[index];

            final selected =
                _selectedCategory == category;

            final color = category?.color ??
                const Color(0xFF159447);

            final label =
                category?.label ?? 'All UAE';

            final icon =
                category?.icon ??
                Icons.public_rounded;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
              child: AnimatedContainer(
                duration:
                    const Duration(milliseconds: 180),
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 13,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? color
                      : const Color(0xFFF3F5F4),
                  borderRadius:
                      BorderRadius.circular(20),
                  border: Border.all(
                    color: selected
                        ? color
                        : const Color(0xFFE2E5E3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 16,
                      color: selected
                          ? Colors.white
                          : color,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      label,
                      style: TextStyle(
                        color: selected
                            ? Colors.white
                            : const Color(0xFF4B5563),
                        fontSize: 11.5,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTopicCard(
    BuildContext context,
    ReferenceTopic topic,
  ) {
    final categoryColor = topic.category.color;

    return Container(
      margin:
          const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        borderRadius:
            BorderRadius.circular(18),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  GuidelineDetailPage(
                topic: topic,
              ),
            ),
          );
        },
        child: Padding(
          padding:
              const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: categoryColor
                      .withValues(alpha: 0.10),
                  borderRadius:
                      BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.shield_rounded,
                  color: categoryColor,
                  size: 25,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            topic.title,
                            style:
                                const TextStyle(
                              fontSize: 14.5,
                              fontWeight:
                                  FontWeight.w800,
                              color:
                                  Color(0xFF111827),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons
                              .arrow_forward_ios_rounded,
                          size: 14,
                          color:
                              Colors.grey.shade500,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      topic.shortDescription,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                      style:
                          const TextStyle(
                        fontSize: 11.5,
                        height: 1.4,
                        color:
                            Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration:
                                BoxDecoration(
                              color: categoryColor
                                  .withValues(
                                alpha: 0.08,
                              ),
                              borderRadius:
                                  BorderRadius
                                      .circular(8),
                            ),
                            child: Text(
                              topic.category.label,
                              overflow:
                                  TextOverflow
                                      .ellipsis,
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight:
                                    FontWeight.w700,
                                color:
                                    categoryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: Text(
                            topic.sourceLabel,
                            maxLines: 1,
                            overflow:
                                TextOverflow
                                    .ellipsis,
                            style:
                                const TextStyle(
                              fontSize: 9.5,
                              color:
                                  Color(0xFF8A8F98),
                            ),
                          ),
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
    final hasFilter =
        _query.isNotEmpty ||
        _selectedCategory != null;

    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color:
                    const Color(0xFFEAF7EF),
                borderRadius:
                    BorderRadius.circular(22),
              ),
              child: const Icon(
                Icons.search_off_rounded,
                color:
                    Color(0xFF159447),
                size: 34,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No guidelines found',
              style: TextStyle(
                fontSize: 16,
                fontWeight:
                    FontWeight.w800,
                color:
                    Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Try another search term or category.',
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color:
                    Color(0xFF6B7280),
              ),
            ),
            if (hasFilter) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  _searchController
                      .clear();

                  setState(() {
                    _query = '';
                    _selectedCategory =
                        null;
                  });
                },
                icon: const Icon(
                  Icons.refresh_rounded,
                ),
                label:
                    const Text('Reset'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
