import 'package:flutter/material.dart';
import '../models/reference_topic.dart';
import '../models/guideline_category.dart';

const List<ReferenceTopic> uaeGeneralGuidelines = [
  ReferenceTopic(
    id: 'general_hse_responsibilities',
    title: 'General HSE Responsibilities',
    shortTitle: 'HSE Responsibilities',
    category: 'UAE General',
    authority: 'UAE Government / MoHRE',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'General guidance on the responsibilities of employers, supervisors, workers and HSE personnel for maintaining a safe and healthy workplace in the UAE.',
    keyRequirements: [
      'Provide a safe and appropriate working environment.',
      'Identify and control workplace hazards.',
      'Provide suitable safety information, instruction and training.',
      'Provide appropriate protective equipment where required.',
      'Maintain safe systems of work and workplace controls.',
      'Workers must follow occupational health and safety instructions.',
      'Workers must use provided protective equipment correctly.',
      'Review workplace safety arrangements periodically.',
    ],
    safetyControls: [
      'HSE management system',
      'Risk assessments',
      'Safety procedures',
      'Worker induction',
      'Competency and training',
      'PPE',
      'Workplace inspections',
      'Corrective action tracking',
    ],
    responsibilities: [
      'Management provides resources and safe systems of work.',
      'Supervisors implement controls at the workplace.',
      'Workers follow approved safety procedures and report hazards.',
      'HSE personnel monitor compliance and provide professional guidance.',
    ],
    references: [
      'UAE Federal Decree-Law No. 33 of 2021 on the Regulation of Labour Relations and amendments',
      'UAE Government - Health and Safety at Workplace',
      'MoHRE Occupational Health and Safety guidance',
    ],
  ),

  ReferenceTopic(
    id: 'risk_assessment',
    title: 'Risk Assessment',
    shortTitle: 'Risk Assessment',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'A structured process for identifying hazards, evaluating risks and implementing controls before and during work activities.',
    keyRequirements: [
      'Identify hazards associated with the work activity.',
      'Identify people who may be affected.',
      'Evaluate the likelihood and potential severity of harm.',
      'Determine appropriate control measures.',
      'Apply the hierarchy of controls.',
      'Communicate significant risks and controls to workers.',
      'Review the assessment when conditions change.',
    ],
    safetyControls: [
      'Activity-based risk assessment',
      'Dynamic risk assessment',
      'Risk matrix',
      'Control measures',
      'Worker consultation',
      'Periodic review',
      'Management approval where required',
    ],
    responsibilities: [
      'Management provides resources for effective risk assessment.',
      'Supervisors ensure assessments are available and understood.',
      'Workers participate in hazard identification and follow controls.',
      'HSE personnel facilitate and review risk assessments.',
    ],
    references: [
      'UAE occupational health and safety requirements',
      'Company Risk Assessment Procedure',
      'Applicable Emirate-specific HSE requirements',
    ],
  ),

  ReferenceTopic(
    id: 'hazard_identification',
    title: 'Hazard Identification',
    shortTitle: 'Hazard Identification',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'Guidance for identifying physical, chemical, biological, ergonomic, environmental and operational hazards before they cause harm.',
    keyRequirements: [
      'Identify hazards before starting work.',
      'Consider routine and non-routine activities.',
      'Consider workers, contractors and visitors.',
      'Identify hazards created by simultaneous activities.',
      'Consider changes in equipment, materials and work conditions.',
      'Record significant hazards and required controls.',
    ],
    safetyControls: [
      'Workplace inspections',
      'Task observations',
      'Risk assessments',
      'Safety checklists',
      'Worker consultation',
      'Near-miss reporting',
      'Management of change',
    ],
    responsibilities: [
      'Supervisors identify hazards at work fronts.',
      'Workers report unsafe conditions immediately.',
      'HSE personnel support systematic hazard identification.',
      'Management ensures identified hazards are controlled.',
    ],
    references: [
      'UAE occupational health and safety requirements',
      'Company HSE Management System',
      'Applicable risk management procedures',
    ],
  ),

  ReferenceTopic(
    id: 'hierarchy_of_controls',
    title: 'Hierarchy of Controls',
    shortTitle: 'Hierarchy of Controls',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'A systematic approach for selecting effective risk controls, prioritising elimination and engineering controls over reliance on administrative measures and PPE alone.',
    keyRequirements: [
      'Consider eliminating the hazard first.',
      'Consider substitution where elimination is not reasonably practicable.',
      'Use engineering controls to isolate people from hazards.',
      'Use administrative controls and safe work procedures.',
      'Use PPE as required by the residual risk.',
      'Review whether controls remain effective.',
    ],
    safetyControls: [
      'Elimination',
      'Substitution',
      'Engineering controls',
      'Administrative controls',
      'Personal protective equipment',
      'Control verification',
    ],
    responsibilities: [
      'Management provides resources for effective controls.',
      'Supervisors verify controls at the work location.',
      'Workers follow implemented control measures.',
      'HSE personnel verify that controls are suitable for the identified risks.',
    ],
    references: [
      'UAE HSE risk management practice',
      'Company Risk Assessment Procedure',
      'Applicable Emirate-specific requirements',
    ],
  ),

  ReferenceTopic(
    id: 'permit_to_work',
    title: 'Permit to Work',
    shortTitle: 'Permit to Work',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'Guidance for controlling high-risk work through a formal permit-to-work system where required by the workplace risk assessment and company procedures.',
    keyRequirements: [
      'Identify activities requiring a permit.',
      'Complete the required risk assessment before permit issue.',
      'Define hazards, controls and work boundaries.',
      'Verify isolations and other prerequisites.',
      'Ensure authorised persons issue and accept permits.',
      'Display or make the permit available at the work location where required.',
      'Suspend or close permits when conditions change or work is completed.',
    ],
    safetyControls: [
      'Permit approval',
      'Risk assessment',
      'Isolation verification',
      'Gas testing where required',
      'Work-area inspection',
      'Permit handover',
      'Permit suspension and close-out',
    ],
    responsibilities: [
      'Permit issuers verify required controls before authorisation.',
      'Supervisors ensure work follows permit conditions.',
      'Workers understand and follow permit requirements.',
      'HSE personnel monitor permit compliance.',
    ],
    references: [
      'Company Permit to Work Procedure',
      'Project HSE Plan',
      'Applicable high-risk work requirements',
    ],
  ),

  ReferenceTopic(
    id: 'job_safety_analysis',
    title: 'Job Safety Analysis',
    shortTitle: 'JSA',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'A task-based process for breaking work into steps, identifying hazards and defining controls before the activity begins.',
    keyRequirements: [
      'Break the task into logical work steps.',
      'Identify hazards for each step.',
      'Determine appropriate controls.',
      'Assign responsibilities for critical controls.',
      'Communicate the JSA to the work team.',
      'Review the JSA when conditions or methods change.',
    ],
    safetyControls: [
      'Task breakdown',
      'Hazard identification',
      'Risk assessment',
      'Control measures',
      'Toolbox briefing',
      'Worker involvement',
      'JSA review',
    ],
    responsibilities: [
      'Supervisors prepare or coordinate task-specific JSAs.',
      'Workers participate and confirm understanding.',
      'HSE personnel provide guidance and verification.',
      'Management ensures adequate resources for safe execution.',
    ],
    references: [
      'Company JSA Procedure',
      'Project HSE Plan',
      'Applicable risk assessment requirements',
    ],
  ),

  ReferenceTopic(
    id: 'toolbox_talk',
    title: 'Toolbox Talk',
    shortTitle: 'Toolbox Talk',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'Short, focused safety communication delivered before or during work to discuss hazards, controls, changes and lessons relevant to the task.',
    keyRequirements: [
      'Conduct toolbox talks for relevant work activities.',
      'Discuss task-specific hazards and controls.',
      'Explain changes in work conditions.',
      'Encourage workers to raise safety concerns.',
      'Record attendance where required.',
      'Use lessons from incidents and near misses where relevant.',
    ],
    safetyControls: [
      'Task-specific briefing',
      'JSA review',
      'Risk communication',
      'Worker participation',
      'Attendance record',
      'Safety observations',
    ],
    responsibilities: [
      'Supervisors lead or coordinate toolbox talks.',
      'Workers participate and ask questions.',
      'HSE personnel support safety awareness activities.',
      'Management ensures adequate time is provided for safety communication.',
    ],
    references: [
      'Company HSE Management System',
      'Project HSE Plan',
      'Company Toolbox Talk Procedure',
    ],
  ),

  ReferenceTopic(
    id: 'accident_incident_reporting',
    title: 'Accident & Incident Reporting',
    shortTitle: 'Incident Reporting',
    category: 'UAE General',
    authority: 'UAE Government / MoHRE',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'Guidance for reporting, recording, investigating and learning from workplace accidents, incidents, near misses and dangerous occurrences.',
    keyRequirements: [
      'Report workplace accidents and incidents promptly.',
      'Record near misses and dangerous occurrences.',
      'Preserve relevant evidence where required.',
      'Conduct an appropriate incident investigation.',
      'Identify immediate, underlying and root causes.',
      'Implement corrective and preventive actions.',
      'Report work injuries and occupational diseases through applicable channels.',
      'Follow applicable statutory reporting timeframes and requirements.',
    ],
    safetyControls: [
      'Incident reporting procedure',
      'Immediate scene control',
      'Evidence preservation',
      'Incident investigation',
      'Root cause analysis',
      'Corrective action tracking',
      'Lessons learned',
    ],
    responsibilities: [
      'Management maintains an effective reporting system.',
      'Supervisors ensure incidents are reported and the area is controlled.',
      'Workers immediately report incidents, injuries and unsafe conditions.',
      'HSE personnel support investigation and corrective actions.',
    ],
    references: [
      'UAE Government - Health and Safety at Workplace',
      'Federal Decree-Law No. 33 of 2021 and applicable implementing requirements',
      'MoHRE Occupational Health and Safety guidance',
      'Company Incident Reporting Procedure',
    ],
  ),

  ReferenceTopic(
    id: 'emergency_preparedness',
    title: 'Emergency Preparedness',
    shortTitle: 'Emergency Preparedness',
    category: 'UAE General',
    authority: 'UAE HSE / Applicable Authority',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'Guidance for preparing workplaces to respond effectively to fire, medical emergencies, hazardous releases, severe weather and other foreseeable emergencies.',
    keyRequirements: [
      'Identify credible emergency scenarios.',
      'Prepare and maintain an emergency response plan.',
      'Define emergency roles and responsibilities.',
      'Provide suitable emergency communication arrangements.',
      'Maintain accessible emergency routes and assembly points.',
      'Provide appropriate emergency equipment.',
      'Conduct drills and exercises as required.',
      'Review emergency arrangements after drills and incidents.',
    ],
    safetyControls: [
      'Emergency response plan',
      'Emergency contacts',
      'Alarm systems',
      'Assembly points',
      'Emergency equipment',
      'First aid',
      'Fire response',
      'Emergency drills',
    ],
    responsibilities: [
      'Management provides emergency resources.',
      'Emergency teams respond according to the established plan.',
      'Supervisors account for workers and control work areas.',
      'Workers follow emergency instructions and proceed to designated safe areas.',
    ],
    references: [
      'UAE Fire and Life Safety requirements',
      'Site Emergency Response Plan',
      'Applicable Civil Defence requirements',
      'Company Emergency Management Procedure',
    ],
  ),

  ReferenceTopic(
    id: 'fire_safety',
    title: 'Fire Safety',
    shortTitle: 'Fire Safety',
    category: 'UAE General',
    authority: 'UAE Civil Defence / Applicable Authority',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'General workplace fire prevention and emergency preparedness guidance covering ignition sources, combustible materials, fire protection, evacuation and emergency response.',
    keyRequirements: [
      'Identify and control fire hazards.',
      'Control ignition sources and combustible materials.',
      'Keep emergency exits and escape routes clear.',
      'Provide appropriate fire protection equipment.',
      'Maintain fire alarm and detection systems where required.',
      'Maintain emergency evacuation arrangements.',
      'Conduct fire drills as required.',
    ],
    safetyControls: [
      'Fire extinguishers',
      'Fire alarm systems',
      'Emergency exits',
      'Fire detection',
      'Hot work controls',
      'Good housekeeping',
      'Emergency lighting',
      'Fire drills',
    ],
    responsibilities: [
      'Management provides suitable fire protection arrangements.',
      'Supervisors maintain clear escape routes.',
      'Workers follow fire prevention procedures.',
      'Emergency teams respond according to established plans.',
    ],
    references: [
      'UAE Fire and Life Safety Code requirements',
      'UAE Civil Defence requirements',
      'Site Emergency Response Plan',
      'Applicable authority requirements',
    ],
  ),

  ReferenceTopic(
    id: 'heat_stress',
    title: 'Heat Stress Management',
    shortTitle: 'Heat Stress',
    category: 'UAE General',
    authority: 'MoHRE / UAE Occupational HSE',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'Guidance for preventing heat-related illness among workers exposed to high temperatures, humidity, radiant heat and physically demanding work, including the UAE Occupational Heat Stress Prevention Policy.',
    keyRequirements: [
      'Identify workers exposed to heat stress.',
      'Provide sufficient drinking water.',
      'Provide shaded or cooled rest arrangements as appropriate.',
      'Provide first aid arrangements.',
      'Implement heat-stress awareness and training.',
      'Plan work to reduce heat exposure.',
      'Monitor workers for signs and symptoms of heat-related illness.',
      'Follow the applicable UAE Midday Break requirements during the designated summer period.',
    ],
    safetyControls: [
      'Potable drinking water',
      'Shaded rest areas',
      'Cooling arrangements',
      'Work-rest arrangements',
      'Heat-stress monitoring',
      'Worker acclimatization',
      'Suitable clothing and PPE',
      'Emergency response arrangements',
    ],
    responsibilities: [
      'Management implements a heat-stress prevention programme.',
      'Supervisors monitor workers and environmental conditions.',
      'Workers maintain hydration and report symptoms promptly.',
      'HSE teams monitor implementation and provide guidance.',
    ],
    references: [
      'MoHRE - The Midday Break / Occupational Heat Stress Prevention Policy',
      'UAE Government - Health and Safety at Workplace',
      'MoHRE Occupational Health and Safety guidance',
      'Company Heat Stress Management Plan',
    ],
  ),

  ReferenceTopic(
    id: 'work_at_height',
    title: 'Work at Height',
    shortTitle: 'Work at Height',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'Guidance for preventing falls from height during construction, maintenance, access and other elevated work activities.',
    keyRequirements: [
      'Avoid work at height where reasonably practicable.',
      'Assess fall hazards before work starts.',
      'Use suitable collective protection where practicable.',
      'Provide safe access and work platforms.',
      'Use suitable fall protection systems where required.',
      'Inspect access and fall protection equipment before use.',
      'Prevent dropped objects from elevated work areas.',
    ],
    safetyControls: [
      'Guardrails',
      'Scaffolding',
      'MEWPs',
      'Fall restraint systems',
      'Fall arrest systems',
      'Lifelines',
      'Safe access',
      'Exclusion zones',
      'Tool lanyards where appropriate',
    ],
    responsibilities: [
      'Management provides safe systems and suitable equipment.',
      'Supervisors verify controls before work starts.',
      'Workers use access and fall protection equipment correctly.',
      'HSE personnel monitor work-at-height activities.',
    ],
    references: [
      'UAE occupational safety requirements',
      'Project Work at Height Procedure',
      'Applicable access equipment standards',
      'Company Fall Protection Procedure',
    ],
  ),

  ReferenceTopic(
    id: 'scaffolding_safety',
    title: 'Scaffolding Safety',
    shortTitle: 'Scaffolding',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'Guidance for erection, inspection, modification and safe use of scaffolding systems used for temporary access and work platforms.',
    keyRequirements: [
      'Scaffolds must be erected and modified by competent personnel.',
      'Provide stable foundations and suitable support.',
      'Install suitable guardrails and toe boards.',
      'Provide safe access and egress.',
      'Prevent unauthorised modification.',
      'Inspect scaffolds before use and after significant changes or events.',
      'Control scaffold loading within its designed capacity.',
    ],
    safetyControls: [
      'Competent erection',
      'Base plates',
      'Sole boards where required',
      'Guardrails',
      'Toe boards',
      'Safe access',
      'Scaffold inspection',
      'Load control',
      'Status identification',
    ],
    responsibilities: [
      'Scaffolders erect and modify scaffolds safely.',
      'Supervisors prevent unauthorised modifications.',
      'Workers use scaffolds according to their intended purpose.',
      'HSE personnel monitor scaffold condition and compliance.',
    ],
    references: [
      'UAE construction safety requirements',
      'Applicable scaffolding standards',
      'Project Scaffolding Procedure',
    ],
  ),

  ReferenceTopic(
    id: 'ladder_safety',
    title: 'Ladder Safety',
    shortTitle: 'Ladder Safety',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'Guidance for selecting, inspecting, positioning and using portable and fixed ladders safely.',
    keyRequirements: [
      'Select the correct ladder for the task.',
      'Inspect ladders before use.',
      'Use ladders on stable and level surfaces.',
      'Maintain secure footing and appropriate positioning.',
      'Maintain three points of contact where practicable.',
      'Do not use damaged or defective ladders.',
      'Avoid overreaching while working from ladders.',
    ],
    safetyControls: [
      'Pre-use inspection',
      'Stable footing',
      'Secure positioning',
      'Three-point contact',
      'Suitable ladder type',
      'Good housekeeping',
      'Safe storage',
    ],
    responsibilities: [
      'Supervisors ensure suitable ladders are available.',
      'Workers inspect and use ladders correctly.',
      'HSE personnel monitor ladder safety.',
      'Management provides appropriate access equipment.',
    ],
    references: [
      'Company Ladder Safety Procedure',
      'UAE occupational safety requirements',
      'Applicable access equipment standards',
    ],
  ),

  ReferenceTopic(
    id: 'confined_space',
    title: 'Confined Space Safety',
    shortTitle: 'Confined Space',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'Safety guidance for work in tanks, vessels, pits, chambers and other spaces where hazardous atmospheres, restricted access or other serious risks may exist.',
    keyRequirements: [
      'Identify and classify confined spaces.',
      'Conduct a suitable risk assessment.',
      'Use a confined-space entry permit where required.',
      'Test the atmosphere before entry.',
      'Continue atmospheric monitoring where required.',
      'Provide suitable ventilation.',
      'Isolate hazardous energy and connected services.',
      'Establish an emergency rescue arrangement.',
    ],
    safetyControls: [
      'Gas testing',
      'Continuous atmospheric monitoring where necessary',
      'Isolation and lockout',
      'Forced ventilation',
      'Standby attendant',
      'Communication system',
      'Emergency rescue plan',
      'Suitable PPE and respiratory protection where required',
    ],
    responsibilities: [
      'Employers provide safe systems of work.',
      'Supervisors verify controls before entry.',
      'Authorised entrants follow the entry procedure.',
      'Standby personnel maintain communication and initiate emergency response.',
    ],
    references: [
      'UAE occupational safety requirements',
      'Company Confined Space Procedure',
      'Applicable Permit to Work System',
      'Project Emergency Rescue Plan',
    ],
  ),

  ReferenceTopic(
    id: 'excavation_trenching',
    title: 'Excavation & Trenching Safety',
    shortTitle: 'Excavation & Trenching',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'Safety guidance for excavation and trenching activities to prevent collapse, falls, underground service strikes, flooding and equipment-related incidents.',
    keyRequirements: [
      'Obtain required approvals before excavation.',
      'Identify underground services before breaking ground.',
      'Assess soil and ground conditions.',
      'Provide suitable shoring, sloping or other protective systems.',
      'Provide safe access and egress.',
      'Keep spoil, materials and equipment away from excavation edges as required by the risk assessment.',
      'Inspect excavations regularly and after significant changes.',
      'Control water accumulation and unstable conditions.',
    ],
    safetyControls: [
      'Excavation permit',
      'Utility scanning',
      'Trial pits where required',
      'Barricading',
      'Safe access',
      'Shoring or sloping',
      'Daily inspection',
      'Water control',
      'Exclusion zones',
    ],
    responsibilities: [
      'Supervisors inspect excavations and verify controls.',
      'Workers remain within designated safe areas.',
      'Plant operators follow exclusion zones and instructions.',
      'HSE personnel verify excavation controls.',
    ],
    references: [
      'UAE construction safety requirements',
      'Project Excavation Procedure',
      'Applicable utility authority requirements',
    ],
  ),

  ReferenceTopic(
    id: 'lifting_operations',
    title: 'Lifting Operations',
    shortTitle: 'Lifting Operations',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'Guidance for safe crane, hoist and lifting operations including planning, equipment inspection, lifting accessories, communication and exclusion zones.',
    keyRequirements: [
      'Plan lifting operations according to the risk.',
      'Use competent lifting personnel.',
      'Inspect lifting equipment and accessories.',
      'Confirm load weight and centre of gravity.',
      'Verify lifting capacity and operating conditions.',
      'Establish exclusion zones.',
      'Use agreed communication methods.',
      'Prevent people from standing under suspended loads.',
    ],
    safetyControls: [
      'Lifting plan',
      'Crane inspection',
      'Lifting accessory inspection',
      'Competent operators',
      'Competent riggers',
      'Banksman/signaller',
      'Exclusion zone',
      'Load control',
      'Weather monitoring where relevant',
    ],
    responsibilities: [
      'Lifting supervisors coordinate lifting operations.',
      'Operators operate equipment within approved limits.',
      'Riggers connect and secure loads correctly.',
      'Banksmen/signallers provide agreed signals.',
      'HSE personnel monitor compliance.',
    ],
    references: [
      'UAE lifting equipment requirements',
      'Applicable equipment standards',
      'Project Lifting Procedure',
      'Manufacturer instructions',
    ],
  ),

  ReferenceTopic(
    id: 'electrical_safety',
    title: 'Electrical Safety',
    shortTitle: 'Electrical Safety',
    category: 'UAE General',
    authority: 'UAE HSE / Applicable Authority',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'Guidance for controlling electrical hazards including electric shock, arc flash, fire, damaged equipment and unauthorised electrical work.',
    keyRequirements: [
      'Electrical work must be carried out by competent persons.',
      'Use suitable isolation procedures.',
      'Protect cables and electrical equipment from damage.',
      'Inspect portable electrical equipment before use.',
      'Use appropriate residual-current protection where applicable.',
      'Maintain safe clearances from electrical hazards.',
      'Keep electrical panels accessible and properly identified.',
      'Do not use damaged electrical equipment.',
    ],
    safetyControls: [
      'Lockout/tagout',
      'Electrical isolation',
      'Inspection and testing',
      'Proper earthing',
      'Cable management',
      'Residual-current protection where applicable',
      'Suitable PPE',
      'Restricted access to electrical rooms',
    ],
    responsibilities: [
      'Management ensures competent electrical personnel.',
      'Supervisors verify safe isolation.',
      'Workers do not use defective electrical equipment.',
      'HSE personnel monitor electrical safety controls.',
    ],
    references: [
      'UAE electrical safety requirements',
      'Applicable authority requirements',
      'Company Electrical Safety Procedure',
      'Manufacturer instructions',
    ],
  ),

  ReferenceTopic(
    id: 'lockout_tagout',
    title: 'Lockout / Tagout',
    shortTitle: 'LOTO',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'Guidance for controlling hazardous energy during maintenance, repair, cleaning and other work where unexpected energisation or release of stored energy could cause harm.',
    keyRequirements: [
      'Identify all hazardous energy sources.',
      'Shut down equipment using the approved procedure.',
      'Isolate energy sources.',
      'Apply personal locks and identification as required.',
      'Release or restrain stored energy.',
      'Verify zero-energy or safe state before work starts.',
      'Maintain isolation until work is safely completed.',
      'Remove locks and restore energy through an approved process.',
    ],
    safetyControls: [
      'Energy isolation procedure',
      'Personal locks',
      'Warning tags',
      'Isolation register',
      'Zero-energy verification',
      'Stored-energy control',
      'Group lockout arrangements',
    ],
    responsibilities: [
      'Authorised persons perform energy isolation.',
      'Supervisors verify isolation before work.',
      'Workers maintain their personal lockout requirements.',
      'HSE personnel monitor LOTO compliance.',
    ],
    references: [
      'Company Lockout / Tagout Procedure',
      'Applicable electrical and machinery safety requirements',
      'Manufacturer instructions',
    ],
  ),

  ReferenceTopic(
    id: 'hot_work',
    title: 'Hot Work Safety',
    shortTitle: 'Hot Work',
    category: 'UAE General',
    authority: 'UAE HSE / Fire Safety Requirements',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'Guidance for controlling welding, cutting, grinding and other activities that generate heat, sparks or flames and may create fire or explosion hazards.',
    keyRequirements: [
      'Conduct a suitable risk assessment before hot work.',
      'Use a hot work permit where required.',
      'Remove or protect combustible materials.',
      'Provide suitable fire extinguishing equipment.',
      'Control sparks and hot metal.',
      'Provide gas testing where required by the risk assessment.',
      'Assign fire watch where required.',
      'Inspect the area after completion of hot work.',
    ],
    safetyControls: [
      'Hot work permit',
      'Fire extinguishers',
      'Fire blankets',
      'Gas testing where required',
      'Fire watch',
      'Combustible material removal',
      'Spark containment',
      'Post-work inspection',
    ],
    responsibilities: [
      'Supervisors verify hot work controls.',
      'Workers follow the permit and safe work procedure.',
      'Fire watch personnel monitor the area as required.',
      'HSE personnel verify compliance.',
    ],
    references: [
      'UAE Fire and Life Safety requirements',
      'Company Hot Work Procedure',
      'Permit to Work System',
      'Applicable Civil Defence requirements',
    ],
  ),

  ReferenceTopic(
    id: 'personal_protective_equipment',
    title: 'Personal Protective Equipment',
    shortTitle: 'PPE',
    category: 'UAE General',
    authority: 'UAE Government / HSE Requirements',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'Guidance for selecting, providing, using, inspecting and maintaining personal protective equipment based on workplace hazards.',
    keyRequirements: [
      'Select PPE based on the risk assessment.',
      'Provide suitable PPE for identified hazards.',
      'Ensure correct fit and compatibility.',
      'Train workers in correct use and limitations.',
      'Inspect PPE before use.',
      'Replace damaged or defective PPE.',
      'Store PPE correctly when not in use.',
      'Do not rely on PPE where higher-level controls are reasonably practicable.',
    ],
    safetyControls: [
      'Hazard assessment',
      'PPE selection',
      'Worker training',
      'Fit and compatibility checks',
      'Inspection',
      'Maintenance',
      'Replacement',
      'PPE compliance monitoring',
    ],
    responsibilities: [
      'Employers provide suitable PPE.',
      'Supervisors enforce PPE requirements.',
      'Workers correctly wear and maintain PPE.',
      'HSE teams monitor PPE compliance.',
    ],
    references: [
      'UAE Government - Health and Safety at Workplace',
      'UAE occupational safety requirements',
      'Company PPE Procedure',
      'Applicable PPE standards',
    ],
  ),

  ReferenceTopic(
    id: 'chemical_safety',
    title: 'Chemical Safety',
    shortTitle: 'Chemical Safety',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'Guidance for identifying, handling, storing and controlling hazardous chemicals to reduce exposure, fire, spill and environmental risks.',
    keyRequirements: [
      'Maintain an inventory of hazardous chemicals.',
      'Ensure containers are properly labelled.',
      'Make relevant Safety Data Sheets available.',
      'Assess chemical exposure risks.',
      'Provide appropriate storage arrangements.',
      'Use suitable handling and transfer procedures.',
      'Provide appropriate PPE and emergency equipment.',
      'Prepare spill and emergency response arrangements.',
    ],
    safetyControls: [
      'Chemical inventory',
      'Safety Data Sheets',
      'Labelling',
      'Segregated storage',
      'Ventilation',
      'Spill kits',
      'Emergency eyewash where required',
      'Chemical-resistant PPE',
    ],
    responsibilities: [
      'Management provides safe chemical management systems.',
      'Supervisors ensure workers understand chemical hazards.',
      'Workers follow SDS and approved handling procedures.',
      'HSE personnel monitor chemical storage and use.',
    ],
    references: [
      'UAE occupational health and safety requirements',
      'Applicable chemical safety requirements',
      'Safety Data Sheets',
      'Company Chemical Management Procedure',
    ],
  ),

  ReferenceTopic(
    id: 'manual_handling',
    title: 'Manual Handling',
    shortTitle: 'Manual Handling',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'Guidance for reducing musculoskeletal injuries associated with lifting, carrying, pushing, pulling and repetitive manual handling.',
    keyRequirements: [
      'Assess manual handling risks.',
      'Avoid manual handling where reasonably practicable.',
      'Use mechanical aids for heavy or awkward loads.',
      'Plan the route before moving loads.',
      'Use suitable lifting techniques.',
      'Request assistance for difficult loads.',
      'Consider repetitive handling and ergonomic factors.',
    ],
    safetyControls: [
      'Mechanical lifting aids',
      'Trolleys',
      'Team lifting',
      'Ergonomic assessment',
      'Load planning',
      'Good housekeeping',
      'Worker training',
    ],
    responsibilities: [
      'Management provides suitable mechanical aids.',
      'Supervisors plan manual handling activities.',
      'Workers use safe handling techniques.',
      'HSE personnel monitor ergonomic risks.',
    ],
    references: [
      'UAE occupational health and safety requirements',
      'Company Manual Handling Procedure',
      'Applicable ergonomic guidance',
    ],
  ),

  ReferenceTopic(
    id: 'vehicle_traffic_safety',
    title: 'Vehicle & Traffic Safety',
    shortTitle: 'Vehicle Safety',
    category: 'UAE General',
    authority: 'UAE HSE / Applicable Authority',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'Guidance for controlling vehicle, mobile plant and pedestrian interaction risks in workplaces, construction sites and industrial areas.',
    keyRequirements: [
      'Implement a suitable traffic management plan where required.',
      'Separate pedestrians and vehicles where practicable.',
      'Define speed limits and traffic routes.',
      'Use trained and authorised drivers and operators.',
      'Inspect vehicles and mobile plant before use.',
      'Use seat belts where provided.',
      'Control reversing operations.',
      'Maintain suitable visibility and lighting.',
    ],
    safetyControls: [
      'Traffic management plan',
      'Pedestrian walkways',
      'Vehicle exclusion zones',
      'Speed controls',
      'Banksman',
      'Reversing controls',
      'Pre-use inspections',
      'Warning signs',
      'Lighting',
    ],
    responsibilities: [
      'Management provides safe traffic arrangements.',
      'Supervisors control vehicle movements.',
      'Drivers and operators follow site traffic rules.',
      'Pedestrians use designated routes.',
      'HSE personnel monitor traffic risks.',
    ],
    references: [
      'UAE traffic and road safety requirements',
      'Project Traffic Management Plan',
      'Company Vehicle Safety Procedure',
      'Applicable authority requirements',
    ],
  ),

  ReferenceTopic(
    id: 'housekeeping_workplace_safety',
    title: 'Housekeeping & Workplace Safety',
    shortTitle: 'Housekeeping',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.uaeGeneral,
    description:
        'Guidance for maintaining clean, orderly and accessible workplaces to prevent slips, trips, falls, fire hazards and other incidents.',
    keyRequirements: [
      'Keep work areas clean and orderly.',
      'Remove waste and unnecessary materials regularly.',
      'Keep walkways and access routes clear.',
      'Control trailing cables and hoses.',
      'Store materials safely.',
      'Keep emergency exits and fire equipment accessible.',
      'Clean spills promptly.',
    ],
    safetyControls: [
      'Routine housekeeping inspections',
      'Waste removal',
      'Material storage',
      'Cable management',
      'Spill control',
      'Clear access routes',
      'Emergency exit checks',
    ],
    responsibilities: [
      'Supervisors maintain housekeeping standards.',
      'Workers clean and organise their work areas.',
      'Contractors comply with site housekeeping requirements.',
      'HSE personnel conduct inspections and follow up deficiencies.',
    ],
    references: [
      'UAE occupational safety requirements',
      'Company Housekeeping Procedure',
      'Project HSE Plan',
    ],
  ),
];


