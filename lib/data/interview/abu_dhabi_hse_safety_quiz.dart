import 'package:flutter/material.dart';

class AbuDhabiHseQuestion {
  final int id; final String topic; final String question; final List<String> options;
  final int correctAnswer; final String explanation; final String siteExample;
  const AbuDhabiHseQuestion({required this.id, required this.topic, required this.question,
    required this.options, required this.correctAnswer, required this.explanation, required this.siteExample});
}

const List<AbuDhabiHseQuestion> abuDhabiHse150Questions = [
  AbuDhabiHseQuestion(
    id: 1, topic: 'Abu Dhabi CoP / ADPHC / OSHAD-SF',
    question: 'What is the purpose of an HSE management system?',
    options: ['To document attendance only', 'To systematically manage hazards, risks and continual improvement', 'To replace supervision', 'To guarantee zero incidents'],
    correctAnswer: 1,
    explanation: 'An HSE management system establishes policy, responsibilities, planning, implementation, monitoring and improvement. It supports legal and project compliance but cannot guarantee that incidents never occur.',
    siteExample: 'At an Abu Dhabi project, the HSE plan assigns responsibilities, sets inspection and training processes, tracks corrective actions and reviews performance.',
  ),
  AbuDhabiHseQuestion(
    id: 2, topic: 'Abu Dhabi CoP / ADPHC / OSHAD-SF',
    question: 'What should a site team do when a project rule conflicts with a legal requirement?',
    options: ['Follow whichever is easier', 'Follow the less restrictive rule', 'Escalate and comply with applicable legal requirements', 'Ignore both'],
    correctAnswer: 2,
    explanation: 'Project procedures must not reduce applicable legal duties. Resolve conflicts through the responsible HSE and management channels before work proceeds.',
    siteExample: 'A supervisor finds a project checklist omits a legally required control and escalates it for correction before authorizing the task.',
  ),
  AbuDhabiHseQuestion(
    id: 3, topic: 'Abu Dhabi CoP / ADPHC / OSHAD-SF',
    question: 'What is the purpose of a Code of Practice (CoP)?',
    options: ['A method for recording payroll', 'A technical framework describing recognized safety requirements and controls', 'A substitute for competent workers', 'A permit to start any job'],
    correctAnswer: 1,
    explanation: 'A CoP provides structured requirements or guidance for managing a defined risk. Applicability and current official versions must be checked.',
    siteExample: 'Before scaffolding work, the HSE team checks the applicable current authority and project requirements rather than relying on an old copied checklist.',
  ),
  AbuDhabiHseQuestion(
    id: 4, topic: 'Abu Dhabi CoP / ADPHC / OSHAD-SF',
    question: 'Who should verify that a worker is competent for a high-risk task?',
    options: ['Any coworker', 'A responsible employer or authorized person using suitable evidence', 'Only the worker', 'A visitor'],
    correctAnswer: 1,
    explanation: 'Competence is task-specific and should be supported by suitable training, knowledge, experience, assessment and authorization where required.',
    siteExample: 'Before assigning a MEWP operator, the supervisor verifies training, practical competence, familiarization and site authorization.',
  ),
  AbuDhabiHseQuestion(
    id: 5, topic: 'Abu Dhabi CoP / ADPHC / OSHAD-SF',
    question: 'What is the main purpose of an HSE inspection?',
    options: ['Find someone to blame', 'Identify unsafe conditions and verify controls are effective', 'Replace risk assessment', 'Approve all work automatically'],
    correctAnswer: 1,
    explanation: 'Inspections provide a planned check of workplace conditions, equipment and control implementation. Findings need owners, deadlines and follow-up.',
    siteExample: 'A weekly site inspection identifies an unprotected opening; the team barricades it immediately and tracks permanent guarding to closure.',
  ),
  AbuDhabiHseQuestion(
    id: 6, topic: 'Abu Dhabi CoP / ADPHC / OSHAD-SF',
    question: 'What should happen after a serious change in work conditions?',
    options: ['Continue under the old assessment', 'Stop or pause affected work and review risk controls', 'Wait until the end of shift', 'Remove the permit'],
    correctAnswer: 1,
    explanation: 'Changes in method, equipment, personnel, weather or surrounding work can invalidate assumptions. Reassess and reauthorize as required.',
    siteExample: 'A lifting route becomes obstructed by another contractor; the lift is paused and the plan, exclusion zone and communications are reviewed.',
  ),
  AbuDhabiHseQuestion(
    id: 7, topic: 'Abu Dhabi CoP / ADPHC / OSHAD-SF',
    question: 'Why are toolbox talks conducted?',
    options: ['To replace formal training and permits', 'To communicate task hazards, controls and changes before work', 'To record production targets only', 'To transfer all responsibility to workers'],
    correctAnswer: 1,
    explanation: 'Toolbox talks reinforce task-specific understanding and invite workers to raise concerns. They supplement, not replace, risk assessments, permits and competency.',
    siteExample: 'Before a concrete pour, the supervisor briefs the crew on hose movement, access, communication, PPE and emergency arrangements.',
  ),
  AbuDhabiHseQuestion(
    id: 8, topic: 'Abu Dhabi CoP / ADPHC / OSHAD-SF',
    question: 'What is the correct approach to an unsafe condition?',
    options: ['Walk past if it is not your task', 'Report it and take safe immediate action within your authority', 'Hide it until inspection', 'Wait for an accident'],
    correctAnswer: 1,
    explanation: 'Prompt reporting and safe intervention help prevent harm. Do not take actions beyond competence or expose yourself to additional danger.',
    siteExample: 'A worker sees a damaged extension lead, stops its use, warns others and reports it for isolation and replacement.',
  ),
  AbuDhabiHseQuestion(
    id: 9, topic: 'Abu Dhabi CoP / ADPHC / OSHAD-SF',
    question: 'What is the purpose of HSE records?',
    options: ['Create paperwork without use', 'Provide evidence of planning, implementation, monitoring and learning', 'Replace field controls', 'Guarantee legal immunity'],
    correctAnswer: 1,
    explanation: 'Accurate, controlled records help demonstrate what was planned and done, support audits and enable trend analysis. Records do not replace actual safe conditions.',
    siteExample: 'A site retains inspection, training, permit and corrective-action records so an audit can trace control implementation.',
  ),
  AbuDhabiHseQuestion(
    id: 10, topic: 'Abu Dhabi CoP / ADPHC / OSHAD-SF',
    question: 'What should an HSE officer do when unsure of an authority requirement?',
    options: ['Invent a limit', 'Check current official guidance and consult the competent responsible party', 'Use a social media post as final authority', 'Proceed without checking'],
    correctAnswer: 1,
    explanation: 'Regulatory and authority requirements can change and may be project-specific. Verify current official sources and obtain competent interpretation where needed.',
    siteExample: 'Before approving a specialized activity, the HSE officer checks the current authority requirement and project specification with the responsible manager.',
  ),
  AbuDhabiHseQuestion(
    id: 11, topic: 'Excavation',
    question: 'What must be checked before excavation starts?',
    options: ['Only the excavator fuel', 'Underground services, ground conditions, authorization and protective controls', 'Only worker attendance', 'The paint color of barriers'],
    correctAnswer: 1,
    explanation: 'Pre-start planning identifies buried utilities, soil and water conditions, adjacent loads, access, protection and emergency arrangements.',
    siteExample: 'The team reviews utility drawings, scans the area, marks services and uses controlled trial holes before machine digging.',
  ),
  AbuDhabiHseQuestion(
    id: 12, topic: 'Excavation',
    question: 'What is a key control against excavation collapse?',
    options: ['Allowing spoil at the edge', 'A suitable protective system such as shoring, shielding or safe battering based on assessment', 'Using warning tape alone', 'Standing workers below an unsupported face'],
    correctAnswer: 1,
    explanation: 'Excavation protection must be selected by competent assessment of depth, soil, water, vibration, surcharge and applicable requirements.',
    siteExample: 'A competent person selects and verifies a trench support system before workers enter the excavation.',
  ),
  AbuDhabiHseQuestion(
    id: 13, topic: 'Excavation',
    question: 'Where should excavated spoil generally be placed?',
    options: ['At the edge to save space', 'Far enough from the edge to avoid surcharge and falling material, as determined by the assessment', 'Inside the access ladder route', 'On top of protective supports'],
    correctAnswer: 1,
    explanation: 'Spoil and equipment loads near an excavation can increase collapse risk or fall into the trench. Follow engineered and site-specific setback requirements.',
    siteExample: 'The excavator operator places spoil in the designated area outside the assessed exclusion distance.',
  ),
  AbuDhabiHseQuestion(
    id: 14, topic: 'Excavation',
    question: 'What is required for safe access into a trench?',
    options: ['Climb on bracing', 'Provide suitable secured access such as a ladder or designed stairway', 'Jump into the trench', 'Use an excavator bucket'],
    correctAnswer: 1,
    explanation: 'Safe access and egress must be provided, maintained and positioned so workers can exit promptly.',
    siteExample: 'A secured ladder is installed at the planned location and kept clear of stored materials.',
  ),
  AbuDhabiHseQuestion(
    id: 15, topic: 'Excavation',
    question: 'When should an excavation be re-inspected?',
    options: ['Only once at project start', 'At required intervals and after events such as rain, vibration, ground change or alteration', 'Only after an injury', 'Never if barricaded'],
    correctAnswer: 1,
    explanation: 'Ground and support conditions can change. Competent inspections are needed at prescribed stages and after conditions that may affect stability.',
    siteExample: 'After heavy rain, the competent person checks water accumulation, wall condition, support and access before re-entry.',
  ),
  AbuDhabiHseQuestion(
    id: 16, topic: 'Excavation',
    question: 'What should be done if an underground cable is exposed unexpectedly?',
    options: ['Pull it clear', 'Stop work, keep people clear, protect the area and notify the responsible utility/site authority', 'Cut it if in the way', 'Cover it and continue'],
    correctAnswer: 1,
    explanation: 'Unexpected services may be live or damaged. Stop, isolate the area and follow the approved utility emergency and verification process.',
    siteExample: 'The excavation crew stops machinery, establishes a safe exclusion area and contacts the utility coordinator.',
  ),
  AbuDhabiHseQuestion(
    id: 17, topic: 'Excavation',
    question: 'Why is water accumulation hazardous in an excavation?',
    options: ['It always strengthens soil', 'It can destabilize ground, conceal hazards and create drowning or access risks', 'It removes the need for support', 'It makes ladders unnecessary'],
    correctAnswer: 1,
    explanation: 'Water can weaken soil, undermine support and obscure conditions. Pumping and discharge must be planned and monitored.',
    siteExample: 'After seepage is observed, workers leave the trench while the team reassesses stability and implements controlled dewatering.',
  ),
  AbuDhabiHseQuestion(
    id: 18, topic: 'Excavation',
    question: 'What is the safest response to signs of excavation movement?',
    options: ['Continue quickly', 'Evacuate the affected area and have a competent person reassess before re-entry', 'Add workers to hold the wall', 'Remove supports'],
    correctAnswer: 1,
    explanation: 'Cracking, bulging, falling soil or support movement may indicate imminent failure. Keep people clear and obtain competent assessment.',
    siteExample: 'Workers withdraw after noticing cracking near the trench edge; the area is isolated pending engineering review.',
  ),
  AbuDhabiHseQuestion(
    id: 19, topic: 'Scaffolding',
    question: 'Who should erect, alter or dismantle scaffolding?',
    options: ['Any available worker', 'Trained and competent scaffold personnel under appropriate supervision', 'Visitors', 'A worker who has watched once'],
    correctAnswer: 1,
    explanation: 'Scaffold work requires task-appropriate competence, planning, supervision and compliance with the scaffold design and site system.',
    siteExample: 'A competent scaffold team erects the access tower and records inspection before release for use.',
  ),
  AbuDhabiHseQuestion(
    id: 20, topic: 'Scaffolding',
    question: 'What does a scaffold handover or inspection tag indicate?',
    options: ['A guarantee against every hazard', 'The status of inspection/release under the site system; users still check conditions', 'Permission to overload', 'That weather cannot affect it'],
    correctAnswer: 1,
    explanation: 'Tags communicate inspection status but do not replace user awareness or required inspections after changes or adverse events.',
    siteExample: 'A worker checks the tag and reports a missing toe board rather than assuming the tag overrides visible defects.',
  ),
  AbuDhabiHseQuestion(
    id: 21, topic: 'Scaffolding',
    question: 'Why are guardrails and toe boards installed?',
    options: ['For decoration', 'To reduce fall and falling-object risks at exposed edges', 'To increase scaffold load', 'To replace access ladders'],
    correctAnswer: 1,
    explanation: 'Edge protection helps prevent people and materials falling from working platforms. Requirements depend on design and applicable rules.',
    siteExample: 'A platform is fitted with complete edge protection before workers carry out façade work.',
  ),
  AbuDhabiHseQuestion(
    id: 22, topic: 'Scaffolding',
    question: 'What should be done if a scaffold is visibly damaged?',
    options: ['Use it carefully', 'Prevent use, report it and have a competent person assess and repair/reinspect it', 'Hide the damage', 'Remove one brace'],
    correctAnswer: 1,
    explanation: 'Damage, unauthorized alteration or instability means the scaffold may no longer be safe. It must be controlled and reassessed.',
    siteExample: 'A bent standard is found; the scaffold is isolated until the competent scaffold team repairs and releases it.',
  ),
  AbuDhabiHseQuestion(
    id: 23, topic: 'Scaffolding',
    question: 'How should scaffold loading be managed?',
    options: ['Store unlimited blocks', 'Keep within the designed duty/load class and distribute materials as planned', 'Load only one side heavily', 'Use guardrails as storage racks'],
    correctAnswer: 1,
    explanation: 'Excess loading or uneven distribution can cause failure. Follow design capacity, platform rating and material-stacking controls.',
    siteExample: 'The supervisor limits masonry units on the platform to the approved load and keeps access routes clear.',
  ),
  AbuDhabiHseQuestion(
    id: 24, topic: 'Scaffolding',
    question: 'What is the safe way to access a scaffold platform?',
    options: ['Climb cross-braces', 'Use the designed ladder, stair tower or approved access system', 'Climb outside standards', 'Use a crane hook'],
    correctAnswer: 1,
    explanation: 'Designed access prevents falls and avoids damaging scaffold components.',
    siteExample: 'Workers use the internal stair tower instead of climbing the frame.',
  ),
  AbuDhabiHseQuestion(
    id: 25, topic: 'Scaffolding',
    question: 'When is a scaffold inspection especially important?',
    options: ['After alteration or an event that may affect stability', 'Only at lunch', 'Only when a client visits', 'Never after handover'],
    correctAnswer: 0,
    explanation: 'Alteration, impact, severe weather or other potentially damaging events can change scaffold condition and require competent reinspection before use.',
    siteExample: 'After a vehicle strikes a scaffold standard, the area is isolated and the scaffold is assessed before release.',
  ),
  AbuDhabiHseQuestion(
    id: 26, topic: 'Scaffolding',
    question: 'Why must scaffold ties and bracing not be removed casually?',
    options: ['They are optional', 'They provide stability and are part of the designed load path', 'They only improve appearance', 'They are replaced by workers standing nearby'],
    correctAnswer: 1,
    explanation: 'Ties and bracing resist movement and instability. Any change must be approved and controlled by a competent person/design process.',
    siteExample: 'A subcontractor requests removal of a tie; work is paused until an approved alternative support arrangement is verified.',
  ),
  AbuDhabiHseQuestion(
    id: 27, topic: 'Working at Height',
    question: 'What should be considered first when planning work at height?',
    options: ['Use a harness in every case', 'Avoid work at height where reasonably practicable, then prevent or minimize falls', 'Work faster', 'Rely on warning signs'],
    correctAnswer: 1,
    explanation: 'The hierarchy prioritizes avoiding height work, then collective prevention such as guarded platforms, followed by suitable personal systems and rescue planning.',
    siteExample: 'A light fitting is assembled at ground level before being lifted into position, reducing time spent at height.',
  ),
  AbuDhabiHseQuestion(
    id: 28, topic: 'Working at Height',
    question: 'What is the main purpose of a fall-arrest harness system?',
    options: ['Prevent all falls from occurring', 'Arrest a fall when prevention has failed, with compatible components and rescue planning', 'Replace guardrails', 'Allow unlimited free movement'],
    correctAnswer: 1,
    explanation: 'A fall-arrest system must be correctly selected, fitted, connected to suitable anchorage and supported by clearance and prompt rescue arrangements.',
    siteExample: 'A trained worker uses an inspected harness and approved connection while working where collective protection is not practicable.',
  ),
  AbuDhabiHseQuestion(
    id: 29, topic: 'Working at Height',
    question: 'Why is a dropped-object exclusion zone needed?',
    options: ['To improve parking', 'To keep people away from the potential fall path of tools or materials', 'To replace tool lanyards', 'To permit overhead work above crowds'],
    correctAnswer: 1,
    explanation: 'Tools and materials can injure people below. Use barriers, controlled access, securing methods and coordinated work planning.',
    siteExample: 'The ground below façade maintenance is barricaded and access is controlled while tools are secured.',
  ),
  AbuDhabiHseQuestion(
    id: 30, topic: 'Working at Height',
    question: 'What should be checked before using a ladder?',
    options: ['Only its color', 'Condition, suitability, secure placement and task risk', 'Whether it can be used as a bridge', 'Whether the user can carry heavy loads'],
    correctAnswer: 1,
    explanation: 'Ladders are suitable only for appropriate tasks and must be inspected, stable and positioned safely. Safer work platforms should be considered for prolonged or demanding work.',
    siteExample: 'A damaged ladder is tagged out; a proper work platform is arranged for extended overhead installation.',
  ),
  AbuDhabiHseQuestion(
    id: 31, topic: 'Working at Height',
    question: 'What is a key requirement for an open floor edge?',
    options: ['A verbal warning only', 'Suitable physical edge protection or an approved fall-prevention system', 'A painted line only in all cases', 'A worker standing nearby'],
    correctAnswer: 1,
    explanation: 'Open edges require effective fall prevention appropriate to the work and site requirements. Openings also need secure covers or guarding.',
    siteExample: 'A floor opening is covered with a secured, load-suitable cover and marked, with access controlled.',
  ),
  AbuDhabiHseQuestion(
    id: 32, topic: 'Working at Height',
    question: 'What should a rescue plan address for a suspended worker?',
    options: ['Only who calls the office', 'Prompt retrieval method, trained rescuers, equipment, communications and emergency response', 'Waiting until shift end', 'Cutting the harness immediately'],
    correctAnswer: 1,
    explanation: 'Suspension after a fall can be life-threatening. Rescue arrangements must be planned, available and practiced for the actual worksite.',
    siteExample: 'Before roof work, the team identifies rescue equipment, access route, trained responders and emergency communication.',
  ),
  AbuDhabiHseQuestion(
    id: 33, topic: 'Working at Height',
    question: 'When should work at height stop?',
    options: ['When weather or conditions make controls ineffective or unsafe', 'Only at scheduled breaks', 'Never if a permit exists', 'When the supervisor leaves but workers continue'],
    correctAnswer: 0,
    explanation: 'Wind, lightning, poor visibility, unstable access or changing conditions can invalidate controls. Pause and reassess before resuming.',
    siteExample: 'A gusting wind affects a roof-edge task; the supervisor stops work and reassesses the method and weather limits.',
  ),
  AbuDhabiHseQuestion(
    id: 34, topic: 'Working at Height',
    question: 'Why is a ladder not normally suitable for heavy two-handed work?',
    options: ['It is always illegal', 'The task can compromise balance and safe contact; a suitable platform should be used', 'Ladders are only for painting', 'It improves stability'],
    correctAnswer: 1,
    explanation: 'A ladder provides limited support and is unsuitable where force, duration, reach or materials make safe positioning difficult.',
    siteExample: 'Workers move a heavy valve installation from a ladder to a properly guarded platform.',
  ),
  AbuDhabiHseQuestion(
    id: 35, topic: 'Power Tools',
    question: 'What should be done before using a portable power tool?',
    options: ['Check only the switch', 'Inspect condition, guards, cable/plug, suitability and required controls', 'Remove the guard', 'Use it while wet'],
    correctAnswer: 1,
    explanation: 'Pre-use checks identify damage and missing safety devices. Defective equipment must be removed from service.',
    siteExample: 'A worker finds a split cable on a grinder, labels it defective and obtains a safe replacement.',
  ),
  AbuDhabiHseQuestion(
    id: 36, topic: 'Power Tools',
    question: 'Why must a grinder guard remain fitted?',
    options: ['It slows work', 'It helps protect against contact and fragments if a disc fails', 'It is only for noise', 'It replaces eye protection'],
    correctAnswer: 1,
    explanation: 'The correct guard must be installed and positioned according to the tool and task. Never defeat safety features.',
    siteExample: 'A cutting disc is installed with the specified guard and the operator uses suitable eye/face protection.',
  ),
  AbuDhabiHseQuestion(
    id: 37, topic: 'Power Tools',
    question: 'What is the purpose of an RCD on a temporary electrical supply?',
    options: ['Increase voltage', 'Provide additional protection by disconnecting supply when residual current is detected', 'Replace earthing and inspection', 'Make damaged cables safe'],
    correctAnswer: 1,
    explanation: 'An RCD is an additional protective measure; it does not make unsafe equipment acceptable or replace other required protections.',
    siteExample: 'A temporary site board uses tested RCD protection, and workers still inspect tools and cables before use.',
  ),
  AbuDhabiHseQuestion(
    id: 38, topic: 'Power Tools',
    question: 'What should happen if a tool vibrates unusually or makes abnormal noise?',
    options: ['Continue until it fails', 'Stop, isolate and report for competent inspection', 'Hold it tighter', 'Remove its guard'],
    correctAnswer: 1,
    explanation: 'Abnormal vibration/noise can indicate damage, incorrect accessories or unsafe operation. Stop and assess.',
    siteExample: 'A drill begins vibrating; the operator disconnects it and sends it for inspection rather than continuing.',
  ),
  AbuDhabiHseQuestion(
    id: 39, topic: 'Power Tools',
    question: 'How should tool accessories be selected?',
    options: ['Any accessory that fits', 'Compatible rating, type, size and condition for the tool and task', 'Use a cracked disc if short duration', 'Modify the accessory to fit'],
    correctAnswer: 1,
    explanation: 'Accessories must match manufacturer specifications and be inspected. Incorrect speed ratings or damaged discs can fail dangerously.',
    siteExample: 'The operator checks the disc rating against the grinder speed and rejects a chipped disc.',
  ),
  AbuDhabiHseQuestion(
    id: 40, topic: 'Power Tools',
    question: 'What is a safe approach to portable tools in wet conditions?',
    options: ['Use any tool with bare hands', 'Use equipment and electrical protection suitable for the environment; keep connections dry and reassess', 'Place joints in puddles', 'Bypass the RCD'],
    correctAnswer: 1,
    explanation: 'Wet conditions increase shock risk. Select suitable equipment, protect connections, use required RCDs and stop if conditions cannot be controlled.',
    siteExample: 'After rain, the supervisor relocates temporary connections to a dry protected area and checks equipment before reuse.',
  ),
  AbuDhabiHseQuestion(
    id: 41, topic: 'Formwork',
    question: 'Who should approve formwork design for a critical pour?',
    options: ['Any carpenter', 'A competent designer/engineer or authorized person under the project system', 'The concrete truck driver', 'A visitor'],
    correctAnswer: 1,
    explanation: 'Formwork and falsework must be designed for expected loads, sequence, stability and supporting conditions by competent personnel.',
    siteExample: 'Before a large slab pour, the engineer reviews the approved formwork drawings and release documentation.',
  ),
  AbuDhabiHseQuestion(
    id: 42, topic: 'Formwork',
    question: 'What is a major risk during concrete placement?',
    options: ['Only noise', 'Formwork failure due to pressure, overloading or inadequate support', 'Too much lighting', 'Clean walkways'],
    correctAnswer: 1,
    explanation: 'Fresh concrete imposes loads and lateral pressure. Pour rate, sequence, supports and monitoring must follow design.',
    siteExample: 'The pour supervisor follows the approved sequence and watches for movement or distress in the formwork.',
  ),
  AbuDhabiHseQuestion(
    id: 43, topic: 'Formwork',
    question: 'What should be checked before a pour?',
    options: ['Only concrete color', 'Formwork condition, supports, access, reinforcement, embedded items and required release', 'Only truck arrival time', 'Whether workers are wearing matching uniforms'],
    correctAnswer: 1,
    explanation: 'A pre-pour check confirms design compliance, stability, access and readiness, with defects corrected before placement.',
    siteExample: 'The competent team checks props, bracing, ties, access and approved inspection records before authorizing the pour.',
  ),
  AbuDhabiHseQuestion(
    id: 44, topic: 'Formwork',
    question: 'When may formwork be removed?',
    options: ['Whenever workers need timber', 'Only when strength and stability criteria and approved striking sequence are met', 'Immediately after finishing', 'When a shift ends'],
    correctAnswer: 1,
    explanation: 'Premature striking can cause collapse or structural damage. Follow engineer-approved criteria, sequence and authorization.',
    siteExample: 'The team waits for the specified strength evidence and written release before removing slab supports.',
  ),
  AbuDhabiHseQuestion(
    id: 45, topic: 'Formwork',
    question: 'Why must props not be adjusted or removed during a pour without authorization?',
    options: ['They are decorative', 'They carry designed loads; alteration can cause instability or collapse', 'It improves finish', 'They are spare materials'],
    correctAnswer: 1,
    explanation: 'Props and bracing are structural temporary works. Unauthorized changes alter load paths and can trigger failure.',
    siteExample: 'A worker notices a leaning prop and alerts the pour supervisor; the area is controlled and engineer assesses it.',
  ),
  AbuDhabiHseQuestion(
    id: 46, topic: 'Formwork',
    question: 'What should be done if formwork bulges or leaks heavily during a pour?',
    options: ['Stand beneath it', 'Stop/pause placement, clear the danger area and follow emergency engineering response', 'Add more workers to push it', 'Ignore it until curing'],
    correctAnswer: 1,
    explanation: 'Movement, bulging or unusual leakage can indicate failure. Protect people, stop loading where safe and obtain competent assessment.',
    siteExample: 'Concrete placement is paused after movement is seen; workers withdraw from the affected zone and the engineer directs next steps.',
  ),
  AbuDhabiHseQuestion(
    id: 47, topic: 'Permit to Work',
    question: 'What is a PTW primarily used for?',
    options: ['Attendance tracking', 'Formal authorization and coordination of specified hazardous work', 'Replacing risk assessment', 'Guaranteeing no incident'],
    correctAnswer: 1,
    explanation: 'A PTW confirms defined work, hazards, precautions, isolations, roles, validity and authorization. It is one part of a wider control system.',
    siteExample: 'A hot-work permit is checked with the JSA, fire controls and area coordination before welding starts.',
  ),
  AbuDhabiHseQuestion(
    id: 48, topic: 'Permit to Work',
    question: 'Who should issue or authorize a permit?',
    options: ['Any worker', 'A designated authorized person under the site PTW procedure', 'A visitor', 'The newest team member'],
    correctAnswer: 1,
    explanation: 'Permit authority must be assigned, trained and competent under the employer/project system.',
    siteExample: 'The authorized issuer reviews site conditions and required certificates before signing the permit.',
  ),
  AbuDhabiHseQuestion(
    id: 49, topic: 'Permit to Work',
    question: 'What should happen when permit conditions change?',
    options: ['Continue using the original permit without review', 'Stop affected work and review, amend or reissue authorization as required', 'Erase the change', 'Let each worker decide'],
    correctAnswer: 1,
    explanation: 'Permits rely on specific conditions and controls. Changed scope, location, hazards or isolations require formal review.',
    siteExample: 'A nearby operation introduces a new ignition source; the permit is paused and area coordination is repeated.',
  ),
  AbuDhabiHseQuestion(
    id: 50, topic: 'Permit to Work',
    question: 'Why is isolation verification important before work on equipment?',
    options: ['It reduces paperwork', 'It confirms hazardous energy is controlled and cannot unexpectedly re-energize', 'A switch label is enough', 'It replaces communication'],
    correctAnswer: 1,
    explanation: 'Isolation, lockout and verification prevent unexpected release of electrical, mechanical, pressure or other energy.',
    siteExample: 'Before maintenance, the team applies locks, proves the equipment is de-energized using the approved method and records the isolation.',
  ),
  AbuDhabiHseQuestion(
    id: 51, topic: 'Permit to Work',
    question: 'What is a permit handback/closeout for?',
    options: ['To avoid inspection', 'Confirm work completion, people/tools cleared, safeguards restored as authorized and permit closed', 'To increase permit duration', 'To transfer responsibility to security'],
    correctAnswer: 1,
    explanation: 'Closeout confirms the job is finished and the plant/work area is safely returned under the procedure.',
    siteExample: 'After maintenance, the supervisor verifies tools are removed, guards restored and personnel accounted for before formal handback.',
  ),
  AbuDhabiHseQuestion(
    id: 52, topic: 'Permit to Work',
    question: 'Can a PTW replace a JSA or risk assessment?',
    options: ['Yes, always', 'No; it authorizes and coordinates work while risk assessment identifies hazards and controls', 'Only at night', 'Only for contractors'],
    correctAnswer: 1,
    explanation: 'PTW and risk assessment serve related but different purposes and should be integrated where required.',
    siteExample: 'The permit references the approved JSA and confirms the listed controls are in place at the worksite.',
  ),
  AbuDhabiHseQuestion(
    id: 53, topic: 'Permit to Work',
    question: 'What should workers do if they do not understand permit controls?',
    options: ['Sign anyway', 'Ask the supervisor/issuer for clarification before starting', 'Copy another worker', 'Proceed slowly'],
    correctAnswer: 1,
    explanation: 'Workers need to understand the scope, hazards, precautions and stop-work conditions before undertaking the task.',
    siteExample: 'A new worker asks for clarification about an isolation boundary during the briefing; work waits until the boundary is understood.',
  ),
  AbuDhabiHseQuestion(
    id: 54, topic: 'Permit to Work',
    question: 'Why is simultaneous operations (SIMOPS) coordination important?',
    options: ['It increases paperwork only', 'Nearby tasks can create interacting hazards and invalidate controls', 'It removes the need for permits', 'It applies only offshore'],
    correctAnswer: 1,
    explanation: 'Concurrent work can introduce ignition, dropped objects, traffic conflicts or energy interactions. Coordination aligns schedules, boundaries and controls.',
    siteExample: 'A lift above a work area is rescheduled or the lower area evacuated and barricaded after SIMOPS review.',
  ),
  AbuDhabiHseQuestion(
    id: 55, topic: 'Hot & Humid Climate',
    question: 'What is a common early sign of heat stress?',
    options: ['Improved concentration', 'Heavy sweating, weakness, headache or dizziness', 'Cold fingers only', 'No change in behavior'],
    correctAnswer: 1,
    explanation: 'Heat illness may progress rapidly. Recognize symptoms early, stop exposure, move to a cooler place and seek appropriate response.',
    siteExample: 'A worker reports dizziness during outdoor work; the supervisor moves them to a cool area and activates the site heat response.',
  ),
  AbuDhabiHseQuestion(
    id: 56, topic: 'Hot & Humid Climate',
    question: 'What is the purpose of acclimatization?',
    options: ['Make workers immune to heat', 'Allow gradual adaptation to hot conditions with monitored work exposure', 'Remove need for water', 'Permit unlimited overtime'],
    correctAnswer: 1,
    explanation: 'Gradual acclimatization can improve heat tolerance, but workers still need hydration, rest, monitoring and controls.',
    siteExample: 'A newly assigned outdoor worker follows a planned gradual exposure schedule with supervisor monitoring.',
  ),
  AbuDhabiHseQuestion(
    id: 57, topic: 'Hot & Humid Climate',
    question: 'What should be available during hot-weather work?',
    options: ['Only energy drinks', 'Accessible drinking water, suitable rest/shade or cooling and planned work-rest controls', 'No breaks', 'Only a first-aid box'],
    correctAnswer: 1,
    explanation: 'Heat controls combine hydration, shade/cooling, scheduling, monitoring and emergency arrangements based on conditions and applicable requirements.',
    siteExample: 'The site provides drinking water and shaded recovery areas and adjusts strenuous tasks during high heat.',
  ),
  AbuDhabiHseQuestion(
    id: 58, topic: 'Hot & Humid Climate',
    question: 'What should a coworker do if someone shows confusion or collapses from heat?',
    options: ['Tell them to finish the task', 'Treat as an emergency, call trained responders, cool the person and follow first-aid protocol', 'Give them a hot drink', 'Leave them alone'],
    correctAnswer: 1,
    explanation: 'Confusion or collapse can indicate severe heat illness. Prompt emergency response and active cooling are essential; do not delay for routine reporting.',
    siteExample: 'A worker collapses; the team raises the alarm, moves them from heat if safe, begins appropriate cooling and arranges emergency medical care.',
  ),
  AbuDhabiHseQuestion(
    id: 59, topic: 'Hot & Humid Climate',
    question: 'Why is workload monitoring important in hot conditions?',
    options: ['Heat affects only new workers', 'Physical effort increases heat strain and individual tolerance varies', 'PPE prevents all heat illness', 'Water alone controls every risk'],
    correctAnswer: 1,
    explanation: 'Work intensity, clothing, acclimatization, health and environment influence heat strain. Supervisors must monitor and adapt controls.',
    siteExample: 'A crew performing heavy manual handling is rotated, given recovery breaks and monitored for symptoms.',
  ),
  AbuDhabiHseQuestion(
    id: 60, topic: 'Hot & Humid Climate',
    question: 'What should be done if required heat controls cannot be maintained?',
    options: ['Continue because the schedule is fixed', 'Pause or reschedule exposed work and consult the responsible site team', 'Remove shade', 'Ask workers to sign a waiver'],
    correctAnswer: 1,
    explanation: 'Work must not proceed when risk controls are inadequate. Apply project and current UAE authority requirements for heat exposure.',
    siteExample: 'Cooling equipment fails in a work zone; the supervisor suspends exposed tasks until suitable controls are restored.',
  ),
  AbuDhabiHseQuestion(
    id: 61, topic: 'Confined Space',
    question: 'What defines a confined space for safety planning?',
    options: ['Any small room', 'A space with restricted entry/exit and potential hazardous atmosphere or other serious hazards, as defined by applicable system', 'Any outdoor area', 'Only a tank'],
    correctAnswer: 1,
    explanation: 'Confined-space classification depends on access, configuration and hazards, not size alone. Apply the site definition and entry procedure.',
    siteExample: 'A tank is assessed for restricted access, residues, oxygen deficiency and rescue challenges before entry is considered.',
  ),
  AbuDhabiHseQuestion(
    id: 62, topic: 'Confined Space',
    question: 'What must be completed before authorized entry?',
    options: ['Only a toolbox talk', 'Risk assessment, permit where required, isolation, atmospheric testing and rescue arrangements', 'Start ventilation after entry', 'Send one worker alone'],
    correctAnswer: 1,
    explanation: 'Entry controls must be established before entry and maintained during the work, including communication and monitoring as required.',
    siteExample: 'The entry supervisor verifies isolation, test results, ventilation, attendant, communications and rescue readiness before authorizing entry.',
  ),
  AbuDhabiHseQuestion(
    id: 63, topic: 'Confined Space',
    question: 'Why is atmospheric testing performed?',
    options: ['To check paint color', 'To assess oxygen, flammable and toxic atmosphere hazards using suitable instruments', 'To replace isolation', 'Only after entry'],
    correctAnswer: 1,
    explanation: 'Atmospheric hazards may be invisible and can change. Testing is performed by competent personnel using calibrated/verified instruments and a defined sequence.',
    siteExample: 'A trained gas tester checks the tank atmosphere at appropriate levels before entry and monitors as specified.',
  ),
  AbuDhabiHseQuestion(
    id: 64, topic: 'Confined Space',
    question: 'What is the role of a confined-space attendant?',
    options: ['Enter whenever someone calls', 'Remain outside, monitor entrants, communicate, raise alarm and prevent unauthorized entry', 'Leave to collect tools', 'Issue medical diagnoses'],
    correctAnswer: 1,
    explanation: 'The attendant maintains awareness and communication and initiates the rescue plan without making an unsafe unplanned entry.',
    siteExample: 'When communication is lost, the attendant raises the alarm and activates the planned rescue response rather than entering alone.',
  ),
  AbuDhabiHseQuestion(
    id: 65, topic: 'Confined Space',
    question: 'What should happen if gas readings exceed permitted entry criteria?',
    options: ['Continue with a mask only', 'Do not enter or evacuate as required; investigate and restore safe conditions before reauthorization', 'Ignore one reading', 'Turn off the detector'],
    correctAnswer: 1,
    explanation: 'Unsafe or uncertain atmosphere requires entry prevention/evacuation, control of the source, ventilation where appropriate and retesting.',
    siteExample: 'An alarm occurs during tank cleaning; entrants exit and the entry supervisor suspends the permit pending reassessment.',
  ),
  AbuDhabiHseQuestion(
    id: 66, topic: 'Confined Space',
    question: 'Why must rescue arrangements be ready before entry?',
    options: ['Rescue is never needed', 'A casualty may be unable to self-rescue and improvised entry can create multiple victims', 'It is only for paperwork', 'It replaces atmospheric monitoring'],
    correctAnswer: 1,
    explanation: 'Confined-space rescue can be complex and time-critical. Equipment, trained responders, communications and retrieval methods must be planned.',
    siteExample: 'A worker becomes unresponsive; the team uses the planned non-entry retrieval method where suitable and activates trained rescue services.',
  ),
  AbuDhabiHseQuestion(
    id: 67, topic: 'Confined Space',
    question: 'What is a safe approach to ventilation?',
    options: ['Use any fan without assessment', 'Select suitable ventilation and monitor atmosphere; prevent introducing new hazards', 'Ventilate only after a casualty', 'Use oxygen to ventilate'],
    correctAnswer: 1,
    explanation: 'Ventilation must be appropriate for contaminants, flow paths and equipment classification. Oxygen enrichment is dangerous and not a ventilation method.',
    siteExample: 'The team uses approved ventilation equipment and verifies atmosphere remains within entry criteria.',
  ),
  AbuDhabiHseQuestion(
    id: 68, topic: 'Confined Space',
    question: 'Who may authorize confined-space entry?',
    options: ['Any entrant', 'The designated competent/authorized entry supervisor under the permit system', 'A delivery driver', 'No one if the space looks clean'],
    correctAnswer: 1,
    explanation: 'Entry authorization follows the formal procedure and confirms controls, personnel, monitoring and rescue readiness.',
    siteExample: 'The entry supervisor checks the permit and signs authorization only after all required controls are verified.',
  ),
  AbuDhabiHseQuestion(
    id: 69, topic: 'Working Near Live Road',
    question: 'What is a key first step before roadside work?',
    options: ['Start unloading in the traffic lane', 'Approve a traffic management plan and establish controls for the work zone', 'Rely only on workers waving', 'Remove warning signs'],
    correctAnswer: 1,
    explanation: 'Roadside work needs planned traffic separation, signs, barriers, visibility, access and coordination with relevant authorities.',
    siteExample: 'Before utility work beside a live road, the contractor implements the approved traffic plan and checks barriers and taper arrangements.',
  ),
  AbuDhabiHseQuestion(
    id: 70, topic: 'Working Near Live Road',
    question: 'Why should workers wear high-visibility clothing near traffic?',
    options: ['For company branding', 'To improve conspicuity to drivers and equipment operators', 'It replaces barriers', 'It prevents vehicle impact'],
    correctAnswer: 1,
    explanation: 'High-visibility PPE is a supporting control; it does not replace physical separation, traffic management or safe positioning.',
    siteExample: 'A survey crew wears suitable high-visibility clothing while working behind approved traffic protection.',
  ),
  AbuDhabiHseQuestion(
    id: 71, topic: 'Working Near Live Road',
    question: 'What is the purpose of a banksman/traffic marshal?',
    options: ['Stand in the blind spot', 'Guide movements from a safe visible position using agreed signals and communication', 'Direct traffic without training', 'Use a phone while walking'],
    correctAnswer: 1,
    explanation: 'A trained marshal helps manage vehicle movements but must remain outside danger zones and follow the approved plan.',
    siteExample: 'A delivery vehicle reverses into a controlled site entrance under a trained banksman\'s guidance.',
  ),
  AbuDhabiHseQuestion(
    id: 72, topic: 'Working Near Live Road',
    question: 'What should be done if traffic barriers are displaced?',
    options: ['Continue until lunch', 'Stop affected work, protect people and restore the approved traffic arrangement', 'Ask workers to stand in the road', 'Remove remaining signs'],
    correctAnswer: 1,
    explanation: 'Displaced barriers may expose workers or road users. Work pauses until the safe work zone is re-established.',
    siteExample: 'A vehicle hits a barrier; the supervisor suspends roadside activity and arranges safe reinstatement.',
  ),
  AbuDhabiHseQuestion(
    id: 73, topic: 'Working Near Live Road',
    question: 'How should plant and pedestrians be managed in a roadside work zone?',
    options: ['Share the same route', 'Provide separation, controlled crossings and clear movement arrangements', 'Use verbal warnings only', 'Allow pedestrians behind reversing trucks'],
    correctAnswer: 1,
    explanation: 'Segregation reduces struck-by risk. Routes, reversing controls, visibility and spotters should be planned.',
    siteExample: 'Pedestrians use a protected walkway while dump trucks follow a one-way route controlled at crossing points.',
  ),
  AbuDhabiHseQuestion(
    id: 74, topic: 'Working Near Live Road',
    question: 'What should be considered for night roadside work?',
    options: ['Only brighter phones', 'Lighting, visibility, reflective devices, driver approach, fatigue and approved traffic controls', 'Remove warning lights', 'Wear dark clothing'],
    correctAnswer: 1,
    explanation: 'Night work increases visibility and perception challenges. Lighting must illuminate the work without dazzling drivers.',
    siteExample: 'A night maintenance crew checks that work lights illuminate the task but do not glare into approaching traffic.',
  ),
  AbuDhabiHseQuestion(
    id: 75, topic: 'Concreting',
    question: 'What is a major hazard from a concrete pump hose?',
    options: ['Low noise', 'Hose whip, pressure release and struck-by injuries', 'Paper cuts only', 'Sunlight'],
    correctAnswer: 1,
    explanation: 'Concrete delivery systems contain pressure and moving hoses. Secure connections, controlled positioning, communication and exclusion zones are essential.',
    siteExample: 'During a pour, workers stay clear of hose movement and the operator stops pumping before clearing a blockage under procedure.',
  ),
  AbuDhabiHseQuestion(
    id: 76, topic: 'Concreting',
    question: 'What PPE is important when handling wet concrete?',
    options: ['Only cloth gloves', 'Suitable waterproof gloves, eye/skin protection, boots and task-specific PPE', 'No PPE if brief', 'Only hearing protection'],
    correctAnswer: 1,
    explanation: 'Wet cement can cause chemical burns and eye injury. Prevent contact, wash contamination promptly and follow SDS and site first aid.',
    siteExample: 'A worker wears suitable gloves and boots and washes cement splashes promptly at the designated washing point.',
  ),
  AbuDhabiHseQuestion(
    id: 77, topic: 'Concreting',
    question: 'What should be done before clearing a concrete blockage?',
    options: ['Strike the hose while pressurized', 'Stop and isolate/depressurize using the approved procedure and competent personnel', 'Ask someone to hold the hose', 'Disconnect any coupling immediately'],
    correctAnswer: 1,
    explanation: 'Stored pressure can cause sudden release and serious injury. Follow manufacturer and site safe-clearing procedures.',
    siteExample: 'The pump operator stops the system and the trained team follows the approved pressure-release method before intervention.',
  ),
  AbuDhabiHseQuestion(
    id: 78, topic: 'Concreting',
    question: 'Why should concrete truck movements be controlled?',
    options: ['To improve paint quality', 'Vehicles create reversing, collision and pedestrian-strike hazards', 'Drivers always see workers', 'No controls are needed on site'],
    correctAnswer: 1,
    explanation: 'Concrete deliveries require designated routes, banksman where needed, pedestrian segregation and safe discharge positioning.',
    siteExample: 'A banksman guides the truck to the pour location while pedestrians remain outside the vehicle movement zone.',
  ),
  AbuDhabiHseQuestion(
    id: 79, topic: 'Concreting',
    question: 'What should workers do after wet concrete contacts skin or eyes?',
    options: ['Wait until shift ends', 'Use immediate washing/eyewash and seek medical assessment according to exposure and site procedure', 'Rub the area', 'Cover it with dry cement'],
    correctAnswer: 1,
    explanation: 'Wet cement is alkaline and can cause burns. Prompt decontamination and medical evaluation reduce injury severity.',
    siteExample: 'A splash to the eye is flushed immediately at the eyewash station and reported for urgent medical assessment.',
  ),
  AbuDhabiHseQuestion(
    id: 80, topic: 'Barricading',
    question: 'What is the purpose of a physical barricade?',
    options: ['Decorate the site', 'Prevent or control access to a hazardous area', 'Replace every other control', 'Mark a storage preference only'],
    correctAnswer: 1,
    explanation: 'Barricades establish boundaries and keep people away from hazards; type and strength must suit the risk.',
    siteExample: 'An excavation is protected with suitable rigid barriers and warning signs to prevent pedestrian entry.',
  ),
  AbuDhabiHseQuestion(
    id: 81, topic: 'Barricading',
    question: 'When is a barricade required around a floor opening?',
    options: ['Only after someone falls', 'Before exposure, with a secured cover or suitable guard and clear identification', 'Only during audits', 'Never if the opening is small'],
    correctAnswer: 1,
    explanation: 'Openings can cause falls and dropped objects. Effective covers/guardrails and access control are required before work exposes people.',
    siteExample: 'A temporary service opening is covered with a secured load-rated cover and marked before the area is released.',
  ),
  AbuDhabiHseQuestion(
    id: 82, topic: 'Barricading',
    question: 'What should be done if a barricade must be temporarily removed?',
    options: ['Remove it and forget it', 'Authorize, control the exposure, provide alternative protection and promptly reinstate it', 'Leave the area open', 'Ask passersby to be careful'],
    correctAnswer: 1,
    explanation: 'Temporary removal creates an exposure and needs controlled access, supervision and restoration.',
    siteExample: 'A delivery requires barrier access; a spotter controls entry and the barrier is reinstated immediately after the lift.',
  ),
  AbuDhabiHseQuestion(
    id: 83, topic: 'Barricading',
    question: 'Why are warning signs used with barricades?',
    options: ['They replace barriers', 'They communicate hazard and restriction, supplementing physical access control', 'They guarantee compliance', 'They are only for visitors'],
    correctAnswer: 1,
    explanation: 'Signs help people understand the hazard and required action, but cannot physically prevent entry by themselves.',
    siteExample: 'A restricted lifting zone uses barriers plus signs stating suspended-load exclusion and authorized access only.',
  ),
  AbuDhabiHseQuestion(
    id: 84, topic: 'Barricading',
    question: 'Who may enter a restricted hazardous area?',
    options: ['Anyone who is curious', 'Only authorized persons who understand and follow required controls', 'Visitors without escort', 'Workers taking shortcuts'],
    correctAnswer: 1,
    explanation: 'Access should be limited to people with a work need, authorization and suitable briefing/PPE.',
    siteExample: 'Only the assigned crew enters the energized testing boundary under the controlled procedure.',
  ),
  AbuDhabiHseQuestion(
    id: 85, topic: 'Worker Welfare',
    question: 'What is an essential drinking-water provision for workers?',
    options: ['Water kept far from work and inaccessible', 'Potable water that is accessible and protected from contamination', 'Unlabelled industrial water', 'No water during hot work'],
    correctAnswer: 1,
    explanation: 'Workers need safe drinking water available in suitable locations. Water quality and containers should be maintained.',
    siteExample: 'Outdoor crews have accessible potable water points and supervisors check replenishment during hot weather.',
  ),
  AbuDhabiHseQuestion(
    id: 86, topic: 'Worker Welfare',
    question: 'Why must sanitary facilities be maintained?',
    options: ['For appearance only', 'To protect hygiene, dignity and health through clean, serviced facilities', 'To replace handwashing', 'Only for office staff'],
    correctAnswer: 1,
    explanation: 'Suitable toilets, handwashing and cleaning arrangements support worker health and welfare; provision must meet applicable requirements.',
    siteExample: 'The welfare inspection finds a facility out of service; it is repaired or an adequate alternative is provided promptly.',
  ),
  AbuDhabiHseQuestion(
    id: 87, topic: 'Worker Welfare',
    question: 'Where should workers take meals and rest?',
    options: ['Beside chemicals', 'In a safe designated clean area away from operational hazards', 'Inside a confined space', 'Under suspended loads'],
    correctAnswer: 1,
    explanation: 'Rest and eating areas should be hygienic and separated from dust, chemicals, traffic and active work hazards.',
    siteExample: 'The contractor provides shaded clean break areas away from vehicle routes and material storage.',
  ),
  AbuDhabiHseQuestion(
    id: 88, topic: 'Worker Welfare',
    question: 'What should be ensured in worker accommodation?',
    options: ['Blocked exits to control access', 'Clear emergency exits, safe services, hygiene and emergency arrangements', 'Overloaded electrical sockets', 'Locked exits during occupancy'],
    correctAnswer: 1,
    explanation: 'Accommodation safety includes fire precautions, unobstructed escape, electrical safety, sanitation and emergency readiness.',
    siteExample: 'A welfare inspection identifies an obstructed exit and requires immediate clearance and follow-up.',
  ),
  AbuDhabiHseQuestion(
    id: 89, topic: 'Worker Welfare',
    question: 'What if drinking water is suspected to be contaminated?',
    options: ['Continue using it', 'Stop use, provide safe alternative water and report for investigation', 'Add chemicals without authorization', 'Tell workers not to complain'],
    correctAnswer: 1,
    explanation: 'Potentially unsafe water must be removed from use while quality is investigated and safe supply maintained.',
    siteExample: 'Workers report unusual water odor; the supply is isolated, bottled potable water is provided and responsible personnel investigate.',
  ),
  AbuDhabiHseQuestion(
    id: 90, topic: 'MEWP',
    question: 'What should be checked before operating a MEWP?',
    options: ['Only fuel level', 'Pre-use inspection, emergency lowering, controls, alarms, tires and safety devices', 'Only platform paint', 'Whether the operator can reach the controls'],
    correctAnswer: 1,
    explanation: 'Pre-use checks confirm the machine is serviceable and emergency functions work. Defects must be reported and equipment not used until safe.',
    siteExample: 'The operator tests ground controls and emergency lowering during the documented pre-use check.',
  ),
  AbuDhabiHseQuestion(
    id: 91, topic: 'MEWP',
    question: 'Who may operate a MEWP?',
    options: ['Any worker who has driven a car', 'A trained, competent, authorized operator familiarized with the specific machine', 'A visitor', 'A worker standing on the ground without training'],
    correctAnswer: 1,
    explanation: 'Operators need appropriate training, practical competence, authorization and familiarization with the model and site conditions.',
    siteExample: 'The supervisor verifies the operator\'s credentials and machine-specific familiarization before assigning the task.',
  ),
  AbuDhabiHseQuestion(
    id: 92, topic: 'MEWP',
    question: 'What ground conditions must be assessed?',
    options: ['Only color of soil', 'Bearing capacity, slope, voids, trenches, covers and travel route', 'Only weather forecast', 'Nothing if outriggers exist'],
    correctAnswer: 1,
    explanation: 'MEWP stability depends on ground strength and geometry. Outriggers or wheels must be supported as specified.',
    siteExample: 'Before positioning near an excavation, the team checks ground capacity and maintains the required safe separation.',
  ),
  AbuDhabiHseQuestion(
    id: 93, topic: 'MEWP',
    question: 'How should workers behave on a boom-type MEWP platform?',
    options: ['Climb guardrails for extra reach', 'Stay within platform limits and use required fall protection as specified; never climb rails', 'Stand on boxes', 'Exceed rated capacity briefly'],
    correctAnswer: 1,
    explanation: 'Platform capacity and manufacturer instructions must be followed. Fall protection requirements depend on equipment type and site rules.',
    siteExample: 'The operator keeps both feet on the platform floor, uses the designated anchor point where required and does not lean outside rails.',
  ),
  AbuDhabiHseQuestion(
    id: 94, topic: 'MEWP',
    question: 'What must be planned for MEWP emergency?',
    options: ['Wait for the battery to die', 'A practical ground/emergency lowering and rescue method with trained people', 'Call the operator only', 'Use a crane hook improvised onsite'],
    correctAnswer: 1,
    explanation: 'A person at ground level must know how to operate emergency controls and activate the response plan.',
    siteExample: 'A ground worker is briefed on emergency lowering before the MEWP raises personnel.',
  ),
  AbuDhabiHseQuestion(
    id: 95, topic: 'MEWP',
    question: 'What is the safe approach near overhead power lines?',
    options: ['Assume rubber tires make it safe', 'Identify lines, consult the responsible authority and establish required clearances/exclusion controls', 'Touch the line to test voltage', 'Use a metal pole to move it'],
    correctAnswer: 1,
    explanation: 'Overhead lines can cause fatal electric shock or arcing. Work planning must establish voltage, clearance, barriers and authorized controls.',
    siteExample: 'The MEWP route is changed and an exclusion zone is set after the utility owner confirms line conditions.',
  ),
  AbuDhabiHseQuestion(
    id: 96, topic: 'Electrical Safety',
    question: 'What is required before working on electrical equipment?',
    options: ['Switch off and assume safe', 'Isolate, lock/tag as required and verify absence of voltage using an approved method', 'Ask a coworker to watch', 'Wear gloves only'],
    correctAnswer: 1,
    explanation: 'Lockout/tagout and test-before-touch controls prevent unexpected energization. Verification must be performed by competent authorized personnel.',
    siteExample: 'An electrician isolates the circuit, applies personal locks and proves dead with an approved tester before work.',
  ),
  AbuDhabiHseQuestion(
    id: 97, topic: 'Electrical Safety',
    question: 'What does an RCD do?',
    options: ['Guarantees equipment is safe', 'Detects residual current imbalance and disconnects supply as additional protection', 'Replaces protective earthing', 'Repairs damaged insulation'],
    correctAnswer: 1,
    explanation: 'An RCD is supplementary protection and does not replace proper equipment condition, earthing, isolation or safe work practices.',
    siteExample: 'A site distribution board includes tested RCD protection; damaged tools are still removed from service.',
  ),
  AbuDhabiHseQuestion(
    id: 98, topic: 'Electrical Safety',
    question: 'What should be done with a damaged electrical cable?',
    options: ['Wrap it with tape and continue', 'Remove it from service, isolate if safe and report for repair/replacement by competent personnel', 'Put it under a mat', 'Use it only in daylight'],
    correctAnswer: 1,
    explanation: 'Damaged insulation creates shock, fire and short-circuit risks. Temporary improvised repairs are not an acceptable substitute for approved repair.',
    siteExample: 'A worker finds exposed conductors, stops use and tags the lead out for replacement.',
  ),
  AbuDhabiHseQuestion(
    id: 99, topic: 'Electrical Safety',
    question: 'What is the purpose of protective earthing?',
    options: ['Increase appliance speed', 'Provide a fault-current path to help protective devices disconnect supply', 'Prevent all electrical hazards', 'Replace insulation'],
    correctAnswer: 1,
    explanation: 'Protective earthing supports fault protection by providing a low-impedance path, used with correctly designed protective devices.',
    siteExample: 'A portable tool\'s protective conductor and plug are inspected as part of the site electrical safety system.',
  ),
  AbuDhabiHseQuestion(
    id: 100, topic: 'Electrical Safety',
    question: 'Who should perform electrical installation or repair work?',
    options: ['Any experienced laborer', 'Competent authorized electrical personnel within their scope', 'A cleaner', 'A visitor'],
    correctAnswer: 1,
    explanation: 'Electrical tasks require suitable competence, authorization, isolation and compliance with applicable procedures.',
    siteExample: 'A site supervisor assigns distribution-board repair to an authorized electrician, not an unqualified helper.',
  ),
  AbuDhabiHseQuestion(
    id: 101, topic: 'Electrical Safety',
    question: 'What is important for temporary distribution boards?',
    options: ['Leave them open in rain', 'Suitable enclosure, protection, secure positioning, inspection and controlled access', 'Allow exposed live parts', 'Stack materials against them'],
    correctAnswer: 1,
    explanation: 'Temporary boards must be protected from weather, impact and unauthorized access, with circuits and protective devices maintained.',
    siteExample: 'The site electrician secures a weather-suitable board on a stable stand and keeps access clear for inspection.',
  ),
  AbuDhabiHseQuestion(
    id: 102, topic: 'Electrical Safety',
    question: 'What is the safe first response to electric shock?',
    options: ['Touch the casualty immediately', 'Do not touch until electrical source is made safe; raise alarm and provide trained first aid/CPR as appropriate', 'Pour water on the equipment', 'Move the cable with bare hands'],
    correctAnswer: 1,
    explanation: 'Rescuers must avoid becoming victims. Isolate power safely, call emergency response and provide first aid only when the scene is safe.',
    siteExample: 'A worker receives a shock; the team isolates supply, calls emergency services and trained responders begin care after confirming safety.',
  ),
  AbuDhabiHseQuestion(
    id: 103, topic: 'Temporary Works',
    question: 'Who should be responsible for temporary works design?',
    options: ['Anyone available', 'A competent designer with defined review and approval responsibilities', 'The material supplier alone', 'A worker selected randomly'],
    correctAnswer: 1,
    explanation: 'Temporary works must be designed and managed for loads, sequence, stability, interfaces and site conditions by competent personnel.',
    siteExample: 'An engineer reviews the temporary access platform design and confirms the required loading and support conditions.',
  ),
  AbuDhabiHseQuestion(
    id: 104, topic: 'Temporary Works',
    question: 'When should temporary works be inspected?',
    options: ['Only after dismantling', 'At required hold points and after alteration, impact or conditions affecting safety', 'Only once at delivery', 'Never if painted'],
    correctAnswer: 1,
    explanation: 'Inspection stages are defined by the temporary works procedure and risk; changes and events may require reassessment.',
    siteExample: 'After a storm, the responsible person inspects the temporary support before work resumes.',
  ),
  AbuDhabiHseQuestion(
    id: 105, topic: 'Temporary Works',
    question: 'What should happen if a brace is removed without approval?',
    options: ['Continue if it looks stable', 'Stop affected work, secure the area and obtain competent review before any change or re-entry', 'Remove more braces', 'Hide the change'],
    correctAnswer: 1,
    explanation: 'Bracing is part of the designed stability system. Unauthorized removal can cause progressive failure.',
    siteExample: 'The supervisor finds a missing brace, isolates the area and asks the temporary works coordinator to assess and restore the approved arrangement.',
  ),
  AbuDhabiHseQuestion(
    id: 106, topic: 'Temporary Works',
    question: 'How should temporary works loading be controlled?',
    options: ['Allow any stored materials', 'Keep loads, sequence and use within approved design limits', 'Use as a general storage area', 'Ignore dynamic loads'],
    correctAnswer: 1,
    explanation: 'Loads from people, materials, equipment, impact and construction sequence must be considered and controlled.',
    siteExample: 'The site limits material stacks on a temporary platform to the approved loading plan.',
  ),
  AbuDhabiHseQuestion(
    id: 107, topic: 'Temporary Works',
    question: 'Why is a temporary works register useful?',
    options: ['It replaces design', 'It tracks temporary works, status, responsible persons, inspections and release points', 'It is only for finance', 'It permits undocumented changes'],
    correctAnswer: 1,
    explanation: 'A register supports visibility and coordination of temporary structures from design through use and dismantling.',
    siteExample: 'The coordinator updates the register with design reference, inspection status and release date for a support system.',
  ),
  AbuDhabiHseQuestion(
    id: 108, topic: 'Temporary Works',
    question: 'When may temporary supports be dismantled?',
    options: ['When convenient', 'After approved strength/stability criteria and sequence are confirmed and authorized', 'As soon as concrete looks dry', 'When a worker requests timber'],
    correctAnswer: 1,
    explanation: 'Premature removal can cause collapse or permanent-works damage. Follow engineer-approved striking criteria and sequence.',
    siteExample: 'The team waits for specified strength evidence and formal release before removing slab props.',
  ),
  AbuDhabiHseQuestion(
    id: 109, topic: 'Manual Handling',
    question: 'What should be assessed before manual lifting?',
    options: ['Only the object\'s color', 'Load, task, individual capability and environment, including route and frequency', 'Only worker age', 'Nothing for short lifts'],
    correctAnswer: 1,
    explanation: 'Manual handling risk depends on load weight and shape, posture, repetition, distance, environment and worker capability.',
    siteExample: 'A supervisor checks a heavy pump component, route and team capability before deciding on a mechanical aid.',
  ),
  AbuDhabiHseQuestion(
    id: 110, topic: 'Manual Handling',
    question: 'What is a safer lifting technique?',
    options: ['Twist while lifting', 'Plan the route, keep the load close, use a stable stance and avoid twisting', 'Lift with arms fully extended', 'Move quickly to reduce exposure'],
    correctAnswer: 1,
    explanation: 'Good technique reduces awkward posture but does not make an unsuitable load safe; redesign or mechanical assistance may be needed.',
    siteExample: 'A worker positions close to a manageable box, faces the travel direction and turns with the feet rather than twisting the back.',
  ),
  AbuDhabiHseQuestion(
    id: 111, topic: 'Manual Handling',
    question: 'When should mechanical handling aids be considered?',
    options: ['Only after an injury', 'For heavy, bulky, repetitive or awkward loads where practicable', 'Never on construction sites', 'Only for office furniture'],
    correctAnswer: 1,
    explanation: 'Mechanical aids reduce physical strain and should be considered during task planning, with routes and operator competence checked.',
    siteExample: 'A trolley or hoist is arranged to move repeated material deliveries instead of carrying each load manually.',
  ),
  AbuDhabiHseQuestion(
    id: 112, topic: 'Manual Handling',
    question: 'What is important during a team lift?',
    options: ['No coordination needed', 'Agree roles, route, commands and synchronized movement before lifting', 'One person changes direction without warning', 'Lift beyond individual capability'],
    correctAnswer: 1,
    explanation: 'Team lifts require communication and coordination; if load or route is unsuitable, use a mechanical aid or revise the plan.',
    siteExample: 'Two workers agree a lift command and clear route before moving a long item through a site corridor.',
  ),
  AbuDhabiHseQuestion(
    id: 113, topic: 'Manual Handling',
    question: 'What should a worker do after developing back pain during lifting?',
    options: ['Continue to meet target', 'Stop or modify the task, report symptoms and seek appropriate assessment', 'Hide the pain', 'Take another heavy load'],
    correctAnswer: 1,
    explanation: 'Early reporting helps prevent worsening injury and supports review of task design and controls.',
    siteExample: 'A worker reports pain; the supervisor arranges assessment and reviews the handling method before reassignment.',
  ),
  AbuDhabiHseQuestion(
    id: 114, topic: 'Hot Work',
    question: 'What should be in place before hot work begins?',
    options: ['Only welding machine', 'Authorized permit/risk controls, area check, fire precautions and required isolations', 'No inspection if outdoors', 'A verbal promise'],
    correctAnswer: 1,
    explanation: 'Hot work requires control of ignition sources, combustibles, atmosphere where relevant, fire protection and authorization.',
    siteExample: 'Before cutting, the team checks the permit, removes or shields combustibles, confirms extinguishers and assigns a fire watch.',
  ),
  AbuDhabiHseQuestion(
    id: 115, topic: 'Hot Work',
    question: 'What is the fire watch\'s role?',
    options: ['Perform unrelated tasks', 'Monitor for ignition during and after work, maintain firefighting readiness and raise alarm', 'Leave when welding stops', 'Approve electrical design'],
    correctAnswer: 1,
    explanation: 'A fire watch remains attentive, understands alarm arrangements and observes the work area for smoldering or fire as required by the permit.',
    siteExample: 'After welding near stored materials, the fire watch checks adjacent and concealed areas during the required post-work period.',
  ),
  AbuDhabiHseQuestion(
    id: 116, topic: 'Hot Work',
    question: 'What should be done with combustible materials near hot work?',
    options: ['Leave them in place', 'Remove them or protect them with suitable non-combustible shielding', 'Cover with paper', 'Move them under the welding table'],
    correctAnswer: 1,
    explanation: 'Sparks and heat can ignite materials at a distance or through openings. Protect nearby and opposite-side areas.',
    siteExample: 'The crew removes packaging and shields nearby openings before grinding begins.',
  ),
  AbuDhabiHseQuestion(
    id: 117, topic: 'Hot Work',
    question: 'How should oxygen cylinders and fittings be treated?',
    options: ['Lubricate with oil', 'Keep clean and free of oil/grease, secure cylinders and use suitable equipment', 'Store loose near heat', 'Use damaged regulators'],
    correctAnswer: 1,
    explanation: 'Oxygen accelerates combustion; oil or grease can ignite violently. Cylinders must be secured and handled according to supplier and site rules.',
    siteExample: 'The gas store rejects a contaminated regulator and secures cylinders upright in the designated ventilated area.',
  ),
  AbuDhabiHseQuestion(
    id: 118, topic: 'Hot Work',
    question: 'What is required for hot work inside a confined space?',
    options: ['Hot-work permit only', 'Coordinate hot-work controls with confined-space entry, atmosphere, ventilation, isolation and rescue requirements', 'Use oxygen for ventilation', 'Allow unmonitored entry'],
    correctAnswer: 1,
    explanation: 'Hot work adds ignition, fume and oxygen-consumption hazards to confined-space risks. Both control systems must be integrated.',
    siteExample: 'A tank welding task is not released until entry authorization, gas testing, ventilation, fire controls and rescue readiness are verified.',
  ),
  AbuDhabiHseQuestion(
    id: 119, topic: 'Hot Work',
    question: 'How should welding fumes be controlled?',
    options: ['Ignore if outdoors', 'Use suitable local exhaust/ventilation and respiratory protection based on assessment', 'Stand in the plume', 'Use a fan that spreads fumes to others'],
    correctAnswer: 1,
    explanation: 'Welding fumes can contain hazardous metals and gases. Control at source where practicable and select PPE from the assessment.',
    siteExample: 'A welder uses local extraction and the supervisor checks ventilation effectiveness and required respiratory protection.',
  ),
  AbuDhabiHseQuestion(
    id: 120, topic: 'Hot Work',
    question: 'What is a proper hot-work closeout?',
    options: ['Leave slag and cylinders', 'Stop equipment, inspect for fire, maintain required fire watch, remove hazards and close permit formally', 'Leave the permit open indefinitely', 'Allow others to enter immediately'],
    correctAnswer: 1,
    explanation: 'Closeout verifies the area is safe after work and any required fire watch/monitoring is completed before permit closure.',
    siteExample: 'After cutting, the fire watch checks the work area and adjacent spaces, and the permit issuer completes handback.',
  ),
  AbuDhabiHseQuestion(
    id: 121, topic: 'Lifting & Rigging',
    question: 'What should a lifting plan address?',
    options: ['Only crane color', 'Load weight, radius, equipment capacity, rigging, ground, route, people and communication', 'Only operator name', 'No weather conditions'],
    correctAnswer: 1,
    explanation: 'A lift plan coordinates equipment selection, load characteristics, rigging, ground bearing, exclusion zones and task interfaces.',
    siteExample: 'Before lifting a generator, the team verifies weight, crane chart at planned radius, sling arrangement and ground support.',
  ),
  AbuDhabiHseQuestion(
    id: 122, topic: 'Lifting & Rigging',
    question: 'What does sling WLL/SWL indicate?',
    options: ['Unlimited strength', 'Rated capacity under stated conditions and configuration', 'The weight of the sling only', 'Permission to use damaged slings'],
    correctAnswer: 1,
    explanation: 'Rigging capacity depends on rating, angle, hitch, condition and configuration. Follow manufacturer markings and the lift plan.',
    siteExample: 'The rigger checks sling identification and capacity for the planned hitch and angle before attaching the load.',
  ),
  AbuDhabiHseQuestion(
    id: 123, topic: 'Lifting & Rigging',
    question: 'What should be done with a damaged or unidentified sling?',
    options: ['Use for a light load', 'Remove from service and report for competent inspection/disposal', 'Tie a knot in it', 'Paint over the tag'],
    correctAnswer: 1,
    explanation: 'Damage or missing identification prevents reliable capacity verification and may indicate failure risk.',
    siteExample: 'A sling with cut fibers and unreadable tag is quarantined and replaced with a verified item.',
  ),
  AbuDhabiHseQuestion(
    id: 124, topic: 'Lifting & Rigging',
    question: 'Where should a banksman stand during a lift?',
    options: ['Under the load', 'In a safe position with clear view/communication, outside the danger zone', 'Between load and fixed object', 'On the crane hook'],
    correctAnswer: 1,
    explanation: 'The banksman must avoid crush zones and maintain agreed signals or radio communication with the operator.',
    siteExample: 'The banksman guides the crane from a protected location and stops the lift if visibility or communication is lost.',
  ),
  AbuDhabiHseQuestion(
    id: 125, topic: 'Lifting & Rigging',
    question: 'What is the rule for people beneath suspended loads?',
    options: ['Allowed with hard hats', 'Keep people out of the suspended-load exclusion zone', 'Allowed for short periods', 'Only supervisors may stand there'],
    correctAnswer: 1,
    explanation: 'A dropped or shifting load can be fatal. Establish and enforce an exclusion zone and never pass loads over people where avoidable.',
    siteExample: 'Barricades keep workers clear while a steel beam is hoisted into position.',
  ),
  AbuDhabiHseQuestion(
    id: 126, topic: 'Lifting & Rigging',
    question: 'What must be assessed for crane outrigger placement?',
    options: ['Only distance to office', 'Ground bearing capacity, underground voids/services, edge distance and matting requirements', 'Only paint markings', 'Whether the operator is confident'],
    correctAnswer: 1,
    explanation: 'Crane stability depends on ground support and outrigger reactions. Competent planning and suitable mats/spreaders are required as designed.',
    siteExample: 'Before setup near a trench, the lift team checks ground capacity and positions outriggers per the approved plan.',
  ),
  AbuDhabiHseQuestion(
    id: 127, topic: 'Risk Assessment & JSA',
    question: 'What is a hazard?',
    options: ['The likelihood of harm', 'A source or situation with potential to cause injury, ill health or damage', 'A completed permit', 'A safety score'],
    correctAnswer: 1,
    explanation: 'A hazard is the potential source of harm; risk considers likelihood and consequence in the context of exposure and controls.',
    siteExample: 'An unguarded rotating shaft is identified as a hazard; entanglement is a potential consequence.',
  ),
  AbuDhabiHseQuestion(
    id: 128, topic: 'Risk Assessment & JSA',
    question: 'Which control is generally preferred in the hierarchy?',
    options: ['PPE', 'Elimination of the hazard', 'Warning signs only', 'Administrative reminder'],
    correctAnswer: 1,
    explanation: 'Elimination removes the hazard and is preferred where reasonably practicable; lower-level controls are used when needed.',
    siteExample: 'The team assembles a component at ground level to eliminate the need for repeated work at height.',
  ),
  AbuDhabiHseQuestion(
    id: 129, topic: 'Risk Assessment & JSA',
    question: 'What does a Job Safety Analysis (JSA) typically contain?',
    options: ['Only worker names', 'Job steps, hazards, consequences and task-specific controls', 'Only final score', 'A list of company holidays'],
    correctAnswer: 1,
    explanation: 'A JSA breaks work into steps and links each step to hazards and controls so the crew can understand the safe method.',
    siteExample: 'A pipe installation JSA covers unloading, lifting, alignment, bolting and testing, with controls for each stage.',
  ),
  AbuDhabiHseQuestion(
    id: 130, topic: 'Risk Assessment & JSA',
    question: 'What is residual risk?',
    options: ['Risk before any controls', 'Risk remaining after selected controls are implemented', 'A risk that can be ignored', 'Only financial cost'],
    correctAnswer: 1,
    explanation: 'Residual risk is reassessed after controls. If unacceptable, add controls or change the method before proceeding.',
    siteExample: 'After installing edge protection, the team reassesses remaining fall risk and confirms access and supervision controls.',
  ),
  AbuDhabiHseQuestion(
    id: 131, topic: 'Risk Assessment & JSA',
    question: 'What should happen if wind causes a suspended load to swing?',
    options: ['Continue faster', 'Stop the lift safely, clear people and reassess conditions and controls', 'Stand under the load to steady it', 'Increase load radius without review'],
    correctAnswer: 1,
    explanation: 'Dynamic conditions can make the lift unsafe. Pause and follow the lift plan\'s stop-work and recovery method.',
    siteExample: 'The banksman signals stop when a panel swings; the crane operator stabilizes it and the lift supervisor reviews wind and control measures.',
  ),
  AbuDhabiHseQuestion(
    id: 132, topic: 'Risk Assessment & JSA',
    question: 'When should a risk assessment be reviewed?',
    options: ['Only once per year regardless of change', 'When tasks, conditions, equipment, personnel or incident findings change, and at planned review points', 'Only after a client asks', 'Never after a near miss'],
    correctAnswer: 1,
    explanation: 'Risk assessments must remain suitable and sufficient as conditions change; incidents and near misses can reveal control gaps.',
    siteExample: 'A near miss during material unloading prompts review of the JSA, vehicle route and pedestrian segregation.',
  ),
  AbuDhabiHseQuestion(
    id: 133, topic: 'Fire & Emergency',
    question: 'What are the three elements of the fire triangle?',
    options: ['Water, smoke, ash', 'Heat, fuel and oxygen', 'Wind, dust and sound', 'Metal, glass and air'],
    correctAnswer: 1,
    explanation: 'Fire requires heat, fuel and oxygen; removing or controlling one element can prevent or extinguish combustion when appropriate.',
    siteExample: 'The site removes combustible waste and controls ignition sources to reduce fire potential.',
  ),
  AbuDhabiHseQuestion(
    id: 134, topic: 'Fire & Emergency',
    question: 'What is appropriate for an energized electrical fire?',
    options: ['Water jet', 'Raise alarm, use a suitable rated extinguisher only if trained and safe, and isolate power if safe', 'Touch the panel', 'Ignore the alarm'],
    correctAnswer: 1,
    explanation: 'Electrical fires require suitable extinguishing media and safe isolation. Evacuate and call responders if the fire is not immediately controllable.',
    siteExample: 'A small electrical panel fire triggers alarm; a trained person uses suitable equipment only if escape remains safe.',
  ),
  AbuDhabiHseQuestion(
    id: 135, topic: 'Fire & Emergency',
    question: 'What should workers do when the site alarm sounds?',
    options: ['Finish the task first', 'Stop safely, follow evacuation route and proceed to designated assembly point', 'Hide in a storage room', 'Return for personal belongings'],
    correctAnswer: 1,
    explanation: 'Emergency procedures require prompt evacuation by safe routes and following instructions from wardens/responders.',
    siteExample: 'Workers leave the workface by the marked route and report to the assembly point.',
  ),
  AbuDhabiHseQuestion(
    id: 136, topic: 'Fire & Emergency',
    question: 'Why is accountability at the assembly point important?',
    options: ['To delay rescue', 'To identify missing persons and provide reliable information to responders', 'To record production', 'To permit early re-entry'],
    correctAnswer: 1,
    explanation: 'Roll call or other accountability helps responders locate potentially missing people. No one should re-enter without authorization.',
    siteExample: 'The supervisor checks the crew list and reports a missing worker\'s last known location to incident command.',
  ),
  AbuDhabiHseQuestion(
    id: 137, topic: 'Fire & Emergency',
    question: 'What should be done if smoke is detected in a confined space?',
    options: ['Enter immediately without equipment', 'Raise alarm, prevent unauthorized entry and activate the planned emergency response', 'Send another worker to look', 'Switch off all communications'],
    correctAnswer: 1,
    explanation: 'Unplanned rescue entry can create multiple casualties. Use trained rescue teams and the established plan.',
    siteExample: 'The attendant alarms responders and keeps others out while trained rescue personnel prepare the planned retrieval.',
  ),
  AbuDhabiHseQuestion(
    id: 138, topic: 'Fire & Emergency',
    question: 'What supports effective emergency preparedness?',
    options: ['A plan kept unknown to workers', 'Current plans, trained roles, communications, suitable equipment and drills', 'Only an emergency phone number', 'No practice'],
    correctAnswer: 1,
    explanation: 'Preparedness requires arrangements that are communicated, resourced, practiced and reviewed after changes or drills.',
    siteExample: 'A site conducts an evacuation drill, records timing and observations, and closes corrective actions.',
  ),
  AbuDhabiHseQuestion(
    id: 139, topic: 'Incident Investigation',
    question: 'What is the first priority after an incident?',
    options: ['Collect blame statements', 'Protect people, provide emergency response and prevent further harm', 'Resume production', 'Delete records'],
    correctAnswer: 1,
    explanation: 'Immediate response prioritizes life safety, first aid/emergency services, scene control and preventing secondary incidents.',
    siteExample: 'After a fall, the supervisor secures the area, activates emergency response and prevents others entering the hazard zone.',
  ),
  AbuDhabiHseQuestion(
    id: 140, topic: 'Incident Investigation',
    question: 'Why should near misses be reported?',
    options: ['They have no value', 'They reveal hazards and control weaknesses before injury occurs', 'Only to punish workers', 'Only if equipment is damaged'],
    correctAnswer: 1,
    explanation: 'Near-miss reporting enables learning and preventive action even when no injury occurred.',
    siteExample: 'A dropped tool with no injury leads to review of tool tethering and exclusion-zone controls.',
  ),
  AbuDhabiHseQuestion(
    id: 141, topic: 'Incident Investigation',
    question: 'What is useful evidence in an investigation?',
    options: ['Rumors', 'Factual observations, records, photos where appropriate and witness accounts, collected safely', 'Edited messages only', 'Assumptions about intent'],
    correctAnswer: 1,
    explanation: 'Evidence should be factual, relevant, preserved appropriately and handled with respect for privacy and site procedures.',
    siteExample: 'Investigators record equipment condition, permit/JSA versions and witness accounts without altering the scene unnecessarily.',
  ),
  AbuDhabiHseQuestion(
    id: 142, topic: 'Incident Investigation',
    question: 'What is root cause analysis intended to identify?',
    options: ['Only the person closest to event', 'Underlying task, equipment, system and management factors that allowed the event', 'A quick label', 'A way to avoid corrective action'],
    correctAnswer: 1,
    explanation: 'Root cause analysis looks beyond immediate acts to contributing conditions and system weaknesses so actions prevent recurrence.',
    siteExample: 'A dropped load investigation examines rigging selection, planning, supervision and equipment inspection rather than stopping at \'operator error\'.',
  ),
  AbuDhabiHseQuestion(
    id: 143, topic: 'Incident Investigation',
    question: 'What makes a corrective action effective?',
    options: ['No owner or deadline', 'Defined owner, due date, risk-based action and verification of effectiveness', 'A verbal promise', 'Closing the report immediately'],
    correctAnswer: 1,
    explanation: 'Actions need accountability and follow-up to confirm the control works and recurrence risk is reduced.',
    siteExample: 'The project assigns an engineer to install a physical barrier by a due date and verifies it during a follow-up inspection.',
  ),
  AbuDhabiHseQuestion(
    id: 144, topic: 'Incident Investigation',
    question: 'How should lessons learned be shared?',
    options: ['Publish personal details widely', 'Share verified relevant findings and controls while protecting personal information', 'Hide all findings', 'Blame a named worker'],
    correctAnswer: 1,
    explanation: 'Lessons should be accurate, practical and communicated to relevant teams without unnecessary personal data.',
    siteExample: 'A site briefing shares the revised lifting-zone control after a near miss, without circulating private medical information.',
  ),
  AbuDhabiHseQuestion(
    id: 145, topic: 'PPE, Training & Competency',
    question: 'How should PPE be selected?',
    options: ['By color preference', 'Based on risk assessment, task, fit, compatibility and applicable requirements', 'Use the same PPE for every hazard', 'Choose the cheapest item only'],
    correctAnswer: 1,
    explanation: 'PPE is a last line of defense and must be suitable, compatible, maintained and correctly worn; higher-level controls remain necessary.',
    siteExample: 'A worker handling wet concrete receives suitable gloves, eye protection and boots based on the task assessment.',
  ),
  AbuDhabiHseQuestion(
    id: 146, topic: 'PPE, Training & Competency',
    question: 'What should be done with a damaged safety harness?',
    options: ['Continue until next inspection', 'Remove it from service and replace or manage under competent inspection procedure', 'Tie a knot in the webbing', 'Share it with another worker'],
    correctAnswer: 1,
    explanation: 'Fall-protection equipment with damage or uncertain history must not be used; inspection and traceability follow manufacturer and site requirements.',
    siteExample: 'A harness with damaged stitching is tagged out and replaced before the worker resumes the task.',
  ),
  AbuDhabiHseQuestion(
    id: 147, topic: 'PPE, Training & Competency',
    question: 'What should site induction cover?',
    options: ['Only payroll', 'Site hazards, emergency arrangements, rules, reporting and relevant access requirements', 'Only company history', 'No worker questions'],
    correctAnswer: 1,
    explanation: 'Induction gives workers essential site-specific information and should be understood, recorded and refreshed when needed.',
    siteExample: 'A new subcontractor receives induction on traffic routes, emergency assembly point, PPE, permit rules and hazard reporting.',
  ),
  AbuDhabiHseQuestion(
    id: 148, topic: 'PPE, Training & Competency',
    question: 'What is required for a MEWP operator?',
    options: ['A general driving license alone', 'Task-specific training, competence, machine familiarization and site authorization', 'Only a toolbox talk', 'No verification'],
    correctAnswer: 1,
    explanation: 'MEWP operation requires evidence of competence for the equipment and conditions, plus familiarization and authorization under site rules.',
    siteExample: 'Before use, the supervisor verifies the operator\'s training and checks familiarization with the particular model\'s emergency controls.',
  ),
  AbuDhabiHseQuestion(
    id: 149, topic: 'PPE, Training & Competency',
    question: 'What is the purpose of a toolbox talk?',
    options: ['Replace the JSA', 'Brief the crew on task hazards, controls, changes and stop-work expectations', 'Guarantee no incidents', 'Record attendance only'],
    correctAnswer: 1,
    explanation: 'Toolbox talks communicate the safe method and allow workers to raise concerns; they supplement formal assessments and permits.',
    siteExample: 'Before a lift, the supervisor reviews load path, exclusion zone, signals, weather and stop-work triggers with the crew.',
  ),
  AbuDhabiHseQuestion(
    id: 150, topic: 'PPE, Training & Competency',
    question: 'How can training effectiveness be verified?',
    options: ['Attendance signature only', 'Knowledge checks, practical observation and reassessment where appropriate', 'Assume everyone understood', 'Count posters'],
    correctAnswer: 1,
    explanation: 'Attendance records show participation but not necessarily competence. Verification should match the skill and risk.',
    siteExample: 'After a practical fire-extinguisher session, the trainer observes each participant demonstrate safe use and corrects gaps.',
  ),
];

