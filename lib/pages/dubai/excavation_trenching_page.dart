import 'package:flutter/material.dart';

/// SafeNexus HSE — Excavation & Trenching
/// Professional Dubai HSE learning, field-reference and advanced-learning page.
/// Single-file architecture: Main + Advanced + Deeper Learning.

class ExcavationTrenchingPage extends StatefulWidget {
  const ExcavationTrenchingPage({super.key});

  @override
  State<ExcavationTrenchingPage> createState() => _ExcavationTrenchingPageState();
}

class _ExcavationTrenchingPageState extends State<ExcavationTrenchingPage> {
  final Set<int> _expanded = {};

  static const Color primary = Color(0xFF0B6B4F);
  static const Color dark = Color(0xFF12372F);
  static const Color background = Color(0xFFF5F8F7);

  final List<_Section> _sections = _buildSections();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Excavation & Trenching',
            style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 32),
        children: [
          _hero(),
          const SizedBox(height: 12),
          for (int i = 0; i < _sections.length; i++) _sectionCard(i, _sections[i]),
          _hseRolesCard(),
        ],
      ),
    );
  }

  Widget _hero() {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(
                color: primary.withValues(alpha: .10),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.construction_outlined, color: primary, size: 28),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text('Excavation & Trenching',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: dark)),
            ),
          ]),
          const SizedBox(height: 12),
          const Text(
            'Professional field learning for planning, protecting, inspecting and controlling excavation and trenching activities.',
            style: TextStyle(fontSize: 14.5, height: 1.55),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: primary.withValues(alpha: .07),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'FIELD RULE: No person should enter an excavation until the planned protection, access, services control, inspection and work-area controls are verified.',
              style: TextStyle(fontSize: 13, height: 1.5, fontWeight: FontWeight.w700),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _sectionCard(int index, _Section section) {
    final open = _expanded.contains(index);
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      child: Column(children: [
        InkWell(
          borderRadius: BorderRadius.circular(17),
          onTap: () => setState(() => open ? _expanded.remove(index) : _expanded.add(index)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
            child: Row(children: [
              Container(
                width: 38, height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: .09),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text('${index + 1}',
                    style: const TextStyle(color: primary, fontWeight: FontWeight.w900)),
              ),
              const SizedBox(width: 11),
              Expanded(child: Text(section.title,
                  style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800, color: dark))),
              Icon(open ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.blueGrey.shade600),
            ]),
          ),
        ),
        if (open)
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Column(children: [
              const Divider(height: 1),
              const SizedBox(height: 5),
              for (final item in section.items) _itemRow(section.title, item),
            ]),
          ),
      ]),
    );
  }

  Widget _itemRow(String sectionTitle, _Item item) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ExcavationAdvancedLearningPage(
          sectionTitle: sectionTitle,
          title: item.title,
          summary: item.summary,
          detail: item.detail,
          responsibilities: item.responsibilities,
          stopWork: item.stopWork,
        ),
      )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 11),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: 8, height: 8, margin: const EdgeInsets.only(top: 7, right: 11),
            decoration: const BoxDecoration(color: primary, shape: BoxShape.circle),
          ),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(item.title,
                style: const TextStyle(fontSize: 14.2, fontWeight: FontWeight.w700, color: dark)),
            const SizedBox(height: 3),
            Text(item.summary,
                maxLines: 2, overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12.4, height: 1.4, color: Colors.blueGrey.shade700)),
          ])),
          const SizedBox(width: 8),
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(Icons.chevron_right_rounded, size: 21, color: primary),
          ),
        ]),
      ),
    );
  }

  Widget _hseRolesCard() {
    const roles = [
      ['HSE Officer', 'Verify field controls, inspections, permits, access, barricading and corrective actions.'],
      ['HSE Supervisor', 'Maintain workface monitoring and intervene when excavation controls are not maintained.'],
      ['Senior HSE', 'Review high-risk excavation arrangements, trends, interfaces and assurance activities.'],
      ['HSE Coordinator', 'Coordinate contractor interfaces, documentation, inspections and close-out tracking.'],
      ['HSE Engineer', 'Support risk assessment, engineering interfaces, temporary support controls and technical verification.'],
      ['HSE Manager', 'Provide governance, resources, escalation and approval/assurance for critical HSE arrangements.'],
    ];
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('HSE Roles — Topic-wise Responsibilities',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: dark)),
          const SizedBox(height: 5),
          Text('Use these role expectations with the approved project organisation and authority matrix.',
              style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 12.5)),
          const SizedBox(height: 9),
          for (final r in roles)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Icon(Icons.verified_user_outlined, size: 19, color: primary),
                const SizedBox(width: 9),
                Expanded(child: RichText(text: TextSpan(
                  style: const TextStyle(color: Colors.black87, fontSize: 13.2, height: 1.45),
                  children: [
                    TextSpan(text: '${r[0]} — ', style: const TextStyle(fontWeight: FontWeight.w800, color: dark)),
                    TextSpan(text: r[1]),
                  ],
                ))),
              ]),
            ),
        ]),
      ),
    );
  }
}

