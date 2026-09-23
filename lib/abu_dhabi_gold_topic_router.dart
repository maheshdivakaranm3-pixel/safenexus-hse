import 'package:flutter/material.dart';

import 'data/abu_dhabi_specialist_hse_complete_gold.dart';
import 'data/abu_dhabi_5AJ_part1_interfaces_specialist_plant_gold.dart';
import 'data/abu_dhabi_5AJ_part2_gap_duplicate_cop36_gold.dart';
import 'data/abu_dhabi_5AB_to_5AE_plant_haulage_compaction_gold.dart';
import 'data/abu_dhabi_5AF_to_5AI_paver_trencher_compressor_generator_gold.dart';
import 'data/abu_dhabi_5S_to_5V_mobile_material_handling_gold.dart';
import 'data/abu_dhabi_5W_to_5Z_earthmoving_gold.dart';
import 'data/abu_dhabi_forklift_powered_lift_trucks_gold.dart';
import 'data/abu_dhabi_mewp_gold.dart';
import 'data/abu_dhabi_crane_lifting_book_gold.dart';
import 'models/reference_topic.dart';

class ScaffoldingGoldEnhancement {
  final String regulatory;
  final String measurements;
  final String fieldExample;
  final String visualGuide;
  final String checklist;
  final String stopWork;
  final String emergency;
  final String interview;
  final String reference;

  const ScaffoldingGoldEnhancement({
    required this.regulatory,
    required this.measurements,
    required this.fieldExample,
    required this.visualGuide,
    required this.checklist,
    required this.stopWork,
    required this.emergency,
    required this.interview,
    required this.reference,
  });
}

