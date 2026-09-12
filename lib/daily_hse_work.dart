import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyHseWorkPage extends StatefulWidget {
  const DailyHseWorkPage({super.key});

  @override
  State<DailyHseWorkPage> createState() => _DailyHseWorkPageState();
}

class _DailyHseWorkPageState extends State<DailyHseWorkPage> {
  static const String storageKey = 'safenexus_hse_daily_hse_work';
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final List<Map<String, dynamic>> _records = [];
  String _search = '';
  String _statusFilter = 'All';
  String _activityFilter = 'All';
  bool _loading = true;

  final List<String> _statuses = const [
    'Draft',
    'Open',
    'In Progress',
    'Action Required',
    'Verification Required',
    'Completed',
    'Closed',
    'Cancelled',
  ];

  final List<String> _activityTypes = const [
    'Daily HSE Log',
    'Toolbox Talk',
    'Daily Inspection',
    'Safety Observation',
    'Site Walk',
    'Unsafe Act',
    'Unsafe Condition',
    'Corrective Action',
    'Work Activity Monitoring',
    'Daily Readiness',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);
    if (raw != null && raw.isNotEmpty) {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        _records
          ..clear()
          ..addAll(
            decoded.map(
              (item) => Map<String, dynamic>.from(item as Map),
            ),
          );
      }
    }
    if (mounted) {
      setState(() => _loading = false);
    }
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(_records));
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final q = _search.trim().toLowerCase();
    return _records.where((r) {
      final matchesSearch = q.isEmpty ||
          _text(r['recordNo']).toLowerCase().contains(q) ||
          _text(r['activityType']).toLowerCase().contains(q) ||
          _text(r['subject']).toLowerCase().contains(q) ||
          _text(r['project']).toLowerCase().contains(q) ||
          _text(r['site']).toLowerCase().contains(q) ||
          _text(r['location']).toLowerCase().contains(q) ||
          _text(r['responsiblePerson']).toLowerCase().contains(q);
      final matchesStatus =
          _statusFilter == 'All' || _text(r['status']) == _statusFilter;
      final matchesActivity = _activityFilter == 'All' ||
          _text(r['activityType']) == _activityFilter;
      return matchesSearch && matchesStatus && matchesActivity;
    }).toList()
      ..sort((a, b) => _dateValue(b['date']).compareTo(_dateValue(a['date'])));
  }

  int _countWhere(bool Function(Map<String, dynamic>) test) =>
      _records.where(test).length;

  DateTime _dateValue(dynamic value) {
    return DateTime.tryParse(_text(value)) ?? DateTime(1900);
  }

  bool _isOverdue(Map<String, dynamic> r) {
    final due = DateTime.tryParse(_text(r['actionDue']));
    if (due == null) return false;
    final status = _text(r['status']);
    return due.isBefore(DateTime.now()) &&
        status != 'Completed' &&
        status != 'Closed' &&
        status != 'Cancelled';
  }

  bool _isToday(Map<String, dynamic> r) {
    final date = DateTime.tryParse(_text(r['date']));
    final now = DateTime.now();
    return date != null &&
        date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  String _text(dynamic value) => value?.toString() ?? '';

  Future<void> _openForm({Map<String, dynamic>? existing}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _DailyHseFormSheet(
        existing: existing,
        statuses: _statuses,
        activityTypes: _activityTypes,
      ),
    );

    if (result == null) return;

    setState(() {
      final index = existing == null ? -1 : _records.indexOf(existing);
      if (index >= 0) {
        _records[index] = result;
      } else {
        _records.add(result);
      }
    });
    await _saveRecords();
  }

  Future<void> _delete(Map<String, dynamic> record) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Record'),
        content: const Text('Delete this daily HSE record?'),
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
    setState(() => _records.remove(record));
    await _saveRecords();
  }

  void _showDetails(Map<String, dynamic> r) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _DetailsSheet(record: r),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = _records.length;
    final today = _countWhere(_isToday);
    final open = _countWhere(
      (r) => _text(r['status']) == 'Open' || _text(r['status']) == 'In Progress',
    );
    final actions = _countWhere(
      (r) =>
          _text(r['status']) == 'Action Required' ||
          _text(r['status']) == 'Verification Required',
    );
    final overdue = _countWhere(_isOverdue);
    final observations = _countWhere(
      (r) =>
          _text(r['activityType']) == 'Safety Observation' ||
          _text(r['activityType']) == 'Unsafe Act' ||
          _text(r['activityType']) == 'Unsafe Condition',
    );
    final inspections =
        _countWhere((r) => _text(r['activityType']) == 'Daily Inspection');
    final tbt =
        _countWhere((r) => _text(r['activityType']) == 'Toolbox Talk');

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Daily HSE Work'),
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
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildDashboard(
                  total,
                  today,
                  open,
                  actions,
                  overdue,
                  observations,
                  inspections,
                  tbt,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                  child: TextField(
                    onChanged: (v) => setState(() => _search = v),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText:
                          'Search record no, activity, project, site...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                _buildFilters(),
                Expanded(child: _buildList()),
              ],
            ),
    );
  }

  Widget _buildDashboard(
    int total,
    int today,
    int open,
    int actions,
    int overdue,
    int observations,
    int inspections,
    int tbt,
  ) {
    final items = [
      ('Total', total, Icons.list_alt),
      ('Today', today, Icons.today),
      ('Open', open, Icons.pending_actions),
      ('Actions', actions, Icons.task_alt),
      ('Overdue', overdue, Icons.warning_amber),
      ('Observations', observations, Icons.visibility),
      ('Inspections', inspections, Icons.fact_check),
      ('TBT', tbt, Icons.groups),
    ];

    return SizedBox(
      height: 118,
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final item = items[i];
          return Container(
            width: 112,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: primaryGreen.withValues(alpha: 0.15)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.$3, color: darkGreen, size: 24),
                const SizedBox(height: 5),
                Text(
                  '${item.$2}',
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                Text(
                  item.$1,
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      child: Row(
        children: [
          _filterDropdown(
            value: _statusFilter,
            label: 'Status',
            items: ['All', ..._statuses],
            onChanged: (v) => setState(() => _statusFilter = v ?? 'All'),
          ),
          const SizedBox(width: 8),
          _filterDropdown(
            value: _activityFilter,
            label: 'Activity',
            items: ['All', ..._activityTypes],
            onChanged: (v) => setState(() => _activityFilter = v ?? 'All'),
          ),
        ],
      ),
    );
  }

  Widget _filterDropdown({
    required String value,
    required String label,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      width: 190,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
        items: items
            .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildList() {
    final data = _filteredRecords;
    if (data.isEmpty) {
      return const Center(
        child: Text(
          'No daily HSE records found.',
          style: TextStyle(color: Colors.black54),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
      itemCount: data.length,
      itemBuilder: (_, index) {
        final r = data[index];
        final overdue = _isOverdue(r);
        final status = _text(r['status']);
        final statusColor = _statusColor(status);

        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          elevation: 0.5,
          child: InkWell(
            onTap: () => _showDetails(r),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${_text(r['recordNo'])} • ${_text(r['activityType'])}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: darkGreen,
                          ),
                        ),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (v) {
                          if (v == 'edit') _openForm(existing: r);
                          if (v == 'delete') _delete(r);
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(value: 'edit', child: Text('Edit')),
                          PopupMenuItem(value: 'delete', child: Text('Delete')),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    _text(r['subject']).isEmpty
                        ? 'Daily HSE record'
                        : _text(r['subject']),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${_text(r['project'])} • ${_text(r['site'])}',
                    style: const TextStyle(color: Colors.black87),
                  ),
                  Text(
                    '${_text(r['location'])} • ${_text(r['date'])}',
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      _chip(status, statusColor),
                      if (_text(r['riskLevel']).isNotEmpty)
                        _chip(
                          'Risk: ${_text(r['riskLevel'])}',
                          _riskColor(_text(r['riskLevel'])),
                        ),
                      if (overdue) _chip('OVERDUE', Colors.red),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Completed':
      case 'Closed':
        return Colors.green;
      case 'Action Required':
      case 'Verification Required':
        return Colors.orange.shade800;
      case 'Cancelled':
        return Colors.grey;
      case 'In Progress':
        return Colors.blue;
      default:
        return darkGreen;
    }
  }

  Color _riskColor(String risk) {
    switch (risk) {
      case 'Critical':
        return Colors.red;
      case 'High':
        return Colors.deepOrange;
      case 'Medium':
        return Colors.orange.shade800;
      default:
        return Colors.green;
    }
  }

  Widget _chip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _DailyHseFormSheet extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> statuses;
  final List<String> activityTypes;

  const _DailyHseFormSheet({
    required this.existing,
    required this.statuses,
    required this.activityTypes,
  });

  @override
  State<_DailyHseFormSheet> createState() => _DailyHseFormSheetState();
}

class _DailyHseFormSheetState extends State<_DailyHseFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _c = {};

  String _activityType = 'Daily HSE Log';
  String _status = 'Draft';
  String _riskLevel = 'Low';
  String _findingType = 'Positive Observation';
  String _actionPriority = 'Medium';
  String _verificationStatus = 'Not Verified';
  String _attendanceStatus = 'Recorded';
  bool _tbtCompleted = false;
  bool _preStartCompleted = false;
  bool _workActivitySafe = false;
  bool _permitVerified = false;
  bool _ramssJsaVerified = false;
  bool _competencyVerified = false;
  bool _equipmentVerified = false;
  bool _ppeVerified = false;
  bool _emergencyReady = false;
  bool _environmentalControls = false;

  final List<String> _riskLevels = const ['Low', 'Medium', 'High', 'Critical'];
  final List<String> _findingTypes = const [
    'Positive Observation',
    'Unsafe Act',
    'Unsafe Condition',
    'Near Miss',
    'Good Practice',
    'Non-Conformance',
    'Improvement Opportunity',
  ];
  final List<String> _priorities = const ['Low', 'Medium', 'High', 'Critical'];
  final List<String> _verificationStatuses = const [
    'Not Verified',
    'Pending',
    'Verified Effective',
    'Verified Ineffective',
  ];
  final List<String> _attendanceStatuses = const [
    'Recorded',
    'Partial',
    'Not Recorded',
  ];

  @override
  void initState() {
    super.initState();
    const keys = [
      'recordNo',
      'date',
      'time',
      'project',
      'site',
      'location',
      'department',
      'workActivity',
      'subject',
      'description',
      'observedBy',
      'hseOfficer',
      'supervisor',
      'contractor',
      'workersInvolved',
      'workerIds',
      'tbtTopic',
      'tbtConductor',
      'attendanceCount',
      'inspectionScope',
      'inspectionFindings',
      'positiveFindings',
      'hazards',
      'controls',
      'permitRef',
      'hiraRef',
      'jsaRef',
      'ramsRef',
      'ptwStatus',
      'equipmentRef',
      'competencyRef',
      'ppeFindings',
      'emergencyFindings',
      'environmentalFindings',
      'findingRef',
      'correctiveAction',
      'actionOwner',
      'actionDue',
      'verificationBy',
      'verificationDate',
      'rootCause',
      'preventiveAction',
      'closureEvidence',
      'handoverRemarks',
      'lessonsLearned',
      'remarks',
    ];
    for (final key in keys) {
      _c[key] = TextEditingController();
    }

    final r = widget.existing;
    if (r != null) {
      for (final key in _c.keys) {
        _c[key]!.text = _text(r[key]);
      }
      _activityType = _valid(
        _text(r['activityType']),
        widget.activityTypes,
        widget.activityTypes.first,
      );
      _status = _valid(
        _text(r['status']),
        widget.statuses,
        widget.statuses.first,
      );
      _riskLevel = _valid(_text(r['riskLevel']), _riskLevels, 'Low');
      _findingType =
          _valid(_text(r['findingType']), _findingTypes, _findingTypes.first);
      _actionPriority =
          _valid(_text(r['actionPriority']), _priorities, 'Medium');
      _verificationStatus = _valid(
        _text(r['verificationStatus']),
        _verificationStatuses,
        _verificationStatuses.first,
      );
      _attendanceStatus = _valid(
        _text(r['attendanceStatus']),
        _attendanceStatuses,
        _attendanceStatuses.first,
      );
      _tbtCompleted = r['tbtCompleted'] == true;
      _preStartCompleted = r['preStartCompleted'] == true;
      _workActivitySafe = r['workActivitySafe'] == true;
      _permitVerified = r['permitVerified'] == true;
      _ramssJsaVerified = r['ramssJsaVerified'] == true;
      _competencyVerified = r['competencyVerified'] == true;
      _equipmentVerified = r['equipmentVerified'] == true;
      _ppeVerified = r['ppeVerified'] == true;
      _emergencyReady = r['emergencyReady'] == true;
      _environmentalControls = r['environmentalControls'] == true;
    } else {
      _c['recordNo']!.text = 'DHW-${DateTime.now().millisecondsSinceEpoch}';
      _c['date']!.text = _date(DateTime.now());
      _c['time']!.text = _time(DateTime.now());
    }
  }

  String _text(dynamic value) => value?.toString() ?? '';

  String _valid(String value, List<String> options, String fallback) =>
      options.contains(value) ? value : fallback;

  String _date(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  String _time(DateTime d) =>
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  @override
  void dispose() {
    for (final controller in _c.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDate(String key) async {
    final initial = DateTime.tryParse(_c[key]!.text) ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) _c[key]!.text = _date(picked);
  }

  Future<void> _pickTime(String key) async {
    final parts = _c[key]!.text.split(':');
    final initial = TimeOfDay(
      hour: parts.length == 2 ? int.tryParse(parts[0]) ?? 9 : 9,
      minute: parts.length == 2 ? int.tryParse(parts[1]) ?? 0 : 0,
    );
    final picked = await showTimePicker(context: context, initialTime: initial);
    if (picked != null) _c[key]!.text = picked.format(context);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now().toIso8601String();
    final existingId = widget.existing?['id']?.toString();
    final record = <String, dynamic>{
      'id': existingId ?? now,
      'recordNo': _c['recordNo']!.text.trim(),
      'activityType': _activityType,
      'date': _c['date']!.text.trim(),
      'time': _c['time']!.text.trim(),
      'project': _c['project']!.text.trim(),
      'site': _c['site']!.text.trim(),
      'location': _c['location']!.text.trim(),
      'department': _c['department']!.text.trim(),
      'workActivity': _c['workActivity']!.text.trim(),
      'subject': _c['subject']!.text.trim(),
      'description': _c['description']!.text.trim(),
      'observedBy': _c['observedBy']!.text.trim(),
      'hseOfficer': _c['hseOfficer']!.text.trim(),
      'supervisor': _c['supervisor']!.text.trim(),
      'contractor': _c['contractor']!.text.trim(),
      'workersInvolved': _c['workersInvolved']!.text.trim(),
      'workerIds': _c['workerIds']!.text.trim(),
      'tbtTopic': _c['tbtTopic']!.text.trim(),
      'tbtConductor': _c['tbtConductor']!.text.trim(),
      'attendanceCount': _c['attendanceCount']!.text.trim(),
      'attendanceStatus': _attendanceStatus,
      'inspectionScope': _c['inspectionScope']!.text.trim(),
      'inspectionFindings': _c['inspectionFindings']!.text.trim(),
      'positiveFindings': _c['positiveFindings']!.text.trim(),
      'findingType': _findingType,
      'findingRef': _c['findingRef']!.text.trim(),
      'hazards': _c['hazards']!.text.trim(),
      'controls': _c['controls']!.text.trim(),
      'riskLevel': _riskLevel,
      'permitRef': _c['permitRef']!.text.trim(),
      'ptwStatus': _c['ptwStatus']!.text.trim(),
      'hiraRef': _c['hiraRef']!.text.trim(),
      'jsaRef': _c['jsaRef']!.text.trim(),
      'ramsRef': _c['ramsRef']!.text.trim(),
      'equipmentRef': _c['equipmentRef']!.text.trim(),
      'competencyRef': _c['competencyRef']!.text.trim(),
      'ppeFindings': _c['ppeFindings']!.text.trim(),
      'emergencyFindings': _c['emergencyFindings']!.text.trim(),
      'environmentalFindings': _c['environmentalFindings']!.text.trim(),
      'tbtCompleted': _tbtCompleted,
      'preStartCompleted': _preStartCompleted,
      'workActivitySafe': _workActivitySafe,
      'permitVerified': _permitVerified,
      'ramssJsaVerified': _ramssJsaVerified,
      'competencyVerified': _competencyVerified,
      'equipmentVerified': _equipmentVerified,
      'ppeVerified': _ppeVerified,
      'emergencyReady': _emergencyReady,
      'environmentalControls': _environmentalControls,
      'correctiveAction': _c['correctiveAction']!.text.trim(),
      'actionOwner': _c['actionOwner']!.text.trim(),
      'actionDue': _c['actionDue']!.text.trim(),
      'actionPriority': _actionPriority,
      'verificationBy': _c['verificationBy']!.text.trim(),
      'verificationDate': _c['verificationDate']!.text.trim(),
      'verificationStatus': _verificationStatus,
      'rootCause': _c['rootCause']!.text.trim(),
      'preventiveAction': _c['preventiveAction']!.text.trim(),
      'closureEvidence': _c['closureEvidence']!.text.trim(),
      'handoverRemarks': _c['handoverRemarks']!.text.trim(),
      'lessonsLearned': _c['lessonsLearned']!.text.trim(),
      'status': _status,
      'remarks': _c['remarks']!.text.trim(),
      'createdAt': widget.existing?['createdAt']?.toString() ?? now,
      'updatedAt': now,
    };

    Navigator.pop(context, record);
  }

  Widget _field(
    String key,
    String label, {
    int maxLines = 1,
    bool required = false,
    TextInputType? keyboardType,
    VoidCallback? onTap,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: _c[key],
        maxLines: maxLines,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: required
            ? (v) => (v == null || v.trim().isEmpty) ? 'Required' : null
            : null,
      ),
    );
  }

  Widget _dropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _switchTile(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      value: value,
      activeTrackColor: primaryGreen.withValues(alpha: 0.35),
      activeThumbColor: primaryGreen,
      onChanged: onChanged,
    );
  }

  Widget _section(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 22,
            decoration: BoxDecoration(
              color: primaryGreen,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.94,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 8, 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.existing == null
                            ? 'Add Daily HSE Record'
                            : 'Edit Daily HSE Record',
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: darkGreen,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  children: [
                    _section('9A • Daily HSE Work Master'),
                    _field('recordNo', 'Record No', required: true),
                    _dropdown(
                      'Activity Type',
                      _activityType,
                      widget.activityTypes,
                      (v) => setState(() => _activityType = v!),
                    ),
                    _field('date', 'Date', readOnly: true, onTap: () => _pickDate('date')),
                    _field('time', 'Time', readOnly: true, onTap: () => _pickTime('time')),
                    _field('project', 'Project', required: true),
                    _field('site', 'Site', required: true),
                    _field('location', 'Location / Work Front'),
                    _field('department', 'Department'),
                    _field('workActivity', 'Work Activity'),
                    _field('subject', 'Subject / Topic', required: true),
                    _field('description', 'Description', maxLines: 4),
                    _field('observedBy', 'Observed / Conducted By'),
                    _field('hseOfficer', 'HSE Officer'),
                    _field('supervisor', 'Supervisor'),
                    _field('contractor', 'Contractor'),
                    _field('workersInvolved', 'Workers Involved'),
                    _field('workerIds', 'Worker IDs / References'),

                    _section('9B • Toolbox Talk / Briefing'),
                    _field('tbtTopic', 'TBT / Briefing Topic'),
                    _field('tbtConductor', 'Conductor / Speaker'),
                    _field('attendanceCount', 'Attendance Count', keyboardType: TextInputType.number),
                    _dropdown(
                      'Attendance Status',
                      _attendanceStatus,
                      _attendanceStatuses,
                      (v) => setState(() => _attendanceStatus = v!),
                    ),
                    _switchTile(
                      'TBT Completed',
                      _tbtCompleted,
                      (v) => setState(() => _tbtCompleted = v),
                    ),

                    _section('9C • Daily Inspection'),
                    _field('inspectionScope', 'Inspection Scope'),
                    _field('inspectionFindings', 'Inspection Findings', maxLines: 4),
                    _field('positiveFindings', 'Positive Findings / Good Practices', maxLines: 3),
                    _switchTile(
                      'Pre-Start Inspection Completed',
                      _preStartCompleted,
                      (v) => setState(() => _preStartCompleted = v),
                    ),

                    _section('9D • Safety Observation / Site Walk'),
                    _dropdown(
                      'Finding Type',
                      _findingType,
                      _findingTypes,
                      (v) => setState(() => _findingType = v!),
                    ),
                    _field('findingRef', 'Observation / Finding Reference'),
                    _field('hazards', 'Hazard / Unsafe Condition', maxLines: 3),
                    _field('controls', 'Existing / Required Controls', maxLines: 4),
                    _dropdown(
                      'Risk Level',
                      _riskLevel,
                      _riskLevels,
                      (v) => setState(() => _riskLevel = v!),
                    ),

                    _section('9E • Work Activity Monitoring & Critical Controls'),
                    _switchTile(
                      'Work Activity Safe / Controlled',
                      _workActivitySafe,
                      (v) => setState(() => _workActivitySafe = v),
                    ),
                    _switchTile(
                      'Permit / PTW Verified',
                      _permitVerified,
                      (v) => setState(() => _permitVerified = v),
                    ),
                    _switchTile(
                      'RAMS / JSA Verified',
                      _ramssJsaVerified,
                      (v) => setState(() => _ramssJsaVerified = v),
                    ),
                    _switchTile(
                      'Competency Verified',
                      _competencyVerified,
                      (v) => setState(() => _competencyVerified = v),
                    ),
                    _switchTile(
                      'Equipment / Inspection Verified',
                      _equipmentVerified,
                      (v) => setState(() => _equipmentVerified = v),
                    ),
                    _switchTile(
                      'PPE Compliance Verified',
                      _ppeVerified,
                      (v) => setState(() => _ppeVerified = v),
                    ),
                    _switchTile(
                      'Emergency / Rescue Readiness',
                      _emergencyReady,
                      (v) => setState(() => _emergencyReady = v),
                    ),
                    _switchTile(
                      'Environmental Controls in Place',
                      _environmentalControls,
                      (v) => setState(() => _environmentalControls = v),
                    ),
                    _field('permitRef', 'PTW Reference'),
                    _field('ptwStatus', 'PTW Status'),
                    _field('hiraRef', 'HIRA Reference'),
                    _field('jsaRef', 'JSA / JHA Reference'),
                    _field('ramsRef', 'RAMS Reference'),
                    _field('equipmentRef', 'Equipment Reference'),
                    _field('competencyRef', 'Competency / Authorization Reference'),
                    _field('ppeFindings', 'PPE Findings'),
                    _field('emergencyFindings', 'Emergency / Rescue Findings'),
                    _field('environmentalFindings', 'Environmental Findings'),

                    _section('9F • Corrective Action'),
                    _field('correctiveAction', 'Corrective Action', maxLines: 4),
                    _field('actionOwner', 'Action Owner'),
                    _field(
                      'actionDue',
                      'Action Due Date',
                      readOnly: true,
                      onTap: () => _pickDate('actionDue'),
                    ),
                    _dropdown(
                      'Action Priority',
                      _actionPriority,
                      _priorities,
                      (v) => setState(() => _actionPriority = v!),
                    ),

                    _section('9G • Verification & Closure'),
                    _field('verificationBy', 'Verified By'),
                    _field(
                      'verificationDate',
                      'Verification Date',
                      readOnly: true,
                      onTap: () => _pickDate('verificationDate'),
                    ),
                    _dropdown(
                      'Verification Status',
                      _verificationStatus,
                      _verificationStatuses,
                      (v) => setState(() => _verificationStatus = v!),
                    ),
                    _field('rootCause', 'Root Cause / Contributing Factor', maxLines: 3),
                    _field('preventiveAction', 'Preventive Action', maxLines: 3),
                    _field('closureEvidence', 'Closure Evidence / Reference'),
                    _field('handoverRemarks', 'Handover / Shift Remarks', maxLines: 3),
                    _field('lessonsLearned', 'Lessons Learned', maxLines: 3),

                    _section('9H • Daily HSE Readiness'),
                    _dropdown(
                      'Record Status',
                      _status,
                      widget.statuses,
                      (v) => setState(() => _status = v!),
                    ),
                    _field('remarks', 'Remarks', maxLines: 3),

                    const SizedBox(height: 12),
                    SizedBox(
                      height: 50,
                      child: FilledButton.icon(
                        onPressed: _submit,
                        style: FilledButton.styleFrom(
                          backgroundColor: primaryGreen,
                        ),
                        icon: const Icon(Icons.save),
                        label: Text(
                          widget.existing == null ? 'Save Record' : 'Update Record',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailsSheet extends StatelessWidget {
  final Map<String, dynamic> record;

  const _DetailsSheet({required this.record});

  static const Color darkGreen = Color(0xFF0B5D4B);

  String _text(dynamic value) => value?.toString() ?? '';

  @override
  Widget build(BuildContext context) {
    final entries = <MapEntry<String, String>>[
      MapEntry('Record No', _text(record['recordNo'])),
      MapEntry('Activity Type', _text(record['activityType'])),
      MapEntry('Date / Time', '${_text(record['date'])} ${_text(record['time'])}'),
      MapEntry('Project', _text(record['project'])),
      MapEntry('Site', _text(record['site'])),
      MapEntry('Location', _text(record['location'])),
      MapEntry('Department', _text(record['department'])),
      MapEntry('Work Activity', _text(record['workActivity'])),
      MapEntry('Subject', _text(record['subject'])),
      MapEntry('Description', _text(record['description'])),
      MapEntry('Observed / Conducted By', _text(record['observedBy'])),
      MapEntry('HSE Officer', _text(record['hseOfficer'])),
      MapEntry('Supervisor', _text(record['supervisor'])),
      MapEntry('Contractor', _text(record['contractor'])),
      MapEntry('Workers', _text(record['workersInvolved'])),
      MapEntry('TBT Topic', _text(record['tbtTopic'])),
      MapEntry('TBT Conductor', _text(record['tbtConductor'])),
      MapEntry('Attendance', _text(record['attendanceCount'])),
      MapEntry('Inspection Scope', _text(record['inspectionScope'])),
      MapEntry('Inspection Findings', _text(record['inspectionFindings'])),
      MapEntry('Positive Findings', _text(record['positiveFindings'])),
      MapEntry('Finding Type', _text(record['findingType'])),
      MapEntry('Hazards', _text(record['hazards'])),
      MapEntry('Controls', _text(record['controls'])),
      MapEntry('Risk Level', _text(record['riskLevel'])),
      MapEntry('PTW', _text(record['permitRef'])),
      MapEntry('HIRA', _text(record['hiraRef'])),
      MapEntry('JSA / JHA', _text(record['jsaRef'])),
      MapEntry('RAMS', _text(record['ramsRef'])),
      MapEntry('Corrective Action', _text(record['correctiveAction'])),
      MapEntry('Action Owner', _text(record['actionOwner'])),
      MapEntry('Action Due', _text(record['actionDue'])),
      MapEntry('Verification', _text(record['verificationStatus'])),
      MapEntry('Lessons Learned', _text(record['lessonsLearned'])),
      MapEntry('Status', _text(record['status'])),
      MapEntry('Remarks', _text(record['remarks'])),
    ];

    final checks = <String, bool>{
      'TBT Completed': record['tbtCompleted'] == true,
      'Pre-Start Completed': record['preStartCompleted'] == true,
      'Work Activity Safe': record['workActivitySafe'] == true,
      'PTW Verified': record['permitVerified'] == true,
      'RAMS / JSA Verified': record['ramssJsaVerified'] == true,
      'Competency Verified': record['competencyVerified'] == true,
      'Equipment Verified': record['equipmentVerified'] == true,
      'PPE Verified': record['ppeVerified'] == true,
      'Emergency Ready': record['emergencyReady'] == true,
      'Environmental Controls': record['environmentalControls'] == true,
    };

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Daily HSE Record Details',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  ...entries.where((e) => e.value.isNotEmpty).map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.key,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(e.value),
                            ],
                          ),
                        ),
                      ),
                  const Divider(height: 24),
                  const Text(
                    'Critical Control Verification',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...checks.entries.map(
                    (e) => ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        e.value ? Icons.check_circle : Icons.cancel,
                        color: e.value ? Colors.green : Colors.red,
                      ),
                      title: Text(e.key),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
