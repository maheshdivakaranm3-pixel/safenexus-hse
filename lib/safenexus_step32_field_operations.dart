import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 32
/// HSE Field Operations & Mobile Work Center
///
/// Modules:
/// 32A Field Work Master
/// 32B Daily HSE Field Plan
/// 32C Site Walk / Field Observation
/// 32D Hazard & Unsafe Condition Capture
/// 32E Immediate Corrective Action
/// 32F Worker / Contractor Engagement
/// 32G Toolbox Talk Field Record
/// 32H Permit / Risk / RAMS Field Verification
/// 32I Equipment & PPE Field Verification
/// 32J Finding Escalation & Follow-up
/// 32K Field Action Closure & Verification
/// 32L Field HSE Intelligence Dashboard
///
/// Clean analyzer version:
/// • Removed unused referenceTypes declaration.
/// • Removed unused _referenceId field.
/// • Reference ID remains fully supported through the controller and saved record.
/// • All 32A–32L functionality remains available.
/// • SharedPreferences local storage.
/// • CRUD, search, filters, workflow, verification, references and history.

class SafeNexusStep32FieldOperationsPage extends StatefulWidget {
  const SafeNexusStep32FieldOperationsPage({
    super.key,
    this.sourceOpener,
  });

  final void Function(String referenceType, String referenceId)? sourceOpener;

  @override
  State<SafeNexusStep32FieldOperationsPage> createState() =>
      _SafeNexusStep32FieldOperationsPageState();
}

