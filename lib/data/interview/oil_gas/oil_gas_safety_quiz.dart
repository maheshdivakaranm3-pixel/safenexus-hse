import 'package:flutter/material.dart';

class OilGasQuestion {
  final int id;
  final String topic, question;
  final List<String> options;
  final int correctAnswer;
  final String explanation, application;

  const OilGasQuestion({
    required this.id,
    required this.topic,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.application,
  });
}

const List<OilGasQuestion> oilGasQuestions = [
  OilGasQuestion(id: 1, topic: 'PTW', question: 'What is the primary purpose of a Permit to Work system?', options: ['Record attendance', 'Formally authorize and control hazardous work', 'Increase work speed', 'Replace risk assessment'], correctAnswer: 1, explanation: 'PTW ensures hazards are identified, risks assessed and precautions implemented before hazardous work begins.', application: 'Verify permit validity, isolation, gas testing and authorization before work starts.'),
  OilGasQuestion(id: 2, topic: 'PTW', question: 'Who generally authorizes hazardous work under a PTW system?', options: ['Security guard', 'Authorized Permit Issuer or Area Authority', 'Storekeeper', 'Transport supervisor'], correctAnswer: 1, explanation: 'The authorized issuer verifies work conditions, operational conflicts and required precautions.', application: 'Confirm issuer and receiver authorization before work.'),
  OilGasQuestion(id: 3, topic: 'PTW', question: 'What should happen when site conditions change after permit issuance?', options: ['Continue working', 'Ignore the change', 'Stop work and reassess', 'Ask an untrained worker'], correctAnswer: 2, explanation: 'Changed conditions may invalidate the original risk assessment or controls.', application: 'Stop, notify the permit authority and resume only after authorization.'),
  OilGasQuestion(id: 4, topic: 'PTW', question: 'Which document identifies task-specific hazards and controls?', options: ['Delivery note', 'Job Safety Analysis', 'Salary sheet', 'Attendance register'], correctAnswer: 1, explanation: 'JSA divides work into steps and identifies hazards and controls for each step.', application: 'Review the JSA with workers during toolbox talk.'),
  OilGasQuestion(id: 5, topic: 'PTW', question: 'What is the main purpose of a Toolbox Talk?', options: ['Discuss salary', 'Communicate task hazards and precautions', 'Replace permit', 'Record purchases'], correctAnswer: 1, explanation: 'It communicates work scope, hazards, controls and emergency arrangements.', application: 'Conduct briefing before work and verify understanding.'),
  OilGasQuestion(id: 6, topic: 'PTW', question: 'When is a Hot Work Permit normally required?', options: ['Office documentation', 'Welding, cutting or grinding', 'Lunch break', 'Walking through site'], correctAnswer: 1, explanation: 'Hot work creates ignition sources that may ignite flammable gases or materials.', application: 'Verify gas testing where required, fire watch and extinguishers.'),
  OilGasQuestion(id: 7, topic: 'PTW', question: 'What is the purpose of a Gas Test Certificate?', options: ['Measure productivity', 'Verify atmospheric conditions', 'Approve overtime', 'Inspect tyres'], correctAnswer: 1, explanation: 'Gas testing evaluates oxygen, flammable and relevant toxic gases.', application: 'Confirm calibration, locations, acceptance criteria and monitoring frequency.'),
  OilGasQuestion(id: 8, topic: 'PTW', question: 'What should happen when a work permit expires?', options: ['Continue', 'Workers extend it themselves', 'Stop and obtain authorized renewal', 'Remove permit'], correctAnswer: 2, explanation: 'An expired permit is no longer valid authorization.', application: 'Obtain formal revalidation before restarting.'),
  OilGasQuestion(id: 9, topic: 'PTW', question: 'What does SIMOPS assessment control?', options: ['Worker numbers', 'Interactions between simultaneous activities', 'Documentation elimination', 'Meeting frequency'], correctAnswer: 1, explanation: 'SIMOPS identifies conflicts between concurrent operations.', application: 'Assess lifting, hot work, production and maintenance interfaces.'),
  OilGasQuestion(id: 10, topic: 'PTW', question: 'Who must ensure workers understand permit conditions?', options: ['Security only', 'Responsible Permit Receiver or supervisor', 'HR', 'Delivery driver'], correctAnswer: 1, explanation: 'The responsible supervisor communicates conditions and verifies understanding.', application: 'Monitor implementation throughout the task.'),
  OilGasQuestion(id: 11, topic: 'H2S & Gas Testing', question: 'What is the chemical formula of Hydrogen Sulphide?', options: ['CO2', 'H2S', 'SO2', 'CH4'], correctAnswer: 1, explanation: 'H2S is a colourless, toxic and flammable gas.', application: 'Use suitable detection, alarms and respiratory protection arrangements.'),
  OilGasQuestion(id: 12, topic: 'H2S & Gas Testing', question: 'Why is smell unreliable for detecting H2S?', options: ['Always visible', 'Olfactory fatigue or loss of smell can occur', 'Only underwater', 'Never has odour'], correctAnswer: 1, explanation: 'The sense of smell can become unreliable at dangerous concentrations.', application: 'Never rely on smell; use a calibrated detector.'),
  OilGasQuestion(id: 13, topic: 'H2S & Gas Testing', question: 'What is the commonly referenced NIOSH IDLH value for H2S?', options: ['10 ppm', '50 ppm', '100 ppm', '500 ppm'], correctAnswer: 2, explanation: 'NIOSH IDLH for H2S is 100 ppm.', application: 'IDLH is not a routine exposure limit. Emergency entry requires trained responders and suitable respiratory protection.'),
  OilGasQuestion(id: 14, topic: 'H2S & Gas Testing', question: 'What does LEL stand for?', options: ['Low Exposure Level', 'Lower Explosive Limit', 'Limited Emergency Level', 'Liquid Emission Limit'], correctAnswer: 1, explanation: 'LEL is the lowest flammable gas or vapour concentration in air capable of propagating flame.', application: 'Check readings against approved site acceptance criteria.'),
  OilGasQuestion(id: 15, topic: 'H2S & Gas Testing', question: 'What does an oxygen reading of 18% generally indicate?', options: ['Normal oxygen', 'Oxygen enrichment', 'Oxygen deficiency', 'Safe unrestricted entry'], correctAnswer: 2, explanation: 'Atmospheric oxygen is approximately 20.9%; below 19.5% is generally considered oxygen-deficient under OSHA criteria.', application: 'Do not permit entry based only on absence of toxic gas alarms.'),
  OilGasQuestion(id: 16, topic: 'H2S & Gas Testing', question: 'Which instrument is commonly used for personal H2S monitoring?', options: ['Lux meter', 'Personal gas detector', 'Sound meter', 'Anemometer'], correctAnswer: 1, explanation: 'Personal detectors monitor gases according to sensor configuration.', application: 'Check calibration, bump test, battery and alarm operation.'),
  OilGasQuestion(id: 17, topic: 'H2S & Gas Testing', question: 'What is the primary purpose of SCBA?', options: ['Cool body', 'Provide independent breathable air', 'Measure gas', 'Prevent hearing loss'], correctAnswer: 1, explanation: 'SCBA provides breathable air from a carried cylinder.', application: 'Use approved equipment for designated entry and rescue by trained personnel.'),
  OilGasQuestion(id: 18, topic: 'H2S & Gas Testing', question: 'What is the purpose of an H2S escape set?', options: ['Unlimited routine work', 'Temporary respiratory protection during escape', 'Replace rescue equipment', 'Measure oxygen'], correctAnswer: 1, explanation: 'Escape breathing apparatus provides limited air for evacuation, not entry rescue.', application: 'Know its location, activation and limitations.'),
  OilGasQuestion(id: 19, topic: 'H2S & Gas Testing', question: 'What should a worker do when an H2S detector alarms?', options: ['Continue', 'Remove detector', 'Stop and evacuate', 'Identify by smell'], correctAnswer: 2, explanation: 'An alarm indicates potentially hazardous atmospheric conditions.', application: 'Evacuate, report to muster and do not re-enter without authorization.'),
  OilGasQuestion(id: 20, topic: 'H2S & Gas Testing', question: 'What is the correct response to a collapsed worker in an H2S area?', options: ['Enter unprotected', 'Hold breath and enter', 'Raise alarm and use trained protected responders', 'Switch off detector'], correctAnswer: 2, explanation: 'Unprotected rescuers may become additional casualties.', application: 'Use trained responders with suitable respiratory protection.'),
  OilGasQuestion(id: 21, topic: 'Confined Space', question: 'What is the primary purpose of a Confined Space Entry Permit?', options: ['Attendance', 'Authorize entry after hazard and control verification', 'Replace risk assessment', 'Allow unsupervised entry'], correctAnswer: 1, explanation: 'The permit confirms assessment, isolation, testing and rescue arrangements.', application: 'Verify permit and actual site conditions before entry.'),
  OilGasQuestion(id: 22, topic: 'Confined Space', question: 'What is the commonly used atmospheric testing sequence?', options: ['Toxic, oxygen, flammable', 'Flammable, toxic, oxygen', 'Oxygen, flammable, toxic', 'Any sequence'], correctAnswer: 2, explanation: 'Oxygen is tested first, followed by flammable and then toxic gases.', application: 'Use calibrated instruments and sample different levels where required.'),
  OilGasQuestion(id: 23, topic: 'Confined Space', question: 'What is the purpose of mechanical ventilation?', options: ['Increase noise', 'Control hazardous atmosphere', 'Replace gas testing', 'Remove rescue needs'], correctAnswer: 1, explanation: 'Ventilation may control oxygen deficiency, toxic gases and flammable atmospheres.', application: 'Maintain ventilation and monitoring as required.'),
  OilGasQuestion(id: 24, topic: 'Confined Space', question: 'What is the main responsibility of a Standby Attendant?', options: ['Enter for rescue', 'Monitor entrants and initiate emergency response', 'Weld inside', 'Issue salaries'], correctAnswer: 1, explanation: 'The attendant maintains accountability, communication and emergency readiness.', application: 'Do not undertake conflicting duties or unplanned entry rescue.'),
  OilGasQuestion(id: 25, topic: 'Confined Space', question: 'What communication arrangement is required during entry?', options: ['None', 'Reliable entrant-attendant communication', 'Only after accident', 'Unassessed mobile phone'], correctAnswer: 1, explanation: 'Reliable communication supports monitoring and prompt evacuation.', application: 'Test system and establish check-in intervals.'),
  OilGasQuestion(id: 26, topic: 'Confined Space', question: 'What must be established before confined space entry?', options: ['Rescue after incident', 'Rescue plan, trained personnel and equipment', 'First-aid box only', 'Attendance register'], correctAnswer: 1, explanation: 'Rescue planning addresses atmospheric, access and extraction hazards.', application: 'Use non-entry retrieval where feasible and approved.'),
  OilGasQuestion(id: 27, topic: 'Confined Space', question: 'Why is LOTO essential before entering a space containing machinery?', options: ['Increase production', 'Prevent unexpected startup and energy release', 'Replace gas testing', 'Avoid toolbox talk'], correctAnswer: 1, explanation: 'LOTO controls electrical, mechanical, hydraulic, pneumatic and stored energy.', application: 'Verify isolation and zero-energy condition.'),
  OilGasQuestion(id: 28, topic: 'Confined Space', question: 'Which condition requires immediate evacuation?', options: ['Normal readings', 'Gas alarm or loss of required ventilation', 'Completed toolbox talk', 'Valid permit'], correctAnswer: 1, explanation: 'Unsafe conditions may invalidate entry authorization.', application: 'Evacuate, account for entrants and reassess before re-entry.'),
  OilGasQuestion(id: 29, topic: 'Confined Space', question: 'What should happen when an entry permit expires?', options: ['Continue', 'Extend verbally', 'Stop entry and obtain authorized revalidation', 'Ignore expiry'], correctAnswer: 2, explanation: 'Permit validity depends on approved scope and conditions.', application: 'Review atmosphere, isolation and rescue readiness.'),
  OilGasQuestion(id: 30, topic: 'Confined Space', question: 'When should an entry permit be suspended or cancelled?', options: ['Only when HSE leaves', 'When work is complete or conditions become unsafe', 'At month end', 'Only for overtime'], correctAnswer: 1, explanation: 'Authorization must end when its conditions no longer apply.', application: 'Account for entrants and complete formal closure.'),
  OilGasQuestion(id: 31, topic: 'Fire & Explosion', question: 'What are the three elements of the Fire Triangle?', options: ['Fuel, Oxygen and Heat', 'Water, Smoke and Fuel', 'Nitrogen, Water and Heat', 'Fuel, Pressure and Water'], correctAnswer: 0, explanation: 'Fire requires fuel, oxygen and sufficient heat.', application: 'Control ignition sources and combustible materials.'),
  OilGasQuestion(id: 32, topic: 'Fire & Explosion', question: 'What is the main purpose of a Fire Watch?', options: ['Attendance', 'Detect and respond to fire hazards during and after hot work', 'Operate welding equipment', 'Issue permits'], correctAnswer: 1, explanation: 'Fire Watch monitors sparks, hot surfaces and combustible materials.', application: 'Provide extinguishers, communication and emergency readiness.'),
  OilGasQuestion(id: 33, topic: 'Fire & Explosion', question: 'What does Flash Point mean?', options: ['Temperature at which liquid vapour can ignite under specified test conditions', 'Water freezing point', 'Steel melting point', 'Oxygen disappearance'], correctAnswer: 0, explanation: 'Flash point indicates when sufficient vapour forms an ignitable mixture under test conditions.', application: 'Apply ignition-source controls when handling petroleum products.'),
  OilGasQuestion(id: 34, topic: 'Fire & Explosion', question: 'What is the purpose of an Emergency Shutdown System?', options: ['Increase production', 'Move process operations to a defined safe state', 'Replace extinguishers', 'Control attendance'], correctAnswer: 1, explanation: 'ESD initiates predefined actions to reduce emergency escalation.', application: 'Know alarms and assigned shutdown responsibilities.'),
  OilGasQuestion(id: 35, topic: 'Fire & Explosion', question: 'What is the main danger of static electricity during petroleum transfer?', options: ['Noise', 'Ignition from electrostatic discharge', 'Poor lighting', 'Water pressure'], correctAnswer: 1, explanation: 'Accumulated charge may discharge as a spark.', application: 'Follow bonding, grounding and approved transfer procedures.'),
  OilGasQuestion(id: 36, topic: 'Fire & Explosion', question: 'What is the purpose of bonding and grounding?', options: ['Increase temperature', 'Control electrostatic charge accumulation', 'Improve paint', 'Increase pump pressure'], correctAnswer: 1, explanation: 'Bonding reduces potential differences; grounding provides a path for charge dissipation.', application: 'Verify approved connections before transfer.'),
  OilGasQuestion(id: 37, topic: 'Fire & Explosion', question: 'Which extinguisher is commonly suitable for an appropriate energized electrical fire?', options: ['Water jet', 'CO2', 'Unapproved foam', 'Water bucket'], correctAnswer: 1, explanation: 'CO2 is non-conductive and used for suitable electrical fires.', application: 'Isolate power when safe and act within training.'),
  OilGasQuestion(id: 38, topic: 'Fire & Explosion', question: 'What does BLEVE stand for?', options: ['Boiling Liquid Expanding Vapour Explosion', 'Basic Liquid Emergency Ventilation Equipment', 'Burning Liquid Electrical Valve Equipment', 'Boiler Leakage Emergency Event'], correctAnswer: 0, explanation: 'BLEVE involves rupture of a pressurized vessel containing liquid above its atmospheric boiling point.', application: 'Fire exposure to LPG vessels requires emergency escalation and evacuation.'),
  OilGasQuestion(id: 39, topic: 'Fire & Explosion', question: 'What is the purpose of a flame detector?', options: ['Attendance', 'Detect flame radiation and initiate configured protection actions', 'Measure humidity', 'Detect vibration'], correctAnswer: 1, explanation: 'Flame detectors identify characteristic radiation and may activate alarms or protection logic.', application: 'Maintain detector health and coverage.'),
  OilGasQuestion(id: 40, topic: 'Fire & Explosion', question: 'What should workers do when a fire alarm sounds?', options: ['Continue working', 'Investigate alone', 'Evacuate to designated safe area', 'Hide inside equipment'], correctAnswer: 2, explanation: 'Prompt evacuation and accountability reduce exposure.', application: 'Follow alarm instructions and emergency team directions.'),
  OilGasQuestion(id: 41, topic: 'LOTO & Electrical', question: 'What is the primary purpose of LOTO?', options: ['Increase production', 'Prevent unexpected energization or hazardous energy release', 'Improve appearance', 'Replace maintenance'], correctAnswer: 1, explanation: 'LOTO isolates hazardous energy during servicing.', application: 'Identify, isolate, lock, tag, release stored energy and verify.'),
  OilGasQuestion(id: 42, topic: 'LOTO & Electrical', question: 'What does LOTOTO mean?', options: ['Lock Out, Tag Out, Try Out', 'Lift Out, Turn Off, Test Out', 'Lock On, Tag On, Turn On', 'Load Out, Transfer Out, Test Out'], correctAnswer: 0, explanation: 'LOTOTO includes isolation, locking, tagging and verification.', application: 'Perform approved try-out and return controls to safe position.'),
  OilGasQuestion(id: 43, topic: 'LOTO & Electrical', question: 'What must be done before working on an isolated circuit?', options: ['Assume breaker OFF means safe', 'Verify absence of voltage with approved tester', 'Touch conductor', 'Remove warnings'], correctAnswer: 1, explanation: 'Circuits may contain backfeed, induced voltage or stored energy.', application: 'Prove tester before and after testing.'),
  OilGasQuestion(id: 44, topic: 'LOTO & Electrical', question: 'What is the purpose of protective earthing?', options: ['Increase current', 'Provide fault-current path and support protective device operation', 'Increase weight', 'Avoid inspection'], correctAnswer: 1, explanation: 'Protective earthing helps reduce dangerous touch voltages.', application: 'Inspect grounding connections and integrity.'),
  OilGasQuestion(id: 45, topic: 'LOTO & Electrical', question: 'What is a major hazard of damaged insulation on an energized cable?', options: ['Approved enclosure', 'Shock, short circuit, arcing and ignition', 'Proper cable tray', 'Correct rating'], correctAnswer: 1, explanation: 'Damaged insulation may expose live conductors.', application: 'Stop use, isolate safely and report for repair.'),
  OilGasQuestion(id: 46, topic: 'LOTO & Electrical', question: 'What is the purpose of intrinsically safe equipment?', options: ['Produce larger sparks', 'Limit energy to prevent ignition under approved conditions', 'Avoid inspection', 'Increase gas concentration'], correctAnswer: 1, explanation: 'Intrinsic safety limits electrical and thermal energy in hazardous atmospheres.', application: 'Verify certification and hazardous-area suitability.'),
  OilGasQuestion(id: 47, topic: 'LOTO & Electrical', question: 'What should happen if a portable tool has a damaged cable?', options: ['Continue carefully', 'Use ordinary tape', 'Remove from service and report', 'Use only daytime'], correctAnswer: 2, explanation: 'Damaged cables can cause shock, fire or ignition.', application: 'Use inspected and approved equipment.'),
  OilGasQuestion(id: 48, topic: 'LOTO & Electrical', question: 'What is the purpose of an RCD?', options: ['Increase motor speed', 'Detect residual current imbalance and disconnect', 'Measure gas', 'Replace all protection'], correctAnswer: 1, explanation: 'RCDs provide additional protection against certain leakage-current and shock hazards.', application: 'Use correct type and test as required.'),
  OilGasQuestion(id: 49, topic: 'LOTO & Electrical', question: 'Who should perform industrial electrical isolation?', options: ['Any worker', 'Authorized competent electrical personnel', 'Visitors', 'Security guards'], correctAnswer: 1, explanation: 'Electrical switching requires authorization and competency.', application: 'Confirm switching authority and isolation boundaries.'),
  OilGasQuestion(id: 50, topic: 'LOTO & Electrical', question: 'What is the safest response to an electrical arc flash?', options: ['Approach equipment', 'Raise alarm and maintain safe distance', 'Pour water on energized equipment', 'Remove PPE'], correctAnswer: 1, explanation: 'Arc flash can cause severe burns, pressure effects and debris.', application: 'Follow emergency isolation and response procedures.'),
  OilGasQuestion(id: 51, topic: 'Working at Height', question: 'What is the primary hazard of working at height?', options: ['Noise', 'Fall from height', 'Poor handwriting', 'Material shortage'], correctAnswer: 1, explanation: 'Falls can result in serious injury or fatality.', application: 'Prioritize elimination, safe platforms and fall protection.'),
  OilGasQuestion(id: 52, topic: 'Working at Height', question: 'What is the preferred first control for work at height?', options: ['Harness in every situation', 'Avoid work at height where reasonably practicable', 'Ordinary chair', 'Remove edge protection'], correctAnswer: 1, explanation: 'The hierarchy prioritizes eliminating exposure.', application: 'Consider ground-level assembly or remote methods.'),
  OilGasQuestion(id: 53, topic: 'Working at Height', question: 'What is the purpose of a full-body harness?', options: ['Walking support', 'Distribute fall-arrest forces across suitable body areas', 'Replace anchor', 'Prevent every injury'], correctAnswer: 1, explanation: 'A harness is part of a personal fall-arrest system.', application: 'Use compatible connectors, anchorage and rescue arrangements.'),
  OilGasQuestion(id: 54, topic: 'Working at Height', question: 'What is the purpose of fall-arrest anchorage?', options: ['Hold tools only', 'Provide suitable attachment point', 'Support lighting', 'Replace scaffold inspection'], correctAnswer: 1, explanation: 'Anchorage must be suitable for the intended system.', application: 'Never attach to unverified pipes or handrails.'),
  OilGasQuestion(id: 55, topic: 'Working at Height', question: 'What does 100% tie-off mean?', options: ['Harness without connection', 'Continuous attachment to approved fall protection', 'Tie to vehicle', 'Carry two harnesses'], correctAnswer: 1, explanation: 'Continuous protection prevents unprotected exposure during transitions.', application: 'Use approved twin-leg or other suitable systems.'),
  OilGasQuestion(id: 56, topic: 'Working at Height', question: 'What is the main danger of dropped objects?', options: ['Noise only', 'Serious injury or fatality to people below', 'Improved housekeeping', 'Reduced lifting risk'], correctAnswer: 1, explanation: 'Falling objects carry impact energy.', application: 'Secure tools and establish exclusion zones.'),
  OilGasQuestion(id: 57, topic: 'Working at Height', question: 'What must be checked before using a MEWP?', options: ['Paint colour', 'Inspection, ground, operator competency and hazards', 'Fuel only', 'Uniform only'], correctAnswer: 1, explanation: 'MEWP hazards include overturning, entrapment and collision.', application: 'Check emergency lowering and overhead hazards.'),
  OilGasQuestion(id: 58, topic: 'Working at Height', question: 'What is the purpose of scaffold tagging?', options: ['Decoration', 'Communicate inspection and permitted-use status', 'Replace design', 'Authorize unlimited loading'], correctAnswer: 1, explanation: 'Tags communicate scaffold status under the site system.', application: 'Do not use incomplete or restricted scaffolds.'),
  OilGasQuestion(id: 59, topic: 'Working at Height', question: 'What should happen when wind or lightning makes elevated work unsafe?', options: ['Continue quickly', 'Stop and follow weather suspension procedure', 'Remove guardrails', 'Climb higher'], correctAnswer: 1, explanation: 'Weather can increase fall and loss-of-control hazards.', application: 'Follow approved environmental limits.'),
  OilGasQuestion(id: 60, topic: 'Working at Height', question: 'Why is a fall rescue plan required?', options: ['Harness eliminates all risk', 'Suspended workers may require prompt rescue', 'Replace alarm', 'Avoid inspection'], correctAnswer: 1, explanation: 'Suspension can cause serious medical effects.', application: 'Provide trained rescuers, equipment and recovery method.'),
  OilGasQuestion(id: 61, topic: 'Lifting & Rigging', question: 'What is the primary purpose of a lifting plan?', options: ['Increase crane speed', 'Define safe lifting arrangements, equipment and hazards', 'Replace certification', 'Remove competency'], correctAnswer: 1, explanation: 'A plan considers load, crane capacity, radius, rigging and ground conditions.', application: 'Review approved plan before critical lifts.'),
  OilGasQuestion(id: 62, topic: 'Lifting & Rigging', question: 'What does SWL mean?', options: ['Safe Working Load', 'Standard Work Location', 'Safety Warning Level', 'Structural Weight Limit'], correctAnswer: 0, explanation: 'SWL identifies permitted working load under specified conditions.', application: 'Never exceed rated equipment capacity.'),
  OilGasQuestion(id: 63, topic: 'Lifting & Rigging', question: 'Who directs crane movements using agreed signals?', options: ['Any worker', 'Authorized competent signaler or banksman', 'Visitor', 'Storekeeper'], correctAnswer: 1, explanation: 'A competent signaler coordinates movements with the operator.', application: 'Stop if communication is lost.'),
  OilGasQuestion(id: 64, topic: 'Lifting & Rigging', question: 'What is the main hazard of standing under a suspended load?', options: ['Noise', 'Struck-by or crushing injury', 'Sun exposure only', 'Housekeeping'], correctAnswer: 1, explanation: 'Loads may swing, shift or fall.', application: 'Establish exclusion zones.'),
  OilGasQuestion(id: 65, topic: 'Lifting & Rigging', question: 'What must be checked before using a sling?', options: ['Colour only', 'Identification, capacity, condition and suitability', 'Length only', 'Logo only'], correctAnswer: 1, explanation: 'Slings may fail due to damage, heat, chemicals or overload.', application: 'Inspect before use and remove defects from service.'),
  OilGasQuestion(id: 66, topic: 'Lifting & Rigging', question: 'What is the purpose of a tag line?', options: ['Increase load weight', 'Help control load movement from safe position', 'Replace sling', 'Lift personnel'], correctAnswer: 1, explanation: 'Tag lines can control rotation but introduce entanglement hazards.', application: 'Never wrap a tag line around the body.'),
  OilGasQuestion(id: 67, topic: 'Lifting & Rigging', question: 'What happens when sling angle decreases from the horizontal?', options: ['Tension always decreases', 'Sling-leg tension increases', 'Load weight decreases', 'Stability guaranteed'], correctAnswer: 1, explanation: 'Smaller sling angles increase tension for a given load.', application: 'Verify calculations and approved angle limits.'),
  OilGasQuestion(id: 68, topic: 'Lifting & Rigging', question: 'What must be verified before mobile crane setup?', options: ['Ground bearing capacity and outrigger support', 'Uniform only', 'Crane colour', 'Fuel only'], correctAnswer: 0, explanation: 'Weak ground may cause settlement or overturning.', application: 'Verify ground assessment and suitable mats.'),
  OilGasQuestion(id: 69, topic: 'Lifting & Rigging', question: 'What should happen if a lifting accessory has no readable capacity identification?', options: ['Use for light loads', 'Use under observation', 'Remove from service pending verification', 'Paint new rating'], correctAnswer: 2, explanation: 'Capacity cannot be reliably confirmed without traceable identification.', application: 'Quarantine and replace or formally verify.'),
  OilGasQuestion(id: 70, topic: 'Lifting & Rigging', question: 'What should happen if a load swings uncontrollably?', options: ['Stand beneath', 'Stop lift and keep personnel clear', 'Pull by hand', 'Increase speed'], correctAnswer: 1, explanation: 'Uncontrolled movement creates collision and crushing hazards.', application: 'Resume only after the cause is controlled.'),
  OilGasQuestion(id: 71, topic: 'Emergency & Rescue', question: 'What is the first priority during an emergency?', options: ['Protect equipment', 'Protect life and prevent further injury', 'Complete paperwork', 'Continue production'], correctAnswer: 1, explanation: 'Emergency response prioritizes life safety and preventing escalation.', application: 'Raise alarm, evacuate and follow emergency plan.'),
  OilGasQuestion(id: 72, topic: 'Emergency & Rescue', question: 'What is the purpose of a muster point?', options: ['Equipment storage', 'Personnel assembly and accountability', 'Vehicle repair', 'Waste disposal'], correctAnswer: 1, explanation: 'Muster points support headcounts and communication.', application: 'Report and remain available for accountability.'),
  OilGasQuestion(id: 73, topic: 'Emergency & Rescue', question: 'What should you do after discovering a gas leak?', options: ['Create ignition source', 'Raise alarm and follow emergency procedure', 'Search with flame', 'Continue work'], correctAnswer: 1, explanation: 'Gas leaks can create toxic, fire and explosion hazards.', application: 'Move to safety, avoid ignition sources and report location.'),
  OilGasQuestion(id: 74, topic: 'Emergency & Rescue', question: 'What is the purpose of an Emergency Response Plan?', options: ['Routine production only', 'Define roles, actions, communication and resources', 'Replace training', 'Avoid drills'], correctAnswer: 1, explanation: 'ERP coordinates response to foreseeable emergencies.', application: 'Know alarms, routes, muster points and contacts.'),
  OilGasQuestion(id: 75, topic: 'Emergency & Rescue', question: 'What is the first action before approaching an injured person in a hazardous area?', options: ['Run directly in', 'Assess scene safety', 'Remove all PPE', 'Ignore atmosphere'], correctAnswer: 1, explanation: 'An unsafe scene can create additional casualties.', application: 'Request trained responders and control hazards first.'),
  OilGasQuestion(id: 76, topic: 'Emergency & Rescue', question: 'Why are emergency drills conducted?', options: ['Entertainment', 'Practice response and identify improvement needs', 'Replace equipment', 'Avoid reporting'], correctAnswer: 1, explanation: 'Drills test readiness, communication and procedures.', application: 'Record observations and close corrective actions.'),
  OilGasQuestion(id: 77, topic: 'Emergency & Rescue', question: 'What is the purpose of ESD during process emergencies?', options: ['Increase flow', 'Initiate defined safe shutdown actions', 'Replace muster', 'Control payroll'], correctAnswer: 1, explanation: 'ESD reduces process escalation through predetermined actions.', application: 'Follow assigned operating and emergency roles.'),
  OilGasQuestion(id: 78, topic: 'Emergency & Rescue', question: 'What should workers do if an evacuation route is blocked?', options: ['Force through hazard', 'Use designated alternate route and communicate', 'Hide in process area', 'Return to work'], correctAnswer: 1, explanation: 'Alternate routes help avoid exposure to the emergency.', application: 'Follow site evacuation maps and instructions.'),
  OilGasQuestion(id: 79, topic: 'Emergency & Rescue', question: 'What is the purpose of personnel accountability after evacuation?', options: ['Count equipment', 'Identify missing or unaccounted personnel', 'Restart production', 'Close permits only'], correctAnswer: 1, explanation: 'Accountability helps emergency command identify potential rescue needs.', application: 'Report missing persons to incident controller.'),
  OilGasQuestion(id: 80, topic: 'Emergency & Rescue', question: 'Who should authorize restart after a major emergency?', options: ['Any worker', 'Authorized management or incident command under procedure', 'Visitor', 'Delivery driver'], correctAnswer: 1, explanation: 'Restart requires confirmation that hazards are controlled and systems are safe.', application: 'Complete investigation, inspection and formal clearance.'),
  OilGasQuestion(id: 81, topic: 'Risk Assessment & JSA', question: 'What is a risk assessment?', options: ['Attendance list', 'Process of identifying hazards and evaluating risks', 'Purchase order', 'Work schedule only'], correctAnswer: 1, explanation: 'Risk assessment evaluates likelihood and consequence and determines controls.', application: 'Review before work and when conditions change.'),
  OilGasQuestion(id: 82, topic: 'Risk Assessment & JSA', question: 'What is a hazard?', options: ['A source or situation with potential to cause harm', 'A completed permit', 'A salary issue', 'A safe condition'], correctAnswer: 0, explanation: 'Hazards can cause injury, illness, damage or environmental harm.', application: 'Identify energy sources, substances, equipment and work conditions.'),
  OilGasQuestion(id: 83, topic: 'Risk Assessment & JSA', question: 'What is risk commonly evaluated from?', options: ['Colour and size', 'Likelihood and consequence', 'Worker age only', 'Cost only'], correctAnswer: 1, explanation: 'Risk evaluation commonly considers likelihood and severity.', application: 'Use the approved site risk matrix.'),
  OilGasQuestion(id: 84, topic: 'Risk Assessment & JSA', question: 'Which is the highest level in the hierarchy of controls?', options: ['PPE', 'Administrative control', 'Elimination', 'Warning sign'], correctAnswer: 2, explanation: 'Elimination removes the hazard rather than relying on worker behaviour.', application: 'Consider eliminating hazardous tasks or exposure.'),
  OilGasQuestion(id: 85, topic: 'Risk Assessment & JSA', question: 'What is a JSA?', options: ['Job Safety Analysis', 'Job Salary Approval', 'Joint Site Attendance', 'Job Supply Agreement'], correctAnswer: 0, explanation: 'JSA analyzes task steps, hazards and controls.', application: 'Use it during planning and toolbox briefings.'),
  OilGasQuestion(id: 86, topic: 'Risk Assessment & JSA', question: 'When should a risk assessment be reviewed?', options: ['Never', 'When scope, conditions or hazards change', 'Only annually regardless of change', 'After closure only'], correctAnswer: 1, explanation: 'Changes may introduce new or increased risks.', application: 'Reassess before restarting changed work.'),
  OilGasQuestion(id: 87, topic: 'Risk Assessment & JSA', question: 'What is residual risk?', options: ['Risk before controls', 'Risk remaining after controls', 'No hazard ever', 'Equipment price'], correctAnswer: 1, explanation: 'Residual risk remains after control measures are applied.', application: 'Confirm it is acceptable under approved criteria.'),
  OilGasQuestion(id: 88, topic: 'Risk Assessment & JSA', question: 'What is dynamic risk assessment?', options: ['One-time annual audit', 'Continuous assessment of changing work conditions', 'Payroll calculation', 'Equipment purchase'], correctAnswer: 1, explanation: 'Dynamic assessment responds to immediate changes and emerging hazards.', application: 'Stop and reassess when conditions change.'),
  OilGasQuestion(id: 89, topic: 'Risk Assessment & JSA', question: 'What is a near miss?', options: ['An event that could have caused harm but did not', 'Only a fatality', 'A planned task', 'A routine meeting'], correctAnswer: 0, explanation: 'Near misses reveal weaknesses before injury or damage occurs.', application: 'Report, investigate and implement corrective actions.'),
  OilGasQuestion(id: 90, topic: 'Risk Assessment & JSA', question: 'What does Stop Work Authority mean?', options: ['Only manager can stop work', 'Workers can stop unsafe work under site policy', 'Stop only after injury', 'Ignore changing conditions'], correctAnswer: 1, explanation: 'Stop Work Authority empowers intervention when unsafe conditions arise.', application: 'Stop, make safe, report and restart only after clearance.'),
  OilGasQuestion(id: 91, topic: 'Practical Site Scenarios', question: 'During hot work, LEL readings begin rising. What should you do?', options: ['Continue welding', 'Stop work, make safe and evacuate as required', 'Ignore detector', 'Increase welding speed'], correctAnswer: 1, explanation: 'Rising flammable gas readings may indicate loss of safe conditions.', application: 'Stop ignition sources if safe, raise alarm and follow permit procedure.'),
  OilGasQuestion(id: 92, topic: 'Practical Site Scenarios', question: 'You see an unauthorized person entering a confined space. What is your action?', options: ['Allow entry', 'Stop entry and alert responsible personnel', 'Ignore', 'Close the hatch'], correctAnswer: 1, explanation: 'Unauthorized entry bypasses required controls.', application: 'Prevent entry and verify permit, isolation and attendant arrangements.'),
  OilGasQuestion(id: 93, topic: 'Practical Site Scenarios', question: 'A worker’s H2S detector fails its bump test. What should happen?', options: ['Use anyway', 'Remove from service and provide a verified detector', 'Silence alarm', 'Share without checking'], correctAnswer: 1, explanation: 'A failed detector cannot be relied upon for warning.', application: 'Quarantine it and follow equipment replacement procedure.'),
  OilGasQuestion(id: 94, topic: 'Practical Site Scenarios', question: 'A crane is planned near an overhead power line. What is required?', options: ['Proceed slowly', 'Stop and obtain approved electrical clearance and lift controls', 'Touch the line', 'Ignore hazard'], correctAnswer: 1, explanation: 'Crane contact or approach can cause fatal electrocution and arcing.', application: 'Establish safe distances, isolation where feasible and approved controls.'),
  OilGasQuestion(id: 95, topic: 'Practical Site Scenarios', question: 'Oil leaks onto a hot surface. What is the immediate concern?', options: ['Housekeeping only', 'Fire or ignition escalation', 'Reduced noise', 'Improved cooling'], correctAnswer: 1, explanation: 'Hydrocarbon leakage near hot surfaces may ignite.', application: 'Raise alarm, isolate source if safe and follow spill/fire response.'),
  OilGasQuestion(id: 96, topic: 'Practical Site Scenarios', question: 'A worker is suspended in a fall-arrest harness. What should happen?', options: ['Wait until shift ends', 'Activate rescue plan promptly', 'Cut the harness', 'Leave worker alone'], correctAnswer: 1, explanation: 'Suspension can cause serious medical effects.', application: 'Use trained rescuers and approved rescue equipment.'),
  OilGasQuestion(id: 97, topic: 'Practical Site Scenarios', question: 'A pump unexpectedly starts during maintenance. What control may have failed?', options: ['Housekeeping', 'Energy isolation and verification', 'Attendance', 'Lighting'], correctAnswer: 1, explanation: 'Unexpected startup indicates hazardous energy control failure.', application: 'Stop work, secure area and investigate isolation integrity.'),
  OilGasQuestion(id: 98, topic: 'Practical Site Scenarios', question: 'A worker feels dizzy near a suspected gas release. What should you do?', options: ['Approach unprotected', 'Raise alarm and evacuate to safe area', 'Give water inside release zone', 'Continue task'], correctAnswer: 1, explanation: 'Dizziness may indicate toxic exposure or oxygen deficiency.', application: 'Do not enter without trained response capability.'),
  OilGasQuestion(id: 99, topic: 'Practical Site Scenarios', question: 'Hot work and hydrocarbon transfer are planned in the same area. What is required?', options: ['Proceed independently', 'SIMOPS review and authorization', 'Ignore interface', 'Remove fire watch'], correctAnswer: 1, explanation: 'Concurrent activities can create ignition and release interactions.', application: 'Coordinate operations and establish approved controls.'),
  OilGasQuestion(id: 100, topic: 'Practical Site Scenarios', question: 'A critical safety barrier is unavailable during a task. What should happen?', options: ['Continue regardless', 'Stop work and reassess authorization and risk', 'Hide defect', 'Wait for incident'], correctAnswer: 1, explanation: 'A failed critical barrier may invalidate the safety basis for work.', application: 'Report, implement approved compensating measures and obtain formal clearance.'),

];

