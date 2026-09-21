import 'package:flutter/material.dart';

import 'data/abu_dhabi_5AJ_part1_interfaces_specialist_plant_gold.dart';
import 'data/abu_dhabi_5AJ_part2_gap_duplicate_cop36_gold.dart';
import 'data/abu_dhabi_5AB_to_5AE_plant_haulage_compaction_gold.dart';
import 'data/abu_dhabi_5AF_to_5AI_paver_trencher_compressor_generator_gold.dart';
import 'data/abu_dhabi_5S_to_5V_mobile_material_handling_gold.dart';
import 'data/abu_dhabi_5W_to_5Z_earthmoving_gold.dart';
import 'data/abu_dhabi_confined_spaces_gold.dart';
import 'data/abu_dhabi_excavation_gold.dart';
import 'data/abu_dhabi_formwork_gold.dart';
import 'data/abu_dhabi_forklift_powered_lift_trucks_gold.dart';
import 'data/abu_dhabi_mewp_gold.dart';
import 'data/abu_dhabi_permit_to_work_gold.dart';
import 'data/abu_dhabi_power_tools_gold.dart';
import 'data/abu_dhabi_safety_in_heat_gold.dart';
import 'data/abu_dhabi_scaffolding_gold.dart';
import 'data/abu_dhabi_working_at_height_gold.dart';
import 'data/abu_dhabi_crane_lifting_book_gold.dart';
import 'data/abu_dhabi_steps_5N_to_5Q_book_gold.dart';
import 'models/reference_topic.dart';

/// Step 5AK-A: central Gold Standard router.
///
/// The old Abu Dhabi registry remains the index. This router decides whether
/// a selected topic has a dedicated Gold Standard data source. If it does,
/// the app opens that source instead of the older generic CoP content.
Widget? buildAbuDhabiGoldTopicPage(ReferenceTopic topic) {
  switch (topic.id) {
    case 'ad_cop_29_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: _withLockedGuide('29', excavationGoldStandardSections),
        regulatory: 'ADPHC CoP 29.0 — Excavation Work — V4.1; February 2026.',
      );
    case 'ad_cop_23_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: _withLockedGuide('23', workingAtHeightGoldStandardSections),
        regulatory: 'ADPHC CoP 23.0 — Working at Heights — V4.1; effective 27 February 2026.',
      );
    case 'ad_cop_26_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: _withLockedGuide('26', scaffoldingGoldStandardSections),
        regulatory: 'ADPHC CoP 26.0 — Scaffolding — V4.1; effective 27 February 2026.',
      );
    case 'ad_cop_27_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: _withLockedGuide('27', confinedSpaceGoldStandardSections),
        regulatory: 'ADPHC CoP 27.0 — Confined Spaces — V4.0; effective 15 July 2024.',
      );
    case 'ad_cop_21_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: _withLockedGuide('21', permitToWorkGoldStandardSections),
        regulatory: 'ADPHC CoP 21.0 — Permit to Work Systems — V4.0; effective 15 July 2024.',
      );
    case 'ad_cop_11_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: _withLockedGuide('11', safetyInHeatGoldStandardSections),
        regulatory: 'ADPHC CoP 11.0 — Safety in the Heat — V4.0; effective 15 July 2024.',
      );
    case 'ad_cop_35_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: _withLockedGuide('35', portablePowerToolsGoldStandardSections),
        regulatory: 'ADPHC CoP 35.0 — Portable Power Tools — V4.1; effective 27 February 2026.',
      );
    case 'ad_cop_40_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: _withLockedGuide('40', formworkGoldStandardSections),
        regulatory: 'ADPHC CoP 40.0 — False Work (Formwork) — V4.1; effective 27 February 2026.',
      );
    case 'ad_cop_51_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: _withLockedGuide('51', forkliftPoweredLiftTruckGoldSections),
        regulatory: 'ADPHC CoP 51.0 — Powered Lift Trucks — V4.1; effective 27 February 2026.',
      );
    case 'ad_cop_14_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: _withLockedGuide(
          '14',
          abuDhabiFiveNQGoldStandardSections
              .where((section) => section.category == '5P — Manual Handling')
              .toList(),
        ),
        regulatory: 'ADPHC CoP 14.0 — Manual Handling and Ergonomics.',
      );
    case 'ad_cop_15_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: _withLockedGuide(
          '15',
          abuDhabiFiveNQGoldStandardSections
              .where((section) =>
                  section.category == '5N — Electricity on Site & Electrical Tools')
              .toList(),
        ),
        regulatory: 'ADPHC CoP 15.0 — Electrical Safety.',
      );
    case 'ad_cop_28_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: _withLockedGuide(
          '28',
          abuDhabiFiveNQGoldStandardSections
              .where((section) => section.category == '5Q — Hot Work')
              .toList(),
        ),
        regulatory: 'ADPHC CoP 28.0 — Hot Work.',
      );
    case 'ad_cop_34_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: _withLockedGuide('34', craneLiftingGoldStandardSections),
        regulatory:
            'ADPHC CoP 34.0 — Safe Use of Lifting Equipment and Lifting Accessories.',
      );
    case 'ad_cop_43_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: _withLockedGuide(
          '43',
          abuDhabiFiveNQGoldStandardSections
              .where((section) => section.category == '5O — Temporary Works')
              .toList(),
        ),
        regulatory: 'ADPHC CoP 43.0 — Temporary Structures.',
      );
    case 'ad_cop_36_0':
      return AbuDhabiPlantEquipmentGoldIndexPage(topic: topic);
    default:
      return null;
  }
}


