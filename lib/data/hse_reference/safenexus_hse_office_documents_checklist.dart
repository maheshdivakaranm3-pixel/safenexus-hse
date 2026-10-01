import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:excel/excel.dart';

/// 40 selectable, document-specific HSE preparation forms.
/// Navigation: Navigator.push(context, MaterialPageRoute(builder: (_) => const HseOfficeDocumentsPage()));
class HseOfficeDocumentsPage extends StatefulWidget {
  const HseOfficeDocumentsPage({super.key});
  @override
  State<HseOfficeDocumentsPage> createState() => _HseOfficeDocumentsPageState();
}

class _DocSpec {
  final String category, title;
  final List<String> fields;
  const _DocSpec(this.category, this.title, this.fields);
}

const _common = <String>[
  'Company Name','Client','Consultant','Main Contractor / Subcontractor',
  'Project Name','Project Location','Contract / Work Order No.',
  'Document No.','Revision','Date / Shift','Prepared By / Designation',
  'Reviewed By / Competent Person','Client / Consultant Approval (if required)',
  'Review Comments / Approval Reference',
];

const _docs = <_DocSpec>[
  _DocSpec('Company & Project Administration','Company HSE Profile & Project Information',['Company HSE policy summary','Scope of services','HSE certifications / registrations','Emergency contacts','HSE resources and organization']),
  _DocSpec('Company & Project Administration','Project HSE Plan',['Project scope and phases','Applicable legal / client requirements','HSE objectives and targets','Organization and responsibilities','Risk register and critical controls','Emergency arrangements','Monitoring, audit and reporting']),
  _DocSpec('Company & Project Administration','HSE Policy',['Policy commitment','Leadership responsibilities','Worker consultation','Communication and display locations','Review date and approval']),
  _DocSpec('Company & Project Administration','HSE Organization Chart & Contact Directory',['Project manager','HSE manager / officer','First aider / fire warden','Competent persons','Emergency contact numbers','Escalation route']),
  _DocSpec('Company & Project Administration','HSE Roles & Responsibility Matrix',['Role / position','HSE duty','Authority to stop work','Required competence','Accountability / evidence']),
  _DocSpec('Risk & Work Control','HIRA / Risk Assessment',['Activity / task step','Hazard and exposed persons','Existing controls','Initial likelihood / severity / risk','Additional controls by hierarchy','Residual risk / acceptance','Responsible person']),
  _DocSpec('Risk & Work Control','Job Safety Analysis (JSA)',['Work scope and sequence step-by-step','Tools / equipment / materials','Hazard per step','Potential consequence','Controls and safe work method','PPE','Responsible person / briefing record']),
  _DocSpec('Risk & Work Control','Method Statement Review & Approval',['Work method and sequence','Resources / manpower','Plant and equipment','Work area / interfaces','Hold points and inspections','Risk assessment reference','Reviewer comments / closeout']),
  _DocSpec('Risk & Work Control','Permit to Work Request & Register',['Permit type / number','Exact work location and boundaries','Start / expiry time','SIMOPS / adjacent activities','Isolation / gas test requirements','Precautions and PPE','Issuer / receiver / closeout']),
  _DocSpec('Risk & Work Control','Toolbox Talk / Safety Briefing Record',['Topic and work activity','Task hazards and controls','Emergency actions','Language / interpretation needs','Attendee name / ID / signature','Presenter and date']),
  _DocSpec('Inspection & Compliance','Daily HSE Site Inspection',['Work area / activity inspected','Housekeeping and access','PPE and worker behavior','Tools / plant condition','Permit / barricade / signage','Findings, risk and immediate action','Owner / due date / closeout']),
  _DocSpec('Inspection & Compliance','Weekly HSE Inspection',['Inspection scope and team','Work at height / scaffolds','Electrical / temporary power','Lifting / plant / traffic','Fire / emergency readiness','Findings and action tracking']),
  _DocSpec('Inspection & Compliance','Monthly HSE Audit & Compliance Report',['Audit criteria / legal register','Departments / areas sampled','Evidence reviewed','Conformity / nonconformity','Finding severity and root cause','Corrective action / owner / due date','Verification and closure']),
  _DocSpec('Inspection & Compliance','Plant, Tools & Equipment Inspection',['Asset ID / description','Manufacturer / capacity','Pre-use inspection points','Defects / isolation decision','Certification expiry','Inspector / date / next inspection']),
  _DocSpec('Inspection & Compliance','Corrective & Preventive Action Register',['Finding / source','Immediate correction','Root cause','Corrective / preventive action','Action owner / target date','Effectiveness verification / closure']),
  _DocSpec('Employee & Training','Employee HSE Induction Record',['Employee / ID / employer','Trade / work location','Induction topics','Site rules / emergency routes','Language understood / assessment','Trainer / attendee acknowledgement']),
  _DocSpec('Employee & Training','HSE Training & Attendance Register',['Course / toolbox topic','Training provider / trainer','Date / duration','Competency outcome','Attendee name / ID / signature','Certificate / refresher due']),
  _DocSpec('Employee & Training','Competency & Authorization Register',['Task / equipment','Required qualification','Evidence / certificate number','Assessment / assessor','Authorization limits','Expiry / renewal date']),
  _DocSpec('Employee & Training','PPE Issue & Replacement Record',['Worker name / ID / trade','PPE type / specification / size','Issue date / condition','Training / fit check','Replacement reason / date','Worker acknowledgement']),
  _DocSpec('Employee & Training','Occupational Fitness / Medical Clearance Register',['Role fitness requirement','Fitness status / restriction (confidential)','Medical clearance reference','Validity / review date','Occupational health follow-up','Authorized custodian']),
  _DocSpec('Incident & Emergency','Incident, Injury & Property Damage Report',['Date / time / exact location','Incident type / persons involved','Description and activity','Injury / damage / potential severity','Immediate response / notifications','Evidence / witnesses','Initial actions']),
  _DocSpec('Incident & Emergency','Near Miss / Unsafe Condition Report',['Date / location / task','Unsafe act / condition / near miss','Potential consequence','Immediate safe action','Photo / witness reference','Recommended control / assigned owner']),
  _DocSpec('Incident & Emergency','Incident Investigation & Root Cause Analysis',['Event chronology','Evidence / witness statements','Immediate / underlying causes','Barrier failures','Root cause method and findings','Corrective actions / owners / dates','Lessons learned / verification']),
  _DocSpec('Incident & Emergency','Emergency Drill Evaluation',['Scenario / objectives','Date / location / participants','Alarm and response timeline','Muster / headcount result','Equipment / communication performance','Gaps / improvement actions']),
  _DocSpec('Incident & Emergency','First Aid & Medical Treatment Record',['Date / time / location','Injury / illness description','First aid provided','Referral / ambulance details','First aider / witness','Confidential record reference / follow-up']),
  _DocSpec('Environmental','Waste Management Register',['Waste stream / classification','Quantity / unit','Storage location / labeling','Segregation and containment','Collection / transporter','Disposal facility / manifest reference']),
  _DocSpec('Environmental','Waste Transfer / Disposal Note',['Waste description / code','Quantity and container count','From / to locations','Licensed carrier / vehicle','Receiving facility','Transfer date / signatures / receipt']),
  _DocSpec('Environmental','Environmental Inspection & Compliance Checklist',['Aspect / receptor','Dust / noise / emissions','Spill / chemical storage','Waste and housekeeping','Water / soil protection','Finding / action / owner / due date']),
  _DocSpec('Environmental','Spill / Environmental Release Report',['Substance / estimated quantity','Release point / pathway','People / environment affected','Source isolation and containment','Notifications / cleanup / waste','Sampling / restoration / follow-up']),
  _DocSpec('Environmental','Environmental Monitoring Record',['Parameter / monitoring point','Instrument / calibration','Date / time / conditions','Result / unit / limit source','Exceedance response','Reviewer / report reference']),
  _DocSpec('Contractor & Equipment','Contractor HSE Prequalification & Evaluation',['Contractor scope / risk profile','HSE statistics / incidents','Competence / certifications','Method / risk assessment review','Resources / supervision','Evaluation findings / approval']),
  _DocSpec('Contractor & Equipment','Equipment & Asset Register',['Asset ID / type / owner','Location / custodian','Inspection / certification status','Maintenance schedule','Defects / restrictions','Next due date']),
  _DocSpec('Contractor & Equipment','Third-Party Certification Register',['Equipment / certificate type','Certificate number / issuer','Inspection date / validity','Limitations / capacity','Next inspection due','Verified by / evidence location']),
  _DocSpec('Contractor & Equipment','Lifting Gear Register',['Gear ID / type / WLL','Serial number / color code','Certificate / inspection date','Condition / quarantine status','Next examination due','Competent person']),
  _DocSpec('Contractor & Equipment','Vehicle & Mobile Plant Daily Inspection',['Vehicle / plant ID','Operator / license','Brakes / steering / tires','Reverse alarm / lights / seatbelt','Leaks / attachments / defects','Safe-to-use decision / supervisor']),
  _DocSpec('Reporting & Document Control','Daily HSE Report',['Date / shift / weather','Workforce / manhours','Activities / permits','Inspections / observations','Incidents / near misses','Training / toolbox talks','Environment / stop-work / actions']),
  _DocSpec('Reporting & Document Control','Monthly HSE Performance Report',['Reporting period / manhours','Incident categories and definitions','Leading / lagging indicators','Training / audit / inspection data','Overdue actions / trends','Lessons / targets / approvals']),
  _DocSpec('Reporting & Document Control','HSE Statistics & KPI Dashboard Register',['KPI definition','Numerator / denominator','Reporting period / data source','Calculation / trend','Target / variance','Owner / validation']),
  _DocSpec('Reporting & Document Control','HSE Document Register & Revision Log',['Document title / number','Owner / current revision','Issue / review / approval dates','Distribution / controlled copies','Change summary','Obsolete copy withdrawal']),
  _DocSpec('Reporting & Document Control','HSE Management Review Minutes',['Meeting date / attendees','Previous action status','Performance / audit / incident trends','Changes / risks / resources','Decisions and actions','Owner / due date / approval']),
];

