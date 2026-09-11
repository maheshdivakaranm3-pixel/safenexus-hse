import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiraRiskAssessmentPage extends StatefulWidget {
  const HiraRiskAssessmentPage({super.key});

  @override
  State<HiraRiskAssessmentPage> createState() => _HiraRiskAssessmentPageState();
}

class _HiraRiskAssessmentPageState extends State<HiraRiskAssessmentPage> {
  static const String _storageKey = 'safenexus_hse_hira_risk_assessments';
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _records = <Map<String, dynamic>>[];
  String _riskFilter = 'All';
  String _statusFilter = 'All';
  bool _loading = true;

  final List<String> _hazardCategories = const <String>[
    'General','Work at Height','Lifting & Rigging','Confined Space',
    'Excavation','Electrical','Fire & Hot Work','Chemical','Mechanical',
    'Vehicle & Traffic','Environmental','Occupational Health','Emergency','Other',
  ];

  final List<String> _statuses = const <String>[
    'Draft','Under Review','Approved','Active','Closed','Cancelled',
  ];

  final List<String> _riskFilters = const <String>[
    'All','Low','Medium','High','Critical',
  ];

  @override
  void initState() {
    super.initState();
    _loadRecords();
    _searchController.addListener(_refresh);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refresh)
      ..dispose();
    super.dispose();
  }

  Future<void> _loadRecords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? raw = prefs.getString(_storageKey);
    if (raw != null && raw.isNotEmpty) {
      try {
        final dynamic decoded = jsonDecode(raw);
        if (decoded is List) {
          _records = decoded
              .whereType<Map>()
              .map((Map item) => Map<String, dynamic>.from(item))
              .toList();
        }
      } catch (_) {
        _records = <Map<String, dynamic>>[];
      }
    }
    if (!mounted) return;
    setState(() => _loading = false);
  }

  Future<void> _saveRecords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(_records));
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  String _s(dynamic value) => value?.toString() ?? '';

  DateTime? _date(dynamic value) => value == null
      ? null
      : DateTime.tryParse(value.toString());

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _formatDateTime(dynamic value) {
    final DateTime? date = _date(value);
    if (date == null) return '-';
    return '${_formatDate(date)} ${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  int _score(int likelihood, int severity) => likelihood * severity;

  String _level(int score) {
    if (score >= 20) return 'Critical';
    if (score >= 12) return 'High';
    if (score >= 5) return 'Medium';
    return 'Low';
  }

  Color _riskColor(String level) {
    switch (level) {
      case 'Critical': return Colors.red.shade800;
      case 'High': return Colors.red.shade600;
      case 'Medium': return Colors.orange.shade700;
      case 'Low': return primaryGreen;
      default: return Colors.grey.shade600;
    }
  }

  int _statusCount(String status) =>
      _records.where((Map<String, dynamic> r) => r['status'] == status).length;

  int _riskCount(String risk) =>
      _records.where((Map<String, dynamic> r) => r['residualRiskLevel'] == risk).length;

  int get _overdueCount {
    final DateTime today = DateTime.now();
    final DateTime start = DateTime(today.year, today.month, today.day);
    return _records.where((Map<String, dynamic> r) {
      final DateTime? review = _date(r['reviewDate']);
      return review != null &&
          review.isBefore(start) &&
          r['status'] != 'Closed' &&
          r['status'] != 'Cancelled';
    }).length;
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final String q = _searchController.text.trim().toLowerCase();
    return _records.where((Map<String, dynamic> r) {
      final String risk = _s(r['residualRiskLevel']);
      final String status = _s(r['status']);
      if (_riskFilter != 'All' && risk != _riskFilter) return false;
      if (_statusFilter != 'All' && status != _statusFilter) return false;
      if (q.isEmpty) return true;
      final String text = <String>[
        r['assessmentNo'],r['project'],r['location'],r['department'],
        r['activity'],r['hazard'],r['hazardCategory'],r['consequence'],
        r['responsiblePerson'],r['status'],r['residualRiskLevel'],
        r['initialRiskLevel'],
      ].map(_s).join(' ').toLowerCase();
      return text.contains(q);
    }).toList();
  }

  bool _overdue(Map<String, dynamic> r) {
    final DateTime? review = _date(r['reviewDate']);
    if (review == null) return false;
    final DateTime now = DateTime.now();
    return review.isBefore(DateTime(now.year, now.month, now.day)) &&
        r['status'] != 'Closed' && r['status'] != 'Cancelled';
  }

  Future<void> _openForm({Map<String, dynamic>? existing}) async {
    final Map<String, dynamic>? result =
        await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => _HiraForm(
        existing: existing,
        categories: _hazardCategories,
        statuses: _statuses,
      ),
    );
    if (result == null) return;

    final DateTime now = DateTime.now();
    if (existing == null) {
      result['id'] = now.microsecondsSinceEpoch.toString();
      result['createdAt'] = now.toIso8601String();
      result['updatedAt'] = now.toIso8601String();
      _records.insert(0, result);
    } else {
      final int index = _records.indexWhere(
        (Map<String, dynamic> r) => r['id'] == existing['id'],
      );
      if (index >= 0) {
        result['id'] = existing['id'];
        result['createdAt'] = existing['createdAt'] ?? now.toIso8601String();
        result['updatedAt'] = now.toIso8601String();
        _records[index] = result;
      }
    }

    await _saveRecords();
    if (!mounted) return;
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(existing == null
            ? 'HIRA saved successfully'
            : 'HIRA updated successfully'),
        backgroundColor: primaryGreen,
      ),
    );
  }

  Future<void> _delete(Map<String, dynamic> record) async {
    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete HIRA?'),
        content: Text(
          'Delete ${_s(record['assessmentNo']).isEmpty ? 'this assessment' : record['assessmentNo']} permanently?',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade700),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    _records.removeWhere((Map<String, dynamic> r) => r['id'] == record['id']);
    await _saveRecords();
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _changeReviewDate(Map<String, dynamic> record) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: _date(record['reviewDate']) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selected == null) return;
    record['reviewDate'] = selected.toIso8601String();
    record['updatedAt'] = DateTime.now().toIso8601String();
    await _saveRecords();
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('HIRA & Risk Assessment',
            style: TextStyle(fontWeight: FontWeight.w700)),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add HIRA'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadRecords,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: <Widget>[
                  SliverToBoxAdapter(child: _intro()),
                  SliverToBoxAdapter(child: _dashboard()),
                  SliverToBoxAdapter(child: _filters()),
                  if (_filteredRecords.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: _empty(),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 100),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) =>
                              _recordCard(_filteredRecords[index]),
                          childCount: _filteredRecords.length,
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Widget _intro() => Container(
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: <Color>[darkGreen, primaryGreen]),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: <Widget>[
              Icon(Icons.health_and_safety, color: Colors.white, size: 30),
              SizedBox(width: 10),
              Expanded(
                child: Text('Hazard Identification & Risk Assessment',
                    style: TextStyle(color: Colors.white, fontSize: 19,
                        fontWeight: FontWeight.w800)),
              ),
            ]),
            SizedBox(height: 8),
            Text(
              'Identify hazards, evaluate initial risk, define controls and verify residual risk before work starts.',
              style: TextStyle(color: Colors.white, height: 1.35),
            ),
          ],
        ),
      );

  Widget _dashboard() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            Expanded(child: _metric('Total', _records.length, Icons.list_alt)),
            const SizedBox(width: 8),
            Expanded(child: _metric('Active', _statusCount('Active'), Icons.play_circle)),
            const SizedBox(width: 8),
            Expanded(child: _metric('High+', _riskCount('High') + _riskCount('Critical'), Icons.warning)),
          ]),
          const SizedBox(height: 8),
          Row(children: <Widget>[
            Expanded(child: _metric('Medium', _riskCount('Medium'), Icons.report_problem)),
            const SizedBox(width: 8),
            Expanded(child: _metric('Low', _riskCount('Low'), Icons.check_circle)),
            const SizedBox(width: 8),
            Expanded(child: _metric('Overdue', _overdueCount, Icons.event_busy)),
          ]),
        ]),
      );

  Widget _metric(String label, int value, IconData icon) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(children: <Widget>[
          Icon(icon, color: primaryGreen, size: 22),
          const SizedBox(width: 8),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('$value', style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
              Text(label, overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
            ],
          )),
        ]),
      );

  Widget _filters() => Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
        child: Column(children: <Widget>[
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search HIRA, activity, hazard, location...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isEmpty
                  ? null
                  : IconButton(onPressed: _searchController.clear, icon: const Icon(Icons.clear)),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(children: <Widget>[
            Expanded(child: _dropdown(
              'Residual Risk', _riskFilter, _riskFilters,
              (String? v) { if (v != null) setState(() => _riskFilter = v); },
            )),
            const SizedBox(width: 8),
            Expanded(child: _dropdown(
              'Status', _statusFilter, <String>['All', ..._statuses],
              (String? v) { if (v != null) setState(() => _statusFilter = v); },
            )),
          ]),
        ]),
      );

  Widget _dropdown(String label, String value, List<String> items,
      ValueChanged<String?> onChanged) => DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
        items: items.map((String item) => DropdownMenuItem<String>(
          value: item, child: Text(item),
        )).toList(),
        onChanged: onChanged,
      );

  Widget _recordCard(Map<String, dynamic> r) {
    final String level = _s(r['residualRiskLevel']);
    final int score = int.tryParse(_s(r['residualRiskScore'])) ?? 0;
    final int initial = int.tryParse(_s(r['initialRiskScore'])) ?? 0;
    final bool overdue = _overdue(r);
    final Color color = _riskColor(level);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.12),
          child: Text('$score', style: TextStyle(color: color, fontWeight: FontWeight.w800)),
        ),
        title: Text(_s(r['assessmentNo']).isEmpty ? 'HIRA Assessment' : _s(r['assessmentNo']),
            style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text(
          '${_s(r['activity']).isEmpty ? 'Activity not specified' : r['activity']}'
          ' 鈥� ${_s(r['location']).isEmpty ? 'Location not specified' : r['location']}',
          maxLines: 2, overflow: TextOverflow.ellipsis,
        ),
        trailing: _badge(level),
        childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        children: <Widget>[
          _line('Project', r['project']),
          _line('Department / Work Group', r['department']),
          _line('Activity / Task', r['activity']),
          _line('Hazard', r['hazard']),
          _line('Hazard Category', r['hazardCategory']),
          _line('Potential Consequence', r['consequence']),
          _line('Existing Controls', r['existingControls']),
          _line('Initial Risk', '$initial (${_s(r['initialRiskLevel'])})'),
          _line('Additional Controls', r['additionalControls']),
          _line('Responsible Person', r['responsiblePerson']),
          _line('Residual Risk', '$score ($level)'),
          _line('Status', r['status']),
          _line('Review Date', _formatDate(_date(r['reviewDate']))),
          if (overdue)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(children: <Widget>[
                Icon(Icons.warning_amber, color: Colors.red),
                SizedBox(width: 8),
                Expanded(child: Text('Review overdue 鈥� reassessment should be considered.',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700))),
              ]),
            ),
          _line('Remarks', r['remarks']),
          const SizedBox(height: 8),
          Row(children: <Widget>[
            Expanded(child: OutlinedButton.icon(
              onPressed: () => _openForm(existing: r),
              icon: const Icon(Icons.edit), label: const Text('Edit'),
            )),
            const SizedBox(width: 8),
            Expanded(child: OutlinedButton.icon(
              onPressed: () => _changeReviewDate(r),
              icon: const Icon(Icons.event), label: const Text('Review Date'),
            )),
            IconButton(
              onPressed: () => _delete(r),
              color: Colors.red.shade700,
              icon: const Icon(Icons.delete_outline),
            ),
          ]),
          Text(
            'Created: ${_formatDateTime(r['createdAt'])} 鈥� Updated: ${_formatDateTime(r['updatedAt'])}',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _line(String label, dynamic value) {
    final String text = _s(value);
    if (text.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: RichText(text: TextSpan(
        style: TextStyle(color: Colors.grey.shade800, fontSize: 13, height: 1.3),
        children: <InlineSpan>[
          TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.w700)),
          TextSpan(text: text),
        ],
      )),
    );
  }

  Widget _badge(String level) {
    final Color color = _riskColor(level);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(level.isEmpty ? '-' : level,
          style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w800)),
    );
  }

  Widget _empty() => Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.health_and_safety_outlined, size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 12),
              const Text('No HIRA records found',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              Text(
                _records.isEmpty
                    ? 'Tap 鈥淎dd HIRA鈥� to create the first risk assessment.'
                    : 'Try changing the search or filters.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      );
}

class _HiraForm extends StatefulWidget {
  const _HiraForm({
    required this.existing,
    required this.categories,
    required this.statuses,
  });

  final Map<String, dynamic>? existing;
  final List<String> categories;
  final List<String> statuses;

  @override
  State<_HiraForm> createState() => _HiraFormState();
}

class _HiraFormState extends State<_HiraForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _no;
  late final TextEditingController _project;
  late final TextEditingController _location;
  late final TextEditingController _department;
  late final TextEditingController _activity;
  late final TextEditingController _hazard;
  late final TextEditingController _consequence;
  late final TextEditingController _existingControls;
  late final TextEditingController _additionalControls;
  late final TextEditingController _responsible;
  late final TextEditingController _remarks;

  late String _category;
  late String _status;
  int _initialLikelihood = 1;
  int _initialSeverity = 1;
  int _residualLikelihood = 1;
  int _residualSeverity = 1;
  DateTime? _reviewDate;

  bool get _editing => widget.existing != null;

  int _score(int l, int s) => l * s;
  String _level(int score) {
    if (score >= 20) return 'Critical';
    if (score >= 12) return 'High';
    if (score >= 5) return 'Medium';
    return 'Low';
  }

  String _text(dynamic v) => v?.toString() ?? '';
  int _rating(dynamic v) {
    final int parsed = int.tryParse(_text(v)) ?? 1;
    if (parsed < 1) return 1;
    if (parsed > 5) return 5;
    return parsed;
  }

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> r = widget.existing ?? <String, dynamic>{};
    _no = TextEditingController(text: _text(r['assessmentNo']));
    _project = TextEditingController(text: _text(r['project']));
    _location = TextEditingController(text: _text(r['location']));
    _department = TextEditingController(text: _text(r['department']));
    _activity = TextEditingController(text: _text(r['activity']));
    _hazard = TextEditingController(text: _text(r['hazard']));
    _consequence = TextEditingController(text: _text(r['consequence']));
    _existingControls = TextEditingController(text: _text(r['existingControls']));
    _additionalControls = TextEditingController(text: _text(r['additionalControls']));
    _responsible = TextEditingController(text: _text(r['responsiblePerson']));
    _remarks = TextEditingController(text: _text(r['remarks']));

    _category = widget.categories.contains(r['hazardCategory'])
        ? _text(r['hazardCategory']) : 'General';
    _status = widget.statuses.contains(r['status'])
        ? _text(r['status']) : 'Draft';
    _initialLikelihood = _rating(r['initialLikelihood']);
    _initialSeverity = _rating(r['initialSeverity']);
    _residualLikelihood = _rating(r['residualLikelihood']);
    _residualSeverity = _rating(r['residualSeverity']);
    _reviewDate = DateTime.tryParse(_text(r['reviewDate']));
  }

  @override
  void dispose() {
    _no.dispose(); _project.dispose(); _location.dispose(); _department.dispose();
    _activity.dispose(); _hazard.dispose(); _consequence.dispose();
    _existingControls.dispose(); _additionalControls.dispose();
    _responsible.dispose(); _remarks.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: _reviewDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selected != null) setState(() => _reviewDate = selected);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final int initialScore = _score(_initialLikelihood, _initialSeverity);
    final int residualScore = _score(_residualLikelihood, _residualSeverity);

    Navigator.pop(context, <String, dynamic>{
      'assessmentNo': _no.text.trim(),
      'project': _project.text.trim(),
      'location': _location.text.trim(),
      'department': _department.text.trim(),
      'activity': _activity.text.trim(),
      'hazard': _hazard.text.trim(),
      'hazardCategory': _category,
      'consequence': _consequence.text.trim(),
      'existingControls': _existingControls.text.trim(),
      'initialLikelihood': _initialLikelihood,
      'initialSeverity': _initialSeverity,
      'initialRiskScore': initialScore,
      'initialRiskLevel': _level(initialScore),
      'additionalControls': _additionalControls.text.trim(),
      'responsiblePerson': _responsible.text.trim(),
      'residualLikelihood': _residualLikelihood,
      'residualSeverity': _residualSeverity,
      'residualRiskScore': residualScore,
      'residualRiskLevel': _level(residualScore),
      'status': _status,
      'reviewDate': _reviewDate?.toIso8601String(),
      'remarks': _remarks.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final double bottom = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.94,
        decoration: const BoxDecoration(
          color: Color(0xFFF6F8F7),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(18, 12, 8, 10),
            color: Colors.white,
            child: Row(children: <Widget>[
              Expanded(child: Text(_editing ? 'Edit HIRA' : 'Add HIRA',
                  style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800))),
              IconButton(onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close)),
            ]),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 28 + bottom),
                children: <Widget>[
                  _section('1. Assessment Information'),
                  _field(_no, 'HIRA / Risk Assessment No.', required: true, hint: 'Example: HIRA-001'),
                  _field(_project, 'Project'),
                  _field(_location, 'Work Location'),
                  _field(_department, 'Department / Work Group'),
                  _field(_activity, 'Activity / Task', required: true),
                  _section('2. Hazard Identification'),
                  _drop('Hazard Category', _category, widget.categories,
                      (String? v) { if (v != null) setState(() => _category = v); }),
                  _field(_hazard, 'Hazard', required: true, maxLines: 3,
                      hint: 'What can cause harm?'),
                  _field(_consequence, 'Potential Consequence', maxLines: 3,
                      hint: 'What could happen?'),
                  _field(_existingControls, 'Existing Control Measures', maxLines: 4),
                  _section('3. Initial Risk Assessment'),
                  _rating('Likelihood', _initialLikelihood,
                      (int v) => setState(() => _initialLikelihood = v)),
                  _rating('Severity', _initialSeverity,
                      (int v) => setState(() => _initialSeverity = v)),
                  _riskBox('Initial Risk', _score(_initialLikelihood, _initialSeverity)),
                  _section('4. Additional Controls'),
                  _field(_additionalControls, 'Additional Control Measures', maxLines: 5),
                  _field(_responsible, 'Responsible Person'),
                  _section('5. Residual Risk Assessment'),
                  _rating('Residual Likelihood', _residualLikelihood,
                      (int v) => setState(() => _residualLikelihood = v)),
                  _rating('Residual Severity', _residualSeverity,
                      (int v) => setState(() => _residualSeverity = v)),
                  _riskBox('Residual Risk', _score(_residualLikelihood, _residualSeverity)),
                  _section('6. Review & Status'),
                  _drop('Status', _status, widget.statuses,
                      (String? v) { if (v != null) setState(() => _status = v); }),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    tileColor: Colors.white,
                    leading: const Icon(Icons.event, color: primaryGreen),
                    title: const Text('Review Date',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text(_reviewDate == null ? 'Not selected' : _formatDate(_reviewDate!)),
                    trailing: TextButton(onPressed: _selectDate, child: const Text('Select')),
                  ),
                  _field(_remarks, 'Remarks', maxLines: 4),
                  const SizedBox(height: 12),
                  _matrix(),
                  const SizedBox(height: 18),
                  FilledButton.icon(
                    onPressed: _submit,
                    style: FilledButton.styleFrom(
                      backgroundColor: primaryGreen,
                      minimumSize: const Size.fromHeight(52),
                    ),
                    icon: Icon(_editing ? Icons.save : Icons.add_task),
                    label: Text(_editing ? 'Update HIRA' : 'Save HIRA'),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _section(String title) => Padding(
    padding: const EdgeInsets.fromLTRB(0, 18, 0, 9),
    child: Text(title, style: const TextStyle(
      color: darkGreen, fontSize: 16, fontWeight: FontWeight.w800)),
  );

  Widget _field(TextEditingController c, String label,
      {bool required = false, String? hint, int maxLines = 1}) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      controller: c,
      maxLines: maxLines,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: required ? '$label *' : label,
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        alignLabelWithHint: maxLines > 1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none,
        ),
      ),
      validator: required
          ? (String? v) => v == null || v.trim().isEmpty ? '$label is required' : null
          : null,
    ),
  );

  Widget _drop(String label, String value, List<String> items,
      ValueChanged<String?> onChanged) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none,
        ),
      ),
      items: items.map((String item) => DropdownMenuItem<String>(
        value: item, child: Text(item),
      )).toList(),
      onChanged: onChanged,
    ),
  );

  Widget _rating(String title, int value, ValueChanged<int> onChanged) =>
      Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13)),
        child: Row(children: <Widget>[
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700))),
          DropdownButton<int>(
            value: value,
            items: List<int>.generate(5, (int i) => i + 1)
                .map((int n) => DropdownMenuItem<int>(value: n, child: Text('$n')))
                .toList(),
            onChanged: (int? v) { if (v != null) onChanged(v); },
          ),
        ]),
      );

  Widget _riskBox(String title, int score) {
    final String level = _level(score);
    final Color color = _riskColor(level);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(children: <Widget>[
        Icon(Icons.speed, color: color),
        const SizedBox(width: 10),
        Expanded(child: Text('$title 鈥� Score: $score',
            style: const TextStyle(fontWeight: FontWeight.w700))),
        Text(level, style: TextStyle(color: color, fontWeight: FontWeight.w900)),
      ]),
    );
  }

  Widget _matrix() => Card(
    elevation: 0,
    color: Colors.white,
    child: ExpansionTile(
      title: const Text('5 脳 5 Risk Matrix Reference',
          style: TextStyle(fontWeight: FontWeight.w800)),
      childrenPadding: const EdgeInsets.all(12),
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Table(
            defaultColumnWidth: const FixedColumnWidth(52),
            border: TableBorder.all(color: Colors.grey),
            children: <TableRow>[
              TableRow(children: <Widget>[
                _cell('L/S', bold: true), ...List<Widget>.generate(5, (int i) => _cell('${i + 1}', bold: true)),
              ]),
              ...List<TableRow>.generate(5, (int li) => TableRow(children: <Widget>[
                _cell('${li + 1}', bold: true),
                ...List<Widget>.generate(5, (int si) {
                  final int score = (li + 1) * (si + 1);
                  return _cell('$score', color: _riskColor(_level(score)));
                }),
              ])),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Text('1鈥�4 Low  鈥�  5鈥�11 Medium  鈥�  12鈥�19 High  鈥�  20鈥�25 Critical',
            style: TextStyle(fontWeight: FontWeight.w700)),
      ],
    ),
  );

  Widget _cell(String text, {Color? color, bool bold = false}) => Container(
    height: 40,
    alignment: Alignment.center,
    color: color?.withValues(alpha: 0.12),
    child: Text(text, style: TextStyle(
      color: color ?? Colors.black87,
      fontWeight: bold ? FontWeight.w800 : FontWeight.w700)),
  );

  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

  Color _riskColor(String level) {
    switch (level) {
      case 'Critical': return Colors.red.shade800;
      case 'High': return Colors.red.shade600;
      case 'Medium': return Colors.orange.shade700;
      case 'Low': return const Color(0xFF159447);
      default: return Colors.grey.shade600;
    }
  }
}
