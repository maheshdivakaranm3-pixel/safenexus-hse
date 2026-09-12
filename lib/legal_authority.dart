import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LegalAuthorityPage extends StatefulWidget {
  const LegalAuthorityPage({super.key});

  @override
  State<LegalAuthorityPage> createState() => _LegalAuthorityPageState();
}

class _LegalAuthorityPageState extends State<LegalAuthorityPage> {
  static const String storageKey = 'safenexus_hse_legal_authority';
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  List<Map<String, dynamic>> records = [];
  String search = '';
  String statusFilter = 'All';
  String jurisdictionFilter = 'All';
  String typeFilter = 'All';

  final jurisdictions = const [
    'UAE Federal',
    'Abu Dhabi',
    'Dubai',
    'Sharjah',
    'Ajman',
    'Umm Al Quwain',
    'Ras Al Khaimah',
    'Fujairah',
    'Other',
  ];

  final requirementTypes = const [
    'Federal Law',
    'Federal Decree-Law',
    'Cabinet Resolution',
    'Ministerial Decision',
    'Executive Regulation',
    'Authority Requirement',
    'Local Law',
    'Local Regulation',
    'Code of Practice',
    'Technical Standard',
    'Permit / License Condition',
    'Client Requirement',
    'Contractual Requirement',
    'Other',
  ];

  final categories = const [
    'HSE General',
    'Occupational Safety & Health',
    'Construction',
    'Fire & Life Safety',
    'Environmental',
    'Waste Management',
    'Electrical Safety',
    'Lifting & Rigging',
    'Work at Height',
    'Confined Space',
    'Excavation',
    'Chemical Safety',
    'Emergency Management',
    'Training & Competency',
    'Permit to Work',
    'Industrial Safety',
    'Traffic / Transport',
    'Welfare',
    'Legal / Regulatory',
    'Other',
  ];

