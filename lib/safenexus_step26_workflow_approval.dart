import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 26
/// HSE Workflow & Approval Control Center
///
/// Modules covered:
/// 26A Workflow Master
/// 26B Record Review & Approval
/// 26C HSE Document Approval
/// 26D Risk / RAMS Approval
/// 26E PTW Approval Workflow
/// 26F Training / Competency Approval
/// 26G Inspection / Audit Approval
/// 26H Incident / CAPA Approval
/// 26I Legal / Compliance Approval
/// 26J Management Approval
/// 26K Rejection / Revision / Re-submission
/// 26L Workflow History & Approval Intelligence
///
/// Core workflow:
/// Create -> Submit -> Review -> Changes Required -> Re-submit
/// -> Approve -> Active -> Review/Expiry -> Close
///
/// This file is intentionally self-contained. Existing SafeNexus HSE
/// modules are not modified by this file.

class SafeNexusStep26 extends StatefulWidget {
  const SafeNexusStep26({
    super.key,
    this.onOpenSourceRecord,
  });

  final void Function(String sourceModule, String recordReference)?
      onOpenSourceRecord;

  @override
  State<SafeNexusStep26> createState() => _SafeNexusStep26State();
}

class _SafeNexusStep26State extends State<SafeNexusStep26> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey = 'safenexus_hse_step26_workflows';

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _records = <Map<String, dynamic>>[];
  String _statusFilter = 'All';
  String _moduleFilter = 'All';
  String _priorityFilter = 'All';
  bool _showOverdueOnly = false;
  bool _loading = true;

  static const List<String> modules = <String>[
    '26A Workflow Master',
    '26B Record Review & Approval',
    '26C HSE Document Approval',
    '26D Risk / RAMS Approval',
    '26E PTW Approval Workflow',
    '26F Training / Competency Approval',
    '26G Inspection / Audit Approval',
    '26H Incident / CAPA Approval',
    '26I Legal / Compliance Approval',
    '26J Management Approval',
    '26K Rejection / Revision / Re-submission',
    '26L Workflow History & Approval Intelligence',
  ];

  static const List<String> statuses = <String>[
    'Draft',
    'Submitted',
    'Under Review',
    'Changes Required',
    'Re-submitted',
    'Approved',
    'Active',
    'Review Due',
    'Expired',
    'Closed',
    'Rejected',
    'Cancelled',
  ];

  static const List<String> priorities = <String>[
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static const List<String> approvalRoles = <String>[
    'Record Owner',
    'HSE Officer',
    'HSE Manager',
    'Project Manager',
    'Construction Manager',
    'Department Manager',
    'Client Representative',
    'Authorized Person',
    'Management',
    'Authority / Regulator',
    'Other',
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

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  DateTime? _parseDate(dynamic value) {
    if (value is! String || value.isEmpty) return null;
    return DateTime.tryParse(value);
  }

  bool _isOverdue(Map<String, dynamic> record) {
    final due = _parseDate(record['dueDate']);
    if (due == null) return false;
    final status = record['status']?.toString() ?? '';
    if (status == 'Approved' ||
        status == 'Active' ||
        status == 'Closed' ||
        status == 'Cancelled') {
      return false;
    }
    return due.isBefore(DateTime.now());
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchController.text.trim().toLowerCase();

    return _records.where((record) {
      final matchesSearch = query.isEmpty ||
          <dynamic>[
            record['workflowNo'],
            record['recordReference'],
            record['title'],
            record['project'],
            record['site'],
            record['owner'],
            record['reviewer'],
            record['approver'],
            record['sourceModule'],
          ].any(
            (value) => value.toString().toLowerCase().contains(query),
          );

      final matchesStatus = _statusFilter == 'All' ||
          record['status']?.toString() == _statusFilter;

      final matchesModule = _moduleFilter == 'All' ||
          record['sourceModule']?.toString() == _moduleFilter;

      final matchesPriority = _priorityFilter == 'All' ||
          record['priority']?.toString() == _priorityFilter;

      final matchesOverdue = !_showOverdueOnly || _isOverdue(record);

      return matchesSearch &&
          matchesStatus &&
          matchesModule &&
          matchesPriority &&
          matchesOverdue;
    }).toList()
      ..sort((a, b) {
        final aDate = _parseDate(a['updatedAt']) ??
            DateTime.fromMillisecondsSinceEpoch(0);
        final bDate = _parseDate(b['updatedAt']) ??
            DateTime.fromMillisecondsSinceEpoch(0);
        return bDate.compareTo(aDate);
      });
  }

  int _countWhere(bool Function(Map<String, dynamic>) test) {
    return _records.where(test).length;
  }

  int get _total => _records.length;

  int get _pending => _countWhere((record) {
        final status = record['status']?.toString() ?? '';
        return status == 'Submitted' ||
            status == 'Under Review' ||
            status == 'Re-submitted';
      });

  int get _changesRequired =>
      _countWhere((record) => record['status'] == 'Changes Required');

  int get _approved =>
      _countWhere((record) => record['status'] == 'Approved');

  int get _active => _countWhere((record) => record['status'] == 'Active');

  int get _overdue => _countWhere(_isOverdue);

  int get _critical => _countWhere(
        (record) => record['priority'] == 'Critical',
      );

  double get _approvalRate {
    if (_total == 0) return 0;
    final approvedOrActiveOrClosed = _countWhere((record) {
      final status = record['status']?.toString() ?? '';
      return status == 'Approved' ||
          status == 'Active' ||
          status == 'Closed';
    });
    return approvedOrActiveOrClosed * 100 / _total;
  }

  Future<void> _openForm({Map<String, dynamic>? existing}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _Step26FormSheet(
        existing: existing,
        modules: modules,
        statuses: statuses,
        priorities: priorities,
        approvalRoles: approvalRoles,
      ),
    );

    if (result == null) return;

    final now = DateTime.now().toIso8601String();
    if (existing == null) {
      result['id'] = DateTime.now().microsecondsSinceEpoch.toString();
      result['createdAt'] = now;
      result['updatedAt'] = now;
      _records.add(result);
    } else {
      final index = _records.indexWhere(
        (item) => item['id'] == existing['id'],
      );
      if (index >= 0) {
        result['id'] = existing['id'];
        result['createdAt'] = existing['createdAt'] ?? now;
        result['updatedAt'] = now;
        result['history'] = List<dynamic>.from(
          existing['history'] ?? <dynamic>[],
        )..add(<String, dynamic>{
            'action': 'Updated',
            'date': now,
            'user': result['updatedBy'] ?? result['owner'] ?? '',
            'status': result['status'],
            'comments': result['reviewComments'] ?? '',
          });
        _records[index] = result;
      }
    }

    await _saveRecords();
    if (mounted) setState(() {});
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete workflow?'),
        content: Text(
          'Delete ${record['workflowNo'] ?? 'this workflow'} permanently?',
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

  Future<void> _changeStatus(
    Map<String, dynamic> record,
    String newStatus,
  ) async {
    final now = DateTime.now().toIso8601String();
    final index = _records.indexWhere((item) => item['id'] == record['id']);
    if (index < 0) return;

    final updated = Map<String, dynamic>.from(_records[index]);
    updated['status'] = newStatus;
    updated['updatedAt'] = now;

    final history = List<dynamic>.from(updated['history'] ?? <dynamic>[]);
    history.add(<String, dynamic>{
      'action': newStatus,
      'date': now,
      'user': updated['updatedBy'] ?? updated['owner'] ?? '',
      'status': newStatus,
      'comments': updated['reviewComments'] ?? '',
    });
    updated['history'] = history;
    _records[index] = updated;

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
          initialChildSize: 0.86,
          maxChildSize: 0.96,
          minChildSize: 0.50,
          builder: (_, controller) => ListView(
            controller: controller,
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  const Icon(Icons.fact_check, color: darkGreen, size: 28),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      record['workflowNo']?.toString() ?? 'Workflow',
                      style: const TextStyle(
                        fontSize: 21,
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
              _detailSection('Workflow', [
                _detailRow('Module', record['sourceModule']),
                _detailRow('Record Reference', record['recordReference']),
                _detailRow('Title', record['title']),
                _detailRow('Project', record['project']),
                _detailRow('Site', record['site']),
                _detailRow('Location', record['location']),
                _detailRow('Priority', record['priority']),
                _detailRow('Status', record['status']),
                _detailRow('Current Stage', record['currentStage']),
              ]),
              _detailSection('Roles & Approval', [
                _detailRow('Owner', record['owner']),
                _detailRow('Reviewer', record['reviewer']),
                _detailRow('Reviewer Role', record['reviewerRole']),
                _detailRow('Approver', record['approver']),
                _detailRow('Approver Role', record['approverRole']),
                _detailRow('Approval Level', record['approvalLevel']),
                _detailRow('Due Date', record['dueDate']),
              ]),
              _detailSection('Review / Decision', [
                _detailRow('Review Comments', record['reviewComments']),
                _detailRow('Rejection Reason', record['rejectionReason']),
                _detailRow('Required Changes', record['requiredChanges']),
                _detailRow('Revision', record['revision']),
                _detailRow('Resubmission Date', record['resubmissionDate']),
                _detailRow('Conditions', record['conditions']),
                _detailRow('Evidence Reference', record['evidenceReference']),
              ]),
              _detailSection('Integration', [
                _detailRow('Risk / HIRA / JSA', record['riskReference']),
                _detailRow('RAMS', record['ramsReference']),
                _detailRow('PTW', record['ptwReference']),
                _detailRow('Training / Competency', record['trainingReference']),
                _detailRow('Audit / Inspection', record['auditReference']),
                _detailRow('Incident / CAPA', record['incidentReference']),
                _detailRow('Legal / Compliance', record['legalReference']),
              ]),
              if ((record['remarks'] ?? '').toString().trim().isNotEmpty)
                _detailSection('Remarks', [
                  _detailRow('Remarks', record['remarks']),
                ]),
              _detailSection('Workflow History', [
                if (history.isEmpty)
                  const Text('No workflow history recorded.')
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
              if (widget.onOpenSourceRecord != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onOpenSourceRecord!(
                        record['sourceModule']?.toString() ?? '',
                        record['recordReference']?.toString() ?? '',
                      );
                    },
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Open Source Record'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
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
          ...children,
        ],
      ),
    );
  }

  Widget _detailRow(String label, dynamic value) {
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
      case 'Approved':
      case 'Active':
      case 'Closed':
        return primaryGreen;
      case 'Changes Required':
      case 'Rejected':
      case 'Expired':
        return Colors.red;
      case 'Review Due':
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

  Widget _summaryCard(
    String label,
    String value,
    IconData icon, {
    Color? color,
  }) {
    final cardColor = color ?? darkGreen;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: cardColor.withValues(alpha: 0.10),
              child: Icon(icon, color: cardColor),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 3),
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

  Widget _filterDropdown({
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
              child: Text(item, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    final records = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Step 26 • Workflow & Approval'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _loadRecords,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('New Workflow'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadRecords,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 90),
                children: [
                  _buildHeader(),
                  const SizedBox(height: 10),
                  _buildSummary(),
                  const SizedBox(height: 10),
                  _buildSearchAndFilters(),
                  const SizedBox(height: 10),
                  _buildIntelligence(),
                  const SizedBox(height: 10),
                  if (records.isEmpty)
                    _buildEmptyState()
                  else
                    ...records.map(_buildRecordCard),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Card(
      color: darkGreen,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.approval,
                color: darkGreen,
                size: 30,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'HSE Workflow & Approval Control Center',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Create → Submit → Review → Approve → Active → Close',
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

  Widget _buildSummary() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.25,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: [
        _summaryCard('Total', '$_total', Icons.all_inbox),
        _summaryCard('Pending Review', '$_pending', Icons.pending_actions),
        _summaryCard(
          'Changes Required',
          '$_changesRequired',
          Icons.edit_note,
          color: Colors.orange,
        ),
        _summaryCard(
          'Approved',
          '$_approved',
          Icons.verified,
          color: primaryGreen,
        ),
        _summaryCard(
          'Active',
          '$_active',
          Icons.play_circle,
          color: primaryGreen,
        ),
        _summaryCard(
          'Overdue',
          '$_overdue',
          Icons.warning_amber,
          color: Colors.red,
        ),
        _summaryCard(
          'Critical',
          '$_critical',
          Icons.priority_high,
          color: Colors.red,
        ),
        _summaryCard(
          'Approval Rate',
          '${_approvalRate.toStringAsFixed(0)}%',
          Icons.insights,
          color: darkGreen,
        ),
      ],
    );
  }

  Widget _buildSearchAndFilters() {
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
                    'Search workflow, record, project, owner, reviewer...',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            _filterDropdown(
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
                  child: _filterDropdown(
                    value: _statusFilter,
                    items: <String>['All', ...statuses],
                    onChanged: (value) {
                      setState(() => _statusFilter = value ?? 'All');
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _filterDropdown(
                    value: _priorityFilter,
                    items: <String>['All', ...priorities],
                    onChanged: (value) {
                      setState(() => _priorityFilter = value ?? 'All');
                    },
                  ),
                ),
              ],
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

  Widget _buildIntelligence() {
    final changes = _changesRequired;
    final overdue = _overdue;
    final critical = _critical;

    String message;
    IconData icon;

    if (critical > 0) {
      message =
          'Critical approval items require management attention.';
      icon = Icons.priority_high;
    } else if (overdue > 0) {
      message = 'Overdue workflow approvals need immediate follow-up.';
      icon = Icons.warning_amber;
    } else if (changes > 0) {
      message =
          'Some records require revision before they can be approved.';
      icon = Icons.edit_note;
    } else if (_pending > 0) {
      message = 'Pending approvals are ready for reviewer action.';
      icon = Icons.pending_actions;
    } else {
      message = 'Workflow center is currently under control.';
      icon = Icons.check_circle;
    }

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: darkGreen.withValues(alpha: 0.10),
          child: Icon(icon, color: darkGreen),
        ),
        title: const Text(
          'Approval Intelligence',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(message),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Icon(
              Icons.fact_check_outlined,
              size: 54,
              color: darkGreen.withValues(alpha: 0.45),
            ),
            const SizedBox(height: 10),
            const Text(
              'No workflow records found',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create a workflow to start the review and approval cycle.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            FilledButton.icon(
              onPressed: () => _openForm(),
              icon: const Icon(Icons.add),
              label: const Text('Create Workflow'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordCard(Map<String, dynamic> record) {
    final status = record['status']?.toString() ?? 'Draft';
    final priority = record['priority']?.toString() ?? 'Medium';
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
                      record['workflowNo']?.toString() ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                      ),
                    ),
                  ),
                  _tag(status, _statusColor(status)),
                  const SizedBox(width: 6),
                  _tag(priority, _priorityColor(priority)),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                record['title']?.toString() ?? 'Untitled workflow',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(record['sourceModule']?.toString() ?? ''),
              const SizedBox(height: 7),
              Wrap(
                spacing: 12,
                runSpacing: 5,
                children: [
                  if ((record['recordReference'] ?? '')
                      .toString()
                      .trim()
                      .isNotEmpty)
                    Text('Ref: ${record['recordReference']}'),
                  if ((record['project'] ?? '').toString().trim().isNotEmpty)
                    Text('Project: ${record['project']}'),
                  if ((record['owner'] ?? '').toString().trim().isNotEmpty)
                    Text('Owner: ${record['owner']}'),
                  if ((record['dueDate'] ?? '').toString().trim().isNotEmpty)
                    Text('Due: ${record['dueDate']}'),
                ],
              ),
              if (overdue)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    '• OVERDUE',
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const Divider(height: 18),
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
                    tooltip: 'Workflow action',
                    onSelected: (value) => _changeStatus(record, value),
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: 'Submitted',
                        child: Text('Submit'),
                      ),
                      PopupMenuItem(
                        value: 'Under Review',
                        child: Text('Start Review'),
                      ),
                      PopupMenuItem(
                        value: 'Changes Required',
                        child: Text('Request Changes'),
                      ),
                      PopupMenuItem(
                        value: 'Re-submitted',
                        child: Text('Re-submit'),
                      ),
                      PopupMenuItem(
                        value: 'Approved',
                        child: Text('Approve'),
                      ),
                      PopupMenuItem(
                        value: 'Active',
                        child: Text('Set Active'),
                      ),
                      PopupMenuItem(
                        value: 'Review Due',
                        child: Text('Mark Review Due'),
                      ),
                      PopupMenuItem(
                        value: 'Closed',
                        child: Text('Close'),
                      ),
                      PopupMenuItem(
                        value: 'Rejected',
                        child: Text('Reject'),
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
}

class _Step26FormSheet extends StatefulWidget {
  const _Step26FormSheet({
    required this.existing,
    required this.modules,
    required this.statuses,
    required this.priorities,
    required this.approvalRoles,
  });

  final Map<String, dynamic>? existing;
  final List<String> modules;
  final List<String> statuses;
  final List<String> priorities;
  final List<String> approvalRoles;

  @override
  State<_Step26FormSheet> createState() => _Step26FormSheetState();
}

class _Step26FormSheetState extends State<_Step26FormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController workflowNo;
  late final TextEditingController recordReference;
  late final TextEditingController title;
  late final TextEditingController project;
  late final TextEditingController site;
  late final TextEditingController location;
  late final TextEditingController owner;
  late final TextEditingController reviewer;
  late final TextEditingController approver;
  late final TextEditingController approvalLevel;
  late final TextEditingController dueDate;
  late final TextEditingController reviewComments;
  late final TextEditingController rejectionReason;
  late final TextEditingController requiredChanges;
  late final TextEditingController revision;
  late final TextEditingController resubmissionDate;
  late final TextEditingController conditions;
  late final TextEditingController evidenceReference;
  late final TextEditingController riskReference;
  late final TextEditingController ramsReference;
  late final TextEditingController ptwReference;
  late final TextEditingController trainingReference;
  late final TextEditingController auditReference;
  late final TextEditingController incidentReference;
  late final TextEditingController legalReference;
  late final TextEditingController remarks;
  late final TextEditingController updatedBy;

  late String sourceModule;
  late String status;
  late String priority;
  late String reviewerRole;
  late String approverRole;
  late String currentStage;

  @override
  void initState() {
    super.initState();
    final r = widget.existing ?? <String, dynamic>{};

    workflowNo = _controller(r, 'workflowNo');
    recordReference = _controller(r, 'recordReference');
    title = _controller(r, 'title');
    project = _controller(r, 'project');
    site = _controller(r, 'site');
    location = _controller(r, 'location');
    owner = _controller(r, 'owner');
    reviewer = _controller(r, 'reviewer');
    approver = _controller(r, 'approver');
    approvalLevel = _controller(r, 'approvalLevel');
    dueDate = _controller(r, 'dueDate');
    reviewComments = _controller(r, 'reviewComments');
    rejectionReason = _controller(r, 'rejectionReason');
    requiredChanges = _controller(r, 'requiredChanges');
    revision = _controller(r, 'revision', fallback: 'Rev 0');
    resubmissionDate = _controller(r, 'resubmissionDate');
    conditions = _controller(r, 'conditions');
    evidenceReference = _controller(r, 'evidenceReference');
    riskReference = _controller(r, 'riskReference');
    ramsReference = _controller(r, 'ramsReference');
    ptwReference = _controller(r, 'ptwReference');
    trainingReference = _controller(r, 'trainingReference');
    auditReference = _controller(r, 'auditReference');
    incidentReference = _controller(r, 'incidentReference');
    legalReference = _controller(r, 'legalReference');
    remarks = _controller(r, 'remarks');
    updatedBy = _controller(r, 'updatedBy');

    sourceModule = _validValue(
      r['sourceModule'],
      widget.modules,
      widget.modules.first,
    );
    status = _validValue(r['status'], widget.statuses, 'Draft');
    priority = _validValue(r['priority'], widget.priorities, 'Medium');
    reviewerRole = _validValue(
      r['reviewerRole'],
      widget.approvalRoles,
      'HSE Officer',
    );
    approverRole = _validValue(
      r['approverRole'],
      widget.approvalRoles,
      'HSE Manager',
    );
    currentStage = _validValue(
      r['currentStage'],
      const [
        'Create',
        'Submit',
        'Review',
        'Changes Required',
        'Re-submit',
        'Approve',
        'Active',
        'Review / Expiry',
        'Close',
      ],
      'Create',
    );
  }

  TextEditingController _controller(
    Map<String, dynamic> record,
    String key, {
    String fallback = '',
  }) {
    return TextEditingController(
      text: record[key]?.toString().isNotEmpty == true
          ? record[key].toString()
          : fallback,
    );
  }

  String _validValue(
    dynamic value,
    List<String> allowed,
    String fallback,
  ) {
    final text = value?.toString() ?? '';
    return allowed.contains(text) ? text : fallback;
  }

  @override
  void dispose() {
    for (final controller in [
      workflowNo,
      recordReference,
      title,
      project,
      site,
      location,
      owner,
      reviewer,
      approver,
      approvalLevel,
      dueDate,
      reviewComments,
      rejectionReason,
      requiredChanges,
      revision,
      resubmissionDate,
      conditions,
      evidenceReference,
      riskReference,
      ramsReference,
      ptwReference,
      trainingReference,
      auditReference,
      incidentReference,
      legalReference,
      remarks,
      updatedBy,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  InputDecoration _decoration(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: const OutlineInputBorder(),
      isDense: true,
    );
  }

  Widget _textField(
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

  Future<void> _pickDate(TextEditingController controller) async {
    final initial = DateTime.tryParse(controller.text) ?? DateTime.now();
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final due = DateTime.tryParse(dueDate.text.trim());
    final resubmit = DateTime.tryParse(resubmissionDate.text.trim());

    if (dueDate.text.trim().isNotEmpty && due == null) {
      _showError('Due Date must use YYYY-MM-DD format.');
      return;
    }

    if (resubmissionDate.text.trim().isNotEmpty && resubmit == null) {
      _showError('Resubmission Date must use YYYY-MM-DD format.');
      return;
    }

    if (status == 'Approved' &&
        approver.text.trim().isEmpty) {
      _showError('Approver is required for Approved status.');
      return;
    }

    if ((status == 'Changes Required' || status == 'Rejected') &&
        reviewComments.text.trim().isEmpty &&
        rejectionReason.text.trim().isEmpty &&
        requiredChanges.text.trim().isEmpty) {
      _showError(
        'Add review comments, rejection reason, or required changes.',
      );
      return;
    }

    final record = <String, dynamic>{
      'workflowNo': workflowNo.text.trim(),
      'recordReference': recordReference.text.trim(),
      'title': title.text.trim(),
      'project': project.text.trim(),
      'site': site.text.trim(),
      'location': location.text.trim(),
      'sourceModule': sourceModule,
      'priority': priority,
      'status': status,
      'currentStage': currentStage,
      'owner': owner.text.trim(),
      'reviewer': reviewer.text.trim(),
      'reviewerRole': reviewerRole,
      'approver': approver.text.trim(),
      'approverRole': approverRole,
      'approvalLevel': approvalLevel.text.trim(),
      'dueDate': dueDate.text.trim(),
      'reviewComments': reviewComments.text.trim(),
      'rejectionReason': rejectionReason.text.trim(),
      'requiredChanges': requiredChanges.text.trim(),
      'revision': revision.text.trim(),
      'resubmissionDate': resubmissionDate.text.trim(),
      'conditions': conditions.text.trim(),
      'evidenceReference': evidenceReference.text.trim(),
      'riskReference': riskReference.text.trim(),
      'ramsReference': ramsReference.text.trim(),
      'ptwReference': ptwReference.text.trim(),
      'trainingReference': trainingReference.text.trim(),
      'auditReference': auditReference.text.trim(),
      'incidentReference': incidentReference.text.trim(),
      'legalReference': legalReference.text.trim(),
      'remarks': remarks.text.trim(),
      'updatedBy': updatedBy.text.trim(),
    };

    Navigator.pop(context, record);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleText = widget.existing == null
        ? 'Create HSE Workflow'
        : 'Edit HSE Workflow';

    return SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.90,
        maxChildSize: 0.98,
        minChildSize: 0.60,
        builder: (_, scrollController) => Material(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
              children: [
                Row(
                  children: [
                    const Icon(Icons.fact_check, color: darkGreen),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        titleText,
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
                const SizedBox(height: 10),
                _textField(
                  workflowNo,
                  'Workflow No.',
                  required: true,
                ),
                _textField(
                  recordReference,
                  'Record Reference',
                  required: true,
                ),
                _textField(title, 'Workflow / Record Title', required: true),
                _dropdown(
                  'Source Module',
                  sourceModule,
                  widget.modules,
                  (value) => setState(
                    () => sourceModule = value ?? sourceModule,
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
                  'Status',
                  status,
                  widget.statuses,
                  (value) => setState(
                    () => status = value ?? status,
                  ),
                ),
                _dropdown(
                  'Current Stage',
                  currentStage,
                  const [
                    'Create',
                    'Submit',
                    'Review',
                    'Changes Required',
                    'Re-submit',
                    'Approve',
                    'Active',
                    'Review / Expiry',
                    'Close',
                  ],
                  (value) => setState(
                    () => currentStage = value ?? currentStage,
                  ),
                ),
                _textField(project, 'Project'),
                _textField(site, 'Site'),
                _textField(location, 'Location'),
                _textField(owner, 'Record Owner', required: true),
                _textField(reviewer, 'Reviewer'),
                _dropdown(
                  'Reviewer Role',
                  reviewerRole,
                  widget.approvalRoles,
                  (value) => setState(
                    () => reviewerRole = value ?? reviewerRole,
                  ),
                ),
                _textField(approver, 'Approver'),
                _dropdown(
                  'Approver Role',
                  approverRole,
                  widget.approvalRoles,
                  (value) => setState(
                    () => approverRole = value ?? approverRole,
                  ),
                ),
                _textField(approvalLevel, 'Approval Level'),
                _dateField('Due Date', dueDate),
                _textField(
                  reviewComments,
                  'Review Comments',
                  maxLines: 3,
                ),
                _textField(
                  rejectionReason,
                  'Rejection Reason',
                  maxLines: 3,
                ),
                _textField(
                  requiredChanges,
                  'Required Changes',
                  maxLines: 3,
                ),
                _textField(revision, 'Revision'),
                _dateField('Resubmission Date', resubmissionDate),
                _textField(
                  conditions,
                  'Approval Conditions',
                  maxLines: 3,
                ),
                _textField(
                  evidenceReference,
                  'Evidence / Document Reference',
                ),
                const SizedBox(height: 4),
                const Text(
                  'Integration References',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                _textField(riskReference, 'Risk / HIRA / JSA Reference'),
                _textField(ramsReference, 'RAMS Reference'),
                _textField(ptwReference, 'PTW Reference'),
                _textField(
                  trainingReference,
                  'Training / Competency Reference',
                ),
                _textField(
                  auditReference,
                  'Audit / Inspection Reference',
                ),
                _textField(
                  incidentReference,
                  'Incident / CAPA Reference',
                ),
                _textField(
                  legalReference,
                  'Legal / Compliance Reference',
                ),
                _textField(
                  remarks,
                  'Remarks',
                  maxLines: 3,
                ),
                _textField(updatedBy, 'Updated / Actioned By'),
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
                    widget.existing == null
                        ? 'Save Workflow'
                        : 'Update Workflow',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dateField(String label, TextEditingController controller) {
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
}
