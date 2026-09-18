/// SafeNexus HSE — Abu Dhabi HSE Gold Standard
/// Topic: Formwork / False Work
/// Regulatory basis: ADOSH-SF CoP 40.0, Version 4.1, February 2026.
///
/// Structured reference content. Project-specific temporary-works design,
/// RAMS, manufacturer instructions, permits and competent-person requirements
/// remain applicable.

class FormworkGoldPoint {
  final String title;
  final List<String> points;

  const FormworkGoldPoint({required this.title, required this.points});
}

class FormworkGoldSection {
  final String number;
  final String title;
  final List<FormworkGoldPoint> points;

  const FormworkGoldSection({
    required this.number,
    required this.title,
    required this.points,
  });
}

const List<FormworkGoldSection> formworkGoldStandardSections = [
  FormworkGoldSection(
    number: '01',
    title: 'Definition & Purpose',
    points: [
      FormworkGoldPoint(
        title: 'Definition',
        points: [
          'False work and formwork are temporary works used to support, shape or retain concrete and associated construction loads until the permanent structure can safely support itself.',
          'Formwork includes shutters, panels, sheathing and associated components. False work includes props, shores, frames, towers, braces and other temporary supporting systems.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Purpose',
        points: [
          'Provide the required geometry, stability, strength, access and protection during erection, reinforcement, concrete placement, curing and striking.',
          'Prevent collapse, excessive movement, uncontrolled release of stored energy and injury to workers or third parties.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '02',
    title: 'Scope & Applications',
    points: [
      FormworkGoldPoint(
        title: 'Applications',
        points: [
          'Columns, walls, beams, slabs, foundations, shafts, retaining structures, bridge works, tanks and other reinforced-concrete construction.',
          'Includes conventional timber or steel systems, proprietary modular systems, table forms, climbing systems and other temporary support arrangements.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Interface',
        points: [
          'Coordinate formwork with reinforcement, embedded items, concrete placing equipment, lifting operations, access systems, electrical services and other simultaneous work.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '03',
    title: 'Types of Formwork',
    points: [
      FormworkGoldPoint(
        title: 'Common systems',
        points: [
          'Timber formwork, steel formwork, aluminium formwork, modular panel systems, plastic systems and proprietary engineered systems.',
          'Beam forms, column forms, wall forms, slab forms, deck systems, table forms and special geometry forms.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Special systems',
        points: [
          'Climbing, self-climbing, slip-form and other engineered systems require system-specific design, procedures, competent personnel and manufacturer requirements.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '04',
    title: 'Components & Parts',
    points: [
      FormworkGoldPoint(
        title: 'Typical components',
        points: [
          'Panels, sheathing, walers, soldiers, ties, clamps, brackets, props, frames, jacks, base plates, sole plates, braces, working platforms and access components.',
          'Anchors, lifting points, pins, couplers, connectors and proprietary locking devices must be compatible with the approved system.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Component integrity',
        points: [
          'Do not substitute, remove or modify structural components without authorization from the responsible temporary-works or design authority.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '05',
    title: 'Design & Engineering',
    points: [
      FormworkGoldPoint(
        title: 'Design principle',
        points: [
          'Formwork and false work must be designed for the loads and conditions expected during construction, including the concrete placement sequence and relevant construction actions.',
          'Design must account for stability, strength, serviceability, support conditions, connections, bracing and load transfer.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Engineering control',
        points: [
          'Use approved drawings, calculations, specifications and manufacturer information. Do not estimate structural capacity in the field.',
          'Changes to the approved system require formal technical review and authorization.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '06',
    title: 'Planning & Site Assessment',
    points: [
      FormworkGoldPoint(
        title: 'Before erection',
        points: [
          'Confirm approved design, method statement, sequence, competent personnel, lifting plan where applicable and inspection arrangements.',
          'Inspect the supporting ground, slab or permanent structure for suitability, level, strength, openings, edges, services and access.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Site conditions',
        points: [
          'Consider wind, rain, heat, poor visibility, restricted access, traffic, adjacent excavations, overhead services and simultaneous operations.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '07',
    title: 'Hazards — One by One',
    points: [
      FormworkGoldPoint(
        title: 'Major hazards',
        points: [
          'Collapse or instability of formwork or false work.',
          'Overloading, inadequate bearing or uncontrolled settlement.',
          'Falls from height and falls through openings.',
          'Falling panels, components, tools or materials.',
          'Crushing and trapping during erection, adjustment or striking.',
          'Unexpected concrete pressure, movement or blowout.',
          'Lifting and suspended-load hazards.',
          'Contact with electrical services.',
          'Unsafe access, poor housekeeping and manual-handling injuries.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Identification',
        points: [
          'Look for damaged components, missing braces or ties, unsupported members, uneven bases, unauthorized modifications, overloaded platforms, movement, settlement, gaps, leaning, loose connections and deviations from approved drawings.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '08',
    title: 'Structural Stability',
    points: [
      FormworkGoldPoint(
        title: 'Stability controls',
        points: [
          'Provide the designed bracing, ties, props, anchors and restraints in the specified arrangement.',
          'Ensure every load path is complete from the formwork through false work and supports into a verified supporting structure or foundation.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Field verification',
        points: [
          'Check verticality, alignment, base conditions, connections, bracing and restraint before loading.',
          'Do not rely on partially erected systems for stability unless the approved erection sequence specifically permits it.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '09',
    title: 'Loads & Capacity',
    points: [
      FormworkGoldPoint(
        title: 'Load sources',
        points: [
          'Consider fresh concrete, reinforcement, workers, equipment, stored materials, construction loads, impact effects and applicable environmental actions identified by the design.',
          'Concrete placement rate and method can significantly affect lateral pressure and system stability.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Capacity rule',
        points: [
          'Never exceed the approved design capacity, manufacturer rating or stated working load limit.',
          'Where a capacity or spacing is required, use the approved engineering documentation rather than an assumed field value.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '10',
    title: 'Erection Sequence',
    points: [
      FormworkGoldPoint(
        title: 'Safe sequence',
        points: [
          'Set out and prepare the support area, establish exclusion zones, position bases or sole plates, erect primary support, install bracing and connections, then install formwork panels and access systems in the approved sequence.',
          'Progressive stability must be maintained at every stage.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Verification',
        points: [
          'Supervisor and competent personnel must verify each critical stage before the next stage is loaded or released.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '11',
    title: 'Striking & Dismantling',
    points: [
      FormworkGoldPoint(
        title: 'Planning',
        points: [
          'Striking must follow the approved sequence and required concrete-strength or engineering release criteria.',
          'Confirm that the structure and remaining temporary works can safely support the loads after each stage.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Dismantling controls',
        points: [
          'Establish exclusion zones, control falling components, use suitable lifting methods and prevent uncontrolled release.',
          'Do not remove props, ties, braces or supports simply because the concrete surface appears hard.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '12',
    title: 'Props & Supports',
    points: [
      FormworkGoldPoint(
        title: 'Prop controls',
        points: [
          'Use the correct type, length, capacity and configuration specified by the design or manufacturer.',
          'Props must stand on adequate bearing surfaces and be protected from displacement, impact and eccentric loading.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Inspection',
        points: [
          'Check threads, pins, collars, plates, tubes, frames and locking mechanisms. Do not use bent, cracked, corroded or otherwise defective supports.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '13',
    title: 'Shoring & Reshoring',
    points: [
      FormworkGoldPoint(
        title: 'Shoring',
        points: [
          'Shoring must be designed and erected to transfer construction loads safely to the supporting structure or ground.',
          'Account for the condition and capacity of slabs or other supporting elements.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Reshoring',
        points: [
          'Reshoring or back-propping must follow an engineered sequence where required and must not be improvised to compensate for an unsafe condition.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '14',
    title: 'Bracing & Restraint',
    points: [
      FormworkGoldPoint(
        title: 'Controls',
        points: [
          'Install all required horizontal, vertical and diagonal bracing, ties, anchors and restraints.',
          'Protect braces and anchors from impact and unauthorized removal.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Critical check',
        points: [
          'Missing one structural restraint can change the load path and stability of the complete system. Treat missing or damaged bracing as a stop-work condition.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '15',
    title: 'Working Platforms & Access',
    points: [
      FormworkGoldPoint(
        title: 'Access',
        points: [
          'Provide safe access and egress suitable for the work. Do not climb on formwork components that are not designed as access.',
          'Use properly designed working platforms, stairs, ladders or other approved access systems.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Platform safety',
        points: [
          'Keep platforms clear, provide required edge protection and prevent tools and materials from falling.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '16',
    title: 'Formwork at Height',
    points: [
      FormworkGoldPoint(
        title: 'Fall prevention',
        points: [
          'Use collective fall prevention such as compliant platforms, guardrails and protected access wherever practicable.',
          'Where fall arrest is required, provide suitable anchor arrangements, compatible equipment, adequate clearance and a rescue plan.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Openings and edges',
        points: [
          'Protect slab edges, shafts, penetrations and other openings against falls and falling objects.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '17',
    title: 'Openings, Edges & Falling Objects',
    points: [
      FormworkGoldPoint(
        title: 'Controls',
        points: [
          'Cover or guard openings using systems capable of resisting the expected loads and identify covers where needed.',
          'Install toe protection or other measures where materials can fall to lower levels.',
          'Establish exclusion zones below overhead formwork activities where required.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '18',
    title: 'Concrete Pouring Interface',
    points: [
      FormworkGoldPoint(
        title: 'Before pour',
        points: [
          'Confirm formwork is complete, braced, tied, aligned, supported and inspected.',
          'Verify embedded items, reinforcement, access, concrete delivery route and communication arrangements.',
        ],
      ),
      FormworkGoldPoint(
        title: 'During pour',
        points: [
          'Control the pour sequence and rate in accordance with the approved method and design.',
          'Monitor for movement, leakage, distortion, unusual sounds, settlement or other signs of instability.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '19',
    title: 'Concrete Pressure & Pour Rate',
    points: [
      FormworkGoldPoint(
        title: 'Pressure control',
        points: [
          'Fresh concrete can create significant lateral pressure. The design and placing procedure must define the permitted conditions for the system.',
          'Do not accelerate concrete placement beyond the approved rate or change the placing method without technical authorization.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Emergency response',
        points: [
          'If abnormal movement, bulging, leakage or instability is observed, stop the pour, keep personnel out of the danger zone and follow the site emergency and temporary-works procedure.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '20',
    title: 'Mobile & Crane-Lifted Formwork',
    points: [
      FormworkGoldPoint(
        title: 'Lifting',
        points: [
          'Use approved lifting points, lifting accessories and a suitable lifting plan.',
          'Confirm the load is within the lifting equipment and formwork system limits and control the suspended load.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Movement',
        points: [
          'Secure components against unexpected movement. Establish an exclusion zone and use tag lines where appropriate and safe.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '21',
    title: 'RAMS / JSA / Risk Assessment',
    points: [
      FormworkGoldPoint(
        title: 'Minimum content',
        points: [
          'Scope, approved design, sequence, hazards, controls, support conditions, lifting activities, access, fall protection, concrete placement, striking sequence and emergency arrangements.',
          'Identify interfaces with cranes, MEWPs, scaffolds, reinforcement, concrete pumps, electrical systems and traffic.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Review triggers',
        points: [
          'Review when design, sequence, materials, support conditions, equipment, personnel or site conditions change.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '22',
    title: 'PTW / Authorization',
    points: [
      FormworkGoldPoint(
        title: 'Authorization',
        points: [
          'Use the site permit system where required by the activity or location.',
          'Critical temporary-works stages, lifting operations, work at height, hot work, electrical isolation and other controlled activities may require separate authorization under the site system.',
        ],
      ),
      FormworkGoldPoint(
        title: 'No unauthorized change',
        points: [
          'Do not erect, alter or strike a designed temporary-works system without the required authorization and approved information.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '23',
    title: 'Inspection & Examination',
    points: [
      FormworkGoldPoint(
        title: 'Inspection stages',
        points: [
          'Inspect supporting surfaces before erection, components before use, the partially erected system during erection, the completed system before loading, and the system after significant changes or events.',
          'Inspect after impact, abnormal movement, severe weather or any event that may affect stability.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Records',
        points: [
          'Record required inspections, defects, corrective actions, approvals and release for use in accordance with the project system.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '24',
    title: 'Competency & Responsibilities',
    points: [
      FormworkGoldPoint(
        title: 'Workers',
        points: [
          'Only trained and authorized personnel should erect, alter, use or dismantle formwork systems within their assigned competence.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Supervisor',
        points: [
          'Verify approved drawings and method, competent workers, sequence, exclusion zones, inspections and safe conditions.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Temporary-works or design authority',
        points: [
          'Provide or approve the engineering basis and technical changes within the project responsibility structure.',
        ],
      ),
      FormworkGoldPoint(
        title: 'HSE',
        points: [
          'Verify implementation of risk controls, access, fall protection, lifting controls, inspections and corrective actions; stop unsafe work.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '25',
    title: 'PPE',
    points: [
      FormworkGoldPoint(
        title: 'Minimum task-based PPE',
        points: [
          'Safety helmet, safety footwear, suitable gloves and eye protection as required by the task.',
          'Use fall-protection equipment, hearing protection, respiratory protection or other PPE when identified by the risk assessment.',
        ],
      ),
      FormworkGoldPoint(
        title: 'PPE limitation',
        points: [
          'PPE does not compensate for inadequate structural design, missing bracing, unsafe access or defective temporary works.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '26',
    title: 'Weather & Environmental Conditions',
    points: [
      FormworkGoldPoint(
        title: 'Weather',
        points: [
          'Consider wind, rain, heat, reduced visibility and other conditions that can affect erection, lifting, stability or worker safety.',
          'Secure loose components and suspend exposed work when conditions exceed the approved safe limits.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Ground and support',
        points: [
          'Protect support areas from undermining, flooding, settlement, excavation changes or other conditions that could affect load transfer.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '27',
    title: 'Simultaneous Operations',
    points: [
      FormworkGoldPoint(
        title: 'Interface hazards',
        points: [
          'Coordinate formwork with reinforcement fixing, concrete pumps, cranes, lifting, scaffolding, electrical work, MEWP operations, vehicles and pedestrian routes.',
          'Prevent unauthorized personnel from entering temporary-works danger zones.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Coordination',
        points: [
          'Use the project\'s coordination and permit arrangements for high-risk simultaneous operations.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '28',
    title: 'Safe Work Procedure',
    points: [
      FormworkGoldPoint(
        title: 'Before erection',
        points: [
          'Review approved drawings and RAMS, inspect components, prepare the base, establish exclusion zones and verify access and lifting arrangements.',
        ],
      ),
      FormworkGoldPoint(
        title: 'During erection',
        points: [
          'Follow the approved sequence, maintain progressive stability, install required braces and connections, and do not improvise structural details.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Before loading or pouring',
        points: [
          'Complete the required inspection and authorization. Confirm formwork, false work, access and fall protection are ready.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Striking',
        points: [
          'Confirm engineering or project release criteria, isolate the area, follow the dismantling sequence and control falling or suspended components.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '29',
    title: 'Maintenance & Defects',
    points: [
      FormworkGoldPoint(
        title: 'Defects',
        points: [
          'Quarantine damaged, bent, cracked, excessively corroded or otherwise defective components.',
          'Do not straighten, weld, drill or modify structural components unless the responsible engineering authority approves the repair.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Housekeeping',
        points: [
          'Remove concrete buildup and debris where it can interfere with connections, access, alignment or safe operation, using approved methods.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '30',
    title: 'Emergency & Rescue',
    points: [
      FormworkGoldPoint(
        title: 'Collapse or instability',
        points: [
          'Stop work, raise the alarm, keep people outside the collapse zone and do not enter an unstable structure to perform an informal rescue.',
          'Activate the site emergency and rescue plan and use competent emergency responders.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Fall or trapped person',
        points: [
          'Call emergency assistance and use the planned rescue system. Do not create a second casualty by entering an unsafe area without proper controls.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '31',
    title: 'Stop-Work Conditions',
    points: [
      FormworkGoldPoint(
        title: 'Immediate stop',
        points: [
          'Missing or damaged primary bracing, unexpected movement, settlement, bulging, distortion, loose or missing connections, overloaded components, inadequate bearing, unauthorized modification, damaged structural component, unsafe access, failed fall protection or conditions outside the approved design basis.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Restart',
        points: [
          'Do not restart until the cause is identified, the system is made safe, competent technical or supervisory verification is completed and required authorization is obtained.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '32',
    title: 'Unsafe Practices → Corrective Actions',
    points: [
      FormworkGoldPoint(
        title: 'Unsafe examples',
        points: [
          'Removing props early, omitting braces, mixing incompatible components, overloading platforms, storing heavy materials on formwork without design approval, climbing on panels, standing beneath suspended panels, changing pour rate without authorization or striking without release.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Corrective action',
        points: [
          'Stop work, isolate the hazard, restore the approved configuration, obtain technical review where necessary, brief the workforce and verify before restart.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '33',
    title: 'Toolbox Talk',
    points: [
      FormworkGoldPoint(
        title: 'Key briefing points',
        points: [
          'Approved formwork design and erection sequence.',
          'Bracing, ties, props and base conditions.',
          'Fall protection and safe access.',
          'Concrete pour sequence and pressure controls.',
          'Lifting and exclusion zones.',
          'Inspection and release before loading.',
          'Striking sequence and stop-work conditions.',
          'Emergency response for instability or collapse.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '34',
    title: 'Field Checklist',
    points: [
      FormworkGoldPoint(
        title: 'Before erection',
        points: [
          '☐ Approved drawings and RAMS available',
          '☐ Components identified and inspected',
          '☐ Base or supporting structure verified',
          '☐ Correct props, braces and connectors available',
          '☐ Safe access and exclusion zone established',
          '☐ Lifting plan and equipment verified where applicable',
        ],
      ),
      FormworkGoldPoint(
        title: 'Before concrete',
        points: [
          '☐ Formwork complete and aligned',
          '☐ Bracing and ties complete',
          '☐ Props and bearing conditions verified',
          '☐ Openings and edges protected',
          '☐ Access platforms safe',
          '☐ Inspection and release completed',
          '☐ Concrete placing sequence confirmed',
        ],
      ),
      FormworkGoldPoint(
        title: 'During pour',
        points: [
          '☐ Pour rate controlled',
          '☐ Workers monitoring movement and leakage',
          '☐ No unauthorized changes',
          '☐ Exclusion zones maintained',
        ],
      ),
      FormworkGoldPoint(
        title: 'Before striking',
        points: [
          '☐ Required concrete strength or release criteria confirmed',
          '☐ Approved striking sequence available',
          '☐ Area isolated',
          '☐ Falling-object controls established',
          '☐ Remaining supports verified',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '35',
    title: 'Quick Reference',
    points: [
      FormworkGoldPoint(
        title: 'Safety cycle',
        points: [
          'IDENTIFY → ASSESS → DESIGN → ERECT → INSPECT → AUTHORIZE → LOAD → MONITOR → STRIKE → REVIEW.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Golden rules',
        points: [
          'Never improvise structural capacity.',
          'Never remove a prop, brace, tie or anchor without authorization.',
          'Never load an incomplete or uninspected system.',
          'Never stand under suspended formwork.',
          'Never change the concrete placing sequence without technical approval.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '36',
    title: 'UAE / Abu Dhabi / Dubai Applicability',
    points: [
      FormworkGoldPoint(
        title: 'Abu Dhabi',
        points: [
          'This module is specifically aligned to Abu Dhabi ADOSH-SF CoP 40.0 — False Work (Formwork), Version 4.1, February 2026.',
          'Project specifications, temporary-works design requirements and other applicable ADOSH-SF requirements may impose additional controls.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Jurisdiction note',
        points: [
          'Dubai requirements and other emirate or sector requirements must be checked separately. An Abu Dhabi CoP should not be presented as automatically being a Dubai legal requirement.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '37',
    title: 'Related CoPs & Cross References',
    points: [
      FormworkGoldPoint(
        title: 'Relevant Abu Dhabi references',
        points: [
          'CoP 2.0 Personal Protective Equipment.',
          'CoP 15.0 Electrical Safety.',
          'CoP 21.0 Permit to Work Systems.',
          'CoP 23.0 Working at Heights.',
          'CoP 24.0 Lock-out/Tag-out and Isolation where isolation is required.',
          'CoP 26.0 Scaffolding where scaffold access or interfaces apply.',
          'CoP 34.0 Lifting Equipment and Accessories where formwork is lifted.',
          'CoP 36.0 Plant and Equipment where construction plant interfaces apply.',
          'CoP 39.0 Overhead and Underground Services where service hazards apply.',
          'CoP 43.0 Temporary Structures where the temporary structure interface applies.',
          'CoP 53.1 OSH Construction Management Plan.',
        ],
      ),
    ],
  ),
  FormworkGoldSection(
    number: '38',
    title: 'Official Regulatory References',
    points: [
      FormworkGoldPoint(
        title: 'Primary reference',
        points: [
          'Abu Dhabi Occupational Safety and Health Center (ADPHC), ADOSH-SF CoP 40.0 — False Work (Formwork), Version 4.1, February 2026.',
          'Check the official ADPHC Code of Practices registry for the current version, effective date and applicability before relying on a regulatory requirement.',
        ],
      ),
      FormworkGoldPoint(
        title: 'Engineering reference',
        points: [
          'Use the approved project temporary-works design, structural calculations, drawings, specifications and manufacturer instructions for system-specific dimensions, loads, capacities, spacing and release criteria.',
          'Do not substitute generic field values for project-specific engineering requirements.',
        ],
      ),
    ],
  ),
];
