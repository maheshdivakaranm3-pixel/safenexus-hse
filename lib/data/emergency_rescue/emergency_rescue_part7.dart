// SafeNexus HSE — Emergency & Rescue Part 7 — Topics 31–40
// Specialist rescue learning guidance. Follow the approved site ERP, competent rescue command,
// manufacturer instructions, medical direction and applicable authority requirements.

import 'emergency_rescue_part1.dart';

const List<EmergencyRescueTopic> emergencyRescuePart7 = <EmergencyRescueTopic>[
  EmergencyRescueTopic(
    id: 'ER-31',
    title: 'Rope Rescue Fundamentals & Planning',
    purpose: 'Provide a controlled framework for rope-based access and rescue where ordinary access is not suitable.',
    scope: 'Use only for planned operations led by trained, authorized rope-rescue personnel; never improvise a rope system during an incident.',
    keyKnowledge: <String>[
      'Rope rescue is a specialist technical activity. A bystander must not enter an exposed edge, shaft, slope or suspended system to attempt an untrained rescue.',
      'Before work, identify the casualty location, access route, edge hazards, fall exposure, communications, weather, anchor options and safe evacuation destination.',
      'Use a written rescue plan matched to the task, site geometry, casualty condition, available team competence and equipment. A generic plan is not enough.',
      'Anchor selection and system design must be performed by competent personnel using approved equipment and documented capacity criteria; do not assume a handrail, pipe or vehicle is an anchor.',
      'Protect ropes from sharp edges, heat, chemicals, moving plant and abrasion. Use suitable edge protection and keep systems clear of traffic and dropped-object zones.',
      'Use compatible, inspected equipment and follow manufacturer instructions for harnesses, connectors, descenders, belay devices and rope systems.',
      'Plan independent protection and a backup/belay arrangement where the approved system requires it. Avoid single-point failure and uncontrolled loading.',
      'Maintain positive communication between rescue lead, edge attendant, lowering/raising operator and receiving team; use agreed commands and repeat-back.',
      'Consider casualty suspension, trauma, medical monitoring, packaging, orientation and transfer to medical responders; technical extraction is not the end of care.',
      'After use, quarantine equipment exposed to shock loading, damage or contamination pending competent inspection and disposition.',
    
      "Planning sequence: define the rescue objective, casualty access, primary and backup systems, edge protection, team positions, communications, lowering or raising route, casualty packaging and handover point before deployment.",
      "Conduct a documented anchor and system review by the designated competent rope-rescue lead. Check compatibility of connectors, rope path, edge protection, system direction, redundancy and exclusion zones; follow equipment ratings and approved procedures rather than estimating loads.",
      "Brief the team on command words, radio channel, stop signal, lost-communication response, change-of-plan authority and the method for keeping rescuers clear of suspended loads and fall lines.",
      "After use, quarantine equipment exposed to shock loading, chemical contamination, sharp edges or uncertain damage. Record inspection, cleaning, retirement decision and traceability according to manufacturer and site rules.",
    ],
    siteImplementation: <String>[
      'Confirm specialist team and authorization; brief roles and command words.',
      'Establish exclusion zones above, below and around the rescue route.',
      'Inspect equipment, anchors, connectors and edge protection before use.',
      'Test communication and rehearse the intended sequence without exposing personnel.',
      'Coordinate casualty handover and record equipment use, defects and lessons.',
    
      "Before the task, brief the team on roles, communication, exclusion boundaries, emergency call route, equipment readiness and who can stop or abort the operation.",
      "During response, maintain scene control, protect bystanders, provide concise updates to the incident lead and record important times, decisions and handovers.",
      "Afterward, secure the area, account for personnel, report equipment defects and participate in debriefing; do not resume work until formal authorization.",
    ],
    practicalExample: <String>[
      'A worker is stranded on a steep embankment. The supervisor raises alarm, prevents untrained entry, isolates nearby plant and calls the site rope-rescue team with access and casualty details.',
    
      "Example: A worker reports this emergency during a live shift. The supervisor stops affected work, raises the site alarm, gives the exact location and known hazards, keeps others clear and activates the approved response plan.",
      "Example review: At the debrief, compare the actual response with the plan, identify delays or missing resources, assign corrective actions and verify completion before the next similar task.",
    ],
    stopWorkConditions: <String>[
      'No competent rescue team; uncertain anchor; damaged/contaminated equipment; changing weather or visibility; uncontrolled edge or plant exposure; loss of communications.',
    ],
    interviewQuestions: <String>[
      'Why must rope rescue be specialist-led?',
      'What should a rescue plan confirm before deployment?',
      'Why are anchor verification and edge protection essential?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-32',
    title: 'Technical Rescue Equipment Selection & Inspection',
    purpose: 'Ensure rescue equipment is suitable, compatible, serviceable and available for the identified credible scenarios.',
    scope: 'Applies to rescue kits, stretchers, harnesses, ropes, connectors, tripods, retrieval devices, breathing apparatus and supporting equipment.',
    keyKnowledge: <String>[
      'Select equipment from the risk assessment and rescue method, not from availability alone. Verify intended use, capacity, environment and user competence.',
      'Maintain an inventory with unique identification, manufacturer instructions, inspection criteria, service life and storage location.',
      'Carry out pre-use checks before every deployment and scheduled documented inspections at intervals set by law, manufacturer and competent-person assessment.',
      'Inspect webbing, stitching, labels, buckles, connectors, gates, corrosion, deformation, cracks, contamination and evidence of shock loading.',
      'Check rescue devices for function, compatibility, correct configuration and required accessories; do not mix components unless approved by the manufacturer or competent system designer.',
      'Store equipment dry, clean, protected from UV, chemicals, heat, sharp objects and unauthorized access. Keep emergency kits accessible without blocking escape routes.',
      'Ensure equipment is appropriate for UAE site conditions, including heat, dust, humidity, coastal corrosion and possible chemical exposure.',
      'Clearly quarantine defective, expired, contaminated or shock-loaded items. Prevent accidental return to service until formally released.',
      'Train users in inspection, fitting, operation, limitations and emergency care. Equipment alone does not establish competence.',
      'Record issue, inspection, maintenance, deployment, damage, quarantine and replacement; audit readiness at work fronts and shifts.',
    
      "Create an equipment register showing unique ID, type, manufacturer, serial or batch number, rated use, issue location, inspection status, service history and retirement criteria.",
      "Pre-use checks should look for cuts, abrasion, deformation, corrosion, damaged stitching, illegible labels, contamination, malfunctioning gates, incompatible components and missing parts. A visual check does not replace required competent-person inspection.",
      "Store rescue equipment clean, dry and protected from sunlight, heat, chemicals, oils, sharp objects and unauthorized use. Separate serviceable, awaiting inspection and quarantined items physically and label them clearly.",
      "Confirm the equipment is suitable for the intended rescue configuration and environment; never mix components solely because they physically connect. Follow manufacturer compatibility and user instructions.",
    ],
    siteImplementation: <String>[
      'Match each credible scenario to a defined equipment list and competent user group.',
      'Assign an equipment custodian and keep a current location register.',
      'Check seals, access, condition and readiness during routine site inspections.',
      'Conduct practical familiarization and scenario drills using the actual kit.',
      'Replace missing/defective items promptly and document closure.',
    
      "Before the task, brief the team on roles, communication, exclusion boundaries, emergency call route, equipment readiness and who can stop or abort the operation.",
      "During response, maintain scene control, protect bystanders, provide concise updates to the incident lead and record important times, decisions and handovers.",
      "Afterward, secure the area, account for personnel, report equipment defects and participate in debriefing; do not resume work until formal authorization.",
    ],
    practicalExample: <String>[
      'A confined-space retrieval kit is found with an unreadable inspection label. It is quarantined and replaced with a verified kit before entry is authorized.',
    
      "Example: A worker reports this emergency during a live shift. The supervisor stops affected work, raises the site alarm, gives the exact location and known hazards, keeps others clear and activates the approved response plan.",
      "Example review: At the debrief, compare the actual response with the plan, identify delays or missing resources, assign corrective actions and verify completion before the next similar task.",
    ],
    stopWorkConditions: <String>[
      'Missing inspection status; damaged or contaminated equipment; incompatible components; expired service life; unavailable trained users; kit inaccessible or incomplete.',
    ],
    interviewQuestions: <String>[
      'What is the difference between pre-use and periodic inspection?',
      'What should happen to shock-loaded equipment?',
      'Why must equipment compatibility be verified?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-33',
    title: 'Confined Space Rescue Planning',
    purpose: 'Prepare a non-entry or specialist entry rescue response for credible confined-space emergencies.',
    scope: 'Applies to tanks, vessels, pits, manholes, chambers, ducts and other spaces identified as confined spaces by the site assessment.',
    keyKnowledge: <String>[
      'Confined-space rescue must be planned before entry. The permit, risk assessment, gas testing, isolation, attendant and rescue arrangements must work together.',
      'Prefer non-entry retrieval where feasible and safe; retrieval equipment must not create entanglement, worsen injury or obstruct the opening.',
      'Never send an unprotected coworker into a suspected hazardous atmosphere. Secondary casualties commonly occur when rescuers enter without controls.',
      'Identify atmospheric hazards, engulfment, mechanical/electrical energy, access geometry, casualty position, rescue route and potential need for specialist responders.',
      'Confirm rescue team response capability, equipment, communications, breathing apparatus where required, medical support and access to the space before entry begins.',
      'Keep the attendant outside, maintain continuous communication and personnel accounting, and initiate alarm according to the ERP if a worker becomes unresponsive or contact is lost.',
      'Isolate connected lines and equipment under approved isolation/LOTO arrangements before rescue where safe and practicable; do not delay urgent alarm or responder call.',
      'Rescue entrants require task-specific training, fit-for-purpose PPE and a controlled entry/rescue method approved by the competent rescue lead.',
      'Plan casualty packaging and extraction through restricted openings, including the possibility that a stretcher or retrieval line may not pass freely.',
      'After rescue, arrange prompt medical assessment, preserve the scene where required and review permit, atmosphere, isolation and rescue performance.',
    
      "The rescue plan must identify the space configuration, access opening, atmosphere hazards, engulfment or mechanical hazards, isolation points, casualty retrieval method, attendant duties and emergency-service interface before entry begins.",
      "Do not send an unprotected colleague into a confined space to rescue someone. Raise the alarm, prevent additional entry, account for entrants and activate the trained rescue team using the approved plan.",
      "Where atmospheric monitoring is required, use a suitable calibrated instrument and competent tester; consider oxygen, flammable and toxic hazards, sampling locations, changing conditions and continuous monitoring requirements in the permit/assessment.",
      "Prepare retrieval and rescue equipment outside the space, verify that it is compatible with the opening and casualty, and keep access clear. Rescue entry requires authorization, suitable protection, trained personnel and atmospheric controls.",
    ],
    siteImplementation: <String>[
      'Review rescue feasibility during permit planning, not after entry starts.',
      'Verify retrieval equipment and communication by a practical pre-entry check.',
      'Confirm rescue personnel and external support arrangements for the actual shift.',
      'Brief attendant on alarm triggers, no-entry rule and responder access.',
      'Suspend entry if rescue capability, isolation or atmosphere controls are lost.',
    
      "Before the task, brief the team on roles, communication, exclusion boundaries, emergency call route, equipment readiness and who can stop or abort the operation.",
      "During response, maintain scene control, protect bystanders, provide concise updates to the incident lead and record important times, decisions and handovers.",
      "Afterward, secure the area, account for personnel, report equipment defects and participate in debriefing; do not resume work until formal authorization.",
    ],
    practicalExample: <String>[
      'A worker collapses in a vessel. The attendant raises the alarm, does not enter, initiates the approved retrieval/rescue plan and directs responders to the vessel access point.',
    
      "Example: A worker reports this emergency during a live shift. The supervisor stops affected work, raises the site alarm, gives the exact location and known hazards, keeps others clear and activates the approved response plan.",
      "Example review: At the debrief, compare the actual response with the plan, identify delays or missing resources, assign corrective actions and verify completion before the next similar task.",
    ],
    stopWorkConditions: <String>[
      'No viable rescue plan; untrained entrant/rescuer; unavailable rescue resources; failed communications; uncertain isolation; unsafe atmosphere or changing conditions.',
    ],
    interviewQuestions: <String>[
      'Why is rescue planning required before confined-space entry?',
      'When is non-entry retrieval preferred?',
      'What must an attendant do when a worker becomes unresponsive?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-34',
    title: 'Work-at-Height Rescue & Fall-Arrest Suspension',
    purpose: 'Enable prompt, controlled recovery of a person after a fall or while stranded at height.',
    scope: 'Applies to roofs, scaffolds, ladders, MEWPs, structures and other elevated work locations.',
    keyKnowledge: <String>[
      'A fall-arrest plan must include a realistic rescue method and prompt activation; calling emergency services alone may not address immediate suspension hazards.',
      'Identify access, anchor arrangements, rescue equipment, trained rescuers, casualty route, exclusion zone and medical handover before work starts.',
      'Never climb an unstable structure or use an unapproved ladder/MEWP rescue method to reach a casualty.',
      'Prevent additional falls and dropped objects by isolating the area below and controlling nearby work, traffic and lifting operations.',
      'Use a rescue method compatible with the casualty’s harness, lanyard/SRL, anchor and site geometry; follow manufacturer limits and trained procedures.',
      'Communicate with a conscious suspended worker, encourage them to follow their training and avoid unsafe self-release or disconnection.',
      'Control the casualty during lowering or raising to prevent collision, snagging, uncontrolled descent and secondary injury.',
      'Once recovered, provide first aid within competence and arrange prompt medical evaluation according to the casualty condition and site protocol.',
      'Inspect and quarantine fall-protection equipment involved in a fall or suspected shock load. Do not return it to service without competent disposition.',
      'Investigate the fall protection failure or event, preserve relevant evidence and revise the task risk assessment and rescue plan.',
    
      "Before work at height, define the rescue method for the exact work position, access equipment, fall-arrest arrangement, casualty condition and available rescuers; do not rely only on calling public emergency services.",
      "Identify safe access for rescuers, edge protection, dropped-object exposure, anchor arrangements, casualty lowering route and a clear area for first aid and ambulance handover.",
      "Rescue team members must be trained for the selected system and equipment. Rehearse the plan in a controlled drill without exposing workers to a real fall or unplanned suspension.",
      "After rescue, prevent re-use of involved fall-protection equipment until competent inspection and disposition are completed; preserve relevant records for incident review.",
    ],
    siteImplementation: <String>[
      'Verify rescue access and equipment at the actual work location and shift.',
      'Brief the team on alarm, rescue lead, exclusion zone and casualty transfer.',
      'Ensure rescuers are trained and equipment is inspected and compatible.',
      'Conduct drills for likely access constraints and communication failures.',
      'Review every fall-arrest deployment and restore readiness before work resumes.',
    
      "Before the task, brief the team on roles, communication, exclusion boundaries, emergency call route, equipment readiness and who can stop or abort the operation.",
      "During response, maintain scene control, protect bystanders, provide concise updates to the incident lead and record important times, decisions and handovers.",
      "Afterward, secure the area, account for personnel, report equipment defects and participate in debriefing; do not resume work until formal authorization.",
    ],
    practicalExample: <String>[
      'A worker is suspended from a lifeline beside a façade. The team raises alarm, secures the drop zone and deploys the preplanned trained rescue method while medical support is called.',
    
      "Example: A worker reports this emergency during a live shift. The supervisor stops affected work, raises the site alarm, gives the exact location and known hazards, keeps others clear and activates the approved response plan.",
      "Example review: At the debrief, compare the actual response with the plan, identify delays or missing resources, assign corrective actions and verify completion before the next similar task.",
    ],
    stopWorkConditions: <String>[
      'No rescue capability; anchor or structure instability; untrained rescue attempt; uncontrolled drop zone; defective equipment; wind or conditions beyond plan limits.',
    ],
    interviewQuestions: <String>[
      'Why must fall-arrest work have a rescue plan?',
      'What hazards exist during casualty lowering?',
      'What happens to equipment after a fall arrest?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-35',
    title: 'Suspended Worker Rescue & Suspension Intolerance Awareness',
    purpose: 'Recognize and manage the urgent risks to a person suspended in a harness while maintaining a controlled rescue.',
    scope: 'Applies to fall-arrest, rope access and other harness suspension events; use current medical and manufacturer guidance.',
    keyKnowledge: <String>[
      'A suspended person may be distressed, injured or unable to self-rescue. Treat the event as urgent and activate the site emergency response without delay.',
      'Signs may include faintness, nausea, sweating, pallor, confusion, weakness or reduced responsiveness; do not rely on a fixed time threshold.',
      'Prioritize safe, prompt recovery using the approved rescue method. Do not create a second casualty by rushing into an uncontrolled rescue.',
      'Keep communication with a conscious casualty, reassure them and request simple actions only if safe and consistent with training.',
      'After recovery, assess responsiveness and breathing, provide first aid within competence and arrange medical evaluation, especially after collapse, injury or altered consciousness.',
      'Follow current first-aid training and medical direction for positioning and care; avoid rigid universal post-rescue positioning rules.',
      'Protect the casualty from further falls, impact, heat exposure and unnecessary movement where trauma is suspected.',
      'Ensure ambulance access and a clear handover of suspension duration if known, fall mechanism, symptoms, rescue actions and observed changes.',
      'Inspect and quarantine involved harnesses, connectors, lanyards and anchors pending competent review.',
      'Use the incident to review rescue response time, alarm reliability, equipment access, team competence and prevention measures.',
    
      "A suspended worker may deteriorate; activate the site rescue plan promptly and communicate the time of suspension, worker responsiveness, injury concerns and exact location to the rescue lead and medical responder.",
      "Do not climb the same structure or use an improvised ladder, lifting device or cutting method. The rescue approach must be selected by competent personnel for the structure, access, anchor and casualty condition.",
      "Once safely recovered, place the casualty in a safe position, assess responsiveness and breathing, provide first aid within competence, keep the person under medical assessment and arrange emergency medical transfer as indicated.",
      "Review why the fall occurred, the rescue delay, equipment arrangement, supervision, access and worker training; do not restart work until the system and risk assessment are reviewed and authorized.",
    ],
    siteImplementation: <String>[
      'Activate alarm and rescue lead immediately; note casualty location and condition.',
      'Secure area below and prepare medical response and access route.',
      'Use only trained personnel and approved rescue equipment.',
      'Provide continuous observation and clear handover after recovery.',
      'Debrief and restore rescue readiness before restarting similar work.',
    
      "Before the task, brief the team on roles, communication, exclusion boundaries, emergency call route, equipment readiness and who can stop or abort the operation.",
      "During response, maintain scene control, protect bystanders, provide concise updates to the incident lead and record important times, decisions and handovers.",
      "Afterward, secure the area, account for personnel, report equipment defects and participate in debriefing; do not resume work until formal authorization.",
    ],
    practicalExample: <String>[
      'A conscious worker hangs in a harness after a fall. A coworker keeps verbal contact from a safe position, activates the alarm and guides responders to the access point.',
    
      "Example: A worker reports this emergency during a live shift. The supervisor stops affected work, raises the site alarm, gives the exact location and known hazards, keeps others clear and activates the approved response plan.",
      "Example review: At the debrief, compare the actual response with the plan, identify delays or missing resources, assign corrective actions and verify completion before the next similar task.",
    ],
    stopWorkConditions: <String>[
      'Delayed alarm; unsafe improvised climbing; casualty becoming unresponsive; rescue equipment defect; unsafe weather/access; no medical handover.',
    ],
    interviewQuestions: <String>[
      'What warning signs may occur during suspension?',
      'Why should rescue be activated promptly?',
      'What information should be handed to medical responders?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-36',
    title: 'Trench & Excavation Emergency Rescue',
    purpose: 'Control the scene and coordinate specialist response when a person is trapped, injured or missing in an excavation.',
    scope: 'Applies to trenches, pits, shafts and excavations, including collapse, water ingress, utility strike and plant interaction.',
    keyKnowledge: <String>[
      'An excavation collapse can involve unstable ground and hidden voids. Do not enter or dig toward a casualty without competent rescue assessment and stabilization.',
      'Raise alarm, stop nearby work and plant, establish an exclusion zone and prevent vibration or surcharge loading near the edge.',
      'Identify excavation depth and geometry, soil/support system, water, weather, adjacent structures, buried services and plant movements.',
      'Call specialist rescue and emergency services early; provide site access, casualty count, last known location and known hazards.',
      'Only competent personnel may assess shoring, trench boxes, shielding or other protective systems and determine a safe rescue approach.',
      'Never undermine shoring, remove supports or operate excavators close to a suspected casualty without a controlled rescue plan.',
      'Control water ingress, falling materials, suspended loads, vehicle movement and secondary collapse hazards as directed by competent responders.',
      'Maintain a reliable headcount and account for workers, visitors and subcontractors who may have been in the excavation.',
      'Provide medical access and safe casualty transfer; preserve the scene and relevant permits, inspections and excavation records.',
      'Before restart, reassess ground conditions, protective systems, services, access, competent-person inspection and authorization.',
    
      "Treat an excavation collapse as an unstable ground emergency. Stop nearby plant and vibration, isolate the edge, raise the alarm and keep untrained personnel out of the excavation.",
      "Never enter a collapsed trench or attempt to pull a buried person from unstable soil without specialist rescue direction; secondary collapse can trap rescuers and worsen casualties.",
      "Provide responders with excavation depth and layout, soil and support information, utility locations, plant movements, water ingress, last known casualty position and any shoring or protective-system details.",
      "Only competent excavation-rescue specialists should determine stabilization, shoring, access and casualty removal. Maintain exclusion zones and monitor changing ground, water and plant hazards.",
    ],
    siteImplementation: <String>[
      'Stop excavation and isolate plant; establish safe perimeter.',
      'Notify emergency services and site incident controller with precise location.',
      'Provide drawings, service information, soil/support details and last-known casualty position.',
      'Keep untrained persons out; follow rescue commander instructions.',
      'Do not restart until the excavation is reassessed and formally released.',
    
      "Before the task, brief the team on roles, communication, exclusion boundaries, emergency call route, equipment readiness and who can stop or abort the operation.",
      "During response, maintain scene control, protect bystanders, provide concise updates to the incident lead and record important times, decisions and handovers.",
      "Afterward, secure the area, account for personnel, report equipment defects and participate in debriefing; do not resume work until formal authorization.",
    ],
    practicalExample: <String>[
      'A trench wall slumps and a worker is missing. The supervisor stops machinery, clears the edge, raises alarm and provides utility drawings and excavation inspection records to responders.',
    
      "Example: A worker reports this emergency during a live shift. The supervisor stops affected work, raises the site alarm, gives the exact location and known hazards, keeps others clear and activates the approved response plan.",
      "Example review: At the debrief, compare the actual response with the plan, identify delays or missing resources, assign corrective actions and verify completion before the next similar task.",
    ],
    stopWorkConditions: <String>[
      'Any movement/cracking; unstable edge; unknown utilities; water ingress; uncontrolled plant; untrained entry; removal of supports without authorization.',
    ],
    interviewQuestions: <String>[
      'Why is immediate untrained entry dangerous after a collapse?',
      'What information helps specialist responders?',
      'What conditions must be checked before restart?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-37',
    title: 'Fire & Smoke Rescue Coordination',
    purpose: 'Protect life and coordinate evacuation or rescue during fire, smoke spread or suspected trapped-person events.',
    scope: 'Applies to buildings, plant rooms, warehouses, accommodation, temporary facilities and hot-work areas.',
    keyKnowledge: <String>[
      'Raise the alarm and notify the designated emergency response. Evacuation and life safety take priority over property protection.',
      'Never enter smoke-filled or oxygen-deficient areas without the required trained team, breathing apparatus, command and backup arrangements.',
      'Use designated escape routes and stairs; do not use lifts unless the building emergency plan explicitly provides an approved evacuation lift procedure.',
      'Close doors if safe while leaving to limit smoke spread; do not delay evacuation to collect belongings or fight a fire beyond training and safe conditions.',
      'Wardens guide people to assembly points, prevent re-entry and report missing persons with last known location and relevant hazards.',
      'Keep fire-service access roads, hydrants, fire doors, exits and emergency equipment unobstructed.',
      'Communicate fire location, fuel/materials, cylinders, chemicals, electrical hazards, persons trapped and access constraints to responders.',
      'Account for contractors, visitors and persons needing assistance using the site muster system and assigned support arrangements.',
      'Re-entry is prohibited until the authorized incident controller or emergency services declare the area safe and required checks are completed.',
      'After the event, preserve relevant alarm, maintenance, hot-work permit and inspection records for investigation and corrective action.',
    
      "Coordinate with the incident commander and fire service; provide site access, building plans, hazardous-material information, isolation points, occupant count and known persons unaccounted for.",
      "Do not enter smoke, a fire compartment or a potentially oxygen-deficient area without authorization, training, suitable respiratory protection and a controlled rescue system.",
      "Account for workers at assembly points and relay last-known locations, mobility needs, hot-work activities, cylinders, flammable stores and process hazards to responders.",
      "After the incident, restrict re-entry until the authorized fire/emergency lead confirms hazards are controlled and the area is released under the site procedure.",
    ],
    siteImplementation: <String>[
      'Activate alarm, call emergency services and initiate planned evacuation.',
      'Wardens sweep only where safe and trained; never enter hazardous smoke.',
      'Account for people and report missing-person details to incident command.',
      'Keep responder routes and access gates clear.',
      'Control re-entry and conduct post-event review.',
    
      "Before the task, brief the team on roles, communication, exclusion boundaries, emergency call route, equipment readiness and who can stop or abort the operation.",
      "During response, maintain scene control, protect bystanders, provide concise updates to the incident lead and record important times, decisions and handovers.",
      "Afterward, secure the area, account for personnel, report equipment defects and participate in debriefing; do not resume work until formal authorization.",
    ],
    practicalExample: <String>[
      'Smoke is reported in a workshop. Workers evacuate by the designated route; a warden reports a missing contractor’s last known work area to the fire-service liaison.',
    
      "Example: A worker reports this emergency during a live shift. The supervisor stops affected work, raises the site alarm, gives the exact location and known hazards, keeps others clear and activates the approved response plan.",
      "Example review: At the debrief, compare the actual response with the plan, identify delays or missing resources, assign corrective actions and verify completion before the next similar task.",
    ],
    stopWorkConditions: <String>[
      'Smoke/heat spreading; blocked exits; alarm failure; unknown fire load; untrained entry; missing accountability; attempted re-entry before release.',
    ],
    interviewQuestions: <String>[
      'What information should be passed to firefighters?',
      'Why is re-entry controlled?',
      'What is the warden’s role during evacuation?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-38',
    title: 'Water Rescue & Man-Overboard Response',
    purpose: 'Provide an immediate alarm, safe recovery coordination and medical response for a person in water.',
    scope: 'Applies to waterfronts, marine work, tanks, open water, drainage channels and other drowning hazards.',
    keyKnowledge: <String>[
      'Raise the alarm immediately and identify exact location, last-seen point, water conditions and number of persons involved.',
      'Do not jump into water unless trained, equipped and authorized under the approved rescue plan; use reach/throw methods from a safe position where appropriate.',
      'Activate designated water-rescue or marine response and arrange emergency medical support. Assign a spotter to maintain visual contact when possible.',
      'Consider current, tide, visibility, temperature, contamination, vessel movement, entrapment and access for rescue craft or responders.',
      'Use approved flotation devices, lifebuoys, throw lines, rescue craft and PPE; inspect and position equipment before work begins.',
      'Control nearby machinery, pumps, propellers, vehicle movement and discharge points where safe and coordinated.',
      'After recovery, assess responsiveness and breathing, provide CPR/AED and first aid only within training and follow emergency-service instructions.',
      'Protect rescuers from cold, contamination, sharp objects and unstable banks or platforms; avoid crowding the edge.',
      'Provide medical handover with estimated submersion time if known, observed condition, environmental exposure and first-aid actions.',
      'Preserve relevant work permits, weather/tide information, equipment and witness details for review.',
    
      "For a person overboard or water emergency, raise the alarm, maintain visual contact, point continuously to the casualty and deploy approved flotation or recovery equipment only if trained and safe.",
      "Do not jump into water as an impulsive rescue. Consider current, tide, temperature, contamination, vessel movement, entanglement and secondary rescuer exposure; activate trained water-rescue capability.",
      "Prepare a clear recovery landing area and medical handover. A recovered casualty needs prompt assessment for breathing, injury and cold exposure by competent first aiders and medical professionals.",
      "For marine or waterfront sites, pre-brief alarm signals, rescue craft readiness, communications, access gates, emergency coordinates and interface with coastguard or local emergency services as applicable.",
    ],
    siteImplementation: <String>[
      'Confirm rescue equipment and trained responders before water-adjacent work.',
      'Establish alarm words, location references and emergency access points.',
      'Assign a lookout where risk assessment requires continuous observation.',
      'Practice alarm, throw/reach equipment use and responder access.',
      'Review barriers, lifejackets, lighting and rescue readiness after any event.',
    
      "Before the task, brief the team on roles, communication, exclusion boundaries, emergency call route, equipment readiness and who can stop or abort the operation.",
      "During response, maintain scene control, protect bystanders, provide concise updates to the incident lead and record important times, decisions and handovers.",
      "Afterward, secure the area, account for personnel, report equipment defects and participate in debriefing; do not resume work until formal authorization.",
    ],
    practicalExample: <String>[
      'A worker falls from a quay. A colleague raises the alarm, throws a lifebuoy from a safe position, keeps the person in sight and directs the trained rescue team to the access ladder.',
    
      "Example: A worker reports this emergency during a live shift. The supervisor stops affected work, raises the site alarm, gives the exact location and known hazards, keeps others clear and activates the approved response plan.",
      "Example review: At the debrief, compare the actual response with the plan, identify delays or missing resources, assign corrective actions and verify completion before the next similar task.",
    ],
    stopWorkConditions: <String>[
      'Unprotected edge; absent flotation/rescue kit; unsafe water conditions; untrained water entry; poor visibility; vessel/propeller hazards; no medical response.',
    ],
    interviewQuestions: <String>[
      'What is the first action after a man-overboard event?',
      'Why should untrained coworkers not jump in?',
      'What details should be handed to medical responders?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-39',
    title: 'Vehicle & Mobile Plant Entrapment Rescue',
    purpose: 'Coordinate a safe response when a person is trapped, crushed or isolated by a vehicle or mobile plant incident.',
    scope: 'Applies to site roads, logistics yards, construction plant, forklifts, cranes, buses and heavy vehicles.',
    keyKnowledge: <String>[
      'Raise alarm, stop movement and secure the scene. Prevent secondary collision, rollover, movement or energy release.',
      'Do not move a vehicle, load or trapped casualty unless an immediate life threat requires action directed by competent responders.',
      'Isolate ignition, electrical, hydraulic, pneumatic or stored energy only through competent personnel and approved methods; beware suspended or unstable loads.',
      'Call emergency medical services and specialist extrication support early. Give vehicle type, load, location, casualty count and access constraints.',
      'Control traffic with a safe perimeter, barriers and a designated traffic controller; keep emergency access clear.',
      'Assess fire, fuel leak, battery, high-voltage vehicle systems, hazardous cargo, unstable ground and nearby overhead services.',
      'Only trained responders should use cutting, lifting, spreading or stabilization equipment. Uncontrolled movement can worsen crush injuries.',
      'Provide first aid within competence, monitor casualty condition and avoid unnecessary movement where spinal or crush injury is possible.',
      'Preserve vehicle position, telematics/CCTV, inspection records, operator authorization, traffic plan and witness information as appropriate.',
      'Restart requires investigation, plant inspection, route review, authorization and closure of corrective actions.',
    
      "Stop and secure the involved vehicle or plant only where this can be done without exposing others; isolate traffic, prevent movement, lower attachments if safe and control ignition or energy hazards through competent operators.",
      "Do not move a trapped casualty or cut structural components unless directed by trained rescue personnel, except immediate action required to prevent imminent greater harm within the responder’s competence.",
      "Give responders machine type, power source, load or attachment position, stability concerns, hydraulic/electrical energy, fuel or battery hazards and safe access routes.",
      "Separate recovery operations from rescue: do not restart, tow or lift the machine until casualty care, scene release, isolation and competent investigation requirements are satisfied.",
    ],
    siteImplementation: <String>[
      'Stop traffic and plant; secure a wide exclusion zone.',
      'Call ambulance and specialist rescue; provide accurate location and access route.',
      'Identify energy sources, load stability, fuel and battery hazards.',
      'Keep untrained persons away from extrication activity.',
      'Preserve evidence and verify corrective actions before restart.',
    
      "Before the task, brief the team on roles, communication, exclusion boundaries, emergency call route, equipment readiness and who can stop or abort the operation.",
      "During response, maintain scene control, protect bystanders, provide concise updates to the incident lead and record important times, decisions and handovers.",
      "Afterward, secure the area, account for personnel, report equipment defects and participate in debriefing; do not resume work until formal authorization.",
    ],
    practicalExample: <String>[
      'A forklift tips near a loading bay. The supervisor isolates the lane, prevents other vehicles entering, calls emergency services and shares the forklift type and load details.',
    
      "Example: A worker reports this emergency during a live shift. The supervisor stops affected work, raises the site alarm, gives the exact location and known hazards, keeps others clear and activates the approved response plan.",
      "Example review: At the debrief, compare the actual response with the plan, identify delays or missing resources, assign corrective actions and verify completion before the next similar task.",
    ],
    stopWorkConditions: <String>[
      'Unstable load/vehicle; leaking fuel; energized system; uncontrolled traffic; untrained lifting/cutting; poor responder access; attempted restart before inspection.',
    ],
    interviewQuestions: <String>[
      'Why must plant movement be controlled before rescue?',
      'Who should perform technical extrication?',
      'What hazards should be reported to responders?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-40',
    title: 'Structural Collapse & Building Failure Response',
    purpose: 'Protect personnel and coordinate specialist response after partial or full structural failure.',
    scope: 'Applies to buildings, scaffolds, temporary works, formwork, falsework, retaining structures and industrial structures.',
    keyKnowledge: <String>[
      'After suspected collapse, raise alarm, evacuate to a safe distance and establish a perimeter. Secondary collapse may occur without warning.',
      'Do not enter, climb debris or move structural members to search for casualties unless directed by qualified rescue command.',
      'Identify the structure, collapse extent, ongoing movement, fire, electrical/gas services, hazardous materials, weather and access constraints.',
      'Notify emergency services and specialist urban search-and-rescue resources where required; share drawings, load information and last known occupancy.',
      'Isolate utilities through authorized personnel where safe; consider live electrical cables, gas, water, process lines and stored energy.',
      'Control cranes, excavators, lifting operations and vehicle vibration near the collapse zone; equipment use must be coordinated by competent command.',
      'Account for workers and visitors using muster records, permits, work-front rosters and supervisor confirmation.',
      'Only competent structural engineers and rescue specialists should assess stability, shoring, lifting or controlled debris removal.',
      'Provide casualty care and medical access when a safe rescue corridor is established; keep communication and incident command centralized.',
      'Re-entry and reconstruction require formal engineering assessment, authority/site approvals as applicable, investigation and documented release.',
    
      "Following structural failure, establish a perimeter and prevent entry because debris, suspended elements, utilities, fire and progressive collapse may remain active hazards.",
      "Call specialist urban-search-and-rescue or civil-defence resources through the site emergency command. Share drawings, building use, occupancy, last-known casualty locations and hazardous process information.",
      "Do not move debris, operate plant near the collapse or enter voids without a coordinated technical assessment and authorization; protect rescuers from secondary collapse and utility releases.",
      "Preserve scene information where practicable, record decisions and handovers, and allow re-entry only after competent structural assessment and formal release.",
    ],
    siteImplementation: <String>[
      'Evacuate, alarm and establish exclusion perimeter.',
      'Provide drawings, temporary works design, inspection records and occupancy details to responders.',
      'Identify and isolate services through authorized persons.',
      'Maintain personnel accounting and control all access.',
      'Do not permit re-entry until competent formal release.',
    
      "Before the task, brief the team on roles, communication, exclusion boundaries, emergency call route, equipment readiness and who can stop or abort the operation.",
      "During response, maintain scene control, protect bystanders, provide concise updates to the incident lead and record important times, decisions and handovers.",
      "Afterward, secure the area, account for personnel, report equipment defects and participate in debriefing; do not resume work until formal authorization.",
    ],
    practicalExample: <String>[
      'Formwork shows sudden movement and part of a slab collapses. The team evacuates adjacent zones, stops concrete placement and lifting, raises alarm and provides temporary-works drawings to responders.',
    
      "Example: A worker reports this emergency during a live shift. The supervisor stops affected work, raises the site alarm, gives the exact location and known hazards, keeps others clear and activates the approved response plan.",
      "Example review: At the debrief, compare the actual response with the plan, identify delays or missing resources, assign corrective actions and verify completion before the next similar task.",
    ],
    stopWorkConditions: <String>[
      'Ongoing movement; cracking/noise; unstable debris; unknown utilities; uncontrolled plant; untrained entry; missing accountability; no engineering release.',
    ],
    interviewQuestions: <String>[
      'Why is secondary collapse a major concern?',
      'What documents can assist rescue command?',
      'Who can authorize re-entry after structural failure?',
    ],
  ),
];
