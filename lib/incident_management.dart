import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncidentManagementPage extends StatefulWidget {
  const IncidentManagementPage({super.key});

  @override
  State<IncidentManagementPage> createState() => _IncidentManagementPageState();
}

class _IncidentManagementPageState extends State<IncidentManagementPage> {
  static const String storageKey = 'safenexus_hse_incident_management';
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  List<Map<String, dynamic>> records = [];
  String search = '';
  String statusFilter = 'All';
  String typeFilter = 'All';
  String severityFilter = 'All';

  final List<String> types = const [
    'Incident',
    'Near Miss',
    'First Aid Case',
    'Medical Treatment Case',
    'Lost Time Injury',
    'Restricted Work Case',
    'Fatality',
    'Property Damage',
    'Equipment Damage',
    'Environmental Incident',
    'Fire / Emergency',
    'Vehicle / Traffic Incident',
    'Security Incident',
    'Unsafe Act / Condition',
    'Other',
  ];

  final List<String> severities = const [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  final List<String> statuses = const [
    'Reported',
    'Under Investigation',
    'Investigation Complete',
    'Action Required',
    'Verification Required',
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
      return (q.isEmpty || text.contains(q)) &&
          (statusFilter == 'All' || r['status'] == statusFilter) &&
          (typeFilter == 'All' || r['type'] == typeFilter) &&
          (severityFilter == 'All' || r['severity'] == severityFilter);
    }).toList();
  }

  int _count(String status) =>
      records.where((r) => r['status'] == status).length;

  int _severityCount(String severity) =>
      records.where((r) => r['severity'] == severity).length;

  bool _isOverdue(Map<String, dynamic> r) {
    final due = DateTime.tryParse('${r['actionDue'] ?? ''}');
    final status = '${r['status'] ?? ''}';
    return due != null &&
        due.isBefore(DateTime.now()) &&
        status != 'Closed' &&
        status != 'Cancelled';
  }

  int get overdueCount => records.where(_isOverdue).length;

  Future<void> _openForm({Map<String, dynamic>? existing, int? index}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _IncidentForm(
        types: types,
        severities: severities,
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
        title: const Text('Delete Incident Record?'),
        content: const Text('This incident record will be deleted.'),
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
        title: const Text('14. Incident Management'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Report Incident'),
      ),
      body: Column(
        children: [
          _Dashboard(
            total: records.length,
            reported: _count('Reported'),
            investigation: _count('Under Investigation'),
            actions: _count('Action Required'),
            closed: _count('Closed'),
            critical: _severityCount('Critical'),
            overdue: overdueCount,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
            child: Column(
              children: [
                TextField(
                  onChanged: (v) => setState(() => search = v),
                  decoration: const InputDecoration(
                    labelText: 'Search incidents / investigations',
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
                        initialValue: severityFilter,
                        decoration: const InputDecoration(
                          labelText: 'Severity',
                          border: OutlineInputBorder(),
                        ),
                        items: ['All', ...severities]
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => severityFilter = v ?? 'All'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: typeFilter,
                  decoration: const InputDecoration(
                    labelText: 'Incident Type',
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
              ],
            ),
          ),
          Expanded(
            child: visible.isEmpty
                ? const Center(child: Text('No incident records found.'))
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
                            backgroundColor: overdue ? Colors.red : primaryGreen,
                            child: Icon(
                              overdue ? Icons.warning : Icons.report,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            '${record['incidentNo'] ?? ''} • ${record['title'] ?? ''}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            '${record['type'] ?? ''} • ${record['severity'] ?? ''}\n'
                            '${record['project'] ?? ''} • ${record['site'] ?? ''}\n'
                            'Status: ${record['status'] ?? ''}'
                            '${overdue ? ' • OVERDUE' : ''}',
                          ),
                          isThreeLine: true,
                          onTap: () => _details(record),
                          trailing: PopupMenuButton<String>(
                            onSelected: (v) {
                              if (v == 'edit') {
                                _openForm(
                                  existing: Map<String, dynamic>.from(record),
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
  final int reported;
  final int investigation;
  final int actions;
  final int closed;
  final int critical;
  final int overdue;

  const _Dashboard({
    required this.total,
    required this.reported,
    required this.investigation,
    required this.actions,
    required this.closed,
    required this.critical,
    required this.overdue,
  });

  @override
  Widget build(BuildContext context) {
    final data = [
      ('Total', total, Icons.list_alt),
      ('Reported', reported, Icons.report),
      ('Investigation', investigation, Icons.search),
      ('Actions', actions, Icons.assignment_late),
      ('Closed', closed, Icons.check_circle),
      ('Critical', critical, Icons.priority_high),
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

class _IncidentForm extends StatefulWidget {
  final List<String> types;
  final List<String> severities;
  final List<String> statuses;
  final Map<String, dynamic>? existing;

  const _IncidentForm({
    required this.types,
    required this.severities,
    required this.statuses,
    this.existing,
  });

  @override
  State<_IncidentForm> createState() => _IncidentFormState();
}

class _IncidentFormState extends State<_IncidentForm> {
  final formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> c;
  late String type;
  late String severity;
  late String status;

  @override
  void initState() {
    super.initState();
    final r = widget.existing ?? {};
    c = {
      'incidentNo': TextEditingController(text: '${r['incidentNo'] ?? ''}'),
      'title': TextEditingController(text: '${r['title'] ?? ''}'),
      'project': TextEditingController(text: '${r['project'] ?? ''}'),
      'site': TextEditingController(text: '${r['site'] ?? ''}'),
      'location': TextEditingController(text: '${r['location'] ?? ''}'),
      'department': TextEditingController(text: '${r['department'] ?? ''}'),
      'workActivity': TextEditingController(text: '${r['workActivity'] ?? ''}'),
      'date': TextEditingController(text: '${r['date'] ?? ''}'),
      'time': TextEditingController(text: '${r['time'] ?? ''}'),
      'reportedBy': TextEditingController(text: '${r['reportedBy'] ?? ''}'),
      'injuredPerson': TextEditingController(text: '${r['injuredPerson'] ?? ''}'),
      'employeeId': TextEditingController(text: '${r['employeeId'] ?? ''}'),
      'company': TextEditingController(text: '${r['company'] ?? ''}'),
      'description': TextEditingController(text: '${r['description'] ?? ''}'),
      'immediateAction': TextEditingController(text: '${r['immediateAction'] ?? ''}'),
      'injuryDetails': TextEditingController(text: '${r['injuryDetails'] ?? ''}'),
      'propertyDamage': TextEditingController(text: '${r['propertyDamage'] ?? ''}'),
      'environmentalImpact': TextEditingController(text: '${r['environmentalImpact'] ?? ''}'),
      'witnesses': TextEditingController(text: '${r['witnesses'] ?? ''}'),
      'evidence': TextEditingController(text: '${r['evidence'] ?? ''}'),
      'investigator': TextEditingController(text: '${r['investigator'] ?? ''}'),
      'investigationDate': TextEditingController(text: '${r['investigationDate'] ?? ''}'),
      'rootCause': TextEditingController(text: '${r['rootCause'] ?? ''}'),
      'directCause': TextEditingController(text: '${r['directCause'] ?? ''}'),
      'underlyingCause': TextEditingController(text: '${r['underlyingCause'] ?? ''}'),
      'contributingFactors': TextEditingController(text: '${r['contributingFactors'] ?? ''}'),
      'lessonsLearned': TextEditingController(text: '${r['lessonsLearned'] ?? ''}'),
      'correctiveAction': TextEditingController(text: '${r['correctiveAction'] ?? ''}'),
      'preventiveAction': TextEditingController(text: '${r['preventiveAction'] ?? ''}'),
      'actionOwner': TextEditingController(text: '${r['actionOwner'] ?? ''}'),
      'actionDue': TextEditingController(text: '${r['actionDue'] ?? ''}'),
      'verification': TextEditingController(text: '${r['verification'] ?? ''}'),
      'closureDate': TextEditingController(text: '${r['closureDate'] ?? ''}'),
      'riskRef': TextEditingController(text: '${r['riskRef'] ?? ''}'),
      'ptwRef': TextEditingController(text: '${r['ptwRef'] ?? ''}'),
      'ramsRef': TextEditingController(text: '${r['ramsRef'] ?? ''}'),
      'trainingRef': TextEditingController(text: '${r['trainingRef'] ?? ''}'),
      'equipmentRef': TextEditingController(text: '${r['equipmentRef'] ?? ''}'),
      'authorityRef': TextEditingController(text: '${r['authorityRef'] ?? ''}'),
      'remarks': TextEditingController(text: '${r['remarks'] ?? ''}'),
    };
    type = widget.types.contains(r['type'])
        ? r['type'] as String
        : widget.types.first;
    severity = widget.severities.contains(r['severity'])
        ? r['severity'] as String
        : widget.severities.first;
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
          height: MediaQuery.of(context).size.height * 0.93,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  'Incident / Investigation Record',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView(
                    children: [
                      field('incidentNo', 'Incident No.', required: true),
                      field('title', 'Incident Title', required: true),
                      DropdownButtonFormField<String>(
                        initialValue: type,
                        decoration: const InputDecoration(
                          labelText: 'Incident Type',
                          border: OutlineInputBorder(),
                        ),
                        items: widget.types
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) => setState(() => type = v ?? type),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: severity,
                        decoration: const InputDecoration(
                          labelText: 'Severity',
                          border: OutlineInputBorder(),
                        ),
                        items: widget.severities
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => severity = v ?? severity),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: status,
                        decoration: const InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder(),
                        ),
                        items: widget.statuses
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) => setState(() => status = v ?? status),
                      ),
                      const SizedBox(height: 10),
                      field('project', 'Project'),
                      field('site', 'Site'),
                      field('location', 'Location'),
                      field('department', 'Department'),
                      field('workActivity', 'Work Activity'),
                      field('company', 'Company / Contractor'),
                      Row(
                        children: [
                          Expanded(child: field('date', 'Incident Date')),
                          IconButton(
                            onPressed: () => _pickDate('date'),
                            icon: const Icon(Icons.calendar_month),
                          ),
                        ],
                      ),
                      field('time', 'Incident Time'),
                      field('reportedBy', 'Reported By'),
                      field('injuredPerson', 'Injured / Affected Person'),
                      field('employeeId', 'Employee / Worker ID'),
                      field('description', 'Incident Description', maxLines: 4),
                      field('immediateAction', 'Immediate Action Taken', maxLines: 4),
                      field('injuryDetails', 'Injury / Illness Details', maxLines: 3),
                      field('propertyDamage', 'Property / Equipment Damage', maxLines: 3),
                      field('environmentalImpact', 'Environmental Impact', maxLines: 3),
                      field('witnesses', 'Witnesses', maxLines: 3),
                      field('evidence', 'Evidence / Photos / Documents', maxLines: 3),
                      field('investigator', 'Investigator / Investigation Team'),
                      Row(
                        children: [
                          Expanded(
                            child: field(
                              'investigationDate',
                              'Investigation Date',
                            ),
                          ),
                          IconButton(
                            onPressed: () => _pickDate('investigationDate'),
                            icon: const Icon(Icons.calendar_month),
                          ),
                        ],
                      ),
                      field('directCause', 'Direct Cause', maxLines: 3),
                      field('underlyingCause', 'Underlying Cause', maxLines: 3),
                      field('contributingFactors', 'Contributing Factors', maxLines: 3),
                      field('rootCause', 'Root Cause / Root Cause Analysis', maxLines: 4),
                      field('lessonsLearned', 'Lessons Learned', maxLines: 4),
                      field('correctiveAction', 'Corrective Action', maxLines: 4),
                      field('preventiveAction', 'Preventive Action', maxLines: 4),
                      field('actionOwner', 'Action Owner'),
                      Row(
                        children: [
                          Expanded(child: field('actionDue', 'Action Due Date')),
                          IconButton(
                            onPressed: () => _pickDate('actionDue'),
                            icon: const Icon(Icons.event),
                          ),
                        ],
                      ),
                      field('verification', 'Action Verification / Closure Evidence', maxLines: 3),
                      Row(
                        children: [
                          Expanded(child: field('closureDate', 'Closure Date')),
                          IconButton(
                            onPressed: () => _pickDate('closureDate'),
                            icon: const Icon(Icons.event_available),
                          ),
                        ],
                      ),
                      field('riskRef', 'Risk / HIRA / JSA Reference'),
                      field('ptwRef', 'PTW Reference'),
                      field('ramsRef', 'RAMS / Method Statement Reference'),
                      field('trainingRef', 'Training / Competency Reference'),
                      field('equipmentRef', 'Equipment / Machinery Reference'),
                      field('authorityRef', 'Authority / Client Notification Reference'),
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
                      result['severity'] = severity;
                      result['status'] = status;
                      Navigator.pop(context, result);
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Save Incident'),
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
                '${record['incidentNo'] ?? ''} • ${record['title'] ?? ''}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${record['type'] ?? ''} • ${record['severity'] ?? ''} • ${record['status'] ?? ''}',
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
                            width: 130,
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