// ============================================================================
// UAE GENERAL HSE — COMPLETE PROFESSIONAL LEARNING PAGE
// Existing ReferenceTopic content above is intentionally preserved.
// Page structure follows the Abu Dhabi learning pattern:
// Section -> Item -> Detailed Guidance -> Field Application -> Safe/Unsafe.
// ============================================================================

class UaeGeneralCompleteTopicPage extends StatelessWidget {
  final ReferenceTopic topic;

  const UaeGeneralCompleteTopicPage({super.key, required this.topic});

  static const Color primaryGreen = Color(0xFF087443);
  static const Color lightGreen = Color(0xFFEAF7F0);
  static const Color pageBackground = Color(0xFFF5F7F6);
  static const Color textDark = Color(0xFF18232F);
  static const Color textMuted = Color(0xFF5E6975);

  @override
  Widget build(BuildContext context) {
    final sections = _uaeTopicLearning[topic.id] ??
        _buildFallbackSections(topic);

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: Text(topic.title),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 32),
        children: [
          for (var i = 0; i < sections.length; i++) ...[
            _UaeSectionTile(
              number: i + 1,
              section: sections[i],
              topicId: topic.id,
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  List<_UaeSection> _buildFallbackSections(ReferenceTopic topic) {
    return [
      _UaeSection(
        title: 'Core Requirements & Controls',
        items: [
          _UaeItem(
            title: 'Understand the requirement',
            detail: topic.description,
            application:
                'Review the approved project procedure, risk assessment, method statement and work conditions before the activity starts. Confirm that the people doing the work understand the required controls.',
          ),
          _UaeItem(
            title: 'Verify controls at the workplace',
            detail:
                topic.safetyControls.join('. ') + '.',
            application:
                'Do not rely only on paperwork. Verify the critical controls at the actual work front and stop or reassess if the planned controls cannot be maintained.',
          ),
          _UaeItem(
            title: 'Worker and supervisor responsibilities',
            detail: topic.responsibilities.join(' '),
            application:
                'Use toolbox talks, task briefings and supervision to confirm who is responsible for each critical control and how workers will respond to changing conditions.',
          ),
        ],
      ),
      _UaeSection(
        title: 'Field Application & Verification',
        items: [
          _UaeItem(
            title: 'Before, during and after work',
            detail:
                'Before work, confirm the approved method, competent people, equipment, controls and work boundaries. During work, monitor the point of exposure and changing conditions. After work, leave the area safe and close outstanding actions.',
            application:
                'A supervisor should be able to demonstrate the main hazard, the critical control, the verification method and the stop-work/reassessment trigger for the activity.',
          ),
        ],
      ),
    ];
  }
}

class _UaeSection {
  final String title;
  final List<_UaeItem> items;
  const _UaeSection({required this.title, required this.items});
}

class _UaeItem {
  final String title;
  final String detail;
  final String application;
  final List<String> safe;
  final List<String> unsafe;

  const _UaeItem({
    required this.title,
    required this.detail,
    required this.application,
    this.safe = const [],
    this.unsafe = const [],
  });
}

class _UaeSectionTile extends StatelessWidget {
  final int number;
  final _UaeSection section;
  final String topicId;
  const _UaeSectionTile({required this.number, required this.section, required this.topicId});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          childrenPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          leading: CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFE7F5EE),
            child: Text(
              '$number',
              style: const TextStyle(
                color: Color(0xFF087443),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          title: Text(
            section.title,
            style: const TextStyle(
              color: Color(0xFF18232F),
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          subtitle: Text('${section.items.length} detailed learning points'),
          children: section.items
              .map((item) => _UaeItemTile(item: item, topicId: topicId))
              .toList(),
        ),
      ),
    );
  }
}

class _UaeItemTile extends StatelessWidget {
  final _UaeItem item;
  final String topicId;
  const _UaeItemTile({required this.item, required this.topicId});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: const Color(0xFFF8FAF9),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Text(
            item.title,
            style: const TextStyle(
              color: Color(0xFF18232F),
              fontSize: 15.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          children: [
            _UaeDetailBlock(
              label: 'DETAILED PROFESSIONAL GUIDANCE',
              text: item.detail,
            ),
            const SizedBox(height: 10),
            _UaeDetailBlock(
              label: 'FIELD APPLICATION / VERIFICATION',
              text: item.application,
            ),
            if (_uaeDeepFieldGuidance.containsKey(topicId)) ...[
              const SizedBox(height: 10),
              _UaeDetailBlock(
                label: 'TOPIC-SPECIFIC HSE FIELD NOTES',
                text: _uaeDeepFieldGuidance[topicId]!,
              ),
            ],
            if (item.safe.isNotEmpty || item.unsafe.isNotEmpty) ...[
              const SizedBox(height: 12),
              _UaeSafeUnsafe(item: item),
            ],
          ],
        ),
      ),
    );
  }
}

