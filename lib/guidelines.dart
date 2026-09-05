import 'package:flutter/material.dart';

class GuidelinesPage extends StatefulWidget {
  const GuidelinesPage({super.key});

  @override
  State<GuidelinesPage> createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  // ============================================================
  // GENERAL UAE HSE REFERENCE LIBRARY
  // ============================================================

  final List<_SafetyTopic> _generalTopics = const [
    _SafetyTopic(
      title: 'Risk Assessment',
      description:
          'Identify hazards, assess risks and implement suitable controls before work starts.',
      purpose:
          'Risk assessment helps identify hazards before they cause harm and provides a structured basis for selecting effective controls.',
      hazards:
          'Unidentified hazards, changing site conditions, unsafe work methods, inadequate controls and uncontrolled high-risk activities.',
      controls:
          'Identify hazards • Assess likelihood and severity • Apply hierarchy of controls • Communicate controls • Review when conditions change.',
      ppe:
          'PPE must be selected according to the residual risk and task requirements.',
      checklist:
          'Task reviewed • Hazards identified • Risk assessed • Controls implemented • Workers briefed • Supervisor verification • Review completed.',
      documents:
          'Risk Assessment / JSA / Method Statement / Toolbox Talk / Inspection Records.',
    ),
    _SafetyTopic(
      title: 'Personal Protective Equipment',
      description:
          'Select, provide, inspect and correctly use PPE according to workplace hazards.',
      purpose:
          'PPE provides the final layer of protection when hazards cannot be adequately controlled through higher-level controls.',
      hazards:
          'Head injury, eye injury, hearing damage, respiratory exposure, hand injury, foot injury and falls.',
      controls:
          'Select suitable PPE • Ensure correct fit • Inspect before use • Maintain PPE • Replace damaged equipment • Train workers.',
      ppe:
          'Safety helmet • Safety footwear • Eye protection • Gloves • Hearing protection • Respiratory protection • Fall protection where required.',
      checklist:
          'Correct PPE selected • Correct size • Good condition • Worker trained • PPE inspected • Replacement available.',
      documents:
          'PPE Assessment / PPE Issue Record / Inspection Record / Training Record.',
    ),
    _SafetyTopic(
      title: 'Heat Stress',
      description:
          'Prevent heat-related illness through planning, hydration, rest, shade and worker monitoring.',
      purpose:
          'Heat-stress management reduces the risk of heat exhaustion, heat stroke, dehydration and other heat-related illness.',
      hazards:
          'High temperature, humidity, direct sunlight, heavy physical work, inadequate hydration and insufficient recovery periods.',
      controls:
          'Work planning • Hydration • Rest and shade • Acclimatization • Heat awareness • Worker monitoring • Emergency response.',
      ppe:
          'Suitable work clothing, head protection and task-specific PPE without creating unnecessary heat burden.',
      checklist:
          'Water available • Rest area available • Heat-risk assessment completed • Workers briefed • Symptoms monitored • Emergency plan available.',
      documents:
          'Heat Stress Plan / Toolbox Talk / Worker Monitoring / Training Records.',
    ),
    _SafetyTopic(
      title: 'Fire Safety',
      description:
          'Prevent fire and ensure people can respond quickly and evacuate safely.',
      purpose:
          'Fire safety controls reduce the likelihood of fire and limit consequences when a fire occurs.',
      hazards:
          'Ignition sources, flammable materials, electrical faults, hot work, gas cylinders and poor housekeeping.',
      controls:
          'Fire risk assessment • Good housekeeping • Control ignition sources • Suitable extinguishers • Emergency routes • Fire drills.',
      ppe:
          'Task-specific fire-resistant PPE where required.',
      checklist:
          'Fire exits clear • Extinguishers accessible • Emergency numbers displayed • Hot work controlled • Workers trained.',
      documents:
          'Fire Risk Assessment / Emergency Plan / Inspection Records / Drill Records.',
    ),
    _SafetyTopic(
      title: 'Emergency Preparedness',
      description:
          'Prepare people, procedures and resources for workplace emergencies.',
      purpose:
          'Emergency preparedness ensures workers know what to do during fire, medical, environmental, structural or other emergencies.',
      hazards:
          'Delayed evacuation, poor communication, blocked routes, inadequate emergency equipment and untrained personnel.',
      controls:
          'Emergency plan • Alarm system • Assembly points • Emergency contacts • Drills • Trained emergency personnel.',
      ppe:
          'Emergency PPE according to the foreseeable emergency.',
      checklist:
          'Emergency plan available • Routes clear • Assembly point identified • Emergency equipment inspected • Drills conducted.',
      documents:
          'Emergency Response Plan / Drill Report / Emergency Contact List.',
    ),
    _SafetyTopic(
      title: 'First Aid',
      description:
          'Provide appropriate first-aid arrangements and prompt medical response.',
      purpose:
          'First aid provides immediate assistance while further medical treatment is arranged.',
      hazards:
          'Delayed treatment, inadequate first-aid equipment, lack of trained first aiders and poor emergency communication.',
      controls:
          'First-aid assessment • Suitable kits • Trained first aiders • Emergency communication • Access to medical services.',
      ppe:
          'First-aid responder PPE appropriate to the incident.',
      checklist:
          'First-aid kit stocked • Expiry dates checked • First aider available • Emergency number known • Access maintained.',
      documents:
          'First Aid Inspection / Training Records / Incident Report.',
    ),
    _SafetyTopic(
      title: 'Occupational Health',
      description:
          'Identify and control workplace exposures that may affect worker health.',
      purpose:
          'Occupational health management focuses on preventing work-related illness through exposure assessment, health monitoring and preventive controls.',
      hazards:
          'Noise, vibration, chemicals, dust, ergonomic risks, heat and other occupational exposures.',
      controls:
          'Exposure assessment • Engineering controls • Administrative controls • Health surveillance where applicable • Worker awareness.',
      ppe:
          'Exposure-specific PPE.',
      checklist:
          'Exposure identified • Controls implemented • Monitoring completed • Workers informed • Health surveillance considered where applicable.',
      documents:
          'Exposure Assessment / Health Surveillance / Training Records.',
    ),
    _SafetyTopic(
      title: 'Work at Height',
      description:
          'Prevent falls through safe access, edge protection and suitable fall protection.',
      purpose:
          'Work-at-height controls prevent falls from platforms, roofs, ladders, scaffolds and other elevated locations.',
      hazards:
          'Falls from edges, unsafe ladders, fragile surfaces, dropped objects and unsuitable access equipment.',
      controls:
          'Avoid work at height where practicable • Safe access • Guardrails • Edge protection • Fall protection • Rescue planning.',
      ppe:
          'Safety helmet • Safety footwear • Full-body harness and suitable fall-arrest equipment where required.',
      checklist:
          'Access inspected • Edge protection installed • Fall protection checked • Anchor points suitable • Rescue plan available.',
      documents:
          'Work-at-Height Risk Assessment / Method Statement / Inspection Records / Rescue Plan.',
    ),
    _SafetyTopic(
      title: 'Confined Space',
      description:
          'Control atmospheric, physical and emergency risks associated with confined-space work.',
      purpose:
          'Confined-space controls protect workers from toxic atmospheres, oxygen deficiency, engulfment and difficult rescue conditions.',
      hazards:
          'Oxygen deficiency, toxic gases, flammable atmosphere, engulfment, restricted access and emergency rescue difficulty.',
      controls:
          'Risk assessment • Isolation • Gas testing • Ventilation • Permit • Standby person • Communication • Rescue plan.',
      ppe:
          'Task-specific PPE • Respiratory protection where assessed and suitable • Harness/rescue equipment where required.',
      checklist:
          'Permit issued • Isolation confirmed • Atmosphere tested • Ventilation available • Standby person assigned • Rescue equipment ready.',
      documents:
          'Confined Space Permit / Gas Test Record / Rescue Plan / Training Records.',
    ),
    _SafetyTopic(
      title: 'Electrical Safety',
      description:
          'Prevent electric shock, burns, fire and equipment damage.',
      purpose:
          'Electrical safety requires competent work, isolation, inspection and protection from electrical hazards.',
      hazards:
          'Live electrical parts, damaged cables, poor earthing, overloaded circuits, unsuitable tools and wet conditions.',
      controls:
          'Competent persons • Isolation • Lockout/Tagout where applicable • Inspection • Suitable protection • Controlled access.',
      ppe:
          'Electrical PPE appropriate to the assessed task and system.',
      checklist:
          'Equipment inspected • Cables undamaged • Isolation available • Protective devices functional • Competent person assigned.',
      documents:
          'Electrical Inspection / Isolation Record / Permit / Test Certificate.',
    ),
    _SafetyTopic(
      title: 'Lifting & Rigging',
      description:
          'Plan and control lifting operations involving cranes, lifting accessories and loads.',
      purpose:
          'Lifting controls prevent dropped loads, equipment failure, struck-by incidents and uncontrolled movement.',
      hazards:
          'Overloading, defective lifting gear, poor rigging, unstable loads, suspended loads and poor communication.',
      controls:
          'Lift plan • Competent personnel • Certified equipment • Load assessment • Exclusion zone • Communication.',
      ppe:
          'Helmet • Safety footwear • Gloves • High-visibility clothing and task-specific PPE.',
      checklist:
          'Lift plan approved • Equipment certified • Accessories inspected • Load known • Ground condition checked • Exclusion zone established.',
      documents:
          'Lift Plan / Lifting Equipment Register / Inspection Certificates / Competency Records.',
    ),
    _SafetyTopic(
      title: 'Chemical Safety',
      description:
          'Control chemical storage, handling, exposure, spills and disposal.',
      purpose:
          'Chemical safety prevents exposure, fire, incompatible reactions and environmental releases.',
      hazards:
          'Toxic exposure, corrosive substances, flammable liquids, incompatible chemicals and spills.',
      controls:
          'SDS • Labelling • Compatible storage • Ventilation • Exposure controls • Spill response • Safe disposal.',
      ppe:
          'Chemical-resistant gloves • Eye/face protection • Suitable protective clothing • Respiratory protection where required.',
      checklist:
          'SDS available • Containers labelled • Storage compatible • Spill kit available • Workers trained.',
      documents:
          'SDS Register / Chemical Register / Risk Assessment / Spill Report.',
    ),
    _SafetyTopic(
      title: 'Incident Investigation',
      description:
          'Report, investigate and learn from incidents, near misses and unsafe events.',
      purpose:
          'Incident investigation identifies immediate, underlying and root causes and prevents recurrence.',
      hazards:
          'Repeat incidents, inadequate corrective actions, missing evidence and delayed reporting.',
      controls:
          'Immediate response • Preserve evidence • Gather facts • Identify root causes • Corrective actions • Follow-up.',
      ppe:
          'Incident-scene PPE appropriate to hazards.',
      checklist:
          'Incident reported • Scene made safe • Evidence collected • Causes identified • Actions assigned • Close-out verified.',
      documents:
          'Incident Report / Investigation Report / Corrective Action Register.',
    ),
    _SafetyTopic(
      title: 'Environmental Safety',
      description:
          'Control environmental risks arising from workplace and construction activities.',
      purpose:
          'Environmental controls reduce impacts from waste, dust, noise, spills, emissions and other activities.',
      hazards:
          'Spills, dust, waste, emissions, noise, contaminated water and uncontrolled discharge.',
      controls:
          'Environmental assessment • Waste segregation • Spill prevention • Dust control • Monitoring • Emergency response.',
      ppe:
          'Environmental/task-specific PPE.',
      checklist:
          'Waste controlled • Spill kit available • Dust controlled • Storage compliant • Environmental inspections completed.',
      documents:
          'Environmental Plan / Waste Records / Inspection Records / Spill Reports.',
    ),
    _SafetyTopic(
      title: 'Manual Handling',
      description:
          'Reduce musculoskeletal injuries through task assessment and safer handling methods.',
      purpose:
          'Manual-handling controls reduce strain, sprains, back injuries and repetitive-motion injuries.',
      hazards:
          'Heavy loads, awkward posture, repetitive movement, pushing/pulling and poor work height.',
      controls:
          'Avoid unnecessary lifting • Mechanical aids • Reduce load • Team lifting • Good technique • Task redesign.',
      ppe:
          'Safety footwear • Gloves where appropriate.',
      checklist:
          'Load assessed • Mechanical aid considered • Route clear • Load manageable • Workers trained.',
      documents:
          'Manual Handling Assessment / Training Record / Task Risk Assessment.',
    ),
    _SafetyTopic(
      title: 'Traffic & Vehicle Safety',
      description:
          'Control interaction between pedestrians, vehicles and mobile equipment.',
      purpose:
          'Traffic management reduces vehicle-pedestrian collisions, reversing incidents and uncontrolled vehicle movement.',
      hazards:
          'Reversing, blind spots, speeding, pedestrian interaction, poor visibility and unstable loads.',
      controls:
          'Traffic plan • Segregation • Speed control • Banksman • Reversing controls • Signage • Lighting.',
      ppe:
          'High-visibility clothing • Safety footwear • Helmet where required.',
      checklist:
          'Routes defined • Pedestrian segregation • Vehicle checks completed • Speed controlled • Operators competent.',
      documents:
          'Traffic Management Plan / Vehicle Inspection / Driver Competency Records.',
    ),
    _SafetyTopic(
      title: 'Permit to Work',
      description:
          'Control high-risk work through authorization, isolation and documented precautions.',
      purpose:
          'A permit-to-work system ensures hazardous activities are formally assessed and controlled before work starts.',
      hazards:
          'Uncontrolled high-risk work, conflicting activities, inadequate isolation and poor communication.',
      controls:
          'Task identification • Risk assessment • Isolation • Permit authorization • Toolbox talk • Close-out.',
      ppe:
          'Task-specific PPE.',
      checklist:
          'Permit valid • Isolation confirmed • Controls verified • Workers briefed • Permit displayed • Close-out completed.',
      documents:
          'Permit / Isolation Certificate / Toolbox Talk / Close-out Record.',
    ),
    _SafetyTopic(
      title: 'Excavation Safety',
      description:
          'Control collapse, underground services, falls and falling materials.',
      purpose:
          'Excavation safety protects workers from collapse, service strikes, falls and water ingress.',
      hazards:
          'Cave-in, underground utilities, falling materials, plant movement, water and unsafe access.',
      controls:
          'Service detection • Shoring/sloping • Safe access • Edge protection • Spoil setback • Inspection.',
      ppe:
          'Helmet • Safety footwear • High-visibility clothing • Task-specific PPE.',
      checklist:
          'Permit/assessment completed • Services identified • Protection installed • Access provided • Daily inspection completed.',
      documents:
          'Excavation Permit / Service Drawing / Inspection Record / Risk Assessment.',
    ),
    _SafetyTopic(
      title: 'Scaffolding Safety',
      description:
          'Ensure safe scaffold erection, inspection, access, loading and use.',
      purpose:
          'Scaffolding must provide stable and safe access and working platforms.',
      hazards:
          'Collapse, falls, missing guardrails, unstable foundations, overloading and unauthorized alteration.',
      controls:
          'Competent erection • Stable foundation • Guardrails • Toe boards • Safe access • Inspection • Load control.',
      ppe:
          'Helmet • Safety footwear • Fall protection during erection where required.',
      checklist:
          'Foundation stable • Scaffold inspected • Tag/status clear • Guardrails present • Access safe • Load controlled.',
      documents:
          'Scaffold Design/Method • Inspection Record • Handover Certificate.',
    ),
    _SafetyTopic(
      title: 'Hot Work Safety',
      description:
          'Control welding, cutting, grinding and other heat/spark-producing activities.',
      purpose:
          'Hot-work controls prevent fire, explosion, burns and exposure to fumes.',
      hazards:
          'Fire, explosion, sparks, hot surfaces, fumes, gas cylinders and nearby combustible materials.',
      controls:
          'Hot Work Permit • Remove combustibles • Fire watch • Fire extinguisher • Gas cylinder control • Post-work inspection.',
      ppe:
          'Welding helmet • Face shield • Gloves • Flame-resistant clothing • Safety footwear • Respiratory protection where required.',
      checklist:
          'Permit issued • Area inspected • Combustibles removed • Fire extinguisher available • Fire watch assigned.',
      documents:
          'Hot Work Permit / Gas Cylinder Inspection / Fire Watch Record.',
    ),
  ];

