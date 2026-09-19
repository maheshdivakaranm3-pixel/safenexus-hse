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

final List<MobileEquipmentTopic> abuDhabi5WTo5ZTopics = [
  MobileEquipmentTopic(
    code: '5W',
    title: 'Wheel Loader',
    regulatoryBasis: 'ADPHC CoP 36.0 Plant & Equipment plus applicable traffic, excavation, lifting, services and task-specific controls.',
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
      MobileEquipmentGoldSection('Wheel loader fundamentals', [
  MobileEquipmentGoldPoint('Machine envelope', 'Control front bucket, articulation joint and counterweight exclusion zones.'),
  MobileEquipmentGoldPoint('Articulation lock', 'Use the manufacturer-provided articulation locking device during maintenance/transport when required.'),
  MobileEquipmentGoldPoint('Bucket capacity', 'Do not exceed machine/attachment rated capacity or use unsuitable material/conditions.'),
  MobileEquipmentGoldPoint('Tyres', 'Inspect tyres, rims and wheel hardware; damaged tyres can cause loss of control or rollover.'),
  MobileEquipmentGoldPoint('Visibility', 'Manage bucket position, stockpile geometry and blind areas to maintain safe visibility.')
]),
      MobileEquipmentGoldSection('Wheel loader operations', [
  MobileEquipmentGoldPoint('Stockpile approach', 'Approach stockpiles squarely and avoid undercutting unstable faces.'),
  MobileEquipmentGoldPoint('Loading trucks', 'Coordinate loading position, keep people clear and avoid swinging the bucket over occupied areas.'),
  MobileEquipmentGoldPoint('Travel', 'Keep bucket in the recommended low travel position and control speed.'),
  MobileEquipmentGoldPoint('Articulation', 'Allow for articulation pinch zones and avoid sharp turns near people or structures.'),
  MobileEquipmentGoldPoint('Slope work', 'Follow manufacturer slope limitations and approved travel direction; avoid unstable cross-slope operation.')
]),
      MobileEquipmentGoldSection('Wheel loader hazards', [
  MobileEquipmentGoldPoint('Rollover', 'Uneven ground, excessive speed, raised loads, side slopes and unstable stockpiles increase rollover risk.'),
  MobileEquipmentGoldPoint('Falling material', 'Overfilled buckets or unstable loads can spill onto people, vehicles or structures.'),
  MobileEquipmentGoldPoint('Articulation crush', 'People can be trapped between front/rear frames or near wheels.'),
  MobileEquipmentGoldPoint('Stockpile collapse', 'Undercutting or working beneath unstable faces can release material.'),
  MobileEquipmentGoldPoint('Collision', 'Blind spots and busy loading zones require strong segregation and communication.')
]),
      MobileEquipmentGoldSection('Wheel loader field verification', [
  MobileEquipmentGoldPoint('Pre-start', 'Check articulation, tyres, hydraulics, bucket, brakes, alarms, cameras and restraint.'),
  MobileEquipmentGoldPoint('Stockpile check', 'Assess face stability, edge conditions and traffic routes before loading.'),
  MobileEquipmentGoldPoint('Truck interface', 'Confirm driver position, exclusion zone and agreed communication.'),
  MobileEquipmentGoldPoint('Maintenance', 'Isolate and secure the loader before accessing articulation or raised equipment.'),
  MobileEquipmentGoldPoint('Stop-work', 'Stop for unstable stockpile faces, failed brakes/steering, uncontrolled pedestrians or unsafe ground.')
])
    ],
  ),
  MobileEquipmentTopic(
    code: '5X',
    title: 'Bobcat / Skid Steer Loader',
    regulatoryBasis: 'ADPHC CoP 36.0 Plant & Equipment plus applicable traffic, excavation, lifting, services and task-specific controls.',
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
      MobileEquipmentGoldSection('Bobcat/skid steer fundamentals', [
  MobileEquipmentGoldPoint('Compact machine', 'Small size does not reduce risk; rapid movement and high attachment energy can cause severe injury.'),
  MobileEquipmentGoldPoint('Interlocked cab', 'Use the designed operator restraint/interlock system; never bypass safety interlocks.'),
  MobileEquipmentGoldPoint('Attachment', 'Verify attachment compatibility, locking and hydraulic connections before use.'),
  MobileEquipmentGoldPoint('Loader arms', 'Keep people outside loader-arm and bucket movement zones.'),
  MobileEquipmentGoldPoint('Visibility', 'Use cameras/alarms/spotters and segregation where visibility is restricted.')
]),
      MobileEquipmentGoldSection('Skid steer operations', [
  MobileEquipmentGoldPoint('Entry/exit', 'Lower attachment, stop, isolate as required and use designated access points; never climb beneath unsupported arms.'),
  MobileEquipmentGoldPoint('Arm support', "Use the manufacturer's mechanical lift-arm support device before working under raised arms."),
  MobileEquipmentGoldPoint('Travel', 'Keep load low and travel at a controlled speed.'),
  MobileEquipmentGoldPoint('Turning', 'Skid steering creates a swept path; keep pedestrians outside the turning envelope.'),
  MobileEquipmentGoldPoint('Attachment change', 'Relieve hydraulic pressure as required and positively lock the attachment.')
]),
      MobileEquipmentGoldSection('Bobcat hazards', [
  MobileEquipmentGoldPoint('Roll-over', 'Raised loads, slopes, sudden turns and unstable ground can cause rollover.'),
  MobileEquipmentGoldPoint('Crush', 'Loader arms can descend or move unexpectedly if energy is not isolated.'),
  MobileEquipmentGoldPoint('Ejection', 'Failure to use restraint can result in ejection during rollover or sudden movement.'),
  MobileEquipmentGoldPoint('Attachment energy', 'Augers, breakers, brooms and cutters create task-specific mechanical hazards.'),
  MobileEquipmentGoldPoint('Carbon monoxide', 'Do not operate combustion-engine equipment in poorly ventilated enclosed areas unless controls and monitoring make it safe.')
]),
      MobileEquipmentGoldSection('Bobcat field verification', [
  MobileEquipmentGoldPoint('Interlock test', 'Confirm required seat/bar/attachment interlocks operate correctly.'),
  MobileEquipmentGoldPoint('Work zone', 'Establish a small-machine exclusion zone despite compact dimensions.'),
  MobileEquipmentGoldPoint('Arm maintenance', 'Install the approved support device and isolate energy before entering danger zones.'),
  MobileEquipmentGoldPoint('Attachment controls', 'Review attachment-specific RAMS and PPE before changing task.'),
  MobileEquipmentGoldPoint('Stop-work', 'Stop for failed interlocks, people inside the swept path, unstable ground or loss of operator control.')
])
    ],
  ),
  MobileEquipmentTopic(
    code: '5Y',
    title: 'Bulldozer',
    regulatoryBasis: 'ADPHC CoP 36.0 Plant & Equipment plus applicable traffic, excavation, lifting, services and task-specific controls.',
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
      MobileEquipmentGoldSection('Bulldozer fundamentals', [
  MobileEquipmentGoldPoint('Blade types', 'Straight, universal, semi-U and angle blades change material handling and machine behaviour.'),
  MobileEquipmentGoldPoint('Track system', 'Inspect tracks, rollers, idlers, sprockets and track tension per manufacturer requirements.'),
  MobileEquipmentGoldPoint('Blade controls', 'Check hydraulic cylinders, pins, cutting edge and blade structure.'),
  MobileEquipmentGoldPoint('Rollover protection', 'Use the required protective structure and seat restraint.'),
  MobileEquipmentGoldPoint('Travel path', 'Survey slopes, edges, buried services, soft ground and other plant interfaces.')
]),
      MobileEquipmentGoldSection('Bulldozer operations', [
  MobileEquipmentGoldPoint('Push limits', "Use the manufacturer's operating method and do not exceed traction, slope or structural limitations."),
  MobileEquipmentGoldPoint('Edge work', 'Maintain approved setbacks from excavation edges, embankments and drop-offs.'),
  MobileEquipmentGoldPoint('Reversing', 'Minimise reversing and use effective visibility/spotter controls where required.'),
  MobileEquipmentGoldPoint('Blade position', 'Use a safe blade position for travel and maintain clear visibility.'),
  MobileEquipmentGoldPoint('Slope travel', 'Follow manufacturer limits; avoid unsafe side-slope manoeuvres and abrupt turns.')
]),
      MobileEquipmentGoldSection('Bulldozer hazards', [
  MobileEquipmentGoldPoint('Rollover', 'Slopes, edge failure, unstable fills and incorrect travel direction can cause rollover.'),
  MobileEquipmentGoldPoint('Blade strike', 'People near the blade or under a raised blade are at severe risk.'),
  MobileEquipmentGoldPoint('Ground failure', 'Dozing near edges or on recently placed fill can trigger collapse.'),
  MobileEquipmentGoldPoint('Collision', 'Large blind zones require segregation and controlled traffic.'),
  MobileEquipmentGoldPoint('Maintenance crush', 'Raised blades/tracks can move or settle; mechanically support and isolate before work.')
]),
      MobileEquipmentGoldSection('Bulldozer field verification', [
  MobileEquipmentGoldPoint('Fill assessment', 'Confirm material stability and compaction/ground conditions before pushing near edges.'),
  MobileEquipmentGoldPoint('Blade inspection', 'Check blade, cutting edge, cylinders and pins before operation.'),
  MobileEquipmentGoldPoint('Slope assessment', 'Confirm permitted machine orientation and travel route.'),
  MobileEquipmentGoldPoint('Isolation', 'Lower blade, isolate energy and install mechanical supports before maintenance.'),
  MobileEquipmentGoldPoint('Stop-work', 'Stop for edge instability, uncontrolled traffic, failed restraint/brakes or unsafe visibility.')
])
    ],
  ),
  MobileEquipmentTopic(
    code: '5Z',
    title: 'Motor Grader',
    regulatoryBasis: 'ADPHC CoP 36.0 Plant & Equipment plus applicable traffic, excavation, lifting, services and task-specific controls.',
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
      MobileEquipmentGoldSection('Motor grader fundamentals', [
  MobileEquipmentGoldPoint('Purpose', 'Motor graders perform fine grading, shaping, camber and surface preparation; their long frame and blade create a large swept envelope.'),
  MobileEquipmentGoldPoint('Blade geometry', 'Understand blade angle, pitch and side-shift effects on machine control and material flow.'),
  MobileEquipmentGoldPoint('Articulation', 'Articulation changes the machine envelope and must be controlled around people and structures.'),
  MobileEquipmentGoldPoint('Tyres', 'Inspect tyres, rims and wheel hardware before operation.'),
  MobileEquipmentGoldPoint('Visibility', 'Use mirrors/cameras and segregation to control blind areas.')
]),
      MobileEquipmentGoldSection('Motor grader operations', [
  MobileEquipmentGoldPoint('Grading route', 'Plan the route, turning areas, slope, drainage, traffic and edge conditions.'),
  MobileEquipmentGoldPoint('Blade clearance', 'Keep people and vehicles outside the blade/sideshift/swept zone.'),
  MobileEquipmentGoldPoint('Travel', 'Use a safe travel configuration and controlled speed.'),
  MobileEquipmentGoldPoint('Road interface', 'Coordinate with traffic management when working on or adjacent to live roads.'),
  MobileEquipmentGoldPoint('Slope work', 'Follow manufacturer limits and project controls for slopes and embankments.')
]),
      MobileEquipmentGoldSection('Motor grader hazards', [
  MobileEquipmentGoldPoint('Collision', 'Large swept areas and articulation create collision and crush risks.'),
  MobileEquipmentGoldPoint('Edge rollover', 'Working too close to road edges or embankments can cause ground failure and rollover.'),
  MobileEquipmentGoldPoint('Blade strike', 'Blade movement can injure workers during operation or maintenance.'),
  MobileEquipmentGoldPoint('Dust/noise', 'Grading can create airborne dust and high noise; apply task-specific controls.'),
  MobileEquipmentGoldPoint('Services', 'Grading can damage shallow/poorly identified services; verify service information before disturbance.')
]),
      MobileEquipmentGoldSection('Motor grader field verification', [
  MobileEquipmentGoldPoint('Pre-start', 'Check steering, articulation, brakes, tyres, blade, hydraulics, alarms, lights and restraint.'),
  MobileEquipmentGoldPoint('Traffic control', 'Confirm barriers, signs, spotters and approved traffic arrangements.'),
  MobileEquipmentGoldPoint('Edge assessment', 'Verify ground/embankment stability before grading near edges.'),
  MobileEquipmentGoldPoint('Blade maintenance', 'Lower/secure blade and isolate before inspection or repair.'),
  MobileEquipmentGoldPoint('Stop-work', 'Stop for loss of traffic segregation, unstable edges, failed steering/brakes or uncontrolled pedestrians.')
])
    ],
  )
];
