// lib/data/hse_work_categories.dart

import '../models/hse_work_model.dart';

/// ============================================================
/// SAFE NEXUS HSE
/// UAE-WIDE HSE WORK ACTIVITY & DOCUMENT REQUIREMENTS
///
/// Purpose:
/// When a new work activity is selected, SafeNexus can use this
/// data to generate the required HSE Work Pack checklist.
///
/// IMPORTANT:
/// This is a planning/reference structure.
/// Actual requirements depend on the project, client, consultant,
/// authority, jurisdiction, activity risk, approved RAMS/JSA,
/// permits and current applicable regulations.
/// ============================================================

/// ------------------------------------------------------------
/// Helper: create a document requirement
/// ------------------------------------------------------------
HseDocumentRequirement _doc(
  String id,
  String title,
  String category,
  String description, {
  bool mandatory = true,
  bool requiresExpiry = false,
  bool requiresSignature = false,
}) {
  return HseDocumentRequirement(
    id: id,
    title: title,
    category: category,
    description: description,
    mandatory: mandatory,
    requiresExpiry: requiresExpiry,
    requiresSignature: requiresSignature,
  );
}

/// ============================================================
/// COMMON DOCUMENTS
/// ============================================================

final List<HseDocumentRequirement> _commonDocuments = [
  _doc(
    'COMMON-01',
    'Project HSE Plan',
    HseDocumentCategories.projectManagement,
    'Approved project HSE plan applicable to the work activity.',
  ),
  _doc(
    'COMMON-02',
    'HSE Policy',
    HseDocumentCategories.projectManagement,
    'Current company HSE policy and commitments.',
  ),
  _doc(
    'COMMON-03',
    'Risk Assessment / HIRA',
    HseDocumentCategories.riskManagement,
    'Activity-specific hazard identification and risk assessment.',
  ),
  _doc(
    'COMMON-04',
    'RAMS / Method Statement',
    HseDocumentCategories.methodStatement,
    'Approved risk assessment and method statement for the activity.',
  ),
  _doc(
    'COMMON-05',
    'Permit to Work',
    HseDocumentCategories.permit,
    'Applicable permit for the activity where required.',
    requiresSignature: true,
  ),
  _doc(
    'COMMON-06',
    'Toolbox Talk Record',
    HseDocumentCategories.dailyRecords,
    'Relevant toolbox talk with attendance and worker confirmation.',
    requiresSignature: true,
  ),
  _doc(
    'COMMON-07',
    'Worker Competency Records',
    HseDocumentCategories.training,
    'Evidence that workers are trained and competent for the activity.',
    requiresExpiry: true,
  ),
  _doc(
    'COMMON-08',
    'Pre-Start Inspection',
    HseDocumentCategories.inspection,
    'Pre-start inspection of the work area and relevant equipment.',
  ),
  _doc(
    'COMMON-09',
    'Emergency Arrangement',
    HseDocumentCategories.emergency,
    'Applicable emergency response and communication arrangements.',
  ),
  _doc(
    'COMMON-10',
    'Daily HSE Inspection',
    HseDocumentCategories.inspection,
    'Daily inspection record for the activity.',
  ),
];

/// ============================================================
/// EXCAVATION
/// ============================================================

final List<HseDocumentRequirement> _excavationDocuments = [
  ..._commonDocuments,
  _doc(
    'EXC-01',
    'Excavation Permit',
    HseDocumentCategories.permit,
    'Approved excavation permit before ground breaking.',
    requiresSignature: true,
  ),
  _doc(
    'EXC-02',
    'Underground Utility / Service Clearance',
    HseDocumentCategories.legal,
    'Verification of underground services and applicable clearances/NOCs.',
  ),
  _doc(
    'EXC-03',
    'Excavation Drawing / Layout',
    HseDocumentCategories.documentControl,
    'Approved excavation layout, dimensions and location.',
  ),
  _doc(
    'EXC-04',
    'Shoring / Temporary Works Design',
    HseDocumentCategories.riskManagement,
    'Approved engineered protective system where required.',
  ),
  _doc(
    'EXC-05',
    'Dewatering Arrangement',
    HseDocumentCategories.environmental,
    'Approved dewatering arrangement where groundwater or water ingress is present.',
  ),
  _doc(
    'EXC-06',
    'Excavation Daily Inspection',
    HseDocumentCategories.inspection,
    'Competent-person inspection of excavation conditions.',
    requiresSignature: true,
  ),
  _doc(
    'EXC-07',
    'Excavation Emergency / Rescue Plan',
    HseDocumentCategories.emergency,
    'Emergency arrangements for collapse, flooding, service strike or other excavation incidents.',
  ),
  _doc(
    'EXC-08',
    'Plant and Excavator Inspection',
    HseDocumentCategories.equipment,
    'Pre-use inspection and relevant certification of excavation plant.',
  ),
  _doc(
    'EXC-09',
    'Authority / Utility Requirements',
    HseDocumentCategories.legal,
    'Current applicable authority, utility-owner and project requirements.',
  ),
  _doc(
    'EXC-10',
    'Excavation Close-Out Record',
    HseDocumentCategories.documentControl,
    'Final inspection and closure record after completion.',
  ),
];

/// ============================================================
/// TRENCHING
/// ============================================================

final List<HseDocumentRequirement> _trenchingDocuments = [
  ..._excavationDocuments,
  _doc(
    'TRN-01',
    'Trench Protection Inspection',
    HseDocumentCategories.inspection,
    'Inspection of shoring, shielding, battering or other approved protection.',
  ),
  _doc(
    'TRN-02',
    'Safe Access / Egress Inspection',
    HseDocumentCategories.inspection,
    'Verification of safe access and emergency egress.',
  ),
  _doc(
    'TRN-03',
    'Spoil and Edge Control Check',
    HseDocumentCategories.inspection,
    'Check that spoil, materials and plant are safely controlled near the trench.',
  ),
  _doc(
    'TRN-04',
    'Water Ingress Monitoring',
    HseDocumentCategories.environmental,
    'Monitoring and control of water accumulation or ingress.',
  ),
];

/// ============================================================
/// UNDERGROUND SERVICES
/// ============================================================

final List<HseDocumentRequirement> _undergroundServiceDocuments = [
  ..._commonDocuments,
  _doc(
    'UGS-01',
    'Utility Drawings',
    HseDocumentCategories.documentControl,
    'Latest available underground utility/service drawings.',
  ),
  _doc(
    'UGS-02',
    'NOC / Utility Clearance',
    HseDocumentCategories.legal,
    'Applicable NOCs and utility-owner clearances.',
  ),
  _doc(
    'UGS-03',
    'Service Detection Record',
    HseDocumentCategories.inspection,
    'Record of approved service detection and verification.',
  ),
  _doc(
    'UGS-04',
    'Trial Pit Record',
    HseDocumentCategories.inspection,
    'Trial-pit verification where required by the approved procedure.',
  ),
  _doc(
    'UGS-05',
    'Service Marking Plan',
    HseDocumentCategories.documentControl,
    'Physical marking and identification of known services.',
  ),
  _doc(
    'UGS-06',
    'Utility Emergency Response',
    HseDocumentCategories.emergency,
    'Emergency response arrangements for utility/service damage.',
  ),
];

/// ============================================================
/// WORK AT HEIGHT
/// ============================================================

