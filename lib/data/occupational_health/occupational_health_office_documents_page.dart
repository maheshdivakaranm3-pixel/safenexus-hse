import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:excel/excel.dart';
import 'package:image_picker/image_picker.dart';

import 'occupational_health_office_documents.dart';

class OccupationalHealthOfficeDocumentsPage extends StatefulWidget {
  const OccupationalHealthOfficeDocumentsPage({super.key});
  @override
  State<OccupationalHealthOfficeDocumentsPage> createState() => _OccupationalHealthOfficeDocumentsPageState();
}

class _OccupationalHealthOfficeDocumentsPageState extends State<OccupationalHealthOfficeDocumentsPage> {
  static const green = Color(0xFF0B5D4B);
  static const storageKey = 'safenexus_oh_office_document_records_v2';
  List<Map<String, dynamic>> saved = [];
  bool loading = true;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);
    if (raw != null) {
      try { saved = (jsonDecode(raw) as List).map((e) => Map<String,dynamic>.from(e as Map)).toList(); } catch (_) {}
    }
    if (mounted) setState(() => loading = false);
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(saved));
  }

  Future<void> _openEditor(OccupationalHealthOfficeDocument doc, {Map<String,dynamic>? existing}) async {
    final result = await Navigator.push<Map<String,dynamic>>(context, MaterialPageRoute(
      builder: (_) => _OfficeDocumentEditor(doc: doc, existing: existing),
    ));
    if (result == null) return;
    setState(() {
      final idx = saved.indexWhere((e) => e['recordId'] == result['recordId']);
      if (idx >= 0) saved[idx] = result; else saved.insert(0, result);
    });
    await _persist();
  }

  @override
  Widget build(BuildContext context) {
    final groups = <String,List<OccupationalHealthOfficeDocument>>{};
    for (final doc in occupationalHealthOfficeDocuments) { groups.putIfAbsent(doc.category, () => []).add(doc); }
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(title: const Text('Office Documents'), backgroundColor: green, foregroundColor: Colors.white),
      body: loading ? const Center(child: CircularProgressIndicator()) : ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(color: const Color(0xFFE5F4E9), child: const Padding(
            padding: EdgeInsets.all(15),
            child: Text('Create and save project-specific occupational health records. Open a document to enter site data, save a draft, or export a report.', style: TextStyle(height: 1.4)),
          )),
          if (saved.isNotEmpty) ...[
            const Padding(padding: EdgeInsets.fromLTRB(5,12,5,6), child: Text('SAVED DOCUMENTS', style: TextStyle(fontWeight: FontWeight.bold,color: green))),
            ...saved.map((r) => Card(child: ListTile(
              leading: const Icon(Icons.description_outlined,color: green),
              title: Text((r['documentTitle'] ?? 'Document').toString()),
              subtitle: Text('${r['project'] ?? 'Project not set'} • ${r['documentNo'] ?? ''} • ${r['status'] ?? 'Draft'}'),
              trailing: const Icon(Icons.edit_outlined),
              onTap: () {
                final doc = occupationalHealthOfficeDocuments.firstWhere((d) => d.id == r['documentId'], orElse: () => occupationalHealthOfficeDocuments.first);
                _openEditor(doc, existing: r);
              },
            ))),
            const Divider(),
          ],
          for (final entry in groups.entries) ...[
            Padding(padding: const EdgeInsets.fromLTRB(5,14,5,7), child: Text(entry.key, style: const TextStyle(fontSize:18,fontWeight:FontWeight.bold,color:green))),
            for (final doc in entry.value)
              Card(color: Colors.white, margin: const EdgeInsets.only(bottom:7), child: ListTile(
                leading: const CircleAvatar(backgroundColor: Color(0xFFE5F4E9), child: Icon(Icons.article_outlined,color:green)),
                title: Text(doc.title, style: const TextStyle(fontWeight:FontWeight.w600)),
                subtitle: Text('Prepared by: ${doc.preparer}'),
                trailing: const Icon(Icons.add_circle_outline,color:green),
                onTap: () => _openEditor(doc),
              )),
          ],
        ],
      ),
    );
  }
}

