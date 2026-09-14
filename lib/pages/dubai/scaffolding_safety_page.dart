import 'package:flutter/material.dart';

class DubaiInteractiveItem {
  final String title;
  final String subtitle;
  final List<String> sections;

  const DubaiInteractiveItem({
    required this.title,
    required this.subtitle,
    required this.sections,
  });
}

class DubaiInteractivePage extends StatelessWidget {
  final String title;
  final String emoji;
  final String introduction;
  final List<DubaiInteractiveItem> items;
  final List<String> sections;

  const DubaiInteractivePage({
    super.key,
    required this.title,
    required this.emoji,
    required this.introduction,
    required this.items,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _introCard(),
          const SizedBox(height: 12),
          ...sections.map(_sectionCard),
          if (items.isNotEmpty) ...[
            const SizedBox(height: 4),
            _interactiveHeader(),
            ...items.map((item) => _itemTile(context, item)),
          ],
        ],
      ),
    );
  }

  Widget _introCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$emoji  Introduction',
                  style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(introduction, style: const TextStyle(fontSize: 15, height: 1.45)),
            ],
          ),
        ),
      );

  Widget _interactiveHeader() => const Padding(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: Text('🔎 Tap to explore',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
      );

  Widget _sectionCard(String text) => Card(
        child: ExpansionTile(
          title: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                'Open this section to review the topic-specific controls and field checks.',
                style: TextStyle(height: 1.4),
              ),
            ),
          ],
        ),
      );

  Widget _itemTile(BuildContext context, DubaiInteractiveItem item) => Card(
        child: ListTile(
          title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(item.subtitle),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DubaiItemDetailPage(item: item),
            ),
          ),
        ),
      );
}

class DubaiItemDetailPage extends StatelessWidget {
  final DubaiInteractiveItem item;

