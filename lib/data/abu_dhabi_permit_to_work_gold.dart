/// SafeNexus HSE — Abu Dhabi HSE Gold Standard
/// Topic: Permit to Work Systems
/// Regulatory basis: ADOSH-SF CoP 21.0, Version 4.0, effective 15 July 2024.
///
/// Structured reference content. The entity/project PTW procedure, RAMS/JSA,
/// isolation procedure, permits, competency requirements and current official
/// regulatory documents remain applicable.

class PermitToWorkGoldPoint {
  final String title;
  final List<String> points;

  const PermitToWorkGoldPoint({required this.title, required this.points});
}

class PermitToWorkGoldSection {
  final String number;
  final String title;
  final List<PermitToWorkGoldPoint> points;

  const PermitToWorkGoldSection({
    required this.number,
    required this.title,
    required this.points,
  });
}

const List<PermitToWorkGoldSection> permitToWorkGoldStandardSections = [
  PermitToWorkGoldSection(
    number: '01',
    title: 'Definition & Purpose',
    points: [
      PermitToWorkGoldPoint(
        title: 'Definition',
        points: [
          'A Permit to Work (PTW) is a formal documented system used to control specified work by defining the work scope, hazards, precautions, authorization, communication and status of the work.',
          'PTW is a control system; it does not by itself make an unsafe task safe and does not replace risk assessment, RAMS, isolation, competency or supervision.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Purpose',
        points: [
          'Prevent uncontrolled or conflicting work, ensure hazards and controls are understood, verify required precautions before work starts and provide controlled suspension, handover and close-out.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '02',
    title: 'Scope & Applications',
    points: [
      PermitToWorkGoldPoint(
        title: 'Application',
        points: [
          'CoP 21.0 requires employers to identify and safely manage activities requiring PTW and to establish a PTW system for non-routine activities.',
          'PTW may be required for high-risk, non-routine, hazardous or potentially conflicting work depending on the entity\'s PTW procedure and risk assessment.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Common examples',
        points: [
          'Hot work, confined-space entry, electrical work or isolation, excavation, work at height, work on or near hazardous systems, line breaking, critical lifting or other controlled work where the site system requires authorization.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '03',
    title: 'PTW Philosophy & Limits',
    points: [
      PermitToWorkGoldPoint(
        title: 'Key principle',
        points: [
          'The permit confirms that defined precautions have been established for a defined task, location, time and set of conditions.',
          'Permit boundaries must be clear enough that workers can identify exactly what is authorized and what is outside the permit.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Limits',
        points: [
          'A permit is not a substitute for competent people, approved method statements, risk assessment, isolation, equipment inspection or emergency planning.',
          'Permit validity must not be treated as permission to continue when conditions become unsafe.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '04',
    title: 'PTW Roles & Responsibilities',
    points: [
      PermitToWorkGoldPoint(
        title: 'Employer',
        points: [
          'Identify activities requiring PTW, establish the PTW system, ensure competent personnel and provide arrangements for safe management.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Permit issuer / authorizing person',
        points: [
          'Verify the scope, hazards, precautions, required isolations and conditions before authorizing work, within the person\'s defined authority.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Permit receiver / performing authority',
        points: [
          'Understand the scope and controls, brief the work party, maintain the permit conditions and stop or suspend work when conditions change.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Workers',
        points: [
          'Follow the permit, RAMS and site rules, remain within the authorized scope and immediately report hazards or changed conditions.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'HSE / supervision',
        points: [
          'Verify implementation, audit the system, support field controls and intervene when permit conditions are not being followed.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '05',
    title: 'Competency, Training & Authorization',
    points: [
      PermitToWorkGoldPoint(
        title: 'Competency',
        points: [
          'Persons involved in issuing, receiving, checking, isolating, monitoring or closing permits must be competent for their assigned role.',
          'Competency should include understanding of the PTW procedure, hazards, control measures, permit boundaries, communication, suspension and emergency requirements.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Authorization',
        points: [
          'Only designated persons with the required authority may issue, approve, accept, suspend or close permits according to the project PTW matrix.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '06',
    title: 'Planning & Assessment',
    points: [
      PermitToWorkGoldPoint(
        title: 'Planning',
        points: [
          'Evaluate the operation and determine whether PTW is required using risk-management practices.',
          'Identify affected people, assets, environment, simultaneous operations, energy sources, emergency arrangements and required controls.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Work package',
        points: [
          'Coordinate PTW with risk assessment, RAMS/JSA, drawings, procedures, isolation certificates, inspection records, lifting plans and other supporting documents.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '07',
    title: 'When is a PTW Required?',
    points: [
      PermitToWorkGoldPoint(
        title: 'Decision process',
        points: [
          'Check the organization\'s approved PTW procedure and risk assessment for the activity.',
          'Apply the PTW system when the identified hazards, work type, location, process or simultaneous operations require formal authorization.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Do not assume',
        points: [
          'Do not create a permit merely as paperwork or omit one because a task appears routine. The project\'s approved PTW matrix and risk assessment determine applicability.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '08',
    title: 'Permit Types & Categories',
    points: [
      PermitToWorkGoldPoint(
        title: 'Typical categories',
        points: [
          'Hot Work Permit, Cold Work or General Work Permit, Confined Space Entry Permit, Electrical Work or Electrical Isolation Permit, Excavation Permit and other specialized permits defined by the project.',
          'Some organizations use separate certificates for isolation, gas testing, line breaking or other supporting controls.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Important',
        points: [
          'Permit names and categories can differ between organizations. SafeNexus should show the local site\'s approved permit taxonomy rather than inventing a universal list.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '09',
    title: 'Permit Scope & Boundaries',
    points: [
      PermitToWorkGoldPoint(
        title: 'Scope',
        points: [
          'Define the exact job, location, equipment or system, work limits, start conditions and authorized personnel.',
          'State what is excluded when an adjacent activity could be confused with the permitted work.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Boundary control',
        points: [
          'Use physical identification, drawings, tags, signs, barricades or other suitable means where required.',
          'Workers must be able to recognize the permit boundary in the field.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '10',
    title: 'Hazard Identification',
    points: [
      PermitToWorkGoldPoint(
        title: 'Minimum hazard review',
        points: [
          'Energy sources, electrical energy, pressure, stored energy, hazardous substances, fire and explosion, oxygen deficiency, toxic atmosphere, moving equipment, vehicles, lifting, falls, excavation, confined spaces, dropped objects, environmental conditions and simultaneous operations.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Field verification',
        points: [
          'Do not rely only on a desk review. Confirm actual site conditions before authorization and during the work.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '11',
    title: 'Risk Assessment & RAMS / JSA',
    points: [
      PermitToWorkGoldPoint(
        title: 'Relationship',
        points: [
          'The risk assessment identifies hazards and evaluates risk; RAMS/JSA explains the safe work method; PTW authorizes the defined activity after required controls are verified.',
          'All three must be consistent with the same task, location, equipment and conditions.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Change',
        points: [
          'If the task, sequence, equipment, location or conditions change materially, stop and reassess before continuing.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '12',
    title: 'Control Measures & Hierarchy',
    points: [
      PermitToWorkGoldPoint(
        title: 'Control sequence',
        points: [
          'Eliminate the hazard where practicable, substitute safer methods, use engineering controls, apply administrative controls and use PPE as the final layer.',
          'PTW should identify the controls that must be in place before work starts and those that must remain during the task.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Critical controls',
        points: [
          'Isolation, guarding, gas testing, ventilation, fire prevention, fall protection, exclusion zones, access control and competent supervision must be verified when applicable.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '13',
    title: 'Permit Preparation',
    points: [
      PermitToWorkGoldPoint(
        title: 'Before issue',
        points: [
          'Define work scope, location, equipment, hazards, controls, required isolations, PPE, testing, emergency arrangements, simultaneous work restrictions and validity period.',
          'Attach or reference supporting documents and certificates required by the site procedure.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Field readiness',
        points: [
          'Confirm the work area is prepared and the stated controls actually exist before the permit is authorized.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '14',
    title: 'Permit Authorization & Issue',
    points: [
      PermitToWorkGoldPoint(
        title: 'Authorization',
        points: [
          'The authorized issuer verifies the permit information and required precautions before signing or electronically authorizing it.',
          'The permit receiver confirms understanding and acceptance of the conditions before work begins.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'No premature start',
        points: [
          'Work must not start until required authorization, isolation, testing and other preconditions are complete.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '15',
    title: 'Isolation & Verification',
    points: [
      PermitToWorkGoldPoint(
        title: 'Isolation',
        points: [
          'Where hazardous energy or process isolation is required, use the approved isolation and lockout/tagout system.',
          'Identify all relevant energy sources, including electrical, mechanical, hydraulic, pneumatic, pressure, thermal, chemical and stored energy.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Verification',
        points: [
          'Isolation must be verified using the site\'s approved method before work starts. Do not rely solely on a tag or assumption.',
          'Where required, zero-energy or safe-state verification must be documented through the appropriate isolation certificate or procedure.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '16',
    title: 'Gas Testing & Atmospheric Monitoring',
    points: [
      PermitToWorkGoldPoint(
        title: 'When applicable',
        points: [
          'Use competent gas testers and calibrated or approved instruments where atmospheric hazards are possible.',
          'Test for oxygen, flammable atmosphere and relevant toxic contaminants according to the task-specific risk assessment and applicable procedure.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Ongoing monitoring',
        points: [
          'Continuous or periodic monitoring may be required when conditions can change. Define the frequency or continuous-monitoring requirement in the permit and risk assessment.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Alarm response',
        points: [
          'If readings become unsafe or an alarm occurs, stop work, withdraw or evacuate as required and follow the emergency procedure.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '17',
    title: 'Hot Work Interface',
    points: [
      PermitToWorkGoldPoint(
        title: 'Hot work',
        points: [
          'Where hot work is outside a designated area, a specific Hot Work Permit is required under the applicable Abu Dhabi hot-work requirements.',
          'Verify combustible-material control, fire protection, gas testing where applicable, fire watch and post-work monitoring as required by the hot-work procedure.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Related reference',
        points: [
          'Hot-work permit controls must align with CoP 28.0 and the project PTW system.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '18',
    title: 'Confined Space Interface',
    points: [
      PermitToWorkGoldPoint(
        title: 'Entry',
        points: [
          'Confined-space entry requires the applicable entry permit and controls, including hazard assessment, isolation, atmospheric testing, ventilation, communication, standby arrangements and rescue planning as applicable.',
          'Do not treat a general work permit as sufficient where the confined-space procedure requires a dedicated entry permit.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '19',
    title: 'Electrical Work & Isolation Interface',
    points: [
      PermitToWorkGoldPoint(
        title: 'Electrical',
        points: [
          'Electrical work must be controlled under the applicable electrical safety and isolation procedure.',
          'Verify isolation, lockout/tagout, identification, testing for dead or other approved verification, earthing or grounding and boundaries as required by the electrical task.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Permit coordination',
        points: [
          'Link electrical permits or certificates to the main PTW where the project system requires cross-referencing.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '20',
    title: 'Excavation / Ground Disturbance Interface',
    points: [
      PermitToWorkGoldPoint(
        title: 'Excavation',
        points: [
          'Where excavation or ground disturbance requires formal authorization, the excavation permit must be coordinated with service information, risk assessment, shoring or sloping controls, access, inspection and emergency arrangements.',
          'Underground-service controls must be verified before breaking ground.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '21',
    title: 'Work at Height / Lifting / Other Interfaces',
    points: [
      PermitToWorkGoldPoint(
        title: 'Work at height',
        points: [
          'Where PTW is required, verify fall-prevention systems, access, rescue arrangements and exclusion zones before authorization.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Lifting',
        points: [
          'Where critical or controlled lifting is subject to PTW, coordinate the permit with the lifting plan, competent lifting team, equipment certification, exclusion zone and communication arrangements.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Other interfaces',
        points: [
          'Coordinate scaffolding, temporary works, plant, road interface, line breaking, chemicals and other specialist controls with their applicable procedures.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '22',
    title: 'Simultaneous & Conflicting Activities',
    points: [
      PermitToWorkGoldPoint(
        title: 'Conflict identification',
        points: [
          'Identify activities that can create conflicting hazards, such as hot work near flammables, lifting over occupied areas, excavation near services, electrical work near water or simultaneous work on the same equipment.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Control',
        points: [
          'Sequence or segregate work, establish exclusion zones, suspend conflicting permits where necessary and use a permit coordination system.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '23',
    title: 'Communication & Handover',
    points: [
      PermitToWorkGoldPoint(
        title: 'Communication',
        points: [
          'Communicate permit conditions to the work party in a language and form they understand.',
          'Maintain clear communication between operations, permit issuer, permit receiver, isolating authority, HSE and affected work groups.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Shift handover',
        points: [
          'Do not assume a permit automatically transfers between shifts. Follow the site\'s formal handover and revalidation process.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '24',
    title: 'Permit Validity, Suspension & Revalidation',
    points: [
      PermitToWorkGoldPoint(
        title: 'Validity',
        points: [
          'Use the validity period and conditions defined by the project PTW procedure. A permit is valid only for its stated scope and conditions.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Suspend',
        points: [
          'Suspend work for unsafe conditions, emergency alarms, loss of isolation, weather or environmental changes, conflicting operations, personnel changes that affect competence, or any condition outside the permit.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Revalidation',
        points: [
          'Before restarting, recheck required conditions and obtain the required authorization or revalidation.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '25',
    title: 'Management of Change',
    points: [
      PermitToWorkGoldPoint(
        title: 'Change triggers',
        points: [
          'Changes to equipment, process, location, work method, sequence, personnel, isolation, materials, hazards or environmental conditions may require formal review.',
          'Do not use an old permit to cover materially changed work.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'MOC interface',
        points: [
          'Where the change is significant, apply the site\'s Management of Change process and issue a new or revised permit as required.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '26',
    title: 'Emergency Situations',
    points: [
      PermitToWorkGoldPoint(
        title: 'Emergency',
        points: [
          'Emergency response takes priority over routine permit administration. Stop work and activate the emergency procedure when necessary.',
          'Ensure the permit identifies relevant alarms, emergency contacts, evacuation routes, muster points, rescue resources and isolation arrangements where applicable.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'After emergency',
        points: [
          'Do not resume work until the area is declared safe, the causes and controls are reviewed and the PTW is revalidated or reissued according to the procedure.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '27',
    title: 'Stop-Work Conditions',
    points: [
      PermitToWorkGoldPoint(
        title: 'Stop immediately',
        points: [
          'Permit expired or outside scope; required control missing; isolation uncertain; unsafe gas reading; alarm; weather beyond safe limits; conflicting activity; unauthorized personnel; changed conditions; defective equipment; loss of communication; or any person identifies an imminent danger.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Worker authority',
        points: [
          'Workers must be able to stop work and report the condition without being pressured to continue.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '28',
    title: 'Permit Close-Out',
    points: [
      PermitToWorkGoldPoint(
        title: 'Completion',
        points: [
          'Confirm work is complete or safely suspended, tools and materials are removed, guards and barriers are restored where required, personnel are accounted for and the work area is left in a safe condition.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Close-out',
        points: [
          'The permit receiver and authorized issuer complete the required close-out. Restore equipment or systems only under the applicable authorization and isolation procedure.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '29',
    title: 'Record Keeping & Traceability',
    points: [
      PermitToWorkGoldPoint(
        title: 'Records',
        points: [
          'Retain permits, supporting certificates, isolation records, gas-test records, approvals, handovers, suspensions, close-outs and related documents according to the entity\'s record-retention procedure.',
          'Records should allow the organization to determine what work was authorized, by whom, where, when and under what controls.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Audit trail',
        points: [
          'Correct errors according to the approved document-control procedure. Do not erase or obscure permit history in a way that destroys traceability.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '30',
    title: 'Auditing, Monitoring & Verification',
    points: [
      PermitToWorkGoldPoint(
        title: 'Field verification',
        points: [
          'Supervisors and HSE personnel should verify that actual work matches the permit and RAMS.',
          'Permit audits should examine both paperwork quality and field implementation.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Effectiveness',
        points: [
          'Repeated permit failures, conflicting work, unauthorized work or control failures should trigger corrective action and review of the PTW system.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '31',
    title: 'Unsafe Practices → Corrective Actions',
    points: [
      PermitToWorkGoldPoint(
        title: 'Unsafe examples',
        points: [
          'Starting before authorization, signing without checking the worksite, copying old permits, using a permit outside its scope, bypassing isolation, failing to communicate suspension, allowing conflicting work, continuing after changed conditions or closing a permit without verifying the worksite.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Corrective action',
        points: [
          'Stop work, make the area safe, notify the responsible authority, correct the control failure, reassess the task and reauthorize only after requirements are met.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '32',
    title: 'Roles Matrix & Field Accountability',
    points: [
      PermitToWorkGoldPoint(
        title: 'Issuer',
        points: [
          'Confirm hazards, controls, isolations, boundaries, supporting documents and authorization requirements.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Receiver',
        points: [
          'Accept the conditions, brief workers, control the work and stop when conditions change.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Performing worker',
        points: [
          'Follow the permit and RAMS, stay within boundaries and report hazards immediately.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Area or operations authority',
        points: [
          'Coordinate operational conditions, isolations, plant status and simultaneous activities where applicable.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '33',
    title: 'Toolbox Talk',
    points: [
      PermitToWorkGoldPoint(
        title: 'Five-minute PTW briefing',
        points: [
          'What exactly are we authorized to do?',
          'Where exactly can we work?',
          'What hazards and energy sources exist?',
          'What isolations and tests are required?',
          'What controls must remain in place?',
          'What activities must not occur simultaneously?',
          'When must we stop and suspend the permit?',
          'Who do we contact in an emergency?',
          'How will the permit be handed over and closed?',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '34',
    title: 'Field Checklist',
    points: [
      PermitToWorkGoldPoint(
        title: 'Before issue',
        points: [
          '☐ Correct permit type',
          '☐ Exact scope and location defined',
          '☐ Risk assessment and RAMS reviewed',
          '☐ Hazards identified',
          '☐ Controls verified in field',
          '☐ Required isolation identified and verified',
          '☐ Gas testing completed where applicable',
          '☐ Competent persons confirmed',
          '☐ PPE and equipment available',
          '☐ Emergency arrangements ready',
          '☐ Conflicting activities controlled',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'During work',
        points: [
          '☐ Permit available at worksite',
          '☐ Scope unchanged',
          '☐ Controls maintained',
          '☐ Isolation remains effective',
          '☐ Required monitoring continues',
          '☐ No conflicting activity',
          '☐ Supervisor verification completed',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Close-out',
        points: [
          '☐ Work completed or safely suspended',
          '☐ Area inspected',
          '☐ Tools and waste removed',
          '☐ Guards/barriers restored',
          '☐ Personnel accounted for',
          '☐ Equipment restoration authorized',
          '☐ Permit formally closed',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '35',
    title: 'Quick Reference',
    points: [
      PermitToWorkGoldPoint(
        title: 'PTW lifecycle',
        points: [
          'IDENTIFY → ASSESS → PLAN → ISOLATE → VERIFY → AUTHORIZE → BRIEF → WORK → MONITOR → SUSPEND/REVALIDATE → CLOSE.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Golden rules',
        points: [
          'No permit where a permit is required.',
          'No work before authorization.',
          'No work outside permit scope.',
          'No work with unverified critical controls.',
          'No continuation after significant change without reassessment and authorization.',
          'Permit does not replace RAMS, isolation, competency or supervision.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '36',
    title: 'UAE / Abu Dhabi / Dubai Applicability',
    points: [
      PermitToWorkGoldPoint(
        title: 'Abu Dhabi',
        points: [
          'This module is aligned to Abu Dhabi ADOSH-SF CoP 21.0 — Permit to Work Systems, Version 4.0, effective 15 July 2024, as listed by ADPHC.',
          'ADPHC states that CoPs provide minimum mandatory OSH technical requirements and apply to entities within their scope.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Jurisdiction note',
        points: [
          'Dubai and other emirates may have different legal or client PTW requirements. Do not present Abu Dhabi CoP 21.0 as automatically being Dubai law.',
          'Client, principal contractor, facility, operator and sector PTW rules may add controls.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '37',
    title: 'Related CoPs & Cross References',
    points: [
      PermitToWorkGoldPoint(
        title: 'Core references',
        points: [
          'CoP 2.0 Personal Protective Equipment.',
          'CoP 15.0 Electrical Safety.',
          'CoP 23.0 Working at Heights.',
          'CoP 24.0 Lock-out/Tag-out (Isolation).',
          'CoP 27.0 Confined Spaces.',
          'CoP 28.0 Hot Work Operations.',
          'CoP 29.0 Excavation Work.',
          'CoP 33.0 Working On or Adjacent to a Road.',
          'CoP 34.0 Safe Use of Lifting Equipment and Lifting Accessories.',
          'CoP 39.0 Overhead and Underground Services.',
          'CoP 40.0 False Work (Formwork).',
          'CoP 53.1 OSH Construction Management Plan.',
        ],
      ),
    ],
  ),
  PermitToWorkGoldSection(
    number: '38',
    title: 'Official Regulatory References',
    points: [
      PermitToWorkGoldPoint(
        title: 'Primary source',
        points: [
          'Abu Dhabi Occupational Safety and Health Center (ADPHC), ADOSH-SF CoP 21.0 — Permit to Work Systems, Version 4.0, effective 15 July 2024.',
          'Official ADPHC Code of Practices registry should be checked for the current version, effective date and applicability before relying on a regulatory requirement.',
        ],
      ),
      PermitToWorkGoldPoint(
        title: 'Structure verified from official CoP',
        points: [
          'CoP 21.0 covers training and competency; roles and responsibilities; planning and assessment; when a permit is required; permit procedure; specific roles; scope; hazard identification; controls; simultaneous conflicting activities; communication; close-out; verification of isolations; management of change; emergency situations; record keeping and references.',
        ],
      ),
    ],
  ),
];