final List<HseDocumentRequirement> _workAtHeightDocuments = [
  ..._commonDocuments,
  _doc(
    'WAH-01',
    'Work at Height Permit',
    HseDocumentCategories.permit,
    'Applicable work-at-height permit.',
    requiresSignature: true,
  ),
  _doc(
    'WAH-02',
    'Fall Protection Plan',
    HseDocumentCategories.riskManagement,
    'Approved fall prevention and protection arrangement.',
  ),
  _doc(
    'WAH-03',
    'Full Body Harness Inspection',
    HseDocumentCategories.equipment,
    'Inspection of harnesses, lanyards and connecting devices.',
  ),
  _doc(
    'WAH-04',
    'Anchor Point Verification',
    HseDocumentCategories.inspection,
    'Verification of suitable approved anchor points.',
  ),
  _doc(
    'WAH-05',
    'Rescue Plan',
    HseDocumentCategories.emergency,
    'Plan for rescue after a fall or suspension event.',
  ),
  _doc(
    'WAH-06',
    'Scaffold / Platform Inspection',
    HseDocumentCategories.inspection,
    'Inspection and status of access platform where applicable.',
  ),
  _doc(
    'WAH-07',
    'Dropped Object Control',
    HseDocumentCategories.riskManagement,
    'Controls for tools and materials falling from height.',
  ),
  _doc(
    'WAH-08',
    'Height Work Competency',
    HseDocumentCategories.training,
    'Evidence of required worker training/competency.',
    requiresExpiry: true,
  ),
];

/// ============================================================
/// SCAFFOLDING
/// ============================================================

final List<HseDocumentRequirement> _scaffoldDocuments = [
  ..._commonDocuments,
  _doc(
    'SCF-01',
    'Scaffold Design / Approved Arrangement',
    HseDocumentCategories.methodStatement,
    'Approved scaffold design or configuration where required.',
  ),
  _doc(
    'SCF-02',
    'Scaffold Erection Competency',
    HseDocumentCategories.training,
    'Competency records for scaffold erection/dismantling personnel.',
    requiresExpiry: true,
  ),
  _doc(
    'SCF-03',
    'Scaffold Inspection Register',
    HseDocumentCategories.inspection,
    'Inspection register and status identification.',
  ),
  _doc(
    'SCF-04',
    'Scaffold Tag / Status Record',
    HseDocumentCategories.equipment,
    'Current scaffold status/tagging system.',
  ),
  _doc(
    'SCF-05',
    'Scaffold Handover Certificate',
    HseDocumentCategories.inspection,
    'Handover record where required by the project.',
    requiresSignature: true,
  ),
  _doc(
    'SCF-06',
    'Scaffold Alteration Record',
    HseDocumentCategories.documentControl,
    'Record of approved scaffold modifications.',
  ),
];

/// ============================================================
/// LADDER
/// ============================================================

final List<HseDocumentRequirement> _ladderDocuments = [
  ..._commonDocuments,
  _doc(
    'LAD-01',
    'Ladder Inspection Register',
    HseDocumentCategories.inspection,
    'Inspection register for ladders.',
  ),
  _doc(
    'LAD-02',
    'Ladder Pre-Use Checklist',
    HseDocumentCategories.equipment,
    'Pre-use condition check.',
  ),
  _doc(
    'LAD-03',
    'Safe Ladder Selection Assessment',
    HseDocumentCategories.riskManagement,
    'Confirmation that ladder use is suitable for the task.',
  ),
];

/// ============================================================
/// HOT WORK
/// ============================================================

final List<HseDocumentRequirement> _hotWorkDocuments = [
  ..._commonDocuments,
  _doc(
    'HOT-01',
    'Hot Work Permit',
    HseDocumentCategories.permit,
    'Approved hot work permit before welding, cutting, grinding or similar work.',
    requiresSignature: true,
  ),
  _doc(
    'HOT-02',
    'Fire Watch Assignment',
    HseDocumentCategories.emergency,
    'Assigned competent fire watch where required.',
  ),
  _doc(
    'HOT-03',
    'Fire Extinguisher Inspection',
    HseDocumentCategories.equipment,
    'Suitable and inspected fire extinguishing equipment.',
  ),
  _doc(
    'HOT-04',
    'Gas Cylinder Inspection',
    HseDocumentCategories.equipment,
    'Inspection and certification of applicable cylinders.',
    requiresExpiry: true,
  ),
  _doc(
    'HOT-05',
    'Welding Machine Inspection',
    HseDocumentCategories.equipment,
    'Pre-use inspection of welding equipment.',
  ),
  _doc(
    'HOT-06',
    'Spark / Heat Containment Check',
    HseDocumentCategories.inspection,
    'Verification of protection against sparks, slag and heat transfer.',
  ),
  _doc(
    'HOT-07',
    'Post Hot-Work Fire Watch Record',
    HseDocumentCategories.emergency,
    'Post-work monitoring where required.',
  ),
];

/// ============================================================
/// WELDING
/// ============================================================

final List<HseDocumentRequirement> _weldingDocuments = [
  ..._hotWorkDocuments,
  _doc(
    'WLD-01',
    'Welder Competency Certificate',
    HseDocumentCategories.training,
    'Relevant welder qualification/competency evidence.',
    requiresExpiry: true,
  ),
  _doc(
    'WLD-02',
    'Welding Leads / Cable Inspection',
    HseDocumentCategories.equipment,
    'Inspection of leads, holders and connections.',
  ),
  _doc(
    'WLD-03',
    'Welding Screen Arrangement',
    HseDocumentCategories.inspection,
    'Protection of nearby workers from arc radiation.',
  ),
];

/// ============================================================
/// GRINDING / CUTTING
/// ============================================================

final List<HseDocumentRequirement> _grindingCuttingDocuments = [
  ..._hotWorkDocuments,
  _doc(
    'GRD-01',
    'Grinding Machine Inspection',
    HseDocumentCategories.equipment,
    'Pre-use inspection of grinder.',
  ),
  _doc(
    'GRD-02',
    'Grinding Wheel Inspection',
    HseDocumentCategories.equipment,
    'Inspection for correct type, condition and compatibility.',
  ),
  _doc(
    'GRD-03',
    'Machine Guard Verification',
    HseDocumentCategories.inspection,
    'Guard and protective-device verification.',
  ),
  _doc(
    'GRD-04',
    'Face / Eye Protection Check',
    HseDocumentCategories.inspection,
    'Verification of appropriate eye and face protection.',
  ),
];

/// ============================================================
/// CONFINED SPACE
/// ============================================================

final List<HseDocumentRequirement> _confinedSpaceDocuments = [
  ..._commonDocuments,
  _doc(
    'CFS-01',
    'Confined Space Entry Permit',
    HseDocumentCategories.permit,
    'Approved confined-space entry permit.',
    requiresSignature: true,
  ),
  _doc(
    'CFS-02',
    'Confined Space Risk Assessment',
    HseDocumentCategories.riskManagement,
    'Specific assessment of atmospheric, physical and access hazards.',
  ),
  _doc(
    'CFS-03',
    'Gas Test Record',
    HseDocumentCategories.inspection,
    'Pre-entry and required continuous/periodic atmospheric testing.',
  ),
  _doc(
    'CFS-04',
    'Gas Detector Calibration Certificate',
    HseDocumentCategories.equipment,
    'Current calibration/verification evidence.',
    requiresExpiry: true,
  ),
  _doc(
    'CFS-05',
    'Entry / Attendant Register',
    HseDocumentCategories.dailyRecords,
    'Record of entrants and attendant.',
  ),
  _doc(
    'CFS-06',
    'Confined Space Rescue Plan',
    HseDocumentCategories.emergency,
    'Specific rescue and recovery arrangement.',
  ),
  _doc(
    'CFS-07',
    'Rescue Equipment Inspection',
    HseDocumentCategories.equipment,
    'Inspection of rescue equipment.',
  ),
  _doc(
    'CFS-08',
    'Competent Gas Tester Certificate',
    HseDocumentCategories.training,
    'Competency evidence for gas testing personnel.',
    requiresExpiry: true,
  ),
];

