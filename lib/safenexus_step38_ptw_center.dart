import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ===============================================================
/// SafeNexus HSE
/// STEP 38 — PERMIT TO WORK (PTW) MANAGEMENT CENTER
///
/// 38A  PTW Master
/// 38B  Permit Request & Work Scope
/// 38C  Permit Type & Classification
/// 38D  Hazard / Risk & RAMS Link
/// 38E  Isolation / LOTO Controls
/// 38F  Gas Test / Atmospheric Monitoring
/// 38G  PPE, Equipment & Precautions
/// 38H  Permit Review & Authorization
/// 38I  Permit Issue / Suspension / Revalidation
/// 38J  Worksite Verification & Permit Closure
/// 38K  Permit History / Audit Trail
/// 38L  PTW Intelligence Dashboard
///
/// Workflow:
/// Request → Risk/RAMS Check → Controls → Authorization → Issue
/// → Work → Verify → Suspend/Revalidate → Close → Analyze
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

class SafeNexusStep38PtwCenterPage extends StatefulWidget {
  const SafeNexusStep38PtwCenterPage({
    super.key,
    this.sourceOpener,
  });

  final void Function(String referenceType, String referenceId)? sourceOpener;

  @override
  State<SafeNexusStep38PtwCenterPage> createState() =>
      _SafeNexusStep38PtwCenterPageState();
}

