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
      return ScaffoldingGoldPilotPage(
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


/// Locked pilot implementation for CoP 26.0 Scaffolding.
///
/// Navigation:
/// Subject introduction -> 38 chapter points -> point detail ->
/// tappable sub-points -> sub-point detail.
///
/// The existing Gold data remains the source of the content. This UI layer
/// does not invent regulatory values or replace the underlying CoP data.
class ScaffoldingGoldPilotPage extends StatelessWidget {
  final ReferenceTopic topic;
  final List<ScaffoldingGoldSection> sections;
  final String regulatory;

  const ScaffoldingGoldPilotPage({
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
        title: const Text('Scaffolding'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
        children: [
          _introCard(),
          const SizedBox(height: 14),
          const Text(
            'Complete Field Handbook',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${sections.length} structured chapters • Tap any chapter to open the detailed field page.',
            style: const TextStyle(fontSize: 14.5, height: 1.45),
          ),
          const SizedBox(height: 12),
          ...sections.asMap().entries.map(
            (entry) => _chapterCard(context, entry.key + 1, entry.value),
          ),
        ],
      ),
    );
  }

  Widget _introCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ABU DHABI HSE • GOLD STANDARD',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w900,
                color: green,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              topic.title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 9),
            const Text(
              'Scaffolding is a temporary access and working-platform system. '
              'Safe use depends on suitable selection, competent erection and '
              'alteration, inspection, stability, safe access, fall protection, '
              'load control and effective management of interfaces and changes.',
              style: TextStyle(fontSize: 15, height: 1.55),
            ),
            const SizedBox(height: 14),
            const Text(
              'Main Hazards',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 7),
            ...const [
              'Falls from height',
              'Scaffold instability or collapse',
              'Falling objects and materials',
              'Unsafe access and egress',
              'Overloading',
              'Unsafe erection or alteration',
              'Electrical interface',
              'Weather and wind exposure',
              'Poor foundation or ground condition',
            ].map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(fontWeight: FontWeight.w900)),
                    Expanded(child: Text(item)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              regulatory,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.45,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chapterCard(
    BuildContext context,
    int index,
    ScaffoldingGoldSection section,
  ) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        leading: CircleAvatar(
          backgroundColor: green.withValues(alpha: 0.12),
          child: Text(
            '$index',
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: darkGreen,
            ),
          ),
        ),
        title: Text(
          section.title,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            color: darkGreen,
          ),
        ),
        subtitle: Text(
          section.introduction,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right, color: darkGreen),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ScaffoldingChapterDetailPage(
              chapterNumber: index,
              section: section,
            ),
          ),
        ),
      ),
    );
  }
}

class ScaffoldingChapterDetailPage extends StatelessWidget {
  final int chapterNumber;
  final ScaffoldingGoldSection section;

  const ScaffoldingChapterDetailPage({
    super.key,
    required this.chapterNumber,
    required this.section,
  });

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    final p = section.point;

    final subPoints = <_ScaffoldingSubPoint>[
      _ScaffoldingSubPoint('Meaning / What this means', p.meaning),
      _ScaffoldingSubPoint('Hazards / Consequences', p.hazards),
      _ScaffoldingSubPoint('Control Measures', p.controls),
      _ScaffoldingSubPoint('HSE Officer Field Check', p.fieldCheck),
      _ScaffoldingSubPoint('Common Mistake', p.commonMistake),
      _ScaffoldingSubPoint('Corrective Action', p.action),
      _ScaffoldingSubPoint('Records / Evidence', p.records),
    ].where((item) => item.detail.trim().isNotEmpty).toList();

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          section.title,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CHAPTER $chapterNumber • ${section.number}',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w900,
                      color: green,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    section.title,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    section.introduction,
                    style: const TextStyle(fontSize: 15, height: 1.55),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Clause: ${p.clause}',
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Detailed Field Controls',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w900,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Tap each item to open its full explanation.',
            style: TextStyle(fontSize: 14.5),
          ),
          const SizedBox(height: 12),
          ...subPoints.asMap().entries.map(
            (entry) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 9,
                ),
                leading: CircleAvatar(
                  backgroundColor: green.withValues(alpha: 0.12),
                  child: Text(
                    '${entry.key + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: darkGreen,
                    ),
                  ),
                ),
                title: Text(
                  entry.value.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: darkGreen,
                  ),
                ),
                subtitle: Text(
                  entry.value.detail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: darkGreen,
                ),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ScaffoldingSubPointDetailPage(
                      chapterTitle: section.title,
                      point: entry.value,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScaffoldingSubPoint {
  final String title;
  final String detail;

  const _ScaffoldingSubPoint(this.title, this.detail);
}

class ScaffoldingSubPointDetailPage extends StatelessWidget {
  final String chapterTitle;
  final _ScaffoldingSubPoint point;

  const ScaffoldingSubPointDetailPage({
    super.key,
    required this.chapterTitle,
    required this.point,
  });

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          point.title,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SCAFFOLDING • FIELD DETAIL',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w900,
                      color: green,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    chapterTitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    point.title,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    point.detail,
                    style: const TextStyle(fontSize: 16, height: 1.6),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.verified_user_outlined, color: green),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Field use: apply the current approved CoP, risk assessment, method statement, competent-person requirements, manufacturer instructions and project controls applicable to the task.',
                      style: TextStyle(fontSize: 14.5, height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
    final points = _sectionPoints(section);
    final sectionIntro = _readString(section, 'introduction');
    final category = _readString(section, 'category');
    final number = _readString(section, 'number');

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(title, overflow: TextOverflow.ellipsis),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (number.isNotEmpty)
                    Text(number, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: green)),
                  if (category.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(category, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: darkGreen)),
                  ],
                  const SizedBox(height: 8),
                  Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: darkGreen)),
                  if (sectionIntro.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(sectionIntro, style: const TextStyle(fontSize: 15, height: 1.5)),
                  ],
                  const SizedBox(height: 12),
                  Text(
                    '${points.length} detailed point${points.length == 1 ? '' : 's'} • Tap any point to open the full field explanation.',
                    style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...points.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final point = entry.value;
            final pointTitle = _readString(point, 'title').isEmpty
                ? 'Field Point $index'
                : _readString(point, 'title');
            final preview = _pointPreview(point);

            return Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                leading: CircleAvatar(
                  backgroundColor: green.withValues(alpha: 0.12),
                  child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w900, color: darkGreen)),
                ),
                title: Text(pointTitle, style: const TextStyle(fontWeight: FontWeight.w900, color: darkGreen)),
                subtitle: preview.isEmpty
                    ? const Text('Open detailed field explanation')
                    : Text(preview, maxLines: 2, overflow: TextOverflow.ellipsis),
                trailing: const Icon(Icons.chevron_right, color: darkGreen),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AbuDhabiGoldPointDetailPage(
                      title: pointTitle,
                      point: point,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class AbuDhabiGoldPointDetailPage extends StatelessWidget {
  final String title;
  final dynamic point;

  const AbuDhabiGoldPointDetailPage({super.key, required this.title, required this.point});

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    final fields = _pointFields(point);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(title, overflow: TextOverflow.ellipsis),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('GOLD STANDARD FIELD EXPLANATION', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w900, color: green)),
                  const SizedBox(height: 7),
                  Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: darkGreen)),
                  const SizedBox(height: 8),
                  const Text(
                    'Use this page as the field-level explanation. Check the applicable controlled CoP, approved method statement, risk assessment, manufacturer instructions and project requirements before execution.',
                    style: TextStyle(fontSize: 14.5, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...fields.map((field) => Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.shield_outlined, color: green),
                          const SizedBox(width: 10),
                          Expanded(child: Text(field.$1, style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w900, color: darkGreen))),
                        ],
                      ),
                      const SizedBox(height: 9),
                      Text(field.$2, style: const TextStyle(fontSize: 15, height: 1.55)),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

