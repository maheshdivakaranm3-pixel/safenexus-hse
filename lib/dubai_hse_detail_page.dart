import 'package:flutter/material.dart';

import 'models/reference_topic.dart';
import 'data/dubai_guidelines.dart';

/// SafeNexus HSE - Dubai HSE topic pages.
///
/// Every Dubai HSE topic is routed to its own dedicated page class. The
/// content is topic-specific and intentionally does not show a References
/// section or the generic reference disclaimer.
class DubaiHseDetailPage extends StatelessWidget {
  final ReferenceTopic topic;

  const DubaiHseDetailPage({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return DubaiHseTopicRouter.pageFor(topic);
  }
}

class DubaiHseTopicRouter {
  static Widget pageFor(ReferenceTopic topic) {
    switch (topic.id) {
      case 'dubai_construction_safety': return const DubaiConstructionSafetyDetailPage();
      case 'dubai_hse_management': return const DubaiHseManagementDetailPage();
      case 'dubai_risk_assessment': return const DubaiRiskAssessmentDetailPage();
      case 'dubai_hse_plan': return const DubaiHsePlanDetailPage();
      case 'dubai_work_at_height': return const DubaiWorkAtHeightDetailPage();
      case 'dubai_scaffolding': return const DubaiScaffoldingDetailPage();
      case 'dubai_lifting': return const DubaiLiftingDetailPage();
      case 'dubai_excavation': return const DubaiExcavationDetailPage();
      case 'dubai_confined_space': return const DubaiConfinedSpaceDetailPage();
      case 'dubai_electrical': return const DubaiElectricalDetailPage();
      case 'dubai_hot_work': return const DubaiHotWorkDetailPage();
      case 'dubai_traffic': return const DubaiTrafficDetailPage();
      case 'dubai_demolition': return const DubaiDemolitionDetailPage();
      case 'dubai_temporary_works': return const DubaiTemporaryWorksDetailPage();
      case 'dubai_heat_stress': return const DubaiHeatStressDetailPage();
      case 'dubai_occupational_health': return const DubaiOccupationalHealthDetailPage();
      case 'dubai_ppe': return const DubaiPpeDetailPage();
      case 'dubai_emergency': return const DubaiEmergencyDetailPage();
      case 'dubai_incident': return const DubaiIncidentDetailPage();
      case 'dubai_contractor': return const DubaiContractorDetailPage();
      case 'dubai_environment': return const DubaiEnvironmentDetailPage();
      case 'dubai_inspection': return const DubaiInspectionDetailPage();
      case 'dubai_performance': return const DubaiPerformanceDetailPage();
      case 'dubai_building_code': return const DubaiBuildingCodeDetailPage();
      case 'dubai_permit_to_work': return const DubaiPermitToWorkDetailPage();
      case 'dubai_cop_site_establishment': return const DubaiCopSiteEstablishmentDetailPage();
      case 'dubai_cop_public_protection': return const DubaiCopPublicProtectionDetailPage();
      case 'dubai_cop_access_housekeeping': return const DubaiCopAccessHousekeepingDetailPage();
      case 'dubai_cop_welfare_facilities': return const DubaiCopWelfareFacilitiesDetailPage();
      case 'dubai_cop_material_storage': return const DubaiCopMaterialStorageDetailPage();
      case 'dubai_cop_formwork_falsework': return const DubaiCopFormworkFalseworkDetailPage();
      case 'dubai_cop_rebar_concrete': return const DubaiCopRebarConcreteDetailPage();
      case 'dubai_cop_machinery_guarding': return const DubaiCopMachineryGuardingDetailPage();
      case 'dubai_cop_ladders_mobile_towers': return const DubaiCopLaddersMobileTowersDetailPage();
      case 'dubai_cop_fire_emergency': return const DubaiCopFireEmergencyDetailPage();
      case 'dubai_cop_signs_barricading': return const DubaiCopSignsBarricadingDetailPage();
      case 'dubai_cop_lighting_weather': return const DubaiCopLightingWeatherDetailPage();
      default: return DubaiHseDedicatedPage(topic: topic, content: _contentFor(topic.id));
    }
  }
}

class _DubaiTopicContent {
  final String purpose;
  final List<String> hazards;
  final List<String> requirements;
  final List<String> controls;
  final List<String> fieldChecks;
  final List<String> emergency;

