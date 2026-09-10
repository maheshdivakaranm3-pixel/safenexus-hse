// ============================================================
// SafeNexus HSE
// TBT - Toolbox Talk Data
// 100 Ready-to-Use TBT Topics
// ============================================================

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
    required this.workerConfirmation,
  });
}

TbtTopic _makeTbt(
  int id,
  String title,
  String category,
  String focus,
  List<String> hazards,
  List<String> controls,
  List<String> ppe,
) {
  return TbtTopic(
    id: id,
    title: title,
    category: category,
    objective:
        'Discuss the hazards and safe working requirements associated with $focus. '
        'Workers must understand the task risks, controls and site requirements before starting work.',
    keyHazards: hazards,
    requiredControls: controls,
    ppe: ppe,
    beforeStarting: [
      'Review the task risk assessment, method statement and applicable permit requirements.',
      'Inspect the work area and identify changes, new hazards or conflicting activities.',
      'Confirm that workers are competent, briefed and fit for the assigned task.',
      'Check that required tools, equipment and protective systems are suitable and inspected.',
      'Confirm communication, access, emergency arrangements and exclusion zones where required.',
    ],
    safeWorkPractices: [
      'Follow the approved safe work procedure and never bypass safety controls.',
      'Keep the work area orderly and maintain safe access and escape routes.',
      'Use only inspected and suitable tools and equipment.',
      'Maintain effective communication with the work team and stop if conditions become unsafe.',
      'Report hazards, near misses, defects and unsafe conditions immediately.',
    ],
    emergencyResponse: [
      'Stop work and make the area safe when an emergency or serious hazard is identified.',
      'Raise the alarm and inform the supervisor or site emergency team.',
      'Follow the site emergency procedure and proceed to the designated assembly point when required.',
      'Provide first aid only when trained and safe to do so.',
      'Do not disturb an incident scene unnecessarily; preserve information for investigation.',
    ],
    supervisorPoints: [
      'What are the main hazards for today’s task?',
      'Which controls must be in place before work starts?',
      'What changes in the work area could increase the risk?',
      'Are all workers aware of the emergency and stop-work arrangements?',
      'Does anyone have a safety concern or require clarification?',
    ],
    workerConfirmation:
        'I understand the hazards, required controls and safe working requirements for this task. '
        'I will follow the site procedure and stop work if conditions become unsafe.',
  );
}