  // ============================================================
  // UAE-WIDE REGION
  // ============================================================

  final _SafetyRegion _uaeRegion = const _SafetyRegion(
    id: 'uae',
    title: 'UAE Safety',
    subtitle: 'UAE-wide HSE guidance',
    icon: Icons.flag_rounded,
    color: Color(0xFF159447),
    description:
        'UAE-wide practical HSE guidance for workplaces, construction activities and safety professionals. Local emirate authority requirements must also be checked.',
    topics: [
      _RegionalTopic(
        title: 'UAE HSE Framework',
        description:
            'Understand the UAE-wide HSE approach and the importance of applicable federal and local requirements.',
        purpose:
            'Use a structured HSE management approach while identifying the authority and legal requirements applicable to the emirate, activity and project.',
        hazards:
            'Incorrect legal assumptions, outdated procedures, unclear responsibilities and uncontrolled workplace hazards.',
        controls:
            'Identify applicable legislation • Identify competent authorities • Maintain current procedures • Conduct risk assessment • Monitor compliance.',
        checklist:
            'Applicable requirements identified • HSE responsibilities assigned • Risk assessment current • Procedures communicated • Records maintained.',
        reference:
            'UAE federal requirements and applicable emirate/project authority requirements.',
      ),
      _RegionalTopic(
        title: 'Construction Site Safety',
        description:
            'Core safety controls for construction and infrastructure activities across the UAE.',
        purpose:
            'Provide a structured approach to controlling construction hazards from planning through execution.',
        hazards:
            'Falls, excavation collapse, lifting, plant movement, electrical hazards, temporary works and hot work.',
        controls:
            'Construction risk assessment • Method statements • PTW • Competent supervision • Inspection • Worker induction.',
        checklist:
            'Site induction • Risk assessment • Method statement • PTW where required • Emergency arrangements • Daily inspection.',
        reference:
            'Applicable UAE legislation, emirate authority requirements and approved project HSE procedures.',
      ),
      _RegionalTopic(
        title: 'Worker Welfare',
        description:
            'Basic worker welfare arrangements including drinking water, sanitation, rest and hygiene.',
        purpose:
            'Provide workers with suitable welfare arrangements that support health, hygiene and safe working conditions.',
        hazards:
            'Dehydration, poor hygiene, inadequate sanitation, heat exposure and unsuitable rest facilities.',
        controls:
            'Potable water • Sanitation • Washing facilities • Rest areas • Hygiene • Heat protection.',
        checklist:
            'Water available • Toilets clean • Rest area suitable • Hygiene maintained • Facilities inspected.',
        reference:
            'Applicable UAE labour, occupational safety and project requirements.',
      ),
      _RegionalTopic(
        title: 'Emergency Response',
        description:
            'Prepare for fire, medical, environmental and other workplace emergencies.',
        purpose:
            'Ensure workers understand alarms, evacuation, communication and emergency responsibilities.',
        hazards:
            'Delayed response, blocked evacuation routes and inadequate emergency resources.',
        controls:
            'Emergency plan • Alarm • Assembly point • Emergency contacts • Drills • Trained responders.',
        checklist:
            'Emergency plan available • Routes clear • Assembly point marked • Emergency equipment inspected • Drill records maintained.',
        reference:
            'Applicable civil defence, authority and project emergency requirements.',
      ),
      _RegionalTopic(
        title: 'UAE Heat & Outdoor Work',
        description:
            'Manage heat exposure during outdoor and physically demanding work.',
        purpose:
            'Prevent heat-related illness through work planning, hydration, rest, shade and worker monitoring.',
        hazards:
            'Heat, humidity, direct sun, heavy work and dehydration.',
        controls:
            'Heat-risk assessment • Water • Rest • Shade • Acclimatization • Monitoring • Emergency response.',
        checklist:
            'Heat controls active • Water available • Rest area available • Workers briefed • Symptoms monitored.',
        reference:
            'Applicable UAE and emirate-specific heat-stress requirements.',
      ),
      _RegionalTopic(
        title: 'Environmental Protection',
        description:
            'Control waste, spills, dust, noise and other environmental impacts.',
        purpose:
            'Reduce environmental harm from workplace and construction operations.',
        hazards:
            'Waste, spills, dust, emissions, contaminated water and uncontrolled discharge.',
        controls:
            'Waste segregation • Spill prevention • Dust suppression • Controlled storage • Environmental inspection.',
        checklist:
            'Waste controlled • Spill kit available • Dust controlled • Storage secure • Records maintained.',
        reference:
            'Applicable UAE federal, emirate and environmental authority requirements.',
      ),
    ],
  );

