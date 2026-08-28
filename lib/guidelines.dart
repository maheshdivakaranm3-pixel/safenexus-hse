import 'package:flutter/material.dart';
import 'guideline_detail_page.dart';

class GuidelinesPage extends StatefulWidget {
  const GuidelinesPage({Key? key}) : super(key: key);

  @override
  State<GuidelinesPage> createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  String _language = 'English';

  final Map<String, List<Map<String, String>>> guidelines = {
    'English': [
      {
        'letter': 'A',
        'title': 'ADOSH (Abu Dhabi OSH)',
        'desc': 'Abu Dhabi Occupational Safety and Health requirements.',
        'English_title': 'ADOSH (Abu Dhabi OSH)',
        'English_what': 'What is ADOSH?',
        'English_whatText':
            'ADOSH is the Abu Dhabi Occupational Safety and Health system used to manage workplace safety and health risks.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent injuries, occupational illness and unsafe working conditions.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Implement applicable OSH requirements, risk assessments, procedures, training and reporting.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Employers, supervisors and workers must follow applicable OSH requirements.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Risk assessment, PPE, training, inspections, emergency arrangements and reporting.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Failure to control identified hazards can result in unsafe conditions and corrective action.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Maintain documented procedures, inspections, training and continual improvement.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Abu Dhabi Occupational Safety and Health System requirements.'
      },
      {
        'letter': 'B',
        'title': 'Basic Safety Rules',
        'desc': 'Essential safety rules for every workplace.',
        'English_title': 'Basic Safety Rules',
        'English_what': 'What are Basic Safety Rules?',
        'English_whatText':
            'Basic safety rules are fundamental precautions that workers must follow to prevent accidents.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To reduce unsafe acts, unsafe conditions and workplace injuries.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Use required PPE, follow procedures, maintain housekeeping and report hazards.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Workers and supervisors must actively maintain safe working conditions.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'PPE, housekeeping, access, tools, electrical safety and emergency routes.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Ignoring site safety rules may expose workers to serious hazards.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Stop unsafe work, report hazards and follow approved safe work procedures.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company HSE procedures and applicable UAE requirements.'
      },
      {
        'letter': 'C',
        'title': 'Code of Practice (CoP)',
        'desc': 'Safety requirements and good practice guidance.',
        'English_title': 'Code of Practice (CoP)',
        'English_what': 'What is a Code of Practice?',
        'English_whatText':
            'A Code of Practice provides practical guidance for managing specific workplace safety risks.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To provide consistent and practical safety controls.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify applicable codes and implement their relevant requirements.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'HSE personnel and supervisors must ensure applicable requirements are communicated and followed.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Applicable CoP, risk assessment, procedures, competent persons and inspections.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Failure to follow applicable requirements can create significant safety risks.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Keep current copies of applicable standards and review procedures regularly.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE authority Codes of Practice and company procedures.'
      },
      {
        'letter': 'D',
        'title': 'Daily Toolbox Talk (TBT)',
        'desc': 'Daily safety briefing before work starts.',
        'English_title': 'Daily Toolbox Talk (TBT)',
        'English_what': 'What is a Toolbox Talk?',
        'English_whatText':
            'A Toolbox Talk is a short safety briefing conducted before work to discuss hazards and controls.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To make workers aware of task-specific hazards before starting work.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Discuss the work scope, hazards, controls, PPE and emergency arrangements.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Supervisors should conduct the briefing and workers should actively participate.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Work scope, hazards, controls, PPE, equipment, weather and emergency arrangements.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Starting work without appropriate briefing can leave workers unaware of hazards.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Keep the discussion short, practical and specific to the planned task.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company HSE procedures and task-specific risk assessments.'
      },
      {
        'letter': 'E',
        'title': 'Emergency Preparedness',
        'desc': 'Preparation for emergencies and accidents.',
        'English_title': 'Emergency Preparedness',
        'English_what': 'What is Emergency Preparedness?',
        'English_whatText':
            'Emergency preparedness means planning and preparing for fires, medical emergencies, spills and other incidents.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To reduce harm and ensure a quick and coordinated response.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Maintain emergency plans, alarms, evacuation routes, assembly points and trained responders.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Workers must know emergency procedures and supervisors must ensure arrangements are maintained.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Emergency numbers, alarms, exits, assembly points, first aid and fire equipment.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Blocked exits, missing equipment or lack of training can increase emergency consequences.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Conduct drills and regularly inspect emergency equipment and routes.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Site emergency plan and applicable UAE emergency requirements.'
      },
      {
        'letter': 'F',
        'title': 'Fire Safety & Prevention',
        'desc': 'Fire prevention and fire protection controls.',
        'English_title': 'Fire Safety & Prevention',
        'English_what': 'What is Fire Safety?',
        'English_whatText':
            'Fire safety involves preventing ignition, controlling fire hazards and preparing for emergency response.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent fires and reduce loss of life, property and equipment.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Control ignition sources, maintain fire extinguishers and follow hot work controls.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Workers must follow fire prevention procedures and report fire hazards immediately.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Extinguishers, fire points, hot work permit, combustible materials and emergency access.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Uncontrolled hot work, blocked fire equipment or poor storage can increase fire risk.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Keep ignition sources controlled and inspect fire protection equipment regularly.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE fire and civil defence requirements.'
      },
      {
        'letter': 'G',
        'title': 'Green Building Regulations',
        'desc': 'Sustainable construction and environmental protection.',
        'English_title': 'Green Building Regulations',
        'English_what': 'What are Green Building Regulations?',
        'English_whatText':
            'Green building requirements promote efficient use of energy, water and materials and reduce environmental impact.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To improve sustainability and reduce environmental impacts from construction and operation.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Follow applicable sustainability, waste, energy, water and environmental requirements.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Project teams must implement approved environmental and sustainability controls.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Waste segregation, water conservation, energy efficiency, dust and pollution control.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Poor environmental controls can cause pollution and regulatory non-compliance.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Monitor environmental performance and minimize waste and resource consumption.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE environmental and green building requirements.'
      },
      {
        'letter': 'H',
        'title': 'Heat Stress Management',
        'desc': 'Protection against heat-related illness.',
        'English_title': 'Heat Stress Management',
        'English_what': 'What is Heat Stress?',
        'English_whatText':
            'Heat stress occurs when the body cannot adequately control its temperature during hot working conditions.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent heat exhaustion, heat stroke and other heat-related illnesses.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Provide drinking water, shaded rest areas, acclimatization, monitoring and applicable midday work restrictions.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Supervisors must monitor workers and workers should report heat-related symptoms immediately.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Water, shade, rest breaks, acclimatization, weather monitoring and worker awareness.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Ignoring heat controls can result in serious heat-related illness.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Plan heavy work during cooler periods and monitor workers continuously.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE occupational heat stress and midday break requirements.'
      },
      {
        'letter': 'I',
        'title': 'Incident Investigation',
        'desc': 'Finding causes of incidents and near misses.',
        'English_title': 'Incident Investigation',
        'English_what': 'What is Incident Investigation?',
        'English_whatText':
            'Incident investigation is a structured process used to identify immediate, underlying and root causes.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent recurrence and improve safety controls.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Secure the scene, collect evidence, interview relevant persons and identify corrective actions.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Investigators should remain objective and focus on system improvements.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Scene evidence, photographs, statements, documents, root cause and corrective actions.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Poor investigation can allow the same incident to happen again.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Focus on root causes rather than blaming individuals.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company incident investigation procedure.'
      },
      {
        'letter': 'J',
        'title': 'Job Safety Analysis (JSA)',
        'desc': 'Identify hazards and controls before a job.',
        'English_title': 'Job Safety Analysis (JSA)',
        'English_what': 'What is JSA?',
        'English_whatText':
            'JSA breaks a job into steps and identifies hazards and controls for each step.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent incidents by controlling hazards before work starts.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify job steps, hazards, risk levels and appropriate control measures.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Supervisors and workers should participate in task hazard identification.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Job steps, hazards, risk rating, controls, PPE and responsible persons.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Starting high-risk work without adequate assessment may expose workers to uncontrolled hazards.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Review the JSA whenever the task, equipment or conditions change.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company risk assessment and JSA procedures.'
      },
      {
        'letter': 'K',
        'title': 'Key Performance Indicators',
        'desc': 'Measures used to monitor HSE performance.',
        'English_title': 'Key Performance Indicators',
        'English_what': 'What are KPIs?',
        'English_whatText':
            'HSE KPIs are measurable indicators used to monitor safety performance.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To identify trends, weaknesses and opportunities for improvement.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Collect reliable data and review relevant leading and lagging indicators.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management and HSE teams should review performance and implement improvements.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Inspections, observations, training, incidents, near misses and corrective actions.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Poor data quality can hide important safety trends.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use leading indicators to identify risks before incidents occur.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company HSE performance management system.'
      },
      {
        'letter': 'L',
        'title': 'Lifting Operations',
        'desc': 'Safe crane and lifting activities.',
        'English_title': 'Lifting Operations',
        'English_what': 'What are Lifting Operations?',
        'English_whatText':
            'Lifting operations involve moving loads using cranes, hoists or other lifting equipment.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent dropped loads, equipment failure and struck-by incidents.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Use competent personnel, inspected equipment, suitable lifting accessories and approved lifting plans where required.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Operators, riggers, signalers and supervisors must perform their assigned duties safely.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Crane inspection, lifting accessories, load weight, exclusion zone and communication.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Overloading, defective accessories and unauthorized lifting can cause serious incidents.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Inspect equipment before use and maintain a controlled lifting zone.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE lifting equipment requirements and company procedures.'
      },
      {
        'letter': 'M',
        'title': 'Manual Handling',
        'desc': 'Safe handling of materials.',
        'English_title': 'Manual Handling',
        'English_what': 'What is Manual Handling?',
        'English_whatText':
            'Manual handling includes lifting, carrying, pushing, pulling or moving objects by physical effort.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent strains, sprains and musculoskeletal injuries.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Assess heavy or awkward loads and use mechanical assistance where appropriate.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Workers should use safe lifting techniques and ask for assistance when needed.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Load weight, posture, route, grip, assistance and mechanical aids.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Improper lifting techniques can result in serious musculoskeletal injuries.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Plan the lift and avoid twisting while carrying loads.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company manual handling procedure.'
      },
      {
        'letter': 'N',
        'title': 'Near Miss Reporting',
        'desc': 'Report events that could have caused harm.',
        'English_title': 'Near Miss Reporting',
        'English_what': 'What is a Near Miss?',
        'English_whatText':
            'A near miss is an event that did not cause injury or damage but had the potential to do so.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To identify hazards before they result in actual incidents.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Report near misses promptly and investigate significant events.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'All workers should report near misses without fear of blame.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Location, activity, hazard, potential consequence, immediate action and corrective action.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Failure to report near misses can allow hazards to remain uncontrolled.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use near misses as learning opportunities and share lessons learned.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company incident and near miss reporting procedure.'
      },
      {
        'letter': 'O',
        'title': 'OSHA & ISO Standards',
        'desc': 'International occupational safety references.',
        'English_title': 'OSHA & ISO Standards',
        'English_what': 'What are OSHA and ISO Standards?',
        'English_whatText':
            'OSHA provides occupational safety guidance and regulations in the United States, while ISO 45001 is an international occupational health and safety management system standard.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To support systematic management of occupational health and safety.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Apply the standards or guidance relevant to the organization and legal requirements.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management and HSE teams should maintain effective safety management systems.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Policy, risk assessment, objectives, training, monitoring and continual improvement.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Incorrectly applying standards can create gaps in safety management.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use applicable legal requirements as the primary compliance basis and standards as appropriate.',
        'English_reference': 'Reference',
        'English_referenceText':
            'ISO 45001 and applicable occupational safety requirements.'
      },
      {
        'letter': 'P',
        'title': 'PPE Compliance',
        'desc': 'Correct use of personal protective equipment.',
        'English_title': 'PPE Compliance',
        'English_what': 'What is PPE?',
        'English_whatText':
            'Personal Protective Equipment protects workers from specific workplace hazards when properly selected and used.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To reduce exposure to hazards that cannot be adequately controlled by other means.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Select suitable PPE, inspect it, maintain it and use it correctly.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Employers provide appropriate PPE and workers use it as instructed.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Helmet, safety footwear, eye protection, gloves, hearing protection and task-specific PPE.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Incorrect or missing PPE can increase exposure to workplace hazards.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Choose PPE based on the hazard assessment and ensure proper fit.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company PPE procedure and applicable UAE requirements.'
      },
      {
        'letter': 'Q',
        'title': 'HSE Auditing',
        'desc': 'Systematic checking of HSE compliance.',
        'English_title': 'HSE Auditing',
        'English_what': 'What is HSE Auditing?',
        'English_whatText':
            'An HSE audit systematically evaluates whether safety systems and requirements are being implemented effectively.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To identify compliance gaps and opportunities for improvement.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Use an audit plan, objective evidence, findings and corrective actions.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Auditors should be competent and objective, while responsible managers should close findings.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Documents, site conditions, training, permits, inspections and corrective actions.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Repeated unresolved findings indicate weaknesses in the HSE management system.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Track findings to closure and verify corrective actions.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company HSE audit procedure and applicable management system requirements.'
      },
      {
        'letter': 'R',
        'title': 'Risk Assessment',
        'desc': 'Identify hazards and control workplace risks.',
        'English_title': 'Risk Assessment',
        'English_what': 'What is Risk Assessment?',
        'English_whatText':
            'Risk assessment is the process of identifying hazards, evaluating risks and selecting appropriate controls.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent harm by controlling risks before and during work.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify hazards, assess risk, apply controls and review when conditions change.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Competent persons should conduct assessments with input from workers.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Hazards, people at risk, risk rating, hierarchy of controls and residual risk.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Failure to identify significant hazards can result in uncontrolled risk.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use the hierarchy of controls and review assessments after changes or incidents.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company risk assessment procedure and applicable UAE requirements.'
      },
      {
        'letter': 'S',
        'title': 'Scaffolding Safety',
        'desc': 'Safe erection, inspection and use of scaffolds.',
        'English_title': 'Scaffolding Safety',
        'English_what': 'What is Scaffolding Safety?',
        'English_whatText':
            'Scaffolding safety covers the design, erection, inspection, access and safe use of scaffolds.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent falls, scaffold collapse and falling-object incidents.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Use competent persons, proper access, guardrails, platforms, inspection and applicable tagging systems.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Only authorized and competent personnel should erect, modify or inspect scaffolds.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Foundation, structure, access ladder, guardrails, toe boards, platform gaps and inspection status.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Missing guardrails, unsafe access, excessive gaps or unauthorized modification can cause falls.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Inspect scaffolds before use and after significant changes or events.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE scaffolding requirements and approved company procedures.'
      },
      {
        'letter': 'T',
        'title': 'Training & Induction',
        'desc': 'Safety training for workers and new personnel.',
        'English_title': 'Training & Induction',
        'English_what': 'What is Safety Induction?',
        'English_whatText':
            'Safety induction introduces workers to site hazards, rules, emergency procedures and responsibilities.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To ensure workers understand the hazards and controls before starting work.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Provide appropriate induction and task-specific training before work begins.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management must provide suitable training and workers must participate and follow instructions.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Site rules, PPE, emergency arrangements, hazards, permits and competency requirements.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Untrained workers may not recognize or properly control workplace hazards.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Keep training records and refresh training when risks or work activities change.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company training matrix and HSE procedures.'
      },
      {
        'letter': 'U',
        'title': 'UAE Labour Law',
        'desc': 'Worker rights, welfare and workplace safety requirements.',
        'English_title': 'UAE Labour Law',
        'English_what': 'What is UAE Labour Law?',
        'English_whatText':
            'UAE labour legislation establishes requirements governing employment relationships and worker protections.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To establish legal protections and responsibilities in the workplace.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Organizations must comply with applicable UAE labour and occupational safety legislation.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Employers and workers must understand and comply with their applicable legal obligations.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Working conditions, welfare, safety arrangements, records and applicable legal requirements.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Non-compliance with applicable labour requirements can lead to legal and safety consequences.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Maintain current legal registers and regularly review compliance.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE labour legislation and official requirements.'
      },
      {
        'letter': 'V',
        'title': 'Ventilation & Confined Space',
        'desc': 'Safe ventilation and confined-space entry.',
        'English_title': 'Ventilation & Confined Space',
        'English_what': 'What is a Confined Space?',
        'English_whatText':
            'A confined space is an enclosed or partially enclosed area that may present specific hazards and is not intended for continuous occupancy.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent toxic exposure, oxygen deficiency, engulfment and other confined-space hazards.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Assess hazards, control access, test the atmosphere and use an approved entry system where required.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Only trained and authorized personnel should perform confined-space work.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Atmospheric testing, ventilation, permit, communication, standby person and rescue plan.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Uncontrolled entry can expose workers to life-threatening atmospheric hazards.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use continuous monitoring when required and maintain an effective rescue arrangement.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company confined-space procedure and applicable UAE requirements.'
      },
      {
        'letter': 'W',
        'title': 'Waste Management',
        'desc': 'Safe handling and disposal of workplace waste.',
        'English_title': 'Waste Management',
        'English_what': 'What is Waste Management?',
        'English_whatText':
            'Waste management includes segregation, storage, handling, transport and disposal of waste.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent pollution, injuries and unsafe workplace conditions.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Segregate waste, use suitable containers and dispose of waste through approved methods.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Workers must use designated waste containers and report improper disposal.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Waste segregation, containers, labels, storage area, housekeeping and approved disposal.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Poor waste management can cause trips, fire hazards and environmental pollution.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Segregate waste at source and maintain clean designated storage areas.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE environmental and waste-management requirements.'
      },
      {
        'letter': 'X',
        'title': 'Radiation Safety',
        'desc': 'Safety controls for radiation and radiography work.',
        'English_title': 'Radiation Safety',
        'English_what': 'What is Radiation Safety?',
        'English_whatText':
            'Radiation safety controls exposure to ionizing radiation during activities such as industrial radiography.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent harmful radiation exposure to workers and the public.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Use authorized personnel, controlled areas, warning signs, monitoring and approved procedures.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Radiation workers must follow approved procedures and access restrictions.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Controlled area, warning signs, monitoring, equipment checks and emergency arrangements.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Unauthorized access or inadequate controls can result in radiation exposure.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Minimize exposure using appropriate time, distance and shielding principles.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE radiation protection requirements and approved procedures.'
      },
      {
        'letter': 'Y',
        'title': 'Yard & Traffic Safety',
        'desc': 'Safe vehicle and pedestrian movement.',
        'English_title': 'Yard & Traffic Safety',
        'English_what': 'What is Yard & Traffic Safety?',
        'English_whatText':
            'Yard and traffic safety controls the movement of vehicles, mobile equipment and pedestrians.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent vehicle collisions, struck-by incidents and pedestrian injuries.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Use traffic routes, speed controls, designated parking and pedestrian segregation.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Drivers, pedestrians and supervisors must follow site traffic rules.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Speed limits, signage, lighting, reversing controls, pedestrian routes and parking.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Speeding, unsafe reversing and poor segregation can result in serious incidents.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Separate pedestrians from vehicles wherever reasonably practicable.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Site traffic management plan and company HSE procedures.'
      },
      {
        'letter': 'Z',
        'title': 'Zero Accident Goal',
        'desc': 'Continuous improvement towards accident prevention.',
        'English_title': 'Zero Accident Goal',
        'English_what': 'What is the Zero Accident Goal?',
        'English_whatText':
            'The zero accident goal represents a commitment to preventing workplace injuries and improving safety performance.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To build a strong safety culture and continuously reduce workplace risks.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify hazards, control risks, report incidents and continuously improve safety systems.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Everyone has a role in identifying hazards and preventing incidents.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Risk assessment, inspections, observations, training, reporting and corrective actions.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Ignoring hazards or unsafe behavior undermines accident prevention efforts.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Promote reporting, learning, worker involvement and proactive hazard control.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company HSE policy and applicable occupational safety requirements.'
      },
    ],
  };

