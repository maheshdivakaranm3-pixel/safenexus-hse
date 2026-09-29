// SafeNexus HSE — Fire & Life Safety Topics FLS-31 to FLS-40
// Expanded handbook edition.
// These are proposed learning topics, not official regulatory numbering.
// Confirm current UAE/emirate requirements, approved design, manufacturer instructions,
// and site emergency procedures before operational use.

import 'package:flutter/material.dart';
import 'fire_science_prevention.dart';

class FireSciencePreventionTopics31To40 {
  static const List<FireSafetyTopic> topics = [
    FireSafetyTopic(
      id: "FLS-31",
      title: "Fire Safety in Hospitals & Healthcare Facilities",
      subtitle: "Clinical risk, oxygen, compartmentation and assisted evacuation",
      icon: Icons.local_hospital_rounded,
      accent: Color(0xFF1565C0),
      overview: "Hospitals and healthcare facilities have a distinctive fire-safety profile because occupants may be asleep, sedated, mobility-impaired, connected to medical equipment or dependent on clinical staff for movement. A fire can threaten life directly through heat and smoke and indirectly through interruption of oxygen, power, ventilation, critical care and other essential services. The facility must operate under its approved fire strategy, emergency plan, clinical continuity arrangements and applicable authority requirements. Staff should understand the difference between raising an alarm, protecting people in the immediate area, moving patients to a protected compartment and carrying out wider evacuation. The safest action depends on fire location, smoke spread, patient dependency, available staff and the facility's approved strategy; ad hoc movement can create additional clinical risk.",
      sections: [
        FireSafetySection("1. Healthcare fire risk and facility mapping", [
          "Start with a documented fire-risk assessment that considers the building layout, patient dependency, occupancy by shift, clinical processes, fire-protection systems, construction work and credible emergency scenarios. Review wards, operating theatres, intensive care, laboratories, pharmacies, medical-gas rooms, kitchens, laundries, waste rooms, plant rooms, electrical rooms, parking and loading areas.",
          "Identify patients who cannot self-evacuate, require life-support equipment, need bariatric or mobility assistance, are confused or require infection-control precautions. Patient information must be current, access-controlled and handled confidentially.",
          "Map fire compartments, smoke barriers, protected corridors, exits, refuge or receiving areas, fire-service access and any approved horizontal evacuation routes. Staff should know the nearest safe compartment and the person authorized to direct movement.",
          "Construction and maintenance can change risk rapidly. Temporary partitions, ceiling works, penetrations, alarm isolation, hot work, dust and changed routes require formal review, coordination and handover before affected clinical areas return to normal use."
        ]),
        FireSafetySection("2. Oxygen and medical-gas controls", [
          "Oxygen is not itself a fuel, but it supports combustion and can make materials ignite more readily and burn more intensely. Oxygen-enriched conditions may result from leaks, damaged connections, poor handling or incorrect equipment use. Keep ignition sources away from oxygen equipment and follow approved medical-gas procedures.",
          "Keep cylinders secured in approved locations, protected from impact and heat, with correct identification and access control. Do not allow oil or grease contamination on oxygen valves, regulators or fittings. Only trained, authorized personnel should connect, move or isolate medical-gas equipment.",
          "Medical-gas isolation can endanger patients if performed without clinical coordination. Follow the facility's emergency isolation matrix and obtain direction from the designated clinical/engineering authority unless the emergency plan specifically directs immediate action to protect life.",
          "Control smoking, candles, unauthorized heaters, electrical defects and hot work. Any suspected oxygen leak requires escalation, ignition-source control where safe, area management and action under the medical-gas emergency procedure."
        ]),
        FireSafetySection("3. Alarm, compartmentation and patient movement", [
          "On discovering fire or smoke, raise the alarm immediately using the approved call point or emergency communication route, report the exact location and activate the facility response. Do not assume another person has called.",
          "Close doors behind you where safe to limit smoke spread. Do not wedge fire doors open. Approved alarm-linked hold-open devices may be used only as designed and maintained.",
          "Healthcare facilities may use progressive horizontal evacuation: moving patients from the affected compartment to a protected adjacent compartment before considering vertical or full-building evacuation. This is not a universal instruction; follow the approved site strategy and incident command.",
          "Clinical staff coordinate patient movement, essential equipment, receiving-unit capacity and clinical records. Use approved evacuation aids and trained teams. Do not use ordinary lifts unless the fire strategy specifically designates and controls them for evacuation.",
          "Maintain clear corridors, fire doors, smoke barriers, exits, fire-fighting access and access to alarm call points and extinguishers. Beds, carts, oxygen cylinders and temporary equipment must not reduce approved escape capacity."
        ]),
        FireSafetySection("4. Emergency readiness, construction and inspection", [
          "Define roles for ward leaders, fire wardens, security, facilities, clinical engineering, control room and incident command. Staff must know alarm signals, call sequence, patient accountability, receiving locations and how to request emergency services.",
          "During rounds, check fire doors latch, seals and closers are intact; exits are clear; alarm call points and extinguishers are accessible; emergency lighting and signage appear serviceable; and evacuation aids are available and maintained.",
          "For hot work in or near occupied clinical areas, require authorized permit, risk assessment, fire watch, suitable barriers, protection of openings, alarm-system coordination and documented close-out. Prefer alternative cold-work methods where practicable.",
          "After a fire-system impairment, apply the formally approved impairment process: authorization, risk review, notifications, compensatory controls, monitoring, restrictions if required, restoration testing and documented return to service."
        ]),
        FireSafetySection("5. HSE officer field method and stop-work conditions", [
          "The HSE Officer should verify that the fire risk assessment matches actual use, patient dependency and current layout; interview staff on their roles; sample day and night shifts; inspect contractor interfaces; review drills and corrective actions; and confirm that system defects are escalated to responsible persons.",
          "Stop or suspend affected work for missing hot-work authorization, absent required fire watch, uncontrolled combustible materials, compromised compartmentation, unapproved alarm isolation, damaged medical-gas equipment or blocked evacuation routes.",
          "Smoke, visible fire, suspected oxygen release, loss of critical protection or a route that prevents safe patient movement requires immediate emergency-plan activation and escalation to incident command. Do not delay alarm or emergency response to complete paperwork."
        ])
      ],
      checklist: [
        "Current approved fire strategy, departmental risk assessment and emergency plan are available.",
        "Patient-dependency and receiving-compartment arrangements are current and confidentially controlled.",
        "Fire doors, smoke barriers, exits, alarm points, emergency lighting and fire-service access are unobstructed.",
        "Medical-gas equipment is secured, identified and managed by trained authorized personnel.",
        "Staff on each shift understand alarm response, clinical-led movement and accountability.",
        "Construction, hot work and fire-system impairments have authorization, compensatory controls and close-out evidence."
      ],
      requiredDocuments: [
        "Departmental fire risk assessment and approved facility fire strategy",
        "Emergency, progressive evacuation and patient-assistance procedures",
        "Medical-gas emergency/isolation procedure and cylinder inventory",
        "Fire alarm, door, smoke-control and suppression inspection/service records",
        "Staff competency, drill reports, hot-work permits and corrective-action register"
      ],
      interviewQuestions: [
        FireSafetyQuestion("Why is evacuation different in a hospital?", "Many patients cannot self-evacuate and may depend on clinical equipment. Follow the approved clinical-led strategy, which may use protected compartment-to-compartment movement, trained teams and confirmed receiving capacity."),
        FireSafetyQuestion("Why is oxygen a fire-safety concern?", "Oxygen supports combustion and can intensify a fire. Prevent leaks and ignition sources, keep equipment uncontaminated and follow medical-gas procedures."),
        FireSafetyQuestion("Can a fire door be wedged open for patient movement?", "Not with an unauthorized wedge. Use an approved alarm-linked hold-open arrangement where installed, or follow the facility's controlled procedure and maintain the required fire separation."),
        FireSafetyQuestion("What should staff do first when smoke is discovered?", "Raise the alarm, communicate the exact location, protect people in immediate danger when safe, close doors where possible and follow incident command and the approved patient-movement plan."),
        FireSafetyQuestion("What should an HSE Officer review?", "The approved strategy, departmental risk assessment, medical-gas controls, system maintenance, staff competence, drill learning, permits, impairment records and verified corrective-action closure.")
      ],
      references: [
        "Current UAE and relevant emirate Civil Defence requirements and the facility's authority-approved fire strategy; verify current applicability.",
        "Facility emergency plan, medical-gas procedures, clinical continuity and infection-control requirements.",
        "NFPA 99 and NFPA 101 are supplementary references only where adopted or specified; confirm edition and project applicability."
      ]
    ),

    FireSafetyTopic(
      id: "FLS-32",
      title: "Fire Safety in Hotels & Residential Buildings",
      subtitle: "Sleeping occupants, guest communication, escape routes and management",
      icon: Icons.hotel_rounded,
      accent: Color(0xFF1565C0),
      overview: "Hotels and residential buildings contain people who may be asleep, unfamiliar with the layout, unable to understand announcements, or in need of assistance. Occupancy changes by time of day and may include guests, residents, visitors, housekeeping, contractors and event attendees. Fire safety therefore depends on the approved building strategy, maintained detection and suppression, protected escape routes, clear instructions, competent staff and coordinated management. A system impairment or renovation can affect people who have no knowledge of the hazard, so communication and formal risk controls are essential.",
      sections: [
        FireSafetySection("1. Occupancy profile and fire-risk areas", [
          "Review guest rooms, apartments, kitchens, laundry rooms, linen stores, refuse rooms, parking, plant rooms, electrical rooms, balconies, service areas and renovation zones. Consider sleeping risk, children, older people, disability, language needs and staff coverage overnight.",
          "Housekeeping carts, luggage, furniture, promotional displays and stored materials can obstruct corridors or protected stairs. Keep escape routes and exit discharge clear and preserve the approved width and function of doors, lobbies and stairs.",
          "Guest-facing emergency information should be legible, understandable and consistent with the approved strategy. Room/floor identification, exit maps, alarm instructions and accessible assistance arrangements should be maintained.",
          "Control common ignition sources: cooking, smoking, candles, portable heaters, damaged chargers, overloaded sockets, laundry lint, waste and unauthorized alterations. Defective electrical equipment must be removed from use and reported."
        ]),
        FireSafetySection("2. Staff duties and alarm response", [
          "Reception, security, housekeeping, maintenance and night teams need defined duties for receiving alarms, calling emergency services, communicating instructions, supporting guests when safe, checking designated areas only within the approved plan and reporting accountability information.",
          "Do not direct untrained staff to enter smoke-affected areas or conduct unsafe room searches. Life safety and incident-command instructions take priority over property protection.",
          "Use approved communication channels and avoid contradictory instructions. Staff should know how to support people requiring assistance and where to report missing persons or inaccessible areas.",
          "Lifts should not be used during a fire unless specifically designated and controlled for evacuation by the approved strategy. Ordinary evacuation routes remain the designated protected stairs and exits."
        ]),
        FireSafetySection("3. Maintenance, impairment and renovation", [
          "Inspect representative floors and back-of-house spaces across shifts. Check fire doors latch, exit signs are visible, emergency lighting is serviceable, extinguishers are accessible, and housekeeping does not compromise egress.",
          "A disabled alarm, sprinkler, smoke-control or emergency-lighting system requires formal authorization, risk assessment, affected-party notification, compensatory measures, monitoring and restoration verification. Building management must determine restrictions or occupancy controls under applicable requirements.",
          "Contractor work needs permit and coordination, especially hot work, ceiling works, temporary partitions, fire stopping and any change to detection or suppression. Confirm daily close-out and formal handback before guest areas reopen.",
          "After renovation, verify penetrations are fire-stopped using approved systems, doors and dampers operate as designed, alarm coverage is restored and updated plans are issued."
        ]),
        FireSafetySection("4. HSE officer field method and stop-work conditions", [
          "The HSE Officer should walk guest floors, stairs, service corridors, kitchens, laundry and plant areas; interview day/night staff; sample maintenance records; review impairment logs; and verify contractor controls and drill actions.",
          "Escalate disabled protection without approved controls, blocked protected stairs, defective fire doors, smoke migration, unsafe hot work in occupied areas or an evacuation route inconsistent with the approved plan.",
          "Do not continue occupancy or high-risk work contrary to the approved fire strategy or competent authority/building-management direction. Activate the emergency plan for smoke, fire or immediate threat."
        ])
      ],
      checklist: [
        "Approved building fire strategy, evacuation plan and current floor plans are available.",
        "Guest instructions and assistance arrangements are understandable and maintained.",
        "Corridors, protected stairs, fire doors, exit discharge and fire-service access are clear.",
        "Alarm, sprinkler, emergency lighting and smoke-control defects are logged and controlled.",
        "Night-shift staffing, communications and emergency roles are verified.",
        "Renovation permits, fire stopping, impairment controls and handback are documented."
      ],
      requiredDocuments: [
        "Approved building fire strategy and evacuation plan",
        "Guest emergency information and accessible assistance arrangements",
        "Alarm, sprinkler, emergency lighting, fire-door and smoke-control service records",
        "Staff training/drill records, contractor permits, impairment log and corrective-action register"
      ],
      interviewQuestions: [
        FireSafetyQuestion("Why is hotel fire risk distinctive?", "Guests may be asleep or unfamiliar with exits. Staff must provide clear information and follow the approved response and assistance plan."),
        FireSafetyQuestion("What should housekeeping do about a blocked corridor?", "Remove the obstruction safely when authorized, report persistent causes and ensure the protected route is restored immediately."),
        FireSafetyQuestion("How should a fire-system impairment be managed?", "Obtain authorization, assess risk, notify affected parties, apply approved compensatory controls and restrictions, monitor, restore and test the system, then document closure."),
        FireSafetyQuestion("Can staff use lifts during evacuation?", "Only a lift specifically designated and controlled for evacuation under the approved strategy; otherwise use designated stairs."),
        FireSafetyQuestion("What should be checked on night shift?", "Duty coverage, alarm receipt, communications, keys/access, unobstructed routes, assistance arrangements and ability to contact emergency services.")
      ],
      references: [
        "Current UAE/emirate Civil Defence requirements and approved building fire strategy.",
        "Property emergency plan, guest communication, contractor control and impairment procedures.",
        "NFPA 101 may be supplementary where adopted; do not assume it automatically governs."
      ]
    ),

    FireSafetyTopic(
      id: "FLS-33",
      title: "Fire Safety in Shopping Malls & Public Buildings",
      subtitle: "Crowd movement, tenant interfaces, events and public communication",
      icon: Icons.storefront_rounded,
      accent: Color(0xFF1565C0),
      overview: "Shopping malls and public buildings bring together high occupant numbers, mixed tenant activities, food outlets, events, contractors and visitors who may not know the building. Fire safety requires a coordinated building strategy, clear exits, functioning alarm and voice communication, tenant controls, crowd-management arrangements and trained control-room response. A local fire or alarm can create crowd movement across several tenants, so decisions must be coordinated through the approved incident command structure rather than independent announcements.",
      sections: [
        FireSafetySection("1. Occupancy, egress and tenant coordination", [
          "Maintain current tenant plans, approved occupancy/event arrangements, assembly locations, accessible evacuation provisions and duty-manager contact lists. Review temporary changes such as kiosks, promotions, queues, displays and seasonal decorations.",
          "Keep exits, corridors, stairs, exit discharge and fire-service access clear. Temporary barriers, event furniture and queue lines must not reduce approved egress capacity or conceal exit signs and alarm devices.",
          "Coordinate tenant controls for cooking, extraction, grease, gas installations where approved, electrical loads, storage, waste, hot work and after-hours activities. Tenant and landlord responsibilities should be clear in writing.",
          "Consider children, older persons, people with disabilities and visitors unfamiliar with the site. Assign trained assistance and prevent unsafe counter-flow or crowd convergence."
        ]),
        FireSafetySection("2. Alarm and public communication", [
          "The control room should receive alarm signals, identify the zone, follow the approved verification and response matrix, notify incident command and contact emergency services as required. Do not delay emergency action where the alarm or observed conditions require immediate response.",
          "Use approved voice messages and trained personnel to provide concise, consistent instructions. Avoid contradictory announcements from tenants, security and event organizers.",
          "Direct people away from smoke and affected zones using the approved strategy. Keep responder routes and fire-service access clear; do not send occupants toward an assembly point exposed to smoke or emergency vehicle movement.",
          "Record alarm receipt, decisions, announcements, calls, system status and handover in the incident log."
        ]),
        FireSafetySection("3. Events, temporary installations and inspection", [
          "Before an event opens, verify approved layout and occupancy, escape routes, temporary power, electrical loading, decoration/material requirements where applicable, fire protection, emergency access, staff briefings and pre-opening inspection.",
          "Inspect public and back-of-house areas during both peak and quiet periods. Check exit visibility, door operation, housekeeping, alarm devices, voice zones, emergency lighting and fire-service access.",
          "Conduct coordinated drills or tabletop exercises with security, facilities, tenants, cleaning, event teams and contractors. Assign action owners and verify closure rather than merely recording completion."
        ]),
        FireSafetySection("4. Stop-work and HSE officer responsibilities", [
          "Stop an event or affected activity if exits are obstructed, temporary installations are unsafe, approved occupancy conditions are exceeded, alarm/voice systems are impaired without authorization or crowd density creates immediate danger.",
          "Escalate smoke, fire, burning smell, crowd-crush indicators, loss of emergency communications or blocked responder access immediately to control room and incident command.",
          "The HSE Officer should review event approvals, tenant rules, contractor permits, alarm records, drill outcomes and recurring housekeeping or egress defects."
        ])
      ],
      checklist: [
        "Approved fire strategy, occupancy/event approval and evacuation plans are current.",
        "Tenant contact tree and control-room alarm/voice response arrangements are tested.",
        "Public routes, exits, stairs, discharge and fire-service access remain clear at peak periods.",
        "Temporary event layout, power, materials and pre-opening checks are approved.",
        "Accessible assistance and assembly arrangements are included in drills.",
        "Incident logs, drill findings and corrective actions are tracked to verified closure."
      ],
      requiredDocuments: [
        "Approved fire strategy, occupant/event approval and evacuation plans",
        "Tenant fire-safety rules, contractor/event permits and pre-opening inspection records",
        "Alarm/voice evacuation, smoke-control, sprinkler and emergency-lighting test records",
        "Drill reports, control-room logs, tenant training and corrective-action register"
      ],
      interviewQuestions: [
        FireSafetyQuestion("Why is tenant coordination important?", "Hazards and response cross unit boundaries. Consistent permits, housekeeping, alarm response and communication reduce interface failures."),
        FireSafetyQuestion("What is the HSE response to blocked exits?", "Stop the activity, restore the route safely, notify management, document recurring causes and verify approved egress is available."),
        FireSafetyQuestion("How should a mall communicate during an alarm?", "Use the approved incident command and voice-message plan, with clear consistent instructions and no conflicting tenant announcements."),
        FireSafetyQuestion("What controls apply to a temporary event?", "Approved layout and occupancy, clear egress, safe temporary power, required material evidence, protection systems, trained staff and pre-opening verification."),
        FireSafetyQuestion("What should a drill evaluate?", "Alarm receipt, control-room decisions, public communication, tenant coordination, accessible assistance, route availability, responder access and accountability.")
      ],
      references: [
        "Current applicable UAE/emirate Civil Defence requirements and approved public-building fire strategy.",
        "Mall emergency plan, tenant handbook, event approval and crowd-management procedure.",
        "NFPA 101 and NFPA 72 are supplementary where adopted; confirm project/authority edition."
      ]
    ),

    FireSafetyTopic(
      id: "FLS-34",
      title: "Fire Safety in Kitchens & Catering Facilities",
      subtitle: "Cooking-oil hazards, extraction, suppression and energy isolation",
      icon: Icons.restaurant_rounded,
      accent: Color(0xFF1565C0),
      overview: "Commercial kitchens combine high temperatures, cooking oils, gas or electrical energy, grease-laden extraction systems and fast-paced work. Grease can accumulate in filters and ducts and provide a concealed path for fire spread. A fryer fire is not equivalent to an ordinary solid-material fire: applying water can cause violent splashing and spread burning oil. Prevention therefore relies on suitable equipment, cleaning, listed cooking suppression, functioning energy interlocks, trained staff and clear evacuation decisions.",
      sections: [
        FireSafetySection("1. Hazard identification and prevention", [
          "Identify fryers, ranges, grills, ovens, extraction hoods and ducts, fuel shutoffs, electrical panels, gas/LPG arrangements where approved, waste and combustible packaging. Review equipment condition, layout and simultaneous cooking operations.",
          "Maintain filters, hoods and ducts on a documented competent cleaning schedule based on actual cooking type, usage and grease loading. Keep access panels usable and record findings, cleaning and defects.",
          "Prevent unattended cooking, unsafe oil levels, uncontrolled temperature, damaged thermostats, loose clothing, combustible packaging near heat and accumulation of waste or lint.",
          "Use only approved cooking appliances and fuel/electrical connections. Gas odor, damaged flexible connections, abnormal flame or repeated electrical trips require immediate escalation and safe isolation by authorized personnel."
        ]),
        FireSafetySection("2. Suppression, extinguishers and response", [
          "Maintain approved automatic cooking-equipment suppression, manual release access and designed fuel/electrical interlocks. Never bypass a shutdown or tamper with nozzles, detection links or release mechanisms.",
          "Provide extinguishing equipment suitable for the assessed hazards and approved design. A wet-chemical/Class F agent is commonly specified for cooking-oil risks, but the installed label and site training govern actual use.",
          "Never apply water to burning cooking oil. Water can rapidly vaporize beneath hot oil and eject burning oil, causing severe burns and fire spread.",
          "On fire: raise alarm, warn others, call emergency response, isolate energy only if safe and authorized, and evacuate if the fire is not immediately controllable. Staff should attempt incipient-stage firefighting only if trained, correct equipment is available, the escape route remains clear and the emergency plan permits it.",
          "Do not open a hood or duct access panel during a suspected concealed fire unless directed by trained responders; added air can worsen combustion."
        ]),
        FireSafetySection("3. Inspection, shutdown and return to service", [
          "Check suppression service status, manual release access, fuel shutoff identification, interlock test records, hood/duct cleaning evidence, extinguisher suitability and staff competence.",
          "After suppression discharge or a fire, keep affected equipment out of service until competent inspection, cleaning, system recharge/repair, functional testing and authorized restart are completed.",
          "The HSE Officer should observe work practices, verify cleaning records, review near misses and ensure defects are closed. Repeated grease accumulation requires review of cleaning frequency and management controls."
        ]),
        FireSafetySection("4. Stop-work triggers", [
          "Stop affected cooking for failed suppression/interlock, uncontrolled gas odor, damaged electrical supply, excessive grease, unsafe fryer condition, missing required protection or blocked escape route.",
          "If fire involves a fryer or extraction duct, activate the emergency plan and evacuate as required. Do not attempt unsafe manual intervention."
        ])
      ],
      checklist: [
        "Kitchen fire risk assessment and equipment layout are current.",
        "Hood, filter and duct cleaning records reflect actual use and grease loading.",
        "Cooking suppression, manual release and designed interlocks are inspected and serviceable.",
        "Correct labeled extinguishers are accessible and staff are trained.",
        "Fuel isolation, exits, waste controls and housekeeping are satisfactory.",
        "Post-discharge equipment remains isolated until competent inspection and authorized restart."
      ],
      requiredDocuments: [
        "Kitchen fire risk assessment and equipment layout",
        "Cooking suppression inspection/maintenance and interlock test records",
        "Extraction hood/duct cleaning and gas/electrical maintenance records",
        "Staff training, incident/near-miss logs and corrective-action closure"
      ],
      interviewQuestions: [
        FireSafetyQuestion("Why must water not be used on a cooking-oil fire?", "Water can rapidly vaporize beneath hot oil and eject burning oil, spreading the fire and causing severe burns."),
        FireSafetyQuestion("What is the purpose of a suppression interlock?", "It performs the designed fuel or electrical shutdown when the system activates, reducing continued heat input."),
        FireSafetyQuestion("What if kitchen suppression is impaired?", "Stop affected cooking as required, notify responsible management, apply formally approved controls and restore/test the system before authorized restart."),
        FireSafetyQuestion("What extinguisher may be specified for cooking oil?", "A suitable labeled wet-chemical/Class F agent according to the approved risk assessment and installed equipment; staff must follow training and local requirements."),
        FireSafetyQuestion("When may staff fight a kitchen fire?", "Only when trained, alarm is raised, fire is incipient, correct equipment is available, conditions are safe and escape remains clear; otherwise evacuate.")
      ],
      references: [
        "Current UAE/emirate Civil Defence requirements, approved kitchen suppression design and equipment listing.",
        "Manufacturer instructions for cooking appliances, fuel shutoffs and suppression systems.",
        "NFPA 96, NFPA 17A and NFPA 10 are supplementary where adopted; verify editions and applicability."
      ]
    ),

    FireSafetyTopic(
      id: "FLS-35",
      title: "Fire Safety in Battery Charging & Energy Storage",
      subtitle: "Charging controls, BMS alarms, thermal runaway and isolation",
      icon: Icons.battery_charging_full_rounded,
      accent: Color(0xFF1565C0),
      overview: "Battery charging and stationary energy storage can present electrical shock, short-circuit, chemical, thermal and fire hazards. Risk varies substantially by chemistry, battery size, configuration, enclosure, charging method and installation. A small portable battery and a large energy-storage installation must not be managed as if they have identical emergency behavior. Controls should follow the approved design, manufacturer instructions, applicable authority requirements and a system-specific emergency response plan. The presence of a battery management system does not remove the need for inspection, protective devices, safe location, alarm response and competent maintenance.",
      sections: [
        FireSafetySection("1. Identify the system and establish safe charging", [
          "Record battery chemistry, capacity, voltage, charger model, battery-management system (BMS), enclosure, location, ventilation, operating limits, emergency disconnects and manufacturer instructions. Confirm that the battery and charger are approved as a compatible combination.",
          "Prevent overcharging, physical damage, short circuits, unauthorized modification and charging of visibly damaged or recalled units. Do not bypass BMS alarms or protective devices to keep equipment operating.",
          "Provide ventilation, environmental control and clearances required by the manufacturer and approved design. Keep combustible storage and ignition sources outside required zones; do not obstruct cooling openings or responder access.",
          "Protect circuits using specified overcurrent, ground-fault and other electrical protection. Emergency isolation points should be labeled, accessible and operated only by trained authorized persons unless the emergency plan directs otherwise.",
          "For stationary energy storage, verify approved detection, suppression, gas/thermal monitoring, separation, signage, access and emergency information as designed. Do not invent generic separation distances; use approved drawings and authority requirements."
        ]),
        FireSafetySection("2. Recognize abnormal conditions", [
          "Warning signs may include swelling, unusual heat, hissing, odor, leakage, smoke, physical damage, unexpected shutdown or repeated BMS alarms. Treat these as abnormal conditions, not routine maintenance issues.",
          "Stop use or charging when safe, warn others, restrict access and notify the responsible supervisor or emergency response team. Do not handle or move a battery that is hot, venting, smoking or otherwise failing.",
          "If smoke, venting, rapid heating or suspected thermal runaway occurs, activate the emergency plan, evacuate the affected area and call emergency services. Firefighting and cooling tactics depend on battery chemistry, system design, exposure and responder capability.",
          "Potential toxic or flammable gases require appropriate responder assessment and exclusion control. Do not re-enter based only on the disappearance of visible smoke or flame."
        ]),
        FireSafetySection("3. Inspection and post-event management", [
          "Inspect battery and charger compatibility, casing, cables, connectors, ventilation, clearances, labels, protective devices, alarms and access to emergency disconnects. Defects should be tagged, isolated and recorded.",
          "Confirm staff know the alarm matrix, emergency contacts, exclusion area, monitoring requirements and post-event re-entry authority. Conduct scenario-based briefings for the actual system installed.",
          "After an event, competent specialists assess affected batteries, adjacent modules, electrical systems and atmosphere. Quarantine and disposal must follow approved hazardous-waste and manufacturer procedures; ordinary waste disposal is not acceptable for suspect batteries.",
          "Return to service only after documented specialist clearance, repair or replacement, required testing, updated risk assessment and authorization."
        ]),
        FireSafetySection("4. HSE officer responsibilities and stop-work triggers", [
          "The HSE Officer verifies system documentation, charging controls, inspection records, staff training, alarm response, contractor competence and closure of defects. Confirm changes to capacity, layout or equipment undergo management of change and approval.",
          "Stop charging for damaged cables/connectors, abnormal temperature, repeated alarms, damaged casing, water ingress, unauthorized charger or failed protective device.",
          "Smoke, venting, rapid heating or suspected thermal runaway requires evacuation and emergency-service response under the approved plan. Do not attempt to carry or relocate a failing battery."
        ])
      ],
      checklist: [
        "Battery chemistry, charger compatibility, manufacturer limits and approved system design are known.",
        "Ventilation, environmental controls, required clearances and responder access are maintained.",
        "Protective devices, BMS alarms, labels and emergency isolation are serviceable.",
        "Damaged or abnormal batteries are isolated and handled through an approved specialist process.",
        "Staff know the alarm, evacuation, exclusion and re-entry procedure.",
        "Post-event inspection, quarantine, disposal and return-to-service authorization are documented."
      ],
      requiredDocuments: [
        "Battery/energy-storage risk assessment and approved system design",
        "Manufacturer manuals, BMS alarm matrix and commissioning/maintenance records",
        "Electrical inspection, charger compatibility and emergency isolation records",
        "Emergency response plan, training/drill evidence and damaged-battery quarantine/disposal records"
      ],
      interviewQuestions: [
        FireSafetyQuestion("What is thermal runaway?", "An uncontrolled self-heating process that may propagate within a battery and release heat and flammable or toxic gases. Its behavior and response depend on chemistry and system configuration."),
        FireSafetyQuestion("Can a hot or swollen battery be carried outside?", "No. Do not handle or move a battery showing abnormal heating, swelling, venting or damage. Isolate the area and follow specialist emergency procedures."),
        FireSafetyQuestion("Why is charger compatibility important?", "Incorrect charging voltage, current or profile can damage cells and defeat protective controls. Use approved matched equipment and never bypass the BMS."),
        FireSafetyQuestion("What should happen after a BMS alarm?", "Follow the manufacturer and site alarm matrix, stop charging if safe, notify responsible personnel and escalate according to severity. Do not reset or bypass without competent authorization."),
        FireSafetyQuestion("Who authorizes re-entry after a battery event?", "The incident commander and competent specialists under the approved emergency plan, after hazards, temperature, atmosphere and system isolation have been assessed and documented.")
      ],
      references: [
        "Current UAE/emirate authority requirements and approved electrical/fire strategy.",
        "Battery, charger, BMS and energy-storage manufacturer instructions and approved emergency response documents.",
        "NFPA 855 and UL 9540A may be supplementary only where adopted or specified; verify editions and project applicability."
      ]
    ),

    FireSafetyTopic(
      id: "FLS-36",
      title: "Lithium-Ion Battery Fire Prevention & Response",
      subtitle: "Cell damage, off-gassing, thermal runaway and re-ignition",
      icon: Icons.battery_alert_rounded,
      accent: Color(0xFF1565C0),
      overview: "Lithium-ion batteries store substantial energy in a compact form. Internal short circuit, overcharge, overheating, impact, manufacturing defect or unsuitable charging can initiate cell failure. A failure may release heat and flammable or toxic gases, produce jet flames, spread to adjacent cells and re-ignite after visible fire has stopped. Response cannot be reduced to one universal extinguisher instruction: battery size, chemistry, enclosure, surroundings and responder capability change the risk. Workers should recognize early warning signs, avoid handling suspect batteries and activate the approved emergency plan promptly.",
      sections: [
        FireSafetySection("1. Prevention, inspection and handling", [
          "Use approved batteries and chargers and follow manufacturer limits for temperature, charging, storage, transport and end-of-life management. Do not use counterfeit, modified, damaged or incompatible charging equipment.",
          "Inspect for swelling, puncture, cracks, corrosion, leakage, unusual odor, heat, smoke or abnormal performance. Remove suspect units from service without unnecessary handling and restrict access as the site procedure requires.",
          "Prevent crushing, dropping, piercing, short circuits, contact with conductive objects, unauthorized repair and exposure to heat or moisture. Protect battery terminals during storage and handling as specified by the manufacturer.",
          "Use designated charging/storage locations with required separation, detection, ventilation and fire protection. Keep exits clear and prohibit unattended charging where site or manufacturer rules disallow it.",
          "Train workers to recognize hissing, popping, venting, rapid heating, smoke and BMS alarms. Provide a clear call sequence, evacuation route, access-control method and emergency-service handover."
        ]),
        FireSafetySection("2. Emergency response and responder interface", [
          "For smoke, venting, flame or rapid temperature rise, raise the alarm, evacuate the affected area, restrict entry and call emergency services. Keep people away from smoke and position upwind where practicable without crossing the hazard zone.",
          "Do not puncture, open, compress, dismantle or attempt unauthorized repair of a swollen or failing cell. Do not retrieve property or move a battery that is hot, venting or smoking.",
          "Firefighting tactics depend on battery size, chemistry, configuration, enclosure and available responder capability. Workers should follow the site plan and fire-service direction rather than improvise a universal extinguishing method.",
          "Provide responders with battery chemistry and inventory, location, system drawings, isolation points, manufacturer emergency information, known alarms and any exposure or injury information."
        ]),
        FireSafetySection("3. Re-ignition, quarantine and return to service", [
          "Maintain exclusion and monitoring for the period directed by incident command or competent specialists. Internal damage may continue after flames cease, and adjacent cells or modules may be affected.",
          "Do not place affected batteries in ordinary waste. Use approved hazardous-waste/quarantine procedures and specialist handling, with documented chain of custody and disposal.",
          "Before reopening, inspect adjacent batteries, chargers, racks, electrical systems and ventilation. Re-entry requires documented authorization after hazards and atmosphere are assessed.",
          "Investigate root causes, update risk assessment, repair or replace affected equipment, brief workers and verify corrective-action effectiveness before return to service."
        ]),
        FireSafetySection("4. Stop-work triggers", [
          "Immediately stop use and escalate batteries that are damaged, swollen, hot, leaking or abnormal. Do not charge or transport suspect units through occupied areas.",
          "Smoke, hissing, venting, flame or rapid temperature rise requires alarm, evacuation, zone isolation if safe and emergency-service response. Do not re-enter to retrieve property."
        ])
      ],
      checklist: [
        "Battery and charger are approved, compatible and used within manufacturer limits.",
        "Physical condition and charging/storage location are inspected.",
        "Damaged or suspect batteries are removed from service and quarantined by approved process.",
        "Workers recognize warning signs and know alarm, evacuation and responder-call procedures.",
        "Responder information includes chemistry, location, isolation and system details.",
        "Post-event monitoring, specialist clearance, disposal and return-to-service are documented."
      ],
      requiredDocuments: [
        "Battery inventory, manufacturer safety information and charging/storage risk assessment",
        "Inspection, defect quarantine and approved disposal records",
        "Emergency plan, incident timeline, responder handover and post-event monitoring records",
        "Training, investigation, corrective actions and return-to-service authorization"
      ],
      interviewQuestions: [
        FireSafetyQuestion("Why can lithium-ion batteries re-ignite?", "Internal damage and stored energy may sustain delayed heating or renewed cell failure. Continued monitoring and specialist clearance may be necessary."),
        FireSafetyQuestion("Should a worker puncture or open a swollen cell?", "No. Do not puncture, open, compress or attempt unauthorized repair. Isolate and follow manufacturer and specialist procedures."),
        FireSafetyQuestion("Are all lithium-ion fires handled identically?", "No. Battery size, chemistry, configuration, enclosure, exposures and responder capability change tactics. Follow the approved emergency plan and fire-service direction."),
        FireSafetyQuestion("What are common warning signs?", "Swelling, unusual heat, odor, hissing, leakage, smoke, physical damage, abnormal performance or repeated battery-management alarms."),
        FireSafetyQuestion("When can the area reopen?", "After incident command and competent specialists confirm hazards are controlled, monitoring and inspection are complete, and documented clearance is issued.")
      ],
      references: [
        "Current UAE/emirate emergency and fire authority requirements and approved site battery response plan.",
        "Battery manufacturer safety instructions and applicable transport and waste requirements.",
        "NFPA 855, UL 9540A and relevant battery standards are supplementary unless adopted or specifically required."
      ]
    ),

    FireSafetyTopic(
      id: "FLS-37",
      title: "Fire Safety in Welding, Cutting & Grinding",
      subtitle: "Hot-work authorization, fire watch, spark travel and close-out",
      icon: Icons.construction_rounded,
      accent: Color(0xFF1565C0),
      overview: "Welding, thermal cutting and grinding generate sparks, hot slag, flame and heat. Ignition may occur away from the visible work point when sparks pass through openings, fall to lower levels, enter cable trays or reach concealed combustible materials. Hot work must therefore be planned as a controlled activity, not treated as safe merely because an extinguisher is nearby. The permit-to-work system, task risk assessment, area inspection, isolation, fire watch, communication and post-work monitoring must reflect the actual site and applicable requirements.",
      sections: [
        FireSafetySection("1. Planning and permit authorization", [
          "Prefer cold-work methods or a designated controlled hot-work bay where practicable. Define exact work location, task, equipment, duration, adjacent areas, simultaneous operations, combustible materials and concealed spaces.",
          "Obtain an authorized hot-work permit after a competent area inspection. Confirm required gas testing, isolations, fire-system impairment approval, area-owner coordination and emergency arrangements before starting.",
          "Remove combustibles or protect them with suitable fire-resistant barriers. Cover openings, drains, cable trays and penetrations as assessed, and prevent sparks or slag reaching lower floors or neighboring work areas.",
          "Inspect both sides of walls/floors and concealed spaces where heat or sparks may travel. Do not work on containers, tanks or lines until contents are identified, isolated, cleaned, tested and formally declared safe by competent personnel.",
          "Check cylinders, hoses, regulators, flashback protection, electrical leads, earthing, ventilation and PPE. Secure cylinders upright and protect them from heat, impact and unauthorized access."
        ]),
        FireSafetySection("2. Fire watch and active work controls", [
          "Provide a trained fire watch when required by the permit or risk assessment. The fire watch must understand ignition exposures, alarm method, suitable equipment, communication and authority to stop work.",
          "The fire watch must not be assigned conflicting duties that prevent continuous observation. Maintain suitable communication with the welder, supervisor and emergency response.",
          "Monitor spark travel, lower levels, opposite sides of barriers, nearby combustibles and changing conditions. Keep exits and emergency equipment accessible.",
          "Stop work if gas readings become unsafe, conditions change, ventilation fails, required fire watch is absent, combustible release occurs, permit validity ends or any control is lost."
        ]),
        FireSafetySection("3. Post-work monitoring and permit close-out", [
          "After work, inspect the work area and adjacent sides, above/below levels, penetrations, cable trays, waste and concealed spaces for smoke, smoldering, heat or ignition.",
          "Maintain fire watch for the duration specified by the approved permit, risk assessment and applicable requirements. Extend monitoring where concealed ignition potential remains; do not invent a universal time in place of the governing procedure.",
          "Close the permit only after required monitoring is complete, the fire watch reports satisfactory checks, defects are controlled and the responsible area owner accepts the area.",
          "If work pauses, shift changes, conditions change or the permit expires, suspend and revalidate. Previous authorization does not automatically cover a changed task or location."
        ]),
        FireSafetySection("4. HSE officer field responsibilities", [
          "Verify permit quality, area inspection, combustible control, fire-watch competence, equipment condition, gas testing where required, adjacent-area protection and documented close-out.",
          "Use field observations to confirm that actual work matches permit scope. Stop and escalate unauthorized hot work, missing controls, smoke, unexpected heat, gas leak or fire-protection impairment.",
          "Review near misses and repeat permit failures. Correct system causes such as poor planning, inadequate supervision, unclear boundaries or weak shift handover."
        ])
      ],
      checklist: [
        "Hot-work permit and task risk assessment are approved for the exact location and scope.",
        "Cold-work alternative was considered; combustibles and openings are controlled.",
        "Adjacent sides, lower levels and concealed spaces are inspected and protected.",
        "Equipment, cylinders, hoses, regulators and electrical leads are serviceable.",
        "Required trained fire watch, alarm communication and suitable equipment are present.",
        "Post-work inspection and monitoring are complete and permit close-out is authorized."
      ],
      requiredDocuments: [
        "Hot-work permit and task-specific risk assessment/JSA",
        "Gas-test, isolation/LOTO and fire-system impairment approvals where applicable",
        "Welder/operator competence, equipment inspection and fire-watch training records",
        "Pre/post-work inspection, permit close-out and incident/near-miss records"
      ],
      interviewQuestions: [
        FireSafetyQuestion("What is the fire watch's role?", "Continuously observe ignition exposures, maintain communication and suitable equipment, stop work and raise the alarm. The role must not be combined with conflicting duties."),
        FireSafetyQuestion("When is a hot-work permit required?", "As defined by site rules and risk assessment for hot work outside designated controlled areas. Authorization and required controls must be in place before starting."),
        FireSafetyQuestion("Why inspect the opposite side of a wall?", "Heat or sparks can pass through penetrations and ignite concealed combustibles away from the visible work face."),
        FireSafetyQuestion("Can work continue if the fire watch leaves?", "No. Suspend hot work until required coverage is restored and permit conditions are revalidated."),
        FireSafetyQuestion("When can the permit close?", "After work ends, the work area and adjacent exposures are inspected, required monitoring is completed, defects are controlled and authorized close-out is recorded.")
      ],
      references: [
        "Current UAE/emirate Civil Defence requirements and approved project hot-work/permit-to-work procedure.",
        "Welding/cutting equipment manufacturer instructions and site gas-testing/LOTO procedures.",
        "NFPA 51B may be supplementary where adopted; verify edition and authority/project applicability."
      ]
    ),

    FireSafetyTopic(
      id: "FLS-38",
      title: "Fire Safety in Confined Spaces",
      subtitle: "Flammable atmosphere, isolation, entry permit and rescue readiness",
      icon: Icons.sensor_door_rounded,
      accent: Color(0xFF1565C0),
      overview: "A confined space may have restricted entry or exit, limited natural ventilation and a potential for hazardous atmosphere or engulfment. Fire can rapidly consume oxygen, generate toxic smoke, block the only access route and make rescue extremely difficult. Fire prevention must be integrated with the confined-space entry permit, task risk assessment, verified isolation, atmospheric testing, ventilation, ignition control, attendant communication and a realistic rescue plan. An entry permit does not automatically authorize hot work; linked permits and controls must be satisfied.",
      sections: [
        FireSafetySection("1. Identify space hazards and prepare entry", [
          "Assess space geometry, access, contents, residues, connected lines, process hazards, previous substances, ventilation, nearby work and simultaneous operations. Examples include tanks, pits, manholes, vessels, ducts and certain pipe sections; classification depends on the applicable definition and site assessment.",
          "Isolate energy and material sources using verified LOTO, blinding or another approved method. Drain, clean and purge through competent personnel where required. Do not assume a single closed valve is adequate isolation.",
          "Issue the required confined-space entry permit after risk assessment, isolation verification, communication checks, attendant assignment and rescue readiness. Identify entry supervisor, entrants, attendant, gas tester and rescue team roles.",
          "Test atmosphere with calibrated instruments by a competent person for oxygen, flammable gases/vapours and relevant toxic substances. Sampling locations and frequency must reflect space geometry, hazard behavior and the approved procedure.",
          "Use approved ventilation and suitably rated equipment where required. Prevent exhaust recirculation and reassess the atmosphere after interruptions, process changes or ventilation failure."
        ]),
        FireSafetySection("2. Hot work, ignition and monitoring", [
          "Hot work inside a confined space requires separate authorization where site rules require it, with linked entry permit, isolation, gas monitoring, ignition-source control, fire watch, ventilation and emergency withdrawal criteria.",
          "Keep cylinders outside the space where required by the approved procedure; inspect hoses, leads and connections and prevent leaks. Remove unnecessary combustibles and control hot surfaces and slag.",
          "Maintain an attendant outside the space with reliable communication, entry/exit log and authority to order withdrawal. The attendant must not enter to perform an unplanned rescue.",
          "Withdraw immediately for alarm, unexpected atmosphere change, ventilation failure, loss of communication, symptoms, smoke, fire, permit breach or changed process conditions."
        ]),
        FireSafetySection("3. Rescue readiness and emergency response", [
          "Before entry, confirm rescue route, access dimensions, retrieval system, rescue equipment, responder capability, emergency contacts and site-specific rescue method. Non-entry rescue should be considered where feasible and designed for the actual space.",
          "No unplanned entry rescue. Only trained, authorized and properly equipped responders may enter under the rescue plan and incident command.",
          "If an alarm or fire occurs, raise the alarm, withdraw entrants as directed, account for all persons, isolate the space and call emergency services. Do not re-enter until competent reassessment, testing, permit reissue and rescue readiness are confirmed.",
          "After an event, preserve relevant entry logs, gas readings, isolation records and equipment information for investigation. Obtain competent clearance before restart."
        ]),
        FireSafetySection("4. HSE officer field responsibilities", [
          "Verify permit linkage, isolation evidence, gas-test instrument calibration, test records, ventilation, attendant coverage, communication, rescue readiness and entrant competence.",
          "Stop entry for missing permit, unverified isolation, unacceptable atmosphere, failed ventilation, unavailable rescue arrangements, ignition-control failure or any changed condition.",
          "Review drills and near misses. A rescue plan that exists only on paper is insufficient; personnel, equipment, access and response time must be realistic for the site."
        ])
      ],
      checklist: [
        "Space assessment, entry permit and task risk assessment are approved and current.",
        "Energy/material isolation is verified and recorded.",
        "Atmospheric tests use suitable calibrated equipment and required monitoring is maintained.",
        "Ventilation, lighting, communications and entry/exit log are functional.",
        "Attendant, rescue equipment, rescue route and trained responders are ready before entry.",
        "Hot work has all required linked permits and ignition controls.",
        "Stop-work and re-entry criteria are understood and enforced."
      ],
      requiredDocuments: [
        "Confined-space entry permit and task risk assessment/JSA",
        "Isolation certificate, LOTO/blinding register and gas-test records",
        "Entrant/attendant/supervisor/rescuer competence and equipment inspection records",
        "Rescue plan, communication checks, entry log, drill and permit close-out"
      ],
      interviewQuestions: [
        FireSafetyQuestion("Why is confined-space fire especially dangerous?", "Restricted egress, possible oxygen deficiency or toxic products, rapid smoke accumulation and difficult rescue can turn a small fire into multiple casualties."),
        FireSafetyQuestion("Who may perform rescue entry?", "Only trained, authorized and properly equipped responders under the approved rescue plan and incident command; never make an unplanned entry."),
        FireSafetyQuestion("What if gas readings change?", "Order immediate withdrawal, raise alarm, reassess source, ventilation and isolation, and allow re-entry only after competent authorization and permit revalidation."),
        FireSafetyQuestion("Why test at different levels or locations?", "Gases may stratify and space geometry can create pockets. The sampling plan must reflect hazards, configuration and competent procedure."),
        FireSafetyQuestion("Can hot work proceed under the entry permit alone?", "Only if all site-required hot-work authorization and linked controls are also satisfied. One permit does not replace another.")
      ],
      references: [
        "Current UAE/emirate confined-space and hot-work requirements and approved site entry/rescue procedures.",
        "Instrument and ventilation manufacturer instructions, site LOTO and permit-to-work standards.",
        "OSHA confined-space and NFPA guidance may be supplementary only; confirm local legal and project applicability."
      ]
    ),

    FireSafetyTopic(
      id: "FLS-39",
      title: "Fire Safety in Temporary Electrical Installations",
      subtitle: "Temporary distribution, overload, protection and cable management",
      icon: Icons.electrical_services_rounded,
      accent: Color(0xFF1565C0),
      overview: "Temporary electrical systems on construction, maintenance and event sites are frequently changed as work progresses. Overload, loose connections, damaged insulation, moisture, unsuitable equipment, poor cable routing and unauthorized modifications can create overheating, arcing and ignition. Temporary power must be designed, installed, inspected, modified and removed by competent authorized electrical personnel under approved project and jurisdictional requirements. Repeatedly resetting a protective device without identifying the cause is not an acceptable control.",
      sections: [
        FireSafetySection("1. Design and competent installation", [
          "Use an approved temporary-power design with load assessment, distribution-board locations, protective devices, earthing/bonding, environmental ratings, emergency isolation and cable routes. Confirm the design reflects actual equipment and anticipated changes.",
          "Only competent authorized electricians should install or modify temporary wiring. Keep distribution boards protected from weather, impact, unauthorized access and combustible storage; maintain covers, labels and circuit schedules.",
          "Select cables, plugs, connectors and equipment suitable for current, environment and mechanical exposure. Route cables away from vehicles, sharp edges, heat, water and trip hazards; use approved ramps or protection where necessary.",
          "Do not overload sockets, daisy-chain extensions, bypass protective devices, use damaged plugs or create unauthorized joints. High-load equipment must use correctly rated circuits and approved connections.",
          "Generators, battery systems, temporary lighting, heaters and hot-work equipment require coordinated controls for fuel, exhaust, ventilation, electrical protection and separation."
        ]),
        FireSafetySection("2. Inspection, defect control and emergency action", [
          "Apply inspection and testing frequencies specified by applicable rules, project requirements, manufacturer instructions and competent electrical risk assessment. Do not invent one interval for every site or equipment type.",
          "Remove defective equipment from service, identify it clearly and prevent reuse until competent repair and testing are complete. Record defects, responsible person, repair and authorization.",
          "Warning signs include burning smell, arcing, unusual heat, repeated breaker trips, exposed conductors, damaged insulation, wet equipment, missing covers or defeated protection.",
          "Isolate only if safe and authorized. Keep people clear, raise alarm for smoke/fire and arrange competent investigation before re-energization. Do not repeatedly reset a tripping breaker without diagnosis."
        ]),
        FireSafetySection("3. Field verification and project close-out", [
          "Inspect board access, lockability, circuit identification, protective-device condition, cable integrity, connectors, earthing evidence, housekeeping and emergency isolation access.",
          "Verify changes are recorded, tested and approved. Temporary supplies must be removed or formally handed over at project completion, with unused cables and equipment safely cleared.",
          "The HSE Officer checks records and site conditions but does not replace the electrical competent person's design, testing or authorization duties. Escalate unsafe conditions promptly."
        ]),
        FireSafetySection("4. Stop-work conditions", [
          "Stop use for exposed conductors, burning smell, arcing, overheating, repeated trips, wet/damaged equipment, missing covers, defeated protection or unauthorized wiring.",
          "Do not re-energize until the cause is identified, repair and required testing are completed, and authorized personnel approve return to service."
        ])
      ],
      checklist: [
        "Approved temporary-power design and load schedule match actual site use.",
        "Installation and modifications are completed by competent authorized electrical personnel.",
        "Boards are protected, identified, accessible and free from combustible storage.",
        "Cables and connectors are suitable, undamaged and routed safely.",
        "Protective devices, earthing and emergency isolation are verified by competent personnel.",
        "Defective equipment is isolated, tagged, repaired, tested and authorized before reuse.",
        "Temporary supplies are removed or formally handed over at project completion."
      ],
      requiredDocuments: [
        "Temporary electrical design/load schedule and approved installation drawings",
        "Competent electrician authorization, inspection/test certificates and maintenance log",
        "Defect isolation/tagging, repair, change-control and energization records",
        "Electrical risk assessment, emergency isolation plan and contractor induction records"
      ],
      interviewQuestions: [
        FireSafetyQuestion("Why should a breaker not be repeatedly reset?", "Repeated tripping indicates a fault or overload. Resetting without diagnosis can worsen overheating, arcing or fire risk."),
        FireSafetyQuestion("Who may modify temporary wiring?", "Competent authorized electrical personnel under approved change control and required testing."),
        FireSafetyQuestion("What are common fire causes?", "Overload, loose connections, damaged insulation, moisture ingress, unsuitable equipment and defeated protective devices."),
        FireSafetyQuestion("What should happen to a damaged extension lead?", "Remove it from service, identify/tag and report it; competent personnel must repair and test it or it must be replaced before reuse."),
        FireSafetyQuestion("What should an HSE Officer verify?", "Approved design, competent installation, suitable protection, inspection records, safe cable routing, defect control and access to emergency isolation.")
      ],
      references: [
        "Current UAE/emirate electrical safety requirements and approved project temporary-power design.",
        "Applicable utility and project electrical safety rules and equipment manufacturer instructions.",
        "IEC 60364 and NFPA 70 are supplementary unless adopted or specified; verify edition and jurisdiction."
      ]
    ),

    FireSafetyTopic(
      id: "FLS-40",
      title: "Fire Investigation, Root Cause Analysis & Lessons Learned",
      subtitle: "Scene control, evidence, causal analysis and safe restart",
      icon: Icons.fact_check_rounded,
      accent: Color(0xFF1565C0),
      overview: "A fire investigation establishes what is known, identifies the sequence of events and contributing factors, and develops controls to prevent recurrence. It must be coordinated with emergency services, competent investigators, authorities, insurers and company management as applicable. Immediate life safety and emergency response always take priority over evidence preservation. HSE personnel should distinguish facts from assumptions, avoid premature conclusions about origin or cause, protect evidence and ensure corrective actions address system weaknesses rather than relying only on reminders or retraining.",
      sections: [
        FireSafetySection("1. Initial response, notification and scene control", [
          "Prioritize life safety, alarm activation, emergency services, medical care, accountability and control of ongoing hazards. Do not delay evacuation, rescue or firefighting to preserve evidence.",
          "After incident command or authority release, secure the scene and restrict access. Record entry, protect evidence from weather, disturbance or unauthorized cleanup, and maintain confidentiality.",
          "Notify internal and external parties promptly according to applicable law, contract, insurer and company reporting procedures. Preserve CCTV, alarm logs, access records, permits, maintenance documents and relevant electronic data.",
          "Collect factual accounts separately and as soon as practicable. Distinguish direct observation, hearsay, assumptions and conclusions. Avoid leading questions, blame language and coaching witnesses.",
          "Maintain chain-of-custody for collected items, photographs, samples and electronic records. Coordinate evidence collection with authority-led investigators."
        ]),
        FireSafetySection("2. Timeline and causal analysis", [
          "Build a timeline using alarm activation, process events, work permits, equipment status, witness accounts, CCTV, control-room records and physical evidence. Record time uncertainty and conflicting accounts transparently.",
          "Separate the immediate event from failed or absent barriers and deeper system factors. Examine risk assessment quality, design, maintenance, competence, supervision, contractor interfaces, change management, procurement and management decisions.",
          "Use a structured method such as barrier analysis or a recognized root-cause technique suitable for the event. A single human error statement is not a complete root-cause analysis.",
          "Do not declare fire origin or cause without competent evidence. If the cause is undetermined, state limitations, unresolved questions and specialist testing needs clearly."
        ]),
        FireSafetySection("3. Corrective action, restart and lessons learned", [
          "Corrective actions should address causal failures, have accountable owners and due dates, be prioritized by risk and include objective evidence of completion. Consider engineering, design, maintenance, supervision and management-system improvements.",
          "Before restart, verify affected building/equipment integrity, fire-protection restoration, electrical and process safety, updated risk assessment, permit conditions, workforce briefing and formal authorization by responsible parties.",
          "Share verified lessons with relevant teams and contractors without blame or disclosure of confidential information. Track effectiveness checks to confirm the same failure mode has not recurred.",
          "Close the investigation only when required reporting, evidence, causal analysis, actions, approvals and effectiveness review are complete or remaining actions are formally tracked."
        ]),
        FireSafetySection("4. HSE officer responsibilities and integrity", [
          "The HSE Officer supports scene safety, notifications, document preservation, interviews, timeline development, action tracking and learning communication. The officer must not interfere with authority-led investigation or present speculation as fact.",
          "Do not alter equipment, discard damaged components, publish unverified findings or permit unauthorized cleanup. Respect legal holds, confidentiality and chain-of-custody requirements.",
          "If evidence conflicts, preserve the uncertainty and escalate to competent investigators. A credible report explains what is known, how it is supported, what remains unknown and what controls are needed meanwhile."
        ])
      ],
      checklist: [
        "Life safety, emergency response and accountability were prioritized.",
        "Scene access is controlled after authorized release and evidence handling is recorded.",
        "Required notifications and preservation of CCTV, alarms, permits and maintenance records are complete.",
        "Witness accounts distinguish direct facts from assumptions and are handled confidentially.",
        "Timeline and causal analysis consider failed barriers and system factors.",
        "Corrective actions have owners, deadlines, risk priority and objective verification.",
        "Restart authorization, lessons learned and effectiveness checks are documented."
      ],
      requiredDocuments: [
        "Incident notification and investigation procedure",
        "Incident timeline, witness statements, photo/video register and evidence chain-of-custody",
        "Fire-system, electrical, maintenance, hot-work permit, training and risk-assessment records",
        "Root-cause report, corrective-action tracker, restart authorization and lessons-learned communication"
      ],
      interviewQuestions: [
        FireSafetyQuestion("What is the difference between immediate and root causes?", "Immediate causes describe the event or failed barrier; root/system causes explain why controls, management systems or decisions allowed the event to occur."),
        FireSafetyQuestion("Should an HSE Officer decide fire origin immediately?", "No. Record facts and preserve evidence. Origin and cause conclusions require competent investigation and coordination with relevant authorities."),
        FireSafetyQuestion("What makes a corrective action effective?", "It addresses the causal failure, has an owner and deadline, is implemented and is verified for effectiveness rather than merely marked complete."),
        FireSafetyQuestion("When may work restart?", "After applicable authority or incident-command release, hazard and equipment assessment, restoration of controls, updated risk/permit review and documented authorization."),
        FireSafetyQuestion("How should lessons learned be communicated?", "Share verified relevant findings without blame or confidential details, brief affected teams, assign actions and check whether controls prevent recurrence.")
      ],
      references: [
        "Applicable UAE/emirate incident notification and authority requirements and company investigation procedure.",
        "Emergency command records, approved permits, maintenance and fire-protection documentation.",
        "ISO 45001 incident and continual-improvement principles and NFPA investigation guidance may be supplementary; verify applicability."
      ]
    )
  ];
}
