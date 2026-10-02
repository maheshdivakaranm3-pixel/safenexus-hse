import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Practical local working form. Project-specific legal and approval rules must
/// be confirmed before controlled issue.
class EnvironmentalEditableDocumentPage extends StatefulWidget {
  const EnvironmentalEditableDocumentPage({
    super.key,
    required this.name,
    required this.group,
  });
  final String name;
  final String group;

  @override
  State<EnvironmentalEditableDocumentPage> createState() =>
      _EnvironmentalEditableDocumentPageState();
}

class _EnvironmentalEditableDocumentPageState
    extends State<EnvironmentalEditableDocumentPage> {
  static const Color green = Color(0xFF0B5D4B);
  static const Map<String, List<String>> sectionFields = {
    'Project & document control': [
      'Project / site name', 'Project / contract number', 'Client',
      'Consultant', 'Main contractor / company', 'Site / work location',
      'Document title / reference number', 'Revision', 'Issue date',
      'Applicable authority / permit / contract reference',
    ],
    'Work details & evidence': [
      'Purpose / scope', 'Activity / environmental aspect / waste stream',
      'Location / date / time / monitoring period',
      'Applicable criteria / acceptance requirements',
      'Observed condition / data / quantities',
      'Risk / impact / non-compliance details',
      'Controls / method / action required',
      'Evidence references (photos, permits, lab reports, manifests)',
      'Attachments / drawing / register references',
    ],
    'Action & close-out': [
      'Action owner / responsible person', 'Target completion date',
      'Interim control / escalation', 'Completion evidence / actual date',
      'Verification / effectiveness result', 'Status / outstanding items',
      'Handover / close-out notes',
    ],
    'Review & approval workflow': [
      'Prepared by (name / role)', 'Prepared date',
      'Reviewed by (name / role)', 'Review date / comments',
      'Approved by (name / role, if required)', 'Approval date / reference',
      'Issue status (Draft / For Review / Approved / Superseded)',
      'Distribution / recipients', 'Next review trigger / retention basis',
    ],
  };

  final Map<String, TextEditingController> controllers = {};
  bool loading = true;
  bool saving = false;

  String _slug(String value) => value.toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
      .replaceAll(RegExp(r'^_|_$'), '');
  String get storageKey => 'env_workdoc_${_slug(widget.group)}_${_slug(widget.name)}';
  List<String> get fields => sectionFields.values.expand((e) => e).toList();

  @override
  void initState() {
    super.initState();
    for (final field in fields) {
      controllers[field] = TextEditingController();
    }
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    for (final field in fields) {
      controllers[field]!.text = prefs.getString('$storageKey::$field') ?? '';
    }
    if (mounted) setState(() => loading = false);
  }

  Future<void> _save() async {
    setState(() => saving = true);
    final prefs = await SharedPreferences.getInstance();
    for (final field in fields) {
      await prefs.setString('$storageKey::$field', controllers[field]!.text);
    }
    if (!mounted) return;
    setState(() => saving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Working draft saved on this device.')),
    );
  }

  @override
  void dispose() {
    for (final controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  bool _multiline(String field) => field.contains('details') ||
      field.contains('evidence') || field.contains('notes') ||
      field.contains('comments') || field.contains('scope') ||
      field.contains('controls') || field.contains('condition') ||
      field.contains('criteria') || field.contains('impact') ||
      field.contains('method') || field.contains('references') ||
      field.contains('recipients') || field.contains('trigger');

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF4F8F6),
    appBar: AppBar(
      title: const Text('Office Working Form'),
      backgroundColor: green,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          tooltip: 'Save working draft',
          onPressed: loading || saving ? null : _save,
          icon: const Icon(Icons.save_outlined),
        ),
      ],
    ),
    body: loading
      ? const Center(child: CircularProgressIndicator())
      : ListView(
          padding: const EdgeInsets.all(14),
          children: [
            Card(
              color: const Color(0xFFE5F3EC),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name, style: const TextStyle(
                      color: green, fontSize: 20, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 5),
                    Text(widget.group, style: const TextStyle(color: green)),
                    const SizedBox(height: 8),
                    const Text(
                      'Complete using actual project records and evidence. Route the document for review and approval where the contract, permit or company procedure requires it. A saved local draft is not an approved permit or controlled issue.',
                      style: TextStyle(height: 1.4)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            ...sectionFields.entries.map((section) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
                side: const BorderSide(color: Color(0xFFE0EAE5))),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(section.key, style: const TextStyle(
                      color: green, fontWeight: FontWeight.w800, fontSize: 16)),
                    const SizedBox(height: 12),
                    ...section.value.map((field) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextField(
                        controller: controllers[field],
                        minLines: _multiline(field) ? 3 : 1,
                        maxLines: _multiline(field) ? 5 : 1,
                        decoration: InputDecoration(
                          labelText: field,
                          alignLabelWithHint: true,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            )),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: green,
                padding: const EdgeInsets.symmetric(vertical: 14)),
              onPressed: saving ? null : _save,
              icon: const Icon(Icons.save_outlined),
              label: Text(saving ? 'Saving…' : 'Save Working Draft'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Current scope: editable fields and on-device draft saving. PDF / Word / Excel export, attachment handling, multi-user review routing and controlled approval are not yet implemented in this version.',
              style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.4)),
          ],
        ),
  );
}
