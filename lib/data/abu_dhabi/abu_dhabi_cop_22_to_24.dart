// lib/data/abu_dhabi/abu_dhabi_cop_22_to_24.dart
// SafeNexus HSE — Abu Dhabi HSE Reference
// CoP 22.0–24.0 field reference, structured from current ADPHC/ADOSH-SF documents.

import 'abu_dhabi_cop_01_to_03.dart';

class AbuDhabiCop22To24 {
  static const String registrySource =
      'Abu Dhabi Public Health Centre (ADPHC) — Code of Practices registry';

  static const List<AbuDhabiCopDocument> documents = [
    cop220Barricading,
    cop230WorkingAtHeight,
    cop240LockoutTagout,
  ];

  static const cop220Barricading = AbuDhabiCopDocument(
    code: 'CoP 22.0',
    title: 'Barricading of Hazards',
    version: '4.0',
    effectiveDate: '15 July 2024',
    introduction:
        'Sets requirements for planning, selecting, installing, inspecting and removing barricades used to control access to physical hazards.',
    sections: [
      AbuDhabiCopSection(
        number: '1.0',
        title: 'Scope, Purpose and Barricading Principles',
        requirements: [
          'Applies to employers within Abu Dhabi and addresses physical hazards that require controlled access or demarcation.',
          'Barricading is used to prevent unauthorized entry to a hazardous or restricted area and to reduce exposure to physical hazards.',
          'Use risk assessment to determine whether barricading is required and what level of physical protection is appropriate.',
          'Barricading is a control measure; it does not replace elimination, engineering controls or other required protective measures.',
        ],
        measurements: [
          'Barricade dimensions and placement shall follow the applicable CoP, risk assessment and site conditions.',
        ],
        documents: [
          'Risk assessment',
          'Barricading procedure',
          'Site rules',
        ],
        hazards: [
          'Falls',
          'Falling objects',
          'Vehicle/pedestrian interaction',
          'Equipment/process hazards',
        ],
        controls: [
          'Eliminate hazard where practicable',
          'Physical separation',
          'Controlled access',
          'Warning signage',
        ],
        inspection: [
          'Verify the barricade actually separates people from the hazard and has not become a symbolic barrier only.',
        ],
      ),
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Training, Competency and Retraining',
        requirements: [
          'Provide competency-based training to people responsible for barricading.',
          'Training shall cover safe systems of work, barricade selection, equipment, care, maintenance and inspection.',
          'Retrain when inspections identify knowledge or application deficiencies or when the barricading procedure fails.',
          'Maintain training records including worker identification, training subject, date and trainer.',
        ],
        measurements: [
        ],
        documents: [
          'Training matrix',
          'Training records',
          'Competency assessment',
        ],
        hazards: [
          'Incorrect barricade selection',
          'Unsafe erection',
          'Poor inspection',
        ],
        controls: [
          'Competency verification',
          'Practical instruction',
          'Retraining',
        ],
        inspection: [
          'Sample training records and interview workers to confirm practical understanding.',
        ],
      ),
      AbuDhabiCopSection(
        number: '3.0',
        title: 'Roles, Responsibilities and Supervision',
        requirements: [
          'Employer maintains control of access to dangerous or high-risk areas through suitable barricades.',
          'Barricades shall be appropriate for the task, serviceable, planned, supervised and inspected by a competent person.',
          'Workers shall report barricade defects or conditions that could endanger themselves or others.',
          'Workers shall follow the entity safe system when installing or erecting barricades.',
        ],
        measurements: [
        ],
        documents: [
          'Responsibility matrix',
          'Inspection records',
          'Site supervision records',
        ],
        hazards: [
          'Unclear ownership',
          'Uncontrolled access',
          'Defective barricade',
        ],
        controls: [
          'Named responsible person',
          'Competent supervision',
          'Worker reporting',
        ],
        inspection: [
          'Confirm responsible supervisor and inspection ownership are clear at the worksite.',
        ],
      ),
      AbuDhabiCopSection(
        number: '4.0',
        title: 'Planning, Risk Assessment and Selection',
        requirements: [
          'Evaluate the site or operation to identify hazards and determine the need for barricading.',
          'Assess the nature of the hazard, likelihood and consequence of interaction and minimum barricading requirements.',
          'Construction projects shall integrate barricading requirements into the applicable pre-tender plan and OSH-CMP.',
          'Consider workers, contractors, visitors and members of the public.',
        ],
        measurements: [
        ],
        documents: [
          'Risk assessment',
          'Pre-tender HSE plan',
          'OSH-CMP',
          'Site layout',
        ],
        hazards: [
          'Unassessed fall hazard',
          'Public exposure',
          'Falling materials',
          'Plant movement',
        ],
        controls: [
          'Risk-based selection',
          'Segregation',
          'Public protection',
          'Site rules',
        ],
        inspection: [
          'Walk the area and compare actual hazards with the barricading risk assessment.',
        ],
      ),
      AbuDhabiCopSection(
        number: '5.0',
        title: 'Where Barricading is Required',
        requirements: [
          'Consider barricading where a person could fall, be struck by falling objects, enter a worksite, be injured by equipment/processes, or enter a hazardous area.',
          'Use the affected-area footprint rather than barricading only the immediate point of the hazard.',
          'Consider deflection or spread of sparks, falling objects, leaks and similar hazards.',
        ],
        measurements: [
          'For trip hazards or unprotected edges with fall potential below 2 m, barricade tape is to be at least 2 m back from the edge or hazard.',
        ],
        documents: [
          'Hazard assessment',
          'Barricade layout',
          'Public protection plan',
        ],
        hazards: [
          'Falls',
          'Falling objects',
          'Leaks',
          'Sparks',
          'Moving equipment',
        ],
        controls: [
          'Adequate setback',
          'Full affected-area coverage',
          'Hard barricading where necessary',
        ],
        inspection: [
          'Verify the entire reasonably affected zone is controlled.',
        ],
      ),
      AbuDhabiCopSection(
        number: '6.0',
        title: 'Soft Barricading',
        requirements: [
          'Use soft barricading as an immediate and short-term control where the risk assessment indicates low risk.',
          'Examples include scissor/expanding barricades, post and chain, cone and plank, flag bunting and plastic mesh barriers.',
          'Soft barricading shall remain effective, visible and maintained.',
        ],
        measurements: [
          'Mesh/tape top edge: 900 mm to 1200 mm.',
        ],
        documents: [
          'Inspection records',
          'Barricade identification',
        ],
        hazards: [
          'Easy displacement',
          'Poor visibility',
          'Unauthorized entry',
        ],
        controls: [
          'Suitable low-risk application',
          'Stable supports',
          'Clear demarcation',
        ],
        inspection: [
          'Check stability, visibility, continuity and suitability for the hazard.',
        ],
      ),
      AbuDhabiCopSection(
        number: '7.0',
        title: 'Hard Barricading and Physical Barriers',
        requirements: [
          'Use hard barricading where risk assessment requires a solid physical barrier.',
          'Examples include mesh/hoarding panels, scaffold tube and fittings, road traffic barricades and rigid A-frame barricades.',
          'Solid barricades shall be erected by competent persons and accompanied by hazard signs.',
          'Provide designated entry/exit points where controlled entry is required.',
        ],
        measurements: [
          'Top edge of mesh/barricading: 900–1200 mm unless another applicable requirement controls.',
        ],
        documents: [
          'Barricade installation record',
          'Competency record',
          'Signage plan',
        ],
        hazards: [
          'Barrier collapse',
          'Uncontrolled entry',
          'Poorly designed access point',
        ],
        controls: [
          'Physical barrier',
          'Controlled gateway',
          'Hazard signage',
        ],
        inspection: [
          'Check anchorage/support, gates, signs and access-control arrangement.',
        ],
      ),
      AbuDhabiCopSection(
        number: '8.0',
        title: 'Barricade Method, Layout and Interfaces',
        requirements: [
          'Install barricades to eliminate accidental entry into the restricted zone.',
          'Barricades may integrate with existing structures where reasonably practicable but shall not be tied to electric cables or flexible air hoses.',
          'Entry points shall be arranged so a person cannot walk directly into the hazard.',
          'Where the public may be exposed, use physical barriers and/or a safety observer as appropriate.',
          'Solid barricades shall carry signage meeting CoP 17 requirements.',
        ],
        measurements: [
        ],
        documents: [
          'Layout drawing',
          'Permit/work package',
          'CoP 17 signage information',
        ],
        hazards: [
          'Accidental entry',
          'Contact with services',
          'Poor pedestrian routing',
        ],
        controls: [
          'Independent supports',
          'Controlled access',
          'Clear warning information',
        ],
        inspection: [
          'Trace pedestrian movement from outside to inside the barricade and verify no direct route into the hazard.',
        ],
      ),
      AbuDhabiCopSection(
        number: '9.0',
        title: 'Barricade Signs and Identification',
        requirements: [
          'Attach signs in sufficient numbers to remain visible under all relevant conditions.',
          'Signs shall communicate the hazard and access restriction.',
          'Include the responsible contact person\'s name and phone number and expected duration of the barricade.',
          'Where appropriate, provide specific hazard wording such as danger/no access/persons working above.',
        ],
        measurements: [
        ],
        documents: [
          'Signage register',
          'Barricade tag',
          'Contact details',
        ],
        hazards: [
          'Missing warning',
          'Unclear responsibility',
          'Outdated duration',
        ],
        controls: [
          'Visible signage',
          'Specific hazard message',
          'Responsible-person details',
        ],
        inspection: [
          'Confirm signs remain legible, current and visible from normal approach routes.',
        ],
      ),
      AbuDhabiCopSection(
        number: '10.0',
        title: 'Barricade Tape, Mesh and Materials',
        requirements: [
          'Barricade tape shall encompass the entire potentially affected area.',
          'Maintain tape and mesh in good condition so they remain effective controls.',
          'Mesh shall be adequately supported to avoid sagging.',
          'Cone-and-plank barriers shall use proprietary brackets to secure planks.',
          'Vehicle-impact water-filled plastic barricades shall be linked together and filled with water.',
        ],
        measurements: [
          'Tape setback for specified low-height trip/unprotected-edge hazards: at least 2 m.',
          'Mesh/tape top edge: 900–1200 mm.',
        ],
        documents: [
          'Material inspection record',
          'Manufacturer information',
        ],
        hazards: [
          'Sagging mesh',
          'Broken tape',
          'Barrier displacement',
          'Vehicle impact',
        ],
        controls: [
          'Correct material selection',
          'Positive fixing',
          'Adequate support',
          'Linked water-filled barriers where required',
        ],
        inspection: [
          'Inspect supports, joints, tape condition, mesh tension and impact resistance.',
        ],
      ),
      AbuDhabiCopSection(
        number: '11.0',
        title: 'Lighting and Night-Time Barricading',
        requirements: [
          'Provide warning lights where risk assessment indicates a need to warn people of a barricade during darkness.',
          'Barricades across roadways that remain during darkness shall use flashing lights in accordance with the road-work requirements.',
          'Night visibility shall be considered during planning, not added only after an incident.',
        ],
        measurements: [
        ],
        documents: [
          'Night-work plan',
          'Lighting inspection',
          'Traffic-management plan',
        ],
        hazards: [
          'Vehicle collision',
          'Pedestrian collision',
          'Poor visibility',
        ],
        controls: [
          'Warning lights',
          'Flashing lights for applicable roadway barricades',
          'Reflective/visible signs',
        ],
        inspection: [
          'Inspect after dark where night work is planned.',
        ],
      ),
      AbuDhabiCopSection(
        number: '12.0',
        title: 'Unauthorized Access and Public Protection',
        requirements: [
          'Construction sites shall be secured with fencing to prevent unauthorized access so far as reasonably practicable.',
          'Consider the relevant building code and current Abu Dhabi construction requirements.',
          'Where increased out-of-hours access risk is foreseeable, consider security guarding.',
          'Give special attention to residential areas and foreseeable child access.',
        ],
        measurements: [
        ],
        documents: [
          'Site security plan',
          'Fencing inspection',
          'Security records',
        ],
        hazards: [
          'Child entry',
          'Public entry',
          'Vandalism',
          'Night access',
        ],
        controls: [
          'Site fencing',
          'Controlled gates',
          'Security arrangements',
          'Warning signs',
        ],
        inspection: [
          'Check gates, fencing continuity and out-of-hours controls.',
        ],
      ),
      AbuDhabiCopSection(
        number: '13.0',
        title: 'Inspection, Tags and Weekly Formal Inspection',
        requirements: [
          'Keep barricades effective, clearly signed, resistant to accidental contact and visible where darkness requires.',
          'Inspect components frequently and remove defective items from service.',
          'Defective components shall be tagged or marked \'Dangerous, Do Not Use\'.',
          'Conduct and document a formal inspection at least weekly for barricading under this CoP.',
          'Inspection tags may identify barricade ID, first erection date, last inspection date, result and inspector.',
        ],
        measurements: [
          'Formal inspection: minimum weekly.',
        ],
        documents: [
          'Inspection tag',
          'Weekly inspection record',
          'Defect report',
        ],
        hazards: [
          'Undetected damage',
          'Expired inspection',
          'False assurance',
        ],
        controls: [
          'Competent inspection',
          'Tagging',
          'Defect isolation',
          'Document control',
        ],
        inspection: [
          'Sample barricades against the weekly inspection register.',
        ],
      ),
      AbuDhabiCopSection(
        number: '14.0',
        title: 'Post-Incident Inspection and Defect Control',
        requirements: [
          'Inspect a barricade after it is damaged or involved in an incident.',
          'Remove damaged components from service where repair is not reasonably practicable.',
          'Only serviceable barricades shall be available for use.',
        ],
        measurements: [
        ],
        documents: [
          'Incident report',
          'Post-incident inspection',
          'Repair/disposal record',
        ],
        hazards: [
          'Impact damage',
          'Loss of stability',
          'Missing components',
        ],
        controls: [
          'Immediate inspection',
          'Isolation of defective parts',
          'Repair or disposal',
        ],
        inspection: [
          'Verify incident-damaged barriers were assessed before reuse.',
        ],
      ),
      AbuDhabiCopSection(
        number: '15.0',
        title: 'Removal, Close-Out and Practical Examples',
        requirements: [
          'Remove barricades and tape once they are no longer required because the hazard is controlled or the work is complete.',
          'Do not leave redundant barricades that create confusion, blocked access or false warnings.',
          'Example: overhead work — barricade the full potential falling-object area and provide signs/contact information.',
          'Example: damaged floor opening — use a suitable physical barrier where the risk requires it, not tape alone.',
          'Example: temporary road obstruction — apply the applicable road-work barricading and night-lighting requirements.',
        ],
        measurements: [
        ],
        documents: [
          'Work completion record',
          'Close-out inspection',
          'Barricade removal record',
        ],
        hazards: [
          'Redundant barrier',
          'False security',
          'Blocked egress',
        ],
        controls: [
          'Close-out verification',
          'Prompt removal',
          'Final area inspection',
        ],
        inspection: [
          'Verify the hazard is controlled before removal and verify safe conditions after removal.',
        ],
      ),
    ],
      AbuDhabiCopSection(
        number: '16.0',
        title: 'CoP 22 Field Example — Overhead Work and Falling Objects',
        requirements: [
          'Where overhead work can expose people below to falling objects, define the entire potentially affected area rather than only the point immediately below the worker.',
          'Consider reasonably practicable deflection of an object from structures below when defining the barricade footprint.',
          'Use suitable physical barriers and signs where people could enter the falling-object zone.',
          'Where the general public may be exposed, use physical barriers and/or a safety observer where appropriate.',
        ],
        measurements: [
          'For the specified trip/unprotected-edge condition with fall potential less than 2 m, barricade tape is installed at least 2 m back from the edge or hazard.',
        ],
        documents: [
          'Dropped-object assessment',
          'Barricade layout',
          'Public protection plan',
        ],
        hazards: [
          'Falling tools',
          'Falling materials',
          'Deflected objects',
          'Public exposure',
        ],
        controls: [
          'Full affected-area barricade',
          'Physical barrier',
          'Warning signs',
          'Safety observer where appropriate',
        ],
        inspection: [
          'Walk the complete drop/deflection area and verify the barricade is not undersized.',
        ],
      ),
      AbuDhabiCopSection(
        number: '17.0',
        title: 'CoP 22 Field Example — Low-Risk Soft Barricade vs Hard Barricade',
        requirements: [
          'Soft barricading is an immediate and short-term control where risk assessment indicates low risk.',
          'Examples include scissor/expanding barricades, post and chain, plastic cone and plank, flag bunting and plastic mesh.',
          'Hard barricading is required where the risk assessment indicates a solid physical barrier is necessary.',
          'Examples include mesh/hoarding fence panels, scaffold tube and fittings, road traffic barricades and free-standing rigid A-frame barricades.',
          'Solid barricades are to be erected by a competent person and accompanied by hazard signs.',
        ],
        measurements: [
          'Mesh/tape top edge: 900–1200 mm.',
        ],
        documents: [
          'Risk assessment',
          'Barricade selection record',
          'Competency record',
        ],
        hazards: [
          'Inadequate barrier strength',
          'Wrong barrier type',
          'Uncontrolled access',
        ],
        controls: [
          'Risk-based selection',
          'Competent installation',
          'Physical separation',
        ],
        inspection: [
          'Challenge the barrier selection if the hazard has changed or the barrier is easily displaced.',
        ],
      ),
      AbuDhabiCopSection(
        number: '18.0',
        title: 'CoP 22 Inspection Tag and Incident-Damage Example',
        requirements: [
          'Barricades shall remain signed, visible, effective against accidental contact and visible during darkness where required.',
          'Components are to be inspected frequently; defective components are withdrawn from service for repair or disposal and marked \'Dangerous, Do Not Use\'.',
          'At minimum, a weekly formal inspection is documented for barricading covered by this CoP.',
          'Inspection tags may record barricade identification, first erection date, last inspection, result and inspector name.',
          'If a barricade is damaged or involved in an incident, inspect it before further use and remove unrepairable components from service.',
        ],
        measurements: [
          'Formal barricade inspection: minimum weekly.',
        ],
        documents: [
          'Inspection tag',
          'Weekly inspection record',
          'Incident inspection record',
          'Repair/disposal record',
        ],
        hazards: [
          'False assurance',
          'Impact damage',
          'Expired inspection',
        ],
        controls: [
          'Competent inspection',
          'Tagging',
          'Defect isolation',
          'Documented close-out',
        ],
        inspection: [
          'Sample the tag against the formal inspection record and verify incident-damaged items were assessed.',
        ],
      ),
    fieldChecklist: [
      'Hazard risk assessment completed.',
      'Correct barricade type selected.',
      'Signs show hazard, responsible contact and expected duration where required.',
      'Affected area fully enclosed.',
      'Barricades inspected and maintained.',
      'Weekly formal inspection documented.',
      'Defects removed from service.',
      'Barricades removed when no longer required.',
    ],
    stopWorkIndicators: [
      'Barricade missing or displaced.',
      'People can accidentally enter the hazard.',
      'Required signage missing.',
      'Defective barricade remains in service.',
      'Night visibility inadequate.',
      'Hazard remains after barricade removal.',
    ],
    references: [
      'ADPHC Code of Practices registry — CoP 22.0.',
      'ADOSH-SF CoP 22.0 — Barricading of Hazards, Version 4.0, 15 July 2024.',
    ],
    verificationNote:
        'Content is structured from the official ADPHC/ADOSH-SF Code of Practice and should be used with the current official document, applicable law, authority requirements, risk assessment and manufacturer instructions.',
  );
  static const cop230WorkingAtHeight = AbuDhabiCopDocument(
    code: 'CoP 23.0',
    title: 'Working at Height',
    version: '4.1',
    effectiveDate: '16 February 2026',
    introduction:
        'Sets requirements for planning, training, fall prevention, falling-object protection, rescue, guardrails, safety nets, fall-arrest systems, working platforms, inspections and roof work.',
    sections: [
      AbuDhabiCopSection(
        number: '1.0',
        title: 'Scope, Definitions and Fall-Prevention Principles',
        requirements: [
          'Applies to employers within Abu Dhabi and covers planning, preparation and conduct of work-at-height activities.',
          'Work at height includes work where a person could fall from, through, into or onto a place or structure; a place may be at or below ground level if a fall can cause injury.',
          'Coverage includes access, fall prevention, guardrails, safety nets, roofs, ladders, tower cranes, fall-arrest systems and working platforms.',
          'Apply the hierarchy of controls and select collective protection before personal fall arrest where reasonably practicable.',
        ],
        measurements: [
          'Anchorage should be rigid and, under the current CoP definition, should not deflect more than 1 mm when a 10 kN force is applied.',
          'Personal fall-arrest anchorages: minimum dead-weight capability 2450 kg per person attached.',
        ],
        documents: [
          'Fall Prevention Plan',
          'Risk assessment',
          'Work-at-height method statement',
        ],
        hazards: [
          'Falls from edges',
          'Falls through openings',
          'Fragile surfaces',
          'Falling objects',
        ],
        controls: [
          'Eliminate work at height',
          'Collective protection',
          'Guardrails/nets',
          'Fall arrest as required',
        ],
        inspection: [
          'Verify the planned system matches the actual work location and access route.',
        ],
      ),
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Training, Competency and Field Assessment',
        requirements: [
          'Provide training before assigning employees to jobs with fall hazards.',
          'Training covers the Fall Prevention Plan, equipment types, hazards, removal from service, identification, maintenance, inspection, rescue, suspension trauma, donning/doffing, equipment limits and practical field use.',
          'Train users of guardrails, fall-arrest systems, safety nets, warning lines, safety monitoring and controlled-access methods used on the site.',
          'Assess competency before an employee uses fall-arrest equipment.',
          'Retrain after job changes, equipment changes, new hazards, inadequate knowledge, inspection findings or failed fall-protection procedures.',
        ],
        measurements: [
        ],
        documents: [
          'Training records',
          'Competency assessment',
          'Practical training record',
        ],
        hazards: [
          'Inexperienced worker',
          'Incorrect harness use',
          'Poor rescue response',
        ],
        controls: [
          'Competent trainer',
          'Field practice',
          'Refresher training',
          'Language appropriate training',
        ],
        inspection: [
          'Interview workers and request evidence of competency.',
        ],
      ),
      AbuDhabiCopSection(
        number: '3.0',
        title: 'Roles, Planning and Assessment',
        requirements: [
          'Employers shall plan, organize and supervise work at height.',
          'Assess work location, access, duration, weather, people exposed, falling-object hazards, rescue requirements and equipment.',
          'Coordinate principal contractor, subcontractors and other work groups.',
          'Include work-at-height controls in the applicable construction HSE plans.',
        ],
        measurements: [
        ],
        documents: [
          'RAMS',
          'Fall Prevention Plan',
          'Lift/access plan',
          'Rescue plan',
        ],
        hazards: [
          'SIMOPS',
          'Weather',
          'Unplanned changes',
          'Poor access',
        ],
        controls: [
          'Pre-job assessment',
          'Coordination',
          'Supervisor verification',
          'Change control',
        ],
        inspection: [
          'Walk down the work area before starting.',
        ],
      ),
      AbuDhabiCopSection(
        number: '4.0',
        title: 'Falling Objects and Public Protection',
        requirements: [
          'Protect people from tools, materials and equipment that could fall from elevated work.',
          'Use toe boards, screens or guardrails, canopies, or barricading/controlled exclusion zones as appropriate.',
          'Keep potential falling objects away from edges where displacement could send them into exposed areas.',
          'Where the public may be exposed, use robust physical protection and appropriate access control.',
        ],
        measurements: [
        ],
        documents: [
          'Dropped-object assessment',
          'Exclusion-zone plan',
          'Public protection plan',
        ],
        hazards: [
          'Tools/materials falling',
          'Debris',
          'Public exposure',
        ],
        controls: [
          'Toe boards',
          'Screens',
          'Canopies',
          'Barricades',
        ],
        inspection: [
          'Check the area below and adjacent to the work, not just the worker\'s platform.',
        ],
      ),
      AbuDhabiCopSection(
        number: '5.0',
        title: 'Emergency Planning, Rescue and Suspension Trauma',
        requirements: [
          'Plan rescue before work begins where a person could fall and remain suspended.',
          'Training shall include practical and theoretical emergency actions and rescue from height.',
          'Consider suspension trauma, access to the casualty, rescue equipment, communications, first aid and emergency services.',
          'Do not rely solely on external emergency services where the work requires a planned site rescue capability.',
        ],
        measurements: [
        ],
        documents: [
          'Rescue plan',
          'Rescue equipment inspection',
          'Emergency contact list',
          'Drill record',
        ],
        hazards: [
          'Suspended worker',
          'Delayed rescue',
          'Secondary fall',
        ],
        controls: [
          'Dedicated rescue method',
          'Trained rescuers',
          'Accessible equipment',
          'Emergency communication',
        ],
        inspection: [
          'Ask the crew to explain the rescue sequence and location of equipment.',
        ],
      ),
      AbuDhabiCopSection(
        number: '6.0',
        title: 'Personal Protective Equipment and Fall-Arrest Selection',
        requirements: [
          'Select fall-protection equipment based on task, fall potential/severity, mobility and available fall distance/clearance.',
          'Use equipment combinations in accordance with manufacturer instructions.',
          'Users shall not alter equipment in ways that adversely affect safe operation.',
          'Consider comfort and freedom of movement while maintaining protection.',
        ],
        measurements: [
          'Use the actual system calculation and manufacturer data for required clearance; do not substitute an assumed clearance value.',
        ],
        documents: [
          'Equipment register',
          'Manufacturer instructions',
          'Compatibility records',
        ],
        hazards: [
          'Incorrect connector',
          'Insufficient clearance',
          'Swing fall',
          'Equipment incompatibility',
        ],
        controls: [
          'Compatible system',
          'Correct anchorage',
          'Clearance assessment',
          'Pre-use inspection',
        ],
        inspection: [
          'Verify harness, lanyard/device, connector and anchorage compatibility.',
        ],
      ),
      AbuDhabiCopSection(
        number: '7.0',
        title: 'Selecting Work-at-Height Personnel',
        requirements: [
          'Assign only personnel who are trained, competent and physically able to perform the planned work safely.',
          'Consider task-specific capability, rescue participation, equipment use and environmental conditions.',
          'Ensure workers understand their role in the Fall Prevention Plan.',
        ],
        measurements: [
        ],
        documents: [
          'Competency matrix',
          'Training record',
          'Medical/fitness process where applicable',
        ],
        hazards: [
          'Inadequate competence',
          'Fatigue',
          'Poor rescue capability',
        ],
        controls: [
          'Competency verification',
          'Supervision',
          'Task-specific briefing',
        ],
        inspection: [
          'Confirm assigned personnel match the competency requirements.',
        ],
      ),
      AbuDhabiCopSection(
        number: '8.0',
        title: 'Danger Areas and Controlled Access',
        requirements: [
          'Identify areas where a fall or falling-object hazard exists and prevent unauthorized entry.',
          'Use barricading and signage in accordance with CoP 22 and CoP 17.',
          'Control access below overhead work and around openings, edges and fragile surfaces.',
          'Keep exclusion zones effective for the full duration of the hazard.',
        ],
        measurements: [
        ],
        documents: [
          'Exclusion-zone plan',
          'Barricade inspection',
          'Signage inspection',
        ],
        hazards: [
          'Unauthorized entry',
          'Falling objects',
          'Openings',
        ],
        controls: [
          'Hard barricade where needed',
          'Warning signs',
          'Access control',
        ],
        inspection: [
          'Inspect the zone at shift changes and after work-front changes.',
        ],
      ),
      AbuDhabiCopSection(
        number: '9.0',
        title: 'Guardrail Systems',
        requirements: [
          'Use guardrails as a primary collective fall-prevention measure where practicable.',
          'Protect open-sided floors, walkways, platforms and runways according to the CoP requirements.',
          'Guardrails shall have top rail, mid-rail and posts; provide toe boards where required.',
          'Protect areas above dangerous equipment regardless of fall height.',
        ],
        measurements: [
          'Standard railing top-rail height: 950 mm nominal.',
          'Standard railing shall withstand at least 90 kg applied in any direction at any point on the top rail.',
          'Open-sided floors/platforms at 1.2 m or more above adjacent floor/ground require standard railing, subject to stated exceptions.',
        ],
        documents: [
          'Guardrail design',
          'Inspection records',
          'Structural certification',
        ],
        hazards: [
          'Guardrail failure',
          'Falling objects',
          'Missing toe board',
        ],
        controls: [
          'Collective protection',
          'Adequate strength',
          'Toe boards',
          'Secure posts',
        ],
        inspection: [
          'Check height, rails, posts, fixing and toe-board requirements.',
        ],
      ),
      AbuDhabiCopSection(
        number: '10.0',
        title: 'Safety Nets',
        requirements: [
          'Use safety nets only when selected and installed by competent persons and suitable for the task.',
          'Maintain certification and installation records at the jobsite.',
          'Do not use defective nets.',
          'Inspect, clean, store and repair nets in accordance with the CoP and manufacturer requirements.',
          'Repairs shall be carried out by competent persons using compatible materials.',
        ],
        measurements: [
          'Safety nets shall be inspected at least weekly.',
          'Repair tags identify the repairer and repair date.',
        ],
        documents: [
          'Net certification',
          'Installation record',
          'Weekly inspection',
          'Repair record',
        ],
        hazards: [
          'Damaged net',
          'Contamination',
          'Incorrect installation',
          'Improper storage',
        ],
        controls: [
          'Competent installation',
          'Regular inspection',
          'Controlled repair',
          'Correct storage',
        ],
        inspection: [
          'Check net condition, certification and repair history.',
        ],
      ),
      AbuDhabiCopSection(
        number: '11.0',
        title: 'Fall-Arrest Systems — Inspection and Maintenance',
        requirements: [
          'Users shall inspect harnesses, lanyards, connectors, fall-arrest devices, ropes and mobile attachment devices before and after each use.',
          'Equipment subjected to a fall or impact shall be removed from service immediately for examination.',
          'Defective equipment shall be tagged out of service and segregated from serviceable equipment.',
          'Repairs shall be performed by competent persons.',
        ],
        measurements: [
          'Belts, harnesses and lanyards: competent inspection every 6 months.',
          'Fall-arrest devices: competent inspection every 3 months.',
          'Horizontal/vertical lifelines and rails: inspection every 12 months.',
          'Anchorages: inspect/certify before use after initial installation and every 12 months thereafter by qualified personnel.',
          'Slings: inspect every 3 months and test every 12 months by competent testing organization.',
          'Ropes used to suspend a person: inspect before/after each use and every 3 months; do not pull-test ropes.',
        ],
        documents: [
          'Inspection register',
          'Out-of-service tags',
          'Test certificates',
          'Repair records',
        ],
        hazards: [
          'Hidden damage',
          'Impact loading',
          'Corrosion',
          'Expired inspection',
        ],
        controls: [
          'Pre-use inspection',
          'Periodic competent inspection',
          'Segregation',
          'Manufacturer maintenance',
        ],
        inspection: [
          'Sample serial numbers against inspection dates.',
        ],
      ),
      AbuDhabiCopSection(
        number: '12.0',
        title: 'Working Platforms, Floors and Stairs',
        requirements: [
          'Protect open-sided floors, walkways, platforms and runways where the CoP requires guardrails.',
          'Provide toe boards where people, moving machinery or equipment could be exposed to falling materials.',
          'Provide fixed stairs where regular travel between levels or routine access requires them.',
          'Protect stairs and maintain required overhead clearance.',
        ],
        measurements: [
          'Open-sided floors/platforms at 1.2 m or more: standard railing.',
          'Standard stair railing: 760–860 mm vertical height.',
          'Overhead stair clearance: at least 2.1 m.',
          'Certain open runways with one side omitted require minimum 45 cm runway width plus appropriate fall protection.',
        ],
        documents: [
          'Platform inspection',
          'Stair inspection',
          'Access design',
        ],
        hazards: [
          'Falls',
          'Falling objects',
          'Head strike',
        ],
        controls: [
          'Guardrails',
          'Toe boards',
          'Fixed stairs',
          'Clearance',
        ],
        inspection: [
          'Measure critical dimensions where required and inspect after alterations.',
        ],
      ),
      AbuDhabiCopSection(
        number: '13.0',
        title: 'Fragile Surfaces and Unprotected Edges',
        requirements: [
          'Do not access or work near fragile surfaces unless it is the only reasonably practicable safe method considering the task, equipment and environment.',
          'Where fragile-surface work is unavoidable, provide and use appropriate platforms, coverings and guardrails.',
          'Warn workers approaching fragile surfaces.',
          'Protect unprotected edges using guardrails, safety nets, personal fall arrest or permitted combinations.',
        ],
        measurements: [
          'Unprotected side/edge at 2 m or more above a lower level requires fall protection.',
          'Low-slope roof provisions include specified warning-line combinations; on roofs 15.25 m or less in width, the CoP permits a safety-monitoring system alone in the stated circumstances.',
        ],
        documents: [
          'Roof risk assessment',
          'Fragile-surface register',
          'Warning signage',
        ],
        hazards: [
          'Fragile roof',
          'Skylights',
          'Unprotected edge',
        ],
        controls: [
          'Coverings',
          'Guardrails',
          'Safety nets',
          'Fall arrest',
        ],
        inspection: [
          'Inspect roof surface, edge protection and warning systems before entry.',
        ],
      ),
      AbuDhabiCopSection(
        number: '14.0',
        title: 'Roof Work and Weather',
        requirements: [
          'Design roof structures to reduce fall risk and consider construction, maintenance, repair and demolition.',
          'Where practicable, provide permanent guardrails/toe boards, anchorages, safe access and design features that reduce work at height.',
          'Before roof work, competent persons shall verify edge protection, harness availability where required, briefing, rescue, barricading below and weather suitability.',
          'Consider off-site assembly/prefabrication to reduce work at height.',
        ],
        measurements: [
        ],
        documents: [
          'Roof work method statement',
          'Design risk record',
          'Weather assessment',
          'Rescue plan',
        ],
        hazards: [
          'Fragile roof',
          'Wind',
          'Rain',
          'Heat',
          'Falling objects',
        ],
        controls: [
          'Edge protection',
          'Safe access',
          'Rescue arrangements',
          'Weather hold point',
        ],
        inspection: [
          'Conduct pre-start roof inspection and stop when conditions exceed safe limits.',
        ],
      ),
      AbuDhabiCopSection(
        number: '15.0',
        title: 'Tower Cranes, Ladders, MEWPs and Access Interfaces',
        requirements: [
          'Treat access equipment and tower-crane work-at-height interfaces as part of the Fall Prevention Plan.',
          'Select equipment suitable for the task and provide safe access/egress.',
          'Do not use ladders as a substitute for a safer access system where the task requires another method.',
          'Coordinate work above/below equipment and protect against dropped objects.',
        ],
        measurements: [
        ],
        documents: [
          'Equipment inspection',
          'Access plan',
          'MEWP inspection/certification',
        ],
        hazards: [
          'Falls',
          'Equipment movement',
          'Dropped objects',
        ],
        controls: [
          'Suitable access equipment',
          'Exclusion zones',
          'Inspection',
          'Competent operation',
        ],
        inspection: [
          'Verify access equipment is inspected and positioned on suitable surfaces.',
        ],
      ),
      AbuDhabiCopSection(
        number: '16.0',
        title: 'Formal Inspection Programme and Records',
        requirements: [
          'Maintain an inspection and preventive-maintenance procedure for fall-protection systems.',
          'Fall-protection equipment shall be inspected before each use and have documented inspection at intervals not exceeding 6 months or manufacturer guidance.',
          'Items shall be inspected after assembly and before first use, at intervals not exceeding 7 days, after substantial alteration and after impacts/extreme conditions affecting stability.',
          'Keep construction-site platform inspection reports until completion, then at the employer office for a further three months.',
        ],
        measurements: [
          'Pre-use inspection: before each use.',
          'Documented fall-protection inspection: maximum 6 months or manufacturer requirement, as applicable.',
          'Installed items/platforms: intervals not exceeding 7 days and after listed events.',
        ],
        documents: [
          'Inspection register',
          'Platform inspection report',
          'Maintenance records',
          'Manufacturer instructions',
        ],
        hazards: [
          'Missed inspections',
          'Unrecorded alterations',
          'Post-impact reuse',
        ],
        controls: [
          'Inspection scheduling',
          'Defect tagging',
          'Record retention',
        ],
        inspection: [
          'Audit dates, serial numbers, inspector competency and corrective-action closure.',
        ],
      ),
    ],
      AbuDhabiCopSection(
        number: '17.0',
        title: 'Working at Height — Falling-Object Controls in Detail',
        requirements: [
          'Where people can be exposed to falling objects, protect them using suitable engineering and access controls.',
          'Use toe boards, screens or guardrails, canopies, barricading/exclusion zones or other suitable controls as applicable.',
          'Work shall stop while people traverse an exclusion zone where the work creates an uncontrolled falling-object exposure.',
          'Provide warning signs in accordance with CoP 17.',
          'Use bolt bags/tool carriers for small tools and secure tools and equipment used at height with lanyards where required.',
          'People required to enter the exclusion zone, including persons holding ladders and banksmen, shall wear hard hats.',
        ],
        measurements: [
        ],
        documents: [
          'Dropped-object assessment',
          'Exclusion-zone plan',
          'Tool-lanyard inspection',
        ],
        hazards: [
          'Falling tools',
          'Falling materials',
          'People entering exclusion zone',
        ],
        controls: [
          'Toe boards',
          'Screens',
          'Canopies',
          'Exclusion zone',
          'Tool lanyards',
        ],
        inspection: [
          'Observe the actual work below and around the elevated activity.',
        ],
      ),
      AbuDhabiCopSection(
        number: '18.0',
        title: 'Guardrail Systems — Detailed Field Requirements',
        requirements: [
          'Provide guardrails to all edges where there is a risk of falling 2 m or more.',
          'Provide guardrails around building perimeters, skylights/fragile roof materials, floor or roof openings, shaft/excavation edges and other applicable exposed edges.',
          'Proprietary systems shall be configured, installed, used and dismantled according to manufacturer instructions.',
          'Use gates, chains or removable sections at hoisting areas when hoisting is not taking place.',
          'Protect holes on all unprotected sides; where material-passage openings exist, control removable sections and close/protect the opening when not in use.',
          'At access holes such as ladder ways, use a gate or offset arrangement so a person cannot walk directly into the hole.',
          'Guardrails on ramps and runways shall be provided along each unprotected side or edge.',
        ],
        measurements: [
          'Top rail minimum: 950 mm above walking/working platform.',
          'Toe board minimum: 150 mm high where required.',
          'Gap between guardrail/midrail/toe board: not more than 470 mm.',
          'Guardrail point-load capacity: at least 1.25 kN in any outward or downward direction at any point along the top edge.',
          'Under the specified downward 1.25 kN test, top edge shall not deflect below 900 mm.',
          'Top and mid rails: at least 60 mm nominal diameter or thickness.',
          'Wire-rope top rails: high-visibility flags at not more than 2 m intervals.',
        ],
        documents: [
          'Guardrail design/certification',
          'Inspection record',
          'Manufacturer instructions',
        ],
        hazards: [
          'Guardrail failure',
          'Open hole',
          'Sharp edges',
          'Clothing snagging',
        ],
        controls: [
          'Adequate strength',
          'Smooth surfaces',
          'Correct gaps',
          'Controlled gates',
        ],
        inspection: [
          'Measure/verify critical dimensions and load evidence where applicable.',
        ],
      ),
      AbuDhabiCopSection(
        number: '19.0',
        title: 'Safety Nets — Installation, Mesh, Certification and Testing',
        requirements: [
          'Use safety nets only where measures preventing a fall of people or objects are not reasonably practicable.',
          'Erect nets as close as reasonably practicable to the working level and slightly higher at the outer edge when installed outside a structure.',
          'Personnel nets are intended to catch a person; material/debris nets reduce risk from falling objects.',
          'Competent persons shall erect nets and ensure the supporting framework can withstand impact/shock loading.',
          'Consult the appropriate authority before erecting nets near electricity lines or overhead power cables.',
          'Do not use defective nets; inspect after events affecting integrity.',
        ],
        measurements: [
          'Maximum fall distance before encountering a safety net: 2 m.',
          'Personnel net mesh: 100 mm type.',
          'Material/debris protection mesh: 12–19 mm type.',
          'Maximum mesh opening: 230 cm² and no side longer than 150 mm; center-to-center mesh opening not longer than 150 mm.',
          'Border rope minimum breaking strength: 22.2 kN.',
          'Connections between net panels: not more than 150 mm apart and at least as strong as integral components.',
          'Safety-net inspection: immediately after erection and at least weekly; test cord testing at intervals not exceeding 3 months.',
          'After two years of use or where deterioration exists, seek manufacturer advice.',
        ],
        documents: [
          'Net certificate',
          'Installation/certification record',
          'Weekly inspection record',
          'Test-cord test record',
          'Manufacturer data',
        ],
        hazards: [
          'Net tear',
          'Excessive fall distance',
          'Weak anchorage',
          'Damaged mesh',
          'Heat/chemical damage',
        ],
        controls: [
          'Competent installation',
          'Correct mesh',
          'Certified framework',
          'Periodic test',
          'Controlled storage',
        ],
        inspection: [
          'Check net label, certificate, mesh, border rope, connections, test-cord status and framework.',
        ],
      ),
      AbuDhabiCopSection(
        number: '20.0',
        title: 'Safety Net Care, Damage Prevention and Storage',
        requirements: [
          'Remove tools, scrap, equipment and other materials that fall into a safety net as soon as reasonably practicable and at least before the next shift.',
          'Do not stack materials on a net or deliberately jump onto or drop objects into it.',
          'Avoid dragging nets over rough surfaces, contact with sharp edges, debris accumulation, welding/burning sparks, hot gases, hot ash and chemical spills/leaks.',
          'Wash nets when required and before storage to remove grit/soot; if contaminated with acids/alkalis, wash appropriately and dry naturally away from heat.',
          'Dry wet nets naturally; ventilate storage; hang nets where reasonably practicable and allow air circulation.',
        ],
        measurements: [
        ],
        documents: [
          'Net cleaning record',
          'Storage inspection',
          'Contamination record',
        ],
        hazards: [
          'Abrasion',
          'Ignition damage',
          'Chemical contamination',
          'Poor storage',
        ],
        controls: [
          'Controlled handling',
          'Cleaning',
          'Ventilated storage',
          'Manufacturer advice',
        ],
        inspection: [
          'Inspect after storage and after contamination or suspected damage.',
        ],
      ),
      AbuDhabiCopSection(
        number: '21.0',
        title: 'Fall-Arrest Equipment — Detailed Inspection Frequencies',
        requirements: [
          'Remove defective equipment from service, tag it \'Out of Service\' and do not use until repaired and tested or replaced.',
          'After a fall arrest, inspect and test every item involved before reuse; replace stretched or damaged items.',
          'Users inspect harnesses, lanyards, connectors, fall-arrest devices, ropes, slings and mobile attachment devices before and after each use.',
          'Inspection shall include touch as well as sight, accessible internal components, rope/line protectors, locking mechanisms and running ropes through the hands where applicable.',
          'Maintain hardware and mechanical devices according to manufacturer instructions; clean synthetic textile materials using mild soap and water unless the manufacturer requires otherwise.',
          'Store and transport equipment to avoid dampness, heat and stress.',
        ],
        measurements: [
          'Belts, harnesses and lanyards: competent inspection every 6 months.',
          'Anchorages: inspect/certify before first use after installation and every 12 months thereafter by qualified personnel.',
          'Fall-arrest devices: competent inspection every 3 months.',
          'Horizontal/vertical lifelines and rails: inspection every 12 months.',
          'Slings: inspect every 3 months and test every 12 months by a competent testing organization.',
          'Ropes used to suspend a person: before/after each use and every 3 months; ropes are not pull tested.',
          'Fall-arrest devices stored longer than 12 months: full service before use.',
        ],
        documents: [
          'Inspection register',
          'Out-of-service tags',
          'Test certificates',
          'Service records',
        ],
        hazards: [
          'Hidden damage',
          'Expired inspection',
          'Post-fall reuse',
          'Corrosion',
        ],
        controls: [
          'Pre-use inspection',
          'Periodic competent inspection',
          'Segregation',
          'Manufacturer maintenance',
        ],
        inspection: [
          'Audit serial/ID, inspection date, inspector competency and corrective action.',
        ],
      ),
      AbuDhabiCopSection(
        number: '22.0',
        title: 'Working Platforms, Stairs and Fixed Access',
        requirements: [
          'Every open-sided floor or platform 1.2 m or more above adjacent floor/ground shall have standard railing on open sides except at entrances to ramps, stairways or fixed ladders.',
          'Provide toe boards where employees can pass, moving machinery is present, or falling materials could create a hazard.',
          'Every runway 1.2 m or more above floor/ground shall have standard railing on all open sides; toe boards are required where tools, machine parts or materials may be used.',
          'Regardless of height, guard open-sided floors, walkways, platforms or runways above/adjacent to dangerous equipment, open tanks and similar hazards.',
          'Stairs with four or more risers require standard stair railings/handrails as specified.',
          'Provide fixed stairs where regular travel between levels or routine access to operating platforms is required, including daily/shift access.',
        ],
        measurements: [
          'Open-sided platform threshold: 1.2 m.',
          'Standard railing nominal height: 950 mm.',
          'Top-rail load: at least 90 kg in any direction at any point.',
          'Standard stair railing: 760–860 mm.',
          'Stair overhead clearance: minimum 2.1 m.',
          'Specified open runway with one side omitted: minimum 45 cm width plus appropriate fall protection.',
        ],
        documents: [
          'Platform inspection',
          'Stair inspection',
          'Fixed-access design',
        ],
        hazards: [
          'Falls',
          'Falling materials',
          'Dangerous equipment exposure',
          'Head strike',
        ],
        controls: [
          'Guardrails',
          'Toe boards',
          'Handrails',
          'Fixed stairs',
        ],
        inspection: [
          'Verify dimensions and conditions after alteration or relocation.',
        ],
      ),
      AbuDhabiCopSection(
        number: '23.0',
        title: 'Fragile Surfaces, Unprotected Edges and Roof Protection',
        requirements: [
          'Provide appropriate platforms, coverings, guardrails and other measures when work is performed on or near fragile surfaces.',
          'Where residual fall risk remains, minimize the distance and effect of the fall as far as reasonably practicable.',
          'Make people aware of fragile-surface danger, preferably using prominent warning notices at approaches.',
          'Employees on unprotected sides/edges 2 m or more above a lower level shall use the specified fall-protection systems.',
          'Protect people above dangerous equipment regardless of height using guardrails or equipment guards.',
          'Low-slope roof protection may use specified combinations of guardrail, safety net, personal fall arrest, warning-line and safety-monitoring systems; for roofs 15.25 m or less in width, safety monitoring alone is permitted in the stated circumstances.',
          'Steep roofs 2 m or more above lower levels require guardrails with toe boards, safety nets or personal fall arrest.',
        ],
        measurements: [
          'Unprotected edge threshold: 2 m.',
          'Low-slope roof width exception: 15.25 m or less for the specified safety-monitoring-only arrangement.',
        ],
        documents: [
          'Roof risk assessment',
          'Fragile-surface register',
          'Warning signage',
          'Fall Prevention Plan',
        ],
        hazards: [
          'Fragile roof',
          'Skylights',
          'Open edges',
          'Dangerous equipment',
        ],
        controls: [
          'Collective protection',
          'Warning systems',
          'Fall arrest',
          'Exclusion zones',
        ],
        inspection: [
          'Pre-start roof inspection and post-weather/event inspection.',
        ],
      ),
    fieldChecklist: [
      'Fall Prevention Plan approved and briefed.',
      'Competent workers assigned.',
      'Rescue arrangements ready.',
      'Collective protection installed where practicable.',
      'Fall-arrest equipment compatible and inspected.',
      'Openings/edges/fragile surfaces controlled.',
      'Falling-object exclusion zones established.',
      'Required inspections current.',
      'Roof weather conditions assessed.',
    ],
    stopWorkIndicators: [
      'No effective fall protection at an exposed edge.',
      'Rescue plan/equipment unavailable.',
      'Fall-arrest equipment damaged or out of inspection.',
      'Guardrail unstable or missing.',
      'Fragile surface uncontrolled.',
      'Required exclusion zone breached.',
      'Weather makes the work unsafe.',
    ],
    references: [
      'ADPHC Code of Practices registry — CoP 23.0.',
      'ADOSH-SF CoP 23.0 — Working at Height, Version 4.1, 16 February 2026.',
    ],
    verificationNote:
        'Content is structured from the official ADPHC/ADOSH-SF Code of Practice and should be used with the current official document, applicable law, authority requirements, risk assessment and manufacturer instructions.',
  );
  static const cop240LockoutTagout = AbuDhabiCopDocument(
    code: 'CoP 24.0',
    title: 'Lock-out / Tag-out (Isolation)',
    version: '4.1',
    effectiveDate: '16 February 2026',
    introduction:
        'Sets minimum performance requirements for controlling hazardous energy during servicing and maintenance where unexpected energization, startup or release of stored energy could cause injury.',
    sections: [
      AbuDhabiCopSection(
        number: '1.0',
        title: 'Scope, Purpose and Hazardous Energy',
        requirements: [
          'Applies to servicing and maintenance where unexpected energization/start-up or release of stored energy could injure employees.',
          'Establish an energy-control program using assessment, controls, procedures, training and periodic inspection.',
          'Normal production operations are generally outside this CoP unless guards/safety devices are bypassed or a worker enters the point of operation.',
          'Use the more stringent applicable regulatory requirement where requirements conflict.',
        ],
        measurements: [
        ],
        documents: [
          'Energy-control program',
          'Risk assessment',
          'Isolation procedure',
        ],
        hazards: [
          'Electrical',
          'Mechanical',
          'Hydraulic',
          'Pneumatic',
          'Thermal',
          'Chemical',
          'Gravity/stored energy',
        ],
        controls: [
          'Isolation',
          'Lockout/tagout',
          'Blocking',
          'Dissipation',
        ],
        inspection: [
          'Confirm every hazardous energy source is identified before maintenance starts.',
        ],
      ),
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Applicability and Exclusions',
        requirements: [
          'The CoP does not apply to cord-and-plug equipment where unplugging and exclusive control of the plug by the servicing employee controls unexpected energization.',
          'Hot tap operations on pressurized gas, steam, water or petroleum systems are outside the standard only when the stated conditions are demonstrated: continuity is essential, shutdown is impractical, and documented procedures/special equipment provide effective protection.',
          'Do not use an exclusion to bypass energy-control requirements without verifying all conditions.',
        ],
        measurements: [
        ],
        documents: [
          'Exclusion assessment',
          'Hot-tap procedure',
          'Risk assessment',
        ],
        hazards: [
          'False exclusion',
          'Unexpected startup',
          'Pressure release',
        ],
        controls: [
          'Documented justification',
          'Specialized procedure',
          'Competent personnel',
        ],
        inspection: [
          'Verify exclusion conditions before accepting alternative controls.',
        ],
      ),
      AbuDhabiCopSection(
        number: '3.0',
        title: 'Roles, Authorized, Affected and Other Employees',
        requirements: [
          'Provide appropriate training for employees who apply/remove locks and tags, employees who work on equipment subject to LOTO, and other employees who may work in affected areas.',
          'Authorized employees need knowledge of hazardous energy sources, magnitude/types of energy, isolation devices and control methods.',
          'Affected and other employees shall understand the purpose of the program and prohibition against restarting locked/tagged equipment.',
          'Maintain a current list of authorized persons.',
        ],
        measurements: [
        ],
        documents: [
          'Authorized-person list',
          'Training records',
          'Role matrix',
        ],
        hazards: [
          'Unauthorized isolation',
          'Restart attempt',
          'Role confusion',
        ],
        controls: [
          'Defined roles',
          'Competency verification',
          'Communication',
        ],
        inspection: [
          'Interview workers and compare authorization list with actual practice.',
        ],
      ),
      AbuDhabiCopSection(
        number: '4.0',
        title: 'Planning, Risk Assessment and Energy Survey',
        requirements: [
          'Assess each site/operation to identify hazardous energy and develop an energy-control program where required.',
          'Identify all energy sources, isolation points, stored energy and possible alternate feeds.',
          'For construction, integrate LOTO requirements into the applicable pre-tender plan and OSH-CMP.',
          'Coordinate contractors and affected operations before isolation.',
        ],
        measurements: [
        ],
        documents: [
          'Energy survey',
          'Risk assessment',
          'Pre-tender HSE plan',
          'OSH-CMP',
        ],
        hazards: [
          'Backfeed',
          'Multiple sources',
          'Stored energy',
          'Contractor interface',
        ],
        controls: [
          'Energy map',
          'Isolation plan',
          'Coordination meeting',
        ],
        inspection: [
          'Walk the equipment and verify drawings against the actual installation.',
        ],
      ),
      AbuDhabiCopSection(
        number: '5.0',
        title: 'Energy-Control Procedure Content',
        requirements: [
          'Each procedure shall clearly state its scope, purpose, authorization, rules and techniques.',
          'Specify shutdown, isolation, blocking and securing steps.',
          'Specify placement, removal and transfer responsibilities for locks/tags.',
          'Specify how isolation effectiveness is tested and verified.',
          'Specify multiple-lock/multiple-task arrangements where required.',
          'Specify removal and restoration steps.',
        ],
        measurements: [
        ],
        documents: [
          'Machine-specific LOTO procedure',
          'Isolation certificate',
          'Manufacturer information',
        ],
        hazards: [
          'Incomplete procedure',
          'Wrong isolation point',
          'Uncontrolled restoration',
        ],
        controls: [
          'Machine-specific steps',
          'Verification',
          'Controlled restoration',
        ],
        inspection: [
          'Compare the written procedure with the actual equipment.',
        ],
      ),
      AbuDhabiCopSection(
        number: '6.0',
        title: 'Shutdown and Isolation Sequence',
        requirements: [
          'Prepare affected personnel before shutdown.',
          'Identify the equipment and all energy sources.',
          'Shut down using the normal stopping method.',
          'Operate energy-isolating devices to isolate the equipment from the energy source.',
          'Apply locks/tags and secure the isolation.',
          'Block or restrain components where gravity or stored mechanical energy can move them.',
          'Release, drain, vent, discharge or otherwise render stored energy safe as applicable.',
        ],
        measurements: [
        ],
        documents: [
          'Shutdown checklist',
          'Isolation certificate',
          'Lock/tag register',
        ],
        hazards: [
          'Unexpected movement',
          'Pressure',
          'Stored electrical energy',
          'Gravity',
        ],
        controls: [
          'Controlled shutdown',
          'Isolation',
          'Blocking',
          'Dissipation',
        ],
        inspection: [
          'Verify each isolation point physically where practicable.',
        ],
      ),
      AbuDhabiCopSection(
        number: '7.0',
        title: 'Lockout Requirements',
        requirements: [
          'When an energy-isolating device is capable of being locked out, the energy-control measures shall use lockout.',
          'Provide appropriate locks, tags, chains or other hardware.',
          'Lockout/tagout devices shall be individually identified and used only for energy control.',
          'Locks and devices shall withstand the environmental conditions in which they are used.',
        ],
        measurements: [
        ],
        documents: [
          'Lock register',
          'Authorized-person register',
          'Isolation hardware specification',
        ],
        hazards: [
          'Wrong lock',
          'Shared control',
          'Device failure',
        ],
        controls: [
          'Personal identification',
          'Durable devices',
          'Controlled hardware',
        ],
        inspection: [
          'Check identification and condition of every lock.',
        ],
      ),
      AbuDhabiCopSection(
        number: '8.0',
        title: 'Tagout Requirements and Tag Limitations',
        requirements: [
          'When an energy-isolating device cannot be locked out, use tagout.',
          'When tagout is used on a device that can be locked, the tag shall be located where the lock would have been and the employer shall demonstrate equivalent safety.',
          'Tags are warning devices and do not provide the physical restraint of a lock.',
          'Tags shall not be removed without authorization and shall never be bypassed, ignored or defeated.',
        ],
        measurements: [
          'Tags shall be legible and printed in Arabic and English plus other language(s) necessary for understanding.',
        ],
        documents: [
          'Tag specification',
          'Tagout procedure',
          'Tag register',
        ],
        hazards: [
          'False security',
          'Illegible tag',
          'Unauthorized removal',
        ],
        controls: [
          'Durable tags',
          'Clear warning',
          'Equivalent-safety demonstration',
        ],
        inspection: [
          'Check language, legibility, attachment and authorization.',
        ],
      ),
      AbuDhabiCopSection(
        number: '9.0',
        title: 'Verification of Isolation and Test for Effectiveness',
        requirements: [
          'Test the equipment to determine and verify the effectiveness of locks, tags and other energy-control measures.',
          'Use an appropriate test method for the energy involved.',
          'After attempting the test, return controls to the required safe position before work begins.',
          'Do not begin maintenance until isolation is verified and stored energy is controlled.',
        ],
        measurements: [
        ],
        documents: [
          'Isolation verification record',
          'Test instrument record',
          'Energy-control procedure',
        ],
        hazards: [
          'Residual energy',
          'False zero',
          'Backfeed',
        ],
        controls: [
          'Try-start/test',
          'Measurement where applicable',
          'Dissipation',
        ],
        inspection: [
          'Observe the verification step rather than relying on a signed form alone.',
        ],
      ),
      AbuDhabiCopSection(
        number: '10.0',
        title: 'Multiple Energy Sources and Multiple Tasks',
        requirements: [
          'Procedures shall address multiple lockout/tagout devices when multiple tasks are undertaken.',
          'Ensure every worker requiring protection has control through the applicable lockout arrangement.',
          'Coordinate handover between shifts, teams and contractors so protection is not lost.',
          'Do not remove another person\'s lock except through the documented authorized process.',
        ],
        measurements: [
        ],
        documents: [
          'Group isolation procedure',
          'Handover record',
          'Lock register',
        ],
        hazards: [
          'Premature removal',
          'Unprotected worker',
          'Shift handover failure',
        ],
        controls: [
          'Controlled group isolation',
          'Personal control',
          'Formal handover',
        ],
        inspection: [
          'Reconcile locks with personnel before restoration.',
        ],
      ),
      AbuDhabiCopSection(
        number: '11.0',
        title: 'Stored Energy, Blocking and Restraint',
        requirements: [
          'Control stored or residual energy after isolation.',
          'Block, restrain or otherwise secure components that could move under gravity or stored force.',
          'Consider pressure, elevated components, springs, flywheels, capacitors, hydraulic/pneumatic accumulators and thermal/chemical energy as applicable.',
          'Recheck stored energy after a delay where the hazard can reaccumulate.',
        ],
        measurements: [
        ],
        documents: [
          'Energy-dissipation checklist',
          'Blocking certificate',
          'Test records',
        ],
        hazards: [
          'Unexpected movement',
          'Pressure release',
          'Hot/cold energy',
          'Reaccumulation',
        ],
        controls: [
          'Bleeding',
          'Venting',
          'Grounding where applicable',
          'Blocking/chocking',
        ],
        inspection: [
          'Verify zero/controlled energy using task-appropriate methods.',
        ],
      ),
      AbuDhabiCopSection(
        number: '12.0',
        title: 'Maintenance, Cleaning and Point-of-Operation Work',
        requirements: [
          'Apply LOTO to servicing, maintenance, inspection or cleaning where unexpected startup/release could cause injury.',
          'Production operations are covered when guards/safety devices are removed/bypassed or a worker enters the point of operation.',
          'Coordinate cleaning and maintenance with operations so no automatic or remote restart can occur.',
        ],
        measurements: [
        ],
        documents: [
          'Maintenance permit',
          'LOTO procedure',
          'Cleaning procedure',
        ],
        hazards: [
          'Moving parts',
          'Automatic restart',
          'Remote control',
        ],
        controls: [
          'Isolation',
          'Guard restoration',
          'Controlled restart',
        ],
        inspection: [
          'Check machine status and remote/automatic control interfaces.',
        ],
      ),
      AbuDhabiCopSection(
        number: '13.0',
        title: 'Equipment Modification and New Installations',
        requirements: [
          'When machines are newly installed or undergo major repair, renovation or modification, energy-isolating devices shall be designed to accept lockout.',
          'Design isolation points so workers can safely identify and control hazardous energy.',
          'Update machine-specific procedures after modifications.',
        ],
        measurements: [
        ],
        documents: [
          'Design documentation',
          'Updated drawings',
          'LOTO procedure revision',
        ],
        hazards: [
          'New energy source',
          'Inaccessible isolator',
          'Obsolete procedure',
        ],
        controls: [
          'Design-for-isolation',
          'Updated energy map',
          'Change management',
        ],
        inspection: [
          'Verify isolation devices are accessible, identifiable and lockable where required.',
        ],
      ),
      AbuDhabiCopSection(
        number: '14.0',
        title: 'Annual Periodic Inspection and Program Audit',
        requirements: [
          'Conduct a periodic inspection of energy-control measures/procedures annually.',
          'The inspector shall be competent and shall not be one of the employees using the energy-control procedure being inspected.',
          'Verify the procedure, locks/tags, training, role allocation and practical application.',
          'Record findings and corrective actions.',
        ],
        measurements: [
          'Periodic inspection: annually.',
        ],
        documents: [
          'Annual inspection record',
          'Corrective-action register',
          'Training records',
        ],
        hazards: [
          'Self-inspection bias',
          'Repeated deviations',
          'Outdated procedure',
        ],
        controls: [
          'Independent competent inspection',
          'Corrective action',
          'Program review',
        ],
        inspection: [
          'Sample actual isolations against the written procedure.',
        ],
      ),
      AbuDhabiCopSection(
        number: '15.0',
        title: 'Training Records and Competency',
        requirements: [
          'Train authorized employees in hazardous energy recognition, types/magnitude of energy, isolation devices and energy-control methods.',
          'Train affected employees in the purpose and use of the procedure.',
          'Train other employees in the procedure and prohibition on restarting locked/tagged equipment.',
          'Provide refresher training after job changes, equipment/process changes, energy-control changes, inspection findings or deficiencies.',
          'Training shall be in a common understandable language and understood by participants.',
        ],
        measurements: [
        ],
        documents: [
          'Training records',
          'Competency assessment',
          'Refresher records',
        ],
        hazards: [
          'Language barrier',
          'Inadequate competency',
          'Changed equipment',
        ],
        controls: [
          'Practical training',
          'Refresher training',
          'Understanding verification',
        ],
        inspection: [
          'Check training records for employee classification, date and trainer.',
        ],
      ),
      AbuDhabiCopSection(
        number: '16.0',
        title: 'Records, Documentation and Manufacturer Information',
        requirements: [
          'Maintain records demonstrating periodic inspections.',
          'Records shall include training records, authorized-person list, equipment/machine covered, inspection date, employees included and inspector identity.',
          'Maintain manufacturer catalogues/information needed for the energy-control procedure.',
          'Keep current procedures accessible to workers.',
        ],
        measurements: [
        ],
        documents: [
          'Periodic inspection record',
          'Authorized-person list',
          'Manufacturer catalogue',
          'Machine-specific procedures',
        ],
        hazards: [
          'Missing evidence',
          'Obsolete information',
          'Poor document control',
        ],
        controls: [
          'Controlled documents',
          'Record retention',
          'Revision control',
        ],
        inspection: [
          'Audit a machine from field to procedure, training and inspection records.',
        ],
      ),
      AbuDhabiCopSection(
        number: '17.0',
        title: 'Restoration, Removal and Return to Service',
        requirements: [
          'Before removing locks/tags, verify work is complete, tools/materials are removed and personnel are clear.',
          'Replace guards and safety devices required for normal operation.',
          'Notify affected personnel before reenergization.',
          'Remove locks/tags only by the responsible employee or through the entity\'s documented authorized removal process.',
          'Restore energy in a controlled sequence and verify safe operation.',
        ],
        measurements: [
        ],
        documents: [
          'Return-to-service checklist',
          'Permit close-out',
          'Lock removal record',
        ],
        hazards: [
          'Unexpected startup',
          'Missing guard',
          'Personnel exposure',
        ],
        controls: [
          'Personnel accountability',
          'Guard restoration',
          'Controlled reenergization',
        ],
        inspection: [
          'Conduct a final walkdown before energization.',
        ],
      ),
      AbuDhabiCopSection(
        number: '18.0',
        title: 'Practical LOTO Scenarios and Stop-Work Conditions',
        requirements: [
          'Example — pump maintenance: isolate electrical supply, control pressure/flow, drain stored pressure and verify isolation before opening the system.',
          'Example — conveyor cleaning: isolate drive energy and prevent stored movement; do not rely on an emergency stop as the isolation.',
          'Example — hydraulic equipment: isolate hydraulic power and control accumulator/stored pressure before entering the hazard zone.',
          'Example — electrical panel work: use the electrical isolation procedure and verify absence of hazardous energy with suitable equipment.',
          'Stop work when an isolation point is unidentified, inaccessible, cannot be verified, a lock is missing, energy reappears, or personnel cannot be accounted for.',
        ],
        measurements: [
        ],
        documents: [
          'LOTO checklist',
          'Isolation certificate',
          'Emergency response procedure',
        ],
        hazards: [
          'Unverified isolation',
          'Reenergization',
          'Stored energy',
          'Missing lock',
        ],
        controls: [
          'Stop work',
          'Reassessment',
          'Re-isolation',
          'Formal authorization',
        ],
        inspection: [
          'Supervisor shall verify corrective action before work resumes.',
        ],
      ),
    ],
      AbuDhabiCopSection(
        number: '19.0',
        title: 'LOTO Procedure — Required Step-by-Step Content',
        requirements: [
          'Each hazardous-energy procedure shall state its intended use, scope, purpose, authorization, rules and techniques.',
          'Specify exact steps for shutting down, isolating, blocking and securing the machine/equipment.',
          'Specify placement, removal and transfer of lockout/tagout devices and who is responsible.',
          'Specify the test method used to verify effectiveness of isolation controls.',
          'Address multiple lockout/tagout devices where multiple tasks are undertaken.',
          'Specify how devices are removed and equipment is restored to normal operation.',
        ],
        measurements: [
        ],
        documents: [
          'Machine-specific LOTO procedure',
          'Isolation certificate',
          'Test/verification record',
          'Restoration checklist',
        ],
        hazards: [
          'Wrong sequence',
          'Missing isolation point',
          'Premature restoration',
        ],
        controls: [
          'Written procedure',
          'Machine-specific isolation',
          'Verification',
          'Controlled restoration',
        ],
        inspection: [
          'Compare procedure step-by-step with actual field practice.',
        ],
      ),
      AbuDhabiCopSection(
        number: '20.0',
        title: 'LOTO Hardware, Tag Construction and Environmental Suitability',
        requirements: [
          'Provide appropriate locks, tags, chains and other hardware for isolating, securing or blocking equipment.',
          'Locks/devices shall be standardized and durable for the workplace environment.',
          'Tags are warning devices and do not provide the physical restraint of a lock.',
          'Tags shall not be removed without authorization and shall never be bypassed, ignored or defeated.',
          'Tags shall be securely attached so they cannot be accidentally detached.',
        ],
        measurements: [
          'Tags shall be legible and printed in Arabic and English plus other languages necessary for workforce understanding.',
          'Tags shall resist weather, wet/damp conditions and corrosive environments.',
          'Lockout/tagout devices shall be robust enough to withstand adverse/forceful conditions.',
        ],
        documents: [
          'Lock/tag specification',
          'Lock register',
          'Tag inspection record',
        ],
        hazards: [
          'Illegible tag',
          'Corrosion',
          'Accidental detachment',
          'False physical security',
        ],
        controls: [
          'Durable devices',
          'Correct language',
          'Secure attachment',
          'Personal control',
        ],
        inspection: [
          'Inspect devices in the actual environmental conditions where they are used.',
        ],
      ),
      AbuDhabiCopSection(
        number: '21.0',
        title: 'LOTO — New Equipment, Modification and Design',
        requirements: [
          'When new machines/equipment are installed, or major repair, renovation or modification occurs, energy-isolating devices shall be designed to accept a lockout device.',
          'Update energy-control procedures after modifications or new energy sources.',
          'Do not rely on obsolete drawings or procedures after equipment change.',
        ],
        measurements: [
        ],
        documents: [
          'Design drawings',
          'Energy-isolation points',
          'Updated procedure',
          'Change record',
        ],
        hazards: [
          'New energy source',
          'Inaccessible isolator',
          'Obsolete isolation plan',
        ],
        controls: [
          'Design for lockability',
          'Change management',
          'Updated energy survey',
        ],
        inspection: [
          'Physically verify new/modified isolation points before return to service.',
        ],
      ),
      AbuDhabiCopSection(
        number: '22.0',
        title: 'LOTO Planning for Construction and Contractors',
        requirements: [
          'Assess risks to employees, contractors and the public.',
          'For Building and Construction Sector, include LOTO requirements in the Pre-Tender Health and Safety Plan.',
          'Include associated safe systems of work and site rules in the OSH-CMP.',
          'Coordinate contractor isolation responsibilities and verify competence before work.',
        ],
        measurements: [
        ],
        documents: [
          'Pre-Tender H&S Plan',
          'OSH-CMP',
          'Contractor RAMS',
          'Isolation responsibility matrix',
        ],
        hazards: [
          'Interface failure',
          'Conflicting isolations',
          'Unauthorized reenergization',
        ],
        controls: [
          'Coordination',
          'Written responsibility',
          'Joint verification',
        ],
        inspection: [
          'Audit contractor isolations against the site energy-control program.',
        ],
      ),
      AbuDhabiCopSection(
        number: '23.0',
        title: 'LOTO Annual Inspection and Record-Keeping',
        requirements: [
          'Conduct a periodic inspection of energy-control measures/procedures annually.',
          'The inspection shall be performed by a competent employee other than the employee(s) using the procedure being inspected.',
          'Maintain records showing training, authorized persons, machine/equipment covered, inspection date, employees included, inspector and manufacturer catalogue information.',
          'Use findings to correct procedure, training or hardware deficiencies.',
        ],
        measurements: [
          'Periodic inspection: annually.',
        ],
        documents: [
          'Annual inspection record',
          'Training records',
          'Authorized-person list',
          'Machine/equipment identification',
          'Manufacturer catalogue',
        ],
        hazards: [
          'Independent review failure',
          'Repeated deviation',
          'Missing records',
        ],
        controls: [
          'Competent independent inspection',
          'Corrective action',
          'Document control',
        ],
        inspection: [
          'Verify the annual inspection record contains all required elements.',
        ],
      ),
      AbuDhabiCopSection(
        number: '24.0',
        title: 'LOTO Field Examples and Stop-Work Conditions',
        requirements: [
          'Example — conveyor: stop normally, isolate all drive energy, lock the isolator, control stored motion and verify the conveyor cannot start before entry.',
          'Example — hydraulic press: isolate hydraulic supply, secure moving parts, control stored accumulator pressure and verify before maintenance.',
          'Example — electrical maintenance: identify all supplies/backfeeds, isolate, lock/tag and perform the required test to verify the energy-control measures.',
          'Example — cleaning with automatic start: isolate the machine before entering the danger area; an emergency stop is not treated as the energy isolation unless the applicable procedure specifically establishes the required isolation.',
          'Stop work if an energy source is unidentified, isolation cannot be verified, a lock/tag is missing or defective, energy reappears, or personnel cannot be accounted for.',
        ],
        measurements: [
        ],
        documents: [
          'Machine-specific LOTO checklist',
          'Isolation certificate',
          'Test record',
          'Return-to-service record',
        ],
        hazards: [
          'Unexpected startup',
          'Backfeed',
          'Stored energy',
          'Unauthorized restoration',
        ],
        controls: [
          'Stop work',
          'Reassessment',
          'Re-isolation',
          'Formal authorization',
        ],
        inspection: [
          'Supervisor verifies the condition is safe before work resumes.',
        ],
      ),
    fieldChecklist: [
      'Energy sources identified.',
      'Machine-specific isolation procedure available.',
      'Authorized/affected employees trained.',
      'Isolation devices applied correctly.',
      'Stored energy controlled.',
      'Isolation effectiveness verified.',
      'Locks/tags identified and legible.',
      'Group/shift arrangements controlled.',
      'Annual inspection completed.',
      'Return-to-service sequence controlled.',
    ],
    stopWorkIndicators: [
      'Energy source cannot be identified or isolated.',
      'Isolation cannot be verified.',
      'Equipment can unexpectedly restart.',
      'Stored energy remains uncontrolled.',
      'Another worker\'s lock is removed without authorization.',
      'Defective or illegible lock/tag is used.',
      'Personnel cannot be accounted for before reenergization.',
    ],
    references: [
      'ADPHC Code of Practices registry — CoP 24.0.',
      'ADOSH-SF CoP 24.0 — Lock-out / Tag-out (Isolation), Version 4.1, 16 February 2026.',
    ],
    verificationNote:
        'Content is structured from the official ADPHC/ADOSH-SF Code of Practice and should be used with the current official document, applicable law, authority requirements, risk assessment and manufacturer instructions.',
  );
}