/// ============================================================
/// ELECTRICAL WORK
/// ============================================================

final List<HseDocumentRequirement> _electricalDocuments = [
  ..._commonDocuments,
  _doc(
    'ELC-01',
    'Electrical Work Permit',
    HseDocumentCategories.permit,
    'Applicable electrical work permit.',
    requiresSignature: true,
  ),
  _doc(
    'ELC-02',
    'Electrical Isolation / LOTO',
    HseDocumentCategories.permit,
    'Isolation and lockout/tagout record.',
    requiresSignature: true,
  ),
  _doc(
    'ELC-03',
    'Electrical Single Line Diagram',
    HseDocumentCategories.documentControl,
    'Current approved electrical drawing where applicable.',
  ),
  _doc(
    'ELC-04',
    'Electrical Competency Certificate',
    HseDocumentCategories.training,
    'Competency/authorization evidence for electrical personnel.',
    requiresExpiry: true,
  ),
  _doc(
    'ELC-05',
    'Portable Electrical Tool Inspection',
    HseDocumentCategories.equipment,
    'Inspection of portable electrical equipment.',
  ),
  _doc(
    'ELC-06',
    'Electrical Test / Calibration Records',
    HseDocumentCategories.equipment,
    'Applicable test and calibration records.',
    requiresExpiry: true,
  ),
  _doc(
    'ELC-07',
    'Temporary Electrical Installation Inspection',
    HseDocumentCategories.inspection,
    'Inspection of temporary electrical systems where applicable.',
  ),
];

/// ============================================================
/// LOTO
/// ============================================================

final List<HseDocumentRequirement> _lotoDocuments = [
  ..._commonDocuments,
  _doc(
    'LOTO-01',
    'LOTO Procedure',
    HseDocumentCategories.permit,
    'Approved isolation and lockout/tagout procedure.',
  ),
  _doc(
    'LOTO-02',
    'Isolation Register',
    HseDocumentCategories.documentControl,
    'Record of energy isolation points.',
  ),
  _doc(
    'LOTO-03',
    'Lock / Tag Register',
    HseDocumentCategories.equipment,
    'Register of assigned locks and tags.',
  ),
  _doc(
    'LOTO-04',
    'Zero Energy Verification',
    HseDocumentCategories.inspection,
    'Verification that hazardous energy has been isolated.',
    requiresSignature: true,
  ),
  _doc(
    'LOTO-05',
    'LOTO Competency Record',
    HseDocumentCategories.training,
    'Training/competency record for authorized personnel.',
    requiresExpiry: true,
  ),
];

/// ============================================================
/// CRANE / LIFTING
/// ============================================================

final List<HseDocumentRequirement> _liftingDocuments = [
  ..._commonDocuments,
  _doc(
    'LFT-01',
    'Lifting Plan',
    HseDocumentCategories.lifting,
    'Approved lift plan appropriate to the lifting activity.',
  ),
  _doc(
    'LFT-02',
    'Lifting Permit',
    HseDocumentCategories.permit,
    'Applicable lifting permit.',
    requiresSignature: true,
  ),
  _doc(
    'LFT-03',
    'Crane Third-Party Inspection Certificate',
    HseDocumentCategories.equipment,
    'Current third-party inspection/certification where required.',
    requiresExpiry: true,
  ),
  _doc(
    'LFT-04',
    'Crane Operator Competency',
    HseDocumentCategories.training,
    'Current operator competency/authorization.',
    requiresExpiry: true,
  ),
  _doc(
    'LFT-05',
    'Rigger Competency',
    HseDocumentCategories.training,
    'Competency evidence for rigging personnel.',
    requiresExpiry: true,
  ),
  _doc(
    'LFT-06',
    'Banksman / Signaller Competency',
    HseDocumentCategories.training,
    'Competency evidence for signal person/banksman.',
    requiresExpiry: true,
  ),
  _doc(
    'LFT-07',
    'Lifting Gear Register',
    HseDocumentCategories.lifting,
    'Register of lifting accessories.',
  ),
  _doc(
    'LFT-08',
    'Lifting Gear Certificates',
    HseDocumentCategories.equipment,
    'Current inspection/certification of lifting accessories.',
    requiresExpiry: true,
  ),
  _doc(
    'LFT-09',
    'Ground Bearing / Setup Assessment',
    HseDocumentCategories.riskManagement,
    'Verification of crane setup and ground conditions where applicable.',
  ),
  _doc(
    'LFT-10',
    'Lift Exclusion Zone Plan',
    HseDocumentCategories.inspection,
    'Controlled lifting area and exclusion arrangement.',
  ),
  _doc(
    'LFT-11',
    'Pre-Lift Meeting Record',
    HseDocumentCategories.dailyRecords,
    'Briefing and confirmation before critical lifting.',
    requiresSignature: true,
  ),
];

/// ============================================================
/// MOBILE CRANE
/// ============================================================

final List<HseDocumentRequirement> _mobileCraneDocuments = [
  ..._liftingDocuments,
  _doc(
    'MCR-01',
    'Crane Load Chart',
    HseDocumentCategories.equipment,
    'Correct manufacturer load chart available to the operator.',
  ),
  _doc(
    'MCR-02',
    'Outrigger Inspection',
    HseDocumentCategories.inspection,
    'Inspection of outriggers and setup.',
  ),
  _doc(
    'MCR-03',
    'Crane Daily Pre-Use Checklist',
    HseDocumentCategories.equipment,
    'Daily crane inspection.',
  ),
];

/// ============================================================
/// FORKLIFT
/// ============================================================

final List<HseDocumentRequirement> _forkliftDocuments = [
  ..._commonDocuments,
  _doc(
    'FLT-01',
    'Forklift Operator Authorization',
    HseDocumentCategories.training,
    'Current operator competency/authorization.',
    requiresExpiry: true,
  ),
  _doc(
    'FLT-02',
    'Forklift Third-Party Inspection',
    HseDocumentCategories.equipment,
    'Applicable current inspection/certification.',
    requiresExpiry: true,
  ),
  _doc(
    'FLT-03',
    'Forklift Daily Checklist',
    HseDocumentCategories.equipment,
    'Daily pre-use inspection.',
  ),
  _doc(
    'FLT-04',
    'Forklift Traffic Management Plan',
    HseDocumentCategories.riskManagement,
    'Vehicle and pedestrian segregation arrangement.',
  ),
  _doc(
    'FLT-05',
    'Load Capacity Check',
    HseDocumentCategories.inspection,
    'Verification of safe load capacity.',
  ),
  _doc(
    'FLT-06',
    'Battery / Fuel Safety Inspection',
    HseDocumentCategories.equipment,
    'Inspection of battery or fuel system.',
  ),
];

/// ============================================================
/// HEAVY EQUIPMENT
/// ============================================================

final List<HseDocumentRequirement> _heavyEquipmentDocuments = [
  ..._commonDocuments,
  _doc(
    'HEQ-01',
    'Heavy Equipment Register',
    HseDocumentCategories.equipment,
    'Current equipment register.',
  ),
  _doc(
    'HEQ-02',
    'Equipment Fitness Certificate',
    HseDocumentCategories.equipment,
    'Applicable fitness/inspection certificate.',
    requiresExpiry: true,
  ),
  _doc(
    'HEQ-03',
    'Operator Competency',
    HseDocumentCategories.training,
    'Operator competency and authorization.',
    requiresExpiry: true,
  ),
  _doc(
    'HEQ-04',
    'Daily Equipment Checklist',
    HseDocumentCategories.equipment,
    'Daily pre-use inspection.',
  ),
  _doc(
    'HEQ-05',
    'Plant Maintenance Record',
    HseDocumentCategories.equipment,
    'Current maintenance/service record.',
  ),
  _doc(
    'HEQ-06',
    'Plant-Pedestrian Segregation Plan',
    HseDocumentCategories.riskManagement,
    'Controls for interaction between plant and pedestrians.',
  ),
];

