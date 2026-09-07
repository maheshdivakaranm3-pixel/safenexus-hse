import '../models/reference_topic.dart';

/// ============================================================
/// HSE SAFETY REFERENCE
///
/// Practical construction HSE safety reference topics.
/// These are general HSE references and are separate from
/// UAE General, Abu Dhabi and Dubai-specific standards.
/// ============================================================

const List<ReferenceTopic> hseSafetyReference = [
  // ============================================================
  // 1. EXCAVATION
  // ============================================================

  ReferenceTopic(
    id: 'excavation_safety',
    title: 'Excavation Safety',
    shortTitle: 'Excavation',
    description:
        'Safety requirements and good practices for excavation and trenching activities, including ground stability, access, underground services and protection against collapse.',
    category: 'UAE General',
    authority: 'HSE Safety Reference',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Conduct a risk assessment before excavation work starts.',
      'Identify underground utilities and services before digging.',
      'Provide safe access and egress to excavations.',
      'Assess soil and ground stability.',
      'Provide suitable protective systems where required.',
      'Inspect excavations before work starts and after significant changes.',
    ],
    safetyControls: [
      'Use suitable shoring, shielding or battering systems.',
      'Keep excavated materials and equipment away from excavation edges.',
      'Provide barricades and warning signs around open excavations.',
      'Control vehicle and plant movement near excavation edges.',
      'Prevent water accumulation inside excavations.',
      'Stop work if unsafe ground movement or collapse indicators are observed.',
    ],
    responsibilities: [
      'Supervisors must ensure excavation controls are implemented.',
      'Workers must follow excavation procedures and access requirements.',
      'HSE personnel should verify inspections and risk controls.',
      'Plant operators must maintain a safe distance from excavation edges.',
    ],
    references: [
      'Approved project risk assessment and method statement.',
      'Approved excavation permit where applicable.',
      'Applicable UAE construction safety requirements.',
      'Project HSE plan and emergency arrangements.',
    ],
  ),

  // ============================================================
  // 2. SCAFFOLDING
  // ============================================================

  ReferenceTopic(
    id: 'scaffolding_safety',
    title: 'Scaffolding Safety',
    shortTitle: 'Scaffolding',
    description:
        'Safe erection, inspection, modification, use and dismantling of scaffolding systems, including stability, access, guardrails and fall prevention.',
    category: 'UAE General',
    authority: 'HSE Safety Reference',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Scaffolding must be erected by competent personnel.',
      'Scaffolds must be stable and adequately supported.',
      'Provide safe access and egress.',
      'Provide suitable guardrails, midrails and toe boards where required.',
      'Inspect scaffolding before use and at required intervals.',
      'Do not use incomplete or unsafe scaffolding.',
    ],
    safetyControls: [
      'Use proper foundations and base plates.',
      'Provide adequate bracing and ties.',
      'Prevent unauthorised modification.',
      'Display scaffold inspection status where applicable.',
      'Keep platforms clear of unnecessary materials.',
      'Provide suitable fall protection during erection and dismantling.',
    ],
    responsibilities: [
      'Scaffolders must follow approved erection procedures.',
      'Supervisors must ensure scaffolds are inspected.',
      'Workers must not alter scaffolding without authorisation.',
      'HSE personnel should verify scaffold inspection arrangements.',
    ],
    references: [
      'Approved scaffold design where required.',
      'Project scaffold inspection procedure.',
      'Manufacturer instructions.',
      'Applicable UAE construction safety requirements.',
    ],
  ),

  // ============================================================
  // 3. WORKING AT HEIGHT
  // ============================================================

  ReferenceTopic(
    id: 'working_at_height',
    title: 'Working at Height',
    shortTitle: 'Working at Height',
    description:
        'Safety practices for activities where workers may fall from an elevated position, including work platforms, ladders, scaffolds and fall protection systems.',
    category: 'UAE General',
    authority: 'HSE Safety Reference',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Plan work at height before starting.',
      'Assess fall hazards and select suitable controls.',
      'Use collective protection wherever reasonably practicable.',
      'Use suitable personal fall protection when required.',
      'Ensure access equipment is suitable and inspected.',
      'Provide an emergency rescue plan.',
    ],
    safetyControls: [
      'Use guardrails and properly protected platforms.',
      'Secure ladders and provide safe access.',
      'Inspect harnesses and fall arrest equipment.',
      'Protect floor openings and edges.',
      'Prevent dropped objects from elevated work areas.',
      'Stop work during unsafe weather conditions where necessary.',
    ],
    responsibilities: [
      'Supervisors must verify work-at-height controls.',
      'Workers must use required fall protection correctly.',
      'HSE personnel should monitor high-risk activities.',
      'Employers must provide suitable equipment and training.',
    ],
    references: [
      'Approved work-at-height procedure.',
      'Risk assessment and method statement.',
      'Manufacturer instructions for fall protection equipment.',
      'Project emergency rescue plan.',
    ],
  ),

  // ============================================================
  // 4. POWER TOOLS
  // ============================================================

  ReferenceTopic(
    id: 'power_tools_safety',
    title: 'Power Tools Safety',
    shortTitle: 'Power Tools',
    description:
        'Safe selection, inspection, operation and maintenance of portable power tools to control electrical, mechanical, cutting and flying-particle hazards.',
    category: 'UAE General',
    authority: 'HSE Safety Reference',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Use the correct tool for the intended task.',
      'Inspect tools before use.',
      'Only authorised and competent workers should operate tools.',
      'Use suitable guards and protective devices.',
      'Use required PPE.',
      'Remove defective tools from service.',
    ],
    safetyControls: [
      'Check cables, plugs and switches before use.',
      'Ensure guards are correctly installed.',
      'Use eye and face protection where required.',
      'Keep hands away from moving or cutting parts.',
      'Disconnect tools before adjustment or maintenance.',
      'Maintain good housekeeping around tool-use areas.',
    ],
    responsibilities: [
      'Workers must inspect tools before use.',
      'Supervisors must ensure defective tools are removed.',
      'HSE personnel should monitor safe tool practices.',
      'Employers must provide suitable tools and training.',
    ],
    references: [
      'Manufacturer operating instructions.',
      'Electrical safety procedure.',
      'Tool inspection procedure.',
      'Project HSE plan.',
    ],
  ),

  // ============================================================
  // 5. FORMWORK
  // ============================================================

  ReferenceTopic(
    id: 'formwork_safety',
    title: 'Formwork Safety',
    shortTitle: 'Formwork',
    description:
        'Safety practices for formwork installation, support, inspection, concrete pouring, stripping and dismantling.',
    category: 'UAE General',
    authority: 'HSE Safety Reference',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Formwork must be designed and installed appropriately.',
      'Temporary supports must have adequate capacity.',
      'Inspect formwork before concrete placement.',
      'Control access to formwork areas.',
      'Follow approved concrete pouring procedures.',
      'Do not remove supports without authorisation.',
    ],
    safetyControls: [
      'Verify alignment, stability and support systems.',
      'Prevent unauthorised access below formwork.',
      'Control concrete placement rates.',
      'Monitor signs of movement or instability.',
      'Provide suitable working platforms.',
      'Use safe dismantling procedures.',
    ],
    responsibilities: [
      'Supervisors must ensure approved formwork systems are used.',
      'Workers must follow the approved method statement.',
      'Engineers must verify design requirements where applicable.',
      'HSE personnel should monitor critical formwork activities.',
    ],
    references: [
      'Approved formwork design.',
      'Temporary works procedure.',
      'Method statement and risk assessment.',
      'Project structural requirements.',
    ],
  ),

  // ============================================================
  // 6. PERMIT TO WORK
  // ============================================================

  ReferenceTopic(
    id: 'permit_to_work',
    title: 'Permit to Work',
    shortTitle: 'PTW',
    description:
        'A controlled system for authorising high-risk work and confirming that hazards, isolations, precautions and responsibilities have been addressed before work starts.',
    category: 'UAE General',
    authority: 'HSE Safety Reference',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Identify work requiring a permit.',
      'Complete risk assessment before issuing the permit.',
      'Define required control measures.',
      'Verify isolations where applicable.',
      'Ensure workers understand permit conditions.',
      'Close or suspend permits when conditions change.',
    ],
    safetyControls: [
      'Display permits at the work location where required.',
      'Conduct toolbox talks before high-risk activities.',
      'Verify gas testing where applicable.',
      'Control simultaneous activities.',
      'Stop work when permit conditions are no longer valid.',
      'Close permits after work completion and area inspection.',
    ],
    responsibilities: [
      'Permit issuer must verify required controls.',
      'Permit receiver must comply with permit conditions.',
      'Supervisors must monitor work activities.',
      'HSE personnel should audit the PTW system.',
    ],
    references: [
      'Project Permit to Work procedure.',
      'Risk assessment.',
      'Method statement.',
      'Isolation and lockout procedures.',
    ],
  ),

  // ============================================================
  // 7. HOT & HUMID CLIMATE
  // ============================================================

  ReferenceTopic(
    id: 'hot_humid_climate',
    title: 'Working in Hot & Humid Climate',
    shortTitle: 'Heat Stress',
    description:
        'Practical controls for protecting workers from heat stress, dehydration, fatigue and heat-related illness when working in hot and humid conditions.',
    category: 'UAE General',
    authority: 'HSE Safety Reference',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Implement a heat-stress management programme.',
      'Provide adequate drinking water.',
      'Provide suitable shaded or cooled rest areas.',
      'Plan work according to environmental conditions.',
      'Train workers to recognise heat-related illness.',
      'Provide prompt first aid and emergency response.',
    ],
    safetyControls: [
      'Schedule heavy work during safer periods where possible.',
      'Use work-rest arrangements based on applicable requirements.',
      'Encourage regular hydration.',
      'Monitor workers for heat-stress symptoms.',
      'Provide suitable clothing and PPE for the task.',
      'Use buddy systems for high-risk activities.',
    ],
    responsibilities: [
      'Supervisors must monitor workers during hot conditions.',
      'Workers must maintain hydration and report symptoms.',
      'HSE personnel should monitor heat-stress controls.',
      'Employers must provide suitable welfare arrangements.',
    ],
    references: [
      'Applicable UAE heat-stress requirements.',
      'Project heat-stress management plan.',
      'Occupational health procedure.',
      'Emergency response procedure.',
    ],
  ),

  // ============================================================
  // 8. CONFINED SPACE
  // ============================================================

  ReferenceTopic(
    id: 'confined_space_safety',
    title: 'Confined Space Safety',
    shortTitle: 'Confined Space',
    description:
        'Safety controls for entry into confined spaces, including hazard assessment, atmospheric testing, ventilation, isolation, communication and rescue.',
    category: 'UAE General',
    authority: 'HSE Safety Reference',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Identify and assess confined-space hazards.',
      'Use a confined-space entry permit where required.',
      'Conduct atmospheric testing before and during entry as necessary.',
      'Provide adequate ventilation.',
      'Isolate hazardous energy and materials.',
      'Provide a suitable rescue plan.',
    ],
    safetyControls: [
      'Use calibrated gas detection equipment.',
      'Maintain continuous communication.',
      'Provide trained standby personnel.',
      'Control entry and exit.',
      'Use suitable respiratory protection where required.',
      'Keep rescue equipment ready at the entry point.',
    ],
    responsibilities: [
      'Entry supervisor must verify permit conditions.',
      'Entrants must follow confined-space procedures.',
      'Standby personnel must maintain communication.',
      'Rescue personnel must be trained and prepared.',
    ],
    references: [
      'Confined-space entry procedure.',
      'Permit to Work system.',
      'Risk assessment and method statement.',
      'Emergency rescue plan.',
    ],
  ),

  // ============================================================
  // 9. WORKING NEAR LIVE ROADS
  // ============================================================

  ReferenceTopic(
    id: 'working_near_live_roads',
    title: 'Working Near Live Roads',
    shortTitle: 'Live Road Safety',
    description:
        'Safety measures for construction and maintenance activities near live traffic, including traffic control, barriers, signs, lighting and worker visibility.',
    category: 'UAE General',
    authority: 'HSE Safety Reference',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Prepare an approved traffic management arrangement.',
      'Separate workers from moving traffic.',
      'Provide appropriate signs and warning devices.',
      'Use suitable barriers and traffic control measures.',
      'Ensure workers are visible to road users.',
      'Coordinate with relevant authorities where required.',
    ],
    safetyControls: [
      'Maintain safe separation from live traffic.',
      'Use trained traffic marshals where required.',
      'Provide adequate lighting for night work.',
      'Control construction vehicle movements.',
      'Maintain clear emergency access.',
      'Inspect traffic controls regularly.',
    ],
    responsibilities: [
      'Traffic management personnel must implement approved controls.',
      'Supervisors must monitor the work zone.',
      'Workers must remain within designated safe areas.',
      'HSE personnel should inspect traffic safety arrangements.',
    ],
    references: [
      'Approved traffic management plan.',
      'Project road-work requirements.',
      'Applicable authority requirements.',
      'Risk assessment and method statement.',
    ],
  ),

  // ============================================================
  // 10. CONCRETING
  // ============================================================

  ReferenceTopic(
    id: 'concreting_safety',
    title: 'Concreting Safety',
    shortTitle: 'Concreting',
    description:
        'Safe practices for concrete delivery, pumping, placing, vibrating and finishing activities, including control of plant, pressure and material hazards.',
    category: 'UAE General',
    authority: 'HSE Safety Reference',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Inspect concrete pumps and associated equipment.',
      'Establish safe exclusion zones.',
      'Ensure formwork is ready before concrete placement.',
      'Control concrete hose movement.',
      'Use suitable PPE against cement and concrete exposure.',
      'Maintain communication between operators and workers.',
    ],
    safetyControls: [
      'Secure pump lines and connections.',
      'Keep workers away from suspended or pressurised equipment.',
      'Use suitable eye and skin protection.',
      'Control access around concrete pumps.',
      'Prevent uncontrolled hose movement.',
      'Clean spills promptly to prevent slips.',
    ],
    responsibilities: [
      'Pump operators must follow operating procedures.',
      'Supervisors must coordinate concrete placement activities.',
      'Workers must use required PPE.',
      'HSE personnel should monitor exclusion zones and controls.',
    ],
    references: [
      'Concrete pouring method statement.',
      'Equipment manufacturer instructions.',
      'Risk assessment.',
      'Project HSE plan.',
    ],
  ),

  // ============================================================
  // 11. BARRICADING OF HAZARDS
  // ============================================================

  ReferenceTopic(
    id: 'barricading_of_hazards',
    title: 'Barricading of Hazards',
    shortTitle: 'Barricading',
    description:
        'Requirements and good practices for isolating hazardous areas using suitable barricades, warning signs and controlled access arrangements.',
    category: 'UAE General',
    authority: 'HSE Safety Reference',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Identify hazards requiring physical isolation.',
      'Use suitable barricades for the hazard level.',
      'Provide warning signs and hazard information.',
      'Prevent unauthorised entry.',
      'Maintain emergency access where required.',
      'Inspect barricades regularly.',
    ],
    safetyControls: [
      'Use rigid barriers where physical protection is required.',
      'Use warning tape only for suitable low-risk applications.',
      'Clearly identify openings, edges and restricted areas.',
      'Maintain adequate visibility of barricades.',
      'Replace damaged barricades immediately.',
      'Remove barricades only when the hazard is eliminated.',
    ],
    responsibilities: [
      'Workers must not remove barricades without authorisation.',
      'Supervisors must ensure hazardous areas are properly isolated.',
      'HSE personnel should inspect barricading arrangements.',
      'Contractors must maintain barriers around their work areas.',
    ],
    references: [
      'Project barricading procedure.',
      'Risk assessment.',
      'Site traffic management requirements.',
      'Project HSE plan.',
    ],
  ),

  // ============================================================
  // 12. WORKER WELFARE
  // ============================================================

  ReferenceTopic(
    id: 'worker_welfare',
    title: 'Worker Welfare',
    shortTitle: 'Worker Welfare',
    description:
        'Essential workplace welfare provisions including drinking water, sanitation, rest areas, hygiene and worker wellbeing.',
    category: 'UAE General',
    authority: 'HSE Safety Reference',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Provide adequate potable drinking water.',
      'Provide suitable sanitation facilities.',
      'Provide appropriate rest and welfare areas.',
      'Maintain good hygiene standards.',
      'Provide arrangements appropriate to site conditions.',
      'Monitor welfare facilities regularly.',
    ],
    safetyControls: [
      'Keep welfare facilities clean and hygienic.',
      'Provide adequate waste disposal.',
      'Maintain drinking water supplies.',
      'Provide suitable shaded or cooled rest areas where required.',
      'Ensure welfare facilities are accessible.',
      'Report and correct welfare deficiencies promptly.',
    ],
    responsibilities: [
      'Employers must provide suitable welfare facilities.',
      'Supervisors must monitor site welfare conditions.',
      'Workers must maintain cleanliness and report deficiencies.',
      'HSE personnel should conduct welfare inspections.',
    ],
    references: [
      'Applicable UAE labour and welfare requirements.',
      'Project welfare procedure.',
      'Site HSE plan.',
      'Occupational health requirements.',
    ],
  ),

  // ============================================================
  // 13. MEWP
  // ============================================================

  ReferenceTopic(
    id: 'mewp_safety',
    title: 'Mobile Elevated Work Platform (MEWP)',
    shortTitle: 'MEWP',
    description:
        'Safe selection, inspection, positioning and operation of mobile elevated work platforms, including stability, fall protection and emergency lowering.',
    category: 'UAE General',
    authority: 'HSE Safety Reference',
    jurisdiction: 'UAE',
    keyRequirements: [
      'MEWP operators must be trained and authorised.',
      'Conduct pre-use inspections.',
      'Use the correct MEWP for the task and ground conditions.',
      'Use required fall protection.',
      'Maintain safe clearance from overhead hazards.',
      'Ensure emergency lowering arrangements are available.',
    ],
    safetyControls: [
      'Check ground stability before positioning.',
      'Use outriggers where applicable.',
      'Maintain exclusion zones below elevated work.',
      'Do not exceed rated platform capacity.',
      'Do not bypass safety devices.',
      'Follow manufacturer operating instructions.',
    ],
    responsibilities: [
      'Operators must complete pre-use checks.',
      'Supervisors must ensure competent operators are assigned.',
      'HSE personnel should verify inspection and training records.',
      'Workers must follow MEWP operating restrictions.',
    ],
    references: [
      'Manufacturer operating manual.',
      'MEWP inspection procedure.',
      'Operator training requirements.',
      'Work-at-height risk assessment.',
    ],
  ),

  // ============================================================
  // 14. ELECTRICITY & ELECTRICAL TOOLS
  // ============================================================

  ReferenceTopic(
    id: 'site_electricity_electrical_tools',
    title: 'Electricity on Site & Electrical Tools',
    shortTitle: 'Electrical Safety',
    description:
        'Controls for temporary site electrical systems, distribution boards, cables, portable electrical tools, grounding and protection devices.',
    category: 'UAE General',
    authority: 'HSE Safety Reference',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Electrical installations must be installed by competent personnel.',
      'Use suitable protective devices.',
      'Inspect electrical tools and cables regularly.',
      'Protect cables from mechanical damage.',
      'Provide suitable grounding and protection.',
      'Isolate electrical equipment before maintenance.',
    ],
    safetyControls: [
      'Use appropriate RCD/GFCI protection where applicable.',
      'Keep distribution boards protected and accessible.',
      'Do not use damaged cables or plugs.',
      'Prevent cables from creating trip hazards.',
      'Use suitable weather protection for outdoor equipment.',
      'Apply lockout and isolation procedures when required.',
    ],
    responsibilities: [
      'Electricians must perform authorised electrical work.',
      'Workers must report damaged electrical equipment.',
      'Supervisors must control temporary electrical installations.',
      'HSE personnel should conduct electrical safety inspections.',
    ],
    references: [
      'Project electrical safety procedure.',
      'Approved temporary electrical design.',
      'Manufacturer instructions.',
      'Applicable electrical safety requirements.',
    ],
  ),

  // ============================================================
  // 15. TEMPORARY WORKS
  // ============================================================

  ReferenceTopic(
    id: 'temporary_works',
    title: 'Temporary Works',
    shortTitle: 'Temporary Works',
    description:
        'Safety management of temporary structures and systems such as formwork, falsework, temporary supports, access systems and other temporary installations.',
    category: 'UAE General',
    authority: 'HSE Safety Reference',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Identify temporary works during project planning.',
      'Ensure designs are prepared and reviewed by competent persons.',
      'Define installation and dismantling procedures.',
      'Inspect temporary works before use.',
      'Control changes and modifications.',
      'Remove temporary works safely when no longer required.',
    ],
    safetyControls: [
      'Use approved drawings and calculations where required.',
      'Control loading and imposed forces.',
      'Inspect supports and connections.',
      'Prevent unauthorised modification.',
      'Maintain exclusion zones where necessary.',
      'Monitor temporary works during critical operations.',
    ],
    responsibilities: [
      'Temporary works coordinator must manage the process where appointed.',
      'Supervisors must ensure approved systems are used.',
      'Workers must follow approved procedures.',
      'HSE personnel should monitor implementation of controls.',
    ],
    references: [
      'Temporary works procedure.',
      'Approved design and drawings.',
      'Risk assessment and method statement.',
      'Project structural requirements.',
    ],
  ),

  // ============================================================
  // 16. MANUAL HANDLING
  // ============================================================

  ReferenceTopic(
    id: 'manual_handling',
    title: 'Manual Handling',
    shortTitle: 'Manual Handling',
    description:
        'Safe manual handling practices covering lifting, carrying, pushing, pulling, team handling, load assessment and prevention of musculoskeletal injuries.',
    category: 'UAE General',
    authority: 'HSE Safety Reference',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Assess manual handling risks before starting.',
      'Avoid manual handling where mechanical assistance is reasonably practicable.',
      'Consider load weight, size, shape and stability.',
      'Use correct lifting techniques.',
      'Provide suitable manual handling training.',
      'Use team lifting where appropriate.',
    ],
    safetyControls: [
      'Use trolleys, hoists or mechanical aids where possible.',
      'Keep loads close to the body during lifting.',
      'Avoid twisting while carrying loads.',
      'Maintain clear travel routes.',
      'Do not lift loads beyond individual capability.',
      'Stop and seek assistance when a load is unsafe to handle.',
    ],
    responsibilities: [
      'Workers must follow safe lifting practices.',
      'Supervisors must identify manual handling risks.',
      'Employers should provide suitable mechanical aids.',
      'HSE personnel should monitor ergonomic risks.',
    ],
    references: [
      'Manual handling risk assessment.',
      'Ergonomics procedure.',
      'Safe lifting training material.',
      'Project HSE plan.',
    ],
  ),

  // ============================================================
  // 17. HOT WORKS
  // ============================================================

  ReferenceTopic(
    id: 'hot_works_safety',
    title: 'Hot Works Safety',
    shortTitle: 'Hot Works',
    description:
        'Safety controls for welding, cutting, grinding, brazing and other hot work activities, including fire prevention, gas cylinder safety and permit requirements.',
    category: 'UAE General',
    authority: 'HSE Safety Reference',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Obtain a hot-work permit where required.',
      'Inspect the work area before starting.',
      'Remove or protect combustible materials.',
      'Provide suitable fire extinguishers.',
      'Inspect welding and cutting equipment.',
      'Provide suitable PPE and ventilation.',
    ],
    safetyControls: [
      'Use fire-resistant screens and blankets where required.',
      'Maintain suitable fire watch arrangements.',
      'Secure gas cylinders upright.',
      'Keep oxygen and fuel gases properly separated as required.',
      'Check hoses, regulators and connections.',
      'Conduct post-work fire checks.',
    ],
    responsibilities: [
      'Workers must follow hot-work permit conditions.',
      'Supervisors must inspect the work area before authorisation.',
      'Fire watch personnel must monitor for ignition hazards.',
      'HSE personnel should verify hot-work controls.',
    ],
    references: [
      'Hot Work Permit procedure.',
      'Fire prevention and emergency procedure.',
      'Welding and cutting equipment instructions.',
      'Project HSE plan.',
    ],
  ),
];
