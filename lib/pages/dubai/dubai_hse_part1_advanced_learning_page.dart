import 'package:flutter/material.dart';

/// SafeNexus HSE
/// Dubai HSE — Advanced Learning
/// Part 1: Topics 1–10
///
/// This is the dedicated Advanced Learning page.
/// Each topic has its own safety content, controls, inspection points,
/// stop-work conditions, role responsibilities and practical example.
/// Technical/legal requirements must follow the current applicable Dubai
/// requirement, approved project documents, competent-person assessment
/// and manufacturer instructions.

class DubaiHsePart1AdvancedLearningPage extends StatelessWidget {
  final String topicId;
  final String topicTitle;

  const DubaiHsePart1AdvancedLearningPage({
    super.key,
    required this.topicId,
    required this.topicTitle,
  });

  static const Map<String, List<DubaiAdvancedSection>> _topics = {
    'dubai_construction_safety_framework': [
      DubaiAdvancedSection('Introduction — What is the Construction Safety Framework?', [
        'The construction safety framework is the overall structure used to govern HSE during project planning, construction, supervision, monitoring and close-out.',
        'It connects legal requirements, project requirements, contractor systems, competent-person arrangements and workface controls.',
      ]),
      DubaiAdvancedSection('1. Governance & HSE Structure', [
        'Define client, consultant, principal contractor, subcontractor and workforce responsibilities.',
        'Establish clear reporting lines and escalation routes for significant risks.',
        'Give competent HSE personnel authority to intervene and stop unsafe work.',
      ]),
      DubaiAdvancedSection('2. Project HSE Planning', [
        'Identify construction phases, high-risk activities, interfaces and resources before work begins.',
        'Link the HSE plan with RAMS, risk assessments, permits, emergency arrangements and inspection programmes.',
        'Review the plan when project scope, design or execution strategy changes.',
      ]),
      DubaiAdvancedSection('3. Site Safety Controls', [
        'Use induction, toolbox talks, supervision, access control, barricading, housekeeping and task-specific controls.',
        'Verify critical controls physically at the workface rather than relying only on documents.',
        'Control simultaneous operations through coordination and permit systems where required.',
      ]),
      DubaiAdvancedSection('4. Main Framework Hazards', [
        'Weak management ownership.',
        'Unclear responsibilities.',
        'Inadequate competent-person arrangements.',
        'Poor contractor coordination.',
        'Missing critical controls.',
        'Repeated unresolved findings.',
      ]),
      DubaiAdvancedSection('5. Safety Controls', [
        'Maintain a documented HSE organization and escalation process.',
        'Set measurable HSE objectives and leading indicators.',
        'Conduct planned inspections and audits.',
        'Track corrective actions to verified closure.',
        'Use incident and near-miss learning to improve controls.',
      ]),
      DubaiAdvancedSection('6. Inspection & Assurance', [
        'Verify that the project HSE system is implemented in the field.',
        'Check high-risk activities, permits, competence, equipment and emergency readiness.',
        'Escalate repeated or critical non-conformities to project management.',
      ]),
      DubaiAdvancedSection('7. Stop-Work Conditions', [
        'Critical safety controls are absent or ineffective.',
        'Work is materially different from the approved method.',
        'Competent supervision is unavailable for a critical activity.',
        'An immediate danger to people, property or the public exists.',
      ]),
      DubaiAdvancedSection('8. HSE Responsibilities', [
        'HSE Officer: field monitoring, observations and immediate reporting.',
        'HSE Supervisor: daily HSE supervision and workforce control.',
        'Senior HSE: assurance, trend review and escalation.',
        'HSE Coordinator: interfaces, documentation and action coordination.',
        'HSE Engineer: technical risk and control assurance.',
        'HSE Manager: governance, resources, leadership and system effectiveness.',
      ]),
      DubaiAdvancedSection('9. Practical Site Example', [
        'A contractor starts structural work with several subcontractors working simultaneously. The HSE team checks the approved HSE plan, RAMS, permits, competence, access, lifting interfaces and emergency arrangements before authorizing the activity.',
        'During the shift, a critical control is found missing. Work is stopped, the control is restored and the area is re-verified before restart.',
      ]),
      DubaiAdvancedSection('10. Quick Learning Formula', [
        'Plan → Assign → Control → Verify → Monitor → Correct → Learn.',
      ]),
    ],

    'dubai_hse_management_system': [
      DubaiAdvancedSection('Introduction — What is an HSE Management System?', [
        'An HSE management system provides a structured method to plan, implement, check and improve safety performance.',
        'It turns HSE expectations into procedures, responsibilities, resources, records and measurable actions.',
      ]),
      DubaiAdvancedSection('1. Leadership & Policy', [
        'Set clear HSE expectations from project management.',
        'Provide adequate manpower, equipment, training and emergency resources.',
        'Demonstrate visible leadership through site engagement and follow-up.',
      ]),
      DubaiAdvancedSection('2. Planning & Objectives', [
        'Identify significant risks and establish measurable objectives.',
        'Define leading indicators such as inspections, observations, training and action closure.',
        'Define lagging indicators such as incidents and occupational cases.',
      ]),
      DubaiAdvancedSection('3. Implementation', [
        'Maintain procedures, RAMS, permits, inductions and competency systems.',
        'Ensure workers understand the controls relevant to their tasks.',
        'Coordinate subcontractors and simultaneous operations.',
      ]),
      DubaiAdvancedSection('4. System Hazards', [
        'Paper-based compliance without field implementation.',
        'Uncontrolled document changes.',
        'Weak action closure.',
        'Poor communication.',
        'Inadequate competence verification.',
      ]),
      DubaiAdvancedSection('5. Safety Controls', [
        'Use document control and approval processes.',
        'Maintain training and authorization records.',
        'Use planned inspection and audit programmes.',
        'Assign corrective actions with responsible persons and due dates.',
        'Verify effectiveness after closure.',
      ]),
      DubaiAdvancedSection('6. Monitoring & Audit', [
        'Compare planned controls with actual field conditions.',
        'Trend observations and recurring findings.',
        'Review significant incidents and lessons learned.',
      ]),
      DubaiAdvancedSection('7. Stop-Work Conditions', [
        'A critical procedure is unavailable or not approved.',
        'Required competence or supervision is absent.',
        'Critical controls are repeatedly bypassed.',
        'Immediate uncontrolled risk is present.',
      ]),
      DubaiAdvancedSection('8. HSE Responsibilities', [
        'HSE Officer: records, observations and field verification.',
        'HSE Supervisor: daily implementation and workforce engagement.',
        'Senior HSE: system assurance and trend analysis.',
        'HSE Coordinator: reporting, interfaces and action tracking.',
        'HSE Engineer: technical system and risk-control support.',
        'HSE Manager: management review, governance and continual improvement.',
      ]),
      DubaiAdvancedSection('9. Practical Site Example', [
        'A recurring housekeeping observation appears across several work fronts. Instead of closing individual observations only, the HSE team identifies the system weakness, assigns ownership, introduces supervisor checks and verifies improvement through trend monitoring.',
      ]),
      DubaiAdvancedSection('10. Quick Learning Formula', [
        'Policy → Plan → Implement → Check → Correct → Improve.',
      ]),
    ],

    'dubai_health_safety_risk_assessment': [
      DubaiAdvancedSection('Introduction — What is Risk Assessment?', [
        'Risk assessment is the structured process of identifying hazards, evaluating risk and selecting controls before and during work.',
        'The assessment must reflect the actual task, environment, equipment, people and interfaces.',
      ]),
      DubaiAdvancedSection('1. Assessment Process', [
        'Define the activity and work boundaries.',
        'Identify hazards and people who may be affected.',
        'Evaluate likelihood and consequence using the approved project matrix.',
        'Select controls using the hierarchy of controls.',
        'Determine residual risk and communicate critical controls.',
      ]),
      DubaiAdvancedSection('2. Task-Specific Inputs', [
        'Work sequence.',
        'Plant and equipment.',
        'Materials and chemicals.',
        'Workforce competence.',
        'Access and egress.',
        'Nearby activities and public interfaces.',
        'Weather and environmental conditions.',
      ]),
      DubaiAdvancedSection('3. Main Risk Assessment Failures', [
        'Copy-paste assessments that do not match the job.',
        'Controls written but not implemented.',
        'No review after change.',
        'Workers not briefed.',
        'Critical controls not identified.',
      ]),
      DubaiAdvancedSection('4. Safety Controls', [
        'Eliminate the hazard where reasonably practicable.',
        'Use engineering controls before administrative controls.',
        'Use clear method statements and supervision.',
        'Use PPE as the final layer of protection where required.',
        'Verify controls at the workface.',
      ]),
      DubaiAdvancedSection('5. Dynamic Review', [
        'Review after changes in design, method, equipment, location, weather or workforce.',
        'Reassess after incidents, near misses or unexpected site conditions.',
        'Suspend work until significant new risks are controlled.',
      ]),
      DubaiAdvancedSection('6. Inspection & Verification', [
        'Supervisors confirm critical controls before starting.',
        'HSE personnel verify high-risk controls during field inspections.',
        'Record deviations and track corrective actions.',
      ]),
      DubaiAdvancedSection('7. Stop-Work Conditions', [
        'Critical control missing.',
        'Risk is higher than the approved assessment.',
        'Unplanned condition creates significant exposure.',
        'Workforce does not understand the required controls.',
      ]),
      DubaiAdvancedSection('8. HSE Responsibilities', [
        'HSE Officer: participate in field hazard identification and verification.',
        'HSE Supervisor: ensure crew-level controls are understood and followed.',
        'Senior HSE: challenge significant risk assessments.',
        'HSE Coordinator: coordinate interfaces and assessment reviews.',
        'HSE Engineer: provide technical risk-control review.',
        'HSE Manager: ensure significant risks receive appropriate management attention and resources.',
      ]),
      DubaiAdvancedSection('9. Practical Site Example', [
        'A work method changes because of restricted access. The supervisor stops the task, the RAMS is reviewed, new hazards are assessed, controls are agreed and the workforce is re-briefed before restarting.',
      ]),
      DubaiAdvancedSection('10. Quick Learning Formula', [
        'Identify → Assess → Control → Communicate → Verify → Review.',
      ]),
    ],

    'dubai_construction_hse_plan': [
      DubaiAdvancedSection('Introduction — What is a Construction HSE Plan?', [
        'The construction HSE plan describes how safety will be managed throughout project execution.',
        'It provides the project-level framework that connects management, contractors, risk controls, emergency arrangements and performance monitoring.',
      ]),
      DubaiAdvancedSection('1. Project Scope & HSE Organization', [
        'Define work phases, packages, interfaces and significant risks.',
        'Identify HSE leadership, competent persons, supervisors and operational responsibilities.',
      ]),
      DubaiAdvancedSection('2. Risk & RAMS Management', [
        'Define how risk assessments, method statements and RAMS are prepared, reviewed, approved and communicated.',
        'Ensure task controls reflect actual site conditions.',
      ]),
      DubaiAdvancedSection('3. Training & Competence', [
        'Establish induction requirements.',
        'Identify task-specific training and authorization.',
        'Verify certificates and competence for safety-critical roles.',
      ]),
      DubaiAdvancedSection('4. Emergency Planning', [
        'Cover credible scenarios such as fire, medical emergency, collapse, fall, lifting incident, electrical incident and environmental emergency.',
        'Define alarm, communication, access, rescue, first aid and external emergency interfaces.',
      ]),
      DubaiAdvancedSection('5. HSE Plan Hazards', [
        'Incomplete project planning.',
        'Poor contractor integration.',
        'Unclear emergency roles.',
        'Insufficient resources.',
        'Uncontrolled changes.',
      ]),
      DubaiAdvancedSection('6. Safety Controls', [
        'Maintain approved procedures and clear responsibilities.',
        'Link inspection and audit programmes to project risk.',
        'Review the plan during major project changes.',
      ]),
      DubaiAdvancedSection('7. Inspection & Monitoring', [
        'Monitor leading and lagging indicators.',
        'Track inspections, audits, observations, incidents and corrective actions.',
        'Report significant trends to management.',
      ]),
      DubaiAdvancedSection('8. Stop-Work Conditions', [
        'Major activity starts without required planning or controls.',
        'Emergency arrangements are not available for a high-risk activity.',
        'Critical contractor controls are not integrated.',
      ]),
      DubaiAdvancedSection('9. HSE Responsibilities', [
        'HSE Officer: verify field implementation.',
        'HSE Supervisor: supervise daily execution.',
        'Senior HSE: assure plan effectiveness.',
        'HSE Coordinator: coordinate project interfaces.',
        'HSE Engineer: support technical planning.',
        'HSE Manager: lead approval, governance and performance review.',
      ]),
      DubaiAdvancedSection('10. Practical Site Example', [
        'Before a major construction phase, the project team reviews the HSE plan against the construction sequence, updates high-risk activity controls, confirms emergency resources and briefs all contractors before mobilization.',
      ]),
      DubaiAdvancedSection('11. Quick Learning Formula', [
        'Scope → Organize → Assess → Control → Train → Prepare → Monitor → Improve.',
      ]),
    ],

    'dubai_work_at_height': [
      DubaiAdvancedSection('Introduction — What is Work at Height?', [
        'Work at height is work where a person could fall a distance capable of causing injury. The risk depends on the task, location, access method and surrounding hazards.',
      ]),
      DubaiAdvancedSection('1. Access Systems', [
        'Scaffolds and mobile access towers.',
        'MEWPs and other approved powered access equipment.',
        'Ladders for suitable short-duration tasks where appropriate.',
        'Permanent or temporary access systems designed for the work.',
      ]),
      DubaiAdvancedSection('2. Fall Prevention', [
        'Avoid work at height where reasonably practicable.',
        'Use suitable platforms, guardrails and edge protection.',
        'Protect floor openings, shafts and fragile surfaces.',
      ]),
      DubaiAdvancedSection('3. Fall Protection', [
        'Where required, select a compatible restraint or fall-arrest system.',
        'Verify anchorage, clearance and rescue arrangements.',
        'Do not rely on PPE to compensate for poor access or missing collective protection.',
      ]),
      DubaiAdvancedSection('4. Main Hazards', [
        'Falls from edges.',
        'Falls through openings or fragile surfaces.',
        'Unsafe ladders or access equipment.',
        'Falling tools and materials.',
        'Uncontrolled MEWP movement.',
        'Adverse weather.',
      ]),
      DubaiAdvancedSection('5. Safety Controls', [
        'Provide compliant access and collective protection.',
        'Control tools and materials against falling.',
        'Maintain exclusion zones below overhead work.',
        'Inspect equipment before use.',
        'Ensure trained personnel and rescue arrangements.',
      ]),
      DubaiAdvancedSection('6. Inspection', [
        'Check platforms, guardrails, access, openings and fall-protection systems.',
        'Inspect ladders and access equipment for defects.',
        'Check environmental conditions and housekeeping.',
      ]),
      DubaiAdvancedSection('7. Stop-Work Conditions', [
        'Missing or damaged edge protection.',
        'Unsafe access.',
        'Unprotected fragile surface.',
        'Unsafe weather or visibility.',
        'Fall-arrest system without suitable rescue arrangements.',
      ]),
      DubaiAdvancedSection('8. HSE Responsibilities', [
        'HSE Officer: inspect access and fall controls.',
        'HSE Supervisor: control crews and prevent unsafe access.',
        'Senior HSE: assure high-risk work-at-height arrangements.',
        'HSE Coordinator: coordinate simultaneous work and exclusion zones.',
        'HSE Engineer: review technical access and fall-protection arrangements.',
        'HSE Manager: assure governance, competence and emergency capability.',
      ]),
      DubaiAdvancedSection('9. Practical Site Example', [
        'A façade crew is preparing work from a mobile access system. Before use, the team verifies the system condition, access, platform protection, environmental conditions, operator competence and exclusion zone. A damaged component is found, so the equipment is removed from service until corrected.',
      ]),
      DubaiAdvancedSection('10. Quick Learning Formula', [
        'Avoid → Prevent → Protect → Inspect → Rescue.',
      ]),
    ],

    'dubai_scaffolding_safety': [
      DubaiAdvancedSection('Introduction — What is Scaffolding?', [
        'Scaffolding is a temporary access and working platform system designed to provide safe access and support for construction activities.',
        'Its safety depends on suitable design/selection, stable support, correct erection, access, loading, inspection, tagging and controlled modification.',
      ]),
      DubaiAdvancedSection('1. Types of Scaffolding', [
        'Fixed/static scaffold.',
        'Independent scaffold.',
        'Tied scaffold.',
        'Mobile scaffold.',
        'Tower scaffold.',
        'Access scaffold.',
        'Birdcage scaffold.',
        'Suspended scaffold.',
        'Cantilever scaffold.',
        'System scaffold.',
        'Tube-and-fitting scaffold.',
        'Special-purpose scaffold.',
      ]),
      DubaiAdvancedSection('2. Scaffold Components', [
        'Standard, ledger and transom.',
        'Base plate, sole board, base jack and castor where applicable.',
        'Brace and tie.',
        'Coupler.',
        'Platform.',
        'Guardrail, intermediate rail and toe board.',
        'Ladder or scaffold stair.',
        'Scaffold status/tagging system.',
      ]),
      DubaiAdvancedSection('3. Technical Requirements', [
        'Provide a suitable foundation and stable support.',
        'Maintain required bracing, ties and structural configuration.',
        'Use components compatible with the scaffold system.',
        'Keep loading within the approved design/duty.',
        'Maintain safe access and edge protection.',
        'Use approved design or engineering arrangements where required.',
      ]),
      DubaiAdvancedSection('4. Main Hazards', [
        'Collapse or instability.',
        'Falls from platforms.',
        'Falling materials.',
        'Overloading.',
        'Unauthorized alteration.',
        'Unsafe access.',
        'Contact with electrical hazards.',
        'Adverse weather.',
      ]),
      DubaiAdvancedSection('5. Safety Controls', [
        'Use competent scaffold personnel.',
        'Maintain foundation, bracing and ties.',
        'Protect platforms and edges.',
        'Control materials and loading.',
        'Use clear status tagging.',
        'Prevent unauthorized removal of components.',
      ]),
      DubaiAdvancedSection('6. Inspection & Tagging', [
        'Inspect after erection and after events or alterations that could affect integrity.',
        'Carry out required periodic inspections under the project system.',
        'Clearly identify scaffold status and prevent use when unsafe.',
      ]),
      DubaiAdvancedSection('7. Stop-Work Conditions', [
        'Unstable or visibly damaged scaffold.',
        'Missing critical ties, braces, rails or platform protection.',
        'Unauthorized modification.',
        'Unsafe access.',
        'Overloading or uncontrolled material storage.',
      ]),
      DubaiAdvancedSection('8. HSE Responsibilities', [
        'HSE Officer: inspect tagging, access, loading and visible condition.',
        'HSE Supervisor: prevent unauthorized use or modification.',
        'Senior HSE: assure high-risk scaffold arrangements.',
        'HSE Coordinator: coordinate scaffold interfaces and handovers.',
        'HSE Engineer: review design/technical interfaces where required.',
        'HSE Manager: assure competent-person arrangements and governance.',
      ]),
      DubaiAdvancedSection('9. Practical Site Example', [
        'A scaffold is found with a removed tie to allow material movement. The area is stopped, access is controlled and the scaffold is reassessed by the competent scaffold team before any component is restored or work resumes.',
      ]),
      DubaiAdvancedSection('10. Quick Learning Formula', [
        'Foundation → Stability → Access → Protection → Load → Inspect → Tag → Control.',
      ]),
    ],

    'dubai_lifting_operations': [
      DubaiAdvancedSection('Introduction — What is a Lifting Operation?', [
        'A lifting operation is the planned movement of a load using a crane, hoist or other lifting appliance and suitable lifting accessories.',
      ]),
      DubaiAdvancedSection('1. Lifting Types', [
        'Mobile crane lifting.',
        'Tower crane lifting.',
        'Crawler crane lifting.',
        'Truck-mounted crane lifting.',
        'Hoist lifting.',
        'Personnel lifting using approved systems where permitted.',
        'Critical, complex or heavy lifting operations requiring additional planning.',
      ]),
      DubaiAdvancedSection('2. Equipment & Accessories', [
        'Crane or lifting appliance.',
        'Hook and safety latch.',
        'Wire rope or chain.',
        'Web sling and round sling.',
        'Shackle.',
        'Spreader/lifting beam.',
        'Tag line.',
        'Load indicator and relevant safety devices.',
      ]),
      DubaiAdvancedSection('3. Technical Requirements', [
        'Confirm equipment capacity for the actual configuration and operating radius.',
        'Verify ground conditions and support arrangements.',
        'Use suitable lifting accessories within approved capacity and condition.',
        'Maintain required clearances and controlled access.',
      ]),
      DubaiAdvancedSection('4. Lift Plan — How to Prepare It', [
        'Define load weight and dimensions.',
        'Determine centre of gravity and lifting points.',
        'Select crane and accessories.',
        'Confirm route, radius and landing area.',
        'Assess ground and environmental conditions.',
        'Define rigging method, communication and exclusion zone.',
        'Assign competent lifting team roles.',
        'Define emergency and stop-work criteria.',
      ]),
      DubaiAdvancedSection('5. Main Hazards', [
        'Dropped load.',
        'Crane instability.',
        'Overloading.',
        'Rigging failure.',
        'Personnel entering the suspended-load zone.',
        'Poor communication.',
        'Contact with structures or services.',
        'Adverse weather.',
      ]),
      DubaiAdvancedSection('6. Rigging & Load Control', [
        'Select suitable slings and shackles.',
        'Protect slings from sharp edges.',
        'Maintain correct sling angles and load balance.',
        'Secure connections and prevent uncontrolled rotation.',
        'Use tag lines where appropriate.',
      ]),
      DubaiAdvancedSection('7. Pre-Lift Inspection', [
        'Crane condition and required safety devices.',
        'Lifting accessories and identification.',
        'Ground/outrigger arrangements.',
        'Load, route and landing area.',
        'Communication system.',
        'Exclusion zone.',
        'Weather and visibility.',
      ]),
      DubaiAdvancedSection('8. Stop-Work Conditions', [
        'Unexpected load or configuration change.',
        'Damaged lifting accessory.',
        'Ground instability.',
        'Loss of communication.',
        'Unauthorized person inside exclusion zone.',
        'Unsafe weather or visibility.',
      ]),
      DubaiAdvancedSection('9. HSE & Rigger Responsibilities', [
        'HSE Officer: verify exclusion zone, permits, equipment condition and field controls.',
        'HSE Supervisor: control the workface and workforce behavior.',
        'Senior HSE: assure critical lifting arrangements.',
        'HSE Coordinator: coordinate interfaces and simultaneous operations.',
        'HSE Engineer: support technical lifting-risk review.',
        'HSE Manager: assure lifting governance and competent resources.',
        'Rigger: select and inspect accessories, rig the load correctly and control load connection.',
      ]),
      DubaiAdvancedSection('10. Practical Site Example', [
        'During an HVAC lift, the rigger verifies the load weight and lifting points, the crane team verifies configuration and ground support, the banksman establishes communication and the HSE team verifies the exclusion zone before the lift starts.',
      ]),
      DubaiAdvancedSection('11. Quick Learning Formula', [
        'Plan → Select → Inspect → Rig → Communicate → Exclude → Lift → Land.',
      ]),
    ],

    'dubai_excavation_trenching': [
      DubaiAdvancedSection('Introduction — What is Excavation?', [
        'Excavation is the removal of soil or other ground material to create trenches, foundations, shafts, manholes, utilities or other below-ground spaces.',
      ]),
      DubaiAdvancedSection('1. Types of Excavation', [
        'Open excavation.',
        'Trench excavation.',
        'Foundation excavation.',
        'Deep excavation.',
        'Utility excavation.',
        'Manhole/chamber excavation.',
      ]),
      DubaiAdvancedSection('2. Components & Protection Systems', [
        'Shoring.',
        'Trench box.',
        'Benching.',
        'Sloping.',
        'Edge protection.',
        'Barricade.',
        'Ladder/stair access.',
        'Spoil-pile control.',
        'Dewatering system.',
        'Underground-service identification and protection.',
      ]),
      DubaiAdvancedSection('3. Technical Requirements', [
        'Assess ground conditions and adjacent structures.',
        'Select an appropriate protective system based on the approved engineering/site method.',
        'Control excavation edges, access, water and plant interaction.',
        'Do not rely on generic dimensions where the approved design or current requirement specifies otherwise.',
      ]),
      DubaiAdvancedSection('4. Risk Assessment & Planning', [
        'Identify soil/ground risks, services, water, nearby structures, plant, traffic and worker access.',
        'Define the excavation sequence and protective system.',
        'Plan emergency response for collapse, flooding, service strike and fall.',
      ]),
      DubaiAdvancedSection('5. Main Hazards', [
        'Ground collapse.',
        'Falls into excavation.',
        'Underground service strike.',
        'Water ingress.',
        'Plant or vehicle falling/entering excavation.',
        'Spoil surcharge.',
        'Adjacent structure movement.',
      ]),
      DubaiAdvancedSection('6. Safety Controls', [
        'Use suitable shoring, trench box, benching or sloping.',
        'Provide safe access and egress.',
        'Control edges and spoil.',
        'Separate plant and people.',
        'Verify underground services.',
        'Control water and inspect after adverse events.',
      ]),
      DubaiAdvancedSection('7. Inspection', [
        'Competent-person inspection before entry.',
        'Reinspection after rain, water ingress, ground movement, service damage, alteration or other significant change.',
        'Record and communicate the status of the excavation.',
      ]),
      DubaiAdvancedSection('8. Stop-Work Conditions', [
        'Signs of ground movement or collapse.',
        'Damaged or inadequate protection.',
        'Unknown or uncontrolled underground service.',
        'Flooding or dangerous water condition.',
        'Unsafe access.',
        'Plant too close or uncontrolled edge loading.',
      ]),
      DubaiAdvancedSection('9. HSE & Operational Responsibilities', [
        'HSE Officer: field verification of barricading, access, protection and inspection status.',
        'HSE Supervisor: control excavation crews and access.',
        'Senior HSE: assure critical excavation arrangements.',
        'HSE Coordinator: coordinate utilities, plant and simultaneous work interfaces.',
        'HSE Engineer: support technical ground/protection assessment.',
        'HSE Manager: assure governance, competent resources and emergency preparedness.',
        'Plant operator/banksman: maintain safe plant movement and separation from excavation hazards.',
      ]),
      DubaiAdvancedSection('10. Practical Site Example', [
        'A utility trench is being prepared near an existing service corridor. Work is stopped until the service information is verified, the protective system and access are confirmed, the spoil/plant interface is controlled and the competent person completes the required inspection.',
      ]),
      DubaiAdvancedSection('11. Quick Learning Formula', [
        'Identify Ground → Identify Services → Protect → Access → Control Water → Inspect → Enter.',
      ]),
    ],

    'dubai_confined_space_entry': [
      DubaiAdvancedSection('Introduction — What is Confined Space Entry?', [
        'A confined space is a space with characteristics that can create serious risks because of limited access, atmosphere, configuration or other hazards. Entry must be controlled by the approved site system.',
      ]),
      DubaiAdvancedSection('1. Entry Planning', [
        'Determine whether entry can be avoided.',
        'Identify atmospheric, mechanical, electrical, process, engulfment and access hazards.',
        'Define entrants, attendant, supervisor and rescue arrangements.',
      ]),
      DubaiAdvancedSection('2. Permit & Isolation', [
        'Use the approved permit-to-work process where required.',
        'Isolate and verify hazardous energy and process sources.',
        'Control connected lines, equipment, pressure, electrical sources and materials.',
      ]),
      DubaiAdvancedSection('3. Atmospheric Control', [
        'Test oxygen, flammable atmosphere and relevant toxic contaminants.',
        'Use suitable calibrated/tested instruments and competent testers.',
        'Continue monitoring when required by the risk assessment or permit.',
      ]),
      DubaiAdvancedSection('4. Main Hazards', [
        'Oxygen deficiency or enrichment.',
        'Toxic gases/vapours.',
        'Flammable atmosphere.',
        'Engulfment.',
        'Mechanical/electrical energy.',
        'Heat stress.',
        'Poor access and difficult rescue.',
      ]),
      DubaiAdvancedSection('5. Safety Controls', [
        'Isolation and verification.',
        'Ventilation where suitable.',
        'Atmospheric testing and monitoring.',
        'Trained entrants and attendant.',
        'Reliable communication.',
        'Site-specific rescue arrangements.',
      ]),
      DubaiAdvancedSection('6. Inspection & Verification', [
        'Verify permit conditions before entry.',
        'Confirm isolation, testing, ventilation, communication and rescue readiness.',
        'Reassess when conditions change.',
      ]),
      DubaiAdvancedSection('7. Stop-Work Conditions', [
        'Unsafe atmosphere.',
        'Loss of ventilation where required.',
        'Loss of communication.',
        'Isolation failure or uncertainty.',
        'Attendant/rescue arrangements unavailable.',
      ]),
      DubaiAdvancedSection('8. HSE Responsibilities', [
        'HSE Officer: verify permit controls, testing and entry arrangements.',
        'HSE Supervisor: control entrants and work sequence.',
        'Senior HSE: assure high-risk confined-space systems.',
        'HSE Coordinator: coordinate isolation and emergency interfaces.',
        'HSE Engineer: review technical hazards and control arrangements.',
        'HSE Manager: assure permit, competence, rescue and governance systems.',
      ]),
      DubaiAdvancedSection('9. Practical Site Example', [
        'A worker is required to enter a chamber. The team first confirms that entry cannot be avoided, isolates connected hazards, tests the atmosphere, establishes ventilation and communication, positions the attendant and confirms rescue readiness before entry.',
      ]),
      DubaiAdvancedSection('10. Quick Learning Formula', [
        'Avoid → Isolate → Test → Ventilate → Supervise → Communicate → Rescue.',
      ]),
    ],

    'dubai_electrical_safety': [
      DubaiAdvancedSection('Introduction — What is Electrical Safety?', [
        'Electrical safety controls hazardous electrical energy to prevent shock, burns, arc events, fires and unintended energization.',
      ]),
      DubaiAdvancedSection('1. Electrical Systems', [
        'Permanent electrical installations.',
        'Temporary construction power.',
        'Distribution boards.',
        'Portable electrical tools.',
        'Cables, leads and connections.',
        'Generators and other electrical sources.',
      ]),
      DubaiAdvancedSection('2. Isolation & LOTO', [
        'Identify all energy sources.',
        'Isolate using the approved procedure.',
        'Apply lockout/tagout where required.',
        'Verify the isolated condition before work.',
        'Control re-energization.',
      ]),
      DubaiAdvancedSection('3. Technical Safety Controls', [
        'Use suitable protective devices and earthing/bonding arrangements.',
        'Protect cables from mechanical damage, water and traffic.',
        'Use suitable enclosures and access control for electrical distribution.',
        'Follow approved design and competent-person requirements.',
      ]),
      DubaiAdvancedSection('4. Main Hazards', [
        'Electric shock.',
        'Arc flash/arc event.',
        'Electrical fire.',
        'Damaged insulation.',
        'Water contact.',
        'Unauthorized access.',
        'Unexpected energization.',
      ]),
      DubaiAdvancedSection('5. Safety Controls', [
        'Use competent and authorized electrical personnel.',
        'Inspect tools, leads and panels.',
        'Maintain protective devices.',
        'Keep electrical systems dry and protected.',
        'Control temporary power distribution.',
      ]),
      DubaiAdvancedSection('6. Inspection', [
        'Inspect equipment and temporary installations at required intervals.',
        'Remove damaged equipment from service.',
        'Check cables, plugs, sockets, panels, protection and physical security.',
      ]),
      DubaiAdvancedSection('7. Stop-Work Conditions', [
        'Exposed live parts.',
        'Damaged cable or equipment.',
        'Unknown isolation status.',
        'Unsafe temporary distribution.',
        'Water or environmental condition creating electrical danger.',
      ]),
      DubaiAdvancedSection('8. HSE Responsibilities', [
        'HSE Officer: field inspection and unsafe-condition reporting.',
        'HSE Supervisor: prevent unauthorized electrical work.',
        'Senior HSE: assure high-risk electrical controls.',
        'HSE Coordinator: coordinate electrical interfaces with construction activities.',
        'HSE Engineer: review technical risk controls and isolation arrangements.',
        'HSE Manager: assure electrical safety governance and competent resources.',
      ]),
      DubaiAdvancedSection('9. Practical Site Example', [
        'A temporary cable is found damaged in a construction access route. The area is controlled, the cable is isolated and removed from service, a competent electrical person assesses the installation and the route is made safe before work continues.',
      ]),
      DubaiAdvancedSection('10. Quick Learning Formula', [
        'Identify Energy → Isolate → Verify → Protect → Inspect → Control Access.',
      ]),
    ],
  };

