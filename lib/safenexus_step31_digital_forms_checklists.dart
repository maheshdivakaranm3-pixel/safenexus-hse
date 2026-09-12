import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE — Step 31
/// HSE Digital Forms & Smart Checklist Center
///
/// 31A HSE Forms Master
/// 31B Daily HSE Checklist
/// 31C Site Safety Inspection Checklist
/// 31D Equipment / Pre-Use Checklist
/// 31E PTW Verification Checklist
/// 31F Risk Control Verification Checklist
/// 31G Emergency Preparedness Checklist
/// 31H Environmental Checklist
/// 31I Worker / PPE Compliance Checklist
/// 31J Audit / Compliance Checklist
/// 31K Checklist Action & Closure
/// 31L Smart Forms & Checklist Intelligence Dashboard
///
/// Core workflow:
/// Select Form -> Fill Checklist -> Identify Finding -> Assign Action
/// -> Verify -> Close -> Performance Analysis
///
/// This module is a local digital-form/checklist register. It does not
/// automatically certify compliance or submit records to an authority.

class SafeNexusStep31 extends StatefulWidget {
  const SafeNexusStep31({super.key});

  @override
  State<SafeNexusStep31> createState() => _SafeNexusStep31State();
}

class _SafeNexusStep31State extends State<SafeNexusStep31> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_step31_digital_forms_checklists';

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _records = <Map<String, dynamic>>[];
  bool _loading = true;

  String _formFilter = 'All';
  String _statusFilter = 'All';
  String _priorityFilter = 'All';
  String _resultFilter = 'All';
  bool _showOverdueOnly = false;

  static const List<String> formTypes = <String>[
    'HSE Forms Master',
    'Daily HSE Checklist',
    'Site Safety Inspection Checklist',
    'Equipment / Pre-Use Checklist',
    'PTW Verification Checklist',
    'Risk Control Verification Checklist',
    'Emergency Preparedness Checklist',
    'Environmental Checklist',
    'Worker / PPE Compliance Checklist',
    'Audit / Compliance Checklist',
    'Checklist Action & Closure',
    'Smart Form',
    'Other',
  ];

  static const List<String> statuses = <String>[
    'Draft',
    'Assigned',
    'In Progress',
    'Submitted',
    'Under Review',
    'Action Required',
    'Verification Required',
    'Verified',
    'Closed',
    'Cancelled',
  ];

  static const List<String> priorities = <String>[
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static const List<String> results = <String>[
    'Not Started',
    'Pass',
    'Pass with Observation',
    'Partial',
    'Fail',
    'Critical Finding',
    'Not Applicable',
  ];

  static const List<String> checklistAnswers = <String>[
    'Pass',
    'Fail',
    'Observation',
    'Not Applicable',
    'Not Checked',
  ];

  static const List<String> frequencies = <String>[
    'One Time',
    'Daily',
    'Weekly',
    'Monthly',
    'Quarterly',
    'Event Based',
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_refresh);
    _loadRecords();
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refresh)
      ..dispose();
    super.dispose();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);

    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          _records = decoded
              .whereType<Map>()
              .map((item) => Map<String, dynamic>.from(item))
              .toList();
        }
      } catch (_) {
        _records = <Map<String, dynamic>>[];
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

  DateTime? _parseDate(dynamic value) {
    if (value is! String || value.trim().isEmpty) return null;
    return DateTime.tryParse(value);
  }

  bool _isOverdue(Map<String, dynamic> record) {
    final due = _parseDate(record['dueDate']);
    if (due == null) return false;

    final status = record['status']?.toString() ?? '';
    if (status == 'Verified' ||
        status == 'Closed' ||
        status == 'Cancelled') {
      return false;
    }

    return due.isBefore(DateTime.now());
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchController.text.trim().toLowerCase();

    final result = _records.where((record) {
      final searchable = <dynamic>[
        record['formNo'],
        record['title'],
        record['formType'],
        record['project'],
        record['site'],
        record['location'],
        record['inspector'],
        record['assignedTo'],
        record['actionOwner'],
        record['finding'],
        record['reference'],
      ];

      final matchesSearch = query.isEmpty ||
          searchable.any(
            (value) => value.toString().toLowerCase().contains(query),
          );

      final matchesForm =
          _formFilter == 'All' || record['formType'] == _formFilter;
      final matchesStatus =
          _statusFilter == 'All' || record['status'] == _statusFilter;
      final matchesPriority =
          _priorityFilter == 'All' || record['priority'] == _priorityFilter;
      final matchesResult =
          _resultFilter == 'All' || record['overallResult'] == _resultFilter;
      final matchesOverdue =
          !_showOverdueOnly || _isOverdue(record);

      return matchesSearch &&
          matchesForm &&
          matchesStatus &&
          matchesPriority &&
          matchesResult &&
          matchesOverdue;
    }).toList();

    result.sort((a, b) {
      final aDate =
          _parseDate(a['updatedAt']) ??
              DateTime.fromMillisecondsSinceEpoch(0);
      final bDate =
          _parseDate(b['updatedAt']) ??
              DateTime.fromMillisecondsSinceEpoch(0);
      return bDate.compareTo(aDate);
    });

    return result;
  }

  int _count(bool Function(Map<String, dynamic>) test) =>
      _records.where(test).length;

  int get _total => _records.length;

  int get _open => _count(
        (r) =>
            r['status'] == 'Assigned' ||
            r['status'] == 'In Progress' ||
            r['status'] == 'Submitted' ||
            r['status'] == 'Under Review' ||
            r['status'] == 'Action Required' ||
            r['status'] == 'Verification Required',
      );

  int get _findings => _count(
        (r) =>
            r['overallResult'] == 'Fail' ||
            r['overallResult'] == 'Critical Finding' ||
            r['overallResult'] == 'Partial' ||
            r['overallResult'] == 'Pass with Observation',
      );

  int get _critical => _count(
        (r) =>
            r['priority'] == 'Critical' &&
            r['status'] != 'Closed' &&
            r['status'] != 'Cancelled',
      );

  int get _overdue => _count(_isOverdue);

  int get _verified => _count(
        (r) => r['status'] == 'Verified' || r['status'] == 'Closed',
      );

  int get _actions => _count(
        (r) =>
            r['status'] == 'Action Required' ||
            r['status'] == 'Verification Required',
      );

  double get _closureRate {
    if (_total == 0) return 0;
    return _verified * 100 / _total;
  }

  double get _passRate {
    if (_total == 0) return 0;
    final passed = _count(
      (r) =>
          r['overallResult'] == 'Pass' ||
          r['overallResult'] == 'Pass with Observation',
    );
    return passed * 100 / _total;
  }

  Future<void> _openForm({
    Map<String, dynamic>? existing,
  }) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _Step31FormSheet(
        existing: existing,
        formTypes: formTypes,
        statuses: statuses,
        priorities: priorities,
        results: results,
        frequencies: frequencies,
        checklistAnswers: checklistAnswers,
      ),
    );

    if (result == null) return;

    final now = DateTime.now().toIso8601String();

    if (existing == null) {
      result['id'] = DateTime.now().microsecondsSinceEpoch.toString();
      result['createdAt'] = now;
      result['updatedAt'] = now;
      result['history'] = <Map<String, dynamic>>[
        <String, dynamic>{
          'action': 'Created',
          'date': now,
          'user': result['updatedBy'] ?? '',
          'status': result['status'],
          'comments': 'Digital form/checklist created.',
        },
      ];
      _records.add(result);
    } else {
      final index =
          _records.indexWhere((item) => item['id'] == existing['id']);

      if (index >= 0) {
        result['id'] = existing['id'];
        result['createdAt'] = existing['createdAt'] ?? now;
        result['updatedAt'] = now;

        final history =
            List<dynamic>.from(existing['history'] ?? <dynamic>[]);
        history.add(<String, dynamic>{
          'action': 'Updated',
          'date': now,
          'user': result['updatedBy'] ?? '',
          'status': result['status'],
          'comments': result['notes'] ?? '',
        });
        result['history'] = history;
        _records[index] = result;
      }
    }

    await _saveRecords();

    if (mounted) setState(() {});
  }

  Future<void> _changeStatus(
    Map<String, dynamic> record,
    String status,
  ) async {
    final index =
        _records.indexWhere((item) => item['id'] == record['id']);
    if (index < 0) return;

    final now = DateTime.now().toIso8601String();
    final updated = Map<String, dynamic>.from(_records[index]);
    updated['status'] = status;
    updated['updatedAt'] = now;

    if (status == 'Verified' || status == 'Closed') {
      updated['verificationDate'] =
          updated['verificationDate'] ??
              now.substring(0, 10);
    }

    final history =
        List<dynamic>.from(updated['history'] ?? <dynamic>[]);
    history.add(<String, dynamic>{
      'action': status,
      'date': now,
      'user': updated['updatedBy'] ?? updated['actionOwner'] ?? '',
      'status': status,
      'comments': updated['notes'] ?? '',
    });
    updated['history'] = history;

    _records[index] = updated;
    await _saveRecords();

    if (mounted) setState(() {});
  }

  Future<void> _markVerified(Map<String, dynamic> record) async {
    final index =
        _records.indexWhere((item) => item['id'] == record['id']);
    if (index < 0) return;

    final verification = await showDialog<String>(
      context: context,
      builder: (_) => _VerificationDialog(
        initialValue:
            record['verificationEvidence']?.toString() ?? '',
      ),
    );

    if (verification == null || verification.trim().isEmpty) return;

    final now = DateTime.now().toIso8601String();
    final updated = Map<String, dynamic>.from(_records[index]);
    updated['verificationEvidence'] = verification.trim();
    updated['verificationDate'] = now.substring(0, 10);
    updated['status'] = 'Verified';
    updated['updatedAt'] = now;

    final history =
        List<dynamic>.from(updated['history'] ?? <dynamic>[]);
    history.add(<String, dynamic>{
      'action': 'Verified',
      'date': now,
      'user': updated['updatedBy'] ?? '',
      'status': 'Verified',
      'comments': verification.trim(),
    });
    updated['history'] = history;

    _records[index] = updated;
    await _saveRecords();

    if (mounted) setState(() {});
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete checklist record?'),
        content: Text(
          'Delete ${record['formNo'] ?? 'this record'} permanently?',
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

    _records.removeWhere((item) => item['id'] == record['id']);
    await _saveRecords();

    if (mounted) setState(() {});
  }

  void _showDetails(Map<String, dynamic> record) {
    final history =
        List<dynamic>.from(record['history'] ?? <dynamic>[]).reversed.toList();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => SafeArea(
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.90,
          maxChildSize: 0.98,
          minChildSize: 0.55,
          builder: (_, controller) => ListView(
            controller: controller,
            padding: const EdgeInsets.all(18),
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.checklist,
                    color: darkGreen,
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      record['formNo']?.toString() ?? 'Checklist',
                      style: const TextStyle(
                        fontSize: 20,
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
              _section('Form / Checklist', [
                _row('Form No.', record['formNo']),
                _row('Title', record['title']),
                _row('Form Type', record['formType']),
                _row('Status', record['status']),
                _row('Priority', record['priority']),
                _row('Overall Result', record['overallResult']),
                _row('Frequency', record['frequency']),
                _row('Project', record['project']),
                _row('Site', record['site']),
                _row('Location', record['location']),
                _row('Inspector', record['inspector']),
                _row('Assigned To', record['assignedTo']),
                _row('Due Date', record['dueDate']),
              ]),
              _section('Checklist Summary', [
                _row('Total Items', record['totalItems']),
                _row('Pass Items', record['passItems']),
                _row('Fail Items', record['failItems']),
                _row('Observation Items', record['observationItems']),
                _row('N/A Items', record['naItems']),
                _row('Not Checked Items', record['notCheckedItems']),
                _row('Score', record['score']),
                _row('Checklist Items',
                    record['checklistItems']),
              ]),
              _section('Finding & Action', [
                _row('Finding', record['finding']),
                _row('Finding Category', record['findingCategory']),
                _row('Root Cause', record['rootCause']),
                _row('Action Required', record['actionRequired']),
                _row('Action Owner', record['actionOwner']),
                _row('Action Due', record['actionDue']),
                _row('Verification Evidence',
                    record['verificationEvidence']),
                _row('Verification Date',
                    record['verificationDate']),
              ]),
              _section('Integration References', [
                _row('Risk / HIRA / JSA', record['riskReference']),
                _row('RAMS', record['ramsReference']),
                _row('PTW', record['ptwReference']),
                _row('Equipment', record['equipmentReference']),
                _row('Workforce / Training',
                    record['workforceReference']),
                _row('Emergency / ERP',
                    record['emergencyReference']),
                _row('Environment',
                    record['environmentReference']),
                _row('Incident / CAPA',
                    record['incidentReference']),
                _row('Audit / Legal',
                    record['auditLegalReference']),
                _row('Communication',
                    record['communicationReference']),
              ]),
              _section('Notes & Audit Trail', [
                _row('Description', record['description']),
                _row('Reference', record['reference']),
                _row('Updated By', record['updatedBy']),
                _row('Notes', record['notes']),
                if (history.isEmpty)
                  const Text('No history recorded.')
                else
                  ...history.map(
                    (item) => Card(
                      child: ListTile(
                        leading: const Icon(Icons.history),
                        title: Text(
                          item['action']?.toString() ?? '',
                        ),
                        subtitle: Text(
                          '${item['date'] ?? ''}\n'
                          'User: ${item['user'] ?? ''}\n'
                          '${item['comments'] ?? ''}',
                        ),
                        isThreeLine: true,
                      ),
                    ),
                  ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 7),
          ...children,
        ],
      ),
    );
  }

  Widget _row(String label, dynamic value) {
    final text = value?.toString().trim() ?? '';
    if (text.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Verified':
      case 'Closed':
        return primaryGreen;
      case 'Cancelled':
        return Colors.red;
      case 'Action Required':
      case 'Verification Required':
        return Colors.orange;
      default:
        return Colors.blueGrey;
    }
  }

  Color _priorityColor(String priority) {
    switch (priority) {
      case 'Critical':
        return Colors.red;
      case 'High':
        return Colors.deepOrange;
      case 'Medium':
        return Colors.orange;
      default:
        return Colors.blueGrey;
    }
  }

  Color _resultColor(String result) {
    switch (result) {
      case 'Pass':
      case 'Pass with Observation':
        return primaryGreen;
      case 'Fail':
      case 'Critical Finding':
        return Colors.red;
      case 'Partial':
        return Colors.orange;
      default:
        return Colors.blueGrey;
    }
  }

  Widget _tag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
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

  Widget _summaryCard(
    String title,
    String value,
    IconData icon, {
    Color? color,
  }) {
    final cardColor = color ?? darkGreen;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(11),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: cardColor.withValues(alpha: 0.10),
              child: Icon(icon, color: cardColor),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: cardColor,
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

  Widget _dropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        isDense: true,
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _header() {
    return Card(
      color: darkGreen,
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.checklist,
                color: darkGreen,
                size: 31,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'HSE Digital Forms & Smart Checklists',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Fill • Find • Assign • Verify • Close',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.90),
                      fontSize: 12,
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

  Widget _summary() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.25,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: [
        _summaryCard(
          'Total Forms',
          '$_total',
          Icons.description,
        ),
        _summaryCard(
          'Open',
          '$_open',
          Icons.pending_actions,
          color: Colors.orange,
        ),
        _summaryCard(
          'Findings',
          '$_findings',
          Icons.report_problem,
          color: Colors.orange,
        ),
        _summaryCard(
          'Critical',
          '$_critical',
          Icons.priority_high,
          color: Colors.red,
        ),
        _summaryCard(
          'Overdue',
          '$_overdue',
          Icons.warning_amber,
          color: Colors.red,
        ),
        _summaryCard(
          'Actions',
          '$_actions',
          Icons.assignment_late,
          color: Colors.orange,
        ),
        _summaryCard(
          'Verified / Closed',
          '$_verified',
          Icons.verified,
          color: primaryGreen,
        ),
        _summaryCard(
          'Pass Rate',
          '${_passRate.toStringAsFixed(0)}%',
          Icons.insights,
          color: primaryGreen,
        ),
      ],
    );
  }

  Widget _filters() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: _searchController.clear,
                        icon: const Icon(Icons.clear),
                      ),
                hintText:
                    'Search form, project, finding, inspector...',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 9),
            _dropdown(
              value: _formFilter,
              items: <String>['All', ...formTypes],
              onChanged: (value) {
                setState(() => _formFilter = value ?? 'All');
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _dropdown(
                    value: _statusFilter,
                    items: <String>['All', ...statuses],
                    onChanged: (value) {
                      setState(
                        () => _statusFilter = value ?? 'All',
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _dropdown(
                    value: _priorityFilter,
                    items: <String>['All', ...priorities],
                    onChanged: (value) {
                      setState(
                        () => _priorityFilter = value ?? 'All',
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _dropdown(
              value: _resultFilter,
              items: <String>['All', ...results],
              onChanged: (value) {
                setState(() => _resultFilter = value ?? 'All');
              },
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Show overdue only'),
              value: _showOverdueOnly,
              onChanged: (value) {
                setState(() => _showOverdueOnly = value);
              },
              activeThumbColor: primaryGreen,
            ),
          ],
        ),
      ),
    );
  }

  Widget _intelligence() {
    String message;
    IconData icon;

    if (_critical > 0) {
      message =
          'Critical checklist findings require immediate HSE management attention.';
      icon = Icons.priority_high;
    } else if (_overdue > 0) {
      message =
          'Overdue checklist actions or verifications require follow-up.';
      icon = Icons.warning_amber;
    } else if (_actions > 0) {
      message =
          'Checklist findings have open actions awaiting closure.';
      icon = Icons.assignment_late;
    } else if (_findings > 0) {
      message =
          'Findings are recorded; review corrective actions and verification.';
      icon = Icons.report_problem;
    } else if (_total > 0) {
      message =
          'Digital forms and checklists are currently under control.';
      icon = Icons.check_circle;
    } else {
      message =
          'Create the first HSE digital form or smart checklist.';
      icon = Icons.add_task;
    }

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: darkGreen.withValues(alpha: 0.10),
          child: Icon(icon, color: darkGreen),
        ),
        title: const Text(
          'Checklist Intelligence',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '$message\n'
          'Closure rate: ${_closureRate.toStringAsFixed(0)}%',
        ),
      ),
    );
  }

  Widget _recordCard(Map<String, dynamic> record) {
    final status = record['status']?.toString() ?? 'Draft';
    final priority = record['priority']?.toString() ?? 'Medium';
    final result =
        record['overallResult']?.toString() ?? 'Not Started';
    final overdue = _isOverdue(record);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () => _showDetails(record),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      record['formNo']?.toString() ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                      ),
                    ),
                  ),
                  _tag(status, _statusColor(status)),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                record['title']?.toString() ?? 'HSE Checklist',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Wrap(
                spacing: 7,
                runSpacing: 6,
                children: [
                  _tag(priority, _priorityColor(priority)),
                  _tag(result, _resultColor(result)),
                ],
              ),
              const SizedBox(height: 7),
              Text(
                '${record['formType'] ?? ''} • '
                '${record['project'] ?? ''}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Wrap(
                spacing: 12,
                runSpacing: 5,
                children: [
                  if ((record['inspector'] ?? '').toString().isNotEmpty)
                    Text('Inspector: ${record['inspector']}'),
                  if ((record['actionOwner'] ?? '').toString().isNotEmpty)
                    Text('Owner: ${record['actionOwner']}'),
                  if ((record['dueDate'] ?? '').toString().isNotEmpty)
                    Text('Due: ${record['dueDate']}'),
                  if ((record['score'] ?? '').toString().isNotEmpty)
                    Text('Score: ${record['score']}'),
                ],
              ),
              if (overdue)
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Text(
                    '• OVERDUE',
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const Divider(height: 17),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () => _showDetails(record),
                    icon: const Icon(Icons.visibility_outlined),
                    label: const Text('Details'),
                  ),
                  TextButton.icon(
                    onPressed: () => _openForm(existing: record),
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Edit'),
                  ),
                  IconButton(
                    tooltip: 'Verify',
                    onPressed: () => _markVerified(record),
                    icon: const Icon(Icons.verified_outlined),
                  ),
                  PopupMenuButton<String>(
                    tooltip: 'Status',
                    onSelected: (value) =>
                        _changeStatus(record, value),
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: 'Assigned',
                        child: Text('Assign'),
                      ),
                      PopupMenuItem(
                        value: 'In Progress',
                        child: Text('In Progress'),
                      ),
                      PopupMenuItem(
                        value: 'Submitted',
                        child: Text('Submit'),
                      ),
                      PopupMenuItem(
                        value: 'Under Review',
                        child: Text('Under Review'),
                      ),
                      PopupMenuItem(
                        value: 'Action Required',
                        child: Text('Action Required'),
                      ),
                      PopupMenuItem(
                        value: 'Verification Required',
                        child: Text('Verification Required'),
                      ),
                      PopupMenuItem(
                        value: 'Verified',
                        child: Text('Verify'),
                      ),
                      PopupMenuItem(
                        value: 'Closed',
                        child: Text('Close'),
                      ),
                      PopupMenuItem(
                        value: 'Cancelled',
                        child: Text('Cancel'),
                      ),
                    ],
                  ),
                  IconButton(
                    tooltip: 'Delete',
                    onPressed: () => _deleteRecord(record),
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final records = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Step 31 • Digital Forms'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Reset filters',
            onPressed: () {
              _searchController.clear();
              setState(() {
                _formFilter = 'All';
                _statusFilter = 'All';
                _priorityFilter = 'All';
                _resultFilter = 'All';
                _showOverdueOnly = false;
              });
            },
            icon: const Icon(Icons.filter_alt_off),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_task),
        label: const Text('New Checklist'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadRecords,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 90),
                children: [
                  _header(),
                  const SizedBox(height: 10),
                  _summary(),
                  const SizedBox(height: 10),
                  _intelligence(),
                  const SizedBox(height: 10),
                  _filters(),
                  const SizedBox(height: 10),
                  Text(
                    'Forms & Checklists (${records.length})',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (records.isEmpty)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.checklist_outlined,
                              size: 52,
                              color: Colors.blueGrey,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'No matching forms or checklists',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              _records.isEmpty
                                  ? 'Create the first digital HSE checklist.'
                                  : 'Change the filters or search text.',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ...records.map(_recordCard),
                ],
              ),
            ),
    );
  }
}

