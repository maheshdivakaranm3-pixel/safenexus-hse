
import 'industrial_part1.dart';

final List<IndustrialTopic> industrialPart3 = [
  // 61–70: Warehouse, Logistics & Material Handling

  IndustrialTopic(
    title: 'Warehouse HSE Management',
    purpose: 'Establish safe warehouse operations, storage, access and housekeeping.',
    hazards: ['Falling materials', 'Vehicle collision', 'Fire', 'Slips and trips'],
    controls: ['Maintain clear aisles', 'Apply safe stacking limits', 'Separate pedestrians and vehicles', 'Inspect storage areas'],
    documents: ['Warehouse risk assessment', 'Inspection checklist', 'Emergency plan', 'Training records'],
    emergencyResponse: 'Stop operations, isolate the affected area, raise the alarm and arrange first aid or emergency response.',
    siteExample: 'Keep emergency exits and forklift routes clear in a UAE industrial warehouse.',
    imagePath: 'assets/images/industrial/warehouse_hse.png',
  ),

  IndustrialTopic(
    title: 'Forklift & Powered Industrial Trucks',
    purpose: 'Control risks during operation of forklifts and powered industrial trucks.',
    hazards: ['Vehicle overturning', 'Pedestrian strike', 'Falling loads', 'Blind spots'],
    controls: ['Authorized trained operators only', 'Pre-use inspection', 'Seat belt use', 'Speed limits', 'Pedestrian segregation'],
    documents: ['Operator authorization', 'Daily checklist', 'Maintenance records', 'Traffic plan'],
    emergencyResponse: 'Stop the vehicle, secure the scene, summon emergency assistance and do not move an injured person unless necessary for safety.',
    siteExample: 'Use a trained banksman where forklift movement crosses pedestrian routes.',
    imagePath: 'assets/images/industrial/forklift_safety.png',
  ),

  IndustrialTopic(
    title: 'Industrial Traffic & Pedestrian Management',
    purpose: 'Prevent collisions between vehicles, mobile equipment and pedestrians.',
    hazards: ['Vehicle impact', 'Reversing incidents', 'Poor visibility', 'Congestion'],
    controls: ['Approved traffic plan', 'Marked walkways', 'One-way routes where practical', 'Speed control', 'Reversing alarms and banksmen'],
    documents: ['Traffic management plan', 'Vehicle inspection records', 'Driver competency records'],
    emergencyResponse: 'Stop traffic, secure the area, call emergency services and preserve the incident scene.',
    siteExample: 'Separate truck loading routes from worker access paths.',
    imagePath: 'assets/images/industrial/traffic_management.png',
  ),

  IndustrialTopic(
    title: 'Industrial Racking & Storage Safety',
    purpose: 'Maintain stable storage systems and prevent collapse or falling objects.',
    hazards: ['Rack collapse', 'Falling loads', 'Overloading', 'Forklift impact'],
    controls: ['Display load capacities', 'Inspect beams and uprights', 'Protect rack legs', 'Report damage', 'Use approved repairs'],
    documents: ['Racking inspection checklist', 'Load capacity records', 'Repair reports'],
    emergencyResponse: 'Evacuate the affected aisle, isolate access and arrange competent inspection before reuse.',
    siteExample: 'Quarantine a rack bay with a visibly bent upright.',
    imagePath: 'assets/images/industrial/racking_storage.png',
  ),

  IndustrialTopic(
    title: 'Loading, Unloading & Dock Safety',
    purpose: 'Control vehicle, load and dock-edge risks during material transfer.',
    hazards: ['Vehicle movement', 'Falling from dock', 'Load shift', 'Trailer movement'],
    controls: ['Vehicle immobilization', 'Dock restraints or chocks', 'Safe loading sequence', 'Edge protection', 'Clear communication'],
    documents: ['Loading checklist', 'Vehicle inspection', 'Load securing records'],
    emergencyResponse: 'Stop loading, secure the vehicle and dock area, and activate site emergency arrangements.',
    siteExample: 'Confirm trailer immobilization before forklift entry.',
    imagePath: 'assets/images/industrial/loading_dock.png',
  ),

  IndustrialTopic(
    title: 'Manual Material Handling & Ergonomics',
    purpose: 'Reduce musculoskeletal injuries during lifting, carrying and repetitive work.',
    hazards: ['Back strain', 'Shoulder injury', 'Repetitive strain', 'Dropped loads'],
    controls: ['Mechanical aids', 'Task redesign', 'Team lifting where suitable', 'Load assessment', 'Training'],
    documents: ['Manual handling assessment', 'Training records', 'Ergonomic inspection'],
    emergencyResponse: 'Stop the task, provide first aid and arrange medical assessment for suspected injury.',
    siteExample: 'Use a pallet truck instead of repeated manual movement of heavy cartons.',
    imagePath: 'assets/images/industrial/manual_handling.png',
  ),

  IndustrialTopic(
    title: 'Overhead Crane & Gantry Crane Safety',
    purpose: 'Ensure safe lifting and movement of loads using overhead and gantry cranes.',
    hazards: ['Dropped load', 'Crane collision', 'Electrical contact', 'Crushing'],
    controls: ['Competent operators', 'Pre-use checks', 'Load limits', 'Exclusion zones', 'Clear signals'],
    documents: ['Crane certificates', 'Inspection records', 'Lifting plan', 'Operator authorization'],
    emergencyResponse: 'Stop movement, isolate the area and follow the approved lifting emergency procedure.',
    siteExample: 'Prevent personnel from walking beneath a suspended steel beam.',
    imagePath: 'assets/images/industrial/overhead_crane.png',
  ),

  IndustrialTopic(
    title: 'Lifting Operations, Rigging & Slinging',
    purpose: 'Plan and control lifting operations to prevent load failure and injury.',
    hazards: ['Sling failure', 'Dropped load', 'Overloading', 'Load swing'],
    controls: ['Approved lifting plan', 'Certified equipment', 'Competent rigger', 'Load weight verification', 'Exclusion zone'],
    documents: ['Lifting plan', 'Rigging inspection', 'Certificates', 'Permit where required'],
    emergencyResponse: 'Stop the lift, keep people clear and follow the site lifting emergency plan.',
    siteExample: 'Verify sling capacity and lifting-point suitability before lifting a pump.',
    imagePath: 'assets/images/industrial/rigging_slinging.png',
  ),

  IndustrialTopic(
    title: 'Pallet, Container & Bulk Material Handling',
    purpose: 'Control risks during movement, stacking and transfer of packaged or bulk materials.',
    hazards: ['Load instability', 'Falling materials', 'Dust exposure', 'Pinch points'],
    controls: ['Stable stacking', 'Suitable handling equipment', 'Load restraint', 'Dust control', 'Safe access'],
    documents: ['Material handling procedure', 'Inspection checklist', 'SDS where applicable'],
    emergencyResponse: 'Stop transfer, isolate spilled or unstable material and follow the relevant emergency procedure.',
    siteExample: 'Secure containerized goods before transport within the facility.',
    imagePath: 'assets/images/industrial/bulk_material_handling.png',
  ),

  IndustrialTopic(
    title: 'Automated Warehouse & Material Handling Systems',
    purpose: 'Safely operate automated conveyors, sorters and storage/retrieval equipment.',
    hazards: ['Unexpected startup', 'Entrapment', 'Robot movement', 'Electrical energy'],
    controls: ['Interlocked guards', 'Emergency stops', 'LOTO', 'Authorized access', 'Safe maintenance mode'],
    documents: ['SOP', 'LOTO procedure', 'Inspection records', 'Operator training'],
    emergencyResponse: 'Use emergency stop, isolate energy and prevent restart until the system is confirmed safe.',
    siteExample: 'Apply LOTO before clearing a jammed automated conveyor.',
    imagePath: 'assets/images/industrial/automated_warehouse.png',
  ),

  // 71–80: Industrial Maintenance & Special Work

  IndustrialTopic(
    title: 'Preventive & Predictive Maintenance',
    purpose: 'Maintain equipment integrity and reduce failures during industrial operations.',
    hazards: ['Unexpected startup', 'Stored energy', 'Working at height', 'Hot surfaces'],
    controls: ['Planned maintenance', 'Isolation and LOTO', 'Competent technicians', 'Pre-job risk assessment'],
    documents: ['Maintenance schedule', 'Work order', 'Isolation certificate', 'Inspection records'],
    emergencyResponse: 'Stop work, isolate equipment and activate site response for injury, fire or release.',
    siteExample: 'Verify zero energy before servicing a rotating pump.',
    imagePath: 'assets/images/industrial/preventive_maintenance.png',
  ),

  IndustrialTopic(
    title: 'Hot Work, Welding & Gas Cutting',
    purpose: 'Prevent fire, explosion, burns and harmful welding exposures.',
    hazards: ['Fire', 'Explosion', 'Fumes', 'Burns', 'Cylinder leakage'],
    controls: ['Hot work permit', 'Gas testing where required', 'Fire watch', 'Remove combustibles', 'Suitable PPE and ventilation'],
    documents: ['Hot work permit', 'Gas test record', 'Fire watch checklist', 'Welder competency'],
    emergencyResponse: 'Stop work, raise alarm, isolate gas supply if safe and use firefighting equipment only if trained.',
    siteExample: 'Provide a fire watch during welding near combustible materials.',
    imagePath: 'assets/images/industrial/hot_work_welding.png',
  ),

  IndustrialTopic(
    title: 'Confined Space Entry & Rescue',
    purpose: 'Prevent fatal incidents during entry into tanks, vessels, pits and other confined spaces.',
    hazards: ['Oxygen deficiency', 'Toxic atmosphere', 'Engulfment', 'Restricted rescue'],
    controls: ['Entry permit', 'Isolation', 'Atmospheric testing', 'Standby attendant', 'Rescue plan'],
    documents: ['Confined space permit', 'Gas test record', 'Rescue plan', 'Training records'],
    emergencyResponse: 'Raise alarm and use the planned rescue system. Never allow unprotected spontaneous entry.',
    siteExample: 'Test atmosphere and confirm rescue readiness before tank entry.',
    imagePath: 'assets/images/industrial/confined_space.png',
  ),

  IndustrialTopic(
    title: 'Industrial Work at Height',
    purpose: 'Prevent falls during work above ground or at exposed edges.',
    hazards: ['Falls', 'Falling objects', 'Fragile surfaces', 'Unsafe access'],
    controls: ['Avoid work at height where possible', 'Guardrails', 'Suitable platforms', 'Fall protection', 'Rescue planning'],
    documents: ['Risk assessment', 'Work at height permit where required', 'Inspection records', 'Rescue plan'],
    emergencyResponse: 'Activate the rescue plan promptly and arrange medical evaluation after a fall.',
    siteExample: 'Use an inspected MEWP with trained operator for elevated maintenance.',
    imagePath: 'assets/images/industrial/work_at_height.png',
  ),

  IndustrialTopic(
    title: 'Scaffolding & Temporary Access',
    purpose: 'Provide safe temporary access and working platforms.',
    hazards: ['Scaffold collapse', 'Falls', 'Falling objects', 'Unauthorized alteration'],
    controls: ['Competent erection', 'Inspection and tagging', 'Safe access', 'Guardrails', 'Load limits'],
    documents: ['Scaffold inspection register', 'Handover certificate', 'Permit where required'],
    emergencyResponse: 'Restrict access to unsafe scaffold and arrange competent inspection and correction.',
    siteExample: 'Do not use a scaffold with missing guardrails or an invalid inspection status.',
    imagePath: 'assets/images/industrial/scaffolding.png',
  ),

  IndustrialTopic(
    title: 'Shutdown & Turnaround Safety',
    purpose: 'Coordinate high-risk maintenance activities during planned plant shutdowns.',
    hazards: ['Simultaneous operations', 'Energy release', 'Congestion', 'Fatigue'],
    controls: ['Shutdown HSE plan', 'SIMOPS coordination', 'Isolation register', 'Daily briefings', 'Workforce welfare'],
    documents: ['Shutdown plan', 'SIMOPS matrix', 'Permit register', 'Emergency arrangements'],
    emergencyResponse: 'Use the shutdown command structure and site emergency response plan.',
    siteExample: 'Coordinate simultaneous vessel entry and adjacent hot work through SIMOPS review.',
    imagePath: 'assets/images/industrial/shutdown_turnaround.png',
  ),

  IndustrialTopic(
    title: 'Equipment Dismantling & Reassembly',
    purpose: 'Control mechanical, electrical and structural risks during equipment removal and rebuilding.',
    hazards: ['Unexpected movement', 'Falling components', 'Stored pressure', 'Incorrect reassembly'],
    controls: ['Approved method statement', 'Isolation', 'Component support', 'Lifting plan', 'Verification before restart'],
    documents: ['Method statement', 'LOTO record', 'Lifting plan', 'Recommissioning checklist'],
    emergencyResponse: 'Stop work, secure unstable components and activate emergency arrangements if a release or injury occurs.',
    siteExample: 'Support a motor assembly before removing its final fixing bolts.',
    imagePath: 'assets/images/industrial/equipment_dismantling.png',
  ),

  IndustrialTopic(
    title: 'Industrial Cleaning & Tank Cleaning',
    purpose: 'Safely remove deposits, residues and contaminants from industrial equipment.',
    hazards: ['Chemical exposure', 'Confined atmosphere', 'Pressure release', 'Slips'],
    controls: ['Approved cleaning method', 'Isolation', 'Chemical compatibility', 'Ventilation', 'Atmospheric testing where required'],
    documents: ['Cleaning procedure', 'SDS', 'Permit', 'Waste disposal records'],
    emergencyResponse: 'Stop cleaning, isolate chemical sources and follow exposure or confined-space rescue arrangements.',
    siteExample: 'Confirm tank isolation and atmosphere safety before internal cleaning.',
    imagePath: 'assets/images/industrial/tank_cleaning.png',
  ),

  IndustrialTopic(
    title: 'NDT & Industrial Radiography Safety',
    purpose: 'Control radiation and other hazards during non-destructive testing.',
    hazards: ['Ionizing radiation', 'Uncontrolled access', 'Electrical hazards', 'Chemical exposure'],
    controls: ['Authorized radiation personnel', 'Radiation barriers', 'Controlled area', 'Survey meters', 'Dosimetry', 'Emergency procedure'],
    documents: ['Radiography permit', 'Radiation protection plan', 'Dosimeter records', 'Equipment certificates'],
    emergencyResponse: 'Stop exposure, secure the area, prevent entry and contact the Radiation Protection Officer and emergency team.',
    siteExample: 'Establish and monitor the exclusion zone before industrial radiography.',
    imagePath: 'assets/images/industrial/ndt_radiography.png',
  ),

  IndustrialTopic(
    title: 'Pressure Testing, Hydrotesting & Pneumatic Testing',
    purpose: 'Prevent failure and injury during pressure testing of systems and components.',
    hazards: ['Stored energy', 'Bursting', 'Flying components', 'Hose failure'],
    controls: ['Approved test pack', 'Defined test pressure', 'Exclusion zone', 'Calibrated gauges', 'Controlled pressurization'],
    documents: ['Pressure test procedure', 'Test pack', 'Calibration certificates', 'Inspection records'],
    emergencyResponse: 'Stop pressurization, isolate the test area and depressurize only through the approved safe method.',
    siteExample: 'Keep personnel outside the exclusion zone during pneumatic testing.',
    imagePath: 'assets/images/industrial/pressure_testing.png',
  ),

  // 81–90: Occupational Health & Industrial Hygiene

  IndustrialTopic(
    title: 'Industrial Occupational Hygiene',
    purpose: 'Identify, assess and control workplace health exposures.',
    hazards: ['Chemical exposure', 'Noise', 'Dust', 'Heat', 'Biological agents'],
    controls: ['Exposure assessment', 'Engineering controls', 'Monitoring', 'Health surveillance', 'PPE as required'],
    documents: ['Hygiene survey', 'Exposure monitoring reports', 'Control plan', 'Training records'],
    emergencyResponse: 'Remove affected persons from exposure and arrange medical assessment when indicated.',
    siteExample: 'Conduct exposure monitoring in a process area with chemical vapours.',
    imagePath: 'assets/images/industrial/occupational_hygiene.png',
  ),

  IndustrialTopic(
    title: 'Noise Exposure & Hearing Conservation',
    purpose: 'Prevent occupational hearing loss from industrial noise.',
    hazards: ['Excessive noise', 'Hearing damage', 'Communication failure'],
    controls: ['Noise assessment', 'Engineering noise reduction', 'Hearing protection', 'Audiometry where required'],
    documents: ['Noise survey', 'Hearing conservation plan', 'Training and health records'],
    emergencyResponse: 'Move workers away from hazardous noise and assess any acute acoustic injury.',
    siteExample: 'Mark high-noise zones and provide suitable hearing protection.',
    imagePath: 'assets/images/industrial/noise_hearing.png',
  ),

  IndustrialTopic(
    title: 'Hand-Arm & Whole-Body Vibration',
    purpose: 'Reduce health risks from vibrating tools, vehicles and machinery.',
    hazards: ['Hand-arm vibration syndrome', 'Back discomfort', 'Nerve and circulation effects'],
    controls: ['Low-vibration equipment', 'Maintenance', 'Exposure-time management', 'Work rotation', 'Health monitoring'],
    documents: ['Vibration assessment', 'Equipment records', 'Exposure monitoring', 'Training'],
    emergencyResponse: 'Stop exposure and refer workers with concerning symptoms for occupational health assessment.',
    siteExample: 'Select suitable low-vibration tools for repetitive grinding work.',
    imagePath: 'assets/images/industrial/vibration_safety.png',
  ),

  IndustrialTopic(
    title: 'Dust, Fumes & Airborne Contaminants',
    purpose: 'Control inhalation exposure to dust, fumes and airborne hazardous substances.',
    hazards: ['Respiratory irritation', 'Occupational lung disease', 'Toxic exposure'],
    controls: ['Substitution', 'Local exhaust ventilation', 'Enclosure', 'Air monitoring', 'Suitable respiratory protection'],
    documents: ['Exposure assessment', 'LEV inspection', 'Monitoring results', 'SDS'],
    emergencyResponse: 'Move affected workers to fresh air without exposing rescuers and obtain medical assistance.',
    siteExample: 'Use local exhaust ventilation at a dusty material transfer point.',
    imagePath: 'assets/images/industrial/dust_fumes.png',
  ),

  IndustrialTopic(
    title: 'Welding Fume & Respiratory Protection',
    purpose: 'Prevent respiratory harm from welding fumes and ensure correct respirator use.',
    hazards: ['Metal fume exposure', 'Ozone', 'Nitrogen oxides', 'Oxygen displacement'],
    controls: ['Fume extraction', 'Suitable process selection', 'Respirator assessment and fit testing where applicable', 'Training'],
    documents: ['Welding risk assessment', 'LEV inspection', 'Respirator records', 'SDS'],
    emergencyResponse: 'Stop exposure, move to fresh air and seek medical assistance for breathing difficulty.',
    siteExample: 'Use source extraction when welding stainless steel in a workshop.',
    imagePath: 'assets/images/industrial/welding_fume.png',
  ),

  IndustrialTopic(
    title: 'Heat Stress & Thermal Environment',
    purpose: 'Prevent heat-related illness during hot industrial work.',
    hazards: ['Heat exhaustion', 'Heat stroke', 'Dehydration', 'Reduced concentration'],
    controls: ['Heat risk assessment', 'Water and rest', 'Shade or cooling', 'Acclimatization', 'Work-rest arrangements'],
    documents: ['Heat stress plan', 'Training records', 'Monitoring records', 'Emergency response procedure'],
    emergencyResponse: 'For suspected heat stroke, activate emergency medical response, begin safe cooling and do not delay medical care.',
    siteExample: 'Apply the relevant UAE summer midday work restrictions and site heat-stress controls.',
    imagePath: 'assets/images/industrial/heat_stress.png',
  ),

  IndustrialTopic(
    title: 'Occupational Health Surveillance & Fitness',
    purpose: 'Monitor work-related health risks and role-specific fitness requirements.',
    hazards: ['Undetected occupational illness', 'Exposure-related disease', 'Inadequate fitness for safety-critical tasks'],
    controls: ['Risk-based health surveillance', 'Confidential medical handling', 'Referral process', 'Fitness review'],
    documents: ['Health surveillance schedule', 'Fitness records', 'Referral records', 'Exposure history'],
    emergencyResponse: 'Arrange urgent medical assessment for acute symptoms and follow confidentiality requirements.',
    siteExample: 'Arrange appropriate health surveillance for workers exposed to occupational noise.',
    imagePath: 'assets/images/industrial/health_surveillance.png',
  ),

  IndustrialTopic(
    title: 'Industrial Ergonomics & Musculoskeletal Risk',
    purpose: 'Design tasks and workstations to reduce physical strain and injury.',
    hazards: ['Awkward posture', 'Repetitive movement', 'Forceful exertion', 'Prolonged standing'],
    controls: ['Ergonomic assessment', 'Workstation adjustment', 'Mechanical aids', 'Task variation', 'Worker consultation'],
    documents: ['Ergonomic assessment', 'Corrective action log', 'Training records'],
    emergencyResponse: 'Stop aggravating work and arrange appropriate first aid or occupational health review.',
    siteExample: 'Adjust a packing station to reduce repeated bending and twisting.',
    imagePath: 'assets/images/industrial/ergonomics.png',
  ),

  IndustrialTopic(
    title: 'Biological Hazards & Workplace Hygiene',
    purpose: 'Reduce exposure to biological agents and maintain hygienic industrial workplaces.',
    hazards: ['Contaminated water', 'Mould', 'Pathogens', 'Poor sanitation'],
    controls: ['Hygiene procedures', 'Safe water', 'Cleaning schedules', 'Pest control', 'Suitable PPE'],
    documents: ['Hygiene inspection', 'Cleaning records', 'Water quality records where applicable'],
    emergencyResponse: 'Isolate the suspected contamination and seek medical or specialist advice as appropriate.',
    siteExample: 'Investigate stagnant water and maintain hygienic welfare facilities.',
    imagePath: 'assets/images/industrial/biological_hygiene.png',
  ),

  IndustrialTopic(
    title: 'Fatigue, Shift Work & Worker Welfare',
    purpose: 'Manage fatigue and protect worker wellbeing in shift-based industrial operations.',
    hazards: ['Reduced alertness', 'Human error', 'Sleep disruption', 'Heat-related fatigue'],
    controls: ['Fatigue risk assessment', 'Suitable shift design', 'Rest breaks', 'Welfare facilities', 'Worker reporting'],
    documents: ['Fatigue management plan', 'Shift roster', 'Welfare inspection', 'Training records'],
    emergencyResponse: 'Remove an unfit worker from safety-critical duties and arrange support or medical assessment when needed.',
    siteExample: 'Review extended shifts before assigning workers to safety-critical maintenance.',
    imagePath: 'assets/images/industrial/fatigue_welfare.png',
  ),
];
