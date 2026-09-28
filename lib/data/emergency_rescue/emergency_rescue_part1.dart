// SafeNexus HSE — Emergency & Rescue | Part 1
// File: lib/data/emergency_rescue/emergency_rescue_part1.dart
//
// Standalone content data. Integrate into the app's existing reference-page
// model/router after checking its current API. No existing project files are
// replaced by this file.
//
// Regulatory note:
// This draft intentionally does not invent UAE legal clause numbers,
// numerical limits, or drill frequencies. Confirm current applicable UAE,
// Abu Dhabi and Dubai instruments before marking a statement as a legal duty.
// General practice notes are identified as operational guidance.

class EmergencyRescueSection {
  final String heading;
  final List<String> points;

  const EmergencyRescueSection(this.heading, this.points);
}

class EmergencyRescueTopic {
  final String code;
  final String title;
  final String icon;
  final String summary;
  final List<EmergencyRescueSection> sections;

  const EmergencyRescueTopic({
    required this.code,
    required this.title,
    required this.icon,
    required this.summary,
    required this.sections,
  });
}

const List<EmergencyRescueTopic> emergencyRescuePart1 = [
  EmergencyRescueTopic(
    code: 'ER-01',
    title: 'Emergency Management',
    icon: 'emergency',
    summary:
        'A coordinated system for preventing emergencies, preparing people and resources, responding safely, and recovering after an event.',
    sections: [
      EmergencyRescueSection('Purpose and objectives', [
        'Protect life and prevent injury.',
        'Prevent escalation and reduce damage to property and the environment.',
        'Coordinate site personnel, contractors, visitors and external emergency responders.',
        'Restore operations only after the area and equipment have been assessed and authorized as safe.',
      ]),
      EmergencyRescueSection('Scope and emergency scenarios', [
        'Fire, smoke, explosion and uncontrolled energy release.',
        'Medical emergencies, serious injury and sudden illness.',
        'Gas release, chemical spill and environmental incident.',
        'Structural instability, collapse, flooding and severe weather.',
        'Electrical shock, heat illness, confined-space emergency and work-at-height rescue.',
        'Marine emergencies where applicable, including man-overboard.',
      ]),
      EmergencyRescueSection('Management cycle', [
        'Prevention: identify credible scenarios through risk assessment and eliminate or reduce hazards.',
        'Preparedness: establish the emergency plan, trained roles, communications, equipment and access arrangements.',
        'Response: raise the alarm, protect people, coordinate response and account for personnel.',
        'Recovery: control re-entry, investigate, correct deficiencies and authorize safe restart.',
      ]),
      EmergencyRescueSection('Roles and responsibilities', [
        'Employer / management: establish and resource emergency arrangements and assign competent persons.',
        'Emergency coordinator / incident controller: coordinate the response under the site plan and communicate with external responders.',
        'HSE personnel: support risk assessment, readiness checks, drills, reporting and corrective actions within their assigned role.',
        'Supervisors: stop affected work when safe, direct personnel to follow the plan and report headcount discrepancies.',
        'Workers and visitors: raise the alarm, follow instructions and do not undertake untrained or unauthorized rescue.',
      ]),
      EmergencyRescueSection('Site implementation', [
        'Identify site-specific credible emergencies and affected work areas.',
        'Prepare a site emergency response plan with site map, access gates, alarm methods, escape routes, assembly points and emergency contacts.',
        'Assign primary and alternate emergency roles and define handover to public emergency services.',
        'Check that emergency equipment is suitable, accessible, maintained and used only by competent persons.',
        'Provide induction and task-specific instruction; conduct drills according to applicable requirements and the approved plan.',
        'Review arrangements after drills, incidents, significant site changes or identified failures.',
      ]),
      EmergencyRescueSection('Documents and records', [
        'Approved emergency response plan and current site layout.',
        'Emergency contact list and role/appointment records.',
        'Training, competency, equipment inspection and maintenance records.',
        'Drill scenarios, attendance, observations and corrective-action closeout.',
        'Incident reports and authorization for return to work, where applicable.',
      ]),
      EmergencyRescueSection('Stop-work / escalation triggers', [
        'Alarm or emergency communication is unavailable or cannot reliably reach affected people.',
        'Escape route or emergency access is blocked.',
        'Required rescue capability, trained personnel or critical equipment is unavailable.',
        'An uncontrolled hazard makes continued work unsafe.',
        'Resume only after the responsible authority confirms controls and readiness.',
      ]),
      EmergencyRescueSection('Practical example', [
        'A fire is reported near a temporary storage area. Raise the alarm, stop affected work, evacuate by the designated route, keep access clear for responders, complete headcount and report missing persons. Do not re-enter until authorized.',
      ]),
      EmergencyRescueSection('Interview questions', [
        'Q: What are the four broad phases of emergency management?',
        'A: Prevention, preparedness, response and recovery.',
        'Q: What is the HSE Officer’s role?',
        'A: Support hazard identification, emergency readiness, training/drills, inspections, reporting and corrective actions; follow the site command structure during an event.',
      ]),
      EmergencyRescueSection('Regulatory verification', [
        'Check the current UAE federal legislation and applicable emirate, sector, authority and project requirements.',
        'For Abu Dhabi, verify the current ADPHC OSH framework, applicable Codes of Practice and entity/project requirements.',
        'For Dubai, verify applicable Dubai legislation, Dubai Municipality requirements and Civil Defence / Fire and Life Safety requirements as relevant.',
        'Do not treat this draft’s operational guidance as a legal clause or substitute for the current official instrument.',
      ]),
    ],
  ),
  EmergencyRescueTopic(
    code: 'ER-02',
    title: 'Emergency Response Procedure',
    icon: 'emergency_share',
    summary:
        'A planned sequence of actions to protect people, control access, summon assistance and coordinate response when an emergency occurs.',
    sections: [
      EmergencyRescueSection('Immediate response sequence', [
        'Recognize the emergency and identify the location and apparent type without exposing yourself to danger.',
        'Raise the alarm using the designated site method and give clear, factual information.',
        'Stop affected work and isolate energy only when trained, authorized and safe; do not delay escape.',
        'Warn nearby people and evacuate or shelter as directed by the site emergency plan.',
        'Call the designated emergency number or site emergency control point and provide location, incident type, casualties and access information.',
        'Keep unauthorized persons away and preserve emergency vehicle access.',
        'Provide first aid or rescue only within training, authorization, equipment and the approved plan.',
        'Conduct headcount at the assembly point and promptly report missing persons and last known locations.',
        'Hand over relevant hazard information to arriving responders.',
        'Record and report the event; do not restart until authorized after safety checks.',
      ]),
      EmergencyRescueSection('Communication message template', [
        'State: “Emergency” and identify yourself.',
        'Give site name, exact location, nearest gate or access point.',
        'Describe what happened and known hazards (for example, fire, electricity, gas or chemical).',
        'Give known number of injured, trapped or missing people; do not guess.',
        'State assistance required and a callback contact.',
        'Keep the line available and follow the emergency coordinator’s instructions.',
      ]),
      EmergencyRescueSection('Critical precautions', [
        'Never enter a confined space or hazardous atmosphere for an improvised rescue.',
        'Do not touch a person who may still be in contact with live electricity until the source is safely isolated by competent personnel.',
        'Do not fight a fire unless trained, authorized, equipped and the fire is within the site’s safe incipient-fire response conditions; maintain an escape route.',
        'Avoid unnecessary movement of an injured person unless there is immediate danger or movement is needed for lifesaving care by a trained responder.',
        'Do not spread unverified information or use personal devices in ways that obstruct response.',
      ]),
      EmergencyRescueSection('Site implementation checklist', [
        'Emergency plan and call tree are accessible.',
        'Workers know how to raise the alarm and where to assemble.',
        'Emergency roles and deputies are assigned.',
        'Rescue arrangements match the actual task and hazards.',
        'External responders can locate the site and access point.',
        'Drill findings are recorded and corrective actions tracked.',
      ]),
      EmergencyRescueSection('Scenario and interview', [
        'Scenario: A worker collapses in a tank. Raise the alarm, prevent entry, activate the planned confined-space rescue team, request medical support and provide responders with permit, gas-test and access information. No unplanned entry rescue.',
        'Q: What is the first priority? A: Protect life, raise the alarm and avoid creating additional casualties.',
        'Q: Can anyone perform rescue? A: No. Rescue must be within competence, authorization, equipment and the approved plan.',
      ]),
      EmergencyRescueSection('Regulatory verification', [
        'Verify the current applicable UAE/emirate requirements and project emergency plan before assigning legal duties or numeric response targets.',
        'The sequence above is general operational guidance, not a claim that every step is a verbatim statutory clause.',
      ]),
    ],
  ),
  EmergencyRescueTopic(
    code: 'ER-03',
    title: 'Emergency Alarm & Communication',
    icon: 'campaign',
    summary:
        'Reliable warning and communication arrangements that alert affected people and coordinate emergency actions.',
    sections: [
      EmergencyRescueSection('Purpose and methods', [
        'Use suitable audible alarms, visual beacons, manual call points, public-address announcements, radios, telephones or approved notification systems.',
        'Select methods based on site noise, visibility, layout, workforce language needs and foreseeable power or network failure.',
        'Define alarm signals and their meaning in the site emergency plan and induction.',
      ]),
      EmergencyRescueSection('System readiness', [
        'Identify who may activate the alarm and how.',
        'Ensure alarm coverage reaches affected work areas, including noisy or remote locations.',
        'Provide backup communication arrangements for foreseeable system failures.',
        'Keep emergency contact lists current and displayed where appropriate.',
        'Inspect, test and maintain systems at the intervals required by applicable rules, manufacturer instructions and the approved maintenance plan.',
        'Record defects, isolate affected work when warning cannot be assured, and restore service before safe restart as applicable.',
      ]),
      EmergencyRescueSection('Radio discipline', [
        'Use concise, calm, factual messages.',
        'Identify yourself, location, emergency type and assistance required.',
        'Avoid unnecessary radio traffic; keep the emergency channel available.',
        'Repeat critical information to confirm it was received.',
        'Use the site’s agreed plain-language terms and avoid ambiguous codes unless everyone is trained in them.',
      ]),
      EmergencyRescueSection('Sample announcement', [
        '“Emergency, Emergency. Fire reported at the temporary storage area. Personnel in the affected zone: evacuate by the designated route to your assigned assembly point. Emergency team: respond under the site emergency plan. Keep access routes clear.”',
        'This is an illustrative message. The site must define its actual alarm signals and wording.',
      ]),
      EmergencyRescueSection('Field checklist', [
        'Alarm activation points are visible and accessible.',
        'Audible/visual warning can be perceived in relevant work areas.',
        'Backup communication method is known.',
        'Workers understand alarm meanings and required actions.',
        'Emergency contacts and radio channels are current.',
        'Faults and test results are recorded and corrected.',
      ]),
      EmergencyRescueSection('Interview questions', [
        'Q: Why is backup communication needed? A: To maintain warning and coordination if the primary system fails.',
        'Q: What should an emergency message include? A: Location, event type, known hazards, known casualties, assistance needed and caller identity/contact.',
      ]),
      EmergencyRescueSection('Regulatory verification', [
        'Confirm applicable fire alarm, life-safety, telecommunications and OSH requirements with the relevant UAE authority and approved project design.',
        'No universal alarm sound pattern or test frequency is asserted in this draft.',
      ]),
    ],
  ),
  EmergencyRescueTopic(
    code: 'ER-04',
    title: 'Emergency Evacuation',
    icon: 'directions_run',
    summary:
        'The organized movement of people from a threatened area to a designated safe location, followed by accountability and controlled re-entry.',
    sections: [
      EmergencyRescueSection('Evacuation arrangements', [
        'The site plan should identify evacuation triggers, routes, exits, assembly points, responsible marshals and arrangements for visitors and people needing assistance.',
        'Depending on the hazard and building/site design, the plan may require full, partial, phased, horizontal or vertical evacuation, or shelter-in-place.',
        'Routes and assembly locations must be suitable for the site-specific hazards and kept clear.',
      ]),
      EmergencyRescueSection('Evacuation procedure', [
        'On alarm, stop work and leave by the designated safe route.',
        'Do not collect personal belongings or delay escape.',
        'Use stairs rather than lifts during fire evacuation unless an approved emergency arrangement specifically provides otherwise.',
        'Assist others only when safe and within assigned training and responsibilities.',
        'Proceed to the assigned assembly point and report to the designated marshal/supervisor.',
        'Complete headcount for employees, contractors, visitors and other persons under site control.',
        'Report missing persons and last known location to the incident controller; do not re-enter to search.',
        'Remain at the assembly point until instructed otherwise.',
        'Re-entry is permitted only after authorization by the responsible incident authority.',
      ]),
      EmergencyRescueSection('Assembly point selection', [
        'Locate away from credible site hazards and not in emergency vehicle access routes.',
        'Make the location identifiable and reachable from designated escape routes.',
        'Provide sufficient space for accountability and communication.',
        'Review location if site layout, work phases or hazard profile changes.',
      ]),
      EmergencyRescueSection('Headcount and missing persons', [
        'Use current worker/visitor attendance or muster records.',
        'Account for contractors, drivers and visitors as defined in site arrangements.',
        'Report discrepancies immediately with names, last known work location and relevant hazards.',
        'Only the authorized rescue team should conduct searches under the emergency command and rescue plan.',
      ]),
      EmergencyRescueSection('Field checklist', [
        'Exit routes and doors are unobstructed.',
        'Exit signs and emergency lighting are functional where required.',
        'Assembly point signs are visible.',
        'Muster lists or reliable accountability method are available.',
        'Personnel understand evacuation and assistance arrangements.',
        'Drill observations and corrective actions are documented.',
      ]),
      EmergencyRescueSection('Scenario and interview', [
        'Scenario: Smoke is reported in a workshop. Raise alarm, evacuate using a safe route, do not use a smoke-affected path, assemble and report missing persons. Do not re-enter until authorized.',
        'Q: What if a worker is missing? A: Inform the incident controller immediately with last known location; do not send untrained people back inside.',
        'Q: When can workers return? A: Only after the responsible authority confirms the area is safe and authorizes re-entry.',
      ]),
      EmergencyRescueSection('Regulatory verification', [
        'Verify current UAE Fire and Life Safety Code, applicable Civil Defence requirements, emirate OSH requirements and approved building/site emergency plan.',
        'Exact exit dimensions, travel distances, occupant loads, drill intervals and other numerical criteria must come from the applicable approved code/design, not this generic draft.',
      ]),
    ],
  ),
];