class _UaeDetailBlock extends StatelessWidget {
  final String label;
  final String text;
  const _UaeDetailBlock({required this.label, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 13, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFFE3E9E6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF087443),
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: .5,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF3F4A55),
              fontSize: 15,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _UaeSafeUnsafe extends StatelessWidget {
  final _UaeItem item;
  const _UaeSafeUnsafe({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (item.safe.isNotEmpty)
          _UaeExampleCard(
            title: 'SAFE WORK PRACTICE',
            icon: Icons.check_circle_outline,
            items: item.safe,
          ),
        if (item.safe.isNotEmpty && item.unsafe.isNotEmpty)
          const SizedBox(height: 8),
        if (item.unsafe.isNotEmpty)
          _UaeExampleCard(
            title: 'UNSAFE WORK PRACTICE',
            icon: Icons.warning_amber_rounded,
            items: item.unsafe,
          ),
      ],
    );
  }
}

class _UaeExampleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> items;
  const _UaeExampleCard({
    required this.title,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 13, 14, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFFE1E7E4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: const Color(0xFF087443)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: .4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (final value in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                '• $value',
                style: const TextStyle(
                  color: Color(0xFF3F4A55),
                  fontSize: 14.5,
                  height: 1.45,
                ),
              ),
            ),
        ],
      ),
    );
  }
}


