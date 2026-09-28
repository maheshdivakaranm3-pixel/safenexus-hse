// SafeNexus HSE — Emergency & Rescue Part 5 — Topics 17–20
// General field-learning guidance. Apply the current approved site ERP,
// risk assessment, competent-person direction and applicable authority rules.
// Do not treat supplementary examples as legal limits or substitute for training.

import 'emergency_rescue_part1.dart';

const List<EmergencyRescueTopic> emergencyRescuePart5 = <EmergencyRescueTopic>[
  EmergencyRescueTopic(
    id: 'ER-17',
    title: 'Severe Weather, Lightning & Sandstorm Response',
    purpose: 'Protect personnel from lightning, high wind, dust storms, reduced visibility, flooding and other severe-weather hazards through early warning, controlled suspension, shelter, accountability and safe restart.',
    scope: 'Applies to outdoor construction, lifting, work at height, scaffolds, cranes, temporary structures, road works, marine interfaces, camps and site transport. Use the project weather-monitoring and emergency arrangements.',
    keyKnowledge: <String>[
      'Monitor reliable official weather alerts and site-approved instruments; assign a person to communicate warnings to every work front and shift.',
      'Recognize lightning, thunder, sudden wind increase, blowing dust, poor visibility, water accumulation, unstable ground and warnings from equipment manufacturers.',
      'Lightning exposure can affect open areas, elevated structures, cranes, scaffolds, metalwork and isolated trees. Do not shelter beneath isolated objects or remain on exposed elevated work.',
      'Wind can destabilize suspended loads, crane booms, MEWPs, access platforms, sheet materials, formwork, hoardings and temporary roofs. Follow the equipment manufacturer limits and approved lift/temporary-works plan; do not invent a universal wind-speed threshold.',
      'Dust and sand reduce visibility, irritate eyes and airways, obscure hazards and affect vehicle control. Respiratory PPE is not a substitute for stopping unsafe outdoor work or moving to suitable shelter.',
      'The ERP should identify safe shelters, refuge locations, alarm wording, communications fallback, personnel-accountability process and responder access during weather disruption.',
      'After a storm, inspect access routes, excavations, scaffold ties, lifting equipment, electrical systems, temporary works, drainage and stored materials before authorizing restart.',
      'Record the warning, decision, affected work, headcount, inspections, defects and restart authorization. Resume only after the responsible competent persons confirm conditions are safe.'
    ],
    siteImplementation: <String>[
      'Before shift: review forecast/alerts, planned high-risk work, exposed work fronts, shelter capacity, communication coverage and emergency contact arrangements.',
      'When warning is received: inform the incident controller and supervisors; stop affected operations in a controlled manner; lower or secure equipment only where the approved procedure permits.',
      'Direct workers to the designated safe shelter using routes that avoid cranes, suspended loads, unstable structures, floodwater and exposed high points.',
      'Supervisors conduct a headcount at the designated safe location and report missing, injured or unaccounted persons to the incident controller; do not send untrained searchers into danger.',
      'If visibility is inadequate, stop vehicle movements in a safe location, use hazard lights as site procedure allows, maintain separation and avoid sudden maneuvers.',
      'For flooding or electrical hazard, keep clear of water around electrical installations and do not enter unknown-depth water or attempt an unplanned rescue.',
      'Restart checklist: official/site alert cleared; competent inspection completed; equipment and ground conditions acceptable; access/egress clear; electrical protection checked; workforce briefed; authorization recorded.'
    ],
    practicalExample: <String>[
      'A sudden dust storm reaches a road-work area. The supervisor stops vehicle movements, warns adjacent crews by radio, directs personnel to the designated shelter, accounts for the crew and reports one missing worker. The incident controller coordinates a safe check from a protected position and contacts emergency services if needed.',
      'A crane lift is planned while wind conditions are changing. The lift supervisor checks the approved lift plan and manufacturer instructions, suspends the lift when required conditions are not met, secures the load/plant safely and documents the hold point.'
    ],
    stopWorkConditions: <String>[
      'Lightning, wind, visibility or weather conditions meet the site ERP, manufacturer, permit or approved method-statement stop criteria.',
      'No reliable weather information or no functioning communication to exposed work fronts.',
      'Shelter, evacuation route or personnel-accountability arrangements are unavailable or compromised.',
      'Ground instability, flooding, damaged electrical systems, loose materials or suspected structural/equipment damage.',
      'Any worker is instructed to continue exposed work despite an unresolved imminent weather hazard.'
    ],
    interviewQuestions: <String>[
      'Q: What is the first priority during a severe-weather warning? A: Protect life—communicate the warning, suspend affected work safely, move people to designated shelter and account for everyone.',
      'Q: Can one wind-speed value be applied to every crane or MEWP? A: No. Follow the specific manufacturer limits, approved lift plan, site risk assessment and applicable requirements.',
      'Q: Who authorizes restart? A: The designated responsible person after required competent inspections and confirmation that controls are restored.',
      'Q: What if a worker is missing? A: Report immediately to the incident controller, provide last known location and details, and do not initiate an untrained entry into hazardous conditions.'
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-18',
    title: 'Structural Collapse, Trench Failure & Building Damage Response',
    purpose: 'Establish safe isolation, alarm, accountability, specialist rescue coordination and controlled recovery following partial or total collapse, trench failure, falling structural elements or suspected instability.',
    scope: 'Applies to buildings, scaffolds, formwork, falsework, temporary works, excavations, retaining systems, industrial structures and areas affected by impact, fire, flooding or ground movement.',
    keyKnowledge: <String>[
      'Secondary collapse is a major danger. Do not enter, climb onto debris, move props, operate nearby plant or disturb a failed excavation unless directed under a controlled specialist plan.',
      'Warning signs may include unusual cracking, movement, settlement, bulging, falling debris, sudden water ingress, failed supports, abnormal sounds or damage after impact. Treat uncertainty conservatively.',
      'Raise the alarm, stop nearby work, isolate the area and prevent unauthorized access. Establish exclusion boundaries from a safe position under the incident controller and competent structural advice.',
      'Account for personnel using work-front rosters, permit registers, visitor logs and contractor supervisors. Provide responders with last known locations, hazards, drawings and access constraints.',
      'Rescue may require fire and rescue services, structural engineers, trench-rescue specialists, utility isolation, shoring, lifting/rigging specialists and medical teams. Site personnel must not improvise technical rescue.',
      'Before touching debris or services, identify potential electrical, gas, chemical, fire, suspended-load and stored-energy hazards. Isolations must be controlled and verified by authorized persons.',
      'Do not use heavy equipment near a collapse zone without an engineered/approved plan; vibration, surcharge and movement can worsen instability.',
      'Recovery and re-entry require formal assessment, controlled access, evidence preservation where applicable, and documented authorization by responsible competent persons.'
    ],
    siteImplementation: <String>[
      'Activate alarm and call emergency services through the site procedure; give exact location, incident type, known persons trapped/injured, access gate and special hazards.',
      'Stop work and plant movement in the affected and potentially affected zone. Establish a safe perimeter; appoint a gate/access controller.',
      'Move uninjured personnel to a safe assembly point, conduct headcount and report missing persons with names, employer, last known location and task.',
      'From a safe location, observe and report hazards; do not enter voids, trenches or unstable structures to search or retrieve tools.',
      'Provide responders with site drawings, excavation/temporary-works information, utility maps, permits, chemical inventory and a person familiar with the area.',
      'Coordinate utility isolation only through authorized competent personnel; communicate confirmed isolation status and any unknown services to responders.',
      'Preserve incident scene where safe and required; record timeline, alarm, decisions, witnesses and actions without delaying rescue.',
      'Re-entry requires structural/temporary-works assessment, removal or stabilization of hazards, revised risk assessment, permit/method statement review and formal release.'
    ],
    practicalExample: <String>[
      'A trench side begins to crack and soil sloughs near a worker. The spotter raises the alarm, stops nearby plant, prevents entry, calls the site emergency number and reports the worker’s last known position. Only trained trench-rescue responders proceed under their controlled rescue plan.',
      'After a vehicle strikes a temporary support, the supervisor evacuates the affected zone, isolates access and requests competent structural assessment before any attempt to remove or adjust the support.'
    ],
    stopWorkConditions: <String>[
      'Any suspected movement, cracking, settlement, support failure, falling debris or unexplained structural noise.',
      'Unknown stability or unverified excavation/temporary-works condition.',
      'Unauthorized entry, excavation, lifting or plant operation inside the exclusion zone.',
      'Unidentified or unisolated utilities, stored energy, fire, gas or chemical hazards.',
      'No competent assessment or formal release for re-entry.'
    ],
    interviewQuestions: <String>[
      'Q: Should an HSE officer enter a collapsed trench to rescue a worker? A: No. Raise alarm, isolate, call specialist rescue and provide information; unplanned entry can create additional casualties.',
      'Q: What information should be given to responders? A: Exact location, access gate, number/status of people, last known positions, structural/excavation details, utilities and other hazards.',
      'Q: Who approves re-entry? A: The designated responsible person after competent structural/temporary-works assessment and documented controls.',
      'Q: Why stop nearby plant? A: Vibration, surcharge and movement may trigger secondary collapse.'
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-19',
    title: 'Gas Leak, Flammable Vapour & Oxygen-Deficient Atmosphere Emergency',
    purpose: 'Protect people from toxic exposure, fire, explosion and oxygen deficiency by raising alarm, withdrawing upwind/uphill where appropriate, isolating ignition sources only when safe, and coordinating specialist response.',
    scope: 'Applies to LPG/fuel systems, gas cylinders, process lines, chemical stores, tank farms, confined-space interfaces, laboratories, workshops and any suspected gas/vapour release. Use the site-specific chemical and process emergency plan.',
    keyKnowledge: <String>[
      'Treat an unknown release as hazardous. Do not rely on smell; some gases are odorless, and odor fatigue or toxic effects may impair detection.',
      'Do not operate electrical switches, phones, vehicles or equipment within a suspected flammable atmosphere unless specifically designed and authorized for that environment.',
      'Do not approach a leak to close a valve unless trained, equipped, authorized and the site procedure confirms it is safe. Remote isolation is preferred where designed.',
      'Move away from the release using the site escape direction; consider wind direction, terrain and vapor behavior. Follow emergency wardens and designated routes rather than assuming one direction is always safe.',
      'Never enter a suspected oxygen-deficient, toxic or flammable atmosphere without a planned, authorized specialist response, suitable monitoring, respiratory protection and rescue capability.',
      'Only competent personnel use calibrated gas detectors and interpret readings under the approved monitoring plan. A single reading does not guarantee the whole area is safe.',
      'Provide responders with Safety Data Sheets (SDS), inventory, process drawings, isolation points, detector information and known exposure details.',
      'Re-entry and restart require source control, atmospheric assessment by competent personnel, ventilation/verification as applicable, authorization and communication to all affected workers.'
    ],
    siteImplementation: <String>[
      'Raise the site alarm from a safe location and report suspected gas/vapour, exact location, wind direction if known, people affected and access restrictions.',
      'Stop work; evacuate affected and downwind/at-risk areas according to the ERP. Do not cross the release plume or enter low-lying/poorly ventilated spaces without direction.',
      'Keep ignition sources away; do not start/stop engines or operate non-rated devices in the suspected hazard zone. Follow the designated emergency team’s instructions.',
      'Account for personnel at the safe assembly point; identify missing persons and possible exposure promptly.',
      'Call emergency services and the site emergency controller. Keep access gates clear and provide a knowledgeable escort from a safe meeting point.',
      'Share SDS, gas identity if known, quantity/pressure information, process layout, isolation status and monitoring results; clearly label unknowns as unknown.',
      'For exposed persons, move them to fresh air only if this can be done without exposing rescuers; request medical assistance and follow trained first-aid direction.',
      'Do not declare the area safe based on odor disappearance or absence of symptoms. Require competent atmospheric verification and formal re-entry authorization.'
    ],
    practicalExample: <String>[
      'A worker reports a hissing sound near a cylinder manifold. The supervisor raises the alarm, evacuates the immediate area, prevents vehicle/ignition activity, reports cylinder identity and location, and waits for the designated gas-response team.',
      'A gas detector alarms at a tank entry point. The attendant prevents entry, initiates the confined-space emergency plan, summons the trained rescue team and does not attempt an unprotected retrieval.'
    ],
    stopWorkConditions: <String>[
      'Unidentified leak, gas alarm, unusual hissing, suspected vapour cloud or unexplained worker symptoms.',
      'No safe escape route, alarm/communication failure or uncontrolled ignition sources.',
      'Attempted entry or rescue without approved specialist capability, atmospheric testing and rescue arrangements.',
      'Unknown isolation status, unavailable SDS/process information or unverified atmosphere.',
      'Pressure to restart before competent clearance and formal authorization.'
    ],
    interviewQuestions: <String>[
      'Q: What should you do first when a gas leak is suspected? A: Raise alarm, withdraw to a safe area using the ERP, prevent access/ignition where safe and notify the emergency controller.',
      'Q: Can you switch off a nearby light or vehicle? A: Not in a suspected flammable atmosphere unless the device and action are specifically approved; switching can create an ignition source.',
      'Q: Is smell enough to confirm the area is safe? A: No. Use competent atmospheric monitoring and formal clearance.',
      'Q: Can an untrained coworker enter to rescue someone? A: No. Initiate the specialist rescue plan and avoid creating another casualty.'
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-20',
    title: 'Emergency Drills, ERP Testing, Debrief & Continuous Improvement',
    purpose: 'Verify that emergency arrangements work in practice, identify gaps, improve competence and ensure corrective actions are closed before a real event.',
    scope: 'Applies to project and facility emergency plans, all shifts, contractors, visitors, remote work fronts, camps, workshops and interfaces with external responders. Drill design and frequency must follow applicable requirements and the approved risk-based plan.',
    keyKnowledge: <String>[
      'A drill tests the system, not merely whether people assemble. Evaluate alarm audibility/visibility, understanding, decision-making, route safety, headcount, communications, access for responders and role performance.',
      'Select scenarios from the current risk assessment and actual work phase. Include credible but controlled scenarios such as fire, medical emergency, confined-space alarm, severe weather or missing-person accountability.',
      'Set clear objectives, boundaries, observers, safety controls, stop signal, participant briefing level and arrangements for real emergencies. Never create an uncontrolled hazard to make a drill realistic.',
      'Include night shift, subcontractors, visitors, language needs, persons requiring assistance and remote work areas in planning where relevant.',
      'Observers should record objective times and facts, not blame. Distinguish planned actions, actual actions, barriers, communication failures and unexpected hazards.',
      'Conduct a structured debrief: what was expected, what happened, why gaps occurred, what worked, and what corrective action, owner and due date are required.',
      'Corrective actions need risk-based priority, accountable owner, target date, evidence of completion and effectiveness verification. Repeated findings require system-level review.',
      'Update ERP, maps, contact lists, training, equipment, signage and risk assessments when findings or site changes require it. Communicate revisions and verify understanding.',
      'Maintain records of scenario, date/shift, participants, observers, findings, actions, closure evidence and management review in the approved system.'
    ],
    siteImplementation: <String>[
      'Before drill: obtain management/site authorization; define objectives and scenario; coordinate with affected contractors and external agencies if applicable; protect live operations.',
      'Check alarm and communications, safe routes, assembly point capacity, attendance sources, first-aid coverage and observer positions.',
      'Brief controllers and observers on safety boundaries, real-emergency override, cancellation phrase/signal and how to avoid confusing the public or emergency services.',
      'Run the scenario without exposing participants to real danger; controllers may pause or terminate the drill immediately if conditions change.',
      'At assembly: supervisors report headcount, missing-person status, injuries/simulated casualties and route obstructions through the agreed chain.',
      'Debrief promptly while details are fresh; capture worker feedback, including language, accessibility and contractor-interface issues.',
      'Create an action register with finding, risk, owner, due date, interim control, closure evidence and effectiveness check.',
      'Verify closure in the field; revise ERP and training; brief all affected personnel and schedule a follow-up test when the gap warrants it.'
    ],
    practicalExample: <String>[
      'A planned evacuation drill reveals that a subcontractor crew uses an outdated assembly-point map. The drill controller records the gap, the supervisor accounts for the crew safely, and management updates maps, briefs all shifts and verifies the change in a follow-up check.',
      'A simulated medical emergency shows the ambulance access gate is blocked by deliveries. The site assigns an access-control owner, changes delivery controls, marks the route and verifies it remains clear during routine inspections.'
    ],
    stopWorkConditions: <String>[
      'A real emergency occurs or conditions become unsafe during the drill—stop the exercise and activate the real ERP.',
      'Drill activity interferes with live lifting, traffic, hazardous operations or emergency access.',
      'Alarm wording or exercise controls may cause confusion with public emergency services or neighboring sites.',
      'Critical emergency equipment, routes or roles are unavailable and the drill cannot be conducted safely.',
      'Corrective actions from serious findings remain uncontrolled while the affected high-risk activity is planned to proceed.'
    ],
    interviewQuestions: <String>[
      'Q: What is the purpose of an emergency drill? A: To test people, equipment, communication and the ERP, identify gaps and verify improvement—not just to record attendance.',
      'Q: What should observers record? A: Objective evidence such as alarm recognition, response sequence, route condition, headcount, communications, delays and barriers.',
      'Q: How do you close a drill finding? A: Assign owner and due date, apply interim controls where needed, retain completion evidence and verify effectiveness.',
      'Q: What if a real incident occurs during a drill? A: Stop the exercise immediately and activate the real emergency response procedure.'
    ],
  ),
];
