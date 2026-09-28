// SafeNexus HSE — Emergency & Rescue Part 1
// File: lib/data/emergency_rescue/emergency_rescue_part1.dart
//
// Detailed field handbook foundation for Topics 01–04.
// General operational learning material. Follow the current site ERP,
// competent-person instructions, applicable authority requirements and
// emergency-service directions. No unverified legal limits are asserted.

class EmergencyRescueTopic {
  final String id;
  final String title;
  final String purpose;
  final String scope;
  final List<String> keyKnowledge;
  final List<String> siteImplementation;
  final List<String> practicalExample;
  final List<String> stopWorkConditions;
  final List<String> interviewQuestions;

  const EmergencyRescueTopic({
    required this.id,
    required this.title,
    required this.purpose,
    required this.scope,
    required this.keyKnowledge,
    required this.siteImplementation,
    required this.practicalExample,
    required this.stopWorkConditions,
    required this.interviewQuestions,
  });
}

const List<EmergencyRescueTopic> emergencyRescuePart1 = <EmergencyRescueTopic>[
  EmergencyRescueTopic(
    id: 'ER-01',
    title: 'Emergency Management',
    purpose:
        'Emergency Management is the organized system used to anticipate credible emergencies, prepare people and resources, coordinate the response, protect life, limit environmental and property damage, and restore safe operations after the event. The priority is life safety; asset protection and business continuity must never delay an urgent warning, evacuation, or request for assistance.',
    scope:
        'Applies to employees, subcontractors, visitors, work fronts, offices, camps, workshops, stores, temporary facilities, plant and equipment, and interfaces with neighboring work sites or public emergency services. The plan must reflect the actual project boundary, work phases, shifts, access arrangements, and changing site hazards.',
    keyKnowledge: <String>[
      'The management cycle has four connected stages: prevention/mitigation, preparedness, response, and recovery. Prevention reduces the likelihood or severity of an event; preparedness makes people and systems ready; response controls immediate danger; recovery restores safe conditions and captures lessons.',
      'A site Emergency Response Plan (ERP) is a practical action document, not only a policy. It should identify credible scenarios, alarm methods, emergency roles, evacuation and shelter arrangements, assembly points, personnel accounting, emergency contacts, access gates, responder meeting points, and recovery/reporting arrangements.',
      'Scenario selection should be based on site risk assessment and changing activities. Consider fire, medical event, collapse, confined-space emergency, work-at-height rescue, lifting incident, electrical shock, chemical spill, gas release, severe weather, heat illness, traffic incident, and man-overboard where relevant.',
      'Emergency organization should clearly identify the incident controller/coordinator, deputy, alarm/communications role, area wardens, first aiders, fire team, rescue specialists, security/gate controller, and personnel-accountability lead. One person may hold more than one role only where the workload and site conditions make it practicable.',
      'Roles must be assigned to named or clearly designated competent people for each shift. A plan that names only day-shift personnel is not adequate for night work, weekends, remote work fronts, or changing contractor teams.',
      'Emergency equipment must match the assessed scenarios and be accessible, maintained, inspected, and understood by assigned users. Examples include alarms, radios, first-aid supplies, suitable fire equipment, emergency lighting, spill kits, rescue equipment, and site maps.',
      'External emergency responders need accurate location information, a usable access gate, a person to meet them where safe, and early notice of special hazards such as chemicals, stored energy, confined spaces, or restricted access.',
      'Training and drills should test real actions: whether people hear and understand the alarm, use safe routes, reach the correct assembly point, are accounted for, and know how to report a missing person. Frequency must follow applicable requirements and the site risk-based plan; do not assume one universal interval.',
      'After an emergency or drill, review delays, communication gaps, route obstructions, equipment defects, role confusion, and accountability failures. Assign an owner and due date for corrective actions, then verify closure.',
      'Emergency plans must be reviewed when layout, process, workforce, access, hazards, equipment, or emergency contacts change, and after an incident or drill identifies a weakness.',
    ],
    siteImplementation: <String>[
      'Walk the site with operations, supervisors, security, contractors, and emergency-role holders. Identify high-risk areas, isolated work fronts, access restrictions, adjacent exposures, muster locations, and routes that may be blocked by construction or deliveries.',
      'Prepare or update the site ERP and supporting map. Show site name, location, gate/access route, emergency control point, assembly points, first-aid and emergency equipment locations, and any special hazard information needed by responders.',
      'Create a role and contact matrix for every operating shift. Confirm who raises the alarm, who coordinates, who calls external services, who controls the gate, who checks the work area, and who collects headcount information.',
      'At induction and toolbox talks, explain alarm meanings, immediate actions, escape routes, assembly points, missing-person reporting, and the rule against unauthorized re-entry. Use languages and methods workers can understand.',
      'Verify that alarms and backup warning methods can reach noisy, remote, enclosed, elevated, and night-shift work areas. Confirm radios/phones are charged, assigned, and tested under site arrangements.',
      'Check emergency exits and access routes during routine site inspections. Keep them identifiable and free from stored materials, parked vehicles, temporary cables, and other obstructions.',
      'Check emergency equipment against the site inventory and inspection schedule. Remove defective equipment from service, report the defect, and provide suitable temporary controls before affected work continues.',
      'Coordinate emergency interfaces with the client, facility owner, security, neighboring contractors, and external responders where the site arrangement requires it.',
      'Run drills based on credible scenarios and record observations. Include contractors and visitors where practicable; test headcount and communication rather than merely sounding an alarm.',
      'After a real event, preserve life-safety priorities, secure the scene when safe, report through required channels, support investigation, arrange welfare follow-up, and authorize restart only after hazards and controls have been reviewed.',
    ],
    practicalExample: <String>[
      'Scenario: Smoke is reported from a temporary electrical distribution board near a work area. The observer raises the alarm and gives the exact location. The supervisor stops nearby work if safe and directs people to the safe route. The coordinator activates the site response and arranges external assistance if needed. Only trained persons may isolate power or use suitable firefighting equipment when conditions permit; no one approaches smoke or exposed electrical danger without authorization and safe conditions. At the assembly point, the supervisor reports headcount and any missing person.',
      'Field lesson: A fire extinguisher being present does not automatically make it safe to fight a fire. Escape route, fire size, smoke, electrical status, training, and the site plan determine whether an attempt is appropriate. Evacuation and alarm raising take priority.',
    ],
    stopWorkConditions: <String>[
      'A required emergency warning, escape route, rescue arrangement, or critical emergency resource is unavailable for the current high-risk activity and no verified safe alternative has been approved.',
      'Workers, visitors, or isolated teams cannot reliably receive an alarm or instruction.',
      'The site layout or activity has changed so that the ERP map, access route, assembly point, or responder interface is no longer reliable.',
      'A proposed rescue or intervention would expose untrained people to uncontrolled fire, smoke, electricity, hazardous atmosphere, unstable structure, chemicals, or moving plant.',
    ],
    interviewQuestions: <String>[
      'Q: What is Emergency Management? A: A planned system covering prevention, preparedness, response, and recovery to protect people first and control wider consequences.',
      'Q: What should a site ERP contain? A: Credible scenarios, alarm and communication methods, roles, evacuation/shelter arrangements, assembly points, accountability, contacts, access details, equipment, training/drills, and recovery/reporting steps.',
      'Q: How do you select emergency scenarios? A: Use site risk assessment, activities, materials, layout, workforce, interfaces, past events, and credible worst-case consequences; review when conditions change.',
      'Q: What is the HSE Officer’s role? A: Support risk-based planning, verify implementation, brief and coach personnel, inspect readiness, observe drills, report gaps, and track corrective actions; command roles follow the site ERP.',
      'Q: Can any worker enter a confined space to rescue a colleague? A: No. Raise the alarm and use the approved rescue plan and competent, equipped rescuers. Unplanned entry can create multiple casualties.',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-02',
    title: 'Emergency Response Procedure',
    purpose:
        'A response procedure gives workers a simple sequence to raise the alarm, communicate essential facts, protect themselves and others, request assistance, and support a controlled handover. It reduces confusion and prevents well-intended actions from creating additional casualties.',
    scope:
        'Use when an emergency has occurred or there is a credible imminent threat. Follow the project ERP, site alarm instructions, emergency coordinator directions, and instructions from public emergency services.',
    keyKnowledge: <String>[
      'Recognize and report; do not delay the alarm while investigating, taking photographs, collecting belongings, or seeking permission where immediate danger is apparent.',
      'Give precise location information: site/project name, area or building, level/plot/grid or nearest identifiable landmark, access gate, and safest approach if known.',
      'Describe the event factually: fire, injury, collapse, release, electrical event, trapped person, or other observed condition. Separate what is known from what is suspected.',
      'Report the number of injured, trapped, or missing people if known. If unknown, say so rather than guessing. Give known injury or exposure information without making an unsupported diagnosis.',
      'Communicate hazards that may affect responders: electricity, gas, chemicals, confined space, work at height, unstable structures, traffic, stored energy, or ongoing plant movement.',
      'Give the caller’s name and contact number and remain available for questions, unless staying would be unsafe. Keep the communication line clear for updates.',
      'Stop work and isolate equipment or energy only if it can be done safely and by an authorized person. Do not approach an uncontrolled source to operate an isolator.',
      'Evacuate, shelter, or isolate the area according to the hazard and site instructions. The correct action depends on whether the danger is fire, gas, chemical release, weather, or another event.',
      'First aid and rescue must stay within the responder’s training, competence, equipment, and safe access conditions. Do not enter hazardous atmospheres or unstable areas without an approved plan and capability.',
      'A handover to emergency services should state what happened, current hazards, actions taken, people accounted for or missing, and any site-specific access or isolation information.',
    ],
    siteImplementation: <String>[
      'Raise the alarm using the designated call point, radio channel, telephone number, or other approved site method.',
      'Notify the emergency coordinator/control point and the responsible supervisor as soon as practicable without delaying the alarm.',
      'When calling emergency services, communicate: site name and exact location; type of emergency; number of injured or missing persons if known; nature of hazards; access gate and meeting point; caller name and contact number.',
      'Speak clearly and slowly. Repeat critical location details and confirm that the receiver has understood. Do not end the call until instructed, unless remaining is unsafe.',
      'Arrange a trained person to meet responders at the agreed gate, if safe. Keep the gate and route clear; do not send an unbriefed person into the hazard area.',
      'Warn affected personnel, stop nearby work where safe, and prevent unauthorized entry. Use barriers or a spotter only if these can be established without exposure.',
      'At the assembly point, supervisors account for their teams and promptly report missing, injured, or unaccounted persons with last known location and relevant hazards.',
      'Record important times, alarm activation, calls, instructions, actions, and handover information after immediate life-safety actions are underway.',
      'After the event, follow site reporting and investigation processes. Do not disturb the scene except to protect life, prevent further harm, or as directed by the responsible authority.',
    ],
    practicalExample: <String>[
      'Scenario: A worker collapses near a chemical storage area. A colleague does not rush into the area. They raise the alarm and tell the coordinator the site name, exact location, one collapsed person, suspected chemical exposure if observed, nearby hazards, access gate, their name, and callback number. People are kept clear. A trained responder approaches only when safe conditions and the response plan permit. A colleague guides emergency services from the gate and the team accounts for everyone.',
      'Sample call structure: “This is [name] at [site]. We have a [type of emergency] at [exact area]. [Number] people are injured or missing / number not yet confirmed. The known hazards are [hazards]. Use gate [name] and meet at [point]. Call me back on [number].” Replace brackets with verified facts; do not invent information.',
    ],
    stopWorkConditions: <String>[
      'The emergency location or hazard cannot be communicated clearly enough for safe response.',
      'Access is unsafe or responders may be directed into an uncontrolled hazard without warning.',
      'Personnel are being asked to conduct rescue, firefighting, isolation, or medical treatment beyond their competence or protective capability.',
      'The incident remains uncontrolled and continuing work could expose additional people.',
    ],
    interviewQuestions: <String>[
      'Q: What six core details should be provided to emergency services? A: Site and exact location, emergency type, injured/missing count if known, hazards, access gate/meeting point, caller name and contact number.',
      'Q: Why must you report hazards as well as the injury? A: Responders need to select a safe approach, equipment, isolation, and rescue method; hidden hazards can create further casualties.',
      'Q: What if the number of injured people is not known? A: State that it is not confirmed, provide the best observed information, and update when verified.',
      'Q: Should a worker enter a dangerous area to rescue someone? A: Not without an approved rescue plan, competent team, suitable equipment, and safe controls. Raise the alarm and prevent additional casualties.',
      'Q: What should be included in a handover? A: Event and location, known hazards, people involved/accounted for, actions taken, isolation status if verified, and any remaining danger.',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-03',
    title: 'Emergency Alarm & Communication',
    purpose:
        'Emergency alarms and communication systems warn people that a dangerous event or instruction exists and tell them what action to take. The system must be understandable, sufficiently reliable for the work area, and supported by a backup method for foreseeable failures.',
    scope:
        'Covers alarm signals, manual activation, audible and visual warning, radio/telephone messages, direct warning, notification of emergency roles, communication failure, and restoration of warning capability.',
    keyKnowledge: <String>[
      'Workers must know what each alarm means and what action follows: evacuate, shelter, stop work, or follow another site-specific instruction. Avoid ambiguous signals or conflicting messages.',
      'Select warning methods for actual conditions. A siren may be masked by machinery; a radio may fail in a dead zone; a visual beacon may not be noticed by a person facing away. Layered methods may be needed.',
      'Consider noise, distance, language, literacy, hearing or visual needs, enclosed areas, elevated work, remote teams, night shift, and temporary changes to the site layout.',
      'The emergency coordinator should receive prompt notification so the response can be coordinated and external services contacted when needed.',
      'Messages should be brief and structured: who is calling, exact location, what happened, immediate hazard, action required, and whether assistance is needed.',
      'Use read-back or confirmation for critical instructions: the receiver repeats the location or action so misunderstandings can be corrected.',
      'If the primary alarm or communication system fails, use the approved backup warning method and stop affected work if safe warning cannot be assured.',
      'A failed alarm, radio, public-address system, or warning device is a safety-critical defect when it affects emergency warning. Report, record, control, repair, and verify it before resuming affected operations where required.',
      'Do not broadcast unverified causes, casualty details, or rumors. Communicate facts and issue updates through the designated coordinator.',
    ],
    siteImplementation: <String>[
      'During induction, demonstrate the alarm signal, how to activate it, where to report, and what to do after hearing it.',
      'At shift start or before isolated/high-risk work, confirm the approved communication method, channel/contact, backup method, and who receives the emergency call.',
      'Notify the emergency coordinator immediately when an emergency or credible threat is identified.',
      'Activate the designated alarm and arrange direct warning of affected personnel where needed, without exposing the person giving the warning.',
      'Suspend affected work if safe warning cannot be assured. Do not rely on an untested phone, radio, or verbal message as proof that everyone has been warned.',
      'Use plain language and agreed terms. Avoid codes unless all relevant personnel are trained and the code is unambiguous.',
      'Confirm receipt of critical instructions, especially location, evacuation direction, access gate, and hazards. Correct any misunderstanding promptly.',
      'Record communication failure, affected area, time, temporary controls, responsible person, repair action, and functional verification.',
      'Restore and verify the alarm/communication system before resuming operations where required. If an approved temporary arrangement is used, communicate it to all affected personnel and document authorization.',
    ],
    practicalExample: <String>[
      'Scenario: A work-front radio repeater fails during hot work in a remote area. The supervisor cannot confirm that the emergency coordinator would receive a distress call. The supervisor stops the affected hot work, establishes and tests the approved backup communication/warning method, informs the coordinator, records the failure, and waits for repair or authorized safe arrangements before restart.',
      'Field check: Ask a worker at the farthest or noisiest work point to demonstrate how they would raise an alarm and identify the signal meaning. A control-room test alone may not prove that the warning reaches the people at risk.',
    ],
    stopWorkConditions: <String>[
      'Affected personnel cannot reliably receive an emergency warning or evacuation instruction.',
      'A critical alarm or communication system is impaired and no verified, approved alternative is available.',
      'Workers do not understand the alarm meaning or the instruction is conflicting or unclear.',
      'The communication method exposes the caller or messenger to the emergency hazard.',
    ],
    interviewQuestions: <String>[
      'Q: What do you do if the alarm fails? A: Notify the coordinator, activate the approved backup/direct warning, stop affected work if safe warning cannot be assured, record the defect, and verify restoration before restart where required.',
      'Q: Why is alarm audibility testing at the actual work front important? A: Noise, distance, barriers, and equipment can prevent a central test from representing what workers actually hear or see.',
      'Q: How do you confirm a radio message was understood? A: Request a read-back of critical details such as location, action, and access point; correct errors immediately.',
      'Q: What information should an emergency message contain? A: Caller identity, exact location, event, immediate hazard, action required, and assistance needed.',
      'Q: Can workers continue if the warning system is defective? A: Only if the affected work has a verified and authorized safe alternative that reliably warns everyone at risk; otherwise stop affected work.',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-04',
    title: 'Emergency Evacuation',
    purpose:
        'Evacuation is the controlled movement of people away from danger to a designated safe location. A successful evacuation includes warning, safe route selection, orderly movement, assistance for people who need support, personnel accountability, reporting missing persons, and controlled re-entry.',
    scope:
        'Applies to offices, workshops, camps, construction work fronts, temporary structures, plant areas, and other locations covered by the site ERP. Depending on the scenario, the correct protective action may be evacuation or sheltering in a designated safe area.',
    keyKnowledge: <String>[
      'People must know the alarm signal, primary and alternative escape routes, assembly point, warden/supervisor instructions, and accountability method before an emergency occurs.',
      'Escape routes should lead away from the hazard and remain identifiable and usable as the site changes. Temporary works, materials, vehicles, cables, and deliveries must not obstruct them.',
      'The nearest exit is not automatically the safest exit. Smoke, fire, chemical vapor, gas release, flooding, electrical danger, traffic, or structural instability may make a route unsafe.',
      'Do not use lifts or enter smoke-filled, flooded, unstable, electrically hazardous, or otherwise unsafe routes unless the approved site plan specifically provides a suitable arrangement.',
      'Assist visitors and people who may need help using assigned arrangements. Do not create a second casualty by attempting an unsafe carry or rescue.',
      'At the assembly point, supervisors or designated persons account for employees, contractors, and visitors using reliable current lists or check-in arrangements.',
      'Report missing or unaccounted persons immediately, with name/description, last known location, task, and known hazards. Do not send coworkers back into the danger area to search.',
      'Remain at the assembly point or designated safe location until the authorized coordinator gives further instruction. Do not re-enter based on rumor or apparent quiet.',
      'After evacuation, identify route problems, alarm coverage issues, confusion, delayed headcount, or support needs and update the plan.',
    ],
    siteImplementation: <String>[
      'When the alarm sounds or an authorized instruction is given, stop work safely and begin the designated protective action without delay.',
      'Leave tools and personal belongings. Do not return to collect phones, bags, documents, or equipment.',
      'Use the safest available designated route. Walk briskly; do not run, push, block exits, or separate from the group without informing the responsible person.',
      'Follow wardens or emergency coordinators and keep emergency access routes clear for responders.',
      'Assist visitors and people requiring support according to the site arrangement. If a route is unsafe, report the person’s location and follow the ERP rather than improvising a dangerous rescue.',
      'Proceed to the assigned assembly point or shelter location. Do not gather at vehicle parks, gates, or other places that obstruct emergency access.',
      'Report to the supervisor/warden for roll call. Give accurate information about who is present, injured, missing, or last seen elsewhere.',
      'If a person is missing, provide their identity, last known location, work activity, and any hazards. Do not re-enter or organize an untrained search.',
      'Wait for an all-clear or further instruction from the authorized site emergency lead or relevant authority before re-entry.',
      'After the event or drill, report blocked routes, unclear signs, alarm audibility problems, unsafe crowding, delayed assistance, and headcount discrepancies.',
    ],
    practicalExample: <String>[
      'Scenario: A fire alarm sounds in a site office while contractors and a visitor are inside. Everyone leaves by the nearest safe marked exit, without collecting belongings, and reports to the assigned assembly point. The supervisor checks the current team list and visitor sign-in record. One visitor is not accounted for, so the supervisor tells the coordinator the visitor’s name and last known location. No one re-enters to search. The group waits for authorized instructions.',
      'Field lesson: “Evacuated” does not mean “accounted for.” A person may have left by another route, gone to first aid, or remained in a hazardous area. Report the discrepancy promptly and let the designated emergency team coordinate the response.',
    ],
    stopWorkConditions: <String>[
      'An escape route is blocked, unsafe, or not communicated and no safe alternative is confirmed.',
      'Alarm/warning arrangements do not reach affected people or the evacuation instruction is not understood.',
      'An assembly point is exposed to the emergency or obstructs emergency-service access; move only under authorized direction to a safe alternative.',
      'Personnel are instructed to re-enter or search a danger area without authorization, competent rescue capability, and suitable controls.',
    ],
    interviewQuestions: <String>[
      'Q: What are the main steps in evacuation? A: Recognize alarm/instruction, stop work safely, use a safe route, reach the designated assembly/shelter point, report for headcount, report missing persons, and await authorization.',
      'Q: What if someone is missing at the assembly point? A: Tell the coordinator immediately with identity, last known location/activity, and hazards. Do not re-enter or send untrained coworkers to search.',
      'Q: Who can authorize re-entry? A: The authorized site emergency lead or relevant authority under the ERP, after the danger is assessed and controlled; not an individual worker acting alone.',
      'Q: How do you include visitors and people needing assistance? A: Use sign-in/accountability systems and pre-assigned support arrangements; keep assistance within safe capability and report anyone not accounted for.',
      'Q: Is evacuation always the correct action? A: Not always. Some scenarios require sheltering or moving to a designated safe area. Follow the site ERP and competent instructions for the specific hazard.',
    ],
  ),
];