/// ============================================================
/// TRAFFIC / ROAD WORK
/// ============================================================

final List<HseDocumentRequirement> _trafficDocuments = [
  ..._commonDocuments,
  _doc(
    'TRF-01',
    'Traffic Management Plan',
    HseDocumentCategories.riskManagement,
    'Approved traffic management arrangement.',
  ),
  _doc(
    'TRF-02',
    'Road Work Permit',
    HseDocumentCategories.permit,
    'Applicable road/traffic work permit.',
    requiresSignature: true,
  ),
  _doc(
    'TRF-03',
    'Traffic Diversion Plan',
    HseDocumentCategories.documentControl,
    'Approved diversion and traffic control arrangement where applicable.',
  ),
  _doc(
    'TRF-04',
    'Banksman / Traffic Marshal Competency',
    HseDocumentCategories.training,
    'Competency records for traffic control personnel.',
    requiresExpiry: true,
  ),
  _doc(
    'TRF-05',
    'Vehicle Inspection',
    HseDocumentCategories.equipment,
    'Current vehicle inspection and fitness records.',
    requiresExpiry: true,
  ),
  _doc(
    'TRF-06',
    'Roadside Emergency Plan',
    HseDocumentCategories.emergency,
    'Emergency arrangements for roadside incidents.',
  ),
];

/// ============================================================
/// WORKING NEAR WATER / MARINE
/// ============================================================

final List<HseDocumentRequirement> _marineDocuments = [
  ..._commonDocuments,
  _doc(
    'MAR-01',
    'Marine / Port Work Plan',
    HseDocumentCategories.projectManagement,
    'Approved marine or port work plan.',
  ),
  _doc(
    'MAR-02',
    'Work Near Water Risk Assessment',
    HseDocumentCategories.riskManagement,
    'Assessment of drowning, vessel, access and environmental hazards.',
  ),
  _doc(
    'MAR-03',
    'Life Jacket Inspection',
    HseDocumentCategories.equipment,
    'Inspection of approved personal flotation equipment.',
  ),
  _doc(
    'MAR-04',
    'Rescue Boat / Rescue Equipment Check',
    HseDocumentCategories.emergency,
    'Applicable water rescue arrangements.',
  ),
  _doc(
    'MAR-05',
    'Marine Emergency Plan',
    HseDocumentCategories.emergency,
    'Emergency response for marine incidents.',
  ),
  _doc(
    'MAR-06',
    'Port / Marine Authority Requirements',
    HseDocumentCategories.legal,
    'Applicable port, marine or terminal requirements.',
  ),
];

/// ============================================================
/// DEMOLITION
/// ============================================================

final List<HseDocumentRequirement> _demolitionDocuments = [
  ..._commonDocuments,
  _doc(
    'DEM-01',
    'Demolition Method Statement',
    HseDocumentCategories.methodStatement,
    'Approved demolition sequence and methodology.',
  ),
  _doc(
    'DEM-02',
    'Structural Assessment',
    HseDocumentCategories.riskManagement,
    'Assessment of structural condition and demolition sequence.',
  ),
  _doc(
    'DEM-03',
    'Services Isolation Record',
    HseDocumentCategories.permit,
    'Verification of isolation of electrical, gas, water and other services.',
    requiresSignature: true,
  ),
  _doc(
    'DEM-04',
    'Dust Control Plan',
    HseDocumentCategories.environmental,
    'Dust suppression and exposure control.',
  ),
  _doc(
    'DEM-05',
    'Demolition Exclusion Zone Plan',
    HseDocumentCategories.inspection,
    'Controlled area and public/workforce protection.',
  ),
  _doc(
    'DEM-06',
    'Emergency / Collapse Response Plan',
    HseDocumentCategories.emergency,
    'Emergency response arrangements.',
  ),
];

/// ============================================================
/// CONCRETE WORK
/// ============================================================

final List<HseDocumentRequirement> _concreteDocuments = [
  ..._commonDocuments,
  _doc(
    'CON-01',
    'Concrete Pour Method Statement',
    HseDocumentCategories.methodStatement,
    'Approved concrete placement methodology.',
  ),
  _doc(
    'CON-02',
    'Pump Inspection',
    HseDocumentCategories.equipment,
    'Inspection of concrete pump where applicable.',
  ),
  _doc(
    'CON-03',
    'Concrete Hose / Coupling Inspection',
    HseDocumentCategories.equipment,
    'Inspection of hoses, couplings and connections.',
  ),
  _doc(
    'CON-04',
    'Concrete Pour Emergency Plan',
    HseDocumentCategories.emergency,
    'Emergency response for hose failure, pump failure or other incidents.',
  ),
];

/// ============================================================
/// FORMWORK
/// ============================================================

final List<HseDocumentRequirement> _formworkDocuments = [
  ..._commonDocuments,
  _doc(
    'FRM-01',
    'Formwork Design / Drawing',
    HseDocumentCategories.documentControl,
    'Approved formwork design and drawings.',
  ),
  _doc(
    'FRM-02',
    'Formwork Inspection',
    HseDocumentCategories.inspection,
    'Pre-pour inspection and approval.',
    requiresSignature: true,
  ),
  _doc(
    'FRM-03',
    'Temporary Works Approval',
    HseDocumentCategories.riskManagement,
    'Temporary works approval where applicable.',
  ),
  _doc(
    'FRM-04',
    'Striking / Dismantling Plan',
    HseDocumentCategories.methodStatement,
    'Approved striking and dismantling sequence.',
  ),
];

/// ============================================================
/// REBAR
/// ============================================================

final List<HseDocumentRequirement> _rebarDocuments = [
  ..._commonDocuments,
  _doc(
    'REB-01',
    'Rebar Installation Method Statement',
    HseDocumentCategories.methodStatement,
    'Approved rebar installation procedure.',
  ),
  _doc(
    'REB-02',
    'Rebar Storage Inspection',
    HseDocumentCategories.inspection,
    'Safe storage and stability inspection.',
  ),
  _doc(
    'REB-03',
    'Cutting / Bending Machine Inspection',
    HseDocumentCategories.equipment,
    'Inspection of rebar processing equipment.',
  ),
  _doc(
    'REB-04',
    'Protruding Rebar Protection Check',
    HseDocumentCategories.inspection,
    'Verification of protection against impalement and impact hazards.',
  ),
];

/// ============================================================
/// DEMOLITION / STRUCTURAL ALTERATION
/// ============================================================

final List<HseDocumentRequirement> _structuralAlterationDocuments = [
  ..._commonDocuments,
  _doc(
    'STA-01',
    'Structural Engineer Approval',
    HseDocumentCategories.legal,
    'Applicable engineer approval for structural alteration.',
  ),
  _doc(
    'STA-02',
    'Temporary Support Design',
    HseDocumentCategories.riskManagement,
    'Approved temporary support arrangement.',
  ),
  _doc(
    'STA-03',
    'Sequence of Work',
    HseDocumentCategories.methodStatement,
    'Approved structural work sequence.',
  ),
];

/// ============================================================
/// MATERIAL STORAGE / WAREHOUSE
/// ============================================================