const Map<String, ScaffoldingGoldEnhancement> scaffoldingGoldEnhancements = {
  'Definition & Purpose': ScaffoldingGoldEnhancement(
    regulatory: 'ADOSH-SF CoP 26.0 applies to planning, assessment, erection, use, maintenance, alteration, dismantling and inspection of scaffolding in Abu Dhabi.',
    measurements: 'Use the current approved design, manufacturer information and applicable CoP values. Do not invent a capacity or dimension from a generic checklist.',
    fieldExample: 'A façade scaffold is required for blockwork and plastering. Before erection, the team identifies the duty, height, access route, tie arrangement, loading and public/traffic interfaces.',
    visualGuide: 'Show: foundation → standards → ledgers/transoms → bracing/ties → platform → guardrail/midrail/toe board → access.',
    checklist: 'Purpose identified; scaffold type selected; height and duty known; design/manufacturer information available; erection and dismantling method planned.',
    stopWork: 'No approved system/design where required; unknown intended load; incomplete or unstable structure; uncontrolled access.',
    emergency: 'For collapse/fall: isolate the area, prevent secondary collapse exposure, raise the site emergency alarm and follow the project rescue plan.',
    interview: 'Why is scaffolding treated as a temporary structure rather than ordinary access? Because its stability, loading and configuration change with erection, use, alteration and dismantling.',
    reference: 'ADOSH-SF CoP 26.0 — Scaffolding, Version 4.1, February 2026.',
  ),
  'Scope & Applications': ScaffoldingGoldEnhancement(
    regulatory: 'CoP 26.0 covers modular, tube-and-coupler, suspended scaffolds, swinging stages and scaffold-component platforms; prefabricated mobile access towers are also addressed with BS EN 1004 requirements.',
    measurements: 'Mobile/static tower height and configuration must follow manufacturer/design limits; do not transfer limits from another scaffold system.',
    fieldExample: 'A project uses a tube-and-fitting façade scaffold and a prefabricated mobile tower. They are controlled as separate systems with their own manufacturer/design requirements.',
    visualGuide: 'Compare fixed scaffold, mobile tower, suspended scaffold and special scaffold as separate system cards.',
    checklist: 'Identify scaffold system; confirm manufacturer; confirm design; confirm intended use; confirm competent erection team.',
    stopWork: 'Mixed systems without competent engineering confirmation or components used outside their intended system.',
    emergency: 'Use the rescue method appropriate to the actual system; suspended and special scaffolds require system-specific rescue arrangements.',
    interview: 'What is the danger of treating every scaffold as the same? Stability, access, loading and erection controls differ by system.',
    reference: 'ADOSH-SF CoP 26.0, Sections 1 and 3.13.',
  ),
  'Types of Scaffolding': ScaffoldingGoldEnhancement(
    regulatory: 'Select the scaffold type according to purpose, environment, loading and design requirements.',
    measurements: 'For prefabricated mobile towers, use the product conformity and manufacturer limits; for engineered scaffolds, use the approved drawing.',
    fieldExample: 'Heavy masonry work requires a different duty and loading arrangement from access-only inspection work.',
    visualGuide: 'System comparison: tube & fitting / modular / mobile tower / suspended / special.',
    checklist: 'Type identified; duty identified; loading identified; access identified; wind/screening effects considered.',
    stopWork: 'Scaffold type cannot safely perform the intended task or is being used outside the design.',
    emergency: 'Emergency plan must account for the system’s access and potential rescue route.',
    interview: 'What determines scaffold selection? Intended use, load, height, location, environment, access and stability requirements.',
    reference: 'ADOSH-SF CoP 26.0, Sections 1 and 3.3.',
  ),
  'Components / Parts': ScaffoldingGoldEnhancement(
    regulatory: 'All components must be suitable, sound and of appropriate strength for their purpose.',
    measurements: 'Use the manufacturer/design specification for tube, fitting, board and system compatibility; do not assume different systems are interchangeable.',
    fieldExample: 'During inspection, a bent tube and worn coupler are found. They are removed from service rather than straightened or reused informally.',
    visualGuide: 'Label standards, ledgers, transoms, braces, ties, baseplates, boards, guardrails, toe boards and access components.',
    checklist: 'No cracks; no severe corrosion; fittings functional; boards sound; connections secure; correct components used.',
    stopWork: 'Defective or incompatible structural components are found in a load-bearing arrangement.',
    emergency: 'If component failure occurs, clear the area and prevent secondary access until the scaffold is assessed.',
    interview: 'Can damaged scaffold components be used temporarily? No; defective material must not be used where it could compromise safety.',
    reference: 'ADOSH-SF CoP 26.0, Sections 3.8, 3.10 and 3.11.',
  ),
  'Planning & Design': ScaffoldingGoldEnhancement(
    regulatory: 'Risk assessment is required before construction of scaffolding. Design drawings are required for scaffolds over 10 m and specified special configurations.',
    measurements: 'Engineer design is required for scaffolds over 10 m or where ladder beams, mesh/shade cloth, freestanding, suspended or non-standard ties/bracing are involved.',
    fieldExample: 'A 12 m scaffold with perimeter shade cloth is routed through engineering because both height and wind-loading/special-design considerations apply.',
    visualGuide: 'Design flow: task → hazards → scaffold type → loads → foundation → ties/bracing → access → protection → inspection.',
    checklist: 'RAMS; design drawing where required; manufacturer instructions; load/duty; ties; access; weather; traffic; electrical services; dismantling plan.',
    stopWork: 'Required engineering/design information is missing or erected scaffold differs materially from the approved arrangement.',
    emergency: 'Planning must include rescue, falling-object exclusion and emergency access before erection starts.',
    interview: 'When is an engineer design drawing required? Over 10 m and for the specified special configurations listed in CoP 26.0.',
    reference: 'ADOSH-SF CoP 26.0, Sections 3.2.2 and 3.2.3.',
  ),
  'Site Assessment': ScaffoldingGoldEnhancement(
    regulatory: 'Risk assessment must consider overhead electrical services, corrosive substances, cranes/vehicles, weak supports and high winds/storms.',
    measurements: 'Verify site-specific clearances and exclusion zones against the applicable electrical, traffic and project controls.',
    fieldExample: 'Before erection beside a haul road, the team identifies vehicle impact risk and installs physical separation and traffic controls.',
    visualGuide: '360° site scan: ground / structure / overhead services / traffic / public / weather / adjacent work.',
    checklist: 'Ground stable; nearby excavation checked; overhead services identified; traffic separated; public protected; weather assessed.',
    stopWork: 'Uncontrolled vehicle impact risk, unstable support, unsafe electrical interface or adverse conditions that compromise safe work.',
    emergency: 'Keep emergency access clear and ensure rescue routes are not blocked by scaffold or exclusion zones.',
    interview: 'Why inspect the surrounding area, not just the scaffold? External conditions can destabilize or damage the scaffold.',
    reference: 'ADOSH-SF CoP 26.0, Section 3.2.2.',
  ),
  'Foundation / Sole Boards': ScaffoldingGoldEnhancement(
    regulatory: 'Baseplates are required on all standards; sole boards on less stable surfaces must follow the scaffold design.',
    measurements: 'Minimum sole board size specified by CoP 26.0: 225 mm × 450 mm. Actual size may need to be greater depending on bearing conditions.',
    fieldExample: 'On compacted fill, the scaffold designer confirms bearing capacity and specifies suitable sole boards before erection.',
    visualGuide: 'Ground → sole board → baseplate → standard. Show settlement warning signs.',
    checklist: 'Baseplates present; sole boards where required; bearing surface sound; no settlement; water not undermining base.',
    stopWork: 'Baseplate missing, unstable support, settlement, washout or foundation outside design.',
    emergency: 'Keep people away from a scaffold showing settlement or movement until stability is assessed.',
    interview: 'What is the minimum sole board size stated in CoP 26.0? 225 mm × 450 mm, subject to the design/support condition.',
    reference: 'ADOSH-SF CoP 26.0, Section 3.4.2.',
  ),
  'Erection Sequence': ScaffoldingGoldEnhancement(
    regulatory: 'Erection must be planned, supervised and performed by competent personnel with working-at-height controls.',
    measurements: 'During erection, the CoP specifies a platform below the level being erected at no more than 3 m for housing construction or 2.4 m otherwise, except stated conditions.',
    fieldExample: 'The erection crew progresses one lift at a time, installs ties/bracing as required and maintains access and edge protection instead of building a bare frame and “fixing it later”.',
    visualGuide: 'Sequence: base → first lift → bracing/ties → platform → access → next lift → protection → inspection.',
    checklist: 'Competent crew; exclusion zone; base stable; ties/braces installed; platform/protection progressive; safe access.',
    stopWork: 'Scaffolders climbing guardrails, missing critical stability components, incomplete access or uncontrolled falling-object risk.',
    emergency: 'Maintain rescue access and prevent people below entering the erection zone.',
    interview: 'Why is progressive erection important? It maintains stability and protection as the scaffold grows.',
    reference: 'ADOSH-SF CoP 26.0, Section 3.4.1.',
  ),
  'Hazards — One by One': ScaffoldingGoldEnhancement(
    regulatory: 'CoP 26.0 requires risk assessment and control of scaffold-related hazards using the hierarchy of controls.',
    measurements: 'Use the actual task, scaffold geometry and environment to determine controls rather than applying generic numbers.',
    fieldExample: 'One inspection identifies three independent hazards: missing tie, open platform edge and falling-object exposure. Each receives a specific corrective action.',
    visualGuide: 'Hazard cards: fall / collapse / falling object / electrical / vehicle / wind / overload / access.',
    checklist: 'Hazard identified; consequence understood; physical control selected; responsible person assigned; verification completed.',
    stopWork: 'Any uncontrolled critical hazard affecting stability, fall protection or public safety.',
    emergency: 'Use the site emergency plan and isolate the hazard zone before rescue or recovery activities.',
    interview: 'Name key scaffold hazards. Falls, collapse, falling objects, electrical contact, vehicle impact, overloading, weather and unsafe access.',
    reference: 'ADOSH-SF CoP 26.0, Section 3.2.2.',
  ),
  'Hazard Identification': ScaffoldingGoldEnhancement(
    regulatory: 'Risk assessment must cover erection, modification, dismantling, use and nearby activities.',
    measurements: 'Record location-specific dimensions and interfaces where they affect risk.',
    fieldExample: 'A tie has been removed by another trade. The defect is recorded as an unauthorized interference and escalated before the scaffold is used.',
    visualGuide: 'Inspection route: top down + inside/outside + base + access + surroundings.',
    checklist: 'Structural; platform; edge; access; loading; electrical; traffic; weather; public; alteration.',
    stopWork: 'Critical control cannot be verified or the condition differs from the approved safe system.',
    emergency: 'Establish a safe perimeter and prevent secondary exposure during investigation.',
    interview: 'Why include other trades in scaffold hazard identification? They can alter, load, strike or interfere with the scaffold.',
    reference: 'ADOSH-SF CoP 26.0, Sections 3.2.1–3.2.2.',
  ),
  'Causes': ScaffoldingGoldEnhancement(
    regulatory: 'The CoP addresses design, competence, erection, alteration, maintenance, loading and inspection as controls against failure.',
    measurements: 'Check actual configuration against design rather than judging only by appearance.',
    fieldExample: 'A façade team removes two ties to install cladding. The root cause is uncontrolled interface management, not simply “worker error”.',
    visualGuide: 'Cause chain: design → erection → use → modification → environment → inspection.',
    checklist: 'Original design available; changes controlled; competent people; inspection current; loading controlled.',
    stopWork: 'Repeated or systemic unauthorized modification or evidence of structural compromise.',
    emergency: 'If collapse is suspected, do not approach unstable sections until the emergency/competent response team makes the area safe.',
    interview: 'What is a common root cause of scaffold failure? Loss of designed stability through poor erection, unauthorized changes, inadequate support or uncontrolled loading.',
    reference: 'ADOSH-SF CoP 26.0, Sections 3.2–3.4 and 3.10.',
  ),
  'Risk & Consequences': ScaffoldingGoldEnhancement(
    regulatory: 'Risk assessment must protect workers, affected persons and the public.',
    measurements: 'Assess credible worst-case consequences such as collapse, falling objects and electrical contact.',
    fieldExample: 'A scaffold beside a public footpath requires controls for people below, not only for scaffold users.',
    visualGuide: 'Risk triangle: worker / public / structure & plant.',
    checklist: 'Affected persons; consequence; controls; exclusion zone; emergency response; verification.',
    stopWork: 'Risk remains intolerable because critical controls are absent.',
    emergency: 'Protect responders from secondary collapse and falling objects; establish exclusion zones.',
    interview: 'Why assess the public? CoP 26.0 explicitly requires safe systems for all parties affected, including the public.',
    reference: 'ADOSH-SF CoP 26.0, Sections 3.2.1 and 3.6.2.',
  ),
  'Hierarchy of Controls': ScaffoldingGoldEnhancement(
    regulatory: 'CoP 26.0 requires controls in accordance with the hierarchy of controls.',
    measurements: 'Use physical separation and engineering controls before relying on PPE.',
    fieldExample: 'Instead of relying only on harnesses, the team first installs compliant edge protection and controls the internal gap.',
    visualGuide: 'Hierarchy: eliminate → safer system/design → isolate/engineer → administrative controls → PPE.',
    checklist: 'Higher-order controls considered; engineered protection installed; procedures communicated; PPE as supporting control.',
    stopWork: 'PPE is being used as a substitute for a required physical/engineering control without an approved safe system.',
    emergency: 'Rescue planning must match the selected control system, especially when fall arrest is used.',
    interview: 'Why is PPE the last resort? It does not remove the structural or fall hazard itself.',
    reference: 'ADOSH-SF CoP 26.0, Sections 3.2.1–3.2.2.',
  ),
  'Scaffold Stability': ScaffoldingGoldEnhancement(
    regulatory: 'Design must consider strength, stability and rigidity, supporting structure, intended use and environmental loads.',
    measurements: 'Stability arrangements must follow the approved design/manufacturer instructions; do not substitute generic tie spacing.',
    fieldExample: 'A scaffold is sheeted for containment. Engineering review confirms additional wind effects and tie requirements before the screen is installed.',
    visualGuide: 'Load path: platform → transom/ledger → standards → baseplate/sole board → ground/support.',
    checklist: 'Plumb; level; ties; bracing; base; support; environmental loads; no unauthorized changes.',
    stopWork: 'Visible movement, settlement, missing ties/bracing or design change without competent review.',
    emergency: 'Evacuate the affected scaffold and adjacent danger area if instability is suspected.',
    interview: 'What can increase wind load? Sheeting, shade cloth, signs and containment screens.',
    reference: 'ADOSH-SF CoP 26.0, Sections 3.3.2–3.3.10.',
  ),
  'Bracing / Ties / Anchoring': ScaffoldingGoldEnhancement(
    regulatory: 'Tie methods and spacing follow manufacturer/designer/supplier instructions; additional ties may be needed for screening, loading platforms, lifting appliances or rubbish chutes.',
    measurements: 'Where specified anchors are used, follow the CoP testing and working-load requirements; do not improvise anchor systems.',
    fieldExample: 'Finishing workers remove a tie to access a façade opening. The scaffold is taken out of service until the tie is restored or the design is revised by the competent route.',
    visualGuide: 'Show tie connecting inner and outer standards with bracing continuity.',
    checklist: 'Tie present; secure; correct location; no unauthorized removal; bracing continuous; anchor information available.',
    stopWork: 'Critical tie/bracing missing, loose, damaged or modified without authorization.',
    emergency: 'Keep clear of a scaffold with compromised stability until assessed.',
    interview: 'Can a finishing trade remove a scaffold tie? No; unauthorized interference must be prevented and alterations controlled.',
    reference: 'ADOSH-SF CoP 26.0, Section 3.4.4.',
  ),
  'Platforms / Working Levels': ScaffoldingGoldEnhancement(
    regulatory: 'Working platforms must be designed for the required number of platforms and live loads.',
    measurements: 'Single board gap ≤25 mm; total gaps between boards ≤50 mm. Board overhang supported by transoms ≤150 mm or 4× board thickness, whichever is less.',
    fieldExample: 'A board with a crack is found on a live work platform. It is removed and replaced; the area is not left open for workers to cross.',
    visualGuide: 'Platform cross-section showing boards, gap limit, secure fixing and overhang.',
    checklist: 'Boards sound; captive/secured; slip-resistant; gaps controlled; overhang controlled; clean surface.',
    stopWork: 'Cracked/split board, unsafe gap, loose board, excessive overhang or platform not suitable for the intended load.',
    emergency: 'Prevent access to a failed platform and provide an alternative safe route before resuming work.',
    interview: 'What are the board gap limits? A single gap must not exceed 25 mm and total gaps must not exceed 50 mm.',
    reference: 'ADOSH-SF CoP 26.0, Section 3.4.3.',
  ),
  'Guardrails / Toe Boards': ScaffoldingGoldEnhancement(
    regulatory: 'Guardrails and toe boards are required at exposed working platforms; mid-rails are required on working platforms over 2 m.',
    measurements: 'Toe board ≥150 mm; guardrail ≥950 mm; gaps between toe/mid/guardrail elements ≤470 mm.',
    fieldExample: 'A material-delivery opening temporarily requires removal of edge protection. It is controlled and the protection is replaced as soon as reasonably practicable.',
    visualGuide: 'Edge-protection diagram: top guardrail 950 mm → mid-rail → toe board 150 mm.',
    checklist: 'Guardrail; midrail; toe board; end protection; secure fixing; no uncontrolled opening.',
    stopWork: 'Exposed edge without compliant protection or falling-object protection.',
    emergency: 'Establish exclusion below an exposed edge and restore protection before work continues.',
    interview: 'What is the minimum guardrail height? 950 mm under CoP 26.0.',
    reference: 'ADOSH-SF CoP 26.0, Section 3.4.7.',
  ),
  'Access & Egress': ScaffoldingGoldEnhancement(
    regulatory: 'Safe access and egress must be provided during erection, use and dismantling.',
    measurements: 'Ladder landing places are required at each 9 m of height; openings for ladders/stairs should be as small as reasonably practicable and not exceed 500 mm.',
    fieldExample: 'A scaffold is extended two lifts but the temporary stair access is not progressed. Work stops until safe access is provided.',
    visualGuide: 'Access route with ladder/stair, protected opening and landing.',
    checklist: 'Safe route; landing; handholds; clear path; protected openings; emergency egress.',
    stopWork: 'Climbing standards/ledgers, unsafe ladder route or blocked emergency egress.',
    emergency: 'Ensure emergency access remains usable even when normal construction routes are congested.',
    interview: 'What access should be considered? Stair towers, portable ladders, permanent stairs/ramps, built-in tower access and suitable personnel hoists.',
    reference: 'ADOSH-SF CoP 26.0, Sections 3.4.8–3.4.9.',
  ),
  'Ladders / Stair Towers': ScaffoldingGoldEnhancement(
    regulatory: 'Ladders used with scaffolds must comply with CoP 37.0 and the additional CoP 26.0 controls.',
    measurements: 'Ladder working angle 75°; extend at least 1.05 m above platform; landing required where ladder rises more than 9 m.',
    fieldExample: 'A ladder is found at a shallow angle and does not extend above the platform. Access is restricted until corrected.',
    visualGuide: 'Ladder diagram: 75° angle, 1 m horizontal for 4 m height, 1.05 m above landing.',
    checklist: 'Firm base; secure; 75°; clear rungs; 1.05 m extension; landing; trapdoor controlled.',
    stopWork: 'Unsecured ladder, unsafe angle, inadequate extension, blocked rungs or ladder used as an upright.',
    emergency: 'Keep ladder routes clear for evacuation and rescue.',
    interview: 'Can a ladder be used as a scaffold upright? No; CoP 26.0 strictly prohibits it.',
    reference: 'ADOSH-SF CoP 26.0, Section 3.12.',
  ),
  'Loading / Load Limits': ScaffoldingGoldEnhancement(
    regulatory: 'Scaffold design must account for dead, live and environmental loads and the intended duty classification.',
    measurements: 'Duty classifications include access only, light working and heavy working. Use the approved load information rather than a generic “4× load” rule.',
    fieldExample: 'A mason stores blocks across a platform. The HSE check verifies the approved duty and prevents material accumulation beyond the design.',
    visualGuide: 'Load map: people + tools + materials + impact + environmental load → structural system.',
    checklist: 'Duty known; loading displayed/communicated; no concentrated overload; access passage maintained.',
    stopWork: 'Unknown load capacity, excessive storage, concentrated load not covered by design or evidence of deflection/failure.',
    emergency: 'If overload is suspected, keep people out and use a controlled unloading plan approved by competent personnel.',
    interview: 'Why avoid quoting a universal four-times rule for Abu Dhabi? The current CoP requires design for the relevant dead, live and environmental loads and duty; use the controlled design rather than an unverified generic figure.',
    reference: 'ADOSH-SF CoP 26.0, Sections 3.3.5, 3.3.7–3.3.11.',
  ),
  'Falling Objects': ScaffoldingGoldEnhancement(
    regulatory: 'Controls include exclusion zones, containment screening, fans, hoardings or gantries where appropriate, and warning signs.',
    measurements: 'Perimeter screening gaps must not exceed 25 mm horizontally or vertically at specified interfaces.',
    fieldExample: 'A façade scaffold above a pedestrian route uses controlled exclusion/protection and warning signage rather than allowing people directly below active work.',
    visualGuide: 'Falling-object cone: platform → toe board/screen → exclusion zone → protected public route.',
    checklist: 'Toe boards; screens/fans where required; secure materials; exclusion zone; warning signs; no dropped materials.',
    stopWork: 'Uncontrolled falling-object exposure to workers or public.',
    emergency: 'Treat a falling-object incident as an exclusion-zone event; prevent further access until the source is controlled.',
    interview: 'Can scaffold materials be thrown down during dismantling? No; materials must be passed/lowered safely.',
    reference: 'ADOSH-SF CoP 26.0, Sections 3.4.10 and 3.6.2.',
  ),
  'Weather / Wind / Heat': ScaffoldingGoldEnhancement(
    regulatory: 'Risk assessment must consider high winds and storms; environmental loads include wind and rain, especially with screens/shade cloth/signs.',
    measurements: 'Use the project/manufacturer/design weather limits; CoP 26.0 does not provide a single universal wind-stop number for every scaffold.',
    fieldExample: 'After strong winds, the scaffold is kept out of service until a competent inspection confirms stability and records the inspection.',
    visualGuide: 'Weather card: wind → screen load → tie/bracing → inspection; rain → slippery platform → housekeeping.',
    checklist: 'Weather checked; loose materials secured; screens assessed; post-event inspection completed; access safe.',
    stopWork: 'Weather makes erection/use unsafe or stability cannot be confirmed after a significant event.',
    emergency: 'Move personnel to a safe location and restrict scaffold access during severe weather according to the site emergency plan.',
    interview: 'Does CoP 26.0 mention strong winds/storms? Yes, both in risk assessment and post-event inspection requirements.',
    reference: 'ADOSH-SF CoP 26.0, Sections 3.2.2, 3.3.6 and 3.14.',
  ),
  'Electrical / Overhead Services': ScaffoldingGoldEnhancement(
    regulatory: 'Overhead electrical services are specifically included in the scaffold risk assessment requirements.',
    measurements: 'Use the applicable electrical authority/project clearance requirements; do not insert an unverified universal distance.',
    fieldExample: 'A scaffold is planned near overhead lines. The work is redesigned/isolated and controlled before erection rather than relying on a visual estimate.',
    visualGuide: 'No-go electrical zone around overhead service with scaffold kept outside the approved clearance.',
    checklist: 'Services identified; isolation/clearance confirmed; no conductive encroachment; traffic/plant controlled.',
    stopWork: 'Electrical clearance or isolation is not confirmed.',
    emergency: 'If contact occurs, keep people away from the scaffold until the electrical source is isolated by the authorized party.',
    interview: 'Why is electrical risk important for scaffold? Metal scaffold can create a conductive path and workers may work at height close to services.',
    reference: 'ADOSH-SF CoP 26.0, Section 3.2.2.',
  ),
  'Mobile / Tower / Special Scaffolds': ScaffoldingGoldEnhancement(
    regulatory: 'Mobile/static towers must have product conformity to BS EN 1004 and follow manufacturer instructions.',
    measurements: 'Tower working-surface height ≤3 times minimum base dimension unless otherwise specified by manufacturer/supplier/designer; stabilizers and castor limits follow the product requirements.',
    fieldExample: 'Before moving a mobile tower, workers confirm no person is on it, the route is firm/level, no overhead obstruction exists and materials cannot fall.',
    visualGuide: 'Tower diagram: locked castors, internal ladder, protected trapdoor, stabilizer/outrigger and base dimension.',
    checklist: 'Conformity; manual; base ratio; castors locked; internal access; stabilizers; no person during movement; no wind.',
    stopWork: 'Person on tower during movement, unlocked castors, unsafe ground, overhead obstruction or movement in windy conditions.',
    emergency: 'Do not attempt to move an unstable tower during an emergency; isolate and follow the site rescue plan.',
    interview: 'Can a mobile tower be moved in windy conditions? No; CoP 26.0 specifically prohibits moving it in windy conditions.',
    reference: 'ADOSH-SF CoP 26.0, Section 3.13 and BS EN 1004.',
  ),
  'RAMS / JSA / Risk Assessment': ScaffoldingGoldEnhancement(
    regulatory: 'A documented safe system of work must cover erection, dismantling, maintenance, alteration, use and nearby activities.',
    measurements: 'The safe system should include scaffold type, special design, erection method, access/egress, tie type/frequency, bracing and safe sequence.',
    fieldExample: 'The HSE Officer compares the RAMS drawing with the actual scaffold and identifies a missing tie arrangement before handover.',
    visualGuide: 'RAMS cycle: plan → brief → execute → inspect → change control → review.',
    checklist: 'Drawing; type; design loads; ties; bracing; access; falling-object controls; emergency; change control.',
    stopWork: 'Work is proceeding outside the documented safe system or the field configuration differs materially.',
    emergency: 'Emergency controls and rescue route must be included in the safe system before work starts.',
    interview: 'What should the documented system contain? The CoP lists type, design considerations, erection method, access, ties, bracing and safe sequence among the required issues.',
    reference: 'ADOSH-SF CoP 26.0, Section 3.5.',
  ),
  'PTW / Authorization': ScaffoldingGoldEnhancement(
    regulatory: 'Permit requirements depend on the project and interfaces; CoP 26.0 requires necessary approvals/authorisations to be obtained before work where applicable.',
    measurements: 'Do not create a universal PTW requirement for every scaffold. Apply the project permit matrix and authority requirements.',
    fieldExample: 'Scaffold erection adjacent to a live road requires the project traffic authorization and controlled work area before the crew starts.',
    visualGuide: 'Authorization chain: scope → risk assessment → permit/approval where required → briefing → work → inspection.',
    checklist: 'Required approvals; RAMS approved; utility/traffic interfaces controlled; competent team briefed.',
    stopWork: 'Required project authorization is missing or conditions of the permit are not met.',
    emergency: 'Permit controls must not delay emergency isolation or rescue actions; follow site emergency procedure.',
    interview: 'Is a PTW automatically required for every scaffold? Not necessarily; apply the project/authority permit matrix and task interfaces.',
    reference: 'ADOSH-SF CoP 26.0, Sections 3.1 and 3.5 plus project permit system.',
  ),
  'Safe Work Procedure': ScaffoldingGoldEnhancement(
    regulatory: 'Safe work procedures must be communicated to scaffolders and users and aligned with the design/manufacturer instructions.',
    measurements: 'Use the controlled sequence and system-specific dimensions rather than generic scaffold rules.',
    fieldExample: 'The erection team uses a step-by-step method that identifies where guardrails, ties, platforms and access are installed at each stage.',
    visualGuide: 'Procedure card: Prepare → Erect → Stabilize → Protect → Inspect → Handover → Use → Alter/Dismantle.',
    checklist: 'Briefing completed; method available; competent team; exclusion zone; sequence followed; inspection planned.',
    stopWork: 'Crew cannot explain the method or critical steps are being skipped.',
    emergency: 'The procedure must identify emergency communication and rescue arrangements.',
    interview: 'Why should the drawing be communicated to scaffolders? So erection, alteration and dismantling follow the intended safe configuration.',
    reference: 'ADOSH-SF CoP 26.0, Section 3.5.',
  ),
  'Inspection & Tagging': ScaffoldingGoldEnhancement(
    regulatory: 'Competent inspection is required after erection and before use, at the minimum periodic interval, after alteration/repair and after events affecting stability.',
    measurements: 'Minimum inspection frequency: before first use and within every 7 days thereafter; after alteration/repair; after an event that could affect stability such as strong winds or storms.',
    fieldExample: 'The inspector records location, comments, date/time, design/specification reference and inspector details, and confirms the scaffold identification information is current.',
    visualGuide: 'Inspection status card: erected date / use / loading / last inspection / inspected by. Project tag colour may be shown separately as a site system.',
    checklist: 'Design match; structure; support; platform; edge protection; access; intended use; record; identification.',
    stopWork: 'Inspection overdue, required post-event inspection missing, or scaffold condition differs from the inspected configuration.',
    emergency: 'Do not rely on a tag during an emergency; isolate the scaffold if its stability is in doubt.',
    interview: 'What information must be marked prominently? Date erected, use, loading, last inspection and inspected by.',
    reference: 'ADOSH-SF CoP 26.0, Section 3.14. Project tag colour systems should be treated as project controls unless specifically mandated by the controlling authority.',
  ),
  'Competency & Responsibilities': ScaffoldingGoldEnhancement(
    regulatory: 'CoP 26.0 sets competency requirements for users, scaffold designers and personnel erecting/modifying/dismantling scaffolds.',
    measurements: 'For scaffolds over 10 m and suspended scaffolds, specified scaffolders require the stated competency certificate; below 10 m the CoP specifies registered-trainer competency requirements.',
    fieldExample: 'The HSE Officer checks competency records before allowing a new scaffolding crew to start alteration work.',
    visualGuide: 'Responsibility map: employer → principal contractor → designer → scaffolder → inspector → user.',
    checklist: 'Qualification/certificate; experience; training record; supervision; user briefing; inspection competence.',
    stopWork: 'Unqualified/uncertified person performing a role that requires specified scaffold competency.',
    emergency: 'Only competent responders should enter unstable scaffold areas unless the emergency plan explicitly provides otherwise.',
    interview: 'Who designs a scaffold requiring engineering design? A competent engineer with appropriate qualifications and experience.',
    reference: 'ADOSH-SF CoP 26.0, Sections 2 and 3.1.',
  ),
  'PPE': ScaffoldingGoldEnhancement(
    regulatory: 'PPE supports the safe system; it does not replace collective/engineering controls.',
    measurements: 'For scaffold erection, CoP 26.0 requires harness issue and use, with clip-on outside an area protected by at least one 950 mm guardrail.',
    fieldExample: 'During erection before full edge protection is available, scaffolders use the approved harness/fall-protection system according to the safe work method.',
    visualGuide: 'PPE panel: helmet with chin strap where required, footwear, gloves, visibility, harness/fall protection as specified.',
    checklist: 'Correct PPE; inspected harness; compatible connectors; anchor/control method; rescue plan; user training.',
    stopWork: 'Required fall-protection equipment is missing, incompatible or the safe system cannot be followed.',
    emergency: 'Rescue arrangements must address a suspended worker and avoid creating a second casualty.',
    interview: 'When must scaffolders clip on? When working outside an area protected by at least one guardrail at 950 mm, as specified by CoP 26.0.',
    reference: 'ADOSH-SF CoP 26.0, Section 3.6.1.',
  ),
  'Emergency / Rescue': ScaffoldingGoldEnhancement(
    regulatory: 'Emergency arrangements must be integrated with the safe system and site emergency plan, especially for falls, collapse and falling objects.',
    measurements: 'Rescue method must be specific to scaffold height, access, fall-protection system and site response capability.',
    fieldExample: 'A fall-arrest user is suspended after a fall. The team follows the preplanned rescue method rather than improvising a climb on an incomplete scaffold.',
    visualGuide: 'Rescue flow: raise alarm → isolate → protect responders → access/rescue → first aid → preserve scene/report.',
    checklist: 'Alarm; communication; access; rescue equipment; trained responders; exclusion zone; first aid; escalation.',
    stopWork: 'Fall-arrest system is planned but no practicable rescue method exists.',
    emergency: 'Never rush into a potentially unstable scaffold; secondary collapse/falling-object hazards must be controlled first.',
    interview: 'Why is rescue planning important with harness use? A fall can leave a worker suspended and a delayed or improvised rescue can create additional risk.',
    reference: 'ADOSH-SF CoP 26.0, Sections 3.5 and 3.6; site emergency plan.',
  ),
  'Stop-Work Conditions': ScaffoldingGoldEnhancement(
    regulatory: 'Stop-work decisions should protect persons where the scaffold is not safe or does not comply with the approved safe system.',
    measurements: 'Examples are control-based rather than a single numerical list: missing critical tie, failed platform, unsafe edge, overdue inspection or unstable support.',
    fieldExample: 'A post-storm inspection finds a displaced board and loosened tie. The scaffold remains out of service until competent correction and inspection.',
    visualGuide: 'STOP sign with four checks: stability / protection / access / inspection.',
    checklist: 'Stop; isolate; tag/warn; notify; correct; inspect; release.',
    stopWork: 'Collapse indicators, missing stability, uncontrolled fall/falling-object risk, electrical danger, severe weather, unauthorized alteration or failed inspection.',
    emergency: 'If collapse is possible, establish a wide exclusion zone and call the competent emergency response.',
    interview: 'What should happen after a critical scaffold defect? Stop use, prevent access, notify the responsible competent team, rectify and verify before re-use.',
    reference: 'ADOSH-SF CoP 26.0, Sections 3.4, 3.6, 3.9 and 3.14.',
  ),
  'Unsafe Practices → Corrective Actions': ScaffoldingGoldEnhancement(
    regulatory: 'Unsafe practices must be controlled through supervision, inspection, documented safe systems and corrective action.',
    measurements: 'Use the defect severity and risk to determine immediate isolation and correction time; project rules may specify target closure times.',
    fieldExample: 'Workers use a scaffold brace as a ladder. The practice is stopped, compliant access is provided and the toolbox talk is refreshed.',
    visualGuide: 'Before/after cards: missing tie → restored tie; open edge → guardrail; overload → controlled unloading.',
    checklist: 'Observe; classify; stop if critical; correct; verify; record; prevent recurrence.',
    stopWork: 'Any practice that directly exposes workers to collapse/fall/falling-object risk.',
    emergency: 'Corrective action must not expose workers to a new hazard; isolate first and use competent personnel.',
    interview: 'Why record repeated scaffold defects? Repeated defects indicate a system weakness requiring corrective action beyond the immediate repair.',
    reference: 'ADOSH-SF CoP 26.0, Sections 3.1, 3.5 and 3.14.',
  ),
  'Toolbox Talk': ScaffoldingGoldEnhancement(
    regulatory: 'Users and scaffold workers must receive appropriate information, instruction, training and supervision.',
    measurements: 'Toolbox talk content should match the scaffold type, work level, loading, access and current site hazards.',
    fieldExample: 'Before masonry starts, the supervisor briefs workers: use only released platforms, do not remove ties/guardrails, respect load limits and report defects.',
    visualGuide: 'Five-point toolbox card: tag/status / access / load / edge protection / defects.',
    checklist: 'Topic; attendees; hazards; controls; questions; understanding; record.',
    stopWork: 'Workers cannot explain the critical scaffold restrictions or safe access route.',
    emergency: 'Include alarm, falling-object exclusion and emergency access in the briefing where relevant.',
    interview: 'What should users know? Loading restrictions, inspection/status, common defects, safe access and prohibited alterations.',
    reference: 'ADOSH-SF CoP 26.0, Section 2.3 and 3.1.3.',
  ),
  'Field Checklist': ScaffoldingGoldEnhancement(
    regulatory: 'Inspection procedures must verify the scaffold remains safe and usable.',
    measurements: 'Minimum inspection cycle: first use and every 7 days; after alteration/repair; after stability-affecting events.',
    fieldExample: 'HSE field walk: base → standards → ties/braces → platforms → edge protection → access → loading → interfaces → tag/records.',
    visualGuide: 'Top-to-bottom inspection route with eight checkpoints.',
    checklist: '1 Base 2 Stability 3 Platforms 4 Edge protection 5 Access 6 Load 7 Interfaces 8 Inspection record.',
    stopWork: 'Any critical checkpoint fails.',
    emergency: 'If a defect suggests instability, do not climb to inspect it from an unsafe position; isolate and use competent personnel.',
    interview: 'What six areas must minimum inspection consider? Design/manufacturer compliance, structure, support, platforms/protection, access/egress and suitability for safe work.',
    reference: 'ADOSH-SF CoP 26.0, Section 3.14.',
  ),
  'Quick Reference': ScaffoldingGoldEnhancement(
    regulatory: 'Use this as a field memory aid, not a substitute for the controlled CoP or design.',
    measurements: 'Key verified figures: 225 mm internal-gap trigger; 225×450 mm minimum sole board; 25/50 mm board gaps; 150 mm toe board; 950 mm guardrail; 9 m ladder landing interval; 7-day inspection maximum interval.',
    fieldExample: 'Before work: check status, access, platform, edge protection, loading and current inspection.',
    visualGuide: 'Pocket-card style: BASE / TIES / PLATFORM / EDGE / ACCESS / LOAD / INSPECTION.',
    checklist: 'SAFE BASE; SAFE STRUCTURE; SAFE PLATFORM; SAFE EDGE; SAFE ACCESS; SAFE LOAD; CURRENT INSPECTION.',
    stopWork: 'If any critical “SAFE” item cannot be verified, stop the affected work.',
    emergency: 'Keep the emergency route clear and follow the site emergency plan.',
    interview: 'What is the simplest field rule? Do not use a scaffold unless its condition, status and intended use are verified.',
    reference: 'ADOSH-SF CoP 26.0, Version 4.1.',
  ),
  'UAE / Abu Dhabi / Dubai Applicability': ScaffoldingGoldEnhancement(
    regulatory: 'Abu Dhabi projects use the current ADOSH-SF/ADPHC CoP 26.0 and applicable sector/project requirements. Dubai and other emirates may have different authority requirements.',
    measurements: 'Do not copy a numerical requirement from Dubai, Sharjah or a free zone into Abu Dhabi without verifying its authority and applicability.',
    fieldExample: 'A contractor working in Abu Dhabi and Dubai maintains separate legal registers and does not label a Dubai requirement as an Abu Dhabi CoP requirement.',
    visualGuide: 'Jurisdiction cards: Abu Dhabi / Dubai / Sharjah / Free Zone — each with its own controlling documents.',
    checklist: 'Project emirate; authority; current code version; sector requirements; project specifications; legal register.',
    stopWork: 'Regulatory applicability is uncertain for a compliance-critical decision.',
    emergency: 'Emergency response remains governed by the project/site emergency system and applicable authority requirements.',
    interview: 'Can a Sharjah scaffolding guideline be quoted as Abu Dhabi law? No. It can be a comparative reference only unless adopted by the controlling project authority.',
    reference: 'Abu Dhabi: ADOSH-SF CoP 26.0. Keep other emirate references separately labelled.',
  ),
  'Official Regulatory References': ScaffoldingGoldEnhancement(
    regulatory: 'Primary reference: ADOSH-SF CoP 26.0 — Scaffolding, Version 4.1, February 2026. Related references include CoP 23.0 Working at Heights and BS EN 1004 for prefabricated mobile access towers.',
    measurements: 'Always verify the current controlled document before publishing or relying on a regulatory number.',
    fieldExample: 'A document-control check confirms the app references the February 2026 Version 4.1 CoP instead of an older OSHAD-SF CoP 16.0 article.',
    visualGuide: 'Document control card: authority → CoP number → version → date → applicability → official source.',
    checklist: 'Current version; official source; jurisdiction; effective/applicability; project legal register updated.',
    stopWork: 'A critical compliance decision depends on an outdated or unverified source.',
    emergency: 'Use the site emergency system while regulatory/document-control questions are escalated; do not delay immediate life safety actions.',
    interview: 'What is the current Abu Dhabi scaffolding CoP used by SafeNexus? ADOSH-SF CoP 26.0, Version 4.1, February 2026.',
    reference: 'Official ADPHC publication: https://www.adphc.gov.ae/-/media/Project/ADPHC/ADPHC/PDF/OSHAD-SF/Codes-of-Practise/2026/COP-260--Scaffolding-v41-English.pdf',
  ),
};

