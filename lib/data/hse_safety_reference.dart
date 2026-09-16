import 'package:flutter/material.dart';

import '../models/reference_topic.dart';
import '../models/guideline_category.dart';

const List<ReferenceTopic> hseSafetyReferences = [
  // ============================================================
  // 1. SAFETY OBSERVATION
  // ============================================================
  ReferenceTopic(
    id: 'safety_observation',
    title: 'Safety Observation',
    shortTitle: 'Safety Observation',
    category: 'HSE Reference',
    authority: 'HSE Best Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for identifying and reporting safe acts, unsafe acts and unsafe conditions through proactive workplace safety observations.',
    keyRequirements: [
      'Conduct regular safety observations at work locations.',
      'Identify both safe and unsafe behaviours.',
      'Identify unsafe conditions before they cause incidents.',
      'Record observations accurately.',
      'Discuss immediate corrective actions with responsible persons.',
      'Track significant observations until close-out.',
      'Use observation trends to identify recurring risks.',
    ],
    safetyControls: [
      'Safety observation cards',
      'Workplace inspections',
      'Behaviour observation',
      'Hazard identification',
      'Immediate corrective action',
      'Trend analysis',
      'Action tracking',
    ],
    responsibilities: [
      'Management supports proactive safety observation programmes.',
      'Supervisors conduct observations and correct unsafe conditions.',
      'Workers report hazards and participate in safety observations.',
      'HSE personnel monitor trends and verify corrective actions.',
    ],
    references: [
      'Company HSE Management System',
      'Safety Observation Procedure',
      'Project HSE Plan',
      'Applicable UAE occupational safety requirements',
    ],
  ),

  // ============================================================
  // 2. NEAR MISS REPORTING
  // ============================================================
  ReferenceTopic(
    id: 'near_miss_reporting',
    title: 'Near Miss Reporting',
    shortTitle: 'Near Miss',
    category: 'HSE Reference',
    authority: 'HSE Best Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for reporting events that could have caused injury, illness, property damage, environmental harm or other loss but did not result in significant consequences.',
    keyRequirements: [
      'Encourage workers to report near misses promptly.',
      'Record the circumstances and potential consequences.',
      'Control immediate hazards.',
      'Investigate significant near misses.',
      'Identify underlying and root causes where appropriate.',
      'Implement corrective and preventive actions.',
      'Share lessons learned with relevant workers.',
      'Monitor recurring near-miss trends.',
    ],
    safetyControls: [
      'Near-miss reporting system',
      'Immediate hazard control',
      'Incident investigation',
      'Root cause analysis',
      'Corrective action tracking',
      'Lessons learned',
      'Trend analysis',
    ],
    responsibilities: [
      'Workers report near misses without unnecessary delay.',
      'Supervisors ensure the area is made safe.',
      'HSE personnel coordinate investigation and trend analysis.',
      'Management ensures corrective actions are implemented.',
    ],
    references: [
      'Company Incident Reporting Procedure',
      'Company HSE Management System',
      'Project HSE Plan',
      'Applicable UAE HSE requirements',
    ],
  ),

  // ============================================================
  // 3. STOP WORK AUTHORITY
  // ============================================================
  ReferenceTopic(
    id: 'stop_work_authority',
    title: 'Stop Work Authority',
    shortTitle: 'Stop Work Authority',
    category: 'HSE Reference',
    authority: 'HSE Best Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance supporting workers and supervisors in stopping or suspending work when an immediate or uncontrolled safety risk is identified.',
    keyRequirements: [
      'Workers should raise concerns about unsafe work.',
      'Stop or suspend work when an immediate serious risk exists.',
      'Move people away from uncontrolled hazards where necessary.',
      'Notify the responsible supervisor.',
      'Assess and control the identified hazard.',
      'Resume work only after appropriate controls are established.',
      'Record significant stop-work interventions where required.',
    ],
    safetyControls: [
      'Stop-work procedure',
      'Hazard assessment',
      'Immediate area control',
      'Supervisor notification',
      'Corrective action',
      'Risk reassessment',
      'Management review',
    ],
    responsibilities: [
      'Workers raise concerns when unsafe conditions are identified.',
      'Supervisors respond promptly to stop-work concerns.',
      'HSE personnel support hazard assessment and control verification.',
      'Management promotes a positive safety culture.',
    ],
    references: [
      'Company Stop Work Authority Procedure',
      'Company HSE Management System',
      'Project HSE Plan',
      'Applicable UAE occupational safety requirements',
    ],
  ),

  // ============================================================
  // 4. SAFETY INDUCTION
  // ============================================================
  ReferenceTopic(
    id: 'safety_induction',
    title: 'Safety Induction',
    shortTitle: 'Safety Induction',
    category: 'HSE Reference',
    authority: 'HSE Best Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for providing workers, contractors and visitors with essential workplace safety information before they enter or begin work at a site.',
    keyRequirements: [
      'Provide site-specific safety induction before work starts.',
      'Explain site hazards and control measures.',
      'Explain emergency arrangements and assembly points.',
      'Explain PPE requirements.',
      'Explain prohibited activities and site rules.',
      'Explain incident and hazard reporting arrangements.',
      'Maintain induction records where required.',
      'Provide additional induction when significant site conditions change.',
    ],
    safetyControls: [
      'Site induction programme',
      'Induction checklist',
      'PPE briefing',
      'Emergency briefing',
      'Site rules',
      'Competency verification',
      'Attendance records',
    ],
    responsibilities: [
      'Management provides an effective induction programme.',
      'Supervisors ensure workers understand site requirements.',
      'Workers attend induction and follow site rules.',
      'HSE personnel coordinate or verify induction activities.',
    ],
    references: [
      'Company HSE Management System',
      'Site HSE Plan',
      'Site Induction Procedure',
      'Applicable UAE occupational safety requirements',
    ],
  ),

  // ============================================================
  // 5. COMPETENCY & SAFETY TRAINING
  // ============================================================
  ReferenceTopic(
    id: 'competency_training',
    title: 'Competency & Safety Training',
    shortTitle: 'Competency & Training',
    category: 'HSE Reference',
    authority: 'HSE Best Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for ensuring workers have the knowledge, skills, training and experience required to perform their assigned tasks safely.',
    keyRequirements: [
      'Identify competency requirements for safety-critical tasks.',
      'Provide appropriate training before assigning workers to relevant activities.',
      'Verify competency where required.',
      'Maintain training and competency records.',
      'Provide refresher training where necessary.',
      'Provide additional training following significant changes or incidents.',
      'Prevent unqualified personnel from performing restricted tasks.',
    ],
    safetyControls: [
      'Training matrix',
      'Competency assessment',
      'Induction',
      'Refresher training',
      'Authorisation system',
      'Training records',
      'Toolbox talks',
    ],
    responsibilities: [
      'Management provides adequate training resources.',
      'Supervisors verify worker competency before task assignment.',
      'Workers attend required training and follow instructions.',
      'HSE personnel monitor training and competency requirements.',
    ],
    references: [
      'Company Training and Competency Procedure',
      'Company HSE Management System',
      'Project HSE Plan',
      'Applicable UAE competency requirements',
    ],
  ),

  // ============================================================
  // 6. HSE INSPECTIONS
  // ============================================================
  ReferenceTopic(
    id: 'safety_inspection',
    title: 'HSE Inspections',
    shortTitle: 'HSE Inspections',
    category: 'HSE Reference',
    authority: 'HSE Best Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for systematic workplace inspections to identify hazards, verify controls and improve safety performance.',
    keyRequirements: [
      'Plan inspections based on workplace risks.',
      'Inspect work areas, equipment and activities.',
      'Identify unsafe conditions and unsafe acts.',
      'Record inspection findings.',
      'Assign corrective actions to responsible persons.',
      'Set realistic target completion dates.',
      'Verify corrective actions before close-out.',
      'Analyse recurring findings and trends.',
    ],
    safetyControls: [
      'Inspection checklist',
      'Workplace inspection',
      'Safety walk',
      'Corrective action register',
      'Action close-out',
      'Trend analysis',
      'Management review',
    ],
    responsibilities: [
      'Management participates in planned safety inspections.',
      'Supervisors correct deficiencies in their work areas.',
      'Workers cooperate with inspection activities.',
      'HSE personnel conduct or coordinate formal HSE inspections.',
    ],
    references: [
      'Company HSE Inspection Procedure',
      'Company HSE Management System',
      'Project HSE Plan',
      'Applicable UAE HSE requirements',
    ],
  ),

  // ============================================================
  // 7. SAFETY SIGNS & SIGNALS
  // ============================================================
  ReferenceTopic(
    id: 'safety_signage',
    title: 'Safety Signs & Signals',
    shortTitle: 'Safety Signs',
    category: 'HSE Reference',
    authority: 'HSE Best Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for using appropriate safety signs, warning notices, mandatory signs, prohibition signs and emergency information to communicate workplace hazards and controls.',
    keyRequirements: [
      'Provide suitable safety signs where hazards require visual communication.',
      'Use clear and understandable signs.',
      'Position signs where they can be easily seen.',
      'Maintain signs in good condition.',
      'Remove obsolete or misleading signs.',
      'Use appropriate emergency and evacuation signage.',
      'Ensure workers understand important safety signs and signals.',
    ],
    safetyControls: [
      'Warning signs',
      'Mandatory signs',
      'Prohibition signs',
      'Emergency signs',
      'Fire safety signs',
      'Barricades',
      'Warning tape',
      'Safety notices',
    ],
    responsibilities: [
      'Management provides suitable safety signage.',
      'Supervisors maintain signs in work areas.',
      'Workers follow safety signs and instructions.',
      'HSE personnel verify signage requirements during inspections.',
    ],
    references: [
      'Applicable UAE safety signage requirements',
      'Company HSE Management System',
      'Project HSE Plan',
      'Applicable international signage standards',
    ],
  ),

  // ============================================================
  // 8. BARRICADING & EXCLUSION ZONES
  // ============================================================
  ReferenceTopic(
    id: 'barricading_exclusion_zones',
    title: 'Barricading & Exclusion Zones',
    shortTitle: 'Barricading',
    category: 'HSE Reference',
    authority: 'HSE Best Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for establishing and maintaining physical or visual barriers around hazardous areas, lifting operations, excavations, work at height and other restricted zones.',
    keyRequirements: [
      'Identify areas requiring restricted access.',
      'Establish suitable exclusion zones before hazardous work begins.',
      'Use appropriate barriers and warning signs.',
      'Prevent unauthorised persons from entering restricted areas.',
      'Maintain adequate access and emergency routes.',
      'Inspect barricades regularly.',
      'Remove barricades only when the hazard has been eliminated or controlled.',
    ],
    safetyControls: [
      'Rigid barricades',
      'Warning tape',
      'Safety cones',
      'Warning signs',
      'Exclusion zones',
      'Access control',
      'Banksman',
      'Physical barriers',
    ],
    responsibilities: [
      'Supervisors establish suitable exclusion zones.',
      'Workers respect restricted areas.',
      'HSE personnel verify barricading arrangements.',
      'Management provides appropriate barrier equipment.',
    ],
    references: [
      'Company Barricading Procedure',
      'Project HSE Plan',
      'Applicable UAE construction safety requirements',
      'Task-specific risk assessment',
    ],
  ),

  // ============================================================
  // 9. GOOD HOUSEKEEPING
  // ============================================================
  ReferenceTopic(
    id: 'housekeeping_reference',
    title: 'Good Housekeeping',
    shortTitle: 'Housekeeping',
    category: 'HSE Reference',
    authority: 'HSE Best Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Practical HSE reference for maintaining clean, organised and obstruction-free work areas to prevent slips, trips, falls, fire risks and material-handling incidents.',
    keyRequirements: [
      'Keep work areas clean and organised.',
      'Remove waste regularly.',
      'Keep walkways and emergency routes clear.',
      'Store tools and materials safely.',
      'Control cables, hoses and temporary services.',
      'Clean spills immediately.',
      'Maintain access to fire and emergency equipment.',
    ],
    safetyControls: [
      'Daily housekeeping',
      'Waste segregation',
      'Material storage',
      'Cable management',
      'Spill control',
      'Access route inspection',
      'Housekeeping audits',
    ],
    responsibilities: [
      'Workers maintain their immediate work areas.',
      'Supervisors enforce housekeeping standards.',
      'Contractors maintain their designated areas.',
      'HSE personnel inspect housekeeping conditions.',
    ],
    references: [
      'Company Housekeeping Procedure',
      'Project HSE Plan',
      'Company HSE Management System',
      'Applicable UAE workplace safety requirements',
    ],
  ),

  // ============================================================
  // 10. ENVIRONMENTAL PROTECTION
  // ============================================================
  ReferenceTopic(
    id: 'environmental_protection',
    title: 'Environmental Protection',
    shortTitle: 'Environmental Safety',
    category: 'HSE Reference',
    authority: 'UAE Environmental / HSE Requirements',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'General HSE reference for controlling workplace activities that may cause pollution, waste, spills, emissions or other environmental impacts.',
    keyRequirements: [
      'Identify environmental aspects and potential impacts.',
      'Prevent uncontrolled releases and spills.',
      'Store hazardous materials appropriately.',
      'Manage waste according to applicable requirements.',
      'Segregate waste where required.',
      'Maintain spill response arrangements.',
      'Report significant environmental incidents.',
      'Comply with applicable environmental requirements.',
    ],
    safetyControls: [
      'Environmental aspect assessment',
      'Waste management',
      'Spill kits',
      'Chemical storage',
      'Waste segregation',
      'Environmental inspections',
      'Emergency response',
      'Incident reporting',
    ],
    responsibilities: [
      'Management provides environmental controls and resources.',
      'Supervisors implement environmental requirements at work locations.',
      'Workers prevent spills and dispose of waste correctly.',
      'HSE/environment personnel monitor environmental compliance.',
    ],
    references: [
      'Applicable UAE environmental requirements',
      'Company Environmental Management Procedure',
      'Project Environmental Management Plan',
      'Company HSE Management System',
    ],
  ),

  // ============================================================
  // 11. OCCUPATIONAL HEALTH
  // ============================================================
  ReferenceTopic(
    id: 'occupational_health',
    title: 'Occupational Health',
    shortTitle: 'Occupational Health',
    category: 'HSE Reference',
    authority: 'UAE Occupational HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'General reference for preventing work-related health risks arising from exposure to physical, chemical, biological, ergonomic and psychosocial hazards.',
    keyRequirements: [
      'Identify occupational health hazards.',
      'Assess worker exposure where appropriate.',
      'Implement suitable exposure controls.',
      'Provide occupational health information and training.',
      'Arrange health surveillance where required.',
      'Maintain appropriate hygiene facilities.',
      'Monitor occupational health trends.',
      'Review controls when exposure conditions change.',
    ],
    safetyControls: [
      'Exposure assessment',
      'Health surveillance',
      'Industrial hygiene',
      'Ventilation',
      'PPE',
      'Ergonomic controls',
      'Hygiene facilities',
      'Health awareness training',
    ],
    responsibilities: [
      'Management provides suitable occupational health controls.',
      'Supervisors implement workplace health requirements.',
      'Workers follow health and hygiene procedures.',
      'HSE and occupational health professionals monitor relevant risks.',
    ],
    references: [
      'UAE occupational health and safety requirements',
      'Company Occupational Health Procedure',
      'Company HSE Management System',
      'Applicable occupational health guidance',
    ],
  ),

  // ============================================================
  // 12. FIRST AID
  // ============================================================
  ReferenceTopic(
    id: 'first_aid',
    title: 'First Aid & Medical Response',
    shortTitle: 'First Aid',
    category: 'HSE Reference',
    authority: 'UAE HSE / Applicable Authority',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for providing appropriate first-aid arrangements, trained personnel, emergency communication and access to medical assistance.',
    keyRequirements: [
      'Assess workplace first-aid requirements.',
      'Provide suitable first-aid equipment.',
      'Provide trained first-aiders where required.',
      'Keep first-aid facilities accessible.',
      'Maintain emergency contact information.',
      'Check and replenish first-aid supplies.',
      'Provide prompt medical assistance for serious injuries.',
      'Record first-aid cases according to company requirements.',
    ],
    safetyControls: [
      'First-aid kits',
      'Trained first-aiders',
      'Emergency contact numbers',
      'Medical facilities',
      'Emergency transport arrangements',
      'First-aid inspection',
      'Incident reporting',
    ],
    responsibilities: [
      'Management provides appropriate first-aid resources.',
      'Supervisors ensure emergency arrangements are understood.',
      'Workers report injuries promptly.',
      'First-aiders provide assistance within their training and competence.',
      'HSE personnel monitor first-aid arrangements.',
    ],
    references: [
      'UAE occupational health and safety requirements',
      'Company First Aid Procedure',
      'Site Emergency Response Plan',
      'Applicable authority requirements',
    ],
  ),

  // ============================================================
  // 13. EMERGENCY DRILLS
  // ============================================================
  ReferenceTopic(
    id: 'emergency_drills',
    title: 'Emergency Drills & Exercises',
    shortTitle: 'Emergency Drills',
    category: 'HSE Reference',
    authority: 'HSE Best Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for testing emergency response arrangements through planned drills and exercises and using the results to improve emergency preparedness.',
    keyRequirements: [
      'Identify emergency scenarios requiring drills.',
      'Plan drills according to workplace risks.',
      'Brief relevant emergency response personnel.',
      'Test alarm, communication and evacuation arrangements.',
      'Account for personnel at assembly points.',
      'Record drill performance and observations.',
      'Identify corrective actions.',
      'Review and improve the emergency response plan.',
    ],
    safetyControls: [
      'Emergency drills',
      'Evacuation exercises',
      'Alarm testing',
      'Muster point checks',
      'Emergency communication',
      'Drill evaluation',
      'Corrective action tracking',
    ],
    responsibilities: [
      'Management provides resources for emergency exercises.',
      'Emergency teams perform assigned response roles.',
      'Supervisors account for workers.',
      'Workers follow drill instructions.',
      'HSE personnel coordinate evaluation and improvement actions.',
    ],
    references: [
      'Site Emergency Response Plan',
      'Company Emergency Management Procedure',
      'Applicable Civil Defence requirements',
      'Applicable UAE emergency preparedness requirements',
    ],
  ),

  // ============================================================
  // 14. SAFETY CULTURE
  // ============================================================
  ReferenceTopic(
    id: 'safety_culture',
    title: 'Safety Culture',
    shortTitle: 'Safety Culture',
    category: 'HSE Reference',
    authority: 'HSE Best Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Reference guidance for developing a workplace culture where management and workers actively demonstrate commitment to safety, reporting and continual improvement.',
    keyRequirements: [
      'Demonstrate visible management commitment to safety.',
      'Encourage open reporting of hazards and near misses.',
      'Avoid discouraging good-faith safety reporting.',
      'Promote worker involvement in safety decisions.',
      'Recognise positive safety behaviour.',
      'Learn from incidents and observations.',
      'Communicate safety expectations consistently.',
      'Continuously improve HSE performance.',
    ],
    safetyControls: [
      'Leadership safety walks',
      'Worker engagement',
      'Safety meetings',
      'Hazard reporting',
      'Near-miss reporting',
      'Lessons learned',
      'Safety campaigns',
      'HSE performance review',
    ],
    responsibilities: [
      'Management demonstrates leadership and provides resources.',
      'Supervisors promote safe behaviour and worker participation.',
      'Workers actively contribute to workplace safety.',
      'HSE personnel support continual improvement and safety awareness.',
    ],
    references: [
      'Company HSE Management System',
      'Project HSE Plan',
      'Safety Culture Programme',
      'Applicable UAE occupational safety requirements',
    ],
  ),

  // ============================================================
  // 15. CODE OF PRACTICE
  // ============================================================
  ReferenceTopic(
    id: 'code_of_practice',
    title: 'Code of Practice',
    shortTitle: 'Code of Practice',
    category: 'HSE Reference',
    authority: 'UAE HSE / Applicable Authority',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'General reference for applying recognised Codes of Practice, technical guidance and approved procedures when planning and controlling workplace activities.',
    keyRequirements: [
      'Identify the applicable Code of Practice for the activity.',
      'Review requirements before work begins.',
      'Apply relevant control measures.',
      'Ensure workers understand applicable requirements.',
      'Use approved procedures and risk assessments.',
      'Review requirements when work conditions change.',
      'Maintain relevant records and documentation.',
    ],
    safetyControls: [
      'Applicable Code of Practice',
      'Risk assessment',
      'Method statement',
      'Permit to work',
      'Competency verification',
      'Inspection',
      'Monitoring',
    ],
    responsibilities: [
      'Management provides applicable standards and resources.',
      'Supervisors ensure work follows approved requirements.',
      'Workers follow applicable procedures and controls.',
      'HSE personnel verify compliance through inspections and audits.',
    ],
    references: [
      'Applicable UAE Codes of Practice',
      'Authority requirements',
      'Company HSE Management System',
      'Project HSE Plan',
    ],
  ),

  // ============================================================
  // 16. EXCAVATION SAFETY
  // ============================================================
  ReferenceTopic(
    id: 'excavation_safety',
    title: 'Excavation Safety',
    shortTitle: 'Excavation',
    category: 'HSE Reference',
    authority: 'UAE Construction HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for safely planning, preparing and controlling excavation and trenching activities to prevent collapse, falls, utility strikes and other hazards.',
    keyRequirements: [
      'Obtain required permits and approvals before excavation.',
      'Identify underground services before breaking ground.',
      'Assess soil and ground conditions.',
      'Provide suitable shoring, benching or sloping where required.',
      'Provide safe access and egress.',
      'Keep spoil and materials away from excavation edges.',
      'Protect excavations with suitable barricades and warning signs.',
      'Inspect excavations before work and after significant changes.',
      'Prevent unauthorised access to open excavations.',
    ],
    safetyControls: [
      'Excavation permit',
      'Utility detection',
      'Shoring',
      'Benching',
      'Sloping',
      'Edge protection',
      'Safe access',
      'Barricading',
      'Excavation inspection',
    ],
    responsibilities: [
      'Management provides competent resources and equipment.',
      'Supervisors verify excavation controls before work starts.',
      'Workers follow excavation procedures and report unsafe conditions.',
      'HSE personnel inspect and monitor excavation safety.',
    ],
    references: [
      'Applicable UAE excavation requirements',
      'Project Excavation Procedure',
      'Approved Risk Assessment and Method Statement',
      'Company HSE Management System',
    ],
  ),

  // ============================================================
  // 17. SCAFFOLDING SAFETY
  // ============================================================
  ReferenceTopic(
    id: 'scaffolding_safety',
    title: 'Scaffolding Safety',
    shortTitle: 'Scaffolding',
    category: 'HSE Reference',
    authority: 'UAE Construction HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for safe erection, modification, inspection, use and dismantling of scaffolding systems.',
    keyRequirements: [
      'Scaffolding must be erected by competent persons.',
      'Use suitable and properly maintained components.',
      'Provide stable foundations and adequate support.',
      'Provide safe access and egress.',
      'Install required guardrails, midrails and toe boards.',
      'Do not exceed the scaffold design load.',
      'Inspect scaffolding before use and after significant changes or adverse conditions.',
      'Use appropriate scaffold tagging or status identification.',
      'Do not alter scaffolding without authorisation.',
    ],
    safetyControls: [
      'Competent scaffolders',
      'Scaffold inspection',
      'Guardrails',
      'Toe boards',
      'Safe access',
      'Scaffold tags',
      'Base plates',
      'Load control',
    ],
    responsibilities: [
      'Management provides competent scaffold personnel.',
      'Supervisors ensure scaffolds are suitable for the intended work.',
      'Workers use scaffolding according to site requirements.',
      'HSE personnel verify inspection and tagging arrangements.',
    ],
    references: [
      'Applicable UAE scaffolding requirements',
      'Approved Scaffold Procedure',
      'Project HSE Plan',
      'Manufacturer instructions',
    ],
  ),

  // ============================================================
  // 18. WORKING AT HEIGHT
  // ============================================================
  ReferenceTopic(
    id: 'working_at_height',
    title: 'Working at Height',
    shortTitle: 'Working at Height',
    category: 'HSE Reference',
    authority: 'UAE HSE / Construction Safety Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for preventing falls of persons and materials during work at height through suitable planning, access systems, edge protection and fall protection.',
    keyRequirements: [
      'Plan work at height before starting the task.',
      'Avoid work at height where reasonably practicable.',
      'Use suitable access equipment.',
      'Provide guardrails and edge protection where required.',
      'Use suitable fall protection systems when necessary.',
      'Inspect ladders, scaffolds and access equipment before use.',
      'Secure tools and materials against falling.',
      'Provide suitable rescue arrangements where fall arrest systems are used.',
    ],
    safetyControls: [
      'Risk assessment',
      'Edge protection',
      'Guardrails',
      'Fall arrest system',
      'Fall restraint system',
      'Safety harness',
      'Scaffolding',
      'MEWP',
      'Tool lanyards',
    ],
    responsibilities: [
      'Management provides suitable work-at-height equipment.',
      'Supervisors ensure controls are established before work starts.',
      'Workers use fall protection correctly.',
      'HSE personnel verify work-at-height arrangements.',
    ],
    references: [
      'Applicable UAE work-at-height requirements',
      'Company Working at Height Procedure',
      'Project HSE Plan',
      'Approved Risk Assessment and Method Statement',
    ],
  ),

  // ============================================================
  // 19. POWER TOOLS SAFETY
  // ============================================================
  ReferenceTopic(
    id: 'power_tools_safety',
    title: 'Power Tools Safety',
    shortTitle: 'Power Tools',
    category: 'HSE Reference',
    authority: 'HSE Best Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for the safe selection, inspection, operation and maintenance of portable and fixed power tools.',
    keyRequirements: [
      'Use the correct tool for the task.',
      'Inspect tools before use.',
      'Use guards and safety devices correctly.',
      'Ensure electrical tools are suitable and properly maintained.',
      'Use appropriate PPE.',
      'Remove damaged tools from service.',
      'Keep hands and body parts away from moving components.',
      'Follow manufacturer instructions.',
      'Only competent workers should operate specialised tools.',
    ],
    safetyControls: [
      'Pre-use inspection',
      'Tool guards',
      'Electrical inspection',
      'PPE',
      'Tool maintenance',
      'Competency verification',
      'Manufacturer instructions',
      'Defective tool tagging',
    ],
    responsibilities: [
      'Management provides suitable and maintained tools.',
      'Supervisors verify tools are suitable for the task.',
      'Workers inspect tools before use.',
      'HSE personnel monitor tool safety arrangements.',
    ],
    references: [
      'Company Power Tools Procedure',
      'Manufacturer instructions',
      'Applicable UAE HSE requirements',
      'Project HSE Plan',
    ],
  ),

  // ============================================================
  // 20. FORMWORK SAFETY
  // ============================================================
  ReferenceTopic(
    id: 'formwork_safety',
    title: 'Formwork Safety',
    shortTitle: 'Formwork',
    category: 'HSE Reference',
    authority: 'UAE Construction HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for safe design, erection, inspection, use and dismantling of formwork and falsework systems used in concrete construction.',
    keyRequirements: [
      'Use an approved formwork design where required.',
      'Ensure formwork is erected by competent personnel.',
      'Verify foundations and supports are adequate.',
      'Check alignment, stability and connections.',
      'Provide safe access and working platforms.',
      'Protect workers from falls and falling objects.',
      'Inspect formwork before concrete placement.',
      'Do not overload formwork.',
      'Follow an approved striking and dismantling sequence.',
    ],
    safetyControls: [
      'Approved design',
      'Temporary works inspection',
      'Adequate supports',
      'Bracing',
      'Edge protection',
      'Safe access',
      'Load control',
      'Pre-pour inspection',
      'Controlled dismantling',
    ],
    responsibilities: [
      'Management ensures competent design and construction resources.',
      'Supervisors verify formwork before concrete placement.',
      'Workers follow approved erection and dismantling procedures.',
      'HSE personnel monitor formwork safety controls.',
    ],
    references: [
      'Approved Formwork Design',
      'Temporary Works Procedure',
      'Project HSE Plan',
      'Applicable UAE construction requirements',
    ],
  ),

  // ============================================================
  // 21. PERMIT TO WORK
  // ============================================================
  ReferenceTopic(
    id: 'permit_to_work',
    title: 'Permit to Work (PTW)',
    shortTitle: 'Permit to Work',
    category: 'HSE Reference',
    authority: 'HSE Best Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for controlling high-risk activities through a formal Permit to Work system that identifies hazards, precautions, responsibilities and work boundaries.',
    keyRequirements: [
      'Identify activities requiring a permit.',
      'Complete required risk assessments before permit issue.',
      'Define the work scope and location clearly.',
      'Specify required safety controls and precautions.',
      'Ensure permits are authorised by competent persons.',
      'Display or maintain permits as required.',
      'Suspend permits when conditions change.',
      'Close permits after work is completed and the area is safe.',
    ],
    safetyControls: [
      'Permit to Work',
      'Risk assessment',
      'Isolation',
      'Gas testing',
      'LOTO',
      'Authorisation',
      'Permit display',
      'Permit close-out',
    ],
    responsibilities: [
      'Management establishes an effective PTW system.',
      'Permit issuers verify required controls.',
      'Supervisors ensure work follows permit conditions.',
      'Workers comply with permit requirements.',
      'HSE personnel audit and monitor the PTW system.',
    ],
    references: [
      'Company Permit to Work Procedure',
      'Project HSE Plan',
      'Task-specific Risk Assessment',
      'Applicable UAE HSE requirements',
    ],
  ),

  // ============================================================
  // 22. WORKING IN HOT & HUMID CLIMATE
  // ============================================================
  ReferenceTopic(
    id: 'hot_humid_climate',
    title: 'Working in Hot & Humid Climate',
    shortTitle: 'Heat Stress',
    category: 'HSE Reference',
    authority: 'UAE HSE / Occupational Health Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for preventing heat stress and heat-related illness when workers are exposed to high temperatures, humidity and physically demanding work.',
    keyRequirements: [
      'Assess heat stress risks before work.',
      'Provide adequate cool drinking water.',
      'Provide suitable shaded or cooled rest areas.',
      'Plan work and rest periods according to applicable requirements.',
      'Use acclimatisation arrangements for workers where required.',
      'Train workers to recognise heat stress symptoms.',
      'Provide appropriate supervision during hot conditions.',
      'Stop or modify work when heat conditions become unsafe.',
    ],
    safetyControls: [
      'Heat stress assessment',
      'Drinking water',
      'Shaded rest areas',
      'Work-rest programme',
      'Acclimatisation',
      'Heat stress training',
      'Weather monitoring',
      'Emergency response',
    ],
    responsibilities: [
      'Management provides suitable heat-stress controls.',
      'Supervisors monitor workers and enforce work-rest arrangements.',
      'Workers drink water regularly and report symptoms.',
      'HSE personnel monitor heat-stress prevention measures.',
    ],
    references: [
      'Applicable UAE heat-stress requirements',
      'Company Heat Stress Management Procedure',
      'Project HSE Plan',
      'Applicable occupational health guidance',
    ],
  ),

  // ============================================================
  // 23. CONFINED SPACE
  // ============================================================
  ReferenceTopic(
    id: 'confined_space',
    title: 'Confined Space Safety',
    shortTitle: 'Confined Space',
    category: 'HSE Reference',
    authority: 'HSE Best Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for safely planning and controlling entry into confined spaces where hazardous atmospheres, engulfment, restricted access or other serious risks may exist.',
    keyRequirements: [
      'Identify and assess confined spaces before entry.',
      'Avoid entry where the task can be completed from outside.',
      'Use an approved confined-space entry permit where required.',
      'Test the atmosphere before and during entry as appropriate.',
      'Provide ventilation where required.',
      'Isolate hazardous energy and process sources.',
      'Provide a trained standby attendant.',
      'Establish an emergency rescue plan before entry.',
      'Use competent and authorised entrants.',
    ],
    safetyControls: [
      'Confined-space permit',
      'Gas testing',
      'Ventilation',
      'Isolation',
      'Standby attendant',
      'Communication',
      'Rescue equipment',
      'Emergency rescue plan',
      'PPE',
    ],
    responsibilities: [
      'Management provides suitable confined-space resources.',
      'Supervisors verify permits and controls before entry.',
      'Workers follow confined-space entry requirements.',
      'HSE personnel verify atmospheric testing and rescue arrangements.',
    ],
    references: [
      'Company Confined Space Procedure',
      'Permit to Work Procedure',
      'Approved Risk Assessment',
      'Applicable UAE HSE requirements',
    ],
  ),

  // ============================================================
  // 24. WORKING NEAR LIVE ROADS
  // ============================================================
  ReferenceTopic(
    id: 'working_near_live_roads',
    title: 'Working Near Live Roads',
    shortTitle: 'Live Road Safety',
    category: 'HSE Reference',
    authority: 'UAE Road & Construction Safety Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for protecting workers, road users and the public when construction or maintenance activities are carried out adjacent to live traffic.',
    keyRequirements: [
      'Prepare an approved traffic management arrangement.',
      'Obtain required road-work permits and approvals.',
      'Separate workers from live traffic using suitable barriers.',
      'Provide appropriate signs, cones and warning devices.',
      'Maintain safe pedestrian and vehicle routes.',
      'Use trained traffic marshals or banksmen where required.',
      'Provide suitable lighting and visibility for night work.',
      'Inspect traffic controls regularly.',
      'Keep emergency access routes available.',
    ],
    safetyControls: [
      'Traffic management plan',
      'Road-work permit',
      'Rigid barriers',
      'Traffic cones',
      'Warning signs',
      'Traffic marshals',
      'Banksman',
      'Lighting',
      'Speed control',
    ],
    responsibilities: [
      'Management obtains required approvals and provides traffic controls.',
      'Supervisors maintain safe work-zone arrangements.',
      'Workers remain within designated safe areas.',
      'Traffic marshals control vehicle and pedestrian movements.',
      'HSE personnel inspect work-zone safety.',
    ],
    references: [
      'Applicable UAE road authority requirements',
      'Approved Traffic Management Plan',
      'Project HSE Plan',
      'Road-work permit requirements',
    ],
  ),

  // ============================================================
  // 25. CONCRETING SAFETY
  // ============================================================
  ReferenceTopic(
    id: 'concreting_safety',
    title: 'Concreting Safety',
    shortTitle: 'Concreting',
    category: 'HSE Reference',
    authority: 'UAE Construction HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for safely carrying out concrete delivery, pumping, placing, vibrating and finishing activities.',
    keyRequirements: [
      'Plan concrete placement before work starts.',
      'Inspect concrete pumps, hoses and equipment.',
      'Ensure formwork and supports are ready for concrete loading.',
      'Control vehicle and concrete mixer movements.',
      'Maintain safe communication between operators and workers.',
      'Keep workers clear of uncontrolled hose movement.',
      'Use suitable PPE to protect against cement exposure.',
      'Control slips, trips and wet concrete hazards.',
      'Follow approved concrete placement procedures.',
    ],
    safetyControls: [
      'Pre-pour inspection',
      'Concrete pump inspection',
      'Hose control',
      'Traffic control',
      'PPE',
      'Communication',
      'Formwork inspection',
      'Safe access',
      'Housekeeping',
    ],
    responsibilities: [
      'Management provides suitable concrete equipment and resources.',
      'Supervisors coordinate concrete placement activities.',
      'Workers follow safe concreting procedures.',
      'HSE personnel monitor concrete-pour safety.',
    ],
    references: [
      'Approved Concrete Pour Procedure',
      'Formwork Inspection Records',
      'Project HSE Plan',
      'Applicable UAE construction safety requirements',
    ],
  ),

  // ============================================================
  // 26. WORKER WELFARE
  // ============================================================
  ReferenceTopic(
    id: 'worker_welfare',
    title: 'Worker Welfare',
    shortTitle: 'Worker Welfare',
    category: 'HSE Reference',
    authority: 'UAE Occupational HSE Requirements',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'General guidance for providing suitable welfare facilities and working conditions that support worker health, hygiene, dignity and wellbeing.',
    keyRequirements: [
      'Provide suitable drinking water.',
      'Provide clean toilets and washing facilities.',
      'Provide suitable rest areas.',
      'Maintain adequate cleanliness and hygiene.',
      'Provide appropriate changing or storage facilities where required.',
      'Provide suitable accommodation or welfare arrangements where applicable.',
      'Maintain facilities in good hygienic condition.',
      'Consider heat, weather and working conditions when planning welfare arrangements.',
    ],
    safetyControls: [
      'Drinking water',
      'Toilets',
      'Washing facilities',
      'Rest areas',
      'Changing facilities',
      'Cleaning programme',
      'Pest control',
      'Welfare inspections',
    ],
    responsibilities: [
      'Management provides adequate welfare facilities.',
      'Supervisors ensure workers have access to required facilities.',
      'Workers maintain hygiene and use facilities responsibly.',
      'HSE personnel inspect welfare standards.',
    ],
    references: [
      'Applicable UAE worker welfare requirements',
      'Company Welfare Procedure',
      'Project HSE Plan',
      'Applicable occupational health requirements',
    ],
  ),

  // ============================================================
  // 27. MOBILE ELEVATED WORK PLATFORM (MEWP)
  // ============================================================
  ReferenceTopic(
    id: 'mewp_safety',
    title: 'Mobile Elevated Work Platform (MEWP)',
    shortTitle: 'MEWP',
    category: 'HSE Reference',
    authority: 'UAE HSE / Work Equipment Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for the safe selection, inspection, operation and use of Mobile Elevated Work Platforms for work at height.',
    keyRequirements: [
      'Use a suitable MEWP for the intended task and environment.',
      'Ensure operators are trained and authorised.',
      'Complete pre-use inspections.',
      'Verify ground conditions and stability.',
      'Maintain safe clearance from overhead hazards.',
      'Use required harness and attachment arrangements where applicable.',
      'Do not exceed the rated platform capacity.',
      'Use suitable exclusion zones around the MEWP.',
      'Follow manufacturer operating instructions.',
      'Establish emergency lowering and rescue arrangements.',
    ],
    safetyControls: [
      'Operator competency',
      'Pre-use inspection',
      'Ground assessment',
      'Emergency lowering',
      'Harness',
      'Exclusion zone',
      'Load control',
      'Overhead clearance',
      'Manufacturer instructions',
    ],
    responsibilities: [
      'Management provides suitable and maintained MEWPs.',
      'Supervisors verify operator competency and site conditions.',
      'Operators perform inspections and operate equipment safely.',
      'HSE personnel monitor MEWP safety requirements.',
    ],
    references: [
      'Manufacturer operating manual',
      'Applicable UAE work equipment requirements',
      'Company MEWP Procedure',
      'Working at Height Procedure',
    ],
  ),

  // ============================================================
  // 28. ELECTRICITY ON SITE & ELECTRICAL TOOLS
  // ============================================================
  ReferenceTopic(
    id: 'site_electricity_electrical_tools',
    title: 'Site Electricity & Electrical Tools',
    shortTitle: 'Electrical Safety',
    category: 'HSE Reference',
    authority: 'UAE Electrical / HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for safely managing temporary electrical supplies, distribution systems, electrical equipment and portable electrical tools on construction and work sites.',
    keyRequirements: [
      'Use competent persons for electrical installation and maintenance.',
      'Protect temporary electrical systems from damage and environmental conditions.',
      'Use suitable distribution boards and protective devices.',
      'Provide effective earthing and electrical protection.',
      'Inspect electrical cables, plugs and tools before use.',
      'Remove damaged electrical equipment from service.',
      'Protect cables from mechanical damage and trip hazards.',
      'Use suitable residual-current protection where required.',
      'Apply isolation and lockout procedures before maintenance.',
    ],
    safetyControls: [
      'Electrical inspection',
      'Earthing',
      'RCD protection',
      'Distribution boards',
      'Cable management',
      'Tool inspection',
      'Isolation',
      'LOTO',
      'Electrical permits',
    ],
    responsibilities: [
      'Management provides safe electrical systems.',
      'Competent electricians perform electrical work.',
      'Supervisors ensure electrical controls are maintained.',
      'Workers inspect portable tools before use.',
      'HSE personnel monitor electrical safety arrangements.',
    ],
    references: [
      'Applicable UAE electrical requirements',
      'Company Electrical Safety Procedure',
      'Project HSE Plan',
      'Manufacturer instructions',
    ],
  ),

  // ============================================================
  // 29. TEMPORARY WORKS
  // ============================================================
  ReferenceTopic(
    id: 'temporary_works',
    title: 'Temporary Works',
    shortTitle: 'Temporary Works',
    category: 'HSE Reference',
    authority: 'UAE Construction HSE Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for planning, designing, constructing, inspecting, maintaining and dismantling temporary works such as formwork, falsework, temporary supports and access structures.',
    keyRequirements: [
      'Identify temporary works requiring formal design and control.',
      'Use competent designers and responsible persons.',
      'Provide approved designs where required.',
      'Verify foundations, supports and stability.',
      'Control loads and imposed forces.',
      'Inspect temporary works before use.',
      'Manage modifications through an approved process.',
      'Monitor temporary works during critical activities.',
      'Dismantle temporary works according to an approved sequence.',
    ],
    safetyControls: [
      'Temporary works design',
      'Design check',
      'Inspection',
      'Load control',
      'Bracing',
      'Stability assessment',
      'Permit or approval system',
      'Controlled dismantling',
    ],
    responsibilities: [
      'Management appoints competent temporary works personnel.',
      'Supervisors ensure approved temporary works are used.',
      'Workers do not modify temporary works without authorisation.',
      'HSE personnel verify safety controls and inspection arrangements.',
    ],
    references: [
      'Company Temporary Works Procedure',
      'Approved Temporary Works Design',
      'Project HSE Plan',
      'Applicable UAE construction requirements',
    ],
  ),

  // ============================================================
  // 30. MANUAL HANDLING
  // ============================================================
  ReferenceTopic(
    id: 'manual_handling',
    title: 'Manual Handling',
    shortTitle: 'Manual Handling',
    category: 'HSE Reference',
    authority: 'HSE Best Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for assessing and controlling risks associated with lifting, carrying, pushing, pulling and moving materials manually.',
    keyRequirements: [
      'Assess manual-handling tasks before work.',
      'Avoid manual handling where mechanical assistance is reasonably practicable.',
      'Use suitable lifting aids and equipment.',
      'Consider load weight, size, shape and stability.',
      'Use correct lifting techniques.',
      'Coordinate team lifting where required.',
      'Avoid twisting while lifting.',
      'Store materials at suitable working heights where practicable.',
      'Provide manual-handling training.',
    ],
    safetyControls: [
      'Manual-handling assessment',
      'Mechanical lifting aids',
      'Trolleys',
      'Team lifting',
      'Proper lifting technique',
      'Material storage',
      'Training',
      'PPE',
    ],
    responsibilities: [
      'Management provides suitable handling equipment.',
      'Supervisors assess high-risk manual-handling activities.',
      'Workers use correct handling techniques.',
      'HSE personnel monitor manual-handling risks.',
    ],
    references: [
      'Company Manual Handling Procedure',
      'Task Risk Assessment',
      'Project HSE Plan',
      'Applicable occupational health guidance',
    ],
  ),

  // ============================================================
  // 31. HOT WORKS
  // ============================================================
  ReferenceTopic(
    id: 'hot_works',
    title: 'Hot Works',
    shortTitle: 'Hot Works',
    category: 'HSE Reference',
    authority: 'UAE HSE / Fire Safety Practice',
    jurisdiction: 'UAE',
    guidelineCategory: GuidelineCategory.hseReference,
    description:
        'Guidance for controlling activities such as welding, cutting, grinding, brazing and other work that generates flame, sparks, heat or ignition sources.',
    keyRequirements: [
      'Obtain a hot-work permit where required.',
      'Inspect the work area before starting.',
      'Remove or protect combustible materials.',
      'Provide suitable fire extinguishers and firefighting equipment.',
      'Use suitable welding screens and barriers.',
      'Check gas cylinders, hoses, regulators and connections.',
      'Provide adequate ventilation.',
      'Use appropriate PPE.',
      'Provide fire watch during and after hot work where required.',
      'Stop hot work if unsafe conditions develop.',
    ],
    safetyControls: [
      'Hot-work permit',
      'Fire watch',
      'Fire extinguishers',
      'Gas cylinder inspection',
      'Welding screens',
      'Combustible-material control',
      'Ventilation',
      'PPE',
      'Post-work fire check',
    ],
    responsibilities: [
      'Management provides suitable hot-work controls.',
      'Supervisors verify permits and work-area preparation.',
      'Workers follow hot-work procedures and permit conditions.',
      'Fire watch personnel monitor for ignition or fire hazards.',
      'HSE personnel inspect and monitor hot-work activities.',
    ],
    references: [
      'Company Hot Work Procedure',
      'Permit to Work Procedure',
      'Project Fire Prevention Plan',
      'Applicable UAE fire and HSE requirements',
    ],
  ),
];