final List<HseDocumentRequirement> _warehouseDocuments = [
  ..._commonDocuments,
  _doc(
    'WH-01',
    'Warehouse Layout',
    HseDocumentCategories.documentControl,
    'Approved storage and access layout.',
  ),
  _doc(
    'WH-02',
    'Material Storage Inspection',
    HseDocumentCategories.inspection,
    'Inspection of stacking, storage and access.',
  ),
  _doc(
    'WH-03',
    'Racking Inspection',
    HseDocumentCategories.equipment,
    'Inspection of storage racking where applicable.',
  ),
  _doc(
    'WH-04',
    'Forklift Safety Arrangement',
    HseDocumentCategories.riskManagement,
    'Controls for forklift and pedestrian interaction.',
  ),
  _doc(
    'WH-05',
    'Fire Safety Inspection',
    HseDocumentCategories.emergency,
    'Fire protection and emergency access inspection.',
  ),
];

/// ============================================================
/// CHEMICAL WORK
/// ============================================================

final List<HseDocumentRequirement> _chemicalDocuments = [
  ..._commonDocuments,
  _doc(
    'CHE-01',
    'Chemical Register',
    HseDocumentCategories.chemical,
    'Current register of chemicals used or stored.',
  ),
  _doc(
    'CHE-02',
    'Safety Data Sheets (SDS)',
    HseDocumentCategories.chemical,
    'Current SDS available for applicable chemicals.',
  ),
  _doc(
    'CHE-03',
    'Chemical Risk Assessment',
    HseDocumentCategories.riskManagement,
    'Chemical-specific health and safety assessment.',
  ),
  _doc(
    'CHE-04',
    'Chemical Storage Inspection',
    HseDocumentCategories.inspection,
    'Inspection of chemical storage arrangements.',
  ),
  _doc(
    'CHE-05',
    'Chemical Spill Response Plan',
    HseDocumentCategories.emergency,
    'Spill response and containment arrangements.',
  ),
  _doc(
    'CHE-06',
    'Chemical Handling Training',
    HseDocumentCategories.training,
    'Worker training/competency for chemical handling.',
  ),
];

/// ============================================================
/// GAS CYLINDER
/// ============================================================

final List<HseDocumentRequirement> _gasCylinderDocuments = [
  ..._commonDocuments,
  _doc(
    'GAS-01',
    'Gas Cylinder Register',
    HseDocumentCategories.equipment,
    'Register of gas cylinders.',
  ),
  _doc(
    'GAS-02',
    'Cylinder Inspection / Certification',
    HseDocumentCategories.equipment,
    'Current applicable cylinder inspection/certification.',
    requiresExpiry: true,
  ),
  _doc(
    'GAS-03',
    'Gas Storage Inspection',
    HseDocumentCategories.inspection,
    'Inspection of gas cylinder storage.',
  ),
  _doc(
    'GAS-04',
    'Gas Leak Emergency Arrangement',
    HseDocumentCategories.emergency,
    'Emergency response for gas leak or cylinder incident.',
  ),
];

/// ============================================================
/// PRESSURE TESTING
/// ============================================================

final List<HseDocumentRequirement> _pressureTestDocuments = [
  ..._commonDocuments,
  _doc(
    'PRS-01',
    'Pressure Test Procedure',
    HseDocumentCategories.methodStatement,
    'Approved pressure test procedure.',
  ),
  _doc(
    'PRS-02',
    'Pressure Test Permit',
    HseDocumentCategories.permit,
    'Applicable test permit.',
    requiresSignature: true,
  ),
  _doc(
    'PRS-03',
    'Test Gauge Calibration',
    HseDocumentCategories.equipment,
    'Current calibration certificate for pressure gauges.',
    requiresExpiry: true,
  ),
  _doc(
    'PRS-04',
    'Pressure Test Exclusion Zone',
    HseDocumentCategories.inspection,
    'Controlled test area and exclusion arrangement.',
  ),
  _doc(
    'PRS-05',
    'Pressure Test Emergency Plan',
    HseDocumentCategories.emergency,
    'Emergency arrangements for pressure release or equipment failure.',
  ),
];

/// ============================================================
/// PNEUMATIC / HYDRAULIC EQUIPMENT
/// ============================================================

final List<HseDocumentRequirement> _pneumaticHydraulicDocuments = [
  ..._commonDocuments,
  _doc(
    'PNE-01',
    'Equipment Inspection',
    HseDocumentCategories.equipment,
    'Pre-use inspection of pneumatic/hydraulic equipment.',
  ),
  _doc(
    'PNE-02',
    'Hose and Coupling Inspection',
    HseDocumentCategories.equipment,
    'Inspection of hoses, fittings and couplings.',
  ),
  _doc(
    'PNE-03',
    'Pressure Rating Verification',
    HseDocumentCategories.inspection,
    'Verification that components are suitable for operating pressure.',
  ),
  _doc(
    'PNE-04',
    'Stored Energy Risk Assessment',
    HseDocumentCategories.riskManagement,
    'Assessment of stored pressure/energy hazards.',
  ),
];

/// ============================================================
/// ROOF WORK
/// ============================================================

final List<HseDocumentRequirement> _roofDocuments = [
  ..._workAtHeightDocuments,
  _doc(
    'ROOF-01',
    'Roof Access Plan',
    HseDocumentCategories.riskManagement,
    'Approved roof access arrangement.',
  ),
  _doc(
    'ROOF-02',
    'Roof Condition Inspection',
    HseDocumentCategories.inspection,
    'Inspection for fragile areas, openings and structural condition.',
  ),
  _doc(
    'ROOF-03',
    'Fragile Roof Assessment',
    HseDocumentCategories.riskManagement,
    'Assessment where fragile roofing is present.',
  ),
  _doc(
    'ROOF-04',
    'Weather Monitoring Record',
    HseDocumentCategories.inspection,
    'Weather conditions checked before and during work.',
  ),
];

/// ============================================================
/// ENVIRONMENTAL WORK
/// ============================================================

final List<HseDocumentRequirement> _environmentDocuments = [
  _doc(
    'ENV-01',
    'Environmental Management Plan',
    HseDocumentCategories.environmental,
    'Applicable environmental management plan.',
  ),
  _doc(
    'ENV-02',
    'Environmental Aspect / Impact Assessment',
    HseDocumentCategories.environmental,
    'Identification of environmental aspects and impacts.',
  ),
  _doc(
    'ENV-03',
    'Waste Management Plan',
    HseDocumentCategories.environmental,
    'Waste segregation, storage and disposal arrangements.',
  ),
  _doc(
    'ENV-04',
    'Waste Register',
    HseDocumentCategories.environmental,
    'Record of waste generation and disposal.',
  ),
  _doc(
    'ENV-05',
    'Spill Prevention Plan',
    HseDocumentCategories.environmental,
    'Controls to prevent and respond to spills.',
  ),
  _doc(
    'ENV-06',
    'Environmental Inspection',
    HseDocumentCategories.inspection,
    'Environmental site inspection record.',
  ),
];

/// ============================================================
/// HEAT STRESS
/// ============================================================

final List<HseDocumentRequirement> _heatStressDocuments = [
  ..._commonDocuments,
  _doc(
    'HEAT-01',
    'Heat Stress Management Plan',
    HseDocumentCategories.occupationalHealth,
    'Applicable heat-stress prevention and management plan.',
  ),
  _doc(
    'HEAT-02',
    'Heat Stress Awareness Training',
    HseDocumentCategories.training,
    'Worker awareness and training record.',
  ),
  _doc(
    'HEAT-03',
    'Hydration / Drinking Water Check',
    HseDocumentCategories.occupationalHealth,
    'Availability of suitable drinking water and hydration controls.',
  ),
  _doc(
    'HEAT-04',
    'Heat Monitoring Record',
    HseDocumentCategories.occupationalHealth,
    'Applicable environmental/heat monitoring record.',
  ),
  _doc(
    'HEAT-05',
    'Heat Illness Response Arrangement',
    HseDocumentCategories.emergency,
    'Response arrangements for suspected heat illness.',
  ),
];