  const _DubaiTopicContent({
    required this.purpose,
    required this.hazards,
    required this.requirements,
    required this.controls,
    required this.fieldChecks,
    required this.emergency,
  });
}

const Map<String, _DubaiTopicContent> _topicContent = {
  'dubai_construction_safety': _DubaiTopicContent(
    purpose: 'Establishes the overall construction safety framework for planning, supervision, worker protection and protection of the public throughout the project lifecycle.',
    hazards: ['Uncontrolled high-risk construction activities', 'Falling objects and materials', 'Vehicle and pedestrian interaction', 'Unsafe temporary works and access', 'Poor coordination between contractors and simultaneous activities'],
    requirements: ['Project construction activities shall be planned around the approved HSE arrangements and applicable Dubai requirements.', 'Competent supervision shall be available at active work fronts and high-risk activities.', 'Risk assessments, RAMS, permits and inspections shall reflect actual site conditions.', 'Workers shall receive suitable induction, task information and supervision before starting work.', 'Changes in sequence, design, plant or work conditions shall trigger review of the relevant controls.'],
    controls: ['Define site boundaries, controlled access and emergency routes.', 'Separate people, plant and high-risk work zones.', 'Maintain effective barricading, signage, housekeeping and lighting.', 'Coordinate contractors and simultaneous operations through planned interfaces.', 'Use inspection and corrective-action systems to verify controls in the field.'],
    fieldChecks: ['Check that the current HSE plan and RAMS are available at the work front.', 'Walk the work area and compare actual controls with the planned controls.', 'Confirm competent supervision is present for high-risk activities.', 'Check access, exclusion zones, housekeeping and emergency arrangements.', 'Verify critical findings are corrected before work continues.'],
    emergency: ['Stop the affected activity when an immediate life-safety risk exists.', 'Protect the area and prevent additional exposure.', 'Raise the site emergency alarm and notify the responsible project team.', 'Evacuate, rescue or provide first aid according to the approved emergency plan.', 'Preserve the incident area where practicable after people are made safe.'],
  ),
  'dubai_hse_management': _DubaiTopicContent(
    purpose: 'Provides the management structure needed to turn HSE policy into measurable responsibilities, resources, procedures, competence and continual improvement.',
    hazards: ['Unclear HSE accountability', 'Inadequate resources or supervision', 'Outdated procedures and risk registers', 'Weak contractor coordination', 'Repeated findings without effective corrective action'],
    requirements: ['Define HSE roles, authority and accountability for management, supervision and workers.', 'Maintain current risk registers, objectives, procedures and emergency arrangements.', 'Provide adequate competent HSE resources and supervision for project risk.', 'Review incidents, inspections, audits and performance trends at management level.', 'Ensure corrective actions have owners, deadlines and verification of effectiveness.'],
    controls: ['Use documented HSE plans, procedures and responsibilities.', 'Maintain training and competency matrices for critical roles.', 'Hold planned inspections, audits and management reviews.', 'Track actions through to physical verification rather than paperwork closure alone.', 'Use trend analysis to identify recurring weaknesses before they become incidents.'],
    fieldChecks: ['Confirm responsibilities are understood by supervisors and workers.', 'Check current risk assessments and HSE objectives.', 'Sample training and competency evidence for critical tasks.', 'Review open critical actions and overdue corrective actions.', 'Confirm management decisions are implemented at the work front.'],
    emergency: ['Escalate uncontrolled significant risk through the HSE management chain.', 'Activate the project emergency plan when people may be harmed.', 'Ensure competent management support is available during major incidents.', 'Record and review significant events and ensure lessons are communicated.'],
  ),
  'dubai_risk_assessment': _DubaiTopicContent(
    purpose: 'Provides a structured method to identify hazards, evaluate risk and select controls before and during construction work.',
    hazards: ['Unidentified hazards', 'Incorrect risk rating', 'Controls based only on PPE', 'Changes in work conditions not reflected in the assessment', 'Workers not understanding the controls'],
    requirements: ['Identify hazards for the actual task, location, equipment and sequence.', 'Identify people who may be exposed, including workers, visitors and the public.', 'Evaluate risk using the project-approved methodology.', 'Apply the hierarchy of controls and reduce risk so far as reasonably practicable.', 'Review the assessment after changes, incidents, near misses or significant site conditions.'],
    controls: ['Use task steps and work-front observations to identify hazards.', 'Prefer elimination, substitution and engineering controls before administrative controls and PPE.', 'Involve competent supervisors and workers who understand the task.', 'Communicate significant controls through RAMS, toolbox talks and permits.', 'Stop and reassess when the actual work differs from the approved assessment.'],
    fieldChecks: ['Compare the risk assessment with the physical work activity.', 'Confirm every significant hazard has a visible control.', 'Ask workers to explain the key controls.', 'Check residual risk and approval status.', 'Verify review triggers are being acted upon.'],
    emergency: ['Stop the task when a significant hazard is uncontrolled.', 'Move people away from the exposure zone.', 'Reassess the task and implement additional controls before restarting.', 'Escalate uncertainty to the competent HSE or technical authority.'],
  ),
  'dubai_hse_plan': _DubaiTopicContent(
    purpose: 'Translates project risks, legal duties and site arrangements into one coordinated project-level HSE management plan.',
    hazards: ['Uncoordinated contractor activities', 'Missing emergency or welfare arrangements', 'Poor interface management', 'Work proceeding without approved RAMS', 'Site arrangements changing without plan review'],
    requirements: ['Maintain an approved project-specific HSE plan.', 'Define organisation, responsibilities, training, communication and consultation arrangements.', 'Address risk management, PTW, emergency response, welfare, traffic, environmental controls and inspections.', 'Integrate contractor and subcontractor arrangements into the project system.', 'Review the plan when project scope, sequence or risk changes.'],
    controls: ['Maintain a controlled current version of the plan.', 'Link high-risk activities to approved RAMS and permits.', 'Use site inductions and toolbox talks to communicate arrangements.', 'Coordinate interfaces between trades and contractors.', 'Audit implementation rather than relying only on document availability.'],
    fieldChecks: ['Verify the current HSE plan is available.', 'Check that site arrangements match the plan.', 'Confirm emergency contacts and muster arrangements are current.', 'Review contractor interfaces and simultaneous operations.', 'Check inspection and action systems are functioning.'],
    emergency: ['Use the emergency arrangements defined in the approved HSE plan.', 'Raise the alarm and account for personnel.', 'Coordinate rescue, first aid and evacuation through assigned roles.', 'Review the plan after significant emergencies or exercises.'],
  ),
  'dubai_work_at_height': _DubaiTopicContent(
    purpose: 'Controls fall-from-height and falling-object risks by prioritising safe design, collective protection, suitable access and planned rescue.',
    hazards: ['Falls from edges and openings', 'Falls through fragile surfaces', 'Falling tools and materials', 'Improper ladder or access use', 'Suspension or delayed rescue after a fall-arrest event'],
    requirements: ['Plan work to avoid height exposure where reasonably practicable.', 'Provide suitable platforms, guardrails, covers and other collective protection.', 'Use fall-restraint or fall-arrest systems only when appropriate and properly planned.', 'Inspect access and fall-protection equipment before use.', 'Provide a realistic rescue arrangement for workers using fall-arrest systems.'],
    controls: ['Protect floor openings and exposed edges.', 'Use compliant access systems and secure them against movement.', 'Control dropped objects with toe boards, tool lanyards or exclusion zones as appropriate.', 'Maintain safe distances from leading edges and fragile surfaces.', 'Prevent unauthorised removal or modification of edge protection.'],
    fieldChecks: ['Check all edges, openings and fragile areas.', 'Inspect platforms, guardrails and access routes.', 'Verify harnesses, lanyards and anchor arrangements where used.', 'Confirm dropped-object controls and exclusion zones.', 'Ask the team to explain the rescue method.'],
    emergency: ['Stop work and isolate the fall area.', 'Raise the alarm and use the planned rescue system.', 'Do not improvise a rescue that exposes another person to a fall.', 'Arrange medical assessment after a fall-arrest event.'],
  ),
  'dubai_scaffolding': _DubaiTopicContent(
    purpose: 'Controls scaffold erection, use, alteration and dismantling so that the scaffold remains stable, properly accessed and suitable for its intended loading.',
    hazards: ['Scaffold collapse or instability', 'Falls from incomplete platforms', 'Falling materials', 'Overloading of platforms', 'Unauthorised alteration or removal of components'],
    requirements: ['Use competent persons for erection, alteration and dismantling.', 'Provide a stable foundation and adequate ties, bracing and structural support.', 'Provide complete platforms, guardrails, toe boards and safe access.', 'Inspect the scaffold at required stages and after events that may affect stability.', 'Prevent use of incomplete, damaged or altered scaffolds until released by the competent person.'],
    controls: ['Use suitable base plates, sole boards, ties and bracing as required by the scaffold design.', 'Maintain safe working platforms and access ladders or stair systems.', 'Control loading and keep materials distributed within the intended capacity.', 'Use a visible inspection/status system.', 'Barricade or tag scaffolds that are unsafe or incomplete.'],
    fieldChecks: ['Check base condition, verticality, bracing and ties.', 'Check platforms, guardrails, toe boards and access.', 'Verify inspection status is current.', 'Check for unauthorised modifications and missing components.', 'Confirm loading is appropriate for the platform.'],
    emergency: ['Stop use of a damaged or unstable scaffold immediately.', 'Establish an exclusion zone below and around the affected area.', 'Prevent access until competent inspection and correction are completed.', 'If a person has fallen, activate the planned rescue and medical response.'],
  ),
  'dubai_lifting': _DubaiTopicContent(
    purpose: 'Controls crane and lifting operations through planning, competent personnel, suitable equipment, stable ground, communication and exclusion zones.',
    hazards: ['Dropped loads', 'Crane instability or overturning', 'Load swing and collision', 'Failure of lifting accessories', 'People entering the suspended-load zone'],
    requirements: ['Plan the lift according to load, radius, equipment capacity, ground conditions and surrounding hazards.', 'Use suitable inspected and certified lifting equipment and accessories.', 'Assign competent operators, riggers and signallers.', 'Establish an effective exclusion zone and prevent people from standing under suspended loads.', 'Stop and reassess when weather, ground, load or site conditions change.'],
    controls: ['Verify load weight, centre of gravity and lifting points.', 'Check crane setup, ground bearing and outrigger arrangements.', 'Inspect slings, shackles, hooks and other accessories before use.', 'Use clear agreed signals or reliable communication.', 'Control tag lines, swing radius and access around the lifting area.'],
    fieldChecks: ['Check lift plan and equipment certification.', 'Inspect accessories and lifting points.', 'Verify crane setup and ground condition.', 'Confirm exclusion zone and communication.', 'Observe the first lift or critical lifts closely.'],
    emergency: ['Stop the lift for instability, loss of communication or equipment failure.', 'Secure the load and clear people from the danger zone.', 'Do not approach a suspended or unstable load until it is made safe.', 'Report equipment damage and remove defective equipment from service.'],
  ),
  'dubai_excavation': _DubaiTopicContent(
    purpose: 'Controls excavation and trenching risks including ground collapse, buried services, falls, plant interaction, water ingress and hazardous atmospheres.',
    hazards: ['Side-wall collapse and engulfment', 'Striking underground utilities', 'Falls of people or materials into excavations', 'Plant or vehicles approaching edges', 'Water accumulation or hazardous atmosphere'],
    requirements: ['Identify underground services before excavation and establish safe digging controls.', 'Provide suitable shoring, shielding, battering or other engineered ground-support arrangements.', 'Provide safe access and egress.', 'Keep spoil, materials and plant a safe distance from edges.', 'Inspect excavations before entry and after relevant changes, rain, vibration or other events.'],
    controls: ['Use approved drawings, service detection and permit arrangements.', 'Barricade edges and protect pedestrian routes.', 'Control plant near excavation edges with defined stand-off distances.', 'Provide pumps or drainage controls where water ingress is possible.', 'Test atmosphere where the excavation may contain hazardous gases or become oxygen deficient.'],
    fieldChecks: ['Verify services have been identified and controlled.', 'Inspect support, battering or shielding.', 'Check ladders, stairs or other access.', 'Check edge protection and spoil/plant stand-off.', 'Inspect after weather, collapse signs, vibration or changes.'],
    emergency: ['Do not enter a collapsed or unstable excavation for an improvised rescue.', 'Withdraw people from the danger zone and raise the alarm.', 'Isolate nearby plant and services where safe.', 'Use the planned rescue and emergency response arrangements.'],
  ),
  'dubai_confined_space': _DubaiTopicContent(
    purpose: 'Controls entry into spaces where toxic gases, oxygen deficiency, engulfment, restricted access or difficult rescue can create serious risk.',
    hazards: ['Oxygen deficiency', 'Toxic or flammable gases', 'Engulfment', 'Heat or poor ventilation', 'Difficult or delayed rescue'],
    requirements: ['Determine whether the space is a confined space before entry.', 'Use an approved entry permit and verify required isolations.', 'Test and record the atmosphere before entry and as required during work.', 'Provide ventilation, communication, standby personnel and suitable rescue arrangements.', 'Ensure entrants and rescuers are trained and competent for the identified hazards.'],
    controls: ['Isolate mechanical, electrical, process and material sources before entry.', 'Use calibrated gas detection equipment.', 'Maintain continuous or periodic atmospheric monitoring according to the risk.', 'Control ignition sources and use suitable low-voltage equipment where required.', 'Keep rescue equipment ready and maintain reliable communication with entrants.'],
    fieldChecks: ['Verify permit and isolation status.', 'Check gas-test results and instrument status.', 'Inspect ventilation and communication.', 'Confirm standby person and rescue team readiness.', 'Check entrants understand entry limits and emergency signals.'],
    emergency: ['Never send an unprotected person into a confined space for rescue.', 'Raise the alarm and call the trained rescue team.', 'Isolate the hazard where safe and maintain external control of the space.', 'Provide first aid and medical support after safe recovery.'],
  ),
  'dubai_electrical': _DubaiTopicContent(
    purpose: 'Controls electrical shock, arc flash, fire and equipment damage through isolation, protection, competent work and inspection.',
    hazards: ['Electric shock and electrocution', 'Arc flash and burns', 'Electrical fire', 'Damaged temporary wiring', 'Unexpected energisation'],
    requirements: ['Electrical work shall be carried out by competent persons.', 'Use isolation and lockout arrangements appropriate to the task.', 'Provide suitable protective devices and earthing.', 'Inspect temporary electrical installations, cables, plugs and distribution boards.', 'Protect electrical equipment from mechanical damage, water and unauthorised access.'],
    controls: ['Identify the electrical source before work.', 'Use lockout/tagout and prove dead where applicable.', 'Protect cables from traffic and sharp edges.', 'Use suitable RCD/GFCI protection where required by the installation and project standards.', 'Keep electrical panels accessible, identified and protected.'],
    fieldChecks: ['Check distribution boards and protective devices.', 'Inspect cables, plugs and connections.', 'Verify isolation controls.', 'Check earthing and protection arrangements.', 'Confirm only authorised competent persons perform electrical work.'],
    emergency: ['Do not touch an electrical casualty until the energy source is controlled.', 'Isolate the supply if safe and raise the alarm.', 'Keep others away from the electrical hazard.', 'Provide first aid and emergency medical response after isolation.'],
  ),
  'dubai_hot_work': _DubaiTopicContent(
    purpose: 'Controls ignition sources from welding, cutting, grinding and similar work so that fire and explosion risks are prevented before, during and after the activity.',
    hazards: ['Ignition of combustible materials', 'Gas cylinder fire or explosion', 'Hot slag and sparks', 'Flammable vapours', 'Fire developing after work stops'],
    requirements: ['Authorise hot work through the applicable permit process.', 'Remove or protect combustibles and control sparks and slag.', 'Inspect cylinders, hoses, regulators and connections.', 'Provide suitable extinguishers and a competent fire watch where required.', 'Maintain post-work fire monitoring for the risk period.'],
    controls: ['Use spark containment and fire-resistant screens.', 'Separate gas cylinders from ignition sources and secure them upright.', 'Control nearby openings, ducts and hidden combustible spaces.', 'Test atmospheres where flammable vapours may be present.', 'Maintain housekeeping throughout the job.'],
    fieldChecks: ['Verify permit status and work boundaries.', 'Check combustibles and spark paths.', 'Inspect cylinders and hoses.', 'Confirm extinguisher and fire-watch arrangements.', 'Confirm post-work monitoring is completed.'],
    emergency: ['Stop the hot work and isolate the ignition source where safe.', 'Raise the alarm for any uncontrolled fire.', 'Use first-aid firefighting equipment only when trained and safe to do so.', 'Evacuate when the fire cannot be immediately controlled.'],
  ),
  'dubai_traffic': _DubaiTopicContent(
    purpose: 'Controls construction traffic by separating pedestrians and vehicles and managing routes, reversing, deliveries, speed and visibility.',
    hazards: ['Vehicle-pedestrian collision', 'Reversing incidents', 'Blind spots', 'Uncontrolled deliveries', 'Plant entering pedestrian work areas'],
    requirements: ['Plan and maintain vehicle and pedestrian routes.', 'Use physical separation where reasonably practicable.', 'Control reversing with suitable visibility, technology or trained banksmen as required.', 'Set suitable speed limits and enforce them.', 'Coordinate deliveries and plant movements with site activities.'],
    controls: ['Use barriers, walkways, crossings and signage.', 'Keep routes clear and adequately lit.', 'Use trained banksmen/signallers for movements requiring them.', 'Control visitor and delivery access.', 'Maintain safe stand-off distances around mobile plant.'],
    fieldChecks: ['Walk pedestrian routes and crossings.', 'Check barriers and signs.', 'Observe reversing controls.', 'Check driver and plant competence arrangements.', 'Verify delivery routes are clear and controlled.'],
    emergency: ['Stop movements in the affected area after a collision or near miss.', 'Protect the scene and prevent secondary vehicle exposure.', 'Raise the alarm and provide first aid.', 'Reopen the route only after the hazard and investigation requirements are addressed.'],
  ),
  'dubai_demolition': _DubaiTopicContent(
    purpose: 'Controls demolition through pre-work surveys, structural assessment, isolation, sequencing, exclusion zones and controlled removal of materials.',
    hazards: ['Unexpected structural collapse', 'Falling materials', 'Hidden services', 'Dust and hazardous materials', 'Plant and people entering unstable areas'],
    requirements: ['Complete appropriate pre-demolition surveys and structural assessment.', 'Identify and isolate utilities and hazardous services.', 'Use an approved demolition sequence and method.', 'Establish exclusion zones and control access.', 'Monitor structures for unexpected movement or instability.'],
    controls: ['Use competent demolition supervision.', 'Control dust and debris generation.', 'Maintain safe plant positions and exclusion distances.', 'Remove materials in a controlled sequence rather than uncontrolled collapse.', 'Stop work when unexpected conditions are discovered.'],
    fieldChecks: ['Verify survey and method are current.', 'Check utility isolation.', 'Inspect exclusion zones.', 'Confirm demolition sequence is understood.', 'Look for cracks, movement, vibration or unexpected structural behaviour.'],
    emergency: ['Stop demolition and withdraw from unstable areas.', 'Establish a larger exclusion zone when structural movement occurs.', 'Raise the alarm and coordinate rescue only through competent personnel.', 'Do not re-enter until the structure is assessed and made safe.'],
  ),
  'dubai_temporary_works': _DubaiTopicContent(
    purpose: 'Controls temporary structures and supports such as formwork, falsework, shoring and temporary platforms through design, checking, erection, inspection and controlled removal.',
    hazards: ['Collapse or instability', 'Overloading', 'Incorrect erection', 'Unauthorised modification', 'Premature striking or removal'],
    requirements: ['Design and check temporary works according to the project temporary-works process.', 'Provide competent supervision during erection and modification.', 'Inspect before loading and after relevant changes or events.', 'Keep loads within design assumptions.', 'Control striking and removal through an approved sequence.'],
    controls: ['Maintain drawings and design information at the work front.', 'Use correct supports, bracing and connections.', 'Prevent accidental removal or movement of components.', 'Control access around temporary works during critical stages.', 'Record inspections and release status.'],
    fieldChecks: ['Check design approval and current revision.', 'Inspect support and bracing.', 'Verify loading conditions.', 'Check for unauthorised changes.', 'Confirm inspection and release status before use.'],
    emergency: ['Stop loading after movement, distress or instability.', 'Evacuate the affected zone.', 'Prevent re-entry until competent engineering assessment is complete.', 'Treat damaged components as unsafe until assessed.'],
  ),
  'dubai_heat_stress': _DubaiTopicContent(
    purpose: 'Controls heat exposure using hydration, shade, acclimatisation, work-rest arrangements, monitoring and rapid response to heat illness.',
    hazards: ['Heat exhaustion', 'Heat stroke', 'Dehydration', 'Reduced concentration and increased error rate', 'Heat exposure intensified by PPE and heavy work'],
    requirements: ['Assess heat exposure considering temperature, humidity, air movement, workload and PPE.', 'Provide cool drinking water and suitable shaded or cooled rest areas.', 'Use work-rest arrangements appropriate to the exposure.', 'Acclimatise workers and monitor vulnerable or newly assigned workers.', 'Train workers and supervisors to recognise and respond to heat illness.'],
    controls: ['Schedule heavy work to reduce peak exposure where practicable.', 'Use ventilation or air movement where suitable.', 'Encourage regular hydration before thirst develops.', 'Use buddy monitoring for symptoms.', 'Stop and respond immediately when signs of serious heat illness appear.'],
    fieldChecks: ['Check heat conditions and work-rest controls.', 'Verify drinking water availability.', 'Inspect shade/rest arrangements.', 'Confirm worker awareness of symptoms.', 'Check supervision and acclimatisation arrangements.'],
    emergency: ['Move the affected worker to a cool safe area.', 'Begin appropriate first response and summon medical assistance for serious symptoms.', 'Do not return a seriously affected worker to heat exposure.', 'Review the work-rest and environmental controls before continuing.'],
  ),
  'dubai_occupational_health': _DubaiTopicContent(
    purpose: 'Prevents work-related illness by identifying occupational exposures and maintaining suitable health surveillance, hygiene, welfare and exposure controls.',
    hazards: ['Dust and respiratory exposure', 'Noise', 'Chemical exposure', 'Ergonomic strain', 'Poor hygiene and welfare conditions'],
    requirements: ['Identify occupational health hazards for the workforce and tasks.', 'Provide health surveillance where the risk and applicable requirements indicate it.', 'Control exposure at source before relying on PPE.', 'Provide suitable hygiene, sanitation, drinking water and welfare arrangements.', 'Encourage early reporting of symptoms and occupational health concerns.'],
    controls: ['Use engineering controls for dust, noise and chemical exposure.', 'Maintain clean welfare and washing facilities.', 'Apply suitable manual-handling and ergonomic controls.', 'Maintain SDS/chemical information and exposure procedures.', 'Review occupational health trends and recurring symptoms.'],
    fieldChecks: ['Check exposure controls at the work front.', 'Inspect welfare and hygiene facilities.', 'Verify required health surveillance arrangements.', 'Speak with workers about symptoms and task difficulties.', 'Check corrective actions for occupational health findings.'],
    emergency: ['Remove the person from acute exposure.', 'Provide first aid or medical assistance as required.', 'Control the source of exposure before allowing others to enter.', 'Report and investigate significant occupational exposure.'],
  ),
  'dubai_ppe': _DubaiTopicContent(
    purpose: 'Ensures personal protective equipment is selected and used as the final layer of protection after higher-level controls have been applied.',
    hazards: ['Incorrect PPE selection', 'Poor fit or compatibility', 'Damaged or expired equipment', 'Workers not understanding limitations', 'PPE giving false confidence when higher controls are absent'],
    requirements: ['Select PPE according to the task and hazard assessment.', 'Provide suitable fit, compatibility and sizes.', 'Inspect and maintain PPE before and during use.', 'Replace damaged or unsuitable PPE.', 'Train workers in correct use, limitations, storage and care.'],
    controls: ['Use task-specific PPE matrices where appropriate.', 'Check compatibility when multiple items are worn together.', 'Keep PPE clean and stored correctly.', 'Do not allow defective PPE to remain in service.', 'Use supervision to reinforce correct use.'],
    fieldChecks: ['Check PPE matches the task.', 'Inspect condition and fit.', 'Check compatibility of combined PPE.', 'Verify worker understanding.', 'Remove defective PPE from service.'],
    emergency: ['Stop the task when required protection is unavailable or defective.', 'Replace or correct PPE before restarting.', 'Escalate repeated PPE failures to supervision and procurement.'],
  ),
  'dubai_emergency': _DubaiTopicContent(
    purpose: 'Provides the site framework for alarm, communication, evacuation, rescue, first aid, accountability and recovery during emergencies.',
    hazards: ['Delayed alarm or communication', 'Blocked escape routes', 'Unaccounted personnel', 'Unplanned rescue attempts', 'Emergency equipment unavailable or inaccessible'],
    requirements: ['Maintain a site-specific emergency plan.', 'Define emergency contacts, alarms, evacuation routes and assembly points.', 'Provide suitable first-aid and emergency equipment.', 'Conduct drills and review performance.', 'Coordinate emergency arrangements with contractors and visitors.'],
    controls: ['Keep escape routes clear and signed.', 'Maintain reliable emergency communications.', 'Provide trained first aiders and competent emergency teams as required.', 'Maintain muster/accountability systems.', 'Record drill findings and close corrective actions.'],
    fieldChecks: ['Check alarm and communication methods.', 'Walk escape routes.', 'Inspect first-aid and emergency equipment.', 'Confirm assembly points and accountability.', 'Review recent drill actions.'],
    emergency: ['Raise the alarm immediately.', 'Call the designated emergency services or site response as required.', 'Evacuate or shelter according to the emergency plan.', 'Account for people and provide information to responders.', 'Do not re-enter until authorised.'],
  ),
  'dubai_incident': _DubaiTopicContent(
    purpose: 'Ensures incidents and near misses are controlled, reported, investigated and converted into effective corrective and preventive actions.',
    hazards: ['Secondary exposure after an incident', 'Loss of evidence', 'Incorrect root-cause analysis', 'Repeated events due to weak actions', 'Delayed notification'],
    requirements: ['Make the area safe and provide immediate care.', 'Notify incidents through the required project and authority channels.', 'Preserve evidence where practicable.', 'Investigate root and contributing causes.', 'Verify corrective actions are effective and communicate lessons learned.'],
    controls: ['Use a defined incident notification process.', 'Control the scene and prevent disturbance of evidence.', 'Use interviews, records and physical evidence in investigation.', 'Separate immediate causes from underlying management causes.', 'Track actions to verified closure.'],
    fieldChecks: ['Confirm notification was completed.', 'Check scene/evidence preservation.', 'Review investigation quality.', 'Verify actions address causes rather than symptoms.', 'Check effectiveness after closure.'],
    emergency: ['Control immediate hazards first.', 'Provide first aid and emergency response.', 'Prevent additional people entering the danger zone.', 'Escalate serious incidents through the established process.'],
  ),
  'dubai_contractor': _DubaiTopicContent(
    purpose: 'Controls contractor and subcontractor HSE performance from prequalification through mobilisation, work execution, monitoring and close-out.',
    hazards: ['Unverified competence', 'Conflicting procedures', 'Poor supervision', 'Uncoordinated simultaneous work', 'Repeated contractor non-compliance'],
    requirements: ['Verify contractor competence, resources and relevant HSE capability.', 'Complete induction and mobilisation requirements.', 'Approve RAMS and permits before high-risk work.', 'Coordinate interfaces and supervision.', 'Monitor performance and enforce corrective actions.'],
    controls: ['Use contractor prequalification and onboarding checks.', 'Define responsibilities in contracts and site arrangements.', 'Conduct joint inspections and coordination meetings.', 'Track contractor findings and leading indicators.', 'Escalate serious or repeated non-compliance.'],
    fieldChecks: ['Check contractor induction status.', 'Verify competent supervision.', 'Sample RAMS understanding.', 'Review open contractor actions.', 'Confirm site performance matches submitted competence claims.'],
    emergency: ['Suspend contractor activity when serious immediate danger exists.', 'Protect the affected work area.', 'Use the project emergency system and contractor emergency contacts.', 'Reassess contractor controls before restart.'],
  ),
  'dubai_environment': _DubaiTopicContent(
    purpose: 'Controls construction environmental risks such as waste, spills, releases, dust, contaminated materials and poor storage.',
    hazards: ['Chemical or fuel spills', 'Improper waste segregation', 'Dust and airborne pollution', 'Uncontrolled discharge to drains', 'Unsafe storage of hazardous materials'],
    requirements: ['Identify environmental aspects and significant risks.', 'Segregate, contain, store and dispose of waste appropriately.', 'Prevent spills and protect drainage systems.', 'Maintain suitable spill response materials.', 'Report and investigate significant environmental incidents.'],
    controls: ['Use labelled waste containers and designated storage areas.', 'Provide secondary containment for relevant liquids.', 'Protect drains and watercourses.', 'Maintain spill kits at risk locations.', 'Use approved disposal routes and records.'],
    fieldChecks: ['Inspect waste segregation.', 'Check chemical/fuel storage.', 'Look for leaks and contaminated ground.', 'Verify spill kits are available.', 'Check housekeeping around environmental risk areas.'],
    emergency: ['Stop the release if safe.', 'Contain the spill and protect drains.', 'Notify the responsible environmental team.', 'Collect contaminated materials safely and dispose of them through approved routes.'],
  ),
  'dubai_inspection': _DubaiTopicContent(
    purpose: 'Provides a structured inspection process to identify unsafe conditions, verify controls and drive timely corrective action.',
    hazards: ['Critical hazards remaining unidentified', 'Paper-only inspections', 'Overdue corrective actions', 'Weak evidence', 'Repeated findings'],
    requirements: ['Plan inspections according to project risk.', 'Record clear evidence and location-specific findings.', 'Assign owners and realistic deadlines.', 'Escalate critical findings immediately.', 'Verify physical closure and effectiveness.'],
    controls: ['Use risk-based inspection schedules.', 'Inspect work fronts rather than only offices.', 'Use photographs or other evidence where appropriate.', 'Trend recurring findings.', 'Verify closure at the location.'],
    fieldChecks: ['Check inspection frequency.', 'Review quality of findings.', 'Sample open actions.', 'Physically verify closed actions.', 'Identify recurring themes.'],
    emergency: ['Stop affected work for critical uncontrolled findings.', 'Protect people from immediate exposure.', 'Escalate through the site HSE chain.', 'Restart only after effective controls are verified.'],
  ),
  'dubai_performance': _DubaiTopicContent(
    purpose: 'Uses leading and lagging HSE indicators to identify trends, test the effectiveness of controls and drive management improvement.',
    hazards: ['Focusing only on injury statistics', 'Under-reporting', 'Poor-quality data', 'Ignoring leading indicators', 'Failure to act on adverse trends'],
    requirements: ['Define meaningful leading and lagging indicators.', 'Use reliable and consistent data.', 'Review trends rather than isolated numbers.', 'Link poor performance to corrective actions.', 'Use management review to test whether controls are working.'],
    controls: ['Track inspections, training, actions, observations and high-risk activity controls.', 'Analyse incidents and near misses.', 'Review contractor performance.', 'Compare trends over time.', 'Verify action effectiveness.'],
    fieldChecks: ['Check data quality.', 'Review current trends.', 'Compare reported performance with field conditions.', 'Identify recurring weaknesses.', 'Confirm management actions are implemented.'],
    emergency: ['Escalate rapidly deteriorating HSE performance when it indicates serious risk.', 'Increase field controls and supervision.', 'Investigate the cause of significant adverse trends.'],
  ),
  'dubai_building_code': _DubaiTopicContent(
    purpose: 'Explains how building-related safety, health, welfare and life-safety requirements interface with construction activities and completed facilities.',
    hazards: ['Unsafe design interfaces', 'Inadequate access or egress', 'Life-safety system deficiencies', 'Uncontrolled design changes', 'Construction work conflicting with approved design'],
    requirements: ['Identify applicable building requirements for the project.', 'Coordinate design and construction safety interfaces.', 'Maintain required access, egress and life-safety provisions.', 'Control design changes through competent review.', 'Use competent technical and building-control input where required.'],
    controls: ['Maintain approved drawings and current revisions.', 'Protect required fire and life-safety systems during construction.', 'Coordinate temporary and permanent access/egress.', 'Review changes before implementation.', 'Record inspections and approvals.'],
    fieldChecks: ['Verify current drawings.', 'Check access and egress.', 'Inspect life-safety interfaces.', 'Confirm changes are approved.', 'Escalate design uncertainty to competent technical personnel.'],
    emergency: ['Restrict areas with immediate life-safety deficiencies.', 'Notify responsible technical/building-control personnel.', 'Use temporary controls until permanent correction is completed.'],
  ),
  'dubai_permit_to_work': _DubaiTopicContent(
    purpose: 'Provides formal control of high-risk work by linking authorization, hazard controls, isolations, interfaces, handover and close-out.',
    hazards: ['Unauthorised high-risk work', 'Incomplete isolation', 'Permit scope not matching actual work', 'Simultaneous incompatible activities', 'Permit remaining open after work ends'],
    requirements: ['Define which activities require permits.', 'Verify controls and isolations before authorization.', 'Ensure permit scope, location, duration and conditions are clear.', 'Control handover and suspension when conditions change.', 'Close or cancel permits correctly after work.'],
    controls: ['Use competent permit issuers and receivers.', 'Verify isolations physically where required.', 'Display or make permit status available at the work area.', 'Coordinate conflicting permits and simultaneous operations.', 'Revalidate permits when conditions or shifts change.'],
    fieldChecks: ['Check permit validity and scope.', 'Verify isolations.', 'Inspect work-front controls.', 'Confirm permit receiver understanding.', 'Check suspension/close-out status.'],
    emergency: ['Suspend the permit when conditions become unsafe.', 'Stop the work and make the area safe.', 'Revalidate before restart.', 'Cancel the permit when the basis for authorization no longer exists.'],
  ),
  'dubai_cop_site_establishment': _DubaiTopicContent(
    purpose: 'Controls the initial and ongoing site arrangement so that boundaries, access, utilities, storage, work zones and emergency routes support safe construction.',
    hazards: ['Uncontrolled public access', 'Poor site layout', 'Unsafe temporary utilities', 'Blocked emergency routes', 'Conflicting material and plant movements'],
    requirements: ['Establish secure site boundaries and controlled access.', 'Plan safe routes, work zones, storage and welfare areas.', 'Provide suitable temporary utilities and protect them from damage.', 'Maintain emergency access and escape routes.', 'Review the layout as construction phases change.'],
    controls: ['Use secure fencing and controlled gates.', 'Separate pedestrian and vehicle movements.', 'Locate storage away from hazards and access routes.', 'Protect temporary power and water services.', 'Maintain clear emergency access.'],
    fieldChecks: ['Inspect boundaries and gates.', 'Walk access and emergency routes.', 'Check temporary utilities.', 'Review site layout against current construction phase.', 'Remove layout conflicts promptly.'],
    emergency: ['Secure unsafe areas and maintain emergency access.', 'Isolate damaged temporary utilities where safe.', 'Redirect people through safe routes while corrections are made.'],
  ),
  'dubai_cop_public_protection': _DubaiTopicContent(
    purpose: 'Protects neighbours, visitors, road users and other members of the public from construction activities and site hazards.',
    hazards: ['Falling objects reaching public areas', 'Vehicle interface with public roads', 'Unauthorised entry', 'Dust, noise or debris affecting neighbours', 'Openings or unstable boundaries'],
    requirements: ['Maintain secure site boundaries and controlled public interfaces.', 'Protect public routes from construction hazards.', 'Control vehicle access and deliveries.', 'Prevent falling objects and debris leaving the site.', 'Maintain clear warnings and barriers around public-facing hazards.'],
    controls: ['Use hoarding, barriers and overhead protection where required by the risk.', 'Coordinate road and pedestrian interfaces.', 'Control gates and security.', 'Maintain housekeeping at site boundaries.', 'Respond quickly to public complaints or unsafe conditions.'],
    fieldChecks: ['Inspect perimeter integrity.', 'Check public walkways and road interfaces.', 'Look for falling-object exposure.', 'Verify gate and delivery controls.', 'Check boundary housekeeping.'],
    emergency: ['Stop the public-interface activity.', 'Secure the affected boundary or route.', 'Prevent public access to the danger zone.', 'Notify responsible project and authority personnel as required.'],
  ),
  'dubai_cop_access_housekeeping': _DubaiTopicContent(
    purpose: 'Maintains safe access, egress, housekeeping and work areas so that slips, trips, falls, blocked escape routes and poor visibility are prevented.',
    hazards: ['Trips and falls', 'Blocked escape routes', 'Poorly maintained stairs', 'Unprotected openings', 'Poor lighting and accumulated debris'],
    requirements: ['Keep routes clear, stable and suitable for the intended use.', 'Provide safe stairs, walkways and access systems.', 'Protect floor openings and edges.', 'Remove waste and materials regularly.', 'Maintain suitable lighting for the work and access route.'],
    controls: ['Use designated storage areas.', 'Remove trailing cables and hoses from walkways or protect them.', 'Keep stairs and platforms free of debris.', 'Provide barriers around openings.', 'Use routine housekeeping inspections.'],
    fieldChecks: ['Walk all main access routes.', 'Check stairs and handrails.', 'Inspect openings and edge protection.', 'Check lighting.', 'Remove or control obstructions immediately.'],
    emergency: ['Close unsafe routes and provide an alternative.', 'Protect people from openings or obstructions.', 'Restore safe access before reopening the route.'],
  ),
  'dubai_cop_welfare_facilities': _DubaiTopicContent(
    purpose: 'Ensures workers have suitable welfare, hygiene, drinking water, rest and first-aid facilities appropriate to the project and workforce.',
    hazards: ['Heat illness and dehydration', 'Poor sanitation', 'Inadequate washing facilities', 'Insufficient rest arrangements', 'Delayed first aid'],
    requirements: ['Provide suitable drinking water and sanitation.', 'Maintain clean washing and welfare facilities.', 'Provide rest arrangements suitable for site conditions.', 'Maintain appropriate first-aid arrangements.', 'Inspect welfare facilities and correct deficiencies promptly.'],
    controls: ['Locate facilities conveniently for workers.', 'Keep drinking water clean, cool and accessible.', 'Provide shade or cooled rest areas as appropriate.', 'Maintain cleaning and waste arrangements.', 'Display emergency and first-aid information.'],
    fieldChecks: ['Check water supply.', 'Inspect toilets and washing facilities.', 'Check rest/shade areas.', 'Verify first-aid arrangements.', 'Review cleaning and maintenance.'],
    emergency: ['Provide immediate access to water, rest or first aid when required.', 'Respond promptly to heat or health symptoms.', 'Correct serious welfare deficiencies before continuing affected work.'],
  ),
  'dubai_cop_material_storage': _DubaiTopicContent(
    purpose: 'Controls storage and handling of construction materials to prevent collapse, falling objects, incompatible storage and manual-handling injuries.',
    hazards: ['Falling or collapsing stacks', 'Overloading racks', 'Unstable pipes or long materials', 'Incompatible chemical storage', 'Manual-handling injuries'],
    requirements: ['Store materials on stable surfaces and in a controlled arrangement.', 'Keep stacks within safe height and stability limits.', 'Segregate incompatible or hazardous materials.', 'Maintain access around storage areas.', 'Use suitable mechanical handling for heavy or awkward materials.'],
    controls: ['Use racks, chocks and restraints where required.', 'Keep heavy items at lower levels where practicable.', 'Protect cylinders and hazardous materials from impact and ignition sources.', 'Maintain clear aisles.', 'Inspect storage after relocation or adverse events.'],
    fieldChecks: ['Inspect stack stability.', 'Check racks and supports.', 'Verify segregation.', 'Check aisle clearance.', 'Look for damaged packaging or materials.'],
    emergency: ['Isolate unstable stacks or damaged storage systems.', 'Keep people outside the fall zone.', 'Use competent personnel and suitable equipment to make the area safe.'],
  ),
  'dubai_cop_formwork_falsework': _DubaiTopicContent(
    purpose: 'Controls formwork and falsework as temporary structural systems, focusing on design, stability, loading, inspection and safe striking.',
    hazards: ['Formwork collapse', 'Overloading', 'Premature striking', 'Falling components', 'Worker falls during erection or removal'],
    requirements: ['Use approved design and current drawings.', 'Erect and modify under competent supervision.', 'Inspect before loading and concrete placement.', 'Control loads and construction sequence.', 'Strike or dismantle only when the required conditions are confirmed.'],
    controls: ['Use adequate props, bracing, ties and foundations.', 'Prevent unauthorised removal of supports.', 'Provide safe access and edge protection.', 'Control concrete placement rate and load sequence.', 'Maintain inspection and release records.'],
    fieldChecks: ['Check drawings and design revision.', 'Inspect props, bracing and connections.', 'Check foundation/support condition.', 'Verify access and edge protection.', 'Confirm striking release before removal.'],
    emergency: ['Stop loading after movement or distress.', 'Evacuate the affected area.', 'Prevent re-entry until competent assessment is completed.', 'Treat displaced or damaged components as unsafe.'],
  ),
  'dubai_cop_rebar_concrete': _DubaiTopicContent(
    purpose: 'Controls reinforcement, concrete placement and associated activities, including impalement, struck-by, hose movement, access and chemical exposure.',
    hazards: ['Rebar impalement', 'Concrete pump hose whip', 'Formwork failure', 'Cement burns and eye exposure', 'Falls around formwork and slab edges'],
    requirements: ['Protect exposed reinforcement against impalement.', 'Control concrete pumping equipment and hose movement.', 'Verify formwork and temporary support before loading.', 'Provide suitable PPE and hygiene controls for wet concrete.', 'Maintain safe access around reinforcement and concrete work.'],
    controls: ['Use caps or suitable physical protection for exposed rebar where required.', 'Establish exclusion zones around pump discharge and hose movement.', 'Control concrete delivery and placement sequence.', 'Provide washing facilities and eye protection.', 'Maintain edge protection and safe work platforms.'],
    fieldChecks: ['Inspect exposed rebar.', 'Check pump and hose arrangements.', 'Verify formwork condition.', 'Check concrete PPE and washing facilities.', 'Inspect access and edge protection.'],
    emergency: ['Stop pumping after uncontrolled hose movement or structural distress.', 'Control the area and isolate equipment where safe.', 'Provide first aid for cement exposure and seek medical care for serious injury.'],
  ),
  'dubai_cop_machinery_guarding': _DubaiTopicContent(
    purpose: 'Prevents contact with dangerous moving machinery parts through guarding, isolation, inspection, safe operation and maintenance controls.',
    hazards: ['Entanglement', 'Crushing and shearing', 'Cutting injuries', 'Unexpected start-up', 'Defeated guards or interlocks'],
    requirements: ['Guard dangerous moving parts where exposure exists.', 'Maintain emergency stops and safety devices.', 'Isolate machinery before maintenance or clearing jams.', 'Use competent operators and maintain equipment.', 'Prevent bypassing or defeating guards and interlocks.'],
    controls: ['Use fixed or interlocked guards as appropriate.', 'Apply lockout/tagout for maintenance.', 'Inspect guards and safety devices regularly.', 'Keep operators away from danger zones.', 'Control access to machinery during maintenance.'],
    fieldChecks: ['Inspect guards.', 'Test emergency stops as appropriate.', 'Check isolation arrangements.', 'Verify operator competence.', 'Look for bypassed safety devices.'],
    emergency: ['Stop and isolate machinery.', 'Do not reach into a machine until hazardous energy is controlled.', 'Raise the alarm and provide first aid/medical response.', 'Quarantine defective equipment until repaired and released.'],
  ),
  'dubai_cop_ladders_mobile_towers': _DubaiTopicContent(
    purpose: 'Controls ladders and mobile access towers through correct selection, setup, securing, inspection, access and stability.',
    hazards: ['Falls from ladders', 'Tower overturning', 'Improper setup', 'Moving an occupied tower', 'Using damaged equipment'],
    requirements: ['Select access equipment suitable for the task and duration.', 'Inspect before use and after conditions that may affect safety.', 'Set ladders on stable surfaces and secure them as required.', 'Erect mobile towers correctly and lock wheels before use.', 'Prevent unsafe movement or unauthorised alteration.'],
    controls: ['Maintain three-point contact on ladders where practicable.', 'Keep ladders at a suitable angle and secure them.', 'Use tower guardrails, platforms and access systems correctly.', 'Do not move mobile towers while occupied.', 'Use inspection/status systems.'],
    fieldChecks: ['Inspect ladder condition.', 'Check setup and securing.', 'Inspect tower wheels, braces and platforms.', 'Verify guardrails and access.', 'Confirm safe use instructions are understood.'],
    emergency: ['Stop use of damaged or unstable access equipment.', 'Prevent access until corrected and inspected.', 'Provide first aid and medical response after a fall.'],
  ),
  'dubai_cop_fire_emergency': _DubaiTopicContent(
    purpose: 'Controls construction fire risk and ensures suitable alarm, escape, firefighting and emergency access arrangements are maintained.',
    hazards: ['Ignition sources', 'Combustible storage', 'Hot work', 'Blocked escape routes', 'Unavailable extinguishers or alarms'],
    requirements: ['Identify construction fire hazards and control ignition sources.', 'Maintain suitable escape routes and emergency access.', 'Provide appropriate firefighting equipment.', 'Control hot work and combustible storage.', 'Maintain emergency arrangements and conduct drills as appropriate.'],
    controls: ['Segregate ignition sources from combustibles.', 'Keep escape routes clear.', 'Inspect extinguishers and fire points.', 'Control temporary electrical systems and hot work.', 'Maintain site fire plans and emergency contacts.'],
    fieldChecks: ['Inspect fire points.', 'Check escape routes.', 'Look for combustible accumulation.', 'Verify hot-work controls.', 'Check emergency access.'],
    emergency: ['Raise the alarm immediately.', 'Evacuate through safe routes.', 'Call emergency services/site response.', 'Use extinguishers only when trained and the fire is suitable for first-aid firefighting.', 'Do not re-enter until authorised.'],
  ),
  'dubai_cop_signs_barricading': _DubaiTopicContent(
    purpose: 'Uses clear signs, barriers and exclusion zones to communicate hazards and physically prevent people from entering dangerous areas.',
    hazards: ['People entering work zones', 'Poorly communicated hazards', 'Missing or damaged barriers', 'Confusing temporary routes', 'Inadequate visibility at night'],
    requirements: ['Provide suitable signs for hazards, instructions and restricted areas.', 'Use physical barricades where a sign alone is insufficient.', 'Maintain exclusion zones around high-risk activities.', 'Keep signs visible, understandable and in suitable locations.', 'Inspect and maintain barriers as work progresses.'],
    controls: ['Use consistent site signage.', 'Use rigid barriers for significant hazards where appropriate.', 'Provide reflective or illuminated warning where visibility requires it.', 'Keep access points controlled.', 'Remove obsolete signs and barriers to prevent confusion.'],
    fieldChecks: ['Check signs are visible.', 'Inspect barrier condition.', 'Verify exclusion-zone size and integrity.', 'Check night visibility.', 'Remove outdated signage.'],
    emergency: ['Stop the affected work when the exclusion zone is breached.', 'Restore the barrier and control access.', 'Reassess whether additional physical protection is required.'],
  ),
  'dubai_cop_lighting_weather': _DubaiTopicContent(
    purpose: 'Controls construction work affected by darkness, poor visibility and adverse weather by maintaining suitable lighting and adjusting work controls.',
    hazards: ['Poor visibility', 'Slips during rain', 'Wind affecting lifting or temporary works', 'Heat exposure', 'Unsecured materials during weather events'],
    requirements: ['Provide adequate lighting for work, access and emergency routes.', 'Monitor weather conditions relevant to the task.', 'Secure plant, materials and temporary structures against weather effects.', 'Stop or modify work when conditions exceed safe limits.', 'Maintain emergency lighting and visibility arrangements where required.'],
    controls: ['Use suitable task and access lighting without excessive glare.', 'Inspect lighting after relocation or damage.', 'Secure loose materials and temporary items before adverse weather.', 'Adjust lifting, height and outdoor work for wind and visibility.', 'Maintain drainage and slip controls during rain.'],
    fieldChecks: ['Check lighting at the actual work front.', 'Inspect emergency routes.', 'Review weather conditions.', 'Check material and plant securing.', 'Confirm stop-work criteria are understood.'],
    emergency: ['Suspend affected work when weather or visibility becomes unsafe.', 'Secure materials and plant where safe.', 'Keep people away from unstable temporary works.', 'Restart only after conditions and controls are acceptable.'],
  ),
};

_DubaiTopicContent _contentFor(String id) => _topicContent[id] ?? const _DubaiTopicContent(
  purpose: 'Apply the approved Dubai HSE controls to the specific work activity and verify their implementation at the work front.',
  hazards: ['Task-specific hazards shall be identified before work starts.'],
  requirements: ['Use the approved risk assessment, RAMS, permits and competent supervision.'],
  controls: ['Implement the hierarchy of controls and maintain effective field controls.'],
  fieldChecks: ['Verify controls are physically present and effective.'],
  emergency: ['Stop unsafe work, protect people and activate the applicable emergency arrangements.'],
);

class DubaiHseDedicatedPage extends StatelessWidget {
  final ReferenceTopic topic;
  final _DubaiTopicContent content;

