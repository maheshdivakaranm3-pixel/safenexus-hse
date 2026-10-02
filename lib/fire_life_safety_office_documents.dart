import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireLifeSafetyOfficeDocumentsPage extends StatelessWidget {
  const FireLifeSafetyOfficeDocumentsPage({super.key});
  static const Color green = Color(0xFF0B5D4B);

  static const Map<String, List<String>> groups = {
    'Fire safety management & planning': [
      'Fire Safety Management Plan', 'Fire Prevention Plan', 'Fire Risk Assessment',
      'Fire Hazard Identification Register', 'Fire Safety Policy',
      'Fire Safety Responsibilities Matrix', 'Fire Safety Legal Compliance Register',
      'Fire Safety Document Master Register', 'Fire Safety Action Tracker',
      'Fire Safety Monthly Report',
    ],
    'Fire alarm & detection': [
      'Fire Alarm Inspection Checklist', 'Fire Alarm Testing Register',
      'Smoke Detector Inspection Record', 'Heat Detector Inspection Record',
      'Manual Call Point Inspection', 'Fire Alarm Fault Register',
      'Fire Alarm Maintenance Record', 'Fire Alarm Test Certificate Register',
    ],
    'Fire-fighting equipment': [
      'Fire Extinguisher Inspection Checklist', 'Fire Extinguisher Register',
      'Fire Extinguisher Service Record', 'Fire Hose Reel Inspection',
      'Fire Hydrant Inspection', 'Fire Pump Weekly Test Record',
      'Fire Pump Maintenance Register', 'Sprinkler System Inspection',
      'Emergency Lighting Inspection', 'Fire Equipment Defect Register',
    ],
    'Hot work & fire watch': [
      'Hot Work Permit', 'Hot Work Risk Assessment', 'Fire Watch Checklist',
      'Welding & Cutting Inspection', 'Gas Cylinder Inspection',
      'Fire Watch Attendance Register', 'Hot Work Permit Closure',
      'Post-Work Fire Monitoring Record',
    ],
    'Emergency, evacuation & drills': [
      'Emergency Response Plan', 'Fire Emergency Action Plan',
      'Emergency Contact Register', 'Evacuation Plan', 'Fire Drill Plan',
      'Fire Drill Attendance', 'Fire Drill Evaluation Report',
      'Assembly Point Register', 'Emergency Evacuation Headcount',
      'Emergency Incident Report', 'Fire Incident Investigation',
      'Corrective Action Register',
    ],
    'Fire warden, training & competency': [
      'Fire Warden Appointment Letter', 'Fire Warden Responsibility Matrix',
      'Fire Safety Training Matrix', 'Fire Safety Induction Record',
      'Fire Extinguisher Training Attendance', 'Fire Drill Training Record',
      'Competency & Certification Register',
    ],
    'Inspection, audit & handover': [
      'Daily Fire Safety Inspection', 'Weekly Fire Safety Inspection',
      'Monthly Fire Safety Audit', 'Fire Safety Non-Conformance Report',
      'Fire Safety Corrective Action Tracker', 'Fire Safety Audit Report',
      'Fire Safety Close-Out Report', 'Fire Safety Handover Dossier',
    ],
  };

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF4F8F6),
    appBar: AppBar(title: const Text('Fire Safety Office Documents'), backgroundColor: green, foregroundColor: Colors.white),
    body: ListView(padding: const EdgeInsets.all(14), children: [
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFFE5F3EC), borderRadius: BorderRadius.circular(15)), child: const Text(
        'Professional editable working forms and record guides. Complete with actual project information, supporting evidence and required review/approval. Confirm current UAE authority, Civil Defence, client and contract requirements before controlled issue.',
        style: TextStyle(color: Color(0xFF174D3D), height: 1.45))),
      const SizedBox(height: 12),
      ...groups.entries.map((group) => Card(elevation: 0, margin: const EdgeInsets.only(bottom: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: const BorderSide(color: Color(0xFFE0EAE5))), child: ExpansionTile(
        iconColor: green, collapsedIconColor: green,
        title: Text(group.key, style: const TextStyle(color: green, fontWeight: FontWeight.w800)),
        children: group.value.map((name) => ListTile(
          leading: const Icon(Icons.description_outlined, color: green), title: Text(name),
          trailing: const Icon(Icons.chevron_right, color: green),
          onTap: () => Navigator.push(context, MaterialPageRoute<void>(builder: (_) => FireEditableDocumentPage(name: name, group: group.key))),
        )).toList(),
      ))),
    ]),
  );
}

