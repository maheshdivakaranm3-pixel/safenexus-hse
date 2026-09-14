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

class LiftingOperationsPage extends StatelessWidget {
  const LiftingOperationsPage({super.key});

  static const items = <DubaiInteractiveItem>[
    DubaiInteractiveItem(title: 'Mobile Crane', subtitle: 'Crane mounted on a mobile carrier', sections: [
      'Focus: Rated capacity, radius, ground condition, outriggers, lift plan and exclusion zone.',
      'Never exceed the approved configuration or capacity.',
    ]),
    DubaiInteractiveItem(title: 'Tower Crane', subtitle: 'Fixed crane for construction lifting', sections: [
      'Focus: Load/radius limits, lifting accessories, communication, exclusion zone and competent operation.',
    ]),
    DubaiInteractiveItem(title: 'Crawler Crane', subtitle: 'Crawler-mounted crane', sections: [
      'Focus: Ground condition, configuration, load chart, travel/positioning controls and exclusion zones.',
    ]),
    DubaiInteractiveItem(title: 'Truck-Mounted Crane', subtitle: 'Crane installed on a truck', sections: [
      'Focus: Vehicle stability, outriggers, ground bearing, load/radius and safe positioning.',
    ]),
    DubaiInteractiveItem(title: 'Hoist', subtitle: 'Mechanical lifting appliance', sections: [
      'Focus: Rated capacity, anchorage/support, hook and lifting mechanism condition, inspection and safe operation.',
    ]),
    DubaiInteractiveItem(title: 'Web Sling', subtitle: 'Flexible lifting accessory', sections: [
      'Checks: Identification/WLL, cuts, abrasion, heat/chemical damage, stitching and correct configuration.',
      'Never use a damaged or unidentified sling.',
    ]),
    DubaiInteractiveItem(title: 'Wire Rope Sling', subtitle: 'Wire-rope lifting accessory', sections: [
      'Checks: Rope condition, end fittings, deformation, corrosion, broken wires and identification.',
    ]),
    DubaiInteractiveItem(title: 'Shackle', subtitle: 'Connector for lifting arrangements', sections: [
      'Checks: WLL/identification, body, pin, deformation, cracks and correct loading direction.',
    ]),
    DubaiInteractiveItem(title: 'Spreader Beam', subtitle: 'Beam used to distribute lifting forces', sections: [
      'Focus: Approved design, rated capacity, lifting points, inspection and correct load distribution.',
    ]),
    DubaiInteractiveItem(title: 'Tag Line', subtitle: 'Line used to control load movement', sections: [
      'Purpose: Helps control rotation and positioning from a safe location.',
      'Never wrap a tag line around the body or place yourself in a crush zone.',
    ]),
    DubaiInteractiveItem(title: 'Banksman / Signalman', subtitle: 'Controls and communicates crane movement', sections: [
      'Focus: Clear agreed signals, line of sight/communication, exclusion zone and stopping the lift when unsafe.',
    ]),
  ];

  static const sections = <String>[
    '📏 Technical Requirements',
    '⚠️ Main Lifting Hazards',
    '🛡️ Safety Controls',
    '🔍 Pre-Lift Inspection',
    '🪝 Lifting Accessories',
    '🛑 Stop-Work Conditions',
    '👷 Lifting Team Responsibilities',
    '🚨 Emergency Response',
    '👷 Practical Site Example',
    '🧠 Quick Learning Formula',
  ];

  @override
  Widget build(BuildContext context) => DubaiInteractivePage(
        title: 'Lifting Operations — Dubai HSE',
        emoji: '🏗️',
        introduction:
            'A lifting operation involves planning, preparing, lifting, moving and lowering a load using a crane, hoist or other lifting appliance. Safe lifting depends on competent people, suitable equipment, verified load information, planned movement and controlled exclusion zones.',
        items: items,
        sections: sections,
      );
}
