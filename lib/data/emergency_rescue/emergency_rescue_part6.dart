// SafeNexus HSE — Emergency & Rescue Part 6 — Topics 21–30
// General field-learning guidance. Apply the approved site ERP, risk assessment,
// competent-person direction, manufacturer instructions and authority requirements.
// This material is not a substitute for practical training or emergency services.

import 'emergency_rescue_part1.dart';

const List<EmergencyRescueTopic> emergencyRescuePart6 = <EmergencyRescueTopic>[
  EmergencyRescueTopic(
    id: 'ER-21',
    title: 'Emergency Response Plan (ERP) Development & Control',
    purpose: 'Establish a controlled, site-specific plan that enables personnel to recognize emergencies, raise the alarm, protect life, summon support, coordinate response and recover safely.',
    scope: 'Applies to construction, industrial, logistics, utilities, marine and office/camp operations, including contractors and visitors.',
    keyKnowledge: <String>[
      'Build the ERP from credible site scenarios: fire, medical event, confined-space incident, work-at-height casualty, spill, severe weather, utility failure and external threat where relevant.',
      'Define alarm methods, emergency numbers, incident command, evacuation routes, assembly areas, headcount, access for responders and interfaces with external emergency services.',
      'Assign primary and alternate roles for each shift. Define who may order evacuation, isolate operations, communicate externally and authorize re-entry.',
      'Map vulnerable persons, remote work fronts, night shifts, language needs, simultaneous operations and changing site phases.',
      'Keep controlled copies accessible at control points and work fronts; brief revisions and withdraw obsolete versions.',
      'Do not assume one generic ERP fits every worksite. Link task-specific rescue plans and specialist procedures to the master plan.',
    ],
    siteImplementation: <String>[
      'Appoint an accountable plan owner and multidisciplinary review team.',
      'Walk the site to verify routes, gates, assembly areas, responder access and equipment locations.',
      'Display emergency contacts and simple alarm instructions in languages understood by the workforce.',
      'Test the plan through scenario-based drills, record gaps, assign owners and verify corrective actions.',
      'Review after layout/process changes, incidents, drill findings or changes in external emergency arrangements.',
    ],
    practicalExample: <String>[
      'A project adds a night shift and relocates its muster point. The ERP owner updates maps, checks lighting and access, briefs all shifts and runs a headcount drill before treating the change as operational.',
    ],
    stopWorkConditions: <String>[
      'Stop affected work when the required emergency arrangements, alarm route, safe exit or competent response coverage is unavailable.',
      'Do not restart after an emergency until the authorized site representative confirms the area and controls are safe.',
    ],
    interviewQuestions: <String>[
      'What are the essential elements of a site ERP?',
      'How do you verify that contractors and night-shift workers understand the plan?',
      'When should an ERP be reviewed or revised?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-22',
    title: 'Emergency Risk Assessment & Scenario Planning',
    purpose: 'Identify credible emergency scenarios before work starts and match each scenario with prevention, warning, response capability and recovery arrangements.',
    scope: 'Applies during project planning, mobilization, method-statement review, change management and periodic site review.',
    keyKnowledge: <String>[
      'Review task risk assessments, site layout, hazardous substances, energy sources, occupancy, access constraints, weather exposure and nearby public interfaces.',
      'Consider low-frequency/high-consequence events as well as foreseeable routine emergencies; avoid relying only on past incident history.',
      'For each scenario identify initiating event, exposed people, escalation path, detection method, alarm, immediate protective action, resources and external support.',
      'Assess rescue feasibility: casualty access, retrieval path, equipment, trained responders, communication and time-critical limitations.',
      'Use credible site information and competent specialist input. Do not invent numerical response times or risk thresholds.',
      'Reassess when equipment, process, workforce, layout, simultaneous operations or environmental conditions change.',
    ],
    siteImplementation: <String>[
      'Conduct a multi-discipline workshop with operations, HSE, supervisors, first aiders and relevant specialists.',
      'Create a scenario register linking each hazard to an ERP section, responsible role, equipment and drill.',
      'Validate scenarios through walk-throughs and practical exercises.',
      'Track actions to closure and retain the assessment with controlled project records.',
    ],
    practicalExample: <String>[
      'A project identifies that a casualty inside a deep excavation cannot be reached by ordinary first aiders. The team plans access control, competent rescue support, plant exclusion and an agreed emergency-service interface before excavation begins.',
    ],
    stopWorkConditions: <String>[
      'Pause high-risk work if a credible emergency has no workable warning, escape or response arrangement.',
      'Stop and reassess after an unplanned change invalidates the scenario assumptions.',
    ],
    interviewQuestions: <String>[
      'How is emergency scenario planning different from a task risk assessment?',
      'How do you decide whether specialist rescue capability is needed?',
      'What changes trigger reassessment?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-23',
    title: 'Emergency Alarm & Communication Systems',
    purpose: 'Ensure a warning is recognized, understood and acted upon across the site, including noisy, remote and multilingual work areas.',
    scope: 'Applies to audible/visual alarms, radios, public-address systems, phones, runners and backup communication methods.',
    keyKnowledge: <String>[
      'Define distinct alarm signals only where personnel can reliably distinguish them; explain the required action for each signal.',
      'Provide backup methods for power loss, radio dead zones, high noise, dust, poor visibility and network outage.',
      'Use plain language, confirmed location and concise messages: event, hazard, people affected, action required and caller identity.',
      'Test coverage at actual work fronts and shifts; maintain devices, batteries, repeaters and contact lists.',
      'Avoid transmitting unverified casualty names or sensitive details over open channels.',
      'Establish a method to acknowledge, relay and close emergency messages so warnings are not assumed received.',
    ],
    siteImplementation: <String>[
      'Map alarm audibility/visibility and radio coverage through representative site conditions.',
      'Train workers to raise the alarm and state the location using site landmarks or grid references.',
      'Assign a communication lead to coordinate updates and prevent conflicting instructions.',
      'Record system tests, faults, repairs and temporary compensating measures.',
    ],
    practicalExample: <String>[
      'A worker reports smoke in a remote store where the siren is not audible. The radio call triggers the agreed backup alert and the area marshal confirms that nearby workers have received the evacuation instruction.',
    ],
    stopWorkConditions: <String>[
      'Suspend affected operations if the required alarm or emergency communication method is inoperative and no approved effective backup exists.',
      'Do not use an untested signal that could be confused with routine site communication.',
    ],
    interviewQuestions: <String>[
      'How do you confirm alarm coverage across a large site?',
      'What information should an emergency radio call contain?',
      'What is your backup if the primary alarm fails?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-24',
    title: 'Emergency Control Room & Coordination',
    purpose: 'Provide a controlled coordination point for receiving reports, maintaining the incident picture, mobilizing resources and supporting the incident commander.',
    scope: 'Applies where the site ERP designates a control room, control point or incident coordination location.',
    keyKnowledge: <String>[
      'Maintain current site plans, emergency contacts, access/gate information, hazardous-material information and response-team rosters.',
      'Record time-stamped reports, decisions, notifications, resource requests and status updates.',
      'Keep one authoritative incident log and communicate verified updates to the incident commander.',
      'Provide backup location and communications if the control room is affected by the incident.',
      'Control access to the coordination point and protect confidential personal or medical information.',
      'The control room supports command; it does not replace the incident commander or external emergency-service command structure.',
    ],
    siteImplementation: <String>[
      'Identify primary and alternate control points and test their power, communications and accessibility.',
      'Use a simple incident board showing event, location, hazards, people accounted for, actions, resources and outstanding decisions.',
      'Assign trained log keeper and communications roles for each shift.',
      'Conduct a tabletop exercise involving simultaneous reports and changing conditions.',
    ],
    practicalExample: <String>[
      'During a fire alarm, the control point logs the reported location, confirms the alarm, dispatches the designated response team, shares gate access details with responders and records the headcount status without sending untrained personnel into the hazard zone.',
    ],
    stopWorkConditions: <String>[
      'Transfer coordination to the designated alternate point if the primary location becomes unsafe or loses essential capability.',
      'Do not issue conflicting tactical instructions outside the agreed command structure.',
    ],
    interviewQuestions: <String>[
      'What information should be available in an emergency control room?',
      'How do you maintain a reliable incident log?',
      'How does site command interface with public emergency services?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-25',
    title: 'Emergency Response Team (ERT) Roles & Competency',
    purpose: 'Ensure designated responders understand their authority, limits, communication duties and competence for the tasks they may be assigned.',
    scope: 'Applies to wardens, first aiders, fire teams, rescue teams, incident command support and specialist contractors.',
    keyKnowledge: <String>[
      'Define roles, deputies, shift coverage, call-out method, reporting line and limits of intervention.',
      'Match competence to the actual hazard and equipment; attendance at a general awareness session is not proof of technical rescue competence.',
      'Provide role-specific practical training, refresher arrangements and scenario drills.',
      'Confirm fitness, PPE, equipment familiarity and safe access before assigning response duties.',
      'Responders must not enter an atmosphere, energized area, unstable excavation or other uncontrolled hazard beyond their training and authorization.',
      'Coordinate with external responders and avoid self-deployment into an incident scene.',
    ],
    siteImplementation: <String>[
      'Maintain a current roster with primary and alternate personnel for all operating shifts.',
      'Keep training and competency evidence current and accessible.',
      'Brief contractors on how to summon the ERT and who controls the response.',
      'Evaluate team performance during drills and close competence gaps before assigning the role.',
    ],
    practicalExample: <String>[
      'A confined-space alarm is raised. The standby person raises the alarm and follows the rescue plan; only the designated competent rescue team performs entry or retrieval within its approved capability.',
    ],
    stopWorkConditions: <String>[
      'Do not commence work requiring a designated emergency role when required coverage or competence is absent.',
      'Withdraw responders if conditions exceed the approved plan, equipment capability or their competence.',
    ],
    interviewQuestions: <String>[
      'How do you verify ERT coverage on every shift?',
      'What is the difference between an emergency warden and a technical rescuer?',
      'When should responders wait for specialist assistance?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-26',
    title: 'Emergency Assembly Point & Muster Control',
    purpose: 'Move people to a safer designated location and establish reliable accountability without exposing them to secondary hazards.',
    scope: 'Applies to evacuation, sheltering, partial evacuation, camps, offices and dispersed work fronts.',
    keyKnowledge: <String>[
      'Select assembly areas using site-specific fire, smoke, traffic, wind direction, hazardous release, falling-object and responder-access considerations.',
      'Provide clear routes, signs, lighting and accessible arrangements; identify alternate assembly locations.',
      'Use attendance systems that reconcile employees, contractors, visitors and people temporarily away from their work area.',
      'Report missing persons and last known location to the incident commander; do not send untrained people back to search.',
      'Keep muster areas clear of emergency vehicle access and avoid blocking gates or roads.',
      'A headcount is not complete until discrepancies are investigated through the approved process.',
    ],
    siteImplementation: <String>[
      'Show primary and alternate muster points on current maps and induction materials.',
      'Assign marshals and headcount responsibilities by zone and shift.',
      'Conduct drills that test visitor/contractor reconciliation and alternate routes.',
      'Review assembly-point suitability as the site footprint changes.',
    ],
    practicalExample: <String>[
      'Smoke moves toward the primary assembly area. The warden directs people to the predesignated alternate point and reports the new location to the control point for headcount reconciliation.',
    ],
    stopWorkConditions: <String>[
      'Do not use an assembly point exposed to the incident or blocking responder access.',
      'Do not authorize re-entry based solely on a completed headcount; wait for the designated all-clear.',
    ],
    interviewQuestions: <String>[
      'How do you account for visitors and subcontractors?',
      'What do you do if someone is missing at muster?',
      'When should an alternate assembly point be used?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-27',
    title: 'Evacuation Assistance & Personal Emergency Plans',
    purpose: 'Make emergency warning and escape arrangements usable for people who may need assistance because of mobility, sensory, language, temporary injury or other access needs.',
    scope: 'Applies to workers, visitors and contractors who may need an individualized or coordinated evacuation arrangement.',
    keyKnowledge: <String>[
      'Discuss support needs respectfully and confidentially with the person; do not make assumptions based on appearance.',
      'Agree a practical personal emergency evacuation plan where needed, including alarm recognition, route, assistance role, communication and safe refuge arrangements if applicable.',
      'Do not use lifts or evacuation devices unless the site plan and equipment are specifically designed and approved for that purpose.',
      'Train assigned assistants and alternates; ensure they are present on the relevant shift.',
      'Consider visitors, temporary injuries, pregnancy-related mobility needs and language comprehension through the site process.',
      'Keep personal information restricted to those who need it for emergency support.',
    ],
    siteImplementation: <String>[
      'Include accessibility in route inspections, induction, drill planning and change reviews.',
      'Agree arrangements with the individual and relevant competent personnel before an emergency.',
      'Test the plan through a safe, planned exercise without creating unnecessary risk or disclosing private information.',
      'Review after workplace, role, route or support-person changes.',
    ],
    practicalExample: <String>[
      'A worker temporarily using crutches is assigned a clear route and trained assistance arrangement. The supervisor confirms the support person and alternate are available for the shift.',
    ],
    stopWorkConditions: <String>[
      'Do not assign a person to a work area where their agreed emergency egress arrangement is unavailable or unsuitable.',
      'Do not improvise a carry or rescue method beyond training and approved equipment.',
    ],
    interviewQuestions: <String>[
      'What should a personal emergency evacuation plan include?',
      'How do you protect privacy while ensuring responders have necessary information?',
      'How do you plan for visitors who need assistance?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-28',
    title: 'Ambulance & External Emergency-Service Coordination',
    purpose: 'Enable prompt, clear access and handover to qualified external responders while maintaining site control and protecting other personnel.',
    scope: 'Applies to medical emergencies, fire, rescue, hazardous-material events and incidents requiring public emergency services.',
    keyKnowledge: <String>[
      'Use the current locally verified emergency contact process; do not rely on an unverified number or outdated contact sheet.',
      'Provide exact site name, gate, location reference, event type, hazards, casualty count if known, access restrictions and caller callback details.',
      'Assign a gate marshal to meet responders and guide them by a safe route; keep access roads and turning areas clear.',
      'Share relevant hazard information, site plans, isolation status and known exposure details with responders.',
      'Keep a trained first aider with the casualty when safe and within competence; do not delay an emergency call while seeking management approval.',
      'Record notification and handover times and follow the external incident commander’s directions within the applicable command arrangement.',
    ],
    siteImplementation: <String>[
      'Verify contact details and site access instructions during mobilization and periodically thereafter.',
      'Provide responders with clear gate signage, coordinates or a reliable site grid reference.',
      'Conduct coordination visits or tabletop exercises where appropriate.',
      'Document handover and preserve relevant incident records.',
    ],
    practicalExample: <String>[
      'A worker suffers a serious injury in a large project. The caller gives the gate and grid location, a marshal meets the ambulance, and the first aider provides a concise handover of observed condition and actions taken.',
    ],
    stopWorkConditions: <String>[
      'Stop affected work and secure the access route when emergency vehicles are approaching.',
      'Do not move a casualty with suspected serious trauma unless an immediate danger makes movement necessary or trained responders direct it.',
    ],
    interviewQuestions: <String>[
      'What information should be given when requesting an ambulance?',
      'Why is a gate marshal important on a large project?',
      'What information belongs in a clinical handover?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-29',
    title: 'Emergency Power Failure & Utility Isolation',
    purpose: 'Protect people when loss or failure of electrical power, lighting, ventilation, communications or other utilities creates an emergency or worsens an existing event.',
    scope: 'Applies to construction sites, plants, temporary facilities, critical systems and utility interfaces.',
    keyKnowledge: <String>[
      'Identify critical loads and safe states: emergency lighting, alarms, communications, ventilation, pumps, access controls and process safety systems.',
      'Only authorized competent persons operate electrical isolation or switching systems; treat equipment as energized until verified safe.',
      'Consider secondary hazards such as darkness, trapped persons, loss of ventilation, automatic restart, stored energy and loss of fire protection.',
      'Use approved lockout/tagout and verification procedures before intervention; emergency isolation does not remove the need to control other energy sources.',
      'Provide safe backup arrangements and communicate the affected areas and restrictions.',
      'Restore utilities in a controlled sequence after the cause is understood and the responsible authority approves restart.',
    ],
    siteImplementation: <String>[
      'Maintain utility and isolation diagrams, authorized-person lists and emergency contact details.',
      'Test backup systems as required by the maintenance plan and manufacturer instructions.',
      'Include power-loss scenarios in ERP drills where credible.',
      'Record the outage, affected systems, isolation, checks and authorization to restore.',
    ],
    practicalExample: <String>[
      'A power outage disables ventilation in a permit-controlled space. The entry is stopped, entrants are evacuated using the approved plan, and no re-entry occurs until atmosphere and ventilation are reassessed and authorization is restored.',
    ],
    stopWorkConditions: <String>[
      'Stop work when loss of power or utility compromises safe access, alarm, ventilation, guarding or process control.',
      'Do not attempt electrical rescue by touching a casualty or conductor before the energy hazard is controlled by authorized responders.',
    ],
    interviewQuestions: <String>[
      'What secondary risks can follow a site power failure?',
      'Who may isolate electrical equipment?',
      'What checks are needed before restoring power?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-30',
    title: 'Post-Emergency Recovery & Safe Re-entry',
    purpose: 'Transition from emergency response to controlled recovery, ensuring hazards are assessed, people are supported, evidence is preserved and operations restart only with authorization.',
    scope: 'Applies after evacuation, fire, spill, rescue, utility failure, severe weather or other significant emergency.',
    keyKnowledge: <String>[
      'Only the designated authority issues the all-clear and permits re-entry after consultation with emergency services and competent specialists as appropriate.',
      'Check structural stability, atmosphere, electrical and mechanical energy, contamination, access routes, fire systems and environmental impacts before releasing an area.',
      'Maintain exclusion zones until hazards are controlled and communicate restrictions to all affected teams.',
      'Provide medical follow-up, welfare support and factual communication to affected personnel.',
      'Preserve scene evidence and records when required; do not disturb evidence except for life safety or hazard control.',
      'Use formal change control, risk assessment and permit revalidation before restarting affected work.',
    ],
    siteImplementation: <String>[
      'Conduct a documented post-event inspection with operations, HSE and relevant competent persons.',
      'Record damage, isolations, tests, cleanup, waste disposition and outstanding restrictions.',
      'Brief the workforce on safe boundaries and revised controls before restart.',
      'Assign investigation and corrective actions with owners and due dates; verify effectiveness.',
    ],
    practicalExample: <String>[
      'After a chemical release is contained, the area remains restricted until competent personnel confirm the atmosphere and cleanup status, contaminated materials are managed through the approved process, and the responsible manager authorizes re-entry.',
    ],
    stopWorkConditions: <String>[
      'Do not re-enter an area without the designated all-clear and required technical checks.',
      'Stop restart if the event cause, residual hazard or integrity of critical controls remains uncertain.',
    ],
    interviewQuestions: <String>[
      'Who can authorize re-entry after an emergency?',
      'What must be checked before restarting work?',
      'How do you ensure lessons learned become effective corrective actions?',
    ],
  ),
];
