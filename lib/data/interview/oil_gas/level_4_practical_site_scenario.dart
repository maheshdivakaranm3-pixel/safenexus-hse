/// SafeNexus HSE — Oil & Gas Interview
/// Level 4: Practical Site Scenario
const List<Map<String, String>> oilGasLevel4Questions = [
  {
    'question': 'You arrive at a job and find the permit is valid, but the worksite conditions differ from the JSA. What do you do?',
    'answer': 'Pause the affected work and make the area safe. Explain the changed condition to the performing supervisor and permit authority, reassess the hazards with the work party, revise the JSA and permit or obtain revalidation as required by site procedure, brief everyone again, and restart only after controls are verified and authorised.',
    'technicalExplanation': 'A permit is conditional on its stated scope and conditions. A changed worksite, task, equipment, weather, nearby activity, or control status can invalidate the original assessment.',
    'practicalExample': 'A new hose route crosses the planned work area. Stop, reassess trip and damage hazards, reroute or protect the hose, update the briefing, and record the change.'
  },
  {
    'question': 'A worker reports a strong rotten-egg smell in a process area. What is your response?',
    'answer': 'Do not rely on smell to judge H2S exposure. Warn nearby personnel without entering a suspected release area, follow the facility alarm and evacuation procedure, move to the designated safe location using the prescribed route and wind information, notify the control room, and account for personnel. Do not attempt an untrained rescue.',
    'technicalExplanation': 'H2S can rapidly impair the sense of smell. Detection instruments, alarm response, escape equipment, and respiratory protection must follow the facility H2S plan and competency requirements.',
    'practicalExample': 'If a worker reports symptoms near a drain, initiate the site response, keep others away, report the location and observations to control room, and allow trained responders with suitable equipment to assess.'
  },
  {
    'question': 'During a lift, a worker walks under a suspended load. What action do you take?',
    'answer': 'Signal an immediate stop using the agreed communication method. Ensure the load is controlled and landed safely where practicable, clear the exclusion zone, notify the lifting supervisor, and review barricading, banksman coverage, access control, and the pre-lift briefing. Resume only after the lifting team confirms the controls.',
    'technicalExplanation': 'A suspended load creates a line-of-fire and dropped-load hazard. The lift plan and site procedure define roles, communication, exclusion zones, and stop criteria.',
    'practicalExample': 'A shortcut opens through a barrier. Stop the lift, close and secure the access, assign a person to control the entry point, and re-brief the crew.'
  },
  {
    'question': 'A gas detector alarms while a crew is performing maintenance. What do you do?',
    'answer': 'Stop work, warn the crew, and follow the facility alarm response. Evacuate or shelter as directed, avoid ignition sources where required by the emergency procedure, report to the control room or emergency team, and account for personnel. Do not resume until the area is declared safe and the permit and risk assessment are reviewed.',
    'technicalExplanation': 'The correct response depends on the detector type, alarm level, location, and facility emergency plan. Never silence or bypass an alarm to continue work.',
    'practicalExample': 'A portable monitor alarms during line breaking. The crew withdraws to the designated safe area; operations investigates and confirms atmospheric conditions before reauthorising the task.'
  },
  {
    'question': 'A contractor is about to start work but cannot explain the critical controls in the JSA. What do you do?',
    'answer': 'Do not allow the task to start. Ask the supervisor to conduct a clear, language-appropriate briefing, explain the hazards and controls, invite questions, and verify understanding by asking workers to describe their role and stop-work triggers. Record the briefing as required and confirm field controls before release.',
    'technicalExplanation': 'A signature is not proof of comprehension. Competence and communication must be verified for the actual task and workforce.',
    'practicalExample': 'For a confined-space job, each entrant should understand entry limits, attendant communication, alarm response, and how to exit immediately.'
  },
  {
    'question': 'You discover a damaged electrical cable near a wet work area. What is your response?',
    'answer': 'Keep people away and do not touch or move the cable. Arrange isolation by an authorised electrical person, barricade the area, notify the supervisor and electrical authority, and ensure inspection, repair, and testing are completed before return to service.',
    'technicalExplanation': 'Damaged insulation and moisture can create shock, arc, and fire hazards. Only competent authorised personnel should handle electrical isolation and verification.',
    'practicalExample': 'A portable tool lead has exposed conductors near washdown activity. Remove the tool from service through the approved process and provide a verified safe replacement.'
  },
  {
    'question': 'A confined-space entrant stops responding to the attendant. What should happen?',
    'answer': 'Raise the alarm immediately, stop other work, and activate the approved confined-space rescue plan. The attendant must not enter impulsively. Trained rescue personnel use the planned equipment, communications, isolation arrangements, and appropriate respiratory protection, while the control room and emergency team are notified.',
    'technicalExplanation': 'Unplanned rescuer entry can create multiple casualties. Rescue readiness, access, retrieval systems, and role competency must be established before entry begins.',
    'practicalExample': 'For a vessel entry, the standby team initiates the site rescue sequence, maintains communication, prepares retrieval equipment, and records the incident timeline.'
  },
  {
    'question': 'A supervisor asks you to ignore a missing fire watch because the hot work will take only five minutes. What do you say?',
    'answer': 'Explain that duration does not remove the ignition hazard or permit condition. Keep the work stopped until the required fire watch and other controls are in place, or the authorised permit authority formally reviews and approves a safe alternative under procedure.',
    'technicalExplanation': 'Hot-work precautions are based on hazard and approved permit conditions, not convenience or job duration. HSE should escalate pressure to bypass a critical control.',
    'practicalExample': 'Before cutting a bracket, verify gas test status, combustibles control, fire protection, fire-watch assignment, and required post-work monitoring under the facility rules.'
  },
  {
    'question': 'You notice an oil spill spreading toward a stormwater drain. What do you do?',
    'answer': 'Protect people first, raise the spill alert, stop the source only if safe and authorised, prevent migration using compatible spill materials, protect the drain, and notify the environmental and operations contacts. Collect and label waste for approved handling, document the event, and investigate the cause.',
    'technicalExplanation': 'Do not wash oil into drains or use an unapproved chemical dispersant. Spill response materials and waste classification must match the substance and site environmental plan.',
    'practicalExample': 'A small hydraulic leak is contained with absorbent socks before it reaches a drain; contaminated absorbents are placed in the designated labelled waste container.'
  },
  {
    'question': 'A worker collapses in a suspected toxic-gas area. How do you respond?',
    'answer': 'Do not enter the hazardous atmosphere without the training, authorisation, and respiratory protection required by the emergency plan. Raise the alarm, communicate the exact location and observed conditions, keep others clear, and support the trained rescue team. Arrange medical response and preserve scene information after the area is controlled.',
    'technicalExplanation': 'Secondary casualties are a known risk in toxic-atmosphere rescues. Rescue must be planned and executed by competent responders with suitable equipment and backup.',
    'practicalExample': 'From a safe location, provide the control room with the casualty’s last known position, possible exposure source, access route, and headcount.'
  },
  {
    'question': 'A scaffold tag is missing, but the crew says it was inspected yesterday. Can they use it?',
    'answer': 'Do not assume it is safe based on verbal assurance. Prevent access until a competent authorised person verifies its status, inspection, configuration, and required tagging or handover record under site procedure. Correct the documentation and communicate the release clearly.',
    'technicalExplanation': 'Scaffold status can change after inspection due to alteration, damage, weather, or unauthorised removal of components. The site tagging system must be followed.',
    'practicalExample': 'Barricade the access, request scaffold inspection, and allow use only after formal confirmation and visible status are restored.'
  },
  {
    'question': 'A vehicle reverses near pedestrians in a congested plant area. What controls do you check?',
    'answer': 'Stop or separate the conflicting movement, establish a safe pedestrian route, verify the traffic management plan, reversing alarm and camera or other aids, trained banksman where required, visibility, speed controls, and exclusion zone. Review the route and timing to prevent recurrence.',
    'technicalExplanation': 'Vehicle-pedestrian interaction is a high-energy hazard. A banksman is not a substitute for route design, segregation, and functioning equipment.',
    'practicalExample': 'During material delivery, hold pedestrian access at a controlled crossing until the vehicle is parked and the delivery area is secured.'
  },
  {
    'question': 'A worker experiences dizziness while working outdoors in hot weather. What do you do?',
    'answer': 'Stop the task, move the worker to a safe cooler area, alert the supervisor and first aider, and follow the site heat-illness response. Do not leave the worker alone. Arrange medical assessment for concerning symptoms and review hydration, work-rest arrangements, acclimatisation, shade, and workload before restarting.',
    'technicalExplanation': 'Heat illness can progress rapidly. Follow the current site heat-stress plan and applicable local requirements; do not diagnose or delay medical response.',
    'practicalExample': 'The supervisor suspends strenuous work, provides access to the designated recovery area, and checks whether other workers show symptoms.'
  },
  {
    'question': 'A permit expires while the crew is still working. What is required?',
    'answer': 'Stop the work safely and place equipment in a safe condition. Notify the performing and issuing authorities, reassess conditions, and obtain formal extension, revalidation, or a new permit according to procedure before resuming. Rebrief the work party and verify controls again.',
    'technicalExplanation': 'Permit validity is a formal boundary. Do not backdate, alter, or continue under an expired authorisation.',
    'practicalExample': 'A maintenance task overruns the shift. The crew secures the worksite, hands over hazards and isolations, and obtains the required authorisation for the next shift.'
  },
  {
    'question': 'A worker reports a near miss but asks you not to record their name. How do you handle it?',
    'answer': 'Thank the worker, explain the purpose of learning and the site reporting options, and protect confidentiality as far as the process permits. Capture factual event details and escalate any immediate risk. Follow the organisation’s reporting and privacy rules without promising absolute anonymity if it cannot be guaranteed.',
    'technicalExplanation': 'A fair reporting culture encourages early reporting while preserving accurate investigation and statutory or company reporting obligations.',
    'practicalExample': 'Record the location, task, equipment, and event sequence, then investigate the failed barrier and communicate lessons without unnecessary personal details.'
  }
];
