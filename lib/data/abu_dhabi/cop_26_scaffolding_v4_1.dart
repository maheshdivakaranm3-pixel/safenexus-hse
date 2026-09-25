// lib/data/abu_dhabi/cop_26_scaffolding_v4_1.dart
//
// SafeNexus HSE
// Abu Dhabi HSE Reference
//
// ADOSH-SF Code of Practice
// CoP 26.0 – Scaffolding
// Version 4.1
// Document date: 16 February 2026
//
// IMPORTANT:
// This file is a structured field-reference representation of the
// supplied ADOSH-SF CoP 26.0 – Scaffolding Version 4.1 source.
// Official requirements should always be checked against the current
// ADPHC publication before regulatory decisions are made.

class AbuDhabiCop26Scaffolding {
  static const String code = 'CoP 26.0';
  static const String title = 'Scaffolding';
  static const String version = '4.1';
  static const String documentDate = '16 February 2026';
  static const String framework = 'ADOSH-SF';
  static const String authority = 'Abu Dhabi Public Health Centre (ADPHC)';

  static const String applicability =
      'This Code of Practice applies to all employers within the Emirate of Abu Dhabi.';

  static const List<String> tableOfContents = [
    '1. Introduction',
    '2. Training and Competency',
    '3. Requirements',
    '3.1 Roles and Responsibilities',
    '3.2 Planning and Assessment',
    '3.3 Design of Scaffolding',
    '3.4 Scaffolding General Requirements',
    '3.5 Documented Safe Systems of Work',
    '3.6 Working at Height',
    '3.7 Mobile Plant and Traffic',
    '3.8 Mixing and Matching Scaffold Components',
    '3.9 Partly Erected or Dismantled Scaffolds',
    '3.10 Care and Maintenance of Scaffolding',
    '3.11 Construction and Material',
    '3.12 Ladders used in Scaffolds',
    '3.13 Mobile and Static Tower Scaffolds',
    '3.14 Inspection of Scaffolding',
    '4. References',
    '5. Document Amendment Record',
  ];

  static const List<Cop26Section> sections = [
    _introduction,
    _trainingAndCompetency,
    _rolesAndResponsibilities,
    _planningAndAssessment,
    _designOfScaffolding,
    _generalRequirements,
    _safeSystemsOfWork,
    _workingAtHeight,
    _mobilePlantAndTraffic,
    _mixingComponents,
    _partlyErected,
    _careAndMaintenance,
    _constructionAndMaterial,
    _ladders,
    _mobileAndStaticTowers,
    _inspection,
    _references,
    _amendmentRecord,
  ];

  static const Cop26Section _introduction = Cop26Section(
    number: '1',
    title: 'Introduction',
    summary:
        'Requirements for assessing and controlling risks associated with scaffolding, including planning, erection, use, maintenance, alteration, dismantling and inspection.',
    requirements: [
      'The CoP applies to all employers within the Emirate of Abu Dhabi.',
      'The CoP incorporates requirements established by ADPHC and relevant Sector Regulatory Authorities in Abu Dhabi.',
      'Risks associated with scaffolding shall be assessed and control measures implemented in accordance with the hierarchy of controls.',
      'The CoP applies to planning, assessment, erection, use, maintenance, alteration, dismantling and inspection of scaffolding.',
      'The scope includes modular scaffolding, tube and coupler scaffolding, suspended scaffolding, swinging stages and planks placed across structures not engineered to accept planks.',
      'Scaffolding is a temporary structure used inside or outside a building or structure and generally consists of wooden or metal planks and metal poles.',
      'Prefabricated mobile access towers may consist of frames, braces, platforms and stabilizers assembled as modular kits.',
      'Prefabricated mobile access towers shall have appropriate product conformity certification to BS EN 1004.',
      'During mobile access tower assembly and dismantling, fall-prevention measures such as Through The Trap (3T) or Advance Guardrails (AGR) are required.',
      'Trestles, fabricated working platforms including work boxes, and motorized platforms are excluded from this scaffolding definition.',
    ],
    hazards: [
      'Falls from height',
      'Falling objects',
      'Scaffold collapse',
      'Unstable support conditions',
      'Incorrect assembly or alteration',
      'Unsafe mobile tower erection or dismantling',
    ],
  );

  static const Cop26Section _trainingAndCompetency = Cop26Section(
    number: '2',
    title: 'Training and Competency',
    summary:
        'Personnel involved in scaffolding activities shall have appropriate training, competency and documented evidence of competence.',
    requirements: [
      'OSH training shall comply with ADOSH-SF Element 5 – Training, Awareness and Competency.',
      'Training shall also comply with ADOSH-SF Mechanism 7.0 – Occupational Safety and Health Practitioner and Service Provider Registration.',
      'Employees implementing this CoP shall be trained in scaffold use and understand associated risks and employer control measures.',
      'Persons working with scaffolds require relevant scaffolding competencies demonstrated through qualification, certificate, permit, training or proven experience.',
      'Persons assembling or dismantling mobile access towers shall be competent and trained to an internationally recognised standard such as PASMA or equivalent.',
      'Training providers for mobile access towers should demonstrate suitable facilities, equipment, instructor qualifications, CPD, instructor-to-trainee ratio and course content subject to independent assessment and ongoing audit by a recognised industry body.',
      'Scaffold designers require appropriate engineering qualifications and experience.',
      'Personnel erecting, modifying or dismantling scaffolds over 10 metres high and all suspended scaffolds require a Scaffolding Competency Certificate issued by an approved third-party training provider.',
      'Personnel erecting, modifying or dismantling scaffolds below 10 metres require a Scaffolding Competency Certificate issued by a registered trainer.',
      'General training shall cover loading requirements and restrictions, inspection requirements, defects and common scaffold hazards.',
      'Employers shall maintain training records.',
    ],
    trainingRecordFields: [
      'Name and ID number',
      'Emirates ID number',
      'Training subject(s)',
      'Training provider',
      'Training date(s)',
      'Person(s) providing the training',
    ],
  );

