import 'package:flutter/material.dart';

class DubaiHsePart1AdvancedLearningPage extends StatelessWidget {
  final String topicTitle;
  final String sectionTitle;
  final String title;
  final String summary;

  const DubaiHsePart1AdvancedLearningPage({
    super.key,
    required this.topicTitle,
    required this.sectionTitle,
    required this.title,
    required this.summary,
  });

  static const Color primary = Color(0xFF087F5B);
  static const Color dark = Color(0xFF17352B);
  static const Color background = Color(0xFFF5F8F7);

  List<String> _detailPoints() {
    final key = title.toLowerCase();

    if (key.contains('construction safety objective')) {
      return [
        'Construction safety starts with controlling the work before people are exposed to the hazard.',
        'The project should identify safety-critical activities, competent supervision and the interfaces between work packages.',
        'Field verification is essential because a written procedure does not by itself create a physical control.',
        'The HSE team should focus attention on high-consequence risks and verify that critical controls remain effective.',
      ];
    }
    if (key.contains('risk assessment')) {
      return [
        'Define the exact task, work sequence, location, people exposed and credible consequences.',
        'Identify hazards before selecting controls. Consider equipment, energy, environment, human factors and simultaneous operations.',
        'Evaluate risk using the project-approved methodology and select controls using the hierarchy of controls.',
        'Assign responsibility for each critical control and verify implementation before exposure.',
        'Review the assessment whenever the method, location, workforce, equipment, weather or surrounding work changes.',
      ];
    }
    if (key.contains('method statement')) {
      return [
        'Describe the intended safe sequence from preparation through completion.',
        'Identify prerequisites such as competent personnel, equipment, permits, access, exclusion zones and emergency arrangements.',
        'The workforce should understand the portions relevant to its work before starting.',
        'Compare the approved method with the actual field condition and stop when a material deviation creates uncontrolled risk.',
      ];
    }
    if (key.contains('fall prevention') || key.contains('work at height')) {
      return [
        'First consider whether the work at height can be eliminated or completed from a safe level.',
        'Where height exposure remains, prioritize suitable collective protection such as protected platforms and edge protection.',
        'Use personal fall-protection equipment only as part of a complete system with compatible anchorage, clearance, training and rescue arrangements.',
        'Control dropped objects and prevent people from entering areas below overhead work.',
      ];
    }
    if (key.contains('scaffold')) {
      return [
        'Use a suitable scaffold system for the intended duty and configuration.',
        'Verify stability, access, platform condition, edge protection, ties and inspection status as applicable.',
        'Do not make uncontrolled alterations or remove safety-critical components.',
        'Coordinate lifting, material loading and nearby work so the scaffold is not struck, overloaded or destabilized.',
      ];
    }
    if (key.contains('mobile access tower')) {
      return [
        'Use the tower on a suitable stable surface and keep the configuration within the approved system requirements.',
        'Check platform, guardrails, access, castors, stability and surrounding hazards before use.',
        'Prevent unintended movement while people are on the tower.',
        'Reassess when the tower location, weather, access or surrounding work changes.',
      ];
    }
    if (key.contains('confined') || key.contains('entry principle')) {
      return [
        'Avoid entry where the work can be completed from outside the space.',
        'If entry is necessary, identify atmospheric, mechanical, electrical, engulfment, access and rescue hazards.',
        'Establish the required permit, isolation, atmospheric testing, ventilation, communication, standby and rescue controls before entry.',
        'A change in atmosphere, isolation or rescue capability is a reason to stop and reassess.',
      ];
    }
    if (key.contains('gas detector')) {
      return [
        'Use a detector suitable for the hazards identified by the risk assessment.',
        'Confirm the instrument is within the project-required calibration or functional-control system.',
        'Test before entry and continue monitoring at the frequency required by the assessment and permit.',
        'Treat abnormal or unexplained readings as a serious control failure and follow the entry emergency procedure.',
      ];
    }
    if (key.contains('electrical') || key.contains('isolation') || key.contains('portable tools')) {
      return [
        'Identify the correct electrical energy source before isolation.',
        'Apply the approved isolation and lockout process and verify the safe condition before exposure.',
        'Protect temporary electrical systems, cables, plugs and tools from damage and environmental exposure.',
        'Remove defective electrical equipment from service and prevent unintended re-energization.',
      ];
    }

    return [
      summary,
      'Understand the exact task, work sequence and people who may be exposed.',
      'Identify the critical hazard and the control that prevents the most serious credible outcome.',
      'Verify the control physically in the field before work starts.',
      'Monitor the control during execution and reassess when conditions change.',
      'Stop the affected work when a critical control is missing, ineffective or no longer valid.',
    ];
  }

