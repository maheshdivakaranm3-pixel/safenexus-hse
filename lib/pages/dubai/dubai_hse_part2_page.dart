import 'package:flutter/material.dart';

import 'dubai_hse_part2_advanced_learning_page.dart';

class DubaiPart2Item {
  final String title;
  final String detail;
  const DubaiPart2Item({required this.title, required this.detail});
}

class DubaiPart2Section {
  final String title;
  final String content;
  final List<DubaiPart2Item> items;
  final bool initiallyExpanded;
  const DubaiPart2Section({
    required this.title,
    required this.content,
    this.items = const [],
    this.initiallyExpanded = false,
  });
}

class DubaiHsePart2TopicPage extends StatelessWidget {
  final String topicId;
  const DubaiHsePart2TopicPage({super.key, required this.topicId});

  static const _topics = <String, _Part2Topic>{
    'dubai_hot_work': _Part2Topic(
      title: 'Hot Work Safety',
      subtitle: 'PLAN • PERMIT • ISOLATE • PROTECT • MONITOR',
      description: 'Control welding, cutting, grinding and other spark, flame or heat-producing work through planning, area preparation, fire prevention and competent supervision.',
      icon: Icons.local_fire_department_rounded,
    ),
    'dubai_traffic': _Part2Topic(
      title: 'Construction Traffic Management',
      subtitle: 'SEPARATE • CONTROL • COMMUNICATE • VERIFY',
      description: 'Manage interaction between vehicles, mobile plant, workers, deliveries and the public through planned routes, segregation, visibility and supervision.',
      icon: Icons.traffic_rounded,
    ),
    'dubai_demolition': _Part2Topic(
      title: 'Demolition Safety',
      subtitle: 'SURVEY • PLAN • ISOLATE • CONTROL • PROGRESS',
      description: 'A structured approach to demolition planning, structural stability, services isolation, exclusion zones, plant interaction, dust and emergency control.',
      icon: Icons.domain_disabled_rounded,
    ),
    'dubai_temporary_works': _Part2Topic(
      title: 'Temporary Works Safety',
      subtitle: 'DESIGN • CHECK • INSTALL • MONITOR • RELEASE',
      description: 'Control temporary structures and supports through design responsibility, checking, installation, inspection, loading control and change management.',
      icon: Icons.construction_rounded,
    ),
    'dubai_heat_stress': _Part2Topic(
      title: 'Heat Stress Management',
      subtitle: 'ASSESS • HYDRATE • REST • SHADE • RESPOND',
      description: 'Prevent heat-related illness through heat-risk assessment, hydration, work-rest planning, environmental controls, acclimatisation and early response.',
      icon: Icons.wb_sunny_rounded,
    ),
    'dubai_occupational_health': _Part2Topic(
      title: 'Occupational Health',
      subtitle: 'IDENTIFY • PREVENT • MONITOR • SUPPORT',
      description: 'Manage work-related health risks including exposure, ergonomics, noise, respiratory hazards, occupational illness and health surveillance where required.',
      icon: Icons.health_and_safety_rounded,
    ),
    'dubai_ppe': _Part2Topic(
      title: 'Personal Protective Equipment',
      subtitle: 'SELECT • FIT • INSPECT • USE • MAINTAIN',
      description: 'Use PPE as part of a wider risk-control strategy, with correct selection, compatibility, fit, inspection, maintenance and user training.',
      icon: Icons.security_rounded,
    ),
    'dubai_emergency': _Part2Topic(
      title: 'Emergency Preparedness & Response',
      subtitle: 'PREPARE • ALARM • CONTROL • RESCUE • RECOVER',
      description: 'Build practical emergency readiness around credible scenarios, alarms, communication, access, rescue, medical response and recovery.',
      icon: Icons.emergency_rounded,
    ),
    'dubai_incident': _Part2Topic(
      title: 'Incident Reporting & Investigation',
      subtitle: 'REPORT • PRESERVE • ANALYSE • CORRECT • LEARN',
      description: 'Turn incidents and near misses into controlled learning through timely reporting, evidence preservation, causal analysis and verified corrective action.',
      icon: Icons.report_problem_rounded,
    ),
    'dubai_contractor': _Part2Topic(
      title: 'Contractor & Subcontractor HSE Management',
      subtitle: 'PREQUALIFY • INTEGRATE • CONTROL • ASSURE',
      description: 'Manage contractor HSE performance from selection and mobilisation through induction, supervision, monitoring, corrective action and closeout.',
      icon: Icons.groups_rounded,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final topic = _topics[topicId];
    if (topic == null) return const Scaffold(body: Center(child: Text('Topic not found')));
    final sections = _sectionsFor(topicId);
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: Text(topic.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        centerTitle: true,
        backgroundColor: const Color(0xFF159447),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        children: [
          _hero(topic),
          const SizedBox(height: 12),
          ...sections.map((section) => _section(context, topic.title, section)),
          const SizedBox(height: 8),
          _endCard(topic.title),
        ],
      ),
    );
  }