  static const Cop26Section _rolesAndResponsibilities = Cop26Section(
    number: '3.1',
    title: 'Roles and Responsibilities',
    summary:
        'Defines specific responsibilities of employers, principal contractors and employees.',
    subsections: [
      Cop26Subsection(
        number: '3.1.1',
        title: 'Employers',
        requirements: [
          'Provide appropriately maintained scaffolds where work cannot safely be performed from ground level or a permanent structure.',
          'Select a scaffold method appropriate for the intended purpose.',
          'Ensure scaffolding work is appropriately planned and supervised.',
          'Ensure persons involved in scaffolding are trained and competent.',
          'Ensure the workplace where scaffolding is undertaken is safe.',
          'Ensure scaffolding equipment is appropriately inspected by a competent person.',
          'Where scaffold erected by another employer is used, ensure it is inspected by a competent person and declared safe and appropriate for use.',
        ],
      ),
      Cop26Subsection(
        number: '3.1.2',
        title: 'Principal Contractors',
        requirements: [
          'Building and Construction principal contractors shall comply with CoP 53.0 requirements.',
          'Provide employers with available site descriptions, drawings, surveys, service plans and information concerning hazardous materials and surrounding properties.',
          'Notify relevant authorities and utility service providers and obtain required approvals before work commences.',
          'Control scaffold access using awareness, signage and access restrictions.',
          'Ensure personnel erecting and inspecting scaffolding are qualified and competent.',
          'Coordinate employers using or working from the same scaffold.',
        ],
      ),
      Cop26Subsection(
        number: '3.1.3',
        title: 'Employees',
        requirements: [
          'Follow information provided by the employer regarding scaffold use.',
          'Observe safe work practices and employer operating procedures.',
          'Observe warning signs.',
          'Use PPE in accordance with employer instructions.',
        ],
      ),
    ],
  );

  static const Cop26Section _planningAndAssessment = Cop26Section(
    number: '3.2',
    title: 'Planning and Assessment',
    summary:
        'Scaffolding shall be planned and risk assessed before construction, erection, alteration or use.',
    subsections: [
      Cop26Subsection(
        number: '3.2.1',
        title: 'General Requirements',
        requirements: [
          'Assess risks and establish safe systems of work for all affected parties, including the public.',
          'Implement effective procedures and control measures.',
          'For Building and Construction, include scaffold requirements in the Pre-Tender Safety and Health Plan in accordance with CoP 53.0.',
          'Include associated safe systems of work and site rules in the OSH Construction Management Plan where applicable.',
        ],
      ),
      Cop26Subsection(
        number: '3.2.2',
        title: 'Risk Assessment',
        requirements: [
          'Complete a risk assessment before construction of scaffolding.',
          'Apply ADOSH-SF Element 2 – Risk Management.',
          'Apply ADOSH-SF CoP 23.0 – Working at Height.',
          'Assess erection, modification and dismantling activities.',
          'Assess scaffold and associated equipment use.',
          'Assess persons in the vicinity of elevated work, scaffold or equipment.',
          'Assess working at height and falling-object risks.',
          'Assess overhead electrical services.',
          'Assess corrosive substances.',
          'Assess cranes, vehicles and machinery movement.',
          'Assess weak or unstable supporting structures and surfaces.',
          'Assess high winds and storms.',
        ],
        controlHierarchy: [
          'Select a less hazardous scaffold or access system.',
          'Modify scaffold or access-system design.',
          'Isolate the scaffold.',
          'As a last resort, provide harness and fall-arrest systems unless prohibited by manufacturer instructions.',
        ],
      ),
      Cop26Subsection(
        number: '3.2.3',
        title: 'Design Drawings',
        requirements: [
          'A competent engineer shall prepare a design drawing for scaffolds over 10 metres high.',
          'A competent engineer design is also required where ladder beams are used.',
          'A competent engineer design is required where mesh or shade cloth is used.',
          'A competent engineer design is required for freestanding scaffolds.',
          'A competent engineer design is required for suspended scaffolds.',
          'A competent engineer design is required for non-standard ties or bracing.',
          'Scaffolds above 10 metres shall be erected, altered, used and dismantled according to design drawings or manufacturer instructions where applicable.',
          'For scaffolds where an engineer design is not required, erectors shall be competent and trained in the relevant scaffold design and erection method.',
          'Manufacturer instructions or drawings shall be followed and available on site.',
        ],
      ),
    ],
  );

