// SafeNexus HSE — Emergency & Rescue Part 1
// File: lib/data/emergency_rescue/emergency_rescue_part1.dart
//
// Handbook foundation for Topics 01–04.
// Regulatory note: This is general operational guidance, not a substitute for
// current UAE/Abu Dhabi/Dubai legislation, site ERP, client rules, or emergency
// service instructions. Do not treat unspecified numbers/frequencies as legal limits.

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
        'Establish an organized system to prepare for, respond to, and recover from emergencies while protecting people, the environment, assets, and continuity of operations.',
    scope:
        'Applies to employees, contractors, visitors, work locations, site facilities, and activities covered by the project or organization emergency arrangements.',
    keyKnowledge: <String>[
      'Emergency management includes prevention and preparedness, response, and recovery.',
      'The site Emergency Response Plan (ERP) should reflect credible site-specific scenarios, access constraints, nearby exposures, and interfaces with external responders.',
      'Typical scenarios may include fire, medical emergency, structural collapse, confined-space incident, work-at-height rescue, lifting incident, electrical event, chemical release, gas leak, severe weather, heat illness, traffic incident, and man-overboard where relevant.',
      'Define an incident command or coordination structure, deputies, communication routes, evacuation arrangements, assembly areas, and external emergency-service interfaces.',
      'Maintain suitable emergency equipment and ensure assigned responders are trained, competent, available, and familiar with their duties.',
      'The ERP should be controlled, communicated, accessible, reviewed after relevant changes or incidents, and aligned with applicable authority, client, and site requirements.',
      'Do not initiate a rescue that exposes untrained personnel to an uncontrolled hazard. Raise the alarm, isolate hazards where safe, and use competent rescue resources.',
    ],
    siteImplementation: <String>[
      'Identify credible emergency scenarios through risk assessment and site consultation.',
      'Prepare a site-specific ERP, emergency contact list, site map, access-gate details, assembly points, and role allocation.',
      'Brief workers and visitors on alarm meaning, escape routes, assembly points, reporting method, and personnel accountability.',
      'Check that alarms, emergency lighting, exit routes, communication devices, first-aid resources, firefighting equipment, and rescue equipment are suitable for the identified scenarios.',
      'Coordinate with client representatives, security, facilities, subcontractors, and external responders as applicable.',
      'Conduct drills and competency checks at intervals established by applicable requirements and the site risk-based plan; record findings and close corrective actions.',
      'After an event, account for people, preserve relevant evidence where safe, report through required channels, investigate, support recovery, and update controls.',
    ],
    practicalExample: <String>[
      'A worker reports smoke from a temporary electrical distribution board. The person raises the alarm and informs the supervisor. Work in the affected area is stopped if safe, people move by the designated route, and the emergency coordinator activates the site response. Only trained personnel use appropriate equipment if conditions permit; otherwise they withdraw and await responders.',
    ],
    stopWorkConditions: <String>[
      'The emergency plan, alarm, escape route, or required rescue capability is unavailable or not suitable for the active high-risk work.',
      'People cannot be warned or evacuated reliably.',
      'An attempted intervention would expose personnel to uncontrolled fire, electrical, atmospheric, structural, chemical, or other serious danger.',
    ],
    interviewQuestions: <String>[
      'What are the main stages of emergency management?',
      'How do you identify credible emergency scenarios for a construction site?',
      'What should an Emergency Response Plan contain?',
      'How do you verify that emergency arrangements are effective?',
      'What is the priority when a rescue attempt may endanger the rescuer?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-02',
    title: 'Emergency Response Procedure',
    purpose:
        'Provide a clear, coordinated sequence for raising an alarm, protecting people, requesting assistance, controlling the scene, and handing over to competent responders.',
    scope:
        'Use for actual emergencies and credible imminent threats, following the site ERP and emergency-service instructions.',
    keyKnowledge: <String>[
      'Recognize the emergency, raise the alarm promptly, and communicate the location and immediate danger.',
      'Protect life first. Do not delay alarm-raising to investigate or collect belongings.',
      'Stop work and isolate energy or process sources only when this can be done safely and by authorized persons.',
      'Evacuate or shelter as directed by the site plan and the nature of the hazard.',
      'Do not enter a hazardous atmosphere, confined space, unstable structure, or energized area to perform an unplanned rescue.',
      'Provide first aid only within training, competence, and safe conditions; arrange professional medical response when required.',
      'Maintain access for responders, keep routes clear, and provide a clear handover of known facts and hazards.',
    ],
    siteImplementation: <String>[
      'Raise the site alarm using the designated call point, radio channel, telephone number, or other approved method.',
      'Notify the emergency coordinator or control point and the relevant supervisor.',
      'State the site name and exact location, type of emergency, number of injured or missing persons if known, nature of hazards, access gate and meeting point, caller name, and contact number.',
      'Give concise updates if the situation changes; do not speculate about unknown facts.',
      'Direct a trained person to meet emergency services at the agreed access point when safe.',
      'Prevent unauthorized entry, preserve clear access, and account for personnel at the assembly point.',
      'Record key times, notifications, actions, and handover details when doing so does not interfere with life-safety actions.',
    ],
    practicalExample: <String>[
      'A worker collapses near a process area. A colleague raises the alarm, reports the exact location and suspected exposure, and requests medical assistance. Personnel keep clear of the potential source. A trained responder approaches only after the area is confirmed safe and provides care within competence. A colleague guides responders through the correct gate.',
    ],
    stopWorkConditions: <String>[
      'The emergency cannot be communicated reliably.',
      'The scene contains an uncontrolled hazard or access route is unsafe.',
      'Personnel are being asked to perform rescue or treatment beyond their competence or available protection.',
    ],
    interviewQuestions: <String>[
      'What information should be given when calling emergency services?',
      'Why should responders be told about hazards and the correct access gate?',
      'What actions should workers avoid during an emergency?',
      'How should the emergency coordinator manage personnel accountability?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-03',
    title: 'Emergency Alarm & Communication',
    purpose:
        'Ensure that emergency warnings reach affected people quickly, clearly, and through a reliable primary and backup communication arrangement.',
    scope:
        'Covers alarm activation, warning methods, radio/telephone communication, notification, communication failure, and restoration before work resumes where required.',
    keyKnowledge: <String>[
      'Alarm signals and their required actions must be explained during induction and task briefings.',
      'Communication methods may include audible alarms, visual beacons, public-address systems, radios, phones, or direct warnings, selected for site conditions.',
      'Consider noise, distance, language, hearing or visual needs, isolated work areas, and loss of power or network.',
      'Emergency messages should be short, factual, location-specific, and free from unverified assumptions.',
      'Maintain an alternative means of warning if the primary system fails.',
      'A communication failure affecting life-safety warning must be treated as a serious control failure.',
    ],
    siteImplementation: <String>[
      'Notify the emergency coordinator when an emergency or credible threat is identified.',
      'Activate the designated alarm and arrange direct warning of affected personnel where needed.',
      'Suspend affected work if safe warning cannot be assured.',
      'Use agreed radio channels or contact numbers and repeat critical information to confirm understanding.',
      'Record alarm or communication failure, notify responsible management, and restore and verify the system before resuming operations where required.',
      'Brief workers on any temporary compensating controls and restrictions while a system is unavailable.',
    ],
    practicalExample: <String>[
      'During maintenance, the site alarm panel loses power in one work zone. The supervisor stops affected work, arranges direct warning and a verified backup communication method, informs the emergency coordinator, and ensures the fault is recorded. Work resumes only after the required warning capability is restored or formally approved safe arrangements are in place.',
    ],
    stopWorkConditions: <String>[
      'Affected workers cannot reliably receive an emergency warning.',
      'A critical alarm or communication system is impaired and no verified safe alternative is available.',
      'The meaning of an alarm or evacuation instruction is unclear to the people at risk.',
    ],
    interviewQuestions: <String>[
      'What should happen if an emergency alarm fails?',
      'How can you confirm that a radio emergency message was understood?',
      'Why must alarm signals be included in induction?',
      'When should affected work be suspended due to communication failure?',
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-04',
    title: 'Emergency Evacuation',
    purpose:
        'Move people from danger to a designated safe location in an orderly manner, while maintaining accountability and avoiding exposure to secondary hazards.',
    scope:
        'Applies to evacuation from buildings, work areas, construction zones, temporary facilities, and other locations covered by the site ERP.',
    keyKnowledge: <String>[
      'Evacuation routes and exits must be suitable for the site layout and credible emergency scenarios.',
      'Workers and visitors need to know the alarm signal, primary and alternative routes, assembly point, and accountability process.',
      'Do not use lifts or enter smoke-filled, flooded, unstable, electrically hazardous, or otherwise unsafe routes unless the site emergency plan specifically provides a safe arrangement.',
      'Assist persons needing support through assigned arrangements without creating additional danger.',
      'Do not re-enter until authorized by the responsible emergency authority or site command.',
      'Account for employees, contractors, and visitors and report missing persons immediately with last known location and relevant hazards.',
    ],
    siteImplementation: <String>[
      'On hearing the evacuation alarm or receiving an instruction, stop work safely and proceed promptly by the designated route.',
      'Leave tools and personal belongings; do not delay evacuation.',
      'Follow wardens or emergency coordinators and keep access routes clear.',
      'Proceed to the assigned assembly point and report to the responsible person for roll call.',
      'Report anyone missing, injured, trapped, or last seen in a hazardous area; do not re-enter to search.',
      'Remain at the assembly point until further instruction and await an authorized all-clear.',
      'After the event, record issues such as blocked routes, alarm audibility, delayed accountability, or assistance needs and close corrective actions.',
    ],
    practicalExample: <String>[
      'A fire alarm sounds in a site office. Workers leave by the nearest safe marked exit, avoid collecting belongings, and report to the assigned assembly point. The supervisor checks the team list and informs the coordinator that one visitor has not yet been accounted for, including the visitor’s last known location. No one re-enters to search.',
    ],
    stopWorkConditions: <String>[
      'An evacuation route is blocked, unsafe, or not communicated and no safe alternative is confirmed.',
      'Alarm or warning arrangements do not reach affected people.',
      'A person is directed to re-enter a danger area without authorization and suitable rescue capability.',
    ],
    interviewQuestions: <String>[
      'What is the difference between evacuation and personnel accountability?',
      'What should you do if a person is missing at the assembly point?',
      'When may personnel re-enter an evacuated area?',
      'How should evacuation arrangements account for visitors and people requiring assistance?',
    ],
  ),
];
