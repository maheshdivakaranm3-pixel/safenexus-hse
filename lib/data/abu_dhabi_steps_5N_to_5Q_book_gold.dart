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
