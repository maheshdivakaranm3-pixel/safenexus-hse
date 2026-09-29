import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Local editable working form for an environmental office document.
/// Project-specific legal/permit applicability and approval remain subject to verification.
class EnvironmentalEditableDocumentPage extends StatefulWidget {
  const EnvironmentalEditableDocumentPage({super.key, required this.name, required this.group});
  final String name;
  final String group;

  @override
  State<EnvironmentalEditableDocumentPage> createState() => _EnvironmentalEditableDocumentPageState();
}

class _EnvironmentalEditableDocumentPageState extends State<EnvironmentalEditableDocumentPage> {
  static const green = Color(0xFF0B5D4B);
  static const fields = <String>[
    'Project name', 'Project number / contract', 'Company / contractor',
    'Client', 'Consultant / Engineer', 'Site / location', 'Document ID',
    'Revision', 'Issue date', 'Prepared by', 'Reviewed by', 'Approved by',
    'Applicable authority / permit condition', 'Activity / environmental aspect',
    'Description / findings', 'Controls / action required', 'Responsible person',
    'Target date', 'Evidence / attachment reference', 'Status / close-out notes',
  ];
  final Map<String, TextEditingController> controllers = {};
  bool loading = true;
  bool saving = false;
  String get storageKey => 'env_doc_${widget.name.hashCode}';

  @override
  void initState() {
    super.initState();
    for (final field in fields) { controllers[field] = TextEditingController(); }
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
      const SnackBar(content: Text('Draft saved on this device.')),
    );
  }

  @override
  void dispose() {
    for (final controller in controllers.values) { controller.dispose(); }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF4F8F6),
    appBar: AppBar(
      title: const Text('Editable Document Template'),
      backgroundColor: green, foregroundColor: Colors.white,
      actions: [IconButton(
        tooltip: 'Save draft', onPressed: loading || saving ? null : _save,
        icon: saving ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.save_outlined),
      )],
    ),
    body: loading
      ? const Center(child: CircularProgressIndicator())
      : ListView(padding: const EdgeInsets.all(16), children: [
        Card(color: const Color(0xFFE5F3EC), elevation: 0, child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.name, style: const TextStyle(color: green, fontSize: 20, fontWeight: FontWeight.w900)),
            const SizedBox(height: 6),
            Text(widget.group, style: const TextStyle(color: green)),
            const SizedBox(height: 8),
            const Text('Editable working draft. Complete only applicable fields, attach controlled evidence in the project document system, and obtain required review/approval before issue. This local draft is not an authority permit or approved record.'),
          ]),
        )),
        const SizedBox(height: 10),
        ...fields.map((field) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextField(
            controller: controllers[field],
            minLines: field == 'Description / findings' || field == 'Controls / action required' || field == 'Evidence / attachment reference' || field == 'Status / close-out notes' ? 3 : 1,
            maxLines: field == 'Description / findings' || field == 'Controls / action required' || field == 'Evidence / attachment reference' || field == 'Status / close-out notes' ? 5 : 1,
            decoration: InputDecoration(
              labelText: field,
              alignLabelWithHint: true,
              filled: true, fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
        )),
        const SizedBox(height: 8),
        FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: green, padding: const EdgeInsets.symmetric(vertical: 14)),
          onPressed: saving ? null : _save,
          icon: const Icon(Icons.save_outlined),
          label: Text(saving ? 'Saving…' : 'Save Draft'),
        ),
        const SizedBox(height: 12),
        const Text('Saved drafts remain on this device using the app’s local preferences. Export, multi-user sync and controlled document approval are not included in this form yet.'),
      ]),
  );
}