  List<String> _fieldChecks() {
    final key = title.toLowerCase();

    if (key.contains('lifting') || key.contains('crane')) {
      return [
        'Confirm the approved lifting arrangement, load information and competent team.',
        'Verify equipment and accessory condition, identification and required status.',
        'Check ground, load path, exclusion zone and communication.',
        'Stop for unstable ground, damaged equipment, lost communication or unexpected load movement.',
      ];
    }
    if (key.contains('excavation') || key.contains('trench')) {
      return [
        'Check excavation condition, edge protection, access and protective system.',
        'Confirm underground-service information and control plant or vehicle approach.',
        'Check water, spoil placement and signs of ground movement.',
        'Stop for cracking, collapse indicators, flooding, unknown services or failed protection.',
      ];
    }
    if (key.contains('confined') || key.contains('gas')) {
      return [
        'Verify permit and isolation before entry.',
        'Confirm atmospheric testing and required continuous monitoring.',
        'Check ventilation, communication, standby and rescue readiness.',
        'Stop entry for unsafe atmosphere, failed isolation or loss of rescue capability.',
      ];
    }
    if (key.contains('electrical') || key.contains('isolation') || key.contains('tool')) {
      return [
        'Identify and isolate the correct energy source.',
        'Verify the safe condition using the approved method and competent personnel.',
        'Check cables, plugs, distribution equipment and physical protection.',
        'Stop for exposed energized parts, damaged equipment or unknown services.',
      ];
    }
    if (key.contains('height') || key.contains('scaffold') || key.contains('tower')) {
      return [
        'Check access, platform condition and collective fall protection.',
        'Verify openings, edges, fragile surfaces and dropped-object controls.',
        'Inspect fall-protection equipment where personal protection is required.',
        'Stop for unstable access, missing protection, defective equipment or unsafe weather.',
      ];
    }

    return [
      'Confirm the work location and actual work sequence.',
      'Verify people, equipment and controls physically present.',
      'Check interfaces with other work, plant, structures and public areas.',
      'Record deviations and correct them before the affected work continues.',
    ];
  }