/// Locked SafeNexus HSE field-execution layer.
///
/// This layer is deliberately additive: the existing CoP data files remain
/// intact, while every selected CoP receives the same professional field
/// workflow: definition, types, hazards, people, permits, pre-start,
/// controls during work, monitoring, records, emergency, stop-work,
/// observation, rectification, verification and close-out.
///
/// Numerical/legal limits are not invented here. Where a value is required,
/// the current controlled CoP, engineered design, manufacturer instruction or
/// project procedure must be checked before entry.
class GoldFieldGuidePoint {
  final String title;
  final String detail;
  const GoldFieldGuidePoint({required this.title, required this.detail});
}

class GoldFieldGuideSection {
  final String title;
  final List<GoldFieldGuidePoint> points;
  const GoldFieldGuideSection({required this.title, required this.points});
}

List<dynamic> _withLockedGuide(String cop, List<dynamic> existing) {
  return <dynamic>[
    ..._lockedGuide(cop),
    ...existing,
  ];
}

List<GoldFieldGuideSection> _lockedGuide(String cop) {
  switch (cop) {
    case '51':
      return _forkliftGuide();
    case '43':
      return _temporaryWorksGuide();
    case '40':
      return _formworkGuide();
    case '36':
      return _plantGuide();
    case '35':
      return _powerToolsGuide();
    case '34':
      return _liftingGuide();
    case '29':
      return _excavationGuide();
    case '28':
      return _hotWorkGuide();
    case '27':
      return _confinedSpaceGuide();
    case '26':
      return _scaffoldingGuide();
    case '23':
      return _workAtHeightGuide();
    case '21':
      return _ptwGuide();
    case '15':
      return _electricalGuide();
    case '11':
      return _heatGuide();
    default:
      return <GoldFieldGuideSection>[];
  }
}

GoldFieldGuideSection _g(String title, List<String> details) =>
    GoldFieldGuideSection(
      title: title,
      points: [
        for (var i = 0; i < details.length; i++)
          GoldFieldGuidePoint(title: 'Field point ${i + 1}', detail: details[i]),
      ],
    );

