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

final List<PlantBookTopic> abuDhabi5ABTo5AETopics = [
PlantBookTopic(
    code: '5AB',
    title: 'Dump Truck / Tipper',
    regulatoryBasis: 'ADPHC CoP 36.0 Plant & Equipment V4.1; applicable traffic/logistics, road, excavation and manufacturer requirements.',
    fieldPurpose: 'Field reference for safe haulage, loading, tipping, reversing, edge work, maintenance and emergency control.',
    sections: [
      PlantBookSection('01 — What / Purpose / Scope', [
  PlantBookPoint('Definition', 'Dump Truck / Tipper is mobile/portable plant used for site operations. The exact machine configuration, capacity, attachment and manufacturer limitations determine its safe operating envelope.'),
  PlantBookPoint('Purpose', 'Use Dump Truck / Tipper only for tasks for which the machine and attachment are designed, rated and authorised.'),
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
      PlantBookSection('39 — Dump Truck / Tipper: Machine-specific controls', [
  PlantBookPoint('Body and chassis', 'Inspect chassis, tipping body, hinges, body props, locking devices, hydraulic cylinders and mounting points.'),
  PlantBookPoint('Tailgate', 'Confirm tailgate operation and locking; prevent unexpected opening during travel.'),
  PlantBookPoint('Payload', 'Know the rated payload and distribute material to avoid instability or overload.'),
  PlantBookPoint('Dumping', 'Dump only on a stable, level or specifically assessed surface with sufficient clearance.'),
  PlantBookPoint('Body raised', 'Never travel with a raised body unless the manufacturer specifically permits the configuration; isolate and mechanically support before maintenance.')
]),
      PlantBookSection('40 — Dump Truck / Tipper: Loading and unloading', [
  PlantBookPoint('Loading position', 'Park squarely in the loading zone and maintain communication with the loading machine.'),
  PlantBookPoint('Cab protection', 'Keep the operator in the designated protected position during loading according to site procedure.'),
  PlantBookPoint('Load distribution', 'Avoid asymmetric loading and overfilling that can cause spillage or instability.'),
  PlantBookPoint('Dump edge', 'Before tipping, verify edge stability, wheel clearance, ground bearing and exclusion zone.'),
  PlantBookPoint('Overhead', 'Check overhead structures and services before raising the body.')
]),
      PlantBookSection('41 — Dump Truck / Tipper: Field scenarios', [
  PlantBookPoint('Stockpile', 'Do not approach unstable stockpile faces or undercut material.'),
  PlantBookPoint('Ramp', 'Use the approved route and gradient; control speed and avoid abrupt steering.'),
  PlantBookPoint('Soft ground', 'Stop where ground bearing is uncertain.'),
  PlantBookPoint('Public road', 'Use the approved traffic plan, lighting, markings and vehicle controls.'),
  PlantBookPoint('Spillage', 'Stop and clean/control spilled material before it creates a traffic hazard.')
])
    ],
  ),
PlantBookTopic(
    code: '5AC',
    title: 'Articulated Dump Truck',
    regulatoryBasis: 'ADPHC CoP 36.0 Plant & Equipment V4.1; applicable traffic, earthworks, ground-stability and manufacturer requirements.',
    fieldPurpose: 'Field reference for articulated haulage, stability, dumping, slopes, articulation hazards and recovery.',
    sections: [
      PlantBookSection('01 — What / Purpose / Scope', [
  PlantBookPoint('Definition', 'Articulated Dump Truck is mobile/portable plant used for site operations. The exact machine configuration, capacity, attachment and manufacturer limitations determine its safe operating envelope.'),
  PlantBookPoint('Purpose', 'Use Articulated Dump Truck only for tasks for which the machine and attachment are designed, rated and authorised.'),
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
      PlantBookSection('39 — Articulated Dump Truck: Articulation and stability', [
  PlantBookPoint('Articulation joint', 'The joint creates a severe crush zone; prohibit personnel from standing between frames unless isolated and controlled.'),
  PlantBookPoint('Oscillation', 'Understand how the oscillation/articulation system affects stability on uneven ground.'),
  PlantBookPoint('Turning', 'Account for rear-frame movement and swept path during turns.'),
  PlantBookPoint('Slope', 'Follow manufacturer limits and avoid unsafe cross-slope travel.'),
  PlantBookPoint('Load', 'Keep payload within rated capacity and distribute it to maintain stability.')
]),
      PlantBookSection('40 — Articulated Dump Truck: Haul routes', [
  PlantBookPoint('Route survey', 'Check width, gradients, berms, crossings, soft spots and traffic interfaces.'),
  PlantBookPoint('Berms', 'Use engineered/approved berms and do not rely on improvised piles.'),
  PlantBookPoint('Dumping', 'Use a controlled tipping area and confirm edge stability.'),
  PlantBookPoint('Visibility', 'Use cameras, mirrors and spotters where required.'),
  PlantBookPoint('Weather', 'Reassess routes after rain, flooding, dust storms or visibility deterioration.')
]),
      PlantBookSection('41 — Articulated Dump Truck: Maintenance hazards', [
  PlantBookPoint('Articulation isolation', "Use the manufacturer's articulation lock where required before work in the joint area."),
  PlantBookPoint('Raised body', 'Use the approved body support device before entering any danger zone.'),
  PlantBookPoint('Hydraulics', 'Relieve stored pressure before disconnecting hydraulic components.'),
  PlantBookPoint('Wheel/tyre', 'Treat tyre and rim work as specialist high-energy work.'),
  PlantBookPoint('Recovery', 'Use an engineered recovery method; do not tow/pull without confirming rated recovery points.')
])
    ],
  ),
PlantBookTopic(
    code: '5AD',
    title: 'Rigid Dump Truck',
    regulatoryBasis: 'ADPHC CoP 36.0 Plant & Equipment V4.1; applicable traffic/logistics, driver-fatique and manufacturer requirements.',
    fieldPurpose: 'Field reference for heavy rigid haul trucks, tipping, braking, reversing, road interaction and maintenance.',
    sections: [
      PlantBookSection('01 — What / Purpose / Scope', [
  PlantBookPoint('Definition', 'Rigid Dump Truck is mobile/portable plant used for site operations. The exact machine configuration, capacity, attachment and manufacturer limitations determine its safe operating envelope.'),
  PlantBookPoint('Purpose', 'Use Rigid Dump Truck only for tasks for which the machine and attachment are designed, rated and authorised.'),
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
      PlantBookSection('39 — Rigid Dump Truck: Heavy vehicle controls', [
  PlantBookPoint('Vehicle mass', 'Large vehicle mass increases stopping distance, collision energy and ground loading.'),
  PlantBookPoint('Cab access', 'Maintain clean steps/handholds and three-point contact when entering/exiting.'),
  PlantBookPoint('Braking', 'Check service and parking braking systems before operation.'),
  PlantBookPoint('Steering', 'Any steering abnormality is safety-critical and requires immediate assessment.'),
  PlantBookPoint('Seat restraint', 'Use the designated restraint at all times while moving.')
]),
      PlantBookSection('40 — Rigid Dump Truck: Tipping operations', [
  PlantBookPoint('Body', 'Inspect body, hinges, hydraulic system and locking arrangements.'),
  PlantBookPoint('Dumping surface', 'Confirm the tipping area can support the vehicle and load.'),
  PlantBookPoint('Edge', 'Use the project-approved setback from edges and follow engineered tipping controls.'),
  PlantBookPoint('Overhead', 'Check body-raise clearance from overhead services/structures.'),
  PlantBookPoint('People', 'Keep people outside the tipping and body movement envelope.')
]),
      PlantBookSection('41 — Rigid Dump Truck: Site traffic', [
  PlantBookPoint('One-way system', 'Use one-way routes where practicable to reduce reversing.'),
  PlantBookPoint('Reversing', 'Use engineered visibility controls and competent signalling where required.'),
  PlantBookPoint('Crossings', 'Control pedestrian crossings and maintain clear sight lines.'),
  PlantBookPoint('Road interface', 'Follow approved road traffic management requirements.'),
  PlantBookPoint('Fatigue', 'Apply driver fatigue controls and journey planning where applicable.')
])
    ],
  ),
PlantBookTopic(
    code: '5AE',
    title: 'Roller / Compactor',
    regulatoryBasis: 'ADPHC CoP 36.0 Plant & Equipment V4.1; applicable vibration, noise, heat and road-work requirements.',
    fieldPurpose: 'Field reference for compaction operations, stability, vibration/noise exposure, traffic interface and maintenance.',
    sections: [
      PlantBookSection('01 — What / Purpose / Scope', [
  PlantBookPoint('Definition', 'Roller / Compactor is mobile/portable plant used for site operations. The exact machine configuration, capacity, attachment and manufacturer limitations determine its safe operating envelope.'),
  PlantBookPoint('Purpose', 'Use Roller / Compactor only for tasks for which the machine and attachment are designed, rated and authorised.'),
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
      PlantBookSection('39 — Roller / Compactor: Machine-specific controls', [
  PlantBookPoint('Drum', 'Inspect drum condition, scrapers, mounts and vibration system.'),
  PlantBookPoint('Vibration', 'Assess whole-body and hand/arm vibration exposure as applicable to the equipment/task.'),
  PlantBookPoint('Water system', 'Check spray tank, lines and nozzles where wet compaction is used.'),
  PlantBookPoint('ROPS/restraint', 'Use required rollover protection and seat restraint.'),
  PlantBookPoint('Edges', 'Maintain safe distance from embankments, excavations and unsupported edges.')
]),
      PlantBookSection('40 — Roller / Compactor: Compaction sequence', [
  PlantBookPoint('Route', 'Plan passes to avoid unnecessary reversing and crossing pedestrian routes.'),
  PlantBookPoint('Overlap', 'Use the planned compaction pattern without creating unstable edge loading.'),
  PlantBookPoint('Slopes', 'Follow manufacturer travel direction and slope limitations.'),
  PlantBookPoint('Other plant', 'Coordinate roller movement with pavers, trucks and graders.'),
  PlantBookPoint('Dust', 'Use suitable dust suppression where material generates airborne dust.')
]),
      PlantBookSection('41 — Roller / Compactor: Occupational exposure', [
  PlantBookPoint('Noise', 'Assess operator and nearby-worker noise exposure.'),
  PlantBookPoint('Vibration', 'Use engineering/administrative controls and exposure management based on the applicable assessment.'),
  PlantBookPoint('Heat', 'Apply heat-stress controls for UAE outdoor operations.'),
  PlantBookPoint('Visibility', 'Use lighting and visibility controls for night work.'),
  PlantBookPoint('Maintenance', 'Isolate vibration systems and moving components before intrusive maintenance.')
])
    ],
  )
];
