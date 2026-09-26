// lib/data/abu_dhabi/abu_dhabi_cop_01_to_03.dart
// SafeNexus HSE — Abu Dhabi HSE Reference
// CoP 1.0–3.1 source-structured field reference.
// Content is paraphrased/structured from official ADPHC/ADOSH-SF English documents.

class AbuDhabiCopSection {
  final String number;
  final String title;
  final List<String> requirements;
  final List<String> measurements;
  final List<String> documents;
  final List<String> hazards;
  final List<String> controls;
  final List<String> inspection;

  const AbuDhabiCopSection({
    required this.number,
    required this.title,
    this.requirements = const [],
    this.measurements = const [],
    this.documents = const [],
    this.hazards = const [],
    this.controls = const [],
    this.inspection = const [],
  });
}

class AbuDhabiCopDocument {
  final String code;
  final String title;
  final String version;
  final String effectiveDate;
  final String introduction;
  final List<AbuDhabiCopSection> sections;
  final List<String> fieldChecklist;
  final List<String> stopWorkIndicators;
  final List<String> references;
  final String verificationNote;
  final List<String> protectionItems;

  const AbuDhabiCopDocument({
    required this.code,
    required this.title,
    required this.version,
    required this.effectiveDate,
    required this.introduction,
    required this.sections,
    this.fieldChecklist = const [],
    this.stopWorkIndicators = const [],
    this.references = const [],
    this.verificationNote = '',
    this.protectionItems = const [],
  });
}

class AbuDhabiCop01To03 {
  static const String registrySource =
      'Abu Dhabi Public Health Centre (ADPHC) — Code of Practices registry';

  static const List<AbuDhabiCopDocument> documents = [
    hazardousMaterials,
    asbestos,
    lead,
    ppe,
    occupationalNoise,
    vibration,
  ];