  static const Cop26Section _designOfScaffolding = Cop26Section(
    number: '3.3',
    title: 'Design of Scaffolding',
    summary:
        'Scaffold design shall address structural integrity, intended use, loads, environmental conditions, stability and safety during erection, use and dismantling.',
    subsections: [
      Cop26Subsection(
        number: '3.3.1',
        title: 'Designers Roles and Responsibilities',
        requirements: [
          'Designers shall comply with ADOSH-SF Element 1 requirements.',
          'Designers shall comply with CoP 20.0 – Safety in Design (Construction).',
        ],
      ),
      Cop26Subsection(
        number: '3.3.2',
        title: 'Principles of Design',
        requirements: [
          'Consider strength, stability and rigidity of the scaffold and supporting structure.',
          'Consider intended use and application.',
          'Consider safety during erection, alteration and dismantling.',
          'Consider safety of scaffold users.',
          'Consider scaffold materials.',
          'Consider persons in the vicinity of the scaffold.',
        ],
      ),
      Cop26Subsection(
        number: '3.3.3',
        title: 'Foundations',
        requirements: [
          'Foundations shall carry and distribute the full scaffold weight and additional loads, including possible perimeter containment screens.',
        ],
      ),
      Cop26Subsection(
        number: '3.3.4',
        title: 'Ground Conditions',
        requirements: [
          'Consider water and nearby excavations that could cause subsidence and scaffold collapse.',
          'Divert foreseeable watercourses, including recently filled trenches, away from the scaffold base where necessary to prevent washout.',
        ],
      ),
      Cop26Subsection(
        number: '3.3.5',
        title: 'Loadings',
        requirements: [
          'Consider the most adverse reasonably foreseeable combination of dead, live and environmental loads.',
          'Calculate dead, live and environmental loads during design.',
          'Ensure supporting structures and lower standards can support calculated loads.',
          'Obtain competent engineer approvals where required during erection.',
          'Follow manufacturer specifications for scaffold components and accessories.',
        ],
      ),
      Cop26Subsection(
        number: '3.3.6',
        title: 'Environmental Loads',
        requirements: [
          'Consider wind and rain loads.',
          'Consider increased wind loading caused by containment screens, shade cloth or signs.',
          'Consider staggering joints in standards to help control collapse risk from environmental loading.',
        ],
      ),
      Cop26Subsection(
        number: '3.3.7',
        title: 'Dead Loads',
        requirements: [
          'Include scaffold self-weight and component weight.',
          'Consider working, catch and access platforms.',
          'Consider stairways and ladders.',
          'Consider screens and sheeting.',
          'Consider platform brackets.',
          'Consider suspension, secondary and traversing ropes.',
          'Consider tie assemblies.',
          'Consider scaffold hoists and electrical cables.',
          'Do not use scaffolds to support formwork or plant unless specifically designed for that purpose.',
        ],
      ),
      Cop26Subsection(
        number: '3.3.8',
        title: 'Live Loads',
        requirements: [
          'Consider persons.',
          'Consider materials and debris.',
          'Consider tools and equipment.',
          'Consider reasonably foreseeable impact forces.',
        ],
      ),
      Cop26Subsection(
        number: '3.3.9',
        title: 'Supporting Structure',
        requirements: [
          'Verify supporting structure capacity for the most adverse reasonably practicable load combination.',
          'Obtain engineer advice before erecting scaffolds on verandas, suspended flooring systems, compacted soil, parapets or awnings.',
          'Provide propping where the supporting structure cannot support the required loads.',
        ],
      ),
      Cop26Subsection(
        number: '3.3.10',
        title: 'Stability of Scaffolding',
        requirements: [
          'Tie scaffolding to a supporting structure.',
          'Increase dead load using securely attached counterweights where appropriate.',
          'Use additional bays, stabilizers or mobile outriggers to increase base dimension.',
        ],
      ),
      Cop26Subsection(
        number: '3.3.11',
        title: 'Design of the Working Platforms',
        requirements: [
          'Working platforms other than suspended scaffolds shall be designed for the intended duty classification.',
          'Duty classifications include access only, light working and heavy working.',
          'Each scaffold shall support the required number of working platforms and associated live loads.',
        ],
      ),
      Cop26Subsection(
        number: '3.3.12',
        title: 'Rubbish Chutes',
        requirements: [
          'Consider additional loads from rubbish chutes.',
          'Consider additional wind loading.',
          'Consider loads resulting from blockage.',
        ],
      ),
    ],
  );

