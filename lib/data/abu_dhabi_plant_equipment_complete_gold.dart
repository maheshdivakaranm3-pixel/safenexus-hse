// SafeNexus HSE — Abu Dhabi Plant & Equipment — Consolidated Gold Reference
// Consolidated minimum-file architecture.
// Plant, lifting and equipment topics consolidated into one reusable data file.
// Existing Gold Standard topic data is preserved below.
// Regulatory/legal/numerical requirements must always be checked against the current controlled official source.

// ===== SOURCE: abu_dhabi_crane_lifting_book_gold.dart =====
class CraneLiftingGoldPoint {
  final String title;
  final String detail;

  const CraneLiftingGoldPoint({
    required this.title,
    required this.detail,
  });
}

class CraneLiftingGoldSection {
  final String title;
  final List<CraneLiftingGoldPoint> points;

  const CraneLiftingGoldSection({
    required this.title,
    required this.points,
  });
}

const craneLiftingGoldStandardSections = <CraneLiftingGoldSection>[

  CraneLiftingGoldSection(
    title: '1. Definition, Purpose and Scope',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Crane and lifting equipment are used to raise, lower, suspend, position or move loads. Safe lifting requires the equipment, accessories, load, ground, environment and people to be treated as one lifting system."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Apply this topic to mobile cranes, crawler cranes, tower cranes, truck mounted cranes, rough terrain cranes, all terrain cranes, pick-and-carry cranes where applicable, gantry and overhead cranes, hoists, winches, goods/passenger hoists and other lifting equipment within the project scope."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Apply the same planning principles to lifting accessories including wire rope slings, web slings, chain slings, shackles, hooks, lifting beams, spreader beams, eyebolts, clamps and other approved accessories."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "The lifting objective is not simply to lift the load. The objective is to complete the lift without injury, dropped load, overturning, collision, equipment damage, uncontrolled movement or loss of containment."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Every lift shall be planned according to the actual load, actual equipment configuration, actual location and actual environmental conditions. Do not rely on a generic lifting plan when site conditions have materially changed."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Where an activity falls under another Abu Dhabi OSH Code of Practice, apply the related requirements as well; examples include plant and equipment, overhead and underground services, working at heights, road work, electrical safety and heat stress."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Use the hierarchy of controls: eliminate unnecessary lifting, substitute with safer handling methods, engineer the lift, establish administrative controls and use PPE as the final layer."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Critical lifting controls must be verified in the field before the load leaves the ground."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '2. Lifting Team and Roles',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "The lifting team should have clearly assigned responsibilities before work starts."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "The appointed person is responsible for planning and managing the lifting operation within the organisation's competence and authorization system."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "The crane operator operates the crane only within the manufacturer's instructions, rated capacity and approved lifting plan."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "The slinger/rigger selects, inspects and attaches lifting accessories and prepares the load for safe lifting."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "The signaler/banksman directs crane movements using the agreed communication method and maintains clear communication with the operator."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "The lifting supervisor coordinates the work at the lift location, confirms controls are in place and stops the lift when unsafe conditions arise."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "The HSE professional verifies the required risk controls, documentation, competency and site conditions but does not replace the operational responsibilities of the lifting team."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Ground personnel must remain outside danger zones unless their presence is specifically required and controlled."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "One clearly identified person should control signals to the operator during a normal lift unless the approved communication arrangement specifically requires otherwise."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Any worker has the authority and responsibility to stop a lift when an immediate uncontrolled hazard is observed."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '3. Appointed Person and Lift Planning',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "The appointed person should have suitable knowledge, experience and competence for the complexity of the lifting operation."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "The lift plan should describe the load, equipment, accessories, lifting method, location, hazards, controls, personnel and emergency arrangements."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Confirm the load mass from reliable information such as approved drawings, manufacturer data, weighing records or engineering calculations."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Do not estimate a critical load by appearance alone."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Identify the load centre of gravity and determine how the load will behave when first lifted."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Confirm the lifting points are designed and rated for the intended lifting method."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Select crane capacity based on the actual configuration and worst planned position, not simply the crane's headline maximum capacity."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Consider boom length, radius, boom angle, counterweight, jib configuration, outrigger position, reeving, duty chart and other manufacturer limitations."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Consider ground bearing capacity and the effect of outrigger reactions or crawler track loads."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Define the exclusion zone, travel path, set-down area and escape routes."),
      CraneLiftingGoldPoint(title: "Point 11", detail: "Specify communication method, signal arrangements and a backup method where radio communication could fail."),
      CraneLiftingGoldPoint(title: "Point 12", detail: "Review the plan whenever load, crane, location, ground, weather, access or work sequence changes materially."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '4. Load Identification and Weight',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Identify exactly what is being lifted, including attached items, packaging, rigging, hoses, temporary supports and any material that may remain attached."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Include the weight of lifting accessories in the lifted load when determining crane capacity unless the applicable load chart or manufacturer instructions explicitly account for them."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Check whether the load contains liquids, trapped material, loose contents or moving internal components."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Determine whether the centre of gravity is central, offset, high, low or likely to shift during lifting."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Identify fragile, flexible, long, unstable, irregular or rotating loads."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Confirm that the load can withstand the forces introduced by the planned lifting points and accessories."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Check doors, covers, temporary bolts, shipping brackets and restraints that may prevent free movement."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Remove or secure loose items before lifting."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Where load weight is uncertain and the uncertainty could affect capacity, stop and obtain reliable weight information."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Do not use a crane load chart to compensate for an unknown load weight."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '5. Crane Types and Applications',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Mobile cranes provide flexible lifting capability but require careful assessment of ground conditions, setup, radius and outrigger configuration."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Crawler cranes distribute load through tracks but still require ground assessment and correct assembly, counterweight and configuration."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Tower cranes require control of foundation, tie-ins, mast configuration, jib arrangement, counterweight and operating envelope."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Truck mounted cranes require stable vehicle positioning, correct parking/braking arrangements and manufacturer-approved stabilisation."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Rough terrain and all terrain cranes require attention to terrain, gradients, outrigger deployment, travel restrictions and manufacturer load charts."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Overhead and gantry cranes require assessment of runway condition, end stops, pendant controls, bridge travel and overhead clearance."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Hoists and winches require correct anchorage, line condition, rated capacity, reeving and control of suspended loads."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Goods and passenger hoists require their dedicated safety controls, guarding, gates, interlocks, examination and operating procedures."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Select the crane type according to load, radius, access, ground, height, duration, environmental exposure and required movement."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '6. Crane Components and Safety Devices',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Know the function and inspection requirements of boom, jib, mast, slew ring, counterweight, chassis, outriggers, hooks, drums, sheaves and wire ropes."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Check hydraulic systems for leaks, damage, abnormal pressure indications and hose deterioration."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Check crane controls, emergency stops, limit devices, indicators and alarms as applicable."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Check load moment/rated capacity indicators where fitted and confirm they are functioning before operation."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Check boom angle and length indication where fitted."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Check hook block, hook, safety latch and swivel arrangement."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Check wire rope termination, reeving and condition."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Check sheaves and drums for damage, abnormal wear and correct rope seating."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Do not bypass, disable or defeat safety devices."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Any safety-critical defect shall be assessed and corrected before the equipment is returned to service."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '7. Rated Capacity, SWL/WLL and Load Charts',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Rated capacity is configuration-specific. The same crane may have different capacities at different radii, boom lengths, jib configurations and support conditions."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Use the manufacturer's current load chart applicable to the exact crane configuration."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "SWL/WLL markings on lifting accessories shall be legible and traceable."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Never exceed the lowest rated capacity of any component in the lifting system."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Account for radius measured according to the manufacturer's load-chart convention."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Consider deductions or limitations stated in the load chart, including attachments, fly jibs, hooks, blocks and reeving arrangements where applicable."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Confirm the crane is configured exactly as the approved load chart requires."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Do not interpolate or invent capacity values when the required configuration is not covered."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Where a lift approaches capacity limits, treat small changes in radius, level or configuration as significant."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Do not use a capacity indicator as a substitute for proper lift planning."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '8. Radius, Boom Length and Boom Angle',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Radius is a critical factor in crane capacity and must be considered for both pick and set-down positions."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Measure or establish the maximum working radius, not only the starting radius."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Account for load swing and the geometry of the lifting path."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Boom length affects capacity and clearance and must match the selected load chart."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Boom angle influences reach, clearance and rated capacity depending on crane design."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Plan for the possibility that the load cannot be positioned directly under the hook."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Do not side-load the boom or pull a load sideways unless the manufacturer specifically permits the operation."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Keep the load vertically below the hook during normal lifting and lowering."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Use tag lines where suitable to control rotation without exposing workers to pinch points."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Recheck radius when the crane slews or when the load path changes."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '9. Ground Conditions and Crane Setup',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Assess ground bearing capacity before crane setup."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Identify underground services, voids, basements, trenches, culverts, tanks, weak slabs and recently backfilled areas."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Do not position outriggers close to unsupported excavation edges without engineering assessment and adequate controls."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Use manufacturer-approved outrigger deployment and support arrangements."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Use suitable mats, steel plates or engineered support systems where required to distribute reactions."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Ensure support surfaces are level, stable and capable of carrying the expected reaction."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Check for water saturation, erosion, settlement, loose fill and hidden voids."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Prevent unauthorised vehicles or plant from striking deployed outriggers."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Reinspect the setup after significant rain, ground disturbance, settlement or change in conditions."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Stop the lift if the crane shows abnormal settlement, tilt or movement."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '10. Outriggers, Stabilisation and Levelling',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Deploy outriggers exactly according to the crane manufacturer's approved configuration."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Confirm all required outrigger beams and jacks are correctly positioned and secured."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Use adequate bearing mats or engineered foundations under outrigger floats where required."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Check that floats are centred and fully supported."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Confirm crane level within the manufacturer's permitted operating tolerance."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Do not place mats over voids or unstable surfaces."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Keep personnel clear of outrigger pinch and crush zones."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Do not move or retract an outrigger while a load is suspended unless the manufacturer specifically permits the operation and the approved plan covers it."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Maintain the required clearances from excavation edges, services and structures."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Monitor for settlement during critical lifts."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '11. Lifting Accessories Selection',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Select accessories based on load weight, geometry, connection points, lifting angles, environment and required capacity."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Use only accessories with identifiable markings and traceable inspection status."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Select wire rope, webbing or chain according to the load and environment."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Use shackles of the correct type, size and rated capacity."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Use hooks with suitable safety latches where required."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Use lifting beams or spreader beams where they are necessary to control load geometry or accessory forces."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Protect slings from sharp edges using suitable packing or edge protection."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Do not knot, twist, shorten or improvise slings unless the manufacturer specifically permits the method."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Do not mix incompatible accessories or make unauthorised modifications."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Reject accessories with identification that cannot be verified when traceability is required."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '12. Wire Rope Slings',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Inspect wire rope for broken wires, kinking, crushing, bird-caging, corrosion, heat damage, mechanical damage and abnormal wear."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Check eyes, ferrules, sockets and terminations for damage or deformation."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Ensure the rope is correctly seated in hooks and fittings."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Protect wire rope from sharp edges and crushing points."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Do not drag slings over rough surfaces unnecessarily."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Do not use a wire rope sling beyond its rated configuration."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Follow the manufacturer's rejection criteria and the project's lifting accessory inspection system."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Keep wire rope clean enough for inspection and protect it from damaging contamination."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Store wire rope slings away from corrosive conditions and mechanical damage."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Remove damaged slings from service and prevent accidental reuse."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '13. Webbing and Round Slings',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Inspect webbing for cuts, tears, abrasion, pulled stitching, chemical attack, heat damage, melting, glazing and contamination."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Check identification labels and rated capacity markings."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Protect synthetic slings from sharp edges and hot surfaces."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Do not drag synthetic slings across abrasive ground where this can damage fibres."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Do not expose synthetic slings to chemicals outside the manufacturer's compatibility limits."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Ensure the sling is not twisted or trapped under the load."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Use the correct hitch arrangement and rated capacity for the planned method."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Do not use a sling if the identification or condition prevents safe assessment."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Keep synthetic slings dry and stored in a clean protected location where practicable."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Quarantine damaged slings immediately."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '14. Chain Slings',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Inspect chain links for cracks, elongation, bending, gouging, corrosion and excessive wear."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Check master links, coupling components, shortening devices and hooks."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Use chain grades and fittings approved for lifting service."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Do not shock-load chain slings."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Do not use makeshift bolts, pins or wire as substitutes for approved components."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Ensure shortening devices are correctly engaged."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Protect chains from sharp edges and uncontrolled abrasion."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Follow the manufacturer's rated capacity for the exact sling configuration and angle."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Remove distorted or damaged chain components from service."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Maintain inspection and traceability records."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '15. Shackles, Hooks and Connecting Hardware',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Confirm shackle body and pin markings are legible."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Use the correct shackle type for the connection and loading direction."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Do not side-load a shackle beyond its manufacturer's permitted configuration."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Ensure pins are correctly fitted and secured."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Inspect hooks for cracks, deformation, excessive throat opening, twisting, wear and latch condition."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Do not use a hook that is bent, twisted or visibly damaged."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Do not tip-load a hook unless the hook manufacturer specifically permits it."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Keep hook loading aligned with the intended load path."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Use compatible rated connecting hardware throughout the lifting assembly."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Never replace a rated component with an unapproved improvised connector."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '16. Sling Angles and Leg Loading',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Sling-leg forces increase as sling angles become flatter."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "For a symmetrical two-leg sling carrying a centred load, each leg tension can be approximated using T = W / (2 × sin θ), where θ is the angle of each sling leg above the horizontal."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Example: at 60 degrees above horizontal, each leg carries approximately 0.577 times the load for an ideal symmetrical arrangement; actual field conditions require additional assessment."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "At 30 degrees above horizontal, each leg carries approximately the full load in the ideal symmetrical formula, demonstrating why shallow angles can greatly increase sling forces."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Never use a convenient angle assumption when the actual geometry is materially different."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Check whether the lifting point spacing and centre of gravity create unequal leg loading."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Do not exceed the accessory's rated capacity for the actual hitch and angle."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Use spreader beams when needed to keep sling angles within the engineered design."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Prevent sling legs from contacting sharp edges or each other in an unsafe manner."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Where the lift is critical, have the sling arrangement verified by a competent lifting person or engineer as appropriate."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '17. Hooks, Lifting Points and Load Attachment',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Confirm lifting lugs, pad eyes, eyebolts and attachment points are designed for lifting."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Inspect lifting points for cracks, deformation, corrosion and damage."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Verify rated capacity and orientation of lifting points."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Ensure the load is supported at the intended lifting points before tensioning."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Conduct a controlled initial lift to confirm balance and stability."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Raise the load only a small amount initially to check sling seating and centre of gravity."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Lower and correct the rigging if the load tilts unexpectedly."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Keep hands out of pinch points during attachment and initial tensioning."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Never stand beneath a suspended load."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Do not lift from non-rated structural members merely because they appear strong."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '18. Rigging the Load — Practical Method',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Confirm the lifting plan and load identity."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Inspect crane and accessories before rigging."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Establish the exclusion zone before attaching the load."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Position the crane hook above the intended load centre."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Attach slings using the approved hitch."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Fit edge protection where required."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Connect shackles and other hardware correctly."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Remove slack gradually and keep people clear of pinch zones."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Perform a controlled trial lift."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Check balance, stability, sling seating, hook alignment and equipment response."),
      CraneLiftingGoldPoint(title: "Point 11", detail: "Lower and correct the rigging if the load is unstable."),
      CraneLiftingGoldPoint(title: "Point 12", detail: "Proceed only after the lifting supervisor confirms the load is ready."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '19. Tag Lines and Load Control',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Use suitable tag lines where they help control load rotation or orientation."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Position tag lines so workers are not pulled into the load path."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Do not wrap a tag line around a worker's hand, body or fixed object."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Do not use tag lines where they can become entangled with rotating machinery, vehicles or structures."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Maintain safe separation from electrical sources."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Use enough control lines for long or wind-sensitive loads where justified."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Never pull a suspended load toward a worker's body."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Keep the load under positive control without placing workers between the load and a fixed object."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Stop if wind or load behaviour makes tag-line control ineffective."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '20. Communication and Signalling',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Agree the communication method before lifting."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Use recognised hand signals or an approved radio protocol."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Ensure the operator can understand the signaler clearly."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Test radios before critical lifts."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Use a backup communication method where loss of communication would create immediate danger."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Only authorised persons should direct crane movements according to the lifting plan."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "If the operator loses the signal, the safe default is to stop movement and hold or place the load safely as conditions permit."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Signalers must maintain a clear view of the load and travel path or use an approved communication arrangement."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Do not give conflicting signals."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Communication must cover start, stop, emergency stop, slew, boom movement, hoist and travel as applicable."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '21. Exclusion Zones and Suspended Loads',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Establish an exclusion zone covering the suspended-load path and credible swing/crush areas."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Prevent unauthorised entry using suitable barriers, signage and supervision."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Do not allow people to work beneath suspended loads."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Consider falling-object and swing-radius hazards as well as the direct load path."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Extend the exclusion zone where a dropped load could travel or where the load may swing."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Protect adjacent work groups from simultaneous operations."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Use spotters where vehicle or pedestrian interaction cannot otherwise be controlled."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Never use a person as a physical counterweight or guide for an uncontrolled load."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Do not pass a suspended load over occupied areas unless the engineered procedure specifically addresses the risk and applicable requirements permit it."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '22. Blind Lifts and Restricted Visibility',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Identify blind lifts during planning."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Use competent signalers and reliable communication."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Use additional spotters where required by the approved method."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Ensure all personnel understand who controls the lift."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Break the lift into controlled movements where visibility changes."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Stop immediately if communication is lost."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Do not rely on mobile-phone communication if it is not suitable for continuous operational signalling."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Check the destination area before the load enters it."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Use cameras or other aids only as supplementary controls unless the approved system specifically relies on them."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Blind lifts require especially disciplined exclusion-zone control."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '23. Tandem and Multiple-Crane Lifts',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Treat tandem lifts as engineered/critical operations requiring detailed planning."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Determine the load share for each crane throughout the movement, not only at the start."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Consider changes in radius, geometry, centre of gravity and crane position."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Use compatible cranes and configurations."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Coordinate operators through a single controlled communication system."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Use an experienced lifting supervisor and competent appointed person."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Define the sequence of boom, slew, hoist and travel movements."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Control differential movement between cranes."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Establish conservative stop criteria."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Do not improvise tandem lifting at the workface."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '24. Lifting Near Overhead Electrical Services',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Identify overhead electrical lines before crane setup and lifting."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Establish the required safe approach controls according to applicable Abu Dhabi requirements, utility requirements and the approved risk assessment."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Where possible, eliminate the hazard by de-energising, isolating or relocating the service through the responsible authority."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Use physical height restriction or engineered controls where appropriate."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Nominate a competent spotter where required."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Consider boom deflection, load swing, wind and accidental slewing."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Do not rely solely on visual judgement of distance."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Clearly mark restricted zones."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Stop work immediately if the crane, boom, load or accessory enters a prohibited area."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '25. Underground Services and Nearby Excavations',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Review service drawings and obtain current service information before setup."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Use permit and utility-owner controls where required."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Confirm underground electrical, gas, water, communication and other services."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Assess the effect of crane reactions on buried services."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Keep crane supports away from unsupported excavation edges unless engineered."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Consider ground collapse caused by concentrated outrigger loads."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Use ground protection and engineered load distribution where necessary."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Reassess after excavation or service exposure changes the ground conditions."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Do not assume a covered service is structurally capable of carrying crane reactions."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '26. Weather and Environmental Conditions',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Check wind speed and direction before and during lifting."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Follow the crane and load manufacturer's wind limits and project restrictions."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Long, lightweight or large-area loads may become difficult to control in wind."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Stop when wind, dust, rain, lightning, poor visibility or other conditions prevent safe control."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Consider heat stress for operators, riggers, signalers and supervisors."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Ensure adequate lighting for night work."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Control visibility at night and during dust conditions."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Do not continue a lift merely because the crane is within its rated capacity if environmental conditions make the load uncontrollable."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Reassess after weather changes."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '27. Crane Setup and Pre-Lift Sequence',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Confirm approved lift plan is available at the work location."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Confirm crane identity and configuration match the plan."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Inspect crane documentation and current inspection/examination status."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Inspect lifting accessories and confirm identification/status."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Establish barriers and exclusion zones."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Verify ground condition and crane level."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Deploy outriggers or other stabilisation systems."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Check overhead and underground services."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Confirm load weight and centre of gravity."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Conduct a toolbox talk and assign roles."),
      CraneLiftingGoldPoint(title: "Point 11", detail: "Test communications."),
      CraneLiftingGoldPoint(title: "Point 12", detail: "Conduct a controlled trial lift before the main movement."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '28. Step-by-Step Safe Lifting Procedure',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Step 1: Review RAMS, lifting plan, permits and drawings."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Step 2: Conduct site and load assessment."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Step 3: Verify crane, operator, riggers and signalers are authorised and competent."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Step 4: Establish crane position and exclusion zone."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Step 5: Inspect crane and accessories."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Step 6: Rig the load using the approved method."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Step 7: Clear non-essential personnel."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Step 8: Take up slack slowly."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Step 9: Conduct the trial lift."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Step 10: Stop and correct any instability or abnormal condition."),
      CraneLiftingGoldPoint(title: "Point 11", detail: "Step 11: Lift, slew, travel or lower using smooth controlled movements."),
      CraneLiftingGoldPoint(title: "Point 12", detail: "Step 12: Keep the load controlled and people outside the danger zone."),
      CraneLiftingGoldPoint(title: "Point 13", detail: "Step 13: Set the load down on a prepared stable support."),
      CraneLiftingGoldPoint(title: "Point 14", detail: "Step 14: Release tension only after the load is stable."),
      CraneLiftingGoldPoint(title: "Point 15", detail: "Step 15: Remove rigging safely and close out the lifting activity."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '29. Crane Assembly and Dismantling',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Use the manufacturer's assembly and dismantling procedure."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Confirm competent personnel and required supervision."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Establish a dedicated exclusion zone."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Verify ground and support conditions."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Use auxiliary lifting equipment where required by the procedure."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Control counterweights and components against uncontrolled movement."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Follow bolt, pin and locking arrangements exactly."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Verify boom and jib connections before loading."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Do not work beneath suspended components."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Complete post-assembly inspections and required tests before operation."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '30. Pre-Use Inspection',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Inspect the crane before each shift or use in accordance with the manufacturer's and project requirements."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Check structural members for cracks, deformation, corrosion or impact damage."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Check hydraulic systems and hoses."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Check wire ropes, sheaves, drums and terminations."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Check hook and safety latch."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Check brakes, steering, tyres or tracks as applicable."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Check outriggers and stabilisation equipment."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Check alarms, indicators, limiters and emergency systems."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Check controls and communication equipment."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Record defects and prevent unsafe equipment from being used."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '31. Thorough Examination, Inspection and Testing',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Maintain the legally and manufacturer-required examination and inspection regime."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Use competent persons and approved examination arrangements."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Keep examination reports available for verification."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Ensure lifting accessories are included in the inspection and examination system where applicable."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Do not rely on an old certificate without confirming equipment identity and current status."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Check that any restrictions or defects recorded on the examination report have been closed."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Do not return equipment to service after a safety-critical defect until it has been appropriately repaired and released."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Retain records according to applicable legal and project requirements."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Review recurring defects for maintenance or operational trends."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '32. Maintenance',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Maintain cranes and lifting accessories according to the manufacturer's instructions and approved maintenance system."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Use competent maintenance personnel."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Isolate and secure equipment before maintenance."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Prevent stored hydraulic, electrical, mechanical or gravitational energy from causing injury."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Use correct replacement parts and approved repairs."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Do not weld, straighten or modify load-bearing components without competent engineering/manufacturer approval."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Keep maintenance records traceable to the equipment."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Conduct functional checks after maintenance before returning equipment to service."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Escalate repeated defects rather than repeatedly applying temporary fixes."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '33. Defect and Rejection Criteria',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Remove equipment from service when a defect could compromise lifting safety."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Examples include cracked structural components, distorted hooks, damaged safety latches, severe wire-rope damage, failed safety devices and uncontrolled hydraulic leakage."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Examples for synthetic slings include severe cuts, heat damage, chemical attack, damaged stitching or unreadable identification."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Examples for chain slings include cracked, elongated, bent or excessively worn links or fittings."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Do not make a field decision to continue using a damaged accessory simply because the lift is light."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Quarantine rejected accessories so they cannot be accidentally returned to service."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Record the defect and corrective action."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Where rejection criteria are manufacturer-specific, use the manufacturer's criteria rather than a generic rule."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '34. Competency and Training',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Crane operators must be competent and authorised for the equipment type and task."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Riggers/slingers must understand load attachment, accessory selection, inspection and safe signalling."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Signalers/banksmen must be competent in the agreed signalling system."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Appointed persons require suitable lifting-planning competence."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Supervisors require sufficient knowledge to verify that the approved plan is being followed."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Training should include practical application, not only classroom knowledge."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Competency must be appropriate to the complexity of the lift."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Refresher or reassessment should be triggered by poor performance, incidents, significant equipment change or organisational requirements."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Do not assign unfamiliar equipment to personnel without appropriate competence."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '35. RAMS, JSA and Risk Assessment',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Identify hazards before the lift begins."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Assess dropped load, overturning, collision, crush, struck-by, electrical contact, ground failure, mechanical failure and environmental hazards."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Consider people who are not part of the lifting team."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Apply hierarchy of controls before relying on PPE."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Define control owners and verification methods."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Include simultaneous operations and nearby contractors."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Identify stop-work criteria."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Review the assessment after changes, incidents, near misses or unexpected site conditions."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Communicate the assessment during the pre-lift briefing."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '36. PTW and Authorisation',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Determine whether the lift requires a permit under the project's PTW system."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Critical or non-routine lifts may require additional authorisation."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Ensure the permit references the correct location, equipment and activity."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Confirm isolations or exclusion controls where required."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Do not treat a permit as proof that the lift is safe; field verification remains necessary."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Close or suspend the permit when conditions change."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Coordinate lifting permits with excavation, electrical, road, hot work or other simultaneous permits where applicable."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '37. Emergency Procedures',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Define emergency arrangements before the lift."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Establish how to respond to equipment failure, load instability, dropped load, crane overturning, power loss, communication loss and contact with services."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Stop movement if an abnormal condition develops."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Keep people away from a failed or unstable suspended load."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Do not rush into the exclusion zone to recover equipment."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Raise the alarm and contact emergency services according to the site emergency plan."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Provide a safe rescue method for injured or trapped personnel."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Where electrical contact occurs, treat the crane and surrounding area as energised until the responsible authority confirms isolation and safe conditions."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Preserve the scene for investigation where required."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '38. Crane Overturning and Ground Failure',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Recognise warning signs such as outrigger settlement, abnormal tilt, ground cracking or unexpected movement."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Stop lifting if stability is compromised."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Do not attempt to counter an overturning crane by moving personnel into danger."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Evacuate the danger area according to the emergency plan."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Keep the public and adjacent work groups outside the collapse zone."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Do not approach until the crane is declared stable and the competent response team controls the scene."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Investigate ground conditions, setup and load parameters before returning equipment to service."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '39. Dropped Load and Load Shift',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Treat dropped loads as a high-potential event even when no injury occurs."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Stop nearby work and establish a larger exclusion zone."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Do not touch or re-rig an unstable load until the lifting supervisor has reassessed the situation."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Check for damaged crane components and accessories."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Inspect the load for instability or hidden damage."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Reassess the centre of gravity and lifting points."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Use a revised lifting plan where the original method is no longer valid."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Report and investigate according to the project's incident and near-miss process."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '40. Working Near Structures, Buildings and Other Plant',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Identify collision risks with buildings, scaffolds, temporary works, vehicles and other cranes."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Define the crane's slew envelope."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Use physical barriers or spotters where appropriate."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Maintain safe clearance from structures and prevent trapping points."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Consider load swing caused by wind or sudden movement."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Protect fragile structures from impact."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Coordinate simultaneous crane operations."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Use a dedicated lifting supervisor for complex congested areas."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '41. Lifting Over Roads, Public Areas or Occupied Workspaces',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Avoid lifting over people and public areas wherever reasonably practicable."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Where lifting near roads is necessary, integrate traffic management and exclusion controls."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Coordinate with road authorities and project traffic plans where applicable."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Use barriers, banksmen and controlled access."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Consider dropped-object consequences beyond the immediate site boundary."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Do not allow unauthorised traffic or pedestrians into the lift zone."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Use planned delivery and staging areas to reduce suspended-load exposure."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '42. Night Lifting and Lighting',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Provide adequate lighting for crane setup, rigging, signalling and landing areas."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Prevent glare that reduces operator or signaler visibility."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Illuminate hazards, barriers and access routes."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Provide backup lighting where loss of lighting could create danger."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Ensure radios and visual signals remain effective."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Stop the lift if visibility becomes inadequate."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '43. Housekeeping and Lifting Accessories Storage',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Keep lifting accessories clean and organised."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Store slings away from sharp edges, chemicals, heat and standing water where relevant."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Do not leave slings on vehicle paths where they can be run over."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Prevent hooks and shackles from being damaged by uncontrolled storage."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Separate serviceable and quarantined equipment."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Maintain identification and inspection status."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Keep lifting zones free of unnecessary materials that could become trip or struck-by hazards."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '44. Unsafe Lifting Practices',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Never stand under a suspended load."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Never exceed rated capacity."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Never use damaged or unidentified lifting accessories."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Never side-pull with a crane unless specifically designed and permitted."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Never drag a load with a crane unless the manufacturer and approved method explicitly permit it."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Never bypass safety devices."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Never use uncertified improvised lifting points."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Never allow unauthorised persons to signal or operate the crane."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Never continue after loss of communication."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Never lift when ground stability is uncertain."),
      CraneLiftingGoldPoint(title: "Point 11", detail: "Never use hands between a load and a fixed object to guide the load."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '45. Stop-Work Conditions',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Stop for unknown or incorrect load weight."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Stop when crane configuration does not match the approved load chart or plan."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Stop when the ground settles, cracks or becomes unstable."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Stop for damaged crane components or lifting accessories."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Stop when required safety devices are defective."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Stop when communication is lost."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Stop when unauthorised people enter the exclusion zone."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Stop when wind, visibility, lightning or other weather makes the operation unsafe."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Stop when overhead or underground service controls are uncertain."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Stop when the load becomes unstable, snags or behaves unexpectedly."),
      CraneLiftingGoldPoint(title: "Point 11", detail: "Stop whenever the actual condition differs materially from the approved lifting plan."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '46. Toolbox Talk — Key Points',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Explain the load and lifting route."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Explain crane position and ground condition."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Identify the appointed person, lifting supervisor, operator, rigger and signaler."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Explain exclusion zones and no-go areas."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Explain communication signals."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Explain weather limits and stop criteria."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Explain pinch points and dropped-object hazards."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Explain emergency arrangements."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Confirm every worker understands that stop-work authority applies."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Record attendance and key briefing points according to site procedure."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '47. Field Inspection Checklist',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Lift plan approved and available."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "RAMS/JSA reviewed."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Permit/authorisation valid where required."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Crane identification verified."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Operator competence verified."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Rigger/slinger competence verified."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Signaler/banksman competence verified."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Crane examination/inspection status current."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Load weight verified."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Centre of gravity assessed."),
      CraneLiftingGoldPoint(title: "Point 11", detail: "Load chart checked for actual configuration."),
      CraneLiftingGoldPoint(title: "Point 12", detail: "Radius and boom configuration verified."),
      CraneLiftingGoldPoint(title: "Point 13", detail: "Ground bearing and support verified."),
      CraneLiftingGoldPoint(title: "Point 14", detail: "Outriggers/stabilisation correct."),
      CraneLiftingGoldPoint(title: "Point 15", detail: "Overhead services assessed."),
      CraneLiftingGoldPoint(title: "Point 16", detail: "Underground services assessed."),
      CraneLiftingGoldPoint(title: "Point 17", detail: "Accessories inspected and identifiable."),
      CraneLiftingGoldPoint(title: "Point 18", detail: "Hooks/latches/shackles/slings acceptable."),
      CraneLiftingGoldPoint(title: "Point 19", detail: "Communication tested."),
      CraneLiftingGoldPoint(title: "Point 20", detail: "Exclusion zone established."),
      CraneLiftingGoldPoint(title: "Point 21", detail: "Landing area prepared."),
      CraneLiftingGoldPoint(title: "Point 22", detail: "Weather acceptable."),
      CraneLiftingGoldPoint(title: "Point 23", detail: "Emergency arrangements understood."),
      CraneLiftingGoldPoint(title: "Point 24", detail: "Trial lift completed satisfactorily."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '48. Practical Site Examples',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Example 1: A pump skid has a known weight but an offset centre of gravity. The rigging plan must account for the centre of gravity and may require a spreader arrangement or different lifting-point selection."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Example 2: A mobile crane is positioned beside an excavation. Even when the crane's chart shows enough capacity, the ground-support risk can make the planned position unacceptable without engineered assessment."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Example 3: A long sheet bundle is within crane capacity but high wind makes it difficult to control. The correct response is to reassess environmental conditions rather than relying only on crane capacity."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Example 4: A web sling has an unreadable label. Its condition may look good, but the required capacity and traceability cannot be verified; quarantine it until properly identified and accepted."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Example 5: A blind lift loses radio communication. The safe response is to stop movement and restore communication before continuing."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Example 6: A crane is within capacity at the pick point but the set-down position has a larger radius. The lift must be planned against the worst applicable condition."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Example 7: A hook safety latch is damaged. The crane may have sufficient capacity, but the lifting system is not acceptable until the defect is corrected."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '49. UAE and Abu Dhabi Applicability',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "For Abu Dhabi OSH compliance, use the current ADPHC Code of Practice registry and the applicable current versions."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "CoP 34.0 is the primary Abu Dhabi reference for safe use of lifting equipment and lifting accessories."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "ADPHC currently lists CoP 34.0 as Version 4.1 with an effective date of 27 February 2026 on its Code of Practices registry."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "The official CoP 34.0 document itself states Version 4.1 and a document date of 16 February 2026; use the official registry and controlled project copy when establishing document control."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "CoP 36.0 Plant and Equipment may also apply to crane/plant requirements depending on the activity and equipment."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "CoP 39.0 Overhead and Underground Services applies to relevant service hazards."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "CoP 23.0 Working at Heights may apply where workers are exposed to falls during lifting activities."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "CoP 33.0 Working On or Adjacent to a Road may apply to lifting operations near roads."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "CoP 11.0 Safety in the Heat may apply to outdoor lifting work in hot conditions."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Always confirm the applicable jurisdiction, sector, client requirements and current controlled document before treating a numerical or legal requirement as mandatory."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '50. Related Abu Dhabi References',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Primary: ADPHC CoP 34.0 — Safe Use of Lifting Equipment and Lifting Accessories."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Related: ADPHC CoP 36.0 — Plant and Equipment."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Related: ADPHC CoP 39.0 — Overhead and Underground Services."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Related: ADPHC CoP 23.0 — Working at Heights."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Related: ADPHC CoP 33.0 — Working On or Adjacent to a Road."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Related: ADPHC CoP 44.0 — Traffic Management and Logistics."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Related: ADPHC CoP 21.0 — Permit to Work Systems."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Related: ADPHC CoP 22.0 — Barricading of Hazards."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Related: ADPHC CoP 11.0 — Safety in the Heat."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Use the official ADPHC controlled documents for the current mandatory wording and project compliance."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '51. Quick Reference — Critical Lifting Rules',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Know the load."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Know the centre of gravity."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Know the crane configuration."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Know the radius."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Know the load chart."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Know the ground condition."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Know the lifting accessory capacity."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Know the sling angle and resulting leg forces."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Know who is authorised to operate, rig and signal."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Establish the exclusion zone."),
      CraneLiftingGoldPoint(title: "Point 11", detail: "Use one controlled communication method."),
      CraneLiftingGoldPoint(title: "Point 12", detail: "Perform a trial lift."),
      CraneLiftingGoldPoint(title: "Point 13", detail: "Keep people out of suspended-load and crush zones."),
      CraneLiftingGoldPoint(title: "Point 14", detail: "Stop when conditions differ from the plan."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '52. Documentation and Records',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Approved lifting plan."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Risk assessment/JSA and RAMS."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Equipment identification and examination records."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Lifting accessory inspection records."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Operator and lifting-team competency records."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Permit and authorisation records where applicable."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Pre-use inspection records where required."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Maintenance and defect records."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Toolbox talk/briefing records."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Incident, near-miss and corrective-action records."),
      CraneLiftingGoldPoint(title: "Point 11", detail: "Records should be controlled, traceable and available to the responsible persons."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '53. Review, Learning and Continuous Improvement',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Review lifting incidents and near misses for common causes."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Track recurring accessory defects."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Review crane setup problems and ground failures."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Use lessons learned in future lift plans."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Update RAMS when field experience identifies a better control."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Encourage reporting of unsafe conditions without waiting for an incident."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Audit whether the actual lift matches the approved plan."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Verify that corrective actions are closed and effective."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Reassess high-risk lifting operations periodically."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '54. HSE Officer / Supervisor Responsibilities',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Verify the lifting plan and risk controls are suitable for the task within the person's role and competence."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Check that the lifting team is competent and authorised."),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Verify crane and accessory inspection/examination status."),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Verify ground, overhead-service and exclusion-zone controls."),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Attend or arrange pre-lift briefings for critical operations."),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Observe the lift and intervene when controls are not followed."),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Ensure defects are quarantined and corrective actions tracked."),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Coordinate with other disciplines where simultaneous operations create hazards."),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Promote stop-work authority."),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Ensure lessons learned and incident findings are communicated."),
    ],
  ),
  CraneLiftingGoldSection(
    title: '55. Gold-Standard Lift Readiness Gate',
    points: [
      CraneLiftingGoldPoint(title: "Point 1", detail: "Before authorising the first movement, confirm the load, crane, accessories, people, ground, environment and destination are all acceptable."),
      CraneLiftingGoldPoint(title: "Point 2", detail: "Ask: Is the load weight verified?"),
      CraneLiftingGoldPoint(title: "Point 3", detail: "Ask: Is the centre of gravity understood?"),
      CraneLiftingGoldPoint(title: "Point 4", detail: "Ask: Does the crane configuration match the load chart?"),
      CraneLiftingGoldPoint(title: "Point 5", detail: "Ask: Is the maximum radius within the approved capacity?"),
      CraneLiftingGoldPoint(title: "Point 6", detail: "Ask: Is the crane foundation/ground support adequate?"),
      CraneLiftingGoldPoint(title: "Point 7", detail: "Ask: Are all accessories identified, inspected and correctly rated?"),
      CraneLiftingGoldPoint(title: "Point 8", detail: "Ask: Is the exclusion zone complete?"),
      CraneLiftingGoldPoint(title: "Point 9", detail: "Ask: Is communication proven?"),
      CraneLiftingGoldPoint(title: "Point 10", detail: "Ask: Are overhead/underground service controls confirmed?"),
      CraneLiftingGoldPoint(title: "Point 11", detail: "Ask: Is the landing area ready?"),
      CraneLiftingGoldPoint(title: "Point 12", detail: "Ask: Are weather and visibility acceptable?"),
      CraneLiftingGoldPoint(title: "Point 13", detail: "Ask: Does every person know the stop-work signal?"),
      CraneLiftingGoldPoint(title: "Point 14", detail: "If any critical answer is no or unknown, do not start the lift until the issue is resolved."),
    ],
  ),
];