  // ============================================================
  // DUBAI REGION
  // Based on Dubai Municipality Health & Safety Technical Guidelines
  // ============================================================

  final _SafetyRegion _dubaiRegion = const _SafetyRegion(
    id: 'dubai',
    title: 'Dubai Safety',
    subtitle: 'Dubai Municipality & Dubai-specific HSE',
    icon: Icons.location_city_rounded,
    color: Color(0xFF1677C8),
    description:
        'Dubai-focused HSE guidance based around Dubai Municipality health and safety guidance and Dubai-specific workplace and construction topics.',
    topics: [
      _RegionalTopic(
        title: 'Dubai Health & Safety Risk Assessment',
        description:
            'Structured risk assessment for Dubai workplaces and built-environment activities.',
        purpose:
            'Identify hazards, evaluate risk and establish suitable controls before and during work.',
        hazards:
            'Uncontrolled workplace hazards, construction hazards, plant interaction and changing site conditions.',
        controls:
            'Hazard identification • Risk evaluation • Hierarchy of controls • Worker consultation • Review after changes.',
        checklist:
            'Assessment completed • Controls assigned • Responsible person identified • Workers briefed • Review date established.',
        reference:
            'Dubai Municipality Health & Safety Technical Guideline 137 and applicable project requirements.',
      ),
      _RegionalTopic(
        title: 'Dubai Safe Forklift Operations',
        description:
            'Control powered forklift operations, loading, movement and pedestrian interaction.',
        purpose:
            'Prevent collisions, overturning, dropped loads and pedestrian injuries during forklift operations.',
        hazards:
            'Overloading, unstable loads, reversing, blind spots, speeding and untrained operators.',
        controls:
            'Competent operator • Pre-use inspection • Load control • Speed control • Pedestrian segregation • Safe parking.',
        checklist:
            'Operator competent • Forklift inspected • Load within capacity • Route clear • Pedestrians segregated.',
        reference:
            'Dubai Municipality Technical Guideline 146 for Safe Forklifts Operations.',
      ),
      _RegionalTopic(
        title: 'Dubai Safe Storage',
        description:
            'Safe storage arrangements for materials, equipment and workplace goods.',
        purpose:
            'Prevent falling objects, unstable stacks, blocked access and storage-related fire or handling hazards.',
        hazards:
            'Unstable stacking, overloaded shelves, falling materials, blocked routes and incompatible storage.',
        controls:
            'Stable stacking • Load limits • Clear aisles • Suitable racks • Inspection • Good housekeeping.',
        checklist:
            'Stacks stable • Shelves within capacity • Aisles clear • Heavy items positioned safely • Storage inspected.',
        reference:
            'Dubai Municipality Technical Guideline 148 for Safe Storage.',
      ),
      _RegionalTopic(
        title: 'Dubai Confined Space Entry',
        description:
            'Controls for confined-space entry within Dubai workplaces and projects.',
        purpose:
            'Prevent atmospheric exposure, engulfment, falls and difficult rescue situations.',
        hazards:
            'Oxygen deficiency, toxic gases, flammable atmosphere, engulfment and restricted access.',
        controls:
            'Risk assessment • Isolation • Gas testing • Ventilation • Entry control • Standby person • Rescue plan.',
        checklist:
            'Permit • Isolation • Gas test • Ventilation • Standby person • Communication • Rescue equipment.',
        reference:
            'Dubai Municipality Technical Guideline 39 for Confined Spaces Entry.',
      ),
      _RegionalTopic(
        title: 'Dubai Heat Stress Management',
        description:
            'Manage heat exposure for workers performing outdoor or physically demanding work in Dubai.',
        purpose:
            'Reduce heat illness through suitable planning, hydration, rest, shade and worker monitoring.',
        hazards:
            'High temperature, humidity, direct sunlight and strenuous activity.',
        controls:
            'Heat assessment • Work/rest planning • Water • Shade • Acclimatization • Monitoring • Emergency response.',
        checklist:
            'Water • Shade • Rest • Heat briefing • Monitoring • Emergency arrangements.',
        reference:
            'Dubai Municipality Technical Guideline 38 for Management of Heat Stress at Work.',
      ),
      _RegionalTopic(
        title: 'Dubai Dangerous Machinery Guarding',
        description:
            'Control dangerous moving machinery and machinery guarding hazards.',
        purpose:
            'Prevent contact with moving parts, crushing, entanglement and other machinery injuries.',
        hazards:
            'Unprotected moving parts, unexpected start-up, maintenance access and bypassed guards.',
        controls:
            'Suitable guarding • Isolation • Interlocks where appropriate • Maintenance control • Competent operation.',
        checklist:
            'Guards installed • Guards intact • Emergency stop available • Isolation procedure known • Operators trained.',
        reference:
            'Dubai Municipality Technical Guideline 41 for Guarding of Dangerous Machinery.',
      ),
      _RegionalTopic(
        title: 'Dubai Indoor Air Quality',
        description:
            'Control workplace indoor-air-quality risks in buildings and occupied areas.',
        purpose:
            'Reduce health impacts associated with inadequate ventilation, contaminants, mould and poor indoor environmental conditions.',
        hazards:
            'Poor ventilation, dust, mould, chemical contaminants and inadequate air exchange.',
        controls:
            'Ventilation assessment • HVAC maintenance • Source control • Cleaning • Monitoring where required.',
        checklist:
            'Ventilation functional • HVAC maintained • Contamination controlled • Complaints investigated.',
        reference:
            'Dubai Municipality Environmental Indoor Air Quality guidance.',
      ),
      _RegionalTopic(
        title: 'Dubai Organic Solvent Safety',
        description:
            'Safe use and control of industrial organic solvents.',
        purpose:
            'Prevent inhalation, skin exposure, fire and uncontrolled chemical release.',
        hazards:
            'Flammable vapour, toxic exposure, skin contact and incompatible storage.',
        controls:
            'SDS • Ventilation • Ignition control • Suitable storage • PPE • Spill response.',
        checklist:
            'Containers labelled • SDS available • Ventilation adequate • Ignition controlled • Spill kit available.',
        reference:
            'Dubai Municipality Technical Guideline 43 for Safe Use of Industrial Organic Solvents.',
      ),
      _RegionalTopic(
        title: 'Dubai Waste Management',
        description:
            'Safe segregation, handling, storage and disposal of workplace waste.',
        purpose:
            'Prevent injuries, contamination, environmental releases and poor housekeeping.',
        hazards:
            'Sharp waste, chemical waste, mixed waste, spills and uncontrolled accumulation.',
        controls:
            'Segregation • Labelling • Suitable containers • Collection • Controlled storage • Approved disposal.',
        checklist:
            'Bins suitable • Waste segregated • Containers closed • Collection scheduled • Area clean.',
        reference:
            'Applicable Dubai Municipality waste and environmental requirements.',
      ),
      _RegionalTopic(
        title: 'Dubai Kitchen & Food Area Safety',
        description:
            'Health and safety controls for kitchen and food-preparation work areas.',
        purpose:
            'Control slips, burns, cuts, food-area hygiene and equipment hazards.',
        hazards:
            'Hot surfaces, knives, slips, chemicals, gas/electrical equipment and poor hygiene.',
        controls:
            'Safe equipment • Housekeeping • Slip prevention • PPE • Chemical control • Emergency arrangements.',
        checklist:
            'Floors clean • Equipment guarded • Knives stored safely • Chemicals controlled • Emergency equipment available.',
        reference:
            'Dubai Municipality Health and Safety guidance for kitchen and food areas.',
      ),
    ],
  );