class WorkingAtHeightGoldPoint {
  final String clause;
  final String title;
  final String meaning;
  final String hazards;
  final String controls;
  final String fieldCheck;
  final String commonMistake;
  final String action;
  final String records;

  const WorkingAtHeightGoldPoint({
    required this.clause,
    required this.title,
    required this.meaning,
    required this.hazards,
    required this.controls,
    required this.fieldCheck,
    required this.commonMistake,
    required this.action,
    required this.records,
  });
}

class WorkingAtHeightGoldSection {
  final String number;
  final String title;
  final String introduction;
  final WorkingAtHeightGoldPoint point;

  const WorkingAtHeightGoldSection({
    required this.number,
    required this.title,
    required this.introduction,
    required this.point,
  });
}

const List<WorkingAtHeightGoldSection> workingAtHeightGoldStandardSections = [
  WorkingAtHeightGoldSection(
    number: '01',
    title: 'Definition & Purpose',
    introduction: 'Working at height means work where a person could fall from one level to another and requires planned fall prevention and protection.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 01',
      title: 'Definition & Purpose',
      meaning: 'Working at height means work where a person could fall from one level to another and requires planned fall prevention and protection.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '02',
    title: 'Scope & Applications',
    introduction: 'Cover construction, maintenance, inspection, access, roof work, platforms, scaffolds, ladders, MEWPs and other applicable elevated work.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 02',
      title: 'Scope & Applications',
      meaning: 'Cover construction, maintenance, inspection, access, roof work, platforms, scaffolds, ladders, MEWPs and other applicable elevated work.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '03',
    title: 'Types of Work at Height',
    introduction: 'Include roofs, edges, openings, scaffolds, ladders, MEWPs, temporary platforms, formwork and other elevated work situations.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 03',
      title: 'Types of Work at Height',
      meaning: 'Include roofs, edges, openings, scaffolds, ladders, MEWPs, temporary platforms, formwork and other elevated work situations.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '04',
    title: 'Components / Equipment',
    introduction: 'Cover platforms, guardrails, toe boards, covers, harnesses, lanyards, lifelines, connectors and approved anchor systems.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 04',
      title: 'Components / Equipment',
      meaning: 'Cover platforms, guardrails, toe boards, covers, harnesses, lanyards, lifelines, connectors and approved anchor systems.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '05',
    title: 'Planning & Design',
    introduction: 'Plan the work before starting; select the safest access method and account for rescue, dropped objects, environment and interfaces.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 05',
      title: 'Planning & Design',
      meaning: 'Plan the work before starting; select the safest access method and account for rescue, dropped objects, environment and interfaces.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '06',
    title: 'Site Assessment',
    introduction: 'Assess edges, openings, fragile surfaces, access, ground conditions, electrical services, traffic, weather and people below.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 06',
      title: 'Site Assessment',
      meaning: 'Assess edges, openings, fragile surfaces, access, ground conditions, electrical services, traffic, weather and people below.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '07',
    title: 'Hierarchy of Controls',
    introduction: 'Prefer elimination and avoidance, then collective fall prevention, then engineered fall arrest and finally administrative controls/PPE.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 07',
      title: 'Hierarchy of Controls',
      meaning: 'Prefer elimination and avoidance, then collective fall prevention, then engineered fall arrest and finally administrative controls/PPE.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '08',
    title: 'Fall Prevention',
    introduction: 'Prevent the fall with safe platforms, guardrails, edge protection, covers and suitable access rather than relying first on fall arrest.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 08',
      title: 'Fall Prevention',
      meaning: 'Prevent the fall with safe platforms, guardrails, edge protection, covers and suitable access rather than relying first on fall arrest.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '09',
    title: 'Fall Arrest',
    introduction: 'Where prevention cannot fully control the risk, use a compatible personal fall-arrest system with suitable anchor, clearance and rescue arrangements.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 09',
      title: 'Fall Arrest',
      meaning: 'Where prevention cannot fully control the risk, use a compatible personal fall-arrest system with suitable anchor, clearance and rescue arrangements.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '10',
    title: 'Guardrails & Edge Protection',
    introduction: 'Protect exposed edges and access openings with suitable collective protection; do not remove protection without a controlled alternative.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 10',
      title: 'Guardrails & Edge Protection',
      meaning: 'Protect exposed edges and access openings with suitable collective protection; do not remove protection without a controlled alternative.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '11',
    title: 'Floor / Shaft / Opening Protection',
    introduction: 'Securely cover or guard floor openings, shafts and other voids; identify and protect temporary openings.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 11',
      title: 'Floor / Shaft / Opening Protection',
      meaning: 'Securely cover or guard floor openings, shafts and other voids; identify and protect temporary openings.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '12',
    title: 'Roof Work',
    introduction: 'Assess roof condition, access, edges, fragile areas, skylights, weather and rescue before roof work.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 12',
      title: 'Roof Work',
      meaning: 'Assess roof condition, access, edges, fragile areas, skylights, weather and rescue before roof work.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '13',
    title: 'Fragile Surfaces',
    introduction: 'Treat fragile roofs, sheets, skylights and weak surfaces as fall hazards until their strength is verified and suitable controls are installed.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 13',
      title: 'Fragile Surfaces',
      meaning: 'Treat fragile roofs, sheets, skylights and weak surfaces as fall hazards until their strength is verified and suitable controls are installed.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '14',
    title: 'Ladders',
    introduction: 'Use ladders only for appropriate tasks and durations; select, inspect, secure and position them according to the applicable requirements.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 14',
      title: 'Ladders',
      meaning: 'Use ladders only for appropriate tasks and durations; select, inspect, secure and position them according to the applicable requirements.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '15',
    title: 'Scaffolds',
    introduction: 'Use inspected and correctly configured scaffolds with complete platforms, edge protection, safe access and controlled loading.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 15',
      title: 'Scaffolds',
      meaning: 'Use inspected and correctly configured scaffolds with complete platforms, edge protection, safe access and controlled loading.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '16',
    title: 'MEWP / Aerial Platforms',
    introduction: 'Use the correct MEWP, trained operator, pre-use inspection, ground assessment, exclusion zone and manufacturer requirements.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 16',
      title: 'MEWP / Aerial Platforms',
      meaning: 'Use the correct MEWP, trained operator, pre-use inspection, ground assessment, exclusion zone and manufacturer requirements.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '17',
    title: 'Temporary Platforms',
    introduction: 'Ensure temporary working platforms are designed, stable, complete and suitable for the intended load and task.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 17',
      title: 'Temporary Platforms',
      meaning: 'Ensure temporary working platforms are designed, stable, complete and suitable for the intended load and task.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '18',
    title: 'Harnesses & Lanyards',
    introduction: 'Select compatible equipment, inspect before use, connect correctly and ensure the system is suitable for the planned task.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 18',
      title: 'Harnesses & Lanyards',
      meaning: 'Select compatible equipment, inspect before use, connect correctly and ensure the system is suitable for the planned task.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '19',
    title: 'Anchor Points & Lifelines',
    introduction: 'Use approved anchors/lifelines suitable for the system; never connect to an unverified point.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 19',
      title: 'Anchor Points & Lifelines',
      meaning: 'Use approved anchors/lifelines suitable for the system; never connect to an unverified point.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '20',
    title: 'Fall Clearance & Swing Fall',
    introduction: 'Confirm sufficient clearance below the worker and control swing-fall hazards before using a fall-arrest system.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 20',
      title: 'Fall Clearance & Swing Fall',
      meaning: 'Confirm sufficient clearance below the worker and control swing-fall hazards before using a fall-arrest system.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '21',
    title: 'Dropped Objects',
    introduction: 'Control tools, materials and components at height using secure storage, tethering where appropriate, toe boards and exclusion zones.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 21',
      title: 'Dropped Objects',
      meaning: 'Control tools, materials and components at height using secure storage, tethering where appropriate, toe boards and exclusion zones.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '22',
    title: 'Weather / Wind / Heat',
    introduction: 'Reassess elevated work for wind, rain, heat, poor visibility, wet surfaces and other environmental conditions.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 22',
      title: 'Weather / Wind / Heat',
      meaning: 'Reassess elevated work for wind, rain, heat, poor visibility, wet surfaces and other environmental conditions.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '23',
    title: 'Electrical / Overhead Services',
    introduction: 'Identify overhead electrical and other services before access or equipment positioning and apply the required isolation, clearance and authority controls.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 23',
      title: 'Electrical / Overhead Services',
      meaning: 'Identify overhead electrical and other services before access or equipment positioning and apply the required isolation, clearance and authority controls.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '24',
    title: 'People / Traffic Interface',
    introduction: 'Protect people, vehicles and public areas below or adjacent to elevated work using barriers, exclusion zones and controlled access.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 24',
      title: 'People / Traffic Interface',
      meaning: 'Protect people, vehicles and public areas below or adjacent to elevated work using barriers, exclusion zones and controlled access.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '25',
    title: 'RAMS / JSA / Risk Assessment',
    introduction: 'Make the assessment task-specific and include access, fall controls, dropped objects, environment, equipment, interfaces and rescue.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 25',
      title: 'RAMS / JSA / Risk Assessment',
      meaning: 'Make the assessment task-specific and include access, fall controls, dropped objects, environment, equipment, interfaces and rescue.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '26',
    title: 'PTW / Authorization',
    introduction: 'Use required permits, authorisations and coordination controls for high-risk or interfacing activities.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 26',
      title: 'PTW / Authorization',
      meaning: 'Use required permits, authorisations and coordination controls for high-risk or interfacing activities.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '27',
    title: 'Safe Work Procedure',
    introduction: 'Sequence the work: plan → assess → establish protection → inspect equipment → brief workers → perform task → monitor → close safely.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 27',
      title: 'Safe Work Procedure',
      meaning: 'Sequence the work: plan → assess → establish protection → inspect equipment → brief workers → perform task → monitor → close safely.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '28',
    title: 'Inspection & Examination',
    introduction: 'Inspect work-at-height systems before use and at required intervals/events; remove defective equipment from service.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 28',
      title: 'Inspection & Examination',
      meaning: 'Inspect work-at-height systems before use and at required intervals/events; remove defective equipment from service.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '29',
    title: 'Competency & Responsibilities',
    introduction: 'Define competent workers, supervisors, HSE personnel, inspectors, operators and rescue roles; verify training and authorization.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 29',
      title: 'Competency & Responsibilities',
      meaning: 'Define competent workers, supervisors, HSE personnel, inspectors, operators and rescue roles; verify training and authorization.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '30',
    title: 'PPE',
    introduction: 'Use task-appropriate helmet, footwear, gloves, eye protection, high visibility and fall-protection equipment where required.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 30',
      title: 'PPE',
      meaning: 'Use task-appropriate helmet, footwear, gloves, eye protection, high visibility and fall-protection equipment where required.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '31',
    title: 'Emergency / Rescue',
    introduction: 'Plan rescue before work. Control the scene, communicate, recover a suspended worker safely, provide first aid and arrange medical evaluation.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 31',
      title: 'Emergency / Rescue',
      meaning: 'Plan rescue before work. Control the scene, communicate, recover a suspended worker safely, provide first aid and arrange medical evaluation.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '32',
    title: 'Stop-Work Conditions',
    introduction: 'Stop for missing edge protection, unsafe openings, defective fall equipment, unknown anchors, inadequate clearance, unsafe access, severe weather or absent rescue controls.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 32',
      title: 'Stop-Work Conditions',
      meaning: 'Stop for missing edge protection, unsafe openings, defective fall equipment, unknown anchors, inadequate clearance, unsafe access, severe weather or absent rescue controls.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '33',
    title: 'Unsafe Practices → Corrective Actions',
    introduction: 'Record the actual unsafe condition, immediate control, root cause, responsible person and verified close-out.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 33',
      title: 'Unsafe Practices → Corrective Actions',
      meaning: 'Record the actual unsafe condition, immediate control, root cause, responsible person and verified close-out.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '34',
    title: 'Toolbox Talk',
    introduction: 'Brief workers on task hazards, access, edge protection, fall-arrest limits, dropped objects, weather, electrical interfaces and rescue.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 34',
      title: 'Toolbox Talk',
      meaning: 'Brief workers on task hazards, access, edge protection, fall-arrest limits, dropped objects, weather, electrical interfaces and rescue.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '35',
    title: 'Field Checklist',
    introduction: 'Check planning, access, platform, edge protection, openings, equipment, anchors, clearance, dropped objects, weather, exclusion zones and rescue.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 35',
      title: 'Field Checklist',
      meaning: 'Check planning, access, platform, edge protection, openings, equipment, anchors, clearance, dropped objects, weather, exclusion zones and rescue.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '36',
    title: 'Quick Reference',
    introduction: 'Use: ELIMINATE → PREVENT → PROTECT → INSPECT → ACCESS → CONTROL OBJECTS → CHECK CLEARANCE → RESCUE READY.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 36',
      title: 'Quick Reference',
      meaning: 'Use: ELIMINATE → PREVENT → PROTECT → INSPECT → ACCESS → CONTROL OBJECTS → CHECK CLEARANCE → RESCUE READY.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '37',
    title: 'UAE / Abu Dhabi / Dubai Applicability',
    introduction: 'Keep Abu Dhabi requirements separate from Dubai and other jurisdictions; verify the applicable authority and current document version.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 37',
      title: 'UAE / Abu Dhabi / Dubai Applicability',
      meaning: 'Keep Abu Dhabi requirements separate from Dubai and other jurisdictions; verify the applicable authority and current document version.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '38',
    title: 'Official Regulatory References',
    introduction: 'Primary Abu Dhabi baseline: ADOSH-SF CoP 23.0 — Working at Heights. Cross-reference applicable scaffold, ladder, MEWP, electrical and other HSE requirements.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 38',
      title: 'Official Regulatory References',
      meaning: 'Primary Abu Dhabi baseline: ADOSH-SF CoP 23.0 — Working at Heights. Cross-reference applicable scaffold, ladder, MEWP, electrical and other HSE requirements.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
];


/// Step 5AK-A: central Gold Standard router.
///
/// The old Abu Dhabi registry remains the index. This router decides whether
/// a selected topic has a dedicated Gold Standard data source. If it does,
/// the app opens that source instead of the older generic CoP content.
Widget? buildAbuDhabiGoldTopicPage(ReferenceTopic topic) {
  switch (topic.id) {
    case 'ad_cop_29_0':
      return null; // Excavation is handled by AbuDhabiHseTopicPage.
    case 'ad_cop_23_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: workingAtHeightGoldStandardSections,
        regulatory: 'ADPHC CoP 23.0 — Working at Heights — V4.1; effective 27 February 2026.',
      );
    case 'ad_cop_26_0':
      return ScaffoldingGoldBookPage(
        topic: topic,
        sections: scaffoldingGoldStandardSections,
        regulatory: 'ADPHC CoP 26.0 — Scaffolding — V4.1; effective 27 February 2026.',
      );
    case 'ad_cop_27_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: confinedSpaceGoldStandardSections,
        regulatory: 'ADPHC CoP 27.0 — Confined Spaces — V4.0; effective 15 July 2024.',
      );
    case 'ad_cop_21_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: permitToWorkGoldStandardSections,
        regulatory: 'ADPHC CoP 21.0 — Permit to Work Systems — V4.0; effective 15 July 2024.',
      );
    case 'ad_cop_11_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: safetyInHeatGoldStandardSections,
        regulatory: 'ADPHC CoP 11.0 — Safety in the Heat — V4.0; effective 15 July 2024.',
      );
    case 'ad_cop_35_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: portablePowerToolsGoldStandardSections,
        regulatory: 'ADPHC CoP 35.0 — Portable Power Tools — V4.1; effective 27 February 2026.',
      );
    case 'ad_cop_40_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: formworkGoldStandardSections,
        regulatory: 'ADPHC CoP 40.0 — False Work (Formwork) — V4.1; effective 27 February 2026.',
      );
    case 'ad_cop_51_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: forkliftPoweredLiftTruckGoldSections,
        regulatory: 'ADPHC CoP 51.0 — Powered Lift Trucks — V4.1; effective 27 February 2026.',
      );
    case 'ad_cop_14_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: abuDhabiFiveNQGoldStandardSections
            .where((section) => section.category == '5P — Manual Handling')
            .toList(),
        regulatory: 'ADPHC CoP 14.0 — Manual Handling and Ergonomics.',
      );
    case 'ad_cop_15_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: abuDhabiFiveNQGoldStandardSections
            .where((section) =>
                section.category == '5N — Electricity on Site & Electrical Tools')
            .toList(),
        regulatory: 'ADPHC CoP 15.0 — Electrical Safety.',
      );
    case 'ad_cop_28_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: abuDhabiFiveNQGoldStandardSections
            .where((section) => section.category == '5Q — Hot Work')
            .toList(),
        regulatory: 'ADPHC CoP 28.0 — Hot Work.',
      );
    case 'ad_cop_34_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: craneLiftingGoldStandardSections,
        regulatory:
            'ADPHC CoP 34.0 — Safe Use of Lifting Equipment and Lifting Accessories.',
      );
    case 'ad_cop_43_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: abuDhabiFiveNQGoldStandardSections
            .where((section) => section.category == '5O — Temporary Works')
            .toList(),
        regulatory: 'ADPHC CoP 43.0 — Temporary Structures.',
      );
    case 'ad_cop_36_0':
      return AbuDhabiPlantEquipmentGoldIndexPage(topic: topic);
    default:
      return null;
  }
}