  static const Cop26Section _generalRequirements = Cop26Section(
    number: '3.4',
    title: 'Scaffolding General Requirements',
    summary:
        'Detailed requirements for safe erection, bases, platforms, ties, walkways, guardrails, access, screening, alteration and dismantling.',
    subsections: [
      Cop26Subsection(
        number: '3.4.1',
        title: 'Safe Erection of Scaffolding',
        measurements: [
          'Minimum erection platform width: 450 mm.',
          'Platform below erection level for housing construction: not more than 3 m.',
          'Platform below erection level for other work: not more than 2.4 m.',
          'Internal scaffold gap trigger: greater than 225 mm.',
        ],
        requirements: [
          'Comply with ADOSH-SF Working at Heights requirements.',
          'Install specific scaffold fall-prevention measures such as advance guardrails.',
          'Provide a platform at least 450 mm wide along the full scaffold section being erected.',
          'Provide edge protection at the level reached by the scaffold.',
          'Provide safe access to the level reached.',
          'A platform below the erection level shall be installed within the specified distance before each level is erected, except the first lift.',
          'A section of platform may be left open temporarily for passing components between levels.',
          'A bottom-level platform is not mandatory where the CoP permits this.',
          'Platforms may be removed progressively after work has started two levels above.',
          'Before complete dismantling, planks shall be reinstalled to maintain employee safety.',
          'Verify ground stability before erection.',
          'Securely tighten scaffold fittings and connections.',
          'Install bracing, ties, guy ropes and buttresses progressively with erection.',
          'Provide an appropriate number of scaffolders to reduce manual-handling risks.',
          'Use a methodical erection sequence.',
          'Provide fully boarded work platforms.',
          'Do not climb guardrails to gain additional height.',
          'Where internal gaps exceed 225 mm, implement appropriate fall controls.',
        ],
      ),
      Cop26Subsection(
        number: '3.4.2',
        title: 'Sole Boards and Baseplates',
        measurements: [
          'Minimum sole board size: 225 mm × 450 mm.',
        ],
        requirements: [
          'Use baseplates on all scaffold standards to distribute loads.',
          'Use sole boards on less stable surfaces according to the scaffold design.',
          'Determine sole-board size based on supporting surface.',
          'Consult an engineer where ground or supporting-structure bearing capacity is uncertain.',
          'Consider needles and spurs where ground conditions are very unstable.',
        ],
      ),
      Cop26Subsection(
        number: '3.4.3',
        title: 'Working Platforms',
        measurements: [
          'Maximum single scaffold-board gap: 25 mm.',
          'Maximum total gap between scaffold boards: 50 mm.',
          'Minimum plywood thickness: 17 mm.',
          'Plywood gap application: less than 500 mm unless engineer approved.',
          'Maximum board overhang: 150 mm or 4 times board thickness, whichever is less.',
        ],
        requirements: [
          'Platforms shall support required live loads.',
          'Boards shall have slip-resistant surfaces.',
          'Boards shall not be cracked or split.',
          'Boards shall have uniform thickness.',
          'Boards shall be captive and secured against uplift or displacement.',
          'Straight-run modular and tube-and-fitting boards shall not be lapped unless the specific scaffold arrangement permits it.',
          'Metal planks lapped on other metal planks shall be secured.',
        ],
      ),
      Cop26Subsection(
        number: '3.4.4',
        title: 'Tying of Scaffolds',
        measurements: [
          'Torque-controlled expansion anchor working load limit: maximum 65% of stated first-slip load.',
          'Proof-load factor for specified expansion and chemical anchors: working load × 1.25.',
          'Minimum failure-load safety factor for specified drill-in expansion or chemical anchors: 3:1.',
          'Minimum testing proportion for drill-in expansion anchors: 10%.',
          'Chemical anchors: all anchors shall be tested where the CoP requirement applies.',
        ],
        requirements: [
          'Tie methods and spacing shall follow manufacturer, designer or supplier instructions.',
          'Consult the scaffold designer, manufacturer, supplier or engineer where specified tie positions cannot reasonably be achieved.',
          'Provide additional ties when scaffold is sheeted or netted.',
          'Provide additional ties for loading platforms.',
          'Provide additional ties when lifting appliances or rubbish chutes are attached.',
          'A competent person shall regularly inspect ties for existence and effectiveness.',
          'Prevent unauthorized alteration, loosening, relocation or removal of ties.',
          'Consult the designer or supplier before attaching additional loads.',
          'Cast-in anchors or through ties are preferred where appropriate.',
          'Deformation-controlled anchors, including self-drilling and drop-in impact anchors, shall not be used.',
          'If an anchor fails, remaining anchors on the same level shall be tested as required.',
          'Ties shall not obstruct platform access.',
          'Ties shall interconnect inner and outer standards unless otherwise specified by an engineer.',
        ],
      ),
      Cop26Subsection(
        number: '3.4.5',
        title: 'Walkways',
        measurements: [
          'Minimum board width for board thickness 50 mm or less: 200 mm.',
          'Minimum board width for board thickness over 50 mm: 150 mm.',
          'Maximum support overlap: 4 times board thickness unless secured against tipping.',
        ],
        requirements: [
          'Boards shall be strong enough for intended work.',
          'Walkways shall be level and flat.',
          'Provide suitable treatment at laps to minimise trip hazards.',
        ],
      ),
      Cop26Subsection(
        number: '3.4.6',
        title: 'Width of Walkways',
        measurements: [
          'Persons-only platform above 2 m: minimum 800 mm / 4 boards.',
          'Persons and materials platform: minimum 1.0 m / 5 boards.',
          'Clear passage with deposited materials: minimum 430 mm.',
          'Clear passage when barrows are used: minimum 600 mm.',
          'Platform carrying trestle or higher platform: minimum 1.0 m / 5 boards.',
          'Masons platform: minimum 1.20 m / 6 boards.',
          'Light short-duration work: minimum 600 mm / 3 boards.',
        ],
      ),
      Cop26Subsection(
        number: '3.4.7',
        title: 'Toe Boards and Guardrails',
        measurements: [
          'Minimum toe-board height: 150 mm.',
          'Minimum guardrail height: 950 mm.',
          'Maximum gap between toe board/mid-rail/guardrail components: 470 mm.',
          'Mid-rail required where working platform level is over 2 m.',
        ],
        requirements: [
          'Provide guardrails and toe boards at outside and ends of working platforms where persons or materials can fall.',
          'Fit guardrails and toe boards on the inside of standards to prevent outward movement.',
          'Provide additional toe-board height or debris protection where materials are stacked.',
          'Replace removed guardrails and toe boards as soon as reasonably practicable.',
        ],
      ),
      Cop26Subsection(
        number: '3.4.8',
        title: 'Landing Places',
        measurements: [
          'Landing place interval between ladder access routes: every 9 m of height.',
          'Maximum ladder/stair opening width: 500 mm.',
        ],
        requirements: [
          'Landing places shall have toe boards and guardrails.',
          'Openings shall be as small as reasonably practicable.',
        ],
      ),
      Cop26Subsection(
        number: '3.4.9',
        title: 'Access and Egress',
        requirements: [
          'Provide safe access and egress during erection, use and dismantling.',
          'Consider temporary stair towers or portable ladder access systems.',
          'Progress access systems with scaffold erection where reasonably practicable.',
          'Consider permanent platforms or ramps.',
          'Use built-in access for mobile towers or system scaffolding where provided.',
          'Mechanical personnel hoists may be used with permanent or temporary stairs and should support emergency or power-failure arrangements.',
          'Existing building stairs may be used where safe.',
        ],
      ),
      Cop26Subsection(
        number: '3.4.10',
        title: 'Perimeter Containment Screening',
        measurements: [
          'Maximum horizontal gap between adjacent screens or screen/framework: 25 mm.',
          'Maximum vertical gap between screens or screen/framework: 25 mm.',
        ],
        requirements: [
          'Where perimeter containment screening is provided, the screening system shall be designed and installed to control falling materials and protect persons below or adjacent to the scaffold.',
          'Plastic sheeting shall be adequately lapped so that materials cannot fall outside the perimeter of the scaffold.',
          'Where the screen is intended to redirect falling objects onto a catch platform, the screen shall be positioned vertically to the top of, or flush with, the outer edge of the catch platform.',
          'Where the screen does not redirect falling objects onto a catch platform, the screen shall be designed to prevent objects from falling onto persons.',
          'Horizontal gaps in perimeter containment screening shall not exceed 25 mm.',
          'Vertical gaps in perimeter containment screening shall not exceed 25 mm.',
          'The supporting framework for the perimeter containment screen shall be capable of carrying the loads imposed by the screen.',
          'The scaffold and supporting structure shall be assessed for additional loads imposed by the containment screening, including applicable environmental loads.',
        ],
        officialReferences: [
          'ADPHC CoP 26.0 – Scaffolding V4.1, Section 3.4.10 – Perimeter Containment Screening.',
          'Official document date: 16 February 2026.',
        ],
      ),
      Cop26Subsection(
        number: '3.4.11',
        title: 'Scaffold Alteration',
        requirements: [
          'Consult the scaffold designer before alteration.',
          'Only competent persons shall alter scaffolding.',
          'Alterations shall comply with the scaffold plan.',
          'Alterations shall not compromise structural integrity.',
          'Inspection systems shall identify unauthorised interference.',
        ],
      ),
      Cop26Subsection(
        number: '3.4.12',
        title: 'Safe Dismantling of Scaffolding',
        measurements: [
          'Minimum dismantling platform width where reasonably practicable: 450 mm.',
        ],
        requirements: [
          'Dismantling shall be carried out progressively along the elevation of the scaffold.',
          'Guardrails shall be removed progressively as the dismantling sequence reaches the relevant section.',
          'Scaffold boards shall be removed from the section being dismantled and lowered to the lift below in a controlled manner.',
          'The dismantling sequence shall maintain safe working platforms and fall protection for scaffolders.',
          'Surplus scaffold boards and fittings shall be removed progressively as dismantling proceeds.',
          'Surplus boards and fittings shall be removed particularly at the end of each working day.',
          'Scaffold fittings shall be stacked at ground level unless the first lift has been specifically designed to support the additional loading.',
          'Materials and components shall not be thrown or dropped from the scaffold during dismantling.',
          'Dismantling shall be carried out by competent scaffolders in accordance with the planned safe system of work.',
          'Required ties, bracing and stability controls shall remain in place until they can be safely removed as part of the planned dismantling sequence.',
          'Additional ties may be required during dismantling.',
          'Check structural stability before dismantling.',
          'Block access to partly dismantled sections and display warning signs.',
          'Protect the public and install barriers where required.',
          'Remove edge protection and access systems as late as reasonably practicable.',
          'Keep a fully planked platform immediately below the worker level where required.',
          'Use controlled hand-to-hand passing or a gin wheel for lowering components.',
        ],
        officialReferences: [
          'ADPHC CoP 26.0 – Scaffolding V4.1, Section 3.4.12 – Safe Dismantling.',
          'Official document date: 16 February 2026.',
        ],
      ),
    ],
  );