// ============================================================================
// TOPIC-SPECIFIC HSE FIELD NOTES
// Preserves the original learning content and adds deeper subject guidance.
// ============================================================================

final Map<String, String> _uaeDeepFieldGuidance = {
  'general_hse_responsibilities': 'Define responsibility at three levels: management provides resources and systems; supervisors verify controls at the work front; workers follow the approved method and report changes. For high-risk work, identify the person authorised to stop the activity and the escalation route. Verify competence, supervision, equipment condition and communication rather than relying only on signed documents.',
  'risk_assessment': 'Break the job into realistic steps and identify who may be exposed at each step. Consider simultaneous operations, temporary conditions, weather, energy sources, access, public interfaces and emergency arrangements. A changed condition should trigger a pause and reassessment. Critical controls should be observable in the field and linked to a named responsible person.',
  'hazard_identification': 'Use a task walk-through to identify hazards before work, then repeat the check when the sequence, equipment, people or environment changes. Consider direct and indirect exposure, including people in adjacent areas. Check for physical, chemical, biological, ergonomic and environmental hazards and verify that identified controls actually remove or reduce the exposure.',
  'hierarchy_of_controls': 'Apply controls in order: eliminate the hazard where practicable, substitute, use engineering controls, then administrative controls and PPE. Do not accept PPE as the only response to a significant hazard when a stronger control is reasonably practicable. For every critical control, define how it will be inspected, tested or demonstrated at the point of exposure.',
  'permit_to_work': 'A permit is a control system, not a replacement for risk assessment or supervision. Before issue, confirm scope, location, isolations, simultaneous operations, competent persons, atmospheric testing where relevant and emergency arrangements. During the job, maintain permit conditions and stop when the scope or risk changes. Close and hand back the work area only after the responsible persons confirm a safe condition.',
  'job_safety_analysis': 'A useful JSA follows the actual work sequence rather than listing generic hazards. For each step identify the hazard, potential consequence, specific control and verification method. Include non-routine steps such as mobilisation, setup, testing, temporary support and demobilisation. Brief the crew using language they understand and update the JSA when field conditions differ from the planned method.',
  'toolbox_talk': 'A toolbox talk should be task-specific and short enough to be understood, but detailed enough to cover the critical risks. Explain the sequence, exclusion zones, energy controls, PPE, emergency response and stop-work triggers. Ask workers to explain back the critical controls and encourage them to raise changes or concerns. Record attendance without treating signatures as proof of competence.',
  'accident_incident_reporting': 'Protect people first, preserve the scene where safe and make the required notifications through the applicable project and authority process. Capture facts, not assumptions: time, location, activity, equipment, people involved, conditions and immediate controls. Investigate underlying and organisational causes, assign corrective actions with owners and due dates, and verify effectiveness rather than closing actions only because a form is complete.',
  'emergency_preparedness': 'Emergency planning should match credible site scenarios such as fire, medical emergency, collapse, confined-space rescue, spill, electrical incident and severe weather. Confirm alarm methods, emergency numbers, access for responders, muster points, first-aid capability, rescue equipment and trained personnel. Drills should test actual response time and communication, and lessons should be converted into corrective actions.',
  'fire_safety': 'Control ignition sources and combustible loading together. Keep escape routes, fire doors and firefighting equipment accessible; control temporary electrical systems and hot work; and inspect storage areas for accumulation of combustibles. Workers should know how to raise the alarm, evacuate and report the location of a fire. Do not fight a fire when the person is not trained, the fire is beyond safe incipient-stage control or escape cannot be maintained.',
  'heat_stress': 'Plan heavy or outdoor work around heat exposure, workload and worker acclimatisation. Provide accessible drinking water, suitable rest arrangements and supervision for signs of heat illness. Use work-rest controls and site arrangements applicable to the current UAE requirements and project conditions. If a worker develops confusion, collapse, severe weakness or other serious symptoms, treat it as an emergency and activate the site medical response.',
  'work_at_height': 'Prefer ground-level work and collective fall prevention before relying on personal fall protection. Check edges, openings, platforms, access systems, fragile surfaces and dropped-object exposure. Where fall arrest is used, confirm anchor suitability, clearance, equipment compatibility and a practical rescue plan before exposure. Never treat a harness as permission to work without an effective system of work.',
  'scaffolding_safety': 'Scaffolds should be suitable for the intended load and configuration, erected or modified by competent persons and protected against instability. Inspect after erection and following events that could affect integrity, and use the site tagging system where applicable. Do not remove braces, ties, platforms or guardrails without authorisation. Keep access, loading and housekeeping within the designed arrangement.',
  'ladder_safety': 'Select a ladder only when it is suitable for the task and conditions and when a safer access method is not reasonably practicable. Inspect feet, stiles, steps and locking arrangements, place it on a stable surface and maintain secure contact while climbing. Do not overreach, improvise height with boxes or unstable supports, or carry loads that prevent safe climbing. Control access around the ladder when others or moving equipment are nearby.',
  'confined_space': 'Treat confined-space entry as a planned high-risk activity. Identify atmospheric, engulfment, mechanical, electrical, thermal and access hazards; isolate energy and product sources; test the atmosphere using suitable equipment; and provide ventilation where required. Establish a competent standby arrangement and a rescue plan that does not depend on an unplanned entry by another worker. Stop entry when readings, conditions or communication fall outside the approved limits.',
  'excavation_trenching': 'Before excavation, establish the location of underground services, ground conditions, required support or battering and safe plant routes. Provide safe access and egress and keep spoil, vehicles and materials away from edges according to the approved design and risk controls. Inspect after changes, rain, vibration or other events that could affect stability. Never allow workers to enter an unsupported or otherwise uncontrolled excavation.',
  'lifting_operations': 'Plan the lift from load identification through set-down: determine weight and centre of gravity, select suitable lifting equipment and accessories, establish exclusion zones and agree communication. Verify inspection status, rated capacity and rigging condition before use. Control suspended-load exposure and account for wind, visibility, nearby structures and simultaneous work. Stop the lift when communication is lost, conditions change or the load cannot be controlled.',
  'electrical_safety': 'Control electrical risk through design, competent work, suitable equipment, inspection and effective isolation. Temporary systems should be protected from damage and unauthorised access, with appropriate protection devices and earthing arrangements. Before work near electrical systems, identify the source and boundaries and use the approved isolation/verification process. Treat unknown or damaged electrical equipment as unsafe until assessed by a competent person.',
  'lockout_tagout': 'Identify every hazardous energy source, including electrical, hydraulic, pneumatic, mechanical, thermal, chemical and stored or gravitational energy. Isolate, secure, identify and release stored energy, then verify zero energy before exposure. Personal control should be maintained according to the approved isolation system. Restoration must be controlled, communicated and completed only after people, tools and guards are confirmed clear.',
  'hot_work': 'Before welding, cutting, grinding or similar work, inspect the area above, below, behind and adjacent to the work for combustible materials and hidden openings. Control sparks, cylinders, hoses and ignition sources, provide suitable fire protection and fire watch where required, and manage fumes through ventilation or extraction. Stop if flammable atmosphere, uncontrolled combustible exposure or loss of fire controls develops.',
  'personal_protective_equipment': 'Select PPE from the actual residual risk and make sure it is compatible with other PPE and the work environment. Check fit, condition, cleanliness and service life before use. Train workers in limitations, adjustment, storage, cleaning and replacement. PPE should complement higher-level controls and should never be used to justify leaving a significant hazard uncontrolled.',
  'chemical_safety': 'Identify each chemical and its hazards before receipt, storage or use. Maintain correct labelling and access to current safety information, segregate incompatible substances and control ventilation and exposure during transfer or use. Prepare spill and exposure response arrangements before the task. Never use an unlabelled container or mix substances unless the approved process specifically permits it and the compatibility has been assessed.',
  'manual_handling': 'Assess the load, route, posture, frequency, distance and environment before lifting. Prefer mechanical aids for heavy, awkward or repetitive tasks and design the destination before movement starts. For team handling, use coordinated commands and enough people to control the load. Redesign repeated awkward lifting rather than relying only on worker technique or PPE.',
  'vehicle_traffic_safety': 'Separate people and moving vehicles wherever practicable using physical barriers, controlled crossings and defined routes. Manage reversing through route design, visibility aids and trained banksmen where required. Control speed, parking, loading and delivery interfaces and review the arrangement as the site changes. Stop vehicle movement when the driver loses visibility, communication or the required exclusion zone.',
  'housekeeping_workplace_safety': 'Housekeeping is a continuous control. Remove waste progressively, route hoses and cables to prevent trips, keep stairs and access routes clear and store materials so they cannot fall, roll or overload surfaces. Control spills immediately and use the correct waste route for contaminated material. Supervisors should inspect active work fronts during the shift, especially after deliveries, changes and high-production activities.',
};

