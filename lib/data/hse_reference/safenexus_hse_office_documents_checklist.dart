import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:excel/excel.dart';

/// Work-ready HSE document preparation workflow.
/// Add to Specialist/Cross-Sector navigation:
/// Navigator.push(context, MaterialPageRoute(builder: (_) => const HseWorkReadyDocumentsPage()));
///
/// PDF and XLSX exports are implemented. Word-compatible RTF export is included
/// so the generated file opens/editably in Microsoft Word; it uses .rtf format.
class HseWorkReadyDocumentsPage extends StatefulWidget {
  const HseWorkReadyDocumentsPage({super.key});
  @override
  State<HseWorkReadyDocumentsPage> createState() => _HseWorkReadyDocumentsPageState();
}

class _HseWorkReadyDocumentsPageState extends State<HseWorkReadyDocumentsPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _c = {
    for (final k in _fields) k: TextEditingController(),
  };
  String _stage = 'Prepare';
  String _status = 'Draft';
  static const _fields = <String>[
    'Company Name','Client','Consultant','Main Contractor / Subcontractor',
    'Project Name','Project Location','Contract / Work Order No.','Document Title',
    'Document Number','Revision','Work Activity','Exact Work Scope','Work Date / Shift',
    'Work Sequence (step by step)','Site Conditions / Interfaces','Workforce / Competent Persons',
    'Plant, Tools & Equipment','Required Permits / Isolations','Hazards and Exposed Persons',
    'Initial Risk / Likelihood-Severity','Control Measures (hierarchy of controls)',
    'Residual Risk / Acceptance','PPE','Inspection / Hold Points','Emergency / Rescue Arrangements',
    'Environmental Controls','Prepared By / Designation','HSE Review / Competent Person',
    'Client / Consultant Approval (if required)','Review Comments / Actions','Approval Reference / Date',
    'Attachments / Evidence','Work Completion / Handover Notes',
  ];

  @override
  void dispose() { for (final x in _c.values) { x.dispose(); } super.dispose(); }

  String _text() => _fields.map((k) => '$k:\n${_c[k]!.text.trim()}').join('\n\n') +
      '\n\nWorkflow Stage: $_stage\nStatus: $_status\nGenerated: ${DateTime.now().toIso8601String()}';

  Future<File> _write(String name, List<int> bytes) async {
    final dir = await getApplicationDocumentsDirectory();
    final safe = (_c['Document Title']!.text.trim().isEmpty ? 'HSE_Work_Document' : _c['Document Title']!.text.trim())
        .replaceAll(RegExp(r'[^A-Za-z0-9_-]+'), '_');
    final file = File('${dir.path}/${safe}_$name');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future<void> _pdf() async {
    final doc = pw.Document();
    doc.addPage(pw.MultiPage(pageFormat: PdfPageFormat.a4, build: (_) => [
      pw.Header(level: 0, child: pw.Text('SAFENEXUS HSE — WORK-READY DOCUMENT')),
      pw.Text('Workflow: $_stage | Status: $_status'),
      pw.SizedBox(height: 12),
      ..._fields.map((k) => pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text(k, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(_c[k]!.text.isEmpty ? 'Not entered' : _c[k]!.text),
        pw.SizedBox(height: 8),
      ])),
      pw.Divider(),
      pw.Text('Controlled issue only after competent review and required client/consultant approval. Verify actual site conditions and applicable authority/client requirements.'),
    ]));
    final f = await _write('document.pdf', await doc.save());
    await Share.shareXFiles([XFile(f.path)], text: 'SafeNexus HSE PDF');
  }

  Future<void> _xlsx() async {
    final book = Excel.createExcel();
    final sheet = book['HSE Work Document'];
    sheet.appendRow([TextCellValue('Field'), TextCellValue('Entered Information')]);
    for (final k in _fields) { sheet.appendRow([TextCellValue(k), TextCellValue(_c[k]!.text)]); }
    sheet.appendRow([TextCellValue('Workflow Stage'), TextCellValue(_stage)]);
    sheet.appendRow([TextCellValue('Status'), TextCellValue(_status)]);
    final bytes = book.encode();
    if (bytes == null) return;
    final f = await _write('document.xlsx', bytes);
    await Share.shareXFiles([XFile(f.path)], text: 'SafeNexus HSE Excel');
  }

  String _rtfEscape(String s) => s.replaceAll(r'\', r'\\').replaceAll('{', r'\{').replaceAll('}', r'\}').replaceAll('\n', r'\line ');
  Future<void> _word() async {
    final body = StringBuffer(r'{\rtf1\ansi\deff0 {\b SafeNexus HSE — Work-Ready Document}\par\par ');
    body.write('{\\b Workflow:} ${_rtfEscape(_stage)} | {\\b Status:} ${_rtfEscape(_status)}\\par\\par ');
    for (final k in _fields) { body.write('{\\b ${_rtfEscape(k)}:}\\par ${_rtfEscape(_c[k]!.text.isEmpty ? 'Not entered' : _c[k]!.text)}\\par\\par '); }
    body.write(r'\par Controlled issue only after competent review and required approval.}');
    final f = await _write('document.rtf', body.toString().codeUnits);
    await Share.shareXFiles([XFile(f.path)], text: 'Editable Word-compatible RTF');
  }

  Future<void> _saveShare() async {
    final f = await _write('draft.txt', _text().codeUnits);
    await Share.shareXFiles([XFile(f.path)], text: 'SafeNexus HSE saved draft');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Work-Ready HSE Documents')),
    body: Form(key: _formKey, child: ListView(padding: const EdgeInsets.all(16), children: [
      const Card(child: Padding(padding: EdgeInsets.all(12), child: Text('Prepare a site-specific work package. Complete actual site details; obtain competent-person review and client/consultant approval where required before work starts.'))),
      DropdownButtonFormField<String>(initialValue: _stage, decoration: const InputDecoration(labelText: 'Workflow stage'), items: ['Prepare','Review','Approve','Ready for issue','Work closeout'].map((s)=>DropdownMenuItem(value:s,child:Text(s))).toList(), onChanged:(v)=>setState(()=>_stage=v??'Prepare')),
      DropdownButtonFormField<String>(initialValue: _status, decoration: const InputDecoration(labelText: 'Document status'), items: ['Draft','Under Review','Comments Returned','Approved','Rejected','Closed'].map((s)=>DropdownMenuItem(value:s,child:Text(s))).toList(), onChanged:(v)=>setState(()=>_status=v??'Draft')),
      const SizedBox(height: 12),
      for (final k in _fields) Padding(padding: const EdgeInsets.only(bottom: 10), child: TextFormField(controller:_c[k], minLines: k.contains('Sequence')||k.contains('Hazard')||k.contains('Control')||k.contains('Scope')||k.contains('Arrangements')||k.contains('Conditions')||k.contains('Comments') ? 3 : 1, maxLines: 6, decoration: InputDecoration(labelText:k, border: const OutlineInputBorder(), alignLabelWithHint:true))),
      const Text('Export / Save & Share', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      Wrap(spacing:8, runSpacing:8, children:[
        FilledButton.icon(onPressed:_pdf, icon:const Icon(Icons.picture_as_pdf), label:const Text('PDF')),
        FilledButton.icon(onPressed:_word, icon:const Icon(Icons.description), label:const Text('Word (RTF)')),
        FilledButton.icon(onPressed:_xlsx, icon:const Icon(Icons.table_chart), label:const Text('Excel')),
        OutlinedButton.icon(onPressed:_saveShare, icon:const Icon(Icons.save), label:const Text('Save & Share Draft')),
      ]),
      const SizedBox(height:12),
      const Text('Safety gate: this app-generated draft does not itself authorize work. Verify site conditions, permits, isolations, risk acceptance, competent review and required client/consultant approval.'),
    ])),
  );
}

/// Compatibility name used by hse_topic_browser.dart navigation.
class HseOfficeDocumentsPage extends HseWorkReadyDocumentsPage {
  const HseOfficeDocumentsPage({super.key});
}