class AbuDhabiHseSafetyQuizPage extends StatefulWidget {
  const AbuDhabiHseSafetyQuizPage({super.key});

  @override
  State<AbuDhabiHseSafetyQuizPage> createState() =>
      _AbuDhabiHseSafetyQuizPageState();
}

class _AbuDhabiHseSafetyQuizPageState
    extends State<AbuDhabiHseSafetyQuizPage> {
  static const int _totalQuestions = 150;
  static const int _passMark = 105;
  static const Color _green = Color(0xFF075E46);
  static const Color _pageBackground = Color(0xFFF4F7F5);

  int currentIndex = 0;
  int score = 0;
  bool answered = false;
  bool finished = false;
  bool reviewMode = false;
  final Map<int, int> selectedAnswers = {};
  List<int> reviewIndices = [];
  int reviewPosition = 0;

  AbuDhabiHseQuestion get currentQuestion =>
      abuDhabiHse150Questions[currentIndex];

  int get wrongCount => selectedAnswers.entries
      .where((entry) =>
          abuDhabiHse150Questions[entry.key].correctAnswer != entry.value)
      .length;

  void selectAnswer(int optionIndex) {
    if (answered || finished || reviewMode) return;
    setState(() {
      selectedAnswers[currentIndex] = optionIndex;
      answered = true;
      if (optionIndex == currentQuestion.correctAnswer) score++;
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

    if (currentIndex < _totalQuestions - 1) {
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
        .where((entry) =>
            abuDhabiHse150Questions[entry.key].correctAnswer != entry.value)
        .map((entry) => entry.key)
        .toList()
      ..sort();

    if (reviewIndices.isEmpty) return;
    setState(() {
      reviewMode = true;
      finished = false;
      reviewPosition = 0;
      currentIndex = reviewIndices.first;
      answered = true;
    });
  }

  Color optionColor(int optionIndex) {
    if (!answered) return Colors.white;
    if (optionIndex == currentQuestion.correctAnswer) {
      return Colors.green.shade100;
    }
    if (selectedAnswers[currentIndex] == optionIndex) {
      return Colors.red.shade100;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    if (finished) return _buildResult();

    return Scaffold(
      backgroundColor: _pageBackground,
      appBar: AppBar(
        title: Text(
          reviewMode ? 'Review Wrong Answers' : 'Abu Dhabi HSE Safety Quiz',
        ),
        backgroundColor: _green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: restartQuiz,
            tooltip: 'Restart Quiz',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProgress(),
              const SizedBox(height: 12),
                    Text(
                      currentQuestion.topic,
                      style: const TextStyle(
                        color: _green,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currentQuestion.question,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1.28,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ...List.generate(4, (optionIndex) {
                      final correct =
                          optionIndex == currentQuestion.correctAnswer;
                      final selected =
                          selectedAnswers[currentIndex] == optionIndex;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 9),
                        child: InkWell(
                          onTap: () => selectAnswer(optionIndex),
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 11,
                            ),
                            decoration: BoxDecoration(
                              color: optionColor(optionIndex),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: answered && correct
                                    ? Colors.green
                                    : answered && selected
                                        ? Colors.red
                                        : Colors.grey.shade300,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: _green,
                                  child: Text(
                                    String.fromCharCode(65 + optionIndex),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 9),
                                Expanded(
                                  child: Text(
                                    currentQuestion.options[optionIndex],
                                    style: const TextStyle(
                                      fontSize: 15.5,
                                      height: 1.2,
                                    ),
                                  ),
                                ),
                                if (answered && correct)
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                if (answered && selected && !correct)
                                  const Icon(Icons.cancel, color: Colors.red),
                              ],
                            ),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedAnswers[currentIndex] ==
                                      currentQuestion.correctAnswer
                                  ? '✓ Correct Answer'
                                  : '✗ Incorrect Answer',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: selectedAnswers[currentIndex] ==
                                        currentQuestion.correctAnswer
                                    ? Colors.green.shade800
                                    : Colors.red.shade800,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Technical Explanation',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              currentQuestion.explanation,
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.25,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Practical UAE Site Example',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              currentQuestion.siteExample,
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: nextQuestion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            reviewMode
                                ? (reviewPosition + 1 == reviewIndices.length
                                    ? 'Finish Review'
                                    : 'Next Wrong Answer')
                                : (currentIndex == _totalQuestions - 1
                                    ? 'View Final Result'
                                    : 'Next Question →'),
                          ),
                        ),
                      ),
                    ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgress() => Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  reviewMode
                      ? 'Review: ${reviewPosition + 1} / ${reviewIndices.length}'
                      : 'Progress: ${currentIndex + 1} / $_totalQuestions',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Score: $score',
                  style: const TextStyle(
                    color: _green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: reviewMode
                  ? (reviewPosition + 1) / reviewIndices.length
                  : (currentIndex + 1) / _totalQuestions,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              color: const Color(0xFF16A34A),
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
      );

  Widget _buildResult() {
    final passed = score >= _passMark;
    final percentage = (score / _totalQuestions * 100).round();

    return Scaffold(
      backgroundColor: _pageBackground,
      appBar: AppBar(
        title: const Text('Quiz Result'),
        backgroundColor: _green,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Icon(
                  passed ? Icons.emoji_events : Icons.school,
                  size: 90,
                  color: passed ? Colors.amber : Colors.orange,
                ),
                const SizedBox(height: 20),
                Text(
                  passed ? 'Congratulations!' : 'Keep Learning!',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '$score / $_totalQuestions',
                  style: const TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                    color: _green,
                  ),
                ),
                Text(
                  '$percentage%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: passed
                        ? Colors.green.shade100
                        : Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    passed ? 'PASS – 70% Threshold' : 'NEEDS IMPROVEMENT',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: passed
                          ? Colors.green.shade900
                          : Colors.orange.shade900,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _resultRow('Total Questions', '$_totalQuestions'),
                _resultRow('Correct Answers', '$score'),
                _resultRow('Wrong Answers', '$wrongCount'),
                _resultRow('Pass Mark', '$_passMark / $_totalQuestions (70%)'),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: restartQuiz,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retake Quiz'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (wrongCount > 0)
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: reviewWrongAnswers,
                      icon: const Icon(Icons.menu_book),
                      label: Text('Review Wrong Answers ($wrongCount)'),
                    ),
                  ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  child: const Text('Back to Interview Levels'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _resultRow(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );
}
