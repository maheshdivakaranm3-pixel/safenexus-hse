// SafeNexus HSE — Abu Dhabi HSE Reference
// CoP 30.0 / CoP 30.1 / CoP 31.0
//
// Official ADPHC registry checked: 2026
// CoP 30.0 — Lone Working and/or in Remote Locations — Version 4.1
// CoP 30.1 — Working in International Locations — Version 4.0
// CoP 31.0 — Working On, Over or Adjacent to Water — Version 4.1
//
// IMPORTANT:
// - This file adds the missing CoP 30/30.1/31 documents to the existing
//   SafeNexus HSE reference hub.
// - Existing UI/navigation architecture is unchanged.
// - Requirements are SafeNexus field explanations and paraphrases; consult
//   the official ADPHC CoP for the controlling legal wording.
// - The current ADPHC registry does NOT list a CoP 32.0 between 31.0 and 33.0.

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
        'CoP 30.0 establishes Abu Dhabi OSH requirements for identifying, assessing and controlling risks where a person works alone or in a remote location without close or direct supervision. The field objective is to prevent a worker from becoming isolated without suitable communication, welfare, emergency response, competent support and effective management of foreseeable hazards.',
    sections: [
      AbuDhabiCopSection(
        number: '1.0',
        title: 'Lone Work Identification and Scope',
        hazards: [
          'Worker becomes ill or injured with no immediate assistance.',
          'Delayed emergency response because the worker cannot summon help.',
          'Exposure to traffic, plant, electricity, chemicals, heights, heat, confined areas or other task hazards while alone.',
          'Violence, security threats or unauthorized access.',
          'Loss of communication in remote or poorly covered areas.',
        ],
        requirements: [
          'Identify every task where a person may work without close or direct supervision.',
          'Treat mobile, isolated, out-of-hours, maintenance, inspection, security, utility and remote-location activities as potential lone-work situations.',
          'Do not assume that a worker is not lone-working merely because other people are somewhere on the same project; assess whether effective assistance is actually available.',
          'Identify the location, task, duration, travel route, environmental conditions, nearest assistance and foreseeable emergency scenarios before authorizing the work.',
          'Where the risk cannot be adequately controlled for one person, arrange additional supervision or a team rather than proceeding with lone work.',
        ],
        documents: [
          'Lone-worker register or task list',
          'Task-specific risk assessment',
          'Safe work procedure / method statement',
          'Communication and check-in plan',
        ],
      ),
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Risk Assessment and Safe System of Work',
        hazards: [
          'Generic risk assessment does not reflect the actual remote task.',
          'Changing weather, heat, terrain or access conditions.',
          'Isolation from emergency services or site support.',
          'Worker fatigue or reduced ability to respond.',
        ],
        requirements: [
          'Complete a task-specific risk assessment before lone work starts.',
          'Consider the nature of the work, location, access and egress, duration, working hours, environmental conditions, tools, plant, chemicals, electrical systems, work at height and any other foreseeable hazard.',
          'Assess whether the worker can safely complete the task without another person physically present.',
          'Define the controls, communication method, check-in frequency, emergency escalation and arrangements for missed check-ins.',
          'Review the assessment whenever the task, location, weather, work hours, equipment or emergency arrangements change.',
          'Use the hierarchy of controls; eliminate the need for lone work where practicable before relying on administrative controls.',
        ],
        controls: [
          'Eliminate the need for lone work where practicable.',
          'Provide additional personnel or direct supervision for higher-risk activities.',
          'Engineering controls, barriers and remote monitoring where appropriate.',
          'Reliable communication and scheduled welfare checks.',
          'PPE and emergency equipment as additional controls.',
        ],
        documents: [
          'Risk assessment',
          'Safe work procedure',
          'Permit where the task requires one',
          'Emergency response plan',
          'Journey / travel plan where applicable',
        ],
      ),
      AbuDhabiCopSection(
        number: '3.0',
        title: 'Training, Competency and Authorization',
        hazards: [
          'Worker does not recognize a condition requiring assistance.',
          'Incorrect emergency response.',
          'Worker lacks competence for the task or equipment.',
          'Failure to understand communication and escalation arrangements.',
        ],
        requirements: [
          'Only authorize persons who are competent and suitable for the task and working conditions.',
          'Provide training and information on task hazards, emergency procedures, communication, first aid arrangements, security risks and site-specific controls.',
          'Verify competence for specialist equipment and activities before assigning lone work.',
          'Ensure workers understand when they must stop work and request assistance.',
          'Provide additional instruction for workers entering unfamiliar or remote locations.',
          'Maintain appropriate training and authorization records.',
        ],
        documents: [
          'Competency records',
          'Training records',
          'Authorization records',
          'Induction records',
        ],
      ),
      AbuDhabiCopSection(
        number: '4.0',
        title: 'Communication, Check-In and Monitoring',
        hazards: [
          'Mobile/radio signal failure.',
          'Worker misses a scheduled check-in.',
          'Emergency alarm is not received.',
          'Communication device battery failure.',
        ],
        requirements: [
          'Select a communication method that works reliably at the actual location.',
          'Test the communication device before departure and before entering the remote work area.',
          'Define who monitors the worker, the agreed check-in interval and the escalation procedure.',
          'Use a positive confirmation system where the responsible person knows that the worker is safe rather than assuming safety from silence.',
          'Provide a backup communication method where the primary system may fail.',
          'Define a clear response to a missed check-in, including attempts to contact the worker, escalation to supervision/security and physical welfare checks where required.',
          'Keep emergency contact information available to the worker and monitoring person.',
        ],
        measurements: [
          'Check-in intervals must be established from the task-specific risk assessment; do not use one generic interval for every activity.',
          'Communication range and battery duration should be confirmed for the actual location and expected work duration.',
        ],
        documents: [
          'Check-in schedule',
          'Communication test record',
          'Emergency contact list',
          'Escalation procedure',
        ],
      ),
      AbuDhabiCopSection(
        number: '5.0',
        title: 'Remote Travel, Access, Welfare and Environment',
        hazards: [
          'Vehicle breakdown or immobilization.',
          'Getting lost or unable to leave the location.',
          'Extreme heat, weather or environmental exposure.',
          'Dehydration, fatigue or reduced concentration.',
          'Poor lighting or unsafe access.',
        ],
        requirements: [
          'Plan the route, access point, expected arrival and expected completion time before travel.',
          'Confirm that the worker has suitable transport, communication, water, lighting and emergency equipment for the location and duration.',
          'Consider heat, humidity, weather, terrain, visibility and daylight when deciding whether lone work is acceptable.',
          'Provide suitable welfare arrangements and realistic recovery opportunities.',
          'Do not continue when fatigue, heat stress, weather or access conditions make the task unsafe.',
          'For remote vehicle travel, establish a breakdown and recovery arrangement and ensure the route is known to the responsible person.',
        ],
        documents: [
          'Journey plan where applicable',
          'Vehicle inspection record',
          'Welfare arrangements',
          'Weather / environmental assessment where relevant',
        ],
      ),
      AbuDhabiCopSection(
        number: '6.0',
        title: 'Emergency Response and Rescue',
        hazards: [
          'Delayed medical assistance.',
          'Worker is unconscious and cannot make a call.',
          'Fire, chemical release, electrical incident or other escalation.',
          'Rescuers are exposed because the emergency plan was not designed in advance.',
        ],
        requirements: [
          'Establish emergency arrangements before lone work begins.',
          'Identify the nearest suitable emergency assistance, site security, first aid and medical arrangements.',
          'Define how the worker will raise an alarm and how the monitoring person will escalate a missed check-in.',
          'Ensure emergency access to the work location is known and practicable.',
          'Provide first-aid or emergency equipment appropriate to the risk and task.',
          'Do not rely solely on the worker being able to call for help; consider automatic alarms, monitoring systems or scheduled physical checks where the risk requires them.',
          'Emergency arrangements must account for remote locations where normal site response times may be longer.',
        ],
        documents: [
          'Emergency response plan',
          'Emergency contact list',
          'First-aid arrangements',
          'Rescue/recovery arrangements where applicable',
        ],
      ),
      AbuDhabiCopSection(
        number: '7.0',
        title: 'Field Verification Before Work',
        hazards: [
          'Controls exist on paper but are unavailable at the work location.',
          'Communication system not tested.',
          'Emergency access blocked.',
          'Task has changed from the original assessment.',
        ],
        requirements: [
          'Verify the exact work location and access route.',
          'Verify communication signal and backup communication.',
          'Confirm check-in arrangements and escalation contacts.',
          'Confirm worker competency and fitness for the assigned task.',
          'Confirm required permits, PPE, tools and emergency equipment.',
          'Confirm environmental conditions are acceptable.',
          'Confirm the worker can leave the area safely without depending on another person who is not actually available.',
        ],
        inspection: [
          'Location and access checked.',
          'Communication tested.',
          'Check-in time agreed.',
          'Emergency contacts confirmed.',
          'Worker competency verified.',
          'PPE and equipment inspected.',
          'Weather and environmental conditions checked.',
        ],
      ),
      AbuDhabiCopSection(
        number: '8.0',
        title: 'Field Example — Remote Inspection',
        requirements: [
          'Before a remote utility inspection, identify the exact asset and access route, review the task risk assessment, confirm communication coverage, set the check-in interval and confirm the escalation contact.',
          'Carry the required inspection equipment, communication device, water, lighting and emergency equipment.',
          'If access becomes unsafe, communication is lost, weather deteriorates or the inspection requires an unexpected high-risk activity, stop and obtain additional support.',
          'On completion, confirm safe exit and close the check-in record.',
        ],
      ),
    ],
    fieldChecklist: [
      'Lone/remote work identified and justified.',
      'Task-specific risk assessment completed.',
      'Competent and authorized worker assigned.',
      'Communication method tested at the work location.',
      'Check-in interval and monitoring person confirmed.',
      'Backup communication available where required.',
      'Emergency contacts and escalation procedure understood.',
      'Access, egress and emergency vehicle access confirmed.',
      'Heat, weather, fatigue and welfare controls checked.',
      'Required PPE, tools and emergency equipment inspected.',
      'Permit and isolation requirements verified where applicable.',
      'Worker understands stop-work and assistance requirements.',
    ],
    stopWorkIndicators: [
      'Communication cannot be maintained and no reliable backup exists.',
      'Worker misses a required check-in or monitoring arrangement fails.',
      'Weather, heat, fatigue or environmental conditions become unsafe.',
      'The task changes into an activity that requires additional personnel or supervision.',
      'Emergency access or escape route becomes unavailable.',
      'Required competency, permit, PPE or emergency equipment is missing.',
    ],
    references: [
      'ADPHC — Code of Practice 30.0, Lone Working and/or in Remote Locations, Version 4.1, effective 27 February 2026.',
      'ADPHC — Code of Practices registry.',
      'ADOSH-SF risk management and training requirements applicable to the activity.',
    ],
    verificationNote:
        'Use the current ADPHC Code of Practice as the controlling regulatory source. SafeNexus field guidance is an explanatory aid and does not replace the employer risk assessment, applicable permits, emergency arrangements or other competent-authority requirements.',
    protectionItems: [
      'Reliable communication device',
      'Backup communication where required',
      'First-aid / emergency equipment',
      'Suitable PPE',
      'Water and welfare supplies',
      'Torch / emergency lighting where required',
      'Journey or location information',
    ],
  );

  static const cop301 = AbuDhabiCopDocument(
    code: 'CoP 30.1',
    title: 'Working in International Locations',
    version: '4.0',
    effectiveDate: '15 July 2024',
    introduction:
        'CoP 30.1 addresses OSH considerations for personnel working outside the normal Abu Dhabi operating environment in international locations. SafeNexus treats this as a planning and risk-control reference: identify host-country requirements, competent-authority expectations, travel and location risks, medical support, emergency arrangements and differences between the home and host systems before deployment.',
    sections: [
      AbuDhabiCopSection(
        number: '1.0',
        title: 'International Assignment Planning',
        hazards: [
          'Different legal and OSH requirements in the host location.',
          'Unfamiliar work practices, language or emergency systems.',
          'Medical, security, environmental and travel risks.',
        ],
        requirements: [
          'Identify the host country, work location, employer/client requirements and applicable legal framework before deployment.',
          'Determine which home-company procedures continue to apply and which host-country requirements must also be followed.',
          'Identify competent local contacts and emergency services.',
          'Review travel, accommodation, transport, communication and welfare arrangements.',
          'Brief workers on local hazards, cultural/site requirements and emergency procedures.',
        ],
        documents: [
          'International assignment risk assessment',
          'Travel and location plan',
          'Host-country legal/OSH requirements',
          'Emergency contacts',
          'Medical and insurance arrangements as applicable',
        ],
      ),
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Host-Country Risk Assessment',
        hazards: [
          'Climate and environmental exposure.',
          'Disease or public-health risks.',
          'Security and civil disturbance.',
          'Different transport and road conditions.',
          'Natural hazards and remote access.',
        ],
        requirements: [
          'Assess risks specific to the destination rather than relying on a generic travel assessment.',
          'Consider climate, heat, cold, altitude, wildlife, disease, water quality, food hygiene, local transport, security and emergency response capability.',
          'Identify task hazards at the actual workplace and integrate them into the project risk assessment.',
          'Review risks for travel between accommodation, workplace and remote locations.',
        ],
        controls: [
          'Eliminate unnecessary exposure or travel.',
          'Use competent local support.',
          'Engineering and physical controls at the workplace.',
          'Administrative controls, briefings, communication and emergency planning.',
          'Suitable PPE and personal protective measures.',
        ],
      ),
      AbuDhabiCopSection(
        number: '3.0',
        title: 'Competency, Communication and Local Interfaces',
        hazards: [
          'Language barriers.',
          'Misunderstanding of permits or work instructions.',
          'Different competency or certification requirements.',
          'Failure to understand local emergency signals.',
        ],
        requirements: [
          'Verify that personnel have the competency required by the host activity and authority.',
          'Provide instructions in a language the workforce understands.',
          'Use qualified interpreters or competent bilingual personnel where necessary.',
          'Confirm permit, induction, access-control and emergency requirements with the host organization.',
          'Verify specialist licenses or certificates before work starts.',
        ],
        documents: [
          'Competency certificates',
          'Host induction record',
          'Permit records',
          'Communication arrangements',
        ],
      ),
      AbuDhabiCopSection(
        number: '4.0',
        title: 'Medical, Emergency and Welfare Arrangements',
        hazards: [
          'Delayed treatment.',
          'Limited local emergency capability.',
          'Worker becomes ill away from normal support.',
          'Inadequate accommodation or welfare.',
        ],
        requirements: [
          'Identify the nearest suitable medical facility and emergency service before deployment.',
          'Establish emergency contacts and escalation routes for the location.',
          'Confirm first-aid arrangements appropriate to the work.',
          'Consider medical evacuation or specialist support where the location or activity warrants it.',
          'Ensure accommodation and welfare arrangements are suitable for the assignment and working conditions.',
        ],
        documents: [
          'Emergency response plan',
          'Medical facility details',
          'Emergency contact list',
          'Welfare arrangements',
        ],
      ),
      AbuDhabiCopSection(
        number: '5.0',
        title: 'Field Verification Before Deployment',
        requirements: [
          'Confirm host-country legal and client requirements.',
          'Confirm worker competency, induction and required permits.',
          'Confirm communication, emergency and medical arrangements.',
          'Confirm travel, accommodation and welfare arrangements.',
          'Confirm environmental, security and task-specific controls.',
        ],
        inspection: [
          'Assignment risk assessment approved.',
          'Host induction completed.',
          'Emergency contacts tested/verified.',
          'Required certificates available.',
          'Travel and accommodation arrangements confirmed.',
          'Task-specific PPE and equipment ready.',
        ],
      ),
    ],
    fieldChecklist: [
      'Host-country requirements identified.',
      'Assignment and task risk assessment completed.',
      'Worker competency and certificates verified.',
      'Host induction completed.',
      'Communication arrangements confirmed.',
      'Emergency and medical facilities identified.',
      'Security and environmental risks reviewed.',
      'Travel, accommodation and welfare arrangements confirmed.',
      'Required permits and client approvals verified.',
    ],
    stopWorkIndicators: [
      'Required host-country authorization is missing.',
      'Competency or certification cannot be verified.',
      'Emergency/medical arrangements are inadequate for the risk.',
      'Security, environmental or travel conditions become unacceptable.',
      'The actual task differs materially from the approved risk assessment.',
    ],
    references: [
      'ADPHC — Code of Practice 30.1, Working in International Locations, Version 4.0, effective 15 July 2024.',
      'ADPHC — Code of Practices registry.',
      'Applicable host-country legislation and competent-authority requirements.',
    ],
    verificationNote:
        'For international work, host-country law and competent-authority requirements must be verified for the actual location and activity. This SafeNexus section is a field planning aid and does not replace local legal advice or project-specific controls.',
    protectionItems: [
      'Travel/assignment risk assessment',
      'Emergency contact information',
      'Communication device',
      'Medical/emergency information',
      'Required PPE',
      'Host-country permits/certificates',
    ],
  );

  static const cop310 = AbuDhabiCopDocument(
    code: 'CoP 31.0',
    title: 'Working On, Over or Adjacent to Water',
    version: '4.1',
    effectiveDate: '27 February 2026',
    introduction:
        'CoP 31.0 establishes Abu Dhabi OSH requirements for work on, over or adjacent to water. The main objective is to prevent falls into water, drowning, being swept away, contact with water traffic and electrical hazards, while also controlling the work-at-height and access hazards associated with marine and waterside work.',
    sections: [
      AbuDhabiCopSection(
        number: '1.0',
        title: 'Water Hazard Identification and Risk Assessment',
        hazards: [
          'Falling into water and drowning.',
          'Being swept away by moving or fast water.',
          'Being struck by water traffic.',
          'Electric shock after electrical equipment enters water.',
          'Slips, trips and falls at wet or unstable edges.',
          'Cold, heat, weather and environmental exposure.',
        ],
        requirements: [
          'Identify every location where workers can fall into or be swept into water.',
          'Assess water depth, current, flow, tides, waves, temperature, visibility, water traffic, edge conditions and rescue access.',
          'Consider the interaction between work at height, plant, lifting, temporary works and water hazards.',
          'Identify changes in water level and weather that can make a previously safe location unsafe.',
          'Define emergency rescue arrangements before work starts.',
        ],
        documents: [
          'Task-specific risk assessment',
          'Safe work procedure / method statement',
          'Marine or waterway interface plan where applicable',
          'Emergency and rescue plan',
        ],
      ),
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Safe Platforms, Edges and Fall Prevention',
        hazards: [
          'Unprotected quay, jetty or platform edges.',
          'Collapse or movement of temporary platforms.',
          'Slippery surfaces.',
          'Falling tools or materials into the water.',
        ],
        requirements: [
          'Provide a stable working platform and suitable edge protection wherever practicable.',
          'Control openings, gaps, unprotected edges and access points.',
          'Keep working surfaces free from oil, mud, water accumulation, loose materials and trip hazards.',
          'Design temporary platforms and access arrangements for the expected loads and environmental conditions.',
          'Where fall prevention cannot fully eliminate water exposure, provide suitable personal protection and rescue systems based on the risk assessment.',
        ],
        controls: [
          'Eliminate work over water where practicable.',
          'Use fixed platforms, guardrails and physical edge protection.',
          'Use properly designed temporary access/platform systems.',
          'Use personal fall and water-rescue equipment as required by risk assessment.',
        ],
      ),
      AbuDhabiCopSection(
        number: '3.0',
        title: 'Gangways, Platforms, Ladders and Access',
        hazards: [
          'Unstable gangways.',
          'Improper ladder positioning.',
          'Excessive slope or inadequate handholds.',
          'Unsafe transition between land and marine structures.',
        ],
        requirements: [
          'Provide safe, secure and suitable access to the work area.',
          'Inspect gangways, ladders, stairs and temporary platforms before use and after conditions change.',
          'Prevent movement or displacement of access equipment.',
          'Keep access clear and provide adequate handholds and safe transitions.',
          'Consider changing water level, vessel movement and weather when positioning access systems.',
        ],
        inspection: [
          'Access equipment stable and secured.',
          'Walking surface clean and non-obstructed.',
          'Handrails/guardrails intact.',
          'Transitions between levels safe.',
          'Water level and movement considered.',
        ],
      ),
      AbuDhabiCopSection(
        number: '4.0',
        title: 'Personal Flotation and Rescue Equipment',
        hazards: [
          'Worker falls into water without suitable buoyancy aid.',
          'Rescue equipment is missing, inaccessible or unsuitable.',
          'Rescuer enters water without protection.',
        ],
        requirements: [
          'Select buoyancy and water-rescue equipment from the risk assessment and conditions of the work.',
          'Provide suitable lifejackets or buoyancy aids where required.',
          'Position lifebuoys, rescue lines and other rescue equipment so they can be reached quickly.',
          'Ensure rescue equipment is suitable for the water environment and maintained.',
          'Do not rely on a rescuer entering the water without a planned rescue method and suitable protection.',
        ],
        documents: [
          'Rescue equipment inspection record',
          'Emergency response plan',
          'Training/competency records',
        ],
      ),
      AbuDhabiCopSection(
        number: '5.0',
        title: 'Water Current, Weather and Environmental Conditions',
        hazards: [
          'Fast currents or tidal movement.',
          'High wind and waves.',
          'Reduced visibility.',
          'Lightning or severe weather.',
          'Extreme heat or cold.',
        ],
        requirements: [
          'Monitor weather and water conditions appropriate to the work location.',
          'Establish conditions under which work must be suspended.',
          'Consider water movement and changing levels when planning access, rescue and equipment placement.',
          'Provide suitable lighting for low-light work without creating glare or visibility hazards.',
          'Ensure workers understand the environmental conditions and stop-work criteria.',
        ],
        measurements: [
          'Weather and water operating limits must be defined from the task-specific risk assessment, equipment manufacturer requirements and competent-authority/project criteria rather than one generic SafeNexus limit.',
        ],
      ),
      AbuDhabiCopSection(
        number: '6.0',
        title: 'Plant, Equipment and Water Traffic',
        hazards: [
          'Collision with vessels or watercraft.',
          'Plant movement near an unprotected edge.',
          'Dropped loads.',
          'Electrical equipment contacting water.',
        ],
        requirements: [
          'Establish a controlled interface between the work area and water traffic.',
          'Use suitable exclusion zones, signs, lighting and communication arrangements.',
          'Control plant near water edges to prevent unintended movement or overturning.',
          'Inspect electrical equipment and use controls suitable for wet conditions.',
          'Plan lifting and material movement so loads cannot strike people or fall into water unexpectedly.',
        ],
        documents: [
          'Traffic/marine interface plan where applicable',
          'Plant inspection records',
          'Lifting plan where applicable',
          'Electrical inspection records',
        ],
      ),
      AbuDhabiCopSection(
        number: '7.0',
        title: 'Rescue, Emergency Response and First Aid',
        hazards: [
          'Drowning or near-drowning.',
          'Rescue attempt causes additional casualties.',
          'Delayed emergency response.',
          'Hypothermia or environmental exposure after rescue.',
        ],
        requirements: [
          'Prepare the rescue plan before work starts and brief everyone involved.',
          'Provide suitable rescue equipment at the point of work.',
          'Ensure personnel assigned to rescue are competent for the expected conditions.',
          'Define how emergency services will reach the location.',
          'Provide suitable first aid and post-rescue medical arrangements.',
          'Conduct drills where the risk assessment indicates that practiced rescue is necessary.',
        ],
        documents: [
          'Emergency response plan',
          'Rescue plan',
          'First-aid arrangements',
          'Rescue training/drill records',
        ],
      ),
      AbuDhabiCopSection(
        number: '8.0',
        title: 'Housekeeping, Signage and Lighting',
        hazards: [
          'Trips on wet surfaces.',
          'Unmarked water edges.',
          'Poor visibility during night work.',
          'Tools/materials falling into the water.',
        ],
        requirements: [
          'Keep walkways and work platforms clear and controlled.',
          'Mark water edges, access restrictions and rescue equipment locations.',
          'Provide adequate illumination for access, work and emergency response.',
          'Secure tools and materials where there is a risk of them falling into water.',
          'Maintain barriers and signage throughout the work.',
        ],
      ),
      AbuDhabiCopSection(
        number: '9.0',
        title: 'Health, Hygiene and Contaminated Water',
        hazards: [
          'Exposure to contaminated water.',
          'Skin or eye contact with harmful substances.',
          'Infection after cuts or immersion.',
        ],
        requirements: [
          'Assess water quality and contamination hazards where relevant.',
          'Provide suitable hygiene, washing and decontamination arrangements.',
          'Cover and protect cuts or wounds before work near contaminated water.',
          'Provide appropriate PPE based on the identified biological or chemical hazards.',
          'Arrange medical advice where exposure may create a health risk.',
        ],
      ),
      AbuDhabiCopSection(
        number: '10.0',
        title: 'Field Verification Before Work',
        requirements: [
          'Confirm the exact water hazard and work boundary.',
          'Verify edge protection, platform stability and safe access.',
          'Inspect lifejackets/buoyancy aids and rescue equipment.',
          'Confirm rescue team, emergency contacts and access route for emergency services.',
          'Check weather, current, tide, water level and water traffic conditions as applicable.',
          'Verify electrical, plant and lifting controls.',
          'Confirm workers understand the rescue method and stop-work criteria.',
        ],
        inspection: [
          'Water conditions checked.',
          'Edge/platform controls inspected.',
          'Access and gangways secured.',
          'Buoyancy/rescue equipment available.',
          'Emergency access confirmed.',
          'Weather and environmental conditions acceptable.',
          'Marine/plant interface controlled.',
        ],
      ),
      AbuDhabiCopSection(
        number: '11.0',
        title: 'Field Example — Jetty / Quay Edge Maintenance',
        requirements: [
          'Before maintenance at a jetty edge, establish the work boundary, inspect the platform and edge protection, identify water traffic, check weather and water conditions, and position rescue equipment.',
          'Brief workers on fall prevention, buoyancy equipment, emergency communication and rescue arrangements.',
          'Control tools and materials so they cannot fall into the water or create hazards for water traffic.',
          'Stop work if the platform becomes unstable, weather or water movement exceeds the defined operating conditions, rescue access is compromised or water traffic cannot be safely controlled.',
        ],
      ),
    ],
    fieldChecklist: [
      'Water hazard and fall exposure identified.',
      'Task-specific risk assessment completed.',
      'Safe platform and edge protection verified.',
      'Access/gangway/ladder inspected and secured.',
      'Suitable buoyancy aids available and correctly selected.',
      'Lifebuoys/rescue lines and rescue equipment positioned.',
      'Rescue plan briefed and competent rescuers identified.',
      'Weather, current, tide and water level checked as applicable.',
      'Water traffic interface controlled.',
      'Electrical equipment suitable for wet conditions.',
      'Plant/lifting controls verified.',
      'Lighting, signage and housekeeping adequate.',
      'Emergency services access confirmed.',
    ],
    stopWorkIndicators: [
      'Unprotected fall exposure cannot be adequately controlled.',
      'Rescue equipment is missing, damaged or inaccessible.',
      'Rescue personnel or emergency arrangements are unavailable.',
      'Water current, tide, waves, weather or visibility exceed the approved operating conditions.',
      'Water traffic cannot be safely separated from the work.',
      'Platform, gangway, ladder or edge protection becomes unstable.',
      'Electrical equipment or cables create an uncontrolled water/electrical hazard.',
    ],
    references: [
      'ADPHC — Code of Practice 31.0, Working On, Over or Adjacent to Water, Version 4.1, effective 27 February 2026.',
      'ADPHC — Code of Practices registry.',
      'ADOSH-SF requirements applicable to working at height, emergency response, electrical safety, lifting and plant as relevant to the task.',
    ],
    verificationNote:
        'Use the current ADPHC Code of Practice and applicable project/competent-authority requirements as the controlling source. SafeNexus provides practical field guidance and does not replace the project risk assessment, rescue plan, permit or engineering design.',
    protectionItems: [
      'Suitable lifejacket / buoyancy aid',
      'Lifebuoy and rescue line',
      'Rescue equipment',
      'Fall-prevention/fall-protection equipment where required',
      'Suitable safety footwear',
      'Helmet and task-specific PPE',
      'Communication equipment',
      'Lighting for low-light work',
    ],
  );
}