String _readString(dynamic object, String field) {
  try {
    final value = switch (field) {
      'title' => object.title,
      'detail' => object.detail,
      'content' => object.content,
      'meaning' => object.meaning,
      'hazards' => object.hazards,
      'controls' => object.controls,
      'fieldCheck' => object.fieldCheck,
      'commonMistake' => object.commonMistake,
      'action' => object.action,
      'records' => object.records,
      'fieldProcedure' => object.fieldProcedure,
      'roles' => object.roles,
      'preWork' => object.preWork,
      'duringWork' => object.duringWork,
      'monitoring' => object.monitoring,
      'emergency' => object.emergency,
      'stopWork' => object.stopWork,
      'checklist' => object.checklist,
      'interview' => object.interview,
      'number' => object.number,
      'category' => object.category,
      'introduction' => object.introduction,
      _ => null,
    };
    if (value is String) return value.trim();
  } catch (_) {}
  return '';
}

String _sectionTitle(dynamic section) {
  for (final field in const ['title', 'name', 'heading', 'category', 'number']) {
    final value = _readString(section, field);
    if (value.isNotEmpty) return value;
  }
  return 'Field Safety Section';
}

String _sectionPreview(dynamic section) {
  for (final field in const [
    'introduction',
    'detail',
    'content',
    'meaning',
    'description',
  ]) {
    final value = _readString(section, field);
    if (value.isNotEmpty) return value;
  }
  final points = _sectionPoints(section);
  if (points.isNotEmpty) return _pointPreview(points.first);
  return '';
}

List<dynamic> _sectionPoints(dynamic section) {
  try {
    final list = section.points as List;
    return list.toList();
  } catch (_) {}
  try {
    return [section.point];
  } catch (_) {}
  return const [];
}

String _pointPreview(dynamic point) {
  for (final field in const ['detail', 'content', 'meaning', 'hazards', 'controls']) {
    final value = _readString(point, field);
    if (value.isNotEmpty) return value;
  }
  return '';
}

List<(String, String)> _pointFields(dynamic point) {
  final result = <(String, String)>[];

  void add(String label, String field) {
    final value = _readString(point, field);
    if (value.isNotEmpty) result.add((label, value));
  }

  add('Meaning / Detail', 'detail');
  add('Content', 'content');
  add('Meaning', 'meaning');
  add('Hazards / Consequences', 'hazards');
  add('Control Measures', 'controls');
  add('Field HSE Check', 'fieldCheck');
  add('Common Mistake', 'commonMistake');
  add('Corrective Action', 'action');
  add('Records / Evidence', 'records');
  add('Field Procedure', 'fieldProcedure');
  add('Roles & Responsibilities', 'roles');
  add('Before Starting', 'preWork');
  add('During Work', 'duringWork');
  add('Monitoring / Verification', 'monitoring');
  add('Emergency / Rescue', 'emergency');
  add('Stop-Work Condition', 'stopWork');
  add('HSE Officer Checklist', 'checklist');
  add('Interview Question', 'interview');

  // Some Gold sources expose a list of strings inside a point.
  try {
    final list = point.points as List;
    for (final item in list) {
      final text = item.toString().trim();
      if (text.isNotEmpty) result.add(('Field Point', text));
    }
  } catch (_) {}

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
