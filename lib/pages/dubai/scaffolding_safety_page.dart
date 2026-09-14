import 'package:flutter/material.dart';

class DubaiDetailItem {
  final String title;
  final String subtitle;
  final List<String> details;
  const DubaiDetailItem({
    required this.title,
    required this.subtitle,
    required this.details,
  });
}

class DubaiDetailSection {
  final String title;
  final String body;
  const DubaiDetailSection(this.title, this.body);
}

class DubaiTopicPage extends StatelessWidget {
  final String title;
  final String emoji;
  final String introduction;
  final List<DubaiDetailSection> sections;
  final List<DubaiDetailItem> tappableItems;

  const DubaiTopicPage({
    super.key,
    required this.title,
    required this.emoji,
    required this.introduction,
    required this.sections,
    required this.tappableItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _card(
            '$emoji  Introduction — What is it?',
            introduction,
          ),
          const SizedBox(height: 10),
          ...sections.map((s) => _expandable(s)),
          if (tappableItems.isNotEmpty) ...[
            const SizedBox(height: 10),
            const Text(
              '🔎 Tap to explore',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            ...tappableItems.map((item) => Card(
                  child: ListTile(
                    title: Text(item.title,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(item.subtitle),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DubaiItemPage(item: item),
                      ),
                    ),
                  ),
                )),
          ],
        ],
      ),
    );
  }

  Widget _card(String heading, String body) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(heading,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(body, style: const TextStyle(fontSize: 15, height: 1.45)),
            ],
          ),
        ),
      );

  Widget _expandable(DubaiDetailSection section) => Card(
        child: ExpansionTile(
          title: Text(section.title,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(section.body,
                  style: const TextStyle(fontSize: 15, height: 1.45)),
            ),
          ],
        ),
      );
}

class DubaiItemPage extends StatelessWidget {
  final DubaiDetailItem item;
  const DubaiItemPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(item.title,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(item.subtitle),
          const SizedBox(height: 14),
          ...item.details.map((d) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(d,
                      style: const TextStyle(fontSize: 15, height: 1.5)),
                ),
              )),
        ],
      ),
    );
  }
}

class ScaffoldingSafetyPage extends StatelessWidget {
  const ScaffoldingSafetyPage({super.key});

  static const types = <DubaiDetailItem>[
    DubaiDetailItem(title: 'Fixed / Static Scaffold', subtitle: 'Ground-supported temporary scaffold', details: [
      'What: A scaffold erected in a fixed position to provide access and working platforms.',
      'Uses: Building construction, façade work, maintenance and inspection.',
      'Controls: Stable foundation, correct erection sequence, bracing, ties where required, safe access and inspection.',
      'Hazards: Falls, collapse, falling objects and overloading.',
    ]),
    DubaiDetailItem(title: 'Independent Scaffold', subtitle: 'Self-supporting scaffold framework', details: [
      'What: A scaffold with its own supporting framework.',
      'Controls: Correct base arrangement, framework stability, bracing, access and designed loading.',
    ]),
    DubaiDetailItem(title: 'Tied Scaffold', subtitle: 'Scaffold connected to a supporting structure', details: [
      'Purpose: Ties provide stability and help control movement.',
      'Critical control: Required ties must not be removed or altered without competent assessment and an approved control arrangement.',
    ]),
    DubaiDetailItem(title: 'Mobile Scaffold', subtitle: 'Scaffold mounted on wheels/castors', details: [
      'What: A scaffold designed for controlled movement between approved work locations.',
      'Controls: Castors locked during use; stable level surface; safe access; suitable configuration; never move with workers on the scaffold.',
      'Stop work: Unlocked wheels, unstable surface, damaged structure or unsafe movement.',
    ]),
    DubaiDetailItem(title: 'Tower Scaffold', subtitle: 'Vertical scaffold arrangement', details: [
      'Purpose: Elevated access and work from a tower configuration.',
      'Controls: Stable base, complete bracing, safe access, edge protection and configuration suitable for its designed height and loading.',
    ]),
    DubaiDetailItem(title: 'Access Scaffold', subtitle: 'Primarily designed for access', details: [
      'Focus: Safe access route, landings, handrails, platforms and housekeeping.',
    ]),
    DubaiDetailItem(title: 'Birdcage Scaffold', subtitle: 'Multi-level working framework', details: [
      'Focus: Overall stability, internal access, platform protection and control of imposed loads.',
    ]),
    DubaiDetailItem(title: 'Suspended Scaffold', subtitle: 'Platform suspended from overhead support', details: [
      'Focus: Suspension system, supporting structure, secondary protection, safe movement controls and inspection.',
    ]),
    DubaiDetailItem(title: 'Cantilever Scaffold', subtitle: 'Supported from a structure rather than ground', details: [
      'Focus: Structural support, anchorage, design verification, stability and controlled loading.',
      'Rule: Never improvise support arrangements.',
    ]),
    DubaiDetailItem(title: 'System Scaffold', subtitle: 'Prefabricated modular system', details: [
      'Focus: Correct compatible components, approved connections, system instructions and designed configuration.',
    ]),
    DubaiDetailItem(title: 'Tube & Fitting Scaffold', subtitle: 'Tubes joined with couplers/fittings', details: [
      'Focus: Tube condition, couplers, bracing, ties, platforms and safe access.',
    ]),
    DubaiDetailItem(title: 'Special-Purpose Scaffold', subtitle: 'Designed for a specific requirement', details: [
      'Use: Where a standard arrangement is not suitable.',
      'Focus: Specific design, support, loading, stability, access and competent control.',
    ]),
  ];