class _SafeNexusStep32FieldOperationsPageState
    extends State<SafeNexusStep32FieldOperationsPage> {
  static const String storageKey = 'safenexus_hse_step32_field_operations';

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
    'Planned',
    'In Progress',
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
    '32A Field Work Master',
    '32B Daily HSE Field Plan',
    '32C Site Walk / Field Observation',
    '32D Hazard & Unsafe Condition Capture',
    '32E Immediate Corrective Action',
    '32F Worker / Contractor Engagement',
    '32G Toolbox Talk Field Record',
    '32H Permit / Risk / RAMS Field Verification',
    '32I Equipment & PPE Field Verification',
    '32J Finding Escalation & Follow-up',
    '32K Field Action Closure & Verification',
    '32L Field HSE Intelligence Dashboard',
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

      if (_statusFilter != 'All' && status != _statusFilter) return false;
      if (_moduleFilter != 'All' && module != _moduleFilter) return false;
      if (_priorityFilter != 'All' && priority != _priorityFilter) {
        return false;
      }

      if (query.isEmpty) return true;

      final searchable = [
        record['title'],
        record['project'],
        record['site'],
        record['location'],
        record['activity'],
        record['finding'],
        record['owner'],
        record['worker'],
        record['contractor'],
        record['module'],
        record['referenceId'],
        record['notes'],
      ].map((value) => '$value').join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();
  }

  int _countWhere(bool Function(Map<String, dynamic>) test) =>
      _records.where(test).length;

  int get _openCount => _countWhere((r) {
        final status = '${r['status'] ?? ''}';
        return status != 'Closed' && status != 'Cancelled';
      });

  int get _criticalCount =>
      _countWhere((r) => '${r['priority'] ?? ''}' == 'Critical');

  int get _actionCount => _countWhere((r) {
        final status = '${r['status'] ?? ''}';
        return status == 'Action Required' ||
            status == 'Verification Required';
      });

  int get _closedCount =>
      _countWhere((r) => '${r['status'] ?? ''}' == 'Closed');

  int get _overdueCount {
    final today = DateTime.now();
    return _countWhere((r) {
      final due = DateTime.tryParse('${r['dueDate'] ?? ''}');
      if (due == null) return false;
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
      builder: (context) => _FieldOperationForm(
        existing: existing,
        sourceOpener: widget.sourceOpener,
      ),
    );

    if (result == null) return;

    final record = Map<String, dynamic>.from(result);
    final existingId = existing?['id'];
    final now = DateTime.now().toIso8601String();

    if (existingId != null) {
      final index = _records.indexWhere((r) => r['id'] == existingId);

      if (index >= 0) {
        record['id'] = existingId;
        record['updatedAt'] = now;
        record['createdAt'] =
            _records[index]['createdAt'] ?? now;

        record['history'] = [
          ...List<dynamic>.from(
            _records[index]['history'] ?? const [],
          ),
          {
            'event': 'Updated',
            'at': now,
          },
        ];

        _records[index] = record;
      }
    } else {
      record['id'] = 'FO-${DateTime.now().millisecondsSinceEpoch}';
      record['createdAt'] = now;
      record['updatedAt'] = now;
      record['history'] = [
        {
          'event': 'Created',
          'at': now,
        },
      ];
      _records.insert(0, record);
    }

    await _saveRecords();

    if (mounted) setState(() {});
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete field record?'),
        content: Text(
          'This will remove "${record['title'] ?? 'this record'}" '
          'from the local Step 32 register.',
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

    _records.removeWhere((r) => r['id'] == record['id']);
    await _saveRecords();

    if (mounted) setState(() {});
  }

  Future<void> _clearAll() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Step 32 records?'),
        content: const Text(
          'All locally stored Step 32 field-operation records will be deleted.',
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

    if (confirmed != true) return;

    _records.clear();
    await _saveRecords();

    if (mounted) setState(() {});
  }

  void _refreshView() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Step 32 • Field Operations'),
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
        label: const Text('New Field Record'),
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
                Icon(
                  Icons.location_searching,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'HSE Field Operations & Mobile Work Center',
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
              'Plan • Observe • Control • Verify • Close',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Step 32 integrates field activities with Daily HSE, Smart '
              'Checklists, Risk, PTW, RAMS, Workforce, Equipment, Incident '
              'and the Action Center.',
              style: TextStyle(
                color: Colors.white,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _workflowCard() {
    const steps = [
      'Plan',
      'Visit Site',
      'Observe',
      'Record Hazard',
      'Control',
      'Assign Action',
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
              '32 Workflow',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
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
      ('Total', _records.length, Icons.list_alt_outlined),
      ('Open', _openCount, Icons.pending_actions_outlined),
      ('Actions', _actionCount, Icons.assignment_late_outlined),
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
        childAspectRatio: 2.2,
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
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
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
                labelText: 'Search field records',
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
            DropdownButtonFormField<String>(
              initialValue: _statusFilter,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(
                  value: 'All',
                  child: Text('All'),
                ),
                ...statuses.map(
                  (value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  ),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _statusFilter = value);
                }
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _moduleFilter,
              decoration: const InputDecoration(
                labelText: 'Step 32 module',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(
                  value: 'All',
                  child: Text('All'),
                ),
                ...modules.map(
                  (value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  ),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _moduleFilter = value);
                }
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _priorityFilter,
              decoration: const InputDecoration(
                labelText: 'Priority',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(
                  value: 'All',
                  child: Text('All'),
                ),
                ...priorities.map(
                  (value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  ),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _priorityFilter = value);
                }
              },
            ),
          ],
        ),
      ),
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
              Icons.fact_check_outlined,
              size: 54,
              color: primaryGreen,
            ),
            const SizedBox(height: 12),
            const Text(
              'No field records found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create a field plan, site observation, hazard, verification '
              'or closure record to start Step 32.',
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
    final status = '${record['status'] ?? 'Planned'}';
    final priority = '${record['priority'] ?? 'Medium'}';
    final dueDate =
        DateTime.tryParse('${record['dueDate'] ?? ''}');

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
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${record['title'] ?? 'Untitled field record'}',
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
              const SizedBox(height: 9),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _statusChip(status),
                  Chip(label: Text(priority)),
                  if (overdue)
                    const Chip(
                      avatar: Icon(
                        Icons.schedule,
                        size: 16,
                      ),
                      label: Text('OVERDUE'),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              _detailLine(
                Icons.business_outlined,
                '${record['project'] ?? '-'} • '
                '${record['site'] ?? '-'}',
              ),
              _detailLine(
                Icons.place_outlined,
                '${record['location'] ?? '-'}',
              ),
              _detailLine(
                Icons.engineering_outlined,
                '${record['activity'] ?? '-'}',
              ),
              if ('${record['finding'] ?? ''}'.trim().isNotEmpty)
                _detailLine(
                  Icons.warning_amber_outlined,
                  '${record['finding']}',
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
              const SizedBox(height: 8),
              _referenceWrap(record),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusChip(String status) {
    return Chip(
      avatar: const Icon(Icons.circle, size: 12),
      label: Text(status),
    );
  }

  Widget _detailLine(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: darkGreen,
          ),
          const SizedBox(width: 7),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _referenceWrap(Map<String, dynamic> record) {
    final refs =
        List<dynamic>.from(record['references'] ?? const []);

    if (refs.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: refs.map((item) {
        final map =
            item is Map ? Map<String, dynamic>.from(item) : {};

        final type = '${map['type'] ?? 'Reference'}';
        final id = '${map['id'] ?? ''}';

        return ActionChip(
          avatar: const Icon(
            Icons.link,
            size: 16,
          ),
          label: Text(
            '$type${id.isEmpty ? '' : ': $id'}',
          ),
          onPressed:
              id.isEmpty || widget.sourceOpener == null
                  ? null
                  : () => widget.sourceOpener!(type, id),
        );
      }).toList(),
    );
  }

  void _showDetails(Map<String, dynamic> record) {
    final history =
        List<dynamic>.from(record['history'] ?? const []);
    final refs =
        List<dynamic>.from(record['references'] ?? const []);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.82,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (context, controller) {
              return ListView(
                controller: controller,
                padding:
                    const EdgeInsets.fromLTRB(18, 4, 18, 30),
                children: [
                  Text(
                    '${record['title'] ?? 'Field Record'}',
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
                    Icons.work_outline,
                    'Activity: ${record['activity']}',
                  ),
                  _detailLine(
                    Icons.person_outline,
                    'Owner: ${record['owner']}',
                  ),
                  _detailLine(
                    Icons.groups_outlined,
                    'Worker / Contractor: '
                    '${record['worker']} / ${record['contractor']}',
                  ),
                  if ('${record['observation'] ?? ''}'
                      .trim()
                      .isNotEmpty)
                    _sectionText(
                      'Observation',
                      '${record['observation']}',
                    ),
                  if ('${record['finding'] ?? ''}'
                      .trim()
                      .isNotEmpty)
                    _sectionText(
                      'Finding / Hazard',
                      '${record['finding']}',
                    ),
                  if ('${record['immediateControl'] ?? ''}'
                      .trim()
                      .isNotEmpty)
                    _sectionText(
                      'Immediate Control',
                      '${record['immediateControl']}',
                    ),
                  if ('${record['action'] ?? ''}'
                      .trim()
                      .isNotEmpty)
                    _sectionText(
                      'Action',
                      '${record['action']}',
                    ),
                  if ('${record['verification'] ?? ''}'
                      .trim()
                      .isNotEmpty)
                    _sectionText(
                      'Verification',
                      '${record['verification']}',
                    ),
                  if ('${record['escalation'] ?? ''}'
                      .trim()
                      .isNotEmpty)
                    _sectionText(
                      'Escalation / Follow-up',
                      '${record['escalation']}',
                    ),
                  if ('${record['notes'] ?? ''}'
                      .trim()
                      .isNotEmpty)
                    _sectionText(
                      'Notes',
                      '${record['notes']}',
                    ),
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
                        leading:
                            const Icon(Icons.history),
                        title: Text(
                          '${event['event'] ?? 'Event'}',
                        ),
                        subtitle: Text(
                          '${event['at'] ?? ''}',
                        ),
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
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

class _FieldOperationForm extends StatefulWidget {
  const _FieldOperationForm({
    this.existing,
    this.sourceOpener,
  });

  final Map<String, dynamic>? existing;
  final void Function(String referenceType, String referenceId)? sourceOpener;

  @override
  State<_FieldOperationForm> createState() =>
      _FieldOperationFormState();
}

class _FieldOperationFormState
    extends State<_FieldOperationForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _projectController;
  late final TextEditingController _siteController;
  late final TextEditingController _locationController;
  late final TextEditingController _activityController;
  late final TextEditingController _observationController;
  late final TextEditingController _findingController;
  late final TextEditingController _controlController;
  late final TextEditingController _actionController;
  late final TextEditingController _verificationController;
  late final TextEditingController _escalationController;
  late final TextEditingController _ownerController;
  late final TextEditingController _workerController;
  late final TextEditingController _contractorController;
  late final TextEditingController _referenceIdController;
  late final TextEditingController _notesController;
  late final TextEditingController _dueDateController;

  String _module = '32A Field Work Master';
  String _status = 'Planned';
  String _priority = 'Medium';
  String _referenceType = 'Step 9 Daily HSE';

  bool _immediateControlApplied = false;
  bool _permitVerified = false;
  bool _riskVerified = false;
  bool _ramsVerified = false;
  bool _competencyVerified = false;
  bool _equipmentVerified = false;
  bool _ppeVerified = false;

  @override
  void initState() {
    super.initState();

    final e = widget.existing ?? {};

    _titleController =
        TextEditingController(text: '${e['title'] ?? ''}');
    _projectController =
        TextEditingController(text: '${e['project'] ?? ''}');
    _siteController =
        TextEditingController(text: '${e['site'] ?? ''}');
    _locationController =
        TextEditingController(text: '${e['location'] ?? ''}');
    _activityController =
        TextEditingController(text: '${e['activity'] ?? ''}');
    _observationController =
        TextEditingController(text: '${e['observation'] ?? ''}');
    _findingController =
        TextEditingController(text: '${e['finding'] ?? ''}');
    _controlController =
        TextEditingController(text: '${e['immediateControl'] ?? ''}');
    _actionController =
        TextEditingController(text: '${e['action'] ?? ''}');
    _verificationController =
        TextEditingController(text: '${e['verification'] ?? ''}');
    _escalationController =
        TextEditingController(text: '${e['escalation'] ?? ''}');
    _ownerController =
        TextEditingController(text: '${e['owner'] ?? ''}');
    _workerController =
        TextEditingController(text: '${e['worker'] ?? ''}');
    _contractorController =
        TextEditingController(text: '${e['contractor'] ?? ''}');
    _referenceIdController =
        TextEditingController(text: '${e['referenceId'] ?? ''}');
    _notesController =
        TextEditingController(text: '${e['notes'] ?? ''}');
    _dueDateController =
        TextEditingController(text: '${e['dueDate'] ?? ''}');

    _module = '${e['module'] ?? _module}';
    _status = '${e['status'] ?? _status}';
    _priority = '${e['priority'] ?? _priority}';
    _referenceType =
        '${e['referenceType'] ?? _referenceType}';

    _immediateControlApplied =
        e['immediateControlApplied'] == true;
    _permitVerified = e['permitVerified'] == true;
    _riskVerified = e['riskVerified'] == true;
    _ramsVerified = e['ramsVerified'] == true;
    _competencyVerified =
        e['competencyVerified'] == true;
    _equipmentVerified =
        e['equipmentVerified'] == true;
    _ppeVerified = e['ppeVerified'] == true;
  }

  @override
  void dispose() {
    for (final controller in [
      _titleController,
      _projectController,
      _siteController,
      _locationController,
      _activityController,
      _observationController,
      _findingController,
      _controlController,
      _actionController,
      _verificationController,
      _escalationController,
      _ownerController,
      _workerController,
      _contractorController,
      _referenceIdController,
      _notesController,
      _dueDateController,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDueDate() async {
    final current =
        DateTime.tryParse(_dueDateController.text);

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
    if (!_formKey.currentState!.validate()) return;

    final referenceId =
        _referenceIdController.text.trim();

    final references = <Map<String, dynamic>>[];

    if (referenceId.isNotEmpty) {
      references.add({
        'type': _referenceType,
        'id': referenceId,
      });
    }

    Navigator.pop(
      context,
      {
        'title': _titleController.text.trim(),
        'module': _module,
        'status': _status,
        'priority': _priority,
        'project': _projectController.text.trim(),
        'site': _siteController.text.trim(),
        'location': _locationController.text.trim(),
        'activity': _activityController.text.trim(),
        'observation':
            _observationController.text.trim(),
        'finding': _findingController.text.trim(),
        'immediateControl':
            _controlController.text.trim(),
        'action': _actionController.text.trim(),
        'verification':
            _verificationController.text.trim(),
        'escalation':
            _escalationController.text.trim(),
        'owner': _ownerController.text.trim(),
        'worker': _workerController.text.trim(),
        'contractor':
            _contractorController.text.trim(),
        'referenceType': _referenceType,
        'referenceId': referenceId,
        'references': references,
        'notes': _notesController.text.trim(),
        'dueDate': _dueDateController.text.trim(),
        'immediateControlApplied':
            _immediateControlApplied,
        'permitVerified': _permitVerified,
        'riskVerified': _riskVerified,
        'ramsVerified': _ramsVerified,
        'competencyVerified':
            _competencyVerified,
        'equipmentVerified':
            _equipmentVerified,
        'ppeVerified': _ppeVerified,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.existing != null;

    return AlertDialog(
      title: Text(
        editing
            ? 'Edit Field Record'
            : 'New Field Record',
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
                  'Record title',
                  required: true,
                ),
                _dropdown(
                  'Step 32 module',
                  _module,
                  _modules,
                  (value) =>
                      setState(() => _module = value),
                ),
                _dropdown(
                  'Status',
                  _status,
                  _statuses,
                  (value) =>
                      setState(() => _status = value),
                ),
                _dropdown(
                  'Priority',
                  _priority,
                  _priorities,
                  (value) =>
                      setState(() => _priority = value),
                ),
                _textField(_projectController, 'Project'),
                _textField(_siteController, 'Site'),
                _textField(
                  _locationController,
                  'Location / Area',
                ),
                _textField(
                  _activityController,
                  'Work activity',
                ),
                _textField(
                  _observationController,
                  'Field observation',
                  maxLines: 3,
                ),
                _textField(
                  _findingController,
                  'Finding / hazard / unsafe condition',
                  maxLines: 3,
                ),
                _textField(
                  _controlController,
                  'Immediate corrective control',
                  maxLines: 3,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Immediate control applied',
                  ),
                  value: _immediateControlApplied,
                  onChanged: (value) => setState(
                    () => _immediateControlApplied =
                        value,
                  ),
                ),
                _textField(
                  _actionController,
                  'Corrective / preventive action',
                  maxLines: 3,
                ),
                _textField(
                  _ownerController,
                  'Action owner',
                ),
                _textField(
                  _workerController,
                  'Worker / person involved',
                ),
                _textField(
                  _contractorController,
                  'Contractor / company',
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Action due date',
                  ),
                  subtitle: Text(
                    _dueDateController.text.isEmpty
                        ? 'Not set'
                        : _dueDateController.text,
                  ),
                  trailing: IconButton(
                    onPressed: _pickDueDate,
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                    ),
                  ),
                ),
                const Divider(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '32H / 32I Field Verification',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('PTW verified'),
                  value: _permitVerified,
                  onChanged: (value) => setState(
                    () => _permitVerified = value,
                  ),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Risk / HIRA / JSA / JHA verified',
                  ),
                  value: _riskVerified,
                  onChanged: (value) => setState(
                    () => _riskVerified = value,
                  ),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'RAMS / Method Statement verified',
                  ),
                  value: _ramsVerified,
                  onChanged: (value) => setState(
                    () => _ramsVerified = value,
                  ),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Workforce / competency verified',
                  ),
                  value: _competencyVerified,
                  onChanged: (value) => setState(
                    () => _competencyVerified =
                        value,
                  ),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Equipment verified',
                  ),
                  value: _equipmentVerified,
                  onChanged: (value) => setState(
                    () => _equipmentVerified =
                        value,
                  ),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('PPE verified'),
                  value: _ppeVerified,
                  onChanged: (value) => setState(
                    () => _ppeVerified = value,
                  ),
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
                  _referenceTypes,
                  (value) => setState(
                    () => _referenceType = value,
                  ),
                ),
                _textField(
                  _referenceIdController,
                  'Reference ID',
                ),
                _textField(
                  _verificationController,
                  'Verification / closure evidence',
                  maxLines: 3,
                ),
                _textField(
                  _escalationController,
                  'Escalation / follow-up',
                  maxLines: 3,
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
          label: Text(
            editing ? 'Update' : 'Save',
          ),
        ),
      ],
    );
  }

  static const List<String> _statuses = [
    'Planned',
    'In Progress',
    'Action Required',
    'Verification Required',
    'Completed',
    'Closed',
    'Cancelled',
  ];

  static const List<String> _priorities = [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static const List<String> _modules = [
    '32A Field Work Master',
    '32B Daily HSE Field Plan',
    '32C Site Walk / Field Observation',
    '32D Hazard & Unsafe Condition Capture',
    '32E Immediate Corrective Action',
    '32F Worker / Contractor Engagement',
    '32G Toolbox Talk Field Record',
    '32H Permit / Risk / RAMS Field Verification',
    '32I Equipment & PPE Field Verification',
    '32J Finding Escalation & Follow-up',
    '32K Field Action Closure & Verification',
    '32L Field HSE Intelligence Dashboard',
  ];

  static const List<String> _referenceTypes = [
    'Step 9 Daily HSE',
    'Step 31 Smart Checklist',
    'Risk / HIRA / JSA / JHA',
    'RAMS',
    'PTW',
    'Workforce / Competency',
    'Equipment',
    'Incident',
    'Action Center',
  ];

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
                if (value == null ||
                    value.trim().isEmpty) {
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
    final safeValue =
        values.contains(value) ? value : values.first;

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
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ),
            )
            .toList(),
        onChanged: (selected) {
          if (selected != null) onChanged(selected);
        },
      ),
    );
  }
}
