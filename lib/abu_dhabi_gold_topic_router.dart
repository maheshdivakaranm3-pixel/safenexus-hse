import 'package:flutter/material.dart';

import 'data/abu_dhabi_specialist_hse_complete_gold.dart';
import 'data/abu_dhabi_5AJ_part1_interfaces_specialist_plant_gold.dart';
import 'data/abu_dhabi_5AJ_part2_gap_duplicate_cop36_gold.dart';
import 'data/abu_dhabi_5AB_to_5AE_plant_haulage_compaction_gold.dart';
import 'data/abu_dhabi_5AF_to_5AI_paver_trencher_compressor_generator_gold.dart';
import 'data/abu_dhabi_5S_to_5V_mobile_material_handling_gold.dart';
import 'data/abu_dhabi_5W_to_5Z_earthmoving_gold.dart';
import 'data/abu_dhabi_forklift_powered_lift_trucks_gold.dart';
import 'data/abu_dhabi_mewp_gold.dart';
import 'data/abu_dhabi_crane_lifting_book_gold.dart';
import 'models/reference_topic.dart';

/// Step 5AK-A: central Gold Standard router.
///
/// The old Abu Dhabi registry remains the index. This router decides whether
/// a selected topic has a dedicated Gold Standard data source. If it does,
/// the app opens that source instead of the older generic CoP content.
Widget? buildAbuDhabiGoldTopicPage(ReferenceTopic topic) {
  switch (topic.id) {
    case 'ad_cop_29_0':
      return null; // Excavation is handled by AbuDhabiHseTopicPage.
    case 'ad_cop_23_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: workingAtHeightGoldStandardSections,
        regulatory: 'ADPHC CoP 23.0 — Working at Heights — V4.1; effective 27 February 2026.',
      );
    case 'ad_cop_26_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: scaffoldingGoldStandardSections,
        regulatory: 'ADPHC CoP 26.0 — Scaffolding — V4.1; effective 27 February 2026.',
      );
    case 'ad_cop_27_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: confinedSpaceGoldStandardSections,
        regulatory: 'ADPHC CoP 27.0 — Confined Spaces — V4.0; effective 15 July 2024.',
      );
    case 'ad_cop_21_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: permitToWorkGoldStandardSections,
        regulatory: 'ADPHC CoP 21.0 — Permit to Work Systems — V4.0; effective 15 July 2024.',
      );
    case 'ad_cop_11_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: safetyInHeatGoldStandardSections,
        regulatory: 'ADPHC CoP 11.0 — Safety in the Heat — V4.0; effective 15 July 2024.',
      );
    case 'ad_cop_35_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: portablePowerToolsGoldStandardSections,
        regulatory: 'ADPHC CoP 35.0 — Portable Power Tools — V4.1; effective 27 February 2026.',
      );
    case 'ad_cop_40_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: formworkGoldStandardSections,
        regulatory: 'ADPHC CoP 40.0 — False Work (Formwork) — V4.1; effective 27 February 2026.',
      );
    case 'ad_cop_51_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: forkliftPoweredLiftTruckGoldSections,
        regulatory: 'ADPHC CoP 51.0 — Powered Lift Trucks — V4.1; effective 27 February 2026.',
      );
    case 'ad_cop_14_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: abuDhabiFiveNQGoldStandardSections
            .where((section) => section.category == '5P — Manual Handling')
            .toList(),
        regulatory: 'ADPHC CoP 14.0 — Manual Handling and Ergonomics.',
      );
    case 'ad_cop_15_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: abuDhabiFiveNQGoldStandardSections
            .where((section) =>
                section.category == '5N — Electricity on Site & Electrical Tools')
            .toList(),
        regulatory: 'ADPHC CoP 15.0 — Electrical Safety.',
      );
    case 'ad_cop_28_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: abuDhabiFiveNQGoldStandardSections
            .where((section) => section.category == '5Q — Hot Work')
            .toList(),
        regulatory: 'ADPHC CoP 28.0 — Hot Work.',
      );
    case 'ad_cop_34_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: craneLiftingGoldStandardSections,
        regulatory:
            'ADPHC CoP 34.0 — Safe Use of Lifting Equipment and Lifting Accessories.',
      );
    case 'ad_cop_43_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: abuDhabiFiveNQGoldStandardSections
            .where((section) => section.category == '5O — Temporary Works')
            .toList(),
        regulatory: 'ADPHC CoP 43.0 — Temporary Structures.',
      );
    case 'ad_cop_36_0':
      return AbuDhabiPlantEquipmentGoldIndexPage(topic: topic);
    default:
      return null;
  }
}

