import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiskMonitoringReviewSchedulePage extends StatefulWidget {
  const RiskMonitoringReviewSchedulePage({
    super.key,
  });

  @override
  State<RiskMonitoringReviewSchedulePage> createState() =>
      _RiskMonitoringReviewSchedulePageState();
}

class _RiskMonitoringReviewSchedulePageState
    extends State<RiskMonitoringReviewSchedulePage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const String storageKey =
      'safenexus_hse_risk_monitoring_review_schedule';

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _records = [];

  String _statusFilter = 'All';
  String _riskFilter = 'All';

  static const List<String> riskLevels = [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static const List<String> statuses = [
    'Draft',
    'Scheduled',
    'Due',
    'Under Review',
    'Action Required',
    'Reassessment Required',
    'Approved',
    'Monitoring',
    'Closed',
    'Cancelled',
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

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
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
        _records = decoded
            .whereType<Map>()
            .map(
              (item) => Map<String, dynamic>.from(item),
            )
            .toList();

        if (mounted) {
          setState(() {});
        }
      }
    } catch (_) {
      _records = [];
    }
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      storageKey,
      jsonEncode(_records),
    );
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchController.text.trim().toLowerCase();

    return _records.where((record) {
      final status = record['status']?.toString() ?? '';
      final residualRiskLevel =
          record['residualRiskLevel']?.toString() ?? '';

      final matchesStatus =
          _statusFilter == 'All' || status == _statusFilter;

      final matchesRisk =
          _riskFilter == 'All' || residualRiskLevel == _riskFilter;

      if (!matchesStatus || !matchesRisk) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      final searchable = [
        record['monitoringNo'],
        record['riskReference'],
        record['project'],
        record['location'],
        record['department'],
        record['activity'],
        record['hazard'],
        record['risk'],
        record['riskOwner'],
        record['reviewer'],
        record['approver'],
        record['monitoringFrequency'],
        record['status'],
        record['residualRiskLevel'],
      ].join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();
  }

  int _countStatus(String status) {
    return _records
        .where(
          (record) => record['status'] == status,
        )
        .length;
  }

  int _countRisk(String level) {
    return _records
        .where(
          (record) => record['residualRiskLevel'] == level,
        )
        .length;
  }

  int get _overdueCount {
    final today = DateTime.now();

    final todayOnly = DateTime(
      today.year,
      today.month,
      today.day,
    );

    return _records.where((record) {
      final nextReviewDate = _parseDate(
        record['nextReviewDate'],
      );

      if (nextReviewDate == null) {
        return false;
      }

      final status = record['status']?.toString() ?? '';

      return nextReviewDate.isBefore(todayOnly) &&
          status != 'Closed' &&
          status != 'Cancelled' &&
          status != 'Approved';
    }).length;
  }

  int get _actionOverdueCount {
    final today = DateTime.now();

    final todayOnly = DateTime(
      today.year,
      today.month,
      today.day,
    );

    return _records.where((record) {
      final actionDueDate = _parseDate(
        record['actionDueDate'],
      );

      if (actionDueDate == null) {
        return false;
      }

      final status = record['status']?.toString() ?? '';

      final actionRequired =
          record['additionalActionRequired']?.toString() ?? '';

      if (actionRequired.trim().isEmpty) {
        return false;
      }

      return actionDueDate.isBefore(todayOnly) &&
          status != 'Closed' &&
          status != 'Cancelled';
    }).length;
  }

  DateTime? _parseDate(dynamic value) {
    if (value == null) {
      return null;
    }

    final text = value.toString();

    if (text.isEmpty) {
      return null;
    }

    return DateTime.tryParse(text);
  }

  String _formatDate(dynamic value) {
    final date = _parseDate(value);

    if (date == null) {
      return '-';
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _formatDateTime(dynamic value) {
    final date = _parseDate(value);

    if (date == null) {
      return '-';
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  Color _riskColor(String level) {
    switch (level) {
      case 'Low':
        return primaryGreen;
      case 'Medium':
        return Colors.orange;
      case 'High':
        return Colors.deepOrange;
      case 'Critical':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Approved':
      case 'Monitoring':
      case 'Closed':
        return primaryGreen;

      case 'Scheduled':
      case 'Under Review':
      case 'Reassessment Required':
        return Colors.orange;

      case 'Due':
      case 'Action Required':
        return Colors.deepOrange;

      case 'Cancelled':
        return Colors.red;

      case 'Draft':
        return Colors.blueGrey;

      default:
        return Colors.grey;
    }
  }

  Future<void> _addRecord() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _RiskMonitoringFormSheet(),
    );

    if (result == null) {
      return;
    }

    final now = DateTime.now().toIso8601String();

    result['id'] =
        DateTime.now().microsecondsSinceEpoch.toString();

    result['createdAt'] = now;
    result['updatedAt'] = now;

    setState(() {
      _records.insert(0, result);
    });

    await _saveRecords();
  }

  Future<void> _editRecord(int index) async {
    final existing = _filteredRecords[index];

    final actualIndex = _records.indexWhere(
      (record) => record['id'] == existing['id'],
    );

    if (actualIndex < 0) {
      return;
    }

    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _RiskMonitoringFormSheet(
        initialData: Map<String, dynamic>.from(existing),
      ),
    );

    if (result == null) {
      return;
    }

    result['id'] = existing['id'];
    result['createdAt'] = existing['createdAt'];
    result['updatedAt'] = DateTime.now().toIso8601String();

    setState(() {
      _records[actualIndex] = result;
    });

    await _saveRecords();
  }

  Future<void> _deleteRecord(int index) async {
    final record = _filteredRecords[index];

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Record'),
          content: Text(
            'Delete ${record['monitoringNo'] ?? 'this record'}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(
                dialogContext,
                false,
              ),
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () => Navigator.pop(
                dialogContext,
                true,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    final actualIndex = _records.indexWhere(
      (record) => record['id'] == record['id'],
    );

    final targetId = record['id'];

    final targetIndex = _records.indexWhere(
      (item) => item['id'] == targetId,
    );

    if (actualIndex < 0 || targetIndex < 0) {
      return;
    }

    setState(() {
      _records.removeAt(targetIndex);
    });

    await _saveRecords();
  }

  void _showHistory(
    Map<String, dynamic> record,
  ) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  'Record History',
                  style: Theme.of(sheetContext)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                      ),
                ),
                const SizedBox(height: 16),
                _historyRow(
                  'Created',
                  _formatDateTime(record['createdAt']),
                ),
                _historyRow(
                  'Last Updated',
                  _formatDateTime(record['updatedAt']),
                ),
                const SizedBox(height: 12),
                const Text(
                  'This register stores record creation and '
                  'last-update timestamps.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _historyRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final records = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'Risk Monitoring & Review',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: _addRecord,
        icon: const Icon(Icons.add),
        label: const Text('Add Monitoring'),
      ),
      body: Column(
        children: [
          _buildHeader(),
          _buildDashboard(),
          _buildFilters(),
          Expanded(
            child: records.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      12,
                      4,
                      12,
                      100,
                    ),
                    itemCount: records.length,
                    itemBuilder: (context, index) {
                      return _buildRecordCard(
                        records[index],
                        index,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        14,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '3J • Risk Monitoring & Review Schedule',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(
                  color: darkGreen,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Plan periodic risk monitoring, review findings, '
            'track actions and trigger reassessment when required.',
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        12,
        12,
        12,
        8,
      ),
      child: Row(
        children: [
          Expanded(
            child: _summaryCard(
              'Total',
              _records.length.toString(),
              Icons.assignment_outlined,
              primaryGreen,
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: _summaryCard(
              'Due',
              (
                _countStatus('Due') +
                    _countStatus('Action Required')
              ).toString(),
              Icons.schedule,
              Colors.deepOrange,
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: _summaryCard(
              'High+',
              (
                _countRisk('High') +
                    _countRisk('Critical')
              ).toString(),
              Icons.warning_amber_rounded,
              Colors.red,
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: _summaryCard(
              'Overdue',
              (
                _overdueCount +
                    _actionOverdueCount
              ).toString(),
              Icons.notification_important_outlined,
              Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 10,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 21,
              color: color,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        12,
        4,
        12,
        8,
      ),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText:
                  'Search no., project, activity, hazard, owner...',
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
                child: _filterDropdown(
                  value: _statusFilter,
                  items: [
                    'All',
                    ...statuses,
                  ],
                  label: 'Status',
                  onChanged: (value) {
                    setState(() {
                      _statusFilter = value ?? 'All';
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _filterDropdown(
                  value: _riskFilter,
                  items: [
                    'All',
                    ...riskLevels,
                  ],
                  label: 'Residual Risk',
                  onChanged: (value) {
                    setState(() {
                      _riskFilter = value ?? 'All';
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _filterDropdown({
    required String value,
    required List<String> items,
    required String label,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
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

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.monitor_heart_outlined,
              size: 70,
              color: primaryGreen.withValues(alpha: 0.35),
            ),
            const SizedBox(height: 16),
            const Text(
              'No Risk Monitoring Records',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add a monitoring schedule to track periodic '
              'risk reviews, findings and corrective actions.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordCard(
    Map<String, dynamic> record,
    int index,
  ) {
    final status = record['status']?.toString() ?? 'Draft';

    final residualLevel =
        record['residualRiskLevel']?.toString() ?? 'Not Assessed';

    final nextReviewDate = _parseDate(
      record['nextReviewDate'],
    );

    final actionDueDate = _parseDate(
      record['actionDueDate'],
    );

    final today = DateTime.now();

    final todayOnly = DateTime(
      today.year,
      today.month,
      today.day,
    );

    final reviewOverdue =
        nextReviewDate != null &&
            nextReviewDate.isBefore(todayOnly) &&
            status != 'Closed' &&
            status != 'Cancelled' &&
            status != 'Approved';

    final actionText =
        record['additionalActionRequired']?.toString() ?? '';

    final actionOverdue =
        actionText.trim().isNotEmpty &&
            actionDueDate != null &&
            actionDueDate.isBefore(todayOnly) &&
            status != 'Closed' &&
            status != 'Cancelled';

    final riskColor = _riskColor(residualLevel);
    final statusColor = _statusColor(status);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showDetails(record),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      record['monitoringNo']?.toString() ??
                          'Risk Monitoring',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                      ),
                    ),
                  ),
                  _statusChip(
                    status,
                    statusColor,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                record['project']?.toString() ?? '-',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if ((record['activity']?.toString() ?? '').isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    record['activity'].toString(),
                  ),
                ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _infoItem(
                      'Risk Ref.',
                      record['riskReference']?.toString() ?? '-',
                    ),
                  ),
                  Expanded(
                    child: _infoItem(
                      'Residual Risk',
                      residualLevel,
                      valueColor: riskColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _infoItem(
                      'Frequency',
                      record['monitoringFrequency']?.toString() ?? '-',
                    ),
                  ),
                  Expanded(
                    child: _infoItem(
                      'Next Review',
                      _formatDate(record['nextReviewDate']),
                      valueColor:
                          reviewOverdue ? Colors.red : null,
                    ),
                  ),
                ],
              ),
              if (reviewOverdue) ...[
                const SizedBox(height: 7),
                const Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 18,
                      color: Colors.red,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'OVERDUE REVIEW',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
              if (actionOverdue) ...[
                const SizedBox(height: 5),
                const Row(
                  children: [
                    Icon(
                      Icons.assignment_late_outlined,
                      size: 18,
                      color: Colors.deepOrange,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'OVERDUE ACTION',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
              const Divider(height: 18),
              Row(
                children: [
                  IconButton(
                    tooltip: 'History',
                    onPressed: () => _showHistory(record),
                    icon: const Icon(
                      Icons.history,
                      color: darkGreen,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Edit',
                    onPressed: () => _editRecord(index),
                    icon: const Icon(
                      Icons.edit_outlined,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Delete',
                    onPressed: () => _deleteRecord(index),
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () => _showDetails(record),
                    icon: const Icon(
                      Icons.visibility_outlined,
                    ),
                    label: const Text('View'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoItem(
    String title,
    String value, {
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(
    String status,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  void _showDetails(
    Map<String, dynamic> record,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (sheetContext) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(sheetContext).size.height * 0.88,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                18,
                4,
                18,
                30,
              ),
              children: [
                Text(
                  record['monitoringNo']?.toString() ??
                      'Risk Monitoring',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  record['project']?.toString() ?? '-',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _detailSection(
                  'Risk Identification',
                  [
                    _detailRow(
                      'Risk Reference',
                      record['riskReference'],
                    ),
                    _detailRow(
                      'Location',
                      record['location'],
                    ),
                    _detailRow(
                      'Department',
                      record['department'],
                    ),
                    _detailRow(
                      'Activity / Work',
                      record['activity'],
                    ),
                    _detailRow(
                      'Hazard',
                      record['hazard'],
                    ),
                    _detailRow(
                      'Risk',
                      record['risk'],
                    ),
                    _detailRow(
                      'Consequence',
                      record['consequence'],
                    ),
                  ],
                ),
                _detailSection(
                  'Risk Assessment',
                  [
                    _detailRow(
                      'Initial Likelihood',
                      record['initialLikelihood'],
                    ),
                    _detailRow(
                      'Initial Severity',
                      record['initialSeverity'],
                    ),
                    _detailRow(
                      'Initial Score',
                      record['initialRiskScore'],
                    ),
                    _detailRow(
                      'Initial Level',
                      record['initialRiskLevel'],
                    ),
                    _detailRow(
                      'Residual Likelihood',
                      record['residualLikelihood'],
                    ),
                    _detailRow(
                      'Residual Severity',
                      record['residualSeverity'],
                    ),
                    _detailRow(
                      'Residual Score',
                      record['residualRiskScore'],
                    ),
                    _detailRow(
                      'Residual Level',
                      record['residualRiskLevel'],
                    ),
                  ],
                ),
                _detailSection(
                  'Monitoring Schedule',
                  [
                    _detailRow(
                      'Monitoring Frequency',
                      record['monitoringFrequency'],
                    ),
                    _detailRow(
                      'Review Trigger',
                      record['reviewTrigger'],
                    ),
                    _detailRow(
                      'Last Review',
                      _formatDate(record['lastReviewDate']),
                    ),
                    _detailRow(
                      'Next Review',
                      _formatDate(record['nextReviewDate']),
                    ),
                    _detailRow(
                      'Risk Owner',
                      record['riskOwner'],
                    ),
                  ],
                ),
                _detailSection(
                  'Review Findings & Controls',
                  [
                    _detailRow(
                      'Monitoring Findings',
                      record['monitoringFindings'],
                    ),
                    _detailRow(
                      'Control Effectiveness',
                      record['controlEffectiveness'],
                    ),
                    _detailRow(
                      'Additional Action Required',
                      record['additionalActionRequired'],
                    ),
                    _detailRow(
                      'Action Owner',
                      record['actionOwner'],
                    ),
                    _detailRow(
                      'Action Due Date',
                      _formatDate(record['actionDueDate']),
                    ),
                  ],
                ),
                _detailSection(
                  'Reassessment & Approval',
                  [
                    _detailRow(
                      'Reassessment Required',
                      record['reassessmentRequired'],
                    ),
                    _detailRow(
                      'Reassessment Reference',
                      record['reassessmentReference'],
                    ),
                    _detailRow(
                      'Reviewer',
                      record['reviewer'],
                    ),
                    _detailRow(
                      'Approver',
                      record['approver'],
                    ),
                    _detailRow(
                      'Approval Date',
                      _formatDate(record['approvalDate']),
                    ),
                    _detailRow(
                      'Status',
                      record['status'],
                    ),
                    _detailRow(
                      'Remarks',
                      record['remarks'],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _detailSection(
    String title,
    List<Widget> children,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            color: pageBackground,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(
    String title,
    dynamic value,
  ) {
    final text = value?.toString() ?? '-';

    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text.isEmpty ? '-' : text,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RiskMonitoringFormSheet extends StatefulWidget {
  final Map<String, dynamic>? initialData;

  const _RiskMonitoringFormSheet({
    this.initialData,
  });

  @override
  State<_RiskMonitoringFormSheet> createState() =>
      _RiskMonitoringFormSheetState();
}

class _RiskMonitoringFormSheetState
    extends State<_RiskMonitoringFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();

  final _monitoringNoController = TextEditingController();
  final _projectController = TextEditingController();
  final _locationController = TextEditingController();
  final _departmentController = TextEditingController();
  final _activityController = TextEditingController();
  final _hazardController = TextEditingController();
  final _riskController = TextEditingController();
  final _consequenceController = TextEditingController();

  final _riskOwnerController = TextEditingController();

  final _reviewTriggerController = TextEditingController();

  final _monitoringFindingsController =
      TextEditingController();

  final _additionalActionController =
      TextEditingController();

  final _actionOwnerController =
      TextEditingController();

  final _reassessmentReferenceController =
      TextEditingController();

  final _reviewerController = TextEditingController();
  final _approverController = TextEditingController();

  final _remarksController = TextEditingController();

  String _riskReference = 'HIRA';

  String _monitoringFrequency = 'Monthly';

  String _controlEffectiveness = 'Not Assessed';

  String _reassessmentRequired = 'No';

  String _status = 'Draft';

  int _initialLikelihood = 1;
  int _initialSeverity = 1;

  int _residualLikelihood = 1;
  int _residualSeverity = 1;

  DateTime? _lastReviewDate;
  DateTime? _nextReviewDate;
  DateTime? _actionDueDate;
  DateTime? _approvalDate;

  bool get _isEditing =>
      widget.initialData != null;

  int get _initialScore =>
      _initialLikelihood * _initialSeverity;

  String get _initialLevel =>
      _riskLevelFromScore(_initialScore);

  int get _residualScore =>
      _residualLikelihood * _residualSeverity;

  String get _residualLevel =>
      _riskLevelFromScore(_residualScore);

  @override
  void initState() {
    super.initState();

    final data = widget.initialData;

    if (data == null) {
      _monitoringNoController.text =
          'RM-${DateTime.now().millisecondsSinceEpoch}';
      return;
    }

    _loadData(data);
  }

  void _loadData(
    Map<String, dynamic> data,
  ) {
    _monitoringNoController.text =
        data['monitoringNo']?.toString() ?? '';

    _projectController.text =
        data['project']?.toString() ?? '';

    _locationController.text =
        data['location']?.toString() ?? '';

    _departmentController.text =
        data['department']?.toString() ?? '';

    _activityController.text =
        data['activity']?.toString() ?? '';

    _hazardController.text =
        data['hazard']?.toString() ?? '';

    _riskController.text =
        data['risk']?.toString() ?? '';

    _consequenceController.text =
        data['consequence']?.toString() ?? '';

    _riskOwnerController.text =
        data['riskOwner']?.toString() ?? '';

    _reviewTriggerController.text =
        data['reviewTrigger']?.toString() ?? '';

    _monitoringFindingsController.text =
        data['monitoringFindings']?.toString() ?? '';

    _additionalActionController.text =
        data['additionalActionRequired']?.toString() ?? '';

    _actionOwnerController.text =
        data['actionOwner']?.toString() ?? '';

    _reassessmentReferenceController.text =
        data['reassessmentReference']?.toString() ?? '';

    _reviewerController.text =
        data['reviewer']?.toString() ?? '';

    _approverController.text =
        data['approver']?.toString() ?? '';

    _remarksController.text =
        data['remarks']?.toString() ?? '';

    _riskReference =
        data['riskReference']?.toString() ?? 'HIRA';

    _monitoringFrequency =
        data['monitoringFrequency']?.toString() ?? 'Monthly';

    _controlEffectiveness =
        data['controlEffectiveness']?.toString() ??
            'Not Assessed';

    _reassessmentRequired =
        data['reassessmentRequired']?.toString() ?? 'No';

    _status =
        data['status']?.toString() ?? 'Draft';

    _initialLikelihood =
        _safeRiskValue(data['initialLikelihood']);

    _initialSeverity =
        _safeRiskValue(data['initialSeverity']);

    _residualLikelihood =
        _safeRiskValue(data['residualLikelihood']);

    _residualSeverity =
        _safeRiskValue(data['residualSeverity']);

    _lastReviewDate =
        _parseDate(data['lastReviewDate']);

    _nextReviewDate =
        _parseDate(data['nextReviewDate']);

    _actionDueDate =
        _parseDate(data['actionDueDate']);

    _approvalDate =
        _parseDate(data['approvalDate']);
  }

  int _safeRiskValue(dynamic value) {
    final parsed =
        int.tryParse(value?.toString() ?? '');

    if (parsed == null || parsed < 1) {
      return 1;
    }

    if (parsed > 5) {
      return 5;
    }

    return parsed;
  }

  DateTime? _parseDate(dynamic value) {
    if (value == null) {
      return null;
    }

    return DateTime.tryParse(value.toString());
  }

  String _riskLevelFromScore(int score) {
    if (score <= 4) {
      return 'Low';
    }

    if (score <= 11) {
      return 'Medium';
    }

    if (score <= 19) {
      return 'High';
    }

    return 'Critical';
  }

  @override
  void dispose() {
    _monitoringNoController.dispose();
    _projectController.dispose();
    _locationController.dispose();
    _departmentController.dispose();
    _activityController.dispose();
    _hazardController.dispose();
    _riskController.dispose();
    _consequenceController.dispose();
    _riskOwnerController.dispose();
    _reviewTriggerController.dispose();
    _monitoringFindingsController.dispose();
    _additionalActionController.dispose();
    _actionOwnerController.dispose();
    _reassessmentReferenceController.dispose();
    _reviewerController.dispose();
    _approverController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({
    required DateTime? current,
    required ValueChanged<DateTime> onSelected,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: current ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      onSelected(picked);
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'Select date';
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  bool _validateBusinessRules() {
    if (_nextReviewDate == null &&
        (_status == 'Scheduled' ||
            _status == 'Due' ||
            _status == 'Under Review' ||
            _status == 'Monitoring')) {
      _showError(
        'Next Review Date is required for active monitoring.',
      );
      return false;
    }

    if (_status == 'Action Required' &&
        _additionalActionController.text.trim().isEmpty) {
      _showError(
        'Additional Action Required must be documented.',
      );
      return false;
    }

    if (_status == 'Action Required' &&
        _actionOwnerController.text.trim().isEmpty) {
      _showError(
        'Action Owner is required.',
      );
      return false;
    }

    if (_status == 'Reassessment Required' &&
        _reassessmentRequired != 'Yes') {
      _showError(
        'Reassessment Required must be Yes for this status.',
      );
      return false;
    }

    if (_status == 'Approved' &&
        _approverController.text.trim().isEmpty) {
      _showError(
        'Approver is required before approval.',
      );
      return false;
    }

    if (_status == 'Approved' &&
        _approvalDate == null) {
      _showError(
        'Approval Date is required.',
      );
      return false;
    }

    if (_residualScore > _initialScore &&
        _monitoringFindingsController.text.trim().isEmpty) {
      _showError(
        'If residual risk is higher than initial risk, '
        'document the monitoring findings.',
      );
      return false;
    }

    if (_nextReviewDate != null &&
        _lastReviewDate != null &&
        _nextReviewDate!.isBefore(_lastReviewDate!)) {
      _showError(
        'Next Review Date cannot be before Last Review Date.',
      );
      return false;
    }

    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_validateBusinessRules()) {
      return;
    }

    final data = <String, dynamic>{
      'monitoringNo':
          _monitoringNoController.text.trim(),

      'riskReference':
          _riskReference,

      'project':
          _projectController.text.trim(),

      'location':
          _locationController.text.trim(),

      'department':
          _departmentController.text.trim(),

      'activity':
          _activityController.text.trim(),

      'hazard':
          _hazardController.text.trim(),

      'risk':
          _riskController.text.trim(),

      'consequence':
          _consequenceController.text.trim(),

      'initialLikelihood':
          _initialLikelihood,

      'initialSeverity':
          _initialSeverity,

      'initialRiskScore':
          _initialScore,

      'initialRiskLevel':
          _initialLevel,

      'residualLikelihood':
          _residualLikelihood,

      'residualSeverity':
          _residualSeverity,

      'residualRiskScore':
          _residualScore,

      'residualRiskLevel':
          _residualLevel,

      'riskOwner':
          _riskOwnerController.text.trim(),

      'monitoringFrequency':
          _monitoringFrequency,

      'reviewTrigger':
          _reviewTriggerController.text.trim(),

      'lastReviewDate':
          _lastReviewDate?.toIso8601String(),

      'nextReviewDate':
          _nextReviewDate?.toIso8601String(),

      'monitoringFindings':
          _monitoringFindingsController.text.trim(),

      'controlEffectiveness':
          _controlEffectiveness,

      'additionalActionRequired':
          _additionalActionController.text.trim(),

      'actionOwner':
          _actionOwnerController.text.trim(),

      'actionDueDate':
          _actionDueDate?.toIso8601String(),

      'reassessmentRequired':
          _reassessmentRequired,

      'reassessmentReference':
          _reassessmentReferenceController.text.trim(),

      'reviewer':
          _reviewerController.text.trim(),

      'approver':
          _approverController.text.trim(),

      'approvalDate':
          _approvalDate?.toIso8601String(),

      'status':
          _status,

      'remarks':
          _remarksController.text.trim(),
    };

    Navigator.of(context).pop(data);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset =
        MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.94,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Column(
          children: [
            _buildFormHeader(),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    8,
                    16,
                    30 + bottomInset,
                  ),
                  children: [
                    _sectionTitle(
                      '1. Monitoring Identification',
                    ),
                    _textField(
                      controller:
                          _monitoringNoController,
                      label:
                          'Risk Monitoring No.',
                      required: true,
                    ),
                    _dropdownField(
                      label:
                          'Risk Reference',
                      value:
                          _riskReference,
                      items: const [
                        'HIRA',
                        'JSA / JHA',
                        'RAMS',
                        'Risk Control Register',
                        'Risk Register Monitoring',
                        'Risk Acceptance',
                        'Other',
                      ],
                      onChanged: (value) {
                        setState(() {
                          _riskReference =
                              value ?? 'HIRA';
                        });
                      },
                    ),

                    _sectionTitle(
                      '2. Project & Work Information',
                    ),
                    _textField(
                      controller:
                          _projectController,
                      label: 'Project',
                      required: true,
                    ),
                    _textField(
                      controller:
                          _locationController,
                      label: 'Location',
                    ),
                    _textField(
                      controller:
                          _departmentController,
                      label:
                          'Department',
                    ),
                    _textField(
                      controller:
                          _activityController,
                      label:
                          'Activity / Work',
                      required: true,
                    ),
                    _textField(
                      controller:
                          _hazardController,
                      label: 'Hazard',
                      required: true,
                    ),
                    _textField(
                      controller:
                          _riskController,
                      label: 'Risk',
                      required: true,
                      maxLines: 3,
                    ),
                    _textField(
                      controller:
                          _consequenceController,
                      label:
                          'Consequence',
                      maxLines: 3,
                    ),

                    _sectionTitle(
                      '3. Initial Risk Assessment',
                    ),
                    _riskSelector(
                      title:
                          'Initial Likelihood',
                      value:
                          _initialLikelihood,
                      onChanged: (value) {
                        setState(() {
                          _initialLikelihood =
                              value;
                        });
                      },
                    ),
                    _riskSelector(
                      title:
                          'Initial Severity',
                      value:
                          _initialSeverity,
                      onChanged: (value) {
                        setState(() {
                          _initialSeverity =
                              value;
                        });
                      },
                    ),
                    _riskSummary(
                      'Initial Risk',
                      _initialScore,
                      _initialLevel,
                    ),

                    _sectionTitle(
                      '4. Residual Risk Assessment',
                    ),
                    _riskSelector(
                      title:
                          'Residual Likelihood',
                      value:
                          _residualLikelihood,
                      onChanged: (value) {
                        setState(() {
                          _residualLikelihood =
                              value;
                        });
                      },
                    ),
                    _riskSelector(
                      title:
                          'Residual Severity',
                      value:
                          _residualSeverity,
                      onChanged: (value) {
                        setState(() {
                          _residualSeverity =
                              value;
                        });
                      },
                    ),
                    _riskSummary(
                      'Residual Risk',
                      _residualScore,
                      _residualLevel,
                    ),

                    _sectionTitle(
                      '5. Monitoring Schedule',
                    ),
                    _dropdownField(
                      label:
                          'Monitoring Frequency',
                      value:
                          _monitoringFrequency,
                      items: const [
                        'Daily',
                        'Weekly',
                        'Bi-Weekly',
                        'Monthly',
                        'Quarterly',
                        'Half-Yearly',
                        'Yearly',
                        'Event-Based',
                        'As Required',
                      ],
                      onChanged: (value) {
                        setState(() {
                          _monitoringFrequency =
                              value ?? 'Monthly';
                        });
                      },
                    ),
                    _textField(
                      controller:
                          _reviewTriggerController,
                      label:
                          'Review Trigger',
                      maxLines: 4,
                    ),
                    _dateField(
                      label:
                          'Last Review Date',
                      value:
                          _lastReviewDate,
                      onTap: () =>
                          _pickDate(
                        current:
                            _lastReviewDate,
                        onSelected: (date) {
                          setState(() {
                            _lastReviewDate =
                                date;
                          });
                        },
                      ),
                    ),
                    _dateField(
                      label:
                          'Next Review Date',
                      value:
                          _nextReviewDate,
                      onTap: () =>
                          _pickDate(
                        current:
                            _nextReviewDate,
                        onSelected: (date) {
                          setState(() {
                            _nextReviewDate =
                                date;
                          });
                        },
                      ),
                    ),
                    _textField(
                      controller:
                          _riskOwnerController,
                      label:
                          'Risk Owner',
                      required: true,
                    ),

                    _sectionTitle(
                      '6. Monitoring Findings & Controls',
                    ),
                    _textField(
                      controller:
                          _monitoringFindingsController,
                      label:
                          'Monitoring Findings',
                      maxLines: 6,
                    ),
                    _dropdownField(
                      label:
                          'Control Effectiveness',
                      value:
                          _controlEffectiveness,
                      items: const [
                        'Not Assessed',
                        'Effective',
                        'Partially Effective',
                        'Ineffective',
                      ],
                      onChanged: (value) {
                        setState(() {
                          _controlEffectiveness =
                              value ??
                                  'Not Assessed';
                        });
                      },
                    ),
                    _textField(
                      controller:
                          _additionalActionController,
                      label:
                          'Additional Action Required',
                      maxLines: 5,
                    ),
                    _textField(
                      controller:
                          _actionOwnerController,
                      label:
                          'Action Owner',
                    ),
                    _dateField(
                      label:
                          'Action Due Date',
                      value:
                          _actionDueDate,
                      onTap: () =>
                          _pickDate(
                        current:
                            _actionDueDate,
                        onSelected: (date) {
                          setState(() {
                            _actionDueDate =
                                date;
                          });
                        },
                      ),
                    ),

                    _sectionTitle(
                      '7. Reassessment',
                    ),
                    _dropdownField(
                      label:
                          'Reassessment Required',
                      value:
                          _reassessmentRequired,
                      items: const [
                        'No',
                        'Yes',
                      ],
                      onChanged: (value) {
                        setState(() {
                          _reassessmentRequired =
                              value ?? 'No';
                        });
                      },
                    ),
                    _textField(
                      controller:
                          _reassessmentReferenceController,
                      label:
                          'Reassessment Reference',
                    ),

                    _sectionTitle(
                      '8. Review & Approval',
                    ),
                    _textField(
                      controller:
                          _reviewerController,
                      label:
                          'Reviewer',
                    ),
                    _textField(
                      controller:
                          _approverController,
                      label:
                          'Approver',
                    ),
                    _dateField(
                      label:
                          'Approval Date',
                      value:
                          _approvalDate,
                      onTap: () =>
                          _pickDate(
                        current:
                            _approvalDate,
                        onSelected: (date) {
                          setState(() {
                            _approvalDate =
                                date;
                          });
                        },
                      ),
                    ),
                    _dropdownField(
                      label: 'Status',
                      value:
                          _status,
                      items: const [
                        'Draft',
                        'Scheduled',
                        'Due',
                        'Under Review',
                        'Action Required',
                        'Reassessment Required',
                        'Approved',
                        'Monitoring',
                        'Closed',
                        'Cancelled',
                      ],
                      onChanged: (value) {
                        setState(() {
                          _status =
                              value ?? 'Draft';
                        });
                      },
                    ),
                    _textField(
                      controller:
                          _remarksController,
                      label:
                          'Remarks',
                      maxLines: 4,
                    ),

                    const SizedBox(height: 20),

                    _buildRiskMatrix(),

                    const SizedBox(height: 24),

                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor:
                            primaryGreen,
                        foregroundColor:
                            Colors.white,
                        minimumSize:
                            const Size.fromHeight(
                          52,
                        ),
                      ),
                      onPressed: _submit,
                      icon: Icon(
                        _isEditing
                            ? Icons.save_outlined
                            : Icons.add_task,
                      ),
                      label: Text(
                        _isEditing
                            ? 'Update Monitoring Schedule'
                            : 'Save Monitoring Schedule',
                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        18,
        14,
        12,
        12,
      ),
      decoration: const BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              '3J • Risk Monitoring & Review Schedule',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.white,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 18,
        bottom: 10,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: darkGreen,
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    bool required = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText:
              required ? '$label *' : label,
          alignLabelWithHint: maxLines > 1,
          filled: true,
          fillColor: const Color(0xFFF8FAF9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        validator: required
            ? (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return '$label is required';
                }

                return null;
              }
            : null,
      ),
    );
  }

  Widget _dropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color(0xFFF8FAF9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _riskSelector({
    required String title,
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<int>(
        initialValue: value,
        decoration: InputDecoration(
          labelText: title,
          filled: true,
          fillColor: const Color(0xFFF8FAF9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        items: List.generate(
          5,
          (index) {
            final number = index + 1;

            return DropdownMenuItem<int>(
              value: number,
              child: Text(number.toString()),
            );
          },
        ),
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
      ),
    );
  }

  Widget _riskSummary(
    String title,
    int score,
    String level,
  ) {
    final color = _matrixColor(level);

    return Card(
      elevation: 0,
      color: color.withValues(alpha: 0.10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              Icons.assessment_outlined,
              color: color,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '$score • $level',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateField({
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(11),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: const Color(0xFFF8FAF9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 19,
                color: darkGreen,
              ),
              const SizedBox(width: 10),
              Text(
                _formatDate(value),
                style: TextStyle(
                  color: value == null
                      ? Colors.grey
                      : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRiskMatrix() {
    const levels = [
      'Low',
      'Medium',
      'High',
      'Critical',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '5 × 5 Risk Matrix Reference',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Risk Score = Likelihood × Severity',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              _matrixHeader(),
              for (int severity = 1;
                  severity <= 5;
                  severity++)
                _matrixRow(severity),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: levels.map((level) {
            final color = _matrixColor(level);

            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                level,
                style: TextStyle(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _matrixHeader() {
    return Row(
      children: [
        _matrixCell(
          'S/L',
          isHeader: true,
        ),
        for (int likelihood = 1;
            likelihood <= 5;
            likelihood++)
          _matrixCell(
            likelihood.toString(),
            isHeader: true,
          ),
      ],
    );
  }

  Widget _matrixRow(int severity) {
    return Row(
      children: [
        _matrixCell(
          severity.toString(),
          isHeader: true,
        ),
        for (int likelihood = 1;
            likelihood <= 5;
            likelihood++)
          _matrixRiskCell(
            likelihood * severity,
          ),
      ],
    );
  }

  Widget _matrixCell(
    String text, {
    bool isHeader = false,
  }) {
    return Expanded(
      child: Container(
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isHeader
              ? const Color(0xFFE9F3EF)
              : Colors.white,
          border: Border.all(
            color: Colors.grey.shade300,
            width: 0.5,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isHeader
                ? FontWeight.bold
                : FontWeight.normal,
            color: isHeader
                ? darkGreen
                : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _matrixRiskCell(int score) {
    final level = _riskLevelFromScore(score);
    final color = _matrixColor(level);

    return Expanded(
      child: Container(
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 0.5,
          ),
        ),
        child: Text(
          score.toString(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }

  Color _matrixColor(String level) {
    switch (level) {
      case 'Low':
        return primaryGreen;
      case 'Medium':
        return Colors.orange;
      case 'High':
        return Colors.deepOrange;
      case 'Critical':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