class _OfficeDocumentEditor extends StatefulWidget {
  final OccupationalHealthOfficeDocument doc;
  final Map<String,dynamic>? existing;
  const _OfficeDocumentEditor({required this.doc,this.existing});
  @override
  State<_OfficeDocumentEditor> createState() => _OfficeDocumentEditorState();
}

class _OfficeDocumentEditorState extends State<_OfficeDocumentEditor> {
  static const green = Color(0xFF0B5D4B);
  final formKey = GlobalKey<FormState>();
  final values = <String,TextEditingController>{};
  final checklist = <String,bool>{};
  final logos = <String,String>{};
  late String recordId;
  String status = 'Draft';

  static const common = <String>[
    'Company / Contractor Name','Client Name','Consultant Name','Project Name','Project Location',
    'Document Number','Revision','Document Date','Work Area / Department','Activity / Assessment Scope',
    'Prepared By – Name & Designation','Reviewed By – Name & Designation','Approved By – Name & Designation',
    'Review / Approval Date','Findings / Observations','Control Measures / Corrective Actions',
    'Responsible Person','Target Completion Date','Verification / Closure Notes','Reference / Attachments'
  ];

  List<String> get fields {
    final title = widget.doc.title.toLowerCase();
    if (title.contains('risk assessment')) return [...common,'Hazard / Health Agent','Persons Exposed','Exposure Route / Duration','Existing Controls','Likelihood (1–5)','Severity (1–5)','Initial Risk Rating','Additional Controls','Residual Likelihood (1–5)','Residual Severity (1–5)','Residual Risk Rating','Review Trigger'];
    if (title.contains('noise')) return [...common,'Monitoring Date / Shift','Instrument / Calibration Details','Monitoring Location','Measured Level (dB(A))','Exposure Duration','Applicable Criteria / Source','Result / Interpretation','Recommended Controls'];
    if (title.contains('heat')) return [...common,'Monitoring Date / Time','Location / Work Activity','WBGT / Heat Reading','Work-Rest Regime','Hydration / Shade Arrangements','Symptoms / Findings','Response / Follow-up'];
    if (title.contains('fitness') || title.contains('medical')) return [...common,'Worker Reference ID (avoid unnecessary clinical details)','Job / Fitness Requirement','Fitness Outcome','Restriction / Work Adjustment (if applicable)','Fitness Valid From','Fitness Valid Until','Review Due Date','Confidential Record Access Owner'];
    if (title.contains('inspection') || title.contains('audit')) return [...common,'Inspection / Audit Date','Inspection Area','Inspection Criteria','Finding Reference','Finding Classification','Evidence / Photo Reference','Corrective Action Owner','Due Date','Closure Verification'];
    if (title.contains('training')) return [...common,'Training Topic','Trainer / Provider','Training Date','Attendee / Employee ID','Competency / Assessment Result','Next Refresher Date'];
    if (title.contains('register')) return [...common,'Record / Requirement','Applicable Source','Responsible Owner','Evidence / Status','Next Review Date'];
    return [...common,'Applicable Requirements / Reference','Resources Required','Monitoring / Review Frequency','Emergency / Escalation Arrangements','Additional Notes'];
  }

  @override
  void initState() {
    super.initState();
    final old = widget.existing ?? {};
    recordId = (old['recordId'] ?? '${widget.doc.id}-${DateTime.now().microsecondsSinceEpoch}').toString();
    status = (old['status'] ?? 'Draft').toString();
    if (old['logos'] is Map) { for (final e in (old['logos'] as Map).entries) { logos[e.key.toString()] = e.value.toString(); } }
    for (final label in fields) {
      values[label] = TextEditingController(text: (old['fields'] is Map ? old['fields'][label] : '')?.toString() ?? '');
    }
    for (final item in widget.doc.checklist) {
      checklist[item] = (old['checklist'] is Map ? old['checklist'][item] == true : false);
    }
  }

  @override
  void dispose() { for (final c in values.values) { c.dispose(); } super.dispose(); }

