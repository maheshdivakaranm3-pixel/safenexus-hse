import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE
/// Step 18 - HSE Action Center & Cross-Module Follow-up
///
/// A single-file management center for open actions, overdue actions,
/// critical priorities, follow-up, verification and closure.
/// It is designed to sit above the 16 core phases without replacing them.

class HseActionCenterPage extends StatefulWidget {
  const HseActionCenterPage({super.key});

  @override
  State<HseActionCenterPage> createState() => _HseActionCenterPageState();
}

class _HseActionCenterPageState extends State<HseActionCenterPage> {
  static const String storageKey = 'safenexus_hse_step18_action_center';
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  List<Map<String, dynamic>> actions = [];
  String search = '';
  String statusFilter = 'All';
  String priorityFilter = 'All';
  String phaseFilter = 'All';

  final priorities = const ['Low', 'Medium', 'High', 'Critical'];
  final statuses = const [
    'Open',
    'In Progress',
    'Verification Required',
    'Completed',
    'Closed',
    'Cancelled',
  ];

  final phases = const [
    'Phase 1 - Project Pre-Start',
    'Phase 2 - HSE Management System',
    'Phase 3 - Risk & Planning',
    'Phase 4 - Permit to Work',
    'Phase 5 - Site Mobilization',
    'Phase 6 - Workforce & Competency',
    'Phase 7 - Equipment & Machinery',
    'Phase 8 - High-Risk Activities',
    'Phase 9 - Daily HSE Work',
    'Phase 10 - Emergency',
    'Phase 11 - Occupational Health',
    'Phase 12 - Chemical & Environment',
    'Phase 13 - Inspection & Audit',
    'Phase 14 - Incident Management',
    'Phase 15 - HSE Reporting',
    'Phase 16 - Legal / Authority',
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
          actions = decoded
              .whereType<Map>()
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        });
      }
    } catch (_) {}
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(actions));
  }

  List<Map<String, dynamic>> get filtered {
    final q = search.trim().toLowerCase();
    return actions.where((a) {
      final text = a.values.join(' ').toLowerCase();
      return (q.isEmpty || text.contains(q)) &&
          (statusFilter == 'All' || a['status'] == statusFilter) &&
          (priorityFilter == 'All' || a['priority'] == priorityFilter) &&
          (phaseFilter == 'All' || a['phase'] == phaseFilter);
    }).toList();
  }

  bool _isOverdue(Map<String, dynamic> a) {
    final due = DateTime.tryParse('${a['dueDate'] ?? ''}');
    final status = '${a['status'] ?? ''}';
    return due != null &&
        due.isBefore(DateTime.now()) &&
        status != 'Completed' &&
        status != 'Closed' &&
        status != 'Cancelled';
  }

  int _countStatus(String status) =>
      actions.where((a) => a['status'] == status).length;

  int _countPriority(String priority) =>
      actions.where((a) => a['priority'] == priority).length;

  int get overdueCount => actions.where(_isOverdue).length;

  int get activeCount => actions.where((a) {
        final s = '${a['status'] ?? ''}';
        return s != 'Completed' && s != 'Closed' && s != 'Cancelled';
      }).length;

  Future<void> _openForm({Map<String, dynamic>? existing, int? index}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _ActionForm(
        priorities: priorities,
        statuses: statuses,
        phases: phases,
        existing: existing,
      ),
    );
    if (result == null) return;

    final now = DateTime.now().toIso8601String();
    result['updatedAt'] = now;

    if (index == null) {
      result['id'] = now;
      result['createdAt'] = now;
      actions.insert(0, result);
    } else {
      result['id'] = actions[index]['id'] ?? now;
      result['createdAt'] = actions[index]['createdAt'] ?? now;
      actions[index] = result;
    }

    await _save();
    if (mounted) setState(() {});
  }

  Future<void> _delete(int index) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Action?'),
        content: const Text('This HSE action will be deleted.'),
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

    actions.removeAt(index);
    await _save();
    if (mounted) setState(() {});
  }

  Future<void> _markCompleted(int index) async {
    actions[index]['status'] = 'Completed';
    actions[index]['updatedAt'] = DateTime.now().toIso8601String();
    await _save();
    if (mounted) setState(() {});
  }

  void _showDetails(Map<String, dynamic> action) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _ActionDetails(action: action),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visible = filtered;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('18. HSE Action Center'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_task),
        label: const Text('Add Action'),
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
          children: [
            _headerCard(),
            const SizedBox(height: 12),
            _dashboard(),
            const SizedBox(height: 12),
            _priorityCard(),
            const SizedBox(height: 12),
            _filters(),
            const SizedBox(height: 8),
            if (visible.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(
                    child: Text('No HSE actions found.'),
                  ),
                ),
              )
            else
              ...visible.map((action) {
                final index = actions.indexOf(action);
                return _actionCard(action, index);
              }),
          ],
        ),
      ),
    );
  }

  Widget _headerCard() {
    return Card(
      color: darkGreen,
      child: const Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.track_changes, color: Colors.white, size: 32),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'HSE Action Center',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Cross-module follow-up, verification and closure',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 5),
            Text(
              'Risk → PTW → Daily HSE → Audit → Incident → Legal → Closure',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboard() {
    final data = [
      ('Total', actions.length, Icons.list_alt),
      ('Active', activeCount, Icons.pending_actions),
      ('Overdue', overdueCount, Icons.warning),
      ('Critical', _countPriority('Critical'), Icons.priority_high),
      ('High', _countPriority('High'), Icons.error_outline),
      ('Verification', _countStatus('Verification Required'), Icons.verified),
      ('Completed', _countStatus('Completed'), Icons.check_circle),
      ('Closed', _countStatus('Closed'), Icons.done_all),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 7,
        mainAxisSpacing: 7,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (_, i) {
        final item = data[i];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.$3, size: 21),
                const SizedBox(height: 3),
                Text(
                  '${item.$2}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  item.$1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 9),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _priorityCard() {
    final critical = _countPriority('Critical');
    final high = _countPriority('High');
    final overdue = overdueCount;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Management Priority',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (critical > 0)
              _priorityRow(
                Icons.priority_high,
                'Critical actions',
                '$critical require immediate management attention.',
              ),
            if (high > 0)
              _priorityRow(
                Icons.error_outline,
                'High priority actions',
                '$high require focused follow-up.',
              ),
            if (overdue > 0)
              _priorityRow(
                Icons.warning,
                'Overdue actions',
                '$overdue actions are past their due date.',
              ),
            if (critical == 0 && high == 0 && overdue == 0)
              const Text('No critical, high-priority or overdue actions.'),
          ],
        ),
      ),
    );
  }

  Widget _priorityRow(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }

  Widget _filters() {
    return Column(
      children: [
        TextField(
          onChanged: (v) => setState(() => search = v),
          decoration: const InputDecoration(
            labelText: 'Search action / owner / project / reference',
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
                    .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) =>
                    setState(() => statusFilter = v ?? 'All'),
              ),
            ),
            const SizedBox(width: 7),
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: priorityFilter,
                decoration: const InputDecoration(
                  labelText: 'Priority',
                  border: OutlineInputBorder(),
                ),
                items: ['All', ...priorities]
                    .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) =>
                    setState(() => priorityFilter = v ?? 'All'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: phaseFilter,
          decoration: const InputDecoration(
            labelText: 'Source Phase',
            border: OutlineInputBorder(),
          ),
          items: ['All', ...phases]
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: (v) => setState(() => phaseFilter = v ?? 'All'),
        ),
      ],
    );
  }

  Widget _actionCard(Map<String, dynamic> action, int index) {
    final overdue = _isOverdue(action);
    final priority = '${action['priority'] ?? 'Medium'}';
    final status = '${action['status'] ?? 'Open'}';

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: overdue ? Colors.red : primaryGreen,
          child: Icon(
            overdue ? Icons.warning : Icons.assignment,
            color: Colors.white,
          ),
        ),
        title: Text(
          '${action['actionNo'] ?? ''} • ${action['title'] ?? ''}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '$priority • $status\n'
          '${action['project'] ?? ''} • ${action['owner'] ?? ''}\n'
          '${action['phase'] ?? ''}'
          '${overdue ? ' • OVERDUE' : ''}',
        ),
        isThreeLine: true,
        onTap: () => _showDetails(action),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              _openForm(
                existing: Map<String, dynamic>.from(action),
                index: index,
              );
            } else if (value == 'complete') {
              _markCompleted(index);
            } else if (value == 'delete') {
              _delete(index);
            }
          },
          itemBuilder: (_) => const [
            PopupMenuItem(
              value: 'edit',
              child: Text('Edit'),
            ),
            PopupMenuItem(
              value: 'complete',
              child: Text('Mark Completed'),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionForm extends StatefulWidget {
  final List<String> priorities;
  final List<String> statuses;
  final List<String> phases;
  final Map<String, dynamic>? existing;

  const _ActionForm({
    required this.priorities,
    required this.statuses,
    required this.phases,
    this.existing,
  });

  @override
  State<_ActionForm> createState() => _ActionFormState();
}

class _ActionFormState extends State<_ActionForm> {
  final formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> c;
  late String priority;
  late String status;
  late String phase;

  @override
  void initState() {
    super.initState();
    final r = widget.existing ?? {};
    c = {
      'actionNo': TextEditingController(text: '${r['actionNo'] ?? ''}'),
      'title': TextEditingController(text: '${r['title'] ?? ''}'),
      'project': TextEditingController(text: '${r['project'] ?? ''}'),
      'site': TextEditingController(text: '${r['site'] ?? ''}'),
      'location': TextEditingController(text: '${r['location'] ?? ''}'),
      'owner': TextEditingController(text: '${r['owner'] ?? ''}'),
      'raisedBy': TextEditingController(text: '${r['raisedBy'] ?? ''}'),
      'raisedDate': TextEditingController(text: '${r['raisedDate'] ?? ''}'),
      'dueDate': TextEditingController(text: '${r['dueDate'] ?? ''}'),
      'completedDate':
          TextEditingController(text: '${r['completedDate'] ?? ''}'),
      'verificationDate':
          TextEditingController(text: '${r['verificationDate'] ?? ''}'),
      'sourceReference':
          TextEditingController(text: '${r['sourceReference'] ?? ''}'),
      'finding': TextEditingController(text: '${r['finding'] ?? ''}'),
      'rootCause': TextEditingController(text: '${r['rootCause'] ?? ''}'),
      'actionDescription':
          TextEditingController(text: '${r['actionDescription'] ?? ''}'),
      'verification':
          TextEditingController(text: '${r['verification'] ?? ''}'),
      'evidence': TextEditingController(text: '${r['evidence'] ?? ''}'),
      'riskRef': TextEditingController(text: '${r['riskRef'] ?? ''}'),
      'ptwRef': TextEditingController(text: '${r['ptwRef'] ?? ''}'),
      'ramsRef': TextEditingController(text: '${r['ramsRef'] ?? ''}'),
      'incidentRef':
          TextEditingController(text: '${r['incidentRef'] ?? ''}'),
      'auditRef': TextEditingController(text: '${r['auditRef'] ?? ''}'),
      'legalRef': TextEditingController(text: '${r['legalRef'] ?? ''}'),
      'remarks': TextEditingController(text: '${r['remarks'] ?? ''}'),
    };

    priority = widget.priorities.contains(r['priority'])
        ? r['priority'] as String
        : widget.priorities[1];
    status = widget.statuses.contains(r['status'])
        ? r['status'] as String
        : widget.statuses.first;
    phase = widget.phases.contains(r['phase'])
        ? r['phase'] as String
        : widget.phases.first;
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
                  'HSE Action / CAPA Record',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView(
                    children: [
                      field('actionNo', 'Action No.', required: true),
                      field('title', 'Action Title', required: true),
                      DropdownButtonFormField<String>(
                        initialValue: priority,
                        decoration: const InputDecoration(
                          labelText: 'Priority',
                          border: OutlineInputBorder(),
                        ),
                        items: widget.priorities
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => priority = v ?? priority),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: status,
                        decoration: const InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder(),
                        ),
                        items: widget.statuses
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => status = v ?? status),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: phase,
                        decoration: const InputDecoration(
                          labelText: 'Source Phase',
                          border: OutlineInputBorder(),
                        ),
                        items: widget.phases
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => phase = v ?? phase),
                      ),
                      const SizedBox(height: 10),
                      field('project', 'Project'),
                      field('site', 'Site'),
                      field('location', 'Location'),
                      field('owner', 'Action Owner'),
                      field('raisedBy', 'Raised By'),
                      dateField('raisedDate', 'Raised Date'),
                      dateField('dueDate', 'Due Date'),
                      dateField('completedDate', 'Completed Date'),
                      dateField('verificationDate', 'Verification Date'),
                      field('sourceReference', 'Source / Finding Reference'),
                      field('finding', 'Finding / Observation', maxLines: 4),
                      field('rootCause', 'Root Cause', maxLines: 3),
                      field('actionDescription', 'Corrective / Preventive Action', maxLines: 4),
                      field('verification', 'Verification / Effectiveness', maxLines: 4),
                      field('evidence', 'Evidence / Closure Reference', maxLines: 3),
                      field('riskRef', 'Risk / HIRA / JSA Reference'),
                      field('ptwRef', 'PTW Reference'),
                      field('ramsRef', 'RAMS Reference'),
                      field('incidentRef', 'Incident Reference'),
                      field('auditRef', 'Inspection / Audit Reference'),
                      field('legalRef', 'Legal / Authority Reference'),
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
                      result['priority'] = priority;
                      result['status'] = status;
                      result['phase'] = phase;
                      Navigator.pop(context, result);
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Save Action'),
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

class _ActionDetails extends StatelessWidget {
  final Map<String, dynamic> action;

  const _ActionDetails({required this.action});

  @override
  Widget build(BuildContext context) {
    final entries = action.entries
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
                '${action['actionNo'] ?? ''} • ${action['title'] ?? ''}',
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${action['priority'] ?? ''} • '
                '${action['status'] ?? ''} • '
                '${action['phase'] ?? ''}',
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