  static const Cop26Section _safeSystemsOfWork = Cop26Section(
    number: '3.5',
    title: 'Documented Safe Systems of Work',
    summary:
        'Documented safe systems shall cover erection, dismantling, maintenance, alteration, use and nearby activities.',
    requirements: [
      'Develop and implement documented safe systems for erecting, dismantling, maintaining and altering scaffolding.',
      'Develop safe systems for scaffold use.',
      'Address activities near scaffolding involving workers and members of the public.',
      'Consult the scaffold designer regarding design loads and additional load capacity.',
      'Consult the principal contractor regarding underground drains, pits and service trenches.',
      'Consult employees involved in scaffold erection, dismantling, maintenance and alteration.',
      'Include drawings showing scaffold elevations and sections.',
      'Communicate drawings and safe systems to persons undertaking scaffold work.',
      'Specify scaffold type.',
      'Specify special design considerations.',
      'Specify erection methodology.',
      'Specify access and egress.',
      'Specify tie type and frequency.',
      'Specify façade and ledger bracing.',
      'Specify safe sequences preventing persons or materials from falling.',
    ],
    documents: [
      'Scaffold drawings',
      'Elevations and sections',
      'Safe system of work',
      'Erection methodology',
      'Access and egress arrangement',
      'Tie details',
      'Bracing details',
      'Risk assessment',
    ],
  );

  static const Cop26Section _workingAtHeight = Cop26Section(
    number: '3.6',
    title: 'Working at Height',
    summary:
        'Additional work-at-height controls apply specifically to scaffold erection, alteration and dismantling.',
    subsections: [
      Cop26Subsection(
        number: '3.6.1',
        title: 'Specific Work at Height Requirements for Scaffolding',
        measurements: [
          'Guardrail reference height: 950 mm.',
        ],
        requirements: [
          'Persons engaged in scaffold erection shall be issued with a personal safety harness.',
          'Scaffolders shall wear harnesses when working at or liable to work at height.',
          'Develop safe systems of work for harness use.',
          'Scaffolders shall clip on whenever outside an area protected by at least one 950 mm guardrail.',
          'Consider poor environmental conditions.',
          'Consider strong winds.',
          'Consider rain and slippery surfaces.',
          'Consider glare and poor lighting.',
          'Consider materials and protruding objects below or adjacent to work areas.',
          'Protect ladder access voids and other unprotected areas.',
          'Control incomplete scaffolds and loose components.',
          'Ensure suitable training, instruction and supervision.',
        ],
      ),
      Cop26Subsection(
        number: '3.6.2',
        title: 'Additional Risk Control Measures whilst Working at Height',
        requirements: [
          'Establish exclusion zones around scaffolding and adjoining areas.',
          'Use perimeter containment screening, scaffold fans, hoardings or gantries where required.',
          'Where practicable, schedule erection and dismantling in built-up areas during quieter periods.',
          'Never drop materials from scaffolds.',
          'Use danger tags and warning signs such as falling-object and incomplete-scaffold warnings.',
        ],
      ),
    ],
  );

