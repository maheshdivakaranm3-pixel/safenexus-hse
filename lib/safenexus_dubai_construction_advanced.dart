import 'package:flutter/material.dart';

class DubaiConstructionAdvancedPage extends StatelessWidget {
  const DubaiConstructionAdvancedPage({super.key});

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF075B45);
  static const Color navy = Color(0xFF082653);
  static const Color pageBg = Color(0xFFF4F8FB);

  static const List<_DubaiTopic> topics = [
    _DubaiTopic(
      '01', 'Construction Site HSE Management', Icons.engineering_rounded,
      'Build a controlled site safety system before work starts and keep it active throughout the project.',
      ['Site HSE plan and responsibilities', 'Risk assessment and method statements', 'Permit and authorization controls', 'Induction, toolbox talks and competency', 'Inspection, reporting and corrective action'],
      ['Uncontrolled work interfaces', 'Unidentified hazards', 'Inadequate supervision', 'Poor emergency readiness', 'Failure to close corrective actions'],
      ['Define roles and authority', 'Review RAMS before high-risk work', 'Verify competent persons and training', 'Run planned inspections and document findings', 'Track actions to verified close-out'],
      ['Is the current work scope covered by an approved risk assessment?', 'Are responsible persons and emergency arrangements known to workers?', 'Are open findings assigned with due dates?'],
      'Use the Dubai Municipality construction safety guide and applicable site-control procedures as the primary reference. Treat project/client requirements as additional controls, not replacements.',
      'https://www.dm.gov.ae/municipality-business/',
    ),
    _DubaiTopic(
      '02', 'Site Access, Fencing & Security', Icons.fence_rounded,
      'Control people, vehicles and materials entering or leaving a construction or demolition site.',
      ['Secure perimeter and gates', 'Visitor and worker access control', 'Security guarding', 'Lighting and warning arrangements', 'CCTV and site security where required'],
      ['Unauthorized entry', 'Public interface', 'Vehicle-person interaction', 'Poor night visibility', 'Theft or unsafe material access'],
      ['Keep external fencing secure and maintained', 'Organize gates for entry/exit traffic', 'Provide suitable site lighting', 'Maintain security arrangements', 'Keep materials and equipment in safe storage areas'],
      ['Is the perimeter continuously secure?', 'Are gates controlled and clearly organized?', 'Can pedestrians and vehicles move without unsafe conflict?'],
      'Dubai Municipality Circular 12-11-1 of 2023 requires security guards, suitable surveillance, safe storage, adequate lighting and secure external fencing/gates for construction and demolition sites.',
      'https://www.dm.gov.ae/wp-content/uploads/2024/12/12-11-1.pdf',
    ),
    _DubaiTopic(
      '03', 'PPE & Worker Protection', Icons.health_and_safety_rounded,
      'Select, provide, maintain and enforce PPE according to the hazards of the task and work area.',
      ['Head, eye, foot and hand protection', 'Hearing and respiratory protection', 'Fall protection', 'PPE compatibility', 'Inspection and replacement'],
      ['Falling objects', 'Impact and penetration', 'Chemical exposure', 'Noise and dust', 'Falls from height'],
      ['Use engineering controls first where practicable', 'Select task-specific PPE', 'Check fit and condition', 'Replace damaged PPE', 'Supervise correct use'],
      ['Does PPE match the actual hazard?', 'Is damaged PPE removed from service?', 'Are workers trained in correct use?'],
      'Dubai Municipality construction inspection material identifies protective equipment and personal protection as inspection items, including helmets, safety shoes, gloves, spectacles and fall protection.',
      'https://www.dm.gov.ae/wp-content/uploads/2020/11/06_qua-localorder139.1.0.pdf',
    ),
    _DubaiTopic(
      '04', 'Work at Height & Falling Objects', Icons.height_rounded,
      'Prevent falls of people and materials wherever a person can fall from an elevated position.',
      ['Hierarchy of fall prevention', 'Guardrails and edge protection', 'Safe access', 'Fall arrest systems', 'Dropped-object prevention'],
      ['Unprotected edges', 'Openings', 'Unsafe ladders', 'Dropped tools/materials', 'Improper anchorage'],
      ['Eliminate height work where possible', 'Install collective protection', 'Protect openings and edges', 'Use suitable fall protection', 'Establish exclusion zones below overhead work'],
      ['Are edges/openings physically protected?', 'Is the access system suitable?', 'Are tools and materials secured against falling?'],
      'Apply the project-approved work-at-height controls together with the applicable Dubai Municipality construction safety requirements.',
      'https://www.dm.gov.ae/municipality-business/',
    ),
    _DubaiTopic(
      '05', 'Lifting Operations & Cranes', Icons.precision_manufacturing_rounded,
      'Control crane, hoist, lift and lifting-accessory risks through competent planning, examination and safe operation.',
      ['Lift plan and load assessment', 'SWL/WLL and equipment selection', 'Operator, rigger and signaler competency', 'Ground stability and exclusion zones', 'Inspection and certification'],
      ['Overloading', 'Unstable ground', 'Poor slinging', 'Suspended loads', 'Equipment failure', 'Poor communication'],
      ['Verify current third-party certification', 'Display safe working load', 'Inspect lifting gear before use', 'Control the lifting zone', 'Use competent persons and agreed signals', 'Stop unsafe lifts immediately'],
      ['Is the certificate current and available at site?', 'Is SWL displayed?', 'Is the lifting zone controlled?', 'Has the ground/setup been verified?'],
      'Dubai Municipality Technical Guidelines DM-HSD-GU48-ECLA2 states that cranes, hoists, lifts and other lifting equipment used in construction sites shall be tested and certified by an EIAC-accredited third party every 12 months; the compliance certificate is to be kept at the site.',
      'https://www.dm.gov.ae/wp-content/uploads/2025/02/DM-HSD-GU48-ECLA2_Technical-Guidelines-for-Examination-and-Certification-of-Cranes-Hoists-Lifts-and-Other-Lifting-Equipment_V5.pdf',
    ),
    _DubaiTopic(
      '06', 'Scaffolding, Ladders & Platforms', Icons.construction_rounded,
      'Provide stable, suitable and protected temporary access and working platforms.',
      ['Foundation and stability', 'Platforms and access', 'Guardrails and toe boards', 'Inspection/tagging systems', 'Safe ladder selection and positioning'],
      ['Collapse', 'Falls from platform', 'Unsafe access', 'Falling materials', 'Overloading'],
      ['Use competent erection/inspection arrangements', 'Maintain stable foundations', 'Provide guardrails and toe boards', 'Keep platforms clear', 'Prevent unauthorized modification'],
      ['Is the scaffold stable and adequately protected?', 'Is access safe?', 'Are platforms overloaded or obstructed?'],
      'Dubai Municipality inspection material specifically identifies scaffolding, ladders and platforms, firmness/durability and protective barriers as safety inspection items.',
      'https://www.dm.gov.ae/wp-content/uploads/2020/11/06_qua-localorder139.1.0.pdf',
    ),
    _DubaiTopic(
      '07', 'Excavation, Shoring & Dewatering', Icons.landscape_rounded,
      'Control ground-collapse, buried-service, water-ingress and access hazards around excavations.',
      ['Excavation permit/planning', 'Underground service verification', 'Shoring or battering', 'Safe access/egress', 'Dewatering and inspection'],
      ['Collapse', 'Service strike', 'Water ingress', 'Plant falling into excavation', 'Worker falls'],
      ['Verify drawings and services', 'Use engineered shoring where required', 'Provide safe access', 'Keep spoil/plant clear of edges', 'Inspect after rain, vibration or changed conditions'],
      ['Has the excavation support method been verified?', 'Are services identified?', 'Is access/egress available?', 'Is water controlled?'],
      'Dubai Municipality construction inspection material identifies digging, shoring and dewatering as a dedicated inspection category.',
      'https://www.dm.gov.ae/wp-content/uploads/2020/11/06_qua-localorder139.1.0.pdf',
    ),
    _DubaiTopic(
      '08', 'Electrical Safety', Icons.electrical_services_rounded,
      'Prevent shock, arc, fire and equipment damage through controlled electrical installations and tools.',
      ['Temporary distribution', 'Isolation and lockout', 'Cable routing and protection', 'Distribution-board safety', 'Inspection of tools and connections'],
      ['Electric shock', 'Arc flash', 'Fire', 'Damaged insulation', 'Water/electricity interaction'],
      ['Use competent electrical persons', 'Protect cables from damage', 'Keep boards secure and suitable', 'Inspect tools and connections', 'Isolate before work where required'],
      ['Are boards protected and accessible only to authorized persons?', 'Are cables and plugs undamaged?', 'Are wet-area risks controlled?'],
      'Dubai Municipality construction inspection material includes insulation of conductors, distribution boards and installation safety, and safe functioning of equipment.',
      'https://www.dm.gov.ae/wp-content/uploads/2020/11/06_qua-localorder139.1.0.pdf',
    ),
    _DubaiTopic(
      '09', 'Fire Prevention & Emergency Preparedness', Icons.local_fire_department_rounded,
      'Prevent ignition and ensure workers can respond rapidly to fire and other emergencies.',
      ['Hot-work control', 'Extinguisher selection and access', 'Emergency routes', 'Alarm/communication', 'Evacuation drills and assembly'],
      ['Uncontrolled ignition', 'Flammable storage', 'Blocked escape routes', 'Delayed response', 'Poor accountability'],
      ['Control ignition sources', 'Store combustibles safely', 'Keep escape routes clear', 'Provide suitable firefighting equipment', 'Conduct realistic drills and review lessons learned'],
      ['Can workers identify the assembly point?', 'Are extinguishers accessible and suitable?', 'Are emergency routes clear?'],
      'Dubai Municipality construction inspection material identifies prevention and firefighting equipment as a specific safety category. Its construction safety campaign also highlighted simulated evacuation exercises.',
      'https://www.dm.gov.ae/dubai-municipality-launches-comprehensive-safety-campaign-for-construction-sites-across-emirate/',
    ),
    _DubaiTopic(
      '10', 'Demolition Safety', Icons.domain_disabled_rounded,
      'Plan demolition around structural stability, sequencing, exclusion zones and public protection.',
      ['Demolition survey', 'Sequence and method', 'Temporary support', 'Exclusion zones', 'Dust/noise and debris control'],
      ['Unexpected collapse', 'Falling debris', 'Utility strike', 'Public exposure', 'Plant interaction'],
      ['Confirm demolition method', 'Isolate services', 'Establish exclusion zones', 'Control access and debris', 'Monitor structural changes continuously'],
      ['Is the demolition sequence understood?', 'Are services isolated?', 'Is the exclusion zone effective?', 'Is temporary support adequate?'],
      'Dubai Municipality inspection material identifies safe execution for demolition works as a specific inspection item; Circular 12-11-1 also applies security requirements to demolition sites.',
      'https://www.dm.gov.ae/wp-content/uploads/2024/12/12-11-1.pdf',
    ),
    _DubaiTopic(
      '11', 'Housekeeping & Material Storage', Icons.inventory_2_rounded,
      'Keep work areas organized so access, emergency response and safe movement are not compromised.',
      ['Material segregation', 'Stable stacking', 'Waste removal', 'Access and egress', 'Storage-area control'],
      ['Trips', 'Falling/rolling materials', 'Blocked exits', 'Fire load', 'Vehicle obstruction'],
      ['Define storage zones', 'Stack within safe limits', 'Remove waste routinely', 'Keep routes clear', 'Separate incompatible materials'],
      ['Are materials stable?', 'Are access and emergency routes clear?', 'Is waste removed at planned intervals?'],
      'Dubai Municipality Circular 12-11-1 requires safe and suitable storage of construction materials, equipment and devices. Building/planning circulars also include organizing, cleaning and protecting construction sites and waste sorting.',
      'https://www.dm.gov.ae/building-planning-circulars-2/',
    ),
    _DubaiTopic(
      '12', 'Construction Traffic & Mobile Equipment', Icons.local_shipping_rounded,
      'Separate pedestrians from moving plant and control vehicle movements inside and around the site.',
      ['Traffic management plan', 'Pedestrian segregation', 'Banksman/signaler', 'Reversing controls', 'Speed and parking controls'],
      ['Struck-by incidents', 'Reversing collisions', 'Blind spots', 'Poor lighting', 'Uncontrolled deliveries'],
      ['Define routes and crossing points', 'Use trained banksmen where needed', 'Control reversing', 'Provide visibility/lighting', 'Maintain equipment'],
      ['Are pedestrian and vehicle routes separated?', 'Are reversing movements controlled?', 'Are delivery times and staging areas defined?'],
      'Use the approved site traffic plan and Dubai Municipality construction-site access and movement requirements applicable to the project.',
      'https://www.dm.gov.ae/building-planning-circulars-2/',
    ),
    _DubaiTopic(
      '13', 'Temporary Works & Structural Stability', Icons.account_tree_rounded,
      'Manage temporary structures and construction-stage stability with engineering control and inspection.',
      ['Design responsibility', 'Load paths', 'Sequence control', 'Temporary support', 'Inspection after changes'],
      ['Progressive collapse', 'Overloading', 'Unapproved modification', 'Instability from weather/vibration'],
      ['Use approved temporary-works design', 'Control loads and sequence', 'Prevent unauthorized changes', 'Inspect critical stages', 'Stop work when stability is uncertain'],
      ['Is the temporary works design approved?', 'Are actual loads within assumptions?', 'Have changes been reviewed?'],
      'Dubai Municipality building-control procedures include technical inspections and construction-stage controls; temporary works should be managed through the project engineering and safety system.',
      'https://www.dm.gov.ae/municipality-business/building-permit-steps/',
    ),
    _DubaiTopic(
      '14', 'Concrete & Formwork', Icons.view_in_ar_rounded,
      'Control formwork, reinforcement, pouring and stripping activities to prevent collapse, falls and struck-by injuries.',
      ['Formwork stability', 'Access and edge protection', 'Pour sequence', 'Pump/hose control', 'Stripping and curing'],
      ['Formwork collapse', 'Falls', 'Concrete hose movement', 'Rebar impalement', 'Premature stripping'],
      ['Verify design and support', 'Control pour rate', 'Protect edges and protruding steel', 'Inspect before loading', 'Strip only when authorized'],
      ['Has formwork been inspected before pour?', 'Is the pour sequence controlled?', 'Are exposed rebars protected?'],
      'Use approved structural/temporary-works design and Dubai Municipality building-control inspection procedures for construction-stage work.',
      'https://www.dm.gov.ae/building-planning-circulars-2/',
    ),
    _DubaiTopic(
      '15', 'Hot Work', Icons.local_fire_department_outlined,
      'Prevent fire and explosion from welding, cutting, grinding and other ignition-producing work.',
      ['Hot-work permit', 'Gas-cylinder control', 'Fire watch', 'Combustible removal', 'Post-work monitoring'],
      ['Ignition of combustibles', 'Gas leak', 'Sparks travelling to adjacent areas', 'Burns and eye injury'],
      ['Issue permit where required', 'Clear/protect combustibles', 'Inspect hoses and regulators', 'Provide suitable extinguishers', 'Maintain fire watch and post-work check'],
      ['Has the work area been inspected before ignition?', 'Are cylinders secured?', 'Is fire watch assigned?'],
      'Integrate hot-work controls into the site permit-to-work and fire-prevention system and applicable Dubai Municipality construction safety requirements.',
      'https://www.dm.gov.ae/municipality-business/',
    ),
    _DubaiTopic(
      '16', 'Confined Spaces', Icons.meeting_room_rounded,
      'Control entry into spaces where atmosphere, access, engulfment or rescue conditions can become life-threatening.',
      ['Entry assessment', 'Atmospheric testing', 'Isolation', 'Permit and attendant', 'Rescue plan'],
      ['Oxygen deficiency', 'Toxic/flammable atmosphere', 'Engulfment', 'Heat stress', 'Difficult rescue'],
      ['Identify confined spaces', 'Isolate energy/material flow', 'Test atmosphere', 'Provide communication and rescue capability', 'Stop entry when conditions change'],
      ['Is the space correctly classified?', 'Are test results acceptable and recorded?', 'Is rescue capability actually available?'],
      'Use the project confined-space procedure and applicable Dubai Municipality health and safety technical guidance. Do not rely on a generic checklist where the site risk assessment requires additional controls.',
      'https://www.dm.gov.ae/municipality-business/technical-guidelines-list/',
    ),
    _DubaiTopic(
      '17', 'Tools, Plant & Equipment', Icons.build_rounded,
      'Keep tools and equipment safe, suitable, maintained and operated only by competent users.',
      ['Pre-use inspection', 'Guards and interlocks', 'Maintenance', 'Operator competency', 'Defect isolation'],
      ['Cuts/crushing', 'Unexpected start', 'Electrical hazards', 'Equipment failure', 'Improper use'],
      ['Inspect before use', 'Keep guards fitted', 'Remove defective equipment from service', 'Maintain according to manufacturer requirements', 'Restrict operation to competent persons'],
      ['Is there a pre-use inspection?', 'Are guards intact?', 'Are defects tagged and isolated?'],
      'Dubai Municipality construction inspection material includes safe functioning of equipment and safety of tools, equipment and electrical works.',
      'https://www.dm.gov.ae/wp-content/uploads/2020/11/06_qua-localorder139.1.0.pdf',
    ),
    _DubaiTopic(
      '18', 'Heat Stress & Worker Welfare', Icons.wb_sunny_rounded,
      'Plan work so heat exposure, hydration, rest and worker welfare are actively managed in UAE conditions.',
      ['Heat-risk assessment', 'Hydration', 'Rest and recovery', 'Acclimatization', 'Heat-illness response'],
      ['Heat exhaustion', 'Heat stroke', 'Dehydration', 'Reduced alertness', 'Unsafe fatigue-related decisions'],
      ['Schedule heavy work appropriately', 'Provide drinking water and shaded/rest arrangements', 'Train workers to recognize symptoms', 'Use buddy monitoring', 'Activate emergency response for suspected heat illness'],
      ['Are workers hydrated and able to rest?', 'Do supervisors know heat-illness symptoms?', 'Are work controls adjusted to conditions?'],
      'Dubai Municipality maintains health and safety technical guidance relevant to construction-site worker requirements and labor-accommodation/transportation controls. Project-specific UAE heat-stress requirements must also be applied.',
      'https://www.dm.gov.ae/municipality-business/technical-guidelines-list/',
    ),
    _DubaiTopic(
      '19', 'Environmental & Public Protection', Icons.public_rounded,
      'Protect neighbors, road users, visitors and the surrounding environment from construction activities.',
      ['Dust/noise control', 'Site boundary protection', 'Waste segregation', 'Public interface', 'Drainage and spill control'],
      ['Public injury', 'Dust exposure', 'Noise nuisance', 'Pollution', 'Waste mismanagement'],
      ['Maintain secure boundaries', 'Control dust and noise', 'Manage waste correctly', 'Protect adjacent public areas', 'Control spills and contaminated water'],
      ['Could a member of the public enter the hazard area?', 'Are dust/noise controls effective?', 'Is waste segregated and removed?'],
      'Dubai Municipality building/planning circulars cover noise prevention, site organization/protection, waste sorting and compliance within plot boundaries.',
      'https://www.dm.gov.ae/building-planning-circulars-2/',
    ),
    _DubaiTopic(
      '20', 'Site Inspection, Audit & Corrective Action', Icons.fact_check_rounded,
      'Turn inspections into measurable risk reduction through evidence, ownership, deadlines and verified close-out.',
      ['Inspection planning', 'Evidence and photos', 'Risk-based findings', 'Action ownership', 'Verification and trend analysis'],
      ['Repeat violations', 'Paper compliance only', 'Overdue actions', 'Poor escalation', 'Loss of learning'],
      ['Inspect high-risk activities first', 'Record objective evidence', 'Assign accountable owners', 'Set realistic due dates', 'Verify controls physically before closure', 'Trend recurring findings'],
      ['Does each finding have evidence?', 'Is a responsible owner assigned?', 'Was effectiveness verified before closure?', 'Are repeat findings escalated?'],
      'Dubai Municipality lists periodic inspections and audits on construction sites as a building-control procedure and conducts specialized occupational-safety inspection and investigation activities.',
      'https://www.dm.gov.ae/building-planning-circulars-2/',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: navy,
        title: const Text('Dubai Construction Safety'),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
        children: [
          _buildIntro(),
          const SizedBox(height: 16),
          ...topics.map((topic) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _TopicCard(topic: topic),
              )),
        ],
      ),
    );
  }

  Widget _buildIntro() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF075B45), Color(0xFF159447)],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ADVANCED LEARNING', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.1)),
          SizedBox(height: 5),
          Text('Dubai Construction Safety Framework', style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w900)),
          SizedBox(height: 8),
          Text('Tap any topic to study the advanced controls, field inspection points, checklist and official Dubai Municipality reference.', style: TextStyle(color: Colors.white, height: 1.35)),
        ],
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.topic});
  final _DubaiTopic topic;
  static const Color green = Color(0xFF159447);
  static const Color navy = Color(0xFF082653);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => _TopicDetailPage(topic: topic))),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(color: const Color(0xFFE6F5ED), borderRadius: BorderRadius.circular(14)),
                child: Icon(topic.icon, color: green),
              ),
              const SizedBox(width: 13),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Topic ${topic.number}', style: const TextStyle(color: green, fontSize: 10, fontWeight: FontWeight.w800)),
                const SizedBox(height: 2),
                Text(topic.title, style: const TextStyle(color: navy, fontSize: 15, fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(topic.overview, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.black54, fontSize: 11.5, height: 1.3)),
              ])),
              const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.black38),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopicDetailPage extends StatelessWidget {
  const _TopicDetailPage({required this.topic});
  final _DubaiTopic topic;
  static const Color green = Color(0xFF159447);
  static const Color navy = Color(0xFF082653);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FB),
      appBar: AppBar(title: Text(topic.title), backgroundColor: Colors.white, foregroundColor: navy),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 30),
        children: [
          _hero(),
          const SizedBox(height: 14),
          _section('Advanced Learning', Icons.school_rounded, topic.learning),
          _section('Major Hazards', Icons.warning_amber_rounded, topic.hazards),
          _section('Risk Controls', Icons.shield_rounded, topic.controls),
          _section('HSE Officer Field Checklist', Icons.fact_check_rounded, topic.checklist),
          _reference(),
        ],
      ),
    );
  }

  Widget _hero() => Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(children: [
          Container(width: 56, height: 56, decoration: BoxDecoration(color: const Color(0xFFE6F5ED), borderRadius: BorderRadius.circular(16)), child: Icon(topic.icon, color: green, size: 29)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Topic ${topic.number}', style: const TextStyle(color: green, fontSize: 11, fontWeight: FontWeight.w800)), const SizedBox(height: 3), Text(topic.title, style: const TextStyle(color: navy, fontSize: 20, fontWeight: FontWeight.w900)), const SizedBox(height: 5), Text(topic.overview, style: const TextStyle(height: 1.35))])),
        ]),
      );

  Widget _section(String title, IconData icon, List<String> items) => Card(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [Icon(icon, color: green, size: 20), const SizedBox(width: 8), Text(title, style: const TextStyle(color: navy, fontSize: 16, fontWeight: FontWeight.w900))]),
            const SizedBox(height: 10),
            ...items.map((e) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('•  ', style: TextStyle(color: green, fontWeight: FontWeight.w900)), Expanded(child: Text(e, style: const TextStyle(height: 1.35)))]))),
          ]),
        ),
      );

  Widget _reference() => Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Row(children: [Icon(Icons.menu_book_rounded, color: green), SizedBox(width: 8), Text('Official Reference', style: TextStyle(color: navy, fontSize: 16, fontWeight: FontWeight.w900))]),
            const SizedBox(height: 10),
            Text(topic.reference, style: const TextStyle(height: 1.4)),
            const SizedBox(height: 10),
            SelectableText(topic.url, style: const TextStyle(color: green, fontSize: 11, height: 1.35)),
            const SizedBox(height: 8),
            const Text('Reference links are provided for source navigation. Always verify the current official document before treating a requirement as legally applicable to a project.', style: TextStyle(color: Colors.black54, fontSize: 10.5, height: 1.35)),
          ]),
        ),
      );
}

class _DubaiTopic {
  const _DubaiTopic(this.number, this.title, this.icon, this.overview, this.learning, this.hazards, this.controls, this.checklist, this.reference, this.url);
  final String number;
  final String title;
  final IconData icon;
  final String overview;
  final List<String> learning;
  final List<String> hazards;
  final List<String> controls;
  final List<String> checklist;
  final String reference;
  final String url;
}