class ExcavationAdvancedLearningPage extends StatelessWidget {
  final String sectionTitle, title, summary, detail;
  final List<String> responsibilities, stopWork;

  const ExcavationAdvancedLearningPage({
    super.key,
    required this.sectionTitle,
    required this.title,
    required this.summary,
    required this.detail,
    required this.responsibilities,
    required this.stopWork,
  });

  static const Color primary = Color(0xFF0B6B4F);
  static const Color dark = Color(0xFF12372F);
  static const Color background = Color(0xFFF5F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(padding: const EdgeInsets.all(14), children: [
        _heading(sectionTitle),
        _card('Core Explanation', detail),
        _card('Field Verification', summary),
        _listCard('Critical Control Points', _controls()),
        _listCard('Responsibilities', responsibilities),
        _listCard('Stop-Work Triggers', stopWork),
        _scenario(),
        const SizedBox(height: 4),
        Card(
          elevation: 0,
          color: Colors.white,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            leading: const Icon(Icons.menu_book_outlined, color: primary),
            title: const Text('Go Deeper — Practical Decision Guide',
                style: TextStyle(fontWeight: FontWeight.w800, color: dark)),
            trailing: const Icon(Icons.chevron_right_rounded, color: primary),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ExcavationDeepLearningPage(title: title, detail: detail),
            )),
          ),
        ),
      ]),
    );
  }

  Widget _heading(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(text, style: const TextStyle(color: primary, fontSize: 13, fontWeight: FontWeight.w800)),
  );

  Widget _card(String title, String body) => Card(
    margin: const EdgeInsets.only(bottom: 10),
    child: Padding(padding: const EdgeInsets.all(16), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: dark)),
        const SizedBox(height: 9),
        Text(body, style: const TextStyle(fontSize: 14.2, height: 1.6)),
      ],
    )),
  );

  Widget _listCard(String title, List<String> values) => Card(
    margin: const EdgeInsets.only(bottom: 10),
    child: Padding(padding: const EdgeInsets.all(16), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: dark)),
        const SizedBox(height: 6),
        for (int i = 0; i < values.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${i + 1}', style: const TextStyle(color: primary, fontWeight: FontWeight.w900)),
              const SizedBox(width: 9),
              Expanded(child: Text(values[i], style: const TextStyle(fontSize: 13.6, height: 1.5))),
            ]),
          ),
      ],
    )),
  );

  List<String> _controls() => [
    'Confirm the excavation method and protection arrangement before entry.',
    'Identify underground services and establish the required protection/permit controls.',
    'Keep spoil, materials, plant and vehicle loading away from vulnerable excavation edges as defined by the approved arrangement.',
    'Provide safe access and egress appropriate to the work and excavation configuration.',
    'Protect workers and the public with suitable barricading, edge protection and exclusion zones.',
    'Control water accumulation and reassess ground stability when conditions change.',
    'Inspect after relevant changes, adverse conditions and before entry in accordance with the project inspection system.',
  ];

  Widget _scenario() => Card(
    margin: const EdgeInsets.only(bottom: 10),
    child: Padding(padding: const EdgeInsets.all(16), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Practical Site Scenario', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: dark)),
        SizedBox(height: 9),
        Text(
          'A trench is prepared for utility installation. Before entry, the team verifies service information, the approved protection system, access, edge controls, spoil/plant positioning, water condition and the competent-person inspection. A change in soil condition or nearby loading triggers reassessment before work continues.',
          style: TextStyle(fontSize: 13.8, height: 1.55),
        ),
      ],
    )),
  );
}

class ExcavationDeepLearningPage extends StatelessWidget {
  final String title, detail;
  const ExcavationDeepLearningPage({super.key, required this.title, required this.detail});