  List<DubaiAdvancedSection> get sections {
    return _topics[topicId] ??
        const [
          DubaiAdvancedSection(
            'Advanced Learning',
            ['No topic-specific content is configured for this topic ID.'],
          ),
        ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: const Text(
          'Advanced Learning',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        children: [
          _header(),
          const SizedBox(height: 14),
          ...List<Widget>.generate(
            sections.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _sectionCard(index + 1, sections[index]),
            ),
          ),
          _fieldVerification(),
        ],
      ),
    );
  }

  Widget _header() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Advanced Learning',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              topicTitle,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 9),
            const Text(
              'Topic-specific HSE learning, field controls and professional responsibilities.',
              style: TextStyle(height: 1.45),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard(int number, DubaiAdvancedSection section) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$number',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    section.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 11),
            ...section.points.map(
              (point) => Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '• ',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    Expanded(
                      child: Text(
                        point,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.48,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fieldVerification() {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(top: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Padding(
        padding: EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Professional Field Verification',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 9),
            Text(
              'Before work starts, verify the approved method, risk assessment, competence, permits where required, equipment condition, site interfaces and emergency arrangements.',
              style: TextStyle(height: 1.48),
            ),
            SizedBox(height: 10),
            Text(
              'If a critical control is missing, ineffective or materially different from the approved method, stop the activity and escalate through the project HSE process.',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                height: 1.48,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DubaiAdvancedSection {
  final String title;
  final List<String> points;

  const DubaiAdvancedSection(this.title, this.points);
}
