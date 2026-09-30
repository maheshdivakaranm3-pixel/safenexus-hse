/// SafeNexus HSE — Oil & Gas Interview consolidated source data.
/// Contains the supplied Level 1–6 source content. Verify current UAE/operator
/// requirements against official documents before field application.

/// SafeNexus HSE — Oil & Gas Interview
/// Level 1: Basic Interview
/// Suggested project path: lib/data/interview/oil_gas/level_1_basic_interview.dart
/// Content is educational interview preparation. Confirm site-specific rules,
/// permit conditions and current UAE authority requirements before field use.

class InterviewQuestion {
  final String question;
  final String answer;
  final String technicalExplanation;
  final String practicalExample;

  const InterviewQuestion({
    required this.question,
    required this.answer,
    required this.technicalExplanation,
    required this.practicalExample,
  });
}

class InterviewSection {
  final String title;
  final String introduction;
  final List<InterviewQuestion> questions;

  const InterviewSection({
    required this.title,
    required this.introduction,
    required this.questions,
  });
}

class OilGasLevel1BasicInterview {
  static const String title = 'Level 1 – Basic Interview';
  static const String category = 'Oil & Gas';

  static const List<InterviewSection> sections = [
    InterviewSection(
      title: 'HSE Fundamentals',
      introduction: 'Basic health, safety and environmental concepts for entry-level Oil & Gas interviews.',
      questions: [
        InterviewQuestion(
          question: '1. What is HSE?',
          answer: 'HSE stands for Health, Safety and Environment. It is the organized approach used to protect people from work-related injury and illness, prevent damage to assets, and avoid harm to the environment. HSE is everyone’s responsibility, from management to workers and contractors.',
          technicalExplanation: 'Health addresses occupational health and wellbeing; Safety focuses on preventing injury, incidents and loss; Environment focuses on preventing pollution, waste and environmental damage. An effective HSE system includes leadership, risk assessment, competence, operational controls, monitoring and continual improvement.',
          practicalExample: 'Before a pump maintenance job, the team reviews chemical exposure, rotating-equipment hazards, isolation requirements, spill controls and emergency arrangements during the pre-job briefing.',
        ),
        InterviewQuestion(
          question: '2. What is a hazard?',
          answer: 'A hazard is a source, situation or activity with the potential to cause injury, ill health, damage to property, interruption of operations or environmental harm.',
          technicalExplanation: 'Identify the hazard first, then assess who or what may be exposed, how harm could occur, and what controls are required. A hazard is not the same as risk: risk considers likelihood and consequence.',
          practicalExample: 'An unguarded rotating coupling is a mechanical hazard. A worker’s hand becoming caught is a possible event and serious injury is a consequence.',
        ),
        InterviewQuestion(
          question: '3. What is risk?',
          answer: 'Risk is the combination of the likelihood that a hazardous event will occur and the severity of its possible consequences, taking account of exposure and existing controls as defined by the site risk method.',
          technicalExplanation: 'Use the approved site risk matrix and consider credible worst-case outcomes, frequency of exposure, number of people exposed and control effectiveness. Risk ratings support decisions but do not replace competent judgment or mandatory controls.',
          practicalExample: 'A hydrocarbon leak near ignition sources may have a low likelihood during normal operation but a potentially severe fire or explosion consequence. The team must maintain preventive barriers and emergency readiness.',
        ),
        InterviewQuestion(
          question: '4. What is a near miss?',
          answer: 'A near miss is an unplanned event that did not result in injury, illness, damage or loss, but had the potential to do so.',
          technicalExplanation: 'Near-miss reporting helps identify weak barriers before a more serious event occurs. Reports should be factual, timely, non-punitive where appropriate, investigated proportionately and followed by corrective actions.',
          practicalExample: 'A spanner falls from a platform and lands inside a barricaded area without hitting anyone. Report it, secure tools, review dropped-object controls and check the effectiveness of toe boards and tool lanyards.',
        ),
        InterviewQuestion(
          question: '5. What is an unsafe act and an unsafe condition?',
          answer: 'An unsafe act is a behavior that can increase exposure to danger, such as bypassing an approved procedure. An unsafe condition is a hazardous workplace state, such as a damaged cable or missing guard. Both should be addressed through reporting, risk control and learning.',
          technicalExplanation: 'Avoid blaming individuals before understanding task design, supervision, training, equipment, workload and procedural factors. Stop an imminent danger, make the area safe and report through the site system.',
          practicalExample: 'A worker uses a grinder without the required face protection (unsafe act); a damaged grinder guard is an unsafe condition. Stop the task and correct both issues before restart.',
        ),
        InterviewQuestion(
          question: '6. What is the hierarchy of controls?',
          answer: 'The hierarchy of controls is a preferred order for selecting risk controls: eliminate the hazard, substitute it, use engineering controls, apply administrative controls, and use personal protective equipment (PPE).',
          technicalExplanation: 'Higher-level controls generally reduce dependence on human behavior. Use multiple layers when needed and verify that controls remain effective. PPE is important but is normally the last line of defense.',
          practicalExample: 'For work at height, first consider doing the work from ground level or using a safer design. If that is not practicable, use suitable platforms and edge protection, then safe procedures and task-appropriate PPE.',
        ),
      ],
    ),
    InterviewSection(
      title: 'Oil & Gas Workplace Safety',
      introduction: 'Common process, operational and maintenance safety questions.',
      questions: [
        InterviewQuestion(
          question: '7. What are the main hazards in Oil & Gas operations?',
          answer: 'Common hazards include flammable or toxic hydrocarbons, fire and explosion, high pressure, hazardous energy, confined spaces, working at height, lifting operations, vehicle movement, chemicals, noise, heat stress and environmental releases. The actual hazards depend on the facility and task.',
          technicalExplanation: 'Use the process safety information, task risk assessment, permit conditions, safety data sheets, area classification and emergency plan relevant to the location. Never assume a line or vessel is safe based only on appearance or an old label.',
          practicalExample: 'During flange breaking, the team considers trapped pressure, residual hydrocarbons, H2S where relevant, line contents, isolation quality, splash exposure, ignition sources and spill containment.',
        ),
        InterviewQuestion(
          question: '8. What is a Permit to Work (PTW)?',
          answer: 'A Permit to Work is a formal authorization and communication system that defines the job, location, hazards, precautions, responsible persons, validity period and conditions for carrying out specified higher-risk work.',
          technicalExplanation: 'A permit does not make a job safe by itself. The work team must understand the scope, verify controls at the job site, coordinate simultaneous operations, follow permit limits and suspend or revalidate the permit when conditions change. Follow the facility’s PTW procedure.',
          practicalExample: 'Before hot work near a process area, the authorized team confirms the approved permit, gas-test requirements, isolation status, fire watch, fire equipment, barricading and simultaneous-operation restrictions.',
        ),
        InterviewQuestion(
          question: '9. What is Lockout/Tagout (LOTO)?',
          answer: 'LOTO is a controlled process for isolating hazardous energy and preventing unexpected start-up or release of energy while equipment is being serviced or maintained.',
          technicalExplanation: 'Identify every energy source, shut down correctly, isolate using approved devices, apply personal or group locks and tags, release or restrain stored energy, and verify zero-energy state using the approved test-before-touch method. Only authorized persons may perform assigned isolation steps.',
          practicalExample: 'Before maintaining a pump, isolate electrical supply and relevant process lines, drain or depressurize as required, secure stored energy and prove the equipment cannot start before work begins.',
        ),
        InterviewQuestion(
          question: '10. What is gas testing and why is it required?',
          answer: 'Gas testing measures the atmosphere for specified hazards such as oxygen deficiency or enrichment, flammable gas or vapor, and toxic gases. It is required when the risk assessment, permit or site procedure identifies atmospheric hazards.',
          technicalExplanation: 'A trained and authorized gas tester uses a suitable, calibrated and function-checked instrument, samples representative locations and records results as required. Testing frequency and acceptance limits must come from the applicable facility procedure and permit; do not assume one limit fits every task.',
          practicalExample: 'Before entering a vessel, the team verifies isolation and ventilation, tests the atmosphere at appropriate levels and locations, records results, and arranges continuous or repeat monitoring when required by the entry plan.',
        ),
        InterviewQuestion(
          question: '11. What is H2S and what should you do if an H2S alarm activates?',
          answer: 'Hydrogen sulfide (H2S) is a highly toxic gas that may be present in some hydrocarbon operations. If an alarm activates, stop work, warn others, follow the site alarm and evacuation procedure, move by the designated route to the designated safe area or muster point, and do not attempt rescue without authorization, training and appropriate respiratory protection.',
          technicalExplanation: 'Do not rely on smell; olfactory fatigue can occur. Follow facility wind-direction indicators and emergency instructions. Only trained response personnel using the specified equipment should enter a suspected contaminated area. Report to the muster coordinator and remain accounted for.',
          practicalExample: 'On hearing the H2S alarm, a technician leaves tools, avoids moving toward the suspected release, follows the marked escape route as directed, reports to muster and informs the coordinator of any missing person or exposure.',
        ),
        InterviewQuestion(
          question: '12. What is a Safety Data Sheet (SDS)?',
          answer: 'An SDS is a standardized document that communicates information about a chemical’s hazards, safe handling, storage, exposure controls, first aid, firefighting, spill response and disposal.',
          technicalExplanation: 'Review the current SDS before using a chemical and ensure workers can access and understand the relevant information. Select compatible PPE and controls based on the SDS and task risk assessment, not on the container name alone.',
          practicalExample: 'Before using a solvent for cleaning, the supervisor checks flammability, ventilation, glove compatibility, ignition control, spill response and waste-disposal requirements.',
        ),
      ],
    ),
    InterviewSection(
      title: 'PPE, Emergency and Reporting',
      introduction: 'Personal protection, emergency readiness and reporting expectations.',
      questions: [
        InterviewQuestion(
          question: '13. What is PPE? Is PPE enough to control every hazard?',
          answer: 'Personal Protective Equipment is equipment worn or used to reduce exposure to workplace hazards, such as safety helmets, eye protection, gloves, safety footwear, hearing protection and task-specific respiratory or fall protection. PPE alone is not enough where hazards can be eliminated or controlled more effectively.',
          technicalExplanation: 'Select PPE through risk assessment, ensure correct fit and compatibility, inspect before use, maintain it and replace defective items. Respiratory protection requires appropriate selection, fit testing where applicable, training and a suitable respiratory-protection program.',
          practicalExample: 'For chemical transfer, use the glove and eye/face protection specified by the SDS and assessment, while also using closed transfer equipment, ventilation and spill containment.',
        ),
        InterviewQuestion(
          question: '14. What should you do when you discover an unsafe condition?',
          answer: 'If there is immediate danger, stop the task if safe to do so, warn people who may be exposed, isolate or barricade the area where authorized, notify the supervisor or control room, and report the condition through the site system. Work resumes only after controls are verified and authorization is obtained where required.',
          technicalExplanation: 'Do not place yourself at risk while intervening. Preserve evidence when relevant, communicate clearly and track corrective actions to closure. Use stop-work authority in accordance with company policy.',
          practicalExample: 'If a temporary electrical cable is damaged in a wet area, prevent access, do not touch it, notify the responsible electrical person and have it isolated and replaced before the area is released.',
        ),
        InterviewQuestion(
          question: '15. What is your role during an emergency?',
          answer: 'My first responsibility is to protect myself and others by following the facility emergency response plan. I raise the alarm, stop work when safe, evacuate or shelter as instructed, go to the designated muster point, report to the coordinator and do not re-enter until officially permitted.',
          technicalExplanation: 'Know the alarm signals, escape routes, muster locations, emergency contacts and role-specific duties before starting work. Only perform firefighting, first aid, rescue or spill response when trained, equipped and assigned to do so.',
          practicalExample: 'If a fire alarm sounds during maintenance, the worker makes equipment safe only if this can be done immediately without delay or added risk, evacuates by the instructed route, reports at muster and remains available for accountability.',
        ),
      ],
    ),
    InterviewSection(
      title: 'Additional Basic Interview Questions',
      introduction: 'Additional foundational Oil & Gas HSE interview questions. Display as one continuous numbered list in the app.',
      questions: [
        InterviewQuestion(
          question: '16. What is a Job Safety Analysis (JSA)?',
          answer: 'A JSA breaks a job into steps, identifies hazards at each step, and specifies controls before work starts.',
          technicalExplanation: 'The team reviews the actual worksite, sequence, people, tools, energy sources and changing conditions. A JSA must be updated when scope or conditions change.',
          practicalExample: 'Before replacing a valve, the crew lists isolation, draining, breaking containment, lifting, fitting and reinstatement steps, then assigns controls and responsibilities.',
        ),
        InterviewQuestion(
          question: '17. What is a toolbox talk?',
          answer: 'A toolbox talk is a short, focused pre-job discussion that aligns the crew on the task, hazards, controls, roles and emergency arrangements.',
          technicalExplanation: 'It should be interactive, in a language workers understand, and based on the approved risk assessment and permit. Attendance alone does not prove understanding.',
          practicalExample: 'Before scaffold work, the supervisor discusses access, falling objects, weather, inspection status, exclusion zones and rescue arrangements.',
        ),
        InterviewQuestion(
          question: '18. What is a safety observation?',
          answer: 'A safety observation is a report of a safe behavior, unsafe act, unsafe condition or improvement opportunity noticed at work.',
          technicalExplanation: 'Good observations are factual, specific, timely and followed by action. They should support learning rather than blame.',
          practicalExample: 'A worker notices an unsecured hose crossing a walkway, reports it and helps arrange safe routing and protection.',
        ),
        InterviewQuestion(
          question: '19. What is stop-work authority?',
          answer: 'Stop-work authority means a worker may pause work when they believe an unsafe condition or uncontrolled risk exists, then notify the responsible supervisor.',
          technicalExplanation: 'Follow the company procedure, communicate the concern, make the area safe if possible, and restart only after controls and authorization are confirmed.',
          practicalExample: 'A fitter sees unexpected pressure during line opening, stops the job, withdraws to safety and informs the permit issuer.',
        ),
        InterviewQuestion(
          question: '20. What is a safety induction?',
          answer: 'A safety induction introduces workers and visitors to site hazards, rules, emergency procedures, reporting and their responsibilities.',
          technicalExplanation: 'Induction content should be site-specific and appropriate to the person’s role, language and competence. Re-induction may be required after changes.',
          practicalExample: 'A new contractor learns the site alarm, muster point, restricted areas, PPE rules, vehicle routes and incident-reporting process before entry.',
        ),
        InterviewQuestion(
          question: '21. What is a risk assessment?',
          answer: 'A risk assessment identifies hazards, evaluates the risk and determines controls to reduce risk to an acceptable level under the site process.',
          technicalExplanation: 'It should consider routine and non-routine work, simultaneous operations, people exposed, control effectiveness and residual risk.',
          practicalExample: 'Before working on a pump, the team assesses electrical, mechanical, pressure, chemical, lifting and access hazards and verifies controls.',
        ),
        InterviewQuestion(
          question: '22. What is a confined space?',
          answer: 'A confined space is an enclosed or partially enclosed space with restricted entry or exit and potential hazards such as hazardous atmosphere, engulfment or difficult rescue.',
          technicalExplanation: 'Use the site definition and confined-space procedure. Entry requires authorization, isolation, atmospheric testing, communication, attendant and rescue arrangements as applicable.',
          practicalExample: 'A tank inspection is treated as confined-space entry under the facility procedure, with verified isolation, gas tests and a ready rescue plan.',
        ),
        InterviewQuestion(
          question: '23. What is a fire triangle?',
          answer: 'The fire triangle describes the three elements needed for ordinary combustion: fuel, oxygen and heat.',
          technicalExplanation: 'Fire prevention removes or controls at least one element, while actual response must follow alarm, evacuation and trained-response rules.',
          practicalExample: 'During hot work, remove combustible materials, control ignition sources and keep suitable firefighting equipment available as required by the permit.',
        ),
        InterviewQuestion(
          question: '24. What is the difference between fire prevention and fire protection?',
          answer: 'Fire prevention reduces the chance of ignition or fire starting; fire protection detects, controls or limits the consequences of a fire.',
          technicalExplanation: 'Examples include ignition control and housekeeping for prevention, and alarms, extinguishers, suppression systems and fire-rated separation for protection.',
          practicalExample: 'A gas detector and hot-work controls help prevent escalation, while alarms and designated firefighting systems support response.',
        ),
        InterviewQuestion(
          question: '25. What should you check before using a fire extinguisher?',
          answer: 'Raise the alarm first and only attempt to use an extinguisher if trained, the fire is small, the correct extinguisher is available and a safe escape route remains.',
          technicalExplanation: 'Never fight a growing fire, unknown chemical fire or situation involving risk of entrapment. Follow the facility emergency plan.',
          practicalExample: 'For a small incipient fire, a trained worker uses the correct extinguisher while keeping an exit behind them; otherwise evacuates.',
        ),
        InterviewQuestion(
          question: '26. What is H2S?',
          answer: 'Hydrogen sulfide is a highly toxic, flammable gas that may be present in some oil and gas operations.',
          technicalExplanation: 'Never rely on smell to detect it; olfactory fatigue can occur. Follow site alarm, detector, escape, breathing-apparatus and rescue procedures.',
          practicalExample: 'On an H2S alarm, stop work, use the designated escape route to the safe area or upwind/crosswind direction as instructed, muster and report. Do not attempt untrained rescue.',
        ),
        InterviewQuestion(
          question: '27. Why must gas detectors be bump-tested or calibrated?',
          answer: 'A bump test checks that a gas detector responds to gas; calibration checks and adjusts its accuracy against a known standard.',
          technicalExplanation: 'Follow manufacturer and site schedules, pre-use checks and instrument status requirements. A failed or overdue detector must not be relied upon.',
          practicalExample: 'Before atmospheric testing, the authorized gas tester confirms the detector is in-date, function-checked and suitable for the gases being assessed.',
        ),
        InterviewQuestion(
          question: '28. What is oxygen deficiency?',
          answer: 'Oxygen deficiency is an atmosphere with less oxygen than the safe range defined by the applicable site procedure, creating risk of impaired judgment, collapse or death.',
          technicalExplanation: 'Atmospheric limits and testing sequence must follow the governing site standard; do not enter based on symptoms or assumptions.',
          practicalExample: 'Before tank entry, a competent tester checks oxygen and other atmospheric hazards from a safe position and records results on the permit.',
        ),
        InterviewQuestion(
          question: '29. What is a flash point?',
          answer: 'Flash point is the lowest temperature at which a liquid gives off enough vapor under a specified test method to ignite momentarily when an ignition source is applied.',
          technicalExplanation: 'It helps characterize flammability but does not alone define safe handling; consider vapor generation, ventilation, temperature and ignition controls.',
          practicalExample: 'A solvent with a low flash point is kept away from hot work and stored in approved containers and locations.',
        ),
        InterviewQuestion(
          question: '30. What is a hazardous area?',
          answer: 'A hazardous area is a location where a flammable gas, vapor, mist or dust atmosphere may occur in quantities requiring special precautions for equipment and work.',
          technicalExplanation: 'Use the facility area-classification drawings and approved equipment requirements. Do not introduce non-approved electrical or ignition sources.',
          practicalExample: 'Before using a portable tool near a process unit, the supervisor verifies area classification and equipment suitability.',
        ),
        InterviewQuestion(
          question: '31. What is simultaneous operations (SIMOPS)?',
          answer: 'SIMOPS means two or more activities occur at the same time in the same or connected area and may affect each other’s safety.',
          technicalExplanation: 'Identify interfaces, conflicts, shared systems, dropped-object zones, gas testing, isolations and emergency access; coordinate through the site process.',
          practicalExample: 'Hot work near a lifting operation is reviewed and may be rescheduled or separated through an approved SIMOPS plan.',
        ),
        InterviewQuestion(
          question: '32. What is line breaking?',
          answer: 'Line breaking is intentionally opening a pipe, hose, duct or equipment that contains or may contain fluid, pressure or hazardous energy.',
          technicalExplanation: 'Verify permit, positive isolation method, depressurization, draining, flushing or purging as required, contents, PPE, positioning and spill response.',
          practicalExample: 'Before opening a hydrocarbon flange, the crew verifies isolation and zero energy, confirms line contents and uses the approved controlled-bolting method.',
        ),
        InterviewQuestion(
          question: '33. What is positive isolation?',
          answer: 'Positive isolation physically separates equipment from hazardous energy or process material using an approved method defined by the facility standard.',
          technicalExplanation: 'Isolation selection depends on hazard, pressure, service and procedure; verify the isolation certificate and test or prove effectiveness as required.',
          practicalExample: 'For intrusive maintenance, the isolation plan may require blinds or spades rather than relying only on a closed valve, as specified by the site.',
        ),
        InterviewQuestion(
          question: '34. What is a dropped-object hazard?',
          answer: 'A dropped-object hazard is the risk of tools, materials or equipment falling from height and striking people or damaging assets.',
          technicalExplanation: 'Use tool tethering where appropriate, toe boards, secured materials, exclusion zones, inspections and good housekeeping.',
          practicalExample: 'During overhead maintenance, workers secure tools and barricade the area below to prevent people entering the drop zone.',
        ),
        InterviewQuestion(
          question: '35. What precautions are needed for working at height?',
          answer: 'Plan the job to avoid height work where possible, use safe platforms and edge protection, inspect access equipment, prevent falling objects and provide a suitable rescue plan.',
          technicalExplanation: 'Apply the site work-at-height procedure and risk assessment. Harnesses require compatible anchorage, correct use and prompt rescue planning.',
          practicalExample: 'Before accessing a platform, the worker checks scaffold tag/status, access, guardrails, weather and dropped-object controls.',
        ),
        InterviewQuestion(
          question: '36. What is a scaffold tag?',
          answer: 'A scaffold tag communicates the scaffold inspection or use status under the site scaffold-control system.',
          technicalExplanation: 'Only competent authorized persons inspect and release scaffolds. A tag is not a substitute for checking visible defects or following site rules.',
          practicalExample: 'A worker sees a red or missing tag and does not use the scaffold; they contact the scaffold coordinator.',
        ),
        InterviewQuestion(
          question: '37. What is a lifting plan?',
          answer: 'A lifting plan defines how a lift will be carried out safely, including load, equipment, configuration, route, ground conditions, roles and controls.',
          technicalExplanation: 'The level of planning and approval depends on lift complexity and site requirements. Confirm certified equipment, competent personnel and exclusion zones.',
          practicalExample: 'Before lifting a pump motor, the team verifies weight, center of gravity, crane capacity at radius, rigging, communication and landing area.',
        ),
        InterviewQuestion(
          question: '38. What is a banksman or signaler’s role?',
          answer: 'A banksman or signaler guides vehicle or lifting movements using agreed signals or communication and helps protect people in the operating area.',
          technicalExplanation: 'They must be competent, visible, positioned safely and able to stop the movement if communication is lost or danger arises.',
          practicalExample: 'During reversing, the driver follows the designated banksman and stops if the banksman is no longer visible.',
        ),
        InterviewQuestion(
          question: '39. What is manual handling?',
          answer: 'Manual handling is lifting, lowering, carrying, pushing or pulling a load by bodily force.',
          technicalExplanation: 'Assess load weight and shape, posture, distance, frequency, route and individual capability. Use mechanical aids or team handling when suitable.',
          practicalExample: 'Instead of carrying a heavy valve component by hand across the site, the team uses a trolley or planned mechanical lift.',
        ),
        InterviewQuestion(
          question: '40. What is heat stress?',
          answer: 'Heat stress occurs when the body cannot adequately manage heat from work, environment and clothing, potentially causing heat illness.',
          technicalExplanation: 'Follow local legal and company heat-stress requirements, acclimatization, hydration, rest, shade, work scheduling and symptom response.',
          practicalExample: 'A worker feeling dizzy in hot conditions stops work, moves to a cool safe area and alerts the supervisor for assessment.',
        ),
        InterviewQuestion(
          question: '41. What are signs of heat illness?',
          answer: 'Warning signs may include heavy sweating, weakness, headache, dizziness, nausea, cramps, confusion or collapse.',
          technicalExplanation: 'Treat suspected serious heat illness as an emergency; activate site response and do not leave the person alone. Follow trained first-aid direction.',
          practicalExample: 'A confused worker in heat is moved from exposure if safe, emergency help is called and cooling begins under trained response.',
        ),
        InterviewQuestion(
          question: '42. What is noise exposure control?',
          answer: 'Noise control reduces harmful sound exposure through quieter equipment, engineering measures, distance, time management and hearing protection.',
          technicalExplanation: 'Assess exposure using the site occupational-hygiene program; hearing protection selection and use must match measured or assessed exposure.',
          practicalExample: 'For prolonged work near compressors, the team uses designated hearing protection and respects restricted noise zones.',
        ),
        InterviewQuestion(
          question: '43. What is ergonomics?',
          answer: 'Ergonomics is designing tasks, tools and workstations to fit people and reduce strain, error and injury.',
          technicalExplanation: 'Consider reach, posture, repetition, force, work height, breaks and worker feedback.',
          practicalExample: 'A frequently used valve handle is repositioned or operated with an approved aid to reduce awkward forceful posture.',
        ),
        InterviewQuestion(
          question: '44. What is housekeeping and why is it important?',
          answer: 'Housekeeping means keeping work areas orderly, clean and free of unnecessary obstructions, waste and trip hazards.',
          technicalExplanation: 'It supports safe access, emergency egress, fire prevention, spill control and efficient work. Assign ownership and inspect routinely.',
          practicalExample: 'Hoses are routed away from walkways, waste is segregated and escape routes remain clear after maintenance.',
        ),
        InterviewQuestion(
          question: '45. How should oil or chemical spills be reported and controlled?',
          answer: 'Warn others, stop the source only if safe and authorized, prevent spread where trained, notify the control room or supervisor and follow the spill response plan.',
          technicalExplanation: 'Use SDS information, compatible spill materials, PPE and approved waste handling. Do not wash contaminants into drains or soil.',
          practicalExample: 'A small oil leak is reported, the area is protected from ignition and the trained response team uses suitable absorbents and disposes of waste correctly.',
        ),
        InterviewQuestion(
          question: '46. What is waste segregation?',
          answer: 'Waste segregation separates waste streams so they can be safely handled, reused, recycled or disposed of through approved routes.',
          technicalExplanation: 'Follow site environmental rules and identify hazardous waste correctly; never mix incompatible chemicals or label unknown waste by guess.',
          practicalExample: 'Used oily rags are placed in the designated compatible container rather than mixed with general waste.',
        ),
        InterviewQuestion(
          question: '47. What is an incident investigation?',
          answer: 'Incident investigation is a structured review to understand what happened, why it happened and what actions can prevent recurrence.',
          technicalExplanation: 'Collect facts, preserve evidence, interview respectfully, examine barriers and system factors, and assign actions with owners and due dates.',
          practicalExample: 'After a hose failure, the team reviews condition, inspection, pressure rating, installation, maintenance and work planning rather than stopping at operator error.',
        ),
        InterviewQuestion(
          question: '48. What is emergency muster and accountability?',
          answer: 'Muster is reporting to the designated assembly point after an alarm so personnel can be accounted for.',
          technicalExplanation: 'Know your assigned point and route; report missing persons to the coordinator and do not leave or re-enter without authorization.',
          practicalExample: 'After evacuation, the worker reports to the roll-call lead and informs them if a colleague was last seen near the worksite.',
        ),
        InterviewQuestion(
          question: '49. Why is communication important in HSE?',
          answer: 'Clear communication ensures workers understand the task, hazards, controls, changes, alarms and responsibilities.',
          technicalExplanation: 'Use closed-loop communication for critical instructions, agreed signals, language support and handover records.',
          practicalExample: 'During isolation, the field operator repeats back the equipment ID and isolation status before the maintenance team proceeds.',
        ),
        InterviewQuestion(
          question: '50. How do you demonstrate a positive safety attitude?',
          answer: 'I follow approved procedures, participate in risk reviews, use stop-work authority responsibly, report hazards and near misses, and support coworkers respectfully.',
          technicalExplanation: 'A positive safety culture depends on leadership, learning, fairness, competence and consistent follow-through, not slogans alone.',
          practicalExample: 'If I notice a coworker about to enter a barricaded lifting zone, I warn them, pause the activity if needed and help clarify the exclusion boundary.',
        ),
      ],
    ),
  ];
}