// ============================================================================
// TOPIC-SPECIFIC PROFESSIONAL LEARNING CONTENT
// ============================================================================

final Map<String, List<_UaeSection>> _uaeTopicLearning = {
  'general_hse_responsibilities': _responsibilityLearning,
  'risk_assessment': _riskAssessmentLearning,
  'hazard_identification': _hazardIdentificationLearning,
  'hierarchy_of_controls': _hierarchyLearning,
  'permit_to_work': _ptwLearning,
  'job_safety_analysis': _jsaLearning,
  'toolbox_talk': _toolboxLearning,
  'accident_incident_reporting': _incidentLearning,
  'emergency_preparedness': _emergencyLearning,
  'fire_safety': _fireLearning,
  'heat_stress': _heatLearning,
  'work_at_height': _heightLearning,
  'scaffolding_safety': _scaffoldLearning,
  'ladder_safety': _ladderLearning,
  'confined_space': _confinedLearning,
  'excavation_trenching': _excavationLearning,
  'lifting_operations': _liftingLearning,
  'electrical_safety': _electricalLearning,
  'lockout_tagout': _lotoLearning,
  'hot_work': _hotWorkLearning,
  'personal_protective_equipment': _ppeLearning,
  'chemical_safety': _chemicalLearning,
  'manual_handling': _manualHandlingLearning,
  'vehicle_traffic_safety': _trafficLearning,
  'housekeeping_workplace_safety': _housekeepingLearning,
};

_UaeSection _uaeCoreSection(String title, String detail, String application) =>
    _UaeSection(
      title: title,
      items: [
        _UaeItem(
          title: 'Before work: establish the safe system',
          detail: detail,
          application: application,
        ),
        _UaeItem(
          title: 'During work: verify the critical controls',
          detail:
              'The control is effective only when it is present at the point of exposure, understood by the team and maintained throughout the task. Changes in people, equipment, sequence, weather, interfaces or work area can change the risk.',
          application:
              'The supervisor should physically verify the critical control, communicate changes and stop/reassess when the approved control cannot be maintained.',
        ),
        _UaeItem(
          title: 'After work: leave the workplace safe',
          detail:
              'Complete the task without creating a new hazard for the next work group. Remove temporary hazards, secure equipment and materials, restore barriers and report defects or outstanding actions.',
          application:
              'Close permits or task records where required, record important findings and ensure the area is safe for subsequent work.',
        ),
      ],
    );

final List<_UaeSection> _responsibilityLearning = [
  _uaeCoreSection(
    'Leadership & accountability',
    'Management is responsible for providing resources, competent people, suitable equipment and an organised system in which hazards are identified and controlled. Safety responsibilities should be assigned clearly rather than left as a general expectation.',
    'Confirm that the project organisation chart, HSE responsibilities, supervision arrangements and escalation routes are understood before work starts.',
  ),
  _UaeSection(title: 'Supervisor & worker duties', items: [
    _UaeItem(title: 'Supervisor control at the work front', detail: 'Supervisors translate procedures and risk assessments into practical controls at the work location. They must understand the task, recognise deviations and intervene when unsafe conditions develop.', application: 'Ask the supervisor to identify the main hazard, critical control, competent person and stop-work trigger.', safe: ['Pre-task briefing completed and critical controls physically verified.', 'Workers know whom to contact when conditions change.'], unsafe: ['Work starts without supervision for a high-risk activity.', 'Workers are told to continue after a critical control has failed.']),
    _UaeItem(title: 'Worker participation', detail: 'Workers are part of the control system. They should understand hazards, follow the approved method, use equipment correctly and report unsafe conditions, near misses and changes in the task.', application: 'Use worker feedback and toolbox discussions to confirm understanding rather than relying only on signatures.'),
  ]),
  _UaeSection(title: 'HSE assurance & continuous improvement', items: [
    _UaeItem(title: 'Inspection and follow-up', detail: 'HSE personnel provide monitoring, coaching and assurance. Findings should be recorded, assigned to responsible persons and followed to effective closure.', application: 'Verify that corrective actions address the underlying cause and not only the visible defect.'),
  ]),
];

final List<_UaeSection> _riskAssessmentLearning = [
  _uaeCoreSection('Hazard-to-control process', 'Risk assessment should identify the activity, hazards, people exposed, existing controls, likelihood and severity, then determine additional controls using the hierarchy of controls.', 'Walk the task in sequence and check that each significant hazard has a specific, verifiable control.'),
  _UaeSection(title: 'Dynamic risk assessment', items: [
    _UaeItem(title: 'Changing conditions', detail: 'A risk assessment is not a permanent permission to continue. Weather, simultaneous operations, equipment changes, new personnel, access restrictions and unexpected site conditions may invalidate the original assumptions.', application: 'Pause, reassess and brief the team whenever the work method or risk profile changes.', safe: ['Conditions are checked before each critical stage.', 'Workers know the stop-and-reassess trigger.'], unsafe: ['A completed assessment is treated as sufficient even after major changes.']),
    _UaeItem(title: 'Residual risk', detail: 'After controls are selected, the remaining risk should be understood and accepted only through the project/company process applicable to the activity.', application: 'Do not hide significant residual risk by simply lowering a matrix score without evidence that controls reduce exposure.'),
  ]),
  _UaeSection(title: 'Risk control verification', items: [
    _UaeItem(title: 'Critical control verification', detail: 'Controls must be measurable or observable. Examples include isolation status, edge protection, gas-test results, lifting exclusion zones and excavation support.', application: 'Record who verified the control, when it was verified and what evidence demonstrates that it was effective.'),
  ]),
];