  static const hazardousMaterials = AbuDhabiCopDocument(
    code: 'CoP 1.0',
    title: 'Hazardous Materials',
    version: '4.0',
    effectiveDate: '15 July 2024',
    introduction:
        'Applies to Abu Dhabi entities that import, store, transport, sell or use hazardous materials. The purpose is to reduce risks to workers and the community through risk assessment, legal compliance, competent management, safe storage and handling, emergency preparedness and the hierarchy of controls.',
    sections: [
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Training and Competency',
        requirements: [
          'Provide hazardous-material awareness before work starts.',
          'Train people according to their responsibilities in handling, storage, transport, classification, labelling, disposal and emergency response.',
          'Training should cover SDS use, PPE, properties and risks, storage and decanting, disposal, spill prevention, incompatible materials, labelling and incident controls.',
          'Transport personnel additionally need safe driving, loading, securing, incident and spill-response, journey-management and approved-route awareness.',
          'Training must be delivered in a language and method appropriate to the workforce.',
        ],
        documents: ['Training records', 'SDS / profile sheets', 'Emergency response information'],
      ),
      AbuDhabiCopSection(
        number: '3.1',
        title: 'Roles and Responsibilities',
        hazards: ['Unidentified hazardous materials', 'Uncontrolled exposure', 'Incorrect storage or transport', 'Fire, toxic release and incompatible reactions'],
        requirements: [
          'Complete a risk assessment covering activities, products, services and hazardous materials present or handled.',
          'Identify and comply with applicable Federal, Abu Dhabi and competent-authority requirements and manufacturer SDS information.',
          'Obtain required permits, licences, approvals and other documentation.',
          'Appoint competent persons to oversee storage, use and disposal.',
          'Inspect stored and used materials routinely; replace damaged or unclear labels and manage expired materials correctly.',
          'Use approved waste-management routes and contractors for hazardous waste.',
          'Manufacturers and distributors must maintain classification, SDS, labelling and inventory controls applicable to their role.',
          'Transport operations require compatible packaging, secured loads, suitable vehicles, emergency equipment, permitted vehicles and qualified drivers.',
        ],
        controls: ['Eliminate or substitute where practicable', 'Engineering controls', 'Administrative controls and safe systems', 'PPE as the final layer'],
        documents: ['Risk assessment', 'Permits / approvals', 'Inventory', 'SDS / profile sheets', 'Waste records', 'Emergency response plan'],
      ),
      AbuDhabiCopSection(
        number: '3.2',
        title: 'Employee Safety and Health',
        hazards: ['Chemical exposure', 'Inhalation', 'Skin and eye contact', 'Fire and incompatible reactions'],
        requirements: [
          'Protect employees and other persons from hazardous-material risks using the hierarchy of controls.',
          'Provide suitable PPE such as helmets, eye/face protection, respiratory protection, gloves, protective aprons, coveralls and safety boots where required by risk assessment.',
          'Do not eat or change clothes in hazardous-material storage/use areas; the CoP specifies segregation of eating/changing facilities by at least 10 m from storage/use areas.',
          'Do not identify materials by smell, taste or touch.',
          'Do not smoke or introduce ignition sources where incompatible with the material.',
          'Do not mix unknown or incompatible materials.',
          'Use compatible, identified containers and identify relevant tanks, valves, openings and pipeline contents/flow direction.',
          'Clean and decontaminate PPE and follow SDS precautions.',
        ],
        measurements: ['Eating/changing facilities: at least 10 m from hazardous-material storage/use areas.'],
      ),
      AbuDhabiCopSection(
        number: '3.3',
        title: 'Emergency Management and Notifications',
        hazards: ['Fire/explosion', 'Toxic release', 'Spills to drains or groundwater', 'Uncontrolled emergency access'],
        requirements: [
          'Identify credible emergency scenarios using a risk-based approach and develop response arrangements with relevant stakeholders.',
          'Address static electricity, sparks, grounding/bonding, alarms/detection, emergency contacts, response kits, spill containment, decontamination and fire protection.',
          'Containment arrangements for stored hazardous materials must provide at least 110% of maximum storage capacity.',
          'Report incidents to relevant emergency services, competent authorities and/or sector regulators as required.',
          'Disclose hazardous-material ingredients to authorised emergency responders and other authorised persons when required for the incident response.',
        ],
        measurements: ['Spill containment capacity: minimum 110% of maximum storage capacity.'],
        documents: ['Emergency response plan', 'Emergency contact list', 'Spill response arrangements', 'Incident reports'],
        inspection: ['Inspect emergency equipment and containment arrangements.', 'Maintain surveillance and inspection arrangements defined by the emergency plan.'],
      ),
      AbuDhabiCopSection(
        number: '3.4',
        title: 'Classification, Labelling, SDS and Communication',
        hazards: ['Incorrect identification', 'Wrong PPE selection', 'Incompatible handling', 'Emergency response delay'],
        requirements: [
          'Maintain current safety data sheet information for hazardous materials in use or storage.',
          'Ensure containers are appropriately identified and labels remain legible and consistent with the material information.',
          'Communicate relevant hazards, precautions, PPE, first-aid and emergency information to affected workers and contractors.',
          'Do not rely on smell, taste or touch to identify an unknown substance.',
          'Review SDS information before introducing a new hazardous material or changing the way an existing material is used.',
        ],
        documents: ['SDS register', 'Chemical inventory', 'Labels/signage', 'Worker communication records'],
      ),
      AbuDhabiCopSection(
        number: '3.5',
        title: 'Storage, Segregation and Handling',
        hazards: ['Fire', 'Toxic release', 'Incompatible reaction', 'Container failure', 'Spill'],
        requirements: [
          'Store hazardous materials according to their properties and compatibility requirements.',
          'Separate incompatible materials and control ignition sources where flammable or combustible hazards exist.',
          'Keep containers secure, compatible with their contents and protected from damage.',
          'Use suitable secondary containment where required by the risk assessment and storage arrangement.',
          'Control decanting and transfer operations to minimise splash, release, static and manual-handling risks.',
        ],
        controls: ['Substitution', 'Closed/contained systems', 'Ventilation and secondary containment', 'Safe storage and handling procedures', 'PPE'],
        inspection: ['Check containers, labels, storage condition, segregation, spill kits and access routes.'],
      ),
    ],
    fieldChecklist: [
      'Current SDS available and understood.',
      'Hazardous-material inventory is accurate.',
      'Containers and labels are intact and compatible.',
      'Segregation and storage controls are in place.',
      'Required permits and approvals are available.',
      'Emergency equipment and spill containment are ready.',
      'Workers have appropriate training and PPE.',
    ],
    stopWorkIndicators: [
      'Unknown or unlabelled hazardous material is being handled.',
      'Incompatible materials are stored or mixed together.',
      'Required permit/approval is missing.',
      'Major spill or uncontrolled release occurs.',
      'Emergency containment or response capability is unavailable.',
    ],
    references: ['ADPHC CoP 1.0 – Hazardous Materials V4.0, 15 July 2024.'],
  );

  static const asbestos = AbuDhabiCopDocument(
    code: 'CoP 1.1',
    title: 'Management of Asbestos Containing Materials',
    version: '4.1',
    effectiveDate: '27 February 2026',
    introduction:
        'Provides the Abu Dhabi framework for managing asbestos-containing materials (ACM), including identification, registers, risk assessment, management decisions, planned work, communication, training and records. The 2026 V4.1 update is listed by ADPHC as effective from 27 February 2026.',
    sections: [
      AbuDhabiCopSection(
        number: 'Management Plan',
        title: 'Asbestos Management Plan',
        requirements: [
          'Maintain an accessible management plan for the building or facility.',
          'Record the date of plan development, asbestos surveyor/consultant details, facility details, current use/work practices, review requirements and stakeholder responsibilities.',
          'Include the specific asbestos register, risk assessment and an action plan for each identified or presumed ACM.',
          'Document the basis for decisions to remove, maintain or replace ACM.',
          'Define consultation and communication arrangements for location, type, condition, risks and controls.',
          'Include training arrangements, planned maintenance work near ACM, completed-work records and the procedure for updating the plan.',
        ],
        documents: ['Asbestos management plan', 'Asbestos register', 'Asbestos risk assessment', 'Action plan', 'Training records', 'Planned maintenance register', 'Completed-work register', 'Clearance certificates'],
      ),
      AbuDhabiCopSection(
        number: 'Field Control',
        title: 'Identification, Assessment and Control',
        hazards: ['Release of asbestos fibres', 'Uncontrolled disturbance during maintenance', 'Inadequate information transfer', 'Improper disposal'],
        requirements: [
          'Treat known or presumed ACM as a controlled hazard and prevent unplanned disturbance.',
          'Make asbestos information available to relevant employees, contractors and maintenance personnel before work.',
          'Use documented work procedures and risk controls appropriate to the material and task.',
          'Record completed asbestos-related work and associated clearance documentation where applicable.',
        ],
        controls: ['Avoid disturbance', 'Eliminate/remove under controlled arrangements where required', 'Engineering containment and fibre controls', 'Administrative controls, registers and permits', 'Appropriate PPE and respiratory protection'],
      ),
      AbuDhabiCopSection(
        number: 'Survey and Register',
        title: 'Asbestos Survey and Register',
        hazards: ['Hidden ACM', 'Unplanned disturbance', 'Fibre release during maintenance'],
        requirements: [
          'Identify the location, type, condition and accessibility of known or presumed ACM before intrusive work.',
          'Keep the asbestos register current and accessible to people who may disturb or work near ACM.',
          'Where work may break or disturb materials, complete the required survey/assessment before proceeding.',
          'Clearly communicate ACM locations and controls to maintenance teams, contractors and other affected persons.',
        ],
        documents: ['Asbestos survey', 'Asbestos register', 'Sampling/analysis records', 'Site plans or location drawings'],
      ),
      AbuDhabiCopSection(
        number: 'Work Planning',
        title: 'Asbestos Work Planning and Specialist Control',
        requirements: [
          'Plan asbestos work before the task begins and define the work method, enclosure/containment requirements, decontamination and waste arrangements as applicable.',
          'Use the competent/licensed asbestos specialist arrangements required by the applicable work scope.',
          'Prevent unauthorised persons from entering the controlled work area.',
          'Coordinate asbestos controls with construction permits, maintenance activities and other simultaneous work.',
        ],
        controls: ['Avoid disturbance', 'Controlled work area', 'Containment and fibre suppression', 'Decontamination', 'Specialist supervision'],
        documents: ['Plan of work', 'Permits/approvals where applicable', 'Competency/licence records', 'Emergency arrangements'],
      ),
      AbuDhabiCopSection(
        number: 'Completion',
        title: 'Clearance, Handover and Records',
        requirements: [
          'Do not return a controlled area to normal use until the required completion and clearance arrangements have been satisfied.',
          'Record completed asbestos work, waste transfer/disposal information and required clearance documentation.',
          'Update the asbestos management plan and register after completed work or changes to ACM condition/location.',
          'Retain records so future maintenance and construction teams can identify the remaining ACM risk.',
        ],
      ),
    ],
    fieldChecklist: ['Current asbestos register accessible.', 'ACM condition and location known.', 'Risk assessment and action plan current.', 'Contractors briefed before work.', 'Maintenance work near ACM controlled.', 'Completed work and clearance records retained.'],
    stopWorkIndicators: ['Suspected ACM is being disturbed without assessment/control.', 'Asbestos register is unavailable where required.', 'Required specialist controls or documentation are missing.', 'Unexpected ACM is discovered during work.'],
    references: ['ADPHC CoP 1.1 – Management of Asbestos Containing Materials V4.1, February 2026.'],
    verificationNote: 'Clause-level content should be refreshed directly from the full official V4.1 English PDF before this entry is treated as the final legal-reference transcription.',
  );

  static const lead = AbuDhabiCopDocument(
    code: 'CoP 1.2',
    title: 'Lead Exposure Management',
    version: '4.0',
    effectiveDate: '15 July 2024',
    introduction:
        'Covers work where people may be exposed to airborne lead and requires risk assessment, exposure control, monitoring, hygiene, PPE, medical surveillance and records.',
    sections: [
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Training and Competency',
        requirements: ['Train affected personnel before exposure work and when required by changes in work or procedures.', 'Cover SDS information, health hazards, symptoms, exposure sources, warning labels, exposure limits, work methods, PPE, hygiene and the lead exposure/medical monitoring program.', 'Maintain training records including worker identification, training subject, date and trainer.'],
        documents: ['Training records', 'Lead exposure control program'],
      ),
      AbuDhabiCopSection(
        number: '3.1–3.3',
        title: 'Roles, Planning and Exposure Control Program',
        hazards: ['Inhalation of airborne lead', 'Contaminated clothing/surfaces', 'Secondary exposure', 'Long-term health effects'],
        requirements: ['Assess locations with potential lead exposure and implement the hierarchy of controls.', 'Maintain a written lead exposure control and medical monitoring program.', 'Review the program at least annually and when workplace changes could affect exposure.', 'Include exposure monitoring, notification, compliance methods, PPE, housekeeping, hygiene, medical surveillance, removal protection, training and records.'],
        controls: ['Avoid exposure where reasonably practicable', 'Prevent exposure through engineering/work-practice controls', 'Minimise exposure below the applicable limit', 'Supplement with respiratory protection where required'],
      ),
      AbuDhabiCopSection(
        number: '3.4',
        title: 'Exposure Monitoring',
        requirements: ['Use recognised sampling methods and competent personnel.', 'Use representative personal full-shift samples for relevant job classifications/work areas.', 'Repeat monitoring according to exposure results and changes in conditions.', 'Maintain sampling strategy, analytical results and corrective-action records and have data reviewed by an appropriately qualified professional.'],
        measurements: ['Action level is defined in relation to 50% of the applicable exposure requirement in the source document.', 'Monitoring schedules depend on whether exposure is below action level, at/above action level, or above the PEL.'],
        documents: ['Sampling strategy', 'Laboratory results', 'Corrective actions', 'Exposure notifications'],
      ),
      AbuDhabiCopSection(
        number: '3.7–3.9',
        title: 'PPE, Housekeeping and Hygiene',
        requirements: ['Provide appropriate respiratory protection and protective work clothing where required.', 'Do not use dry sweeping or compressed air where it could re-aerosolise lead.', 'Use wet methods or suitable HEPA-filtered vacuuming for contaminated surfaces.', 'Provide required shower and clean facilities where the applicable exposure criteria require them.', 'Prevent contaminated clothing/PPE from spreading lead outside controlled areas.'],
        documents: ['PPE records', 'Cleaning records', 'Medical surveillance records'],
      ),
      AbuDhabiCopSection(
        number: '3.10–3.13',
        title: 'Medical Surveillance, Removal Protection and Signage',
        requirements: ['Provide medical surveillance where the applicable exposure criteria trigger it.', 'Use licensed medical oversight and appropriate biological monitoring.', 'Notify affected personnel of relevant results within the specified timeframes.', 'Apply medical-removal protections and required signage when criteria are met.'],
      ),
      AbuDhabiCopSection(
        number: '3.5',
        title: 'Engineering and Work-Practice Controls',
        hazards: ['Dust/fume generation', 'Contaminated surfaces', 'Take-home exposure', 'Secondary contamination'],
        requirements: [
          'Prioritise engineering and work-practice controls before relying on respiratory protection.',
          'Use local exhaust, enclosure, isolation, wet methods or suitable process changes where applicable to reduce airborne lead.',
          'Control the spread of contaminated dust and residues between work and clean areas.',
          'Review controls when process, material, equipment or workplace conditions change.',
        ],
        controls: ['Elimination/substitution', 'Enclosure/isolation', 'Local exhaust ventilation', 'Wet methods', 'Administrative controls', 'PPE'],
      ),
      AbuDhabiCopSection(
        number: '3.6',
        title: 'Housekeeping, Hygiene and Decontamination',
        hazards: ['Ingestion of lead', 'Contamination of clothing', 'Contamination of welfare areas'],
        requirements: [
          'Prevent accumulation and spread of lead-containing dust and residues.',
          'Use cleaning methods that minimise re-suspension of contaminated dust.',
          'Provide appropriate hand-washing and welfare arrangements for affected workers.',
          'Control contaminated work clothing and PPE so lead is not transferred to clean areas or taken home.',
          'Prohibit eating, drinking or smoking in contaminated work areas where the exposure-control program requires such restrictions.',
        ],
        inspection: ['Check housekeeping, clean/dirty separation, hand-washing arrangements and contaminated clothing controls.'],
      ),
      AbuDhabiCopSection(
        number: '4.0',
        title: 'Record Keeping',
        requirements: ['Maintain exposure, training, medical, notification and control records for the periods required by the applicable framework.'],
        documents: ['Exposure monitoring records', 'Medical surveillance records', 'Training records', 'Control-program reviews'],
      ),
    ],
    fieldChecklist: ['Lead exposure assessment completed.', 'Control program current.', 'Exposure monitoring strategy established.', 'PPE and hygiene controls available.', 'HEPA/wet cleaning controls used.', 'Medical surveillance arrangements in place where required.', 'Records and notifications maintained.'],
    stopWorkIndicators: ['Uncontrolled lead exposure identified.', 'Required exposure monitoring is not performed.', 'Contaminated clothing/PPE is being handled in a way that can spread lead.', 'Required medical or exposure-control arrangements are absent.'],
    references: ['ADPHC registry: CoP 1.2 – Lead Exposure Management V4.0, effective 15 July 2024.'],
    verificationNote: 'The ADPHC registry lists V4.0 effective 15 July 2024. The indexed English PDF available through the legacy document path is V3.1 (2017); final clause-level V4.0 content must therefore be refreshed from the current official V4.0 English attachment before this entry is treated as a final legal transcription.',
  );

  static const ppe = AbuDhabiCopDocument(
    code: 'CoP 2.0',
    title: 'Personal Protective Equipment',
    version: '4.0',
    effectiveDate: '15 July 2024',
    introduction:
        'Sets minimum requirements for selection, provision, use, maintenance, storage and management of PPE where workers may be exposed to health or safety risks.',
    protectionItems: [
      'Head protection — protects the head from falling objects, impact and other identified head hazards; use a suitable safety helmet where required by the risk assessment.',
      'Eye protection — protects the eyes from flying particles, dust, chemical splashes and other identified eye hazards; select safety spectacles, goggles or equivalent protection for the task.',
      'Face protection — protects the face from splash, impact, heat or other identified hazards; use a suitable face shield together with required eye protection where applicable.',
      'Hearing protection — protects hearing from excessive occupational noise; use suitable earplugs, earmuffs or other approved hearing protection based on the noise assessment.',
      'Respiratory protection — protects the respiratory system from hazardous airborne contaminants when other controls do not adequately control exposure; select the correct respirator for the contaminant and task.',
      'Hand protection — protects hands from cuts, abrasion, chemicals, heat, cold, puncture and other identified hazards; select gloves for the actual hazard and ensure compatibility with other PPE.',
      'Foot protection — protects feet from impact, crushing, puncture, slips and other identified hazards; select suitable safety footwear for the workplace risk.',
      'Body / protective clothing — protects the body and clothing from chemical contact, contamination, heat, flame, weather or other task-specific hazards where required.',
      'Fall protection — protects workers from falls when work-at-height risks require personal fall protection; use compatible harnesses, lanyards, lifelines or other approved systems as specified by the applicable risk assessment and work system.',
    ],
    sections: [
      AbuDhabiCopSection(number: '2.0', title: 'Training and Competency', requirements: ['Provide practical and theoretical PPE training.', 'Cover hazards, correct selection/use, limitations, defects, reporting, storage, inspection and issue records.', 'Use a language and method appropriate to the workforce.', 'Verify competency; retrain personnel who cannot demonstrate adequate understanding.'], documents: ['Training records', 'PPE issue records']),
      AbuDhabiCopSection(number: '3.1', title: 'Roles and Responsibilities', requirements: ['Provide appropriate PPE to employees exposed to workplace risks.', 'PPE supplied by the employer is generally provided at no cost to employees.', 'Employees must use PPE correctly and report hazards/defects.']),
      AbuDhabiCopSection(number: '3.2', title: 'General Requirements', requirements: ['PPE must be hygienic and suitable for personal use.', 'PPE must meet applicable UAE/national and recognised standards referenced by the CoP.', 'Provide appropriate PPE to visitors and other persons entering areas where PPE is required.']),
      AbuDhabiCopSection(number: '3.3–3.4', title: 'Planning, Assessment and Selection', requirements: ['Assess workplace hazards and determine PPE needs through risk management.', 'Select PPE that is suitable, compatible and effective for the identified risks.', 'Where multiple PPE items are needed, ensure they remain compatible and effective together.'], controls: ['Elimination/substitution', 'Engineering controls', 'Administrative controls', 'PPE as the final protective layer']),
      AbuDhabiCopSection(number: '3.5–3.8', title: 'Maintenance, Storage, Communication and Cost', requirements: ['Maintain, clean and replace PPE as necessary and establish an inspection regime.', 'Protect stored PPE from chemicals, sunlight, humidity, heat, impacts, contamination and loss.', 'Communicate required PPE, hazards and issue arrangements and provide suitable signage.', 'Employer-provided necessary PPE and required replacements are managed at no cost except where the CoP permits otherwise.'], inspection: ['Inspect PPE before, during and after use as appropriate.', 'Maintain a defined PPE inspection regime.']),
      AbuDhabiCopSection(number: '3.9–3.12', title: 'Respiratory Protection', requirements: ['Provide effective respiratory protection where airborne contaminants exceed applicable limits until engineering/other controls reduce exposure.', 'Manage respirator selection, use, fit/competency, supplied-air systems and training in accordance with the CoP.', 'Maintain records and ensure users understand limitations and emergency arrangements.'], documents: ['Respiratory protection program', 'Fit/competency records', 'Inspection and maintenance records']),
      AbuDhabiCopSection(
        number: 'PPE Selection Guide',
        title: 'Task-Specific PPE Selection',
        requirements: [
          'Select PPE from the actual hazard assessment rather than using a generic PPE list.',
          'Consider impact, penetration, chemical compatibility, heat, electrical, respiratory, noise and fall hazards as applicable.',
          'Check that PPE items do not interfere with each other; for example, eye, face, hearing and respiratory protection must remain effective when worn together.',
          'Consider worker fit, comfort, communication, visibility and environmental conditions without reducing the required protection.',
        ],
        inspection: ['Check size/fit, damage, contamination, expiry/service status and compatibility before use.'],
      ),
      AbuDhabiCopSection(
        number: 'PPE Management',
        title: 'Issue, Inspection and Replacement',
        requirements: [
          'Maintain an effective system for issue, replacement, cleaning and maintenance of PPE.',
          'Remove damaged or contaminated PPE from service when it can no longer provide the required protection.',
          'Provide suitable storage that prevents contamination, deterioration, loss and unauthorised use.',
          'Keep training and issue/inspection records where required by the PPE management system.',
        ],
        documents: ['PPE matrix', 'Issue records', 'Inspection records', 'Replacement records', 'Training records'],
      ),
    ],
    fieldChecklist: ['Risk assessment identifies PPE requirements.', 'Correct PPE available and in good condition.', 'PPE is compatible when multiple items are worn.', 'Users are trained and competent.', 'Storage protects PPE from damage/contamination.', 'Respiratory protection program is implemented where required.'],
    stopWorkIndicators: ['Required PPE is unavailable or defective.', 'Worker is not competent to use required PPE.', 'PPE is incompatible with the hazard or other PPE.', 'Required respiratory protection controls are absent.'],
    references: ['ADPHC CoP 2.0 – Personal Protective Equipment V4.0, 15 July 2024.'],
  );

  static const occupationalNoise = AbuDhabiCopDocument(
    code: 'CoP 3.0',
    title: 'Occupational Noise',
    version: '4.0',
    effectiveDate: '15 July 2024',
    introduction:
        'Controls occupational noise exposure through risk assessment, engineering/administrative controls, hearing conservation, signage, audiometry, exposure calculations and records.',
    protectionItems: [
      'Earplugs — provide hearing attenuation by reducing the sound reaching the ear; select a suitable type and rating for the measured noise environment and ensure correct fit.',
      'Earmuffs / ear defenders — provide hearing attenuation by enclosing the ears; select a suitable rated device and ensure a proper seal around the ears.',
      'Double hearing protection (earplugs + earmuffs) — provides combined attenuation where a single device cannot reduce exposure sufficiently; the CoP provides a calculation method for combined protection.',
      'Hearing protection selection — the protector must provide sufficient attenuation to reduce the employee\'s exposure to the applicable level; fit, compatibility and the specific noise environment must be considered.',
    ],
    sections: [
      AbuDhabiCopSection(number: '2.0', title: 'Training and Competency', requirements: ['Train affected workers on noise hazards, controls, hearing protection and the hearing conservation program where applicable.']),
      AbuDhabiCopSection(number: '3.1', title: 'Roles and Responsibilities', hazards: ['Hearing damage', 'Communication failure', 'Impact/continuous/intermittent noise exposure'], requirements: ['Eliminate/reduce noise where reasonably practicable using lower-noise equipment, maintenance, barriers and other controls.', 'Protect workers, contractors and visitors when exposure exceeds the applicable schedule.', 'Provide hearing protection when controls do not reduce exposure sufficiently.', 'A hearing conservation program is required when noise hazards exceed 85 dB(A).'], measurements: ['Action level: 85 dB(A).', 'Noise at or above 100 dB(A) requires appropriate hearing protection under the CoP.']),
      AbuDhabiCopSection(number: '3.2', title: 'Noise Risk Assessment', requirements: ['Assess work liable to expose people at or above 85 dB(A).', 'Use observation, equipment information and measurement where necessary.', 'Consider level, type, duration, peak sound pressure, affected contractors/others and exposure limits.'], measurements: ['Assessment trigger: 85 dB(A) action level.']),
      AbuDhabiCopSection(number: '3.3', title: 'Hearing Conservation Program', requirements: ['Implement the program where required, including exposure monitoring, employee information, hearing protection, audiometric testing, baseline comparison and follow-up for standard threshold shifts.', 'Employees with a standard threshold shift must be informed and appropriate hearing protection/evaluation actions taken as specified.'], measurements: ['Standard threshold shift: average change of 10 dB(A) or more at 2000, 3000 and 4000 Hz in either ear relative to baseline.']),
      AbuDhabiCopSection(number: '3.4–3.8', title: 'Signage, Audiometry and Exposure Calculations', requirements: ['Mark noise-hazard areas as required.', 'Use appropriate audiometric instruments and test-room controls.', 'Calculate employee noise exposure and hearing-protection attenuation using the methods in the CoP appendices.']),
      AbuDhabiCopSection(number: '3.9', title: 'Engineering and Administrative Noise Controls', requirements: ['Prioritise noise reduction at source where reasonably practicable.', 'Consider quieter equipment, isolation, enclosure, barriers, damping, maintenance and layout changes.', 'Control exposure time and worker location where engineering controls alone do not provide sufficient reduction.', 'Review controls when equipment, process, work location or exposure conditions change.'], controls: ['Eliminate/substitute noisy process', 'Low-noise equipment', 'Enclosure/isolation', 'Acoustic barriers/damping', 'Maintenance', 'Exposure-time management', 'Hearing protection']),
      AbuDhabiCopSection(number: '3.10', title: 'Hearing Protection Use', hazards: ['Incorrect fit', 'Insufficient attenuation', 'Incompatible PPE', 'Failure to wear protection in designated areas'], requirements: ['Select hearing protection using the measured/assessed noise environment and the CoP calculation method.', 'Train workers in correct insertion, fitting, cleaning, storage and limitations of hearing protectors.', 'Ensure hearing protection remains compatible with helmets, eye protection, communication equipment and other required PPE.', 'Replace protectors when damaged, contaminated or no longer capable of providing the required protection.'], inspection: ['Check fit, condition, cleanliness, availability and correct use in designated hearing-protection areas.']),
      AbuDhabiCopSection(number: 'Exposure Management', title: 'Field Exposure Assessment', requirements: ['Consider task duration, worker location, simultaneous noise sources and changes in operating conditions.', 'Use representative exposure information for affected job groups and repeat assessment when conditions change.', 'Document measurement equipment, measurement method, worker/task, location, date and result so the assessment can be reproduced and reviewed.'], documents: ['Noise survey', 'Dosimetry records', 'Measurement equipment records', 'Corrective-action records']),
      AbuDhabiCopSection(number: '4.0', title: 'Record Keeping', requirements: ['Maintain noise assessment, monitoring, hearing conservation and audiometric records as required.'], documents: ['Noise risk assessment', 'Monitoring records', 'Audiograms', 'Training records', 'Corrective-action records']),
    ],
    fieldChecklist: ['Noise risk assessment completed where applicable.', 'Low-noise/engineering controls considered.', '85 dB(A) action level addressed.', 'Hearing protection available and suitable.', 'Noise signage installed where required.', 'Audiometric program implemented where required.', 'Records maintained.'],
    stopWorkIndicators: ['Noise exposure exceeds applicable limits without required controls.', 'Hearing protection is required but unavailable.', 'Noise-hazard area is uncontrolled or unmarked where signage is required.', 'Required hearing-conservation arrangements are absent.'],
    references: ['ADPHC CoP 3.0 – Occupational Noise V4.0, 15 July 2024.'],
  );

  static const vibration = AbuDhabiCopDocument(
    code: 'CoP 3.1',
    title: 'Vibration',
    version: '4.0',
    effectiveDate: '15 July 2024',
    introduction:
        'Controls occupational hand-arm and whole-body vibration through exposure assessment, action/limit values, risk controls, health surveillance and records.',
    sections: [
      AbuDhabiCopSection(number: '2.0', title: 'Training and Competency', requirements: ['Train workers on vibration hazards, exposure controls, equipment use, reporting and relevant health-surveillance arrangements.']),
      AbuDhabiCopSection(number: '3.1', title: 'Roles and Responsibilities', requirements: ['Identify vibration hazards, implement risk controls and provide suitable equipment/safety devices.', 'Workers must report activities or equipment defects that could cause overexposure and use provided controls as instructed.']),
      AbuDhabiCopSection(number: '3.2', title: 'Exposure Limit and Action Values', requirements: ['Assess daily exposure using the methods in Schedule A for hand-arm vibration and Schedule B for whole-body vibration.'], measurements: ['Hand-arm vibration daily exposure limit: 5 m/s² A(8).', 'Hand-arm vibration daily action value: 2.5 m/s² A(8).', 'Whole-body vibration daily exposure limit: 1.15 m/s² A(8).', 'Whole-body vibration daily action value: 0.5 m/s² A(8).']),
      AbuDhabiCopSection(number: '3.3', title: 'Risk Assessment', hazards: ['Hand-arm vibration exposure', 'Whole-body vibration exposure', 'Repeated shocks', 'Cold-related aggravation', 'Equipment/workplace stability effects'], requirements: ['Assess magnitude, type and duration of exposure.', 'Consider intermittent vibration/repeated shocks, vulnerable workers, equipment information, lower-vibration alternatives, workplace effects, low temperatures and health-surveillance information.', 'Use observation, manufacturer/scientific information and measurement where necessary.'], controls: ['Avoid unnecessary exposure', 'Use lower-vibration equipment', 'Engineering controls', 'Work-practice/administrative controls', 'Exposure-time management and health surveillance']),
      AbuDhabiCopSection(number: '3.4', title: 'Health Surveillance', requirements: ['Provide health surveillance where required by the exposure risk and action/limit criteria.', 'Use health information to review whether controls remain effective and whether further assessment is needed.'], documents: ['Vibration risk assessment', 'Exposure calculations/measurements', 'Health surveillance records']),
      AbuDhabiCopSection(number: '3.5', title: 'Hand-Arm Vibration Controls', hazards: ['Numbness/tingling', 'Loss of grip/control', 'Long-term hand-arm vibration effects'], requirements: ['Select lower-vibration tools where practicable.', 'Maintain tools in good condition and use manufacturer-recommended accessories and operating methods.', 'Avoid unnecessary grip force and exposure duration.', 'Use suitable work rotation or exposure-time controls as part of the risk assessment where required.', 'Keep workers informed about symptoms and reporting arrangements.'], controls: ['Lower-vibration equipment', 'Tool maintenance', 'Process redesign', 'Exposure-time management', 'Health surveillance']),
      AbuDhabiCopSection(number: '3.6', title: 'Whole-Body Vibration Controls', hazards: ['Vehicle/equipment vibration', 'Repeated shocks', 'Poor seating or suspension', 'Uneven travel surfaces'], requirements: ['Select equipment with effective suspension and vibration characteristics where practicable.', 'Maintain seats, suspension, tyres/tracks and travel surfaces.', 'Reduce speed and shock exposure where appropriate to the task and site conditions.', 'Consider cab/seat design, operator posture, route condition and duration of exposure in the risk assessment.'], controls: ['Equipment selection', 'Seat/suspension maintenance', 'Route improvement', 'Speed/work-practice controls', 'Exposure-time management']),
      AbuDhabiCopSection(number: '3.7', title: 'Exposure Calculation and Monitoring', requirements: ['Determine daily vibration exposure using the applicable A(8) calculation method.', 'Where multiple operations occur during a shift, combine exposure contributions using the applicable calculation method rather than assessing each task in isolation.', 'Record vibration magnitude, exposure duration, equipment/task and assumptions used in the calculation.'], documents: ['Vibration survey', 'Manufacturer data', 'Exposure calculations', 'Measurement records']),
      AbuDhabiCopSection(number: '3.8', title: 'Health Surveillance and Review', requirements: ['Use health-surveillance findings and worker reports as inputs to the risk assessment.', 'Review controls when symptoms, exposure changes, new equipment or new work methods indicate that the existing assessment may no longer be adequate.', 'Maintain confidentiality of medical information while retaining the required occupational health records.']),
      AbuDhabiCopSection(number: '4.0', title: 'Record Keeping', requirements: ['Maintain records of assessments, exposure information and health surveillance as required.'], documents: ['Risk assessments', 'Exposure calculations', 'Measurement records', 'Training records', 'Health surveillance records']),
    ],
    fieldChecklist: ['Vibration sources identified.', 'Daily exposure assessed.', 'Action and limit values checked.', 'Lower-vibration equipment considered.', 'Exposure duration controlled.', 'Health surveillance arranged where required.', 'Records maintained.'],
    stopWorkIndicators: ['Exposure exceeds the applicable limit without adequate control.', 'Required exposure assessment is unavailable.', 'Known high-vibration equipment is used without controls.', 'Worker reports symptoms or conditions requiring immediate reassessment and no response is taken.'],
    references: ['ADPHC CoP 3.1 – Vibration V4.0, 15 July 2024.'],
  );
}