/// SafeNexus HSE — Oil & Gas Interview | Level 2: Technical Interview
const List<Map<String, String>> oilGasLevel2Questions = [
  {'question':'Explain the Permit to Work process.','answer':'Define the exact task, location and duration; review the risk assessment and method statement; identify isolations, gas tests and SIMOPS; implement and verify precautions; obtain authorisation; brief the work party; monitor conditions; suspend or revalidate when conditions change; and close and hand back the worksite under the facility procedure.','technicalExplanation':'A permit authorises controlled work but does not itself make the work safe. The field conditions must match the permit, and each designated role must fulfil its responsibilities.','siteExample':'Before pump maintenance, match equipment tags to the permit, verify isolation and zero-energy status, review gas-test requirements, brief the crew and check the worksite before starting.'},
  {'question':'How do you apply LOTO and verify isolation?','answer':'Identify all energy sources, use the approved isolation plan, shut down in the authorised sequence, isolate and lock/tag each source, release or restrain stored energy, and verify the safe state using the approved test or try method. Only authorised personnel perform isolation and restoration.','technicalExplanation':'Energy can be electrical, mechanical, hydraulic, pneumatic, chemical, thermal, pressure or gravitational. A control switch or emergency stop is not normally an energy-isolating device.','siteExample':'For a pump, verify electrical isolation, suction/discharge boundaries, drain and vent status, zero pressure and prevention of unexpected rotation; confirm tags match the isolation certificate.'},
  {'question':'What are the essential hot-work precautions in a process facility?','answer':'Use an approved hot-work permit and task assessment. Confirm preparation and isolation, required gas testing, control of flammable materials and vapours, fire protection, trained fire watch, spark containment, protection of drains/openings, communications and emergency readiness. Stop if conditions change.','technicalExplanation':'Gas-test limits, retest frequency and fire-watch duration must come from current operator procedures and applicable requirements; do not assume universal values.','siteExample':'Before grinding near process equipment, verify the authorised boundary, gas-test status, nearby vents and drains, spark screens, fire extinguisher and control-room coordination.'},
  {'question':'Describe safe confined-space entry controls.','answer':'Confirm classification and entry authorisation; isolate connected systems; drain, clean or purge as specified; test the atmosphere; ventilate where required; assign an attendant; establish communication and access control; and prepare a tested rescue plan and equipment. Monitor as required by the permit.','technicalExplanation':'Hazards include oxygen deficiency/enrichment, toxic or flammable atmosphere, engulfment, heat, restricted access and unexpected energy. Never rely on an improvised rescue entry.','siteExample':'For tank entry, verify isolation boundaries, test at representative levels, record readings, confirm attendant and communication, stage rescue equipment and stop entry if monitoring or ventilation fails.'},
  {'question':'How do you manage H2S exposure risk?','answer':'Follow the facility H2S assessment and emergency procedure. Know potential release points, alarm arrangements, wind indicators, escape routes and muster points. Use only authorised respiratory protection and training. On alarm, follow the designated escape route and never attempt an untrained rescue in a suspected contaminated atmosphere.','technicalExplanation':'H2S is acutely toxic and smell is not a reliable warning. Alarm setpoints, escape equipment and breathing-apparatus requirements are facility-specific.','siteExample':'When an H2S alarm sounds, stop work, move by the designated route toward the safe area considering wind direction, report at muster and await emergency-team instructions.'},
  {'question':'What is SIMOPS and how is it controlled?','answer':'Simultaneous operations are activities that overlap in time or location and may interact. Identify interfaces, assess cumulative and escalation risks, coordinate timing, assign an authority, communicate restrictions, establish exclusion zones and review the plan when conditions change.','technicalExplanation':'Examples include hot work near hydrocarbon transfer, lifting over occupied areas, excavation near live services and maintenance beside operating equipment.','siteExample':'Coordinate a crane lift, nearby hot work and operating process line with operations; sequence tasks, protect emergency access and suspend conflicting work until interfaces are controlled.'},
  {'question':'What should a lifting plan address?','answer':'Verify load weight and centre of gravity, lifting points, crane configuration and capacity, radius, ground/deck capacity, route, weather limits, exclusion zone, competent roles, communications and contingency arrangements. Use the plan required for the lift complexity and operator procedure.','technicalExplanation':'Use the actual crane load chart and approved configuration, not rules of thumb. Inspect lifting accessories and verify identification and certification under the site system.','siteExample':'Before lifting a motor, confirm verified weight, lifting points, rigging, crane setup, route, nearby pipework, barricades, signal person and communications.'},
  {'question':'How do you control work at height?','answer':'Avoid work at height where practicable. Otherwise prioritise suitable platforms and collective protection, then assess access, fragile surfaces, dropped objects, weather, rescue and work below. Use inspected equipment and trained personnel.','technicalExplanation':'Fall-arrest requires compatible components, suitable anchorage, clearance assessment and a prompt rescue plan. Exact thresholds and inspection intervals depend on applicable rules and site procedures.','siteExample':'For elevated instrument work, verify platform and handrails, access, tool securing, barricade below, permit/rescue arrangements and weather before starting.'},
  {'question':'What is Management of Change (MOC)?','answer':'MOC formally reviews changes that may affect process safety, people, environment, equipment, procedures or compliance. Define scope and reason, assess impacts, specify safeguards, obtain authorised approval, update documents and training, and verify readiness before implementation.','technicalExplanation':'Changes may be permanent, temporary or emergency. Screen uncertain changes under the operator’s procedure rather than assuming they are exempt.','siteExample':'A replacement pump with different capacity or materials may affect pressure, flow, electrical load and maintenance. MOC coordinates engineering review, drawing updates, training and readiness checks.'},
  {'question':'How do you investigate an incident?','answer':'Make the area safe, provide emergency response, notify required personnel and preserve evidence where practicable. Gather facts, interview witnesses respectfully, review permits and records, identify immediate and underlying causes, assign corrective actions and verify effectiveness.','technicalExplanation':'Avoid blame-based conclusions. Examine planning, equipment, supervision, procedures, competence and organisational factors using the approved investigation method.','siteExample':'After a hose failure, secure the system, preserve the hose, review inspection and pressure records, interview the crew and track corrective actions addressing the failure mechanism.'},
  {'question':'How do you manage chemical storage?','answer':'Maintain an approved inventory and current SDS access; segregate incompatible materials; use suitable labelled containers, containment, ventilation and ignition controls; restrict access; provide appropriate spill response materials; inspect storage and dispose of waste under site rules.','technicalExplanation':'Compatibility and storage limits depend on chemical properties and facility requirements. Never use an unlabelled container or rely on appearance.','siteExample':'Inspect chemical cabinets and bunds, confirm labels and closed lids, segregate incompatibles and ensure spill kits match the stored substances.'},
  {'question':'How do you perform an effective HSE inspection?','answer':'Plan around risk and active work, observe field conditions, speak with workers, inspect equipment and records, record objective findings with location and risk, assign owners and due dates, and verify closeout in the field.','technicalExplanation':'Prioritise actual exposure and critical-control failures. Repeated findings may indicate systemic weaknesses in planning, procurement, supervision or training.','siteExample':'Identify a hose crossing an access route, arrange safe rerouting or protection, assign an owner and verify the route is clear.'},
  {'question':'Distinguish process safety from personal safety.','answer':'Personal safety prevents individual harm such as slips, trips and hand injuries. Process safety prevents loss of containment of hazardous substances or energy that could cause fire, explosion, toxic release or major accident. Both require leadership, engineering, operating discipline and learning.','technicalExplanation':'Process safety depends on design integrity, operating limits, alarms, safeguards, inspection, maintenance, competence and emergency preparedness. Low injury rates alone do not demonstrate healthy process safety.','siteExample':'A worker may wear PPE yet remain exposed to a major release from a degraded pressure boundary. Reporting leaks, corrosion, abnormal vibration and impaired safeguards supports process safety.'}
,
  {'question':'What is Process Safety Management (PSM), and why is it important in Oil & Gas?','answer':'Process Safety Management is a structured system for preventing major accidents involving loss of containment, fire, explosion or toxic release. It combines process safety information, hazard analysis, operating procedures, competence, mechanical integrity, management of change, contractor control, emergency planning, incident learning and assurance.','technicalExplanation':'PSM addresses low-frequency, high-consequence events and the integrity of multiple prevention and mitigation barriers. Personal safety indicators alone cannot demonstrate process safety health. Apply the operator’s PSM framework and applicable legal and technical requirements.','siteExample':'Before modifying a hydrocarbon pump seal arrangement, the team reviews process hazards, engineering changes, isolation needs, safeguards, procedures, training and commissioning checks through formal management of change.'},
  {'question':'How is gas testing and atmospheric monitoring performed before and during hazardous work?','answer':'A competent authorised gas tester uses an approved, calibrated instrument, verifies its status and performs tests at the locations and elevations specified by the permit or procedure. Test oxygen, flammable gas and relevant toxic contaminants as required. Record results, time, location, tester and instrument details; repeat or continuously monitor when conditions or permit requirements demand it.','technicalExplanation':'Sampling strategy must account for gas density, ventilation, confined geometry, process sources and possible stratification. Acceptance limits, test intervals and stop-work triggers come from the current permit, facility procedure and applicable requirements—not a generic value.','siteExample':'For vessel entry, test remotely before opening or entry, sample representative levels and dead spaces as specified, confirm ventilation and isolation, and maintain the required attendant and monitoring arrangements.'},
  {'question':'What is an Emergency Shutdown (ESD) system?','answer':'An ESD system brings a process or facility, or a defined part of it, to a predetermined safe state when specified abnormal or emergency conditions occur. Depending on design, it may close shutdown valves, stop equipment, isolate inventory or initiate other protective actions.','technicalExplanation':'ESD functions are engineered safeguards with defined cause-and-effect logic, integrity requirements, proof testing, bypass control and management of impairment. Personnel must not operate, inhibit or reset systems outside their authority and approved procedure.','siteExample':'A confirmed high-high pressure or emergency pushbutton signal may initiate a defined shutdown sequence. Operators follow the control-room response and verify field status without bypassing safeguards.'},
  {'question':'How do Fire and Gas (F&G) detection systems support facility safety?','answer':'F&G systems detect selected fire, flammable gas or toxic gas conditions and alert personnel or initiate configured protective actions. Devices may include flame, heat, smoke, combustible-gas and toxic-gas detectors, linked to alarms, ventilation actions or shutdown logic where designed.','technicalExplanation':'Detector type, placement, voting logic, alarm setpoints, coverage, testing and impairment management are determined by the approved safety design and facility procedures. Detection does not replace prevention, evacuation readiness or manual reporting.','siteExample':'If a fixed gas detector alarms near a compressor, the operator follows the alarm response, avoids entering the suspected release area, informs the control room and initiates the required evacuation or isolation actions.'},
  {'question':'What precautions are required for pressure testing or hydrotesting?','answer':'Use an approved test pack and procedure; confirm test boundaries, rated components, calibrated gauges, relief arrangements, exclusion zones, communications and competent supervision. Prefer water where technically suitable, fill and vent safely, raise pressure in controlled stages, inspect from safe positions, depressurise fully before adjustment, and document results.','technicalExplanation':'Stored energy can cause catastrophic failure even during liquid testing. Pneumatic testing generally presents greater stored-energy risk and requires specific engineering justification and controls. Test pressure, hold time, acceptance criteria and boundaries must come from approved engineering documents and applicable codes.','siteExample':'Before hydrotesting a spool, verify blinds and supports against the test pack, barricade the line of fire, establish controlled pressurisation, monitor remotely where practicable and prove zero pressure before dismantling.'},
  {'question':'What is hazardous area classification, and how does it affect equipment selection?','answer':'Hazardous area classification identifies locations where flammable gas, vapour, mist or dust may be present in quantities requiring special precautions. The classification defines zones or divisions and gas or dust groups and temperature requirements used to select suitable electrical and instrumentation equipment.','technicalExplanation':'Use the approved facility hazardous-area drawings and applicable design standard. Equipment certification, protection concept, gas group, temperature class, ingress protection, installation and maintenance must match the area and service. Do not assume ordinary equipment is acceptable because a release is not currently visible.','siteExample':'Before using a portable light near a hydrocarbon process unit, verify the area classification, equipment certification and permit conditions; use only approved equipment and inspect it before use.'},
  {'question':'How do you assess initial and residual risk for an Oil & Gas task?','answer':'Define the task and credible hazards, identify exposed people and assets, evaluate likelihood and consequence using the approved site matrix, and select controls using the hierarchy of controls. Reassess after controls are implemented to determine residual risk, confirm required approvals and communicate remaining risks to the work party.','technicalExplanation':'Residual risk is not automatically acceptable because a score is reduced. Mandatory safeguards, legal duties, simultaneous operations, uncertainty and change conditions must be considered. Escalate risk beyond delegated authority and stop if controls are absent or ineffective.','siteExample':'For flange breaking, the team reviews stored pressure and hazardous fluid, verifies isolation and depressurisation, defines exclusion and PPE, confirms the permit and gas testing, then checks whether residual risk meets site authorisation criteria before starting.'},
];


