import 'package:flutter/material.dart';

class HandbookTopic {
  final String title, overview, field, records;
  const HandbookTopic({
    required this.title,
    required this.overview,
    required this.field,
    required this.records,
  });
}

const occupationalHealthPart1 = <HandbookTopic>[
  HandbookTopic(
    title: "Occupational Health & Safety Management System",
    overview: "An occupational health management system is the organized set of policy, leadership, planning, implementation, monitoring and improvement arrangements used to prevent work-related ill health. It connects occupational hygiene, worker welfare, medical surveillance, incident learning and contractor control with the overall HSE management system. Define the sites, activities, employees, subcontractors and visitors covered, then identify the significant health risks and measurable objectives.",
    field: "Appoint accountable management and competent occupational health support; establish a health risk register; assign owners and resources; integrate health requirements into procurement, method statements, induction and contractor onboarding. Consult workers and occupational health professionals. Verify controls through workplace inspections, exposure data, medical trend review and corrective-action closure. Review after process changes, incidents, new substances, monitoring exceedances or at planned management-review intervals.",
    records: "Approved OH policy and objectives; occupational health plan; legal and other requirements register; health risk register; responsibility matrix; training/consultation records; inspection and exposure-monitoring reports; medical surveillance arrangements (confidential); KPI dashboard; corrective-action log; management review minutes.",
  ),
  HandbookTopic(
    title: "Occupational Health Policy & Objectives",
    overview: "A policy is senior management’s formal commitment to prevent occupational injury and ill health, comply with applicable obligations, consult workers and continually improve. Objectives translate the commitment into measurable outcomes such as completion of risk assessments, exposure monitoring, medical surveillance, heat-stress readiness, welfare inspections and timely action closure. Objectives should be relevant to actual project risks, not only injury-rate targets.",
    field: "Obtain top-management approval and communicate the policy in languages workers understand. Set baseline, target, owner, resources, measurement method and review date for each objective. Include leading indicators—planned monitoring completed, corrective actions closed, training verified—and outcome indicators such as occupational illness trends. Avoid incentives that discourage reporting. Review performance periodically and revise targets when scope, risk or regulatory requirements change.",
    records: "Signed policy with revision control; annual objectives and action plan; KPI definitions and data sources; communication and worker acknowledgement; periodic performance review; approved revisions and evidence of resource allocation.",
  ),
  HandbookTopic(
    title: "Occupational Health Legal Compliance",
    overview: "Legal compliance means identifying and meeting applicable occupational health duties arising from UAE federal requirements, the relevant emirate regulator, free-zone or sector rules, client specifications and permit conditions. Applicability depends on work location, industry, workforce, exposure and contract. A register should distinguish mandatory law from guidance, standards and contractual commitments.",
    field: "Identify authoritative sources and the regulator for the project; record title, clause/topic, applicability, responsible owner, evidence required and review date. Evaluate compliance against actual site evidence, not document presence alone. Track changes and communicate them to affected teams. Where requirements conflict or are unclear, obtain competent legal/regulatory advice and follow the applicable authority’s direction. Do not treat a generic app note as legal advice.",
    records: "Legal and other requirements register; applicability assessment; compliance evaluation checklist; evidence references; regulator/client correspondence; action tracker; change log; periodic review sign-off.",
  ),
  HandbookTopic(
    title: "Occupational Health Roles & Responsibilities",
    overview: "Clear accountability prevents gaps between project management, HSE, occupational health clinicians, industrial hygienists, supervisors, workers, HR, procurement and contractors. Clinical decisions and confidential health information must remain with appropriately qualified health professionals. Supervisors are responsible for daily implementation; management provides resources and ensures corrective actions are completed.",
    field: "Prepare a responsibility matrix for policy, risk assessment, exposure monitoring, medical surveillance, welfare, training, emergency response and reporting. Define who may stop work, isolate an exposure, arrange referral and authorize return to work. Brief subcontractors and verify competence before assigning specialist duties. Protect medical confidentiality and share only necessary fitness restrictions with line management.",
    records: "Organization chart; RACI/responsibility matrix; role descriptions; competency certificates; appointment letters; contractor interface matrix; consultation minutes; escalation and authorization records.",
  ),
  HandbookTopic(
    title: "Occupational Health Risk Assessment",
    overview: "An occupational health risk assessment identifies how work can cause acute or chronic harm, estimates exposure and risk, and selects controls. It considers routine, non-routine and emergency tasks; susceptible groups; duration and frequency; combined exposures; and the effectiveness of existing controls. It complements task-based HIRA/JSA and should address health effects that may develop over time.",
    field: "Break work into tasks and worker groups; identify chemical, physical, biological, ergonomic and psychosocial hazards; review SDS, process data, exposure history and worker feedback. Assess severity, likelihood and exposure; document uncertainty. Apply elimination, substitution, engineering, administrative controls and PPE in that order. Assign owners and deadlines, brief workers, verify residual risk and reassess after change, symptoms, incidents or monitoring results.",
    records: "Health risk assessment register; task assessments/JSA; SDS and chemical inventory; worker consultation; exposure data; control verification; action closure evidence; review and approval history.",
  ),
  HandbookTopic(
    title: "Occupational Health Hazard Identification",
    overview: "Hazard identification is the systematic recognition of agents, conditions or work organization that may harm health. Hazards may be invisible or delayed: vapours, dust, noise, vibration, heat, pathogens, awkward posture, fatigue and stress. Consider workers who may be more vulnerable, including new or young workers, pregnant workers where relevant, and people with existing restrictions, while respecting privacy and applicable law.",
    field: "Use workplace walkthroughs, task observation, SDS review, worker interviews, incident/ill-health trends, monitoring data and change-management reviews. Inspect all shifts and less frequent tasks. Identify source, route of exposure, exposed group, duration and possible health outcome. Record uncertain hazards for competent evaluation rather than assuming absence. Revisit the register when materials, equipment, layout, staffing or work methods change.",
    records: "Hazard register; inspection checklists; SDS register; task inventory; worker feedback; exposure-monitoring results; incident/ill-health reports; change review records.",
  ),
  HandbookTopic(
    title: "Occupational Health Management Plan",
    overview: "The plan converts risk assessment and policy into a project-specific programme. It defines scope, objectives, roles, resources, controls, medical and hygiene services, welfare standards, emergency arrangements, monitoring, reporting and review. It should be proportionate to the site’s risk profile and coordinated with the project HSE plan, emergency plan and contractor plans.",
    field: "Prepare a risk-based annual or project-phase schedule. Identify responsible competent persons, clinic/provider arrangements, monitoring campaigns, heat-stress readiness, welfare inspections and training. Specify interfaces, escalation thresholds and document control. Obtain required client/consultant approval before implementation. Track completion monthly and revise after significant changes, audit findings, illness trends or regulator/client direction.",
    records: "Approved OH plan; programme calendar; resource and service-provider details; responsibility matrix; monitoring and medical-surveillance schedules; welfare inspection plan; emergency interface; monthly progress and revision log.",
  ),
  HandbookTopic(
    title: "Occupational Health Competency & Training",
    overview: "Competency combines knowledge, practical skill, experience and authorization for the assigned health-related task. Training needs vary: workers need hazard awareness and reporting; supervisors need recognition and control verification; specialists need suitable qualifications for sampling, medical care, respirator fit testing or exposure assessment.",
    field: "Conduct a role-based training-needs analysis. Provide induction and task-specific instruction in understandable languages; demonstrate correct controls and PPE use; assess understanding through observation or questions. Verify credentials and equipment-specific authorization. Refresh after changes, poor performance, incidents or defined intervals. Do not assign clinical diagnosis or specialist monitoring to unqualified personnel.",
    records: "Training matrix; approved course content; attendance and assessment results; competency/qualification evidence; toolbox-talk records; authorization list; refresher schedule; effectiveness checks.",
  ),
  HandbookTopic(
    title: "Occupational Health Inspection & Audit",
    overview: "Inspections verify day-to-day conditions and control use; audits evaluate whether the management system is designed and operating effectively. Include hygiene, welfare, ventilation, chemical storage, noise controls, heat arrangements, ergonomics, housekeeping and worker understanding. Findings should be evidence-based and risk-ranked.",
    field: "Use planned risk-based inspections across locations and shifts. Observe tasks, speak with workers, check records and measure where visual checks are insufficient. Record location, evidence, risk, immediate containment, owner and due date. Escalate imminent serious exposure promptly. Verify corrective action at the workplace and test whether it prevents recurrence. Keep audit independence appropriate to the scope.",
    records: "Inspection/audit schedule; checklists; photographs or measurement references; findings and risk ranking; immediate action records; corrective-action tracker; verification and close-out evidence; audit reports.",
  ),
  HandbookTopic(
    title: "Occupational Health Performance Monitoring",
    overview: "Performance monitoring uses leading and lagging indicators to determine whether health risks are controlled. Useful measures include exposure assessment completion, monitoring coverage, medical surveillance completion, welfare findings, heat-stress controls, training competence, symptom reports and action closure. Ill-health data must be interpreted carefully because latency and under-reporting can distort trends.",
    field: "Define each KPI, numerator, denominator, data owner, frequency and escalation trigger. Review trends by task, exposure group and site without exposing personal medical data. Investigate adverse trends and validate data quality. Combine numbers with worker feedback and field verification; avoid relying solely on zero illness or lost-time targets. Report actions and effectiveness to management.",
    records: "KPI dictionary; monthly dashboard; exposure and surveillance completion summaries; anonymized trend analysis; meeting minutes; investigation/action records; management review.",
  ),
  HandbookTopic(
    title: "Introduction to Industrial Hygiene",
    overview: "Industrial hygiene anticipates, recognizes, evaluates and controls workplace exposures that may cause illness. It focuses on the relationship between agent, source, pathway, worker and dose. It covers chemical agents, physical stressors, biological hazards and ventilation. Industrial hygiene decisions require suitable methods, competent interpretation and consideration of uncertainty.",
    field: "Map processes and exposed groups before selecting monitoring. Review SDS and process conditions; observe source and pathway; choose representative or worst-case sampling with a competent hygienist. Prioritize source control and engineering solutions. Explain findings to workers and supervisors, verify controls and repeat assessment when conditions change. Monitoring alone does not replace prevention.",
    records: "Process and exposure inventory; sampling strategy; instrument calibration records; laboratory reports; control design/maintenance records; worker communication; reassessment schedule.",
  ),
  HandbookTopic(
    title: "Anticipation, Recognition, Evaluation & Control (AREC)",
    overview: "AREC is a practical cycle for preventing occupational exposure: anticipate hazards before introducing work, recognize hazards in current operations, evaluate exposure and risk, then control and verify. It applies to new chemicals, equipment, construction phases, maintenance, shutdowns and process changes.",
    field: "During planning, review design, SDS, materials and similar-work history. At site, observe actual tasks and identify exposed groups. Evaluate qualitatively first and quantitatively when needed. Select controls using the hierarchy, specify performance criteria and responsible owners, then verify through inspection, monitoring and worker feedback. Feed lessons into future planning and management of change.",
    records: "Design/change review; hazard and exposure register; assessment and sampling plan; control action plan; verification records; lessons learned; revised method statements and training.",
  ),
  HandbookTopic(
    title: "Occupational Exposure Assessment",
    overview: "Exposure assessment estimates the amount, route, duration and pattern of contact between a worker and a hazardous agent. It considers inhalation, skin absorption, ingestion and injection, task peaks, full-shift exposure, similar exposure groups and combined agents. A sound assessment states assumptions and uncertainty.",
    field: "Define agent, process, exposed group and decision question. Review task duration, controls, SDS and prior results. Select representative workers and sampling periods with a competent hygienist; use validated methods and calibrated equipment. Compare results with applicable occupational exposure criteria, accounting for units and averaging periods. Investigate elevated or uncertain results and implement interim controls while awaiting results.",
    records: "Exposure assessment protocol; similar exposure group rationale; task and duration observations; sampling records; lab reports; comparison criteria; uncertainty notes; corrective actions and reassessment.",
  ),
  HandbookTopic(
    title: "Personal Exposure Monitoring",
    overview: "Personal monitoring measures exposure in a worker’s breathing zone or on the person during representative work. It can characterize inhalable dust, respirable particulate, vapours, gases, noise or other agents using agent-specific methods. A single sample may not represent all workers or conditions.",
    field: "Choose workers and shifts to represent similar exposure groups, including high-exposure tasks. Place sampler correctly without obstructing work; record task, location, controls, duration and unusual events. Calibrate before and after sampling as method requires; maintain chain of custody and use competent laboratories. Communicate results and act on exceedances or uncertain findings.",
    records: "Sampling plan; worker/task log; instrument serial and calibration; field blanks where required; chain-of-custody forms; laboratory report; result interpretation; communication and follow-up actions.",
  ),
  HandbookTopic(
    title: "Workplace Environmental Monitoring",
    overview: "Environmental monitoring measures conditions around the workplace—such as area contaminant levels, temperature, humidity, air movement, noise or ventilation performance. It helps locate sources and evaluate controls but may not equal an individual worker’s exposure.",
    field: "Select locations based on source, airflow, occupancy and task patterns. Record operating conditions and instrument limitations. Use suitable calibrated meters and competent methods. Map results, compare with applicable criteria and investigate hotspots. Combine area measurements with personal sampling, observation and worker reports when exposure decisions require it.",
    records: "Monitoring map; equipment and calibration records; time-stamped readings; operating-condition log; interpretation; ventilation/control maintenance records; corrective-action and repeat-monitoring evidence.",
  ),
  HandbookTopic(
    title: "Occupational Exposure Limits (OEL)",
    overview: "An OEL is a reference concentration or intensity for a specified agent and averaging period. Different authorities and professional bodies publish limits with differing legal status and assumptions. An OEL is not a sharp boundary between safe and unsafe for every individual, and some agents may require exposure to be reduced as far as reasonably practicable even below a limit.",
    field: "Identify the exact source, edition, units, averaging period, skin notation and any ceiling or excursion rule. Confirm which criterion is legally or contractually applicable to the project. Ensure sampling method and laboratory reporting match the criterion. Treat results near or above the limit conservatively; investigate controls, uncertainty and vulnerable workers with competent occupational hygiene and medical advice.",
    records: "Approved OEL reference register; agent-to-limit mapping; sampling methods; laboratory results; compliance evaluation; exceedance response; revision/change history.",
  ),
  HandbookTopic(
    title: "TWA, STEL & Ceiling Limits",
    overview: "Time-weighted average (TWA) refers to average exposure over a stated work period; short-term exposure limit (STEL) addresses a shorter averaging window; ceiling limits are concentrations that should not be exceeded under the applicable criterion. Definitions and averaging periods depend on the selected authority or standard.",
    field: "Do not compare a short task reading directly with a full-shift TWA. Plan full-shift and task-based sampling to answer the relevant question. Account for extended shifts and the adjustment method required by the chosen standard. Use direct-reading instruments for peaks only when suitable and validated. Apply immediate controls for suspected acute peaks and document the criterion used.",
    records: "Exposure monitoring plan specifying averaging period; task/time log; instrument method; calculation sheet; source and edition of limits; interpretation and action records.",
  ),
  HandbookTopic(
    title: "Occupational Hygiene Sampling Methods",
    overview: "Sampling methods collect or measure agents using validated procedures, such as filter sampling for dust, sorbent tubes for vapours, direct-reading gas meters, sound dosimeters or vibration meters. Method selection depends on agent, particle fraction, expected concentration, sampling duration, laboratory capability and decision purpose.",
    field: "Define the question and target fraction; choose a recognized method and suitable flow rate or instrument range. Check media, pump, tubing, battery and calibration. Prevent contamination, label samples and record blanks where required. Maintain chain of custody, method deviations and field conditions. Use competent laboratories and interpret detection limits and uncertainty.",
    records: "Method selection rationale; sampling SOP; equipment checks; pre/post calibration; sample labels; field sheets; blanks; chain-of-custody; lab reports; deviations and corrective actions.",
  ),
  HandbookTopic(
    title: "Exposure Monitoring Equipment & Calibration",
    overview: "Monitoring equipment must be suitable, maintained and calibrated so results are reliable. Calibration checks whether an instrument responds accurately against a traceable reference; field checks and bump tests may be required for gas detectors. Calibration frequency depends on manufacturer instructions, method, use and applicable requirements.",
    field: "Maintain an equipment register with serial number, range, accuracy, due date and owner. Inspect before use; verify zero/span or bump test where specified; use certified calibration devices and trained operators. Remove damaged, overdue or failed equipment from service and assess whether previous data are affected. Keep raw readings and calibration evidence linked to reports.",
    records: "Equipment register; certificates; pre/post field calibration; bump-test logs; maintenance and repair history; out-of-service tags; impact assessment for failed equipment.",
  ),
  HandbookTopic(
    title: "Occupational Hygiene Control Banding",
    overview: "Control banding is a qualitative approach that groups hazards by severity and exposure potential to guide proportionate controls when detailed exposure data are unavailable. It is a screening and prioritization tool, not a substitute for required measurement or specialist assessment.",
    field: "Gather reliable hazard classification, quantity, dustiness/volatility, task duration and existing controls. Use a recognized control-banding tool within its intended scope. Select recommended containment, ventilation or work practice controls and document assumptions. Escalate high-hazard, uncertain or complex operations to an industrial hygienist; verify actual control performance and monitor when needed.",
    records: "Chemical/task inventory; SDS hazard classification; control-banding worksheet and tool version; selected controls; specialist referral; verification and monitoring records.",
  ),
  HandbookTopic(
    title: "Thermal Stress & Heat Exposure",
    overview: "Thermal stress occurs when environmental heat, workload, clothing and personal factors challenge the body’s ability to regulate temperature. Outcomes range from heat rash and cramps to heat exhaustion and life-threatening heat stroke. Risk varies by acclimatization, hydration, rest, radiant heat, humidity and workload.",
    field: "Assess conditions and workload using an appropriate heat-stress method, such as WBGT where applicable, with competent interpretation. Schedule heavy work for cooler periods; provide shade, cool potable water, acclimatization, work-rest cycles and buddy observation. Train workers to report symptoms early. Stop work and initiate emergency response for suspected heat illness; never leave an affected worker alone.",
    records: "Heat-stress plan; weather/heat readings; work-rest and hydration logs; acclimatization records; toolbox talks; welfare inspection; symptom/incident records; emergency and corrective-action review.",
  ),
  HandbookTopic(
    title: "Cold Stress & Hypothermia",
    overview: "Cold stress can occur in refrigerated facilities, winter outdoor work, wet or windy conditions and offshore operations. Hypothermia, frost injury, reduced dexterity and impaired judgment may result. Risk depends on temperature, wind, moisture, clothing, exposure duration and individual factors.",
    field: "Assess wind chill, wetness, task demands and emergency access. Provide layered dry clothing, gloves, shelter and warm-up breaks; rotate tasks and maintain communication. Keep spare dry clothing and warming arrangements available. Train supervisors to recognize shivering, confusion, slurred speech and loss of coordination. Move suspected hypothermia cases to shelter, handle gently and obtain medical assistance.",
    records: "Cold-weather risk assessment; weather monitoring; PPE issue records; warm-up/rest arrangements; training; inspection and incident/referral records.",
  ),
  HandbookTopic(
    title: "Occupational Noise Exposure",
    overview: "Noise exposure can cause irreversible hearing loss and tinnitus, interfere with communication and increase safety risk. Exposure depends on sound level, duration, impulse peaks and task pattern. Area readings identify noisy sources; personal dosimetry better characterizes an individual’s shift exposure.",
    field: "Survey noisy tasks and equipment; maintain machinery and fit silencers/enclosures; isolate sources and limit access where feasible. Use calibrated sound level meters or dosimeters with competent interpretation. Establish hearing protection zones and select compatible hearing protection with fit and training. Arrange audiometric surveillance where indicated and investigate threshold shifts or complaints.",
    records: "Noise survey and map; dosimetry reports; equipment maintenance; hearing protection selection/training; audiometry programme records held confidentially; corrective actions and follow-up measurements.",
  ),
  HandbookTopic(
    title: "Hearing Conservation Programme",
    overview: "A hearing conservation programme combines noise assessment, engineering and administrative controls, suitable hearing protection, training, audiometry and programme evaluation. It aims to prevent hearing damage and detect changes early; PPE alone is not an adequate programme.",
    field: "Define included groups using exposure assessment and applicable requirements. Baseline and periodic audiometry should be performed by qualified providers with appropriate test conditions. Explain results confidentially, refer significant changes for clinical review and investigate workplace causes. Check protector fit, compatibility with other PPE and actual worker use. Review programme effectiveness annually or after significant change.",
    records: "Written programme; noise exposure group list; audiometry schedule and confidential clinical records; protector issue/fit training; maintenance and signage inspections; anonymized trend review; action close-out.",
  ),
  HandbookTopic(
    title: "Hand–Arm Vibration",
    overview: "Hand–arm vibration from powered tools can cause vascular, neurological and musculoskeletal disorders, including vibration-related white finger. Risk depends on vibration magnitude, trigger time, tool condition, grip force, cold and cumulative exposure.",
    field: "Inventory vibrating tools and obtain reliable vibration data; assess actual trigger time rather than shift duration alone. Select lower-vibration tools, maintain consumables, reduce exposure duration and avoid excessive grip force. Keep hands warm and dry; train workers to report tingling, numbness or blanching early. Arrange occupational health assessment where symptoms or exposure warrant it.",
    records: "Tool inventory and vibration data; exposure/trigger-time assessment; maintenance records; task rotation plan; training; symptom referral and exposure review records.",
  ),
  HandbookTopic(
    title: "Whole Body Vibration",
    overview: "Whole-body vibration is transmitted through vehicle or machine seats and floors. Repeated exposure, shocks and poor posture can contribute to back discomfort and other health effects. Exposure is influenced by vehicle speed, terrain, seat condition, suspension, driving duration and operator posture.",
    field: "Assess representative routes, vehicles and operating conditions using competent measurement where needed. Maintain roads, tires, suspension and seats; select suitable adjustable seats; reduce speed over rough terrain and limit continuous driving. Train operators in posture and reporting. Consider ergonomic factors and medical advice for workers with symptoms.",
    records: "Vehicle/operator risk assessment; vibration measurement; seat and vehicle maintenance; route inspection; driving/rest schedule; operator training and reported-symptom follow-up.",
  ),
  HandbookTopic(
    title: "Occupational Lighting & Visual Ergonomics",
    overview: "Poor lighting, glare, flicker, low contrast and unsuitable screen setup can cause visual discomfort, headaches, errors and unsafe movement. Lighting needs differ for access routes, detailed inspection, workshops, control rooms and office tasks.",
    field: "Survey illumination at the work plane using a suitable meter and compare with project standards or applicable guidance for the task. Correct failed lamps, glare, shadows and uneven lighting; provide task lighting without creating trip or electrical hazards. Position screens to reduce reflections, adjust display settings and encourage visual breaks. Refer persistent symptoms for assessment.",
    records: "Lighting survey and locations; maintenance records; task-lighting inspection; workstation assessment; worker feedback; corrective actions and follow-up checks.",
  ),
  HandbookTopic(
    title: "Non-Ionizing Radiation",
    overview: "Non-ionizing radiation includes ultraviolet, infrared, radiofrequency, microwave and laser sources. Exposure may affect eyes or skin depending on wavelength, intensity, duration and distance. Welding arcs, UV curing, lasers and some industrial equipment require source-specific controls.",
    field: "Identify sources and manufacturer classifications; establish exclusion zones and interlocks; use shielding, barriers and warning signs. Select wavelength-appropriate eye/skin protection and ensure workers understand access restrictions. Inspect guards and interlocks before use; control reflections and unauthorized access. For suspected eye or skin injury, stop exposure and obtain prompt medical assessment.",
    records: "Source inventory; risk assessment; equipment manuals/classification; access and interlock checks; PPE specifications; training/authorization; inspection and incident records.",
  ),
  HandbookTopic(
    title: "Ionizing Radiation Protection",
    overview: "Ionizing radiation from industrial radiography and other licensed sources can damage tissue and increase long-term cancer risk. Work must be controlled under applicable radiation-protection legislation, licensing conditions and competent radiation-protection arrangements. This topic is not a substitute for an approved radiation protection programme.",
    field: "Use authorized radiation protection personnel and approved procedures. Apply time, distance and shielding; establish controlled areas, barriers, warning signals and access control. Verify survey meters and personal dosimeters are suitable and in calibration. Confirm source security, emergency arrangements and worker training before work. Stop work and escalate immediately for suspected loss, damage, unexpected dose or boundary failure.",
    records: "Licences/authorizations; radiation protection plan; source inventory and security log; dose monitoring; survey and instrument calibration; controlled-area checks; training; emergency drills and incident reports.",
  ),
  HandbookTopic(
    title: "Workplace Air Quality & Ventilation",
    overview: "Ventilation controls airborne contaminants by capturing emissions at source, diluting contaminants or supplying clean air. Poor ventilation can allow dust, fumes, vapours, bioaerosols or combustion products to accumulate. General ventilation may be insufficient for high-hazard or localized emissions.",
    field: "Identify contaminant sources and airflow paths; prioritize enclosure and local exhaust ventilation close to the source. Verify hood position, capture, duct condition, filters and discharge location. Do not recirculate contaminated air unless a competent design confirms it is safe and permitted. Maintain systems and investigate complaints, visible emissions or monitoring results. Confined-space ventilation requires a separate permit and atmospheric control process.",
    records: "Ventilation design and commissioning data; LEV examination/maintenance; filter and airflow checks; indoor air quality readings; complaints and investigation records; corrective actions and re-verification.",
  ),
];