  Widget _hero(_Part2Topic topic) => Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: const Color(0xFF159447).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(topic.icon, color: const Color(0xFF159447), size: 29),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(topic.title, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w800, color: Color(0xFF0B5D4B))),
                  const SizedBox(height: 5),
                  Text(topic.subtitle, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: Color(0xFF237A5C))),
                  const SizedBox(height: 10),
                  Text(topic.description, style: const TextStyle(fontSize: 15, height: 1.48)),
                ]),
              ),
            ],
          ),
        ),
      );

  Widget _section(BuildContext context, String topicTitle, DubaiPart2Section section) => Card(
        margin: const EdgeInsets.only(bottom: 10),
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: ExpansionTile(
          initiallyExpanded: section.initiallyExpanded,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 15),
          iconColor: const Color(0xFF237A5C),
          collapsedIconColor: const Color(0xFF237A5C),
          title: Text(section.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          children: [
            Text(section.content, style: const TextStyle(fontSize: 15.2, height: 1.5)),
            if (section.items.isNotEmpty) const SizedBox(height: 10),
            ...section.items.map((item) => _itemTile(context, topicTitle, section.title, item)),
          ],
        ),
      );

  Widget _itemTile(BuildContext context, String topicTitle, String sectionTitle, DubaiPart2Item item) => Card(
        margin: const EdgeInsets.only(bottom: 8),
        elevation: 0,
        color: const Color(0xFFF8FBF9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: InkWell(
          borderRadius: BorderRadius.circular(13),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DubaiHsePart2AdvancedLearningPage(topicTitle: topicTitle, sectionTitle: sectionTitle, title: item.title, summary: item.detail))),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(13, 12, 10, 12),
            child: Row(
              children: [
                Expanded(child: Text(item.title, style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700))),
                const Icon(Icons.chevron_right_rounded, size: 24, color: Color(0xFF237A5C)),
              ],
            ),
          ),
        ),
      );

  Widget _endCard(String title) => Card(
        elevation: 0,
        color: const Color(0xFFEFF7F2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Professional field rule: understand the hazard, verify the critical control, stop when the control fails, and document what was verified. $title must be managed through the project risk assessment, approved method, applicable requirements and competent supervision.', style: const TextStyle(fontSize: 14.5, height: 1.5)),
        ),
      );

  static List<DubaiPart2Section> _sectionsFor(String id) {
    switch (id) {
      case 'dubai_hot_work': return _hotWork();
      case 'dubai_traffic': return _traffic();
      case 'dubai_demolition': return _demolition();
      case 'dubai_temporary_works': return _temporaryWorks();
      case 'dubai_heat_stress': return _heatStress();
      case 'dubai_occupational_health': return _occupationalHealth();
      case 'dubai_ppe': return _ppe();
      case 'dubai_emergency': return _emergency();
      case 'dubai_incident': return _incident();
      case 'dubai_contractor': return _contractor();
      default: return const [];
    }
  }

  static List<DubaiPart2Section> _hotWork() => const [
    DubaiPart2Section(title: '1. Introduction — What is Hot Work?', initiallyExpanded: true, content: 'Hot work is work that can create flame, heat, sparks or hot particles capable of igniting combustible materials. Typical activities include welding, cutting, brazing, soldering and grinding.', items: [
      DubaiPart2Item(title: 'Hot Work Identification', detail: 'Confirm whether the activity can generate an ignition source and identify nearby combustible materials, gases, dusts and concealed spaces.'),
      DubaiPart2Item(title: 'Work Scope', detail: 'Define the exact task, location, equipment, duration, nearby operations and required controls before starting.'),
    ]),
    DubaiPart2Section(title: '2. Types of Hot Work', content: 'Different hot-work activities create different ignition, heat, fume and fire-spread hazards.', items: [
      DubaiPart2Item(title: 'Welding', detail: 'Arc or gas welding can generate intense heat, sparks, UV radiation, fumes and hot metal.'),
      DubaiPart2Item(title: 'Gas Cutting', detail: 'Controls include cylinders, hoses, flashback protection, ignition sources and fire exposure.'),
      DubaiPart2Item(title: 'Grinding', detail: 'Grinding can create high-energy sparks and hot particles that travel beyond the immediate work position.'),
      DubaiPart2Item(title: 'Brazing / Soldering', detail: 'Consider flame/heat source, combustible surroundings and ventilation.'),
    ]),
    DubaiPart2Section(title: '3. Equipment & Protection', content: 'Use suitable, inspected equipment and protect people and surrounding assets from heat, sparks, fumes and radiation.', items: [
      DubaiPart2Item(title: 'Welding Set & Leads', detail: 'Check condition, connections, insulation, earthing/return arrangement and routing.'),
      DubaiPart2Item(title: 'Gas Cylinders & Hoses', detail: 'Secure cylinders, protect valves, inspect hoses and use suitable flashback/backflow protection where required.'),
      DubaiPart2Item(title: 'Fire Extinguishing Equipment', detail: 'Provide suitable, accessible equipment based on the credible fire risk and site emergency arrangement.'),
      DubaiPart2Item(title: 'Fire Blankets / Screens', detail: 'Contain sparks, hot particles and radiation and protect adjacent workers and materials.'),
    ]),
    DubaiPart2Section(title: '4. Hot Work Permit & Planning', content: 'Where the project permit system requires a hot-work permit, the permit must be issued only after the work area and controls are verified. The permit does not replace the risk assessment or safe method.', items: [
      DubaiPart2Item(title: 'Permit Verification', detail: 'Confirm scope, location, validity, precautions, responsible persons and required fire watch.'),
      DubaiPart2Item(title: 'Area Preparation', detail: 'Remove or protect combustibles, check adjacent areas and consider hidden spaces where sparks may travel.'),
      DubaiPart2Item(title: 'Isolation', detail: 'Control process lines, electrical sources, flammable materials and other energy sources as required by the task.'),
    ]),
    DubaiPart2Section(title: '5. Main Hazards', content: 'Fire, explosion, burns, fumes, eye injury, electric shock, gas-cylinder incidents, dropped/hot materials and ignition of concealed combustibles are key hazards.', items: [
      DubaiPart2Item(title: 'Fire / Explosion', detail: 'Control ignition sources and combustible atmospheres before and during work.'),
      DubaiPart2Item(title: 'Fumes & Gases', detail: 'Provide suitable ventilation and exposure controls based on the material and process.'),
      DubaiPart2Item(title: 'Radiation & Burns', detail: 'Use suitable PPE and screens and control access to the hot-work zone.'),
    ]),
    DubaiPart2Section(title: '6. Fire Watch & Monitoring', content: 'Fire-watch arrangements must be competent, continuous where required and focused on the actual fire-spread pathways. Continue post-work checks for concealed or delayed ignition as required by the risk assessment/site procedure.', items: [
      DubaiPart2Item(title: 'Fire Watch', detail: 'Maintain active observation of the work and adjacent areas and know how to raise the alarm and use emergency equipment within competence.'),
      DubaiPart2Item(title: 'Post-Work Check', detail: 'Inspect nearby spaces, lower levels and concealed areas where hot particles could cause delayed ignition.'),
    ]),
    DubaiPart2Section(title: '7. Inspection & Verification', content: 'Verify equipment condition, work area preparation, fire protection, PPE, permit status and housekeeping before release.', items: [
      DubaiPart2Item(title: 'Pre-Start Check', detail: 'Do not start until required controls are physically verified.'),
      DubaiPart2Item(title: 'During Work', detail: 'Reassess if the work position, materials, ventilation or surrounding activities change.'),
    ]),
    DubaiPart2Section(title: '8. Stop-Work Conditions', content: 'Stop for uncontrolled combustible materials, flammable atmosphere, failed fire protection, defective equipment, missing permit controls, unsafe ventilation or changing conditions that invalidate the approved method.', items: [
      DubaiPart2Item(title: 'Critical Control Failure', detail: 'Stop, make the area safe and correct the failed control before restarting.'),
    ]),
    DubaiPart2Section(title: '9. Emergency Response', content: 'Raise the alarm, stop the hot work, isolate energy where safe, use first-response firefighting only within competence, evacuate or rescue according to the site emergency plan, and prevent re-entry until authorised.', items: [
      DubaiPart2Item(title: 'Fire / Smoke', detail: 'Alarm → stop work → isolate if safe → evacuate/control area → emergency response.'),
      DubaiPart2Item(title: 'Burn / Exposure', detail: 'Remove from source, provide first aid within competence and obtain medical support according to the site plan.'),
    ]),
    DubaiPart2Section(title: '10. Practical Site Example', content: 'A welding task is planned beside temporary combustible materials. Before work, the team removes or protects combustibles, establishes a controlled area, verifies the permit, provides fire protection and assigns competent fire-watch coverage.', items: [
      DubaiPart2Item(title: 'HSE Verification', detail: 'Verify the actual work area rather than accepting the permit as proof that every control is present.'),
    ]),
    DubaiPart2Section(title: '11. Quick Learning Formula', content: 'PERMIT → ISOLATE → CLEAR → SCREEN → EXTINGUISH → WATCH → CHECK → CLOSE', items: [
      DubaiPart2Item(title: 'PERMIT', detail: 'Confirm formal authorisation where required.'),
      DubaiPart2Item(title: 'WATCH', detail: 'Control fire risk during and after the work as required.'),
    ]),
    DubaiPart2Section(title: '12. HSE Roles — Topic-wise Responsibilities', content: 'HSE Officer: field verification and intervention. HSE Supervisor: coordination and daily control. Senior HSE: high-risk assurance. HSE Coordinator: permit/action coordination. HSE Engineer: technical interface review. HSE Manager: governance and escalation.'),
  ];

  static List<DubaiPart2Section> _traffic() => _genericTopic('Construction Traffic Management', 'PLAN → SEPARATE → CONTROL → COMMUNICATE → MONITOR', [
    ['1. Introduction — What is Construction Traffic Management?', 'A planned system for controlling interaction between pedestrians, vehicles, mobile plant, deliveries and the public.', ['Traffic Management Plan', 'Pedestrian–Vehicle Segregation', 'Delivery & Reversing Control']],
    ['2. Traffic Systems & Routes', 'Define site entrances, exits, one-way systems, pedestrian routes, plant routes, delivery areas and emergency access.', ['Vehicle Routes', 'Pedestrian Routes', 'Delivery Routes', 'Emergency Access']],
    ['3. Traffic Components & Controls', 'Use barriers, gates, signs, lighting, mirrors, speed controls, banksmen and designated crossing points.', ['Barriers & Gates', 'Signs & Markings', 'Banksman / Signaller', 'Lighting & Visibility']],
    ['4. Planning & Technical Requirements', 'Review vehicle dimensions, turning paths, gradients, ground condition, visibility, interfaces and temporary changes.', ['Route Survey', 'Turning Area', 'Ground Condition', 'Temporary Change Control']],
    ['5. Main Hazards', 'Vehicle strike, reversing incidents, blind spots, pedestrian intrusion, unstable loads and public interface.', ['Reversing', 'Blind Spots', 'Pedestrian Interface', 'Public Protection']],
    ['6. Vehicle & Plant Controls', 'Verify competent operators, suitable plant condition, alarms, cameras/mirrors where provided and safe loading.', ['Pre-Use Check', 'Operator Competence', 'Load Security']],
    ['7. Inspection & Monitoring', 'Inspect routes, barriers, signs, lighting, crossings, housekeeping and changing work fronts.', ['Daily Route Check', 'Barrier Check', 'Change Review']],
    ['8. Stop-Work Conditions', 'Stop movement when the route is blocked, visibility is inadequate, segregation fails or people enter the exclusion area.', ['Unsafe Reversing', 'Failed Segregation']],
    ['9. Emergency Response', 'Secure the area, stop traffic, raise alarm, provide first response within competence and maintain emergency access.', ['Vehicle Incident', 'Emergency Access']],
    ['10. Practical Site Example', 'A concrete delivery vehicle approaches a congested work front. The route is cleared, pedestrians are segregated and the banksman confirms the movement before entry.', ['HSE Verification']],
    ['11. Quick Learning Formula', 'SEPARATE → SEE → SIGNAL → CONTROL → VERIFY', ['SEPARATE', 'VERIFY']],
    ['12. HSE Roles — Topic-wise Responsibilities', 'HSE Officer: field checks. HSE Supervisor: daily traffic coordination. Senior HSE: major interface assurance. HSE Coordinator: communication. HSE Engineer: route/interface review. HSE Manager: governance and escalation.', []],
  ]);

  static List<DubaiPart2Section> _demolition() => _genericTopic('Demolition Safety', 'SURVEY → ISOLATE → PLAN → EXCLUDE → DEMOLISH PROGRESSIVELY', [
    ['1. Introduction — What is Demolition?', 'The controlled dismantling or removal of a structure or part of a structure using planned methods and competent supervision.', ['Pre-Demolition Survey', 'Demolition Method', 'Structural Stability']],
    ['2. Demolition Methods', 'Method selection depends on structure, location, surrounding assets and engineered assessment.', ['Manual / Hand Demolition', 'Mechanical Demolition', 'Partial / Selective Demolition', 'Specialist Demolition']],
    ['3. Components & Control Zones', 'Establish exclusion zones, temporary supports, access, plant routes, service isolation and debris-control arrangements.', ['Exclusion Zone', 'Temporary Support', 'Plant Working Zone', 'Debris Control']],
    ['4. Planning & Technical Requirements', 'Review structural sequence, temporary stability, services, adjacent structures, public interface, dust and emergency arrangements.', ['Structural Sequence', 'Service Isolation', 'Temporary Works', 'Monitoring']],
    ['5. Main Hazards', 'Unexpected collapse, falling materials, plant strike, dust, asbestos or other hazardous materials, electrical energy and public exposure.', ['Collapse', 'Falling Debris', 'Hazardous Materials', 'Plant Interaction']],
    ['6. Progressive Demolition Controls', 'Maintain stability and remove materials in the approved sequence without undermining remaining structure.', ['Sequence Control', 'Stability Monitoring']],
    ['7. Inspection & Monitoring', 'Verify barriers, temporary supports, plant, services isolation, structural condition and work sequence.', ['Pre-Start Verification', 'Change Inspection']],
    ['8. Stop-Work Conditions', 'Stop for unexpected structural movement, unidentified services, uncontrolled dust, failed exclusion zones or change from approved sequence.', ['Structural Movement', 'Unplanned Change']],
    ['9. Emergency Response', 'Stop operations, isolate the area, raise alarm, prevent secondary collapse exposure and activate rescue arrangements.', ['Collapse Event', 'Utility Strike']],
    ['10. Practical Site Example', 'During selective demolition, unexpected movement is observed. Work stops, the area is cleared and the competent engineering team reassesses stability before any restart.', ['HSE Verification']],
    ['11. Quick Learning Formula', 'SURVEY → ISOLATE → SUPPORT → EXCLUDE → SEQUENCE → MONITOR', ['SURVEY', 'MONITOR']],
    ['12. HSE Roles — Topic-wise Responsibilities', 'HSE Officer: field controls. HSE Supervisor: work-front supervision. Senior HSE: major-risk assurance. HSE Coordinator: interface control. HSE Engineer: technical review. HSE Manager: governance and escalation.', []],
  ]);

  static List<DubaiPart2Section> _temporaryWorks() => _genericTopic('Temporary Works Safety', 'DESIGN → CHECK → INSTALL → INSPECT → CONTROL CHANGE', [
    ['1. Introduction — What are Temporary Works?', 'Temporary works are structures or systems required to support, protect, access or enable construction until they are removed or replaced by permanent works.', ['Temporary Support', 'Access Platform', 'Formwork / Falsework']],
    ['2. Types of Temporary Works', 'Examples include formwork, falsework, shoring, propping, temporary bridges, access platforms and temporary retaining arrangements.', ['Formwork', 'Falsework', 'Shoring & Propping', 'Temporary Access']],
    ['3. Components & Interfaces', 'Control design loads, foundations, connections, bracing, supports, access and interfaces with permanent structures.', ['Base / Foundation', 'Connections', 'Bracing', 'Load Path']],
    ['4. Design & Technical Requirements', 'Use competent design/checking arrangements, approved drawings, design loads and installation sequence.', ['Design Responsibility', 'Independent Check', 'Load Verification']],
    ['5. Main Hazards', 'Collapse, instability, overload, poor foundation, unauthorised modification and premature removal.', ['Collapse', 'Overload', 'Premature Removal']],
    ['6. Installation & Control', 'Install progressively, maintain stability, follow drawings and prevent unauthorised alteration.', ['Installation Sequence', 'Access Control']],
    ['7. Inspection & Monitoring', 'Inspect before loading/use and after changes, impact, unusual movement or other events that could affect integrity.', ['Pre-Use Inspection', 'Post-Change Inspection']],
    ['8. Stop-Work Conditions', 'Stop for unexpected movement, damaged components, missing supports, design uncertainty or unauthorised changes.', ['Instability', 'Design Uncertainty']],
    ['9. Emergency Response', 'Stop loading, exclude personnel and activate engineering/emergency arrangements without entering an unstable zone.', ['Collapse / Movement']],
    ['10. Practical Site Example', 'A temporary platform is found with an altered support arrangement. Use is stopped until the approved design and stability are verified.', ['HSE Verification']],
    ['11. Quick Learning Formula', 'DESIGN → CHECK → BUILD → INSPECT → LOAD → MONITOR → RELEASE', ['CHECK', 'MONITOR']],
    ['12. HSE Roles — Topic-wise Responsibilities', 'HSE Officer: field verification. HSE Supervisor: work control. Senior HSE: high-risk assurance. HSE Coordinator: document/interface tracking. HSE Engineer: technical review. HSE Manager: governance.', []],
  ]);

  static List<DubaiPart2Section> _heatStress() => _genericTopic('Heat Stress Management', 'ASSESS → ACCLIMATISE → HYDRATE → REST → SHADE → RESPOND', [
    ['1. Introduction — What is Heat Stress?', 'Heat stress occurs when the body cannot adequately regulate temperature under heat exposure. Risk depends on environmental conditions, workload, clothing, acclimatisation and individual factors.', ['Heat Exposure', 'Workload', 'Acclimatisation']],
    ['2. Heat Risk Factors', 'Assess air temperature, humidity, air movement, radiant heat, workload, PPE/clothing and duration of exposure.', ['Environmental Heat', 'Heavy Work', 'Protective Clothing']],
    ['3. Prevention Controls', 'Use shade, ventilation, hydration, suitable work-rest arrangements, scheduling and task rotation where appropriate.', ['Shade', 'Hydration', 'Work-Rest Planning', 'Ventilation']],
    ['4. Heat-Work Planning', 'Plan high-heat work with competent supervision and account for environmental conditions and workforce acclimatisation.', ['Daily Heat Review', 'Acclimatisation']],
    ['5. Main Heat-Related Hazards', 'Heat cramps, heat exhaustion, heat stroke, dehydration, fatigue and reduced alertness can increase incident risk.', ['Dehydration', 'Heat Exhaustion', 'Heat Stroke']],
    ['6. Hydration & Welfare', 'Provide accessible drinking water and suitable welfare arrangements; encourage early reporting of symptoms.', ['Drinking Water', 'Welfare Facilities']],
    ['7. Monitoring & Inspection', 'Monitor conditions and worker wellbeing and adjust controls when conditions or work intensity change.', ['Heat Monitoring', 'Worker Observation']],
    ['8. Stop-Work / Escalation', 'Stop or modify work when controls are inadequate, symptoms occur or environmental/work conditions exceed the project control criteria.', ['Symptoms', 'Control Failure']],
    ['9. Emergency Response', 'Move the affected person to a cooler safe area, activate medical/emergency support and follow the site response plan. Suspected heat stroke is a medical emergency.', ['Heat Illness Response']],
    ['10. Practical Site Example', 'A heavy outdoor task continues as heat exposure increases. The supervisor reviews conditions, adjusts work/rest arrangements, reinforces hydration and increases monitoring.', ['HSE Verification']],
    ['11. Quick Learning Formula', 'CHECK HEAT → PLAN WORK → DRINK → REST → SHADE → REPORT → RESPOND', ['CHECK HEAT', 'RESPOND']],
    ['12. HSE Roles — Topic-wise Responsibilities', 'HSE Officer: heat-control verification. HSE Supervisor: daily implementation. Senior HSE: seasonal assurance. HSE Coordinator: communication/tracking. HSE Engineer: task-control review. HSE Manager: programme governance.', []],
  ]);

  static List<DubaiPart2Section> _occupationalHealth() => _genericTopic('Occupational Health', 'IDENTIFY → ASSESS → CONTROL → MONITOR → IMPROVE', [
    ['1. Introduction — What is Occupational Health?', 'Occupational health protects workers from work-related illness and health effects by identifying exposures and controlling them at source.', ['Health Risk Profile', 'Exposure Identification']],
    ['2. Common Occupational Health Risks', 'Noise, dust, fumes, chemicals, vibration, manual handling, ergonomic stress, biological agents and heat can require control.', ['Noise', 'Respiratory Exposure', 'Ergonomics', 'Vibration']],
    ['3. Exposure Controls', 'Prioritise elimination/substitution and engineering controls, supported by administrative controls and PPE.', ['Engineering Control', 'Administrative Control', 'PPE']],
    ['4. Health Surveillance', 'Where required by risk, exposure and applicable arrangements, use appropriate health surveillance and follow-up.', ['Exposure Monitoring', 'Health Surveillance']],
    ['5. Main Health Hazards', 'Long-term exposure can cause hearing loss, respiratory illness, musculoskeletal disorders and other occupational health effects.', ['Hearing Risk', 'Respiratory Risk', 'Musculoskeletal Risk']],
    ['6. Welfare & Hygiene', 'Provide suitable welfare, sanitation, drinking water and hygiene arrangements to support worker health.', ['Welfare', 'Hygiene']],
    ['7. Inspection & Monitoring', 'Verify controls in the field and review exposure information, complaints, trends and occupational health findings.', ['Field Verification', 'Trend Review']],
    ['8. Stop-Work / Escalation', 'Escalate uncontrolled exposure, significant symptoms, failed engineering controls or conditions outside the approved risk assessment.', ['Uncontrolled Exposure']],
    ['9. Emergency Response', 'Provide first response within competence and activate medical support for acute exposure, injury or illness.', ['Acute Exposure']],
    ['10. Practical Site Example', 'A cutting operation produces visible dust despite existing controls. Work is paused, the control hierarchy is reviewed and additional engineering controls are implemented.', ['HSE Verification']],
    ['11. Quick Learning Formula', 'SOURCE → PATHWAY → EXPOSURE → CONTROL → VERIFY', ['SOURCE', 'VERIFY']],
    ['12. HSE Roles — Topic-wise Responsibilities', 'HSE Officer: exposure observations. HSE Supervisor: implementation. Senior HSE: programme assurance. HSE Coordinator: records. HSE Engineer: technical controls. HSE Manager: governance.', []],
  ]);

  static List<DubaiPart2Section> _ppe() => _genericTopic('Personal Protective Equipment', 'ASSESS → SELECT → FIT → INSPECT → USE → MAINTAIN', [
    ['1. Introduction — What is PPE?', 'PPE is equipment worn or used by a person to reduce exposure to a residual hazard after higher-level controls have been considered.', ['Residual Risk', 'PPE as Last Line']],
    ['2. PPE Types', 'Head, eye/face, hearing, respiratory, hand, foot, body and fall-protection equipment are selected according to the hazard.', ['Head Protection', 'Eye / Face Protection', 'Hand Protection', 'Foot Protection', 'Hearing Protection', 'Respiratory Protection', 'Body Protection', 'Fall Protection']],
    ['3. PPE Selection', 'Selection must match the hazard, task, environment, compatibility requirements and user characteristics.', ['Hazard Match', 'Compatibility', 'Correct Size / Fit']],
    ['4. Inspection & Maintenance', 'Inspect before use and remove defective PPE from service. Follow manufacturer care and replacement requirements.', ['Pre-Use Inspection', 'Cleaning & Storage', 'Defect Control']],
    ['5. Main PPE Hazards', 'Wrong selection, poor fit, incompatible equipment, damaged PPE, poor hygiene and false confidence can reduce protection.', ['Wrong PPE', 'Poor Fit', 'Damage']],
    ['6. Worker Training', 'Workers need instruction on selection, fitting, limitations, use, inspection, storage and reporting defects.', ['Fit & Use', 'Limitations']],
    ['7. Verification', 'Supervisors and HSE personnel verify that required PPE is available, suitable and used correctly.', ['Field Verification']],
    ['8. Stop-Work Conditions', 'Stop or control work when required PPE is missing, incompatible, defective or unsuitable for the actual hazard.', ['Missing PPE', 'Defective PPE']],
    ['9. Emergency Response', 'For contamination, exposure or PPE failure, stop exposure, move to a safe area and activate first aid/emergency arrangements as appropriate.', ['PPE Failure']],
    ['10. Practical Site Example', 'A worker is issued hearing protection that is incompatible with another required item. The combination is reassessed and a suitable compatible selection is provided.', ['HSE Verification']],
    ['11. Quick Learning Formula', 'HAZARD → SELECT → FIT → CHECK → USE → CARE → REPLACE', ['SELECT', 'CHECK']],
    ['12. HSE Roles — Topic-wise Responsibilities', 'HSE Officer: field checks. HSE Supervisor: enforcement and coaching. Senior HSE: programme assurance. HSE Coordinator: records. HSE Engineer: risk/compatibility review. HSE Manager: PPE programme governance.', []],
  ]);

  static List<DubaiPart2Section> _emergency() => _genericTopic('Emergency Preparedness & Response', 'IDENTIFY → PREPARE → ALARM → CONTROL → RESCUE → RECOVER', [
    ['1. Introduction — What is Emergency Preparedness?', 'Emergency preparedness establishes how the project responds to credible events before they occur.', ['Credible Scenarios', 'Emergency Organisation']],
    ['2. Emergency Scenarios', 'Consider fire, collapse, medical emergency, electrical incident, hazardous release, vehicle incident and severe weather as applicable to the project.', ['Fire', 'Collapse', 'Medical Emergency', 'Hazardous Release']],
    ['3. Emergency Components', 'Provide alarms, communication, routes, assembly arrangements, emergency equipment, first aid and response contacts.', ['Alarm', 'Communication', 'Assembly Area', 'First Aid']],
    ['4. Emergency Planning', 'Define roles, access, evacuation, rescue interfaces, external support and recovery responsibilities.', ['Emergency Plan', 'Rescue Plan', 'External Support']],
    ['5. Main Emergency Risks', 'Poor alarm communication, blocked access, untrained responders, uncontrolled secondary hazards and delayed escalation can worsen outcomes.', ['Communication Failure', 'Blocked Access']],
    ['6. Drills & Training', 'Use realistic exercises to test the emergency system and correct identified gaps.', ['Drills', 'Lessons Learned']],
    ['7. Inspection & Readiness', 'Check emergency equipment, routes, signage, access and contact information.', ['Equipment Check', 'Route Check']],
    ['8. Stop-Work / Escalation', 'Escalate when emergency arrangements are unavailable or credible high-risk work is proceeding without required readiness.', ['Readiness Failure']],
    ['9. Emergency Response Sequence', 'ALARM → STOP → ISOLATE IF SAFE → EVACUATE / RESCUE → MEDICAL SUPPORT → ACCOUNT → REPORT.', ['Alarm & Evacuation', 'Rescue Interface']],
    ['10. Practical Site Example', 'A fire alarm is activated near a construction work front. Work stops, personnel follow the planned route, the area is accounted for and responders control the incident.', ['HSE Verification']],
    ['11. Quick Learning Formula', 'PLAN → TRAIN → ALARM → ACCOUNT → RESCUE → RECOVER', ['PLAN', 'ACCOUNT']],
    ['12. HSE Roles — Topic-wise Responsibilities', 'HSE Officer: readiness checks. HSE Supervisor: field response coordination. Senior HSE: major emergency assurance. HSE Coordinator: contacts/records. HSE Engineer: technical emergency interfaces. HSE Manager: emergency governance.', []],
  ]);

  static List<DubaiPart2Section> _incident() => _genericTopic('Incident Reporting & Investigation', 'REPORT → PRESERVE → INVESTIGATE → CORRECT → VERIFY → LEARN', [
    ['1. Introduction — What is Incident Management?', 'A controlled process for reporting events, protecting people and evidence, understanding causes and preventing recurrence.', ['Incident', 'Near Miss', 'Unsafe Event']],
    ['2. Event Types', 'Use the project classification system for injuries, property damage, environmental events, near misses and other reportable occurrences.', ['Injury', 'Near Miss', 'Damage / Loss']],
    ['3. Immediate Actions', 'Make the area safe, provide first response, preserve evidence where appropriate and notify the required management levels.', ['Make Safe', 'First Response', 'Notification']],
    ['4. Investigation Planning', 'Define scope, team, evidence, interviews, causal analysis and reporting requirements.', ['Evidence Plan', 'Interview Plan', 'Causal Analysis']],
    ['5. Main Investigation Errors', 'Focusing only on worker behaviour, losing evidence, weak causal analysis and ineffective corrective actions reduce learning value.', ['Blame Focus', 'Lost Evidence']],
    ['6. Root / Contributing Causes', 'Consider task conditions, supervision, planning, competence, equipment, environment and management-system factors.', ['Immediate Cause', 'Underlying Cause', 'System Cause']],
    ['7. Corrective & Preventive Actions', 'Actions should address causes, have ownership and deadlines, and be verified for effectiveness.', ['Action Ownership', 'Effectiveness Check']],
    ['8. Stop-Work / Escalation', 'Serious or recurring uncontrolled conditions require immediate intervention and appropriate management escalation.', ['Serious Event', 'Recurring Risk']],
    ['9. Emergency Interface', 'Incident investigation begins after immediate emergency response and stabilisation; life safety remains the first priority.', ['Life Safety First']],
    ['10. Practical Site Example', 'A dropped object narrowly misses a worker. The area is made safe, evidence is preserved and the investigation identifies an ineffective dropped-object control.', ['HSE Verification']],
    ['11. Quick Learning Formula', 'REPORT → PROTECT → PRESERVE → ANALYSE → ACT → VERIFY → SHARE', ['PRESERVE', 'VERIFY']],
    ['12. HSE Roles — Topic-wise Responsibilities', 'HSE Officer: initial reporting/evidence. HSE Supervisor: scene control. Senior HSE: investigation assurance. HSE Coordinator: records/actions. HSE Engineer: technical analysis. HSE Manager: governance and learning.', []],
  ]);

  static List<DubaiPart2Section> _contractor() => _genericTopic('Contractor & Subcontractor HSE Management', 'PREQUALIFY → MOBILISE → INTEGRATE → MONITOR → ASSURE', [
    ['1. Introduction — What is Contractor HSE Management?', 'A structured system for controlling HSE performance across contractors and subcontractors working under the project.', ['Contractor Control', 'Shared HSE Expectations']],
    ['2. Prequalification', 'Review relevant HSE capability, experience, resources, competence, records and project-specific capacity.', ['HSE Capability', 'Competence', 'Past Performance']],
    ['3. Mobilisation & Induction', 'Confirm documentation, personnel competence, equipment, welfare, emergency arrangements and project induction before work.', ['Mobilisation Check', 'HSE Induction']],
    ['4. Contractor HSE Plan & Interface', 'Align contractor controls with project requirements, risk assessments, methods and simultaneous operations.', ['HSE Plan', 'Interface Register']],
    ['5. Main Contractor Risks', 'Poor supervision, competence gaps, inconsistent procedures, uncontrolled subcontracting and weak corrective-action closeout can create risk.', ['Supervision', 'Competence', 'Subcontracting']],
    ['6. Operational Control', 'Verify permits, method statements, toolbox talks, inspections, competency and work-front controls.', ['Permit Control', 'Field Supervision', 'Toolbox Talk']],
    ['7. Monitoring & Assurance', 'Use inspections, audits, observations, meetings and performance indicators to verify implementation.', ['Inspection', 'Audit', 'Performance Review']],
    ['8. Stop-Work / Escalation', 'Stop unsafe contractor work and escalate persistent or critical nonconformance through the project governance process.', ['Critical Nonconformance']],
    ['9. Incident & Corrective Action', 'Contractors must participate in reporting, investigation and verified closeout according to project requirements.', ['Incident Cooperation', 'Action Closeout']],
    ['10. Practical Site Example', 'A subcontractor starts high-risk work with competent workers but incomplete interface controls. The work is held until the missing controls are verified.', ['HSE Verification']],
    ['11. Quick Learning Formula', 'SELECT → INDUCT → PLAN → CONTROL → INSPECT → AUDIT → IMPROVE', ['SELECT', 'IMPROVE']],
    ['12. HSE Roles — Topic-wise Responsibilities', 'HSE Officer: field monitoring. HSE Supervisor: contractor coordination. Senior HSE: assurance. HSE Coordinator: records/interface. HSE Engineer: technical review. HSE Manager: contractor HSE governance.', []],
  ]);

  static List<DubaiPart2Section> _genericTopic(String topic, String formula, List<List<Object>> data) {
    return data.map((row) {
      final title = row[0] as String;
      final content = (row[1] as String) + (title.startsWith('1.') ? '\n\nLearning Formula: ' + formula : '');
      final names = row[2] as List<String>;
      return DubaiPart2Section(
        title: title,
        content: content,
        initiallyExpanded: title.startsWith('1.'),
        items: names.map((name) => DubaiPart2Item(title: name, detail: _itemDetail(topic, name))).toList(),
      );
    }).toList();
  }

  static String _itemDetail(String topic, String item) => '$item is a key control area within $topic. Confirm the approved method, risk assessment, competent-person requirements, physical field controls and inspection status before work. If the actual condition differs from the planned control, stop or reassess before continuing.';
}

class _Part2Topic {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  const _Part2Topic({required this.title, required this.subtitle, required this.description, required this.icon});
}
