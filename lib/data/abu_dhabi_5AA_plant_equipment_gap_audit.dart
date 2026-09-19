// SafeNexus HSE — Abu Dhabi HSE Reference
// Step 5AA — Plant & Equipment / Remaining Critical Equipment Audit
//
// Purpose:
// Consolidated minimum-file registry for auditing remaining critical plant and
// equipment after the detailed 5S–5Z modules.
// This file is an AUDIT / GAP REGISTRY, not a replacement for detailed Gold
// Standard equipment modules.
//
// Regulatory baseline:
// ADPHC CoP 36.0 — Plant & Equipment.
// Cross-reference applicable CoPs such as CoP 29.0 Excavation Work,
// CoP 33.0 Working On or Adjacent to a Road, CoP 34.0 Lifting Equipment
// & Accessories, CoP 38.0 Concrete Placing Equipment, CoP 39.0 Overhead
// & Underground Services, CoP 44.0 Traffic Management and Logistics,
// CoP 47.0 Machine Guarding, CoP 49.0 Compressed Gases & Air,
// CoP 51.0 Powered Lift Trucks, and other applicable requirements.
//
// IMPORTANT:
// - Verify the current official ADPHC/ADOSH-SF version before regulatory use.
// - Manufacturer instructions and project RAMS/JSA remain essential.
// - Do not treat this registry as evidence that a topic is fully Gold Standard.
// - Numeric limits must be verified against the applicable current source.

enum PlantAuditStatus {
  existingDetailed,
  crossReference,
  candidateForGoldBuild,
  projectDependent,
  auditRequired,
}

class PlantEquipmentAuditItem {
  final String code;
  final String equipment;
  final String category;
  final PlantAuditStatus status;
  final String primaryBasis;
  final List<String> criticalChecks;
  final List<String> relatedTopics;
  final String decisionNote;

  const PlantEquipmentAuditItem({
    required this.code,
    required this.equipment,
    required this.category,
    required this.status,
    required this.primaryBasis,
    required this.criticalChecks,
    required this.relatedTopics,
    required this.decisionNote,
  });
}

class PlantEquipmentAuditSection {
  final String title;
  final List<String> points;

  const PlantEquipmentAuditSection({
    required this.title,
    required this.points,
  });
}

const List<PlantEquipmentAuditSection>
    abuDhabi5AAPlantEquipmentAuditSections = [
  PlantEquipmentAuditSection(
    title: '5AA.1 — Audit purpose',
    points: [
      'Audit the remaining critical plant and equipment after the detailed 5S–5Z modules.',
      'Prevent duplicate pages where an existing Gold Standard module already covers the equipment.',
      'Identify equipment requiring a dedicated book-level Gold Standard module.',
      'Separate common plant controls from equipment-specific controls.',
      'Keep the Abu Dhabi HSE Reference within the minimum-file architecture.',
    ],
  ),
  PlantEquipmentAuditSection(
    title: '5AA.2 — Audit method',
    points: [
      'Check whether the equipment already has a detailed Gold Standard module.',
      'Check whether the equipment is adequately covered by an existing cross-reference module.',
      'Check whether the equipment has a dedicated ADPHC CoP or is controlled primarily through CoP 36.0.',
      'Check task-specific interfaces such as lifting, excavation, traffic, electrical, hot work and underground services.',
      'Mark missing subjects for later Gold Standard expansion rather than creating duplicate content.',
    ],
  ),
  PlantEquipmentAuditSection(
    title: '5AA.3 — Universal plant controls',
    points: [
      'Equipment suitability and manufacturer instructions.',
      'Competent and authorised operator.',
      'Pre-use inspection and defect control.',
      'Planned preventive maintenance.',
      'Safety-critical devices and interlocks.',
      'Ground and work-area assessment.',
      'Pedestrian and vehicle segregation.',
      'Visibility and communication controls.',
      'Safe parking and isolation.',
      'Emergency response and recovery arrangements.',
      'RAMS/JSA and toolbox briefing where required.',
      'Stop-work authority for uncontrolled critical risk.',
    ],
  ),
  PlantEquipmentAuditSection(
    title: '5AA.4 — Decision rule',
    points: [
      'EXISTING DETAILED: do not create another full page; link to the existing Gold module.',
      'CROSS-REFERENCE: keep the equipment in the registry and link to the controlling topic.',
      'CANDIDATE FOR GOLD BUILD: create a detailed module only after scope and regulatory basis are confirmed.',
      'PROJECT-DEPENDENT: include in the master registry but expand only when relevant to the project/sector.',
      'AUDIT REQUIRED: verify the equipment, applicable CoP, manufacturer requirements and field use before locking.',
    ],
  ),
];

