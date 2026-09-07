import '../models/reference_topic.dart';

/// ============================================================
/// SafeNexus HSE
/// Professional HSE Safety Reference
///
/// UAE-wide general HSE reference topics.
/// Keep this file separate from emirate-specific guidelines.
/// ============================================================

const List<ReferenceTopic> hseSafetyReferences = [
  // ============================================================
  // 1. Risk Assessment
  // ============================================================

  ReferenceTopic(
    id: 'hse_risk_assessment',
    title: 'Risk Assessment',
    shortTitle: 'Risk Assessment',
    description:
        'A systematic process for identifying hazards, evaluating risks and implementing suitable control measures before and during work activities.',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Identify hazards associated with the work activity.',
      'Identify people who may be affected by the hazards.',
      'Evaluate the likelihood and potential severity of harm.',
      'Determine appropriate risk control measures.',
      'Implement controls before starting the activity.',
      'Review the assessment when conditions or work methods change.',
    ],
    safetyControls: [
      'Elimination of hazards where reasonably practicable.',
      'Substitution with safer methods or materials.',
      'Engineering controls and physical protection.',
      'Administrative controls and safe work procedures.',
      'Suitable personal protective equipment.',
      'Regular monitoring of implemented controls.',
    ],
    responsibilities: [
      'Management shall provide resources for effective risk control.',
      'Supervisors shall ensure controls are implemented at the workplace.',
      'Workers shall follow approved procedures and report hazards.',
      'HSE personnel shall support risk assessment and monitoring.',
    ],
    references: [
      'UAE occupational health and safety requirements.',
      'Organisation-approved HSE procedures.',
      'Project risk assessments and method statements.',
    ],
  ),

  // ============================================================
  // 2. Permit to Work
  // ============================================================

  ReferenceTopic(
    id: 'hse_permit_to_work',
    title: 'Permit to Work System',
    shortTitle: 'PTW',
    description:
        'A formal control system used to authorise and control high-risk work activities through defined precautions, responsibilities and approval requirements.',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Identify activities requiring a permit.',
      'Define hazards and required precautions before work starts.',
      'Obtain approval from authorised personnel.',
      'Verify site conditions before issuing the permit.',
      'Communicate permit requirements to the work team.',
      'Close or suspend the permit when work conditions change.',
    ],
    safetyControls: [
      'Isolation and lockout where required.',
      'Gas testing for applicable activities.',
      'Barricading and controlled access.',
      'Fire prevention and emergency arrangements.',
      'Competent supervision.',
      'Permit display and status monitoring.',
    ],
    responsibilities: [
      'Authorised personnel shall issue and control permits.',
      'Supervisors shall ensure workers understand permit conditions.',
      'Workers shall comply with permit requirements.',
      'HSE personnel shall monitor compliance with the PTW system.',
    ],
    references: [
      'Project Permit to Work procedure.',
      'Approved method statement and risk assessment.',
      'Applicable UAE HSE requirements.',
    ],
  ),

  // ============================================================
  // 3. Working at Height
  // ============================================================

  ReferenceTopic(
    id: 'hse_working_at_height',
    title: 'Working at Height',
    shortTitle: 'Work at Height',
    description:
        'Requirements for preventing falls of people and materials when work is performed at elevated locations or where a person could fall and suffer injury.',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Plan work at height before starting the activity.',
      'Avoid work at height where reasonably practicable.',
      'Use suitable access equipment.',
      'Inspect scaffolds, ladders and access systems before use.',
      'Provide suitable fall prevention or protection systems.',
      'Secure tools and materials against falling.',
    ],
    safetyControls: [
      'Guardrails and edge protection.',
      'Safe and properly erected scaffolding.',
      'Suitable ladders and access equipment.',
      'Full body harness with suitable anchorage where required.',
      'Toe boards and debris protection.',
      'Exclusion zones below elevated work.',
    ],
    responsibilities: [
      'Supervisors shall ensure work-at-height controls are established.',
      'Workers shall use access and fall-protection systems correctly.',
      'Competent persons shall inspect relevant equipment.',
      'HSE personnel shall monitor compliance and workplace conditions.',
    ],
    references: [
      'Approved work-at-height procedure.',
      'Scaffold inspection requirements.',
      'Project risk assessment and method statement.',
    ],
  ),

  // ============================================================
  // 4. Excavation Safety
  // ============================================================

  ReferenceTopic(
    id: 'hse_excavation_safety',
    title: 'Excavation and Trenching Safety',
    shortTitle: 'Excavation Safety',
    description:
        'Safety controls for excavation and trenching activities to prevent collapse, falls, underground service damage, struck-by incidents and access hazards.',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Assess excavation hazards before work begins.',
      'Identify underground services before excavation.',
      'Provide suitable excavation support where required.',
      'Provide safe access and egress.',
      'Keep people and equipment away from unsupported edges.',
      'Inspect excavations regularly and after changing conditions.',
    ],
    safetyControls: [
      'Shoring, benching or safe battering.',
      'Barricading around excavation edges.',
      'Safe access ladders or ramps.',
      'Underground utility identification.',
      'Spoil and material setback from excavation edges.',
      'Water control and dewatering where required.',
    ],
    responsibilities: [
      'Supervisors shall verify excavation controls before work.',
      'Competent persons shall inspect excavations.',
      'Workers shall remain within designated safe areas.',
      'Plant operators shall follow exclusion and access controls.',
    ],
    references: [
      'Approved excavation procedure.',
      'Utility survey and permit requirements.',
      'Project risk assessment and method statement.',
    ],
  ),

  // ============================================================
  // 5. Lifting Operations
  // ============================================================

  ReferenceTopic(
    id: 'hse_lifting_operations',
    title: 'Lifting Operations',
    shortTitle: 'Lifting Safety',
    description:
        'Safety requirements for planning, preparing and conducting lifting operations involving cranes, lifting equipment and lifting accessories.',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Plan lifting operations according to the load and site conditions.',
      'Use competent and authorised lifting personnel.',
      'Verify lifting equipment suitability and capacity.',
      'Inspect lifting accessories before use.',
      'Establish suitable exclusion zones.',
      'Maintain clear communication between the lifting team.',
    ],
    safetyControls: [
      'Approved lifting plan where required.',
      'Certified lifting equipment and accessories.',
      'Competent operator, rigger and signalman.',
      'Load-control and exclusion zones.',
      'Suitable ground conditions and crane setup.',
      'Tag lines where appropriate.',
    ],
    responsibilities: [
      'Lifting supervisors shall control lifting activities.',
      'Operators shall operate equipment within approved limits.',
      'Riggers shall attach loads safely.',
      'Workers shall stay clear of suspended loads.',
    ],
    references: [
      'Approved lifting plan.',
      'Lifting equipment inspection records.',
      'Project lifting procedure.',
    ],
  ),

  // ============================================================
  // 6. Scaffolding
  // ============================================================

  ReferenceTopic(
    id: 'hse_scaffolding_safety',
    title: 'Scaffolding Safety',
    shortTitle: 'Scaffolding',
    description:
        'Safety requirements for the erection, inspection, modification and use of scaffolding systems used to provide temporary access and working platforms.',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Scaffolding shall be erected by competent personnel.',
      'Scaffolds shall be inspected before use and after significant changes.',
      'Platforms shall be adequately supported and secured.',
      'Safe access shall be provided.',
      'Guardrails and toe boards shall be provided where required.',
      'Unauthorised modification shall be prohibited.',
    ],
    safetyControls: [
      'Stable foundations.',
      'Proper bracing and ties.',
      'Guardrails and toe boards.',
      'Safe ladder or stair access.',
      'Inspection tags or status identification.',
      'Safe loading limits.',
    ],
    responsibilities: [
      'Scaffolders shall erect and modify scaffolds safely.',
      'Competent inspectors shall inspect scaffolds.',
      'Users shall report defects immediately.',
      'Supervisors shall prevent unauthorised modifications.',
    ],
    references: [
      'Scaffold inspection procedure.',
      'Approved scaffold design where required.',
      'Project working-at-height requirements.',
    ],
  ),

  // ============================================================
  // 7. Electrical Safety
  // ============================================================

  ReferenceTopic(
    id: 'hse_electrical_safety',
    title: 'Electrical Safety',
    shortTitle: 'Electrical Safety',
    description:
        'Controls for preventing electric shock, burns, electrical fires and other incidents arising from electrical systems and equipment.',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Electrical work shall be performed by competent personnel.',
      'Electrical equipment shall be suitable for its intended use.',
      'Damaged cables and equipment shall be removed from service.',
      'Suitable isolation procedures shall be followed.',
      'Temporary electrical installations shall be properly protected.',
      'Electrical panels shall remain accessible and protected.',
    ],
    safetyControls: [
      'Lockout and tagout where required.',
      'Residual current protection where applicable.',
      'Proper earthing and bonding.',
      'Cable protection and suitable routing.',
      'Electrical inspection and testing.',
      'Warning signs and restricted access.',
    ],
    responsibilities: [
      'Electrical personnel shall perform authorised electrical work.',
      'Supervisors shall ensure safe electrical arrangements.',
      'Workers shall not tamper with electrical systems.',
      'HSE personnel shall monitor electrical safety controls.',
    ],
    references: [
      'Approved electrical safety procedure.',
      'Lockout/Tagout procedure.',
      'Applicable electrical standards and project requirements.',
    ],
  ),

  // ============================================================
  // 8. Fire Safety
  // ============================================================

  ReferenceTopic(
    id: 'hse_fire_safety',
    title: 'Fire Safety and Prevention',
    shortTitle: 'Fire Safety',
    description:
        'Controls for preventing fires and ensuring effective emergency response, evacuation and firefighting arrangements at the workplace.',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Identify workplace fire hazards.',
      'Maintain suitable firefighting equipment.',
      'Keep emergency exits and access routes clear.',
      'Control ignition sources and combustible materials.',
      'Provide emergency procedures and evacuation arrangements.',
      'Conduct appropriate emergency drills.',
    ],
    safetyControls: [
      'Suitable fire extinguishers.',
      'Fire detection and alarm systems where required.',
      'Emergency exits and evacuation routes.',
      'Hot-work controls.',
      'Safe storage of flammable materials.',
      'Emergency assembly points.',
    ],
    responsibilities: [
      'Management shall provide suitable fire protection arrangements.',
      'Supervisors shall maintain safe housekeeping and access.',
      'Workers shall follow fire prevention and emergency procedures.',
      'Emergency teams shall be trained for assigned duties.',
    ],
    references: [
      'UAE Fire and Life Safety requirements.',
      'Civil Defence requirements applicable to the project.',
      'Project emergency response plan.',
    ],
  ),

  // ============================================================
  // 9. PPE
  // ============================================================

  ReferenceTopic(
    id: 'hse_personal_protective_equipment',
    title: 'Personal Protective Equipment',
    shortTitle: 'PPE',
    description:
        'Selection, provision, use, inspection and maintenance of personal protective equipment based on workplace hazards and risk assessments.',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Select PPE based on identified hazards.',
      'Provide suitable PPE to workers.',
      'Ensure PPE fits the user correctly.',
      'Train workers in correct PPE use.',
      'Inspect PPE before use.',
      'Replace damaged or unsuitable PPE.',
    ],
    safetyControls: [
      'Safety helmets.',
      'Safety footwear.',
      'Eye and face protection.',
      'Hearing protection.',
      'Protective gloves.',
      'Fall protection equipment where required.',
    ],
    responsibilities: [
      'Employers shall provide suitable PPE as required.',
      'Supervisors shall enforce PPE requirements.',
      'Workers shall wear and maintain assigned PPE.',
      'HSE personnel shall monitor PPE compliance.',
    ],
    references: [
      'Project PPE procedure.',
      'Risk assessment requirements.',
      'Applicable PPE standards.',
    ],
  ),

  // ============================================================
  // 10. Heat Stress
  // ============================================================

  ReferenceTopic(
    id: 'hse_heat_stress',
    title: 'Heat Stress Management',
    shortTitle: 'Heat Stress',
    description:
        'Measures to prevent heat-related illness among workers exposed to high temperatures, humidity, radiant heat and physically demanding work.',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Assess heat-stress risks for outdoor and hot work.',
      'Provide drinking water and suitable hydration arrangements.',
      'Provide suitable rest areas and recovery periods.',
      'Schedule demanding work appropriately where practicable.',
      'Train workers to recognise heat-stress symptoms.',
      'Provide prompt response to suspected heat-related illness.',
    ],
    safetyControls: [
      'Adequate drinking water.',
      'Shaded or cooled rest areas.',
      'Work-rest arrangements.',
      'Heat-stress awareness training.',
      'Buddy monitoring.',
      'Emergency response arrangements.',
    ],
    responsibilities: [
      'Management shall implement heat-stress prevention measures.',
      'Supervisors shall monitor workers and site conditions.',
      'Workers shall follow hydration and rest requirements.',
      'HSE personnel shall conduct heat-stress monitoring.',
    ],
    references: [
      'UAE heat-stress and midday-break requirements.',
      'Project heat-stress management plan.',
      'Applicable occupational health requirements.',
    ],
  ),

  // ============================================================
  // 11. Confined Space
  // ============================================================

  ReferenceTopic(
    id: 'hse_confined_space',
    title: 'Confined Space Safety',
    shortTitle: 'Confined Space',
    description:
        'Safety controls for work in spaces that may have restricted entry or exit and may contain hazardous atmospheres or other serious risks.',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Identify and classify confined spaces.',
      'Conduct a risk assessment before entry.',
      'Use a permit system where required.',
      'Test the atmosphere before and during entry as necessary.',
      'Provide suitable ventilation.',
      'Establish rescue arrangements before entry.',
    ],
    safetyControls: [
      'Atmospheric monitoring.',
      'Mechanical ventilation.',
      'Isolation of energy and hazardous substances.',
      'Standby attendant.',
      'Communication systems.',
      'Dedicated rescue equipment and trained personnel.',
    ],
    responsibilities: [
      'Supervisors shall verify entry controls.',
      'Authorised entrants shall follow entry procedures.',
      'Standby personnel shall continuously monitor the entry as required.',
      'Rescue personnel shall be suitably trained.',
    ],
    references: [
      'Confined-space entry procedure.',
      'Permit to Work system.',
      'Project emergency rescue plan.',
    ],
  ),

  // ============================================================
  // 12. Hot Work
  // ============================================================

  ReferenceTopic(
    id: 'hse_hot_work',
    title: 'Hot Work Safety',
    shortTitle: 'Hot Work',
    description:
        'Controls for activities such as welding, cutting, grinding and other work that can generate heat, sparks, flames or ignition sources.',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Obtain the required hot-work permit.',
      'Remove or protect combustible materials.',
      'Provide suitable firefighting equipment.',
      'Inspect the work area before starting.',
      'Use appropriate PPE.',
      'Conduct post-work fire watch where required.',
    ],
    safetyControls: [
      'Hot-work permit.',
      'Fire extinguishers.',
      'Fire-resistant blankets and screens.',
      'Gas-cylinder controls.',
      'Suitable ventilation.',
      'Fire watch.',
    ],
    responsibilities: [
      'Supervisors shall ensure hot-work controls are established.',
      'Workers shall follow the approved hot-work procedure.',
      'Fire watchers shall monitor the area as required.',
      'HSE personnel shall verify compliance.',
    ],
    references: [
      'Hot-work permit procedure.',
      'Project fire prevention procedure.',
      'Risk assessment and method statement.',
    ],
  ),

  // ============================================================
  // 13. Chemical Safety
  // ============================================================

  ReferenceTopic(
    id: 'hse_chemical_safety',
    title: 'Chemical Safety',
    shortTitle: 'Chemical Safety',
    description:
        'Safe handling, storage, transportation and use of hazardous chemicals to prevent exposure, fire, environmental release and other incidents.',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Maintain an inventory of hazardous chemicals.',
      'Provide current Safety Data Sheets.',
      'Label chemical containers correctly.',
      'Store chemicals according to compatibility requirements.',
      'Provide appropriate PPE and exposure controls.',
      'Train workers in chemical hazards and emergency response.',
    ],
    safetyControls: [
      'Safety Data Sheets.',
      'Chemical labelling.',
      'Suitable storage cabinets or areas.',
      'Spill containment.',
      'Ventilation.',
      'Emergency eyewash or shower facilities where required.',
    ],
    responsibilities: [
      'Management shall provide suitable chemical controls.',
      'Supervisors shall ensure safe storage and handling.',
      'Workers shall follow chemical handling procedures.',
      'HSE personnel shall monitor chemical safety arrangements.',
    ],
    references: [
      'Safety Data Sheets.',
      'Chemical management procedure.',
      'Applicable UAE hazardous-material requirements.',
    ],
  ),

  // ============================================================
  // 14. Emergency Preparedness
  // ============================================================

  ReferenceTopic(
    id: 'hse_emergency_preparedness',
    title: 'Emergency Preparedness and Response',
    shortTitle: 'Emergency Response',
    description:
        'Planning and preparedness measures to ensure an effective response to foreseeable workplace emergencies and minimise harm to people, property and the environment.',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Identify foreseeable emergency scenarios.',
      'Develop and maintain emergency response procedures.',
      'Provide suitable emergency communication arrangements.',
      'Identify emergency assembly points.',
      'Provide trained emergency response personnel.',
      'Conduct drills and review emergency performance.',
    ],
    safetyControls: [
      'Emergency response plan.',
      'Alarm and communication systems.',
      'Emergency contact information.',
      'First-aid arrangements.',
      'Fire response equipment.',
      'Emergency assembly areas.',
    ],
    responsibilities: [
      'Management shall provide emergency resources.',
      'Supervisors shall ensure workers understand emergency procedures.',
      'Workers shall follow emergency instructions.',
      'Emergency response teams shall perform assigned duties.',
    ],
    references: [
      'Project Emergency Response Plan.',
      'Fire and life-safety requirements.',
      'Applicable UAE emergency requirements.',
    ],
  ),

  // ============================================================
  // 15. Incident Reporting
  // ============================================================

  ReferenceTopic(
    id: 'hse_incident_reporting',
    title: 'Incident Reporting and Investigation',
    shortTitle: 'Incident Reporting',
    description:
        'A structured process for reporting, investigating and learning from incidents, near misses and unsafe conditions to prevent recurrence.',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Report incidents and near misses promptly.',
      'Preserve relevant evidence where appropriate.',
      'Investigate significant incidents systematically.',
      'Identify immediate and underlying causes.',
      'Develop corrective and preventive actions.',
      'Track actions until effective closure.',
    ],
    safetyControls: [
      'Incident reporting procedure.',
      'Root-cause analysis.',
      'Corrective action tracking.',
      'Lessons-learned communication.',
      'Trend analysis.',
      'Management review.',
    ],
    responsibilities: [
      'Workers shall report incidents and unsafe conditions.',
      'Supervisors shall secure the area and initiate reporting.',
      'HSE personnel shall coordinate investigations as required.',
      'Management shall ensure corrective actions are implemented.',
    ],
    references: [
      'Organisation incident reporting procedure.',
      'Project HSE management system.',
      'Applicable UAE reporting requirements.',
    ],
  ),

  // ============================================================
  // 16. Housekeeping
  // ============================================================

  ReferenceTopic(
    id: 'hse_housekeeping',
    title: 'Workplace Housekeeping',
    shortTitle: 'Housekeeping',
    description:
        'Good housekeeping practices that maintain clean, orderly and accessible workplaces and reduce slips, trips, falls, fire and material-handling hazards.',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Keep work areas clean and organised.',
      'Remove waste and unnecessary materials regularly.',
      'Maintain clear access and emergency routes.',
      'Store materials safely.',
      'Control spills promptly.',
      'Keep fire equipment and electrical panels accessible.',
    ],
    safetyControls: [
      'Defined waste collection areas.',
      'Routine housekeeping inspections.',
      'Safe material storage.',
      'Spill-control arrangements.',
      'Clear walkways.',
      'Good lighting.',
    ],
    responsibilities: [
      'Workers shall maintain good housekeeping.',
      'Supervisors shall conduct regular workplace checks.',
      'Contractors shall maintain their work areas.',
      'HSE personnel shall monitor housekeeping standards.',
    ],
    references: [
      'Project housekeeping procedure.',
      'Daily workplace inspection checklist.',
      'Project HSE requirements.',
    ],
  ),

  // ============================================================
  // 17. Manual Handling
  // ============================================================

  ReferenceTopic(
    id: 'hse_manual_handling',
    title: 'Manual Handling Safety',
    shortTitle: 'Manual Handling',
    description:
        'Controls for reducing musculoskeletal injuries and other risks associated with lifting, carrying, pushing, pulling and moving materials manually.',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Assess manual-handling tasks before work.',
      'Avoid unnecessary manual handling where practicable.',
      'Use mechanical aids for heavy or awkward loads.',
      'Provide suitable training.',
      'Use safe lifting techniques.',
      'Consider load weight, shape and working environment.',
    ],
    safetyControls: [
      'Trolleys and mechanical handling aids.',
      'Team lifting where appropriate.',
      'Suitable storage heights.',
      'Task rotation where required.',
      'Clear handling routes.',
      'Manual-handling training.',
    ],
    responsibilities: [
      'Supervisors shall plan handling activities safely.',
      'Workers shall use correct handling methods.',
      'Management shall provide suitable handling equipment.',
      'HSE personnel shall monitor manual-handling risks.',
    ],
    references: [
      'Manual handling risk assessment.',
      'Ergonomics procedure.',
      'Project HSE requirements.',
    ],
  ),

  // ============================================================
  // 18. Vehicle and Traffic Safety
  // ============================================================

  ReferenceTopic(
    id: 'hse_vehicle_traffic_safety',
    title: 'Vehicle and Traffic Safety',
    shortTitle: 'Traffic Safety',
    description:
        'Controls for managing vehicle movement, pedestrian interaction, reversing, loading and unloading within workplaces and construction sites.',
    category: 'UAE General',
    authority: 'UAE HSE Practice',
    jurisdiction: 'UAE',
    keyRequirements: [
      'Develop suitable site traffic arrangements.',
      'Separate pedestrians and vehicles where practicable.',
      'Control vehicle speeds.',
      'Use trained and authorised drivers.',
      'Inspect vehicles before use.',
      'Control reversing operations.',
    ],
    safetyControls: [
      'Traffic management plan.',
      'Pedestrian walkways.',
      'Speed limits and signage.',
      'Banksman or spotter where required.',
      'Vehicle alarms and warning systems.',
      'Adequate lighting.',
    ],
    responsibilities: [
      'Drivers shall follow site traffic rules.',
      'Supervisors shall control site vehicle movement.',
      'Pedestrians shall use designated routes.',
      'HSE personnel shall monitor traffic safety.',
    ],
    references: [
      'Project Traffic Management Plan.',
      'Vehicle inspection procedure.',
      'Site access and traffic rules.',
    ],
  ),
];
