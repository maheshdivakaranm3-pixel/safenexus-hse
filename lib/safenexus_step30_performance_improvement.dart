import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE — Step 30
/// HSE Performance, Compliance & Continuous Improvement Center
///
/// 30A HSE Performance Master
/// 30B HSE KPI & Target Monitoring
/// 30C Leading / Lagging Indicators
/// 30D Trend & Performance Analysis
/// 30E Non-Conformance Management
/// 30F CAPA Effectiveness Review
/// 30G Root Cause & Recurrence Tracking
/// 30H Safety Improvement Initiatives
/// 30I Lessons Learned & Best Practices
/// 30J Management Improvement Actions
/// 30K Continuous Improvement Register
/// 30L HSE Performance Intelligence Dashboard
///
/// Core flow:
/// Measure -> Analyze -> Identify Gap -> Correct -> Verify
/// -> Improve -> Standardize -> Review
///
/// This is a local operational register. It does not claim certification,
/// legal compliance, or automatic external reporting.

class SafeNexusStep30 extends StatefulWidget {
  const SafeNexusStep30({super.key});

  @override
  State<SafeNexusStep30> createState() => _SafeNexusStep30State();
}

class _SafeNexusStep30State extends State<SafeNexusStep30> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_step30_performance_improvement';

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _records = <Map<String, dynamic>>[];
  bool _loading = true;
  String _moduleFilter = 'All';
  String _statusFilter = 'All';
  String _priorityFilter = 'All';
  String _performanceFilter = 'All';
  bool _showOverdueOnly = false;

  static const List<String> modules = <String>[
    'HSE Performance Master',
    'HSE KPI & Target Monitoring',
    'Leading Indicator',
    'Lagging Indicator',
    'Trend & Performance Analysis',
    'Non-Conformance',
    'CAPA Effectiveness Review',
    'Root Cause & Recurrence Tracking',
    'Safety Improvement Initiative',
    'Lessons Learned',
    'Best Practice',
    'Management Improvement Action',
    'Continuous Improvement Register',
    'Other',
  ];

  static const List<String> statuses = <String>[
    'Draft',
    'Open',
    'Under Review',
    'Action Required',
    'In Progress',
    'Verification Required',
    'Effective',
    'Standardized',
    'Closed',
    'Cancelled',
  ];

  static const List<String> priorities = <String>[
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static const List<String> performanceStatuses = <String>[
    'Not Measured',
    'On Target',
    'Above Target',
    'Below Target',
    'Critical Gap',
    'Improving',
    'Stable',
    'Declining',
    'Not Applicable',
  ];

  static const List<String> indicatorTypes = <String>[
    'Leading',
    'Lagging',
    'Mixed',
    'Not Applicable',
  ];

  static const List<String> improvementTypes = <String>[
    'Corrective',
    'Preventive',
    'Continuous Improvement',
    'Process Improvement',
    'Training Improvement',
    'Engineering Improvement',
    'Behavioral Improvement',
    'Management System Improvement',
    'Best Practice',
  ];

  static const List<String> reviewFrequencies = <String>[
    'Daily',
    'Weekly',
    'Monthly',
    'Quarterly',
    'Half-Yearly',
    'Yearly',
    'Event Based',
    'Not Applicable',
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

    if (mounted) setState(() => _loading = false);
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
    if (status == 'Effective' ||
        status == 'Standardized' ||
        status == 'Closed' ||
        status == 'Cancelled') {
      return false;
    }

    return due.isBefore(DateTime.now());
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchController.text.trim().toLowerCase();

    final result = _records.where((record) {
      final matchesSearch = query.isEmpty ||
          <dynamic>[
            record['recordNo'],
            record['title'],
            record['description'],
            record['project'],
            record['site'],
            record['location'],
            record['owner'],
            record['department'],
            record['kpiName'],
            record['indicatorName'],
            record['rootCause'],
            record['improvementAction'],
            record['reference'],
          ].any(
            (value) => value.toString().toLowerCase().contains(query),
          );

      final matchesModule =
          _moduleFilter == 'All' || record['module'] == _moduleFilter;
      final matchesStatus =
          _statusFilter == 'All' || record['status'] == _statusFilter;
      final matchesPriority =
          _priorityFilter == 'All' || record['priority'] == _priorityFilter;
      final matchesPerformance = _performanceFilter == 'All' ||
          record['performanceStatus'] == _performanceFilter;
      final matchesOverdue =
          !_showOverdueOnly || _isOverdue(record);

      return matchesSearch &&
          matchesModule &&
          matchesStatus &&
          matchesPriority &&
          matchesPerformance &&
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

  int get _openActions => _count(
        (r) =>
            r['status'] == 'Open' ||
            r['status'] == 'Action Required' ||
            r['status'] == 'In Progress' ||
            r['status'] == 'Verification Required',
      );

  int get _critical => _count(
        (r) =>
            r['priority'] == 'Critical' &&
            r['status'] != 'Closed' &&
            r['status'] != 'Cancelled',
      );

  int get _overdue => _count(_isOverdue);

  int get _belowTarget => _count(
        (r) =>
            r['performanceStatus'] == 'Below Target' ||
            r['performanceStatus'] == 'Critical Gap' ||
            r['performanceStatus'] == 'Declining',
      );

  int get _effective => _count(
        (r) =>
            r['status'] == 'Effective' ||
            r['status'] == 'Standardized' ||
            r['status'] == 'Closed',
      );

  int get _improving => _count(
        (r) =>
            r['performanceStatus'] == 'Improving' ||
            r['performanceStatus'] == 'On Target' ||
            r['performanceStatus'] == 'Above Target',
      );

  double get _effectivenessRate {
    if (_total == 0) return 0;
    return _effective * 100 / _total;
  }

  double get _improvementRate {
    if (_total == 0) return 0;
    return _improving * 100 / _total;
  }

  Future<void> _openForm({
    Map<String, dynamic>? existing,
  }) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _Step30FormSheet(
        existing: existing,
        modules: modules,
        statuses: statuses,
        priorities: priorities,
        performanceStatuses: performanceStatuses,
        indicatorTypes: indicatorTypes,
        improvementTypes: improvementTypes,
        reviewFrequencies: reviewFrequencies,
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
          'comments': 'Performance / improvement record created.',
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

    final history =
        List<dynamic>.from(updated['history'] ?? <dynamic>[]);
    history.add(<String, dynamic>{
      'action': status,
      'date': now,
      'user': updated['updatedBy'] ?? updated['owner'] ?? '',
      'status': status,
      'comments': updated['notes'] ?? '',
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
        title: const Text('Delete performance record?'),
        content: Text(
          'Delete ${record['recordNo'] ?? 'this record'} permanently?',
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
                    Icons.trending_up,
                    color: darkGreen,
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      record['recordNo']?.toString() ?? 'Performance Record',
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
              _section('Performance Record', [
                _row('Module', record['module']),
                _row('Title', record['title']),
                _row('Project', record['project']),
                _row('Site', record['site']),
                _row('Location', record['location']),
                _row('Department', record['department']),
                _row('Owner', record['owner']),
                _row('Priority', record['priority']),
                _row('Status', record['status']),
                _row('Performance', record['performanceStatus']),
                _row('Review Frequency', record['reviewFrequency']),
                _row('Due Date', record['dueDate']),
              ]),
              _section('KPI / Indicator', [
                _row('KPI Name', record['kpiName']),
                _row('Indicator Name', record['indicatorName']),
                _row('Indicator Type', record['indicatorType']),
                _row('Target', record['target']),
                _row('Actual', record['actual']),
                _row('Unit', record['unit']),
                _row('Period', record['measurementPeriod']),
                _row('Previous Value', record['previousValue']),
                _row('Variance', record['variance']),
              ]),
              _section('Gap / Root Cause', [
                _row('Gap / Finding', record['gap']),
                _row('Root Cause', record['rootCause']),
                _row('Recurrence', record['recurrenceStatus']),
                _row('Recurrence Count', record['recurrenceCount']),
                _row('Contributing Factors', record['contributingFactors']),
              ]),
              _section('Improvement', [
                _row('Improvement Type', record['improvementType']),
                _row('Improvement Action', record['improvementAction']),
                _row('Action Owner', record['actionOwner']),
                _row('Action Due', record['actionDue']),
                _row('Effectiveness', record['effectiveness']),
                _row('Verification Date', record['verificationDate']),
                _row('Standardized', record['standardized']),
                _row('Best Practice / Lesson', record['bestPractice']),
              ]),
              _section('Integration References', [
                _row('Risk / HIRA / JSA', record['riskReference']),
                _row('RAMS', record['ramsReference']),
                _row('PTW', record['ptwReference']),
                _row('Incident / CAPA', record['incidentReference']),
                _row('Audit / Inspection', record['auditReference']),
                _row('Training / Workforce', record['trainingReference']),
                _row('Legal / Authority', record['legalReference']),
                _row('Communication', record['communicationReference']),
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
                        title: Text(item['action']?.toString() ?? ''),
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
            width: 145,
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
      case 'Effective':
      case 'Standardized':
      case 'Closed':
        return primaryGreen;
      case 'Critical':
      case 'Cancelled':
        return Colors.red;
      case 'Action Required':
      case 'In Progress':
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

  Color _performanceColor(String value) {
    switch (value) {
      case 'On Target':
      case 'Above Target':
      case 'Improving':
        return primaryGreen;
      case 'Critical Gap':
      case 'Declining':
        return Colors.red;
      case 'Below Target':
        return Colors.orange;
      default:
        return Colors.blueGrey;
    }
  }

  Widget _tag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  Text(title, style: const TextStyle(fontSize: 12)),
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
                Icons.trending_up,
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
                    'HSE Performance & Continuous Improvement',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Measure • Analyze • Improve • Standardize • Review',
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
        _summaryCard('Total Records', '$_total', Icons.analytics),
        _summaryCard(
          'Open Actions',
          '$_openActions',
          Icons.assignment_late,
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
          'Below Target / Gap',
          '$_belowTarget',
          Icons.trending_down,
          color: Colors.orange,
        ),
        _summaryCard(
          'Effective / Closed',
          '$_effective',
          Icons.verified,
          color: primaryGreen,
        ),
        _summaryCard(
          'Improving / On Target',
          '$_improving',
          Icons.trending_up,
          color: primaryGreen,
        ),
        _summaryCard(
          'Effectiveness',
          '${_effectivenessRate.toStringAsFixed(0)}%',
          Icons.insights,
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
                    'Search KPI, action, project, root cause...',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 9),
            _dropdown(
              value: _moduleFilter,
              items: <String>['All', ...modules],
              onChanged: (value) {
                setState(() => _moduleFilter = value ?? 'All');
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
                      setState(() => _statusFilter = value ?? 'All');
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
              value: _performanceFilter,
              items: <String>['All', ...performanceStatuses],
              onChanged: (value) {
                setState(
                  () => _performanceFilter = value ?? 'All',
                );
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
          'Critical performance gaps require immediate management attention.';
      icon = Icons.priority_high;
    } else if (_overdue > 0) {
      message =
          'Overdue improvement actions or reviews need follow-up.';
      icon = Icons.warning_amber;
    } else if (_belowTarget > 0) {
      message =
          'Performance gaps are present; review root cause and improvement actions.';
      icon = Icons.trending_down;
    } else if (_openActions > 0) {
      message =
          'Open improvement actions remain in progress.';
      icon = Icons.assignment_late;
    } else if (_total > 0) {
      message =
          'Performance records are currently under control.';
      icon = Icons.check_circle;
    } else {
      message =
          'Create the first performance or continuous-improvement record.';
      icon = Icons.add_chart;
    }

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: darkGreen.withValues(alpha: 0.10),
          child: Icon(icon, color: darkGreen),
        ),
        title: const Text(
          'Performance Intelligence',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '$message\n'
          'Improvement rate: ${_improvementRate.toStringAsFixed(0)}%',
        ),
      ),
    );
  }

  Widget _recordCard(Map<String, dynamic> record) {
    final status = record['status']?.toString() ?? 'Draft';
    final priority = record['priority']?.toString() ?? 'Medium';
    final performance =
        record['performanceStatus']?.toString() ?? 'Not Measured';
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
                      record['recordNo']?.toString() ?? '',
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
                record['title']?.toString() ?? 'Performance Record',
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
                  _tag(
                    performance,
                    _performanceColor(performance),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Text(
                '${record['module'] ?? ''} • '
                '${record['project'] ?? ''}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Wrap(
                spacing: 12,
                runSpacing: 5,
                children: [
                  if ((record['kpiName'] ?? '').toString().isNotEmpty)
                    Text('KPI: ${record['kpiName']}'),
                  if ((record['owner'] ?? '').toString().isNotEmpty)
                    Text('Owner: ${record['owner']}'),
                  if ((record['dueDate'] ?? '').toString().isNotEmpty)
                    Text('Due: ${record['dueDate']}'),
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
                  PopupMenuButton<String>(
                    tooltip: 'Status',
                    onSelected: (value) =>
                        _changeStatus(record, value),
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: 'Open',
                        child: Text('Open'),
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
                        value: 'In Progress',
                        child: Text('In Progress'),
                      ),
                      PopupMenuItem(
                        value: 'Verification Required',
                        child: Text('Verification Required'),
                      ),
                      PopupMenuItem(
                        value: 'Effective',
                        child: Text('Mark Effective'),
                      ),
                      PopupMenuItem(
                        value: 'Standardized',
                        child: Text('Standardize'),
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
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Step 30 • HSE Performance'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Reset filters',
            onPressed: () {
              _searchController.clear();
              setState(() {
                _moduleFilter = 'All';
                _statusFilter = 'All';
                _priorityFilter = 'All';
                _performanceFilter = 'All';
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
        icon: const Icon(Icons.add),
        label: const Text('New Record'),
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
                    'Records (${_filteredRecords.length})',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_filteredRecords.isEmpty)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.analytics_outlined,
                              size: 52,
                              color: Colors.blueGrey,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'No matching records',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              _records.isEmpty
                                  ? 'Create a performance or improvement record.'
                                  : 'Change the filters or search text.',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ..._filteredRecords.map(_recordCard),
                ],
              ),
            ),
    );
  }
}

class _Step30FormSheet extends StatefulWidget {
  const _Step30FormSheet({
    required this.existing,
    required this.modules,
    required this.statuses,
    required this.priorities,
    required this.performanceStatuses,
    required this.indicatorTypes,
    required this.improvementTypes,
    required this.reviewFrequencies,
  });

  final Map<String, dynamic>? existing;
  final List<String> modules;
  final List<String> statuses;
  final List<String> priorities;
  final List<String> performanceStatuses;
  final List<String> indicatorTypes;
  final List<String> improvementTypes;
  final List<String> reviewFrequencies;

  @override
  State<_Step30FormSheet> createState() => _Step30FormSheetState();
}

class _Step30FormSheetState extends State<_Step30FormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController recordNo;
  late final TextEditingController title;
  late final TextEditingController description;
  late final TextEditingController project;
  late final TextEditingController site;
  late final TextEditingController location;
  late final TextEditingController department;
  late final TextEditingController owner;
  late final TextEditingController dueDate;
  late final TextEditingController kpiName;
  late final TextEditingController indicatorName;
  late final TextEditingController target;
  late final TextEditingController actual;
  late final TextEditingController unit;
  late final TextEditingController measurementPeriod;
  late final TextEditingController previousValue;
  late final TextEditingController variance;
  late final TextEditingController gap;
  late final TextEditingController rootCause;
  late final TextEditingController recurrenceStatus;
  late final TextEditingController recurrenceCount;
  late final TextEditingController contributingFactors;
  late final TextEditingController improvementAction;
  late final TextEditingController actionOwner;
  late final TextEditingController actionDue;
  late final TextEditingController effectiveness;
  late final TextEditingController verificationDate;
  late final TextEditingController standardized;
  late final TextEditingController bestPractice;
  late final TextEditingController riskReference;
  late final TextEditingController ramsReference;
  late final TextEditingController ptwReference;
  late final TextEditingController incidentReference;
  late final TextEditingController auditReference;
  late final TextEditingController trainingReference;
  late final TextEditingController legalReference;
  late final TextEditingController communicationReference;
  late final TextEditingController reference;
  late final TextEditingController updatedBy;
  late final TextEditingController notes;

  late String module;
  late String status;
  late String priority;
  late String performanceStatus;
  late String indicatorType;
  late String improvementType;
  late String reviewFrequency;

  @override
  void initState() {
    super.initState();
    final r = widget.existing ?? <String, dynamic>{};

    recordNo = _controller(r, 'recordNo');
    title = _controller(r, 'title');
    description = _controller(r, 'description');
    project = _controller(r, 'project');
    site = _controller(r, 'site');
    location = _controller(r, 'location');
    department = _controller(r, 'department');
    owner = _controller(r, 'owner');
    dueDate = _controller(r, 'dueDate');
    kpiName = _controller(r, 'kpiName');
    indicatorName = _controller(r, 'indicatorName');
    target = _controller(r, 'target');
    actual = _controller(r, 'actual');
    unit = _controller(r, 'unit');
    measurementPeriod = _controller(r, 'measurementPeriod');
    previousValue = _controller(r, 'previousValue');
    variance = _controller(r, 'variance');
    gap = _controller(r, 'gap');
    rootCause = _controller(r, 'rootCause');
    recurrenceStatus = _controller(r, 'recurrenceStatus');
    recurrenceCount = _controller(r, 'recurrenceCount');
    contributingFactors = _controller(r, 'contributingFactors');
    improvementAction = _controller(r, 'improvementAction');
    actionOwner = _controller(r, 'actionOwner');
    actionDue = _controller(r, 'actionDue');
    effectiveness = _controller(r, 'effectiveness');
    verificationDate = _controller(r, 'verificationDate');
    standardized = _controller(r, 'standardized');
    bestPractice = _controller(r, 'bestPractice');
    riskReference = _controller(r, 'riskReference');
    ramsReference = _controller(r, 'ramsReference');
    ptwReference = _controller(r, 'ptwReference');
    incidentReference = _controller(r, 'incidentReference');
    auditReference = _controller(r, 'auditReference');
    trainingReference = _controller(r, 'trainingReference');
    legalReference = _controller(r, 'legalReference');
    communicationReference =
        _controller(r, 'communicationReference');
    reference = _controller(r, 'reference');
    updatedBy = _controller(r, 'updatedBy');
    notes = _controller(r, 'notes');

    module = _valid(
      r['module'],
      widget.modules,
      'HSE Performance Master',
    );
    status = _valid(r['status'], widget.statuses, 'Draft');
    priority = _valid(
      r['priority'],
      widget.priorities,
      'Medium',
    );
    performanceStatus = _valid(
      r['performanceStatus'],
      widget.performanceStatuses,
      'Not Measured',
    );
    indicatorType = _valid(
      r['indicatorType'],
      widget.indicatorTypes,
      'Not Applicable',
    );
    improvementType = _valid(
      r['improvementType'],
      widget.improvementTypes,
      'Continuous Improvement',
    );
    reviewFrequency = _valid(
      r['reviewFrequency'],
      widget.reviewFrequencies,
      'Monthly',
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
      recordNo,
      title,
      description,
      project,
      site,
      location,
      department,
      owner,
      dueDate,
      kpiName,
      indicatorName,
      target,
      actual,
      unit,
      measurementPeriod,
      previousValue,
      variance,
      gap,
      rootCause,
      recurrenceStatus,
      recurrenceCount,
      contributingFactors,
      improvementAction,
      actionOwner,
      actionDue,
      effectiveness,
      verificationDate,
      standardized,
      bestPractice,
      riskReference,
      ramsReference,
      ptwReference,
      incidentReference,
      auditReference,
      trainingReference,
      legalReference,
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
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final dateFields = <MapEntry<String, TextEditingController>>[
      MapEntry('Due Date', dueDate),
      MapEntry('Action Due', actionDue),
      MapEntry('Verification Date', verificationDate),
    ];

    for (final item in dateFields) {
      if (!_validDate(item.value.text)) {
        _error('${item.key} must use YYYY-MM-DD format.');
        return;
      }
    }

    final due = DateTime.tryParse(dueDate.text.trim());
    final action = DateTime.tryParse(actionDue.text.trim());

    if (due != null &&
        action != null &&
        action.isBefore(due)) {
      _error('Action Due cannot be before Due Date.');
      return;
    }

    if (status == 'Effective' &&
        verificationDate.text.trim().isEmpty) {
      _error('Verification Date is required when status is Effective.');
      return;
    }

    if ((status == 'Action Required' || status == 'In Progress') &&
        improvementAction.text.trim().isEmpty) {
      _error('Improvement Action is required for an open action.');
      return;
    }

    if ((performanceStatus == 'Below Target' ||
            performanceStatus == 'Critical Gap' ||
            performanceStatus == 'Declining') &&
        rootCause.text.trim().isEmpty) {
      _error(
        'Root Cause is required when performance has a significant gap.',
      );
      return;
    }

    if (status == 'Standardized' && standardized.text.trim().isEmpty) {
      _error('Standardized / New Standard reference is required.');
      return;
    }

    final record = <String, dynamic>{
      'recordNo': recordNo.text.trim(),
      'title': title.text.trim(),
      'description': description.text.trim(),
      'module': module,
      'status': status,
      'priority': priority,
      'performanceStatus': performanceStatus,
      'reviewFrequency': reviewFrequency,
      'project': project.text.trim(),
      'site': site.text.trim(),
      'location': location.text.trim(),
      'department': department.text.trim(),
      'owner': owner.text.trim(),
      'dueDate': dueDate.text.trim(),
      'kpiName': kpiName.text.trim(),
      'indicatorName': indicatorName.text.trim(),
      'indicatorType': indicatorType,
      'target': target.text.trim(),
      'actual': actual.text.trim(),
      'unit': unit.text.trim(),
      'measurementPeriod': measurementPeriod.text.trim(),
      'previousValue': previousValue.text.trim(),
      'variance': variance.text.trim(),
      'gap': gap.text.trim(),
      'rootCause': rootCause.text.trim(),
      'recurrenceStatus': recurrenceStatus.text.trim(),
      'recurrenceCount': recurrenceCount.text.trim(),
      'contributingFactors': contributingFactors.text.trim(),
      'improvementType': improvementType,
      'improvementAction': improvementAction.text.trim(),
      'actionOwner': actionOwner.text.trim(),
      'actionDue': actionDue.text.trim(),
      'effectiveness': effectiveness.text.trim(),
      'verificationDate': verificationDate.text.trim(),
      'standardized': standardized.text.trim(),
      'bestPractice': bestPractice.text.trim(),
      'riskReference': riskReference.text.trim(),
      'ramsReference': ramsReference.text.trim(),
      'ptwReference': ptwReference.text.trim(),
      'incidentReference': incidentReference.text.trim(),
      'auditReference': auditReference.text.trim(),
      'trainingReference': trainingReference.text.trim(),
      'legalReference': legalReference.text.trim(),
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
                    const Icon(Icons.trending_up, color: darkGreen),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        editing
                            ? 'Edit Performance Record'
                            : 'Create Performance Record',
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
                  recordNo,
                  'Record No.',
                  required: true,
                ),
                _field(
                  title,
                  'Title',
                  required: true,
                ),
                _dropdown(
                  'Module',
                  module,
                  widget.modules,
                  (value) => setState(
                    () => module = value ?? module,
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
                  'Performance Status',
                  performanceStatus,
                  widget.performanceStatuses,
                  (value) => setState(
                    () => performanceStatus =
                        value ?? performanceStatus,
                  ),
                ),
                _dropdown(
                  'Review Frequency',
                  reviewFrequency,
                  widget.reviewFrequencies,
                  (value) => setState(
                    () => reviewFrequency =
                        value ?? reviewFrequency,
                  ),
                ),
                _field(description, 'Description', maxLines: 4),
                _field(project, 'Project'),
                _field(site, 'Site'),
                _field(location, 'Location'),
                _field(department, 'Department'),
                _field(owner, 'Responsible Owner'),
                _dateField('Due Date', dueDate),
                const SizedBox(height: 3),
                const Text(
                  'KPI & Indicator Monitoring',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                _field(kpiName, 'KPI Name'),
                _field(indicatorName, 'Indicator Name'),
                _dropdown(
                  'Indicator Type',
                  indicatorType,
                  widget.indicatorTypes,
                  (value) => setState(
                    () => indicatorType =
                        value ?? indicatorType,
                  ),
                ),
                _field(target, 'Target'),
                _field(actual, 'Actual'),
                _field(unit, 'Unit'),
                _field(measurementPeriod, 'Measurement Period'),
                _field(previousValue, 'Previous Value'),
                _field(variance, 'Variance'),
                const SizedBox(height: 3),
                const Text(
                  'Gap, Root Cause & Recurrence',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                _field(gap, 'Gap / Finding', maxLines: 3),
                _field(rootCause, 'Root Cause', maxLines: 4),
                _field(
                  recurrenceStatus,
                  'Recurrence Status',
                ),
                _field(
                  recurrenceCount,
                  'Recurrence Count',
                ),
                _field(
                  contributingFactors,
                  'Contributing Factors',
                  maxLines: 3,
                ),
                const SizedBox(height: 3),
                const Text(
                  'Improvement & Effectiveness',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                _dropdown(
                  'Improvement Type',
                  improvementType,
                  widget.improvementTypes,
                  (value) => setState(
                    () => improvementType =
                        value ?? improvementType,
                  ),
                ),
                _field(
                  improvementAction,
                  'Improvement / Corrective Action',
                  maxLines: 4,
                ),
                _field(actionOwner, 'Action Owner'),
                _dateField('Action Due', actionDue),
                _field(
                  effectiveness,
                  'Effectiveness / Evidence',
                  maxLines: 4,
                ),
                _dateField(
                  'Verification Date',
                  verificationDate,
                ),
                _field(
                  standardized,
                  'Standardized / New Standard Reference',
                ),
                _field(
                  bestPractice,
                  'Lesson Learned / Best Practice',
                  maxLines: 4,
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
                  incidentReference,
                  'Incident / CAPA Reference',
                ),
                _field(
                  auditReference,
                  'Audit / Inspection Reference',
                ),
                _field(
                  trainingReference,
                  'Training / Workforce Reference',
                ),
                _field(
                  legalReference,
                  'Legal / Authority Reference',
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
                        ? 'Update Performance Record'
                        : 'Save Performance Record',
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