  static const Cop26Section _mobilePlantAndTraffic = Cop26Section(
    number: '3.7',
    title: 'Mobile Plant and Traffic',
    requirements: [
      'Reroute motor vehicles and mobile plant away from scaffolding where practicable.',
      'Use traffic controllers where required.',
      'Use barricades, signs, posts, buffer rails, guards or suitable curbs to prevent vehicle or plant contact with scaffolding.',
      'Avoid unnecessary scaffold protrusions including over-length transoms, tie tubes or over-height standards.',
      'Apply CoP 22.0 – Barricading of Hazards.',
      'Apply CoP 17.0 – Safety Signage and Signals.',
    ],
  );

  static const Cop26Section _mixingComponents = Cop26Section(
    number: '3.8',
    title: 'Mixing and Matching Scaffold Components',
    requirements: [
      'Do not mix scaffold components from different manufacturers unless a competent engineer confirms compatibility.',
      'Compatibility shall include size and strength.',
      'Compatibility shall include deflection characteristics.',
      'Fixing devices shall be compatible.',
      'Mixing shall not reduce strength, stability, rigidity or suitability.',
      'Avoid mixing different modular systems with incompatible connection geometries or tolerances.',
      'Do not mix tubing with different outside diameters and strengths.',
      'Do not mix aluminium and steel components where steel clamps could crush aluminium tubing and reduce strength.',
      'Beam clamps and flange clamps shall have information for safe use, including tightening torque and appropriate coupler types.',
    ],
  );

  static const Cop26Section _partlyErected = Cop26Section(
    number: '3.9',
    title: 'Partly Erected or Dismantled Scaffolds',
    requirements: [
      'A partly erected or dismantled scaffold shall not remain accessible for use unless it meets the specified controls.',
      'Place a prominent warning notice at or near access points.',
      'Clearly indicate that the scaffold or part of it shall not be used.',
      'Effectively block access as far as reasonably practicable.',
    ],
    fieldWarning:
        'Danger – Incomplete Scaffolding / Do Not Use',
  );

  static const Cop26Section _careAndMaintenance = Cop26Section(
    number: '3.10',
    title: 'Care and Maintenance of Scaffolding',
    requirements: [
      'Store scaffolding materials appropriately when not in use.',
      'Protect protective coatings on scaffold tubes.',
      'Do not use unprotected steel in particularly corrosive atmospheres where it may affect safety.',
      'Tube straightening shall be carried out only by competent persons.',
      'Cut out and discard split or damaged tube sections.',
      'Examine couplers and fittings before use.',
      'Ensure moving parts are free from wear or damage and appropriately lubricated.',
      'Inspect scaffold boards after each job.',
      'Discard boards showing abuse, decay or excessive warping.',
      'Maintain end hoops or bands as necessary.',
      'Use nail plates only within permitted limits for split board ends.',
      'Do not paint or treat scaffold boards in a manner that conceals defects.',
      'Clean boards after return from site and stack them flat above ground on cross battens.',
      'Do not use scaffold boards as makeshift crawling boards, shuttering or door-frame props.',
      'Never drop or throw scaffold boards or components from height.',
    ],
  );

  static const Cop26Section _constructionAndMaterial = Cop26Section(
    number: '3.11',
    title: 'Construction and Material',
    requirements: [
      'Every scaffold component shall be of good construction and suitable strength.',
      'Use appropriate materials for the intended scaffold.',
      'Consider work type, load, height and weather conditions.',
      'Timber shall be appropriate quality and condition with bark removed.',
      'Timber shall not be painted or treated so that defects cannot be readily seen.',
      'Metal scaffold parts shall be good quality and free from corrosion or defects affecting strength.',
      'Do not use defective materials or parts.',
      'Store suitable and unsuitable scaffold components separately.',
      'Maintain scaffolds clean and secure all parts against accidental displacement.',
    ],
  );

  static const Cop26Section _ladders = Cop26Section(
    number: '3.12',
    title: 'Ladders Used in Scaffolds',
    subsections: [
      Cop26Subsection(
        number: '3.12.1',
        title: 'Ladders',
        requirements: [
          'Ladders may be used where access is required by a limited number of persons and tools/materials can be delivered separately.',
          'Where space permits, ladders shall be in a separate ladder-access bay.',
          'If the access bay forms part of the working platform, provide a trap door.',
          'Control the trap door so that it remains closed during platform work.',
          'Set ladders on firm, level surfaces.',
          'Do not use ladders on scaffold bays to gain additional height.',
        ],
      ),
      Cop26Subsection(
        number: '3.12.2',
        title: 'Ladders Not to be Used as Uprights',
        requirements: [
          'Ladders shall not be used as uprights to support a single-board working platform.',
          'This practice is prohibited.',
        ],
      ),
      Cop26Subsection(
        number: '3.12.3',
        title: 'Ladders When Provided for Access',
        measurements: [
          'Ladder working angle: approximately 75 degrees to horizontal.',
          'Typical set-up: 1 m out for every 4 m of height.',
          'Ladder extension above platform: at least 1.05 m / 5 rungs.',
          'Intermediate landing required when ladder rises more than 9 m vertically.',
        ],
        requirements: [
          'Top of ladder shall be supported by stiles resting on a firm, even base.',
          'Secure rungs by suitable lashing or ladder clamp.',
          'Keep rungs clear of obstruction, materials and rubbish.',
          'Clean or sand slippery rungs promptly.',
          'Keep stepping-off rungs level with the working platform.',
          'Outside working hours, remove ladders or board off access to prevent unauthorised access.',
        ],
      ),
    ],
  );

