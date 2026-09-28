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
  ], fieldChecklist: ['Approved drawings/marking plan', 'RA/SWP briefed', 'Element and inserts checked', 'Concrete strength verified', 'Crane/ground/lift path checked', 'Rigging inspected', 'Braces ready', 'Exclusion zone established', 'Weather acceptable', 'Access/fall protection available', 'Final connections controlled'], stopWorkIndicators: ['Unknown weight/lifting point', 'Damaged insert/rigging/brace', 'Strength cannot be verified', 'Unstable crane ground', 'Unsafe wind/weather', 'People enter collapse/load zone', 'Unapproved design/sequence change', 'Loss of operator-rigger communication'], references: ['ADPHC/ADOSH-SF CoP 42.0 Pre Cast Construction V4.1', 'CoP 34.0 Safe Use of Lifting Equipment and Lifting Accessories', 'CoP 23.0 Working at Heights', 'CoP 20.0 Safety in Design (Construction)', 'CoP 53.0 OSH Management During Construction Work'], verificationNote: 'Use the current ADPHC CoP, approved engineering/project documents and manufacturer instructions for compliance decisions. SafeNexus is a field-reference summary and does not replace an approved design, permit, lift plan or traffic plan.', protectionItems: ['Safety helmet', 'Safety footwear', 'High-visibility clothing', 'Eye/hand protection', 'Fall protection where required']);

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
  ], fieldChecklist: ['Need/RA complete', 'Design/manufacturer information', 'Ground/foundation', 'Anchorage/bracing', 'Erection/dismantling sequence', 'Occupancy/load control', 'Emergency exits', 'Fire/electrical', 'Public/vehicle segregation', 'Post-weather inspection'], stopWorkIndicators: ['Movement/distortion/settlement', 'Damaged anchor/brace', 'Unapproved modification', 'Overload', 'Blocked emergency route', 'Weather beyond approved limit', 'Vehicle impact damage'], references: ['ADPHC/ADOSH-SF CoP 43.0 Temporary Structures V4.1', 'CoP 20.0 Safety in Design', 'CoP 22.0 Barricading of Hazards', 'CoP 23.0 Working at Heights', 'CoP 53.0 OSH Management During Construction Work'], verificationNote: 'Use the current ADPHC CoP, approved engineering/project documents and manufacturer instructions for compliance decisions. SafeNexus is a field-reference summary and does not replace an approved design, permit, lift plan or traffic plan.', protectionItems: ['Safety helmet', 'Safety footwear', 'High-visibility clothing', 'Eye/hand protection', 'Fall protection where required']);

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
  ], fieldChecklist: ['Current traffic/logistics plan', 'Pedestrian/vehicle segregation', 'Entrances/exits', 'Visitor briefing', 'Reversing controls', 'Banksman safe position', 'Speed controls', 'Suitable routes', 'Loading/unloading controls', 'Emergency access', 'Signs/barriers/lighting', 'Review after changes/incidents'], stopWorkIndicators: ['Inadequate segregation', 'Banksman/driver lose visibility', 'Person enters reversing zone', 'Emergency route blocked', 'Unsafe route condition', 'Critical barrier/sign missing', 'Uncontrolled plant movement', 'Plan no longer matches site'], references: ['ADPHC/ADOSH-SF CoP 44.0 Traffic Management and Logistics V4.1', 'CoP 36.0 Plant and Equipment', 'CoP 39.0 Overhead and Underground Services', 'CoP 22.0 Barricading of Hazards', 'CoP 17.0 Safety Signage and Signals', 'CoP 34.0 Safe Use of Lifting Equipment', 'CoP 53.0 OSH Management During Construction Work'], verificationNote: 'Use the current ADPHC CoP, approved engineering/project documents and manufacturer instructions for compliance decisions. SafeNexus is a field-reference summary and does not replace an approved design, permit, lift plan or traffic plan.', protectionItems: ['High-visibility clothing', 'Safety footwear', 'Safety helmet where required', 'Eye protection where required', 'Task/weather PPE']);

}
