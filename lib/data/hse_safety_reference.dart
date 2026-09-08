import '../models/reference_topic.dart';

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