const List<PlantEquipmentAuditItem> abuDhabi5AAPlantEquipmentAuditRegistry = [
  PlantEquipmentAuditItem(
    code: '5S',
    equipment: 'Forklift / Powered Lift Trucks',
    category: 'Material Handling',
    status: PlantAuditStatus.existingDetailed,
    primaryBasis: 'ADPHC CoP 51.0 Powered Lift Trucks; also applicable CoP 36.0 plant controls.',
    criticalChecks: [
      'Rated capacity and load centre',
      'Forks, mast, chains and attachment locking',
      'Seat restraint and safety devices',
      'Pre-use inspection and defect isolation',
      'Pedestrian segregation and reversing controls',
      'Charging/fuelling arrangements',
    ],
    relatedTopics: ['Traffic Management', 'Lifting', 'Material Handling'],
    decisionNote: 'Already covered by the detailed 5S module.',
  ),
  PlantEquipmentAuditItem(
    code: '5T',
    equipment: 'Telehandler / Telescopic Handler',
    category: 'Material Handling / Mobile Plant',
    status: PlantAuditStatus.existingDetailed,
    primaryBasis: 'ADPHC CoP 36.0 Plant & Equipment and applicable attachment/lifting requirements.',
    criticalChecks: [
      'Correct load chart',
      'Attachment compatibility and locking',
      'Boom condition and hydraulic systems',
      'Ground stability',
      'Load radius and centre of gravity',
      'Pedestrian exclusion',
    ],
    relatedTopics: ['Lifting', 'Traffic Management', 'Ground Conditions'],
    decisionNote: 'Already covered by the detailed 5T module.',
  ),
  PlantEquipmentAuditItem(
    code: '5U',
    equipment: 'Excavator / Hydraulic Excavator',
    category: 'Earthmoving',
    status: PlantAuditStatus.existingDetailed,
    primaryBasis: 'CoP 36.0, CoP 29.0 Excavation Work and CoP 39.0 Overhead & Underground Services.',
    criticalChecks: [
      'Underground service verification',
      'Excavation edge stability',
      'Swing radius exclusion',
      'Attachment and quick-hitch locking',
      'Hydraulic condition',
      'Spoil and material placement',
    ],
    relatedTopics: ['Excavation', 'Underground Services', 'Traffic'],
    decisionNote: 'Already covered by the detailed 5U module.',
  ),
  PlantEquipmentAuditItem(
    code: '5V',
    equipment: 'Backhoe Loader',
    category: 'Earthmoving',
    status: PlantAuditStatus.existingDetailed,
    primaryBasis: 'CoP 36.0, CoP 29.0 and CoP 39.0 as applicable.',
    criticalChecks: [
      'Stabilisers and ground support',
      'Excavation edge control',
      'Swing and crush zones',
      'Loader bucket and attachment condition',
      'Service location',
      'Traffic/pedestrian segregation',
    ],
    relatedTopics: ['Excavation', 'Underground Services', 'Traffic'],
    decisionNote: 'Already covered by the detailed 5V module.',
  ),
  PlantEquipmentAuditItem(
    code: '5W',
    equipment: 'Wheel Loader',
    category: 'Earthmoving',
    status: PlantAuditStatus.existingDetailed,
    primaryBasis: 'CoP 36.0 Plant & Equipment and applicable task controls.',
    criticalChecks: [
      'Articulation zone',
      'Bucket and linkage',
      'Tyres and brakes',
      'Stockpile stability',
      'Travel configuration',
      'Loading-zone segregation',
    ],
    relatedTopics: ['Traffic', 'Stockpile Safety', 'Material Handling'],
    decisionNote: 'Already covered by the detailed 5W module.',
  ),
  PlantEquipmentAuditItem(
    code: '5X',
    equipment: 'Bobcat / Skid Steer Loader',
    category: 'Compact Mobile Plant',
    status: PlantAuditStatus.existingDetailed,
    primaryBasis: 'CoP 36.0 Plant & Equipment and manufacturer-specific controls.',
    criticalChecks: [
      'Interlocks',
      'Seat restraint',
      'Loader-arm support for maintenance',
      'Attachment locking',
      'Blind-spot segregation',
      'Carbon monoxide control where relevant',
    ],
    relatedTopics: ['Machine Guarding', 'Attachments', 'Maintenance Isolation'],
    decisionNote: 'Already covered by the detailed 5X module.',
  ),
  PlantEquipmentAuditItem(
    code: '5Y',
    equipment: 'Bulldozer',
    category: 'Earthmoving',
    status: PlantAuditStatus.existingDetailed,
    primaryBasis: 'CoP 36.0 Plant & Equipment and applicable earthmoving/ground controls.',
    criticalChecks: [
      'Blade condition',
      'Track system',
      'Slope and edge stability',
      'Rollover protection',
      'Reversing controls',
      'Maintenance isolation',
    ],
    relatedTopics: ['Excavation', 'Traffic', 'Ground Stability'],
    decisionNote: 'Already covered by the detailed 5Y module.',
  ),
  PlantEquipmentAuditItem(
    code: '5Z',
    equipment: 'Motor Grader',
    category: 'Earthmoving / Road Works',
    status: PlantAuditStatus.existingDetailed,
    primaryBasis: 'CoP 36.0 and applicable road/traffic controls.',
    criticalChecks: [
      'Blade and sideshift',
      'Articulation zone',
      'Steering and brakes',
      'Road traffic segregation',
      'Edge/embankment stability',
      'Visibility and dust controls',
    ],
    relatedTopics: ['CoP 33.0 Road Work', 'CoP 44.0 Traffic Management'],
    decisionNote: 'Already covered by the detailed 5Z module.',
  ),
  PlantEquipmentAuditItem(
    code: '5AA-01',
    equipment: 'Dump Truck / Tipper',
    category: 'Haulage / Earthmoving',
    status: PlantAuditStatus.candidateForGoldBuild,
    primaryBasis: 'CoP 36.0 Plant & Equipment; traffic and task-specific requirements.',
    criticalChecks: [
      'Reversing and blind spots',
      'Tipper body locking/support',
      'Overhead clearance',
      'Loading stability',
      'Ground and edge conditions',
      'Pedestrian segregation',
      'Unloading-area stability',
    ],
    relatedTopics: ['Traffic', 'Earthworks', 'Working Near Edges'],
    decisionNote: 'High-priority candidate for dedicated Gold Standard treatment.',
  ),
  PlantEquipmentAuditItem(
    code: '5AA-02',
    equipment: 'Articulated Dump Truck',
    category: 'Haulage / Earthmoving',
    status: PlantAuditStatus.candidateForGoldBuild,
    primaryBasis: 'CoP 36.0 Plant & Equipment; manufacturer operating limits.',
    criticalChecks: [
      'Articulation crush zone',
      'Rollover stability',
      'Payload control',
      'Gradient and ground conditions',
      'Dumping edge controls',
      'Traffic segregation',
    ],
    relatedTopics: ['Traffic', 'Earthworks', 'Ground Stability'],
    decisionNote: 'Treat separately from rigid dump trucks where operating characteristics differ materially.',
  ),
  PlantEquipmentAuditItem(
    code: '5AA-03',
    equipment: 'Rigid Dump Truck',
    category: 'Haulage / Earthmoving',
    status: PlantAuditStatus.candidateForGoldBuild,
    primaryBasis: 'CoP 36.0 Plant & Equipment; traffic and site logistics requirements.',
    criticalChecks: [
      'Payload and centre of gravity',
      'Brake/steering condition',
      'Dump-body controls',
      'Reversing systems',
      'Dumping-edge stability',
      'Cab access and restraint',
    ],
    relatedTopics: ['Traffic Management', 'Earthworks'],
    decisionNote: 'Candidate for a consolidated haul-truck module with articulated dump truck if content remains clear.',
  ),
  PlantEquipmentAuditItem(
    code: '5AA-04',
    equipment: 'Roller / Compactor',
    category: 'Road Works / Compaction',
    status: PlantAuditStatus.candidateForGoldBuild,
    primaryBasis: 'CoP 36.0 Plant & Equipment; applicable traffic and vibration controls.',
    criticalChecks: [
      'Rollover protection',
      'Drum condition',
      'Reversing visibility',
      'Edge stability',
      'Vibration exposure',
      'Pedestrian segregation',
    ],
    relatedTopics: ['Occupational Vibration', 'Traffic', 'Ground Stability'],
    decisionNote: 'High-value road/construction equipment topic.',
  ),
  PlantEquipmentAuditItem(
    code: '5AA-05',
    equipment: 'Road / Asphalt Paver',
    category: 'Road Works',
    status: PlantAuditStatus.candidateForGoldBuild,
    primaryBasis: 'CoP 36.0 Plant & Equipment and applicable road-work controls.',
    criticalChecks: [
      'Hot material exposure',
      'Auger and conveyor guarding',
      'Burn hazards',
      'Traffic interface',
      'Operator access',
      'Emergency stop controls',
    ],
    relatedTopics: ['Hot Work/Heat', 'Machine Guarding', 'Road Traffic'],
    decisionNote: 'Candidate for Gold Standard module because of mechanical, thermal and traffic interfaces.',
  ),
  PlantEquipmentAuditItem(
    code: '5AA-06',
    equipment: 'Trencher',
    category: 'Excavation Equipment',
    status: PlantAuditStatus.candidateForGoldBuild,
    primaryBasis: 'CoP 36.0, CoP 29.0 Excavation Work and CoP 39.0 Services.',
    criticalChecks: [
      'Service location',
      'Cutting chain/rotor guarding',
      'Trench stability',
      'Spoil placement',
      'Exclusion zone',
      'Attachment isolation',
    ],
    relatedTopics: ['Excavation', 'Underground Services', 'Machine Guarding'],
    decisionNote: 'High-risk specialist excavation equipment; dedicated treatment recommended.',
  ),
  PlantEquipmentAuditItem(
    code: '5AA-07',
    equipment: 'Piling / Pile Driving Equipment',
    category: 'Specialist Construction Plant',
    status: PlantAuditStatus.projectDependent,
    primaryBasis: 'CoP 36.0 and applicable lifting, noise, vibration, temporary works and project requirements.',
    criticalChecks: [
      'Rig stability',
      'Pile handling',
      'Dropped-object controls',
      'Noise and vibration',
      'Exclusion zones',
      'Overhead/underground services',
    ],
    relatedTopics: ['Lifting', 'Noise', 'Vibration', 'Temporary Works'],
    decisionNote: 'Expand when piling is within project/sector scope; retain in master registry.',
  ),
  PlantEquipmentAuditItem(
    code: '5AA-08',
    equipment: 'Drilling Rig / Ground Drilling Equipment',
    category: 'Specialist Construction Plant',
    status: PlantAuditStatus.projectDependent,
    primaryBasis: 'CoP 36.0, CoP 39.0 and applicable project drilling requirements.',
    criticalChecks: [
      'Rig stability',
      'Rotating parts and guarding',
      'Drill string handling',
      'Underground services',
      'High-pressure systems',
      'Exclusion zone',
    ],
    relatedTopics: ['Machine Guarding', 'Underground Services', 'Lifting'],
    decisionNote: 'Project-dependent but important for civil, geotechnical and oil & gas work.',
  ),
  PlantEquipmentAuditItem(
    code: '5AA-09',
    equipment: 'Water Tanker',
    category: 'Site Logistics / Mobile Plant',
    status: PlantAuditStatus.candidateForGoldBuild,
    primaryBasis: 'CoP 36.0 and applicable road/traffic and liquid-handling controls.',
    criticalChecks: [
      'Tank integrity',
      'Vehicle stability',
      'Hose/connection condition',
      'Reversing controls',
      'Water spray visibility',
      'Traffic segregation',
    ],
    relatedTopics: ['Traffic', 'Vehicle Safety', 'Dust Control'],
    decisionNote: 'Include because water tankers are common in UAE construction and dust-control operations.',
  ),
  PlantEquipmentAuditItem(
    code: '5AA-10',
    equipment: 'Vacuum Excavator',
    category: 'Specialist Excavation Equipment',
    status: PlantAuditStatus.projectDependent,
    primaryBasis: 'CoP 29.0, CoP 39.0 and CoP 36.0 as applicable.',
    criticalChecks: [
      'Service verification',
      'Suction hose integrity',
      'Vacuum pressure controls',
      'Material discharge',
      'Noise/dust',
      'Exclusion zone',
    ],
    relatedTopics: ['Excavation', 'Underground Services', 'Noise'],
    decisionNote: 'Useful specialist control module for safe excavation around sensitive services.',
  ),
  PlantEquipmentAuditItem(
    code: '5AA-11',
    equipment: 'Mobile Compressor',
    category: 'Pressure / Utility Equipment',
    status: PlantAuditStatus.candidateForGoldBuild,
    primaryBasis: 'CoP 36.0 and CoP 49.0 Compressed Gases & Air where applicable.',
    criticalChecks: [
      'Pressure system integrity',
      'Hoses and couplings',
      'Guards',
      'Relief/protection devices',
      'Noise',
      'Hot surfaces',
      'Fuel/exhaust controls',
    ],
    relatedTopics: ['Compressed Air', 'Pressure Systems', 'Noise'],
    decisionNote: 'High-use equipment with pressure, mechanical, noise and stored-energy hazards.',
  ),
  PlantEquipmentAuditItem(
    code: '5AA-12',
    equipment: 'Generator / Portable Generator',
    category: 'Temporary Power',
    status: PlantAuditStatus.candidateForGoldBuild,
    primaryBasis: 'CoP 15.0 Electrical Safety, CoP 36.0 Plant & Equipment and applicable environmental controls.',
    criticalChecks: [
      'Earthing/grounding',
      'Electrical protection',
      'Cable condition',
      'Fuel and fire controls',
      'Exhaust/ventilation',
      'Noise',
      'Isolation',
    ],
    relatedTopics: ['Electrical Safety', 'Hot Work', 'Fire', 'Noise'],
    decisionNote: 'Should be linked tightly with the Electricity on Site & Electrical Tools module.',
  ),
  PlantEquipmentAuditItem(
    code: '5AA-13',
    equipment: 'Welding Generator / Engine-Driven Welder',
    category: 'Hot Work / Temporary Power',
    status: PlantAuditStatus.crossReference,
    primaryBasis: 'CoP 28.0 Hot Work Operations, CoP 15.0 Electrical Safety and CoP 36.0.',
    criticalChecks: [
      'Welding leads and connections',
      'Earthing',
      'Fuel/fire control',
      'Hot-work permit',
      'Gas-cylinder separation where applicable',
      'Ventilation',
    ],
    relatedTopics: ['Hot Work', 'Electrical Safety', 'Fire'],
    decisionNote: 'Do not duplicate the hot-work book; cross-reference the hot-work and electrical modules.',
  ),
  PlantEquipmentAuditItem(
    code: '5AA-14',
    equipment: 'Tower Crane',
    category: 'Lifting Equipment',
    status: PlantAuditStatus.crossReference,
    primaryBasis: 'CoP 34.0 Lifting Equipment & Accessories and applicable CoP 36.0 requirements.',
    criticalChecks: [
      'Foundation/base',
      'Configuration and load chart',
      'Assembly/dismantling',
      'Lifting accessories',
      'Wind/weather limits',
      'Overhead/underground interface',
    ],
    relatedTopics: ['Crane & Lifting', 'Temporary Works', 'Wind'],
    decisionNote: 'Remain under the consolidated Crane & Lifting module; no duplicate 5AA book required.',
  ),
  PlantEquipmentAuditItem(
    code: '5AA-15',
    equipment: 'Manlift / Mast Climber',
    category: 'Access Equipment',
    status: PlantAuditStatus.crossReference,
    primaryBasis: 'CoP 36.0 and applicable working-at-height/MEWP requirements.',
    criticalChecks: [
      'Platform guarding',
      'Emergency lowering',
      'Anchorage/restraint where required',
      'Inspection',
      'Ground stability',
      'Overhead clearance',
    ],
    relatedTopics: ['MEWP', 'Working at Height'],
    decisionNote: 'Cross-reference existing MEWP and Working at Height Gold modules unless project-specific equipment warrants expansion.',
  ),
  PlantEquipmentAuditItem(
    code: '5AA-16',
    equipment: 'Concrete Pump',
    category: 'Concrete Placing Equipment',
    status: PlantAuditStatus.crossReference,
    primaryBasis: 'ADPHC CoP 38.0 Concrete Placing Equipment and CoP 36.0.',
    criticalChecks: [
      'Pipeline and coupling condition',
      'Hose whip control',
      'Outrigger/ground stability',
      'Blockage response',
      'Exclusion zone',
      'Cleaning/isolation',
    ],
    relatedTopics: ['Concreting', 'Lifting', 'Temporary Works'],
    decisionNote: 'Cross-reference the existing Concreting/Concrete Placing module rather than duplicate.',
  ),
  PlantEquipmentAuditItem(
    code: '5AA-17',
    equipment: 'Compactor / Plate Compactor',
    category: 'Compaction Equipment',
    status: PlantAuditStatus.candidateForGoldBuild,
    primaryBasis: 'CoP 36.0 and applicable vibration/noise controls.',
    criticalChecks: [
      'Hand-arm vibration',
      'Noise',
      'Guarding',
      'Fuel/electrical condition',
      'Manual handling',
      'Work-area segregation',
    ],
    relatedTopics: ['Manual Handling', 'Vibration', 'Noise'],
    decisionNote: 'Can be consolidated with Roller/Compaction Equipment if the resulting module remains sufficiently detailed.',
  ),
  PlantEquipmentAuditItem(
    code: '5AA-18',
    equipment: 'Road Cutter / Concrete Cutter',
    category: 'Cutting Equipment',
    status: PlantAuditStatus.crossReference,
    primaryBasis: 'CoP 35.0 Portable Power Tools, CoP 47.0 Machine Guarding and applicable road-work controls.',
    criticalChecks: [
      'Blade condition',
      'Guarding',
      'Dust suppression',
      'Electrical/fuel safety',
      'Noise',
      'Underground services',
    ],
    relatedTopics: ['Portable Power Tools', 'Machine Guarding', 'Road Work'],
    decisionNote: 'Cross-reference the Power Tools module unless the project requires a dedicated cutting-equipment chapter.',
  ),
  PlantEquipmentAuditItem(
    code: '5AA-19',
    equipment: 'Specialist / Sector-Specific Plant',
    category: 'Oil & Gas / Offshore / Industrial',
    status: PlantAuditStatus.auditRequired,
    primaryBasis: 'CoP 36.0 plus sector-specific regulatory, client and manufacturer requirements.',
    criticalChecks: [
      'Equipment-specific competency',
      'Hazardous-area suitability where applicable',
      'Lifting/handling interface',
      'Energy isolation',
      'Emergency response',
      'Inspection and certification',
    ],
    relatedTopics: ['Oil & Gas HSE', 'Offshore HSE', 'Industrial HSE'],
    decisionNote: 'Keep as a controlled expansion point; do not invent equipment requirements before project/sector scope is confirmed.',
  ),
];