/// ============================================================
/// FIRST AID / MEDICAL
/// ============================================================

final List<HseDocumentRequirement> _firstAidDocuments = [
  _doc(
    'FA-01',
    'First Aid Risk Assessment',
    HseDocumentCategories.occupationalHealth,
    'Assessment of site first-aid needs.',
  ),
  _doc(
    'FA-02',
    'First Aider Register',
    HseDocumentCategories.training,
    'Current list of designated first aiders.',
    requiresExpiry: true,
  ),
  _doc(
    'FA-03',
    'First Aid Box Inspection',
    HseDocumentCategories.inspection,
    'Inspection and replenishment record.',
  ),
  _doc(
    'FA-04',
    'First Aid Treatment Register',
    HseDocumentCategories.occupationalHealth,
    'Record of first-aid treatment in accordance with site procedure.',
  ),
  _doc(
    'FA-05',
    'Emergency Medical Contact List',
    HseDocumentCategories.emergency,
    'Current emergency medical contacts.',
  ),
];

/// ============================================================
/// FIRE SAFETY
/// ============================================================

final List<HseDocumentRequirement> _fireDocuments = [
  ..._commonDocuments,
  _doc(
    'FIR-01',
    'Fire Risk Assessment',
    HseDocumentCategories.riskManagement,
    'Applicable fire risk assessment.',
  ),
  _doc(
    'FIR-02',
    'Fire Emergency Plan',
    HseDocumentCategories.emergency,
    'Fire emergency response plan.',
  ),
  _doc(
    'FIR-03',
    'Fire Extinguisher Register',
    HseDocumentCategories.equipment,
    'Register and inspection status of extinguishers.',
  ),
  _doc(
    'FIR-04',
    'Fire Warden Register',
    HseDocumentCategories.training,
    'Current fire warden/designated person records.',
    requiresExpiry: true,
  ),
  _doc(
    'FIR-05',
    'Fire Drill Record',
    HseDocumentCategories.emergency,
    'Record of fire/emergency drills where required.',
  ),
];

/// ============================================================
/// EMERGENCY EVACUATION
/// ============================================================

final List<HseDocumentRequirement> _evacuationDocuments = [
  _doc(
    'EVA-01',
    'Emergency Response Plan',
    HseDocumentCategories.emergency,
    'Approved emergency response plan.',
  ),
  _doc(
    'EVA-02',
    'Evacuation Plan',
    HseDocumentCategories.emergency,
    'Evacuation routes and procedures.',
  ),
  _doc(
    'EVA-03',
    'Muster Point Register',
    HseDocumentCategories.emergency,
    'Designated assembly/muster point information.',
  ),
  _doc(
    'EVA-04',
    'Emergency Contact Board',
    HseDocumentCategories.emergency,
    'Current emergency contact information.',
  ),
  _doc(
    'EVA-05',
    'Emergency Drill Report',
    HseDocumentCategories.emergency,
    'Record of drill performance and actions.',
  ),
];

/// ============================================================
/// DAILY HSE MANAGEMENT
/// ============================================================

final List<HseDocumentRequirement> _dailyHseDocuments = [
  _doc(
    'DAY-01',
    'Daily HSE Report',
    HseDocumentCategories.dailyRecords,
    'Daily HSE activities, manpower, inspections and observations.',
  ),
  _doc(
    'DAY-02',
    'Daily Toolbox Talk',
    HseDocumentCategories.dailyRecords,
    'Daily toolbox talk topic and attendance.',
    requiresSignature: true,
  ),
  _doc(
    'DAY-03',
    'Daily Site Inspection',
    HseDocumentCategories.inspection,
    'Daily site safety inspection.',
  ),
  _doc(
    'DAY-04',
    'Safety Observation Register',
    HseDocumentCategories.dailyRecords,
    'Positive and negative safety observations.',
  ),
  _doc(
    'DAY-05',
    'Corrective Action Register',
    HseDocumentCategories.inspection,
    'Open corrective actions and closure status.',
  ),
];

/// ============================================================
/// INCIDENT MANAGEMENT
/// ============================================================

final List<HseDocumentRequirement> _incidentDocuments = [
  _doc(
    'INC-01',
    'Initial Incident Report',
    HseDocumentCategories.incident,
    'Initial notification/report of incident.',
  ),
  _doc(
    'INC-02',
    'Incident Investigation',
    HseDocumentCategories.incident,
    'Formal investigation where required.',
  ),
  _doc(
    'INC-03',
    'Root Cause Analysis',
    HseDocumentCategories.incident,
    'Root-cause analysis appropriate to the incident.',
  ),
  _doc(
    'INC-04',
    'Corrective / Preventive Action',
    HseDocumentCategories.incident,
    'Actions arising from investigation findings.',
  ),
  _doc(
    'INC-05',
    'Lessons Learned',
    HseDocumentCategories.incident,
    'Lessons learned and communication record.',
  ),
];

/// ============================================================
/// TRAINING / INDUCTION
/// ============================================================

final List<HseDocumentRequirement> _trainingDocuments = [
  _doc(
    'TRN-01',
    'HSE Induction Register',
    HseDocumentCategories.training,
    'Site induction record for workers.',
    requiresSignature: true,
  ),
  _doc(
    'TRN-02',
    'Visitor Induction Register',
    HseDocumentCategories.training,
    'Visitor safety induction where applicable.',
  ),
  _doc(
    'TRN-03',
    'Training Matrix',
    HseDocumentCategories.training,
    'Current project training matrix.',
  ),
  _doc(
    'TRN-04',
    'Competency Matrix',
    HseDocumentCategories.training,
    'Competency requirements and status.',
  ),
  _doc(
    'TRN-05',
    'Toolbox Talk Attendance',
    HseDocumentCategories.dailyRecords,
    'Attendance/acknowledgement records.',
    requiresSignature: true,
  ),
];

/// ============================================================
/// DOCUMENT CONTROL
/// ============================================================

final List<HseDocumentRequirement> _documentControlDocuments = [
  _doc(
    'DOC-01',
    'Master Document Register',
    HseDocumentCategories.documentControl,
    'Register of controlled HSE documents.',
  ),
  _doc(
    'DOC-02',
    'Revision Register',
    HseDocumentCategories.documentControl,
    'Document revision and approval history.',
  ),
  _doc(
    'DOC-03',
    'Legal Register',
    HseDocumentCategories.legal,
    'Applicable legal and regulatory requirements register.',
  ),
  _doc(
    'DOC-04',
    'Authority Approval Register',
    HseDocumentCategories.legal,
    'Applicable authority approvals and correspondence.',
  ),
  _doc(
    'DOC-05',
    'Expiry Tracking Register',
    HseDocumentCategories.documentControl,
    'Tracking of certificates, permits and other expiry-controlled records.',
  ),
];

/// ============================================================
/// ALL HSE WORK ACTIVITIES
/// ============================================================

