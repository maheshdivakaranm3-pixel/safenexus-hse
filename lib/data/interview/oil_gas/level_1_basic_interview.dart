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
  ];
}