  Map<String,dynamic> _record() => {
    'recordId':recordId,'documentId':widget.doc.id,'documentTitle':widget.doc.title,
    'category':widget.doc.category,'documentNo':values['Document Number']!.text,
    'project':values['Project Name']!.text,'status':status,'updatedAt':DateTime.now().toIso8601String(),
    'fields':{for(final e in values.entries)e.key:e.value.text},
    'checklist':checklist,'logos':logos,
  };

  Future<void> _pickLogo(String key) async {
    final picked = await ImagePicker().pickImage(source:ImageSource.gallery,imageQuality:75,maxWidth:900);
    if (picked == null) return;
    final bytes = await File(picked.path).readAsBytes();
    if (mounted) setState(() => logos[key] = base64Encode(bytes));
  }

  Widget _logoPicker(String key) => Card(color:Colors.white,child:ListTile(
    leading: logos[key] == null ? const Icon(Icons.add_photo_alternate_outlined,color:green) : Image.memory(base64Decode(logos[key]!),width:48,height:48,fit:BoxFit.contain),
    title:Text('$key Logo'),
    subtitle:Text(logos[key] == null ? 'Optional – select image' : 'Logo selected'),
    trailing:const Icon(Icons.upload_outlined),
    onTap:()=>_pickLogo(key),
  ));

  Future<void> _save() async {
    final data = _record();
    Navigator.pop(context,data);
  }

  String _plainText() {
    final b=StringBuffer();
    b.writeln(widget.doc.title.toUpperCase());
    b.writeln('DOCUMENT CONTROL');
    for(final key in ['Company / Contractor Name','Client Name','Consultant Name','Project Name','Project Location','Document Number','Revision','Document Date']) {
      b.writeln('$key: ${values[key]!.text}');
    }
    b.writeln('\nPURPOSE\n${widget.doc.purpose}');
    b.writeln('\nDOCUMENT RESPONSIBILITY\nPrepared By: ${widget.doc.preparer}\nReviewed By: ${widget.doc.reviewer}\nApproved By: ${widget.doc.approver}');
    b.writeln('\nDOCUMENT DETAILS');
    for(final e in values.entries) { if(e.value.text.trim().isNotEmpty && !['Company / Contractor Name','Client Name','Consultant Name','Project Name','Project Location','Document Number','Revision','Document Date'].contains(e.key)) b.writeln('${e.key}: ${e.value.text}'); }
    b.writeln('\nWORKING CHECKLIST');
    for(final e in checklist.entries) { b.writeln('[${e.value ? 'X' : ' '}] ${e.key}'); }
    b.writeln('\nSTATUS: $status');
    return b.toString();
  }

