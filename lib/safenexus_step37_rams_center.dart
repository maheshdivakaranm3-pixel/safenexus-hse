import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ===============================================================
/// SafeNexus HSE
/// STEP 37 — RAMS (RISK ASSESSMENT & METHOD STATEMENT) CENTER
///
/// 37A  RAMS Master
/// 37B  Work Activity & Scope
/// 37C  Hazard / Risk Link
/// 37D  Method Statement
/// 37E  Control Measures
/// 37F  PPE / Equipment / Competency
/// 37G  Roles & Responsibilities
/// 37H  Review & Approval
/// 37I  Field Verification
/// 37J  Revision & Change Control
/// 37K  RAMS History / Audit Trail
/// 37L  RAMS Intelligence Dashboard
///
/// Workflow:
/// Draft → Risk Review → Controls → Review → Approval
/// → Field Verify → Revise → Close → Analyze
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

class SafeNexusStep37RamsCenterPage extends StatefulWidget {
  const SafeNexusStep37RamsCenterPage({
    super.key,
    this.sourceOpener,
  });

  final void Function(String referenceType, String referenceId)? sourceOpener;

  @override
  State<SafeNexusStep37RamsCenterPage> createState() =>
      _SafeNexusStep37RamsCenterPageState();
}

class _SafeNexusStep37RamsCenterPageState
    extends State<SafeNexusStep37RamsCenterPage> {
  static const String storageKey = 'safenexus_hse_step37_rams_center';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const List<String> documentTypes = [
    'RAMS',
    'Method Statement',
    'Risk Assessment',
    'Task Risk Assessment',
    'Safe Work Method Statement',
  ];

  static const List<String> workTypes = [
    'General Construction',
    'Work at Height',
    'Confined Space',
    'Lifting Operations',
    'Excavation',
    'Electrical Work',
    'Hot Work',
    'Scaffolding',
    'Mechanical Work',
    'Chemical Handling',
    'Traffic / Vehicle',
    'Marine / Port Work',
    'Maintenance',
    'Other',
  ];

  static const List<String> sources = [
    'Step 9 Daily HSE',
    'Step 31 Smart Checklist',
    'Step 32 Field Operations',
    'Step 34 Documents & Records',
    'Step 35 Action Center',
    'Step 36 Risk & Control Center',
    'PTW',
    'Incident',
    'Other',
  ];

  static const List<String> statuses = [
    'Draft',
    'Under Risk Review',
    'Under HSE Review',
    'Pending Approval',
    'Approved',
    'Rejected',
    'Field Verification',
    'Revision Required',
    'Closed',
  ];

  static const List<String> priorities = [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static const List<String> approvalStatuses = [
    'Not Submitted',
    'Submitted',
    'Approved',
    'Rejected',
  ];

  static const List<String> verificationStatuses = [
    'Not Verified',
    'Verified',
    'Partially Verified',
    'Failed',
  ];

  static const List<String> riskLevels = [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _rams = [];
  bool _loading = true;

  String _statusFilter = 'All';
  String _priorityFilter = 'All';
  String _riskFilter = 'All';
  String _verificationFilter = 'All';

  @override
  void initState() {
    super.initState();
    _loadRams();
    _searchController.addListener(_refresh);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refresh)
      ..dispose();
    super.dispose();
  }

  Future<void> _loadRams() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);

    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          _rams = decoded
              .whereType<Map>()
              .map((item) => Map<String, dynamic>.from(item))
              .toList();
        }
      } catch (_) {
        _rams = [];
      }
    }

    if (mounted) {
      setState(() => _loading = false);
    }
  }

  Future<void> _saveRams() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(_rams));
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  bool _isOverdue(Map<String, dynamic> rams) {
    final status = '${rams['status']}';
    if (status == 'Closed') return false;

    final date = DateTime.tryParse('${rams['reviewDate']}');
    if (date == null) return false;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final review = DateTime(date.year, date.month, date.day);
    return review.isBefore(today);
  }

  List<Map<String, dynamic>> get _filteredRams {
    final query = _searchController.text.trim().toLowerCase();

    return _rams.where((rams) {
      final searchable = [
        rams['id'],
        rams['title'],
        rams['project'],
        rams['location'],
        rams['workType'],
        rams['activity'],
        rams['contractor'],
        rams['preparedBy'],
        rams['source'],
        rams['referenceId'],
        rams['riskLevel'],
        rams['status'],
      ].map((v) => '$v').join(' ').toLowerCase();

      final searchOk = query.isEmpty || searchable.contains(query);
      final statusOk =
          _statusFilter == 'All' || '${rams['status']}' == _statusFilter;
      final priorityOk = _priorityFilter == 'All' ||
          '${rams['priority']}' == _priorityFilter;
      final riskOk =
          _riskFilter == 'All' || '${rams['riskLevel']}' == _riskFilter;
      final verificationOk = _verificationFilter == 'All' ||
          '${rams['verificationStatus']}' == _verificationFilter;

      return searchOk &&
          statusOk &&
          priorityOk &&
          riskOk &&
          verificationOk;
    }).toList();
  }

  int _count(bool Function(Map<String, dynamic>) test) =>
      _rams.where(test).length;

  int get _activeCount =>
      _count((r) => '${r['status']}' != 'Closed');

  int get _draftCount =>
      _count((r) => '${r['status']}' == 'Draft');

  int get _approvalCount => _count(
        (r) =>
            '${r['status']}' == 'Pending Approval' ||
            '${r['approvalStatus']}' == 'Submitted',
      );

  int get _approvedCount =>
      _count((r) => '${r['status']}' == 'Approved');

  int get _highRiskCount => _count(
        (r) =>
            '${r['riskLevel']}' == 'High' ||
            '${r['riskLevel']}' == 'Critical',
      );

  int get _overdueCount => _count(_isOverdue);

  int get _unverifiedCount =>
      _count((r) => '${r['verificationStatus']}' != 'Verified');

  int get _revisionCount =>
      _count((r) => '${r['status']}' == 'Revision Required');

  Future<void> _openForm({Map<String, dynamic>? existing}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _RamsFormSheet(
        existing: existing,
        documentTypes: documentTypes,
        workTypes: workTypes,
        sources: sources,
        statuses: statuses,
        priorities: priorities,
        approvalStatuses: approvalStatuses,
        verificationStatuses: verificationStatuses,
        riskLevels: riskLevels,
      ),
    );

    if (result == null) return;

    final now = DateTime.now().toIso8601String();

    if (existing == null) {
      result['id'] = 'RAMS-${DateTime.now().millisecondsSinceEpoch}';
      result['revision'] = 'Rev 0';
      result['createdAt'] = now;
      result['updatedAt'] = now;
      result['history'] = [
        {
          'at': now,
          'event': 'RAMS created',
          'note': 'New RAMS record created.',
        },
      ];
      _rams.insert(0, result);
    } else {
      final index = _rams.indexWhere((r) => r['id'] == existing['id']);
      if (index >= 0) {
        final history = _historyFrom(existing['history']);
        history.add({
          'at': now,
          'event': 'RAMS updated',
          'note': 'RAMS record updated.',
        });

        result['id'] = existing['id'];
        result['revision'] = _nextRevision('${existing['revision'] ?? 'Rev 0'}');
        result['createdAt'] = existing['createdAt'] ?? now;
        result['updatedAt'] = now;
        result['history'] = history;
        _rams[index] = result;
      }
    }

    await _saveRams();
    if (mounted) setState(() {});
  }

  List<Map<String, dynamic>> _historyFrom(dynamic value) {
    final output = <Map<String, dynamic>>[];
    if (value is List) {
      for (final item in value) {
        if (item is Map) {
          output.add(Map<String, dynamic>.from(item));
        }
      }
    }
    return output;
  }

  String _nextRevision(String value) {
    final match = RegExp(r'(\d+)$').firstMatch(value);
    final number = int.tryParse(match?.group(1) ?? '0') ?? 0;
    return 'Rev ${number + 1}';
  }

  Future<void> _deleteRams(Map<String, dynamic> rams) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete RAMS?'),
        content: Text(
          'Permanently remove ${rams['id'] ?? 'this RAMS'} from local storage?',
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

    _rams.removeWhere((r) => r['id'] == rams['id']);
    await _saveRams();
    if (mounted) setState(() {});
  }

  Future<void> _quickStatus(
    Map<String, dynamic> rams,
    String status,
  ) async {
    final index = _rams.indexWhere((r) => r['id'] == rams['id']);
    if (index < 0) return;

    final updated = Map<String, dynamic>.from(_rams[index]);
    final now = DateTime.now().toIso8601String();

    updated['status'] = status;
    updated['updatedAt'] = now;

    if (status == 'Approved') {
      updated['approvalStatus'] = 'Approved';
    } else if (status == 'Pending Approval') {
      updated['approvalStatus'] = 'Submitted';
    } else if (status == 'Rejected') {
      updated['approvalStatus'] = 'Rejected';
    }

    final history = _historyFrom(updated['history']);
    history.add({
      'at': now,
      'event': 'Status changed',
      'note': 'RAMS status changed to $status.',
    });
    updated['history'] = history;

    _rams[index] = updated;
    await _saveRams();
    if (mounted) setState(() {});
  }

  Future<void> _quickVerification(
    Map<String, dynamic> rams,
    String status,
  ) async {
    final index = _rams.indexWhere((r) => r['id'] == rams['id']);
    if (index < 0) return;

    final updated = Map<String, dynamic>.from(_rams[index]);
    final now = DateTime.now().toIso8601String();

    updated['verificationStatus'] = status;
    updated['updatedAt'] = now;

    if (status == 'Failed' || status == 'Partially Verified') {
      updated['status'] = 'Revision Required';
    }

    final history = _historyFrom(updated['history']);
    history.add({
      'at': now,
      'event': 'Field verification',
      'note': 'Verification status changed to $status.',
    });
    updated['history'] = history;

    _rams[index] = updated;
    await _saveRams();
    if (mounted) setState(() {});
  }

  void _showHistory(Map<String, dynamic> rams) {
    final history = _historyFrom(rams['history']);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .70,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RAMS History — ${rams['id']}',
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
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

  void _showDetails(Map<String, dynamic> rams) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _RamsDetailsSheet(
        rams: rams,
        onEdit: () {
          Navigator.pop(context);
          _openForm(existing: rams);
        },
        onDelete: () {
          Navigator.pop(context);
          _deleteRams(rams);
        },
        onHistory: () {
          Navigator.pop(context);
          _showHistory(rams);
        },
        onApprove: () {
          Navigator.pop(context);
          _quickStatus(rams, 'Approved');
        },
        onRevision: () {
          Navigator.pop(context);
          _quickStatus(rams, 'Revision Required');
        },
        onVerify: () {
          Navigator.pop(context);
          _quickVerification(rams, 'Verified');
        },
        onSourceOpen: widget.sourceOpener == null
            ? null
            : () {
                Navigator.pop(context);
                widget.sourceOpener!(
                  '${rams['source'] ?? ''}',
                  '${rams['referenceId'] ?? ''}',
                );
              },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredRams;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text(
          'HSE RAMS Center',
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
                _riskFilter = 'All';
                _verificationFilter = 'All';
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
        icon: const Icon(Icons.description_outlined),
        label: const Text('New RAMS'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadRams,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
                children: [
                  _buildHeader(),
                  const SizedBox(height: 12),
                  _buildDashboard(),
                  const SizedBox(height: 12),
                  _buildFilters(),
                  const SizedBox(height: 12),
                  if (filtered.isEmpty)
                    _buildEmpty()
                  else
                    ...filtered.map(_buildRamsCard),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
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
            Icon(Icons.description_outlined, color: Colors.white, size: 34),
            SizedBox(height: 8),
            Text(
              'RAMS Management Center',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Risk Assessment + Method Statement',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 4),
            Text(
              'Plan → Control → Approve → Verify → Revise',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboard() {
    final items = <Map<String, dynamic>>[
      {'label': 'Active', 'value': _activeCount, 'icon': Icons.folder_open},
      {'label': 'Draft', 'value': _draftCount, 'icon': Icons.edit_note},
      {'label': 'Approval', 'value': _approvalCount, 'icon': Icons.approval},
      {'label': 'Approved', 'value': _approvedCount, 'icon': Icons.verified},
      {'label': 'High Risk+', 'value': _highRiskCount, 'icon': Icons.warning_amber},
      {'label': 'Overdue', 'value': _overdueCount, 'icon': Icons.event_busy},
      {'label': 'Unverified', 'value': _unverifiedCount, 'icon': Icons.fact_check},
      {'label': 'Revision', 'value': _revisionCount, 'icon': Icons.change_circle},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2.35,
      ),
      itemBuilder: (_, index) {
        final item = items[index];
        return Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Icon(item['icon'] as IconData, color: primaryGreen),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${item['label']}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                Text(
                  '${item['value']}',
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: darkGreen,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilters() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Search RAMS, project, activity, contractor...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            _filterDropdown(
              'Status',
              _statusFilter,
              ['All', ...statuses],
              (v) => setState(() => _statusFilter = v ?? 'All'),
            ),
            const SizedBox(height: 10),
            _filterDropdown(
              'Priority',
              _priorityFilter,
              ['All', ...priorities],
              (v) => setState(() => _priorityFilter = v ?? 'All'),
            ),
            const SizedBox(height: 10),
            _filterDropdown(
              'Risk Level',
              _riskFilter,
              ['All', ...riskLevels],
              (v) => setState(() => _riskFilter = v ?? 'All'),
            ),
            const SizedBox(height: 10),
            _filterDropdown(
              'Verification',
              _verificationFilter,
              ['All', ...verificationStatuses],
              (v) => setState(() => _verificationFilter = v ?? 'All'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterDropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildEmpty() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Icon(
              Icons.description_outlined,
              size: 52,
              color: Colors.grey.shade500,
            ),
            const SizedBox(height: 12),
            const Text(
              'No RAMS records found.',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create a RAMS record to start the controlled work-method workflow.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRamsCard(Map<String, dynamic> rams) {
    final risk = '${rams['riskLevel'] ?? 'Low'}';
    final overdue = _isOverdue(rams);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showDetails(rams),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${rams['title'] ?? 'Untitled RAMS'}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: darkGreen,
                      ),
                    ),
                  ),
                  _chip(risk),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                '${rams['id'] ?? ''} • ${rams['revision'] ?? 'Rev 0'} • ${rams['status'] ?? 'Draft'}',
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 8),
              Text('Project: ${rams['project'] ?? '-'}'),
              Text('Activity: ${rams['activity'] ?? '-'}'),
              Text('Location: ${rams['location'] ?? '-'}'),
              Text('Contractor: ${rams['contractor'] ?? '-'}'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _smallChip('Risk: $risk'),
                  _smallChip(
                    overdue
                        ? 'Review Overdue'
                        : 'Review ${_formatDate(rams['reviewDate'])}',
                  ),
                  _smallChip(
                    'Verification: ${rams['verificationStatus'] ?? 'Not Verified'}',
                  ),
                  _smallChip(
                    'Approval: ${rams['approvalStatus'] ?? 'Not Submitted'}',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () => _showDetails(rams),
                    icon: const Icon(Icons.open_in_new, size: 18),
                    label: const Text('Details'),
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') _openForm(existing: rams);
                      if (value == 'approval') {
                        _quickStatus(rams, 'Pending Approval');
                      }
                      if (value == 'approve') {
                        _quickStatus(rams, 'Approved');
                      }
                      if (value == 'verify') {
                        _quickVerification(rams, 'Verified');
                      }
                      if (value == 'revision') {
                        _quickStatus(rams, 'Revision Required');
                      }
                      if (value == 'history') _showHistory(rams);
                      if (value == 'delete') _deleteRams(rams);
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(value: 'edit', child: Text('Edit')),
                      PopupMenuItem(
                        value: 'approval',
                        child: Text('Submit for Approval'),
                      ),
                      PopupMenuItem(
                        value: 'approve',
                        child: Text('Approve'),
                      ),
                      PopupMenuItem(
                        value: 'verify',
                        child: Text('Field Verify'),
                      ),
                      PopupMenuItem(
                        value: 'revision',
                        child: Text('Revision Required'),
                      ),
                      PopupMenuItem(
                        value: 'history',
                        child: Text('History'),
                      ),
                      PopupMenuItem(value: 'delete', child: Text('Delete')),
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

  Widget _chip(String text) {
    return Chip(
      label: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _smallChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: pageBackground,
      ),
      child: Text(text, style: const TextStyle(fontSize: 11)),
    );
  }
}

class _RamsFormSheet extends StatefulWidget {
  const _RamsFormSheet({
    required this.existing,
    required this.documentTypes,
    required this.workTypes,
    required this.sources,
    required this.statuses,
    required this.priorities,
    required this.approvalStatuses,
    required this.verificationStatuses,
    required this.riskLevels,
  });

  final Map<String, dynamic>? existing;
  final List<String> documentTypes;
  final List<String> workTypes;
  final List<String> sources;
  final List<String> statuses;
  final List<String> priorities;
  final List<String> approvalStatuses;
  final List<String> verificationStatuses;
  final List<String> riskLevels;

  @override
  State<_RamsFormSheet> createState() => _RamsFormSheetState();
}

class _RamsFormSheetState extends State<_RamsFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _title;
  late final TextEditingController _project;
  late final TextEditingController _location;
  late final TextEditingController _activity;
  late final TextEditingController _scope;
  late final TextEditingController _methodStatement;
  late final TextEditingController _hazards;
  late final TextEditingController _riskControls;
  late final TextEditingController _existingControls;
  late final TextEditingController _additionalControls;
  late final TextEditingController _ppe;
  late final TextEditingController _equipment;
  late final TextEditingController _competency;
  late final TextEditingController _roles;
  late final TextEditingController _preparedBy;
  late final TextEditingController _reviewedBy;
  late final TextEditingController _approvedBy;
  late final TextEditingController _contractor;
  late final TextEditingController _sourceReference;
  late final TextEditingController _revisionReason;
  late final TextEditingController _verificationNote;
  late final TextEditingController _reviewNote;

  String _documentType = 'RAMS';
  String _workType = 'General Construction';
  String _source = 'Step 36 Risk & Control Center';
  String _status = 'Draft';
  String _priority = 'Medium';
  String _approvalStatus = 'Not Submitted';
  String _verificationStatus = 'Not Verified';
  String _riskLevel = 'Medium';

  DateTime? _reviewDate;
  DateTime? _approvalDate;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;

    _title = TextEditingController(text: '${e?['title'] ?? ''}');
    _project = TextEditingController(text: '${e?['project'] ?? ''}');
    _location = TextEditingController(text: '${e?['location'] ?? ''}');
    _activity = TextEditingController(text: '${e?['activity'] ?? ''}');
    _scope = TextEditingController(text: '${e?['scope'] ?? ''}');
    _methodStatement =
        TextEditingController(text: '${e?['methodStatement'] ?? ''}');
    _hazards = TextEditingController(text: '${e?['hazards'] ?? ''}');
    _riskControls =
        TextEditingController(text: '${e?['riskControls'] ?? ''}');
    _existingControls =
        TextEditingController(text: '${e?['existingControls'] ?? ''}');
    _additionalControls =
        TextEditingController(text: '${e?['additionalControls'] ?? ''}');
    _ppe = TextEditingController(text: '${e?['ppe'] ?? ''}');
    _equipment = TextEditingController(text: '${e?['equipment'] ?? ''}');
    _competency = TextEditingController(text: '${e?['competency'] ?? ''}');
    _roles = TextEditingController(text: '${e?['roles'] ?? ''}');
    _preparedBy = TextEditingController(text: '${e?['preparedBy'] ?? ''}');
    _reviewedBy = TextEditingController(text: '${e?['reviewedBy'] ?? ''}');
    _approvedBy = TextEditingController(text: '${e?['approvedBy'] ?? ''}');
    _contractor = TextEditingController(text: '${e?['contractor'] ?? ''}');
    _sourceReference =
        TextEditingController(text: '${e?['referenceId'] ?? ''}');
    _revisionReason =
        TextEditingController(text: '${e?['revisionReason'] ?? ''}');
    _verificationNote =
        TextEditingController(text: '${e?['verificationNote'] ?? ''}');
    _reviewNote = TextEditingController(text: '${e?['reviewNote'] ?? ''}');

    _documentType =
        _safe(widget.documentTypes, '${e?['documentType']}', _documentType);
    _workType = _safe(widget.workTypes, '${e?['workType']}', _workType);
    _source = _safe(widget.sources, '${e?['source']}', _source);
    _status = _safe(widget.statuses, '${e?['status']}', _status);
    _priority = _safe(widget.priorities, '${e?['priority']}', _priority);
    _approvalStatus =
        _safe(widget.approvalStatuses, '${e?['approvalStatus']}', _approvalStatus);
    _verificationStatus = _safe(
      widget.verificationStatuses,
      '${e?['verificationStatus']}',
      _verificationStatus,
    );
    _riskLevel = _safe(widget.riskLevels, '${e?['riskLevel']}', _riskLevel);

    _reviewDate = DateTime.tryParse('${e?['reviewDate']}');
    _approvalDate = DateTime.tryParse('${e?['approvalDate']}');
  }

  String _safe(List<String> values, String value, String fallback) {
    return values.contains(value) ? value : fallback;
  }

  @override
  void dispose() {
    _title.dispose();
    _project.dispose();
    _location.dispose();
    _activity.dispose();
    _scope.dispose();
    _methodStatement.dispose();
    _hazards.dispose();
    _riskControls.dispose();
    _existingControls.dispose();
    _additionalControls.dispose();
    _ppe.dispose();
    _equipment.dispose();
    _competency.dispose();
    _roles.dispose();
    _preparedBy.dispose();
    _reviewedBy.dispose();
    _approvedBy.dispose();
    _contractor.dispose();
    _sourceReference.dispose();
    _revisionReason.dispose();
    _verificationNote.dispose();
    _reviewNote.dispose();
    super.dispose();
  }

  Future<void> _pickDate({
    required bool approval,
  }) async {
    final current = approval ? _approvalDate : _reviewDate;
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: current ?? DateTime.now().add(const Duration(days: 30)),
    );

    if (picked == null) return;

    setState(() {
      if (approval) {
        _approvalDate = picked;
      } else {
        _reviewDate = picked;
      }
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(context, {
      'documentType': _documentType,
      'title': _title.text.trim(),
      'project': _project.text.trim(),
      'location': _location.text.trim(),
      'workType': _workType,
      'activity': _activity.text.trim(),
      'scope': _scope.text.trim(),
      'methodStatement': _methodStatement.text.trim(),
      'hazards': _hazards.text.trim(),
      'riskLevel': _riskLevel,
      'riskControls': _riskControls.text.trim(),
      'existingControls': _existingControls.text.trim(),
      'additionalControls': _additionalControls.text.trim(),
      'ppe': _ppe.text.trim(),
      'equipment': _equipment.text.trim(),
      'competency': _competency.text.trim(),
      'roles': _roles.text.trim(),
      'preparedBy': _preparedBy.text.trim(),
      'reviewedBy': _reviewedBy.text.trim(),
      'approvedBy': _approvedBy.text.trim(),
      'contractor': _contractor.text.trim(),
      'source': _source,
      'referenceId': _sourceReference.text.trim(),
      'priority': _priority,
      'status': _status,
      'approvalStatus': _approvalStatus,
      'approvalDate': _approvalDate?.toIso8601String(),
      'verificationStatus': _verificationStatus,
      'reviewDate': _reviewDate?.toIso8601String(),
      'revisionReason': _revisionReason.text.trim(),
      'verificationNote': _verificationNote.text.trim(),
      'reviewNote': _reviewNote.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Material(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 14, 16, 16 + bottom),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .92,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.existing == null
                        ? 'Create RAMS'
                        : 'Edit RAMS',
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      children: [
                        _text(
                          _title,
                          'RAMS Title',
                          required: true,
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          'Document Type',
                          _documentType,
                          widget.documentTypes,
                          (v) => setState(() => _documentType = v!),
                        ),
                        const SizedBox(height: 10),
                        _text(_project, 'Project / Work Package'),
                        const SizedBox(height: 10),
                        _text(_contractor, 'Contractor / Company'),
                        const SizedBox(height: 10),
                        _text(_location, 'Location / Area'),
                        const SizedBox(height: 10),
                        _dropdown(
                          'Work Type',
                          _workType,
                          widget.workTypes,
                          (v) => setState(() => _workType = v!),
                        ),
                        const SizedBox(height: 10),
                        _text(_activity, 'Work Activity', required: true),
                        const SizedBox(height: 10),
                        _text(_scope, 'Scope of Work', maxLines: 4),
                        const SizedBox(height: 10),
                        _text(
                          _methodStatement,
                          'Method Statement / Work Sequence',
                          maxLines: 7,
                        ),
                        const SizedBox(height: 10),
                        _section('Risk & Controls'),
                        _text(
                          _hazards,
                          'Hazards / Potential Harm',
                          maxLines: 5,
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          'Overall Risk Level',
                          _riskLevel,
                          widget.riskLevels,
                          (v) => setState(() => _riskLevel = v!),
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _riskControls,
                          'Risk Assessment / Control Link',
                          maxLines: 4,
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _existingControls,
                          'Existing Controls',
                          maxLines: 4,
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _additionalControls,
                          'Additional Control Measures',
                          maxLines: 5,
                        ),
                        const SizedBox(height: 10),
                        _section('Resources & Competency'),
                        _text(_ppe, 'PPE Requirements', maxLines: 3),
                        const SizedBox(height: 10),
                        _text(_equipment, 'Plant / Equipment / Tools', maxLines: 3),
                        const SizedBox(height: 10),
                        _text(_competency, 'Training / Competency Requirements', maxLines: 3),
                        const SizedBox(height: 10),
                        _text(_roles, 'Roles & Responsibilities', maxLines: 4),
                        const SizedBox(height: 10),
                        _section('Review & Approval'),
                        _text(_preparedBy, 'Prepared By'),
                        const SizedBox(height: 10),
                        _text(_reviewedBy, 'Reviewed By'),
                        const SizedBox(height: 10),
                        _text(_approvedBy, 'Approved By'),
                        const SizedBox(height: 10),
                        _dropdown(
                          'Priority',
                          _priority,
                          widget.priorities,
                          (v) => setState(() => _priority = v!),
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          'Approval Status',
                          _approvalStatus,
                          widget.approvalStatuses,
                          (v) => setState(() => _approvalStatus = v!),
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton.icon(
                          onPressed: () => _pickDate(approval: true),
                          icon: const Icon(Icons.approval),
                          label: Text(
                            _approvalDate == null
                                ? 'Select Approval Date'
                                : 'Approval: ${_formatDate(_approvalDate)}',
                          ),
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          'Field Verification',
                          _verificationStatus,
                          widget.verificationStatuses,
                          (v) =>
                              setState(() => _verificationStatus = v!),
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton.icon(
                          onPressed: () => _pickDate(approval: false),
                          icon: const Icon(Icons.event),
                          label: Text(
                            _reviewDate == null
                                ? 'Select Review Date'
                                : 'Review: ${_formatDate(_reviewDate)}',
                          ),
                        ),
                        const SizedBox(height: 10),
                        _text(_reviewNote, 'Review Note', maxLines: 3),
                        const SizedBox(height: 10),
                        _text(
                          _verificationNote,
                          'Field Verification Note',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _revisionReason,
                          'Revision / Change Reason',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          'Source',
                          _source,
                          widget.sources,
                          (v) => setState(() => _source = v!),
                        ),
                        const SizedBox(height: 10),
                        _text(_sourceReference, 'Reference ID'),
                        const SizedBox(height: 10),
                        _dropdown(
                          'Status',
                          _status,
                          widget.statuses,
                          (v) => setState(() => _status = v!),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: primaryGreen,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _submit,
                      icon: const Icon(Icons.save),
                      label: Text(
                        widget.existing == null ? 'Save RAMS' : 'Update RAMS',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _section(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        title,
        style: const TextStyle(
          color: darkGreen,
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _text(
    TextEditingController controller,
    String label, {
    bool required = false,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: required
          ? (value) =>
              value == null || value.trim().isEmpty ? 'Required' : null
          : null,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _dropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}

class _RamsDetailsSheet extends StatelessWidget {
  const _RamsDetailsSheet({
    required this.rams,
    required this.onEdit,
    required this.onDelete,
    required this.onHistory,
    required this.onApprove,
    required this.onRevision,
    required this.onVerify,
    required this.onSourceOpen,
  });

  final Map<String, dynamic> rams;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onHistory;
  final VoidCallback onApprove;
  final VoidCallback onRevision;
  final VoidCallback onVerify;
  final VoidCallback? onSourceOpen;

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color(0xFF0B5D4B);
    const primaryGreen = Color(0xFF159447);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .84,
          child: ListView(
            children: [
              Text(
                '${rams['title'] ?? 'RAMS'}',
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: darkGreen,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${rams['id'] ?? ''} • ${rams['revision'] ?? 'Rev 0'}',
              ),
              const Divider(height: 24),
              _row('Document Type', rams['documentType']),
              _row('Project', rams['project']),
              _row('Contractor', rams['contractor']),
              _row('Location', rams['location']),
              _row('Work Type', rams['workType']),
              _row('Activity', rams['activity']),
              _row('Scope', rams['scope']),
              _row('Method Statement', rams['methodStatement']),
              _row('Hazards', rams['hazards']),
              _row('Risk Level', rams['riskLevel']),
              _row('Risk / Control Link', rams['riskControls']),
              _row('Existing Controls', rams['existingControls']),
              _row('Additional Controls', rams['additionalControls']),
              _row('PPE', rams['ppe']),
              _row('Equipment', rams['equipment']),
              _row('Competency', rams['competency']),
              _row('Roles', rams['roles']),
              _row('Prepared By', rams['preparedBy']),
              _row('Reviewed By', rams['reviewedBy']),
              _row('Approved By', rams['approvedBy']),
              _row('Priority', rams['priority']),
              _row('Approval Status', rams['approvalStatus']),
              _row('Approval Date', _formatDate(rams['approvalDate'])),
              _row('Verification', rams['verificationStatus']),
              _row('Review Date', _formatDate(rams['reviewDate'])),
              _row('Review Note', rams['reviewNote']),
              _row('Verification Note', rams['verificationNote']),
              _row('Revision Reason', rams['revisionReason']),
              _row('Source', rams['source']),
              _row('Reference ID', rams['referenceId']),
              _row('Status', rams['status']),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: primaryGreen,
                    ),
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onApprove,
                    icon: const Icon(Icons.verified),
                    label: const Text('Approve'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onVerify,
                    icon: const Icon(Icons.fact_check),
                    label: const Text('Verify'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onRevision,
                    icon: const Icon(Icons.change_circle),
                    label: const Text('Revision'),
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

  Widget _row(String label, dynamic value) {
    final text = value == null || '$value' == 'null' || '$value'.isEmpty
        ? '-'
        : '$value';

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
  if (value == null || '$value' == 'null' || '$value'.isEmpty) return '-';

  final date = DateTime.tryParse('$value');
  if (date == null) return '$value';

  return '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.year}';
}

String _formatDateTime(dynamic value) {
  if (value == null || '$value' == 'null' || '$value'.isEmpty) return '-';

  final date = DateTime.tryParse('$value');
  if (date == null) return '$value';

  return '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.year} '
      '${date.hour.toString().padLeft(2, '0')}:'
      '${date.minute.toString().padLeft(2, '0')}';
}