  static const Color primary = Color(0xFF0B6B4F);
  static const Color dark = Color(0xFF12372F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Practical Decision Guide'),
          backgroundColor: primary, foregroundColor: Colors.white),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: dark)),
        const SizedBox(height: 14),
        _decision('1', 'Before entry', 'Ask: Is the excavation planned, protected, accessible, inspected and authorised for the intended work?'),
        _decision('2', 'Ground condition', 'Ask: Has soil, water, vibration, weather, adjacent loading or nearby construction changed the stability assumptions?'),
        _decision('3', 'Services', 'Ask: Are underground services positively identified and controlled before excavation reaches the affected zone?'),
        _decision('4', 'Edge loading', 'Ask: Could spoil, materials, vehicles, cranes, plant or structures impose additional loading or vibration on the excavation?'),
        _decision('5', 'Protection integrity', 'Ask: Is the installed shoring, trench box, benching or sloping arrangement complete and consistent with the approved method/design?'),
        _decision('6', 'Restart decision', 'If a critical condition changes or a control is missing, stop the affected work, make the area safe and reassess before restart.'),
        Card(child: Padding(padding: const EdgeInsets.all(15), child: Text(
          'Learning focus: excavation safety is a stability-and-exposure problem. Control the ground, the edge, the people, the plant, the services and the changing conditions together.',
          style: const TextStyle(fontSize: 14, height: 1.6, fontWeight: FontWeight.w700),
        ))),
      ]),
    );
  }

  Widget _decision(String n, String h, String b) => Card(
    margin: const EdgeInsets.only(bottom: 9),
    child: Padding(padding: const EdgeInsets.all(14), child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 15, backgroundColor: primary, child: Text(n, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800))),
        const SizedBox(width: 11),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(h, style: const TextStyle(fontWeight: FontWeight.w900, color: dark)),
          const SizedBox(height: 4),
          Text(b, style: const TextStyle(fontSize: 13.4, height: 1.5)),
        ])),
      ],
    )),
  );
}

class _Section {
  final String title;
  final List<_Item> items;
  const _Section(this.title, this.items);
}

class _Item {
  final String title, summary, detail;
  final List<String> responsibilities, stopWork;
  const _Item({
    required this.title,
    required this.summary,
    required this.detail,
    this.responsibilities = const [],
    this.stopWork = const [],
  });
}

List<String> _commonRiggerPlant = const [
  'Rigger / Plant Team — verify plant positioning, lifting/access interfaces and keep loads/vehicles clear of unsafe excavation edges.',
  'Rigger / Plant Team — follow the approved lifting and exclusion-zone arrangements where lifting interacts with the excavation.',
  'Plant Operator — maintain safe travel, parking and loading arrangements and follow the banksman/signaller system where required.',
];

_Section _s(String title, List<_Item> items) => _Section(title, items);