final List<_UaeSection> _hazardIdentificationLearning = [
  _uaeCoreSection('Identify hazards systematically', 'Hazard identification should consider physical, chemical, biological, ergonomic, environmental and operational hazards. Include routine, non-routine, maintenance, emergency and simultaneous activities.', 'Use task observations, drawings, site walks, worker consultation, incident history and equipment information.'),
  _UaeSection(title: 'People, interfaces & change', items: [
    _UaeItem(title: 'Who can be exposed?', detail: 'Consider workers, contractors, visitors, drivers, members of the public and people working in adjacent areas. Exposure may occur even when a person is not directly performing the task.', application: 'Map interfaces and establish exclusion, communication and access controls.'),
    _UaeItem(title: 'Change and emerging hazards', detail: 'New equipment, materials, sequencing, weather, access or neighbouring work can introduce hazards that were not present during the original assessment.', application: 'Trigger review through management of change or dynamic assessment when conditions change.'),
  ]),
  _UaeSection(title: 'Field hazard verification', items: [
    _UaeItem(title: 'Point-of-exposure check', detail: 'The most useful hazard check happens at the exact work front immediately before exposure. Look for actual conditions rather than assuming the drawing or checklist is current.', application: 'Ask the team to identify the three highest-consequence hazards and show the physical controls.'),
  ]),
];

final List<_UaeSection> _hierarchyLearning = [
  _uaeCoreSection('Select controls in the correct order', 'Start with elimination where reasonably practicable, then substitution, engineering controls, administrative controls and PPE. PPE remains important but should not be the only control for significant hazards when stronger controls are practicable.', 'Challenge the assessment if it jumps directly to PPE without considering safer design, isolation or engineering solutions.'),
  _UaeSection(title: 'Engineering & administrative controls', items: [
    _UaeItem(title: 'Engineering controls', detail: 'Engineering controls physically separate people from hazards, for example guards, barriers, interlocks, edge protection, ventilation or remote operation.', application: 'Inspect the control itself and verify that it cannot be easily bypassed or defeated.'),
    _UaeItem(title: 'Administrative controls', detail: 'Procedures, permits, training, sequencing, supervision and signage help control exposure but depend on people following the system consistently.', application: 'Verify that the administrative control is understood and supported by practical physical controls where necessary.'),
  ]),
  _UaeSection(title: 'Control effectiveness', items: [
    _UaeItem(title: 'Do not confuse presence with effectiveness', detail: 'A control can exist but still fail. A guard may be open, a barrier may be displaced, a permit may not match the actual task, or PPE may be unsuitable or damaged.', application: 'Inspect, test and observe the control at the point of exposure.'),
  ]),
];

final List<_UaeSection> _ptwLearning = [
  _uaeCoreSection('Permit planning & boundaries', 'A permit-to-work system provides formal control of defined high-risk activities where required. The permit should identify the work, location, hazards, precautions, validity and responsible persons.', 'Verify the permit describes the actual job, exact area and current conditions before authorisation.'),
  _UaeSection(title: 'Isolation & prerequisites', items: [
    _UaeItem(title: 'Permit prerequisites', detail: 'Prerequisites may include risk assessment, isolation, gas testing, fire protection, competent persons, equipment inspection and area preparation depending on the task.', application: 'Do not issue or accept a permit when a critical prerequisite is incomplete.', safe: ['Permit boundaries match the work area and isolation is verified.', 'Required tests are current and recorded.'], unsafe: ['Permit is signed first and controls are arranged afterwards.', 'Workers extend the job beyond the permit boundary.']),
    _UaeItem(title: 'Suspension and revalidation', detail: 'A permit may need suspension when conditions change, alarms occur, weather becomes unsuitable or the work is interrupted. Revalidation must confirm that controls remain valid.', application: 'Treat significant changes as a trigger to stop and reassess rather than simply continuing the old permit.'),
  ]),
  _UaeSection(title: 'Close-out & handover', items: [
    _UaeItem(title: 'Safe completion', detail: 'At completion, remove tools and temporary controls safely, restore systems only through the authorised process and communicate outstanding hazards or work.', application: 'Confirm area condition, isolation status, housekeeping and handover before permit closure.'),
  ]),
];

final List<_UaeSection> _jsaLearning = [
  _uaeCoreSection('Break the task into steps', 'A JSA should describe the actual sequence of work, not a generic activity title. Each step should identify hazards and practical controls.', 'Walk through the job with the people who will perform it and challenge assumptions before approval.'),
  _UaeSection(title: 'Critical steps & controls', items: [
    _UaeItem(title: 'High-consequence steps', detail: 'Focus attention on steps involving energy release, work at height, lifting, excavation, electrical isolation, confined space entry, hot work or interaction with moving plant.', application: 'Identify which controls must be verified before the team moves to the next critical step.'),
    _UaeItem(title: 'Worker involvement', detail: 'Workers often know practical task details that are missed during office-based planning. Their input improves the accuracy of the JSA.', application: 'Use questions, demonstrations and feedback rather than only collecting signatures.'),
  ]),
  _UaeSection(title: 'JSA review in the field', items: [
    _UaeItem(title: 'Stop and update when conditions change', detail: 'If the sequence, equipment, access, weather or surrounding activities change, the JSA may no longer represent the real risk.', application: 'Pause the activity, reassess and rebrief the team before resuming.'),
  ]),
];

final List<_UaeSection> _toolboxLearning = [
  _uaeCoreSection('Toolbox talk preparation', 'A useful toolbox talk is short, task-specific and linked to the work planned for the shift. It should explain hazards, critical controls, emergency actions and stop-work conditions.', 'Use the actual work area, equipment and current site conditions as examples.'),
  _UaeSection(title: 'Worker understanding', items: [
    _UaeItem(title: 'Two-way communication', detail: 'Workers should have an opportunity to ask questions, raise concerns and identify changes. A signature alone does not prove understanding.', application: 'Ask workers to explain the main hazard and demonstrate the critical control.'),
    _UaeItem(title: 'Language and literacy', detail: 'Information should be communicated in a form workers can understand, using suitable language, visuals, demonstrations or translated support where necessary.', application: 'Check understanding by asking practical questions and observing the response.'),
  ]),
  _UaeSection(title: 'Field reinforcement', items: [
    _UaeItem(title: 'Brief again after change', detail: 'Repeat or update the briefing when there is a significant change in method, location, people, equipment or risk.', application: 'Record the change and confirm that the revised controls are understood before exposure.'),
  ]),
];

final List<_UaeSection> _incidentLearning = [
  _uaeCoreSection('Immediate response & reporting', 'Protect people first, control the scene and obtain medical or emergency assistance as required. Reporting should capture sufficient factual information for classification, investigation and learning.', 'Do not disturb evidence unnecessarily after life-saving actions unless required to make the area safe.'),
  _UaeSection(title: 'Investigation & root causes', items: [
    _UaeItem(title: 'Evidence collection', detail: 'Collect photographs, statements, records, equipment information and site conditions while evidence is reliable. Separate facts from assumptions.', application: 'Preserve relevant evidence and establish a clear timeline.'),
    _UaeItem(title: 'Root and system causes', detail: 'A strong investigation looks beyond the immediate unsafe act or condition and examines planning, competence, supervision, design, equipment, communication and organisational controls.', application: 'Corrective actions should address causes and be assigned with due dates and verification.'),
  ]),
  _UaeSection(title: 'Learning & closure', items: [
    _UaeItem(title: 'Share lessons', detail: 'Lessons learned should reach people who perform similar work so that controls improve across the project.', application: 'Check that corrective actions are implemented and effective before formal closure.'),
  ]),
];

final List<_UaeSection> _emergencyLearning = [
  _uaeCoreSection('Emergency planning', 'Emergency arrangements should be based on credible scenarios such as fire, medical emergency, collapse, spill, confined-space incident, electrical event or severe weather as applicable to the workplace.', 'Define alarms, communication, access, assembly areas, emergency contacts, roles and rescue arrangements.'),
  _UaeSection(title: 'Response readiness', items: [
    _UaeItem(title: 'Emergency equipment & access', detail: 'Emergency routes, exits, extinguishers, first-aid resources, rescue equipment and access for emergency responders must remain available and suitable for the identified scenarios.', application: 'Inspect emergency arrangements in the actual work area, especially after layout changes.'),
    _UaeItem(title: 'Drills and learning', detail: 'Exercises test whether people can recognise the alarm, communicate, evacuate and perform assigned roles under realistic conditions.', application: 'Record drill findings and close weaknesses rather than treating the drill as a ceremonial activity.'),
  ]),
  _UaeSection(title: 'Emergency decision-making', items: [
    _UaeItem(title: 'Protect, isolate, communicate', detail: 'Initial actions should prioritise life safety, control of additional exposure, notification and access for responders. Do not create a second casualty while attempting rescue.', application: 'Use task-specific emergency procedures and only allow trained persons to perform specialised rescue.'),
  ]),
];

final List<_UaeSection> _fireLearning = [
  _uaeCoreSection('Fire prevention', 'Fire safety starts with controlling ignition sources, fuel, oxygen and unsafe storage or housekeeping. Maintain clear access to fire equipment and emergency routes.', 'Inspect hot-work areas, electrical systems, flammable storage, waste accumulation and escape routes.'),
  _UaeSection(title: 'Detection & response', items: [
    _UaeItem(title: 'Fire equipment readiness', detail: 'Extinguishers and other fire protection systems must be suitable for the hazards, accessible, identifiable and maintained through the applicable inspection system.', application: 'Never block or remove fire equipment without an approved temporary arrangement.'),
    _UaeItem(title: 'Evacuation', detail: 'People should know alarm signals, escape routes, assembly arrangements and how to report missing persons.', application: 'Keep routes clear and test evacuation arrangements through drills.'),
  ]),
  _UaeSection(title: 'Hot work interface', items: [
    _UaeItem(title: 'Control ignition near combustibles', detail: 'Hot work can ignite hidden or adjacent combustible materials through sparks, heat transfer and radiant heat.', application: 'Use appropriate isolation, removal or shielding of combustibles and fire watch controls where required.', safe: ['Combustibles removed or protected and suitable fire controls available.'], unsafe: ['Grinding or welding performed next to unprotected combustible materials.']),
  ]),
];