final List<HseWorkActivity> hseWorkActivities = [
  // ----------------------------------------------------------
  // GENERAL
  // ----------------------------------------------------------

  HseWorkActivity(
    id: 'general-work',
    title: 'General Work Activity',
    category: 'General HSE',
    description:
        'General work activity requiring standard HSE planning and controls.',
    requiredDocuments: _commonDocuments,
  ),

  HseWorkActivity(
    id: 'daily-hse',
    title: 'Daily HSE Management',
    category: 'General HSE',
    description:
        'Daily HSE reporting, briefing, inspection and corrective-action activities.',
    requiredDocuments: _dailyHseDocuments,
  ),

  HseWorkActivity(
    id: 'training-induction',
    title: 'HSE Training & Induction',
    category: 'Training & Competency',
    description:
        'Worker induction, training and competency management.',
    requiredDocuments: _trainingDocuments,
  ),

  HseWorkActivity(
    id: 'document-control',
    title: 'HSE Document Control',
    category: 'Document Control',
    description:
        'Control and management of HSE documents, revisions and expiry records.',
    requiredDocuments: _documentControlDocuments,
  ),

  // ----------------------------------------------------------
  // EXCAVATION
  // ----------------------------------------------------------

  HseWorkActivity(
    id: 'excavation',
    title: 'Excavation Safety',
    category: 'Excavation & Ground Works',
    description:
        'Planning and control of excavation and ground-breaking activities.',
    requiredDocuments: _excavationDocuments,
  ),

  HseWorkActivity(
    id: 'trenching',
    title: 'Trenching Safety',
    category: 'Excavation & Ground Works',
    description:
        'Safe planning and execution of trenching activities.',
    requiredDocuments: _trenchingDocuments,
  ),

  HseWorkActivity(
    id: 'underground-services',
    title: 'Underground Services',
    category: 'Excavation & Ground Works',
    description:
        'Identification and protection of underground utilities and services.',
    requiredDocuments: _undergroundServiceDocuments,
  ),

  // ----------------------------------------------------------
  // HEIGHT
  // ----------------------------------------------------------

  HseWorkActivity(
    id: 'work-at-height',
    title: 'Work at Height',
    category: 'Work at Height',
    description:
        'Work where a person may be exposed to a fall from height.',
    requiredDocuments: _workAtHeightDocuments,
  ),

  HseWorkActivity(
    id: 'scaffolding',
    title: 'Scaffolding',
    category: 'Work at Height',
    description:
        'Scaffold erection, use, inspection, modification and dismantling.',
    requiredDocuments: _scaffoldDocuments,
  ),

  HseWorkActivity(
    id: 'ladder-work',
    title: 'Ladder Work',
    category: 'Work at Height',
    description:
        'Selection, inspection and safe use of ladders.',
    requiredDocuments: _ladderDocuments,
  ),

  HseWorkActivity(
    id: 'roof-work',
    title: 'Roof Work',
    category: 'Work at Height',
    description:
        'Roof access and work including fall and fragile-surface controls.',
    requiredDocuments: _roofDocuments,
  ),

  // ----------------------------------------------------------
  // HOT WORK
  // ----------------------------------------------------------

  HseWorkActivity(
    id: 'hot-work',
    title: 'Hot Work',
    category: 'Hot Work',
    description:
        'Welding, cutting, grinding and other spark/heat-producing activities.',
    requiredDocuments: _hotWorkDocuments,
  ),

  HseWorkActivity(
    id: 'welding',
    title: 'Welding',
    category: 'Hot Work',
    description:
        'Arc welding and related welding activities.',
    requiredDocuments: _weldingDocuments,
  ),

  HseWorkActivity(
    id: 'grinding-cutting',
    title: 'Grinding & Cutting',
    category: 'Hot Work',
    description:
        'Grinding, cutting and abrasive-wheel activities.',
    requiredDocuments: _grindingCuttingDocuments,
  ),

  // ----------------------------------------------------------
  // CONFINED SPACE
  // ----------------------------------------------------------

  HseWorkActivity(
    id: 'confined-space',
    title: 'Confined Space Entry',
    category: 'Confined Space',
    description:
        'Entry into confined or potentially hazardous enclosed spaces.',
    requiredDocuments: _confinedSpaceDocuments,
  ),

  // ----------------------------------------------------------
  // ELECTRICAL
  // ----------------------------------------------------------

  HseWorkActivity(
    id: 'electrical-work',
    title: 'Electrical Work',
    category: 'Electrical Safety',
    description:
        'Electrical installation, maintenance, testing and related work.',
    requiredDocuments: _electricalDocuments,
  ),

  HseWorkActivity(
    id: 'loto',
    title: 'Lockout Tagout (LOTO)',
    category: 'Electrical & Energy Isolation',
    description:
        'Isolation and control of hazardous energy sources.',
    requiredDocuments: _lotoDocuments,
  ),

  // ----------------------------------------------------------
  // LIFTING
  // ----------------------------------------------------------

  HseWorkActivity(
    id: 'lifting-operations',
    title: 'Lifting Operations',
    category: 'Lifting & Rigging',
    description:
        'Planned lifting operations using cranes and lifting equipment.',
    requiredDocuments: _liftingDocuments,
  ),

  HseWorkActivity(
    id: 'mobile-crane',
    title: 'Mobile Crane Operations',
    category: 'Lifting & Rigging',
    description:
        'Mobile crane setup and lifting activities.',
    requiredDocuments: _mobileCraneDocuments,
  ),

  HseWorkActivity(
    id: 'rigging',
    title: 'Rigging Operations',
    category: 'Lifting & Rigging',
    description:
        'Rigging and handling of suspended loads.',
    requiredDocuments: _liftingDocuments,
  ),

  // ----------------------------------------------------------
  // PLANT
  // ----------------------------------------------------------

  HseWorkActivity(
    id: 'forklift',
    title: 'Forklift Operations',
    category: 'Plant & Equipment',
    description:
        'Forklift operation and material handling.',
    requiredDocuments: _forkliftDocuments,
  ),

  HseWorkActivity(
    id: 'heavy-equipment',
    title: 'Heavy Equipment Operations',
    category: 'Plant & Equipment',
    description:
        'Operation of excavators, loaders and other heavy mobile plant.',
    requiredDocuments: _heavyEquipmentDocuments,
  ),

  // ----------------------------------------------------------
  // TRAFFIC
  // ----------------------------------------------------------

  HseWorkActivity(
    id: 'traffic-management',
    title: 'Traffic Management',
    category: 'Traffic & Road Safety',
    description:
        'Control of vehicle, plant and pedestrian movement.',
    requiredDocuments: _trafficDocuments,
  ),

  HseWorkActivity(
    id: 'road-work',
    title: 'Road Work',
    category: 'Traffic & Road Safety',
    description:
        'Construction or maintenance activities affecting roads and traffic.',
    requiredDocuments: _trafficDocuments,
  ),

  // ----------------------------------------------------------
  // MARINE
  // ----------------------------------------------------------

  HseWorkActivity(
    id: 'marine-port',
    title: 'Marine & Port Work',
    category: 'Marine Safety',
    description:
        'Marine, port, terminal and work-near-water activities.',
    requiredDocuments: _marineDocuments,
  ),

  HseWorkActivity(
    id: 'working-near-water',
    title: 'Working Near Water',
    category: 'Marine Safety',
    description:
        'Work activities where personnel may be exposed to water-related hazards.',
    requiredDocuments: _marineDocuments,
  ),

  // ----------------------------------------------------------
  // CONSTRUCTION
  // ----------------------------------------------------------

  HseWorkActivity(
    id: 'construction',
    title: 'Construction Work',
    category: 'Construction',
    description:
        'General construction activities and site work.',
    requiredDocuments: _commonDocuments,
  ),

  HseWorkActivity(
    id: 'concrete',
    title: 'Concrete Work',
    category: 'Construction',
    description:
        'Concrete placement, pumping and associated activities.',
    requiredDocuments: _concreteDocuments,
  ),

  HseWorkActivity(
    id: 'formwork',
    title: 'Formwork',
    category: 'Construction',
    description:
        'Formwork installation, inspection, use and dismantling.',
    requiredDocuments: _formworkDocuments,
  ),

  HseWorkActivity(
    id: 'rebar',
    title: 'Rebar Work',
    category: 'Construction',
    description:
        'Reinforcement steel cutting, bending and installation.',
    requiredDocuments: _rebarDocuments,
  ),

  HseWorkActivity(
    id: 'demolition',
    title: 'Demolition',
    category: 'Construction',
    description:
        'Controlled demolition and structural removal activities.',
    requiredDocuments: _demolitionDocuments,
  ),

  HseWorkActivity(
    id: 'structural-alteration',
    title: 'Structural Alteration',
    category: 'Construction',
    description:
        'Structural modification or alteration work.',
    requiredDocuments: _structuralAlterationDocuments,
  ),

  // ----------------------------------------------------------
  // WAREHOUSE
  // ----------------------------------------------------------

  HseWorkActivity(
    id: 'warehouse',
    title: 'Warehouse Operations',
    category: 'Material & Warehouse',
    description:
        'Warehouse storage, handling and movement activities.',
    requiredDocuments: _warehouseDocuments,
  ),

  HseWorkActivity(
    id: 'material-storage',
    title: 'Material Storage',
    category: 'Material & Warehouse',
    description:
        'Safe storage, stacking and handling of materials.',
    requiredDocuments: _warehouseDocuments,
  ),

  // ----------------------------------------------------------
  // CHEMICAL
  // ----------------------------------------------------------

  HseWorkActivity(
    id: 'chemical-work',
    title: 'Chemical Handling',
    category: 'Chemical Safety',
    description:
        'Use, handling and storage of chemicals and hazardous substances.',
    requiredDocuments: _chemicalDocuments,
  ),

  HseWorkActivity(
    id: 'gas-cylinder',
    title: 'Gas Cylinder Handling',
    category: 'Chemical & Gas Safety',
    description:
        'Storage, transportation and use of gas cylinders.',
    requiredDocuments: _gasCylinderDocuments,
  ),

  // ----------------------------------------------------------
  // PRESSURE / EQUIPMENT
  // ----------------------------------------------------------

  HseWorkActivity(
    id: 'pressure-testing',
    title: 'Pressure Testing',
    category: 'Specialist Work',
    description:
        'Hydrostatic, pneumatic or other pressure testing activities.',
    requiredDocuments: _pressureTestDocuments,
  ),

  HseWorkActivity(
    id: 'pneumatic-hydraulic',
    title: 'Pneumatic & Hydraulic Equipment',
    category: 'Specialist Work',
    description:
        'Work involving pneumatic or hydraulic systems and equipment.',
    requiredDocuments: _pneumaticHydraulicDocuments,
  ),

  // ----------------------------------------------------------
  // FIRE
  // ----------------------------------------------------------

  HseWorkActivity(
    id: 'fire-safety',
    title: 'Fire Safety',
    category: 'Fire & Emergency',
    description:
        'Fire prevention, protection, inspection and emergency preparedness.',
    requiredDocuments: _fireDocuments,
  ),

  HseWorkActivity(
    id: 'emergency-evacuation',
    title: 'Emergency Evacuation',
    category: 'Fire & Emergency',
    description:
        'Emergency evacuation planning, drills and muster arrangements.',
    requiredDocuments: _evacuationDocuments,
  ),

  // ----------------------------------------------------------
  // HEALTH
  // ----------------------------------------------------------

  HseWorkActivity(
    id: 'heat-stress',
    title: 'Heat Stress Management',
    category: 'Occupational Health',
    description:
        'Prevention and management of heat-related illness.',
    requiredDocuments: _heatStressDocuments,
  ),

  HseWorkActivity(
    id: 'first-aid',
    title: 'First Aid Management',
    category: 'Occupational Health',
    description:
        'First aid facilities, personnel and treatment records.',
    requiredDocuments: _firstAidDocuments,
  ),

  // ----------------------------------------------------------
  // ENVIRONMENT
  // ----------------------------------------------------------

  HseWorkActivity(
    id: 'environmental',
    title: 'Environmental Management',
    category: 'Environment',
    description:
        'Environmental controls, waste, spill and inspection activities.',
    requiredDocuments: _environmentDocuments,
  ),

  HseWorkActivity(
    id: 'waste-management',
    title: 'Waste Management',
    category: 'Environment',
    description:
        'Segregation, storage, transportation and disposal of waste.',
    requiredDocuments: _environmentDocuments,
  ),

  // ----------------------------------------------------------
  // INCIDENT
  // ----------------------------------------------------------

  HseWorkActivity(
    id: 'incident-management',
    title: 'Incident Management',
    category: 'Incident Management',
    description:
        'Incident reporting, investigation, root cause and corrective action.',
    requiredDocuments: _incidentDocuments,
  ),
];

