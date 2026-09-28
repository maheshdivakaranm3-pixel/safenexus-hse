// SafeNexus HSE — Emergency & Rescue Part 3
// File: lib/data/emergency_rescue/emergency_rescue_part3.dart
//
// Topics 09–12. General field-learning guidance. Use the current approved site
// ERP, task risk assessment, competent rescue arrangements, SDS and applicable
// authority/emergency-service instructions. Site plans must be validated for
// the actual worksite; this file does not create a site-specific authorization.

import 'emergency_rescue_part1.dart';

const List<EmergencyRescueTopic> emergencyRescuePart3 = <EmergencyRescueTopic>[
  EmergencyRescueTopic(
    id: 'ER-09',
    title: 'Work at Height Rescue',
    purpose: 'Work at Height Rescue is the planned recovery of a person who has fallen, is suspended in a fall-arrest system, is stranded at an elevated work position, or is otherwise unable to reach a safe place. The objective is to prevent a second casualty, provide prompt controlled recovery, and arrange medical assessment. Rescue must be planned before work starts; calling public emergency services alone is not a complete worksite rescue plan.',
    scope: 'Applies to roofs, scaffolds, ladders, towers, structural steel, formwork, work platforms, MEWPs and other elevated work locations. The method depends on access, height, structure, anchor suitability, casualty condition, weather, equipment and available competent rescuers.',
    keyKnowledge: <String>[
      'Select the hierarchy of controls: avoid work at height where practicable; use a safe working platform or collective protection; then use suitable restraint or fall-arrest systems where residual risk remains.',
      'A fall-arrest system can stop a fall but does not itself retrieve the person. Before work, identify the rescue method, rescue team, compatible equipment, access route, casualty landing area and emergency communication.',
      'A suspended worker may deteriorate while hanging. Treat suspension as urgent; do not rely on a universal “safe suspension time”. Initiate the site rescue response promptly and obtain medical assessment after recovery.',
      'Rescue options may include self-rescue, assisted descent, rescue from a platform, controlled lowering or raising, or specialist technical rescue. Use only methods for which the team is trained and the equipment is approved and compatible.',
      'Never improvise an anchor, connect rescue equipment to an unverified handrail, or overload a scaffold, MEWP or structure. A competent person must confirm anchor and system suitability for the intended rescue loads.',
      'Consider an unconscious or injured casualty, entanglement, sharp edges, swing fall, dropped objects, electrical lines, unstable structures, wind, limited access and the risk of rescuers becoming suspended.',
      'A rescue kit should be selected for the actual scenario, inspected, maintained, protected from damage and immediately accessible. Users must know its limitations and the manufacturer instructions.',
      'MEWP rescue may require ground controls or an emergency lowering procedure. Identify the machine-specific procedure and trained operator before use; do not assume all models operate alike.',
      'After recovery, trained first aiders assess the casualty and arrange emergency medical care as indicated. Do not allow an apparently recovered suspended worker to simply return to work.',
      'Preserve equipment and the scene where safe, quarantine fall-arrest equipment involved in a fall, report the event and review the risk assessment and rescue plan before restarting.'
    ],
    siteImplementation: <String>[
      'Before the task, the supervisor and competent person identify credible fall and stranding scenarios for the exact work location.',
      'Document rescue method, assigned rescuers, communication channel, access and egress, anchor/equipment verification, casualty landing point and external responder access.',
      'Brief workers on alarm words/signals, who initiates rescue, who controls the area and how to summon medical assistance.',
      'Check rescue equipment, harness compatibility, connectors, ropes, edge protection, MEWP emergency controls and inspection status before use.',
      'Stop work if the rescue method is unavailable, access is blocked, weather exceeds approved limits, equipment is defective or the rescue team is not available.',
      'On an event, raise alarm, stop nearby work, secure the drop zone and prevent further falls or dropped objects. Keep an untrained person from attempting an improvised climb or rescue.',
      'The designated rescue lead selects the pre-planned method after checking hazards and casualty condition. Maintain communication with the casualty where possible.',
      'Recover the casualty in a controlled manner, protect against secondary impact and transfer to first aid/medical responders.',
      'Record time line, equipment identification, witness details and actions; quarantine affected equipment and authorize restart only after review.'
    ],
    practicalExample: <String>[
      'A painter falls into a harness while working from an approved elevated platform and remains suspended. The coworker raises the alarm and stops adjacent work. The trained rescue team secures the exclusion zone, uses the pre-briefed compatible rescue system and verified anchor, lowers the worker to the designated safe area, and hands over to first aid/medical responders. The harness and lanyard are quarantined for competent inspection; work does not resume until the cause and controls are reviewed.'
    ],
    stopWorkConditions: <String>[
      'No documented, feasible rescue method or no competent rescue capability available for the shift.',
      'Unverified anchor, incompatible or damaged equipment, expired/unclear inspection status, or rescue kit inaccessible.',
      'Unsafe weather, unstable structure, exposed electrical hazard, uncontrolled dropped-object zone or blocked emergency access.',
      'Rescue would expose a second person to an uncontrolled fall or other serious hazard; isolate and escalate for specialist response.'
    ],
    interviewQuestions: <String>[
      'Q: Why is rescue planning required before work at height? A: Fall arrest only stops a fall; a suspended or stranded person still needs prompt, controlled recovery, and rescuers must not be exposed to a second incident.',
      'Q: What is suspension trauma? A: A potentially serious medical condition associated with remaining suspended in a harness; treat it as urgent and arrange prompt recovery and medical assessment.',
      'Q: Can any worker perform a harness rescue? A: No. Only people trained, equipped and authorized for the selected method should perform technical rescue.',
      'Q: What happens to fall-arrest equipment after a fall? A: Remove it from service, identify and quarantine it, and follow competent inspection/manufacturer requirements before any disposition.',
      'Q: What should the rescue plan specify? A: Scenario, roles, alarm, method, verified equipment/anchors, access, landing area, communication, medical handover and external assistance.'
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-10',
    title: 'Crane / Lifting Emergency Rescue',
    purpose: 'A lifting emergency is an abnormal event during crane or lifting operations that threatens people, load stability, equipment integrity or nearby assets. Response priorities are to stop the lift safely where possible, isolate the danger area, prevent uncontrolled movement and obtain competent technical or emergency assistance. Do not attempt an improvised recovery of a suspended load or damaged crane.',
    scope: 'Applies to mobile, crawler, tower and overhead cranes, hoists, lifting accessories and suspended loads, including power failure, mechanical/hydraulic fault, overturning, rigging failure, snagging, load swing, operator incapacitation and person entrapment.',
    keyKnowledge: <String>[
      'Credible scenarios include loss of power, control malfunction, hydraulic leak, abnormal noise, instability, ground settlement, outrigger movement, wind effects, load snagging, failed rigging, dropped load and contact with services.',
      'The lift supervisor, crane operator, appointed lifting personnel and site emergency controller must understand their roles and communication protocol before lifting begins.',
      'Use the crane manufacturer emergency instructions and approved lift plan. A safe response may differ by crane model, load, configuration, ground condition and failure mode.',
      'If a load is suspended, establish an exclusion zone based on the credible fall, swing and collapse envelope. Keep people out; do not stand beneath or attempt to steady a load by hand.',
      'Where safe and within the operator’s training and approved procedure, stop movement and secure controls. Do not operate unfamiliar controls or defeat safety devices.',
      'For suspected instability, structural damage, overturning or failed rigging, withdraw personnel and call competent lifting/engineering specialists and emergency services as required.',
      'If electrical line contact is possible, treat the crane and surrounding ground as energized. Keep clear, warn others and coordinate isolation with the network/operator; do not approach until declared safe by the responsible authority.',
      'If the operator is incapacitated, do not climb onto the crane or attempt control transfer unless the approved emergency procedure and competent personnel explicitly provide for it.',
      'Rescue of a trapped or injured person must be coordinated with emergency responders and technical specialists. Stabilization, isolation and controlled access come before casualty extraction unless immediate life-saving action is directed by competent responders.',
      'After the event, preserve the scene where safe, quarantine crane and accessories, report defects, review ground conditions and lift plan, and obtain competent release before reuse.'
    ],
    siteImplementation: <String>[
      'Pre-lift briefing confirms emergency stop/communication, operator and lifting-team roles, exclusion-zone boundaries, emergency access and escalation contacts.',
      'Check ground bearing and setup controls, equipment condition, rigging identification, load path, weather limits and nearby overhead/underground hazards under the approved lift plan.',
      'On abnormal movement, sound, instability, snagging or communication loss, stop the lift and alert the lift supervisor using the agreed signal.',
      'Secure the area, stop nearby operations and prevent entry beneath the load or into the possible collapse/swing zone.',
      'The operator follows the crane-specific safe shutdown or emergency procedure only where it is safe to do so; do not force a landing or movement that may worsen instability.',
      'The lift supervisor informs the emergency controller and requests competent crane/engineering support or public emergency services as needed.',
      'For injury or entrapment, provide first aid only from a safe position and coordinate extraction with competent responders.',
      'Document equipment status, load details, configuration, ground condition, weather, communications and witness accounts. Quarantine affected equipment pending inspection and formal authorization.'
    ],
    practicalExample: <String>[
      'During a planned lift, the operator notices unexpected outrigger settlement and the load begins to move abnormally. The operator stops movement using the approved procedure and alerts the lift supervisor. The area is evacuated and isolated; no one approaches the load or attempts to pack the outrigger. A competent lifting/engineering team assesses stability and directs any recovery. Equipment remains out of service until inspected and released.'
    ],
    stopWorkConditions: <String>[
      'Unexplained movement, abnormal noise, hydraulic leak, instability, ground settlement, damaged rigging or loss of reliable communication.',
      'People inside the exclusion zone, uncontrolled public interface or emergency access blocked.',
      'Suspected contact with power lines or other stored-energy source without confirmed safe isolation.',
      'No approved recovery procedure, competent lifting lead or suitable technical support for the abnormal condition.'
    ],
    interviewQuestions: <String>[
      'Q: What is the first priority in a crane emergency? A: Protect life, stop or avoid worsening movement where safe, isolate the danger zone and activate the site emergency response.',
      'Q: Should workers try to guide a suspended load by hand during a failure? A: No. Keep clear of the fall and swing zone and follow the approved emergency plan.',
      'Q: What if a crane contacts an overhead power line? A: Treat it as energized, keep people away, warn others and obtain isolation/clearance from the responsible electrical authority before approach.',
      'Q: Who decides how to recover a damaged or unstable crane? A: Competent lifting/engineering specialists using manufacturer guidance and an approved recovery method, coordinated with emergency responders.',
      'Q: When can equipment return to service? A: Only after defects and event causes are assessed, required inspection/repair is completed and an authorized competent person releases it.'
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-11',
    title: 'Electrical Shock Rescue',
    purpose: 'Electrical shock rescue is the controlled response to electric shock, electrical burns, arc flash, or a person in contact with energized equipment. The rescuer’s first duty is to avoid becoming another casualty. Do not touch the person or conductive object until the electrical hazard is confirmed isolated or a specifically trained and equipped responder applies an approved method.',
    scope: 'Applies to temporary and permanent electrical installations, portable tools, cables, panels, generators, overhead/underground services, batteries and high-voltage systems. Response must account for stored energy, automatic re-energization, backfeed and arc-flash exposure.',
    keyKnowledge: <String>[
      'Electrical injury may cause cardiac arrest, burns, muscle injury, falls and internal injury even when external marks appear minor. Arrange urgent medical assessment after suspected significant shock or arc exposure.',
      'Raise the alarm, keep others away and identify the source from a safe location. Never grab a person who may still be in contact with an energized source.',
      'Use the designated emergency stop or isolator only if it is safe, accessible and the responder is authorized. Isolation must be verified by a competent electrical person; a switch position alone may not prove absence of voltage.',
      'Consider alternate supplies, generators, UPS, capacitors, batteries, induced voltage and automatic restart. Apply the site electrical isolation/LOTO procedure and test-before-touch practices through authorized personnel.',
      'High-voltage systems, substations and overhead lines require the responsible network/electrical authority and specialist responders. Maintain the prescribed approach boundaries; do not improvise rescue with poles, ropes or vehicles.',
      'Arc flash can injure without direct contact. Do not enter a suspected arc hazard area until the source and approach conditions are made safe by competent personnel.',
      'Once the scene is declared electrically safe, trained first aiders assess responsiveness and breathing, summon emergency medical help, and begin CPR/AED according to their training and device prompts when indicated.',
      'Do not delay emergency medical response while trying to determine the exact voltage or injury severity. Communicate known exposure, burns, fall, loss of consciousness and isolation status to responders.',
      'Do not apply creams or remove clothing stuck to burns. Protect the casualty from further contamination and follow trained first-aid guidance while awaiting medical care.',
      'Preserve evidence where safe, isolate/quarantine the equipment, report the event and require competent investigation and authorization before re-energization.'
    ],
    siteImplementation: <String>[
      'Include emergency contacts, electrical isolation points, authorized persons, LOTO arrangements and emergency responder access in the site plan.',
      'At the event, shout/raise alarm, stop nearby work and prevent approach. Tell others not to touch the casualty, cable, tool or surrounding metalwork.',
      'Request the authorized electrical person or network operator to isolate the source. Do not approach a downed line or flooded/electrified area.',
      'Wait for competent confirmation that the source is isolated and safe, including consideration of stored energy and re-energization controls.',
      'After safe access is confirmed, trained first aiders assess the casualty, call ambulance/emergency medical services and provide CPR/AED or burn care within their training.',
      'Keep the casualty warm and monitored; do not move them unnecessarily if a fall or spinal injury is possible unless the scene becomes unsafe.',
      'Give responders the suspected source, exposure mechanism, isolation status, symptoms, burns and any fall/impact information.',
      'Secure and label affected equipment against use; record witnesses, permits, isolation records and corrective actions. Re-energize only after competent inspection and formal release.'
    ],
    practicalExample: <String>[
      'A worker collapses beside a damaged portable cable. A coworker raises the alarm but does not touch the worker. The supervisor isolates the area and calls the authorized electrician. After the supply is isolated and safety is confirmed, trained first aiders assess breathing, call emergency medical services and use an AED/CPR if indicated by their training. The cable and tool are quarantined and the incident is investigated before work resumes.'
    ],
    stopWorkConditions: <String>[
      'Unknown or unverified electrical source, damaged cable, exposed conductor, wet energized area or suspected overhead-line contact.',
      'No authorized person available to isolate and verify the source or uncertainty about backfeed/stored energy.',
      'Arc-flash hazard, damaged switchgear, smoke, fire or repeated tripping without competent assessment.',
      'Anyone proposes touching or moving the casualty before the electrical danger is confirmed safe.'
    ],
    interviewQuestions: <String>[
      'Q: What is the first action when someone is receiving an electric shock? A: Do not touch them; raise the alarm, keep others away and arrange safe isolation by an authorized person.',
      'Q: Is switching off a breaker always enough? A: No. Isolation must be verified and other sources, stored energy and re-energization considered under the electrical safety procedure.',
      'Q: When can CPR/AED begin? A: Once the scene is confirmed electrically safe and trained responders can access the casualty; follow training and AED prompts.',
      'Q: Why is medical assessment important after shock? A: Serious cardiac, burn or internal injuries may not be obvious immediately.',
      'Q: Who can authorize re-energization? A: The competent authorized electrical authority after inspection, corrective work and required release.'
    ],
  ),
  EmergencyRescueTopic(
    id: 'ER-12',
    title: 'Chemical Spill Response',
    purpose: 'Chemical spill response protects people, the environment and property from an uncontrolled release of a hazardous substance. The response begins with recognition, alarm, isolation and assessment—not automatic cleanup. Only trained and equipped personnel may handle a spill within their assigned capability; unknown, highly hazardous or escalating releases require evacuation and specialist emergency response.',
    scope: 'Applies to chemical receipt, storage, transfer, mixing, maintenance, laboratories, workshops, fuel/chemical stores and transport interfaces. Consider liquid, vapor, gas, powder, reactive, corrosive, flammable, toxic and environmentally harmful materials.',
    keyKnowledge: <String>[
      'Distinguish a small incidental release that trained site personnel can safely control from an emergency release requiring a specialist hazardous-material response. The decision depends on substance, quantity, exposure, ventilation, fire/explosion potential, location and responder capability—not volume alone.',
      'Identify the substance using container label, inventory and Safety Data Sheet (SDS) only when this can be done without entering the hazard area. Never approach an unknown vapor cloud to read a label.',
      'Raise alarm, stop work, isolate access and move people to a safe location. Use wind direction and site-specific plume guidance; where relevant, move crosswind and then upwind/uphill as directed by the emergency plan.',
      'Do not touch, smell, walk through or attempt to neutralize an unknown chemical. Avoid creating sparks or operating electrical equipment in a potentially flammable atmosphere unless the emergency procedure permits it.',
      'Select PPE and respiratory protection from the substance hazard assessment and SDS, with trained fit-tested users where required. Ordinary work gloves or dust masks are not a universal spill response kit.',
      'Protect drains, soil and water only when it can be done safely by trained responders. Do not wash chemicals into drains or mix incompatible absorbents/neutralizers.',
      'Account for exposure routes: inhalation, skin/eye contact, ingestion and injection. Use designated eyewash/safety shower for exposure as trained and seek medical advice promptly; bring the SDS or product information to medical responders.',
      'Establish hot, warm and cold zones where the incident scale and specialist response method require them. Control entry, communications, decontamination and responder accountability.',
      'Spill waste, contaminated PPE and cleanup materials may remain hazardous. Package, label, store and dispose through the approved site/environmental waste process.',
      'Re-entry requires competent confirmation that the source is controlled, atmosphere/area is safe as applicable, waste is managed and affected equipment or process is released.'
    ],
    siteImplementation: <String>[
      'Maintain current chemical inventory, accessible SDS, compatible spill kits, emergency contacts, drain maps and trained response roles.',
      'At discovery, warn nearby people, raise the alarm and report known product, location, visible release, injuries and immediate hazards from a safe position.',
      'Evacuate or isolate according to the site ERP. Keep people out of the spill path and prevent ignition sources only when this can be done without exposure.',
      'Incident controller classifies the event using the site criteria and requests specialist responders when substance identity, atmosphere, scale or capability is uncertain.',
      'Trained responders select PPE, containment and recovery method from SDS, compatibility information and approved procedure. Do not mix chemicals or improvise neutralization.',
      'Protect drains and sensitive receptors only where safe; use compatible barriers/absorbents and prevent spread without entering an unsafe zone.',
      'For skin/eye exposure, use designated emergency washing facilities immediately as instructed by SDS/site procedure and obtain medical assessment. Do not delay care to complete reporting.',
      'Collect contaminated materials in compatible, labeled containers; arrange approved hazardous-waste handling and document quantities/impact where known.',
      'Verify source isolation, cleanup, ventilation/monitoring if required, waste removal and area release before restart. Review cause, training, storage and transfer controls.'
    ],
    practicalExample: <String>[
      'A container leaks in a chemical store and the product is not immediately confirmed. The discoverer warns others, activates the site alarm and withdraws without touching the liquid. The area is isolated and the emergency controller consults inventory/SDS from a safe location. Because the release capability is uncertain, trained specialist responders are requested. They select compatible PPE and containment, protect drains where safe, manage contaminated waste and authorize re-entry only after assessment and release.'
    ],
    stopWorkConditions: <String>[
      'Unknown substance, visible vapor/cloud, strong reaction, heat, fire, suspected toxic atmosphere or symptoms among nearby people.',
      'Spill exceeds trained team capability, PPE is uncertain, respiratory protection is unavailable or no safe escape route exists.',
      'Risk of incompatible chemical mixing, ignition, drain/waterway contamination or uncontrolled spread.',
      'No accessible SDS/inventory or no competent person to authorize cleanup, decontamination and re-entry.'
    ],
    interviewQuestions: <String>[
      'Q: What should a worker do first on discovering an unknown chemical spill? A: Raise the alarm, withdraw to safety, isolate access and report observations; do not touch or attempt cleanup.',
      'Q: What is the purpose of the SDS? A: It provides substance hazards, exposure controls, first aid, firefighting, spill handling, storage and disposal information; use the correct product SDS.',
      'Q: Can every spill be handled with a spill kit? A: No. Only trained personnel may manage a release within the site-defined incidental-spill capability; larger or uncertain events require specialist response.',
      'Q: Why must drain protection be considered? A: A release can spread beyond the work area and contaminate soil, surface water or drainage systems.',
      'Q: Who authorizes re-entry? A: The designated competent incident lead after source control, cleanup, required assessment/monitoring and waste management are verified.'
    ],
  ),
];
