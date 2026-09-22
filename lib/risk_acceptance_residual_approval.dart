import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiskAcceptanceResidualApprovalPage extends StatefulWidget {
  const RiskAcceptanceResidualApprovalPage({
    super.key,
  });

  @override
  State<RiskAcceptanceResidualApprovalPage> createState() =>
      _RiskAcceptanceResidualApprovalPageState();
}

class _RiskAcceptanceResidualApprovalPageState
    extends State<RiskAcceptanceResidualApprovalPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const String storageKey =
      'safenexus_hse_risk_acceptance_residual_approval';

  final TextEditingController _searchController =
      TextEditingController();

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
    'Pending Acceptance',
    'Under HSE Review',
    'Pending Approval',
    'Accepted',
    'Accepted with Conditions',
    'Rejected',
    'Under Monitoring',
    'Closed',
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
      final status =
          record['status']?.toString() ?? '';

      final residualRiskLevel =
          record['residualRiskLevel']?.toString() ?? '';

      final matchesStatus =
          _statusFilter == 'All' ||
          status == _statusFilter;

      final matchesRisk =
          _riskFilter == 'All' ||
          residualRiskLevel == _riskFilter;

      if (!matchesStatus || !matchesRisk) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      final searchable = [
        record['acceptanceNo'],
        record['riskReference'],
        record['project'],
        record['location'],
        record['department'],
        record['activity'],
        record['hazard'],
        record['risk'],
        record['riskOwner'],
        record['hseReviewer'],
        record['managementApprover'],
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
          (record) =>
              record['residualRiskLevel'] == level,
        )
        .length;
  }

  int get _overdueCount {
    final today = DateTime.now();

    return _records.where((record) {
      final reviewDate =
          _parseDate(record['reviewDate']);

      if (reviewDate == null) {
        return false;
      }

      final status =
          record['status']?.toString() ?? '';

      final todayOnly = DateTime(
        today.year,
        today.month,
        today.day,
      );

      return reviewDate.isBefore(todayOnly) &&
          status != 'Closed' &&
          status != 'Rejected';
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
      case 'Accepted':
      case 'Closed':
      case 'Under Monitoring':
        return primaryGreen;

      case 'Accepted with Conditions':
      case 'Pending Approval':
      case 'Under HSE Review':
        return Colors.orange;

      case 'Rejected':
        return Colors.red;

      case 'Pending Acceptance':
      case 'Draft':
        return Colors.blueGrey;

      default:
        return Colors.grey;
    }
  }

  Future<void> _addRecord() async {
    final result =
        await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          const _RiskAcceptanceFormSheet(),
    );

    if (result == null) {
      return;
    }

    final now =
        DateTime.now().toIso8601String();

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
      (record) =>
          record['id'] == existing['id'],
    );

    if (actualIndex < 0) {
      return;
    }

    final result =
        await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          _RiskAcceptanceFormSheet(
        initialData:
            Map<String, dynamic>.from(existing),
      ),
    );

    if (result == null) {
      return;
    }

    result['id'] = existing['id'];
    result['createdAt'] =
        existing['createdAt'];
    result['updatedAt'] =
        DateTime.now().toIso8601String();

    setState(() {
      _records[actualIndex] = result;
    });

    await _saveRecords();
  }

  Future<void> _deleteRecord(int index) async {
    final record = _filteredRecords[index];

    final confirmed =
        await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Delete Record',
          ),
          content: Text(
            'Delete ${record['acceptanceNo'] ?? 'this record'}?',
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(
                dialogContext,
                false,
              ),
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () =>
                  Navigator.pop(
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

    final actualIndex =
        _records.indexWhere(
      (item) =>
          item['id'] == record['id'],
    );

    if (actualIndex < 0) {
      return;
    }

    setState(() {
      _records.removeAt(actualIndex);
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
                  style: Theme.of(
                    sheetContext,
                  ).textTheme.titleLarge?.copyWith(
                        fontWeight:
                            FontWeight.bold,
                        color: darkGreen,
                      ),
                ),
                const SizedBox(height: 16),
                _historyRow(
                  'Created',
                  _formatDateTime(
                    record['createdAt'],
                  ),
                ),
                _historyRow(
                  'Last Updated',
                  _formatDateTime(
                    record['updatedAt'],
                  ),
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
      padding:
          const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight:
                    FontWeight.w600,
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
          'Risk Acceptance & Approval',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton:
          FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: _addRecord,
        icon: const Icon(Icons.add),
        label: const Text(
          'Add Risk Acceptance',
        ),
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
                    padding:
                        const EdgeInsets.fromLTRB(
                      12,
                      4,
                      12,
                      100,
                    ),
                    itemCount:
                        records.length,
                    itemBuilder:
                        (context, index) {
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
      padding:
          const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        14,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            '3I • Risk Acceptance & Residual Risk Approval',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(
                  color: darkGreen,
                  fontWeight:
                      FontWeight.bold,
                ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Evaluate residual risk, document acceptance '
            'conditions, complete HSE review and obtain '
            'management approval.',
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard() {
    return Container(
      padding:
          const EdgeInsets.fromLTRB(
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
          const SizedBox(width: 8),
          Expanded(
            child: _summaryCard(
              'Pending',
              (
                _countStatus(
                      'Pending Acceptance',
                    ) +
                    _countStatus(
                      'Under HSE Review',
                    ) +
                    _countStatus(
                      'Pending Approval',
                    )
              ).toString(),
              Icons.pending_actions,
              Colors.orange,
            ),
          ),
          const SizedBox(width: 8),
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
          const SizedBox(width: 8),
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
        padding:
            const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 10,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 22,
              color: color,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 19,
                fontWeight:
                    FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(
        12,
        4,
        12,
        8,
      ),
      child: Column(
        children: [
          TextField(
            controller:
                _searchController,
            decoration:
                InputDecoration(
              hintText:
                  'Search no., project, activity, hazard, owner...',
              prefixIcon:
                  const Icon(Icons.search),
              suffixIcon:
                  _searchController
                          .text
                          .isEmpty
                      ? null
                      : IconButton(
                          onPressed:
                              _searchController
                                  .clear,
                          icon: const Icon(
                            Icons.clear,
                          ),
                        ),
              filled: true,
              fillColor:
                  Colors.white,
              border:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(
                  12,
                ),
                borderSide:
                    BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child:
                    _filterDropdown(
                  value:
                      _statusFilter,
                  items: [
                    'All',
                    ...statuses,
                  ],
                  label: 'Status',
                  onChanged:
                      (value) {
                    setState(() {
                      _statusFilter =
                          value ?? 'All';
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child:
                    _filterDropdown(
                  value:
                      _riskFilter,
                  items: [
                    'All',
                    ...riskLevels,
                  ],
                  label:
                      'Residual Risk',
                  onChanged:
                      (value) {
                    setState(() {
                      _riskFilter =
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
    required ValueChanged<String?>
        onChanged,
  }) {
    return DropdownButtonFormField<
        String>(
      initialValue: value,
      decoration:
          InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            12,
          ),
          borderSide:
              BorderSide.none,
        ),
      ),
      items: items
          .map(
            (item) =>
                DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                overflow:
                    TextOverflow.ellipsis,
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
        padding:
            const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons
                  .verified_user_outlined,
              size: 70,
              color: primaryGreen
                  .withValues(
                alpha: 0.35,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No Risk Acceptance Records',
              style: TextStyle(
                fontSize: 19,
                fontWeight:
                    FontWeight.bold,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add a risk acceptance record to document '
              'residual risk approval and monitoring conditions.',
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
        record['status']?.toString() ??
            'Draft';

    final residualLevel =
        record['residualRiskLevel']
                ?.toString() ??
            'Not Assessed';

    final reviewDate =
        _parseDate(
      record['reviewDate'],
    );

    final today = DateTime.now();

    final overdue =
        reviewDate != null &&
        reviewDate.isBefore(
          DateTime(
            today.year,
            today.month,
            today.day,
          ),
        ) &&
        status != 'Closed' &&
        status != 'Rejected';

    final riskColor =
        _riskColor(residualLevel);

    final statusColor =
        _statusColor(status);

    return Card(
      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),
      elevation: 1,
      child: InkWell(
        borderRadius:
            BorderRadius.circular(
          12,
        ),
        onTap: () =>
            _showDetails(record),
        child: Padding(
          padding:
              const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      record['acceptanceNo']
                              ?.toString() ??
                          'Risk Acceptance',
                      style:
                          const TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.bold,
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
                record['project']
                        ?.toString() ??
                    '-',
                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
              if ((record['activity']
                          ?.toString() ??
                      '')
                  .isNotEmpty)
                Padding(
                  padding:
                      const EdgeInsets.only(
                    top: 3,
                  ),
                  child: Text(
                    record['activity']
                        .toString(),
                  ),
                ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _infoItem(
                      'Risk Ref.',
                      record['riskReference']
                              ?.toString() ??
                          '-',
                    ),
                  ),
                  Expanded(
                    child: _infoItem(
                      'Residual Risk',
                      residualLevel,
                      valueColor:
                          riskColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _infoItem(
                      'Owner',
                      record['riskOwner']
                              ?.toString() ??
                          '-',
                    ),
                  ),
                  Expanded(
                    child: _infoItem(
                      'Review',
                      _formatDate(
                        record[
                            'reviewDate'],
                      ),
                      valueColor:
                          overdue
                              ? Colors.red
                              : null,
                    ),
                  ),
                ],
              ),
              if (overdue) ...[
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(
                      Icons
                          .warning_amber_rounded,
                      size: 18,
                      color: Colors.red,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'OVERDUE REVIEW',
                      style:
                          TextStyle(
                        color:
                            Colors.red,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
              const Divider(
                height: 18,
              ),
              Row(
                children: [
                  IconButton(
                    tooltip:
                        'History',
                    onPressed: () =>
                        _showHistory(
                      record,
                    ),
                    icon:
                        const Icon(
                      Icons.history,
                      color:
                          darkGreen,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Edit',
                    onPressed: () =>
                        _editRecord(
                      index,
                    ),
                    icon:
                        const Icon(
                      Icons
                          .edit_outlined,
                    ),
                  ),
                  IconButton(
                    tooltip:
                        'Delete',
                    onPressed: () =>
                        _deleteRecord(
                      index,
                    ),
                    icon:
                        const Icon(
                      Icons
                          .delete_outline,
                      color:
                          Colors.red,
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () =>
                        _showDetails(
                      record,
                    ),
                    icon:
                        const Icon(
                      Icons
                          .visibility_outlined,
                    ),
                    label:
                        const Text(
                      'View',
                    ),
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
      padding:
          const EdgeInsets.only(
        right: 8,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 2,
            overflow:
                TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight:
                  FontWeight.w600,
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
      padding:
          const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration:
          BoxDecoration(
        color: color.withValues(
          alpha: 0.12,
        ),
        borderRadius:
            BorderRadius.circular(
          20,
        ),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11,
          fontWeight:
              FontWeight.bold,
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
      backgroundColor:
          Colors.white,
      builder: (sheetContext) {
        return SafeArea(
          child:
              DraggableScrollableSheet(
            expand: false,
            initialChildSize:
                0.88,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (
              context,
              controller,
            ) {
              return ListView(
                controller:
                    controller,
                padding:
                    const EdgeInsets
                        .fromLTRB(
                  18,
                  4,
                  18,
                  30,
                ),
                children: [
                  Text(
                    record[
                                'acceptanceNo']
                            ?.toString() ??
                        'Risk Acceptance',
                    style:
                        const TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    record['project']
                            ?.toString() ??
                        '-',
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _detailSection(
                    'Risk Identification',
                    [
                      _detailRow(
                        'Risk Reference',
                        record[
                            'riskReference'],
                      ),
                      _detailRow(
                        'Location',
                        record[
                            'location'],
                      ),
                      _detailRow(
                        'Department',
                        record[
                            'department'],
                      ),
                      _detailRow(
                        'Activity / Work',
                        record[
                            'activity'],
                      ),
                      _detailRow(
                        'Hazard',
                        record[
                            'hazard'],
                      ),
                      _detailRow(
                        'Risk',
                        record['risk'],
                      ),
                      _detailRow(
                        'Consequence',
                        record[
                            'consequence'],
                      ),
                    ],
                  ),
                  _detailSection(
                    'Initial Risk',
                    [
                      _detailRow(
                        'Likelihood',
                        record[
                            'initialLikelihood'],
                      ),
                      _detailRow(
                        'Severity',
                        record[
                            'initialSeverity'],
                      ),
                      _detailRow(
                        'Score',
                        record[
                            'initialRiskScore'],
                      ),
                      _detailRow(
                        'Level',
                        record[
                            'initialRiskLevel'],
                      ),
                    ],
                  ),
                  _detailSection(
                    'Residual Risk',
                    [
                      _detailRow(
                        'Likelihood',
                        record[
                            'residualLikelihood'],
                      ),
                      _detailRow(
                        'Severity',
                        record[
                            'residualSeverity'],
                      ),
                      _detailRow(
                        'Score',
                        record[
                            'residualRiskScore'],
                      ),
                      _detailRow(
                        'Level',
                        record[
                            'residualRiskLevel'],
                      ),
                      _detailRow(
                        'Acceptance Justification',
                        record[
                            'acceptanceJustification'],
                      ),
                      _detailRow(
                        'Additional Controls',
                        record[
                            'additionalControls'],
                      ),
                      _detailRow(
                        'Acceptance Conditions',
                        record[
                            'acceptanceConditions'],
                      ),
                    ],
                  ),
                  _detailSection(
                    'Review & Approval',
                    [
                      _detailRow(
                        'Risk Owner',
                        record[
                            'riskOwner'],
                      ),
                      _detailRow(
                        'HSE Reviewer',
                        record[
                            'hseReviewer'],
                      ),
                      _detailRow(
                        'Management Approver',
                        record[
                            'managementApprover'],
                      ),
                      _detailRow(
                        'Acceptance Date',
                        _formatDate(
                          record[
                              'acceptanceDate'],
                        ),
                      ),
                      _detailRow(
                        'Approval Date',
                        _formatDate(
                          record[
                              'approvalDate'],
                        ),
                      ),
                      _detailRow(
                        'Status',
                        record['status'],
                      ),
                      _detailRow(
                        'Rejection Reason',
                        record[
                            'rejectionReason'],
                      ),
                    ],
                  ),
                  _detailSection(
                    'Monitoring',
                    [
                      _detailRow(
                        'Monitoring Requirements',
                        record[
                            'monitoringRequirements'],
                      ),
                      _detailRow(
                        'Review Date',
                        _formatDate(
                          record[
                              'reviewDate'],
                        ),
                      ),
                      _detailRow(
                        'Remarks',
                        record['remarks'],
                      ),
                    ],
                  ),
                ],
              );
            },
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
      padding:
          const EdgeInsets.only(
        bottom: 18,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                const TextStyle(
              fontSize: 16,
              fontWeight:
                  FontWeight.bold,
              color: darkGreen,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Card(
            elevation: 0,
            color:
                pageBackground,
            child: Padding(
              padding:
                  const EdgeInsets.all(
                12,
              ),
              child: Column(
                children:
                    children,
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
    final text =
        value?.toString() ?? '-';

    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 9,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 145,
            child: Text(
              title,
              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text.isEmpty
                  ? '-'
                  : text,
              style:
                  const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RiskAcceptanceFormSheet
    extends StatefulWidget {
  final Map<String, dynamic>?
      initialData;

  const _RiskAcceptanceFormSheet({
    this.initialData,
  });

  @override
  State<_RiskAcceptanceFormSheet>
      createState() =>
          _RiskAcceptanceFormSheetState();
}

class _RiskAcceptanceFormSheetState
    extends State<
        _RiskAcceptanceFormSheet> {
  static const Color primaryGreen =
      Color(0xFF159447);

  static const Color darkGreen =
      Color(0xFF0B5D4B);

  final _formKey =
      GlobalKey<FormState>();

  final _acceptanceNoController =
      TextEditingController();

  final _projectController =
      TextEditingController();

  final _locationController =
      TextEditingController();

  final _departmentController =
      TextEditingController();

  final _activityController =
      TextEditingController();

  final _hazardController =
      TextEditingController();

  final _riskController =
      TextEditingController();

  final _consequenceController =
      TextEditingController();

  final _additionalControlsController =
      TextEditingController();

  final _acceptanceJustificationController =
      TextEditingController();

  final _acceptanceConditionsController =
      TextEditingController();

  final _riskOwnerController =
      TextEditingController();

  final _hseReviewerController =
      TextEditingController();

  final _managementApproverController =
      TextEditingController();

  final _monitoringRequirementsController =
      TextEditingController();

  final _rejectionReasonController =
      TextEditingController();

  final _remarksController =
      TextEditingController();

  String _riskReference = 'HIRA';

  int _initialLikelihood = 1;
  int _initialSeverity = 1;

  int _residualLikelihood = 1;
  int _residualSeverity = 1;

  String _status = 'Draft';

  DateTime? _acceptanceDate;
  DateTime? _approvalDate;
  DateTime? _reviewDate;

  bool get _isEditing =>
      widget.initialData != null;

  int get _initialScore =>
      _initialLikelihood *
      _initialSeverity;

  String get _initialLevel =>
      _riskLevelFromScore(
        _initialScore,
      );

  int get _residualScore =>
      _residualLikelihood *
      _residualSeverity;

  String get _residualLevel =>
      _riskLevelFromScore(
        _residualScore,
      );

  @override
  void initState() {
    super.initState();

    final data =
        widget.initialData;

    if (data == null) {
      _acceptanceNoController
          .text =
          'RA-${DateTime.now().millisecondsSinceEpoch}';
      return;
    }

    _loadData(data);
  }

  void _loadData(
    Map<String, dynamic> data,
  ) {
    _acceptanceNoController
            .text =
        data['acceptanceNo']
                ?.toString() ??
            '';

    _projectController.text =
        data['project']
                ?.toString() ??
            '';

    _locationController.text =
        data['location']
                ?.toString() ??
            '';

    _departmentController.text =
        data['department']
                ?.toString() ??
            '';

    _activityController.text =
        data['activity']
                ?.toString() ??
            '';

    _hazardController.text =
        data['hazard']
                ?.toString() ??
            '';

    _riskController.text =
        data['risk']
                ?.toString() ??
            '';

    _consequenceController.text =
        data['consequence']
                ?.toString() ??
            '';

    _additionalControlsController
            .text =
        data['additionalControls']
                ?.toString() ??
            '';

    _acceptanceJustificationController
            .text =
        data['acceptanceJustification']
                ?.toString() ??
            '';

    _acceptanceConditionsController
            .text =
        data['acceptanceConditions']
                ?.toString() ??
            '';

    _riskOwnerController.text =
        data['riskOwner']
                ?.toString() ??
            '';

    _hseReviewerController.text =
        data['hseReviewer']
                ?.toString() ??
            '';

    _managementApproverController
            .text =
        data['managementApprover']
                ?.toString() ??
            '';

    _monitoringRequirementsController
            .text =
        data['monitoringRequirements']
                ?.toString() ??
            '';

    _rejectionReasonController.text =
        data['rejectionReason']
                ?.toString() ??
            '';

    _remarksController.text =
        data['remarks']
                ?.toString() ??
            '';

    _riskReference =
        data['riskReference']
                ?.toString() ??
            'HIRA';

    _status =
        data['status']
                ?.toString() ??
            'Draft';

    _initialLikelihood =
        _safeRiskValue(
      data['initialLikelihood'],
    );

    _initialSeverity =
        _safeRiskValue(
      data['initialSeverity'],
    );

    _residualLikelihood =
        _safeRiskValue(
      data['residualLikelihood'],
    );

    _residualSeverity =
        _safeRiskValue(
      data['residualSeverity'],
    );

    _acceptanceDate =
        _parseDate(
      data['acceptanceDate'],
    );

    _approvalDate =
        _parseDate(
      data['approvalDate'],
    );

    _reviewDate =
        _parseDate(
      data['reviewDate'],
    );
  }

  int _safeRiskValue(
    dynamic value,
  ) {
    final parsed =
        int.tryParse(
      value?.toString() ?? '',
    );

    if (parsed == null ||
        parsed < 1) {
      return 1;
    }

    if (parsed > 5) {
      return 5;
    }

    return parsed;
  }

  DateTime? _parseDate(
    dynamic value,
  ) {
    if (value == null) {
      return null;
    }

    return DateTime.tryParse(
      value.toString(),
    );
  }

  String _riskLevelFromScore(
    int score,
  ) {
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
    _acceptanceNoController.dispose();
    _projectController.dispose();
    _locationController.dispose();
    _departmentController.dispose();
    _activityController.dispose();
    _hazardController.dispose();
    _riskController.dispose();
    _consequenceController.dispose();
    _additionalControlsController
        .dispose();
    _acceptanceJustificationController
        .dispose();
    _acceptanceConditionsController
        .dispose();
    _riskOwnerController.dispose();
    _hseReviewerController.dispose();
    _managementApproverController
        .dispose();
    _monitoringRequirementsController
        .dispose();
    _rejectionReasonController
        .dispose();
    _remarksController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({
    required DateTime? current,
    required ValueChanged<DateTime>
        onSelected,
  }) async {
    final picked =
        await showDatePicker(
      context: context,
      initialDate:
          current ?? DateTime.now(),
      firstDate:
          DateTime(2020),
      lastDate:
          DateTime(2100),
    );

    if (picked != null) {
      onSelected(picked);
    }
  }

  String _formatDate(
    DateTime? date,
  ) {
    if (date == null) {
      return 'Select date';
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  bool _validateBusinessRules() {
    if (_residualScore >
        _initialScore) {
      _showError(
        'Residual risk should not be higher than '
        'the initial risk unless the justification '
        'and additional controls are documented.',
      );

      if (_acceptanceJustificationController
          .text
          .trim()
          .isEmpty) {
        return false;
      }
    }

    if ((_status == 'Accepted' ||
            _status ==
                'Accepted with Conditions' ||
            _status ==
                'Under Monitoring') &&
        _riskOwnerController
            .text
            .trim()
            .isEmpty) {
      _showError(
        'Risk Owner is required for accepted '
        'or monitored risks.',
      );
      return false;
    }

    if ((_status == 'Accepted' ||
            _status ==
                'Accepted with Conditions') &&
        _hseReviewerController
            .text
            .trim()
            .isEmpty) {
      _showError(
        'HSE Reviewer is required before risk acceptance.',
      );
      return false;
    }

    if ((_status == 'Accepted' ||
            _status ==
                'Accepted with Conditions') &&
        _managementApproverController
            .text
            .trim()
            .isEmpty) {
      _showError(
        'Management Approver is required before approval.',
      );
      return false;
    }

    if (_status ==
            'Accepted with Conditions' &&
        _acceptanceConditionsController
            .text
            .trim()
            .isEmpty) {
      _showError(
        'Acceptance Conditions are required.',
      );
      return false;
    }

    if (_status == 'Rejected' &&
        _rejectionReasonController
            .text
            .trim()
            .isEmpty) {
      _showError(
        'Rejection Reason is required.',
      );
      return false;
    }

    if ((_status ==
                'Under Monitoring' ||
            _status == 'Accepted' ||
            _status ==
                'Accepted with Conditions') &&
        _reviewDate == null) {
      _showError(
        'Review Date is required for accepted '
        'or monitored risks.',
      );
      return false;
    }

    return true;
  }

  void _showError(
    String message,
  ) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        backgroundColor:
            Colors.red,
        content:
            Text(message),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    if (!_validateBusinessRules()) {
      return;
    }

    final data =
        <String, dynamic>{
      'acceptanceNo':
          _acceptanceNoController
              .text
              .trim(),

      'riskReference':
          _riskReference,

      'project':
          _projectController
              .text
              .trim(),

      'location':
          _locationController
              .text
              .trim(),

      'department':
          _departmentController
              .text
              .trim(),

      'activity':
          _activityController
              .text
              .trim(),

      'hazard':
          _hazardController
              .text
              .trim(),

      'risk':
          _riskController
              .text
              .trim(),

      'consequence':
          _consequenceController
              .text
              .trim(),

      'initialLikelihood':
          _initialLikelihood,

      'initialSeverity':
          _initialSeverity,

      'initialRiskScore':
          _initialScore,

      'initialRiskLevel':
          _initialLevel,

      'additionalControls':
          _additionalControlsController
              .text
              .trim(),

      'residualLikelihood':
          _residualLikelihood,

      'residualSeverity':
          _residualSeverity,

      'residualRiskScore':
          _residualScore,

      'residualRiskLevel':
          _residualLevel,

      'acceptanceJustification':
          _acceptanceJustificationController
              .text
              .trim(),

      'acceptanceConditions':
          _acceptanceConditionsController
              .text
              .trim(),

      'riskOwner':
          _riskOwnerController
              .text
              .trim(),

      'hseReviewer':
          _hseReviewerController
              .text
              .trim(),

      'managementApprover':
          _managementApproverController
              .text
              .trim(),

      'acceptanceDate':
          _acceptanceDate
              ?.toIso8601String(),

      'approvalDate':
          _approvalDate
              ?.toIso8601String(),

      'monitoringRequirements':
          _monitoringRequirementsController
              .text
              .trim(),

      'reviewDate':
          _reviewDate
              ?.toIso8601String(),

      'status':
          _status,

      'rejectionReason':
          _rejectionReasonController
              .text
              .trim(),

      'remarks':
          _remarksController
              .text
              .trim(),
    };

    Navigator.of(
      context,
    ).pop(data);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final bottomInset =
        MediaQuery.of(context)
            .viewInsets
            .bottom;

    return SafeArea(
      child: Container(
        height:
            MediaQuery.of(context)
                    .size
                    .height *
                0.94,
        decoration:
            const BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.vertical(
            top: Radius.circular(
              22,
            ),
          ),
        ),
        child: Column(
          children: [
            _buildFormHeader(),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding:
                      EdgeInsets.fromLTRB(
                    16,
                    8,
                    16,
                    30 + bottomInset,
                  ),
                  children: [
                    _sectionTitle(
                      '1. Risk Acceptance Identification',
                    ),
                    _textField(
                      controller:
                          _acceptanceNoController,
                      label:
                          'Risk Acceptance No.',
                      required: true,
                    ),
                    _dropdownField(
                      label:
                          'Risk Reference',
                      value:
                          _riskReference,
                      items:
                          const [
                        'HIRA',
                        'JSA / JHA',
                        'RAMS',
                        'Risk Control Register',
                        'Risk Register Monitoring',
                        'Other',
                      ],
                      onChanged:
                          (value) {
                        setState(() {
                          _riskReference =
                              value ??
                                  'HIRA';
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
                      onChanged:
                          (value) {
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
                      onChanged:
                          (value) {
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
                      '4. Additional Controls',
                    ),
                    _textField(
                      controller:
                          _additionalControlsController,
                      label:
                          'Additional Controls',
                      required: true,
                      maxLines: 5,
                    ),
                    _textField(
                      controller:
                          _acceptanceJustificationController,
                      label:
                          'Risk Acceptance Justification',
                      required: true,
                      maxLines: 5,
                    ),
                    _textField(
                      controller:
                          _acceptanceConditionsController,
                      label:
                          'Acceptance Conditions',
                      maxLines: 5,
                    ),

                    _sectionTitle(
                      '5. Residual Risk Assessment',
                    ),
                    _riskSelector(
                      title:
                          'Residual Likelihood',
                      value:
                          _residualLikelihood,
                      onChanged:
                          (value) {
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
                      onChanged:
                          (value) {
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
                      '6. Ownership & Review',
                    ),
                    _textField(
                      controller:
                          _riskOwnerController,
                      label:
                          'Risk Owner',
                      required: true,
                    ),
                    _textField(
                      controller:
                          _hseReviewerController,
                      label:
                          'HSE Reviewer',
                    ),
                    _textField(
                      controller:
                          _managementApproverController,
                      label:
                          'Management Approver',
                    ),
                    _dateField(
                      label:
                          'Acceptance Date',
                      value:
                          _acceptanceDate,
                      onTap: () =>
                          _pickDate(
                        current:
                            _acceptanceDate,
                        onSelected:
                            (date) {
                          setState(() {
                            _acceptanceDate =
                                date;
                          });
                        },
                      ),
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
                        onSelected:
                            (date) {
                          setState(() {
                            _approvalDate =
                                date;
                          });
                        },
                      ),
                    ),

                    _sectionTitle(
                      '7. Monitoring & Review',
                    ),
                    _textField(
                      controller:
                          _monitoringRequirementsController,
                      label:
                          'Monitoring Requirements',
                      maxLines: 5,
                    ),
                    _dateField(
                      label:
                          'Next Review Date',
                      value:
                          _reviewDate,
                      onTap: () =>
                          _pickDate(
                        current:
                            _reviewDate,
                        onSelected:
                            (date) {
                          setState(() {
                            _reviewDate =
                                date;
                          });
                        },
                      ),
                    ),

                    _sectionTitle(
                      '8. Approval Status',
                    ),
                    _dropdownField(
                      label: 'Status',
                      value: _status,
                      items:
                          const [
                        'Draft',
                        'Pending Acceptance',
                        'Under HSE Review',
                        'Pending Approval',
                        'Accepted',
                        'Accepted with Conditions',
                        'Rejected',
                        'Under Monitoring',
                        'Closed',
                      ],
                      onChanged:
                          (value) {
                        setState(() {
                          _status =
                              value ??
                                  'Draft';
                        });
                      },
                    ),
                    _textField(
                      controller:
                          _rejectionReasonController,
                      label:
                          'Rejection Reason',
                      maxLines: 4,
                    ),
                    _textField(
                      controller:
                          _remarksController,
                      label:
                          'Remarks',
                      maxLines: 4,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    _buildRiskMatrix(),

                    const SizedBox(
                      height: 24,
                    ),

                    FilledButton.icon(
                      style:
                          FilledButton.styleFrom(
                        backgroundColor:
                            primaryGreen,
                        foregroundColor:
                            Colors.white,
                        minimumSize:
                            const Size
                                .fromHeight(
                          52,
                        ),
                      ),
                      onPressed:
                          _submit,
                      icon: Icon(
                        _isEditing
                            ? Icons
                                .save_outlined
                            : Icons
                                .add_task,
                      ),
                      label: Text(
                        _isEditing
                            ? 'Update Risk Acceptance'
                            : 'Save Risk Acceptance',
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
      padding:
          const EdgeInsets.fromLTRB(
        18,
        14,
        12,
        12,
      ),
      decoration:
          const BoxDecoration(
        color: primaryGreen,
        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(
            22,
          ),
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              '3I • Risk Acceptance & Residual Risk Approval',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: () =>
                Navigator.pop(
              context,
            ),
            color: Colors.white,
            icon: const Icon(
              Icons.close,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(
    String title,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        top: 18,
        bottom: 10,
      ),
      child: Text(
        title,
        style:
            const TextStyle(
          fontSize: 16,
          fontWeight:
              FontWeight.bold,
          color: darkGreen,
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController
        controller,
    required String label,
    bool required = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration:
            InputDecoration(
          labelText: required
              ? '$label *'
              : label,
          alignLabelWithHint:
              maxLines > 1,
          filled: true,
          fillColor:
              const Color(
            0xFFF8FAF9,
          ),
          border:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(
              11,
            ),
          ),
        ),
        validator: required
            ? (value) {
                if (value ==
                        null ||
                    value
                        .trim()
                        .isEmpty) {
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
    required List<String>
        items,
    required ValueChanged<String?>
        onChanged,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child:
          DropdownButtonFormField<
              String>(
        initialValue: value,
        decoration:
            InputDecoration(
          labelText: label,
          filled: true,
          fillColor:
              const Color(
            0xFFF8FAF9,
          ),
          border:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(
              11,
            ),
          ),
        ),
        items: items
            .map(
              (item) =>
                  DropdownMenuItem<
                      String>(
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
    required ValueChanged<int>
        onChanged,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child:
          DropdownButtonFormField<
              int>(
        initialValue: value,
        decoration:
            InputDecoration(
          labelText: title,
          filled: true,
          fillColor:
              const Color(
            0xFFF8FAF9,
          ),
          border:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(
              11,
            ),
          ),
        ),
        items: List.generate(
          5,
          (index) {
            final number =
                index + 1;

            return DropdownMenuItem<
                int>(
              value: number,
              child: Text(
                number.toString(),
              ),
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
    final color =
        _matrixColor(level);

    return Card(
      elevation: 0,
      color:
          color.withValues(
        alpha: 0.10,
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(
          12,
        ),
        child: Row(
          children: [
            Icon(
              Icons
                  .assessment_outlined,
              color: color,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                title,
                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
            Text(
              '$score • $level',
              style: TextStyle(
                color: color,
                fontWeight:
                    FontWeight.bold,
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
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius:
            BorderRadius.circular(
          11,
        ),
        child: InputDecorator(
          decoration:
              InputDecoration(
            labelText: label,
            filled: true,
            fillColor:
                const Color(
              0xFFF8FAF9,
            ),
            border:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                11,
              ),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons
                    .calendar_today_outlined,
                size: 19,
                color: darkGreen,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                _formatDate(value),
                style: TextStyle(
                  color: value ==
                          null
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
            fontWeight:
                FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Risk Score = Likelihood × Severity',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration:
              BoxDecoration(
            border: Border.all(
              color:
                  Colors.grey.shade300,
            ),
            borderRadius:
                BorderRadius.circular(
              10,
            ),
          ),
          clipBehavior:
              Clip.antiAlias,
          child: Column(
            children: [
              _matrixHeader(),
              for (
                int severity = 1;
                severity <= 5;
                severity++
              )
                _matrixRow(
                  severity,
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children:
              levels.map(
            (level) {
              final color =
                  _matrixColor(
                level,
              );

              return Container(
                padding:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                decoration:
                    BoxDecoration(
                  color: color
                      .withValues(
                    alpha: 0.12,
                  ),
                  borderRadius:
                      BorderRadius
                          .circular(
                    8,
                  ),
                ),
                child: Text(
                  level,
                  style:
                      TextStyle(
                    fontSize: 11,
                    color: color,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              );
            },
          ).toList(),
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
        for (
          int likelihood = 1;
          likelihood <= 5;
          likelihood++
        )
          _matrixCell(
            likelihood.toString(),
            isHeader: true,
          ),
      ],
    );
  }

  Widget _matrixRow(
    int severity,
  ) {
    return Row(
      children: [
        _matrixCell(
          severity.toString(),
          isHeader: true,
        ),
        for (
          int likelihood = 1;
          likelihood <= 5;
          likelihood++
        )
          _matrixRiskCell(
            likelihood *
                severity,
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
        alignment:
            Alignment.center,
        decoration:
            BoxDecoration(
          color: isHeader
              ? const Color(
                  0xFFE9F3EF,
                )
              : Colors.white,
          border:
              Border.all(
            color:
                Colors.grey.shade300,
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

  Widget _matrixRiskCell(
    int score,
  ) {
    final level =
        _riskLevelFromScore(
      score,
    );

    final color =
        _matrixColor(level);

    return Expanded(
      child: Container(
        height: 34,
        alignment:
            Alignment.center,
        decoration:
            BoxDecoration(
          color: color
              .withValues(
            alpha: 0.12,
          ),
          border:
              Border.all(
            color:
                Colors.grey.shade300,
            width: 0.5,
          ),
        ),
        child: Text(
          score.toString(),
          style: TextStyle(
            fontSize: 11,
            fontWeight:
                FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }

  Color _matrixColor(
    String level,
  ) {
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
