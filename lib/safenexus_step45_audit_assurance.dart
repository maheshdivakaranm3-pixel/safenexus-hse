import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE
/// Step 45 — Audit & Assurance Management Center
///
/// Workflow:
/// Plan → Scope → Audit → Evidence → Find → Classify → Correct
/// → Verify → Approve → Close → Learn → Analyze
///
/// UAE-wide architecture. English + Malayalam UI.
/// Local persistence: SharedPreferences.

class SafeNexusStep45AuditAssurancePage extends StatefulWidget {
  const SafeNexusStep45AuditAssurancePage({super.key});

  @override
  State<SafeNexusStep45AuditAssurancePage> createState() =>
      _SafeNexusStep45AuditAssurancePageState();
}

class _SafeNexusStep45AuditAssurancePageState
    extends State<SafeNexusStep45AuditAssurancePage> {
  static const String _storageKey =
      'safenexus_hse_step45_audit_assurance';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final List<String> _auditTypes = const [
    'Internal HSE Audit',
    'External / Third-Party Audit',
    'Client Audit',
    'Regulatory / Compliance Audit',
    'Contractor Audit',
    'Site Inspection Audit',
    'Management System Audit',
    'Environmental Audit',
    'Emergency Preparedness Audit',
    'Thematic / Focus Audit',
    'Other',
  ];

  final List<String> _statuses = const [
    'Planned',
    'Scheduled',
    'In Progress',
    'Findings Pending',
    'Action Required',
    'Verification Required',
    'Under Review',
    'Closed',
    'Cancelled',
  ];

  final List<String> _findingTypes = const [
    'Major Non-Conformance',
    'Minor Non-Conformance',
    'Observation',
    'Opportunity for Improvement',
    'Positive Practice',
    'Compliance',
  ];

  final List<String> _priorities = const [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  final List<String> _actionStatuses = const [
    'Not Required',
    'Open',
    'In Progress',
    'Verification Required',
    'Closed',
  ];

  final List<String> _approvalStatuses = const [
    'Pending',
    'Reviewed',
    'Approved',
    'Rejected',
  ];

  final List<Map<String, dynamic>> _records = [];
  String _search = '';
  String _statusFilter = 'All';
  String _typeFilter = 'All';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);

    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          _records
            ..clear()
            ..addAll(
              decoded
                  .whereType<Map>()
                  .map((item) => Map<String, dynamic>.from(item)),
            );
        }
      } catch (_) {
        // Keep an empty local store if saved data is malformed.
      }
    }

    if (!mounted) return;
    setState(() {
      _loading = false;
    });
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(_records));
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _search.trim().toLowerCase();

    return _records.where((record) {
      final status = record['status']?.toString() ?? '';
      final type = record['auditType']?.toString() ?? '';

      final matchesStatus =
          _statusFilter == 'All' || status == _statusFilter;
      final matchesType = _typeFilter == 'All' || type == _typeFilter;

      if (!matchesStatus || !matchesType) return false;
      if (query.isEmpty) return true;

      final searchable = [
        record['title'],
        record['auditNo'],
        record['site'],
        record['auditor'],
        record['auditee'],
        record['scope'],
        record['findingSummary'],
      ].join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();
  }

  int _countByStatus(String status) {
    return _records.where((item) => item['status'] == status).length;
  }

  int get _openFindings {
    return _records.fold<int>(
      0,
      (sum, item) => sum + ((item['findingCount'] as num?)?.toInt() ?? 0),
    );
  }

  int get _openActions {
    return _records.fold<int>(
      0,
      (sum, item) => sum + ((item['openActions'] as num?)?.toInt() ?? 0),
    );
  }

  int get _overdue {
    final now = DateTime.now();
    return _records.where((item) {
      final value = item['targetClosure'];
      if (value == null || value.toString().isEmpty) return false;
      final date = DateTime.tryParse(value.toString());
      if (date == null) return false;
      final status = item['status']?.toString() ?? '';
      return date.isBefore(now) && status != 'Closed' && status != 'Cancelled';
    }).length;
  }

  String _formatDate(String? value) {
    if (value == null || value.isEmpty) return '-';
    final date = DateTime.tryParse(value);
    if (date == null) return value;
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _formatDateTime(String? value) {
    if (value == null || value.isEmpty) return '-';
    final date = DateTime.tryParse(value);
    if (date == null) return value;
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  void _showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Audit'),
        content: const Text(
          'Are you sure you want to delete this audit record?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() {
      _records.removeWhere(
        (item) => item['id'] == record['id'],
      );
    });
    await _saveRecords();
    _showSnack('Audit record deleted.');
  }

  Future<void> _showAuditForm({Map<String, dynamic>? existing}) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => _AuditFormDialog(
        existing: existing,
        auditTypes: _auditTypes,
        statuses: _statuses,
        findingTypes: _findingTypes,
        priorities: _priorities,
        actionStatuses: _actionStatuses,
        approvalStatuses: _approvalStatuses,
      ),
    );

    if (result == null) return;

    final now = DateTime.now().toIso8601String();
    final isEdit = existing != null;

    if (isEdit) {
      final index = _records.indexWhere(
        (item) => item['id'] == existing['id'],
      );
      if (index >= 0) {
        final history = List<Map<String, dynamic>>.from(
          (existing['history'] as List? ?? const [])
              .whereType<Map>()
              .map((item) => Map<String, dynamic>.from(item)),
        );
        history.add({
          'timestamp': now,
          'event': 'Audit record updated',
        });

        result['id'] = existing['id'];
        result['createdAt'] = existing['createdAt'] ?? now;
        result['updatedAt'] = now;
        result['history'] = history;
        _records[index] = result;
      }
    } else {
      result['id'] = 'AUD-${DateTime.now().microsecondsSinceEpoch}';
      result['createdAt'] = now;
      result['updatedAt'] = now;
      result['history'] = [
        {
          'timestamp': now,
          'event': 'Audit record created',
        },
      ];
      _records.insert(0, result);
    }

    await _saveRecords();

    if (!mounted) return;
    setState(() {});
    _showSnack(isEdit ? 'Audit record updated.' : 'Audit record added.');
  }

  Future<void> _updateStatus(Map<String, dynamic> record) async {
    final current = record['status']?.toString() ?? _statuses.first;
    final selected = await showDialog<String>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: const Text('Update Audit Status'),
        children: _statuses.map((status) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(dialogContext, status),
            child: Row(
              children: [
                Icon(
                  status == current
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  size: 20,
                  color: status == current ? primaryGreen : Colors.grey,
                ),
                const SizedBox(width: 10),
                Text(status),
              ],
            ),
          );
        }).toList(),
      ),
    );

    if (selected == null || selected == current) return;

    final history = List<Map<String, dynamic>>.from(
      (record['history'] as List? ?? const [])
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item)),
    );
    history.add({
      'timestamp': DateTime.now().toIso8601String(),
      'event': 'Status changed to $selected',
    });

    setState(() {
      record['status'] = selected;
      record['updatedAt'] = DateTime.now().toIso8601String();
      record['history'] = history;
    });

    await _saveRecords();
    _showSnack('Status updated.');
  }

  void _showDashboard() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: pageBackground,
      builder: (_) => _DashboardSheet(
        total: _records.length,
        planned: _countByStatus('Planned') + _countByStatus('Scheduled'),
        inProgress: _countByStatus('In Progress'),
        findings: _openFindings,
        actions: _openActions,
        overdue: _overdue,
        closed: _countByStatus('Closed'),
      ),
    );
  }

  void _showHistory(Map<String, dynamic> record) {
    final history = (record['history'] as List? ?? const [])
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList()
        .reversed
        .toList();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: pageBackground,
      builder: (_) => SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.72,
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  'Audit History — ${record['auditNo'] ?? '-'}',
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: darkGreen,
                  ),
                ),
              ),
              Expanded(
                child: history.isEmpty
                    ? const Center(
                        child: Text('No history available.'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: history.length,
                        itemBuilder: (_, index) {
                          final item = history[index];
                          return Card(
                            child: ListTile(
                              leading: const CircleAvatar(
                                child: Icon(Icons.history),
                              ),
                              title: Text(
                                item['event']?.toString() ?? '-',
                              ),
                              subtitle: Text(
                                _formatDateTime(
                                  item['timestamp']?.toString(),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetails(Map<String, dynamic> record) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: pageBackground,
      builder: (_) => _AuditDetailsSheet(
        record: record,
        formatDate: _formatDate,
        formatDateTime: _formatDateTime,
        onHistory: () {
          Navigator.pop(context);
          _showHistory(record);
        },
      ),
    );
  }

  void _showGuide() {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('45 — Audit & Assurance'),
        content: const SingleChildScrollView(
          child: Text(
            'Audit assurance workflow:\n\n'
            '1. Plan and schedule the audit.\n'
            '2. Define scope, criteria and responsible people.\n'
            '3. Conduct the audit and capture evidence.\n'
            '4. Record compliance, observations and non-conformances.\n'
            '5. Link findings to the Action Center.\n'
            '6. Verify corrective actions and effectiveness.\n'
            '7. Review, approve and close the audit.\n'
            '8. Capture lessons learned and assurance trends.\n\n'
            'UAE-wide design supports internal, client, contractor, '
            'regulatory and management-system assurance activities.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _resetFilters() {
    setState(() {
      _search = '';
      _statusFilter = 'All';
      _typeFilter = 'All';
    });
  }

  Future<void> _showFindingUpdate(Map<String, dynamic> record) async {
    final findingController = TextEditingController(
      text: '${record['findingCount'] ?? 0}',
    );
    final actionController = TextEditingController(
      text: '${record['openActions'] ?? 0}',
    );

    final values = await showDialog<Map<String, int>>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Update Findings & Actions'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: findingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Total findings',
                prefixIcon: Icon(Icons.find_in_page_outlined),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: actionController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Open actions',
                prefixIcon: Icon(Icons.task_alt_outlined),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context, {
                'findings':
                    int.tryParse(findingController.text.trim()) ?? 0,
                'actions':
                    int.tryParse(actionController.text.trim()) ?? 0,
              });
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    findingController.dispose();
    actionController.dispose();

    if (values == null) return;

    final history = List<Map<String, dynamic>>.from(
      (record['history'] as List? ?? const [])
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item)),
    );
    history.add({
      'timestamp': DateTime.now().toIso8601String(),
      'event': 'Findings and actions updated',
    });

    setState(() {
      record['findingCount'] = values['findings'] ?? 0;
      record['openActions'] = values['actions'] ?? 0;
      record['updatedAt'] = DateTime.now().toIso8601String();
      record['history'] = history;
    });

    await _saveRecords();
    _showSnack('Findings and actions updated.');
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'HSE Audit & Assurance',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            tooltip: 'Guide',
            onPressed: _showGuide,
            icon: const Icon(Icons.help_outline),
          ),
          IconButton(
            tooltip: 'Dashboard',
            onPressed: _showDashboard,
            icon: const Icon(Icons.dashboard_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _showAuditForm(),
        icon: const Icon(Icons.add),
        label: const Text('New Audit'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadRecords,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                children: [
                  _buildHeader(),
                  const SizedBox(height: 14),
                  _buildKpiGrid(),
                  const SizedBox(height: 16),
                  _buildFilters(),
                  const SizedBox(height: 14),
                  if (filtered.isEmpty)
                    _buildEmptyState()
                  else
                    ...filtered.map(_buildAuditCard),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [darkGreen, primaryGreen],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step 45 • Audit & Assurance',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Plan, verify, close and improve HSE assurance activities.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Plan → Audit → Find → Correct → Verify → Close → Analyze',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKpiGrid() {
    final cards = [
      _KpiData(
        'Total Audits',
        _records.length.toString(),
        Icons.fact_check_outlined,
      ),
      _KpiData(
        'Open Findings',
        _openFindings.toString(),
        Icons.find_in_page_outlined,
      ),
      _KpiData(
        'Open Actions',
        _openActions.toString(),
        Icons.task_alt_outlined,
      ),
      _KpiData(
        'Overdue',
        _overdue.toString(),
        Icons.warning_amber_outlined,
      ),
      _KpiData(
        'In Progress',
        _countByStatus('In Progress').toString(),
        Icons.play_circle_outline,
      ),
      _KpiData(
        'Closed',
        _countByStatus('Closed').toString(),
        Icons.verified_outlined,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 700 ? 3 : 2;
        final width =
            (constraints.maxWidth - ((columns - 1) * 10)) / columns;

        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: cards.map((item) {
            return SizedBox(
              width: width,
              child: _KpiCard(data: item),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildFilters() {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _search = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search audit no., site, auditor, scope...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _search.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            _search = '';
                          });
                        },
                        icon: const Icon(Icons.clear),
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _statusFilter,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: 'All',
                        child: Text('All Statuses'),
                      ),
                      ..._statuses.map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _statusFilter = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _typeFilter,
                    decoration: const InputDecoration(
                      labelText: 'Audit Type',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: 'All',
                        child: Text('All Types'),
                      ),
                      ..._auditTypes.map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _typeFilter = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'Reset filters',
                  onPressed: _resetFilters,
                  icon: const Icon(Icons.filter_alt_off_outlined),
                ),
              ],
            ),
          ],
        ),
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
              size: 56,
              color: primaryGreen,
            ),
            const SizedBox(height: 12),
            const Text(
              'No audit records found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create an audit or change the filters to view records.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => _showAuditForm(),
              icon: const Icon(Icons.add),
              label: const Text('Create Audit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuditCard(Map<String, dynamic> record) {
    final status = record['status']?.toString() ?? '-';
    final priority = record['priority']?.toString() ?? '-';
    final targetClosure = record['targetClosure']?.toString();
    final isOverdue = targetClosure != null &&
        targetClosure.isNotEmpty &&
        DateTime.tryParse(targetClosure)?.isBefore(DateTime.now()) == true &&
        status != 'Closed' &&
        status != 'Cancelled';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showDetails(record),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor:
                        primaryGreen.withValues(alpha: 0.10),
                    foregroundColor: primaryGreen,
                    child: const Icon(Icons.fact_check_outlined),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          record['title']?.toString() ?? 'Untitled Audit',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: darkGreen,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${record['auditNo'] ?? '-'} • '
                          '${record['auditType'] ?? '-'}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _StatusChip(label: status),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          _showAuditForm(existing: record);
                        case 'status':
                          _updateStatus(record);
                        case 'finding':
                          _showFindingUpdate(record);
                        case 'history':
                          _showHistory(record);
                        case 'delete':
                          _deleteRecord(record);
                      }
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit Audit'),
                      ),
                      PopupMenuItem(
                        value: 'status',
                        child: Text('Update Status'),
                      ),
                      PopupMenuItem(
                        value: 'finding',
                        child: Text('Update Findings'),
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
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _InfoPill(
                    icon: Icons.location_on_outlined,
                    text: record['site']?.toString() ?? '-',
                  ),
                  _InfoPill(
                    icon: Icons.person_outline,
                    text: record['auditor']?.toString() ?? '-',
                  ),
                  _InfoPill(
                    icon: Icons.flag_outlined,
                    text: priority,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _MiniMetric(
                      label: 'Findings',
                      value: '${record['findingCount'] ?? 0}',
                    ),
                  ),
                  Expanded(
                    child: _MiniMetric(
                      label: 'Open Actions',
                      value: '${record['openActions'] ?? 0}',
                    ),
                  ),
                  Expanded(
                    child: _MiniMetric(
                      label: 'Closure',
                      value: _formatDate(targetClosure),
                    ),
                  ),
                ],
              ),
              if (isOverdue) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red.withValues(alpha: 0.08),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 18,
                        color: Colors.red,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Target closure date is overdue.',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _AuditFormDialog extends StatefulWidget {
  const _AuditFormDialog({
    required this.existing,
    required this.auditTypes,
    required this.statuses,
    required this.findingTypes,
    required this.priorities,
    required this.actionStatuses,
    required this.approvalStatuses,
  });

  final Map<String, dynamic>? existing;
  final List<String> auditTypes;
  final List<String> statuses;
  final List<String> findingTypes;
  final List<String> priorities;
  final List<String> actionStatuses;
  final List<String> approvalStatuses;

  @override
  State<_AuditFormDialog> createState() => _AuditFormDialogState();
}

class _AuditFormDialogState extends State<_AuditFormDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _title;
  late final TextEditingController _auditNo;
  late final TextEditingController _site;
  late final TextEditingController _emirate;
  late final TextEditingController _auditor;
  late final TextEditingController _auditee;
  late final TextEditingController _department;
  late final TextEditingController _scope;
  late final TextEditingController _criteria;
  late final TextEditingController _leadAuditor;
  late final TextEditingController _team;
  late final TextEditingController _findingSummary;
  late final TextEditingController _evidence;
  late final TextEditingController _findingDetails;
  late final TextEditingController _rootCause;
  late final TextEditingController _actions;
  late final TextEditingController _lessons;
  late final TextEditingController _notes;

  String? _auditType;
  String? _status;
  String? _findingType;
  String? _priority;
  String? _actionStatus;
  String? _approvalStatus;
  DateTime? _plannedDate;
  DateTime? _targetClosure;

  @override
  void initState() {
    super.initState();
    final item = widget.existing ?? <String, dynamic>{};

    _title = TextEditingController(text: item['title']?.toString() ?? '');
    _auditNo = TextEditingController(
      text: item['auditNo']?.toString() ?? '',
    );
    _site = TextEditingController(text: item['site']?.toString() ?? '');
    _emirate = TextEditingController(
      text: item['emirate']?.toString() ?? '',
    );
    _auditor = TextEditingController(
      text: item['auditor']?.toString() ?? '',
    );
    _auditee = TextEditingController(
      text: item['auditee']?.toString() ?? '',
    );
    _department = TextEditingController(
      text: item['department']?.toString() ?? '',
    );
    _scope = TextEditingController(text: item['scope']?.toString() ?? '');
    _criteria = TextEditingController(
      text: item['criteria']?.toString() ?? '',
    );
    _leadAuditor = TextEditingController(
      text: item['leadAuditor']?.toString() ?? '',
    );
    _team = TextEditingController(text: item['team']?.toString() ?? '');
    _findingSummary = TextEditingController(
      text: item['findingSummary']?.toString() ?? '',
    );
    _evidence = TextEditingController(
      text: item['evidence']?.toString() ?? '',
    );
    _findingDetails = TextEditingController(
      text: item['findingDetails']?.toString() ?? '',
    );
    _rootCause = TextEditingController(
      text: item['rootCause']?.toString() ?? '',
    );
    _actions = TextEditingController(
      text: item['actions']?.toString() ?? '',
    );
    _lessons = TextEditingController(
      text: item['lessonsLearned']?.toString() ?? '',
    );
    _notes = TextEditingController(text: item['notes']?.toString() ?? '');

    _auditType = item['auditType']?.toString() ?? widget.auditTypes.first;
    _status = item['status']?.toString() ?? widget.statuses.first;
    _findingType =
        item['findingType']?.toString() ?? widget.findingTypes.first;
    _priority =
        item['priority']?.toString() ?? widget.priorities[1];
    _actionStatus =
        item['actionStatus']?.toString() ?? widget.actionStatuses.first;
    _approvalStatus =
        item['approvalStatus']?.toString() ?? widget.approvalStatuses.first;

    _plannedDate = DateTime.tryParse(
      item['plannedDate']?.toString() ?? '',
    );
    _targetClosure = DateTime.tryParse(
      item['targetClosure']?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _title.dispose();
    _auditNo.dispose();
    _site.dispose();
    _emirate.dispose();
    _auditor.dispose();
    _auditee.dispose();
    _department.dispose();
    _scope.dispose();
    _criteria.dispose();
    _leadAuditor.dispose();
    _team.dispose();
    _findingSummary.dispose();
    _evidence.dispose();
    _findingDetails.dispose();
    _rootCause.dispose();
    _actions.dispose();
    _lessons.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _pickDate({
    required DateTime? current,
    required void Function(DateTime value) onSelected,
  }) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: current ?? DateTime.now(),
    );
    if (picked != null) {
      onSelected(picked);
    }
  }

  String _dateText(DateTime? value) {
    if (value == null) return 'Select date';
    return '${value.day.toString().padLeft(2, '0')}/'
        '${value.month.toString().padLeft(2, '0')}/${value.year}';
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now().toIso8601String();

    final result = <String, dynamic>{
      'id': widget.existing?['id'],
      'title': _title.text.trim(),
      'auditNo': _auditNo.text.trim(),
      'auditType': _auditType,
      'status': _status,
      'site': _site.text.trim(),
      'emirate': _emirate.text.trim(),
      'auditor': _auditor.text.trim(),
      'auditee': _auditee.text.trim(),
      'department': _department.text.trim(),
      'scope': _scope.text.trim(),
      'criteria': _criteria.text.trim(),
      'leadAuditor': _leadAuditor.text.trim(),
      'team': _team.text.trim(),
      'plannedDate': _plannedDate?.toIso8601String(),
      'targetClosure': _targetClosure?.toIso8601String(),
      'findingType': _findingType,
      'priority': _priority,
      'findingSummary': _findingSummary.text.trim(),
      'findingDetails': _findingDetails.text.trim(),
      'evidence': _evidence.text.trim(),
      'rootCause': _rootCause.text.trim(),
      'actions': _actions.text.trim(),
      'actionStatus': _actionStatus,
      'openActions':
          widget.existing?['openActions'] as int? ?? 0,
      'findingCount':
          widget.existing?['findingCount'] as int? ?? 0,
      'lessonsLearned': _lessons.text.trim(),
      'approvalStatus': _approvalStatus,
      'notes': _notes.text.trim(),
      'updatedAt': now,
    };

    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;

    return AlertDialog(
      title: Text(isEdit ? 'Edit Audit' : 'New HSE Audit'),
      content: SizedBox(
        width: 620,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _sectionTitle('45A–45C • Audit Master & Scope'),
                _text(
                  _title,
                  'Audit title',
                  requiredField: true,
                ),
                _text(_auditNo, 'Audit number'),
                _dropdown(
                  label: 'Audit type',
                  value: _auditType,
                  items: widget.auditTypes,
                  onChanged: (value) {
                    setState(() {
                      _auditType = value;
                    });
                  },
                ),
                _dropdown(
                  label: 'Status',
                  value: _status,
                  items: widget.statuses,
                  onChanged: (value) {
                    setState(() {
                      _status = value;
                    });
                  },
                ),
                _text(_site, 'Site / project'),
                _text(_emirate, 'Emirate'),
                _text(_department, 'Department / function'),
                _text(_scope, 'Audit scope', maxLines: 3),
                _text(_criteria, 'Audit criteria / references', maxLines: 3),
                const SizedBox(height: 8),
                _dateButton(
                  label: 'Planned / scheduled date',
                  value: _dateText(_plannedDate),
                  onPressed: () => _pickDate(
                    current: _plannedDate,
                    onSelected: (value) {
                      setState(() {
                        _plannedDate = value;
                      });
                    },
                  ),
                ),
                _dateButton(
                  label: 'Target closure date',
                  value: _dateText(_targetClosure),
                  onPressed: () => _pickDate(
                    current: _targetClosure,
                    onSelected: (value) {
                      setState(() {
                        _targetClosure = value;
                      });
                    },
                  ),
                ),
                _sectionTitle('45H • Auditor / Auditee'),
                _text(_leadAuditor, 'Lead auditor'),
                _text(_auditor, 'Auditor / audit team'),
                _text(_team, 'Audit team / members'),
                _text(_auditee, 'Auditee / responsible manager'),
                _sectionTitle('45D–45F • Evidence & Findings'),
                _dropdown(
                  label: 'Finding type',
                  value: _findingType,
                  items: widget.findingTypes,
                  onChanged: (value) {
                    setState(() {
                      _findingType = value;
                    });
                  },
                ),
                _dropdown(
                  label: 'Priority',
                  value: _priority,
                  items: widget.priorities,
                  onChanged: (value) {
                    setState(() {
                      _priority = value;
                    });
                  },
                ),
                _text(
                  _findingSummary,
                  'Finding summary',
                  maxLines: 3,
                ),
                _text(
                  _findingDetails,
                  'Finding / observation details',
                  maxLines: 4,
                ),
                _text(
                  _evidence,
                  'Evidence / documents / references',
                  maxLines: 3,
                ),
                _sectionTitle('45G • Corrective / Preventive Action'),
                _text(
                  _rootCause,
                  'Cause / contributing factor',
                  maxLines: 3,
                ),
                _text(
                  _actions,
                  'Corrective / preventive actions',
                  maxLines: 4,
                ),
                _dropdown(
                  label: 'Action status',
                  value: _actionStatus,
                  items: widget.actionStatuses,
                  onChanged: (value) {
                    setState(() {
                      _actionStatus = value;
                    });
                  },
                ),
                _sectionTitle('45I–45J • Review & Verification'),
                _dropdown(
                  label: 'Approval / review status',
                  value: _approvalStatus,
                  items: widget.approvalStatuses,
                  onChanged: (value) {
                    setState(() {
                      _approvalStatus = value;
                    });
                  },
                ),
                _text(
                  _lessons,
                  'Lessons learned / improvement',
                  maxLines: 3,
                ),
                _text(_notes, 'Notes', maxLines: 3),
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
          label: Text(isEdit ? 'Update' : 'Save Audit'),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 14, bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF5EF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: _SafeNexusStep45AuditAssurancePageState.darkGreen,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _text(
    TextEditingController controller,
    String label, {
    bool requiredField = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: requiredField
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Required';
                }
                return null;
              }
            : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _dropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    final validValue = items.contains(value) ? value : null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        initialValue: validValue,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _dateButton({
    required String label,
    required String value,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(4),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 18),
              const SizedBox(width: 10),
              Text(value),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardSheet extends StatelessWidget {
  const _DashboardSheet({
    required this.total,
    required this.planned,
    required this.inProgress,
    required this.findings,
    required this.actions,
    required this.overdue,
    required this.closed,
  });

  final int total;
  final int planned;
  final int inProgress;
  final int findings;
  final int actions;
  final int overdue;
  final int closed;

  @override
  Widget build(BuildContext context) {
    final cards = [
      _KpiData('Total Audits', '$total', Icons.fact_check_outlined),
      _KpiData('Planned', '$planned', Icons.event_note_outlined),
      _KpiData('In Progress', '$inProgress', Icons.play_circle_outline),
      _KpiData('Findings', '$findings', Icons.find_in_page_outlined),
      _KpiData('Open Actions', '$actions', Icons.task_alt_outlined),
      _KpiData('Overdue', '$overdue', Icons.warning_amber_outlined),
      _KpiData('Closed', '$closed', Icons.verified_outlined),
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Icon(
                  Icons.analytics_outlined,
                  color: _SafeNexusStep45AuditAssurancePageState.darkGreen,
                ),
                SizedBox(width: 8),
                Text(
                  'Audit Assurance Intelligence',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: _SafeNexusStep45AuditAssurancePageState.darkGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: cards.map((item) {
                return SizedBox(
                  width: 145,
                  child: _KpiCard(data: item),
                );
              }).toList(),
            ),
            const SizedBox(height: 14),
            const Text(
              'Use these indicators for management review, assurance planning '
              'and follow-up prioritization.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _AuditDetailsSheet extends StatelessWidget {
  const _AuditDetailsSheet({
    required this.record,
    required this.formatDate,
    required this.formatDateTime,
    required this.onHistory,
  });

  final Map<String, dynamic> record;
  final String Function(String?) formatDate;
  final String Function(String?) formatDateTime;
  final VoidCallback onHistory;

  @override
  Widget build(BuildContext context) {
    final sections = <String, List<List<String>>>{
      'Audit Master': [
        ['Audit No.', '${record['auditNo'] ?? '-'}'],
        ['Type', '${record['auditType'] ?? '-'}'],
        ['Status', '${record['status'] ?? '-'}'],
        ['Title', '${record['title'] ?? '-'}'],
        ['Site', '${record['site'] ?? '-'}'],
        ['Emirate', '${record['emirate'] ?? '-'}'],
      ],
      'Scope & People': [
        ['Department', '${record['department'] ?? '-'}'],
        ['Scope', '${record['scope'] ?? '-'}'],
        ['Criteria', '${record['criteria'] ?? '-'}'],
        ['Lead Auditor', '${record['leadAuditor'] ?? '-'}'],
        ['Auditor / Team', '${record['auditor'] ?? '-'}'],
        ['Auditee', '${record['auditee'] ?? '-'}'],
      ],
      'Findings & Actions': [
        ['Finding Type', '${record['findingType'] ?? '-'}'],
        ['Priority', '${record['priority'] ?? '-'}'],
        ['Finding Count', '${record['findingCount'] ?? 0}'],
        ['Open Actions', '${record['openActions'] ?? 0}'],
        ['Action Status', '${record['actionStatus'] ?? '-'}'],
        ['Approval', '${record['approvalStatus'] ?? '-'}'],
      ],
      'Dates': [
        [
          'Planned Date',
          formatDate(record['plannedDate']?.toString()),
        ],
        [
          'Target Closure',
          formatDate(record['targetClosure']?.toString()),
        ],
        [
          'Last Updated',
          formatDateTime(record['updatedAt']?.toString()),
        ],
      ],
      'Assurance Record': [
        ['Finding Summary', '${record['findingSummary'] ?? '-'}'],
        ['Finding Details', '${record['findingDetails'] ?? '-'}'],
        ['Evidence', '${record['evidence'] ?? '-'}'],
        ['Cause', '${record['rootCause'] ?? '-'}'],
        ['Actions', '${record['actions'] ?? '-'}'],
        ['Lessons Learned', '${record['lessonsLearned'] ?? '-'}'],
        ['Notes', '${record['notes'] ?? '-'}'],
      ],
    };

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.86,
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.fact_check_outlined),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      record['title']?.toString() ?? 'Audit Details',
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: _SafeNexusStep45AuditAssurancePageState.darkGreen,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'History',
                    onPressed: onHistory,
                    icon: const Icon(Icons.history),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: sections.entries.map((entry) {
                  return _DetailsSection(
                    title: entry.key,
                    rows: entry.value,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailsSection extends StatelessWidget {
  const _DetailsSection({
    required this.title,
    required this.rows,
  });

  final String title;
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: _SafeNexusStep45AuditAssurancePageState.darkGreen,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            const Divider(),
            ...rows.map(
              (row) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 118,
                      child: Text(
                        row[0],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(row[1]),
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

class _KpiData {
  const _KpiData(this.label, this.value, this.icon);

  final String label;
  final String value;
  final IconData icon;
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({required this.data});

  final _KpiData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor:
                  _SafeNexusStep45AuditAssurancePageState.primaryGreen
                      .withValues(alpha: 0.10),
              foregroundColor:
                  _SafeNexusStep45AuditAssurancePageState.primaryGreen,
              child: Icon(data.icon, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: _SafeNexusStep45AuditAssurancePageState.darkGreen,
                    ),
                  ),
                  Text(
                    data.label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
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
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: _chipBackground(label),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: _chipForeground(label),
        ),
      ),
    );
  }

  Color _chipBackground(String value) {
    switch (value) {
      case 'Closed':
        return Colors.green.withValues(alpha: 0.12);
      case 'In Progress':
      case 'Under Review':
        return Colors.blue.withValues(alpha: 0.12);
      case 'Action Required':
      case 'Verification Required':
        return Colors.orange.withValues(alpha: 0.14);
      case 'Cancelled':
        return Colors.grey.withValues(alpha: 0.16);
      default:
        return _SafeNexusStep45AuditAssurancePageState.primaryGreen
            .withValues(alpha: 0.10);
    }
  }

  Color _chipForeground(String value) {
    switch (value) {
      case 'Closed':
        return Colors.green.shade800;
      case 'In Progress':
      case 'Under Review':
        return Colors.blue.shade800;
      case 'Action Required':
      case 'Verification Required':
        return Colors.orange.shade900;
      case 'Cancelled':
        return Colors.grey.shade800;
      default:
        return _SafeNexusStep45AuditAssurancePageState.darkGreen;
    }
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 220),
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 1),
          Icon(icon, size: 15, color: Colors.black54),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniMetric extends StatelessWidget {
  const _MiniMetric({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: _SafeNexusStep45AuditAssurancePageState.darkGreen,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