  List<String> _rolePoints() {
    final key = title.toLowerCase();

    if (key.contains('risk assessment')) {
      return [
        'HSE Officer: verify field implementation and identify gaps between the assessment and actual work.',
        'HSE Supervisor: coordinate briefing, field verification and immediate corrective actions.',
        'Senior HSE: review significant and recurring high-risk findings.',
        'HSE Coordinator: control assessment records, revisions and action tracking.',
        'HSE Engineer: provide technical input for complex engineering and interface risks.',
        'HSE Manager: provide governance, escalation and assurance for project risk management.',
      ];
    }
    if (key.contains('height') || key.contains('scaffold') || key.contains('tower')) {
      return [
        'HSE Officer: inspect fall-prevention controls and intervene on unsafe exposure.',
        'HSE Supervisor: supervise daily access, protection, briefing and inspection controls.',
        'Senior HSE: assure high-risk work-at-height arrangements and recurring fall-risk trends.',
        'HSE Coordinator: coordinate competency, inspection and rescue-related records.',
        'HSE Engineer: review technical access, anchorage and temporary-system interfaces.',
        'HSE Manager: provide project-level fall-prevention governance and assurance.',
      ];
    }
    if (key.contains('confined') || key.contains('gas')) {
      return [
        'HSE Officer: verify permit, atmosphere controls, PPE, access and standby arrangements.',
        'HSE Supervisor: coordinate field entry controls and stop-work actions.',
        'Senior HSE: assure high-risk entry and rescue readiness.',
        'HSE Coordinator: coordinate permits, training, records and contractor interfaces.',
        'HSE Engineer: review isolation, ventilation and technical atmospheric controls.',
        'HSE Manager: provide governance and assurance for confined-space entry.',
      ];
    }
    if (key.contains('electrical') || key.contains('isolation') || key.contains('tool')) {
      return [
        'HSE Officer: monitor temporary power, tools, guarding and field compliance.',
        'HSE Supervisor: supervise daily electrical controls and corrective actions.',
        'Senior HSE: assure major electrical risks and recurring findings.',
        'HSE Coordinator: coordinate records, training and contractor interfaces.',
        'HSE Engineer: review isolation, electrical-service and technical interface risks.',
        'HSE Manager: provide electrical-safety governance and escalation.',
      ];
    }

    return [
      'HSE Officer: verify the critical control in the field, record observations and follow up correction.',
      'HSE Supervisor: supervise daily implementation, briefings and immediate corrective action.',
      'Senior HSE: provide senior assurance for high-consequence and recurring risks.',
      'HSE Coordinator: coordinate records, actions, communications and contractor interfaces.',
      'HSE Engineer: review technical and engineering interfaces affecting the control.',
      'HSE Manager: provide governance, escalation, performance assurance and continual improvement.',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final points = _detailPoints();
    final checks = _fieldChecks();
    final roles = _rolePoints();

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8F3EF),
        foregroundColor: dark,
        elevation: 0,
        title: const Text(
          'Advanced HSE Learning',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          _HeroCard(
            topicTitle: topicTitle,
            sectionTitle: sectionTitle,
            title: title,
            summary: summary,
          ),
          const SizedBox(height: 14),
          _SectionBlock(
            title: 'Professional Explanation',
            icon: Icons.school_rounded,
            children: [
              ...List.generate(
                points.length,
                (index) => _NumberedCard(
                  number: index + 1,
                  text: points[index],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _SectionBlock(
            title: 'Field Verification',
            icon: Icons.fact_check_rounded,
            children: [
              ...List.generate(
                checks.length,
                (index) => _NumberedCard(
                  number: index + 1,
                  text: checks[index],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _SectionBlock(
            title: 'HSE Responsibilities',
            icon: Icons.health_and_safety_rounded,
            children: [
              ...List.generate(
                roles.length,
                (index) => _NumberedCard(
                  number: index + 1,
                  text: roles[index],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _AdvancedActionTile(
            title: 'Go Deeper — Practical Decision Guide',
            detail:
                'Open the next learning level for a field decision sequence: identify → verify → control → monitor → stop/restart.',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => DubaiHsePart1DeepLearningPage(
                  topicTitle: topicTitle,
                  title: title,
                  points: [
                    'Identify the actual hazard and exposed people.',
                    'Confirm the critical control required for the task.',
                    'Verify the control physically before exposure.',
                    'Monitor the work and surrounding interfaces continuously.',
                    'Stop the affected work if the critical control fails.',
                    'Reassess the condition and authorize restart only after effective controls are restored.',
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E7),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFE8D8A8)),
            ),
            child: const Text(
              'STOP-WORK PRINCIPLE\n'
              'If the actual condition is materially different from the approved method or a critical control is missing or ineffective, stop the affected work, make the area safe and reassess before restart.',
              style: TextStyle(
                color: Color(0xFF4D432A),
                fontSize: 15,
                height: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DubaiHsePart1DeepLearningPage extends StatelessWidget {
  final String topicTitle;
  final String title;
  final List<String> points;

  const DubaiHsePart1DeepLearningPage({
    super.key,
    required this.topicTitle,
    required this.title,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DubaiHsePart1AdvancedLearningPage.background,
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8F3EF),
        foregroundColor: DubaiHsePart1AdvancedLearningPage.dark,
        elevation: 0,
        title: const Text('Practical Decision Guide'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          _HeroCard(
            topicTitle: topicTitle,
            sectionTitle: 'Deep Learning',
            title: title,
            summary:
                'A practical field decision sequence designed to help the user compare planned controls with actual site conditions.',
          ),
          const SizedBox(height: 14),
          ...List.generate(
            points.length,
            (index) => _NumberedCard(
              number: index + 1,
              text: points[index],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final String topicTitle;
  final String sectionTitle;
  final String title;
  final String summary;

  const _HeroCard({
    required this.topicTitle,
    required this.sectionTitle,
    required this.title,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [Color(0xFFE3F4ED), Color(0xFFF9FBFA)],
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            offset: Offset(0, 3),
            color: Color(0x22000000),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ADVANCED HSE LEARNING',
            style: TextStyle(
              color: DubaiHsePart1AdvancedLearningPage.primary,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: .7,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            topicTitle,
            style: const TextStyle(
              color: Color(0xFF557069),
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            sectionTitle,
            style: const TextStyle(
              color: Color(0xFF557069),
              fontSize: 13.5,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            title,
            style: const TextStyle(
              color: DubaiHsePart1AdvancedLearningPage.dark,
              fontSize: 26,
              height: 1.18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            summary,
            style: const TextStyle(
              color: Color(0xFF40514A),
              fontSize: 15.5,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionBlock extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionBlock({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(17, 17, 17, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: DubaiHsePart1AdvancedLearningPage.primary,
                  size: 26,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: DubaiHsePart1AdvancedLearningPage.dark,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 13),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _NumberedCard extends StatelessWidget {
  final int number;
  final String text;

  const _NumberedCard({
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAF9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDDE9E4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFE1F3EC),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                color: DubaiHsePart1AdvancedLearningPage.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF34443E),
                fontSize: 15.2,
                height: 1.52,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdvancedActionTile extends StatelessWidget {
  final String title;
  final String detail;
  final VoidCallback onTap;

  const _AdvancedActionTile({
    required this.title,
    required this.detail,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: const Color(0xFFF4F8F6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFD7E7E0)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(17, 15, 12, 15),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF17332A),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      detail,
                      style: const TextStyle(
                        fontSize: 14.5,
                        height: 1.45,
                        color: Color(0xFF465650),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right_rounded,
                size: 25,
                color: Color(0xFF4D5A55),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
