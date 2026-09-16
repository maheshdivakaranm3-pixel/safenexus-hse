import 'package:flutter/material.dart';

import '../models/reference_topic.dart';
import '../models/guideline_category.dart';

const List<ReferenceTopic> abuDhabiGuidelines = [
ReferenceTopic(
id: 'ad_oshad_sf',
title: 'Abu Dhabi Occupational Safety & Health System Framework',
shortTitle: 'ADOSH-SF',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'Abu Dhabi Public Health Centre (ADPHC)',
jurisdiction: 'Abu Dhabi',
description:
'Overview of the Abu Dhabi Occupational Safety and Health System Framework (ADOSH-SF), the emirate-level framework for managing occupational safety and health risks and establishing an effective OSH management system.',
keyRequirements: [
'Establish and maintain an occupational safety and health management system appropriate to the entity and its activities.',
'Identify and control occupational safety and health risks.',
'Define organisational roles, responsibilities and accountability.',
'Implement applicable ADOSH-SF requirements and relevant sector requirements.',
'Maintain appropriate consultation, communication and worker participation arrangements.',
'Monitor OSH performance and compliance.',
'Report applicable incidents and required information through prescribed channels.',
'Promote continual improvement of occupational safety and health performance.',
],
safetyControls: [
'ADOSH-SF framework',
'OSH management system',
'Risk assessment',
'HSE procedures',
'Training and competency',
'Incident reporting',
'Inspection and audit',
'Performance monitoring',
'Corrective actions',
],
responsibilities: [
'Management provides leadership, resources and accountability.',
'Supervisors implement safe systems of work.',
'Workers follow approved procedures and report hazards.',
'HSE personnel monitor implementation and provide professional advice.',
],
references: [
'ADOSH-SF – Abu Dhabi Occupational Safety and Health System Framework',
'ADPHC – ADOSH-SF Legislation',
'ADOSH-SF Manual – Version 4.0',
'Department of Municipalities and Transport (DMT) – Occupational Safety & Health Management System',
],
),

ReferenceTopic(
id: 'ad_oshms',
title: 'Occupational Safety & Health Management System',
shortTitle: 'OSHMS',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'ADPHC / Sector Regulatory Authorities',
jurisdiction: 'Abu Dhabi',
description:
'Guidance for establishing, implementing, maintaining and continually improving an Occupational Safety and Health Management System in accordance with applicable ADOSH-SF requirements.',
keyRequirements: [
'Define the scope of the OSH management system.',
'Establish OSH policies, objectives and responsibilities.',
'Identify legal and other applicable requirements.',
'Identify hazards and assess occupational risks.',
'Establish operational controls and safe systems of work.',
'Provide training, competency and awareness arrangements.',
'Monitor and measure OSH performance.',
'Investigate incidents and implement corrective actions.',
'Conduct management review and continual improvement.',
],
safetyControls: [
'OSH policy',
'Risk management',
'HSE plans',
'Procedures',
'Training matrix',
'Inspections',
'Audits',
'Performance indicators',
'Corrective action system',
],
responsibilities: [
'Management owns the OSHMS and provides resources.',
'HSE personnel coordinate system implementation and monitoring.',
'Supervisors implement requirements at operational level.',
'Workers participate and comply with the OSHMS.',
],
references: [
'ADOSH-SF – Manual, Version 4.0',
'ADOSH-SF – Elements, Version 4.0',
'ADOSH-SF – Mechanisms, Version 4.0',
'DMT – Occupational Safety & Health Management System',
],
),

ReferenceTopic(
id: 'ad_risk_management',
title: 'Abu Dhabi Risk Management',
shortTitle: 'Risk Management',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'DMT / ADOSH-SF',
jurisdiction: 'Abu Dhabi',
description:
'Guidance for systematic identification, assessment and control of occupational safety and health risks in Abu Dhabi workplaces, projects and construction activities.',
keyRequirements: [
'Identify hazards associated with activities and workplaces.',
'Assess risks using an appropriate risk assessment methodology.',
'Apply the hierarchy of controls when selecting control measures.',
'Communicate significant risks to affected workers.',
'Review risk assessments when conditions, activities or controls change.',
'Maintain documented risk information where required.',
'Consider contractor, interface and simultaneous-operation risks.',
],
safetyControls: [
'Risk assessment',
'Task risk assessment',
'JSA',
'Hierarchy of controls',
'Dynamic risk assessment',
'Management of change',
'Risk communication',
'Risk register',
],
responsibilities: [
'Management provides resources for risk control.',
'Supervisors verify controls before and during work.',
'Workers participate in hazard identification and risk control.',
'HSE personnel facilitate and review risk assessments.',
],
references: [
'ADOSH-SF – OSH Management System requirements',
'DMT – Risk Assessment Model for Building & Construction Projects',
'Project HSE Plan',
'Applicable ADOSH-SF requirements',
],
),

ReferenceTopic(
id: 'ad_hse_plan',
title: 'HSE Plan for Building & Construction',
shortTitle: 'HSE Plan',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'DMT',
jurisdiction: 'Abu Dhabi',
description:
'Guidance for developing and implementing an HSE plan for building, construction and infrastructure projects in Abu Dhabi.',
keyRequirements: [
'Define project HSE objectives, responsibilities and arrangements.',
'Identify project-specific hazards and risks.',
'Define applicable legal and authority requirements.',
'Establish control measures and safe work procedures.',
'Define emergency arrangements.',
'Define inspection, audit and monitoring arrangements.',
'Define incident reporting and investigation arrangements.',
'Review and update the plan when project conditions change.',
],
safetyControls: [
'Project HSE plan',
'Risk register',
'Method statements',
'Inspection plans',
'Emergency response plan',
'Training plan',
'Audit programme',
'Corrective action tracking',
],
responsibilities: [
'Project management ensures implementation.',
'HSE management coordinates the plan.',
'Supervisors implement task-level requirements.',
'Workers follow project procedures.',
],
references: [
'ADOSH-SF – CoP 53.1: OSH Construction Management Plan, Version 4.1',
'DMT – Guideline for Developing HSE Plan in Building and Construction Sector',
'ADOSH-SF – CoP 53.0: OSH Management During Construction Work',
'Applicable DMT and project requirements',
],
),

ReferenceTopic(
id: 'ad_roles_responsibilities',
title: 'OSH Roles & Responsibilities',
shortTitle: 'Roles & Responsibilities',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'ADPHC / ADOSH-SF',
jurisdiction: 'Abu Dhabi',
description:
'Guidance on organisational accountability, roles and responsibilities for occupational safety and health under the ADOSH-SF framework.',
keyRequirements: [
'Define management accountability for OSH.',
'Define HSE responsibilities and authority.',
'Define supervisor responsibilities.',
'Define worker responsibilities.',
'Define contractor and subcontractor responsibilities.',
'Ensure responsibilities are communicated to relevant personnel.',
'Provide sufficient competent resources.',
],
safetyControls: [
'Organisation chart',
'Responsibility matrix',
'HSE roles',
'Competency requirements',
'Delegation of authority',
'Performance monitoring',
],
responsibilities: [
'Management provides leadership and resources.',
'HSE personnel provide specialist advice and monitoring.',
'Supervisors control daily work activities.',
'Workers follow procedures and report unsafe conditions.',
],
references: [
'ADOSH-SF – Manual, Version 4.0',
'ADOSH-SF – Elements, Version 4.0',
'ADOSH-SF – Element 1: Roles, Responsibilities and Self-Regulation',
'Project HSE Plan',
],
),

ReferenceTopic(
id: 'ad_incident_reporting',
title: 'Incident & Accident Reporting',
shortTitle: 'Incident Reporting',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'ADPHC / ADOSH-SF',
jurisdiction: 'Abu Dhabi',
description:
'Guidance for reporting, investigating and learning from occupational incidents, injuries and other reportable events in Abu Dhabi.',
keyRequirements: [
'Report applicable incidents through the required channels.',
'Notify responsible management and HSE personnel promptly.',
'Preserve the incident scene where appropriate.',
'Conduct an investigation proportionate to the event.',
'Identify immediate, underlying and root causes.',
'Implement corrective and preventive actions.',
'Submit mandatory information through prescribed systems where required.',
'Track actions until effective closure.',
],
safetyControls: [
'Incident notification',
'Scene preservation',
'Investigation',
'Root cause analysis',
'Corrective actions',
'Lessons learned',
'Electronic reporting where applicable',
],
responsibilities: [
'Workers report incidents and unsafe conditions immediately.',
'Supervisors secure the area and initiate reporting.',
'HSE personnel coordinate investigation and corrective actions.',
'Management ensures required regulatory reporting is completed.',
],
references: [
'ADOSH-SF – Mechanisms',
'ADOSH-SF – Mechanism 1: Integration of OSH Requirements',
'Applicable ADOSH-SF incident reporting requirements',
'Project Incident Reporting Procedure',
],
),

ReferenceTopic(
id: 'ad_training_competency',
title: 'Training & Competency',
shortTitle: 'Training & Competency',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'ADPHC / ADOSH-SF',
jurisdiction: 'Abu Dhabi',
description:
'Guidance for ensuring workers, supervisors and other personnel have the knowledge, skills and competency required for their assigned safety-critical duties.',
keyRequirements: [
'Identify competency requirements for safety-critical activities.',
'Provide appropriate induction and training.',
'Maintain competency and training records.',
'Use competent personnel for specialised activities.',
'Provide refresher training when required.',
'Evaluate competency where appropriate.',
'Address identified training gaps.',
],
safetyControls: [
'Training matrix',
'Site induction',
'Task-specific training',
'Competency assessment',
'Refresher training',
'Authorisation systems',
'Training records',
],
responsibilities: [
'Management provides training resources.',
'Supervisors ensure workers are competent for assigned tasks.',
'Workers attend required training and follow instructions.',
'HSE personnel monitor training and competency requirements.',
],
references: [
'ADOSH-SF – Manual, Version 4.0',
'ADOSH-SF – Elements, Version 4.0',
'Applicable competency requirements',
'Project Training Matrix',
],
),

ReferenceTopic(
id: 'ad_contractor_management',
title: 'Contractor & Subcontractor Management',
shortTitle: 'Contractor Management',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'ADPHC / ADOSH-SF',
jurisdiction: 'Abu Dhabi',
description:
'Guidance for managing occupational safety and health risks associated with contractors, subcontractors and other external parties.',
keyRequirements: [
'Evaluate contractor HSE capability before engagement where required.',
'Communicate project HSE requirements.',
'Verify contractor risk assessments and method statements.',
'Monitor contractor compliance.',
'Coordinate simultaneous activities and interfaces.',
'Address contractor incidents and non-conformances.',
'Maintain appropriate records and performance information.',
],
safetyControls: [
'Prequalification',
'Contractor HSE evaluation',
'HSE plan review',
'Induction',
'Permit to work',
'Site inspections',
'Audits',
'Performance monitoring',
],
responsibilities: [
'Principal or project management establishes requirements.',
'Contractors implement safe systems for their work.',
'Supervisors monitor contractor activities.',
'HSE personnel verify compliance and coordinate monitoring.',
],
references: [
'ADOSH-SF – Technical Guideline: Management of Contractors, Version 4.0',
'ADOSH-SF – OSH Management System requirements',
'Project HSE Plan',
'Contractor HSE Management Procedure',
],
),

ReferenceTopic(
id: 'ad_emergency_management',
title: 'Emergency Management',
shortTitle: 'Emergency Management',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'ADPHC / Applicable Authorities',
jurisdiction: 'Abu Dhabi',
description:
'Guidance for identifying foreseeable emergencies and preparing effective response arrangements for Abu Dhabi workplaces and construction sites.',
keyRequirements: [
'Identify credible emergency scenarios.',
'Prepare an emergency response plan.',
'Define emergency roles and responsibilities.',
'Provide emergency communication arrangements.',
'Maintain emergency access and escape routes.',
'Provide suitable emergency equipment.',
'Provide first aid and medical emergency arrangements.',
'Conduct drills and exercises as appropriate.',
'Review emergency arrangements after incidents and exercises.',
],
safetyControls: [
'Emergency response plan',
'Emergency contacts',
'Alarm systems',
'Assembly points',
'First aid',
'Fire response',
'Rescue arrangements',
'Emergency drills',
],
responsibilities: [
'Management provides emergency resources.',
'Emergency teams respond according to the plan.',
'Supervisors account for personnel.',
'Workers follow emergency instructions.',
'HSE personnel coordinate preparedness and review.',
],
references: [
'ADOSH-SF – CoP 4.0: First Aid and Medical Emergency Treatment, Version 4.0',
'ADOSH-SF – applicable emergency management requirements',
'Project Emergency Response Plan',
'Applicable Abu Dhabi Civil Defence requirements',
],
),

ReferenceTopic(
id: 'ad_work_at_height',
title: 'Work at Height',
shortTitle: 'Work at Height',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'ADPHC / ADOSH-SF',
jurisdiction: 'Abu Dhabi',
description:
'Guidance for controlling fall-from-height risks during construction, maintenance and other elevated activities in Abu Dhabi.',
keyRequirements: [
'Assess work-at-height risks before starting work.',
'Avoid work at height where reasonably practicable.',
'Provide suitable collective fall protection.',
'Provide safe access and working platforms.',
'Use suitable personal fall protection where required.',
'Inspect fall protection equipment before use.',
'Control dropped-object risks.',
'Provide rescue arrangements where fall arrest systems are used.',
],
safetyControls: [
'Guardrails',
'Scaffolding',
'MEWPs',
'Fall restraint',
'Fall arrest',
'Lifelines',
'Safety nets where appropriate',
'Exclusion zones',
'Rescue plan',
],
responsibilities: [
'Management provides suitable equipment and systems.',
'Supervisors verify controls before work starts.',
'Workers use fall protection correctly.',
'HSE personnel monitor compliance.',
],
references: [
'ADOSH-SF – CoP 23.0: Working at Heights, Version 4.1',
'Effective date: 27 February 2026',
'Project Work at Height Procedure',
'Applicable ADOSH-SF requirements',
],
),

ReferenceTopic(
id: 'ad_scaffolding',
title: 'Scaffolding Safety',
shortTitle: 'Scaffolding',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'ADPHC / ADOSH-SF',
jurisdiction: 'Abu Dhabi',
description:
'Guidance for safe erection, modification, inspection, maintenance and use of scaffolding systems on Abu Dhabi projects.',
keyRequirements: [
'Use competent personnel for erection and modification.',
'Provide stable foundations and adequate support.',
'Install suitable guardrails and toe boards.',
'Provide safe access and egress.',
'Prevent unauthorised alteration.',
'Inspect scaffolds before use and following significant changes or events.',
'Control loads within the designed capacity.',
],
safetyControls: [
'Competent scaffolders',
'Base plates',
'Sole boards where required',
'Guardrails',
'Toe boards',
'Safe access',
'Inspection',
'Load control',
'Scaffold status identification',
],
responsibilities: [
'Scaffolders erect and modify systems safely.',
'Supervisors prevent unauthorised modifications.',
'Workers use scaffolds as intended.',
'HSE personnel monitor scaffold safety.',
],
references: [
'ADOSH-SF – CoP 26.0: Scaffolding, Version 4.1',
'Effective date: 27 February 2026',
'Applicable scaffold design and inspection requirements',
'Project Scaffolding Procedure',
],
),

ReferenceTopic(
id: 'ad_lifting_operations',
title: 'Lifting Operations',
shortTitle: 'Lifting Operations',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'ADPHC / ADOSH-SF',
jurisdiction: 'Abu Dhabi',
description:
'Guidance for planning and controlling crane and lifting operations, including lifting equipment, accessories, personnel and exclusion zones.',
keyRequirements: [
'Plan lifting operations according to risk.',
'Use competent lifting personnel.',
'Ensure lifting equipment and accessories are suitable and inspected.',
'Confirm load weight and lifting capacity.',
'Control suspended loads and exclusion zones.',
'Use competent operators and riggers.',
'Use effective communication and signalling.',
'Consider weather and site conditions.',
],
safetyControls: [
'Lifting plan',
'Equipment inspection',
'Third-party inspection where applicable',
'Competent crane operator',
'Competent rigger',
'Banksman/signaller',
'Exclusion zone',
'Load control',
'Weather monitoring',
],
responsibilities: [
'Lifting supervisors coordinate operations.',
'Operators operate within approved limits.',
'Riggers secure loads correctly.',
'Banksmen provide agreed signals.',
'HSE personnel monitor lifting controls.',
],
references: [
'ADOSH-SF – CoP 34.0: Safe Use of Lifting Equipment and Lifting Accessories, Version 4.1',
'Effective date: 27 February 2026',
'Applicable lifting equipment inspection requirements',
'Manufacturer instructions',
],
),

ReferenceTopic(
id: 'ad_confined_space',
title: 'Confined Space Entry',
shortTitle: 'Confined Space',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'ADPHC / ADOSH-SF',
jurisdiction: 'Abu Dhabi',
description:
'Guidance for controlling hazards associated with entry into tanks, vessels, pits, chambers and other confined spaces.',
keyRequirements: [
'Identify and assess confined spaces.',
'Establish an entry procedure.',
'Use a permit system where required.',
'Test the atmosphere before entry.',
'Maintain atmospheric monitoring where necessary.',
'Provide suitable ventilation.',
'Isolate connected energy and services.',
'Provide a suitable rescue plan.',
],
safetyControls: [
'Gas testing',
'Continuous monitoring where required',
'Isolation',
'Lockout/tagout',
'Ventilation',
'Standby attendant',
'Communication',
'Rescue equipment',
'Emergency rescue plan',
],
responsibilities: [
'Supervisors verify entry controls.',
'Authorised entrants follow the procedure.',
'Standby personnel maintain communication.',
'Rescue personnel respond according to the plan.',
'HSE personnel monitor compliance.',
],
references: [
'ADOSH-SF – CoP 27.0: Confined Spaces, Version 4.0',
'ADOSH-SF – CoP 21.0: Permit to Work Systems, Version 4.0',
'Project Confined Space Procedure',
'Project Emergency Rescue Plan',
],
),

ReferenceTopic(
id: 'ad_excavation',
title: 'Excavation & Trenching',
shortTitle: 'Excavation',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'ADPHC / DMT',
jurisdiction: 'Abu Dhabi',
description:
'Guidance for controlling excavation and trenching risks including ground collapse, underground utilities, falls and mobile plant interaction.',
keyRequirements: [
'Obtain required approvals before excavation.',
'Identify underground utilities and services.',
'Assess ground conditions.',
'Provide suitable protective systems.',
'Provide safe access and egress.',
'Control materials and equipment near excavation edges.',
'Inspect excavations regularly.',
'Control water accumulation and unstable conditions.',
],
safetyControls: [
'Excavation permit',
'Utility detection',
'Trial excavation where required',
'Barricading',
'Shoring',
'Sloping',
'Safe access',
'Inspection',
'Exclusion zones',
],
responsibilities: [
'Supervisors verify excavation controls.',
'Workers remain within safe areas.',
'Plant operators follow exclusion zones.',
'HSE personnel inspect and monitor excavation activities.',
],
references: [
'ADOSH-SF – CoP 29.0: Excavation Work, Version 4.1',
'ADOSH-SF – CoP 39.0: Overhead and Underground Services, Version 4.1',
'DMT construction safety requirements',
'Project Excavation Procedure',
],
),

ReferenceTopic(
id: 'ad_electrical_safety',
title: 'Electrical Safety',
shortTitle: 'Electrical Safety',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'ADPHC / ADOSH-SF',
jurisdiction: 'Abu Dhabi',
description:
'Guidance for controlling electrical shock, arc flash, fire, defective equipment and electrical isolation hazards.',
keyRequirements: [
'Electrical work must be performed by competent persons.',
'Identify and isolate electrical energy before work where required.',
'Protect cables and equipment from mechanical damage.',
'Inspect electrical equipment before use.',
'Maintain suitable earthing and protection systems.',
'Keep electrical panels accessible.',
'Control access to electrical installations.',
'Do not use damaged electrical equipment.',
],
safetyControls: [
'Electrical isolation',
'LOTO',
'Inspection and testing',
'Earthing',
'Cable management',
'Residual-current protection where applicable',
'Electrical PPE',
'Restricted access',
],
responsibilities: [
'Management provides competent electrical personnel.',
'Supervisors verify isolation.',
'Workers use electrical equipment correctly.',
'HSE personnel monitor electrical safety.',
],
references: [
'ADOSH-SF – CoP 15.0: Electrical Safety, Version 4.0',
'ADOSH-SF – CoP 24.0: Lock-out Tag-out (Isolation), Version 4.1',
'Applicable Abu Dhabi electrical requirements',
'Company Electrical Safety Procedure',
],
),

ReferenceTopic(
id: 'ad_hot_work',
title: 'Hot Work Safety',
shortTitle: 'Hot Work',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'ADPHC / ADOSH-SF',
jurisdiction: 'Abu Dhabi',
description:
'Guidance for welding, cutting, grinding and other activities that create heat, sparks or flames.',
keyRequirements: [
'Conduct a suitable risk assessment.',
'Use a hot work permit where required.',
'Remove or protect combustible materials.',
'Provide suitable fire extinguishing equipment.',
'Control sparks and hot materials.',
'Conduct gas testing where required.',
'Provide fire watch where required.',
'Inspect the work area after completion.',
],
safetyControls: [
'Hot work permit',
'Fire extinguisher',
'Fire blanket',
'Gas testing',
'Fire watch',
'Spark containment',
'Combustible material control',
'Post-work inspection',
],
responsibilities: [
'Supervisors verify hot work controls.',
'Workers follow permit conditions.',
'Fire watch personnel monitor the area.',
'HSE personnel verify compliance.',
],
references: [
'ADOSH-SF – CoP 28.0: Hot Work Operations, Version 4.1',
'ADOSH-SF – CoP 21.0: Permit to Work Systems, Version 4.0',
'Applicable Abu Dhabi fire safety requirements',
'Company Hot Work Procedure',
],
),

ReferenceTopic(
id: 'ad_traffic_management',
title: 'Construction Traffic Management',
shortTitle: 'Traffic Management',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'ADPHC / DMT',
jurisdiction: 'Abu Dhabi',
description:
'Guidance for controlling vehicle, mobile plant and pedestrian interaction on construction sites and other Abu Dhabi workplaces.',
keyRequirements: [
'Develop a traffic management arrangement appropriate to the site.',
'Separate pedestrians and vehicles where practicable.',
'Define traffic routes and speed controls.',
'Use trained and authorised operators.',
'Inspect vehicles and mobile plant before use.',
'Control reversing operations.',
'Provide suitable signage and lighting.',
'Control interaction between construction plant and workers.',
],
safetyControls: [
'Traffic management plan',
'Pedestrian routes',
'Vehicle exclusion zones',
'Speed limits',
'Banksman',
'Reversing controls',
'Plant inspection',
'Warning signs',
'Lighting',
],
responsibilities: [
'Project management establishes traffic arrangements.',
'Supervisors control site vehicle movements.',
'Drivers follow site traffic rules.',
'Pedestrians use designated routes.',
'HSE personnel monitor traffic controls.',
],
references: [
'ADOSH-SF – CoP 44.0: Traffic Management and Logistics, Version 4.1',
'ADOSH-SF – CoP 33.0: Working On or Adjacent to a Road, Version 4.1',
'Project Traffic Management Plan',
'Applicable authority requirements',
],
),

ReferenceTopic(
id: 'ad_occupational_health',
title: 'Occupational Health',
shortTitle: 'Occupational Health',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'Abu Dhabi Public Health Centre',
jurisdiction: 'Abu Dhabi',
description:
'Guidance for identifying and controlling occupational health risks, including exposure to physical, chemical, biological and ergonomic hazards.',
keyRequirements: [
'Identify occupational health hazards.',
'Assess worker exposure risks.',
'Implement suitable engineering and administrative controls.',
'Provide appropriate occupational health surveillance where required.',
'Maintain relevant health and exposure records in accordance with applicable requirements.',
'Provide worker health information and awareness.',
'Review occupational health risks when work conditions change.',
],
safetyControls: [
'Exposure assessment',
'Health surveillance where required',
'Industrial hygiene',
'Engineering controls',
'Ventilation',
'PPE',
'Ergonomic controls',
'Health awareness',
],
responsibilities: [
'Management provides occupational health resources.',
'Supervisors implement exposure controls.',
'Workers report relevant symptoms and exposures.',
'HSE and occupational health professionals provide specialist support.',
],
references: [
'ADOSH-SF – CoP 5.0: Occupational Health Screening and Medical Surveillance, Version 4.0',
'ADOSH-SF – applicable occupational health requirements',
'Abu Dhabi Public Health Centre',
'Company Occupational Health Programme',
],
),

ReferenceTopic(
id: 'ad_heat_stress',
title: 'Heat Stress Management',
shortTitle: 'Heat Stress',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'ADPHC / MoHRE',
jurisdiction: 'Abu Dhabi',
description:
'Guidance for controlling heat stress risks for workers exposed to high temperatures, humidity, radiant heat and physically demanding work.',
keyRequirements: [
'Identify workers exposed to heat stress.',
'Provide adequate drinking water.',
'Provide shaded or cooled rest arrangements as appropriate.',
'Provide heat-stress awareness and training.',
'Plan work to reduce heat exposure.',
'Monitor workers for signs of heat-related illness.',
'Provide first aid and emergency response arrangements.',
'Follow applicable UAE and Abu Dhabi requirements for outdoor work during the summer period.',
],
safetyControls: [
'Drinking water',
'Shaded rest areas',
'Cooling arrangements',
'Work-rest arrangements',
'Heat monitoring',
'Acclimatisation',
'Suitable PPE and clothing',
'Emergency response',
],
responsibilities: [
'Management implements heat-stress controls.',
'Supervisors monitor workers and site conditions.',
'Workers maintain hydration and report symptoms.',
'HSE personnel monitor programme implementation.',
],
references: [
'ADOSH-SF – CoP 11.0: Safety in the Heat, Version 4.0',
'MoHRE – Occupational Heat Stress Prevention requirements',
'Applicable Abu Dhabi occupational health requirements',
'Company Heat Stress Management Plan',
],
),

ReferenceTopic(
id: 'ad_ppe',
title: 'Personal Protective Equipment',
shortTitle: 'PPE',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'ADPHC / ADOSH-SF',
jurisdiction: 'Abu Dhabi',
description:
'Guidance for selecting, providing, using and maintaining personal protective equipment based on workplace risks in Abu Dhabi.',
keyRequirements: [
'Select PPE based on risk assessment.',
'Provide suitable PPE for identified hazards.',
'Ensure correct fit and compatibility.',
'Train workers in correct PPE use.',
'Inspect PPE before use.',
'Replace damaged or defective PPE.',
'Maintain and store PPE appropriately.',
'Use PPE as part of a broader hierarchy of controls.',
],
safetyControls: [
'Risk assessment',
'PPE selection',
'Worker training',
'Fit checks',
'Inspection',
'Maintenance',
'Replacement',
'Compliance monitoring',
],
responsibilities: [
'Management provides suitable PPE.',
'Supervisors enforce PPE requirements.',
'Workers correctly use and maintain PPE.',
'HSE personnel monitor PPE compliance.',
],
references: [
'ADOSH-SF – CoP 2.0: Personal Protective Equipment, Version 4.0',
'Applicable PPE standards',
'Company PPE Procedure',
'Project risk assessments',
],
),

ReferenceTopic(
id: 'ad_environmental_waste',
title: 'Environmental & Waste Management',
shortTitle: 'Environmental Management',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'Applicable Abu Dhabi Authorities',
jurisdiction: 'Abu Dhabi',
description:
'General guidance for managing environmental aspects and waste associated with workplace and construction activities in Abu Dhabi.',
keyRequirements: [
'Identify environmental aspects associated with activities.',
'Control waste generation and disposal.',
'Segregate waste where required.',
'Prevent uncontrolled discharge and pollution.',
'Store hazardous materials and waste appropriately.',
'Use authorised disposal arrangements where required.',
'Control dust, noise and other environmental impacts.',
'Maintain required environmental records.',
],
safetyControls: [
'Environmental management plan',
'Waste segregation',
'Waste storage',
'Spill prevention',
'Dust control',
'Noise control',
'Pollution prevention',
'Approved waste disposal',
],
responsibilities: [
'Management provides environmental controls and resources.',
'Supervisors implement site controls.',
'Workers follow waste and environmental procedures.',
'HSE/environment personnel monitor compliance.',
],
references: [
'ADOSH-SF – CoP 54.0: Waste Management, Version 4.0',
'Project Environmental Management Plan',
'Applicable Abu Dhabi environmental requirements',
'Applicable waste management requirements',
],
),

ReferenceTopic(
id: 'ad_inspection_audit',
title: 'HSE Inspection & Audit',
shortTitle: 'Inspection & Audit',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'ADPHC / ADOSH-SF',
jurisdiction: 'Abu Dhabi',
description:
'Guidance for monitoring workplace compliance through inspections, audits, observations and corrective action management.',
keyRequirements: [
'Establish an inspection and audit programme.',
'Conduct inspections based on workplace risk.',
'Record significant findings.',
'Assign corrective actions to responsible persons.',
'Set appropriate completion targets.',
'Verify corrective action effectiveness.',
'Use trends and findings to improve HSE performance.',
],
safetyControls: [
'Planned inspections',
'HSE audits',
'Safety observations',
'Corrective action register',
'Trend analysis',
'Management review',
'Verification inspections',
],
responsibilities: [
'Management reviews significant findings and performance.',
'Supervisors close workplace deficiencies.',
'HSE personnel conduct or coordinate inspections and audits.',
'Workers participate in reporting unsafe conditions.',
],
references: [
'ADOSH-SF – Technical Guideline 1.0: Audit and Inspection, Version 4.0',
'ADOSH-SF – OSH Management System requirements',
'Project HSE Inspection Programme',
'Company Audit Procedure',
],
),

ReferenceTopic(
id: 'ad_performance_monitoring',
title: 'OSH Performance Monitoring',
shortTitle: 'Performance Monitoring',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'ADPHC / ADOSH-SF',
jurisdiction: 'Abu Dhabi',
description:
'Guidance for monitoring occupational safety and health performance through indicators, reports, inspections, audits and corrective actions.',
keyRequirements: [
'Establish relevant leading and lagging indicators.',
'Monitor incidents and injury trends.',
'Monitor inspection and audit performance.',
'Track corrective action closure.',
'Monitor training and competency performance.',
'Review performance against objectives.',
'Use performance information for continual improvement.',
],
safetyControls: [
'HSE KPIs',
'Leading indicators',
'Lagging indicators',
'Inspection statistics',
'Incident trends',
'Training metrics',
'Corrective action tracking',
'Management review',
],
responsibilities: [
'Management reviews HSE performance.',
'HSE personnel collect and analyse performance information.',
'Supervisors provide accurate operational data.',
'Workers contribute through observations and reporting.',
],
references: [
'ADOSH-SF – OSH Management System requirements',
'ADOSH-SF – Mechanisms for performance reporting',
'Applicable electronic performance reporting requirements',
'Project HSE KPI system',
],
),

ReferenceTopic(
id: 'ad_electronic_reporting',
title: 'Electronic OSH Reporting',
shortTitle: 'Electronic Reporting',
category: 'Abu Dhabi',
guidelineCategory: GuidelineCategory.abuDhabi,
authority: 'ADPHC / ADOSH-SF',
jurisdiction: 'Abu Dhabi',
description:
'Overview of electronic occupational safety and health reporting and submission requirements applicable to entities where prescribed by the Abu Dhabi regulatory system.',
keyRequirements: [
'Use the prescribed electronic system where applicable.',
'Submit required incident information and forms.',
'Maintain accurate and complete information.',
'Meet applicable reporting requirements and timeframes.',
'Maintain supporting records.',
'Ensure responsible personnel understand submission procedures.',
],
safetyControls: [
'Electronic reporting',
'Incident records',
'Mandatory forms',
'Document control',
'Submission tracking',
'Management review',
],
responsibilities: [
'Management ensures regulatory submissions are controlled.',
'HSE personnel coordinate required reporting.',
'Responsible personnel provide accurate information.',
'Supervisors support timely incident information collection.',
],
references: [
'ADOSH-SF – Mechanisms, Version 4.0',
'ADOSH-SF – applicable OSH incident and performance reporting requirements',
'ADPHC electronic OSH reporting requirements',
'Project reporting procedure',
],
),
];


