import 'package:flutter/material.dart';

/// SafeNexus HSE — Abu Dhabi Interview Questionnaire
/// Source-based set: 40 questions from the user's HSE written questionnaire.
/// Each item contains Model Answer, Technical Explanation and Practical Site Example.
/// Regulatory values and deadlines requiring current authority/project confirmation are
/// explicitly qualified rather than invented.

class InterviewQuestion {
  final int number;
  final String question;
  final String modelAnswer;
  final String technicalExplanation;
  final String practicalSiteExample;

  const InterviewQuestion({
    required this.number,
    required this.question,
    required this.modelAnswer,
    required this.technicalExplanation,
    required this.practicalSiteExample,
  });
}

const List<InterviewQuestion> abuDhabiQuestionnaire40 = [
  InterviewQuestion(
    number: 1,
    question: 'What is ADOSH CoP and how many CoPs are there?',
    modelAnswer: 'ADOSH-SF means Abu Dhabi Occupational Safety and Health System Framework. A Code of Practice (CoP) sets topic-specific occupational safety and health requirements. The current number must be checked against the latest official ADPHC registry.',
    technicalExplanation: 'CoPs address subjects such as excavation, scaffolding, lifting, confined spaces and portable power tools. Use the current controlled revision applicable to the project; do not rely on an old count.',
    practicalSiteExample: 'Before excavation, the HSE Officer checks the current excavation CoP, the project procedure, permit conditions and approved method statement, then briefs the workforce.',
  ),
  InterviewQuestion(
    number: 2,
    question: 'State the five steps of the hierarchy of risk control in order.',
    modelAnswer: '1. Elimination. 2. Substitution. 3. Engineering controls. 4. Administrative controls. 5. Personal protective equipment (PPE).',
    technicalExplanation: 'Controls are ranked by their ability to reduce exposure at source. PPE depends on correct selection, fit, maintenance and worker use, so it is generally the last line of defence.',
    practicalSiteExample: 'For cutting, first consider eliminating the cut or using a pre-cut item, then a lower-risk process, guarding and extraction, safe procedures and training, and finally suitable eye and hearing protection.',
  ),
  InterviewQuestion(
    number: 3,
    question: 'Give the ADOSH CoP numbers for confined space, lifting, excavation, electrical, first aid, traffic management and power tools.',
    modelAnswer: 'Commonly referenced ADPHC topics include Confined Spaces 27.0, Excavation Work 29.0, Portable Power Tools 35.0, and Safe Use of Lifting Equipment and Accessories 34.0. First Aid is commonly referenced as CoP 4.0. Confirm current titles and numbering in the official registry. Verify the applicable electrical and traffic-management CoPs rather than guessing.',
    technicalExplanation: 'CoP numbers and titles can be revised or restructured. Roadside work may involve a separate road/traffic CoP and authority-approved traffic management requirements.',
    practicalSiteExample: 'The HSE team keeps a controlled regulatory register with title, number, revision, applicability and source link, and checks it during document review.',
  ),
  InterviewQuestion(
    number: 4,
    question: 'Name six main hazards in infrastructure or road projects.',
    modelAnswer: '1. Live traffic and moving plant. 2. Excavation collapse. 3. Underground utility strikes. 4. Lifting and suspended loads. 5. Electrical hazards. 6. Heat stress and dehydration.',
    technicalExplanation: 'Risk depends on work phase, public interface, visibility, ground conditions, utility information, plant routes and environmental conditions. Dust, noise, falls and reversing vehicles may also be significant.',
    practicalSiteExample: 'During road widening, establish a protected work zone, approved diversion, utility verification, plant/pedestrian segregation, excavation protection and heat controls before work begins.',
  ),
  InterviewQuestion(
    number: 5,
    question: 'What RCD value is used for an electrical DB supplying portable hand tools?',
    modelAnswer: 'A 30 mA RCD is commonly specified for additional protection of portable 240 V tools, subject to the current applicable CoP, design and project electrical procedure.',
    technicalExplanation: 'An RCD detects residual current imbalance and disconnects supply to reduce electric-shock risk. It does not replace earthing, inspection, suitable voltage selection or safe isolation.',
    practicalSiteExample: 'Before use, a competent electrician verifies the distribution board protection and test arrangements; the operator checks tool, cable and plug condition and reports defects.',
  ),
  InterviewQuestion(
    number: 6,
    question: 'What is the unit of earthing resistance and what is the desired value?',
    modelAnswer: 'Earthing resistance is measured in ohms (Ω). There is no single universal target for every installation; acceptance depends on the earthing arrangement, protective-device design, applicable standard and approved project specification.',
    technicalExplanation: 'A competent electrical person must verify earth continuity, bonding, test results and protective-device operation. Never accept a value solely because it matches a generic rule of thumb.',
    practicalSiteExample: 'The HSE Officer checks that the generator or temporary DB has current test documentation and that defects are corrected before energization.',
  ),
  InterviewQuestion(
    number: 7,
    question: 'For a 10-metre excavation, state precautions from start to backfilling.',
    modelAnswer: 'Obtain permit and approved engineered method; review utility drawings and locate services; assess soil and groundwater; install engineered shoring, shielding or designed battering; provide safe access/egress; barricade and control plant/spoil loads; inspect by a competent person; manage water, atmosphere where relevant, and emergency rescue; backfill and compact in the approved sequence.',
    technicalExplanation: 'A deep excavation requires design based on geotechnical information, adjacent structures, surcharge, groundwater and construction sequence. Generic slope or setback values must not replace the engineered design.',
    practicalSiteExample: 'Before entry, the supervisor verifies the protective system inspection, access ladder, exclusion zone, utility clearance, dewatering and rescue arrangements at the excavation briefing.',
  ),
  InterviewQuestion(
    number: 8,
    question: 'What oxygen limits are commonly used, and what rescue equipment is needed for manholes and pipes?',
    modelAnswer: 'A commonly used screening range for oxygen is 19.5%–23.5%, but the approved confined-space procedure and applicable requirements govern. Rescue provisions may include a calibrated multi-gas detector, suitable harness, tripod/davit and retrieval winch where appropriate, communications, trained rescue team, breathing apparatus for trained rescuers, stretcher and first-aid equipment.',
    technicalExplanation: 'Atmospheric hazards can change during entry. Test before entry and monitor as required. Never conduct an unplanned entry rescue or rely on an untrained person entering to help.',
    practicalSiteExample: 'A standby attendant raises the alarm, prevents unauthorized entry, communicates with the entrant and activates the rehearsed non-entry retrieval or specialist rescue plan.',
  ),
  InterviewQuestion(
    number: 9,
    question: 'What is a KPI? Give three leading and three lagging indicators.',
    modelAnswer: 'KPI means Key Performance Indicator. Leading examples: planned inspections completed, toolbox talks/briefings completed, and corrective actions closed on time. Lagging examples: lost-time injuries, recordable injury cases and injury-related lost workdays.',
    technicalExplanation: 'Leading indicators track preventive activity; lagging indicators record outcomes. Measures should have clear definitions, owners, reporting periods and data quality checks.',
    practicalSiteExample: 'A monthly dashboard shows overdue high-risk actions alongside incident trends, allowing management to address weaknesses before another event occurs.',
  ),
  InterviewQuestion(
    number: 10,
    question: 'What is a critical lift?',
    modelAnswer: 'A critical lift is a lifting operation classified as high risk by the applicable project lifting procedure. Triggers may include high crane-capacity utilization, tandem lifting, lifting over occupied or operating areas, complex loads, restricted conditions or high-consequence failure.',
    technicalExplanation: 'Classification criteria are project-specific. A critical lift normally needs a detailed engineered lift plan, verified load data, competent roles, suitable equipment, ground assessment, exclusion zone and formal authorization.',
    practicalSiteExample: 'Before a tandem lift, the appointed lifting planner coordinates crane capacities, load-share assumptions, rigging, communication, sequence, weather limits and stop-work criteria.',
  ),
  InterviewQuestion(
    number: 11,
    question: 'Who is a Lifting Appointed Person and what certification is required?',
    modelAnswer: 'An Appointed Person is a competent person formally appointed to plan and manage lifting operations within the defined scope. Required certification or evidence of competence depends on the equipment, role, client and applicable project/regulatory requirements.',
    technicalExplanation: 'The role includes lift planning, crane/accessory selection, load and radius checks, ground conditions, roles, communication, risk controls and review of changing conditions. A certificate alone does not establish competence for every lift.',
    practicalSiteExample: 'The appointed person reviews the lift plan and site conditions, confirms the team understands the sequence, and stops or revises the operation if conditions differ from the plan.',
  ),
  InterviewQuestion(
    number: 12,
    question: 'Name four crane safety devices.',
    modelAnswer: 'Examples are Rated Capacity Limiter (RCL) or Load Moment Indicator (LMI), anti-two-block device, hoist limit switch and emergency stop. Other devices depend on crane type and configuration.',
    technicalExplanation: 'Safety devices supplement competent operation, inspection, load-chart compliance and a suitable lift plan. Never bypass or defeat a safety device.',
    practicalSiteExample: 'During pre-use checks, the operator tests required indicators and limits according to the manufacturer’s instructions and reports any malfunction before lifting.',
  ),
  InterviewQuestion(
    number: 13,
    question: 'What certification is required for a MEWP operator?',
    modelAnswer: 'The operator needs training and assessed competence for the relevant MEWP category, employer/client authorization, familiarization with the specific machine and training in emergency lowering and rescue arrangements.',
    technicalExplanation: 'Competence includes ground assessment, overhead hazards, load limits, fall-protection requirements, travel, exclusion zones and response to malfunction. Confirm the accepted certification scheme with the project.',
    practicalSiteExample: 'Before elevating, the supervisor verifies operator authorization, machine inspection, ground bearing, overhead clearance, rescue plan and communication.',
  ),
  InterviewQuestion(
    number: 14,
    question: 'Name three summer arrangements. What is TWL and the Midday Break?',
    modelAnswer: 'Provide potable water and shaded rest; implement heat-stress training, acclimatization and monitoring; and plan work/rest and emergency response. TWL means Thermal Work Limit, a heat-stress assessment method. UAE midday-break dates and hours are announced for each applicable season; verify the current official announcement and exemptions.',
    technicalExplanation: 'Heat controls should consider workload, clothing, humidity, radiant heat, worker acclimatization and symptoms. Do not assume a previous year’s midday-break dates apply to the current year.',
    practicalSiteExample: 'A site supervisor checks the approved heat-stress plan and current official restriction, adjusts work scheduling and ensures workers know how to report heat illness.',
  ),
  InterviewQuestion(
    number: 15,
    question: 'What is COSHH? Give four chemical-store requirements.',
    modelAnswer: 'COSHH means Control of Substances Hazardous to Health. Store chemicals with current Safety Data Sheets, compatible segregation, suitable secondary containment, and appropriate ventilation, labels, access control and emergency provisions.',
    technicalExplanation: 'The assessment must consider exposure routes, incompatibilities, ignition, spill response, PPE, storage quantities and waste. Apply the relevant UAE/project chemical and environmental requirements.',
    practicalSiteExample: 'An inspection finds oxidizers stored separately from flammables, containers labelled, spill kit available and workers able to access the SDS and emergency instructions.',
  ),
  InterviewQuestion(
    number: 16,
    question: 'State four key components of traffic detours on live roads.',
    modelAnswer: 'Use an approved Traffic Management Plan; provide advance warning and diversion signs; install barriers/cones and clear delineation; and provide safe pedestrian routes and controlled access. Include lighting, trained traffic controllers where required, emergency access and road-authority coordination.',
    technicalExplanation: 'The plan must address approach speeds, sight distance, work-zone layout, transitions, vulnerable road users, night conditions and changes in traffic phase.',
    practicalSiteExample: 'Before closing a lane, the team checks authority approval, sign sequence, barrier continuity, flagger position, pedestrian diversion and emergency vehicle access.',
  ),
  InterviewQuestion(
    number: 17,
    question: 'What are the colours of mandatory and prohibitory signs? Give two examples each.',
    modelAnswer: 'Mandatory signs are generally blue circular signs with white symbols: wear safety helmet; wear eye protection. Prohibition signs generally have a white background, red circular border and diagonal red bar: no smoking; no unauthorized entry.',
    technicalExplanation: 'Use standardized safety signs that are visible, maintained and understandable to the workforce. Signs supplement, but do not replace, physical controls and briefing.',
    practicalSiteExample: 'At a workshop entrance, display required PPE signs and no-smoking signs, while supervisors verify compliance and control ignition sources.',
  ),
  InterviewQuestion(
    number: 18,
    question: 'Name five scaffold components. Who inspects an erected scaffold before use?',
    modelAnswer: 'Components include standards, ledgers, transoms, bracing and working platforms with guardrails/toeboards as required. A competent scaffold inspector inspects the erected scaffold before use and at required intervals and after events that may affect integrity.',
    technicalExplanation: 'Inspection and tagging follow the applicable CoP, manufacturer/design requirements and project procedure. A tag is a status communication tool, not a substitute for inspection.',
    practicalSiteExample: 'Before access, the supervisor checks the scaffold tag/status, access ladder, platform, guardrails, ties, base condition and inspection record.',
  ),
  InterviewQuestion(
    number: 19,
    question: 'What is the difference between a rigger and an outrigger?',
    modelAnswer: 'A rigger is a trained person who selects/checks lifting accessories, attaches the load and guides lifting operations within assigned competence. An outrigger is a crane or plant support leg used to improve stability and transfer loads to the ground.',
    technicalExplanation: 'Rigger competence concerns people and lifting tasks; outrigger safety concerns equipment configuration, ground bearing, mats, level and manufacturer requirements.',
    practicalSiteExample: 'The rigger checks sling identification and attachment while the crane supervisor verifies outrigger extension, mats, ground condition and setup against the lift plan.',
  ),
  InterviewQuestion(
    number: 20,
    question: 'What is MMI? Give five control measures.',
    modelAnswer: 'The source questionnaire does not expand “MMI.” If it refers to manual material handling, controls include avoiding manual handling through mechanical aids, assessing load and route, team lifting where suitable, training in safe handling, and keeping loads close while avoiding twisting.',
    technicalExplanation: 'Assess load weight, size, grip, repetition, posture, distance, pushing/pulling force and individual capability. Confirm the intended meaning of MMI against the interviewer’s terminology.',
    practicalSiteExample: 'For moving heavy materials, use a trolley or lifting aid, clear the route, set down at waist height where practical and brief workers on coordinated movement.',
  ),
  InterviewQuestion(
    number: 21,
    question: 'What are six steps in accident investigation?',
    modelAnswer: '1. Make the area safe and arrange medical care. 2. Notify required parties and preserve the scene where safe. 3. Collect physical and documentary evidence. 4. Interview witnesses. 5. Identify immediate, underlying and root causes. 6. Assign corrective actions and verify effectiveness.',
    technicalExplanation: 'Investigation should be evidence-based and focus on prevention, including equipment, procedures, supervision, competence, planning and organizational factors—not blame alone.',
    practicalSiteExample: 'After a dropped object near miss, preserve the area, inspect the lifting arrangement, reconstruct the sequence, examine barriers and close actions with proof of effectiveness.',
  ),
  InterviewQuestion(
    number: 22,
    question: 'How would you rescue a tower crane operator during a medical emergency?',
    modelAnswer: 'Stop the operation and secure the load; raise the alarm and contact emergency responders; communicate with the operator; activate the approved tower-crane rescue plan; use trained rescue personnel and approved equipment; and arrange controlled evacuation and medical assessment.',
    technicalExplanation: 'The method must be planned for the crane configuration, access, weather, casualty condition and rescue-team capability. Do not improvise climbing or lowering methods.',
    practicalSiteExample: 'A site drill tests communication, rescue-team access, equipment readiness, ground exclusion, ambulance access and handover to medical personnel.',
  ),
  InterviewQuestion(
    number: 23,
    question: 'Name five worker welfare requirements.',
    modelAnswer: 'Potable drinking water; clean toilets and washing facilities; suitable rest areas and shade; first-aid/medical arrangements; and hygienic eating facilities. Also assess transport, accommodation, heat protection and worker feedback where applicable.',
    technicalExplanation: 'Welfare provisions should be adequate for workforce size, shift pattern, location, climate and applicable legal/project requirements, and must be inspected and maintained.',
    practicalSiteExample: 'A welfare inspection records water availability, toilet cleanliness, shaded rest capacity, hygiene, first-aid access and corrective-action owners.',
  ),
  InterviewQuestion(
    number: 24,
    question: 'What is the validity of a crane operator certificate and lifting gear certificate?',
    modelAnswer: 'Validity depends on the certificate type, issuing body, equipment, client/project rules and applicable requirements. Verify operator authorization and competency, equipment examination certificate, accessory identification, inspection due date and condition before use.',
    technicalExplanation: 'Do not assume one fixed validity period applies to all operators, cranes or accessories. Check the controlled register and original certification, including scope and limitations.',
    practicalSiteExample: 'Before a lift, the lifting supervisor checks operator documents, crane examination status, sling/shackle identification and inspection records, then rejects expired, damaged or untraceable items.',
  ),
  InterviewQuestion(
    number: 25,
    question: 'What is the legal requirement for first-aid and firefighting manpower percentage?',
    modelAnswer: 'Do not assume a universal percentage. Determine required competent first-aiders and firefighting personnel from current applicable legal/authority requirements, workforce and shift coverage, project risk assessment and approved emergency plan.',
    technicalExplanation: 'Adequacy depends on site size, work activities, remoteness, response time, simultaneous operations and availability across shifts. Verify exact statutory numbers from the current official source before quoting them.',
    practicalSiteExample: 'The emergency plan maps trained responders by work zone and shift, checks coverage during leave or night work and records drill performance.',
  ),
  InterviewQuestion(
    number: 26,
    question: 'What is the difference between task briefing and toolbox talk?',
    modelAnswer: 'A task briefing is job-specific and covers the work sequence, hazards, controls, roles and changing conditions immediately before work. A toolbox talk is a short safety-learning session on a selected topic, lesson learned or recurring risk.',
    technicalExplanation: 'Both require worker participation and confirmation of understanding. Re-brief when scope, personnel, equipment, weather or site conditions change.',
    practicalSiteExample: 'Before lifting, the team receives a task briefing on the lift plan and signals; the weekly toolbox talk may cover dropped-object prevention across the project.',
  ),
  InterviewQuestion(
    number: 27,
    question: 'What is Permit to Work? State the relevant CoP and four examples of permits.',
    modelAnswer: 'A Permit to Work (PTW) is a formal authorization and control system for specified hazardous work. Examples include hot work, confined-space entry, excavation and electrical isolation/work permits. Confirm the current applicable CoP and project PTW procedure for the activity.',
    technicalExplanation: 'A permit communicates scope, hazards, isolations, precautions, responsible persons, validity and handback. It does not replace risk assessment, method statement or supervision.',
    practicalSiteExample: 'Before hot work, verify permit approval, gas testing where required, isolation, fire watch, extinguishers, area clearance and permit closeout.',
  ),
  InterviewQuestion(
    number: 28,
    question: 'Give five precautions for precast lifting and explain how to verify lifting-eye capacity.',
    modelAnswer: 'Confirm approved lift plan and element weight; verify lifting-point design and concrete strength; use suitable certified accessories; check crane capacity/radius and ground stability; and establish exclusion zone and communication. Verify lifting-eye capacity from approved design/manufacturer data, WLL, load direction, sling-angle effects, embedment and required engineering approval.',
    technicalExplanation: 'Never infer capacity from appearance or use unapproved lifting points. Consider dynamic effects, load distribution, concrete condition, edge distances and the planned lifting configuration.',
    practicalSiteExample: 'Before lifting a precast panel, the engineer confirms the approved lifting-point details and concrete release strength, while the lifting supervisor checks accessories and exclusion zone.',
  ),
  InterviewQuestion(
    number: 29,
    question: 'Which extinguisher is suitable for electrical fires and why?',
    modelAnswer: 'A CO₂ extinguisher is commonly suitable for energized electrical equipment because it is non-conductive and leaves no powder residue. Isolate the supply if safe and follow the site fire plan and extinguisher classification.',
    technicalExplanation: 'Never use water on energized electrical equipment. Select an extinguisher appropriate to the actual fire and ensure the user is trained and has a safe escape route.',
    practicalSiteExample: 'For a small electrical-panel fire, raise the alarm, isolate power if safe, use the designated suitable extinguisher only if trained and safe, and evacuate if the fire grows.',
  ),
  InterviewQuestion(
    number: 30,
    question: 'What escalation steps would you take if a foreman or engineer ignores your safety advice?',
    modelAnswer: 'Explain the hazard and consequence; refer to the risk assessment, method statement and requirement; request correction; stop the task if there is imminent danger under site procedure; escalate to construction and HSE management; document and follow up until effective closure.',
    technicalExplanation: 'Use professional, evidence-based communication. Escalation should be timely and proportionate, with immediate protection of people taking priority over hierarchy.',
    practicalSiteExample: 'If workers enter an unprotected excavation, stop entry, secure the area, inform the responsible manager, arrange engineered protection and verify controls before restart.',
  ),
  InterviewQuestion(
    number: 31,
    question: 'Which forms are used for reporting incidents to SRA and what is the timeframe?',
    modelAnswer: 'The source questionnaire does not identify the SRA or the exact reporting procedure. Use immediate site notification, the approved initial incident notification, investigation report and corrective-action record. Confirm current ADPHC and relevant SRA form names and deadlines from the controlled official procedure.',
    technicalExplanation: 'Reporting categories and deadlines can depend on event severity, sector and authority. Do not invent a deadline or form number; maintain evidence of notification and submission.',
    practicalSiteExample: 'The HSE Manager checks the event classification, notifies the designated authority/client contacts within the applicable timeframe and retains submission acknowledgement.',
  ),
  InterviewQuestion(
    number: 32,
    question: 'Define Lost Time Injury and Restricted Work as per the ADOSH reporting framework.',
    modelAnswer: 'An LTI is a work-related injury resulting in the worker being unable to perform work on a subsequent scheduled workday/shift, subject to the applicable reporting definition. A restricted-work case involves inability to perform one or more routine job functions or a reduced normal workday due to a work-related injury. Use the current framework’s exact definitions for classification.',
    technicalExplanation: 'Consistent classification matters for reporting and KPI integrity. Follow current ADOSH/sector reporting definitions and medical/work-status documentation.',
    practicalSiteExample: 'After an injury, HSE confirms the worker’s medical restrictions and next scheduled shift status before classifying and recording the case.',
  ),
  InterviewQuestion(
    number: 33,
    question: 'What are the components of a risk assessment?',
    modelAnswer: 'Define the activity; identify hazards and persons at risk; evaluate likelihood and severity; determine risk; select controls using the hierarchy; assign action owners; record residual risk and approval; communicate controls; and review after changes or incidents.',
    technicalExplanation: 'A useful assessment is task-specific, considers routine and non-routine work and verifies that controls are practical, available and understood.',
    practicalSiteExample: 'For excavation, assess collapse, utilities, plant interface, falls, water and atmosphere; assign engineered protection, permit checks, inspections and emergency arrangements.',
  ),
  InterviewQuestion(
    number: 34,
    question: 'Name three toxic gases that may be present in a confined space.',
    modelAnswer: 'Hydrogen sulphide (H₂S), carbon monoxide (CO) and ammonia (NH₃). Other hazards may include methane, solvent vapours and oxygen deficiency or enrichment.',
    technicalExplanation: 'Atmospheric hazards may be invisible or odourless. Use a calibrated detector suitable for expected contaminants and follow the entry testing/monitoring plan.',
    practicalSiteExample: 'Before manhole entry, a competent tester checks the atmosphere at appropriate levels, records results and confirms ventilation, attendant and rescue readiness.',
  ),
  InterviewQuestion(
    number: 35,
    question: 'Name five emergency drills carried out on construction projects.',
    modelAnswer: 'Fire evacuation; medical/first-aid response; confined-space rescue; work-at-height rescue; and chemical spill response. Other relevant drills include tower-crane rescue, heat illness response and road traffic emergencies.',
    technicalExplanation: 'Drills should test roles, communication, equipment, response time, access, accountability and lessons learned. Record findings and close improvement actions.',
    practicalSiteExample: 'A confined-space drill tests alarm raising, attendant actions, non-entry retrieval, rescue-team mobilization, casualty handover and post-drill corrective actions.',
  ),
  InterviewQuestion(
    number: 36,
    question: 'Give five inspection points for a mobile excavator and five for a stationary generator or plate compactor.',
    modelAnswer: 'Excavator: brakes/steering/controls; hydraulic leaks; tracks/tyres/undercarriage; bucket, pins and attachments; reverse alarm, beacon, mirrors/camera and seat belt. Generator/compactor: guards; fuel/oil leaks; cables/plugs/earthing where applicable; emergency stop and controls; exhaust/ventilation and general condition.',
    technicalExplanation: 'Inspection must follow manufacturer instructions and site checklist. Defective equipment is isolated, tagged and reported; inspection does not authorize use of unsafe equipment.',
    practicalSiteExample: 'The operator completes and signs the pre-start checklist, reports a hydraulic leak, and keeps the excavator out of service until repaired and released.',
  ),
  InterviewQuestion(
    number: 37,
    question: 'Name five points from an operator daily checklist.',
    modelAnswer: 'Operator authorization and fitness for duty; visual walk-around; brakes, steering and safety devices; leaks, tyres/tracks and attachments; horn, reverse alarm, lights and seat belt.',
    technicalExplanation: 'The checklist should be equipment-specific and include defects, isolation status and reporting. The operator must not bypass a defect or rely only on a previous shift’s check.',
    practicalSiteExample: 'At shift start, the operator checks the reverse alarm and seat belt, records results and reports a failed alarm before moving the machine.',
  ),
  InterviewQuestion(
    number: 38,
    question: 'What is a training matrix and what is competency?',
    modelAnswer: 'A training matrix records required and completed training for each role or worker, including expiry and refresher dates. Competency is the demonstrated combination of knowledge, skills, training, experience and ability to perform a task safely to the required standard.',
    technicalExplanation: 'Competence should be assessed for the actual task, equipment and site conditions; attendance at a course alone may not prove practical competence.',
    practicalSiteExample: 'The supervisor checks the matrix and practical authorization before assigning a worker to operate a MEWP or perform confined-space duties.',
  ),
  InterviewQuestion(
    number: 39,
    question: 'What is health surveillance and who conducts it?',
    modelAnswer: 'Health surveillance is planned monitoring of workers’ health where workplace exposure may cause occupational illness. It is conducted by qualified occupational-health professionals under an appropriate medical programme, arranged by the employer with confidentiality protected.',
    technicalExplanation: 'The programme is exposure-based and may include audiometry, respiratory assessment, skin checks or other clinically appropriate surveillance. Results should inform preventive controls and referral.',
    practicalSiteExample: 'Workers exposed to high noise are enrolled in the approved hearing-conservation programme; trends and recommendations are reviewed without disclosing confidential medical details.',
  ),
  InterviewQuestion(
    number: 40,
    question: 'What is behavioural safety?',
    modelAnswer: 'Behavioural safety is a preventive approach that observes and reinforces safe work practices, encourages hazard and near-miss reporting, and uses respectful coaching and feedback to improve safety performance.',
    technicalExplanation: 'It should address system conditions as well as individual actions. Avoid blame-only approaches; workers need suitable equipment, realistic procedures, supervision and a safe way to speak up.',
    practicalSiteExample: 'A supervisor observes a pedestrian entering a plant route, intervenes respectfully, reviews the segregation layout with workers and tracks whether the physical control prevents recurrence.',
  ),
];


/// Screen used by LearningInterviewPage navigation.
class AbuDhabiHseInterviewPage extends StatelessWidget {
  const AbuDhabiHseInterviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Abu Dhabi HSE Interview')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: abuDhabiQuestionnaire40.length,
        itemBuilder: (context, index) {
          final item = abuDhabiQuestionnaire40[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ExpansionTile(
              key: PageStorageKey<String>('abu-dhabi-q-${item.number}'),
              title: Text(
                'Q${item.number}. ${item.question}',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                _AbuDhabiAnswerBlock(
                  label: 'Model Answer',
                  text: item.modelAnswer,
                ),
                _AbuDhabiAnswerBlock(
                  label: 'Technical Explanation',
                  text: item.technicalExplanation,
                ),
                _AbuDhabiAnswerBlock(
                  label: 'Practical Site Example',
                  text: item.practicalSiteExample,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AbuDhabiAnswerBlock extends StatelessWidget {
  final String label;
  final String text;

  const _AbuDhabiAnswerBlock({
    required this.label,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF159447),
            ),
          ),
          const SizedBox(height: 4),
          Text(text),
        ],
      ),
    );
  }
}
