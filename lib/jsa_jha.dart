import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JsaJhaPage extends StatefulWidget {
  const JsaJhaPage({super.key});

  @override
  State<JsaJhaPage> createState() => _JsaJhaPageState();
}

class _JsaJhaPageState extends State<JsaJhaPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey = 'safenexus_hse_jsa_jha_records';

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _records = [];
  String _riskFilter = 'All';
  String _statusFilter = 'All';

  final List<String> _riskLevels = [
    'All',
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  final List<String> _statuses = [
    'All',
    'Draft',
    'Under Review',
    'Approved',
    'Active',
    'Closed',
    'Cancelled',
  ];

  @override
  void initState() {
    super.initState();
    _loadRecords();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);

    if (raw == null || raw.isEmpty) {
      return;
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        setState(() {
          _records = decoded
              .whereType<Map>()
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        });
      }
    } catch (_) {
      // Ignore invalid legacy data.
    }
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(_records));
  }

  String _text(dynamic value) => value?.toString() ?? '';

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  bool _isOverdue(Map<String, dynamic> record) {
    final date = _parseDate(record['reviewDate']);
    if (date == null) return false;

    final status = _text(record['status']);
    if (status == 'Closed' || status == 'Cancelled') return false;

    final today = DateTime.now();
    final due = DateTime(date.year, date.month, date.day);
    final now = DateTime(today.year, today.month, today.day);

    return due.isBefore(now);
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchController.text.trim().toLowerCase();

    return _records.where((record) {
      final risk = _text(record['residualRiskLevel']);
      final status = _text(record['status']);

      if (_riskFilter != 'All' && risk != _riskFilter) return false;
      if (_statusFilter != 'All' && status != _statusFilter) return false;

      if (query.isEmpty) return true;

      final searchable = [
        record['jsaNo'],
        record['project'],
        record['location'],
        record['department'],
        record['activity'],
        record['workStep'],
        record['hazard'],
        record['consequence'],
        record['existingControls'],
        record['additionalControls'],
        record['responsiblePerson'],
        record['competency'],
        record['ppe'],
        record['permit'],
        record['equipment'],
        record['status'],
        record['initialRiskLevel'],
        record['residualRiskLevel'],
      ].map(_text).join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();
  }

  int get _totalCount => _records.length;

  int get _activeCount =>
      _records.where((r) => _text(r['status']) == 'Active').length;

  int get _highCriticalCount => _records.where((r) {
        final level = _text(r['residualRiskLevel']);
        return level == 'High' || level == 'Critical';
      }).length;

  int get _mediumCount =>
      _records.where((r) => _text(r['residualRiskLevel']) == 'Medium').length;

  int get _lowCount =>
      _records.where((r) => _text(r['residualRiskLevel']) == 'Low').length;

  int get _overdueCount => _records.where(_isOverdue).length;

  Color _riskColor(String level) {
    switch (level) {
      case 'Critical':
        return Colors.red.shade800;
      case 'High':
        return Colors.red.shade600;
      case 'Medium':
        return Colors.orange.shade700;
      case 'Low':
        return primaryGreen;
      default:
        return Colors.grey;
    }
  }

  Future<void> _deleteRecord(String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete JSA / JHA'),
        content: const Text(
          'Are you sure you want to delete this JSA / JHA record?',
        ),
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

    if (confirmed != true) return;

    setState(() {
      _records.removeWhere((record) => _text(record['id']) == id);
    });

    await _saveRecords();
  }

  Future<void> _openForm({Map<String, dynamic>? existingRecord}) async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => _JsaJhaFormPage(
          existingRecord: existingRecord,
          primaryGreen: primaryGreen,
          darkGreen: darkGreen,
        ),
      ),
    );

    if (result == null) return;

    final id = _text(result['id']);

    setState(() {
      final index = _records.indexWhere((record) => _text(record['id']) == id);

      if (index >= 0) {
        _records[index] = result;
      } else {
        _records.insert(0, result);
      }
    });

    await _saveRecords();
  }

  @override
  Widget build(BuildContext context) {
    final records = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text(
          'JSA / JHA',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add JSA'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildDashboard(),
            _buildFilters(),
            Expanded(
              child: records.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 100),
                      itemCount: records.length,
                      itemBuilder: (context, index) {
                        return _buildRecordCard(records[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.55,
        children: [
          _summaryCard('Total', _totalCount, Icons.list_alt, darkGreen),
          _summaryCard('Active', _activeCount, Icons.play_circle, primaryGreen),
          _summaryCard(
            'High+',
            _highCriticalCount,
            Icons.warning_amber_rounded,
            Colors.red.shade700,
          ),
          _summaryCard(
            'Medium',
            _mediumCount,
            Icons.report_problem_outlined,
            Colors.orange.shade700,
          ),
          _summaryCard('Low', _lowCount, Icons.check_circle, primaryGreen),
          _summaryCard(
            'Overdue',
            _overdueCount,
            Icons.event_busy,
            Colors.red.shade700,
          ),
        ],
      ),
    );
  }

  Widget _summaryCard(
    String title,
    int value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(icon, color: color, size: 23),
            const SizedBox(width: 7),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 2, 12, 6),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search JSA, activity, hazard, location...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: _searchController.clear,
                      icon: const Icon(Icons.clear),
                    ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _riskFilter,
                  decoration: const InputDecoration(
                    labelText: 'Residual Risk',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  items: _riskLevels
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _riskFilter = value);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _statusFilter,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  items: _statuses
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _statusFilter = value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 68,
              color: darkGreen.withValues(alpha: 0.45),
            ),
            const SizedBox(height: 14),
            const Text(
              'No JSA / JHA records found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'Create a Job Safety Analysis to identify task hazards, controls and residual risk.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: () => _openForm(),
              icon: const Icon(Icons.add),
              label: const Text('Add JSA / JHA'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordCard(Map<String, dynamic> record) {
    final residualLevel = _text(record['residualRiskLevel']);
    final initialLevel = _text(record['initialRiskLevel']);
    final overdue = _isOverdue(record);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1.5,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _openForm(existingRecord: record),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      _text(record['jsaNo']).isEmpty
                          ? 'JSA / JHA'
                          : _text(record['jsaNo']),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  _riskChip(residualLevel),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _openForm(existingRecord: record);
                      } else if (value == 'delete') {
                        _deleteRecord(_text(record['id']));
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
                ],
              ),
              const SizedBox(height: 5),
              Text(
                _text(record['activity']).isEmpty
                    ? 'Activity not specified'
                    : _text(record['activity']),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${_text(record['project']).isEmpty ? '-' : _text(record['project'])} 鈥� '
                '${_text(record['location']).isEmpty ? '-' : _text(record['location'])}',
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const Divider(height: 18),
              Text(
                'Work Step: ${_text(record['workStep']).isEmpty ? '-' : _text(record['workStep'])}',
              ),
              const SizedBox(height: 3),
              Text(
                'Hazard: ${_text(record['hazard']).isEmpty ? '-' : _text(record['hazard'])}',
              ),
              const SizedBox(height: 3),
              Text(
                'Initial Risk: $initialLevel (${_text(record['initialRiskScore']).isEmpty ? '-' : _text(record['initialRiskScore'])})',
              ),
              const SizedBox(height: 3),
              Text(
                'Residual Risk: $residualLevel (${_text(record['residualRiskScore']).isEmpty ? '-' : _text(record['residualRiskScore'])})',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: _riskColor(residualLevel),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Status: ${_text(record['status']).isEmpty ? '-' : _text(record['status'])}',
                    ),
                  ),
                  if (overdue)
                    Text(
                      '鈥� OVERDUE',
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Responsible: ${_text(record['responsiblePerson']).isEmpty ? '-' : _text(record['responsiblePerson'])}',
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 7),
              Text(
                'Review Date: ${_formatDate(_parseDate(record['reviewDate']))}',
                style: TextStyle(
                  color: overdue ? Colors.red.shade700 : Colors.grey.shade700,
                  fontWeight: overdue ? FontWeight.w700 : FontWeight.normal,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Created: ${_formatDate(_parseDate(record['createdAt']))} 鈥� '
                'Updated: ${_formatDate(_parseDate(record['updatedAt']))}',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _riskChip(String level) {
    final color = _riskColor(level);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        level.isEmpty ? '-' : level,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _JsaJhaFormPage extends StatefulWidget {
  final Map<String, dynamic>? existingRecord;
  final Color primaryGreen;
  final Color darkGreen;

  const _JsaJhaFormPage({
    required this.existingRecord,
    required this.primaryGreen,
    required this.darkGreen,
  });

  @override
  State<_JsaJhaFormPage> createState() => _JsaJhaFormPageState();
}

class _JsaJhaFormPageState extends State<_JsaJhaFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _jsaNo;
  late final TextEditingController _project;
  late final TextEditingController _location;
  late final TextEditingController _department;
  late final TextEditingController _activity;
  late final TextEditingController _workStep;
  late final TextEditingController _hazard;
  late final TextEditingController _consequence;
  late final TextEditingController _existingControls;
  late final TextEditingController _additionalControls;
  late final TextEditingController _responsiblePerson;
  late final TextEditingController _competency;
  late final TextEditingController _ppe;
  late final TextEditingController _permit;
  late final TextEditingController _equipment;
  late final TextEditingController _remarks;

  String _hazardCategory = 'General';
  String _status = 'Draft';

  int _initialLikelihood = 1;
  int _initialSeverity = 1;
  int _residualLikelihood = 1;
  int _residualSeverity = 1;

  DateTime? _reviewDate;

  final List<String> _hazardCategories = [
    'General',
    'Work at Height',
    'Lifting & Rigging',
    'Confined Space',
    'Excavation',
    'Electrical',
    'Fire & Hot Work',
    'Chemical',
    'Mechanical',
    'Vehicle & Traffic',
    'Environmental',
    'Occupational Health',
    'Emergency',
    'Other',
  ];

  final List<String> _statuses = [
    'Draft',
    'Under Review',
    'Approved',
    'Active',
    'Closed',
    'Cancelled',
  ];

  @override
  void initState() {
    super.initState();

    final r = widget.existingRecord;

    _jsaNo = TextEditingController(text: _value(r, 'jsaNo'));
    _project = TextEditingController(text: _value(r, 'project'));
    _location = TextEditingController(text: _value(r, 'location'));
    _department = TextEditingController(text: _value(r, 'department'));
    _activity = TextEditingController(text: _value(r, 'activity'));
    _workStep = TextEditingController(text: _value(r, 'workStep'));
    _hazard = TextEditingController(text: _value(r, 'hazard'));
    _consequence = TextEditingController(text: _value(r, 'consequence'));
    _existingControls =
        TextEditingController(text: _value(r, 'existingControls'));
    _additionalControls =
        TextEditingController(text: _value(r, 'additionalControls'));
    _responsiblePerson =
        TextEditingController(text: _value(r, 'responsiblePerson'));
    _competency = TextEditingController(text: _value(r, 'competency'));
    _ppe = TextEditingController(text: _value(r, 'ppe'));
    _permit = TextEditingController(text: _value(r, 'permit'));
    _equipment = TextEditingController(text: _value(r, 'equipment'));
    _remarks = TextEditingController(text: _value(r, 'remarks'));

    if (r != null) {
      final category = _value(r, 'hazardCategory');
      if (_hazardCategories.contains(category)) {
        _hazardCategory = category;
      }

      final status = _value(r, 'status');
      if (_statuses.contains(status)) {
        _status = status;
      }

      _initialLikelihood = _parseRating(r['initialLikelihood']);
      _initialSeverity = _parseRating(r['initialSeverity']);
      _residualLikelihood = _parseRating(r['residualLikelihood']);
      _residualSeverity = _parseRating(r['residualSeverity']);
      _reviewDate = _parseDate(r['reviewDate']);
    }
  }

  String _value(Map<String, dynamic>? record, String key) {
    return record?[key]?.toString() ?? '';
  }

  int _parseRating(dynamic value) {
    final parsed = int.tryParse(value?.toString() ?? '') ?? 1;
    if (parsed < 1) return 1;
    if (parsed > 5) return 5;
    return parsed;
  }

  int _score(int likelihood, int severity) => likelihood * severity;

  String _level(int likelihood, int severity) {
    final score = _score(likelihood, severity);
    if (score <= 4) return 'Low';
    if (score <= 11) return 'Medium';
    if (score <= 19) return 'High';
    return 'Critical';
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  Future<void> _pickReviewDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _reviewDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => _reviewDate = picked);
    }
  }

  void _clearReviewDate() {
    setState(() => _reviewDate = null);
  }

  Map<String, dynamic> _buildRecord() {
    final now = DateTime.now();
    final existing = widget.existingRecord;

    return {
      'id': existing?['id']?.toString() ??
          '${now.microsecondsSinceEpoch}_${_jsaNo.text.trim()}',
      'jsaNo': _jsaNo.text.trim(),
      'project': _project.text.trim(),
      'location': _location.text.trim(),
      'department': _department.text.trim(),
      'activity': _activity.text.trim(),
      'workStep': _workStep.text.trim(),
      'hazard': _hazard.text.trim(),
      'hazardCategory': _hazardCategory,
      'consequence': _consequence.text.trim(),
      'existingControls': _existingControls.text.trim(),
      'initialLikelihood': _initialLikelihood,
      'initialSeverity': _initialSeverity,
      'initialRiskScore': _score(_initialLikelihood, _initialSeverity),
      'initialRiskLevel': _level(_initialLikelihood, _initialSeverity),
      'additionalControls': _additionalControls.text.trim(),
      'responsiblePerson': _responsiblePerson.text.trim(),
      'residualLikelihood': _residualLikelihood,
      'residualSeverity': _residualSeverity,
      'residualRiskScore': _score(_residualLikelihood, _residualSeverity),
      'residualRiskLevel': _level(_residualLikelihood, _residualSeverity),
      'competency': _competency.text.trim(),
      'ppe': _ppe.text.trim(),
      'permit': _permit.text.trim(),
      'equipment': _equipment.text.trim(),
      'status': _status,
      'reviewDate': _reviewDate?.toIso8601String(),
      'remarks': _remarks.text.trim(),
      'createdAt': existing?['createdAt']?.toString() ?? now.toIso8601String(),
      'updatedAt': now.toIso8601String(),
    };
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.pop(context, _buildRecord());
  }

  @override
  void dispose() {
    _jsaNo.dispose();
    _project.dispose();
    _location.dispose();
    _department.dispose();
    _activity.dispose();
    _workStep.dispose();
    _hazard.dispose();
    _consequence.dispose();
    _existingControls.dispose();
    _additionalControls.dispose();
    _responsiblePerson.dispose();
    _competency.dispose();
    _ppe.dispose();
    _permit.dispose();
    _equipment.dispose();
    _remarks.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final initialScore = _score(_initialLikelihood, _initialSeverity);
    final initialLevel = _level(_initialLikelihood, _initialSeverity);
    final residualScore = _score(_residualLikelihood, _residualSeverity);
    final residualLevel = _level(_residualLikelihood, _residualSeverity);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: Text(
          widget.existingRecord == null ? 'Add JSA / JHA' : 'Edit JSA / JHA',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: widget.primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 30),
          children: [
            _sectionTitle('1. Job / Activity Information'),
            _field(
              controller: _jsaNo,
              label: 'JSA / JHA No.',
              required: true,
            ),
            _field(controller: _project, label: 'Project'),
            _field(controller: _location, label: 'Work Location'),
            _field(
              controller: _department,
              label: 'Department / Work Group',
            ),
            _field(
              controller: _activity,
              label: 'Activity / Job',
              required: true,
            ),
            _field(
              controller: _workStep,
              label: 'Work Step / Task',
              required: true,
              maxLines: 3,
            ),
            DropdownButtonFormField<String>(
              initialValue: _hazardCategory,
              decoration: const InputDecoration(
                labelText: 'Hazard Category',
                border: OutlineInputBorder(),
              ),
              items: _hazardCategories
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _hazardCategory = value);
                }
              },
            ),
            const SizedBox(height: 12),
            _field(
              controller: _hazard,
              label: 'Hazard',
              required: true,
              maxLines: 3,
            ),
            _field(
              controller: _consequence,
              label: 'Potential Consequence',
              maxLines: 3,
            ),
            _field(
              controller: _existingControls,
              label: 'Existing Control Measures',
              maxLines: 4,
            ),
            _riskSection(
              title: '2. Initial Risk Assessment',
              likelihood: _initialLikelihood,
              severity: _initialSeverity,
              score: initialScore,
              level: initialLevel,
              onLikelihoodChanged: (value) {
                setState(() => _initialLikelihood = value);
              },
              onSeverityChanged: (value) {
                setState(() => _initialSeverity = value);
              },
            ),
            _sectionTitle('3. Additional Controls'),
            _field(
              controller: _additionalControls,
              label: 'Additional Control Measures',
              maxLines: 5,
            ),
            _field(
              controller: _responsiblePerson,
              label: 'Responsible Person',
            ),
            _field(
              controller: _competency,
              label: 'Required Competency / Training',
              maxLines: 3,
            ),
            _field(
              controller: _ppe,
              label: 'Required PPE',
              maxLines: 3,
            ),
            _field(
              controller: _permit,
              label: 'Required Permit',
              maxLines: 2,
            ),
            _field(
              controller: _equipment,
              label: 'Equipment / Tools',
              maxLines: 3,
            ),
            _riskSection(
              title: '4. Residual Risk Assessment',
              likelihood: _residualLikelihood,
              severity: _residualSeverity,
              score: residualScore,
              level: residualLevel,
              onLikelihoodChanged: (value) {
                setState(() => _residualLikelihood = value);
              },
              onSeverityChanged: (value) {
                setState(() => _residualSeverity = value);
              },
            ),
            _sectionTitle('5. Review & Status'),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Review Date'),
              subtitle: Text(_formatDate(_reviewDate)),
              leading: const Icon(Icons.event),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: 'Select date',
                    onPressed: _pickReviewDate,
                    icon: const Icon(Icons.calendar_month),
                  ),
                  if (_reviewDate != null)
                    IconButton(
                      tooltip: 'Clear date',
                      onPressed: _clearReviewDate,
                      icon: const Icon(Icons.clear),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            DropdownButtonFormField<String>(
              initialValue: _status,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
              items: _statuses
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _status = value);
                }
              },
            ),
            const SizedBox(height: 12),
            _field(
              controller: _remarks,
              label: 'Remarks',
              maxLines: 4,
            ),
            const SizedBox(height: 18),
            _buildRiskReference(),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save),
              label: Text(
                widget.existingRecord == null
                    ? 'Save JSA / JHA'
                    : 'Update JSA / JHA',
              ),
              style: FilledButton.styleFrom(
                backgroundColor: widget.primaryGreen,
                minimumSize: const Size.fromHeight(52),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          color: widget.darkGreen,
          fontSize: 17,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    bool required = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          border: const OutlineInputBorder(),
        ),
        validator: required
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return '$label is required';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _riskSection({
    required String title,
    required int likelihood,
    required int severity,
    required int score,
    required String level,
    required ValueChanged<int> onLikelihoodChanged,
    required ValueChanged<int> onSeverityChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: widget.darkGreen,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _rating(
                    label: 'Likelihood',
                    value: likelihood,
                    onChanged: onLikelihoodChanged,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _rating(
                    label: 'Severity',
                    value: severity,
                    onChanged: onSeverityChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _riskColor(level).withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Risk Score: $score',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    level,
                    style: TextStyle(
                      color: _riskColor(level),
                      fontWeight: FontWeight.w900,
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

  Widget _rating({
    required String label,
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    return DropdownButtonFormField<int>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: List.generate(
        5,
        (index) {
          final number = index + 1;
          return DropdownMenuItem(
            value: number,
            child: Text('$number'),
          );
        },
      ),
      onChanged: (newValue) {
        if (newValue != null) {
          onChanged(newValue);
        }
      },
    );
  }

  Color _riskColor(String level) {
    switch (level) {
      case 'Critical':
        return Colors.red.shade800;
      case 'High':
        return Colors.red.shade600;
      case 'Medium':
        return Colors.orange.shade700;
      case 'Low':
        return widget.primaryGreen;
      default:
        return Colors.grey;
    }
  }

  Widget _buildRiskReference() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '5 脳 5 Risk Matrix Reference',
              style: TextStyle(
                color: widget.darkGreen,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 7),
            const Text('Risk Score = Likelihood 脳 Severity'),
            const SizedBox(height: 5),
            const Text('1鈥�4 Low 鈥� 5鈥�11 Medium 鈥� 12鈥�19 High 鈥� 20鈥�25 Critical'),
          ],
        ),
      ),
    );
  }
}
