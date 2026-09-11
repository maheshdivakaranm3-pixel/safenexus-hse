import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiskClosureLessonsLearnedPage extends StatefulWidget {
  const RiskClosureLessonsLearnedPage({
    super.key,
  });

  @override
  State<RiskClosureLessonsLearnedPage> createState() =>
      _RiskClosureLessonsLearnedPageState();
}

class _RiskClosureLessonsLearnedPageState
    extends State<RiskClosureLessonsLearnedPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const String storageKey =
      'safenexus_hse_risk_closure_lessons_learned';

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _records = [];

  String _statusFilter = 'All';
  String _residualRiskFilter = 'All';

  static const List<String> residualRiskLevels = [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static const List<String> statuses = [
    'Draft',
    'Closure Review',
    'Verification Required',
    'Action Pending',
    'HSE Verified',
    'Pending Approval',
    'Closed',
    'Reopened',
    'Cancelled',
  ];

  static const List<String> effectivenessOptions = [
    'Not Assessed',
    'Effective',
    'Partially Effective',
    'Ineffective',
  ];

  static const List<String> knowledgeUpdateOptions = [
    'Not Required',
    'Training Update Required',
    'Procedure Update Required',
    'Risk Assessment Update Required',
    'TBT / Awareness Update Required',
    'Multiple Updates Required',
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
      final riskLevel =
          record['residualRiskLevel']?.toString() ?? '';

      final matchesStatus =
          _statusFilter == 'All' || status == _statusFilter;

      final matchesRisk =
          _residualRiskFilter == 'All' ||
          riskLevel == _residualRiskFilter;

      if (!matchesStatus || !matchesRisk) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      final searchable = [
        record['closureNo'],
        record['riskReference'],
        record['project'],
        record['location'],
        record['department'],
        record['activity'],
        record['hazard'],
        record['risk'],
        record['closureCriteria'],
        record['closedBy'],
        record['hseVerifier'],
        record['managementApprover'],
        record['lessonsLearned'],
        record['rootCause'],
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
      final closureDate = _parseDate(
        record['targetClosureDate'],
      );

      if (closureDate == null) {
        return false;
      }

      final status = record['status']?.toString() ?? '';

      return closureDate.isBefore(todayOnly) &&
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
      case 'Closed':
      case 'HSE Verified':
        return primaryGreen;

      case 'Pending Approval':
      case 'Closure Review':
      case 'Verification Required':
        return Colors.orange;

      case 'Action Pending':
        return Colors.deepOrange;

      case 'Reopened':
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
      builder: (_) => const _RiskClosureFormSheet(),
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
      builder: (_) => _RiskClosureFormSheet(
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
    final targetId = record['id'];

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Record'),
          content: Text(
            'Delete ${record['closureNo'] ?? 'this record'}?',
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

    final targetIndex = _records.indexWhere(
      (record) => record['id'] == targetId,
    );

    if (targetIndex < 0) {
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
                  'This register stores record creation '
                  'and last-update timestamps.',
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
          'Risk Closure & Lessons Learned',
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
        label: const Text('Add Closure'),
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
            '3K • Risk Closure & Lessons Learned',
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
            'Verify controls, complete closure approval, '
            'capture lessons learned and record preventive actions.',
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
              'Pending',
              (
                _countStatus('Closure Review') +
                    _countStatus('Verification Required') +
                    _countStatus('Action Pending') +
                    _countStatus('Pending Approval')
              ).toString(),
              Icons.pending_actions,
              Colors.orange,
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
              _overdueCount.toString(),
              Icons.schedule,
              Colors.deepOrange,
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
                  'Search no., project, risk, closure, lessons...',
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
                  value: _residualRiskFilter,
                  items: [
                    'All',
                    ...residualRiskLevels,
                  ],
                  label: 'Residual Risk',
                  onChanged: (value) {
                    setState(() {
                      _residualRiskFilter =
                          value ?? 'All';
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
              Icons.verified_outlined,
              size: 70,
              color: primaryGreen.withValues(alpha: 0.35),
            ),
            const SizedBox(height: 16),
            const Text(
              'No Risk Closure Records',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add a risk closure record to document '
              'verification, approval and lessons learned.',
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
    final status =
        record['status']?.toString() ?? 'Draft';

    final residualLevel =
        record['residualRiskLevel']?.toString() ??
            'Not Assessed';

    final targetClosureDate =
        _parseDate(record['targetClosureDate']);

    final today = DateTime.now();

    final todayOnly = DateTime(
      today.year,
      today.month,
      today.day,
    );

    final overdue =
        targetClosureDate != null &&
            targetClosureDate.isBefore(todayOnly) &&
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
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      record['closureNo']?.toString() ??
                          'Risk Closure',
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
                      record['riskReference']?.toString() ??
                          '-',
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
                      'Closure Date',
                      _formatDate(
                        record['targetClosureDate'],
                      ),
                      valueColor:
                          overdue ? Colors.red : null,
                    ),
                  ),
                  Expanded(
                    child: _infoItem(
                      'Effectiveness',
                      record['controlEffectiveness']
                              ?.toString() ??
                          '-',
                    ),
                  ),
                ],
              ),
              if (overdue) ...[
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
                      'OVERDUE CLOSURE',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
              if ((record['lessonsLearned']
                          ?.toString() ??
                      '')
                  .trim()
                  .isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.lightbulb_outline,
                      size: 18,
                      color: darkGreen,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'Lessons learned documented',
                        style: TextStyle(
                          color: darkGreen,
                          fontWeight:
                              FontWeight.w600,
                        ),
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
                    onPressed: () =>
                        _showHistory(record),
                    icon: const Icon(
                      Icons.history,
                      color: darkGreen,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Edit',
                    onPressed: () =>
                        _editRecord(index),
                    icon: const Icon(
                      Icons.edit_outlined,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Delete',
                    onPressed: () =>
                        _deleteRecord(index),
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () =>
                        _showDetails(record),
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
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
            height:
                MediaQuery.of(sheetContext).size.height *
                    0.88,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                18,
                4,
                18,
                30,
              ),
              children: [
                Text(
                  record['closureNo']?.toString() ??
                      'Risk Closure',
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
                  ],
                ),
                _detailSection(
                  'Risk Levels',
                  [
                    _detailRow(
                      'Initial Risk Level',
                      record['initialRiskLevel'],
                    ),
                    _detailRow(
                      'Residual Risk Level',
                      record['residualRiskLevel'],
                    ),
                    _detailRow(
                      'Residual Risk Score',
                      record['residualRiskScore'],
                    ),
                  ],
                ),
                _detailSection(
                  'Control Implementation',
                  [
                    _detailRow(
                      'Control / Action Implemented',
                      record['controlActionImplemented'],
                    ),
                    _detailRow(
                      'Effectiveness',
                      record['controlEffectiveness'],
                    ),
                    _detailRow(
                      'Verification Findings',
                      record['verificationFindings'],
                    ),
                    _detailRow(
                      'Closure Criteria',
                      record['closureCriteria'],
                    ),
                  ],
                ),
                _detailSection(
                  'Closure & Approval',
                  [
                    _detailRow(
                      'Target Closure Date',
                      _formatDate(
                        record['targetClosureDate'],
                      ),
                    ),
                    _detailRow(
                      'Closure Date',
                      _formatDate(
                        record['closureDate'],
                      ),
                    ),
                    _detailRow(
                      'Closed By',
                      record['closedBy'],
                    ),
                    _detailRow(
                      'HSE Verification',
                      record['hseVerifier'],
                    ),
                    _detailRow(
                      'Management Approver',
                      record['managementApprover'],
                    ),
                    _detailRow(
                      'Approval Date',
                      _formatDate(
                        record['approvalDate'],
                      ),
                    ),
                    _detailRow(
                      'Status',
                      record['status'],
                    ),
                  ],
                ),
                _detailSection(
                  'Lessons Learned',
                  [
                    _detailRow(
                      'Lessons Learned',
                      record['lessonsLearned'],
                    ),
                    _detailRow(
                      'Root Cause / Key Learning',
                      record['rootCause'],
                    ),
                    _detailRow(
                      'Preventive Actions',
                      record['preventiveActions'],
                    ),
                    _detailRow(
                      'Knowledge / Training Update',
                      record['knowledgeUpdateRequired'],
                    ),
                    _detailRow(
                      'Related Reference',
                      record['relatedReference'],
                    ),
                  ],
                ),
                _detailSection(
                  'Remarks',
                  [
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 155,
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

class _RiskClosureFormSheet extends StatefulWidget {
  final Map<String, dynamic>? initialData;

  const _RiskClosureFormSheet({
    this.initialData,
  });

  @override
  State<_RiskClosureFormSheet> createState() =>
      _RiskClosureFormSheetState();
}

class _RiskClosureFormSheetState
    extends State<_RiskClosureFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  static const List<String> effectivenessOptions = [
    'Not Assessed',
    'Effective',
    'Partially Effective',
    'Ineffective',
  ];

  static const List<String> knowledgeUpdateOptions = [
    'Not Required',
    'Training Update Required',
    'Procedure Update Required',
    'Risk Assessment Update Required',
    'TBT / Awareness Update Required',
    'Multiple Updates Required',
  ];

  final _formKey = GlobalKey<FormState>();

  final _closureNoController = TextEditingController();
  final _projectController = TextEditingController();
  final _locationController = TextEditingController();
  final _departmentController = TextEditingController();
  final _activityController = TextEditingController();
  final _hazardController = TextEditingController();
  final _riskController = TextEditingController();

  final _controlActionController = TextEditingController();
  final _verificationFindingsController = TextEditingController();
  final _closureCriteriaController = TextEditingController();

  final _closedByController = TextEditingController();
  final _hseVerifierController = TextEditingController();
  final _managementApproverController =
      TextEditingController();

  final _lessonsLearnedController = TextEditingController();
  final _rootCauseController = TextEditingController();
  final _preventiveActionsController =
      TextEditingController();
  final _relatedReferenceController =
      TextEditingController();
  final _remarksController = TextEditingController();

  String _riskReference = 'HIRA';

  String _initialRiskLevel = 'Low';

  int _residualRiskScore = 1;

  String _controlEffectiveness = 'Not Assessed';

  String _knowledgeUpdateRequired =
      'Not Required';

  String _status = 'Draft';

  DateTime? _targetClosureDate;
  DateTime? _closureDate;
  DateTime? _approvalDate;

  bool get _isEditing =>
      widget.initialData != null;

  @override
  void initState() {
    super.initState();

    final data = widget.initialData;

    if (data == null) {
      _closureNoController.text =
          'RC-${DateTime.now().millisecondsSinceEpoch}';
      return;
    }

    _loadData(data);
  }

  void _loadData(
    Map<String, dynamic> data,
  ) {
    _closureNoController.text =
        data['closureNo']?.toString() ?? '';

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

    _controlActionController.text =
        data['controlActionImplemented']?.toString() ?? '';

    _verificationFindingsController.text =
        data['verificationFindings']?.toString() ?? '';

    _closureCriteriaController.text =
        data['closureCriteria']?.toString() ?? '';

    _closedByController.text =
        data['closedBy']?.toString() ?? '';

    _hseVerifierController.text =
        data['hseVerifier']?.toString() ?? '';

    _managementApproverController.text =
        data['managementApprover']?.toString() ?? '';

    _lessonsLearnedController.text =
        data['lessonsLearned']?.toString() ?? '';

    _rootCauseController.text =
        data['rootCause']?.toString() ?? '';

    _preventiveActionsController.text =
        data['preventiveActions']?.toString() ?? '';

    _relatedReferenceController.text =
        data['relatedReference']?.toString() ?? '';

    _remarksController.text =
        data['remarks']?.toString() ?? '';

    _riskReference =
        data['riskReference']?.toString() ?? 'HIRA';

    _initialRiskLevel =
        data['initialRiskLevel']?.toString() ?? 'Low';
    _residualRiskScore =
        _safeScore(data['residualRiskScore']);

    _controlEffectiveness =
        data['controlEffectiveness']?.toString() ??
            'Not Assessed';

    _knowledgeUpdateRequired =
        data['knowledgeUpdateRequired']?.toString() ??
            'Not Required';

    _status =
        data['status']?.toString() ?? 'Draft';

    _targetClosureDate =
        _parseDate(data['targetClosureDate']);

    _closureDate =
        _parseDate(data['closureDate']);

    _approvalDate =
        _parseDate(data['approvalDate']);
  }

  int _safeScore(dynamic value) {
    final parsed =
        int.tryParse(value?.toString() ?? '');

    if (parsed == null || parsed < 1) {
      return 1;
    }

    if (parsed > 25) {
      return 25;
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
    _closureNoController.dispose();
    _projectController.dispose();
    _locationController.dispose();
    _departmentController.dispose();
    _activityController.dispose();
    _hazardController.dispose();
    _riskController.dispose();
    _controlActionController.dispose();
    _verificationFindingsController.dispose();
    _closureCriteriaController.dispose();
    _closedByController.dispose();
    _hseVerifierController.dispose();
    _managementApproverController.dispose();
    _lessonsLearnedController.dispose();
    _rootCauseController.dispose();
    _preventiveActionsController.dispose();
    _relatedReferenceController.dispose();
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
    if (_controlActionController.text.trim().isEmpty &&
        (_status == 'Verification Required' ||
            _status == 'HSE Verified' ||
            _status == 'Pending Approval' ||
            _status == 'Closed')) {
      _showError(
        'Control / Action Implemented is required before closure.',
      );
      return false;
    }

    if (_status == 'HSE Verified' &&
        _hseVerifierController.text.trim().isEmpty) {
      _showError(
        'HSE Verifier is required.',
      );
      return false;
    }

    if (_status == 'Pending Approval' &&
        _managementApproverController.text.trim().isEmpty) {
      _showError(
        'Management Approver is required.',
      );
      return false;
    }

    if (_status == 'Pending Approval' &&
        _approvalDate == null) {
      _showError(
        'Approval Date is required.',
      );
      return false;
    }

    if (_status == 'Closed') {
      if (_closedByController.text.trim().isEmpty) {
        _showError(
          'Closed By is required.',
        );
        return false;
      }

      if (_hseVerifierController.text.trim().isEmpty) {
        _showError(
          'HSE Verification is required before closure.',
        );
        return false;
      }

      if (_managementApproverController.text.trim().isEmpty) {
        _showError(
          'Management Approval is required before closure.',
        );
        return false;
      }

      if (_closureDate == null) {
        _showError(
          'Closure Date is required.',
        );
        return false;
      }
    }

    if (_lessonsLearnedController.text.trim().isEmpty &&
        _status == 'Closed') {
      _showError(
        'Lessons Learned must be documented before closure.',
      );
      return false;
    }

    if (_targetClosureDate != null &&
        _closureDate != null &&
        _closureDate!.isBefore(_targetClosureDate!)) {
      _showError(
        'Closure Date cannot be before Target Closure Date.',
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
      'closureNo':
          _closureNoController.text.trim(),

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

      'initialRiskLevel':
          _initialRiskLevel,

      'residualRiskLevel':
          _riskLevelFromScore(
            _residualRiskScore,
          ),

      'residualRiskScore':
          _residualRiskScore,

      'controlActionImplemented':
          _controlActionController.text.trim(),

      'controlEffectiveness':
          _controlEffectiveness,

      'verificationFindings':
          _verificationFindingsController.text.trim(),

      'closureCriteria':
          _closureCriteriaController.text.trim(),

      'targetClosureDate':
          _targetClosureDate?.toIso8601String(),

      'closureDate':
          _closureDate?.toIso8601String(),

      'closedBy':
          _closedByController.text.trim(),

      'hseVerifier':
          _hseVerifierController.text.trim(),

      'managementApprover':
          _managementApproverController.text.trim(),

      'approvalDate':
          _approvalDate?.toIso8601String(),

      'lessonsLearned':
          _lessonsLearnedController.text.trim(),

      'rootCause':
          _rootCauseController.text.trim(),

      'preventiveActions':
          _preventiveActionsController.text.trim(),

      'knowledgeUpdateRequired':
          _knowledgeUpdateRequired,

      'relatedReference':
          _relatedReferenceController.text.trim(),

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
        height:
            MediaQuery.of(context).size.height * 0.94,
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
                      '1. Risk Closure Identification',
                    ),
                    _textField(
                      controller:
                          _closureNoController,
                      label:
                          'Risk Closure No.',
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
                        'Risk Monitoring',
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

                    _sectionTitle(
                      '3. Risk Level',
                    ),
                    _dropdownField(
                      label:
                          'Initial Risk Level',
                      value:
                          _initialRiskLevel,
                      items: const [
                        'Low',
                        'Medium',
                        'High',
                        'Critical',
                      ],
                      onChanged: (value) {
                        setState(() {
                          _initialRiskLevel =
                              value ?? 'Low';
                        });
                      },
                    ),
                    _riskScoreSelector(),

                    _sectionTitle(
                      '4. Control Implementation & Verification',
                    ),
                    _textField(
                      controller:
                          _controlActionController,
                      label:
                          'Control / Action Implemented',
                      required: true,
                      maxLines: 6,
                    ),
                    _dropdownField(
                      label:
                          'Control Effectiveness',
                      value:
                          _controlEffectiveness,
                      items:
                          effectivenessOptions,
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
                          _verificationFindingsController,
                      label:
                          'Verification Findings',
                      maxLines: 6,
                    ),
                    _textField(
                      controller:
                          _closureCriteriaController,
                      label:
                          'Closure Criteria',
                      maxLines: 5,
                    ),

                    _sectionTitle(
                      '5. Closure & Approval',
                    ),
                    _dateField(
                      label:
                          'Target Closure Date',
                      value:
                          _targetClosureDate,
                      onTap: () =>
                          _pickDate(
                        current:
                            _targetClosureDate,
                        onSelected: (date) {
                          setState(() {
                            _targetClosureDate =
                                date;
                          });
                        },
                      ),
                    ),
                    _dateField(
                      label:
                          'Closure Date',
                      value:
                          _closureDate,
                      onTap: () =>
                          _pickDate(
                        current:
                            _closureDate,
                        onSelected: (date) {
                          setState(() {
                            _closureDate =
                                date;
                          });
                        },
                      ),
                    ),
                    _textField(
                      controller:
                          _closedByController,
                      label:
                          'Closed By',
                    ),
                    _textField(
                      controller:
                          _hseVerifierController,
                      label:
                          'HSE Verification',
                    ),
                    _textField(
                      controller:
                          _managementApproverController,
                      label:
                          'Management Approver',
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

                    _sectionTitle(
                      '6. Lessons Learned',
                    ),
                    _textField(
                      controller:
                          _lessonsLearnedController,
                      label:
                          'Lessons Learned',
                      maxLines: 7,
                    ),
                    _textField(
                      controller:
                          _rootCauseController,
                      label:
                          'Root Cause / Key Learning',
                      maxLines: 6,
                    ),
                    _textField(
                      controller:
                          _preventiveActionsController,
                      label:
                          'Recommended Preventive Actions',
                      maxLines: 6,
                    ),
                    _dropdownField(
                      label:
                          'Knowledge / Training Update',
                      value:
                          _knowledgeUpdateRequired,
                      items:
                          knowledgeUpdateOptions,
                      onChanged: (value) {
                        setState(() {
                          _knowledgeUpdateRequired =
                              value ??
                                  'Not Required';
                        });
                      },
                    ),
                    _textField(
                      controller:
                          _relatedReferenceController,
                      label:
                          'Related Document / Reference',
                    ),

                    _sectionTitle(
                      '7. Closure Status',
                    ),
                    _dropdownField(
                      label: 'Status',
                      value:
                          _status,
                      items: const [
                        'Draft',
                        'Closure Review',
                        'Verification Required',
                        'Action Pending',
                        'HSE Verified',
                        'Pending Approval',
                        'Closed',
                        'Reopened',
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
                      style:
                          FilledButton.styleFrom(
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
                            ? 'Update Risk Closure'
                            : 'Save Risk Closure',
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
              '3K • Risk Closure & Lessons Learned',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: () =>
                Navigator.pop(context),
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

  Widget _riskScoreSelector() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<int>(
        initialValue: _residualRiskScore,
        decoration: InputDecoration(
          labelText: 'Residual Risk Score',
          filled: true,
          fillColor: const Color(0xFFF8FAF9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        items: List.generate(
          25,
          (index) {
            final score = index + 1;
            final level =
                _riskLevelFromScore(score);

            return DropdownMenuItem<int>(
              value: score,
              child: Text(
                '$score • $level',
              ),
            );
          },
        ),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _residualRiskScore = value;
            });
          }
        },
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
      crossAxisAlignment:
          CrossAxisAlignment.start,
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
            borderRadius:
                BorderRadius.circular(10),
          ),
          clipBehavior:
              Clip.antiAlias,
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
            final color =
                _matrixColor(level);

            return Container(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 5,
              ),
              decoration:
                  BoxDecoration(
                color:
                    color.withValues(
                  alpha: 0.12,
                ),
                borderRadius:
                    BorderRadius.circular(
                  8,
                ),
              ),
              child: Text(
                level,
                style: TextStyle(
                  fontSize: 11,
                  color: color,
                  fontWeight:
                      FontWeight.bold,
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
    final level =
        _riskLevelFromScore(score);

    final color =
        _matrixColor(level);

    return Expanded(
      child: Container(
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:
              color.withValues(
            alpha: 0.12,
          ),
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
