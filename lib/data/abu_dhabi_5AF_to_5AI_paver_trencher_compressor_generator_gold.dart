// SafeNexus HSE — Abu Dhabi HSE Reference
// BOOK-LEVEL GOLD STANDARD — Plant & Equipment
// Consolidated minimum-file architecture.
//
// This file is designed as a field handbook data source, not a shallow topic
// registry. Regulatory statements and numeric requirements must be checked
// against the current official ADPHC/ADOSH-SF source, manufacturer manual,
// approved RAMS/JSA, project requirements and competent-person assessment.
//
// Current regulatory baseline used for architecture:
// ADPHC CoP 36.0 — Plant and Equipment — Version 4.1, February 2026.
// Other cross-referenced CoPs are identified inside each applicable topic.

class PlantBookPoint {
  final String title;
  final String detail;
  const PlantBookPoint(this.title, this.detail);
}

class PlantBookSection {
  final String title;
  final List<PlantBookPoint> points;
  const PlantBookSection(this.title, this.points);
}

class PlantBookTopic {
  final String code;
  final String title;
  final String regulatoryBasis;
  final String fieldPurpose;
  final List<PlantBookSection> sections;

  const PlantBookTopic({
    required this.code,
    required this.title,
    required this.regulatoryBasis,
    required this.fieldPurpose,
    required this.sections,
  });
}