class _Step31FormSheet extends StatefulWidget {
  const _Step31FormSheet({
    required this.existing,
    required this.formTypes,
    required this.statuses,
    required this.priorities,
    required this.results,
    required this.frequencies,
    required this.checklistAnswers,
  });

  final Map<String, dynamic>? existing;
  final List<String> formTypes;
  final List<String> statuses;
  final List<String> priorities;
  final List<String> results;
  final List<String> frequencies;
  final List<String> checklistAnswers;

  @override
  State<_Step31FormSheet> createState() => _Step31FormSheetState();
}

class _Step31FormSheetState extends State<_Step31FormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController formNo;
  late final TextEditingController title;
  late final TextEditingController description;
  late final TextEditingController project;
  late final TextEditingController site;
  late final TextEditingController location;
  late final TextEditingController inspector;
  late final TextEditingController assignedTo;
  late final TextEditingController dueDate;
  late final TextEditingController totalItems;
  late final TextEditingController passItems;
  late final TextEditingController failItems;
  late final TextEditingController observationItems;
  late final TextEditingController naItems;
  late final TextEditingController notCheckedItems;
  late final TextEditingController score;
  late final TextEditingController checklistItems;
  late final TextEditingController finding;
  late final TextEditingController findingCategory;
  late final TextEditingController rootCause;
  late final TextEditingController actionRequired;
  late final TextEditingController actionOwner;
  late final TextEditingController actionDue;
  late final TextEditingController verificationEvidence;
  late final TextEditingController verificationDate;
  late final TextEditingController riskReference;
  late final TextEditingController ramsReference;
  late final TextEditingController ptwReference;
  late final TextEditingController equipmentReference;
  late final TextEditingController workforceReference;
  late final TextEditingController emergencyReference;
  late final TextEditingController environmentReference;
  late final TextEditingController incidentReference;
  late final TextEditingController auditLegalReference;
  late final TextEditingController communicationReference;
  late final TextEditingController reference;
  late final TextEditingController updatedBy;
  late final TextEditingController notes;

  late String formType;
  late String status;
  late String priority;
  late String overallResult;
  late String frequency;

  @override
  void initState() {
    super.initState();

    final r = widget.existing ?? <String, dynamic>{};

    formNo = _controller(r, 'formNo');
    title = _controller(r, 'title');
    description = _controller(r, 'description');
    project = _controller(r, 'project');
    site = _controller(r, 'site');
    location = _controller(r, 'location');
    inspector = _controller(r, 'inspector');
    assignedTo = _controller(r, 'assignedTo');
    dueDate = _controller(r, 'dueDate');
    totalItems = _controller(r, 'totalItems');
    passItems = _controller(r, 'passItems');
    failItems = _controller(r, 'failItems');
    observationItems = _controller(r, 'observationItems');
    naItems = _controller(r, 'naItems');
    notCheckedItems = _controller(r, 'notCheckedItems');
    score = _controller(r, 'score');
    checklistItems = _controller(r, 'checklistItems');
    finding = _controller(r, 'finding');
    findingCategory = _controller(r, 'findingCategory');
    rootCause = _controller(r, 'rootCause');
    actionRequired = _controller(r, 'actionRequired');
    actionOwner = _controller(r, 'actionOwner');
    actionDue = _controller(r, 'actionDue');
    verificationEvidence = _controller(r, 'verificationEvidence');
    verificationDate = _controller(r, 'verificationDate');
    riskReference = _controller(r, 'riskReference');
    ramsReference = _controller(r, 'ramsReference');
    ptwReference = _controller(r, 'ptwReference');
    equipmentReference = _controller(r, 'equipmentReference');
    workforceReference = _controller(r, 'workforceReference');
    emergencyReference = _controller(r, 'emergencyReference');
    environmentReference = _controller(r, 'environmentReference');
    incidentReference = _controller(r, 'incidentReference');
    auditLegalReference = _controller(r, 'auditLegalReference');
    communicationReference = _controller(r, 'communicationReference');
    reference = _controller(r, 'reference');
    updatedBy = _controller(r, 'updatedBy');
    notes = _controller(r, 'notes');

    formType = _valid(
      r['formType'],
      widget.formTypes,
      'HSE Forms Master',
    );
    status = _valid(
      r['status'],
      widget.statuses,
      'Draft',
    );
    priority = _valid(
      r['priority'],
      widget.priorities,
      'Medium',
    );
    overallResult = _valid(
      r['overallResult'],
      widget.results,
      'Not Started',
    );
    frequency = _valid(
      r['frequency'],
      widget.frequencies,
      'One Time',
    );
  }

  TextEditingController _controller(
    Map<String, dynamic> record,
    String key, {
    String fallback = '',
  }) {
    final value = record[key]?.toString() ?? '';
    return TextEditingController(
      text: value.isEmpty ? fallback : value,
    );
  }

  String _valid(
    dynamic value,
    List<String> values,
    String fallback,
  ) {
    final text = value?.toString() ?? '';
    return values.contains(text) ? text : fallback;
  }

  @override
  void dispose() {
    for (final controller in [
      formNo,
      title,
      description,
      project,
      site,
      location,
      inspector,
      assignedTo,
      dueDate,
      totalItems,
      passItems,
      failItems,
      observationItems,
      naItems,
      notCheckedItems,
      score,
      checklistItems,
      finding,
      findingCategory,
      rootCause,
      actionRequired,
      actionOwner,
      actionDue,
      verificationEvidence,
      verificationDate,
      riskReference,
      ramsReference,
      ptwReference,
      equipmentReference,
      workforceReference,
      emergencyReference,
      environmentReference,
      incidentReference,
      auditLegalReference,
      communicationReference,
      reference,
      updatedBy,
      notes,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
      isDense: true,
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    bool required = false,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: _decoration(label),
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
        isExpanded: true,
        decoration: _decoration(label),
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _dateField(
    String label,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: _decoration(label).copyWith(
          suffixIcon: IconButton(
            onPressed: () => _pickDate(controller),
            icon: const Icon(Icons.calendar_month),
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate(
    TextEditingController controller,
  ) async {
    final initial =
        DateTime.tryParse(controller.text) ?? DateTime.now();

    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: initial,
    );

    if (picked != null) {
      controller.text =
          '${picked.year.toString().padLeft(4, '0')}-'
          '${picked.month.toString().padLeft(2, '0')}-'
          '${picked.day.toString().padLeft(2, '0')}';
    }
  }

  bool _validDate(String value) {
    return value.trim().isEmpty ||
        DateTime.tryParse(value.trim()) != null;
  }

  int? _number(String value) {
    return int.tryParse(value.trim());
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_validDate(dueDate.text) ||
        !_validDate(actionDue.text) ||
        !_validDate(verificationDate.text)) {
      _error('Dates must use YYYY-MM-DD format.');
      return;
    }

    final total = _number(totalItems.text);
    final pass = _number(passItems.text);
    final fail = _number(failItems.text);
    final observations = _number(observationItems.text);
    final na = _number(naItems.text);
    final notChecked = _number(notCheckedItems.text);

    final supplied = <String, int?>{
      'Total Items': total,
      'Pass Items': pass,
      'Fail Items': fail,
      'Observation Items': observations,
      'N/A Items': na,
      'Not Checked Items': notChecked,
    };

    for (final entry in supplied.entries) {
      if (entry.value == null && entry.value != null) {
        _error('${entry.key} must be a whole number.');
        return;
      }
    }

    final values = [
      total,
      pass,
      fail,
      observations,
      na,
      notChecked,
    ].whereType<int>().toList();

    if (values.isNotEmpty && values.any((value) => value < 0)) {
      _error('Checklist counts cannot be negative.');
      return;
    }

    if (total != null && values.length == 6) {
      final sum = pass! + fail! + observations! + na! + notChecked!;
      if (sum > total) {
        _error('Checklist item results cannot exceed Total Items.');
        return;
      }
    }

    final due = DateTime.tryParse(dueDate.text.trim());
    final action = DateTime.tryParse(actionDue.text.trim());

    if (due != null &&
        action != null &&
        action.isBefore(due)) {
      _error('Action Due cannot be before Form Due Date.');
      return;
    }

    if ((overallResult == 'Fail' ||
            overallResult == 'Critical Finding' ||
            overallResult == 'Partial' ||
            overallResult == 'Pass with Observation') &&
        finding.text.trim().isEmpty) {
      _error('Finding is required for the selected result.');
      return;
    }

    if ((status == 'Action Required' ||
            status == 'Verification Required') &&
        actionRequired.text.trim().isEmpty) {
      _error('Action Required is needed for an open finding.');
      return;
    }

    if (status == 'Verified' &&
        verificationDate.text.trim().isEmpty) {
      _error('Verification Date is required for Verified status.');
      return;
    }

    if (status == 'Closed' &&
        verificationEvidence.text.trim().isEmpty) {
      _error('Verification Evidence is required before closure.');
      return;
    }

    if (priority == 'Critical' &&
        finding.text.trim().isEmpty) {
      _error('Finding is required for a Critical record.');
      return;
    }

    final record = <String, dynamic>{
      'formNo': formNo.text.trim(),
      'title': title.text.trim(),
      'description': description.text.trim(),
      'formType': formType,
      'status': status,
      'priority': priority,
      'overallResult': overallResult,
      'frequency': frequency,
      'project': project.text.trim(),
      'site': site.text.trim(),
      'location': location.text.trim(),
      'inspector': inspector.text.trim(),
      'assignedTo': assignedTo.text.trim(),
      'dueDate': dueDate.text.trim(),
      'totalItems': totalItems.text.trim(),
      'passItems': passItems.text.trim(),
      'failItems': failItems.text.trim(),
      'observationItems': observationItems.text.trim(),
      'naItems': naItems.text.trim(),
      'notCheckedItems': notCheckedItems.text.trim(),
      'score': score.text.trim(),
      'checklistItems': checklistItems.text.trim(),
      'finding': finding.text.trim(),
      'findingCategory': findingCategory.text.trim(),
      'rootCause': rootCause.text.trim(),
      'actionRequired': actionRequired.text.trim(),
      'actionOwner': actionOwner.text.trim(),
      'actionDue': actionDue.text.trim(),
      'verificationEvidence': verificationEvidence.text.trim(),
      'verificationDate': verificationDate.text.trim(),
      'riskReference': riskReference.text.trim(),
      'ramsReference': ramsReference.text.trim(),
      'ptwReference': ptwReference.text.trim(),
      'equipmentReference': equipmentReference.text.trim(),
      'workforceReference': workforceReference.text.trim(),
      'emergencyReference': emergencyReference.text.trim(),
      'environmentReference': environmentReference.text.trim(),
      'incidentReference': incidentReference.text.trim(),
      'auditLegalReference': auditLegalReference.text.trim(),
      'communicationReference':
          communicationReference.text.trim(),
      'reference': reference.text.trim(),
      'updatedBy': updatedBy.text.trim(),
      'notes': notes.text.trim(),
    };

    Navigator.pop(context, record);
  }

  void _error(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.existing != null;

    return SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.94,
        maxChildSize: 0.99,
        minChildSize: 0.60,
        builder: (_, controller) => Material(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              controller: controller,
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.checklist,
                      color: darkGreen,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        editing
                            ? 'Edit Digital Checklist'
                            : 'Create Digital Checklist',
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
                const SizedBox(height: 8),
                _field(
                  formNo,
                  'Form / Checklist No.',
                  required: true,
                ),
                _field(
                  title,
                  'Title',
                  required: true,
                ),
                _dropdown(
                  'Form Type',
                  formType,
                  widget.formTypes,
                  (value) => setState(
                    () => formType = value ?? formType,
                  ),
                ),
                _dropdown(
                  'Status',
                  status,
                  widget.statuses,
                  (value) => setState(
                    () => status = value ?? status,
                  ),
                ),
                _dropdown(
                  'Priority',
                  priority,
                  widget.priorities,
                  (value) => setState(
                    () => priority = value ?? priority,
                  ),
                ),
                _dropdown(
                  'Overall Result',
                  overallResult,
                  widget.results,
                  (value) => setState(
                    () => overallResult =
                        value ?? overallResult,
                  ),
                ),
                _dropdown(
                  'Frequency',
                  frequency,
                  widget.frequencies,
                  (value) => setState(
                    () => frequency = value ?? frequency,
                  ),
                ),
                _field(
                  description,
                  'Description / Scope',
                  maxLines: 4,
                ),
                _field(project, 'Project'),
                _field(site, 'Site'),
                _field(location, 'Location'),
                _field(inspector, 'Inspector / HSE Officer'),
                _field(assignedTo, 'Assigned To'),
                _dateField('Due Date', dueDate),
                const SizedBox(height: 3),
                const Text(
                  'Checklist Results',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                _field(
                  totalItems,
                  'Total Items',
                  keyboardType: TextInputType.number,
                ),
                _field(
                  passItems,
                  'Pass Items',
                  keyboardType: TextInputType.number,
                ),
                _field(
                  failItems,
                  'Fail Items',
                  keyboardType: TextInputType.number,
                ),
                _field(
                  observationItems,
                  'Observation Items',
                  keyboardType: TextInputType.number,
                ),
                _field(
                  naItems,
                  'N/A Items',
                  keyboardType: TextInputType.number,
                ),
                _field(
                  notCheckedItems,
                  'Not Checked Items',
                  keyboardType: TextInputType.number,
                ),
                _field(score, 'Score / Percentage'),
                _field(
                  checklistItems,
                  'Checklist Items / Responses',
                  maxLines: 7,
                ),
                const SizedBox(height: 3),
                const Text(
                  'Finding & Corrective Action',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                _field(
                  finding,
                  'Finding / Observation',
                  maxLines: 4,
                ),
                _field(
                  findingCategory,
                  'Finding Category',
                ),
                _field(
                  rootCause,
                  'Root Cause',
                  maxLines: 4,
                ),
                _field(
                  actionRequired,
                  'Action Required',
                  maxLines: 4,
                ),
                _field(actionOwner, 'Action Owner'),
                _dateField('Action Due', actionDue),
                _field(
                  verificationEvidence,
                  'Verification Evidence',
                  maxLines: 4,
                ),
                _dateField(
                  'Verification Date',
                  verificationDate,
                ),
                const SizedBox(height: 3),
                const Text(
                  'HSE Integration References',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                _field(
                  riskReference,
                  'Risk / HIRA / JSA Reference',
                ),
                _field(ramsReference, 'RAMS Reference'),
                _field(ptwReference, 'PTW Reference'),
                _field(
                  equipmentReference,
                  'Equipment Reference',
                ),
                _field(
                  workforceReference,
                  'Workforce / Training Reference',
                ),
                _field(
                  emergencyReference,
                  'Emergency / ERP Reference',
                ),
                _field(
                  environmentReference,
                  'Environment Reference',
                ),
                _field(
                  incidentReference,
                  'Incident / CAPA Reference',
                ),
                _field(
                  auditLegalReference,
                  'Audit / Legal Reference',
                ),
                _field(
                  communicationReference,
                  'Communication Reference',
                ),
                const SizedBox(height: 3),
                const Text(
                  'Audit & Notes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                _field(reference, 'Related Reference'),
                _field(updatedBy, 'Updated / Reviewed By'),
                _field(notes, 'Notes', maxLines: 3),
                const SizedBox(height: 8),
                FilledButton.icon(
                  onPressed: _submit,
                  style: FilledButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  icon: const Icon(Icons.save),
                  label: Text(
                    editing
                        ? 'Update Checklist'
                        : 'Save Checklist',
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

class _VerificationDialog extends StatefulWidget {
  const _VerificationDialog({
    required this.initialValue,
  });

  final String initialValue;

  @override
  State<_VerificationDialog> createState() =>
      _VerificationDialogState();
}

class _VerificationDialogState extends State<_VerificationDialog> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: widget.initialValue,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Verification Evidence'),
      content: TextField(
        controller: controller,
        maxLines: 4,
        decoration: const InputDecoration(
          labelText: 'Evidence / verification comment',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (controller.text.trim().isEmpty) return;
            Navigator.pop(context, controller.text);
          },
          child: const Text('Verify'),
        ),
      ],
    );
  }
}