  static const Cop26Section _mobileAndStaticTowers = Cop26Section(
    number: '3.13',
    title: 'Mobile and Static Tower Scaffolds',
    measurements: [
      'Tower working-surface height: no greater than 3 times the minimum base dimension unless manufacturer, supplier or designer specifies otherwise.',
      'Maximum stabilizer lift when moving/positioning as specified: 25 mm.',
    ],
    requirements: [
      'Mobile access towers shall be designed and have product conformity certification to BS EN 1004.',
      'Use fall-prevention systems such as Through The Trap (3T) or Advance Guardrails during assembly and dismantling.',
      'Retain or obtain manufacturer instructions.',
      'Use a secure internal ladder with protected opening.',
      'Select castors capable of supporting total dead and live loads.',
      'Castors shall have working load limits clearly marked.',
      'Lock castors during erection and use.',
      'Use and adjust suitable castors/legs to maintain a level platform.',
      'Provide plan bracing at the base according to manufacturer instructions.',
      'Before moving, check for overhead power lines and obstructions.',
      'Before moving, confirm ground is firm and level.',
      'No person shall remain on the mobile tower during movement.',
      'Secure equipment and materials against dislodgement.',
      'Check the travel surface for obstructions.',
      'Prevent electrical leads from becoming tangled.',
      'Do not move mobile towers in windy conditions.',
      'Push or pull from the base.',
      'Do not use powered vehicles to move mobile towers.',
      'Do not lift mobile/static towers by crane unless checked by a competent engineer.',
      'Do not use a crane to move lightweight aluminium scaffolds.',
    ],
  );

  static const Cop26Section _inspection = Cop26Section(
    number: '3.14',
    title: 'Inspection of Scaffolding',
    summary:
        'Scaffolding shall be inspected by competent persons and maintained in a safe and usable condition.',
    inspectionFrequency: [
      'Before first use.',
      'At least every 7 days thereafter.',
      'After alteration or repair.',
      'After any event that could affect scaffold stability, such as strong winds or storms.',
    ],
    inspectionPoints: [
      'Compliance with manufacturer instructions and approved design drawings.',
      'Scaffold structure is appropriate.',
      'Supporting structure is appropriate.',
      'Working platforms are secured and protected.',
      'Access and egress are appropriate.',
      'Scaffold permits the work to be performed safely and appropriately.',
    ],
    requirements: [
      'Inspect scaffold after erection and before use.',
      'Inspection shall be performed by a competent person.',
      'Where an engineer design exists, consult the engineer and obtain sign-off certification against the design drawings.',
      'Keep certification on site while scaffold is in use.',
      'The person responsible for erection shall provide a handover certificate.',
      'Keep the handover certificate on site until dismantling.',
      'Inspection frequency may need to increase depending on weather, site conditions, scaffold type and size, and collapse risk.',
      'Keep inspection records on site.',
    ],
    inspectionRecordFields: [
      'Location',
      'Comments',
      'Date',
      'Time',
      'Relevant design/specification reference',
      'Inspector details',
    ],
    scaffoldTagFields: [
      'Date erected',
      'Use',
      'Loading',
      'Last inspection',
      'Inspected by',
    ],
  );

  static const Cop26Section _references = Cop26Section(
    number: '4',
    title: 'References',
    references: [
      'BS EN 1004 – Mobile access and working towers made of prefabricated elements – Materials, dimensions, design loads, safety and performance requirements.',
    ],
  );

  static const Cop26Section _amendmentRecord = Cop26Section(
    number: '5',
    title: 'Document Amendment Record',
    amendments: [
      Cop26Amendment(
        version: '4.0',
        date: '15 July 2024',
        description:
            'System acronym updated from OSHAD-SF to ADOSH-SF; change from OSHAD to ADPHC; logo change; minor editorial changes; Mechanism 7 title updated; OSHAD-SF Mechanism 8.0 – OSH Practitioner Registration deleted.',
        pagesAffected: 'Throughout',
      ),
      Cop26Amendment(
        version: '4.1',
        date: '16 February 2026',
        description:
            'Minor editorial changes throughout the document without changing requirements.',
        pagesAffected: 'Throughout',
      ),
    ],
  );

