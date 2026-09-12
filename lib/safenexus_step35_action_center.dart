import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ===============================================================
/// SafeNexus HSE
/// STEP 35 — HSE ACTION & CORRECTIVE ACTION CENTER
///
/// 35A  Action Master
/// 35B  Finding / Observation → Action
/// 35C  Corrective Action
/// 35D  Preventive Action
/// 35E  Action Assignment
/// 35F  Priority & Risk
/// 35G  Due Date & Overdue Tracking
/// 35H  Evidence / Closure Record
/// 35I  Verification & Effectiveness
/// 35J  Escalation & Follow-up
/// 35K  Action History / Audit Trail
/// 35L  Action Intelligence Dashboard
///
/// Workflow:
/// Finding → Action → Assign → Control → Evidence → Verify
/// → Effectiveness → Close → Analyze
///
/// Storage:
/// SharedPreferences
///
/// Language:
/// English + Malayalam ready
///
/// Cross-module:
/// Optional sourceOpener callback
/// ===============================================================

class SafeNexusStep35ActionCenterPage extends StatefulWidget {
  const SafeNexusStep35ActionCenterPage({
    super.key,
    this.sourceOpener,
  });

  final void Function(String referenceType, String referenceId)? sourceOpener;

  @override
  State<SafeNexusStep35ActionCenterPage> createState() =>
      _SafeNexusStep35ActionCenterPageState();
}