final List<_UaeSection> _heatLearning = [
  _uaeCoreSection('Heat risk assessment', 'Heat stress risk depends on environmental conditions, workload, clothing, hydration, acclimatisation, individual susceptibility and the ability to recover.', 'Plan work around the heat conditions and use the applicable UAE/company heat-stress controls for the site and season.'),
  _UaeSection(title: 'Hydration, rest & acclimatisation', items: [
    _UaeItem(title: 'Work-rest-hydration controls', detail: 'Provide suitable drinking water, planned recovery opportunities and practical arrangements that reduce heat exposure. New or returning workers may require gradual acclimatisation.', application: 'Supervisors should monitor workload, environmental conditions and worker response rather than relying only on a fixed timetable.'),
    _UaeItem(title: 'Recognise symptoms early', detail: 'Headache, dizziness, weakness, excessive sweating, nausea, confusion or collapse can indicate heat illness. Severe symptoms require urgent emergency response.', application: 'Stop exposure, move the person to a cooler location and follow the site emergency/medical procedure.'),
  ]),
  _UaeSection(title: 'Supervision & worker fitness for the task', items: [
    _UaeItem(title: 'Active monitoring', detail: 'Heat management is an operational control, not only a welfare message. Supervisors should look for signs of heat strain and changes in conditions.', application: 'Use buddy checks and encourage early reporting of symptoms without stigma.'),
  ]),
];

final List<_UaeSection> _heightLearning = [
  _uaeCoreSection('Plan to prevent falls', 'Work at height should be planned to avoid the exposure where possible and otherwise use suitable work platforms, edge protection, safe access and fall protection systems appropriate to the task.', 'Verify the work platform, access, edge protection, equipment inspection, anchorage/rescue arrangements and exclusion zone before exposure.'),
  _UaeSection(title: 'Access, platforms & fall protection', items: [
    _UaeItem(title: 'Collective protection first', detail: 'Guardrails, properly designed platforms and other collective measures protect more than one person and reduce reliance on individual behaviour.', application: 'Inspect the physical protection at the work front and do not remove it without an authorised alternative control.'),
    _UaeItem(title: 'Personal fall protection', detail: 'Where required, harness systems, connectors and anchor arrangements must be suitable, inspected, correctly fitted and compatible with the task. Fall clearance and rescue must be considered before work.', application: 'Never connect to an unverified anchorage or use equipment outside its intended configuration.', safe: ['Inspected equipment, suitable anchorage and rescue plan confirmed before work.'], unsafe: ['Worker clips to an improvised point or works beyond the protected edge without suitable control.']),
  ]),
  _UaeSection(title: 'Dropped objects & rescue', items: [
    _UaeItem(title: 'Prevent objects falling', detail: 'Tools and materials at height can injure people below even when the worker does not fall. Use secure storage, toe boards, tool lanyards where suitable and controlled exclusion zones.', application: 'Keep people out of the drop zone and secure loose materials before work starts.'),
    _UaeItem(title: 'Rescue readiness', detail: 'A fall-arrest system may save a life but can create additional risk after a fall. Rescue arrangements should be practical for the location and available without relying on emergency services as the only plan.', application: 'Confirm rescue equipment, trained responders, access and communication before exposure.'),
  ]),
];

final List<_UaeSection> _scaffoldLearning = [
  _uaeCoreSection('Selection, design & erection', 'Scaffolds must be suitable for the intended use, loading and configuration and erected or modified by competent persons under the applicable system.', 'Confirm foundation, access, stability, platform arrangement, edge protection and required inspection before use.'),
  _UaeSection(title: 'Inspection & tagging', items: [
    _UaeItem(title: 'Pre-use and periodic inspection', detail: 'Inspect for stability, missing components, damaged boards, unsafe access, altered configuration and other defects. Inspection frequency should follow the applicable site and legal requirements.', application: 'Do not rely on a tag alone; physically verify the scaffold condition.'),
    _UaeItem(title: 'Modification control', detail: 'Unauthorised removal of braces, guardrails, boards or ties can compromise stability and fall protection.', application: 'Only authorised competent persons should alter the scaffold and the revised configuration should be re-inspected.', safe: ['Scaffold is inspected and complete before access.'], unsafe: ['Workers remove guardrails or braces to gain access or space.']),
  ]),
  _UaeSection(title: 'Safe use & loading', items: [
    _UaeItem(title: 'Platform loading', detail: 'Do not exceed the designed duty or load the platform with materials that obstruct access or create instability.', application: 'Control material quantities and keep access routes clear.'),
  ]),
];

final List<_UaeSection> _ladderLearning = [
  _uaeCoreSection('Select the right access equipment', 'Ladders should be used only where the task, duration, conditions and risk justify their use. Safer platforms or other access systems should be considered where practicable.', 'Check ladder type, condition, ground, angle/position, access point and task requirements before use.'),
  _UaeSection(title: 'Positioning & three-point contact', items: [
    _UaeItem(title: 'Stable setup', detail: 'The ladder must be placed on a stable surface, secured as required and positioned to prevent displacement. Access points and overhead hazards must be considered.', application: 'Never improvise with boxes, drums or unstable supports to gain additional height.', safe: ['Ladder is inspected, stable and positioned correctly for the task.'], unsafe: ['Ladder placed on a loose surface or used from an improvised support.']),
    _UaeItem(title: 'Safe climbing', detail: 'Maintain suitable contact and face the ladder when climbing. Carrying large loads that prevent secure climbing creates fall risk.', application: 'Use suitable methods for tools and materials rather than carrying loads that compromise balance.'),
  ]),
  _UaeSection(title: 'Work limitations', items: [
    _UaeItem(title: 'Know when to stop using a ladder', detail: 'Poor weather, unstable ground, excessive reach, long-duration work or a need for both hands may indicate that a different access system is required.', application: 'Change the method rather than forcing the ladder to perform a task it is not suitable for.'),
  ]),
];

final List<_UaeSection> _confinedLearning = [
  _uaeCoreSection('Identify & assess the space', 'A confined space can contain atmospheric, engulfment, mechanical, electrical, thermal or access hazards. The entry plan must be based on the actual space and task.', 'Confirm identification, risk assessment, entry controls, isolation and rescue arrangements before entry.'),
  _UaeSection(title: 'Permit, isolation & atmosphere', items: [
    _UaeItem(title: 'Isolation', detail: 'Prevent unexpected release of energy, product, gas, liquid or moving equipment into the space through verified isolation appropriate to the hazards.', application: 'Verify isolation at the point of exposure and control re-energisation.'),
    _UaeItem(title: 'Atmospheric testing', detail: 'Test for oxygen adequacy and relevant toxic, flammable or other contaminants using suitable calibrated equipment and an appropriate testing strategy.', application: 'Define testing locations, frequency and alarm response before entry.', safe: ['Atmosphere tested and acceptable before entry with continuous/periodic monitoring as required.'], unsafe: ['Worker enters based only on a previous test or smell without required monitoring.']),
  ]),
  _UaeSection(title: 'Standby & rescue', items: [
    _UaeItem(title: 'Rescue without creating another casualty', detail: 'The standby arrangement must maintain communication and initiate emergency response. Rescue equipment and trained responders must match the space and foreseeable incident.', application: 'Do not send an unprotected person into the space to rescue a collapsed worker.'),
    _UaeItem(title: 'Continuous control', detail: 'Conditions can change because of process activity, ventilation failure, weather, adjacent work or product release.', application: 'Stop entry and evacuate if alarm limits or other critical conditions are exceeded.'),
  ]),
];

final List<_UaeSection> _excavationLearning = [
  _uaeCoreSection('Plan the excavation', 'Excavation risk depends on ground conditions, depth, adjacent structures, underground services, water, plant and access. Planning should establish the safe method before breaking ground.', 'Verify drawings/service information, ground assessment, access, support or battering requirements and work boundaries.'),
  _UaeSection(title: 'Ground stability & services', items: [
    _UaeItem(title: 'Prevent collapse', detail: 'Unsupported sides can collapse suddenly. Suitable shoring, shielding, benching or safe battering should be selected according to the actual ground and excavation conditions.', application: 'Inspect the excavation and protective system, especially after rain, vibration, plant movement or changes.'),
    _UaeItem(title: 'Underground services', detail: 'Electricity, gas, water, communication and other buried services can create fatal or disruptive hazards when struck.', application: 'Use approved information, locating methods, permits and controlled excavation practices applicable to the site.', safe: ['Services identified and controlled before excavation.'], unsafe: ['Excavation starts using assumptions about service location.']),
  ]),
  _UaeSection(title: 'Access, plant & inspection', items: [
    _UaeItem(title: 'Safe access and egress', detail: 'Provide suitable access and keep it clear. Workers should not climb unstable sides or enter areas where escape is compromised.', application: 'Check access at the start of each shift and after changes.'),
    _UaeItem(title: 'Plant interface', detail: 'Excavators, dumpers and other plant can overload edges or strike people. Keep safe separation and control reversing and movement.', application: 'Use defined routes, exclusion zones and competent banksman arrangements where required.'),
  ]),
];

final List<_UaeSection> _liftingLearning = [
  _uaeCoreSection('Lift planning', 'Lifting should be planned for load weight, centre of gravity, lifting points, equipment capacity, ground conditions, travel path, weather and people affected by the operation.', 'Use a lift plan appropriate to the complexity and criticality of the lift and define the exclusion zone.'),
  _UaeSection(title: 'Equipment & lifting accessories', items: [
    _UaeItem(title: 'Crane and accessory suitability', detail: 'Confirm rated capacity, configuration, radius, lifting accessories, inspection status and compatibility with the load. Do not exceed rated capacity or use damaged accessories.', application: 'Inspect equipment before the lift and ensure competent personnel control the operation.', safe: ['Lift plan matches actual load and equipment configuration.', 'Accessories are identified, inspected and suitable.'], unsafe: ['Load is estimated without reliable information or damaged accessories are used.']),
    _UaeItem(title: 'Rigging & load control', detail: 'Correct rigging protects the load and people from uncontrolled movement. Consider sharp edges, sling angles, lifting points, tag lines and stability.', application: 'Conduct a pre-lift check and keep people out of suspended-load and line-of-fire areas.'),
  ]),
  _UaeSection(title: 'Communication & environmental conditions', items: [
    _UaeItem(title: 'Exclusion zone and signals', detail: 'Only authorised persons should enter the controlled lifting area. Communication between operator, signaler and riggers must be clear and agreed before the lift.', application: 'Stop if communication is lost or unauthorised people enter the exclusion zone.'),
    _UaeItem(title: 'Wind and visibility', detail: 'Wind, poor visibility, lightning and other environmental conditions can make a lift unsafe depending on the equipment and load.', application: 'Follow equipment limits and project controls and stop when conditions exceed safe limits.'),
  ]),
];

