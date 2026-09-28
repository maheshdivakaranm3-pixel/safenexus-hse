// lib/data/abu_dhabi/abu_dhabi_cop_42_43_44.dart
// SafeNexus HSE — Abu Dhabi HSE Reference
// CoP 42.0 / 43.0 / 44.0 — Gold Standard
// Existing AbuDhabiCopDocument / AbuDhabiCopSection API preserved.
// UI/navigation is not changed. Official requirements are paraphrased.

import 'package:safenexus_hse/data/abu_dhabi/abu_dhabi_cop_01_to_03.dart';

class AbuDhabiCop42To44 {
  static final List<AbuDhabiCopDocument> documents = [cop42, cop43, cop44];

  static final AbuDhabiCopDocument cop42 = AbuDhabiCopDocument(code: 'CoP 42.0', title: 'Pre Cast Construction', version: '4.1', effectiveDate: '27 February 2026', introduction: 'CoP 42.0 covers safe design, prefabrication/casting, handling, storage, transport and erection of pre-cast and tilt-up concrete elements. Key risks include collapse, severe crush injuries, dropped loads, lifting-point failure, unstable bracing, wind and vehicle/plant interfaces.', sections: [
      AbuDhabiCopSection(
        number: '42.1',
        title: 'Pre-Cast Construction Fundamentals',
        requirements: ['Treat pre-cast work as a planned structural erection activity, not simply a lifting task.', 'Control design, fabrication, handling, storage, transport, erection and final incorporation as one system.', 'Identify interfaces with cranes, transporters, MEWPs, scaffolds, other contractors and the public.'],
hazards: ['Uncontrolled collapse', 'Crush/caught-between', 'Dropped or swinging elements', 'Wind instability'],
      ),
      AbuDhabiCopSection(
        number: '42.2',
        title: 'Scope, Definitions and Applicability',
        requirements: ['CoP 42.0 covers safe design, prefabrication/casting, handling, storage, transport and erection.', 'A pre-cast element is cast on-site or off-site and subsequently lifted into its structural position.', 'Tilt-up panels are cast horizontally and then rotated toward a vertical position before stabilisation.', 'The official scope excludes concrete pipes, bridge beams and culverts.'],
documents: ['Current ADPHC CoP 42.0', 'Approved structural and shop drawings'],
      ),
      AbuDhabiCopSection(
        number: '42.3',
        title: 'Roles, Responsibilities, Training and Competency',
        requirements: ['Employers plan, organise and supervise the work and provide competent people and suitable equipment.', 'Designers/engineers address erection stability, lifting strength, temporary supports and progressive-collapse prevention.', 'Supervisors verify the approved sequence, bracing, lifting arrangements, exclusion zones and changing conditions.', 'Workers follow the safe system and report defects.', 'Training records should identify person, subject, date and training provider.'],
documents: ['Training/competency records', 'Authorisations', 'Engineer approvals'],
      ),
      AbuDhabiCopSection(
        number: '42.4',
        title: 'Planning, Risk Assessment and Safe System of Work',
        requirements: ['Assess risk at design, fabrication, handling, storage, transport, erection, temporary bracing, final fixing, brace removal, modification and demolition.', 'Plan the complete erection sequence before fabrication where sequence affects safety.', 'Include ground conditions, crane position, services, weather, work at height, manual handling, simultaneous work and traffic.', 'Document erection scheme, phasing, stabilisation methods, crane requirements and site restrictions.'],
hazards: ['Weak ground', 'Overhead/underground services', 'Wind', 'Falls', 'Traffic/mobile plant'],
documents: ['Risk assessment', 'Safe work method', 'Erection sequence', 'Site survey'],
      ),
      AbuDhabiCopSection(
        number: '42.5',
        title: 'Design Documentation and Engineering Control',
        requirements: ['Structural drawings and erection documentation must provide information necessary for safe erection.', 'Marking plans should identify each element and its final location/sequence.', 'Erection documentation should address orientation, brace configuration, brace type/angle, brace footing requirements, shims and grouting.', 'Proprietary systems must follow manufacturer instructions; incompatible components must not be mixed without appropriate confirmation.', 'Changes to engineered requirements must be formally controlled.'],
hazards: ['Progressive collapse', 'Incorrect components', 'Unapproved modification'],
      ),
      AbuDhabiCopSection(
        number: '42.6',
        title: 'Lifting Inserts, Fixings and Rigging',
        requirements: ['Confirm insert type, capacity, location and reinforcement before lifting.', 'Use the rigging arrangement specified in erection documentation.', 'Inspect lifting accessories before use and quarantine defective items.', 'Do not improvise lifting points or connect to fittings not approved for lifting.', 'Control rotation, shock loading and suspended-load movement.'],
hazards: ['Insert pull-out', 'Concrete breakout', 'Rigging failure', 'Uncontrolled rotation'],
controls: ['Engineered lifting points', 'Competent rigger/signaller', 'Exclusion zone'],
      ),
      AbuDhabiCopSection(
        number: '42.7',
        title: 'Handling, Storage and Transport',
        requirements: ['Verify required element and brace-footing strength before lifting.', 'Store elements on engineered supports appropriate to size, shape and weight.', 'Obtain engineering approval before unusual horizontal storage or storage on suspended slabs/beams where required.', 'Protect stored elements from vehicles and plant.', 'Secure loads for transport and brief transporters on site-specific hazards.'],
hazards: ['Overturning', 'Support failure', 'Load shift', 'Vehicle impact'],
inspection: ['Element condition', 'Supports/racks', 'Transport restraints', 'Unloading area'],
      ),
      AbuDhabiCopSection(
        number: '42.8',
        title: 'Crane Selection, Setup and Lift Area',
        requirements: ['Select and position cranes under CoP 34.0 and the approved lift plan.', 'Check capacity, radius, access, ground bearing and erection sequence.', 'Avoid slewing conflicts with previously erected elements and braces.', 'Where multiple cranes operate, use planned positioning and controls to prevent contact.', 'Establish a controlled lifting/exclusion zone.'],
hazards: ['Overload', 'Crane overturning', 'Brace collision', 'Power-line contact', 'People entering load path'],
      ),
      AbuDhabiCopSection(
        number: '42.9',
        title: 'Erection, Temporary Bracing and Stability',
        requirements: ['Follow the engineer-approved erection sequence.', 'Install required temporary braces and fixings before releasing the element from the crane.', 'Verify brace footing and fixing conditions.', 'Maintain structural stability at every stage.', 'Do not remove braces until the approved structural condition is achieved.', 'Keep people outside the collapse/crush envelope.'],
hazards: ['Progressive collapse', 'Brace failure', 'Pinch points', 'Unstable panel'],
      ),
      AbuDhabiCopSection(
        number: '42.10',
        title: 'Working at Height and Access',
        requirements: ['Provide suitable scaffold, MEWP or other approved access for connections and inspection.', 'Provide fall protection where required.', 'Keep access clear and coordinate MEWP movement with lifting.', 'Control dropped tools and materials.'],
hazards: ['Falls', 'MEWP collision', 'Dropped objects'],
controls: ['Collective protection', 'Approved access equipment', 'Fall protection', 'Dropped-object controls'],
      ),
      AbuDhabiCopSection(
        number: '42.11',
        title: 'Weather, Wind and Environmental Conditions',
        requirements: ['Assess wind because large panels are highly wind-exposed.', 'Use approved engineer/manufacturer safe-weather criteria.', 'Stop or revise work when wind, rain, heat, visibility or ground deterioration makes the approved method unsafe.', 'Reinspect after severe weather.'],
hazards: ['Wind instability', 'Wet crane area', 'Heat stress'],
      ),
      AbuDhabiCopSection(
        number: '42.12',
        title: 'Inspection, Handover and Final Incorporation',
        requirements: ['Inspect elements, connections, braces and supports before the next stage.', 'Confirm final connections, grouting and structural continuity as specified.', 'Do not remove temporary stability systems merely because the element appears stable.', 'Control brace removal by the approved sequence.'],
inspection: ['Element condition', 'Alignment/orientation', 'Connections', 'Braces', 'Grouting', 'Sign-off'],
      ),
      AbuDhabiCopSection(
        number: '42.13',
        title: 'Field Example — Tilt-Up Wall Panel',
        requirements: ['Verify drawings and panel identity.', 'Confirm concrete strength and lifting inserts.', 'Inspect crane, rigging, brace system and footing.', 'Establish exclusion zone and communication.', 'Lift gradually, control rotation and avoid pinch points.', 'Install braces before release.', 'Record inspection and continue only when stability is confirmed.'],
      ),
      AbuDhabiCopSection(
        number: '42.14',
        title: 'Wrong Practice vs Safe Practice',
        requirements: ['Wrong: lift before required strength is verified. Safe: verify documented strength.', 'Wrong: improvised lifting point. Safe: engineered insert/rigging.', 'Wrong: release crane before stability. Safe: secure designed bracing first.', 'Wrong: store wherever space exists. Safe: use engineered storage.', 'Wrong: people inside erection zone. Safe: enforce segregation.'],
      ),
      AbuDhabiCopSection(
        number: '42.15',
        title: 'HSE Supervisor Field Verification',
        requirements: ['Approved drawings and sequence available.', 'RA/SWP briefed.', 'Element and lifting points verified.', 'Strength requirement verified.', 'Crane/lifting equipment suitable.', 'Braces and fixings ready.', 'Exclusion zone established.', 'Weather acceptable.', 'Safe access/fall protection available.', 'Emergency arrangements communicated.'],
      ),

      AbuDhabiCopSection(
        number: '42.17',
        title: 'Pre-Start Certification and Strength Verification',
        requirements: [
          'Before erection, verify the engineer certification for the temporary support system and confirm that the erection crew has been briefed on the approved safe system of work.',
          'Verify the concrete strength of each element and the brace footing strength against the approved shop and erection documentation before lifting.',
          'Confirm locating dowels, horizontal restraints, levelling shims, brace fixings and required support/falsework are ready before the element is lowered.',
          'Do not substitute lifting inserts, braces, fixings or proprietary components without the required engineering/supplier confirmation.',
          'Confirm weather and site conditions remain within the limits established by the approved erection method and equipment manufacturers.'
        ],
      ),
      AbuDhabiCopSection(
        number: '42.18',
        title: 'No-Go Zone, Suspended Loads and Crush-Point Control',
        requirements: [
          'Establish a physical exclusion or no-go zone around the lifting and erection envelope using barriers, signs and controlled access.',
          'Only people directly involved in the lift, including authorised supervisors and engineers, should enter the controlled lifting area.',
          'Prevent workers and the public from entering areas where a panel could fall, overturn or create a crush point.',
          'Avoid suspending or travelling a pre-cast element over people wherever reasonably practicable. Where an approved exception requires a backup system, it must be engineered for the actual element and lifting arrangement.',
          'Never position a worker between a moving pre-cast element and a wall, column, vehicle, crane or other hard obstruction.'
        ],
      ),
      AbuDhabiCopSection(
        number: '42.19',
        title: 'Bracing, Bolt Checks and Progressive Stability',
        requirements: [
          'Treat temporary bracing as a critical structural system until the element is permanently incorporated and the engineer confirms the required stage has been achieved.',
          'Inspect braces, bracing inserts, fixings and connections at the frequencies established by the erection plan and after events that could affect stability.',
          'The CoP requires brace-bolt torque to be checked 24 hours after erection unless the anchor manufacturer specifies otherwise, with further checks at planned intervals.',
          'Carry out daily visual inspection of braced and bracing pre-cast elements and record defects or movement.',
          'Do not remove braces merely because the panel appears stable; removal must follow the approved engineering sequence and required permanent restraint/grouting conditions.'
        ],
      ),
      AbuDhabiCopSection(
        number: '42.20',
        title: 'Transport Route and Delivery Interface',
        requirements: [
          'Brief the transporter on site-specific hazards, approved routes, overhead restrictions, utilities, traffic arrangements and local access constraints before the load enters the work area.',
          'Plan delivery and erection sequences together so that elements are unloaded in a sequence compatible with the erection plan.',
          'Check long or over-dimensional loads for route geometry, road cambers, turning areas and overhead clearance before movement.',
          'Secure each element individually using a transport support system designed for the expected forces during loading, travel and unloading.',
          'Do not release an individual pre-cast element during unloading until the crane has taken the initial load of that element.'
        ],
      ),
      AbuDhabiCopSection(
        number: '42.21',
        title: 'Weather, Wind and Environmental Stop Conditions',
        requirements: [
          'The erection plan must consider wind loading on the size, shape and orientation of pre-cast elements.',
          'Stop or suspend erection when wind, rain, ground deterioration, visibility or temperature creates conditions outside the approved safe system or manufacturer limits.',
          'Reassess crane standing areas after heavy rain or any change that may reduce bearing capacity or stability.',
          'Consider heat stress for workers performing prolonged erection, rigging or work at height in Abu Dhabi conditions and apply the relevant CoP 11 controls.',
          'After a significant weather event, inspect temporary braces, lifting accessories, supports, crane standing areas and partially erected elements before restarting.'
        ],
      ),
      AbuDhabiCopSection(
        number: '42.22',
        title: 'Modification, Damage and Defect Control',
        requirements: [
          'Quarantine cracked, damaged, distorted or otherwise suspect pre-cast elements until the responsible engineer determines their condition and permitted disposition.',
          'Do not drill, cut, weld, alter lifting inserts or modify reinforcement without approved engineering instruction.',
          'Treat damage to lifting inserts, connectors, braces and support frames as a potential structural/lifting defect rather than a cosmetic issue.',
          'Record repairs and approved changes and ensure revised drawings or written engineer instructions are available to the erection team.',
          'If the stability or load path is uncertain, stop the activity and obtain competent engineering verification before continuing.'
        ],
      ),
      AbuDhabiCopSection(
        number: '42.23',
        title: 'Supervisor Pre-Erection Field Sequence',
        requirements: [
          'Step 1: verify current drawings, erection sequence, lifting plan, risk assessment and temporary bracing design.',
          'Step 2: verify element identification, lifting points, required strength, dimensions and visible defects.',
          'Step 3: verify crane setup, ground condition, lifting accessories, exclusion zone, communications and emergency arrangements.',
          'Step 4: verify brace footings, anchors, shims, dowels, restraints and access equipment are ready before the lift.',
          'Step 5: conduct the toolbox talk and confirm each person understands the stop signal and emergency arrangements.',
          'Step 6: perform a controlled initial lift/check and continuously monitor load behaviour, wind, communication and stability.',
          'Step 7: secure the element as designed before releasing the crane and never remove temporary stability controls prematurely.'
        ],
      ),
  ], fieldChecklist: ['Approved drawings/marking plan', 'RA/SWP briefed', 'Element and inserts checked', 'Concrete strength verified', 'Crane/ground/lift path checked', 'Rigging inspected', 'Braces ready', 'Exclusion zone established', 'Weather acceptable', 'Access/fall protection available', 'Final connections controlled'], stopWorkIndicators: ['Unknown weight/lifting point', 'Damaged insert/rigging/brace', 'Strength cannot be verified', 'Unstable crane ground', 'Unsafe wind/weather', 'People enter collapse/load zone', 'Unapproved design/sequence change', 'Loss of operator-rigger communication'], references: ['ADPHC/ADOSH-SF CoP 42.0 Pre Cast Construction V4.1', 'CoP 34.0 Safe Use of Lifting Equipment and Lifting Accessories', 'CoP 23.0 Working at Heights', 'CoP 20.0 Safety in Design (Construction)', 'CoP 53.0 OSH Management During Construction Work', 'HSE — Pre-stressed concrete safety guidance', 'HSE — Lifting operations guidance', 'HSE — Temporary works guidance'], verificationNote: 'Use the current ADPHC CoP, approved engineering/project documents and manufacturer instructions for compliance decisions. SafeNexus is a field-reference summary and does not replace an approved design, permit, lift plan or traffic plan.', protectionItems: ['Safety helmet', 'Safety footwear', 'High-visibility clothing', 'Eye/hand protection', 'Fall protection where required']);