List<GoldFieldGuideSection> _scaffoldingGuide() => [
  _g('Scaffolding — What it is and where it is used', [
    'A temporary access and/or working platform system assembled from compatible components to provide people, materials and tools with controlled access to elevated work.',
    'Select the scaffold configuration for the actual geometry, height, access route, intended load, environment and work activity. Do not treat a scaffold as a generic platform.',
  ]),
  _g('Types of scaffolding', [
    'Tube & Coupler: tubes connected with approved couplers; useful for irregular geometry and special configurations. It requires competent design/erection and correct bracing, ties and coupler installation.',
    'System / Modular: prefabricated standards, ledgers, transoms and compatible components. Follow the manufacturer system configuration and component compatibility.',
    'Mobile / Tower: a free-standing scaffold on wheels/castors. Control stability, wheel locking, platform access, movement and overhead hazards; never move an occupied scaffold unless the approved system specifically permits it.',
    'Suspended: a platform suspended from an overhead supporting system. Control suspension points, ropes, hoists, secondary protection, load, wind, rescue and emergency lowering.',
    'Cantilever: a scaffold supported from a structure rather than a conventional ground base. Treat the supporting structure and engineered design as critical controls.',
    'Birdcage: a multi-standard internal scaffold generally used for work over an area. Control stability, bracing, platform loading, access and falling objects.',
    'Special / designed scaffold: unusual, high, heavily loaded, cantilevered, suspended or otherwise non-standard configurations require documented engineering/design and controlled erection.',
  ]),
  _g('Scaffold technical parameters', [
    'Check scaffold height, bay/lift geometry, platform width, access openings, guardrail/toe-board arrangement, tie pattern, bracing, base support, clearance and intended loading against the applicable controlled CoP, design and manufacturer system. Do not copy a generic dimension into a project without verification.',
    'Where the scaffold is outside a standard manufacturer configuration, obtain the required design/engineering information before erection or use.',
  ]),
  _g('Pre-start requirements', [
    'Confirm work scope, location, scaffold type, intended users, load, height, interfaces, overhead services, traffic, weather exposure and nearby hazards.',
    'Verify suitable foundation/base, compatible components, competent erection team, safe erection sequence, required edge protection, access and inspection arrangements.',
  ]),
  _g('Inspection and use', [
    'Inspect before first use and after alteration, damage, impact, adverse event or any condition that could affect stability; follow the applicable inspection frequency and tagging system.',
    'Users must not remove, relocate or modify standards, ties, braces, guardrails, platforms or other safety-critical components without authorization.',
  ]),
  _g('Hazards, observation and rectification', [
    'Hazards include collapse, falls, falling objects, overloading, unstable base, missing ties/bracing, damaged components, unsafe access, electrical contact, weather and unauthorized modification.',
    'Safety Observation: record the actual unsafe condition, location, component and immediate risk. Immediate Action: prevent exposure where necessary. Rectification: restore the designed/approved condition. Verification: competent person re-inspects before release. Close-out: retain evidence.',
  ]),
  _g('Stop-work conditions', [
    'Stop use for suspected instability, missing critical structural components, significant damage, unsafe access, missing required edge protection, uncontrolled alteration, overload, unsafe electrical interface or any condition where the scaffold no longer matches its approved/design condition.',
  ]),
];

List<GoldFieldGuideSection> _excavationGuide() => [
  _g('Excavation — What it is and scope', [
    'Ground-breaking and removal of earth/rock including trenches and other excavation activities. Treat underground-service exposure and effects on adjacent structures as part of the excavation risk.',
  ]),
  _g('Excavation types and ground-control methods', [
    'Open cut excavation, trench excavation, shaft/deep excavation, stepped/benched excavation, sloped excavation, shored excavation and engineered systems such as trench boxes where applicable.',
    'Select sloping, benching, shoring or a protective system from the ground assessment and applicable requirements. Never assume soil is stable because a previous excavation remained open.',
  ]),
  _g('Pre-start requirements', [
    'Confirm drawings and field survey, underground utilities/services, ground conditions, adjacent structures, water, traffic, plant interfaces, access/egress, spoil placement, weather and emergency arrangements.',
    'Complete the required risk assessment/JSA, method statement and permits/authorizations. Establish competent inspection and supervision arrangements.',
  ]),
  _g('Access, edge and plant controls', [
    'Provide safe access/egress suitable for the excavation. Protect edges and prevent people, materials and mobile plant from creating a collapse or fall hazard.',
    'Control spoil, materials and plant near excavation edges using the applicable engineered/CoP requirements; do not rely on an arbitrary generic setback.',
  ]),
  _g('Ground stability and protection', [
    'Control cave-in/collapse using an approved protective system such as suitable sloping, benching, shoring or trench protection. Consider surcharge loads, vibration, water, adjacent foundations and changing ground conditions.',
  ]),
  _g('Inspection, monitoring and emergency', [
    'Inspect before entry/use and whenever conditions change or after events that may affect stability; record required inspections. Monitor water, cracking, movement, services and atmospheric hazards where relevant.',
    'Emergency planning must address collapse, trapped person, flooding, service strike, hazardous atmosphere and plant/traffic interface. Do not improvise an unplanned rescue inside an unstable excavation.',
  ]),
  _g('Observation → rectification → verification', [
    'Observation: unsupported face, damaged shoring, water ingress, spoil surcharge, unsafe access or exposed service. Immediate Action: stop exposure and secure the area. Rectification: install/restore the approved control. Verification: competent person confirms safe condition. Close-out: document the action and evidence.',
  ]),
];

