class TbtTopic {
  final int id;
  final String title;
  final String category;
  final String objective;
  final List<String> keyHazards;
  final List<String> requiredControls;
  final List<String> ppe;
  final List<String> beforeStarting;
  final List<String> safeWorkPractices;
  final List<String> emergencyResponse;
  final List<String> supervisorPoints;
  final List<String> codeOfPractice;
  final String workerConfirmation;

  const TbtTopic({
    required this.id,
    required this.title,
    required this.category,
    required this.objective,
    required this.keyHazards,
    required this.requiredControls,
    required this.ppe,
    required this.beforeStarting,
    required this.safeWorkPractices,
    required this.emergencyResponse,
    required this.supervisorPoints,
    required this.codeOfPractice,
    required this.workerConfirmation,
  });
}

List<String> _referencesFor(int id) {
  // ============================================================
  // TBT 41 - EXCAVATION SAFETY
  // ============================================================
  if (id == 41) {
    return [
      'Approved project excavation procedure and RAMS/JSA shall be reviewed before work.',
      'Required excavation Permit to Work (PTW), approvals and site controls shall be in place.',
      'Confirm utility drawings, NOCs and service-location information before breaking ground.',
      'Use an approved shoring, shielding, battering or engineered temporary-works solution where required.',
      'Excavation inspection shall be carried out by a competent person at the required frequency and after relevant changes or events.',
      'Verify current applicable Dubai Municipality construction/excavation requirements or Abu Dhabi DMT/EHS requirements, as applicable to the project and location.',
      'Project specifications, engineer/temporary-works design, utility-owner requirements and current authority requirements take precedence where applicable.',
    ];
  }

  // ============================================================
  // TBT 42 - TRENCHING SAFETY
  // ============================================================
  if (id == 42) {
    return [
      'Approved project trenching procedure and RAMS/JSA shall be reviewed before work.',
      'Required excavation PTW, NOCs and utility-clearance controls shall be confirmed.',
      'Provide an approved shoring, shielding, battering or other protective system where required by the risk assessment/design.',
      'Keep spoil, materials, plant and loads controlled away from trench edges as defined by the approved design/procedure.',
      'Competent-person inspections shall be completed before entry and after conditions change or significant events.',
      'Verify current applicable authority requirements, including Dubai Municipality or Abu Dhabi DMT/EHS requirements where applicable.',
      'Approved project design, temporary-works calculations and utility-owner requirements take precedence where applicable.',
    ];
  }

  // ============================================================
  // TBT 43 - UNDERGROUND SERVICES
  // ============================================================
  if (id == 43) {
    return [
      'Obtain and review current utility drawings, NOCs and service records before excavation.',
      'Use the project-approved utility detection, marking and trial-pit procedure.',
      'Follow utility-owner requirements and permit conditions for excavation near live services.',
      'Do not rely on drawings alone; verify service location using the approved detection/verification method.',
      'Maintain required clearances and protection measures around identified services.',
      'Verify current applicable Dubai Municipality, Abu Dhabi DMT/EHS and utility-owner requirements, as applicable.',
      'Approved project RAMS/JSA, PTW and NOC conditions take precedence where applicable.',
    ];
  }

  // ============================================================
  // GENERAL CODE OF PRACTICE / REFERENCE
  // ============================================================
  return [
    'Follow the approved project RAMS/JSA, Permit to Work requirements and site procedures.',
    'Use applicable UAE HSE requirements and the current project/client HSE plan as reference.',
    'Verify current emirate/authority requirements and the latest applicable Code of Practice before work.',
    'Where an authority, client, engineer or project procedure is more specific, follow the approved applicable requirement.',
    'This TBT is a safety briefing reference and does not replace approved drawings, RAMS/JSA, permits or competent-person instructions.',
  ];
}

TbtTopic _makeTbt(
  int id,
  String title,
  String category,
) {
  return TbtTopic(
    id: id,
    title: title,
    category: category,

    objective:
        'Build worker awareness and consistent safe work practices for $title. Apply the approved site risk assessment, RAMS/JSA, permits and local procedures.',

    keyHazards: [
      'Unsafe conditions or practices related to the task.',
      'Poor planning, inadequate supervision or unclear communication.',
      'Failure to identify changing site conditions before work starts.',
    ],

    requiredControls: [
      'Follow the approved RAMS/JSA, permit requirements and site procedures.',
      'Use competent and authorised personnel for the task.',
      'Inspect the work area, equipment and access before starting.',
      'Maintain exclusion zones, safe access and effective communication.',
      'Stop work and escalate if conditions become unsafe.',
    ],

    ppe: [
      'Safety helmet',
      'Safety footwear',
      'High-visibility clothing',
      'Task-appropriate gloves',
      'Eye protection where required',
      'Hearing, respiratory or fall protection as identified by the risk assessment',
    ],

    beforeStarting: [
      'Conduct the pre-start briefing and confirm everyone understands the task.',
      'Review hazards, controls, emergency arrangements and weather/site conditions.',
      'Check required tools, equipment and PPE are suitable and in good condition.',
    ],

    safeWorkPractices: [
      'Keep the work area controlled, organised and free from unnecessary hazards.',
      'Maintain required clearances and exclusion zones.',
      'Never bypass guards, alarms, permits or safety controls.',
      'Report defects, hazards and near misses immediately.',
      'Use Stop Work Authority whenever there is serious or uncontrolled risk.',
    ],

    emergencyResponse: [
      'Stop work and make the area safe if possible without creating additional risk.',
      'Raise the site emergency alarm and contact the designated emergency response team.',
      'Move to the designated muster point and follow site instructions.',
      'Do not re-enter until authorised.',
    ],

    supervisorPoints: [
      'What are the main hazards of this task at our worksite?',
      'Which controls are mandatory before work begins?',
      'Who is competent/authorised for this task?',
      'What is our emergency and escalation route?',
    ],

    codeOfPractice: _referencesFor(id),

    workerConfirmation:
        'I understand the hazards, controls, PPE, Code of Practice references and emergency arrangements for this toolbox talk. I will follow the approved safe work procedure and report unsafe conditions immediately.',
  );
}

