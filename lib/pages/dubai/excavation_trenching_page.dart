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

class ExcavationTrenchingPage extends StatelessWidget {
  const ExcavationTrenchingPage({super.key});

  static const items = <DubaiDetailItem>[
    DubaiDetailItem(title: 'Open Excavation', subtitle: 'Large/open ground excavation', details: [
      'Purpose: Foundation, civil and infrastructure work.',
      'Controls: Ground assessment, suitable slope/benching/shoring, edge protection, access and inspection.',
    ]),
    DubaiDetailItem(title: 'Trench Excavation', subtitle: 'Narrow/deep excavation', details: [
      'Main risks: Collapse, falls, underground services and water ingress.',
      'Controls: Appropriate protective system, safe access, exclusion zones and competent inspection.',
    ]),
    DubaiDetailItem(title: 'Foundation Excavation', subtitle: 'Excavation for foundations', details: [
      'Focus: Ground stability, nearby structures, access, plant control and edge protection.',
    ]),
    DubaiDetailItem(title: 'Deep Excavation', subtitle: 'Excavation requiring enhanced stability control', details: [
      'Focus: Engineered support, ground movement, adjacent structures, groundwater and monitoring as required.',
    ]),
    DubaiDetailItem(title: 'Utility Excavation', subtitle: 'Excavation around underground services', details: [
      'Critical control: Identify and locate underground cables, pipes and other services before excavation.',
      'Stop work if an unknown or suspected service is encountered.',
    ]),
    DubaiDetailItem(title: 'Shoring', subtitle: 'Structural support to excavation sides', details: [
      'Purpose: Reduces risk of side-wall collapse.',
      'Control: Use the designed/approved system and inspect after changes or events affecting stability.',
    ]),
    DubaiDetailItem(title: 'Trench Box', subtitle: 'Protective trench system', details: [
      'Purpose: Provides a protected working zone in a trench.',
      'Control: Use only as designed and suitable for the excavation conditions.',
    ]),
    DubaiDetailItem(title: 'Benching', subtitle: 'Stepped excavation profile', details: [
      'Purpose: Controls unsupported soil height where suitable.',
      'Control: Configuration must suit ground conditions and project requirements.',
    ]),
    DubaiDetailItem(title: 'Sloping', subtitle: 'Angled excavation sides', details: [
      'Purpose: Changes the side profile to reduce collapse potential where appropriate.',
      'Control: Slope selection must be based on ground conditions and applicable requirements.',
    ]),
    DubaiDetailItem(title: 'Access Ladder / Stair', subtitle: 'Safe entry and exit', details: [
      'Controls: Secure access, suitable landing, clear route and emergency access considerations.',
    ]),
    DubaiDetailItem(title: 'Barricade & Edge Protection', subtitle: 'Controls falls and access', details: [
      'Controls: Secure barriers, visible warning and exclusion of unauthorised persons.',
    ]),
  ];

  static const sections = <DubaiDetailSection>[
    DubaiDetailSection('📏 Technical Requirements', 'Assess ground conditions; select an appropriate protective system; provide safe access/egress; protect edges; control spoil and plant near the excavation; identify underground services; control water; and inspect before entry and after significant changes. Exact dimensions and protective-system requirements must follow applicable Dubai requirements, approved design and competent engineering assessment.'),
    DubaiDetailSection('⚠️ Main Excavation Hazards', 'Cave-in/collapse; falls into excavation; underground electrical or utility strike; falling materials; plant interaction; water accumulation; hazardous atmosphere; poor access; nearby structure movement.'),
    DubaiDetailSection('🛡️ Safety Controls', 'Risk assessment; ground/service investigation; permit or approval where required; suitable shoring/sloping/benching; barricading; safe access; spoil control; plant separation; water management; competent inspection.'),
    DubaiDetailSection('🔍 Inspection', 'Check ground stability, protective system, access, edges, spoil/material position, water, nearby structures, plant controls and changes since the previous inspection.'),
    DubaiDetailSection('🛑 Stop-Work Conditions', 'Collapse signs; damaged/failed protection; unknown underground service; unsafe access; water affecting stability; uncontrolled plant near the edge; cracks or movement; hazardous atmosphere.'),
    DubaiDetailSection('👷 Competent Person Responsibilities', 'Assess excavation conditions; verify protection; inspect access and edges; identify changes; stop unsafe work; record/control corrective actions; verify safe restart.'),
    DubaiDetailSection('👷 Worker Responsibilities', 'Use designated access; stay outside exclusion zones; never remove shoring/protection; do not enter an unsafe excavation; report cracks, movement, water or service concerns immediately.'),
    DubaiDetailSection('🚨 Emergency Response', 'Collapse/service strike: STOP → ALARM → ISOLATE → KEEP PEOPLE OUT → CALL EMERGENCY RESPONSE → FOLLOW RESCUE PLAN → DO NOT ENTER AN UNSTABLE EXCAVATION.'),
    DubaiDetailSection('👷 Practical Site Example', 'Foundation excavation near an underground cable: verify drawings → detect/locate service → establish exclusion zone → controlled excavation → competent supervision → stop and reassess if conditions differ.'),
    DubaiDetailSection('🧠 Quick Learning Formula', 'PLAN → LOCATE → PROTECT → ACCESS → INSPECT → CONTROL → STOP'),
  ];

  @override
  Widget build(BuildContext context) => DubaiTopicPage(
    title: 'Excavation & Trenching — Dubai HSE',
    emoji: '🕳️',
    introduction: 'Excavation is the removal of soil or ground to form trenches, pits, foundations or other openings. Principal risks include collapse, falls, underground services, falling materials, plant interaction, water ingress and hazardous atmospheres.',
    sections: sections,
    tappableItems: items,
  );
}