// ===== SOURCE: abu_dhabi_mewp_gold.dart =====
class MewpGoldPoint {
  final String title;
  final String content;

  const MewpGoldPoint({
    required this.title,
    required this.content,
  });
}

class MewpGoldSection {
  final String title;
  final List<MewpGoldPoint> points;

  const MewpGoldSection({
    required this.title,
    required this.points,
  });
}

const List<MewpGoldSection> mewpGoldStandardSections = [
  MewpGoldSection(
    title: '01. Definition & Purpose',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Define MEWP use as work involving mobile elevating work platforms used to position people and tools at height, with controls for stability, falls, collision, entrapment, electrical contact and machine-specific hazards.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '02. Scope & Applications',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Cover scissor lifts, boom-type MEWPs, vertical mast platforms and other powered mobile platforms used for construction, maintenance, installation, inspection, access and similar work.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '03. MEWP Types',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Identify the machine type, operating principle, rated capacity, platform configuration, drive system, outreach and manufacturer limitations before selection and use.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '04. Selection & Suitability',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Select a MEWP suitable for the task, working height, outreach, ground conditions, access route, environment, load, indoor/outdoor use and foreseeable hazards. Do not select equipment only by maximum height.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '05. Manufacturer Instructions',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Follow the manufacturer\'s operating manual, rated capacity, configuration limits, warning labels, inspection instructions and emergency procedures. Manufacturer limitations shall not be overridden by site practice.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '06. Hazard Identification',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Identify overturning, falls, entrapment/crushing, collision, dropped objects, electrical contact, unstable ground, vehicle interface, wind, weather, mechanical failure, unauthorized use and unsafe access before operation.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '07. Risk Assessment & RAMS/JSA',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Include MEWP hazards in the task risk assessment and RAMS/JSA. Define machine selection, controls, exclusion zones, rescue, traffic interface, weather limits, emergency arrangements and competent-person responsibilities.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '08. Ground Conditions & Stability',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Verify ground strength, level, bearing capacity, slopes, voids, trenches, edges, underground services and hidden hazards. Use manufacturer-approved stabilisation arrangements where applicable and prevent travel over unsuitable ground.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '09. Outriggers, Stabilizers & Levelling',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Where fitted, deploy outriggers or stabilizers exactly as specified by the manufacturer. Use suitable ground protection where required. Confirm the machine is stable and level before elevation.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '10. Load & Capacity Control',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Never exceed the rated platform load or configuration limits. Include people, tools, materials and accessories in the load. Respect reduced capacity caused by outreach, platform configuration or other manufacturer-defined conditions.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '11. Fall Prevention',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Keep workers inside the designated platform and use the machine\'s prescribed guardrails, gates and access systems. Do not climb on guardrails, use boxes or improvised platforms, or lean outside the platform to gain additional reach.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '12. Harness & Personal Fall Protection',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Use personal fall protection where required by the machine manufacturer, risk assessment and applicable requirements. Connect only to designated anchorage points and use compatible equipment. Never attach to unsuitable structural parts.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '13. Access & Egress',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Use the designated access gate, steps or ladder. Keep access points clear. Do not enter or leave an elevated platform except where a specifically planned, risk-assessed and authorised procedure permits it.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '14. Overhead Electrical Hazards',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Identify overhead and nearby electrical services before positioning or travelling. Maintain the applicable separation distances and controls required by the authority, utility owner, risk assessment and manufacturer. Treat unidentified lines as potentially energised until verified.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '15. Collision & Entrapment',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Control crushing and trapping between the platform, structure, ceiling, beams, pipework or other obstacles. Use a spotter or other control where visibility is restricted and maintain effective communication.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '16. Traffic & Pedestrian Interface',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Separate MEWP operations from vehicles and pedestrians using suitable barriers, exclusion zones, signs, traffic controls and spotters where required. Control reversing, blind areas and interaction with mobile plant.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '17. Wind & Weather',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Operate only within manufacturer and site weather limits. Stop or lower the platform when wind, lightning, heavy rain, poor visibility, sandstorms or other conditions make operation unsafe.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '18. Working Near Edges, Openings & Excavations',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Maintain safe clearance from unprotected edges, excavations, shafts, slopes and floor openings. Assess ground failure and overturning risk, especially when travelling or positioning close to an edge.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '19. Dropped Objects & Exclusion Zones',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Prevent tools and materials from falling from the platform. Secure suitable tools, maintain housekeeping and establish exclusion zones below or around elevated work where people or property could be exposed.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '20. Tools, Materials & Attachments',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Use only tools and attachments permitted by the manufacturer and risk assessment. Do not use the platform as a crane, lifting point or material-handling device unless specifically designed and approved for that purpose.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '21. Pre-Use Inspection',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Before each use or shift, inspect controls, emergency stop, alarms, guardrails, gate, tyres or wheels, hydraulic systems, leaks, batteries or fuel system, steering, brakes, emergency lowering, structural components, decals and safety devices.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '22. Thorough Examination & Maintenance',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Maintain required examination, inspection, servicing and repair records. Defects affecting safe operation shall be reported, the machine removed from service where necessary, and repairs completed by competent personnel before return to use.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '23. Operator Competency',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Only trained, authorised and competent operators shall operate the MEWP. Competency shall cover the machine type, controls, hazards, manufacturer instructions, pre-use inspection, emergency procedures and site-specific risks.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '24. Supervisor & HSE Responsibilities',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Supervisors shall verify suitable equipment, competent operators, RAMS/JSA, site controls, exclusion zones and emergency arrangements. HSE personnel shall monitor compliance, inspect controls and ensure unsafe conditions are escalated.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '25. Communication & Spotter',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Establish reliable communication between operator, ground personnel, spotter and supervisor where required. Agree signals before work starts. A spotter shall not be used as a substitute for proper visibility or engineered controls.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '26. Charging, Fuel & Energy Safety',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Control battery charging, refuelling and energy sources in designated areas. Prevent ignition sources, spills, incompatible charging arrangements and exposure to hazardous energy. Follow manufacturer requirements for batteries and fuel systems.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '27. Safe Operating Procedure',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Plan the route, inspect the machine, establish the work zone, position on suitable ground, complete functional checks, elevate smoothly, maintain clearances, perform the task within capacity and lower the platform safely before relocation.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '28. Parking, Shutdown & Transport',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Lower the platform fully where required, park on a suitable surface, isolate or secure the machine according to manufacturer instructions and prevent unauthorised use. Apply transport and tie-down requirements when moving the machine between locations.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '29. Rescue & Emergency',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Provide a practical rescue plan before elevated work starts. Operators and ground personnel shall know emergency lowering and communication procedures. Rescue arrangements shall consider operator incapacity, entrapment, power failure, machine failure and medical emergencies.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '30. PPE',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Provide PPE based on the risk assessment, including safety footwear, hard hat, high-visibility clothing, eye protection, hearing protection, gloves and fall-protection equipment where applicable. PPE shall complement, not replace, engineering controls.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '31. Stop-Work Conditions',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Stop operation for loss of stability, defective safety devices, failed inspection, excessive wind, lightning, unsafe ground, uncontrolled electrical exposure, overloaded platform, loss of communication, collision risk, unauthorised operation or any condition outside manufacturer limits.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '32. Unsafe Practices → Corrective Actions',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Correct unsafe acts such as climbing guardrails, overloading, moving with unsafe elevation, bypassing alarms, using improvised access, operating near uncontrolled power lines or working outside weather limits. Stop, isolate the hazard, correct the control and reauthorise work.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '33. Toolbox Talk',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Brief workers on machine type, task limits, ground conditions, exclusion zones, overhead hazards, fall protection, communication, traffic interface, weather, emergency lowering, rescue arrangements and stop-work authority before the activity.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '34. Field Checklist',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Verify machine identification; valid inspection/examination status; operator competency; pre-use inspection; emergency controls; guardrails and gate; ground condition; capacity; overhead services; exclusion zone; traffic control; weather; PPE; communication; rescue plan; housekeeping; defect reporting.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '35. Quick Reference',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'FIELD RULE: SELECT the right MEWP. INSPECT before use. CHECK ground and overhead hazards. STAY within the platform. RESPECT capacity and manufacturer limits. CONTROL people and vehicles. MONITOR weather. KNOW the rescue plan. STOP when conditions become unsafe.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '36. UAE / Abu Dhabi / Dubai Applicability',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'For Abu Dhabi, apply the current ADOSH-SF requirements and relevant sector or authority requirements. MEWP controls are specifically addressed within ADOSH-SF CoP 36.0 Plant and Equipment, alongside related requirements for working at height, overhead services, electrical safety, traffic and lifting where applicable. Dubai and other jurisdictions shall be checked against their own current requirements.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '37. Related CoPs & Cross-References',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Relevant Abu Dhabi references include CoP 36.0 Plant and Equipment; CoP 23.0 Working at Heights; CoP 39.0 Overhead and Underground Services; CoP 15.0 Electrical Safety; CoP 33.0 Working On or Adjacent to a Road; CoP 44.0 Traffic Management and Logistics; and other applicable CoPs based on the task.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '38. Official Regulatory References',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Primary official reference: Abu Dhabi Public Health Centre (ADPHC), ADOSH-SF CoP 36.0 Plant and Equipment, Version 4.1, effective 27 February 2026. The official CoP states that plant includes equipment that lifts people, such as MEWPs, and addresses risk assessment, controls, maintenance, inspection, records and responsibilities. Verify the current ADPHC registry and applicable authority requirements before relying on legal or numerical requirements.',
      ),
    ],
  ),
];