  const DubaiItemDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(item.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(item.subtitle, style: const TextStyle(fontSize: 15)),
          const SizedBox(height: 16),
          ...item.sections.map((section) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(section,
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

  static const types = <DubaiInteractiveItem>[
    DubaiInteractiveItem(title: 'Fixed / Static Scaffold', subtitle: 'Ground-supported temporary scaffold', sections: [
      'Purpose: Provides stable access and working platforms for construction, façade and maintenance work.',
      'Key controls: Stable foundation, correct erection sequence, required bracing and ties, safe access and inspection before use.',
      'Main hazards: Collapse, falls, falling objects, overloading and unauthorised alteration.',
    ]),
    DubaiInteractiveItem(title: 'Independent Scaffold', subtitle: 'Self-supporting scaffold framework', sections: [
      'Purpose: Uses its own framework to support working platforms.',
      'Key controls: Correct base arrangement, bracing, ties where required by design and suitable loading.',
      'Inspection focus: Standards, ledgers, transoms, braces, platforms, access and stability.',
    ]),
    DubaiInteractiveItem(title: 'Tied Scaffold', subtitle: 'Scaffold connected to a supporting structure', sections: [
      'Purpose: Ties provide stability against movement and overturning.',
      'Critical rule: Required ties must not be removed casually. Any alteration must be assessed and controlled.',
      'Stop work: Missing or damaged critical ties, visible instability or unsafe modification.',
    ]),
    DubaiInteractiveItem(title: 'Mobile Scaffold', subtitle: 'Scaffold mounted on castors/wheels', sections: [
      'Purpose: Allows approved movement between work locations.',
      'Controls: Castors locked during use, stable surface, safe access, suitable stability and no movement while workers are on the scaffold.',
      'Stop work: Unlocked wheels, unstable surface, damaged components or unsafe movement.',
    ]),
    DubaiInteractiveItem(title: 'Tower Scaffold', subtitle: 'Vertical scaffold arrangement for elevated work', sections: [
      'Controls: Stable base, complete bracing, safe internal/external access and edge protection.',
      'Use: Suitable only for the configuration, height and loading for which it was designed.',
    ]),
    DubaiInteractiveItem(title: 'Access Scaffold', subtitle: 'Primarily designed for safe access', sections: [
      'Focus: Safe route, landing points, handrails, suitable platforms and unobstructed access.',
      'Housekeeping: Keep access routes clear and dry.',
    ]),
    DubaiInteractiveItem(title: 'Birdcage Scaffold', subtitle: 'Multi-level framework for larger working areas', sections: [
      'Focus: Overall stability, internal access, platform protection and control of imposed loads.',
      'Use: Configuration must match the planned work and design.',
    ]),
    DubaiInteractiveItem(title: 'Suspended Scaffold', subtitle: 'Platform suspended from an overhead support system', sections: [
      'Focus: Suspension system, supporting structure, secondary protection, controls against unintended movement and inspection.',
      'Only use equipment within its designed capacity and approved configuration.',
    ]),
    DubaiInteractiveItem(title: 'Cantilever Scaffold', subtitle: 'Scaffold supported from a structure rather than directly from ground', sections: [
      'Focus: Structural support, anchorage, design verification, stability and controlled loading.',
      'Never improvise support arrangements.',
    ]),
    DubaiInteractiveItem(title: 'System Scaffold', subtitle: 'Prefabricated modular scaffold system', sections: [
      'Focus: Correct components, approved connections, manufacturer/system instructions and designed configuration.',
      'Do not mix incompatible components unless specifically approved.',
    ]),
    DubaiInteractiveItem(title: 'Tube & Fitting Scaffold', subtitle: 'Tube-and-coupler construction', sections: [
      'Focus: Correct tube condition, couplers, spacing, bracing, ties, platforms and access.',
      'Connections must be correctly installed and maintained.',
    ]),
    DubaiInteractiveItem(title: 'Special-Purpose Scaffold', subtitle: 'Designed for a specific work requirement', sections: [
      'Use when a standard arrangement is not suitable.',
      'Focus: Specific design, loading, support, stability, access and competent control.',
    ]),
  ];

  static const components = <DubaiInteractiveItem>[
    DubaiInteractiveItem(title: 'Standard (Vertical Member)', subtitle: 'Main vertical load-bearing member', sections: [
      'Function: Transfers vertical loads through the scaffold framework to the supporting base.',
      'Checks: Correct position, vertical alignment, sound condition and proper connection.',
      'Hazard: Settlement, instability or incorrect loading can compromise the scaffold.',
    ]),
    DubaiInteractiveItem(title: 'Ledger', subtitle: 'Longitudinal horizontal member', sections: [
      'Function: Connects standards and contributes to the scaffold framework and stability.',
      'Checks: Correct connections, level/alignment and undamaged components.',
    ]),
    DubaiInteractiveItem(title: 'Transom', subtitle: 'Cross member supporting the platform', sections: [
      'Function: Supports platform components and ties the scaffold across its width.',
      'Checks: Correct seating, condition and configuration.',
    ]),
    DubaiInteractiveItem(title: 'Base Plate', subtitle: 'Load-distribution plate at a standard base', sections: [
      'Function: Provides a suitable interface between the standard and supporting arrangement.',
      'Checks: Correct placement, condition and adequate supporting surface.',
    ]),
    DubaiInteractiveItem(title: 'Sole Board', subtitle: 'Load-distribution support beneath base arrangement', sections: [
      'Function: Helps distribute loads where required by the scaffold design and ground condition.',
      'Checks: Sound support, level placement and no unstable improvised packing.',
    ]),
    DubaiInteractiveItem(title: 'Brace', subtitle: 'Provides stiffness and stability', sections: [
      'Function: Resists movement and improves structural stability.',
      'Critical rule: Never remove required bracing without competent assessment and control.',
    ]),
    DubaiInteractiveItem(title: 'Tie', subtitle: 'Connects scaffold to supporting structure', sections: [
      'Function: Provides required stability against movement.',
      'Critical rule: Required ties must remain in place unless an approved controlled alteration is implemented.',
    ]),
    DubaiInteractiveItem(title: 'Coupler', subtitle: 'Connects tubes/components', sections: [
      'Function: Provides structural connections in tube-and-fitting systems.',
      'Checks: Correct type, condition, installation and secure connection.',
    ]),
    DubaiInteractiveItem(title: 'Platform', subtitle: 'Working surface', sections: [
      'Function: Provides a safe working area.',
      'Checks: Secure support, suitable duty/load, no dangerous gaps, sound condition and good housekeeping.',
    ]),
    DubaiInteractiveItem(title: 'Guardrail / Handrail', subtitle: 'Primary edge protection', sections: [
      'Function: Reduces the risk of falls from exposed edges.',
      'Checks: Secure fixing, suitable arrangement and no unprotected working edge.',
    ]),
    DubaiInteractiveItem(title: 'Intermediate Rail', subtitle: 'Additional edge protection', sections: [
      'Function: Reduces open-edge exposure between platform and upper protection.',
      'Checks: Secure installation and complete edge protection arrangement.',
    ]),
    DubaiInteractiveItem(title: 'Toe Board', subtitle: 'Helps prevent falls of people/materials from platform edges', sections: [
      'Function: Provides low-level edge protection and helps retain tools/materials.',
      'Checks: Secure, continuous where required and suitable for the platform arrangement.',
    ]),
    DubaiInteractiveItem(title: 'Access Ladder', subtitle: 'Controlled access to platforms', sections: [
      'Function: Provides a safe route between levels.',
      'Checks: Secure installation, suitable landing access and unobstructed route.',
    ]),
    DubaiInteractiveItem(title: 'Scaffold Stair', subtitle: 'Stair-type scaffold access', sections: [
      'Function: Provides easier movement between levels where designed.',
      'Checks: Handrails, landings, treads, housekeeping and safe access.',
    ]),
    DubaiInteractiveItem(title: 'Castor / Wheel', subtitle: 'Allows approved mobile scaffold movement', sections: [
      'Function: Enables controlled movement of a mobile scaffold.',
      'Checks: Condition, locking arrangement and suitability for the system.',
    ]),
    DubaiInteractiveItem(title: 'Base Jack', subtitle: 'Controlled adjustment/support component', sections: [
      'Function: Provides designed adjustment/support at the base.',
      'Checks: Correct installation, load path and no excessive/unapproved adjustment.',
    ]),
    DubaiInteractiveItem(title: 'Scaffold Tag', subtitle: 'Communicates inspection/status', sections: [
      'Function: Communicates the site inspection/status system.',
      'Critical rule: A tag does not replace visual checks or reporting of defects.',
    ]),
  ];

  static const sections = <String>[
    '📏 3. Technical Requirements',
    '⚠️ 4. Main Scaffolding Hazards',
    '🔧 5. Erection & Dismantling',
    '🔍 6. Inspection',
    '🏷️ 7. Scaffold Tagging',
    '🔄 8. Modification & Control',
    '🛑 9. Stop-Work Conditions',
    '👷 10. Competent Person Responsibilities',
    '👷 11. Worker Responsibilities',
    '🚨 12. Emergency Response',
    '👷 13. Practical Site Example',
    '🧠 14. Quick Learning Formula',
  ];

  @override
  Widget build(BuildContext context) => DubaiInteractivePage(
        title: 'Scaffolding Safety — Dubai HSE',
        emoji: '🏗️',
        introduction:
            'Scaffolding is a temporary structure used to provide safe access, working platforms and fall protection for construction, maintenance, inspection and other work-at-height activities. It must be planned, erected by competent persons, inspected, maintained and safely dismantled.',
        items: [...types, ...components],
        sections: sections,
      );
}
