// lib/data/abu_dhabi/abu_dhabi_cop_45_46_47.dart
//
// SafeNexus HSE — Abu Dhabi HSE Reference
// CoP 45.0 / 46.0 / 47.0 — Gold Standard HSE Expanded
//
// Based on current ADPHC/ADOSH-SF CoP V4.1 requirements and
// supplementary HSE field-learning principles. Requirements are paraphrased.
// Existing AbuDhabiCopDocument / AbuDhabiCopSection API is preserved.
// UI/navigation is not changed.

import 'package:safenexus_hse/data/abu_dhabi/abu_dhabi_cop_01_to_03.dart';

class AbuDhabiCop45To47 {
  static final List<AbuDhabiCopDocument> documents = [cop45, cop46, cop47];

  static final AbuDhabiCopDocument cop45 = AbuDhabiCopDocument(
    code: 'CoP 45.0',
    title: 'Underwater Activities',
    version: '4.1',
    effectiveDate: '27 February 2026',
    introduction: 'CoP 45.0 establishes requirements for diving and related support operations in Abu Dhabi waters, including recreational, commercial and work-related diving. SafeNexus expands the regulatory framework into practical planning, field verification, competency, equipment, marine interface, emergency and interview-learning material.',
    sections: [
      AbuDhabiCopSection(
        number: "'45.1'",
        title: 'Underwater Activities — Fundamentals, Scope and Work Classification',
        requirements: ['Treat underwater work as a specialist operation requiring a planned diving system, competent personnel, suitable diving equipment and a dedicated emergency strategy.', 'CoP 45.0 applies to diving and related support operations in Abu Dhabi waters, including construction, general industry, recreational diving, commercial diving, ship repair, shipbuilding, shipbreaking and long-shoring.', 'Separate recreational diving/training arrangements from commercial diving controls. The work being performed and the depth/technique determine the competence and equipment needed.', 'Before mobilization identify whether the task is inspection, survey, construction, repair, welding/cutting, pipeline work, evidence/sample collection, photography, recovery or another specialist activity.'],
        hazards: ['Drowning', 'Decompression illness', 'Arterial gas embolism', 'Entrapment', 'Entanglement', 'Loss of breathing gas', 'Pressure injury', 'Cold/thermal stress', 'Poor visibility', 'Vessel movement', 'Dropped objects', 'Electrical or hydraulic energy'],
        documents: ['ADOSH-SF CoP 45.0 V4.1', 'Occupational Diving Program', 'Dive project plan', 'Task-specific risk assessment'],
        controls: ['Hierarchy of controls first; engineering and operational controls before relying on PPE.', 'Use a dedicated diving supervisor/competent person and defined communications.', 'Control interfaces with lifting, vessels, discharge, pressure testing, firefighting systems and other simultaneous operations.']
      ),
      AbuDhabiCopSection(
        number: "'45.2'",
        title: 'Training, Certification, Medical Fitness and Competency',
        requirements: ['All personnel must receive training appropriate to their duties, hazards, controls and emergency procedures.', 'Commercial diving work requires valid commercial diving certification appropriate to the work. Recreational diving services require recognised diving qualification/certification or an equivalent recognised qualification.', 'Competence must match the depth and actual operation; a diver qualified for one type of diving activity should not automatically be treated as competent for a different specialist operation.', 'Managers and supervisors must have the appropriate diving certification/qualification for the operation they supervise and appropriate first-aid capability.', 'Employers must arrange medical evaluation for divers before starting work and annually thereafter, by a physician familiar with diving hazards. Re-assessment is required where an obvious change in medical fitness occurs.', 'Maintain individual dive records/logbooks; the CoP requires employee daily dive records to be retained for a minimum of five years.'],
        hazards: ['Expired certification', 'Unverified medical fitness', 'Inadequate depth qualification', 'Inexperienced supervisor', 'Fatigue'],
        documents: ['Diving certificates', 'Medical fitness certificate', 'Training records', 'Daily dive log', 'Refresher training records']
      ),
      AbuDhabiCopSection(
        number: "'45.3'",
        title: 'Occupational Diving Program and Dive Project Plan',
        requirements: ['The employer shall establish an Occupational Diving Program covering competency, training, communication, pre-work assessment, emergency arrangements, incident reporting, medical surveillance, dive logging and equipment maintenance/testing.', 'Before commercial diving begins, prepare a diving project plan and update it when conditions change or new hazards are identified.', 'The project plan should identify the appointed competent diving supervisor, risk controls, diving technique, emergency contacts, medical facilities, Coast Guard interface, compressed-air quality testing and diver/surface communication arrangements.', 'Ensure all personnel understand the current plan and that changes are briefed before work continues.'],
        hazards: ['Uncontrolled change', 'Missing emergency contacts', 'Conflicting simultaneous operations', 'Inadequate communication'],
        documents: ['Diving project plan', 'Occupational Diving Program', 'Pre-dive briefing', 'Emergency response plan']
      ),
      AbuDhabiCopSection(
        number: "'45.4'",
        title: 'Diving Supervisor, Team Structure and Surface Support',
        requirements: ['Diving operations shall not proceed without a competent appointed diving supervisor.', 'Define who controls the dive, who tends/supports the diver, who monitors communications, who controls the worksite and who activates emergency response.', 'Do not plan diving as lone work. Ensure medical assistance is available when required.', 'Maintain clear command and communication between diver, surface team, vessel/site management and emergency services.', 'Stop the dive if the supervisor loses effective control of the operation or reliable communication.'],
        hazards: ['Diver separation', 'Communication loss', 'Uncontrolled vessel movement', 'Inadequate surface support'],
        documents: ['Dive team list', 'Duty roster', 'Communication test record', 'Emergency contact sheet']
      ),
      AbuDhabiCopSection(
        number: "'45.5'",
        title: 'Risk Assessment — Water, Environment, Plant and Interface Hazards',
        requirements: ['Assess tides, currents, visibility, water temperature, weather, sea state, marine traffic, seabed condition, entanglement hazards and access/egress.', 'Identify all energy sources and interfaces: lifting operations, scaffolding, pumps, valves, subsea pressure testing, electrical systems, hydraulic systems, propellers, thrusters, intakes and discharges.', 'Identify dropped-object potential from over-side work and prevent personnel or equipment from entering the dive zone unless controlled.', 'Where simultaneous operations cannot be avoided, apply formal interface controls and PTW controls as required by the worksite system.'],
        hazards: ['Current/sweep', 'Vessel collision', 'Propeller/jet hazard', 'Suction/intake', 'Dropped object', 'Subsea pressure release', 'Electrical energy', 'Contaminated water'],
        documents: ['Dive RA/JSA', 'SIMOPS/interface register', 'PTW', 'Marine exclusion plan']
      ),
      AbuDhabiCopSection(
        number: "'45.6'",
        title: 'Breathing Gas, Cylinders, Compressors and Equipment Integrity',
        requirements: ["Maintain all diving equipment according to manufacturer requirements and the diving organisation's applicable standards.", 'Verify cylinders, breathing-gas supply, hoses, regulators, masks/helmets, communications, bailout/emergency equipment and other life-support equipment before use.', "For operations deeper than 35 m, the CoP requires appropriate equipment and tested breathing gases meeting the applicable professional organisation's specifications.", 'Keep gas cylinders protected from damage and contamination and ensure identification and supply arrangements prevent incorrect gas use.', 'Do not use equipment with an unknown inspection, service or certification status.'],
        hazards: ['Gas contamination', 'Cylinder failure', 'Wrong gas', 'Hose failure', 'Loss of communications'],
        documents: ['Equipment inspection/service records', 'Gas test certificate', 'Cylinder records', 'Manufacturer maintenance instructions']
      ),
      AbuDhabiCopSection(
        number: "'45.7'",
        title: 'Depth, Decompression and Medical Emergency Controls',
        requirements: ['For diving operations deeper than 35 m, the CoP requires appropriate certification, equipment, tested breathing gases and access to a decompression chamber or bell with qualified medical staff within one hour, subject to the more stringent on-site requirements specified by the CoP for certain operations.', 'Recreational diving is limited to 40 m under the CoP; deeper recreational activities must follow commercial diving requirements.', 'Commercial operations must have emergency arrangements for decompression illness and identify a physician/medical facility capable of treating diving-related illness.', 'Include emergency evacuation route, communications, transport arrangements and hyperbaric treatment interface in the plan.'],
        hazards: ['Decompression illness', 'Barotrauma', 'Delayed medical treatment', 'Evacuation delay'],
        documents: ['Dive/decompression plan', 'Emergency medical agreement', 'Hyperbaric facility details', 'Emergency contact list']
      ),
      AbuDhabiCopSection(
        number: "'45.8'",
        title: 'Navigation, Dive Signals, Warning Notices and Exclusion Zones',
        requirements: ['Provide clear warning notices and signals so other water users understand that diving operations are underway.', 'Control vessel traffic and maintain the required navigation safety arrangements for the location and task.', 'Coordinate diving signals/communications with the vessel master, site manager and diving team before work begins.', 'Establish a clearly controlled dive zone and prevent unauthorised entry into the operating area.'],
        hazards: ['Collision', 'Propeller strike', 'Unauthorised entry', 'Dropped object'],
        documents: ['Diving warning signs/flags', 'Marine traffic plan', 'Exclusion-zone plan', 'Communication protocol'],
      ),
      AbuDhabiCopSection(
        number: "'45.9'",
        title: 'Emergency Response, Diver Recovery and Rescue',
        requirements: ['Pre-plan lost diver, unconscious diver, entanglement, gas-supply failure, decompression illness, vessel movement, fire and medical evacuation scenarios.', 'Provide arrangements for rapid recovery of an injured diver, first aid and medical treatment.', 'Emergency contacts should include relevant emergency services, medical facilities, Coast Guard and diving-competent medical support as applicable.', 'Conduct drills appropriate to the operation and equipment so the team can execute the plan under pressure.'],
        hazards: ['Delayed rescue', 'Unconscious diver', 'Entrapment', 'Gas failure', 'Fire/abandonment', 'Decompression emergency'],
        documents: ['Emergency response plan', 'Rescue drill records', 'First-aid arrangements', 'Medical evacuation route']
      ),
      AbuDhabiCopSection(
        number: "'45.10'",
        title: 'Pre-Dive Field Checklist and Stop-Work Verification',
        requirements: ['Confirm permits/licences, competent supervisor, diver certifications, medical fitness, equipment inspection, gas testing, weather/tide/current, communications, exclusion zone, SIMOPS controls and emergency arrangements.', 'Reconfirm the risk assessment at the worksite on the day of the dive and whenever conditions change.', 'Record the dive and report defects or incidents according to the occupational diving programme.']
      ),
    ],
    fieldChecklist: ['Competent diving supervisor appointed', 'Diver certification and depth/task competency verified', 'Medical fitness current', 'Dive project plan and task RA approved', 'Equipment/cylinders/gas checks complete', 'Weather/tide/current/visibility checked', 'Marine exclusion zone established', 'Communications tested', 'SIMOPS/PTW controls confirmed', 'Emergency/hyperbaric medical arrangements confirmed'],
    stopWorkIndicators: ['No competent diving supervisor', 'Expired/invalid certification or medical fitness', 'Loss of diver-surface communication', 'Uncontrolled vessel movement', 'Uncontrolled over-side lifting/discharge/pressure testing', 'Breathing-gas uncertainty or equipment defect', 'Weather/current/visibility outside approved limits', 'Emergency rescue or medical arrangements unavailable'],
    references: ['ADPHC/ADOSH-SF CoP 45.0 Underwater Activities V4.1', 'ADPHC Element 2 Risk Management', 'ADPHC Element 5 Training, Awareness and Competency', 'ADPHC CoP 2.0 Personal Protective Equipment', 'ADPHC CoP 4.0 First Aid and Medical Emergency Treatment', 'ADPHC CoP 30.0 Lone Work and/or in Remote Locations', 'IMCA or equivalent recognised diving-industry practice where applicable', 'UK HSE diving guidance as supplementary learning reference'],
    verificationNote: 'Regulatory requirements take priority. Depth-, gas-, vessel- and task-specific controls must be verified against the official current CoP and applicable authority requirements before field use.',
    protectionItems: ['Dive helmet/mask or approved breathing apparatus', 'Wetsuit/drysuit as task/environment requires', 'Diving knife/entanglement tool where justified', 'Buoyancy and weighting system', 'Communication system', 'Emergency/bailout equipment as required', 'Approved life-support and breathing-gas equipment'],
  );