  static const components = <DubaiDetailItem>[
    DubaiDetailItem(title: 'Standard (Vertical Member)', subtitle: 'Main vertical load-bearing member', details: [
      'Function: Transfers vertical loads through the scaffold framework to the base.',
      'Checks: Position, vertical alignment, condition, connections and base support.',
    ]),
    DubaiDetailItem(title: 'Ledger', subtitle: 'Longitudinal horizontal member', details: [
      'Function: Connects standards and contributes to the scaffold framework.',
      'Checks: Correct connections, level/alignment and component condition.',
    ]),
    DubaiDetailItem(title: 'Transom', subtitle: 'Cross member supporting the platform', details: [
      'Function: Supports platform components and connects the scaffold across its width.',
      'Checks: Correct seating, condition and configuration.',
    ]),
    DubaiDetailItem(title: 'Base Plate', subtitle: 'Base load-distribution component', details: [
      'Function: Provides a suitable interface between the standard and base arrangement.',
      'Checks: Correct placement, condition and supporting surface.',
    ]),
    DubaiDetailItem(title: 'Sole Board', subtitle: 'Ground/load-distribution support', details: [
      'Function: Helps distribute loads where required by the design and ground condition.',
      'Rule: Do not use unstable improvised packing.',
    ]),
    DubaiDetailItem(title: 'Brace', subtitle: 'Stiffness and stability member', details: [
      'Function: Resists movement and contributes to stability.',
      'Rule: Never remove required bracing without competent assessment and control.',
    ]),
    DubaiDetailItem(title: 'Tie', subtitle: 'Connection to supporting structure', details: [
      'Function: Provides stability against movement.',
      'Rule: Required ties must remain controlled as part of the approved arrangement.',
    ]),
    DubaiDetailItem(title: 'Coupler', subtitle: 'Tube/component connector', details: [
      'Function: Connects tubes/components in tube-and-fitting systems.',
      'Checks: Correct type, condition, installation and secure connection.',
    ]),
    DubaiDetailItem(title: 'Platform', subtitle: 'Working surface', details: [
      'Function: Provides a safe working area.',
      'Checks: Support, secure positioning, suitable duty/load, sound condition, housekeeping and no dangerous gaps.',
    ]),
    DubaiDetailItem(title: 'Guardrail / Handrail', subtitle: 'Edge protection', details: [
      'Function: Reduces fall risk at exposed platform edges.',
      'Checks: Secure fixing, suitable arrangement and no unprotected working edge.',
    ]),
    DubaiDetailItem(title: 'Intermediate Rail', subtitle: 'Additional edge protection', details: [
      'Function: Reduces open-edge exposure between platform and upper protection.',
      'Checks: Secure and complete edge protection arrangement.',
    ]),
    DubaiDetailItem(title: 'Toe Board', subtitle: 'Low-level edge protection', details: [
      'Function: Helps prevent people and materials falling from platform edges.',
      'Checks: Secure installation and suitable arrangement for the platform.',
    ]),
    DubaiDetailItem(title: 'Access Ladder', subtitle: 'Controlled access between levels', details: [
      'Function: Provides a safe route to platforms.',
      'Checks: Secure installation, suitable landing and clear access.',
    ]),
    DubaiDetailItem(title: 'Scaffold Stair', subtitle: 'Stair-type access', details: [
      'Function: Provides stair-type movement between levels where designed.',
      'Checks: Handrails, treads, landings, housekeeping and safe access.',
    ]),
    DubaiDetailItem(title: 'Castor / Wheel', subtitle: 'Mobile scaffold movement component', details: [
      'Function: Enables controlled movement of mobile scaffolds.',
      'Checks: Condition, locking mechanism and compatibility with the system.',
    ]),
    DubaiDetailItem(title: 'Base Jack', subtitle: 'Designed base adjustment/support', details: [
      'Function: Provides controlled adjustment/support where designed.',
      'Checks: Correct installation, load path and approved adjustment range.',
    ]),
    DubaiDetailItem(title: 'Scaffold Tag', subtitle: 'Inspection/status communication', details: [
      'Function: Communicates the site inspection/status system.',
      'Rule: A tag does not replace visual checks or reporting of defects.',
    ]),
  ];

