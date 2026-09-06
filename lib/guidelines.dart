import 'package:flutter/material.dart';
import 'guideline_detail_page.dart';

class GuidelinesPage extends StatefulWidget {
  const GuidelinesPage({super.key});

  @override
  State<GuidelinesPage> createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  final TextEditingController _searchController =
      TextEditingController();

  String _query = '';
  GuidelineCategory _selectedCategory = GuidelineCategory.all;

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
          'Falls from height\nFalling objects and materials\nScaffold collapse or instability\nOverloading of platforms\nUnsafe access and egress\nAdverse weather conditions',
      controls:
          'Use competent and trained scaffolders\nProvide proper foundations and stability\nInstall guardrails, midrails and toe boards\nProvide safe access and egress\nDisplay inspection status where required\nPrevent unauthorised alteration\nMaintain safe platform loading limits',
      planning:
          'Assess the work area before erection. Confirm ground conditions, access, overhead hazards, nearby electrical services, loading requirements and environmental conditions. Ensure the scaffold arrangement is suitable for the intended work.',
      safePractices:
          'Do not remove guardrails or structural components without authorisation. Keep platforms clean and free from unnecessary materials. Maintain clear access routes and use approved access systems.',
      ppe:
          'Safety helmet\nSafety footwear\nHigh-visibility clothing\nFall protection where required by the risk assessment\nGloves suitable for the task',
      checklist:
          'Scaffold erected by competent persons\nBase and foundations are stable\nGuardrails and toe boards installed\nAccess ladder or stair system provided\nPlatform is complete and suitable\nInspection completed before use\nNo unauthorised modifications',
      inspection:
          'Check structural condition\nCheck ties and stability\nCheck platforms\nCheck guardrails\nCheck toe boards\nCheck access\nCheck for damage or unauthorised alteration',
      dos:
          'Use only inspected and approved scaffolding\nKeep platforms clear\nReport defects immediately\nFollow site access requirements',
      donts:
          'Do not use incomplete scaffolding\nDo not overload platforms\nDo not climb outside approved access\nDo not modify scaffolding without authorisation',
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
          'Falls from edges\nFalls through openings\nFalls from ladders\nFalling tools and materials\nUnsafe temporary platforms\nPoor weather conditions',
      controls:
          'Avoid work at height where practicable\nUse suitable collective protection\nProvide safe access and working platforms\nProtect openings and edges\nUse fall protection when required\nControl dropped objects\nEnsure workers are competent',
      planning:
          'Complete a task-specific risk assessment and identify access requirements, rescue arrangements, weather conditions, equipment and competency requirements before work starts.',
      safePractices:
          'Maintain three points of contact on ladders where appropriate. Keep work platforms clean. Use approved anchor points and fall protection systems where required.',
      ppe:
          'Safety helmet with suitable retention where required\nSafety footwear\nHigh-visibility clothing\nFull body harness where required\nSuitable gloves',
      checklist:
          'Risk assessment completed\nSafe access provided\nEdges protected\nOpenings protected\nEquipment inspected\nRescue plan available\nWorkers competent',
      inspection:
          'Check platforms\nCheck ladders\nCheck guardrails\nCheck anchor points\nCheck harness and lanyards\nCheck openings and edges',
      dos:
          'Plan the work\nUse approved access equipment\nMaintain good housekeeping\nFollow the rescue plan',
      donts:
          'Do not work at height without suitable controls\nDo not use damaged equipment\nDo not improvise anchor points\nDo not throw materials from height',
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
          'Heat exhaustion\nHeat stroke\nDehydration\nFatigue\nReduced concentration\nLoss of physical performance',
      controls:
          'Provide drinking water\nProvide suitable shaded rest areas\nPlan work to reduce heat exposure\nUse appropriate work-rest arrangements\nMonitor workers\nProvide acclimatisation\nTrain workers to recognise symptoms',
      planning:
          'Plan high-risk activities considering temperature, humidity, workload, clothing, worker acclimatisation and availability of shade and drinking water.',
      safePractices:
          'Drink water regularly. Take scheduled rest periods. Report symptoms early. Avoid unnecessary physical exertion during extreme heat conditions.',
      ppe:
          'Lightweight suitable work clothing\nSafety helmet\nSafety footwear\nHigh-visibility clothing\nTask-specific PPE',
      checklist:
          'Drinking water available\nShade/rest area available\nWorkers briefed\nHeat condition monitored\nWork-rest arrangements implemented\nEmergency response available',
      inspection:
          'Check water supply\nCheck shaded rest area\nCheck worker welfare\nCheck heat monitoring arrangements\nCheck communication',
      dos:
          'Drink water regularly\nTake rest breaks\nReport symptoms immediately\nLook after co-workers',
      donts:
          'Do not ignore heat illness symptoms\nDo not restrict access to drinking water\nDo not continue unsafe work during severe symptoms',
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
          'Head injury\nEye injury\nHand injury\nFoot injury\nHearing damage\nRespiratory exposure\nFall from height',
      controls:
          'Complete risk assessment\nSelect suitable PPE\nEnsure correct fit\nTrain workers\nInspect PPE before use\nReplace damaged PPE\nStore PPE correctly',
      planning:
          'Identify hazards first and determine whether engineering or administrative controls can reduce the risk. Select PPE that provides appropriate protection for the remaining risk.',
      safePractices:
          'Wear PPE as required by the task. Inspect before use and report defective equipment. Keep PPE clean and properly stored.',
      ppe:
          'Safety helmet\nSafety glasses\nSafety footwear\nGloves\nHearing protection\nRespiratory protection where required\nFall protection where required',
      checklist:
          'Correct PPE selected\nPPE fits correctly\nPPE inspected\nWorker trained\nDamaged PPE removed\nStorage available',
      inspection:
          'Check cracks\nCheck straps\nCheck lenses\nCheck gloves\nCheck soles\nCheck harness components\nCheck expiry or service requirements where applicable',
      dos:
          'Wear task-specific PPE\nInspect before use\nKeep PPE clean\nReplace defective PPE',
      donts:
          'Do not use damaged PPE\nDo not share PPE where hygiene or fit makes this unsuitable\nDo not modify PPE',
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
          'Falls from ladders\nSlipping\nOverreaching\nElectrical contact\nUnstable ground\nIncorrect ladder selection',
      controls:
          'Use suitable ladder type\nInspect before use\nPlace on stable ground\nSecure where necessary\nMaintain safe contact\nKeep away from electrical hazards',
      planning:
          'Assess whether a ladder is the correct access method. Consider duration, height, task requirements, ground condition and nearby hazards.',
      safePractices:
          'Maintain appropriate contact while climbing. Keep your body within the ladder profile and avoid overreaching. Do not carry loads that prevent safe climbing.',
      ppe:
          'Safety helmet\nSafety footwear\nTask-specific gloves\nFall protection where specifically required',
      checklist:
          'Ladder inspected\nCorrect type selected\nStable base\nSecure position\nAccess area clear\nNo visible damage',
      inspection:
          'Check stiles\nCheck rungs\nCheck feet\nCheck locks\nCheck platform where applicable\nCheck contamination or damage',
      dos:
          'Use a suitable ladder\nInspect before use\nMaintain stable footing\nKeep access area clear',
      donts:
          'Do not use damaged ladders\nDo not overreach\nDo not stand on prohibited steps\nDo not use near electrical hazards without suitable controls',
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
          'Oxygen deficiency\nToxic gases\nFlammable atmosphere\nEngulfment\nRestricted access\nDifficult rescue',
      controls:
          'Permit where required\nAtmospheric testing\nIsolation\nVentilation\nCompetent personnel\nStandby arrangement\nEmergency rescue plan',
      planning:
          'Identify the space, hazards, isolation requirements, atmospheric testing, ventilation, communication and rescue arrangements before entry.',
      safePractices:
          'Follow the entry permit and site procedure. Continuously monitor atmosphere where required. Maintain communication with the attendant.',
      ppe:
          'Safety helmet\nSafety footwear\nGloves\nEye protection\nRespiratory protection where required\nHarness and retrieval equipment where required',
      checklist:
          'Permit approved\nIsolation completed\nAtmosphere tested\nVentilation available\nCommunication available\nRescue plan ready\nCompetent team available',
      inspection:
          'Check entry point\nCheck atmosphere\nCheck ventilation\nCheck communication\nCheck retrieval system\nCheck isolation',
      dos:
          'Follow permit requirements\nTest atmosphere\nMaintain communication\nKeep rescue equipment ready',
      donts:
          'Do not enter without authorisation\nDo not enter an unsafe atmosphere\nDo not attempt an unplanned rescue',
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
          'Fire\nExplosion\nBurns\nWelding fumes\nRadiation\nGas cylinder hazards',
      controls:
          'Hot work permit where required\nRemove combustible materials\nProvide fire extinguishers\nUse fire watch\nControl gas cylinders\nProvide ventilation\nInspect equipment',
      planning:
          'Identify combustible materials, nearby processes, gas cylinders, fire protection, ventilation and emergency arrangements before starting.',
      safePractices:
          'Keep the work area controlled and clean. Use correct welding screens. Secure cylinders and maintain suitable separation and storage arrangements.',
      ppe:
          'Welding helmet or suitable eye protection\nGloves\nFlame-resistant clothing\nSafety footwear\nHearing protection where required\nRespiratory protection where required',
      checklist:
          'Permit available\nCombustibles controlled\nFire extinguisher available\nFire watch assigned\nEquipment inspected\nGas cylinders secured\nVentilation adequate',
      inspection:
          'Check hoses\nCheck regulators\nCheck cables\nCheck cylinders\nCheck fire extinguishers\nCheck surrounding area',
      dos:
          'Obtain required permit\nRemove combustibles\nMaintain fire watch\nInspect equipment',
      donts:
          'Do not start unauthorised hot work\nDo not leave ignition sources uncontrolled\nDo not use damaged hoses or cables',
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
          'Trench collapse\nUnderground services\nFalling materials\nPlant movement\nWater ingress\nFalls into excavation',
      controls:
          'Permit and planning\nService identification\nSuitable shoring or battering\nSafe access\nEdge protection\nPlant exclusion zones\nRegular inspection',
      planning:
          'Identify underground services and ground conditions. Determine protective systems, access, spoil placement, plant movement and emergency arrangements.',
      safePractices:
          'Keep spoil and materials away from excavation edges as required. Provide safe access. Prevent unauthorised entry and maintain suitable barriers.',
      ppe:
          'Safety helmet\nSafety footwear\nHigh-visibility clothing\nGloves\nEye protection where required',
      checklist:
          'Excavation inspected\nServices identified\nProtective system provided\nSafe access provided\nEdges protected\nPlant controlled\nWater controlled',
      inspection:
          'Check excavation walls\nCheck protective systems\nCheck access\nCheck edge protection\nCheck water ingress\nCheck nearby plant',
      dos:
          'Inspect excavation before entry\nMaintain barriers\nFollow approved excavation controls\nReport ground movement',
      donts:
          'Do not enter unsupported unsafe excavation\nDo not place plant too close to edges\nDo not ignore ground movement or water ingress',
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
          'Dropped loads\nCrane overturning\nLoad swing\nEquipment failure\nStruck-by incidents\nOverhead hazards',
      controls:
          'Approved lifting plan\nCompetent lifting team\nInspected equipment\nSuitable rigging\nExclusion zone\nClear communication\nWeather monitoring',
      planning:
          'Determine load weight, centre of gravity, lifting points, equipment capacity, ground conditions, lifting radius and communication arrangements before lifting.',
      safePractices:
          'Use approved lifting accessories. Establish an exclusion zone. Keep personnel away from suspended loads and maintain clear communication between the lifting team.',
      ppe:
          'Safety helmet\nSafety footwear\nHigh-visibility clothing\nGloves\nEye protection where required',
      checklist:
          'Lift planned\nEquipment inspected\nAccessories inspected\nLoad capacity confirmed\nGround condition suitable\nExclusion zone established\nCommunication confirmed',
      inspection:
          'Check crane/equipment\nCheck slings\nCheck shackles\nCheck hooks\nCheck lifting points\nCheck ground condition',
      dos:
          'Use competent personnel\nInspect lifting accessories\nMaintain exclusion zones\nFollow the lifting plan',
      donts:
          'Do not stand under suspended loads\nDo not exceed rated capacity\nDo not use damaged lifting accessories\nDo not lift without proper planning',
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
          'Electric shock\nArc flash\nBurns\nElectrical fire\nDamaged cables\nContact with overhead services',
      controls:
          'Competent persons\nIsolation and lockout\nSuitable protection devices\nInspection and testing\nCable management\nSafe distances\nPermit requirements where applicable',
      planning:
          'Identify electrical sources and nearby services. Determine isolation requirements and ensure only authorised persons perform electrical work.',
      safePractices:
          'Do not use damaged cables or equipment. Keep electrical equipment away from water where appropriate. Maintain safe distances from overhead lines.',
      ppe:
          'Safety helmet\nSafety footwear\nEye protection\nElectrical gloves where required\nArc-rated PPE where required by risk assessment',
      checklist:
          'Isolation identified\nEquipment inspected\nCables protected\nAuthorised persons assigned\nProtection devices available\nArea controlled',
      inspection:
          'Check cables\nCheck plugs\nCheck sockets\nCheck distribution boards\nCheck earthing arrangements\nCheck temporary electrical installations',
      dos:
          'Use authorised personnel\nIsolate before work\nInspect equipment\nReport defects',
      donts:
          'Do not use damaged electrical equipment\nDo not bypass safety devices\nDo not work on live systems unless specifically authorised and controlled',
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
          'Fire\nSmoke inhalation\nExplosion\nBlocked escape routes\nFlammable materials\nIgnition sources',
      controls:
          'Control ignition sources\nStore flammables correctly\nMaintain extinguishers\nKeep exits clear\nProvide alarms\nConduct drills\nTrain workers',
      planning:
          'Identify fire hazards, emergency exits, assembly points, firefighting equipment, alarm arrangements and emergency contacts.',
      safePractices:
          'Keep escape routes clear. Store flammable materials correctly. Report fire hazards and damaged firefighting equipment immediately.',
      ppe:
          'Safety helmet\nSafety footwear\nTask-specific PPE\nFire-resistant PPE where required',
      checklist:
          'Fire exits clear\nExtinguishers available\nAlarm accessible\nAssembly point identified\nFlammable storage controlled\nWorkers briefed',
      inspection:
          'Check extinguishers\nCheck exits\nCheck fire doors\nCheck alarm systems\nCheck emergency signage\nCheck housekeeping',
      dos:
          'Keep exits clear\nReport fire hazards\nKnow the assembly point\nFollow emergency instructions',
      donts:
          'Do not block emergency exits\nDo not misuse fire equipment\nDo not store flammables near uncontrolled ignition sources',
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
          'Back injury\nMuscle strain\nCrushing injuries\nDropped loads\nPoor posture\nRepetitive handling',
      controls:
          'Reduce load weight\nUse mechanical aids\nTeam lifting where appropriate\nImprove workplace layout\nTrain workers\nPlan the route',
      planning:
          'Assess load weight, shape, distance, route, frequency and worker capability before handling materials.',
      safePractices:
          'Keep the load close to the body. Avoid twisting while carrying. Use mechanical aids where practicable and ask for assistance for difficult loads.',
      ppe:
          'Safety footwear\nSuitable gloves\nHigh-visibility clothing where required',
      checklist:
          'Load assessed\nRoute clear\nMechanical aid available\nTeam lift arranged where required\nWorker trained',
      inspection:
          'Check handling aids\nCheck route\nCheck storage arrangement\nCheck load stability',
      dos:
          'Plan the lift\nUse mechanical assistance\nKeep load close\nAsk for assistance',
      donts:
          'Do not attempt unsafe loads alone\nDo not twist while lifting\nDo not carry loads that block your vision',
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
          'Uncontrolled high-risk work\nUnexpected energy release\nFire and explosion\nConflicting activities\nUnauthorised work',
      controls:
          'Correct permit type\nRisk assessment\nIsolation\nAuthorisation\nSite verification\nPermit display\nPermit close-out',
      planning:
          'Identify the work scope, hazards, controls, isolation requirements and responsible persons before issuing the permit.',
      safePractices:
          'Follow permit conditions exactly. Stop and revalidate if conditions change. Close the permit correctly after work completion.',
      ppe:
          'Task-specific PPE as defined by risk assessment and permit',
      checklist:
          'Correct permit selected\nRisk assessment completed\nControls verified\nIsolation confirmed\nAuthorisation obtained\nPermit displayed\nClose-out completed',
      inspection:
          'Check work area\nCheck isolation\nCheck controls\nCheck permit conditions\nCheck simultaneous activities',
      dos:
          'Read and understand permit conditions\nFollow controls\nStop if conditions change\nClose permit correctly',
      donts:
          'Do not work outside permit scope\nDo not bypass controls\nDo not continue when permit conditions are no longer valid',
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
          'Workplace-specific hazards\nHigh-risk activities\nOccupational health exposures\nEmergency risks\nCompetency gaps',
      controls:
          'Implement an appropriate OSH management system\nConduct risk assessments\nProvide competent supervision\nMaintain training and records\nReport and investigate incidents\nMonitor workplace conditions',
      planning:
          'Identify applicable Abu Dhabi OSH requirements and authority expectations for the specific activity, organisation and sector.',
      safePractices:
          'Follow approved company procedures, risk assessments, method statements and applicable Abu Dhabi requirements.',
      ppe:
          'PPE according to task risk assessment and applicable requirements',
      checklist:
          'Applicable requirements identified\nRisk assessment available\nProcedures implemented\nCompetency verified\nRecords maintained\nEmergency arrangements available',
      inspection:
          'Check workplace controls\nCheck documentation\nCheck training records\nCheck emergency arrangements\nCheck inspection records',
      dos:
          'Verify current requirements\nMaintain documented controls\nEnsure competent supervision\nReport incidents',
      donts:
          'Do not rely on outdated requirements\nDo not treat reference guidance as a substitute for official requirements',
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
          'Construction hazards\nWork at height\nLifting operations\nExcavation\nElectrical hazards\nHeat stress',
      controls:
          'Project HSE plan\nRisk assessment\nMethod statement\nPermit systems\nCompetent supervision\nInspection and monitoring\nEmergency preparedness',
      planning:
          'Identify applicable Dubai authority requirements, project requirements and contractor responsibilities before starting work.',
      safePractices:
          'Follow approved project procedures, method statements, permits and risk controls. Maintain good housekeeping and effective site supervision.',
      ppe:
          'Safety helmet\nSafety footwear\nHigh-visibility clothing\nEye protection\nTask-specific PPE',
      checklist:
          'Project HSE plan available\nRisk assessment approved\nMethod statement available\nPermit requirements identified\nCompetent supervision available\nEmergency plan available',
      inspection:
          'Check site conditions\nCheck access\nCheck work-at-height controls\nCheck lifting controls\nCheck housekeeping\nCheck emergency arrangements',
      dos:
          'Follow approved project controls\nMaintain records\nReport hazards\nFollow Dubai-specific requirements',
      donts:
          'Do not assume one emirate requirement automatically applies everywhere\nDo not bypass project procedures',
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
          _selectedCategory == GuidelineCategory.all ||
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
    const categories = [
      GuidelineCategory.all,
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
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final category = categories[index];
            final selected = _selectedCategory == category;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? category.color
                      : const Color(0xFFF3F5F4),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: selected
                        ? category.color
                        : const Color(0xFFE2E5E3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      category.icon,
                      size: 16,
                      color: selected
                          ? Colors.white
                          : category.color,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      category.label,
                      style: TextStyle(
                        color: selected
                            ? Colors.white
                            : const Color(0xFF4B5563),
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
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
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => GuidelineDetailPage(
                topic: topic,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: topic.category.color.withValues(
                    alpha: 0.10,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.shield_rounded,
                  color: topic.category.color,
                  size: 25,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            topic.title,
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF111827),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: Colors.grey.shade500,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      topic.shortDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11.5,
                        height: 1.4,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: topic.category.color
                                  .withValues(alpha: 0.08),
                              borderRadius:
                                  BorderRadius.circular(8),
                            ),
                            child: Text(
                              topic.category.label,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                color: topic.category.color,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: Text(
                            topic.sourceLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 9.5,
                              color: Color(0xFF8A8F98),
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF7EF),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Icon(
                Icons.search_off_rounded,
                color: Color(0xFF159447),
                size: 34,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No guidelines found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Try another search term or category.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
              ),
            ),
            if (_query.isNotEmpty ||
                _selectedCategory != GuidelineCategory.all) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  _searchController.clear();
                  setState(() {
                    _query = '';
                    _selectedCategory =
                        GuidelineCategory.all;
                  });
                },
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Reset'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