  static const List<Cop26QuickReference> keyMeasurements = [
    Cop26QuickReference('Scaffold erection platform', 'Minimum 450 mm'),
    Cop26QuickReference(
      'Platform below erection level – housing construction',
      'Maximum 3 m',
    ),
    Cop26QuickReference(
      'Platform below erection level – other work',
      'Maximum 2.4 m',
    ),
    Cop26QuickReference('Internal scaffold gap trigger', 'Greater than 225 mm'),
    Cop26QuickReference('Minimum sole board', '225 mm × 450 mm'),
    Cop26QuickReference('Maximum single board gap', '25 mm'),
    Cop26QuickReference('Maximum total board gap', '50 mm'),
    Cop26QuickReference('Minimum plywood thickness', '17 mm'),
    Cop26QuickReference(
      'Plywood gap application',
      'Less than 500 mm unless engineer approved',
    ),
    Cop26QuickReference(
      'Maximum board overhang',
      '150 mm or 4 × board thickness, whichever is less',
    ),
    Cop26QuickReference('Toe board', 'Minimum 150 mm'),
    Cop26QuickReference('Guardrail', 'Minimum 950 mm'),
    Cop26QuickReference('Guardrail/mid-rail related gap', 'Maximum 470 mm'),
    Cop26QuickReference('Landing interval', 'Every 9 m'),
    Cop26QuickReference('Ladder/stair opening', 'Maximum 500 mm'),
    Cop26QuickReference('Ladder angle', 'Approximately 75°'),
    Cop26QuickReference(
      'Ladder extension above platform',
      'Minimum 1.05 m / 5 rungs',
    ),
    Cop26QuickReference(
      'Intermediate ladder landing',
      'Required above 9 m vertical rise',
    ),
    Cop26QuickReference(
      'Mobile/static tower height',
      'Maximum 3 × minimum base dimension unless otherwise specified',
    ),
    Cop26QuickReference(
      'Mobile tower stabilizer',
      'Raised no more than 25 mm',
    ),
    Cop26QuickReference(
      'Inspection interval',
      'Before first use and at least every 7 days',
    ),
    Cop26QuickReference(
      'Perimeter screen gap',
      'Maximum 25 mm',
    ),
    Cop26QuickReference(
      'Expansion-anchor working load',
      'Maximum 65% of first-slip load',
    ),
    Cop26QuickReference(
      'Expansion-anchor test proportion',
      '10%',
    ),
    Cop26QuickReference(
      'Chemical-anchor testing',
      'All chemical anchors where specified',
    ),
    Cop26QuickReference(
      'Anchor proof-load factor',
      'Working load × 1.25',
    ),
    Cop26QuickReference(
      'Anchor failure-load safety factor',
      '3:1',
    ),
  ];

  static const List<String> crossReferences = [
    'ADOSH-SF Element 1 – Roles, Responsibilities and Self-Regulation',
    'ADOSH-SF Element 2 – Risk Management',
    'ADOSH-SF Element 5 – Training, Awareness and Competency',
    'ADOSH-SF Mechanism 7.0 – Occupational Safety and Health Practitioner and Service Provider Registration',
    'ADOSH-SF CoP 17.0 – Safety Signage and Signals',
    'ADOSH-SF CoP 20.0 – Safety in Design (Construction)',
    'ADOSH-SF CoP 22.0 – Barricading of Hazards',
    'ADOSH-SF CoP 23.0 – Working at Heights',
    'ADOSH-SF CoP 37.0 – Ladders',
    'ADOSH-SF CoP 53.0 – OSH Management During Construction Work',
  ];

  static const List<String> fieldChecklist = [
    'Approved scaffold design/drawing available where required.',
    'Risk assessment completed.',
    'Safe system of work available.',
    'Competent scaffolders assigned.',
    'Ground/supporting structure checked.',
    'Baseplates and sole boards suitable.',
    'Bracing and ties installed.',
    'Platforms fully secured.',
    'Guardrails and toe boards installed.',
    'Safe access and egress provided.',
    'Internal gaps controlled.',
    'Falling-object controls established.',
    'Traffic/mobile-plant controls established.',
    'Incomplete scaffold sections barricaded and tagged.',
    'Scaffold inspected before first use.',
    'Seven-day inspection requirement maintained.',
    'Post-alteration/repair inspection completed.',
    'Post-storm/stability-event inspection completed.',
    'Inspection and handover records retained.',
    'Scaffold identification information displayed.',
  ];

  static const List<String> stopWorkIndicators = [
    'Scaffold stability is uncertain.',
    'Required design information is unavailable.',
    'Required competent person is unavailable.',
    'Unauthorised scaffold alteration is identified.',
    'Critical ties or braces are missing, loose or removed.',
    'Platforms or edge protection are incomplete where required.',
    'Unsafe access or egress exists.',
    'Scaffold is being used without required inspection/handover.',
    'Strong wind or other environmental conditions make the scaffold unsafe.',
    'Defective scaffold components are identified.',
    'Incomplete scaffold is accessible without effective warning and access control.',
    'Materials are being thrown or dropped from scaffold.',
    'Mobile tower is being moved with a person on it.',
    'Mobile tower is being moved in unsafe wind or ground conditions.',
  ];
}

class Cop26Section {
  final String number;
  final String title;
  final String? summary;
  final List<String> requirements;
  final List<String> hazards;
  final List<String> measurements;
  final List<Cop26Subsection> subsections;
  final List<String> documents;
  final List<String> trainingRecordFields;
  final List<String> inspectionFrequency;
  final List<String> inspectionPoints;
  final List<String> inspectionRecordFields;
  final List<String> scaffoldTagFields;
  final List<String> references;
  final List<Cop26Amendment> amendments;
  final String? fieldWarning;
  final List<String> controlHierarchy;

  const Cop26Section({
    required this.number,
    required this.title,
    this.summary,
    this.requirements = const [],
    this.hazards = const [],
    this.measurements = const [],
    this.subsections = const [],
    this.documents = const [],
    this.trainingRecordFields = const [],
    this.inspectionFrequency = const [],
    this.inspectionPoints = const [],
    this.inspectionRecordFields = const [],
    this.scaffoldTagFields = const [],
    this.references = const [],
    this.amendments = const [],
    this.fieldWarning,
    this.controlHierarchy = const [],
  });
}

class Cop26Subsection {
  final String number;
  final String title;
  final List<String> requirements;
  final List<String> measurements;
  final List<String> controlHierarchy;
  final List<String> officialReferences;

  const Cop26Subsection({
    required this.number,
    required this.title,
    this.requirements = const [],
    this.measurements = const [],
    this.controlHierarchy = const [],
    this.officialReferences = const [],
  });
}

class Cop26QuickReference {
  final String item;
  final String requirement;

  const Cop26QuickReference(this.item, this.requirement);
}

class Cop26Amendment {
  final String version;
  final String date;
  final String description;
  final String pagesAffected;

  const Cop26Amendment({
    required this.version,
    required this.date,
    required this.description,
    required this.pagesAffected,
  });
}