  static final AbuDhabiCopDocument cop46 = AbuDhabiCopDocument(
    code: 'CoP 46.0',
    title: 'Underground Construction',
    version: '4.1',
    effectiveDate: '27 February 2026',
    introduction: 'CoP 46.0 addresses underground construction risks including ground instability, services, communication, access/egress, heat, first aid, evacuation, fire, noise, ventilation, lighting, atmospheric hazards, lifting, shaft sinking, pipe jacking, ground support and piling. SafeNexus presents these as field study and verification modules.',
    sections: [
      AbuDhabiCopSection(
        number: "'46.1'",
        title: 'Underground Construction — Fundamentals and Scope',
        requirements: ['Treat underground construction as a continuously changing risk environment involving ground stability, atmosphere, water, fire, plant, lifting, access and emergency evacuation.', 'CoP 46.0 covers underground construction activities and provides requirements for planning, communication, access/egress, heat, first aid, evacuation, fire, noise, ventilation, lighting, atmosphere, lifting, shaft sinking, pipe jacking, ground support and piling.', 'Before work begins, establish the construction method, site boundaries, services, ground conditions, adjacent structures, water sources and emergency arrangements.'],
        hazards: ['Ground collapse', 'Flooding', 'Gas', 'Fire', 'Poor ventilation', 'Plant strike', 'Falling objects', 'Confined-space hazards'],
        documents: ['Competent-person assessment', 'Safe system of work', 'Site survey', 'Emergency plan'],
      ),
      AbuDhabiCopSection(
        number: "'46.2'",
        title: 'Training, Competency and Site-Specific Induction',
        requirements: ['Train workers to recognise and respond to underground hazards and site-specific conditions.', 'Training should cover identified hazards, prohibited activities, confined-space operations, safe methods, air monitoring, ventilation, access/egress, illumination, communications, flood control, PPE, emergency evacuation, check-in/check-out, fire protection and mechanical equipment.', 'Maintain training records identifying worker, Emirates ID, subjects, provider, dates and trainer.'],
        hazards: ['Untrained entry', 'Communication failure', 'Incorrect emergency response'],
        documents: ['Training matrix', 'Competency records', 'Site induction', 'Emergency drill records'],
      ),
      AbuDhabiCopSection(
        number: "'46.3'",
        title: 'Roles, Responsibilities and Competent Supervision',
        requirements: ['Before underground construction begins, a competent person must assess the work and required controls.', 'Prepare documented safe systems of work and systematically plan the construction method.', 'Survey the site, confirm alignments and boundaries, obtain drawings/maps/specifications, validate service searches and consider historical, archaeological and geological constraints.', 'Obtain required permits, authorisations and notifications and nominate a competent person to supervise the work.'],
        hazards: ['Uncontrolled work method', 'Unknown services', 'Inadequate supervision', 'Interface with adjacent property'],
        documents: ['Approved method statement', 'Permit/authorisation', 'Survey drawings', 'Competent-person appointment'],
      ),
      AbuDhabiCopSection(
        number: "'46.4'",
        title: 'Planning, Site Survey, Services Search and Validation Area',
        requirements: ['Validate all known and suspected underground services before excavation or underground construction.', 'Where service-owner validation areas overlap, treat the combined area as the controlled validation area.', 'Complete a validation-area risk assessment with the client/asset owner and incorporate the controls into the documented safe system of work.', 'Consider adjacent properties and the effect of underground works on neighbouring structures.'],
        hazards: ['Utility strike', 'Electric shock', 'Gas release', 'Water ingress', 'Structural damage'],
        documents: ['Service drawings', 'Service-owner information', 'Detection/locating records', 'Validation-area RA']
      ),
      AbuDhabiCopSection(
        number: "'46.5'",
        title: 'Communication, Above-Ground Controller and Check-In/Check-Out',
        requirements: ['Whenever personnel are underground, maintain at least one designated person above ground.', 'The designated person maintains an accurate count of personnel underground and prevents unauthorised access.', 'The designated person must be capable of summoning emergency assistance immediately.', 'Where voice communication is ineffective, use a power-assisted communication system between the work face, shaft bottom and surface.', 'Use agreed audible/visual signals for shaft lifting and machine operations; signals to machine operators must be given by competent banksmen.'],
        hazards: ['Lost person', 'Communication loss', 'Unauthorised entry', 'Incorrect lifting signal'],
        documents: ['Check-in/out register', 'Radio/communication test', 'Signal code', 'Emergency call procedure']
      ),
      AbuDhabiCopSection(
        number: "'46.6'",
        title: 'No Lone Working, Access and Egress',
        requirements: ['Lone working is not permitted underground; use at least two persons with an intrinsically safe means of communication.', 'Maintain safe access and egress from all underground areas.', 'Unused openings must be securely covered, bulkheaded, barricaded or fenced and posted with warning signs.', 'Design access around plant movement, lifting operations, emergency evacuation and casualty recovery.'],
        hazards: ['Entrapment', 'Falls', 'Plant strike', 'Unauthorised entry'],
        documents: ['Access plan', 'Egress route', 'Barricade inspection', 'Personnel register'],
      ),
      AbuDhabiCopSection(
        number: "'46.7'",
        title: 'Heat Stress, Welfare and Fatigue',
        requirements: ['Use mechanisation, ventilation and job rotation to reduce heat stress and exhaustion.', 'Provide cold potable water and apply the applicable Abu Dhabi heat-stress requirements.', 'Consider underground temperature, humidity, work intensity, clothing, respiratory equipment, travel distance and recovery time.', 'Include fatigue controls in shift planning and monitor workers for signs of heat illness.'],
        hazards: ['Heat exhaustion', 'Heat stroke', 'Dehydration', 'Fatigue'],
        documents: ['Heat-stress plan', 'Potable-water arrangement', 'Work/rest schedule'],
      ),
      AbuDhabiCopSection(
        number: "'46.8'",
        title: 'First Aid, Casualty Handling and Evacuation',
        requirements: ['Provide competent first-aiders on each shift and first-aid equipment suitable for underground conditions.', 'Provide stretchers appropriate for confined tunnel spaces and keep them accessible and protected from damp/dirt.', 'Provide a means of transporting an injured person to the surface; shaft lifting arrangements must account for casualty transport.', 'Plan ambulance access to shaft tops or other emergency access points.'],
        hazards: ['Delayed casualty evacuation', 'Manual handling injury', 'Limited shaft access'],
        documents: ['First-aid kit', 'Tunnel stretcher', 'Casualty transport plan', 'Emergency access route'],
      ),
      AbuDhabiCopSection(
        number: "'46.9'",
        title: 'Fire Prevention and Fire Emergency Controls',
        requirements: ['Prohibit open flames and smoking underground except controlled hot-work activities permitted by the safe system.', 'Provide fire extinguishing means at the head and work areas.', 'Control combustible/flammable materials near underground access points and ensure storage arrangements are suitable.', 'Petrol must not be kept underground. Control oil, grease and diesel in sealed containers and designated fire-resistant arrangements.', 'Control oxygen and fuel-gas cylinders for hot work according to the CoP and approved hot-work system.'],
        hazards: ['Fire', 'Smoke', 'Fuel ignition', 'Gas explosion', 'Blocked escape'],
        documents: ['Hot-work permit', 'Fire plan', 'Extinguisher inspection', 'Fuel/gas storage plan'],
      ),
      AbuDhabiCopSection(
        number: "'46.10'",
        title: 'Ventilation, Air Quality and Hazardous Atmospheres',
        requirements: ['Design ventilation to provide suitable air quality and remove contaminants, fumes, dust and heat.', 'Where methane is reasonably foreseeable, ventilation design must account for methane hazards; continuously monitor methane in relevant extraction ducts and use explosion-protected fans where required.', 'Atmospheric monitoring should be based on the hazards identified in the risk assessment and confined-space controls where applicable.', 'Prevent vehicle and plant exhaust from accumulating in work areas.'],
        hazards: ['Oxygen deficiency', 'Toxic gases', 'Methane', 'Diesel exhaust', 'Dust', 'Heat'],
        documents: ['Ventilation calculations', 'Gas-monitoring records', 'Fan inspection', 'Air-quality plan'],
      ),
      AbuDhabiCopSection(
        number: "'46.11'",
        title: 'Dust, Noise and Occupational Health',
        requirements: ['Suppress tunnel dust at source using suitable methods such as wet drilling, water spraying, water infusion or extraction ventilation.', 'Maintain ventilation and extraction systems and control dust migration.', 'For dusty conditions, the CoP specifies a minimum air velocity of 0.5 m/s in relevant tunnel sections when using extraction ventilation to prevent back-migration; verify the engineering calculation for the actual system.', 'Assess noise exposure from drilling, excavation, ventilation and mechanical plant and apply hearing controls.'],
        hazards: ['Respirable dust', 'Silica exposure', 'Noise-induced hearing loss', 'Vibration'],
        documents: ['Dust-control plan', 'Air monitoring', 'Noise assessment', 'PPE/RPE records']
      ),
      AbuDhabiCopSection(
        number: "'46.12'",
        title: 'Lighting and Emergency Lighting',
        requirements: ['Provide lighting sufficient to identify hazards and work safely, with higher local lighting at machinery and active work areas.', 'The CoP gives recommended mean levels of at least 10 lux at walkways and 100 lux at general working surfaces; tunnel face/excavation/crane lifting areas require 100 lux illuminated from at least two widely separated sources to reduce shadows.', 'Use explosion-protected lighting where explosive atmospheres may exist.', 'Emergency lighting and backup power must allow personnel to take appropriate action during loss of normal power.'],
        hazards: ['Poor visibility', 'Trip/fall', 'Machinery strike', 'Explosion ignition'],
        documents: ['Lighting plan', 'Lux measurements', 'Emergency lighting test'],
      ),
      AbuDhabiCopSection(
        number: "'46.13'",
        title: 'Atmospheric Conditions, Flooding and Changing Ground',
        requirements: ['Monitor changing ground, water, rainfall, tidal levels and atmospheric conditions.', 'Record and communicate abnormal ground movement, collapse, flooding, fire, equipment failure and gas release to incoming shifts.', 'Provide flood-control measures appropriate to the excavation and water sources.', 'Stop or evacuate where ground movement, water ingress, gas or other conditions exceed the safe system.'],
        hazards: ['Flooding', 'Sudden ground movement', 'Gas release', 'Loss of support'],
        documents: ['Ground-monitoring records', 'Water-control plan', 'Shift handover log', 'Trigger/action plan'],
      ),
      AbuDhabiCopSection(
        number: "'46.14'",
        title: 'Lifting Equipment and Shaft Operations',
        requirements: ['Use suitable lifting equipment for shaft sinking and underground material/personnel movement.', 'Control lifting signals, exclusion zones, equipment inspection and communication.', 'Where shaft lifting is used for emergency casualty transport, ensure the lifting arrangement is compatible with the rescue plan.', 'Do not allow unauthorised persons into lifting zones.'],
        hazards: ['Dropped load', 'Personnel fall', 'Shaft collision', 'Signal failure'],
        documents: ['Lift plan', 'Lifting equipment certificates', 'Signal chart', 'Exclusion-zone plan'],
      ),
      AbuDhabiCopSection(
        number: "'46.15'",
        title: 'Shaft Sinking, Ground Support, Pipe Jacking and Piling',
        requirements: ['Treat shaft sinking as a specialist activity requiring engineered sequencing, ground-support controls, safe access and controlled lifting.', 'Ground-support systems must be selected, installed, inspected and maintained in accordance with the engineered design and changing ground conditions.', 'Pipe jacking requires control of ground movement, equipment interfaces, access, communication, ventilation, rescue and stored energy.', 'Piling operations require control of plant stability, lifting, suspended loads, exclusion zones, overhead services and adjacent structures.'],
        hazards: ['Collapse', 'Entanglement', 'Crushing', 'Stored energy', 'Ground movement', 'Plant overturn'],
        documents: ['Engineered temporary works', 'Ground-support inspection', 'Pipe-jacking method', 'Piling method statement'],
      ),
      AbuDhabiCopSection(
        number: "'46.16'",
        title: 'Emergency Rescue, Evacuation Drill and Field Verification',
        requirements: ['Maintain a realistic evacuation and rescue plan for fire, gas, flooding, collapse, power failure, casualty and communication loss.', 'Ensure emergency routes remain clear and personnel accountability can be established at all times.', 'Conduct drills appropriate to the underground configuration and review lessons learned.', 'Before each shift verify access, communication, ventilation, lighting, water control, first aid, emergency equipment and personnel count.'],
        hazards: ['Mass evacuation', 'Trapped worker', 'Fire/smoke', 'Flooding', 'Gas release', 'Power failure'],
        documents: ['Emergency drill record', 'Muster/accountability list', 'Rescue equipment inspection', 'Shift checklist'],
      ),
    ],
    fieldChecklist: ['Competent assessment completed', 'Approved safe system of work', 'Services searched and validated', 'Two-person minimum/no lone working underground', 'Above-ground designated person on duty', 'Check-in/check-out active', 'Communication tested', 'Ventilation and atmospheric monitoring ready', 'Lighting measured/adequate', 'Water/flood controls ready', 'First aid/stretchers/casualty transport ready', 'Emergency evacuation plan briefed', 'Fire controls and extinguishers ready', 'Ground support inspected'],
    stopWorkIndicators: ['Ground movement/collapse', 'Flooding or abnormal water/tidal condition', 'Gas release or unsafe atmosphere', 'Ventilation failure', 'Communication failure', 'Unauthorised entry', 'Lighting below required safe level', 'Fire/smoke', 'Loss of ground support', 'Unsafe lifting/shaft operation'],
    references: ['ADPHC/ADOSH-SF CoP 46.0 Underground Construction V4.1', 'ADPHC CoP 27.0 Confined Spaces where applicable', 'ADPHC CoP 30.0 Lone Work and/or in Remote Locations', 'ADPHC CoP 11.0 Safety in the Heat', 'ADPHC CoP 17.0 Safety Signage and Signals', 'ADPHC CoP 34.0 Lifting Equipment and Lifting Accessories', 'HSE HSG47 Avoiding Danger from Underground Services', 'HSE underground construction/temporary works guidance'],
    verificationNote: 'The 0.5 m/s dust-control ventilation value and 10/100 lux values are specific CoP 46 field values. They must not be generalised to unrelated work; verify the official table and engineering design for the actual installation.',
    protectionItems: ['Gas monitor', 'Escape breathing apparatus where required by hazard assessment', 'Intrinsically safe communication', 'Cap/hand lamps', 'Tunnel stretcher', 'First-aid equipment', 'Fire extinguishers', 'PPE/RPE appropriate to hazard', 'Fall protection for shafts/edges'],
  );

