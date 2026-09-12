import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ===============================================================
/// SafeNexus HSE
/// STEP 36 — HSE RISK & CONTROL MANAGEMENT CENTER
///
/// 36A  Risk Master
/// 36B  Hazard Identification
/// 36C  Risk Assessment
/// 36D  Risk Matrix
/// 36E  Existing Controls
/// 36F  Additional Controls
/// 36G  Risk Owner / Responsibility
/// 36H  Residual Risk
/// 36I  Control Verification
/// 36J  Risk Review & Escalation
/// 36K  Risk History / Audit Trail
/// 36L  Risk Intelligence Dashboard
///
/// Workflow:
/// Hazard → Assess → Control → Residual Risk → Verify
/// → Review → Close → Analyze
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

class SafeNexusStep36RiskControlCenterPage extends StatefulWidget {
  const SafeNexusStep36RiskControlCenterPage({
    super.key,
    this.sourceOpener,
  });

  final void Function(String referenceType, String referenceId)? sourceOpener;

  @override
  State<SafeNexusStep36RiskControlCenterPage> createState() =>
      _SafeNexusStep36RiskControlCenterPageState();
}

class _SafeNexusStep36RiskControlCenterPageState
    extends State<SafeNexusStep36RiskControlCenterPage> {
  static const String storageKey = 'safenexus_hse_step36_risk_control_center';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const List<String> riskTypes = [
    'General HSE Risk',
    'Task Risk',
    'Activity Risk',
    'Environmental Risk',
    'Occupational Health Risk',
    'Fire & Life Safety Risk',
    'Emergency Risk',
    'Equipment / Machinery Risk',
    'Chemical Risk',
    'Work at Height Risk',
    'Confined Space Risk',
    'Electrical Risk',
    'Lifting Risk',
    'Traffic / Vehicle Risk',
    'Other',
  ];

  static const List<String> sources = [
    'Step 9 Daily HSE',
    'Step 31 Smart Checklist',
    'Step 32 Field Operations',
    'Step 33 Communication',
    'Step 34 Documents & Records',
    'Step 35 Action Center',
    'RAMS',
    'PTW',
    'Incident',
    'Workforce / Competency',
    'Equipment',
    'Other',
  ];

  static const List<String> likelihoods = [
    '1 - Rare',
    '2 - Unlikely',
    '3 - Possible',
    '4 - Likely',
    '5 - Almost Certain',
  ];

  static const List<String> consequences = [
    '1 - Insignificant',
    '2 - Minor',
    '3 - Moderate',
    '4 - Major',
    '5 - Severe',
  ];

  static const List<String> statuses = [
    'Open',
    'Under Assessment',
    'Controls Planned',
    'Under Review',
    'Closed',
    'Escalated',
  ];

  static const List<String> controlStatuses = [
    'Not Verified',
    'Verified',
    'Partially Verified',
    'Failed',
  ];

  static const List<String> hierarchies = [
    'Elimination',
    'Substitution',
    'Engineering Control',
    'Administrative Control',
    'PPE',
  ];

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _risks = [];
  bool _loading = true;

  String _statusFilter = 'All';
  String _riskFilter = 'All';
  String _sourceFilter = 'All';
  String _overdueFilter = 'All';

  @override
  void initState() {
    super.initState();
    _loadRisks();
    _searchController.addListener(_refresh);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refresh)
      ..dispose();
    super.dispose();
  }

  Future<void> _loadRisks() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);

    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          _risks = decoded
              .whereType<Map>()
              .map((item) => Map<String, dynamic>.from(item))
              .toList();
        }
      } catch (_) {
        _risks = [];
      }
    }

    if (mounted) {
      setState(() => _loading = false);
    }
  }

  Future<void> _saveRisks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(_risks));
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  int _score(String likelihood, String consequence) {
    final l = int.tryParse(likelihood.split(' ').first) ?? 1;
    final c = int.tryParse(consequence.split(' ').first) ?? 1;
    return l * c;
  }

  String _level(int score) {
    if (score >= 20) return 'Critical';
    if (score >= 12) return 'High';
    if (score >= 5) return 'Medium';
    return 'Low';
  }

  bool _isOverdue(Map<String, dynamic> risk) {
    final status = '${risk['status']}';
    if (status == 'Closed') return false;

    final due = DateTime.tryParse('${risk['reviewDate']}');
    if (due == null) return false;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDay = DateTime(due.year, due.month, due.day);
    return dueDay.isBefore(today);
  }

  List<Map<String, dynamic>> get _filteredRisks {
    final query = _searchController.text.trim().toLowerCase();

    return _risks.where((risk) {
      final searchable = [
        risk['id'],
        risk['title'],
        risk['hazard'],
        risk['location'],
        risk['activity'],
        risk['owner'],
        risk['source'],
        risk['referenceId'],
        risk['initialLevel'],
        risk['residualLevel'],
      ].map((v) => '$v').join(' ').toLowerCase();

      final searchOk = query.isEmpty || searchable.contains(query);
      final statusOk =
          _statusFilter == 'All' || '${risk['status']}' == _statusFilter;
      final riskOk =
          _riskFilter == 'All' || '${risk['initialLevel']}' == _riskFilter;
      final sourceOk =
          _sourceFilter == 'All' || '${risk['source']}' == _sourceFilter;

      final overdue = _isOverdue(risk);
      final overdueOk = _overdueFilter == 'All' ||
          (_overdueFilter == 'Overdue' && overdue) ||
          (_overdueFilter == 'Not Overdue' && !overdue);

      return searchOk && statusOk && riskOk && sourceOk && overdueOk;
    }).toList();
  }

  int _count(bool Function(Map<String, dynamic>) test) =>
      _risks.where(test).length;

  int get _openCount =>
      _count((r) => '${r['status']}' != 'Closed');

  int get _criticalCount =>
      _count((r) => '${r['initialLevel']}' == 'Critical');

  int get _highCount =>
      _count((r) => '${r['initialLevel']}' == 'High');

  int get _overdueCount => _count(_isOverdue);

  int get _unverifiedCount =>
      _count((r) => '${r['controlStatus']}' != 'Verified');

  int get _closedCount =>
      _count((r) => '${r['status']}' == 'Closed');

  int get _residualHighCount => _count(
        (r) =>
            '${r['residualLevel']}' == 'High' ||
            '${r['residualLevel']}' == 'Critical',
      );

  Future<void> _openForm({Map<String, dynamic>? existing}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _RiskFormSheet(
        existing: existing,
        riskTypes: riskTypes,
        sources: sources,
        likelihoods: likelihoods,
        consequences: consequences,
        statuses: statuses,
        controlStatuses: controlStatuses,
        hierarchies: hierarchies,
      ),
    );

    if (result == null) return;

    final now = DateTime.now().toIso8601String();
    final likelihood = '${result['likelihood']}';
    final consequence = '${result['consequence']}';
    final residualLikelihood = '${result['residualLikelihood']}';
    final residualConsequence = '${result['residualConsequence']}';

    result['initialScore'] = _score(likelihood, consequence);
    result['initialLevel'] = _level(result['initialScore'] as int);
    result['residualScore'] =
        _score(residualLikelihood, residualConsequence);
    result['residualLevel'] = _level(result['residualScore'] as int);

    if (existing == null) {
      result['id'] = 'RISK-${DateTime.now().millisecondsSinceEpoch}';
      result['createdAt'] = now;
      result['updatedAt'] = now;
      result['history'] = [
        {
          'at': now,
          'event': 'Risk created',
          'note': 'New risk registered in Risk & Control Center.',
        },
      ];
      _risks.insert(0, result);
    } else {
      final index = _risks.indexWhere((r) => r['id'] == existing['id']);
      if (index >= 0) {
        final history = <Map<String, dynamic>>[];
        final oldHistory = existing['history'];
        if (oldHistory is List) {
          for (final item in oldHistory) {
            if (item is Map) {
              history.add(Map<String, dynamic>.from(item));
            }
          }
        }
        history.add({
          'at': now,
          'event': 'Risk updated',
          'note': 'Risk assessment and control record updated.',
        });

        result['id'] = existing['id'];
        result['createdAt'] = existing['createdAt'] ?? now;
        result['updatedAt'] = now;
        result['history'] = history;
        _risks[index] = result;
      }
    }

    await _saveRisks();
    if (mounted) setState(() {});
  }

  Future<void> _deleteRisk(Map<String, dynamic> risk) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Risk?'),
        content: Text(
          'Permanently remove ${risk['id'] ?? 'this risk'} from local storage?',
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

    _risks.removeWhere((r) => r['id'] == risk['id']);
    await _saveRisks();
    if (mounted) setState(() {});
  }

  Future<void> _quickStatus(Map<String, dynamic> risk, String status) async {
    final index = _risks.indexWhere((r) => r['id'] == risk['id']);
    if (index < 0) return;

    final updated = Map<String, dynamic>.from(_risks[index]);
    final now = DateTime.now().toIso8601String();

    updated['status'] = status;
    updated['updatedAt'] = now;

    final history = <Map<String, dynamic>>[];
    final oldHistory = updated['history'];
    if (oldHistory is List) {
      for (final item in oldHistory) {
        if (item is Map) {
          history.add(Map<String, dynamic>.from(item));
        }
      }
    }
    history.add({
      'at': now,
      'event': 'Status changed',
      'note': 'Risk status changed to $status.',
    });
    updated['history'] = history;

    _risks[index] = updated;
    await _saveRisks();
    if (mounted) setState(() {});
  }

  void _showHistory(Map<String, dynamic> risk) {
    final history = <Map<String, dynamic>>[];
    final raw = risk['history'];
    if (raw is List) {
      for (final item in raw) {
        if (item is Map) history.add(Map<String, dynamic>.from(item));
      }
    }

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
                  'Risk History — ${risk['id']}',
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

  void _showDetails(Map<String, dynamic> risk) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _RiskDetailsSheet(
        risk: risk,
        onEdit: () {
          Navigator.pop(context);
          _openForm(existing: risk);
        },
        onDelete: () {
          Navigator.pop(context);
          _deleteRisk(risk);
        },
        onHistory: () {
          Navigator.pop(context);
          _showHistory(risk);
        },
        onStatusChange: (status) {
          Navigator.pop(context);
          _quickStatus(risk, status);
        },
        onSourceOpen: widget.sourceOpener == null
            ? null
            : () {
                Navigator.pop(context);
                widget.sourceOpener!(
                  '${risk['source'] ?? ''}',
                  '${risk['referenceId'] ?? ''}',
                );
              },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredRisks;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text(
          'HSE Risk & Control Center',
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
                _riskFilter = 'All';
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
        icon: const Icon(Icons.add_alert),
        label: const Text('New Risk'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadRisks,
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
                    ...filtered.map(_buildRiskCard),
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
            Icon(Icons.shield_outlined, color: Colors.white, size: 34),
            SizedBox(height: 8),
            Text(
              'Risk & Control Management',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Hazard → Assess → Control → Verify → Review',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 4),
            Text(
              'UAE-wide HSE risk management center 🇦🇪',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboard() {
    final items = <Map<String, dynamic>>[
      {'label': 'Open', 'value': _openCount, 'icon': Icons.folder_open},
      {'label': 'Critical', 'value': _criticalCount, 'icon': Icons.dangerous},
      {'label': 'High', 'value': _highCount, 'icon': Icons.warning_amber},
      {'label': 'Overdue', 'value': _overdueCount, 'icon': Icons.event_busy},
      {
        'label': 'Unverified',
        'value': _unverifiedCount,
        'icon': Icons.verified_outlined
      },
      {
        'label': 'Residual High+',
        'value': _residualHighCount,
        'icon': Icons.trending_up
      },
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
                labelText: 'Search risk, hazard, activity, owner...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _statusFilter,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
              items: ['All', ...statuses]
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              onChanged: (value) =>
                  setState(() => _statusFilter = value ?? 'All'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _riskFilter,
              decoration: const InputDecoration(
                labelText: 'Initial Risk',
                border: OutlineInputBorder(),
              ),
              items: ['All', 'Low', 'Medium', 'High', 'Critical']
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              onChanged: (value) =>
                  setState(() => _riskFilter = value ?? 'All'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _sourceFilter,
              decoration: const InputDecoration(
                labelText: 'Source',
                border: OutlineInputBorder(),
              ),
              items: ['All', ...sources]
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              onChanged: (value) =>
                  setState(() => _sourceFilter = value ?? 'All'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _overdueFilter,
              decoration: const InputDecoration(
                labelText: 'Review Date',
                border: OutlineInputBorder(),
              ),
              items: const ['All', 'Overdue', 'Not Overdue']
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              onChanged: (value) =>
                  setState(() => _overdueFilter = value ?? 'All'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Icon(Icons.shield_outlined, size: 52, color: Colors.grey.shade500),
            const SizedBox(height: 12),
            const Text(
              'No risk records found.',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create a risk assessment to start the control workflow.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiskCard(Map<String, dynamic> risk) {
    final initialLevel = '${risk['initialLevel'] ?? 'Low'}';
    final residualLevel = '${risk['residualLevel'] ?? 'Low'}';
    final overdue = _isOverdue(risk);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showDetails(risk),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${risk['title'] ?? 'Untitled Risk'}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: darkGreen,
                      ),
                    ),
                  ),
                  _levelChip(initialLevel),
                ],
              ),
              const SizedBox(height: 7),
              Text(
                '${risk['id'] ?? ''} • ${risk['status'] ?? 'Open'}',
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 8),
              Text('Hazard: ${risk['hazard'] ?? '-'}'),
              Text('Location: ${risk['location'] ?? '-'}'),
              Text('Owner: ${risk['owner'] ?? '-'}'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _smallChip('Initial: $initialLevel'),
                  _smallChip('Residual: $residualLevel'),
                  _smallChip(
                    overdue ? 'Review Overdue' : 'Review ${_formatDate(risk['reviewDate'])}',
                  ),
                  _smallChip('Control: ${risk['controlStatus'] ?? 'Not Verified'}'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () => _showDetails(risk),
                    icon: const Icon(Icons.open_in_new, size: 18),
                    label: const Text('Details'),
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') _openForm(existing: risk);
                      if (value == 'history') _showHistory(risk);
                      if (value == 'delete') _deleteRisk(risk);
                      if (value == 'review') _quickStatus(risk, 'Under Review');
                      if (value == 'close') _quickStatus(risk, 'Closed');
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(value: 'edit', child: Text('Edit')),
                      PopupMenuItem(value: 'review', child: Text('Move to Review')),
                      PopupMenuItem(value: 'close', child: Text('Close')),
                      PopupMenuItem(value: 'history', child: Text('History')),
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

  Widget _levelChip(String level) {
    return Chip(
      label: Text(
        level,
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

class _RiskFormSheet extends StatefulWidget {
  const _RiskFormSheet({
    required this.existing,
    required this.riskTypes,
    required this.sources,
    required this.likelihoods,
    required this.consequences,
    required this.statuses,
    required this.controlStatuses,
    required this.hierarchies,
  });

  final Map<String, dynamic>? existing;
  final List<String> riskTypes;
  final List<String> sources;
  final List<String> likelihoods;
  final List<String> consequences;
  final List<String> statuses;
  final List<String> controlStatuses;
  final List<String> hierarchies;

  @override
  State<_RiskFormSheet> createState() => _RiskFormSheetState();
}

class _RiskFormSheetState extends State<_RiskFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _title;
  late final TextEditingController _hazard;
  late final TextEditingController _activity;
  late final TextEditingController _location;
  late final TextEditingController _owner;
  late final TextEditingController _department;
  late final TextEditingController _referenceId;
  late final TextEditingController _existingControls;
  late final TextEditingController _additionalControls;
  late final TextEditingController _reviewNote;
  late final TextEditingController _verificationNote;
  late final TextEditingController _escalationNote;

  String _type = 'General HSE Risk';
  String _source = 'Step 32 Field Operations';
  String _likelihood = '3 - Possible';
  String _consequence = '3 - Moderate';
  String _residualLikelihood = '2 - Unlikely';
  String _residualConsequence = '2 - Minor';
  String _status = 'Open';
  String _controlStatus = 'Not Verified';
  String _hierarchy = 'Administrative Control';
  DateTime? _reviewDate;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;

    _title = TextEditingController(text: '${e?['title'] ?? ''}');
    _hazard = TextEditingController(text: '${e?['hazard'] ?? ''}');
    _activity = TextEditingController(text: '${e?['activity'] ?? ''}');
    _location = TextEditingController(text: '${e?['location'] ?? ''}');
    _owner = TextEditingController(text: '${e?['owner'] ?? ''}');
    _department = TextEditingController(text: '${e?['department'] ?? ''}');
    _referenceId = TextEditingController(text: '${e?['referenceId'] ?? ''}');
    _existingControls =
        TextEditingController(text: '${e?['existingControls'] ?? ''}');
    _additionalControls =
        TextEditingController(text: '${e?['additionalControls'] ?? ''}');
    _reviewNote = TextEditingController(text: '${e?['reviewNote'] ?? ''}');
    _verificationNote =
        TextEditingController(text: '${e?['verificationNote'] ?? ''}');
    _escalationNote =
        TextEditingController(text: '${e?['escalationNote'] ?? ''}');

    _type = _safe(widget.riskTypes, '${e?['riskType']}', _type);
    _source = _safe(widget.sources, '${e?['source']}', _source);
    _likelihood =
        _safe(widget.likelihoods, '${e?['likelihood']}', _likelihood);
    _consequence =
        _safe(widget.consequences, '${e?['consequence']}', _consequence);
    _residualLikelihood = _safe(
      widget.likelihoods,
      '${e?['residualLikelihood']}',
      _residualLikelihood,
    );
    _residualConsequence = _safe(
      widget.consequences,
      '${e?['residualConsequence']}',
      _residualConsequence,
    );
    _status = _safe(widget.statuses, '${e?['status']}', _status);
    _controlStatus =
        _safe(widget.controlStatuses, '${e?['controlStatus']}', _controlStatus);
    _hierarchy = _safe(widget.hierarchies, '${e?['hierarchy']}', _hierarchy);
    _reviewDate = DateTime.tryParse('${e?['reviewDate']}');
  }

  String _safe(List<String> values, String value, String fallback) {
    return values.contains(value) ? value : fallback;
  }

  @override
  void dispose() {
    _title.dispose();
    _hazard.dispose();
    _activity.dispose();
    _location.dispose();
    _owner.dispose();
    _department.dispose();
    _referenceId.dispose();
    _existingControls.dispose();
    _additionalControls.dispose();
    _reviewNote.dispose();
    _verificationNote.dispose();
    _escalationNote.dispose();
    super.dispose();
  }

  Future<void> _pickReviewDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: _reviewDate ?? DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(() => _reviewDate = picked);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(context, {
      'title': _title.text.trim(),
      'riskType': _type,
      'hazard': _hazard.text.trim(),
      'activity': _activity.text.trim(),
      'location': _location.text.trim(),
      'owner': _owner.text.trim(),
      'department': _department.text.trim(),
      'source': _source,
      'referenceId': _referenceId.text.trim(),
      'likelihood': _likelihood,
      'consequence': _consequence,
      'existingControls': _existingControls.text.trim(),
      'additionalControls': _additionalControls.text.trim(),
      'hierarchy': _hierarchy,
      'residualLikelihood': _residualLikelihood,
      'residualConsequence': _residualConsequence,
      'controlStatus': _controlStatus,
      'reviewDate': _reviewDate?.toIso8601String(),
      'reviewNote': _reviewNote.text.trim(),
      'verificationNote': _verificationNote.text.trim(),
      'escalationNote': _escalationNote.text.trim(),
      'status': _status,
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
            height: MediaQuery.of(context).size.height * .90,
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
                    widget.existing == null ? 'Create Risk Assessment' : 'Edit Risk Assessment',
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
                        _text(_title, 'Risk / Assessment Title', required: true),
                        const SizedBox(height: 10),
                        _dropdown(
                          label: 'Risk Type',
                          value: _type,
                          items: widget.riskTypes,
                          onChanged: (v) => setState(() => _type = v!),
                        ),
                        const SizedBox(height: 10),
                        _text(_hazard, 'Hazard / Source of Harm', required: true),
                        const SizedBox(height: 10),
                        _text(_activity, 'Activity / Task'),
                        const SizedBox(height: 10),
                        _text(_location, 'Location / Area'),
                        const SizedBox(height: 10),
                        _text(_owner, 'Risk Owner / Responsible Person'),
                        const SizedBox(height: 10),
                        _text(_department, 'Department / Contractor'),
                        const SizedBox(height: 10),
                        _dropdown(
                          label: 'Source',
                          value: _source,
                          items: widget.sources,
                          onChanged: (v) => setState(() => _source = v!),
                        ),
                        const SizedBox(height: 10),
                        _text(_referenceId, 'Reference ID'),
                        const SizedBox(height: 10),
                        _section('Initial Risk Assessment'),
                        _dropdown(
                          label: 'Likelihood',
                          value: _likelihood,
                          items: widget.likelihoods,
                          onChanged: (v) => setState(() => _likelihood = v!),
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          label: 'Consequence',
                          value: _consequence,
                          items: widget.consequences,
                          onChanged: (v) => setState(() => _consequence = v!),
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
                          'Additional Controls / Actions',
                          maxLines: 4,
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          label: 'Control Hierarchy',
                          value: _hierarchy,
                          items: widget.hierarchies,
                          onChanged: (v) => setState(() => _hierarchy = v!),
                        ),
                        const SizedBox(height: 10),
                        _section('Residual Risk'),
                        _dropdown(
                          label: 'Residual Likelihood',
                          value: _residualLikelihood,
                          items: widget.likelihoods,
                          onChanged: (v) =>
                              setState(() => _residualLikelihood = v!),
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          label: 'Residual Consequence',
                          value: _residualConsequence,
                          items: widget.consequences,
                          onChanged: (v) =>
                              setState(() => _residualConsequence = v!),
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          label: 'Control Verification',
                          value: _controlStatus,
                          items: widget.controlStatuses,
                          onChanged: (v) =>
                              setState(() => _controlStatus = v!),
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton.icon(
                          onPressed: _pickReviewDate,
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
                          'Verification / Effectiveness Note',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        _text(
                          _escalationNote,
                          'Escalation / Follow-up Note',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          label: 'Status',
                          value: _status,
                          items: widget.statuses,
                          onChanged: (v) => setState(() => _status = v!),
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
                        widget.existing == null ? 'Save Risk' : 'Update Risk',
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

  Widget _dropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
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

class _RiskDetailsSheet extends StatelessWidget {
  const _RiskDetailsSheet({
    required this.risk,
    required this.onEdit,
    required this.onDelete,
    required this.onHistory,
    required this.onStatusChange,
    required this.onSourceOpen,
  });

  final Map<String, dynamic> risk;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onHistory;
  final ValueChanged<String> onStatusChange;
  final VoidCallback? onSourceOpen;

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color(0xFF0B5D4B);
    const primaryGreen = Color(0xFF159447);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .82,
          child: ListView(
            children: [
              Text(
                '${risk['title'] ?? 'Risk'}',
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: darkGreen,
                ),
              ),
              const SizedBox(height: 5),
              Text('${risk['id'] ?? ''}'),
              const Divider(height: 24),
              _row('Risk Type', risk['riskType']),
              _row('Hazard', risk['hazard']),
              _row('Activity', risk['activity']),
              _row('Location', risk['location']),
              _row('Owner', risk['owner']),
              _row('Department', risk['department']),
              _row('Source', risk['source']),
              _row('Reference', risk['referenceId']),
              _row(
                'Initial Risk',
                '${risk['initialLevel']} (${risk['initialScore']})',
              ),
              _row('Existing Controls', risk['existingControls']),
              _row('Additional Controls', risk['additionalControls']),
              _row('Hierarchy', risk['hierarchy']),
              _row(
                'Residual Risk',
                '${risk['residualLevel']} (${risk['residualScore']})',
              ),
              _row('Control Verification', risk['controlStatus']),
              _row('Review Date', _formatDate(risk['reviewDate'])),
              _row('Status', risk['status']),
              _row('Review Note', risk['reviewNote']),
              _row('Verification Note', risk['verificationNote']),
              _row('Escalation Note', risk['escalationNote']),
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
                  OutlinedButton.icon(
                    onPressed: () => onStatusChange('Under Review'),
                    icon: const Icon(Icons.rate_review),
                    label: const Text('Review'),
                  ),
                  OutlinedButton.icon(
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
