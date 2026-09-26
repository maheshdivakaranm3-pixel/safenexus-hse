// lib/data/abu_dhabi/abu_dhabi_cop_27_28_29.dart

import 'abu_dhabi_cop_01_to_03.dart';
//
// SafeNexus HSE – Abu Dhabi HSE Reference
//
// Official ADOSH-SF / ADPHC Codes of Practice
// CoP 27.0 – Confined Spaces – V4.0 – Effective 15 July 2024
// CoP 28.0 – Hot Work Operations – V4.1 – Effective 27 February 2026
// CoP 29.0 – Excavation Work – V4.1 – Effective 27 February 2026
//
// This is a paraphrased, structured field-reference dataset.
// Official publications remain the controlling source for regulatory decisions.

class AbuDhabiCop27To29 {
  static const List<AbuDhabiCopDocument> documents = [
    AbuDhabiCop27.document,
    AbuDhabiCop28.document,
    AbuDhabiCop29.document,
  ];
}

class AbuDhabiCop27 {
  static const String code = '27.0';
  static const String title = 'Confined Spaces';
  static const String version = '4.0';
  static const String effectiveDate = '15 July 2024';

  static const List<AbuDhabiCopSection> sections = [
    AbuDhabiCopSection(
      number: '1',
      title: 'Introduction',
      requirements: ['The CoP applies to all employers within Abu Dhabi.', 'Assess confined-space risks and implement controls according to the hierarchy of controls.', 'Use the ADOSH-SF Technical Guideline on Safe Work in Confined Spaces as additional non-mandatory guidance.'],
      hazards: ['Fire or explosion', 'Oxygen deficiency or unsafe atmosphere', 'Toxic gas, fume or vapour', 'Heat', 'Flooding/liquid ingress', 'Free-flowing solids/engulfment', 'Restricted rescue'],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '2.1',
      title: 'General Training',
      requirements: ['Train relevant employees on confined-space hazards.', 'Train employees on the need to prevent unauthorised entry.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '2.2',
      title: 'Specific Confined Space Entry Training',
      requirements: ['Training shall comply with ADOSH-SF Element 5 and Mechanism 7.0.', 'Cover hazard identification, equipment selection/testing, permits, safe procedures, hygiene, gas detection, PPE/RPE and emergency procedures.', 'Retrain before first assignment, after duty/operational changes creating new hazards, or when procedural/knowledge deficiencies are identified.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.1',
      title: 'Roles and Responsibilities',
      requirements: ['Identify and record confined-space activities.', 'Allow entry only when the purpose cannot reasonably be achieved without entry.', 'Ensure entrants are competent and aware of emergency procedures.', 'Employees shall follow authorised procedures and immediately report hazards or defects.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.2',
      title: 'Planning and Assessment',
      requirements: ['Assess risks and establish safe systems for affected persons and the public where applicable.', 'For construction, include confined-space controls in the applicable Pre-Tender Safety and Health Plan and OSH-CMP.', 'Identify isolation, atmosphere, ventilation, access, egress, communication and rescue requirements.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.3',
      title: 'Definition and Specified Risk',
      requirements: ['Apply the official confined-space definition to enclosed places where a reasonably foreseeable specified risk exists.', 'Do not assume a space is safe merely because a person can physically enter.'],
      hazards: ['Serious injury from fire/explosion', 'Loss of consciousness from excessive body temperature', 'Loss of consciousness/asphyxiation from gas, vapour or lack of oxygen', 'Drowning from rising liquid', 'Asphyxiation/entrapment from free-flowing solids'],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.4',
      title: 'Identification of Confined Spaces',
      requirements: ['Identify and record confined spaces.', 'Control unauthorised entry.', 'Use appropriate confined-space warning signage and communicate hazards and safe entry procedures.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.5',
      title: 'Work in Confined Spaces',
      requirements: ['Develop a Permit Required Confined Spaces Program where required.', 'Maintain a PRCS list, competent entry personnel, competent rescue personnel and equipment/calibration information.', 'Maintain entry and supervision records.', 'Maintain a specific risk assessment and safe working procedure for each PRCS.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.6',
      title: 'Risk Assessment',
      requirements: ['Conduct an entry-specific risk assessment.', 'Consider space hazards, task hazards, connected systems, atmosphere, residues, energy, liquids, gases, heat, fire, access, rescue and communication.', 'Apply the hierarchy of controls and avoid entry where reasonably practicable.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.7',
      title: 'Safe Working Procedure',
      requirements: ['Make the procedure specific to the activity, time and date.', 'Provide supervision/safety watch and reliable communication.', 'Test/monitor atmosphere, ventilate, isolate hazardous materials and energy, provide safe access/egress, PPE/RPE, fire controls and suitable lighting.', 'Control portable gas cylinders and internal-combustion engines.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.8',
      title: 'Emergency Procedures',
      requirements: ['Prepare specific rescue arrangements before PRCS entry.', 'Rescue arrangements shall be suitable for the space, hazards and access limitations.', 'Rescue personnel and equipment shall be competent/appropriate.', 'Do not create additional casualties by sending unprotected persons into the space.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.9',
      title: 'Communication',
      requirements: ['Provide reliable communication between entrants and persons outside.', 'Communication shall allow help to be summoned and emergency procedures initiated.', 'Use intrinsically safe equipment where required and test communication before/throughout work.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.5.1',
      title: 'Permit Required Confined Spaces Program — Field Content',
      requirements: [
        'Maintain a current list of all identified Permit Required Confined Spaces (PRCS).',
        'Record the normal activities undertaken in each PRCS and identify the competent persons authorised to enter.',
        'Maintain the list of competent emergency-rescue personnel relevant to the spaces.',
        'Maintain associated equipment records, including calibration requirements for atmospheric-monitoring equipment.',
        'Record each entry, including persons entering and persons supervising the task.',
        'Keep the space-specific risk assessment and safe working procedure with the PRCS program.',
        'Make the PRCS program readily available for inspection by staff and relevant regulatory authorities.',
      ],
      documents: [
        'PRCS register',
        'Competent entrant register',
        'Rescue-person register',
        'Equipment and calibration records',
        'Entry records',
        'Space-specific risk assessments',
        'Safe working procedures',
      ],
      hazards: ['Uncontrolled entry', 'Unverified competence', 'Unavailable rescue capability', 'Expired or uncalibrated monitoring equipment'],
      controls: ['Controlled access', 'Competency verification', 'Equipment register and calibration control', 'Entry logging', 'Space-specific procedures'],
      inspection: ['Check the PRCS register against actual site spaces.', 'Verify competent-person and rescue-person records.', 'Verify equipment status and calibration information before entry.'],
    ),
    AbuDhabiCopSection(
      number: '3.6.1',
      title: 'Confined-Space Risk Assessment — Entry-Specific Review',
      requirements: [
        'Make the risk assessment specific to the activity, time and date of the entry.',
        'Identify hazards arising from the space itself and from the work being performed inside it.',
        'Consider the effect of the work on people outside the space and on the surrounding area.',
        'Review previous contents, residues and contamination that may remain inside the space.',
        'Consider foreseeable emergency scenarios created or worsened by the work.',
        'Apply the hierarchy of controls and avoid entry when the purpose can reasonably be achieved without entry.',
        'Keep the completed risk assessment within the PRCS program as the entry record.',
      ],
      hazards: ['Residual chemicals', 'Stored energy', 'Atmospheric change', 'Heat stress', 'Fire/explosion', 'Flooding', 'Engulfment', 'Difficult rescue'],
      controls: ['Elimination/non-entry where practicable', 'Isolation', 'Ventilation', 'Atmospheric monitoring', 'Engineering controls', 'Safe system of work', 'PPE/RPE'],
      documents: ['Entry-specific risk assessment', 'Task method statement / safe working procedure', 'Isolation records', 'Gas-test records'],
    ),
    AbuDhabiCopSection(
      number: '3.7.1',
      title: 'Safe Working Procedure — Minimum Field Elements',
      requirements: [
        'Provide a safety watch/supervision arrangement appropriate to the entry.',
        'Confirm competence of persons entering the PRCS.',
        'Define communication methods and emergency communication actions.',
        'Define atmospheric testing and monitoring arrangements, including where measurements are taken within the space.',
        'Define ventilation and residue-removal arrangements.',
        'Isolate gases, hazardous materials, liquids, flowing materials and mechanical/electrical energy as applicable.',
        'Specify equipment, PPE and RPE suitable for the identified hazards.',
        'Control portable gas cylinders and internal-combustion engines.',
        'Provide safe access and egress, fire prevention/control and suitable lighting.',
        'Limit exposure duration where the risk assessment identifies a need for controlled working periods.',
      ],
      hazards: ['Atmospheric contamination', 'Energy release', 'Poor visibility', 'Fire', 'Excessive exposure time', 'Communication failure'],
      controls: ['Isolation and verification', 'Continuous/periodic monitoring as required', 'Forced ventilation where required', 'Standby/safety watch', 'Suitable PPE/RPE', 'Safe access/egress'],
      inspection: ['Verify controls before entry and whenever conditions change.', 'Recheck monitoring, ventilation and communications after interruptions or changes.'],
    ),
    AbuDhabiCopSection(
      number: '3.8.1',
      title: 'Emergency and Rescue — Readiness',
      requirements: [
        'Prepare rescue arrangements before PRCS entry; entry is not permitted without appropriate arrangements.',
        'Make rescue arrangements specific to the activity, time and date of entry.',
        'Design rescue controls so that rescuers are not exposed to avoidable additional risk.',
        'Provide and maintain resuscitation equipment where resuscitation is a reasonably foreseeable consequence of the specified risk.',
        'Confirm rescue communication, access/egress routes and equipment readiness before entry.',
        'Ensure rescue arrangements reflect the actual configuration and hazards of the space rather than relying on a generic plan.',
      ],
      hazards: ['Unplanned rescue entry', 'Secondary casualty', 'Delayed emergency response', 'Inadequate resuscitation capability'],
      controls: ['Pre-planned rescue', 'Competent rescue personnel', 'Suitable rescue equipment', 'Emergency communication', 'Rescue-access verification'],
      documents: ['Rescue plan', 'Emergency contact list', 'Rescue equipment inspection records', 'Emergency drill/training records where applicable'],
    ),
    AbuDhabiCopSection(
      number: '3.10',
      title: 'Confined Space Entry Permit / PTW',
      requirements: ['Complete the confined-space entry permit before entry.', 'All permit conditions must be satisfied and verified before entry.', 'Follow CoP 21.0 PTW requirements.', 'Entry permits shall be specific to the activity, time and date.', 'Test atmosphere, maintain required ventilation, supervision, standby, isolation, access/egress and fire controls.', 'Secure the area when the permit expires and close/sign off the permit after completion.'],
      hazards: [],
      measurements: ['Oxygen: 19.5%–23.5% where specified by the CoP', 'Flammable gas/vapour: below 5% LEL where specified by the CoP'],
    ),
  ];

  static const List<String> fieldChecklist = [
    'Space identified and recorded.',
    'Entry necessity assessed.',
    'PRCS programme available where required.',
    'Specific risk assessment and safe working procedure completed.',
    'Competent entrants confirmed.',
    'Safety watch/standby confirmed.',
    'Isolation completed and verified.',
    'Atmosphere tested and monitored as required.',
    'Ventilation established.',
    'Communication tested.',
    'Rescue arrangements ready.',
    'Permit authorised before entry.',
    'Personnel accounted for and permit closed.',
  ];

  static const List<String> stopWorkIndicators = [
    'Unauthorised entry',
    'Missing/invalid permit',
    'Unsafe atmosphere',
    'Loss of isolation',
    'Unexpected gas/liquid/material ingress',
    'Loss of communication',
    'No required standby/safety watch',
    'Rescue arrangements unavailable',
    'Unsafe access/egress',
    'Fire/explosion condition',
    'Changed conditions not covered by permit',
  ];

  static const List<String> references = [
    'Official ADPHC CoP 27.0 – Confined Spaces V4.0 – 15 July 2024',
    'ADOSH-SF Technical Guideline 8.0 – Safe Work in Confined Spaces V4.0',
    'ADOSH-SF Technical Guideline – Safe Work in Confined Spaces',
    'CoP 21.0 – Permit to Work Systems',
  ];

  static const AbuDhabiCopDocument document = AbuDhabiCopDocument(
    code: 'CoP 27.0',
    title: 'Confined Spaces',
    version: '4.0',
    effectiveDate: '15 July 2024',
    introduction: 'Official ADPHC / ADOSH-SF field-reference dataset for CoP 27.0 – Confined Spaces. This is a paraphrased operational reference; the current official CoP remains the controlling source.',
    sections: sections,
    fieldChecklist: fieldChecklist,
    stopWorkIndicators: stopWorkIndicators,
    references: references,
    protectionItems: [
      'Confined-space warning/signage and controlled access',
      'Atmospheric monitoring and suitable ventilation',
      'Isolation and verification of hazardous energy/material flow',
      'Reliable communication',
      'Suitable PPE/RPE based on risk assessment',
      'Rescue equipment and emergency arrangements',
    ],
    verificationNote: 'Verify the current official ADPHC publication and project-specific legal requirements before making a compliance determination.',
  );
}

class AbuDhabiCop28 {
  static const String code = '28.0';
  static const String title = 'Hot Work Operations';
  static const String version = '4.1';
  static const String effectiveDate = '27 February 2026';

  static const List<AbuDhabiCopSection> sections = [
    AbuDhabiCopSection(
      number: '1',
      title: 'Introduction',
      requirements: ['The CoP applies to all employers within Abu Dhabi.', 'Hot work includes welding, cutting, grinding, heating and other heat/spark-producing operations.', 'Apply controls during construction, maintenance, repair and demolition and where plant/equipment may contain flammable, combustible or explosive material.'],
      hazards: ['Fire', 'Explosion', 'Burns', 'Fumes/gases', 'Electric shock', 'Radiation', 'Cylinder/pressure hazards', 'Flashback'],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '2',
      title: 'Training and Competency',
      requirements: ['Training shall comply with Element 5 and Mechanism 7.0.', 'Cover safe systems, equipment selection, PPE, care, maintenance and inspection.', 'Retrain where inspections identify deviations or inadequate knowledge.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.1',
      title: 'Roles and Responsibilities',
      requirements: ['Employers shall provide suitable, maintained equipment and plan, organise and supervise hot work.', 'Ensure users are trained and competent.', 'Employees shall inspect equipment before use and report defects.', 'Apply occupational health/medical surveillance and air monitoring where required.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.2',
      title: 'Planning and Assessment',
      requirements: ['Outside a designated hot-work area, use a specific Hot Work Permit to Work.', 'Apply CoP 21.0 PTW requirements.', 'Assess fire, explosion, fumes, electrical and radiation hazards.', 'Construction activities shall integrate controls into the applicable construction OSH plans.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.3',
      title: 'Hot Work',
      requirements: ['Make SDS information for electrodes, fluxes and coatings available.', 'Protect welders and nearby persons from sparks, hot metal and harmful radiation.', 'Use screens and welding booths where reasonably practicable.', 'Keep gas systems, cylinders, regulators and hoses in good condition.', 'Provide suitable first-aid capability for burns, fumes/gases and welding-flash injuries.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.3.2',
      title: 'Designated Hot Work Areas',
      requirements: ['Use designated permanent hot-work areas where reasonably practicable.', 'Construct from non-combustible/fire-resistive materials.', 'Keep essentially free of combustibles and flammables.', 'Provide suitable segregation, fire protection, ventilation and management approval.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.3.3',
      title: 'Fumes and Gases',
      requirements: ['Reduce exposure to harmful fumes and gases.', 'Remove hazardous coatings where appropriate.', 'Use suitable general/dilution ventilation or local exhaust ventilation.', 'Position LEV close to the welding source where required.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.3.4',
      title: 'Electricity and Radiation',
      requirements: ['Use welding equipment to manufacturer requirements.', 'Use suitable RCD and earthing arrangements.', 'Protect welding cables from sparks/hot metal.', 'Use suitable radiation screens.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.3.5',
      title: 'Preventing Fire',
      requirements: ['Move the workpiece to a safe location where practicable.', 'Remove or protect combustibles.', 'Check concealed spaces behind walls/partitions.', 'Prevent sparks/hot particles passing through openings.', 'Maintain fire watch during work and for the specified post-work period.', 'Keep fire extinguishers nearby.'],
      hazards: [],
      measurements: ['Remove combustible materials within 10 m where specified', 'Fire watch for at least 1 hour after work where specified'],
    ),
    AbuDhabiCopSection(
      number: '3.4',
      title: 'Hazardous Areas',
      requirements: ['Obtain a Hot Work Permit.', 'Verify ventilation and isolation.', 'Test for flammable gas/vapour.', 'Maintain flammable gas/vapour below 5% LEL where specified by the CoP.', 'Provide fire-fighting equipment, safe access/exit and required supervision.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.5',
      title: 'Electric Arc Welding',
      requirements: ['Use equipment to manufacturer requirements.', 'Use suitable insulated leads and return cables.', 'Inspect leads and return cables at least daily.', 'Secure welding return to the workpiece.', 'Use fully insulated electrode holders.', 'De-energise during substantial breaks and prevent accidental arcing.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.6',
      title: 'Gas Welding',
      requirements: ['Keep oxy-fuel fittings free from grease/oil.', 'Check regulators at least daily.', 'Do not use regulators showing creep.', 'Use correct hose colours/fittings.', 'Do not use copper in acetylene lines.', 'Fit flashback arresters.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.7',
      title: 'Gas Cylinders',
      requirements: ['Store cylinders vertically and secure against falling.', 'Separate full and empty cylinders.', 'Protect cylinders from sunlight and excessive heat.', 'Separate oxygen from acetylene/LPG as specified.', 'Use purpose-built trolleys and safe lifting carriers.', 'Do not roll or drop cylinders.', 'Use appropriate regulators, leak checks, dedicated hoses and flashback/non-return protection.'],
      hazards: [],
      measurements: ['Oxygen separation from acetylene/LPG: 6 m where specified', 'Acetylene cylinder after accidental horizontal position: stand upright 15 minutes before use'],
    ),
    AbuDhabiCopSection(
      number: '3.8',
      title: 'Inspection',
      requirements: ['Users shall visually check equipment before use.', 'Competent persons shall perform formal inspections.', 'Leak-test joints at working pressure at the required frequency.', 'Remove malfunctioning equipment from service immediately.'],
      hazards: [],
      measurements: ['Daily visual/leak check', 'Weekly where in constant use or before every use as applicable', 'Six-monthly functional test', 'Five-year refurbishment/replacement or manufacturer requirement'],
    ),
  ];

  static const List<String> fieldChecklist = [
    'Hot-work risk assessment completed.',
    'Required Hot Work Permit completed.',
    'Combustibles removed/protected.',
    'Fire extinguishers available.',
    'Fire watch established where required.',
    'Required post-work fire watch completed.',
    'Gas test completed in hazardous areas.',
    'Ventilation adequate.',
    'Welding screens installed.',
    'Electrical welding equipment inspected.',
    'Cylinders upright/secured.',
    'Oxygen/fuel gas separation maintained.',
    'Hoses/regulators inspected.',
    'Flashback protection installed.',
    'Post-work area checked and permit closed.',
  ];

  static const List<String> stopWorkIndicators = [
    'Hot work without required permit',
    'Unsafe gas test',
    'Combustibles uncontrolled',
    'No required fire watch',
    'Defective welding/cutting equipment',
    'Damaged hose/regulator/cylinder attachment',
    'Missing flashback protection',
    'Poor ventilation/uncontrolled fumes',
    'Unsafe electrical welding arrangement',
    'Cylinder instability',
    'Fire, gas leak or uncontrolled ignition',
  ];

  static const List<String> references = [
    'Official ADPHC CoP 28.0 – Hot Work Operations (e.g. Welding and Cutting) V4.1 – 27 February 2026',
    'CoP 21.0 – Permit to Work Systems',
    'CoP 2.0 – PPE',
  ];

  static const AbuDhabiCopDocument document = AbuDhabiCopDocument(
    code: 'CoP 28.0',
    title: 'Hot Work Operations',
    version: '4.1',
    effectiveDate: '27 February 2026',
    introduction: 'Official ADPHC / ADOSH-SF field-reference dataset for CoP 28.0 – Hot Work Operations. This is a paraphrased operational reference; the current official CoP remains the controlling source.',
    sections: sections,
    fieldChecklist: fieldChecklist,
    stopWorkIndicators: stopWorkIndicators,
    references: references,
    protectionItems: [
      'Welding helmet/filtered eye protection appropriate to the process',
      'Fire-resistant gloves and protective clothing',
      'Suitable footwear and additional protection such as apron/spats where required',
      'Welding screens and fire-resistant barriers',
      'Suitable fire extinguishing equipment and fire-watch arrangements',
      'Gas-cylinder, regulator, hose and flashback protection',
    ],
    verificationNote: 'Verify the current official ADPHC publication and project-specific legal requirements before making a compliance determination.',
  );
}

class AbuDhabiCop29 {
  static const String code = '29.0';
  static const String title = 'Excavation Work';
  static const String version = '4.1';
  static const String effectiveDate = '27 February 2026';

  static const List<AbuDhabiCopSection> sections = [
    AbuDhabiCopSection(
      number: '1',
      title: 'Introduction',
      requirements: ['The CoP applies to all employers within Abu Dhabi.', 'Assess excavation risks and implement controls according to the hierarchy of controls.', 'Address excavation planning, ground conditions, water, slopes, support, access, lighting, ventilation, barriers, inspections and cofferdams/caissons.'],
      hazards: ['Collapse', 'Underground services', 'Groundwater', 'Flooding', 'Adjacent-structure instability', 'Plant/traffic', 'Falls', 'Hazardous atmosphere', 'Poor access'],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '2',
      title: 'Training and Competency',
      requirements: ['Training shall comply with Element 5 and Mechanism 7.0.', 'Train excavation workers, safe-system authors, site managers, supervisors, plant operators and PPE users.', 'Cover hazards, risk assessment, control measures, emergency rescue, first aid, night work, debris removal, security and personnel restriction.', 'Retrain when duties or hazards change or deficiencies are identified.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.1',
      title: 'Roles and Responsibilities',
      requirements: ['Conduct risk assessment with relevant stakeholders.', 'Identify, locate and mark underground services.', 'Survey the site and confirm alignments/boundaries.', 'Obtain drawings and surrounding-property information.', 'Validate service searches.', 'Develop documented safe systems of work.', 'Obtain permits/authorisations and nominate competent excavation supervision.', 'Provide public protection, site security, information, training and supervision.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.2',
      title: 'Planning and Assessment',
      requirements: ['Complete risk assessment before excavation.', 'Identify services, boundaries, adjacent structures and public/traffic risks.', 'Obtain and validate drawings and service information.', 'Define excavation method, support method, access, lighting, ventilation, barriers and emergency controls.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.2.4',
      title: 'Site Survey and Plans',
      requirements: ['Survey alignments and boundaries correctly.', 'Obtain available diagrams, maps, drawings and specifications.', 'Assess surrounding properties.', 'Safeguard relevant historical, archaeological or geological features.', 'Notify adjoining property owners where required.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.2.5',
      title: 'Services Search',
      requirements: ['Conduct all applicable underground-service searches.', 'Validate the search information.', 'Follow service-owner requirements for locating exact service positions.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.2.6',
      title: 'Validation Area Risk Assessment',
      requirements: ['Use the service-owner validation area around presumed service locations.', 'Conduct the validation-area risk assessment with the asset owner.', 'Consider overlapping service validation areas.', 'Include controls in the documented safe system of work.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.3',
      title: 'Ground Conditions',
      requirements: ['Identify ground type before excavation.', 'Review borehole/trial-pit information where available.', 'Consider water table effects.', 'Consider contaminated ground.', 'Consider weather, vibration, adjacent excavation and loading changes.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.4',
      title: 'Ground Water',
      requirements: ['Use suitable dewatering methods such as shallow-well pumping or well-pointing.', 'Use sheet piling where suitable for the geological condition.', 'Prevent silty water discharge to drains/watercourses.', 'Use suitable barriers and approved disposal routes.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.5',
      title: 'Temporary Safe Slopes',
      requirements: ['Use competent assessment of actual ground conditions.', 'Indicative temporary slope values must be considered with site-specific conditions and engineering judgment.'],
      hazards: [],
      measurements: ['Boulders: dry 35–45°, wet 30–40°', 'Cobbles: dry 35–40°, wet 30–35°', 'Gravel: dry 30–40°, wet 10–30°', 'Sand: dry 30–35°, wet 10–30°', 'Silt: dry 20–40°, wet 5–20°', 'Soft clay: dry 20–30°, wet 10–20°', 'Firm clay: dry 30–40°, wet 20–25°', 'Stiff clay: dry 40–45°, wet 25–35°'],
    ),
    AbuDhabiCopSection(
      number: '3.6',
      title: 'Choice of Support Method',
      requirements: ['Select support based on plant, site conditions and competent operator availability.', 'Methods may include sheeting/waling/strutting, hydraulic struts, proprietary systems and soldier piles.', 'Install support progressively and without unnecessary exposure.', 'Do not leave adjacent buried services unsupported.', 'Provide suitable stop-end bracing.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.7',
      title: 'Support Systems',
      requirements: ['Provide timbering/shoring for trenches/excavations greater than 1.2 m deep where material could fall or collapse.', 'Use trained persons and competent engineering for larger excavations.', 'Provide support materials before excavation.', 'Use sound, defect-free, secure supports.', 'Only competent persons under supervision shall erect, alter or dismantle supports.', 'Use protective boxes/cages where required during installation.'],
      hazards: [],
      measurements: ['Support trigger: greater than 1.2 m where material could fall/collapse'],
    ),
    AbuDhabiCopSection(
      number: '3.8',
      title: 'Access',
      requirements: ['Provide safe entry and exit.', 'Secure and maintain ladders.', 'Provide escape capability during flooding or falling materials.', 'Do not use walings or struts as access/egress.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.9',
      title: 'Site Lighting',
      requirements: ['Provide appropriate lighting.', 'Pay particular attention to openings, access points and lifting operations.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.10',
      title: 'Ventilation',
      requirements: ['Keep excavations clear of suffocating, toxic or explosive gases.', 'Consider hydrogen sulphide, methane, sulphur dioxide, plant exhaust, pipe leaks and LPG leakage.', 'Use clean-air ventilation where appropriate.', 'Apply CoP 27.0 where excavation conditions also create confined-space risks.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.11',
      title: 'Barriers around Excavations',
      requirements: ['Provide rigid barriers where a person may fall more than 2 m.', 'Below 2 m, physically demarcate excavation edges.', 'Use barriers to prevent materials, plant and vehicles approaching the edge.', 'Replace temporarily removed barriers promptly.', 'Use warning lights during darkness near public routes.', 'Apply road-work and barricading requirements where applicable.'],
      hazards: [],
      measurements: ['Rigid barrier where fall may exceed 2 m', 'Barrier height: 950 mm', 'Ladder set-up: not flatter than 4:1 where reasonably practicable', 'Ladder projection above ground: at least 1 m / 4 rungs'],
    ),
    AbuDhabiCopSection(
      number: '3.12',
      title: 'Maintenance Inspections',
      requirements: ['Maintain vigilance when excavations are newly opened or unsupported.', 'Inspect timber and support components.', 'Control shrinkage, loosened timbering and displaced struts.', 'Control slumping soil and loose material during bad weather.', 'Keep heavy vehicles and plant away from edges unless support is designed for the loading.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.13',
      title: 'Inspection and Examination',
      requirements: ['Inspect excavation/support before entry and after events that may affect stability.', 'Check ground movement, supports, water, barriers, access, services, adjacent structures and plant controls.', 'Record defects and correct unsafe conditions before work continues.'],
      hazards: [],
      measurements: [],
    ),
    AbuDhabiCopSection(
      number: '3.14',
      title: 'Cofferdams and Caissons',
      requirements: ['Use appropriate engineering design.', 'Control water ingress and stability.', 'Provide safe access/egress.', 'Provide dewatering and emergency arrangements.', 'Assess atmospheric hazards where the structure can become a confined space.'],
      hazards: [],
      measurements: [],
    ),
  ];

  static const List<String> fieldChecklist = [
    'Excavation risk assessment completed.',
    'Site survey completed.',
    'Services search completed and validated.',
    'Services marked.',
    'Validation-area assessment completed.',
    'Ground conditions assessed.',
    'Water table considered.',
    'Dewatering controls established.',
    'Support/sloping method selected.',
    'Support materials available and sound.',
    'Competent supervision assigned.',
    'Safe access/egress provided.',
    'Barriers/demarcation installed.',
    'Vehicle/plant edge controls established.',
    'Lighting adequate.',
    'Atmospheric hazards considered.',
    'Inspection system active.',
    'Post-rain/event inspection completed where required.',
    'Emergency arrangements established.',
  ];

  static const List<String> stopWorkIndicators = [
    'Unknown/unvalidated underground service',
    'Suspected service strike',
    'Ground cracking/slumping/bulging',
    'Missing/displaced support',
    'Water ingress affecting stability',
    'Flooding',
    'Heavy plant too close without designed support',
    'Unsafe access/egress',
    'Missing required barriers',
    'Hazardous atmosphere',
    'Adjacent structure movement',
    'Unauthorised support alteration',
    'Severe weather affecting stability',
  ];

  static const List<String> references = [
    'Official ADPHC CoP 29.0 – Excavation Work V4.1 – 27 February 2026',
    'CoP 22.0 – Barricading of Hazards',
    'CoP 27.0 – Confined Spaces',
    'CoP 33.0 – Working On or Adjacent to a Road',
  ];

  static const AbuDhabiCopDocument document = AbuDhabiCopDocument(
    code: 'CoP 29.0',
    title: 'Excavation Work',
    version: '4.1',
    effectiveDate: '27 February 2026',
    introduction: 'Official ADPHC / ADOSH-SF field-reference dataset for CoP 29.0 – Excavation Work. This is a paraphrased operational reference; the current official CoP remains the controlling source.',
    sections: sections,
    fieldChecklist: fieldChecklist,
    stopWorkIndicators: stopWorkIndicators,
    references: references,
    protectionItems: [
      'Excavation support, battering or benching as required by ground conditions',
      'Safe access/egress and protected ladders',
      'Rigid barriers or physical edge demarcation',
      'Vehicle and plant edge protection',
      'Service-location and isolation controls',
      'Atmospheric monitoring where conditions require it',
    ],
    verificationNote: 'Verify the current official ADPHC publication and project-specific legal requirements before making a compliance determination.',
  );
}

