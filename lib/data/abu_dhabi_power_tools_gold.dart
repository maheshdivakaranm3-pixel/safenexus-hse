import 'package:flutter/material.dart';

/// Abu Dhabi HSE Gold Standard — CoP 35.0 Portable Power Tools
///
/// Regulatory basis:
/// ADOSH-SF CoP 35.0 - Portable Power Tools, Version 4.1,
/// effective 16 February 2026.
///
/// This file is a structured knowledge source. Project-specific RAMS,
/// manufacturer instructions, risk assessments, permits and competent-person
/// requirements remain applicable and must be checked before work.

class PowerToolsGoldPoint {
  final String title;
  final List<String> points;

  const PowerToolsGoldPoint({
    required this.title,
    required this.points,
  });
}

class PowerToolsGoldSection {
  final String number;
  final String title;
  final List<PowerToolsGoldPoint> points;

  const PowerToolsGoldSection({
    required this.number,
    required this.title,
    required this.points,
  });
}

const List<PowerToolsGoldSection> portablePowerToolsGoldStandardSections = [
  PowerToolsGoldSection(
    number: '01',
    title: 'Definition & Purpose',
    points: [
      PowerToolsGoldPoint(title: 'Definition', points: [
        'Portable power tools are hand-held, portable or transportable tools powered by electricity, batteries, compressed air, hydraulic energy or other power sources.',
        'The purpose of this topic is to control injury from electrical energy, mechanical movement, stored energy, flying particles, heat, noise, vibration, dust, sparks and loss of control.',
      ]),
      PowerToolsGoldPoint(title: 'Core principle', points: [
        'Select the safest suitable tool, use the correct accessory, isolate energy before intervention, inspect before use and operate only within the manufacturer limits.',
        'Use the hierarchy of controls before relying on PPE.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '02',
    title: 'Scope & Applications',
    points: [
      PowerToolsGoldPoint(title: 'Typical applications', points: [
        'Construction, maintenance, fabrication, installation, shutdown, civil works and facility maintenance.',
        'Grinding, drilling, cutting, sanding, polishing, fastening, chipping, demolition and surface preparation.',
      ]),
      PowerToolsGoldPoint(title: 'Included tools', points: [
        'Electric, cordless/battery, pneumatic and hydraulic portable tools, including grinders, drills, saws, impact tools and portable cutting equipment.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '03',
    title: 'Types & Classification',
    points: [
      PowerToolsGoldPoint(title: 'Power source', points: [
        'Cordless/battery tools.',
        'Low-voltage or transformer-supplied electrical tools.',
        'Higher-voltage electrical tools protected by suitable RCD arrangements.',
        'Pneumatic and hydraulic tools.',
      ]),
      PowerToolsGoldPoint(title: 'Task classification', points: [
        'Rotating, cutting, abrasive, impact, drilling, fastening, chipping and surface-treatment tools require task-specific controls.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '04',
    title: 'Components & Safety Devices',
    points: [
      PowerToolsGoldPoint(title: 'Check components', points: [
        'Body/casing, switch, trigger, guard, spindle, chuck, blade or wheel, cable/plug, battery, hose, fittings and attachment points.',
        'Check manufacturer guards, handles, dead-man or constant-pressure controls and emergency-stop arrangements where applicable.',
      ]),
      PowerToolsGoldPoint(title: 'Never bypass', points: [
        'Do not remove, defeat, lock open or bypass guards, RCDs, safety switches, interlocks or other protective devices.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '05',
    title: 'Tool Selection & Planning',
    points: [
      PowerToolsGoldPoint(title: 'Selection', points: [
        'Choose a tool designed for the material, task, environment and duty cycle.',
        'Use the correct rated accessory and ensure its maximum permitted speed/rating is compatible with the tool.',
      ]),
      PowerToolsGoldPoint(title: 'Planning questions', points: [
        'What energy sources are present? What can eject? What can rotate? What can cut? Is there dust, noise, vibration, heat, water or flammable material?',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '06',
    title: 'Hazard Identification',
    points: [
      PowerToolsGoldPoint(title: 'Identify before starting', points: [
        'Electrical shock, burns and electrocution.',
        'Entanglement, cuts, crushing, kickback and loss of control.',
        'Flying fragments, broken wheels, blades and workpiece ejection.',
        'Noise, hand-arm vibration, dust/fume exposure, sparks and fire.',
        'Hydraulic injection, hose failure and stored pneumatic energy.',
      ]),
      PowerToolsGoldPoint(title: 'Field indicators', points: [
        'Damaged casing, exposed conductors, missing guard, abnormal noise, overheating, vibration, damaged accessory, leaking hose or defective trigger are stop-work indicators.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '07',
    title: 'Risk Assessment & Hierarchy of Controls',
    points: [
      PowerToolsGoldPoint(title: 'Control sequence', points: [
        'Eliminate the powered-tool task where practicable.',
        'Substitute with a safer process or lower-energy tool.',
        'Use engineering controls such as guards, extraction, isolation and RCD protection.',
        'Apply administrative controls, training, inspection, supervision and safe systems of work.',
        'Use PPE as the final layer, not the only control.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '08',
    title: 'Electrical Portable Tools',
    points: [
      PowerToolsGoldPoint(title: 'Abu Dhabi requirements', points: [
        'CoP 35.0 identifies a planning hierarchy of battery/cordless low-voltage tools, 110 V tools supplied through a step-down transformer, or 240 V tools protected by a 30 mA RCD as applicable to the work arrangement.',
        'Electrical portable tools must be maintained in good condition.',
        'Hand-held electrically operated portable tools should have a constant-pressure switch that requires continuous pressure to energize the tool.',
      ]),
      PowerToolsGoldPoint(title: 'Electrical checks', points: [
        'Inspect plug, cable, strain relief, casing, switch, earth continuity arrangements and protection before use.',
        'Keep connections protected from water, damage, traffic and unauthorised access.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '09',
    title: 'Battery & Cordless Tools',
    points: [
      PowerToolsGoldPoint(title: 'Battery safety', points: [
        'Use only approved batteries and chargers compatible with the tool.',
        'Inspect for swelling, cracking, leakage, overheating, damaged terminals or impact damage.',
        'Remove damaged batteries from service and follow the manufacturer disposal/quarantine procedure.',
      ]),
      PowerToolsGoldPoint(title: 'Charging', points: [
        'Charge in a designated, suitable location with adequate ventilation and fire precautions.',
        'Do not modify battery packs or use damaged chargers.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '10',
    title: 'Grinders & Abrasive Wheels',
    points: [
      PowerToolsGoldPoint(title: 'Critical controls', points: [
        'Use the correct wheel/disc for the material and tool.',
        'Confirm wheel condition, rating and compatibility before mounting.',
        'Keep the manufacturer guard correctly fitted and positioned.',
        'Use the auxiliary handle where provided and maintain a stable stance.',
      ]),
      PowerToolsGoldPoint(title: 'Grinding hazards', points: [
        'Wheel burst, kickback, flying fragments, sparks, burns, dust and noise.',
        'Do not use a cutting disc for side grinding unless specifically designed for that purpose.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '11',
    title: 'Drilling & Impact Tools',
    points: [
      PowerToolsGoldPoint(title: 'Controls', points: [
        'Secure the workpiece where practicable and select the correct bit/accessory.',
        'Keep hands away from the rotating point and use the correct auxiliary handle for high-torque tools.',
        'Check for hidden electrical, gas, water or communication services before drilling.',
      ]),
      PowerToolsGoldPoint(title: 'Hazards', points: [
        'Bit breakage, kickback, entanglement, dust, noise, vibration and contact with concealed services.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '12',
    title: 'Cutting Tools & Saws',
    points: [
      PowerToolsGoldPoint(title: 'Controls', points: [
        'Use the correct blade/disc, guard and cutting method.',
        'Support material to prevent binding or unexpected movement.',
        'Keep the line of cut clear of people and protect against flying fragments.',
      ]),
      PowerToolsGoldPoint(title: 'Stop conditions', points: [
        'Stop for binding, damaged blade, abnormal vibration, loss of guard, overheating or uncontrolled kickback.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '13',
    title: 'Pneumatic Tools',
    points: [
      PowerToolsGoldPoint(title: 'Controls', points: [
        'Inspect hoses, couplings, whip checks/restraints where required and tool connections.',
        'Isolate and depressurise the supply before disconnecting, changing accessories or servicing.',
        'Prevent hoses from creating trip hazards or being damaged by vehicles and sharp edges.',
      ]),
      PowerToolsGoldPoint(title: 'Hazards', points: [
        'Stored pressure, hose whip, flying particles, noise, vibration and accidental actuation.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '14',
    title: 'Hydraulic Tools',
    points: [
      PowerToolsGoldPoint(title: 'Controls', points: [
        'Inspect hoses, fittings, couplings and tool body before use.',
        'Isolate and release hydraulic pressure before maintenance or disconnection.',
        'Never use hands to locate a suspected hydraulic leak.',
      ]),
      PowerToolsGoldPoint(title: 'Injection hazard', points: [
        'High-pressure fluid can penetrate skin and cause a medical emergency even when the external wound is small. Treat suspected injection injury as urgent.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '15',
    title: 'Guards, Handles & Safety Devices',
    points: [
      PowerToolsGoldPoint(title: 'Requirements', points: [
        'Guards must be present, correctly fitted and suitable for the tool/accessory.',
        'Handles and auxiliary grips must be secure and used where required for control.',
        'Safety devices must function as designed and must not be bypassed.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '16',
    title: 'Accessories, Discs, Blades & Bits',
    points: [
      PowerToolsGoldPoint(title: 'Compatibility', points: [
        'Match accessory type, size, mounting system, material suitability and maximum speed/rating to the tool.',
        'Inspect accessories for cracks, chips, distortion, excessive wear, damaged teeth or other defects.',
      ]),
      PowerToolsGoldPoint(title: 'Storage', points: [
        'Store accessories dry, protected and in accordance with manufacturer requirements. Do not use unknown or damaged accessories.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '17',
    title: 'Inspection Before Use',
    points: [
      PowerToolsGoldPoint(title: 'Pre-use inspection', points: [
        'Check identification, casing, guard, switch/trigger, cable/plug, battery, accessory, handle, fittings and general condition.',
        'Function-test the tool safely before beginning the task where appropriate.',
      ]),
      PowerToolsGoldPoint(title: 'Defect action', points: [
        'Stop, isolate, label/remove from service and report defective equipment. Do not return it to use until authorised repair and inspection are completed.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '18',
    title: 'Maintenance & Isolation',
    points: [
      PowerToolsGoldPoint(title: 'Safe maintenance', points: [
        'Disconnect electrical supply, remove battery or isolate pneumatic/hydraulic energy before servicing.',
        'Control stored energy and prevent accidental re-energisation.',
      ]),
      PowerToolsGoldPoint(title: 'LOTO interface', points: [
        'Where the task requires formal isolation, apply the site LOTO/isolation procedure and relevant ADOSH requirements.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '19',
    title: 'Dust, Fumes & Local Exhaust',
    points: [
      PowerToolsGoldPoint(title: 'Exposure control', points: [
        'Identify dust and fume hazards generated by cutting, grinding, drilling or surface preparation.',
        'Prefer wet methods, local extraction or other engineering controls where suitable.',
        'Select respiratory protection from the task-specific assessment when engineering controls do not adequately control exposure.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '20',
    title: 'Noise & Vibration',
    points: [
      PowerToolsGoldPoint(title: 'Noise', points: [
        'Assess noisy tasks and implement engineering and administrative controls. Provide hearing protection where required by the assessment and applicable requirements.',
      ]),
      PowerToolsGoldPoint(title: 'Vibration', points: [
        'Select lower-vibration tools where practicable, maintain equipment and manage exposure time. Consider occupational health controls for significant hand-arm vibration exposure.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '21',
    title: 'Fire, Sparks & Hot Work Interface',
    points: [
      PowerToolsGoldPoint(title: 'Controls', points: [
        'Identify combustible materials, gases, vapours and dust before generating sparks or heat.',
        'Use suitable screens, housekeeping and fire precautions.',
        'Where the activity meets the site's definition of hot work, comply with the applicable hot-work permit and controls.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '22',
    title: 'Work Area & Housekeeping',
    points: [
      PowerToolsGoldPoint(title: 'Work area', points: [
        'Provide adequate lighting, stable footing, access and workspace.',
        'Route cables and hoses to prevent trips, crushing, sharp-edge damage and contact with moving equipment.',
        'Keep bystanders outside the hazard zone.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '23',
    title: 'Electrical & Environmental Conditions',
    points: [
      PowerToolsGoldPoint(title: 'Wet conditions', points: [
        'Assess water, conductive surfaces and weather before using electrical tools. Use equipment and protection suitable for the environment.',
        'Do not use damaged electrical equipment in wet conditions.',
      ]),
      PowerToolsGoldPoint(title: 'Overhead/underground services', points: [
        'Confirm service information before drilling, cutting or breaking into structures or ground. Apply the relevant permit, detection and isolation controls.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '24',
    title: 'People, Traffic & Dropped-Object Interface',
    points: [
      PowerToolsGoldPoint(title: 'Exclusion zones', points: [
        'Establish a suitable exclusion zone where fragments, sparks, noise or falling objects can affect others.',
        'Coordinate tool work with lifting, vehicle movement, simultaneous operations and pedestrian routes.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '25',
    title: 'RAMS / JSA / Risk Assessment',
    points: [
      PowerToolsGoldPoint(title: 'Minimum assessment content', points: [
        'Task, tool, material, energy sources, hazards, affected persons, controls, PPE, competency, inspection, emergency arrangements and environmental conditions.',
        'Review the assessment when the tool, material, location, process or conditions change.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '26',
    title: 'PTW / Authorization',
    points: [
      PowerToolsGoldPoint(title: 'Permit interface', points: [
        'Use the site PTW system where the task or location requires a permit, including applicable hot work, electrical isolation, confined-space or other permits.',
        'Permit requirements do not replace the manufacturer's instructions, RAMS or risk assessment.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '27',
    title: 'Safe Work Procedure',
    points: [
      PowerToolsGoldPoint(title: 'Before use', points: [
        'Review RAMS, confirm competent operator, inspect tool/accessory, establish exclusion zone and verify energy controls.',
      ]),
      PowerToolsGoldPoint(title: 'During use', points: [
        'Maintain stable footing and two-handed control where required, keep guards in place, avoid distraction and stop if conditions become unsafe.',
      ]),
      PowerToolsGoldPoint(title: 'After use', points: [
        'Switch off, isolate energy, wait for moving parts to stop, clean/store safely and report defects.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '28',
    title: 'Inspection, Examination & Records',
    points: [
      PowerToolsGoldPoint(title: 'Records', points: [
        'Maintain the site's required inspection, maintenance, testing, defect, repair and training records.',
        'Inspection frequency must reflect manufacturer requirements, risk, site rules and applicable regulatory requirements.',
      ]),
      PowerToolsGoldPoint(title: 'Traceability', points: [
        'Where the site uses equipment registers or identification tags, ensure the tool can be linked to its inspection and maintenance status.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '29',
    title: 'Competency & Responsibilities',
    points: [
      PowerToolsGoldPoint(title: 'Operator', points: [
        'Use only tools for which trained/competent and follow manufacturer instructions, RAMS and site rules.',
      ]),
      PowerToolsGoldPoint(title: 'Supervisor', points: [
        'Confirm task controls, competent personnel, suitable equipment, inspection status and safe work conditions.',
      ]),
      PowerToolsGoldPoint(title: 'HSE', points: [
        'Verify risk controls, inspections, training, field compliance and corrective actions; intervene when unsafe conditions are observed.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '30',
    title: 'PPE',
    points: [
      PowerToolsGoldPoint(title: 'Task-based PPE', points: [
        'Safety helmet, eye/face protection, suitable gloves, safety footwear and hearing protection as required by the risk assessment.',
        'Use respiratory protection when required by the exposure assessment.',
      ]),
      PowerToolsGoldPoint(title: 'Important limitation', points: [
        'PPE does not make defective equipment safe and must not substitute for guarding, isolation, extraction or other higher-level controls.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '31',
    title: 'Emergency & Rescue',
    points: [
      PowerToolsGoldPoint(title: 'Immediate response', points: [
        'Stop the tool and isolate energy if safe to do so. Raise the alarm and obtain site emergency assistance.',
        'For electrical incidents, do not touch an injured person until the electrical source is safely isolated.',
        'For hydraulic injection injury, seek urgent medical treatment and provide information about the fluid involved.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '32',
    title: 'Stop-Work Conditions',
    points: [
      PowerToolsGoldPoint(title: 'Stop immediately for', points: [
        'Missing/damaged guard, defective switch, exposed conductor, damaged plug/cable, abnormal vibration or noise, damaged accessory, uncontrolled kickback, overheating, fluid leak, unsafe hose connection, failed RCD/protection, loss of stable control or unexpected energisation.',
        'Stop when the work area changes or new hazards arise and the RAMS/controls are no longer adequate.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '33',
    title: 'Unsafe Practices → Corrective Actions',
    points: [
      PowerToolsGoldPoint(title: 'Unsafe examples', points: [
        'Removing guards, using damaged discs, bypassing RCDs, using wrong accessories, pulling a tool by its cable, carrying a running tool, working without required eye protection, connecting damaged hoses or servicing while energised.',
      ]),
      PowerToolsGoldPoint(title: 'Corrective action', points: [
        'Stop work, make the area safe, isolate/remove defective equipment, brief affected workers, correct the root cause and verify before restart.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '34',
    title: 'Toolbox Talk',
    points: [
      PowerToolsGoldPoint(title: 'Five-minute briefing', points: [
        'Correct tool and accessory.',
        'Pre-use inspection and guard check.',
        'Energy isolation and RCD/electrical protection.',
        'Flying particles, kickback, dust, noise and vibration.',
        'Exclusion zone and PPE.',
        'Stop-work conditions and emergency response.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '35',
    title: 'Field Checklist',
    points: [
      PowerToolsGoldPoint(title: 'Quick inspection', points: [
        '☐ Correct tool for task',
        '☐ Correct accessory and rating',
        '☐ Guard fitted and secure',
        '☐ Switch/trigger works correctly',
        '☐ Cable/plug/battery/hose in good condition',
        '☐ RCD/protection available where required',
        '☐ No abnormal noise/vibration/overheating',
        '☐ Workpiece secured',
        '☐ Exclusion zone established',
        '☐ Dust/noise/fire controls in place',
        '☐ PPE suitable',
        '☐ Operator competent',
        '☐ RAMS/JSA reviewed',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '36',
    title: 'Quick Reference',
    points: [
      PowerToolsGoldPoint(title: 'Remember', points: [
        'SELECT → INSPECT → ISOLATE → GUARD → CONTROL → OPERATE → MONITOR → STOP → REPORT.',
        'Never bypass a safety device.',
        'Never use a damaged tool or accessory.',
        'Never service an energised tool.',
        'Always follow manufacturer instructions and the approved site safe system of work.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '37',
    title: 'UAE / Abu Dhabi / Dubai Applicability',
    points: [
      PowerToolsGoldPoint(title: 'Abu Dhabi', points: [
        'This module is specifically aligned to Abu Dhabi ADOSH-SF CoP 35.0 Portable Power Tools, Version 4.1, effective 16 February 2026.',
        'CoP requirements are mandatory minimum OSH technical requirements within their scope. Project/entity procedures may impose additional controls.',
      ]),
      PowerToolsGoldPoint(title: 'Jurisdiction note', points: [
        'Dubai requirements and other emirate/sector requirements must be checked separately. Do not treat Abu Dhabi CoP requirements as automatically being Dubai legal requirements.',
      ]),
    ],
  ),
  PowerToolsGoldSection(
    number: '38',
    title: 'Official Regulatory References',
    points: [
      PowerToolsGoldPoint(title: 'Primary reference', points: [
        'Abu Dhabi Occupational Safety and Health Center (ADPHC), ADOSH-SF CoP 35.0 — Portable Power Tools, Version 4.1, 16 February 2026.',
        'Official ADPHC Code of Practices registry should be checked for the current version and effective date before relying on a regulatory requirement.',
      ]),
      PowerToolsGoldPoint(title: 'Related references', points: [
        'CoP 2.0 Personal Protective Equipment.',
        'CoP 3.0 Occupational Noise and CoP 3.1 Vibration.',
        'CoP 15.0 Electrical Safety.',
        'CoP 21.0 Permit to Work Systems.',
        'CoP 24.0 Lock-out/Tag-out (Isolation).',
        'CoP 28.0 Hot Work Operations where the tool activity creates hot-work hazards.',
        'CoP 47.0 Machine Guarding where machinery guarding requirements apply.',
      ]),
    ],
  ),
];