  // ============================================================
  // ABU DHABI REGION
  // Based on ADOSH-SF official framework
  // ============================================================

  final _SafetyRegion _abuDhabiRegion = const _SafetyRegion(
    id: 'abu_dhabi',
    title: 'Abu Dhabi Safety',
    subtitle: 'ADOSH-SF occupational safety & health',
    icon: Icons.account_balance_rounded,
    color: Color(0xFF6736C8),
    description:
        'Abu Dhabi-focused OSH guidance structured around the ADOSH-SF framework, Codes of Practice, Mechanisms and Technical Guidelines.',
    topics: [
      _RegionalTopic(
        title: 'ADOSH-SF Framework',
        description:
            'Understand the Abu Dhabi Occupational Safety and Health System Framework.',
        purpose:
            'Provide a clear understanding of the structure and principles used to manage occupational safety and health in Abu Dhabi.',
        hazards:
            'Unclear OSH responsibilities, inadequate management systems and failure to identify applicable requirements.',
        controls:
            'Understand the Manual • Management System Elements • Mechanisms • Codes of Practice • Technical Guidelines.',
        checklist:
            'Applicable ADOSH-SF requirements identified • OSH responsibilities defined • System documented • Records maintained.',
        reference:
            'ADOSH-SF Version 4.0 official Manual and framework documents.',
      ),
      _RegionalTopic(
        title: 'ADOSH-SF Management System',
        description:
            'Minimum management-system requirements for applicable entities in Abu Dhabi.',
        purpose:
            'Establish a systematic approach to occupational safety and health management.',
        hazards:
            'Weak leadership, inadequate planning, poor consultation, insufficient monitoring and incomplete corrective actions.',
        controls:
            'Policy • Planning • Risk management • Consultation • Training • Monitoring • Review • Improvement.',
        checklist:
            'OSH policy • Roles defined • Objectives established • Risk process active • Monitoring completed • Review performed.',
        reference:
            'ADOSH-SF Management System Elements V4.0.',
      ),
      _RegionalTopic(
        title: 'Abu Dhabi Risk Management',
        description:
            'Identify and control occupational safety and health risks under the ADOSH-SF approach.',
        purpose:
            'Ensure workplace hazards are identified, assessed and controlled systematically.',
        hazards:
            'Unidentified hazards, inadequate controls and changes not reflected in risk assessments.',
        controls:
            'Hazard identification • Risk assessment • Hierarchy of controls • Consultation • Review.',
        checklist:
            'Risk assessment current • Controls implemented • Workers consulted • Changes reviewed.',
        reference:
            'ADOSH-SF requirements and applicable Codes of Practice.',
      ),
      _RegionalTopic(
        title: 'ADOSH-SF Personal Protective Equipment',
        description:
            'PPE requirements and management for Abu Dhabi workplaces.',
        purpose:
            'Ensure PPE is selected and managed according to assessed workplace hazards.',
        hazards:
            'Incorrect PPE, poor fit, damaged equipment and reliance on PPE instead of higher-level controls.',
        controls:
            'Hazard-based selection • Fit • Inspection • Maintenance • Replacement • Training.',
        checklist:
            'PPE assessment • Correct PPE • Fit checked • Inspection • Training • Replacement process.',
        reference:
            'ADOSH-SF CoP 2.0 Personal Protective Equipment V4.0.',
      ),
      _RegionalTopic(
        title: 'Abu Dhabi Occupational Noise',
        description:
            'Control worker exposure to occupational noise.',
        purpose:
            'Prevent hearing damage through exposure assessment and suitable controls.',
        hazards:
            'High noise from machinery, construction equipment and industrial activities.',
        controls:
            'Noise assessment • Engineering controls • Administrative controls • Hearing protection • Health monitoring where required.',
        checklist:
            'Noise assessed • Sources identified • Controls applied • Hearing protection available • Monitoring considered.',
        reference:
            'ADOSH-SF CoP 3.0 Occupational Noise V4.0.',
      ),
      _RegionalTopic(
        title: 'Abu Dhabi Vibration',
        description:
            'Control exposure to hand-arm and whole-body vibration.',
        purpose:
            'Reduce occupational health risks from vibration-producing tools, equipment and vehicles.',
        hazards:
            'Long exposure duration, high-vibration tools and poorly maintained equipment.',
        controls:
            'Exposure assessment • Low-vibration equipment • Maintenance • Exposure limits/time management • Health monitoring.',
        checklist:
            'Equipment identified • Exposure assessed • Controls implemented • Workers informed • Monitoring considered.',
        reference:
            'ADOSH-SF CoP 3.1 Vibration V4.0.',
      ),
      _RegionalTopic(
        title: 'Abu Dhabi First Aid & Medical Emergency',
        description:
            'Establish suitable first-aid and medical emergency arrangements.',
        purpose:
            'Ensure appropriate immediate care and emergency medical response.',
        hazards:
            'Delayed treatment, inadequate first-aid arrangements and poor emergency communication.',
        controls:
            'First-aid assessment • Trained personnel • Equipment • Emergency communication • Medical access.',
        checklist:
            'First-aid facilities • Trained first aiders • Equipment checked • Emergency contacts • Access maintained.',
        reference:
            'ADOSH-SF CoP 4.0 First Aid and Medical Emergency Treatment V4.0.',
      ),
      _RegionalTopic(
        title: 'Abu Dhabi Occupational Health',
        description:
            'Occupational health screening and medical surveillance where applicable.',
        purpose:
            'Identify and manage work-related health risks through suitable assessment and surveillance.',
        hazards:
            'Noise, chemicals, vibration, heat, ergonomic and other occupational exposures.',
        controls:
            'Exposure assessment • Health screening • Medical surveillance where required • Preventive controls.',
        checklist:
            'Exposure identified • Health requirements assessed • Surveillance arranged where applicable • Records controlled.',
        reference:
            'ADOSH-SF CoP 5.0 Occupational Health Screening and Medical Surveillance.',
      ),
      _RegionalTopic(
        title: 'Abu Dhabi Safety in the Heat',
        description:
            'Control occupational heat exposure in Abu Dhabi workplaces.',
        purpose:
            'Prevent heat-related illness through planning, hydration, rest, shade, acclimatization and monitoring.',
        hazards:
            'Heat, humidity, direct sunlight, physical work and dehydration.',
        controls:
            'Heat-risk assessment • Water • Rest • Shade • Acclimatization • Monitoring • Emergency response.',
        checklist:
            'Heat controls • Water • Rest/shade • Worker briefing • Monitoring • Emergency plan.',
        reference:
            'ADOSH-SF CoP 11.0 Safety in the Heat V4.0.',
      ),
      _RegionalTopic(
        title: 'Abu Dhabi Electrical Safety',
        description:
            'Control electrical risks in Abu Dhabi workplaces and projects.',
        purpose:
            'Prevent electric shock, burns, fire and electrical equipment incidents.',
        hazards:
            'Live parts, damaged cables, poor isolation, unsuitable equipment and unauthorized work.',
        controls:
            'Competent persons • Isolation • LOTO • Inspection • Protection • Controlled access.',
        checklist:
            'Isolation • Inspection • Competent worker • Protective devices • Equipment condition verified.',
        reference:
            'ADOSH-SF CoP 15.0 Electrical Safety V4.0.',
      ),
      _RegionalTopic(
        title: 'Abu Dhabi Permit to Work',
        description:
            'Formal control of high-risk work activities.',
        purpose:
            'Ensure hazardous work is authorized, assessed, isolated and controlled.',
        hazards:
            'Conflicting work, inadequate isolation, uncontrolled energy and insufficient communication.',
        controls:
            'Task assessment • Isolation • Permit authorization • Precautions • Toolbox talk • Close-out.',
        checklist:
            'Permit valid • Isolation verified • Controls checked • Workers briefed • Close-out completed.',
        reference:
            'ADOSH-SF CoP 21.0 Permit to Work Systems V4.0.',
      ),
      _RegionalTopic(
        title: 'Abu Dhabi Working at Heights',
        description:
            'Fall-prevention and fall-protection requirements for elevated work.',
        purpose:
            'Prevent falls through planning, safe access, edge protection and suitable fall protection.',
        hazards:
            'Falls from edges, roofs, scaffolds, platforms and fragile surfaces.',
        controls:
            'Avoid • Safe access • Guardrails • Edge protection • Fall protection • Rescue planning.',
        checklist:
            'Risk assessment • Access inspected • Protection installed • Equipment checked • Rescue plan.',
        reference:
            'ADOSH-SF CoP 23.0 Working at Heights V4.1.',
      ),
      _RegionalTopic(
        title: 'Abu Dhabi Lockout / Tagout',
        description:
            'Control hazardous energy during maintenance and intervention.',
        purpose:
            'Prevent unexpected energization or release of stored energy.',
        hazards:
            'Electrical energy, mechanical movement, pressure, hydraulic/pneumatic energy and stored energy.',
        controls:
            'Identify energy • Shut down • Isolate • Lock • Tag • Verify zero energy • Controlled restoration.',
        checklist:
            'Energy sources identified • Isolation applied • Locks/tags installed • Zero energy verified • Restoration controlled.',
        reference:
            'ADOSH-SF CoP 24.0 Lock-out Tag-out (Isolation) V4.1.',
      ),
      _RegionalTopic(
        title: 'Abu Dhabi Construction OSH',
        description:
            'Occupational safety and health management during construction work.',
        purpose:
            'Control construction risks through planning, supervision, coordination and monitoring.',
        hazards:
            'Falls, lifting, excavation, temporary works, plant movement, electrical and simultaneous activities.',
        controls:
            'Construction OSH management • Risk assessment • Coordination • Inspection • Competent supervision.',
        checklist:
            'Construction OSH plan • Risk assessments • Coordination • Inspections • Corrective actions.',
        reference:
            'ADOSH-SF CoP 53.0 OSH Management During Construction Work and CoP 53.1.',
      ),
      _RegionalTopic(
        title: 'Abu Dhabi Hazardous Materials',
        description:
            'Control hazardous-material storage, handling, exposure and emergency response.',
        purpose:
            'Prevent chemical exposure, fire, uncontrolled releases and unsafe handling.',
        hazards:
            'Toxicity, corrosivity, flammability, incompatible chemicals and spills.',
        controls:
            'SDS • Labelling • Storage • Exposure control • PPE • Spill response • Disposal.',
        checklist:
            'Chemical register • SDS • Labels • Compatible storage • Spill kit • Worker training.',
        reference:
            'ADOSH-SF CoP 1.0 Hazardous Materials V4.0.',
      ),
      _RegionalTopic(
        title: 'Abu Dhabi Asbestos Management',
        description:
            'Manage asbestos-containing materials and prevent fibre exposure.',
        purpose:
            'Prevent exposure to asbestos fibres during identification, maintenance, demolition or removal.',
        hazards:
            'Disturbance of asbestos-containing materials and uncontrolled fibre release.',
        controls:
            'Survey • Identification • Competent management • Controlled work • Appropriate containment and disposal.',
        checklist:
            'Survey completed • Material identified • Competent contractor • Control plan • Disposal controlled.',
        reference:
            'ADOSH-SF CoP 1.1 Management of Asbestos Containing Materials V4.1.',
      ),
      _RegionalTopic(
        title: 'Abu Dhabi Lead Exposure',
        description:
            'Control occupational exposure to lead.',
        purpose:
            'Prevent harmful lead exposure through assessment, engineering controls and health protection.',
        hazards:
            'Lead dust/fumes from specific processes and contaminated materials.',
        controls:
            'Exposure assessment • Engineering controls • Hygiene • PPE • Health surveillance where required.',
        checklist:
            'Exposure identified • Controls implemented • Hygiene facilities • PPE • Monitoring where applicable.',
        reference:
            'ADOSH-SF CoP 1.2 Lead Exposure Management V4.0.',
      ),
      _RegionalTopic(
        title: 'Abu Dhabi Safety Signage',
        description:
            'Use suitable safety signs, signals and workplace communication.',
        purpose:
            'Provide clear warnings, prohibitions, mandatory instructions and emergency information.',
        hazards:
            'Poor visibility, missing signs, conflicting signs and inadequate worker communication.',
        controls:
            'Correct sign selection • Suitable location • Visibility • Maintenance • Worker awareness.',
        checklist:
            'Signs visible • Correct meaning • Good condition • Emergency signs clear • Obstructions removed.',
        reference:
            'ADOSH-SF CoP 17.0 Safety Signage and Signals V4.0.',
      ),
      _RegionalTopic(
        title: 'Abu Dhabi Waste Management',
        description:
            'Control waste generation, segregation, storage and disposal.',
        purpose:
            'Prevent injury, contamination and environmental impact from workplace waste.',
        hazards:
            'Mixed waste, hazardous waste, sharp materials, spills and uncontrolled accumulation.',
        controls:
            'Segregation • Labelling • Suitable containers • Controlled storage • Approved disposal.',
        checklist:
            'Waste segregated • Containers suitable • Labels clear • Storage controlled • Disposal records maintained.',
        reference:
            'ADOSH-SF CoP 54.0 Waste Management V4.0.',
      ),
      _RegionalTopic(
        title: 'Abu Dhabi Incident Reporting',
        description:
            'Understand incident notification, investigation and reporting requirements.',
        purpose:
            'Ensure relevant OSH incidents are reported, investigated and followed by corrective actions.',
        hazards:
            'Delayed notification, inadequate investigation and repeat incidents.',
        controls:
            'Immediate notification as applicable • Investigation • Root-cause analysis • Corrective action • Follow-up.',
        checklist:
            'Incident reported • Evidence preserved • Investigation completed • Actions assigned • Close-out verified.',
        reference:
            'ADOSH-SF Mechanism 11.0 Incident Notification, Investigation and Reporting.',
      ),
      _RegionalTopic(
        title: 'Abu Dhabi Audit & Inspection',
        description:
            'Use audits and inspections to verify OSH controls and continual improvement.',
        purpose:
            'Identify gaps, verify compliance and ensure corrective actions are effective.',
        hazards:
            'Unidentified non-conformances, ineffective corrective actions and poor follow-up.',
        controls:
            'Inspection programme • Audit • Findings • Corrective action • Verification • Management review.',
        checklist:
            'Schedule established • Findings recorded • Actions assigned • Due dates set • Effectiveness verified.',
        reference:
            'ADOSH-SF Technical Guideline on Audit and Inspection V4.0.',
      ),
    ],
  );

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final query = _query.trim().toLowerCase();