/// Production Gold Standard implementation for CoP 26.0 Scaffolding.
///
/// Navigation:
/// Subject introduction -> 38 chapter points -> point detail ->
/// tappable sub-points -> sub-point detail.
///
/// The existing consolidated Gold data remains the source of the content.
/// The enhancement layer adds field examples, measurements, checklists,
/// stop-work points, emergency prompts and visual guidance without creating
/// a new scaffolding data file.
class ScaffoldingGoldBookPage extends StatelessWidget {
  final ReferenceTopic topic;
  final List<ScaffoldingGoldSection> sections;
  final String regulatory;

  const ScaffoldingGoldBookPage({
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
        title: const Text('Scaffolding'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
        children: [
          _introCard(),
          const SizedBox(height: 14),
          const Text(
            'Complete Field Handbook',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${sections.length} structured chapters • Tap any chapter to open the detailed field page.',
            style: const TextStyle(fontSize: 14.5, height: 1.45),
          ),
          const SizedBox(height: 12),
          ...sections.asMap().entries.map(
            (entry) => _chapterCard(context, entry.key + 1, entry.value),
          ),
        ],
      ),
    );
  }

  Widget _introCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ABU DHABI HSE • GOLD STANDARD',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w900,
                color: green,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              topic.title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 9),
            const Text(
              'Scaffolding is a temporary access and working-platform system. '
              'Safe use depends on suitable selection, competent erection and '
              'alteration, inspection, stability, safe access, fall protection, '
              'load control and effective management of interfaces and changes.',
              style: TextStyle(fontSize: 15, height: 1.55),
            ),
            const SizedBox(height: 14),
            const Text(
              'Main Hazards',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 7),
            ...const [
              'Falls from height',
              'Scaffold instability or collapse',
              'Falling objects and materials',
              'Unsafe access and egress',
              'Overloading',
              'Unsafe erection or alteration',
              'Electrical interface',
              'Weather and wind exposure',
              'Poor foundation or ground condition',
            ].map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(fontWeight: FontWeight.w900)),
                    Expanded(child: Text(item)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              regulatory,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.45,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chapterCard(
    BuildContext context,
    int index,
    ScaffoldingGoldSection section,
  ) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        leading: CircleAvatar(
          backgroundColor: green.withValues(alpha: 0.12),
          child: Text(
            '$index',
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: darkGreen,
            ),
          ),
        ),
        title: Text(
          section.title,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            color: darkGreen,
          ),
        ),
        subtitle: Text(
          section.introduction,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right, color: darkGreen),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ScaffoldingChapterDetailPage(
              chapterNumber: index,
              section: section,
            ),
          ),
        ),
      ),
    );
  }
}