class OilGasSafetyQuizPage extends StatefulWidget {
  const OilGasSafetyQuizPage({super.key});

  @override
  State<OilGasSafetyQuizPage> createState() => _OilGasSafetyQuizPageState();
}

class _OilGasSafetyQuizPageState extends State<OilGasSafetyQuizPage> {
  int currentIndex = 0;
  int score = 0;
  bool answered = false;
  bool finished = false;
  bool reviewMode = false;
  final Map<int, int> selectedAnswers = {};
  List<int> reviewIndices = [];
  int reviewPosition = 0;

  OilGasQuestion get currentQuestion => oilGasQuestions[currentIndex];
  int get wrongCount => selectedAnswers.entries.where(
    (e) => oilGasQuestions[e.key].correctAnswer != e.value,
  ).length;
  double get percentage => score.toDouble();

  void selectAnswer(int index) {
    if (answered || finished) return;
    setState(() {
      selectedAnswers[currentIndex] = index;
      answered = true;
      if (index == currentQuestion.correctAnswer) score++;
    });
  }

  void nextQuestion() {
    if (reviewMode) {
      if (reviewPosition + 1 < reviewIndices.length) {
        setState(() {
          reviewPosition++;
          currentIndex = reviewIndices[reviewPosition];
          answered = true;
        });
      } else {
        setState(() => finished = true);
      }
      return;
    }
    if (currentIndex < oilGasQuestions.length - 1) {
      setState(() {
        currentIndex++;
        answered = false;
      });
    } else {
      setState(() => finished = true);
    }
  }