  static final AbuDhabiCopDocument cop47 = AbuDhabiCopDocument(
    code: 'CoP 47.0',
    title: 'Machine Guarding',
    version: '4.1',
    effectiveDate: '27 February 2026',
    introduction: 'CoP 47.0 establishes requirements for assessing machinery guarding risks and implementing controls through the hierarchy of controls. SafeNexus expands this into practical guarding inspection, reach-distance verification, safe servicing, defect control, examples and interview preparation.',
    sections: [
      AbuDhabiCopSection(
        number: "'47.1'",
        title: 'Machine Guarding Fundamentals and Scope',
        requirements: ['Machine guarding protects operators and other persons from dangerous machine parts, point-of-operation hazards, rotating stock-bars, in-running nip points, flying chips and sparks.', 'CoP 47.0 applies to employers in Abu Dhabi and requires machinery risks to be assessed and controls implemented using the hierarchy of controls.', 'Guarding is not only an operator issue; maintenance personnel, cleaners, contractors, visitors and anyone entering the machine area must be considered.'],
        hazards: ['Entanglement', 'Crushing', 'Shearing', 'Cutting', 'Drawing-in/nip', 'Impact', 'Ejected material', 'Burns'],
        documents: ['Machine risk assessment', 'Manufacturer manual', 'Guarding inspection record'],
      ),
      AbuDhabiCopSection(
        number: "'47.2'",
        title: 'Training, Competency and Authorisation',
        requirements: ['Anyone using work equipment must receive appropriate health and safety training covering the method of use, risks and precautions.', 'Supervisors/managers responsible for equipment use require appropriate training.', 'Workers must not access dangerous parts unless authorised and the machine has been made safe.', 'Defects must be reported immediately and defective machinery marked out of use until made safe.'],
        hazards: ['Untrained operator', 'Unsafe intervention', 'Bypassed guard'],
        documents: ['Training records', 'Authorisation list', 'Operator instructions'],
      ),
      AbuDhabiCopSection(
        number: "'47.3'",
        title: 'Risk Assessment and Machinery Hazard Identification',
        requirements: ['Assess each machine and operation, including installation, normal operation, adjustment, cleaning, blockage clearing, maintenance, testing and foreseeable misuse.', 'Consider everyone who may be affected, not only the operator.', 'Identify point-of-operation hazards, rotating parts, nip points, belts, chains, gears, shafts, blades, cutting tools, hot surfaces, ejected material and stored energy.', 'Review risk assessments when equipment, process, tooling or guarding changes.'],
        hazards: ['Point of operation', 'Rotating parts', 'Nip points', 'Flying chips/sparks', 'Stored energy'],
        documents: ['Machine-specific RA', 'JSA/SWP', 'Change-control record'],
      ),
      AbuDhabiCopSection(
        number: "'47.4'",
        title: 'Hierarchy of Guarding Controls',
        requirements: ['Where practicable, use fixed guards to enclose dangerous parts.', 'Where fixed guarding is not practicable, use other guards or protective devices such as interlocks, automatic guards, distance guards, trip devices or presence-sensing systems.', 'Use jigs, holders, push-sticks or similar appliances where appropriate.', 'Information, instruction, training and PPE are supporting controls and should not be used as a substitute for practicable physical safeguarding.'],
        hazards: ['Guard bypass', 'Access to moving parts', 'Residual risk'],
        documents: ['Guard design review', 'Interlock test', 'Safety-device test'],
      ),
      AbuDhabiCopSection(
        number: "'47.5'",
        title: 'Types of Guards — Fixed, Interlocking, Automatic, Distance and Trip',
        requirements: ['Fixed guards form a physical barrier and should be secure.', 'Interlocking guards prevent operation unless the guard is in the safe position; the interlock must be reliable and not easily defeated.', 'Automatic/push-away guards may be suitable only for appropriate slow-machine applications.', 'Distance guards use barriers/fences to prevent access; access gates/doors require suitable locking or interlocking.', 'Trip/presence-sensing systems such as photoelectric curtains, laser scanners and pressure mats can stop machinery when a person enters a dangerous position.'],
        hazards: ['Interlock failure', 'Defeat/bypass', 'Inadequate distance', 'Trip-device failure'],
        documents: ['Guard type selection', 'Interlock inspection', 'Safety-device test'],
      ),
      AbuDhabiCopSection(
        number: "'47.6'",
        title: 'Guard Design Quality and Materials',
        requirements: ['A guard must be strong enough, suitable for the machine and compatible with the work process.', 'Poorly designed guarding can create new hazards, obstruct safe work or encourage bypassing.', 'Where an existing guard is transferred to another machine, verify fit, strength, condition and effectiveness for the new application.', 'Consider heat, dust, noise, ventilation, wear, visibility and maintenance access when designing guards.'],
        hazards: ['Weak guard', 'Sharp edges', 'Poor visibility', 'Overheating', 'Bypass due to inconvenience'],
        documents: ['Guard design drawing', 'Manufacturer instructions', 'Engineering approval'],
      ),
      AbuDhabiCopSection(
        number: "'47.7'",
        title: 'Guard Placement, Reach and Minimum Clearances',
        requirements: ['Guard positioning must prevent a person from reaching the danger point through or around the guard.', 'The CoP table gives minimum assumed reach distances: arm reach at least 850 mm; elbow reach at least 550 mm; wrist reach at least 230 mm; finger reach at least 130 mm; vertical reach up to 2500 mm when standing on toes.', "For mesh/openings up to and including 9 mm, the guard can be very close to the danger point; openings over 9 mm and less than 40 mm require the CoP's specified separation, including at least 200 mm in the stated range.", 'The bottom opening between the guard and floor must not exceed 250 mm.', 'Use the complete CoP tables for barrier geometry rather than applying one generic clearance to every machine.'],
        hazards: ['Reach-through', 'Reach-over', 'Reach-under', 'Mesh opening access'],
        documents: ['Guarding measurement record', 'CoP Table 1/2/3/4', 'Engineering verification']
      ),
      AbuDhabiCopSection(
        number: "'47.8'",
        title: 'Point of Operation and Common Machinery Hazards',
        requirements: ['Guard every point of operation where exposure could cause injury.', 'Control in-running nip points at rollers, belts, chains, gears and rotating shafts.', 'Control flying chips, sparks and ejected materials with suitable guarding/deflection.', 'Prevent access to blades, cutters, saws, presses, shears and rotating tools during normal operation.'],
        hazards: ['Amputation', 'Crushing', 'Laceration', 'Eye injury', 'Impact'],
        documents: ['Machine-specific guarding checklist', 'Tooling inspection', 'Operator pre-start check'],
      ),
      AbuDhabiCopSection(
        number: "'47.9'",
        title: 'Servicing, Cleaning, Jam Clearing and Safe Stop',
        requirements: ['Design guards so they can be safely removed and replaced for maintenance, cleaning and adjustment.', 'Guard removal must be controlled by a safe procedure and the machine must not be operating when guards are opened/removed.', 'Apply isolation/lockout provisions before clearing jams or accessing dangerous parts.', 'Consider hot/sharp parts, cool-down periods, working space, solvents, work at height and testing with guards removed.', 'After maintenance, reinstall guards and verify safety devices before return to service.'],
        hazards: ['Unexpected start-up', 'Stored energy', 'Sharp/hot parts', 'Restart with guard removed'],
        documents: ['LOTO/isolation procedure', 'Maintenance permit', 'Guard reinstatement check', 'Servicing record']
      ),
      AbuDhabiCopSection(
        number: "'47.10'",
        title: 'Inspection, Testing, Maintenance and Defect Control',
        requirements: ['Inspect guards and guarding devices regularly and maintain them in effective working order according to manufacturer requirements.', 'Test interlocks, emergency stops and presence-sensing devices as specified by the machine/system requirements.', 'Do not operate equipment when required guarding is missing, damaged, defeated or ineffective.', 'Mark defective machinery out of use and prevent unauthorised restart until repaired and verified.'],
        hazards: ['Guard damage', 'Interlock failure', 'Emergency-stop failure', 'Unauthorised restart'],
        documents: ['Inspection register', 'Maintenance record', 'Defect tag', 'Functional test record'],
      ),
      AbuDhabiCopSection(
        number: "'47.11'",
        title: 'Supervisor/HSE Verification — Field Inspection',
        requirements: ['Check every accessible dangerous part against the risk assessment.', 'Confirm guards are physically secure, correctly positioned and not easily defeated.', 'Check interlocks and trip systems where provided.', 'Look for improvised openings, removed panels, loose bolts, damaged mesh, bypassed switches and temporary modifications.', 'Observe actual work practices; a technically correct guard is ineffective if workers routinely bypass it.'],
        hazards: ['Bypassed guard', 'Improvised modification', 'Unauthorised access', 'Unsafe work practice'],
        documents: ['Daily/weekly inspection', 'Observation report', 'Corrective action tracker'],
      ),
      AbuDhabiCopSection(
        number: "'47.12'",
        title: 'Practical Examples — Grinder, Conveyor, Drill Press, Saw and Mixer',
        requirements: ['Bench grinder: control wheel exposure, tool-rest arrangement, spark direction and access to rotating parts.', 'Conveyor: guard nip points at rollers, drive systems and return points; control access during maintenance.', 'Drill press: prevent contact with rotating spindle/chuck and secure the workpiece; isolate before adjustment.', 'Circular saw: guard the blade and control access to the cutting zone; use suitable push devices where applicable.', 'Concrete mixer: guard drive, gears, belts and rotating components; isolate before clearing hardened material.'],
        hazards: ['Entanglement', 'Drawing-in', 'Contact with blade', 'Ejection', 'Crushing'],
        documents: ['Machine-specific SOP', 'Manufacturer manual', 'Pre-use inspection'],
      ),
      AbuDhabiCopSection(
        number: "'47.13'",
        title: 'Wrong vs Safe Practice, Stop-Work and Quick Revision',
        requirements: ['Wrong: guard removed because it slows production. Safe: stop the machine and correct the guarding before operation.', 'Wrong: interlock taped or defeated. Safe: repair the safety system and investigate why it was being bypassed.', 'Wrong: worker reaches through a mesh opening to adjust a running machine. Safe: stop, isolate and use the approved adjustment method.', 'Wrong: defective machine remains available. Safe: isolate, identify as out of service, repair and verify before restart.', 'Stop work for missing/defeated guards, uncontrolled access to dangerous parts, failed interlocks, unexpected movement, exposed stored energy or unsafe maintenance.'],
        hazards: ['Missing guard', 'Defeated interlock', 'Unexpected movement', 'Unsafe jam clearing'],
        documents: ['Stop-work record', 'Corrective action', 'Restart authorisation']
      ),
    ],
    fieldChecklist: ['Machine-specific risk assessment current', 'Danger points identified', 'Fixed/other guards correctly installed', 'Interlocks/trip devices tested where applicable', 'Guard openings/clearances checked', 'No bypassed safety devices', 'Emergency stop functional', 'Maintenance isolation procedure available', 'Defects tagged/out of service', 'Guard reinstatement verified before restart'],
    stopWorkIndicators: ['Missing or damaged guard', 'Defeated/taped interlock', 'Accessible dangerous moving parts', 'Failed trip/presence-sensing device', 'Unsafe jam clearing', 'Machine restarted with guard removed', 'Improvised guard/modification without engineering approval', 'Defective machine not isolated'],
    references: ['ADPHC/ADOSH-SF CoP 47.0 Machine Guarding V4.1', 'ADPHC Element 2 Risk Management', 'ADPHC Element 5 Training, Awareness and Competency', 'HSE Introduction to Machinery Safety', 'HSE PUWER overview and guarding guidance', 'HSE Safe Stop and machinery safeguarding guidance'],
    verificationNote: 'Guard clearance values in this document reproduce only the key numeric values needed for field study; the complete official tables must be consulted for detailed barrier geometry and machine-specific design.',
    protectionItems: ['Fixed guards', 'Interlocking guards', 'Distance guards/barriers', 'Trip/presence-sensing devices', 'Two-hand controls where appropriate', 'Jigs/holders/push-sticks', 'Emergency stop devices'],
  );


}