// ============================================================
// HSE REFERENCE COMPLETE LEARNING
// ============================================================

const Map<String, List<_HseReferenceSection>> hseReferenceDetailedContent = {
  'safety_observation': [
    _HseReferenceSection(
      title: 'Observation Planning',
      items: [
        'Define the observation purpose, work activity, location and people exposed before starting. Review the task risk assessment and identify the critical controls that should be visible at the workface. Select an observation approach that covers both positive safety behaviour and conditions requiring improvement. Avoid observations that focus only on PPE; look at the full control system.',
        'Record the date, location, activity, persons involved and factual condition observed.',
        'Use observations to verify whether controls are actually being used, not merely documented.',
        'Ask workers to explain the main hazard and critical control in their own words.',
      ],
    ),
    _HseReferenceSection(
      title: 'Safe Acts & Behaviours',
      items: [
        'Recognise safe planning, correct equipment use, effective communication, good housekeeping and intervention when hazards are found. Positive observations should identify the behaviour and why it prevents harm. Share useful examples during toolbox talks so good practices become repeatable. Avoid rewarding unsafe shortcuts simply because production was achieved.',
        'Record the specific safe behaviour and the risk it controls.',
        'Use positive observations to reinforce critical behaviours in high-risk tasks.',
        'Check whether the safe behaviour is supported by adequate equipment, time and supervision.',
      ],
    ),
    _HseReferenceSection(
      title: 'Unsafe Acts & Conditions',
      items: [
        'Describe unsafe acts and unsafe conditions objectively: what was seen, where, who could be exposed and what could happen. Classify the immediate hazard and identify whether the failure is equipment, procedure, competence, supervision or planning related. Apply immediate controls where there is an uncontrolled risk.',
        'Do not blame a worker when a system failure may have contributed.',
        'Escalate serious uncontrolled conditions and use stop-work arrangements where necessary.',
        'Verify corrective action at the actual point of exposure.',
      ],
    ),
    _HseReferenceSection(
      title: 'Corrective Action & Learning',
      items: [
        'Assign actions to responsible persons with realistic deadlines and required evidence. Distinguish immediate correction from longer-term preventive action. Verify effectiveness after closure rather than closing an action only because a photo was uploaded. Trend repeated observations to identify systemic weaknesses.',
        'Link recurring findings to risk assessments, training, design or management-of-change reviews.',
        'Use lessons learned in toolbox talks and supervisor briefings.',
        'Retain objective records for assurance and performance review.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the safety observation controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
    _HseReferenceSection(
      title: 'Observation examples',
      items: [
        'Safe: Worker identifies a missing guardrail before entering the area and reports it.',
        'Unsafe: Worker walks past an exposed hazard because no incident has happened yet.',
        'Safe: Supervisor discusses the control and verifies correction at the workface.',
        'Unsafe: Observation is recorded without correcting an immediate serious hazard.',
      ],
    ),
  ],
  'near_miss_reporting': [
    _HseReferenceSection(
      title: 'Recognition & Immediate Control',
      items: [
        'Recognise events where injury, illness, damage, environmental harm or other loss could reasonably have occurred. Make the area safe before investigating. Preserve evidence where appropriate and ensure injured or exposed people receive assistance.',
        'Separate the actual outcome from the credible potential consequence.',
        'Report promptly through the project/company process.',
        'Escalate high-potential events even when no injury occurred.',
      ],
    ),
    _HseReferenceSection(
      title: 'Information Capture',
      items: [
        'Record sequence of events, location, task, equipment, environmental conditions and people involved. Capture photographs, permits, drawings or other evidence where appropriate. Avoid changing facts to fit a preferred explanation.',
        'Describe what happened before, during and after the event.',
        'Identify the critical control that failed, was absent or was bypassed.',
        'Capture witness information while details are fresh.',
      ],
    ),
    _HseReferenceSection(
      title: 'Investigation & Root Causes',
      items: [
        'Investigate significant near misses proportionately. Look beyond the immediate unsafe act to planning, supervision, competence, equipment condition, workload and organisational factors. Use evidence-based questioning and avoid assumptions.',
        'Identify immediate, underlying and root causes where appropriate.',
        'Check whether the same exposure exists elsewhere on the project.',
        'Define corrective and preventive actions that address causes, not symptoms.',
      ],
    ),
    _HseReferenceSection(
      title: 'Learning & Trend Analysis',
      items: [
        'Share relevant lessons with affected teams without unnecessary blame. Trend near misses by activity, location, hazard and failed control. Use repeated trends to strengthen procedures, training or engineering controls.',
        'Verify that lessons reach workers who perform similar tasks.',
        'Track action effectiveness after implementation.',
        'Use high-potential near misses as leading indicators for management review.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the near miss reporting controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
    _HseReferenceSection(
      title: 'Near-miss examples',
      items: [
        'Safe: A dropped object is reported, the area is controlled and the failed retention control is investigated.',
        'Unsafe: A near miss is ignored because nobody was injured.',
        'Safe: Similar work areas are checked for the same exposure.',
        'Unsafe: The investigation blames one worker without checking planning and equipment controls.',
      ],
    ),
  ],
  'stop_work_authority': [
    _HseReferenceSection(
      title: 'When to Stop',
      items: [
        'Stop or suspend work when an immediate or uncontrolled risk exists, a critical control is missing, conditions differ materially from the approved method, or a worker cannot safely continue. The aim is to prevent harm, not to assign blame.',
        'Move people to a safe position when required.',
        'Notify the responsible supervisor and HSE representative.',
        'Do not restart simply because production pressure exists.',
      ],
    ),
    _HseReferenceSection(
      title: 'Hazard Assessment',
      items: [
        'Identify the hazard, exposed persons, credible consequence and failed control. Reassess the task and determine whether the approved method remains suitable.',
        'Check changes in weather, equipment, interfaces, personnel and work sequence.',
        'Use the hierarchy of controls to select stronger controls where possible.',
        'Document significant interventions and decisions.',
      ],
    ),
    _HseReferenceSection(
      title: 'Corrective Controls',
      items: [
        'Establish the required engineering, administrative and PPE controls before restart. Update RAMS, permits, isolation or training when the work method changes.',
        'Verify critical controls at the point of exposure.',
        'Ensure affected workers understand what changed.',
        'Escalate unresolved risks to competent management.',
      ],
    ),
    _HseReferenceSection(
      title: 'Restart & Learning',
      items: [
        'Restart only after the responsible person confirms the controls are effective and authorised restart requirements are met. Record lessons from repeated stop-work events.',
        'Check that the same hazard is not present elsewhere.',
        'Use interventions to improve planning and safety culture.',
        'Never penalise good-faith reporting of a genuine safety concern.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the stop work authority controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
    _HseReferenceSection(
      title: 'Stop-work examples',
      items: [
        'Safe: Work is paused when an exclusion zone is breached and restarted after controls are restored.',
        'Unsafe: Workers continue because the task is almost finished.',
      ],
    ),
  ],
  'safety_induction': [
    _HseReferenceSection(
      title: 'Site-Specific Orientation',
      items: [
        'Explain site boundaries, access routes, emergency arrangements, welfare facilities, restricted areas and reporting channels. Induction should reflect actual site hazards rather than generic slides.',
        'Confirm language and communication needs.',
        'Use maps, demonstrations and site walks where useful.',
        'Update induction when major site conditions change.',
      ],
    ),
    _HseReferenceSection(
      title: 'Critical Hazards & Controls',
      items: [
        'Cover the hazards most relevant to the site: work at height, lifting, excavation, traffic, electrical energy, hot work, confined spaces and environmental conditions as applicable. Explain the controls workers are expected to follow.',
        'Show examples of prohibited practices.',
        'Explain how to recognise and report changing conditions.',
        'Link induction content to task-specific RAMS and permits.',
      ],
    ),
    _HseReferenceSection(
      title: 'Emergency & Reporting',
      items: [
        'Explain alarms, emergency numbers, assembly points, first-aid arrangements, fire response, rescue limitations and incident/near-miss reporting. Workers should know what to do before an emergency occurs.',
        'Confirm workers can identify the nearest safe escape route.',
        'Explain who controls the scene during an emergency.',
        'Keep attendance and competency evidence as required.',
      ],
    ),
    _HseReferenceSection(
      title: 'Verification & Refresher',
      items: [
        'Check understanding through questions, demonstrations or short assessments. Provide refresher or re-induction after significant changes, prolonged absence or identified gaps.',
        'Do not treat attendance alone as proof of understanding.',
        'Record induction status for workers, contractors and visitors as applicable.',
        'Supervisors should reinforce induction rules during daily briefings.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the safety induction controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
  ],
  'competency_training': [
    _HseReferenceSection(
      title: 'Training Needs Analysis',
      items: [
        'Identify competence requirements from task hazards, legal/project requirements, equipment, roles and emergency duties. Separate awareness training from safety-critical competency.',
        'Use a training matrix linked to job roles and activities.',
        'Identify expiry, refresher and reassessment needs.',
        'Prevent assignment to restricted tasks until competence is verified.',
      ],
    ),
    _HseReferenceSection(
      title: 'Practical Competence',
      items: [
        'Use practical demonstrations, supervised practice and assessments where skills are safety-critical. Verify that workers can use equipment and apply controls, not merely repeat theory.',
        'Assess abnormal and emergency situations where relevant.',
        'Use competent assessors appropriate to the task.',
        'Document evidence of competence and authorisation.',
      ],
    ),
    _HseReferenceSection(
      title: 'Toolbox Talks & Communication',
      items: [
        'Make toolbox talks task-specific, short enough to remain effective and linked to actual site conditions. Discuss hazards, critical controls, recent changes and lessons learned.',
        'Encourage questions and worker feedback.',
        'Use visual demonstrations for complex tasks.',
        'Record attendance without treating signatures as the only evidence of learning.',
      ],
    ),
    _HseReferenceSection(
      title: 'Assurance & Improvement',
      items: [
        'Review training effectiveness through observations, incidents, audits and supervisor feedback. Update content when procedures, equipment or risks change.',
        'Investigate repeated errors as possible training-system failures.',
        'Refresh competence after significant changes or long periods away from the task.',
        'Maintain controlled training records.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the competency & safety training controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
  ],
  'safety_inspection': [
    _HseReferenceSection(
      title: 'Inspection Planning',
      items: [
        'Set inspection frequency according to risk, work stage and previous findings. Include high-risk activities, temporary works, plant, access, welfare and emergency arrangements.',
        'Use risk-based checklists but allow inspectors to record unexpected hazards.',
        'Plan joint inspections with responsible supervisors when useful.',
        'Ensure findings are factual and traceable.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Verification',
      items: [
        'Inspect actual conditions at the point of exposure: barriers, equipment condition, access, permits, isolation, housekeeping and worker practices. Compare field conditions with approved documents.',
        'Interview workers to test whether controls are understood.',
        'Use photographs or other evidence where appropriate.',
        'Escalate imminent danger immediately.',
      ],
    ),
    _HseReferenceSection(
      title: 'Findings & Actions',
      items: [
        'Classify findings according to risk and required response. Assign clear owners, target dates and evidence requirements.',
        'Immediate correction does not remove the need to understand why the failure occurred.',
        'Verify close-out at the field location.',
        'Reopen actions when the control is ineffective.',
      ],
    ),
    _HseReferenceSection(
      title: 'Trend & Assurance',
      items: [
        'Analyse recurring findings by hazard, contractor, area and control type. Use trends to adjust inspections, training, engineering controls and management priorities.',
        'Track overdue high-risk actions closely.',
        'Use inspection data as a leading indicator.',
        'Retain records according to the project/company system.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the hse inspections controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
  ],
  'safety_signage': [
    _HseReferenceSection(
      title: 'Sign Selection',
      items: [
        'Select signs and signals according to the hazard, required behaviour and audience. Use standard symbols and clear wording suitable for the workforce.',
        'Do not use signs as a substitute for engineering controls where stronger controls are required.',
        'Ensure temporary signs reflect current work conditions.',
        'Use multilingual or visual communication where necessary for comprehension.',
      ],
    ),
    _HseReferenceSection(
      title: 'Placement & Visibility',
      items: [
        'Position signs where people can see and understand them before entering the hazard area or making a decision. Consider height, lighting, obstructions, dust and changing site layouts.',
        'Keep signs clean, legible and secure.',
        'Provide advance warning for vehicle and pedestrian interfaces.',
        'Remove obsolete signs to prevent conflicting instructions.',
      ],
    ),
    _HseReferenceSection(
      title: 'Signals & Communication',
      items: [
        'Define hand signals, alarms, traffic signals and emergency warnings used on the site. Ensure operators and signalers share the same system.',
        'Test alarms and communication methods where required.',
        'Use dedicated signalers for critical movements.',
        'Stop work when communication is lost during safety-critical operations.',
      ],
    ),
    _HseReferenceSection(
      title: 'Inspection & Maintenance',
      items: [
        'Inspect signs and signals during routine HSE checks and after layout changes. Replace damaged, faded or misleading signs promptly.',
        'Record significant deficiencies.',
        'Verify temporary controls during each work phase.',
        'Coordinate signs with barricades and exclusion zones.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the safety signs & signals controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
  ],
  'barricading_exclusion_zones': [
    _HseReferenceSection(
      title: 'Hazard Assessment',
      items: [
        'Define what hazard the barrier is controlling: fall, excavation, lifting, traffic, electrical energy, demolition, hot work or another exposure. Set the boundary based on credible reach, fall, swing, blast or vehicle movement.',
        'Do not rely on tape alone where a stronger physical barrier is required.',
        'Identify authorised access points.',
        'Review boundaries when the work method changes.',
      ],
    ),
    _HseReferenceSection(
      title: 'Barrier Selection',
      items: [
        'Use rigid barriers, guardrails, fencing, cones, warning tape or other systems appropriate to the risk. Barriers should be stable, visible and difficult to bypass unintentionally.',
        'Provide signs explaining the hazard and access restriction.',
        'Protect barriers from vehicle impact where necessary.',
        'Maintain emergency access routes unless the emergency plan provides an alternative.',
      ],
    ),
    _HseReferenceSection(
      title: 'Access Control',
      items: [
        'Control who may enter and under what conditions. Use permits, supervision or physical access control for high-risk zones.',
        'Prevent workers from stepping through barriers for convenience.',
        'Provide safe crossing points where routes must intersect.',
        'Brief contractors and visitors on restricted areas.',
      ],
    ),
    _HseReferenceSection(
      title: 'Inspection & Change',
      items: [
        'Inspect barricades after weather, vehicle impact, relocation or changes in the work area. Remove barriers only when the hazard is controlled or the exclusion is no longer required.',
        'Record repeated barrier failures as a systemic issue.',
        'Ensure night visibility where applicable.',
        'Coordinate with traffic and lifting plans.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the barricading & exclusion zones controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
  ],
  'housekeeping_reference': [
    _HseReferenceSection(
      title: 'Orderly Workplace',
      items: [
        'Keep access routes, stairs, platforms, work areas and emergency exits clear. Store tools and materials so they cannot fall, roll, obstruct movement or create trip hazards.',
        'Remove waste progressively rather than waiting until the end of the shift.',
        'Maintain clean and dry walking surfaces where practicable.',
        'Assign responsibility for housekeeping in each work area.',
      ],
    ),
    _HseReferenceSection(
      title: 'Storage & Access',
      items: [
        'Stack materials securely, respect storage limits and keep heavy or unstable items at suitable heights. Maintain clearance around electrical panels, fire equipment and emergency routes.',
        'Prevent protruding materials from creating impact hazards.',
        'Use racks, bins and designated storage areas.',
        'Inspect temporary storage after deliveries or layout changes.',
      ],
    ),
    _HseReferenceSection(
      title: 'Spills & Waste',
      items: [
        'Control spills promptly using suitable procedures and equipment. Segregate waste according to project/environmental requirements and remove hazardous waste through approved arrangements.',
        'Use appropriate PPE for spill cleanup.',
        'Prevent contaminated materials from entering drains or soil.',
        'Report repeated spills as an underlying process problem.',
      ],
    ),
    _HseReferenceSection(
      title: 'Inspection & Behaviour',
      items: [
        'Include housekeeping in daily supervisor checks and formal HSE inspections. Recognise good standards and correct poor conditions before they become normalised.',
        'Use photos or checklists for recurring problem areas.',
        'Link poor housekeeping to root causes such as inadequate bins, planning or shift handover.',
        'Maintain emergency routes continuously.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the good housekeeping controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
  ],
  'environmental_protection': [
    _HseReferenceSection(
      title: 'Environmental Aspects',
      items: [
        'Identify environmental aspects such as dust, noise, wastewater, spills, waste, emissions, soil contamination and resource use. Determine which activities can affect neighbours, workers and the environment.',
        'Use project environmental plans and applicable authority conditions.',
        'Consider environmental risks during method planning and changes.',
        'Define monitoring responsibilities.',
      ],
    ),
    _HseReferenceSection(
      title: 'Pollution Prevention',
      items: [
        'Prevent releases through containment, equipment maintenance, drainage protection and controlled storage. Keep fuels, chemicals and wastes away from incompatible areas and sensitive receptors.',
        'Maintain spill kits appropriate to the materials present.',
        'Use secondary containment where required.',
        'Stop and report uncontrolled discharges promptly.',
      ],
    ),
    _HseReferenceSection(
      title: 'Waste & Resources',
      items: [
        'Segregate waste streams where required and use authorised collection/disposal arrangements. Reduce waste through planning, reuse and controlled material quantities.',
        'Label waste containers clearly.',
        'Prevent mixing incompatible wastes.',
        'Maintain transfer or disposal records where required.',
      ],
    ),
    _HseReferenceSection(
      title: 'Dust, Noise & Community',
      items: [
        'Use dust suppression, equipment maintenance, work sequencing and suitable barriers to reduce impacts. Manage noisy activities with planning and monitoring where necessary.',
        'Consider weather and wind conditions.',
        'Respond to complaints through the project process.',
        'Verify controls at the boundary of the affected area.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the environmental protection controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
  ],
  'occupational_health': [
    _HseReferenceSection(
      title: 'Exposure Identification',
      items: [
        'Identify physical, chemical, biological, ergonomic and psychosocial exposures associated with work. Consider duration, frequency, intensity and susceptible groups without relying only on PPE.',
        'Use competent occupational health or industrial hygiene support when needed.',
        'Review exposures after process or material changes.',
        'Link exposure assessments to task risk assessments.',
      ],
    ),
    _HseReferenceSection(
      title: 'Engineering & Administrative Controls',
      items: [
        'Prioritise elimination, substitution, enclosure, ventilation, isolation and work-practice controls. Use administrative limits and PPE as supporting controls.',
        'Verify ventilation and extraction systems are functioning.',
        'Control access to high-exposure areas.',
        'Maintain inspection and maintenance records.',
      ],
    ),
    _HseReferenceSection(
      title: 'Health Surveillance',
      items: [
        'Where required, implement appropriate screening or surveillance linked to identified exposures. Protect confidentiality and use competent medical professionals.',
        'Use results to identify control weaknesses without exposing private medical information.',
        'Track attendance and follow-up appropriately.',
        'Review surveillance requirements when exposure changes.',
      ],
    ),
    _HseReferenceSection(
      title: 'Worker Awareness & Welfare',
      items: [
        'Explain symptoms, exposure routes, hygiene requirements, reporting arrangements and available support. Provide suitable washing, changing, drinking and rest facilities.',
        'Prevent eating or drinking in contaminated areas.',
        'Encourage early reporting of work-related symptoms.',
        'Use health information to strengthen preventive controls.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the occupational health controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
  ],
  'first_aid': [
    _HseReferenceSection(
      title: 'Needs Assessment',
      items: [
        'Determine first-aid needs from workforce size, work activities, hazards, remoteness, shifts and emergency response time. Provide suitable trained responders and equipment for the identified risk.',
        'Consider remote or high-risk work separately.',
        'Keep emergency contact information current.',
        'Inspect first-aid supplies routinely.',
      ],
    ),
    _HseReferenceSection(
      title: 'Immediate Response',
      items: [
        'Protect the scene, call for assistance and provide first aid within the responder’s competence. Do not create additional casualties by entering an uncontrolled hazard.',
        'Use emergency equipment only as trained.',
        'Provide clear access for emergency responders.',
        'Escalate serious injuries according to the incident process.',
      ],
    ),
    _HseReferenceSection(
      title: 'Equipment & Facilities',
      items: [
        'Position first-aid kits, eyewash, emergency showers, stretchers or other equipment according to risk. Keep equipment accessible, identifiable and maintained.',
        'Check expiry dates and replenish used items.',
        'Provide suitable facilities for remote or dispersed work.',
        'Avoid locking emergency equipment where immediate access is required.',
      ],
    ),
    _HseReferenceSection(
      title: 'Records & Learning',
      items: [
        'Record treatment and referrals according to applicable requirements while protecting confidential information. Review trends and response performance after significant events.',
        'Conduct post-event checks of equipment and responder readiness.',
        'Use lessons learned to improve controls and emergency plans.',
        'Coordinate first aid with site emergency drills.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the first aid & medical response controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
  ],
  'emergency_drills': [
    _HseReferenceSection(
      title: 'Scenario Planning',
      items: [
        'Select credible scenarios based on site hazards: fire, medical emergency, fall, confined-space rescue, spill, vehicle incident or severe weather. Define objectives before the exercise.',
        'Avoid drills that create uncontrolled exposure.',
        'Coordinate with responsible emergency personnel.',
        'Inform only those who need to know when realism is important and safe.',
      ],
    ),
    _HseReferenceSection(
      title: 'Execution',
      items: [
        'Test alarms, communication, evacuation, accountability, access, first aid and command arrangements. Observe real behaviour rather than assuming procedures will work.',
        'Maintain safe control of the drill area.',
        'Record response times and missed actions.',
        'Ensure contractors and visitors are included where relevant.',
      ],
    ),
    _HseReferenceSection(
      title: 'Evaluation',
      items: [
        'Conduct a structured debrief and identify strengths, gaps and actions. Compare performance against emergency plan requirements and objectives.',
        'Distinguish equipment failure from human performance issues.',
        'Assign corrective actions with owners and dates.',
        'Escalate critical gaps immediately.',
      ],
    ),
    _HseReferenceSection(
      title: 'Readiness Improvement',
      items: [
        'Update plans, contact lists, equipment and training based on findings. Repeat drills when significant gaps or changes exist.',
        'Verify that corrective actions are effective in later exercises.',
        'Use drill results in management review.',
        'Maintain records of scenarios, attendance and lessons.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the emergency drills & exercises controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
  ],
  'safety_culture': [
    _HseReferenceSection(
      title: 'Leadership & Accountability',
      items: [
        'Leaders demonstrate safety through decisions, resources, visible field presence and consistent follow-up. Accountability should be clear and fair, with attention to system conditions that influence behaviour.',
        'Do not encourage production targets that implicitly require unsafe shortcuts.',
        'Recognise proactive hazard reporting and intervention.',
        'Review whether supervisors have time and resources to control work.',
      ],
    ),
    _HseReferenceSection(
      title: 'Worker Participation',
      items: [
        'Create practical ways for workers to raise hazards, suggest improvements and participate in risk assessments. Close the feedback loop so people know what happened to their concerns.',
        'Provide communication routes appropriate to language and literacy needs.',
        'Include contractors in relevant engagement.',
        'Use toolbox talks as two-way discussions.',
      ],
    ),
    _HseReferenceSection(
      title: 'Learning & Just Culture',
      items: [
        'Treat incidents, near misses, observations and audits as sources of learning. Investigate why controls failed and distinguish error, at-risk behaviour and deliberate violation where evidence supports the distinction.',
        'Avoid blame-only responses to unintentional mistakes.',
        'Strengthen systems when repeated failures occur.',
        'Share lessons without unnecessary personal details.',
      ],
    ),
    _HseReferenceSection(
      title: 'Measurement & Improvement',
      items: [
        'Use leading and lagging indicators together: observations, inspections, training, action closure, incidents and recurring hazards. Focus on quality of controls rather than raw activity counts.',
        'Review trends with operational leaders.',
        'Set improvement actions based on evidence.',
        'Verify whether changes actually reduce exposure.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the safety culture controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
  ],
  'code_of_practice': [
    _HseReferenceSection(
      title: 'Understanding Requirements',
      items: [
        'Use the applicable Code of Practice or technical guidance as a reference for the subject and understand whether requirements are mandatory, project-specific or guidance-based.',
        'Confirm the current version before relying on a requirement.',
        'Read the full applicable document where a compliance decision depends on it.',
        'Do not present a generic summary as a substitute for the governing document.',
      ],
    ),
    _HseReferenceSection(
      title: 'Applying to Work',
      items: [
        'Translate relevant requirements into risk assessments, method statements, permits, inspections, training and field controls. Consider the actual task and conditions.',
        'Identify competent persons responsible for implementation.',
        'Document how critical requirements are met.',
        'Verify controls at the point of work.',
      ],
    ),
    _HseReferenceSection(
      title: 'Change & Interface',
      items: [
        'Review requirements when design, equipment, materials, contractors or work methods change. Consider interactions with other codes, authority conditions and project procedures.',
        'Use management of change for significant deviations.',
        'Escalate conflicts or unclear requirements for competent review.',
        'Avoid relying on outdated copies.',
      ],
    ),
    _HseReferenceSection(
      title: 'Assurance & Records',
      items: [
        'Maintain controlled copies, evidence of implementation and inspection/audit records. Use findings to identify gaps and improve the management system.',
        'Track revisions and approvals.',
        'Ensure workers receive changes that affect them.',
        'Verify corrective actions against the applicable requirement.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the code of practice controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
  ],
  'excavation_safety': [
    _HseReferenceSection(
      title: 'Planning & Services',
      items: [
        'Review drawings, permits, surveys and utility information before breaking ground. Locate and positively identify underground services using approved methods.',
        'Treat unknown services as potentially live until verified.',
        'Define safe digging methods near services.',
        'Brief operators and banksmen on service locations.',
      ],
    ),
    _HseReferenceSection(
      title: 'Ground Stability',
      items: [
        'Assess soil, water, vibration, adjacent structures and surcharge loads. Select suitable sloping, benching, shoring or shielding arrangements.',
        'Keep spoil, materials and plant away from edges as required.',
        'Inspect after rain, water ingress, vibration or changes.',
        'Never enter an unsupported excavation where collapse risk is uncontrolled.',
      ],
    ),
    _HseReferenceSection(
      title: 'Access & Workface Control',
      items: [
        'Provide safe ladders, ramps or other access and maintain clear egress. Separate pedestrians and plant and protect open edges.',
        'Use barriers and warning signs.',
        'Control entry into excavations and pits.',
        'Provide lighting for low-visibility work.',
      ],
    ),
    _HseReferenceSection(
      title: 'Inspection & Emergency',
      items: [
        'Conduct competent inspections before shifts and after conditions change. Define rescue arrangements for collapse, service strike, flooding or other credible emergencies.',
        'Stop work when cracks, movement, water or unexpected services appear.',
        'Do not attempt improvised rescue into an unstable excavation.',
        'Record inspections and corrective actions.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the excavation safety controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
    _HseReferenceSection(
      title: 'Excavation examples',
      items: [
        'Safe: Underground services are located and verified before excavation.',
        'Unsafe: Excavation starts from an old drawing without field verification.',
        'Safe: A competent inspection confirms ground stability and access before entry.',
        'Unsafe: Workers enter a cracked or waterlogged excavation without reassessment.',
      ],
    ),
  ],
  'scaffolding_safety': [
    _HseReferenceSection(
      title: 'Design & Foundation',
      items: [
        'Select scaffold type and configuration for the intended load, height and environment. Ensure foundations, sole boards, base plates and ties are suitable for the design.',
        'Prevent settlement and instability.',
        'Consider wind and interface loads.',
        'Do not improvise components.',
      ],
    ),
    _HseReferenceSection(
      title: 'Erection & Modification',
      items: [
        'Use competent scaffolders and follow the approved sequence. Maintain stability during erection and dismantling.',
        'Control dropped objects and falling materials.',
        'Prevent unauthorised alterations.',
        'Keep incomplete scaffolds clearly controlled.',
      ],
    ),
    _HseReferenceSection(
      title: 'Platforms & Access',
      items: [
        'Provide full platforms, guardrails, toe boards and safe access appropriate to the scaffold. Control overloading and material accumulation.',
        'Keep platforms clear of trip hazards.',
        'Use suitable access rather than climbing outside the intended system.',
        'Respect design load limits.',
      ],
    ),
    _HseReferenceSection(
      title: 'Inspection & Tagging',
      items: [
        'Inspect before use and after significant alteration, damage or events that could affect integrity. Identify status clearly through the project system.',
        'Remove defective scaffolds from service.',
        'Record findings and corrective actions.',
        'Verify modifications before returning to use.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the scaffolding safety controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
    _HseReferenceSection(
      title: 'Scaffold examples',
      items: [
        'Safe: Scaffold is inspected and released before use.',
        'Unsafe: Workers alter guardrails or ties without competent control.',
      ],
    ),
  ],
  'working_at_height': [
    _HseReferenceSection(
      title: 'Hierarchy of Fall Prevention',
      items: [
        'Avoid work at height where practicable. Prefer ground-level assembly, collective protection, safe platforms and suitable access before relying on personal fall protection.',
        'Select controls based on the actual task and fall consequence.',
        'Include dropped-object risks.',
        'Review the method when conditions change.',
      ],
    ),
    _HseReferenceSection(
      title: 'Access & Platforms',
      items: [
        'Use suitable scaffolds, MEWPs, platforms, stairs or ladders according to the task. Keep access stable, clear and appropriate to the height and duration of work.',
        'Do not use improvised platforms.',
        'Protect openings and edges.',
        'Control simultaneous activities below.',
      ],
    ),
    _HseReferenceSection(
      title: 'Fall Protection & Rescue',
      items: [
        'Where personal systems are required, select compatible equipment, suitable anchorage and an arrangement that limits fall distance. Plan rescue before work starts.',
        'Inspect harnesses, connectors and lifelines before use.',
        'Ensure workers understand suspension and rescue risks.',
        'Do not rely on emergency services alone when site rescue is required.',
      ],
    ),
    _HseReferenceSection(
      title: 'Dropped Objects & Weather',
      items: [
        'Secure tools and materials and establish exclusion zones below. Monitor wind, rain, visibility and other conditions that can affect safe work at height.',
        'Stop work when fall protection or access cannot be maintained.',
        'Use tool lanyards where appropriate.',
        'Reassess after scaffold/platform movement or impact.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the working at height controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
    _HseReferenceSection(
      title: 'Work-at-height examples',
      items: [
        'Safe: A protected platform is used with a planned rescue arrangement.',
        'Unsafe: A worker climbs onto a guardrail to gain extra reach.',
        'Safe: Tools are secured and the area below is controlled.',
        'Unsafe: Materials are left loose at an elevated edge.',
      ],
    ),
  ],
  'power_tools_safety': [
    _HseReferenceSection(
      title: 'Tool Selection & Inspection',
      items: [
        'Select the correct tool, attachment and power source for the task. Inspect guards, cables, plugs, switches, batteries and accessories before use.',
        'Remove defective tools from service.',
        'Use manufacturer instructions and rated accessories.',
        'Do not modify safety devices.',
      ],
    ),
    _HseReferenceSection(
      title: 'Abrasive Wheels & Cutting',
      items: [
        'Confirm wheel type, speed rating, guard and mounting are suitable. Control sparks, fragments, dust and nearby combustibles.',
        'Use eye/face protection and other task-specific PPE.',
        'Keep bystanders outside the hazard zone.',
        'Allow wheels to stop before setting tools down.',
      ],
    ),
    _HseReferenceSection(
      title: 'Electrical & Mechanical Hazards',
      items: [
        'Use suitable electrical protection, grounding or battery systems and keep cords protected from damage. Control entanglement, kickback, pinch points and unexpected movement.',
        'Maintain stable footing and two-handed control where required.',
        'Disconnect/isolate before changing blades or accessories.',
        'Keep hands clear of moving parts.',
      ],
    ),
    _HseReferenceSection(
      title: 'Dust, Noise & Competence',
      items: [
        'Assess dust, noise and vibration exposure and use extraction, low-emission tools, hearing protection and exposure controls as appropriate.',
        'Train users in correct operation and emergency response.',
        'Do not use a tool for a task outside its design.',
        'Store and transport tools safely.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the power tools safety controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
    _HseReferenceSection(
      title: 'Power-tool examples',
      items: [
        'Safe: Damaged cable is tagged out and the tool is removed from service.',
        'Unsafe: A guard is removed to make cutting easier.',
      ],
    ),
  ],
  'formwork_safety': [
    _HseReferenceSection(
      title: 'Design & Load Path',
      items: [
        'Ensure formwork and falsework are designed or selected for expected loads, concrete pressure and construction sequence. Identify load paths and support conditions.',
        'Use approved drawings and competent review.',
        'Do not alter members without approval.',
        'Consider openings, edges and access during design.',
      ],
    ),
    _HseReferenceSection(
      title: 'Erection & Stability',
      items: [
        'Erect in a controlled sequence with bracing, ties, supports and foundations complete as required. Prevent premature loading.',
        'Control work at height and dropped objects.',
        'Barricade incomplete formwork.',
        'Inspect alignment and stability before loading.',
      ],
    ),
    _HseReferenceSection(
      title: 'Concrete Placement',
      items: [
        'Control pour rate, pressure, hose/pump interaction and worker positions. Monitor for movement, leakage, distress or unexpected deflection.',
        'Stop placement if instability develops.',
        'Keep people out of collapse zones.',
        'Coordinate with concrete and lifting teams.',
      ],
    ),
    _HseReferenceSection(
      title: 'Striking & Handover',
      items: [
        'Remove formwork only after required strength, approvals and sequence conditions are confirmed. Control falling components during striking.',
        'Use a planned dismantling sequence.',
        'Inspect remaining structure and temporary supports.',
        'Record handover and release conditions.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the formwork safety controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
    _HseReferenceSection(
      title: 'Formwork examples',
      items: [
        'Safe: Formwork is checked for stability before concrete placement.',
        'Unsafe: Props are moved during a pour without engineering control.',
      ],
    ),
  ],
  'permit_to_work': [
    _HseReferenceSection(
      title: 'Permit Planning',
      items: [
        'Identify whether the activity requires a permit and define scope, location, hazards, controls, validity and responsible persons. Link PTW to RAMS and risk assessment.',
        'Use a permit only when its controls can be verified.',
        'Avoid overlapping permits that create conflicting conditions.',
        'Define permit issuer and receiver roles.',
      ],
    ),
    _HseReferenceSection(
      title: 'Isolation & Preconditions',
      items: [
        'Confirm energy isolation, gas testing, fire protection, access, barriers, equipment and other prerequisites before work begins.',
        'Verify isolations at the point of work.',
        'Record test results and expiry where applicable.',
        'Do not start when a required prerequisite is incomplete.',
      ],
    ),
    _HseReferenceSection(
      title: 'Handover, Suspension & Change',
      items: [
        'Communicate permit conditions to the work team and suspend the permit when conditions change, alarms occur or work stops beyond the permitted conditions.',
        'Revalidate after shift or personnel changes as required.',
        'Reassess when the work scope changes.',
        'Maintain clear status of active permits.',
      ],
    ),
    _HseReferenceSection(
      title: 'Closure & Assurance',
      items: [
        'Inspect the area, remove tools and personnel, restore systems safely and close the permit through the authorised process.',
        'Do not restore energy before confirming readiness.',
        'Audit permit quality, not just permit presence.',
        'Trend repeated permit deviations.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the permit to work (ptw) controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
    _HseReferenceSection(
      title: 'PTW examples',
      items: [
        'Safe: Work starts only after isolation and permit conditions are verified.',
        'Unsafe: A permit is signed but the field isolation is not verified.',
      ],
    ),
  ],
  'hot_humid_climate': [
    _HseReferenceSection(
      title: 'Heat Risk Assessment',
      items: [
        'Consider temperature, humidity, radiant heat, workload, clothing, acclimatisation and individual factors. Identify high-risk tasks and times.',
        'Use applicable UAE seasonal requirements and project heat-management arrangements.',
        'Monitor conditions and adjust work planning.',
        'Consider shaded and cooled work locations.',
      ],
    ),
    _HseReferenceSection(
      title: 'Hydration & Work-Rest',
      items: [
        'Provide potable drinking water and suitable rest/cooling arrangements. Schedule demanding work to reduce heat exposure and apply required work-rest controls.',
        'Encourage regular hydration rather than waiting for thirst.',
        'Provide acclimatisation for new or returning workers.',
        'Monitor high-risk crews more closely.',
      ],
    ),
    _HseReferenceSection(
      title: 'Recognition & Response',
      items: [
        'Train workers and supervisors to recognise heat exhaustion, heat stroke and other heat-related illness. Stop exposure and activate medical response when symptoms are serious.',
        'Never leave an affected worker alone.',
        'Move the person to a cool area while arranging appropriate medical help.',
        'Document and investigate significant heat illness.',
      ],
    ),
    _HseReferenceSection(
      title: 'Supervision & Programme Assurance',
      items: [
        'Supervisors monitor worker condition, workload, clothing, hydration and environmental conditions. Review heat programme performance and near misses.',
        'Encourage workers to report symptoms without stigma.',
        'Adjust work when controls are not effective.',
        'Verify welfare facilities remain usable throughout the shift.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the working in hot & humid climate controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
  ],
  'confined_space': [
    _HseReferenceSection(
      title: 'Identification & Assessment',
      items: [
        'Identify spaces with restricted entry/exit and potential atmospheric, engulfment, mechanical, electrical, thermal or biological hazards. Determine whether entry can be avoided.',
        'Assess connected systems and hidden energy sources.',
        'Define authorised entrants and roles.',
        'Review rescue feasibility before entry.',
      ],
    ),
    _HseReferenceSection(
      title: 'Permit & Isolation',
      items: [
        'Use the required permit and isolate lines, energy, mechanical movement and process hazards. Lock and tag isolations where applicable.',
        'Verify zero-energy condition.',
        'Control access to the space.',
        'Suspend entry when conditions change.',
      ],
    ),
    _HseReferenceSection(
      title: 'Atmosphere & Ventilation',
      items: [
        'Test oxygen, flammable gases and toxic contaminants using suitable calibrated instruments. Provide ventilation and continuous monitoring where required by the risk.',
        'Place monitors where stratification or source location requires.',
        'Do not rely on smell as a gas test.',
        'Stop entry when readings exceed approved limits.',
      ],
    ),
    _HseReferenceSection(
      title: 'Standby & Rescue',
      items: [
        'Provide a competent attendant, communication and a rescue system appropriate to the space. Rescue should not depend on untrained workers entering after a casualty.',
        'Test rescue equipment and access.',
        'Maintain entrant accountability.',
        'Conduct drills for credible rescue scenarios.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the confined space safety controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
    _HseReferenceSection(
      title: 'Confined-space examples',
      items: [
        'Safe: Atmosphere is tested and monitored with a prepared rescue plan.',
        'Unsafe: A worker enters because the space “looks safe” without testing.',
      ],
    ),
  ],
  'working_near_live_roads': [
    _HseReferenceSection(
      title: 'Traffic Management Planning',
      items: [
        'Define work zones, traffic routes, pedestrian paths, speed controls, barriers and transitions before work starts. Coordinate with road authority/project requirements.',
        'Consider traffic volume, vehicle type and sight distance.',
        'Protect workers from intrusion into the work area.',
        'Update arrangements as road geometry changes.',
      ],
    ),
    _HseReferenceSection(
      title: 'Pedestrian & Worker Protection',
      items: [
        'Use physical separation, safe crossings and controlled access. Position workers away from moving traffic and provide high-visibility clothing appropriate to the risk.',
        'Never assume drivers will see workers.',
        'Maintain clear escape routes.',
        'Control plant entering and leaving the work zone.',
      ],
    ),
    _HseReferenceSection(
      title: 'Plant & Reversing',
      items: [
        'Use trained drivers, banksmen and reversing controls where required. Minimise reversing and use cameras, alarms or physical separation as appropriate.',
        'Establish exclusion zones around mobile plant.',
        'Separate pedestrian and vehicle movements.',
        'Stop work if traffic controls are displaced.',
      ],
    ),
    _HseReferenceSection(
      title: 'Night, Weather & Emergency',
      items: [
        'Provide lighting, reflective signs and barriers for low visibility. Plan response to vehicle intrusion, collision, breakdown and emergency access.',
        'Inspect traffic controls after impact or severe weather.',
        'Maintain emergency vehicle access.',
        'Record and investigate traffic incidents and near misses.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the working near live roads controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
    _HseReferenceSection(
      title: 'Road-work examples',
      items: [
        'Safe: Physical separation and controlled pedestrian routes are maintained.',
        'Unsafe: Workers cross through live traffic lanes because the route is shorter.',
      ],
    ),
  ],
  'concreting_safety': [
    _HseReferenceSection(
      title: 'Pre-Pour Planning',
      items: [
        'Review formwork stability, access, pump location, delivery route, exclusion zones, reinforcement hazards and emergency arrangements. Confirm the sequence and responsibilities before the pour.',
        'Conduct a pre-pour inspection and briefing.',
        'Control simultaneous activities.',
        'Ensure workers understand stop-work triggers.',
      ],
    ),
    _HseReferenceSection(
      title: 'Pump & Hose Safety',
      items: [
        'Inspect pumps, hoses, couplings, clamps and restraints. Control line movement, pressure and blockage response.',
        'Never open a pressurised line without following the safe depressurisation procedure.',
        'Keep workers clear of hose whip zones.',
        'Use competent pump operators and assistants.',
      ],
    ),
    _HseReferenceSection(
      title: 'Placement & Access',
      items: [
        'Provide stable working platforms and protect edges and openings. Control slips, trips, protruding reinforcement and contact with wet concrete.',
        'Use suitable PPE for cement contact.',
        'Keep access routes clear of hoses where possible.',
        'Prevent workers from standing in unsafe positions during placement.',
      ],
    ),
    _HseReferenceSection(
      title: 'Washout & Close-Out',
      items: [
        'Control concrete washout and prevent uncontrolled discharge. Clean equipment safely and inspect the work area after the pour.',
        'Use designated washout areas.',
        'Protect drains and soil.',
        'Close out defects in formwork, access and housekeeping before the area is released.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the concreting safety controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
    _HseReferenceSection(
      title: 'Concreting examples',
      items: [
        'Safe: Pump line and hose connections are checked before pressurisation.',
        'Unsafe: A worker opens a blocked pressurised line without following the depressurisation procedure.',
      ],
    ),
  ],
  'worker_welfare': [
    _HseReferenceSection(
      title: 'Basic Facilities',
      items: [
        'Provide suitable drinking water, sanitation, washing, rest, changing and welfare arrangements appropriate to the workforce and work conditions.',
        'Keep facilities clean, accessible and maintained.',
        'Consider remote and night-shift workers.',
        'Inspect welfare facilities routinely.',
      ],
    ),
    _HseReferenceSection(
      title: 'Heat, Rest & Recovery',
      items: [
        'Provide suitable shaded/cooling rest arrangements and work-rest planning where heat exposure exists. Ensure workers can recover without unsafe pressure to continue.',
        'Monitor heat conditions and worker welfare.',
        'Provide drinking water close to work areas.',
        'Escalate failures of welfare controls.',
      ],
    ),
    _HseReferenceSection(
      title: 'Hygiene & Living Conditions',
      items: [
        'Maintain hygiene, waste disposal, food areas and accommodation arrangements where provided. Prevent contamination and unsafe storage.',
        'Separate clean and contaminated areas where necessary.',
        'Maintain pest and sanitation controls.',
        'Record and address recurring welfare complaints.',
      ],
    ),
    _HseReferenceSection(
      title: 'Communication & Support',
      items: [
        'Provide clear channels for workers to raise welfare and safety concerns. Ensure supervisors respond and do not ignore reasonable welfare needs.',
        'Use language-appropriate communication.',
        'Include welfare in contractor monitoring.',
        'Review welfare trends during HSE meetings.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the worker welfare controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
  ],
  'mewp_safety': [
    _HseReferenceSection(
      title: 'Selection & Pre-Use Checks',
      items: [
        'Select a MEWP suitable for height, reach, ground conditions, capacity and environment. Conduct documented pre-use checks and confirm required inspection status.',
        'Check tyres, controls, alarms, emergency lowering and guardrails.',
        'Remove defective equipment from service.',
        'Use only authorised operators.',
      ],
    ),
    _HseReferenceSection(
      title: 'Ground & Positioning',
      items: [
        'Assess ground stability, slopes, openings, overhead hazards and vehicle interfaces. Position and stabilise the machine according to manufacturer requirements.',
        'Use outriggers or stabilisers where designed.',
        'Maintain required clearances from electrical hazards.',
        'Control pedestrian access around the machine.',
      ],
    ),
    _HseReferenceSection(
      title: 'Platform Use & Fall Protection',
      items: [
        'Keep gates closed and remain within the platform. Use required fall protection according to the machine and task risk.',
        'Do not climb guardrails or use improvised ladders in the basket.',
        'Respect rated capacity and wind limits.',
        'Do not transfer between elevated platforms unless specifically designed and controlled.',
      ],
    ),
    _HseReferenceSection(
      title: 'Travel, Rescue & Maintenance',
      items: [
        'Control travel with the platform raised, overhead obstructions and ground personnel. Know emergency lowering and rescue arrangements.',
        'Isolate energy before maintenance.',
        'Use competent maintenance personnel.',
        'Inspect after impact or abnormal events before reuse.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the mobile elevated work platform (mewp) controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
    _HseReferenceSection(
      title: 'MEWP examples',
      items: [
        'Safe: Operator completes pre-use inspection and keeps the gate closed.',
        'Unsafe: Worker stands on the guardrail to gain additional height.',
      ],
    ),
  ],
  'site_electricity_electrical_tools': [
    _HseReferenceSection(
      title: 'Temporary Electrical System',
      items: [
        'Design and install temporary distribution systems for the site conditions, with suitable protection, enclosures, isolation and identification.',
        'Protect cables from traffic, water and mechanical damage.',
        'Keep panels accessible and secured.',
        'Use competent electrical personnel.',
      ],
    ),
    _HseReferenceSection(
      title: 'Inspection & Protection',
      items: [
        'Inspect tools, cords, plugs, sockets and protective devices before use. Use appropriate residual-current protection and earthing arrangements where required.',
        'Remove damaged equipment immediately.',
        'Do not use taped or improvised electrical repairs.',
        'Maintain testing/inspection records where required.',
      ],
    ),
    _HseReferenceSection(
      title: 'Isolation & Maintenance',
      items: [
        'Isolate electrical energy before maintenance or repair and use LOTO where applicable. Verify de-energisation before touching conductors.',
        'Prevent unauthorised re-energisation.',
        'Use suitable test equipment and competent persons.',
        'Treat unknown circuits as energised until verified otherwise.',
      ],
    ),
    _HseReferenceSection(
      title: 'Work Environment & Emergency',
      items: [
        'Keep electrical equipment away from water and incompatible conditions. Plan response to electric shock, fire and damaged cables.',
        'Do not touch a casualty until the electrical source is made safe.',
        'Provide emergency access and suitable firefighting arrangements.',
        'Investigate repeated electrical defects.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the site electricity & electrical tools controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
    _HseReferenceSection(
      title: 'Electrical examples',
      items: [
        'Safe: Damaged extension lead is removed from service.',
        'Unsafe: A taped cable is kept in use because a replacement is not available.',
      ],
    ),
  ],
  'temporary_works': [
    _HseReferenceSection(
      title: 'Design & Approval',
      items: [
        'Identify temporary structures and construction-stage conditions that require engineering design or competent approval. Define loads, sequence, stability and interfaces.',
        'Control design changes formally.',
        'Use current drawings and revision status.',
        'Do not rely on informal site modifications.',
      ],
    ),
    _HseReferenceSection(
      title: 'Erection & Stability',
      items: [
        'Erect temporary works according to the approved sequence with foundations, bracing, ties and supports complete as required.',
        'Control weather and impact risks.',
        'Prevent unauthorised access to incomplete works.',
        'Verify stability before loading.',
      ],
    ),
    _HseReferenceSection(
      title: 'Use, Inspection & Change',
      items: [
        'Inspect before use and after alteration, impact, overload, settlement or severe weather. Manage changes through competent review.',
        'Record inspections and release status.',
        'Stop work when distress or unexpected movement is observed.',
        'Protect temporary works from conflicting activities.',
      ],
    ),
    _HseReferenceSection(
      title: 'Dismantling & Handover',
      items: [
        'Plan dismantling in a controlled sequence and confirm conditions for removal of supports. Handover information should identify residual risks and restrictions.',
        'Prevent premature removal.',
        'Control dropped components.',
        'Confirm the permanent works can safely take the intended loads before release.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the temporary works controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
  ],
  'manual_handling': [
    _HseReferenceSection(
      title: 'Task Assessment',
      items: [
        'Assess load weight, shape, grip, posture, distance, frequency, environment and individual capability. Look first for ways to eliminate or mechanise the handling.',
        'Avoid unnecessary carrying distances.',
        'Break loads down where practicable.',
        'Plan routes before moving materials.',
      ],
    ),
    _HseReferenceSection(
      title: 'Mechanical Aids',
      items: [
        'Use trolleys, hoists, pallet trucks, forklifts or other aids appropriate to the load and route. Ensure equipment is suitable and inspected.',
        'Do not overload handling aids.',
        'Control slopes, thresholds and pedestrian interfaces.',
        'Train users in the specific equipment.',
      ],
    ),
    _HseReferenceSection(
      title: 'Lifting Technique & Team Handling',
      items: [
        'Use stable footing, plan the movement and keep the load close where practicable. Team lifts require one person to coordinate the movement and clear communication.',
        'Do not twist while carrying a heavy load.',
        'Stop when grip, visibility or balance is lost.',
        'Use rest and task rotation for repetitive handling.',
      ],
    ),
    _HseReferenceSection(
      title: 'Ergonomics & Improvement',
      items: [
        'Use observations and health information to identify repetitive or awkward tasks. Redesign storage heights, workstations and material flow to reduce strain.',
        'Do not treat PPE as the primary solution to poor task design.',
        'Monitor recurring musculoskeletal complaints.',
        'Review controls after changes to materials or production methods.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the manual handling controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
    _HseReferenceSection(
      title: 'Manual-handling examples',
      items: [
        'Safe: Heavy material is moved using a suitable mechanical aid.',
        'Unsafe: One worker attempts to lift a load that cannot be safely controlled.',
      ],
    ),
  ],
  'hot_works': [
    _HseReferenceSection(
      title: 'Hot Work Assessment & Permit',
      items: [
        'Identify ignition sources, combustibles, adjacent areas, hidden spaces and flammable atmospheres. Use a hot-work permit where required and define the authorised time and location.',
        'Remove or protect combustible materials.',
        'Check nearby floors, walls and voids for heat transfer risk.',
        'Stop work if permit conditions are no longer valid.',
      ],
    ),
    _HseReferenceSection(
      title: 'Equipment & Gas Safety',
      items: [
        'Inspect welding machines, leads, earth connections, hoses, regulators, flashback protection and cylinders. Secure cylinders upright and separate incompatible gases as required.',
        'Keep hoses protected from damage.',
        'Close valves when equipment is not in use.',
        'Do not use leaking or defective equipment.',
      ],
    ),
    _HseReferenceSection(
      title: 'Fire Prevention & Watch',
      items: [
        'Provide suitable extinguishing equipment, spark containment and a competent fire watch when required. Monitor adjacent areas during and after work.',
        'Protect combustible surfaces and openings.',
        'Maintain clear access for firefighting.',
        'Extend post-work checks according to the fire risk and procedure.',
      ],
    ),
    _HseReferenceSection(
      title: 'Fumes, Radiation & PPE',
      items: [
        'Control welding fumes through ventilation or extraction and protect workers and others from arc radiation, sparks, noise and burns.',
        'Use task-appropriate welding screens and PPE.',
        'Do not perform hot work in a hazardous atmosphere without required controls.',
        'Coordinate hot work with confined-space and gas-testing requirements where relevant.',
      ],
    ),
    _HseReferenceSection(
      title: 'Field Application & Verification',
      items: [
        'Apply the hot works controls at the actual point of work and compare field conditions with the approved risk assessment, method statement and site requirements.',
        'Supervisor should confirm the critical controls before exposure, during the task and after significant changes; stop and reassess when a critical control cannot be maintained.',
        'Ask workers to explain the main hazard, the critical control, the stop-work trigger and the emergency action for this subject.',
        'Record significant deficiencies, assign corrective actions and verify effectiveness at the workface before considering the issue closed.',
      ],
    ),
    _HseReferenceSection(
      title: 'Hot-work examples',
      items: [
        'Safe: Combustibles are protected and a fire watch is maintained.',
        'Unsafe: Grinding sparks are allowed to reach stored combustible material.',
      ],
    ),
  ],
};

class _HseReferenceSection {
  final String title;
  final List<String> items;

  const _HseReferenceSection({
    required this.title,
    required this.items,
  });
}

class HseReferenceCompleteTopicPage extends StatelessWidget {
  final ReferenceTopic topic;

  const HseReferenceCompleteTopicPage({
    super.key,
    required this.topic,
  });

  static const Color primaryGreen = Color(0xFF0B6B46);
  static const Color pageBackground = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    final sections = hseReferenceDetailedContent[topic.id] ?? const <_HseReferenceSection>[];

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          topic.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 32),
        itemCount: sections.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final section = sections[index];
          return _HseSectionTile(
            number: index + 1,
            section: section,
          );
        },
      ),
    );
  }
}

class _HseSectionTile extends StatelessWidget {
  final int number;
  final _HseReferenceSection section;

  const _HseSectionTile({
    required this.number,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE7F5EF),
          foregroundColor: const Color(0xFF087548),
          child: Text(
            '$number',
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        title: Text(
          section.title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
        subtitle: Text(
          '${section.items.length} detailed learning points',
        ),
        children: [
          for (var i = 0; i < section.items.length; i++)
            _HseItemTile(
              number: i + 1,
              text: section.items[i],
            ),
        ],
      ),
    );
  }
}

class _HseItemTile extends StatelessWidget {
  final int number;
  final String text;

  const _HseItemTile({
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final lower = text.toLowerCase();
    final isSafe = lower.startsWith('safe:');
    final isUnsafe = lower.startsWith('unsafe:');
    final Color accent = isUnsafe
        ? const Color(0xFFC62828)
        : isSafe
            ? const Color(0xFF16834D)
            : const Color(0xFF2D5F4B);

    return Container(
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: isUnsafe
            ? const Color(0xFFFFF4F4)
            : isSafe
                ? const Color(0xFFF0FAF4)
                : const Color(0xFFF8FAF9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: accent.withValues(alpha: 0.14),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 13),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: accent.withValues(alpha: 0.10),
              foregroundColor: accent,
              child: Text(
                '$number',
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Color(0xFF263238),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
