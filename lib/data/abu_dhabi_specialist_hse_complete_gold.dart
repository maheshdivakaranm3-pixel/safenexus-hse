// SafeNexus HSE — Abu Dhabi Specialist HSE — Consolidated Gold Reference
// Canonical consolidated data file for the existing 10 specialist Gold modules.
// Existing topic structures and content are preserved; no new topic filenames are introduced here.
// Regulatory/legal/numerical requirements must always be checked against the current controlled official source.

// ===== SOURCE: abu_dhabi_excavation_gold.dart =====
/// SafeNexus HSE — Abu Dhabi Excavation Gold Standard content.
/// Regulatory baseline: ADOSH-SF CoP 29.0 — Excavation Work, Version 4.1, February 2026.
/// This is a field-reference layer; official ADPHC publications remain controlling for compliance decisions.

class ExcavationGoldPoint {
  final String clause;
  final String title;
  final String meaning;
  final String hazards;
  final String controls;
  final String fieldCheck;
  final String commonMistake;
  final String action;
  final String records;

  const ExcavationGoldPoint({
    required this.clause,
    required this.title,
    required this.meaning,
    required this.hazards,
    required this.controls,
    required this.fieldCheck,
    required this.commonMistake,
    required this.action,
    required this.records,
  });
}

class ExcavationGoldSection {
  final String number;
  final String title;
  final String introduction;
  final ExcavationGoldPoint point;

  const ExcavationGoldSection({
    required this.number,
    required this.title,
    required this.introduction,
    required this.point,
  });
}

const List<ExcavationGoldSection> excavationGoldStandardSections = [
  ExcavationGoldSection(
    number: '01',
    title: 'Definition & Purpose',
    introduction: 'Treat the activity as excavation risk from the planning stage, not only after digging starts.',
    point: ExcavationGoldPoint(
      clause: 'Step 01',
      title: 'Definition & Purpose',
      meaning: 'Excavation covers ground-breaking and earth or rock removal, including digging, trenches, shafts, wells, grading, tunnelling, boring/drilling, post driving, cofferdams and caissons. It also includes work that could strike, damage, undermine or expose underground services or their protective systems.',
      hazards: 'Unexpected collapse, service strike, falls, flooding, hazardous atmosphere and damage to adjacent assets.',
      controls: 'Define scope, competent assessment, documented safe system of work, permits/authorisations where required, competent supervision and task-specific controls.',
      fieldCheck: 'Confirm the actual work scope matches the excavation assessment and approved method.',
      commonMistake: 'Starting from a drawing alone without field verification.',
      action: 'Stop and reassess if the scope or ground/service conditions differ from the approved plan.',
      records: 'Risk assessment, method statement, drawings, permits and site survey.',
    ),
  ),
  ExcavationGoldSection(
    number: '02',
    title: 'Scope & Applications',
    introduction: 'Identify whether another specialist CoP also applies.',
    point: ExcavationGoldPoint(
      clause: 'Step 02',
      title: 'Scope & Applications',
      meaning: 'Apply the excavation controls to trenches, pits, shafts, wells, grading, tunnelling, boring/drilling, post driving and water-excluding structures such as cofferdams and caissons.',
      hazards: 'Controls can be missed when an activity is called piling, boring, roadwork or utility work rather than excavation.',
      controls: 'Map the activity to all applicable CoPs and sector requirements before work starts.',
      fieldCheck: 'Check the task description, plant and location against the approved scope.',
      commonMistake: 'Assuming only traditional digging is excavation.',
      action: 'Add missing interfaces to the risk assessment and safe system of work.',
      records: 'Scope statement, work package, applicable-CoP review.',
    ),
  ),
  ExcavationGoldSection(
    number: '03',
    title: 'Types of Excavation',
    introduction: 'The type affects access, support, water, atmosphere, rescue and public-interface controls.',
    point: ExcavationGoldPoint(
      clause: 'Step 03',
      title: 'Types of Excavation',
      meaning: 'Common field forms include open excavation, trench, pit, deep excavation, shaft, basement excavation, utility trench, grading, boring/drilling, cofferdam and caisson.',
      hazards: 'A control suitable for a shallow open cut may be unsuitable for a deep or confined excavation.',
      controls: 'Select controls based on actual geometry, ground, depth, support method and surrounding conditions.',
      fieldCheck: 'Verify dimensions, access points, support design and plant arrangement.',
      commonMistake: 'Using one standard method for every excavation.',
      action: 'Revise RAMS when geometry or method changes.',
      records: 'Drawings, temporary works/support design, RAMS.',
    ),
  ),
  ExcavationGoldSection(
    number: '04',
    title: 'Components / Parts',
    introduction: 'Understand how each component interacts with ground stability and worker movement.',
    point: ExcavationGoldPoint(
      clause: 'Step 04',
      title: 'Components / Parts',
      meaning: 'Typical components include excavation face, floor/base, edge, support system, walers, struts, sheet piles or proprietary systems, access, barriers, spoil area, plant exclusion zone, drainage/dewatering and monitoring arrangements.',
      hazards: 'Missing or damaged components can create a chain failure.',
      controls: 'Inspect the complete system rather than only the visible excavation face.',
      fieldCheck: 'Walk the perimeter and inspect access, supports, edge controls and loading.',
      commonMistake: 'Checking only depth and ignoring support/access interfaces.',
      action: 'Correct missing components before entry.',
      records: 'Inspection checklist, support information, site layout.',
    ),
  ),
  ExcavationGoldSection(
    number: '05',
    title: 'Pre-Excavation Planning',
    introduction: 'Planning must be completed before excavation starts and updated when conditions change.',
    point: ExcavationGoldPoint(
      clause: 'Step 05',
      title: 'Pre-Excavation Planning',
      meaning: 'Planning must address risk assessment, safe systems of work, emergency arrangements, permits/authorisations, services, site survey, surrounding properties, equipment and supervision.',
      hazards: 'Unplanned excavation can encounter unknown services, unstable ground or public exposure.',
      controls: 'Use competent assessment and documented controls; include excavation requirements in the construction OSH management system where applicable.',
      fieldCheck: 'Ask: What can collapse, fall, flood, ignite, electrocute, gas, or be struck?',
      commonMistake: 'Starting with the excavator before completing planning.',
      action: 'Hold the start until critical controls are verified.',
      records: 'RA, RAMS, permits, survey, emergency plan.',
    ),
  ),
  ExcavationGoldSection(
    number: '06',
    title: 'Site Investigation',
    introduction: 'The investigation must consider ground and water conditions.',
    point: ExcavationGoldPoint(
      clause: 'Step 06',
      title: 'Site Investigation',
      meaning: 'Use available drawings, maps, specifications, borehole/trial-pit information and surrounding-property information. Confirm boundaries and relevant historical, geological or archaeological constraints.',
      hazards: 'Old wells, voids, disturbed fill or contaminated ground may not be obvious from the surface.',
      controls: 'Use competent survey/investigation and escalate unknown conditions.',
      fieldCheck: 'Compare site findings with the investigation information.',
      commonMistake: 'Treating geotechnical information as permanently accurate despite changed conditions.',
      action: 'Pause and obtain competent assessment when conditions differ.',
      records: 'Survey, geotechnical records, trial-pit/borehole logs.',
    ),
  ),
  ExcavationGoldSection(
    number: '07',
    title: 'Ground / Soil Conditions',
    introduction: 'Temporary stability depends on the actual ground condition and whether it is dry or wet.',
    point: ExcavationGoldPoint(
      clause: 'Step 07',
      title: 'Ground / Soil Conditions',
      meaning: 'Identify the ground type and review its stability, water table, contamination and previous disturbance before excavation.',
      hazards: 'Drying, saturation, vibration, adjacent voids and weather can change stability.',
      controls: 'Select safe slope/support method based on actual conditions and competent assessment.',
      fieldCheck: 'Look for cracks, slumping, seepage, loose material, tension cracks and movement.',
      commonMistake: 'Assuming the exposed face represents all surrounding ground.',
      action: 'Stop entry and reassess when instability indicators appear.',
      records: 'Ground assessment, inspection records, support design.',
    ),
  ),
  ExcavationGoldSection(
    number: '08',
    title: 'Underground Services',
    introduction: 'Services include electrical, gas, water, sewer, telecom, oil and other buried assets.',
    point: ExcavationGoldPoint(
      clause: 'Step 08',
      title: 'Underground Services',
      meaning: 'Before excavation, identify and validate services using utility information, competent survey, avoidance tools and physical verification as required. Treat identified services as live/in service unless formally confirmed otherwise.',
      hazards: 'Service strike can cause electrocution, fire, explosion, flooding, environmental release and service outage.',
      controls: 'Obtain relevant permits/NOCs; locate and mark services; use approved safe-digging controls; protect/support exposed services.',
      fieldCheck: 'Verify plans against field markings and trial holes.',
      commonMistake: 'Relying only on old drawings.',
      action: 'Stop immediately for an uncharted service and reassess before restart.',
      records: 'Utility plans, NOCs, permits, survey/locator records, service-owner communications.',
    ),
  ),
  ExcavationGoldSection(
    number: '09',
    title: 'Excavation Hazards',
    introduction: 'Hazard identification must cover workers, contractors, visitors, public, plant, structures and environment.',
    point: ExcavationGoldPoint(
      clause: 'Step 09',
      title: 'Excavation Hazards',
      meaning: 'Core hazards include collapse, falling material, falls into excavation, service strike, flooding, hazardous atmosphere, plant intrusion, edge loading, adjacent-structure instability and public exposure.',
      hazards: 'Multiple hazards can interact and amplify consequences.',
      controls: 'Apply the hierarchy of controls and critical-control verification.',
      fieldCheck: 'Perform a physical walkdown before each shift.',
      commonMistake: 'Using PPE as the primary control for structural hazards.',
      action: 'Control the hazard at source and stop work for failed critical controls.',
      records: 'RA/JSA, inspection, observations, incident/near-miss records.',
    ),
  ),
  ExcavationGoldSection(
    number: '10',
    title: 'Hazard Identification',
    introduction: 'Use drawings plus physical inspection and worker input.',
    point: ExcavationGoldPoint(
      clause: 'Step 10',
      title: 'Hazard Identification',
      meaning: 'Identify hazards from ground condition, geometry, services, plant, water, weather, atmosphere, access, edge protection and adjacent activities.',
      hazards: 'Conditions may change faster than paperwork.',
      controls: 'Reassess after rain, water ingress, service discovery, support change, plant relocation or scope change.',
      fieldCheck: 'Look for change indicators at the excavation face and perimeter.',
      commonMistake: 'Assuming yesterday’s inspection covers today’s conditions.',
      action: 'Update controls before resuming affected work.',
      records: 'Daily/shift inspection and dynamic risk assessment.',
    ),
  ),
  ExcavationGoldSection(
    number: '11',
    title: 'Causes',
    introduction: 'Understanding causes helps select prevention rather than only response.',
    point: ExcavationGoldPoint(
      clause: 'Step 11',
      title: 'Causes',
      meaning: 'Typical causes include inadequate investigation, unsupported excavation, unsuitable slope, poor support installation, edge loading, vibration, water ingress, service damage, poor access, inadequate supervision and changed conditions.',
      hazards: 'A minor control failure can progress to collapse or service incident.',
      controls: 'Trace each hazard back to a controllable cause and assign an owner.',
      fieldCheck: 'Ask why the condition exists, not only what is wrong.',
      commonMistake: 'Correcting symptoms while leaving the cause.',
      action: 'Record root cause and verify permanent corrective action.',
      records: 'Observation reports, corrective-action records.',
    ),
  ),
  ExcavationGoldSection(
    number: '12',
    title: 'Risk & Consequences',
    introduction: 'Risk assessment should consider severity, likelihood, exposure and credible escalation.',
    point: ExcavationGoldPoint(
      clause: 'Step 12',
      title: 'Risk & Consequences',
      meaning: 'Consequences can include fatal burial/crushing, falls, electrocution, gas release, fire/explosion, drowning, toxic exposure, structural damage, public injury and environmental contamination.',
      hazards: 'Excavation incidents can develop rapidly with limited escape time.',
      controls: 'Prioritise collapse, service strike, atmosphere, flooding and vehicle intrusion as critical scenarios where applicable.',
      fieldCheck: 'Check whether rescue is realistically possible under the proposed controls.',
      commonMistake: 'Having a rescue plan that depends on unprotected entry.',
      action: 'Strengthen prevention and ensure rescue arrangements are practical.',
      records: 'Risk register, emergency plan, rescue assessment.',
    ),
  ),
  ExcavationGoldSection(
    number: '13',
    title: 'Hierarchy of Controls',
    introduction: 'Structural protection should not depend solely on worker behaviour.',
    point: ExcavationGoldPoint(
      clause: 'Step 13',
      title: 'Hierarchy of Controls',
      meaning: 'Eliminate unnecessary excavation where practicable; substitute methods; isolate services/areas; use engineering controls such as shoring, barriers and safe slopes; then administrative controls and PPE.',
      hazards: 'Administrative controls alone can fail during plant movement or ground collapse.',
      controls: 'Prefer engineered controls and verify their installation and condition.',
      fieldCheck: 'Check whether a lower-level control is being used because a higher-level control was skipped.',
      commonMistake: '“Wear PPE” used as the main control for collapse.',
      action: 'Upgrade the control hierarchy before work continues.',
      records: 'RA hierarchy, engineering/support design, inspection evidence.',
    ),
  ),
  ExcavationGoldSection(
    number: '14',
    title: 'Shoring / Timbering',
    introduction: 'Support may include sheeting/waling/strutting, hydraulic struts, proprietary systems or soldier piles.',
    point: ExcavationGoldPoint(
      clause: 'Step 14',
      title: 'Shoring / Timbering',
      meaning: 'For trenches/excavations greater than 1.2 m where there is danger of material falling or collapse, provide timbering or shoring. Support systems must be suitable, secure, maintained and handled by competent personnel.',
      hazards: 'Collapse during support installation or removal can trap workers.',
      controls: 'Install support without unnecessary delay; use interim protection where entry is needed during installation; do not alter support without competent control.',
      fieldCheck: 'Inspect alignment, tightness, displacement, damage and loading.',
      commonMistake: 'Entering an unsupported section to install permanent support.',
      action: 'Use appropriate interim protection and complete full support before other work.',
      records: 'Support design, installation records, inspections, engineer/competent-person records.',
    ),
  ),
  ExcavationGoldSection(
    number: '15',
    title: 'Battering / Benching / Sloping',
    introduction: 'CoP 29.0 provides a table of temporary safe slopes by ground type and condition; engineering judgement and site-specific conditions still matter.',
    point: ExcavationGoldPoint(
      clause: 'Step 15',
      title: 'Battering / Benching / Sloping',
      meaning: 'Temporary safe slopes must be selected from the applicable ground condition and dry/wet condition rather than a single universal angle.',
      hazards: 'Using a dry-ground angle in wet or changed conditions can reduce stability.',
      controls: 'Confirm ground classification, water condition and applicable slope requirement before cutting.',
      fieldCheck: 'Measure/verify geometry and inspect for slumping or cracking.',
      commonMistake: 'Using “one angle fits all” or relying on memory.',
      action: 'Stop and reassess if ground condition changes.',
      records: 'Ground assessment, drawings, slope/support records.',
    ),
  ),
  ExcavationGoldSection(
    number: '16',
    title: 'Dimensions, Depths & Safe Limits',
    introduction: 'These values must be applied with the exact conditions stated in the CoP, not as universal rules outside their context.',
    point: ExcavationGoldPoint(
      clause: 'Step 16',
      title: 'Dimensions, Depths & Safe Limits',
      meaning: 'Key verified CoP values include the >1.2 m shoring threshold where collapse/material-fall danger exists, 4:1 ladder positioning where reasonably practicable, 1 m/4-rung ladder projection, 2 m fall criterion for rigid barriers, and 950 mm barrier height.',
      hazards: 'Misapplying a threshold can create false assurance.',
      controls: 'Show the requirement context in the RAMS/checklist.',
      fieldCheck: 'Verify the actual dimension and the condition triggering the requirement.',
      commonMistake: 'Copying a number without its qualifying condition.',
      action: 'Escalate ambiguous cases to the competent person/engineer and official source.',
      records: 'Inspection measurements, support design, CoP reference.',
    ),
  ),
  ExcavationGoldSection(
    number: '17',
    title: 'Access & Egress',
    introduction: 'Access must remain usable throughout the shift and during foreseeable emergencies.',
    point: ExcavationGoldPoint(
      clause: 'Step 17',
      title: 'Access & Egress',
      meaning: 'Provide safe means of entering and leaving the excavation. Ladders must be secure, maintained and positioned for quick escape; walings and struts must not be used as access routes.',
      hazards: 'Blocked, damaged or poorly positioned access delays escape.',
      controls: 'Provide protected access and keep routes clear of plant, spoil and materials.',
      fieldCheck: 'Test access physically rather than only checking its presence.',
      commonMistake: 'Using support members as stairs or climbing over barriers.',
      action: 'Restore safe access before allowing entry.',
      records: 'Access inspection, ladder inspection.',
    ),
  ),
  ExcavationGoldSection(
    number: '18',
    title: 'Ladders',
    introduction: 'Position ladders away from plant and material-handling damage.',
    point: ExcavationGoldPoint(
      clause: 'Step 18',
      title: 'Ladders',
      meaning: 'Where reasonably practicable, position ladders at a height-to-base ratio not flatter than 4:1, secure the upper end, and project at least 1 m/4 rungs above ground for handhold.',
      hazards: 'Slipping, short projection, obstruction or poor landing can cause falls.',
      controls: 'Secure, inspect and protect ladders; maintain a stable landing/exit.',
      fieldCheck: 'Check angle, securing, projection, condition and landing.',
      commonMistake: 'Unsecured ladder or insufficient projection.',
      action: 'Remove defective ladders and provide compliant access.',
      records: 'Ladder inspection, pre-start checklist.',
    ),
  ),
  ExcavationGoldSection(
    number: '19',
    title: 'Edge Protection & Barricading',
    introduction: 'Barriers also help keep people, plant and materials away from excavation edges.',
    point: ExcavationGoldPoint(
      clause: 'Step 19',
      title: 'Edge Protection & Barricading',
      meaning: 'Where fall potential exceeds 2 m, provide appropriate rigid barriers; below 2 m, provide physical edge demarcation. CoP 29.0 specifies 950 mm barrier height.',
      hazards: 'Missing barriers expose workers/public and permit plant intrusion.',
      controls: 'Use suitable barriers, warning signs, wheel stops and hazard lights where required.',
      fieldCheck: 'Inspect continuity, stability, visibility and access gates.',
      commonMistake: 'Removing barriers and failing to replace them.',
      action: 'Reinstate immediately when reasonably practicable and control the opening.',
      records: 'Barricade inspection, traffic/public protection records.',
    ),
  ),
  ExcavationGoldSection(
    number: '20',
    title: 'Spoil / Material / Plant Setback',
    introduction: 'Edge loading can increase ground pressure and collapse risk.',
    point: ExcavationGoldPoint(
      clause: 'Step 20',
      title: 'Spoil / Material / Plant Setback',
      meaning: 'Keep spoil, materials and heavy plant away from excavation edges unless the support/temporary works arrangement has been specifically designed for the imposed loading.',
      hazards: 'Spoil slumping and vehicle overrun can add sudden loads.',
      controls: 'Use defined exclusion zones and engineered arrangements for unavoidable close loading.',
      fieldCheck: 'Check where spoil is piled and where plant wheels/tracks are operating.',
      commonMistake: 'Allowing dumpers to reverse to an unprotected edge.',
      action: 'Move loads back or provide designed protection such as baulk timbers where applicable.',
      records: 'Site layout, inspection, temporary works/support assessment.',
    ),
  ),
  ExcavationGoldSection(
    number: '21',
    title: 'Water / Dewatering / Flooding',
    introduction: 'Dewatering must also control discharge and prevent environmental harm.',
    point: ExcavationGoldPoint(
      clause: 'Step 21',
      title: 'Water / Dewatering / Flooding',
      meaning: 'Assess groundwater and water ingress. Dewatering may use methods such as shallow wells or well-pointing; sheet piling may reduce ingress in suitable conditions.',
      hazards: 'Water can weaken faces/support, destabilise the base and create drowning/electrical hazards.',
      controls: 'Provide drainage/dewatering suitable for the ground and protect drains/watercourses from silty discharge.',
      fieldCheck: 'Inspect pumps, hoses, discharge path, water level and erosion.',
      commonMistake: 'Pumping dirty water directly into drains or ignoring rising water.',
      action: 'Stop entry when water compromises stability or escape and implement the approved response.',
      records: 'Dewatering plan, discharge approval/records, inspections.',
    ),
  ),
  ExcavationGoldSection(
    number: '22',
    title: 'Atmospheric Hazards & Ventilation',
    introduction: 'Deep or confined excavations may require continuous routine air testing under CoP 27.0.',
    point: ExcavationGoldPoint(
      clause: 'Step 22',
      title: 'Atmospheric Hazards & Ventilation',
      meaning: 'Excavations may accumulate suffocating, toxic or explosive gases such as H2S, methane or sulphur dioxide, or exhaust gases and LPG leakage.',
      hazards: 'Gas accumulation can cause poisoning, oxygen deficiency, fire or explosion.',
      controls: 'Assess atmosphere, ventilate with clean air where appropriate, control ignition sources and apply confined-space requirements when applicable.',
      fieldCheck: 'Consider gas sources, smell reports, plant exhaust and test results.',
      commonMistake: 'Assuming open-top excavation means no atmospheric hazard.',
      action: 'Evacuate for dangerous readings/conditions and follow the emergency procedure.',
      records: 'Gas-test records, ventilation plan, confined-space assessment.',
    ),
  ),
  ExcavationGoldSection(
    number: '23',
    title: 'Plant & Vehicle Interface',
    introduction: 'Use competent operators, banksmen where required, exclusion zones and physical stops.',
    point: ExcavationGoldPoint(
      clause: 'Step 23',
      title: 'Plant & Vehicle Interface',
      meaning: 'Plant and vehicles must be controlled so their loading, movement and vibration do not undermine the excavation or allow entry into it.',
      hazards: 'Reversing, edge overrun and vibration can cause collapse or worker strike.',
      controls: 'Separate people and plant; use wheel stops/baulks/barriers where appropriate.',
      fieldCheck: 'Observe actual wheel/track positions, swing radius and edge condition.',
      commonMistake: 'Relying only on painted lines near a collapse hazard.',
      action: 'Stop movement and reposition plant when exclusion controls fail.',
      records: 'Traffic plan, plant inspection, banksman records, site inspection.',
    ),
  ),
  ExcavationGoldSection(
    number: '24',
    title: 'Adjacent Structures',
    introduction: 'Inspect adjoining properties where necessary and monitor changes during excavation.',
    point: ExcavationGoldPoint(
      clause: 'Step 24',
      title: 'Adjacent Structures',
      meaning: 'Excavation must not jeopardise the stability of adjacent buildings, walls, roads, utilities or other structures.',
      hazards: 'Loss of support can cause settlement, cracking or collapse.',
      controls: 'Use competent assessment, staged excavation, suitable support and monitoring where required.',
      fieldCheck: 'Look for cracks, settlement, movement, distortion and vibration effects.',
      commonMistake: 'Ignoring pre-existing defects or assuming they are unrelated.',
      action: 'Stop and escalate structural movement immediately.',
      records: 'Condition survey, monitoring records, engineering assessment.',
    ),
  ),
  ExcavationGoldSection(
    number: '25',
    title: 'Road / Public Interface',
    introduction: 'Public protection continues outside normal working hours.',
    point: ExcavationGoldPoint(
      clause: 'Step 25',
      title: 'Road / Public Interface',
      meaning: 'Road excavation requires appropriate authority approvals, barricades and warning arrangements, with traffic controls under the applicable road-work requirements.',
      hazards: 'Vehicle impact and pedestrian entry can create multiple-casualty incidents.',
      controls: 'Use approved traffic management, barriers, warning signs/lights and protected pedestrian routes.',
      fieldCheck: 'Inspect traffic-facing barricades, reflective markings and pedestrian continuity.',
      commonMistake: 'Leaving an excavation inadequately protected after the crew leaves.',
      action: 'Secure the site and restore public protection before demobilisation.',
      records: 'Traffic plan, approvals, inspection records.',
    ),
  ),
  ExcavationGoldSection(
    number: '26',
    title: 'Lighting / Night Work',
    introduction: 'Lighting must support safe movement without creating glare or shadow hazards.',
    point: ExcavationGoldPoint(
      clause: 'Step 26',
      title: 'Lighting / Night Work',
      meaning: 'Provide appropriate workplace lighting, especially at access points and openings and during lifting operations. During darkness, excavation edges near public thoroughfares require hazard warning lights.',
      hazards: 'Poor visibility hides edges, supports, plant and people.',
      controls: 'Use adequate lighting, protected electrical supplies and emergency lighting where required.',
      fieldCheck: 'Check illumination at the actual workface and access points.',
      commonMistake: 'Lighting only the general area while leaving excavation edges dark.',
      action: 'Suspend night work if safe visibility cannot be maintained.',
      records: 'Lighting inspection, electrical inspection.',
    ),
  ),
  ExcavationGoldSection(
    number: '27',
    title: 'RAMS / JSA / Risk Assessment',
    introduction: 'Where required by the risk, implement a permit-to-work system in accordance with CoP 21.0.',
    point: ExcavationGoldPoint(
      clause: 'Step 27',
      title: 'RAMS / JSA / Risk Assessment',
      meaning: 'The excavation risk assessment and documented safe system of work must define the method, hazards, controls, emergency arrangements, services and interfaces.',
      hazards: 'Generic RAMS may omit site-specific services or ground conditions.',
      controls: 'Use task-specific, location-specific RAMS and brief affected workers.',
      fieldCheck: 'Compare the approved RAMS against what is actually happening.',
      commonMistake: 'Using a copied RAMS for a different location.',
      action: 'Stop work and revise the safe system when critical conditions change.',
      records: 'RA, JSA, RAMS, briefing attendance, permit.',
    ),
  ),
  ExcavationGoldSection(
    number: '28',
    title: 'Permit / Authorization / NOC',
    introduction: 'Requirements depend on location, asset owner, sector and task.',
    point: ExcavationGoldPoint(
      clause: 'Step 28',
      title: 'Permit / Authorization / NOC',
      meaning: 'Obtain applicable work permits, authorisations, notifications and utility approvals/NOCs before excavation begins.',
      hazards: 'Unauthorised excavation can expose workers and third parties to uncontrolled risks.',
      controls: 'Create a permit/NOC matrix and verify validity, boundaries and conditions.',
      fieldCheck: 'Check permit location, date, scope and outstanding conditions.',
      commonMistake: 'Treating an expired or different-location permit as valid.',
      action: 'Suspend work until correct authorisation is in place.',
      records: 'Permit, NOC, approval, service-owner communication.',
    ),
  ),
  ExcavationGoldSection(
    number: '29',
    title: 'Safe Work Procedure',
    introduction: 'The sequence must be adapted to the approved method and engineering controls.',
    point: ExcavationGoldPoint(
      clause: 'Step 29',
      title: 'Safe Work Procedure',
      meaning: 'A safe sequence is: plan → survey → services validation → permits → barricade → prepare access → start excavation → install support/slopes → control spoil/plant → inspect → continue with monitoring → backfill/reinstate safely.',
      hazards: 'Skipping early controls transfers risk into the excavation.',
      controls: 'Use hold points for services, support, inspection and changed conditions.',
      fieldCheck: 'Verify each hold point before progression.',
      commonMistake: 'Excavating ahead of the support/verification sequence.',
      action: 'Stop at the failed hold point and correct before proceeding.',
      records: 'Method statement, inspection/hold-point records.',
    ),
  ),
  ExcavationGoldSection(
    number: '30',
    title: 'Inspection & Examination',
    introduction: 'Maintenance inspection must also watch timber/support, soil condition, struts, weather effects and plant loading.',
    point: ExcavationGoldPoint(
      clause: 'Step 30',
      title: 'Inspection & Examination',
      meaning: 'Excavations must be inspected by an experienced competent person before work starts, at least once a day and before each shift. Thorough examination is required weekly/every seven days and after substantial collapse or damage, with results recorded.',
      hazards: 'Conditions can deteriorate after weather, vibration, drying/shrinkage or support movement.',
      controls: 'Use a structured checklist and record findings and actions.',
      fieldCheck: 'Inspect faces, support, access, barriers, water, atmosphere, edge loading and adjacent structures.',
      commonMistake: 'Signing a checklist without physically inspecting.',
      action: 'Prevent entry until critical defects are controlled.',
      records: 'Daily/shift inspection, weekly examination, corrective-action records.',
    ),
  ),
  ExcavationGoldSection(
    number: '31',
    title: 'Competency & Responsibilities',
    introduction: 'Training includes hazards, risk assessment, safe systems, emergency rescue, first aid, night excavation, debris removal, security and restrictions.',
    point: ExcavationGoldPoint(
      clause: 'Step 31',
      title: 'Competency & Responsibilities',
      meaning: 'Employers must provide training appropriate to excavation work for workers, safe-system writers, site managers, supervisors, machinery/plant operators and PPE users.',
      hazards: 'Untrained people may not recognise early collapse or gas indicators.',
      controls: 'Verify role-specific competency and refresher training when duties or hazards change.',
      fieldCheck: 'Ask workers to explain critical controls and emergency actions.',
      commonMistake: 'Assuming site induction alone is excavation competency.',
      action: 'Remove unqualified personnel from critical tasks and arrange competent supervision/training.',
      records: 'Training matrix, competency evidence, toolbox records.',
    ),
  ),
  ExcavationGoldSection(
    number: '32',
    title: 'PPE',
    introduction: 'PPE does not replace shoring, barriers, service controls or safe access.',
    point: ExcavationGoldPoint(
      clause: 'Step 32',
      title: 'PPE',
      meaning: 'PPE is the final layer and must match the assessed hazards: helmet, safety footwear, high-visibility clothing, gloves, eye/face protection, hearing protection and respiratory/fall protection where specifically required.',
      hazards: 'Wrong PPE or poor fit can create false confidence.',
      controls: 'Select PPE from the risk assessment and ensure inspection, fit and worker training.',
      fieldCheck: 'Check condition and suitability before work.',
      commonMistake: 'Using generic PPE without considering task hazards.',
      action: 'Replace defective PPE and correct the underlying control gap.',
      records: 'PPE assessment, issue/inspection records.',
    ),
  ),
  ExcavationGoldSection(
    number: '33',
    title: 'Emergency / Rescue',
    introduction: 'Rescue planning must not require unprotected rescuers to enter a collapsed or contaminated excavation.',
    point: ExcavationGoldPoint(
      clause: 'Step 33',
      title: 'Emergency / Rescue',
      meaning: 'Prepare for collapse, flooding, service strike, gas release, fire/explosion, fall, plant intrusion and medical emergencies.',
      hazards: 'Secondary casualties are a major rescue risk.',
      controls: 'Define alarm, evacuation, isolation, access for emergency services, first aid and competent rescue arrangements.',
      fieldCheck: 'Check emergency access and communication at the excavation.',
      commonMistake: 'Workers entering to rescue a buried colleague without assessment.',
      action: 'Raise alarm, isolate hazards where safe, evacuate and call emergency response; follow the site rescue plan.',
      records: 'Emergency plan, drill records, contact list.',
    ),
  ),
  ExcavationGoldSection(
    number: '34',
    title: 'Stop-Work Conditions',
    introduction: 'Stop-work is a control, not a failure.',
    point: ExcavationGoldPoint(
      clause: 'Step 34',
      title: 'Stop-Work Conditions',
      meaning: 'Stop when there is collapse, cracking, bulging, slumping, unexpected movement, damaged/incomplete support, unexpected water/ground condition, unidentified service, dangerous atmosphere, unsafe access, unsafe edge loading, failed barricading or missing required authorisation.',
      hazards: 'Continuing after a critical-control failure can turn a warning sign into a fatal incident.',
      controls: 'Give workers authority to stop and establish clear escalation.',
      fieldCheck: 'Verify the reason for stop, make the area safe and reassess.',
      commonMistake: 'Restarting because production pressure exists.',
      action: 'Restart only after competent review and required approvals/controls are restored.',
      records: 'Stop-work record, revised RA/RAMS, approval to restart.',
    ),
  ),
  ExcavationGoldSection(
    number: '35',
    title: 'Unsafe Practices → Corrective Actions',
    introduction: 'Each unsafe practice needs a direct correction plus root-cause follow-up.',
    point: ExcavationGoldPoint(
      clause: 'Step 35',
      title: 'Unsafe Practices → Corrective Actions',
      meaning: 'Examples include unsupported entry, climbing struts, unprotected edge, spoil at edge, plant overrun, service strike, poor ladder, missing inspection and uncontrolled water.',
      hazards: 'Repeated unsafe practices indicate a system weakness.',
      controls: 'Use observation → immediate control → root cause → corrective action → verification.',
      fieldCheck: 'Record before/after evidence where practical.',
      commonMistake: 'Closing observations without verifying the field condition.',
      action: 'Do not close until the responsible person and HSE verify effectiveness.',
      records: 'Observation, NCR, corrective-action evidence.',
    ),
  ),
  ExcavationGoldSection(
    number: '36',
    title: 'Toolbox Talk',
    introduction: 'Workers should be encouraged to report changes and unknown services.',
    point: ExcavationGoldPoint(
      clause: 'Step 36',
      title: 'Toolbox Talk',
      meaning: 'Toolbox talk should cover today’s excavation location, depth/method, ground condition, services, support/slopes, access, edge controls, plant movement, water, atmosphere, emergency and stop-work triggers.',
      hazards: 'Poor briefings create different assumptions among crews.',
      controls: 'Use a site-specific briefing at the workface and confirm understanding.',
      fieldCheck: 'Ask workers to identify the nearest access and emergency route.',
      commonMistake: 'Reading a generic toolbox talk without discussing the actual excavation.',
      action: 'Re-brief after any material change.',
      records: 'Toolbox attendance, briefing content, questions/actions.',
    ),
  ),
  ExcavationGoldSection(
    number: '37',
    title: 'Field Checklist / Quick Reference',
    introduction: 'Use this as a rapid check; the full RAMS/CoP remains controlling.',
    point: ExcavationGoldPoint(
      clause: 'Step 37',
      title: 'Field Checklist / Quick Reference',
      meaning: 'Field sequence: Permit/NOC → service search/validation → ground assessment → support/slope → access → barriers → spoil/plant control → water → atmosphere → lighting → inspection → emergency readiness.',
      hazards: 'A quick checklist can miss project-specific engineering requirements if used alone.',
      controls: 'Link every checklist item to the applicable detailed control and record.',
      fieldCheck: 'Walk the full perimeter and entry route.',
      commonMistake: 'Checking boxes remotely without seeing the excavation.',
      action: 'Hold work where a critical item is not verified.',
      records: 'Field checklist, inspection record, action tracker.',
    ),
  ),
  ExcavationGoldSection(
    number: '38',
    title: 'Abu Dhabi Regulatory References',
    introduction: 'Official CoPs are the regulatory source; SafeNexus is a learning/field-reference layer and does not replace the official publication.',
    point: ExcavationGoldPoint(
      clause: 'Step 38',
      title: 'Abu Dhabi Regulatory References',
      meaning: 'Primary reference: ADOSH-SF CoP 29.0 Excavation Work, Version 4.1, February 2026. Related references include CoP 21.0 Permit to Work, CoP 22.0 Barricading, CoP 27.0 Confined Spaces, CoP 33.0 Work On or Adjacent to a Road, CoP 39.0 Overhead and Underground Services, CoP 53.0/53.1 construction OSH management, and CoP 54.0 Waste Management where applicable.',
      hazards: 'Using outdated versions or the wrong jurisdiction can lead to incorrect controls.',
      controls: 'Record source title, version, effective date and applicability for regulatory statements.',
      fieldCheck: 'Check the current official ADPHC publication when making a compliance decision.',
      commonMistake: 'Quoting a requirement without its source/version/context.',
      action: 'Escalate legal/regulatory uncertainty to the responsible competent authority/professional.',
      records: 'Official CoP links, version record, project legal register.',
    ),
  ),
];