/// ============================================================
/// 100 READY-TO-USE TBT TOPICS
/// ============================================================

final List<TbtTopic> tbtTopics = [
  _makeTbt(1, 'General Safety', 'General Safety'),
  _makeTbt(2, 'Personal Protective Equipment (PPE)', 'General Safety'),
  _makeTbt(3, 'Work at Height', 'General Safety'),
  _makeTbt(4, 'Scaffolding Safety', 'General Safety'),
  _makeTbt(5, 'Ladder Safety', 'General Safety'),
  _makeTbt(6, 'Fall Prevention', 'General Safety'),
  _makeTbt(7, 'Dropped Object Prevention', 'General Safety'),
  _makeTbt(8, 'Safe Access and Egress', 'General Safety'),
  _makeTbt(9, 'Housekeeping', 'General Safety'),
  _makeTbt(10, 'Slips, Trips and Falls', 'General Safety'),

  _makeTbt(11, 'Lifting Operations', 'Lifting & Rigging'),
  _makeTbt(12, 'Crane Safety', 'Lifting & Rigging'),
  _makeTbt(13, 'Rigging Safety', 'Lifting & Rigging'),
  _makeTbt(14, 'Banksman and Signaller Safety', 'Lifting & Rigging'),
  _makeTbt(15, 'Mobile Crane Safety', 'Lifting & Rigging'),

  _makeTbt(16, 'Forklift Safety', 'Plant & Traffic'),
  _makeTbt(17, 'Heavy Equipment Safety', 'Plant & Traffic'),
  _makeTbt(18, 'Vehicle and Traffic Safety', 'Plant & Traffic'),
  _makeTbt(19, 'Reversing Safety', 'Plant & Traffic'),

  _makeTbt(20, 'Manual Handling', 'Manual Handling'),

  _makeTbt(21, 'Electrical Safety', 'Electrical Safety'),
  _makeTbt(22, 'Lockout Tagout (LOTO)', 'Electrical Safety'),
  _makeTbt(23, 'Portable Electrical Tools', 'Electrical Safety'),

  _makeTbt(24, 'Hot Work', 'Hot Work'),
  _makeTbt(25, 'Welding Safety', 'Hot Work'),
  _makeTbt(26, 'Grinding Safety', 'Hot Work'),
  _makeTbt(27, 'Cutting Operations', 'Hot Work'),

  _makeTbt(28, 'Fire Prevention', 'Fire & Emergency'),
  _makeTbt(29, 'Fire Extinguisher Awareness', 'Fire & Emergency'),
  _makeTbt(30, 'Emergency Evacuation', 'Fire & Emergency'),

  _makeTbt(31, 'Confined Space Entry', 'Confined Space'),
  _makeTbt(32, 'Gas Testing', 'Confined Space'),
  _makeTbt(33, 'Confined Space Rescue', 'Confined Space'),

  _makeTbt(34, 'Chemical Safety', 'Chemical & Gas'),
  _makeTbt(35, 'Hazardous Materials', 'Chemical & Gas'),
  _makeTbt(36, 'Chemical Spill Response', 'Chemical & Gas'),
  _makeTbt(37, 'SDS Awareness', 'Chemical & Gas'),
  _makeTbt(38, 'Gas Cylinder Safety', 'Chemical & Gas'),
  _makeTbt(39, 'Compressed Air Safety', 'Chemical & Gas'),

  _makeTbt(40, 'Hand and Power Tools', 'Tools'),

  _makeTbt(41, 'Excavation Safety', 'Excavation'),
  _makeTbt(42, 'Trenching Safety', 'Excavation'),
  _makeTbt(43, 'Underground Services', 'Excavation'),

  _makeTbt(44, 'Construction Site Safety', 'Construction'),
  _makeTbt(45, 'Concrete Work Safety', 'Construction'),
  _makeTbt(46, 'Formwork Safety', 'Construction'),
  _makeTbt(47, 'Rebar Safety', 'Construction'),
  _makeTbt(48, 'Demolition Safety', 'Construction'),
  _makeTbt(49, 'Material Storage', 'Construction'),
  _makeTbt(50, 'Warehouse Safety', 'Construction'),

  _makeTbt(51, 'Heat Stress Management', 'Occupational Health'),
  _makeTbt(52, 'Dehydration Prevention', 'Occupational Health'),
  _makeTbt(53, 'Working in Extreme Weather', 'Occupational Health'),
  _makeTbt(54, 'Dust and Respiratory Protection', 'Occupational Health'),
  _makeTbt(55, 'Noise Exposure', 'Occupational Health'),
  _makeTbt(56, 'Ergonomics', 'Occupational Health'),
  _makeTbt(57, 'Fatigue Management', 'Occupational Health'),
  _makeTbt(58, 'Night Shift Safety', 'Occupational Health'),

  _makeTbt(59, 'First Aid Awareness', 'Emergency & First Aid'),
  _makeTbt(60, 'Emergency Preparedness', 'Emergency & First Aid'),

  _makeTbt(61, 'Hazard Identification', 'Risk Management'),
  _makeTbt(62, 'Risk Assessment', 'Risk Management'),
  _makeTbt(63, 'Job Safety Analysis (JSA)', 'Risk Management'),
  _makeTbt(64, 'Permit to Work (PTW)', 'Risk Management'),

  _makeTbt(65, 'Near Miss Reporting', 'Incident Management'),
  _makeTbt(66, 'Incident Reporting', 'Incident Management'),

  _makeTbt(67, 'Stop Work Authority', 'Safety Leadership'),
  _makeTbt(68, 'Safety Communication', 'Safety Leadership'),
  _makeTbt(69, 'Toolbox Talk Participation', 'Safety Leadership'),
  _makeTbt(70, 'Positive Safety Behaviour', 'Safety Leadership'),

  _makeTbt(71, 'Marine and Port Safety', 'Marine Safety'),
  _makeTbt(72, 'Working Near Water', 'Marine Safety'),

  _makeTbt(73, 'Road Work Safety', 'Road Safety'),
  _makeTbt(74, 'Defensive Driving', 'Road Safety'),
  _makeTbt(75, 'Pedestrian Safety', 'Road Safety'),

  _makeTbt(76, 'Environmental Safety', 'Environmental'),
  _makeTbt(77, 'Waste Management', 'Environmental'),
  _makeTbt(78, 'Spill Prevention', 'Environmental'),
  _makeTbt(79, 'Fuel Handling Safety', 'Environmental'),
  _makeTbt(80, 'Environmental Incident Reporting', 'Environmental'),

  _makeTbt(81, 'Roof Work Safety', 'Specialist Work'),
  _makeTbt(82, 'Fragile Roof Safety', 'Specialist Work'),
  _makeTbt(83, 'Temporary Works Safety', 'Specialist Work'),
  _makeTbt(84, 'Pressure Testing Safety', 'Specialist Work'),

  _makeTbt(85, 'Pneumatic Tool Safety', 'Equipment & Maintenance'),
  _makeTbt(86, 'Hydraulic Equipment Safety', 'Equipment & Maintenance'),
  _makeTbt(87, 'Machine Guarding', 'Equipment & Maintenance'),
  _makeTbt(88, 'Maintenance Safety', 'Equipment & Maintenance'),

  _makeTbt(
    89,
    'Cleaning and Maintenance Chemicals',
    'Chemical Safety',
  ),

  _makeTbt(90, 'Working Alone', 'General HSE'),
  _makeTbt(91, 'Daily Safety Briefing', 'General HSE'),
  _makeTbt(92, 'Pre-Start Safety Meeting', 'General HSE'),
  _makeTbt(93, 'Safety Observation', 'General HSE'),
  _makeTbt(94, 'Corrective Action Awareness', 'General HSE'),

  _makeTbt(
    95,
    'Safety Leadership for Supervisors',
    'Safety Leadership',
  ),
  _makeTbt(
    96,
    'Worker Right to Stop Unsafe Work',
    'Safety Leadership',
  ),
  _makeTbt(
    97,
    'Safety Rules and Site Discipline',
    'Safety Leadership',
  ),
  _makeTbt(
    98,
    'HSE Awareness for New Workers',
    'Safety Leadership',
  ),
  _makeTbt(
    99,
    'Safety Culture and Teamwork',
    'Safety Leadership',
  ),
  _makeTbt(
    100,
    '100% Safe Work Commitment',
    'Safety Leadership',
  ),
];

final List<String> tbtCategories = [
  'General Safety',
  'Lifting & Rigging',
  'Plant & Traffic',
  'Manual Handling',
  'Electrical Safety',
  'Hot Work',
  'Fire & Emergency',
  'Confined Space',
  'Chemical & Gas',
  'Tools',
  'Excavation',
  'Construction',
  'Occupational Health',
  'Emergency & First Aid',
  'Risk Management',
  'Incident Management',
  'Safety Leadership',
  'Marine Safety',
  'Road Safety',
  'Environmental',
  'Specialist Work',
  'Equipment & Maintenance',
  'Chemical Safety',
  'General HSE',
];
