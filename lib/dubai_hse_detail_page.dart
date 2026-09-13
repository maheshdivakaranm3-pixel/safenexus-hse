import 'package:flutter/material.dart';

import 'models/reference_topic.dart';

/// SafeNexus HSE - Dubai HSE
///
/// The Dubai topic screen is an index of topic-specific controls. Each card
/// is tappable and opens a dedicated detailed section page. The content is
/// kept in this file so the existing green build is not dependent on adding
/// more routes or changing the Dubai guideline data file.
class DubaiHseDetailPage extends StatelessWidget {
  final ReferenceTopic topic;

  const DubaiHseDetailPage({
    super.key,
    required this.topic,
  });

  static const Color darkGreen = Color(0xFF0B5D3B);
  static const Color primaryGreen = Color(0xFF159447);
  static const Color pageBackground = Color(0xFFF5F7FA);
  static const Color textDark = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF4B5563);

  @override
  Widget build(BuildContext context) {
    final detail = _details[topic.id] ?? _fallback(topic);
    final sections = _sectionsFor(topic, detail);

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        title: Text(topic.shortTitle.isEmpty ? topic.title : topic.shortTitle),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
          children: [
            _header(topic, detail),
            const SizedBox(height: 16),
            const Text(
              'Detailed HSE Topics',
              style: TextStyle(
                color: darkGreen,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Tap any item to open the full topic-specific guidance.',
              style: TextStyle(color: textSecondary, fontSize: 15, height: 1.4),
            ),
            const SizedBox(height: 12),
            ...sections.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _sectionCard(context, entry.key + 1, entry.value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(ReferenceTopic topic, _TopicDetail detail) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [darkGreen, Color(0xFF087F5B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DUBAI HSE',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            topic.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              height: 1.22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            detail.purpose,
            style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.45),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard(BuildContext context, int number, _DubaiSection section) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => DubaiHseSectionDetailPage(
                topicTitle: topic.title,
                section: section,
                number: number,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: const Color(0xFFE4E9E7)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(alpha: .10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$number',
                  style: const TextStyle(
                    color: darkGreen,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section.title,
                      style: const TextStyle(
                        color: textDark,
                        fontSize: 16.5,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      section.summary,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: textSecondary,
                        fontSize: 13.5,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right_rounded, color: primaryGreen, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}

class DubaiHseSectionDetailPage extends StatelessWidget {
  final String topicTitle;
  final _DubaiSection section;
  final int number;

  const DubaiHseSectionDetailPage({
    super.key,
    required this.topicTitle,
    required this.section,
    required this.number,
  });

  static const Color darkGreen = Color(0xFF0B5D3B);
  static const Color primaryGreen = Color(0xFF159447);
  static const Color pageBackground = Color(0xFFF5F7FA);
  static const Color textDark = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF4B5563);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        title: Text(section.title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE1E8E4)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primaryGreen.withValues(alpha: .10),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$number',
                      style: const TextStyle(color: darkGreen, fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      topicTitle,
                      style: const TextStyle(color: darkGreen, fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _card('Detailed Guidance', Icons.menu_book_outlined, section.detail),
            if (section.bullets.isNotEmpty) ...[
              const SizedBox(height: 14),
              _bulletCard(section.bullets),
            ],
            if (section.stopWork.isNotEmpty) ...[
              const SizedBox(height: 14),
              _stopCard(section.stopWork),
            ],
          ],
        ),
      ),
    );
  }

  Widget _card(String title, IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: .04), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryGreen, size: 27),
              const SizedBox(width: 10),
              Expanded(child: Text(title, style: const TextStyle(color: darkGreen, fontSize: 20, fontWeight: FontWeight.w800))),
            ],
          ),
          const SizedBox(height: 14),
          Text(text, style: const TextStyle(color: textSecondary, fontSize: 16, height: 1.55)),
        ],
      ),
    );
  }

  Widget _bulletCard(List<String> bullets) {
    return Container(
      padding: const EdgeInsets.fromLTRB(19, 18, 19, 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [Icon(Icons.checklist_rounded, color: primaryGreen, size: 27), SizedBox(width: 10), Text('Practical Points', style: TextStyle(color: darkGreen, fontSize: 20, fontWeight: FontWeight.w800))]),
          const SizedBox(height: 12),
          ...bullets.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.only(top: 7), child: Icon(Icons.circle, size: 7, color: primaryGreen)),
                const SizedBox(width: 10),
                Expanded(child: Text(item, style: const TextStyle(color: textDark, fontSize: 15.5, height: 1.48))),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _stopCard(String text) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E7),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE7C76A)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.do_not_disturb_on_outlined, color: Color(0xFF9A6B00), size: 28),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('STOP WORK / EMERGENCY', style: TextStyle(color: Color(0xFF7A5700), fontSize: 16, fontWeight: FontWeight.w800)),
            const SizedBox(height: 7),
            Text(text, style: const TextStyle(color: textSecondary, fontSize: 15, height: 1.48)),
          ])),
        ],
      ),
    );
  }
}

class _DubaiSection {
  final String title;
  final String summary;
  final String detail;
  final List<String> bullets;
  final String stopWork;

  const _DubaiSection({
    required this.title,
    required this.summary,
    required this.detail,
    this.bullets = const [],
    this.stopWork = '',
  });
}

_TopicDetail _fallback(ReferenceTopic topic) => _TopicDetail(
  purpose: topic.description,
  hazards: topic.keyRequirements.take(5).toList(),
  requirements: topic.keyRequirements,
  controls: topic.safetyControls,
  verification: topic.responsibilities,
  records: const ['Approved risk assessment and method statement', 'Inspection and training evidence', 'Corrective-action records and close-out evidence'],
  stopWork: 'Stop the affected activity when a critical control is missing or conditions become unsafe. Protect people, isolate the hazard and obtain competent assessment before restart.',
);

_TopicDetail _topicData(String id, ReferenceTopic topic) => _details[id] ?? _fallback(topic);

List<_DubaiSection> _sectionsFor(ReferenceTopic topic, _TopicDetail d) {
  final titles = _sectionTitles[topic.id] ?? const [
    'Purpose & Scope', 'Main Hazards', 'Detailed Requirements', 'Safety Controls',
    'Pre-Start Checks', 'Work Execution', 'Inspection & Verification',
    'Supervisor Responsibilities', 'Worker Responsibilities', 'Records & Evidence',
    'Stop-Work Conditions', 'Emergency Response',
  ];

  final details = <_DubaiSection>[
    _DubaiSection(title: titles[0], summary: 'What this topic covers and why it matters on a Dubai construction site.', detail: d.purpose, bullets: d.requirements.take(5).toList()),
    _DubaiSection(title: titles[1], summary: 'The principal hazards that must be recognised before the activity starts.', detail: 'For ' + topic.title + ', the risk picture must be based on the actual work method, location, people, plant and changing site conditions. The following hazards are the key exposure points to control:', bullets: d.hazards),
    _DubaiSection(title: titles[2], summary: 'Core requirements that should be built into planning and supervision.', detail: 'The requirements below should be translated into the approved work method, risk assessment, supervision arrangements and worker briefing. They should remain aligned with actual site conditions.', bullets: d.requirements),
    _DubaiSection(title: titles[3], summary: 'Practical controls that should be visible at the work front.', detail: 'Controls should follow the hierarchy of control and should be physically verifiable. PPE should not be treated as a substitute for engineering, isolation, guarding, exclusion or other higher-level controls.', bullets: d.controls),
    _DubaiSection(title: titles[4], summary: 'Checks to complete before the work or shift begins.', detail: 'Before starting, the supervisor should confirm that the planned controls are available, understood and suitable for the current work front. Any material change should trigger reassessment.', bullets: [...d.verification.take(3), ...d.requirements.take(2)]),
    _DubaiSection(title: titles[5], summary: 'How to maintain control while the activity is being performed.', detail: 'During execution, supervision should verify that the approved sequence is followed, interfaces remain controlled and workers do not bypass critical protections. Stop and reassess when conditions differ from the planned method.', bullets: d.controls),
    _DubaiSection(title: titles[6], summary: 'Field checks, inspection evidence and verification of controls.', detail: 'Verification must be based on the physical work area, not paperwork alone. Findings should be recorded clearly, assigned to responsible persons and physically verified when closed.', bullets: d.verification, stopWork: d.stopWork),
    _DubaiSection(title: titles[7], summary: 'What competent supervision must actively manage.', detail: 'The supervisor is responsible for maintaining the planned controls at the work front, communicating changes, checking worker understanding and stopping the activity when a critical control is not effective.', bullets: d.requirements.take(4)),
    _DubaiSection(title: titles[8], summary: 'What workers need to understand and do before and during the task.', detail: 'Workers should understand the hazards, required controls, limits of the equipment or method and the conditions that require them to stop and inform supervision.', bullets: [...d.hazards.take(3), ...d.controls.take(3)]),
    _DubaiSection(title: titles[9], summary: 'Evidence that demonstrates the activity was planned, controlled and checked.', detail: 'Maintain the records required by the project HSE management system and applicable authority requirements. Records should be current, traceable and available to the responsible team.', bullets: d.records),
    _DubaiSection(title: titles[10], summary: 'Conditions in which the activity must not continue.', detail: d.stopWork, bullets: ['Uncontrolled critical hazard', 'Required protection missing or defective', 'Actual conditions materially different from the approved method', 'Unsafe interference by another activity or person'], stopWork: d.stopWork),
    _DubaiSection(title: titles[11], summary: 'Immediate response principles if an incident or emergency occurs.', detail: 'Protect people first, raise the alarm through the approved site process, prevent secondary exposure and use the project emergency arrangements. Do not create a second casualty during rescue or intervention.', bullets: d.hazards.take(3).toList()..addAll(d.verification.take(2)), stopWork: d.stopWork),
  ];
  return details;
}

