
/// SafeNexus HSE
/// Abu Dhabi Scaffolding — Gold Standard content layer.
///
/// Regulatory backbone:
/// ADOSH-SF / ADPHC CoP 26.0 — Scaffolding, Version 4.1,
/// effective 27 February 2026.
///
/// NOTE:
/// This file is a field-reference content layer. Controlled regulatory
/// documents, approved project requirements, engineering design,
/// manufacturer instructions and competent-person decisions remain
/// authoritative for actual work.

class GoldFieldPoint {
  final String title;
  final Map<String, String> fields;

  const GoldFieldPoint({
    required this.title,
    required this.fields,
  });
}

class GoldSection {
  final String number;
  final String title;
  final String introduction;
  final List<GoldFieldPoint> points;

  const GoldSection({
    required this.number,
    required this.title,
    required this.introduction,
    required this.points,
  });
}

const scaffoldingGoldStandardSections = <GoldSection>[
  GoldSection(
    number: '01',
    title: 'Purpose, Scope & Application',
    introduction:
        'A scaffold is a temporary access and working-platform system. '
        'Safe performance depends on suitable selection, competent design, '
        'erection, inspection, use, alteration, maintenance and dismantling.',
    points: [
      GoldFieldPoint(
        title: 'Purpose',
        fields: {
          'Meaning / Detail':
              'Provide a stable temporary means of access and a safe working platform for persons and, where specifically designed, materials.',
          'Hazards / Consequences':
              'Falls from height, collapse, falling objects, unsafe access, overloading and uncontrolled modification.',
          'Control Measures':
              'Use a planned scaffold system suitable for the intended task, loading, geometry, environment and duration.',
          'Field HSE Check':
              'Confirm the scaffold is suitable for the actual work and has been inspected and released before use.',
          'Stop-Work Condition':
              'Stop use where the scaffold is incomplete, unstable, damaged, overloaded, uninspected or materially altered without authorization.',
        },
      ),
      GoldFieldPoint(
        title: 'Scope',
        fields: {
          'Meaning / Detail':
              'Apply the applicable Abu Dhabi scaffolding requirements to planning, assessment, design, erection, use, inspection, maintenance, alteration and dismantling.',
          'Records / Evidence':
              'Approved design where required, risk assessment, method statement, competency records, inspection records and handover documentation.',
          'Common Mistake':
              'Treating a scaffold as a simple access item and ignoring changes in load, geometry, weather or interfaces.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '02',
    title: 'Regulatory Basis & Document Control',
    introduction:
        'Use the current controlled Abu Dhabi requirements together with project and manufacturer requirements.',
    points: [
      GoldFieldPoint(
        title: 'Primary Abu Dhabi Reference',
        fields: {
          'Meaning / Detail':
              'ADOSH-SF / ADPHC Code of Practice 26.0 — Scaffolding, Version 4.1, effective 27 February 2026.',
          'Records / Evidence':
              'Keep access to the current controlled version applicable to the project.',
          'Field HSE Check':
              'Verify that project procedures and scaffold controls reference the current approved requirements.',
        },
      ),
      GoldFieldPoint(
        title: 'Related Working-at-Height Controls',
        fields: {
          'Meaning / Detail':
              'Scaffolding work interfaces with working-at-height controls. Apply the applicable working-at-height requirements, risk assessment and fall-protection arrangements.',
          'Control Measures':
              'Use collective protection wherever practicable and provide a suitable safe system for erection, alteration and dismantling.',
        },
      ),
      GoldFieldPoint(
        title: 'Hierarchy of Requirements',
        fields: {
          'Meaning / Detail':
              'Use the applicable law/regulatory requirement, approved project requirements, engineering design, manufacturer instructions and competent-person controls together. Where requirements differ, resolve them through the responsible competent/design authority rather than guessing.',
          'Common Mistake':
              'Copying a requirement from another emirate or international guide and presenting it as an Abu Dhabi statutory requirement.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '03',
    title: 'Roles, Competency & Supervision',
    introduction:
        'Scaffold safety depends on competent people performing clearly defined roles.',
    points: [
      GoldFieldPoint(
        title: 'Competent Scaffolder',
        fields: {
          'Meaning / Detail':
              'Erection, alteration and dismantling must be carried out by suitably trained and competent persons under the required supervision.',
          'Field HSE Check':
              'Verify competency records and that personnel understand the scaffold system and approved method.',
          'Common Mistake':
              'Allowing general construction workers to alter scaffold components because the change appears minor.',
          'Stop-Work Condition':
              'Stop unauthorized erection, alteration or dismantling.',
        },
      ),
      GoldFieldPoint(
        title: 'Competent Inspector',
        fields: {
          'Meaning / Detail':
              'Inspection must be performed by a person competent for the type and complexity of scaffold and the applicable inspection requirements.',
          'Records / Evidence':
              'Inspection record, handover information and scaffold identification/status.',
        },
      ),
      GoldFieldPoint(
        title: 'HSE Officer',
        fields: {
          'Meaning / Detail':
              'The HSE Officer verifies that the safe system is implemented, checks visible conditions, follows up defects and stops unsafe work within the project authority.',
          'Field HSE Check':
              'Check access, platforms, edge protection, stability, loading, tagging, housekeeping and interfaces.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '04',
    title: 'Planning & Risk Assessment',
    introduction:
        'Scaffold selection and configuration should follow a task-specific risk assessment.',
    points: [
      GoldFieldPoint(
        title: 'Pre-Planning Review',
        fields: {
          'Meaning / Detail':
              'Define height, location, intended users, working platform arrangement, loads, access, duration, interfaces, weather exposure and dismantling sequence before erection.',
          'Documents / Evidence':
              'Risk assessment, method statement/SWMS, approved design where required and manufacturer information.',
          'Field Procedure':
              'Survey the area; identify hazards and interfaces; select the system; confirm support and stability; establish erection and inspection arrangements.',
        },
      ),
      GoldFieldPoint(
        title: 'Interface Hazards',
        fields: {
          'Hazards / Consequences':
              'Electrical services, cranes, mobile plant, traffic, public areas, excavation edges, openings, adjacent structures and falling-object exposure.',
          'Control Measures':
              'Use exclusion zones, isolation where applicable, physical protection, competent supervision and task-specific controls.',
        },
      ),
      GoldFieldPoint(
        title: 'Weather Assessment',
        fields: {
          'Hazards / Consequences':
              'Strong wind, storms, rain, reduced visibility and environmental conditions can affect stability and safe access.',
          'Control Measures':
              'Include adverse-weather criteria in the risk assessment and inspect the scaffold after events that could affect stability.',
          'Stop-Work Condition':
              'Stop work where weather conditions make the scaffold or work-at-height system unsafe.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '05',
    title: 'Design & Engineering',
    introduction:
        'Scaffold design must match the intended use, geometry, loading, environment and stability requirements.',
    points: [
      GoldFieldPoint(
        title: 'Engineering Requirement',
        fields: {
          'Meaning / Detail':
              'Use competent engineering design where required by the applicable CoP, configuration, height, loading or non-standard arrangement.',
          'Field HSE Check':
              'Verify that the erected scaffold matches the approved design and that changes have been controlled.',
          'Stop-Work Condition':
              'Stop use where a required design/calculation is missing or the erected scaffold materially differs from the approved design.',
        },
      ),
      GoldFieldPoint(
        title: 'Non-Standard Configurations',
        fields: {
          'Meaning / Detail':
              'Special, suspended, freestanding, cantilevered, heavily screened or otherwise non-standard configurations require appropriate engineering and competent review.',
          'Common Mistake':
              'Adding sheeting, shade cloth, lifting arrangements or unusual loading without checking structural effects.',
        },
      ),
      GoldFieldPoint(
        title: 'Loading',
        fields: {
          'Meaning / Detail':
              'The scaffold must be designed and used for its intended duty and loads. Do not assume a general scaffold can carry stored materials, equipment or concentrated loads.',
          'Field HSE Check':
              'Check load classification/limits and prevent uncontrolled material accumulation.',
          'Stop-Work Condition':
              'Stop where the scaffold is overloaded or the actual use exceeds its approved design.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '06',
    title: 'Foundation, Base Support & Stability',
    introduction:
        'A sound foundation and stable load path are essential to prevent settlement, tilting and collapse.',
    points: [
      GoldFieldPoint(
        title: 'Ground Condition',
        fields: {
          'Hazards / Consequences':
              'Soft ground, voids, water, settlement, excavation edges and uncontrolled fill can compromise stability.',
          'Control Measures':
              'Verify bearing/support conditions and use suitable base arrangements, sole boards or other engineered measures as required.',
          'Field HSE Check':
              'Look for settlement, leaning, cracked support, displaced base plates and water undermining.',
        },
      ),
      GoldFieldPoint(
        title: 'Sole Boards and Base Plates',
        fields: {
          'Meaning / Detail':
              'Where required, provide suitable sole boards and base plates to distribute loads and maintain a stable base.',
          'Common Mistake':
              'Using loose blocks, unstable packing or damaged components as improvised supports.',
          'Stop-Work Condition':
              'Stop where bases are unstable, unsupported or visibly settling.',
        },
      ),
      GoldFieldPoint(
        title: 'Stability',
        fields: {
          'Control Measures':
              'Provide the designed ties, braces, standards, ledgers and other stability components. Do not remove stability components without authorized redesign/review.',
          'Field HSE Check':
              'Check ties and bracing are present, correctly positioned and secure.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '07',
    title: 'Erection & Progressive Construction',
    introduction:
        'Erection should follow the approved sequence and maintain protection as the scaffold progresses.',
    points: [
      GoldFieldPoint(
        title: 'Erection Sequence',
        fields: {
          'Field Procedure':
              'Establish the controlled work zone, prepare foundations, erect progressively, install stability components, provide safe access and edge protection, inspect and hand over before use.',
          'Control Measures':
              'Maintain exclusion zones below and around erection activities and prevent unauthorized access to incomplete scaffold.',
        },
      ),
      GoldFieldPoint(
        title: 'Fall Protection During Erection',
        fields: {
          'Hazards / Consequences':
              'Scaffolders can fall while working on incomplete platforms or installing components.',
          'Control Measures':
              'Use the approved safe system of work and appropriate collective or personal fall protection.',
          'Stop-Work Condition':
              'Stop if the planned erection method does not provide a safe means of protection.',
        },
      ),
      GoldFieldPoint(
        title: 'Incomplete Scaffold',
        fields: {
          'Control Measures':
              'Clearly identify incomplete or unavailable scaffold and physically prevent unauthorized use.',
          'Field HSE Check':
              'Check access points, barriers and status identification during erection and dismantling.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '08',
    title: 'Working Platforms & Boards',
    introduction:
        'Platforms must provide secure footing, suitable width and adequate support for the intended task.',
    points: [
      GoldFieldPoint(
        title: 'Platform Condition',
        fields: {
          'Control Measures':
              'Use suitable boards/components in good condition; secure them against movement and maintain a clear working surface.',
          'Common Mistake':
              'Using cracked, split, damaged or improvised boards.',
          'Stop-Work Condition':
              'Stop where platform integrity cannot be assured.',
        },
      ),
      GoldFieldPoint(
        title: 'Board Gaps',
        fields: {
          'Meaning / Detail':
              'The current Abu Dhabi CoP specifies limits for board gaps. The field inspector should verify the current controlled CoP/design rather than rely on an old checklist.',
          'Field HSE Check':
              'Inspect gaps, trip hazards and openings along the full platform.',
        },
      ),
      GoldFieldPoint(
        title: 'Platform Width',
        fields: {
          'Meaning / Detail':
              'Platform width must be suitable for the intended activity, number of persons, materials and access requirements and must comply with the applicable design/CoP.',
          'Common Mistake':
              'Reducing the platform width by removing boards to create space for pipes or equipment.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '09',
    title: 'Guardrails, Midrails, Toe Boards & Falling Objects',
    introduction:
        'Collective edge protection and falling-object controls are fundamental scaffold safeguards.',
    points: [
      GoldFieldPoint(
        title: 'Guardrails',
        fields: {
          'Control Measures':
              'Provide compliant top guardrails and intermediate protection as required for the working platform.',
          'Field HSE Check':
              'Check continuity, secure fixing, height and openings around all exposed edges.',
        },
      ),
      GoldFieldPoint(
        title: 'Toe Boards',
        fields: {
          'Control Measures':
              'Provide compliant toe boards where required to prevent persons, tools and materials falling from platform edges.',
          'Field HSE Check':
              'Check toe boards are continuous where required and not removed to make material movement easier.',
        },
      ),
      GoldFieldPoint(
        title: 'Falling Object Protection',
        fields: {
          'Hazards / Consequences':
              'Tools, fittings, boards and stored materials can strike workers or the public below.',
          'Control Measures':
              'Use toe boards, brick guards/screens, exclusion zones, covered walkways or other engineered/procedural controls as required by risk assessment.',
          'Stop-Work Condition':
              'Stop work below where falling-object risk is uncontrolled.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '10',
    title: 'Access, Egress & Landing Places',
    introduction:
        'Safe access must be designed and maintained as part of the scaffold system.',
    points: [
      GoldFieldPoint(
        title: 'Access Route',
        fields: {
          'Control Measures':
              'Provide a stable, unobstructed and suitable access route. Keep ladders, stairs and landings free from materials.',
          'Field HSE Check':
              'Inspect access from ground level to every required working level.',
        },
      ),
      GoldFieldPoint(
        title: 'Ladder Access',
        fields: {
          'Meaning / Detail':
              'Where ladders are used, comply with the approved scaffold design and applicable access requirements. Secure ladders and maintain safe transition at landings.',
          'Common Mistake':
              'Using unsecured ladders, climbing outside the scaffold or carrying bulky materials while climbing.',
        },
      ),
      GoldFieldPoint(
        title: 'Emergency Egress',
        fields: {
          'Control Measures':
              'Ensure emergency access/egress remains available and is not blocked by stored materials, sheeting or temporary modifications.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '11',
    title: 'Loading, Storage & Loading Bays',
    introduction:
        'Material loading must remain within the designed duty and controlled storage arrangement.',
    points: [
      GoldFieldPoint(
        title: 'Material Storage',
        fields: {
          'Hazards / Consequences':
              'Overloading, concentrated loads, falling materials and blocked access.',
          'Control Measures':
              'Store only the materials permitted by the design/load classification and keep access/egress clear.',
          'Field HSE Check':
              'Look for excessive brick, block, tile, steel, tools or waste accumulation.',
        },
      ),
      GoldFieldPoint(
        title: 'Loading Bay',
        fields: {
          'Control Measures':
              'Use a purpose-designed loading arrangement where materials must be transferred to scaffold levels. Provide suitable edge protection and load controls.',
          'Stop-Work Condition':
              'Stop where the loading arrangement is not designed, damaged or overloaded.',
        },
      ),
      GoldFieldPoint(
        title: 'Load Warning Information',
        fields: {
          'Records / Evidence':
              'Where required, display clear information about the intended use/loading limits and communicate it to users.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '12',
    title: 'Inspection, Handover & Identification',
    introduction:
        'A scaffold must be inspected and released before use and re-inspected at the required intervals and after relevant changes/events.',
    points: [
      GoldFieldPoint(
        title: 'Initial Inspection',
        fields: {
          'Meaning / Detail':
              'Inspect after erection and before first use, using a competent person and the applicable inspection criteria.',
          'Records / Evidence':
              'Inspection record and handover documentation as required by the project/CoP.',
          'Stop-Work Condition':
              'Do not allow use before required inspection and release.',
        },
      ),
      GoldFieldPoint(
        title: 'Periodic Inspection',
        fields: {
          'Meaning / Detail':
              'The current Abu Dhabi CoP requires inspection at the specified periodic interval during use; the commonly stated interval is at least every 7 days.',
          'Field HSE Check':
              'Verify the inspection date/status and that the record remains current.',
        },
      ),
      GoldFieldPoint(
        title: 'Post-Event Inspection',
        fields: {
          'Meaning / Detail':
              'Re-inspect after alteration, repair or an event that could affect stability, including relevant strong-wind or storm conditions.',
          'Stop-Work Condition':
              'Do not return the scaffold to service until required post-event inspection is completed.',
        },
      ),
      GoldFieldPoint(
        title: 'Scaffold Tag / Identification',
        fields: {
          'Meaning / Detail':
              'Use the project-approved scaffold identification/tagging system. The scaffold must clearly communicate its status and required inspection/use information.',
          'Common Mistake':
              'Treating a tag alone as proof that the scaffold remains safe after a modification or adverse event.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '13',
    title: 'Modification, Maintenance & Defects',
    introduction:
        'Any change to a scaffold can affect its structural and fall-protection performance.',
    points: [
      GoldFieldPoint(
        title: 'Unauthorized Modification',
        fields: {
          'Hazards / Consequences':
              'Removal of ties, braces, guardrails or boards can cause falls or collapse.',
          'Control Measures':
              'Only authorized competent personnel should modify the scaffold under the approved system.',
          'Stop-Work Condition':
              'Stop use where unauthorized modifications are found until assessed and corrected.',
        },
      ),
      GoldFieldPoint(
        title: 'Damaged Components',
        fields: {
          'Control Measures':
              'Remove defective components from service and replace them with suitable components.',
          'Field HSE Check':
              'Inspect tubes, fittings, boards, frames, ladders, base components and connection points for damage/corrosion/deformation.',
        },
      ),
      GoldFieldPoint(
        title: 'Housekeeping',
        fields: {
          'Hazards / Consequences':
              'Trips, falling objects, blocked access and increased load.',
          'Control Measures':
              'Maintain clean platforms and remove waste/materials that are not required for the work.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '14',
    title: 'Electrical & Overhead Services',
    introduction:
        'Scaffolds can create conductive structures and access routes close to electrical hazards.',
    points: [
      GoldFieldPoint(
        title: 'Electrical Interface',
        fields: {
          'Hazards / Consequences':
              'Electric shock, arc flash, contact with overhead lines and energized equipment.',
          'Control Measures':
              'Identify services during planning, maintain the applicable clearance, isolate where practicable and establish physical exclusion controls.',
          'Stop-Work Condition':
              'Stop where safe clearance/isolation cannot be established.',
        },
      ),
      GoldFieldPoint(
        title: 'Scaffold as a Conductive Structure',
        fields: {
          'Meaning / Detail':
              'Metal scaffold components can transfer electrical energy if they contact or approach energized sources.',
          'Field HSE Check':
              'Check the complete scaffold footprint and any materials/hoists that could encroach into electrical zones.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '15',
    title: 'Weather, Wind & Storm Controls',
    introduction:
        'Environmental conditions can change scaffold stability and user safety.',
    points: [
      GoldFieldPoint(
        title: 'Strong Wind',
        fields: {
          'Hazards / Consequences':
              'Increased wind load, movement of boards/materials, instability and falling objects.',
          'Control Measures':
              'Follow the project wind criteria and competent-person assessment; secure loose materials and inspect after relevant events.',
        },
      ),
      GoldFieldPoint(
        title: 'Sand / Dust Conditions',
        fields: {
          'Meaning / Detail':
              'Sand and dust can reduce visibility, affect housekeeping and contribute to material accumulation. Site-specific risk assessment should determine additional controls.',
          'Common Mistake':
              'Treating a scaffold as unchanged after a significant environmental event.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '16',
    title: 'Public, Road & Traffic Interface',
    introduction:
        'Where scaffold interfaces with pedestrians or vehicles, additional controls are required.',
    points: [
      GoldFieldPoint(
        title: 'Pedestrian Protection',
        fields: {
          'Hazards / Consequences':
              'Falling objects, contact with scaffold and unauthorized climbing.',
          'Control Measures':
              'Use barriers, exclusion zones, protected walkways and falling-object controls based on risk assessment.',
        },
      ),
      GoldFieldPoint(
        title: 'Vehicle Interface',
        fields: {
          'Control Measures':
              'Separate vehicles from scaffold using suitable barriers, traffic management and protection against impact where required.',
          'Stop-Work Condition':
              'Stop where uncontrolled vehicle movement could strike or destabilize the scaffold.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '17',
    title: 'Dismantling',
    introduction:
        'Dismantling is a planned work-at-height activity and must be controlled as carefully as erection.',
    points: [
      GoldFieldPoint(
        title: 'Dismantling Sequence',
        fields: {
          'Field Procedure':
              'Follow the approved sequence, maintain stability progressively, maintain access/fall protection and control the drop zone.',
          'Control Measures':
              'Use competent scaffolders, exclusion zones and controlled lowering/handling of components.',
          'Stop-Work Condition':
              'Stop where dismantling would remove critical stability or protection without an approved safe sequence.',
        },
      ),
      GoldFieldPoint(
        title: 'Falling Components',
        fields: {
          'Hazards / Consequences':
              'Struck-by injuries to workers, plant or the public.',
          'Control Measures':
              'Never throw scaffold components. Establish exclusion zones and use controlled handling.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '18',
    title: 'Emergency, Rescue & Stop-Work',
    introduction:
        'Emergency arrangements must be practical for the actual scaffold configuration and site.',
    points: [
      GoldFieldPoint(
        title: 'Emergency Response',
        fields: {
          'Control Measures':
              'Maintain site emergency communication, access for rescuers and a task-specific response plan. Consider falls, suspension, collapse, electrical contact and severe weather.',
          'Records / Evidence':
              'Emergency plan, communication method and relevant drill/training records.',
        },
      ),
      GoldFieldPoint(
        title: 'Fall / Suspension Rescue',
        fields: {
          'Meaning / Detail':
              'Where personal fall-arrest equipment is used, the rescue plan must address prompt recovery and avoid reliance on emergency services alone.',
          'Stop-Work Condition':
              'Do not start a fall-arrest-dependent task without a practicable rescue arrangement.',
        },
      ),
      GoldFieldPoint(
        title: 'Immediate Stop-Work Triggers',
        fields: {
          'Meaning / Detail':
              'Examples include visible instability, missing critical ties/bracing, failed platform/edge protection, major unauthorized modification, structural damage, uncontrolled electrical exposure, dangerous weather or required inspection not completed.',
          'Action':
              'Stop the affected work/area, prevent access, inform the responsible supervisor/competent person and rectify/verify before re-use.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '19',
    title: 'Common Site Defects',
    introduction:
        'The following defect patterns are useful for HSE field inspections.',
    points: [
      GoldFieldPoint(
        title: 'Missing Tie or Brace',
        fields: {
          'Hazards / Consequences':
              'Loss of stability and potential progressive failure.',
          'Corrective Action':
              'Restrict access and have competent scaffold personnel restore the designed stability system.',
        },
      ),
      GoldFieldPoint(
        title: 'Missing Toe Board',
        fields: {
          'Hazards / Consequences':
              'Falling tools/materials and increased exposure to persons below.',
          'Corrective Action':
              'Restore compliant edge/falling-object protection before work continues.',
        },
      ),
      GoldFieldPoint(
        title: 'Damaged Board',
        fields: {
          'Hazards / Consequences':
              'Platform failure, trip or fall through the platform.',
          'Corrective Action':
              'Remove and replace with a suitable approved component.',
        },
      ),
      GoldFieldPoint(
        title: 'Unauthorized Removal of Guardrail',
        fields: {
          'Hazards / Consequences':
              'Fall from height.',
          'Corrective Action':
              'Stop affected work and restore compliant edge protection through authorized personnel.',
        },
      ),
      GoldFieldPoint(
        title: 'Overloaded Platform',
        fields: {
          'Hazards / Consequences':
              'Excessive deflection, component failure or collapse.',
          'Corrective Action':
              'Stop loading, establish a safe unloading method and have the competent/design authority assess the arrangement.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '20',
    title: 'HSE Officer Field Checklist',
    introduction:
        'A concise field verification list for routine inspection and site walkdowns.',
    points: [
      GoldFieldPoint(
        title: 'Foundation & Stability Checklist',
        fields: {
          'HSE Officer Checklist':
              'Ground condition; sole boards/base plates where required; standards vertical; no settlement; ties/bracing present; no unauthorized removal; scaffold matches design.',
        },
      ),
      GoldFieldPoint(
        title: 'Platform Checklist',
        fields: {
          'HSE Officer Checklist':
              'Boards in good condition; secure; suitable width; acceptable gaps; no unsafe overhang; no excessive material storage; clear access.',
        },
      ),
      GoldFieldPoint(
        title: 'Edge Protection Checklist',
        fields: {
          'HSE Officer Checklist':
              'Top guardrail; intermediate protection; toe board; internal edge protection where required; falling-object controls; no missing sections.',
        },
      ),
      GoldFieldPoint(
        title: 'Inspection & Tag Checklist',
        fields: {
          'HSE Officer Checklist':
              'Initial inspection completed; periodic inspection current; post-event inspection where required; identification/tag present; handover/records available.',
        },
      ),
      GoldFieldPoint(
        title: 'Interface Checklist',
        fields: {
          'HSE Officer Checklist':
              'Electrical clearance; crane/plant interface; vehicle/pedestrian controls; public protection; weather conditions; exclusion zones.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '21',
    title: 'Toolbox Talk & Field Communication',
    introduction:
        'Workers should understand the scaffold status, intended use and prohibited actions before starting work.',
    points: [
      GoldFieldPoint(
        title: 'Toolbox Talk — Key Messages',
        fields: {
          'Meaning / Detail':
              'Use only the scaffold released for your work. Do not remove boards, guardrails, toe boards, ties or braces. Do not overload platforms. Keep access clear. Report damage or changes immediately. Never use an incomplete or unsafe scaffold.',
        },
      ),
      GoldFieldPoint(
        title: 'User Responsibilities',
        fields: {
          'Field Check':
              'Workers should visually check the scaffold before use and report defects, missing components, unusual movement, damage or status concerns.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '22',
    title: 'Interview & Learning',
    introduction:
        'Core questions for HSE Officer and scaffolding-supervision interviews.',
    points: [
      GoldFieldPoint(
        title: 'What is the main purpose of scaffold inspection?',
        fields: {
          'Interview Question':
              'To verify that the scaffold remains structurally stable, properly protected, suitable for its intended use and free from defects or unauthorized changes before and during use.',
        },
      ),
      GoldFieldPoint(
        title: 'When should a scaffold be re-inspected?',
        fields: {
          'Interview Question':
              'After erection before use, at the required periodic interval, after relevant alteration or repair, and after an event that could affect stability such as strong wind or storm conditions.',
        },
      ),
      GoldFieldPoint(
        title: 'What should an HSE Officer do if a critical tie is missing?',
        fields: {
          'Interview Question':
              'Stop use of the affected scaffold/area, prevent access, notify the competent scaffold team and ensure the stability system is restored and verified before re-use.',
        },
      ),
      GoldFieldPoint(
        title: 'Can a normal worker remove a scaffold guardrail?',
        fields: {
          'Interview Question':
              'No. Scaffold components must not be removed or altered by unauthorized personnel. Any modification must follow the approved control process and be performed by competent personnel.',
        },
      ),
    ],
  ),
  GoldSection(
    number: '23',
    title: 'Dubai & Other UAE Cross-Reference',
    introduction:
        'Jurisdiction-specific requirements must be kept separate from Abu Dhabi requirements.',
    points: [
      GoldFieldPoint(
        title: 'Dubai Reference',
        fields: {
          'Meaning / Detail':
              'Dubai requirements may include Dubai Municipality and other applicable authority/project requirements. Do not present Dubai rules as Abu Dhabi CoP requirements.',
          'Field HSE Check':
              'For a Dubai project, verify the current controlling authority document and project requirements before applying a numerical or procedural requirement.',
        },
      ),
      GoldFieldPoint(
        title: 'Sharjah Reference',
        fields: {
          'Meaning / Detail':
              'Sharjah OSHJ guidance provides useful comparative scaffolding content, but it is a Sharjah jurisdiction reference and must be labelled as such.',
        },
      ),
      GoldFieldPoint(
        title: 'Cross-Jurisdiction Rule',
        fields: {
          'Meaning / Detail':
              'Common engineering and safety principles can be shared, but legal/regulatory requirements, authority procedures, inspection systems and project conditions must remain jurisdiction-specific.',
        },
      ),
    ],
  ),
];