List<GoldFieldGuideSection> _liftingGuide() => [
  _g('Crane and lifting — complete lifting system', [
    'A safe lift combines crane/equipment selection, load characteristics, rigging, ground, radius, configuration, environment and competent people. The objective is controlled movement without dropped load, overturning, collision or loss of control.',
  ]),
  _g('Crane and lifting equipment types', [
    'Mobile, crawler, tower, truck-mounted, rough-terrain and other cranes/equipment within the project scope. Also include hoists and other lifting equipment where covered by the task.',
  ]),
  _g('Lifting accessories', [
    'Control wire-rope slings, web slings, chain slings, shackles, hooks, lifting beams/spreader beams, clamps and other approved accessories according to their identification, condition, capacity and intended use.',
  ]),
  _g('Lift planning and load control', [
    'Confirm load weight, centre of gravity, dimensions, lifting points, required radius, boom/configuration, applicable load chart, ground condition, outrigger arrangement and travel/placement path before lifting.',
    'Use the required lift plan/permit/authorization and define roles, communication method, exclusion zone and emergency arrangements. Critical/tandem/blind or unusual lifts require the additional planning and controls specified by the applicable procedure.',
  ]),
  _g('Rigging and exclusion zone', [
    'Verify accessory identification and capacity, correct hitch/angle configuration, hook and latch condition, protection from sharp edges, connection security and controlled landing area.',
    'Establish and maintain an exclusion zone appropriate to the lift. Never allow people under a suspended load.',
  ]),
  _g('People and communication', [
    'Use competent/authorized crane operators, riggers and signalers/banksmen as required by the task and project. Maintain one clear communication method and stop the lift when communication is lost or unclear.',
  ]),
  _g('Observation → rectification → close-out', [
    'Observation: overload, wrong accessory, damaged sling, unstable ground, uncontrolled access, poor communication or load-path conflict. Stop/secure the lift, rectify the control, verify equipment/plan and then release the lift.',
  ]),
];

List<GoldFieldGuideSection> _confinedSpaceGuide() => [
  _g('Confined space — before entry', [
    'Identify the space and hazards, complete the required risk assessment and entry controls, confirm the applicable permit-to-work/entry permit process, isolation and rescue arrangements before entry.',
    'Determine atmospheric hazards relevant to the space and task. Test with suitable calibrated equipment and follow the approved testing frequency/continuous-monitoring requirement for the risk.',
  ]),
  _g('Who must be present', [
    'Define authorized entrants, attendant/standby role, competent person, supervisor, gas tester, permit issuer/authorized person and rescue personnel as required by the applicable procedure and risk.',
    'Do not assume every confined-space job uses exactly the same staffing model; the roles must be established before entry and maintained while personnel are exposed.',
  ]),
  _g('Entry and exit accountability', [
    'Maintain positive personnel accountability using the project-approved entry/exit log, permit register or equivalent system. Know who is inside, who has exited and whether the permit remains valid.',
    'Control unauthorized entry and ensure the entry/exit route remains usable throughout the work.',
  ]),
  _g('Atmosphere, ventilation and work controls', [
    'Control oxygen deficiency/enrichment, flammable atmospheres and toxic contaminants relevant to the space. Provide ventilation and re-test/monitor as required when conditions can change.',
    'Control ignition sources, chemicals, welding/hot work, energy sources, engulfment, heat, mechanical movement and other task-specific hazards.',
  ]),
  _g('Rescue and emergency', [
    'Have a documented rescue plan, competent rescue capability and suitable rescue equipment available before entry. Do not rely on an emergency response plan that requires an unprotected person to enter and rescue the casualty.',
  ]),
  _g('Stop-work and close-out', [
    'Stop entry for failed atmospheric criteria, loss of ventilation, loss of communication, isolation failure, unsafe access/egress, unauthorized entrant, change in conditions, expired/invalid permit or loss of rescue readiness.',
    'Close the permit only after personnel accountability, equipment removal, area status and required records are verified.',
  ]),
];