class OccupationalHealthHandbookPage extends StatelessWidget {
  const OccupationalHealthHandbookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: const Text('Occupational Health'),
        backgroundColor: const Color(0xFF0B5D4B),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: occupationalHealthPart1.length,
        itemBuilder: (context, i) {
          final topic = occupationalHealthPart1[i];
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE5F4E9),
                child: Icon(Icons.health_and_safety, color: Color(0xFF159447)),
              ),
              title: Text(topic.title, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text('Professional field handbook'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => _TopicDetail(topic: topic)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TopicDetail extends StatelessWidget {
  final HandbookTopic topic;
  const _TopicDetail({required this.topic});

  Widget _section(String heading, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0B5D4B),
            ),
          ),
          const SizedBox(height: 7),
          SelectableText(body, style: const TextStyle(fontSize: 15, height: 1.55)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: Text(topic.title, maxLines: 2, overflow: TextOverflow.ellipsis),
        backgroundColor: const Color(0xFF0B5D4B),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          _section('1. Definition, purpose & applicability', topic.overview),
          _section('2. Detailed site implementation & controls', topic.field),
          _section('3. Office documents, evidence & records', topic.records),
          _section(
            '4. UAE project compliance and professional review',
            'Confirm the current UAE federal, emirate, regulator, client and sector requirements applicable to the project. Use the approved project criteria and competent occupational health / industrial hygiene advice. This handbook is practical guidance and does not replace legal advice, clinical judgment, an approved risk assessment or regulator instructions.',
          ),
        ],
      ),
    );
  }
}