  void restartQuiz() {
    setState(() {
      currentIndex = 0;
      score = 0;
      answered = false;
      finished = false;
      reviewMode = false;
      reviewIndices = [];
      reviewPosition = 0;
      selectedAnswers.clear();
    });
  }

  void reviewWrongAnswers() {
    reviewIndices = selectedAnswers.entries
        .where((e) => oilGasQuestions[e.key].correctAnswer != e.value)
        .map((e) => e.key).toList()..sort();
    if (reviewIndices.isEmpty) return;
    setState(() {
      reviewMode = true;
      finished = false;
      reviewPosition = 0;
      currentIndex = reviewIndices.first;
      answered = true;
    });
  }

  Color optionColor(int index) {
    if (!answered) return Colors.white;
    if (index == currentQuestion.correctAnswer) return Colors.green.shade100;
    if (selectedAnswers[currentIndex] == index) return Colors.red.shade100;
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    if (finished) return _buildResult();
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F5),
      appBar: AppBar(
        title: Text(reviewMode ? 'Review Wrong Answers' : 'Oil & Gas Safety Quiz'),
        backgroundColor: const Color(0xFF075E46),
        foregroundColor: Colors.white,
        actions: [IconButton(onPressed: restartQuiz, icon: const Icon(Icons.refresh))],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildProgress(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(currentQuestion.question,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.28)),
                    const SizedBox(height: 14),
                    ...List.generate(4, (index) {
                      final correct = index == currentQuestion.correctAnswer;
                      final selected = selectedAnswers[currentIndex] == index;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 9),
                        child: InkWell(
                          onTap: () => selectAnswer(index),
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                            decoration: BoxDecoration(
                              color: optionColor(index),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: answered && correct ? Colors.green :
                                  answered && selected ? Colors.red : Colors.grey.shade300,
                                width: 1.5,
                              ),
                            ),
                            child: Row(children: [
                              CircleAvatar(
                                backgroundColor: const Color(0xFF075E46),
                                child: Text(String.fromCharCode(65 + index),
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(width: 9),
                              Expanded(
                                child: Text(
                                  currentQuestion.options[index],
                                  style: const TextStyle(fontSize: 15.5, height: 1.2),
                                ),
                              ),
                              if (answered && correct) const Icon(Icons.check_circle, color: Colors.green),
                              if (answered && selected && !correct) const Icon(Icons.cancel, color: Colors.red),
                            ]),
                          ),
                        ),
                      );
                    }),
                    if (answered) ...[
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(
                            selectedAnswers[currentIndex] == currentQuestion.correctAnswer
                                ? '✓ Correct Answer' : '✗ Incorrect Answer',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17,
                              color: selectedAnswers[currentIndex] == currentQuestion.correctAnswer
                                  ? Colors.green.shade800 : Colors.red.shade800),
                          ),
                          const SizedBox(height: 10),
                          const Text('Technical Explanation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          const SizedBox(height: 5),
                          Text(currentQuestion.explanation, style: const TextStyle(fontSize: 14, height: 1.25)),
                          const SizedBox(height: 12),
                          const Text('Practical Site Application', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          const SizedBox(height: 5),
                          Text(currentQuestion.application, style: const TextStyle(fontSize: 14, height: 1.25)),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: nextQuestion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF075E46),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(reviewMode
                              ? (reviewPosition + 1 == reviewIndices.length ? 'Finish Review' : 'Next Wrong Answer')
                              : (currentIndex == 99 ? 'View Final Result' : 'Next Question →')),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgress() => Container(
    padding: const EdgeInsets.all(16),
    color: Colors.white,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(reviewMode ? 'Review Progress' : 'Progress: ${currentIndex + 1} / 100',
          style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('Score: $score', style: const TextStyle(color: Color(0xFF075E46), fontWeight: FontWeight.bold)),
      ]),
      const SizedBox(height: 10),
      LinearProgressIndicator(
        value: reviewMode ? (reviewPosition + 1) / reviewIndices.length : (currentIndex + 1) / 100,
        minHeight: 8,
        backgroundColor: Colors.grey.shade200,
        color: const Color(0xFF16A34A),
        borderRadius: BorderRadius.circular(10),
      ),
    ]),
  );

  Widget _buildResult() {
    final passed = score >= 70;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F5),
      appBar: AppBar(
        title: const Text('Quiz Result'),
        backgroundColor: const Color(0xFF075E46),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(children: [
              Icon(passed ? Icons.emoji_events : Icons.school,
                size: 90, color: passed ? Colors.amber : Colors.orange),
              const SizedBox(height: 20),
              Text(passed ? 'Congratulations!' : 'Keep Learning!',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text('$score / 100', style: const TextStyle(fontSize: 52,
                fontWeight: FontWeight.bold, color: Color(0xFF075E46))),
              Text('${score}%', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: passed ? Colors.green.shade100 : Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(passed ? 'PASS – 70% Threshold' : 'NEEDS IMPROVEMENT',
                  style: TextStyle(fontWeight: FontWeight.bold,
                    color: passed ? Colors.green.shade900 : Colors.orange.shade900)),
              ),
              const SizedBox(height: 24),
              _resultRow('Total Questions', '100'),
              _resultRow('Correct Answers', '$score'),
              _resultRow('Wrong Answers', '$wrongCount'),
              _resultRow('Pass Mark', '70%'),
              const SizedBox(height: 28),
              SizedBox(width: double.infinity, child: ElevatedButton.icon(
                onPressed: restartQuiz,
                icon: const Icon(Icons.refresh),
                label: const Text('Retake Quiz'),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF075E46),
                  foregroundColor: Colors.white, padding: const EdgeInsets.all(16)),
              )),
              const SizedBox(height: 12),
              if (wrongCount > 0)
                SizedBox(width: double.infinity, child: OutlinedButton.icon(
                  onPressed: reviewWrongAnswers,
                  icon: const Icon(Icons.menu_book),
                  label: Text('Review Wrong Answers ($wrongCount)'),
                )),
              const SizedBox(height: 12),
              TextButton(onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('Back to Interview Levels')),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _resultRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label), Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
    ]),
  );
}
