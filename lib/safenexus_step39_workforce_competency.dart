import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ===============================================================
/// SafeNexus HSE
/// STEP 39 — WORKFORCE & COMPETENCY MANAGEMENT CENTER
///
/// 39A  Workforce Master
/// 39B  Employee / Worker Profile
/// 39C  Contractor Workforce
/// 39D  HSE Competency & Skills
/// 39E  Training & Certification
/// 39F  Medical / Fitness Validity Tracking
/// 39G  Induction & Site Orientation
/// 39H  Role / Responsibility & Authorization
/// 39I  Competency Expiry & Renewal
/// 39J  Workforce HSE Verification
/// 39K  Workforce History / Audit Trail
/// 39L  Workforce Intelligence Dashboard
///
/// Workflow:
/// Register → Verify → Induct → Train → Certify → Authorize
/// → Deploy → Monitor → Renew → Analyze
///
/// Storage:
/// SharedPreferences
///
/// Language:
/// English + Malayalam ready
///
/// Cross-module:
/// Optional sourceOpener callback
///
/// Design:
/// UAE-wide scalable HSE architecture
/// ===============================================================

class SafeNexusStep39WorkforceCompetencyPage extends StatefulWidget {
  const SafeNexusStep39WorkforceCompetencyPage({
    super.key,
    this.sourceOpener,
  });

  final void Function(String referenceType, String referenceId)? sourceOpener;

  @override
  State<SafeNexusStep39WorkforceCompetencyPage> createState() =>
      _SafeNexusStep39WorkforceCompetencyPageState();
}

