import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 29
/// HSE Communication, Notification & Collaboration Center
///
/// Modules:
/// 29A HSE Communication Master
/// 29B Internal HSE Notifications
/// 29C Safety Alerts & Bulletins
/// 29D Toolbox / Safety Briefing Communication
/// 29E Worker & Contractor Communication
/// 29F Management / Client Communication
/// 29G Authority / Regulatory Communication
/// 29H Action / Approval Notifications
/// 29I Emergency Communication Log
/// 29J Communication Acknowledgement Tracking
/// 29K Communication History & Audit Trail
/// 29L Communication Intelligence Dashboard
///
/// Core flow:
/// Create -> Review -> Publish/Send -> Acknowledgement -> Action
/// -> Verification -> Close
///
/// This is a local communication register. It does not silently send
/// messages, emails, push notifications, or authority submissions.
/// Production delivery should be connected to approved communication
/// services with authentication, authorization, audit and privacy controls.

class SafeNexusStep29 extends StatefulWidget {
  const SafeNexusStep29({super.key});

  @override
  State<SafeNexusStep29> createState() => _SafeNexusStep29State();
}

class _SafeNexusStep29State extends State<SafeNexusStep29> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_step29_communication_collaboration';

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _records = <Map<String, dynamic>>[];
  bool _loading = true;
  String _typeFilter = 'All';
  String _statusFilter = 'All';
  String _priorityFilter = 'All';
  String _ackFilter = 'All';
  bool _showOverdueOnly = false;

  static const List<String> communicationTypes = <String>[
    'HSE Communication Master',
    'Internal HSE Notification',
    'Safety Alert',
    'Safety Bulletin',
    'Toolbox Talk Communication',
    'Safety Briefing',
    'Worker Communication',
    'Contractor Communication',
    'Management Communication',
    'Client Communication',
    'Authority / Regulatory Communication',
    'Action Notification',
    'Approval Notification',
    'Emergency Communication',
    'Acknowledgement Tracking',
    'Other',
  ];

  static const List<String> statuses = <String>[
    'Draft',
    'Under Review',
    'Approved',
    'Scheduled',
    'Published',
    'Sent',
    'Acknowledgement Pending',
    'Action Required',
    'In Progress',
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

  static const List<String> acknowledgementStatuses = <String>[
    'Not Required',
    'Pending',
    'Partially Acknowledged',
    'Fully Acknowledged',
    'Overdue',
    'Not Applicable',
  ];

  static const List<String> audiences = <String>[
    'All Workforce',
    'HSE Team',
    'Workers',
    'Supervisors',
    'Contractors',
    'Subcontractors',
    'Management',
    'Client',
    'Visitors',
    'Authority / Regulator',
    'Emergency Response Team',
    'Specific Group',
  ];

  static const List<String> channels = <String>[
    'App Notification',
    'Email',
    'SMS',
    'Toolbox Talk',
    'Safety Briefing',
    'Notice Board',
    'Meeting',
    'Letter',
    'Radio',
    'Phone',
    'Verbal',
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
      final matchesSearch = query.isEmpty ||
          <dynamic>[
            record['communicationNo'],
            record['subject'],
            record['messageTitle'],
            record['project'],
            record['site'],
            record['location'],
            record['sender'],
            record['recipient'],
            record['audience'],
            record['reference'],
            record['actionOwner'],
          ].any(
            (value) => value.toString().toLowerCase().contains(query),
          );

      final matchesType = _typeFilter == 'All' ||
          record['communicationType'] == _typeFilter;

      final matchesStatus = _statusFilter == 'All' ||
          record['status'] == _statusFilter;

      final matchesPriority = _priorityFilter == 'All' ||
          record['priority'] == _priorityFilter;

      final matchesAck = _ackFilter == 'All' ||
          record['acknowledgementStatus'] == _ackFilter;

      final matchesOverdue =
          !_showOverdueOnly || _isOverdue(record);

      return matchesSearch &&
          matchesType &&
          matchesStatus &&
          matchesPriority &&
          matchesAck &&
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

  int get _sent => _count(
        (r) =>
            r['status'] == 'Sent' ||
            r['status'] == 'Published' ||
            r['status'] == 'Acknowledgement Pending' ||
            r['status'] == 'Action Required' ||
            r['status'] == 'In Progress' ||
            r['status'] == 'Verified' ||
            r['status'] == 'Closed',
      );

  int get _pendingAcknowledgement => _count(
        (r) =>
            r['acknowledgementStatus'] == 'Pending' ||
            r['acknowledgementStatus'] == 'Partially Acknowledged' ||
            r['acknowledgementStatus'] == 'Overdue',
      );

  int get _actionRequired => _count(
        (r) =>
            r['status'] == 'Action Required' ||
            r['status'] == 'In Progress',
      );

  int get _critical => _count(
        (r) =>
            r['priority'] == 'Critical' &&
            r['status'] != 'Closed' &&
            r['status'] != 'Cancelled',
      );

  int get _overdue => _count(_isOverdue);

  int get _verified => _count(
        (r) =>
            r['status'] == 'Verified' ||
            r['status'] == 'Closed',
      );

  double get _ackRate {
    final required = _count(
      (r) =>
          r['acknowledgementStatus'] != 'Not Required' &&
          r['acknowledgementStatus'] != 'Not Applicable',
    );
    if (required == 0) return 0;

    final complete = _count(
      (r) => r['acknowledgementStatus'] == 'Fully Acknowledged',
    );
    return complete * 100 / required;
  }

  Future<void> _openForm({
    Map<String, dynamic>? existing,
  }) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _Step29FormSheet(
        existing: existing,
        communicationTypes: communicationTypes,
        statuses: statuses,
        priorities: priorities,
        acknowledgementStatuses: acknowledgementStatuses,
        audiences: audiences,
        channels: channels,
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
          'comments': 'Communication record created.',
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
      'user': updated['updatedBy'] ?? updated['sender'] ?? '',
      'status': status,
      'comments': updated['notes'] ?? '',
    });
    updated['history'] = history;

    _records[index] = updated;
    await _saveRecords();

    if (mounted) setState(() {});
  }

  Future<void> _acknowledge(Map<String, dynamic> record) async {
    final index = _records.indexWhere(
      (item) => item['id'] == record['id'],
    );
    if (index < 0) return;

    final now = DateTime.now().toIso8601String();
    final updated = Map<String, dynamic>.from(_records[index]);
    updated['acknowledgementStatus'] = 'Fully Acknowledged';
    updated['acknowledgedDate'] = now.substring(0, 10);
    updated['status'] = 'Verified';
    updated['updatedAt'] = now;

    final history = List<dynamic>.from(
      updated['history'] ?? <dynamic>[],
    );
    history.add(<String, dynamic>{
      'action': 'Acknowledged',
      'date': now,
      'user': updated['updatedBy'] ?? '',
      'status': 'Verified',
      'comments': 'Communication acknowledgement recorded.',
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
        title: const Text('Delete communication record?'),
        content: Text(
          'Delete ${record['communicationNo'] ?? 'this record'} permanently?',
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
                    Icons.campaign,
                    color: darkGreen,
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      record['communicationNo']?.toString() ??
                          'Communication',
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
              _section('Communication', [
                _row('Type', record['communicationType']),
                _row('Subject', record['subject']),
                _row('Message Title', record['messageTitle']),
                _row('Project', record['project']),
                _row('Site', record['site']),
                _row('Location', record['location']),
                _row('Priority', record['priority']),
                _row('Status', record['status']),
                _row('Communication Date', record['communicationDate']),
                _row('Due Date', record['dueDate']),
              ]),
              _section('Sender / Audience', [
                _row('Sender', record['sender']),
                _row('Recipient', record['recipient']),
                _row('Audience', record['audience']),
                _row('Channel', record['channel']),
                _row('Language', record['language']),
                _row('Attendee / Recipient Count',
                    record['recipientCount']),
              ]),
              _section('Message & Action', [
                _row('Message', record['message']),
                _row('Required Action', record['requiredAction']),
                _row('Action Owner', record['actionOwner']),
                _row('Action Due', record['actionDue']),
                _row('Action Status', record['actionStatus']),
                _row('Verification', record['verification']),
              ]),
              _section('Acknowledgement', [
                _row(
                    'Acknowledgement Status',
                    record['acknowledgementStatus']),
                _row('Acknowledged Date', record['acknowledgedDate']),
                _row('Acknowledgement Evidence',
                    record['acknowledgementEvidence']),
                _row('Unacknowledged Count',
                    record['unacknowledgedCount']),
              ]),
              _section('HSE Integration', [
                _row('Risk / HIRA / JSA', record['riskReference']),
                _row('RAMS', record['ramsReference']),
                _row('PTW', record['ptwReference']),
                _row('Incident / CAPA', record['incidentReference']),
                _row('Audit / Inspection', record['auditReference']),
                _row('Legal / Authority', record['legalReference']),
                _row('Training / Competency',
                    record['trainingReference']),
                _row('Emergency / ERP', record['emergencyReference']),
              ]),
              _section('Audit & Notes', [
                _row('Reference', record['reference']),
                _row('Updated By', record['updatedBy']),
                _row('Notes', record['notes']),
              ]),
              _section(
                'Communication History & Audit Trail',
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
      case 'Published':
      case 'Sent':
      case 'Verified':
      case 'Closed':
        return primaryGreen;
      case 'Critical':
      case 'Cancelled':
        return Colors.red;
      case 'Acknowledgement Pending':
      case 'Action Required':
      case 'In Progress':
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

  Color _ackColor(String status) {
    switch (status) {
      case 'Fully Acknowledged':
        return primaryGreen;
      case 'Overdue':
        return Colors.red;
      case 'Pending':
      case 'Partially Acknowledged':
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
                Icons.campaign,
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
                    'HSE Communication & Collaboration Center',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Create • Send • Acknowledge • Act • Verify • Close',
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
        _summaryCard('Total', '$_total', Icons.forum),
        _summaryCard(
          'Sent / Published',
          '$_sent',
          Icons.send,
          color: primaryGreen,
        ),
        _summaryCard(
          'Ack Pending',
          '$_pendingAcknowledgement',
          Icons.mark_email_unread,
          color: Colors.orange,
        ),
        _summaryCard(
          'Action Required',
          '$_actionRequired',
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
          'Verified / Closed',
          '$_verified',
          Icons.verified,
          color: primaryGreen,
        ),
        _summaryCard(
          'Ack Rate',
          '${_ackRate.toStringAsFixed(0)}%',
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
                    'Search communication, subject, project, sender...',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 9),
            _dropdown(
              value: _typeFilter,
              items: <String>['All', ...communicationTypes],
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
              value: _ackFilter,
              items: <String>['All', ...acknowledgementStatuses],
              onChanged: (value) {
                setState(() => _ackFilter = value ?? 'All');
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
          'Critical communications require immediate management attention.';
      icon = Icons.priority_high;
    } else if (_overdue > 0) {
      message =
          'Overdue communication actions or acknowledgements need follow-up.';
      icon = Icons.warning_amber;
    } else if (_pendingAcknowledgement > 0) {
      message =
          'Some recipients have not completed required acknowledgement.';
      icon = Icons.mark_email_unread;
    } else if (_actionRequired > 0) {
      message =
          'Communication-linked actions remain open.';
      icon = Icons.assignment_late;
    } else {
      message =
          'Communication and acknowledgement records are under control.';
      icon = Icons.check_circle;
    }

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: darkGreen.withValues(alpha: 0.10),
          child: Icon(icon, color: darkGreen),
        ),
        title: const Text(
          'Communication Intelligence',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(message),
      ),
    );
  }

  Widget _recordCard(Map<String, dynamic> record) {
    final status = record['status']?.toString() ?? 'Draft';
    final priority = record['priority']?.toString() ?? 'Medium';
    final ack = record['acknowledgementStatus']?.toString() ??
        'Not Required';
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
                      record['communicationNo']?.toString() ?? '',
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
                record['subject']?.toString() ??
                    record['messageTitle']?.toString() ??
                    'Communication',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      record['communicationType']?.toString() ?? '',
                    ),
                  ),
                  _tag(priority, _priorityColor(priority)),
                ],
              ),
              const SizedBox(height: 6),
              _tag(ack, _ackColor(ack)),
              const SizedBox(height: 6),
              Wrap(
                spacing: 12,
                runSpacing: 5,
                children: [
                  if ((record['project'] ?? '').toString().isNotEmpty)
                    Text('Project: ${record['project']}'),
                  if ((record['site'] ?? '').toString().isNotEmpty)
                    Text('Site: ${record['site']}'),
                  if ((record['audience'] ?? '').toString().isNotEmpty)
                    Text('Audience: ${record['audience']}'),
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
                    tooltip: 'Acknowledge',
                    onPressed: () => _acknowledge(record),
                    icon: const Icon(Icons.done_all),
                  ),
                  PopupMenuButton<String>(
                    tooltip: 'Status',
                    onSelected: (value) =>
                        _changeStatus(record, value),
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: 'Under Review',
                        child: Text('Under Review'),
                      ),
                      PopupMenuItem(
                        value: 'Approved',
                        child: Text('Approve'),
                      ),
                      PopupMenuItem(
                        value: 'Scheduled',
                        child: Text('Schedule'),
                      ),
                      PopupMenuItem(
                        value: 'Published',
                        child: Text('Publish'),
                      ),
                      PopupMenuItem(
                        value: 'Sent',
                        child: Text('Mark Sent'),
                      ),
                      PopupMenuItem(
                        value: 'Acknowledgement Pending',
                        child: Text('Ack Pending'),
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
        title: const Text('Step 29 • HSE Communication'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Reset filters',
            onPressed: () {
              _searchController.clear();
              setState(() {
                _typeFilter = 'All';
                _statusFilter = 'All';
                _priorityFilter = 'All';
                _ackFilter = 'All';
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
        label: const Text('New Communication'),
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
                    'Communication Records (${records.length})',
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
                              Icons.campaign_outlined,
                              size: 52,
                              color: Colors.blueGrey,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'No matching communication records',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              _records.isEmpty
                                  ? 'Create the first HSE communication record.'
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

class _Step29FormSheet extends StatefulWidget {
  const _Step29FormSheet({
    required this.existing,
    required this.communicationTypes,
    required this.statuses,
    required this.priorities,
    required this.acknowledgementStatuses,
    required this.audiences,
    required this.channels,
  });

  final Map<String, dynamic>? existing;
  final List<String> communicationTypes;
  final List<String> statuses;
  final List<String> priorities;
  final List<String> acknowledgementStatuses;
  final List<String> audiences;
  final List<String> channels;

  @override
  State<_Step29FormSheet> createState() => _Step29FormSheetState();
}

class _Step29FormSheetState extends State<_Step29FormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController communicationNo;
  late final TextEditingController subject;
  late final TextEditingController messageTitle;
  late final TextEditingController project;
  late final TextEditingController site;
  late final TextEditingController location;
  late final TextEditingController communicationDate;
  late final TextEditingController dueDate;
  late final TextEditingController sender;
  late final TextEditingController recipient;
  late final TextEditingController language;
  late final TextEditingController recipientCount;
  late final TextEditingController message;
  late final TextEditingController requiredAction;
  late final TextEditingController actionOwner;
  late final TextEditingController actionDue;
  late final TextEditingController actionStatus;
  late final TextEditingController verification;
  late final TextEditingController acknowledgedDate;
  late final TextEditingController acknowledgementEvidence;
  late final TextEditingController unacknowledgedCount;
  late final TextEditingController riskReference;
  late final TextEditingController ramsReference;
  late final TextEditingController ptwReference;
  late final TextEditingController incidentReference;
  late final TextEditingController auditReference;
  late final TextEditingController legalReference;
  late final TextEditingController trainingReference;
  late final TextEditingController emergencyReference;
  late final TextEditingController reference;
  late final TextEditingController updatedBy;
  late final TextEditingController notes;

  late String communicationType;
  late String status;
  late String priority;
  late String acknowledgementStatus;
  late String audience;
  late String channel;

  @override
  void initState() {
    super.initState();

    final r = widget.existing ?? <String, dynamic>{};

    communicationNo = _controller(r, 'communicationNo');
    subject = _controller(r, 'subject');
    messageTitle = _controller(r, 'messageTitle');
    project = _controller(r, 'project');
    site = _controller(r, 'site');
    location = _controller(r, 'location');
    communicationDate = _controller(r, 'communicationDate');
    dueDate = _controller(r, 'dueDate');
    sender = _controller(r, 'sender');
    recipient = _controller(r, 'recipient');
    language = _controller(r, 'language', fallback: 'English');
    recipientCount = _controller(r, 'recipientCount');
    message = _controller(r, 'message');
    requiredAction = _controller(r, 'requiredAction');
    actionOwner = _controller(r, 'actionOwner');
    actionDue = _controller(r, 'actionDue');
    actionStatus = _controller(r, 'actionStatus');
    verification = _controller(r, 'verification');
    acknowledgedDate = _controller(r, 'acknowledgedDate');
    acknowledgementEvidence =
        _controller(r, 'acknowledgementEvidence');
    unacknowledgedCount =
        _controller(r, 'unacknowledgedCount');
    riskReference = _controller(r, 'riskReference');
    ramsReference = _controller(r, 'ramsReference');
    ptwReference = _controller(r, 'ptwReference');
    incidentReference = _controller(r, 'incidentReference');
    auditReference = _controller(r, 'auditReference');
    legalReference = _controller(r, 'legalReference');
    trainingReference = _controller(r, 'trainingReference');
    emergencyReference = _controller(r, 'emergencyReference');
    reference = _controller(r, 'reference');
    updatedBy = _controller(r, 'updatedBy');
    notes = _controller(r, 'notes');

    communicationType = _valid(
      r['communicationType'],
      widget.communicationTypes,
      'HSE Communication Master',
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
    acknowledgementStatus = _valid(
      r['acknowledgementStatus'],
      widget.acknowledgementStatuses,
      'Not Required',
    );
    audience = _valid(
      r['audience'],
      widget.audiences,
      'HSE Team',
    );
    channel = _valid(
      r['channel'],
      widget.channels,
      'App Notification',
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
      communicationNo,
      subject,
      messageTitle,
      project,
      site,
      location,
      communicationDate,
      dueDate,
      sender,
      recipient,
      language,
      recipientCount,
      message,
      requiredAction,
      actionOwner,
      actionDue,
      actionStatus,
      verification,
      acknowledgedDate,
      acknowledgementEvidence,
      unacknowledgedCount,
      riskReference,
      ramsReference,
      ptwReference,
      incidentReference,
      auditReference,
      legalReference,
      trainingReference,
      emergencyReference,
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

    final dates = <MapEntry<String, TextEditingController>>[
      MapEntry('Communication Date', communicationDate),
      MapEntry('Due Date', dueDate),
      MapEntry('Action Due', actionDue),
      MapEntry('Acknowledged Date', acknowledgedDate),
    ];

    for (final item in dates) {
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
      _error('Action Due cannot be before Communication Due Date.');
      return;
    }

    if (status == 'Sent' &&
        sender.text.trim().isEmpty) {
      _error('Sender is required when status is Sent.');
      return;
    }

    if (acknowledgementStatus == 'Fully Acknowledged' &&
        acknowledgedDate.text.trim().isEmpty) {
      _error(
        'Acknowledged Date is required for Fully Acknowledged status.',
      );
      return;
    }

    if (status == 'Action Required' &&
        requiredAction.text.trim().isEmpty) {
      _error('Required Action is required for Action Required status.');
      return;
    }

    final record = <String, dynamic>{
      'communicationNo': communicationNo.text.trim(),
      'subject': subject.text.trim(),
      'messageTitle': messageTitle.text.trim(),
      'communicationType': communicationType,
      'status': status,
      'priority': priority,
      'project': project.text.trim(),
      'site': site.text.trim(),
      'location': location.text.trim(),
      'communicationDate': communicationDate.text.trim(),
      'dueDate': dueDate.text.trim(),
      'sender': sender.text.trim(),
      'recipient': recipient.text.trim(),
      'audience': audience,
      'channel': channel,
      'language': language.text.trim(),
      'recipientCount': recipientCount.text.trim(),
      'message': message.text.trim(),
      'requiredAction': requiredAction.text.trim(),
      'actionOwner': actionOwner.text.trim(),
      'actionDue': actionDue.text.trim(),
      'actionStatus': actionStatus.text.trim(),
      'verification': verification.text.trim(),
      'acknowledgementStatus': acknowledgementStatus,
      'acknowledgedDate': acknowledgedDate.text.trim(),
      'acknowledgementEvidence':
          acknowledgementEvidence.text.trim(),
      'unacknowledgedCount': unacknowledgedCount.text.trim(),
      'riskReference': riskReference.text.trim(),
      'ramsReference': ramsReference.text.trim(),
      'ptwReference': ptwReference.text.trim(),
      'incidentReference': incidentReference.text.trim(),
      'auditReference': auditReference.text.trim(),
      'legalReference': legalReference.text.trim(),
      'trainingReference': trainingReference.text.trim(),
      'emergencyReference': emergencyReference.text.trim(),
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
        initialChildSize: 0.93,
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
                    const Icon(Icons.campaign, color: darkGreen),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        editing
                            ? 'Edit Communication'
                            : 'Create Communication',
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
                  communicationNo,
                  'Communication No.',
                  required: true,
                ),
                _field(
                  subject,
                  'Subject',
                  required: true,
                ),
                _field(messageTitle, 'Message Title'),
                _dropdown(
                  'Communication Type',
                  communicationType,
                  widget.communicationTypes,
                  (value) => setState(
                    () => communicationType =
                        value ?? communicationType,
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
                _field(project, 'Project'),
                _field(site, 'Site'),
                _field(location, 'Location'),
                _dateField(
                  'Communication Date',
                  communicationDate,
                ),
                _dateField('Due Date', dueDate),
                const SizedBox(height: 3),
                const Text(
                  'Sender & Audience',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                _field(sender, 'Sender'),
                _field(recipient, 'Recipient / Group'),
                _dropdown(
                  'Audience',
                  audience,
                  widget.audiences,
                  (value) => setState(
                    () => audience = value ?? audience,
                  ),
                ),
                _dropdown(
                  'Communication Channel',
                  channel,
                  widget.channels,
                  (value) => setState(
                    () => channel = value ?? channel,
                  ),
                ),
                _field(language, 'Language'),
                _field(recipientCount, 'Recipient / Attendee Count'),
                _field(
                  message,
                  'Message / Communication Content',
                  maxLines: 5,
                ),
                const SizedBox(height: 3),
                const Text(
                  'Action & Verification',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                _field(
                  requiredAction,
                  'Required Action',
                  maxLines: 3,
                ),
                _field(actionOwner, 'Action Owner'),
                _dateField('Action Due', actionDue),
                _field(actionStatus, 'Action Status'),
                _field(
                  verification,
                  'Verification / Effectiveness',
                  maxLines: 3,
                ),
                const SizedBox(height: 3),
                const Text(
                  'Acknowledgement',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                _dropdown(
                  'Acknowledgement Status',
                  acknowledgementStatus,
                  widget.acknowledgementStatuses,
                  (value) => setState(
                    () => acknowledgementStatus =
                        value ?? acknowledgementStatus,
                  ),
                ),
                _dateField(
                  'Acknowledged Date',
                  acknowledgedDate,
                ),
                _field(
                  acknowledgementEvidence,
                  'Acknowledgement Evidence / Reference',
                ),
                _field(
                  unacknowledgedCount,
                  'Unacknowledged Recipient Count',
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
                _field(riskReference, 'Risk / HIRA / JSA Reference'),
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
                  legalReference,
                  'Legal / Authority Reference',
                ),
                _field(
                  trainingReference,
                  'Training / Competency Reference',
                ),
                _field(
                  emergencyReference,
                  'Emergency / ERP Reference',
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
                        ? 'Update Communication'
                        : 'Save Communication',
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