  final Map<String, String> pageTitles = {
    'English': 'UAE HSE A-Z Guidelines',
    'Hindi': 'UAE HSE A-Z सुरक्षा दिशानिर्देश',
    'Malayalam': 'UAE HSE A-Z സുരക്ഷാ മാർഗ്ഗനിർദ്ദേശങ്ങൾ',
    'Tamil': 'UAE HSE A-Z பாதுகாப்பு வழிகாட்டுதல்கள்',
  };

  void _changeLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  void _openGuideline(Map<String, String> item) {
    final Map<String, String> detailGuideline =
        Map<String, String>.from(item);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GuidelineDetailPage(
          guideline: detailGuideline,
          language: _language,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentGuidelines = guidelines['English'] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitles[_language]!),
        backgroundColor: Colors.blueAccent,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: _changeLanguage,
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'English',
                child: Text('English'),
              ),
              PopupMenuItem(
                value: 'Hindi',
                child: Text('हिन्दी'),
              ),
              PopupMenuItem(
                value: 'Malayalam',
                child: Text('മലയാളം'),
              ),
              PopupMenuItem(
                value: 'Tamil',
                child: Text('தமிழ்'),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: currentGuidelines.length,
        itemBuilder: (context, index) {
          final item = currentGuidelines[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            elevation: 3,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blueAccent,
                child: Text(
                  item['letter'] ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                item['title'] ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  item['desc'] ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.blueAccent,
              ),
              onTap: () {
                _openGuideline(item);
              },
            ),
          );
        },
      ),
    );
  }
}