class _SafeNexusStep39WorkforceCompetencyPageState
    extends State<SafeNexusStep39WorkforceCompetencyPage> {
  static const String storageKey =
      'safenexus_hse_step39_workforce_competency';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const List<String> workerTypes = [
    'Employee',
    'Contractor',
    'Subcontractor',
    'Visitor',
    'Temporary Worker',
    'Other',
  ];

  static const List<String> employmentStatuses = [
    'Active',
    'Inactive',
    'On Leave',
    'Suspended',
    'Demobilized',
  ];

  static const List<String> roles = [
    'HSE Officer',
    'HSE Engineer',
    'HSE Manager',
    'Supervisor',
    'Foreman',
    'Permit Holder',
    'Authorized Person',
    'Worker',
    'Operator',
    'Banksman / Signalman',
    'Rigger',
    'Electrician',
    'Welder',
    'Scaffolder',
    'Confined Space Attendant',
    'Confined Space Entrant',
    'First Aider',
    'Fire Watcher',
    'Lifting Supervisor',
    'Other',
  ];

  static const List<String> competencyStatuses = [
    'Not Assessed',
    'Competent',
    'Conditionally Competent',
    'Not Yet Competent',
    'Expired',
  ];

  static const List<String> trainingStatuses = [
    'Not Started',
    'Scheduled',
    'In Progress',
    'Completed',
    'Expired',
  ];

  static const List<String> inductionStatuses = [
    'Not Completed',
    'Scheduled',
    'Completed',
    'Expired',
  ];

  static const List<String> fitnessStatuses = [
    'Not Available',
    'Valid',
    'Expiring Soon',
    'Expired',
    'Restricted',
  ];

  static const List<String> authorizationStatuses = [
    'Not Authorized',
    'Pending',
    'Authorized',
    'Suspended',
    'Expired',
  ];

  static const List<String> verificationStatuses = [
    'Not Verified',
    'Verified',
    'Needs Follow-up',
    'Failed',
  ];

  static const List<String> priorities = [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static const List<String> sources = [
    'Step 9 Daily HSE',
    'Step 31 Smart Checklists',
    'Step 32 Field Operations',
    'Step 35 Action Center',
    'Step 36 Risk & Control Center',
    'Step 37 RAMS Center',
    'Step 38 PTW Center',
    'Incident',
    'Other',
  ];

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _workers = [];
  bool _loading = true;

  String _workerTypeFilter = 'All';
  String _statusFilter = 'All';
  String _roleFilter = 'All';
  String _competencyFilter = 'All';
  String _expiryFilter = 'All';
  String _verificationFilter = 'All';

  @override
  void initState() {
    super.initState();
    _loadWorkers();
    _searchController.addListener(_refresh);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refresh)
      ..dispose();
    super.dispose();
  }

  Future<void> _loadWorkers() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);

    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          _workers = decoded
              .whereType<Map>()
              .map((item) => Map<String, dynamic>.from(item))
              .toList();
        }
      } catch (_) {
        _workers = [];
      }
    }

    if (mounted) {
      setState(() => _loading = false);
    }
  }

  Future<void> _saveWorkers() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(_workers));
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  DateTime? _date(dynamic value) {
    if (value == null || '$value' == 'null' || '$value'.isEmpty) {
      return null;
    }
    return DateTime.tryParse('$value');
  }

  bool _isDateExpired(dynamic value) {
    final date = _date(value);
    return date != null && date.isBefore(DateTime.now());
  }

  bool _isExpiringSoon(dynamic value) {
    final date = _date(value);
    if (date == null) return false;

    final now = DateTime.now();
    final limit = now.add(const Duration(days: 30));
    return !date.isBefore(now) && date.isBefore(limit);
  }

  bool _hasAnyExpiryProblem(Map<String, dynamic> worker) {
    final dates = [
      worker['competencyExpiry'],
      worker['trainingExpiry'],
      worker['medicalExpiry'],
      worker['inductionExpiry'],
      worker['authorizationExpiry'],
    ];

    return dates.any(_isDateExpired) || dates.any(_isExpiringSoon);
  }

  List<Map<String, dynamic>> get _filteredWorkers {
    final query = _searchController.text.trim().toLowerCase();

    return _workers.where((worker) {
      final searchable = [
        worker['id'],
        worker['name'],
        worker['employeeNumber'],
        worker['company'],
        worker['workerType'],
        worker['role'],
        worker['trade'],
        worker['project'],
        worker['site'],
        worker['nationality'],
        worker['phone'],
        worker['email'],
        worker['competency'],
        worker['status'],
        worker['source'],
        worker['referenceId'],
      ].map((v) => '$v').join(' ').toLowerCase();

      final searchOk = query.isEmpty || searchable.contains(query);

      final workerTypeOk = _workerTypeFilter == 'All' ||
          '${worker['workerType']}' == _workerTypeFilter;

      final statusOk =
          _statusFilter == 'All' || '${worker['status']}' == _statusFilter;

      final roleOk =
          _roleFilter == 'All' || '${worker['role']}' == _roleFilter;

      final competencyOk = _competencyFilter == 'All' ||
          '${worker['competency']}' == _competencyFilter;

      final expiryProblem = _hasAnyExpiryProblem(worker);
      final expiryOk = _expiryFilter == 'All' ||
          (_expiryFilter == 'Attention Required' && expiryProblem) ||
          (_expiryFilter == 'Valid / No Attention' && !expiryProblem);

      final verificationOk = _verificationFilter == 'All' ||
          '${worker['verification']}' == _verificationFilter;

      return searchOk &&
          workerTypeOk &&
          statusOk &&
          roleOk &&
          competencyOk &&
          expiryOk &&
          verificationOk;
    }).toList();
  }

  int _count(bool Function(Map<String, dynamic>) test) =>
      _workers.where(test).length;

  int get _activeCount =>
      _count((w) => '${w['status']}' == 'Active');

  int get _contractorCount =>
      _count((w) => '${w['workerType']}' == 'Contractor');

  int get _competentCount =>
      _count((w) => '${w['competency']}' == 'Competent');

  int get _trainingCompletedCount =>
      _count((w) => '${w['trainingStatus']}' == 'Completed');

  int get _inductionCompletedCount =>
      _count((w) => '${w['inductionStatus']}' == 'Completed');

  int get _fitnessExpiredCount =>
      _count((w) => '${w['fitnessStatus']}' == 'Expired');

  int get _authorizationExpiredCount =>
      _count((w) => '${w['authorizationStatus']}' == 'Expired');

  int get _expiryAttentionCount => _count(_hasAnyExpiryProblem);

  int get _verificationPendingCount =>
      _count((w) => '${w['verification']}' != 'Verified');

  int get _criticalCount =>
      _count((w) => '${w['priority']}' == 'Critical');

  int get _authorizedCount =>
      _count((w) => '${w['authorizationStatus']}' == 'Authorized');

  Future<void> _openForm({Map<String, dynamic>? existing}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _WorkforceFormSheet(
        existing: existing,
        workerTypes: workerTypes,
        employmentStatuses: employmentStatuses,
        roles: roles,
        competencyStatuses: competencyStatuses,
        trainingStatuses: trainingStatuses,
        inductionStatuses: inductionStatuses,
        fitnessStatuses: fitnessStatuses,
        authorizationStatuses: authorizationStatuses,
        verificationStatuses: verificationStatuses,
        priorities: priorities,
        sources: sources,
      ),
    );

    if (result == null) return;

    final now = DateTime.now().toIso8601String();

    if (existing == null) {
      final id = 'WF-${DateTime.now().millisecondsSinceEpoch}';

      result['id'] = id;
      result['createdAt'] = now;
      result['updatedAt'] = now;
      result['history'] = [
        {
          'at': now,
          'event': 'Worker registered',
          'note': 'New workforce record created.',
        },
      ];

      _workers.insert(0, result);
    } else {
      final index = _workers.indexWhere((w) => w['id'] == existing['id']);

      if (index >= 0) {
        final history = _historyFrom(existing['history']);
        history.add({
          'at': now,
          'event': 'Worker record updated',
          'note': 'Workforce record updated.',
        });

        result['id'] = existing['id'];
        result['createdAt'] = existing['createdAt'] ?? now;
        result['updatedAt'] = now;
        result['history'] = history;

        _workers[index] = result;
      }
    }

    await _saveWorkers();

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

  Future<void> _deleteWorker(Map<String, dynamic> worker) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Workforce Record?'),
        content: Text(
          'Permanently remove ${worker['name'] ?? 'this worker'} '
          'from local workforce storage?',
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

    _workers.removeWhere((w) => w['id'] == worker['id']);
    await _saveWorkers();

    if (mounted) setState(() {});
  }

  Future<void> _updateWorker(
    Map<String, dynamic> worker, {
    String? status,
    String? competency,
    String? trainingStatus,
    String? inductionStatus,
    String? fitnessStatus,
    String? authorizationStatus,
    String? verification,
  }) async {
    final index = _workers.indexWhere((w) => w['id'] == worker['id']);
    if (index < 0) return;

    final updated = Map<String, dynamic>.from(_workers[index]);
    final now = DateTime.now().toIso8601String();

    String? event;
    String? note;

    if (status != null) {
      updated['status'] = status;
      event = 'Employment status updated';
      note = 'Worker status changed to $status.';
    }

    if (competency != null) {
      updated['competency'] = competency;
      event = 'Competency updated';
      note = 'Competency status changed to $competency.';
    }

    if (trainingStatus != null) {
      updated['trainingStatus'] = trainingStatus;
      event = 'Training status updated';
      note = 'Training status changed to $trainingStatus.';
    }

    if (inductionStatus != null) {
      updated['inductionStatus'] = inductionStatus;
      event = 'Induction status updated';
      note = 'Induction status changed to $inductionStatus.';
    }

    if (fitnessStatus != null) {
      updated['fitnessStatus'] = fitnessStatus;
      event = 'Fitness status updated';
      note = 'Medical / fitness status changed to $fitnessStatus.';
    }

    if (authorizationStatus != null) {
      updated['authorizationStatus'] = authorizationStatus;
      event = 'Authorization updated';
      note = 'Authorization changed to $authorizationStatus.';
    }

    if (verification != null) {
      updated['verification'] = verification;
      event = 'Verification updated';
      note = 'HSE verification changed to $verification.';
    }

    if (event != null) {
      final history = _historyFrom(updated['history']);
      history.add({
        'at': now,
        'event': event,
        'note': note,
      });
      updated['history'] = history;
    }

    updated['updatedAt'] = now;
    _workers[index] = updated;

    await _saveWorkers();

    if (mounted) setState(() {});
  }

  void _showHistory(Map<String, dynamic> worker) {
    final history = _historyFrom(worker['history']);

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
                  'Workforce History — ${worker['name'] ?? worker['id']}',
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: history.isEmpty
                      ? const Center(
                          child: Text('No history available.'),
                        )
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

  void _showDetails(Map<String, dynamic> worker) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _WorkforceDetailsSheet(
        worker: worker,
        onEdit: () {
          Navigator.pop(context);
          _openForm(existing: worker);
        },
        onDelete: () {
          Navigator.pop(context);
          _deleteWorker(worker);
        },
        onHistory: () {
          Navigator.pop(context);
          _showHistory(worker);
        },
        onVerify: () {
          Navigator.pop(context);
          _updateWorker(
            worker,
            verification: 'Verified',
          );
        },
        onCompetent: () {
          Navigator.pop(context);
          _updateWorker(
            worker,
            competency: 'Competent',
          );
        },
        onTrainingComplete: () {
          Navigator.pop(context);
          _updateWorker(
            worker,
            trainingStatus: 'Completed',
          );
        },
        onInductionComplete: () {
          Navigator.pop(context);
          _updateWorker(
            worker,
            inductionStatus: 'Completed',
          );
        },
        onFitnessValid: () {
          Navigator.pop(context);
          _updateWorker(
            worker,
            fitnessStatus: 'Valid',
          );
        },
        onAuthorize: () {
          Navigator.pop(context);
          _updateWorker(
            worker,
            authorizationStatus: 'Authorized',
          );
        },
        onSuspend: () {
          Navigator.pop(context);
          _updateWorker(
            worker,
            status: 'Suspended',
            authorizationStatus: 'Suspended',
          );
        },
        onSourceOpen: widget.sourceOpener == null
            ? null
            : () {
                Navigator.pop(context);
                widget.sourceOpener!(
                  '${worker['source'] ?? ''}',
                  '${worker['referenceId'] ?? ''}',
                );
              },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredWorkers;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text(
          'Workforce & Competency',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Reset filters',
            onPressed: () {
              setState(() {
                _workerTypeFilter = 'All';
                _statusFilter = 'All';
                _roleFilter = 'All';
                _competencyFilter = 'All';
                _expiryFilter = 'All';
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
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Add Workforce'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadWorkers,
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
                    ...filtered.map(_buildWorkerCard),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
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
              Icons.groups_2_outlined,
              color: Colors.white,
              size: 34,
            ),
            SizedBox(height: 8),
            Text(
              'Workforce & Competency Management Center',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Register → Verify → Train → Certify → Authorize → Deploy',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 4),
            Text(
              'Competency, training, fitness & authorization • UAE-wide 🇦🇪',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboard() {
    final items = <Map<String, dynamic>>[
      {
        'label': 'Total',
        'value': _workers.length,
        'icon': Icons.groups,
      },
      {
        'label': 'Active',
        'value': _activeCount,
        'icon': Icons.person,
      },
      {
        'label': 'Contractors',
        'value': _contractorCount,
        'icon': Icons.engineering,
      },
      {
        'label': 'Competent',
        'value': _competentCount,
        'icon': Icons.verified_user,
      },
      {
        'label': 'Training Done',
        'value': _trainingCompletedCount,
        'icon': Icons.school,
      },
      {
        'label': 'Inducted',
        'value': _inductionCompletedCount,
        'icon': Icons.assignment_turned_in,
      },
      {
        'label': 'Fitness Expired',
        'value': _fitnessExpiredCount,
        'icon': Icons.health_and_safety,
      },
      {
        'label': 'Auth Expired',
        'value': _authorizationExpiredCount,
        'icon': Icons.lock_clock,
      },
      {
        'label': 'Expiry Attention',
        'value': _expiryAttentionCount,
        'icon': Icons.event_busy,
      },
      {
        'label': 'Verification Pending',
        'value': _verificationPendingCount,
        'icon': Icons.fact_check,
      },
      {
        'label': 'Critical',
        'value': _criticalCount,
        'icon': Icons.warning_amber,
      },
      {
        'label': 'Authorized',
        'value': _authorizedCount,
        'icon': Icons.verified,
      },
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
                labelText:
                    'Search name, ID, company, role, project...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            _filterDropdown(
              'Worker Type',
              _workerTypeFilter,
              ['All', ...workerTypes],
              (v) => setState(
                () => _workerTypeFilter = v ?? 'All',
              ),
            ),
            const SizedBox(height: 10),
            _filterDropdown(
              'Employment Status',
              _statusFilter,
              ['All', ...employmentStatuses],
              (v) => setState(
                () => _statusFilter = v ?? 'All',
              ),
            ),
            const SizedBox(height: 10),
            _filterDropdown(
              'Role',
              _roleFilter,
              ['All', ...roles],
              (v) => setState(
                () => _roleFilter = v ?? 'All',
              ),
            ),
            const SizedBox(height: 10),
            _filterDropdown(
              'Competency',
              _competencyFilter,
              ['All', ...competencyStatuses],
              (v) => setState(
                () => _competencyFilter = v ?? 'All',
              ),
            ),
            const SizedBox(height: 10),
            _filterDropdown(
              'Expiry',
              _expiryFilter,
              const [
                'All',
                'Attention Required',
                'Valid / No Attention',
              ],
              (v) => setState(
                () => _expiryFilter = v ?? 'All',
              ),
            ),
            const SizedBox(height: 10),
            _filterDropdown(
              'Verification',
              _verificationFilter,
              ['All', ...verificationStatuses],
              (v) => setState(
                () => _verificationFilter = v ?? 'All',
              ),
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
              Icons.groups_outlined,
              size: 52,
              color: Colors.grey.shade500,
            ),
            const SizedBox(height: 12),
            const Text(
              'No workforce records found.',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Add an employee, contractor or other workforce record.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkerCard(Map<String, dynamic> worker) {
    final attention = _hasAnyExpiryProblem(worker);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showDetails(worker),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: pageBackground,
                    child: const Icon(
                      Icons.person_outline,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '${worker['name'] ?? 'Unnamed Worker'}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: darkGreen,
                      ),
                    ),
                  ),
                  _chip('${worker['priority'] ?? 'Medium'}'),
                ],
              ),
              const SizedBox(height: 7),
              Text(
                '${worker['id'] ?? ''} • '
                '${worker['workerType'] ?? ''} • '
                '${worker['status'] ?? ''}',
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 7),
              Text('Company: ${worker['company'] ?? '-'}'),
              Text('Role: ${worker['role'] ?? '-'}'),
              Text('Trade / Skill: ${worker['trade'] ?? '-'}'),
              Text('Project: ${worker['project'] ?? '-'}'),
              Text('Site: ${worker['site'] ?? '-'}'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _smallChip(
                    'Competency: ${worker['competency'] ?? '-'}',
                  ),
                  _smallChip(
                    'Training: ${worker['trainingStatus'] ?? '-'}',
                  ),
                  _smallChip(
                    'Induction: ${worker['inductionStatus'] ?? '-'}',
                  ),
                  _smallChip(
                    'Fitness: ${worker['fitnessStatus'] ?? '-'}',
                  ),
                  _smallChip(
                    'Authorization: '
                    '${worker['authorizationStatus'] ?? '-'}',
                  ),
                  _smallChip(
                    attention
                        ? 'Expiry Attention'
                        : 'Expiry OK',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () => _showDetails(worker),
                    icon: const Icon(
                      Icons.open_in_new,
                      size: 18,
                    ),
                    label: const Text('Details'),
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          _openForm(existing: worker);
                          break;
                        case 'verify':
                          _updateWorker(
                            worker,
                            verification: 'Verified',
                          );
                          break;
                        case 'competent':
                          _updateWorker(
                            worker,
                            competency: 'Competent',
                          );
                          break;
                        case 'training':
                          _updateWorker(
                            worker,
                            trainingStatus: 'Completed',
                          );
                          break;
                        case 'induction':
                          _updateWorker(
                            worker,
                            inductionStatus: 'Completed',
                          );
                          break;
                        case 'fitness':
                          _updateWorker(
                            worker,
                            fitnessStatus: 'Valid',
                          );
                          break;
                        case 'authorize':
                          _updateWorker(
                            worker,
                            authorizationStatus: 'Authorized',
                          );
                          break;
                        case 'suspend':
                          _updateWorker(
                            worker,
                            status: 'Suspended',
                            authorizationStatus: 'Suspended',
                          );
                          break;
                        case 'activate':
                          _updateWorker(
                            worker,
                            status: 'Active',
                          );
                          break;
                        case 'history':
                          _showHistory(worker);
                          break;
                        case 'delete':
                          _deleteWorker(worker);
                          break;
                      }
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      PopupMenuItem(
                        value: 'verify',
                        child: Text('HSE Verify'),
                      ),
                      PopupMenuItem(
                        value: 'competent',
                        child: Text('Mark Competent'),
                      ),
                      PopupMenuItem(
                        value: 'training',
                        child: Text('Training Completed'),
                      ),
                      PopupMenuItem(
                        value: 'induction',
                        child: Text('Induction Completed'),
                      ),
                      PopupMenuItem(
                        value: 'fitness',
                        child: Text('Fitness Valid'),
                      ),
                      PopupMenuItem(
                        value: 'authorize',
                        child: Text('Authorize'),
                      ),
                      PopupMenuItem(
                        value: 'activate',
                        child: Text('Set Active'),
                      ),
                      PopupMenuItem(
                        value: 'suspend',
                        child: Text('Suspend'),
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

class _WorkforceFormSheet extends StatefulWidget {
  const _WorkforceFormSheet({
    required this.existing,
    required this.workerTypes,
    required this.employmentStatuses,
    required this.roles,
    required this.competencyStatuses,
    required this.trainingStatuses,
    required this.inductionStatuses,
    required this.fitnessStatuses,
    required this.authorizationStatuses,
    required this.verificationStatuses,
    required this.priorities,
    required this.sources,
  });

  final Map<String, dynamic>? existing;
  final List<String> workerTypes;
  final List<String> employmentStatuses;
  final List<String> roles;
  final List<String> competencyStatuses;
  final List<String> trainingStatuses;
  final List<String> inductionStatuses;
  final List<String> fitnessStatuses;
  final List<String> authorizationStatuses;
  final List<String> verificationStatuses;
  final List<String> priorities;
  final List<String> sources;

  @override
  State<_WorkforceFormSheet> createState() => _WorkforceFormSheetState();
}

class _WorkforceFormSheetState extends State<_WorkforceFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _name;
  late final TextEditingController _employeeNumber;
  late final TextEditingController _company;
  late final TextEditingController _trade;
  late final TextEditingController _project;
  late final TextEditingController _site;
  late final TextEditingController _nationality;
  late final TextEditingController _phone;
  late final TextEditingController _email;
  late final TextEditingController _competencyDetails;
  late final TextEditingController _trainingDetails;
  late final TextEditingController _certificateReference;
  late final TextEditingController _medicalReference;
  late final TextEditingController _inductionDetails;
  late final TextEditingController _authorizationDetails;
  late final TextEditingController _verificationNote;
  late final TextEditingController _skills;
  late final TextEditingController _emergencyContact;
  late final TextEditingController _sourceReference;
  late final TextEditingController _notes;

  String _workerType = 'Employee';
  String _status = 'Active';
  String _role = 'Worker';
  String _competency = 'Not Assessed';
  String _trainingStatus = 'Not Started';
  String _inductionStatus = 'Not Completed';
  String _fitnessStatus = 'Not Available';
  String _authorizationStatus = 'Not Authorized';
  String _verification = 'Not Verified';
  String _priority = 'Medium';
  String _source = 'Step 9 Daily HSE';

  DateTime? _competencyExpiry;
  DateTime? _trainingExpiry;
  DateTime? _medicalExpiry;
  DateTime? _inductionExpiry;
  DateTime? _authorizationExpiry;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;

    _name = TextEditingController(text: '${e?['name'] ?? ''}');
    _employeeNumber = TextEditingController(
      text: '${e?['employeeNumber'] ?? ''}',
    );
    _company = TextEditingController(
      text: '${e?['company'] ?? ''}',
    );
    _trade = TextEditingController(
      text: '${e?['trade'] ?? ''}',
    );
    _project = TextEditingController(
      text: '${e?['project'] ?? ''}',
    );
    _site = TextEditingController(
      text: '${e?['site'] ?? ''}',
    );
    _nationality = TextEditingController(
      text: '${e?['nationality'] ?? ''}',
    );
    _phone = TextEditingController(
      text: '${e?['phone'] ?? ''}',
    );
    _email = TextEditingController(
      text: '${e?['email'] ?? ''}',
    );
    _competencyDetails = TextEditingController(
      text: '${e?['competencyDetails'] ?? ''}',
    );
    _trainingDetails = TextEditingController(
      text: '${e?['trainingDetails'] ?? ''}',
    );
    _certificateReference = TextEditingController(
      text: '${e?['certificateReference'] ?? ''}',
    );
    _medicalReference = TextEditingController(
      text: '${e?['medicalReference'] ?? ''}',
    );
    _inductionDetails = TextEditingController(
      text: '${e?['inductionDetails'] ?? ''}',
    );
    _authorizationDetails = TextEditingController(
      text: '${e?['authorizationDetails'] ?? ''}',
    );
    _verificationNote = TextEditingController(
      text: '${e?['verificationNote'] ?? ''}',
    );
    _skills = TextEditingController(
      text: '${e?['skills'] ?? ''}',
    );
    _emergencyContact = TextEditingController(
      text: '${e?['emergencyContact'] ?? ''}',
    );
    _sourceReference = TextEditingController(
      text: '${e?['referenceId'] ?? ''}',
    );
    _notes = TextEditingController(
      text: '${e?['notes'] ?? ''}',
    );

    _workerType = _safe(
      widget.workerTypes,
      '${e?['workerType']}',
      _workerType,
    );
    _status = _safe(
      widget.employmentStatuses,
      '${e?['status']}',
      _status,
    );
    _role = _safe(
      widget.roles,
      '${e?['role']}',
      _role,
    );
    _competency = _safe(
      widget.competencyStatuses,
      '${e?['competency']}',
      _competency,
    );
    _trainingStatus = _safe(
      widget.trainingStatuses,
      '${e?['trainingStatus']}',
      _trainingStatus,
    );
    _inductionStatus = _safe(
      widget.inductionStatuses,
      '${e?['inductionStatus']}',
      _inductionStatus,
    );
    _fitnessStatus = _safe(
      widget.fitnessStatuses,
      '${e?['fitnessStatus']}',
      _fitnessStatus,
    );
    _authorizationStatus = _safe(
      widget.authorizationStatuses,
      '${e?['authorizationStatus']}',
      _authorizationStatus,
    );
    _verification = _safe(
      widget.verificationStatuses,
      '${e?['verification']}',
      _verification,
    );
    _priority = _safe(
      widget.priorities,
      '${e?['priority']}',
      _priority,
    );
    _source = _safe(
      widget.sources,
      '${e?['source']}',
      _source,
    );

    _competencyExpiry =
        DateTime.tryParse('${e?['competencyExpiry']}');
    _trainingExpiry =
        DateTime.tryParse('${e?['trainingExpiry']}');
    _medicalExpiry =
        DateTime.tryParse('${e?['medicalExpiry']}');
    _inductionExpiry =
        DateTime.tryParse('${e?['inductionExpiry']}');
    _authorizationExpiry =
        DateTime.tryParse('${e?['authorizationExpiry']}');
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
    _name.dispose();
    _employeeNumber.dispose();
    _company.dispose();
    _trade.dispose();
    _project.dispose();
    _site.dispose();
    _nationality.dispose();
    _phone.dispose();
    _email.dispose();
    _competencyDetails.dispose();
    _trainingDetails.dispose();
    _certificateReference.dispose();
    _medicalReference.dispose();
    _inductionDetails.dispose();
    _authorizationDetails.dispose();
    _verificationNote.dispose();
    _skills.dispose();
    _emergencyContact.dispose();
    _sourceReference.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _pickDate({
    required String field,
  }) async {
    DateTime current;

    if (field == 'competency') {
      current = _competencyExpiry ??
          DateTime.now().add(const Duration(days: 365));
    } else if (field == 'training') {
      current = _trainingExpiry ??
          DateTime.now().add(const Duration(days: 365));
    } else if (field == 'medical') {
      current = _medicalExpiry ??
          DateTime.now().add(const Duration(days: 365));
    } else if (field == 'induction') {
      current = _inductionExpiry ??
          DateTime.now().add(const Duration(days: 365));
    } else {
      current = _authorizationExpiry ??
          DateTime.now().add(const Duration(days: 365));
    }

    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: current,
    );

    if (picked == null) return;

    setState(() {
      if (field == 'competency') {
        _competencyExpiry = picked;
      } else if (field == 'training') {
        _trainingExpiry = picked;
      } else if (field == 'medical') {
        _medicalExpiry = picked;
      } else if (field == 'induction') {
        _inductionExpiry = picked;
      } else {
        _authorizationExpiry = picked;
      }
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(context, {
      'name': _name.text.trim(),
      'employeeNumber': _employeeNumber.text.trim(),
      'company': _company.text.trim(),
      'workerType': _workerType,
      'status': _status,
      'role': _role,
      'trade': _trade.text.trim(),
      'project': _project.text.trim(),
      'site': _site.text.trim(),
      'nationality': _nationality.text.trim(),
      'phone': _phone.text.trim(),
      'email': _email.text.trim(),
      'skills': _skills.text.trim(),
      'competency': _competency,
      'competencyDetails': _competencyDetails.text.trim(),
      'competencyExpiry':
          _competencyExpiry?.toIso8601String(),
      'trainingStatus': _trainingStatus,
      'trainingDetails': _trainingDetails.text.trim(),
      'certificateReference': _certificateReference.text.trim(),
      'trainingExpiry': _trainingExpiry?.toIso8601String(),
      'fitnessStatus': _fitnessStatus,
      'medicalReference': _medicalReference.text.trim(),
      'medicalExpiry': _medicalExpiry?.toIso8601String(),
      'inductionStatus': _inductionStatus,
      'inductionDetails': _inductionDetails.text.trim(),
      'inductionExpiry': _inductionExpiry?.toIso8601String(),
      'authorizationStatus': _authorizationStatus,
      'authorizationDetails':
          _authorizationDetails.text.trim(),
      'authorizationExpiry':
          _authorizationExpiry?.toIso8601String(),
      'verification': _verification,
      'verificationNote': _verificationNote.text.trim(),
      'priority': _priority,
      'emergencyContact': _emergencyContact.text.trim(),
      'source': _source,
      'referenceId': _sourceReference.text.trim(),
      'notes': _notes.text.trim(),
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
                        ? 'Add Workforce Record'
                        : 'Edit Workforce Record',
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
                          _name,
                          'Full Name',
                          required: true,
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _employeeNumber,
                          'Employee / ID Number',
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          'Worker Type',
                          _workerType,
                          widget.workerTypes,
                          (v) => setState(
                            () => _workerType = v!,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          'Employment Status',
                          _status,
                          widget.employmentStatuses,
                          (v) => setState(
                            () => _status = v!,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _company,
                          'Company / Contractor',
                          required: true,
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          'Role',
                          _role,
                          widget.roles,
                          (v) => setState(
                            () => _role = v!,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _trade,
                          'Trade / Skill',
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _skills,
                          'Skills / Special Competencies',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _project,
                          'Project / Work Package',
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _site,
                          'Site / Work Location',
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _nationality,
                          'Nationality',
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _phone,
                          'Phone',
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _email,
                          'Email',
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _emergencyContact,
                          'Emergency Contact',
                        ),
                        const SizedBox(height: 10),
                        _section('Competency & Skills'),
                        _dropdown(
                          'Competency Status',
                          _competency,
                          widget.competencyStatuses,
                          (v) => setState(
                            () => _competency = v!,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _competencyDetails,
                          'Competency Assessment Details',
                          maxLines: 4,
                        ),
                        const SizedBox(height: 8),
                        _dateButton(
                          label: _competencyExpiry == null
                              ? 'Select Competency Expiry'
                              : 'Competency Expiry: '
                                '${_formatDate(_competencyExpiry)}',
                          onPressed: () =>
                              _pickDate(field: 'competency'),
                        ),
                        const SizedBox(height: 10),
                        _section('Training & Certification'),
                        _dropdown(
                          'Training Status',
                          _trainingStatus,
                          widget.trainingStatuses,
                          (v) => setState(
                            () => _trainingStatus = v!,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _trainingDetails,
                          'Training / Course Details',
                          maxLines: 4,
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _certificateReference,
                          'Certificate / Training Reference',
                        ),
                        const SizedBox(height: 8),
                        _dateButton(
                          label: _trainingExpiry == null
                              ? 'Select Training Expiry'
                              : 'Training Expiry: '
                                '${_formatDate(_trainingExpiry)}',
                          onPressed: () =>
                              _pickDate(field: 'training'),
                        ),
                        const SizedBox(height: 10),
                        _section('Medical / Fitness'),
                        _dropdown(
                          'Fitness Status',
                          _fitnessStatus,
                          widget.fitnessStatuses,
                          (v) => setState(
                            () => _fitnessStatus = v!,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _medicalReference,
                          'Medical / Fitness Reference',
                        ),
                        const SizedBox(height: 8),
                        _dateButton(
                          label: _medicalExpiry == null
                              ? 'Select Medical / Fitness Expiry'
                              : 'Medical Expiry: '
                                '${_formatDate(_medicalExpiry)}',
                          onPressed: () =>
                              _pickDate(field: 'medical'),
                        ),
                        const SizedBox(height: 10),
                        _section('Induction & Site Orientation'),
                        _dropdown(
                          'Induction Status',
                          _inductionStatus,
                          widget.inductionStatuses,
                          (v) => setState(
                            () => _inductionStatus = v!,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _inductionDetails,
                          'Induction / Orientation Details',
                          maxLines: 4,
                        ),
                        const SizedBox(height: 8),
                        _dateButton(
                          label: _inductionExpiry == null
                              ? 'Select Induction Expiry'
                              : 'Induction Expiry: '
                                '${_formatDate(_inductionExpiry)}',
                          onPressed: () =>
                              _pickDate(field: 'induction'),
                        ),
                        const SizedBox(height: 10),
                        _section('Authorization'),
                        _dropdown(
                          'Authorization Status',
                          _authorizationStatus,
                          widget.authorizationStatuses,
                          (v) => setState(
                            () => _authorizationStatus = v!,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _authorizationDetails,
                          'Role / Permit / Work Authorization',
                          maxLines: 4,
                        ),
                        const SizedBox(height: 8),
                        _dateButton(
                          label: _authorizationExpiry == null
                              ? 'Select Authorization Expiry'
                              : 'Authorization Expiry: '
                                '${_formatDate(_authorizationExpiry)}',
                          onPressed: () =>
                              _pickDate(field: 'authorization'),
                        ),
                        const SizedBox(height: 10),
                        _section('HSE Verification'),
                        _dropdown(
                          'HSE Verification',
                          _verification,
                          widget.verificationStatuses,
                          (v) => setState(
                            () => _verification = v!,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _verificationNote,
                          'Verification Note',
                          maxLines: 4,
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          'Priority',
                          _priority,
                          widget.priorities,
                          (v) => setState(
                            () => _priority = v!,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _section('Source & Record Notes'),
                        _dropdown(
                          'Source',
                          _source,
                          widget.sources,
                          (v) => setState(
                            () => _source = v!,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _sourceReference,
                          'Reference ID',
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _notes,
                          'Additional Notes',
                          maxLines: 4,
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
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                      onPressed: _submit,
                      icon: const Icon(Icons.save),
                      label: Text(
                        widget.existing == null
                            ? 'Save Workforce'
                            : 'Update Workforce',
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

  Widget _dateButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.event),
      label: Text(label),
    );
  }
}

class _WorkforceDetailsSheet extends StatelessWidget {
  const _WorkforceDetailsSheet({
    required this.worker,
    required this.onEdit,
    required this.onDelete,
    required this.onHistory,
    required this.onVerify,
    required this.onCompetent,
    required this.onTrainingComplete,
    required this.onInductionComplete,
    required this.onFitnessValid,
    required this.onAuthorize,
    required this.onSuspend,
    required this.onSourceOpen,
  });

  final Map<String, dynamic> worker;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onHistory;
  final VoidCallback onVerify;
  final VoidCallback onCompetent;
  final VoidCallback onTrainingComplete;
  final VoidCallback onInductionComplete;
  final VoidCallback onFitnessValid;
  final VoidCallback onAuthorize;
  final VoidCallback onSuspend;
  final VoidCallback? onSourceOpen;

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color(0xFF0B5D4B);
    const primaryGreen = Color(0xFF159447);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .90,
          child: ListView(
            children: [
              Text(
                '${worker['name'] ?? 'Worker'}',
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: darkGreen,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${worker['id'] ?? ''} • '
                '${worker['workerType'] ?? ''} • '
                '${worker['role'] ?? ''}',
              ),
              const Divider(height: 24),
              _row('Employee / ID', worker['employeeNumber']),
              _row('Company', worker['company']),
              _row('Status', worker['status']),
              _row('Trade / Skill', worker['trade']),
              _row('Project', worker['project']),
              _row('Site', worker['site']),
              _row('Nationality', worker['nationality']),
              _row('Phone', worker['phone']),
              _row('Email', worker['email']),
              _row('Emergency Contact', worker['emergencyContact']),
              _row('Skills', worker['skills']),
              _row('Competency', worker['competency']),
              _row(
                'Competency Details',
                worker['competencyDetails'],
              ),
              _row(
                'Competency Expiry',
                _formatDate(worker['competencyExpiry']),
              ),
              _row('Training', worker['trainingStatus']),
              _row(
                'Training Details',
                worker['trainingDetails'],
              ),
              _row(
                'Certificate Reference',
                worker['certificateReference'],
              ),
              _row(
                'Training Expiry',
                _formatDate(worker['trainingExpiry']),
              ),
              _row('Fitness', worker['fitnessStatus']),
              _row(
                'Medical Reference',
                worker['medicalReference'],
              ),
              _row(
                'Medical Expiry',
                _formatDate(worker['medicalExpiry']),
              ),
              _row('Induction', worker['inductionStatus']),
              _row(
                'Induction Details',
                worker['inductionDetails'],
              ),
              _row(
                'Induction Expiry',
                _formatDate(worker['inductionExpiry']),
              ),
              _row(
                'Authorization',
                worker['authorizationStatus'],
              ),
              _row(
                'Authorization Details',
                worker['authorizationDetails'],
              ),
              _row(
                'Authorization Expiry',
                _formatDate(worker['authorizationExpiry']),
              ),
              _row('HSE Verification', worker['verification']),
              _row(
                'Verification Note',
                worker['verificationNote'],
              ),
              _row('Priority', worker['priority']),
              _row('Source', worker['source']),
              _row('Reference ID', worker['referenceId']),
              _row('Notes', worker['notes']),
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
                    onPressed: onVerify,
                    icon: const Icon(Icons.fact_check),
                    label: const Text('Verify'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onCompetent,
                    icon: const Icon(Icons.verified_user),
                    label: const Text('Competent'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onTrainingComplete,
                    icon: const Icon(Icons.school),
                    label: const Text('Training Done'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onInductionComplete,
                    icon: const Icon(Icons.assignment_turned_in),
                    label: const Text('Induction Done'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onFitnessValid,
                    icon: const Icon(Icons.health_and_safety),
                    label: const Text('Fitness Valid'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onAuthorize,
                    icon: const Icon(Icons.verified),
                    label: const Text('Authorize'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onSuspend,
                    icon: const Icon(Icons.pause_circle),
                    label: const Text('Suspend'),
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