class FireEditableDocumentPage extends StatefulWidget {
  const FireEditableDocumentPage({super.key, required this.name, required this.group});
  final String name;
  final String group;
  @override
  State<FireEditableDocumentPage> createState() => _FireEditableDocumentPageState();
}

class _FireEditableDocumentPageState extends State<FireEditableDocumentPage> {
  static const Color green = Color(0xFF0B5D4B);
  static const List<String> fields = [
    'Company name', 'Company logo reference (reserved placement)',
    'Client name', 'Client logo reference (reserved placement)',
    'Consultant name', 'Consultant logo reference (reserved placement)',
    'Project / site name', 'Project / contract number', 'Site / work location',
    'Document title / reference number', 'Revision', 'Issue date',
    'Activity / system / equipment ID', 'Inspection / event date and time',
    'Purpose / scope / work details', 'Applicable criteria / authority / permit reference',
    'Inspection findings / observations', 'Risk / deficiency / incident details',
    'Immediate controls / corrective action required', 'Action owner / target completion date',
    'Evidence / photo / attachment references', 'Completion evidence / close-out date',
    'Prepared by (name / role / signature)', 'Reviewed by (name / role / signature)',
    'Approved by (name / role / signature, if required)', 'Review / approval dates',
    'Issue status (Draft / For Review / Approved / Superseded)',
    'Distribution / handover / retention notes',
  ];
  final Map<String, TextEditingController> controllers = {};
  bool loading = true, saving = false;
  String get keyBase => 'fire_doc_${widget.name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_')}';

  @override
  void initState() { super.initState(); for (final f in fields) { controllers[f] = TextEditingController(); } _load(); }
  Future<void> _load() async { final p = await SharedPreferences.getInstance(); for (final f in fields) { controllers[f]!.text = p.getString('$keyBase::$f') ?? ''; } if (mounted) setState(() => loading = false); }
  Future<void> _save() async { setState(() => saving = true); final p = await SharedPreferences.getInstance(); for (final f in fields) { await p.setString('$keyBase::$f', controllers[f]!.text); } if (!mounted) return; setState(() => saving = false); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Working draft saved on this device.'))); }
  @override
  void dispose() { for (final c in controllers.values) { c.dispose(); } super.dispose(); }
  bool _multi(String f) => f.contains('details') || f.contains('scope') || f.contains('findings') || f.contains('action') || f.contains('evidence') || f.contains('notes') || f.contains('reference');

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF4F8F6),
    appBar: AppBar(title: const Text('Editable Fire Safety Form'), backgroundColor: green, foregroundColor: Colors.white, actions: [IconButton(tooltip: 'Save draft', onPressed: loading || saving ? null : _save, icon: const Icon(Icons.save_outlined))]),
    body: loading ? const Center(child: CircularProgressIndicator()) : ListView(padding: const EdgeInsets.all(14), children: [
      Card(color: const Color(0xFFE5F3EC), elevation: 0, child: Padding(padding: const EdgeInsets.all(15), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(widget.name, style: const TextStyle(color: green, fontSize: 20, fontWeight: FontWeight.w900)),
        const SizedBox(height: 5), Text(widget.group, style: const TextStyle(color: green)),
        const SizedBox(height: 10),
        Row(children: [for (final label in ['Company Logo', 'Client Logo', 'Consultant Logo']) Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 3), child: Container(height: 62, decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xFF9DB8AC), style: BorderStyle.solid), borderRadius: BorderRadius.circular(8)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.image_outlined, color: green), Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: green))])))]),
        const SizedBox(height: 10), const Text('Logo boxes are reserved in this form layout. Add actual logo assets and export branding in the document package before formal issue.', style: TextStyle(fontSize: 12, height: 1.35)),
      ]))),
      ...fields.map((f) => Padding(padding: const EdgeInsets.only(bottom: 10), child: TextField(controller: controllers[f], minLines: _multi(f) ? 3 : 1, maxLines: _multi(f) ? 5 : 1, decoration: InputDecoration(labelText: f, alignLabelWithHint: true, filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none))))),
      FilledButton.icon(style: FilledButton.styleFrom(backgroundColor: green, padding: const EdgeInsets.symmetric(vertical: 14)), onPressed: saving ? null : _save, icon: const Icon(Icons.save_outlined), label: Text(saving ? 'Saving…' : 'Save Working Draft')),
      const SizedBox(height: 8), const Text('This build provides editable fields and on-device draft saving. PDF, Word and Excel export, logo image upload and approval routing are not yet implemented; do not treat a local draft as an approved permit or controlled record.', style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.4)),
    ]),
  );
}
