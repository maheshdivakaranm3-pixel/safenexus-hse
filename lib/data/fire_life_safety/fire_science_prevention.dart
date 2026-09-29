// SafeNexus HSE — Fire & Life Safety
// First five topic content source. Keep inside lib/data/fire_life_safety/.
// Regulatory note: apply the current authority-approved UAE requirements and
// project specifications. International standards below are supplementary unless
// adopted by the applicable authority or contract.

import 'package:flutter/material.dart';

class FireSafetyQuestion {
  final String question;
  final String answer;
  const FireSafetyQuestion(this.question, this.answer);
}

class FireSafetyTopic {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final String overview;
  final List<FireSafetySection> sections;
  final List<String> checklist;
  final List<String> requiredDocuments;
  final List<FireSafetyQuestion> interviewQuestions;
  final List<String> references;

  const FireSafetyTopic({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.overview,
    required this.sections,
    required this.checklist,
    required this.requiredDocuments,
    required this.interviewQuestions,
    required this.references,
  });
}

class FireSafetySection {
  final String heading;
  final List<String> points;
  const FireSafetySection(this.heading, this.points);
}

class FireSciencePreventionTopics {
  static const List<FireSafetyTopic> topics = [
    FireSafetyTopic(
      id: 'FLS-01',
      title: 'Fire Science & Fire Triangle',
      subtitle: 'Combustion principles, fire growth and prevention fundamentals',
      icon: Icons.local_fire_department_rounded,
      accent: Color(0xFFF07814),
      overview: 'Fire is a rapid oxidation/combustion process that releases heat and often light. Sustained flaming generally requires fuel, an oxidizer (normally oxygen), sufficient heat and a self-sustaining chemical chain reaction. The fire triangle explains fuel, heat and oxygen; the fire tetrahedron adds the chain reaction. Prevention and extinguishment work by removing or interrupting one or more elements.',
      sections: [
        FireSafetySection('Purpose, scope & terminology', [
          'Use fire science to recognize ignition sources, combustible materials, oxygen enrichment and conditions that allow fire to grow.',
          'Combustion: a chemical reaction releasing heat; flaming and smouldering are different combustion modes.',
          'Ignition source: flame, hot surface, spark, electrical fault, friction, static discharge or other energy capable of initiating combustion.',
          'Flash point, fire point, auto-ignition temperature and flammable range are distinct properties; use the product Safety Data Sheet (SDS) and competent technical advice.',
        ]),
        FireSafetySection('Fire development & heat transfer', [
          'Conduction transfers heat through a material; convection transfers heat through moving gases; radiation transfers heat by electromagnetic waves.',
          'A developing fire can grow through ignition, growth, fully developed and decay stages; actual behaviour depends on fuel, ventilation, geometry and suppression.',
          'Smoke can contain toxic gases, hot particles and obscuring aerosols. Do not assume a smoke-filled route is safe or that visibility indicates breathable air.',
          'Ventilation changes can intensify fire. Do not open doors or alter ventilation during a fire unless directed by the incident commander or approved procedure.',
        ]),
        FireSafetySection('Individual hazards & consequences', [
          'Ignition of ordinary combustibles: burns, smoke exposure, asset loss and fire spread.',
          'Flammable vapour accumulation: flash fire, explosion, pressure effects and multiple casualties.',
          'Oxygen-enriched atmosphere: materials may ignite more readily and burn more intensely; keep oxygen equipment leak-free and away from oil/grease.',
          'Hidden smouldering: delayed re-ignition after apparent extinguishment.',
          'Smoke and heat migration: toxic exposure, disorientation, blocked escape and structural damage.',
        ]),
        FireSafetySection('Controls & field precautions', [
          'Eliminate unnecessary ignition sources; substitute less-flammable products where practicable; segregate fuel from heat and ignition sources.',
          'Maintain housekeeping; remove waste and combustible deposits using the approved waste route.',
          'Control hot work through the site permit system, suitable screening, fire watch and post-work checks as specified by the approved procedure.',
          'Keep fire doors, fire-stopping, ventilation controls and fire protection systems in their approved condition; never wedge fire doors open.',
          'Store and use chemicals according to SDS, compatibility rules, ventilation needs and approved quantities.',
          'Train workers to raise the alarm, evacuate and report; untrained personnel must not attempt firefighting beyond their training and safe escape conditions.',
        ]),
        FireSafetySection('Hierarchy of controls', [
          'Elimination: remove unnecessary combustible stock, ignition work or temporary fuel sources.',
          'Substitution: choose less hazardous/less flammable materials where technically feasible.',
          'Engineering: suitable separation, ventilation, electrical protection, fire-rated construction and approved detection/suppression.',
          'Administrative: risk assessment, PTW, housekeeping, inspections, training, signage and emergency arrangements.',
          'PPE: task-specific PPE for normal work; PPE is not a substitute for fire prevention or evacuation.',
        ]),
        FireSafetySection('Inspection, competency & records', [
          'Inspect for fuel accumulation, damaged electrical equipment, unauthorized hot work, blocked ventilation or exits, and altered fire protection.',
          'Workers need site induction and alarm/evacuation awareness; fire wardens and response personnel need role-specific training.',
          'Retain applicable fire risk assessment, SDS, permits, inspection findings, training, drill reports and corrective-action closure evidence.',
        ]),
        FireSafetySection('Stop-work & emergency response', [
          'Stop and report uncontrolled ignition sources, gas/vapour leaks, oxygen enrichment, impaired fire protection, unsafe hot work or blocked escape routes.',
          'On discovering fire: raise alarm, call the site emergency number / Civil Defence as applicable, warn others and evacuate by the safe route.',
          'Only trained, authorized persons may use an extinguisher on a small, incipient fire when the correct extinguisher is available, alarm is raised and a clear escape route remains.',
          'Do not re-enter or restart work until the authorized incident controller / site management confirms it is safe.',
        ]),
        FireSafetySection('Site example', [
          'A cutting task is planned near packaging. Remove or protect combustibles, verify permit conditions, provide suitable extinguisher and assigned fire watch, control sparks, and complete the prescribed post-work fire check. If combustible removal or fire watch cannot be achieved, do not start the task.',
        ]),
      ],
      checklist: [
        'Combustible materials and waste are controlled and removed from work areas.',
        'Ignition sources are identified and controlled; unauthorized hot work is absent.',
        'Chemical containers are identified and stored according to SDS and compatibility.',
        'Oxygen cylinders/equipment are secured, leak-free and segregated from contamination and ignition.',
        'Fire doors, fire stopping and approved ventilation arrangements are not compromised.',
        'Fire alarm, escape routes and assembly instructions are communicated to workers.',
        'Fire protection impairments are authorized, recorded and provided with approved compensatory measures.',
        'Defects have an owner, target date, interim control and closure verification.',
      ],
      requiredDocuments: [
        'Fire Risk Assessment / Fire Hazard Register',
        'Site Emergency Response Plan and evacuation drawing',
        'Applicable SDS for flammable / combustible products',
        'Hot Work Permit and associated risk assessment where applicable',
        'Fire protection inspection and impairment records',
        'Fire safety induction / toolbox talk attendance',
        'Fire drill report and corrective-action register',
      ],
      interviewQuestions: [
        FireSafetyQuestion('What are the elements of the fire triangle?', 'Fuel, heat and oxygen. The fire tetrahedron adds the self-sustaining chemical chain reaction.'),
        FireSafetyQuestion('How can a fire be controlled?', 'By removing fuel, cooling below the conditions needed for combustion, excluding oxygen where suitable, or interrupting the chain reaction using an appropriate approved agent.'),
        FireSafetyQuestion('Why is smoke dangerous?', 'It may contain toxic products, heat and particulates, reduce visibility and compromise escape.'),
        FireSafetyQuestion('What is the difference between flash point and auto-ignition temperature?', 'Flash point is the lowest specified test temperature at which a liquid gives off enough vapour to ignite momentarily under the test method; auto-ignition temperature is the temperature at which ignition occurs without an external flame or spark under defined test conditions.'),
        FireSafetyQuestion('What should an HSE Officer do if fire protection is impaired?', 'Stop or restrict affected activities as required, notify authorized management, record the impairment, implement approved compensatory controls and verify restoration before closure.'),
      ],
      references: [
        'UAE Fire and Life Safety Code of Practice — current edition and applicable authority amendments; verify applicability with the project authority.',
        'Applicable UAE Civil Defence / local Civil Defence authority requirements and approved project fire strategy.',
        'Product Safety Data Sheets and manufacturer instructions.',
        'NFPA fire science publications/standards — supplementary technical guidance only unless adopted by authority or contract.',
      ],
    ),
    FireSafetyTopic(
      id: 'FLS-02',
      title: 'Fire Classes',
      subtitle: 'Identify the burning material and choose a compatible extinguishing method',
      icon: Icons.whatshot_rounded,
      accent: Color(0xFFD94D65),
      overview: 'Fire classes group fires by the type of fuel involved so responders can select a compatible extinguishing agent. Class lettering differs among standards and jurisdictions; follow the extinguisher label, current UAE authority requirements and site emergency plan rather than relying on letter alone.',
      sections: [
        FireSafetySection('Common class concepts', [
          'Class A: ordinary solid combustibles such as wood, paper and many textiles.',
          'Class B: flammable liquids and, in some systems, flammable-liquid vapours; use the local adopted classification and equipment label.',
          'Class C: flammable gases in some classification systems; gas supply isolation is a critical control when safe and authorized.',
          'Class D: combustible metals; requires agent specifically suitable for the metal involved.',
          'Electrical equipment: some systems designate energized electrical fires separately; electricity is an added hazard, not a fuel class in every standard.',
          'Cooking oils/fats: often identified as Class F or Class K depending on the classification system; use a listed wet-chemical unit suitable for the appliance and fuel.',
        ]),
        FireSafetySection('Selection principles', [
          'Read the extinguisher label and rating; confirm the agent is suitable for the actual fuel and energized condition.',
          'Water can spread burning flammable liquid and may react dangerously with some metals or energized equipment.',
          'Do not apply water to burning cooking oil; sudden steam generation and splashing can cause severe burns and fire spread.',
          'For gas fires, isolate the supply only if it can be done safely by an authorized person; extinguishing a flame while gas continues to escape can create an explosive cloud.',
          'If the fire is growing, smoke is affecting escape, or the correct agent is unavailable, evacuate and leave firefighting to responders.',
        ]),
        FireSafetySection('Hazards & controls', [
          'Wrong agent selection can intensify fire, cause violent reaction, electrocution, splash burns or re-ignition.',
          'Identify likely fuels in the risk assessment and provide suitable, approved extinguishers at designated locations.',
          'Train users on local extinguisher labels and limitations; never assume all red cylinders contain the same agent.',
          'Keep access clear and prevent untrained persons from entering smoke or hazardous atmospheres.',
        ]),
        FireSafetySection('Field procedure', [
          'Raise alarm first and call the site emergency contact.',
          'Identify fuel only from a safe position; check the extinguisher label and escape route.',
          'Use only if trained, fire is small/incipient, conditions are safe and the route behind remains clear.',
          'If the first attempt does not control the fire promptly, withdraw, close doors if safe and evacuate.',
          'Report use or discharge and arrange replacement/recharge by an authorized service provider.',
        ]),
        FireSafetySection('Inspection & records', [
          'Verify type/agent, label legibility, pressure/indicator where fitted, pin/seal, hose/nozzle, body condition, access, signage and inspection/service status.',
          'Follow the manufacturer, adopted code and authority-approved maintenance schedule; do not invent a universal monthly/annual interval.',
          'Record unique asset ID, location, date, condition, defect, action owner and closure evidence.',
        ]),
        FireSafetySection('Stop-work & emergency response', [
          'Stop affected work if required extinguisher type is missing, discharged, damaged, inaccessible or unsuitable for the hazard.',
          'Never fight a fire involving unknown chemicals, reactive metals, pressurized cylinders or rapidly spreading smoke without specialist authorization and equipment.',
          'Evacuate, account for personnel and hand over fuel/material information and SDS to responders.',
        ]),
        FireSafetySection('Site example', [
          'A small cooking-oil fire occurs in a site kitchen. Do not use water. Raise alarm, isolate heat only if safe, use the approved cooking-oil extinguisher only if trained and the fire remains small; otherwise evacuate and call emergency responders.',
        ]),
      ],
      checklist: [
        'Likely fire fuels and classification are identified in the site risk assessment.',
        'Extinguisher agent and rating are suitable for the identified hazard and local code.',
        'Labels and operating instructions are legible.',
        'Units are accessible, mounted/located as approved and not obstructed.',
        'Safety pin, tamper seal, hose/nozzle and body show no visible damage.',
        'Pressure/indicator is within the manufacturer marked operating range where fitted.',
        'Inspection and service status are current under the applicable approved schedule.',
        'Workers know alarm, evacuation and limits of extinguisher use.',
      ],
      requiredDocuments: [
        'Fire extinguisher location plan / asset register',
        'Extinguisher inspection checklist and defect log',
        'Service / maintenance certificates and work orders',
        'Fire risk assessment identifying fuel classes',
        'Fire safety training records',
        'Emergency plan and site contact list',
      ],
      interviewQuestions: [
        FireSafetyQuestion('Why must extinguisher selection be based on the fuel?', 'Different agents cool, smother or interrupt combustion differently; an incompatible agent can spread fire or create additional hazards.'),
        FireSafetyQuestion('Can water be used on burning cooking oil?', 'No. Water can rapidly vaporize and eject burning oil, causing severe fire spread and burns.'),
        FireSafetyQuestion('What is the priority for a gas fire?', 'Raise alarm and arrange safe isolation of the gas supply by an authorized person; do not extinguish the flame while uncontrolled gas continues to escape.'),
        FireSafetyQuestion('What should you do if an extinguisher is discharged?', 'Remove it from service, identify it as unavailable, arrange authorized recharge/replacement and record the action.'),
        FireSafetyQuestion('What are the limits of portable extinguisher use?', 'Only trained persons, small incipient fires, correct agent, safe conditions and a clear escape route; otherwise evacuate.'),
      ],
      references: [
        'UAE Fire and Life Safety Code of Practice — current edition and authority-approved project requirements.',
        'Extinguisher label, manufacturer instructions and approved maintenance provider guidance.',
        'Applicable local Civil Defence requirements.',
        'NFPA 10 — supplementary reference; confirm adoption and edition before treating as a contractual/legal requirement.',
      ],
    ),
    FireSafetyTopic(
      id: 'FLS-03',
      title: 'Fire Prevention',
      subtitle: 'Control ignition sources, combustible loading and unsafe storage',
      icon: Icons.shield_rounded,
      accent: Color(0xFF279B80),
      overview: 'Fire prevention is the planned elimination or control of ignition sources, fuel and conditions that allow fire to start or spread. Controls must be specific to the activity, material, building, temporary works and approved project fire strategy.',
      sections: [
        FireSafetySection('Prevention program', [
          'Identify combustible materials, ignition sources, oxygen-enrichment risks and people who may be affected.',
          'Apply housekeeping and waste removal routines; prevent accumulation in plant rooms, escape routes, roof spaces and temporary accommodation.',
          'Control smoking/vaping only in designated approved areas and dispose of smoking materials safely.',
          'Use approved electrical equipment; inspect leads, plugs, temporary distribution boards and overload protection.',
          'Store flammable liquids in suitable approved containers/cabinets and segregate incompatible materials in accordance with SDS and authority requirements.',
        ]),
        FireSafetySection('Hot surfaces & hot work', [
          'Use the site PTW and risk assessment process for welding, cutting, grinding, brazing or other spark/heat-producing work.',
          'Remove or protect combustible materials, openings and concealed spaces from sparks and hot slag.',
          'Provide a trained fire watch and suitable firefighting equipment when required by permit/risk assessment.',
          'Inspect the work area after completion for smouldering or hidden ignition as specified by approved procedure.',
        ]),
        FireSafetySection('Electrical and equipment controls', [
          'Do not use damaged cables, exposed conductors, makeshift joints or equipment with signs of overheating.',
          'Do not overload sockets or bypass protective devices; report repeated tripping and abnormal heat/smell.',
          'Keep equipment ventilation openings clear and follow manufacturer duty/maintenance instructions.',
          'Use suitable hazardous-area equipment where a classified hazardous atmosphere exists; classification and selection require competent design review.',
        ]),
        FireSafetySection('Hazards, responsibilities & documents', [
          'Common hazards: accumulated waste, unauthorized hot work, leaking fuel, incompatible storage, overloaded circuits, blocked fire doors and disabled detection/suppression.',
          'Project management provides resources; supervisors enforce controls; workers report unsafe conditions; HSE verifies and tracks findings.',
          'Keep housekeeping inspections, hot work permits, SDS, electrical inspection records, fire system impairment permits and toolbox talk evidence.',
        ]),
        FireSafetySection('Stop-work & emergency response', [
          'Stop work for uncontrolled sparks near combustibles, suspected gas leak, overheating electrical equipment, missing permit controls or blocked escape.',
          'Raise alarm and evacuate on fire; do not delay evacuation to collect tools or belongings.',
          'Do not restore isolated equipment or fire systems until authorized competent personnel verify safe restoration.',
        ]),
        FireSafetySection('Site example', [
          'Packaging waste is accumulating beside a temporary distribution board. The supervisor arranges safe waste removal, checks electrical condition, maintains access and records the corrective action before the area returns to normal use.',
        ]),
      ],
      checklist: [
        'Fire hazards and ignition sources have been identified for the work area.',
        'Combustible waste is removed at the planned frequency and never blocks exits.',
        'Hot work is authorized and permit controls are implemented.',
        'Flammable materials are labeled, closed, segregated and stored as approved.',
        'Electrical equipment and cables are undamaged and not overloaded.',
        'Smoking controls and designated areas are communicated.',
        'Fire doors, access to equipment and escape routes remain clear.',
        'Defects are reported, risk-controlled and closed with evidence.',
      ],
      requiredDocuments: [
        'Fire Prevention Plan / Fire Risk Assessment',
        'Housekeeping inspection checklist and waste records',
        'Hot Work Permit, JSA/RA and fire-watch record where applicable',
        'SDS and chemical storage/compatibility register',
        'Electrical inspection / maintenance records',
        'Fire system impairment and restoration records',
        'Toolbox talk / induction records',
      ],
      interviewQuestions: [
        FireSafetyQuestion('What are the three broad fire prevention priorities?', 'Control ignition sources, control combustible fuel and maintain the building/site fire protection and escape arrangements.'),
        FireSafetyQuestion('Why is housekeeping a fire control?', 'It reduces available fuel, prevents fire spread and keeps access to exits and firefighting equipment clear.'),
        FireSafetyQuestion('What should happen before hot work starts?', 'Complete risk assessment and permit requirements, remove/protect combustibles, verify equipment and fire protection, assign fire watch where required and brief workers.'),
        FireSafetyQuestion('What do repeated electrical trips indicate?', 'They may indicate overload, fault or unsuitable equipment; stop unsafe use and have a competent electrician investigate rather than repeatedly resetting.'),
        FireSafetyQuestion('Who is responsible for fire prevention?', 'Everyone has duties; management provides systems/resources, supervisors implement controls, workers comply/report, and HSE monitors and verifies.'),
      ],
      references: [
        'Current UAE Fire and Life Safety Code of Practice and applicable Civil Defence requirements.',
        'Approved project fire strategy, site emergency plan and PTW procedure.',
        'Chemical SDS and equipment manufacturer instructions.',
        'NFPA and other recognized fire-prevention guidance — supplementary unless adopted.',
      ],
    ),
    FireSafetyTopic(
      id: 'FLS-04',
      title: 'Fire Risk Assessment',
      subtitle: 'Identify fire hazards, evaluate risk and verify control measures',
      icon: Icons.fact_check_rounded,
      accent: Color(0xFF7C55C7),
      overview: 'A fire risk assessment is a documented, site-specific process to identify ignition sources, fuel, oxygen-enrichment conditions, people at risk, fire and smoke spread, escape, detection, firefighting arrangements and residual risk. It must be reviewed when conditions, occupancy, materials, work methods or protection systems change.',
      sections: [
        FireSafetySection('Assessment workflow', [
          'Define area, activity, operating conditions, occupancy and assessment boundaries.',
          'Identify fuel, ignition sources, oxygen sources, fire load, concealed spaces and potential fire/smoke pathways.',
          'Identify people at risk, including visitors, night-shift workers, persons needing assistance and contractors unfamiliar with the site.',
          'Review prevention, detection, alarm, escape, emergency lighting, firefighting equipment, access and response arrangements.',
          'Evaluate likelihood and consequence using the approved company/project risk matrix; do not substitute an unapproved scoring method.',
          'Select controls using hierarchy of controls, assign owners and deadlines, then assess residual risk.',
          'Communicate significant findings and verify action closure in the field.',
        ]),
        FireSafetySection('Risk factors & consequences', [
          'Fuel quantity, physical form, volatility, storage arrangement and compatibility.',
          'Ignition probability from hot work, electrical faults, hot surfaces, friction, static or smoking.',
          'Ventilation, compartmentation, fire doors, penetrations and potential smoke spread.',
          'Occupancy, mobility, familiarity, shift patterns and distance/availability of safe exits.',
          'Potential outcomes include burns, smoke inhalation, fatality, structural damage, business interruption and environmental release.',
        ]),
        FireSafetySection('Controls and verification', [
          'Prioritize removal/reduction of fuel and ignition sources before relying on procedures or PPE.',
          'Verify alarm audibility/visibility, exit usability, emergency lighting, fire doors and approved fire systems through competent inspection/testing.',
          'Record existing controls separately from proposed actions; do not mark an action complete until evidence is checked.',
          'Use competent fire engineering / authority review for design, occupancy, travel-distance, capacity or code-compliance questions.',
        ]),
        FireSafetySection('Review triggers', [
          'New project phase, layout, occupancy, temporary building or change in use.',
          'New chemical/fuel, process, hot-work activity or significant increase in combustible storage.',
          'Fire, near miss, drill finding, repeated alarm or system impairment.',
          'Change to exit routes, fire doors, detection, suppression, ventilation or authority requirements.',
          'At the review interval required by the applicable management system, authority or project procedure.',
        ]),
        FireSafetySection('Stop-work & emergency response', [
          'Do not authorize affected work where risk is unacceptable, critical controls are absent or escape/protection is impaired.',
          'Escalate unresolved high-risk findings to the responsible manager and competent fire-safety authority/engineer as applicable.',
          'If fire occurs, activate the emergency plan; the assessment is not a substitute for alarm, evacuation and incident command.',
        ]),
        FireSafetySection('Site example', [
          'A warehouse changes from low-volume storage to high-rack combustible stock. Reassess fire load, storage arrangement, detection/suppression suitability, access, evacuation and authority approval before the changed operation begins.',
        ]),
      ],
      checklist: [
        'Assessment scope, location, activity and review date are defined.',
        'Fuel, ignition sources, oxygen enrichment and fire spread paths are identified.',
        'All relevant people at risk and shift/visitor conditions are considered.',
        'Prevention, detection, alarm, escape and firefighting controls are verified.',
        'Risk rating follows the approved project/company matrix.',
        'Actions have responsible owners, target dates and interim controls.',
        'Residual risk is evaluated and accepted by the authorized role.',
        'Findings are communicated and evidence-based closure is recorded.',
        'Review triggers and next review date are documented.',
      ],
      requiredDocuments: [
        'Fire Risk Assessment / Fire Hazard Register',
        'Approved project risk matrix and risk acceptance criteria',
        'Fire strategy / approved fire and life safety drawings, where applicable',
        'Emergency Response Plan and evacuation plan',
        'Fire system inspection/testing and impairment records',
        'Action tracker with closure evidence',
        'Review / approval and worker communication records',
      ],
      interviewQuestions: [
        FireSafetyQuestion('What is the purpose of a fire risk assessment?', 'To identify fire hazards and people at risk, evaluate existing controls, determine further measures and verify that residual risk is acceptable.'),
        FireSafetyQuestion('When should it be reviewed?', 'When there is a material change in layout, occupancy, fuel, process, protection system, incident, drill finding or applicable requirements, and at the required planned interval.'),
        FireSafetyQuestion('What is residual risk?', 'The risk remaining after specified controls are implemented and verified.'),
        FireSafetyQuestion('Can an HSE Officer approve fire engineering design values?', 'Only if formally competent and authorized. Design/code compliance values should be confirmed by the qualified designer and relevant authority.'),
        FireSafetyQuestion('How do you close a fire-risk action?', 'Verify the control in the field, review objective evidence, confirm the responsible person and date, and update the action register; do not close based only on verbal assurance.'),
      ],
      references: [
        'Current UAE Fire and Life Safety Code of Practice and applicable local Civil Defence authority requirements.',
        'Approved project fire strategy, drawings, risk matrix and emergency plan.',
        'UAE regulatory and authority circulars applicable to the project; confirm current version with the authority.',
        'ISO 31000 risk management principles — supplementary framework, not a fire-code substitute.',
      ],
    ),
    FireSafetyTopic(
      id: 'FLS-05',
      title: 'Fire Extinguishers',
      subtitle: 'Types, selection, safe use, inspection and maintenance',
      icon: Icons.fire_extinguisher_rounded,
      accent: Color(0xFF249B82),
      overview: 'Portable fire extinguishers are first-response equipment for small incipient fires. Selection must match the fuel, electrical condition, environment, user competency and authority-approved fire strategy. They are not a substitute for alarm, evacuation, fixed protection or emergency services.',
      sections: [
        FireSafetySection('Common extinguisher agents', [
          'Water: primarily cooling for suitable Class A materials; not for energized electrical equipment, burning liquids or water-reactive materials.',
          'Foam: suitable for specified Class A/B risks according to label; avoid use where incompatible with energized equipment or chemicals.',
          'Carbon dioxide (CO₂): useful for certain flammable-liquid/electrical risks; discharge horn can become very cold and ventilation/re-ignition concerns remain.',
          'Dry chemical powder: agent type and rating determine suitability; discharge reduces visibility and can affect sensitive equipment.',
          'Wet chemical: designed for specified cooking-oil/fat hazards; follow label and appliance procedure.',
          'Class D powder: must be selected for the specific combustible metal; ordinary agents may be ineffective or dangerous.',
        ]),
        FireSafetySection('Selection & positioning', [
          'Base type, rating, quantity and location on approved design, hazard assessment, authority requirements and applicable code.',
          'Consider travel/access, visibility, mounting, environmental exposure, tampering, obstruction and user capability.',
          'Do not invent universal spacing or mounting-height values; verify the adopted code, approved drawings and manufacturer instructions.',
          'Provide signage and identification consistent with the approved site plan and applicable requirements.',
        ]),
        FireSafetySection('Safe operating method', [
          'Raise alarm and ensure emergency services/site response are notified.',
          'Select the correct labelled extinguisher; maintain a clear escape route behind you and stay upwind where relevant.',
          'Use only if trained and the fire is small, contained and not producing dangerous smoke/heat.',
          'Follow the device instructions (often remembered as PASS: Pull, Aim, Squeeze, Sweep, where applicable to the model).',
          'Withdraw if fire grows, agent is ineffective, smoke increases or escape is threatened. Do not turn your back on the fire while retreating.',
          'After use, report and remove the unit from service for authorized recharge/replacement, even if only partly discharged.',
        ]),
        FireSafetySection('Inspection & maintenance', [
          'Check correct type/rating, location, accessibility, signage, label legibility, body/corrosion, pin/seal, hose/nozzle, pressure indicator where fitted and service status.',
          'Inspection frequency and maintenance must follow current authority-adopted code, approved project schedule, manufacturer and competent service provider; record the actual governing basis.',
          'Do not dismantle, pressure-test or recharge unless authorized and competent.',
          'Defective, discharged, expired or inaccessible units must be made unavailable for reliance, replaced or otherwise covered by approved temporary controls.',
        ]),
        FireSafetySection('Responsibilities & records', [
          'Employer/project management provides suitable equipment and maintenance resources.',
          'HSE/supervisor verifies availability and records findings; competent service provider performs required servicing.',
          'Workers receive awareness/training and use equipment only within training and safe conditions.',
          'Maintain asset ID, location, agent/rating, inspection date, defects, action owner, service evidence and next due date.',
        ]),
        FireSafetySection('Stop-work & emergency response', [
          'Stop/restrict affected activity if required extinguisher is missing, wrong type, damaged, discharged, overdue under governing schedule or blocked.',
          'Do not attempt firefighting on pressurized cylinders, unknown chemicals, reactive metals or a fire beyond incipient stage unless specialist response is assigned.',
          'Evacuate, account for people and provide responders with fuel/SDS information.',
        ]),
        FireSafetySection('Site example', [
          'A workshop extinguisher has a broken seal and unreadable label. Tag it out, arrange an approved replacement immediately, assess whether temporary controls or work restriction are needed, record the defect and verify closure.',
        ]),
      ],
      checklist: [
        'Extinguisher type and rating match the approved fire risk assessment and location.',
        'Unit is in its designated location, visible and accessible.',
        'Signage and operating label are legible.',
        'Pin and tamper seal are present and undamaged.',
        'Hose, horn/nozzle, handle and body have no visible damage or corrosion.',
        'Pressure indicator is within the manufacturer-marked range where fitted.',
        'Inspection/service tag and records meet the applicable approved schedule.',
        'Unit is not discharged, obstructed, leaking or otherwise defective.',
        'Defects are tagged, reported, replaced/controlled and closed with evidence.',
        'Relevant workers know alarm/evacuation priority and extinguisher-use limitations.',
      ],
      requiredDocuments: [
        'Approved fire extinguisher layout / location plan',
        'Fire extinguisher asset register (ID, type, rating, location)',
        'Routine inspection checklist and defect/corrective-action log',
        'Competent service / maintenance certificates and work orders',
        'Fire risk assessment and emergency response plan',
        'User training / fire awareness records',
      ],
      interviewQuestions: [
        FireSafetyQuestion('What does PASS commonly stand for?', 'Pull the pin, Aim at the base of the fire, Squeeze the handle and Sweep side to side; follow the actual extinguisher instructions and training.'),
        FireSafetyQuestion('Can CO₂ be used in a small enclosed room?', 'Only within the equipment label, training and risk controls; CO₂ can displace oxygen and create an asphyxiation hazard, so evacuation and ventilation considerations are essential.'),
        FireSafetyQuestion('What do you do with a defective extinguisher?', 'Tag/remove it from reliance, provide approved replacement or interim controls, report it, arrange competent service and document verified closure.'),
        FireSafetyQuestion('Who may service an extinguisher?', 'A competent, authorized service provider under applicable authority, manufacturer and project requirements.'),
        FireSafetyQuestion('When should a worker attempt to extinguish a fire?', 'Only when trained, alarm is raised, correct agent is available, fire is small and incipient, conditions are safe and a clear escape route remains; otherwise evacuate.'),
      ],
      references: [
        'Current UAE Fire and Life Safety Code of Practice and applicable Civil Defence authority requirements.',
        'Approved project fire strategy, extinguisher schedule and site emergency plan.',
        'Extinguisher manufacturer label, operating and maintenance instructions.',
        'NFPA 10 — supplementary reference; verify whether and which edition is adopted by the applicable authority/project.',
      ],
    ),
  ];
}