List<_Section> _buildSections() => [
  _s('Introduction — What is Excavation?', [
    _Item(title: 'Purpose of Excavation', summary: 'Removal of ground to create space for foundations, utilities, structures or access.',
      detail: 'Excavation is the controlled removal of soil, rock or other ground material to form a trench, pit, foundation area, chamber or other below-ground work space. The safety challenge is not only the digging operation; it includes ground stability, people exposure, services, water, plant, edge loading, adjacent structures and access.',
      responsibilities: ['Competent planning and supervision must match the excavation risk.', 'Workers must enter only after required controls are verified.'],
      stopWork: ['Protection is absent or damaged.', 'Ground movement, cracking, collapse or uncontrolled water is observed.']),
    _Item(title: 'Excavation Life Cycle', summary: 'Plan → locate services → establish protection → excavate → inspect → work → backfill.',
      detail: 'Safe excavation is a controlled sequence. The team should understand the planned method, identify interfaces and services, establish protection, control the workface, inspect critical conditions and maintain controls until the excavation is safely closed or backfilled.',
      responsibilities: ['HSE verifies field implementation and monitoring.', 'Supervisor controls the sequence at the workface.'],
      stopWork: ['The actual condition no longer matches the approved method.']),
  ]),
  _s('Types of Excavation', [
    _Item(title: 'Open Excavation', summary: 'Broad excavation with exposed ground and working space.',
      detail: 'Open excavations may be used for foundations, basements, roads or other construction works. The protection approach depends on geometry, ground conditions, depth, adjacent structures, water and the approved engineering arrangement.', stopWork: ['Unexpected ground movement or instability.', 'Public or plant exposure is uncontrolled.']),
    _Item(title: 'Trench Excavation', summary: 'Narrow excavation typically used for linear utility or service work.',
      detail: 'A trench creates a high-consequence ground-collapse exposure because people often work within a relatively confined space. The selected protective system and access arrangement must suit the actual ground and work method.', stopWork: ['Entry occurs without the required protective system.', 'Access or egress is unsafe.']),
    _Item(title: 'Foundation Excavation', summary: 'Excavation formed for footings, foundations or structural works.',
      detail: 'Foundation excavations can interact with adjacent structures, temporary works, reinforcement, formwork, concrete operations and lifting activities. The excavation must be coordinated with the construction sequence.', stopWork: ['Adjacent structure or temporary support is affected.']),
    _Item(title: 'Deep Excavation', summary: 'Excavation where depth and surrounding interfaces create increased engineering complexity.',
      detail: 'Deep excavations require a project-specific engineered approach considering ground conditions, support systems, groundwater, adjacent assets, monitoring and construction sequence. Do not rely on a generic rule for a complex excavation.', stopWork: ['Monitoring indicates movement beyond approved limits.', 'Support or monitoring arrangements are compromised.']),
    _Item(title: 'Utility Excavation', summary: 'Excavation to install, repair or expose underground services.',
      detail: 'Utility excavation requires positive service identification, controlled digging methods, protection of existing services and coordination with service owners or approved procedures.', stopWork: ['Service location is uncertain.', 'An unidentified service is encountered.']),
    _Item(title: 'Manhole / Chamber Excavation', summary: 'Excavation associated with below-ground chambers and access structures.',
      detail: 'These excavations may combine excavation hazards with confined-space risks, restricted access, water, gases and lifting interfaces. Treat the combined hazards as an integrated work package.', stopWork: ['Confined-space conditions are not controlled.', 'Water or atmospheric hazards are uncontrolled.']),
  ]),
  _s('Excavation Components & Protection', [
    _Item(title: 'Shoring', summary: 'Structural support system used to control ground movement.',
      detail: 'Shoring is a support arrangement selected and installed according to the approved design or competent technical method. It must remain stable, complete and protected from unauthorised alteration.', stopWork: ['Shoring is damaged, incomplete or modified without authorisation.']),
    _Item(title: 'Trench Box', summary: 'Protective system designed to provide a protected working zone in a trench.',
      detail: 'A trench box is a protective system, not a substitute for planning. Installation, positioning, access and movement must follow the manufacturer/approved arrangement and site conditions.', stopWork: ['The box is damaged or used outside its approved arrangement.']),
    _Item(title: 'Benching', summary: 'Formation of stepped excavation profiles to manage ground exposure.',
      detail: 'Benching must be designed or selected for the actual ground and excavation arrangement. It should not be improvised at the workface without competent assessment.', stopWork: ['The benching profile is unstable or inconsistent with the approved method.']),
    _Item(title: 'Sloping', summary: 'Controlled inclination of excavation sides to reduce collapse exposure.',
      detail: 'Sloping depends on ground type, geometry, water and adjacent conditions. The angle must be determined by the approved engineering/competent arrangement rather than an assumed universal value.', stopWork: ['Cracking, sloughing or unexpected movement is observed.']),
    _Item(title: 'Edge Protection', summary: 'Controls people and objects at excavation edges.',
      detail: 'Edge protection should prevent falls and control access to the excavation. Its design and location should account for pedestrian movement, plant interfaces and falling-object exposure.', stopWork: ['Open edge exposes people without effective protection.']),
    _Item(title: 'Barricade & Exclusion Zone', summary: 'Defines and protects the excavation work area.',
      detail: 'Barricading should be visible, stable and maintained. Exclusion zones should reflect the excavation, plant, lifting, falling-object and public-interface risks.', stopWork: ['Unauthorised access cannot be effectively controlled.']),
    _Item(title: 'Ladder / Safe Access', summary: 'Provides controlled entry and exit.',
      detail: 'Access must be suitable for the excavation configuration, location and work activity. Emergency egress should be considered as part of the access plan.', stopWork: ['Access is obstructed, unstable or insufficient for the task.']),
    _Item(title: 'Spoil Pile Control', summary: 'Controls excavated material near the excavation edge.',
      detail: 'Spoil placement must be controlled to avoid creating unsafe edge loading, falling material or blocked access. The safe arrangement should follow the approved method and ground/support assessment.', stopWork: ['Spoil or materials create uncontrolled edge loading or falling-object risk.']),
    _Item(title: 'Dewatering', summary: 'Controls water accumulation and its effect on excavation stability.',
      detail: 'Water can weaken ground, affect visibility, access and support performance, and create electrical or contamination hazards. Dewatering must be planned and monitored.', stopWork: ['Water accumulation is affecting stability or safe access.']),
    _Item(title: 'Underground Services', summary: 'Identification and protection of existing buried utilities.',
      detail: 'Service drawings, detection, marking, permits and controlled excavation methods should be integrated before breaking ground. The required process depends on the service and project arrangements.', stopWork: ['Service identity/location is uncertain or a service is unexpectedly exposed.']),
  ]),
  _s('Technical Requirements', [
    _Item(title: 'Approved Excavation Method', summary: 'Define sequence, equipment, protection, access and controls.',
      detail: 'The excavation method should reflect the actual work, ground conditions, depth, protection system, nearby structures, services, water, plant and emergency arrangements. Field conditions must be checked against the approved method.', stopWork: ['Work starts without the required approved method or control.']),
    _Item(title: 'Ground Stability Assessment', summary: 'Consider soil/rock, water, loading, vibration and adjacent conditions.',
      detail: 'Ground stability is affected by more than excavation depth. Consider material behaviour, groundwater, weather, vibration, traffic, nearby foundations and temporary works. Complex conditions require competent engineering input.', stopWork: ['Stability assumptions no longer match field conditions.']),
    _Item(title: 'Protection System Integrity', summary: 'Keep shoring, trench boxes, benching or sloping complete and stable.',
      detail: 'Protective systems must be installed, used, inspected and maintained according to their approved arrangement. Workers must not remove or alter structural protection without authorisation.', stopWork: ['Protection is missing, damaged, displaced or unauthorisedly modified.']),
    _Item(title: 'Interface Control', summary: 'Coordinate excavation with lifting, scaffolding, temporary works and traffic.',
      detail: 'Excavation can undermine nearby structures, affect crane/plant positioning, change access routes and interact with temporary works. Interfaces must be planned rather than managed informally.', stopWork: ['An interface creates a new uncontrolled stability or exposure risk.']),
  ]),
  _s('Excavation Risk Assessment & Planning', [
    _Item(title: 'Hazard Identification', summary: 'Identify collapse, services, water, falls, plant, atmosphere and interfaces.',
      detail: 'The assessment should identify who can be exposed, how exposure can occur and which controls prevent the event. Consider normal work, abnormal conditions and emergency situations.', responsibilities: ['HSE supports risk review and field verification.', 'Supervisor confirms controls at the workface.']),
    _Item(title: 'Sequence & Hold Points', summary: 'Define when excavation can progress and when checks are mandatory.',
      detail: 'A safe sequence may include service verification, initial excavation, protection installation, inspection, controlled progression and final reinstatement. Hold points should be clear to the work team.', stopWork: ['A required hold point or verification is bypassed.']),
    _Item(title: 'Emergency & Rescue Planning', summary: 'Plan response to collapse, engulfment, flooding, service strike and injury.',
      detail: 'Emergency planning should match the actual excavation and access arrangements. Rescue must not expose additional people to collapse or atmospheric hazards.', stopWork: ['Emergency access or rescue arrangements are unavailable for a high-risk task.']),
  ]),
  _s('Main Hazards', [
    _Item(title: 'Ground Collapse / Engulfment', summary: 'Potential burial, crushing or fatal injury.',
      detail: 'Collapse can occur suddenly and can result from unsupported ground, unsuitable protection, water, vibration, edge loading, nearby structures or changing conditions. Prevention depends on an appropriate protection system and continuous control.', stopWork: ['Cracks, bulging, sloughing, movement or collapse signs.']),
    _Item(title: 'Falls into Excavation', summary: 'People or objects can fall from exposed edges.',
      detail: 'Controls include edge protection, barricading, safe access, lighting, housekeeping and exclusion zones. The arrangement must suit workers, visitors and public interfaces.', stopWork: ['Open edge is accessible without effective controls.']),
    _Item(title: 'Plant / Vehicle Interaction', summary: 'Mobile equipment can strike people or destabilise excavation edges.',
      detail: 'Control traffic routes, parking, reversing, banksman/signaller arrangements, exclusion zones and edge loading. Plant positioning should follow the approved site arrangement.', stopWork: ['Plant enters an unsafe exclusion zone or edge loading is uncontrolled.']),
    _Item(title: 'Water Ingress', summary: 'Water can weaken ground and affect access.',
      detail: 'Monitor groundwater, rain, leakage and process water. Control accumulation and reassess stability when water conditions change.', stopWork: ['Water compromises stability or access.']),
    _Item(title: 'Service Strike', summary: 'Damage to electrical, gas, water or communication services.',
      detail: 'A service strike can cause electrocution, fire, explosion, flooding, outage or structural damage. Service identification and controlled excavation are critical.', stopWork: ['Unknown service encountered or service protection is compromised.']),
    _Item(title: 'Atmospheric / Confined-Space Risk', summary: 'Some chambers and deep/restricted excavations may require atmospheric controls.',
      detail: 'Where the configuration meets confined-space criteria or creates atmospheric hazards, apply the project confined-space system, including assessment, testing, ventilation, permit and rescue arrangements as applicable.', stopWork: ['Atmosphere is unsafe or required confined-space controls are absent.']),
  ]),
  _s('Protection Systems', [
    _Item(title: 'Select the Right System', summary: 'Match protection to ground, geometry, depth and interfaces.',
      detail: 'Protection selection should be based on competent assessment or engineered design where required. Do not select a system solely because it was used on a previous excavation.', stopWork: ['Protection does not match actual conditions.']),
    _Item(title: 'Protective System Maintenance', summary: 'Keep the system stable throughout the work.',
      detail: 'Inspect for movement, damage, displacement, corrosion, impact and unauthorised changes. Maintain manufacturer/engineering requirements.', stopWork: ['Protection has been compromised.']),
    _Item(title: 'No Unauthorised Modification', summary: 'Workers must not remove structural protection for convenience.',
      detail: 'Changes to shoring, trench boxes, benching or sloping can invalidate the protective arrangement. Any change requires the appropriate competent/engineering approval.', stopWork: ['Protection is altered without authorisation.']),
  ]),
  _s('Access & Egress', [
    _Item(title: 'Safe Entry Route', summary: 'Provide suitable access close to the work area.',
      detail: 'Access should be stable, clear and maintained. Consider the number of workers, tools/materials and emergency evacuation needs.', stopWork: ['Workers climb unstable surfaces or use an unsafe route.']),
    _Item(title: 'Emergency Egress', summary: 'Workers need a realistic route out during changing conditions.',
      detail: 'Egress arrangements should consider water, collapse, plant movement, service incidents and the excavation geometry.', stopWork: ['Emergency exit route is blocked or unavailable.']),
  ]),
  _s('Underground Services', [
    _Item(title: 'Service Information', summary: 'Obtain and verify current service information before excavation.',
      detail: 'Use the project-approved service-location process. Drawings alone may not prove the exact position; verification and marking methods should follow the applicable project procedure.', stopWork: ['Required service information is missing or unreliable.']),
    _Item(title: 'Detection & Marking', summary: 'Identify the service route and communicate it to the excavation team.',
      detail: 'Use suitable detection/verification methods and clearly mark known services. Maintain markings as excavation progresses.', stopWork: ['Marked service route is unclear or inconsistent with field evidence.']),
    _Item(title: 'Safe Digging Near Services', summary: 'Use controlled methods when approaching identified services.',
      detail: 'The approved method should specify how mechanical and manual excavation are controlled near services and who has authority to direct the work.', stopWork: ['Required safe-dig procedure is not being followed.']),
  ]),
  _s('Water & Dewatering', [
    _Item(title: 'Water Monitoring', summary: 'Monitor groundwater, rain and leakage throughout the excavation.',
      detail: 'Water conditions can change rapidly. Monitoring should be linked to the stability and access assessment.', stopWork: ['Water level or flow creates a new stability or rescue risk.']),
    _Item(title: 'Dewatering System', summary: 'Control water without undermining ground or adjacent assets.',
      detail: 'Dewatering should be designed and managed so that removal of water does not create unacceptable settlement, piping or instability. Follow the approved engineering arrangement.', stopWork: ['Dewatering causes unexpected ground movement or system failure.']),
  ]),
  _s('Plant, Vehicle & Spoil Control', [
    _Item(title: 'Plant Positioning', summary: 'Keep equipment positioned according to the approved edge/loading arrangement.',
      detail: 'Plant weight, dynamic loading and vibration can affect excavation stability. Positioning must be controlled by the approved method and competent assessment.', responsibilities: _commonRiggerPlant, stopWork: ['Plant is positioned where edge stability/loading is not verified.']),
    _Item(title: 'Traffic Management', summary: 'Separate people, plant and excavation edges.',
      detail: 'Use defined routes, exclusion zones, banksman/signaller controls where required and clear communication. Avoid uncontrolled reversing near excavation edges.', responsibilities: _commonRiggerPlant, stopWork: ['Traffic route or exclusion zone fails.']),
    _Item(title: 'Spoil & Material Storage', summary: 'Control storage and loading near the excavation.',
      detail: 'Materials, spoil and temporary loads must be located in accordance with the approved arrangement to avoid surcharge and falling-object risks.', stopWork: ['Storage creates uncontrolled edge loading.']),
  ]),
  _s('Inspection', [
    _Item(title: 'Pre-Entry Inspection', summary: 'Verify protection, access, edges, water, services and work conditions before entry.',
      detail: 'The competent inspection should confirm that the excavation remains consistent with the approved arrangement and that critical controls are present. Inspection frequency and records should follow the project system and applicable requirements.', stopWork: ['Required inspection has not been completed or critical defect remains.']),
    _Item(title: 'Change / Weather Inspection', summary: 'Reinspect after events that could affect stability or controls.',
      detail: 'Heavy rain, water ingress, vibration, nearby construction, plant impact, ground movement or changes to support can require reassessment and reinspection.', stopWork: ['Post-event condition is not verified.']),
    _Item(title: 'Record & Close Actions', summary: 'Document findings and verify corrective actions.',
      detail: 'Inspection is effective only when defects are controlled. Record the issue, responsible person, due date and verification of closure.', stopWork: ['Critical corrective action remains open while exposure continues.']),
  ]),
  _s('Stop-Work Conditions', [
    _Item(title: 'Collapse / Movement Indicators', summary: 'Cracking, bulging, sloughing, settlement or unexpected movement.',
      detail: 'Any indication of instability requires immediate control of the area and reassessment. Do not enter to investigate a potentially unstable excavation unless the rescue/investigation method itself is safe.', stopWork: ['Any credible instability indicator.']),
    _Item(title: 'Protection Failure', summary: 'Shoring, trench box, benching or sloping is damaged or inadequate.',
      detail: 'Stop the affected work and prevent entry until the protection arrangement is restored or revised by the competent authority.', stopWork: ['Protection system failure or unauthorised modification.']),
    _Item(title: 'Service Uncertainty', summary: 'Unknown service, unexpected cable/pipe or loss of service information.',
      detail: 'Stop excavation in the affected zone and follow the approved service verification/escalation process.', stopWork: ['Service identity or location is uncertain.']),
    _Item(title: 'Unsafe Water / Atmosphere', summary: 'Flooding, rapid water ingress or unsafe atmospheric conditions.',
      detail: 'Remove exposure and activate the relevant emergency or specialist control process.', stopWork: ['Unsafe atmosphere or uncontrolled flooding.']),
  ]),
  _s('Excavation near Lifting / Scaffolding / Temporary Works', [
    _Item(title: 'Near Lifting Operations', summary: 'Crane/plant loading, suspended loads and excavation stability must be coordinated.',
      detail: 'Lifting near excavations requires consideration of crane outrigger/loading, ground bearing, exclusion zones, suspended loads and the excavation protection arrangement. The lifting plan and excavation method must be compatible.', responsibilities: _commonRiggerPlant, stopWork: ['Crane/plant ground condition or edge loading is not verified.']),
    _Item(title: 'Near Scaffolding', summary: 'Excavation can affect scaffold foundations and stability.',
      detail: 'Do not excavate in a way that undermines scaffold bases, sole boards, ties or adjacent ground without competent assessment and an approved temporary arrangement.', stopWork: ['Scaffold support or ground is affected unexpectedly.']),
    _Item(title: 'Near Temporary Works', summary: 'Excavation can affect retaining, formwork, falsework and other temporary structures.',
      detail: 'Coordinate excavation sequence with temporary works design and inspection. Changes in ground support can transfer loads or cause movement.', stopWork: ['Temporary works stability is uncertain or monitoring indicates movement.']),
  ]),
  _s('Competent Person Responsibilities', [
    _Item(title: 'Pre-Work Verification', summary: 'Confirm the excavation method and critical controls before work.',
      detail: 'The competent person verifies that the planned excavation arrangement is appropriate to the actual site conditions and that required protection and access are established.', stopWork: ['Critical controls cannot be verified.']),
    _Item(title: 'Ongoing Condition Monitoring', summary: 'Recognise changes and escalate early.',
      detail: 'Monitor ground, water, support, loading, nearby activities and other conditions that could change excavation stability.', stopWork: ['Condition changes beyond the approved arrangement.']),
    _Item(title: 'Authority to Stop', summary: 'Stop work when controls are inadequate.',
      detail: 'A competent person should have clear authority to prevent entry or progression until safety-critical conditions are restored.', stopWork: ['Any uncontrolled high-risk exposure.']),
  ]),
  _s('Worker Responsibilities', [
    _Item(title: 'Follow the Method', summary: 'Work only within the approved sequence and controls.',
      detail: 'Workers must follow instructions, use access systems correctly and never remove or alter protection for convenience.', stopWork: ['Worker is asked to bypass a safety-critical control.']),
    _Item(title: 'Report Changes', summary: 'Report cracks, water, movement, damaged barriers and service concerns immediately.',
      detail: 'Workers are often first to see changing conditions. Early reporting prevents escalation.', stopWork: ['Any significant change is observed and not yet assessed.']),
    _Item(title: 'Stay Inside Controls', summary: 'Respect exclusion zones and plant separation.',
      detail: 'Do not enter restricted areas, stand under suspended loads or approach moving plant without the required controls.', stopWork: ['Exclusion zone is ineffective.']),
  ]),
  _s('Emergency Response', [
    _Item(title: 'Collapse / Engulfment', summary: 'Raise alarm, isolate the area and prevent secondary collapse exposure.',
      detail: 'Do not rush unprotected rescuers into an unstable excavation. Activate the project emergency and specialist rescue arrangements and control plant/traffic around the area.', stopWork: ['Rescue route or ground stability is unsafe.']),
    _Item(title: 'Service Strike', summary: 'Stop work and follow the service emergency procedure.',
      detail: 'Keep people away from the affected area and follow the approved response for electrical, gas, water or communication service incidents.', stopWork: ['Service incident remains uncontrolled.']),
    _Item(title: 'Flooding / Water Ingress', summary: 'Evacuate where required and control the source if safe.',
      detail: 'Rapid water ingress can change stability quickly. Protect people first and do not enter an unstable flooded excavation.', stopWork: ['Water level or flow creates immediate danger.']),
  ]),
  _s('Practical Site Example', [
    _Item(title: 'Utility Trench Example', summary: 'A utility trench changes condition after rain and nearby plant movement.',
      detail: 'The supervisor notices water accumulation and fresh edge cracking. Work stops, workers leave the trench, plant is moved to a safe controlled location, the competent person reassesses the condition and the protection/dewatering arrangement is reviewed before restart.', stopWork: ['Cracking, water and loading create an unverified condition.']),
    _Item(title: 'HVAC / Service Chamber Example', summary: 'A chamber excavation also presents confined-space concerns.',
      detail: 'The team treats excavation, access, atmosphere, water and rescue as one integrated work package. Entry is controlled through the applicable project procedures rather than treating the chamber as an ordinary open excavation.', stopWork: ['Atmospheric or rescue controls are incomplete.']),
  ]),
  _s('Quick Learning Formula', [
    _Item(title: 'PLAN', summary: 'Know the ground, services, sequence, protection and interfaces.',
      detail: 'PLAN = method + ground + services + protection + access + emergency + interfaces.', stopWork: ['Critical planning information is missing.']),
    _Item(title: 'PROTECT', summary: 'Install and maintain the right protection before exposure.',
      detail: 'PROTECT = shoring/trench box/benching/sloping + edge control + exclusion + access.', stopWork: ['Protection is missing or compromised.']),
    _Item(title: 'INSPECT', summary: 'Verify before entry and after meaningful changes.',
      detail: 'INSPECT = condition + support + water + services + access + edge + plant + records.', stopWork: ['Inspection or verification is incomplete.']),
    _Item(title: 'STOP', summary: 'Stop when stability or critical controls are uncertain.',
      detail: 'STOP = movement + service uncertainty + water danger + protection failure + unsafe interface.', stopWork: ['Any credible critical trigger.']),
  ]),
  _s('Rigger / Plant — Topic-wise Responsibilities', [
    _Item(title: 'Rigger / Plant — Excavation Interface', summary: 'Control lifting, plant and edge-loading interfaces.',
      detail: 'Rigger/plant teams must follow the approved lifting and traffic arrangement and ensure equipment, loads and vehicle movements do not create uncontrolled excavation-edge loading or exclusion-zone conflicts.',
      responsibilities: _commonRiggerPlant, stopWork: ['Unsafe crane/plant positioning.', 'Exclusion-zone breach.', 'Ground/edge condition not verified for the operation.']),
    _Item(title: 'Banksman / Signaller', summary: 'Control plant movement around excavation interfaces.',
      detail: 'Where the site system requires a banksman/signaller, they should maintain clear communication and prevent plant movement into restricted or unsafe areas.', responsibilities: _commonRiggerPlant,
      stopWork: ['Communication is lost or the route cannot be safely controlled.']),
  ]),
];
