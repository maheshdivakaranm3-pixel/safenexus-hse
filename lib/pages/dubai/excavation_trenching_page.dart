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

class ExcavationTrenchingPage extends StatelessWidget {
  const ExcavationTrenchingPage({super.key});

  static const items = <DubaiInteractiveItem>[
    DubaiInteractiveItem(title: 'Open Excavation', subtitle: 'Large/open ground excavation', sections: [
      'Purpose: Foundation, civil and infrastructure work.',
      'Controls: Ground assessment, suitable slope/benching/shoring, edge protection, access and inspection.',
    ]),
    DubaiInteractiveItem(title: 'Trench Excavation', subtitle: 'Narrow excavation for services or construction', sections: [
      'Main risks: Collapse, falls, services and water ingress.',
      'Controls: Protective system, safe access, exclusion zones and competent inspection.',
    ]),
    DubaiInteractiveItem(title: 'Foundation Excavation', subtitle: 'Excavation for foundations', sections: [
      'Focus: Ground stability, nearby structures, access, plant control and protection of excavation edges.',
    ]),
    DubaiInteractiveItem(title: 'Deep Excavation', subtitle: 'Excavation with increased depth and stability considerations', sections: [
      'Focus: Engineered support, ground movement, adjacent structures, groundwater and monitoring as required.',
    ]),
    DubaiInteractiveItem(title: 'Utility Excavation', subtitle: 'Excavation for cables, pipes and services', sections: [
      'Critical control: Identify and locate underground services before breaking ground.',
      'Stop work if an unknown or suspected service is encountered.',
    ]),
    DubaiInteractiveItem(title: 'Shoring', subtitle: 'Structural support to excavation sides', sections: [
      'Purpose: Reduces risk of side-wall collapse.',
      'Control: Use the designed/approved system and inspect after changes or events affecting stability.',
    ]),
    DubaiInteractiveItem(title: 'Trench Box', subtitle: 'Protective system for trench work', sections: [
      'Purpose: Provides a protected working zone within a trench.',
      'Control: Use only as designed and installed for the conditions.',
    ]),
    DubaiInteractiveItem(title: 'Benching', subtitle: 'Stepped excavation profile', sections: [
      'Purpose: Controls unsupported soil height where suitable.',
      'Control: Configuration must be appropriate for soil and project requirements.',
    ]),
    DubaiInteractiveItem(title: 'Sloping', subtitle: 'Angled excavation sides', sections: [
      'Purpose: Reduces collapse potential by changing the side profile.',
      'Control: Slope selection must be based on ground conditions and applicable requirements.',
    ]),
    DubaiInteractiveItem(title: 'Access Ladder / Stair', subtitle: 'Safe entry and exit', sections: [
      'Controls: Secure access, suitable landing, clear route and emergency access considerations.',
    ]),
    DubaiInteractiveItem(title: 'Barricade & Edge Protection', subtitle: 'Prevents falls and controls access', sections: [
      'Controls: Secure barriers, visible warning and exclusion of unauthorised persons.',
    ]),
  ];

  static const sections = <String>[
    '📏 Technical Requirements',
    '⚠️ Main Excavation Hazards',
    '🛡️ Safety Controls',
    '🔍 Inspection',
    '🛑 Stop-Work Conditions',
    '👷 Competent Person Responsibilities',
    '👷 Worker Responsibilities',
    '🚨 Emergency Response',
    '👷 Practical Site Example',
    '🧠 Quick Learning Formula',
  ];

  @override
  Widget build(BuildContext context) => DubaiInteractivePage(
        title: 'Excavation & Trenching — Dubai HSE',
        emoji: '🕳️',
        introduction:
            'Excavation is the process of removing soil or ground to form trenches, pits, foundations or other openings. The principal risks include collapse, falls, underground services, falling materials, plant interaction, water ingress and hazardous atmospheres.',
        items: items,
        sections: sections,
      );
}
