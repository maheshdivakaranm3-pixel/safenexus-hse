// SafeNexus HSE — Abu Dhabi HSE Reference
// CoP 30.0 / CoP 30.1 / CoP 31.0
//
// Official ADPHC registry verified against the current Code of Practices page.
// CoP 30.0 — Lone Working and/or in Remote Locations — Version 4.1
// CoP 30.1 — Working in International Locations — Version 4.0
// CoP 31.0 — Working On, Over or Adjacent to Water — Version 4.1
//
// IMPORTANT:
// - Existing UI/navigation and AbuDhabiCopDocument API are unchanged.
// - SafeNexus content below is paraphrased, field-structured guidance.
// - The official ADPHC CoP remains the controlling regulatory source.
// - Current ADPHC registry does not list CoP 32.0; it proceeds from 31.0 to 33.0.

import 'abu_dhabi_cop_01_to_03.dart';

class AbuDhabiCop30To31 {
  static const List<AbuDhabiCopDocument> documents = [
    cop300,
    cop301,
    cop310,
  ];

  static const cop300 = AbuDhabiCopDocument(
    code: 'CoP 30.0',
    title: 'Lone Working and/or in Remote Locations',
    version: '4.1',
    effectiveDate: '27 February 2026',
    introduction:
        'Applies to employers in Abu Dhabi and addresses workers who work by themselves without close or direct supervision, including isolated, mobile, out-of-hours and remote activities. SafeNexus expands the official structure into practical field planning, communication, emergency and verification guidance.',
    sections: [
      AbuDhabiCopSection(
        number: '1.0',
        title: 'Lone Work Identification and Scope',
        hazards: [
      'Delayed assistance after injury or illness.',
      'Isolation from emergency services.',
      'Exposure to task hazards without immediate support.',
      'Security, assault or unauthorized-access risk.',
      'Communication failure.',
    ]
        requirements: [
      'Identify all activities in which a person may work without close or direct supervision, including fixed locations, isolated areas, out-of-hours work and mobile/remote tasks.',
      'Assess whether other people are actually close enough to provide effective assistance; the mere presence of people elsewhere on a site does not automatically remove lone-working risk.',
      'Consider construction, installation, maintenance, cleaning, electrical repair, lift work, painting, vehicle recovery, service visits, inspection and similar mobile activities.',
      'Identify the work location, duration, travel route, access/egress, environmental conditions, communications, nearest assistance and foreseeable emergencies before authorisation.',
      'Where lone working creates unacceptable residual risk, arrange additional personnel, direct supervision or another work method instead.',
    ]
        documents: [
      'Lone-worker task/register',
      'Task-specific risk assessment',
      'Safe work procedure / method statement',
      'Emergency and communication plan',
    ]
      ),
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Roles, Responsibilities and Management Control',
        requirements: [
      'Employers must identify persons at increased risk from working alone and implement controls proportionate to that risk.',
      'Provide appropriate welfare arrangements and integrate lone-working controls with emergency management, first aid, workplace amenities and heat requirements.',
      'Ensure employees follow the lone-working procedure and promptly report hazards or information that may adversely affect the work.',
      'For construction work, integrate relevant lone-working requirements into the pre-tender safety and health plan and the OSH Construction Management Plan as applicable.',
      'Management must determine the level of supervision; the decision should not be left solely to the lone worker.',
    ]
        documents: [
      'OSH policy/procedure',
      'Pre-tender safety and health plan where applicable',
      'OSH-CMP where applicable',
      'Supervision arrangements',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.0',
        title: 'Training, Competency and Authorization',
        requirements: [
      'Provide task-specific OSH training and include hazards created or increased by lone working.',
      'Training must be delivered in a language appropriate to the workforce and include a competency check.',
      'Do not assign the relevant task to a worker who cannot demonstrate adequate understanding until retraining is completed.',
      'Refresh training when appropriate and when task, equipment, hazard or procedure changes require it.',
      'Verify competency for specialist equipment, permits, isolation, first aid or other task-specific requirements before lone assignment.',
    ]
        documents: [
      'Training record',
      'Competency assessment',
      'Authorization record',
      'Induction record',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.1',
        title: 'Training Record Content',
        requirements: [
      'Maintain records identifying the employee, Emirates ID where required by the CoP, training subject, training date(s) and training provider/person delivering the training.',
      'Link training evidence to the actual task and authorization rather than relying only on general induction.',
    ]
        documents: [
      'Training matrix',
      'Competency records',
      'Refresher-training records',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.2',
        title: 'Planning and Full Risk Assessment',
        requirements: [
      'Evaluate each site or operation using the ADOSH-SF risk-management process.',
      'Where lone working is identified, complete a full risk assessment covering normal work and foreseeable emergencies.',
      'Establish safe systems of work and controls for workers, affected persons and the public.',
      'Review the assessment whenever location, task, equipment, working hours, weather, communication or emergency arrangements change.',
      'Use the hierarchy of controls and first consider whether the need to work alone can be eliminated.',
    ]
        documents: [
      'Risk assessment',
      'Safe system of work',
      'Permit where required',
      'Change/review record',
    ]
        controls: [
      'Eliminate lone work where practicable',
      'Add personnel or supervision for higher-risk work',
      'Engineering/remote-monitoring controls',
      'Administrative/check-in controls',
      'PPE and emergency equipment as additional layers',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.3',
        title: 'Length of Time Working Alone',
        hazards: [
      'Extended isolation',
      'Night or out-of-hours exposure',
      'High-risk task performed without immediate support',
    ]
        requirements: [
      'Determine whether the proposed period alone is reasonable for the task and worker.',
      'Consider whether the task should be performed alone at all, how long the person will actually be isolated, and the time of day.',
      'Check whether legislation, another CoP, a permit or the task risk assessment prohibits or restricts lone work for the activity.',
      'Short duration does not automatically make a high-consequence activity suitable for lone work.',
    ]
        documents: [
      'Work plan',
      'Risk assessment',
      'Permit/authorization',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.4',
        title: 'Remoteness, Isolation and Emergency Access',
        hazards: [
      'Blocked emergency access',
      'Vehicle breakdown',
      'Worker becomes stranded',
      'Delayed medical response',
    ]
        requirements: [
      'Assess whether emergency services can approach sufficiently close to the work location.',
      'Confirm the expected work duration and a clear route for emergency responders.',
      'Provide first-aid access or appropriate portable first-aid equipment for mobile/remote workers.',
      'Confirm transport arrangements to and from the work location.',
      'Treat rarely occupied rooms, storage areas or isolated plant areas as potentially remote even when they are physically inside a main facility.',
    ]
        documents: [
      'Location plan',
      'Journey plan',
      'Emergency access plan',
      'Vehicle/emergency equipment inspection',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.5',
        title: 'Location, Travel and Vehicle Breakdown',
        hazards: [
      'Vehicle failure',
      'Getting lost',
      'Heat exposure',
      'Insufficient water',
      'Unsafe terrain',
    ]
        requirements: [
      'Plan the route, access point, expected arrival and expected completion time.',
      'Check whether transport is required and whether the vehicle is appropriate for the route and terrain.',
      'Where the worker leaves a vehicle, determine which emergency supplies must be carried.',
      'Consider food, drinking water, first-aid equipment and other emergency supplies appropriate to the remote location and duration.',
      'Define the response to vehicle breakdown, immobilisation or loss of communication.',
    ]
        documents: [
      'Journey management plan',
      'Vehicle inspection',
      'Emergency contact sheet',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.6',
        title: 'Workplace Condition, Welfare and Environment',
        hazards: [
      'Poor access/egress',
      'Heat stress',
      'Fatigue',
      'Poor lighting',
      'Environmental exposure',
    ]
        requirements: [
      'Provide safe means of entry and exit.',
      'Provide workplace amenities appropriate to the location, including lighting, drinking water, washing and welfare arrangements as required.',
      'Consider heat, cold, rain, wind, poor visibility, terrain, insects/animals and other environmental conditions.',
      'Do not continue when environmental conditions make safe completion or emergency response impracticable.',
    ]
        documents: [
      'Environmental assessment',
      'Welfare arrangements',
      'Inspection checklist',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.7',
        title: 'Communication System and Positive Contact',
        requirements: [
      'Select a communication method that works at the actual location: two-way radio, mobile phone, satellite or another suitable system.',
      'Determine whether voice communication is sufficient or whether visual confirmation, CCTV or a personal alarm is required.',
      'Test the communication method before work starts and consider battery life, coverage and failure modes.',
      'Provide an alternative method when the primary system may fail.',
      'Use positive contact: the responsible person should know the worker is safe rather than treating silence as confirmation.',
    ]
        measurements: [
      'The check-in interval should be risk-based and task-specific; the CoP does not prescribe one universal interval.',
      'Confirm actual communication coverage and battery capacity for the expected work period.',
    ]
        documents: [
      'Communication test record',
      'Check-in schedule',
      'Backup communication arrangement',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.8',
        title: 'Personal Alarm, Monitoring and Escalation',
        hazards: [
      'Missed check-in',
      'Alarm not monitored',
      'No escalation owner',
      'False assumption that silence means safety',
    ]
        requirements: [
      'Where justified by the risk, provide a personal alarm or monitoring system capable of raising an immediate alert or supporting accurate worker location.',
      'Define the contact person, backup contact and escalation sequence before work starts.',
      'Specify what happens after a missed check-in: attempt contact, escalate to the nominated responsible person/security and arrange a physical welfare check or emergency response as required.',
      'Keep the procedure individual to the worker/task and review it periodically.',
      'Where CCTV or remote plant monitoring is used, confirm who monitors it and how an alarm becomes an active response.',
    ]
        documents: [
      'Lone-worker procedure',
      'Escalation matrix',
      'Alarm test record',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.9',
        title: 'Personal Security and Violence',
        hazards: [
      'Robbery',
      'Assault',
      'Threatening public interaction',
      'Unauthorized access',
    ]
        requirements: [
      'Assess whether the worker carries cash, valuables, medicines, tools, devices or other items that could attract robbery or assault.',
      'Consider exposure to members of the public, isolated premises, unknown visitors, home addresses and other security threats.',
      'Use suitable access control, communication, security support, work-location controls and emergency procedures.',
      'Do not require a lone worker to confront a violent or threatening person; the safe system must provide a means to withdraw and summon assistance.',
    ]
        controls: [
      'Avoid unnecessary exposure',
      'Security/access controls',
      'Communication and alarm systems',
      'Administrative procedures',
      'Emergency response',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.10',
        title: 'Emergency Procedures and Unattended Workplace',
        requirements: [
      'Prepare for foreseeable emergencies such as fire, illness, equipment failure and incidents.',
      'Ensure the lone worker knows how to raise an alarm and what immediate actions are expected.',
      'Where the workplace may be left unattended, define how it is made safe and secure.',
      'Ensure emergency responders can gain access when the worker is inside a locked building or restricted area.',
      'Do not design the emergency plan around an assumption that the worker will always remain conscious or able to make a call.',
    ]
        documents: [
      'Emergency response plan',
      'Emergency contact list',
      'Access/key arrangements',
      'Fire/emergency procedure',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.11',
        title: 'Supervision and Management Visits',
        requirements: [
      'Provide supervision proportionate to the risk, competence and experience of the worker.',
      'New workers, trainees, people performing special-risk work or workers facing unfamiliar situations may require accompaniment initially.',
      'Use planned site visits, progress checks and safety discussions where direct supervision is not possible.',
      'Management must set the required supervision level based on risk rather than allowing the worker to decide alone that assistance is unnecessary.',
    ]
        documents: [
      'Supervision plan',
      'Site visit records',
      'Safety discussion records',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.12',
        title: 'Medical Fitness and Worker Suitability',
        requirements: [
      'Consider whether the conditions of lone work impose additional physical demands or endurance requirements.',
      'Consider whether a known medical restriction could make the lone-working arrangement unsuitable.',
      "Use the employer's occupational-health process and applicable medical-fitness requirements when a task has special demands.",
      'Do not use medical information beyond what is necessary for lawful work suitability and emergency planning.',
    ]
        documents: [
      'Fitness/occupational-health arrangements where applicable',
      'Task suitability assessment',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.13',
        title: 'Tools, Machinery, Electricity and Hazardous Materials',
        hazards: [
      'Electric shock',
      'Unexpected machine movement',
      'Chemical exposure',
      'Fire',
      'Uncontrolled lifting',
    ]
        requirements: [
      'Assess machinery and power tools for electrical safety, guarding and fire risks before assigning lone work.',
      'Apply relevant controls under CoP 15.0, CoP 35.0 and CoP 36.0 as applicable.',
      'Fully assess flammable, explosive or toxic chemicals under the hazardous-material requirements; consider special hazards from automatic extinguishing systems.',
      'Use access equipment that can be safely handled by one person where appropriate and plan lifting so that lone workers are not exposed to uncontrolled manual or mechanical loads.',
      'Consider whether the task itself should prohibit lone working because of the consequence of an equipment failure or exposure.',
    ]
        documents: [
      'Equipment inspection',
      'Permit/isolation documents',
      'SDS where applicable',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.14',
        title: 'High-Risk Activities — Lone Work Decision',
        hazards: [
      'Work at height',
      'Confined space',
      'Electrical work',
      'Hazardous substances',
      'High-pressure systems',
      'Chainsaws/other hazardous equipment',
    ]
        requirements: [
      'Specifically screen for work at height, confined spaces, electricity, hazardous substances, high-pressure systems, hazardous equipment and tasks with potential violence.',
      'Do not treat a phone or personal alarm as a substitute for physical assistance where the consequence of failure is severe.',
      'Where a task requires rescue, immediate intervention, continuous observation or a second competent person, change the work arrangement rather than simply increasing check-in frequency.',
      'Coordinate with the specific CoP, permit and rescue requirements applicable to the activity.',
    ]
        controls: [
      'Eliminate lone work',
      'Two-person/team working',
      'Direct supervision',
      'Dedicated rescue capability',
      'Engineering isolation',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.15',
        title: 'Field Example — Remote Utility Inspection',
        requirements: [
      'A technician is assigned alone to inspect a remote utility asset several kilometres from the main site.',
      'Before departure: confirm the exact asset, route, vehicle condition, weather, water, first-aid kit, communication coverage and emergency contact.',
      'At the location: test communication, confirm the check-in plan, inspect access, establish the work boundary and verify that the inspection remains within the assessed scope.',
      'If communication is lost, access deteriorates, an unexpected electrical/height/confined-space hazard appears, or the task changes, stop and obtain assistance.',
      'On completion: confirm safe exit and close the check-in record.',
    ]
        documents: [
      'Journey plan',
      'Task RA',
      'Check-in log',
      'Equipment inspection',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.16',
        title: 'Field Example — Night Maintenance in a Locked Facility',
        requirements: [
      'A maintenance worker is scheduled after normal hours inside a building where other staff have left.',
      'Confirm that emergency responders can enter, the worker can communicate from the work area, and the responsible contact and backup are available.',
      'Check lighting, access/egress, fire systems, electrical isolation and any security risks before starting.',
      'Use the agreed check-in schedule and escalation procedure; if a check-in is missed, the nominated contact initiates the documented response rather than waiting indefinitely.',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.17',
        title: 'Field Verification Before Release to Work',
        requirements: [
      'Verify the actual location and route.',
      'Confirm task-specific risk assessment and safe system of work.',
      'Confirm worker competency and authorization.',
      'Test primary and backup communication.',
      'Confirm contact person, backup contact and escalation sequence.',
      'Confirm first-aid, emergency equipment, water, lighting and welfare arrangements.',
      'Confirm permits and isolation requirements where applicable.',
      'Confirm environmental and security conditions are acceptable.',
      'Confirm the worker knows stop-work conditions and how to request assistance.',
    ]
        inspection: [
      'Location/access verified',
      'Communication tested',
      'Check-in arrangement confirmed',
      'Emergency access confirmed',
      'Equipment/PPE inspected',
      'Weather/environment checked',
      'Permit/isolation verified',
    ]
      ),
    ],
    fieldChecklist: [
      'Lone/remote work identified and justified.',
      'Task-specific risk assessment completed.',
      'Safe system of work and site rules available.',
      'Competent and authorized worker assigned.',
      'Primary and backup communication tested.',
      'Named contact and backup contact confirmed.',
      'Check-in frequency and missed-check-in escalation agreed.',
      'Emergency access and first-aid arrangements confirmed.',
      'Journey/vehicle controls checked where applicable.',
      'Heat, weather, fatigue, welfare and security conditions assessed.',
      'Tools, equipment, PPE and permits inspected.',
      'High-risk activities screened for whether lone work is prohibited or unsuitable.',
      'Worker understands stop-work and assistance arrangements.',
    ],
    stopWorkIndicators: [
      'Communication cannot be maintained and no reliable backup exists.',
      'The worker cannot maintain the agreed check-in arrangement.',
      'A missed check-in has not been resolved under the escalation procedure.',
      'The task changes into high-risk work requiring additional personnel, direct supervision or rescue capability.',
      'Emergency access or escape becomes unavailable.',
      'Weather, heat, fatigue, security or environmental conditions make the task unsafe.',
      'Required competency, permit, isolation, PPE or emergency equipment is missing.',
      'The worker encounters an unexpected hazard outside the approved risk assessment.',
    ],
    references: [
      'ADPHC — CoP 30.0, Lone Working and/or in Remote Locations, Version 4.1, 16 February 2026.',
      'ADOSH-SF Element 2 — Risk Management.',
      'ADOSH-SF Element 5 — Training, Awareness and Competency.',
      'ADOSH-SF Element 6 — Emergency Management.',
      'ADPHC CoP 4.0 — First Aid and Medical Emergency Treatment.',
      'ADPHC CoP 8.0 — General Workplace Amenities.',
      'ADPHC CoP 11.0 — Safety in the Heat.',
      'ADPHC CoP 15.0 — Electrical Safety.',
      'ADPHC CoP 35.0 — Portable Power Tools.',
      'ADPHC CoP 36.0 — Plant and Equipment.',
    ],
    verificationNote:
        'Official ADPHC CoP 30.0 Version 4.1 is the controlling source. SafeNexus content is a paraphrased field-reference aid and does not replace the project risk assessment, applicable permit, rescue plan or competent-authority requirements.',
    protectionItems: [
      'Reliable two-way communication device',
      'Backup communication where required',
      'Personal alarm/worker-location system where justified by risk',
      'First-aid and emergency supplies',
      'Drinking water and welfare supplies',
      'Suitable lighting',
      'Task-specific PPE',
      'Journey/location information',
    ],
  );

  static const cop301 = AbuDhabiCopDocument(
    code: 'CoP 30.1',
    title: 'Working in International Locations',
    version: '4.0',
    effectiveDate: '15 July 2024',
    introduction:
        'Provides a planning and risk-control framework for Abu Dhabi employers sending employees, volunteers or temporary workers to international locations where living conditions, infrastructure, culture, political conditions, legal requirements and health risks may differ from Abu Dhabi.',
    sections: [
      AbuDhabiCopSection(
        number: '1.0',
        title: 'International Assignment Scope and Pre-Travel Planning',
        hazards: [
      'Unfamiliar legal/OSH requirements',
      'Security threats',
      'Disease',
      'Natural disasters',
      'Poor infrastructure',
      'Travel risks',
    ]
        requirements: [
      'Identify the destination, route, worksite, host organization, client requirements and the legal/OSH framework that will apply.',
      'Assess conditions likely to be encountered during travel and at the destination before deployment.',
      'Include security threats, emerging diseases, natural hazards, infrastructure, culture, political conditions and other location-specific risks.',
      'Treat volunteers and temporary workers travelling on behalf of the employer within the assignment scope.',
      'Use current UAE Ministry of Foreign Affairs travel advisories and other authoritative destination information as inputs to the risk assessment.',
    ]
        documents: [
      'International assignment plan',
      'Destination risk assessment',
      'Travel advisory review',
      'Host/client requirements',
    ]
      ),
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Roles and Responsibilities',
        requirements: [
      'Management must provide the manpower, material resources and organisational arrangements needed to protect employees deployed internationally.',
      "Employees must follow the employer's international-work procedure and host-site rules that do not conflict with the employer's safety requirements.",
      'Establish a clear point of contact in the overseas entity with responsibility for the travelling employee while on the host premises.',
      'Define the interface between home-company controls, host-company controls and local legal requirements before work starts.',
    ]
        documents: [
      'Responsibility matrix',
      'Host contact details',
      'Interface plan',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.0',
        title: 'Training and Competency for International Work',
        requirements: [
      "Tailor training to the destination and worksite, not just the employee's normal Abu Dhabi induction.",
      'Cover identified hazards, personal security, disease prevention, natural-disaster response, emergency procedures, first aid, medical response, insurance information and communication protocols.',
      'Brief workers on climate, local dress requirements, driving and transport, food arrangements and restrictions relating to alcohol, tobacco and drugs.',
      'Ensure workers understand the host induction and local emergency arrangements.',
      'Keep training records identifying the employee, Emirates ID where required, subjects, provider and dates.',
    ]
        documents: [
      'International-work training record',
      'Destination briefing',
      'Host induction record',
      'Competency certificates',
    ]
      ),
      AbuDhabiCopSection(
        number: '4.0',
        title: 'Planning and Risk Assessment',
        requirements: [
      "Ensure the employer's OSH policy and risk assessment cover international deployment.",
      'Assess the risks associated with the actual journey, destination, accommodation, worksite and task.',
      'Establish safe systems of work and controls for employees and affected persons.',
      'Review and update the assessment when destination conditions, work scope, security, health or travel arrangements change.',
    ]
        documents: [
      'International RA',
      'Travel risk assessment',
      'Task RA',
      'Review record',
    ]
        controls: [
      'Eliminate unnecessary travel/work exposure',
      'Use competent local support',
      'Engineering/workplace controls',
      'Administrative/travel controls',
      'PPE and personal protective measures',
    ]
      ),
      AbuDhabiCopSection(
        number: '5.0',
        title: 'Travel Advisories, Security and Law-and-Order',
        hazards: [
      'Conflict/civil disturbance',
      'Crime',
      'Kidnapping/assault risk',
      'Unsafe transport',
      'Restricted movement',
    ]
        requirements: [
      'Obtain current information about safety and security at the intended location, including law-and-order conditions and conflicts.',
      'Consider the route to and from the workplace, local transport, isolated travel and out-of-hours movement.',
      'Define what conditions trigger postponement, route change, relocation or suspension of the assignment.',
      'Provide employees with emergency contacts and clear instructions for security incidents.',
    ]
        documents: [
      'Security brief',
      'Travel advisory record',
      'Emergency contact card',
    ]
      ),
      AbuDhabiCopSection(
        number: '6.0',
        title: 'Health Hazards, Disease Prevention and Medical Planning',
        hazards: [
      'Communicable disease',
      'Poor healthcare access',
      'Heat/cold/altitude',
      'Food/water hazards',
      'Travel fatigue',
    ]
        requirements: [
      'Obtain current information on health hazards and disease conditions at the destination.',
      'Determine applicable preventive health measures and immunization requirements through appropriate medical/occupational-health advice.',
      'Identify medical facilities and emergency treatment arrangements before travel.',
      'Ensure employees know how to obtain medical help and how medical insurance/assistance operates.',
      'Consider long travel, fatigue, environmental exposure and the health demands of the actual work.',
    ]
        documents: [
      'Medical plan',
      'Emergency medical contacts',
      'Insurance/assistance information',
    ]
      ),
      AbuDhabiCopSection(
        number: '7.0',
        title: 'Host-Country Legal and OSH Interface',
        requirements: [
      'Identify relevant host-country OSH regulations and technical requirements for the work.',
      'Confirm host permits, licences, certificates, training and access requirements before mobilisation.',
      'Determine which home-company safe systems apply and how they interface with host procedures.',
      'Do not assume an Abu Dhabi permit, certificate or procedure automatically satisfies host-country law.',
      'Record gaps and define the controls needed before work begins.',
    ]
        documents: [
      'Legal/OSH register',
      'Permit matrix',
      'Certificate matrix',
      'Host/client requirements',
    ]
      ),
      AbuDhabiCopSection(
        number: '8.0',
        title: 'Host Worksite Induction and Emergency Interface',
        requirements: [
      'Ensure employees complete a host-site induction before starting work.',
      'Where the host does not provide a suitable induction, the employer should establish a practical induction checklist covering reporting lines, first-aid locations, emergency evacuation points, alarms and incident contacts.',
      'Confirm how incidents are reported during working and out-of-hours periods.',
      'Ensure employees know the local emergency signals and evacuation arrangements.',
    ]
        documents: [
      'Host induction checklist',
      'Emergency map',
      'Incident-reporting procedure',
    ]
      ),
      AbuDhabiCopSection(
        number: '9.0',
        title: 'Accommodation and Welfare',
        hazards: [
      'Fire',
      'Poor sanitation',
      'Security',
      'Unsafe transport',
      'Fatigue',
    ]
        requirements: [
      'Assess the accommodation as part of the international assignment risk assessment.',
      'Consider fire safety, access/egress, security, sanitation, food and water, transport, location and emergency arrangements.',
      'Where employer-supplied accommodation is involved, consider applicable Abu Dhabi accommodation requirements together with host-country legal/technical requirements.',
      'Provide welfare arrangements suitable for the assignment and working pattern.',
    ]
        documents: [
      'Accommodation assessment',
      'Welfare plan',
      'Emergency accommodation contacts',
    ]
      ),
      AbuDhabiCopSection(
        number: '10.0',
        title: 'Supervision and High-Risk International Work',
        hazards: [
      'High-risk work without competent supervision',
      'Host/home procedure conflict',
      'Inadequate emergency response',
    ]
        requirements: [
      'Provide adequate OSH supervision for construction and other high-risk activities at international locations.',
      'Verify that competent supervision is available during the actual work period, including out-of-hours arrangements where needed.',
      'Do not allow unfamiliar local conditions to reduce the level of control required for high-risk activities.',
      'Use task-specific permits, method statements, isolation and rescue arrangements where applicable.',
    ]
        documents: [
      'Supervision plan',
      'Method statement',
      'Permit/RA',
    ]
      ),
      AbuDhabiCopSection(
        number: '11.0',
        title: 'PPE, Equipment and Logistics',
        requirements: [
      'Ensure employees take the PPE required for the work and verify compatibility with host-site requirements.',
      'Confirm that specialist equipment, tools, electrical systems, communication equipment and spares are suitable for the destination.',
      'Check transport/storage requirements and local restrictions for equipment brought across borders.',
      'Inspect equipment before deployment and after arrival where transport could affect condition.',
    ]
        documents: [
      'PPE matrix',
      'Equipment inspection',
      'Packing/transport list',
      'Host equipment requirements',
    ]
      ),
      AbuDhabiCopSection(
        number: '12.0',
        title: 'Communication and Out-of-Hours Support',
        requirements: [
      'Define communication channels between the travelling employee, home organisation and host organisation.',
      'Provide contact arrangements for normal and out-of-hours assistance.',
      'Consider time-zone differences and ensure the employee can reach an accountable person when the home office is closed.',
      'Provide backup communication when local network availability is uncertain.',
      'Include emergency contacts for security, medical, transport and project support.',
    ]
        documents: [
      'Communication plan',
      'Contact list',
      'Out-of-hours escalation plan',
    ]
      ),
      AbuDhabiCopSection(
        number: '13.0',
        title: 'Gender, Cultural and Personal-Safety Considerations',
        requirements: [
      'Consider gender-specific requirements and destination-specific cultural/legal expectations during planning.',
      'Brief employees on local customs, dress, movement, transport and workplace expectations relevant to the assignment.',
      'Do not rely on assumptions about local practice; verify requirements for the actual destination.',
      "Ensure the employer's safety arrangements remain applicable and employees know how to report concerns.",
    ]
        documents: [
      'Cultural briefing',
      'Personal-safety briefing',
      'Destination requirements',
    ]
      ),
      AbuDhabiCopSection(
        number: '14.0',
        title: 'Insurance, Liability and Financial Protection',
        requirements: [
      'Confirm that travelling employees have appropriate insurance and liability cover, including medical cover.',
      'Consider insurance requirements for vehicles and equipment used during international work.',
      'Inform field and off-site employees of the extent and limitations of insurance before work begins.',
      'Verify any exclusions or special authorisations that could affect the assignment.',
    ]
        documents: [
      'Insurance confirmation',
      'Liability/vehicle cover',
      'Employee briefing record',
    ]
      ),
      AbuDhabiCopSection(
        number: '15.0',
        title: 'Incident Reporting and Emergency Response',
        requirements: [
      'Define how incidents, near misses, illness, security events and travel emergencies are reported from the destination.',
      'Ensure local emergency response is compatible with the home-company emergency plan.',
      'Identify who has authority to suspend work, relocate personnel or activate emergency assistance.',
      'Maintain communication during an incident and document lessons learned after the event.',
    ]
        documents: [
      'Incident-reporting process',
      'Emergency response plan',
      'Escalation matrix',
      'Debrief record',
    ]
      ),
      AbuDhabiCopSection(
        number: '16.0',
        title: 'Post-Assignment Debrief and Lessons Learned',
        requirements: [
      'Debrief employees after the assignment to identify hazards, control gaps and lessons learned.',
      'Update the international-work procedure and destination risk information when lessons indicate a recurring gap.',
      'Record significant changes in host requirements, security, medical or travel conditions for future assignments.',
    ]
        documents: [
      'Post-assignment debrief',
      'Lessons-learned record',
      'Procedure review',
    ]
      ),
      AbuDhabiCopSection(
        number: '17.0',
        title: 'Field Example — UAE Engineer Visiting an Overseas Plant',
        requirements: [
      "Before travel, the employer identifies the host site's legal requirements, emergency contacts, local transport, accommodation, medical facility, security conditions and required certification.",
      'The engineer receives destination-specific briefing, host induction requirements, communication arrangements and insurance information.',
      'At the site, the engineer verifies permit, isolation, emergency access and host supervision before entering the work area.',
      'If the host work scope changes to high-risk construction or maintenance outside the approved assessment, work is paused until the risk assessment, supervision and controls are revised.',
    ]
      ),
      AbuDhabiCopSection(
        number: '18.0',
        title: 'Field Example — Remote Overseas Project',
        requirements: [
      'A project team is deployed to a remote location with limited medical support and unreliable communications.',
      'Before mobilisation, the employer evaluates journey routes, accommodation, communications, medical evacuation, local security, disease risks, emergency supplies and host-country requirements.',
      'The team establishes a daily contact procedure and clear triggers for suspension or evacuation.',
      'Any change in security, weather, medical access or work scope is reassessed before continuing.',
    ]
      ),
      AbuDhabiCopSection(
        number: '19.0',
        title: 'Pre-Deployment Verification',
        requirements: [
      'Destination and route verified.',
      'UAE travel-advisory information reviewed.',
      'Host-country legal/OSH requirements identified.',
      'Host/client permits, licences and certificates verified.',
      'Task-specific risk assessment approved.',
      'Host contact and out-of-hours contact confirmed.',
      'Medical facility and emergency arrangements confirmed.',
      'Security and communication arrangements tested/verified.',
      'Accommodation and transport assessed.',
      'PPE, equipment and documentation ready.',
      'Insurance and liability cover confirmed.',
      'Host induction and emergency arrangements confirmed.',
    ]
        inspection: [
      'Document check',
      'Host contact verification',
      'Equipment/PPE check',
      'Travel and accommodation check',
      'Emergency communication check',
    ]
      ),
    ],
    fieldChecklist: [
      'Destination and route risk assessed.',
      'Current UAE travel-advisory information reviewed.',
      'Host-country OSH and legal requirements identified.',
      'Host/client permits, licences and certificates verified.',
      'Task-specific risk assessment approved.',
      'Destination-specific training and briefing completed.',
      'Host induction and emergency arrangements confirmed.',
      'Medical facilities, health precautions and insurance arrangements confirmed.',
      'Security, transport and accommodation risks assessed.',
      'Home/host OSH interface and responsible contacts established.',
      'Normal and out-of-hours communication arrangements available.',
      'Required PPE, tools and documentation ready.',
      'Incident reporting and emergency escalation process understood.',
      'Post-assignment debrief planned.',
    ],
    stopWorkIndicators: [
      'Required host-country authorization, permit or certificate is missing.',
      'The actual work differs materially from the approved task/risk assessment.',
      'Competent supervision is unavailable for high-risk work.',
      'Security conditions deteriorate beyond the approved risk assessment.',
      'Emergency medical support or communication is inadequate for the risk.',
      'Required PPE, equipment or emergency arrangements are unavailable.',
      'Host and employer procedures conflict and no competent resolution has been established.',
      'Travel or destination conditions create an unacceptable risk to personnel.',
    ],
    references: [
      'ADPHC — CoP 30.1, Working in International Locations, Version 4.0, 15 July 2024.',
      'ADOSH-SF Element 2 — Risk Management.',
      'ADOSH-SF Element 5 — Training, Awareness and Competency.',
      'ADOSH-SF Element 6 — Emergency Management.',
      'ADPHC CoP 18.0 — Employer Supplied Accommodation, where applicable.',
      'Current UAE Ministry of Foreign Affairs travel advisories for the destination.',
      'Applicable host-country legislation and competent-authority requirements.',
    ],
    verificationNote:
        'Official ADPHC CoP 30.1 Version 4.0 is the controlling source. International assignments must also comply with applicable host-country law and competent-authority requirements. SafeNexus is a field planning aid and does not replace local legal advice or project controls.',
    protectionItems: [
      'International assignment risk assessment',
      'Destination/security briefing',
      'Emergency and medical contact information',
      'Communication device and backup method where required',
      'Required PPE and task equipment',
      'Host-country permits/certificates',
      'Insurance/assistance information',
    ],
  );

  static const cop310 = AbuDhabiCopDocument(
    code: 'CoP 31.0',
    title: 'Working On, Over or Adjacent to Water',
    version: '4.1',
    effectiveDate: '27 February 2026',
    introduction:
        'Establishes Abu Dhabi OSH requirements for work on, over or adjacent to water. The SafeNexus field reference expands the official 3.1–3.21 structure into practical planning, equipment, rescue, inspection and field-example guidance without changing the existing document API.',
    sections: [
      AbuDhabiCopSection(
        number: '1.0',
        title: 'Scope, Water Hazards and Work Interface',
        hazards: [
      'Fall into water/drowning',
      'Fast current',
      'Water traffic',
      'Electrical contact with water',
      'Slips/trips',
      'Difficult rescue',
    ]
        requirements: [
      'Identify all work on, over or adjacent to water and assess the interaction with work at height, temporary works, plant, lifting, electrical systems and access.',
      'Consider falling into water and drowning, being swept away by moving water, being struck by water traffic and electrical shock following contact with water.',
      'Assess the actual water environment, work boundary, rescue access and conditions that could change during the shift.',
      'Plan, organize and supervise the work so water hazards are controlled before people are exposed.',
    ]
        documents: [
      'Task risk assessment',
      'Safe work method statement',
      'Water/marine interface plan where applicable',
      'Emergency/rescue plan',
    ]
      ),
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Training, Competency and Rescue Drills',
        requirements: [
      'Provide task-specific training covering buoyancy aids, fall restraint/fall arrest systems, fall hazards, equipment identification, inspection, maintenance, donning/doffing and equipment limitations.',
      'Provide practical field exercises so workers can demonstrate correct use of the relevant protective equipment.',
      'Ensure a competent first aider trained in CPR and drowning response is readily available on contracts involving work on, over or adjacent to water.',
      'Train all employees to raise alarms, respond to emergencies and understand the rescue procedure.',
      'Retrain when job assignment, equipment or known hazards change, or when inspection identifies deviations from the required procedure.',
    ]
        documents: [
      'Training records',
      'Practical competency records',
      'Rescue-drill records',
      'First-aid certificates',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.0',
        title: 'Roles, Responsibilities and Supervision',
        requirements: [
      'Employers must assess water-related risks and implement controls and safe work practices.',
      'Ensure work is planned, organized and supervised; drowning risks are managed; rescue controls are available; emergency equipment is inspected; and workers are trained and competent.',
      'Employees must follow safe work procedures, use provided PPE/equipment, keep supervisors informed of their location and know how to raise an alarm.',
      'Workers must report defects or activities that could reasonably endanger themselves or others.',
    ]
        documents: [
      'Supervision plan',
      'Inspection records',
      'Worker briefing records',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.1',
        title: 'Planning and Assessment',
        requirements: [
      'Include water-work controls in the construction pre-tender safety and health plan and OSH-CMP where applicable.',
      'Assess falls from structures/scaffolds, poor visibility, electrical equipment contacting water, rescue difficulty, current/environment and workers who cannot swim.',
      'Define controls before work begins and review them when water level, weather, plant, access or work location changes.',
    ]
        documents: [
      'Pre-tender safety and health plan where applicable',
      'OSH-CMP where applicable',
      'Task RA',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.2',
        title: 'Personal Protective Equipment and Buoyancy',
        requirements: [
      'Where there is a risk of drowning, provide an appropriately fitting Type I or Type II rated personal flotation device/buoyancy aid as required by the CoP.',
      'Provide slip-resistant footwear and appropriate fall-protection controls.',
      'Workers should inspect PPE before, during and after use and remove defective equipment from service.',
      'Select equipment that permits necessary movement and is suitable for the task and water conditions.',
    ]
        measurements: [
      'The CoP specifies Type I or Type II rated PFD/buoyancy aid where there is a risk of drowning.',
    ]
        documents: [
      'PPE inspection record',
      'PFD inspection record',
      'Training record',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.3',
        title: 'Health, Hygiene and Remote Welfare',
        hazards: [
      'Heat stress',
      'Contaminated water',
      'Poor hygiene',
      'Infection',
    ]
        requirements: [
      'Apply the ADOSH-SF heat requirements for hot-weather work.',
      'Provide suitable workplace amenities where toilet or welfare facilities are remote or not within walking distance.',
      'Consider contaminated water, hygiene, wounds, biological exposure and decontamination where relevant to the site.',
    ]
        documents: [
      'Heat controls',
      'Welfare arrangement',
      'Hygiene/decontamination plan',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.4',
        title: 'Barriers and Edge Protection',
        requirements: [
      'Provide a fence, barrier or other suitable physical control wherever people could fall into water.',
      'Use appropriate walkways, handrails, stairways, ladders, scaffold barriers or tube-and-fitting guardrails according to the work arrangement.',
      'Maintain barriers at all times while the fall exposure exists and control openings or temporary removal.',
    ]
        controls: [
      'Eliminate exposure',
      'Physical barriers/guardrails',
      'Safe access systems',
      'Fall protection as secondary control',
    ]
        inspection: [
      'Barrier continuity',
      'Edge condition',
      'Openings controlled',
      'Access protected',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.5',
        title: 'Signage and Warning Notices',
        requirements: [
      'Display warning signs/notices to identify water hazards and restricted areas.',
      'Position signs so they are visible before a person reaches the danger point.',
      'Maintain signage when work boundaries or water hazards change.',
    ]
        documents: [
      'Signage plan',
      'Daily inspection',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.6',
        title: 'Lighting and Night Work',
        hazards: [
      'Poor visibility',
      'Glare',
      'Unseen water edge',
      'Delayed rescue',
    ]
        requirements: [
      'Provide lighting adequate for the duration and nature of the work.',
      'Provide lighting for night work near water, including shafts, dark corners and stairways.',
      'Use an even spread of light to reduce deceptive shadows and glare.',
      'Ensure the immediate water surface is included in the illuminated area.',
      'Use strategically positioned spotlights where needed to help locate a person in the water and navigation lights for floating/shore work when required.',
    ]
        documents: [
      'Lighting inspection',
      'Night-work plan',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.7',
        title: 'Plant, Equipment and Electrical Controls Near Water',
        requirements: [
      'Strictly control electrical equipment near water.',
      'Prevent portable electrical leads from being long enough to reach the water and secure equipment against dropping into water.',
      'Use 30 mA RCD protection for portable electrical tools as specified by the CoP.',
      'Inspect plant and equipment and keep equipment positioned to prevent unintended movement toward the water edge.',
      'Coordinate lifting and material handling so loads do not create an uncontrolled water or fall hazard.',
    ]
        measurements: [
      'Portable electrical tools: 30 mA RCD protection specified by CoP 31.0.',
    ]
        documents: [
      'Electrical inspection',
      'RCD test/verification',
      'Plant inspection',
      'Lifting plan where applicable',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.8',
        title: 'Water Current, Depth, Width and Rescue Capacity',
        requirements: [
      'Assess vegetation, mud flats and other features that could obstruct rescue.',
      'Assess the width, depth and speed of the water and select a rescue capability appropriate to those conditions.',
      'Where a thrown lifebuoy can reach a person in the water, provide a lifebuoy with a rope at the worksite.',
      'Where the worksite is too far from the water for a thrown lifebuoy to reach a person, provide the rescue-boat and communication arrangements required by the CoP.',
      'Where work is more than 400 m from land or occurs at more than one location on a bridge, provide the required power-boat/boat-operator arrangement on both banks.',
    ]
        measurements: [
      'Communication systems on bridge/land: not more than 400 m apart where that option is used.',
      'Communication systems must be tested at the start of every shift and after work resumes following a break.',
    ]
        documents: [
      'Water-rescue assessment',
      'Rescue boat plan',
      'Communication test record',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.9',
        title: 'Platforms and Gangways',
        requirements: [
      'Provide platforms and gangways of at least four boards in width with guardrails and toe boards at edges where a person could fall into water.',
      'Secure barriers/fences and provide warning notices at edges and boundaries.',
      'Secure decking above tidal water against displacement from rising water or high winds.',
      'Provide additional handholds where high winds may affect stability.',
      'Ensure barges, pontoons and similar floating work platforms are appropriately constructed and stable.',
    ]
        measurements: [
      'Minimum platform/gangway width specified: 4 boards / 800 mm.',
      'Guardrails and toe boards are required at edges from which a person could fall into water.',
    ]
        documents: [
      'Temporary platform inspection',
      'Marine platform stability assessment',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.10',
        title: 'Ladders Over or Near Water',
        requirements: [
      'Apply the applicable ladder requirements and ensure ladders are sound and suitable for the task.',
      'Use ladders of appropriate length and strength and secure them against slipping.',
      'Where ladders are permanently fitted to plant over water, provide safety hoops as required.',
    ]
        documents: [
      'Ladder inspection',
      'Access inspection',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.11',
        title: 'Safety Nets and Safety Harnesses',
        requirements: [
      'Where safety nets are used, secure them appropriately and position them sufficiently above high-water level to keep a person clear and permit rescue craft access.',
      'Select the net type with reference to manufacturer guidance and the actual work/environment.',
      'Use harnesses as a last resort where collective physical controls and fall prevention cannot adequately control the fall risk.',
      'Coordinate fall-protection selection with CoP 23.0 and the task-specific rescue arrangement.',
    ]
        documents: [
      'Fall-protection plan',
      'Equipment inspection',
      'Manufacturer information',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.12',
        title: 'Site Housekeeping and Spill Control',
        requirements: [
      'Store tools, ropes and unused materials safely and clear rubbish promptly.',
      'Stack materials compactly; on pontoons, do not pile materials more than two pallets high.',
      'Treat slippery surfaces immediately.',
      'Treat oily or greasy surfaces with suitable absorbent material.',
      'Use drip trays under machinery to reduce oily surfaces and fire risk, especially on pontoons.',
      'Clean spillages promptly and maintain spill kits with booms that can be deployed on water.',
    ]
        measurements: [
      'Pontoons: materials awaiting use should not be piled more than two pallets high.',
    ]
        documents: [
      'Housekeeping checklist',
      'Spill response plan',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.13',
        title: 'Weather Conditions and Work Suspension',
        hazards: [
      'Wind',
      'Rain',
      'Fog/sea mist',
      'Heat',
      'Reduced visibility',
      'Wave/current change',
    ]
        requirements: [
      'Obtain and communicate local weather conditions at the start of each workday/shift.',
      'Monitor weather throughout the work for deterioration.',
      'Consider hot weather, rain, rising winds, fog and sea mist as potential hazards.',
      'Define operating limits in the task risk assessment, manufacturer instructions and competent-authority/project requirements.',
      'Suspend work when weather conditions create a risk to safe execution.',
    ]
        documents: [
      'Daily weather briefing',
      'Weather monitoring record',
      'Stop-work criteria',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.14',
        title: 'First Aid and Drowning Response',
        requirements: [
      'Ensure a competent first aider trained in CPR and drowning response is readily available.',
      'Locate first-aid equipment so it can reach the work area quickly.',
      'Plan for post-rescue medical assessment and treatment even when the casualty appears to recover.',
      'Brief workers on alarm raising and initial safe response.',
    ]
        documents: [
      'First-aid arrangements',
      'CPR/drowning competency',
      'Emergency contact list',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.15',
        title: 'Rescue Method — Avoid Secondary Casualties',
        hazards: [
      'Secondary rescuer drowning',
      'Current carrying casualty away',
      'Delayed retrieval',
    ]
        requirements: [
      'Select the safest practical rescue method.',
      'For a conscious person who can respond, prefer reach/throw methods from a safe position where practicable rather than entering the water.',
      'Prevent untrained persons from making uncontrolled water entries.',
      'After retrieval, provide drowning/medical response and arrange appropriate medical assessment.',
      'Keep the rescue method compatible with the current, tide, platform height and access to the casualty.',
    ]
        documents: [
      'Rescue plan',
      'Rescue drill record',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.16',
        title: 'Buoyancy Aids — Selection and Inspection',
        requirements: [
      'Use an appropriately fitting Type I or Type II PFD as standard practice where required by the CoP.',
      "Select buoyancy equipment suitable for the work and hazard and compatible with the user's movement.",
      'Equipment should provide sufficient buoyancy to keep the wearer afloat face-up, be secure, visible and resistant to the working environment.',
      'Prevent snagging and maintain inflatable equipment according to its inspection requirements.',
      'Where specified by the CoP, provide clip-on self-igniting lights for the buoyancy aid.',
    ]
        measurements: [
      'PFD type specified by CoP 31.0: Type I or Type II.',
    ]
        inspection: [
      'Fit and condition',
      'Buoyancy system',
      'Fasteners',
      'Visibility',
      'Light where fitted',
      'Inflation/maintenance for inflatable type',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.17',
        title: 'Water Transport and Passenger-Carrying Craft',
        requirements: [
      'Where access to a worksite on water is by passenger-carrying boat, ensure the craft meets applicable Abu Dhabi marine transport and Coast Guard requirements.',
      'Use registered craft, maintain required registration, and operate within the permitted passenger capacity for the craft.',
      'Provide appropriate life-saving and firefighting equipment specified by the relevant authority.',
      'Ensure operators are appropriately licensed and the craft is maintained and inspected.',
    ]
        measurements: [
      'The CoP notes VHF radio where a craft is longer than 10.7 m, subject to applicable authority requirements.',
    ]
        documents: [
      'Boat registration',
      'Passenger capacity information',
      'Operator licence',
      'Marine inspection record',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.18',
        title: 'Lifebuoys and Rescue Lines',
        requirements: [
      'Position lifebuoys so they can be reached quickly from the work area.',
      'Use a buoyant lifeline long enough for the height of the work position, tide range and possible downstream movement.',
      'Provide approved self-ignition lights for night work where required.',
      'Check lifebuoys and rescue lines daily for location and serviceable condition.',
    ]
        measurements: [
      'Lifebuoy normally specified: approximately 765 mm outside diameter.',
      'Buoyant lifeline specified: 30 m, with knots at 3 m intervals for handhold.',
    ]
        documents: [
      'Daily rescue-equipment inspection',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.19',
        title: 'Grab Lines and Throw Lines',
        requirements: [
      'Provide grab/throw lines attached to the working place or other suitable downstream positions so a person can reach them in an emergency.',
      'Allow for normal tidal rise and fall when selecting line length.',
      'Use buoyant lines with a marker float at the free end.',
      'Avoid trailing line ends that could foul boats.',
      'Inspect the lines daily and confirm they remain in position and serviceable.',
    ]
        documents: [
      'Daily grab-line inspection',
      'Rescue equipment layout',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.20',
        title: 'Rescue Requirements and Reset After Rescue',
        requirements: [
      'Train employees to raise alarms and practise rescue drills regularly.',
      'Ensure boat and watercraft operators hold the required licences.',
      'After a lifebuoy or rescue boat is used for a person in the water, stop work until the rescue equipment is reset and ready for the next emergency.',
      'Ensure water-safety personnel hold the required first-aid certification.',
    ]
        documents: [
      'Rescue-drill records',
      'Boat operator licence',
      'Equipment reset checklist',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.21',
        title: 'Rescue Boat Requirements',
        requirements: [
      'Use appropriately licensed and maintained rescue boats.',
      'Operate rescue boats with competent, appropriately licensed personnel.',
      'Inspect the boat before use for leaks, fuel leaks, structural damage and other unsafe conditions.',
      'Where conditions warrant, consider suitable inflatable craft for casualty recovery.',
      'For tidal or fast-flowing water, use the powered craft arrangement required by the CoP and risk assessment.',
      'Test powered craft periodically when not on patrol to ensure operational readiness.',
      'Provide the required oars/paddles, retaining arrangements, grab lines, rescue PFD and reliable two-way communication with shore.',
      'Keep rescue equipment ready for immediate deployment and ensure crew understand the rescue method.',
    ]
        documents: [
      'Boat pre-use inspection',
      'Operator licence',
      'Maintenance record',
      'Communication test',
      'Rescue-boat checklist',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.22',
        title: 'Field Example — Jetty Edge Maintenance',
        requirements: [
      'Set the work boundary, inspect the edge barrier and platform, confirm the PFD selection, position a lifebuoy/rescue line, test communication and review weather/water conditions.',
      'Control tools so they cannot fall into the water and create hazards to workers or vessels.',
      'Maintain a clear rescue path from the work area to the casualty recovery point.',
      'If wind, tide, visibility or water traffic changes beyond the approved conditions, suspend the task and reassess before restarting.',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.23',
        title: 'Field Example — Bridge Inspection Over Fast Water',
        requirements: [
      'Determine water width, depth and current speed and identify mud/vegetation that could obstruct rescue.',
      'Select the rescue capacity required by the assessed conditions; verify communication and rescue-boat readiness where required.',
      'Inspect fall protection, PFDs, access, lighting and bridge-edge barriers before starting.',
      'Test communication at shift start and after breaks where the CoP requires it.',
      'Stop work if rescue capability becomes unavailable or current/weather conditions make recovery unsafe.',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.24',
        title: 'Field Example — Floating Pontoon Work',
        requirements: [
      'Confirm the pontoon is stable and suitable for the expected loads and environmental conditions.',
      'Keep materials compact and control slippery/oily surfaces; use drip trays and water-deployable spill booms where needed.',
      'Secure tools and materials, maintain edge protection, inspect access and keep rescue equipment ready.',
      'Monitor wind and water movement because changes can affect platform stability and rescue access.',
    ]
      ),
      AbuDhabiCopSection(
        number: '3.25',
        title: 'Field Verification Before Work',
        requirements: [
      'Water hazard and fall exposure identified.',
      'Risk assessment and safe system of work approved.',
      'Competent supervision and trained workers confirmed.',
      'PFD/buoyancy aids fitted and inspected.',
      'Barriers, guardrails, toe boards and access systems inspected.',
      'Lighting and signage adequate.',
      'Electrical controls and 30 mA RCD protection verified where applicable.',
      'Water width/depth/current and environmental conditions assessed.',
      'Rescue equipment positioned and inspected.',
      'Communication system tested.',
      'Rescue boat/boat operator arrangements confirmed where required.',
      'First aider trained in CPR and drowning response available.',
      'Weather conditions checked and operating limits understood.',
      'Housekeeping, spill control and water-traffic interface verified.',
    ]
        inspection: [
      'Pre-start water-safety inspection',
      'PFD inspection',
      'Rescue-equipment daily check',
      'Communication test',
      'Weather/water check',
      'Platform/access inspection',
    ]
      ),
    ],
    fieldChecklist: [
      'Water hazard and fall/drowning exposure identified.',
      'Task-specific risk assessment and safe system of work completed.',
      'Competent supervision and trained workers confirmed.',
      'Type I or Type II PFD/buoyancy aid selected and fitted where drowning risk exists.',
      'Slip-resistant footwear and required fall protection provided.',
      'Barriers, guardrails, toe boards and access systems inspected.',
      'Lighting, signage and navigation controls adequate.',
      'Electrical equipment controlled and 30 mA RCD protection verified for portable electrical tools where applicable.',
      'Water width, depth, current and rescue access assessed.',
      'Lifebuoys, rescue lines, grab/throw lines and other rescue equipment positioned.',
      'Rescue boat and licensed operator arrangements confirmed where required.',
      'Communication tested at the required intervals.',
      'Competent first aider trained in CPR and drowning response available.',
      'Weather conditions checked and suspension criteria understood.',
      'Housekeeping, spill control and water-traffic interface controlled.',
      'Rescue drill/competency requirements satisfied.',
    ],
    stopWorkIndicators: [
      'Unprotected fall/drowning exposure cannot be adequately controlled.',
      'Required PFD/buoyancy aid or fall-protection equipment is missing, defective or unsuitable.',
      'Rescue capability, competent first aider or required rescue equipment is unavailable.',
      'Communication system fails and no reliable alternative is available.',
      'Water current, tide, weather, visibility or water level exceeds the approved operating conditions.',
      'Platform, gangway, ladder, barrier or floating work structure becomes unstable.',
      'Water traffic cannot be safely separated or controlled.',
      'Electrical equipment creates an uncontrolled shock hazard near water.',
      'Rescue equipment is used and has not been reset/replaced before work resumes.',
      'Required boat/operator licensing or pre-use inspection is not available.',
    ],
    references: [
      'ADPHC — CoP 31.0, Working On, Over or Adjacent to Water, Version 4.1, 16 February 2026.',
      'ADOSH-SF CoP 2.0 — Personal Protective Equipment.',
      'ADOSH-SF CoP 4.0 — First Aid and Medical Emergency Treatment.',
      'ADOSH-SF CoP 8.0 — General Workplace Amenities.',
      'ADOSH-SF CoP 11.0 — Safety in the Heat.',
      'ADOSH-SF CoP 17.0 — Safety Signage and Signals.',
      'ADOSH-SF CoP 23.0 — Working at Heights.',
      'ADOSH-SF CoP 35.0 — Portable Power Tools.',
      'ADOSH-SF CoP 37.0 — Ladders.',
      'ADOSH-SF CoP 53.0 — OSH Management During Construction Work, where applicable.',
    ],
    verificationNote:
        'Official ADPHC CoP 31.0 Version 4.1 is the controlling source. Numerical values and equipment requirements shown here are paraphrased from the official CoP and should be checked against the current official document, manufacturer requirements, marine authority requirements and the project risk assessment before field use.',
    protectionItems: [
      'Type I or Type II personal flotation device/buoyancy aid',
      'Slip-resistant footwear',
      'Fall restraint/fall arrest equipment where required',
      'Lifebuoy with buoyant rescue line',
      'Grab/throw line with marker float',
      'Rescue boat and appropriate life-saving equipment where required',
      'Two-way communication system',
      'First-aid and drowning-response equipment',
      'Suitable lighting and navigation lights where required',
      'Water-deployable spill-control equipment',
    ],
  );


}
