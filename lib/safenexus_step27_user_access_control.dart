import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 27
/// HSE User, Role & Access Control Center
///
/// Modules:
/// 27A User Master Register
/// 27B User Role Management
/// 27C HSE Role & Responsibility Mapping
/// 27D Module Access / Permission Control
/// 27E Project & Site Access
/// 27F Approval Authority Matrix
/// 27G User Activation / Suspension / Deactivation
/// 27H Login / Session / Security Control
/// 27I Access Change Request & Approval
/// 27J User Activity / Audit Log
/// 27K Access Review & Recertification
/// 27L Security & Access Intelligence Dashboard
///
/// Core flow:
/// User Created -> Role Assigned -> Project/Site Assigned -> Permissions Assigned
/// -> Approval Authority -> Active -> Periodic Access Review -> Suspend/Deactivate
///
/// This is a local user/access administration register. It does not implement
/// password authentication, encryption, server-side authorization, or identity
/// provider integration. Those controls should be added at production backend
/// level when required.

class SafeNexusStep27 extends StatefulWidget {
  const SafeNexusStep27({
    super.key,
    this.onOpenSourceRecord,
  });

  final void Function(String module, String reference)? onOpenSourceRecord;

  @override
  State<SafeNexusStep27> createState() => _SafeNexusStep27State();
}