/// SafeNexus HSE — Oil & Gas Interview | Level 3: Advanced Interview
const List<Map<String, String>> oilGasLevel3Questions = [
  {'question':'How would you build a risk-based HSE assurance programme?','answer':'Use the facility risk profile, legal and company obligations, major accident hazards, critical controls, incident trends and operational changes to define assurance activities, competent reviewers, sampling, frequency, evidence standards, escalation and effectiveness checks. Combine field verification, records review and workforce engagement.','technicalExplanation':'Assurance tests whether controls are present, suitable, used and effective—not merely whether a procedure exists.','siteExample':'For lifting, sample lift plans, inspect accessories, observe lifts, interview crews and track recurring findings to closure.'},
  {'question':'Explain bow-tie analysis.','answer':'Bow-tie analysis places a top event, such as loss of containment, between threats and consequences. Preventive barriers act before the top event; mitigative barriers reduce consequences after it. Each barrier should have an owner, performance standard and verification method.','technicalExplanation':'Barriers must be specific and verifiable. General phrases such as “good supervision” need to be translated into observable controls.','siteExample':'For a hydrocarbon release, threats may include corrosion or overpressure; preventive barriers include inspection and pressure protection, while mitigation includes detection, isolation, fire protection and evacuation.'},
  {'question':'What do you do when a safety-critical barrier is impaired?','answer':'Confirm the impairment, notify the designated operations authority, assess increased risk, apply approved compensating measures, restrict or suspend affected activities as required, record and communicate the impairment, then restore and test the barrier before formal closeout.','technicalExplanation':'Impairments to alarms, trips, fire and gas detection, firewater and other safety-critical systems require the facility’s formal authorisation and impairment process.','siteExample':'If a firewater pump is unavailable, notify operations, assess affected activities, apply authorised interim measures, restrict hot work as required and track restoration and testing.'},
  {'question':'How would you investigate a high-potential near miss?','answer':'Secure the area, preserve evidence, notify required parties, establish a multidisciplinary team, develop a factual timeline, examine barriers and decisions, test possible explanations, identify systemic contributors and assign actions with effectiveness criteria.','technicalExplanation':'Potential severity differs from actual outcome. A no-injury event can reveal major weaknesses in lifting, isolation or process-safety barriers.','siteExample':'After a dropped load narrowly misses a worker, examine rigging, lift plan, exclusion zone, communications, equipment condition, supervision and planning pressures.'},
  {'question':'What is a safety-critical element (SCE)?','answer':'An SCE is equipment or a system identified by the facility’s major-accident hazard assessment as necessary to prevent a major accident or limit its consequences. Manage it through performance standards, inspection, maintenance, defect reporting, impairment control, competence and assurance.','technicalExplanation':'The SCE register and standards are facility-specific and should be managed with engineering, operations and maintenance technical authorities.','siteExample':'For an emergency shutdown valve, check its defined function, test status, defects, bypass status and approved response if unavailable.'},
  {'question':'How do you evaluate contractor HSE performance beyond injury rates?','answer':'Use balanced leading and lagging indicators: critical-control verification, risk-assessment quality, competence, field leadership, action closeout, equipment integrity, worker reporting and incident trends. Interpret data against exposure and work scope.','technicalExplanation':'A low incident count may reflect low exposure or under-reporting. Metrics need consistent definitions, denominators and field validation.','siteExample':'For shutdown contractors, review permit quality, isolation verification, lifting observations, supervision, fatigue controls and high-risk action closeout.'},
  {'question':'How do you manage HSE during a shutdown or turnaround?','answer':'Establish governance and interfaces early; risk-rank scope; validate contractor competence; plan isolations and SIMOPS; coordinate permits, access and traffic; monitor fatigue and welfare; prepare emergency response; and conduct daily risk reviews. Manage scope changes formally.','technicalExplanation':'Shutdowns increase workforce density, non-routine tasks, schedule pressure and interface risk. Planning must integrate operations, maintenance, engineering, contractors and logistics.','siteExample':'Before opening a vessel, verify isolation and gas-free status, entry and rescue arrangements, lifting routes, adjacent work restrictions and waste handling.'},
  {'question':'How do you assess cumulative SIMOPS risk?','answer':'Identify activities in the interaction zone and time window, map shared hazards and barriers, assess escalation pathways, sequence tasks, define exclusion zones and communication, assign coordination authority and review when conditions change.','technicalExplanation':'Individually acceptable task assessments may combine into unacceptable risk through domino effects, shared escape routes, utilities or control-room workload.','siteExample':'Coordinate a crane lift, hydrocarbon transfer and electrical maintenance; sequence work, protect emergency access and control ignition sources.'},
  {'question':'What if production pressure conflicts with a critical safety control?','answer':'State the specific hazard and control requirement, pause affected work if risk is uncontrolled, notify responsible operations and management, and assess any alternative through the formal risk and change process. Do not accept an informal bypass.','technicalExplanation':'Safe production depends on maintaining barriers and approved operating limits. Decisions belong to authorised roles and should be documented.','siteExample':'If required gas detection is unavailable, do not proceed solely to meet schedule. Escalate and restart only after an approved equivalent control is confirmed.'},
  {'question':'How do you verify corrective-action effectiveness?','answer':'Define intended risk reduction and evidence before closure. Verify implementation in the field, interview workers, review tests or records, check whether the failure mechanism was addressed and monitor recurrence. Reopen or escalate ineffective actions.','technicalExplanation':'Procedure updates and training completion are outputs, not necessarily proof of effectiveness. Actions should address causes proportionately to risk.','siteExample':'After repeated hose failures, verify specification, procurement, inspection, storage, handling, competence and trend data—not only a safety-alert circulation.'},
  {'question':'How should an HSE leader respond during a major emergency?','answer':'Prioritise life safety and follow the facility incident-command structure. Support alarm, accountability, evacuation or shelter, authorised isolation decisions, responder safety, situation reporting and coordination with external agencies. Support recovery and learning after control is restored.','technicalExplanation':'Do not assume command unless assigned by the emergency plan. Use verified information, clear roles and established communications.','siteExample':'During a suspected gas release, support the incident commander with hazard information, personnel accountability, exclusion-zone advice and responder exposure monitoring.'},
  {'question':'How do you embed process safety culture?','answer':'Make major accident hazards visible in leadership decisions, encourage reporting of weak signals, maintain operating discipline, verify critical controls, involve frontline workers, learn from normal work and failures, and resource asset integrity and competence.','technicalExplanation':'Culture is demonstrated by everyday decisions, reporting trust, investigation quality, barrier health and follow-through—not slogans alone.','siteExample':'Review overdue safety-critical maintenance, alarm impairments, abnormal process conditions and worker concerns in operations meetings with owners and escalation dates.'},
  {'question':'How do you prepare for an HSE or regulatory audit?','answer':'Confirm scope and criteria, map requirements to controlled evidence, review prior findings, brief process owners, arrange safe access and ensure records are accurate. Answer transparently, record findings and manage actions through verified closure.','technicalExplanation':'Do not create retrospective or misleading records. Readiness should reflect actual implementation and the applicable authority and operator requirements.','siteExample':'For a PTW audit, compare sampled permits with field conditions, authorisations and isolations; interview workers and trace findings through effectiveness review.'},
  {'question':'How do you prioritise HSE work when resources are limited?','answer':'Prioritise credible consequence, exposure, control reliability, legal obligations and urgency. Address imminent danger and uncontrolled major-accident hazards first, then use a transparent risk-based plan. Escalate resource gaps and document authorised interim safeguards.','technicalExplanation':'A risk score must not override mandatory requirements or critical-control failures. Decisions should involve operational and technical owners.','siteExample':'Prioritise overdue safety-critical equipment and high-risk interfaces, escalate staffing constraints and arrange approved interim controls.'},
  {
    'question': 'How do you verify safety-critical element performance?',
    'answer': 'Identify each safety-critical element, its performance standard, owner, inspection or proof-test interval, impairment process and evidence. Confirm overdue or failed tests are escalated and risk is controlled.',
    'technicalExplanation': 'A safety-critical element is a barrier whose failure can contribute to or worsen a major accident. Assurance must test availability, functionality and reliability against approved performance standards.',
    'practicalExample': 'A firewater pump test fails its required performance criterion. Record the impairment, notify operations, apply approved compensating measures and restore and retest before closing the action.',
  },
  {
    'question': 'How do you manage simultaneous operations (SIMOPS)?',
    'answer': 'Identify concurrent activities, map interactions, assess combined risks, agree area authority and communication, sequence or separate incompatible work, and brief all affected teams. Reassess whenever scope or conditions change.',
    'technicalExplanation': 'SIMOPS risk may arise from overlapping permits, energy sources, lifting paths, ignition sources, process operations or emergency access. Use the facility SIMOPS matrix and coordination process.',
    'practicalExample': 'Hot work near a hydrocarbon transfer operation is held until the area authority confirms separation, controls, gas monitoring and approved coordination.',
  },
  {
    'question': 'What is a bow-tie analysis?',
    'answer': 'Define the top event, identify credible threats and consequences, then map preventive barriers before the event and mitigative barriers after it. Assign owners and verify barrier health.',
    'technicalExplanation': 'Bow-tie analysis communicates how controls prevent loss of control and limit consequences. It should connect to risk assessments, performance standards and assurance activities.',
    'practicalExample': 'For loss of containment, prevention may include corrosion control and maintenance; mitigation may include detection, isolation, emergency response and fire protection.',
  },
  {
    'question': 'How do you investigate a high-potential near miss?',
    'answer': 'Make the scene safe, preserve evidence, notify required parties, gather records and witness accounts, establish a timeline, analyse failed and missing barriers, assign corrective actions and verify effectiveness.',
    'technicalExplanation': 'Focus on system and barrier causes rather than stopping at individual actions. Protect evidence integrity and follow operator reporting and investigation requirements.',
    'practicalExample': 'A dropped object is stopped by a secondary barrier. The team examines lifting plan, tool tethering, exclusion zone, supervision and inspection, then verifies actions in the field.',
  },
  {
    'question': 'How do you control management of change (MOC)?',
    'answer': 'Screen proposed temporary or permanent changes, assess technical and HSE impacts, obtain competent review and approval, update drawings and procedures, train affected personnel, and verify readiness before startup.',
    'technicalExplanation': 'MOC prevents unassessed changes from weakening process safety barriers. Define expiry and restoration for temporary changes and complete a pre-startup safety review where required.',
    'practicalExample': 'A pump is replaced with a different model. Engineering checks capacity, materials, hazardous-area suitability, safeguards, documentation and operator training before commissioning.',
  },
  {
    'question': 'How do you manage safety-critical maintenance deferrals?',
    'answer': 'Identify the affected function and risk, obtain engineering and operations assessment, document authorisation and expiry, implement approved compensating controls, track the deferral and restore integrity promptly.',
    'technicalExplanation': 'A deferral must not become an informal extension. Apply site impairment and risk acceptance rules, including escalation when protection is degraded beyond permitted limits.',
    'practicalExample': 'A gas detector is unavailable. Operations assess coverage, restrict affected work, arrange approved temporary monitoring and track repair and functional test to closure.',
  },
];


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
  },
  {
    'question': 'A gas detector alarms during hot work. What do you do?',
    'answer': 'Stop work, make tools safe if this can be done without exposure, withdraw to the designated safe area, warn others and notify the control room or permit authority. Do not re-enter until authorised and conditions are reassessed.',
    'technicalExplanation': 'An alarm may indicate a release or changing atmosphere. Follow site alarm response and emergency procedures; never silence or bypass the detector to continue work.',
    'practicalExample': 'During welding, a combustible-gas alarm activates. The crew evacuates upwind or to the muster point as instructed, and the permit is suspended pending investigation and revalidation.',
  },
  {
    'question': 'A contractor begins work outside the permit boundary. How do you respond?',
    'answer': 'Stop the unauthorised activity, prevent exposure, inform the supervisor and permit issuer, confirm the approved scope and boundaries, and restart only after permit and risk documents are corrected and briefed.',
    'technicalExplanation': 'Permit validity applies only to the defined scope, location, period and precautions. Work outside those limits is not authorised.',
    'practicalExample': 'A crew moves to an adjacent line not shown on the permit. The HSE officer stops the task and requires updated isolation verification and permit approval.',
  },
  {
    'question': 'You find a damaged sling before a lift. What action is required?',
    'answer': 'Do not use it. Isolate and identify it as defective, report it to the lifting supervisor, arrange replacement with certified suitable gear, and verify the lift plan and inspection status before proceeding.',
    'technicalExplanation': 'Defects can reduce rated capacity or cause sudden failure. Quarantine prevents accidental reuse; do not attempt an unauthorised repair.',
    'practicalExample': 'A web sling has a cut edge. It is removed from service and replaced; the lifting team rechecks capacity, configuration and rigging before the lift.',
  },
  {
    'question': 'A worker collapses in a suspected H2S area. What is your response?',
    'answer': 'Raise the alarm, keep others out, approach only under the site emergency plan with trained responders and suitable respiratory protection, and activate rescue and medical response. Never make an unprotected rescue entry.',
    'technicalExplanation': 'H2S can rapidly incapacitate rescuers. Rescue requires command, atmospheric assessment, appropriate breathing apparatus, backup and casualty handover.',
    'practicalExample': 'A worker is down near a process drain. The team isolates access and calls the trained rescue team rather than rushing in with ordinary masks.',
  },
  {
    'question': 'Heavy rain affects an excavation. What must happen?',
    'answer': 'Stop entry, keep people and equipment away from the edge, arrange competent inspection and reassess water accumulation, soil stability, support, access and nearby loads. Resume only after authorised confirmation.',
    'technicalExplanation': 'Rain can weaken ground, increase surcharge and undermine protective systems. Pumping water alone does not establish stability.',
    'practicalExample': 'After overnight rain, the excavation supervisor blocks access until a competent person inspects shoring, edge protection, water and adjacent structures.',
  },
];