class _SafeNexusStep38PtwCenterPageState
    extends State<SafeNexusStep38PtwCenterPage> {
  static const String storageKey = 'safenexus_hse_step38_ptw_center';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const List<String> permitTypes = [
    'Hot Work Permit',
    'Cold Work Permit',
    'Confined Space Entry',
    'Work at Height',
    'Excavation / Ground Disturbance',
    'Electrical Work',
    'Lifting Operation',
    'Line Breaking / Breaking Containment',
    'Radiography / Radiation Work',
    'Marine / Port Work',
    'Vehicle / Traffic Work',
    'Other',
  ];

  static const List<String> classifications = [
    'Routine',
    'Non-Routine',
    'High Risk',
    'Critical',
    'Emergency',
  ];

  static const List<String> sources = [
    'Step 9 Daily HSE',
    'Step 31 Smart Checklist',
    'Step 32 Field Operations',
    'Step 34 Documents & Records',
    'Step 35 Action Center',
    'Step 36 Risk & Control Center',
    'Step 37 RAMS Center',
    'Incident',
    'Other',
  ];

  static const List<String> statuses = [
    'Draft',
    'Requested',
    'Under HSE Review',
    'Pending Authorization',
    'Authorized',
    'Issued',
    'Active',
    'Suspended',
    'Revalidated',
    'Expired',
    'Closed',
    'Rejected',
    'Cancelled',
  ];

  static const List<String> priorities = [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static const List<String> isolationStatuses = [
    'Not Required',
    'Planned',
    'Applied',
    'Verified',
    'Removed',
  ];

  static const List<String> gasTestStatuses = [
    'Not Required',
    'Pending',
    'Safe',
    'Unsafe',
    'Expired',
  ];

  static const List<String> verificationStatuses = [
    'Not Verified',
    'Verified',
    'Partially Verified',
    'Failed',
  ];

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _permits = [];
  bool _loading = true;

  String _statusFilter = 'All';
  String _typeFilter = 'All';
  String _priorityFilter = 'All';
  String _overdueFilter = 'All';

  @override
  void initState() {
    super.initState();
    _loadPermits();
    _searchController.addListener(_refresh);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refresh)
      ..dispose();
    super.dispose();
  }

  Future<void> _loadPermits() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);

    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          _permits = decoded
              .whereType<Map>()
              .map((item) => Map<String, dynamic>.from(item))
              .toList();
        }
      } catch (_) {
        _permits = [];
      }
    }

    if (mounted) {
      setState(() => _loading = false);
    }
  }

  Future<void> _savePermits() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(_permits));
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  bool _isOverdue(Map<String, dynamic> permit) {
    final status = '${permit['status']}';
    if (status == 'Closed' ||
        status == 'Cancelled' ||
        status == 'Rejected' ||
        status == 'Expired') {
      return false;
    }

    final expiry = DateTime.tryParse('${permit['expiryDateTime']}');
    if (expiry == null) return false;

    return expiry.isBefore(DateTime.now());
  }

  bool _isCurrentlyActive(Map<String, dynamic> permit) {
    final status = '${permit['status']}';
    return status == 'Issued' ||
        status == 'Active' ||
        status == 'Revalidated';
  }

  List<Map<String, dynamic>> get _filteredPermits {
    final query = _searchController.text.trim().toLowerCase();

    return _permits.where((permit) {
      final searchable = [
        permit['id'],
        permit['title'],
        permit['permitType'],
        permit['classification'],
        permit['project'],
        permit['location'],
        permit['activity'],
        permit['performingAuthority'],
        permit['issuingAuthority'],
        permit['source'],
        permit['referenceId'],
        permit['ramsReference'],
        permit['riskReference'],
        permit['status'],
      ].map((v) => '$v').join(' ').toLowerCase();

      final searchOk = query.isEmpty || searchable.contains(query);
      final statusOk =
          _statusFilter == 'All' || '${permit['status']}' == _statusFilter;
      final typeOk = _typeFilter == 'All' ||
          '${permit['permitType']}' == _typeFilter;
      final priorityOk = _priorityFilter == 'All' ||
          '${permit['priority']}' == _priorityFilter;

      final overdue = _isOverdue(permit);
      final overdueOk = _overdueFilter == 'All' ||
          (_overdueFilter == 'Overdue' && overdue) ||
          (_overdueFilter == 'Not Overdue' && !overdue);

      return searchOk && statusOk && typeOk && priorityOk && overdueOk;
    }).toList();
  }

  int _count(bool Function(Map<String, dynamic>) test) =>
      _permits.where(test).length;

  int get _activeCount => _count(_isCurrentlyActive);

  int get _pendingCount => _count(
        (p) =>
            '${p['status']}' == 'Requested' ||
            '${p['status']}' == 'Under HSE Review' ||
            '${p['status']}' == 'Pending Authorization',
      );

  int get _highRiskCount => _count(
        (p) =>
            '${p['priority']}' == 'High' ||
            '${p['priority']}' == 'Critical' ||
            '${p['classification']}' == 'High Risk' ||
            '${p['classification']}' == 'Critical',
      );

  int get _overdueCount => _count(_isOverdue);

  int get _suspendedCount =>
      _count((p) => '${p['status']}' == 'Suspended');

  int get _unverifiedCount =>
      _count((p) => '${p['verificationStatus']}' != 'Verified');

  int get _gasUnsafeCount =>
      _count((p) => '${p['gasTestStatus']}' == 'Unsafe');

  int get _closedCount => _count((p) => '${p['status']}' == 'Closed');

  Future<void> _openForm({Map<String, dynamic>? existing}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _PtwFormSheet(
        existing: existing,
        permitTypes: permitTypes,
        classifications: classifications,
        sources: sources,
        statuses: statuses,
        priorities: priorities,
        isolationStatuses: isolationStatuses,
        gasTestStatuses: gasTestStatuses,
        verificationStatuses: verificationStatuses,
      ),
    );

    if (result == null) return;

    final now = DateTime.now().toIso8601String();

    if (existing == null) {
      result['id'] = 'PTW-${DateTime.now().millisecondsSinceEpoch}';
      result['permitNumber'] = 'PTW-${DateTime.now().millisecondsSinceEpoch}';
      result['createdAt'] = now;
      result['updatedAt'] = now;
      result['history'] = [
        {
          'at': now,
          'event': 'Permit created',
          'note': 'New PTW record created.',
        },
      ];
      _permits.insert(0, result);
    } else {
      final index = _permits.indexWhere((p) => p['id'] == existing['id']);

      if (index >= 0) {
        final history = _historyFrom(existing['history']);
        history.add({
          'at': now,
          'event': 'Permit updated',
          'note': 'PTW record updated.',
        });

        result['id'] = existing['id'];
        result['permitNumber'] =
            existing['permitNumber'] ?? existing['id'];
        result['createdAt'] = existing['createdAt'] ?? now;
        result['updatedAt'] = now;
        result['history'] = history;
        _permits[index] = result;
      }
    }

    await _savePermits();
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

  Future<void> _deletePermit(Map<String, dynamic> permit) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Permit?'),
        content: Text(
          'Permanently remove ${permit['id'] ?? 'this permit'} '
          'from local PTW storage?',
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

    _permits.removeWhere((p) => p['id'] == permit['id']);
    await _savePermits();

    if (mounted) setState(() {});
  }

  Future<void> _quickStatus(
    Map<String, dynamic> permit,
    String status,
  ) async {
    final index = _permits.indexWhere((p) => p['id'] == permit['id']);
    if (index < 0) return;

    final updated = Map<String, dynamic>.from(_permits[index]);
    final now = DateTime.now().toIso8601String();

    updated['status'] = status;
    updated['updatedAt'] = now;

    if (status == 'Issued' || status == 'Active') {
      updated['issueDateTime'] ??= now;
    }

    if (status == 'Closed') {
      updated['closureDateTime'] = now;
    }

    final history = _historyFrom(updated['history']);
    history.add({
      'at': now,
      'event': 'Status changed',
      'note': 'Permit status changed to $status.',
    });
    updated['history'] = history;

    _permits[index] = updated;
    await _savePermits();

    if (mounted) setState(() {});
  }

  Future<void> _quickVerification(
    Map<String, dynamic> permit,
    String status,
  ) async {
    final index = _permits.indexWhere((p) => p['id'] == permit['id']);
    if (index < 0) return;

    final updated = Map<String, dynamic>.from(_permits[index]);
    final now = DateTime.now().toIso8601String();

    updated['verificationStatus'] = status;
    updated['updatedAt'] = now;

    if (status == 'Failed') {
      updated['status'] = 'Suspended';
    }

    final history = _historyFrom(updated['history']);
    history.add({
      'at': now,
      'event': 'Worksite verification',
      'note': 'Verification status changed to $status.',
    });
    updated['history'] = history;

    _permits[index] = updated;
    await _savePermits();

    if (mounted) setState(() {});
  }

  Future<void> _quickGasTest(
    Map<String, dynamic> permit,
    String status,
  ) async {
    final index = _permits.indexWhere((p) => p['id'] == permit['id']);
    if (index < 0) return;

    final updated = Map<String, dynamic>.from(_permits[index]);
    final now = DateTime.now().toIso8601String();

    updated['gasTestStatus'] = status;
    updated['gasTestDateTime'] = now;
    updated['updatedAt'] = now;

    if (status == 'Unsafe') {
      updated['status'] = 'Suspended';
    }

    final history = _historyFrom(updated['history']);
    history.add({
      'at': now,
      'event': 'Gas test update',
      'note': 'Atmospheric test status changed to $status.',
    });
    updated['history'] = history;

    _permits[index] = updated;
    await _savePermits();

    if (mounted) setState(() {});
  }

  void _showHistory(Map<String, dynamic> permit) {
    final history = _historyFrom(permit['history']);

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
                  'PTW History — ${permit['id']}',
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
                              title: Text(
                                '${item['event'] ?? 'Update'}',
                              ),
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

  void _showDetails(Map<String, dynamic> permit) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _PtwDetailsSheet(
        permit: permit,
        onEdit: () {
          Navigator.pop(context);
          _openForm(existing: permit);
        },
        onDelete: () {
          Navigator.pop(context);
          _deletePermit(permit);
        },
        onHistory: () {
          Navigator.pop(context);
          _showHistory(permit);
        },
        onAuthorize: () {
          Navigator.pop(context);
          _quickStatus(permit, 'Authorized');
        },
        onIssue: () {
          Navigator.pop(context);
          _quickStatus(permit, 'Issued');
        },
        onSuspend: () {
          Navigator.pop(context);
          _quickStatus(permit, 'Suspended');
        },
        onVerify: () {
          Navigator.pop(context);
          _quickVerification(permit, 'Verified');
        },
        onGasSafe: () {
          Navigator.pop(context);
          _quickGasTest(permit, 'Safe');
        },
        onGasUnsafe: () {
          Navigator.pop(context);
          _quickGasTest(permit, 'Unsafe');
        },
        onClose: () {
          Navigator.pop(context);
          _quickStatus(permit, 'Closed');
        },
        onSourceOpen: widget.sourceOpener == null
            ? null
            : () {
                Navigator.pop(context);
                widget.sourceOpener!(
                  '${permit['source'] ?? ''}',
                  '${permit['referenceId'] ?? ''}',
                );
              },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredPermits;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text(
          'HSE PTW Center',
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
                _typeFilter = 'All';
                _priorityFilter = 'All';
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
        icon: const Icon(Icons.assignment_outlined),
        label: const Text('New Permit'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadPermits,
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
                    ...filtered.map(_buildPermitCard),
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
            Icon(
              Icons.assignment_outlined,
              color: Colors.white,
              size: 34,
            ),
            SizedBox(height: 8),
            Text(
              'Permit to Work Management Center',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Request → Review → Authorize → Issue → Work → Close',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 4),
            Text(
              'Controlled high-risk work management • UAE-wide 🇦🇪',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboard() {
    final items = <Map<String, dynamic>>[
      {'label': 'Active', 'value': _activeCount, 'icon': Icons.play_circle},
      {'label': 'Pending', 'value': _pendingCount, 'icon': Icons.pending_actions},
      {'label': 'High Risk+', 'value': _highRiskCount, 'icon': Icons.warning_amber},
      {'label': 'Overdue', 'value': _overdueCount, 'icon': Icons.event_busy},
      {'label': 'Suspended', 'value': _suspendedCount, 'icon': Icons.pause_circle},
      {'label': 'Unverified', 'value': _unverifiedCount, 'icon': Icons.fact_check},
      {'label': 'Gas Unsafe', 'value': _gasUnsafeCount, 'icon': Icons.air},
      {'label': 'Closed', 'value': _closedCount, 'icon': Icons.task_alt},
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
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            child: Row(
              children: [
                Icon(
                  item['icon'] as IconData,
                  color: primaryGreen,
                ),
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
                labelText: 'Search permit, activity, location, RAMS...',
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
              'Permit Type',
              _typeFilter,
              ['All', ...permitTypes],
              (v) => setState(() => _typeFilter = v ?? 'All'),
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
              'Expiry',
              _overdueFilter,
              const ['All', 'Overdue', 'Not Overdue'],
              (v) => setState(() => _overdueFilter = v ?? 'All'),
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
              Icons.assignment_outlined,
              size: 52,
              color: Colors.grey.shade500,
            ),
            const SizedBox(height: 12),
            const Text(
              'No PTW records found.',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create a Permit to Work record to start controlled work management.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermitCard(Map<String, dynamic> permit) {
    final overdue = _isOverdue(permit);
    final active = _isCurrentlyActive(permit);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showDetails(permit),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${permit['title'] ?? 'Untitled Permit'}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: darkGreen,
                      ),
                    ),
                  ),
                  _chip('${permit['priority'] ?? 'Medium'}'),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                '${permit['id'] ?? ''} • '
                '${permit['permitType'] ?? ''} • '
                '${permit['status'] ?? 'Draft'}',
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 8),
              Text('Activity: ${permit['activity'] ?? '-'}'),
              Text('Location: ${permit['location'] ?? '-'}'),
              Text('Performing Authority: ${permit['performingAuthority'] ?? '-'}'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _smallChip(
                    active ? 'Work Active' : 'Status: ${permit['status'] ?? '-'}',
                  ),
                  _smallChip(
                    overdue
                        ? 'Permit Expired'
                        : 'Expires ${_formatDateTime(permit['expiryDateTime'])}',
                  ),
                  _smallChip(
                    'Risk: ${permit['riskLevel'] ?? 'Medium'}',
                  ),
                  _smallChip(
                    'Isolation: ${permit['isolationStatus'] ?? 'Not Required'}',
                  ),
                  _smallChip(
                    'Gas: ${permit['gasTestStatus'] ?? 'Not Required'}',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () => _showDetails(permit),
                    icon: const Icon(Icons.open_in_new, size: 18),
                    label: const Text('Details'),
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _openForm(existing: permit);
                      } else if (value == 'authorize') {
                        _quickStatus(permit, 'Authorized');
                      } else if (value == 'issue') {
                        _quickStatus(permit, 'Issued');
                      } else if (value == 'active') {
                        _quickStatus(permit, 'Active');
                      } else if (value == 'suspend') {
                        _quickStatus(permit, 'Suspended');
                      } else if (value == 'verify') {
                        _quickVerification(permit, 'Verified');
                      } else if (value == 'gasSafe') {
                        _quickGasTest(permit, 'Safe');
                      } else if (value == 'gasUnsafe') {
                        _quickGasTest(permit, 'Unsafe');
                      } else if (value == 'close') {
                        _quickStatus(permit, 'Closed');
                      } else if (value == 'history') {
                        _showHistory(permit);
                      } else if (value == 'delete') {
                        _deletePermit(permit);
                      }
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      PopupMenuItem(
                        value: 'authorize',
                        child: Text('Authorize'),
                      ),
                      PopupMenuItem(
                        value: 'issue',
                        child: Text('Issue Permit'),
                      ),
                      PopupMenuItem(
                        value: 'active',
                        child: Text('Start / Active'),
                      ),
                      PopupMenuItem(
                        value: 'suspend',
                        child: Text('Suspend'),
                      ),
                      PopupMenuItem(
                        value: 'verify',
                        child: Text('Worksite Verify'),
                      ),
                      PopupMenuItem(
                        value: 'gasSafe',
                        child: Text('Gas Test Safe'),
                      ),
                      PopupMenuItem(
                        value: 'gasUnsafe',
                        child: Text('Gas Test Unsafe'),
                      ),
                      PopupMenuItem(
                        value: 'close',
                        child: Text('Close Permit'),
                      ),
                      PopupMenuItem(
                        value: 'history',
                        child: Text('History'),
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
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: pageBackground,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11),
      ),
    );
  }
}

class _PtwFormSheet extends StatefulWidget {
  const _PtwFormSheet({
    required this.existing,
    required this.permitTypes,
    required this.classifications,
    required this.sources,
    required this.statuses,
    required this.priorities,
    required this.isolationStatuses,
    required this.gasTestStatuses,
    required this.verificationStatuses,
  });

  final Map<String, dynamic>? existing;
  final List<String> permitTypes;
  final List<String> classifications;
  final List<String> sources;
  final List<String> statuses;
  final List<String> priorities;
  final List<String> isolationStatuses;
  final List<String> gasTestStatuses;
  final List<String> verificationStatuses;

  @override
  State<_PtwFormSheet> createState() => _PtwFormSheetState();
}

class _PtwFormSheetState extends State<_PtwFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _title;
  late final TextEditingController _project;
  late final TextEditingController _location;
  late final TextEditingController _activity;
  late final TextEditingController _scope;
  late final TextEditingController _performingAuthority;
  late final TextEditingController _issuingAuthority;
  late final TextEditingController _areaOwner;
  late final TextEditingController _hazards;
  late final TextEditingController _controls;
  late final TextEditingController _ramsReference;
  late final TextEditingController _riskReference;
  late final TextEditingController _sourceReference;
  late final TextEditingController _isolationDetails;
  late final TextEditingController _gasTestDetails;
  late final TextEditingController _ppe;
  late final TextEditingController _equipment;
  late final TextEditingController _precautions;
  late final TextEditingController _emergencyPlan;
  late final TextEditingController _authorizationNote;
  late final TextEditingController _verificationNote;
  late final TextEditingController _closureNote;

  String _permitType = 'Hot Work Permit';
  String _classification = 'High Risk';
  String _source = 'Step 37 RAMS Center';
  String _status = 'Draft';
  String _priority = 'High';
  String _riskLevel = 'High';
  String _isolationStatus = 'Not Required';
  String _gasTestStatus = 'Not Required';
  String _verificationStatus = 'Not Verified';

  DateTime? _startDateTime;
  DateTime? _expiryDateTime;
  DateTime? _issueDateTime;
  DateTime? _closureDateTime;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;

    _title = TextEditingController(text: '${e?['title'] ?? ''}');
    _project = TextEditingController(text: '${e?['project'] ?? ''}');
    _location = TextEditingController(text: '${e?['location'] ?? ''}');
    _activity = TextEditingController(text: '${e?['activity'] ?? ''}');
    _scope = TextEditingController(text: '${e?['scope'] ?? ''}');
    _performingAuthority = TextEditingController(
      text: '${e?['performingAuthority'] ?? ''}',
    );
    _issuingAuthority = TextEditingController(
      text: '${e?['issuingAuthority'] ?? ''}',
    );
    _areaOwner = TextEditingController(
      text: '${e?['areaOwner'] ?? ''}',
    );
    _hazards = TextEditingController(
      text: '${e?['hazards'] ?? ''}',
    );
    _controls = TextEditingController(
      text: '${e?['controls'] ?? ''}',
    );
    _ramsReference = TextEditingController(
      text: '${e?['ramsReference'] ?? ''}',
    );
    _riskReference = TextEditingController(
      text: '${e?['riskReference'] ?? ''}',
    );
    _sourceReference = TextEditingController(
      text: '${e?['referenceId'] ?? ''}',
    );
    _isolationDetails = TextEditingController(
      text: '${e?['isolationDetails'] ?? ''}',
    );
    _gasTestDetails = TextEditingController(
      text: '${e?['gasTestDetails'] ?? ''}',
    );
    _ppe = TextEditingController(
      text: '${e?['ppe'] ?? ''}',
    );
    _equipment = TextEditingController(
      text: '${e?['equipment'] ?? ''}',
    );
    _precautions = TextEditingController(
      text: '${e?['precautions'] ?? ''}',
    );
    _emergencyPlan = TextEditingController(
      text: '${e?['emergencyPlan'] ?? ''}',
    );
    _authorizationNote = TextEditingController(
      text: '${e?['authorizationNote'] ?? ''}',
    );
    _verificationNote = TextEditingController(
      text: '${e?['verificationNote'] ?? ''}',
    );
    _closureNote = TextEditingController(
      text: '${e?['closureNote'] ?? ''}',
    );

    _permitType = _safe(
      widget.permitTypes,
      '${e?['permitType']}',
      _permitType,
    );
    _classification = _safe(
      widget.classifications,
      '${e?['classification']}',
      _classification,
    );
    _source = _safe(widget.sources, '${e?['source']}', _source);
    _status = _safe(widget.statuses, '${e?['status']}', _status);
    _priority = _safe(widget.priorities, '${e?['priority']}', _priority);
    _riskLevel = _safe(
      const ['Low', 'Medium', 'High', 'Critical'],
      '${e?['riskLevel']}',
      _riskLevel,
    );
    _isolationStatus = _safe(
      widget.isolationStatuses,
      '${e?['isolationStatus']}',
      _isolationStatus,
    );
    _gasTestStatus = _safe(
      widget.gasTestStatuses,
      '${e?['gasTestStatus']}',
      _gasTestStatus,
    );
    _verificationStatus = _safe(
      widget.verificationStatuses,
      '${e?['verificationStatus']}',
      _verificationStatus,
    );

    _startDateTime = DateTime.tryParse('${e?['startDateTime']}');
    _expiryDateTime = DateTime.tryParse('${e?['expiryDateTime']}');
    _issueDateTime = DateTime.tryParse('${e?['issueDateTime']}');
    _closureDateTime = DateTime.tryParse('${e?['closureDateTime']}');
  }

  String _safe(
    List<String> values,
    String value,
    String fallback,
  ) {
    return values.contains(value) ? value : fallback;
  }

  @override
  void dispose() {
    _title.dispose();
    _project.dispose();
    _location.dispose();
    _activity.dispose();
    _scope.dispose();
    _performingAuthority.dispose();
    _issuingAuthority.dispose();
    _areaOwner.dispose();
    _hazards.dispose();
    _controls.dispose();
    _ramsReference.dispose();
    _riskReference.dispose();
    _sourceReference.dispose();
    _isolationDetails.dispose();
    _gasTestDetails.dispose();
    _ppe.dispose();
    _equipment.dispose();
    _precautions.dispose();
    _emergencyPlan.dispose();
    _authorizationNote.dispose();
    _verificationNote.dispose();
    _closureNote.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime({
    required String field,
  }) async {
    DateTime current;

    if (field == 'start') {
      current = _startDateTime ?? DateTime.now();
    } else if (field == 'expiry') {
      current = _expiryDateTime ??
          DateTime.now().add(const Duration(hours: 8));
    } else if (field == 'issue') {
      current = _issueDateTime ?? DateTime.now();
    } else {
      current = _closureDateTime ?? DateTime.now();
    }

    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: current,
    );

    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(current),
    );

    if (time == null) return;

    final picked = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      if (field == 'start') {
        _startDateTime = picked;
      } else if (field == 'expiry') {
        _expiryDateTime = picked;
      } else if (field == 'issue') {
        _issueDateTime = picked;
      } else {
        _closureDateTime = picked;
      }
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(context, {
      'permitType': _permitType,
      'classification': _classification,
      'title': _title.text.trim(),
      'project': _project.text.trim(),
      'location': _location.text.trim(),
      'activity': _activity.text.trim(),
      'scope': _scope.text.trim(),
      'performingAuthority': _performingAuthority.text.trim(),
      'issuingAuthority': _issuingAuthority.text.trim(),
      'areaOwner': _areaOwner.text.trim(),
      'hazards': _hazards.text.trim(),
      'controls': _controls.text.trim(),
      'ramsReference': _ramsReference.text.trim(),
      'riskReference': _riskReference.text.trim(),
      'source': _source,
      'referenceId': _sourceReference.text.trim(),
      'priority': _priority,
      'riskLevel': _riskLevel,
      'isolationStatus': _isolationStatus,
      'isolationDetails': _isolationDetails.text.trim(),
      'gasTestStatus': _gasTestStatus,
      'gasTestDetails': _gasTestDetails.text.trim(),
      'ppe': _ppe.text.trim(),
      'equipment': _equipment.text.trim(),
      'precautions': _precautions.text.trim(),
      'emergencyPlan': _emergencyPlan.text.trim(),
      'authorizationNote': _authorizationNote.text.trim(),
      'verificationStatus': _verificationStatus,
      'verificationNote': _verificationNote.text.trim(),
      'closureNote': _closureNote.text.trim(),
      'status': _status,
      'startDateTime': _startDateTime?.toIso8601String(),
      'expiryDateTime': _expiryDateTime?.toIso8601String(),
      'issueDateTime': _issueDateTime?.toIso8601String(),
      'closureDateTime': _closureDateTime?.toIso8601String(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Material(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(22),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            14,
            16,
            16 + bottom,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .94,
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
                        ? 'Create Permit to Work'
                        : 'Edit Permit to Work',
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
                          'Permit Title',
                          required: true,
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          'Permit Type',
                          _permitType,
                          widget.permitTypes,
                          (v) => setState(() => _permitType = v!),
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          'Classification',
                          _classification,
                          widget.classifications,
                          (v) => setState(() => _classification = v!),
                        ),
                        const SizedBox(height: 10),
                        _text(_project, 'Project / Work Package'),
                        const SizedBox(height: 10),
                        _text(_location, 'Location / Area', required: true),
                        const SizedBox(height: 10),
                        _text(_activity, 'Work Activity', required: true),
                        const SizedBox(height: 10),
                        _text(_scope, 'Work Scope', maxLines: 4),
                        const SizedBox(height: 10),
                        _text(
                          _performingAuthority,
                          'Performing Authority / Permit Holder',
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _issuingAuthority,
                          'Issuing Authority / Authorized Person',
                        ),
                        const SizedBox(height: 10),
                        _text(_areaOwner, 'Area / Asset Owner'),
                        const SizedBox(height: 10),
                        _section('Risk & RAMS'),
                        _text(
                          _hazards,
                          'Hazards / Potential Harm',
                          maxLines: 5,
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          'Risk Level',
                          _riskLevel,
                          const [
                            'Low',
                            'Medium',
                            'High',
                            'Critical',
                          ],
                          (v) => setState(() => _riskLevel = v!),
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _controls,
                          'Required Control Measures',
                          maxLines: 5,
                        ),
                        const SizedBox(height: 10),
                        _text(_ramsReference, 'RAMS Reference'),
                        const SizedBox(height: 10),
                        _text(_riskReference, 'Risk Assessment Reference'),
                        const SizedBox(height: 10),
                        _section('Isolation / LOTO'),
                        _dropdown(
                          'Isolation Status',
                          _isolationStatus,
                          widget.isolationStatuses,
                          (v) =>
                              setState(() => _isolationStatus = v!),
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _isolationDetails,
                          'Isolation / LOTO Details',
                          maxLines: 4,
                        ),
                        const SizedBox(height: 10),
                        _section('Gas Test / Atmospheric Monitoring'),
                        _dropdown(
                          'Gas Test Status',
                          _gasTestStatus,
                          widget.gasTestStatuses,
                          (v) => setState(() => _gasTestStatus = v!),
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _gasTestDetails,
                          'Gas Test Details / Readings',
                          maxLines: 4,
                        ),
                        const SizedBox(height: 10),
                        _section('PPE / Equipment / Precautions'),
                        _text(_ppe, 'PPE Requirements', maxLines: 3),
                        const SizedBox(height: 10),
                        _text(
                          _equipment,
                          'Equipment / Tools / Plant',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _precautions,
                          'Special Precautions',
                          maxLines: 4,
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _emergencyPlan,
                          'Emergency / Rescue Plan',
                          maxLines: 4,
                        ),
                        const SizedBox(height: 10),
                        _section('Authorization & Verification'),
                        _dropdown(
                          'Priority',
                          _priority,
                          widget.priorities,
                          (v) => setState(() => _priority = v!),
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _authorizationNote,
                          'Authorization Note',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          'Worksite Verification',
                          _verificationStatus,
                          widget.verificationStatuses,
                          (v) =>
                              setState(() => _verificationStatus = v!),
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _verificationNote,
                          'Verification Note',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton.icon(
                          onPressed: () =>
                              _pickDateTime(field: 'start'),
                          icon: const Icon(Icons.play_arrow),
                          label: Text(
                            _startDateTime == null
                                ? 'Select Start Date & Time'
                                : 'Start: ${_formatDateTime(_startDateTime)}',
                          ),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          onPressed: () =>
                              _pickDateTime(field: 'expiry'),
                          icon: const Icon(Icons.timer_outlined),
                          label: Text(
                            _expiryDateTime == null
                                ? 'Select Expiry Date & Time'
                                : 'Expiry: ${_formatDateTime(_expiryDateTime)}',
                          ),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          onPressed: () =>
                              _pickDateTime(field: 'issue'),
                          icon: const Icon(Icons.verified_outlined),
                          label: Text(
                            _issueDateTime == null
                                ? 'Select Issue Date & Time'
                                : 'Issue: ${_formatDateTime(_issueDateTime)}',
                          ),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          onPressed: () =>
                              _pickDateTime(field: 'closure'),
                          icon: const Icon(Icons.task_alt),
                          label: Text(
                            _closureDateTime == null
                                ? 'Select Closure Date & Time'
                                : 'Closure: ${_formatDateTime(_closureDateTime)}',
                          ),
                        ),
                        const SizedBox(height: 10),
                        _section('Source & Status'),
                        _dropdown(
                          'Source',
                          _source,
                          widget.sources,
                          (v) => setState(() => _source = v!),
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _sourceReference,
                          'Reference ID',
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          'Status',
                          _status,
                          widget.statuses,
                          (v) => setState(() => _status = v!),
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _closureNote,
                          'Closure Note',
                          maxLines: 3,
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
                        widget.existing == null
                            ? 'Save Permit'
                            : 'Update Permit',
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
          ? (value) => value == null || value.trim().isEmpty
              ? 'Required'
              : null
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

class _PtwDetailsSheet extends StatelessWidget {
  const _PtwDetailsSheet({
    required this.permit,
    required this.onEdit,
    required this.onDelete,
    required this.onHistory,
    required this.onAuthorize,
    required this.onIssue,
    required this.onSuspend,
    required this.onVerify,
    required this.onGasSafe,
    required this.onGasUnsafe,
    required this.onClose,
    required this.onSourceOpen,
  });

  final Map<String, dynamic> permit;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onHistory;
  final VoidCallback onAuthorize;
  final VoidCallback onIssue;
  final VoidCallback onSuspend;
  final VoidCallback onVerify;
  final VoidCallback onGasSafe;
  final VoidCallback onGasUnsafe;
  final VoidCallback onClose;
  final VoidCallback? onSourceOpen;

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color(0xFF0B5D4B);
    const primaryGreen = Color(0xFF159447);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .88,
          child: ListView(
            children: [
              Text(
                '${permit['title'] ?? 'Permit'}',
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: darkGreen,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${permit['id'] ?? ''} • '
                '${permit['permitType'] ?? ''}',
              ),
              const Divider(height: 24),
              _row('Classification', permit['classification']),
              _row('Project', permit['project']),
              _row('Location', permit['location']),
              _row('Activity', permit['activity']),
              _row('Scope', permit['scope']),
              _row(
                'Performing Authority',
                permit['performingAuthority'],
              ),
              _row(
                'Issuing Authority',
                permit['issuingAuthority'],
              ),
              _row('Area Owner', permit['areaOwner']),
              _row('Hazards', permit['hazards']),
              _row('Risk Level', permit['riskLevel']),
              _row('Controls', permit['controls']),
              _row('RAMS Reference', permit['ramsReference']),
              _row('Risk Reference', permit['riskReference']),
              _row('Isolation Status', permit['isolationStatus']),
              _row('Isolation Details', permit['isolationDetails']),
              _row('Gas Test Status', permit['gasTestStatus']),
              _row('Gas Test Details', permit['gasTestDetails']),
              _row('PPE', permit['ppe']),
              _row('Equipment', permit['equipment']),
              _row('Precautions', permit['precautions']),
              _row('Emergency Plan', permit['emergencyPlan']),
              _row('Priority', permit['priority']),
              _row('Verification', permit['verificationStatus']),
              _row(
                'Start',
                _formatDateTime(permit['startDateTime']),
              ),
              _row(
                'Expiry',
                _formatDateTime(permit['expiryDateTime']),
              ),
              _row(
                'Issue',
                _formatDateTime(permit['issueDateTime']),
              ),
              _row(
                'Closure',
                _formatDateTime(permit['closureDateTime']),
              ),
              _row('Authorization Note', permit['authorizationNote']),
              _row('Verification Note', permit['verificationNote']),
              _row('Source', permit['source']),
              _row('Reference ID', permit['referenceId']),
              _row('Status', permit['status']),
              _row('Closure Note', permit['closureNote']),
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
                    onPressed: onAuthorize,
                    icon: const Icon(Icons.approval),
                    label: const Text('Authorize'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onIssue,
                    icon: const Icon(Icons.verified),
                    label: const Text('Issue'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onSuspend,
                    icon: const Icon(Icons.pause_circle),
                    label: const Text('Suspend'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onVerify,
                    icon: const Icon(Icons.fact_check),
                    label: const Text('Verify'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onGasSafe,
                    icon: const Icon(Icons.air),
                    label: const Text('Gas Safe'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onGasUnsafe,
                    icon: const Icon(Icons.warning_amber),
                    label: const Text('Gas Unsafe'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onClose,
                    icon: const Icon(Icons.task_alt),
                    label: const Text('Close'),
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
    final text = value == null ||
            '$value' == 'null' ||
            '$value'.isEmpty
        ? '-'
        : '$value';

    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black87,
            height: 1.3,
          ),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(text: text),
          ],
        ),
      ),
    );
  }
}

String _formatDate(dynamic value) {
  if (value == null || '$value' == 'null' || '$value'.isEmpty) {
    return '-';
  }

  final date = DateTime.tryParse('$value');
  if (date == null) return '$value';

  return '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.year}';
}

String _formatDateTime(dynamic value) {
  if (value == null || '$value' == 'null' || '$value'.isEmpty) {
    return '-';
  }

  final date = DateTime.tryParse('$value');
  if (date == null) return '$value';

  return '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.year} '
      '${date.hour.toString().padLeft(2, '0')}:'
      '${date.minute.toString().padLeft(2, '0')}';
}
