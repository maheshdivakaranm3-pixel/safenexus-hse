class AbuDhabiCoreGoldPoint {
  final String title;
  final List<String> points;

  const AbuDhabiCoreGoldPoint({required this.title, required this.points});
}

class AbuDhabiCoreGoldSection {
  final String number;
  final String title;
  final String category;
  final List<AbuDhabiCoreGoldPoint> points;

  const AbuDhabiCoreGoldSection({
    required this.number,
    required this.title,
    required this.category,
    required this.points,
  });
}

const List<AbuDhabiCoreGoldSection> abuDhabiCoreGoldStandardSections = [
  AbuDhabiCoreGoldSection(
    number: '14',
    title: 'Electricity on Site & Electrical Tools',
    category: 'Electrical Safety',
    points: [
      AbuDhabiCoreGoldPoint(
        title: 'Key Controls',
        points: [
          'Identify electrical sources, temporary installations, distribution boards, cables, portable tools, generators, overhead and underground services before work starts.',
          'Only competent and authorised persons shall install, modify, inspect, test, maintain or repair electrical systems as applicable.',
          'Use suitable isolation and lockout/tagout before work on electrical equipment. Verify isolation before touching conductors or equipment.',
          'Provide suitable earthing, bonding and protective devices such as RCD/RCBO where required by the design, equipment and applicable requirements.',
          'Inspect plugs, sockets, cables, extension leads, portable tools, guards and protective devices before use. Remove damaged equipment from service.',
          'Keep electrical equipment and connections protected from water, conductive contamination, mechanical damage, heat and unauthorised access.',
          'Route cables to prevent trip hazards, crushing, abrasion, vehicle damage and contact with sharp edges.',
          'Control portable electrical tools under the applicable Portable Power Tools requirements and manufacturer instructions.',
          'Identify overhead and underground services before excavation, lifting, MEWP operation or other work that could contact services.',
          'Provide electrical emergency arrangements including emergency isolation, electric-shock response, fire response and medical assistance.',
          'Relevant Abu Dhabi reference: ADOSH-SF CoP 15.0 Electrical Safety, Version 4.0 effective 15 July 2024; related CoP 24.0 Lock-out Tag-out (Isolation), Version 4.1 effective 27 February 2026, CoP 35.0 Portable Power Tools, Version 4.1 effective 27 February 2026, and CoP 39.0 Overhead and Underground Services, Version 4.1 effective 27 February 2026. Verify the official registry before relying on numerical requirements.',
        ],
      ),
    ],
  ),
  AbuDhabiCoreGoldSection(
    number: '15',
    title: 'Temporary Works',
    category: 'Temporary Works / Structures',
    points: [
      AbuDhabiCoreGoldPoint(
        title: 'Key Controls',
        points: [
          'Temporary works include temporary structures, supports, platforms, access arrangements, site facilities and other temporary installations whose failure can affect people or property.',
          'Plan temporary works according to intended use, loads, environmental conditions, construction sequence, stability and foreseeable interfaces.',
          'Competent persons shall design, check, inspect and authorise temporary works according to the project\'s temporary-works procedure and applicable requirements.',
          'Consider foundations, ground bearing, stability, bracing, anchorage, connections, weather, wind, impact, fire, access and emergency egress.',
          'Do not modify, remove, overload or relocate temporary works without competent assessment and authorisation.',
          'Inspect temporary works after installation and following events that could affect stability, including significant weather, impact, alteration or abnormal loading.',
          'Maintain safe access and egress and prevent vehicle-pedestrian conflicts around temporary structures.',
          'Portable buildings shall have suitable access, egress, fire and electrical arrangements and shall be installed on suitable bases.',
          'Temporary structures shall be protected against foreseeable fire, electrical, wind and environmental hazards.',
          'Keep records of design information, approvals, inspections, modifications, defects and corrective actions.',
          'Relevant Abu Dhabi reference: ADOSH-SF CoP 43.0 Temporary Structures, Version 4.1 effective 16 February 2026; related CoP 40.0 False Work (Formwork), Version 4.1 effective 27 February 2026, and applicable lifting, traffic and fire requirements.',
        ],
      ),
    ],
  ),
  AbuDhabiCoreGoldSection(
    number: '16',
    title: 'Manual Handling',
    category: 'Manual Handling & Ergonomics',
    points: [
      AbuDhabiCoreGoldPoint(
        title: 'Key Controls',
        points: [
          'Assess manual-handling tasks before work, considering load characteristics, posture, force, frequency, distance, environment and worker capability.',
          'Apply the hierarchy of controls: eliminate unnecessary manual handling, reduce load or distance, use mechanical aids, redesign the task and then apply administrative and PPE controls.',
          'Plan the route before carrying a load. Remove obstructions, improve lighting and ensure the destination is ready.',
          'Use suitable trolleys, pallet trucks, hoists, lifting aids or other mechanical assistance whenever practical and appropriate.',
          'Keep the load stable and maintain a secure grip. Avoid sudden movements and twisting while carrying.',
          'Use suitable team lifting arrangements for loads or objects that cannot safely be handled by one person. One person should coordinate the movement.',
          'Store materials at practical heights and avoid repeated lifting from floor level or above shoulder level where the task can be redesigned.',
          'Rotate or redesign repetitive tasks where ergonomic risk assessment identifies excessive repetition, force or awkward posture.',
          'Provide information, instruction and training on safe handling techniques and the correct use of mechanical aids.',
          'Report pain, discomfort, damaged handling equipment, unstable loads and unsafe storage conditions early.',
          'Relevant Abu Dhabi reference: ADOSH-SF CoP 14.0 Manual Handling and Ergonomics, Version 4.0 effective 15 July 2024, and CoP 14.1 Manual Tasks Involving the Handling of People, Version 4.0 effective 15 July 2024.',
        ],
      ),
    ],
  ),
  AbuDhabiCoreGoldSection(
    number: '17',
    title: 'Hot Work',
    category: 'Hot Work Operations',
    points: [
      AbuDhabiCoreGoldPoint(
        title: 'Key Controls',
        points: [
          'Hot work includes activities such as welding, cutting and other work that generates flame, heat, sparks or hot particles.',
          'Plan hot work through risk assessment, RAMS/JSA and the applicable Permit to Work system where required.',
          'Inspect the work area and remove or protect combustible materials, flammable liquids, gases, dust and other fire hazards before starting.',
          'Provide suitable fire prevention and firefighting arrangements appropriate to the activity and location.',
          'Use competent and authorised personnel and verify welding/cutting equipment, leads, hoses, regulators, torches and protective equipment before use.',
          'Electric arc welding requires suitable electrical controls, cable management, earthing and protection from electric shock.',
          'Gas welding and cutting requires correct cylinders, regulators, hoses, flashback protection where applicable, leak checks and secure cylinder handling.',
          'Secure gas cylinders upright where required, protect them from damage and heat, and separate incompatible gases according to applicable requirements.',
          'Provide suitable ventilation and respiratory protection controls where fumes, gases or coatings may create exposure.',
          'Control hot-work sparks and slag, including protection of lower levels, openings, adjacent areas and hidden combustible materials.',
          'Maintain a suitable fire watch where required by the risk assessment, permit or applicable procedure, including controls for post-work ignition hazards.',
          'Stop hot work when conditions become unsafe, combustible materials cannot be controlled, gas equipment is defective, ventilation is inadequate or the permit conditions are no longer valid.',
          'Relevant Abu Dhabi reference: ADOSH-SF CoP 28.0 Hot Work Operations, Version 4.1 effective 27 February 2026. The CoP covers planning, competency, hazardous areas, electric arc welding, gas welding, gas cylinders and inspection.',
        ],
      ),
    ],
  ),
];