final List<PlantBookTopic> abuDhabi5AFTo5AITopics = [
PlantBookTopic(
    code: '5AF',
    title: 'Road / Asphalt Paver',
    regulatoryBasis: 'ADPHC CoP 36.0 Plant & Equipment V4.1; CoP 33.0 Working On or Adjacent to a Road; CoP 44.0 Traffic Management and Logistics; applicable heat/noise controls.',
    fieldPurpose: 'Field reference for asphalt paving, hot material, screed/auger hazards, truck interface and live-road controls.',
    sections: [
      PlantBookSection('01 — What / Purpose / Scope', [
  PlantBookPoint('Definition', 'Road / Asphalt Paver is mobile/portable plant used for site operations. The exact machine configuration, capacity, attachment and manufacturer limitations determine its safe operating envelope.'),
  PlantBookPoint('Purpose', 'Use Road / Asphalt Paver only for tasks for which the machine and attachment are designed, rated and authorised.'),
  PlantBookPoint('Scope', 'Covers planning, selection, mobilisation, inspection, operation, maintenance, traffic interaction, emergency response and field verification.'),
  PlantBookPoint('People at risk', 'Operators, banksmen, ground workers, mechanics, supervisors, visitors, drivers and members of the public where site boundaries interface with public areas.'),
  PlantBookPoint('Golden rule', 'Suitable equipment + competent operator + inspected machine + controlled work area + approved method + continuous monitoring.')
]),
      PlantBookSection('02 — Types / Configurations', [
  PlantBookPoint('Machine variants', 'Identify the exact model, operating mass, power source, attachment and configuration before applying any operating information.'),
  PlantBookPoint('Attachments', 'Attachment changes can change stability, capacity, visibility, hydraulic demand and hazard profile.'),
  PlantBookPoint('Manufacturer data', 'Use the machine identification plate, operator manual, load chart and attachment documentation for the exact configuration.'),
  PlantBookPoint('Site configuration', 'Record any approved project-specific modification or accessory; unauthorised modifications are not acceptable.'),
  PlantBookPoint('Selection', 'Select the smallest suitable machine that can safely perform the task without creating additional hazards.')
]),
      PlantBookSection('03 — Main Components', [
  PlantBookPoint('Structure', 'Inspect chassis/frame, guards, access systems, operator protection and structural connections.'),
  PlantBookPoint('Power system', 'Check engine/electric/hydraulic/pneumatic systems appropriate to the equipment.'),
  PlantBookPoint('Controls', 'Controls, indicators, alarms, emergency functions and safety interlocks must be understood and functional.'),
  PlantBookPoint('Working equipment', "Inspect the machine's working attachment, linkage, cutting/compacting/hauling components and securing systems."),
  PlantBookPoint('Safety systems', 'Seat restraint, ROPS/FOPS where fitted, cameras, alarms, lights, mirrors, interlocks and emergency devices must not be bypassed.')
]),
      PlantBookSection('04 — Applications / When Used', [
  PlantBookPoint('Approved use', "Use only within the machine's intended application and rated operating envelope."),
  PlantBookPoint('Task matching', 'Confirm material type, load, distance, terrain, gradient, clearance, cycle and productivity demands before selection.'),
  PlantBookPoint('Multi-purpose use', 'If the machine is being used for a different task, conduct a new risk assessment and verify attachment/task suitability.'),
  PlantBookPoint('Prohibited improvisation', 'Do not use buckets, blades, forks, bodies, hooks or other components for unapproved lifting, carrying people or other improvised purposes.'),
  PlantBookPoint('Change management', 'Reassess whenever the machine, attachment, route, material, sequence or surrounding activity changes.')
]),
      PlantBookSection('05 — Hazards: Identification', [
  PlantBookPoint('Mechanical', 'Identify crush, shear, pinch, entanglement, struck-by and unexpected-movement zones.'),
  PlantBookPoint('Stability', 'Identify rollover, tip-over, sliding, edge failure and ground bearing hazards.'),
  PlantBookPoint('Traffic', 'Identify collision, reversing, blind-spot and pedestrian interface hazards.'),
  PlantBookPoint('Energy', 'Identify hydraulic, pneumatic, electrical, thermal, stored mechanical and pressure energy.'),
  PlantBookPoint('Environment', 'Identify dust, noise, vibration, heat, poor visibility, rain, flooding and contamination hazards.')
]),
      PlantBookSection('06 — Why Hazards Occur', [
  PlantBookPoint('Human factors', 'Inadequate competency, fatigue, distraction, rushing, poor communication and failure to follow the approved method can defeat controls.'),
  PlantBookPoint('Equipment factors', 'Defects, poor maintenance, incorrect attachment, bypassed safety devices or unsuitable machine selection can create uncontrolled risk.'),
  PlantBookPoint('Work-area factors', 'Poor ground, congestion, inadequate segregation, poor lighting and uncontrolled access increase exposure.'),
  PlantBookPoint('Planning factors', 'Incomplete RAMS/JSA, missing service information, incorrect capacity assumptions or inadequate emergency planning create predictable failures.'),
  PlantBookPoint('Change factors', 'Changing weather, route, load, personnel or simultaneous operations can invalidate the original controls.')
]),
      PlantBookSection('07 — Risk Assessment / Hierarchy of Controls', [
  PlantBookPoint('Eliminate', 'Remove unnecessary plant movement, manual interface or hazardous step where practicable.'),
  PlantBookPoint('Substitute', 'Use a safer machine, attachment, route or process when reasonably practicable.'),
  PlantBookPoint('Engineering', 'Use barriers, interlocks, guarding, cameras, alarms, mechanical supports, remote controls and engineered ground/traffic controls.'),
  PlantBookPoint('Administrative', 'Use RAMS/JSA, permits, competence controls, exclusion zones, inspection systems, traffic plans and supervision.'),
  PlantBookPoint('PPE', 'Select task-specific PPE after higher-level controls; PPE must not substitute for segregation or engineering controls.')
]),
      PlantBookSection('08 — Detailed Preventive Controls', [
  PlantBookPoint('Pre-job briefing', 'Explain machine limits, route, load/material, exclusion zone, signals, emergency arrangements and stop-work triggers.'),
  PlantBookPoint('Exclusion', 'Physically separate people from moving plant and hazardous machine envelopes wherever practicable.'),
  PlantBookPoint('Visibility', 'Use suitable mirrors, cameras, lighting, spotters and controlled routes where direct visibility is limited.'),
  PlantBookPoint('Housekeeping', 'Keep travel and work surfaces clear, stable and free of obstructions.'),
  PlantBookPoint('Verification', 'Supervision must verify critical controls physically, not merely rely on paperwork.')
]),
      PlantBookSection('09 — Measurements / Limits / Clearances', [
  PlantBookPoint('Source rule', 'Do not use generic internet values as regulatory limits. Confirm exact values from the current manufacturer manual, ADPHC CoP, project specification or competent engineering assessment.'),
  PlantBookPoint('Capacity', 'Rated capacity, payload, load centre, reach, attachment rating and stability limits must be taken from the exact machine/configuration.'),
  PlantBookPoint('Clearance', 'Required clearance from overhead services, edges, traffic and structures must be established from the applicable current requirement and site assessment.'),
  PlantBookPoint('Slope', 'Use manufacturer-approved slope/gradient limits and site-specific ground assessment.'),
  PlantBookPoint('Speed', 'Use the lower of the site-approved speed and the machine/manufacturer safe operating limit.')
]),
      PlantBookSection('10 — Ground / Foundation / Work Area', [
  PlantBookPoint('Bearing', "Assess ground bearing capacity for the machine's imposed loads; consider soft spots, voids, trenches and buried structures."),
  PlantBookPoint('Drainage', 'Control water accumulation and saturated ground that can reduce stability and traction.'),
  PlantBookPoint('Edges', 'Do not approach unsupported edges, excavations or embankments without a competent assessment and defined setback.'),
  PlantBookPoint('Routes', 'Confirm route width, turning radius, gradients, overhead clearance and emergency access.'),
  PlantBookPoint('Weather', 'Reassess ground and visibility after heavy rain, flooding, high winds, dust or other significant weather change.')
]),
      PlantBookSection('11 — Operator Competency', [
  PlantBookPoint('Competence', 'Operator training must match the exact equipment type, task and attachment and comply with applicable site/authority requirements.'),
  PlantBookPoint('Familiarisation', 'Provide machine-specific familiarisation before first use or after a significant configuration change.'),
  PlantBookPoint('Authorisation', 'Only authorised personnel may operate equipment.'),
  PlantBookPoint('Signals', 'Banksman/signaller competence and a single agreed communication system are required where signalling is used.'),
  PlantBookPoint('Fitness', 'No operation while impaired by fatigue, alcohol, drugs, illness or distraction.')
]),
      PlantBookSection('12 — PPE', [
  PlantBookPoint('Head/eye/foot', 'Use site-required head protection, eye protection and safety footwear appropriate to the task.'),
  PlantBookPoint('High visibility', 'Use high-visibility clothing where required by the traffic management system.'),
  PlantBookPoint('Hearing', 'Use hearing protection where risk assessment identifies hazardous noise.'),
  PlantBookPoint('Respiratory', 'Use suitable respiratory protection only where engineering and exposure controls do not adequately control airborne contaminants.'),
  PlantBookPoint('Specialist PPE', 'Add task-specific gloves, face protection, fall protection or chemical/thermal PPE based on the hazard assessment.')
]),
      PlantBookSection('13 — RAMS / JSA / PTW', [
  PlantBookPoint('RAMS', 'Approved risk assessment and method statement must describe the actual equipment, task, route, hazards and critical controls.'),
  PlantBookPoint('JSA', 'Break the task into steps and identify hazards and controls for each step.'),
  PlantBookPoint('PTW', 'Obtain permits where the activity or site system requires them, including interfaces with services, hot work, excavation or restricted areas.'),
  PlantBookPoint('Briefing', 'Ensure affected workers understand the method before work starts.'),
  PlantBookPoint('Change', 'Stop and revise the risk assessment when the work materially changes.')
]),
      PlantBookSection('14 — Pre-Use Inspection', [
  PlantBookPoint('Walk-around', 'Check structure, tyres/tracks, wheels, leaks, hoses, guards, steps, handrails, mirrors, cameras, lights and alarms.'),
  PlantBookPoint('Controls', 'Test steering, brakes, parking brake, travel controls and working controls as applicable.'),
  PlantBookPoint('Safety devices', 'Check seat restraint, emergency stop, interlocks, alarms and other safety-critical devices.'),
  PlantBookPoint('Working equipment', 'Inspect attachment, pins, locking systems, cutting/compacting/hauling components and hydraulic connections.'),
  PlantBookPoint('Defects', 'Tag out equipment with safety-critical defects and prevent operation until authorised repair/release.')
]),
      PlantBookSection('15 — Inspection / Maintenance', [
  PlantBookPoint('Planned maintenance', "Follow the manufacturer's maintenance schedule and site preventive-maintenance system."),
  PlantBookPoint('Periodic examination', 'Complete statutory or project-required inspections/examinations by competent authorised personnel.'),
  PlantBookPoint('Records', 'Maintain inspection, maintenance, defect and release records.'),
  PlantBookPoint('Modification', 'Engineering approval is required for safety-significant modification; reassess the risk after modification.'),
  PlantBookPoint('Return to service', 'Verify repair completion and safety-device function before releasing equipment.')
]),
      PlantBookSection('16 — Safe Start-Up', [
  PlantBookPoint('Access', 'Use designated steps/handholds and maintain three-point contact where applicable.'),
  PlantBookPoint('Cab check', 'Confirm controls are neutral and surroundings are clear before starting/moving.'),
  PlantBookPoint('Restraint', 'Fasten the operator restraint before machine movement.'),
  PlantBookPoint('System check', 'Confirm instruments, alarms and required safety functions are normal.'),
  PlantBookPoint('Area clearance', 'Do not start or move until people in the machine envelope are clear.')
]),
      PlantBookSection('17 — Safe Operation', [
  PlantBookPoint('Control', 'Operate smoothly and maintain full control of the machine at all times.'),
  PlantBookPoint('Load/material', 'Keep loads/material within the rated operating envelope and stable.'),
  PlantBookPoint('Visibility', 'Stop when the intended path cannot be safely seen or positively controlled.'),
  PlantBookPoint('Speed', 'Adjust speed for terrain, load, visibility, traffic, pedestrians and weather.'),
  PlantBookPoint('No distraction', 'Do not use phones or engage in distracting activity while operating.')
]),
      PlantBookSection('18 — Loading / Unloading / Material Interface', [
  PlantBookPoint('Loading zone', 'Establish a controlled loading area with clear communication between machine operators and other personnel.'),
  PlantBookPoint('Load stability', 'Ensure material is stable and does not create an uncontrolled shift or fall.'),
  PlantBookPoint('Truck interface', 'Coordinate machine and vehicle positions and keep non-essential persons outside the interface.'),
  PlantBookPoint('Overloading', 'Never exceed machine, attachment, vehicle or route limitations.'),
  PlantBookPoint('Spillage', 'Control material spillage promptly to prevent collision, slip, dust and visibility hazards.')
]),
      PlantBookSection('19 — Reversing / Blind Spots', [
  PlantBookPoint('Avoid', 'Eliminate unnecessary reversing through route planning.'),
  PlantBookPoint('Visibility aids', 'Use cameras, mirrors, alarms and lighting as designed; these do not replace segregation.'),
  PlantBookPoint('Banksman', 'Use a competent banksman where required by risk assessment/site rules.'),
  PlantBookPoint('Signal loss', 'Stop immediately if the operator loses the agreed signal or visual confirmation.'),
  PlantBookPoint('Pedestrians', 'Never assume pedestrians can see or hear the machine.')
]),
      PlantBookSection('20 — Traffic / Pedestrian Segregation', [
  PlantBookPoint('Traffic plan', 'Integrate machine movement into the approved traffic management and logistics plan.'),
  PlantBookPoint('Barriers', 'Use physical barriers and protected walkways wherever practicable.'),
  PlantBookPoint('Crossings', 'Control pedestrian crossings with designated routes and clear sight lines.'),
  PlantBookPoint('Public interface', 'Use stronger controls where site work interfaces with public roads or third parties.'),
  PlantBookPoint('Coordination', 'Coordinate simultaneous plant movements through a nominated competent person when required.')
]),
      PlantBookSection('21 — Slopes / Edges / Stability', [
  PlantBookPoint('Stability envelope', 'Understand how load, machine orientation, attachment position and slope affect stability.'),
  PlantBookPoint('Slope travel', 'Follow manufacturer limits and approved direction of travel; avoid unsafe cross-slope manoeuvres.'),
  PlantBookPoint('Edges', 'Maintain the project-approved safe setback from unsupported edges.'),
  PlantBookPoint('Soft ground', 'Stop when ground conditions cannot safely support the machine.'),
  PlantBookPoint('Rollover', 'Never attempt to recover a tipping/unstable machine through sudden manoeuvres; follow the emergency/recovery plan.')
]),
      PlantBookSection('22 — Overhead / Underground Services', [
  PlantBookPoint('Locate', 'Identify and verify underground services before ground disturbance.'),
  PlantBookPoint('Overhead', 'Establish the required exclusion controls around overhead services using the current applicable requirement.'),
  PlantBookPoint('Permit', 'Use service permits/authorisations where required.'),
  PlantBookPoint('Spotter', 'Use a competent spotter where specified by the risk assessment or service control system.'),
  PlantBookPoint('Strike response', 'If a service is contacted or suspected, stop, isolate the area and follow the emergency/service-owner procedure.')
]),
      PlantBookSection('23 — Weather / Environment', [
  PlantBookPoint('Heat', 'Apply the applicable heat-stress controls, hydration, rest and monitoring requirements.'),
  PlantBookPoint('Dust', 'Control dust through suitable suppression, enclosure or process controls.'),
  PlantBookPoint('Noise', 'Assess occupational and community noise where relevant.'),
  PlantBookPoint('Wind', 'Follow manufacturer/project wind restrictions for machine and attachment operations.'),
  PlantBookPoint('Poor visibility', 'Stop or reduce operations when visibility is insufficient for safe control.')
]),
      PlantBookSection('24 — Attachments / Accessories', [
  PlantBookPoint('Compatibility', 'Use only manufacturer-approved or engineered-compatible attachments.'),
  PlantBookPoint('Locking', 'Verify positive locking before operation.'),
  PlantBookPoint('Rating', 'Attachment capacity and machine capacity must both be respected.'),
  PlantBookPoint('Hydraulics', 'Check hoses, couplings, pressure and contamination controls.'),
  PlantBookPoint('Changeover', 'Use an approved attachment-change procedure and rebrief operators when risk changes.')
]),
      PlantBookSection('25 — Maintenance Isolation / Stored Energy', [
  PlantBookPoint('Isolation', 'Isolate electrical, hydraulic, pneumatic, mechanical and other energy sources before intrusive maintenance.'),
  PlantBookPoint('Lockout', "Apply the site's lockout/tagout process where hazardous energy could be released."),
  PlantBookPoint('Raised equipment', 'Never rely on hydraulics alone to support raised components; use approved mechanical supports.'),
  PlantBookPoint('Pressure', 'Relieve stored hydraulic/pneumatic pressure before disconnecting lines.'),
  PlantBookPoint('Verification', 'Test for zero energy/zero movement before entering the danger zone.')
]),
      PlantBookSection('26 — Fuel / Battery / Fire', [
  PlantBookPoint('Fuel', 'Control ignition sources, spills, refuelling areas and fuel storage.'),
  PlantBookPoint('Battery', 'Use suitable charging arrangements, ventilation and electrical controls.'),
  PlantBookPoint('Fire protection', 'Provide appropriate fire equipment and maintain access to it.'),
  PlantBookPoint('Hot surfaces', 'Control contact and ignition hazards from engines, exhausts and other hot components.'),
  PlantBookPoint('Leak response', 'Stop use and control leaks rather than continuing with a known fire/environmental hazard.')
]),
      PlantBookSection('27 — Emergency / Breakdown', [
  PlantBookPoint('Breakdown', 'Move to a safe location where possible, secure the machine and establish an exclusion zone.'),
  PlantBookPoint('Fire', 'Stop, isolate if safe, raise alarm and follow the site fire response procedure.'),
  PlantBookPoint('Rollover', 'Remain restrained as appropriate and follow machine/site emergency guidance; do not jump unless required by an immediate life-threatening condition.'),
  PlantBookPoint('Service strike', 'Treat suspected electrical/gas/service contact as an emergency and follow the established procedure.'),
  PlantBookPoint('Recovery', 'Use planned recovery equipment and competent personnel; never improvise a recovery that introduces additional risk.')
]),
      PlantBookSection('28 — Rescue / Recovery', [
  PlantBookPoint('Planning', 'Identify credible rescue/recovery scenarios before high-risk operations.'),
  PlantBookPoint('Recovery equipment', 'Use equipment rated and suitable for the machine and recovery method.'),
  PlantBookPoint('Exclusion', 'Keep non-essential people outside the recovery zone.'),
  PlantBookPoint('Competence', 'Only trained/competent personnel should conduct specialist recovery.'),
  PlantBookPoint('Post-recovery', 'Inspect the machine and ground before return to service.')
]),
      PlantBookSection('29 — Stop-Work Conditions', [
  PlantBookPoint('Critical defects', 'Stop for brake/steering failure, structural damage, failed restraint or failed safety-critical device.'),
  PlantBookPoint('Stability', 'Stop for unstable ground, uncontrolled edge failure, rollover risk or loss of machine stability.'),
  PlantBookPoint('People', 'Stop when pedestrians enter the machine danger zone and cannot be safely controlled.'),
  PlantBookPoint('Visibility', 'Stop when the operator cannot maintain safe visibility/communication.'),
  PlantBookPoint('Method failure', 'Stop when actual work conditions no longer match the approved RAMS/JSA.')
]),
      PlantBookSection('30 — Unsafe Practices', [
  PlantBookPoint('Bypassing', 'Never bypass interlocks, alarms, guards or safety devices.'),
  PlantBookPoint('Improvised use', 'Do not use equipment outside its intended purpose or rated capacity.'),
  PlantBookPoint('People carrying', 'Do not carry passengers unless the machine is specifically designed and authorised for passengers.'),
  PlantBookPoint('Maintenance under load', 'Never enter beneath unsupported raised equipment.'),
  PlantBookPoint('Distraction', 'Do not operate while using a phone or while otherwise distracted.')
]),
      PlantBookSection('31 — Supervisor / HSE Responsibilities', [
  PlantBookPoint('Before work', 'Verify competency, inspection status, RAMS/JSA, work-area controls and emergency arrangements.'),
  PlantBookPoint('Field verification', 'Physically inspect critical controls and observe the actual operating method.'),
  PlantBookPoint('Monitoring', 'Monitor changes in ground, traffic, weather, people and equipment condition.'),
  PlantBookPoint('Intervention', 'Stop unsafe work and restore critical controls before restart.'),
  PlantBookPoint('Records', 'Maintain inspection, briefing, observation, defect and corrective-action evidence.')
]),
      PlantBookSection('32 — Records / Documents', [
  PlantBookPoint('Equipment', 'Equipment register, identification, inspection and maintenance records.'),
  PlantBookPoint('People', 'Competency, authorisation, familiarisation and toolbox records.'),
  PlantBookPoint('Task', 'RAMS/JSA, permits, traffic plans, lifting plans or service permits as applicable.'),
  PlantBookPoint('Defects', 'Defect reports, isolation/tag-out and repair/release evidence.'),
  PlantBookPoint('Incident', 'Near miss, incident, observation and corrective-action records.')
]),
      PlantBookSection('33 — Toolbox Talk', [
  PlantBookPoint('Machine', 'Explain machine-specific hazards, capacity, attachment and safety devices.'),
  PlantBookPoint('Area', 'Explain route, ground, edges, services, traffic and pedestrian controls.'),
  PlantBookPoint('People', 'Confirm operator, banksman, supervisor and emergency contacts.'),
  PlantBookPoint('Signals', 'Agree one communication/signalling system.'),
  PlantBookPoint('Stop-work', 'State clear stop-work triggers and confirm every worker can raise a concern.')
]),
      PlantBookSection('34 — Field Checklist / Quick Reference', [
  PlantBookPoint('Documents', 'RAMS/JSA, permits and inspection status verified.'),
  PlantBookPoint('Machine', 'Pre-use inspection complete; no safety-critical defect.'),
  PlantBookPoint('People', 'Competent authorised operator and required banksman/spotter.'),
  PlantBookPoint('Area', 'Ground, route, segregation, services and weather checked.'),
  PlantBookPoint('Operation', 'Capacity, speed, visibility and attachment controls maintained.')
]),
      PlantBookSection('35 — Corrective Action', [
  PlantBookPoint('Immediate', 'Stop the unsafe activity and make the area safe.'),
  PlantBookPoint('Defect', 'Isolate/tag out defective equipment where required.'),
  PlantBookPoint('Root cause', 'Identify why the control failed rather than correcting only the symptom.'),
  PlantBookPoint('Close-out', 'Verify the corrective action physically before returning to normal work.'),
  PlantBookPoint('Learning', 'Share significant findings through toolbox talks and lessons learned.')
]),
      PlantBookSection('36 — UAE / Abu Dhabi / Dubai Applicability', [
  PlantBookPoint('Abu Dhabi', 'Apply the current ADPHC/ADOSH-SF requirements and Abu Dhabi project/client requirements.'),
  PlantBookPoint('UAE common', 'Also comply with applicable federal requirements and project contractual obligations.'),
  PlantBookPoint('Dubai', 'Dubai requirements are not automatically transferable to Abu Dhabi; maintain separate jurisdictional references.'),
  PlantBookPoint('Sector', 'Oil & gas, offshore, industrial and specialist projects may impose additional client/sector controls.'),
  PlantBookPoint('Hierarchy', 'Where requirements differ, identify the applicable legal, authority, client and manufacturer requirements and obtain competent clarification.')
]),
      PlantBookSection('37 — Cross-References', [
  PlantBookPoint('Plant', 'ADPHC CoP 36.0 — Plant and Equipment.'),
  PlantBookPoint('Traffic', 'CoP 33.0 Working On or Adjacent to a Road and CoP 44.0 Traffic Management and Logistics where applicable.'),
  PlantBookPoint('Services', 'CoP 39.0 Overhead and Underground Services.'),
  PlantBookPoint('Lifting', 'CoP 34.0 Safe Use of Lifting Equipment and Lifting Accessories where lifting is involved.'),
  PlantBookPoint('Other', 'Link to electrical, hot work, heat, vibration, noise, excavation, machine guarding and lockout modules according to task.')
]),
      PlantBookSection('38 — Official Reference / Regulatory Verification', [
  PlantBookPoint('Official registry', 'Use the Abu Dhabi Public Health Centre Code of Practices registry as the primary source for current CoP versions and effective dates.'),
  PlantBookPoint('Current baseline', 'CoP 36.0 Plant and Equipment is listed as Version 4.1, effective February 2026.'),
  PlantBookPoint('Verification rule', 'Before regulatory lock, verify the exact current PDF, applicability, definitions, mandatory requirements and numeric values.'),
  PlantBookPoint('Manufacturer source', 'The exact machine operator manual, load chart and safety instructions must be available and followed.'),
  PlantBookPoint('Field rule', 'This handbook supports field understanding; it does not replace the applicable law, CoP, engineering design, manufacturer instructions or approved project documents.')
]),
      PlantBookSection('39 — Road / Asphalt Paver: Machine-specific hazards', [
  PlantBookPoint('Hot material', 'Asphalt and heated components can cause burns; establish thermal controls and safe access.'),
  PlantBookPoint('Screed', 'Control crush, pinch and burn hazards around screed mechanisms.'),
  PlantBookPoint('Auger', 'Guard and isolate auger/conveyor systems before entry or maintenance.'),
  PlantBookPoint('Fumes', 'Assess asphalt fumes and ensure ventilation/exposure controls.'),
  PlantBookPoint('Traffic', 'The paver is commonly used in live-road environments; integrate fully with the traffic management plan.')
]),
      PlantBookSection('40 — Road / Asphalt Paver: Operating sequence', [
  PlantBookPoint('Set-up', 'Confirm route, paving width, delivery vehicle interface and emergency access.'),
  PlantBookPoint('Truck interface', 'Coordinate truck approach, reversing and material transfer with a controlled system.'),
  PlantBookPoint('Material', 'Prevent unnecessary contact with hot asphalt and maintain safe access.'),
  PlantBookPoint('Screed adjustment', 'Only authorised personnel should adjust the screed using safe procedures.'),
  PlantBookPoint('Shutdown', 'Stop material feed, secure moving parts and isolate before cleaning/maintenance.')
]),
      PlantBookSection('41 — Road / Asphalt Paver: Environmental controls', [
  PlantBookPoint('Fumes', 'Use exposure controls and monitor worker conditions where required.'),
  PlantBookPoint('Heat', 'Combine hot-material hazards with UAE heat-stress controls.'),
  PlantBookPoint('Noise', 'Assess paver, truck and roller combined noise.'),
  PlantBookPoint('Traffic', 'Maintain barriers, signs, lighting and safe work-zone transitions.'),
  PlantBookPoint('Spills', 'Control fuel, hydraulic oil and asphalt/material spills promptly.')
])
    ],
  ),
PlantBookTopic(
    code: '5AG',
    title: 'Trencher',
    regulatoryBasis: 'ADPHC CoP 36.0 Plant & Equipment V4.1; CoP 29.0 Excavation Work; CoP 39.0 Overhead and Underground Services; applicable machine-guarding requirements.',
    fieldPurpose: 'Field reference for trenching, service protection, cutting-system hazards, excavation stability and emergency response.',
    sections: [
      PlantBookSection('01 — What / Purpose / Scope', [
  PlantBookPoint('Definition', 'Trencher is mobile/portable plant used for site operations. The exact machine configuration, capacity, attachment and manufacturer limitations determine its safe operating envelope.'),
  PlantBookPoint('Purpose', 'Use Trencher only for tasks for which the machine and attachment are designed, rated and authorised.'),
  PlantBookPoint('Scope', 'Covers planning, selection, mobilisation, inspection, operation, maintenance, traffic interaction, emergency response and field verification.'),
  PlantBookPoint('People at risk', 'Operators, banksmen, ground workers, mechanics, supervisors, visitors, drivers and members of the public where site boundaries interface with public areas.'),
  PlantBookPoint('Golden rule', 'Suitable equipment + competent operator + inspected machine + controlled work area + approved method + continuous monitoring.')
]),
      PlantBookSection('02 — Types / Configurations', [
  PlantBookPoint('Machine variants', 'Identify the exact model, operating mass, power source, attachment and configuration before applying any operating information.'),
  PlantBookPoint('Attachments', 'Attachment changes can change stability, capacity, visibility, hydraulic demand and hazard profile.'),
  PlantBookPoint('Manufacturer data', 'Use the machine identification plate, operator manual, load chart and attachment documentation for the exact configuration.'),
  PlantBookPoint('Site configuration', 'Record any approved project-specific modification or accessory; unauthorised modifications are not acceptable.'),
  PlantBookPoint('Selection', 'Select the smallest suitable machine that can safely perform the task without creating additional hazards.')
]),
      PlantBookSection('03 — Main Components', [
  PlantBookPoint('Structure', 'Inspect chassis/frame, guards, access systems, operator protection and structural connections.'),
  PlantBookPoint('Power system', 'Check engine/electric/hydraulic/pneumatic systems appropriate to the equipment.'),
  PlantBookPoint('Controls', 'Controls, indicators, alarms, emergency functions and safety interlocks must be understood and functional.'),
  PlantBookPoint('Working equipment', "Inspect the machine's working attachment, linkage, cutting/compacting/hauling components and securing systems."),
  PlantBookPoint('Safety systems', 'Seat restraint, ROPS/FOPS where fitted, cameras, alarms, lights, mirrors, interlocks and emergency devices must not be bypassed.')
]),
      PlantBookSection('04 — Applications / When Used', [
  PlantBookPoint('Approved use', "Use only within the machine's intended application and rated operating envelope."),
  PlantBookPoint('Task matching', 'Confirm material type, load, distance, terrain, gradient, clearance, cycle and productivity demands before selection.'),
  PlantBookPoint('Multi-purpose use', 'If the machine is being used for a different task, conduct a new risk assessment and verify attachment/task suitability.'),
  PlantBookPoint('Prohibited improvisation', 'Do not use buckets, blades, forks, bodies, hooks or other components for unapproved lifting, carrying people or other improvised purposes.'),
  PlantBookPoint('Change management', 'Reassess whenever the machine, attachment, route, material, sequence or surrounding activity changes.')
]),
      PlantBookSection('05 — Hazards: Identification', [
  PlantBookPoint('Mechanical', 'Identify crush, shear, pinch, entanglement, struck-by and unexpected-movement zones.'),
  PlantBookPoint('Stability', 'Identify rollover, tip-over, sliding, edge failure and ground bearing hazards.'),
  PlantBookPoint('Traffic', 'Identify collision, reversing, blind-spot and pedestrian interface hazards.'),
  PlantBookPoint('Energy', 'Identify hydraulic, pneumatic, electrical, thermal, stored mechanical and pressure energy.'),
  PlantBookPoint('Environment', 'Identify dust, noise, vibration, heat, poor visibility, rain, flooding and contamination hazards.')
]),
      PlantBookSection('06 — Why Hazards Occur', [
  PlantBookPoint('Human factors', 'Inadequate competency, fatigue, distraction, rushing, poor communication and failure to follow the approved method can defeat controls.'),
  PlantBookPoint('Equipment factors', 'Defects, poor maintenance, incorrect attachment, bypassed safety devices or unsuitable machine selection can create uncontrolled risk.'),
  PlantBookPoint('Work-area factors', 'Poor ground, congestion, inadequate segregation, poor lighting and uncontrolled access increase exposure.'),
  PlantBookPoint('Planning factors', 'Incomplete RAMS/JSA, missing service information, incorrect capacity assumptions or inadequate emergency planning create predictable failures.'),
  PlantBookPoint('Change factors', 'Changing weather, route, load, personnel or simultaneous operations can invalidate the original controls.')
]),
      PlantBookSection('07 — Risk Assessment / Hierarchy of Controls', [
  PlantBookPoint('Eliminate', 'Remove unnecessary plant movement, manual interface or hazardous step where practicable.'),
  PlantBookPoint('Substitute', 'Use a safer machine, attachment, route or process when reasonably practicable.'),
  PlantBookPoint('Engineering', 'Use barriers, interlocks, guarding, cameras, alarms, mechanical supports, remote controls and engineered ground/traffic controls.'),
  PlantBookPoint('Administrative', 'Use RAMS/JSA, permits, competence controls, exclusion zones, inspection systems, traffic plans and supervision.'),
  PlantBookPoint('PPE', 'Select task-specific PPE after higher-level controls; PPE must not substitute for segregation or engineering controls.')
]),
      PlantBookSection('08 — Detailed Preventive Controls', [
  PlantBookPoint('Pre-job briefing', 'Explain machine limits, route, load/material, exclusion zone, signals, emergency arrangements and stop-work triggers.'),
  PlantBookPoint('Exclusion', 'Physically separate people from moving plant and hazardous machine envelopes wherever practicable.'),
  PlantBookPoint('Visibility', 'Use suitable mirrors, cameras, lighting, spotters and controlled routes where direct visibility is limited.'),
  PlantBookPoint('Housekeeping', 'Keep travel and work surfaces clear, stable and free of obstructions.'),
  PlantBookPoint('Verification', 'Supervision must verify critical controls physically, not merely rely on paperwork.')
]),
      PlantBookSection('09 — Measurements / Limits / Clearances', [
  PlantBookPoint('Source rule', 'Do not use generic internet values as regulatory limits. Confirm exact values from the current manufacturer manual, ADPHC CoP, project specification or competent engineering assessment.'),
  PlantBookPoint('Capacity', 'Rated capacity, payload, load centre, reach, attachment rating and stability limits must be taken from the exact machine/configuration.'),
  PlantBookPoint('Clearance', 'Required clearance from overhead services, edges, traffic and structures must be established from the applicable current requirement and site assessment.'),
  PlantBookPoint('Slope', 'Use manufacturer-approved slope/gradient limits and site-specific ground assessment.'),
  PlantBookPoint('Speed', 'Use the lower of the site-approved speed and the machine/manufacturer safe operating limit.')
]),
      PlantBookSection('10 — Ground / Foundation / Work Area', [
  PlantBookPoint('Bearing', "Assess ground bearing capacity for the machine's imposed loads; consider soft spots, voids, trenches and buried structures."),
  PlantBookPoint('Drainage', 'Control water accumulation and saturated ground that can reduce stability and traction.'),
  PlantBookPoint('Edges', 'Do not approach unsupported edges, excavations or embankments without a competent assessment and defined setback.'),
  PlantBookPoint('Routes', 'Confirm route width, turning radius, gradients, overhead clearance and emergency access.'),
  PlantBookPoint('Weather', 'Reassess ground and visibility after heavy rain, flooding, high winds, dust or other significant weather change.')
]),
      PlantBookSection('11 — Operator Competency', [
  PlantBookPoint('Competence', 'Operator training must match the exact equipment type, task and attachment and comply with applicable site/authority requirements.'),
  PlantBookPoint('Familiarisation', 'Provide machine-specific familiarisation before first use or after a significant configuration change.'),
  PlantBookPoint('Authorisation', 'Only authorised personnel may operate equipment.'),
  PlantBookPoint('Signals', 'Banksman/signaller competence and a single agreed communication system are required where signalling is used.'),
  PlantBookPoint('Fitness', 'No operation while impaired by fatigue, alcohol, drugs, illness or distraction.')
]),
      PlantBookSection('12 — PPE', [
  PlantBookPoint('Head/eye/foot', 'Use site-required head protection, eye protection and safety footwear appropriate to the task.'),
  PlantBookPoint('High visibility', 'Use high-visibility clothing where required by the traffic management system.'),
  PlantBookPoint('Hearing', 'Use hearing protection where risk assessment identifies hazardous noise.'),
  PlantBookPoint('Respiratory', 'Use suitable respiratory protection only where engineering and exposure controls do not adequately control airborne contaminants.'),
  PlantBookPoint('Specialist PPE', 'Add task-specific gloves, face protection, fall protection or chemical/thermal PPE based on the hazard assessment.')
]),
      PlantBookSection('13 — RAMS / JSA / PTW', [
  PlantBookPoint('RAMS', 'Approved risk assessment and method statement must describe the actual equipment, task, route, hazards and critical controls.'),
  PlantBookPoint('JSA', 'Break the task into steps and identify hazards and controls for each step.'),
  PlantBookPoint('PTW', 'Obtain permits where the activity or site system requires them, including interfaces with services, hot work, excavation or restricted areas.'),
  PlantBookPoint('Briefing', 'Ensure affected workers understand the method before work starts.'),
  PlantBookPoint('Change', 'Stop and revise the risk assessment when the work materially changes.')
]),
      PlantBookSection('14 — Pre-Use Inspection', [
  PlantBookPoint('Walk-around', 'Check structure, tyres/tracks, wheels, leaks, hoses, guards, steps, handrails, mirrors, cameras, lights and alarms.'),
  PlantBookPoint('Controls', 'Test steering, brakes, parking brake, travel controls and working controls as applicable.'),
  PlantBookPoint('Safety devices', 'Check seat restraint, emergency stop, interlocks, alarms and other safety-critical devices.'),
  PlantBookPoint('Working equipment', 'Inspect attachment, pins, locking systems, cutting/compacting/hauling components and hydraulic connections.'),
  PlantBookPoint('Defects', 'Tag out equipment with safety-critical defects and prevent operation until authorised repair/release.')
]),
      PlantBookSection('15 — Inspection / Maintenance', [
  PlantBookPoint('Planned maintenance', "Follow the manufacturer's maintenance schedule and site preventive-maintenance system."),
  PlantBookPoint('Periodic examination', 'Complete statutory or project-required inspections/examinations by competent authorised personnel.'),
  PlantBookPoint('Records', 'Maintain inspection, maintenance, defect and release records.'),
  PlantBookPoint('Modification', 'Engineering approval is required for safety-significant modification; reassess the risk after modification.'),
  PlantBookPoint('Return to service', 'Verify repair completion and safety-device function before releasing equipment.')
]),
      PlantBookSection('16 — Safe Start-Up', [
  PlantBookPoint('Access', 'Use designated steps/handholds and maintain three-point contact where applicable.'),
  PlantBookPoint('Cab check', 'Confirm controls are neutral and surroundings are clear before starting/moving.'),
  PlantBookPoint('Restraint', 'Fasten the operator restraint before machine movement.'),
  PlantBookPoint('System check', 'Confirm instruments, alarms and required safety functions are normal.'),
  PlantBookPoint('Area clearance', 'Do not start or move until people in the machine envelope are clear.')
]),
      PlantBookSection('17 — Safe Operation', [
  PlantBookPoint('Control', 'Operate smoothly and maintain full control of the machine at all times.'),
  PlantBookPoint('Load/material', 'Keep loads/material within the rated operating envelope and stable.'),
  PlantBookPoint('Visibility', 'Stop when the intended path cannot be safely seen or positively controlled.'),
  PlantBookPoint('Speed', 'Adjust speed for terrain, load, visibility, traffic, pedestrians and weather.'),
  PlantBookPoint('No distraction', 'Do not use phones or engage in distracting activity while operating.')
]),
      PlantBookSection('18 — Loading / Unloading / Material Interface', [
  PlantBookPoint('Loading zone', 'Establish a controlled loading area with clear communication between machine operators and other personnel.'),
  PlantBookPoint('Load stability', 'Ensure material is stable and does not create an uncontrolled shift or fall.'),
  PlantBookPoint('Truck interface', 'Coordinate machine and vehicle positions and keep non-essential persons outside the interface.'),
  PlantBookPoint('Overloading', 'Never exceed machine, attachment, vehicle or route limitations.'),
  PlantBookPoint('Spillage', 'Control material spillage promptly to prevent collision, slip, dust and visibility hazards.')
]),
      PlantBookSection('19 — Reversing / Blind Spots', [
  PlantBookPoint('Avoid', 'Eliminate unnecessary reversing through route planning.'),
  PlantBookPoint('Visibility aids', 'Use cameras, mirrors, alarms and lighting as designed; these do not replace segregation.'),
  PlantBookPoint('Banksman', 'Use a competent banksman where required by risk assessment/site rules.'),
  PlantBookPoint('Signal loss', 'Stop immediately if the operator loses the agreed signal or visual confirmation.'),
  PlantBookPoint('Pedestrians', 'Never assume pedestrians can see or hear the machine.')
]),
      PlantBookSection('20 — Traffic / Pedestrian Segregation', [
  PlantBookPoint('Traffic plan', 'Integrate machine movement into the approved traffic management and logistics plan.'),
  PlantBookPoint('Barriers', 'Use physical barriers and protected walkways wherever practicable.'),
  PlantBookPoint('Crossings', 'Control pedestrian crossings with designated routes and clear sight lines.'),
  PlantBookPoint('Public interface', 'Use stronger controls where site work interfaces with public roads or third parties.'),
  PlantBookPoint('Coordination', 'Coordinate simultaneous plant movements through a nominated competent person when required.')
]),
      PlantBookSection('21 — Slopes / Edges / Stability', [
  PlantBookPoint('Stability envelope', 'Understand how load, machine orientation, attachment position and slope affect stability.'),
  PlantBookPoint('Slope travel', 'Follow manufacturer limits and approved direction of travel; avoid unsafe cross-slope manoeuvres.'),
  PlantBookPoint('Edges', 'Maintain the project-approved safe setback from unsupported edges.'),
  PlantBookPoint('Soft ground', 'Stop when ground conditions cannot safely support the machine.'),
  PlantBookPoint('Rollover', 'Never attempt to recover a tipping/unstable machine through sudden manoeuvres; follow the emergency/recovery plan.')
]),
      PlantBookSection('22 — Overhead / Underground Services', [
  PlantBookPoint('Locate', 'Identify and verify underground services before ground disturbance.'),
  PlantBookPoint('Overhead', 'Establish the required exclusion controls around overhead services using the current applicable requirement.'),
  PlantBookPoint('Permit', 'Use service permits/authorisations where required.'),
  PlantBookPoint('Spotter', 'Use a competent spotter where specified by the risk assessment or service control system.'),
  PlantBookPoint('Strike response', 'If a service is contacted or suspected, stop, isolate the area and follow the emergency/service-owner procedure.')
]),
      PlantBookSection('23 — Weather / Environment', [
  PlantBookPoint('Heat', 'Apply the applicable heat-stress controls, hydration, rest and monitoring requirements.'),
  PlantBookPoint('Dust', 'Control dust through suitable suppression, enclosure or process controls.'),
  PlantBookPoint('Noise', 'Assess occupational and community noise where relevant.'),
  PlantBookPoint('Wind', 'Follow manufacturer/project wind restrictions for machine and attachment operations.'),
  PlantBookPoint('Poor visibility', 'Stop or reduce operations when visibility is insufficient for safe control.')
]),
      PlantBookSection('24 — Attachments / Accessories', [
  PlantBookPoint('Compatibility', 'Use only manufacturer-approved or engineered-compatible attachments.'),
  PlantBookPoint('Locking', 'Verify positive locking before operation.'),
  PlantBookPoint('Rating', 'Attachment capacity and machine capacity must both be respected.'),
  PlantBookPoint('Hydraulics', 'Check hoses, couplings, pressure and contamination controls.'),
  PlantBookPoint('Changeover', 'Use an approved attachment-change procedure and rebrief operators when risk changes.')
]),
      PlantBookSection('25 — Maintenance Isolation / Stored Energy', [
  PlantBookPoint('Isolation', 'Isolate electrical, hydraulic, pneumatic, mechanical and other energy sources before intrusive maintenance.'),
  PlantBookPoint('Lockout', "Apply the site's lockout/tagout process where hazardous energy could be released."),
  PlantBookPoint('Raised equipment', 'Never rely on hydraulics alone to support raised components; use approved mechanical supports.'),
  PlantBookPoint('Pressure', 'Relieve stored hydraulic/pneumatic pressure before disconnecting lines.'),
  PlantBookPoint('Verification', 'Test for zero energy/zero movement before entering the danger zone.')
]),
      PlantBookSection('26 — Fuel / Battery / Fire', [
  PlantBookPoint('Fuel', 'Control ignition sources, spills, refuelling areas and fuel storage.'),
  PlantBookPoint('Battery', 'Use suitable charging arrangements, ventilation and electrical controls.'),
  PlantBookPoint('Fire protection', 'Provide appropriate fire equipment and maintain access to it.'),
  PlantBookPoint('Hot surfaces', 'Control contact and ignition hazards from engines, exhausts and other hot components.'),
  PlantBookPoint('Leak response', 'Stop use and control leaks rather than continuing with a known fire/environmental hazard.')
]),
      PlantBookSection('27 — Emergency / Breakdown', [
  PlantBookPoint('Breakdown', 'Move to a safe location where possible, secure the machine and establish an exclusion zone.'),
  PlantBookPoint('Fire', 'Stop, isolate if safe, raise alarm and follow the site fire response procedure.'),
  PlantBookPoint('Rollover', 'Remain restrained as appropriate and follow machine/site emergency guidance; do not jump unless required by an immediate life-threatening condition.'),
  PlantBookPoint('Service strike', 'Treat suspected electrical/gas/service contact as an emergency and follow the established procedure.'),
  PlantBookPoint('Recovery', 'Use planned recovery equipment and competent personnel; never improvise a recovery that introduces additional risk.')
]),
      PlantBookSection('28 — Rescue / Recovery', [
  PlantBookPoint('Planning', 'Identify credible rescue/recovery scenarios before high-risk operations.'),
  PlantBookPoint('Recovery equipment', 'Use equipment rated and suitable for the machine and recovery method.'),
  PlantBookPoint('Exclusion', 'Keep non-essential people outside the recovery zone.'),
  PlantBookPoint('Competence', 'Only trained/competent personnel should conduct specialist recovery.'),
  PlantBookPoint('Post-recovery', 'Inspect the machine and ground before return to service.')
]),
      PlantBookSection('29 — Stop-Work Conditions', [
  PlantBookPoint('Critical defects', 'Stop for brake/steering failure, structural damage, failed restraint or failed safety-critical device.'),
  PlantBookPoint('Stability', 'Stop for unstable ground, uncontrolled edge failure, rollover risk or loss of machine stability.'),
  PlantBookPoint('People', 'Stop when pedestrians enter the machine danger zone and cannot be safely controlled.'),
  PlantBookPoint('Visibility', 'Stop when the operator cannot maintain safe visibility/communication.'),
  PlantBookPoint('Method failure', 'Stop when actual work conditions no longer match the approved RAMS/JSA.')
]),
      PlantBookSection('30 — Unsafe Practices', [
  PlantBookPoint('Bypassing', 'Never bypass interlocks, alarms, guards or safety devices.'),
  PlantBookPoint('Improvised use', 'Do not use equipment outside its intended purpose or rated capacity.'),
  PlantBookPoint('People carrying', 'Do not carry passengers unless the machine is specifically designed and authorised for passengers.'),
  PlantBookPoint('Maintenance under load', 'Never enter beneath unsupported raised equipment.'),
  PlantBookPoint('Distraction', 'Do not operate while using a phone or while otherwise distracted.')
]),
      PlantBookSection('31 — Supervisor / HSE Responsibilities', [
  PlantBookPoint('Before work', 'Verify competency, inspection status, RAMS/JSA, work-area controls and emergency arrangements.'),
  PlantBookPoint('Field verification', 'Physically inspect critical controls and observe the actual operating method.'),
  PlantBookPoint('Monitoring', 'Monitor changes in ground, traffic, weather, people and equipment condition.'),
  PlantBookPoint('Intervention', 'Stop unsafe work and restore critical controls before restart.'),
  PlantBookPoint('Records', 'Maintain inspection, briefing, observation, defect and corrective-action evidence.')
]),
      PlantBookSection('32 — Records / Documents', [
  PlantBookPoint('Equipment', 'Equipment register, identification, inspection and maintenance records.'),
  PlantBookPoint('People', 'Competency, authorisation, familiarisation and toolbox records.'),
  PlantBookPoint('Task', 'RAMS/JSA, permits, traffic plans, lifting plans or service permits as applicable.'),
  PlantBookPoint('Defects', 'Defect reports, isolation/tag-out and repair/release evidence.'),
  PlantBookPoint('Incident', 'Near miss, incident, observation and corrective-action records.')
]),
      PlantBookSection('33 — Toolbox Talk', [
  PlantBookPoint('Machine', 'Explain machine-specific hazards, capacity, attachment and safety devices.'),
  PlantBookPoint('Area', 'Explain route, ground, edges, services, traffic and pedestrian controls.'),
  PlantBookPoint('People', 'Confirm operator, banksman, supervisor and emergency contacts.'),
  PlantBookPoint('Signals', 'Agree one communication/signalling system.'),
  PlantBookPoint('Stop-work', 'State clear stop-work triggers and confirm every worker can raise a concern.')
]),
      PlantBookSection('34 — Field Checklist / Quick Reference', [
  PlantBookPoint('Documents', 'RAMS/JSA, permits and inspection status verified.'),
  PlantBookPoint('Machine', 'Pre-use inspection complete; no safety-critical defect.'),
  PlantBookPoint('People', 'Competent authorised operator and required banksman/spotter.'),
  PlantBookPoint('Area', 'Ground, route, segregation, services and weather checked.'),
  PlantBookPoint('Operation', 'Capacity, speed, visibility and attachment controls maintained.')
]),
      PlantBookSection('35 — Corrective Action', [
  PlantBookPoint('Immediate', 'Stop the unsafe activity and make the area safe.'),
  PlantBookPoint('Defect', 'Isolate/tag out defective equipment where required.'),
  PlantBookPoint('Root cause', 'Identify why the control failed rather than correcting only the symptom.'),
  PlantBookPoint('Close-out', 'Verify the corrective action physically before returning to normal work.'),
  PlantBookPoint('Learning', 'Share significant findings through toolbox talks and lessons learned.')
]),
      PlantBookSection('36 — UAE / Abu Dhabi / Dubai Applicability', [
  PlantBookPoint('Abu Dhabi', 'Apply the current ADPHC/ADOSH-SF requirements and Abu Dhabi project/client requirements.'),
  PlantBookPoint('UAE common', 'Also comply with applicable federal requirements and project contractual obligations.'),
  PlantBookPoint('Dubai', 'Dubai requirements are not automatically transferable to Abu Dhabi; maintain separate jurisdictional references.'),
  PlantBookPoint('Sector', 'Oil & gas, offshore, industrial and specialist projects may impose additional client/sector controls.'),
  PlantBookPoint('Hierarchy', 'Where requirements differ, identify the applicable legal, authority, client and manufacturer requirements and obtain competent clarification.')
]),
      PlantBookSection('37 — Cross-References', [
  PlantBookPoint('Plant', 'ADPHC CoP 36.0 — Plant and Equipment.'),
  PlantBookPoint('Traffic', 'CoP 33.0 Working On or Adjacent to a Road and CoP 44.0 Traffic Management and Logistics where applicable.'),
  PlantBookPoint('Services', 'CoP 39.0 Overhead and Underground Services.'),
  PlantBookPoint('Lifting', 'CoP 34.0 Safe Use of Lifting Equipment and Lifting Accessories where lifting is involved.'),
  PlantBookPoint('Other', 'Link to electrical, hot work, heat, vibration, noise, excavation, machine guarding and lockout modules according to task.')
]),
      PlantBookSection('38 — Official Reference / Regulatory Verification', [
  PlantBookPoint('Official registry', 'Use the Abu Dhabi Public Health Centre Code of Practices registry as the primary source for current CoP versions and effective dates.'),
  PlantBookPoint('Current baseline', 'CoP 36.0 Plant and Equipment is listed as Version 4.1, effective February 2026.'),
  PlantBookPoint('Verification rule', 'Before regulatory lock, verify the exact current PDF, applicability, definitions, mandatory requirements and numeric values.'),
  PlantBookPoint('Manufacturer source', 'The exact machine operator manual, load chart and safety instructions must be available and followed.'),
  PlantBookPoint('Field rule', 'This handbook supports field understanding; it does not replace the applicable law, CoP, engineering design, manufacturer instructions or approved project documents.')
]),
      PlantBookSection('39 — Trencher: Excavation and service protection', [
  PlantBookPoint('Service location', 'Underground service identification and verification is a critical precondition before trenching.'),
  PlantBookPoint('Permit', 'Use the applicable excavation/service permit and approved method.'),
  PlantBookPoint('Cutting system', 'Guard the chain, wheel or cutting mechanism and establish a physical exclusion zone.'),
  PlantBookPoint('Spoil', 'Prevent spoil and material from creating unsafe surcharge or falling into the trench.'),
  PlantBookPoint('Stability', 'Coordinate machine operation with the trench support/protection system.')
]),
      PlantBookSection('40 — Trencher: Operating controls', [
  PlantBookPoint('Route', 'Survey the trench alignment, access, crossings and service locations.'),
  PlantBookPoint('Depth', 'Use the approved design/method and stop when conditions differ from the planned excavation.'),
  PlantBookPoint('Banksman', 'Use competent signalling where visibility is restricted.'),
  PlantBookPoint('Attachment', 'Isolate cutting equipment before clearing blockages.'),
  PlantBookPoint('Public interface', 'Barricade and protect open trenching from workers, vehicles and public access.')
]),
      PlantBookSection('41 — Trencher: Emergency and maintenance', [
  PlantBookPoint('Blockage', 'Never clear a blocked cutting mechanism while it can move; isolate all relevant energy first.'),
  PlantBookPoint('Service strike', 'Stop immediately on suspected service contact and follow the service emergency procedure.'),
  PlantBookPoint('Collapse', 'Treat signs of ground movement as an immediate stop-work trigger.'),
  PlantBookPoint('Recovery', 'Use planned recovery methods for bogging or machine instability.'),
  PlantBookPoint('Inspection', 'Reinspect cutting components, guards and structural parts after abnormal loading.')
])
    ],
  ),
PlantBookTopic(
    code: '5AH',
    title: 'Mobile Compressor',
    regulatoryBasis: 'ADPHC CoP 36.0 Plant & Equipment V4.1; CoP 49.0 Compressed Gases and Air V4.1; applicable pressure-system, noise and manufacturer requirements.',
    fieldPurpose: 'Field reference for compressed-air generation, stored pressure, hoses, rotating machinery, noise and isolation.',
    sections: [
      PlantBookSection('01 — What / Purpose / Scope', [
  PlantBookPoint('Definition', 'Mobile Compressor is mobile/portable plant used for site operations. The exact machine configuration, capacity, attachment and manufacturer limitations determine its safe operating envelope.'),
  PlantBookPoint('Purpose', 'Use Mobile Compressor only for tasks for which the machine and attachment are designed, rated and authorised.'),
  PlantBookPoint('Scope', 'Covers planning, selection, mobilisation, inspection, operation, maintenance, traffic interaction, emergency response and field verification.'),
  PlantBookPoint('People at risk', 'Operators, banksmen, ground workers, mechanics, supervisors, visitors, drivers and members of the public where site boundaries interface with public areas.'),
  PlantBookPoint('Golden rule', 'Suitable equipment + competent operator + inspected machine + controlled work area + approved method + continuous monitoring.')
]),
      PlantBookSection('02 — Types / Configurations', [
  PlantBookPoint('Machine variants', 'Identify the exact model, operating mass, power source, attachment and configuration before applying any operating information.'),
  PlantBookPoint('Attachments', 'Attachment changes can change stability, capacity, visibility, hydraulic demand and hazard profile.'),
  PlantBookPoint('Manufacturer data', 'Use the machine identification plate, operator manual, load chart and attachment documentation for the exact configuration.'),
  PlantBookPoint('Site configuration', 'Record any approved project-specific modification or accessory; unauthorised modifications are not acceptable.'),
  PlantBookPoint('Selection', 'Select the smallest suitable machine that can safely perform the task without creating additional hazards.')
]),
      PlantBookSection('03 — Main Components', [
  PlantBookPoint('Structure', 'Inspect chassis/frame, guards, access systems, operator protection and structural connections.'),
  PlantBookPoint('Power system', 'Check engine/electric/hydraulic/pneumatic systems appropriate to the equipment.'),
  PlantBookPoint('Controls', 'Controls, indicators, alarms, emergency functions and safety interlocks must be understood and functional.'),
  PlantBookPoint('Working equipment', "Inspect the machine's working attachment, linkage, cutting/compacting/hauling components and securing systems."),
  PlantBookPoint('Safety systems', 'Seat restraint, ROPS/FOPS where fitted, cameras, alarms, lights, mirrors, interlocks and emergency devices must not be bypassed.')
]),
      PlantBookSection('04 — Applications / When Used', [
  PlantBookPoint('Approved use', "Use only within the machine's intended application and rated operating envelope."),
  PlantBookPoint('Task matching', 'Confirm material type, load, distance, terrain, gradient, clearance, cycle and productivity demands before selection.'),
  PlantBookPoint('Multi-purpose use', 'If the machine is being used for a different task, conduct a new risk assessment and verify attachment/task suitability.'),
  PlantBookPoint('Prohibited improvisation', 'Do not use buckets, blades, forks, bodies, hooks or other components for unapproved lifting, carrying people or other improvised purposes.'),
  PlantBookPoint('Change management', 'Reassess whenever the machine, attachment, route, material, sequence or surrounding activity changes.')
]),
      PlantBookSection('05 — Hazards: Identification', [
  PlantBookPoint('Mechanical', 'Identify crush, shear, pinch, entanglement, struck-by and unexpected-movement zones.'),
  PlantBookPoint('Stability', 'Identify rollover, tip-over, sliding, edge failure and ground bearing hazards.'),
  PlantBookPoint('Traffic', 'Identify collision, reversing, blind-spot and pedestrian interface hazards.'),
  PlantBookPoint('Energy', 'Identify hydraulic, pneumatic, electrical, thermal, stored mechanical and pressure energy.'),
  PlantBookPoint('Environment', 'Identify dust, noise, vibration, heat, poor visibility, rain, flooding and contamination hazards.')
]),
      PlantBookSection('06 — Why Hazards Occur', [
  PlantBookPoint('Human factors', 'Inadequate competency, fatigue, distraction, rushing, poor communication and failure to follow the approved method can defeat controls.'),
  PlantBookPoint('Equipment factors', 'Defects, poor maintenance, incorrect attachment, bypassed safety devices or unsuitable machine selection can create uncontrolled risk.'),
  PlantBookPoint('Work-area factors', 'Poor ground, congestion, inadequate segregation, poor lighting and uncontrolled access increase exposure.'),
  PlantBookPoint('Planning factors', 'Incomplete RAMS/JSA, missing service information, incorrect capacity assumptions or inadequate emergency planning create predictable failures.'),
  PlantBookPoint('Change factors', 'Changing weather, route, load, personnel or simultaneous operations can invalidate the original controls.')
]),
      PlantBookSection('07 — Risk Assessment / Hierarchy of Controls', [
  PlantBookPoint('Eliminate', 'Remove unnecessary plant movement, manual interface or hazardous step where practicable.'),
  PlantBookPoint('Substitute', 'Use a safer machine, attachment, route or process when reasonably practicable.'),
  PlantBookPoint('Engineering', 'Use barriers, interlocks, guarding, cameras, alarms, mechanical supports, remote controls and engineered ground/traffic controls.'),
  PlantBookPoint('Administrative', 'Use RAMS/JSA, permits, competence controls, exclusion zones, inspection systems, traffic plans and supervision.'),
  PlantBookPoint('PPE', 'Select task-specific PPE after higher-level controls; PPE must not substitute for segregation or engineering controls.')
]),
      PlantBookSection('08 — Detailed Preventive Controls', [
  PlantBookPoint('Pre-job briefing', 'Explain machine limits, route, load/material, exclusion zone, signals, emergency arrangements and stop-work triggers.'),
  PlantBookPoint('Exclusion', 'Physically separate people from moving plant and hazardous machine envelopes wherever practicable.'),
  PlantBookPoint('Visibility', 'Use suitable mirrors, cameras, lighting, spotters and controlled routes where direct visibility is limited.'),
  PlantBookPoint('Housekeeping', 'Keep travel and work surfaces clear, stable and free of obstructions.'),
  PlantBookPoint('Verification', 'Supervision must verify critical controls physically, not merely rely on paperwork.')
]),
      PlantBookSection('09 — Measurements / Limits / Clearances', [
  PlantBookPoint('Source rule', 'Do not use generic internet values as regulatory limits. Confirm exact values from the current manufacturer manual, ADPHC CoP, project specification or competent engineering assessment.'),
  PlantBookPoint('Capacity', 'Rated capacity, payload, load centre, reach, attachment rating and stability limits must be taken from the exact machine/configuration.'),
  PlantBookPoint('Clearance', 'Required clearance from overhead services, edges, traffic and structures must be established from the applicable current requirement and site assessment.'),
  PlantBookPoint('Slope', 'Use manufacturer-approved slope/gradient limits and site-specific ground assessment.'),
  PlantBookPoint('Speed', 'Use the lower of the site-approved speed and the machine/manufacturer safe operating limit.')
]),
      PlantBookSection('10 — Ground / Foundation / Work Area', [
  PlantBookPoint('Bearing', "Assess ground bearing capacity for the machine's imposed loads; consider soft spots, voids, trenches and buried structures."),
  PlantBookPoint('Drainage', 'Control water accumulation and saturated ground that can reduce stability and traction.'),
  PlantBookPoint('Edges', 'Do not approach unsupported edges, excavations or embankments without a competent assessment and defined setback.'),
  PlantBookPoint('Routes', 'Confirm route width, turning radius, gradients, overhead clearance and emergency access.'),
  PlantBookPoint('Weather', 'Reassess ground and visibility after heavy rain, flooding, high winds, dust or other significant weather change.')
]),
      PlantBookSection('11 — Operator Competency', [
  PlantBookPoint('Competence', 'Operator training must match the exact equipment type, task and attachment and comply with applicable site/authority requirements.'),
  PlantBookPoint('Familiarisation', 'Provide machine-specific familiarisation before first use or after a significant configuration change.'),
  PlantBookPoint('Authorisation', 'Only authorised personnel may operate equipment.'),
  PlantBookPoint('Signals', 'Banksman/signaller competence and a single agreed communication system are required where signalling is used.'),
  PlantBookPoint('Fitness', 'No operation while impaired by fatigue, alcohol, drugs, illness or distraction.')
]),
      PlantBookSection('12 — PPE', [
  PlantBookPoint('Head/eye/foot', 'Use site-required head protection, eye protection and safety footwear appropriate to the task.'),
  PlantBookPoint('High visibility', 'Use high-visibility clothing where required by the traffic management system.'),
  PlantBookPoint('Hearing', 'Use hearing protection where risk assessment identifies hazardous noise.'),
  PlantBookPoint('Respiratory', 'Use suitable respiratory protection only where engineering and exposure controls do not adequately control airborne contaminants.'),
  PlantBookPoint('Specialist PPE', 'Add task-specific gloves, face protection, fall protection or chemical/thermal PPE based on the hazard assessment.')
]),
      PlantBookSection('13 — RAMS / JSA / PTW', [
  PlantBookPoint('RAMS', 'Approved risk assessment and method statement must describe the actual equipment, task, route, hazards and critical controls.'),
  PlantBookPoint('JSA', 'Break the task into steps and identify hazards and controls for each step.'),
  PlantBookPoint('PTW', 'Obtain permits where the activity or site system requires them, including interfaces with services, hot work, excavation or restricted areas.'),
  PlantBookPoint('Briefing', 'Ensure affected workers understand the method before work starts.'),
  PlantBookPoint('Change', 'Stop and revise the risk assessment when the work materially changes.')
]),
      PlantBookSection('14 — Pre-Use Inspection', [
  PlantBookPoint('Walk-around', 'Check structure, tyres/tracks, wheels, leaks, hoses, guards, steps, handrails, mirrors, cameras, lights and alarms.'),
  PlantBookPoint('Controls', 'Test steering, brakes, parking brake, travel controls and working controls as applicable.'),
  PlantBookPoint('Safety devices', 'Check seat restraint, emergency stop, interlocks, alarms and other safety-critical devices.'),
  PlantBookPoint('Working equipment', 'Inspect attachment, pins, locking systems, cutting/compacting/hauling components and hydraulic connections.'),
  PlantBookPoint('Defects', 'Tag out equipment with safety-critical defects and prevent operation until authorised repair/release.')
]),
      PlantBookSection('15 — Inspection / Maintenance', [
  PlantBookPoint('Planned maintenance', "Follow the manufacturer's maintenance schedule and site preventive-maintenance system."),
  PlantBookPoint('Periodic examination', 'Complete statutory or project-required inspections/examinations by competent authorised personnel.'),
  PlantBookPoint('Records', 'Maintain inspection, maintenance, defect and release records.'),
  PlantBookPoint('Modification', 'Engineering approval is required for safety-significant modification; reassess the risk after modification.'),
  PlantBookPoint('Return to service', 'Verify repair completion and safety-device function before releasing equipment.')
]),
      PlantBookSection('16 — Safe Start-Up', [
  PlantBookPoint('Access', 'Use designated steps/handholds and maintain three-point contact where applicable.'),
  PlantBookPoint('Cab check', 'Confirm controls are neutral and surroundings are clear before starting/moving.'),
  PlantBookPoint('Restraint', 'Fasten the operator restraint before machine movement.'),
  PlantBookPoint('System check', 'Confirm instruments, alarms and required safety functions are normal.'),
  PlantBookPoint('Area clearance', 'Do not start or move until people in the machine envelope are clear.')
]),
      PlantBookSection('17 — Safe Operation', [
  PlantBookPoint('Control', 'Operate smoothly and maintain full control of the machine at all times.'),
  PlantBookPoint('Load/material', 'Keep loads/material within the rated operating envelope and stable.'),
  PlantBookPoint('Visibility', 'Stop when the intended path cannot be safely seen or positively controlled.'),
  PlantBookPoint('Speed', 'Adjust speed for terrain, load, visibility, traffic, pedestrians and weather.'),
  PlantBookPoint('No distraction', 'Do not use phones or engage in distracting activity while operating.')
]),
      PlantBookSection('18 — Loading / Unloading / Material Interface', [
  PlantBookPoint('Loading zone', 'Establish a controlled loading area with clear communication between machine operators and other personnel.'),
  PlantBookPoint('Load stability', 'Ensure material is stable and does not create an uncontrolled shift or fall.'),
  PlantBookPoint('Truck interface', 'Coordinate machine and vehicle positions and keep non-essential persons outside the interface.'),
  PlantBookPoint('Overloading', 'Never exceed machine, attachment, vehicle or route limitations.'),
  PlantBookPoint('Spillage', 'Control material spillage promptly to prevent collision, slip, dust and visibility hazards.')
]),
      PlantBookSection('19 — Reversing / Blind Spots', [
  PlantBookPoint('Avoid', 'Eliminate unnecessary reversing through route planning.'),
  PlantBookPoint('Visibility aids', 'Use cameras, mirrors, alarms and lighting as designed; these do not replace segregation.'),
  PlantBookPoint('Banksman', 'Use a competent banksman where required by risk assessment/site rules.'),
  PlantBookPoint('Signal loss', 'Stop immediately if the operator loses the agreed signal or visual confirmation.'),
  PlantBookPoint('Pedestrians', 'Never assume pedestrians can see or hear the machine.')
]),
      PlantBookSection('20 — Traffic / Pedestrian Segregation', [
  PlantBookPoint('Traffic plan', 'Integrate machine movement into the approved traffic management and logistics plan.'),
  PlantBookPoint('Barriers', 'Use physical barriers and protected walkways wherever practicable.'),
  PlantBookPoint('Crossings', 'Control pedestrian crossings with designated routes and clear sight lines.'),
  PlantBookPoint('Public interface', 'Use stronger controls where site work interfaces with public roads or third parties.'),
  PlantBookPoint('Coordination', 'Coordinate simultaneous plant movements through a nominated competent person when required.')
]),
      PlantBookSection('21 — Slopes / Edges / Stability', [
  PlantBookPoint('Stability envelope', 'Understand how load, machine orientation, attachment position and slope affect stability.'),
  PlantBookPoint('Slope travel', 'Follow manufacturer limits and approved direction of travel; avoid unsafe cross-slope manoeuvres.'),
  PlantBookPoint('Edges', 'Maintain the project-approved safe setback from unsupported edges.'),
  PlantBookPoint('Soft ground', 'Stop when ground conditions cannot safely support the machine.'),
  PlantBookPoint('Rollover', 'Never attempt to recover a tipping/unstable machine through sudden manoeuvres; follow the emergency/recovery plan.')
]),
      PlantBookSection('22 — Overhead / Underground Services', [
  PlantBookPoint('Locate', 'Identify and verify underground services before ground disturbance.'),
  PlantBookPoint('Overhead', 'Establish the required exclusion controls around overhead services using the current applicable requirement.'),
  PlantBookPoint('Permit', 'Use service permits/authorisations where required.'),
  PlantBookPoint('Spotter', 'Use a competent spotter where specified by the risk assessment or service control system.'),
  PlantBookPoint('Strike response', 'If a service is contacted or suspected, stop, isolate the area and follow the emergency/service-owner procedure.')
]),
      PlantBookSection('23 — Weather / Environment', [
  PlantBookPoint('Heat', 'Apply the applicable heat-stress controls, hydration, rest and monitoring requirements.'),
  PlantBookPoint('Dust', 'Control dust through suitable suppression, enclosure or process controls.'),
  PlantBookPoint('Noise', 'Assess occupational and community noise where relevant.'),
  PlantBookPoint('Wind', 'Follow manufacturer/project wind restrictions for machine and attachment operations.'),
  PlantBookPoint('Poor visibility', 'Stop or reduce operations when visibility is insufficient for safe control.')
]),
      PlantBookSection('24 — Attachments / Accessories', [
  PlantBookPoint('Compatibility', 'Use only manufacturer-approved or engineered-compatible attachments.'),
  PlantBookPoint('Locking', 'Verify positive locking before operation.'),
  PlantBookPoint('Rating', 'Attachment capacity and machine capacity must both be respected.'),
  PlantBookPoint('Hydraulics', 'Check hoses, couplings, pressure and contamination controls.'),
  PlantBookPoint('Changeover', 'Use an approved attachment-change procedure and rebrief operators when risk changes.')
]),
      PlantBookSection('25 — Maintenance Isolation / Stored Energy', [
  PlantBookPoint('Isolation', 'Isolate electrical, hydraulic, pneumatic, mechanical and other energy sources before intrusive maintenance.'),
  PlantBookPoint('Lockout', "Apply the site's lockout/tagout process where hazardous energy could be released."),
  PlantBookPoint('Raised equipment', 'Never rely on hydraulics alone to support raised components; use approved mechanical supports.'),
  PlantBookPoint('Pressure', 'Relieve stored hydraulic/pneumatic pressure before disconnecting lines.'),
  PlantBookPoint('Verification', 'Test for zero energy/zero movement before entering the danger zone.')
]),
      PlantBookSection('26 — Fuel / Battery / Fire', [
  PlantBookPoint('Fuel', 'Control ignition sources, spills, refuelling areas and fuel storage.'),
  PlantBookPoint('Battery', 'Use suitable charging arrangements, ventilation and electrical controls.'),
  PlantBookPoint('Fire protection', 'Provide appropriate fire equipment and maintain access to it.'),
  PlantBookPoint('Hot surfaces', 'Control contact and ignition hazards from engines, exhausts and other hot components.'),
  PlantBookPoint('Leak response', 'Stop use and control leaks rather than continuing with a known fire/environmental hazard.')
]),
      PlantBookSection('27 — Emergency / Breakdown', [
  PlantBookPoint('Breakdown', 'Move to a safe location where possible, secure the machine and establish an exclusion zone.'),
  PlantBookPoint('Fire', 'Stop, isolate if safe, raise alarm and follow the site fire response procedure.'),
  PlantBookPoint('Rollover', 'Remain restrained as appropriate and follow machine/site emergency guidance; do not jump unless required by an immediate life-threatening condition.'),
  PlantBookPoint('Service strike', 'Treat suspected electrical/gas/service contact as an emergency and follow the established procedure.'),
  PlantBookPoint('Recovery', 'Use planned recovery equipment and competent personnel; never improvise a recovery that introduces additional risk.')
]),
      PlantBookSection('28 — Rescue / Recovery', [
  PlantBookPoint('Planning', 'Identify credible rescue/recovery scenarios before high-risk operations.'),
  PlantBookPoint('Recovery equipment', 'Use equipment rated and suitable for the machine and recovery method.'),
  PlantBookPoint('Exclusion', 'Keep non-essential people outside the recovery zone.'),
  PlantBookPoint('Competence', 'Only trained/competent personnel should conduct specialist recovery.'),
  PlantBookPoint('Post-recovery', 'Inspect the machine and ground before return to service.')
]),
      PlantBookSection('29 — Stop-Work Conditions', [
  PlantBookPoint('Critical defects', 'Stop for brake/steering failure, structural damage, failed restraint or failed safety-critical device.'),
  PlantBookPoint('Stability', 'Stop for unstable ground, uncontrolled edge failure, rollover risk or loss of machine stability.'),
  PlantBookPoint('People', 'Stop when pedestrians enter the machine danger zone and cannot be safely controlled.'),
  PlantBookPoint('Visibility', 'Stop when the operator cannot maintain safe visibility/communication.'),
  PlantBookPoint('Method failure', 'Stop when actual work conditions no longer match the approved RAMS/JSA.')
]),
      PlantBookSection('30 — Unsafe Practices', [
  PlantBookPoint('Bypassing', 'Never bypass interlocks, alarms, guards or safety devices.'),
  PlantBookPoint('Improvised use', 'Do not use equipment outside its intended purpose or rated capacity.'),
  PlantBookPoint('People carrying', 'Do not carry passengers unless the machine is specifically designed and authorised for passengers.'),
  PlantBookPoint('Maintenance under load', 'Never enter beneath unsupported raised equipment.'),
  PlantBookPoint('Distraction', 'Do not operate while using a phone or while otherwise distracted.')
]),
      PlantBookSection('31 — Supervisor / HSE Responsibilities', [
  PlantBookPoint('Before work', 'Verify competency, inspection status, RAMS/JSA, work-area controls and emergency arrangements.'),
  PlantBookPoint('Field verification', 'Physically inspect critical controls and observe the actual operating method.'),
  PlantBookPoint('Monitoring', 'Monitor changes in ground, traffic, weather, people and equipment condition.'),
  PlantBookPoint('Intervention', 'Stop unsafe work and restore critical controls before restart.'),
  PlantBookPoint('Records', 'Maintain inspection, briefing, observation, defect and corrective-action evidence.')
]),
      PlantBookSection('32 — Records / Documents', [
  PlantBookPoint('Equipment', 'Equipment register, identification, inspection and maintenance records.'),
  PlantBookPoint('People', 'Competency, authorisation, familiarisation and toolbox records.'),
  PlantBookPoint('Task', 'RAMS/JSA, permits, traffic plans, lifting plans or service permits as applicable.'),
  PlantBookPoint('Defects', 'Defect reports, isolation/tag-out and repair/release evidence.'),
  PlantBookPoint('Incident', 'Near miss, incident, observation and corrective-action records.')
]),
      PlantBookSection('33 — Toolbox Talk', [
  PlantBookPoint('Machine', 'Explain machine-specific hazards, capacity, attachment and safety devices.'),
  PlantBookPoint('Area', 'Explain route, ground, edges, services, traffic and pedestrian controls.'),
  PlantBookPoint('People', 'Confirm operator, banksman, supervisor and emergency contacts.'),
  PlantBookPoint('Signals', 'Agree one communication/signalling system.'),
  PlantBookPoint('Stop-work', 'State clear stop-work triggers and confirm every worker can raise a concern.')
]),
      PlantBookSection('34 — Field Checklist / Quick Reference', [
  PlantBookPoint('Documents', 'RAMS/JSA, permits and inspection status verified.'),
  PlantBookPoint('Machine', 'Pre-use inspection complete; no safety-critical defect.'),
  PlantBookPoint('People', 'Competent authorised operator and required banksman/spotter.'),
  PlantBookPoint('Area', 'Ground, route, segregation, services and weather checked.'),
  PlantBookPoint('Operation', 'Capacity, speed, visibility and attachment controls maintained.')
]),
      PlantBookSection('35 — Corrective Action', [
  PlantBookPoint('Immediate', 'Stop the unsafe activity and make the area safe.'),
  PlantBookPoint('Defect', 'Isolate/tag out defective equipment where required.'),
  PlantBookPoint('Root cause', 'Identify why the control failed rather than correcting only the symptom.'),
  PlantBookPoint('Close-out', 'Verify the corrective action physically before returning to normal work.'),
  PlantBookPoint('Learning', 'Share significant findings through toolbox talks and lessons learned.')
]),
      PlantBookSection('36 — UAE / Abu Dhabi / Dubai Applicability', [
  PlantBookPoint('Abu Dhabi', 'Apply the current ADPHC/ADOSH-SF requirements and Abu Dhabi project/client requirements.'),
  PlantBookPoint('UAE common', 'Also comply with applicable federal requirements and project contractual obligations.'),
  PlantBookPoint('Dubai', 'Dubai requirements are not automatically transferable to Abu Dhabi; maintain separate jurisdictional references.'),
  PlantBookPoint('Sector', 'Oil & gas, offshore, industrial and specialist projects may impose additional client/sector controls.'),
  PlantBookPoint('Hierarchy', 'Where requirements differ, identify the applicable legal, authority, client and manufacturer requirements and obtain competent clarification.')
]),
      PlantBookSection('37 — Cross-References', [
  PlantBookPoint('Plant', 'ADPHC CoP 36.0 — Plant and Equipment.'),
  PlantBookPoint('Traffic', 'CoP 33.0 Working On or Adjacent to a Road and CoP 44.0 Traffic Management and Logistics where applicable.'),
  PlantBookPoint('Services', 'CoP 39.0 Overhead and Underground Services.'),
  PlantBookPoint('Lifting', 'CoP 34.0 Safe Use of Lifting Equipment and Lifting Accessories where lifting is involved.'),
  PlantBookPoint('Other', 'Link to electrical, hot work, heat, vibration, noise, excavation, machine guarding and lockout modules according to task.')
]),
      PlantBookSection('38 — Official Reference / Regulatory Verification', [
  PlantBookPoint('Official registry', 'Use the Abu Dhabi Public Health Centre Code of Practices registry as the primary source for current CoP versions and effective dates.'),
  PlantBookPoint('Current baseline', 'CoP 36.0 Plant and Equipment is listed as Version 4.1, effective February 2026.'),
  PlantBookPoint('Verification rule', 'Before regulatory lock, verify the exact current PDF, applicability, definitions, mandatory requirements and numeric values.'),
  PlantBookPoint('Manufacturer source', 'The exact machine operator manual, load chart and safety instructions must be available and followed.'),
  PlantBookPoint('Field rule', 'This handbook supports field understanding; it does not replace the applicable law, CoP, engineering design, manufacturer instructions or approved project documents.')
]),
      PlantBookSection('39 — Mobile Compressor: Pressure system hazards', [
  PlantBookPoint('Receiver', 'Treat the air receiver and connected pressure system as stored-energy equipment.'),
  PlantBookPoint('Relief device', 'Safety/relief devices must be maintained and never defeated.'),
  PlantBookPoint('Hoses', 'Inspect hoses, couplings, whip-check/restraint arrangements and fittings.'),
  PlantBookPoint('Pressure', 'Never disconnect pressurised lines unless the approved procedure specifically controls the hazard.'),
  PlantBookPoint('Inspection', 'Follow applicable statutory/project inspection and pressure-system requirements.')
]),
      PlantBookSection('40 — Mobile Compressor: Air / mechanical controls', [
  PlantBookPoint('Air jet', 'Never direct compressed air at a person or use it for unsafe cleaning of clothing/body.'),
  PlantBookPoint('Guarding', 'Protect belts, fans, couplings and other rotating parts.'),
  PlantBookPoint('Noise', 'Assess compressor noise and provide exposure controls.'),
  PlantBookPoint('Hot surfaces', 'Control exhaust and engine hot-surface hazards.'),
  PlantBookPoint('Ventilation', 'Prevent exhaust accumulation in enclosed or poorly ventilated areas.')
]),
      PlantBookSection('41 — Mobile Compressor: Compressed-air work', [
  PlantBookPoint('Tool connection', 'Secure connections before pressurising.'),
  PlantBookPoint('Hose routing', 'Protect hoses from vehicles, sharp edges, heat and uncontrolled movement.'),
  PlantBookPoint('Blowdown', 'Depressurise safely before maintenance or disconnection.'),
  PlantBookPoint('Energy isolation', 'Apply lockout/isolation where maintenance can expose workers to stored energy.'),
  PlantBookPoint('Cross-reference', 'Apply ADPHC CoP 49.0 requirements and applicable manufacturer/pressure-system controls.')
])
    ],
  ),
PlantBookTopic(
    code: '5AI',
    title: 'Generator / Portable Generator',
    regulatoryBasis: 'ADPHC CoP 36.0 Plant & Equipment V4.1; CoP 15.0 Electrical Safety V4.0; applicable fire, fuel, noise, temporary-power and manufacturer requirements.',
    fieldPurpose: 'Field reference for temporary electrical power, grounding, distribution, fuel/fire, exhaust/CO, noise and isolation.',
    sections: [
      PlantBookSection('01 — What / Purpose / Scope', [
  PlantBookPoint('Definition', 'Generator / Portable Generator is mobile/portable plant used for site operations. The exact machine configuration, capacity, attachment and manufacturer limitations determine its safe operating envelope.'),
  PlantBookPoint('Purpose', 'Use Generator / Portable Generator only for tasks for which the machine and attachment are designed, rated and authorised.'),
  PlantBookPoint('Scope', 'Covers planning, selection, mobilisation, inspection, operation, maintenance, traffic interaction, emergency response and field verification.'),
  PlantBookPoint('People at risk', 'Operators, banksmen, ground workers, mechanics, supervisors, visitors, drivers and members of the public where site boundaries interface with public areas.'),
  PlantBookPoint('Golden rule', 'Suitable equipment + competent operator + inspected machine + controlled work area + approved method + continuous monitoring.')
]),
      PlantBookSection('02 — Types / Configurations', [
  PlantBookPoint('Machine variants', 'Identify the exact model, operating mass, power source, attachment and configuration before applying any operating information.'),
  PlantBookPoint('Attachments', 'Attachment changes can change stability, capacity, visibility, hydraulic demand and hazard profile.'),
  PlantBookPoint('Manufacturer data', 'Use the machine identification plate, operator manual, load chart and attachment documentation for the exact configuration.'),
  PlantBookPoint('Site configuration', 'Record any approved project-specific modification or accessory; unauthorised modifications are not acceptable.'),
  PlantBookPoint('Selection', 'Select the smallest suitable machine that can safely perform the task without creating additional hazards.')
]),
      PlantBookSection('03 — Main Components', [
  PlantBookPoint('Structure', 'Inspect chassis/frame, guards, access systems, operator protection and structural connections.'),
  PlantBookPoint('Power system', 'Check engine/electric/hydraulic/pneumatic systems appropriate to the equipment.'),
  PlantBookPoint('Controls', 'Controls, indicators, alarms, emergency functions and safety interlocks must be understood and functional.'),
  PlantBookPoint('Working equipment', "Inspect the machine's working attachment, linkage, cutting/compacting/hauling components and securing systems."),
  PlantBookPoint('Safety systems', 'Seat restraint, ROPS/FOPS where fitted, cameras, alarms, lights, mirrors, interlocks and emergency devices must not be bypassed.')
]),
      PlantBookSection('04 — Applications / When Used', [
  PlantBookPoint('Approved use', "Use only within the machine's intended application and rated operating envelope."),
  PlantBookPoint('Task matching', 'Confirm material type, load, distance, terrain, gradient, clearance, cycle and productivity demands before selection.'),
  PlantBookPoint('Multi-purpose use', 'If the machine is being used for a different task, conduct a new risk assessment and verify attachment/task suitability.'),
  PlantBookPoint('Prohibited improvisation', 'Do not use buckets, blades, forks, bodies, hooks or other components for unapproved lifting, carrying people or other improvised purposes.'),
  PlantBookPoint('Change management', 'Reassess whenever the machine, attachment, route, material, sequence or surrounding activity changes.')
]),
      PlantBookSection('05 — Hazards: Identification', [
  PlantBookPoint('Mechanical', 'Identify crush, shear, pinch, entanglement, struck-by and unexpected-movement zones.'),
  PlantBookPoint('Stability', 'Identify rollover, tip-over, sliding, edge failure and ground bearing hazards.'),
  PlantBookPoint('Traffic', 'Identify collision, reversing, blind-spot and pedestrian interface hazards.'),
  PlantBookPoint('Energy', 'Identify hydraulic, pneumatic, electrical, thermal, stored mechanical and pressure energy.'),
  PlantBookPoint('Environment', 'Identify dust, noise, vibration, heat, poor visibility, rain, flooding and contamination hazards.')
]),
      PlantBookSection('06 — Why Hazards Occur', [
  PlantBookPoint('Human factors', 'Inadequate competency, fatigue, distraction, rushing, poor communication and failure to follow the approved method can defeat controls.'),
  PlantBookPoint('Equipment factors', 'Defects, poor maintenance, incorrect attachment, bypassed safety devices or unsuitable machine selection can create uncontrolled risk.'),
  PlantBookPoint('Work-area factors', 'Poor ground, congestion, inadequate segregation, poor lighting and uncontrolled access increase exposure.'),
  PlantBookPoint('Planning factors', 'Incomplete RAMS/JSA, missing service information, incorrect capacity assumptions or inadequate emergency planning create predictable failures.'),
  PlantBookPoint('Change factors', 'Changing weather, route, load, personnel or simultaneous operations can invalidate the original controls.')
]),
      PlantBookSection('07 — Risk Assessment / Hierarchy of Controls', [
  PlantBookPoint('Eliminate', 'Remove unnecessary plant movement, manual interface or hazardous step where practicable.'),
  PlantBookPoint('Substitute', 'Use a safer machine, attachment, route or process when reasonably practicable.'),
  PlantBookPoint('Engineering', 'Use barriers, interlocks, guarding, cameras, alarms, mechanical supports, remote controls and engineered ground/traffic controls.'),
  PlantBookPoint('Administrative', 'Use RAMS/JSA, permits, competence controls, exclusion zones, inspection systems, traffic plans and supervision.'),
  PlantBookPoint('PPE', 'Select task-specific PPE after higher-level controls; PPE must not substitute for segregation or engineering controls.')
]),
      PlantBookSection('08 — Detailed Preventive Controls', [
  PlantBookPoint('Pre-job briefing', 'Explain machine limits, route, load/material, exclusion zone, signals, emergency arrangements and stop-work triggers.'),
  PlantBookPoint('Exclusion', 'Physically separate people from moving plant and hazardous machine envelopes wherever practicable.'),
  PlantBookPoint('Visibility', 'Use suitable mirrors, cameras, lighting, spotters and controlled routes where direct visibility is limited.'),
  PlantBookPoint('Housekeeping', 'Keep travel and work surfaces clear, stable and free of obstructions.'),
  PlantBookPoint('Verification', 'Supervision must verify critical controls physically, not merely rely on paperwork.')
]),
      PlantBookSection('09 — Measurements / Limits / Clearances', [
  PlantBookPoint('Source rule', 'Do not use generic internet values as regulatory limits. Confirm exact values from the current manufacturer manual, ADPHC CoP, project specification or competent engineering assessment.'),
  PlantBookPoint('Capacity', 'Rated capacity, payload, load centre, reach, attachment rating and stability limits must be taken from the exact machine/configuration.'),
  PlantBookPoint('Clearance', 'Required clearance from overhead services, edges, traffic and structures must be established from the applicable current requirement and site assessment.'),
  PlantBookPoint('Slope', 'Use manufacturer-approved slope/gradient limits and site-specific ground assessment.'),
  PlantBookPoint('Speed', 'Use the lower of the site-approved speed and the machine/manufacturer safe operating limit.')
]),
      PlantBookSection('10 — Ground / Foundation / Work Area', [
  PlantBookPoint('Bearing', "Assess ground bearing capacity for the machine's imposed loads; consider soft spots, voids, trenches and buried structures."),
  PlantBookPoint('Drainage', 'Control water accumulation and saturated ground that can reduce stability and traction.'),
  PlantBookPoint('Edges', 'Do not approach unsupported edges, excavations or embankments without a competent assessment and defined setback.'),
  PlantBookPoint('Routes', 'Confirm route width, turning radius, gradients, overhead clearance and emergency access.'),
  PlantBookPoint('Weather', 'Reassess ground and visibility after heavy rain, flooding, high winds, dust or other significant weather change.')
]),
      PlantBookSection('11 — Operator Competency', [
  PlantBookPoint('Competence', 'Operator training must match the exact equipment type, task and attachment and comply with applicable site/authority requirements.'),
  PlantBookPoint('Familiarisation', 'Provide machine-specific familiarisation before first use or after a significant configuration change.'),
  PlantBookPoint('Authorisation', 'Only authorised personnel may operate equipment.'),
  PlantBookPoint('Signals', 'Banksman/signaller competence and a single agreed communication system are required where signalling is used.'),
  PlantBookPoint('Fitness', 'No operation while impaired by fatigue, alcohol, drugs, illness or distraction.')
]),
      PlantBookSection('12 — PPE', [
  PlantBookPoint('Head/eye/foot', 'Use site-required head protection, eye protection and safety footwear appropriate to the task.'),
  PlantBookPoint('High visibility', 'Use high-visibility clothing where required by the traffic management system.'),
  PlantBookPoint('Hearing', 'Use hearing protection where risk assessment identifies hazardous noise.'),
  PlantBookPoint('Respiratory', 'Use suitable respiratory protection only where engineering and exposure controls do not adequately control airborne contaminants.'),
  PlantBookPoint('Specialist PPE', 'Add task-specific gloves, face protection, fall protection or chemical/thermal PPE based on the hazard assessment.')
]),
      PlantBookSection('13 — RAMS / JSA / PTW', [
  PlantBookPoint('RAMS', 'Approved risk assessment and method statement must describe the actual equipment, task, route, hazards and critical controls.'),
  PlantBookPoint('JSA', 'Break the task into steps and identify hazards and controls for each step.'),
  PlantBookPoint('PTW', 'Obtain permits where the activity or site system requires them, including interfaces with services, hot work, excavation or restricted areas.'),
  PlantBookPoint('Briefing', 'Ensure affected workers understand the method before work starts.'),
  PlantBookPoint('Change', 'Stop and revise the risk assessment when the work materially changes.')
]),
      PlantBookSection('14 — Pre-Use Inspection', [
  PlantBookPoint('Walk-around', 'Check structure, tyres/tracks, wheels, leaks, hoses, guards, steps, handrails, mirrors, cameras, lights and alarms.'),
  PlantBookPoint('Controls', 'Test steering, brakes, parking brake, travel controls and working controls as applicable.'),
  PlantBookPoint('Safety devices', 'Check seat restraint, emergency stop, interlocks, alarms and other safety-critical devices.'),
  PlantBookPoint('Working equipment', 'Inspect attachment, pins, locking systems, cutting/compacting/hauling components and hydraulic connections.'),
  PlantBookPoint('Defects', 'Tag out equipment with safety-critical defects and prevent operation until authorised repair/release.')
]),
      PlantBookSection('15 — Inspection / Maintenance', [
  PlantBookPoint('Planned maintenance', "Follow the manufacturer's maintenance schedule and site preventive-maintenance system."),
  PlantBookPoint('Periodic examination', 'Complete statutory or project-required inspections/examinations by competent authorised personnel.'),
  PlantBookPoint('Records', 'Maintain inspection, maintenance, defect and release records.'),
  PlantBookPoint('Modification', 'Engineering approval is required for safety-significant modification; reassess the risk after modification.'),
  PlantBookPoint('Return to service', 'Verify repair completion and safety-device function before releasing equipment.')
]),
      PlantBookSection('16 — Safe Start-Up', [
  PlantBookPoint('Access', 'Use designated steps/handholds and maintain three-point contact where applicable.'),
  PlantBookPoint('Cab check', 'Confirm controls are neutral and surroundings are clear before starting/moving.'),
  PlantBookPoint('Restraint', 'Fasten the operator restraint before machine movement.'),
  PlantBookPoint('System check', 'Confirm instruments, alarms and required safety functions are normal.'),
  PlantBookPoint('Area clearance', 'Do not start or move until people in the machine envelope are clear.')
]),
      PlantBookSection('17 — Safe Operation', [
  PlantBookPoint('Control', 'Operate smoothly and maintain full control of the machine at all times.'),
  PlantBookPoint('Load/material', 'Keep loads/material within the rated operating envelope and stable.'),
  PlantBookPoint('Visibility', 'Stop when the intended path cannot be safely seen or positively controlled.'),
  PlantBookPoint('Speed', 'Adjust speed for terrain, load, visibility, traffic, pedestrians and weather.'),
  PlantBookPoint('No distraction', 'Do not use phones or engage in distracting activity while operating.')
]),
      PlantBookSection('18 — Loading / Unloading / Material Interface', [
  PlantBookPoint('Loading zone', 'Establish a controlled loading area with clear communication between machine operators and other personnel.'),
  PlantBookPoint('Load stability', 'Ensure material is stable and does not create an uncontrolled shift or fall.'),
  PlantBookPoint('Truck interface', 'Coordinate machine and vehicle positions and keep non-essential persons outside the interface.'),
  PlantBookPoint('Overloading', 'Never exceed machine, attachment, vehicle or route limitations.'),
  PlantBookPoint('Spillage', 'Control material spillage promptly to prevent collision, slip, dust and visibility hazards.')
]),
      PlantBookSection('19 — Reversing / Blind Spots', [
  PlantBookPoint('Avoid', 'Eliminate unnecessary reversing through route planning.'),
  PlantBookPoint('Visibility aids', 'Use cameras, mirrors, alarms and lighting as designed; these do not replace segregation.'),
  PlantBookPoint('Banksman', 'Use a competent banksman where required by risk assessment/site rules.'),
  PlantBookPoint('Signal loss', 'Stop immediately if the operator loses the agreed signal or visual confirmation.'),
  PlantBookPoint('Pedestrians', 'Never assume pedestrians can see or hear the machine.')
]),
      PlantBookSection('20 — Traffic / Pedestrian Segregation', [
  PlantBookPoint('Traffic plan', 'Integrate machine movement into the approved traffic management and logistics plan.'),
  PlantBookPoint('Barriers', 'Use physical barriers and protected walkways wherever practicable.'),
  PlantBookPoint('Crossings', 'Control pedestrian crossings with designated routes and clear sight lines.'),
  PlantBookPoint('Public interface', 'Use stronger controls where site work interfaces with public roads or third parties.'),
  PlantBookPoint('Coordination', 'Coordinate simultaneous plant movements through a nominated competent person when required.')
]),
      PlantBookSection('21 — Slopes / Edges / Stability', [
  PlantBookPoint('Stability envelope', 'Understand how load, machine orientation, attachment position and slope affect stability.'),
  PlantBookPoint('Slope travel', 'Follow manufacturer limits and approved direction of travel; avoid unsafe cross-slope manoeuvres.'),
  PlantBookPoint('Edges', 'Maintain the project-approved safe setback from unsupported edges.'),
  PlantBookPoint('Soft ground', 'Stop when ground conditions cannot safely support the machine.'),
  PlantBookPoint('Rollover', 'Never attempt to recover a tipping/unstable machine through sudden manoeuvres; follow the emergency/recovery plan.')
]),
      PlantBookSection('22 — Overhead / Underground Services', [
  PlantBookPoint('Locate', 'Identify and verify underground services before ground disturbance.'),
  PlantBookPoint('Overhead', 'Establish the required exclusion controls around overhead services using the current applicable requirement.'),
  PlantBookPoint('Permit', 'Use service permits/authorisations where required.'),
  PlantBookPoint('Spotter', 'Use a competent spotter where specified by the risk assessment or service control system.'),
  PlantBookPoint('Strike response', 'If a service is contacted or suspected, stop, isolate the area and follow the emergency/service-owner procedure.')
]),
      PlantBookSection('23 — Weather / Environment', [
  PlantBookPoint('Heat', 'Apply the applicable heat-stress controls, hydration, rest and monitoring requirements.'),
  PlantBookPoint('Dust', 'Control dust through suitable suppression, enclosure or process controls.'),
  PlantBookPoint('Noise', 'Assess occupational and community noise where relevant.'),
  PlantBookPoint('Wind', 'Follow manufacturer/project wind restrictions for machine and attachment operations.'),
  PlantBookPoint('Poor visibility', 'Stop or reduce operations when visibility is insufficient for safe control.')
]),
      PlantBookSection('24 — Attachments / Accessories', [
  PlantBookPoint('Compatibility', 'Use only manufacturer-approved or engineered-compatible attachments.'),
  PlantBookPoint('Locking', 'Verify positive locking before operation.'),
  PlantBookPoint('Rating', 'Attachment capacity and machine capacity must both be respected.'),
  PlantBookPoint('Hydraulics', 'Check hoses, couplings, pressure and contamination controls.'),
  PlantBookPoint('Changeover', 'Use an approved attachment-change procedure and rebrief operators when risk changes.')
]),
      PlantBookSection('25 — Maintenance Isolation / Stored Energy', [
  PlantBookPoint('Isolation', 'Isolate electrical, hydraulic, pneumatic, mechanical and other energy sources before intrusive maintenance.'),
  PlantBookPoint('Lockout', "Apply the site's lockout/tagout process where hazardous energy could be released."),
  PlantBookPoint('Raised equipment', 'Never rely on hydraulics alone to support raised components; use approved mechanical supports.'),
  PlantBookPoint('Pressure', 'Relieve stored hydraulic/pneumatic pressure before disconnecting lines.'),
  PlantBookPoint('Verification', 'Test for zero energy/zero movement before entering the danger zone.')
]),
      PlantBookSection('26 — Fuel / Battery / Fire', [
  PlantBookPoint('Fuel', 'Control ignition sources, spills, refuelling areas and fuel storage.'),
  PlantBookPoint('Battery', 'Use suitable charging arrangements, ventilation and electrical controls.'),
  PlantBookPoint('Fire protection', 'Provide appropriate fire equipment and maintain access to it.'),
  PlantBookPoint('Hot surfaces', 'Control contact and ignition hazards from engines, exhausts and other hot components.'),
  PlantBookPoint('Leak response', 'Stop use and control leaks rather than continuing with a known fire/environmental hazard.')
]),
      PlantBookSection('27 — Emergency / Breakdown', [
  PlantBookPoint('Breakdown', 'Move to a safe location where possible, secure the machine and establish an exclusion zone.'),
  PlantBookPoint('Fire', 'Stop, isolate if safe, raise alarm and follow the site fire response procedure.'),
  PlantBookPoint('Rollover', 'Remain restrained as appropriate and follow machine/site emergency guidance; do not jump unless required by an immediate life-threatening condition.'),
  PlantBookPoint('Service strike', 'Treat suspected electrical/gas/service contact as an emergency and follow the established procedure.'),
  PlantBookPoint('Recovery', 'Use planned recovery equipment and competent personnel; never improvise a recovery that introduces additional risk.')
]),
      PlantBookSection('28 — Rescue / Recovery', [
  PlantBookPoint('Planning', 'Identify credible rescue/recovery scenarios before high-risk operations.'),
  PlantBookPoint('Recovery equipment', 'Use equipment rated and suitable for the machine and recovery method.'),
  PlantBookPoint('Exclusion', 'Keep non-essential people outside the recovery zone.'),
  PlantBookPoint('Competence', 'Only trained/competent personnel should conduct specialist recovery.'),
  PlantBookPoint('Post-recovery', 'Inspect the machine and ground before return to service.')
]),
      PlantBookSection('29 — Stop-Work Conditions', [
  PlantBookPoint('Critical defects', 'Stop for brake/steering failure, structural damage, failed restraint or failed safety-critical device.'),
  PlantBookPoint('Stability', 'Stop for unstable ground, uncontrolled edge failure, rollover risk or loss of machine stability.'),
  PlantBookPoint('People', 'Stop when pedestrians enter the machine danger zone and cannot be safely controlled.'),
  PlantBookPoint('Visibility', 'Stop when the operator cannot maintain safe visibility/communication.'),
  PlantBookPoint('Method failure', 'Stop when actual work conditions no longer match the approved RAMS/JSA.')
]),
      PlantBookSection('30 — Unsafe Practices', [
  PlantBookPoint('Bypassing', 'Never bypass interlocks, alarms, guards or safety devices.'),
  PlantBookPoint('Improvised use', 'Do not use equipment outside its intended purpose or rated capacity.'),
  PlantBookPoint('People carrying', 'Do not carry passengers unless the machine is specifically designed and authorised for passengers.'),
  PlantBookPoint('Maintenance under load', 'Never enter beneath unsupported raised equipment.'),
  PlantBookPoint('Distraction', 'Do not operate while using a phone or while otherwise distracted.')
]),
      PlantBookSection('31 — Supervisor / HSE Responsibilities', [
  PlantBookPoint('Before work', 'Verify competency, inspection status, RAMS/JSA, work-area controls and emergency arrangements.'),
  PlantBookPoint('Field verification', 'Physically inspect critical controls and observe the actual operating method.'),
  PlantBookPoint('Monitoring', 'Monitor changes in ground, traffic, weather, people and equipment condition.'),
  PlantBookPoint('Intervention', 'Stop unsafe work and restore critical controls before restart.'),
  PlantBookPoint('Records', 'Maintain inspection, briefing, observation, defect and corrective-action evidence.')
]),
      PlantBookSection('32 — Records / Documents', [
  PlantBookPoint('Equipment', 'Equipment register, identification, inspection and maintenance records.'),
  PlantBookPoint('People', 'Competency, authorisation, familiarisation and toolbox records.'),
  PlantBookPoint('Task', 'RAMS/JSA, permits, traffic plans, lifting plans or service permits as applicable.'),
  PlantBookPoint('Defects', 'Defect reports, isolation/tag-out and repair/release evidence.'),
  PlantBookPoint('Incident', 'Near miss, incident, observation and corrective-action records.')
]),
      PlantBookSection('33 — Toolbox Talk', [
  PlantBookPoint('Machine', 'Explain machine-specific hazards, capacity, attachment and safety devices.'),
  PlantBookPoint('Area', 'Explain route, ground, edges, services, traffic and pedestrian controls.'),
  PlantBookPoint('People', 'Confirm operator, banksman, supervisor and emergency contacts.'),
  PlantBookPoint('Signals', 'Agree one communication/signalling system.'),
  PlantBookPoint('Stop-work', 'State clear stop-work triggers and confirm every worker can raise a concern.')
]),
      PlantBookSection('34 — Field Checklist / Quick Reference', [
  PlantBookPoint('Documents', 'RAMS/JSA, permits and inspection status verified.'),
  PlantBookPoint('Machine', 'Pre-use inspection complete; no safety-critical defect.'),
  PlantBookPoint('People', 'Competent authorised operator and required banksman/spotter.'),
  PlantBookPoint('Area', 'Ground, route, segregation, services and weather checked.'),
  PlantBookPoint('Operation', 'Capacity, speed, visibility and attachment controls maintained.')
]),
      PlantBookSection('35 — Corrective Action', [
  PlantBookPoint('Immediate', 'Stop the unsafe activity and make the area safe.'),
  PlantBookPoint('Defect', 'Isolate/tag out defective equipment where required.'),
  PlantBookPoint('Root cause', 'Identify why the control failed rather than correcting only the symptom.'),
  PlantBookPoint('Close-out', 'Verify the corrective action physically before returning to normal work.'),
  PlantBookPoint('Learning', 'Share significant findings through toolbox talks and lessons learned.')
]),
      PlantBookSection('36 — UAE / Abu Dhabi / Dubai Applicability', [
  PlantBookPoint('Abu Dhabi', 'Apply the current ADPHC/ADOSH-SF requirements and Abu Dhabi project/client requirements.'),
  PlantBookPoint('UAE common', 'Also comply with applicable federal requirements and project contractual obligations.'),
  PlantBookPoint('Dubai', 'Dubai requirements are not automatically transferable to Abu Dhabi; maintain separate jurisdictional references.'),
  PlantBookPoint('Sector', 'Oil & gas, offshore, industrial and specialist projects may impose additional client/sector controls.'),
  PlantBookPoint('Hierarchy', 'Where requirements differ, identify the applicable legal, authority, client and manufacturer requirements and obtain competent clarification.')
]),
      PlantBookSection('37 — Cross-References', [
  PlantBookPoint('Plant', 'ADPHC CoP 36.0 — Plant and Equipment.'),
  PlantBookPoint('Traffic', 'CoP 33.0 Working On or Adjacent to a Road and CoP 44.0 Traffic Management and Logistics where applicable.'),
  PlantBookPoint('Services', 'CoP 39.0 Overhead and Underground Services.'),
  PlantBookPoint('Lifting', 'CoP 34.0 Safe Use of Lifting Equipment and Lifting Accessories where lifting is involved.'),
  PlantBookPoint('Other', 'Link to electrical, hot work, heat, vibration, noise, excavation, machine guarding and lockout modules according to task.')
]),
      PlantBookSection('38 — Official Reference / Regulatory Verification', [
  PlantBookPoint('Official registry', 'Use the Abu Dhabi Public Health Centre Code of Practices registry as the primary source for current CoP versions and effective dates.'),
  PlantBookPoint('Current baseline', 'CoP 36.0 Plant and Equipment is listed as Version 4.1, effective February 2026.'),
  PlantBookPoint('Verification rule', 'Before regulatory lock, verify the exact current PDF, applicability, definitions, mandatory requirements and numeric values.'),
  PlantBookPoint('Manufacturer source', 'The exact machine operator manual, load chart and safety instructions must be available and followed.'),
  PlantBookPoint('Field rule', 'This handbook supports field understanding; it does not replace the applicable law, CoP, engineering design, manufacturer instructions or approved project documents.')
]),
      PlantBookSection('39 — Generator: Electrical controls', [
  PlantBookPoint('Earthing', 'Provide the required grounding/earthing and electrical protection for the generator installation.'),
  PlantBookPoint('Distribution', 'Use suitable distribution boards, protective devices, cables and connections.'),
  PlantBookPoint('Isolation', 'Provide a clear means of isolation and prevent unauthorised energisation.'),
  PlantBookPoint('Inspection', 'Inspect cables, plugs, outlets, enclosures and protective devices before use.'),
  PlantBookPoint('Competence', 'Electrical installation/testing work must be performed by appropriately competent authorised personnel.')
]),
      PlantBookSection('40 — Generator: Fuel / fire / exhaust', [
  PlantBookPoint('Fuel', 'Control fuel storage, refuelling, spills and ignition sources.'),
  PlantBookPoint('Exhaust', 'Route exhaust safely and prevent carbon-monoxide accumulation.'),
  PlantBookPoint('Ventilation', 'Never place combustion generators in enclosed spaces without a properly engineered and approved arrangement.'),
  PlantBookPoint('Fire', 'Provide appropriate fire controls and maintain clear access.'),
  PlantBookPoint('Hot surfaces', 'Prevent contact and ignition from exhaust and engine components.')
]),
      PlantBookSection('41 — Generator: Temporary power management', [
  PlantBookPoint('Load', 'Do not exceed generator output or distribution-system ratings.'),
  PlantBookPoint('Cable management', 'Protect cables from traffic, water, sharp edges and mechanical damage.'),
  PlantBookPoint('Weather', 'Protect electrical equipment from water ingress while maintaining safe ventilation.'),
  PlantBookPoint('Noise', 'Assess operator/community noise and apply controls.'),
  PlantBookPoint('Lockout', 'Use the site isolation/LOTO system for maintenance and electrical work.')
])
    ],
  )
];