class _GoldChapter {
  final String title;
  final String subtitle;
  final List<dynamic> sections;

  const _GoldChapter({required this.title, required this.subtitle, required this.sections});
}

class AbuDhabiGoldBookPage extends StatelessWidget {
  final ReferenceTopic topic;
  final List<dynamic> sections;
  final String regulatory;

  const AbuDhabiGoldBookPage({
    super.key,
    required this.topic,
    required this.sections,
    required this.regulatory,
  });

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(topic.shortTitle, overflow: TextOverflow.ellipsis),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(topic.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: darkGreen)),
                const SizedBox(height: 9),
                Text('Gold Standard Field Handbook', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: green)),
                const SizedBox(height: 10),
                Text(topic.description, style: const TextStyle(fontSize: 15, height: 1.5)),
                const SizedBox(height: 12),
                Text(regulatory, style: const TextStyle(fontSize: 14.2, height: 1.45, fontWeight: FontWeight.w800)),
              ]),
            ),
          ),
          const SizedBox(height: 14),
          ...sections.asMap().entries.map((e) => _sectionCard(context, e.key + 1, e.value)),
        ],
      ),
    );
  }

  Widget _sectionCard(BuildContext context, int number, dynamic section) {
    final title = _sectionTitle(section);
    final preview = _sectionPreview(section);
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        leading: CircleAvatar(
          backgroundColor: green.withValues(alpha: 0.12),
          child: Text('$number', style: const TextStyle(fontWeight: FontWeight.w900, color: darkGreen)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900, color: darkGreen)),
        subtitle: preview.isEmpty ? null : Text(preview, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: const Icon(Icons.chevron_right, color: darkGreen),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AbuDhabiGoldSectionPage(title: title, section: section))),
      ),
    );
  }
}

class AbuDhabiGoldSectionPage extends StatelessWidget {
  final String title;
  final dynamic section;

  const AbuDhabiGoldSectionPage({super.key, required this.title, required this.section});

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    final blocks = _sectionBlocks(section);
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(title: Text(title, overflow: TextOverflow.ellipsis), backgroundColor: darkGreen, foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: blocks.asMap().entries.map((entry) {
          final block = entry.value;
          return Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [const Icon(Icons.shield_outlined, color: green), const SizedBox(width: 10), Expanded(child: Text(block.$1, style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w900, color: darkGreen)))]),
                const SizedBox(height: 8),
                ...block.$2.map((p) => Padding(padding: const EdgeInsets.only(bottom: 7), child: Text('• $p', style: const TextStyle(fontSize: 15, height: 1.48)))),
              ]),
            ),
          );
        }).toList(),
      ),
    );
  }
}

String _sectionTitle(dynamic section) {
  try { return section.title as String; } catch (_) { return 'Section'; }
}

String _sectionPreview(dynamic section) {
  try {
    final points = section.points as List;
    if (points.isEmpty) return '';
    final first = points.first;
    try { return (first.detail as String); } catch (_) {}
    try { return (first.content as String); } catch (_) {}
    try { final list = (first.points as List).cast<String>(); return list.isEmpty ? '' : list.first; } catch (_) {}
    return '';
  } catch (_) { return ''; }
}