class _SafeNexusStep35ActionCenterPageState
    extends State<SafeNexusStep35ActionCenterPage> {
  static const String storageKey = 'safenexus_hse_step35_action_center';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const List<String> actionTypes = [
    'Corrective Action',
    'Preventive Action',
    'Immediate Action',
    'Improvement Action',
  ];

  static const List<String> sources = [
    'Step 9 Daily HSE',
    'Step 31 Smart Checklist',
    'Step 32 Field Operations',
    'Step 33 Communication',
    'Step 34 Documents & Records',
    'Risk / HIRA / JSA / JHA',
    'RAMS',
    'PTW',
    'Workforce / Competency',
    'Equipment',
    'Incident',
    'Other',
  ];

  static const List<String> priorities = [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static const List<String> risks = [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static const List<String> statuses = [
    'Open',
    'Assigned',
    'In Progress',
    'Pending Verification',
    'Closed',
    'Rejected',
  ];

  static const List<String> effectivenessValues = [
    'Not Assessed',
    'Effective',
    'Partially Effective',
    'Not Effective',
  ];

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _actions = [];
  bool _loading = true;

  String _statusFilter = 'All';
  String _priorityFilter = 'All';
  String _sourceFilter = 'All';
  String _overdueFilter = 'All';

  @override
  void initState() {
    super.initState();
    _loadActions();
    _searchController.addListener(_refresh);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refresh)
      ..dispose();
    super.dispose();
  }

  Future<void> _loadActions() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);

    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          _actions = decoded
              .whereType<Map>()
              .map((item) => Map<String, dynamic>.from(item))
              .toList();
        }
      } catch (_) {
        _actions = [];
      }
    }

    if (mounted) {
      setState(() => _loading = false);
    }
  }

  Future<void> _saveActions() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(_actions));
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  List<Map<String, dynamic>> get _filteredActions {
    final query = _searchController.text.trim().toLowerCase();

    return _actions.where((action) {
      final text = [
        action['id'],
        action['title'],
        action['description'],
        action['assignee'],
        action['location'],
        action['source'],
        action['referenceId'],
      ].map((value) => '$value').join(' ').toLowerCase();

      final matchesSearch = query.isEmpty || text.contains(query);
      final matchesStatus = _statusFilter == 'All' ||
          '${action['status']}' == _statusFilter;
      final matchesPriority = _priorityFilter == 'All' ||
          '${action['priority']}' == _priorityFilter;
      final matchesSource =
          _sourceFilter == 'All' || '${action['source']}' == _sourceFilter;

      final overdue = _isOverdue(action);
      final matchesOverdue = _overdueFilter == 'All' ||
          (_overdueFilter == 'Overdue' && overdue) ||
          (_overdueFilter == 'Not Overdue' && !overdue);

      return matchesSearch &&
          matchesStatus &&
          matchesPriority &&
          matchesSource &&
          matchesOverdue;
    }).toList();
  }

  bool _isOverdue(Map<String, dynamic> action) {
    final status = '${action['status']}';
    if (status == 'Closed' || status == 'Rejected') return false;

    final dueDate = DateTime.tryParse('${action['dueDate']}');
    if (dueDate == null) return false;

    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);
    final dueOnly = DateTime(dueDate.year, dueDate.month, dueDate.day);

    return dueOnly.isBefore(todayOnly);
  }

  int _countWhere(bool Function(Map<String, dynamic>) test) {
    return _actions.where(test).length;
  }

  int get _openCount => _countWhere(
        (a) => '${a['status']}' != 'Closed' && '${a['status']}' != 'Rejected',
      );

  int get _inProgressCount =>
      _countWhere((a) => '${a['status']}' == 'In Progress');

  int get _overdueCount => _countWhere(_isOverdue);

  int get _highCount => _countWhere(
        (a) => '${a['priority']}' == 'High' || '${a['priority']}' == 'Critical',
      );

  int get _criticalCount =>
      _countWhere((a) => '${a['priority']}' == 'Critical');

  int get _pendingVerificationCount =>
      _countWhere((a) => '${a['status']}' == 'Pending Verification');

  int get _closedCount => _countWhere((a) => '${a['status']}' == 'Closed');

  Future<void> _openForm({Map<String, dynamic>? existing}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ActionFormSheet(
        existing: existing,
        actionTypes: actionTypes,
        sources: sources,
        priorities: priorities,
        risks: risks,
        statuses: statuses,
        effectivenessValues: effectivenessValues,
      ),
    );

    if (result == null) return;

    final now = DateTime.now().toIso8601String();

    if (existing == null) {
      result['id'] = 'ACT-${DateTime.now().millisecondsSinceEpoch}';
      result['createdAt'] = now;
      result['updatedAt'] = now;
      result['history'] = [
        {
          'at': now,
          'event': 'Action created',
          'note': 'New action registered in Action Center.',
        },
      ];
      _actions.insert(0, result);
    } else {
      final index = _actions.indexWhere((a) => a['id'] == existing['id']);
      if (index >= 0) {
        final history =
            List<Map<String, dynamic>>.from(existing['history'] ?? const []);
        history.add({
          'at': now,
          'event': 'Action updated',
          'note': 'Action record updated.',
        });
        result['id'] = existing['id'];
        result['createdAt'] = existing['createdAt'] ?? now;
        result['updatedAt'] = now;
        result['history'] = history;
        _actions[index] = result;
      }
    }

    await _saveActions();
    if (mounted) setState(() {});
  }

  Future<void> _deleteAction(Map<String, dynamic> action) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Action?'),
        content: Text(
          'This will permanently remove ${action['id'] ?? 'this action'} '
          'from local Action Center storage.',
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

    _actions.removeWhere((a) => a['id'] == action['id']);
    await _saveActions();
    if (mounted) setState(() {});
  }

  Future<void> _quickStatusUpdate(
    Map<String, dynamic> action,
    String status,
  ) async {
    final index = _actions.indexWhere((a) => a['id'] == action['id']);
    if (index < 0) return;

    final now = DateTime.now().toIso8601String();
    final updated = Map<String, dynamic>.from(_actions[index]);
    updated['status'] = status;
    updated['updatedAt'] = now;

    final history =
        List<Map<String, dynamic>>.from(updated['history'] ?? const []);
    history.add({
      'at': now,
      'event': 'Status changed',
      'note': 'Status changed to $status.',
    });
    updated['history'] = history;

    if (status == 'Closed' && '${updated['effectiveness']}' == 'Not Assessed') {
      updated['effectiveness'] = 'Effective';
      updated['verificationDate'] = DateTime.now().toIso8601String();
    }

    _actions[index] = updated;
    await _saveActions();
    if (mounted) setState(() {});
  }

  void _showHistory(Map<String, dynamic> action) {
    final history = List<Map<String, dynamic>>.from(action['history'] ?? const []);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Action History — ${action['id']}',
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: history.isEmpty
                      ? const Center(child: Text('No history available.'))
                      : ListView.separated(
                          itemCount: history.length,
                          separatorBuilder: (_, __) =>
                              const Divider(height: 1),
                          itemBuilder: (_, index) {
                            final item = history[index];
                            return ListTile(
                              leading: const Icon(
                                Icons.history,
                                color: primaryGreen,
                              ),
                              title: Text('${item['event'] ?? 'Update'}'),
                              subtitle: Text(
                                '${item['note'] ?? ''}\n'
                                '${_formatDateTime(item['at'])}',
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showActionDetails(Map<String, dynamic> action) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _ActionDetailsSheet(
        action: action,
        onEdit: () {
          Navigator.pop(context);
          _openForm(existing: action);
        },
        onDelete: () {
          Navigator.pop(context);
          _deleteAction(action);
        },
        onHistory: () {
          Navigator.pop(context);
          _showHistory(action);
        },
        onStatusChange: (status) {
          Navigator.pop(context);
          _quickStatusUpdate(action, status);
        },
        onSourceOpen: widget.sourceOpener == null
            ? null
            : () {
                Navigator.pop(context);
                widget.sourceOpener!(
                  '${action['source'] ?? ''}',
                  '${action['referenceId'] ?? ''}',
                );
              },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredActions;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text(
          'HSE Action Center',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Reset filters',
            onPressed: () {
              setState(() {
                _statusFilter = 'All';
                _priorityFilter = 'All';
                _sourceFilter = 'All';
                _overdueFilter = 'All';
                _searchController.clear();
              });
            },
            icon: const Icon(Icons.filter_alt_off),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add_task),
        label: const Text('New Action'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadActions,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
                children: [
                  _buildHeaderCard(),
                  const SizedBox(height: 12),
                  _buildDashboard(),
                  const SizedBox(height: 12),
                  _buildSearchAndFilters(),
                  const SizedBox(height: 12),
                  if (filtered.isEmpty)
                    _buildEmptyState()
                  else
                    ...filtered.map(_buildActionCard),
                ],
              ),
            ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [darkGreen, primaryGreen],
          ),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.assignment_turned_in, color: Colors.white, size: 34),
            SizedBox(height: 10),
            Text(
              '35 — HSE Action & Corrective Action Center',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Finding → Action → Assign → Control → Evidence → Verify → Close',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboard() {
    final cards = [
      ('Total', _actions.length, Icons.list_alt),
      ('Open', _openCount, Icons.folder_open),
      ('In Progress', _inProgressCount, Icons.autorenew),
      ('Overdue', _overdueCount, Icons.warning_amber_rounded),
      ('High+', _highCount, Icons.priority_high),
      ('Critical', _criticalCount, Icons.error_outline),
      ('Verification', _pendingVerificationCount, Icons.fact_check),
      ('Closed', _closedCount, Icons.task_alt),
    ];

    return GridView.builder(
      itemCount: cards.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2.05,
      ),
      itemBuilder: (_, index) {
        final item = cards[index];
        return _MetricCard(
          label: item.$1,
          value: item.$2,
          icon: item.$3,
        );
      },
    );
  }

  Widget _buildSearchAndFilters() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search actions',
                hintText: 'ID, title, assignee, location, reference...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: _searchController.clear,
                        icon: const Icon(Icons.clear),
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _filterDropdown(
                  label: 'Status',
                  value: _statusFilter,
                  values: ['All', ...statuses],
                  onChanged: (value) =>
                      setState(() => _statusFilter = value ?? 'All'),
                ),
                _filterDropdown(
                  label: 'Priority',
                  value: _priorityFilter,
                  values: ['All', ...priorities],
                  onChanged: (value) =>
                      setState(() => _priorityFilter = value ?? 'All'),
                ),
                _filterDropdown(
                  label: 'Source',
                  value: _sourceFilter,
                  values: ['All', ...sources],
                  onChanged: (value) =>
                      setState(() => _sourceFilter = value ?? 'All'),
                ),
                _filterDropdown(
                  label: 'Due',
                  value: _overdueFilter,
                  values: const ['All', 'Overdue', 'Not Overdue'],
                  onChanged: (value) =>
                      setState(() => _overdueFilter = value ?? 'All'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterDropdown({
    required String label,
    required String value,
    required List<String> values,
    required ValueChanged<String?> onChanged,
  }) {
    return SizedBox(
      width: 175,
      child: DropdownButtonFormField<String>(
        initialValue: values.contains(value) ? value : 'All',
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        items: values
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

  Widget _buildEmptyState() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Icon(
              Icons.assignment_late_outlined,
              size: 58,
              color: Colors.grey.shade500,
            ),
            const SizedBox(height: 12),
            const Text(
              'No actions found',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create a new action or change the filters.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            FilledButton.icon(
              onPressed: () => _openForm(),
              icon: const Icon(Icons.add),
              label: const Text('Create Action'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(Map<String, dynamic> action) {
    final overdue = _isOverdue(action);
    final priority = '${action['priority'] ?? 'Medium'}';
    final status = '${action['status'] ?? 'Open'}';

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => _showActionDetails(action),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${action['title'] ?? 'Untitled Action'}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: darkGreen,
                      ),
                    ),
                  ),
                  _PriorityChip(priority: priority),
                ],
              ),
              const SizedBox(height: 7),
              Text(
                '${action['id'] ?? ''} • ${action['actionType'] ?? ''}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${action['description'] ?? ''}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _InfoChip(icon: Icons.flag, text: status),
                  _InfoChip(
                    icon: Icons.person_outline,
                    text: '${action['assignee'] ?? 'Unassigned'}',
                  ),
                  _InfoChip(
                    icon: Icons.calendar_today,
                    text: _formatDate(action['dueDate']),
                  ),
                  if (overdue)
                    const _InfoChip(
                      icon: Icons.warning_amber,
                      text: 'OVERDUE',
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Source: ${action['source'] ?? 'Other'}'
                      '${action['referenceId'].toString().isEmpty ? '' : ' • ${action['referenceId']}'}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') _openForm(existing: action);
                      if (value == 'history') _showHistory(action);
                      if (value == 'delete') _deleteAction(action);
                      if (value == 'verify') {
                        _quickStatusUpdate(action, 'Pending Verification');
                      }
                      if (value == 'close') {
                        _quickStatusUpdate(action, 'Closed');
                      }
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      PopupMenuItem(
                        value: 'verify',
                        child: Text('Send for Verification'),
                      ),
                      PopupMenuItem(
                        value: 'close',
                        child: Text('Close Action'),
                      ),
                      PopupMenuItem(
                        value: 'history',
                        child: Text('View History'),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
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

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final int value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 19,
              child: Icon(icon, size: 19),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$value',
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    label,
                    style: const TextStyle(fontSize: 11),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriorityChip extends StatelessWidget {
  const _PriorityChip({required this.priority});

  final String priority;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    if (priority == 'Critical') {
      icon = Icons.error;
    } else if (priority == 'High') {
      icon = Icons.priority_high;
    } else if (priority == 'Medium') {
      icon = Icons.remove_circle_outline;
    } else {
      icon = Icons.arrow_downward;
    }

    return Chip(
      avatar: Icon(icon, size: 15),
      label: Text(priority),
      visualDensity: VisualDensity.compact,
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 14),
      label: Text(
        text,
        overflow: TextOverflow.ellipsis,
      ),
      visualDensity: VisualDensity.compact,
    );
  }
}

class _ActionFormSheet extends StatefulWidget {
  const _ActionFormSheet({
    required this.existing,
    required this.actionTypes,
    required this.sources,
    required this.priorities,
    required this.risks,
    required this.statuses,
    required this.effectivenessValues,
  });

  final Map<String, dynamic>? existing;
  final List<String> actionTypes;
  final List<String> sources;
  final List<String> priorities;
  final List<String> risks;
  final List<String> statuses;
  final List<String> effectivenessValues;

  @override
  State<_ActionFormSheet> createState() => _ActionFormSheetState();
}

class _ActionFormSheetState extends State<_ActionFormSheet> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _locationController;
  late final TextEditingController _assigneeController;
  late final TextEditingController _departmentController;
  late final TextEditingController _referenceIdController;
  late final TextEditingController _rootCauseController;
  late final TextEditingController _controlController;
  late final TextEditingController _evidenceController;
  late final TextEditingController _verificationNoteController;
  late final TextEditingController _escalationController;

  String _actionType = 'Corrective Action';
  String _source = 'Step 32 Field Operations';
  String _priority = 'Medium';
  String _risk = 'Medium';
  String _status = 'Open';
  String _effectiveness = 'Not Assessed';

  DateTime _dueDate = DateTime.now().add(const Duration(days: 7));
  DateTime? _verificationDate;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;

    _titleController =
        TextEditingController(text: '${e?['title'] ?? ''}');
    _descriptionController =
        TextEditingController(text: '${e?['description'] ?? ''}');
    _locationController =
        TextEditingController(text: '${e?['location'] ?? ''}');
    _assigneeController =
        TextEditingController(text: '${e?['assignee'] ?? ''}');
    _departmentController =
        TextEditingController(text: '${e?['department'] ?? ''}');
    _referenceIdController =
        TextEditingController(text: '${e?['referenceId'] ?? ''}');
    _rootCauseController =
        TextEditingController(text: '${e?['rootCause'] ?? ''}');
    _controlController =
        TextEditingController(text: '${e?['controlMeasure'] ?? ''}');
    _evidenceController =
        TextEditingController(text: '${e?['evidence'] ?? ''}');
    _verificationNoteController =
        TextEditingController(text: '${e?['verificationNote'] ?? ''}');
    _escalationController =
        TextEditingController(text: '${e?['escalationNote'] ?? ''}');

    _actionType = _safeValue(
      '${e?['actionType'] ?? _actionType}',
      widget.actionTypes,
      _actionType,
    );
    _source = _safeValue(
      '${e?['source'] ?? _source}',
      widget.sources,
      _source,
    );
    _priority = _safeValue(
      '${e?['priority'] ?? _priority}',
      widget.priorities,
      _priority,
    );
    _risk = _safeValue(
      '${e?['risk'] ?? _risk}',
      widget.risks,
      _risk,
    );
    _status = _safeValue(
      '${e?['status'] ?? _status}',
      widget.statuses,
      _status,
    );
    _effectiveness = _safeValue(
      '${e?['effectiveness'] ?? _effectiveness}',
      widget.effectivenessValues,
      _effectiveness,
    );

    final parsedDue = DateTime.tryParse('${e?['dueDate']}');
    if (parsedDue != null) _dueDate = parsedDue;

    final parsedVerification = DateTime.tryParse('${e?['verificationDate']}');
    if (parsedVerification != null) _verificationDate = parsedVerification;
  }

  String _safeValue(String value, List<String> values, String fallback) {
    return values.contains(value) ? value : fallback;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _assigneeController.dispose();
    _departmentController.dispose();
    _referenceIdController.dispose();
    _rootCauseController.dispose();
    _controlController.dispose();
    _evidenceController.dispose();
    _verificationNoteController.dispose();
    _escalationController.dispose();
    super.dispose();
  }

  Future<void> _pickDueDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _dueDate.isBefore(DateTime.now())
          ? DateTime.now()
          : _dueDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (selected != null) {
      setState(() => _dueDate = selected);
    }
  }

  Future<void> _pickVerificationDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _verificationDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (selected != null) {
      setState(() => _verificationDate = selected);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now().toIso8601String();

    Navigator.pop(context, {
      'title': _titleController.text.trim(),
      'description': _descriptionController.text.trim(),
      'location': _locationController.text.trim(),
      'assignee': _assigneeController.text.trim(),
      'department': _departmentController.text.trim(),
      'referenceId': _referenceIdController.text.trim(),
      'rootCause': _rootCauseController.text.trim(),
      'controlMeasure': _controlController.text.trim(),
      'evidence': _evidenceController.text.trim(),
      'verificationNote': _verificationNoteController.text.trim(),
      'escalationNote': _escalationController.text.trim(),
      'actionType': _actionType,
      'source': _source,
      'priority': _priority,
      'risk': _risk,
      'status': _status,
      'effectiveness': _effectiveness,
      'dueDate': _dueDate.toIso8601String(),
      'verificationDate': _verificationDate?.toIso8601String(),
      'updatedAt': now,
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: Material(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.92,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 12, 8, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.existing == null
                              ? 'Create HSE Action'
                              : 'Edit HSE Action',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: _SafeNexusStep35ActionCenterPageState.darkGreen,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                      children: [
                        _sectionTitle('35A–35B  Action Master & Finding'),
                        _textField(
                          controller: _titleController,
                          label: 'Action Title',
                          icon: Icons.title,
                          requiredField: true,
                        ),
                        _textField(
                          controller: _descriptionController,
                          label: 'Finding / Observation / Description',
                          icon: Icons.description_outlined,
                          requiredField: true,
                          maxLines: 4,
                        ),
                        _textField(
                          controller: _locationController,
                          label: 'Location / Work Area',
                          icon: Icons.location_on_outlined,
                        ),
                        _dropdown(
                          label: 'Action Type',
                          value: _actionType,
                          values: widget.actionTypes,
                          onChanged: (v) =>
                              setState(() => _actionType = v ?? _actionType),
                        ),
                        _dropdown(
                          label: 'Source Module',
                          value: _source,
                          values: widget.sources,
                          onChanged: (v) =>
                              setState(() => _source = v ?? _source),
                        ),
                        _textField(
                          controller: _referenceIdController,
                          label: 'Source Reference ID',
                          icon: Icons.link,
                        ),
                        const SizedBox(height: 4),
                        _sectionTitle('35C–35G  Control, Assignment & Risk'),
                        _textField(
                          controller: _rootCauseController,
                          label: 'Root Cause',
                          icon: Icons.account_tree_outlined,
                          maxLines: 3,
                        ),
                        _textField(
                          controller: _controlController,
                          label: 'Corrective / Preventive Control Measure',
                          icon: Icons.shield_outlined,
                          requiredField: true,
                          maxLines: 4,
                        ),
                        _textField(
                          controller: _assigneeController,
                          label: 'Responsible Person / Assignee',
                          icon: Icons.person_outline,
                          requiredField: true,
                        ),
                        _textField(
                          controller: _departmentController,
                          label: 'Department / Contractor',
                          icon: Icons.groups_outlined,
                        ),
                        _dropdown(
                          label: 'Priority',
                          value: _priority,
                          values: widget.priorities,
                          onChanged: (v) =>
                              setState(() => _priority = v ?? _priority),
                        ),
                        _dropdown(
                          label: 'Risk',
                          value: _risk,
                          values: widget.risks,
                          onChanged: (v) =>
                              setState(() => _risk = v ?? _risk),
                        ),
                        _dropdown(
                          label: 'Status',
                          value: _status,
                          values: widget.statuses,
                          onChanged: (v) =>
                              setState(() => _status = v ?? _status),
                        ),
                        _dateTile(
                          label: 'Due Date',
                          value: _dueDate,
                          onTap: _pickDueDate,
                        ),
                        const SizedBox(height: 4),
                        _sectionTitle('35H–35I  Evidence & Verification'),
                        _textField(
                          controller: _evidenceController,
                          label: 'Evidence / Closure Record',
                          icon: Icons.photo_library_outlined,
                          hint:
                              'Enter evidence reference, file name, photo ID, record ID, etc.',
                          maxLines: 3,
                        ),
                        _dropdown(
                          label: 'Effectiveness',
                          value: _effectiveness,
                          values: widget.effectivenessValues,
                          onChanged: (v) => setState(
                            () => _effectiveness = v ?? _effectiveness,
                          ),
                        ),
                        _dateTile(
                          label: 'Verification Date',
                          value: _verificationDate,
                          onTap: _pickVerificationDate,
                          allowEmpty: true,
                        ),
                        _textField(
                          controller: _verificationNoteController,
                          label: 'Verification / Effectiveness Note',
                          icon: Icons.fact_check_outlined,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 4),
                        _sectionTitle('35J–35K  Escalation & Audit Trail'),
                        _textField(
                          controller: _escalationController,
                          label: 'Escalation / Follow-up Note',
                          icon: Icons.escalator_warning_outlined,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 12),
                        FilledButton.icon(
                          onPressed: _submit,
                          icon: const Icon(Icons.save),
                          label: Text(
                            widget.existing == null
                                ? 'Save Action'
                                : 'Save Changes',
                          ),
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 12, 2, 9),
      child: Text(
        title,
        style: const TextStyle(
          color: _SafeNexusStep35ActionCenterPageState.darkGreen,
          fontWeight: FontWeight.w800,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    bool requiredField = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: requiredField
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Required field';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _dropdown({
    required String label,
    required String value,
    required List<String> values,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        initialValue: values.contains(value) ? value : values.first,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        items: values
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

  Widget _dateTile({
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
    bool allowEmpty = false,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Icon(Icons.event, color: _SafeNexusStep35ActionCenterPageState.primaryGreen),
        title: Text(label),
        subtitle: Text(
          value == null
              ? (allowEmpty ? 'Not set' : 'Select date')
              : _formatDate(value.toIso8601String()),
        ),
        trailing: const Icon(Icons.edit_calendar),
        onTap: onTap,
      ),
    );
  }
}

class _ActionDetailsSheet extends StatelessWidget {
  const _ActionDetailsSheet({
    required this.action,
    required this.onEdit,
    required this.onDelete,
    required this.onHistory,
    required this.onStatusChange,
    required this.onSourceOpen,
  });

  final Map<String, dynamic> action;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onHistory;
  final ValueChanged<String> onStatusChange;
  final VoidCallback? onSourceOpen;

  @override
  Widget build(BuildContext context) {
    final status = '${action['status'] ?? 'Open'}';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 22),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Action Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: _SafeNexusStep35ActionCenterPageState.darkGreen,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Text(
                '${action['id'] ?? ''}',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                '${action['title'] ?? ''}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),
              _detail('Action Type', action['actionType']),
              _detail('Status', status),
              _detail('Priority', action['priority']),
              _detail('Risk', action['risk']),
              _detail('Assignee', action['assignee']),
              _detail('Department', action['department']),
              _detail('Location', action['location']),
              _detail('Source', action['source']),
              _detail('Reference ID', action['referenceId']),
              _detail('Due Date', _formatDate(action['dueDate'])),
              _detail('Root Cause', action['rootCause']),
              _detail('Control Measure', action['controlMeasure']),
              _detail('Evidence', action['evidence']),
              _detail('Effectiveness', action['effectiveness']),
              _detail(
                'Verification Date',
                _formatDate(action['verificationDate']),
              ),
              _detail('Verification Note', action['verificationNote']),
              _detail('Escalation Note', action['escalationNote']),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onHistory,
                    icon: const Icon(Icons.history),
                    label: const Text('History'),
                  ),
                  if (onSourceOpen != null)
                    OutlinedButton.icon(
                      onPressed: onSourceOpen,
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('Open Source'),
                    ),
                  if (status != 'In Progress')
                    FilledButton.icon(
                      onPressed: () => onStatusChange('In Progress'),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Start'),
                    ),
                  FilledButton.icon(
                    onPressed: () => onStatusChange('Pending Verification'),
                    icon: const Icon(Icons.fact_check),
                    label: const Text('Verify'),
                  ),
                  FilledButton.icon(
                    onPressed: () => onStatusChange('Closed'),
                    icon: const Icon(Icons.task_alt),
                    label: const Text('Close'),
                  ),
                  TextButton.icon(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detail(String label, dynamic value) {
    final text = value == null ? '' : '$value';
    if (text.trim().isEmpty || text == 'null') return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87, height: 1.3),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            TextSpan(text: text),
          ],
        ),
      ),
    );
  }
}

String _formatDate(dynamic value) {
  if (value == null) return 'Not set';
  final parsed = DateTime.tryParse('$value');
  if (parsed == null) return '$value';
  return '${parsed.day.toString().padLeft(2, '0')}/'
      '${parsed.month.toString().padLeft(2, '0')}/'
      '${parsed.year}';
}

String _formatDateTime(dynamic value) {
  if (value == null) return '';
  final parsed = DateTime.tryParse('$value');
  if (parsed == null) return '$value';

  final hour = parsed.hour.toString().padLeft(2, '0');
  final minute = parsed.minute.toString().padLeft(2, '0');

  return '${parsed.day.toString().padLeft(2, '0')}/'
      '${parsed.month.toString().padLeft(2, '0')}/'
      '${parsed.year} $hour:$minute';
}