class _SafeNexusStep27State extends State<SafeNexusStep27> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey = 'safenexus_hse_step27_user_access';

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _records = <Map<String, dynamic>>[];
  bool _loading = true;
  String _statusFilter = 'All';
  String _roleFilter = 'All';
  String _accessFilter = 'All';
  bool _showOverdueOnly = false;

  static const List<String> roles = <String>[
    'Administrator',
    'HSE Manager',
    'HSE Officer',
    'HSE Supervisor',
    'Project Manager',
    'Construction Manager',
    'Site Manager',
    'Department Manager',
    'Supervisor',
    'Authorized Person',
    'Permit Issuer',
    'Permit Receiver',
    'Auditor',
    'Inspector',
    'Training Coordinator',
    'Document Controller',
    'Worker',
    'Client Representative',
    'Management',
    'Viewer',
    'Other',
  ];

  static const List<String> statuses = <String>[
    'Pending',
    'Active',
    'Pending Approval',
    'Suspended',
    'Deactivated',
    'Expired',
    'Revoked',
    'Under Review',
  ];

  static const List<String> accessLevels = <String>[
    'Full',
    'Create / Edit',
    'Review / Approve',
    'View Only',
    'No Access',
  ];

  static const List<String> approvalLevels = <String>[
    'Level 1 - Supervisor',
    'Level 2 - HSE / Department',
    'Level 3 - Project Management',
    'Level 4 - Senior Management',
    'Level 5 - Client / Authority',
    'Not Applicable',
  ];

  static const List<String> accessReviewStatuses = <String>[
    'Not Reviewed',
    'Scheduled',
    'Reviewed - Retain',
    'Reviewed - Modify',
    'Reviewed - Revoke',
    'Overdue',
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

  DateTime? _date(dynamic value) {
    if (value is! String || value.trim().isEmpty) return null;
    return DateTime.tryParse(value);
  }

  bool _isOverdue(Map<String, dynamic> record) {
    final due = _date(record['reviewDueDate']);
    if (due == null) return false;

    final status = record['status']?.toString() ?? '';
    if (status == 'Deactivated' ||
        status == 'Revoked' ||
        status == 'Expired') {
      return false;
    }

    final review = record['accessReviewStatus']?.toString() ?? '';
    return due.isBefore(DateTime.now()) && review != 'Reviewed - Retain';
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchController.text.trim().toLowerCase();

    final result = _records.where((record) {
      final matchesSearch = query.isEmpty ||
          <dynamic>[
            record['userNo'],
            record['userName'],
            record['employeeId'],
            record['email'],
            record['company'],
            record['project'],
            record['site'],
            record['department'],
            record['jobTitle'],
            record['role'],
            record['reference'],
          ].any(
            (value) => value.toString().toLowerCase().contains(query),
          );

      final matchesStatus =
          _statusFilter == 'All' || record['status'] == _statusFilter;

      final matchesRole =
          _roleFilter == 'All' || record['role'] == _roleFilter;

      final matchesAccess =
          _accessFilter == 'All' || record['accessLevel'] == _accessFilter;

      final matchesOverdue =
          !_showOverdueOnly || _isOverdue(record);

      return matchesSearch &&
          matchesStatus &&
          matchesRole &&
          matchesAccess &&
          matchesOverdue;
    }).toList();

    result.sort((a, b) {
      final aDate =
          _date(a['updatedAt']) ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bDate =
          _date(b['updatedAt']) ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bDate.compareTo(aDate);
    });

    return result;
  }

  int _count(bool Function(Map<String, dynamic>) test) =>
      _records.where(test).length;

  int get _total => _records.length;

  int get _active => _count((r) => r['status'] == 'Active');

  int get _pending => _count(
        (r) =>
            r['status'] == 'Pending' ||
            r['status'] == 'Pending Approval',
      );

  int get _suspended =>
      _count((r) => r['status'] == 'Suspended');

  int get _overdue => _count(_isOverdue);

  int get _fullAccess =>
      _count((r) => r['accessLevel'] == 'Full');

  int get _reviewDue => _count(
        (r) =>
            r['accessReviewStatus'] == 'Scheduled' ||
            r['accessReviewStatus'] == 'Overdue',
      );

  int get _criticalAccess => _count(
        (r) =>
            r['priority'] == 'Critical' &&
            r['status'] == 'Active',
      );

  double get _activeRate =>
      _total == 0 ? 0 : _active * 100 / _total;

  Future<void> _openForm({
    Map<String, dynamic>? existing,
  }) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _Step27FormSheet(
        existing: existing,
        roles: roles,
        statuses: statuses,
        accessLevels: accessLevels,
        approvalLevels: approvalLevels,
        accessReviewStatuses: accessReviewStatuses,
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
          'comments': 'User/access record created.',
        },
      ];
      _records.add(result);
    } else {
      final index = _records.indexWhere(
        (item) => item['id'] == existing['id'],
      );

      if (index >= 0) {
        result['id'] = existing['id'];
        result['createdAt'] = existing['createdAt'] ?? now;
        result['updatedAt'] = now;

        final history = List<dynamic>.from(
          existing['history'] ?? <dynamic>[],
        );
        history.add(<String, dynamic>{
          'action': 'Updated',
          'date': now,
          'user': result['updatedBy'] ?? '',
          'status': result['status'],
          'comments': result['accessChangeReason'] ?? '',
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
    final index = _records.indexWhere(
      (item) => item['id'] == record['id'],
    );
    if (index < 0) return;

    final now = DateTime.now().toIso8601String();
    final updated = Map<String, dynamic>.from(_records[index]);
    updated['status'] = status;
    updated['updatedAt'] = now;

    final history = List<dynamic>.from(
      updated['history'] ?? <dynamic>[],
    );
    history.add(<String, dynamic>{
      'action': status,
      'date': now,
      'user': updated['updatedBy'] ?? updated['userName'] ?? '',
      'status': status,
      'comments': updated['accessChangeReason'] ?? '',
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
        title: const Text('Delete access record?'),
        content: Text(
          'Delete ${record['userName'] ?? 'this user'} access record?',
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
          initialChildSize: 0.88,
          maxChildSize: 0.97,
          minChildSize: 0.55,
          builder: (_, controller) => ListView(
            controller: controller,
            padding: const EdgeInsets.all(18),
            children: [
              Row(
                children: [
                  const Icon(Icons.admin_panel_settings,
                      color: darkGreen, size: 28),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      record['userName']?.toString() ?? 'User Access',
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
              _section('User Identity', [
                _row('User No.', record['userNo']),
                _row('Employee ID', record['employeeId']),
                _row('Name', record['userName']),
                _row('Email', record['email']),
                _row('Mobile', record['mobile']),
                _row('Company', record['company']),
                _row('Job Title', record['jobTitle']),
                _row('Department', record['department']),
              ]),
              _section('Role & Access', [
                _row('Role', record['role']),
                _row('Access Level', record['accessLevel']),
                _row('Access Scope', record['accessScope']),
                _row('Modules', record['modulePermissions']),
                _row('Project', record['project']),
                _row('Site', record['site']),
                _row('Area', record['area']),
              ]),
              _section('Approval Authority', [
                _row('Approval Level', record['approvalLevel']),
                _row('Authority Scope', record['authorityScope']),
                _row('Appointed By', record['appointedBy']),
                _row('Approved By', record['approvedBy']),
                _row('Approval Reference', record['approvalReference']),
              ]),
              _section('Lifecycle & Security', [
                _row('Status', record['status']),
                _row('Created Date', record['createdDate']),
                _row('Effective Date', record['effectiveDate']),
                _row('Access Expiry', record['accessExpiryDate']),
                _row('Last Review', record['lastReviewDate']),
                _row('Review Due', record['reviewDueDate']),
                _row('Review Status', record['accessReviewStatus']),
                _row('Change Request', record['changeRequestReference']),
                _row('Change Reason', record['accessChangeReason']),
              ]),
              _section('Audit / Notes', [
                _row('Reference', record['reference']),
                _row('Updated By', record['updatedBy']),
                _row('Remarks', record['remarks']),
              ]),
              _section(
                'User Activity / Audit History',
                history.isEmpty
                    ? [const Text('No history recorded.')]
                    : history
                        .map(
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
                        )
                        .toList(),
              ),
              if (widget.onOpenSourceRecord != null)
                FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onOpenSourceRecord!(
                      '27 User Access',
                      record['reference']?.toString() ?? '',
                    );
                  },
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Open Related Record'),
                ),
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
      case 'Active':
        return primaryGreen;
      case 'Suspended':
      case 'Expired':
      case 'Revoked':
      case 'Deactivated':
        return Colors.red;
      case 'Pending':
      case 'Pending Approval':
      case 'Under Review':
        return Colors.orange;
      default:
        return Colors.blueGrey;
    }
  }

  Color _accessColor(String access) {
    switch (access) {
      case 'Full':
        return Colors.red;
      case 'Create / Edit':
      case 'Review / Approve':
        return Colors.orange;
      case 'View Only':
        return primaryGreen;
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

  @override
  Widget build(BuildContext context) {
    final records = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Step 27 • User & Access Control'),
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
        icon: const Icon(Icons.person_add),
        label: const Text('New User'),
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
                  _filters(),
                  const SizedBox(height: 10),
                  _intelligence(),
                  const SizedBox(height: 10),
                  if (records.isEmpty)
                    _empty()
                  else
                    ...records.map(_recordCard),
                ],
              ),
            ),
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
                Icons.admin_panel_settings,
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
                    'HSE User, Role & Access Control Center',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Users • Roles • Permissions • Authority • Access Review',
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
        _summaryCard('Total Users', '$_total', Icons.people),
        _summaryCard('Active', '$_active', Icons.verified_user,
            color: primaryGreen),
        _summaryCard('Pending', '$_pending', Icons.pending_actions,
            color: Colors.orange),
        _summaryCard('Suspended', '$_suspended', Icons.pause_circle,
            color: Colors.red),
        _summaryCard('Review Due', '$_reviewDue', Icons.event_repeat,
            color: Colors.orange),
        _summaryCard('Overdue', '$_overdue', Icons.warning_amber,
            color: Colors.red),
        _summaryCard('Full Access', '$_fullAccess', Icons.security,
            color: Colors.red),
        _summaryCard(
          'Active Rate',
          '${_activeRate.toStringAsFixed(0)}%',
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
                    'Search user, ID, company, project, role, reference...',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 9),
            _dropdown(
              value: _roleFilter,
              items: <String>['All', ...roles],
              onChanged: (value) {
                setState(() => _roleFilter = value ?? 'All');
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
                    value: _accessFilter,
                    items: <String>['All', ...accessLevels],
                    onChanged: (value) {
                      setState(() => _accessFilter = value ?? 'All');
                    },
                  ),
                ),
              ],
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Show overdue access reviews only'),
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

    if (_criticalAccess > 0) {
      message =
          'Critical active access requires management attention.';
      icon = Icons.priority_high;
    } else if (_overdue > 0) {
      message =
          'Access reviews are overdue and should be completed.';
      icon = Icons.warning_amber;
    } else if (_suspended > 0) {
      message =
          'Suspended users should be checked against current deployment needs.';
      icon = Icons.pause_circle;
    } else if (_pending > 0) {
      message =
          'Pending user/access approvals require responsible action.';
      icon = Icons.pending_actions;
    } else {
      message = 'User access records are currently under control.';
      icon = Icons.check_circle;
    }

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: darkGreen.withValues(alpha: 0.10),
          child: Icon(icon, color: darkGreen),
        ),
        title: const Text(
          'Security & Access Intelligence',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(message),
      ),
    );
  }

  Widget _empty() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Icon(
              Icons.people_outline,
              size: 55,
              color: darkGreen.withValues(alpha: 0.45),
            ),
            const SizedBox(height: 10),
            const Text(
              'No user access records found',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create a user record to start access and authority control.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            FilledButton.icon(
              onPressed: () => _openForm(),
              icon: const Icon(Icons.person_add),
              label: const Text('Create User'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recordCard(Map<String, dynamic> record) {
    final status = record['status']?.toString() ?? 'Pending';
    final access = record['accessLevel']?.toString() ?? 'View Only';
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
                      record['userNo']?.toString() ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                      ),
                    ),
                  ),
                  _tag(status, _statusColor(status)),
                  const SizedBox(width: 5),
                  _tag(access, _accessColor(access)),
                ],
              ),
              const SizedBox(height: 7),
              Text(
                record['userName']?.toString() ?? 'Unnamed User',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '${record['role'] ?? ''} • ${record['company'] ?? ''}',
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 12,
                runSpacing: 5,
                children: [
                  if ((record['employeeId'] ?? '').toString().isNotEmpty)
                    Text('ID: ${record['employeeId']}'),
                  if ((record['project'] ?? '').toString().isNotEmpty)
                    Text('Project: ${record['project']}'),
                  if ((record['site'] ?? '').toString().isNotEmpty)
                    Text('Site: ${record['site']}'),
                  if ((record['reviewDueDate'] ?? '').toString().isNotEmpty)
                    Text('Review: ${record['reviewDueDate']}'),
                ],
              ),
              if (overdue)
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Text(
                    '• OVERDUE ACCESS REVIEW',
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
                    tooltip: 'User status',
                    onSelected: (value) => _changeStatus(record, value),
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: 'Active',
                        child: Text('Activate'),
                      ),
                      PopupMenuItem(
                        value: 'Pending Approval',
                        child: Text('Pending Approval'),
                      ),
                      PopupMenuItem(
                        value: 'Suspended',
                        child: Text('Suspend'),
                      ),
                      PopupMenuItem(
                        value: 'Deactivated',
                        child: Text('Deactivate'),
                      ),
                      PopupMenuItem(
                        value: 'Revoked',
                        child: Text('Revoke Access'),
                      ),
                      PopupMenuItem(
                        value: 'Under Review',
                        child: Text('Under Review'),
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
}

class _Step27FormSheet extends StatefulWidget {
  const _Step27FormSheet({
    required this.existing,
    required this.roles,
    required this.statuses,
    required this.accessLevels,
    required this.approvalLevels,
    required this.accessReviewStatuses,
  });

  final Map<String, dynamic>? existing;
  final List<String> roles;
  final List<String> statuses;
  final List<String> accessLevels;
  final List<String> approvalLevels;
  final List<String> accessReviewStatuses;

  @override
  State<_Step27FormSheet> createState() => _Step27FormSheetState();
}

class _Step27FormSheetState extends State<_Step27FormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController userNo;
  late final TextEditingController userName;
  late final TextEditingController employeeId;
  late final TextEditingController email;
  late final TextEditingController mobile;
  late final TextEditingController company;
  late final TextEditingController jobTitle;
  late final TextEditingController department;
  late final TextEditingController project;
  late final TextEditingController site;
  late final TextEditingController area;
  late final TextEditingController accessScope;
  late final TextEditingController modulePermissions;
  late final TextEditingController authorityScope;
  late final TextEditingController appointedBy;
  late final TextEditingController approvedBy;
  late final TextEditingController approvalReference;
  late final TextEditingController createdDate;
  late final TextEditingController effectiveDate;
  late final TextEditingController accessExpiryDate;
  late final TextEditingController lastReviewDate;
  late final TextEditingController reviewDueDate;
  late final TextEditingController changeRequestReference;
  late final TextEditingController accessChangeReason;
  late final TextEditingController reference;
  late final TextEditingController updatedBy;
  late final TextEditingController remarks;

  late String role;
  late String status;
  late String accessLevel;
  late String approvalLevel;
  late String accessReviewStatus;

  @override
  void initState() {
    super.initState();

    final r = widget.existing ?? <String, dynamic>{};

    userNo = _controller(r, 'userNo');
    userName = _controller(r, 'userName');
    employeeId = _controller(r, 'employeeId');
    email = _controller(r, 'email');
    mobile = _controller(r, 'mobile');
    company = _controller(r, 'company');
    jobTitle = _controller(r, 'jobTitle');
    department = _controller(r, 'department');
    project = _controller(r, 'project');
    site = _controller(r, 'site');
    area = _controller(r, 'area');
    accessScope = _controller(r, 'accessScope');
    modulePermissions = _controller(r, 'modulePermissions');
    authorityScope = _controller(r, 'authorityScope');
    appointedBy = _controller(r, 'appointedBy');
    approvedBy = _controller(r, 'approvedBy');
    approvalReference = _controller(r, 'approvalReference');
    createdDate = _controller(r, 'createdDate');
    effectiveDate = _controller(r, 'effectiveDate');
    accessExpiryDate = _controller(r, 'accessExpiryDate');
    lastReviewDate = _controller(r, 'lastReviewDate');
    reviewDueDate = _controller(r, 'reviewDueDate');
    changeRequestReference = _controller(r, 'changeRequestReference');
    accessChangeReason = _controller(r, 'accessChangeReason');
    reference = _controller(r, 'reference');
    updatedBy = _controller(r, 'updatedBy');
    remarks = _controller(r, 'remarks');

    role = _valid(
      r['role'],
      widget.roles,
      'Viewer',
    );
    status = _valid(
      r['status'],
      widget.statuses,
      'Pending',
    );
    accessLevel = _valid(
      r['accessLevel'],
      widget.accessLevels,
      'View Only',
    );
    approvalLevel = _valid(
      r['approvalLevel'],
      widget.approvalLevels,
      'Not Applicable',
    );
    accessReviewStatus = _valid(
      r['accessReviewStatus'],
      widget.accessReviewStatuses,
      'Not Reviewed',
    );
  }

  TextEditingController _controller(
    Map<String, dynamic> record,
    String key,
  ) {
    return TextEditingController(
      text: record[key]?.toString() ?? '',
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
      userNo,
      userName,
      employeeId,
      email,
      mobile,
      company,
      jobTitle,
      department,
      project,
      site,
      area,
      accessScope,
      modulePermissions,
      authorityScope,
      appointedBy,
      approvedBy,
      approvalReference,
      createdDate,
      effectiveDate,
      accessExpiryDate,
      lastReviewDate,
      reviewDueDate,
      changeRequestReference,
      accessChangeReason,
      reference,
      updatedBy,
      remarks,
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
      MapEntry('Created Date', createdDate),
      MapEntry('Effective Date', effectiveDate),
      MapEntry('Access Expiry Date', accessExpiryDate),
      MapEntry('Last Review Date', lastReviewDate),
      MapEntry('Review Due Date', reviewDueDate),
    ];

    for (final entry in dateFields) {
      if (!_validDate(entry.value.text)) {
        _error('${entry.key} must use YYYY-MM-DD format.');
        return;
      }
    }

    final expiry = DateTime.tryParse(accessExpiryDate.text.trim());
    final effective = DateTime.tryParse(effectiveDate.text.trim());

    if (expiry != null &&
        effective != null &&
        expiry.isBefore(effective)) {
      _error('Access Expiry Date cannot be before Effective Date.');
      return;
    }

    if (status == 'Active' &&
        userName.text.trim().isEmpty) {
      _error('User Name is required for an Active user.');
      return;
    }

    if (status == 'Active' &&
        accessLevel == 'No Access') {
      _error('Active user cannot have No Access.');
      return;
    }

    if (approvalLevel != 'Not Applicable' &&
        approvedBy.text.trim().isEmpty &&
        status == 'Active') {
      _error('Approved By is required for an Active approved role.');
      return;
    }

    final record = <String, dynamic>{
      'userNo': userNo.text.trim(),
      'userName': userName.text.trim(),
      'employeeId': employeeId.text.trim(),
      'email': email.text.trim(),
      'mobile': mobile.text.trim(),
      'company': company.text.trim(),
      'jobTitle': jobTitle.text.trim(),
      'department': department.text.trim(),
      'role': role,
      'status': status,
      'accessLevel': accessLevel,
      'project': project.text.trim(),
      'site': site.text.trim(),
      'area': area.text.trim(),
      'accessScope': accessScope.text.trim(),
      'modulePermissions': modulePermissions.text.trim(),
      'approvalLevel': approvalLevel,
      'authorityScope': authorityScope.text.trim(),
      'appointedBy': appointedBy.text.trim(),
      'approvedBy': approvedBy.text.trim(),
      'approvalReference': approvalReference.text.trim(),
      'createdDate': createdDate.text.trim(),
      'effectiveDate': effectiveDate.text.trim(),
      'accessExpiryDate': accessExpiryDate.text.trim(),
      'lastReviewDate': lastReviewDate.text.trim(),
      'reviewDueDate': reviewDueDate.text.trim(),
      'accessReviewStatus': accessReviewStatus,
      'changeRequestReference': changeRequestReference.text.trim(),
      'accessChangeReason': accessChangeReason.text.trim(),
      'reference': reference.text.trim(),
      'updatedBy': updatedBy.text.trim(),
      'remarks': remarks.text.trim(),
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
        initialChildSize: 0.92,
        maxChildSize: 0.98,
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
                      Icons.admin_panel_settings,
                      color: darkGreen,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        editing
                            ? 'Edit User & Access'
                            : 'Create User & Access',
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
                _field(userNo, 'User No.', required: true),
                _field(userName, 'User Name', required: true),
                _field(employeeId, 'Employee / Staff ID'),
                _field(email, 'Email'),
                _field(mobile, 'Mobile'),
                _field(company, 'Company'),
                _field(jobTitle, 'Job Title'),
                _field(department, 'Department'),
                _dropdown(
                  'HSE / System Role',
                  role,
                  widget.roles,
                  (value) => setState(
                    () => role = value ?? role,
                  ),
                ),
                _dropdown(
                  'User Status',
                  status,
                  widget.statuses,
                  (value) => setState(
                    () => status = value ?? status,
                  ),
                ),
                _dropdown(
                  'Access Level',
                  accessLevel,
                  widget.accessLevels,
                  (value) => setState(
                    () => accessLevel = value ?? accessLevel,
                  ),
                ),
                _field(
                  accessScope,
                  'Access Scope',
                  maxLines: 2,
                ),
                _field(
                  modulePermissions,
                  'Module Permissions',
                  maxLines: 3,
                ),
                _field(project, 'Project'),
                _field(site, 'Site'),
                _field(area, 'Work Area / Zone'),
                const SizedBox(height: 3),
                const Text(
                  'Approval Authority',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                _dropdown(
                  'Approval Level',
                  approvalLevel,
                  widget.approvalLevels,
                  (value) => setState(
                    () => approvalLevel = value ?? approvalLevel,
                  ),
                ),
                _field(
                  authorityScope,
                  'Authority Scope',
                  maxLines: 2,
                ),
                _field(appointedBy, 'Appointed By'),
                _field(approvedBy, 'Approved By'),
                _field(approvalReference, 'Approval Reference'),
                const SizedBox(height: 3),
                const Text(
                  'Lifecycle & Access Review',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                _dateField('Created Date', createdDate),
                _dateField('Effective Date', effectiveDate),
                _dateField('Access Expiry Date', accessExpiryDate),
                _dateField('Last Review Date', lastReviewDate),
                _dateField('Review Due Date', reviewDueDate),
                _dropdown(
                  'Access Review Status',
                  accessReviewStatus,
                  widget.accessReviewStatuses,
                  (value) => setState(
                    () => accessReviewStatus =
                        value ?? accessReviewStatus,
                  ),
                ),
                _field(
                  changeRequestReference,
                  'Access Change Request Reference',
                ),
                _field(
                  accessChangeReason,
                  'Access Change / Review Reason',
                  maxLines: 3,
                ),
                const SizedBox(height: 3),
                const Text(
                  'Audit & Integration',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                _field(reference, 'Related Record / Reference'),
                _field(updatedBy, 'Updated / Actioned By'),
                _field(
                  remarks,
                  'Remarks',
                  maxLines: 3,
                ),
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
                    editing ? 'Update User' : 'Save User',
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