List<GoldFieldGuideSection> _hotWorkGuide() => [
  _g('Hot work / welding — what it covers', [
    'Welding, cutting, brazing, grinding or other work capable of producing flame, heat, sparks or ignition. Select controls for the exact process, material, location and surrounding hazards.',
  ]),
  _g('Pre-work / hot work permit', [
    'Use the applicable hot-work permit within the project PTW system where required. Inspect the work area, remove/control combustibles, protect openings and adjacent levels, establish fire protection, define fire-watch arrangements and verify isolations/gas testing where required.',
  ]),
  _g('Welding and gas equipment', [
    'Inspect welding machine, leads, holder, earthing/return arrangement, cylinders, valves, regulators, hoses, connections and flashback protection where applicable. Secure cylinders and protect them from impact, heat and unauthorized handling.',
  ]),
  _g('Health hazards', [
    'Control electric shock, burns, UV/IR radiation, welding fumes, gases, fire/explosion, eye injury, noise and task-specific chemical exposure. Provide ventilation/fume extraction appropriate to the work.',
  ]),
  _g('Confined space / height / combustible areas', [
    'Apply additional controls for welding inside confined spaces, at height, near flammable materials, near live process lines or where sparks can travel to hidden/remote combustibles.',
  ]),
  _g('Fire watch and close-out', [
    'Provide the required fire-watch arrangement during and after hot work according to the permit/risk. Inspect adjacent and concealed areas before final close-out and record permit completion.',
  ]),
];

List<GoldFieldGuideSection> _electricalGuide() => [
  _g('Electrical safety — planning', [
    'Identify electrical sources, voltage, equipment, temporary supplies, tools, cables, distribution boards, interfaces and competent-person requirements before work.',
    'Apply isolation/LOTO where required, verify absence of hazardous energy using the approved method, and prevent unauthorized re-energization.',
  ]),
  _g('Equipment and tools', [
    'Inspect cables, plugs, sockets, enclosures, earthing/grounding, protection devices and portable tools before use. Remove damaged equipment from service.',
  ]),
  _g('Work near electrical hazards', [
    'Establish the applicable approach/clearance and isolation controls from the current controlled requirements. Do not substitute a guessed distance for the project/utility requirement.',
  ]),
  _g('Observation and rectification', [
    'Observation: exposed conductor, damaged cable, missing protection, wet electrical connection, unauthorized modification or failed isolation. Stop exposure, isolate where safe, rectify through a competent person and verify before re-energization.',
  ]),
];

List<GoldFieldGuideSection> _workAtHeightGuide() => [
  _g('Working at height — planning', [
    'Identify every fall exposure, fragile surface, opening, edge, access route, dropped-object risk and rescue requirement before work begins.',
    'Use the hierarchy of controls: eliminate work at height where reasonably practicable, then collective protection such as guardrails/platforms, then suitable personal fall protection where required.',
  ]),
  _g('Access systems', [
    'Select scaffold, MEWP, ladder, stair or other access equipment for the task. Ensure the equipment is inspected, suitable, stable and used within its intended configuration.',
  ]),
  _g('Fall protection and rescue', [
    'Where personal fall protection is required, select compatible equipment, suitable anchorage and a rescue arrangement that addresses suspension and access. Do not rely only on an emergency call.',
  ]),
  _g('Stop-work', [
    'Stop for missing edge protection, unsuitable access, unprotected openings, damaged equipment, unsafe weather, incompatible anchorage, uncontrolled dropped-object risk or inability to execute the planned rescue.',
  ]),
];

List<GoldFieldGuideSection> _ptwGuide() => [
  _g('Permit to Work — purpose', [
    'PTW is a formal control system for specified hazardous work. It confirms the work scope, hazards, isolations, precautions, responsible people, validity and authorization before work starts.',
  ]),
  _g('Permit lifecycle', [
    'Request → assess → identify hazards → define controls → isolate where required → inspect/test → authorize → communicate → execute → suspend/revalidate when required → hand back → close.',
  ]),
  _g('Permit does not replace risk assessment', [
    'A permit is not a substitute for risk assessment, method statement, competency or supervision. All controls must match the actual work and site conditions.',
  ]),
  _g('Stop-work and handback', [
    'Stop/suspend when conditions change, controls fail, permit validity expires, unauthorized work occurs or the work scope changes. Close only after the area is safe and required handback/records are complete.',
  ]),
];

List<GoldFieldGuideSection> _powerToolsGuide() => [
  _g('Portable power tools — selection', [
    'Select the tool for the material and task. Use the manufacturer-specified guard, accessory, power supply and operating method.',
  ]),
  _g('Pre-use inspection', [
    'Check body, guard, switch, cable, plug, accessory, blade/disc, battery, earthing/protection and signs of damage. Remove defective tools from service.',
  ]),
  _g('Use controls', [
    'Secure the workpiece, maintain stable posture, control kickback and flying particles, keep guards fitted, isolate before adjustment and control dust/noise/vibration as applicable.',
  ]),
  _g('Observation and close-out', [
    'Observation: missing guard, damaged lead, wrong accessory, unauthorized modification or unsafe use. Stop use, tag/quarantine, rectify through an authorized process and verify before return to service.',
  ]),
];