  const DubaiHseDedicatedPage({
    super.key,
    required this.topic,
    required this.content,
  });

  static const Color darkGreen = Color(0xFF0B5D3B);
  static const Color primaryGreen = Color(0xFF159447);
  static const Color pageBackground = Color(0xFFF5F7FA);
  static const Color textSecondary = Color(0xFF374151);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(topic.shortTitle.isNotEmpty ? topic.shortTitle : topic.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _hero(),
              const SizedBox(height: 14),
              _detailSection('Purpose & Scope', Icons.info_outline, content.purpose),
              const SizedBox(height: 14),
              _bulletSection('Main Hazards', Icons.warning_amber_rounded, content.hazards),
              const SizedBox(height: 14),
              _bulletSection('Detailed Requirements', Icons.rule_folder_outlined, content.requirements),
              const SizedBox(height: 14),
              _bulletSection('Safety Controls', Icons.health_and_safety_outlined, content.controls),
              const SizedBox(height: 14),
              _bulletSection('Site / Field Verification', Icons.fact_check_outlined, content.fieldChecks),
              const SizedBox(height: 14),
              _bulletSection('Emergency & Stop-Work', Icons.emergency_outlined, content.emergency),
            ],
          ),
        ),
      ),
    );
  }

  Widget _hero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [darkGreen, Color(0xFF087F5B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'DUBAI HSE • DEDICATED TOPIC',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            topic.title,
            style: const TextStyle(color: Colors.white, fontSize: 24, height: 1.2, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            content.purpose,
            style: TextStyle(color: Colors.white.withValues(alpha: .94), fontSize: 15, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _detailSection(String title, IconData icon, String text) {
    return _sectionCard(
      title,
      icon,
      Text(text, style: const TextStyle(color: textSecondary, fontSize: 15, height: 1.6)),
    );
  }

  Widget _bulletSection(String title, IconData icon, List<String> items) {
    return _sectionCard(
      title,
      icon,
      Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primaryGreen.withValues(alpha: .10),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('${i + 1}', style: const TextStyle(color: primaryGreen, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Text(items[i], style: const TextStyle(color: textSecondary, fontSize: 15, height: 1.55)),
                  ),
                ],
              ),
            ),
            if (i != items.length - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }

  Widget _sectionCard(String title, IconData icon, Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 10, offset: Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryGreen, size: 23),
              const SizedBox(width: 9),
              Expanded(child: Text(title, style: const TextStyle(color: darkGreen, fontWeight: FontWeight.bold, fontSize: 18))),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

ReferenceTopic _dubaiTopic(String id) {
  for (final topic in dubaiGuidelines) {
    if (topic.id == id) return topic;
  }
  throw StateError('Dubai HSE topic not found: $id');
}

class DubaiConstructionSafetyDetailPage extends StatelessWidget { const DubaiConstructionSafetyDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_construction_safety'), content: _contentFor('dubai_construction_safety')); }
class DubaiHseManagementDetailPage extends StatelessWidget { const DubaiHseManagementDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_hse_management'), content: _contentFor('dubai_hse_management')); }
class DubaiRiskAssessmentDetailPage extends StatelessWidget { const DubaiRiskAssessmentDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_risk_assessment'), content: _contentFor('dubai_risk_assessment')); }
class DubaiHsePlanDetailPage extends StatelessWidget { const DubaiHsePlanDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_hse_plan'), content: _contentFor('dubai_hse_plan')); }
class DubaiWorkAtHeightDetailPage extends StatelessWidget { const DubaiWorkAtHeightDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_work_at_height'), content: _contentFor('dubai_work_at_height')); }
class DubaiScaffoldingDetailPage extends StatelessWidget { const DubaiScaffoldingDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_scaffolding'), content: _contentFor('dubai_scaffolding')); }
class DubaiLiftingDetailPage extends StatelessWidget { const DubaiLiftingDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_lifting'), content: _contentFor('dubai_lifting')); }
class DubaiExcavationDetailPage extends StatelessWidget { const DubaiExcavationDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_excavation'), content: _contentFor('dubai_excavation')); }
class DubaiConfinedSpaceDetailPage extends StatelessWidget { const DubaiConfinedSpaceDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_confined_space'), content: _contentFor('dubai_confined_space')); }
class DubaiElectricalDetailPage extends StatelessWidget { const DubaiElectricalDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_electrical'), content: _contentFor('dubai_electrical')); }
class DubaiHotWorkDetailPage extends StatelessWidget { const DubaiHotWorkDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_hot_work'), content: _contentFor('dubai_hot_work')); }
class DubaiTrafficDetailPage extends StatelessWidget { const DubaiTrafficDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_traffic'), content: _contentFor('dubai_traffic')); }
class DubaiDemolitionDetailPage extends StatelessWidget { const DubaiDemolitionDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_demolition'), content: _contentFor('dubai_demolition')); }
class DubaiTemporaryWorksDetailPage extends StatelessWidget { const DubaiTemporaryWorksDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_temporary_works'), content: _contentFor('dubai_temporary_works')); }
class DubaiHeatStressDetailPage extends StatelessWidget { const DubaiHeatStressDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_heat_stress'), content: _contentFor('dubai_heat_stress')); }
class DubaiOccupationalHealthDetailPage extends StatelessWidget { const DubaiOccupationalHealthDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_occupational_health'), content: _contentFor('dubai_occupational_health')); }
class DubaiPpeDetailPage extends StatelessWidget { const DubaiPpeDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_ppe'), content: _contentFor('dubai_ppe')); }
class DubaiEmergencyDetailPage extends StatelessWidget { const DubaiEmergencyDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_emergency'), content: _contentFor('dubai_emergency')); }
class DubaiIncidentDetailPage extends StatelessWidget { const DubaiIncidentDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_incident'), content: _contentFor('dubai_incident')); }
class DubaiContractorDetailPage extends StatelessWidget { const DubaiContractorDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_contractor'), content: _contentFor('dubai_contractor')); }
class DubaiEnvironmentDetailPage extends StatelessWidget { const DubaiEnvironmentDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_environment'), content: _contentFor('dubai_environment')); }
class DubaiInspectionDetailPage extends StatelessWidget { const DubaiInspectionDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_inspection'), content: _contentFor('dubai_inspection')); }
class DubaiPerformanceDetailPage extends StatelessWidget { const DubaiPerformanceDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_performance'), content: _contentFor('dubai_performance')); }
class DubaiBuildingCodeDetailPage extends StatelessWidget { const DubaiBuildingCodeDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_building_code'), content: _contentFor('dubai_building_code')); }
class DubaiPermitToWorkDetailPage extends StatelessWidget { const DubaiPermitToWorkDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_permit_to_work'), content: _contentFor('dubai_permit_to_work')); }
class DubaiCopSiteEstablishmentDetailPage extends StatelessWidget { const DubaiCopSiteEstablishmentDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_cop_site_establishment'), content: _contentFor('dubai_cop_site_establishment')); }
class DubaiCopPublicProtectionDetailPage extends StatelessWidget { const DubaiCopPublicProtectionDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_cop_public_protection'), content: _contentFor('dubai_cop_public_protection')); }
class DubaiCopAccessHousekeepingDetailPage extends StatelessWidget { const DubaiCopAccessHousekeepingDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_cop_access_housekeeping'), content: _contentFor('dubai_cop_access_housekeeping')); }
class DubaiCopWelfareFacilitiesDetailPage extends StatelessWidget { const DubaiCopWelfareFacilitiesDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_cop_welfare_facilities'), content: _contentFor('dubai_cop_welfare_facilities')); }
class DubaiCopMaterialStorageDetailPage extends StatelessWidget { const DubaiCopMaterialStorageDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_cop_material_storage'), content: _contentFor('dubai_cop_material_storage')); }
class DubaiCopFormworkFalseworkDetailPage extends StatelessWidget { const DubaiCopFormworkFalseworkDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_cop_formwork_falsework'), content: _contentFor('dubai_cop_formwork_falsework')); }
class DubaiCopRebarConcreteDetailPage extends StatelessWidget { const DubaiCopRebarConcreteDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_cop_rebar_concrete'), content: _contentFor('dubai_cop_rebar_concrete')); }
class DubaiCopMachineryGuardingDetailPage extends StatelessWidget { const DubaiCopMachineryGuardingDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_cop_machinery_guarding'), content: _contentFor('dubai_cop_machinery_guarding')); }
class DubaiCopLaddersMobileTowersDetailPage extends StatelessWidget { const DubaiCopLaddersMobileTowersDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_cop_ladders_mobile_towers'), content: _contentFor('dubai_cop_ladders_mobile_towers')); }
class DubaiCopFireEmergencyDetailPage extends StatelessWidget { const DubaiCopFireEmergencyDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_cop_fire_emergency'), content: _contentFor('dubai_cop_fire_emergency')); }
class DubaiCopSignsBarricadingDetailPage extends StatelessWidget { const DubaiCopSignsBarricadingDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_cop_signs_barricading'), content: _contentFor('dubai_cop_signs_barricading')); }
class DubaiCopLightingWeatherDetailPage extends StatelessWidget { const DubaiCopLightingWeatherDetailPage({super.key}); @override Widget build(BuildContext context) => DubaiHseDedicatedPage(topic: _dubaiTopic('dubai_cop_lighting_weather'), content: _contentFor('dubai_cop_lighting_weather')); }