const Map<String, List<String>> _sectionTitles = {
  'dubai_construction_safety': ['Construction Safety Purpose & Scope','Construction Site Hazards','Planning & HSE Requirements','Site-Wide Safety Controls','Pre-Start Construction Checks','Safe Work Coordination','Inspection & Assurance','Project HSE Supervisor Focus','Worker Safety Responsibilities','HSE Records & Evidence','Construction Stop-Work Conditions','Construction Emergency Response'],
  'dubai_hse_management': ['HSE Management System Purpose','Management-System Hazards','Leadership & Governance Requirements','HSE Management Controls','Management Pre-Start Review','Implementation at Work Front','Inspection, Audit & Review','Management Responsibilities','Worker Participation','HSE Documentation & Records','Management Escalation / Stop Work','Major Incident Management'],
  'dubai_risk_assessment': ['Risk Assessment Purpose & Scope','Hazard Identification','Risk Evaluation Requirements','Hierarchy of Controls','Pre-Task Risk Review','Dynamic Risk Control','Verification of Risk Controls','Supervisor Risk Responsibilities','Worker Risk Awareness','Risk Assessment Records','When to Stop & Reassess','Emergency Risk Response'],
  'dubai_hse_plan': ['Construction HSE Plan Purpose','HSE Plan Risk Profile','Plan Content Requirements','Project HSE Controls','Pre-Mobilisation Checks','Implementation & Interfaces','Plan Inspection & Review','HSE Manager / Supervisor Duties','Worker Communication','Plan Records & Revision Control','Plan-Related Stop Work','Emergency Arrangements in the Plan'],
  'dubai_work_at_height': ['Work at Height Scope','Fall & Dropped-Object Hazards','Work at Height Planning Requirements','Edge Protection & Fall Controls','Pre-Start Height Checks','Safe Work at Height','Inspection & Access Verification','Supervisor Responsibilities','Worker Responsibilities','Height Work Records','Fall-Related Stop Work','Fall Rescue & Emergency Response'],
  'dubai_scaffolding': ['Scaffold Purpose & Scope','Scaffold Types & Applications','Scaffold Hazards','Foundation / Base Requirements','Erection & Dismantling','Guardrails & Toe Boards','Safe Access','Bracing, Ties & Stability','Platforms & Loading','Inspection & Tagging','Modification & Weather Control','Scaffold Emergency / Stop Work'],
  'dubai_lifting': ['Lifting Purpose & Scope','Lifting Equipment & Operations','Lifting Hazards','Ground & Set-Up Requirements','Lift Planning','Rigging & Accessories','Exclusion Zones & Signalling','Crane / Hoist Stability','Load Control & Capacity','Inspection & Certification','Competent Persons & Responsibilities','Lifting Emergency / Stop Work'],
  'dubai_excavation': ['Excavation Purpose & Scope','Excavation Types & Hazards','Ground Condition Assessment','Underground Services','Excavation Planning','Shoring / Benching / Sloping','Access & Egress','Plant, Traffic & Edge Protection','Water, Atmosphere & Environmental Conditions','Daily Inspection','Collapse / Unsafe Excavation Stop Work','Excavation Emergency Response'],
  'dubai_confined_space': ['Confined Space Purpose & Scope','Confined Space Hazards','Entry Planning','Isolation & Permit Controls','Atmospheric Testing','Ventilation & Communications','Entry Team & Standby Person','PPE & Rescue Equipment','Continuous Monitoring','Inspection & Records','Entry Stop-Work Conditions','Confined Space Rescue'],
  'dubai_electrical': ['Electrical Safety Purpose','Electrical Hazards','Electrical Planning & Competence','Isolation / LOTO','Temporary Electrical Systems','Cables, Distribution & Protection','Tools & Equipment','Inspection & Testing','Work Near Electrical Services','Electrical Records','Electrical Stop Work','Electrical Emergency Response'],
  'dubai_hot_work': ['Hot Work Purpose & Scope','Fire / Explosion Hazards','Hot Work Planning','Permit & Area Preparation','Gas Cylinder Controls','Fire Watch & Fire Protection','Spark / Heat Containment','Ventilation & Atmosphere','Post-Work Fire Watch','Inspection & Records','Hot Work Stop Work','Fire / Burn Emergency Response'],
  'dubai_traffic': ['Traffic Management Purpose','Vehicle & Pedestrian Hazards','Traffic Planning','Site Entry & Route Control','Pedestrian Segregation','Banksman / Signaller Controls','Reversing & Manoeuvring','Plant Speed & Parking','Night / Visibility Controls','Traffic Inspection Records','Traffic Stop Work','Vehicle Incident Response'],
  'dubai_demolition': ['Demolition Purpose & Scope','Demolition Hazards','Pre-Demolition Survey','Structural Stability','Isolation of Services','Demolition Sequence','Exclusion Zones & Public Protection','Plant & Remote Operations','Dust, Noise & Debris','Inspection & Monitoring','Demolition Stop Work','Collapse / Emergency Response'],
  'dubai_temporary_works': ['Temporary Works Purpose','Temporary Works Hazards','Design & Approval','Foundations & Stability','Erection / Installation','Loading & Structural Limits','Inspection & Hold Points','Interfaces with Permanent Works','Weather / Environmental Effects','Temporary Works Records','Unsafe Temporary Works Stop Work','Structural Emergency Response'],
  'dubai_heat_stress': ['Heat Stress Purpose','Heat Stress Hazards','Heat Risk Assessment','Work-Rest Planning','Hydration & Cooling','Acclimatisation','PPE & Clothing','Worker Monitoring','Supervisor Field Checks','Heat Stress Records','Heat Stop-Work Conditions','Heat Illness Emergency Response'],
  'dubai_occupational_health': ['Occupational Health Scope','Work-Related Health Hazards','Health Risk Assessment','Exposure Controls','Dust / Respiratory Protection','Noise & Hearing','Chemicals & Skin Exposure','Ergonomics & Manual Handling','Health Surveillance','Welfare & Hygiene Checks','Occupational Health Escalation','Medical / Exposure Emergency'],
  'dubai_ppe': ['PPE Purpose & Scope','PPE Hazard Assessment','PPE Selection','Head / Eye / Face Protection','Hand / Foot Protection','Hearing & Respiratory Protection','Protective Clothing & Compatibility','Fit, Inspection & Maintenance','Worker PPE Responsibilities','PPE Records & Training','Defective PPE Stop Work','PPE-Related Emergency Response'],
  'dubai_emergency': ['Emergency Preparedness Scope','Emergency Hazards','Emergency Planning','Alarm & Communication','Evacuation & Assembly','First Aid','Rescue Arrangements','Fire & Life Safety Equipment','Drills & Readiness Checks','Emergency Records','Emergency Stop-Work / Escalation','Incident & Recovery Response'],
  'dubai_incident': ['Incident Reporting Purpose','Immediate Incident Hazards','Initial Response','Notification & Escalation','Scene Preservation','Investigation Method','Root Cause Analysis','Corrective & Preventive Actions','Worker / Witness Participation','Incident Records','Post-Incident Stop Work','Serious Incident Response'],
  'dubai_contractor': ['Contractor HSE Scope','Contractor Risk Profile','Prequalification','Mobilisation & Induction','RAMS & Permit Approval','Interface Management','Competence & Supervision','Contractor Inspection','Performance & Corrective Actions','Contractor Records','Contractor Stop Work','Contractor Emergency Coordination'],
  'dubai_environment': ['Environmental HSE Scope','Environmental Hazards','Environmental Aspect Assessment','Waste Segregation','Chemical / Fuel Storage','Spill Prevention','Dust / Air Quality','Drainage & Pollution Prevention','Environmental Inspection','Waste & Incident Records','Environmental Stop Work','Spill / Release Emergency'],
  'dubai_inspection': ['Inspection Purpose','Inspection Risk Priorities','Inspection Planning','Workfront Inspection Method','Critical Control Verification','Evidence & Findings','Action Assignment','Supervisor Follow-Up','Worker Engagement','Inspection Records','Critical Finding Stop Work','Immediate Hazard Response'],
  'dubai_performance': ['HSE Performance Scope','Performance Risks','Leading Indicators','Lagging Indicators','Target & KPI Setting','Data Quality','Trend Analysis','Management Review','Worker / Contractor Performance','Performance Records','Escalation for Poor Performance','Major Event Learning'],
  'dubai_building_code': ['Dubai Building Code Scope','Building Safety Hazards','Code-Based Planning','Life Safety Requirements','Means of Egress','Fire & Accessibility Interfaces','Structural / Building Interfaces','Construction Verification','Authority / Design Coordination','Compliance Records','Non-Compliance Stop Work','Building Safety Emergency'],
  'dubai_permit_to_work': ['PTW Purpose & Scope','Permit-Controlled Hazards','Permit Planning','Isolation & Boundaries','Permit Issue & Authorisation','Worksite Verification','SIMOPS / Interface Control','Permit Display & Communication','Permit Suspension & Revalidation','Permit Records','Permit Stop Work','Emergency Permit Response'],
  'dubai_cop_site_establishment': ['Site Establishment Purpose','Site Set-Up Hazards','Site Layout Planning','Access & Boundary Controls','Welfare / Facilities Set-Up','Utilities & Temporary Services','Emergency Access','Material / Plant Areas','Housekeeping & Inspection','Site Establishment Records','Unsafe Site Set-Up Stop Work','Site Emergency Arrangements'],
  'dubai_cop_public_protection': ['Public Protection Purpose','Third-Party Hazards','Public Interface Planning','Hoarding & Site Boundaries','Pedestrian Protection','Falling Object Controls','Traffic / Public Interface','Security & Access Control','Inspection & Monitoring','Public Protection Records','Public Exposure Stop Work','Third-Party Emergency Response'],
  'dubai_cop_access_housekeeping': ['Access & Housekeeping Purpose','Access / Trip Hazards','Access Route Planning','Stairs & Walkways','Housekeeping Standards','Openings & Obstructions','Material / Waste Control','Lighting & Visibility','Daily Inspection','Housekeeping Records','Unsafe Access Stop Work','Emergency Access Response'],
  'dubai_cop_welfare_facilities': ['Worker Welfare Purpose','Welfare Hazards','Facility Planning','Drinking Water & Sanitation','Rest / Changing Facilities','Worker Accommodation Interfaces','Heat / Hygiene Controls','Cleaning & Maintenance','Welfare Inspection','Welfare Records','Unsafe Welfare Conditions','Medical / Welfare Emergency'],
  'dubai_cop_material_storage': ['Material Storage Purpose','Storage Hazards','Storage Area Planning','Stacking & Stability','Safe Handling','Forklift / Plant Interface','Chemical / Hazardous Storage','Access & Fire Separation','Storage Inspection','Storage Records','Unstable Storage Stop Work','Storage Incident Response'],
  'dubai_cop_formwork_falsework': ['Formwork / Falsework Scope','Temporary Support Hazards','Design & Approval','Ground / Bearing Conditions','Erection Sequence','Bracing & Stability','Loading & Concrete Pour Controls','Access & Edge Protection','Inspection & Hold Points','Formwork Records','Unsafe Support Stop Work','Collapse Emergency Response'],
  'dubai_cop_rebar_concrete': ['Reinforcement & Concrete Scope','Rebar / Concrete Hazards','Work Planning','Rebar Storage & Handling','Impaling Protection','Concrete Pour Controls','Pumps / Hoses / Pressure','Access & Work Platforms','Inspection & Housekeeping','Work Records','Unsafe Concrete Operation Stop Work','Concrete / Rebar Emergency'],
  'dubai_cop_machinery_guarding': ['Machinery Guarding Purpose','Mechanical Hazards','Machine Selection & Risk Assessment','Fixed / Interlocked Guards','Isolation & Lockout','Safe Operating Controls','Maintenance & Adjustment','Operator Competence','Inspection & Guard Integrity','Machine Records','Guarding Stop Work','Machinery Emergency Response'],
  'dubai_cop_ladders_mobile_towers': ['Ladders & Towers Scope','Access Equipment Hazards','Selection & Suitability','Ground / Set-Up','Three-Point Contact','Mobile Tower Stability','Guardrails & Platform Protection','Movement / Relocation','Inspection & Tagging','Training & Records','Unsafe Access Stop Work','Fall / Tip-Over Emergency'],
  'dubai_cop_fire_emergency': ['Fire Prevention Scope','Fire Hazards','Fire Risk Planning','Ignition Source Control','Combustible Material Control','Fire Extinguishers & Equipment','Hot Work Interface','Emergency Routes & Assembly','Fire Inspection & Drills','Fire Records','Fire Stop-Work Conditions','Fire Emergency Response'],
  'dubai_cop_signs_barricading': ['Signs & Barricading Scope','Signage Hazards','Sign Selection','Barricade Design','Exclusion Zones','Pedestrian / Traffic Communication','Night Visibility','Inspection & Maintenance','Change Management','Signage Records','Broken Barrier Stop Work','Emergency Area Isolation'],
  'dubai_cop_lighting_weather': ['Lighting & Weather Scope','Visibility Hazards','Lighting Planning','Task / Route Illumination','Glare & Shadow Control','Temporary Electrical Protection','Night / Shift Work','Wind & Weather Monitoring','Inspection During Shift','Lighting / Weather Records','Adverse Condition Stop Work','Weather Emergency Response'],
};