List<GoldFieldGuideSection> _formworkGuide() => [
  _g('Formwork / falsework — planning', [
    'Treat formwork and falsework as temporary structures that must safely resist the intended construction loads and construction sequence. Confirm design, drawings, erection sequence and competent supervision.',
  ]),
  _g('Loads and stability', [
    'Consider concrete pressure, self-weight, workers, materials, equipment, impact and construction sequence. Verify supports, props, ties, bracing, foundations and load path against the design.',
  ]),
  _g('Before concrete placement', [
    'Inspect dimensions, alignment, supports, props, ties, bracing, access, platforms, openings, embedded items, release agent controls and exclusion zones. Do not proceed when the installed condition differs materially from the approved design.',
  ]),
  _g('Stripping / dismantling', [
    'Follow the approved striking sequence and required strength/authorization criteria. Control falling components and prevent premature removal of critical supports.',
  ]),
];

List<GoldFieldGuideSection> _temporaryWorksGuide() => [
  _g('Temporary structures — planning', [
    'Identify the temporary structure, intended loads, duration, interfaces, stability risks, erection/dismantling sequence and required design/engineering controls before work.',
  ]),
  _g('Design and approval', [
    'Use competent design and approval arrangements appropriate to the complexity and risk. Control revisions, field changes and unauthorized modification.',
  ]),
  _g('Inspection and use', [
    'Inspect foundations, connections, bracing, load paths, access, weather exposure and condition before use and after relevant changes/events. Keep records required by the project system.',
  ]),
];

List<GoldFieldGuideSection> _forkliftGuide() => [
  _g('Powered lift trucks — planning', [
    'Select the truck for load, environment, travel surface, attachments, visibility and duty. Only trained/authorized operators may operate the equipment as required by the applicable system.',
  ]),
  _g('Pre-use inspection', [
    'Check forks, mast, chains, hydraulics, tyres/wheels, brakes, steering, horn, alarms, lights, seat/restraint system and attachments. Defects affecting safe operation require removal from service.',
  ]),
  _g('Load and travel controls', [
    'Know the rated capacity and attachment effects from the truck data plate/load chart. Keep the load stable, maintain visibility, control speed, segregate pedestrians and use designated routes.',
  ]),
  _g('Observation and stop-work', [
    'Stop for overload, unstable load, failed brake/steering, defective fork/mast, unsafe attachment, pedestrian conflict, poor visibility or operation by an unauthorized person.',
  ]),
];

List<GoldFieldGuideSection> _plantGuide() => [
  _g('Plant & equipment — complete control cycle', [
    'Identify each item, intended task, manufacturer limits, competent operator, inspection/certification requirements, energy sources, traffic interface and emergency controls before use.',
  ]),
  _g('Selection and pre-start', [
    'Confirm equipment suitability, condition, guards, alarms, emergency stops, brakes/steering, attachments, fluids/leaks, access/egress and required certificates/records.',
  ]),
  _g('Traffic and people', [
    'Separate pedestrians and plant where practicable, establish controlled routes, visibility controls, reversing arrangements and exclusion zones for moving/operating equipment.',
  ]),
  _g('Observation → rectification → verification', [
    'Record defects or unsafe interfaces, stop or isolate the equipment when necessary, rectify through competent personnel and verify safe condition before return to service.',
  ]),
];

List<GoldFieldGuideSection> _heatGuide() => [
  _g('Safety in heat — planning', [
    'Plan work for heat exposure using the applicable Abu Dhabi heat-stress requirements, weather/heat assessment, work-rest arrangements, hydration, shaded recovery and acclimatization controls.',
  ]),
  _g('Worker protection', [
    'Provide suitable drinking water, rest/recovery arrangements, training and supervision. Monitor workers for heat-stress symptoms and use the applicable work restrictions and emergency response.',
  ]),
  _g('Heat-stress observation and response', [
    'Observation: worker with symptoms, inadequate hydration/rest, excessive exposure or work outside the applicable heat-control arrangement. Stop exposure, move to a safe recovery area, initiate first aid/emergency response as appropriate and document the event.',
  ]),
];

class _GoldChapter {
  final String title;
  final String subtitle;
  final List<dynamic> sections;

  const _GoldChapter({required this.title, required this.subtitle, required this.sections});
}