/// SafeNexus HSE — Oil & Gas Interview
/// Level 5: Supervisor / Engineer Interview
const List<Map<String, String>> oilGasLevel5Questions = [
  {
    'question': 'How do you plan and lead a safe daily work programme?',
    'answer': 'Review the work scope, priorities, manpower, competence, permits, isolations, equipment readiness, SIMOPS, environmental conditions, and emergency arrangements. Conduct a coordination meeting, assign accountable supervisors, verify critical controls in the field, monitor progress, and reassess when conditions or scope change. Close the shift with a documented handover.',
    'technicalExplanation': 'Planning integrates operations, maintenance, contractors, logistics, and HSE. A schedule must not override permit boundaries, critical controls, or legal obligations.',
    'practicalExample': 'For a maintenance campaign, sequence isolation-dependent jobs, prevent conflicting hot work and lifting, confirm access routes, and review high-risk activities at the daily meeting.'
  },
  {
    'question': 'How do you ensure subcontractors meet site HSE requirements?',
    'answer': 'Verify prequalification and scope-specific competence, communicate site rules and performance expectations, review method statements and risk assessments, confirm supervision and equipment readiness, monitor field implementation, and manage deficiencies through coaching and formal escalation. Evaluate performance using evidence and trends.',
    'technicalExplanation': 'Contracting does not transfer away the operator’s responsibility to manage interfaces and verify controls. Requirements should be clear before mobilisation and consistently applied.',
    'practicalExample': 'Before a specialist contractor begins vessel work, verify training, medical or fitness requirements where applicable, rescue capability, calibrated equipment, permit roles, and emergency briefing.'
  },
  {
    'question': 'What would you do when a critical maintenance action is overdue?',
    'answer': 'Confirm the equipment and safety function affected, assess the risk with the responsible technical and operations authorities, determine whether the item is safety-critical, apply the formal defect or impairment process, establish authorised compensating measures or restrictions, and escalate resource or schedule needs. Track restoration and verification to closure.',
    'technicalExplanation': 'An overdue action cannot be accepted solely because the equipment appears to be operating. Risk decisions and extensions require authorised technical justification under the facility system.',
    'practicalExample': 'An overdue test on a protective device is escalated to operations and engineering; affected activities are reviewed and any approved operating restrictions are communicated to shifts.'
  },
  {
    'question': 'How do you manage a serious safety disagreement with a production manager?',
    'answer': 'State the hazard, evidence, applicable control requirement, and potential consequence objectively. Pause affected work if risk is uncontrolled, use the formal escalation and risk review process, involve the authorised technical or operations decision-maker, document the decision, and communicate conditions for safe restart.',
    'technicalExplanation': 'Professional challenge should be respectful, evidence-based, and focused on barrier integrity. HSE advice does not replace the authorised operational decision process.',
    'practicalExample': 'If a required isolation cannot be verified, explain the exposure and stop criteria, request operations verification, and do not release the task based on schedule pressure.'
  },
  {
    'question': 'How do you conduct an effective shift handover for HSE-critical work?',
    'answer': 'Use a structured handover covering active permits, equipment status, isolations, gas test or monitoring status, suspended work, impairments, SIMOPS, personnel accountability, abnormal conditions, open incidents, emergency equipment, and outstanding actions. Confirm the incoming supervisor understands and accepts responsibility under site procedure.',
    'technicalExplanation': 'Critical information should be written, traceable, and verbally confirmed. Ambiguous ownership during shift changes can undermine barriers.',
    'practicalExample': 'A vessel entry is suspended overnight. Handover records entry status, isolation boundaries, atmospheric status, equipment, access security, rescue readiness, and conditions required before re-entry.'
  },
  {
    'question': 'How do you set measurable HSE objectives for a project?',
    'answer': 'Start with significant risks, applicable obligations, project phase, and stakeholder expectations. Define specific leading and lagging indicators, baselines, owners, targets, data sources, review cadence, and corrective triggers. Ensure measures reflect control effectiveness rather than rewarding low reporting.',
    'technicalExplanation': 'Useful indicators may include critical-control verification quality, overdue high-risk actions, competence assurance, permit field compliance, and learning-action effectiveness. Avoid targets that encourage under-reporting.',
    'practicalExample': 'A project tracks completion and field quality of high-risk lift-plan verifications, then reviews recurring defects and corrective action effectiveness weekly.'
  },
  {
    'question': 'How would you manage a major incident investigation as a supervisor?',
    'answer': 'Ensure emergency response and scene safety first, notify the required command and reporting channels, preserve evidence without obstructing rescue, support a competent investigation team, provide accurate records and witness access, and implement immediate safeguards. Track assigned actions and verify effectiveness before normalising the activity.',
    'technicalExplanation': 'Supervisors should avoid altering evidence, coaching witness accounts, or speculating about cause. Investigation independence and reporting requirements follow company and applicable authority rules.',
    'practicalExample': 'After a dropped object, secure the area, preserve the object and tool condition, collect lift and inspection records, and implement temporary controls pending investigation findings.'
  },
  {
    'question': 'How do you verify that workers are competent for a high-risk task?',
    'answer': 'Identify task-specific competence criteria, verify current training and authorisation, assess practical ability where required, confirm familiarity with equipment and procedures, and ensure supervision is appropriate. Reassess after significant changes, poor performance, or a long absence from the task.',
    'technicalExplanation': 'Training attendance alone may not establish competence. Licensing, certification, medical fitness, and refresher requirements are task- and jurisdiction-specific and must be checked against current rules.',
    'practicalExample': 'Before a lifting operation, verify the assigned operator, rigger, and signal person meet the facility’s competence and authorisation requirements for the equipment and lift complexity.'
  },
  {
    'question': 'How do you control fatigue during shutdown or night-shift work?',
    'answer': 'Apply the company fatigue management process, plan realistic shifts and rest, monitor overtime and consecutive duties, assess task criticality, provide suitable welfare and transport arrangements, encourage workers to report fatigue, and adjust staffing or task timing when alertness may be impaired.',
    'technicalExplanation': 'Fatigue is influenced by workload, shift pattern, sleep opportunity, heat, travel, and individual factors. Follow applicable working-time rules and operator standards rather than inventing universal limits.',
    'practicalExample': 'Before a complex night lift, the supervisor checks crew fitness and hours, confirms adequate staffing and lighting, and reschedules if safe performance cannot be assured.'
  },
  {
    'question': 'How do you manage emergency drills and close lessons learned?',
    'answer': 'Select credible scenarios from the risk assessment, define objectives and evaluation criteria, coordinate participants and observers, conduct the drill safely, record actual response times and communication gaps, debrief participants, assign improvement actions, and verify closure through follow-up or repeat exercise.',
    'technicalExplanation': 'A drill is not successful merely because it was completed. Evaluate alarm recognition, command, communication, accountability, access, equipment, and coordination with external responders where relevant.',
    'practicalExample': 'A simulated gas-release drill reveals confusion over muster location. Update signage and induction content, brief shifts, and test understanding in a later exercise.'
  },
  {
    'question': 'What is your approach to environmental compliance on an Oil & Gas project?',
    'answer': 'Identify permits and environmental commitments, assess emissions, discharges, waste, spills, noise, and resource use, establish monitoring and inspection plans, maintain records, train workers, and report deviations promptly. Use approved waste routes and contractors and verify corrective actions.',
    'technicalExplanation': 'Permit conditions and reporting thresholds are site- and authority-specific. Do not discharge, burn, or dispose of materials without the required authorisation and controls.',
    'practicalExample': 'For maintenance waste, classify the waste through the approved process, segregate and label containers, use authorised transport and disposal, and retain manifests or transfer records.'
  },
  {
    'question': 'How do you review a method statement before approving or recommending it?',
    'answer': 'Check that the scope, sequence, resources, competence, equipment, hazards, controls, permits, isolations, interfaces, environmental measures, inspection points, emergency arrangements, and responsibilities are clear and consistent with the risk assessment and site requirements. Resolve gaps with the technical owner before work authorisation.',
    'technicalExplanation': 'A method statement should describe how the work will actually be performed. Generic text, mismatched equipment details, and unclear hold points are warning signs.',
    'practicalExample': 'For pipe removal, verify line identification, isolation and verification steps, residual contents management, lifting method, temporary supports, and reinstatement checks.'
  },
  {
    'question': 'How do you manage change in scope during execution?',
    'answer': 'Pause the affected portion, define the proposed change, assess technical and HSE impacts, review permits and risk assessments, consult relevant authorities and affected teams, obtain required MOC or work-change approval, brief the crew, and verify revised controls before restarting.',
    'technicalExplanation': 'Small field changes can introduce new energy sources, exposures, interfaces, or design assumptions. The site change-control process determines the required level of review.',
    'practicalExample': 'A repair requires a different cutting method than planned. Stop, assess ignition and exposure implications, update the work package and permit conditions, and obtain authorisation.'
  },
  {
    'question': 'How do you coach a supervisor who repeatedly has poor safety observations?',
    'answer': 'Discuss specific observed behaviours and work conditions privately and respectfully, listen for barriers such as unclear planning or inadequate resources, agree practical improvements, provide support or training, and follow up in the field. Escalate repeated deliberate non-compliance through the fair company process.',
    'technicalExplanation': 'Effective coaching distinguishes capability, system, and conduct issues. Avoid relying only on slogans or punitive measures that may discourage reporting.',
    'practicalExample': 'Repeated poor barricading is addressed by reviewing the work-planning process, supplying suitable barriers, assigning ownership, and checking the next jobs for sustained improvement.'
  },
  {
    'question': 'What information should a project HSE dashboard present to leadership?',
    'answer': 'Present a balanced view of exposure, critical-control health, high-potential events, leading and lagging trends, overdue risk actions, audit findings, competence, contractor performance, environmental events, and key decisions needed. Define metrics and explain data limitations so leaders can act on risk rather than chase numbers.',
    'technicalExplanation': 'Dashboard data should be accurate, comparable, and disaggregated where useful by work type, contractor, phase, or exposure. Avoid presenting raw counts without context.',
    'practicalExample': 'A dashboard shows recurring isolation verification gaps by workstream, the affected tasks, action owners, due dates, and whether field rechecks confirm improvement.'
  },
  {
    'question': 'How do you ensure contractor HSE performance?',
    'answer': 'Prequalify competence and resources, communicate requirements, review plans, verify induction and task training, monitor field execution, address deviations, review trends and close corrective actions with evidence.',
    'technicalExplanation': 'Contractor oversight should be risk-based and shared with the contract owner and operations. Leading indicators and critical-control verification complement injury statistics.',
    'practicalExample': 'A contractor repeatedly misses gas-test records. The supervisor pauses affected work, investigates system causes, retrains and audits subsequent permits before lifting the restriction.',
  },
  {
    'question': 'How do you lead a toolbox talk that changes behaviour?',
    'answer': 'Use the actual task and worksite conditions, explain top hazards and controls, invite worker input, confirm understanding, assign responsibilities and check controls at the job site.',
    'technicalExplanation': 'A toolbox talk is effective when it is interactive and linked to verified controls, not merely a signature sheet. Rebrief after meaningful change.',
    'practicalExample': 'Before flange breaking, the supervisor demonstrates the exclusion zone, confirms isolation points and asks each worker to explain their role and stop-work trigger.',
  },
  {
    'question': 'What do you do when production pressure conflicts with a safety control?',
    'answer': 'Pause the affected work, explain the specific risk and required control, escalate through operations and HSE authority, and resume only when approved safeguards are effective.',
    'technicalExplanation': 'Production targets do not replace permit conditions, legal duties or risk acceptance authority. Document decisions and use formal escalation rather than informal compromise.',
    'practicalExample': 'A supervisor requests work with an overdue critical inspection. The engineer escalates the impairment and obtains an authorised risk decision before work proceeds.',
  },
  {
    'question': 'How do you verify corrective actions are effective?',
    'answer': 'Define the intended risk reduction, assign an accountable owner and due date, review objective evidence, and perform a field recheck or trend review. Reopen actions that are incomplete or ineffective.',
    'technicalExplanation': 'Closure should demonstrate that the underlying cause or failed barrier has been addressed, not merely that a document was submitted.',
    'practicalExample': 'After a housekeeping action, the supervisor checks the work area during later shifts and reviews repeat findings before confirming effectiveness.',
  },
  {
    'question': 'How do you manage fatigue in shift operations?',
    'answer': 'Assess shift length, overtime, rest opportunity, travel, workload and task criticality. Apply the site fatigue-management process, report unfit-for-duty concerns, adjust assignments and ensure adequate handover.',
    'technicalExplanation': 'Fatigue can impair attention, judgement and reaction time. Supervisors should manage organisational factors and not rely only on individual self-reporting.',
    'practicalExample': 'A technician reports severe fatigue before a critical operation. The supervisor arranges a fit-for-duty review and suitable reassignment under company procedure.',
  },
];