  static const sections = <DubaiDetailSection>[
    DubaiDetailSection('📏 3. Technical Requirements',
        'Platform: properly supported, secure, suitable for intended duty/load and free from dangerous gaps. Guardrails: suitable edge protection, secure fixing and no unprotected working edge. Toe boards: installed and secured where required. Foundation: stable support and proper load distribution. Bracing and ties: installed and maintained according to the approved design/system. Loading: never exceed designed capacity and avoid concentrated loads. Exact dimensions or load values must follow the applicable Dubai requirement, approved scaffold design and manufacturer/system instructions.'),
    DubaiDetailSection('⚠️ 4. Main Scaffolding Hazards',
        'Falls from height; scaffold collapse; falling tools/materials; overloading; unstable foundation; missing bracing or ties; unsafe access; damaged platforms; unauthorised modification; mobile scaffold movement; adverse weather.'),
    DubaiDetailSection('🔧 5. Erection & Dismantling',
        'Safe sequence: PLAN → ASSESS → EXCLUDE → ERECT PROGRESSIVELY → MAINTAIN STABILITY → INSTALL PROTECTION → INSPECT → TAG → USE. Dismantling must be planned, the area isolated, falling objects controlled, stability maintained and components removed progressively and safely.'),
    DubaiDetailSection('🔍 6. Inspection',
        'Check foundation, base plates, standards, ledgers, transoms, bracing, ties, platforms, guardrails, toe boards, access, loading, damage, unauthorised modifications and inspection/status information. Re-inspect after changes or events that may affect stability.'),
    DubaiDetailSection('🏷️ 7. Scaffold Tagging',
        'Use the site tagging/status system to communicate inspection and authorised-use status. Never rely on the tag alone; workers must report visible defects and unsafe conditions.'),
    DubaiDetailSection('🔄 8. Modification & Control',
        'Workers must not independently remove guardrails, ties or braces, alter platforms, add unauthorised loading or change scaffold configuration. Modifications must be assessed and controlled by competent personnel.'),
    DubaiDetailSection('🛑 9. Stop-Work Conditions',
        'Stop immediately for instability, critical missing edge protection, deteriorated foundation, missing required ties/bracing, damaged platform, overloading, unsafe access, unauthorised modification or weather conditions that compromise safety.'),
    DubaiDetailSection('👷 10. Competent Person Responsibilities',
        'Plan scaffold activities within competency; control erection/dismantling; inspect; identify defects; control modifications; verify stability; recommend corrective action; prevent unauthorised use.'),
    DubaiDetailSection('👷 11. Worker Responsibilities',
        'Use only approved scaffolds; follow site instructions; report unsafe conditions; never remove scaffold components; never exceed loading limits; maintain housekeeping; use safe access; follow work-at-height requirements.'),
    DubaiDetailSection('🚨 12. Emergency Response',
        'Scaffold collapse/instability/fall: STOP → ALARM → EXCLUDE → DO NOT ENTER AN UNSTABLE AREA → FOLLOW EMERGENCY/RESCUE PLAN → FIRST AID WITHIN COMPETENCE → REPORT & INVESTIGATE.'),
    DubaiDetailSection('👷 13. Practical Site Example',
        'Situation: A façade team is using a tied scaffold and one required tie has been removed. HSE response: STOP WORK → isolate affected area → competent-person stability assessment → restore/control the approved tie arrangement → re-inspect → confirm status → resume only after verification.'),
    DubaiDetailSection('🧠 14. Quick Learning Formula',
        'BASE → FRAME → BRACE → TIE → PLATFORM → GUARDRAIL → ACCESS → LOAD → INSPECT → TAG → USE'),
  ];

  @override
  Widget build(BuildContext context) => DubaiTopicPage(
        title: 'Scaffolding Safety — Dubai HSE',
        emoji: '🏗️',
        introduction: 'Scaffolding is a temporary structure used to provide safe access, working platforms and fall protection for construction, maintenance, inspection and other work-at-height activities. A scaffold must be properly planned, suitable for its intended purpose, erected by competent persons, inspected, maintained and safely dismantled.',
        sections: sections,
        tappableItems: [...types, ...components],
      );
}