class AbuDhabiGoldBookPage extends StatelessWidget {
  final ReferenceTopic topic;
  final List<dynamic> sections;
  final String regulatory;

  const AbuDhabiGoldBookPage({
    super.key,
    required this.topic,
    required this.sections,
    required this.regulatory,
  });

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(topic.shortTitle, overflow: TextOverflow.ellipsis),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(topic.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: darkGreen)),
                const SizedBox(height: 9),
                Text('Gold Standard Field Handbook', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: green)),
                const SizedBox(height: 10),
                Text(topic.description, style: const TextStyle(fontSize: 15, height: 1.5)),
                const SizedBox(height: 12),
                Text(regulatory, style: const TextStyle(fontSize: 14.2, height: 1.45, fontWeight: FontWeight.w800)),
              ]),
            ),
          ),
          const SizedBox(height: 14),
          ...sections.asMap().entries.map((e) => _sectionCard(context, e.key + 1, e.value)),
        ],
      ),
    );
  }

  Widget _sectionCard(BuildContext context, int number, dynamic section) {
    final title = _sectionTitle(section);
    final preview = _sectionPreview(section);
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        leading: CircleAvatar(
          backgroundColor: green.withValues(alpha: 0.12),
          child: Text('$number', style: const TextStyle(fontWeight: FontWeight.w900, color: darkGreen)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900, color: darkGreen)),
        subtitle: preview.isEmpty ? null : Text(preview, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: const Icon(Icons.chevron_right, color: darkGreen),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AbuDhabiGoldSectionPage(title: title, section: section))),
      ),
    );
  }
}

class AbuDhabiGoldSectionPage extends StatelessWidget {
  final String title;
  final dynamic section;

  const AbuDhabiGoldSectionPage({super.key, required this.title, required this.section});

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    final blocks = _sectionBlocks(section);
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(title: Text(title, overflow: TextOverflow.ellipsis), backgroundColor: darkGreen, foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: blocks.asMap().entries.map((entry) {
          final block = entry.value;
          return Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [const Icon(Icons.shield_outlined, color: green), const SizedBox(width: 10), Expanded(child: Text(block.$1, style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w900, color: darkGreen)))]),
                const SizedBox(height: 8),
                ...block.$2.map((p) => Padding(padding: const EdgeInsets.only(bottom: 7), child: Text('• $p', style: const TextStyle(fontSize: 15, height: 1.48)))),
              ]),
            ),
          );
        }).toList(),
      ),
    );
  }
}

String _sectionTitle(dynamic section) {
  try { return section.title as String; } catch (_) { return 'Section'; }
}

List<dynamic> _goldSectionPoints(dynamic section) {
  // Gold data modules are intentionally allowed to use either:
  //   1) section.points -> List<GoldPoint>
  //   2) section.point  -> GoldPoint
  // Keep both shapes supported so the detail page never silently renders blank.
  try {
    final points = section.points as List;
    if (points.isNotEmpty) return points.cast<dynamic>();
  } catch (_) {}

  try {
    final point = section.point;
    return <dynamic>[point];
  } catch (_) {}

  return <dynamic>[];
}

String _goldText(dynamic value) {
  if (value == null) return '';
  final text = value.toString().trim();
  if (text.isEmpty || text == 'null') return '';
  return text;
}

String _sectionPreview(dynamic section) {
  final points = _goldSectionPoints(section);
  if (points.isEmpty) return '';

  final first = points.first;
  try {
    final detail = _goldText(first.detail);
    if (detail.isNotEmpty) return detail;
  } catch (_) {}
  try {
    final content = _goldText(first.content);
    if (content.isNotEmpty) return content;
  } catch (_) {}
  try {
    final list = first.points as List;
    if (list.isNotEmpty) return _goldText(list.first);
  } catch (_) {}
  try {
    final meaning = _goldText(first.meaning);
    if (meaning.isNotEmpty) return meaning;
  } catch (_) {}
  return '';
}

