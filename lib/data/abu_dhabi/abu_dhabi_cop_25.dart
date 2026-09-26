// SafeNexus HSE — Abu Dhabi HSE Reference
// CoP 25.0 — Driver Fatigue Prevention — maximum-detail field handbook content.
// Official ADPHC / ADOSH-SF: Version 4.0 — effective 15 July 2024.
//
// Content only. Existing SafeNexus UI/navigation architecture is unchanged.
// Technical/legal limits are included only where stated by the official CoP.
// Do not treat examples as substitutes for applicable UAE/Abu Dhabi transport laws.

import 'abu_dhabi_cop_01_to_03.dart';

class AbuDhabiCop25 {
  static const List<AbuDhabiCopDocument> documents = [
    cop250,
  ];

  static const cop250 = AbuDhabiCopDocument(
    code: 'CoP 25.0',
    title: 'Driver Fatigue Prevention',
    version: '4.0',
    effectiveDate: '15 July 2024',
    introduction:
        'CoP 25.0 establishes Abu Dhabi occupational safety and health requirements for preventing driver fatigue and reducing fatigue-related driving incidents. It applies to employers and places of business in Abu Dhabi and covers drivers, schedulers, the Responsible Person, fatigue-risk management, training, schedules and rosters, employer-supplied accommodation for night workers, and record keeping.',
    sections: [
      AbuDhabiCopSection(
        number: '1.0',
        title: 'Purpose, Scope and Regulatory Basis',
        requirements: [
        'Apply CoP 25.0 to all employers and places of business within the Emirate of Abu Dhabi where commercial driving is undertaken for business purposes.',
        'Use the Code as the minimum Abu Dhabi OSH framework for reducing fatigue-related driving incidents and managing fatigue risk.',
        'Where another competent regulatory authority establishes a conflicting requirement, apply the more stringent applicable requirement.',
        'Integrate driver-fatigue controls with the entity\'s wider OSH management system, transport arrangements, traffic management and occupational-health processes.',
        'Include employees who drive regularly or occasionally for business purposes; the definition of driver is not limited to professional full-time drivers.',
        'Example: A construction company has employees who occasionally drive company pickups between projects. They fall within the business-driving scope even if driving is not their primary job.',
        'Field check: confirm the company knows which workers may drive for work and that the FRMP covers them.',
      ],
        measurements: [
        'Night Time: 00:00 to 05:00.',
        'Night Worker: a person who works 2 hours or more during the Night Time period.',
        'Working hours include driving and associated duties such as loading, unloading, cleaning, repair and inspection.',
        'Break: continuous uninterrupted time used exclusively for recuperation, with no driving or other work duties.',
        'Rest: continuous uninterrupted time that the person may freely dispose of; rest is not work and is not a break performed during work.',
      ],
        documents: [
        'Fatigue Risk Management Program (FRMP).',
        'Fatigue management policy.',
        'Driver schedules and rosters.',
        'Occupational health / fitness-for-work process.',
        'Training and fatigue-risk education records.',
      ],
        hazards: [
        'Fatigue-related impaired driving.',
        'Night driving and circadian disruption.',
        'Long or poorly planned duty periods.',
        'Loading/unloading or other work extending the duty period.',
        'Insufficient recovery sleep.',
        'Fatigue compounded by medicines, alcohol or other substances.',
      ],
        controls: [
        'Identify fatigue hazards through risk assessment.',
        'Design schedules and rosters to provide adequate rest.',
        'Provide fatigue education and reporting arrangements.',
        'Assess driver fitness for work.',
        'Monitor controls and investigate fatigue-related incidents.',
      ],
        inspection: [
        'Review schedules and rosters against applicable legal/transport-sector working-time requirements.',
        'Verify driver fatigue education records.',
        'Review fatigue reports and corrective actions.',
        'Audit FRMP implementation.',
      ],
      ),
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Key Definitions for Field Use',
        requirements: [
        'Use a common fatigue vocabulary so drivers, schedulers, supervisors and HSE personnel make consistent decisions.',
        'Treat fatigue as a potential impairment issue rather than simply a feeling of being tired.',
        'Recognize that working hours include non-driving work that can extend the total duty period and reduce recovery opportunity.',
        'Use the terms schedule and roster correctly: a schedule plans trips/tasks; a roster plans the pattern of work and rest over a defined period.',
      ],
        measurements: [
        'Night Time = 00:00–05:00.',
        'Night Worker = 2 hours or more worked during Night Time.',
        'Working hours include associated non-driving duties.',
        'A roster normally covers a defined period such as a week or more.',
      ],
        documents: [
        'FRMP.',
        'Responsible Person.',
        'Scheduler.',
        'Roster.',
        'Schedule.',
        'Rest.',
        'Break.',
        'Fatigue impairment.',
      ],
        hazards: [
        'Confusing a short work break with genuine off-duty rest.',
        'Counting loading/unloading as if it were personal recovery time.',
        'Ignoring occasional business drivers.',
        'Treating fatigue as only a night-shift problem.',
      ],
        controls: [
        'Use the definitions in induction, toolbox talks, scheduling procedures and incident investigations.',
        'Make records and forms use the same terminology.',
      ],
        inspection: [
        'Audit forms and procedures for consistent terminology.',
        'Review whether driver-hour records capture associated duties, not only steering time.',
      ],
      ),
      AbuDhabiCopSection(
        number: '3.0',
        title: 'Training and Competency',
        requirements: [
        'Ensure OSH training aligns with ADOSH-SF Element 5 and the applicable practitioner/service-provider requirements referenced by the CoP.',
        'Ensure every person has sufficient competence for the fatigue responsibilities assigned to them.',
        'Document the fatigue-risk education program.',
        'Provide suitable and sufficient information and training to people with FRMP responsibilities.',
        'Include drivers, the Responsible Person and schedulers in the fatigue-risk education program.',
        'Provide refresher training at appropriate intervals and repeat the core fatigue-risk topics.',
      ],
        measurements: [
        'Training records must include name and ID number, Emirates ID number, training subject(s), training date(s) and training provider.',
      ],
        documents: [
        'Fatigue-risk education program.',
        'Driver induction / refresher training.',
        'Scheduler and Responsible Person competency records.',
        'Attendance and assessment evidence.',
      ],
        hazards: [
        'Failure to recognize fatigue signs.',
        'Failure to report suspected impairment.',
        'Poor understanding of medicine/substance effects.',
        'Inadequate understanding of lifestyle and health contributors.',
      ],
        controls: [
        'Train drivers to identify signs of fatigue and understand its safety consequences.',
        'Train drivers on medicines and substances, including alcohol, that may affect fatigue.',
        'Train drivers on when/how to report suspected fatigue and the action to take.',
        'Cover lifestyle and health factors that influence fatigue.',
        'Cover fatigue-prevention procedures and incident reporting.',
      ],
        inspection: [
        'Check competence, not just attendance.',
        'Provide refresher training when appropriate and when gaps are identified.',
        'Keep training evidence systematically.',
      ],
      ),
      AbuDhabiCopSection(
        number: '4.0',
        title: 'Driver Responsibilities and Fitness for Driving',
        requirements: [
        'Drivers must not drive or continue driving a commercial vehicle while impaired, or likely to be impaired, by fatigue.',
        'A driver who believes they are impaired or likely to be impaired must report this to the entity\'s Responsible Person.',
        'Use a non-punitive reporting route so a driver can raise fatigue concerns before an incident occurs.',
        'Ensure drivers understand that declaring fatigue is a safety control, not permission to continue driving while impaired.',
      ],
        measurements: [
        'Fitness-for-work arrangements must align with the employer\'s occupational-health process and CoP 5.0 where applicable.',
      ],
        documents: [
        'Driver fatigue reporting procedure.',
        'Fitness-for-work process.',
        'Escalation/contact list.',
        'Driver induction acknowledgement.',
      ],
        hazards: [
        'Sleepiness.',
        'Reduced alertness.',
        'Slower reactions.',
        'Difficulty maintaining attention.',
        'Fatigue combined with medication, alcohol or other substances.',
      ],
        controls: [
        'Stop the unsafe driving task when fatigue impairment is identified.',
        'Notify the Responsible Person.',
        'Arrange an appropriate safe response such as relief, rest or rescheduling according to the FRMP and applicable requirements.',
      ],
        inspection: [
        'Supervisors should review fatigue declarations and ensure corrective action is taken.',
        'Do not treat a fatigue report as a reason to pressure the driver to continue.',
      ],
      ),
      AbuDhabiCopSection(
        number: '5.0',
        title: 'Employer Responsibilities',
        requirements: [
        'Take reasonable steps to ensure business practices and policies do not cause drivers to drive while fatigue-impaired.',
        'Take reasonable steps to ensure drivers are not required to work in breach of applicable working-hours or rest requirements.',
        'Establish, document and implement a suitable and sufficient FRMP.',
        'Appoint a competent Responsible Person to manage the FRMP.',
        'Provide a process to ensure drivers are fit to perform work and receive required medical assessment in accordance with CoP 5.0.',
      ],
        measurements: [
        'FRMP effectiveness should be monitored and corrective actions implemented where controls are not adequate.',
      ],
        documents: [
        'FRMP.',
        'Responsible Person appointment.',
        'Fitness-for-work process.',
        'Training program.',
        'Audit and inspection program.',
      ],
        hazards: [
        'Production or delivery pressure.',
        'Poor scheduling.',
        'Insufficient resources.',
        'Inadequate relief arrangements.',
        'Failure to respond to fatigue reports.',
      ],
        controls: [
        'Resource the FRMP.',
        'Identify fatigue risks and controls.',
        'Provide training.',
        'Investigate fatigue-related incidents.',
        'Audit and inspect controls.',
      ],
        inspection: [
        'Review management decisions that may create fatigue risk.',
        'Track corrective actions to closure.',
      ],
      ),
      AbuDhabiCopSection(
        number: '6.0',
        title: 'Responsible Person and Scheduler Responsibilities',
        requirements: [
        'The Responsible Person oversees and manages implementation of the FRMP using appropriate training and experience.',
        'The Scheduler must take reasonable steps to ensure schedules and rosters do not cause fatigue-impaired driving or breach applicable working/rest requirements.',
        'The Scheduler must consider all other work duties assigned to the driver.',
        'The Scheduler must consider reasonably expected traffic, loading, unloading and other delays.',
        'No person may direct, coerce or require a driver to perform work that they know or reasonably should know would cause unsafe fatigue or breach applicable requirements.',
      ],
        measurements: [
        'Schedule planning must allow for foreseeable operational delays rather than assuming ideal travel conditions.',
      ],
        documents: [
        'Responsible Person appointment.',
        'Roster approval workflow.',
        'Schedule planning procedure.',
        'Escalation process for schedule changes.',
      ],
        hazards: [
        'Unrealistic delivery deadlines.',
        'Unexpected traffic delay.',
        'Loading/unloading delay.',
        'Additional site duties after driving.',
        'Pressure from supervisors or customers.',
      ],
        controls: [
        'Build realistic schedules.',
        'Provide escalation when a schedule cannot be safely achieved.',
        'Re-plan after significant deviations.',
        'Ensure relief/alternative arrangements are available where required.',
      ],
        inspection: [
        'Audit schedules against actual duty patterns.',
        'Review repeated overruns as a systemic issue.',
      ],
      ),
      AbuDhabiCopSection(
        number: '7.0',
        title: 'Fatigue Risk Management Program (FRMP)',
        requirements: [
        'Each entity employing or procuring driver services must develop, document and implement a suitable and sufficient FRMP.',
        'The FRMP must demonstrate identification of fatigue risk factors and implementation of appropriate controls.',
        'The FRMP must monitor the effectiveness of controls and introduce corrective actions where necessary.',
        'Include a fatigue management policy.',
        'Include a fatigue risk identification, assessment and control process consistent with ADOSH-SF Element 2 Risk Management.',
        'Include a documented fatigue-risk education program.',
        'Include investigation and reporting of driving-fatigue incidents in accordance with the applicable incident mechanism.',
        'Include audit and inspection of fatigue controls in accordance with the applicable ADOSH-SF requirements.',
        'Integrate relevant CoP 44.0 Traffic Management and Logistics requirements.',
        'At minimum, include driver-duty scheduling controls and controls addressing night-worker accommodation.',
      ],
        measurements: [
        'Use a documented risk-based approach rather than relying only on driver self-management.',
      ],
        documents: [
        'FRMP manual/procedure.',
        'Fatigue risk assessments.',
        'Fatigue policy.',
        'Training program.',
        'Incident investigation process.',
        'Audit/inspection program.',
        'Roster controls.',
        'Accommodation controls for night workers.',
      ],
        hazards: [
        'Unidentified fatigue hazards.',
        'Controls not implemented.',
        'Controls not monitored.',
        'Corrective actions not closed.',
      ],
        controls: [
        'Plan → identify risk → assess risk → select controls → implement → monitor → correct → review.',
      ],
        inspection: [
        'Audit FRMP implementation.',
        'Review fatigue indicators and incidents.',
        'Reassess after significant changes to routes, shifts, staffing or transport operations.',
      ],
      ),
      AbuDhabiCopSection(
        number: '8.0',
        title: 'Fatigue Management Policy',
        requirements: [
        'Obtain top-management approval for the fatigue management policy.',
        'Document the policy and make it available to interested parties.',
        'Nominate a Responsible Person to oversee FRMP requirements.',
        'Commit sufficient resources to fatigue management.',
        'Commit to identifying and reducing fatigue risks.',
        'Ensure appropriate fatigue controls are identified and implemented.',
        'Provide suitable and sufficient training.',
        'Ensure fatigue-related incidents are investigated for possible fatigue contribution.',
        'Assess driver fitness for work.',
      ],
        measurements: [
        'Policy should clearly connect management commitment with the operational FRMP.',
      ],
        documents: [
        'Signed/approved fatigue policy.',
        'FRMP responsibilities matrix.',
        'Management review evidence.',
      ],
        hazards: [
        'Policy exists but is not implemented.',
        'No accountable person.',
        'No resources.',
        'No incident learning.',
      ],
        controls: [
        'Communicate the policy to drivers, schedulers, supervisors and relevant contractors.',
        'Review the policy when significant operational changes occur.',
      ],
        inspection: [
        'Check approval, availability and implementation during audit.',
      ],
      ),
      AbuDhabiCopSection(
        number: '9.0',
        title: 'Schedules and Rosters — Core Controls',
        requirements: [
        'Organize schedules and rosters in accordance with applicable legal and regulatory working-hour requirements for the relevant transport operation.',
        'Ensure schedules provide adequate opportunity for rest.',
        'Minimize periods of night driving where practicable.',
        'Avoid departures before 05:00 as a fatigue-risk reduction measure identified by the CoP.',
        'Plan flexible schedules that allow driving and breaks at appropriate times and locations.',
        'Split trips into shorter continuous driving periods between breaks where appropriate.',
        'Consult drivers or their representatives when developing schedules.',
        'Allow flexibility for unforeseen circumstances that require schedule changes.',
        'Require drivers to follow agreed schedules rather than rush to complete tasks sooner.',
        'Allow sufficient time for rest and acclimatization when drivers significantly change shift patterns, such as moving between day and night work.',
        'Establish corrective-action and re-scheduling procedures when actual work departs from the planned schedule.',
        'Apply the same fatigue scheduling principles to part-time, relief and contracted drivers.',
      ],
        measurements: [
        '05:00 is the specific departure-time consideration stated in the CoP; it is not a substitute for applicable legal working/rest limits.',
        'Night Time is defined by the CoP as 00:00–05:00.',
      ],
        documents: [
        'Roster.',
        'Trip schedule.',
        'Break plan.',
        'Deviation/rescheduling process.',
        'Driver consultation record.',
      ],
        hazards: [
        'Early starts.',
        'Night driving.',
        'Continuous long trips.',
        'Unplanned delays.',
        'Schedule pressure.',
      ],
        controls: [
        'Use realistic trip times.',
        'Provide recovery opportunity.',
        'Re-plan when actual conditions invalidate the original plan.',
        'Do not solve delays by instructing unsafe driving.',
      ],
        inspection: [
        'Compare planned vs actual duty patterns.',
        'Identify repeated schedule deviations and root causes.',
      ],
      ),
      AbuDhabiCopSection(
        number: '10.0',
        title: 'Roster Design for Sleep and Recovery',
        requirements: [
        'Arrange rosters to maximize the opportunity for good-quality sleep and recovery.',
        'Keep rosters as regular as reasonably practicable.',
        'Where non-regular or alternating rosters are necessary, plan start times to move forwards in time rather than backwards where possible.',
        'When drivers return from leave or another absence, allow time to adapt to longer working hours or night work, starting with day rosters where possible.',
      ],
        measurements: [
        'Roster design should consider the driver\'s recovery opportunity, not only the total number of driving tasks.',
      ],
        documents: [
        'Roster pattern.',
        'Shift-change plan.',
        'Return-from-leave plan.',
        'Fatigue risk assessment.',
      ],
        hazards: [
        'Rapid shift changes.',
        'Backward rotation.',
        'Abrupt transition to night work.',
        'Insufficient recovery after absence.',
      ],
        controls: [
        'Use predictable roster patterns.',
        'Provide adaptation time after significant changes.',
        'Review repeated fatigue reports associated with particular roster patterns.',
      ],
        inspection: [
        'Review rosters periodically and after fatigue incidents.',
      ],
      ),
      AbuDhabiCopSection(
        number: '11.0',
        title: 'Night Driving and Night Worker Management',
        requirements: [
        'Identify drivers who work during the CoP-defined Night Time period.',
        'Manage the additional fatigue risk associated with night work through the FRMP.',
        'Minimize night driving where practicable when scheduling work.',
        'Ensure night workers have accommodation arrangements that support adequate rest when employer accommodation is provided.',
        'Consider light, noise, room sharing, maintenance activities and thermal comfort when assessing night-worker accommodation.',
      ],
        measurements: [
        'Night Time = 00:00–05:00.',
        'A Night Worker works 2 hours or more during this Night Time period.',
      ],
        documents: [
        'Night-work roster.',
        'Night-worker accommodation assessment.',
        'Accommodation controls under CoP 18.0.',
      ],
        hazards: [
        'Light penetration into sleeping areas.',
        'Noise from other occupants.',
        'Day workers disturbing night workers.',
        'Cleaning/maintenance disturbance.',
        'Poor thermal comfort.',
      ],
        controls: [
        'Use suitable window coverings.',
        'Organize shared rooms to reduce disturbance.',
        'Plan cleaning and maintenance to avoid disturbing sleeping night workers.',
        'Reduce accommodation noise.',
        'Maintain suitable thermal comfort.',
      ],
        inspection: [
        'Inspect accommodation and review night-worker feedback.',
      ],
      ),
      AbuDhabiCopSection(
        number: '12.0',
        title: 'Employer-Supplied Accommodation Interface',
        requirements: [
        'Ensure employer-provided accommodation complies with CoP 18.0 General Requirements.',
        'Take reasonable steps to account for night workers\' needs and facilitate adequate rest.',
        'Assess accommodation suitability for light, room sharing, cleaning/maintenance, noise and thermal comfort.',
        'Coordinate accommodation controls with the FRMP when night work is part of the transport operation.',
      ],
        measurements: [
        'Use the CoP 18.0 requirements as the accommodation baseline; do not create substitute limits that are not supported by the applicable authority.',
      ],
        documents: [
        'Accommodation inspection checklist.',
        'Room allocation plan.',
        'Maintenance schedule.',
        'Noise/light/thermal-comfort corrective actions.',
      ],
        hazards: [
        'Sleep disruption.',
        'Inadequate room allocation.',
        'Maintenance disturbance.',
        'Excessive noise.',
        'Unsuitable thermal conditions.',
      ],
        controls: [
        'Control light penetration.',
        'Control room sharing.',
        'Schedule maintenance to minimize disturbance.',
        'Reduce avoidable noise.',
        'Maintain thermal comfort.',
      ],
        inspection: [
        'Inspect accommodation and track complaints/corrective actions.',
      ],
      ),
      AbuDhabiCopSection(
        number: '13.0',
        title: 'Fatigue Risk Factors — Field Assessment',
        requirements: [
        'Identify fatigue risks arising from the total work system, not only driving time.',
        'Consider driving time together with loading, unloading, inspection, cleaning, repair and other assigned duties.',
        'Consider night work, shift changes, route delays and operational pressure.',
        'Consider health, lifestyle and medicine/substance factors through appropriate education and fitness-for-work arrangements.',
        'Use incident and schedule-deviation information to identify recurring fatigue patterns.',
      ],
        measurements: [
        'Working hours include associated non-driving duties under the CoP.',
      ],
        documents: [
        'Fatigue risk assessment.',
        'Driver feedback.',
        'Schedule/deviation data.',
        'Incident records.',
      ],
        hazards: [
        'Long total duty time.',
        'Night work.',
        'Shift changes.',
        'Additional physical work before/after driving.',
        'Unexpected delays.',
      ],
        controls: [
        'Eliminate or reduce avoidable workload.',
        'Improve schedule realism.',
        'Provide recovery opportunities.',
        'Use reporting and corrective action.',
      ],
        inspection: [
        'Review risk assessments after significant operational change or recurring fatigue events.',
      ],
      ),
      AbuDhabiCopSection(
        number: '14.0',
        title: 'Fatigue Reporting, Incident Investigation and Corrective Action',
        requirements: [
        'Provide a clear method for drivers to report actual or suspected fatigue impairment.',
        'Ensure reports are escalated to the Responsible Person or designated process.',
        'Investigate driving incidents and determine whether fatigue may have been an influencing factor.',
        'Use incident findings to improve schedules, rosters, training, accommodation or other controls.',
        'Implement corrective actions where monitoring shows controls are ineffective.',
      ],
        measurements: [
        'FRMP incident reporting should interface with the applicable ADOSH-SF incident notification, investigation and reporting mechanism.',
      ],
        documents: [
        'Fatigue report form.',
        'Incident investigation procedure.',
        'Corrective-action register.',
        'FRMP review.',
      ],
        hazards: [
        'Under-reporting.',
        'Pressure to continue driving.',
        'Repeated schedule failures.',
        'Recurring incidents with similar fatigue contributors.',
      ],
        controls: [
        'Encourage early reporting.',
        'Protect the reporting route from unsafe pressure.',
        'Investigate system causes, not only driver behavior.',
        'Track corrective actions to closure.',
      ],
        inspection: [
        'Trend fatigue reports and schedule deviations.',
        'Review whether corrective actions actually reduce recurrence.',
      ],
      ),
      AbuDhabiCopSection(
        number: '15.0',
        title: 'Record Keeping and Driver Working-Hours Records',
        requirements: [
        'Require drivers to keep records of working hours, including driving, breaks and non-work time such as rest days.',
        'Maintain records in accordance with applicable transport-sector regulations and other legal requirements.',
        'The Responsible Person must ensure there is a clear and systematic record for each driver within the entity.',
        'Retain required training records for at least 5 years.',
        'Ensure records are legible, traceable and available for review.',
      ],
        measurements: [
        'Training-record retention minimum: 5 years under CoP 25.0.',
        'Driver working-hour records must also follow applicable authority/transport-sector retention requirements.',
      ],
        documents: [
        'Driver duty records.',
        'Driving records.',
        'Break/rest records.',
        'Training records.',
        'FRMP records.',
      ],
        hazards: [
        'Missing records.',
        'Incomplete duty information.',
        'Records that show only driving and omit associated work.',
        'Untraceable training.',
      ],
        controls: [
        'Use a consistent record format.',
        'Review records for completeness.',
        'Protect records from loss or unauthorized alteration.',
      ],
        inspection: [
        'Periodic record audits by the Responsible Person.',
      ],
      ),
      AbuDhabiCopSection(
        number: '16.0',
        title: 'Monitoring, Audit and Continual Improvement',
        requirements: [
        'Establish monitoring and audit arrangements within the FRMP.',
        'Verify that fatigue controls are implemented as planned.',
        'Review schedule and roster performance against actual operations.',
        'Review training, fatigue reports, incidents, accommodation controls and corrective actions.',
        'Introduce corrective action where controls are ineffective.',
        'Reassess the FRMP when transport operations, routes, shifts, workforce or other significant conditions change.',
      ],
        measurements: [
        'Use evidence from records, interviews, inspections and incident investigations rather than relying on a single indicator.',
      ],
        documents: [
        'Audit checklist.',
        'FRMP review.',
        'Management review.',
        'Corrective-action register.',
      ],
        hazards: [
        'Paper compliance without field implementation.',
        'Repeated unresolved schedule deviations.',
        'Recurring fatigue reports.',
      ],
        controls: [
        'Combine document review with driver/scheduler interviews and operational sampling.',
        'Close findings and verify effectiveness.',
      ],
        inspection: [
        'Audit periodically and after significant fatigue-related events or changes.',
      ],
      ),
      AbuDhabiCopSection(
        number: '17.0',
        title: 'Field HSE / Supervisor Checklist',
        requirements: [
        'Confirm the driver is fit for the assigned driving task.',
        'Confirm the driver knows how to report fatigue and who the Responsible Person is.',
        'Check that the planned schedule provides appropriate rest opportunity.',
        'Check for foreseeable traffic, loading and unloading delays.',
        'Check whether the duty includes significant non-driving work.',
        'Check night-driving and shift-change risks.',
        'Confirm required fatigue training is current.',
        'Verify working-hour and duty records are maintained.',
        'Escalate any condition that could require driving while fatigue-impaired.',
      ],
        measurements: [
        'Use applicable legal/transport-sector working-hour limits; do not replace those limits with an unofficial company number.',
      ],
        documents: [
        'Daily/shift supervisor checklist.',
        'Driver declaration/reporting process.',
        'Roster and schedule.',
      ],
        hazards: [
        'Fatigue impairment.',
        'Schedule pressure.',
        'Unexpected delay.',
        'Night work.',
        'Insufficient recovery.',
      ],
        controls: [
        'Pause unsafe driving.',
        'Notify the Responsible Person.',
        'Re-plan, relieve or otherwise control the task according to the FRMP.',
      ],
        inspection: [
        'Supervisors should record significant fatigue-related interventions and review recurring issues.',
      ],
      ),
      AbuDhabiCopSection(
        number: '18.0',
        title: 'Practical Scenarios and Interview Questions',
        requirements: [
        'Use realistic scenarios to test whether workers understand the FRMP rather than memorizing definitions.',
        'Include drivers, schedulers, supervisors and HSE personnel in scenario-based learning.',
        'Use actual organizational routes, roster patterns and delay conditions when developing exercises.',
      ],
        measurements: [
        'Scenario: driver becomes sleepy before completing a trip.',
        'Scenario: night worker cannot obtain adequate sleep because of accommodation disturbance.',
        'Scenario: delivery is delayed by traffic and loading.',
        'Scenario: roster changes from day to night work.',
        'Scenario: driver is asked to continue despite reporting fatigue.',
      ],
        documents: [
        'Toolbox talk / training record.',
        'Scenario assessment.',
        'Interview checklist.',
      ],
        hazards: [
        'Normalizing fatigue.',
        'Pressure to meet delivery targets.',
        'Failure to escalate.',
        'Poor understanding of rest versus breaks.',
      ],
        controls: [
        'Expected response: report fatigue, prevent unsafe driving, contact the Responsible Person, and apply the FRMP controls.',
      ],
        inspection: [
        'Repeat scenarios where competence gaps are found.',
      ],
      ),    ],
    fieldChecklist: [
      'Confirm the entity has a documented Fatigue Risk Management Program (FRMP).',
      'Confirm a competent Responsible Person has been appointed to manage the FRMP.',
      'Confirm drivers, the Responsible Person and schedulers receive documented fatigue-risk education.',
      'Confirm drivers know the signs of fatigue and the reporting/escalation process.',
      'Confirm drivers do not drive or continue driving while impaired or likely to be impaired by fatigue.',
      'Review schedules and rosters for adequate rest opportunity and foreseeable delays.',
      'Check that the scheduling process considers non-driving duties such as loading and unloading.',
      'Review night-driving and shift-change risks.',
      'Confirm employer accommodation considers night-worker sleep needs where accommodation is provided.',
      'Check working-hour, driving, break and rest records against applicable legal/transport requirements.',
      'Confirm training records contain the required identification, subject, date and trainer/provider information.',
      'Confirm required training records are retained for at least 5 years.',
      'Review fatigue incidents, reports, audit findings and corrective actions.',
      'Verify FRMP controls are monitored and improved when ineffective.'
    ],
    stopWorkIndicators: [
      'Driver is impaired or likely to be impaired by fatigue.',
      'Driver reports fatigue impairment and is being pressured to continue driving.',
      'Schedule or instruction would require unsafe fatigue-impaired driving.',
      'Schedule or roster creates a known breach of applicable working/rest requirements.',
      'Operational delay is being managed by unsafe rushing instead of re-planning.',
      'A critical fatigue control in the FRMP is absent or ineffective and the driving task cannot be safely controlled.',
    ],
    references: [
      'ADPHC / ADOSH-SF Code of Practice 25.0 — Driver Fatigue Prevention — Version 4.0 — 15 July 2024.',
      'ADPHC Code of Practices registry — CoP 25.0 Driver Fatigue Prevention.',
      'ADOSH-SF Element 1 — Roles, Responsibilities and Self-Regulation.',
      'ADOSH-SF Element 2 — Risk Management.',
      'ADOSH-SF Element 5 — Training, Awareness and Competency.',
      'ADOSH-SF Element 8 — Audit and Inspection.',
      'ADOSH-SF Mechanism 11 — Incident Notification, Investigation and Reporting.',
      'ADOSH-SF CoP 5.0 — Occupational Health Screening and Medical Surveillance.',
      'ADOSH-SF CoP 18.0 — Employer Supplied Accommodation — General Requirements.',
      'ADOSH-SF CoP 44.0 — Traffic Management and Logistics.',
    ],
    verificationNote:
        'Verified against the official ADPHC Code of Practice 25.0 — Driver Fatigue Prevention, Version 4.0, effective 15 July 2024. The field examples are SafeNexus explanatory examples; they do not replace the official Code or other applicable UAE/Abu Dhabi legal and transport-sector requirements.',
    protectionItems: [
      'Fatigue-risk education and awareness.',
      'Fitness-for-work controls.',
      'Safe schedules and rosters.',
      'Adequate rest and recovery opportunity.',
      'Night-worker accommodation controls.',
      'Fatigue reporting and incident investigation.',
    ],
  );
}