const List<String> abuDhabi5AAHighPriorityGoldCandidates = [
  'Dump Truck / Tipper',
  'Articulated Dump Truck',
  'Rigid Dump Truck',
  'Roller / Compactor',
  'Road / Asphalt Paver',
  'Trencher',
  'Mobile Compressor',
  'Generator / Portable Generator',
];

const List<String> abuDhabi5AACrossReferenceOnly = [
  'Forklift / Powered Lift Trucks',
  'Telehandler / Telescopic Handler',
  'Excavator / Hydraulic Excavator',
  'Backhoe Loader',
  'Wheel Loader',
  'Bobcat / Skid Steer Loader',
  'Bulldozer',
  'Motor Grader',
  'Tower Crane',
  'Manlift / Mast Climber',
  'Concrete Pump',
  'Welding Generator / Engine-Driven Welder',
  'Road Cutter / Concrete Cutter',
];

const List<String> abuDhabi5AAAuditClosureChecklist = [
  'Confirm every machine/equipment type used by the target project is represented.',
  'Confirm each item has one clear owner module and no duplicate full-content module.',
  'Confirm the applicable ADPHC CoP and current version for each regulated item.',
  'Confirm manufacturer-specific requirements are referenced where equipment behaviour is model-specific.',
  'Confirm lifting, electrical, excavation, traffic, hot work, working-at-height and underground-service interfaces are linked.',
  'Confirm competency, inspection, maintenance, certification and emergency requirements are addressed.',
  'Confirm project-dependent equipment is marked clearly rather than treated as universally applicable.',
  'Confirm all numeric limits are verified against the current applicable source before regulatory lock.',
  'Only after this audit should new Gold Standard equipment modules be added.',
];

const List<String> abuDhabi5AAGapAuditConclusion = [
  '5S–5Z are already covered by detailed Gold Standard modules.',
  'Tower crane, manlift/mast climber, concrete pump, welding generator and road cutter should remain cross-references rather than duplicate books.',
  'The highest-value remaining candidates are haulage trucks, compaction equipment, asphalt paving equipment, trenching equipment, compressors and generators.',
  'Specialist piling/drilling/vacuum-excavation equipment remains project/sector dependent and should be expanded when applicable.',
  'The 5AA registry is therefore the control point for remaining plant/equipment coverage before the next Gold Standard build.',
];