class ScaffoldingChapterDetailPage extends StatelessWidget {
  final int chapterNumber;
  final ScaffoldingGoldSection section;

  const ScaffoldingChapterDetailPage({
    super.key,
    required this.chapterNumber,
    required this.section,
  });

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    final p = section.point;
    final enhancement = scaffoldingGoldEnhancements[section.title];

    final subPoints = <_ScaffoldingSubPoint>[
      _ScaffoldingSubPoint('Meaning / What this means', p.meaning),
      _ScaffoldingSubPoint('Hazards / Consequences', p.hazards),
      _ScaffoldingSubPoint('Control Measures', p.controls),
      _ScaffoldingSubPoint('HSE Officer Field Check', p.fieldCheck),
      _ScaffoldingSubPoint('Common Mistake', p.commonMistake),
      _ScaffoldingSubPoint('Corrective Action', p.action),
      _ScaffoldingSubPoint('Records / Evidence', p.records),
    ].where((item) => item.detail.trim().isNotEmpty).toList();

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          section.title,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CHAPTER $chapterNumber • ${section.number}',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w900,
                      color: green,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    section.title,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    section.introduction,
                    style: const TextStyle(fontSize: 15, height: 1.55),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Clause: ${p.clause}',
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Detailed Field Controls',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w900,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Tap each item to open its full explanation.',
            style: TextStyle(fontSize: 14.5),
          ),
          const SizedBox(height: 12),
          ...subPoints.asMap().entries.map(
            (entry) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 9,
                ),
                leading: CircleAvatar(
                  backgroundColor: green.withValues(alpha: 0.12),
                  child: Text(
                    '${entry.key + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: darkGreen,
                    ),
                  ),
                ),
                title: Text(
                  entry.value.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: darkGreen,
                  ),
                ),
                subtitle: Text(
                  entry.value.detail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: darkGreen,
                ),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ScaffoldingSubPointDetailPage(
                      chapterTitle: section.title,
                      point: entry.value,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (enhancement != null) ...[
            const SizedBox(height: 10),
            const Text(
              'Gold Standard Field Layer',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w900,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 7),
            _enhancementCard('Regulatory Basis', enhancement.regulatory, Icons.gavel),
            _enhancementCard('Measurements / Limits', enhancement.measurements, Icons.straighten),
            _enhancementCard('Field Example', enhancement.fieldExample, Icons.construction),
            _visualCard(enhancement.visualGuide),
            _enhancementCard('Field Checklist', enhancement.checklist, Icons.fact_check_outlined),
            _enhancementCard('Stop-Work Conditions', enhancement.stopWork, Icons.stop_circle_outlined),
            _enhancementCard('Emergency / Rescue', enhancement.emergency, Icons.emergency_outlined),
            _enhancementCard('Interview Question', enhancement.interview, Icons.school_outlined),
            _enhancementCard('Official / Control Reference', enhancement.reference, Icons.menu_book_outlined),
          ],
        ],
      ),
    );
  }

  Widget _enhancementCard(String title, String detail, IconData icon) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: green),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    detail,
                    style: const TextStyle(fontSize: 14.5, height: 1.55),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _visualCard(String guide) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.account_tree_outlined, color: green),
                SizedBox(width: 11),
                Text(
                  'Visual Field Guide',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: darkGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: green.withValues(alpha: 0.07),
                border: Border.all(color: green.withValues(alpha: 0.18)),
              ),
              child: Text(
                guide,
                style: const TextStyle(
                  fontSize: 14.5,
                  height: 1.55,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 9),
            const Text(
              'SafeNexus visual principle: use a simple diagram/illustration whenever a measurement, sequence, component relationship or safe/unsafe condition is easier to understand visually.',
              style: TextStyle(fontSize: 12.8, height: 1.45),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScaffoldingSubPoint {
  final String title;
  final String detail;

  const _ScaffoldingSubPoint(this.title, this.detail);
}

class ScaffoldingSubPointDetailPage extends StatelessWidget {
  final String chapterTitle;
  final _ScaffoldingSubPoint point;

  const ScaffoldingSubPointDetailPage({
    super.key,
    required this.chapterTitle,
    required this.point,
  });

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          point.title,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SCAFFOLDING • FIELD DETAIL',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w900,
                      color: green,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    chapterTitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    point.title,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    point.detail,
                    style: const TextStyle(fontSize: 16, height: 1.6),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.verified_user_outlined, color: green),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Field use: apply the current approved CoP, risk assessment, method statement, competent-person requirements, manufacturer instructions and project controls applicable to the task.',
                      style: TextStyle(fontSize: 14.5, height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


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
    final points = _sectionPoints(section);
    final sectionIntro = _readString(section, 'introduction');
    final category = _readString(section, 'category');
    final number = _readString(section, 'number');

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(title, overflow: TextOverflow.ellipsis),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (number.isNotEmpty)
                    Text(number, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: green)),
                  if (category.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(category, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: darkGreen)),
                  ],
                  const SizedBox(height: 8),
                  Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: darkGreen)),
                  if (sectionIntro.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(sectionIntro, style: const TextStyle(fontSize: 15, height: 1.5)),
                  ],
                  const SizedBox(height: 12),
                  Text(
                    '${points.length} detailed point${points.length == 1 ? '' : 's'} • Tap any point to open the full field explanation.',
                    style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...points.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final point = entry.value;
            final pointTitle = _readString(point, 'title').isEmpty
                ? 'Field Point $index'
                : _readString(point, 'title');
            final preview = _pointPreview(point);

            return Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                leading: CircleAvatar(
                  backgroundColor: green.withValues(alpha: 0.12),
                  child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w900, color: darkGreen)),
                ),
                title: Text(pointTitle, style: const TextStyle(fontWeight: FontWeight.w900, color: darkGreen)),
                subtitle: preview.isEmpty
                    ? const Text('Open detailed field explanation')
                    : Text(preview, maxLines: 2, overflow: TextOverflow.ellipsis),
                trailing: const Icon(Icons.chevron_right, color: darkGreen),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AbuDhabiGoldPointDetailPage(
                      title: pointTitle,
                      point: point,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class AbuDhabiGoldPointDetailPage extends StatelessWidget {
  final String title;
  final dynamic point;

  const AbuDhabiGoldPointDetailPage({super.key, required this.title, required this.point});

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    final fields = _pointFields(point);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(title, overflow: TextOverflow.ellipsis),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('GOLD STANDARD FIELD EXPLANATION', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w900, color: green)),
                  const SizedBox(height: 7),
                  Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: darkGreen)),
                  const SizedBox(height: 8),
                  const Text(
                    'Use this page as the field-level explanation. Check the applicable controlled CoP, approved method statement, risk assessment, manufacturer instructions and project requirements before execution.',
                    style: TextStyle(fontSize: 14.5, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...fields.map((field) => Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.shield_outlined, color: green),
                          const SizedBox(width: 10),
                          Expanded(child: Text(field.$1, style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w900, color: darkGreen))),
                        ],
                      ),
                      const SizedBox(height: 9),
                      Text(field.$2, style: const TextStyle(fontSize: 15, height: 1.55)),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