// ===== SOURCE: abu_dhabi_plant_equipment_gold.dart =====
class AbuDhabiPlantEquipmentGoldPoint {
  final String title;
  final String content;

  const AbuDhabiPlantEquipmentGoldPoint({
    required this.title,
    required this.content,
  });
}

class AbuDhabiPlantEquipmentGoldSection {
  final String number;
  final String title;
  final List<AbuDhabiPlantEquipmentGoldPoint> points;

  const AbuDhabiPlantEquipmentGoldSection({
    required this.number,
    required this.title,
    required this.points,
  });
}

const List<AbuDhabiPlantEquipmentGoldSection> abuDhabiPlantEquipmentGoldStandardSections = [
  AbuDhabiPlantEquipmentGoldSection(
    number: '01',
    title: 'Plant & Equipment General',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Selection, suitability, manufacturer instructions, risk assessment, competent operators, inspection, maintenance, guarding, exclusion zones, safe operating limits and emergency arrangements.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '02',
    title: 'Mobile Plant General',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Site traffic controls, pedestrian segregation, reversing controls, blind spots, seat belts, alarms, cameras, banksman/spotter arrangements, parking, isolation and unauthorised use.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '03',
    title: 'Cranes & Lifting Machines',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Crane selection, configuration, rated capacity, lifting plan, ground conditions, setup, load charts, radius, boom/jib controls, exclusion zones, weather, communication and emergency arrangements.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '04',
    title: 'Mobile Cranes',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Carrier stability, outriggers, mats, ground bearing, travel configuration, setup, slew radius, overhead services, counterweights, transport and manufacturer limitations.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '05',
    title: 'Crawler Cranes',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Crawler stability, tracking, jib configuration, ground conditions, assembly/disassembly, support of jib components, barriers and controlled lifting zones.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '06',
    title: 'Tower Cranes',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Foundation, mast, ties, climbing, load charts, anti-collision, limit switches, wind controls, inspection, operator competency, exclusion zones and emergency lowering.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '07',
    title: 'Overhead / Gantry Cranes',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Rated load marking, hoist condition, travel controls, anti-collision where required, hook and lifting accessory condition, load path, no suspended-person exposure and controlled maintenance.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '08',
    title: 'Truck / Vehicle Mounted Cranes',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Vehicle stability, parking, outriggers, load distribution, setup, traffic controls, overhead services, loading areas and safe transport configuration.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '09',
    title: 'Forklifts / Powered Lift Trucks',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Operator competence, load capacity, stability triangle, forks, mast, attachments, seat belt, speed control, pedestrian segregation, reversing, ramps, loading and parking.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '10',
    title: 'Telehandlers',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Rated capacity/load chart, attachment selection, boom position, stability, ground conditions, exclusion zones, travel, lifting and prohibited improvised uses.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '11',
    title: 'MEWP / Access Platforms',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Scissor and boom platforms, ground stability, guardrails, fall protection, overhead hazards, wind, capacity, pre-use inspection, emergency lowering and rescue.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '12',
    title: 'Excavators',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Stability, slew radius, attachments, digging near services, excavation edges, lifting limitations, operator visibility, exclusion zones, maintenance and safe shutdown.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '13',
    title: 'Loaders',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Bucket loading, stability, visibility, travel routes, stockpile faces, attachment security, pedestrian separation, reversing and parking.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '14',
    title: 'Bobcat / Skid Steer',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Attachment locking, rollover protection, operator restraint, visibility, reversing, bucket position, exclusion zones, travel stability and hydraulic safety.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '15',
    title: 'Bulldozers / Dozers',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Blade controls, slopes, edge protection, ground stability, reversing, visibility, rollover protection, transport and maintenance isolation.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '16',
    title: 'Wheel / Road Rollers',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Slope and edge hazards, vibration, reversing, pedestrian separation, seat restraints, visibility, water systems, parking and transport.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '17',
    title: 'Compactors & Soil Equipment',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Operating surface, vibration, slope stability, underground services, pedestrian interface, maintenance isolation and safe transport.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '18',
    title: 'Concrete Plant & Placing Equipment',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Concrete pumps, placing booms, hoses, pressure, line blockage, coupling security, exclusion zones, overhead services, cleaning and maintenance isolation.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '19',
    title: 'Compressors & Compressed-Air Plant',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Pressure vessels, hoses, couplings, whip checks where applicable, relief devices, noise, stored energy, isolation, air quality and safe depressurisation.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '20',
    title: 'Generators & Power Generation Plant',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Electrical protection, earthing, fuel, exhaust, ventilation, back-feeding prevention, cable routing, fire controls, weather protection and maintenance.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '21',
    title: 'Welding / Cutting Equipment',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Equipment condition, electrical controls, gas systems, cylinders, hoses, flashback protection where applicable, ventilation, fire prevention, hot-work permit and PPE.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '22',
    title: 'Gas Cylinders & Gas Handling',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Identification, segregation, securing, transport, regulators, hoses, leak checks, valve protection, ignition control, storage and emergency response.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '23',
    title: 'Lifting Equipment & Accessories',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Slings, shackles, hooks, lifting beams, spreader beams, chains, wire ropes, inspection, WLL/SWL, identification, compatibility, storage and rejection criteria.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '24',
    title: 'Rigging & Banksman / Signaller',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Lift planning, centre of gravity, sling angles, communication, tag lines where suitable, exclusion zones, hand signals, radio protocol and control of suspended loads.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '25',
    title: 'Earthmoving Attachments',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Buckets, breakers, forks, grabs and other attachments shall be compatible, securely connected, inspected and used only within manufacturer limits.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '26',
    title: 'Hydraulic & Pneumatic Systems',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Stored pressure, hose condition, couplings, injection hazards, isolation, depressurisation, guarding, leaks, maintenance and safe testing.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '27',
    title: 'Machine Guarding',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Fixed and interlocked guards, nip points, rotating parts, belts, chains, shafts, access doors, emergency stops and prevention of bypassing safety devices.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '28',
    title: 'Plant Maintenance & LOTO',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Planned maintenance, competent technicians, isolation of electrical/hydraulic/pneumatic/mechanical energy, stored-energy release, lockout/tagout and controlled return to service.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '29',
    title: 'Pre-Use Inspection',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Check structure, controls, brakes, steering, tyres/tracks, attachments, guards, alarms, lights, leaks, safety devices, emergency controls and documentation before use.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '30',
    title: 'Thorough Examination & Certification',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Maintain legally and manufacturer-required examinations, inspection records, certificates, defect records, maintenance history and equipment identification. Do not operate equipment with unresolved critical defects.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '31',
    title: 'Plant Transport & Loading',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Select suitable transport, secure plant, control ramps, loading surfaces, height/width restrictions, exclusion zones, banksman assistance and tie-down arrangements.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '32',
    title: 'Fuel, Battery & Charging Safety',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Control refuelling, battery charging, ignition sources, spills, ventilation, hydrogen or other gases where applicable, electrical connections and emergency arrangements.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '33',
    title: 'Work Near Services',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Identify overhead and underground services before plant movement, excavation or lifting. Apply authority/utility controls, exclusion zones, barriers and competent supervision.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '34',
    title: 'Traffic & Pedestrian Interface',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Use traffic management plans, segregated walkways, crossings, barriers, signage, lighting, speed controls, reversing controls and trained banksmen where required.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '35',
    title: 'Environmental & Weather Controls',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Assess heat, wind, rain, sand, dust, visibility, lightning and ground deterioration. Follow manufacturer limits and stop operation when conditions become unsafe.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '36',
    title: 'Operator Competency & Supervision',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Operators shall be trained, competent and authorised for the specific plant type. Supervisors shall verify competence, task controls, inspections, exclusion zones and safe operating conditions.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '37',
    title: 'Emergency, Rescue & Stop Work',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Plan for overturning, collision, entrapment, fire, electrical contact, hydraulic failure, suspended-load incidents and medical emergencies. Stop work for critical defects, instability, uncontrolled interfaces or conditions outside approved limits.',
      ),
    ],
  ),
  AbuDhabiPlantEquipmentGoldSection(
    number: '38',
    title: 'UAE / Abu Dhabi Applicability & Official References',
    points: [
      AbuDhabiPlantEquipmentGoldPoint(
        title: 'Key Controls',
        content: 'Use the current ADPHC/ADOSH-SF Code of Practices and applicable sector/authority requirements. Primary references include CoP 36.0 Plant and Equipment V4.1, CoP 34.0 Safe Use of Lifting Equipment and Lifting Accessories V4.1, CoP 51.0 Powered Lift Trucks V4.1, CoP 38.0 Concrete Placing Equipment V4.1, CoP 39.0 Overhead and Underground Services V4.1, CoP 47.0 Machine Guarding V4.1 and CoP 49.0 Compressed Gases and Air V4.1. Verify the official registry before relying on legal or numerical requirements.',
      ),
    ],
  ),
];