  static final AbuDhabiCopDocument cop43 = AbuDhabiCopDocument(code: 'CoP 43.0', title: 'Temporary Structures', version: '4.1', effectiveDate: '27 February 2026', introduction: 'CoP 43.0 requires the need, risks, design, installation, stability, occupancy, inspection, modification and dismantling of temporary structures to be controlled. Temporary does not mean low risk; collapse, wind, fire, electrical, access, public and overloading hazards must be managed.', sections: [
      AbuDhabiCopSection(
        number: '43.1',
        title: 'Temporary Structure Fundamentals',
        requirements: ['Temporary does not mean unengineered or low risk.', 'Identify type, use, occupancy, duration and location.', 'Control supports, frame, enclosure, connections, services and occupancy loads.', 'Protect workers, contractors, visitors and the public.'],
hazards: ['Collapse', 'Wind movement', 'Overloading', 'Fire/egress', 'Public access'],
      ),
      AbuDhabiCopSection(
        number: '43.2',
        title: 'Need, Scope and Risk Assessment',
        requirements: ['Assess whether the temporary structure is required and whether a permanent arrangement is reasonably practicable.', 'Assess risks to employees and the public.', 'For construction, include requirements in applicable pre-tender and OSH construction management arrangements.', 'Review when use, location or surrounding conditions change.'],
documents: ['Risk assessment', 'Site/layout plan', 'Safe system', 'Approvals'],
      ),
      AbuDhabiCopSection(
        number: '43.3',
        title: 'Design, Engineering and Manufacturer Requirements',
        requirements: ['Use competent design/engineering input appropriate to the structure.', 'Confirm intended occupancy and environmental loading.', 'Follow manufacturer instructions for proprietary tents, cabins and modular systems.', 'Verify foundations, anchors, ballast and connections.', 'Do not mix incompatible proprietary components without confirmation.'],
hazards: ['Foundation/anchor failure', 'Connection failure', 'Unapproved modification'],
      ),
      AbuDhabiCopSection(
        number: '43.4',
        title: 'Site Selection, Ground and Foundation',
        requirements: ['Assess ground bearing, slope, drainage and flooding potential.', 'Keep clear of hazardous areas and maintain emergency access.', 'Install anchors/supports as designed.', 'Protect supports from vehicle impact.'],
hazards: ['Settlement', 'Water accumulation', 'Vehicle strike'],
inspection: ['Ground', 'Foundation/supports', 'Anchorage/ballast', 'Drainage', 'Vehicle protection'],
      ),
      AbuDhabiCopSection(
        number: '43.5',
        title: 'Erection and Installation',
        requirements: ['Use competent installers and approved sequence.', 'Control lifting/manual handling.', 'Establish exclusion zones during erection.', 'Secure partly erected structures before leaving them unattended.', 'Use suitable access equipment.'],
hazards: ['Falls', 'Falling components', 'Instability', 'Manual handling'],
      ),
      AbuDhabiCopSection(
        number: '43.6',
        title: 'Structural Stability, Bracing and Connections',
        requirements: ['Maintain designed stability during erection and use.', 'Verify braces, anchors, ties, bolts and connections.', 'Do not remove stability components without an approved sequence.', 'Inspect after modification, relocation or significant weather.'],
hazards: ['Movement', 'Distortion', 'Settlement', 'Connection failure'],
      ),
      AbuDhabiCopSection(
        number: '43.7',
        title: 'Wind, Weather and Environmental Conditions',
        requirements: ['Assess exposure to wind and weather.', 'Use structure-specific manufacturer/engineer criteria.', 'Secure or evacuate when approved safe conditions are exceeded.', 'Inspect after strong wind/heavy rain.', 'Control heat and ventilation for occupied facilities.'],
hazards: ['Wind uplift', 'Rain/flooding', 'Heat stress'],
measurements: ['Do not substitute a generic wind value for the structure-specific limit.'],
      ),
      AbuDhabiCopSection(
        number: '43.8',
        title: 'Occupancy, Loading and Internal Arrangement',
        requirements: ['Control occupancy according to approved arrangement.', 'Do not overload floors, roofs, platforms or storage areas.', 'Keep exits clear.', 'Secure shelves/cabinets where overturning is possible.', 'Control electrical loads and temporary services.'],
hazards: ['Overloading', 'Falling objects', 'Blocked exits', 'Electrical overload'],
      ),
      AbuDhabiCopSection(
        number: '43.9',
        title: 'Fire, Emergency Access and Public Protection',
        requirements: ['Provide emergency access/egress appropriate to occupancy.', 'Keep fire equipment and emergency routes accessible.', 'Control ignition sources and combustible storage.', 'Use barriers/signage to prevent unauthorised public access.'],
hazards: ['Fire', 'Blocked escape', 'Public exposure'],
      ),
      AbuDhabiCopSection(
        number: '43.10',
        title: 'Temporary Electrical and Utility Services',
        requirements: ['Install temporary electrical systems through competent persons.', 'Protect cables from traffic, water and mechanical damage.', 'Provide suitable isolation/protection.', 'Do not overload temporary distribution.', 'Coordinate generators, fuel, HVAC and other services.'],
hazards: ['Shock', 'Fire', 'Cable damage', 'Fuel release'],
      ),
      AbuDhabiCopSection(
        number: '43.11',
        title: 'Inspection, Maintenance and Modification',
        requirements: ['Inspect after erection and before occupation/use.', 'Reinspect after severe weather, impact, relocation or modification.', 'Repair defects before continued use.', 'Prevent unauthorised changes.', 'Record significant inspections and corrective actions.'],
inspection: ['Frame', 'Anchors/braces', 'Supports', 'Roof/enclosure', 'Exits', 'Services'],
      ),
      AbuDhabiCopSection(
        number: '43.12',
        title: 'Dismantling, Relocation and Handover',
        requirements: ['Plan dismantling before removal.', 'Use a sequence that prevents premature instability.', 'Establish exclusion zone.', 'Isolate services.', 'Control lifting/manual handling.', 'After relocation repeat foundation, anchorage and structural checks.'],
      ),
      AbuDhabiCopSection(
        number: '43.13',
        title: 'Field Example — Temporary Site Office/Welfare Cabin',
        requirements: ['Confirm location and ground.', 'Check supports and vehicle-impact protection.', 'Verify anchorage/stability.', 'Confirm exits and emergency access.', 'Inspect electrical services.', 'Control occupancy, housekeeping and fire protection.', 'Reinspect after severe weather or relocation.'],
      ),
      AbuDhabiCopSection(
        number: '43.14',
        title: 'Field Example — Temporary Event/Festival Tent',
        requirements: ['Verify approved design and anchorage/ballast.', 'Assess crowd movement and egress.', 'Separate public from vehicles/service operations.', 'Control wind/weather and evacuation action.', 'Keep exits and fire equipment clear.'],
      ),
      AbuDhabiCopSection(
        number: '43.15',
        title: 'Wrong Practice vs Safe Practice',
        requirements: ['Wrong: add heavy storage without checking loads. Safe: verify approved loads.', 'Wrong: remove brace for access. Safe: obtain approved instruction.', 'Wrong: assume supplied tent is automatically safe. Safe: verify installation/anchorage.', 'Wrong: reuse after relocation without inspection. Safe: inspect before occupation.'],
      ),
      AbuDhabiCopSection(
        number: '43.16',
        title: 'HSE Supervisor Field Verification',
        requirements: ['Need/use confirmed', 'Design/manufacturer information available', 'Ground/foundation acceptable', 'Anchors/braces checked', 'Competent erection', 'Emergency exits clear', 'Fire/electrical controls', 'Occupancy/load controlled', 'Inspection records', 'Weather/impact reinspection triggers'],
      ),

      AbuDhabiCopSection(
        number: '43.18',
        title: 'Portable Building Base, Access and Fire Controls',
        requirements: [
          'Portable buildings must be fit for purpose and positioned so users have safe access and egress.',
          'Provide a level concrete base and prevent combustible waste from accumulating beneath the building by controlling the gap to ground.',
          'Where two or more portable buildings are used, provide an integrated emergency plan and fire alarm arrangement appropriate to the installation.',
          'Provide fire detection and firefighting equipment in accordance with the applicable UAE Fire and Life Safety Code and emergency-management requirements.',
          'Provide safe steps and handrails at entrances and emergency exits; maintain pedestrian routes between buildings and segregate them from vehicles.'
        ],
      ),
      AbuDhabiCopSection(
        number: '43.19',
        title: 'Portable Building Electrical and Lifting Controls',
        requirements: [
          'Electrical installations for portable buildings must be completed by a competent electrician in accordance with the applicable Abu Dhabi electrical-safety requirements.',
          'The CoP specifies six-month testing of the distribution board, associated cables, wall sockets and fixed electrical installations in portable buildings.',
          'When lifting a proprietary portable building, follow the manufacturer lifting method and the lifting-equipment requirements of CoP 34.0.',
          'Never lift a portable building unless its lifting points have the required inspection/test certification from an approved third-party engineer.',
          'Inspect the lifting arrangement, load path, exclusion zone, ground condition and crane setup before the lift.'
        ],
      ),
      AbuDhabiCopSection(
        number: '43.20',
        title: 'Stacked Portable Buildings',
        requirements: [
          'A competent engineer must verify loading and structural suitability when portable buildings are stacked.',
          'Provide suitable metal stairs with fixed handrails to upper levels and protect landing platforms in accordance with working-at-height requirements.',
          'Provide an additional means of escape from upper levels where required by the CoP.',
          'Ensure the fire-rating requirements for the lower roof and upper floor are satisfied where buildings are stacked.',
          'Do not add storage, equipment or imposed loads beyond the approved design loading.'
        ],
      ),
      AbuDhabiCopSection(
        number: '43.21',
        title: 'Commercial Tent and Event Approval Workflow',
        requirements: [
          'For a commercial event tent or canopy, prepare and submit the required plan to the concerned competent authority at least 10 working days before scheduled erection as specified by the CoP.',
          'The submission should address site layout, intended use, dates, parking and emergency-vehicle access, fire-safe materials, Civil Defence fire systems, emergency equipment, floor surface, heating/cooling/cooking and emergency arrangements.',
          'The floor plan should identify seating and maximum capacity, internal obstacles, common and emergency access, emergency lighting, exit and no-smoking signs, firefighting equipment and fire access routes.',
          'After erection and before the event, arrange the required inspection/approval process; the CoP specifies completion of inspection at least two days before the event.',
          'Keep approved plans, inspection records and authority approvals available at the site.'
        ],
      ),
      AbuDhabiCopSection(
        number: '43.22',
        title: 'Tent Egress and Occupancy Controls',
        requirements: [
          'Provide at least two exits for covered tents/canopies, with each exit at least 2 m wide under the stated CoP requirement.',
          'The CoP states a maximum travel distance of 30 m from any point in the tent to the nearest external exit.',
          'Keep escape routes clear and ensure exits lead directly to an open exterior area.',
          'Control occupancy to the agreed maximum using trained personnel and keep the emergency plan aligned with the actual layout.',
          'Maintain at least 3 m separation between rows of stalls and limit a row of stalls to 15 m as specified for the covered tent arrangement.'
        ],
      ),
      AbuDhabiCopSection(
        number: '43.23',
        title: 'Tent Fire Protection, LPG and Generator Controls',
        requirements: [
          'The CoP specifies that all parts of a tent are to be within 100 m of a fire hydrant while maintaining the stated minimum 3 m separation from hydrants, breeching inlets and neighbouring fire-exit staircases.',
          'Provide 2.5 kg ABC dry chemical extinguishers so that no person needs to travel more than 15 m to reach one, together with the additional CO2 extinguisher arrangement specified for generators or air-conditioning sets.',
          'Generators are to be positioned at least 5 m from buildings and tents/stalls under the stated CoP requirement.',
          'LPG use requires the specified permit/Civil Defence permission and a task-specific risk assessment; controls must meet applicable Civil Defence and Municipality requirements.',
          'Keep combustible materials away from heat sources, prohibit smoking in tents/canopies and maintain the specified combustible-waste housekeeping zone.'
        ],
      ),
      AbuDhabiCopSection(
        number: '43.24',
        title: 'Wind, Inspection, Occupancy and Dismantling',
        requirements: [
          'Before occupancy, inspect the structure for anchorage, bracing, fabric condition, exits, emergency lighting, electrical installations, fire protection and public-access controls.',
          'Reinspect after significant weather, modification, impact or other event that could affect structural stability or fire/life safety.',
          'Monitor wind and weather conditions against the temporary structure design and manufacturer limitations; stop use or evacuate when stability is no longer assured.',
          'The CoP requires temporary structures to be dismantled and removed within 3 days after expiry of the approved period.',
          'Plan dismantling as a controlled work activity with exclusion zones, competent personnel and an engineered sequence where structural stability can change during removal.'
        ],
      ),
  ], fieldChecklist: ['Need/RA complete', 'Design/manufacturer information', 'Ground/foundation', 'Anchorage/bracing', 'Erection/dismantling sequence', 'Occupancy/load control', 'Emergency exits', 'Fire/electrical', 'Public/vehicle segregation', 'Post-weather inspection'], stopWorkIndicators: ['Movement/distortion/settlement', 'Damaged anchor/brace', 'Unapproved modification', 'Overload', 'Blocked emergency route', 'Weather beyond approved limit', 'Vehicle impact damage'], references: ['ADPHC/ADOSH-SF CoP 43.0 Temporary Structures V4.1', 'CoP 20.0 Safety in Design', 'CoP 22.0 Barricading of Hazards', 'CoP 23.0 Working at Heights', 'CoP 53.0 OSH Management During Construction Work', 'HSE — Temporary works guidance', 'HSE — Temporary demountable structures guidance', 'HSE — Event/site design safety guidance'], verificationNote: 'Use the current ADPHC CoP, approved engineering/project documents and manufacturer instructions for compliance decisions. SafeNexus is a field-reference summary and does not replace an approved design, permit, lift plan or traffic plan.', protectionItems: ['Safety helmet', 'Safety footwear', 'High-visibility clothing', 'Eye/hand protection', 'Fall protection where required']);