/// SafeNexus HSE — Oil & Gas Interview
/// Level 6: UAE Authority-Specific
/// Authority requirements change; verify current official instruments and site/operator rules.
const List<Map<String, String>> oilGasLevel6Questions = [
  {
    'question': 'How do you identify which UAE and emirate HSE requirements apply to an Oil & Gas worksite?',
    'answer': 'Establish the facility location, activity, sector, employer and operator requirements, permit conditions, and applicable federal and emirate-level instruments. Consult the current official authority publications and the operator legal register, confirm applicability with the compliance or legal owner, and translate requirements into procedures, training, inspections, and records.',
    'technicalExplanation': 'UAE requirements may be federal, emirate-specific, sector-specific, or embedded in permits and operator standards. Do not assume that one emirate’s code automatically applies in another.',
    'practicalExample': 'For an Abu Dhabi project, check the current ADPHC/OSHAD framework and relevant Codes of Practice, alongside federal legislation, environmental approvals, civil defence requirements, and operator procedures as applicable.'
  },
  {
    'question': 'What is the role of Abu Dhabi Public Health Centre (ADPHC) in occupational safety and health?',
    'answer': 'ADPHC is a public health authority in Abu Dhabi with responsibilities that include the Abu Dhabi occupational safety and health system framework. An HSE professional should identify applicable system requirements, Codes of Practice, guidance, and reporting obligations from current official publications and ensure the employer’s arrangements implement them.',
    'technicalExplanation': 'Use the current official ADPHC materials and the organisation’s legal register for exact titles, versions, applicability, and mandatory wording. Historical OSHAD references may appear in older documents; verify current institutional naming and documents.',
    'practicalExample': 'Before developing an excavation procedure for an Abu Dhabi site, confirm the currently applicable excavation CoP, permit requirements, utility coordination, competent-person duties, and operator-specific controls.'
  },
  {
    'question': 'How would you explain the difference between UAE federal requirements and Abu Dhabi or Dubai requirements?',
    'answer': 'Federal instruments establish requirements applicable at the federal level within their scope. Emirate authorities may issue additional local requirements, codes, permits, or enforcement arrangements for activities under their jurisdiction. The employer must determine the complete set that applies and meet all relevant obligations, including stricter operator or client requirements where contractually applicable.',
    'technicalExplanation': 'Avoid assuming that a company standard replaces legislation or that a local code applies nationwide. Applicability depends on jurisdiction, activity, entity, and current legal instruments.',
    'practicalExample': 'A contractor working in Abu Dhabi and Dubai maintains a jurisdiction-specific legal register and task procedures rather than using one unverified checklist for both sites.'
  },
  {
    'question': 'What is the importance of the UAE Labour Law for HSE?',
    'answer': 'The UAE labour framework includes employer and worker obligations relevant to occupational safety, health, welfare, and workplace conditions. An HSE professional should consult the current official legislation and implementing decisions, understand which provisions apply to the employment relationship and sector, and ensure company procedures and records reflect those obligations.',
    'technicalExplanation': 'Do not rely on remembered article numbers or outdated summaries. Confirm current text, amendments, exemptions, and implementing rules through official UAE government sources or competent legal advice.',
    'practicalExample': 'When reviewing heat-stress arrangements, check current applicable ministerial decisions and official announcements for the relevant year, then align work planning, worker communication, and records accordingly.'
  },
  {
    'question': 'How do you manage UAE summer heat-stress compliance?',
    'answer': 'Identify the current year’s applicable midday-work restriction and any scope or exemption conditions from official UAE sources, then implement the employer’s heat-stress programme: work planning, shade and recovery arrangements, drinking water, acclimatisation, training, symptom recognition, emergency response, and records. Confirm site and sector-specific requirements before scheduling outdoor work.',
    'technicalExplanation': 'Dates, hours, exemptions, and enforcement details can change by year and official decision. Never quote an old season’s dates as current without verification.',
    'practicalExample': 'Before summer work planning, HSE verifies the current official restriction, maps outdoor tasks, adjusts schedules, briefs supervisors, and checks welfare and heat-illness response readiness.'
  },
  {
    'question': 'What should you know about UAE fire and life-safety requirements?',
    'answer': 'Identify the applicable UAE Fire and Life Safety Code, civil defence or competent authority requirements, building or facility approvals, and operator fire-protection standards. Confirm that fire detection, alarm, suppression, access, evacuation, maintenance, and emergency plans meet the requirements applicable to the specific facility and activity.',
    'technicalExplanation': 'The applicable edition, amendments, authority approvals, and sector-specific rules must be confirmed from current official sources and the facility’s approved fire strategy.',
    'practicalExample': 'For temporary project accommodation, verify approved occupancy and escape routes, alarm and extinguisher provisions, inspection records, and coordination with the responsible authority.'
  },
  {
    'question': 'How do environmental permits and waste requirements affect Oil & Gas work?',
    'answer': 'Identify the environmental authority and permit conditions for the site, including waste classification, storage, transport, treatment, discharge, emissions, spill reporting, and monitoring. Use approved contractors and authorised disposal routes, retain required manifests and monitoring records, and report deviations through the site and authority channels when applicable.',
    'technicalExplanation': 'Requirements differ by emirate, facility, waste type, and permit. A waste contractor’s presence alone does not prove that a disposal route is authorised.',
    'practicalExample': 'Before removing contaminated absorbents or oily sludge, confirm classification, approved packaging, labels, temporary storage, authorised transporter, receiving facility, and transfer documentation.'
  },
  {
    'question': 'What is the role of a client or operator HSE standard compared with law?',
    'answer': 'Law and authority requirements establish binding obligations within their scope. Client and operator standards may add contractual or operational controls. The project should maintain a requirements register, identify conflicts, obtain competent interpretation, and implement the applicable legal obligations and approved project requirements without treating a company standard as permission to breach law.',
    'technicalExplanation': 'Where requirements differ, consult the contract, legal register, authority conditions, and authorised technical or legal personnel. Do not independently choose a lower standard.',
    'practicalExample': 'A client requires additional lifting assurance beyond the minimum legal framework. The contractor incorporates that requirement into lift planning and verification while still meeting all applicable law.'
  },
  {
    'question': 'How should an HSE Officer respond to an authority inspection?',
    'answer': 'Notify the designated site representative, cooperate professionally, provide accurate controlled records, accompany inspectors as required, answer within your competence, and avoid speculation or altering documents. Record observations and requests, escalate potential non-compliance promptly, and manage corrective actions with accountable owners and evidence of closure.',
    'technicalExplanation': 'Follow the organisation’s protocol for regulatory communications and document control. Never conceal an incident, fabricate a record, or obstruct an authorised inspection.',
    'practicalExample': 'If an inspector asks for a permit and training record, retrieve the controlled current documents, explain any known gap transparently, and coordinate the formal response and corrective action.'
  },
  {
    'question': 'How do you keep an HSE legal register current?',
    'answer': 'Assign an accountable owner, identify official sources and applicable jurisdictions, monitor amendments and new instruments, assess applicability and compliance status, assign actions, communicate changes to affected functions, and periodically verify implementation. Retain revision history and evidence of review.',
    'technicalExplanation': 'A list of law titles is insufficient. The register should connect each applicable obligation to an operational control, owner, evidence, and review status.',
    'practicalExample': 'When an authority updates a relevant code, the compliance owner screens the change, updates the register, assigns procedure and training revisions, and verifies site implementation.'
  },
  {
    'question': 'What is the safest way to answer an interview question asking for an exact UAE legal limit you do not remember?',
    'answer': 'Be honest. Explain the control principle and state that you would verify the current official requirement, its applicability, and the operator’s procedure before giving or applying an exact value. Do not guess a number or present international guidance as UAE law.',
    'technicalExplanation': 'Regulatory thresholds and editions may change. Professional competence includes knowing how to locate authoritative current requirements and recognise the limits of one’s knowledge.',
    'practicalExample': 'For a question about a heat restriction or gas-test acceptance criterion, describe the verification route and explain that the permit and current authority or facility procedure govern the task.'
  },
  {
    'question': 'How do you distinguish official UAE requirements from international good practice?',
    'answer': 'Identify the source, issuing body, jurisdiction, document status, edition, and whether it is legislation, an authority code, a permit condition, a contract standard, or voluntary guidance. Label supplementary standards clearly and use them only where adopted or appropriate, without misrepresenting them as UAE legal obligations.',
    'technicalExplanation': 'International standards can inform engineering and management practice, but legal applicability depends on adoption, reference, contract, or authority requirement. Maintain traceable references.',
    'practicalExample': 'A procedure may cite an adopted standard for equipment selection while separately identifying the applicable UAE and emirate obligations and operator requirements.'
  },
  {
    'question': 'What records help demonstrate HSE compliance in a UAE Oil & Gas project?',
    'answer': 'Depending on applicable requirements, maintain controlled policies and procedures, risk assessments, permits, isolation records, competency evidence, inspections, equipment certificates, monitoring results, incident notifications and investigations, emergency drills, waste and environmental records, audit findings, and corrective-action evidence. Ensure records are accurate, accessible, protected, and retained for the required period.',
    'technicalExplanation': 'Record type, retention period, language, submission route, and authority notification deadlines must be confirmed from current law, permit conditions, and operator procedures.',
    'practicalExample': 'For a lifting audit, retrieve the approved lift plan, equipment and accessory inspection evidence, personnel competence, permit or work authorisation, pre-lift briefing, and closeout record.'
  },
  {
    'question': 'How would you verify whether an Abu Dhabi CoP applies to a specific task?',
    'answer': 'Identify the task and workplace, consult the current official ADPHC OSH system and CoP registry, check the CoP scope and definitions, confirm employer and sector applicability, and compare it with the site legal register and operator standards. Ask the compliance owner or authority for clarification where scope is uncertain.',
    'technicalExplanation': 'CoP numbering, titles, revisions, and applicability should be verified from the current official registry. Do not rely solely on copied lists or older training material.',
    'practicalExample': 'For scaffold work, verify the current scaffolding CoP and related work-at-height requirements, then confirm competent-person inspection and tagging arrangements in the site procedure.'
  },
  {
    'question': 'What should you do if a site procedure appears inconsistent with an authority requirement?',
    'answer': 'Pause the affected activity if compliance or safety is uncertain, preserve the current condition, notify the responsible manager and compliance or legal function, verify the official requirement and applicability, and obtain an approved procedure correction or formal direction before proceeding. Communicate the resolution and update training and records.',
    'technicalExplanation': 'Do not resolve a legal conflict informally at the workface or select the less demanding interpretation without authority. Document the assessment and approval trail.',
    'practicalExample': 'A work instruction references an outdated requirement. The supervisor holds the affected work, compliance verifies the current source, and the controlled instruction is revised and re-briefed.'
  },
  {
    'question': 'How do you confirm ADOSH or other UAE requirements apply to a site?',
    'answer': 'Identify emirate, sector, asset owner, activity and contractual requirements; consult current official regulations, codes and operator procedures; confirm applicability with the responsible compliance or HSE function; maintain a controlled legal register.',
    'technicalExplanation': 'Requirements can differ by emirate, sector and facility. Do not assume an ADOSH instrument applies identically to every UAE site or substitutes for operator standards.',
    'practicalExample': 'For an Abu Dhabi project, the HSE team checks current ADPHC/ADOSH instruments and project obligations, records applicable clauses and communicates them in procedures and audits.',
  },
  {
    'question': 'How do you manage a conflict between a company procedure and a legal requirement?',
    'answer': 'Stop and clarify the conflict with the compliance owner, legal or competent authority. Apply the legally required minimum and any stricter applicable approved control; do not independently waive either requirement.',
    'technicalExplanation': 'Resolve conflicts through documented interpretation and controlled revision. Confirm jurisdiction, scope, effective date and any regulator or client direction.',
    'practicalExample': 'A corporate procedure appears less stringent than an applicable local requirement. The team escalates, applies the compliant control and updates the controlled procedure and briefing.',
  },
  {
    'question': 'What evidence would you prepare for an HSE authority inspection?',
    'answer': 'Provide controlled applicable permits and approvals, risk assessments, training and competency records, inspection and maintenance evidence, incident and corrective-action records, emergency arrangements and site verification, as requested.',
    'technicalExplanation': 'Evidence must be current, traceable, consistent with field conditions and shared through authorised channels. Protect personal and commercially sensitive information.',
    'practicalExample': 'During an inspection, the HSE representative retrieves the current permit, gas-test log, equipment certificate and action closure evidence, then accompanies the inspector for field verification.',
  },
  {
    'question': 'How do you keep an UAE HSE legal register current?',
    'answer': 'Assign an owner, identify applicable jurisdictions and instruments, monitor official updates, assess applicability and impact, update controlled documents, brief affected personnel and retain review evidence.',
    'technicalExplanation': 'A legal register is useful only when obligations are translated into operational controls, owners, records and assurance checks. Verify effective dates and superseded editions.',
    'practicalExample': 'A new applicable code is identified. Compliance reviews affected procedures and training, assigns actions and verifies implementation during site inspection.',
  },
  {
    'question': 'How do you respond to an authority-issued nonconformance?',
    'answer': 'Understand the cited requirement and evidence, make the immediate condition safe, notify management, investigate causes, prepare a corrective-action plan with owners and dates, submit through authorised channels and verify closure.',
    'technicalExplanation': 'Do not conceal or alter records. Escalate deadlines and communicate transparently while ensuring corrective actions address systemic causes and prevent recurrence.',
    'practicalExample': 'An inspection identifies incomplete equipment inspection records. The team secures affected equipment as needed, reconstructs only verifiable records, corrects the control process and provides evidence of completion.',
  },
];