final List<_UaeSection> _electricalLearning = [
  _uaeCoreSection('Electrical risk control', 'Electrical work can cause shock, burns, arc flash, fire and secondary falls. Controls should address design, isolation, competent persons, equipment condition and environmental exposure.', 'Identify the energy source, isolation point, work boundary and verification method before work.'),
  _UaeSection(title: 'Isolation & verification', items: [
    _UaeItem(title: 'De-energise where practicable', detail: 'The safest approach is to eliminate exposure by isolating and de-energising equipment before work. Where work on or near energised systems is permitted, additional controls and competent persons are required.', application: 'Never assume a circuit is dead because a switch is off; verify absence of energy through the approved process.', safe: ['Isolation identified, secured and verified before work.'], unsafe: ['Worker relies on a label or switch position without verification.']),
    _UaeItem(title: 'Temporary electrical systems', detail: 'Temporary distribution, cables, sockets and protective devices must be suitable, protected from damage and maintained in safe condition.', application: 'Inspect cables, plugs, enclosures, protection and routing before use.'),
  ]),
  _UaeSection(title: 'Work near services', items: [
    _UaeItem(title: 'Overhead and buried services', detail: 'Maintain the required controls for work near electrical services, including identification, exclusion, protection and authorised methods.', application: 'Plan plant movement and excavation routes before starting work.'),
  ]),
];

final List<_UaeSection> _lotoLearning = [
  _uaeCoreSection('Isolation strategy', 'Lockout/tagout controls unexpected release of hazardous energy during maintenance, cleaning, inspection or other intervention. Identify all energy sources, not only electrical energy.', 'Map electrical, mechanical, hydraulic, pneumatic, thermal, gravitational, chemical and stored energy as applicable.'),
  _UaeSection(title: 'Lock, tag, try & verify', items: [
    _UaeItem(title: 'Personal protection through isolation', detail: 'Isolation should prevent re-energisation and be controlled by authorised persons. Where required, each exposed worker should maintain personal control of the isolation.', application: 'Follow the approved sequence: isolate, secure, identify, release stored energy and verify zero energy before work.', safe: ['Isolation is physically secured and zero-energy state verified.'], unsafe: ['A warning tag is used without effective isolation or verification.']),
    _UaeItem(title: 'Stored energy', detail: 'Pressure, gravity, springs, capacitors, heat and other stored energy can remain after shutdown.', application: 'Bleed, block, discharge, restrain or otherwise control stored energy before exposure.'),
  ]),
  _UaeSection(title: 'Restoration & handover', items: [
    _UaeItem(title: 'Controlled re-energisation', detail: 'Restoration should occur only after tools and people are clear, guards are restored and the responsible persons confirm the system is ready.', application: 'Use the authorised removal and re-energisation sequence and communicate status to affected persons.'),
  ]),
];

final List<_UaeSection> _hotWorkLearning = [
  _uaeCoreSection('Hot work assessment', 'Welding, cutting, grinding and other spark or heat-producing work can ignite combustible materials and create fumes, burns and other hazards.', 'Assess the area, remove or protect combustibles, control cylinders and establish fire controls before starting.'),
  _UaeSection(title: 'Preparation & fire watch', items: [
    _UaeItem(title: 'Prepare the work area', detail: 'Control combustible materials, openings, adjacent rooms, hidden spaces and flammable atmospheres. Protect surfaces and establish barriers as needed.', application: 'Inspect above, below and behind the work for possible heat or spark travel.'),
    _UaeItem(title: 'Fire watch', detail: 'Where required, a competent fire watch monitors the work and surrounding area for ignition and remains available for the defined post-work period.', application: 'Fire watch should not be distracted by unrelated duties.', safe: ['Area checked and suitable fire controls positioned before work.'], unsafe: ['Hot work continues with combustibles nearby and no effective fire monitoring.']),
  ]),
  _UaeSection(title: 'Gas cylinders & fumes', items: [
    _UaeItem(title: 'Cylinder safety', detail: 'Secure cylinders upright where required, protect valves, separate incompatible gases as applicable and keep them away from heat and vehicle impact.', application: 'Inspect hoses, regulators and connections and control leaks.'),
    _UaeItem(title: 'Fume control', detail: 'Welding and cutting can produce hazardous fumes. Use suitable ventilation, local extraction or respiratory protection based on the exposure assessment.', application: 'Do not use respiratory protection as a substitute for practical ventilation when effective ventilation is reasonably practicable.'),
  ]),
];

final List<_UaeSection> _ppeLearning = [
  _uaeCoreSection('Select PPE from the residual risk', 'PPE should be selected after assessing the hazard and other controls. It must be suitable for the task, user, environment and compatibility with other PPE.', 'Specify PPE by hazard rather than using one generic list for every activity.'),
  _UaeSection(title: 'Fit, inspection & compatibility', items: [
    _UaeItem(title: 'Correct fit', detail: 'Poorly fitting PPE can reduce protection or create secondary hazards. Fit testing or sizing may be necessary for certain equipment.', application: 'Check fit, adjustment and compatibility before entering the exposure area.'),
    _UaeItem(title: 'Inspection and maintenance', detail: 'Damaged, contaminated or expired PPE may not provide the intended protection.', application: 'Users should inspect before use and follow replacement, cleaning and storage requirements.'),
  ]),
  _UaeSection(title: 'Training & limitations', items: [
    _UaeItem(title: 'Understand what PPE can and cannot do', detail: 'PPE controls exposure only while worn correctly and within its design limits. It does not remove the hazard.', application: 'Train workers on selection, use, limitations, care and emergency actions.', safe: ['PPE matches the hazard and is used with stronger controls.'], unsafe: ['PPE is treated as the only control for a significant hazard when better controls are available.']),
  ]),
];

final List<_UaeSection> _chemicalLearning = [
  _uaeCoreSection('Chemical hazard assessment', 'Chemical risks depend on substance properties, concentration, route of exposure, quantity and task. Use the applicable safety data and workplace exposure information.', 'Identify chemicals before use and establish storage, handling, ventilation, PPE and emergency controls.'),
  _UaeSection(title: 'Storage & handling', items: [
    _UaeItem(title: 'Compatibility and containment', detail: 'Store chemicals according to compatibility, container condition, labelling and required environmental controls. Prevent incompatible materials from interacting.', application: 'Inspect storage areas and secondary containment where applicable.'),
    _UaeItem(title: 'Transfer and dispensing', detail: 'Pouring, mixing, spraying and decanting can increase exposure and spill risk.', application: 'Use suitable equipment, ventilation and controlled transfer methods.'),
  ]),
  _UaeSection(title: 'Spill, exposure & waste', items: [
    _UaeItem(title: 'Emergency response', detail: 'Workers should know how to respond to spills, splashes, inhalation or other exposures and when to seek medical assistance.', application: 'Keep appropriate spill and emergency resources available for the identified substances.', safe: ['Containers labelled, closed and stored correctly.'], unsafe: ['Unknown liquid stored in an unlabelled container.']),
  ]),
];

final List<_UaeSection> _manualHandlingLearning = [
  _uaeCoreSection('Assess the manual task', 'Manual-handling risk depends on load weight, size, grip, posture, frequency, distance, environment and individual capability.', 'Look for opportunities to eliminate or mechanise the lift before relying on lifting technique alone.'),
  _UaeSection(title: 'Planning & team handling', items: [
    _UaeItem(title: 'Use mechanical assistance', detail: 'Trolleys, hoists, forklifts and other aids can reduce force and repetition when selected and used correctly.', application: 'Plan the route, equipment and destination before moving the load.'),
    _UaeItem(title: 'Team lifting', detail: 'Team lifts require coordinated movement, suitable numbers and clear communication. One person should lead the movement where appropriate.', application: 'Avoid team lifting when the load or route cannot be controlled safely.'),
  ]),
  _UaeSection(title: 'Ergonomic technique', items: [
    _UaeItem(title: 'Reduce awkward exposure', detail: 'Keep loads close where practicable, avoid twisting under load and position work to reduce prolonged bending, reaching and forceful exertion.', application: 'Modify the workplace or task if repeated awkward postures remain necessary.'),
  ]),
];

final List<_UaeSection> _trafficLearning = [
  _uaeCoreSection('Traffic management planning', 'Vehicle and pedestrian interaction can cause fatal struck-by and crushing incidents. Plan routes, separation, speed control, visibility and reversing arrangements.', 'Map pedestrian and vehicle movements before work starts and review them as the site changes.'),
  _UaeSection(title: 'Pedestrian & plant separation', items: [
    _UaeItem(title: 'Physical segregation', detail: 'Where practicable, use physical barriers and dedicated routes to separate pedestrians from moving plant.', application: 'Do not rely only on signs where a physical separation is reasonably practicable.', safe: ['Pedestrian route physically separated from plant movement.'], unsafe: ['Workers walk through active plant routes because the shortest route is convenient.']),
    _UaeItem(title: 'Reversing control', detail: 'Reversing is a high-risk movement because visibility can be restricted. Use suitable engineering and administrative controls such as cameras, alarms, route design and trained banksmen where required.', application: 'Stop movement if the driver loses visibility or communication.'),
  ]),
  _UaeSection(title: 'Public and changing site interfaces', items: [
    _UaeItem(title: 'Protect changing boundaries', detail: 'Construction sites and temporary work areas can change daily. Public interfaces, gates and deliveries must be reviewed as the layout changes.', application: 'Update traffic arrangements and brief drivers and workers after significant changes.'),
  ]),
];

final List<_UaeSection> _housekeepingLearning = [
  _uaeCoreSection('Orderly workplace', 'Good housekeeping prevents slips, trips, falls, fire loading, blocked access and uncontrolled materials. It should be treated as a continuous operational control.', 'Define who owns housekeeping at each work front and remove waste progressively rather than waiting for a final clean-up.'),
  _UaeSection(title: 'Access, storage & waste', items: [
    _UaeItem(title: 'Keep routes clear', detail: 'Walkways, stairs, emergency exits, fire equipment and access to plant should remain clear. Cables, hoses and temporary materials need controlled routing.', application: 'Inspect access routes during the shift, not only at the end of the day.'),
    _UaeItem(title: 'Safe storage', detail: 'Materials should be stacked or stored so they cannot fall, roll, obstruct access or create excessive loading.', application: 'Use designated storage areas and secure unstable items.'),
  ]),
  _UaeSection(title: 'Spills & waste control', items: [
    _UaeItem(title: 'Immediate spill response', detail: 'Spills should be controlled promptly using suitable resources and the correct waste route for the material.', application: 'Do not walk past a spill expecting another person to control it; isolate the area and initiate the site response.'),
  ]),
];
