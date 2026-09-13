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
  final String meetingFocus;
  final List<String> discussionQuestions;

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
    required this.meetingFocus,
    required this.discussionQuestions,
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


String _meetingFocusFor(int id, String title) {
  const focus = <int, String>{
    1: 'Understand the site safety rules, Stop Work Authority and immediate reporting expectations.',
    2: 'Select, inspect and correctly use PPE based on the task risk assessment.',
    3: 'Prevent falls through approved access, edge protection and fall-arrest controls.',
    4: 'Use only inspected scaffolds with safe access, platforms, guardrails and tags.',
    5: 'Use ladders only for suitable tasks and maintain three-point contact.',
    6: 'Identify fall hazards and verify prevention/protection controls before work.',
    7: 'Prevent tools, materials and equipment from falling onto people or property.',
    8: 'Maintain safe access and egress routes and keep emergency paths unobstructed.',
    9: 'Maintain clean, orderly work areas to prevent injuries and fire hazards.',
    10: 'Control slip, trip and fall hazards through housekeeping and safe access.',
    11: 'Plan lifting operations, verify lifting gear and maintain exclusion zones.',
    12: 'Operate cranes only under approved lift plans with competent personnel.',
    13: 'Select, inspect and use rigging equipment within its rated capacity.',
    14: 'Use clear signals and communication between banksman, operator and work crew.',
    15: 'Control mobile-crane setup, ground conditions, outriggers and lifting radius.',
    16: 'Control pedestrian/vehicle interaction, loads, visibility and forklift stability.',
    17: 'Keep heavy plant within its operating limits and control blind spots.',
    18: 'Separate vehicles and pedestrians and enforce site traffic controls.',
    19: 'Control reversing with planning, alarms, cameras and a trained spotter where required.',
    20: 'Use safe lifting techniques, mechanical aids and team lifting where appropriate.',
    21: 'Prevent electric shock, arc flash and fire through isolation and inspection.',
    22: 'Apply verified isolation, lockout, tagout and zero-energy checks before work.',
    23: 'Inspect portable electrical tools, cables, plugs and protective devices before use.',
    24: 'Control ignition sources, combustibles, gas cylinders, fire watch and permits.',
    25: 'Control welding fumes, hot metal, cylinders, screens and fire risk.',
    26: 'Control sparks, wheel condition, guards, workpiece stability and eye protection.',
    27: 'Control cutting tools, sparks, stored energy and fire hazards.',
    28: 'Prevent fires through ignition-source control, housekeeping and emergency readiness.',
    29: 'Know extinguisher types, limitations, safe approach and when to evacuate.',
    30: 'Know alarm, evacuation routes, muster points and emergency responsibilities.',
    31: 'Prevent confined-space exposure through entry controls, testing and rescue planning.',
    32: 'Verify atmospheric testing, calibration, monitoring and response to alarms.',
    33: 'Ensure a dedicated, practiced rescue plan is available before entry.',
    34: 'Identify chemical hazards and control exposure through storage, handling and PPE.',
    35: 'Control hazardous materials from receipt and storage through use and disposal.',
    36: 'Contain and report chemical spills using the approved spill-response procedure.',
    37: 'Use SDS information to understand hazards, PPE, storage and emergency measures.',
    38: 'Secure cylinders, separate incompatible gases and prevent valve damage.',
    39: 'Prevent hose failure, flying particles and unsafe compressed-air use.',
    40: 'Use the correct tool, guards and inspection method and avoid unsafe modifications.',
    41: 'Prevent collapse, falls, struck-by incidents and underground-service damage.',
    42: 'Protect trench occupants through approved protective systems and inspections.',
    43: 'Locate, verify and protect underground utilities before and during excavation.',
    44: 'Apply construction-site controls for people, plant, materials and changing conditions.',
    45: 'Control concrete pours, pumps, formwork interfaces, access and wet-cement exposure.',
    46: 'Verify formwork stability, bracing, access and controlled stripping.',
    47: 'Prevent impalement, cuts, manual-handling injuries and unstable rebar stacks.',
    48: 'Control demolition sequence, exclusion zones, structural stability and dust.',
    49: 'Store materials securely, maintain access and prevent collapse or falling objects.',
    50: 'Control warehouse traffic, stacking, storage systems, lifting and fire risks.',
    51: 'Prevent heat illness through hydration, rest, shade and heat-stress controls.',
    52: 'Recognize dehydration early and maintain planned hydration during work.',
    53: 'Adjust work controls for heat, rain, wind, poor visibility and other weather.',
    54: 'Control airborne dust through engineering controls, housekeeping and respiratory protection.',
    55: 'Reduce noise exposure and use hearing protection where required.',
    56: 'Prevent ergonomic strain through task design, posture, rotation and mechanical aids.',
    57: 'Recognize fatigue risks and ensure adequate rest, supervision and reporting.',
    58: 'Control reduced visibility, fatigue, lighting and communication during night work.',
    59: 'Ensure workers know first-aid arrangements, emergency contacts and incident reporting.',
    60: 'Confirm emergency scenarios, alarms, muster points, contacts and response roles.',
    61: 'Identify hazards before work and reassess when conditions change.',
    62: 'Apply the hierarchy of controls and verify risk controls before starting.',
    63: 'Break the job into steps and link each step to hazards and controls.',
    64: 'Verify permit requirements, isolations, precautions and permit boundaries.',
    65: 'Report near misses promptly so lessons can prevent recurrence.',
    66: 'Report incidents accurately, preserve the scene where required and escalate promptly.',
    67: 'Use Stop Work Authority whenever a serious or uncontrolled risk is identified.',
    68: 'Use clear safety communication, handover and confirmation of critical instructions.',
    69: 'Make toolbox talks interactive and ensure workers understand the controls.',
    70: 'Recognize and reinforce safe behaviors while correcting unsafe acts respectfully.',
    71: 'Control marine traffic, vessel access, mooring, lifting and port interfaces.',
    72: 'Prevent drowning through edge protection, life-saving equipment and rescue readiness.',
    73: 'Control work zones, traffic interfaces, barriers, signage and worker visibility.',
    74: 'Apply defensive-driving principles and manage speed, distance and distractions.',
    75: 'Separate pedestrians from vehicles and provide controlled crossing points.',
    76: 'Prevent environmental harm through planned controls and responsible work practices.',
    77: 'Segregate, store and dispose of waste according to approved requirements.',
    78: 'Prevent spills through containment, inspection and controlled handling.',
    79: 'Control ignition, transfer, storage and spill risks during fuel handling.',
    80: 'Report environmental incidents promptly and implement effective corrective actions.',
    81: 'Control roof access, edges, openings, fragile areas and fall-protection systems.',
    82: 'Identify fragile roof surfaces and establish exclusion and fall-protection controls.',
    83: 'Use approved temporary-works designs, inspections and change controls.',
    84: 'Control stored energy, exclusion zones, test pressure and release points.',
    85: 'Control pneumatic hoses, couplings, pressure and tool condition.',
    86: 'Control hydraulic pressure, stored energy, leaks and isolation before maintenance.',
    87: 'Keep machine guards effective and never bypass interlocks or protective devices.',
    88: 'Plan maintenance, isolate energy sources and control unexpected start-up.',
    89: 'Control chemical selection, labeling, storage, ventilation and worker exposure.',
    90: 'Assess lone-worker risks and establish communication, check-in and emergency arrangements.',
    91: 'Use the daily briefing to confirm work scope, hazards, controls and changes.',
    92: 'Confirm pre-start readiness, permits, equipment, workforce competency and controls.',
    93: 'Identify unsafe conditions and positive observations and record them accurately.',
    94: 'Close corrective actions with clear ownership, due dates and verification.',
    95: 'Supervisors lead by example, verify controls and intervene early on unsafe work.',
    96: 'Ensure workers understand their right and responsibility to stop unsafe work.',
    97: 'Apply site rules consistently and address unsafe behavior before escalation.',
    98: 'Give new workers clear induction, task hazards, emergency information and supervision.',
    99: 'Build teamwork through open reporting, mutual support and shared safety ownership.',
    100: 'Reinforce the commitment that production never overrides critical safety controls.',
  };
  return focus[id] ?? 'Discuss the specific hazards, controls and safe work expectations for $title at today’s work location.';
}

