import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InspectionAuditPage extends StatefulWidget {
  const InspectionAuditPage({super.key});

  @override
  State<InspectionAuditPage> createState() => _InspectionAuditPageState();
}

class _InspectionAuditPageState extends State<InspectionAuditPage> {
  static const String storageKey = 'safenexus_hse_inspection_audit';
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  List<Map<String, dynamic>> records = [];
  String search = '';
  String statusFilter = 'All';
  String typeFilter = 'All';

  final List<String> types = const [
    'HSE Inspection',
    'Site Safety Inspection',
    'Equipment / Machinery Inspection',
    'Environmental Inspection',
    'Legal / Compliance Audit',
    'Internal HSE Audit',
    'Management Inspection',
    'Special Inspection',
    'Other',
  ];

  final List<String> statuses = const [
    'Planned',
    'Open',
    'In Progress',
    'Action Required',
    'Verification Required',
    'Completed',
    'Closed',
    'Cancelled',
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
      final matchesSearch = q.isEmpty || text.contains(q);
      final matchesStatus =
          statusFilter == 'All' || r['status'] == statusFilter;
      final matchesType = typeFilter == 'All' || r['type'] == typeFilter;
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  int _count(String status) =>
      records.where((r) => r['status'] == status).length;

  bool _isOverdue(Map<String, dynamic> r) {
    final due = DateTime.tryParse('${r['actionDue'] ?? ''}');
    if (due == null) return false;
    final status = '${r['status'] ?? ''}';
    return due.isBefore(DateTime.now()) &&
        status != 'Completed' &&
        status != 'Closed' &&
        status != 'Cancelled';
  }

  int get overdueCount => records.where(_isOverdue).length;

  Future<void> _openForm({Map<String, dynamic>? existing, int? index}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _InspectionForm(
        types: types,
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
        title: const Text('Delete Record?'),
        content: const Text('This inspection/audit record will be deleted.'),
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

  void _details(Map<String, dynamic> r) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _DetailsSheet(record: r),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visible = filtered;
    return Scaffold(
      appBar: AppBar(
        title: const Text('13. Inspection & Audit'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Record'),
      ),
      body: Column(
        children: [
          _Dashboard(
            total: records.length,
            open: _count('Open'),
            actions: _count('Action Required'),
            verification: _count('Verification Required'),
            closed: _count('Closed'),
            overdue: overdueCount,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
            child: Column(
              children: [
                TextField(
                  onChanged: (v) => setState(() => search = v),
                  decoration: const InputDecoration(
                    labelText: 'Search inspections / audits',
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
                        initialValue: typeFilter,
                        decoration: const InputDecoration(
                          labelText: 'Type',
                          border: OutlineInputBorder(),
                        ),
                        items: ['All', ...types]
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => typeFilter = v ?? 'All'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: visible.isEmpty
                ? const Center(
                    child: Text('No inspection / audit records found.'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
                    itemCount: visible.length,
                    itemBuilder: (_, i) {
                      final r = visible[i];
                      final realIndex = records.indexOf(r);
                      final overdue = _isOverdue(r);
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                overdue ? Colors.red : primaryGreen,
                            child: Icon(
                              overdue ? Icons.warning : Icons.fact_check,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            '${r['inspectionNo'] ?? ''} • ${r['title'] ?? ''}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            '${r['type'] ?? ''}\n'
                            '${r['project'] ?? ''} • ${r['site'] ?? ''}\n'
                            'Status: ${r['status'] ?? ''}'
                            '${overdue ? ' • OVERDUE' : ''}',
                          ),
                          isThreeLine: true,
                          onTap: () => _details(r),
                          trailing: PopupMenuButton<String>(
                            onSelected: (v) {
                              if (v == 'edit') {
                                _openForm(
                                  existing: Map<String, dynamic>.from(r),
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
  final int open;
  final int actions;
  final int verification;
  final int closed;
  final int overdue;

  const _Dashboard({
    required this.total,
    required this.open,
    required this.actions,
    required this.verification,
    required this.closed,
    required this.overdue,
  });

  @override
  Widget build(BuildContext context) {
    final data = [
      ('Total', total, Icons.list_alt),
      ('Open', open, Icons.folder_open),
      ('Actions', actions, Icons.assignment_late),
      ('Verify', verification, Icons.verified),
      ('Closed', closed, Icons.check_circle),
      ('Overdue', overdue, Icons.warning),
    ];
    return SizedBox(
      height: 104,
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final item = data[i];
          return Card(
            child: SizedBox(
              width: 100,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item.$3),
                    const SizedBox(height: 4),
                    Text(
                      '${item.$2}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      item.$1,
                      style: const TextStyle(fontSize: 11),
                    ),
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

class _InspectionForm extends StatefulWidget {
  final List<String> types;
  final List<String> statuses;
  final Map<String, dynamic>? existing;

  const _InspectionForm({
    required this.types,
    required this.statuses,
    this.existing,
  });

  @override
  State<_InspectionForm> createState() => _InspectionFormState();
}

class _InspectionFormState extends State<_InspectionForm> {
  final formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> c;
  late String type;
  late String status;

  @override
  void initState() {
    super.initState();
    final r = widget.existing ?? {};
    c = {
      'inspectionNo': TextEditingController(text: '${r['inspectionNo'] ?? ''}'),
      'title': TextEditingController(text: '${r['title'] ?? ''}'),
      'project': TextEditingController(text: '${r['project'] ?? ''}'),
      'site': TextEditingController(text: '${r['site'] ?? ''}'),
      'location': TextEditingController(text: '${r['location'] ?? ''}'),
      'department': TextEditingController(text: '${r['department'] ?? ''}'),
      'activity': TextEditingController(text: '${r['activity'] ?? ''}'),
      'inspector': TextEditingController(text: '${r['inspector'] ?? ''}'),
      'auditLead': TextEditingController(text: '${r['auditLead'] ?? ''}'),
      'date': TextEditingController(text: '${r['date'] ?? ''}'),
      'dueDate': TextEditingController(text: '${r['actionDue'] ?? ''}'),
      'scope': TextEditingController(text: '${r['scope'] ?? ''}'),
      'findings': TextEditingController(text: '${r['findings'] ?? ''}'),
      'positiveObservations':
          TextEditingController(text: '${r['positiveObservations'] ?? ''}'),
      'nonConformities':
          TextEditingController(text: '${r['nonConformities'] ?? ''}'),
      'correctiveAction':
          TextEditingController(text: '${r['correctiveAction'] ?? ''}'),
      'actionOwner':
          TextEditingController(text: '${r['actionOwner'] ?? ''}'),
      'verification':
          TextEditingController(text: '${r['verification'] ?? ''}'),
      'evidence': TextEditingController(text: '${r['evidence'] ?? ''}'),
      'references':
          TextEditingController(text: '${r['references'] ?? ''}'),
      'riskRef': TextEditingController(text: '${r['riskRef'] ?? ''}'),
      'ptwRef': TextEditingController(text: '${r['ptwRef'] ?? ''}'),
      'ramsRef': TextEditingController(text: '${r['ramsRef'] ?? ''}'),
      'equipmentRef':
          TextEditingController(text: '${r['equipmentRef'] ?? ''}'),
      'trainingRef':
          TextEditingController(text: '${r['trainingRef'] ?? ''}'),
      'remarks': TextEditingController(text: '${r['remarks'] ?? ''}'),
    };
    type = widget.types.contains(r['type']) ? r['type'] as String : widget.types.first;
    status = widget.statuses.contains(r['status'])
        ? r['status'] as String
        : widget.statuses.first;
  }

  @override
  void dispose() {
    for (final x in c.values) {
      x.dispose();
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

  Widget field(String key, String label, {int maxLines = 1, bool required = false}) {
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
            ? (v) => (v == null || v.trim().isEmpty) ? 'Required' : null
            : null,
      ),
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
          height: MediaQuery.of(context).size.height * 0.92,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  'Inspection / Audit Record',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView(
                    children: [
                      field('inspectionNo', 'Inspection / Audit No.', required: true),
                      field('title', 'Title', required: true),
                      DropdownButtonFormField<String>(
                        initialValue: type,
                        decoration: const InputDecoration(
                          labelText: 'Inspection / Audit Type',
                          border: OutlineInputBorder(),
                        ),
                        items: widget.types
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) => setState(() => type = v ?? type),
                      ),
                      const SizedBox(height: 10),
                      field('project', 'Project'),
                      field('site', 'Site'),
                      field('location', 'Location'),
                      field('department', 'Department'),
                      field('activity', 'Work Activity'),
                      field('inspector', 'Inspector'),
                      field('auditLead', 'Audit Lead / HSE Manager'),
                      Row(
                        children: [
                          Expanded(
                            child: field('date', 'Inspection Date'),
                          ),
                          IconButton(
                            onPressed: () => _pickDate('date'),
                            icon: const Icon(Icons.calendar_month),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: field('dueDate', 'Action Due Date'),
                          ),
                          IconButton(
                            onPressed: () => _pickDate('dueDate'),
                            icon: const Icon(Icons.event),
                          ),
                        ],
                      ),
                      DropdownButtonFormField<String>(
                        initialValue: status,
                        decoration: const InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder(),
                        ),
                        items: widget.statuses
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) => setState(() => status = v ?? status),
                      ),
                      const SizedBox(height: 10),
                      field('scope', 'Scope / Inspection Plan', maxLines: 3),
                      field('findings', 'Findings / Observations', maxLines: 4),
                      field('positiveObservations', 'Positive Observations', maxLines: 3),
                      field('nonConformities', 'Non-Conformities / Gaps', maxLines: 3),
                      field('correctiveAction', 'Corrective Action / CAPA', maxLines: 4),
                      field('actionOwner', 'Action Owner'),
                      field('verification', 'Verification / Closure Evidence', maxLines: 3),
                      field('evidence', 'Evidence / Document Reference', maxLines: 3),
                      field('references', 'Applicable Standards / Requirements', maxLines: 3),
                      field('riskRef', 'Risk / HIRA / JSA Reference'),
                      field('ptwRef', 'PTW Reference'),
                      field('ramsRef', 'RAMS / Method Statement Reference'),
                      field('equipmentRef', 'Equipment / Machinery Reference'),
                      field('trainingRef', 'Training / Competency Reference'),
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
                      result['type'] = type;
                      result['status'] = status;
                      result['actionDue'] = c['dueDate']!.text.trim();
                      Navigator.pop(context, result);
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Save Record'),
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
          height: MediaQuery.of(context).size.height * 0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${record['inspectionNo'] ?? ''} • ${record['title'] ?? ''}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: entries.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, i) {
                    final e = entries[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 125,
                            child: Text(
                              _label(e.key),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(child: Text('${e.value}')),
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
        .map((e) => e.isEmpty ? e : '${e[0].toUpperCase()}${e.substring(1)}')
        .join(' ');
  }
}