const Map<String, _TopicDetail> _details = {

  'dubai_construction_safety': _TopicDetail(

    purpose: 'Sets the overall site safety framework for construction activities, interfaces and changing project conditions.',

    hazards: const [

      'Uncontrolled simultaneous activities',

      'Falls, struck-by and caught-between events',

      'Public or third-party exposure',

      'Uncontrolled changes in site conditions',

    ],

    requirements: const [

      'Establish project HSE responsibilities before mobilisation',

      'Complete activity risk assessments and method statements',

      'Coordinate contractors and simultaneous operations',

      'Provide welfare, emergency access and communication systems',

      'Review controls when scope or site conditions change',

    ],

    controls: const [

      'Site induction and competency verification',

      'Planned inspections and corrective actions',

      'Controlled access and segregation',

      'Permit systems for higher-risk activities',

      'Daily coordination and toolbox communication',

    ],

    verification: const [

      'Check that critical controls are physically present before work',

      'Verify inspection records and close-out of critical findings',

      'Confirm emergency routes remain usable',

      'Confirm supervisors understand current work fronts',

      'Escalate serious deviations immediately',

    ],

    records: const [

      'Current approved Dubai Construction Safety Framework risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Stop the affected activity, isolate the hazard area, protect personnel and activate the project emergency arrangements when an immediate danger exists.',

  ),

  'dubai_hse_management': _TopicDetail(

    purpose: 'Defines how HSE policy, responsibilities, planning, implementation, assurance and continual improvement are managed on a Dubai construction project.',

    hazards: const [

      'Unclear accountability',

      'Poor document control',

      'Unclosed corrective actions',

      'Weak contractor coordination',

    ],

    requirements: const [

      'Define HSE roles and authority',

      'Set measurable objectives and project controls',

      'Control procedures, forms and revisions',

      'Provide competent supervision and resources',

      'Audit performance and drive corrective action',

    ],

    controls: const [

      'Approved HSE plan and procedures',

      'Training and competency matrix',

      'Inspection and audit programme',

      'Action tracking with owners and due dates',

      'Management review of significant trends',

    ],

    verification: const [

      'Sample current procedures at the work front',

      'Verify actions are actually closed, not only marked closed',

      'Check induction and training status',

      'Review recent incidents and leading indicators',

      'Confirm changes are communicated',

    ],

    records: const [

      'Current approved HSE Management System risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Suspend unsafe work where management controls are ineffective and escalate through the project HSE and management structure.',

  ),

  'dubai_risk_assessment': _TopicDetail(

    purpose: 'Provides a structured process for identifying hazards, evaluating risk, selecting controls and reviewing residual risk before and during work.',

    hazards: const [

      'Unidentified hazards',

      'Inadequate control selection',

      'Changing conditions',

      'Failure to communicate residual risk',

    ],

    requirements: const [

      'Define the task and work boundaries',

      'Identify hazards and exposed persons',

      'Evaluate risk using the approved project method',

      'Apply the hierarchy of controls',

      'Review the assessment after changes, incidents or new information',

    ],

    controls: const [

      'Eliminate hazards where practicable',

      'Use engineering and physical controls before relying on PPE',

      'Assign control owners',

      'Brief affected workers',

      'Record residual risk and required monitoring',

    ],

    verification: const [

      'Walk the actual work area and compare it with the assessment',

      'Verify controls match the stated risk',

      'Check workers can explain key hazards',

      'Reassess when plant, sequence or environment changes',

      'Close review actions before high-risk work proceeds',

    ],

    records: const [

      'Current approved Health & Safety Risk Assessment risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Stop work if a critical hazard is not adequately controlled or the actual conditions differ materially from the approved assessment.',

  ),

  'dubai_hse_plan': _TopicDetail(

    purpose: 'Explains the project-specific arrangements used to manage construction HSE risks, responsibilities, interfaces and assurance activities.',

    hazards: const [

      'Generic controls that do not match the project',

      'Missing high-risk activity arrangements',

      'Poor contractor interfaces',

      'Unclear emergency and inspection arrangements',

    ],

    requirements: const [

      'Develop the plan before major construction activities',

      'Include project organisation and responsibilities',

      'Define risk assessment, PTW and emergency arrangements',

      'Address welfare, occupational health and environmental interfaces',

      'Review the plan when scope or conditions change',

    ],

    controls: const [

      'Activity-specific method statements',

      'HSE inspection and audit schedules',

      'Emergency response plans and drills',

      'Training and competency requirements',

      'Document control and revision tracking',

    ],

    verification: const [

      'Verify the current approved revision is available',

      'Check project controls are implemented at site',

      'Sample contractor plans against the main HSE plan',

      'Review emergency contacts and access',

      'Track overdue actions and approvals',

    ],

    records: const [

      'Current approved Construction HSE Plan risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Stop affected work where a required project control or approved method is absent and the risk cannot otherwise be controlled.',

  ),

  'dubai_work_at_height': _TopicDetail(

    purpose: 'Controls work where a person could fall from an elevated position, including selection of access systems, edge protection and rescue planning.',

    hazards: const [

      'Falls from edges and openings',

      'Dropped objects',

      'Unstable access equipment',

      'Suspension after a fall-arrest event',

    ],

    requirements: const [

      'Avoid work at height where practicable',

      'Select suitable collective protection first',

      'Provide safe access and work platforms',

      'Use fall restraint or fall arrest systems when required',

      'Plan rescue before using fall-arrest equipment',

    ],

    controls: const [

      'Guardrails, toe boards and protected openings',

      'Inspected scaffolds, towers and MEWPs',

      'Anchorage systems suitable for the task',

      'Dropped-object controls and exclusion zones',

      'Weather and wind monitoring',

    ],

    verification: const [

      'Inspect access and edge protection before use',

      'Check harnesses, lanyards and anchors where applicable',

      'Verify openings are securely covered or guarded',

      'Confirm rescue equipment and trained responders',

      'Stop when weather or visibility makes the task unsafe',

    ],

    records: const [

      'Current approved Work at Height risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Prevent access below a fall or dropped-object hazard, raise the alarm for a fall event and implement the planned rescue without creating a second casualty.',

  ),

  'dubai_scaffolding': _TopicDetail(

    purpose: 'Controls scaffold design, erection, alteration, inspection, access, loading and use so the temporary access structure remains stable throughout its service life.',

    hazards: const [

      'Collapse or overturning',

      'Falls from incomplete or unguarded platforms',

      'Falling materials',

      'Overloading or unauthorised modification',

    ],

    requirements: const [

      'Use competent scaffold personnel',

      'Provide a suitable foundation and stable configuration',

      'Install platforms, guardrails, toe boards and safe access',

      'Control loading and prevent unauthorised alteration',

      'Inspect after erection and after events that could affect stability',

    ],

    controls: const [

      'Base plates, sole boards and ties as required',

      'Complete working platforms and protected edges',

      'Safe ladders or stair access',

      'Scaffold status/tagging system',

      'Controlled exclusion zones during erection or dismantling',

    ],

    verification: const [

      'Check foundations and ties',

      'Verify guardrails, toe boards and platform condition',

      'Confirm access is complete',

      'Check inspection status and defects',

      'Compare intended load with actual stored materials',

    ],

    records: const [

      'Current approved Scaffolding Safety risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Evacuate the scaffold and exclusion zone after suspected movement, impact or instability; prevent re-entry until competent assessment confirms safety.',

  ),

  'dubai_lifting': _TopicDetail(

    purpose: 'Controls planning, lifting equipment, accessories, personnel, exclusion zones and communication for crane and lifting activities.',

    hazards: const [

      'Dropped loads',

      'Crane or equipment overturning',

      'People entering the lifting zone',

      'Failure of lifting accessories or communication',

    ],

    requirements: const [

      'Plan lifts according to load, radius and site constraints',

      'Use competent lifting personnel',

      'Verify equipment and accessories are suitable and inspected',

      'Establish exclusion zones and communication methods',

      'Control weather and ground conditions',

    ],

    controls: const [

      'Lift plan and lifting sequence',

      'Certified or inspected equipment and accessories',

      'Competent operator, rigger and signaler',

      'Tag lines where appropriate',

      'Defined landing and storage areas',

    ],

    verification: const [

      'Check certificates/inspection status',

      'Inspect slings, shackles and hooks',

      'Verify load weight and centre of gravity',

      'Confirm exclusion zone is effective',

      'Stop for abnormal wind, poor visibility or loss of communication',

    ],

    records: const [

      'Current approved Lifting Operations risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Stop the lift for instability, overload, failed communication or any person entering the danger zone; secure the load and make the area safe.',

  ),

  'dubai_excavation': _TopicDetail(

    purpose: 'Controls ground disturbance, excavation stability, access, underground services, water, plant interaction and worker protection.',

    hazards: const [

      'Collapse or ground failure',

      'Buried services',

      'Falls into excavations',

      'Plant or vehicles entering the excavation',

      'Water ingress or hazardous atmosphere',

    ],

    requirements: const [

      'Locate and verify underground services before digging',

      'Assess ground conditions and required support',

      'Provide safe access and egress',

      'Keep spoil, plant and loads away from edges as required',

      'Inspect excavations after changes, rain or other destabilising events',

    ],

    controls: const [

      'Shoring, benching or battering where required',

      'Edge protection and barriers',

      'Safe ladders or access routes',

      'Service detection and permit controls',

      'Water control and atmospheric checks where applicable',

    ],

    verification: const [

      'Inspect faces, support systems and edges before entry',

      'Check access points are secure',

      'Verify service markings remain visible',

      'Confirm plant exclusion distances',

      'Reassess after rain, vibration or ground movement',

    ],

    records: const [

      'Current approved Excavation & Trenching risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Evacuate the excavation for signs of collapse, uncontrolled water, service strike or unsafe atmosphere. Prevent entry until competent assessment restores safe conditions.',

  ),

  'dubai_confined_space': _TopicDetail(

    purpose: 'Controls entry into spaces that may contain hazardous atmospheres, restricted access, engulfment or other conditions requiring specialised controls.',

    hazards: const [

      'Oxygen deficiency or toxic gases',

      'Fire or explosion',

      'Engulfment',

      'Entrapment and difficult rescue',

      'Uncontrolled energy or connected systems',

    ],

    requirements: const [

      'Identify and classify the space before entry',

      'Isolate connected systems and energy sources',

      'Issue and control the required permit',

      'Test atmosphere before and during entry as required',

      'Provide trained entrants, attendant and rescue arrangements',

    ],

    controls: const [

      'Ventilation and continuous/periodic gas monitoring',

      'Low-voltage or suitable electrical equipment',

      'Harness and lifeline where required',

      'Dedicated standby attendant',

      'Emergency rescue equipment and trained responders',

    ],

    verification: const [

      'Check permit, isolation and test results',

      'Verify ventilation is operating',

      'Confirm attendant remains at the entry point',

      'Test monitors before use',

      'Confirm rescue equipment is immediately available',

    ],

    records: const [

      'Current approved Confined Space Entry risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Do not enter or remain in a space with an unsafe atmosphere or failed critical control. Raise the alarm and use planned rescue arrangements; never create an unplanned rescuer casualty.',

  ),

  'dubai_electrical': _TopicDetail(

    purpose: 'Controls electrical installation, temporary power, isolation, testing, distribution equipment and work near electrical hazards.',

    hazards: const [

      'Electric shock and arc flash',

      'Unexpected energisation',

      'Damaged cables or equipment',

      'Poor temporary distribution',

      'Contact with overhead or buried services',

    ],

    requirements: const [

      'Use competent authorised electrical personnel',

      'Identify and isolate energy before work',

      'Protect temporary installations from damage and water',

      'Use suitable distribution and residual-current protection where required',

      'Control work near overhead and underground services',

    ],

    controls: const [

      'Lockout/tagout or equivalent isolation',

      'Inspection of cables, plugs, boards and tools',

      'Suitable earthing/bonding arrangements',

      'Protected cable routes',

      'Electrical work permits where required',

    ],

    verification: const [

      'Check boards are closed and identified',

      'Inspect leads and plugs before use',

      'Verify isolation before intervention',

      'Check protection devices and test status',

      'Keep electrical equipment away from unsuitable wet conditions',

    ],

    records: const [

      'Current approved Electrical Safety risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Isolate the supply, keep people clear and raise the alarm after electrical contact, arcing, smoke or suspected energisation. Provide first aid/medical response through trained personnel.',

  ),

  'dubai_hot_work': _TopicDetail(

    purpose: 'Controls welding, cutting, grinding and other spark, flame or heat-producing activities that can ignite combustibles or create hazardous fumes.',

    hazards: const [

      'Fire and explosion',

      'Burns',

      'Welding fumes and gases',

      'Gas cylinder failure',

      'Ignition of hidden combustibles',

    ],

    requirements: const [

      'Authorise hot work under the applicable permit system',

      'Inspect the work area for combustibles and openings',

      'Provide suitable fire protection and fire watch',

      'Control gas cylinders and hoses',

      'Check ventilation and fume controls',

    ],

    controls: const [

      'Remove or protect combustible materials',

      'Fire extinguishers and fire hose where appropriate',

      'Screens for welding arc',

      'Cylinder separation, securing and leak checks',

      'Post-work fire watch when required',

    ],

    verification: const [

      'Inspect adjacent and lower levels for ignition paths',

      'Verify extinguishers are accessible',

      'Check hoses, regulators and cylinders',

      'Confirm fire watch is assigned',

      'Reinspect after completion for smouldering materials',

    ],

    records: const [

      'Current approved Hot Work Safety risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Stop hot work on discovery of uncontrolled combustibles, gas leakage, inadequate fire protection or unsafe atmosphere. Raise the alarm for any fire and evacuate as required.',

  ),

  'dubai_traffic': _TopicDetail(

    purpose: 'Controls movement of vehicles, mobile plant, pedestrians and deliveries within and around construction work areas.',

    hazards: const [

      'Vehicle-pedestrian collision',

      'Reversing incidents',

      'Plant overturning',

      'Congestion and blocked emergency routes',

    ],

    requirements: const [

      'Plan site traffic routes and interfaces',

      'Separate pedestrians from moving vehicles',

      'Control reversing and blind spots',

      'Set speed limits and vehicle rules',

      'Coordinate deliveries and lifting/plant movements',

    ],

    controls: const [

      'Physical barriers and walkways',

      'Banksmen or spotters where required',

      'Reversing alarms/cameras as appropriate',

      'Lighting and signs',

      'Defined parking, loading and turning areas',

    ],

    verification: const [

      'Walk routes at different times of the shift',

      'Check barriers and crossings',

      'Verify drivers and operators are authorised',

      'Keep fire and emergency access clear',

      'Correct damaged signs or route controls immediately',

    ],

    records: const [

      'Current approved Construction Traffic Management risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Stop vehicle movement where pedestrians are exposed to uncontrolled traffic or visibility is inadequate. Secure the area and re-establish segregation before restarting.',

  ),

  'dubai_demolition': _TopicDetail(

    purpose: 'Controls planned dismantling and demolition through structural assessment, sequencing, exclusion zones, services isolation and controlled debris handling.',

    hazards: const [

      'Unexpected structural collapse',

      'Falling debris',

      'Uncontrolled service energy',

      'Dust and hazardous materials',

      'Plant interaction and public exposure',

    ],

    requirements: const [

      'Complete a competent structural and demolition assessment',

      'Identify and isolate utilities',

      'Define the demolition sequence and exclusion zone',

      'Control dust, debris and temporary stability',

      'Coordinate specialist hazards such as asbestos where applicable',

    ],

    controls: const [

      'Engineered sequence and temporary support',

      'Physical exclusion and controlled access',

      'Water/dust suppression',

      'Plant inspection and operator competency',

      'Emergency arrangements for collapse or service strike',

    ],

    verification: const [

      'Verify isolation before demolition starts',

      'Inspect temporary supports and structural condition',

      'Check exclusion zone integrity',

      'Monitor dust and debris movement',

      'Stop if unexpected cracking, movement or buried services are found',

    ],

    records: const [

      'Current approved Demolition Safety risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Stop demolition immediately for unexpected movement, structural instability or uncontrolled service exposure; evacuate the danger zone and obtain competent assessment.',

  ),

  'dubai_temporary_works': _TopicDetail(

    purpose: 'Controls temporary structures and support systems such as falsework, formwork, propping, access platforms and temporary stability arrangements.',

    hazards: const [

      'Collapse or instability',

      'Overloading',

      'Incorrect assembly',

      'Uncontrolled changes',

      'Interaction with permanent works',

    ],

    requirements: const [

      'Identify temporary works and appoint competent design/control responsibility',

      'Review design assumptions and loads',

      'Control erection, inspection and striking sequence',

      'Prevent unauthorised modifications',

      'Monitor temporary works during changing conditions',

    ],

    controls: const [

      'Approved drawings and calculations where required',

      'Hold points before loading',

      'Inspection after alteration or adverse events',

      'Load limits and status identification',

      'Controlled dismantling sequence',

    ],

    verification: const [

      'Verify installation against approved configuration',

      'Check supports, connections and bracing',

      'Confirm load paths remain valid',

      'Inspect after impact or unusual loading',

      'Control access below or around unstable temporary works',

    ],

    records: const [

      'Current approved Temporary Works Safety risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Evacuate the affected area after movement, distress or suspected overload. Prevent re-entry until temporary works are assessed and made safe.',

  ),

  'dubai_heat_stress': _TopicDetail(

    purpose: 'Controls heat exposure through work planning, hydration, rest, acclimatisation, environmental assessment and recognition of heat illness.',

    hazards: const [

      'Heat exhaustion',

      'Heat stroke',

      'Dehydration',

      'Reduced concentration and increased error risk',

    ],

    requirements: const [

      'Assess heat conditions and task intensity',

      'Provide cool drinking water and suitable shaded recovery areas',

      'Schedule heavy work to reduce peak heat exposure',

      'Use acclimatisation and work/rest arrangements',

      'Train workers to recognise symptoms and respond early',

    ],

    controls: const [

      'Shade and ventilation',

      'Hydration stations',

      'Work/rest scheduling',

      'Buddy monitoring for symptoms',

      'Suitable clothing and PPE compatible with the task',

    ],

    verification: const [

      'Check water and shade at the work front',

      'Observe worker condition and workload',

      'Monitor heat conditions according to project arrangements',

      'Verify new workers receive acclimatisation controls',

      'Record and escalate heat illness cases',

    ],

    records: const [

      'Current approved Heat Stress Management risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Stop or modify work for signs of serious heat illness. Move the affected worker to a cool area, raise medical assistance and follow the emergency plan.',

  ),

  'dubai_occupational_health': _TopicDetail(

    purpose: 'Addresses health risks arising from work activities, exposure to hazardous agents, fatigue, ergonomics and other occupational factors.',

    hazards: const [

      'Noise and vibration exposure',

      'Chemical or dust exposure',

      'Musculoskeletal strain',

      'Fatigue and occupational illness',

    ],

    requirements: const [

      'Identify occupational health hazards during risk assessment',

      'Use exposure controls and monitoring where needed',

      'Provide health surveillance when applicable',

      'Manage fatigue and ergonomic risks',

      'Maintain confidential health-related records appropriately',

    ],

    controls: const [

      'Engineering controls for noise/dust',

      'Suitable PPE and hygiene facilities',

      'Exposure monitoring',

      'Ergonomic task design',

      'Health surveillance and referral arrangements',

    ],

    verification: const [

      'Check control measures at source',

      'Verify monitoring is current',

      'Observe hygiene and welfare arrangements',

      'Check high-risk workers are covered by required programmes',

      'Review trends in occupational health findings',

    ],

    records: const [

      'Current approved Occupational Health risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Remove personnel from harmful exposure, control the source and arrange prompt medical assessment when acute exposure or serious symptoms occur.',

  ),

  'dubai_ppe': _TopicDetail(

    purpose: 'Controls selection, issue, use, inspection, maintenance and replacement of PPE based on assessed hazards and task requirements.',

    hazards: const [

      'Incorrect PPE selection',

      'Damaged or poorly fitted PPE',

      'PPE incompatibility',

      'Failure to use required protection',

    ],

    requirements: const [

      'Select PPE from the task risk assessment',

      'Ensure correct fit and compatibility',

      'Train workers in use, limitations and care',

      'Inspect and replace damaged equipment',

      'Do not rely on PPE where higher-level controls are practicable',

    ],

    controls: const [

      'Head, eye, hearing, hand and foot protection as required',

      'Protective clothing and respiratory protection where assessed',

      'Fall protection where applicable',

      'Storage and cleaning arrangements',

      'Issue and replacement records',

    ],

    verification: const [

      'Check PPE condition before work',

      'Verify fit and compatibility',

      'Confirm task-specific PPE is available',

      'Observe actual use in the field',

      'Remove damaged or expired equipment from service',

    ],

    records: const [

      'Current approved Personal Protective Equipment risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Stop the task when required PPE is unavailable, damaged or incompatible. Replace or correct protection before restarting.',

  ),

  'dubai_emergency': _TopicDetail(

    purpose: 'Ensures the project can recognise emergencies, raise the alarm, communicate, evacuate, account for personnel and recover safely.',

    hazards: const [

      'Delayed alarm',

      'Poor evacuation routes',

      'Unclear roles',

      'Missing emergency equipment',

      'Unaccounted personnel',

    ],

    requirements: const [

      'Identify credible emergency scenarios',

      'Maintain emergency plans and contact lists',

      'Provide alarms, routes, assembly points and emergency equipment',

      'Train and drill personnel',

      'Review performance after drills and real incidents',

    ],

    controls: const [

      'Clear evacuation routes',

      'Emergency lighting and signage',

      'First aid and firefighting equipment',

      'Assembly and accountability arrangements',

      'Defined incident command and communication',

    ],

    verification: const [

      'Walk emergency routes regularly',

      'Check assembly points are accessible',

      'Verify emergency numbers are current',

      'Inspect emergency equipment',

      'Record drill findings and close corrective actions',

    ],

    records: const [

      'Current approved Emergency Preparedness & Response risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Raise the alarm, stop work where safe, evacuate or shelter as directed, account for personnel and allow only authorised re-entry.',

  ),

  'dubai_incident': _TopicDetail(

    purpose: 'Provides a structured process for immediate response, notification, evidence preservation, investigation, root-cause analysis and corrective action.',

    hazards: const [

      'Delayed reporting',

      'Loss of evidence',

      'Incorrect root-cause identification',

      'Repeated events due to weak actions',

    ],

    requirements: const [

      'Make the area safe and provide first aid',

      'Notify the required project/authority contacts',

      'Preserve evidence where practicable',

      'Investigate causes and contributing factors',

      'Implement and verify corrective actions',

    ],

    controls: const [

      'Defined notification thresholds',

      'Scene preservation',

      'Witness and evidence collection',

      'Root-cause analysis',

      'Action tracking and effectiveness review',

    ],

    verification: const [

      'Check incident records for completeness',

      'Verify actions address underlying causes',

      'Review repeat events',

      'Confirm lessons are communicated',

      'Escalate overdue high-risk actions',

    ],

    records: const [

      'Current approved Incident Reporting & Investigation risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Protect people first, secure the scene and initiate emergency/notification arrangements. Do not disturb critical evidence unless necessary to prevent further harm.',

  ),

  'dubai_contractor': _TopicDetail(

    purpose: 'Controls contractor selection, mobilisation, competency, interface risks, supervision and performance throughout the contract lifecycle.',

    hazards: const [

      'Unknown contractor competence',

      'Conflicting procedures',

      'Poor supervision',

      'Interface and simultaneous-operation risks',

    ],

    requirements: const [

      'Prequalify contractors against HSE requirements',

      'Review plans, risk assessments and method statements',

      'Verify competency and mobilisation requirements',

      'Define interface responsibilities',

      'Monitor performance and enforce corrective action',

    ],

    controls: const [

      'Contractor induction',

      'Competency records',

      'Joint inspections and coordination meetings',

      'Permit and RAMS controls',

      'Performance scorecards and action tracking',

    ],

    verification: const [

      'Sample contractor documents against field conditions',

      'Verify supervisors are present',

      'Check workforce competency',

      'Review open actions and repeat findings',

      'Escalate serious non-compliance promptly',

    ],

    records: const [

      'Current approved Contractor & Subcontractor HSE Management risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Suspend contractor activity where serious non-compliance creates immediate danger and restart only after effective controls are verified.',

  ),

  'dubai_environment': _TopicDetail(

    purpose: 'Controls construction waste, spills, emissions, water protection, storage and disposal activities that can affect people or the environment.',

    hazards: const [

      'Chemical or fuel spills',

      'Uncontrolled waste',

      'Drain or watercourse contamination',

      'Dust, noise or nuisance emissions',

    ],

    requirements: const [

      'Identify environmental aspects and legal/project requirements',

      'Segregate and store waste safely',

      'Control fuels and hazardous substances',

      'Protect drains and watercourses',

      'Use approved disposal and transfer arrangements',

    ],

    controls: const [

      'Bunds and spill kits',

      'Covered or secure waste storage',

      'Waste segregation and labelling',

      'Drain protection',

      'Spill response procedures',

    ],

    verification: const [

      'Inspect storage and bunds',

      'Check waste containers are labelled and closed',

      'Verify spill kits are stocked',

      'Look for leaks and contaminated drainage',

      'Track waste transfer and corrective actions',

    ],

    records: const [

      'Current approved Environmental & Waste Management risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Stop the source if safe, contain the release, protect drains, notify responsible personnel and follow the spill/emergency response procedure.',

  ),

  'dubai_inspection': _TopicDetail(

    purpose: 'Uses planned inspections and audits to verify compliance, identify unsafe conditions and test whether HSE systems work in practice.',

    hazards: const [

      'Superficial inspections',

      'Missed critical hazards',

      'Poor corrective-action follow-up',

      'Audits disconnected from field conditions',

    ],

    requirements: const [

      'Plan inspections according to risk',

      'Use competent inspectors',

      'Record clear evidence and responsible actions',

      'Escalate critical findings immediately',

      'Verify effectiveness of corrective actions',

    ],

    controls: const [

      'Risk-based inspection frequency',

      'Photographic or objective evidence where appropriate',

      'Clear finding classifications',

      'Action owner and due date',

      'Close-out verification',

    ],

    verification: const [

      'Walk active work fronts',

      'Sample high-risk controls',

      'Compare documents with actual practice',

      'Review repeat findings',

      'Verify closed actions in the field',

    ],

    records: const [

      'Current approved HSE Inspection & Audit risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Escalate critical findings immediately and stop affected work until an effective control is verified.',

  ),

  'dubai_performance': _TopicDetail(

    purpose: 'Tracks leading and lagging indicators to identify deterioration, verify control effectiveness and support management decisions.',

    hazards: const [

      'Focusing only on injury statistics',

      'Poor-quality data',

      'Failure to act on adverse trends',

      'Targets that encourage under-reporting',

    ],

    requirements: const [

      'Define meaningful leading and lagging indicators',

      'Set responsibilities and reporting frequency',

      'Analyse trends and recurring issues',

      'Use data to target preventive actions',

      'Review performance at management level',

    ],

    controls: const [

      'Inspection completion',

      'Action closure performance',

      'Training and competency indicators',

      'Incident and near-miss trends',

      'High-risk activity assurance metrics',

    ],

    verification: const [

      'Validate reported data against records',

      'Investigate sudden unexplained changes',

      'Review repeat findings',

      'Track overdue critical actions',

      'Use trends to target field verification',

    ],

    records: const [

      'Current approved HSE Performance Monitoring risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Treat significant deterioration as an early warning: escalate the issue, identify the cause and implement corrective measures before serious harm occurs.',

  ),

  'dubai_building_code': _TopicDetail(

    purpose: 'Provides the building-level health, safety, welfare and environmental requirements relevant to design and construction interfaces.',

    hazards: const [

      'Design features creating life-safety risks',

      'Unsafe temporary interfaces',

      'Non-compliant building elements',

      'Uncontrolled changes from approved design',

    ],

    requirements: const [

      'Use the applicable Dubai Building Code requirements for the project',

      'Coordinate safety-critical design information',

      'Control changes through the approved process',

      'Verify construction matches approved information',

      'Coordinate building-control and specialist requirements',

    ],

    controls: const [

      'Approved drawings and specifications',

      'Design change control',

      'Fire/life-safety interfaces',

      'Safe access and egress',

      'Inspection and testing of safety-critical systems',

    ],

    verification: const [

      'Check current approved drawings',

      'Verify safety-critical changes are controlled',

      'Inspect interfaces between temporary and permanent works',

      'Confirm access/egress remains usable',

      'Escalate design uncertainty to competent parties',

    ],

    records: const [

      'Current approved Dubai Building Code & Safety risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Restrict the affected area for an immediate life-safety concern and involve competent design/building-control or emergency authorities as applicable.',

  ),

  'dubai_permit_to_work': _TopicDetail(

    purpose: 'Controls defined high-risk activities by confirming hazards, isolations, precautions, authorisation, validity and handover before work starts.',

    hazards: const [

      'Work without authorisation',

      'Incomplete isolation',

      'Permit conditions not matching the job',

      'Permit remaining active after conditions change',

    ],

    requirements: const [

      'Identify tasks requiring permits',

      'Define hazards and controls before issue',

      'Verify isolations and precautions',

      'Authorise only competent persons',

      'Suspend, cancel and revalidate permits when conditions change',

    ],

    controls: const [

      'Permit board/register',

      'Isolation certificates',

      'Gas testing where required',

      'Site verification before start',

      'Handover and close-out controls',

    ],

    verification: const [

      'Check permit validity and location',

      'Verify controls physically at the work front',

      'Confirm isolations remain effective',

      'Check permit holder and supervisor understanding',

      'Close permits only after the area is safe',

    ],

    records: const [

      'Current approved Permit to Work System risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Suspend or cancel the permit when conditions change, controls fail or unauthorised work is found. Revalidate before restarting.',

  ),

  'dubai_cop_site_establishment': _TopicDetail(

    purpose: 'Controls site layout, mobilisation, temporary services, welfare interfaces, access, emergency arrangements and general construction-site organisation.',

    hazards: const [

      'Poor site layout',

      'Unsafe temporary services',

      'Blocked emergency access',

      'Uncontrolled site entry',

    ],

    requirements: const [

      'Plan the site before mobilisation',

      'Separate work, storage, traffic and welfare areas',

      'Provide safe temporary utilities',

      'Maintain emergency access and routes',

      'Review layout as construction progresses',

    ],

    controls: const [

      'Site layout plan',

      'Secure boundaries and controlled entry',

      'Temporary electrical and water controls',

      'Welfare and first-aid provisions',

      'Emergency route protection',

    ],

    verification: const [

      'Inspect site entrances and routes',

      'Check temporary services for damage',

      'Confirm emergency access is clear',

      'Verify welfare facilities are usable',

      'Remove unsafe accumulations and obstructions',

    ],

    records: const [

      'Current approved Code of Practice: Site Establishment & General Arrangements risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Restrict access to unsafe zones, secure temporary services and maintain emergency access while the site arrangement is corrected.',

  ),

  'dubai_cop_public_protection': _TopicDetail(

    purpose: 'Controls interfaces between construction activities and the public, neighbours, visitors and third parties.',

    hazards: const [

      'Public entry into work zones',

      'Falling objects reaching public areas',

      'Vehicle interface with pedestrians',

      'Inadequate hoarding or barriers',

    ],

    requirements: const [

      'Define the public interface risk',

      'Provide secure perimeter controls',

      'Protect public routes from construction hazards',

      'Control deliveries and vehicle crossings',

      'Maintain warning signs and communication',

    ],

    controls: const [

      'Hoarding and gates',

      'Covered or protected walkways where required',

      'Banksman arrangements',

      'Falling-object controls',

      'Security and access checks',

    ],

    verification: const [

      'Inspect perimeter continuously',

      'Check gates close and remain secure',

      'Verify public routes are unobstructed',

      'Inspect overhead protection',

      'Respond to public complaints or near misses',

    ],

    records: const [

      'Current approved Code of Practice: Site Security & Public Protection risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Stop the public-interface activity, secure the perimeter and remove the source of danger before normal access resumes.',

  ),

  'dubai_cop_access_housekeeping': _TopicDetail(

    purpose: 'Maintains safe movement routes, stairs, ladders, platforms and work areas through effective access control and housekeeping.',

    hazards: const [

      'Trips and falls',

      'Blocked escape routes',

      'Poor access to work areas',

      'Materials falling from routes',

    ],

    requirements: const [

      'Provide safe routes to all active work areas',

      'Keep stairs and walkways clear',

      'Remove waste progressively',

      'Protect openings and level changes',

      'Maintain emergency egress at all times',

    ],

    controls: const [

      'Defined walkways',

      'Guarded openings',

      'Good lighting',

      'Routine housekeeping',

      'Waste collection points',

    ],

    verification: const [

      'Walk the routes during active work',

      'Check stairs and ladders',

      'Remove trailing cables and debris',

      'Verify exits are clear',

      'Correct damaged surfaces or barriers',

    ],

    records: const [

      'Current approved Code of Practice: Access, Egress & Housekeeping risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Restrict unsafe routes, provide an alternative safe route and remove the obstruction or hazard before reopening the area.',

  ),

  'dubai_cop_welfare_facilities': _TopicDetail(

    purpose: 'Controls basic welfare provisions including drinking water, sanitation, washing, rest and first-aid arrangements for construction workers.',

    hazards: const [

      'Dehydration',

      'Poor sanitation and hygiene',

      'Inadequate rest/recovery',

      'Delayed first aid',

    ],

    requirements: const [

      'Provide sufficient potable drinking water',

      'Provide clean toilets and washing facilities',

      'Provide suitable rest areas',

      'Maintain first-aid arrangements',

      'Clean and service facilities regularly',

    ],

    controls: const [

      'Accessible water points',

      'Toilets and washing facilities',

      'Rest/shade areas',

      'First-aid boxes and trained personnel',

      'Cleaning and maintenance schedules',

    ],

    verification: const [

      'Check facilities at active work fronts',

      'Verify water is available and suitable',

      'Inspect cleanliness',

      'Check first-aid supplies',

      'Confirm facilities remain accessible during shifts',

    ],

    records: const [

      'Current approved Code of Practice: Worker Welfare & Site Facilities risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Provide immediate access to drinking water, sanitation, rest or first aid as required; stop work where welfare failure creates a serious health risk.',

  ),

  'dubai_cop_material_storage': _TopicDetail(

    purpose: 'Controls safe receipt, stacking, storage, movement and manual/mechanical handling of construction materials.',

    hazards: const [

      'Falling or collapsing stacks',

      'Overloading storage areas',

      'Manual handling injuries',

      'Vehicle/material interface',

    ],

    requirements: const [

      'Plan storage for stability and access',

      'Segregate incompatible or hazardous materials',

      'Respect load limits',

      'Keep routes and fire access clear',

      'Use suitable lifting/handling equipment',

    ],

    controls: const [

      'Stable stacks and racking',

      'Securing of long or cylindrical materials',

      'Safe manual handling methods',

      'Forklift exclusion and operating controls',

      'Clear labelling and storage zones',

    ],

    verification: const [

      'Check stacks for leaning or damage',

      'Verify storage limits',

      'Keep heavy items low where appropriate',

      'Inspect racking and handling equipment',

      'Remove unstable materials safely',

    ],

    records: const [

      'Current approved Code of Practice: Material Storage & Handling risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Isolate unstable stacks or damaged storage systems, keep people outside the fall zone and arrange safe recovery by competent personnel.',

  ),

  'dubai_cop_formwork_falsework': _TopicDetail(

    purpose: 'Controls temporary support systems used to carry concrete, loads and construction forces until the structure can safely support itself.',

    hazards: const [

      'Collapse under fresh concrete load',

      'Incorrect assembly',

      'Premature striking',

      'Overloading or impact',

    ],

    requirements: const [

      'Use approved design and sequence where required',

      'Erect on suitable foundations',

      'Provide adequate bracing and connections',

      'Control loading and concrete placement sequence',

      'Strike only when authorised and conditions are satisfied',

    ],

    controls: const [

      'Inspection before loading',

      'Pour sequence control',

      'Bracing and support checks',

      'Exclusion zones below',

      'Controlled striking and dismantling',

    ],

    verification: const [

      'Verify configuration against approved information',

      'Inspect supports and connections',

      'Check for movement during loading',

      'Control access below',

      'Reinspect after impact or unexpected loading',

    ],

    records: const [

      'Current approved Code of Practice: Formwork, Falsework & Temporary Support risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Evacuate the affected zone after movement, overloading or instability and prevent re-entry until temporary works are assessed and made safe.',

  ),

  'dubai_cop_rebar_concrete': _TopicDetail(

    purpose: 'Controls reinforcement, concrete placement, pumps, hoses, vibration, cutting and associated construction activities.',

    hazards: const [

      'Impaling on exposed reinforcement',

      'Concrete hose whip',

      'Formwork movement',

      'Chemical burns from cement products',

      'Plant interaction',

    ],

    requirements: const [

      'Cap or otherwise protect exposed reinforcement',

      'Plan concrete delivery and pump setup',

      'Secure hoses and control line movement',

      'Provide suitable PPE and hygiene facilities',

      'Coordinate workers and plant during pours',

    ],

    controls: const [

      'Rebar protection',

      'Stable pump and hose arrangements',

      'Exclusion zones',

      'Safe access around formwork',

      'Wash facilities and emergency eyewash where needed',

    ],

    verification: const [

      'Inspect rebar protection',

      'Check pump and hose condition',

      'Verify pour sequence controls',

      'Monitor formwork movement',

      'Confirm wash/eyewash arrangements are accessible',

    ],

    records: const [

      'Current approved Code of Practice: Reinforcement, Concrete & Construction Operations risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Stop the operation after uncontrolled hose movement, formwork movement, serious impalement exposure or equipment failure; secure the area before restarting.',

  ),

  'dubai_cop_machinery_guarding': _TopicDetail(

    purpose: 'Controls machinery selection, guarding, isolation, inspection and safe operation to prevent contact with moving or hazardous parts.',

    hazards: const [

      'Entanglement and crushing',

      'Unexpected start-up',

      'Defeated guards or interlocks',

      'Poor maintenance',

    ],

    requirements: const [

      'Provide suitable guarding',

      'Prevent access to dangerous moving parts',

      'Isolate energy before maintenance',

      'Authorise competent operators',

      'Inspect and maintain safety devices',

    ],

    controls: const [

      'Fixed/interlocked guards',

      'Emergency stops',

      'Isolation and lockout',

      'Maintenance inspections',

      'Operator training and instructions',

    ],

    verification: const [

      'Check guards are fitted and effective',

      'Test emergency stops as required',

      'Inspect cables, belts and moving parts',

      'Verify isolation before maintenance',

      'Remove defective machinery from service',

    ],

    records: const [

      'Current approved Code of Practice: Plant, Machinery & Guarding risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Stop and isolate machinery when a guard is missing, defeated or damaged, or when an emergency stop/interlock is unreliable.',

  ),

  'dubai_cop_ladders_mobile_towers': _TopicDetail(

    purpose: 'Controls selection, setup, stability, inspection and use of ladders and mobile access towers for temporary access and light work.',

    hazards: const [

      'Falls from height',

      'Tower overturning',

      'Incorrect ladder angle/setup',

      'Moving a tower while occupied',

    ],

    requirements: const [

      'Select the correct access system for the task',

      'Use sound level ground and stable bases',

      'Secure ladders and towers as required',

      'Maintain three-point contact on ladders',

      'Do not move mobile towers while occupied unless specifically designed and controlled',

    ],

    controls: const [

      'Pre-use inspection',

      'Guardrails and toe boards on towers',

      'Lockable castors',

      'Safe ladder angle and footing',

      'Controlled access and platform loading',

    ],

    verification: const [

      'Check ladder condition',

      'Verify tower components and locking devices',

      'Confirm platform guardrails are complete',

      'Check ground stability',

      'Remove defective equipment from service',

    ],

    records: const [

      'Current approved Code of Practice: Ladders & Mobile Access Towers risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Stop use of an unstable, damaged or incorrectly erected access system and prevent access until it is corrected and inspected.',

  ),

  'dubai_cop_fire_emergency': _TopicDetail(

    purpose: 'Controls ignition sources, combustible materials, fire protection, emergency routes, alarms and response arrangements on construction sites.',

    hazards: const [

      'Fire from hot work',

      'Combustible storage',

      'Blocked escape routes',

      'Inadequate firefighting equipment',

    ],

    requirements: const [

      'Control ignition sources',

      'Store combustibles safely',

      'Provide suitable firefighting equipment',

      'Maintain escape routes and emergency access',

      'Train workers and conduct drills as required',

    ],

    controls: const [

      'Fire extinguishers and firefighting systems',

      'Hot-work controls',

      'Emergency lighting/signage',

      'Fire points and access',

      'Alarm and evacuation arrangements',

    ],

    verification: const [

      'Inspect fire equipment',

      'Check escape routes',

      'Look for combustible accumulation',

      'Verify hot-work precautions',

      'Confirm emergency contacts and assembly arrangements',

    ],

    records: const [

      'Current approved Code of Practice: Fire Prevention & Emergency Arrangements risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Raise the alarm, stop work, evacuate through safe routes and use firefighting equipment only when trained and the situation is suitable for first-aid firefighting.',

  ),

  'dubai_cop_signs_barricading': _TopicDetail(

    purpose: 'Controls visual warnings, physical barriers and exclusion zones so hazards are clearly communicated and unauthorised entry is prevented.',

    hazards: const [

      'People entering hazardous areas',

      'Poorly visible warnings',

      'Barriers removed without control',

      'Confusion between pedestrian and work zones',

    ],

    requirements: const [

      'Select signs that communicate the actual hazard',

      'Use robust barriers for physical exclusion',

      'Maintain visibility and access control',

      'Define boundaries for lifting, excavation and overhead work',

      'Inspect and reinstate damaged controls',

    ],

    controls: const [

      'Warning and mandatory signs',

      'Rigid barriers where needed',

      'Access gates and controlled entry',

      'Reflective/visible markings',

      'Exclusion-zone inspection',

    ],

    verification: const [

      'Check signs are legible and correctly positioned',

      'Verify barriers are stable',

      'Confirm no unauthorised gaps exist',

      'Inspect after work-front changes',

      'Remove obsolete signs that cause confusion',

    ],

    records: const [

      'Current approved Code of Practice: Safety Signs, Barricading & Exclusion Zones risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Stop or isolate the affected activity when the hazard boundary is unclear or breached; restore the barrier and warning system before work continues.',

  ),

  'dubai_cop_lighting_weather': _TopicDetail(

    purpose: 'Controls visibility, temporary lighting and weather-related conditions that can change the safety of construction activities.',

    hazards: const [

      'Poor visibility and trips',

      'Glare or shadowing',

      'Wind affecting lifting or work at height',

      'Rain or weather affecting electrical/ground conditions',

    ],

    requirements: const [

      'Provide adequate task and route lighting',

      'Control glare and shadows',

      'Monitor weather relevant to the activity',

      'Protect temporary lighting and cables',

      'Define stop-work criteria for adverse conditions',

    ],

    controls: const [

      'Illuminated access routes',

      'Protected temporary lights',

      'Weather monitoring',

      'Wind limits for lifting/height activities',

      'Additional lighting for night work',

    ],

    verification: const [

      'Walk work areas during the actual shift',

      'Check dark spots and glare',

      'Inspect light fixtures and cables',

      'Confirm weather limits are understood',

      'Suspend exposed activities when conditions deteriorate',

    ],

    records: const [

      'Current approved Code of Practice: Construction Lighting, Weather & Visibility risk assessment / method statement or applicable control document',

      'Competency, induction and task-specific training evidence',

      'Pre-use, inspection, permit or monitoring records relevant to the activity',

      'Corrective-action and close-out evidence for significant findings',

    ],

    stopWork: 'Suspend work where visibility or weather makes the task unsafe, secure plant/materials and restart only when adequate controls and conditions are restored.',

  ),

};
