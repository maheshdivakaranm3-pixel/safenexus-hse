// lib/data/abu_dhabi/abu_dhabi_cop_01_to_03_reference_page.dart
// SafeNexus HSE — Abu Dhabi HSE CoP list + field-reference hub

import 'package:flutter/material.dart';
import 'abu_dhabi_cop_01_to_03.dart';
import 'abu_dhabi_cop_04_to_06.dart';
import 'abu_dhabi_cop_08_to_09.dart';
import 'abu_dhabi_cop_10_to_12.dart';
import 'abu_dhabi_cop_13_to_15.dart';
import 'abu_dhabi_cop_16_to_18.dart';
import 'abu_dhabi_scaffolding_reference_page.dart';

class AbuDhabiCop01To03ReferencePage extends StatefulWidget {
  const AbuDhabiCop01To03ReferencePage({super.key});

  @override
  State<AbuDhabiCop01To03ReferencePage> createState() =>
      _AbuDhabiCop01To03ReferencePageState();
}

class _AbuDhabiCop01To03ReferencePageState
    extends State<AbuDhabiCop01To03ReferencePage> {
  static const Color green = Color(0xFF159447);
  static const Color navy = Color(0xFF082653);

  final TextEditingController _search = TextEditingController();
  final TransformationController _transform = TransformationController();

  String _query = '';
  bool _zoomed = false;

  @override
  void dispose() {
    _search.dispose();
    _transform.dispose();
    super.dispose();
  }

  List<AbuDhabiCopDocument> get _allDocuments => [
        ...AbuDhabiCop01To03.documents,
        ...AbuDhabiCop04To06.documents,
        ...AbuDhabiCop08To09.documents,
        ...AbuDhabiCop10To12.documents,
        ...AbuDhabiCop13To15.documents,
        ...AbuDhabiCop16To18.documents,
      ];

  List<AbuDhabiCopDocument> get _filtered {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) {
      return _allDocuments;
    }

    return _allDocuments.where((doc) {
      final haystack = [
        doc.code,
        doc.title,
        doc.version,
        doc.effectiveDate,
        doc.introduction,
        ...doc.protectionItems,
        ...doc.sections.expand(
          (s) => [
            s.number,
            s.title,
            ...s.requirements,
            ...s.measurements,
            ...s.documents,
            ...s.hazards,
            ...s.controls,
            ...s.inspection,
          ],
        ),
        ...doc.fieldChecklist,
        ...doc.stopWorkIndicators,
        ...doc.references,
      ].join(' ').toLowerCase();

      return haystack.contains(q);
    }).toList();
  }

  void _toggleZoom() {
    setState(() {
      _zoomed = !_zoomed;
      _transform.value = _zoomed
          ? Matrix4.diagonal3Values(1.35, 1.35, 1.0)
          : Matrix4.identity();
    });
  }

  void _resetZoom() {
    setState(() {
      _zoomed = false;
      _transform.value = Matrix4.identity();
    });
  }

  @override
  Widget build(BuildContext context) {
    final docs = _filtered;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FB),
      appBar: AppBar(
        title: const Text('Abu Dhabi HSE Reference'),
        backgroundColor: Colors.white,
        foregroundColor: navy,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: _zoomed ? 'Reset zoom' : 'Zoom',
            onPressed: _toggleZoom,
            icon: Icon(_zoomed ? Icons.zoom_out_map : Icons.zoom_in),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _search,
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: 'Search Abu Dhabi HSE CoP content...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _search.clear();
                          setState(() => _query = '');
                        },
                        icon: const Icon(Icons.clear),
                      ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onDoubleTap: _toggleZoom,
              child: InteractiveViewer(
                transformationController: _transform,
                minScale: 1,
                maxScale: 3,
                panEnabled: true,
                scaleEnabled: true,
                boundaryMargin: const EdgeInsets.all(80),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _safetyReferenceCard(),
                      const SizedBox(height: 12),
                      if (docs.isEmpty)
                        _emptySearch()
                      else
                        for (final doc in docs) ...[
                          _documentCard(context, doc),
                          const SizedBox(height: 12),
                        ],
                      if (_query.trim().isEmpty ||
                          'scaffolding'.contains(_query.trim().toLowerCase()) ||
                          'cop 26.0'.contains(_query.trim().toLowerCase()))
                        _scaffoldingCard(context),
                      const SizedBox(height: 8),
                      _noteCard(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _zoomed
          ? FloatingActionButton.small(
              onPressed: _resetZoom,
              backgroundColor: green,
              foregroundColor: Colors.white,
              tooltip: 'Reset zoom',
              child: const Icon(Icons.center_focus_strong),
            )
          : null,
    );
  }

  Widget _safetyReferenceCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: const BoxDecoration(
              color: Color(0xFFE7F5EC),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.health_and_safety,
              color: green,
              size: 27,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Safety & Compliance Reference',
                  style: TextStyle(
                    color: navy,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'ADPHC CoP subjects • field requirements • controls • inspections',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _documentCard(
    BuildContext context,
    AbuDhabiCopDocument doc,
  ) {
    return _topicCard(
      context: context,
      icon: _iconFor(doc.code),
      title: '${doc.code} – ${doc.title}',
      subtitle: 'Version ${doc.version} • ${doc.effectiveDate}',
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => _CopDocumentDetailPage(doc: doc),
          ),
        );
      },
    );
  }

  Widget _scaffoldingCard(BuildContext context) {
    return _topicCard(
      context: context,
      icon: Icons.construction,
      title: 'CoP 26.0 – Scaffolding',
      subtitle: 'Existing locked subject • V4.1 • 16 February 2026',
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const AbuDhabiScaffoldingReferencePage(),
          ),
        );
      },
    );
  }

  Widget _topicCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 13,
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: const BoxDecoration(
                  color: Color(0xFFE7F5EC),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: green,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: navy,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black54,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconFor(String code) {
    switch (code) {
      case 'CoP 1.0':
        return Icons.science_outlined;
      case 'CoP 1.1':
        return Icons.warning_amber_rounded;
      case 'CoP 1.2':
        return Icons.health_and_safety;
      case 'CoP 2.0':
        return Icons.engineering;
      case 'CoP 3.0':
        return Icons.hearing;
      case 'CoP 3.1':
        return Icons.vibration;
      case 'CoP 10.0':
        return Icons.assignment_return_outlined;
      case 'CoP 11.0':
        return Icons.wb_sunny_outlined;
      case 'CoP 12.0':
        return Icons.water_drop_outlined;
      default:
        return Icons.shield_outlined;
    }
  }

  Widget _noteCard() {
    return const Padding(
      padding: EdgeInsets.only(top: 4),
      child: Text(
        'Source basis: ADPHC Code of Practices registry and official English CoP documents. Verify the current official attachment before using any item as a legal/compliance determination.',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 12,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _emptySearch() {
    return const Padding(
      padding: EdgeInsets.all(30),
      child: Center(
        child: Text('No matching Abu Dhabi CoP content found.'),
      ),
    );
  }
}

class _CopDocumentDetailPage extends StatelessWidget {
  const _CopDocumentDetailPage({
    required this.doc,
  });

  static const Color green = Color(0xFF159447);
  static const Color navy = Color(0xFF082653);

  final AbuDhabiCopDocument doc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FB),
      appBar: AppBar(
        title: Text(doc.code),
        backgroundColor: Colors.white,
        foregroundColor: navy,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE7F5EC),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _detailIcon(doc.code),
                      color: green,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doc.title,
                          style: const TextStyle(
                            color: navy,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Version ${doc.version} • ${doc.effectiveDate}',
                          style: const TextStyle(
                            color: green,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _textBlock(doc.title, doc.introduction),
            if (doc.protectionItems.isNotEmpty)
              _bulletBlock(
                doc.code == 'CoP 2.0'
                    ? 'PPE Types & Protection Provided'
                    : 'Noise Protection Types & Protection Provided',
                doc.code == 'CoP 2.0'
                    ? Icons.health_and_safety
                    : Icons.hearing,
                green,
                doc.protectionItems,
              ),
            for (final section in doc.sections) _section(section),
            if (doc.fieldChecklist.isNotEmpty)
              _bulletBlock(
                'Field Checklist',
                Icons.checklist,
                green,
                doc.fieldChecklist,
              ),
            if (doc.stopWorkIndicators.isNotEmpty)
              _bulletBlock(
                'Stop-Work Indicators',
                Icons.stop_circle_outlined,
                const Color(0xFFC62828),
                doc.stopWorkIndicators,
              ),
            if (doc.references.isNotEmpty)
              _bulletBlock(
                'Official References',
                Icons.menu_book_outlined,
                navy,
                doc.references,
              ),
            if (doc.verificationNote.isNotEmpty)
              _warningBlock(doc.verificationNote),
          ],
        ),
      ),
    );
  }

  IconData _detailIcon(String code) {
    switch (code) {
      case 'CoP 1.0':
        return Icons.science_outlined;
      case 'CoP 1.1':
        return Icons.warning_amber_rounded;
      case 'CoP 1.2':
        return Icons.health_and_safety;
      case 'CoP 2.0':
        return Icons.engineering;
      case 'CoP 3.0':
        return Icons.hearing;
      case 'CoP 3.1':
        return Icons.vibration;
      case 'CoP 10.0':
        return Icons.assignment_return_outlined;
      case 'CoP 11.0':
        return Icons.wb_sunny_outlined;
      case 'CoP 12.0':
        return Icons.water_drop_outlined;
      default:
        return Icons.shield_outlined;
    }
  }

  Widget _section(AbuDhabiCopSection s) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${s.number}  ${s.title}',
            style: const TextStyle(
              color: navy,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
          if (s.hazards.isNotEmpty) _miniList('Hazards', s.hazards),
          if (s.requirements.isNotEmpty)
            _miniList('Requirements', s.requirements),
          if (s.measurements.isNotEmpty)
            _miniList('Measurements / Limits', s.measurements),
          if (s.controls.isNotEmpty)
            _miniList('Hierarchy / Controls', s.controls),
          if (s.documents.isNotEmpty)
            _miniList('Documents / Records', s.documents),
          if (s.inspection.isNotEmpty)
            _miniList('Inspection', s.inspection),
        ],
      ),
    );
  }

  Widget _textBlock(String title, String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: green,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(height: 1.45),
          ),
        ],
      ),
    );
  }

  Widget _miniList(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(top: 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: navy,
            ),
          ),
          const SizedBox(height: 4),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '• ',
                    style: TextStyle(
                      color: green,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(height: 1.35),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _bulletBlock(
    String title,
    IconData icon,
    Color color,
    List<String> items,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .07),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '• $item',
                style: const TextStyle(height: 1.35),
              ),
            ),
        ],
      ),
    );
  }

  Widget _warningBlock(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4E5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            color: Color(0xFFB26A00),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}