  final statuses = const [
    'Compliant',
    'Partially Compliant',
    'Non-Compliant',
    'Under Review',
    'Action Required',
    'Not Applicable',
    'Superseded',
    'Closed',
  ];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);
    if (raw == null || raw.isEmpty) return;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        setState(() {
          records = decoded
              .whereType<Map>()
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        });
      }
    } catch (_) {}
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(records));
  }

  List<Map<String, dynamic>> get filtered {
    final q = search.trim().toLowerCase();
    return records.where((r) {
      final text = r.values.join(' ').toLowerCase();
      return (q.isEmpty || text.contains(q)) &&
          (statusFilter == 'All' || r['status'] == statusFilter) &&
          (jurisdictionFilter == 'All' ||
              r['jurisdiction'] == jurisdictionFilter) &&
          (typeFilter == 'All' || r['requirementType'] == typeFilter);
    }).toList();
  }

  int _count(String status) =>
      records.where((r) => r['status'] == status).length;

  bool _isOverdue(Map<String, dynamic> r) {
    final due = DateTime.tryParse('${r['nextReview'] ?? ''}');
    final status = '${r['status'] ?? ''}';
    return due != null &&
        due.isBefore(DateTime.now()) &&
        status != 'Compliant' &&
        status != 'Not Applicable' &&
        status != 'Superseded' &&
        status != 'Closed';
  }

  int get overdueCount => records.where(_isOverdue).length;

  Future<void> _openForm({Map<String, dynamic>? existing, int? index}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _LegalForm(
        jurisdictions: jurisdictions,
        requirementTypes: requirementTypes,
        categories: categories,
        statuses: statuses,
        existing: existing,
      ),
    );
    if (result == null) return;

    final now = DateTime.now().toIso8601String();
    result['updatedAt'] = now;
    if (index == null) {
      result['id'] = now;
      result['createdAt'] = now;
      records.insert(0, result);
    } else {
      result['id'] = records[index]['id'] ?? now;
      result['createdAt'] = records[index]['createdAt'] ?? now;
      records[index] = result;
    }
    await _save();
    if (mounted) setState(() {});
  }

  Future<void> _delete(int index) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Compliance Record?'),
        content: const Text('This legal / authority record will be deleted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    records.removeAt(index);
    await _save();
    if (mounted) setState(() {});
  }

  void _details(Map<String, dynamic> record) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _DetailsSheet(record: record),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visible = filtered;
    return Scaffold(
      appBar: AppBar(
        title: const Text('16. Legal / Authority'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.gavel),
        label: const Text('Add Requirement'),
      ),
      body: Column(
        children: [
          _Dashboard(
            total: records.length,
            compliant: _count('Compliant'),
            partial: _count('Partially Compliant'),
            nonCompliant: _count('Non-Compliant'),
            review: _count('Under Review'),
            action: _count('Action Required'),
            overdue: overdueCount,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
            child: Column(
              children: [
                TextField(
                  onChanged: (v) => setState(() => search = v),
                  decoration: const InputDecoration(
                    labelText: 'Search legal / authority requirements',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: statusFilter,
                        decoration: const InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder(),
                        ),
                        items: ['All', ...statuses]
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => statusFilter = v ?? 'All'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: jurisdictionFilter,
                        decoration: const InputDecoration(
                          labelText: 'Jurisdiction',
                          border: OutlineInputBorder(),
                        ),
                        items: ['All', ...jurisdictions]
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (v) => setState(
                          () => jurisdictionFilter = v ?? 'All',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: typeFilter,
                  decoration: const InputDecoration(
                    labelText: 'Requirement Type',
                    border: OutlineInputBorder(),
                  ),
                  items: ['All', ...requirementTypes]
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (v) =>
                      setState(() => typeFilter = v ?? 'All'),
                ),
              ],
            ),
          ),
          Expanded(
            child: visible.isEmpty
                ? const Center(
                    child: Text('No legal / authority records found.'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
                    itemCount: visible.length,
                    itemBuilder: (_, i) {
                      final record = visible[i];
                      final realIndex = records.indexOf(record);
                      final overdue = _isOverdue(record);
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                overdue ? Colors.red : primaryGreen,
                            child: Icon(
                              overdue ? Icons.warning : Icons.gavel,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            '${record['registerNo'] ?? ''} • ${record['title'] ?? ''}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            '${record['jurisdiction'] ?? ''} • ${record['requirementType'] ?? ''}\n'
                            '${record['authority'] ?? ''} • ${record['category'] ?? ''}\n'
                            'Status: ${record['status'] ?? ''}'
                            '${overdue ? ' • OVERDUE' : ''}',
                          ),
                          isThreeLine: true,
                          onTap: () => _details(record),
                          trailing: PopupMenuButton<String>(
                            onSelected: (v) {
                              if (v == 'edit') {
                                _openForm(
                                  existing:
                                      Map<String, dynamic>.from(record),
                                  index: realIndex,
                                );
                              } else if (v == 'delete') {
                                _delete(realIndex);
                              }
                            },
                            itemBuilder: (_) => const [
                              PopupMenuItem(
                                value: 'edit',
                                child: Text('Edit'),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _Dashboard extends StatelessWidget {
  final int total;
  final int compliant;
  final int partial;
  final int nonCompliant;
  final int review;
  final int action;
  final int overdue;

  const _Dashboard({
    required this.total,
    required this.compliant,
    required this.partial,
    required this.nonCompliant,
    required this.review,
    required this.action,
    required this.overdue,
  });

  @override
  Widget build(BuildContext context) {
    final data = [
      ('Total', total, Icons.list_alt),
      ('Compliant', compliant, Icons.check_circle),
      ('Partial', partial, Icons.warning_amber),
      ('Non-Compliant', nonCompliant, Icons.error),
      ('Review', review, Icons.rate_review),
      ('Actions', action, Icons.assignment_late),
      ('Overdue', overdue, Icons.warning),
    ];
    return SizedBox(
      height: 106,
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final item = data[i];
          return Card(
            child: SizedBox(
              width: 104,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item.$3),
                    const SizedBox(height: 3),
                    Text(
                      '${item.$2}',
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(item.$1, style: const TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LegalForm extends StatefulWidget {
  final List<String> jurisdictions;
  final List<String> requirementTypes;
  final List<String> categories;
  final List<String> statuses;
  final Map<String, dynamic>? existing;

  const _LegalForm({
    required this.jurisdictions,
    required this.requirementTypes,
    required this.categories,
    required this.statuses,
    this.existing,
  });

  @override
  State<_LegalForm> createState() => _LegalFormState();
}

class _LegalFormState extends State<_LegalForm> {
  final formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> c;
  late String jurisdiction;
  late String requirementType;
  late String category;
  late String status;

  @override
  void initState() {
    super.initState();
    final r = widget.existing ?? {};
    c = {
      'registerNo': TextEditingController(text: '${r['registerNo'] ?? ''}'),
      'title': TextEditingController(text: '${r['title'] ?? ''}'),
      'authority': TextEditingController(text: '${r['authority'] ?? ''}'),
      'lawReference':
          TextEditingController(text: '${r['lawReference'] ?? ''}'),
      'versionRevision':
          TextEditingController(text: '${r['versionRevision'] ?? ''}'),
      'applicableActivity':
          TextEditingController(text: '${r['applicableActivity'] ?? ''}'),
      'department':
          TextEditingController(text: '${r['department'] ?? ''}'),
      'requirement':
          TextEditingController(text: '${r['requirement'] ?? ''}'),
      'applicability':
          TextEditingController(text: '${r['applicability'] ?? ''}'),
      'complianceEvidence':
          TextEditingController(text: '${r['complianceEvidence'] ?? ''}'),
      'responsibleOwner':
          TextEditingController(text: '${r['responsibleOwner'] ?? ''}'),
      'lastReview':
          TextEditingController(text: '${r['lastReview'] ?? ''}'),
      'nextReview':
          TextEditingController(text: '${r['nextReview'] ?? ''}'),
      'gap':
          TextEditingController(text: '${r['gap'] ?? ''}'),
      'correctiveAction':
          TextEditingController(text: '${r['correctiveAction'] ?? ''}'),
      'actionOwner':
          TextEditingController(text: '${r['actionOwner'] ?? ''}'),
      'actionDue':
          TextEditingController(text: '${r['actionDue'] ?? ''}'),
      'permitLicense':
          TextEditingController(text: '${r['permitLicense'] ?? ''}'),
      'clientRequirement':
          TextEditingController(text: '${r['clientRequirement'] ?? ''}'),
      'evidenceLocation':
          TextEditingController(text: '${r['evidenceLocation'] ?? ''}'),
      'authorityContact':
          TextEditingController(text: '${r['authorityContact'] ?? ''}'),
      'notificationReference':
          TextEditingController(text: '${r['notificationReference'] ?? ''}'),
      'reviewFindings':
          TextEditingController(text: '${r['reviewFindings'] ?? ''}'),
      'remarks':
          TextEditingController(text: '${r['remarks'] ?? ''}'),
    };

    jurisdiction = widget.jurisdictions.contains(r['jurisdiction'])
        ? r['jurisdiction'] as String
        : widget.jurisdictions.first;
    requirementType = widget.requirementTypes.contains(r['requirementType'])
        ? r['requirementType'] as String
        : widget.requirementTypes.first;
    category = widget.categories.contains(r['category'])
        ? r['category'] as String
        : widget.categories.first;
    status = widget.statuses.contains(r['status'])
        ? r['status'] as String
        : widget.statuses.first;
  }

  @override
  void dispose() {
    for (final controller in c.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDate(String key) async {
    final initial = DateTime.tryParse(c[key]!.text) ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: initial,
    );
    if (picked != null) {
      c[key]!.text = picked.toIso8601String().split('T').first;
    }
  }

  Widget field(
    String key,
    String label, {
    int maxLines = 1,
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: c[key],
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          border: const OutlineInputBorder(),
        ),
        validator: required
            ? (v) => v == null || v.trim().isEmpty ? 'Required' : null
            : null,
      ),
    );
  }

  Widget dateField(String key, String label) {
    return Row(
      children: [
        Expanded(child: field(key, label)),
        IconButton(
          onPressed: () => _pickDate(key),
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.94,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  'Legal / Authority Compliance Record',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView(
                    children: [
                      field('registerNo', 'Register No.', required: true),
                      field('title', 'Requirement Title', required: true),
                      DropdownButtonFormField<String>(
                        initialValue: jurisdiction,
                        decoration: const InputDecoration(
                          labelText: 'Jurisdiction',
                          border: OutlineInputBorder(),
                        ),
                        items: widget.jurisdictions
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => jurisdiction = v ?? jurisdiction),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: requirementType,
                        decoration: const InputDecoration(
                          labelText: 'Requirement Type',
                          border: OutlineInputBorder(),
                        ),
                        items: widget.requirementTypes
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) => setState(
                          () => requirementType = v ?? requirementType,
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: category,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                        ),
                        items: widget.categories
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => category = v ?? category),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: status,
                        decoration: const InputDecoration(
                          labelText: 'Compliance Status',
                          border: OutlineInputBorder(),
                        ),
                        items: widget.statuses
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => status = v ?? status),
                      ),
                      const SizedBox(height: 10),
                      field('authority', 'Authority / Regulator'),
                      field('lawReference', 'Law / Regulation / Reference No.'),
                      field('versionRevision', 'Version / Revision'),
                      field('applicableActivity', 'Applicable Activity'),
                      field('department', 'Department'),
                      field('requirement', 'Requirement / Obligation', maxLines: 4),
                      field('applicability', 'Applicability / Scope', maxLines: 3),
                      field('complianceEvidence', 'Compliance Evidence', maxLines: 3),
                      field('responsibleOwner', 'Compliance Owner'),
                      dateField('lastReview', 'Last Review Date'),
                      dateField('nextReview', 'Next Review Date'),
                      field('gap', 'Compliance Gap / Finding', maxLines: 3),
                      field('correctiveAction', 'Corrective Action', maxLines: 4),
                      field('actionOwner', 'Action Owner'),
                      dateField('actionDue', 'Action Due Date'),
                      field('permitLicense', 'Permit / License Reference'),
                      field('clientRequirement', 'Client / Contract Requirement', maxLines: 3),
                      field('evidenceLocation', 'Evidence Location / Document Ref', maxLines: 3),
                      field('authorityContact', 'Authority Contact / Portal Reference'),
                      field('notificationReference', 'Notification / Submission Reference'),
                      field('reviewFindings', 'Review Findings / Notes', maxLines: 4),
                      field('remarks', 'Remarks', maxLines: 3),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      final result = <String, dynamic>{};
                      for (final entry in c.entries) {
                        result[entry.key] = entry.value.text.trim();
                      }
                      result['jurisdiction'] = jurisdiction;
                      result['requirementType'] = requirementType;
                      result['category'] = category;
                      result['status'] = status;
                      Navigator.pop(context, result);
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Save Requirement'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailsSheet extends StatelessWidget {
  final Map<String, dynamic> record;

  const _DetailsSheet({required this.record});

  @override
  Widget build(BuildContext context) {
    final entries = record.entries
        .where((e) => e.value != null && '${e.value}'.trim().isNotEmpty)
        .toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.86,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${record['registerNo'] ?? ''} • ${record['title'] ?? ''}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${record['jurisdiction'] ?? ''} • '
                '${record['requirementType'] ?? ''} • '
                '${record['status'] ?? ''}',
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: entries.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, i) {
                    final entry = entries[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 140,
                            child: Text(
                              _label(entry.key),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(child: Text('${entry.value}')),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _label(String key) {
    return key
        .replaceAllMapped(
          RegExp(r'([a-z])([A-Z])'),
          (m) => '${m.group(1)} ${m.group(2)}',
        )
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (e) => e.isEmpty
              ? e
              : '${e[0].toUpperCase()}${e.substring(1)}',
        )
        .join(' ');
  }
}
