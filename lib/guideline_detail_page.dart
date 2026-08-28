import 'package:flutter/material.dart';

class GuidelineDetailPage extends StatelessWidget {
  final Map<String, String> guideline;
  final String language;

  const GuidelineDetailPage({
    Key? key,
    required this.guideline,
    required this.language,
  }) : super(key: key);

  String get letter => guideline['letter'] ?? '';
  String get title => guideline['title'] ?? '';
  String get desc => guideline['desc'] ?? '';

  Map<String, Map<String, String>> get details {
    return {
      'A': {
        'what': 'What is ADOSH?',
        'whatText':
            'ADOSH-SF is the Abu Dhabi Occupational Safety and Health System Framework. It provides a structured system for managing occupational safety and health in Abu Dhabi.',
        'purpose': 'Purpose',
        'purposeText':
            'To protect workers, prevent occupational injuries and illnesses, and establish effective OSH management systems.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Implement an effective OSH management system, identify hazards, assess risks, provide controls, training, supervision and reporting.',
        'responsibilities': 'HSE Responsibilities',
        'responsibilitiesText':
            'HSE personnel should monitor compliance, conduct inspections, support risk assessment, investigate incidents and promote continual improvement.',
        'checklist': 'Site Checklist',
        'checklistText':
            'Risk assessment available • Safe systems of work • Training records • PPE • Emergency arrangements • Inspections • Incident reporting.',
        'violations': 'Common Issues',
        'violationsText':
            'Missing risk assessments, inadequate supervision, poor housekeeping, insufficient PPE and failure to report incidents.',
        'best': 'Best Practice',
        'bestText':
            'Use the applicable official ADOSH requirements, maintain documented procedures and continuously improve workplace safety.',
        'reference': 'Reference',
        'referenceText':
            'Abu Dhabi Public Health Centre (ADPHC) – ADOSH-SF legislation and Codes of Practice.',
      },

      'B': {
        'what': 'What are Basic Safety Rules?',
        'whatText':
            'Basic Safety Rules are fundamental workplace practices designed to prevent injuries, incidents and unsafe conditions.',
        'purpose': 'Purpose',
        'purposeText':
            'To establish safe behaviour and minimum safety expectations for everyone at the workplace.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Follow site rules, use required PPE, maintain housekeeping, follow approved procedures and report unsafe conditions.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Workers must follow instructions and report hazards. Supervisors must provide proper instruction, supervision and controls.',
        'checklist': 'Checklist',
        'checklistText':
            'PPE • Housekeeping • Access • Safe tools • Warning signs • Emergency routes • Permit requirements.',
        'violations': 'Common Issues',
        'violationsText':
            'Ignoring PPE requirements, unsafe shortcuts, blocked access routes and failure to report hazards.',
        'best': 'Best Practice',
        'bestText':
            'Stop unsafe work, correct hazards immediately where possible and communicate safety expectations clearly.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE and site-specific occupational safety requirements.',
      },

      'C': {
        'what': 'What is a Code of Practice?',
        'whatText':
            'A Code of Practice provides technical occupational safety and health requirements for specific workplace subjects.',
        'purpose': 'Purpose',
        'purposeText':
            'To provide consistent technical requirements and controls for managing specific OSH risks.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Identify the applicable CoP, understand its requirements and implement the relevant controls within the workplace.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Employers and responsible personnel should ensure applicable requirements are understood and implemented.',
        'checklist': 'Checklist',
        'checklistText':
            'Applicable CoP identified • Requirements reviewed • Controls implemented • Records maintained • Compliance monitored.',
        'violations': 'Common Issues',
        'violationsText':
            'Failure to identify applicable requirements, incomplete controls and poor documentation.',
        'best': 'Best Practice',
        'bestText':
            'Always verify the latest applicable official Code of Practice before making compliance decisions.',
        'reference': 'Reference',
        'referenceText':
            'Abu Dhabi Public Health Centre (ADPHC) – Codes of Practice.',
      },

      'D': {
        'what': 'What is a Toolbox Talk?',
        'whatText':
            'A Toolbox Talk is a short safety discussion conducted before work to communicate job-specific hazards and controls.',
        'purpose': 'Purpose',
        'purposeText':
            'To make workers aware of the hazards, controls and safe working methods for the planned task.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Discuss the task, hazards, controls, PPE, emergency arrangements and worker questions.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'The supervisor or competent person should conduct the briefing and ensure workers understand the information.',
        'checklist': 'Checklist',
        'checklistText':
            'Task explained • Hazards identified • Controls discussed • PPE checked • Attendance recorded.',
        'violations': 'Common Issues',
        'violationsText':
            'Generic talks, no attendance record, poor worker participation and failure to discuss task-specific hazards.',
        'best': 'Best Practice',
        'bestText':
            'Keep the discussion practical, short and directly related to the work being performed.',
        'reference': 'Reference',
        'referenceText':
            'Applicable site HSE procedures and UAE OSH requirements.',
      },

      'E': {
        'what': 'What is Emergency Preparedness?',
        'whatText':
            'Emergency preparedness means planning and preparing for situations such as fire, serious injury, chemical release or other emergencies.',
        'purpose': 'Purpose',
        'purposeText':
            'To reduce injury, loss and confusion during an emergency.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Emergency plans, alarms, evacuation routes, assembly points, emergency contacts, trained personnel and drills.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Workers should know the alarm, evacuation route and assembly point. Supervisors should coordinate emergency response arrangements.',
        'checklist': 'Checklist',
        'checklistText':
            'Emergency plan • Alarm • Exit routes • Assembly point • Fire equipment • First aid • Emergency contacts.',
        'violations': 'Common Issues',
        'violationsText':
            'Blocked exits, missing signs, poor emergency awareness and inadequate drills.',
        'best': 'Best Practice',
        'bestText':
            'Conduct appropriate emergency drills and regularly review emergency arrangements.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE fire, emergency and occupational safety requirements.',
      },

      'F': {
        'what': 'What is Fire Safety?',
        'whatText':
            'Fire safety includes measures used to prevent fires, protect people and respond effectively when a fire occurs.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent fire incidents and minimise consequences if a fire occurs.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Control ignition sources, maintain fire equipment, keep escape routes clear and manage hot work safely.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Workers must follow fire precautions and report fire hazards. Supervisors must ensure required controls are implemented.',
        'checklist': 'Checklist',
        'checklistText':
            'Extinguishers • Fire exits • Alarm • Hot work controls • Flammable materials • Emergency access.',
        'violations': 'Common Issues',
        'violationsText':
            'Blocked fire exits, uncontrolled hot work, poor storage of flammable materials and inaccessible extinguishers.',
        'best': 'Best Practice',
        'bestText':
            'Control ignition sources and maintain effective fire prevention and emergency arrangements.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE fire and life safety requirements and site procedures.',
      },

      'G': {
        'what': 'What are Green Building Regulations?',
        'whatText':
            'Green building practices focus on sustainable construction, efficient resource use and environmental protection.',
        'purpose': 'Purpose',
        'purposeText':
            'To reduce environmental impact and improve resource efficiency throughout construction and building operation.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Energy efficiency, water conservation, waste reduction, sustainable materials and environmental controls as applicable.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Project teams should implement applicable environmental and sustainability requirements.',
        'checklist': 'Checklist',
        'checklistText':
            'Waste segregation • Water management • Energy efficiency • Environmental controls • Approved materials.',
        'violations': 'Common Issues',
        'violationsText':
            'Poor waste segregation, excessive resource consumption and inadequate environmental controls.',
        'best': 'Best Practice',
        'bestText':
            'Integrate environmental controls into planning, procurement and daily site activities.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE and local authority sustainability requirements.',
      },

      'H': {
        'what': 'What is Heat Stress Management?',
        'whatText':
            'Heat stress management protects workers from excessive heat exposure and related illnesses.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent heat-related illness through planning, hydration, rest, shade, training and monitoring.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Provide drinking water, suitable rest arrangements, heat awareness, supervision and comply with applicable UAE midday work restrictions.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Supervisors should monitor workers for heat stress symptoms and implement required controls.',
        'checklist': 'Checklist',
        'checklistText':
            'Water • Shade/rest • Worker awareness • Heat monitoring • Work/rest planning • First aid.',
        'violations': 'Common Issues',
        'violationsText':
            'Insufficient drinking water, inadequate rest, poor supervision and failure to follow applicable midday restrictions.',
        'best': 'Best Practice',
        'bestText':
            'Plan physically demanding work around heat conditions and encourage early reporting of symptoms.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE Ministry of Human Resources and Emiratisation and local OSH requirements.',
      },

      'I': {
        'what': 'What is Incident Investigation?',
        'whatText':
            'Incident investigation is a systematic process used to understand what happened and identify underlying causes.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent recurrence by identifying root and contributing causes.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Secure the scene, collect evidence, interview relevant persons, identify causes and implement corrective actions.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Competent investigation personnel should conduct the investigation objectively and document findings.',
        'checklist': 'Checklist',
        'checklistText':
            'Scene secured • Evidence collected • Interviews • Cause analysis • Corrective actions • Follow-up.',
        'violations': 'Common Issues',
        'violationsText':
            'Blaming individuals without root-cause analysis, incomplete evidence and weak corrective actions.',
        'best': 'Best Practice',
        'bestText':
            'Focus on system and contributing factors rather than simply assigning blame.',
        'reference': 'Reference',
        'referenceText':
            'Applicable incident reporting procedures and UAE OSH requirements.',
      },

      'J': {
        'what': 'What is Job Safety Analysis?',
        'whatText':
            'JSA is a structured process for breaking a job into steps, identifying hazards and establishing controls.',
        'purpose': 'Purpose',
        'purposeText':
            'To reduce risk before work starts and ensure workers understand safe work methods.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Identify job steps, hazards, risk controls, required PPE and responsible persons.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Supervisors and competent personnel should ensure the JSA reflects actual site conditions.',
        'checklist': 'Checklist',
        'checklistText':
            'Job steps • Hazards • Risk rating • Controls • PPE • Worker briefing.',
        'violations': 'Common Issues',
        'violationsText':
            'Copy-paste JSAs, missing hazards and controls that do not match actual work conditions.',
        'best': 'Best Practice',
        'bestText':
            'Review the JSA whenever the task, equipment, environment or conditions change.',
        'reference': 'Reference',
        'referenceText':
            'Applicable project risk assessment and safe work procedures.',
      },

      'K': {
        'what': 'What are HSE Key Performance Indicators?',
        'whatText':
            'KPIs are measurable indicators used to monitor safety performance and identify improvement areas.',
        'purpose': 'Purpose',
        'purposeText':
            'To measure performance, identify trends and support continual improvement.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Use meaningful leading and lagging indicators and review trends regularly.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'HSE teams should collect reliable data and communicate performance results.',
        'checklist': 'Checklist',
        'checklistText':
            'Inspections • Training • Near misses • Incidents • Corrective actions • Trends.',
        'violations': 'Common Issues',
        'violationsText':
            'Focusing only on accident numbers and ignoring leading indicators.',
        'best': 'Best Practice',
        'bestText':
            'Use KPIs to drive preventive action rather than simply reporting statistics.',
        'reference': 'Reference',
        'referenceText':
            'Company HSE management system and applicable OSH requirements.',
      },

      'L': {
        'what': 'What are Lifting Operations?',
        'whatText':
            'Lifting operations involve moving loads using cranes, lifting equipment or accessories.',
        'purpose': 'Purpose',
        'purposeText':
            'To safely plan and execute lifting activities while preventing dropped loads and equipment failure.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Competent personnel, suitable lifting equipment, inspection, lifting plan where required, exclusion zones and communication.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Lifting supervisors, operators, riggers and signalers must perform their assigned roles competently.',
        'checklist': 'Checklist',
        'checklistText':
            'Equipment inspection • SWL/WLL • Rigging • Ground condition • Exclusion zone • Communication.',
        'violations': 'Common Issues',
        'violationsText':
            'Overloading, damaged lifting accessories, poor rigging and people standing under suspended loads.',
        'best': 'Best Practice',
        'bestText':
            'Plan the lift, verify equipment capacity and keep people away from suspended loads.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE OSH lifting requirements and approved lifting procedures.',
      },

      'M': {
        'what': 'What is Manual Handling?',
        'whatText':
            'Manual handling involves lifting, carrying, pushing, pulling or moving objects using physical effort.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent musculoskeletal injuries and other manual handling-related harm.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Assess the task, reduce load weight where possible, use mechanical aids and provide suitable training.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Supervisors should identify high-risk manual tasks and workers should use safe handling techniques.',
        'checklist': 'Checklist',
        'checklistText':
            'Load assessed • Mechanical aid • Safe route • Team lift where appropriate • Correct technique.',
        'violations': 'Common Issues',
        'violationsText':
            'Lifting excessive loads, twisting while lifting and carrying loads over unsafe distances.',
        'best': 'Best Practice',
        'bestText':
            'Eliminate or reduce manual handling by using mechanical assistance wherever reasonably practicable.',
        'reference': 'Reference',
        'referenceText':
            'Applicable workplace risk assessment and ergonomic requirements.',
      },

      'N': {
        'what': 'What is Near Miss Reporting?',
        'whatText':
            'A near miss is an event that could have resulted in injury, damage or loss but did not.',
        'purpose': 'Purpose',
        'purposeText':
            'To identify weaknesses before they result in actual incidents.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Encourage reporting, investigate significant near misses and implement corrective actions.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Everyone should report near misses without fear of blame or retaliation.',
        'checklist': 'Checklist',
        'checklistText':
            'Report • Investigate • Identify cause • Correct • Share lesson learned.',
        'violations': 'Common Issues',
        'violationsText':
            'Under-reporting, blaming workers and failing to close corrective actions.',
        'best': 'Best Practice',
        'bestText':
            'Treat near misses as valuable opportunities for prevention and learning.',
        'reference': 'Reference',
        'referenceText':
            'Applicable company incident and near-miss reporting procedures.',
      },

      'O': {
        'what': 'What are OSHA & ISO Standards?',
        'whatText':
            'OSHA regulations and ISO standards provide widely used approaches to occupational safety and health management.',
        'purpose': 'Purpose',
        'purposeText':
            'To support effective safety management, risk control and continual improvement.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Apply the standard or legal requirement relevant to the organisation and maintain documented processes where required.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Management must provide resources and HSE teams should monitor implementation.',
        'checklist': 'Checklist',
        'checklistText':
            'Legal register • Risk assessment • Training • Monitoring • Auditing • Corrective actions.',
        'violations': 'Common Issues',
        'violationsText':
            'Treating certification or standards as paperwork without effective implementation.',
        'best': 'Best Practice',
        'bestText':
            'Integrate safety standards into daily operations rather than treating them as separate paperwork.',
        'reference': 'Reference',
        'referenceText':
            'Applicable OSHA resources, ISO 45001 and UAE legal requirements.',
      },

      'P': {
        'what': 'What is PPE Compliance?',
        'whatText':
            'PPE compliance means selecting, providing, using and maintaining personal protective equipment appropriate to identified hazards.',
        'purpose': 'Purpose',
        'purposeText':
            'To provide additional protection when hazards cannot be adequately controlled through other measures.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'PPE should be suitable for the hazard, correctly fitted, maintained and used according to instructions.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Employers provide suitable PPE and workers use and maintain it correctly.',
        'checklist': 'Checklist',
        'checklistText':
            'Helmet • Safety footwear • Eye protection • Gloves • Hearing protection • Fall protection as applicable.',
        'violations': 'Common Issues',
        'violationsText':
            'Wrong PPE, damaged PPE, poor fit and failure to wear required PPE.',
        'best': 'Best Practice',
        'bestText':
            'Control hazards at source first and use PPE as the appropriate final layer of protection.',
        'reference': 'Reference',
        'referenceText':
            'Applicable ADPHC PPE requirements and project-specific PPE procedures.',
      },

      'Q': {
        'what': 'What is HSE Auditing?',
        'whatText':
            'An HSE audit is a systematic examination of safety management arrangements and compliance.',
        'purpose': 'Purpose',
        'purposeText':
            'To identify gaps, verify compliance and drive continual improvement.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Define scope, collect evidence, identify findings, assign corrective actions and verify closure.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Auditors should remain objective and base findings on evidence.',
        'checklist': 'Checklist',
        'checklistText':
            'Scope • Documents • Site inspection • Interviews • Findings • Corrective actions.',
        'violations': 'Common Issues',
        'violationsText':
            'Paper-only audits, weak evidence and corrective actions that are not closed.',
        'best': 'Best Practice',
        'bestText':
            'Use audit findings to identify systemic improvements, not just individual failures.',
        'reference': 'Reference',
        'referenceText':
            'Applicable company HSE audit procedures and OSH management requirements.',
      },

      'R': {
        'what': 'What is Risk Assessment?',
        'whatText':
            'Risk assessment is the process of identifying hazards, evaluating risks and determining suitable controls.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent harm by controlling risks before and during work.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Identify hazards, determine risk, implement controls and review the assessment when conditions change.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Competent personnel should conduct or support risk assessments with worker involvement where appropriate.',
        'checklist': 'Checklist',
        'checklistText':
            'Hazards • People at risk • Existing controls • Risk rating • Additional controls • Review date.',
        'violations': 'Common Issues',
        'violationsText':
            'Generic assessments, missing hazards and controls that are not implemented in practice.',
        'best': 'Best Practice',
        'bestText':
            'Use the hierarchy of controls and involve people who understand the actual task.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE OSH risk management requirements and company procedures.',
      },

      'S': {
        'what': 'What is Scaffolding Safety?',
        'whatText':
            'Scaffolding safety covers the safe design, erection, inspection, tagging, alteration and use of scaffolds.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent falls, scaffold collapse and falling-object incidents.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Competent erection, suitable foundations, proper access, guardrails, toe boards, inspection and safe loading.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Only authorised and competent personnel should erect, alter or inspect scaffolding as required.',
        'checklist': 'Checklist',
        'checklistText':
            'Foundation • Access • Guardrails • Toe boards • Platform • Inspection/tag • Safe load.',
        'violations': 'Common Issues',
        'violationsText':
            'Missing guardrails, unsafe access, damaged components, overloading and unauthorised alteration.',
        'best': 'Best Practice',
        'bestText':
            'Do not use scaffolding until it has been properly inspected and released for use according to the applicable system.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE/Abu Dhabi scaffolding requirements and project procedures.',
      },

      'T': {
        'what': 'What are Training & Induction?',
        'whatText':
            'Training and induction provide workers with the knowledge and information needed to work safely.',
        'purpose': 'Purpose',
        'purposeText':
            'To ensure workers understand site hazards, rules, emergency arrangements and safe work methods.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Provide appropriate induction, task-specific training and refresher training where required.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Management provides resources and supervisors ensure workers are competent for assigned tasks.',
        'checklist': 'Checklist',
        'checklistText':
            'Site induction • Task training • Competency • Attendance records • Refresher training.',
        'violations': 'Common Issues',
        'violationsText':
            'Untrained workers, expired competency and incomplete training records.',
        'best': 'Best Practice',
        'bestText':
            'Verify competence before assigning workers to safety-critical tasks.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE OSH and project training requirements.',
      },

      'U': {
        'what': 'What is UAE Labour Law?',
        'whatText':
            'UAE labour legislation establishes legal requirements governing employment relationships and worker protections.',
        'purpose': 'Purpose',
        'purposeText':
            'To establish legal protections and responsibilities within employment.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Employers and workers must comply with applicable UAE labour legislation and related regulations.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Organisations should maintain compliance with applicable legal requirements and communicate relevant workplace obligations.',
        'checklist': 'Checklist',
        'checklistText':
            'Legal requirements • Worker welfare • Working conditions • Records • HSE obligations.',
        'violations': 'Common Issues',
        'violationsText':
            'Failure to understand applicable legal requirements or maintain required records and controls.',
        'best': 'Best Practice',
        'bestText':
            'Always verify the latest official UAE legislation before making a legal compliance decision.',
        'reference': 'Reference',
        'referenceText':
            'UAE official labour legislation and Ministry of Human Resources and Emiratisation resources.',
      },

      'V': {
        'what': 'What are Ventilation & Confined Spaces?',
        'whatText':
            'Confined spaces may have limited entry or exit and can contain serious atmospheric or physical hazards.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent poisoning, oxygen deficiency, engulfment, fire, explosion and other confined-space incidents.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Risk assessment, permit controls where required, atmospheric testing, ventilation, isolation, communication and rescue arrangements.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Only trained and authorised personnel should enter where applicable, with appropriate supervision and rescue arrangements.',
        'checklist': 'Checklist',
        'checklistText':
            'Permit • Gas testing • Ventilation • Isolation • Communication • Attendant • Rescue plan.',
        'violations': 'Common Issues',
        'violationsText':
            'Entering without testing, inadequate ventilation, poor isolation and no rescue plan.',
        'best': 'Best Practice',
        'bestText':
            'Avoid entry where possible; where entry is necessary, implement all applicable controls before entry.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE OSH confined-space requirements and approved procedures.',
      },

      'W': {
        'what': 'What is Waste Management?',
        'whatText':
            'Waste management is the safe segregation, collection, storage, transport and disposal of workplace waste.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent pollution, injuries, fire hazards and unsafe working conditions.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Segregate waste, use suitable containers, maintain housekeeping and dispose of waste through approved methods.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Workers should segregate waste correctly and supervisors should monitor waste areas.',
        'checklist': 'Checklist',
        'checklistText':
            'Segregation • Containers • Labelling • Storage • Housekeeping • Approved disposal.',
        'violations': 'Common Issues',
        'violationsText':
            'Mixed waste, overflowing bins, unsafe storage and improper disposal.',
        'best': 'Best Practice',
        'bestText':
            'Reduce waste at source and maintain clear segregation and housekeeping arrangements.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE environmental and waste management requirements.',
      },

      'X': {
        'what': 'What is Radiation Safety?',
        'whatText':
            'Radiation safety controls exposure to ionising radiation and protects workers and the public.',
        'purpose': 'Purpose',
        'purposeText':
            'To keep radiation exposure as low as reasonably achievable and within applicable limits.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Controlled areas, authorised personnel, suitable shielding, monitoring, warning signs and approved procedures.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Only authorised and appropriately trained personnel should perform radiation-related work.',
        'checklist': 'Checklist',
        'checklistText':
            'Controlled area • Warning signs • Dosimetry • Shielding • Equipment checks • Authorisation.',
        'violations': 'Common Issues',
        'violationsText':
            'Unauthorised access, inadequate exclusion zones and failure to follow radiation procedures.',
        'best': 'Best Practice',
        'bestText':
            'Follow the approved radiation protection programme and applicable regulatory requirements.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE radiation protection and regulatory requirements.',
      },

      'Y': {
        'what': 'What is Yard & Traffic Safety?',
        'whatText':
            'Yard and traffic safety controls interaction between vehicles, mobile equipment and pedestrians.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent vehicle collisions, struck-by incidents and pedestrian injuries.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Traffic routes, speed controls, pedestrian segregation, reversing controls, signs and competent drivers.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Drivers must follow site traffic rules and pedestrians must use designated routes.',
        'checklist': 'Checklist',
        'checklistText':
            'Speed limits • Walkways • Barriers • Signage • Reversing controls • Vehicle inspection.',
        'violations': 'Common Issues',
        'violationsText':
            'Speeding, poor segregation, unsafe reversing and blocked pedestrian routes.',
        'best': 'Best Practice',
        'bestText':
            'Separate people and vehicles wherever reasonably practicable and control vehicle movements.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE traffic and workplace vehicle safety requirements.',
      },

      'Z': {
        'what': 'What is the Zero Accident Goal?',
        'whatText':
            'The zero-accident goal represents a commitment to preventing injuries and improving workplace safety continuously.',
        'purpose': 'Purpose',
        'purposeText':
            'To create a strong prevention-focused safety culture.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Leadership commitment, hazard identification, risk control, worker participation, reporting and continual improvement.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Everyone has a role in identifying hazards, following controls and reporting unsafe conditions.',
        'checklist': 'Checklist',
        'checklistText':
            'Leadership • Risk assessment • Training • Inspections • Reporting • Corrective actions.',
        'violations': 'Common Issues',
        'violationsText':
            'Production pressure, unsafe shortcuts, poor reporting culture and incomplete corrective actions.',
        'best': 'Best Practice',
        'bestText':
            'Focus on prevention, learning and continuous improvement rather than treating zero accidents as only a numerical target.',
        'reference': 'Reference',
        'referenceText':
            'Company HSE policy and applicable UAE occupational safety requirements.',
      },
    };
  }

  String _value(String key) {
    final item = details[letter];

    if (item == null) {
      return '';
    }

    return item[key] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 38,
                backgroundColor: Colors.blueAccent,
                child: Text(
                  letter,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Center(
              child: Text(
                desc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 20),

            _section('📖', _value('what'), _value('whatText')),
            _section('🎯', _value('purpose'), _value('purposeText')),
            _section('⚠️', _value('requirements'), _value('requirementsText')),
            _section('👷', _value('responsibilities'), _value('responsibilitiesText')),
            _section('📋', _value('checklist'), _value('checklistText')),
            _section('🚨', _value('violations'), _value('violationsText')),
            _section('✅', _value('best'), _value('bestText')),
            _section('📚', _value('reference'), _value('referenceText')),

            const SizedBox(height: 20),

            Card(
              color: Colors.orange.shade50,
              child: const Padding(
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: Colors.orange),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Important: This information is for HSE awareness and guidance. Always verify the latest applicable UAE legislation, authority requirements, Codes of Practice and project procedures before making compliance decisions.',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section(
    String icon,
    String heading,
    String content,
  ) {
    if (heading.isEmpty || content.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  icon,
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    heading,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