List<(String, List<String>)> _sectionBlocks(dynamic section) {
  final result = <(String, List<String>)>[];
  final points = _goldSectionPoints(section);

  for (final point in points) {
    String title = 'Field control';
    try {
      final value = _goldText(point.title);
      if (value.isNotEmpty) title = value;
    } catch (_) {}

    final values = <String>[];

    void addText(dynamic value) {
      final text = _goldText(value);
      if (text.isNotEmpty && !values.contains(text)) values.add(text);
    }

    // Direct narrative fields used by several Gold modules.
    try { addText(point.detail); } catch (_) {}
    try { addText(point.content); } catch (_) {}

    // Some modules store several field-control bullets in point.points.
    try {
      final list = point.points as List;
      for (final item in list) addText(item);
    } catch (_) {}

    // Structured Gold fields used by the detailed field modules.
    try { addText('Meaning: ${_goldText(point.meaning)}'); } catch (_) {}
    try { addText('Hazards: ${_goldText(point.hazards)}'); } catch (_) {}
    try { addText('Controls: ${_goldText(point.controls)}'); } catch (_) {}
    try { addText('Field check: ${_goldText(point.fieldCheck)}'); } catch (_) {}
    try { addText('Common mistake: ${_goldText(point.commonMistake)}'); } catch (_) {}
    try { addText('Corrective action: ${_goldText(point.action)}'); } catch (_) {}
    try { addText('Records / evidence: ${_goldText(point.records)}'); } catch (_) {}

    // Never add an empty card. A point with valid content is always rendered.
    if (values.isNotEmpty) {
      result.add((title, values));
    }
  }

  return result;
}

class AbuDhabiPlantEquipmentGoldIndexPage extends StatelessWidget {
  final ReferenceTopic topic;
  const AbuDhabiPlantEquipmentGoldIndexPage({super.key, required this.topic});

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  List<_GoldChapter> get chapters => [
    _GoldChapter(title: 'CoP 36.0 — Locked Field Execution Standard', subtitle: 'Planning • pre-start • operation • inspection • emergency • rectification', sections: _lockedGuide('36')),
    _GoldChapter(title: '5S–5V — Mobile / Material Handling', subtitle: 'Gold equipment chapters', sections: abuDhabi5STo5VTopics.expand((t) => t.sections).toList()),
    _GoldChapter(title: '5W–5Z — Earthmoving', subtitle: 'Gold equipment chapters', sections: abuDhabi5WTo5ZTopics.expand((t) => t.sections).toList()),
    _GoldChapter(title: '5AB–5AE — Haulage / Compaction', subtitle: 'Gold equipment chapters', sections: abuDhabi5ABTo5AETopics.expand((t) => t.sections).toList()),
    _GoldChapter(title: '5AF–5AI — Paver / Trencher / Compressor / Generator', subtitle: 'Gold equipment chapters', sections: abuDhabi5AFTo5AITopics.expand((t) => t.sections).toList()),
    _GoldChapter(title: 'Crane & Lifting', subtitle: 'Dedicated Gold Standard book', sections: craneLiftingGoldStandardSections),
    _GoldChapter(title: 'MEWP', subtitle: 'Dedicated Gold Standard book', sections: mewpGoldStandardSections),
    _GoldChapter(title: '5AJ Part 1 — Interfaces / Specialist Plant', subtitle: 'Master audit and field interfaces', sections: abuDhabiPlantInterfaceGoldSections),
    _GoldChapter(title: '5AJ Part 2 — Gaps / Duplicate / CoP 36.0', subtitle: 'Master audit and closure', sections: abuDhabiPlantAuditGoldSections),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(title: const Text('Plant & Equipment — Gold Standard'), backgroundColor: darkGreen, foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(topic.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: darkGreen)),
                  const SizedBox(height: 8),
                  const Text('CoP 36.0 • Integrated Gold Standard Plant & Equipment Reference', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: green)),
                  const SizedBox(height: 10),
                  Text(topic.description, style: const TextStyle(fontSize: 15, height: 1.5)),
                  const SizedBox(height: 10),
                  const Text('The registry remains the index; these dedicated books are now the active detailed content layer.', style: TextStyle(fontSize: 14.5, height: 1.45)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          ...chapters.map((chapter) => Card(elevation: 0, margin: const EdgeInsets.only(bottom: 10), child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(backgroundColor: green.withValues(alpha: 0.12), child: const Icon(Icons.precision_manufacturing_outlined, color: darkGreen)),
            title: Text(chapter.title, style: const TextStyle(fontWeight: FontWeight.w900, color: darkGreen)),
            subtitle: Text('${chapter.subtitle} • ${chapter.sections.length} sections'),
            trailing: const Icon(Icons.chevron_right, color: darkGreen),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AbuDhabiGoldBookPage(topic: topic, sections: chapter.sections, regulatory: 'Integrated under ADPHC CoP 36.0 Plant and Equipment; apply the specific related CoP and manufacturer requirements for the equipment/task.'))),
          ))),
        ],
      ),
    );
  }
}
