/// SafeNexus HSE — Abu Dhabi HSE Reference
/// Step 5AJ Part 1 — Machine Guarding, Compressed Air/Gas, Electrical/Generator & Specialist Plant Interfaces
/// Audit / reference module — book-level structured content.
/// Regulatory basis: ADPHC/ADOSH-SF CoP 36.0 V4.1; related CoP 47.0 V4.1, CoP 49.0 V4.1 and CoP 15.0 V4.0; current official registry verification required.
///
/// IMPORTANT: This module is a structured field reference. It does not
/// replace the current official ADPHC/ADOSH-SF Code of Practice,
/// manufacturer instructions, project HSE plan, RAMS/JSA, permits,
/// competent-person requirements or other applicable authority rules.
/// Numeric/legal requirements must be verified against the current
/// applicable official source before a compliance decision is made.

class PlantInterfaceGoldPoint {
  final String title;
  final List<String> points;
  const PlantInterfaceGoldPoint({required this.title, required this.points});
}

class PlantInterfaceGoldSection {
  final String number;
  final String title;
  final List<PlantInterfaceGoldPoint> points;
  const PlantInterfaceGoldSection({required this.number, required this.title, required this.points});
}

const List<PlantInterfaceGoldSection> abuDhabiPlantInterfaceGoldSections = [
  PlantInterfaceGoldSection(
    number: '01',
    title: 'Purpose and audit philosophy',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Use this module to connect plant and equipment hazards with the specialist controls already covered elsewhere in the SafeNexus HSE Reference.',
          'An interface is not a duplicate equipment chapter; it identifies where a plant hazard crosses into another specialist safety subject.',
          'Apply IDENTIFY → ASSESS → ELIMINATE → CONTROL → VERIFY → MONITOR → REVIEW → IMPROVE.',
          'Treat the current official ADPHC Code of Practice registry as the regulatory source of truth for Abu Dhabi applicability and version status.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Use project-specific requirements, manufacturer instructions and competent-person controls in addition to the general reference.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '02',
    title: 'Machine guarding — scope',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Machine guarding applies to accessible moving parts that can cause crushing, shearing, entanglement, drawing-in, cutting, impact or ejection.',
          'Typical interfaces include conveyors, rotating shafts, belts, chains, couplings, gears, pulleys, fans, saws, drills, mixers and processing equipment.',
          'Guarding is an engineering control; PPE must not be treated as a substitute for effective guarding.',
          'Identify fixed guards, interlocked guards, adjustable guards and other protective devices fitted to the actual machine.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Verify that guarding remains effective after maintenance, adjustment, cleaning or relocation.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '03',
    title: 'Machine guarding — hazard identification',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Look for nip points, in-running points, rotating shafts, exposed couplings, belts, chains, blades, cutting edges and ejection zones.',
          'Check whether a person can reach the dangerous part through, over, under or around the guard.',
          'Look for missing fasteners, damaged mesh, excessive openings, defeated interlocks and makeshift guards.',
          'Observe whether operators routinely remove guards to clear jams or speed up production.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Check whether maintenance access creates exposure to stored mechanical, hydraulic, pneumatic or electrical energy.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '04',
    title: 'Machine guarding — safe controls',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Prefer elimination or redesign of the dangerous access point before relying on administrative controls.',
          'Use guards designed for the machine and task; guards must be secure, robust and compatible with operation and maintenance.',
          'Interlocks must prevent access to danger while hazardous movement or energy remains present as designed.',
          'Where guarding cannot fully prevent exposure, use suitable supplementary controls such as safe distances, presence sensing or controlled operating procedures as applicable.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Keep guarding arrangements consistent with the machine manufacturer and approved modification process.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '05',
    title: 'Machine guarding — isolation interface',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Before maintenance, cleaning, jam clearing or guard removal, identify all energy sources and apply the approved isolation procedure.',
          'Electrical isolation may need to be combined with hydraulic, pneumatic, mechanical, gravity, thermal and stored-energy controls.',
          'Do not assume stopping the motor removes all hazardous stored energy.',
          'Verify zero-energy state using the approved method before entering the danger zone.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Restore guards and verify safe operation before returning equipment to service.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '06',
    title: 'Machine guarding — inspection and verification',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Include guard condition in pre-use or planned inspection according to the equipment and project inspection regime.',
          'Check fasteners, hinges, mesh, panels, interlocks, switches and warning signs.',
          'Confirm no tools, temporary materials or hoses create an opening that defeats the guard.',
          'Record defects and remove unsafe equipment from service when protection is ineffective.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Verify corrective action at the machine, not only by closing the paperwork.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '07',
    title: 'Compressed air — interface',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Compressed-air equipment may create stored-energy, hose-whip, projectile, noise, dust and pressure-release hazards.',
          'Identify compressors, air receivers, hoses, couplings, blow guns, pneumatic tools and isolation points.',
          'Inspect hoses for cuts, abrasion, bulges, damaged couplings and unsuitable repairs.',
          'Prevent uncontrolled hose movement by using suitable connection and restraint arrangements where required.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Never direct compressed air at people or use it to clean clothing or the body.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '08',
    title: 'Compressed air — receiver and pressure controls',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Verify the air receiver is suitable, maintained and subject to the applicable inspection and statutory requirements.',
          'Check pressure gauges, relief devices, drains and isolation arrangements for serviceability.',
          'Do not exceed the rated pressure of the receiver, hose, tool, fitting or accessory.',
          'Control condensate and drainage according to the equipment procedure and environmental requirements.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Treat pressure vessels and compressed systems as stored-energy systems until safely isolated and depressurised.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '09',
    title: 'Compressed air — pneumatic tools',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Match the tool to the supply pressure, flow and hose specification stated by the manufacturer.',
          'Use correct couplings and fittings; prevent incompatible connections.',
          'Isolate and depressurise before changing accessories or disconnecting a hose where required.',
          'Control noise, vibration and flying particles generated by pneumatic tools.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Secure hoses away from traffic, sharp edges, hot surfaces and moving equipment.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '10',
    title: 'Gas interface — cylinders',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Identify gas type, hazard class, cylinder condition, valve condition and storage requirements before use.',
          'Keep cylinders secured against falling and protect valves from damage during handling and storage.',
          'Separate incompatible gases and follow the applicable storage and segregation requirements.',
          'Keep cylinders away from heat, ignition sources and areas where mechanical damage is likely.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Use the correct regulator, hose, connection and equipment for the gas and service.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '11',
    title: 'Gas interface — leakage and emergency',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Treat an unidentified or suspected gas leak as an emergency until assessed by competent personnel.',
          'Do not operate electrical or ignition sources in a potentially flammable atmosphere unless the emergency procedure permits it.',
          'Move people to a safe location and follow the site\'s emergency response and gas-release procedure.',
          'Use gas detection where the risk assessment requires it; do not rely on smell as a safety control.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Do not attempt repairs to cylinders or pressure equipment outside authorised competent arrangements.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '12',
    title: 'Gas cutting and welding interface',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Integrate compressed-gas controls with the Hot Work module and applicable permit requirements.',
          'Inspect hoses, regulators, flashback protection where required, connections and cylinder arrangements before use.',
          'Keep oxygen equipment free from oil or grease contamination where applicable.',
          'Route hoses to avoid damage, trip hazards and contact with hot work.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Close valves and isolate equipment when the work is complete or during extended interruption according to the approved procedure.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '13',
    title: 'Electrical interface — temporary power',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Plant supplied from temporary electrical systems must use suitable distribution, protective devices, earthing and cable management.',
          'Protect cables from crushing, cutting, water, traffic and heat.',
          'Do not use damaged plugs, leads, sockets or improvised joints.',
          'Electrical modifications and repairs must be performed by authorised competent persons.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Verify inspection and testing arrangements after installation, movement, modification or damage as applicable.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '14',
    title: 'Electrical interface — portable plant',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Select electrical equipment for the voltage, environment, duty and task.',
          'Inspect cords, plugs, enclosures, guards, switches and protective devices before use.',
          'Remove damaged equipment from service and prevent accidental reuse.',
          'Use suitable residual-current and other protective arrangements where required by the applicable system.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Keep electrical equipment away from water and conductive contamination unless specifically designed and controlled for that environment.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '15',
    title: 'Generator interface',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Generators require coordinated controls for fuel, exhaust, fire, electrical output, earthing, noise, hot surfaces and moving parts.',
          'Position generators to control exhaust exposure and maintain suitable ventilation and clearance from combustible materials.',
          'Use appropriate distribution equipment and protection for the connected load.',
          'Prevent unauthorised connection to building or site systems; use approved changeover or isolation arrangements where applicable.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Inspect fuel lines, electrical connections, guards, emergency stop and condition before operation.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '16',
    title: 'Generator fuel and fire interface',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Store and handle fuel according to applicable fire, environmental and site requirements.',
          'Stop and isolate the generator before maintenance or fuel-related intervention where required.',
          'Control ignition sources and hot surfaces around fuel handling.',
          'Provide appropriate spill response and firefighting arrangements based on the risk assessment.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Investigate leaks, repeated trips, overheating or abnormal exhaust as equipment-condition warning signs.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '17',
    title: 'Remaining specialist plant — identification',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Specialist plant must be identified from the project plant register, method statements, procurement records and actual site walkdowns.',
          'Do not assume a generic equipment list covers every project; project scope determines the plant population.',
          'Classify specialist plant by energy source, movement, stored energy, lifting function, ground interaction, excavation function and process hazard.',
          'Examples may include piling rigs, drilling rigs, vacuum excavation systems, milling equipment, specialist pumps and process-specific machinery.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Each identified item should have a named owner, inspection arrangement, competent-user requirement and emergency response interface.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '18',
    title: 'Specialist plant — selection and suitability',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Confirm the equipment is suitable for the terrain, load, reach, environment, task and intended duty.',
          'Review manufacturer limits, ground-bearing needs, access requirements and exclusion zones before mobilisation.',
          'Check compatibility with other plant, overhead services, underground services and simultaneous operations.',
          'Where attachments or modifications are used, verify compatibility and approval before use.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Do not allow production pressure to override equipment suitability.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '19',
    title: 'Specialist plant — mobilisation',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Plan delivery, unloading, assembly, commissioning and demobilisation before the equipment reaches site.',
          'Confirm transport route, turning space, overhead clearance, ground condition and exclusion areas.',
          'Control assembly and commissioning with competent persons and the manufacturer\'s procedure.',
          'Complete required inspection, testing and documentation before operational use.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Brief the work team on emergency shutdown, isolation and recovery arrangements.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '20',
    title: 'Specialist plant — operational controls',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Define operating zones, pedestrian segregation, communication methods and exclusion areas.',
          'Use competent operators and task-specific training where required.',
          'Control reversing, blind spots, line-of-fire exposure and interaction with other plant.',
          'Monitor ground and weather conditions that can change stability or machine performance.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Stop work when a critical control is absent, ineffective or unexpectedly changed.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '21',
    title: 'Specialist plant — maintenance interface',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Planned maintenance must address wear, safety devices, guards, hoses, tyres/tracks, brakes, steering and structural condition as applicable.',
          'Use isolation and stored-energy controls before maintenance.',
          'Prevent unauthorised operation during maintenance using the approved lockout or control method.',
          'Record maintenance defects and release equipment only after competent verification.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Do not return equipment to service merely because a temporary workaround appears functional.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '22',
    title: 'Specialist plant — emergency and recovery',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Define emergency shutdown and isolation before work starts.',
          'Plan recovery for bogging, rollover, breakdown, loss of power, hydraulic failure, fire and contact with services as applicable.',
          'Do not improvise recovery using unsuitable lifting points, ropes, chains or another machine.',
          'Establish exclusion zones during recovery because stored energy and unexpected movement may occur.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Report incidents and near misses and review the risk assessment before resuming.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '23',
    title: 'Interface with lifting operations',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Where plant lifts suspended loads, apply the lifting-equipment controls rather than treating the machine only as mobile plant.',
          'Verify rated capacity, lifting configuration, approved attachment and load-control arrangements.',
          'Keep people out of suspended-load and crush zones.',
          'Coordinate lift plans, communication and exclusion zones with the lifting team.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Use current inspection and certification arrangements required for the equipment and lifting configuration.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '24',
    title: 'Interface with excavation and underground services',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Plant working near excavation edges must be controlled for surcharge, ground instability and unintended entry.',
          'Identify underground services before digging and use the applicable permit-to-dig/service-location controls.',
          'Maintain the required safe working arrangement for the actual service, equipment and authority requirements.',
          'Prevent plant from undermining excavation support or approaching unstable edges.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Use banksmen or other controls where visibility and proximity risks require them.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '25',
    title: 'Interface with traffic and pedestrians',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Separate plant and pedestrians using physical segregation where practicable.',
          'Define one-way systems, crossing points, reversing controls and speed controls in the traffic plan.',
          'Use suitable lighting, alarms, cameras, mirrors or trained spotters according to the risk.',
          'Never rely solely on a reversing alarm where the person may still enter the danger zone.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Review routes after changes to work fronts, deliveries or temporary works.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '26',
    title: 'Noise, vibration and occupational health interface',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Identify plant producing significant noise or vibration and assess exposure where required.',
          'Prefer quieter equipment, engineering controls, maintenance and exposure reduction before relying on PPE.',
          'Consider whole-body vibration for operators of mobile plant and hand-arm vibration for tools and controls.',
          'Maintain seats, tyres, tracks and machine components to reduce unnecessary vibration.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Integrate occupational health monitoring where exposure and applicable requirements warrant it.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '27',
    title: 'Environmental and spill interface',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Control fuel, oil, hydraulic-fluid and chemical leaks from plant.',
          'Provide suitable spill response equipment where the risk assessment requires it.',
          'Prevent discharge to drains, soil or water and follow project environmental controls.',
          'Store waste filters, contaminated absorbents and used fluids in designated arrangements.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Investigate recurring leaks as equipment defects rather than repeatedly cleaning the symptom.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '28',
    title: 'Weather and visibility interface',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Assess wind, rain, heat, dust, fog and reduced visibility for the specific plant.',
          'Follow manufacturer limits and project restrictions for adverse weather.',
          'Increase separation and reduce operations when visibility is inadequate.',
          'Inspect ground conditions after heavy rain or flooding before plant movement.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Apply heat-stress controls to operators and ground crews exposed to Abu Dhabi conditions.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '29',
    title: 'Competency and authorization',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Define the competency required for each equipment type and task.',
          'Verify operator authorization, training, familiarisation and task-specific competence before use.',
          'Specialist attachments and configurations may require additional competence beyond basic machine operation.',
          'Supervisors must verify competence rather than assuming experience equals authorization.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Maintain training and authorization records according to the project system.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '30',
    title: 'Inspection, records and traceability',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Maintain equipment identification and traceability so inspection records can be matched to the actual machine.',
          'Record pre-use checks, periodic inspections, maintenance, defects, tests and corrective actions as applicable.',
          'Do not accept an inspection sticker as the only evidence when the underlying record is required.',
          'Make defects visible to users and prevent unsafe equipment from returning to service.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Review repeated defects for fleet-level corrective action.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '31',
    title: 'Stop-work triggers',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Stop when a guard, interlock, brake, steering, emergency stop, lifting device, pressure-control device or other critical safety function is defective.',
          'Stop when the equipment exceeds its rated capacity or manufacturer operating limits.',
          'Stop when ground, weather, visibility or surrounding conditions make safe operation uncertain.',
          'Stop when an unauthorised modification, attachment or repair is identified.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Stop when an underground/overhead service, person or other critical interface enters the uncontrolled danger zone.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '32',
    title: 'Field verification checklist',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Identity and equipment condition verified.',
          'Correct operator and task authorization verified.',
          'Pre-use inspection completed.',
          'Critical guards and safety devices functional.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Energy sources and isolation points identified.',
          'Work area, ground, traffic and pedestrian controls established.',
          'RAMS/JSA and permit requirements understood where applicable.',
          'Emergency shutdown, recovery and communication arrangements briefed.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 3',
        points: [
          'Defects and corrective actions recorded and closed.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '33',
    title: 'Official-reference and change-control rule',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Use the current ADPHC Code of Practice registry as the starting point for Abu Dhabi regulatory version checking.',
          'CoP 36.0 Plant and Equipment is currently listed by ADPHC as Version 4.1 effective 27 February 2026.',
          'CoP 47.0 Machine Guarding is currently listed as Version 4.1 effective 27 February 2026.',
          'CoP 49.0 Compressed Gases and Air is currently listed as Version 4.1 effective 27 February 2026.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'CoP 15.0 Electrical Safety is currently listed as Version 4.0 effective 15 July 2024; verify again before compliance decisions because the official registry can change.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '34',
    title: 'Cross-reference map',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Machine guarding ↔ CoP 47.0 ↔ plant-specific guarding and isolation.',
          'Compressed air/gas ↔ CoP 49.0 ↔ hot work, pressure systems, pneumatic tools and emergency response.',
          'Electrical/generator ↔ CoP 15.0 and applicable isolation requirements ↔ temporary power and fire controls.',
          'Plant and equipment ↔ CoP 36.0 ↔ lifting, powered lift trucks, concrete placing equipment, portable power tools and traffic interfaces.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Use the dedicated SafeNexus topic module for detailed specialist controls instead of duplicating the same content in this interface chapter.',
        ],
      ),
    ],
  ),
  PlantInterfaceGoldSection(
    number: '35',
    title: 'Audit closure',
    points: [
      PlantInterfaceGoldPoint(
        title: 'Field controls 1',
        points: [
          'Record defects with equipment identification, location, risk, immediate action, responsible person and closure evidence.',
          'Where a manufacturer requirement is more stringent than a generic site rule, follow the applicable manufacturer requirement.',
          'Do not defeat, bypass, remove or modify a safety device without an approved engineering and management process.',
          'Reassess the task after abnormal conditions, near misses, equipment damage, changes in method or changes in surrounding work.',
        ],
      ),
      PlantInterfaceGoldPoint(
        title: 'Field controls 2',
        points: [
          'Close the interface audit only after every identified plant item has an owner, applicable specialist references and a verified control path.',
          'Any gap that changes regulatory applicability must be escalated for current-source verification before the project treats the reference as complete.',
        ],
      ),
    ],
  ),
];