List<(String, List<String>)> _sectionBlocks(dynamic section) {
  final result = <(String, List<String>)>[];

  // Gold data files intentionally use different point schemas.
  // Read optional fields defensively so a valid section can never crash
  // the page merely because that schema does not contain a field.
  final points = <dynamic>[];
  try {
    final list = section.points as List;
    points.addAll(list);
  } catch (_) {
    try {
      points.add(section.point);
    } catch (_) {}
  }

  for (final point in points) {
    String title = 'Field control';
    try {
      title = point.title as String;
    } catch (_) {}

    final values = <String>[];

    void add(String label, dynamic value) {
      if (value is String && value.trim().isNotEmpty) {
        values.add('$label: $value');
      }
    }

    void addOptional(String label, dynamic Function() getter) {
      try {
        add(label, getter());
      } catch (_) {}
    }

    // Common Gold schemas. Every optional property is guarded because the
    // point classes are strongly typed and do not all expose the same fields.
    addOptional('Detail', () => point.detail);
    addOptional('Content', () => point.content);
    addOptional('Meaning', () => point.meaning);
    addOptional('Hazards', () => point.hazards);
    addOptional('Controls', () => point.controls);
    addOptional('Field check', () => point.fieldCheck);
    addOptional('Common mistake', () => point.commonMistake);
    addOptional('Corrective action', () => point.action);
    addOptional('Records / evidence', () => point.records);

    // Extended field-handbook layer, when present in a source schema.
    addOptional('Field procedure', () => point.fieldProcedure);
    addOptional('Roles & responsibilities', () => point.roles);
    addOptional('Before starting', () => point.preWork);
    addOptional('During work', () => point.duringWork);
    addOptional('Monitoring / verification', () => point.monitoring);
    addOptional('Emergency / rescue', () => point.emergency);
    addOptional('Stop-work condition', () => point.stopWork);
    addOptional('HSE officer checklist', () => point.checklist);
    addOptional('Interview question', () => point.interview);

    // Multi-point schemas such as Safety in the Heat / Power Tools use a
    // List<String> named `points`. Render it directly when available.
    try {
      final list = point.points as List;
      for (final item in list) {
        final text = item.toString().trim();
        if (text.isNotEmpty) values.add(text);
      }
    } catch (_) {}

    if (values.isNotEmpty) {
      result.add((title, values));
    }
  }

  return result;
}

class AbuDhabiPlantEquipmentGoldIndexPage extends StatelessWidget {
  final ReferenceTopic topic;
  const AbuDhabiPlantEquipmentGoldIndexPage({super.key, required this.topic});

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  List<_GoldChapter> get chapters => [
    _GoldChapter(title: '5S–5V — Mobile / Material Handling', subtitle: 'Gold equipment chapters', sections: abuDhabi5STo5VTopics.expand((t) => t.sections).toList()),
    _GoldChapter(title: '5W–5Z — Earthmoving', subtitle: 'Gold equipment chapters', sections: abuDhabi5WTo5ZTopics.expand((t) => t.sections).toList()),
    _GoldChapter(title: '5AB–5AE — Haulage / Compaction', subtitle: 'Gold equipment chapters', sections: abuDhabi5ABTo5AETopics.expand((t) => t.sections).toList()),
    _GoldChapter(title: '5AF–5AI — Paver / Trencher / Compressor / Generator', subtitle: 'Gold equipment chapters', sections: abuDhabi5AFTo5AITopics.expand((t) => t.sections).toList()),
    _GoldChapter(title: 'Crane & Lifting', subtitle: 'Dedicated Gold Standard book', sections: craneLiftingGoldStandardSections),
    _GoldChapter(title: 'MEWP', subtitle: 'Dedicated Gold Standard book', sections: mewpGoldStandardSections),
    _GoldChapter(title: '5AJ Part 1 — Interfaces / Specialist Plant', subtitle: 'Master audit and field interfaces', sections: abuDhabiPlantInterfaceGoldSections),
    _GoldChapter(title: '5AJ Part 2 — Gaps / Duplicate / CoP 36.0', subtitle: 'Master audit and closure', sections: abuDhabiPlantAuditGoldSections),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(title: const Text('Plant & Equipment — Gold Standard'), backgroundColor: darkGreen, foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(topic.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: darkGreen)),
                  const SizedBox(height: 8),
                  const Text('CoP 36.0 • Integrated Gold Standard Plant & Equipment Reference', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: green)),
                  const SizedBox(height: 10),
                  Text(topic.description, style: const TextStyle(fontSize: 15, height: 1.5)),
                  const SizedBox(height: 10),
                  const Text('The registry remains the index; these dedicated books are now the active detailed content layer.', style: TextStyle(fontSize: 14.5, height: 1.45)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          ...chapters.map((chapter) => Card(elevation: 0, margin: const EdgeInsets.only(bottom: 10), child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(backgroundColor: green.withValues(alpha: 0.12), child: const Icon(Icons.precision_manufacturing_outlined, color: darkGreen)),
            title: Text(chapter.title, style: const TextStyle(fontWeight: FontWeight.w900, color: darkGreen)),
            subtitle: Text('${chapter.subtitle} • ${chapter.sections.length} sections'),
            trailing: const Icon(Icons.chevron_right, color: darkGreen),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AbuDhabiGoldBookPage(topic: topic, sections: chapter.sections, regulatory: 'Integrated under ADPHC CoP 36.0 Plant and Equipment; apply the specific related CoP and manufacturer requirements for the equipment/task.'))),
          ))),
        ],
      ),
    );
  }
}