  Future<void> _exportPdf() async {
    final pdf=pw.Document();
    final fields=values.entries.where((e)=>e.value.text.trim().isNotEmpty).toList();
    pdf.addPage(pw.MultiPage(build:(context)=>[
      pw.Header(level:0,child:pw.Column(crossAxisAlignment:pw.CrossAxisAlignment.center,children:[
        pw.Text(values['Company / Contractor Name']!.text.isEmpty?'COMPANY / CONTRACTOR':values['Company / Contractor Name']!.text,style:pw.TextStyle(fontSize:16,fontWeight:pw.FontWeight.bold)),
        pw.Text('OCCUPATIONAL HEALTH & SAFETY DOCUMENT',style:const pw.TextStyle(fontSize:9)),
        pw.SizedBox(height:8),pw.Text(widget.doc.title.toUpperCase(),style:pw.TextStyle(fontSize:17,fontWeight:pw.FontWeight.bold)),
        pw.SizedBox(height:6),
        pw.Row(mainAxisAlignment:pw.MainAxisAlignment.spaceBetween,children:[
          for(final key in ['Company','Client','Consultant'])
            if(logos[key] != null) pw.Container(width:65,height:38,child:pw.Image(pw.MemoryImage(base64Decode(logos[key]!)),fit:pw.BoxFit.contain)),
        ]),
      ])),
      pw.Table.fromTextArray(data:[['CLIENT',values['Client Name']!.text,'CONSULTANT',values['Consultant Name']!.text],['PROJECT',values['Project Name']!.text,'LOCATION',values['Project Location']!.text],['DOCUMENT NO.',values['Document Number']!.text,'REVISION',values['Revision']!.text],['DATE',values['Document Date']!.text,'STATUS',status]]),
      pw.SizedBox(height:12),pw.Text('1. PURPOSE',style:pw.TextStyle(fontWeight:pw.FontWeight.bold)),pw.Text(widget.doc.purpose),
      pw.SizedBox(height:10),pw.Text('2. DOCUMENT RESPONSIBILITY',style:pw.TextStyle(fontWeight:pw.FontWeight.bold)),
      pw.Text('Prepared By: ${widget.doc.preparer}\nReviewed By: ${widget.doc.reviewer}\nApproved By: ${widget.doc.approver}'),
      pw.SizedBox(height:10),pw.Text('3. PROJECT / SITE DETAILS',style:pw.TextStyle(fontWeight:pw.FontWeight.bold)),
      pw.Table.fromTextArray(data:[['FIELD','ENTERED INFORMATION'],...fields.map((e)=>[e.key,e.value.text])]),
      pw.SizedBox(height:10),pw.Text('4. WORKING CHECKLIST',style:pw.TextStyle(fontWeight:pw.FontWeight.bold)),
      pw.Table.fromTextArray(data:[['CHECK ITEM','STATUS'],...checklist.entries.map((e)=>[e.key,e.value?'Completed':'Pending'])]),
      pw.SizedBox(height:20),pw.Text('PREPARED BY: ____________________   REVIEWED BY: ____________________'),
      pw.SizedBox(height:20),pw.Text('APPROVED BY: ____________________   DATE: ____________________'),
      pw.SizedBox(height:12),pw.Text('Document status: $status | Generated by SafeNexus HSE',style:const pw.TextStyle(fontSize:8)),
    ]));
    await Printing.sharePdf(bytes:await pdf.save(),filename:'${widget.doc.title.replaceAll(RegExp(r'[^A-Za-z0-9]+'),'_')}.pdf');
  }

  Future<void> _exportExcel() async {
    final book=Excel.createExcel();
    final sheet=book['Office Document'];
    sheet.appendRow([TextCellValue('SAFE NEXUS HSE – ${widget.doc.title}')]);
    sheet.appendRow([TextCellValue('Field'),TextCellValue('Value')]);
    for(final e in values.entries) { sheet.appendRow([TextCellValue(e.key),TextCellValue(e.value.text)]); }
    sheet.appendRow([TextCellValue('Purpose'),TextCellValue(widget.doc.purpose)]);
    sheet.appendRow([TextCellValue('Checklist Item'),TextCellValue('Status')]);
    for(final e in checklist.entries) { sheet.appendRow([TextCellValue(e.key),TextCellValue(e.value?'Completed':'Pending')]); }
    final bytes=book.encode();
    if(bytes==null) return;
    final dir=await getTemporaryDirectory();
    final file=File('${dir.path}/OH_Document_${widget.doc.id}.xlsx');
    await file.writeAsBytes(bytes,flush:true);
    await Share.shareXFiles([XFile(file.path)],text:'${widget.doc.title} – Excel workbook');
  }