    final generalResults = _generalTopics.where((topic) {
      return query.isEmpty ||
          topic.title.toLowerCase().contains(query) ||
          topic.description.toLowerCase().contains(query);
    }).toList();

    final regionResults = <_RegionalTopic>[];

    if (query.isNotEmpty) {
      for (final topic in _uaeRegion.topics) {
        if (_matchesRegionalTopic(topic, query)) {
          regionResults.add(topic);
        }
      }

      for (final topic in _dubaiRegion.topics) {
        if (_matchesRegionalTopic(topic, query)) {
          regionResults.add(topic);
        }
      }

      for (final topic in _abuDhabiRegion.topics) {
        if (_matchesRegionalTopic(topic, query)) {
          regionResults.add(topic);
        }
      }
    }

    final searching = query.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: const Text(
          'HSE Guidelines',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        children: [
          _buildIntroCard(),

          const SizedBox(height: 18),

          TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _query = value;
              });
            },
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'Search HSE guidelines',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: _query.isEmpty
                  ? null
                  : IconButton(
                      tooltip: 'Clear search',
                      icon: const Icon(Icons.clear_rounded),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _query = '';
                        });
                      },
                    ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFF159447),
                  width: 1.4,
                ),
              ),
            ),
          ),

          const SizedBox(height: 22),

          if (!searching) ...[
            const Text(
              'UAE HSE SAFETY',
              style: TextStyle(
                color: Color(0xFF087A38),
                fontSize: 14,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Choose your safety guidance area',
              style: TextStyle(
                color: Color(0xFF707070),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),

            _buildRegionCard(context, _uaeRegion),
            _buildRegionCard(context, _dubaiRegion),
            _buildRegionCard(context, _abuDhabiRegion),

            const SizedBox(height: 18),

            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Safety Reference Library',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Text(
                  '${_generalTopics.length} topics',
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),

            const Text(
              'General practical HSE reference topics',
              style: TextStyle(
                color: Color(0xFF777777),
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 10),

            ...generalResults.asMap().entries.map(
                  (entry) => _buildGeneralTopicCard(
                    context,
                    entry.key + 1,
                    entry.value,
                  ),
                ),
          ],

          if (searching) ...[
            const Text(
              'SEARCH RESULTS',
              style: TextStyle(
                color: Color(0xFF087A38),
                fontSize: 14,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 10),

            if (generalResults.isEmpty && regionResults.isEmpty)
              _buildEmptySearchState()
            else ...[
              if (generalResults.isNotEmpty) ...[
                const Text(
                  'General UAE HSE',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                ...generalResults.asMap().entries.map(
                      (entry) => _buildGeneralTopicCard(
                        context,
                        entry.key + 1,
                        entry.value,
                      ),
                    ),
              ],

              if (regionResults.isNotEmpty) ...[
                const SizedBox(height: 8),
                const Text(
                  'Regional HSE',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                ...regionResults.map(
                  (topic) => _buildSearchRegionalCard(
                    context,
                    topic,
                  ),
                ),
              ],
            ],
          ],
        ],
      ),
    );
  }

  bool _matchesRegionalTopic(
    _RegionalTopic topic,
    String query,
  ) {
    return topic.title.toLowerCase().contains(query) ||
        topic.description.toLowerCase().contains(query) ||
        topic.purpose.toLowerCase().contains(query) ||
        topic.reference.toLowerCase().contains(query);
  }

  // ============================================================
  // INTRO
  // ============================================================

  Widget _buildIntroCard() {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0B5D4B),
            Color(0xFF159447),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 14,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0x22FFFFFF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'UAE HSE Safety Centre',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'UAE-wide, Dubai and Abu Dhabi focused HSE reference guidance for safety professionals and workplaces.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // REGION CARD
  // ============================================================

  Widget _buildRegionCard(
    BuildContext context,
    _SafetyRegion region,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RegionalSafetyPage(region: region),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: region.color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  region.icon,
                  color: region.color,
                  size: 27,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      region.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      region.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF777777),
                        fontSize: 11.5,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${region.topics.length} topics',
                      style: TextStyle(
                        color: region.color,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                color: region.color,
                size: 27,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // GENERAL TOPIC CARD
  // ============================================================

  Widget _buildGeneralTopicCard(
    BuildContext context,
    int number,
    _SafetyTopic topic,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => GeneralTopicPage(topic: topic),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFE7F3EF),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text(
                  '$number',
                  style: const TextStyle(
                    color: Color(0xFF0B5D4B),
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      topic.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.35,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchRegionalCard(
    BuildContext context,
    _RegionalTopic topic,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        title: Text(
          topic.title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          topic.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RegionalTopicPage(
                regionTitle: _findRegionForTopic(topic).title,
                regionColor: _findRegionForTopic(topic).color,
                regionIcon: _findRegionForTopic(topic).icon,
                topic: topic,
              ),
            ),
          );
        },
      ),
    );
  }

  _SafetyRegion _findRegionForTopic(_RegionalTopic topic) {
    if (_uaeRegion.topics.contains(topic)) {
      return _uaeRegion;
    }

    if (_dubaiRegion.topics.contains(topic)) {
      return _dubaiRegion;
    }

    return _abuDhabiRegion;
  }

  Widget _buildEmptySearchState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 52,
            color: Theme.of(context)
                .colorScheme
                .onSurfaceVariant,
          ),
          const SizedBox(height: 12),
          const Text(
            'No guidelines found',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try a different keyword or search by HSE topic.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// REGIONAL SAFETY PAGE
// ============================================================

class RegionalSafetyPage extends StatelessWidget {
  final _SafetyRegion region;

  const RegionalSafetyPage({
    super.key,
    required this.region,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: Text(
          region.title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        children: [
          Container(
            padding: const EdgeInsets.all(19),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: region.color.withValues(alpha: 0.20),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: region.color.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    region.icon,
                    color: region.color,
                    size: 29,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        region.title,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        region.subtitle,
                        style: TextStyle(
                          color: region.color,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        region.description,
                        style: const TextStyle(
                          color: Color(0xFF666666),
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Text(
            '${region.topics.length} SAFETY TOPICS',
            style: TextStyle(
              color: region.color,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),

          const SizedBox(height: 10),

          ...region.topics.asMap().entries.map(
                (entry) => _buildRegionalTopicCard(
                  context,
                  entry.key + 1,
                  entry.value,
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildRegionalTopicCard(
    BuildContext context,
    int number,
    _RegionalTopic topic,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RegionalTopicPage(
                regionTitle: region.title,
                regionColor: region.color,
                regionIcon: region.icon,
                topic: topic,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 13,
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: region.color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$number',
                  style: TextStyle(
                    color: region.color,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      topic.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF777777),
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: region.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// GENERAL TOPIC DETAIL PAGE
// ============================================================

class GeneralTopicPage extends StatelessWidget {
  final _SafetyTopic topic;

  const GeneralTopicPage({
    super.key,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF159447);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: Text(
          topic.title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        children: [
          _detailHeader(
            color: color,
            icon: Icons.shield_rounded,
            title: topic.title,
            subtitle: 'UAE-wide HSE Reference',
          ),
          const SizedBox(height: 16),
          _infoCard(
            color: color,
            icon: Icons.info_outline_rounded,
            title: 'Purpose',
            content: topic.purpose,
          ),
          _infoCard(
            color: color,
            icon: Icons.warning_amber_rounded,
            title: 'Main Hazards',
            content: topic.hazards,
          ),
          _infoCard(
            color: color,
            icon: Icons.rule_rounded,
            title: 'Key Controls',
            content: topic.controls,
          ),
          _infoCard(
            color: color,
            icon: Icons.health_and_safety_rounded,
            title: 'PPE',
            content: topic.ppe,
          ),
          _infoCard(
            color: color,
            icon: Icons.checklist_rounded,
            title: 'Quick Checklist',
            content: topic.checklist,
          ),
          _infoCard(
            color: color,
            icon: Icons.description_outlined,
            title: 'Recommended Records',
            content: topic.documents,
          ),
          _importantCard(),
        ],
      ),
    );
  }
}

// ============================================================
// REGIONAL TOPIC DETAIL PAGE
// ============================================================

class RegionalTopicPage extends StatelessWidget {
  final String regionTitle;
  final Color regionColor;
  final IconData regionIcon;
  final _RegionalTopic topic;

  const RegionalTopicPage({
    super.key,
    required this.regionTitle,
    required this.regionColor,
    required this.regionIcon,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: Text(
          topic.title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        children: [
          _detailHeader(
            color: regionColor,
            icon: regionIcon,
            title: topic.title,
            subtitle: regionTitle,
          ),
          const SizedBox(height: 16),
          _infoCard(
            color: regionColor,
            icon: Icons.info_outline_rounded,
            title: 'Purpose',
            content: topic.purpose,
          ),
          _infoCard(
            color: regionColor,
            icon: Icons.warning_amber_rounded,
            title: 'Main Hazards',
            content: topic.hazards,
          ),
          _infoCard(
            color: regionColor,
            icon: Icons.rule_rounded,
            title: 'Key Controls',
            content: topic.controls,
          ),
          _infoCard(
            color: regionColor,
            icon: Icons.health_and_safety_rounded,
            title: 'PPE',
            content: topic.ppe,
          ),
          _infoCard(
            color: regionColor,
            icon: Icons.checklist_rounded,
            title: 'Quick Checklist',
            content: topic.checklist,
          ),
          _infoCard(
            color: regionColor,
            icon: Icons.menu_book_rounded,
            title: 'Official / Authority Reference',
            content: topic.reference,
          ),
          _importantCard(),
        ],
      ),
    );
  }
}

// ============================================================
// DETAIL UI HELPERS
// ============================================================

Widget _detailHeader({
  required Color color,
  required IconData icon,
  required String title,
  required String subtitle,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: [
          color,
          color.withValues(alpha: 0.78),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 32,
        ),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _infoCard({
  required Color color,
  required IconData icon,
  required String title,
  required String content,
}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
      border: Border.all(
        color: Colors.grey.shade200,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: color,
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                content,
                style: const TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _importantCard() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF8E7),
      borderRadius: BorderRadius.circular(17),
      border: Border.all(
        color: const Color(0xFFE8C96A),
      ),
    ),
    child: const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.warning_amber_rounded,
          color: Color(0xFF9A6B00),
          size: 24,
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Important',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF765300),
                ),
              ),
              SizedBox(height: 6),
              Text(
                'This app provides practical HSE awareness and reference guidance. It is not a substitute for current legislation, regulator requirements, authority-issued documents, approved project procedures or competent professional advice. Always verify the latest applicable requirements for the location and activity.',
                style: TextStyle(
                  color: Color(0xFF765300),
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// DATA MODELS
// ============================================================

class _SafetyTopic {
  final String title;
  final String description;
  final String purpose;
  final String hazards;
  final String controls;
  final String ppe;
  final String checklist;
  final String documents;

  const _SafetyTopic({
    required this.title,
    required this.description,
    required this.purpose,
    required this.hazards,
    required this.controls,
    required this.ppe,
    required this.checklist,
    required this.documents,
  });
}

class _RegionalTopic {
  final String title;
  final String description;
  final String purpose;
  final String hazards;
  final String controls;
  final String ppe;
  final String checklist;
  final String reference;

  const _RegionalTopic({
    required this.title,
    required this.description,
    required this.purpose,
    required this.hazards,
    required this.controls,
    required this.ppe,
    required this.checklist,
    required this.reference,
  });
}

class _SafetyRegion {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String description;
  final List<_RegionalTopic> topics;

  const _SafetyRegion({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.description,
    required this.topics,
  });
}
