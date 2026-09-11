import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiskChangeManagementPage extends StatefulWidget {
  const RiskChangeManagementPage({
    super.key,
  });

  @override
  State<RiskChangeManagementPage> createState() =>
      _RiskChangeManagementPageState();
}

class _RiskChangeManagementPageState
    extends State<RiskChangeManagementPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const String storageKey =
      'safenexus_hse_risk_change_management';

  final TextEditingController _searchController =
      TextEditingController();

  List<Map<String, dynamic>> _records = [];

  String _statusFilter = 'All';
  String _changeTypeFilter = 'All';
  String _riskFilter = 'All';

  static const List<String> statuses = [
    'Draft',
    'Under Evaluation',
    'Risk Re-Assessment Required',
    'Additional Controls Required',
    'Pending Approval',
    'Approved',
    'Communicated',
    'Implemented',
    'Monitoring',
    'Effective',
    'Closed',
    'Rejected',
    'Cancelled',
  ];

  static const List<String> changeTypes = [
    'Process Change',
    'Equipment Change',
    'Material / Chemical Change',
    'Method Change',
    'Personnel Change',
    'Site / Location Change',
    'Design Change',
    'Legal / Requirement Change',
    'Emergency Change',
    'Other',
  ];

  static const List<String> riskLevels = [
    'Low',
    'Medium',
    'High',
    'Critical',
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
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);

    if (raw == null || raw.isEmpty || !mounted) {
      return;
    }

    try {
      final decoded = jsonDecode(raw);

      if (decoded is List) {
        setState(() {
          _records = decoded
              .whereType<Map>()
              .map(
                (item) => Map<String, dynamic>.from(item),
              )
              .toList();
        });
      }
    } catch (_) {
      // Ignore invalid local data.
    }
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      storageKey,
      jsonEncode(_records),
    );
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query =
        _searchController.text.trim().toLowerCase();

    return _records.where((record) {
      final status =
          record['status']?.toString() ?? '';
      final changeType =
          record['changeType']?.toString() ?? '';
      final residualRisk =
          record['residualRiskLevel']?.toString() ?? '';

      if (_statusFilter != 'All' &&
          status != _statusFilter) {
        return false;
      }

      if (_changeTypeFilter != 'All' &&
          changeType != _changeTypeFilter) {
        return false;
      }

      if (_riskFilter != 'All' &&
          residualRisk != _riskFilter) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      final searchable = [
        record['changeNo'],
        record['changeReference'],
        record['project'],
        record['location'],
        record['department'],
        record['activity'],
        record['changeType'],
        record['changeDescription'],
        record['reason'],
        record['riskReference'],
        record['additionalHazards'],
        record['additionalControls'],
        record['responsiblePerson'],
        record['status'],
        record['initialRiskLevel'],
        record['residualRiskLevel'],
      ].join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();
  }

  int _countByStatus(String status) {
    return _records.where(
      (record) => record['status'] == status,
    ).length;
  }

  int _countByRisk(String level) {
    return _records.where(
      (record) => record['residualRiskLevel'] == level,
    ).length;
  }

  bool _isClosedStatus(String status) {
    return status == 'Closed' ||
        status == 'Cancelled' ||
        status == 'Rejected';
  }

  bool _isOverdue(Map<String, dynamic> record) {
    final targetDate =
        _parseDate(record['targetDate']?.toString());

    if (targetDate == null) {
      return false;
    }

    final status =
        record['status']?.toString() ?? '';

    if (_isClosedStatus(status) ||
        status == 'Effective') {
      return false;
    }

    final today = DateTime.now();

    return DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
    ).isBefore(
      DateTime(
        today.year,
        today.month,
        today.day,
      ),
    );
  }

  DateTime? _parseDate(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    return DateTime.tryParse(value);
  }

  String _formatDate(String? value) {
    final date = _parseDate(value);

    if (date == null) {
      return '-';
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _formatDateTime(String? value) {
    final date = _parseDate(value);

    if (date == null) {
      return '-';
    }

    return '${_formatDate(value)} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _openForm({
    Map<String, dynamic>? existingRecord,
    int? editIndex,
  }) async {
    final result =
        await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return RiskChangeManagementFormSheet(
          existingRecord: existingRecord,
        );
      },
    );

    if (result == null || !mounted) {
      return;
    }

    setState(() {
      if (editIndex != null &&
          editIndex >= 0 &&
          editIndex < _records.length) {
        final oldRecord =
            Map<String, dynamic>.from(
          _records[editIndex],
        );

        result['createdAt'] =
            oldRecord['createdAt'] ??
                DateTime.now().toIso8601String();

        result['updatedAt'] =
            DateTime.now().toIso8601String();

        _records[editIndex] = result;
      } else {
        result['createdAt'] =
            DateTime.now().toIso8601String();

        result['updatedAt'] =
            DateTime.now().toIso8601String();

        _records.insert(0, result);
      }
    });

    await _saveRecords();
  }

  Future<void> _deleteRecord(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Record'),
          content: const Text(
            'Are you sure you want to delete this '
            'risk change management record?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    setState(() {
      _records.removeAt(index);
    });

    await _saveRecords();
  }

  void _showHistory(
    Map<String, dynamic> record,
  ) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Record History'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Created',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatDateTime(
                  record['createdAt']?.toString(),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Last Updated',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatDateTime(
                  record['updatedAt']?.toString(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Draft':
        return Colors.grey;
      case 'Under Evaluation':
        return Colors.blue;
      case 'Risk Re-Assessment Required':
        return Colors.orange;
      case 'Additional Controls Required':
        return Colors.deepOrange;
      case 'Pending Approval':
        return Colors.amber.shade800;
      case 'Approved':
        return Colors.indigo;
      case 'Communicated':
        return Colors.teal;
      case 'Implemented':
        return Colors.cyan.shade700;
      case 'Monitoring':
        return Colors.purple;
      case 'Effective':
        return primaryGreen;
      case 'Closed':
        return darkGreen;
      case 'Rejected':
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
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

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text(
          'Risk Change Management',
        ),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _loadRecords,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton:
          FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: _openForm,
        icon: const Icon(Icons.add),
        label: const Text('Add Change'),
      ),
      body: RefreshIndicator(
        onRefresh: _loadRecords,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            12,
            12,
            12,
            100,
          ),
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildDashboard(),
            const SizedBox(height: 12),
            _buildSearchAndFilters(),
            const SizedBox(height: 12),
            if (filtered.isEmpty)
              _buildEmptyState()
            else
              ...filtered.map(
                _buildRecordCard,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: primaryGreen.withValues(
                  alpha: 0.10,
                ),
                borderRadius:
                    BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.change_circle_outlined,
                color: primaryGreen,
                size: 30,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Risk Change Management & Re-Assessment',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Evaluate changes, reassess risks, '
                    'approve controls and monitor implementation.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
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

  Widget _buildDashboard() {
    final total = _records.length;
    final evaluation =
        _countByStatus('Under Evaluation');
    final reassessment =
        _countByStatus(
      'Risk Re-Assessment Required',
    );
    final approval =
        _countByStatus('Pending Approval');
    final implemented =
        _countByStatus('Implemented');
    final monitoring =
        _countByStatus('Monitoring');
    final effective =
        _countByStatus('Effective');
    final overdue =
        _records.where(_isOverdue).length;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _metricCard(
                'Total',
                total.toString(),
                Icons.list_alt_outlined,
                primaryGreen,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _metricCard(
                'Evaluation',
                evaluation.toString(),
                Icons.manage_search_outlined,
                Colors.blue,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _metricCard(
                'Re-Assess',
                reassessment.toString(),
                Icons.assessment_outlined,
                Colors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _metricCard(
                'Approval',
                approval.toString(),
                Icons.approval_outlined,
                Colors.indigo,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _metricCard(
                'Implemented',
                implemented.toString(),
                Icons.build_circle_outlined,
                Colors.cyan.shade700,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _metricCard(
                'Monitoring',
                monitoring.toString(),
                Icons.monitor_outlined,
                Colors.purple,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _metricCard(
                'Effective',
                effective.toString(),
                Icons.verified_outlined,
                primaryGreen,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _metricCard(
                'Overdue',
                overdue.toString(),
                Icons.schedule,
                Colors.red,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _metricCard(
                'Records',
                _filteredRecords.length.toString(),
                Icons.filter_alt_outlined,
                Colors.blueGrey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _metricCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 12,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 21,
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                hintText:
                    'No, project, activity, risk, change...',
                prefixIcon:
                    const Icon(Icons.search),
                suffixIcon:
                    _searchController.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () {
                              _searchController.clear();
                            },
                            icon: const Icon(
                              Icons.clear,
                            ),
                          ),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _statusFilter,
              decoration:
                  _filterDecoration('Status'),
              items: [
                const DropdownMenuItem(
                  value: 'All',
                  child: Text('All'),
                ),
                ...statuses.map(
                  (status) =>
                      DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _statusFilter =
                      value ?? 'All';
                });
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue:
                  _changeTypeFilter,
              decoration: _filterDecoration(
                'Change Type',
              ),
              items: [
                const DropdownMenuItem(
                  value: 'All',
                  child: Text('All'),
                ),
                ...changeTypes.map(
                  (type) =>
                      DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _changeTypeFilter =
                      value ?? 'All';
                });
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _riskFilter,
              decoration: _filterDecoration(
                'Residual Risk',
              ),
              items: [
                const DropdownMenuItem(
                  value: 'All',
                  child: Text('All'),
                ),
                ...riskLevels.map(
                  (level) =>
                      DropdownMenuItem(
                    value: level,
                    child: Text(level),
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _riskFilter =
                      value ?? 'All';
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _filterDecoration(
    String label,
  ) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
      ),
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
    );
  }

  Widget _buildRecordCard(
    Map<String, dynamic> record,
  ) {
    final recordIndex =
        _records.indexOf(record);

    final status =
        record['status']?.toString() ?? '';

    final initialRisk =
        record['initialRiskLevel']
                ?.toString() ??
            '-';

    final residualRisk =
        record['residualRiskLevel']
                ?.toString() ??
            '-';

    final overdue = _isOverdue(record);

    return Card(
      elevation: 1,
      margin:
          const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(14),
      ),
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
                    record['changeNo']
                            ?.toString() ??
                        'Risk Change',
                    style:
                        const TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      _openForm(
                        existingRecord:
                            record,
                        editIndex:
                            recordIndex,
                      );
                    } else if (value ==
                        'history') {
                      _showHistory(record);
                    } else if (value ==
                        'delete') {
                      _deleteRecord(
                        recordIndex,
                      );
                    }
                  },
                  itemBuilder: (_) =>
                      const [
                    PopupMenuItem(
                      value: 'edit',
                      child:
                          Text('Edit'),
                    ),
                    PopupMenuItem(
                      value: 'history',
                      child:
                          Text('History'),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child:
                          Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _badge(
                  status,
                  _statusColor(status),
                ),
                _badge(
                  'Initial: $initialRisk',
                  _riskColor(
                    initialRisk,
                  ),
                ),
                _badge(
                  'Residual: $residualRisk',
                  _riskColor(
                    residualRisk,
                  ),
                ),
                if (overdue)
                  _badge(
                    'OVERDUE',
                    Colors.red,
                  ),
              ],
            ),
            const SizedBox(height: 12),
            _infoRow(
              Icons.link,
              'Change Ref.',
              record['changeReference'],
            ),
            _infoRow(
              Icons.warning_amber_outlined,
              'Risk Ref.',
              record['riskReference'],
            ),
            _infoRow(
              Icons.business_outlined,
              'Project',
              record['project'],
            ),
            _infoRow(
              Icons.location_on_outlined,
              'Location',
              record['location'],
            ),
            _infoRow(
              Icons.work_outline,
              'Activity',
              record['activity'],
            ),
            _infoRow(
              Icons.change_circle_outlined,
              'Change Type',
              record['changeType'],
            ),
            _infoRow(
              Icons.description_outlined,
              'Change',
              record['changeDescription'],
            ),
            _infoRow(
              Icons.help_outline,
              'Reason',
              record['reason'],
            ),
            const Divider(height: 22),
            _infoRow(
              Icons.warning_outlined,
              'Additional Hazards',
              record['additionalHazards'],
            ),
            _infoRow(
              Icons.security_outlined,
              'Additional Controls',
              record['additionalControls'],
            ),
            _infoRow(
              Icons.person_outline,
              'Responsible',
              record['responsiblePerson'],
            ),
            _infoRow(
              Icons.event_outlined,
              'Target Date',
              _formatDate(
                record['targetDate']
                    ?.toString(),
              ),
            ),
            _infoRow(
              Icons.person_search_outlined,
              'Approver',
              record['approvedBy'],
            ),
            _infoRow(
              Icons.campaign_outlined,
              'Communicated By',
              record['communicatedBy'],
            ),
            _infoRow(
              Icons.build_circle_outlined,
              'Implementation',
              record[
                  'implementationStatus'],
            ),
            _infoRow(
              Icons.monitor_outlined,
              'Monitoring',
              record[
                  'monitoringStatus'],
            ),
            _infoRow(
              Icons.verified_outlined,
              'Effectiveness',
              record[
                  'effectiveness'],
            ),
            if ((record['remarks']
                        ?.toString() ??
                    '')
                .isNotEmpty)
              _infoRow(
                Icons.notes_outlined,
                'Remarks',
                record['remarks'],
              ),
          ],
        ),
      ),
    );
  }

  Widget _badge(
    String text,
    Color color,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.12,
        ),
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String label,
    dynamic value,
  ) {
    final text =
        value?.toString() ?? '';

    if (text.isEmpty || text == '-') {
      return const SizedBox.shrink();
    }

    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 7,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 17,
            color: darkGreen,
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 105,
            child: Text(
              label,
              style:
                  const TextStyle(
                fontSize: 11,
                color:
                    Colors.black54,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
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

  Widget _buildEmptyState() {
    return Card(
      elevation: 1,
      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(14),
      ),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        child: Column(
          children: [
            Icon(
              Icons.change_circle_outlined,
              size: 55,
              color:
                  primaryGreen.withValues(
                alpha: 0.55,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'No Risk Change Records',
              style:
                  TextStyle(
                fontSize: 16,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Add a change record to start '
              'risk evaluation and re-assessment.',
              textAlign:
                  TextAlign.center,
              style:
                  TextStyle(
                fontSize: 12,
                color:
                    Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              style:
                  FilledButton.styleFrom(
                backgroundColor:
                    primaryGreen,
              ),
              onPressed: _openForm,
              icon: const Icon(
                Icons.add,
              ),
              label: const Text(
                'Add First Change',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RiskChangeManagementFormSheet
    extends StatefulWidget {
  final Map<String, dynamic>?
      existingRecord;

  const RiskChangeManagementFormSheet({
    super.key,
    this.existingRecord,
  });

  @override
  State<RiskChangeManagementFormSheet>
      createState() =>
          _RiskChangeManagementFormSheetState();
}

class _RiskChangeManagementFormSheetState
    extends State<
        RiskChangeManagementFormSheet> {
  static const Color primaryGreen =
      Color(0xFF159447);
  static const Color darkGreen =
      Color(0xFF0B5D4B);

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  late final TextEditingController
      _changeNoController;
  late final TextEditingController
      _changeReferenceController;
  late final TextEditingController
      _projectController;
  late final TextEditingController
      _locationController;
  late final TextEditingController
      _departmentController;
  late final TextEditingController
      _activityController;
  late final TextEditingController
      _changeDescriptionController;
  late final TextEditingController
      _reasonController;
  late final TextEditingController
      _riskReferenceController;
  late final TextEditingController
      _existingRiskController;
  late final TextEditingController
      _additionalHazardsController;
  late final TextEditingController
      _additionalControlsController;
  late final TextEditingController
      _responsibleController;
  late final TextEditingController
      _approvalCommentsController;
  late final TextEditingController
      _communicatedByController;
  late final TextEditingController
      _workerAcknowledgementController;
  late final TextEditingController
      _monitoringCommentsController;
  late final TextEditingController
      _remarksController;

  String _changeType =
      'Process Change';

  String _initialRiskLevel =
      'Medium';

  String _residualRiskLevel =
      'Medium';

  String _status =
      'Draft';

  String _implementationStatus =
      'Not Started';

  String _monitoringStatus =
      'Not Started';

  String _effectiveness =
      'Not Assessed';

  bool _riskReAssessmentCompleted =
      false;

  bool _approved = false;

  bool _communicated = false;

  DateTime? _changeDate;
  DateTime? _targetDate;
  DateTime? _approvalDate;
  DateTime? _communicationDate;
  DateTime? _implementationDate;
  DateTime? _monitoringDate;
  DateTime? _closureDate;

  late final TextEditingController
      _initialLikelihoodController;
  late final TextEditingController
      _initialSeverityController;
  late final TextEditingController
      _residualLikelihoodController;
  late final TextEditingController
      _residualSeverityController;

  bool get _isEditing =>
      widget.existingRecord != null;

  static const List<String> _changeTypes = [
    'Process Change',
    'Equipment Change',
    'Material / Chemical Change',
    'Method Change',
    'Personnel Change',
    'Site / Location Change',
    'Design Change',
    'Legal / Requirement Change',
    'Emergency Change',
    'Other',
  ];

  static const List<String> _riskLevels = [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static const List<String> _statuses = [
    'Draft',
    'Under Evaluation',
    'Risk Re-Assessment Required',
    'Additional Controls Required',
    'Pending Approval',
    'Approved',
    'Communicated',
    'Implemented',
    'Monitoring',
    'Effective',
    'Closed',
    'Rejected',
    'Cancelled',
  ];

  static const List<String>
      _implementationStatuses = [
    'Not Started',
    'In Progress',
    'Implemented',
    'Not Implemented',
  ];

  static const List<String>
      _monitoringStatuses = [
    'Not Started',
    'In Progress',
    'Monitoring Complete',
    'Issue Identified',
    'Closed',
  ];

  static const List<String>
      _effectivenessValues = [
    'Not Assessed',
    'Effective',
    'Partially Effective',
    'Ineffective',
  ];

  @override
  void initState() {
    super.initState();

    final record =
        widget.existingRecord;

    _changeNoController =
        TextEditingController(
      text: record?['changeNo']
              ?.toString() ??
          '',
    );

    _changeReferenceController =
        TextEditingController(
      text: record?['changeReference']
              ?.toString() ??
          '',
    );

    _projectController =
        TextEditingController(
      text: record?['project']
              ?.toString() ??
          '',
    );

    _locationController =
        TextEditingController(
      text: record?['location']
              ?.toString() ??
          '',
    );

    _departmentController =
        TextEditingController(
      text: record?['department']
              ?.toString() ??
          '',
    );

    _activityController =
        TextEditingController(
      text: record?['activity']
              ?.toString() ??
          '',
    );

    _changeDescriptionController =
        TextEditingController(
      text: record?['changeDescription']
              ?.toString() ??
          '',
    );

    _reasonController =
        TextEditingController(
      text: record?['reason']
              ?.toString() ??
          '',
    );

    _riskReferenceController =
        TextEditingController(
      text: record?['riskReference']
              ?.toString() ??
          '',
    );

    _existingRiskController =
        TextEditingController(
      text: record?['existingRisk']
              ?.toString() ??
          '',
    );

    _additionalHazardsController =
        TextEditingController(
      text: record?['additionalHazards']
              ?.toString() ??
          '',
    );

    _additionalControlsController =
        TextEditingController(
      text: record?['additionalControls']
              ?.toString() ??
          '',
    );

    _responsibleController =
        TextEditingController(
      text: record?['responsiblePerson']
              ?.toString() ??
          '',
    );

    _approvalCommentsController =
        TextEditingController(
      text: record?['approvalComments']
              ?.toString() ??
          '',
    );

    _communicatedByController =
        TextEditingController(
      text: record?['communicatedBy']
              ?.toString() ??
          '',
    );

    _workerAcknowledgementController =
        TextEditingController(
      text: record?[
                  'workerAcknowledgement']
              ?.toString() ??
          '',
    );

    _monitoringCommentsController =
        TextEditingController(
      text: record?[
                  'monitoringComments']
              ?.toString() ??
          '',
    );

    _remarksController =
        TextEditingController(
      text: record?['remarks']
              ?.toString() ??
          '',
    );

    _initialLikelihoodController =
        TextEditingController(
      text: record?[
                  'initialLikelihood']
              ?.toString() ??
          '3',
    );

    _initialSeverityController =
        TextEditingController(
      text: record?['initialSeverity']
              ?.toString() ??
          '3',
    );

    _residualLikelihoodController =
        TextEditingController(
      text: record?[
                  'residualLikelihood']
              ?.toString() ??
          '2',
    );

    _residualSeverityController =
        TextEditingController(
      text: record?[
                  'residualSeverity']
              ?.toString() ??
          '2',
    );

    _changeType =
        record?['changeType']
                ?.toString() ??
            _changeType;

    _initialRiskLevel =
        record?['initialRiskLevel']
                ?.toString() ??
            _initialRiskLevel;

    _residualRiskLevel =
        record?['residualRiskLevel']
                ?.toString() ??
            _residualRiskLevel;

    _status =
        record?['status']
                ?.toString() ??
            _status;

    _implementationStatus =
        record?[
                    'implementationStatus']
                ?.toString() ??
            _implementationStatus;

    _monitoringStatus =
        record?['monitoringStatus']
                ?.toString() ??
            _monitoringStatus;

    _effectiveness =
        record?['effectiveness']
                ?.toString() ??
            _effectiveness;

    _riskReAssessmentCompleted =
        record?[
                    'riskReAssessmentCompleted'] ==
                true;

    _approved =
        record?['approved'] == true;

    _communicated =
        record?['communicated'] == true;

    _changeDate = _parseDate(
      record?['changeDate']?.toString(),
    );

    _targetDate = _parseDate(
      record?['targetDate']?.toString(),
    );

    _approvalDate = _parseDate(
      record?['approvalDate']?.toString(),
    );

    _communicationDate = _parseDate(
      record?[
                  'communicationDate']
              ?.toString(),
    );

    _implementationDate = _parseDate(
      record?[
                  'implementationDate']
              ?.toString(),
    );

    _monitoringDate = _parseDate(
      record?['monitoringDate']
          ?.toString(),
    );

    _closureDate = _parseDate(
      record?['closureDate']
          ?.toString(),
    );
  }

  @override
  void dispose() {
    _changeNoController.dispose();
    _changeReferenceController.dispose();
    _projectController.dispose();
    _locationController.dispose();
    _departmentController.dispose();
    _activityController.dispose();
    _changeDescriptionController.dispose();
    _reasonController.dispose();
    _riskReferenceController.dispose();
    _existingRiskController.dispose();
    _additionalHazardsController.dispose();
    _additionalControlsController.dispose();
    _responsibleController.dispose();
    _approvalCommentsController.dispose();
    _communicatedByController.dispose();
    _workerAcknowledgementController
        .dispose();
    _monitoringCommentsController
        .dispose();
    _remarksController.dispose();
    _initialLikelihoodController
        .dispose();
    _initialSeverityController.dispose();
    _residualLikelihoodController
        .dispose();
    _residualSeverityController.dispose();
    super.dispose();
  }

  DateTime? _parseDate(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    return DateTime.tryParse(value);
  }

  String _dateToText(DateTime? date) {
    if (date == null) {
      return '';
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  Future<void> _pickDate({
    required DateTime? current,
    required ValueChanged<DateTime>
        onSelected,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate:
          current ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      onSelected(picked);
    }
  }

  InputDecoration _decoration(
    String label, {
    IconData? icon,
    String? hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon == null
          ? null
          : Icon(
              icon,
              color: darkGreen,
            ),
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget _sectionTitle(
    String title,
    IconData icon,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        top: 18,
        bottom: 10,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryGreen,
            size: 21,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style:
                  const TextStyle(
                fontSize: 15,
                fontWeight:
                    FontWeight.bold,
                color: darkGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField(
    TextEditingController controller,
    String label, {
    IconData? icon,
    bool required = false,
    int maxLines = 1,
    String? hint,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: _decoration(
          label,
          icon: icon,
          hint: hint,
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

  Widget _dropdownField(
    String label,
    String value,
    List<String> values,
    ValueChanged<String?>
        onChanged,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child:
          DropdownButtonFormField<String>(
        initialValue: value,
        decoration:
            _decoration(label),
        items: values
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

  Widget _dateField(
    String label,
    DateTime? value,
    VoidCallback onTap, {
    bool required = false,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius:
            BorderRadius.circular(12),
        child: InputDecorator(
          decoration: _decoration(
            label,
            icon:
                Icons.event_outlined,
          ).copyWith(
            errorText:
                required &&
                        value == null
                    ? 'Select $label'
                    : null,
          ),
          child: Text(
            value == null
                ? 'Select date'
                : _dateToText(value),
            style: TextStyle(
              color: value == null
                  ? Colors.black45
                  : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  int _score(
    TextEditingController likelihood,
    TextEditingController severity,
  ) {
    final l =
        int.tryParse(
              likelihood.text.trim(),
            ) ??
            0;

    final s =
        int.tryParse(
              severity.text.trim(),
            ) ??
            0;

    return l * s;
  }

  String _levelFromScore(int score) {
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

  void _calculateInitialRisk() {
    final score = _score(
      _initialLikelihoodController,
      _initialSeverityController,
    );

    if (score < 1 || score > 25) {
      _showMessage(
        'Likelihood and Severity must be between 1 and 5.',
      );
      return;
    }

    setState(() {
      _initialRiskLevel =
          _levelFromScore(score);
    });
  }

  void _calculateResidualRisk() {
    final score = _score(
      _residualLikelihoodController,
      _residualSeverityController,
    );

    if (score < 1 || score > 25) {
      _showMessage(
        'Likelihood and Severity must be between 1 and 5.',
      );
      return;
    }

    setState(() {
      _residualRiskLevel =
          _levelFromScore(score);
    });
  }

  Widget _riskScoreCard({
    required String title,
    required TextEditingController
        likelihood,
    required TextEditingController
        severity,
    required String level,
    required VoidCallback onCalculate,
  }) {
    final score = _score(
      likelihood,
      severity,
    );

    return Card(
      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),
      elevation: 0,
      color: Colors.white,
      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(12),
        side: BorderSide(
          color:
              Colors.grey.shade300,
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child:
                      TextFormField(
                    controller:
                        likelihood,
                    keyboardType:
                        TextInputType.number,
                    decoration:
                        _decoration(
                      'Likelihood (1-5)',
                    ),
                    validator:
                        (value) {
                      final number =
                          int.tryParse(
                        value?.trim() ??
                            '',
                      );

                      if (number ==
                              null ||
                          number <
                              1 ||
                          number >
                              5) {
                        return '1-5';
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child:
                      TextFormField(
                    controller:
                        severity,
                    keyboardType:
                        TextInputType.number,
                    decoration:
                        _decoration(
                      'Severity (1-5)',
                    ),
                    validator:
                        (value) {
                      final number =
                          int.tryParse(
                        value?.trim() ??
                            '',
                      );

                      if (number ==
                              null ||
                          number <
                              1 ||
                          number >
                              5) {
                        return '1-5';
                      }

                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration:
                        BoxDecoration(
                      color:
                          primaryGreen
                              .withValues(
                        alpha: 0.08,
                      ),
                      borderRadius:
                          BorderRadius
                              .circular(
                        10,
                      ),
                    ),
                    child: Text(
                      'Score: $score\nLevel: $level',
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  style:
                      FilledButton.styleFrom(
                    backgroundColor:
                        primaryGreen,
                  ),
                  onPressed:
                      onCalculate,
                  child:
                      const Text(
                    'Calculate',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    if (_changeDate == null) {
      _showMessage(
        'Please select Change Date.',
      );
      return;
    }

    if (_targetDate == null) {
      _showMessage(
        'Please select Target Date.',
      );
      return;
    }

    final initialScore = _score(
      _initialLikelihoodController,
      _initialSeverityController,
    );

    final residualScore = _score(
      _residualLikelihoodController,
      _residualSeverityController,
    );

    if (initialScore < 1 ||
        initialScore > 25) {
      _showMessage(
        'Initial risk score must be between 1 and 25.',
      );
      return;
    }

    if (residualScore < 1 ||
        residualScore > 25) {
      _showMessage(
        'Residual risk score must be between 1 and 25.',
      );
      return;
    }

    if (_riskReAssessmentCompleted &&
        _additionalControlsController
            .text
            .trim()
            .isEmpty) {
      _showMessage(
        'Additional Controls are required when risk re-assessment is completed.',
      );
      return;
    }

    if (_status == 'Approved' &&
        !_approved) {
      _showMessage(
        'Approved status requires approval confirmation.',
      );
      return;
    }

    if (_status == 'Communicated' &&
        !_communicated) {
      _showMessage(
        'Communicated status requires communication confirmation.',
      );
      return;
    }

    if (_status == 'Implemented' &&
        _implementationStatus !=
            'Implemented') {
      _showMessage(
        'Implemented status requires Implementation Status = Implemented.',
      );
      return;
    }

    if (_status == 'Effective' &&
        _effectiveness !=
            'Effective') {
      _showMessage(
        'Effective status requires Effectiveness = Effective.',
      );
      return;
    }

    if (_closureDate != null &&
        _changeDate != null &&
        _closureDate!.isBefore(
          _changeDate!,
        )) {
      _showMessage(
        'Closure Date cannot be before Change Date.',
      );
      return;
    }

    final result =
        <String, dynamic>{
      'changeNo':
          _changeNoController.text
              .trim(),
      'changeReference':
          _changeReferenceController
              .text
              .trim(),
      'project':
          _projectController.text
              .trim(),
      'location':
          _locationController.text
              .trim(),
      'department':
          _departmentController.text
              .trim(),
      'activity':
          _activityController.text
              .trim(),
      'changeType':
          _changeType,
      'changeDate':
          _changeDate!
              .toIso8601String(),
      'changeDescription':
          _changeDescriptionController
              .text
              .trim(),
      'reason':
          _reasonController.text
              .trim(),
      'riskReference':
          _riskReferenceController
              .text
              .trim(),
      'existingRisk':
          _existingRiskController
              .text
              .trim(),
      'initialLikelihood':
          int.parse(
        _initialLikelihoodController
            .text
            .trim(),
      ),
      'initialSeverity':
          int.parse(
        _initialSeverityController
            .text
            .trim(),
      ),
      'initialScore':
          initialScore,
      'initialRiskLevel':
          _initialRiskLevel,
      'additionalHazards':
          _additionalHazardsController
              .text
              .trim(),
      'additionalControls':
          _additionalControlsController
              .text
              .trim(),
      'riskReAssessmentCompleted':
          _riskReAssessmentCompleted,
      'residualLikelihood':
          int.parse(
        _residualLikelihoodController
            .text
            .trim(),
      ),
      'residualSeverity':
          int.parse(
        _residualSeverityController
            .text
            .trim(),
      ),
      'residualScore':
          residualScore,
      'residualRiskLevel':
          _residualRiskLevel,
      'responsiblePerson':
          _responsibleController.text
              .trim(),
      'targetDate':
          _targetDate!
              .toIso8601String(),
      'approved':
          _approved,
      'approvalDate':
          _approvalDate
                  ?.toIso8601String() ??
              '',
      'approvalComments':
          _approvalCommentsController
              .text
              .trim(),
      'communicated':
          _communicated,
      'communicationDate':
          _communicationDate
                  ?.toIso8601String() ??
              '',
      'communicatedBy':
          _communicatedByController
              .text
              .trim(),
      'workerAcknowledgement':
          _workerAcknowledgementController
              .text
              .trim(),
      'implementationStatus':
          _implementationStatus,
      'implementationDate':
          _implementationDate
                  ?.toIso8601String() ??
              '',
      'monitoringStatus':
          _monitoringStatus,
      'monitoringDate':
          _monitoringDate
                  ?.toIso8601String() ??
              '',
      'monitoringComments':
          _monitoringCommentsController
              .text
              .trim(),
      'effectiveness':
          _effectiveness,
      'closureDate':
          _closureDate
                  ?.toIso8601String() ??
              '',
      'status':
          _status,
      'remarks':
          _remarksController.text
              .trim(),
    };

    if (!mounted) {
      return;
    }

    Navigator.pop(
      context,
      result,
    );
  }

  void _showMessage(
    String message,
  ) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content:
            Text(message),
        behavior:
            SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset =
        MediaQuery.viewInsetsOf(
      context,
    ).bottom;

    return SafeArea(
      child: Container(
        height:
            MediaQuery.sizeOf(context)
                    .height *
                0.95,
        decoration:
            const BoxDecoration(
          color:
              Color(0xFFF6F8F7),
          borderRadius:
              BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets
                      .fromLTRB(
                18,
                12,
                8,
                12,
              ),
              decoration:
                  const BoxDecoration(
                color: primaryGreen,
                borderRadius:
                    BorderRadius.vertical(
                  top:
                      Radius.circular(22),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _isEditing
                          ? 'Edit Risk Change'
                          : 'New Risk Change',
                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                        fontSize: 17,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    color:
                        Colors.white,
                    icon:
                        const Icon(
                      Icons.close,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding:
                      EdgeInsets.fromLTRB(
                    14,
                    4,
                    14,
                    30 + bottomInset,
                  ),
                  children: [
                    _sectionTitle(
                      '1. Change Identification',
                      Icons.change_circle_outlined,
                    ),
                    _textField(
                      _changeNoController,
                      'Change Management No.',
                      icon: Icons.numbers,
                      required: true,
                      hint: 'CM-001',
                    ),
                    _textField(
                      _changeReferenceController,
                      'Change Reference',
                      icon: Icons.link,
                    ),
                    _textField(
                      _projectController,
                      'Project',
                      icon: Icons.business_outlined,
                      required: true,
                    ),
                    _textField(
                      _locationController,
                      'Location',
                      icon: Icons.location_on_outlined,
                      required: true,
                    ),
                    _textField(
                      _departmentController,
                      'Department',
                      icon: Icons.account_tree_outlined,
                    ),
                    _textField(
                      _activityController,
                      'Activity / Work',
                      icon: Icons.work_outline,
                      required: true,
                    ),
                    _dropdownField(
                      'Change Type',
                      _changeType,
                      _changeTypes,
                      (value) {
                        if (value == null) {
                          return;
                        }

                        setState(() {
                          _changeType =
                              value;
                        });
                      },
                    ),
                    _dateField(
                      'Change Date',
                      _changeDate,
                      () {
                        _pickDate(
                          current:
                              _changeDate,
                          onSelected:
                              (date) {
                            setState(() {
                              _changeDate =
                                  date;
                            });
                          },
                        );
                      },
                      required: true,
                    ),
                    _textField(
                      _changeDescriptionController,
                      'Description of Change',
                      icon: Icons.description_outlined,
                      required: true,
                      maxLines: 4,
                    ),
                    _textField(
                      _reasonController,
                      'Reason for Change',
                      icon: Icons.help_outline,
                      required: true,
                      maxLines: 3,
                    ),

                    _sectionTitle(
                      '2. Existing Risk Reference',
                      Icons.warning_amber_outlined,
                    ),
                    _textField(
                      _riskReferenceController,
                      'Risk Reference',
                      icon: Icons.link,
                      hint:
                          'HIRA / JSA / JHA / RAMS / Risk Register No.',
                    ),
                    _textField(
                      _existingRiskController,
                      'Existing Risk / Controls',
                      icon: Icons.security_outlined,
                      maxLines: 4,
                    ),

                    _sectionTitle(
                      '3. Initial Risk Assessment',
                      Icons.assessment_outlined,
                    ),
                    _riskScoreCard(
                      title:
                          'Initial Risk Before Change Controls',
                      likelihood:
                          _initialLikelihoodController,
                      severity:
                          _initialSeverityController,
                      level:
                          _initialRiskLevel,
                      onCalculate:
                          _calculateInitialRisk,
                    ),

                    _sectionTitle(
                      '4. Risk Re-Assessment',
                      Icons.replay_circle_filled_outlined,
                    ),
                    _textField(
                      _additionalHazardsController,
                      'Additional Hazards',
                      icon: Icons.warning_outlined,
                      maxLines: 4,
                    ),
                    _textField(
                      _additionalControlsController,
                      'Additional Controls',
                      icon: Icons.shield_outlined,
                      maxLines: 5,
                    ),
                    SwitchListTile.adaptive(
                      contentPadding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 4,
                      ),
                      title:
                          const Text(
                        'Risk Re-Assessment Completed',
                        style:
                            TextStyle(
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                      subtitle:
                          const Text(
                        'The change has been reassessed after identifying new or changed risks.',
                        style:
                            TextStyle(
                          fontSize: 11,
                        ),
                      ),
                      value:
                          _riskReAssessmentCompleted,
                      activeThumbColor:
                          primaryGreen,
                      onChanged:
                          (value) {
                        setState(() {
                          _riskReAssessmentCompleted =
                              value;
                        });
                      },
                    ),
                    _riskScoreCard(
                      title:
                          'Residual Risk After Additional Controls',
                      likelihood:
                          _residualLikelihoodController,
                      severity:
                          _residualSeverityController,
                      level:
                          _residualRiskLevel,
                      onCalculate:
                          _calculateResidualRisk,
                    ),

                    _sectionTitle(
                      '5. Responsibility & Approval',
                      Icons.approval_outlined,
                    ),
                    _textField(
                      _responsibleController,
                      'Responsible Person',
                      icon: Icons.person_outline,
                      required: true,
                    ),
                    _dateField(
                      'Target Date',
                      _targetDate,
                      () {
                        _pickDate(
                          current:
                              _targetDate,
                          onSelected:
                              (date) {
                            setState(() {
                              _targetDate =
                                  date;
                            });
                          },
                        );
                      },
                      required: true,
                    ),
                    SwitchListTile.adaptive(
                      contentPadding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 4,
                      ),
                      title:
                          const Text(
                        'Approval Confirmed',
                        style:
                            TextStyle(
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                      value: _approved,
                      activeThumbColor:
                          primaryGreen,
                      onChanged:
                          (value) {
                        setState(() {
                          _approved =
                              value;
                        });
                      },
                    ),
                    _dateField(
                      'Approval Date',
                      _approvalDate,
                      () {
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
                        );
                      },
                    ),
                    _textField(
                      _approvalCommentsController,
                      'Approval Comments',
                      icon: Icons.comment_outlined,
                      maxLines: 3,
                    ),

                    _sectionTitle(
                      '6. Risk Communication',
                      Icons.campaign_outlined,
                    ),
                    SwitchListTile.adaptive(
                      contentPadding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 4,
                      ),
                      title:
                          const Text(
                        'Risk Communicated',
                        style:
                            TextStyle(
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                      subtitle:
                          const Text(
                        'Affected workers and relevant persons have been informed.',
                        style:
                            TextStyle(
                          fontSize: 11,
                        ),
                      ),
                      value:
                          _communicated,
                      activeThumbColor:
                          primaryGreen,
                      onChanged:
                          (value) {
                        setState(() {
                          _communicated =
                              value;
                        });
                      },
                    ),
                    _dateField(
                      'Communication Date',
                      _communicationDate,
                      () {
                        _pickDate(
                          current:
                              _communicationDate,
                          onSelected:
                              (date) {
                            setState(() {
                              _communicationDate =
                                  date;
                            });
                          },
                        );
                      },
                    ),
                    _textField(
                      _communicatedByController,
                      'Communicated By',
                      icon: Icons.person_outline,
                    ),
                    _textField(
                      _workerAcknowledgementController,
                      'Worker Acknowledgement / Participants',
                      icon: Icons.groups_outlined,
                      maxLines: 3,
                    ),

                    _sectionTitle(
                      '7. Implementation',
                      Icons.build_circle_outlined,
                    ),
                    _dropdownField(
                      'Implementation Status',
                      _implementationStatus,
                      _implementationStatuses,
                      (value) {
                        if (value == null) {
                          return;
                        }

                        setState(() {
                          _implementationStatus =
                              value;
                        });
                      },
                    ),
                    _dateField(
                      'Implementation Date',
                      _implementationDate,
                      () {
                        _pickDate(
                          current:
                              _implementationDate,
                          onSelected:
                              (date) {
                            setState(() {
                              _implementationDate =
                                  date;
                            });
                          },
                        );
                      },
                    ),

                    _sectionTitle(
                      '8. Monitoring & Effectiveness',
                      Icons.monitor_outlined,
                    ),
                    _dropdownField(
                      'Monitoring Status',
                      _monitoringStatus,
                      _monitoringStatuses,
                      (value) {
                        if (value == null) {
                          return;
                        }

                        setState(() {
                          _monitoringStatus =
                              value;
                        });
                      },
                    ),
                    _dateField(
                      'Monitoring Date',
                      _monitoringDate,
                      () {
                        _pickDate(
                          current:
                              _monitoringDate,
                          onSelected:
                              (date) {
                            setState(() {
                              _monitoringDate =
                                  date;
                            });
                          },
                        );
                      },
                    ),
                    _textField(
                      _monitoringCommentsController,
                      'Monitoring Comments',
                      icon: Icons.notes_outlined,
                      maxLines: 4,
                    ),
                    _dropdownField(
                      'Effectiveness',
                      _effectiveness,
                      _effectivenessValues,
                      (value) {
                        if (value == null) {
                          return;
                        }

                        setState(() {
                          _effectiveness =
                              value;
                        });
                      },
                    ),

                    _sectionTitle(
                      '9. Status & Closure',
                      Icons.assignment_turned_in_outlined,
                    ),
                    _dropdownField(
                      'Status',
                      _status,
                      _statuses,
                      (value) {
                        if (value == null) {
                          return;
                        }

                        setState(() {
                          _status =
                              value;
                        });
                      },
                    ),
                    _dateField(
                      'Closure Date',
                      _closureDate,
                      () {
                        _pickDate(
                          current:
                              _closureDate,
                          onSelected:
                              (date) {
                            setState(() {
                              _closureDate =
                                  date;
                            });
                          },
                        );
                      },
                    ),
                    _textField(
                      _remarksController,
                      'Remarks',
                      icon: Icons.notes_outlined,
                      maxLines: 4,
                    ),

                    const SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      height: 50,
                      child:
                          FilledButton.icon(
                        style:
                            FilledButton.styleFrom(
                          backgroundColor:
                              primaryGreen,
                          foregroundColor:
                              Colors.white,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              12,
                            ),
                          ),
                        ),
                        onPressed:
                            _submit,
                        icon: Icon(
                          _isEditing
                              ? Icons
                                  .save_outlined
                              : Icons
                                  .add_task_outlined,
                        ),
                        label: Text(
                          _isEditing
                              ? 'Update Record'
                              : 'Save Record',
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
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
}