String _readString(dynamic object, String field) {
  try {
    final value = switch (field) {
      'title' => object.title,
      'detail' => object.detail,
      'content' => object.content,
      'meaning' => object.meaning,
      'hazards' => object.hazards,
      'controls' => object.controls,
      'fieldCheck' => object.fieldCheck,
      'commonMistake' => object.commonMistake,
      'action' => object.action,
      'records' => object.records,
      'fieldProcedure' => object.fieldProcedure,
      'roles' => object.roles,
      'preWork' => object.preWork,
      'duringWork' => object.duringWork,
      'monitoring' => object.monitoring,
      'emergency' => object.emergency,
      'stopWork' => object.stopWork,
      'checklist' => object.checklist,
      'interview' => object.interview,
      'number' => object.number,
      'category' => object.category,
      'introduction' => object.introduction,
      _ => null,
    };
    if (value is String) return value.trim();
  } catch (_) {}
  return '';
}

String _sectionTitle(dynamic section) {
  for (final field in const ['title', 'name', 'heading', 'category', 'number']) {
    final value = _readString(section, field);
    if (value.isNotEmpty) return value;
  }
  return 'Field Safety Section';
}

String _sectionPreview(dynamic section) {
  for (final field in const [
    'introduction',
    'detail',
    'content',
    'meaning',
    'description',
  ]) {
    final value = _readString(section, field);
    if (value.isNotEmpty) return value;
  }
  final points = _sectionPoints(section);
  if (points.isNotEmpty) return _pointPreview(points.first);
  return '';
}

