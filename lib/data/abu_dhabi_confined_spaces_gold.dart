/// SafeNexus HSE — Abu Dhabi HSE Gold Standard
/// Topic: Confined Spaces
/// Regulatory basis: ADOSH-SF CoP 27.0, Version 4.0, July 2024.
///
/// Structured reference content. Site PTW, RAMS/JSA, isolation, atmospheric
/// testing, rescue, competency and current official requirements remain applicable.

class ConfinedSpaceGoldPoint {
  final String title;
  final List<String> points;

  const ConfinedSpaceGoldPoint({required this.title, required this.points});
}

class ConfinedSpaceGoldSection {
  final String number;
  final String title;
  final List<ConfinedSpaceGoldPoint> points;

  const ConfinedSpaceGoldSection({
    required this.number,
    required this.title,
    required this.points,
  });
}

const List<ConfinedSpaceGoldSection> confinedSpaceGoldStandardSections = [
  ConfinedSpaceGoldSection(
    number: '01',
    title: 'Definition & Purpose',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'A confined space is a space such as a tank, vessel, pipe, sewer, silo, storage bin, hopper, vault, pit, excavation, manhole or similar enclosed space where its enclosed nature creates a reasonably foreseeable specified risk.',
          'The purpose of confined-space control is to prevent fire or explosion, loss of consciousness from heat or hazardous atmosphere, asphyxiation, drowning, engulfment and other serious harm associated with restricted spaces.',
          'Confined-space work must be planned as a specialist high-risk activity and must not be treated as ordinary access work.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '02',
    title: 'Scope & Applications',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Applies to construction, maintenance, cleaning, inspection, entry, repair, shutdown and commissioning activities where a space meets the applicable confined-space definition.',
          'Examples include tanks, vessels, manholes, chambers, pits, ducts, sewers, pipelines, silos, hoppers and certain excavations.',
          'The classification must be based on the actual hazards and applicable ADOSH requirements, not only on the physical size or depth of the space.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '03',
    title: 'Identification & Classification',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Identify spaces during design, planning, worksite inspection and asset surveys. Mark or otherwise identify known confined spaces where required by the site system.',
          'Determine whether entry is required. Eliminate entry where the task can be completed from outside.',
          'Assess the space for atmospheric, engulfment, drowning, fire/explosion, heat, mechanical, electrical, biological, access/egress and other foreseeable hazards.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '04',
    title: 'Specified Risks',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Specified risks include serious injury from fire or explosion, loss of consciousness from increased body temperature, loss of consciousness or asphyxiation from gas, fume, vapour or lack of oxygen, drowning from rising liquid, and asphyxiation or inability to reach a respirable environment due to free-flowing solids or entrapment.',
          'Other task hazards must also be identified even when they are not the reason the space is classified as a confined space.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '05',
    title: 'Entry Decision & Elimination',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'First ask whether entry can be eliminated by remote inspection, external cleaning, tooling, cameras, extended tools or another method.',
          'If entry cannot be eliminated, minimize the number of entrants, duration and exposure.',
          'Do not enter simply because the space appears clean, ventilated or previously used safely.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '06',
    title: 'Risk Assessment & RAMS / JSA',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Prepare a task-specific risk assessment and approved safe system of work covering the space, task, hazards, controls, personnel, equipment, atmospheric testing, isolation, ventilation, communication, standby arrangements and rescue.',
          'Review the assessment when conditions, work sequence, equipment, substances, personnel or space configuration changes.',
          'RAMS/JSA and permit conditions must describe the same work scope and controls.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '07',
    title: 'Permit to Work & Authorization',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Confined-space entry must be controlled by the applicable PTW system and a dedicated entry permit where required by the entity procedure.',
          'Permit authorization must verify the defined space, scope, hazards, isolations, atmospheric controls, competent personnel, standby arrangements, communications and rescue arrangements.',
          'Do not start entry before all required authorizations and preconditions are complete.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '08',
    title: 'Competency & Roles',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Only trained, competent and authorized personnel should enter, supervise, test atmospheres, issue or receive permits, isolate systems or perform rescue duties within their assigned roles.',
          'Roles should be clearly defined for the entry supervisor or responsible person, permit issuer, entry team, standby person, gas tester, isolation authority and rescue personnel as applicable.',
          'Competence must include recognition of hazards, equipment use, communication, emergency response and the limits of the person\'s role.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '09',
    title: 'Isolation & Zero-Energy Verification',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Identify and isolate all hazardous energy and process sources that could affect the space: electrical, mechanical, hydraulic, pneumatic, pressure, thermal, chemical and process energy.',
          'Prevent entry of gases, liquids, steam, chemicals, materials or other substances into the space.',
          'Use the approved lockout/tagout and isolation procedure. Verify isolation using the site\'s approved method rather than relying only on a tag or assumption.',
          'Where required, drain, depressurize, purge, blank, disconnect or otherwise positively isolate the system.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '10',
    title: 'Atmospheric Hazards',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Atmospheric hazards may include oxygen deficiency or enrichment, flammable gases or vapours, toxic gases, fumes, vapours, dusts and contaminants generated by the work or released from connected systems.',
          'Consider both the atmosphere present before entry and changes that can occur during the work.',
          'Atmospheric hazards must be assessed before entry and controlled continuously or periodically as required by the risk assessment and permit.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '11',
    title: 'Gas Testing & Monitoring',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Use a suitable, calibrated and maintained gas detector operated by a competent person.',
          'Test the atmosphere before entry and at locations representative of the space, including areas where gases may accumulate.',
          'Where conditions can change, provide continuous or periodic monitoring according to the risk assessment and permit.',
          'Record required readings and respond immediately to alarms or unacceptable conditions.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '12',
    title: 'Oxygen, Flammable & Toxic Atmospheres',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Verify that oxygen concentration is within the safe range specified by the applicable procedure and permit.',
          'Verify that flammable atmosphere remains within the approved safe criteria for the work.',
          'Identify toxic contaminants relevant to the process, previous contents, cleaning agents and work activity, and apply applicable exposure limits and controls.',
          'Never use smell as an atmospheric test.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '13',
    title: 'Ventilation & Purging',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Provide effective ventilation where needed to maintain a safe atmosphere and remove contaminants.',
          'Select the ventilation method according to the hazard; do not introduce a new hazard by using an unsuitable gas or ventilation arrangement.',
          'Where purging is used, ensure the purge method, medium, discharge path and re-entry criteria are defined by the approved procedure.',
          'Do not use oxygen as a substitute for normal ventilation.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '14',
    title: 'Continuous Atmospheric Change',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Atmospheric conditions can change because of welding, cutting, solvents, cleaning chemicals, biological decomposition, leakage, nearby processes, ventilation failure or disturbance of deposits.',
          'Define alarm actions, withdrawal criteria and retesting requirements before work starts.',
          'Stop entry if monitoring becomes unavailable or conditions cannot be confirmed safe.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '15',
    title: 'Access & Egress',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Provide safe access and a reliable means of escape suitable for the space, task and emergency conditions.',
          'Keep access and egress routes clear of tools, hoses, cables and other obstructions.',
          'Where ladders, tripods, winches or other access systems are used, inspect and use them according to the approved method and manufacturer requirements.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '16',
    title: 'Communication & Standby Person',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Provide reliable communication between entrants and the standby person or responsible supervisor.',
          'The standby person must understand the permit, hazards, alarm signals, entry status and emergency procedure.',
          'The standby person must not leave the assigned post or become distracted by unrelated work while entrants remain dependent on the standby arrangement.',
          'The standby person must not enter for an improvised rescue unless specifically trained, equipped and authorized under the rescue plan.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '17',
    title: 'Rescue & Emergency Planning',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Every entry must have a realistic rescue plan based on the actual space and foreseeable emergencies.',
          'Rescue arrangements must identify trained rescuers, equipment, access, retrieval, communication, medical response and emergency contacts.',
          'Do not rely solely on external emergency services when the time required for rescue could create an unacceptable risk.',
          'Practice or verify the rescue arrangement where required so that equipment and access are known to work.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '18',
    title: 'Retrieval & Rescue Equipment',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Select retrieval equipment according to the space and task, which may include harnesses, lifelines, tripods, davit systems, winches, retrieval devices, breathing equipment and other rescue equipment.',
          'Equipment must be compatible, inspected, maintained and positioned so it can be used without creating additional hazards.',
          'Do not assume a standard harness or lifeline is suitable for every entry or rescue configuration.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '19',
    title: 'Respiratory Protection & Breathing Apparatus',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Use respiratory protective equipment only when selected through the hazard assessment and respiratory-protection program.',
          'Where atmosphere cannot be maintained within safe limits, entry may need to be prohibited or specialized breathing apparatus and specialist controls may be required.',
          'Respiratory protection does not remove the need for isolation, ventilation, atmospheric monitoring and rescue planning.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '20',
    title: 'Fire, Explosion & Hot Work',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Identify flammable gases, vapours, residues, dusts and oxygen-enrichment hazards before any ignition source enters the space.',
          'Hot work inside or near a confined space requires additional controls, atmospheric testing, ventilation, fire protection and the applicable hot-work permit.',
          'Control cylinders, hoses, electrical equipment, ignition sources and combustible materials according to the approved procedure.',
          'Stop work if atmospheric conditions become unsafe.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '21',
    title: 'Heat, Humidity & Thermal Stress',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Assess heat generated by the environment, process, PPE, physical workload and restricted ventilation.',
          'Provide cooling, hydration, work-rest controls and monitoring appropriate to the heat risk.',
          'Heat-related symptoms require immediate action; do not allow an affected worker to continue simply because the permit remains valid.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '22',
    title: 'Engulfment, Drowning & Material Ingress',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Prevent unexpected entry of liquids, gases, steam, powders, grains, aggregates and other free-flowing materials.',
          'Isolate valves, lines, conveyors, chutes and other sources of material movement.',
          'Where liquid level can rise, establish effective isolation and emergency arrangements before entry.',
          'Never rely on another person simply holding a valve closed without verified isolation.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '23',
    title: 'Mechanical, Electrical & Process Hazards',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Isolate agitators, mixers, conveyors, pumps, fans, valves, moving machinery and other equipment that can start or move.',
          'Control electrical hazards using the applicable electrical safety and isolation procedure.',
          'Consider stored pressure, springs, gravity, rotating parts, heat, chemicals and process residues.',
          'Verify the safe state before entry and after any change to the system.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '24',
    title: 'Lighting, Tools & Equipment',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Use suitable lighting and equipment for the environment and task.',
          'Electrical equipment must be suitable for the hazardous conditions identified by the assessment; use appropriate low-voltage, intrinsically safe or other specified equipment where required.',
          'Control cables, hoses and tools so they do not obstruct escape or create additional hazards.',
          'Inspect equipment before use and remove defective equipment from service.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '25',
    title: 'PPE & Personal Equipment',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Select PPE based on the risk assessment, including head, eye, hand, foot, hearing, respiratory and chemical protection as applicable.',
          'Fall protection or retrieval equipment may be required where the entry configuration creates a fall or rescue hazard.',
          'PPE must be compatible with other equipment and must not interfere with emergency escape or communication.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '26',
    title: 'Simultaneous Operations & Interfaces',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Control welding, grinding, cleaning, painting, electrical work, lifting, excavation, traffic, nearby process operations and other activities that can affect the space.',
          'Coordinate permits and isolate conflicting work.',
          'Prevent unauthorized access to the entry area and protect the space from falling objects or vehicle impact.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '27',
    title: 'Safe Entry Procedure',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Confirm entry is necessary, review RAMS/JSA and permit, verify isolation, prepare access, establish communication and rescue arrangements, test the atmosphere and brief all personnel.',
          'Enter only after the responsible authorization is complete and required controls are confirmed.',
          'Maintain monitoring, communication, ventilation, supervision and boundary controls throughout the work.',
          'Exit immediately when alarm, unsafe condition, communication failure, loss of ventilation, changed conditions or other withdrawal criteria occur.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '28',
    title: 'Inspection, Examination & Records',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Inspect gas detectors, ventilation equipment, retrieval systems, harnesses, ladders, lighting, communication equipment and other entry equipment before use.',
          'Maintain required calibration, inspection, maintenance, training, permit, gas-test and rescue records.',
          'Review incidents, near misses, alarms and abnormal readings and update controls where required.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '29',
    title: 'Medical & Occupational Health Considerations',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Use the entity\'s occupational-health and medical-fitness processes for workers whose assigned duties require them.',
          'Do not make informal medical judgments in the field. Refer individual health concerns through the approved occupational-health process.',
          'Emergency medical response must be available for foreseeable outcomes of the task.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '30',
    title: 'Supervisor / HSE Responsibilities',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Verify the permit, RAMS, isolation, atmospheric testing, ventilation, access, communication, standby and rescue arrangements.',
          'Monitor field compliance and stop work when conditions no longer match the approved controls.',
          'Ensure lessons from incidents, alarms, failed controls and near misses are communicated and corrective actions are tracked.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '31',
    title: 'Stop-Work Conditions',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Stop entry for unsafe atmospheric readings, gas-detector failure, loss of ventilation, loss of communication, loss of isolation, unexpected inflow, rising liquid, material movement, fire or explosion risk, worker symptoms, rescue-system failure, severe weather affecting the task or any condition outside the approved risk assessment.',
          'Evacuate when required and do not re-enter until the hazard is controlled, the atmosphere and isolations are reverified and the permit is revalidated or reissued.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '32',
    title: 'Unsafe Practices → Corrective Actions',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Unsafe practices include entering without authorization, testing only once when conditions can change, relying on smell, bypassing isolation, working without a standby arrangement, improvised rescue, entering after an alarm, using unverified equipment or allowing conflicting work.',
          'Stop work, evacuate if necessary, make the area safe, notify the responsible authority, correct the failed control and verify the complete entry system before restart.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '33',
    title: 'Toolbox Talk',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Explain the space, hazards, permit boundaries, isolation points, atmospheric limits, testing locations, ventilation, communication, standby role, escape route, rescue plan, PPE, prohibited activities and stop-work signals.',
          'Every entrant should know how to recognize an alarm and how to leave the space immediately.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '34',
    title: 'Field Checklist',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          '☐ Entry is necessary and alternatives considered',
          '☐ Confined space identified and assessed',
          '☐ Approved RAMS/JSA available',
          '☐ Correct entry permit authorized',
          '☐ All hazardous energy and process sources isolated',
          '☐ Isolation verified',
          '☐ Atmosphere tested before entry',
          '☐ Required monitoring operating',
          '☐ Ventilation effective',
          '☐ Safe access and egress provided',
          '☐ Standby person assigned',
          '☐ Communication tested',
          '☐ Rescue plan and equipment ready',
          '☐ Competent personnel confirmed',
          '☐ PPE and respiratory controls suitable',
          '☐ Conflicting activities controlled',
          '☐ Emergency arrangements communicated',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '35',
    title: 'Quick Reference',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'PLAN → ELIMINATE ENTRY → ISOLATE → VERIFY → TEST → VENTILATE → AUTHORIZE → ENTER → MONITOR → COMMUNICATE → EXIT → CLOSE.',
          'Never enter an unknown atmosphere.',
          'Never rely on smell to confirm safety.',
          'Never improvise a rescue.',
          'Never continue after an alarm or loss of a critical control.',
          'Permit validity does not override an unsafe condition.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '36',
    title: 'UAE / Abu Dhabi / Dubai Applicability',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'This module is specifically aligned to Abu Dhabi ADOSH-SF CoP 27.0 — Confined Spaces, Version 4.0, July 2024.',
          'ADPHC\'s official technical guideline Safe Work in Confined Spaces is supplementary guidance and states that its content is not mandatory, while helping entities comply with CoP 27.0.',
          'Dubai and other emirates may have different requirements. Client, operator, facility and sector procedures may add controls.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '37',
    title: 'Related CoPs & Cross References',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'CoP 2.0 Personal Protective Equipment.',
          'CoP 4.0 First Aid and Medical Emergency Treatment.',
          'CoP 11.0 Safety in the Heat.',
          'CoP 15.0 Electrical Safety.',
          'CoP 21.0 Permit to Work Systems.',
          'CoP 23.0 Working at Heights.',
          'CoP 24.0 Lock-out/Tag-out and Isolation.',
          'CoP 28.0 Hot Work Operations.',
          'CoP 29.0 Excavation Work.',
          'CoP 34.0 Lifting Equipment and Lifting Accessories.',
          'CoP 35.0 Portable Power Tools.',
          'CoP 39.0 Overhead and Underground Services.',
        ],
      ),
    ],
  ),
  ConfinedSpaceGoldSection(
    number: '38',
    title: 'Official Regulatory References',
    points: [
      ConfinedSpaceGoldPoint(
        title: 'Key Controls',
        points: [
          'Primary source: Abu Dhabi Occupational Safety and Health Center (ADPHC), ADOSH-SF CoP 27.0 — Confined Spaces, Version 4.0, July 2024.',
          'Supplementary official guidance: ADOSH-SF Technical Guideline — Safe Work in Confined Spaces, Version 4.0, 15 July 2024.',
          'Check the official ADPHC registry and current document before relying on any legal, numerical, atmospheric or procedural requirement.',
        ],
      ),
    ],
  ),
];