class _HseOfficeDocumentsPageState extends State<HseOfficeDocumentsPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  int _selected = 0;
  String _stage = 'Prepare';
  String _status = 'Draft';

  _DocSpec get _doc => _docs[_selected];
  TextEditingController _controller(String key) => _controllers.putIfAbsent(key, () => TextEditingController());
  List<String> get _allFields => [..._common, ..._doc.fields];

  @override
  void dispose() { for (final c in _controllers.values) { c.dispose(); } super.dispose(); }

  String _body() => [
    'SafeNexus HSE — ${_doc.title}',
    'Category: ${_doc.category}',
    'Workflow: $_stage | Status: $_status',
    for (final k in _allFields) '$k:\n${_controller('${_selected}_$k').text.trim().isEmpty ? 'Not entered' : _controller('${_selected}_$k').text.trim()}',
    'Generated: ${DateTime.now().toIso8601String()}',
    'CONTROL: Draft does not authorize work. Verify actual site conditions, applicable requirements, permits, isolations, competent review and required client/consultant approval before work starts.'
  ].join('\n\n');

  Future<File> _save(String ext, List<int> bytes) async {
    final dir = await getApplicationDocumentsDirectory();
    final name = _doc.title.replaceAll(RegExp(r'[^A-Za-z0-9_-]+'), '_');
    final f = File('${dir.path}/${name}_Rev${_controller('${_selected}_Revision').text.trim().isEmpty ? '0' : _controller('${_selected}_Revision').text.trim()}.$ext');
    await f.writeAsBytes(bytes, flush: true);
    return f;
  }

  Future<void> _pdf() async {
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(pageFormat: PdfPageFormat.a4, build: (_) => [
      pw.Header(level: 0, child: pw.Text(_doc.title)),
      pw.Text('Category: ${_doc.category} | Stage: $_stage | Status: $_status'),
      pw.SizedBox(height: 10),
      for (final k in _allFields) pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text(k, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(_controller('${_selected}_$k').text.trim().isEmpty ? 'Not entered' : _controller('${_selected}_$k').text),
        pw.SizedBox(height: 7),
      ]),
      pw.Divider(),
      pw.Text('Draft only: verify site conditions and obtain required competent-person and client/consultant approvals before work.'),
    ]));
    final f = await _save('pdf', await pdf.save());
    await Share.shareXFiles([XFile(f.path)], text: _doc.title);
  }

  Future<void> _xlsx() async {
    final excel = Excel.createExcel();
    final sheet = excel['${_doc.title.substring(0, _doc.title.length > 28 ? 28 : _doc.title.length)}'];
    sheet.appendRow([TextCellValue('Field'), TextCellValue('Site-specific entry')]);
    for (final k in _allFields) sheet.appendRow([TextCellValue(k), TextCellValue(_controller('${_selected}_$k').text)]);
    sheet.appendRow([TextCellValue('Workflow'), TextCellValue('$_stage / $_status')]);
    final bytes = excel.encode();
    if (bytes == null) return;
    final f = await _save('xlsx', bytes);
    await Share.shareXFiles([XFile(f.path)], text: '${_doc.title} Excel');
  }

  String _rtf(String s) => s.replaceAll(r'\', r'\\').replaceAll('{', r'\{').replaceAll('}', r'\}').replaceAll('\n', r'\line ');
  Future<void> _word() async {
    final b = StringBuffer(r'{\rtf1\ansi\deff0 ');
    b.write('{\\b ${_rtf(_doc.title)}}\\par Category: ${_rtf(_doc.category)}\\par Stage: ${_rtf(_stage)} | Status: ${_rtf(_status)}\\par\\par ');
    for (final k in _allFields) b.write('{\\b ${_rtf(k)}:}\\par ${_rtf(_controller('${_selected}_$k').text.isEmpty ? 'Not entered' : _controller('${_selected}_$k').text)}\\par\\par ');
    b.write(r'\par Draft only: verify site conditions and obtain required approvals before work.}');
    final f = await _save('rtf', b.toString().codeUnits);
    await Share.shareXFiles([XFile(f.path)], text: '${_doc.title} editable Word-compatible file');
  }

  Future<void> _saveShare() async {
    final f = await _save('txt', _body().codeUnits);
    await Share.shareXFiles([XFile(f.path)], text: '${_doc.title} saved draft');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Office Documents & Templates')),
    body: Form(key: _formKey, child: ListView(padding: const EdgeInsets.all(16), children: [
      Text('${_docs.length} document-specific forms', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 8),
      DropdownButtonFormField<int>(
        initialValue: _selected,
        isExpanded: true,
        decoration: const InputDecoration(labelText: 'Select HSE document', border: OutlineInputBorder()),
        items: List.generate(_docs.length, (i) => DropdownMenuItem(value: i, child: Text('${i + 1}. ${_docs[i].title}', overflow: TextOverflow.ellipsis))),
        onChanged: (v) => setState(() => _selected = v ?? 0),
      ),
      const SizedBox(height: 8),
      Text(_doc.category, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
      DropdownButtonFormField<String>(
        initialValue: _stage,
        decoration: const InputDecoration(labelText: 'Workflow stage'),
        items: ['Prepare','Review','Approve','Ready for issue','Work closeout'].map((s) => DropdownMenuItem(value:s, child:Text(s))).toList(),
        onChanged: (v) => setState(() => _stage = v ?? 'Prepare'),
      ),
      DropdownButtonFormField<String>(
        initialValue: _status,
        decoration: const InputDecoration(labelText: 'Document status'),
        items: ['Draft','Under Review','Comments Returned','Approved','Rejected','Closed'].map((s) => DropdownMenuItem(value:s, child:Text(s))).toList(),
        onChanged: (v) => setState(() => _status = v ?? 'Draft'),
      ),
      const SizedBox(height: 12),
      Card(color: Theme.of(context).colorScheme.surfaceContainerHighest, child: const Padding(padding: EdgeInsets.all(12), child: Text('Complete actual project and work details. Review and required approvals must be completed before work starts.'))),
      for (final k in _allFields) Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextFormField(
          controller: _controller('${_selected}_$k'),
          minLines: (k.toLowerCase().contains('hazard') || k.toLowerCase().contains('control') || k.toLowerCase().contains('scope') || k.toLowerCase().contains('sequence') || k.toLowerCase().contains('arrangement') || k.toLowerCase().contains('action') || k.toLowerCase().contains('finding') || k.toLowerCase().contains('review') || k.toLowerCase().contains('method')) ? 3 : 1,
          maxLines: 6,
          decoration: InputDecoration(labelText: k, border: const OutlineInputBorder(), alignLabelWithHint: true),
        ),
      ),
      const Text('Export selected document', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      Wrap(spacing: 8, runSpacing: 8, children: [
        FilledButton.icon(onPressed: _pdf, icon: const Icon(Icons.picture_as_pdf), label: const Text('PDF')),
        FilledButton.icon(onPressed: _word, icon: const Icon(Icons.description), label: const Text('Word')),
        FilledButton.icon(onPressed: _xlsx, icon: const Icon(Icons.table_chart), label: const Text('Excel')),
        OutlinedButton.icon(onPressed: _saveShare, icon: const Icon(Icons.save), label: const Text('Save & Share')),
      ]),
      const SizedBox(height: 12),
      const Text('Generated documents remain drafts until verified and approved by authorized persons.'),
    ])),
  );
}