  static final AbuDhabiCopDocument cop44 = AbuDhabiCopDocument(code: 'CoP 44.0', title: 'Traffic Management and Logistics', version: '4.1', effectiveDate: '27 February 2026', introduction: 'CoP 44.0 addresses site traffic management and logistics. The field priority is effective separation of pedestrians and vehicles, controlled entrances/exits, safe routes, reversing controls, competent traffic personnel, delivery management, emergency access and continual review as the site changes.', sections: [
      AbuDhabiCopSection(
        number: '44.1',
        title: 'Traffic Management Fundamentals',
        requirements: ['Plan, organise and supervise site traffic management and logistics.', 'Segregate pedestrians and vehicles so far as reasonably practicable.', 'Clearly mark routes with signs/barriers.', 'Provide separate entrances/exits where practicable.', 'Set site speed controls based on risk.', 'Brief visitor drivers before movement.', 'Review arrangements as the site changes.'],
hazards: ['Vehicle-pedestrian collision', 'Vehicle collision', 'Reversing', 'Rollover', 'Congestion'],
      ),
      AbuDhabiCopSection(
        number: '44.2',
        title: 'Traffic Roles, Competency and Communication',
        requirements: ['Traffic-management personnel must be competent for assigned duties.', 'Drivers/operators must understand site rules.', 'Use banksmen/traffic marshals where required by risk assessment.', 'Use an agreed communication method.', 'Only authorised persons should direct controlled movements.'],
documents: ['Traffic management plan', 'Driver induction', 'Banksman competency', 'Site route map'],
      ),
      AbuDhabiCopSection(
        number: '44.3',
        title: 'Planning and Risk Assessment',
        requirements: ['Map vehicle/pedestrian routes, loading areas, parking and emergency routes.', 'Consider vehicle dimensions, delivery frequency, reversing, visibility and public interface.', 'Assess temporary changes caused by excavation, lifting, closures and material storage.', 'Review after incidents, near misses or major layout changes.'],
hazards: ['Poor visibility', 'Obstructions', 'Changing ground', 'Public interface', 'Multiple contractors'],
      ),
      AbuDhabiCopSection(
        number: '44.4',
        title: 'Vehicle and Pedestrian Segregation',
        requirements: ['Use physical segregation wherever reasonably practicable.', 'Provide defined pedestrian walkways/crossings.', 'Prevent shortcuts through vehicle routes.', 'Protect crossings from reversing/turning vehicles.', 'Keep pedestrian routes clear.'],
hazards: ['Run-over', 'Crush', 'Vehicle strike'],
controls: ['Barriers', 'Dedicated walkways', 'Controlled crossings', 'Gates', 'Lighting'],
      ),
      AbuDhabiCopSection(
        number: '44.5',
        title: 'Site Entrances, Exits and Visitor Control',
        requirements: ['Control vehicle and pedestrian gates.', 'Brief drivers before entry.', 'Provide visibility at gates.', 'Manage delivery timing and waiting areas.', 'Keep emergency access available.'],
hazards: ['Gate collision', 'Pedestrian run-over', 'Queue obstruction'],
      ),
      AbuDhabiCopSection(
        number: '44.6',
        title: 'Reversing, Blind Spots and Banksman Control',
        requirements: ['Eliminate reversing where reasonably practicable by route design.', 'Where reversing is necessary, apply risk-based controls.', 'Banksman must remain visible and have a safe escape position.', 'Never position a banksman between a reversing vehicle and a fixed object.', 'Stop movement if communication is lost.'],
hazards: ['Run-over/crush', 'Blind-side collision', 'Banksman struck'],
      ),
      AbuDhabiCopSection(
        number: '44.7',
        title: 'Speed Management and Traffic Rules',
        requirements: ['Set site-specific speed controls according to risk and conditions.', 'Communicate limits at entrances and within the site.', 'Use physical/engineered controls where signs alone are insufficient.', 'Drivers must adapt speed to visibility, surface, weather, load and traffic.'],
measurements: ['Do not insert a universal speed value; use the approved site/project limit.'],
      ),
      AbuDhabiCopSection(
        number: '44.8',
        title: 'Internal Roads, Surfaces and Route Condition',
        requirements: ['Maintain routes suitable for vehicles using them.', 'Control potholes, loose material, standing water, dust and mud.', 'Provide adequate width/turning space/visibility.', 'Protect edges, excavations and drop-offs.', 'Inspect after heavy rain, excavation changes or major deliveries.'],
hazards: ['Skidding', 'Rollover', 'Loss of control'],
inspection: ['Surface', 'Edges', 'Drainage', 'Turning areas', 'Obstructions'],
      ),
      AbuDhabiCopSection(
        number: '44.9',
        title: 'Loading, Unloading and Logistics Areas',
        requirements: ['Designate safe loading/unloading areas.', 'Control vehicle position before loading.', 'Keep people outside movement/falling-material zones.', 'Secure loads before travel.', 'Coordinate lifting operations with traffic controls.'],
hazards: ['Falling materials', 'Vehicle movement', 'Plant collision', 'Unstable load'],
      ),
      AbuDhabiCopSection(
        number: '44.10',
        title: 'Plant, Heavy Vehicles and Mobile Equipment',
        requirements: ['Use trained/authorised operators.', 'Inspect plant before use.', 'Plan routes for machine dimensions, turning radius, height and ground conditions.', 'Control interaction between cranes, excavators, trucks and pedestrians.', 'Use exclusion zones where required.'],
documents: ['Plant inspection', 'Operator authorisation', 'Route plan', 'Traffic plan'],
      ),
      AbuDhabiCopSection(
        number: '44.11',
        title: 'Overhead, Underground and Structural Interfaces',
        requirements: ['Check overhead clearances for vehicles, booms and loads.', 'Identify underground services before heavy movement or route changes.', 'Protect scaffolds, temporary works and structures from vehicle impact.', 'Coordinate with CoP 39.0.'],
hazards: ['Power-line contact', 'Service damage', 'Structure impact', 'Ground failure'],
      ),
      AbuDhabiCopSection(
        number: '44.12',
        title: 'Emergency Access and Traffic Incident Response',
        requirements: ['Maintain emergency routes.', 'Do not park or store material on emergency access.', 'Define response for breakdown, collision, spill and obstruction.', 'Secure incidents against secondary collisions.', 'Report and investigate incidents/near misses.'],
hazards: ['Blocked emergency route', 'Secondary collision', 'Spill'],
      ),
      AbuDhabiCopSection(
        number: '44.13',
        title: 'Night Work, Lighting and Visibility',
        requirements: ['Provide adequate lighting for routes, gates, crossings and loading areas.', 'Avoid glare.', 'Keep signs/barriers visible.', 'Review temporary lighting after layout changes.', 'Do not rely only on vehicle headlights.'],
hazards: ['Poor visibility', 'Hidden pedestrian', 'Barrier collision'],
      ),
      AbuDhabiCopSection(
        number: '44.14',
        title: 'Traffic Management Plan — Required Field Content',
        requirements: ['Show vehicle/pedestrian routes.', 'Identify entrances, exits, crossings, loading areas and delivery routes.', 'Define reversing/banksman arrangements.', 'Show emergency routes and restricted areas.', 'Identify temporary phase changes.', 'Define review triggers and responsible persons.'],
documents: ['Current traffic plan', 'Logistics plan', 'Route drawings', 'Driver briefing', 'Inspection records'],
      ),
      AbuDhabiCopSection(
        number: '44.15',
        title: 'Inspection and Review',
        requirements: ['Inspect routes, barriers, signs, crossings, lighting and segregation.', 'Check physical site against the plan.', 'Correct damaged barriers, missing signs, blocked routes and poor surfaces.', 'Review after incidents, near misses and major changes.', 'Record findings and close corrective actions.'],
inspection: ['Vehicle routes', 'Pedestrian routes', 'Barriers/gates', 'Signs/markings', 'Lighting', 'Emergency access', 'Loading areas', 'Reversing zones'],
      ),
      AbuDhabiCopSection(
        number: '44.16',
        title: 'Field Example — Construction Delivery',
        requirements: ['Schedule delivery away from peak pedestrian movement.', 'Brief driver at entrance.', 'Confirm route, turning area and unloading location.', 'Control conflicting traffic.', 'Use competent banksman where required.', 'Keep workers outside manoeuvring/unloading zone.', 'Release vehicle only when route is clear.'],
      ),
      AbuDhabiCopSection(
        number: '44.17',
        title: 'Field Example — Excavator and Truck Interface',
        requirements: ['Separate pedestrians from loading zone.', 'Establish controlled truck position.', 'Agree loading sequence.', 'Prevent people between excavator and truck.', 'Control reversing and departure.', 'Reassess when access layout changes.'],
      ),
      AbuDhabiCopSection(
        number: '44.18',
        title: 'Wrong Practice vs Safe Practice',
        requirements: ['Wrong: pedestrian shortcut through plant route. Safe: enforce designated walkway.', 'Wrong: uncontrolled reversing. Safe: eliminate or control reversing.', 'Wrong: delivery vehicle blocks emergency route. Safe: use designated waiting area.', 'Wrong: unchanged plan after layout change. Safe: review/update.', 'Wrong: damaged barrier left in place. Safe: repair/replace.'],
      ),
      AbuDhabiCopSection(
        number: '44.19',
        title: 'HSE Supervisor Traffic Inspection',
        requirements: ['Traffic plan current', 'Site matches plan', 'Pedestrian/vehicle segregation', 'Entrances/exits controlled', 'Reversing controlled', 'Banksman competent and safe', 'Speed controls enforced', 'Routes unobstructed', 'Loading zones controlled', 'Emergency routes clear', 'Night lighting adequate', 'Defects closed'],
      ),

      AbuDhabiCopSection(
        number: '44.21',
        title: 'Traffic Management Plan — Minimum Field Content',
        requirements: [
          'Prepare a site-specific Traffic Management Plan where vehicle operations require one, particularly where risk or traffic volume warrants a formal plan.',
          'Include site description, vehicle types, vehicle risk assessment, traffic-route drawing, pedestrian routes, crossing points, signs, traffic-control measures, estimated traffic volumes, parking areas and the person overseeing traffic management.',
          'Include driver/operator site rules, visiting-driver arrangements and the list/training records of traffic marshals where used.',
          'Review the plan regularly and whenever the site layout, traffic flow, work phase, public interface or significant hazards change.',
          'Keep the current plan available to supervisors, drivers, marshals and contractors who need it.'
        ],
      ),
      AbuDhabiCopSection(
        number: '44.22',
        title: 'Pedestrian Segregation and Crossing Control',
        requirements: [
          'Use physical segregation between pedestrians and vehicles wherever reasonably practicable; engineering controls should take priority over administrative controls.',
          'Provide clearly marked pedestrian routes, maintain them free from obstruction and conduct the CoP-required daily checks at the beginning of each shift.',
          'Provide designated, signed crossing points where pedestrians must cross vehicle routes and prevent shortcutting through high-risk manoeuvring areas.',
          'Restrict access to high-risk vehicle manoeuvring areas with barriers and warning signs in accordance with CoP 22.0.',
          'Provide suitable illumination for pedestrian routes during night or out-of-hours work.'
        ],
      ),
      AbuDhabiCopSection(
        number: '44.23',
        title: 'Traffic Marshal and Reversing Control',
        requirements: [
          'Design the site so reversing is avoided or minimised; use one-way systems and turning arrangements where reasonably practicable.',
          'Where reversing cannot be avoided, complete a detailed risk assessment, designate the reversing area and restrict pedestrian access.',
          'Vehicles operating in reversing arrangements must have the specified automatic audible reversing alarm and flashing amber light arrangements.',
          'A traffic marshal should not be treated as the first control where engineering controls can eliminate the reversing risk; the CoP describes marshals as a last-resort control.',
          'When a marshal is used, the marshal must be trained, identifiable, positioned in full view of the driver and able to prevent pedestrians entering the reversing path.'
        ],
      ),
      AbuDhabiCopSection(
        number: '44.24',
        title: 'Traffic Route Engineering and Emergency Access',
        requirements: [
          'Design vehicle routes for the actual vehicle types, including adequate width for safe passing where two-way traffic is unavoidable.',
          'Maintain emergency-vehicle access at all times or establish an alternative route when temporary site activities block the normal route.',
          'Design routes to reduce blind spots and tight bends and provide appropriate lighting, signage and directional controls.',
          'Determine site speed limits through risk assessment and display them at suitable points; do not copy a generic speed value without site assessment.',
          'Inspect and maintain route surfaces, promptly addressing potholes, deterioration, drainage problems and other conditions that can destabilise vehicles or pedestrians.'
        ],
      ),
      AbuDhabiCopSection(
        number: '44.25',
        title: 'Logistics, Storage and Delivery Interface',
        requirements: [
          'Before main works start, establish perimeter security, welfare, site offices, traffic routes, pedestrian routes, delivery areas and storage areas.',
          'Provide suitable hard-standing for palletised materials and keep storage areas defined, accessible and protected from vehicle conflict.',
          'Under the CoP, palletised materials are to be stacked no more than three pallets high or the manufacturer limit, whichever is lower.',
          'Brief delivery and collection drivers on the site layout, route, speed controls, loading/unloading rules and task-specific hazards before they enter operational areas.',
          'Use dedicated areas for coupling/uncoupling and ensure loads are checked before entry and again after loading before the vehicle leaves.'
        ],
      ),
      AbuDhabiCopSection(
        number: '44.26',
        title: 'Journey Management and Off-Site Vehicle Movement',
        requirements: [
          'For relevant off-site business vehicle movements, establish a Journey Management Plan; routine commuting journeys are excluded from this specific CoP requirement.',
          'Confirm the journey is necessary and business-related and plan route, timing, destination and other relevant travel factors.',
          'Record the vehicle, driver, passengers, departure time, destination and expected arrival/return information in the journey log.',
          'Require the driver to report arrival, return and unexpected delays such as traffic congestion.',
          'The CoP specifies that when a driver is more than one hour late with the relevant report, the employer should take appropriate steps to contact the driver and confirm safety.'
        ],
      ),
      AbuDhabiCopSection(
        number: '44.27',
        title: 'Traffic Incident Emergency Scenarios',
        requirements: [
          'Maintain documented emergency arrangements for foreseeable vehicle collisions, vehicle overturns, breakdowns in high-volume areas, pedestrian strikes and vehicle fires.',
          'After a collision or overturn, secure the area, prevent secondary vehicle movement, establish an exclusion zone and coordinate emergency response before recovery operations.',
          'For vehicle fire, activate the emergency plan, keep people away from the hazard area and use firefighting equipment only when trained and when conditions permit safe intervention.',
          'For a pedestrian strike, protect the casualty from further traffic exposure, summon emergency medical assistance and preserve the incident scene as required by site procedures.',
          'Reassess the traffic-control system after an incident and implement corrective actions before normal traffic operations resume.'
        ],
      ),
      AbuDhabiCopSection(
        number: '44.28',
        title: 'Daily HSE Traffic Verification Routine',
        requirements: [
          'Start-of-shift: inspect entrances, exits, traffic routes, pedestrian walkways, crossings, barriers, signs, lighting and emergency access.',
          'During shift: observe actual driver behaviour, reversing, speed compliance, pedestrian segregation, delivery movements and unauthorised route use.',
          'Check visitor and delivery drivers have received the required briefing and are following the current traffic plan.',
          'Check storage and loading areas for obstruction, unstable stacking, vehicle-pedestrian conflict and unsafe coupling/uncoupling.',
          'Record non-compliances, assign corrective actions and verify close-out rather than treating the inspection as a paperwork exercise.'
        ],
      ),
  ], fieldChecklist: ['Current traffic/logistics plan', 'Pedestrian/vehicle segregation', 'Entrances/exits', 'Visitor briefing', 'Reversing controls', 'Banksman safe position', 'Speed controls', 'Suitable routes', 'Loading/unloading controls', 'Emergency access', 'Signs/barriers/lighting', 'Review after changes/incidents'], stopWorkIndicators: ['Inadequate segregation', 'Banksman/driver lose visibility', 'Person enters reversing zone', 'Emergency route blocked', 'Unsafe route condition', 'Critical barrier/sign missing', 'Uncontrolled plant movement', 'Plan no longer matches site'], references: ['ADPHC/ADOSH-SF CoP 44.0 Traffic Management and Logistics V4.1', 'CoP 36.0 Plant and Equipment', 'CoP 39.0 Overhead and Underground Services', 'CoP 22.0 Barricading of Hazards', 'CoP 17.0 Safety Signage and Signals', 'CoP 34.0 Safe Use of Lifting Equipment', 'CoP 53.0 OSH Management During Construction Work', 'HSE — Traffic management on construction sites', 'HSE — Workplace transport safety', 'HSE — Temporary workplaces and unprepared roadways'], verificationNote: 'Use the current ADPHC CoP, approved engineering/project documents and manufacturer instructions for compliance decisions. SafeNexus is a field-reference summary and does not replace an approved design, permit, lift plan or traffic plan.', protectionItems: ['High-visibility clothing', 'Safety footwear', 'Safety helmet where required', 'Eye protection where required', 'Task/weather PPE']);

}
