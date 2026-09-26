// lib/data/abu_dhabi/abu_dhabi_cop_01_to_03_reference_page.dart
// SafeNexus HSE — CoP 1.0 to 3.1 field-reference hub

import 'package:flutter/material.dart';
import 'abu_dhabi_cop_01_to_03.dart';
import 'abu_dhabi_scaffolding_reference_page.dart';

class AbuDhabiCop01To03ReferencePage extends StatefulWidget {
  const AbuDhabiCop01To03ReferencePage({super.key});

  @override
  State<AbuDhabiCop01To03ReferencePage> createState() => _AbuDhabiCop01To03ReferencePageState();
}

class _AbuDhabiCop01To03ReferencePageState extends State<AbuDhabiCop01To03ReferencePage> {
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

  List<AbuDhabiCopDocument> get _filtered {
    if (_query.trim().isEmpty) return AbuDhabiCop01To03.documents;
    final q = _query.toLowerCase().trim();
    return AbuDhabiCop01To03.documents.where((doc) {
      final haystack = [
        doc.code,
        doc.title,
        doc.version,
        doc.introduction,
        ...doc.sections.expand((s) => [
              s.number,
              s.title,
              ...s.requirements,
              ...s.measurements,
              ...s.documents,
              ...s.hazards,
              ...s.controls,
              ...s.inspection,
            ]),
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
          ? Matrix4.diagonal3Values(1.65, 1.65, 1.0)
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
                hintText: 'Search CoP 1–3 content...',
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
                      _introCard(),
                      const SizedBox(height: 12),
                      _scaffoldingCard(context),
                      const SizedBox(height: 12),
                      if (docs.isEmpty)
                        _emptySearch()
                      else
                        for (final doc in docs) ...[
                          _documentCard(doc),
                          const SizedBox(height: 12),
                        ],
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

  Widget _introCard() => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
        child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('CoP 1.0–3.1', style: TextStyle(color: navy, fontSize: 25, fontWeight: FontWeight.w900)),
          SizedBox(height: 8),
          Text('Official Abu Dhabi OSH reference subjects', style: TextStyle(color: green, fontSize: 14, fontWeight: FontWeight.w800)),
          SizedBox(height: 10),
          Text('Use Search to find requirements, measurements, hazards, inspections or checklist items. Double-tap or use the zoom button, then drag with your finger to inspect small text.', style: TextStyle(fontSize: 14, height: 1.45)),
        ]),
      );

  Widget _scaffoldingCard(BuildContext context) => Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: ListTile(
          leading: const CircleAvatar(backgroundColor: Color(0xFFE7F5EC), child: Icon(Icons.construction, color: green)),
          title: const Text('CoP 26.0 – Scaffolding', style: TextStyle(fontWeight: FontWeight.w800, color: navy)),
          subtitle: const Text('Existing locked subject • V4.1 • 16 February 2026'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AbuDhabiScaffoldingReferencePage())),
        ),
      );

  Widget _documentCard(AbuDhabiCopDocument doc) => Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
          title: Text('${doc.code} – ${doc.title}', style: const TextStyle(color: navy, fontWeight: FontWeight.w900, fontSize: 17)),
          subtitle: Text('Version ${doc.version} • ${doc.effectiveDate}', style: const TextStyle(color: green, fontWeight: FontWeight.w700)),
          children: [
            _textBlock('What is this subject?', doc.introduction),
            for (final section in doc.sections) _section(section),
            if (doc.fieldChecklist.isNotEmpty) _bulletBlock('Field Checklist', Icons.checklist, green, doc.fieldChecklist),
            if (doc.stopWorkIndicators.isNotEmpty) _bulletBlock('Stop-Work Indicators', Icons.stop_circle_outlined, const Color(0xFFC62828), doc.stopWorkIndicators),
            if (doc.references.isNotEmpty) _bulletBlock('Official References', Icons.menu_book_outlined, navy, doc.references),
            if (doc.verificationNote.isNotEmpty) _warningBlock(doc.verificationNote),
          ],
        ),
      );

  Widget _section(AbuDhabiCopSection s) => Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: const Color(0xFFF7FAFC), borderRadius: BorderRadius.circular(14)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${s.number}  ${s.title}', style: const TextStyle(color: navy, fontSize: 15, fontWeight: FontWeight.w900)),
          if (s.hazards.isNotEmpty) _miniList('Hazards', s.hazards),
          if (s.requirements.isNotEmpty) _miniList('Requirements', s.requirements),
          if (s.measurements.isNotEmpty) _miniList('Measurements / Limits', s.measurements),
          if (s.controls.isNotEmpty) _miniList('Hierarchy / Controls', s.controls),
          if (s.documents.isNotEmpty) _miniList('Documents / Records', s.documents),
          if (s.inspection.isNotEmpty) _miniList('Inspection', s.inspection),
        ]),
      );

  Widget _textBlock(String title, String text) => Padding(padding: const EdgeInsets.fromLTRB(4, 4, 4, 10), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: green, fontWeight: FontWeight.w900)), const SizedBox(height: 5), Text(text, style: const TextStyle(height: 1.45))]));

  Widget _miniList(String title, List<String> items) => Padding(padding: const EdgeInsets.only(top: 9), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: navy)), const SizedBox(height: 4), for (final item in items) Padding(padding: const EdgeInsets.only(bottom: 4), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('• ', style: TextStyle(color: green, fontWeight: FontWeight.w900)), Expanded(child: Text(item, style: const TextStyle(height: 1.35)))]))]));

  Widget _bulletBlock(String title, IconData icon, Color color, List<String> items) => Container(margin: const EdgeInsets.only(top: 10), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: color.withValues(alpha: .07), borderRadius: BorderRadius.circular(14)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Icon(icon, color: color), const SizedBox(width: 8), Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w900))]), const SizedBox(height: 8), for (final item in items) Padding(padding: const EdgeInsets.only(bottom: 4), child: Text('• $item', style: const TextStyle(height: 1.35)))]));

  Widget _warningBlock(String text) => Container(margin: const EdgeInsets.only(top: 10), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFFFF4E5), borderRadius: BorderRadius.circular(12)), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Icon(Icons.info_outline, color: Color(0xFFB26A00)), const SizedBox(width: 8), Expanded(child: Text(text, style: const TextStyle(height: 1.35)))]));

  Widget _emptySearch() => const Padding(padding: EdgeInsets.all(30), child: Center(child: Text('No matching CoP content found.')));

  Widget _noteCard() => const Padding(padding: EdgeInsets.only(top: 4), child: Text('Source basis: ADPHC Code of Practices registry and official English CoP documents. Verify the current official attachment before using any item as a legal/compliance determination.', style: TextStyle(fontSize: 12, height: 1.4, color: Colors.black54)));
}