const List<TbtTopic> tbtTopics = [
  // ==========================================================
  // 1 - 10 : GENERAL / PPE
  // ==========================================================

  _makeTbt(
    1,
    'General Safety Toolbox Talk',
    'General Safety',
    'general workplace safety',
    [
      'Unidentified workplace hazards',
      'Unsafe acts and conditions',
      'Poor housekeeping',
      'Inadequate communication',
    ],
    [
      'Complete task risk assessment',
      'Follow site HSE rules',
      'Maintain good housekeeping',
      'Use stop-work authority when necessary',
    ],
    ['Safety helmet', 'Safety footwear', 'High-visibility vest', 'Safety glasses'],
  ),

  _makeTbt(
    2,
    'Personal Protective Equipment (PPE)',
    'PPE',
    'correct selection and use of PPE',
    [
      'Incorrect PPE selection',
      'Damaged PPE',
      'Failure to wear PPE',
      'Improper PPE use',
    ],
    [
      'Select PPE according to task risk',
      'Inspect PPE before use',
      'Replace damaged PPE',
      'Wear PPE correctly throughout the task',
    ],
    ['Safety helmet', 'Safety glasses', 'Safety footwear', 'Gloves', 'High-visibility vest'],
  ),

  _makeTbt(
    3,
    'Work at Height',
    'Work at Height',
    'working at height',
    [
      'Falls from height',
      'Unprotected edges',
      'Falling objects',
      'Unsafe access equipment',
    ],
    [
      'Use approved fall protection',
      'Provide guardrails or other collective protection where required',
      'Inspect access equipment',
      'Establish exclusion zones below overhead work',
    ],
    ['Safety helmet', 'Full-body harness where required', 'Safety footwear', 'Gloves', 'Eye protection'],
  ),

  _makeTbt(
    4,
    'Scaffolding Safety',
    'Work at Height',
    'scaffold use and inspection',
    [
      'Scaffold collapse',
      'Falls from platforms',
      'Missing guardrails',
      'Overloading',
    ],
    [
      'Use approved and inspected scaffolds',
      'Maintain guardrails, toe boards and safe access',
      'Do not alter scaffolding without authorization',
      'Respect scaffold load limits',
    ],
    ['Safety helmet', 'Safety footwear', 'Gloves', 'Full-body harness where required'],
  ),

  _makeTbt(
    5,
    'Ladder Safety',
    'Work at Height',
    'safe ladder use',
    [
      'Falls',
      'Ladder slipping',
      'Overreaching',
      'Incorrect ladder selection',
    ],
    [
      'Use the correct ladder for the task',
      'Inspect ladder before use',
      'Secure the ladder where necessary',
      'Maintain three-point contact',
    ],
    ['Safety helmet', 'Safety footwear', 'Gloves', 'Eye protection'],
  ),

  _makeTbt(
    6,
    'Fall Prevention',
    'Work at Height',
    'prevention of falls',
    [
      'Open edges',
      'Floor openings',
      'Unprotected platforms',
      'Improper fall protection',
    ],
    [
      'Install physical barriers',
      'Cover or protect openings',
      'Use approved fall-arrest systems where required',
      'Keep access routes clear',
    ],
    ['Safety helmet', 'Safety footwear', 'Harness where required', 'Gloves'],
  ),

  _makeTbt(
    7,
    'Dropped Object Prevention',
    'Work at Height',
    'prevention of falling objects',
    [
      'Tools falling from height',
      'Loose materials',
      'Unsecured equipment',
      'People entering drop zones',
    ],
    [
      'Secure tools and materials',
      'Use tool lanyards where appropriate',
      'Establish exclusion zones',
      'Do not store loose materials near edges',
    ],
    ['Safety helmet', 'Safety footwear', 'Gloves', 'Eye protection'],
  ),

  _makeTbt(
    8,
    'Safe Access and Egress',
    'General Safety',
    'safe access and emergency escape',
    [
      'Blocked walkways',
      'Unsafe stairs',
      'Poor lighting',
      'Obstructed emergency exits',
    ],
    [
      'Keep routes clear',
      'Maintain adequate lighting',
      'Use designated access routes',
      'Keep emergency exits unobstructed',
    ],
    ['Safety footwear', 'High-visibility vest', 'Safety helmet'],
  ),

  _makeTbt(
    9,
    'Housekeeping',
    'General Safety',
    'workplace housekeeping',
    [
      'Trips and falls',
      'Blocked access',
      'Fire loading',
      'Poor material storage',
    ],
    [
      'Clean as work progresses',
      'Store materials correctly',
      'Remove waste regularly',
      'Keep emergency routes clear',
    ],
    ['Safety footwear', 'Gloves', 'Safety glasses'],
  ),

  _makeTbt(
    10,
    'Slips, Trips and Falls',
    'General Safety',
    'slip, trip and fall prevention',
    [
      'Wet surfaces',
      'Loose cables',
      'Uneven surfaces',
      'Poor housekeeping',
    ],
    [
      'Clean spills immediately',
      'Route cables safely',
      'Provide warning signs',
      'Maintain good housekeeping',
    ],
    ['Safety footwear', 'High-visibility vest'],
  ),

  // ==========================================================
  // 11 - 20 : LIFTING / EQUIPMENT
  // ==========================================================

  _makeTbt(
    11,
    'Lifting Operations',
    'Lifting',
    'planned lifting operations',
    [
      'Dropped loads',
      'Overloading',
      'Crush injuries',
      'Poor communication',
    ],
    [
      'Use an approved lifting plan where required',
      'Inspect lifting accessories',
      'Use competent lifting personnel',
      'Establish a controlled lifting zone',
    ],
    ['Safety helmet', 'Safety footwear', 'Gloves', 'High-visibility vest'],
  ),

  _makeTbt(
    12,
    'Crane Safety',
    'Lifting',
    'safe crane operations',
    [
      'Crane overturning',
      'Dropped load',
      'Contact with structures',
      'Overhead hazards',
    ],
    [
      'Confirm crane ground conditions',
      'Follow lifting plan and load chart',
      'Use competent operators and riggers',
      'Maintain required exclusion zones',
    ],
    ['Safety helmet', 'Safety footwear', 'Gloves', 'High-visibility vest'],
  ),

  _makeTbt(
    13,
    'Rigging Safety',
    'Lifting',
    'safe rigging practices',
    [
      'Failed lifting accessories',
      'Incorrect rigging',
      'Dropped loads',
      'Pinch points',
    ],
    [
      'Inspect slings and accessories',
      'Use correct lifting capacity',
      'Balance the load correctly',
      'Keep personnel clear of suspended loads',
    ],
    ['Safety helmet', 'Safety footwear', 'Gloves', 'Eye protection'],
  ),

  _makeTbt(
    14,
    'Banksman and Signaller Safety',
    'Lifting',
    'safe signalling and communication',
    [
      'Miscommunication',
      'Vehicle movement',
      'Blind spots',
      'Unexpected load movement',
    ],
    [
      'Use agreed hand signals',
      'Maintain clear communication',
      'Position safely with good visibility',
      'Stop the operation if communication is lost',
    ],
    ['Safety helmet', 'High-visibility vest', 'Safety footwear'],
  ),

  _makeTbt(
    15,
    'Mobile Crane Safety',
    'Lifting',
    'mobile crane operations',
    [
      'Unstable ground',
      'Overturning',
      'Power-line contact',
      'Load swing',
    ],
    [
      'Check ground bearing capacity',
      'Deploy stabilizers correctly',
      'Maintain safe clearance',
      'Follow the approved lifting plan',
    ],
    ['Safety helmet', 'Safety footwear', 'High-visibility vest', 'Gloves'],
  ),

  _makeTbt(
    16,
    'Forklift Safety',
    'Mobile Equipment',
    'safe forklift operation',
    [
      'Pedestrian collision',
      'Falling loads',
      'Overturning',
      'Poor visibility',
    ],
    [
      'Use authorized operators',
      'Follow site traffic routes',
      'Secure loads',
      'Maintain safe speed',
    ],
    ['Safety helmet', 'Safety footwear', 'High-visibility vest'],
  ),

  _makeTbt(
    17,
    'Heavy Equipment Safety',
    'Mobile Equipment',
    'heavy machinery operation',
    [
      'Struck-by incidents',
      'Blind spots',
      'Equipment rollover',
      'Unexpected movement',
    ],
    [
      'Use trained operators',
      'Conduct pre-use inspections',
      'Maintain exclusion zones',
      'Use spotters where required',
    ],
    ['Safety helmet', 'Safety footwear', 'High-visibility vest'],
  ),

  _makeTbt(
    18,
    'Vehicle and Traffic Safety',
    'Traffic Safety',
    'worksite vehicle movement',
    [
      'Vehicle-pedestrian collision',
      'Reversing incidents',
      'Speeding',
      'Poor traffic management',
    ],
    [
      'Follow site traffic plan',
      'Use designated pedestrian routes',
      'Use reversing controls and spotters where required',
      'Obey speed limits',
    ],
    ['Safety helmet', 'High-visibility vest', 'Safety footwear'],
  ),

  _makeTbt(
    19,
    'Reversing Safety',
    'Traffic Safety',
    'safe vehicle reversing',
    [
      'Blind spots',
      'Pedestrian contact',
      'Poor visibility',
      'Unexpected movement',
    ],
    [
      'Avoid reversing where practical',
      'Use a trained banksman where required',
      'Check the area before movement',
      'Use alarms and cameras where provided',
    ],
    ['High-visibility vest', 'Safety footwear', 'Safety helmet'],
  ),

  _makeTbt(
    20,
    'Manual Handling',
    'Ergonomics',
    'safe manual handling',
    [
      'Back injuries',
      'Muscle strain',
      'Falling objects',
      'Poor lifting technique',
    ],
    [
      'Assess load weight and shape',
      'Use mechanical assistance when possible',
      'Use correct lifting technique',
      'Ask for assistance with difficult loads',
    ],
    ['Safety footwear', 'Gloves', 'Back-support equipment only where approved'],
  ),

  // ==========================================================
  // 21 - 30 : ELECTRICAL / HOT WORK
  // ==========================================================

  _makeTbt(
    21,
    'Electrical Safety',
    'Electrical Safety',
    'electrical work and electrical hazards',
    [
      'Electric shock',
      'Arc flash',
      'Damaged cables',
      'Incorrect connections',
    ],
    [
      'Use competent electrical personnel',
      'Inspect cables and equipment',
      'Isolate energy before authorized work',
      'Protect temporary electrical installations',
    ],
    ['Safety helmet', 'Safety footwear', 'Safety glasses', 'Electrical PPE as required'],
  ),

  _makeTbt(
    22,
    'Lockout Tagout (LOTO)',
    'Electrical Safety',
    'energy isolation and lockout',
    [
      'Unexpected startup',
      'Stored energy',
      'Electric shock',
      'Release of hazardous energy',
    ],
    [
      'Identify all energy sources',
      'Isolate and lock the equipment',
      'Verify zero energy before work',
      'Only authorized persons remove locks',
    ],
    ['Safety helmet', 'Safety footwear', 'Safety glasses', 'Task-specific gloves'],
  ),

  _makeTbt(
    23,
    'Portable Electrical Tools',
    'Electrical Safety',
    'portable electrical tools',
    [
      'Electric shock',
      'Damaged plugs',
      'Cable damage',
      'Incorrect grounding',
    ],
    [
      'Inspect before use',
      'Remove damaged tools from service',
      'Use appropriate electrical protection',
      'Keep cables protected from damage',
    ],
    ['Safety glasses', 'Safety footwear', 'Gloves', 'Hearing protection where required'],
  ),

  _makeTbt(
    24,
    'Hot Work',
    'Hot Work',
    'welding, cutting and other hot work',
    [
      'Fire',
      'Burns',
      'Sparks',
      'Smoke and fumes',
    ],
    [
      'Use hot-work permit where required',
      'Remove or protect combustible materials',
      'Provide suitable fire extinguishing equipment',
      'Maintain fire watch where required',
    ],
    ['Welding helmet or face protection', 'Heat-resistant gloves', 'Safety footwear', 'Protective clothing'],
  ),

  _makeTbt(
    25,
    'Welding Safety',
    'Hot Work',
    'safe welding operations',
    [
      'Arc flash',
      'Burns',
      'Fumes',
      'Fire',
    ],
    [
      'Inspect welding equipment',
      'Provide suitable ventilation',
      'Protect nearby personnel from arc radiation',
      'Control combustible materials',
    ],
    ['Welding helmet', 'Welding gloves', 'Protective clothing', 'Safety footwear', 'Respiratory protection where required'],
  ),

  _makeTbt(
    26,
    'Grinding Safety',
    'Hot Work',
    'grinding operations',
    [
      'Flying particles',
      'Wheel failure',
      'Sparks',
      'Noise',
    ],
    [
      'Inspect grinding wheel and guard',
      'Use correct wheel for the equipment',
      'Maintain safe body position',
      'Control sparks and combustible materials',
    ],
    ['Face shield', 'Safety glasses', 'Hearing protection', 'Gloves', 'Safety footwear'],
  ),

  _makeTbt(
    27,
    'Cutting Operations',
    'Hot Work',
    'cutting activities',
    [
      'Cuts',
      'Sparks',
      'Fire',
      'Flying particles',
    ],
    [
      'Inspect cutting equipment',
      'Use guards and appropriate PPE',
      'Control sparks',
      'Maintain safe distance from others',
    ],
    ['Face protection', 'Safety glasses', 'Cut-resistant gloves', 'Safety footwear'],
  ),

  _makeTbt(
    28,
    'Fire Prevention',
    'Fire Safety',
    'fire prevention at the workplace',
    [
      'Ignition sources',
      'Combustible materials',
      'Poor storage',
      'Blocked fire equipment',
    ],
    [
      'Control ignition sources',
      'Store combustibles safely',
      'Maintain fire extinguishers',
      'Keep emergency routes clear',
    ],
    ['Safety helmet', 'Safety footwear', 'Safety glasses'],
  ),

  _makeTbt(
    29,
    'Fire Extinguisher Awareness',
    'Fire Safety',
    'basic fire extinguisher awareness',
    [
      'Incorrect extinguisher selection',
      'Delayed alarm',
      'Unsafe firefighting attempt',
    ],
    [
      'Raise alarm first',
      'Use extinguisher only when trained and safe',
      'Keep escape route behind you',
      'Evacuate when fire cannot be controlled safely',
    ],
    ['Safety footwear', 'Safety helmet', 'Task-specific fire PPE'],
  ),

  _makeTbt(
    30,
    'Emergency Evacuation',
    'Emergency',
    'emergency evacuation',
    [
      'Delayed evacuation',
      'Blocked exits',
      'Poor communication',
      'Missing personnel',
    ],
    [
      'Know alarm signals',
      'Know emergency exits',
      'Go to assembly point',
      'Follow emergency team instructions',
    ],
    ['Safety helmet where required', 'Safety footwear', 'High-visibility vest'],
  ),

  // ==========================================================
  // 31 - 40 : CONFINED SPACE / CHEMICAL
  // ==========================================================

  _makeTbt(
    31,
    'Confined Space Entry',
    'Confined Space',
    'confined space entry',
    [
      'Oxygen deficiency',
      'Toxic atmosphere',
      'Engulfment',
      'Difficult rescue',
    ],
    [
      'Use approved confined-space procedure',
      'Test atmosphere before and during entry as required',
      'Provide standby personnel and rescue arrangements',
      'Control entry and communication',
    ],
    ['Safety helmet', 'Safety footwear', 'Harness where required', 'Respiratory protection where required'],
  ),

  _makeTbt(
    32,
    'Gas Testing',
    'Confined Space',
    'atmospheric gas testing',
    [
      'Toxic gases',
      'Flammable atmosphere',
      'Low oxygen',
      'Incorrect instrument use',
    ],
    [
      'Use calibrated and suitable instruments',
      'Test according to the approved procedure',
      'Record results where required',
      'Stop work if readings become unsafe',
    ],
    ['Safety helmet', 'Safety footwear', 'Eye protection', 'Respiratory protection where required'],
  ),

  _makeTbt(
    33,
    'Confined Space Rescue',
    'Emergency',
    'confined-space rescue preparedness',
    [
      'Unplanned rescue',
      'Secondary victim',
      'Delayed response',
      'Inadequate rescue equipment',
    ],
    [
      'Have a rescue plan before entry',
      'Use trained rescue personnel',
      'Keep rescue equipment ready',
      'Never enter to rescue without proper authorization and protection',
    ],
    ['Safety helmet', 'Safety footwear', 'Harness', 'Respiratory protection as required'],
  ),

  _makeTbt(
    34,
    'Chemical Safety',
    'Chemical Safety',
    'safe chemical handling',
    [
      'Chemical exposure',
      'Spills',
      'Incompatible storage',
      'Fire or reaction',
    ],
    [
      'Read the SDS before use',
      'Use correct PPE',
      'Store chemicals correctly',
      'Control spills according to site procedure',
    ],
    ['Safety glasses', 'Chemical-resistant gloves', 'Safety footwear', 'Respiratory protection where required'],
  ),

  _makeTbt(
    35,
    'Hazardous Materials',
    'Chemical Safety',
    'hazardous material handling',
    [
      'Exposure',
      'Leaks',
      'Incorrect labeling',
      'Improper storage',
    ],
    [
      'Maintain correct labels',
      'Follow SDS requirements',
      'Use suitable storage areas',
      'Keep incompatible materials separated',
    ],
    ['Safety glasses', 'Chemical-resistant gloves', 'Safety footwear'],
  ),

  _makeTbt(
    36,
    'Chemical Spill Response',
    'Emergency',
    'chemical spill response',
    [
      'Skin contact',
      'Inhalation',
      'Fire',
      'Environmental contamination',
    ],
    [
      'Isolate the area',
      'Use the correct spill response procedure',
      'Wear suitable PPE',
      'Notify responsible personnel',
    ],
    ['Chemical-resistant gloves', 'Safety glasses', 'Protective clothing', 'Safety footwear'],
  ),

  _makeTbt(
    37,
    'SDS Awareness',
    'Chemical Safety',
    'Safety Data Sheet use',
    [
      'Unknown chemical hazards',
      'Incorrect PPE',
      'Incorrect emergency response',
    ],
    [
      'Ensure SDS is available',
      'Review hazards before use',
      'Follow storage and handling instructions',
      'Know first-aid and spill information',
    ],
    ['Task-specific PPE according to SDS'],
  ),

  _makeTbt(
    38,
    'Gas Cylinder Safety',
    'Chemical Safety',
    'gas cylinder handling and storage',
    [
      'Cylinder falling',
      'Gas leak',
      'Fire',
      'Incorrect connection',
    ],
    [
      'Secure cylinders upright',
      'Protect valves',
      'Use correct regulators and hoses',
      'Keep cylinders away from incompatible hazards',
    ],
    ['Safety helmet', 'Safety footwear', 'Gloves', 'Safety glasses'],
  ),

  _makeTbt(
    39,
    'Compressed Air Safety',
    'Equipment Safety',
    'compressed air use',
    [
      'Eye injury',
      'Hose failure',
      'Noise',
      'Air injection injury',
    ],
    [
      'Never direct compressed air at people',
      'Inspect hoses and connections',
      'Use correct pressure',
      'Secure connections',
    ],
    ['Safety glasses', 'Face protection where required', 'Hearing protection', 'Safety footwear'],
  ),

  _makeTbt(
    40,
    'Hand and Power Tools',
    'Equipment Safety',
    'safe use of hand and power tools',
    [
      'Cuts',
      'Flying particles',
      'Electric shock',
      'Unexpected tool movement',
    ],
    [
      'Use the correct tool',
      'Inspect tools before use',
      'Keep guards in place',
      'Remove defective tools from service',
    ],
    ['Safety glasses', 'Gloves', 'Safety footwear', 'Hearing protection where required'],
  ),

  // ==========================================================
  // 41 - 50 : EXCAVATION / CONSTRUCTION
  // ==========================================================

  _makeTbt(
    41,
    'Excavation Safety',
    'Excavation',
    'excavation and trenching',
    [
      'Collapse',
      'Underground services',
      'Falls into excavation',
      'Water accumulation',
    ],
    [
      'Complete excavation risk assessment',
      'Identify underground services',
      'Provide suitable protective systems',
      'Control access and edge protection',
    ],
    ['Safety helmet', 'Safety footwear', 'High-visibility vest', 'Gloves'],
  ),

  _makeTbt(
    42,
    'Trenching Safety',
    'Excavation',
    'trench work',
    [
      'Soil collapse',
      'Entrapment',
      'Falls',
      'Unsafe access',
    ],
    [
      'Provide appropriate trench protection',
      'Use safe access and egress',
      'Keep materials away from edges',
      'Inspect after changes or adverse conditions',
    ],
    ['Safety helmet', 'Safety footwear', 'High-visibility vest'],
  ),

  _makeTbt(
    43,
    'Underground Services',
    'Excavation',
    'working near underground utilities',
    [
      'Electric shock',
      'Gas release',
      'Water or service damage',
      'Explosion',
    ],
    [
      'Confirm service information before excavation',
      'Use approved detection and locating methods',
      'Follow permit requirements',
      'Use controlled excavation methods near services',
    ],
    ['Safety helmet', 'Safety footwear', 'High-visibility vest', 'Gloves'],
  ),

  _makeTbt(
    44,
    'Construction Site Safety',
    'Construction',
    'general construction activities',
    [
      'Multiple simultaneous hazards',
      'Falling objects',
      'Mobile equipment',
      'Poor housekeeping',
    ],
    [
      'Coordinate activities',
      'Maintain controlled work zones',
      'Follow approved construction procedures',
      'Conduct regular inspections',
    ],
    ['Safety helmet', 'Safety footwear', 'High-visibility vest', 'Safety glasses'],
  ),

  _makeTbt(
    45,
    'Concrete Work Safety',
    'Construction',
    'concrete work',
    [
      'Chemical burns',
      'Struck-by hazards',
      'Equipment movement',
      'Slips',
    ],
    [
      'Control concrete equipment',
      'Use suitable skin protection',
      'Maintain clean access',
      'Follow equipment operating procedures',
    ],
    ['Safety helmet', 'Safety glasses', 'Waterproof gloves', 'Safety footwear'],
  ),

  _makeTbt(
    46,
    'Formwork Safety',
    'Construction',
    'formwork installation and removal',
    [
      'Collapse',
      'Falling components',
      'Pinch points',
      'Falls',
    ],
    [
      'Follow approved formwork design',
      'Inspect before loading',
      'Control lifting and dismantling',
      'Keep unauthorized personnel away',
    ],
    ['Safety helmet', 'Safety footwear', 'Gloves', 'Eye protection'],
  ),

  _makeTbt(
    47,
    'Rebar Safety',
    'Construction',
    'reinforcement steel work',
    [
      'Cuts',
      'Impaling',
      'Manual handling injuries',
      'Trips',
    ],
    [
      'Protect exposed ends',
      'Use safe lifting methods',
      'Keep storage stable',
      'Maintain clear access',
    ],
    ['Safety helmet', 'Cut-resistant gloves', 'Safety footwear', 'Eye protection'],
  ),

  _makeTbt(
    48,
    'Demolition Safety',
    'Construction',
    'demolition activities',
    [
      'Structural collapse',
      'Falling materials',
      'Dust',
      'Unexpected services',
    ],
    [
      'Use approved demolition plan',
      'Establish exclusion zones',
      'Control dust',
      'Verify services and structural conditions',
    ],
    ['Safety helmet', 'Safety glasses', 'Safety footwear', 'Respiratory protection where required'],
  ),

  _makeTbt(
    49,
    'Material Storage',
    'General Safety',
    'safe storage and stacking',
    [
      'Falling materials',
      'Stack collapse',
      'Blocked access',
      'Manual handling injuries',
    ],
    [
      'Use stable stacking methods',
      'Respect storage limits',
      'Keep aisles clear',
      'Store incompatible materials correctly',
    ],
    ['Safety footwear', 'Safety helmet', 'Gloves'],
  ),

  _makeTbt(
    50,
    'Warehouse Safety',
    'Warehouse',
    'warehouse operations',
    [
      'Forklift collision',
      'Falling stock',
      'Manual handling',
      'Blocked aisles',
    ],
    [
      'Separate pedestrians and vehicles',
      'Maintain safe stacking',
      'Use correct lifting equipment',
      'Keep aisles and emergency exits clear',
    ],
    ['Safety footwear', 'High-visibility vest', 'Safety helmet', 'Gloves'],
  ),

  // ==========================================================
  // 51 - 60 : HEALTH / UAE CONDITIONS
  // ==========================================================

  _makeTbt(
    51,
    'Heat Stress Management',
    'Occupational Health',
    'heat stress prevention in hot conditions',
    [
      'Heat exhaustion',
      'Heat stroke',
      'Dehydration',
      'Reduced concentration',
    ],
    [
      'Follow site heat-stress controls',
      'Take scheduled rest periods',
      'Maintain hydration',
      'Use shaded or cooled recovery areas',
    ],
    ['Safety helmet', 'High-visibility vest', 'Safety footwear', 'Sun protection'],
  ),

  _makeTbt(
    52,
    'Dehydration Prevention',
    'Occupational Health',
    'hydration during work',
    [
      'Dehydration',
      'Fatigue',
      'Reduced alertness',
      'Heat illness',
    ],
    [
      'Drink water regularly',
      'Use designated hydration areas',
      'Report symptoms early',
      'Follow site heat-stress arrangements',
    ],
    ['Safety helmet', 'Safety footwear', 'Sun protection'],
  ),

  _makeTbt(
    53,
    'Working in Extreme Weather',
    'Occupational Health',
    'safe work during extreme weather',
    [
      'Heat',
      'Strong wind',
      'Dust',
      'Reduced visibility',
    ],
    [
      'Monitor site weather conditions',
      'Follow work-rest arrangements',
      'Suspend exposed activities when required',
      'Secure loose materials and equipment',
    ],
    ['Safety helmet', 'Safety footwear', 'Eye protection', 'High-visibility vest'],
  ),

  _makeTbt(
    54,
    'Dust and Respiratory Protection',
    'Occupational Health',
    'dust exposure',
    [
      'Respiratory exposure',
      'Eye irritation',
      'Reduced visibility',
      'Long-term health effects',
    ],
    [
      'Use dust suppression',
      'Improve ventilation',
      'Avoid unnecessary exposure',
      'Use suitable respiratory protection where required',
    ],
    ['Safety glasses', 'Respiratory protection where required', 'Safety footwear'],
  ),

  _makeTbt(
    55,
    'Noise Exposure',
    'Occupational Health',
    'workplace noise',
    [
      'Hearing damage',
      'Communication difficulty',
      'Reduced awareness',
    ],
    [
      'Identify noisy activities',
      'Use engineering or administrative controls',
      'Maintain safe distance where possible',
      'Wear hearing protection in designated areas',
    ],
    ['Hearing protection', 'Safety glasses', 'Safety footwear'],
  ),

  _makeTbt(
    56,
    'Ergonomics',
    'Occupational Health',
    'ergonomic risks',
    [
      'Musculoskeletal strain',
      'Awkward posture',
      'Repetitive movement',
      'Fatigue',
    ],
    [
      'Adjust work position',
      'Use mechanical assistance',
      'Rotate tasks where appropriate',
      'Take suitable recovery breaks',
    ],
    ['Safety footwear', 'Task-specific gloves'],
  ),

  _makeTbt(
    57,
    'Fatigue Management',
    'Occupational Health',
    'worker fatigue',
    [
      'Reduced concentration',
      'Slow reaction',
      'Poor decisions',
      'Increased incident risk',
    ],
    [
      'Report fatigue',
      'Use planned breaks',
      'Follow working-hour controls',
      'Do not operate equipment when unfit',
    ],
    ['Normal task PPE'],
  ),

  _makeTbt(
    58,
    'Night Shift Safety',
    'Occupational Health',
    'night work',
    [
      'Poor visibility',
      'Fatigue',
      'Reduced awareness',
      'Vehicle interaction',
    ],
    [
      'Provide adequate lighting',
      'Manage fatigue',
      'Use high-visibility clothing',
      'Maintain clear communication',
    ],
    ['High-visibility vest', 'Safety helmet', 'Safety footwear'],
  ),

  _makeTbt(
    59,
    'First Aid Awareness',
    'Emergency',
    'basic workplace first-aid awareness',
    [
      'Delayed treatment',
      'Incorrect first aid',
      'Poor emergency communication',
    ],
    [
      'Know first-aid locations',
      'Know trained first aiders',
      'Report injuries immediately',
      'Follow site emergency arrangements',
    ],
    ['Task-specific PPE'],
  ),

  _makeTbt(
    60,
    'Emergency Preparedness',
    'Emergency',
    'workplace emergency preparedness',
    [
      'Delayed response',
      'Poor communication',
      'Unclear responsibilities',
    ],
    [
      'Know emergency numbers',
      'Know alarm systems',
      'Know assembly points',
      'Participate in emergency drills',
    ],
    ['Safety helmet where required', 'Safety footwear', 'High-visibility vest'],
  ),

  // ==========================================================
  // 61 - 70 : RISK / PTW / REPORTING
  // ==========================================================

  _makeTbt(
    61,
    'Hazard Identification',
    'Risk Management',
    'hazard identification',
    [
      'Unrecognized hazards',
      'Changing work conditions',
      'Human error',
    ],
    [
      'Inspect before work',
      'Use worker input',
      'Review changes continuously',
      'Control identified hazards before proceeding',
    ],
    ['Task-specific PPE'],
  ),

  _makeTbt(
    62,
    'Risk Assessment',
    'Risk Management',
    'task risk assessment',
    [
      'Underestimating risk',
      'Missing hazards',
      'Inadequate controls',
    ],
    [
      'Identify hazards',
      'Assess risk',
      'Apply the hierarchy of controls',
      'Review assessment when conditions change',
    ],
    ['Task-specific PPE'],
  ),

  _makeTbt(
    63,
    'Job Safety Analysis (JSA)',
    'Risk Management',
    'JSA preparation and implementation',
    [
      'Missed task steps',
      'Unclear responsibilities',
      'Inadequate controls',
    ],
    [
      'Break the task into steps',
      'Identify hazards for each step',
      'Define controls',
      'Brief all involved workers',
    ],
    ['Task-specific PPE'],
  ),

  _makeTbt(
    64,
    'Permit to Work (PTW)',
    'Permit to Work',
    'permit-controlled work',
    [
      'Unauthorized work',
      'Missing controls',
      'Conflicting activities',
    ],
    [
      'Obtain required permit',
      'Understand permit conditions',
      'Display and maintain permit where required',
      'Stop work when permit conditions are no longer valid',
    ],
    ['Task-specific PPE'],
  ),

  _makeTbt(
    65,
    'Near Miss Reporting',
    'Incident Management',
    'near-miss reporting',
    [
      'Repeated unsafe conditions',
      'Failure to learn from events',
      'Unreported hazards',
    ],
    [
      'Report near misses promptly',
      'Provide accurate information',
      'Identify immediate controls',
      'Share lessons learned',
    ],
    ['Normal task PPE'],
  ),

  _makeTbt(
    66,
    'Incident Reporting',
    'Incident Management',
    'workplace incident reporting',
    [
      'Delayed reporting',
      'Loss of evidence',
      'Repeated incidents',
    ],
    [
      'Report incidents immediately',
      'Follow site notification procedure',
      'Protect the scene when safe',
      'Support investigation honestly',
    ],
    ['Normal task PPE'],
  ),

  _makeTbt(
    67,
    'Stop Work Authority',
    'Safety Leadership',
    'stop-work authority',
    [
      'Continuing unsafe work',
      'Pressure to meet schedule',
      'Uncontrolled hazards',
    ],
    [
      'Stop when serious risk is present',
      'Inform supervisor',
      'Correct the hazard before restarting',
      'Never discourage good-faith safety intervention',
    ],
    ['Normal task PPE'],
  ),

  _makeTbt(
    68,
    'Safety Communication',
    'Safety Leadership',
    'effective HSE communication',
    [
      'Misunderstanding',
      'Language barriers',
      'Incomplete instructions',
    ],
    [
      'Use clear language',
      'Confirm understanding',
      'Use visual communication where useful',
      'Encourage questions',
    ],
    ['Normal task PPE'],
  ),

  _makeTbt(
    69,
    'Toolbox Talk Participation',
    'Safety Leadership',
    'effective toolbox meetings',
    [
      'Passive participation',
      'Missed hazards',
      'Poor understanding',
    ],
    [
      'Discuss the actual task',
      'Encourage worker participation',
      'Review hazards and controls',
      'Confirm understanding before work',
    ],
    ['Normal task PPE'],
  ),

  _makeTbt(
    70,
    'Positive Safety Behaviour',
    'Safety Leadership',
    'positive safety behaviour',
    [
      'Unsafe shortcuts',
      'Peer pressure',
      'Poor safety culture',
    ],
    [
      'Lead by example',
      'Recognize safe behaviour',
      'Challenge unsafe acts respectfully',
      'Follow procedures consistently',
    ],
    ['Normal task PPE'],
  ),

  // ==========================================================
  // 71 - 80 : MARINE / ENVIRONMENT / ROADS
  // ==========================================================

  _makeTbt(
    71,
    'Marine and Port Safety',
    'Marine Safety',
    'marine and port operations',
    [
      'Falls into water',
      'Moving vehicles',
      'Lifting operations',
      'Restricted access',
    ],
    [
      'Follow port/site procedures',
      'Control vehicle and pedestrian movement',
      'Use life-saving equipment where required',
      'Maintain exclusion zones',
    ],
    ['Safety helmet', 'Safety footwear', 'High-visibility vest', 'Life jacket where required'],
  ),

  _makeTbt(
    72,
    'Working Near Water',
    'Marine Safety',
    'work near water',
    [
      'Drowning',
      'Slips',
      'Strong currents',
      'Unstable access',
    ],
    [
      'Provide edge protection where practicable',
      'Use suitable life-saving arrangements',
      'Maintain safe access',
      'Follow marine emergency procedures',
    ],
    ['Safety helmet', 'Safety footwear', 'Life jacket where required'],
  ),

  _makeTbt(
    73,
    'Road Work Safety',
    'Traffic Safety',
    'work near public or site roads',
    [
      'Vehicle collision',
      'Poor visibility',
      'Uncontrolled traffic',
    ],
    [
      'Use approved traffic management',
      'Provide barriers and signs',
      'Use trained traffic marshals where required',
      'Maintain worker visibility',
    ],
    ['High-visibility clothing', 'Safety helmet', 'Safety footwear'],
  ),

  _makeTbt(
    74,
    'Defensive Driving',
    'Traffic Safety',
    'defensive driving',
    [
      'Speeding',
      'Following too closely',
      'Distraction',
      'Fatigue',
    ],
    [
      'Follow speed limits',
      'Maintain safe following distance',
      'Avoid mobile-phone distraction',
      'Drive according to conditions',
    ],
    ['Seat belt required', 'High-visibility clothing when outside vehicle'],
  ),

  _makeTbt(
    75,
    'Pedestrian Safety',
    'Traffic Safety',
    'pedestrian movement around vehicles',
    [
      'Vehicle impact',
      'Blind spots',
      'Crossing active routes',
    ],
    [
      'Use designated walkways',
      'Make eye contact where appropriate',
      'Stay out of blind spots',
      'Follow site traffic controls',
    ],
    ['High-visibility vest', 'Safety helmet', 'Safety footwear'],
  ),

  _makeTbt(
    76,
    'Environmental Safety',
    'Environment',
    'environmental protection at work',
    [
      'Pollution',
      'Chemical release',
      'Improper disposal',
      'Dust and noise impacts',
    ],
    [
      'Prevent releases',
      'Use designated waste areas',
      'Control dust and emissions',
      'Report environmental incidents',
    ],
    ['Task-specific PPE'],
  ),

  _makeTbt(
    77,
    'Waste Management',
    'Environment',
    'safe waste handling',
    [
      'Cuts',
      'Chemical exposure',
      'Poor segregation',
      'Fire risk',
    ],
    [
      'Segregate waste correctly',
      'Use suitable containers',
      'Do not mix incompatible waste',
      'Maintain clean waste areas',
    ],
    ['Safety gloves', 'Safety footwear', 'Safety glasses'],
  ),

  _makeTbt(
    78,
    'Spill Prevention',
    'Environment',
    'prevention of oil and chemical spills',
    [
      'Soil contamination',
      'Water contamination',
      'Slip hazards',
      'Fire risk',
    ],
    [
      'Inspect containers',
      'Use secondary containment where required',
      'Keep spill kits available',
      'Report leaks immediately',
    ],
    ['Chemical-resistant gloves', 'Safety glasses', 'Safety footwear'],
  ),

  _makeTbt(
    79,
    'Fuel Handling Safety',
    'Environment',
    'safe fuel handling',
    [
      'Fire',
      'Spills',
      'Skin contact',
      'Vapour exposure',
    ],
    [
      'Keep ignition sources controlled',
      'Use approved containers',
      'Prevent spills',
      'Follow fuel handling procedures',
    ],
    ['Safety glasses', 'Chemical-resistant gloves', 'Safety footwear'],
  ),

  _makeTbt(
    80,
    'Environmental Incident Reporting',
    'Environment',
    'environmental incident reporting',
    [
      'Delayed response',
      'Pollution spread',
      'Incomplete reporting',
    ],
    [
      'Report immediately',
      'Stop the source when safe',
      'Protect drains and sensitive areas where applicable',
      'Follow site environmental response procedure',
    ],
    ['Task-specific PPE'],
  ),

  // ==========================================================
  // 81 - 90 : SPECIAL TASKS
  // ==========================================================

  _makeTbt(
    81,
    'Roof Work Safety',
    'Work at Height',
    'roof work',
    [
      'Falls through fragile surfaces',
      'Falls from edges',
      'Weather conditions',
    ],
    [
      'Identify fragile areas',
      'Use suitable edge protection',
      'Use approved access and fall protection',
      'Stop work during unsafe weather',
    ],
    ['Safety helmet', 'Safety footwear', 'Harness where required', 'Eye protection'],
  ),

  _makeTbt(
    82,
    'Fragile Roof Safety',
    'Work at Height',
    'work on fragile roofs',
    [
      'Fall through roof',
      'Unstable surfaces',
      'Poor access',
    ],
    [
      'Identify fragile surfaces before access',
      'Use approved walkways and protection',
      'Prevent unauthorized access',
      'Follow work-at-height controls',
    ],
    ['Safety helmet', 'Harness where required', 'Safety footwear'],
  ),

  _makeTbt(
    83,
    'Temporary Works Safety',
    'Construction',
    'temporary works',
    [
      'Structural failure',
      'Collapse',
      'Incorrect installation',
    ],
    [
      'Use approved temporary works design',
      'Follow installation requirements',
      'Inspect before loading',
      'Do not modify without authorization',
    ],
    ['Safety helmet', 'Safety footwear', 'Gloves'],
  ),

  _makeTbt(
    84,
    'Pressure Testing Safety',
    'Specialist Work',
    'pressure testing',
    [
      'Stored energy',
      'Component failure',
      'Flying parts',
      'Unexpected release',
    ],
    [
      'Use approved test procedure',
      'Establish exclusion zone',
      'Use calibrated equipment',
      'Never enter the danger zone during testing',
    ],
    ['Safety helmet', 'Safety glasses', 'Safety footwear', 'Face protection where required'],
  ),

  _makeTbt(
    85,
    'Pneumatic Tool Safety',
    'Equipment Safety',
    'pneumatic tools',
    [
      'Hose failure',
      'Flying particles',
      'Noise',
      'Unexpected movement',
    ],
    [
      'Inspect hoses and fittings',
      'Use correct operating pressure',
      'Secure connections',
      'Follow manufacturer instructions',
    ],
    ['Safety glasses', 'Hearing protection', 'Gloves', 'Safety footwear'],
  ),

  _makeTbt(
    86,
    'Hydraulic Equipment Safety',
    'Equipment Safety',
    'hydraulic equipment',
    [
      'High-pressure fluid injection',
      'Unexpected movement',
      'Hose failure',
      'Stored energy',
    ],
    [
      'Inspect hoses and connections',
      'Relieve pressure before authorized maintenance',
      'Keep clear of pressurized systems',
      'Use approved maintenance procedures',
    ],
    ['Safety glasses', 'Face protection where required', 'Gloves', 'Safety footwear'],
  ),

  _makeTbt(
    87,
    'Machine Guarding',
    'Equipment Safety',
    'machine guarding',
    [
      'Entanglement',
      'Crushing',
      'Cutting',
      'Unexpected startup',
    ],
    [
      'Keep guards installed',
      'Do not bypass interlocks',
      'Isolate before maintenance',
      'Report damaged guards',
    ],
    ['Safety glasses', 'Safety footwear', 'Task-specific gloves'],
  ),

  _makeTbt(
    88,
    'Maintenance Safety',
    'Maintenance',
    'maintenance activities',
    [
      'Unexpected startup',
      'Stored energy',
      'Chemical exposure',
      'Working at height',
    ],
    [
      'Use maintenance risk assessment',
      'Apply isolation controls',
      'Control access',
      'Use correct tools and PPE',
    ],
    ['Safety helmet', 'Safety footwear', 'Safety glasses', 'Task-specific gloves'],
  ),

  _makeTbt(
    89,
    'Cleaning and Maintenance Chemicals',
    'Chemical Safety',
    'cleaning chemical use',
    [
      'Chemical exposure',
      'Mixing incompatible chemicals',
      'Splashes',
    ],
    [
      'Read labels and SDS',
      'Never mix chemicals unless approved',
      'Use correct ventilation',
      'Store chemicals correctly',
    ],
    ['Safety glasses', 'Chemical-resistant gloves', 'Safety footwear'],
  ),

  _makeTbt(
    90,
    'Working Alone',
    'General Safety',
    'lone working',
    [
      'Delayed emergency response',
      'Communication failure',
      'Unexpected hazards',
    ],
    [
      'Follow lone-worker procedure',
      'Maintain reliable communication',
      'Use check-in arrangements',
      'Avoid high-risk work alone',
    ],
    ['Task-specific PPE', 'Communication device where required'],
  ),

  // ==========================================================
  // 91 - 100 : SAFETY CULTURE / DAILY OPERATIONS
  // ==========================================================

  _makeTbt(
    91,
    'Daily Safety Briefing',
    'Safety Leadership',
    'daily safety briefing',
    [
      'Unclear daily tasks',
      'Changing site conditions',
      'Poor coordination',
    ],
    [
      'Discuss the day’s activities',
      'Identify interfaces and hazards',
      'Confirm controls',
      'Allow workers to raise concerns',
    ],
    ['Normal task PPE'],
  ),

  _makeTbt(
    92,
    'Pre-Start Safety Meeting',
    'Safety Leadership',
    'pre-start meeting',
    [
      'Starting before controls are ready',
      'Poor coordination',
      'Equipment defects',
    ],
    [
      'Confirm permits',
      'Confirm equipment inspections',
      'Review task hazards',
      'Confirm competent personnel',
    ],
    ['Normal task PPE'],
  ),

  _makeTbt(
    93,
    'Safety Observation',
    'Safety Leadership',
    'workplace safety observations',
    [
      'Unsafe conditions',
      'Unsafe behaviour',
      'Missed positive practices',
    ],
    [
      'Observe work without creating additional risk',
      'Record hazards accurately',
      'Provide constructive feedback',
      'Track corrective actions',
    ],
    ['Normal task PPE'],
  ),

  _makeTbt(
    94,
    'Corrective Action Awareness',
    'Safety Leadership',
    'corrective actions',
    [
      'Unresolved hazards',
      'Repeated findings',
      'Poor follow-up',
    ],
    [
      'Assign responsible persons',
      'Set realistic completion dates',
      'Verify effectiveness',
      'Close actions only after verification',
    ],
    ['Normal task PPE'],
  ),

  _makeTbt(
    95,
    'Safety Leadership for Supervisors',
    'Safety Leadership',
    'supervisor safety leadership',
    [
      'Poor role modelling',
      'Inadequate communication',
      'Production pressure',
    ],
    [
      'Lead by example',
      'Conduct regular safety briefings',
      'Verify controls in the field',
      'Intervene early when unsafe conditions are observed',
    ],
    ['Normal task PPE'],
  ),

  _makeTbt(
    96,
    'Worker Right to Stop Unsafe Work',
    'Safety Leadership',
    'worker intervention and stop-work rights',
    [
      'Fear of reporting',
      'Unsafe continuation',
      'Uncontrolled risk',
    ],
    [
      'Encourage safety intervention',
      'Stop unsafe activity',
      'Discuss concerns with supervision',
      'Restart only after controls are confirmed',
    ],
    ['Normal task PPE'],
  ),

  _makeTbt(
    97,
    'Safety Rules and Site Discipline',
    'General Safety',
    'following site safety rules',
    [
      'Rule violations',
      'Shortcuts',
      'Unsafe behaviour',
    ],
    [
      'Follow site induction requirements',
      'Comply with mandatory controls',
      'Report unsafe practices',
      'Maintain professional safety behaviour',
    ],
    ['Normal task PPE'],
  ),

  _makeTbt(
    98,
    'HSE Awareness for New Workers',
    'General Safety',
    'new-worker HSE awareness',
    [
      'Lack of site familiarity',
      'Unknown emergency arrangements',
      'Unfamiliar hazards',
    ],
    [
      'Complete site induction',
      'Understand emergency procedures',
      'Work under appropriate supervision',
      'Ask questions before starting unfamiliar tasks',
    ],
    ['Safety helmet', 'Safety footwear', 'High-visibility vest', 'Safety glasses'],
  ),

  _makeTbt(
    99,
    'Safety Culture and Teamwork',
    'Safety Leadership',
    'positive safety culture and teamwork',
    [
      'Poor communication',
      'Unsafe peer influence',
      'Failure to support colleagues',
    ],
    [
      'Communicate openly',
      'Support safe behaviour',
      'Share lessons learned',
      'Treat safety as a team responsibility',
    ],
    ['Normal task PPE'],
  ),

  _makeTbt(
    100,
    '100% Safe Work Commitment',
    'Safety Leadership',
    'personal commitment to safe work',
    [
      'Complacency',
      'Shortcuts',
      'Ignoring changing conditions',
    ],
    [
      'Plan the work safely',
      'Follow approved controls',
      'Speak up about hazards',
      'Stop and reassess when conditions change',
    ],
    ['Normal task PPE'],
  ),
];