List<dynamic> _sectionPoints(dynamic section) {
  try {
    final list = section.points as List;
    return list.toList();
  } catch (_) {}
  try {
    return [section.point];
  } catch (_) {}
  return const [];
}

String _pointPreview(dynamic point) {
  for (final field in const ['detail', 'content', 'meaning', 'hazards', 'controls']) {
    final value = _readString(point, field);
    if (value.isNotEmpty) return value;
  }
  return '';
}

List<(String, String)> _pointFields(dynamic point) {
  final result = <(String, String)>[];

  void add(String label, String field) {
    final value = _readString(point, field);
    if (value.isNotEmpty) result.add((label, value));
  }

  add('Meaning / Detail', 'detail');
  add('Content', 'content');
  add('Meaning', 'meaning');
  add('Hazards / Consequences', 'hazards');
  add('Control Measures', 'controls');
  add('Field HSE Check', 'fieldCheck');
  add('Common Mistake', 'commonMistake');
  add('Corrective Action', 'action');
  add('Records / Evidence', 'records');
  add('Field Procedure', 'fieldProcedure');
  add('Roles & Responsibilities', 'roles');
  add('Before Starting', 'preWork');
  add('During Work', 'duringWork');
  add('Monitoring / Verification', 'monitoring');
  add('Emergency / Rescue', 'emergency');
  add('Stop-Work Condition', 'stopWork');
  add('HSE Officer Checklist', 'checklist');
  add('Interview Question', 'interview');

  // Some Gold sources expose a list of strings inside a point.
  try {
    final list = point.points as List;
    for (final item in list) {
      final text = item.toString().trim();
      if (text.isNotEmpty) result.add(('Field Point', text));
    }
  } catch (_) {}

  return result;
}

class AbuDhabiPlantEquipmentGoldIndexPage extends StatelessWidget {
  final ReferenceTopic topic;
  const AbuDhabiPlantEquipmentGoldIndexPage({super.key, required this.topic});

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  List<_GoldChapter> get chapters => [
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
