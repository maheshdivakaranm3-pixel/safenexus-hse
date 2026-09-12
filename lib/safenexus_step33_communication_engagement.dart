import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 33
/// HSE Site Communication & Workforce Engagement Center
///
/// 33A Communication Master
/// 33B Worker Safety Communication
/// 33C Contractor Communication
/// 33D Safety Meeting & Consultation
/// 33E Safety Campaign & Awareness
/// 33F Safety Alert / Bulletin
/// 33G Worker Feedback & Suggestion
/// 33H Safety Committee / Representative
/// 33I Communication Acknowledgement
/// 33J Escalation & Follow-up
/// 33K Communication Closure & Effectiveness
/// 33L Communication Intelligence Dashboard
///
/// Workflow:
/// Plan -> Communicate -> Engage -> Acknowledge -> Capture Feedback
/// -> Action -> Verify -> Close -> Analyze
///
/// Local register using SharedPreferences. Cross-module navigation can be
/// connected through the optional sourceOpener callback.

class SafeNexusStep33CommunicationPage extends StatefulWidget {
  const SafeNexusStep33CommunicationPage({
    super.key,
    this.sourceOpener,
  });

  final void Function(String referenceType, String referenceId)? sourceOpener;

  @override
  State<SafeNexusStep33CommunicationPage> createState() =>
      _SafeNexusStep33CommunicationPageState();
}

