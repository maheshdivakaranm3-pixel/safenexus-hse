import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 28
/// HSE Backup, Data Export & Recovery Control Center
///
/// Modules:
/// 28A Backup Master Register
/// 28B Manual Backup
/// 28C Automatic Backup Schedule
/// 28D HSE Data Export
/// 28E Excel / CSV Export Control
/// 28F PDF Report Export Reference
/// 28G Backup Verification
/// 28H Restore / Recovery Register
/// 28I Data Retention & Archive
/// 28J Backup History & Audit Trail
/// 28K Data Integrity & Recovery Readiness
/// 28L Backup / Recovery Intelligence Dashboard
///
/// This module provides a local backup/export/recovery register.
/// It records backup jobs and operational metadata. It does not silently
/// upload data to a cloud service and does not implement encryption,
/// authentication, or a production server-side restore engine.

class SafeNexusStep28 extends StatefulWidget {
  const SafeNexusStep28({super.key});

  @override
  State<SafeNexusStep28> createState() => _SafeNexusStep28State();
}

class _SafeNexusStep28State extends State<SafeNexusStep28> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey = 'safenexus_hse_step28_backup_recovery';

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _records = <Map<String, dynamic>>[];
  bool _loading = true;
  String _typeFilter = 'All';
  String _statusFilter = 'All';
  String _verificationFilter = 'All';
  bool _showOverdueOnly = false;

  static const List<String> recordTypes = <String>[
    'Backup Master',
    'Manual Backup',
    'Automatic Backup',
    'Data Export',
    'CSV Export',
    'Excel Export',
    'PDF Export Reference',
    'Backup Verification',
    'Restore / Recovery',
    'Retention / Archive',
    'Backup Audit',
    'Integrity / Recovery Readiness',
  ];

  static const List<String> statuses = <String>[
    'Planned',
    'Scheduled',
    'In Progress',
    'Completed',
    'Verified',
    'Failed',
    'Restore Tested',
    'Archived',
    'Expired',
    'Cancelled',
  ];

  static const List<String> verificationStatuses = <String>[
    'Not Verified',
    'Pending Verification',
    'Verified',
    'Failed Verification',
    'Not Applicable',
  ];

  static const List<String> frequencies = <String>[
    'One Time',
    'Daily',
    'Weekly',
    'Monthly',
    'Quarterly',
    'Annual',
    'As Required',
  ];

  static const List<String> storageTypes = <String>[
    'Local Device',
    'External Storage',
    'Project Server',
    'Approved Cloud Storage',
    'Archive Storage',
    'Other',
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
    if (status == 'Completed' ||
        status == 'Verified' ||
        status == 'Restore Tested' ||
        status == 'Archived' ||
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
            record['backupNo'],
            record['title'],
            record['project'],
            record['site'],
            record['recordType'],
            record['storageLocation'],
            record['fileName'],
            record['reference'],
            record['owner'],
            record['verifiedBy'],
          ].any(
            (value) => value.toString().toLowerCase().contains(query),
          );

      final matchesType = _typeFilter == 'All' ||
          record['recordType'] == _typeFilter;

      final matchesStatus = _statusFilter == 'All' ||
          record['status'] == _statusFilter;

      final matchesVerification = _verificationFilter == 'All' ||
          record['verificationStatus'] == _verificationFilter;

      final matchesOverdue =
          !_showOverdueOnly || _isOverdue(record);

      return matchesSearch &&
          matchesType &&
          matchesStatus &&
          matchesVerification &&
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

  int get _completed => _count(
        (r) =>
            r['status'] == 'Completed' ||
            r['status'] == 'Verified' ||
            r['status'] == 'Restore Tested',
      );

  int get _verified =>
      _count((r) => r['verificationStatus'] == 'Verified');

  int get _failed => _count(
        (r) =>
            r['status'] == 'Failed' ||
            r['verificationStatus'] == 'Failed Verification',
      );

  int get _overdue => _count(_isOverdue);

  int get _restoreTested =>
      _count((r) => r['status'] == 'Restore Tested');

  int get _archived =>
      _count((r) => r['status'] == 'Archived');

  double get _verificationRate =>
      _total == 0 ? 0 : _verified * 100 / _total;

  Future<void> _openForm({
    Map<String, dynamic>? existing,
  }) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _Step28FormSheet(
        existing: existing,
        recordTypes: recordTypes,
        statuses: statuses,
        verificationStatuses: verificationStatuses,
        frequencies: frequencies,
        storageTypes: storageTypes,
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
          'comments': 'Backup / recovery record created.',
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
      'user': updated['updatedBy'] ?? updated['owner'] ?? '',
      'status': status,
      'comments': updated['notes'] ?? '',
    });
    updated['history'] = history;

    _records[index] = updated;
    await _saveRecords();

    if (mounted) setState(() {});
  }

  Future<void> _verifyRecord(Map<String, dynamic> record) async {
    final index = _records.indexWhere(
      (item) => item['id'] == record['id'],
    );
    if (index < 0) return;

    final now = DateTime.now().toIso8601String();
    final updated = Map<String, dynamic>.from(_records[index]);
    updated['verificationStatus'] = 'Verified';
    updated['verifiedDate'] = now.substring(0, 10);
    updated['status'] = 'Verified';
    updated['updatedAt'] = now;

    final history = List<dynamic>.from(
      updated['history'] ?? <dynamic>[],
    );
    history.add(<String, dynamic>{
      'action': 'Verified',
      'date': now,
      'user': updated['verifiedBy'] ?? updated['updatedBy'] ?? '',
      'status': 'Verified',
      'comments': 'Backup/export verification completed.',
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
        title: const Text('Delete backup record?'),
        content: Text(
          'Delete ${record['backupNo'] ?? 'this record'} permanently?',
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
                  const Icon(
                    Icons.backup,
                    color: darkGreen,
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      record['backupNo']?.toString() ?? 'Backup Record',
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
              _section('Backup / Export', [
                _row('Record Type', record['recordType']),
                _row('Title', record['title']),
                _row('Project', record['project']),
                _row('Site', record['site']),
                _row('Owner', record['owner']),
                _row('Status', record['status']),
                _row('Frequency', record['frequency']),
                _row('Backup Date', record['backupDate']),
                _row('Next Due Date', record['dueDate']),
              ]),
              _section('Storage & File', [
                _row('Storage Type', record['storageType']),
                _row('Storage Location', record['storageLocation']),
                _row('File Name', record['fileName']),
                _row('File Format', record['fileFormat']),
                _row('File Size', record['fileSize']),
                _row('Record Count', record['recordCount']),
                _row('Checksum / Hash Reference', record['checksum']),
                _row('External URI / Reference', record['externalUri']),
              ]),
              _section('Verification & Recovery', [
                _row('Verification Status', record['verificationStatus']),
                _row('Verified By', record['verifiedBy']),
                _row('Verified Date', record['verifiedDate']),
                _row('Restore Tested', record['restoreTested']),
                _row('Restore Test Date', record['restoreTestDate']),
                _row('Recovery Result', record['recoveryResult']),
                _row('Recovery Reference', record['recoveryReference']),
              ]),
              _section('Retention & Archive', [
                _row('Retention Period', record['retentionPeriod']),
                _row('Archive Status', record['archiveStatus']),
                _row('Archive Date', record['archiveDate']),
                _row('Expiry Date', record['expiryDate']),
              ]),
              _section('Audit', [
                _row('Reference', record['reference']),
                _row('Updated By', record['updatedBy']),
                _row('Notes', record['notes']),
              ]),
              _section(
                'Backup History & Audit Trail',
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
      case 'Completed':
      case 'Verified':
      case 'Restore Tested':
      case 'Archived':
        return primaryGreen;
      case 'Failed':
      case 'Expired':
        return Colors.red;
      case 'In Progress':
      case 'Scheduled':
        return Colors.orange;
      default:
        return Colors.blueGrey;
    }
  }

  Color _verificationColor(String status) {
    switch (status) {
      case 'Verified':
        return primaryGreen;
      case 'Failed Verification':
        return Colors.red;
      case 'Pending Verification':
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
                Icons.backup,
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
                    'HSE Backup, Export & Recovery Control Center',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Backup • Verify • Export • Archive • Restore Test',
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
        _summaryCard('Total', '$_total', Icons.storage),
        _summaryCard(
          'Completed',
          '$_completed',
          Icons.check_circle,
          color: primaryGreen,
        ),
        _summaryCard(
          'Verified',
          '$_verified',
          Icons.verified,
          color: primaryGreen,
        ),
        _summaryCard(
          'Failed',
          '$_failed',
          Icons.error_outline,
          color: Colors.red,
        ),
        _summaryCard(
          'Overdue',
          '$_overdue',
          Icons.warning_amber,
          color: Colors.red,
        ),
        _summaryCard(
          'Restore Tested',
          '$_restoreTested',
          Icons.restore,
          color: darkGreen,
        ),
        _summaryCard(
          'Archived',
          '$_archived',
          Icons.archive,
          color: Colors.blueGrey,
        ),
        _summaryCard(
          'Verification Rate',
          '${_verificationRate.toStringAsFixed(0)}%',
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
                    'Search backup, project, file, owner, reference...',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 9),
            _dropdown(
              value: _typeFilter,
              items: <String>['All', ...recordTypes],
              onChanged: (value) {
                setState(() => _typeFilter = value ?? 'All');
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
                    value: _verificationFilter,
                    items: <String>['All', ...verificationStatuses],
                    onChanged: (value) {
                      setState(
                        () => _verificationFilter =
                            value ?? 'All',
                      );
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

  Widget _intelligence() {
    String message;
    IconData icon;

    if (_failed > 0) {
      message =
          'Failed backup or verification records require immediate action.';
      icon = Icons.error_outline;
    } else if (_overdue > 0) {
      message =
          'Backup, export, or recovery activities are overdue.';
      icon = Icons.warning_amber;
    } else if (_restoreTested == 0 && _total > 0) {
      message =
          'Consider recording a restore test to demonstrate recovery readiness.';
      icon = Icons.restore;
    } else if (_verified < _total && _total > 0) {
      message =
          'Some backup/export records still require verification.';
      icon = Icons.verified_outlined;
    } else {
      message =
          'Backup and recovery records are currently under control.';
      icon = Icons.check_circle;
    }

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: darkGreen.withValues(alpha: 0.10),
          child: Icon(icon, color: darkGreen),
        ),
        title: const Text(
          'Backup / Recovery Intelligence',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(message),
      ),
    );
  }

  Widget _recordCard(Map<String, dynamic> record) {
    final status = record['status']?.toString() ?? 'Planned';
    final verification =
        record['verificationStatus']?.toString() ?? 'Not Verified';
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
                      record['backupNo']?.toString() ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                      ),
                    ),
                  ),
                  _tag(status, _statusColor(status)),
                  const SizedBox(width: 5),
                  _tag(
                    verification,
                    _verificationColor(verification),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Text(
                record['title']?.toString() ?? 'Backup / Export Record',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(record['recordType']?.toString() ?? ''),
              const SizedBox(height: 6),
              Wrap(
                spacing: 12,
                runSpacing: 5,
                children: [
                  if ((record['project'] ?? '').toString().isNotEmpty)
                    Text('Project: ${record['project']}'),
                  if ((record['site'] ?? '').toString().isNotEmpty)
                    Text('Site: ${record['site']}'),
                  if ((record['storageType'] ?? '').toString().isNotEmpty)
                    Text('Storage: ${record['storageType']}'),
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
                  IconButton(
                    tooltip: 'Verify',
                    onPressed: () => _verifyRecord(record),
                    icon: const Icon(Icons.verified_outlined),
                  ),
                  PopupMenuButton<String>(
                    tooltip: 'Status',
                    onSelected: (value) =>
                        _changeStatus(record, value),
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: 'In Progress',
                        child: Text('In Progress'),
                      ),
                      PopupMenuItem(
                        value: 'Completed',
                        child: Text('Completed'),
                      ),
                      PopupMenuItem(
                        value: 'Verified',
                        child: Text('Verified'),
                      ),
                      PopupMenuItem(
                        value: 'Failed',
                        child: Text('Failed'),
                      ),
                      PopupMenuItem(
                        value: 'Restore Tested',
                        child: Text('Restore Tested'),
                      ),
                      PopupMenuItem(
                        value: 'Archived',
                        child: Text('Archived'),
                      ),
                      PopupMenuItem(
                        value: 'Cancelled',
                        child: Text('Cancelled'),
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
        title: const Text('Step 28 • Backup & Recovery'),
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
        label: const Text('New Backup'),
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

  Widget _empty() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Icon(
              Icons.backup_outlined,
              size: 55,
              color: darkGreen.withValues(alpha: 0.45),
            ),
            const SizedBox(height: 10),
            const Text(
              'No backup / recovery records found',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create a record to start backup, verification, export and recovery tracking.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            FilledButton.icon(
              onPressed: () => _openForm(),
              icon: const Icon(Icons.add),
              label: const Text('Create Backup Record'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Step28FormSheet extends StatefulWidget {
  const _Step28FormSheet({
    required this.existing,
    required this.recordTypes,
    required this.statuses,
    required this.verificationStatuses,
    required this.frequencies,
    required this.storageTypes,
  });

  final Map<String, dynamic>? existing;
  final List<String> recordTypes;
  final List<String> statuses;
  final List<String> verificationStatuses;
  final List<String> frequencies;
  final List<String> storageTypes;

  @override
  State<_Step28FormSheet> createState() => _Step28FormSheetState();
}

class _Step28FormSheetState extends State<_Step28FormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController backupNo;
  late final TextEditingController title;
  late final TextEditingController project;
  late final TextEditingController site;
  late final TextEditingController owner;
  late final TextEditingController backupDate;
  late final TextEditingController dueDate;
  late final TextEditingController storageLocation;
  late final TextEditingController fileName;
  late final TextEditingController fileFormat;
  late final TextEditingController fileSize;
  late final TextEditingController recordCount;
  late final TextEditingController checksum;
  late final TextEditingController externalUri;
  late final TextEditingController verifiedBy;
  late final TextEditingController verifiedDate;
  late final TextEditingController restoreTested;
  late final TextEditingController restoreTestDate;
  late final TextEditingController recoveryResult;
  late final TextEditingController recoveryReference;
  late final TextEditingController retentionPeriod;
  late final TextEditingController archiveStatus;
  late final TextEditingController archiveDate;
  late final TextEditingController expiryDate;
  late final TextEditingController reference;
  late final TextEditingController updatedBy;
  late final TextEditingController notes;

  late String recordType;
  late String status;
  late String verificationStatus;
  late String frequency;
  late String storageType;

  @override
  void initState() {
    super.initState();

    final r = widget.existing ?? <String, dynamic>{};

    backupNo = _controller(r, 'backupNo');
    title = _controller(r, 'title');
    project = _controller(r, 'project');
    site = _controller(r, 'site');
    owner = _controller(r, 'owner');
    backupDate = _controller(r, 'backupDate');
    dueDate = _controller(r, 'dueDate');
    storageLocation = _controller(r, 'storageLocation');
    fileName = _controller(r, 'fileName');
    fileFormat = _controller(r, 'fileFormat');
    fileSize = _controller(r, 'fileSize');
    recordCount = _controller(r, 'recordCount');
    checksum = _controller(r, 'checksum');
    externalUri = _controller(r, 'externalUri');
    verifiedBy = _controller(r, 'verifiedBy');
    verifiedDate = _controller(r, 'verifiedDate');
    restoreTested = _controller(r, 'restoreTested');
    restoreTestDate = _controller(r, 'restoreTestDate');
    recoveryResult = _controller(r, 'recoveryResult');
    recoveryReference = _controller(r, 'recoveryReference');
    retentionPeriod = _controller(r, 'retentionPeriod');
    archiveStatus = _controller(r, 'archiveStatus');
    archiveDate = _controller(r, 'archiveDate');
    expiryDate = _controller(r, 'expiryDate');
    reference = _controller(r, 'reference');
    updatedBy = _controller(r, 'updatedBy');
    notes = _controller(r, 'notes');

    recordType = _valid(
      r['recordType'],
      widget.recordTypes,
      'Backup Master',
    );
    status = _valid(
      r['status'],
      widget.statuses,
      'Planned',
    );
    verificationStatus = _valid(
      r['verificationStatus'],
      widget.verificationStatuses,
      'Not Verified',
    );
    frequency = _valid(
      r['frequency'],
      widget.frequencies,
      'One Time',
    );
    storageType = _valid(
      r['storageType'],
      widget.storageTypes,
      'Local Device',
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
      backupNo,
      title,
      project,
      site,
      owner,
      backupDate,
      dueDate,
      storageLocation,
      fileName,
      fileFormat,
      fileSize,
      recordCount,
      checksum,
      externalUri,
      verifiedBy,
      verifiedDate,
      restoreTested,
      restoreTestDate,
      recoveryResult,
      recoveryReference,
      retentionPeriod,
      archiveStatus,
      archiveDate,
      expiryDate,
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

    final fields = <MapEntry<String, TextEditingController>>[
      MapEntry('Backup Date', backupDate),
      MapEntry('Due Date', dueDate),
      MapEntry('Verified Date', verifiedDate),
      MapEntry('Restore Test Date', restoreTestDate),
      MapEntry('Archive Date', archiveDate),
      MapEntry('Expiry Date', expiryDate),
    ];

    for (final field in fields) {
      if (!_validDate(field.value.text)) {
        _error('${field.key} must use YYYY-MM-DD format.');
        return;
      }
    }

    final backup = DateTime.tryParse(backupDate.text.trim());
    final expiry = DateTime.tryParse(expiryDate.text.trim());

    if (backup != null &&
        expiry != null &&
        expiry.isBefore(backup)) {
      _error('Expiry Date cannot be before Backup Date.');
      return;
    }

    if (verificationStatus == 'Verified' &&
        verifiedBy.text.trim().isEmpty) {
      _error('Verified By is required for Verified status.');
      return;
    }

    if (status == 'Restore Tested' &&
        restoreTestDate.text.trim().isEmpty) {
      _error('Restore Test Date is required.');
      return;
    }

    final record = <String, dynamic>{
      'backupNo': backupNo.text.trim(),
      'title': title.text.trim(),
      'project': project.text.trim(),
      'site': site.text.trim(),
      'owner': owner.text.trim(),
      'recordType': recordType,
      'status': status,
      'frequency': frequency,
      'backupDate': backupDate.text.trim(),
      'dueDate': dueDate.text.trim(),
      'storageType': storageType,
      'storageLocation': storageLocation.text.trim(),
      'fileName': fileName.text.trim(),
      'fileFormat': fileFormat.text.trim(),
      'fileSize': fileSize.text.trim(),
      'recordCount': recordCount.text.trim(),
      'checksum': checksum.text.trim(),
      'externalUri': externalUri.text.trim(),
      'verificationStatus': verificationStatus,
      'verifiedBy': verifiedBy.text.trim(),
      'verifiedDate': verifiedDate.text.trim(),
      'restoreTested': restoreTested.text.trim(),
      'restoreTestDate': restoreTestDate.text.trim(),
      'recoveryResult': recoveryResult.text.trim(),
      'recoveryReference': recoveryReference.text.trim(),
      'retentionPeriod': retentionPeriod.text.trim(),
      'archiveStatus': archiveStatus.text.trim(),
      'archiveDate': archiveDate.text.trim(),
      'expiryDate': expiryDate.text.trim(),
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
                    const Icon(Icons.backup, color: darkGreen),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        editing
                            ? 'Edit Backup / Recovery Record'
                            : 'Create Backup / Recovery Record',
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
                _field(backupNo, 'Backup / Record No.', required: true),
                _field(title, 'Title', required: true),
                _dropdown(
                  'Record Type',
                  recordType,
                  widget.recordTypes,
                  (value) => setState(
                    () => recordType = value ?? recordType,
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
                  'Frequency',
                  frequency,
                  widget.frequencies,
                  (value) => setState(
                    () => frequency = value ?? frequency,
                  ),
                ),
                _field(project, 'Project'),
                _field(site, 'Site'),
                _field(owner, 'Owner', required: true),
                _dateField('Backup Date', backupDate),
                _dateField('Next Due Date', dueDate),
                const SizedBox(height: 3),
                const Text(
                  'Storage & Export',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                _dropdown(
                  'Storage Type',
                  storageType,
                  widget.storageTypes,
                  (value) => setState(
                    () => storageType = value ?? storageType,
                  ),
                ),
                _field(storageLocation, 'Storage Location'),
                _field(fileName, 'File Name'),
                _field(fileFormat, 'File Format'),
                _field(fileSize, 'File Size'),
                _field(recordCount, 'Record Count'),
                _field(checksum, 'Checksum / Hash Reference'),
                _field(
                  externalUri,
                  'External URI / Reference',
                  maxLines: 2,
                ),
                const SizedBox(height: 3),
                const Text(
                  'Verification & Recovery',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                _dropdown(
                  'Verification Status',
                  verificationStatus,
                  widget.verificationStatuses,
                  (value) => setState(
                    () => verificationStatus =
                        value ?? verificationStatus,
                  ),
                ),
                _field(verifiedBy, 'Verified By'),
                _dateField('Verified Date', verifiedDate),
                _field(
                  restoreTested,
                  'Restore Test Result / Status',
                ),
                _dateField('Restore Test Date', restoreTestDate),
                _field(
                  recoveryResult,
                  'Recovery Result',
                  maxLines: 2,
                ),
                _field(
                  recoveryReference,
                  'Recovery Reference',
                ),
                const SizedBox(height: 3),
                const Text(
                  'Retention & Archive',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                _field(retentionPeriod, 'Retention Period'),
                _field(archiveStatus, 'Archive Status'),
                _dateField('Archive Date', archiveDate),
                _dateField('Expiry Date', expiryDate),
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
                _field(updatedBy, 'Updated / Actioned By'),
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
                        ? 'Update Backup Record'
                        : 'Save Backup Record',
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