List<String> _discussionQuestionsFor(int id, String title) {
  const questions = <int, List<String>>{
    1: ['What are today’s highest-risk activities?', 'What condition would make you stop the job?', 'Who must be informed when a hazard is found?'],
    2: ['What PPE is mandatory for this task?', 'How do you inspect it before use?', 'When must damaged PPE be replaced?'],
    3: ['Where are the fall hazards today?', 'What fall-prevention controls are installed?', 'What is the rescue arrangement?'],
    11: ['Is there an approved lifting plan?', 'Are the lifting accessories inspected and suitable?', 'Who controls the exclusion zone?'],
    21: ['What is the energy source?', 'Has isolation been verified?', 'What should you do if an electrical defect is found?'],
    24: ['Is a hot-work permit required?', 'Where is the fire watch?', 'What combustible materials must be removed or protected?'],
    31: ['Is entry authorized?', 'What atmospheric hazards could exist?', 'How will rescue be initiated?'],
    41: ['Are underground services confirmed?', 'What protective system is approved?', 'When must the excavation be re-inspected?'],
    51: ['What are today’s heat conditions?', 'Where are water, shade and rest areas?', 'What symptoms require immediate action?'],
    64: ['Which PTW applies?', 'What isolations and precautions are listed?', 'What changes require the permit to be reviewed?'],
    67: ['What is Stop Work Authority?', 'Can every worker use it?', 'Who must be notified after stopping work?'],
    71: ['What marine interface hazards exist today?', 'What exclusion zones are required?', 'What is the emergency response route?'],
    90: ['How often must the lone worker check in?', 'What communication device is required?', 'What happens if contact is lost?'],
  };
  return questions[id] ??
      ['What are the main hazards for $title today?', 'Which controls must be verified before starting?', 'What should you do if conditions become unsafe?'];
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
    meetingFocus: _meetingFocusFor(id, title),
    discussionQuestions: _discussionQuestionsFor(id, title),
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