/// ============================================================
/// CATEGORY LIST
/// ============================================================

final List<String> hseWorkCategories = [
  'General HSE',
  'Construction',
  'Excavation & Ground Works',
  'Work at Height',
  'Hot Work',
  'Confined Space',
  'Electrical Safety',
  'Electrical & Energy Isolation',
  'Lifting & Rigging',
  'Plant & Equipment',
  'Traffic & Road Safety',
  'Marine Safety',
  'Material & Warehouse',
  'Chemical Safety',
  'Chemical & Gas Safety',
  'Specialist Work',
  'Fire & Emergency',
  'Occupational Health',
  'Environment',
  'Training & Competency',
  'Document Control',
  'Incident Management',
];

/// ============================================================
/// QUICK LOOKUP
/// ============================================================

HseWorkActivity? getHseWorkActivityById(
  String id,
) {
  for (final activity in hseWorkActivities) {
    if (activity.id == id) {
      return activity;
    }
  }

  return null;
}

/// ============================================================
/// CATEGORY FILTER
/// ============================================================

List<HseWorkActivity> getHseWorkActivitiesByCategory(
  String category,
) {
  return hseWorkActivities
      .where(
        (activity) =>
            activity.category == category,
      )
      .toList();
}

/// ============================================================
/// SEARCH
/// ============================================================

List<HseWorkActivity> searchHseWorkActivities(
  String query,
) {
  final q = query.trim().toLowerCase();

  if (q.isEmpty) {
    return List<HseWorkActivity>.from(
      hseWorkActivities,
    );
  }

  return hseWorkActivities.where(
    (activity) {
      return activity.title
              .toLowerCase()
              .contains(q) ||
          activity.category
              .toLowerCase()
              .contains(q) ||
          activity.description
              .toLowerCase()
              .contains(q);
    },
  ).toList();
}

/// ============================================================
/// DOCUMENT COUNT
/// ============================================================

int getTotalHseDocumentRequirements() {
  final ids = <String>{};

  for (final activity in hseWorkActivities) {
    for (final document
        in activity.requiredDocuments) {
      ids.add(document.id);
    }
  }

  return ids.length;
}

/// ============================================================
/// ALL UNIQUE DOCUMENT REQUIREMENTS
/// ============================================================

List<HseDocumentRequirement>
    getAllHseDocumentRequirements() {
  final map =
      <String, HseDocumentRequirement>{};

  for (final activity in hseWorkActivities) {
    for (final document
        in activity.requiredDocuments) {
      map[document.id] = document;
    }
  }

  return map.values.toList();
}

/// ============================================================
/// MANDATORY DOCUMENTS
/// ============================================================

List<HseDocumentRequirement>
    getMandatoryDocumentsForActivity(
  String activityId,
) {
  final activity =
      getHseWorkActivityById(activityId);

  if (activity == null) {
    return [];
  }

  return activity.requiredDocuments
      .where(
        (document) =>
            document.mandatory,
      )
      .toList();
}

/// ============================================================
/// EXPIRY CONTROLLED DOCUMENTS
/// ============================================================

List<HseDocumentRequirement>
    getExpiryControlledDocumentsForActivity(
  String activityId,
) {
  final activity =
      getHseWorkActivityById(activityId);

  if (activity == null) {
    return [];
  }

  return activity.requiredDocuments
      .where(
        (document) =>
            document.requiresExpiry,
      )
      .toList();
}