/// ============================================================================
/// ABU DHABI COMPLETE HSE LEARNING PAGE
///
/// One canonical file contains the complete learning content for all 24
/// Abu Dhabi topics defined above. Existing ReferenceTopic records are kept.
/// This page adds a tap-to-expand learning experience without duplicating the
/// 24 topic definitions in another file.
///
/// Official-source basis for the Abu Dhabi regulatory context:
/// - Abu Dhabi DMT / Abu Dhabi City Municipality EHS pages
/// - Abu Dhabi OSHAD SF information
/// - Applicable OSHAD Codes of Practice, circulars and authority requirements
/// - Project-specific approvals, HSE plans and current competent-authority
///   requirements
///
/// Always verify the current official requirement before using this as a
/// compliance decision.
/// ============================================================================

class AbuDhabiCompleteTopicPage extends StatelessWidget {
  final ReferenceTopic topic;

  const AbuDhabiCompleteTopicPage({
    super.key,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    final sections = _abuDhabiDetailedContent[topic.id] ?? const <_AbuDhabiSection>[];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B5D3B),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          topic.shortTitle.trim().isEmpty ? topic.title : topic.shortTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 30),
          children: [
            ...sections.map(
              (section) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _AbuDhabiSectionTile(section: section),
              ),
            ),
            const SizedBox(height: 8),
            _AbuDhabiSourceCard(topic: topic),
          ],
        ),
      ),
    );
  }
}