// ===== COMPREHENSIVE PLANT & EQUIPMENT SUBJECT REGISTRY =====
class PlantEquipmentSubject {
  final String category;
  final String title;
  final String status;
  const PlantEquipmentSubject({
    required this.category,
    required this.title,
    required this.status,
  });
}

const abuDhabiPlantEquipmentSubjectRegistry = <PlantEquipmentSubject>[
  // Lifting
  PlantEquipmentSubject(category: "Lifting", title: "Mobile Crane", status: "Gold"),
  PlantEquipmentSubject(category: "Lifting", title: "Crawler Crane", status: "Gold"),
  PlantEquipmentSubject(category: "Lifting", title: "Tower Crane", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Lifting", title: "Truck-Mounted Crane", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Lifting", title: "Rough Terrain Crane", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Lifting", title: "All Terrain Crane", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Lifting", title: "Pick-and-Carry Crane", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Lifting", title: "Overhead / EOT Crane", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Lifting", title: "Gantry Crane", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Lifting", title: "Hoist", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Lifting", title: "Winch", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Lifting", title: "Lifting Accessories", status: "Gold within lifting chapter"),
  PlantEquipmentSubject(category: "Lifting", title: "Rigging / Slinging", status: "Gold within lifting chapter"),

  // Mobile plant
  PlantEquipmentSubject(category: "Earthmoving", title: "Excavator", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Earthmoving", title: "Backhoe Loader", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Earthmoving", title: "Wheel Loader", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Earthmoving", title: "Skid Steer / Bobcat", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Earthmoving", title: "Bulldozer", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Earthmoving", title: "Motor Grader", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Earthmoving", title: "Compactor / Roller", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Earthmoving", title: "Dump Truck / Tipper", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Earthmoving", title: "Water Tanker", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Earthmoving", title: "Vacuum Excavator", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Material Handling", title: "Forklift / Powered Lift Truck", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Material Handling", title: "Telehandler", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Access", title: "MEWP / EWP", status: "Gold"),
  PlantEquipmentSubject(category: "Access", title: "Scissor Lift", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Access", title: "Boom Lift", status: "Registry / expand"),

  // Construction equipment
  PlantEquipmentSubject(category: "Concrete", title: "Concrete Pump", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Concrete", title: "Concrete Placing Equipment", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Concrete", title: "Concrete Batching Plant", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Concrete", title: "Concrete Mixer", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Concrete", title: "Vibrator", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Temporary Works", title: "Temporary Support / Falsework Equipment", status: "Registry / expand"),

  // Power / utility
  PlantEquipmentSubject(category: "Power", title: "Diesel Generator", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Power", title: "Electrical Generator", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Compressed Air", title: "Air Compressor", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Compressed Air", title: "Air Receiver", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Welding", title: "Welding Machine", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Welding", title: "Gas Cutting Set", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Welding", title: "Gas Cylinders / Manifold", status: "Registry / expand"),

  // Tools
  PlantEquipmentSubject(category: "Portable Tools", title: "Angle Grinder", status: "Gold within power tools"),
  PlantEquipmentSubject(category: "Portable Tools", title: "Drilling Machine", status: "Gold within power tools"),
  PlantEquipmentSubject(category: "Portable Tools", title: "Cutting Tools", status: "Gold within power tools"),
  PlantEquipmentSubject(category: "Portable Tools", title: "Circular / Cut-Off Saw", status: "Gold within power tools"),
  PlantEquipmentSubject(category: "Portable Tools", title: "Impact / Torque Tools", status: "Gold within power tools"),
  PlantEquipmentSubject(category: "Portable Tools", title: "Pneumatic Tools", status: "Gold within power tools"),
  PlantEquipmentSubject(category: "Portable Tools", title: "Hydraulic Tools", status: "Gold within power tools"),
  PlantEquipmentSubject(category: "Portable Tools", title: "Battery Tools", status: "Gold within power tools"),
  PlantEquipmentSubject(category: "Portable Tools", title: "Hand Tools", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Abrasive Equipment", title: "Abrasive Wheels", status: "Gold within power tools"),

  // Specialist / other
  PlantEquipmentSubject(category: "Access", title: "Ladders", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Plant", title: "Machine Guarding", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Plant", title: "Conveyors", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Plant", title: "Material Handling Equipment", status: "Registry / expand"),
  PlantEquipmentSubject(category: "Plant", title: "Vehicle and Reversing Systems", status: "Registry / expand"),
];
