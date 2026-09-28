// SafeNexus HSE — Emergency & Rescue Part 3 Advanced
// File: lib/data/emergency_rescue/emergency_rescue_part3.dart
//
// ADDITIVE EXTRA CONTENT ONLY.
// Does not modify Part 1, Part 2, Part 3, navigation, or shared model.
// Uses the existing EmergencyRescueTopic API from Part 1.
//
// Training reference: site-specific plans, rescue methods, electrical isolation,
// crane recovery, chemical response and re-entry must be assessed and approved
// by competent persons under the current site ERP, manufacturer instructions,
// SDS and applicable authority requirements. No universal limits or timings
// are asserted here.

import 'emergency_rescue_part1.dart';

const List<EmergencyRescueTopic> emergencyRescuePart3 =
    <EmergencyRescueTopic>[
  EmergencyRescueTopic(
    id: 'ER-09',
    title: 'Work at Height Rescue — Advanced Field Guide',
    purpose:
        'This advanced guide expands planning and response for a person who has fallen into a fall-arrest system, is stranded at height, or cannot descend safely. Rescue is a separate planned activity: fall protection may arrest a fall but does not guarantee recovery. The response must protect the casualty, rescuers and people below, and arrange prompt medical assessment.',
    scope:
        'Use for construction, maintenance, roof work, scaffolds, towers, structural steel, formwork, ladders, suspended access and MEWPs. Select the method for the actual geometry, casualty condition, anchor and equipment ratings, access, weather, nearby services and rescue-team competence.',
    keyKnowledge: <String>[
      'Planning sequence: identify credible fall/stranding scenarios; eliminate or reduce exposure; choose collective protection where practicable; select suitable restraint or fall-arrest equipment for residual risk; then design and brief a feasible rescue method before work starts.',
      'A rescue plan should answer: Who raises the alarm? Who commands the response? What exact location and access route? How will rescuers reach the casualty? What verified anchor and compatible system are available? How is the casualty transferred to a safe landing area? Who provides first aid and medical handover?',
      'Differentiate restraint, work positioning and fall arrest. Restraint aims to prevent reaching a fall edge; work positioning supports a worker in a controlled position; fall arrest stops a fall but can leave the person suspended and exposed to further injury.',
      'A suspended casualty may be conscious, confused, injured, entangled, unconscious or unable to assist. Do not assume a person can self-rescue. Maintain communication if possible and treat the event as urgent without relying on a universal suspension-time threshold.',
      'Rescue options can include assisted descent, controlled lowering or raising, recovery from an adjacent platform, MEWP ground lowering, or specialist rope/technical rescue. The chosen method must be practiced, compatible with the installed system and within the team’s competence.',
      'Anchor selection is a critical engineering/competent-person decision. Do not use handrails, scaffold members, pipework, temporary supports or unknown structural points unless their suitability for the rescue loading and direction has been verified.',
      'Consider edge transitions, sharp edges, pendulum/swing fall, obstruction, dropped objects, electrical lines, unstable platforms, rescue-line entanglement, casualty snagging and the possibility of a rescuer falling or becoming suspended.',
      'For scaffold rescue, assess scaffold stability, access ladders, incomplete lifts, ties, loading and whether rescue forces or movement could destabilize the structure. Do not overload the scaffold or remove components to improvise access.',
      'For roof rescue, identify fragile roof lights, brittle sheets, unprotected edges, skylights, weather, access hatches and a safe casualty transfer route. Keep rescuers on verified safe access/protection systems.',
      'For MEWP events, identify the exact machine model, ground-control location, emergency-lowering method, ground operator and rescue access. Use the manufacturer procedure and trained personnel; do not assume controls or emergency functions are identical across machines.',
      'Rescue equipment should be selected as a system: harness/interface, connectors, rope or device, edge protection, anchor, lowering/raising capability, communications and casualty packaging where needed. Inspect and store it under manufacturer and site requirements.',
      'After recovery, trained first aiders assess the casualty and arrange medical evaluation appropriate to the event. Consider fall impact, suspension, loss of consciousness, breathing difficulty, pain, burns or possible spinal injury; avoid unnecessary movement unless the location is unsafe.',
      'Remove fall-arrest equipment involved in a fall from service, identify and quarantine it, and follow manufacturer/competent-person disposition requirements. Do not return it to service merely because it looks undamaged.',
      'A rescue drill should test the actual route, communications, team availability, equipment access, casualty transfer and handover. Record learning and correct gaps before relying on the plan.',
      'Regulatory note: verify current UAE/Abu Dhabi requirements and project specifications from official sources. International rescue guidance is supplementary unless formally adopted by the applicable authority or project.'
    ],
    siteImplementation: <String>[
      'Before the shift, supervisor and competent person review the work-at-height risk assessment, permit where required, weather, simultaneous operations and rescue arrangements for the specific work front.',
      'Record casualty scenarios, primary and backup rescue method, designated rescue lead, trained rescuers, first aider, alarm phrase/channel, site access gate and responder meeting point.',
      'Walk the route from the work position to the casualty and from the casualty to the landing/medical handover area. Confirm barriers, lighting, headroom, obstructions and emergency access.',
      'Verify anchor suitability, equipment compatibility, inspection status, manufacturer instructions and availability. Check that rescue equipment is not locked away or stored beyond practical reach.',
      'Brief all involved workers on stop-work triggers, alarm activation, exclusion zone, no-improvised-rescue rule and who may operate MEWP ground controls or rescue devices.',
      'On an event, raise alarm, stop nearby work, secure the drop zone and prevent additional exposure. Give exact location, access route, casualty status if known and hazards such as electricity or unstable structure.',
      'The rescue lead assesses conditions from a safe position and selects the pre-planned method. If the situation differs materially from the plan, stop and obtain competent specialist direction rather than improvising.',
      'Maintain voice/radio contact with the casualty where possible. Do not promise a recovery time or ask an injured person to perform actions beyond their ability.',
      'Perform controlled recovery with continuous coordination, avoiding shock loading, uncontrolled swinging, collision and secondary fall. Keep nonessential people outside the rescue area.',
      'Transfer casualty to trained first aid/medical responders; provide event mechanism, fall/suspension details, observed symptoms and any known impact or loss of consciousness.',
      'Secure the scene, quarantine involved equipment, record chronology and witnesses, notify required site/client channels and review the risk assessment and rescue plan before restart.'
    ],
    practicalExample: <String>[
      'Scenario A — suspended worker at roof edge: A worker slips and is held by a fall-arrest system. The coworker activates the alarm and identifies the roof access gate. The rescue lead isolates the area below, checks the approved anchor and rescue kit, and deploys the briefed assisted-lowering method with trained rescuers. The worker is transferred to first aid and medical assessment; the harness and lanyard are quarantined.',
      'Scenario B — MEWP unable to lower: A platform stops elevated with a worker aboard. The ground operator prevents others from entering the operating zone, follows the machine-specific emergency-lowering procedure and maintains communication. If the procedure fails or the machine is unstable, the team calls the designated specialist/emergency support rather than climbing or forcing controls.',
      'Scenario C — casualty unconscious: The rescue plan must account for a non-cooperative casualty, airway/medical needs, packaging or controlled transfer, and adequate rescuers. A competent rescue lead coordinates technical recovery and medical responders; coworkers do not attempt an unplanned lift.',
      'SITE PLAN — WORK AT HEIGHT RESCUE PLAN: Project/workfront: ______; revision/date: ______; work location and height: ______; credible fall/stranding scenarios: ______; rescue lead/deputy: ______; trained rescuers: ______; primary method: ______; contingency method: ______; verified anchor/equipment IDs: ______; access route: ______; casualty landing/transfer point: ______; alarm/channel: ______; first aider/medical contact: ______; external responder gate/meeting point: ______; drill/briefing record: ______; competent approval: ______.',
      'PRE-TASK CHECKLIST: rescue method feasible; competent team present; anchor verified; compatible rescue equipment inspected; access route clear; casualty landing area protected; communications tested; MEWP ground controls and trained operator identified where relevant; exclusion zone arranged; weather/site conditions acceptable; medical handover arrangements known.'
    ],
    stopWorkConditions: <String>[
      'No practical rescue method, competent rescuers, suitable equipment or reliable communication for the planned work.',
      'Anchor or supporting structure not verified, equipment damaged/incompatible, or inspection status uncertain.',
      'Rescue access crosses an uncontrolled fall edge, fragile roof, energized hazard, unstable scaffold or other unassessed danger.',
      'Weather or changing site conditions invalidate the approved method, or emergency access/landing area is obstructed.',
      'An improvised rescue would expose another person to an uncontrolled fall; isolate and request competent specialist response.'
    ],
    interviewQuestions: <String>[
      'Q: Why is fall arrest not a complete rescue plan? A: It may stop a fall but can leave a person suspended or injured; a separate feasible recovery and medical handover arrangement is needed.',
      'Q: What should be confirmed before work starts? A: Scenario, rescue lead/team, alarm, verified anchor and compatible equipment, access, landing area, communications and medical support.',
      'Q: Can a worker use any nearby steel member as a rescue anchor? A: No. Anchor suitability and loading direction must be verified by a competent person.',
      'Q: What is the response to an unconscious suspended casualty? A: Raise alarm, protect rescuers, use the planned competent rescue method promptly, coordinate medical responders and avoid unplanned handling.',
      'Q: What happens to equipment after a fall? A: Quarantine it and follow manufacturer/competent-person inspection and disposal requirements.',
      'Q: How do you improve a rescue plan? A: Conduct realistic drills, record delays and failures, assign corrective actions and revalidate after worksite changes.'
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-10',
    title: 'Crane & Lifting Emergency — Advanced Field Guide',
    purpose:
        'This guide expands response to abnormal lifting events that may cause a dropped or swinging load, crane instability, equipment damage, entrapment or electrical contact. The response is life-safety led: stop or avoid worsening movement where safe, isolate the hazard envelope, activate the emergency organization and obtain competent lifting/engineering support. Recovery of damaged or unstable equipment is not an improvised field task.',
    scope:
        'Mobile, crawler, tower, overhead and other cranes; hoists, lifting accessories, suspended loads, rigging, lifting near structures or services, and emergency conditions including power failure, control fault, ground movement, overload indication, snagging, rigging failure, operator incapacitation and overturning.',
    keyKnowledge: <String>[
      'Pre-lift emergency planning should identify credible failure modes, load path, exclusion zone, communication method, emergency stop/shutdown procedure, emergency access and persons authorized to direct the response.',
      'Potential precursors include outrigger settlement, ground cracking, unexpected tilt, abnormal noise, hydraulic leakage, rope or reeving irregularity, unexpected load movement, loss of signal, wind changes and load snagging. Treat unexplained changes as a stop-and-assess trigger.',
      'A suspended load can fall, swing, rotate or move when a component fails or stored energy is released. Establish the exclusion zone using the actual load path and credible crane/boom collapse or swing envelope; keep people clear.',
      'Do not stand under a suspended load, try to catch it, push it by hand during an abnormal event, or enter beneath a boom to retrieve equipment. Protect life before asset recovery.',
      'Operator actions must follow the exact crane manufacturer instructions, approved lift plan and training. Do not force controls, bypass limiters/interlocks or transfer operation to an unqualified person.',
      'Ground bearing and setup are integral to crane stability. Settlement or outrigger movement may indicate loss of support; do not add packing, reposition outriggers or alter configuration without competent technical direction.',
      'If rigging fails or load is snagged, do not release, cut or manipulate rigging unless an approved engineered method directs it. Stored energy and sudden load movement can cause fatal injury.',
      'For operator incapacitation, use only the crane-specific emergency procedure and trained/authorized personnel. Do not climb onto the crane or attempt control transfer by guesswork.',
      'For suspected overhead power-line contact, treat crane, load and surrounding ground as energized. Keep clear, warn others, and coordinate with the responsible electrical/network authority. Follow site and utility instructions for safe separation and approach.',
      'For overturning, structural damage or a trapped casualty, establish a wider exclusion area, call emergency services and competent crane/engineering specialists, and coordinate stabilization before extraction unless emergency responders direct otherwise.',
      'Emergency recovery should be engineered for the actual crane configuration, load, ground, damage, weather and access. Manufacturer technical support may be required. Never assume a generic recovery sequence is safe for every crane.',
      'After the event, preserve records: lift plan, crane configuration, load data, rigging certificates/IDs, inspection/maintenance, ground assessment, weather, operator and signaler statements, alarms and control indications.',
      'Quarantine crane and accessories. Reuse requires competent inspection, repair, verification and formal release under the site system; close corrective actions and revise the lift plan/briefing.'
    ],
    siteImplementation: <String>[
      'Before lifting, confirm lift supervisor, operator, appointed lifting personnel, signaler, emergency controller and backup communication arrangements for the shift.',
      'Review the lift plan, load weight/center of gravity, radius/configuration, ground support, exclusion zone, overhead services, weather limits and emergency access with the crew.',
      'Identify crane-specific emergency stop, shutdown and manufacturer emergency instructions. Confirm the operator knows the limits of their authority during an abnormal event.',
      'On abnormal movement, instability, snagging, defect, loss of communication or warning indication, stop the lift and alert the lift supervisor using the agreed signal.',
      'The supervisor stops nearby operations, isolates the credible fall/swing/collapse area and prevents entry. Keep emergency routes clear and account for personnel.',
      'Operator follows the approved safe-stop procedure only if it does not increase danger. Do not make additional movements merely to “test” the crane.',
      'Notify the incident controller and call competent lifting/engineering support or emergency services as indicated by injury, instability, contact with services or damage.',
      'For electrical contact, do not approach the crane or casualty until the electrical authority confirms safe conditions. Prevent others from touching the machine or nearby conductive objects.',
      'If casualty rescue is needed, coordinate with emergency responders and technical specialists; do not destabilize the crane or load by unplanned access or movement.',
      'Record the event, preserve relevant data and quarantine equipment. Reassess ground, crane, rigging, method statement, competence and interfaces before written release.'
    ],
    practicalExample: <String>[
      'Scenario A — outrigger settlement: During a lift, an outrigger pad begins to settle and the boom/load position changes unexpectedly. The operator stops movement using the approved procedure and informs the lift supervisor. The area is evacuated and isolated. No worker approaches to add packing. A competent lifting/engineering team assesses stability and develops a controlled recovery plan.',
      'Scenario B — suspended load snag: A load catches on a structure. The signaler calls stop; the crew keeps clear and does not pull tag lines or release rigging to free it. The lift supervisor reassesses the load path and obtains competent direction before any controlled movement.',
      'Scenario C — suspected power-line contact: The operator and crew treat the crane as energized, warn people away and contact the responsible utility/electrical authority. No one approaches to assist until safe conditions and any required clearance are confirmed.',
      'SITE PLAN — CRANE & LIFTING EMERGENCY PLAN: Project/lift ID: ______; crane make/model/configuration: ______; load and lift location: ______; lift supervisor: ______; operator/signalers: ______; emergency controller: ______; stop/alarm signal: ______; exclusion/collapse zone drawing: ______; emergency gate/access: ______; power-line contact procedure/contact: ______; competent lifting/engineering support: ______; emergency services contact: ______; equipment quarantine point: ______; approval/revision: ______.',
      'PRE-LIFT EMERGENCY CHECKLIST: approved lift plan available; roles and signals briefed; ground/setup verified; rigging checked; exclusion zone controlled; overhead/underground services assessed; emergency stop procedure known; emergency access clear; weather within approved plan; no unresolved defects; recovery/escalation contacts available.'
    ],
    stopWorkConditions: <String>[
      'Unexpected settlement, tilt, abnormal noise, leakage, damaged rope/rigging, overload warning, snagging or unexplained load movement.',
      'People within the load fall/swing/collapse envelope or exclusion zone cannot be controlled.',
      'Suspected power-line contact, damaged electrical equipment or uncertainty about energized conditions.',
      'No approved lift plan, competent lifting lead, reliable communication or safe emergency access.',
      'Proposed recovery requires bypassing safety devices, unapproved crane movement, improvised rigging or unverified ground support.'
    ],
    interviewQuestions: <String>[
      'Q: What are the priorities in a lifting emergency? A: Protect people, stop worsening movement where safe, isolate the danger zone, raise alarm and obtain competent technical/emergency support.',
      'Q: Why must nobody stand under or manually catch a suspended load? A: Load movement or component failure can be sudden and unpredictable; people must remain outside the hazard envelope.',
      'Q: What does outrigger settlement indicate? A: Possible loss of ground support/stability; stop and isolate, then obtain competent assessment rather than improvising packing or repositioning.',
      'Q: Who plans recovery of a damaged crane? A: Competent lifting/engineering specialists using manufacturer information and an approved method, coordinated with emergency responders.',
      'Q: What if the crane contacts an overhead line? A: Treat it as energized, keep clear, warn others and coordinate with the responsible utility/electrical authority before approach.',
      'Q: What is required before return to service? A: Quarantine, competent inspection/repair, verification, formal release and review of the lift plan and corrective actions.'
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-11',
    title: 'Electrical Shock Rescue — Advanced Field Guide',
    purpose:
        'Electrical rescue addresses shock, burns, arc flash, electrical fire and secondary injury. The rescuer must not become a second casualty. Alarm, isolation by authorized personnel, verification of safe conditions, trained first aid and medical escalation form the response sequence. Electrical hazards may remain after a visible switch is opened because of alternate supplies, stored energy or automatic re-energization.',
    scope:
        'Temporary/permanent installations, portable tools, distribution boards, generators, batteries, UPS, capacitors, overhead/underground services, low- and high-voltage equipment and electrical incidents in wet or confined locations.',
    keyKnowledge: <String>[
      'Electrical injury mechanisms include current through the body, arc-flash heat/pressure, burns, involuntary muscle contraction, fall from height, blast impact and secondary fire. External appearance does not reliably show internal injury severity.',
      'At discovery, raise the alarm, keep people back and identify the source only from a safe location. Never touch the casualty, cable, tool, water or conductive object while energization is possible.',
      'Only an authorized person should operate designated isolation equipment where safe. Follow the site electrical isolation and LOTO process, including identification of all energy sources and control of re-energization.',
      'Verification of safe isolation must be performed by competent authorized personnel using the approved test method and suitable instrument. A breaker handle position, indicator lamp or verbal assumption alone is not proof of absence of voltage.',
      'Consider alternate feeds, generators, UPS, solar/PV sources, batteries, capacitors, induced voltage, shared circuits, automatic transfer and stored mechanical energy. Discharge/earthing steps depend on equipment and procedure.',
      'High-voltage and overhead-line incidents require the network/electrical authority and specialist responders. Maintain required approach boundaries and do not use improvised poles, ropes, vehicles or rescue tools.',
      'Arc flash may injure a person without direct contact. Do not enter a suspected arc-flash exposure zone or open damaged switchgear until competent electrical personnel establish safe conditions.',
      'Once the scene is confirmed electrically safe, trained first aiders assess responsiveness and breathing, call emergency medical services and provide CPR/AED within their training and AED prompts when indicated.',
      'For burns, avoid creams and do not remove material stuck to the skin. Protect the casualty, monitor condition and obtain urgent medical assessment according to the exposure and site first-aid protocol.',
      'If a fall or blast occurred, consider head, neck, spinal and internal injuries. Avoid unnecessary movement unless the scene is unsafe or trained responders direct action.',
      'Communicate known source, suspected voltage category if confirmed, exposure mechanism, isolation/verification status, burns, collapse, fall and first-aid actions to medical responders.',
      'Keep affected equipment isolated and tagged against use. Preserve protective devices, tools, permits, isolation records and witness information for investigation.',
      'Re-energization requires competent inspection, defect correction, verification, authorization and communication to affected workers. Never reset repeatedly to see whether a trip clears.'
    ],
    siteImplementation: <String>[
      'Maintain an electrical emergency contact list, authorized-person roster, isolation drawings/labels, LOTO equipment, first-aid/AED arrangements and emergency access information.',
      'At an incident, shout/raise alarm, stop nearby work and establish a safe perimeter. Tell bystanders not to touch the casualty or equipment.',
      'Call the authorized electrical person or responsible network operator. Provide exact location, visible hazards, possible supply sources and any fire/smoke or water involvement.',
      'Isolate through the approved procedure. The authorized person identifies all sources, applies required locks/tags and verifies safe conditions before allowing access.',
      'Only after safe access is confirmed, trained first aiders approach, assess the casualty, call ambulance/emergency medical services and provide care within their competence.',
      'Use CPR/AED when indicated by assessment and training; follow AED voice prompts. Do not delay emergency call or attempt technical electrical work while providing first aid.',
      'Keep casualty monitored and protected from further harm. Report any fall, burn, loss of consciousness, chest symptoms or breathing difficulty to responders.',
      'Secure the equipment and work area; record circuit/asset ID, isolation points, permits, test records, witness accounts and actions taken.',
      'Investigate root causes such as damaged insulation, unsuitable tool, water ingress, unauthorized modification, missing protection, poor isolation or procedural failure.',
      'Return to service only after competent inspection, repair, verification and documented authorization; brief workers on revised controls.'
    ],
    practicalExample: <String>[
      'Scenario A — damaged portable lead: A worker collapses near a cut cable. A coworker raises the alarm and prevents others from approaching. The authorized electrician isolates the supply, checks for alternate sources and verifies safe conditions. Trained first aiders then assess breathing, call medical services and provide CPR/AED if indicated. The lead and tool are quarantined.',
      'Scenario B — panel arc event: Smoke and a flash occur at a distribution board. Workers evacuate the immediate area and report the panel location. No one opens the enclosure or attempts a reset. The electrical authority isolates and assesses the installation; fire response and medical care are coordinated as required.',
      'Scenario C — suspected HV contact: A person is down near an overhead line. The area is cordoned off and utility/emergency services are contacted. No one approaches until the responsible authority confirms the line and surrounding conditions are safe.',
      'SITE PLAN — ELECTRICAL SHOCK & ISOLATION PLAN: Site/asset: ______; emergency controller: ______; authorized electrical contact: ______; supply/source diagram reference: ______; isolation/LOTO procedure: ______; verification authority/method: ______; approach boundary reference: ______; ambulance access: ______; first aider/AED location: ______; emergency call channel: ______; quarantine location: ______; re-energization approver: ______; revision/approval: ______.',
      'PRE-WORK CHECKLIST: correct equipment and rating; visual inspection complete; protective devices and earthing arrangements checked as required; work authorization/permit available where applicable; isolation points identified; LOTO and test equipment available to authorized persons; wet conditions assessed; emergency contacts and first-aid arrangements known.'
    ],
    stopWorkConditions: <String>[
      'Exposed conductor, damaged cable, unexplained trip, smoke, arcing, burning smell or suspected energized water/metalwork.',
      'Source or alternate supply is unknown, isolation cannot be verified, or unauthorized persons propose switching/repair.',
      'Suspected high-voltage contact or arc-flash hazard without competent electrical/utility control.',
      'Casualty access requires touching an energized object or entering an uncontrolled electrical area.',
      'Equipment is being reset or returned to service without competent inspection and authorization.'
    ],
    interviewQuestions: <String>[
      'Q: What is the first rule in electrical shock rescue? A: Do not touch the casualty until the electrical hazard is isolated and safe access is confirmed.',
      'Q: Why is a switch-off indication not enough? A: Alternate feeds, stored energy and faulty isolation may remain; an authorized competent person must verify safe conditions.',
      'Q: When can CPR/AED be started? A: After the scene is electrically safe and trained responders can safely access the casualty; follow training and AED prompts.',
      'Q: Why is medical evaluation needed after shock? A: Cardiac, burn and internal injuries may be serious even when external signs are limited.',
      'Q: What is LOTO for? A: To control hazardous energy and prevent unexpected re-energization during work, using the approved site process.',
      'Q: Who authorizes re-energization? A: The competent authorized electrical authority after inspection, corrective action, verification and formal release.'
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-12',
    title: 'Chemical Spill Response — Advanced Field Guide',
    purpose:
        'Chemical spill response is a structured process to protect people, environment and property from an uncontrolled release. The discoverer should warn, withdraw and report; trained responders assess and control only within their defined capability. Unknown, escalating, toxic, reactive, flammable or otherwise high-consequence releases require isolation, evacuation and specialist response rather than an improvised cleanup.',
    scope:
        'Chemical stores, receiving and dispensing, fuel and lubricant areas, laboratories, workshops, process plants, cleaning operations, transport interfaces and waste handling. Consider liquids, gases, vapors, powders, corrosives, oxidizers, flammables, toxics and environmentally harmful substances.',
    keyKnowledge: <String>[
      'Classify the event using site criteria and responder capability. An incidental release may be controlled by trained personnel using routine spill procedures; an emergency release may require evacuation, specialist hazardous-material response, respiratory protection, monitoring and incident command. Quantity alone does not determine the category.',
      'Identify the product through label, inventory and SDS only from a safe position. Record product name, container, approximate release, location and visible effects if known; do not approach an unknown cloud to identify it.',
      'SDS information to consult includes hazards, first aid, firefighting, accidental release, handling/storage, exposure controls/PPE, stability/reactivity and disposal. Ensure the SDS matches the actual product and concentration.',
      'Immediate response: raise alarm, stop nearby work, isolate access, move people to a safer location and call the site emergency controller. Do not touch, smell, walk through or attempt to neutralize an unknown substance.',
      'Wind and terrain affect vapor movement. Follow the site ERP and responder direction; where applicable, avoid moving into a plume and use a safe crosswind/upwind route. Do not prescribe one direction for every release or building layout.',
      'Control ignition sources only when this can be done without entering the hazard area. Do not operate switches or equipment in a potentially flammable atmosphere unless the approved emergency procedure directs a safe action.',
      'PPE must be selected from hazard assessment, SDS and responder training. Chemical compatibility, splash, vapor, respiratory and breakthrough considerations matter; ordinary gloves or a dust mask are not universal protection.',
      'Do not mix absorbents, neutralizers or cleanup chemicals unless compatibility and procedure are confirmed. Some combinations generate heat, toxic gas, fire or violent reaction.',
      'Protect drains, soil and water only when safe and within responder capability. Use compatible barriers/booms and avoid washing material into drainage. Notify environmental/site contacts when release may migrate beyond containment.',
      'Where exposure occurs, use designated eyewash/safety shower and SDS/site first-aid instructions promptly; remove contaminated clothing only as trained and safe. Seek medical advice and provide product/SDS information.',
      'Large or uncertain incidents may require hot/warm/cold zones, entry control, responder accountability, decontamination corridor and atmospheric monitoring. These are established by competent incident command, not improvised by untrained workers.',
      'Recovered chemical and contaminated absorbents/PPE remain potentially hazardous. Use compatible, closed, labeled containers and approved waste classification, storage, transport and disposal arrangements.',
      'Re-entry requires confirmation that the source is controlled, cleanup and decontamination are complete, atmosphere/area is assessed where needed, waste is managed and the authorized incident lead releases the area.',
      'Record product, estimated amount if reliably known, release cause, affected drains/soil, exposures, notifications, waste route and corrective actions. Review storage compatibility, secondary containment, transfer method, maintenance and training.'
    ],
    siteImplementation: <String>[
      'Before work, maintain a current chemical register, matching SDS access, compatibility/storage information, spill kit inventory, drain map, emergency contacts and trained response roster.',
      'Brief workers on alarm method, safe withdrawal routes, assembly point, exposure washing facilities, reporting information and the rule against unauthorized cleanup.',
      'On discovery, warn nearby people, raise alarm and withdraw. Report exact location, product only if known safely, visible release behavior, injuries and immediate ignition/drain concerns.',
      'Incident controller establishes perimeter, evacuation/shelter decision, responder capability and need for specialist emergency services. Keep unassigned people out.',
      'Trained responders review SDS and compatibility, select PPE and response method, establish communication and escape route, and confirm backup/support before entry.',
      'Control source only when safe and within competence. Do not close valves, upright containers or plug leaks if doing so exposes responders or could worsen the release.',
      'Contain migration with compatible materials only when safe. Protect drains/waterways under the approved plan and avoid incompatible absorbents or uncontrolled flushing.',
      'For skin/eye exposure, direct the person to designated emergency washing facilities and obtain medical support according to SDS/site procedure. Do not delay urgent care for paperwork.',
      'Manage contaminated tools, clothing and absorbents as potentially hazardous. Label and segregate them, prevent incompatible storage and arrange approved waste handling.',
      'Incident controller confirms source control, cleanup, any required monitoring, waste removal and area release. Communicate re-entry conditions before restarting work.',
      'Report and investigate the event, notify required site/environmental channels, review controls and verify corrective action closure.'
    ],
    practicalExample: <String>[
      'Scenario A — unidentified liquid in store: A worker sees liquid spreading from a drum and notices irritation nearby. The worker raises alarm, withdraws and warns others without touching the material. The incident controller isolates the store and obtains product information from inventory/SDS remotely. Because identity and exposure are uncertain, specialist responders assess and manage the release.',
      'Scenario B — small known product spill: A trained storekeeper identifies a minor release of a known product and checks the approved site incidental-spill criteria and SDS. If within capability, the designated responder uses compatible PPE and spill materials, protects drains safely, packages waste and reports completion. If any condition exceeds the plan, the person withdraws and escalates.',
      'Scenario C — chemical splash to eye: A coworker guides the exposed person to the designated eyewash immediately and summons first aid/medical assistance according to the product SDS and site procedure. The product identity is provided to medical responders; cleanup of the spill is handled separately by trained responders.',
      'SITE PLAN — CHEMICAL SPILL EMERGENCY & CONTAINMENT PLAN: Site/area: ______; chemical inventory/SDS location: ______; incident controller: ______; trained spill team: ______; alarm/channel: ______; primary/alternative safe location: ______; isolation boundary: ______; drain/water receptor map: ______; spill kit type/location: ______; PPE/respiratory capability: ______; specialist response contact: ______; eyewash/shower location: ______; medical access: ______; waste container/holding route: ______; monitoring/re-entry authority: ______; revision/approval: ______.',
      'PRE-USE CHECKLIST: product labeled and SDS accessible; incompatible materials segregated; container and secondary containment sound; transfer equipment inspected; spill kit compatible and stocked; drains/receptors known; emergency route and eyewash accessible; trained responder capability confirmed; waste route established.'
    ],
    stopWorkConditions: <String>[
      'Unknown substance, vapor cloud, strong reaction, heat, smoke, symptoms, fire/explosion potential or uncontrolled release.',
      'No matching SDS/product identification, uncertain PPE compatibility, no trained response team or no safe escape route.',
      'Release may enter drains, soil, waterway or occupied area and cannot be safely contained by available capability.',
      'Cleanup requires mixing chemicals, entering an unknown atmosphere, operating in a flammable vapor area or approaching an unstable container.',
      'No competent incident lead has confirmed cleanup completion, required monitoring, waste handling and re-entry.'
    ],
    interviewQuestions: <String>[
      'Q: What should a worker do first on finding an unknown spill? A: Raise the alarm, withdraw, isolate access from a safe position and report; do not touch or attempt cleanup.',
      'Q: How does SDS support response? A: It informs hazards, first aid, firefighting, spill handling, PPE, stability/reactivity and disposal; verify the SDS matches the product.',
      'Q: What distinguishes incidental from emergency release? A: Whether trained site personnel can safely control it under established procedures, considering substance, exposure, atmosphere, location and capability—not volume alone.',
      'Q: Why must chemical compatibility be checked? A: Incompatible materials or cleanup agents can react, generate heat or toxic gas, or cause fire.',
      'Q: What should happen after exposure? A: Use designated washing facilities and SDS/site first-aid directions promptly, summon medical support and provide product information.',
      'Q: Who authorizes re-entry? A: The designated competent incident lead after source control, cleanup, required assessment/monitoring and waste management are verified.'
    ],
  ),
];