class _AbuDhabiSection {
  final String title;
  final IconData icon;
  final List<String> items;

  const _AbuDhabiSection({
    required this.title,
    required this.icon,
    required this.items,
  });
}

class _AbuDhabiSectionTile extends StatelessWidget {
  final _AbuDhabiSection section;

  const _AbuDhabiSectionTile({required this.section});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: const Color(0xFFE8F5EE),
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
          childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
          leading: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5EE),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              section.icon,
              color: const Color(0xFF0B5D3B),
              size: 21,
            ),
          ),
          title: Text(
            section.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111827),
            ),
          ),
          subtitle: Text(
            '${section.items.length} detailed learning points',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF6B7280),
            ),
          ),
          children: List.generate(
            section.items.length,
            (index) => _AbuDhabiItemTile(
              number: index + 1,
              text: section.items[index],
            ),
          ),
        ),
      ),
    );
  }
}

class _AbuDhabiItemTile extends StatelessWidget {
  final int number;
  final String text;

  const _AbuDhabiItemTile({
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final words = text.split(RegExp(r'\s+'));
    final title = words.length > 8
        ? '${words.take(8).join(' ')}…'
        : text;

    return Card(
      elevation: 0,
      color: const Color(0xFFF8FAFC),
      margin: const EdgeInsets.only(bottom: 7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 11, vertical: 1),
        childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 13),
        leading: CircleAvatar(
          radius: 15,
          backgroundColor: const Color(0xFFE8F5EE),
          child: Text(
            '$number',
            style: const TextStyle(
              color: Color(0xFF0B5D3B),
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13.5,
            height: 1.3,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2937),
          ),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.55,
                color: Color(0xFF374151),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AbuDhabiSourceCard extends StatelessWidget {
  final ReferenceTopic topic;

  const _AbuDhabiSourceCard({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ExpansionTile(
        leading: const Icon(
          Icons.verified_outlined,
          color: Color(0xFF0B5D3B),
        ),
        title: const Text(
          'Official Reference & Verification',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          Text(
            'Current official requirements should be verified through the Abu Dhabi Department of Municipalities and Transport / Abu Dhabi City Municipality EHS resources, the Abu Dhabi Public Health Centre and the applicable authority or project approval.',
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.5,
              color: Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 10),
          ...topic.references.map(
            (ref) => Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '• ',
                    style: TextStyle(
                      color: Color(0xFF0B5D3B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      ref,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.45,
                        color: Color(0xFF4B5563),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const Map<String, List<_AbuDhabiSection>> _abuDhabiDetailedContent = {
  'ad_oshad_sf': [
    _AbuDhabiSection(
      title: 'Framework & Governance',
      icon: Icons.account_balance_outlined,
      items: [
        'Understand the Abu Dhabi Occupational Safety & Health System Framework (OSHAD SF) as the overarching framework for occupational safety and health management in the Emirate.',
        'Identify the competent authority, sector regulatory authority and applicable sub-sector authority for the organisation and project.',
        'For building and construction, verify the current requirements issued by the Department of Municipalities and Transport and the applicable municipality/authority.',
        'Determine the organisation\'s risk classification and the corresponding OSH management, assurance and reporting obligations.',
        'Maintain controlled access to the current official framework, applicable Codes of Practice, circulars and authority requirements.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Entity & Project Compliance',
      icon: Icons.check_circle_outline,
      items: [
        'Confirm that the company, project and relevant activities have the required registrations, approvals and HSE arrangements before work starts.',
        'Identify project-specific authority conditions, permits, NOCs, approvals and inspection requirements.',
        'Map each project activity to applicable OSHAD requirements and project controls.',
        'Ensure consultants, contractors and subcontractors understand the compliance obligations that apply to their scope.',
        'Review requirements whenever scope, risk profile, organisation, authority requirements or site conditions change.',
      ],
    ),
    _AbuDhabiSection(
      title: 'OSH Management Elements',
      icon: Icons.check_circle_outline,
      items: [
        'Establish leadership, policy, objectives, roles, consultation and worker participation.',
        'Use risk management to identify hazards, assess risks, select controls and verify effectiveness.',
        'Control operational activities through procedures, RAMS, permits, inspections and supervision.',
        'Provide occupational health, emergency preparedness, incident management, training and competency arrangements.',
        'Measure performance, investigate failures, complete corrective actions and drive continual improvement.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Assurance & Verification',
      icon: Icons.check_circle_outline,
      items: [
        'Use planned inspections, audits, observations and management reviews to verify implementation.',
        'Track legal and OSH obligations against objective evidence rather than statements of compliance alone.',
        'Trend incidents, high-potential events, inspection findings, training, corrective actions and other relevant indicators.',
        'Escalate significant non-compliance and verify close-out effectiveness.',
        'Keep records controlled, retrievable and protected from unauthorised alteration.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Treat the framework as a management system rather than a collection of safety rules.',
        'Build a traceability chain: requirement → risk → control → responsible person → evidence → verification → review.',
        'Use risk classification to determine the depth of governance, assurance and resources required.',
        'Link site-level controls to management-level objectives so that field observations can trigger system improvement.',
        'Review official authority sources before relying on a requirement because circulars, guides and project conditions can change.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_oshms': [
    _AbuDhabiSection(
      title: 'System Architecture',
      icon: Icons.policy_outlined,
      items: [
        'Define the OSHMS scope, boundaries, sites, activities, workforce and interfaces covered by the system.',
        'Establish a documented OSH policy supported by leadership, resources, consultation and measurable objectives.',
        'Define responsibilities, authorities, competence and reporting lines from senior management to work crews.',
        'Integrate OSH into project planning, procurement, design review, construction planning and operational control.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Planning & Risk Control',
      icon: Icons.check_circle_outline,
      items: [
        'Maintain a systematic hazard identification and risk assessment process for routine and non-routine work.',
        'Define legal and other requirements and convert them into operational controls.',
        'Set objectives and programmes with owners, measures, target dates and verification methods.',
        'Manage change so that new activities, equipment, materials, personnel and interfaces are risk assessed before implementation.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Operational Control',
      icon: Icons.check_circle_outline,
      items: [
        'Control high-risk activities through approved RAMS, permits, competency verification, supervision and inspection.',
        'Ensure emergency arrangements are available, communicated, tested and periodically reviewed.',
        'Control contractors and suppliers through defined HSE requirements and performance monitoring.',
        'Maintain occupational health arrangements for identified exposures and worker welfare needs.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Assurance & Improvement',
      icon: Icons.check_circle_outline,
      items: [
        'Use inspections, audits, incident investigations, leading indicators and worker feedback to evaluate performance.',
        'Track corrective and preventive actions to verified closure.',
        'Conduct management review of performance, significant risks, resources, trends and improvement needs.',
        'Use lessons learned to update procedures, training, risk assessments and field controls.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Use Plan–Do–Check–Act thinking to keep the OSHMS active and evidence based.',
        'Distinguish system failures from individual mistakes during assurance and investigations.',
        'Measure whether controls work in the field, not merely whether documents exist.',
        'Use assurance findings to prioritise resources toward critical risks and recurring weaknesses.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_risk_management': [
    _AbuDhabiSection(
      title: 'Risk Management Process',
      icon: Icons.manage_search_outlined,
      items: [
        'Define the work activity and boundaries before identifying hazards.',
        'Identify hazards from task steps, plant, materials, energy sources, environment, human factors and interfaces.',
        'Assess likelihood and consequence using the approved project risk methodology.',
        'Record existing controls, calculate residual risk and determine whether additional controls are required.',
        'Communicate significant risks to the people who perform and supervise the work.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Hierarchy of Controls',
      icon: Icons.check_circle_outline,
      items: [
        'Eliminate the hazard where reasonably practicable before relying on personal protective equipment.',
        'Use substitution, engineering controls and physical separation to reduce exposure.',
        'Use administrative controls such as procedures, scheduling, training and supervision as supporting measures.',
        'Use PPE as the final layer where residual exposure remains.',
        'Verify that controls are available, suitable, maintained and actually used.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Dynamic & Task Risk Assessment',
      icon: Icons.check_circle_outline,
      items: [
        'Reassess risk when site conditions, weather, sequence, personnel, equipment or interfaces change.',
        'Use pre-task briefings and point-of-work assessments for changing field conditions.',
        'Stop and reassess when the planned method cannot be followed safely.',
        'Escalate high or uncontrolled residual risk to competent management before work continues.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Critical Risk Review',
      icon: Icons.check_circle_outline,
      items: [
        'Give particular attention to falls, lifting, excavation, electrical energy, confined spaces, mobile plant, traffic and fire/hot work.',
        'Define critical controls for high-risk activities and verify them before exposure occurs.',
        'Use field verification to confirm barriers are present and effective.',
        'Capture lessons from incidents, near misses and observations in future risk assessments.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Separate inherent risk from residual risk and never allow paperwork to substitute for physical control.',
        'Use the hierarchy of controls to challenge risk assessments that rely heavily on warnings and PPE.',
        'Treat change and interface risk as major sources of unexpected exposure.',
        'Use critical-control verification for hazards where a single failed barrier can produce a fatal outcome.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_hse_plan': [
    _AbuDhabiSection(
      title: 'Plan Structure',
      icon: Icons.description_outlined,
      items: [
        'Define project scope, site conditions, construction phases, organisation, responsibilities and applicable authority requirements.',
        'Include risk management, legal compliance, emergency preparedness, occupational health, welfare and environmental controls.',
        'Define inspection, audit, reporting, incident management and performance monitoring arrangements.',
        'Set document control, review, approval and change-management requirements.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Pre-Construction Controls',
      icon: Icons.check_circle_outline,
      items: [
        'Review design hazards, temporary works, logistics, access, utilities, interfaces and construction sequencing.',
        'Confirm required permits, authority approvals, NOCs and site arrangements before mobilisation.',
        'Establish welfare, first aid, emergency access, fire protection, traffic routes and communication arrangements.',
        'Assess contractor and subcontractor HSE arrangements before allowing work to start.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Construction Phase Controls',
      icon: Icons.check_circle_outline,
      items: [
        'Translate the plan into activity-specific RAMS, permits, inspections and supervision.',
        'Coordinate simultaneous activities to prevent conflicting work and uncontrolled interfaces.',
        'Maintain housekeeping, access, edge protection, lifting controls, excavation controls and plant segregation.',
        'Monitor high-risk activities and update controls when methods or conditions change.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Emergency & Occupational Health',
      icon: Icons.check_circle_outline,
      items: [
        'Provide emergency plans for fire, medical events, rescue, spill, utility strike and other credible scenarios.',
        'Identify occupational exposures such as heat, dust, noise, vibration, chemicals and ergonomic strain.',
        'Provide welfare facilities, potable water, sanitation, rest areas and suitable worker support.',
        'Conduct drills and verify emergency arrangements are usable at the work location.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Use the HSE plan as the project\'s control architecture, not as a static submission document.',
        'Link every major section to a field verification mechanism such as an inspection, permit, checklist or KPI.',
        'Review the plan at mobilisation, major phase changes, significant incidents and material changes in risk.',
        'Keep authority conditions and project commitments traceable to specific controls and evidence.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_roles_responsibilities': [
    _AbuDhabiSection(
      title: 'Leadership',
      icon: Icons.groups_outlined,
      items: [
        'Senior management provides resources, authority and visible leadership for OSH performance.',
        'Project management integrates safety into planning, programme, procurement and production decisions.',
        'Managers ensure unsafe conditions are corrected and significant issues are escalated.',
      ],
    ),
    _AbuDhabiSection(
      title: 'HSE Function',
      icon: Icons.check_circle_outline,
      items: [
        'HSE personnel advise management, monitor compliance, conduct inspections and audits and support investigations.',
        'HSE staff verify critical controls and challenge ineffective or incomplete arrangements.',
        'HSE findings should be communicated clearly with owners, priorities and due dates.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Supervision & Workforce',
      icon: Icons.check_circle_outline,
      items: [
        'Supervisors control daily work, brief teams, verify permits and stop work when conditions are unsafe.',
        'Workers follow approved procedures, use controls correctly and report hazards, incidents and changes.',
        'Workers should be given a practical opportunity to raise safety concerns without bypassing the site communication process.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Contractor Interfaces',
      icon: Icons.check_circle_outline,
      items: [
        'Define responsibilities between client, consultant, principal contractor and subcontractors.',
        'Prevent gaps caused by assumptions that another party owns a control.',
        'Use interface meetings and RAMS reviews for simultaneous or shared activities.',
        'Verify contractor performance rather than relying only on contractual wording.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Assign responsibility for the control, not merely responsibility for producing the document.',
        'Use RACI-style mapping for critical controls and interfaces.',
        'Escalation routes should be clear before an incident or serious non-compliance occurs.',
        'Leadership effectiveness is demonstrated through decisions, resources and follow-up, not slogans alone.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_incident_reporting': [
    _AbuDhabiSection(
      title: 'Immediate Response',
      icon: Icons.report_problem_outlined,
      items: [
        'Protect life first, provide emergency assistance and control the scene.',
        'Stop or isolate the affected activity where necessary to prevent further harm.',
        'Preserve relevant evidence without unnecessarily disturbing the scene.',
        'Notify the responsible management and authority channels according to applicable requirements.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Reporting & Classification',
      icon: Icons.check_circle_outline,
      items: [
        'Record factual information including time, location, activity, people involved, equipment and immediate conditions.',
        'Classify the event according to the project and applicable authority reporting system.',
        'Capture near misses and high-potential events so learning is not limited to injuries.',
        'Submit mandatory reports through the applicable Abu Dhabi reporting mechanism when required.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Investigation',
      icon: Icons.check_circle_outline,
      items: [
        'Build the timeline from evidence, interviews, records and physical conditions.',
        'Identify immediate, underlying and organisational causes rather than stopping at worker error.',
        'Examine failed barriers, supervision, planning, competence, equipment and management systems.',
        'Protect confidentiality and treat witnesses fairly while maintaining factual integrity.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Corrective Action',
      icon: Icons.check_circle_outline,
      items: [
        'Define corrective actions that address the failed control or system weakness.',
        'Assign an owner, due date, priority and verification method.',
        'Verify effectiveness at the work location and revise RAMS, training or procedures where necessary.',
        'Share lessons learned across similar work areas and contractors.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'High-potential near misses can reveal weak barriers before a serious injury occurs.',
        'Evidence preservation is important because assumptions made immediately after an event can distort the investigation.',
        'Use root-cause methods proportionate to event significance and complexity.',
        'Close-out should prove risk reduction, not simply completion of an action field.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_training_competency': [
    _AbuDhabiSection(
      title: 'Training Needs',
      icon: Icons.school_outlined,
      items: [
        'Identify competence requirements from job roles, risk assessments, legal obligations and equipment requirements.',
        'Separate awareness, knowledge, practical skill, supervision and formal authorisation requirements.',
        'Identify safety-critical roles that require evidence of qualification or competency.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Induction & Communication',
      icon: Icons.check_circle_outline,
      items: [
        'Provide site induction before exposure to site hazards.',
        'Cover emergency arrangements, prohibited practices, PPE, welfare, traffic, reporting and key project risks.',
        'Deliver information in a language and form workers can understand.',
        'Use task briefings and toolbox talks for changes and specific hazards.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Practical Competence',
      icon: Icons.check_circle_outline,
      items: [
        'Use practical demonstrations or assessments for equipment operation and safety-critical tasks.',
        'Verify certificates, licences and authorisations where applicable.',
        'Use supervised familiarisation for new equipment, methods and work environments.',
        'Reassess competence after significant incidents, long absence, unsafe performance or major process change.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Training Assurance',
      icon: Icons.check_circle_outline,
      items: [
        'Maintain a training matrix showing required, completed, expired and upcoming competence.',
        'Audit the quality of training rather than counting attendance only.',
        'Observe workers performing tasks to confirm transfer of learning.',
        'Track refresher and expiry dates for time-limited qualifications.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Competence is the ability to perform safely in the real work environment, not merely possession of a certificate.',
        'Training should reflect the actual hazards and equipment used on the project.',
        'Use incident and observation trends to update training needs.',
        'Supervisors should receive training appropriate to the risks they control and the decisions they make.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_contractor_management': [
    _AbuDhabiSection(
      title: 'Prequalification',
      icon: Icons.handshake_outlined,
      items: [
        'Assess contractor HSE capability, experience, resources, competence and relevant performance history.',
        'Review HSE policies, management systems, key personnel and evidence relevant to the proposed scope.',
        'Confirm ability to meet project and authority requirements before award or mobilisation.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Mobilisation',
      icon: Icons.check_circle_outline,
      items: [
        'Complete induction, site rules, welfare, emergency, traffic and reporting arrangements before work begins.',
        'Review contractor RAMS and verify critical controls at the work front.',
        'Define supervision ratios, communication routes and interface responsibilities.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Performance Control',
      icon: Icons.check_circle_outline,
      items: [
        'Monitor contractor inspections, training, incidents, observations, permits and corrective actions.',
        'Use planned audits and field verification to test actual performance.',
        'Escalate repeated or serious non-compliance through the project contract and HSE governance process.',
        'Prevent subcontractor tiers from bypassing the main contractor\'s HSE control system.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Change & Interface',
      icon: Icons.check_circle_outline,
      items: [
        'Reassess risks when contractors change methods, resources, plant or subcontractors.',
        'Coordinate simultaneous activities and shared workspaces.',
        'Ensure temporary works, lifting, excavation, traffic and utilities are controlled across interfaces.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Contractor management is a lifecycle process: prequalification → mobilisation → execution → assurance → close-out.',
        'Paper compliance can hide field weaknesses; use observation and verification.',
        'Require evidence for critical controls and competence rather than generic declarations.',
        'Learn from contractor incidents and recurring findings across the whole project.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_emergency_management': [
    _AbuDhabiSection(
      title: 'Emergency Planning',
      icon: Icons.emergency_outlined,
      items: [
        'Identify credible emergency scenarios from site hazards, location, project phase and surrounding environment.',
        'Define command, communication, alarm, evacuation, assembly and accountability arrangements.',
        'Provide emergency contact information and ensure routes are accessible and maintained.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Fire & Medical',
      icon: Icons.check_circle_outline,
      items: [
        'Provide suitable fire prevention, detection, extinguishing and emergency access arrangements.',
        'Provide first aid resources, trained personnel and clear arrangements for emergency medical response.',
        'Coordinate with external emergency services and identify access/egress constraints.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Rescue Scenarios',
      icon: Icons.check_circle_outline,
      items: [
        'Plan rescue for work at height, confined spaces, excavation collapse, electrical incidents and other credible events.',
        'Do not rely on improvised rescue; provide suitable equipment, competent rescuers and defined methods.',
        'Control secondary hazards before rescuers enter the affected area.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Drills & Readiness',
      icon: Icons.check_circle_outline,
      items: [
        'Conduct drills appropriate to project risk and phase.',
        'Record response times, communication failures, accountability issues and equipment gaps.',
        'Update emergency plans and training from drill and incident lessons.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Emergency planning should consider the first few minutes before external responders arrive.',
        'Accountability must work for visitors, subcontractors and changing workforce numbers.',
        'Rescue plans should be designed before high-risk work starts, not after an incident.',
        'Emergency controls must remain usable during power loss, smoke, congestion, weather or other degraded conditions.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_work_at_height': [
    _AbuDhabiSection(
      title: 'Fall Prevention',
      icon: Icons.height_outlined,
      items: [
        'Plan work to eliminate work at height where reasonably practicable.',
        'Prefer collective protection such as guardrails, barriers and safe platforms before personal fall arrest.',
        'Identify fragile surfaces, openings, edges and falling-object risks.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Access & Platforms',
      icon: Icons.check_circle_outline,
      items: [
        'Use suitable, inspected access systems such as compliant scaffolds, ladders or MEWPs for the task.',
        'Provide safe access and egress and prevent unauthorised alteration of temporary platforms.',
        'Maintain clear working platforms and prevent materials from creating trip or edge hazards.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Fall Arrest & Rescue',
      icon: Icons.check_circle_outline,
      items: [
        'Where fall arrest is required, select compatible equipment and suitable anchorage.',
        'Control swing-fall, clearance and sharp-edge risks.',
        'Provide a practical rescue plan and do not rely on emergency services as the sole rescue arrangement.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Dropped Objects',
      icon: Icons.check_circle_outline,
      items: [
        'Secure tools and materials and control work below elevated activities.',
        'Use toe boards, debris containment, exclusion zones and controlled lifting of materials as appropriate.',
        'Prevent unauthorised access beneath overhead work.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Use the hierarchy: avoid height → prevent the fall → minimise fall consequences.',
        'Inspect the complete system, not just the worker\'s harness.',
        'Consider rescue time, suspension intolerance and anchor suitability when selecting fall-arrest systems.',
        'Temporary edge protection should be treated as a critical control and verified after changes.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_scaffolding': [
    _AbuDhabiSection(
      title: 'Design & Selection',
      icon: Icons.construction_outlined,
      items: [
        'Select scaffold type and configuration suitable for the load, height, geometry and environment.',
        'Use competent persons for erection, alteration and inspection.',
        'Consider ground conditions, ties, stability, access, loading and adjacent hazards.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Erection & Dismantling',
      icon: Icons.check_circle_outline,
      items: [
        'Control the erection zone and prevent unauthorised access.',
        'Follow the approved erection sequence and maintain stability as the scaffold rises.',
        'Use safe access and fall protection appropriate to the erection method.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Inspection & Tagging',
      icon: Icons.check_circle_outline,
      items: [
        'Inspect scaffolds before first use and after events or changes that could affect stability.',
        'Use a clear status system consistent with the project procedure.',
        'Do not allow workers to use incomplete, damaged or altered scaffolds.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Safe Use',
      icon: Icons.check_circle_outline,
      items: [
        'Maintain guardrails, midrails, toe boards, platforms and safe access.',
        'Control loading and prevent overloading with materials or equipment.',
        'Prevent unauthorised removal of ties, braces, boards or edge protection.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Scaffold safety depends on structural stability plus user discipline and inspection.',
        'Treat modifications by unapproved persons as a high-risk interface.',
        'Consider wind, suspended loads, sheeting and nearby plant as stability factors.',
        'Inspection records should identify the actual scaffold/location and any restrictions.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_lifting_operations': [
    _AbuDhabiSection(
      title: 'Lift Planning',
      icon: Icons.precision_manufacturing_outlined,
      items: [
        'Assess the load, centre of gravity, lifting points, travel path, landing area and surrounding hazards.',
        'Select suitable crane/hoist capacity and lifting accessories with adequate capacity and condition.',
        'Prepare a lift plan appropriate to the complexity and risk of the lift.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Competence & Equipment',
      icon: Icons.check_circle_outline,
      items: [
        'Use competent authorised operators, riggers, signalers and supervisors.',
        'Verify inspection and certification requirements for lifting equipment and accessories.',
        'Remove damaged or uncertified lifting gear from service.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Exclusion & Communication',
      icon: Icons.check_circle_outline,
      items: [
        'Establish exclusion zones and prevent people from standing under suspended loads.',
        'Use agreed signals or communication systems and ensure visibility.',
        'Control interface with traffic, structures, power lines and other simultaneous activities.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Environmental Conditions',
      icon: Icons.check_circle_outline,
      items: [
        'Consider wind, visibility, lighting, ground bearing capacity and weather.',
        'Define limits for lifting and stop when conditions exceed the approved limits.',
        'Reassess lifts after site or equipment changes.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Most lifting failures involve a chain of failed controls rather than one isolated error.',
        'Verify ground conditions and lifting accessories as carefully as crane capacity.',
        'Control suspended-load energy by keeping people out of the fall zone.',
        'Complex lifts require stronger planning, competent supervision and documented hold points.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_confined_space': [
    _AbuDhabiSection(
      title: 'Identification & Assessment',
      icon: Icons.air_outlined,
      items: [
        'Identify spaces with limited entry/exit or potential atmospheric, engulfment or other serious hazards.',
        'Determine whether the space meets the project\'s confined-space criteria before entry.',
        'Assess atmospheric, mechanical, electrical, chemical, biological and physical hazards.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Permit & Isolation',
      icon: Icons.check_circle_outline,
      items: [
        'Use a controlled entry permit where required by the project procedure.',
        'Isolate and lock out energy, flow, mechanical movement and other sources before entry.',
        'Verify isolation rather than relying on labels or verbal confirmation.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Atmospheric Controls',
      icon: Icons.check_circle_outline,
      items: [
        'Test oxygen, flammable atmosphere and relevant toxic contaminants before entry and as required during the task.',
        'Use calibrated instruments and competent gas testers.',
        'Provide ventilation without creating new hazards and define alarm/action limits.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Standby & Rescue',
      icon: Icons.check_circle_outline,
      items: [
        'Provide a competent attendant where required and maintain reliable communication.',
        'Prepare a rescue plan with suitable equipment and trained rescuers.',
        'Never send an unprotected worker into a confined space to rescue another person.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Confined-space risk can change rapidly due to process, weather, ventilation or nearby work.',
        'Entry controls are a system: isolation + atmosphere + permit + attendant + communication + rescue.',
        'Continuous monitoring may be necessary where conditions can change.',
        'Rescue planning should match the space geometry and casualty extraction route.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_excavation': [
    _AbuDhabiSection(
      title: 'Planning & Survey',
      icon: Icons.landscape_outlined,
      items: [
        'Confirm excavation scope, soil conditions, depth, nearby structures and access.',
        'Identify underground services and verify their location before excavation.',
        'Define competent-person inspections and controls for the excavation method.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Ground Stability',
      icon: Icons.check_circle_outline,
      items: [
        'Use a suitable protective system such as safe battering, benching, shoring or shielding as required by the design and conditions.',
        'Control water ingress, vibration, adjacent loads and spoil placement.',
        'Prevent undermining of structures and keep plant away from unsupported edges.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Access & Egress',
      icon: Icons.check_circle_outline,
      items: [
        'Provide safe access and egress appropriate to excavation depth and configuration.',
        'Keep access routes clear and maintain them after weather or work changes.',
        'Prevent falls into excavations with barriers and controlled access.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Daily & Change Inspection',
      icon: Icons.check_circle_outline,
      items: [
        'Inspect after rain, water ingress, vibration, collapse signs, service strikes or other changes.',
        'Look for cracking, sloughing, bulging, tension cracks and changes in ground condition.',
        'Stop work and reassess if stability cannot be assured.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Excavation failures can occur with little warning; protective systems should not depend on visual optimism.',
        'Loads near the edge can increase collapse risk even when the excavation appears stable.',
        'Underground services require a positive identification and controlled excavation approach.',
        'Water is both a stability hazard and an emergency escalation trigger.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_electrical_safety': [
    _AbuDhabiSection(
      title: 'Electrical Risk Assessment',
      icon: Icons.electrical_services_outlined,
      items: [
        'Identify sources, voltage, temporary supplies, portable tools, generators, overhead and underground services.',
        'Determine shock, arc-flash, fire, stored-energy and secondary hazards.',
        'Use competent persons for electrical work and supervision appropriate to the system.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Isolation & LOTO',
      icon: Icons.check_circle_outline,
      items: [
        'Isolate electrical energy before work where practicable.',
        'Apply lockout/tagout or an equivalent controlled isolation procedure.',
        'Test for dead using suitable equipment and verify the isolation before touching conductors.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Temporary Electrical Systems',
      icon: Icons.check_circle_outline,
      items: [
        'Protect distribution boards, cables, outlets and generators from damage and environmental exposure.',
        'Use suitable protection devices and earthing arrangements.',
        'Inspect temporary systems and remove damaged leads, plugs or tools from service.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Work Near Services',
      icon: Icons.check_circle_outline,
      items: [
        'Identify and protect overhead and underground electrical services before excavation or lifting.',
        'Maintain required clearances and use controlled methods where work is near energised systems.',
        'Coordinate electrical isolation with the responsible authority or competent electrical person.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Electrical safety is about energy control, not only PPE.',
        'Verification of isolation is critical because labels and switches can be wrong or incomplete.',
        'Temporary installations deserve the same engineering discipline as permanent systems.',
        'Arc-flash and stored-energy hazards require task-specific assessment beyond simple shock protection.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_hot_work': [
    _AbuDhabiSection(
      title: 'Hot Work Assessment',
      icon: Icons.local_fire_department_outlined,
      items: [
        'Identify welding, cutting, grinding, brazing and other ignition-producing work.',
        'Assess combustible materials, gases, vapours, dust, adjacent spaces and hidden fire paths.',
        'Use a permit-to-work system where required by the project.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Preparation',
      icon: Icons.check_circle_outline,
      items: [
        'Remove or protect combustibles and provide suitable fire extinguishers and fire blankets/screens.',
        'Isolate or protect adjacent systems that could carry sparks or heat.',
        'Check gas cylinders, hoses, regulators, flashback arrestors and electrical leads.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Fire Watch',
      icon: Icons.check_circle_outline,
      items: [
        'Provide a competent fire watch during work and for the required post-work period.',
        'Keep fire watch personnel free from conflicting duties.',
        'Inspect adjacent and concealed areas for smouldering or heat transfer.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Gas & Cylinder Safety',
      icon: Icons.check_circle_outline,
      items: [
        'Secure cylinders upright and protect valves during transport and use.',
        'Separate incompatible gases and keep cylinders away from heat and impact.',
        'Check hoses, connections and leak conditions before use.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Hot work risk is driven by the path that heat, sparks or molten metal can travel.',
        'Fire prevention depends on controlling the surrounding environment, not only the welding machine.',
        'Permit quality should be verified at the work location before ignition begins.',
        'Post-work fire monitoring should reflect the building, materials and hidden-space risk.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_traffic_management': [
    _AbuDhabiSection(
      title: 'Traffic Planning',
      icon: Icons.traffic_outlined,
      items: [
        'Separate people, vehicles and mobile plant wherever practicable.',
        'Define site entry, exit, one-way routes, reversing controls, speed limits and delivery zones.',
        'Consider construction phase changes and temporary route changes.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Pedestrian Protection',
      icon: Icons.check_circle_outline,
      items: [
        'Provide protected pedestrian routes with clear barriers and crossing points.',
        'Use lighting, signs and visibility controls appropriate to the site.',
        'Prevent pedestrians from entering plant blind spots and loading areas.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Plant & Reversing',
      icon: Icons.check_circle_outline,
      items: [
        'Use competent authorised drivers/operators and maintain vehicle condition.',
        'Minimise reversing and use suitable banksman/spotter controls where required.',
        'Control mobile plant interaction with cranes, lifting operations and excavation edges.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Public & Interface Risk',
      icon: Icons.check_circle_outline,
      items: [
        'Protect the public and neighbouring properties where construction traffic interfaces with public roads.',
        'Coordinate delivery times and traffic marshaling to reduce congestion.',
        'Maintain emergency access routes at all times.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Traffic plans should be designed around actual movement patterns, not just drawing lines on a site plan.',
        'Blind spots, reversing and pedestrian/plant interface are critical-control areas.',
        'Temporary route changes require immediate communication and field verification.',
        'Use near-miss and observation data to redesign routes rather than only retrain drivers.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_occupational_health': [
    _AbuDhabiSection(
      title: 'Exposure Identification',
      icon: Icons.health_and_safety_outlined,
      items: [
        'Identify physical, chemical, biological, ergonomic and psychosocial exposures associated with work.',
        'Use risk assessment and occupational hygiene methods appropriate to the exposure.',
        'Consider vulnerable workers and individual fitness requirements within applicable policies.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Health Surveillance',
      icon: Icons.check_circle_outline,
      items: [
        'Provide health surveillance where required by exposure, risk assessment or applicable requirements.',
        'Use competent occupational health professionals and maintain confidentiality of medical information.',
        'Track referrals and follow-up without exposing unnecessary personal medical details to supervisors.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Common Construction Exposures',
      icon: Icons.check_circle_outline,
      items: [
        'Control dust, silica, noise, vibration, chemicals, heat, manual handling and ergonomic strain.',
        'Use engineering controls and suitable work methods before relying on PPE.',
        'Maintain SDS information and chemical exposure controls for hazardous substances.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Welfare & Worker Support',
      icon: Icons.check_circle_outline,
      items: [
        'Provide suitable sanitation, drinking water, rest areas and hygiene arrangements.',
        'Manage fatigue, working hours and recovery where risk indicates.',
        'Provide clear access to first aid and occupational health support.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Occupational health is preventive: exposure measurement and control should precede illness.',
        'Short-term comfort does not prove long-term exposure is safe.',
        'Use trends in sickness absence, health surveillance and exposure monitoring to identify system weaknesses.',
        'Integrate health controls into construction planning instead of treating them as medical-only issues.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_heat_stress': [
    _AbuDhabiSection(
      title: 'Heat Risk Assessment',
      icon: Icons.wb_sunny_outlined,
      items: [
        'Assess heat, humidity, radiant heat, workload, clothing, acclimatisation and individual factors.',
        'Identify high-risk periods and tasks and apply the project\'s approved UAE/Abu Dhabi heat controls.',
        'Monitor weather and site conditions and adjust work planning.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Work-Rest-Hydration',
      icon: Icons.check_circle_outline,
      items: [
        'Provide adequate drinking water and suitable rest arrangements.',
        'Schedule heavy work for safer periods where practicable and use planned recovery breaks.',
        'Use shaded or cooled rest areas appropriate to the work environment.',
        'Monitor new and returning workers for acclimatisation needs.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Recognition & Response',
      icon: Icons.check_circle_outline,
      items: [
        'Train workers and supervisors to recognise heat exhaustion and heat stroke warning signs.',
        'Stop work and obtain medical assistance when serious symptoms occur.',
        'Never leave a suspected heat-illness casualty alone while awaiting help.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Supervision & Monitoring',
      icon: Icons.check_circle_outline,
      items: [
        'Supervisors should actively observe workers rather than relying only on self-reporting.',
        'Increase controls for heavy PPE, high workload, poor airflow or high radiant heat.',
        'Record heat-related events and review work planning after incidents.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Heat stress is affected by workload and clothing as well as ambient temperature.',
        'Early symptoms can progress rapidly; emergency response should be rehearsed.',
        'Hydration alone is not a complete heat-control programme.',
        'Use seasonal planning, worker acclimatisation, engineering controls and work-rest scheduling together.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_ppe': [
    _AbuDhabiSection(
      title: 'PPE Selection',
      icon: Icons.shield_outlined,
      items: [
        'Select PPE from risk assessment and task requirements, not from a generic list.',
        'Use compatible PPE that does not introduce new hazards or interfere with other equipment.',
        'Consider fit, comfort, environmental conditions, duration and worker communication needs.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Hierarchy & Limitations',
      icon: Icons.check_circle_outline,
      items: [
        'Use PPE as a final layer after elimination, engineering and administrative controls.',
        'Do not use PPE to justify leaving a preventable hazard uncontrolled.',
        'Define residual risks that PPE is intended to control.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Inspection & Maintenance',
      icon: Icons.check_circle_outline,
      items: [
        'Inspect PPE before use and remove defective equipment from service.',
        'Maintain, clean, store and replace PPE according to manufacturer and project requirements.',
        'Control expiry, damage and contamination for relevant PPE.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Training & Use',
      icon: Icons.check_circle_outline,
      items: [
        'Train workers in selection, fitting, adjustment, limitations and emergency removal.',
        'Supervisors should verify correct use in the field.',
        'Provide suitable replacement and ensure workers have access to the required PPE.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Compatibility is a critical PPE issue: eye, respiratory, hearing, head, fall and other PPE can interact.',
        'Comfort and fit influence actual use and should be considered during selection.',
        'PPE programmes should include procurement, issue, inspection, replacement and disposal.',
        'Track recurring PPE failures as indicators of upstream control weaknesses.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_environmental_waste': [
    _AbuDhabiSection(
      title: 'Environmental Planning',
      icon: Icons.recycling_outlined,
      items: [
        'Identify environmental aspects associated with construction activities, materials, storage, transport and waste.',
        'Define controls for dust, noise, water, soil, spills, emissions and waste.',
        'Identify applicable authority and project environmental requirements.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Waste Segregation',
      icon: Icons.check_circle_outline,
      items: [
        'Separate waste streams according to project requirements and applicable disposal arrangements.',
        'Provide labelled, secure and suitable storage areas.',
        'Prevent uncontrolled burning, dumping or mixing of incompatible wastes.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Hazardous Materials & Spills',
      icon: Icons.check_circle_outline,
      items: [
        'Store chemicals and fuels with suitable containment and access controls.',
        'Maintain spill response materials and train relevant personnel.',
        'Control drains, soil and water pathways to prevent pollution.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Monitoring & Records',
      icon: Icons.check_circle_outline,
      items: [
        'Track waste quantities, disposal records, manifests or contractor evidence as applicable.',
        'Inspect waste areas and environmental controls routinely.',
        'Investigate spills, complaints and repeated environmental non-compliance.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Environmental controls protect both compliance and worker/public health.',
        'Poor housekeeping can become a fire, traffic, pest or exposure hazard as well as an environmental issue.',
        'Use source reduction and segregation to improve control at the point of generation.',
        'Emergency spill planning should consider the pathway and receptor, not just the spill source.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_inspection_audit': [
    _AbuDhabiSection(
      title: 'Inspection Planning',
      icon: Icons.fact_check_outlined,
      items: [
        'Create an inspection programme based on project phase, risk and work activity.',
        'Use competent inspectors and clear checklists linked to actual requirements.',
        'Include high-risk activities, temporary works, welfare, plant, access and emergency controls.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Verification',
      icon: Icons.check_circle_outline,
      items: [
        'Inspect the physical workplace and compare conditions with approved controls.',
        'Talk with workers and supervisors to test whether procedures are understood and practical.',
        'Record objective evidence, location, responsible party and priority.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Audit Process',
      icon: Icons.check_circle_outline,
      items: [
        'Define audit scope, criteria, evidence and reporting arrangements.',
        'Assess system implementation as well as field performance.',
        'Maintain impartiality and avoid auditing only paperwork generated by the same person.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Findings & Close-Out',
      icon: Icons.check_circle_outline,
      items: [
        'Classify findings consistently and assign actions with owners and due dates.',
        'Escalate serious or repeated issues promptly.',
        'Verify effectiveness after closure and identify systemic trends.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Inspection asks \'is the control present now?\'; audit also asks \'is the system capable of sustaining it?\'',
        'Good findings are specific enough to allow corrective action and verification.',
        'Use repeat findings to identify management-system weaknesses rather than endlessly closing symptoms.',
        'Field sampling should cover different locations, shifts, contractors and activities.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_performance_monitoring': [
    _AbuDhabiSection(
      title: 'Performance Framework',
      icon: Icons.analytics_outlined,
      items: [
        'Define a balanced set of leading and lagging indicators relevant to project risk.',
        'Assign data owners, reporting frequency, definitions and verification methods.',
        'Avoid indicators that reward under-reporting or discourage transparent reporting.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Leading Indicators',
      icon: Icons.check_circle_outline,
      items: [
        'Monitor critical-control verification, inspections, training, observations, corrective action ageing and emergency drills.',
        'Track preventive activities against planned targets.',
        'Use trends to identify deteriorating control before harm occurs.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Lagging Indicators',
      icon: Icons.check_circle_outline,
      items: [
        'Monitor injuries, illnesses, high-potential events, property damage and other relevant outcomes.',
        'Analyse frequency, severity, recurrence and causal themes.',
        'Use event data as one part of the performance picture rather than the only measure.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Review & Action',
      icon: Icons.check_circle_outline,
      items: [
        'Discuss trends in HSE meetings and management review.',
        'Investigate unusual changes in reporting behaviour or performance.',
        'Convert meaningful trends into targeted controls, resources and improvement actions.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Zero incidents does not automatically prove strong control if exposure and reporting quality are unknown.',
        'Use critical-risk indicators that directly test whether essential barriers are functioning.',
        'Triangulate data from inspections, worker feedback, incidents and audits.',
        'Trend performance by activity, contractor, location and phase to find concentration of risk.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
  'ad_electronic_reporting': [
    _AbuDhabiSection(
      title: 'Reporting System Governance',
      icon: Icons.cloud_upload_outlined,
      items: [
        'Identify the current official electronic reporting platform and the reports/forms applicable to the organisation.',
        'Assign authorised users and define review and approval responsibilities.',
        'Maintain controlled access and protect login credentials and submitted information.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Data Quality',
      icon: Icons.check_circle_outline,
      items: [
        'Submit accurate, complete and timely information according to applicable requirements.',
        'Use consistent definitions and source records so submitted data can be verified.',
        'Review entries before submission to prevent avoidable errors and omissions.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Incident & Performance Reporting',
      icon: Icons.check_circle_outline,
      items: [
        'Maintain supporting evidence for reported incidents, performance information and mandatory submissions.',
        'Track submission dates, acknowledgement, queries and required corrections.',
        'Escalate missed or rejected submissions promptly.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Record Control',
      icon: Icons.check_circle_outline,
      items: [
        'Keep copies or reliable records of submitted forms and supporting evidence according to the project record system.',
        'Protect personal and sensitive information from unauthorised access.',
        'Use version control when corrected or resubmitted information is required.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Advanced Learning',
      icon: Icons.check_circle_outline,
      items: [
        'Electronic reporting is part of compliance assurance, not simply an administrative task.',
        'Data quality directly affects the authority\'s ability to understand risk and the organisation\'s ability to manage it.',
        'Build an internal review step before formal submission for high-importance reports.',
        'Monitor recurring submission errors and train responsible personnel on the root causes.',
      ],
    ),
    _AbuDhabiSection(
      title: 'Field Application & Verification',
      icon: Icons.fact_check_outlined,
      items: [
        'Before work: confirm the approved method, competent people, required controls and applicable authority/project requirements for this topic.',
        'During work: verify the critical controls at the point of exposure, communicate changes and stop/reassess when the approved control cannot be maintained.',
        'After work: inspect the result, record evidence, correct deficiencies and capture lessons that should improve the next work cycle.',
        'Supervisor check: ask the work team to explain the main hazard, the critical control and what they will do if the condition changes.',
      ],
    ),
  ],
};