  String _rtfEscape(String s)=>s.replaceAll('\\','\\\\').replaceAll('{',r'\{').replaceAll('}',r'\}').replaceAll('\n',r'\par ');
  Future<void> _exportWord() async {
    final dir=await getTemporaryDirectory();
    final content=_plainText().split('\n').map(_rtfEscape).join(r'\par ');
    final rtf='{\\rtf1\\ansi\\deff0 {\\fonttbl {\\f0 Arial;}}\\f0\\fs22 $content\\par}';
    final file=File('${dir.path}/OH_Document_${widget.doc.id}.rtf');
    await file.writeAsString(rtf,flush:true);
    await Share.shareXFiles([XFile(file.path)],text:'Word-compatible RTF document (opens in Microsoft Word)');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor:const Color(0xFFF6F8F7),
    appBar:AppBar(title:Text(widget.doc.title,maxLines:2,overflow:TextOverflow.ellipsis),backgroundColor:green,foregroundColor:Colors.white),
    body:Form(key:formKey,child:ListView(padding:const EdgeInsets.all(14),children:[
      Container(padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:const Color(0xFFE5F4E9),borderRadius:BorderRadius.circular(12)),child:Column(children:[
        const Icon(Icons.business_outlined,size:30,color:green),
        Text(values['Company / Contractor Name']!.text.isEmpty?'COMPANY / CONTRACTOR NAME':values['Company / Contractor Name']!.text.toUpperCase(),textAlign:TextAlign.center,style:const TextStyle(fontWeight:FontWeight.bold,fontSize:17,color:green)),
        const Text('OCCUPATIONAL HEALTH & SAFETY DOCUMENT',textAlign:TextAlign.center,style:TextStyle(fontSize:11)),
        const SizedBox(height:8),Text(widget.doc.title.toUpperCase(),textAlign:TextAlign.center,style:const TextStyle(fontWeight:FontWeight.bold,fontSize:16)),
        const Text('Company / Client / Consultant logo areas can be added to the final branded export.',textAlign:TextAlign.center,style:TextStyle(fontSize:11,color:Colors.black54)),
      ])),
      const SizedBox(height:12),
      _section('DOCUMENT PURPOSE',widget.doc.purpose),
      _section('DOCUMENT RESPONSIBILITY','Prepared by: ${widget.doc.preparer}\nReviewed by: ${widget.doc.reviewer}\nApproved by: ${widget.doc.approver}'),
      const Text('COMPANY BRANDING',style:TextStyle(fontWeight:FontWeight.bold,color:green,fontSize:17)),
      for(final key in ['Company','Client','Consultant']) _logoPicker(key),
      const SizedBox(height:10),
      const Text('PROJECT DETAILS & DOCUMENT INPUT',style:TextStyle(fontWeight:FontWeight.bold,color:green,fontSize:17)),
      for(final label in fields) Padding(padding:const EdgeInsets.only(top:9),child:TextFormField(controller:values[label],maxLines:label.contains('Notes')||label.contains('Findings')||label.contains('Measures')||label.contains('Scope')?3:1,decoration:InputDecoration(labelText:label,border:const OutlineInputBorder(),filled:true,fillColor:Colors.white))),
      const SizedBox(height:16),const Text('WORKING CHECKLIST',style:TextStyle(fontWeight:FontWeight.bold,color:green,fontSize:17)),
      for(final item in checklist.keys.toList()) Card(color:Colors.white,child:CheckboxListTile(value:checklist[item],controlAffinity:ListTileControlAffinity.leading,title:Text(item),onChanged:(v)=>setState(()=>checklist[item]=v??false))),
      const SizedBox(height:10),DropdownButtonFormField<String>(value:status,decoration:const InputDecoration(labelText:'Document Status',border:OutlineInputBorder()),items:const ['Draft','Under Review','Approved','Action Required','Closed'].map((s)=>DropdownMenuItem(value:s,child:Text(s))).toList(),onChanged:(v)=>setState(()=>status=v??'Draft')),
      const SizedBox(height:16),
      FilledButton.icon(onPressed:_save,icon:const Icon(Icons.save_outlined),label:const Text('Save Document')),
      const SizedBox(height:8),
      OutlinedButton.icon(onPressed:_exportPdf,icon:const Icon(Icons.picture_as_pdf),label:const Text('Export / Share PDF')),
      OutlinedButton.icon(onPressed:_exportWord,icon:const Icon(Icons.description_outlined),label:const Text('Export Word-compatible RTF')),
      OutlinedButton.icon(onPressed:_exportExcel,icon:const Icon(Icons.table_chart_outlined),label:const Text('Export Excel (.xlsx)')),
      const SizedBox(height:12),
      const Text('Medical records: store only necessary fitness outcomes and restrict access to confidential clinical information.',style:TextStyle(fontSize:12,color:Colors.black54)),
    ])),
  );

  Widget _section(String title,String body)=>Padding(padding:const EdgeInsets.only(bottom:14),child:Card(color:Colors.white,child:Padding(padding:const EdgeInsets.all(13),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(fontWeight:FontWeight.bold,color:green)),const SizedBox(height:5),Text(body)]))));
}