// ===== SOURCE: abu_dhabi_scaffolding_gold.dart =====
class ScaffoldingGoldPoint {
  final String clause;
  final String title;
  final String meaning;
  final String hazards;
  final String controls;
  final String fieldCheck;
  final String commonMistake;
  final String action;
  final String records;

  const ScaffoldingGoldPoint({
    required this.clause,
    required this.title,
    required this.meaning,
    required this.hazards,
    required this.controls,
    required this.fieldCheck,
    required this.commonMistake,
    required this.action,
    required this.records,
  });
}

class ScaffoldingGoldSection {
  final String number;
  final String title;
  final String introduction;
  final ScaffoldingGoldPoint point;

  const ScaffoldingGoldSection({
    required this.number,
    required this.title,
    required this.introduction,
    required this.point,
  });
}

const List<ScaffoldingGoldSection> scaffoldingGoldStandardSections = [
  ScaffoldingGoldSection(
    number: '01',
    title: 'Definition & Purpose',
    introduction: 'Define scaffolding as a temporary access/working system and control it from design through dismantling.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 01',
      title: 'Definition & Purpose',
      meaning: 'Define scaffolding as a temporary access/working system and control it from design through dismantling.',
      hazards: 'Scaffold collapse, falls, falling objects, overloading and unsafe access can cause serious injury.',
      controls: 'Use competent design/planning, suitable components, competent erection, inspection, supervision and controlled alteration/dismantling.',
      fieldCheck: 'Confirm scaffold type, purpose, location, height and intended users before erection.',
      commonMistake: 'Treating a scaffold as ordinary site access without design or inspection.',
      action: 'Stop use until the scaffold is correctly assessed and controlled.',
      records: 'Design/plan, RAMS, inspection records, training records.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '02',
    title: 'Scope & Applications',
    introduction: 'Apply the controls to fixed, mobile, tower, suspended and special scaffold arrangements within the applicable scope.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 02',
      title: 'Scope & Applications',
      meaning: 'Apply the controls to fixed, mobile, tower, suspended and special scaffold arrangements within the applicable scope.',
      hazards: 'Different scaffold systems have different stability, loading, access and rescue hazards.',
      controls: 'Identify the system and all applicable Abu Dhabi requirements before work.',
      fieldCheck: 'Check the actual scaffold against the approved system and intended application.',
      commonMistake: 'Mixing components or using a system outside its intended configuration.',
      action: 'Quarantine non-compliant arrangements and obtain competent review.',
      records: 'Scaffold plan, manufacturer information, approval/design records.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '03',
    title: 'Types of Scaffolding',
    introduction: 'Select the scaffold type according to task, height, loading, access and site constraints.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 03',
      title: 'Types of Scaffolding',
      meaning: 'Select the scaffold type according to task, height, loading, access and site constraints.',
      hazards: 'Incorrect type can create instability, excessive loading or unsafe access.',
      controls: 'Assess fixed/tube-and-coupler, modular, mobile/tower, suspended and special arrangements as applicable.',
      fieldCheck: 'Verify the installed configuration matches the planned type.',
      commonMistake: 'Using a mobile tower where a fixed scaffold or engineered solution is required.',
      action: 'Stop and select an appropriate system.',
      records: 'Design/drawing, RAMS, equipment records.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '04',
    title: 'Components / Parts',
    introduction: 'Understand standards, ledgers, transoms, base plates, sole boards, braces, ties, couplers, platforms and edge protection.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 04',
      title: 'Components / Parts',
      meaning: 'Understand standards, ledgers, transoms, base plates, sole boards, braces, ties, couplers, platforms and edge protection.',
      hazards: 'Missing, incompatible or damaged components can weaken the structure.',
      controls: 'Use compatible approved components and install them according to design/manufacturer requirements.',
      fieldCheck: 'Visually trace critical load paths and connections during inspection.',
      commonMistake: 'Substituting components without approval.',
      action: 'Remove defective or incompatible components from service.',
      records: 'Component inspection and manufacturer records.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '05',
    title: 'Planning & Design',
    introduction: 'Plan foundation, geometry, ties, loading, access, environmental loads and interfaces before erection.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 05',
      title: 'Planning & Design',
      meaning: 'Plan foundation, geometry, ties, loading, access, environmental loads and interfaces before erection.',
      hazards: 'Unplanned loading, wind, sheeting, cantilevers and unusual configurations can affect stability.',
      controls: 'Use competent engineering/design where required and account for actual site conditions.',
      fieldCheck: 'Compare erection to current approved drawing.',
      commonMistake: 'Building from memory or an old drawing.',
      action: 'Stop erection and obtain the correct design information.',
      records: 'Approved drawing, calculations where required, RAMS.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '06',
    title: 'Site Assessment',
    introduction: 'Assess ground, overhead services, adjacent structures, traffic, public areas, weather and nearby work.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 06',
      title: 'Site Assessment',
      meaning: 'Assess ground, overhead services, adjacent structures, traffic, public areas, weather and nearby work.',
      hazards: 'Soft ground, excavation edges, traffic and services can compromise scaffold stability or expose workers.',
      controls: 'Provide suitable foundation, exclusion zones, service controls and interface arrangements.',
      fieldCheck: 'Inspect the full scaffold footprint and surroundings.',
      commonMistake: 'Erecting directly beside an excavation without assessing edge stability.',
      action: 'Reposition or engineer the arrangement before erection.',
      records: 'Site survey, permits/NOCs, risk assessment.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '07',
    title: 'Foundation / Sole Boards',
    introduction: 'Provide a stable foundation capable of supporting the scaffold and imposed loads.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 07',
      title: 'Foundation / Sole Boards',
      meaning: 'Provide a stable foundation capable of supporting the scaffold and imposed loads.',
      hazards: 'Settlement or uneven bearing can cause leaning, movement or collapse.',
      controls: 'Use suitable sole boards/base arrangements and comply with the applicable CoP/design.',
      fieldCheck: 'Check bearing surface, sole boards, base plates and level.',
      commonMistake: 'Placing standards on loose fill, debris or unsupported covers.',
      action: 'Stop erection until a suitable foundation is provided.',
      records: 'Foundation inspection, scaffold checklist.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '08',
    title: 'Erection Sequence',
    introduction: 'Erect progressively with stability maintained at every stage.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 08',
      title: 'Erection Sequence',
      meaning: 'Erect progressively with stability maintained at every stage.',
      hazards: 'Partially erected scaffolds can be unstable and create fall hazards.',
      controls: 'Follow the approved erection method, maintain bracing/ties progressively and establish an exclusion zone.',
      fieldCheck: 'Confirm every completed lift is stable before progressing.',
      commonMistake: 'Removing braces or ties temporarily without a controlled sequence.',
      action: 'Stop erection and restore the designed stability.',
      records: 'RAMS, erection checklist, competent-person records.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '09',
    title: 'Hazards — One by One',
    introduction: 'Treat collapse, falls, falling objects, overloading, electrical contact, weather and unsafe modification as separate hazards.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 09',
      title: 'Hazards — One by One',
      meaning: 'Treat collapse, falls, falling objects, overloading, electrical contact, weather and unsafe modification as separate hazards.',
      hazards: 'Multiple simultaneous failures can escalate a scaffold incident.',
      controls: 'Identify each hazard and assign a specific control rather than relying only on PPE.',
      fieldCheck: 'Ask: what can fail, who is exposed, and what prevents the failure?',
      commonMistake: 'Using one generic \'scaffold safe\' statement.',
      action: 'Record and control each significant hazard.',
      records: 'Risk assessment/JSA and inspection records.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '10',
    title: 'Hazard Identification',
    introduction: 'Identify defects, movement, missing components, inadequate ties, gaps, access issues and interface hazards.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 10',
      title: 'Hazard Identification',
      meaning: 'Identify defects, movement, missing components, inadequate ties, gaps, access issues and interface hazards.',
      hazards: 'Defects can be hidden until loading or weather occurs.',
      controls: 'Use systematic inspections from foundation to highest working level.',
      fieldCheck: 'Walk the complete scaffold and inspect critical connections.',
      commonMistake: 'Inspecting only the platform where workers stand.',
      action: 'Tag/isolated the scaffold when a critical defect is found.',
      records: 'Inspection checklist, photographs, defect log.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '11',
    title: 'Causes',
    introduction: 'Understand failures caused by poor design, poor erection, unauthorized alteration, overloading, weak ground and environmental effects.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 11',
      title: 'Causes',
      meaning: 'Understand failures caused by poor design, poor erection, unauthorized alteration, overloading, weak ground and environmental effects.',
      hazards: 'Failure to address root causes allows recurrence.',
      controls: 'Use competent planning, supervision, inspection and change control.',
      fieldCheck: 'Look for evidence of changes from the original configuration.',
      commonMistake: 'Blaming users without correcting system failures.',
      action: 'Correct the underlying cause and verify effectiveness.',
      records: 'Incident/observation investigation and corrective action.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '12',
    title: 'Risk & Consequences',
    introduction: 'Assess consequences for workers, public, property, plant and adjacent activities.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 12',
      title: 'Risk & Consequences',
      meaning: 'Assess consequences for workers, public, property, plant and adjacent activities.',
      hazards: 'Collapse can affect multiple levels and nearby work areas.',
      controls: 'Use risk assessment and critical-control verification for high-risk configurations.',
      fieldCheck: 'Check whether exclusion zones and emergency arrangements match the credible consequence.',
      commonMistake: 'Assessing only the person standing on the platform.',
      action: 'Expand the risk assessment to all exposed persons.',
      records: 'Risk assessment, emergency plan.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '13',
    title: 'Hierarchy of Controls',
    introduction: 'Control scaffold risks through design and engineering before relying on administrative controls or PPE.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 13',
      title: 'Hierarchy of Controls',
      meaning: 'Control scaffold risks through design and engineering before relying on administrative controls or PPE.',
      hazards: 'Administrative controls alone may not prevent collapse or falls.',
      controls: 'Eliminate unnecessary access; engineer stability and edge protection; use procedures, supervision and PPE as supporting controls.',
      fieldCheck: 'Verify engineering controls first during inspections.',
      commonMistake: 'Relying on helmets to compensate for missing guardrails.',
      action: 'Install/restore the physical control before work.',
      records: 'RAMS, design, inspection records.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '14',
    title: 'Scaffold Stability',
    introduction: 'Maintain the designed base, bracing, ties, standards, ledgers and structural configuration.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 14',
      title: 'Scaffold Stability',
      meaning: 'Maintain the designed base, bracing, ties, standards, ledgers and structural configuration.',
      hazards: 'Instability can result from missing ties, altered braces, settlement or excessive eccentric loading.',
      controls: 'Follow approved design/manufacturer requirements and protect critical structural members from unauthorized changes.',
      fieldCheck: 'Check plumb/level, bracing, ties and signs of movement.',
      commonMistake: 'Removing a tie to allow another trade to pass.',
      action: 'Stop use and restore the stability system.',
      records: 'Design, inspection, alteration records.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '15',
    title: 'Bracing / Ties / Anchoring',
    introduction: 'Use bracing and ties required by the design/system and maintain them throughout use.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 15',
      title: 'Bracing / Ties / Anchoring',
      meaning: 'Use bracing and ties required by the design/system and maintain them throughout use.',
      hazards: 'Insufficient or removed ties/bracing can cause progressive instability.',
      controls: 'Install, inspect and protect ties/bracing; engineered alternatives require competent approval.',
      fieldCheck: 'Check tie pattern, condition and connections against the drawing.',
      commonMistake: 'Assuming one tie is enough for every configuration.',
      action: 'Isolate and obtain competent assessment.',
      records: 'Scaffold drawing, tie/bracing inspection.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '16',
    title: 'Platforms / Working Levels',
    introduction: 'Provide complete, suitable working platforms for the intended task and loading.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 16',
      title: 'Platforms / Working Levels',
      meaning: 'Provide complete, suitable working platforms for the intended task and loading.',
      hazards: 'Trips, falls through gaps and platform failure can occur.',
      controls: 'Use suitable boards/components, secure them, control gaps and maintain a clear work surface.',
      fieldCheck: 'Inspect boards, gaps, support and cleanliness.',
      commonMistake: 'Using damaged boards or leaving uncontrolled gaps.',
      action: 'Remove defective boards and correct the platform.',
      records: 'Platform inspection, component records.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '17',
    title: 'Guardrails / Toe Boards',
    introduction: 'Provide effective edge protection and falling-object controls at exposed working levels.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 17',
      title: 'Guardrails / Toe Boards',
      meaning: 'Provide effective edge protection and falling-object controls at exposed working levels.',
      hazards: 'Workers can fall and tools/materials can strike people below.',
      controls: 'Maintain guardrails, intermediate protection where required, toe boards and exclusion zones.',
      fieldCheck: 'Check every exposed edge, end and access opening.',
      commonMistake: 'Removing a guardrail temporarily and not restoring it.',
      action: 'Stop work at the exposed edge and reinstate protection.',
      records: 'Inspection/tagging records.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '18',
    title: 'Access & Egress',
    introduction: 'Provide safe access designed for the scaffold configuration.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 18',
      title: 'Access & Egress',
      meaning: 'Provide safe access designed for the scaffold configuration.',
      hazards: 'Climbing standards, ledgers or braces can cause falls.',
      controls: 'Use approved ladders, stair towers or designed access; keep routes clear.',
      fieldCheck: 'Verify access from ground to each required working level.',
      commonMistake: 'Workers climbing outside the scaffold.',
      action: 'Block unsafe access and provide compliant access.',
      records: 'Access inspection, RAMS.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '19',
    title: 'Ladders / Stair Towers',
    introduction: 'Control ladder angle, securing, landing arrangements and stair-tower integrity according to the applicable system requirements.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 19',
      title: 'Ladders / Stair Towers',
      meaning: 'Control ladder angle, securing, landing arrangements and stair-tower integrity according to the applicable system requirements.',
      hazards: 'Unsecured or poorly positioned ladders can cause slips and falls.',
      controls: 'Use suitable access equipment, secure it and maintain safe landings and handholds.',
      fieldCheck: 'Inspect ladder/stair condition and connection at each access route.',
      commonMistake: 'Using scaffold braces as ladders.',
      action: 'Remove unsafe access and provide the designed route.',
      records: 'Access inspection and training records.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '20',
    title: 'Loading / Load Limits',
    introduction: 'Ensure platform loading remains within the designed and identified capacity.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 20',
      title: 'Loading / Load Limits',
      meaning: 'Ensure platform loading remains within the designed and identified capacity.',
      hazards: 'Overloading can cause board failure, local instability or collapse.',
      controls: 'Display/communicate loading requirements and control materials, workers and equipment.',
      fieldCheck: 'Check stored materials and concentrated loads during inspection.',
      commonMistake: 'Stacking blocks/materials without checking design capacity.',
      action: 'Remove excess load under controlled conditions.',
      records: 'Design/load information, inspection record.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '21',
    title: 'Falling Objects',
    introduction: 'Prevent tools, materials and components from falling from scaffold levels.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 21',
      title: 'Falling Objects',
      meaning: 'Prevent tools, materials and components from falling from scaffold levels.',
      hazards: 'People below can suffer impact injuries.',
      controls: 'Use toe boards, containment, secured materials, exclusion zones and controlled lifting/handling.',
      fieldCheck: 'Check edges, openings and material storage.',
      commonMistake: 'Throwing materials between levels.',
      action: 'Stop unsafe handling and establish controlled movement.',
      records: 'Toolbox talk, inspection and lifting records.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '22',
    title: 'Weather / Wind / Heat',
    introduction: 'Assess wind, rain, heat and other environmental conditions affecting scaffold stability and worker safety.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 22',
      title: 'Weather / Wind / Heat',
      meaning: 'Assess wind, rain, heat and other environmental conditions affecting scaffold stability and worker safety.',
      hazards: 'Wind can increase structural loading; heat can impair workers and equipment.',
      controls: 'Follow design/manufacturer weather limits and site heat controls; reassess after adverse conditions.',
      fieldCheck: 'Check weather exposure, sheeting/netting and stability before use.',
      commonMistake: 'Adding sheeting without assessing wind loading.',
      action: 'Stop use and obtain competent assessment when conditions exceed controls.',
      records: 'Weather monitoring, inspection records.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '23',
    title: 'Electrical / Overhead Services',
    introduction: 'Control contact with overhead electrical lines and electrical hazards near scaffolding.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 23',
      title: 'Electrical / Overhead Services',
      meaning: 'Control contact with overhead electrical lines and electrical hazards near scaffolding.',
      hazards: 'Conductive scaffold can create fatal shock or arc-flash exposure.',
      controls: 'Identify services, maintain required clearances, isolate where possible and use authority controls/NOCs as applicable.',
      fieldCheck: 'Survey overhead services before erection and during changes.',
      commonMistake: 'Erecting scaffold without checking overhead lines.',
      action: 'Stop work and establish the required electrical/service controls.',
      records: 'Survey, NOC/permit, electrical risk assessment.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '24',
    title: 'Mobile / Tower / Special Scaffolds',
    introduction: 'Apply additional controls to mobile towers, suspended and special scaffold systems.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 24',
      title: 'Mobile / Tower / Special Scaffolds',
      meaning: 'Apply additional controls to mobile towers, suspended and special scaffold systems.',
      hazards: 'Movement, overturning, suspension failure or non-standard loads can cause falls/collapse.',
      controls: 'Use competent assembly, suitable foundations, wheel controls, design and manufacturer requirements.',
      fieldCheck: 'Check configuration, brakes/stabilisers, platform and intended use.',
      commonMistake: 'Moving a tower while people or unsecured materials remain on it.',
      action: 'Stop use and correct the configuration.',
      records: 'Manufacturer instructions, inspection, training.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '25',
    title: 'RAMS / JSA / Risk Assessment',
    introduction: 'Make the scaffold method specific to erection, use, alteration and dismantling.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 25',
      title: 'RAMS / JSA / Risk Assessment',
      meaning: 'Make the scaffold method specific to erection, use, alteration and dismantling.',
      hazards: 'Generic RAMS can omit site-specific stability and interface risks.',
      controls: 'Include sequence, competent roles, exclusion zones, design, loading, access, rescue and change control.',
      fieldCheck: 'Compare field work with the approved RAMS.',
      commonMistake: 'Using a generic RAMS for a non-standard scaffold.',
      action: 'Revise and reapprove before continuing.',
      records: 'RAMS/JSA, approval records.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '26',
    title: 'PTW / Authorization',
    introduction: 'Use permits and authorisations where required by the site or interfacing activity.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 26',
      title: 'PTW / Authorization',
      meaning: 'Use permits and authorisations where required by the site or interfacing activity.',
      hazards: 'Scaffold work may interface with roads, electrical services, hot work or other controlled activities.',
      controls: 'Confirm required permits/NOCs and coordination before work.',
      fieldCheck: 'Check permit status and boundaries at pre-start.',
      commonMistake: 'Assuming scaffold erection never requires a permit.',
      action: 'Stop until required authorization is in place.',
      records: 'Permit/NOC and coordination records.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '27',
    title: 'Safe Work Procedure',
    introduction: 'Control erection, use, alteration and dismantling as separate stages.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 27',
      title: 'Safe Work Procedure',
      meaning: 'Control erection, use, alteration and dismantling as separate stages.',
      hazards: 'Uncontrolled sequence changes can remove critical stability or fall protection.',
      controls: 'Use competent workers, progressive stability, exclusion zones and controlled handover.',
      fieldCheck: 'Observe the actual sequence, not just the paperwork.',
      commonMistake: 'Allowing trades to modify the scaffold themselves.',
      action: 'Stop and restore the approved configuration.',
      records: 'RAMS, handover and inspection records.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '28',
    title: 'Inspection & Tagging',
    introduction: 'Inspect before use and at the intervals/events required by the applicable CoP/site system, with clear status identification.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 28',
      title: 'Inspection & Tagging',
      meaning: 'Inspect before use and at the intervals/events required by the applicable CoP/site system, with clear status identification.',
      hazards: 'Workers may enter an unsafe or incomplete scaffold if status is unclear.',
      controls: 'Use competent inspection, defect control and a visible status/tagging system.',
      fieldCheck: 'Check inspection date, status, defects and whether alterations occurred.',
      commonMistake: 'Leaving an old green tag after a major alteration or adverse event.',
      action: 'Remove/replace status and isolate until re-inspected.',
      records: 'Inspection register, tag record, defect closure.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '29',
    title: 'Competency & Responsibilities',
    introduction: 'Define responsibilities for designer, scaffolder, inspector, supervisor, HSE and users.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 29',
      title: 'Competency & Responsibilities',
      meaning: 'Define responsibilities for designer, scaffolder, inspector, supervisor, HSE and users.',
      hazards: 'Unclear responsibility leads to unauthorized changes and missed defects.',
      controls: 'Use trained/competent persons and clear authorization boundaries.',
      fieldCheck: 'Verify competency before assigning erection, inspection or alteration duties.',
      commonMistake: 'Allowing untrained workers to erect or modify scaffolds.',
      action: 'Remove from the task and assign competent personnel.',
      records: 'Training/certification and authorization records.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '30',
    title: 'PPE',
    introduction: 'Use PPE as the final layer after engineered controls are established.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 30',
      title: 'PPE',
      meaning: 'Use PPE as the final layer after engineered controls are established.',
      hazards: 'Improper PPE can leave workers exposed to falls, impact, dust or other task hazards.',
      controls: 'Use task-appropriate helmet, footwear, gloves, eye protection, high visibility and fall protection where required by the risk assessment/system.',
      fieldCheck: 'Check PPE condition and correct use.',
      commonMistake: 'Using fall-arrest equipment without a suitable rescue plan.',
      action: 'Correct the PPE and rescue arrangement before work.',
      records: 'PPE inspection, training records.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '31',
    title: 'Emergency / Rescue',
    introduction: 'Plan for falls, collapse, suspended-worker incidents, falling objects, electrical contact and medical emergencies.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 31',
      title: 'Emergency / Rescue',
      meaning: 'Plan for falls, collapse, suspended-worker incidents, falling objects, electrical contact and medical emergencies.',
      hazards: 'Improvised rescue can expose rescuers to the same hazard.',
      controls: 'Provide communication, rescue equipment, competent responders and exclusion controls appropriate to the scaffold.',
      fieldCheck: 'Confirm rescue route and emergency access remain usable.',
      commonMistake: 'Starting high-level work without a rescue plan.',
      action: 'Stop work until emergency arrangements are credible and communicated.',
      records: 'Emergency plan, drill/toolbox records.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '32',
    title: 'Stop-Work Conditions',
    introduction: 'Define critical failures that require immediate isolation or reassessment.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 32',
      title: 'Stop-Work Conditions',
      meaning: 'Define critical failures that require immediate isolation or reassessment.',
      hazards: 'Continued use after a critical defect can turn a correctable defect into a major incident.',
      controls: 'Stop for instability, damaged/missing critical components, failed edge protection, unsafe access, uncontrolled alteration, overload, unsafe weather or electrical exposure.',
      fieldCheck: 'Check whether any critical control has failed.',
      commonMistake: 'Continuing because workers have already started.',
      action: 'Isolate, tag, rectify and re-inspect.',
      records: 'Stop-work/defect record.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '33',
    title: 'Unsafe Practices → Corrective Actions',
    introduction: 'Convert unsafe observations into specific, verified corrective actions.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 33',
      title: 'Unsafe Practices → Corrective Actions',
      meaning: 'Convert unsafe observations into specific, verified corrective actions.',
      hazards: 'Repeated unsafe practices indicate weak supervision or system control.',
      controls: 'Record condition, risk, immediate action, root cause, owner and verification.',
      fieldCheck: 'Photograph/describe the actual defect where appropriate.',
      commonMistake: 'Closing an observation with \'worker instructed\' only.',
      action: 'Address the physical/system cause and verify closure.',
      records: 'Observation, corrective-action and close-out records.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '34',
    title: 'Toolbox Talk',
    introduction: 'Use toolbox talks to communicate scaffold-specific critical controls before work.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 34',
      title: 'Toolbox Talk',
      meaning: 'Use toolbox talks to communicate scaffold-specific critical controls before work.',
      hazards: 'Workers may not understand loading, access, tagging or modification restrictions.',
      controls: 'Cover scaffold status, access, load limits, prohibited alterations, falling-object controls, weather and stop-work triggers.',
      fieldCheck: 'Ask workers to explain the critical controls back.',
      commonMistake: 'Signing attendance without checking understanding.',
      action: 'Repeat briefing and correct knowledge gaps.',
      records: 'Toolbox attendance and briefing content.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '35',
    title: 'Field Checklist',
    introduction: 'Use a top-to-bottom inspection route from foundation to highest working level.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 35',
      title: 'Field Checklist',
      meaning: 'Use a top-to-bottom inspection route from foundation to highest working level.',
      hazards: 'Skipping areas can leave critical defects undetected.',
      controls: 'Check foundation, standards, ledgers, braces, ties, platforms, guardrails, toe boards, access, loading, tags and surrounding interfaces.',
      fieldCheck: 'Perform a complete physical walk-through.',
      commonMistake: 'Checking only the green tag.',
      action: 'Isolate and record any critical defect.',
      records: 'Inspection checklist and defect log.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '36',
    title: 'Quick Reference',
    introduction: 'Provide a compact field sequence for supervisors and HSE officers.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 36',
      title: 'Quick Reference',
      meaning: 'Provide a compact field sequence for supervisors and HSE officers.',
      hazards: 'Important controls can be missed under time pressure.',
      controls: 'Use: DESIGN → FOUNDATION → STRUCTURE → TIES/BRACING → PLATFORM → EDGE PROTECTION → ACCESS → LOAD → INTERFACES → INSPECTION → TAG → USE.',
      fieldCheck: 'Use the sequence during every field verification.',
      commonMistake: 'Treating the tag as a substitute for visual inspection.',
      action: 'Follow the sequence and escalate discrepancies.',
      records: 'Quick-reference checklist.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '37',
    title: 'UAE / Abu Dhabi / Dubai Applicability',
    introduction: 'Keep Abu Dhabi requirements separate from Dubai and other jurisdictional requirements.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 37',
      title: 'UAE / Abu Dhabi / Dubai Applicability',
      meaning: 'Keep Abu Dhabi requirements separate from Dubai and other jurisdictional requirements.',
      hazards: 'Transferring a Dubai rule into Abu Dhabi without verification can create incorrect compliance advice.',
      controls: 'Use Abu Dhabi ADOSH-SF/ADPHC sources for Abu Dhabi; cross-reference other jurisdictions separately.',
      fieldCheck: 'Check jurisdiction and current document version before quoting a requirement.',
      commonMistake: 'Copying Dubai scaffolding content into Abu Dhabi unchanged.',
      action: 'Verify against the applicable authority.',
      records: 'Legal register, source/version record.',
    ),
  ),
  ScaffoldingGoldSection(
    number: '38',
    title: 'Official Regulatory References',
    introduction: 'Use the current official Abu Dhabi publication as the controlling regulatory source.',
    point: ScaffoldingGoldPoint(
      clause: 'Step 38',
      title: 'Official Regulatory References',
      meaning: 'Use the current official Abu Dhabi publication as the controlling regulatory source.',
      hazards: 'Outdated or secondary material can contain superseded requirements.',
      controls: 'Primary baseline: ADOSH-SF CoP 26.0 — Scaffolding, Version 4.1. Cross-reference other applicable CoPs and authority requirements where relevant.',
      fieldCheck: 'Record source title, version, effective date and applicability.',
      commonMistake: 'Using an old uncontrolled PDF as the legal basis.',
      action: 'Update the legal/reference register and reverify critical numeric requirements.',
      records: 'Official CoP, legal register, revision record.',
    ),
  ),
];