class _SafeNexusStep33CommunicationPageState
    extends State<SafeNexusStep33CommunicationPage> {
  static const String storageKey =
      'safenexus_hse_step33_communication_engagement';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _records = [];
  bool _loading = true;
  String _statusFilter = 'All';
  String _moduleFilter = 'All';
  String _priorityFilter = 'All';

  static const List<String> statuses = [
    'Draft',
    'Planned',
    'Published',
    'Acknowledgement Required',
    'Action Required',
    'Verification Required',
    'Completed',
    'Closed',
    'Cancelled',
  ];

  static const List<String> priorities = [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static const List<String> modules = [
    '33A Communication Master',
    '33B Worker Safety Communication',
    '33C Contractor Communication',
    '33D Safety Meeting & Consultation',
    '33E Safety Campaign & Awareness',
    '33F Safety Alert / Bulletin',
    '33G Worker Feedback & Suggestion',
    '33H Safety Committee / Representative',
    '33I Communication Acknowledgement',
    '33J Escalation & Follow-up',
    '33K Communication Closure & Effectiveness',
    '33L Communication Intelligence Dashboard',
  ];

  static const List<String> communicationTypes = [
    'Safety Meeting',
    'Toolbox Talk',
    'Safety Alert',
    'Safety Bulletin',
    'Campaign',
    'Worker Feedback',
    'Contractor Communication',
    'Management Communication',
    'Safety Committee',
    'Emergency Communication',
    'Authority Communication',
    'Training / Awareness',
    'Other',
  ];

  static const List<String> audiences = [
    'Workers',
    'Supervisors',
    'HSE Team',
    'Contractors',
    'Subcontractors',
    'Management',
    'Client',
    'Safety Committee',
    'Authority',
    'All Site Personnel',
  ];

  static const List<String> referenceTypes = [
    'Step 9 Daily HSE',
    'Step 31 Smart Checklist',
    'Step 32 Field Operations',
    'Risk / HIRA / JSA / JHA',
    'RAMS',
    'PTW',
    'Workforce / Competency',
    'Equipment',
    'Incident',
    'Action Center',
  ];

  @override
  void initState() {
    super.initState();
    _loadRecords();
    _searchController.addListener(_refreshView);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refreshView)
      ..dispose();
    super.dispose();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);

    if (raw == null || raw.trim().isEmpty) {
      if (mounted) {
        setState(() {
          _records = [];
          _loading = false;
        });
      }
      return;
    }

    try {
      final decoded = jsonDecode(raw);
      final list = decoded is List ? decoded : <dynamic>[];
      final records = list
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();

      if (mounted) {
        setState(() {
          _records = records;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _records = [];
          _loading = false;
        });
      }
    }
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(_records));
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchController.text.trim().toLowerCase();

    return _records.where((record) {
      final status = '${record['status'] ?? ''}';
      final module = '${record['module'] ?? ''}';
      final priority = '${record['priority'] ?? ''}';

      if (_statusFilter != 'All' && status != _statusFilter) {
        return false;
      }
      if (_moduleFilter != 'All' && module != _moduleFilter) {
        return false;
      }
      if (_priorityFilter != 'All' && priority != _priorityFilter) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      final searchable = [
        record['title'],
        record['project'],
        record['site'],
        record['location'],
        record['communicationType'],
        record['audience'],
        record['message'],
        record['feedback'],
        record['action'],
        record['owner'],
        record['referenceId'],
        record['module'],
        record['notes'],
      ].map((value) => '$value').join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();
  }

  int _countWhere(bool Function(Map<String, dynamic>) test) =>
      _records.where(test).length;

  int get _openCount => _countWhere((r) {
        final status = '${r['status'] ?? ''}';
        return status != 'Closed' &&
            status != 'Cancelled' &&
            status != 'Completed';
      });

  int get _criticalCount =>
      _countWhere((r) => '${r['priority'] ?? ''}' == 'Critical');

  int get _actionCount => _countWhere((r) {
        final status = '${r['status'] ?? ''}';
        return status == 'Action Required' ||
            status == 'Verification Required';
      });

  int get _ackRequiredCount => _countWhere(
        (r) => '${r['status'] ?? ''}' == 'Acknowledgement Required',
      );

  int get _closedCount =>
      _countWhere((r) => '${r['status'] ?? ''}' == 'Closed');

  int get _overdueCount {
    final today = DateTime.now();
    return _countWhere((r) {
      final due = DateTime.tryParse('${r['dueDate'] ?? ''}');
      if (due == null) {
        return false;
      }

      final status = '${r['status'] ?? ''}';
      return due.isBefore(DateTime(today.year, today.month, today.day)) &&
          status != 'Closed' &&
          status != 'Cancelled' &&
          status != 'Completed';
    });
  }

  Future<void> _openForm({Map<String, dynamic>? existing}) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _CommunicationForm(
        existing: existing,
      ),
    );

    if (result == null) {
      return;
    }

    final record = Map<String, dynamic>.from(result);
    final existingId = existing?['id'];

    if (existingId != null) {
      final index = _records.indexWhere((r) => r['id'] == existingId);
      if (index >= 0) {
        record['id'] = existingId;
        record['createdAt'] = _records[index]['createdAt'];
        record['updatedAt'] = DateTime.now().toIso8601String();
        record['history'] = [
          ...List<dynamic>.from(_records[index]['history'] ?? const []),
          {
            'event': 'Updated',
            'at': DateTime.now().toIso8601String(),
          },
        ];
        _records[index] = record;
      }
    } else {
      record['id'] = 'COM-${DateTime.now().millisecondsSinceEpoch}';
      record['createdAt'] = DateTime.now().toIso8601String();
      record['updatedAt'] = DateTime.now().toIso8601String();
      record['history'] = [
        {
          'event': 'Created',
          'at': DateTime.now().toIso8601String(),
        },
      ];
      _records.insert(0, record);
    }

    await _saveRecords();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete communication record?'),
        content: Text(
          'Remove "${record['title'] ?? 'this record'}" from the local '
          'Step 33 register?',
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

    if (confirmed != true) {
      return;
    }

    _records.removeWhere((r) => r['id'] == record['id']);
    await _saveRecords();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _clearAll() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Step 33 records?'),
        content: const Text(
          'All locally stored communication and engagement records '
          'will be deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );

    if (confirmed != true) {
      return;
    }

    _records.clear();
    await _saveRecords();

    if (mounted) {
      setState(() {});
    }
  }

  void _refreshView() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Step 33 • Communication'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Clear all',
            onPressed: _records.isEmpty ? null : _clearAll,
            icon: const Icon(Icons.delete_sweep_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add),
        label: const Text('New Communication'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadRecords,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                children: [
                  _headerCard(),
                  const SizedBox(height: 12),
                  _workflowCard(),
                  const SizedBox(height: 12),
                  _summaryCards(),
                  const SizedBox(height: 12),
                  _filters(),
                  const SizedBox(height: 12),
                  if (filtered.isEmpty)
                    _emptyState()
                  else
                    ...filtered.map(_recordCard),
                ],
              ),
            ),
    );
  }

  Widget _headerCard() {
    return Card(
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [darkGreen, primaryGreen],
          ),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.groups_2_outlined, color: Colors.white, size: 30),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'HSE Site Communication & Workforce Engagement Center',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Communicate • Engage • Acknowledge • Improve',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            SizedBox(height: 12),
            Text(
              'Step 33 manages worker, contractor, management, committee, '
              'campaign, alert, feedback and communication effectiveness '
              'records.',
              style: TextStyle(color: Colors.white, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _workflowCard() {
    const steps = [
      'Plan',
      'Communicate',
      'Engage',
      'Acknowledge',
      'Feedback',
      'Action',
      'Verify',
      'Close',
      'Analyze',
    ];

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '33 Workflow',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var i = 0; i < steps.length; i++)
                  Chip(
                    avatar: CircleAvatar(
                      backgroundColor: primaryGreen,
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    label: Text(steps[i]),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCards() {
    final values = [
      ('Total', _records.length, Icons.forum_outlined),
      ('Open', _openCount, Icons.pending_actions_outlined),
      ('Actions', _actionCount, Icons.assignment_late_outlined),
      ('Ack. Required', _ackRequiredCount, Icons.mark_email_unread_outlined),
      ('Critical', _criticalCount, Icons.priority_high_outlined),
      ('Overdue', _overdueCount, Icons.schedule_outlined),
      ('Closed', _closedCount, Icons.task_alt_outlined),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: values.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.15,
      ),
      itemBuilder: (context, index) {
        final item = values[index];
        return Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(item.$3, color: primaryGreen),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item.$2}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(item.$1),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _filters() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search communication records',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: _searchController.clear,
                        icon: const Icon(Icons.clear),
                      ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            _filterDropdown(
              'Status',
              _statusFilter,
              [
                'All',
                ...statuses,
              ],
              (value) => setState(() => _statusFilter = value),
            ),
            const SizedBox(height: 10),
            _filterDropdown(
              'Step 33 module',
              _moduleFilter,
              [
                'All',
                ...modules,
              ],
              (value) => setState(() => _moduleFilter = value),
            ),
            const SizedBox(height: 10),
            _filterDropdown(
              'Priority',
              _priorityFilter,
              [
                'All',
                ...priorities,
              ],
              (value) => setState(() => _priorityFilter = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterDropdown(
    String label,
    String value,
    List<String> values,
    ValueChanged<String> onChanged,
  ) {
    final safeValue = values.contains(value) ? value : values.first;

    return DropdownButtonFormField<String>(
      initialValue: safeValue,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: values
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: (selected) {
        if (selected != null) {
          onChanged(selected);
        }
      },
    );
  }

  Widget _emptyState() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Icon(
              Icons.record_voice_over_outlined,
              size: 54,
              color: primaryGreen,
            ),
            const SizedBox(height: 12),
            const Text(
              'No communication records found',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create a safety meeting, alert, campaign, feedback, '
              'committee or worker communication record.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            FilledButton.icon(
              onPressed: () => _openForm(),
              icon: const Icon(Icons.add),
              label: const Text('Create First Record'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recordCard(Map<String, dynamic> record) {
    final status = '${record['status'] ?? 'Draft'}';
    final priority = '${record['priority'] ?? 'Medium'}';
    final dueDate = DateTime.tryParse('${record['dueDate'] ?? ''}');

    final overdue = dueDate != null &&
        dueDate.isBefore(
          DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
        ) &&
        status != 'Closed' &&
        status != 'Cancelled' &&
        status != 'Completed';

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
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
                      '${record['title'] ?? 'Untitled communication'}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _openForm(existing: record);
                      } else if (value == 'delete') {
                        _deleteRecord(record);
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text('${record['module'] ?? ''}'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  Chip(
                    avatar: const Icon(Icons.circle, size: 12),
                    label: Text(status),
                  ),
                  Chip(label: Text(priority)),
                  if (overdue)
                    const Chip(
                      avatar: Icon(Icons.schedule, size: 16),
                      label: Text('OVERDUE'),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              _detailLine(
                Icons.campaign_outlined,
                '${record['communicationType'] ?? '-'}',
              ),
              _detailLine(
                Icons.groups_outlined,
                'Audience: ${record['audience'] ?? '-'}',
              ),
              _detailLine(
                Icons.business_outlined,
                '${record['project'] ?? '-'} • ${record['site'] ?? '-'}',
              ),
              _detailLine(
                Icons.place_outlined,
                '${record['location'] ?? '-'}',
              ),
              if ('${record['owner'] ?? ''}'.trim().isNotEmpty)
                _detailLine(
                  Icons.person_outline,
                  'Owner: ${record['owner']}',
                ),
              if (dueDate != null)
                _detailLine(
                  Icons.event_outlined,
                  'Due: ${_dateOnly(dueDate)}',
                ),
              if ('${record['feedback'] ?? ''}'.trim().isNotEmpty)
                _detailLine(
                  Icons.feedback_outlined,
                  '${record['feedback']}',
                ),
              const SizedBox(height: 8),
              _referenceWrap(record),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailLine(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: darkGreen),
          const SizedBox(width: 7),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _referenceWrap(Map<String, dynamic> record) {
    final refs = List<dynamic>.from(record['references'] ?? const []);

    if (refs.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: refs.map((item) {
        final map = item is Map ? Map<String, dynamic>.from(item) : {};
        final type = '${map['type'] ?? 'Reference'}';
        final id = '${map['id'] ?? ''}';

        return ActionChip(
          avatar: const Icon(Icons.link, size: 16),
          label: Text('$type${id.isEmpty ? '' : ': $id'}'),
          onPressed: id.isEmpty || widget.sourceOpener == null
              ? null
              : () => widget.sourceOpener!(type, id),
        );
      }).toList(),
    );
  }

  void _showDetails(Map<String, dynamic> record) {
    final history = List<dynamic>.from(record['history'] ?? const []);
    final refs = List<dynamic>.from(record['references'] ?? const []);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.84,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (context, controller) {
              return ListView(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(18, 4, 18, 30),
                children: [
                  Text(
                    '${record['title'] ?? 'Communication Record'}',
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('${record['module'] ?? ''}'),
                  const Divider(height: 28),
                  _detailLine(
                    Icons.info_outline,
                    'Status: ${record['status']}',
                  ),
                  _detailLine(
                    Icons.flag_outlined,
                    'Priority: ${record['priority']}',
                  ),
                  _detailLine(
                    Icons.campaign_outlined,
                    'Type: ${record['communicationType']}',
                  ),
                  _detailLine(
                    Icons.groups_outlined,
                    'Audience: ${record['audience']}',
                  ),
                  _detailLine(
                    Icons.business_outlined,
                    'Project: ${record['project']}',
                  ),
                  _detailLine(
                    Icons.location_city_outlined,
                    'Site: ${record['site']}',
                  ),
                  _detailLine(
                    Icons.place_outlined,
                    'Location: ${record['location']}',
                  ),
                  _detailLine(
                    Icons.person_outline,
                    'Owner: ${record['owner']}',
                  ),
                  _sectionText('Message / Communication',
                      '${record['message'] ?? ''}'),
                  if ('${record['feedback'] ?? ''}'.trim().isNotEmpty)
                    _sectionText(
                      'Worker / Audience Feedback',
                      '${record['feedback']}',
                    ),
                  if ('${record['acknowledgement'] ?? ''}'
                      .trim()
                      .isNotEmpty)
                    _sectionText(
                      'Acknowledgement',
                      '${record['acknowledgement']}',
                    ),
                  if ('${record['action'] ?? ''}'.trim().isNotEmpty)
                    _sectionText(
                      'Action / Follow-up',
                      '${record['action']}',
                    ),
                  if ('${record['verification'] ?? ''}'
                      .trim()
                      .isNotEmpty)
                    _sectionText(
                      'Verification / Effectiveness',
                      '${record['verification']}',
                    ),
                  if ('${record['escalation'] ?? ''}'.trim().isNotEmpty)
                    _sectionText(
                      'Escalation',
                      '${record['escalation']}',
                    ),
                  if ('${record['notes'] ?? ''}'.trim().isNotEmpty)
                    _sectionText('Notes', '${record['notes']}'),
                  if (refs.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    const Text(
                      'Integrated References',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _referenceWrap(record),
                  ],
                  if (history.isNotEmpty) ...[
                    const SizedBox(height: 18),
                    const Text(
                      'History / Audit Trail',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...history.reversed.map(
                      (event) => ListTile(
                        dense: true,
                        leading: const Icon(Icons.history),
                        title: Text('${event['event'] ?? 'Event'}'),
                        subtitle: Text('${event['at'] ?? ''}'),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _sectionText(String title, String value) {
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
            ),
          ),
          const SizedBox(height: 5),
          Text(value),
        ],
      ),
    );
  }

  String _dateOnly(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}

class _CommunicationForm extends StatefulWidget {
  const _CommunicationForm({
    this.existing,
  });

  final Map<String, dynamic>? existing;

  @override
  State<_CommunicationForm> createState() => _CommunicationFormState();
}

class _CommunicationFormState extends State<_CommunicationForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _projectController;
  late final TextEditingController _siteController;
  late final TextEditingController _locationController;
  late final TextEditingController _messageController;
  late final TextEditingController _feedbackController;
  late final TextEditingController _ackController;
  late final TextEditingController _actionController;
  late final TextEditingController _verificationController;
  late final TextEditingController _escalationController;
  late final TextEditingController _ownerController;
  late final TextEditingController _facilitatorController;
  late final TextEditingController _referenceIdController;
  late final TextEditingController _notesController;
  late final TextEditingController _dueDateController;

  String _module = '33A Communication Master';
  String _status = 'Draft';
  String _priority = 'Medium';
  String _communicationType = 'Safety Meeting';
  String _audience = 'Workers';
  String _referenceType = 'Step 9 Daily HSE';

  bool _acknowledgementRequired = false;
  bool _published = false;
  bool _feedbackCaptured = false;
  bool _actionAssigned = false;
  bool _effectivenessVerified = false;

  @override
  void initState() {
    super.initState();
    final e = widget.existing ?? {};

    _titleController = TextEditingController(text: '${e['title'] ?? ''}');
    _projectController = TextEditingController(text: '${e['project'] ?? ''}');
    _siteController = TextEditingController(text: '${e['site'] ?? ''}');
    _locationController =
        TextEditingController(text: '${e['location'] ?? ''}');
    _messageController = TextEditingController(text: '${e['message'] ?? ''}');
    _feedbackController =
        TextEditingController(text: '${e['feedback'] ?? ''}');
    _ackController =
        TextEditingController(text: '${e['acknowledgement'] ?? ''}');
    _actionController = TextEditingController(text: '${e['action'] ?? ''}');
    _verificationController =
        TextEditingController(text: '${e['verification'] ?? ''}');
    _escalationController =
        TextEditingController(text: '${e['escalation'] ?? ''}');
    _ownerController = TextEditingController(text: '${e['owner'] ?? ''}');
    _facilitatorController =
        TextEditingController(text: '${e['facilitator'] ?? ''}');
    _referenceIdController =
        TextEditingController(text: '${e['referenceId'] ?? ''}');
    _notesController = TextEditingController(text: '${e['notes'] ?? ''}');
    _dueDateController = TextEditingController(text: '${e['dueDate'] ?? ''}');

    _module = '${e['module'] ?? _module}';
    _status = '${e['status'] ?? _status}';
    _priority = '${e['priority'] ?? _priority}';
    _communicationType =
        '${e['communicationType'] ?? _communicationType}';
    _audience = '${e['audience'] ?? _audience}';
    _referenceType = '${e['referenceType'] ?? _referenceType}';

    _acknowledgementRequired = e['acknowledgementRequired'] == true;
    _published = e['published'] == true;
    _feedbackCaptured = e['feedbackCaptured'] == true;
    _actionAssigned = e['actionAssigned'] == true;
    _effectivenessVerified = e['effectivenessVerified'] == true;
  }

  @override
  void dispose() {
    for (final controller in [
      _titleController,
      _projectController,
      _siteController,
      _locationController,
      _messageController,
      _feedbackController,
      _ackController,
      _actionController,
      _verificationController,
      _escalationController,
      _ownerController,
      _facilitatorController,
      _referenceIdController,
      _notesController,
      _dueDateController,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDueDate() async {
    final current = DateTime.tryParse(_dueDateController.text);
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: current ?? DateTime.now(),
    );

    if (picked != null) {
      _dueDateController.text =
          '${picked.year.toString().padLeft(4, '0')}-'
          '${picked.month.toString().padLeft(2, '0')}-'
          '${picked.day.toString().padLeft(2, '0')}';
      setState(() {});
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final references = <Map<String, dynamic>>[];
    if (_referenceIdController.text.trim().isNotEmpty) {
      references.add({
        'type': _referenceType,
        'id': _referenceIdController.text.trim(),
      });
    }

    Navigator.pop(context, {
      'title': _titleController.text.trim(),
      'module': _module,
      'status': _status,
      'priority': _priority,
      'communicationType': _communicationType,
      'audience': _audience,
      'project': _projectController.text.trim(),
      'site': _siteController.text.trim(),
      'location': _locationController.text.trim(),
      'message': _messageController.text.trim(),
      'feedback': _feedbackController.text.trim(),
      'acknowledgement': _ackController.text.trim(),
      'action': _actionController.text.trim(),
      'verification': _verificationController.text.trim(),
      'escalation': _escalationController.text.trim(),
      'owner': _ownerController.text.trim(),
      'facilitator': _facilitatorController.text.trim(),
      'referenceType': _referenceType,
      'referenceId': _referenceIdController.text.trim(),
      'references': references,
      'notes': _notesController.text.trim(),
      'dueDate': _dueDateController.text.trim(),
      'acknowledgementRequired': _acknowledgementRequired,
      'published': _published,
      'feedbackCaptured': _feedbackCaptured,
      'actionAssigned': _actionAssigned,
      'effectivenessVerified': _effectivenessVerified,
    });
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.existing != null;

    return AlertDialog(
      title: Text(
        editing ? 'Edit Communication Record' : 'New Communication Record',
      ),
      content: SizedBox(
        width: 620,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _textField(
                  _titleController,
                  'Communication title',
                  required: true,
                ),
                _dropdown(
                  'Step 33 module',
                  _module,
                  [
                    '33A Communication Master',
                    '33B Worker Safety Communication',
                    '33C Contractor Communication',
                    '33D Safety Meeting & Consultation',
                    '33E Safety Campaign & Awareness',
                    '33F Safety Alert / Bulletin',
                    '33G Worker Feedback & Suggestion',
                    '33H Safety Committee / Representative',
                    '33I Communication Acknowledgement',
                    '33J Escalation & Follow-up',
                    '33K Communication Closure & Effectiveness',
                    '33L Communication Intelligence Dashboard',
                  ],
                  (value) => setState(() => _module = value),
                ),
                _dropdown(
                  'Status',
                  _status,
                  [
                    'Draft',
                    'Planned',
                    'Published',
                    'Acknowledgement Required',
                    'Action Required',
                    'Verification Required',
                    'Completed',
                    'Closed',
                    'Cancelled',
                  ],
                  (value) => setState(() => _status = value),
                ),
                _dropdown(
                  'Priority',
                  _priority,
                  ['Low', 'Medium', 'High', 'Critical'],
                  (value) => setState(() => _priority = value),
                ),
                _dropdown(
                  'Communication type',
                  _communicationType,
                  [
                    'Safety Meeting',
                    'Toolbox Talk',
                    'Safety Alert',
                    'Safety Bulletin',
                    'Campaign',
                    'Worker Feedback',
                    'Contractor Communication',
                    'Management Communication',
                    'Safety Committee',
                    'Emergency Communication',
                    'Authority Communication',
                    'Training / Awareness',
                    'Other',
                  ],
                  (value) =>
                      setState(() => _communicationType = value),
                ),
                _dropdown(
                  'Audience',
                  _audience,
                  [
                    'Workers',
                    'Supervisors',
                    'HSE Team',
                    'Contractors',
                    'Subcontractors',
                    'Management',
                    'Client',
                    'Safety Committee',
                    'Authority',
                    'All Site Personnel',
                  ],
                  (value) => setState(() => _audience = value),
                ),
                _textField(_projectController, 'Project'),
                _textField(_siteController, 'Site'),
                _textField(_locationController, 'Location / Area'),
                _textField(
                  _facilitatorController,
                  'Facilitator / communicator',
                ),
                _textField(
                  _ownerController,
                  'Action / communication owner',
                ),
                _textField(
                  _messageController,
                  'Message / communication content',
                  maxLines: 4,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Published / communicated'),
                  value: _published,
                  onChanged: (value) =>
                      setState(() => _published = value),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Acknowledgement required'),
                  value: _acknowledgementRequired,
                  onChanged: (value) => setState(
                    () => _acknowledgementRequired = value,
                  ),
                ),
                _textField(
                  _ackController,
                  'Acknowledgement / attendance record',
                  maxLines: 3,
                ),
                _textField(
                  _feedbackController,
                  'Worker / audience feedback',
                  maxLines: 3,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Feedback captured'),
                  value: _feedbackCaptured,
                  onChanged: (value) =>
                      setState(() => _feedbackCaptured = value),
                ),
                _textField(
                  _actionController,
                  'Action / follow-up',
                  maxLines: 3,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Action assigned'),
                  value: _actionAssigned,
                  onChanged: (value) =>
                      setState(() => _actionAssigned = value),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Follow-up due date'),
                  subtitle: Text(
                    _dueDateController.text.isEmpty
                        ? 'Not set'
                        : _dueDateController.text,
                  ),
                  trailing: IconButton(
                    onPressed: _pickDueDate,
                    icon: const Icon(Icons.calendar_month_outlined),
                  ),
                ),
                _textField(
                  _verificationController,
                  'Effectiveness / verification',
                  maxLines: 3,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Effectiveness verified'),
                  value: _effectivenessVerified,
                  onChanged: (value) => setState(
                    () => _effectivenessVerified = value,
                  ),
                ),
                _textField(
                  _escalationController,
                  'Escalation / unresolved issue',
                  maxLines: 3,
                ),
                const Divider(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Integration Reference',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                _dropdown(
                  'Reference source',
                  _referenceType,
                  [
                    'Step 9 Daily HSE',
                    'Step 31 Smart Checklist',
                    'Step 32 Field Operations',
                    'Risk / HIRA / JSA / JHA',
                    'RAMS',
                    'PTW',
                    'Workforce / Competency',
                    'Equipment',
                    'Incident',
                    'Action Center',
                  ],
                  (value) => setState(() => _referenceType = value),
                ),
                _textField(
                  _referenceIdController,
                  'Reference ID',
                ),
                _textField(
                  _notesController,
                  'Notes',
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: _submit,
          icon: const Icon(Icons.save_outlined),
          label: Text(editing ? 'Update' : 'Save'),
        ),
      ],
    );
  }

  Widget _textField(
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
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: required
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Required';
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
    List<String> values,
    ValueChanged<String> onChanged,
  ) {
    final safeValue = values.contains(value) ? value : values.first;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        initialValue: safeValue,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: values
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ),
            )
            .toList(),
        onChanged: (selected) {
          if (selected != null) {
            onChanged(selected);
          }
        },
      ),
    );
  }
}
