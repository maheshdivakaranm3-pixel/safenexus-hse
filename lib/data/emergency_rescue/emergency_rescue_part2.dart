// SafeNexus HSE — Emergency & Rescue Part 2
// File: lib/data/emergency_rescue/emergency_rescue_part2.dart
//
// Topics 05–08: Assembly Point, Fire Emergency, First Aid, Confined Space Rescue.
// General field-learning content. Follow the current site ERP, approved rescue
// plan, applicable authority requirements, and competent emergency responders.
// No unverified legal clause numbers, dimensions, or drill frequencies asserted.

import 'emergency_rescue_part1.dart';

const List<EmergencyRescueTopic> emergencyRescuePart2 = <EmergencyRescueTopic>[
  EmergencyRescueTopic(
    id: 'ER-05',
    title: 'Assembly Point & Personnel Accountability',
    purpose:
        'An assembly point is a designated location used after an evacuation so people can move away from immediate danger, receive instructions, and be accounted for. Personnel accountability helps the emergency coordinator identify who is safe, who is injured, and who may still be missing. Reaching the assembly point alone does not prove that everyone has been accounted for.',
    scope:
        'Applies to employees, subcontractors, visitors, delivery personnel, and other persons present at the site. Assembly arrangements must fit the site layout, changing work fronts, shift patterns, emergency scenarios, and the possibility that a normal assembly point becomes unsafe.',
    keyKnowledge: <String>[
      'The assembly point should be selected using the site risk assessment. Consider separation from credible hazards, smoke or vapor travel, traffic, falling objects, structural collapse, emergency vehicle access, and the need to keep gates and responder routes clear.',
      'A site may need a primary and an alternative assembly point. The alternative is used only under the site ERP or authorized instruction when the primary point is threatened, inaccessible, or unsuitable.',
      'Workers should know the assembly point for their work area before starting work. A single site-wide location may not be suitable for a large, multi-zone project or a site with changing phases.',
      'Personnel accountability means comparing the people expected to be present with those actually reported safe. Use current shift rosters, contractor lists, visitor logs, work permits or work-front registers as applicable; stale lists can create false assurance.',
      'Supervisors should account for their assigned teams and report results to the designated coordinator. Visitors should be accounted for through the host or visitor-control process.',
      'Report missing, injured, transferred-to-first-aid, or otherwise unaccounted persons separately. Give their name, employer/team, last known location, work activity, and any known exposure or hazard. Do not guess or delay reporting while trying to reconcile every detail.',
      'Do not allow workers to leave the assembly point without informing the responsible person. A person who leaves for a vehicle, gate, toilet, or another muster area can appear missing during headcount.',
      'Do not send untrained coworkers back into a danger area to search. The emergency coordinator must pass verified information to the competent rescue team or public emergency services.',
      'Assembly points must remain identifiable and usable. Construction changes, parked vehicles, stored materials, excavation, hot work, or wind direction can make a previously suitable point unsafe.',
      'Headcount is not complete until discrepancies are communicated, checked through safe means, and the coordinator records the status or outstanding uncertainty.',
    ],
    siteImplementation: <String>[
      'Show primary and alternative assembly locations on the site emergency map and explain them during induction, toolbox talks, and work-front briefings.',
      'At the start of each shift, confirm the supervisor/team allocation, contractor presence, visitor-host arrangement, and the method for reporting headcount.',
      'When an evacuation instruction is given, proceed by a safe route to the assigned assembly point. Do not stop at a vehicle, collect belongings, or block access roads.',
      'Report to the assigned supervisor or warden. State your name/team and report any injury, exposure, missing colleague, or person who may have gone to first aid.',
      'Supervisors compare the current attendance information with persons present and promptly send the result to the coordinator using the agreed communication method.',
      'For a discrepancy, provide the missing person’s identity, last known location, task, and hazards. Keep the information factual and update it if new facts are confirmed.',
      'Keep the assembly point orderly, away from emergency access routes, and clear of vehicle movement. Follow instructions to move to an alternative safe location if directed.',
      'Do not leave or re-enter until the authorized emergency lead gives instructions. Record any departure or transfer through the designated accountability process.',
      'After a drill or incident, review delayed headcounts, outdated lists, unclear muster signs, crowding, communication failures, and any people not included in the roll call.',
      'Update maps, rosters, induction material, and contractor arrangements whenever the site layout, work zones, workforce, or assembly location changes.',
    ],
    practicalExample: <String>[
      'Scenario: During an evacuation, a subcontractor team reports that 18 workers reached the assembly point, but the current team list shows 19. The supervisor immediately tells the emergency coordinator that one worker is unaccounted for, provides the worker’s name, last assigned work area, and task, and confirms whether the worker was sent to first aid or another location. The supervisor does not send another worker back to search. The coordinator shares the information with the authorized rescue response.',
      'Field lesson: Never report “all safe” based only on a visual glance. Use a defined list or reliable check-in method, report uncertainty promptly, and keep the assembly point clear for responders.',
      'SITE PLAN — ASSEMBLY POINT & MUSTER PLAN: Site/project: ______; date/revision: ______; incident controller: ______; primary assembly point: ______; alternative point: ______; alarm method: ______; evacuation routes shown on attached site map: ______; muster controller by zone: ______; team/visitor roster source: ______; headcount reporting channel: ______; emergency access gate: ______; missing-person escalation contact: ______; re-entry authority: ______; approval: ______. Before issue, verify locations against current site hazards and layout.',
      'MUSTER CHECKLIST: Alarm heard; safe route used; supervisors completed roll call; visitors accounted for by hosts; injured/transferred persons separately recorded; missing-person details and last known location reported; emergency access kept clear; no unauthorized re-entry; discrepancies closed or formally handed to incident controller.'
    ],
    stopWorkConditions: <String>[
      'The designated assembly point is exposed to the current hazard, blocked, or inaccessible and no safe alternative has been communicated.',
      'Personnel cannot reliably be accounted for because current team/visitor information or communication arrangements are missing.',
      'Workers are being told to re-enter or conduct an informal search in an uncontrolled area.',
      'The assembly location or access route creates a traffic conflict or obstructs emergency vehicles.',
    ],
    interviewQuestions: <String>[
      'Q: What is the purpose of an assembly point? A: To move people to a designated safer location, receive instructions, and support reliable personnel accountability.',
      'Q: What information should be given for a missing person? A: Name, employer/team, last known location, task, time last seen if known, and relevant hazards; distinguish confirmed facts from uncertainty.',
      'Q: Who performs headcount? A: Assigned supervisors, wardens, hosts, or designated personnel under the site ERP, reporting results to the emergency coordinator.',
      'Q: Should coworkers return to search for a missing person? A: No. Report the details immediately; only an authorized competent rescue response should plan any search or rescue.',
      'Q: When should an alternative assembly point be used? A: When the primary point is unsafe, inaccessible, or unsuitable, following the ERP or authorized emergency instruction.',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-06',
    title: 'Fire Emergency & Initial Response',
    purpose:
        'Fire emergency response aims to raise the alarm early, protect people from flame, heat and smoke, prevent further exposure, support evacuation, and provide accurate information to trained responders. Extinguisher use is secondary to life safety and is appropriate only when the person is trained, the fire is small and suitable for the available extinguisher, and a safe escape route remains available.',
    scope:
        'Applies to offices, accommodation, workshops, stores, construction areas, temporary electrical installations, hot-work locations, plant rooms, vehicles, and other site areas. Follow the site fire plan and the instructions of the emergency coordinator and fire service.',
    keyKnowledge: <String>[
      'Fire requires fuel, heat, and oxygen. Prevention controls one or more of these elements through housekeeping, ignition-source control, safe storage, equipment maintenance, and hot-work controls.',
      'Common site fire scenarios include electrical equipment, temporary distribution boards, hot work, flammable liquids or gases, cooking areas, waste accumulation, vehicles, batteries, and combustible materials.',
      'Smoke and toxic combustion products can incapacitate people before flames reach them. Do not enter smoke-filled rooms, enclosed areas, or unknown atmospheres to investigate or retrieve property.',
      'The first actions are to raise the alarm, warn nearby people, stop work if safe, and evacuate or move to a designated safe location. Call emergency services according to the site ERP.',
      'Only trained and authorized persons should attempt initial firefighting, and only when the fire is incipient, the extinguisher is suitable, the approach is safe, and a clear escape route is behind them. If in doubt, evacuate.',
      'Do not use water on energized electrical equipment or burning substances for which water is unsuitable. Select firefighting media only according to training, equipment labeling, site procedure, and competent advice.',
      'Fire doors, exits, alarm call points, extinguishers, hose reels, and emergency access routes must remain accessible and must not be blocked or misused.',
      'Hot-work controls may include authorization/permit, removal or protection of combustibles, suitable fire watch, gas testing where specified by the risk assessment, and post-work monitoring according to the approved procedure.',
      'After evacuation, report people missing, injuries, the fire location, known fuel or chemical hazards, electrical or stored-energy concerns, and any actions already taken.',
      'Do not re-enter or restart work until the authorized lead or relevant authority confirms that the area is safe and required inspections, isolation, cleanup, and corrective actions are complete.',
    ],
    siteImplementation: <String>[
      'On seeing fire, smoke, or an unusual burning smell, raise the alarm using the site method and give the exact location. Do not wait to identify the cause.',
      'Warn people in the immediate area without approaching the fire or smoke. Stop nearby work and isolate equipment only if safe and authorized.',
      'Evacuate by the safest available route to the assigned assembly point. Keep emergency vehicle access and gates clear.',
      'Call the designated emergency number or arrange the call through the control point. State site name, exact location, fire type if known, people injured or missing, hazards, gate/meeting point, and caller contact.',
      'If trained and if all safe conditions are met, a person may use the correct extinguisher on a small incipient fire while keeping an escape route available. Stop immediately if the fire grows, smoke increases, heat becomes intense, or escape is threatened.',
      'Do not fight a fire involving unknown chemicals, pressurized cylinders, gas leaks, energized equipment, or an enclosed/rapidly developing fire unless specifically trained, equipped, and directed under the emergency plan.',
      'At the assembly point, account for workers and visitors and report missing persons with last known location and relevant hazards.',
      'Meet responders at the agreed gate if safe and brief them on location, fuel/materials involved, electrical isolation status if verified, cylinders or chemicals, and any missing persons.',
      'Preserve the scene after life safety is addressed. Do not reset alarms, remove evidence, or restart affected equipment without authorization.',
      'After the event, inspect and replenish used or damaged firefighting equipment, review ignition-source controls, and close corrective actions before affected work restarts.',
    ],
    practicalExample: <String>[
      'Scenario: A small fire is seen at a temporary electrical panel. A worker activates the alarm and warns nearby personnel. The area is evacuated. Nobody throws water on the panel or opens it to investigate. An authorized person isolates the supply only if this can be done safely. A trained responder may use a suitable extinguisher only if the fire remains incipient and escape is clear; otherwise everyone withdraws. Emergency services are given the panel location and electrical hazard information.',
      'Field lesson: “I have an extinguisher” is not proof that firefighting is safe. Alarm, evacuation, safe distance, correct extinguisher selection, training, and escape route govern the decision.',
      'SITE PLAN — FIRE EMERGENCY RESPONSE PLAN: Site/area: ______; alarm point/method: ______; emergency contact: ______; incident controller: ______; fire wardens: ______; assembly point: ______; responder access gate/meeting person: ______; known fuel/chemical/electrical hazards: ______; isolation authority: ______; fire equipment locations: ______; first-aid/medical interface: ______; re-entry and restart authority: ______; approval/revision: ______. Attach area map and verify the plan against the actual fire risk assessment.',
      'FIRE RESPONSE CHECKLIST: Raise alarm; warn and evacuate; call emergency services per ERP; report exact location and hazards; use extinguisher only if trained, fire is incipient, correct media is available and escape remains clear; account for people; meet responders; prevent re-entry; inspect/replenish equipment and close corrective actions.'
    ],
    stopWorkConditions: <String>[
      'Fire, smoke, heat, or suspected gas release threatens the work area or escape route.',
      'Required fire alarm, escape route, fire watch, or hot-work control is absent or ineffective for the activity.',
      'A person is attempting firefighting without suitable training, equipment, safe access, or a clear escape route.',
      'Re-entry or restart is proposed before the area is declared safe and required isolation or inspection is complete.',
    ],
    interviewQuestions: <String>[
      'Q: What are the first actions on discovering a fire? A: Raise alarm, warn people, stop work if safe, evacuate, call/notify the response team, and report hazards and missing persons.',
      'Q: When may a worker use an extinguisher? A: Only if trained, the fire is small and suitable, conditions are safe, and a clear escape route remains; otherwise withdraw.',
      'Q: Why is smoke dangerous? A: It can reduce visibility and contain toxic or oxygen-displacing products, causing rapid incapacitation.',
      'Q: Can water be used on an electrical fire? A: Do not use water on energized electrical equipment. Follow extinguisher labeling and trained response procedures.',
      'Q: Who authorizes re-entry? A: The authorized site emergency lead or relevant authority under the ERP after safety is assessed and controlled.',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-07',
    title: 'First Aid & Medical Emergency',
    purpose:
        'First aid is immediate, limited care given to a person who is injured or suddenly ill until appropriate medical care takes over. The priorities are scene safety, early alarm, rapid recognition of life-threatening conditions, care within the responder’s training, and safe handover to medical professionals.',
    scope:
        'Applies to workplace injury, sudden illness, collapse, burns, bleeding, suspected fracture, heat-related illness, chemical exposure, electrical injury, and other medical events. Follow the site medical emergency plan, trained first-aider scope, and emergency-service instructions.',
    keyKnowledge: <String>[
      'Check scene safety before approaching. Consider traffic, electricity, fire, chemicals, unstable structures, moving machinery, confined spaces, and other hazards. Do not become a second casualty.',
      'Raise the alarm early and request the site first aider or medical response. Call emergency services for serious, life-threatening, uncertain, or worsening conditions according to the site procedure.',
      'Use a structured initial assessment taught in recognized first-aid training. Check responsiveness and normal breathing; follow current training and dispatcher instructions. If the person is unresponsive and not breathing normally, emergency services and CPR/AED response are urgent.',
      'Only trained persons should provide CPR, use an AED, control serious bleeding, manage burns, or perform other interventions, following their training and the device instructions. Do not delay emergency activation while seeking equipment.',
      'Do not move a casualty with possible spinal, major fracture, or serious trauma unless necessary to remove them from immediate danger or instructed by competent responders.',
      'For chemical exposure, protect the rescuer, identify the substance from a safe source if possible, use the relevant safety data sheet and site procedure, and arrange prompt medical assessment. Do not touch contaminated clothing or material without suitable protection.',
      'For suspected electrical shock, do not touch the casualty until the electrical source is isolated and the area is confirmed safe. Request emergency medical assistance even if the person appears to recover, as serious effects may not be immediately obvious.',
      'For heat illness, move the person to a safer cooler location only if this can be done safely, summon trained medical support, and follow the site heat-stress response procedure. Altered consciousness, collapse, or severe symptoms require urgent emergency response.',
      'Maintain privacy and dignity. Do not share casualty photographs, names, or medical details through informal channels. Provide only necessary information to responders and authorized site personnel.',
      'Record factual information after care is underway: time, location, observed condition, known exposure, first aid provided, people notified, and handover. Avoid unsupported diagnosis or blame.',
    ],
    siteImplementation: <String>[
      'Stop and assess hazards before approaching. If the area is unsafe, keep others away and request specialist response rather than entering.',
      'Raise the alarm and request the designated first aider/medical team. Arrange emergency-service call when required by severity, uncertainty, or site procedure.',
      'Introduce yourself if safe, obtain consent where the person is conscious and able to respond, and explain what assistance is being offered.',
      'Follow your current first-aid training: assess responsiveness and breathing, control immediate life threats within competence, and use an AED/CPR only as trained and directed.',
      'Send a person to meet the ambulance or medical team at the agreed access gate, if safe, and keep the route clear.',
      'Do not give food, drink, medication, or treatment outside your training and approved procedure. Do not remove embedded objects or apply untrained interventions.',
      'For chemical or eye exposure, use the site emergency shower/eyewash and substance-specific procedure where appropriate, while arranging urgent medical advice. Follow the SDS and trained responder instructions.',
      'Keep the casualty warm, reassured, and monitored within your competence until handover. Note changes and communicate them to medical responders.',
      'Give a clear handover: identity if known, incident mechanism, time, symptoms observed, known exposures, first aid performed, changes, and relevant site hazards.',
      'Complete the site incident/first-aid record through authorized channels, protect personal information, replenish used supplies, and review any control failures.',
    ],
    practicalExample: <String>[
      'Scenario: A worker collapses in a workshop. The nearest colleague checks for hazards and does not approach moving machinery or exposed electrical equipment. They raise the alarm and call the trained first aider. A second person meets the medical team at the gate. The trained responder assesses the casualty and follows current training and emergency-dispatch instructions. The team gives responders the observed timeline and any known exposure; coworkers do not speculate about the diagnosis.',
      'Field lesson: First aid begins with scene safety and early escalation. A first aider should work within competence and must not delay professional medical help for a serious or uncertain condition.',
      'SITE PLAN — FIRST AID & MEDICAL EMERGENCY RESPONSE PLAN: Site/area: ______; emergency call method/number per approved site contacts: ______; first aider per shift: ______; first-aid point: ______; ambulance access gate and guide: ______; nearest designated medical facility per site arrangement: ______; casualty transfer route: ______; communication channel: ______; incident controller: ______; record custodian: ______; approval/revision: ______. Confirm contacts and access details before the plan is issued.',
      'MEDICAL RESPONSE CHECKLIST: Make scene safe; raise alarm; request trained first aider and emergency services when indicated; use care within training; do not touch electrical casualty until isolation/safety confirmed; send guide to gate; protect privacy; hand over observed facts and care given; document event through authorized process; replenish supplies.'
    ],
    stopWorkConditions: <String>[
      'The scene remains unsafe because of electricity, chemicals, fire, traffic, unstable structures, or other uncontrolled hazards.',
      'The casualty has a potentially life-threatening condition, serious injury, altered consciousness, abnormal breathing, or worsening symptoms and emergency assistance has not been activated.',
      'A person is being asked to perform treatment beyond their training or without suitable protective equipment.',
      'Contamination, exposure, or a medical emergency affects nearby workers and the area has not been controlled.',
    ],
    interviewQuestions: <String>[
      'Q: What is the first priority before giving first aid? A: Scene safety—protect yourself, the casualty, and others from hazards.',
      'Q: What should you do for an unresponsive person who is not breathing normally? A: Activate emergency response immediately and follow current CPR/AED training and dispatcher instructions.',
      'Q: Should an electrical-shock casualty be touched immediately? A: No. Ensure the electrical source is isolated and the scene is safe first; call emergency medical help.',
      'Q: What should be included in medical handover? A: Event mechanism, time, observed signs, known exposure, care provided, changes, and relevant hazards—without unsupported diagnosis.',
      'Q: Can a first aider give medication? A: Only where permitted by their training, authorization, and site procedure; otherwise do not administer medication.',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-08',
    title: 'Confined Space Rescue',
    purpose:
        'Confined-space rescue is a planned response to a person who is injured, unconscious, trapped, or unable to exit a confined space. It is a high-risk operation because rescuers may face the same hazardous atmosphere, restricted access, entanglement, engulfment, or difficult casualty movement. The fundamental rule is to raise the alarm and use the approved rescue plan; unplanned entry can create multiple casualties.',
    scope:
        'Applies to tanks, vessels, manholes, pits, sewers, chambers, ducts, and other spaces identified as confined spaces under the project risk assessment and applicable procedure. The exact classification and controls must be confirmed by the site competent person; do not assume every pit or vessel has identical hazards.',
    keyKnowledge: <String>[
      'Potential hazards include oxygen deficiency or enrichment, toxic gases, flammable atmosphere, engulfment, flooding, heat, mechanical or electrical energy, poor access, restricted movement, and changing process conditions.',
      'A confined-space entry permit and associated risk assessment should define the space, task, hazards, isolations, atmospheric testing, ventilation, attendant, communication, entrants, rescue method, equipment, and authorization. Follow the current site permit system and applicable requirements.',
      'Rescue planning must be completed before entry begins. Identify how an alarm is raised, who leads the rescue, who is trained and equipped, how the casualty will be recovered, how emergency services are contacted, and how the space is kept controlled.',
      'A standby attendant remains outside, maintains communication and entry records, monitors conditions as assigned, raises the alarm, and does not abandon the post or enter to rescue unless the approved plan explicitly assigns a trained and equipped entry-rescue role.',
      'Non-entry retrieval may be possible when the space, casualty, anchor points, retrieval device, and task setup make it suitable. It is not automatically safe or effective; entanglement, geometry, casualty condition, or hazardous atmosphere may require a different planned method.',
      'Atmospheric monitoring and ventilation must follow the permit and competent-person instructions. A reading taken before entry does not guarantee conditions remain safe; monitor as required by the risk assessment and task conditions.',
      'Rescue equipment may include suitable retrieval systems, harnesses, breathing apparatus, gas monitoring, communications, lighting, and first-aid equipment. Selection, inspection, compatibility, and use require trained competent personnel.',
      'Do not use an ordinary dust mask or a filtering respirator as a substitute for breathing apparatus where the atmosphere is oxygen-deficient or immediately dangerous. Rescuers must use equipment suitable for the identified atmosphere and trained procedures.',
      'Energy and process isolation must be verified as required: mechanical movement, electrical supply, inflow, pressure, agitation, and connected lines can create fatal hazards during rescue.',
      'After rescue, arrange medical assessment, secure the space, preserve relevant records, investigate causes, and review the permit, isolation, monitoring, supervision, and rescue readiness before any re-entry.',
    ],
    siteImplementation: <String>[
      'On discovering a person in distress, raise the emergency alarm immediately. Tell the coordinator the exact space ID/location, number of persons, last known condition, task, and known or suspected hazards.',
      'The attendant remains outside, maintains communication if possible, prevents unauthorized entry, and follows the approved emergency plan. Do not allow coworkers to rush into the space.',
      'Stop related work and prevent additional entry. Keep the entry point clear for the rescue team and emergency services.',
      'Provide the rescue team with the permit, risk assessment, isolation status, atmospheric readings and trends if available, entry log, communication method, and details of the casualty’s position and task.',
      'Use non-entry retrieval only when the approved plan, equipment arrangement, casualty condition, and space geometry make it suitable and the operation can be performed without exposing rescuers.',
      'If entry rescue is required, it must be conducted only by a competent, trained, equipped team under the approved rescue plan, with atmospheric control/monitoring, suitable respiratory protection, communications, backup/rescue provision, and verified isolation as applicable.',
      'Do not attempt to ventilate or enter in a way that spreads contaminants, introduces ignition, disturbs material, or creates additional danger. Follow competent rescue-team direction.',
      'Once the casualty is recovered, trained first aiders and medical responders provide care within competence and arrange urgent medical assessment as appropriate to the exposure and condition.',
      'Keep the area controlled, preserve permit and monitoring records, and report all facts to the incident lead. Do not restart entry work until the cause, controls, permit, and rescue readiness have been reviewed and reauthorized.',
      'After drills, assess alarm raising, attendant actions, retrieval compatibility, communication, responder access, equipment readiness, and the time lost to confusion; assign corrective actions and verify closure.',
    ],
    practicalExample: <String>[
      'Scenario: A worker inside a manhole stops responding during cleaning. The standby attendant raises the alarm, reports the manhole identifier and task, tells others not to enter, and keeps the entry point clear. The coordinator activates the approved confined-space rescue team and emergency services as required. The team reviews the permit, isolation and atmospheric information, then selects the planned retrieval method. No coworker climbs in spontaneously. After recovery, medical care and incident review follow.',
      'Field lesson: Many multiple-fatality confined-space events begin when an unprotected coworker enters to help. The attendant’s most important immediate action is to raise the alarm, prevent impulsive entry, and activate the planned rescue capability.',
      'SITE PLAN — CONFINED SPACE RESCUE PLAN: Space ID/location: ______; task/permit number: ______; entry supervisor: ______; attendant: ______; entrant(s): ______; rescue lead/team and verified availability: ______; alarm/communication: ______; isolation points and verification: ______; atmospheric hazards and monitoring method: ______; planned non-entry retrieval suitability: ______; entry-rescue method and competent team: ______; equipment/inspection status: ______; emergency-service interface/access gate: ______; medical handover point: ______; approval/revision: ______. Complete and validate for this exact space and task before entry; a generic template is not rescue authorization.',
      'PRE-ENTRY RESCUE READINESS CHECKLIST: Permit and risk assessment approved; isolation verified; atmosphere tested and monitoring arranged; attendant assigned; communications tested; rescue team and response route confirmed; retrieval system compatible with geometry and casualty; equipment inspected; rescue roles briefed; emergency contacts and access confirmed; no entry starts until every required control is in place.'
    ],
    stopWorkConditions: <String>[
      'No approved rescue plan, trained rescue capability, suitable equipment, or reliable alarm/communication is available before confined-space entry.',
      'Atmospheric testing/monitoring, ventilation, attendant coverage, or required isolation is missing, unreliable, or outside the permit conditions.',
      'A worker becomes unresponsive, communication is lost, atmosphere changes, or an alarm/monitor indicates a dangerous condition: stop work, initiate the ERP, and withdraw/evacuate as the plan directs.',
      'An untrained person attempts entry rescue or suitable respiratory protection and backup rescue arrangements are absent.',
      'The space, process, or task changes from the permit assumptions and the competent person has not reassessed and reauthorized the work.',
    ],
    interviewQuestions: <String>[
      'Q: What is the first action when a confined-space entrant collapses? A: Raise the alarm, notify the coordinator, prevent unplanned entry, and activate the approved rescue plan.',
      'Q: Why must an attendant not rush inside? A: The attendant may be overcome by the same atmosphere or hazard, creating additional casualties and leaving the entry uncontrolled.',
      'Q: What is non-entry rescue? A: A planned retrieval method performed from outside the space when the geometry, casualty, equipment, and hazard conditions make it suitable.',
      'Q: What should be confirmed before entry work starts? A: Risk assessment and permit, isolation, atmospheric testing/monitoring, ventilation as required, attendant and communication, trained entrants, rescue plan, suitable equipment, and emergency-service interface.',
      'Q: Can a filtering face mask protect a rescuer in an oxygen-deficient atmosphere? A: No. Filtering masks do not supply oxygen; respiratory protection must be selected for the actual hazard by competent personnel.',
      'Q: What happens after rescue? A: Arrange medical assessment, secure the area, preserve records, investigate causes, review controls and rescue readiness, and reauthorize work only after hazards are controlled.',
    ],
  ),
];