// ===== SOURCE: abu_dhabi_working_at_height_gold.dart =====
/// SafeNexus HSE — Abu Dhabi Working at Height Gold Standard.
/// Primary regulatory baseline: ADOSH-SF CoP 23.0 — Working at Heights.
/// This is a structured field-reference layer. The current official ADPHC
/// publication remains the controlling source for regulatory decisions.
///
/// 38-section Gold Standard content model.

class WorkingAtHeightGoldPoint {
  final String clause;
  final String title;
  final String meaning;
  final String hazards;
  final String controls;
  final String fieldCheck;
  final String commonMistake;
  final String action;
  final String records;

  const WorkingAtHeightGoldPoint({
    required this.clause,
    required this.title,
    required this.meaning,
    required this.hazards,
    required this.controls,
    required this.fieldCheck,
    required this.commonMistake,
    required this.action,
    required this.records,
  });
}

class WorkingAtHeightGoldSection {
  final String number;
  final String title;
  final String introduction;
  final WorkingAtHeightGoldPoint point;

  const WorkingAtHeightGoldSection({
    required this.number,
    required this.title,
    required this.introduction,
    required this.point,
  });
}

const List<WorkingAtHeightGoldSection> workingAtHeightGoldStandardSections = [
  WorkingAtHeightGoldSection(
    number: '01',
    title: 'Definition & Purpose',
    introduction: 'Working at height means work where a person could fall from one level to another and requires planned fall prevention and protection.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 01',
      title: 'Definition & Purpose',
      meaning: 'Working at height means work where a person could fall from one level to another and requires planned fall prevention and protection.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '02',
    title: 'Scope & Applications',
    introduction: 'Cover construction, maintenance, inspection, access, roof work, platforms, scaffolds, ladders, MEWPs and other applicable elevated work.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 02',
      title: 'Scope & Applications',
      meaning: 'Cover construction, maintenance, inspection, access, roof work, platforms, scaffolds, ladders, MEWPs and other applicable elevated work.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '03',
    title: 'Types of Work at Height',
    introduction: 'Include roofs, edges, openings, scaffolds, ladders, MEWPs, temporary platforms, formwork and other elevated work situations.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 03',
      title: 'Types of Work at Height',
      meaning: 'Include roofs, edges, openings, scaffolds, ladders, MEWPs, temporary platforms, formwork and other elevated work situations.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '04',
    title: 'Components / Equipment',
    introduction: 'Cover platforms, guardrails, toe boards, covers, harnesses, lanyards, lifelines, connectors and approved anchor systems.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 04',
      title: 'Components / Equipment',
      meaning: 'Cover platforms, guardrails, toe boards, covers, harnesses, lanyards, lifelines, connectors and approved anchor systems.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '05',
    title: 'Planning & Design',
    introduction: 'Plan the work before starting; select the safest access method and account for rescue, dropped objects, environment and interfaces.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 05',
      title: 'Planning & Design',
      meaning: 'Plan the work before starting; select the safest access method and account for rescue, dropped objects, environment and interfaces.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '06',
    title: 'Site Assessment',
    introduction: 'Assess edges, openings, fragile surfaces, access, ground conditions, electrical services, traffic, weather and people below.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 06',
      title: 'Site Assessment',
      meaning: 'Assess edges, openings, fragile surfaces, access, ground conditions, electrical services, traffic, weather and people below.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '07',
    title: 'Hierarchy of Controls',
    introduction: 'Prefer elimination and avoidance, then collective fall prevention, then engineered fall arrest and finally administrative controls/PPE.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 07',
      title: 'Hierarchy of Controls',
      meaning: 'Prefer elimination and avoidance, then collective fall prevention, then engineered fall arrest and finally administrative controls/PPE.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '08',
    title: 'Fall Prevention',
    introduction: 'Prevent the fall with safe platforms, guardrails, edge protection, covers and suitable access rather than relying first on fall arrest.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 08',
      title: 'Fall Prevention',
      meaning: 'Prevent the fall with safe platforms, guardrails, edge protection, covers and suitable access rather than relying first on fall arrest.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '09',
    title: 'Fall Arrest',
    introduction: 'Where prevention cannot fully control the risk, use a compatible personal fall-arrest system with suitable anchor, clearance and rescue arrangements.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 09',
      title: 'Fall Arrest',
      meaning: 'Where prevention cannot fully control the risk, use a compatible personal fall-arrest system with suitable anchor, clearance and rescue arrangements.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '10',
    title: 'Guardrails & Edge Protection',
    introduction: 'Protect exposed edges and access openings with suitable collective protection; do not remove protection without a controlled alternative.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 10',
      title: 'Guardrails & Edge Protection',
      meaning: 'Protect exposed edges and access openings with suitable collective protection; do not remove protection without a controlled alternative.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '11',
    title: 'Floor / Shaft / Opening Protection',
    introduction: 'Securely cover or guard floor openings, shafts and other voids; identify and protect temporary openings.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 11',
      title: 'Floor / Shaft / Opening Protection',
      meaning: 'Securely cover or guard floor openings, shafts and other voids; identify and protect temporary openings.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '12',
    title: 'Roof Work',
    introduction: 'Assess roof condition, access, edges, fragile areas, skylights, weather and rescue before roof work.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 12',
      title: 'Roof Work',
      meaning: 'Assess roof condition, access, edges, fragile areas, skylights, weather and rescue before roof work.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '13',
    title: 'Fragile Surfaces',
    introduction: 'Treat fragile roofs, sheets, skylights and weak surfaces as fall hazards until their strength is verified and suitable controls are installed.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 13',
      title: 'Fragile Surfaces',
      meaning: 'Treat fragile roofs, sheets, skylights and weak surfaces as fall hazards until their strength is verified and suitable controls are installed.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '14',
    title: 'Ladders',
    introduction: 'Use ladders only for appropriate tasks and durations; select, inspect, secure and position them according to the applicable requirements.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 14',
      title: 'Ladders',
      meaning: 'Use ladders only for appropriate tasks and durations; select, inspect, secure and position them according to the applicable requirements.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '15',
    title: 'Scaffolds',
    introduction: 'Use inspected and correctly configured scaffolds with complete platforms, edge protection, safe access and controlled loading.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 15',
      title: 'Scaffolds',
      meaning: 'Use inspected and correctly configured scaffolds with complete platforms, edge protection, safe access and controlled loading.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '16',
    title: 'MEWP / Aerial Platforms',
    introduction: 'Use the correct MEWP, trained operator, pre-use inspection, ground assessment, exclusion zone and manufacturer requirements.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 16',
      title: 'MEWP / Aerial Platforms',
      meaning: 'Use the correct MEWP, trained operator, pre-use inspection, ground assessment, exclusion zone and manufacturer requirements.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '17',
    title: 'Temporary Platforms',
    introduction: 'Ensure temporary working platforms are designed, stable, complete and suitable for the intended load and task.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 17',
      title: 'Temporary Platforms',
      meaning: 'Ensure temporary working platforms are designed, stable, complete and suitable for the intended load and task.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '18',
    title: 'Harnesses & Lanyards',
    introduction: 'Select compatible equipment, inspect before use, connect correctly and ensure the system is suitable for the planned task.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 18',
      title: 'Harnesses & Lanyards',
      meaning: 'Select compatible equipment, inspect before use, connect correctly and ensure the system is suitable for the planned task.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '19',
    title: 'Anchor Points & Lifelines',
    introduction: 'Use approved anchors/lifelines suitable for the system; never connect to an unverified point.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 19',
      title: 'Anchor Points & Lifelines',
      meaning: 'Use approved anchors/lifelines suitable for the system; never connect to an unverified point.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '20',
    title: 'Fall Clearance & Swing Fall',
    introduction: 'Confirm sufficient clearance below the worker and control swing-fall hazards before using a fall-arrest system.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 20',
      title: 'Fall Clearance & Swing Fall',
      meaning: 'Confirm sufficient clearance below the worker and control swing-fall hazards before using a fall-arrest system.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '21',
    title: 'Dropped Objects',
    introduction: 'Control tools, materials and components at height using secure storage, tethering where appropriate, toe boards and exclusion zones.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 21',
      title: 'Dropped Objects',
      meaning: 'Control tools, materials and components at height using secure storage, tethering where appropriate, toe boards and exclusion zones.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '22',
    title: 'Weather / Wind / Heat',
    introduction: 'Reassess elevated work for wind, rain, heat, poor visibility, wet surfaces and other environmental conditions.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 22',
      title: 'Weather / Wind / Heat',
      meaning: 'Reassess elevated work for wind, rain, heat, poor visibility, wet surfaces and other environmental conditions.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '23',
    title: 'Electrical / Overhead Services',
    introduction: 'Identify overhead electrical and other services before access or equipment positioning and apply the required isolation, clearance and authority controls.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 23',
      title: 'Electrical / Overhead Services',
      meaning: 'Identify overhead electrical and other services before access or equipment positioning and apply the required isolation, clearance and authority controls.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '24',
    title: 'People / Traffic Interface',
    introduction: 'Protect people, vehicles and public areas below or adjacent to elevated work using barriers, exclusion zones and controlled access.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 24',
      title: 'People / Traffic Interface',
      meaning: 'Protect people, vehicles and public areas below or adjacent to elevated work using barriers, exclusion zones and controlled access.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '25',
    title: 'RAMS / JSA / Risk Assessment',
    introduction: 'Make the assessment task-specific and include access, fall controls, dropped objects, environment, equipment, interfaces and rescue.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 25',
      title: 'RAMS / JSA / Risk Assessment',
      meaning: 'Make the assessment task-specific and include access, fall controls, dropped objects, environment, equipment, interfaces and rescue.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '26',
    title: 'PTW / Authorization',
    introduction: 'Use required permits, authorisations and coordination controls for high-risk or interfacing activities.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 26',
      title: 'PTW / Authorization',
      meaning: 'Use required permits, authorisations and coordination controls for high-risk or interfacing activities.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '27',
    title: 'Safe Work Procedure',
    introduction: 'Sequence the work: plan → assess → establish protection → inspect equipment → brief workers → perform task → monitor → close safely.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 27',
      title: 'Safe Work Procedure',
      meaning: 'Sequence the work: plan → assess → establish protection → inspect equipment → brief workers → perform task → monitor → close safely.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '28',
    title: 'Inspection & Examination',
    introduction: 'Inspect work-at-height systems before use and at required intervals/events; remove defective equipment from service.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 28',
      title: 'Inspection & Examination',
      meaning: 'Inspect work-at-height systems before use and at required intervals/events; remove defective equipment from service.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '29',
    title: 'Competency & Responsibilities',
    introduction: 'Define competent workers, supervisors, HSE personnel, inspectors, operators and rescue roles; verify training and authorization.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 29',
      title: 'Competency & Responsibilities',
      meaning: 'Define competent workers, supervisors, HSE personnel, inspectors, operators and rescue roles; verify training and authorization.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '30',
    title: 'PPE',
    introduction: 'Use task-appropriate helmet, footwear, gloves, eye protection, high visibility and fall-protection equipment where required.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 30',
      title: 'PPE',
      meaning: 'Use task-appropriate helmet, footwear, gloves, eye protection, high visibility and fall-protection equipment where required.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '31',
    title: 'Emergency / Rescue',
    introduction: 'Plan rescue before work. Control the scene, communicate, recover a suspended worker safely, provide first aid and arrange medical evaluation.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 31',
      title: 'Emergency / Rescue',
      meaning: 'Plan rescue before work. Control the scene, communicate, recover a suspended worker safely, provide first aid and arrange medical evaluation.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '32',
    title: 'Stop-Work Conditions',
    introduction: 'Stop for missing edge protection, unsafe openings, defective fall equipment, unknown anchors, inadequate clearance, unsafe access, severe weather or absent rescue controls.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 32',
      title: 'Stop-Work Conditions',
      meaning: 'Stop for missing edge protection, unsafe openings, defective fall equipment, unknown anchors, inadequate clearance, unsafe access, severe weather or absent rescue controls.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '33',
    title: 'Unsafe Practices → Corrective Actions',
    introduction: 'Record the actual unsafe condition, immediate control, root cause, responsible person and verified close-out.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 33',
      title: 'Unsafe Practices → Corrective Actions',
      meaning: 'Record the actual unsafe condition, immediate control, root cause, responsible person and verified close-out.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '34',
    title: 'Toolbox Talk',
    introduction: 'Brief workers on task hazards, access, edge protection, fall-arrest limits, dropped objects, weather, electrical interfaces and rescue.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 34',
      title: 'Toolbox Talk',
      meaning: 'Brief workers on task hazards, access, edge protection, fall-arrest limits, dropped objects, weather, electrical interfaces and rescue.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '35',
    title: 'Field Checklist',
    introduction: 'Check planning, access, platform, edge protection, openings, equipment, anchors, clearance, dropped objects, weather, exclusion zones and rescue.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 35',
      title: 'Field Checklist',
      meaning: 'Check planning, access, platform, edge protection, openings, equipment, anchors, clearance, dropped objects, weather, exclusion zones and rescue.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '36',
    title: 'Quick Reference',
    introduction: 'Use: ELIMINATE → PREVENT → PROTECT → INSPECT → ACCESS → CONTROL OBJECTS → CHECK CLEARANCE → RESCUE READY.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 36',
      title: 'Quick Reference',
      meaning: 'Use: ELIMINATE → PREVENT → PROTECT → INSPECT → ACCESS → CONTROL OBJECTS → CHECK CLEARANCE → RESCUE READY.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '37',
    title: 'UAE / Abu Dhabi / Dubai Applicability',
    introduction: 'Keep Abu Dhabi requirements separate from Dubai and other jurisdictions; verify the applicable authority and current document version.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 37',
      title: 'UAE / Abu Dhabi / Dubai Applicability',
      meaning: 'Keep Abu Dhabi requirements separate from Dubai and other jurisdictions; verify the applicable authority and current document version.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '38',
    title: 'Official Regulatory References',
    introduction: 'Primary Abu Dhabi baseline: ADOSH-SF CoP 23.0 — Working at Heights. Cross-reference applicable scaffold, ladder, MEWP, electrical and other HSE requirements.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 38',
      title: 'Official Regulatory References',
      meaning: 'Primary Abu Dhabi baseline: ADOSH-SF CoP 23.0 — Working at Heights. Cross-reference applicable scaffold, ladder, MEWP, electrical and other HSE requirements.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
];

// ===== SOURCE: abu_dhabi_power_tools_gold.dart =====
/// SafeNexus HSE — Abu Dhabi HSE Gold Standard
/// Topic: Portable Power Tools
/// Regulatory basis: ADOSH-SF CoP 35.0, Version 4.1, effective 16 February 2026.
///
/// This is structured reference content. Project-specific RAMS, JSA,
/// manufacturer instructions, permits, competent-person requirements and
/// current official regulatory documents remain applicable.

class PowerToolsGoldPoint {
  final String title;
  final List<String> points;

  const PowerToolsGoldPoint({required this.title, required this.points});
}

class PowerToolsGoldSection {
  final String number;
  final String title;
  final List<PowerToolsGoldPoint> points;

  const PowerToolsGoldSection({
    required this.number,
    required this.title,
    required this.points,
  });
}

const List<PowerToolsGoldSection> portablePowerToolsGoldStandardSections = [
  PowerToolsGoldSection(
    number: '01',
    title: 'Definition & Purpose',
    points: [
      PowerToolsGoldPoint(
        title: 'Definition',
        points: [
          'Portable power tools are hand-held, portable or transportable tools powered by electricity, batteries, compressed air, hydraulic energy or another power source.',
          'The purpose of this topic is to control injury from electrical energy, mechanical movement, stored energy, flying particles, heat, noise, vibration, dust, sparks and loss of control.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Core principle',
        points: [
          'Select the safest suitable tool, use the correct accessory, isolate energy before intervention, inspect before use and operate within manufacturer limits.',
          'Apply the hierarchy of controls before relying on PPE.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '02',
    title: 'Scope & Applications',
    points: [
      PowerToolsGoldPoint(
        title: 'Typical applications',
        points: [
          'Construction, maintenance, fabrication, installation, shutdown, civil works and facility maintenance.',
          'Grinding, drilling, cutting, sanding, polishing, fastening, chipping, demolition and surface preparation.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Included tools',
        points: [
          'Electric, cordless or battery, pneumatic and hydraulic portable tools, including grinders, drills, saws, impact tools and portable cutting equipment.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '03',
    title: 'Types & Classification',
    points: [
      PowerToolsGoldPoint(
        title: 'Power source',
        points: [
          'Cordless or battery tools.',
          'Low-voltage or transformer-supplied electrical tools.',
          'Electrical tools supplied at higher voltage with suitable RCD protection where permitted by the applicable arrangement.',
          'Pneumatic and hydraulic tools.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Task classification',
        points: [
          'Rotating, cutting, abrasive, impact, drilling, fastening, chipping and surface-treatment tools require task-specific controls.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '04',
    title: 'Components & Safety Devices',
    points: [
      PowerToolsGoldPoint(
        title: 'Check components',
        points: [
          'Body or casing, switch, trigger, guard, spindle, chuck, blade or wheel, cable and plug, battery, hose, fittings and attachment points.',
          'Check manufacturer guards, handles, dead-man or constant-pressure controls and emergency-stop arrangements where provided.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Never bypass',
        points: [
          'Do not remove, defeat, lock open or bypass guards, RCDs, safety switches, interlocks or other protective devices.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '05',
    title: 'Tool Selection & Planning',
    points: [
      PowerToolsGoldPoint(
        title: 'Selection',
        points: [
          'Choose a tool designed for the material, task, environment and duty cycle.',
          'Use the correct rated accessory and ensure its maximum permitted speed or rating is compatible with the tool.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Planning questions',
        points: [
          'Identify the energy sources, ejected materials, rotating or cutting parts, dust, noise, vibration, heat, water, combustible materials and simultaneous operations.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '06',
    title: 'Hazard Identification',
    points: [
      PowerToolsGoldPoint(
        title: 'Identify before starting',
        points: [
          'Electrical shock, burns and electrocution.',
          'Entanglement, cuts, crushing, kickback and loss of control.',
          'Flying fragments, broken wheels, blades and workpiece ejection.',
          'Noise, hand-arm vibration, dust and fume exposure, sparks and fire.',
          'Hydraulic injection, hose failure and stored pneumatic energy.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Field indicators',
        points: [
          'Damaged casing, exposed conductors, missing guard, abnormal noise, overheating, excessive vibration, damaged accessory, leaking hose or defective trigger are stop-work indicators.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '07',
    title: 'Risk Assessment & Hierarchy of Controls',
    points: [
      PowerToolsGoldPoint(
        title: 'Control sequence',
        points: [
          'Eliminate the powered-tool task where practicable.',
          'Substitute with a safer process or lower-energy tool.',
          'Use engineering controls such as guards, extraction, isolation and RCD protection.',
          'Apply administrative controls, training, inspection, supervision and safe systems of work.',
          'Use PPE as the final layer, not as the only control.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '08',
    title: 'Electrical Portable Tools',
    points: [
      PowerToolsGoldPoint(
        title: 'Abu Dhabi requirements',
        points: [
          'CoP 35.0 identifies a planning hierarchy that includes battery or cordless low-voltage tools, 110 V tools supplied through a step-down transformer, or 240 V tools protected by a 30 mA RCD, as applicable to the work arrangement.',
          'Electrical portable tools must be maintained in good condition.',
          'Hand-held electrically operated portable tools should have a constant-pressure switch that requires continuous pressure to energize the tool.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Electrical checks',
        points: [
          'Inspect plug, cable, strain relief, casing, switch and protection before use.',
          'Keep connections protected from water, damage, traffic and unauthorized access.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '09',
    title: 'Battery & Cordless Tools',
    points: [
      PowerToolsGoldPoint(
        title: 'Battery safety',
        points: [
          'Use only approved batteries and chargers compatible with the tool.',
          'Inspect for swelling, cracking, leakage, overheating, damaged terminals or impact damage.',
          'Remove damaged batteries from service and follow the manufacturer quarantine and disposal procedure.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Charging',
        points: [
          'Charge in a designated suitable location with adequate ventilation and fire precautions.',
          'Do not modify battery packs or use damaged chargers.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '10',
    title: 'Grinders & Abrasive Wheels',
    points: [
      PowerToolsGoldPoint(
        title: 'Critical controls',
        points: [
          'Use the correct wheel or disc for the material and tool.',
          'Confirm wheel condition, rating and compatibility before mounting.',
          'Keep the manufacturer guard correctly fitted and positioned.',
          'Use the auxiliary handle where provided and maintain a stable stance.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Grinding hazards',
        points: [
          'Wheel burst, kickback, flying fragments, sparks, burns, dust and noise.',
          'Do not use a cutting disc for side grinding unless it is specifically designed for that purpose.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '11',
    title: 'Drilling & Impact Tools',
    points: [
      PowerToolsGoldPoint(
        title: 'Controls',
        points: [
          'Secure the workpiece where practicable and select the correct bit or accessory.',
          'Keep hands away from the rotating point and use the correct auxiliary handle for high-torque tools.',
          'Check for hidden electrical, gas, water or communication services before drilling.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Hazards',
        points: [
          'Bit breakage, kickback, entanglement, dust, noise, vibration and contact with concealed services.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '12',
    title: 'Cutting Tools & Saws',
    points: [
      PowerToolsGoldPoint(
        title: 'Controls',
        points: [
          'Use the correct blade or disc, guard and cutting method.',
          'Support material to prevent binding or unexpected movement.',
          'Keep the line of cut clear of people and protect against flying fragments.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Stop conditions',
        points: [
          'Stop for binding, damaged blade, abnormal vibration, loss of guard, overheating or uncontrolled kickback.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '13',
    title: 'Pneumatic Tools',
    points: [
      PowerToolsGoldPoint(
        title: 'Controls',
        points: [
          'Inspect hoses, couplings, whip checks or restraints where required, and tool connections.',
          'Isolate and depressurize the supply before disconnecting, changing accessories or servicing.',
          'Prevent hoses from creating trip hazards or being damaged by vehicles and sharp edges.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Hazards',
        points: [
          'Stored pressure, hose whip, flying particles, noise, vibration and accidental actuation.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '14',
    title: 'Hydraulic Tools',
    points: [
      PowerToolsGoldPoint(
        title: 'Controls',
        points: [
          'Inspect hoses, fittings, couplings and tool body before use.',
          'Isolate and release hydraulic pressure before maintenance or disconnection.',
          'Never use hands to locate a suspected hydraulic leak.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Injection hazard',
        points: [
          'High-pressure fluid can penetrate skin and cause a medical emergency even when the external wound is small. Treat suspected injection injury as urgent.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '15',
    title: 'Guards, Handles & Safety Devices',
    points: [
      PowerToolsGoldPoint(
        title: 'Requirements',
        points: [
          'Guards must be present, correctly fitted and suitable for the tool and accessory.',
          'Handles and auxiliary grips must be secure and used where required for control.',
          'Safety devices must function as designed and must not be bypassed.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '16',
    title: 'Accessories, Discs, Blades & Bits',
    points: [
      PowerToolsGoldPoint(
        title: 'Compatibility',
        points: [
          'Match accessory type, size, mounting system, material suitability and maximum speed or rating to the tool.',
          'Inspect accessories for cracks, chips, distortion, excessive wear, damaged teeth or other defects.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Storage',
        points: [
          'Store accessories dry, protected and in accordance with manufacturer requirements. Do not use unknown or damaged accessories.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '17',
    title: 'Inspection Before Use',
    points: [
      PowerToolsGoldPoint(
        title: 'Pre-use inspection',
        points: [
          'Check identification, casing, guard, switch or trigger, cable or plug, battery, accessory, handle, fittings and general condition.',
          'Function-test the tool safely before beginning the task where appropriate.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Defect action',
        points: [
          'Stop, isolate, label or remove defective equipment from service and report it. Do not return it to use until authorized repair and inspection are completed.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '18',
    title: 'Maintenance & Isolation',
    points: [
      PowerToolsGoldPoint(
        title: 'Safe maintenance',
        points: [
          'Disconnect electrical supply, remove the battery or isolate pneumatic or hydraulic energy before servicing.',
          'Control stored energy and prevent accidental re-energization.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'LOTO interface',
        points: [
          'Where formal isolation is required, apply the site lockout or tagout and isolation procedure and the applicable ADOSH requirements.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '19',
    title: 'Dust, Fumes & Local Exhaust',
    points: [
      PowerToolsGoldPoint(
        title: 'Exposure control',
        points: [
          'Identify dust and fume hazards generated by cutting, grinding, drilling or surface preparation.',
          'Prefer wet methods, local extraction or other engineering controls where suitable.',
          'Select respiratory protection from the task-specific assessment when engineering controls do not adequately control exposure.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '20',
    title: 'Noise & Vibration',
    points: [
      PowerToolsGoldPoint(
        title: 'Noise',
        points: [
          'Assess noisy tasks and implement engineering and administrative controls. Provide hearing protection where required by the assessment and applicable requirements.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Vibration',
        points: [
          'Select lower-vibration tools where practicable, maintain equipment and manage exposure time. Consider occupational health controls for significant hand-arm vibration exposure.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '21',
    title: 'Fire, Sparks & Hot Work Interface',
    points: [
      PowerToolsGoldPoint(
        title: 'Controls',
        points: [
          'Identify combustible materials, gases, vapors and dust before generating sparks or heat.',
          'Use suitable screens, housekeeping and fire precautions.',
          'Where the activity meets the site definition of hot work, comply with the applicable hot-work permit and controls.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '22',
    title: 'Work Area & Housekeeping',
    points: [
      PowerToolsGoldPoint(
        title: 'Work area',
        points: [
          'Provide adequate lighting, stable footing, access and workspace.',
          'Route cables and hoses to prevent trips, crushing, sharp-edge damage and contact with moving equipment.',
          'Keep bystanders outside the hazard zone.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '23',
    title: 'Electrical & Environmental Conditions',
    points: [
      PowerToolsGoldPoint(
        title: 'Wet conditions',
        points: [
          'Assess water, conductive surfaces and weather before using electrical tools. Use equipment and protection suitable for the environment.',
          'Do not use damaged electrical equipment in wet conditions.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Overhead or underground services',
        points: [
          'Confirm service information before drilling, cutting or breaking into structures or ground. Apply the relevant permit, detection and isolation controls.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '24',
    title: 'People, Traffic & Dropped-Object Interface',
    points: [
      PowerToolsGoldPoint(
        title: 'Exclusion zones',
        points: [
          'Establish a suitable exclusion zone where fragments, sparks, noise or falling objects can affect others.',
          'Coordinate tool work with lifting, vehicle movement, simultaneous operations and pedestrian routes.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '25',
    title: 'RAMS / JSA / Risk Assessment',
    points: [
      PowerToolsGoldPoint(
        title: 'Minimum assessment content',
        points: [
          'Task, tool, material, energy sources, hazards, affected persons, controls, PPE, competency, inspection, emergency arrangements and environmental conditions.',
          'Review the assessment when the tool, material, location, process or conditions change.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '26',
    title: 'PTW / Authorization',
    points: [
      PowerToolsGoldPoint(
        title: 'Permit interface',
        points: [
          'Use the site PTW system where the task or location requires a permit, including applicable hot-work, electrical-isolation, confined-space or other permits.',
          'Permit requirements do not replace manufacturer instructions, RAMS or risk assessment.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '27',
    title: 'Safe Work Procedure',
    points: [
      PowerToolsGoldPoint(
        title: 'Before use',
        points: [
          'Review RAMS, confirm competent operator, inspect tool and accessory, establish exclusion zone and verify energy controls.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'During use',
        points: [
          'Maintain stable footing and two-handed control where required, keep guards in place, avoid distraction and stop if conditions become unsafe.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'After use',
        points: [
          'Switch off, isolate energy, wait for moving parts to stop, clean and store safely, and report defects.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '28',
    title: 'Inspection, Examination & Records',
    points: [
      PowerToolsGoldPoint(
        title: 'Records',
        points: [
          'Maintain the site\'s required inspection, maintenance, testing, defect, repair and training records.',
          'Inspection frequency must reflect manufacturer requirements, risk, site rules and applicable regulatory requirements.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Traceability',
        points: [
          'Where the site uses equipment registers or identification tags, ensure the tool can be linked to its inspection and maintenance status.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '29',
    title: 'Competency & Responsibilities',
    points: [
      PowerToolsGoldPoint(
        title: 'Operator',
        points: [
          'Use only tools for which trained or competent and follow manufacturer instructions, RAMS and site rules.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Supervisor',
        points: [
          'Confirm task controls, competent personnel, suitable equipment, inspection status and safe work conditions.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'HSE',
        points: [
          'Verify risk controls, inspections, training, field compliance and corrective actions, and intervene when unsafe conditions are observed.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '30',
    title: 'PPE',
    points: [
      PowerToolsGoldPoint(
        title: 'Task-based PPE',
        points: [
          'Safety helmet, eye and face protection, suitable gloves, safety footwear and hearing protection as required by the risk assessment.',
          'Use respiratory protection when required by the exposure assessment.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Important limitation',
        points: [
          'PPE does not make defective equipment safe and must not substitute for guarding, isolation, extraction or other higher-level controls.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '31',
    title: 'Emergency & Rescue',
    points: [
      PowerToolsGoldPoint(
        title: 'Immediate response',
        points: [
          'Stop the tool and isolate energy if safe to do so. Raise the alarm and obtain site emergency assistance.',
          'For electrical incidents, do not touch an injured person until the electrical source is safely isolated.',
          'For hydraulic injection injury, seek urgent medical treatment and provide information about the fluid involved.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '32',
    title: 'Stop-Work Conditions',
    points: [
      PowerToolsGoldPoint(
        title: 'Stop immediately for',
        points: [
          'Missing or damaged guard, defective switch, exposed conductor, damaged plug or cable, abnormal vibration or noise, damaged accessory, uncontrolled kickback, overheating, fluid leak, unsafe hose connection, failed RCD or protection, loss of stable control or unexpected energization.',
          'Stop when the work area changes or new hazards arise and the RAMS or controls are no longer adequate.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '33',
    title: 'Unsafe Practices → Corrective Actions',
    points: [
      PowerToolsGoldPoint(
        title: 'Unsafe examples',
        points: [
          'Removing guards, using damaged discs, bypassing RCDs, using wrong accessories, pulling a tool by its cable, carrying a running tool, working without required eye protection, connecting damaged hoses or servicing while energized.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Corrective action',
        points: [
          'Stop work, make the area safe, isolate or remove defective equipment, brief affected workers, correct the root cause and verify controls before restart.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '34',
    title: 'Toolbox Talk',
    points: [
      PowerToolsGoldPoint(
        title: 'Five-minute briefing',
        points: [
          'Correct tool and accessory.',
          'Pre-use inspection and guard check.',
          'Energy isolation and RCD or electrical protection.',
          'Flying particles, kickback, dust, noise and vibration.',
          'Exclusion zone and PPE.',
          'Stop-work conditions and emergency response.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '35',
    title: 'Field Checklist',
    points: [
      PowerToolsGoldPoint(
        title: 'Quick inspection',
        points: [
          '☐ Correct tool for task',
          '☐ Correct accessory and rating',
          '☐ Guard fitted and secure',
          '☐ Switch or trigger works correctly',
          '☐ Cable, plug, battery or hose in good condition',
          '☐ RCD or required protection available',
          '☐ No abnormal noise, vibration or overheating',
          '☐ Workpiece secured',
          '☐ Exclusion zone established',
          '☐ Dust, noise and fire controls in place',
          '☐ PPE suitable',
          '☐ Operator competent',
          '☐ RAMS or JSA reviewed',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '36',
    title: 'Quick Reference',
    points: [
      PowerToolsGoldPoint(
        title: 'Remember',
        points: [
          'SELECT → INSPECT → ISOLATE → GUARD → CONTROL → OPERATE → MONITOR → STOP → REPORT.',
          'Never bypass a safety device.',
          'Never use a damaged tool or accessory.',
          'Never service an energized tool.',
          'Always follow manufacturer instructions and the approved site safe system of work.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '37',
    title: 'UAE / Abu Dhabi / Dubai Applicability',
    points: [
      PowerToolsGoldPoint(
        title: 'Abu Dhabi',
        points: [
          'This module is specifically aligned to Abu Dhabi ADOSH-SF CoP 35.0 Portable Power Tools, Version 4.1, effective 16 February 2026.',
          'CoP requirements are mandatory minimum OSH technical requirements within their scope. Project or entity procedures may impose additional controls.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Jurisdiction note',
        points: [
          'Dubai requirements and other emirate or sector requirements must be checked separately. Do not treat an Abu Dhabi CoP as automatically being a Dubai legal requirement.',
        ],
      ),
    ],
  ),
  PowerToolsGoldSection(
    number: '38',
    title: 'Official Regulatory References',
    points: [
      PowerToolsGoldPoint(
        title: 'Primary reference',
        points: [
          'Abu Dhabi Occupational Safety and Health Center (ADPHC), ADOSH-SF CoP 35.0 — Portable Power Tools, Version 4.1, effective 16 February 2026.',
          'Check the official ADPHC Code of Practices registry for the current version and effective date before relying on a regulatory requirement.',
        ],
      ),
      PowerToolsGoldPoint(
        title: 'Related references',
        points: [
          'CoP 2.0 Personal Protective Equipment.',
          'CoP 3.0 Occupational Noise and CoP 3.1 Vibration.',
          'CoP 15.0 Electrical Safety.',
          'CoP 21.0 Permit to Work Systems.',
          'CoP 24.0 Lock-out/Tag-out and Isolation.',
          'CoP 28.0 Hot Work Operations where the tool activity creates hot-work hazards.',
          'CoP 47.0 Machine Guarding where machinery guarding requirements apply.',
        ],
      ),
    ],
  ),
];

// ===== SOURCE: abu_dhabi_formwork_gold.dart =====
/// SafeNexus HSE — Abu Dhabi HSE Gold Standard
/// Topic: Formwork / False Work
/// Regulatory basis: ADOSH-SF CoP 40.0, Version 4.1, February 2026.
///
/// Structured reference content. Project-specific temporary-works design,
/// RAMS, manufacturer instructions, permits and competent-person requirements
/// remain applicable.

class FormworkGoldPoint {
  final String title;
  final List<String> points;

  const FormworkGoldPoint({required this.title, required this.points});
}

class FormworkGoldSection {
  final String number;
  final String title;
  final List<FormworkGoldPoint> points;

  const FormworkGoldSection({
    required this.number,
    required this.title,
    required this.points,
  });
}

const List<FormworkGoldSection> formworkGoldStandardSections = [
  FormworkGoldSection(
    number: '01',
    title: 'Definition & Purpose',
    points: [
      FormworkGoldPoint(
        title: 'Definition',
        points: [
          'False work and formwork are temporary works used to support, shape or retain concrete and associated construction loads until the permanent structure can safely support itself.',
          'Formwork includes shutters, panels, sheathing and associated components. False work includes props, shores, frames, towers, braces and other temporary supporting systems.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Purpose',
        points: [
          'Provide the required geometry, stability, strength, access and protection during erection, reinforcement, concrete placement, curing and striking.',
          'Prevent collapse, excessive movement, uncontrolled release of stored energy and injury to workers or third parties.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '02',
    title: 'Scope & Applications',
    points: [
      FormworkGoldPoint(
        title: 'Applications',
        points: [
          'Columns, walls, beams, slabs, foundations, shafts, retaining structures, bridge works, tanks and other reinforced-concrete construction.',
          'Includes conventional timber or steel systems, proprietary modular systems, table forms, climbing systems and other temporary support arrangements.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Interface',
        points: [
          'Coordinate formwork with reinforcement, embedded items, concrete placing equipment, lifting operations, access systems, electrical services and other simultaneous work.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '03',
    title: 'Types of Formwork',
    points: [
      FormworkGoldPoint(
        title: 'Common systems',
        points: [
          'Timber formwork, steel formwork, aluminium formwork, modular panel systems, plastic systems and proprietary engineered systems.',
          'Beam forms, column forms, wall forms, slab forms, deck systems, table forms and special geometry forms.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Special systems',
        points: [
          'Climbing, self-climbing, slip-form and other engineered systems require system-specific design, procedures, competent personnel and manufacturer requirements.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '04',
    title: 'Components & Parts',
    points: [
      FormworkGoldPoint(
        title: 'Typical components',
        points: [
          'Panels, sheathing, walers, soldiers, ties, clamps, brackets, props, frames, jacks, base plates, sole plates, braces, working platforms and access components.',
          'Anchors, lifting points, pins, couplers, connectors and proprietary locking devices must be compatible with the approved system.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Component integrity',
        points: [
          'Do not substitute, remove or modify structural components without authorization from the responsible temporary-works or design authority.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '05',
    title: 'Design & Engineering',
    points: [
      FormworkGoldPoint(
        title: 'Design principle',
        points: [
          'Formwork and false work must be designed for the loads and conditions expected during construction, including the concrete placement sequence and relevant construction actions.',
          'Design must account for stability, strength, serviceability, support conditions, connections, bracing and load transfer.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Engineering control',
        points: [
          'Use approved drawings, calculations, specifications and manufacturer information. Do not estimate structural capacity in the field.',
          'Changes to the approved system require formal technical review and authorization.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '06',
    title: 'Planning & Site Assessment',
    points: [
      FormworkGoldPoint(
        title: 'Before erection',
        points: [
          'Confirm approved design, method statement, sequence, competent personnel, lifting plan where applicable and inspection arrangements.',
          'Inspect the supporting ground, slab or permanent structure for suitability, level, strength, openings, edges, services and access.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Site conditions',
        points: [
          'Consider wind, rain, heat, poor visibility, restricted access, traffic, adjacent excavations, overhead services and simultaneous operations.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '07',
    title: 'Hazards — One by One',
    points: [
      FormworkGoldPoint(
        title: 'Major hazards',
        points: [
          'Collapse or instability of formwork or false work.',
          'Overloading, inadequate bearing or uncontrolled settlement.',
          'Falls from height and falls through openings.',
          'Falling panels, components, tools or materials.',
          'Crushing and trapping during erection, adjustment or striking.',
          'Unexpected concrete pressure, movement or blowout.',
          'Lifting and suspended-load hazards.',
          'Contact with electrical services.',
          'Unsafe access, poor housekeeping and manual-handling injuries.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Identification',
        points: [
          'Look for damaged components, missing braces or ties, unsupported members, uneven bases, unauthorized modifications, overloaded platforms, movement, settlement, gaps, leaning, loose connections and deviations from approved drawings.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '08',
    title: 'Structural Stability',
    points: [
      FormworkGoldPoint(
        title: 'Stability controls',
        points: [
          'Provide the designed bracing, ties, props, anchors and restraints in the specified arrangement.',
          'Ensure every load path is complete from the formwork through false work and supports into a verified supporting structure or foundation.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Field verification',
        points: [
          'Check verticality, alignment, base conditions, connections, bracing and restraint before loading.',
          'Do not rely on partially erected systems for stability unless the approved erection sequence specifically permits it.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '09',
    title: 'Loads & Capacity',
    points: [
      FormworkGoldPoint(
        title: 'Load sources',
        points: [
          'Consider fresh concrete, reinforcement, workers, equipment, stored materials, construction loads, impact effects and applicable environmental actions identified by the design.',
          'Concrete placement rate and method can significantly affect lateral pressure and system stability.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Capacity rule',
        points: [
          'Never exceed the approved design capacity, manufacturer rating or stated working load limit.',
          'Where a capacity or spacing is required, use the approved engineering documentation rather than an assumed field value.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '10',
    title: 'Erection Sequence',
    points: [
      FormworkGoldPoint(
        title: 'Safe sequence',
        points: [
          'Set out and prepare the support area, establish exclusion zones, position bases or sole plates, erect primary support, install bracing and connections, then install formwork panels and access systems in the approved sequence.',
          'Progressive stability must be maintained at every stage.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Verification',
        points: [
          'Supervisor and competent personnel must verify each critical stage before the next stage is loaded or released.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '11',
    title: 'Striking & Dismantling',
    points: [
      FormworkGoldPoint(
        title: 'Planning',
        points: [
          'Striking must follow the approved sequence and required concrete-strength or engineering release criteria.',
          'Confirm that the structure and remaining temporary works can safely support the loads after each stage.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Dismantling controls',
        points: [
          'Establish exclusion zones, control falling components, use suitable lifting methods and prevent uncontrolled release.',
          'Do not remove props, ties, braces or supports simply because the concrete surface appears hard.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '12',
    title: 'Props & Supports',
    points: [
      FormworkGoldPoint(
        title: 'Prop controls',
        points: [
          'Use the correct type, length, capacity and configuration specified by the design or manufacturer.',
          'Props must stand on adequate bearing surfaces and be protected from displacement, impact and eccentric loading.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Inspection',
        points: [
          'Check threads, pins, collars, plates, tubes, frames and locking mechanisms. Do not use bent, cracked, corroded or otherwise defective supports.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '13',
    title: 'Shoring & Reshoring',
    points: [
      FormworkGoldPoint(
        title: 'Shoring',
        points: [
          'Shoring must be designed and erected to transfer construction loads safely to the supporting structure or ground.',
          'Account for the condition and capacity of slabs or other supporting elements.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Reshoring',
        points: [
          'Reshoring or back-propping must follow an engineered sequence where required and must not be improvised to compensate for an unsafe condition.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '14',
    title: 'Bracing & Restraint',
    points: [
      FormworkGoldPoint(
        title: 'Controls',
        points: [
          'Install all required horizontal, vertical and diagonal bracing, ties, anchors and restraints.',
          'Protect braces and anchors from impact and unauthorized removal.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Critical check',
        points: [
          'Missing one structural restraint can change the load path and stability of the complete system. Treat missing or damaged bracing as a stop-work condition.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '15',
    title: 'Working Platforms & Access',
    points: [
      FormworkGoldPoint(
        title: 'Access',
        points: [
          'Provide safe access and egress suitable for the work. Do not climb on formwork components that are not designed as access.',
          'Use properly designed working platforms, stairs, ladders or other approved access systems.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Platform safety',
        points: [
          'Keep platforms clear, provide required edge protection and prevent tools and materials from falling.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '16',
    title: 'Formwork at Height',
    points: [
      FormworkGoldPoint(
        title: 'Fall prevention',
        points: [
          'Use collective fall prevention such as compliant platforms, guardrails and protected access wherever practicable.',
          'Where fall arrest is required, provide suitable anchor arrangements, compatible equipment, adequate clearance and a rescue plan.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Openings and edges',
        points: [
          'Protect slab edges, shafts, penetrations and other openings against falls and falling objects.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '17',
    title: 'Openings, Edges & Falling Objects',
    points: [
      FormworkGoldPoint(
        title: 'Controls',
        points: [
          'Cover or guard openings using systems capable of resisting the expected loads and identify covers where needed.',
          'Install toe protection or other measures where materials can fall to lower levels.',
          'Establish exclusion zones below overhead formwork activities where required.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '18',
    title: 'Concrete Pouring Interface',
    points: [
      FormworkGoldPoint(
        title: 'Before pour',
        points: [
          'Confirm formwork is complete, braced, tied, aligned, supported and inspected.',
          'Verify embedded items, reinforcement, access, concrete delivery route and communication arrangements.',
        ],
      ),
      FormworkGoldPoint(
        title: 'During pour',
        points: [
          'Control the pour sequence and rate in accordance with the approved method and design.',
          'Monitor for movement, leakage, distortion, unusual sounds, settlement or other signs of instability.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '19',
    title: 'Concrete Pressure & Pour Rate',
    points: [
      FormworkGoldPoint(
        title: 'Pressure control',
        points: [
          'Fresh concrete can create significant lateral pressure. The design and placing procedure must define the permitted conditions for the system.',
          'Do not accelerate concrete placement beyond the approved rate or change the placing method without technical authorization.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Emergency response',
        points: [
          'If abnormal movement, bulging, leakage or instability is observed, stop the pour, keep personnel out of the danger zone and follow the site emergency and temporary-works procedure.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '20',
    title: 'Mobile & Crane-Lifted Formwork',
    points: [
      FormworkGoldPoint(
        title: 'Lifting',
        points: [
          'Use approved lifting points, lifting accessories and a suitable lifting plan.',
          'Confirm the load is within the lifting equipment and formwork system limits and control the suspended load.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Movement',
        points: [
          'Secure components against unexpected movement. Establish an exclusion zone and use tag lines where appropriate and safe.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '21',
    title: 'RAMS / JSA / Risk Assessment',
    points: [
      FormworkGoldPoint(
        title: 'Minimum content',
        points: [
          'Scope, approved design, sequence, hazards, controls, support conditions, lifting activities, access, fall protection, concrete placement, striking sequence and emergency arrangements.',
          'Identify interfaces with cranes, MEWPs, scaffolds, reinforcement, concrete pumps, electrical systems and traffic.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Review triggers',
        points: [
          'Review when design, sequence, materials, support conditions, equipment, personnel or site conditions change.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '22',
    title: 'PTW / Authorization',
    points: [
      FormworkGoldPoint(
        title: 'Authorization',
        points: [
          'Use the site permit system where required by the activity or location.',
          'Critical temporary-works stages, lifting operations, work at height, hot work, electrical isolation and other controlled activities may require separate authorization under the site system.',
        ],
      ),
      FormworkGoldPoint(
        title: 'No unauthorized change',
        points: [
          'Do not erect, alter or strike a designed temporary-works system without the required authorization and approved information.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '23',
    title: 'Inspection & Examination',
    points: [
      FormworkGoldPoint(
        title: 'Inspection stages',
        points: [
          'Inspect supporting surfaces before erection, components before use, the partially erected system during erection, the completed system before loading, and the system after significant changes or events.',
          'Inspect after impact, abnormal movement, severe weather or any event that may affect stability.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Records',
        points: [
          'Record required inspections, defects, corrective actions, approvals and release for use in accordance with the project system.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '24',
    title: 'Competency & Responsibilities',
    points: [
      FormworkGoldPoint(
        title: 'Workers',
        points: [
          'Only trained and authorized personnel should erect, alter, use or dismantle formwork systems within their assigned competence.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Supervisor',
        points: [
          'Verify approved drawings and method, competent workers, sequence, exclusion zones, inspections and safe conditions.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Temporary-works or design authority',
        points: [
          'Provide or approve the engineering basis and technical changes within the project responsibility structure.',
        ],
      ),
      FormworkGoldPoint(
        title: 'HSE',
        points: [
          'Verify implementation of risk controls, access, fall protection, lifting controls, inspections and corrective actions; stop unsafe work.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '25',
    title: 'PPE',
    points: [
      FormworkGoldPoint(
        title: 'Minimum task-based PPE',
        points: [
          'Safety helmet, safety footwear, suitable gloves and eye protection as required by the task.',
          'Use fall-protection equipment, hearing protection, respiratory protection or other PPE when identified by the risk assessment.',
        ],
      ),
      FormworkGoldPoint(
        title: 'PPE limitation',
        points: [
          'PPE does not compensate for inadequate structural design, missing bracing, unsafe access or defective temporary works.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '26',
    title: 'Weather & Environmental Conditions',
    points: [
      FormworkGoldPoint(
        title: 'Weather',
        points: [
          'Consider wind, rain, heat, reduced visibility and other conditions that can affect erection, lifting, stability or worker safety.',
          'Secure loose components and suspend exposed work when conditions exceed the approved safe limits.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Ground and support',
        points: [
          'Protect support areas from undermining, flooding, settlement, excavation changes or other conditions that could affect load transfer.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '27',
    title: 'Simultaneous Operations',
    points: [
      FormworkGoldPoint(
        title: 'Interface hazards',
        points: [
          'Coordinate formwork with reinforcement fixing, concrete pumps, cranes, lifting, scaffolding, electrical work, MEWP operations, vehicles and pedestrian routes.',
          'Prevent unauthorized personnel from entering temporary-works danger zones.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Coordination',
        points: [
          'Use the project\'s coordination and permit arrangements for high-risk simultaneous operations.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '28',
    title: 'Safe Work Procedure',
    points: [
      FormworkGoldPoint(
        title: 'Before erection',
        points: [
          'Review approved drawings and RAMS, inspect components, prepare the base, establish exclusion zones and verify access and lifting arrangements.',
        ],
      ),
      FormworkGoldPoint(
        title: 'During erection',
        points: [
          'Follow the approved sequence, maintain progressive stability, install required braces and connections, and do not improvise structural details.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Before loading or pouring',
        points: [
          'Complete the required inspection and authorization. Confirm formwork, false work, access and fall protection are ready.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Striking',
        points: [
          'Confirm engineering or project release criteria, isolate the area, follow the dismantling sequence and control falling or suspended components.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '29',
    title: 'Maintenance & Defects',
    points: [
      FormworkGoldPoint(
        title: 'Defects',
        points: [
          'Quarantine damaged, bent, cracked, excessively corroded or otherwise defective components.',
          'Do not straighten, weld, drill or modify structural components unless the responsible engineering authority approves the repair.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Housekeeping',
        points: [
          'Remove concrete buildup and debris where it can interfere with connections, access, alignment or safe operation, using approved methods.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '30',
    title: 'Emergency & Rescue',
    points: [
      FormworkGoldPoint(
        title: 'Collapse or instability',
        points: [
          'Stop work, raise the alarm, keep people outside the collapse zone and do not enter an unstable structure to perform an informal rescue.',
          'Activate the site emergency and rescue plan and use competent emergency responders.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Fall or trapped person',
        points: [
          'Call emergency assistance and use the planned rescue system. Do not create a second casualty by entering an unsafe area without proper controls.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '31',
    title: 'Stop-Work Conditions',
    points: [
      FormworkGoldPoint(
        title: 'Immediate stop',
        points: [
          'Missing or damaged primary bracing, unexpected movement, settlement, bulging, distortion, loose or missing connections, overloaded components, inadequate bearing, unauthorized modification, damaged structural component, unsafe access, failed fall protection or conditions outside the approved design basis.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Restart',
        points: [
          'Do not restart until the cause is identified, the system is made safe, competent technical or supervisory verification is completed and required authorization is obtained.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '32',
    title: 'Unsafe Practices → Corrective Actions',
    points: [
      FormworkGoldPoint(
        title: 'Unsafe examples',
        points: [
          'Removing props early, omitting braces, mixing incompatible components, overloading platforms, storing heavy materials on formwork without design approval, climbing on panels, standing beneath suspended panels, changing pour rate without authorization or striking without release.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Corrective action',
        points: [
          'Stop work, isolate the hazard, restore the approved configuration, obtain technical review where necessary, brief the workforce and verify before restart.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '33',
    title: 'Toolbox Talk',
    points: [
      FormworkGoldPoint(
        title: 'Key briefing points',
        points: [
          'Approved formwork design and erection sequence.',
          'Bracing, ties, props and base conditions.',
          'Fall protection and safe access.',
          'Concrete pour sequence and pressure controls.',
          'Lifting and exclusion zones.',
          'Inspection and release before loading.',
          'Striking sequence and stop-work conditions.',
          'Emergency response for instability or collapse.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '34',
    title: 'Field Checklist',
    points: [
      FormworkGoldPoint(
        title: 'Before erection',
        points: [
          '☐ Approved drawings and RAMS available',
          '☐ Components identified and inspected',
          '☐ Base or supporting structure verified',
          '☐ Correct props, braces and connectors available',
          '☐ Safe access and exclusion zone established',
          '☐ Lifting plan and equipment verified where applicable',
        ],
      ),
      FormworkGoldPoint(
        title: 'Before concrete',
        points: [
          '☐ Formwork complete and aligned',
          '☐ Bracing and ties complete',
          '☐ Props and bearing conditions verified',
          '☐ Openings and edges protected',
          '☐ Access platforms safe',
          '☐ Inspection and release completed',
          '☐ Concrete placing sequence confirmed',
        ],
      ),
      FormworkGoldPoint(
        title: 'During pour',
        points: [
          '☐ Pour rate controlled',
          '☐ Workers monitoring movement and leakage',
          '☐ No unauthorized changes',
          '☐ Exclusion zones maintained',
        ],
      ),
      FormworkGoldPoint(
        title: 'Before striking',
        points: [
          '☐ Required concrete strength or release criteria confirmed',
          '☐ Approved striking sequence available',
          '☐ Area isolated',
          '☐ Falling-object controls established',
          '☐ Remaining supports verified',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '35',
    title: 'Quick Reference',
    points: [
      FormworkGoldPoint(
        title: 'Safety cycle',
        points: [
          'IDENTIFY → ASSESS → DESIGN → ERECT → INSPECT → AUTHORIZE → LOAD → MONITOR → STRIKE → REVIEW.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Golden rules',
        points: [
          'Never improvise structural capacity.',
          'Never remove a prop, brace, tie or anchor without authorization.',
          'Never load an incomplete or uninspected system.',
          'Never stand under suspended formwork.',
          'Never change the concrete placing sequence without technical approval.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '36',
    title: 'UAE / Abu Dhabi / Dubai Applicability',
    points: [
      FormworkGoldPoint(
        title: 'Abu Dhabi',
        points: [
          'This module is specifically aligned to Abu Dhabi ADOSH-SF CoP 40.0 — False Work (Formwork), Version 4.1, February 2026.',
          'Project specifications, temporary-works design requirements and other applicable ADOSH-SF requirements may impose additional controls.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Jurisdiction note',
        points: [
          'Dubai requirements and other emirate or sector requirements must be checked separately. An Abu Dhabi CoP should not be presented as automatically being a Dubai legal requirement.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '37',
    title: 'Related CoPs & Cross References',
    points: [
      FormworkGoldPoint(
        title: 'Relevant Abu Dhabi references',
        points: [
          'CoP 2.0 Personal Protective Equipment.',
          'CoP 15.0 Electrical Safety.',
          'CoP 21.0 Permit to Work Systems.',
          'CoP 23.0 Working at Heights.',
          'CoP 24.0 Lock-out/Tag-out and Isolation where isolation is required.',
          'CoP 26.0 Scaffolding where scaffold access or interfaces apply.',
          'CoP 34.0 Lifting Equipment and Accessories where formwork is lifted.',
          'CoP 36.0 Plant and Equipment where construction plant interfaces apply.',
          'CoP 39.0 Overhead and Underground Services where service hazards apply.',
          'CoP 43.0 Temporary Structures where the temporary structure interface applies.',
          'CoP 53.1 OSH Construction Management Plan.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '38',
    title: 'Official Regulatory References',
    points: [
      FormworkGoldPoint(
        title: 'Primary reference',
        points: [
          'Abu Dhabi Occupational Safety and Health Center (ADPHC), ADOSH-SF CoP 40.0 — False Work (Formwork), Version 4.1, February 2026.',
          'Check the official ADPHC Code of Practices registry for the current version, effective date and applicability before relying on a regulatory requirement.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Engineering reference',
        points: [
          'Use the approved project temporary-works design, structural calculations, drawings, specifications and manufacturer instructions for system-specific dimensions, loads, capacities, spacing and release criteria.',
          'Do not substitute generic field values for project-specific engineering requirements.',
        ],
      ),
    ],
  ),
];

// ===== SOURCE: abu_dhabi_permit_to_work_gold.dart =====
/// SafeNexus HSE — Abu Dhabi HSE Gold Standard
/// Topic: Permit to Work Systems
/// Regulatory basis: ADOSH-SF CoP 21.0, Version 4.0, effective 15 July 2024.
///
/// Structured reference content. The entity/project PTW procedure, RAMS/JSA,
/// isolation procedure, permits, competency requirements and current official
/// regulatory documents remain applicable.

class PermitToWorkGoldPoint {
  final String title;
  final List<String> points;

  const PermitToWorkGoldPoint({required this.title, required this.points});
}

class PermitToWorkGoldSection {
  final String number;
  final String title;
  final List<PermitToWorkGoldPoint> points;

  const PermitToWorkGoldSection({
    required this.number,
    required this.title,
    required this.points,
  });
}

const List<PermitToWorkGoldSection> permitToWorkGoldStandardSections = [
  PermitToWorkGoldSection(
    number: '01',
    title: 'Definition & Purpose',
    points: [
      PermitToWorkGoldPoint(
        title: 'Definition',
        points: [
          'A Permit to Work (PTW) is a formal documented system used to control specified work by defining the work scope, hazards, precautions, authorization, communication and status of the work.',
          'PTW is a control system; it does not by itself make an unsafe task safe and does not replace risk assessment, RAMS, isolation, competency or supervision.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Purpose',
        points: [
          'Prevent uncontrolled or conflicting work, ensure hazards and controls are understood, verify required precautions before work starts and provide controlled suspension, handover and close-out.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '02',
    title: 'Scope & Applications',
    points: [
      PermitToWorkGoldPoint(
        title: 'Application',
        points: [
          'CoP 21.0 requires employers to identify and safely manage activities requiring PTW and to establish a PTW system for non-routine activities.',
          'PTW may be required for high-risk, non-routine, hazardous or potentially conflicting work depending on the entity\'s PTW procedure and risk assessment.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Common examples',
        points: [
          'Hot work, confined-space entry, electrical work or isolation, excavation, work at height, work on or near hazardous systems, line breaking, critical lifting or other controlled work where the site system requires authorization.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '03',
    title: 'PTW Philosophy & Limits',
    points: [
      PermitToWorkGoldPoint(
        title: 'Key principle',
        points: [
          'The permit confirms that defined precautions have been established for a defined task, location, time and set of conditions.',
          'Permit boundaries must be clear enough that workers can identify exactly what is authorized and what is outside the permit.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Limits',
        points: [
          'A permit is not a substitute for competent people, approved method statements, risk assessment, isolation, equipment inspection or emergency planning.',
          'Permit validity must not be treated as permission to continue when conditions become unsafe.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '04',
    title: 'PTW Roles & Responsibilities',
    points: [
      PermitToWorkGoldPoint(
        title: 'Employer',
        points: [
          'Identify activities requiring PTW, establish the PTW system, ensure competent personnel and provide arrangements for safe management.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Permit issuer / authorizing person',
        points: [
          'Verify the scope, hazards, precautions, required isolations and conditions before authorizing work, within the person\'s defined authority.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Permit receiver / performing authority',
        points: [
          'Understand the scope and controls, brief the work party, maintain the permit conditions and stop or suspend work when conditions change.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Workers',
        points: [
          'Follow the permit, RAMS and site rules, remain within the authorized scope and immediately report hazards or changed conditions.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'HSE / supervision',
        points: [
          'Verify implementation, audit the system, support field controls and intervene when permit conditions are not being followed.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '05',
    title: 'Competency, Training & Authorization',
    points: [
      PermitToWorkGoldPoint(
        title: 'Competency',
        points: [
          'Persons involved in issuing, receiving, checking, isolating, monitoring or closing permits must be competent for their assigned role.',
          'Competency should include understanding of the PTW procedure, hazards, control measures, permit boundaries, communication, suspension and emergency requirements.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Authorization',
        points: [
          'Only designated persons with the required authority may issue, approve, accept, suspend or close permits according to the project PTW matrix.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '06',
    title: 'Planning & Assessment',
    points: [
      PermitToWorkGoldPoint(
        title: 'Planning',
        points: [
          'Evaluate the operation and determine whether PTW is required using risk-management practices.',
          'Identify affected people, assets, environment, simultaneous operations, energy sources, emergency arrangements and required controls.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Work package',
        points: [
          'Coordinate PTW with risk assessment, RAMS/JSA, drawings, procedures, isolation certificates, inspection records, lifting plans and other supporting documents.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '07',
    title: 'When is a PTW Required?',
    points: [
      PermitToWorkGoldPoint(
        title: 'Decision process',
        points: [
          'Check the organization\'s approved PTW procedure and risk assessment for the activity.',
          'Apply the PTW system when the identified hazards, work type, location, process or simultaneous operations require formal authorization.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Do not assume',
        points: [
          'Do not create a permit merely as paperwork or omit one because a task appears routine. The project\'s approved PTW matrix and risk assessment determine applicability.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '08',
    title: 'Permit Types & Categories',
    points: [
      PermitToWorkGoldPoint(
        title: 'Typical categories',
        points: [
          'Hot Work Permit, Cold Work or General Work Permit, Confined Space Entry Permit, Electrical Work or Electrical Isolation Permit, Excavation Permit and other specialized permits defined by the project.',
          'Some organizations use separate certificates for isolation, gas testing, line breaking or other supporting controls.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Important',
        points: [
          'Permit names and categories can differ between organizations. SafeNexus should show the local site\'s approved permit taxonomy rather than inventing a universal list.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '09',
    title: 'Permit Scope & Boundaries',
    points: [
      PermitToWorkGoldPoint(
        title: 'Scope',
        points: [
          'Define the exact job, location, equipment or system, work limits, start conditions and authorized personnel.',
          'State what is excluded when an adjacent activity could be confused with the permitted work.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Boundary control',
        points: [
          'Use physical identification, drawings, tags, signs, barricades or other suitable means where required.',
          'Workers must be able to recognize the permit boundary in the field.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '10',
    title: 'Hazard Identification',
    points: [
      PermitToWorkGoldPoint(
        title: 'Minimum hazard review',
        points: [
          'Energy sources, electrical energy, pressure, stored energy, hazardous substances, fire and explosion, oxygen deficiency, toxic atmosphere, moving equipment, vehicles, lifting, falls, excavation, confined spaces, dropped objects, environmental conditions and simultaneous operations.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Field verification',
        points: [
          'Do not rely only on a desk review. Confirm actual site conditions before authorization and during the work.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '11',
    title: 'Risk Assessment & RAMS / JSA',
    points: [
      PermitToWorkGoldPoint(
        title: 'Relationship',
        points: [
          'The risk assessment identifies hazards and evaluates risk; RAMS/JSA explains the safe work method; PTW authorizes the defined activity after required controls are verified.',
          'All three must be consistent with the same task, location, equipment and conditions.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Change',
        points: [
          'If the task, sequence, equipment, location or conditions change materially, stop and reassess before continuing.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '12',
    title: 'Control Measures & Hierarchy',
    points: [
      PermitToWorkGoldPoint(
        title: 'Control sequence',
        points: [
          'Eliminate the hazard where practicable, substitute safer methods, use engineering controls, apply administrative controls and use PPE as the final layer.',
          'PTW should identify the controls that must be in place before work starts and those that must remain during the task.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Critical controls',
        points: [
          'Isolation, guarding, gas testing, ventilation, fire prevention, fall protection, exclusion zones, access control and competent supervision must be verified when applicable.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '13',
    title: 'Permit Preparation',
    points: [
      PermitToWorkGoldPoint(
        title: 'Before issue',
        points: [
          'Define work scope, location, equipment, hazards, controls, required isolations, PPE, testing, emergency arrangements, simultaneous work restrictions and validity period.',
          'Attach or reference supporting documents and certificates required by the site procedure.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Field readiness',
        points: [
          'Confirm the work area is prepared and the stated controls actually exist before the permit is authorized.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '14',
    title: 'Permit Authorization & Issue',
    points: [
      PermitToWorkGoldPoint(
        title: 'Authorization',
        points: [
          'The authorized issuer verifies the permit information and required precautions before signing or electronically authorizing it.',
          'The permit receiver confirms understanding and acceptance of the conditions before work begins.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'No premature start',
        points: [
          'Work must not start until required authorization, isolation, testing and other preconditions are complete.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '15',
    title: 'Isolation & Verification',
    points: [
      PermitToWorkGoldPoint(
        title: 'Isolation',
        points: [
          'Where hazardous energy or process isolation is required, use the approved isolation and lockout/tagout system.',
          'Identify all relevant energy sources, including electrical, mechanical, hydraulic, pneumatic, pressure, thermal, chemical and stored energy.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Verification',
        points: [
          'Isolation must be verified using the site\'s approved method before work starts. Do not rely solely on a tag or assumption.',
          'Where required, zero-energy or safe-state verification must be documented through the appropriate isolation certificate or procedure.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '16',
    title: 'Gas Testing & Atmospheric Monitoring',
    points: [
      PermitToWorkGoldPoint(
        title: 'When applicable',
        points: [
          'Use competent gas testers and calibrated or approved instruments where atmospheric hazards are possible.',
          'Test for oxygen, flammable atmosphere and relevant toxic contaminants according to the task-specific risk assessment and applicable procedure.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Ongoing monitoring',
        points: [
          'Continuous or periodic monitoring may be required when conditions can change. Define the frequency or continuous-monitoring requirement in the permit and risk assessment.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Alarm response',
        points: [
          'If readings become unsafe or an alarm occurs, stop work, withdraw or evacuate as required and follow the emergency procedure.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '17',
    title: 'Hot Work Interface',
    points: [
      PermitToWorkGoldPoint(
        title: 'Hot work',
        points: [
          'Where hot work is outside a designated area, a specific Hot Work Permit is required under the applicable Abu Dhabi hot-work requirements.',
          'Verify combustible-material control, fire protection, gas testing where applicable, fire watch and post-work monitoring as required by the hot-work procedure.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Related reference',
        points: [
          'Hot-work permit controls must align with CoP 28.0 and the project PTW system.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '18',
    title: 'Confined Space Interface',
    points: [
      PermitToWorkGoldPoint(
        title: 'Entry',
        points: [
          'Confined-space entry requires the applicable entry permit and controls, including hazard assessment, isolation, atmospheric testing, ventilation, communication, standby arrangements and rescue planning as applicable.',
          'Do not treat a general work permit as sufficient where the confined-space procedure requires a dedicated entry permit.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '19',
    title: 'Electrical Work & Isolation Interface',
    points: [
      PermitToWorkGoldPoint(
        title: 'Electrical',
        points: [
          'Electrical work must be controlled under the applicable electrical safety and isolation procedure.',
          'Verify isolation, lockout/tagout, identification, testing for dead or other approved verification, earthing or grounding and boundaries as required by the electrical task.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Permit coordination',
        points: [
          'Link electrical permits or certificates to the main PTW where the project system requires cross-referencing.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '20',
    title: 'Excavation / Ground Disturbance Interface',
    points: [
      PermitToWorkGoldPoint(
        title: 'Excavation',
        points: [
          'Where excavation or ground disturbance requires formal authorization, the excavation permit must be coordinated with service information, risk assessment, shoring or sloping controls, access, inspection and emergency arrangements.',
          'Underground-service controls must be verified before breaking ground.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '21',
    title: 'Work at Height / Lifting / Other Interfaces',
    points: [
      PermitToWorkGoldPoint(
        title: 'Work at height',
        points: [
          'Where PTW is required, verify fall-prevention systems, access, rescue arrangements and exclusion zones before authorization.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Lifting',
        points: [
          'Where critical or controlled lifting is subject to PTW, coordinate the permit with the lifting plan, competent lifting team, equipment certification, exclusion zone and communication arrangements.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Other interfaces',
        points: [
          'Coordinate scaffolding, temporary works, plant, road interface, line breaking, chemicals and other specialist controls with their applicable procedures.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '22',
    title: 'Simultaneous & Conflicting Activities',
    points: [
      PermitToWorkGoldPoint(
        title: 'Conflict identification',
        points: [
          'Identify activities that can create conflicting hazards, such as hot work near flammables, lifting over occupied areas, excavation near services, electrical work near water or simultaneous work on the same equipment.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Control',
        points: [
          'Sequence or segregate work, establish exclusion zones, suspend conflicting permits where necessary and use a permit coordination system.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '23',
    title: 'Communication & Handover',
    points: [
      PermitToWorkGoldPoint(
        title: 'Communication',
        points: [
          'Communicate permit conditions to the work party in a language and form they understand.',
          'Maintain clear communication between operations, permit issuer, permit receiver, isolating authority, HSE and affected work groups.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Shift handover',
        points: [
          'Do not assume a permit automatically transfers between shifts. Follow the site\'s formal handover and revalidation process.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '24',
    title: 'Permit Validity, Suspension & Revalidation',
    points: [
      PermitToWorkGoldPoint(
        title: 'Validity',
        points: [
          'Use the validity period and conditions defined by the project PTW procedure. A permit is valid only for its stated scope and conditions.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Suspend',
        points: [
          'Suspend work for unsafe conditions, emergency alarms, loss of isolation, weather or environmental changes, conflicting operations, personnel changes that affect competence, or any condition outside the permit.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Revalidation',
        points: [
          'Before restarting, recheck required conditions and obtain the required authorization or revalidation.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '25',
    title: 'Management of Change',
    points: [
      PermitToWorkGoldPoint(
        title: 'Change triggers',
        points: [
          'Changes to equipment, process, location, work method, sequence, personnel, isolation, materials, hazards or environmental conditions may require formal review.',
          'Do not use an old permit to cover materially changed work.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'MOC interface',
        points: [
          'Where the change is significant, apply the site\'s Management of Change process and issue a new or revised permit as required.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '26',
    title: 'Emergency Situations',
    points: [
      PermitToWorkGoldPoint(
        title: 'Emergency',
        points: [
          'Emergency response takes priority over routine permit administration. Stop work and activate the emergency procedure when necessary.',
          'Ensure the permit identifies relevant alarms, emergency contacts, evacuation routes, muster points, rescue resources and isolation arrangements where applicable.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'After emergency',
        points: [
          'Do not resume work until the area is declared safe, the causes and controls are reviewed and the PTW is revalidated or reissued according to the procedure.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '27',
    title: 'Stop-Work Conditions',
    points: [
      PermitToWorkGoldPoint(
        title: 'Stop immediately',
        points: [
          'Permit expired or outside scope; required control missing; isolation uncertain; unsafe gas reading; alarm; weather beyond safe limits; conflicting activity; unauthorized personnel; changed conditions; defective equipment; loss of communication; or any person identifies an imminent danger.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Worker authority',
        points: [
          'Workers must be able to stop work and report the condition without being pressured to continue.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '28',
    title: 'Permit Close-Out',
    points: [
      PermitToWorkGoldPoint(
        title: 'Completion',
        points: [
          'Confirm work is complete or safely suspended, tools and materials are removed, guards and barriers are restored where required, personnel are accounted for and the work area is left in a safe condition.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Close-out',
        points: [
          'The permit receiver and authorized issuer complete the required close-out. Restore equipment or systems only under the applicable authorization and isolation procedure.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '29',
    title: 'Record Keeping & Traceability',
    points: [
      PermitToWorkGoldPoint(
        title: 'Records',
        points: [
          'Retain permits, supporting certificates, isolation records, gas-test records, approvals, handovers, suspensions, close-outs and related documents according to the entity\'s record-retention procedure.',
          'Records should allow the organization to determine what work was authorized, by whom, where, when and under what controls.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Audit trail',
        points: [
          'Correct errors according to the approved document-control procedure. Do not erase or obscure permit history in a way that destroys traceability.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '30',
    title: 'Auditing, Monitoring & Verification',
    points: [
      PermitToWorkGoldPoint(
        title: 'Field verification',
        points: [
          'Supervisors and HSE personnel should verify that actual work matches the permit and RAMS.',
          'Permit audits should examine both paperwork quality and field implementation.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Effectiveness',
        points: [
          'Repeated permit failures, conflicting work, unauthorized work or control failures should trigger corrective action and review of the PTW system.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '31',
    title: 'Unsafe Practices → Corrective Actions',
    points: [
      PermitToWorkGoldPoint(
        title: 'Unsafe examples',
        points: [
          'Starting before authorization, signing without checking the worksite, copying old permits, using a permit outside its scope, bypassing isolation, failing to communicate suspension, allowing conflicting work, continuing after changed conditions or closing a permit without verifying the worksite.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Corrective action',
        points: [
          'Stop work, make the area safe, notify the responsible authority, correct the control failure, reassess the task and reauthorize only after requirements are met.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '32',
    title: 'Roles Matrix & Field Accountability',
    points: [
      PermitToWorkGoldPoint(
        title: 'Issuer',
        points: [
          'Confirm hazards, controls, isolations, boundaries, supporting documents and authorization requirements.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Receiver',
        points: [
          'Accept the conditions, brief workers, control the work and stop when conditions change.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Performing worker',
        points: [
          'Follow the permit and RAMS, stay within boundaries and report hazards immediately.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Area or operations authority',
        points: [
          'Coordinate operational conditions, isolations, plant status and simultaneous activities where applicable.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '33',
    title: 'Toolbox Talk',
    points: [
      PermitToWorkGoldPoint(
        title: 'Five-minute PTW briefing',
        points: [
          'What exactly are we authorized to do?',
          'Where exactly can we work?',
          'What hazards and energy sources exist?',
          'What isolations and tests are required?',
          'What controls must remain in place?',
          'What activities must not occur simultaneously?',
          'When must we stop and suspend the permit?',
          'Who do we contact in an emergency?',
          'How will the permit be handed over and closed?',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '34',
    title: 'Field Checklist',
    points: [
      PermitToWorkGoldPoint(
        title: 'Before issue',
        points: [
          '☐ Correct permit type',
          '☐ Exact scope and location defined',
          '☐ Risk assessment and RAMS reviewed',
          '☐ Hazards identified',
          '☐ Controls verified in field',
          '☐ Required isolation identified and verified',
          '☐ Gas testing completed where applicable',
          '☐ Competent persons confirmed',
          '☐ PPE and equipment available',
          '☐ Emergency arrangements ready',
          '☐ Conflicting activities controlled',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'During work',
        points: [
          '☐ Permit available at worksite',
          '☐ Scope unchanged',
          '☐ Controls maintained',
          '☐ Isolation remains effective',
          '☐ Required monitoring continues',
          '☐ No conflicting activity',
          '☐ Supervisor verification completed',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Close-out',
        points: [
          '☐ Work completed or safely suspended',
          '☐ Area inspected',
          '☐ Tools and waste removed',
          '☐ Guards/barriers restored',
          '☐ Personnel accounted for',
          '☐ Equipment restoration authorized',
          '☐ Permit formally closed',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '35',
    title: 'Quick Reference',
    points: [
      PermitToWorkGoldPoint(
        title: 'PTW lifecycle',
        points: [
          'IDENTIFY → ASSESS → PLAN → ISOLATE → VERIFY → AUTHORIZE → BRIEF → WORK → MONITOR → SUSPEND/REVALIDATE → CLOSE.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Golden rules',
        points: [
          'No permit where a permit is required.',
          'No work before authorization.',
          'No work outside permit scope.',
          'No work with unverified critical controls.',
          'No continuation after significant change without reassessment and authorization.',
          'Permit does not replace RAMS, isolation, competency or supervision.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '36',
    title: 'UAE / Abu Dhabi / Dubai Applicability',
    points: [
      PermitToWorkGoldPoint(
        title: 'Abu Dhabi',
        points: [
          'This module is aligned to Abu Dhabi ADOSH-SF CoP 21.0 — Permit to Work Systems, Version 4.0, effective 15 July 2024, as listed by ADPHC.',
          'ADPHC states that CoPs provide minimum mandatory OSH technical requirements and apply to entities within their scope.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Jurisdiction note',
        points: [
          'Dubai and other emirates may have different legal or client PTW requirements. Do not present Abu Dhabi CoP 21.0 as automatically being Dubai law.',
          'Client, principal contractor, facility, operator and sector PTW rules may add controls.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '37',
    title: 'Related CoPs & Cross References',
    points: [
      PermitToWorkGoldPoint(
        title: 'Core references',
        points: [
          'CoP 2.0 Personal Protective Equipment.',
          'CoP 15.0 Electrical Safety.',
          'CoP 23.0 Working at Heights.',
          'CoP 24.0 Lock-out/Tag-out (Isolation).',
          'CoP 27.0 Confined Spaces.',
          'CoP 28.0 Hot Work Operations.',
          'CoP 29.0 Excavation Work.',
          'CoP 33.0 Working On or Adjacent to a Road.',
          'CoP 34.0 Safe Use of Lifting Equipment and Lifting Accessories.',
          'CoP 39.0 Overhead and Underground Services.',
          'CoP 40.0 False Work (Formwork).',
          'CoP 53.1 OSH Construction Management Plan.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '38',
    title: 'Official Regulatory References',
    points: [
      PermitToWorkGoldPoint(
        title: 'Primary source',
        points: [
          'Abu Dhabi Occupational Safety and Health Center (ADPHC), ADOSH-SF CoP 21.0 — Permit to Work Systems, Version 4.0, effective 15 July 2024.',
          'Official ADPHC Code of Practices registry should be checked for the current version, effective date and applicability before relying on a regulatory requirement.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Structure verified from official CoP',
        points: [
          'CoP 21.0 covers training and competency; roles and responsibilities; planning and assessment; when a permit is required; permit procedure; specific roles; scope; hazard identification; controls; simultaneous conflicting activities; communication; close-out; verification of isolations; management of change; emergency situations; record keeping and references.',
        ],
      ),
    ],
  ),
];

// ===== SOURCE: abu_dhabi_safety_in_heat_gold.dart =====
/// SafeNexus HSE — Abu Dhabi HSE Gold Standard
/// Topic: Safety in the Heat / Working in Hot & Humid Climate
/// Regulatory basis: ADOSH-SF CoP 11.0, Version 4.0, effective 15 July 2024.
///
/// Structured reference content. Site heat-management procedures, medical
/// guidance, risk assessments and current official requirements remain applicable.

class SafetyInHeatGoldPoint {
  final String title;
  final List<String> points;

  const SafetyInHeatGoldPoint({required this.title, required this.points});
}

class SafetyInHeatGoldSection {
  final String number;
  final String title;
  final List<SafetyInHeatGoldPoint> points;

  const SafetyInHeatGoldSection({
    required this.number,
    required this.title,
    required this.points,
  });
}

const List<SafetyInHeatGoldSection> safetyInHeatGoldStandardSections = [
  SafetyInHeatGoldSection(
    number: '01',
    title: 'Definition & Purpose',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Heat exposure occurs when environmental heat, humidity, radiant heat, workload, clothing and individual factors reduce the body\'s ability to lose heat. The purpose is to prevent heat-related illness and maintain safe work performance.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '02',
    title: 'Scope & Applications',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Applies to outdoor and indoor work where heat exposure can occur, including construction, road work, lifting, confined or poorly ventilated areas, workshops, kitchens and hot process areas.',
          'Controls must be adapted to the actual work, season, location, duration and exposure.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '03',
    title: 'Heat Stress Hazards',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Key hazards include high air temperature, humidity, radiant heat, low air movement, heavy physical work, direct sunlight, hot surfaces, impermeable PPE, dehydration, inadequate acclimatization and long exposure duration.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '04',
    title: 'Heat Balance & Environmental Factors',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Assess temperature together with humidity, radiant heat, air movement, workload, clothing and exposure duration. Humidity can reduce evaporative cooling and increase heat strain.',
          'Do not judge heat risk from air temperature alone.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '05',
    title: 'Worker Heat-Illness Awareness',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Workers should know early symptoms and immediately report headache, dizziness, weakness, unusual fatigue, thirst, nausea, cramps, confusion or other abnormal symptoms.',
          'Workers must never be discouraged from reporting heat symptoms.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '06',
    title: 'Heat Cramps',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Heat cramps can occur during or after strenuous activity and sweating. Stop the activity, move the person to a cooler area, provide appropriate first aid and medical assessment according to the site procedure.',
          'Escalate if symptoms are severe, persistent or accompanied by signs of serious heat illness.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '07',
    title: 'Heat Exhaustion',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Possible signs include heavy sweating, weakness, dizziness, headache, nausea, thirst and reduced ability to continue work safely.',
          'Stop work, move to a cool area, cool the person, provide appropriate fluids if the person is alert and able to drink, and obtain medical assistance according to the emergency procedure.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '08',
    title: 'Heat Stroke',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Heat stroke is a life-threatening emergency. Warning signs can include altered mental status, confusion, collapse, seizures or very high body temperature.',
          'Activate emergency medical response immediately and begin rapid cooling according to trained first-aid procedures. Do not leave the casualty alone.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '09',
    title: 'Risk Assessment',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Assess heat exposure as part of the risk-management process, considering task, location, season, weather, workload, clothing, worker acclimatization, duration, breaks, hydration, supervision and emergency arrangements.',
          'Review the assessment when conditions or work methods change.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '10',
    title: 'Work Planning',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Plan heavy work for cooler periods where practicable, reduce unnecessary exposure, provide recovery opportunities and organize manpower so that heat exposure can be controlled.',
          'Use mechanization, job rotation and task redesign where practicable to reduce physical heat load.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '11',
    title: 'Acclimatization',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'New workers, workers returning after an extended absence and workers with limited recent heat exposure require a controlled acclimatization approach under the employer\'s heat-management procedure.',
          'Increase exposure and workload progressively while providing closer supervision and monitoring during acclimatization.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '12',
    title: 'Hydration',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Provide adequate cool potable drinking water at accessible locations close to the work.',
          'Encourage workers to drink regularly rather than waiting until severe thirst develops. Apply the employer\'s approved hydration program and medical guidance for electrolyte replacement where appropriate.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '13',
    title: 'Rest & Recovery',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Provide suitable rest or recovery arrangements based on the heat-risk assessment and applicable ADOSH requirements.',
          'Recovery areas should reduce heat exposure and provide shade or cooling as appropriate.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '14',
    title: 'Shade & Cooling',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Provide effective shaded or cooled recovery areas appropriate to the worksite and number of workers.',
          'Use ventilation, fans, air conditioning, evaporative cooling or other suitable engineering controls where practicable.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '15',
    title: 'Ventilation & Air Movement',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Improve air movement and ventilation where it reduces heat accumulation and does not introduce another hazard.',
          'For indoor hot processes, control the heat source and exhaust hot air or steam where practicable.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '16',
    title: 'Clothing & PPE',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Select clothing and PPE that provide required protection while minimizing unnecessary heat burden.',
          'Consider breathable or task-suitable clothing where compatible with the hazard. Do not remove mandatory PPE to manage heat without an approved alternative control.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '17',
    title: 'Workload & Physical Exertion',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Assess metabolic workload. Heavy lifting, manual handling, repetitive work and high-force tasks increase heat strain.',
          'Use mechanical aids, team lifting, task rotation and work redesign where practicable.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '18',
    title: 'Sun & Radiant Heat',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Control direct solar exposure using shade, scheduling, suitable clothing and recovery arrangements.',
          'Radiant heat from furnaces, hot equipment, concrete, asphalt or other surfaces must also be considered.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '19',
    title: 'Humidity & Poor Air Movement',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'High humidity reduces the body\'s ability to lose heat through sweat evaporation. Poor air movement can further reduce cooling.',
          'Increase monitoring and controls when humidity and heat combine to create significant heat strain.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '20',
    title: 'Indoor & Enclosed Hot Areas',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Identify workshops, plant rooms, kitchens, tanks, roofs, poorly ventilated areas and other locations where heat can accumulate.',
          'Provide ventilation, cooling, work-rest arrangements and monitoring appropriate to the assessed exposure.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '21',
    title: 'High-Risk Work & Individuals',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Consider strenuous work, high PPE burden, heat-sensitive tasks, remote locations and workers who may be at increased risk based on relevant occupational-health advice.',
          'Do not make assumptions about an individual\'s medical condition. Use occupational-health processes where individual assessment is required.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '22',
    title: 'Monitoring & Supervision',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Supervisors should monitor environmental conditions, work intensity, hydration access, rest arrangements and worker behavior or symptoms.',
          'Increase monitoring during extreme conditions, acclimatization and high-risk tasks.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '23',
    title: 'Buddy System & Communication',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Use buddy or team monitoring where appropriate so workers can recognize early signs of heat illness in themselves and others.',
          'Provide clear communication routes for requesting water, rest, medical help or stopping work.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '24',
    title: 'Emergency Preparedness',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'The site heat-emergency plan should define alarm/communication, first aid, cooling, medical escalation, transport, access for emergency services and responsibilities.',
          'Ensure emergency equipment and trained first-aid personnel are available as required by the site arrangements.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '25',
    title: 'First Aid & Immediate Response',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Move the affected person away from heat, stop exertion and begin appropriate cooling and first aid while arranging medical assistance according to the severity of symptoms.',
          'Do not allow an unwell worker to return to heat exposure until appropriately assessed and cleared under the site\'s medical process.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '26',
    title: 'RAMS / JSA / PTW Interface',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Heat controls must be incorporated into RAMS/JSA and task risk assessments where heat exposure exists.',
          'Where a permit is required, heat-related controls should be reflected in the permit conditions and pre-work verification.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '27',
    title: 'Site Facilities & Welfare',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Provide accessible drinking water, suitable sanitation and recovery facilities in accordance with applicable workplace welfare requirements.',
          'Locate facilities so workers can use them without excessive additional heat exposure.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '28',
    title: 'Weather & Work-Schedule Management',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Monitor reliable weather information and site conditions. Adjust scheduling, workload, manpower and controls when heat conditions increase.',
          'Do not rely on a calendar date alone; actual conditions and applicable regulatory requirements must be considered.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '29',
    title: 'Inspection & Verification',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Supervisors and HSE personnel should verify water availability, shade/cooling, signage, monitoring arrangements, emergency readiness and compliance with the heat-management plan.',
          'Record inspections and corrective actions according to the site system.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '30',
    title: 'Competency & Responsibilities',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Employers provide the heat-management system and resources. Supervisors implement and monitor controls. HSE verifies compliance and supports risk assessment. Workers follow controls, hydrate, use rest arrangements and report symptoms.',
          'Training should cover heat hazards, symptoms, prevention, reporting and emergency response.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '31',
    title: 'Stop-Work Conditions',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Stop or modify work when heat conditions exceed the approved control basis, cooling/rest arrangements are unavailable, water is unavailable, emergency arrangements fail, workers show heat-illness symptoms, or the risk assessment is no longer adequate.',
          'Restart only after effective controls are restored and the responsible authority confirms safe conditions.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '32',
    title: 'Unsafe Practices → Corrective Actions',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Unsafe practices include hiding symptoms, refusing recovery breaks, inadequate water access, working alone without required controls, removing mandatory PPE, ignoring weather warnings and continuing symptomatic workers.',
          'Stop the unsafe activity, correct the control failure, provide appropriate assistance and verify before restart.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '33',
    title: 'Toolbox Talk',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Explain heat hazards, symptoms, hydration, rest and recovery, acclimatization, clothing/PPE, buddy monitoring, reporting, emergency response and stop-work authority.',
          'Remind workers that early reporting can prevent serious heat illness.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '34',
    title: 'Field Checklist',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          '☐ Heat-risk assessment reviewed',
          '☐ Weather/conditions checked',
          '☐ Drinking water accessible',
          '☐ Shade/cooling available',
          '☐ Rest/recovery arrangements ready',
          '☐ Acclimatization controls applied where needed',
          '☐ Supervisors briefed',
          '☐ Workers trained',
          '☐ Emergency/first-aid arrangements ready',
          '☐ Heat symptoms understood',
          '☐ Buddy monitoring arranged where required',
          '☐ Workload and schedule controlled',
          '☐ PPE suitable for heat exposure',
          '☐ Records and inspections maintained',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '35',
    title: 'Quick Reference',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'IDENTIFY HEAT → ASSESS EXPOSURE → PLAN → HYDRATE → COOL/REST → MONITOR → REPORT SYMPTOMS → RESPOND EARLY → REVIEW.',
          'Never ignore heat-illness symptoms. Heat stroke is a medical emergency.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '36',
    title: 'UAE / Abu Dhabi / Dubai Applicability',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'The Abu Dhabi reference is ADOSH-SF CoP 11.0 — Safety in the Heat, listed by ADPHC as Version 4.0 effective 15 July 2024.',
          'Abu Dhabi requirements must be distinguished from Dubai or other emirate requirements. Client and sector requirements may add controls.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '37',
    title: 'Related CoPs & Cross References',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'CoP 2.0 Personal Protective Equipment.',
          'CoP 3.0 Occupational Noise and CoP 3.1 Vibration.',
          'CoP 4.0 First Aid and Medical Emergency Treatment.',
          'CoP 5.0 Occupational Health Screening and Medical Surveillance.',
          'CoP 8.0 General Workplace Amenities.',
          'CoP 14.0 Manual Handling and Ergonomics.',
          'CoP 15.0 Electrical Safety.',
          'CoP 21.0 Permit to Work Systems.',
          'CoP 23.0 Working at Heights.',
          'CoP 25.0 Driver Fatigue Prevention.',
          'CoP 27.0 Confined Spaces.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '38',
    title: 'Official Regulatory References',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Primary reference: Abu Dhabi Occupational Safety and Health Center (ADPHC), ADOSH-SF CoP 11.0 — Safety in the Heat, Version 4.0, effective 15 July 2024, as listed in the official CoP registry.',
          'Check the official ADPHC registry and current CoP document before relying on a legal or numerical requirement.',
        ],
      ),
    ],
  ),
];

// ===== SOURCE: abu_dhabi_confined_spaces_gold.dart =====
/// SafeNexus HSE — Abu Dhabi HSE Gold Standard
/// Topic: Confined Spaces
/// Regulatory basis: ADOSH-SF CoP 27.0, Version 4.0, July 2024.
///
/// Structured reference content. Site PTW, RAMS/JSA, isolation, atmospheric
/// testing, rescue, competency and current official requirements remain applicable.

class ConfinedSpaceGoldPoint {
  final String title;
  final List<String> points;

  const ConfinedSpaceGoldPoint({required this.title, required this.points});
}

class ConfinedSpaceGoldSection {
  final String number;
  final String title;
  final List<ConfinedSpaceGoldPoint> points;

  const ConfinedSpaceGoldSection({
    required this.number,
    required this.title,
    required this.points,
  });
}

const List<ConfinedSpaceGoldSection> confinedSpaceGoldStandardSections = [
  ConfinedSpaceGoldSection(
    number: '01',
    title: 'Definition & Purpose',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'A confined space is a space such as a tank, vessel, pipe, sewer, silo, storage bin, hopper, vault, pit, excavation, manhole or similar enclosed space where its enclosed nature creates a reasonably foreseeable specified risk.',
          'The purpose of confined-space control is to prevent fire or explosion, loss of consciousness from heat or hazardous atmosphere, asphyxiation, drowning, engulfment and other serious harm associated with restricted spaces.',
          'Confined-space work must be planned as a specialist high-risk activity and must not be treated as ordinary access work.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '02',
    title: 'Scope & Applications',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Applies to construction, maintenance, cleaning, inspection, entry, repair, shutdown and commissioning activities where a space meets the applicable confined-space definition.',
          'Examples include tanks, vessels, manholes, chambers, pits, ducts, sewers, pipelines, silos, hoppers and certain excavations.',
          'The classification must be based on the actual hazards and applicable ADOSH requirements, not only on the physical size or depth of the space.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '03',
    title: 'Identification & Classification',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Identify spaces during design, planning, worksite inspection and asset surveys. Mark or otherwise identify known confined spaces where required by the site system.',
          'Determine whether entry is required. Eliminate entry where the task can be completed from outside.',
          'Assess the space for atmospheric, engulfment, drowning, fire/explosion, heat, mechanical, electrical, biological, access/egress and other foreseeable hazards.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '04',
    title: 'Specified Risks',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Specified risks include serious injury from fire or explosion, loss of consciousness from increased body temperature, loss of consciousness or asphyxiation from gas, fume, vapour or lack of oxygen, drowning from rising liquid, and asphyxiation or inability to reach a respirable environment due to free-flowing solids or entrapment.',
          'Other task hazards must also be identified even when they are not the reason the space is classified as a confined space.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '05',
    title: 'Entry Decision & Elimination',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'First ask whether entry can be eliminated by remote inspection, external cleaning, tooling, cameras, extended tools or another method.',
          'If entry cannot be eliminated, minimize the number of entrants, duration and exposure.',
          'Do not enter simply because the space appears clean, ventilated or previously used safely.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '06',
    title: 'Risk Assessment & RAMS / JSA',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Prepare a task-specific risk assessment and approved safe system of work covering the space, task, hazards, controls, personnel, equipment, atmospheric testing, isolation, ventilation, communication, standby arrangements and rescue.',
          'Review the assessment when conditions, work sequence, equipment, substances, personnel or space configuration changes.',
          'RAMS/JSA and permit conditions must describe the same work scope and controls.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '07',
    title: 'Permit to Work & Authorization',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Confined-space entry must be controlled by the applicable PTW system and a dedicated entry permit where required by the entity procedure.',
          'Permit authorization must verify the defined space, scope, hazards, isolations, atmospheric controls, competent personnel, standby arrangements, communications and rescue arrangements.',
          'Do not start entry before all required authorizations and preconditions are complete.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '08',
    title: 'Competency & Roles',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Only trained, competent and authorized personnel should enter, supervise, test atmospheres, issue or receive permits, isolate systems or perform rescue duties within their assigned roles.',
          'Roles should be clearly defined for the entry supervisor or responsible person, permit issuer, entry team, standby person, gas tester, isolation authority and rescue personnel as applicable.',
          'Competence must include recognition of hazards, equipment use, communication, emergency response and the limits of the person\'s role.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '09',
    title: 'Isolation & Zero-Energy Verification',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Identify and isolate all hazardous energy and process sources that could affect the space: electrical, mechanical, hydraulic, pneumatic, pressure, thermal, chemical and process energy.',
          'Prevent entry of gases, liquids, steam, chemicals, materials or other substances into the space.',
          'Use the approved lockout/tagout and isolation procedure. Verify isolation using the site\'s approved method rather than relying only on a tag or assumption.',
          'Where required, drain, depressurize, purge, blank, disconnect or otherwise positively isolate the system.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '10',
    title: 'Atmospheric Hazards',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Atmospheric hazards may include oxygen deficiency or enrichment, flammable gases or vapours, toxic gases, fumes, vapours, dusts and contaminants generated by the work or released from connected systems.',
          'Consider both the atmosphere present before entry and changes that can occur during the work.',
          'Atmospheric hazards must be assessed before entry and controlled continuously or periodically as required by the risk assessment and permit.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '11',
    title: 'Gas Testing & Monitoring',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Use a suitable, calibrated and maintained gas detector operated by a competent person.',
          'Test the atmosphere before entry and at locations representative of the space, including areas where gases may accumulate.',
          'Where conditions can change, provide continuous or periodic monitoring according to the risk assessment and permit.',
          'Record required readings and respond immediately to alarms or unacceptable conditions.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '12',
    title: 'Oxygen, Flammable & Toxic Atmospheres',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Verify that oxygen concentration is within the safe range specified by the applicable procedure and permit.',
          'Verify that flammable atmosphere remains within the approved safe criteria for the work.',
          'Identify toxic contaminants relevant to the process, previous contents, cleaning agents and work activity, and apply applicable exposure limits and controls.',
          'Never use smell as an atmospheric test.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '13',
    title: 'Ventilation & Purging',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Provide effective ventilation where needed to maintain a safe atmosphere and remove contaminants.',
          'Select the ventilation method according to the hazard; do not introduce a new hazard by using an unsuitable gas or ventilation arrangement.',
          'Where purging is used, ensure the purge method, medium, discharge path and re-entry criteria are defined by the approved procedure.',
          'Do not use oxygen as a substitute for normal ventilation.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '14',
    title: 'Continuous Atmospheric Change',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Atmospheric conditions can change because of welding, cutting, solvents, cleaning chemicals, biological decomposition, leakage, nearby processes, ventilation failure or disturbance of deposits.',
          'Define alarm actions, withdrawal criteria and retesting requirements before work starts.',
          'Stop entry if monitoring becomes unavailable or conditions cannot be confirmed safe.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '15',
    title: 'Access & Egress',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Provide safe access and a reliable means of escape suitable for the space, task and emergency conditions.',
          'Keep access and egress routes clear of tools, hoses, cables and other obstructions.',
          'Where ladders, tripods, winches or other access systems are used, inspect and use them according to the approved method and manufacturer requirements.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '16',
    title: 'Communication & Standby Person',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Provide reliable communication between entrants and the standby person or responsible supervisor.',
          'The standby person must understand the permit, hazards, alarm signals, entry status and emergency procedure.',
          'The standby person must not leave the assigned post or become distracted by unrelated work while entrants remain dependent on the standby arrangement.',
          'The standby person must not enter for an improvised rescue unless specifically trained, equipped and authorized under the rescue plan.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '17',
    title: 'Rescue & Emergency Planning',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Every entry must have a realistic rescue plan based on the actual space and foreseeable emergencies.',
          'Rescue arrangements must identify trained rescuers, equipment, access, retrieval, communication, medical response and emergency contacts.',
          'Do not rely solely on external emergency services when the time required for rescue could create an unacceptable risk.',
          'Practice or verify the rescue arrangement where required so that equipment and access are known to work.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '18',
    title: 'Retrieval & Rescue Equipment',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Select retrieval equipment according to the space and task, which may include harnesses, lifelines, tripods, davit systems, winches, retrieval devices, breathing equipment and other rescue equipment.',
          'Equipment must be compatible, inspected, maintained and positioned so it can be used without creating additional hazards.',
          'Do not assume a standard harness or lifeline is suitable for every entry or rescue configuration.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '19',
    title: 'Respiratory Protection & Breathing Apparatus',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Use respiratory protective equipment only when selected through the hazard assessment and respiratory-protection program.',
          'Where atmosphere cannot be maintained within safe limits, entry may need to be prohibited or specialized breathing apparatus and specialist controls may be required.',
          'Respiratory protection does not remove the need for isolation, ventilation, atmospheric monitoring and rescue planning.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '20',
    title: 'Fire, Explosion & Hot Work',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Identify flammable gases, vapours, residues, dusts and oxygen-enrichment hazards before any ignition source enters the space.',
          'Hot work inside or near a confined space requires additional controls, atmospheric testing, ventilation, fire protection and the applicable hot-work permit.',
          'Control cylinders, hoses, electrical equipment, ignition sources and combustible materials according to the approved procedure.',
          'Stop work if atmospheric conditions become unsafe.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '21',
    title: 'Heat, Humidity & Thermal Stress',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Assess heat generated by the environment, process, PPE, physical workload and restricted ventilation.',
          'Provide cooling, hydration, work-rest controls and monitoring appropriate to the heat risk.',
          'Heat-related symptoms require immediate action; do not allow an affected worker to continue simply because the permit remains valid.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '22',
    title: 'Engulfment, Drowning & Material Ingress',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Prevent unexpected entry of liquids, gases, steam, powders, grains, aggregates and other free-flowing materials.',
          'Isolate valves, lines, conveyors, chutes and other sources of material movement.',
          'Where liquid level can rise, establish effective isolation and emergency arrangements before entry.',
          'Never rely on another person simply holding a valve closed without verified isolation.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '23',
    title: 'Mechanical, Electrical & Process Hazards',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Isolate agitators, mixers, conveyors, pumps, fans, valves, moving machinery and other equipment that can start or move.',
          'Control electrical hazards using the applicable electrical safety and isolation procedure.',
          'Consider stored pressure, springs, gravity, rotating parts, heat, chemicals and process residues.',
          'Verify the safe state before entry and after any change to the system.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '24',
    title: 'Lighting, Tools & Equipment',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Use suitable lighting and equipment for the environment and task.',
          'Electrical equipment must be suitable for the hazardous conditions identified by the assessment; use appropriate low-voltage, intrinsically safe or other specified equipment where required.',
          'Control cables, hoses and tools so they do not obstruct escape or create additional hazards.',
          'Inspect equipment before use and remove defective equipment from service.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '25',
    title: 'PPE & Personal Equipment',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Select PPE based on the risk assessment, including head, eye, hand, foot, hearing, respiratory and chemical protection as applicable.',
          'Fall protection or retrieval equipment may be required where the entry configuration creates a fall or rescue hazard.',
          'PPE must be compatible with other equipment and must not interfere with emergency escape or communication.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '26',
    title: 'Simultaneous Operations & Interfaces',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Control welding, grinding, cleaning, painting, electrical work, lifting, excavation, traffic, nearby process operations and other activities that can affect the space.',
          'Coordinate permits and isolate conflicting work.',
          'Prevent unauthorized access to the entry area and protect the space from falling objects or vehicle impact.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '27',
    title: 'Safe Entry Procedure',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Confirm entry is necessary, review RAMS/JSA and permit, verify isolation, prepare access, establish communication and rescue arrangements, test the atmosphere and brief all personnel.',
          'Enter only after the responsible authorization is complete and required controls are confirmed.',
          'Maintain monitoring, communication, ventilation, supervision and boundary controls throughout the work.',
          'Exit immediately when alarm, unsafe condition, communication failure, loss of ventilation, changed conditions or other withdrawal criteria occur.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '28',
    title: 'Inspection, Examination & Records',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Inspect gas detectors, ventilation equipment, retrieval systems, harnesses, ladders, lighting, communication equipment and other entry equipment before use.',
          'Maintain required calibration, inspection, maintenance, training, permit, gas-test and rescue records.',
          'Review incidents, near misses, alarms and abnormal readings and update controls where required.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '29',
    title: 'Medical & Occupational Health Considerations',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Use the entity\'s occupational-health and medical-fitness processes for workers whose assigned duties require them.',
          'Do not make informal medical judgments in the field. Refer individual health concerns through the approved occupational-health process.',
          'Emergency medical response must be available for foreseeable outcomes of the task.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '30',
    title: 'Supervisor / HSE Responsibilities',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Verify the permit, RAMS, isolation, atmospheric testing, ventilation, access, communication, standby and rescue arrangements.',
          'Monitor field compliance and stop work when conditions no longer match the approved controls.',
          'Ensure lessons from incidents, alarms, failed controls and near misses are communicated and corrective actions are tracked.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '31',
    title: 'Stop-Work Conditions',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Stop entry for unsafe atmospheric readings, gas-detector failure, loss of ventilation, loss of communication, loss of isolation, unexpected inflow, rising liquid, material movement, fire or explosion risk, worker symptoms, rescue-system failure, severe weather affecting the task or any condition outside the approved risk assessment.',
          'Evacuate when required and do not re-enter until the hazard is controlled, the atmosphere and isolations are reverified and the permit is revalidated or reissued.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '32',
    title: 'Unsafe Practices → Corrective Actions',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Unsafe practices include entering without authorization, testing only once when conditions can change, relying on smell, bypassing isolation, working without a standby arrangement, improvised rescue, entering after an alarm, using unverified equipment or allowing conflicting work.',
          'Stop work, evacuate if necessary, make the area safe, notify the responsible authority, correct the failed control and verify the complete entry system before restart.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '33',
    title: 'Toolbox Talk',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Explain the space, hazards, permit boundaries, isolation points, atmospheric limits, testing locations, ventilation, communication, standby role, escape route, rescue plan, PPE, prohibited activities and stop-work signals.',
          'Every entrant should know how to recognize an alarm and how to leave the space immediately.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '34',
    title: 'Field Checklist',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          '☐ Entry is necessary and alternatives considered',
          '☐ Confined space identified and assessed',
          '☐ Approved RAMS/JSA available',
          '☐ Correct entry permit authorized',
          '☐ All hazardous energy and process sources isolated',
          '☐ Isolation verified',
          '☐ Atmosphere tested before entry',
          '☐ Required monitoring operating',
          '☐ Ventilation effective',
          '☐ Safe access and egress provided',
          '☐ Standby person assigned',
          '☐ Communication tested',
          '☐ Rescue plan and equipment ready',
          '☐ Competent personnel confirmed',
          '☐ PPE and respiratory controls suitable',
          '☐ Conflicting activities controlled',
          '☐ Emergency arrangements communicated',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '35',
    title: 'Quick Reference',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'PLAN → ELIMINATE ENTRY → ISOLATE → VERIFY → TEST → VENTILATE → AUTHORIZE → ENTER → MONITOR → COMMUNICATE → EXIT → CLOSE.',
          'Never enter an unknown atmosphere.',
          'Never rely on smell to confirm safety.',
          'Never improvise a rescue.',
          'Never continue after an alarm or loss of a critical control.',
          'Permit validity does not override an unsafe condition.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '36',
    title: 'UAE / Abu Dhabi / Dubai Applicability',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'This module is specifically aligned to Abu Dhabi ADOSH-SF CoP 27.0 — Confined Spaces, Version 4.0, July 2024.',
          'ADPHC\'s official technical guideline Safe Work in Confined Spaces is supplementary guidance and states that its content is not mandatory, while helping entities comply with CoP 27.0.',
          'Dubai and other emirates may have different requirements. Client, operator, facility and sector procedures may add controls.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '37',
    title: 'Related CoPs & Cross References',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'CoP 2.0 Personal Protective Equipment.',
          'CoP 4.0 First Aid and Medical Emergency Treatment.',
          'CoP 11.0 Safety in the Heat.',
          'CoP 15.0 Electrical Safety.',
          'CoP 21.0 Permit to Work Systems.',
          'CoP 23.0 Working at Heights.',
          'CoP 24.0 Lock-out/Tag-out and Isolation.',
          'CoP 28.0 Hot Work Operations.',
          'CoP 29.0 Excavation Work.',
          'CoP 34.0 Lifting Equipment and Lifting Accessories.',
          'CoP 35.0 Portable Power Tools.',
          'CoP 39.0 Overhead and Underground Services.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '38',
    title: 'Official Regulatory References',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Primary source: Abu Dhabi Occupational Safety and Health Center (ADPHC), ADOSH-SF CoP 27.0 — Confined Spaces, Version 4.0, July 2024.',
          'Supplementary official guidance: ADOSH-SF Technical Guideline — Safe Work in Confined Spaces, Version 4.0, 15 July 2024.',
          'Check the official ADPHC registry and current document before relying on any legal, numerical, atmospheric or procedural requirement.',
        ],
      ),
    ],
  ),
];

// ===== SOURCE: abu_dhabi_worker_welfare_gold.dart =====

class WorkerWelfareGoldPoint {
  final String title;
  final String content;

  const WorkerWelfareGoldPoint({
    required this.title,
    required this.content,
  });
}

class WorkerWelfareGoldSection {
  final String title;
  final List<WorkerWelfareGoldPoint> points;

  const WorkerWelfareGoldSection({
    required this.title,
    required this.points,
  });
}

const List<WorkerWelfareGoldSection> workerWelfareGoldStandardSections = [
  WorkerWelfareGoldSection(
    title: '01. Purpose and Scope',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Worker welfare means providing safe, healthy, hygienic and suitable workplace facilities and arrangements that support worker health, dignity and safe performance. Welfare planning shall cover the workplace and, where applicable, employer-supplied accommodation, transport, food and related services. Requirements shall be matched to the work activity, workforce size, location, environmental conditions and applicable Abu Dhabi requirements.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '02. Welfare Planning',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Welfare requirements shall be identified during project planning and incorporated into the OSH management system, site layout and mobilization plan. Consider workforce numbers, gender, shifts, remote areas, hot-weather exposure, accessibility, emergency access, cleaning arrangements, water supply, sanitation, accommodation interfaces and contractor responsibilities before work starts.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '03. Drinking Water',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Provide a reliable supply of suitable potable drinking water in accessible locations. Protect water from contamination, maintain clean dispensers and containers, provide hygienic drinking arrangements and monitor availability throughout the shift. Water provision shall be increased or relocated when work conditions, workforce distribution or heat exposure require it.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '04. Water Hygiene',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Drinking-water containers, coolers, dispensers and associated equipment shall be clean, protected and maintained. Do not permit practices that can contaminate shared drinking facilities. Any suspected contamination, damaged container or unsafe supply shall be isolated and corrected promptly.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '05. Toilets and Sanitary Conveniences',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Provide suitable sanitary conveniences that are accessible, hygienic, adequately maintained and appropriate for the workforce and work location. Toilets shall be kept clean, supplied, serviced and positioned so workers can use them without unnecessary exposure to traffic, hazards or excessive travel distance.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '06. Washing Facilities',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Provide suitable washing facilities where work creates a need for personal cleaning. Facilities shall have an adequate supply of suitable water and hygiene supplies as applicable to the work. Increase cleaning and servicing where contamination, chemicals, dust, oils or other occupational exposures make this necessary.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '07. Rest Areas',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Provide suitable rest facilities protected from workplace hazards and environmental conditions. Rest areas shall be kept clean and maintained, with sufficient seating and arrangements appropriate to the workforce and work pattern. Rest facilities shall not be used for storage of hazardous materials or equipment.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '08. Heat and Weather Protection',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Welfare arrangements shall support the controls required for hot, humid, dusty, rainy or otherwise severe weather. Provide suitable shaded or cooled recovery areas and drinking-water arrangements as required by the applicable heat-management controls. Coordinate welfare planning with ADOSH-SF Safety in the Heat requirements and the site heat-stress risk assessment.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '09. Changing and Drying Facilities',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Where the work requires workers to change clothing or remove contaminated or wet workwear, provide suitable arrangements that maintain hygiene, privacy and separation from clean clothing and food areas. Facilities shall be maintained so contaminated clothing does not create secondary exposure.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '10. Eating and Meal Areas',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Designate clean eating areas separated from hazardous work, chemicals, waste, dust-generating activities and contaminated equipment. Maintain tables, seating, cleaning arrangements and waste controls. Food shall not be stored or consumed in areas where contamination from work activities can occur.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '11. Food Hygiene Interface',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Where food is prepared, handled or served as part of the workplace arrangement, coordinate welfare controls with applicable occupational food-handling requirements. Food preparation areas shall be hygienic, suitably maintained and protected from contamination. Food-service contractors shall have defined responsibilities and monitoring arrangements.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '12. Accommodation Interface',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Where accommodation is supplied or controlled by the employer, welfare planning shall interface with the applicable Abu Dhabi accommodation requirements. Workplace welfare controls do not replace accommodation-specific requirements. Responsibilities for accommodation management, hygiene, maintenance, emergency arrangements and reporting shall be clearly assigned.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '13. Temporary Accommodation',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Temporary employer-supplied accommodation shall be planned, operated and maintained in accordance with the applicable Abu Dhabi requirements. Consider fire safety, sanitation, potable water, ventilation, cleanliness, emergency access, electrical safety, waste control, occupancy management and maintenance. Licensing and authority requirements shall also be considered.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '14. Ventilation and Indoor Conditions',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Welfare and occupied areas shall have suitable ventilation and indoor environmental conditions. HVAC and ventilation systems shall be maintained and kept free from conditions that could create health risks. Do not allow welfare spaces to become excessively hot, poorly ventilated, contaminated or overcrowded.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '15. Lighting',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Provide suitable lighting for welfare areas, access routes, toilets, washing facilities, eating areas and other occupied spaces. Lighting shall support safe movement, cleaning, inspection and emergency response. Defective lighting shall be reported and corrected.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '16. Housekeeping',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Welfare areas shall be maintained clean, orderly and free from unnecessary obstructions. Cleaning schedules shall be documented where appropriate. Spillages, food waste, standing water, damaged fixtures, blocked access and unhygienic conditions shall be corrected promptly.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '17. Waste Management',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Provide suitable waste containers near welfare and eating areas. Waste shall be removed at an appropriate frequency to prevent accumulation, odour, pests and hygiene problems. Waste segregation shall follow the site waste-management plan and applicable requirements.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '18. Pest and Vector Control',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Prevent conditions that attract insects, rodents and other pests. Control food waste, standing water, damaged waste containers and poor housekeeping. Where pest-control treatments are required, use competent service providers and manage chemicals so workers are not exposed unnecessarily.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '19. First Aid and Medical Access',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Welfare planning shall interface with the site first-aid and medical emergency arrangements. Workers shall know how to obtain assistance, where first-aid resources are located and how emergencies are communicated. Access routes for emergency response shall remain clear.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '20. Worker Transportation',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Where the employer provides transportation, vehicles and transport arrangements shall be suitable for the intended journey and workforce. Vehicle safety, driver competence, passenger management, seat-belt use, loading restrictions, maintenance, emergency arrangements and fatigue controls shall be addressed under the applicable requirements.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '21. Welfare Access and Location',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Locate welfare facilities so workers can access them safely without crossing unnecessary traffic routes, lifting zones, excavation edges, hazardous-energy areas or other restricted zones. Provide safe pedestrian access and keep routes unobstructed.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '22. Accessibility and Special Needs',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Consider workers with disabilities, temporary limitations or other special access requirements when planning welfare facilities. Access routes, sanitary facilities, seating, emergency arrangements and communication methods shall be suitable for the workforce and applicable requirements.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '23. Privacy and Dignity',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Welfare facilities shall protect privacy and dignity. Toilets, washing, changing and accommodation arrangements shall be designed and managed so workers can use them safely and respectfully. Where the workforce requires separate facilities, the site shall provide suitable arrangements.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '24. Contractor and Subcontractor Welfare',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Principal contractors and employers shall define welfare responsibilities for contractors and subcontractors. Site induction, welfare access, facility servicing, complaints, inspections, accommodation interfaces and corrective actions shall be coordinated so every worker receives the applicable welfare protections.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '25. Worker Information and Communication',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Workers shall be informed about welfare facilities, locations, permitted use, hygiene expectations, emergency arrangements and how to report shortages or unsafe conditions. Information shall be communicated in a form workers can understand.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '26. Worker Complaints and Reporting',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Provide a practical method for workers to report missing water, sanitation problems, excessive heat, poor hygiene, overcrowding, damaged facilities or other welfare concerns. Reports shall be recorded where required, investigated and closed with corrective action. Workers should not be discouraged from raising genuine welfare concerns.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '27. Welfare Inspection and Monitoring',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Inspect welfare facilities at a frequency appropriate to workforce size, usage, risk and environmental conditions. Check water availability, sanitation, cleanliness, supplies, temperature or ventilation where relevant, waste, pest control, access, lighting, damage and emergency access. Record findings and track corrective actions.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '28. Competency and Responsibilities',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Assign clear responsibilities for welfare planning, facility provision, cleaning, servicing, inspection, maintenance and corrective actions. Supervisors shall monitor day-to-day conditions. HSE personnel shall verify compliance and escalate deficiencies. Contractors shall meet their assigned welfare obligations.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '29. RAMS, Risk Assessment and Welfare',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Welfare needs shall be considered during risk assessment and method planning, particularly for remote work, large workforces, night shifts, hot-weather activities, contaminated work, work at isolated locations and activities requiring special hygiene arrangements. Welfare controls shall be reviewed when conditions change.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '30. Emergency Welfare Arrangements',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Emergency planning shall consider loss of potable water, failure of sanitation, severe weather, fire, medical events, accommodation emergencies, utility failure and evacuation. Emergency routes and assembly areas shall remain usable, and welfare facilities shall not obstruct emergency response.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '31. Stop-Work and Escalation Conditions',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Escalate immediately where welfare deficiencies create a significant health or safety risk. Examples include unavailable potable drinking water during heat exposure, severely unhygienic sanitary facilities, unsafe accommodation conditions, blocked emergency access, serious electrical or fire hazards in welfare areas, contaminated water or conditions that make the facility unsafe to use. Correct the deficiency before affected work or occupancy continues where required by the risk.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '32. Unsafe Practices and Corrective Actions',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Unsafe practices include drinking non-potable water, storing chemicals in eating areas, using welfare rooms as material stores, ignoring sanitation failures, allowing waste accumulation, blocking welfare access, bypassing cleaning schedules, overcrowding facilities or failing to report serious welfare deficiencies. Corrective actions shall address the immediate condition and the underlying cause.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '33. Toolbox Talk Points',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Explain welfare locations, drinking-water arrangements, toilet and washing facilities, rest areas, eating rules, heat recovery arrangements, hygiene, waste disposal, emergency contacts and reporting channels. Reinforce that welfare facilities are part of the site safety system and that workers should report deficiencies promptly.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '34. Field Checklist',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Verify: potable drinking water available; dispensers clean; toilets accessible and hygienic; washing facilities functional; rest areas suitable; heat protection available; eating areas clean; waste controlled; pest issues controlled; lighting adequate; ventilation suitable; access routes clear; first-aid access maintained; transport arrangements controlled; contractor welfare responsibilities understood; inspections recorded; corrective actions closed.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '35. Quick Reference',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'FIELD RULE: PLAN welfare before mobilization. PROVIDE suitable facilities. KEEP them clean and serviceable. MONITOR water, sanitation, heat protection and hygiene. INFORM workers. REPORT deficiencies. CORRECT promptly. VERIFY during inspections. Welfare is an OSH control, not an optional site convenience.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '36. UAE and Abu Dhabi Applicability',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'For Abu Dhabi projects, welfare controls shall be aligned with the applicable ADOSH-SF requirements and the requirements of the relevant sector and authority. The official ADPHC Code of Practices registry lists CoP 8.0 General Workplace Amenities, CoP 18.0 Employer Supplied Accommodation - General Requirements, CoP 18.1 Temporary Employer Supplied Accommodation, CoP 11.0 Safety in the Heat, CoP 4.0 First Aid and Medical Emergency Treatment, CoP 16.0 OSH Requirements for People with Special Needs and CoP 19.0 Occupational Food Handling and Food Preparation Areas. Apply the requirement that is relevant to the actual activity and facility.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '37. Related CoPs and Cross References',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Cross-reference welfare controls with CoP 8.0 General Workplace Amenities; CoP 11.0 Safety in the Heat; CoP 16.0 OSH Requirements for People with Special Needs; CoP 18.0 Employer Supplied Accommodation - General Requirements; CoP 18.1 Temporary Employer Supplied Accommodation; CoP 19.0 Occupational Food Handling and Food Preparation Areas; CoP 4.0 First Aid and Medical Emergency Treatment; and CoP 54.0 Waste Management, as applicable.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '38. Official Regulatory References',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Primary official reference: Abu Dhabi Public Health Centre (ADPHC), Abu Dhabi Occupational Safety and Health System Framework (ADOSH-SF), Code of Practices registry. Current registry information identifies CoP 8.0 General Workplace Amenities, Version 4.0 effective 15 July 2024; CoP 18.0 Employer Supplied Accommodation - General Requirements, Version 4.0 effective 15 July 2024; and CoP 18.1 Temporary Employer Supplied Accommodation, Version 4.0 effective 15 July 2024. Always verify the official ADPHC registry and applicable authority requirements before relying on legal or numerical requirements in the field.',
      ),
    ],
  ),
];

// ===== SOURCE: abu_dhabi_steps_5N_to_5Q_book_gold.dart =====
// SafeNexus HSE — Abu Dhabi HSE Reference
// Detailed Gold Standard: Steps 5N–5Q
// Pure data file: no Flutter import required.

class AbuDhabiFiveNQPoint {
  final String title;
  final String content;
  const AbuDhabiFiveNQPoint({required this.title, required this.content});
}

class AbuDhabiFiveNQSection {
  final String number;
  final String title;
  final String category;
  final List<AbuDhabiFiveNQPoint> points;
  const AbuDhabiFiveNQSection({
    required this.number,
    required this.title,
    required this.category,
    required this.points,
  });
}

const List<AbuDhabiFiveNQSection> abuDhabiFiveNQGoldStandardSections = [
  AbuDhabiFiveNQSection(
    number: '01',
    title: 'Definition & Purpose',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Electrical safety covers generation, distribution, temporary supplies, fixed installations, portable tools, batteries, generators and electrical work. The objective is to prevent shock, burns, arc-flash injury, fire, explosion, equipment damage and unintended energisation.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '02',
    title: 'Electrical Hazards',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Typical hazards include exposed live conductors, damaged insulation, defective plugs, poor earthing, overload, short circuit, wet conditions, temporary wiring, stored energy, overhead lines, underground services and unauthorised modifications.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '03',
    title: 'Hazard Identification',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Walk the work area before starting. Identify every source, distribution point, cable route, portable tool, generator, service and possible contact point. Treat unidentified conductors or services as potentially hazardous until verified.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '04',
    title: 'Risk Assessment',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Assess voltage, available energy, task, exposure, environment, equipment condition, access, competence and simultaneous activities. Define isolation, barriers, protective devices, safe distances, PPE and emergency arrangements.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '05',
    title: 'Hierarchy of Controls',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Eliminate the electrical task where possible. Prefer de-energisation and isolation. Then use engineering controls such as guarding, enclosure, interlocks and protective devices, followed by procedures, training and PPE.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '06',
    title: 'Competency & Authorisation',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Electrical installation, testing, fault finding and repair shall be performed by appropriately competent and authorised persons. Define the person\'s limits of work and supervision requirements.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '07',
    title: 'Isolation & LOTO',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Identify every energy source, isolate, lock, tag, release stored energy and verify zero energy before work. Prevent remote, automatic, alternative or back-feed energisation. Restoration shall be controlled.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '08',
    title: 'Proving Dead',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Never assume a circuit is dead because a switch is open. Use suitable test equipment and a safe test method. Verify the tester as required by the procedure before and after proving absence of voltage.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '09',
    title: 'Live Work',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Avoid live work wherever reasonably practicable. If permitted by the applicable safe system, use a specific risk assessment, authorisation, competent personnel, boundaries, insulated equipment and appropriate PPE.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '10',
    title: 'Distribution Boards',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Boards shall be suitable, enclosed, protected against damage, identified and accessible to authorised persons. Covers and protective devices must remain intact. Do not store material in front of boards.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '11',
    title: 'RCD / RCBO Protection',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Use residual-current protection where required by the electrical design, applicable requirements and risk assessment. Test protective devices at the required interval. Never bypass, bridge or defeat a protective device.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '12',
    title: 'Earthing & Bonding',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Provide effective protective earthing and bonding appropriate to the system. Keep protective conductors continuous and identifiable. Inspect connections and investigate damaged or corroded earth paths.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '13',
    title: 'Cables & Extension Leads',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Select cables for load, environment and duty. Protect from crushing, abrasion, sharp edges, heat, water and traffic. Remove cables with exposed conductors or unsafe damage from service.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '14',
    title: 'Plugs & Sockets',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Use compatible approved plugs, sockets and connectors. Prevent overloading and unsafe adaptor chains. Keep connections protected from water and mechanical damage.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '15',
    title: 'Portable Power Tools',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Inspect body, guards, switch, cable, plug, earth or double-insulation features and protective devices before use. Follow manufacturer instructions and applicable portable-tool controls.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '16',
    title: 'Battery Tools',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Inspect battery casing, terminals, charger, leads and connectors. Prevent short circuits, impact, overheating and unauthorised modification. Charge only with suitable equipment in an appropriate location.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '17',
    title: 'Generators',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Control earthing, distribution, back-feed, fuel, exhaust, ventilation, cables, fire risk and weather. Never connect a generator to another supply unless the system is specifically designed and controlled for it.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '18',
    title: 'Temporary Electrical Installation',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Temporary systems shall be designed, installed, inspected and maintained by competent persons. Protect cables, boards, outlets and equipment from construction damage and unauthorised alteration.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '19',
    title: 'Wet Areas',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Use suitable equipment and protective measures for wet or conductive environments. Keep connections out of water and control wet hands, conductive surfaces and damaged insulation.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '20',
    title: 'Overhead Services',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Identify overhead electrical lines before crane, MEWP, scaffolding, lifting or other work. Establish authority/utility controls and physical exclusion arrangements before work.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '21',
    title: 'Underground Services',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Obtain current service information, survey and locate services before excavation. Use approved detection and safe-digging controls. Stop when service location is uncertain or an unexpected service is found.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '22',
    title: 'Cable Routing',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Route cables away from vehicle wheels, sharp edges, hot surfaces and water. Use suitable ramps, cable bridges or elevated routes where needed. Never create an avoidable trip hazard.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '23',
    title: 'Overload & Short Circuit',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Use conductors and protective devices appropriate to the intended load. Watch for overheating, repeated tripping, burning smell, discolouration, buzzing or arcing and remove unsafe equipment.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '24',
    title: 'Fire Prevention',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Control combustible storage around electrical equipment. Maintain suitable firefighting arrangements and emergency isolation. Never use water on an electrical fire unless the electrical source and fire procedure specifically permit it.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '25',
    title: 'Inspection & Testing',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Establish inspection, testing and maintenance schedules based on equipment, installation and risk. Record defects and repairs. Equipment failing a safety inspection shall be isolated until corrected.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '26',
    title: 'Maintenance',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Isolate before maintenance, release stored energy, prevent unexpected movement and verify safe condition. Replace damaged components with suitable approved parts; do not improvise repairs.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '27',
    title: 'Electrical Work Procedure',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Plan → identify source → isolate → lock/tag → prove dead → establish work zone → perform work → inspect → remove tools/personnel → restore under authorisation → document.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '28',
    title: 'PPE',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Select PPE from the electrical risk assessment. Depending on the hazard this may include eye/face protection, suitable gloves, footwear, protective clothing and arc-rated equipment. PPE does not replace isolation.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '29',
    title: 'Electric Shock Emergency',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Do not touch a person in contact with an electrical source until the source is safely isolated. Raise alarm, isolate if safe, call emergency assistance and provide trained first aid/CPR/AED as appropriate.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '30',
    title: 'Arc Flash',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Control arc-flash exposure by de-energisation, suitable equipment selection, boundaries, maintenance, protective devices and task-specific PPE. Do not approach damaged equipment producing smoke, sound or arcing.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '31',
    title: 'Supervisor Duties',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Verify competent persons, approved methods, equipment condition, isolation, inspections, barriers and emergency arrangements. Stop unsafe work and ensure corrective actions are closed.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '32',
    title: 'Stop Work',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Stop for exposed live parts, failed isolation, defective protective devices, damaged cables, uncontrolled water exposure, unknown services, overheating, smoke, arcing or unauthorised modification.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '33',
    title: 'Unsafe Practices',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Examples: bypassing RCDs, taped cable repairs, makeshift joints, open DBs, overloaded sockets, live work without authorisation, domestic equipment in unsuitable environments and cables across traffic routes.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '34',
    title: 'Corrective Action',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Make safe immediately, isolate affected equipment, identify root cause, repair or replace through competent personnel, inspect/test and formally return to service.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '35',
    title: 'Toolbox Talk',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Cover electrical sources, isolation, damaged equipment, cable routing, RCDs, generators, temporary boards, overhead/underground services, wet conditions, emergency isolation and stop-work authority.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '36',
    title: 'Field Checklist',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Check source identification; DB condition; covers; protective devices; earthing; RCD; cables; plugs; tools; generator; temporary wiring; service locations; barriers; signage; housekeeping; emergency access; records.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '37',
    title: 'Field Example',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'A grinder has a damaged cable near a wet work area. Stop use, isolate it, tag it defective, remove it from the work area, replace/repair through a competent person, inspect/test and only then return it to service.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '38',
    title: 'Regulatory Basis',
    category: '5N — Electricity on Site & Electrical Tools',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Abu Dhabi primary reference: ADOSH-SF CoP 15.0 Electrical Safety, V4.0 effective 15 July 2024. Related references include CoP 24.0 Lock-out Tag-out V4.1, CoP 35.0 Portable Power Tools V4.1 and CoP 39.0 Overhead and Underground Services V4.1. Verify the official registry before relying on legal or numerical requirements.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '01',
    title: 'Definition & Purpose',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Temporary works are temporary structures, supports, arrangements and installations required to enable construction, access, protection, stability or temporary occupation. Failure can cause collapse, falls, struck-by incidents and property damage.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '02',
    title: 'Examples',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Examples include temporary platforms, access structures, shoring, temporary supports, temporary buildings, barriers, ramps, temporary stairs, falsework interfaces and other temporary structural arrangements.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '03',
    title: 'Planning',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Identify temporary works during project planning, define the intended function and establish design, checking, approval, erection, inspection, modification and dismantling responsibilities.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '04',
    title: 'Design Basis',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Consider dead load, imposed load, equipment loads, wind, impact, vibration, construction sequence, environmental conditions, foundation capacity and foreseeable misuse.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '05',
    title: 'Competent Design',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Design and checking shall be performed by persons with appropriate competence and authority. Use approved design information and do not rely on visual similarity to previously used structures.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '06',
    title: 'Ground & Foundation',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Verify bearing capacity, level, settlement, drainage and underground hazards. Prevent undermining by excavation, water, vibration or nearby plant.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '07',
    title: 'Stability',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Provide adequate bracing, ties, anchors, foundations and connections. Assess overturning, sliding, buckling and progressive collapse.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '08',
    title: 'Loads',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Identify maximum intended loads and clearly control them. Do not add equipment, materials, stored water or people beyond the approved design.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '09',
    title: 'Construction Sequence',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Temporary works must remain stable at every stage, not only after completion. Assess partial erection, removal of braces, loading sequence and temporary conditions.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '10',
    title: 'Access Platforms',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Platforms require suitable decking, edge protection, access, load control and inspection. Do not create gaps, trip hazards or improvised extensions.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '11',
    title: 'Temporary Stairs & Ramps',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Provide stable surfaces, suitable access, handrails/edge protection where required and safe gradient/transition arrangements according to design and applicable requirements.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '12',
    title: 'Temporary Supports',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Identify what the support carries, verify load path and prevent accidental removal. Never remove props, shores, ties or braces without authorised sequence.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '13',
    title: 'Temporary Structures Near Excavation',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Assess interaction between structures and excavation edges. Prevent surcharge loading, undermining and vibration from plant.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '14',
    title: 'Weather',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Assess wind, rain, flooding, heat and other environmental effects. Reinspect after events that may affect stability.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '15',
    title: 'Vehicle Impact',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Protect temporary works from plant and vehicle collision using location, barriers, exclusion zones or engineered protection.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '16',
    title: 'Fire Safety',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Control combustible materials, hot work, temporary electrical installations, emergency access and firefighting arrangements around temporary structures.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '17',
    title: 'Electrical Safety',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Temporary buildings and electrical installations shall be installed by competent persons and coordinated with electrical safety controls.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '18',
    title: 'Portable Buildings',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Provide suitable base, safe access/egress, fire detection/firefighting arrangements, emergency planning and pedestrian/vehicle segregation as applicable.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '19',
    title: 'Inspection',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Inspect before use, after installation, after modification and after events such as impact, severe weather or abnormal loading.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '20',
    title: 'Defects',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Tag or isolate unsafe temporary works. Prevent access or loading until a competent person assesses and corrects the defect.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '21',
    title: 'Modification',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'No unauthorised drilling, cutting, welding, removal of braces, moving, loading or attachment to temporary works.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '22',
    title: 'Interfaces',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Coordinate temporary works with cranes, scaffolds, formwork, MEWPs, excavation, electrical services, traffic and lifting operations.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '23',
    title: 'RAMS/JSA',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'RAMS shall explain erection, use, inspection, loading, exclusion zones, modification, emergency arrangements and dismantling.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '24',
    title: 'Permit / Authorisation',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Use project permit or authorisation systems where required, especially for work affecting structures, excavation, lifting, electrical services or public interfaces.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '25',
    title: 'Erection',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Establish exclusion zones, competent supervision, safe access, sequence controls and temporary stability throughout erection.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '26',
    title: 'Use',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Use only for the approved purpose. Maintain housekeeping, load limits, access and protective systems.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '27',
    title: 'Dismantling',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Plan dismantling in reverse-safe sequence. Do not remove stabilising elements early. Control falling materials and access below.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '28',
    title: 'Emergency',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Plan response to instability, partial collapse, impact, fire, flooding and severe weather. Keep rescue and emergency access clear.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '29',
    title: 'Supervisor Duties',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Verify approved design, erection status, inspections, loading, modifications and environmental conditions.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '30',
    title: 'HSE Duties',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Audit controls, inspect work areas, verify records, identify unsafe conditions and escalate critical defects.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '31',
    title: 'Stop Work',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Stop for movement, settlement, cracking, missing bracing, overload, unauthorised modification, impact damage or any sign of instability.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '32',
    title: 'Unsafe Practices',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Examples: removing props, overloading platforms, using damaged supports, placing heavy plant on unapproved structures, altering braces or ignoring movement.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '33',
    title: 'Corrective Action',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Prevent access/load, stabilise only through competent direction, inspect, repair/reinstate and document approval before reuse.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '34',
    title: 'Toolbox Talk',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Explain design limits, access, loading, exclusion zones, inspection status, prohibited modifications and emergency reporting.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '35',
    title: 'Field Checklist',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Design approved; foundations stable; braces/ties present; connections secure; access safe; load controlled; barriers present; inspection current; defects closed; weather checked; records available.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '36',
    title: 'Field Example',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'A temporary platform develops movement after nearby excavation. Stop loading and access, isolate the area, have a competent person assess ground and structure, correct the cause and inspect before reopening.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '37',
    title: 'Official Basis',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Abu Dhabi primary reference: ADOSH-SF CoP 43.0 Temporary Structures, V4.1 effective 16 February 2026. Related CoP 40.0 False Work V4.1 and applicable lifting, electrical, traffic and fire requirements shall be considered.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '38',
    title: 'Small Details',
    category: '5O — Temporary Works',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Keep bases clean, prevent water accumulation, maintain drainage, prevent combustible waste beneath portable buildings, protect emergency exits, keep walkways clear and record every significant modification.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '01',
    title: 'Definition & Purpose',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Manual handling includes lifting, lowering, carrying, pushing, pulling, holding, moving or supporting loads or people. The objective is to prevent musculoskeletal injury and acute strain.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '02',
    title: 'Hazards',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Hazards include excessive force, awkward posture, repetitive movement, long carrying distance, unstable loads, poor grip, uneven floors, restricted visibility, sudden movement and poor storage height.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '03',
    title: 'Task Assessment',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Assess the object, task, individual, environment and frequency. Consider weight, dimensions, centre of gravity, handles, surface, temperature and sharp edges.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '04',
    title: 'Elimination',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Ask whether the item needs to be moved manually at all. Relocate storage, change delivery sequence or use mechanical handling where practical.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '05',
    title: 'Mechanical Aids',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Use trolleys, pallet trucks, hoists, lifting tables, carts, conveyors or other suitable aids. Select the aid for the load and route.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '06',
    title: 'Load Characteristics',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Check whether the load is unstable, slippery, sharp, hot, cold, contaminated, flexible, liquid-filled or likely to shift.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '07',
    title: 'Route Planning',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Clear the route, check doors, ramps, steps, lighting, floor condition and destination space before lifting.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '08',
    title: 'Grip',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Use designed handles where available. Keep hands away from pinch points and sharp edges.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '09',
    title: 'Body Position',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Use a stable stance and avoid twisting while carrying. Keep the load controlled and close where practical.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '10',
    title: 'Lifting Sequence',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Plan → approach → establish stable footing → secure grip → controlled lift → move smoothly → place safely. Do not jerk the load.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '11',
    title: 'Team Lifting',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Choose a competent lead person, agree commands, synchronise movement and ensure everyone knows when to lift, move and lower.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '12',
    title: 'Pushing & Pulling',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Assess force, wheels, floor condition, slope and visibility. Prefer pushing rather than pulling where the equipment and environment make it safer.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '13',
    title: 'Repetitive Work',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Identify high-frequency tasks and redesign layout, tools, rotation or mechanical assistance to reduce cumulative exposure.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '14',
    title: 'Awkward Work',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Redesign tasks that require prolonged bending, reaching, twisting, kneeling or overhead handling.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '15',
    title: 'Storage',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Store frequently handled materials at practical heights, maintain stable stacks and avoid overreaching.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '16',
    title: 'Pallets',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Inspect pallets for broken boards, protruding nails and instability. Do not move damaged pallets with uncontrolled loads.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '17',
    title: 'Drums & Cylinders',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Use appropriate drum handling equipment and cylinder carts. Do not roll or drag gas cylinders in an unsafe manner.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '18',
    title: 'Long Loads',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Use team handling, mechanical aids and route control. Watch corners, doors, overhead obstructions and other workers.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '19',
    title: 'Sharp / Hot Loads',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Use suitable gloves and handling aids; allow hot items to cool or use designated handling equipment.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '20',
    title: 'Chemical Containers',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Use suitable mechanical handling and chemical controls. Do not manually handle leaking containers without an approved response.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '21',
    title: 'People Handling',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Tasks involving lifting or moving people require specific assessment, suitable equipment, training and dignity/privacy controls.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '22',
    title: 'Individual Capability',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Consider training, experience, physical limitations and health-related restrictions through appropriate occupational-health processes without placing workers at risk.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '23',
    title: 'PPE',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Select gloves, footwear and other PPE for the actual hazard. PPE shall not be used as the main control for excessive force or poor task design.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '24',
    title: 'Training',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Training should cover task-specific handling, mechanical aids, reporting, storage and recognising early symptoms.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '25',
    title: 'Early Reporting',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Workers should report pain, discomfort, near misses, unstable loads and equipment defects early so controls can be improved.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '26',
    title: 'RAMS/JSA',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Include handling sequence, load characteristics, route, mechanical aids, team handling and emergency arrangements.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '27',
    title: 'Supervisor Duties',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Check storage, route, equipment, workload, handling methods and worker feedback.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '28',
    title: 'HSE Duties',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Monitor ergonomic risks, inspect tasks, review incidents and support corrective actions.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '29',
    title: 'Stop Work',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Stop for unstable loads, failed handling equipment, blocked route, uncontrolled excessive force, damaged pallet or unsafe team coordination.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '30',
    title: 'Unsafe Practices',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Examples: twisting while lifting, carrying loads blocking vision, dragging cylinders, lifting from unstable stacks, using broken trolleys and rushing repetitive tasks.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '31',
    title: 'Corrective Action',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Stop the task, make load safe, use a suitable aid, redesign the route/storage and reassess the task.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '32',
    title: 'Toolbox Talk',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Discuss planning, mechanical aids, grip, posture, team lifting, storage, reporting symptoms and avoiding shortcuts.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '33',
    title: 'Field Checklist',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Load assessed; route clear; aid available; equipment inspected; grip safe; posture controlled; team signal agreed; destination ready; PPE suitable; repetitive exposure controlled.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '34',
    title: 'Field Example',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Workers repeatedly carry boxes from floor level to a high shelf. Redesign storage height, use a trolley and reduce repeated lifting rather than relying only on lifting-technique training.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '35',
    title: 'Regulatory Basis',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Abu Dhabi primary reference: ADOSH-SF CoP 14.0 Manual Handling and Ergonomics, V4.0 effective 15 July 2024. CoP 14.1 Manual Tasks Involving the Handling of People is also listed by ADPHC where applicable.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '36',
    title: 'Ergonomic Review',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Review tasks after injury, near miss, equipment change, production change, new material, layout change or worker feedback.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '37',
    title: 'Small Details',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Keep trolley wheels clean and functional, avoid loose straps, maintain stable stacks, keep handles dry, remove trip hazards and never leave a load suspended or leaning unattended.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '38',
    title: 'Continuous Improvement',
    category: '5P — Manual Handling',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Use observations, discomfort reports, incidents and worker consultation to redesign tasks and reduce manual handling exposure.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '01',
    title: 'Definition & Purpose',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Hot work includes welding, cutting and other operations that generate flame, sparks, heat, molten metal or hot particles. Controls prevent fire, explosion, burns, eye injury, fumes and related exposure.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '02',
    title: 'Types',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Include arc welding, gas welding, oxy-fuel cutting, brazing, soldering, gouging and other spark/heat-producing work as defined by the site system.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '03',
    title: 'Planning',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Identify combustible materials, gases, liquids, dust, adjacent rooms, lower levels, concealed spaces, ventilation, gas services and emergency arrangements before work.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '04',
    title: 'Hot Work Permit',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Use the applicable Permit to Work process where required. Confirm work area, hazards, controls, validity, responsible persons and close-out requirements.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '05',
    title: 'Competency',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Operators shall be trained and competent for the equipment and process. Supervisors shall verify competence and task controls.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '06',
    title: 'Equipment Inspection',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Inspect welding machines, leads, electrode holders, torches, regulators, hoses, flashback devices where applicable, cylinders, clamps and earth connections before use.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '07',
    title: 'Fire Prevention',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Remove combustible materials where possible. Otherwise shield them using suitable fire-resistant protection. Control sparks, slag and heat transfer.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '08',
    title: 'Openings & Lower Levels',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Protect floor openings, penetrations, adjacent rooms and lower levels from falling sparks and hot slag. Inspect hidden areas for ignition risk.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '09',
    title: 'Fire Watch',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Provide a competent fire watch where required by the risk assessment, permit or site procedure. Maintain monitoring after work for possible delayed ignition.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '10',
    title: 'Fire Extinguishers',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Provide suitable, accessible firefighting equipment based on the hazard and site emergency plan. Do not obstruct emergency access.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '11',
    title: 'Gas Cylinders',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Identify cylinders, secure them appropriately, protect valves, use suitable regulators and keep cylinders away from heat and damage.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '12',
    title: 'Gas Hoses',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Inspect hoses for cracking, burns, leaks and unsuitable connections. Keep hoses protected from traffic, sharp edges and hot surfaces.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '13',
    title: 'Flashback Protection',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Use suitable flashback arrestors/check valves where required by the equipment, process and applicable procedure. Do not bypass safety devices.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '14',
    title: 'Leak Testing',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Check gas connections using an approved safe method. Never search for a gas leak using a flame.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '15',
    title: 'Cylinder Storage',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Store cylinders upright where required, secured, protected from impact and heat, and segregated as required by the applicable gas-management procedure.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '16',
    title: 'Electrical Welding',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Inspect welding leads, holder, earth connection, insulation and machine condition. Keep electrical connections dry and protected.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '17',
    title: 'Welding Fumes',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Provide suitable local exhaust or general ventilation and occupational exposure controls. Respiratory protection may be required based on the assessment.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '18',
    title: 'Coatings & Confined Spaces',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Assess coatings, residues and confined-space atmospheres before hot work. Hot work in confined spaces requires integrated gas testing, ventilation, isolation and rescue controls.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '19',
    title: 'Flammable Atmospheres',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Do not perform hot work where an uncontrolled flammable atmosphere may exist. Isolate sources and verify conditions through the approved process.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '20',
    title: 'Hot Work Near Gas Lines',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Identify and isolate affected services where required. Do not rely on visual assumptions about pipe contents.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '21',
    title: 'Grinding Interface',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Grinding creates sparks and hot particles and shall receive equivalent fire and eye/face protection controls where applicable.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '22',
    title: 'PPE',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Select helmet/filter lens, eye/face protection, fire-resistant clothing, gloves, footwear, hearing protection and respiratory protection according to the process and assessment.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '23',
    title: 'Screens & Barriers',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Use welding screens and barriers to protect nearby workers from arc radiation, sparks and access to the hot-work zone.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '24',
    title: 'Weather & Outdoor Work',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Control wind that can carry sparks to combustible areas and affect gas flames. Stop when weather makes controls ineffective.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '25',
    title: 'Simultaneous Operations',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Coordinate hot work with painting, gas work, chemical handling, lifting, confined-space entry and other activities that may create additional risk.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '26',
    title: 'Emergency',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Know alarm method, emergency isolation, fire response, escape routes, first aid and incident reporting before starting.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '27',
    title: 'Safe Procedure',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Inspect → permit → isolate/protect area → remove combustibles → set barriers → inspect equipment → establish fire controls → perform work → fire watch → inspect area → close permit.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '28',
    title: 'Post-Work Inspection',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Check the work area, opposite side of partitions, lower levels, voids and adjacent combustible materials for heat, smoke, smouldering or ignition.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '29',
    title: 'Supervisor Duties',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Verify permit, controls, equipment, fire watch, ventilation, gas arrangements and work-area readiness.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '30',
    title: 'HSE Duties',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Audit hot-work controls, verify permits and inspections, monitor exposure and ensure deficiencies are corrected.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '31',
    title: 'Stop Work',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Stop for uncontrolled combustibles, gas leak, defective equipment, inadequate ventilation, flammable atmosphere, loss of fire protection, expired permit or changing conditions.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '32',
    title: 'Unsafe Practices',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Examples: cutting near fuel, bypassing flashback devices, using damaged leads, unsecured cylinders, leaving hot slag, welding without screens, using oxygen for cleaning or ignoring fumes.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '33',
    title: 'Corrective Action',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Stop, isolate, remove ignition source, restore fire controls, repair/replace defective equipment and revalidate the permit before restarting.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '34',
    title: 'Toolbox Talk',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Discuss fire triangle, combustibles, cylinders, hoses, flashback protection, PPE, fumes, screens, fire watch, emergency response and post-work inspection.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '35',
    title: 'Field Checklist',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Permit valid; operator competent; equipment inspected; cylinders secured; hoses sound; regulators suitable; fire protection ready; combustibles controlled; screens installed; ventilation adequate; PPE correct; fire watch assigned; area inspected after work.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '36',
    title: 'Field Example',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Welding is planned beside a painted partition. Protect/remove combustible materials where possible, inspect the opposite side and lower level, establish fire controls and screens, provide ventilation and fire watch, then inspect after completion.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '37',
    title: 'Regulatory Basis',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Abu Dhabi primary reference: ADOSH-SF CoP 28.0 Hot Work Operations, V4.1 effective 16 February 2026. The CoP requires suitable maintained equipment, planning, supervision, competent users, daily competent-person inspection and appropriate PPE; verify the official document for detailed requirements.',
      ),
    ],
  ),
  AbuDhabiFiveNQSection(
    number: '38',
    title: 'Small Details',
    category: '5Q — Hot Work',
    points: [
      AbuDhabiFiveNQPoint(
        title: 'Detailed Field Controls',
        content: 'Keep electrode stubs and hot metal controlled, route leads away from trip hazards, keep cylinder caps/protection arrangements appropriate, prevent sparks entering drains or openings, maintain housekeeping and never leave an ignition source unattended.',
      ),
    ],
  ),
];

