/// SafeNexus HSE — Abu Dhabi HSE Reference
/// Step 5AJ Part 2 — Project-Dependent Plant, Duplicate Content, Critical Gaps & CoP 36.0 Coverage
/// Audit / reference module — book-level structured content.
/// Regulatory basis: ADPHC/ADOSH-SF current Code of Practices registry; CoP 36.0 Plant and Equipment V4.1 (effective 27 February 2026) plus applicable related CoPs.
///
/// IMPORTANT: This module is a structured field reference. It does not
/// replace the current official ADPHC/ADOSH-SF Code of Practice,
/// manufacturer instructions, project HSE plan, RAMS/JSA, permits,
/// competent-person requirements or other applicable authority rules.
/// Numeric/legal requirements must be verified against the current
/// applicable official source before a compliance decision is made.

class PlantAuditGoldPoint {
  final String title;
  final List<String> points;
  const PlantAuditGoldPoint({required this.title, required this.points});
}

class PlantAuditGoldSection {
  final String number;
  final String title;
  final List<PlantAuditGoldPoint> points;
  const PlantAuditGoldSection({required this.number, required this.title, required this.points});
}

const List<PlantAuditGoldSection> abuDhabiPlantAuditGoldSections = [
  PlantAuditGoldSection(
    number: '01',
    title: 'Purpose and audit method',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Use this module as the final gap-control layer for the Abu Dhabi Plant & Equipment section.',
          'Audit the actual SafeNexus modules against the project plant population and the current ADPHC regulatory structure.',
          'Classify findings as COMPLETE, CROSS-REFERENCE, MISSING, DUPLICATE, PROJECT-DEPENDENT or VERIFY.',
          'Do not mark a topic complete merely because its name appears in a registry; confirm meaningful safety content exists.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Use the audit to prevent both knowledge gaps and unnecessary duplicate Dart files.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '02',
    title: 'Coverage baseline — existing equipment books',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Check the completed 5S–5Z mobile/material-handling and earthmoving modules.',
          'Check the completed 5AB–5AE haulage/compaction modules.',
          'Check the completed 5AF–5AI paver/trencher/compressor/generator modules.',
          'Check Crane & Lifting, MEWP, Forklift/Powered Lift Trucks and Telehandler modules.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Check Portable Power Tools and Concrete Placing Equipment interfaces.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '03',
    title: 'Coverage baseline — specialist interfaces',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Machine Guarding must connect to plant hazards without duplicating the full machine-guarding specialist topic.',
          'Compressed Gases and Air must connect to compressors, pneumatic tools, cylinders and hot-work activities.',
          'Electrical Safety must connect to generators, temporary power and electrically powered plant.',
          'Traffic Management must connect to mobile plant routes, pedestrian segregation and reversing controls.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Overhead/Underground Services must connect to excavation, lifting, MEWP and earthmoving plant.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '04',
    title: 'Duplicate-content audit',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Compare titles, section subjects, hazard lists, control lists and regulatory references before creating a new file.',
          'Prefer one authoritative content module and cross-reference it from related equipment modules.',
          'Do not copy the same numerical limit into multiple files unless the source and applicability are identical and intentionally maintained.',
          'Do not create separate UI pages solely because two equipment types share the same controls.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Where duplicate content already exists, retain the more complete verified source and convert the other location to a cross-reference where practical.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '05',
    title: 'Critical-equipment gap test',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'A critical equipment item is missing when the project can reasonably use it and no adequate SafeNexus topic or cross-reference provides the required controls.',
          'Check lifting, excavation, traffic, concrete, electrical, pressure, mobile plant, access and specialist-process equipment categories.',
          'Check project procurement and method statements because specialist plant cannot be inferred from a generic registry alone.',
          'Record the equipment, reason for use, hazard profile, applicable CoPs, existing coverage and recommended action.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Do not label an item missing when it is adequately covered by an existing generic module with a clear cross-reference.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '06',
    title: 'Project-dependent plant',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Project-dependent plant varies with scope, method, geology, utilities, production process and client requirements.',
          'Typical examples may include piling rigs, drilling rigs, vacuum excavation systems, road milling machines, specialist pumps, dewatering systems and process-specific plant.',
          'Such equipment should enter the project plant register before mobilisation.',
          'Create a dedicated Gold module only when the equipment is sufficiently common or the project requires detailed standalone treatment.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'For rare specialist equipment, use a structured project-specific module or verified manufacturer/project procedure while retaining the master audit reference.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '07',
    title: 'Piling equipment gap test',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Confirm whether piling or foundation works are in project scope.',
          'Where applicable, assess mast stability, drilling/hammer hazards, suspended components, exclusion zones, underground services, noise/vibration and emergency shutdown.',
          'Verify competent operators, assembly procedures, lifting interfaces and ground-bearing requirements.',
          'Do not claim a universal numerical limit without the current manufacturer and applicable authority source.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Classify as PROJECT-DEPENDENT when the project does not use piling equipment.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '08',
    title: 'Drilling rig gap test',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Check rotary, crawler, truck-mounted and other drilling systems against the actual project method.',
          'Assess rotating parts, entanglement, rods, stored energy, dust, noise, vibration, fluids, ground stability and service interfaces.',
          'Include rod handling, coupling/uncoupling, maintenance isolation and emergency shutdown.',
          'Verify ground and setup requirements from manufacturer and project engineering controls.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Mark project-dependent where no drilling activity exists.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '09',
    title: 'Vacuum excavator gap test',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Assess vacuum, excavation, spoil containment, hose movement, pressure/vacuum energy, underground services and traffic interfaces.',
          'Integrate service-location and permit-to-dig controls.',
          'Control discharge and contaminated spoil according to environmental requirements.',
          'Verify operator competence and equipment condition before work.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Treat the system as project-dependent unless the project scope requires it.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '10',
    title: 'Road and asphalt specialist plant gap test',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Check pavers, milling machines, specialist rollers, heaters and related asphalt plant against the project method.',
          'Assess hot surfaces, bitumen/asphalt exposure, moving parts, reversing, traffic, visibility, fire and occupational health.',
          'Coordinate with road-work and traffic-management modules.',
          'Control pedestrian access to active paving and milling zones.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Verify emergency shutdown and burn/heat exposure arrangements.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '11',
    title: 'Water, fuel and service vehicles',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Check water tankers, fuel bowsers and service vehicles where they form part of the project fleet.',
          'Assess vehicle stability, pressure, hose connections, refuelling, spill prevention and traffic interaction.',
          'Fuel equipment requires fire, ignition-source and environmental controls.',
          'Water equipment may create pressure, slip, electrical and contamination hazards depending on use.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Classify according to actual project fleet and applicable specialist requirements.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '12',
    title: 'CoP 36.0 coverage — regulatory anchor',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'ADPHC currently lists CoP 36.0 Plant and Equipment as Version 4.1 with an effective date of 27 February 2026.',
          'Use the current official ADPHC registry and current CoP document as the regulatory anchor rather than an old downloaded copy.',
          'Check that the SafeNexus plant content covers equipment selection, suitability, inspection, maintenance, operation, competence, isolation and emergency interfaces.',
          'Map related CoPs separately where a plant activity falls under a specialist code.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Do not treat CoP 36.0 as the only requirement for a machine when another CoP directly governs the hazard or activity.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '13',
    title: 'CoP 36.0 mapping matrix',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Plant/equipment → CoP 36.0.',
          'Machine guarding → CoP 47.0.',
          'Portable power tools → CoP 35.0.',
          'Powered lift trucks → CoP 51.0.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Lifting equipment/accessories → CoP 34.0.',
          'Concrete placing equipment → CoP 38.0.',
          'Compressed gases and air → CoP 49.0.',
          'Electrical safety → CoP 15.0.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 3',
        points: [
          'Overhead/underground services → CoP 39.0.',
          'Traffic management/logistics → CoP 44.0 and applicable road-work requirements.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '14',
    title: 'Regulatory version verification',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Record the CoP number, title, version, effective date and official source location in the reference data.',
          'Re-check regulatory versions when the project starts, when a major regulatory update is announced and during scheduled content review.',
          'Do not silently retain a superseded version as the current requirement.',
          'Where an official page and an old PDF conflict, verify the current official publication before locking content.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Keep the app\'s regulatory-reference metadata separate from field guidance so updates can be made without rewriting every equipment chapter.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '15',
    title: 'Missing-equipment decision tree',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Step 1: Is the equipment actually used or reasonably foreseeable on the project?',
          'Step 2: Is there an existing detailed equipment module?',
          'Step 3: If not, is there an adequate generic plant module plus clear specialist cross-reference?',
          'Step 4: Does the equipment introduce hazards not adequately covered elsewhere?',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Step 5: Is there a governing CoP or specialist standard requiring dedicated treatment?',
          'Step 6: If yes, create a Gold module; if no, classify as project-dependent or cross-reference.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '16',
    title: 'Criticality classification',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Critical: failure or misuse can cause fatality, multiple serious injuries, major uncontrolled energy release or major infrastructure damage.',
          'High: significant injury, equipment damage or major operational consequence is credible without controls.',
          'Medium: risk is controllable through routine controls but still requires documented management.',
          'Project-dependent: significance depends on whether the equipment or activity exists on the project.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Use criticality to prioritize content verification, not to create a political or commercial ranking.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '17',
    title: 'Evidence required for closure',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Actual equipment register or confirmed project scope.',
          'Manufacturer manual or approved equipment documentation.',
          'Applicable ADPHC CoP and current version.',
          'Inspection and maintenance arrangements.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Competency/authorization evidence.',
          'RAMS/JSA/PTW where applicable.',
          'Emergency response and recovery arrangements.',
          'Field verification evidence for critical controls.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '18',
    title: 'Plant register quality check',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Every plant item should have unique identification or traceability appropriate to the project.',
          'Record equipment type, manufacturer/model where applicable, owner/contractor, status and location.',
          'Link inspection, maintenance and defect records to the equipment identity.',
          'Identify attachments and configurations that materially change the hazard profile.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Remove retired or off-hired equipment from active registers to avoid false coverage.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '19',
    title: 'Inspection and maintenance gap test',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Check pre-use, periodic and statutory inspection requirements applicable to each equipment class.',
          'Verify that critical safety devices are included in inspection criteria.',
          'Check defect reporting, quarantine and release-to-service arrangements.',
          'Review maintenance history for recurring defects.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Confirm that modifications and repairs are controlled and documented.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '20',
    title: 'Competence and authorization gap test',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Map each equipment class to the required operator/maintainer competence.',
          'Check familiarisation for specific models and attachments where necessary.',
          'Separate operator competence from maintenance/electrical/pressure-system competence.',
          'Do not use a generic training certificate as evidence for every specialist machine without checking applicability.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Maintain records and verify authorization at site level.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '21',
    title: 'Emergency and recovery gap test',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Every critical machine should have a practical shutdown/isolation method understood by the work team.',
          'Plan foreseeable breakdown, rollover, entrapment, fire, service strike, pressure release and environmental-release scenarios as applicable.',
          'Recovery must use suitable rated equipment and competent personnel.',
          'Do not enter a machine danger zone until hazardous energy is controlled.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Review emergency arrangements after drills, incidents and significant changes.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '22',
    title: 'Interface duplication control',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Keep detailed hazard controls in the specialist source topic.',
          'Equipment-specific files should explain the interface and point to the specialist source rather than reproducing the entire topic.',
          'Keep common controls consistent through shared data or carefully maintained references.',
          'Where a control is equipment-specific, retain it in the equipment chapter.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Audit duplicate sections after major content updates.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '23',
    title: 'Numerical and legal accuracy control',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Never invent a clearance, pressure, load, inspection interval, slope, exposure limit or legal deadline.',
          'Every important number must have a verified source and applicability statement.',
          'Where requirements vary by equipment, manufacturer, jurisdiction or project, state the dependency explicitly.',
          'If the current source cannot be verified, use a verification note instead of a guessed value.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Update the source metadata whenever the governing document changes.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '24',
    title: 'Current known official registry anchors',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'ADPHC\'s current Code of Practices registry lists CoP 36.0 Plant and Equipment V4.1 effective 27 February 2026.',
          'The same registry lists CoP 47.0 Machine Guarding V4.1 effective 27 February 2026.',
          'It lists CoP 49.0 Compressed Gases and Air V4.1 effective 27 February 2026.',
          'It lists CoP 51.0 Powered Lift Trucks V4.1 effective 27 February 2026.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'It lists CoP 15.0 Electrical Safety V4.0 effective 15 July 2024; re-verify before compliance decisions.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '25',
    title: 'Final closure matrix',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'COMPLETE = detailed, verified module exists and the interface is clear.',
          'CROSS-REFERENCE = control is adequately covered elsewhere and linked.',
          'PROJECT-DEPENDENT = only required when the actual project scope uses the equipment/activity.',
          'MISSING = no adequate content path exists; create a Gold module after source verification.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'DUPLICATE = content exists in more than one authoritative location; consolidate or cross-reference.',
          'VERIFY = evidence or current regulatory source is insufficient; do not lock as complete.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '26',
    title: 'Release checklist',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'All current equipment books are indexed.',
          'All specialist interfaces are mapped.',
          'Project-dependent equipment has a defined decision path.',
          'Duplicate content has an owner and consolidation decision.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Critical missing equipment has been identified from actual scope.',
          'CoP 36.0 and related CoPs have current-version references.',
          'Numbers and legal requirements are source-verified.',
          'Field checklists, stop-work controls and emergency interfaces are represented.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 3',
        points: [
          'Only after these checks pass should Plant & Equipment be marked COMPLETE.',
        ],
      ),
    ],
  ),
  PlantAuditGoldSection(
    number: '27',
    title: 'Plant & Equipment completion rule',
    points: [
      PlantAuditGoldPoint(
        title: 'Field controls 1',
        points: [
          'Plant & Equipment is COMPLETE only when the audit shows no unresolved critical gap.',
          'Non-critical project-dependent items may remain conditional if their status and activation criteria are explicitly recorded.',
          'Regulatory references must remain updateable because official versions can change.',
          'Future equipment modules must be added through this audit to prevent duplicate architecture.',
        ],
      ),
      PlantAuditGoldPoint(
        title: 'Field controls 2',
        points: [
          'Final status should be recorded as COMPLETE, CONDITIONAL or OPEN based on evidence, not assumption.',
        ],
      ),
    ],
  ),
];
