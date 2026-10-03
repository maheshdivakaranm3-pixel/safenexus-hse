import 'industrial_part1.dart';

const String _base = 'assets/images/industrial';

const List<IndustrialTopic> industrialPart4 = [
  // 91
  IndustrialTopic(
    id: 91,
    title: 'Metal Fabrication & Foundry Safety',
    image: '$_base/manufacturing/metal_fabrication.png',
    purpose: 'Prevent injuries during cutting, welding, machining, fabrication and foundry operations.',
    hazards: ['Sharp edges', 'Flying particles', 'Hot surfaces', 'Fumes', 'Moving machinery'],
    controls: ['Machine guarding', 'Hot-work controls', 'Local exhaust ventilation', 'Safe material handling', 'Suitable PPE'],
    documents: ['Risk Assessment', 'JSA', 'Hot Work Permit', 'Equipment Inspection Checklist', 'Training Records'],
    emergency: 'Stop work, isolate machinery, raise alarm, provide first aid for cuts or burns and activate site emergency response.',
    siteExample: 'Fabrication workers use guarded cutting machines, welding screens and fume extraction before production starts.',
  ),

  // 92
  IndustrialTopic(
    id: 92,
    title: 'Casting, Furnace & Molten Metal Safety',
    image: '$_base/manufacturing/molten_metal.png',
    purpose: 'Control risks from molten metal handling, casting, furnaces and high-temperature operations.',
    hazards: ['Molten metal splash', 'Severe burns', 'Furnace failure', 'Moisture explosions', 'Heat stress'],
    controls: ['Dry moulds and tools', 'Restricted exclusion zones', 'Furnace inspections', 'Suitable heat-resistant PPE', 'Safe pouring procedures'],
    documents: ['Furnace Inspection Record', 'Risk Assessment', 'SOP', 'PPE Inspection', 'Emergency Plan'],
    emergency: 'Raise alarm, isolate the furnace where safe, keep personnel clear of molten metal and arrange burn or heat emergency response.',
    siteExample: 'Before pouring, the foundry supervisor confirms moulds and ladles are dry and the exclusion zone is clear.',
  ),

  // 93
  IndustrialTopic(
    id: 93,
    title: 'Heat Treatment & Industrial Furnace Safety',
    image: '$_base/manufacturing/heat_treatment.png',
    purpose: 'Prevent burns, fire and equipment incidents during industrial heating and heat-treatment cycles.',
    hazards: ['High temperature', 'Hot workpieces', 'Gas leakage', 'Electrical faults', 'Unexpected furnace start'],
    controls: ['Interlocked guards', 'Temperature controls', 'Gas leak checks', 'Isolation before maintenance', 'Cooling and handling procedures'],
    documents: ['Operating Procedure', 'Maintenance Log', 'LOTO Record', 'Inspection Checklist', 'Training Record'],
    emergency: 'Stop the process, isolate energy if safe, evacuate from gas or fire hazards and contact the emergency team.',
    siteExample: 'Operators use designated tongs and marked cooling areas when removing heat-treated components.',
  ),

  // 94
  IndustrialTopic(
    id: 94,
    title: 'Plastic, Polymer & Injection Moulding Safety',
    image: '$_base/manufacturing/plastic_moulding.png',
    purpose: 'Control machinery, heat, chemical and ergonomic risks in plastic and polymer production.',
    hazards: ['Hot moulds', 'Crushing points', 'Polymer fumes', 'Hydraulic pressure', 'Manual handling'],
    controls: ['Interlocked machine guards', 'Fume extraction', 'Pressure isolation', 'Safe mould-change procedure', 'Ergonomic workstations'],
    documents: ['Machine Risk Assessment', 'SOP', 'LOTO Record', 'Ventilation Inspection', 'Operator Training'],
    emergency: 'Activate emergency stop, isolate energy, keep clear of press mechanisms and arrange first aid for burns or crush injuries.',
    siteExample: 'A technician isolates electrical and hydraulic energy before opening an injection moulding machine for maintenance.',
  ),

  // 95
  IndustrialTopic(
    id: 95,
    title: 'Rubber & Tyre Manufacturing Safety',
    image: '$_base/manufacturing/rubber_tyre.png',
    purpose: 'Prevent machinery, chemical, heat and fire incidents in rubber and tyre production.',
    hazards: ['Rotating rollers', 'Chemical exposure', 'Hot presses', 'Combustible materials', 'Noise'],
    controls: ['Roller nip-point guards', 'Chemical handling controls', 'Fire prevention', 'Noise control', 'Safe press isolation'],
    documents: ['Chemical Register', 'SDS', 'Machine Inspection', 'Risk Assessment', 'Emergency Plan'],
    emergency: 'Stop machinery, isolate the affected process, raise alarm for fire or chemical release and follow site response procedures.',
    siteExample: 'Workers keep hands outside roller danger zones and use approved tools to feed rubber sheets.',
  ),

  // 96
  IndustrialTopic(
    id: 96,
    title: 'Food & Beverage Manufacturing Safety',
    image: '$_base/manufacturing/food_beverage.png',
    purpose: 'Protect workers during food processing, packaging, cleaning and production operations.',
    hazards: ['Slippery floors', 'Conveyors', 'Hot liquids', 'Cleaning chemicals', 'Cold-room exposure'],
    controls: ['Slip-resistant flooring', 'Machine guarding', 'Chemical dilution procedures', 'Cold-room alarms', 'Hygiene and PPE controls'],
    documents: ['Risk Assessment', 'Cleaning SOP', 'Chemical SDS', 'Equipment Inspection', 'Training Records'],
    emergency: 'Stop equipment, isolate chemical or thermal hazards, assist affected personnel and activate medical response when needed.',
    siteExample: 'A production team uses lockout before cleaning a conveyor and places warning signs around wet floors.',
  ),

  // 97
  IndustrialTopic(
    id: 97,
    title: 'Pharmaceutical & Cleanroom Safety',
    image: '$_base/manufacturing/pharmaceutical_cleanroom.png',
    purpose: 'Control occupational exposure, contamination and process hazards in pharmaceutical and cleanroom operations.',
    hazards: ['Potent substances', 'Cleaning agents', 'Biological exposure', 'Pressure differentials', 'Ergonomic strain'],
    controls: ['Containment systems', 'Access control', 'Validated cleaning procedures', 'Suitable PPE', 'Exposure monitoring'],
    documents: ['SOP', 'SDS', 'Risk Assessment', 'Exposure Monitoring Record', 'Training and Competency Record'],
    emergency: 'Restrict access, follow contamination-control procedures, use trained responders and arrange medical evaluation for exposure.',
    siteExample: 'Operators follow gowning and controlled transfer procedures before entering a classified production area.',
  ),

  // 98
  IndustrialTopic(
    id: 98,
    title: 'Paint, Coating & Surface Treatment Safety',
    image: '$_base/manufacturing/paint_coating.png',
    purpose: 'Prevent fire, explosion, chemical exposure and injury during coating and surface-treatment work.',
    hazards: ['Flammable vapours', 'Solvent exposure', 'Spray pressure', 'Abrasive blasting', 'Static electricity'],
    controls: ['Ventilation', 'Ignition-source control', 'Bonding and grounding', 'Respiratory protection', 'Blasting enclosure and inspection'],
    documents: ['SDS', 'Risk Assessment', 'Hot Work Permit where applicable', 'Ventilation Inspection', 'PPE Records'],
    emergency: 'Stop spraying, eliminate ignition sources only where safe, evacuate affected area and use spill or fire response procedures.',
    siteExample: 'A coating team checks ventilation and grounding before spraying solvent-based paint in a designated booth.',
  ),

  // 99
  IndustrialTopic(
    id: 99,
    title: 'Cement, Concrete & Building Material Manufacturing',
    image: '$_base/manufacturing/cement_concrete.png',
    purpose: 'Manage dust, machinery, vehicle and chemical risks in cement and building-material production.',
    hazards: ['Silica-containing dust', 'Conveyors', 'Heavy vehicles', 'Cement burns', 'Noise'],
    controls: ['Dust suppression', 'Enclosed transfer points', 'Traffic segregation', 'Suitable respiratory protection', 'Skin protection and washing facilities'],
    documents: ['Dust Monitoring Record', 'Risk Assessment', 'Vehicle Inspection', 'SDS', 'Health Surveillance Record'],
    emergency: 'Move exposed workers to a safe area, flush chemical contact as directed by SDS and seek medical assessment for exposure.',
    siteExample: 'A batching plant uses enclosed cement transfer and dust extraction to reduce airborne dust.',
  ),

  // 100
  IndustrialTopic(
    id: 100,
    title: 'Textile, Paper & Packaging Manufacturing Safety',
    image: '$_base/manufacturing/textile_paper_packaging.png',
    purpose: 'Prevent entanglement, fire, noise and ergonomic injuries in continuous manufacturing lines.',
    hazards: ['Rotating rollers', 'Entanglement', 'Paper dust', 'Fire load', 'Repetitive handling'],
    controls: ['Fixed guards', 'Emergency stops', 'Dust housekeeping', 'Fire protection', 'Ergonomic lifting methods'],
    documents: ['Machine Inspection', 'Fire Risk Assessment', 'Housekeeping Checklist', 'SOP', 'Training Record'],
    emergency: 'Use emergency stop, isolate machinery and raise alarm for fire, entanglement or serious injury.',
    siteExample: 'Operators never clear a jammed packaging roller until the equipment is stopped and isolated.',
  ),

  // 101
  IndustrialTopic(
    id: 101,
    title: 'Industrial Environmental Management',
    image: '$_base/environmental/environmental_management.png',
    purpose: 'Establish controls to prevent environmental harm from industrial activities.',
    hazards: ['Pollution releases', 'Non-compliant waste', 'Resource overuse', 'Environmental incidents', 'Permit breaches'],
    controls: ['Environmental aspects register', 'Operational controls', 'Monitoring', 'Legal compliance review', 'Corrective actions'],
    documents: ['Environmental Management Plan', 'Aspect and Impact Register', 'Legal Register', 'Inspection Reports', 'Monitoring Records'],
    emergency: 'Contain the release where safe, protect drains and receptors, notify responsible personnel and follow reporting requirements.',
    siteExample: 'The environmental officer reviews monthly monitoring results and tracks corrective actions to closure.',
  ),

  // 102
  IndustrialTopic(
    id: 102,
    title: 'Industrial Waste Segregation & Disposal',
    image: '$_base/environmental/waste_segregation.png',
    purpose: 'Ensure industrial waste is identified, segregated, stored and transferred through approved routes.',
    hazards: ['Incompatible waste mixing', 'Leaks', 'Sharp waste', 'Uncontrolled disposal', 'Fire'],
    controls: ['Labelled containers', 'Segregated storage', 'Covered waste areas', 'Approved waste contractors', 'Transfer documentation'],
    documents: ['Waste Register', 'Waste Transfer Note', 'Contractor Approval', 'Inspection Checklist', 'Disposal Records'],
    emergency: 'Isolate the affected area, prevent waste entering drains and arrange trained cleanup and approved disposal.',
    siteExample: 'The site team separates general, recyclable and hazardous waste in labelled designated containers.',
  ),

  // 103
  IndustrialTopic(
    id: 103,
    title: 'Hazardous Waste Management',
    image: '$_base/environmental/hazardous_waste.png',
    purpose: 'Control hazardous waste from generation through storage, transport and final disposal.',
    hazards: ['Toxic exposure', 'Chemical reaction', 'Fire', 'Container failure', 'Environmental contamination'],
    controls: ['Waste classification', 'Compatible containers', 'Secondary containment', 'Access control', 'Approved licensed handlers'],
    documents: ['Hazardous Waste Register', 'SDS', 'Waste Manifest', 'Storage Inspection', 'Contractor Documents'],
    emergency: 'Keep untrained personnel away, identify the material, prevent spread and use trained spill responders with suitable PPE.',
    siteExample: 'Used chemical containers are labelled, closed and stored in a bunded hazardous-waste area.',
  ),

  // 104
  IndustrialTopic(
    id: 104,
    title: 'Air Emissions & Pollution Control',
    image: '$_base/environmental/air_emissions.png',
    purpose: 'Monitor and control emissions from stacks, generators, boilers and industrial processes.',
    hazards: ['Particulate emissions', 'Combustion gases', 'Uncontrolled releases', 'Exposure', 'Permit non-compliance'],
    controls: ['Emission control equipment', 'Preventive maintenance', 'Stack monitoring', 'Operating limits', 'Corrective action tracking'],
    documents: ['Emission Monitoring Report', 'Equipment Maintenance Log', 'Permit', 'Calibration Records', 'Compliance Register'],
    emergency: 'Report abnormal emissions, stop or reduce the source where safe and follow the site environmental incident procedure.',
    siteExample: 'A facility reviews stack-monitoring results and maintains its dust collector to keep emissions within applicable limits.',
  ),

  // 105
  IndustrialTopic(
    id: 105,
    title: 'Wastewater & Effluent Management',
    image: '$_base/environmental/wastewater_effluent.png',
    purpose: 'Prevent uncontrolled discharge and protect drains, treatment systems and receiving environments.',
    hazards: ['Chemical effluent', 'Overflow', 'Confined-space exposure', 'Slips', 'Unapproved discharge'],
    controls: ['Effluent treatment', 'Sampling and testing', 'Drain protection', 'Tank level alarms', 'Authorized discharge controls'],
    documents: ['Effluent Monitoring Log', 'Discharge Approval', 'Treatment Plant Inspection', 'Sampling Reports', 'Maintenance Records'],
    emergency: 'Stop the discharge if safe, isolate the affected drain, contain the release and notify environmental management.',
    siteExample: 'The wastewater operator records pH and other required parameters before authorized discharge.',
  ),

  // 106
  IndustrialTopic(
    id: 106,
    title: 'Oil, Chemical & Fuel Spill Prevention',
    image: '$_base/environmental/spill_prevention.png',
    purpose: 'Prevent and control spills during storage, transfer, dispensing and maintenance.',
    hazards: ['Leaks', 'Fire', 'Slip hazards', 'Soil contamination', 'Drain pollution'],
    controls: ['Bunds and drip trays', 'Hose inspection', 'Overfill prevention', 'Spill kits', 'Drain covers and transfer supervision'],
    documents: ['Spill Prevention Plan', 'Tank Inspection', 'Transfer Checklist', 'Spill Kit Inspection', 'Incident Report'],
    emergency: 'Stop the source if safe, protect drains, establish an exclusion zone and deploy trained spill responders.',
    siteExample: 'A fuel transfer operator checks hose condition and places spill protection near vulnerable drains.',
  ),

  // 107
  IndustrialTopic(
    id: 107,
    title: 'Noise Pollution & Boundary Monitoring',
    image: '$_base/environmental/noise_monitoring.png',
    purpose: 'Manage industrial noise impacts on workers and surrounding receptors.',
    hazards: ['Excessive noise', 'Hearing damage', 'Community disturbance', 'Equipment vibration', 'Communication failure'],
    controls: ['Acoustic enclosures', 'Equipment maintenance', 'Noise surveys', 'Work scheduling', 'Hearing protection where required'],
    documents: ['Noise Monitoring Report', 'Noise Map', 'Equipment Maintenance Log', 'Complaints Register', 'Corrective Action Record'],
    emergency: 'Investigate abnormal noise or vibration, isolate unsafe equipment and address any immediate exposure or community concern.',
    siteExample: 'Boundary noise readings are reviewed after installation of a new generator or production machine.',
  ),

  // 108
  IndustrialTopic(
    id: 108,
    title: 'Resource, Energy & Water Conservation',
    image: '$_base/environmental/resource_conservation.png',
    purpose: 'Improve responsible use of energy, water and materials while reducing environmental impacts.',
    hazards: ['Resource wastage', 'Leaks', 'Inefficient equipment', 'Excess consumption', 'Uncontrolled discharge'],
    controls: ['Metering', 'Leak inspections', 'Efficiency maintenance', 'Consumption targets', 'Awareness and improvement plans'],
    documents: ['Utility Consumption Register', 'Energy Review', 'Water Inspection', 'Improvement Plan', 'Management Review'],
    emergency: 'Isolate major leaks or unsafe utility equipment where safe and notify facilities or emergency personnel.',
    siteExample: 'Monthly electricity and water consumption is compared with production data to identify abnormal usage.',
  ),

  // 109
  IndustrialTopic(
    id: 109,
    title: 'Industrial Site Housekeeping & 5S',
    image: '$_base/management/industrial_5s.png',
    purpose: 'Maintain orderly workplaces that reduce slips, trips, fire load and operational inefficiency.',
    hazards: ['Blocked access', 'Slips and trips', 'Poor storage', 'Combustible accumulation', 'Obstructed emergency equipment'],
    controls: ['Sort and organize', 'Clear walkways', 'Defined storage locations', 'Routine inspections', 'Prompt waste removal'],
    documents: ['5S Audit Checklist', 'Housekeeping Inspection', 'Action Tracker', 'Waste Register', 'Shift Handover Record'],
    emergency: 'Keep escape routes clear, remove immediate hazards where safe and report blocked exits or emergency equipment.',
    siteExample: 'At shift end, the supervisor checks walkways, fire points, tool storage and waste bins.',
  ),

  // 110
  IndustrialTopic(
    id: 110,
    title: 'Environmental Emergency & Regulatory Reporting',
    image: '$_base/environmental/environmental_emergency.png',
    purpose: 'Ensure environmental incidents are contained, escalated, investigated and reported as required.',
    hazards: ['Major spill', 'Uncontrolled emission', 'Effluent release', 'Firewater runoff', 'Delayed notification'],
    controls: ['Emergency response plan', 'Defined notification roles', 'Spill equipment', 'Incident classification', 'Regulatory reporting procedure'],
    documents: ['Environmental Emergency Plan', 'Incident Notification', 'Incident Investigation', 'Corrective Action Register', 'Regulatory Correspondence'],
    emergency: 'Protect people first, contain the release if safe, notify site management and make required external notifications through authorized personnel.',
    siteExample: 'A chemical release is logged, contained, investigated and reported through the company’s applicable notification process.',
  ),

  // 111
  IndustrialTopic(
    id: 111,
    title: 'Industrial Construction',
    image: '$_base/construction/industrial_construction.png',
    purpose: 'Control construction and installation hazards within operating industrial facilities.',
    hazards: ['SIMOPS', 'Lifting operations', 'Work at height', 'Excavation', 'Live plant interfaces'],
    controls: ['Construction HSE Plan', 'Permit to Work', 'SIMOPS coordination', 'Competent supervision', 'Daily coordination and inspections'],
    documents: ['Construction HSE Plan', 'Risk Assessment', 'Method Statement', 'PTW', 'Inspection Records'],
    emergency: 'Stop work, raise alarm, isolate affected work area and coordinate with the operating facility emergency team.',
    siteExample: 'Before equipment installation, construction and operations teams coordinate lifting, access and nearby live-process activities.',
  ),

  // 112
  IndustrialTopic(
    id: 112,
    title: 'Temporary Works & Structural Stability',
    image: '$_base/construction/temporary_works.png',
    purpose: 'Ensure temporary structures and supports remain stable throughout installation, use and removal.',
    hazards: ['Structural collapse', 'Overloading', 'Unapproved modification', 'Poor foundations', 'Weather effects'],
    controls: ['Design review', 'Competent inspection', 'Load limits', 'Permit or authorization controls', 'Controlled dismantling sequence'],
    documents: ['Temporary Works Design', 'Inspection Certificate', 'Load Register', 'Method Statement', 'Handover Record'],
    emergency: 'Evacuate the affected zone, prevent access, notify the responsible engineer and do not alter unstable structures until assessed.',
    siteExample: 'Temporary access platforms are inspected and formally handed over before workers use them.',
  ),

  // 113
  IndustrialTopic(
    id: 113,
    title: 'Industrial Demolition & Decommissioning',
    image: '$_base/construction/industrial_demolition.png',
    purpose: 'Manage hazards during dismantling, demolition, plant shutdown and decommissioning.',
    hazards: ['Unidentified services', 'Structural collapse', 'Residual chemicals', 'Asbestos or hazardous materials', 'Falling objects'],
    controls: ['Engineering survey', 'Isolation and LOTO', 'Decontamination', 'Sequenced demolition plan', 'Exclusion zones'],
    documents: ['Demolition Plan', 'Survey Report', 'Isolation Certificate', 'Waste Management Plan', 'Permit and Risk Assessment'],
    emergency: 'Stop demolition, evacuate the exclusion zone, isolate hazards where safe and activate rescue or emergency services.',
    siteExample: 'A decommissioning team verifies process lines are drained, purged and isolated before cutting begins.',
  ),

  // 114
  IndustrialTopic(
    id: 114,
    title: 'Industrial Refrigeration & Ammonia Safety',
    image: '$_base/process_safety/industrial_ammonia.png',
    purpose: 'Prevent toxic releases and mechanical or pressure incidents in industrial refrigeration systems.',
    hazards: ['Ammonia leak', 'Toxic inhalation', 'Pressure release', 'Cold burns', 'Confined machinery spaces'],
    controls: ['Gas detection', 'Ventilation', 'Leak testing', 'Emergency shutdown', 'Trained responders and access control'],
    documents: ['Refrigeration P&ID', 'Ammonia SDS', 'Inspection and Maintenance Log', 'Emergency Plan', 'Competency Records'],
    emergency: 'Raise alarm, evacuate upwind or crosswind as directed by the site plan, prevent entry and allow only trained responders with suitable protection.',
    siteExample: 'An ammonia detector alarm triggers evacuation and isolation actions under the facility emergency procedure.',
  ),

  // 115
  IndustrialTopic(
    id: 115,
    title: 'Battery Charging & Industrial Battery Safety',
    image: '$_base/electrical/battery_charging.png',
    purpose: 'Control electrical, chemical, fire and manual-handling risks during industrial battery use and charging.',
    hazards: ['Hydrogen gas', 'Acid electrolyte', 'Short circuit', 'Electric shock', 'Battery lifting'],
    controls: ['Designated ventilated charging area', 'Correct chargers', 'No ignition sources', 'Insulated tools', 'Eyewash and spill provisions'],
    documents: ['Battery Inspection', 'Charging Log', 'SDS', 'Maintenance Record', 'Emergency Procedure'],
    emergency: 'Isolate charging power if safe, keep ignition sources away, evacuate for gas or fire risk and use trained responders for electrolyte spills.',
    siteExample: 'Forklift batteries are charged in a ventilated zone with inspected cables and emergency eyewash access.',
  ),

  // 116
  IndustrialTopic(
    id: 116,
    title: 'Lithium-Ion Battery & Energy Storage Fire Safety',
    image: '$_base/electrical/lithium_energy_storage.png',
    purpose: 'Manage thermal runaway, electrical and fire risks in lithium-ion batteries and energy storage systems.',
    hazards: ['Thermal runaway', 'Fire and re-ignition', 'Toxic gases', 'Electrical energy', 'Damaged cells'],
    controls: ['Approved installation', 'Battery Management System', 'Temperature monitoring', 'Separation and ventilation', 'Emergency response coordination'],
    documents: ['Battery Safety Data', 'System Inspection', 'Emergency Response Plan', 'Maintenance Records', 'Incident Report'],
    emergency: 'Raise alarm, evacuate and isolate the area; do not handle damaged or heating batteries; responders must follow the system-specific emergency plan.',
    siteExample: 'A facility isolates a battery storage area after abnormal temperature alarms and follows its engineered response procedure.',
  ),

  // 117
  IndustrialTopic(
    id: 117,
    title: 'Solar PV & Industrial Renewable Energy Safety',
    image: '$_base/electrical/solar_pv_safety.png',
    purpose: 'Control electrical, fall, fire and maintenance risks in industrial renewable energy systems.',
    hazards: ['DC electric shock', 'Arc flash', 'Falls from height', 'Hot surfaces', 'Unexpected backfeed'],
    controls: ['Competent electrical work', 'Isolation and verification', 'Fall protection', 'Safe access', 'Manufacturer-approved maintenance'],
    documents: ['Electrical Risk Assessment', 'Isolation Record', 'Inspection Report', 'Work at Height Permit', 'Maintenance Log'],
    emergency: 'Keep clear of energized equipment, raise alarm and use authorized isolation and rescue procedures.',
    siteExample: 'Technicians verify isolation and follow approved access controls before rooftop PV maintenance.',
  ),

  // 118
  IndustrialTopic(
    id: 118,
    title: 'Industrial Cyber-Physical Safety & Control System Risks',
    image: '$_base/process_safety/control_system_safety.png',
    purpose: 'Protect industrial operations from control-system failures and unsafe changes affecting physical processes.',
    hazards: ['Control system malfunction', 'Unauthorized changes', 'Alarm failure', 'Loss of monitoring', 'Unsafe remote access'],
    controls: ['Change management', 'Access control', 'Backup and recovery', 'Alarm management', 'Cybersecurity coordination with process safety'],
    documents: ['Management of Change', 'Access Register', 'Backup Record', 'Alarm Review', 'Incident and Recovery Plan'],
    emergency: 'Follow approved manual or shutdown procedures, notify control-room and technical teams and avoid unauthorized system changes.',
    siteExample: 'A control-system configuration change is reviewed and tested before deployment to a live production unit.',
  ),

  // 119
  IndustrialTopic(
    id: 119,
    title: 'Industrial HSE Documentation, Records & Compliance',
    image: '$_base/management/hse_document_control.png',
    purpose: 'Maintain controlled HSE documents and evidence of compliance, inspection and corrective action.',
    hazards: ['Expired procedures', 'Missing permits', 'Unverified training', 'Poor record traceability', 'Unclosed actions'],
    controls: ['Document control', 'Revision approval', 'Defined retention', 'Periodic compliance audits', 'Action ownership and closure verification'],
    documents: ['Document Register', 'Legal Register', 'Permit Register', 'Training Matrix', 'Audit and Action Tracker'],
    emergency: 'Use current approved emergency documents, report missing critical information and ensure controlled copies are available to responders.',
    siteExample: 'The HSE team checks revision status and closure evidence before an internal compliance audit.',
  ),

  // 120
  IndustrialTopic(
    id: 120,
    title: 'Industrial HSE Leadership, Training & Competency',
    image: '$_base/management/hse_leadership_competency.png',
    purpose: 'Build effective HSE leadership, worker participation and verified competency for industrial work.',
    hazards: ['Inadequate supervision', 'Untrained workers', 'Poor safety communication', 'Unsafe behaviors', 'Competency gaps'],
    controls: ['Role-based training', 'Competency assessment', 'Toolbox talks', 'Leadership site tours', 'Worker consultation and refresher training'],
    documents: ['Training Matrix', 'Competency Assessment', 'Induction Record', 'Toolbox Talk Register', 'Leadership Inspection Record'],
    emergency: 'Ensure trained personnel lead the response, account for workers and communicate through the established emergency command structure.',
    siteExample: 'A supervisor verifies operator competency and conducts a pre-task briefing before assigning high-risk work.',
  ),
];
