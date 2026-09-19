// SafeNexus HSE — Abu Dhabi HSE Reference
// Gold Standard field handbook data.
// Consolidated minimum-file architecture.
// IMPORTANT: Verify the current applicable ADPHC/ADOSH requirements,
// manufacturer instructions, project RAMS/JSA, and competent-person requirements
// before field use. Numeric limits are not to be treated as universal unless
// confirmed by the applicable source.

class MobileEquipmentGoldPoint {
  final String title;
  final String detail;
  const MobileEquipmentGoldPoint(this.title, this.detail);
}

class MobileEquipmentGoldSection {
  final String title;
  final List<MobileEquipmentGoldPoint> points;
  const MobileEquipmentGoldSection(this.title, this.points);
}

class MobileEquipmentTopic {
  final String code;
  final String title;
  final String regulatoryBasis;
  final List<MobileEquipmentGoldSection> sections;
  const MobileEquipmentTopic({
    required this.code,
    required this.title,
    required this.regulatoryBasis,
    required this.sections,
  });
}

final List<MobileEquipmentTopic> abuDhabi5STo5VTopics = [
  MobileEquipmentTopic(
    code: '5S',
    title: 'Forklift / Powered Lift Trucks',
    regulatoryBasis: 'ADPHC CoP 51.0 Powered Lift Trucks; current applicable version and project requirements must be verified.',
    sections: [
      MobileEquipmentGoldSection('Purpose, scope and field use', [
  MobileEquipmentGoldPoint('Purpose', 'Provide a field-ready control framework for safe selection, operation, inspection, maintenance and supervision of mobile plant and material-handling equipment.'),
  MobileEquipmentGoldPoint('Scope', 'Applies to equipment operators, banksmen/signallers, supervisors, HSE personnel, mechanics, lifting teams, logistics teams and contractors where the equipment is used.'),
  MobileEquipmentGoldPoint('Golden rule', 'Use only equipment that is suitable for the task, inspected, maintained, authorised for use and operated by a competent person.'),
  MobileEquipmentGoldPoint('Manufacturer instructions', 'Manufacturer operating limits, load charts, stability limits, attachments, exclusions and warnings form a critical part of the safe system of work.'),
  MobileEquipmentGoldPoint('Project interface', 'Follow the approved RAMS/JSA, traffic management plan, permit requirements, lifting plan where applicable, exclusion zones and site rules.')
]),
      MobileEquipmentGoldSection('Planning and risk assessment', [
  MobileEquipmentGoldPoint('Task assessment', 'Identify load, travel path, ground conditions, gradients, visibility, overhead services, underground services, pedestrians, other plant, weather and simultaneous operations.'),
  MobileEquipmentGoldPoint('Hierarchy of controls', 'Eliminate unnecessary plant movement first; then segregate people and machines; use engineered controls; administrative controls; PPE as the final layer.'),
  MobileEquipmentGoldPoint('Dynamic conditions', 'Reassess when ground, weather, load, attachment, route, visibility, work sequence or nearby activities change.'),
  MobileEquipmentGoldPoint('Exclusion zone', 'Define and physically control the plant operating envelope and keep unauthorised persons outside it.'),
  MobileEquipmentGoldPoint('Stop and reassess', 'Stop work when a critical control is missing, conditions become unsafe, equipment behaves abnormally or the operator cannot maintain safe control.')
]),
      MobileEquipmentGoldSection('Competency and authorisation', [
  MobileEquipmentGoldPoint('Operator', 'Operator competency must match the equipment type, attachment, task and site requirements; evidence of required training/authorisation must be available.'),
  MobileEquipmentGoldPoint('Familiarisation', 'Operators must understand the specific machine, controls, safety devices, limitations and emergency arrangements before use.'),
  MobileEquipmentGoldPoint('Banksman/signaller', 'Where required, use a competent banksman/signaller with a clear agreed communication system.'),
  MobileEquipmentGoldPoint('Supervision', 'Supervision must be proportionate to risk, operator experience, work complexity and site conditions.'),
  MobileEquipmentGoldPoint('Fitness', 'Do not operate while impaired by fatigue, alcohol, drugs, illness, distraction or any condition affecting safe operation.')
]),
      MobileEquipmentGoldSection('Pre-use inspection', [
  MobileEquipmentGoldPoint('Walk-around', 'Inspect structure, tyres/tracks, leaks, guards, steps, handrails, mirrors/cameras, lights, alarms, horn, seat belt, fire protection and visible damage.'),
  MobileEquipmentGoldPoint('Hydraulic systems', 'Check hoses, fittings, cylinders and connections for damage, abrasion, leakage or unsafe modification.'),
  MobileEquipmentGoldPoint('Controls', 'Confirm steering, brakes, service brake, parking brake, travel controls, attachment controls and emergency functions operate correctly.'),
  MobileEquipmentGoldPoint('Safety devices', 'Verify required interlocks, alarms, reversing aids, load indicators, cameras and other safety devices are present and functional.'),
  MobileEquipmentGoldPoint('Defects', 'Tag out and prevent use of equipment with a safety-critical defect until the defect is assessed and corrected by an authorised person.')
]),
      MobileEquipmentGoldSection('Work area and ground conditions', [
  MobileEquipmentGoldPoint('Ground capacity', 'Confirm the ground can safely support the machine and imposed loads, considering soft spots, voids, trenches, slabs, edges and underground services.'),
  MobileEquipmentGoldPoint('Slopes', 'Follow manufacturer limits and the approved method for slopes; avoid cross-slope travel where it creates instability.'),
  MobileEquipmentGoldPoint('Edges and excavations', 'Maintain a safe setback from excavations, unsupported edges and other collapse hazards based on competent assessment and site controls.'),
  MobileEquipmentGoldPoint('Housekeeping', 'Remove debris, loose materials and obstructions that can affect traction, steering, visibility or attachment stability.'),
  MobileEquipmentGoldPoint('Drainage', 'Control water accumulation and mud because saturated ground can reduce bearing capacity and braking/traction.')
]),
      MobileEquipmentGoldSection('People, traffic and segregation', [
  MobileEquipmentGoldPoint('Pedestrian segregation', 'Use physical barriers and defined pedestrian routes wherever practicable; do not rely only on verbal warnings.'),
  MobileEquipmentGoldPoint('Reversing', 'Avoid reversing where possible; when unavoidable, use a controlled system with suitable visibility aids and a competent banksman where required.'),
  MobileEquipmentGoldPoint('Blind spots', 'Assume that people may be hidden from the operator; stop if the operator loses visual confirmation of the intended path.'),
  MobileEquipmentGoldPoint('Speed', 'Operate at a safe site-approved speed appropriate to visibility, load, ground, traffic and manufacturer limitations.'),
  MobileEquipmentGoldPoint('Communication', 'Use one agreed signal system; stop immediately if signals are unclear or conflicting.')
]),
      MobileEquipmentGoldSection('Loading, attachments and stability', [
  MobileEquipmentGoldPoint('Correct attachment', 'Use only approved attachments compatible with the machine and task; secure them correctly and inspect locking mechanisms.'),
  MobileEquipmentGoldPoint('Load security', 'Keep loads stable, within equipment limits and positioned to preserve visibility and stability.'),
  MobileEquipmentGoldPoint('Centre of gravity', 'Understand how load position, boom/attachment geometry, height, travel direction and slope affect stability.'),
  MobileEquipmentGoldPoint('No improvised lifting', 'Do not use buckets, forks, hooks or other attachments for lifting unless specifically designed, approved and controlled for that purpose.'),
  MobileEquipmentGoldPoint('Overloading', 'Never exceed the applicable rated capacity, load chart, attachment rating or other limiting condition.')
]),
      MobileEquipmentGoldSection('Safe operating procedure', [
  MobileEquipmentGoldPoint('Start-up', 'Mount using designated access points, fasten restraints, check surroundings and start only when the area is clear.'),
  MobileEquipmentGoldPoint('Travel', 'Travel with the attachment/load in the manufacturer-recommended safe travel position and maintain control.'),
  MobileEquipmentGoldPoint('Stopping', 'Park in a safe designated area, lower attachments to a safe position, apply parking brake and isolate/shut down as required.'),
  MobileEquipmentGoldPoint('Unauthorised passengers', 'No passengers unless the machine is specifically designed and approved for them.'),
  MobileEquipmentGoldPoint('Leaving machine', 'Never leave an operating machine unattended; follow isolation and parking requirements before dismounting.')
]),
      MobileEquipmentGoldSection('Maintenance, isolation and emergency', [
  MobileEquipmentGoldPoint('Isolation', 'Before maintenance, isolate energy sources and prevent unexpected movement; use lockout/tagout where required by the site system.'),
  MobileEquipmentGoldPoint('Stored energy', 'Relieve hydraulic, pneumatic, electrical and mechanical stored energy before work on systems that could move or release energy.'),
  MobileEquipmentGoldPoint('Hot surfaces', 'Allow hot components to cool or use controlled procedures before inspection or maintenance.'),
  MobileEquipmentGoldPoint('Emergency', 'Operators must know emergency stop/shutdown, fire response, evacuation, recovery and site emergency communication arrangements.'),
  MobileEquipmentGoldPoint('Recovery', 'Do not improvise recovery of disabled plant; use an approved recovery method, suitable equipment and competent personnel.')
]),
      MobileEquipmentGoldSection('Field checklist and stop-work', [
  MobileEquipmentGoldPoint('Before use', 'Authorisation, inspection status, machine condition, attachment, route, ground, services, segregation, visibility, weather and emergency arrangements confirmed.'),
  MobileEquipmentGoldPoint('During use', 'Seat restraint used, controls maintained, people segregated, loads stable, speed controlled and no safety device bypassed.'),
  MobileEquipmentGoldPoint('Stop-work triggers', 'Uncontrolled pedestrian entry, loss of visibility, unstable ground, hydraulic/structural failure, brake/steering fault, overloaded condition, unsafe weather or failed safety-critical device.'),
  MobileEquipmentGoldPoint('Unsafe practices', 'Riding on attachments, bypassing interlocks, carrying people improperly, operating with known defects, exceeding capacity, using phones while driving and working too close to hazards without controls.'),
  MobileEquipmentGoldPoint('Corrective action', 'Stop, secure equipment, isolate if necessary, notify supervision/HSE, control the area and only resume after competent verification.')
]),
      MobileEquipmentGoldSection('Forklift fundamentals', [
  MobileEquipmentGoldPoint('Types', 'Counterbalance, reach, rough-terrain and other powered lift truck configurations have different stability and operating characteristics.'),
  MobileEquipmentGoldPoint('Capacity plate', 'Read the truck rating plate/load chart and account for load centre, mast position, attachment and any capacity reduction.'),
  MobileEquipmentGoldPoint('Mast and forks', 'Inspect mast rails, chains, rollers, forks, fork heels, locking pins and attachment interfaces for damage or wear.'),
  MobileEquipmentGoldPoint('Fork condition', 'Forks must be correctly seated and locked; damaged, excessively worn, cracked or distorted forks must be removed from service.'),
  MobileEquipmentGoldPoint('Load centre', "Keep the load as close to the intended load centre as practicable and within the truck's rated configuration.")
]),
      MobileEquipmentGoldSection('Forklift loading and travel', [
  MobileEquipmentGoldPoint('Load height', "Carry loads at the manufacturer's recommended low travel position while preserving stability and visibility."),
  MobileEquipmentGoldPoint('Visibility', 'If the load blocks forward view, use the approved travel direction and a competent banksman/spotter where required.'),
  MobileEquipmentGoldPoint('Fork positioning', 'Position forks symmetrically and fully under the load where the load and equipment design permit.'),
  MobileEquipmentGoldPoint('Pedestrian crossings', 'Use designated crossings and stop/confirm clearance before crossing pedestrian routes.'),
  MobileEquipmentGoldPoint('Parking', 'Lower forks, neutralise controls, apply parking brake, shut down and secure the truck in the designated parking area.')
]),
      MobileEquipmentGoldSection('Forklift specific hazards', [
  MobileEquipmentGoldPoint('Tip-over', 'Main contributors include excessive load, incorrect load centre, turning too fast, uneven ground, ramps, raised loads and abrupt manoeuvres.'),
  MobileEquipmentGoldPoint('Dropped load', 'Can result from damaged pallets, unstable stacking, incorrect fork engagement, excessive height or unsuitable attachment.'),
  MobileEquipmentGoldPoint('Mast crush points', 'Keep body parts outside mast, carriage, chains and attachment pinch/crush zones.'),
  MobileEquipmentGoldPoint('Trailer interface', 'Control trailer movement, dock condition and access before entering trailers; use site-approved dock controls.'),
  MobileEquipmentGoldPoint('Battery/charging', 'Charging areas require appropriate ventilation, ignition control, electrical integrity, spill response and manufacturer/site procedures.')
]),
      MobileEquipmentGoldSection('Forklift practical verification', [
  MobileEquipmentGoldPoint('Daily record', 'Record required pre-use checks and defects according to the site inspection system.'),
  MobileEquipmentGoldPoint('Periodic examination', 'Complete statutory/site-required examinations and maintenance at the specified frequency by authorised competent personnel.'),
  MobileEquipmentGoldPoint('Attachment change', 'Recheck capacity and stability whenever an attachment is changed.'),
  MobileEquipmentGoldPoint('Ramp travel', 'Follow manufacturer/site rules for loaded and unloaded travel on gradients; avoid turning or unstable manoeuvres on slopes.'),
  MobileEquipmentGoldPoint('Load handling', 'Set down loads squarely, keep people clear and confirm the storage surface can support the load.')
])
    ],
  ),
  MobileEquipmentTopic(
    code: '5T',
    title: 'Telehandler / Telescopic Handler',
    regulatoryBasis: 'ADPHC CoP 36.0 Plant & Equipment and applicable powered-lift/attachment requirements; verify the current equipment-specific basis.',
    sections: [
      MobileEquipmentGoldSection('Purpose, scope and field use', [
  MobileEquipmentGoldPoint('Purpose', 'Provide a field-ready control framework for safe selection, operation, inspection, maintenance and supervision of mobile plant and material-handling equipment.'),
  MobileEquipmentGoldPoint('Scope', 'Applies to equipment operators, banksmen/signallers, supervisors, HSE personnel, mechanics, lifting teams, logistics teams and contractors where the equipment is used.'),
  MobileEquipmentGoldPoint('Golden rule', 'Use only equipment that is suitable for the task, inspected, maintained, authorised for use and operated by a competent person.'),
  MobileEquipmentGoldPoint('Manufacturer instructions', 'Manufacturer operating limits, load charts, stability limits, attachments, exclusions and warnings form a critical part of the safe system of work.'),
  MobileEquipmentGoldPoint('Project interface', 'Follow the approved RAMS/JSA, traffic management plan, permit requirements, lifting plan where applicable, exclusion zones and site rules.')
]),
      MobileEquipmentGoldSection('Planning and risk assessment', [
  MobileEquipmentGoldPoint('Task assessment', 'Identify load, travel path, ground conditions, gradients, visibility, overhead services, underground services, pedestrians, other plant, weather and simultaneous operations.'),
  MobileEquipmentGoldPoint('Hierarchy of controls', 'Eliminate unnecessary plant movement first; then segregate people and machines; use engineered controls; administrative controls; PPE as the final layer.'),
  MobileEquipmentGoldPoint('Dynamic conditions', 'Reassess when ground, weather, load, attachment, route, visibility, work sequence or nearby activities change.'),
  MobileEquipmentGoldPoint('Exclusion zone', 'Define and physically control the plant operating envelope and keep unauthorised persons outside it.'),
  MobileEquipmentGoldPoint('Stop and reassess', 'Stop work when a critical control is missing, conditions become unsafe, equipment behaves abnormally or the operator cannot maintain safe control.')
]),
      MobileEquipmentGoldSection('Competency and authorisation', [
  MobileEquipmentGoldPoint('Operator', 'Operator competency must match the equipment type, attachment, task and site requirements; evidence of required training/authorisation must be available.'),
  MobileEquipmentGoldPoint('Familiarisation', 'Operators must understand the specific machine, controls, safety devices, limitations and emergency arrangements before use.'),
  MobileEquipmentGoldPoint('Banksman/signaller', 'Where required, use a competent banksman/signaller with a clear agreed communication system.'),
  MobileEquipmentGoldPoint('Supervision', 'Supervision must be proportionate to risk, operator experience, work complexity and site conditions.'),
  MobileEquipmentGoldPoint('Fitness', 'Do not operate while impaired by fatigue, alcohol, drugs, illness, distraction or any condition affecting safe operation.')
]),
      MobileEquipmentGoldSection('Pre-use inspection', [
  MobileEquipmentGoldPoint('Walk-around', 'Inspect structure, tyres/tracks, leaks, guards, steps, handrails, mirrors/cameras, lights, alarms, horn, seat belt, fire protection and visible damage.'),
  MobileEquipmentGoldPoint('Hydraulic systems', 'Check hoses, fittings, cylinders and connections for damage, abrasion, leakage or unsafe modification.'),
  MobileEquipmentGoldPoint('Controls', 'Confirm steering, brakes, service brake, parking brake, travel controls, attachment controls and emergency functions operate correctly.'),
  MobileEquipmentGoldPoint('Safety devices', 'Verify required interlocks, alarms, reversing aids, load indicators, cameras and other safety devices are present and functional.'),
  MobileEquipmentGoldPoint('Defects', 'Tag out and prevent use of equipment with a safety-critical defect until the defect is assessed and corrected by an authorised person.')
]),
      MobileEquipmentGoldSection('Work area and ground conditions', [
  MobileEquipmentGoldPoint('Ground capacity', 'Confirm the ground can safely support the machine and imposed loads, considering soft spots, voids, trenches, slabs, edges and underground services.'),
  MobileEquipmentGoldPoint('Slopes', 'Follow manufacturer limits and the approved method for slopes; avoid cross-slope travel where it creates instability.'),
  MobileEquipmentGoldPoint('Edges and excavations', 'Maintain a safe setback from excavations, unsupported edges and other collapse hazards based on competent assessment and site controls.'),
  MobileEquipmentGoldPoint('Housekeeping', 'Remove debris, loose materials and obstructions that can affect traction, steering, visibility or attachment stability.'),
  MobileEquipmentGoldPoint('Drainage', 'Control water accumulation and mud because saturated ground can reduce bearing capacity and braking/traction.')
]),
      MobileEquipmentGoldSection('People, traffic and segregation', [
  MobileEquipmentGoldPoint('Pedestrian segregation', 'Use physical barriers and defined pedestrian routes wherever practicable; do not rely only on verbal warnings.'),
  MobileEquipmentGoldPoint('Reversing', 'Avoid reversing where possible; when unavoidable, use a controlled system with suitable visibility aids and a competent banksman where required.'),
  MobileEquipmentGoldPoint('Blind spots', 'Assume that people may be hidden from the operator; stop if the operator loses visual confirmation of the intended path.'),
  MobileEquipmentGoldPoint('Speed', 'Operate at a safe site-approved speed appropriate to visibility, load, ground, traffic and manufacturer limitations.'),
  MobileEquipmentGoldPoint('Communication', 'Use one agreed signal system; stop immediately if signals are unclear or conflicting.')
]),
      MobileEquipmentGoldSection('Loading, attachments and stability', [
  MobileEquipmentGoldPoint('Correct attachment', 'Use only approved attachments compatible with the machine and task; secure them correctly and inspect locking mechanisms.'),
  MobileEquipmentGoldPoint('Load security', 'Keep loads stable, within equipment limits and positioned to preserve visibility and stability.'),
  MobileEquipmentGoldPoint('Centre of gravity', 'Understand how load position, boom/attachment geometry, height, travel direction and slope affect stability.'),
  MobileEquipmentGoldPoint('No improvised lifting', 'Do not use buckets, forks, hooks or other attachments for lifting unless specifically designed, approved and controlled for that purpose.'),
  MobileEquipmentGoldPoint('Overloading', 'Never exceed the applicable rated capacity, load chart, attachment rating or other limiting condition.')
]),
      MobileEquipmentGoldSection('Safe operating procedure', [
  MobileEquipmentGoldPoint('Start-up', 'Mount using designated access points, fasten restraints, check surroundings and start only when the area is clear.'),
  MobileEquipmentGoldPoint('Travel', 'Travel with the attachment/load in the manufacturer-recommended safe travel position and maintain control.'),
  MobileEquipmentGoldPoint('Stopping', 'Park in a safe designated area, lower attachments to a safe position, apply parking brake and isolate/shut down as required.'),
  MobileEquipmentGoldPoint('Unauthorised passengers', 'No passengers unless the machine is specifically designed and approved for them.'),
  MobileEquipmentGoldPoint('Leaving machine', 'Never leave an operating machine unattended; follow isolation and parking requirements before dismounting.')
]),
      MobileEquipmentGoldSection('Maintenance, isolation and emergency', [
  MobileEquipmentGoldPoint('Isolation', 'Before maintenance, isolate energy sources and prevent unexpected movement; use lockout/tagout where required by the site system.'),
  MobileEquipmentGoldPoint('Stored energy', 'Relieve hydraulic, pneumatic, electrical and mechanical stored energy before work on systems that could move or release energy.'),
  MobileEquipmentGoldPoint('Hot surfaces', 'Allow hot components to cool or use controlled procedures before inspection or maintenance.'),
  MobileEquipmentGoldPoint('Emergency', 'Operators must know emergency stop/shutdown, fire response, evacuation, recovery and site emergency communication arrangements.'),
  MobileEquipmentGoldPoint('Recovery', 'Do not improvise recovery of disabled plant; use an approved recovery method, suitable equipment and competent personnel.')
]),
      MobileEquipmentGoldSection('Field checklist and stop-work', [
  MobileEquipmentGoldPoint('Before use', 'Authorisation, inspection status, machine condition, attachment, route, ground, services, segregation, visibility, weather and emergency arrangements confirmed.'),
  MobileEquipmentGoldPoint('During use', 'Seat restraint used, controls maintained, people segregated, loads stable, speed controlled and no safety device bypassed.'),
  MobileEquipmentGoldPoint('Stop-work triggers', 'Uncontrolled pedestrian entry, loss of visibility, unstable ground, hydraulic/structural failure, brake/steering fault, overloaded condition, unsafe weather or failed safety-critical device.'),
  MobileEquipmentGoldPoint('Unsafe practices', 'Riding on attachments, bypassing interlocks, carrying people improperly, operating with known defects, exceeding capacity, using phones while driving and working too close to hazards without controls.'),
  MobileEquipmentGoldPoint('Corrective action', 'Stop, secure equipment, isolate if necessary, notify supervision/HSE, control the area and only resume after competent verification.')
]),
      MobileEquipmentGoldSection('Telehandler fundamentals', [
  MobileEquipmentGoldPoint('Machine configuration', 'Telehandler stability changes with boom extension, load radius, attachment, steering mode, ground slope and load position.'),
  MobileEquipmentGoldPoint('Load chart', 'Use the correct load chart for the machine, attachment and operating configuration; do not use a generic capacity value.'),
  MobileEquipmentGoldPoint('Boom', 'Inspect boom sections, pins, bushes, cylinders, hoses, guards and structural members for damage or leakage.'),
  MobileEquipmentGoldPoint('Attachment locking', 'Confirm the attachment is fully engaged and the locking system is positively secured before use.'),
  MobileEquipmentGoldPoint('Cab protection', 'Use required restraint and keep within the protected operator position.')
]),
      MobileEquipmentGoldSection('Telehandler operation', [
  MobileEquipmentGoldPoint('Load travel', 'Keep the boom/load in the manufacturer-recommended travel configuration and avoid sudden steering or braking.'),
  MobileEquipmentGoldPoint('Visibility', 'Use approved cameras/mirrors and a banksman where visibility is restricted.'),
  MobileEquipmentGoldPoint('Forks', "Keep fork tines level and correctly engaged; never exceed the attachment's rating."),
  MobileEquipmentGoldPoint('Elevated loads', 'Do not travel or manoeuvre with elevated loads unless specifically permitted by the manufacturer and approved method.'),
  MobileEquipmentGoldPoint('Parking', 'Lower boom/attachment to the designated safe position, apply parking brake and isolate as required.')
]),
      MobileEquipmentGoldSection('Telehandler hazards', [
  MobileEquipmentGoldPoint('Forward instability', 'Excessive reach, heavy loads, sudden braking and poor ground conditions can move the combined centre of gravity outside the stability envelope.'),
  MobileEquipmentGoldPoint('Side instability', 'Cross-slope travel, uneven ground, turning with a raised boom and poor load placement increase overturn risk.'),
  MobileEquipmentGoldPoint('Attachment failure', 'Incorrect locking or incompatible attachments can cause sudden load release.'),
  MobileEquipmentGoldPoint('Overhead services', 'Boom movement can approach overhead conductors; establish and maintain the required site/service exclusion controls.'),
  MobileEquipmentGoldPoint('People near load', "Never permit people beneath suspended/elevated loads or inside the machine's hazard envelope.")
]),
      MobileEquipmentGoldSection('Telehandler field verification', [
  MobileEquipmentGoldPoint('Load chart check', 'Before each new load/task, confirm weight, centre of gravity, attachment and chart zone.'),
  MobileEquipmentGoldPoint('Ground check', 'Inspect soft ground, edges, ramps, trenches and underground void risks before entering the area.'),
  MobileEquipmentGoldPoint('Travel route', 'Confirm route width, overhead clearance, turning space, pedestrian segregation and emergency escape.'),
  MobileEquipmentGoldPoint('Attachment change', 'Reassess rated capacity and chart information after every attachment/configuration change.'),
  MobileEquipmentGoldPoint('Stop-work', 'Stop for unknown load weight, unclear chart applicability, unstable ground, failed restraint/safety device or loss of required visibility.')
])
    ],
  ),
  MobileEquipmentTopic(
    code: '5U',
    title: 'Excavator / Hydraulic Excavator',
    regulatoryBasis: 'ADPHC CoP 36.0 Plant & Equipment, CoP 39.0 Overhead & Underground Services, CoP 29.0 Excavation Work and applicable site controls.',
    sections: [
      MobileEquipmentGoldSection('Purpose, scope and field use', [
  MobileEquipmentGoldPoint('Purpose', 'Provide a field-ready control framework for safe selection, operation, inspection, maintenance and supervision of mobile plant and material-handling equipment.'),
  MobileEquipmentGoldPoint('Scope', 'Applies to equipment operators, banksmen/signallers, supervisors, HSE personnel, mechanics, lifting teams, logistics teams and contractors where the equipment is used.'),
  MobileEquipmentGoldPoint('Golden rule', 'Use only equipment that is suitable for the task, inspected, maintained, authorised for use and operated by a competent person.'),
  MobileEquipmentGoldPoint('Manufacturer instructions', 'Manufacturer operating limits, load charts, stability limits, attachments, exclusions and warnings form a critical part of the safe system of work.'),
  MobileEquipmentGoldPoint('Project interface', 'Follow the approved RAMS/JSA, traffic management plan, permit requirements, lifting plan where applicable, exclusion zones and site rules.')
]),
      MobileEquipmentGoldSection('Planning and risk assessment', [
  MobileEquipmentGoldPoint('Task assessment', 'Identify load, travel path, ground conditions, gradients, visibility, overhead services, underground services, pedestrians, other plant, weather and simultaneous operations.'),
  MobileEquipmentGoldPoint('Hierarchy of controls', 'Eliminate unnecessary plant movement first; then segregate people and machines; use engineered controls; administrative controls; PPE as the final layer.'),
  MobileEquipmentGoldPoint('Dynamic conditions', 'Reassess when ground, weather, load, attachment, route, visibility, work sequence or nearby activities change.'),
  MobileEquipmentGoldPoint('Exclusion zone', 'Define and physically control the plant operating envelope and keep unauthorised persons outside it.'),
  MobileEquipmentGoldPoint('Stop and reassess', 'Stop work when a critical control is missing, conditions become unsafe, equipment behaves abnormally or the operator cannot maintain safe control.')
]),
      MobileEquipmentGoldSection('Competency and authorisation', [
  MobileEquipmentGoldPoint('Operator', 'Operator competency must match the equipment type, attachment, task and site requirements; evidence of required training/authorisation must be available.'),
  MobileEquipmentGoldPoint('Familiarisation', 'Operators must understand the specific machine, controls, safety devices, limitations and emergency arrangements before use.'),
  MobileEquipmentGoldPoint('Banksman/signaller', 'Where required, use a competent banksman/signaller with a clear agreed communication system.'),
  MobileEquipmentGoldPoint('Supervision', 'Supervision must be proportionate to risk, operator experience, work complexity and site conditions.'),
  MobileEquipmentGoldPoint('Fitness', 'Do not operate while impaired by fatigue, alcohol, drugs, illness, distraction or any condition affecting safe operation.')
]),
      MobileEquipmentGoldSection('Pre-use inspection', [
  MobileEquipmentGoldPoint('Walk-around', 'Inspect structure, tyres/tracks, leaks, guards, steps, handrails, mirrors/cameras, lights, alarms, horn, seat belt, fire protection and visible damage.'),
  MobileEquipmentGoldPoint('Hydraulic systems', 'Check hoses, fittings, cylinders and connections for damage, abrasion, leakage or unsafe modification.'),
  MobileEquipmentGoldPoint('Controls', 'Confirm steering, brakes, service brake, parking brake, travel controls, attachment controls and emergency functions operate correctly.'),
  MobileEquipmentGoldPoint('Safety devices', 'Verify required interlocks, alarms, reversing aids, load indicators, cameras and other safety devices are present and functional.'),
  MobileEquipmentGoldPoint('Defects', 'Tag out and prevent use of equipment with a safety-critical defect until the defect is assessed and corrected by an authorised person.')
]),
      MobileEquipmentGoldSection('Work area and ground conditions', [
  MobileEquipmentGoldPoint('Ground capacity', 'Confirm the ground can safely support the machine and imposed loads, considering soft spots, voids, trenches, slabs, edges and underground services.'),
  MobileEquipmentGoldPoint('Slopes', 'Follow manufacturer limits and the approved method for slopes; avoid cross-slope travel where it creates instability.'),
  MobileEquipmentGoldPoint('Edges and excavations', 'Maintain a safe setback from excavations, unsupported edges and other collapse hazards based on competent assessment and site controls.'),
  MobileEquipmentGoldPoint('Housekeeping', 'Remove debris, loose materials and obstructions that can affect traction, steering, visibility or attachment stability.'),
  MobileEquipmentGoldPoint('Drainage', 'Control water accumulation and mud because saturated ground can reduce bearing capacity and braking/traction.')
]),
      MobileEquipmentGoldSection('People, traffic and segregation', [
  MobileEquipmentGoldPoint('Pedestrian segregation', 'Use physical barriers and defined pedestrian routes wherever practicable; do not rely only on verbal warnings.'),
  MobileEquipmentGoldPoint('Reversing', 'Avoid reversing where possible; when unavoidable, use a controlled system with suitable visibility aids and a competent banksman where required.'),
  MobileEquipmentGoldPoint('Blind spots', 'Assume that people may be hidden from the operator; stop if the operator loses visual confirmation of the intended path.'),
  MobileEquipmentGoldPoint('Speed', 'Operate at a safe site-approved speed appropriate to visibility, load, ground, traffic and manufacturer limitations.'),
  MobileEquipmentGoldPoint('Communication', 'Use one agreed signal system; stop immediately if signals are unclear or conflicting.')
]),
      MobileEquipmentGoldSection('Loading, attachments and stability', [
  MobileEquipmentGoldPoint('Correct attachment', 'Use only approved attachments compatible with the machine and task; secure them correctly and inspect locking mechanisms.'),
  MobileEquipmentGoldPoint('Load security', 'Keep loads stable, within equipment limits and positioned to preserve visibility and stability.'),
  MobileEquipmentGoldPoint('Centre of gravity', 'Understand how load position, boom/attachment geometry, height, travel direction and slope affect stability.'),
  MobileEquipmentGoldPoint('No improvised lifting', 'Do not use buckets, forks, hooks or other attachments for lifting unless specifically designed, approved and controlled for that purpose.'),
  MobileEquipmentGoldPoint('Overloading', 'Never exceed the applicable rated capacity, load chart, attachment rating or other limiting condition.')
]),
      MobileEquipmentGoldSection('Safe operating procedure', [
  MobileEquipmentGoldPoint('Start-up', 'Mount using designated access points, fasten restraints, check surroundings and start only when the area is clear.'),
  MobileEquipmentGoldPoint('Travel', 'Travel with the attachment/load in the manufacturer-recommended safe travel position and maintain control.'),
  MobileEquipmentGoldPoint('Stopping', 'Park in a safe designated area, lower attachments to a safe position, apply parking brake and isolate/shut down as required.'),
  MobileEquipmentGoldPoint('Unauthorised passengers', 'No passengers unless the machine is specifically designed and approved for them.'),
  MobileEquipmentGoldPoint('Leaving machine', 'Never leave an operating machine unattended; follow isolation and parking requirements before dismounting.')
]),
      MobileEquipmentGoldSection('Maintenance, isolation and emergency', [
  MobileEquipmentGoldPoint('Isolation', 'Before maintenance, isolate energy sources and prevent unexpected movement; use lockout/tagout where required by the site system.'),
  MobileEquipmentGoldPoint('Stored energy', 'Relieve hydraulic, pneumatic, electrical and mechanical stored energy before work on systems that could move or release energy.'),
  MobileEquipmentGoldPoint('Hot surfaces', 'Allow hot components to cool or use controlled procedures before inspection or maintenance.'),
  MobileEquipmentGoldPoint('Emergency', 'Operators must know emergency stop/shutdown, fire response, evacuation, recovery and site emergency communication arrangements.'),
  MobileEquipmentGoldPoint('Recovery', 'Do not improvise recovery of disabled plant; use an approved recovery method, suitable equipment and competent personnel.')
]),
      MobileEquipmentGoldSection('Field checklist and stop-work', [
  MobileEquipmentGoldPoint('Before use', 'Authorisation, inspection status, machine condition, attachment, route, ground, services, segregation, visibility, weather and emergency arrangements confirmed.'),
  MobileEquipmentGoldPoint('During use', 'Seat restraint used, controls maintained, people segregated, loads stable, speed controlled and no safety device bypassed.'),
  MobileEquipmentGoldPoint('Stop-work triggers', 'Uncontrolled pedestrian entry, loss of visibility, unstable ground, hydraulic/structural failure, brake/steering fault, overloaded condition, unsafe weather or failed safety-critical device.'),
  MobileEquipmentGoldPoint('Unsafe practices', 'Riding on attachments, bypassing interlocks, carrying people improperly, operating with known defects, exceeding capacity, using phones while driving and working too close to hazards without controls.'),
  MobileEquipmentGoldPoint('Corrective action', 'Stop, secure equipment, isolate if necessary, notify supervision/HSE, control the area and only resume after competent verification.')
]),
      MobileEquipmentGoldSection('Excavator fundamentals', [
  MobileEquipmentGoldPoint('Types', 'Hydraulic excavators vary by operating weight, tail swing, boom/stick arrangement and attachment; controls and limits are model-specific.'),
  MobileEquipmentGoldPoint('Attachment selection', 'Bucket, breaker, auger, grapple and other attachments require compatibility checks, hydraulic compatibility and approved procedures.'),
  MobileEquipmentGoldPoint('Excavation interface', 'Excavator work must be coordinated with excavation support, edge controls, underground services and spoil placement requirements.'),
  MobileEquipmentGoldPoint('Tail swing', 'Establish a physical exclusion zone around the tail swing and counterweight area.'),
  MobileEquipmentGoldPoint('Cab', 'Seat belt/restraint and required operator protective structures must be used; never operate with safety systems intentionally bypassed.')
]),
      MobileEquipmentGoldSection('Excavator digging controls', [
  MobileEquipmentGoldPoint('Services', 'Locate, verify and protect underground services before excavation; use the applicable permit/service control process.'),
  MobileEquipmentGoldPoint('Edge distance', 'Do not position the machine at excavation edges unless a competent assessment confirms ground stability and safe loading conditions.'),
  MobileEquipmentGoldPoint('Spoil', 'Place spoil and materials so they cannot surcharge the excavation edge or fall into the excavation.'),
  MobileEquipmentGoldPoint('Swing', 'Control swing radius and prevent buckets/attachments from passing over people or occupied areas.'),
  MobileEquipmentGoldPoint('Bucket release', 'Secure attachment connections and hydraulic quick couplers; verify locking before operation.')
]),
      MobileEquipmentGoldSection('Excavator hazards', [
  MobileEquipmentGoldPoint('Ground collapse', 'Machine surcharge, vibration, unsupported edges and poor soil conditions can contribute to excavation collapse.'),
  MobileEquipmentGoldPoint('Overhead contact', 'Boom and attachment can contact overhead services; maintain the required exclusion controls.'),
  MobileEquipmentGoldPoint('Dropped objects', 'Loose material on buckets/attachments can fall during swing or transport.'),
  MobileEquipmentGoldPoint('Striking people', 'Blind spots around the machine are significant; use segregation and controlled signalling.'),
  MobileEquipmentGoldPoint('Attachment energy', 'Breakers and other powered attachments introduce vibration, flying fragments and stored hydraulic energy.')
]),
      MobileEquipmentGoldSection('Excavator field verification', [
  MobileEquipmentGoldPoint('Digging plan', 'Confirm excavation limits, service drawings/locates, permit, support system and safe spoil location.'),
  MobileEquipmentGoldPoint('Operator checks', 'Verify travel, swing, hydraulics, attachment locking, alarms and cameras before work.'),
  MobileEquipmentGoldPoint('Bank edge', 'Maintain the project-approved safe setback and prevent machine movement into unsupported areas.'),
  MobileEquipmentGoldPoint('Breaker use', 'Use suitable exclusion zones, eye/face protection for exposed personnel and controls for flying fragments/noise/dust.'),
  MobileEquipmentGoldPoint('Recovery', 'Use a planned recovery method if tracks become stuck or machine becomes unstable; do not create a second hazard.')
])
    ],
  ),
  MobileEquipmentTopic(
    code: '5V',
    title: 'Backhoe Loader',
    regulatoryBasis: 'ADPHC CoP 36.0 Plant & Equipment, CoP 39.0 Overhead & Underground Services, CoP 29.0 Excavation Work and applicable site controls.',
    sections: [
      MobileEquipmentGoldSection('Purpose, scope and field use', [
  MobileEquipmentGoldPoint('Purpose', 'Provide a field-ready control framework for safe selection, operation, inspection, maintenance and supervision of mobile plant and material-handling equipment.'),
  MobileEquipmentGoldPoint('Scope', 'Applies to equipment operators, banksmen/signallers, supervisors, HSE personnel, mechanics, lifting teams, logistics teams and contractors where the equipment is used.'),
  MobileEquipmentGoldPoint('Golden rule', 'Use only equipment that is suitable for the task, inspected, maintained, authorised for use and operated by a competent person.'),
  MobileEquipmentGoldPoint('Manufacturer instructions', 'Manufacturer operating limits, load charts, stability limits, attachments, exclusions and warnings form a critical part of the safe system of work.'),
  MobileEquipmentGoldPoint('Project interface', 'Follow the approved RAMS/JSA, traffic management plan, permit requirements, lifting plan where applicable, exclusion zones and site rules.')
]),
      MobileEquipmentGoldSection('Planning and risk assessment', [
  MobileEquipmentGoldPoint('Task assessment', 'Identify load, travel path, ground conditions, gradients, visibility, overhead services, underground services, pedestrians, other plant, weather and simultaneous operations.'),
  MobileEquipmentGoldPoint('Hierarchy of controls', 'Eliminate unnecessary plant movement first; then segregate people and machines; use engineered controls; administrative controls; PPE as the final layer.'),
  MobileEquipmentGoldPoint('Dynamic conditions', 'Reassess when ground, weather, load, attachment, route, visibility, work sequence or nearby activities change.'),
  MobileEquipmentGoldPoint('Exclusion zone', 'Define and physically control the plant operating envelope and keep unauthorised persons outside it.'),
  MobileEquipmentGoldPoint('Stop and reassess', 'Stop work when a critical control is missing, conditions become unsafe, equipment behaves abnormally or the operator cannot maintain safe control.')
]),
      MobileEquipmentGoldSection('Competency and authorisation', [
  MobileEquipmentGoldPoint('Operator', 'Operator competency must match the equipment type, attachment, task and site requirements; evidence of required training/authorisation must be available.'),
  MobileEquipmentGoldPoint('Familiarisation', 'Operators must understand the specific machine, controls, safety devices, limitations and emergency arrangements before use.'),
  MobileEquipmentGoldPoint('Banksman/signaller', 'Where required, use a competent banksman/signaller with a clear agreed communication system.'),
  MobileEquipmentGoldPoint('Supervision', 'Supervision must be proportionate to risk, operator experience, work complexity and site conditions.'),
  MobileEquipmentGoldPoint('Fitness', 'Do not operate while impaired by fatigue, alcohol, drugs, illness, distraction or any condition affecting safe operation.')
]),
      MobileEquipmentGoldSection('Pre-use inspection', [
  MobileEquipmentGoldPoint('Walk-around', 'Inspect structure, tyres/tracks, leaks, guards, steps, handrails, mirrors/cameras, lights, alarms, horn, seat belt, fire protection and visible damage.'),
  MobileEquipmentGoldPoint('Hydraulic systems', 'Check hoses, fittings, cylinders and connections for damage, abrasion, leakage or unsafe modification.'),
  MobileEquipmentGoldPoint('Controls', 'Confirm steering, brakes, service brake, parking brake, travel controls, attachment controls and emergency functions operate correctly.'),
  MobileEquipmentGoldPoint('Safety devices', 'Verify required interlocks, alarms, reversing aids, load indicators, cameras and other safety devices are present and functional.'),
  MobileEquipmentGoldPoint('Defects', 'Tag out and prevent use of equipment with a safety-critical defect until the defect is assessed and corrected by an authorised person.')
]),
      MobileEquipmentGoldSection('Work area and ground conditions', [
  MobileEquipmentGoldPoint('Ground capacity', 'Confirm the ground can safely support the machine and imposed loads, considering soft spots, voids, trenches, slabs, edges and underground services.'),
  MobileEquipmentGoldPoint('Slopes', 'Follow manufacturer limits and the approved method for slopes; avoid cross-slope travel where it creates instability.'),
  MobileEquipmentGoldPoint('Edges and excavations', 'Maintain a safe setback from excavations, unsupported edges and other collapse hazards based on competent assessment and site controls.'),
  MobileEquipmentGoldPoint('Housekeeping', 'Remove debris, loose materials and obstructions that can affect traction, steering, visibility or attachment stability.'),
  MobileEquipmentGoldPoint('Drainage', 'Control water accumulation and mud because saturated ground can reduce bearing capacity and braking/traction.')
]),
      MobileEquipmentGoldSection('People, traffic and segregation', [
  MobileEquipmentGoldPoint('Pedestrian segregation', 'Use physical barriers and defined pedestrian routes wherever practicable; do not rely only on verbal warnings.'),
  MobileEquipmentGoldPoint('Reversing', 'Avoid reversing where possible; when unavoidable, use a controlled system with suitable visibility aids and a competent banksman where required.'),
  MobileEquipmentGoldPoint('Blind spots', 'Assume that people may be hidden from the operator; stop if the operator loses visual confirmation of the intended path.'),
  MobileEquipmentGoldPoint('Speed', 'Operate at a safe site-approved speed appropriate to visibility, load, ground, traffic and manufacturer limitations.'),
  MobileEquipmentGoldPoint('Communication', 'Use one agreed signal system; stop immediately if signals are unclear or conflicting.')
]),
      MobileEquipmentGoldSection('Loading, attachments and stability', [
  MobileEquipmentGoldPoint('Correct attachment', 'Use only approved attachments compatible with the machine and task; secure them correctly and inspect locking mechanisms.'),
  MobileEquipmentGoldPoint('Load security', 'Keep loads stable, within equipment limits and positioned to preserve visibility and stability.'),
  MobileEquipmentGoldPoint('Centre of gravity', 'Understand how load position, boom/attachment geometry, height, travel direction and slope affect stability.'),
  MobileEquipmentGoldPoint('No improvised lifting', 'Do not use buckets, forks, hooks or other attachments for lifting unless specifically designed, approved and controlled for that purpose.'),
  MobileEquipmentGoldPoint('Overloading', 'Never exceed the applicable rated capacity, load chart, attachment rating or other limiting condition.')
]),
      MobileEquipmentGoldSection('Safe operating procedure', [
  MobileEquipmentGoldPoint('Start-up', 'Mount using designated access points, fasten restraints, check surroundings and start only when the area is clear.'),
  MobileEquipmentGoldPoint('Travel', 'Travel with the attachment/load in the manufacturer-recommended safe travel position and maintain control.'),
  MobileEquipmentGoldPoint('Stopping', 'Park in a safe designated area, lower attachments to a safe position, apply parking brake and isolate/shut down as required.'),
  MobileEquipmentGoldPoint('Unauthorised passengers', 'No passengers unless the machine is specifically designed and approved for them.'),
  MobileEquipmentGoldPoint('Leaving machine', 'Never leave an operating machine unattended; follow isolation and parking requirements before dismounting.')
]),
      MobileEquipmentGoldSection('Maintenance, isolation and emergency', [
  MobileEquipmentGoldPoint('Isolation', 'Before maintenance, isolate energy sources and prevent unexpected movement; use lockout/tagout where required by the site system.'),
  MobileEquipmentGoldPoint('Stored energy', 'Relieve hydraulic, pneumatic, electrical and mechanical stored energy before work on systems that could move or release energy.'),
  MobileEquipmentGoldPoint('Hot surfaces', 'Allow hot components to cool or use controlled procedures before inspection or maintenance.'),
  MobileEquipmentGoldPoint('Emergency', 'Operators must know emergency stop/shutdown, fire response, evacuation, recovery and site emergency communication arrangements.'),
  MobileEquipmentGoldPoint('Recovery', 'Do not improvise recovery of disabled plant; use an approved recovery method, suitable equipment and competent personnel.')
]),
      MobileEquipmentGoldSection('Field checklist and stop-work', [
  MobileEquipmentGoldPoint('Before use', 'Authorisation, inspection status, machine condition, attachment, route, ground, services, segregation, visibility, weather and emergency arrangements confirmed.'),
  MobileEquipmentGoldPoint('During use', 'Seat restraint used, controls maintained, people segregated, loads stable, speed controlled and no safety device bypassed.'),
  MobileEquipmentGoldPoint('Stop-work triggers', 'Uncontrolled pedestrian entry, loss of visibility, unstable ground, hydraulic/structural failure, brake/steering fault, overloaded condition, unsafe weather or failed safety-critical device.'),
  MobileEquipmentGoldPoint('Unsafe practices', 'Riding on attachments, bypassing interlocks, carrying people improperly, operating with known defects, exceeding capacity, using phones while driving and working too close to hazards without controls.'),
  MobileEquipmentGoldPoint('Corrective action', 'Stop, secure equipment, isolate if necessary, notify supervision/HSE, control the area and only resume after competent verification.')
]),
      MobileEquipmentGoldSection('Backhoe loader fundamentals', [
  MobileEquipmentGoldPoint('Dual function', 'Backhoe loaders combine loader and excavator functions; stability and safe configuration change between tasks.'),
  MobileEquipmentGoldPoint('Stabilisers', 'When excavating, deploy stabilisers according to manufacturer instructions and ground conditions.'),
  MobileEquipmentGoldPoint('Loader bucket', 'Inspect bucket, linkage, pins, cylinders and attachment locking before loader operations.'),
  MobileEquipmentGoldPoint('Seat/controls', 'Use the designated operator position and restraint; change operating position only through the prescribed procedure.'),
  MobileEquipmentGoldPoint('Configuration', 'Keep unused attachments and stabilisers in the safe travel/working configuration specified by the manufacturer.')
]),
      MobileEquipmentGoldSection('Backhoe excavation controls', [
  MobileEquipmentGoldPoint('Service location', 'Verify underground services before digging and maintain required controls.'),
  MobileEquipmentGoldPoint('Stabiliser ground', 'Ensure stabiliser pads are fully supported and not placed over voids, soft ground or unsafe edges.'),
  MobileEquipmentGoldPoint('Swing zone', 'Segregate the backhoe swing area from pedestrians and other plant.'),
  MobileEquipmentGoldPoint('Loader travel', 'Carry the loader bucket in the recommended travel position and maintain visibility.'),
  MobileEquipmentGoldPoint('Edge work', 'Do not work close to unsupported edges without competent assessment and appropriate controls.')
]),
      MobileEquipmentGoldSection('Backhoe hazards', [
  MobileEquipmentGoldPoint('Machine movement', 'Unexpected movement can occur from poor stabiliser setup, uneven ground or incorrect hydraulic control.'),
  MobileEquipmentGoldPoint('Crush zones', 'Stabilisers, loader arms, bucket linkages and swing areas contain severe crush/pinch points.'),
  MobileEquipmentGoldPoint('Service strike', 'Digging can damage underground utilities and create electrical, gas, flooding or structural hazards.'),
  MobileEquipmentGoldPoint('Traffic interaction', 'Backhoes working near roads require approved traffic management and segregation.'),
  MobileEquipmentGoldPoint('Hydraulic failure', 'Attachment or stabiliser movement can occur if hydraulic components fail; isolate before maintenance.')
]),
      MobileEquipmentGoldSection('Backhoe field verification', [
  MobileEquipmentGoldPoint('Before digging', 'Confirm service information, permit, excavation controls, spoil placement and emergency arrangements.'),
  MobileEquipmentGoldPoint('Before loading', 'Confirm the truck/loading interface, level ground and people exclusion zone.'),
  MobileEquipmentGoldPoint('Stabiliser check', 'Recheck stabilisers after relocation or ground condition change.'),
  MobileEquipmentGoldPoint('Attachment change', 'Confirm correct locking and compatibility after changing attachments.'),
  MobileEquipmentGoldPoint('Stop-work', 'Stop for unknown services, ground instability, uncontrolled people, failed stabilisers, hydraulic defects or loss of visibility.')
])
    ],
  )
];
