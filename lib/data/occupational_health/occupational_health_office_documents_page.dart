import 'package:flutter/material.dart';
import 'occupational_health_office_documents.dart';

class OccupationalHealthOfficeDocumentsPage extends StatelessWidget {
  const OccupationalHealthOfficeDocumentsPage({super.key});
  static const green = Color(0xFF0B5D4B);
  @override
  Widget build(BuildContext context) {
    final groups = <String, List<OccupationalHealthOfficeDocument>>{};
    for (final doc in occupationalHealthOfficeDocuments) {
      groups.putIfAbsent(doc.category, () => []).add(doc);
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(title: const Text('Office Documents & Templates'), backgroundColor: green, foregroundColor: Colors.white),
      body: ListView(padding: const EdgeInsets.all(12), children: [
        Card(color: const Color(0xFFE5F4E9), child: const Padding(padding: EdgeInsets.all(16), child: Text('Occupational Health office document catalogue. Select a document to view its purpose, assigned roles and working checklist.', style: TextStyle(fontSize: 15, height: 1.4)))),
        for (final entry in groups.entries) ...[
          Padding(padding: const EdgeInsets.fromLTRB(5, 15, 5, 7), child: Text(entry.key, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: green))),
          for (final doc in entry.value)
            Card(color: Colors.white, margin: const EdgeInsets.only(bottom: 8), child: ListTile(
              leading: const CircleAvatar(backgroundColor: Color(0xFFE5F4E9), child: Icon(Icons.description_outlined, color: Color(0xFF159447))),
              title: Text(doc.title, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text('Prepared: ${doc.preparer}'),
              trailing: const Icon(Icons.chevron_right, color: green),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => _OfficeDocumentDetail(doc: doc))),
            )),
        ],
      ]),
    );
  }
}

class _OfficeDocumentDetail extends StatefulWidget {
  final OccupationalHealthOfficeDocument doc;
  const _OfficeDocumentDetail({required this.doc});
  @override
  State<_OfficeDocumentDetail> createState() => _OfficeDocumentDetailState();
}
class _OfficeDocumentDetailState extends State<_OfficeDocumentDetail> {
  late final checks = List<bool>.filled(widget.doc.checklist.length, false);
  @override
  Widget build(BuildContext context) {
    final doc = widget.doc;
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(title: Text(doc.title, maxLines: 2, overflow: TextOverflow.ellipsis), backgroundColor: const Color(0xFF0B5D4B), foregroundColor: Colors.white),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        _heading('Purpose'), Text(doc.purpose),
        _heading('Document responsibility'),
        _role('Prepared By', doc.preparer), _role('Reviewed By', doc.reviewer), _role('Approved By', doc.approver),
        _heading('Working checklist'),
        ...List.generate(doc.checklist.length, (i) => Card(color: Colors.white, child: CheckboxListTile(value: checks[i], controlAffinity: ListTileControlAffinity.leading, title: Text(doc.checklist[i]), onChanged: (v) => setState(() => checks[i] = v ?? false)))),
        const SizedBox(height: 12),
        const Text('Checklist selections are shown for on-screen review only. Document editing, persistent save, approval signatures and PDF/Word/Excel export are not connected in this catalogue build.', style: TextStyle(color: Colors.black54, fontSize: 12)),
      ]),
    );
  }
  Widget _heading(String value) => Padding(padding: const EdgeInsets.only(top: 18, bottom: 8), child: Text(value, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF0B5D4B))));
  Widget _role(String label, String value) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(width: 115, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600))), Expanded(child: Text(value))]));
}
