import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SiteHseReadinessRecord {
  final String id;
  final String checklistNo;
  final String projectName;
  final String siteName;
  final String location;
  final String contractor;
  final String projectManager;
  final String hseManager;
  final String inspectionDate;
  final String targetReadyDate;
  final String reviewer;
  final String approver;
  final String status;
  final String overallReadiness;
  final String score;
  final String mobilizationReference;
  final Map<String, bool> checks;
  final String findings;
  final String correctiveActions;
  final String actionOwner;
  final String actionDueDate;
  final String verification;
  final String approvalComments;
  final String supportingDocuments;
  final String remarks;
  final String createdAt;
  final String updatedAt;

  const SiteHseReadinessRecord({
    required this.id,
    required this.checklistNo,
    required this.projectName,
    required this.siteName,
    required this.location,
    required this.contractor,
    required this.projectManager,
    required this.hseManager,
    required this.inspectionDate,
    required this.targetReadyDate,
    required this.reviewer,
    required this.approver,
    required this.status,
    required this.overallReadiness,
    required this.score,
    required this.mobilizationReference,
    required this.checks,
    required this.findings,
    required this.correctiveActions,
    required this.actionOwner,
    required this.actionDueDate,
    required this.verification,
    required this.approvalComments,
    required this.supportingDocuments,
    required this.remarks,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'checklistNo': checklistNo,
        'projectName': projectName,
        'siteName': siteName,
        'location': location,
        'contractor': contractor,
        'projectManager': projectManager,
        'hseManager': hseManager,
        'inspectionDate': inspectionDate,
        'targetReadyDate': targetReadyDate,
        'reviewer': reviewer,
        'approver': approver,
        'status': status,
        'overallReadiness': overallReadiness,
        'score': score,
        'mobilizationReference': mobilizationReference,
        'checks': checks,
        'findings': findings,
        'correctiveActions': correctiveActions,
        'actionOwner': actionOwner,
        'actionDueDate': actionDueDate,
        'verification': verification,
        'approvalComments': approvalComments,
        'supportingDocuments': supportingDocuments,
        'remarks': remarks,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  factory SiteHseReadinessRecord.fromJson(Map<String, dynamic> json) {
    final rawChecks = json['checks'];
    final checks = <String, bool>{};
    if (rawChecks is Map) {
      rawChecks.forEach((key, value) {
        checks[key.toString()] = value == true;
      });
    }
    return SiteHseReadinessRecord(
      id: json['id']?.toString() ?? '',
      checklistNo: json['checklistNo']?.toString() ?? '',
      projectName: json['projectName']?.toString() ?? '',
      siteName: json['siteName']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      contractor: json['contractor']?.toString() ?? '',
      projectManager: json['projectManager']?.toString() ?? '',
      hseManager: json['hseManager']?.toString() ?? '',
      inspectionDate: json['inspectionDate']?.toString() ?? '',
      targetReadyDate: json['targetReadyDate']?.toString() ?? '',
      reviewer: json['reviewer']?.toString() ?? '',
      approver: json['approver']?.toString() ?? '',
      status: json['status']?.toString() ?? 'Draft',
      overallReadiness: json['overallReadiness']?.toString() ?? 'Not Ready',
      score: json['score']?.toString() ?? '0',
      mobilizationReference:
          json['mobilizationReference']?.toString() ?? '',
      checks: checks,
      findings: json['findings']?.toString() ?? '',
      correctiveActions: json['correctiveActions']?.toString() ?? '',
      actionOwner: json['actionOwner']?.toString() ?? '',
      actionDueDate: json['actionDueDate']?.toString() ?? '',
      verification: json['verification']?.toString() ?? '',
      approvalComments: json['approvalComments']?.toString() ?? '',
      supportingDocuments: json['supportingDocuments']?.toString() ?? '',
      remarks: json['remarks']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
    );
  }
}

class SiteHseMobilizationChecklistReadiness extends StatefulWidget {
  const SiteHseMobilizationChecklistReadiness({super.key});

  @override
  State<SiteHseMobilizationChecklistReadiness> createState() =>
      _SiteHseMobilizationChecklistReadinessState();
}

class _SiteHseMobilizationChecklistReadinessState
    extends State<SiteHseMobilizationChecklistReadiness> {
  static const String _storageKey =
      'safenexus_hse_site_hse_mobilization_checklist_readiness';
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final List<SiteHseReadinessRecord> _records = [];
  String _search = '';
  String _statusFilter = 'All';
  bool _loading = true;

  final List<String> _statuses = const [
    'Draft',
    'Checklist In Progress',
    'Under HSE Review',
    'Action Required',
    'Ready with Conditions',
    'Ready for Approval',
    'Approved',
    'Not Ready',
    'Closed',
    'Cancelled',
  ];

  final List<String> _sections = const [
    '5A - Site Mobilization Master Register',
    '5B - Site Establishment & Facilities',
    '5C - Site Access & Traffic Management',
    '5D - Temporary Facilities & Utilities',
    '5E - Emergency & Fire Readiness',
    '5F - Site Security & Access Control',
    'HSE Management System & Documents',
    'HSE Team & Responsibilities',
    'Risk Assessment & RAMS Readiness',
    'Permit to Work Readiness',
    'Workforce Induction & Competency',
    'PPE & Safety Equipment',
    'First Aid & Medical Readiness',
    'Emergency Response & Rescue',
    'Fire Prevention & Protection',
    'Environmental & Waste Readiness',
    'Inspection & Certification Readiness',
    'Welfare & Worker Facilities',
    'Communication & Safety Signage',
    'Document Control & Records',
  ];

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_storageKey) ?? <String>[];
    _records
      ..clear()
      ..addAll(raw.map((item) {
        try {
          return SiteHseReadinessRecord.fromJson(
            jsonDecode(item) as Map<String, dynamic>,
          );
        } catch (_) {
          return null;
        }
      }).whereType<SiteHseReadinessRecord>());
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _storageKey,
      _records.map((record) => jsonEncode(record.toJson())).toList(),
    );
  }

  List<SiteHseReadinessRecord> get _filteredRecords {
    final query = _search.trim().toLowerCase();
    return _records.where((record) {
      final matchesStatus =
          _statusFilter == 'All' || record.status == _statusFilter;
      if (!matchesStatus) return false;
      if (query.isEmpty) return true;
      final text = [
        record.checklistNo,
        record.projectName,
        record.siteName,
        record.location,
        record.contractor,
        record.status,
        record.overallReadiness,
      ].join(' ').toLowerCase();
      return text.contains(query);
    }).toList();
  }

  int _completedChecks(SiteHseReadinessRecord record) =>
      record.checks.values.where((value) => value).length;

  int _totalChecks(SiteHseReadinessRecord record) => record.checks.length;

  bool _isOverdue(SiteHseReadinessRecord record) {
    if (record.actionDueDate.trim().isEmpty ||
        record.status == 'Closed' ||
        record.status == 'Cancelled') {
      return false;
    }
    final due = DateTime.tryParse(record.actionDueDate);
    if (due == null) return false;
    return due.isBefore(DateTime.now());
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Approved':
      case 'Closed':
        return primaryGreen;
      case 'Ready for Approval':
      case 'Ready with Conditions':
        return Colors.orange.shade800;
      case 'Action Required':
      case 'Not Ready':
        return Colors.red.shade700;
      case 'Under HSE Review':
        return Colors.blue.shade700;
      case 'Cancelled':
        return Colors.grey.shade700;
      default:
        return darkGreen;
    }
  }

  Future<void> _deleteRecord(SiteHseReadinessRecord record) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Readiness Record?'),
        content: Text('Delete ${record.checklistNo}? This cannot be undone.'),
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
    if (confirm != true) return;
    _records.removeWhere((item) => item.id == record.id);
    await _saveRecords();
    if (mounted) setState(() {});
  }

  Future<void> _openForm({SiteHseReadinessRecord? existing}) async {
    final result = await showModalBottomSheet<SiteHseReadinessRecord>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ReadinessFormSheet(
        existing: existing,
        sections: _sections,
        statuses: _statuses,
      ),
    );
    if (result == null) return;
    final index = _records.indexWhere((item) => item.id == result.id);
    if (index >= 0) {
      _records[index] = result;
    } else {
      _records.insert(0, result);
    }
    await _saveRecords();
    if (mounted) setState(() {});
  }

  void _showDetails(SiteHseReadinessRecord record) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => _DetailsSheet(
        record: record,
        completed: _completedChecks(record),
        total: _totalChecks(record),
        overdue: _isOverdue(record),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredRecords;
    final total = _records.length;
    final approved =
        _records.where((record) => record.status == 'Approved').length;
    final ready = _records
        .where((record) =>
            record.overallReadiness == 'Ready' ||
            record.overallReadiness == 'Ready with Conditions')
        .length;
    final actions = _records
        .where((record) =>
            record.status == 'Action Required' || _isOverdue(record))
        .length;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('5G HSE Mobilization Readiness'),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Add checklist',
            onPressed: () => _openForm(),
            icon: const Icon(Icons.add_task),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add),
        label: const Text('New Checklist'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadRecords,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
                children: [
                  _headerCard(),
                  const SizedBox(height: 12),
                  _dashboard(total, approved, ready, actions),
                  const SizedBox(height: 12),
                  _searchAndFilter(),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [darkGreen, primaryGreen],
          ),
        ),
        padding: const EdgeInsets.all(18),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.verified_user, color: Colors.white, size: 30),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Site HSE Mobilization Checklist & Readiness',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Overall readiness gate for 5A–5F before site work starts.',
              style: TextStyle(color: Colors.white70, height: 1.35),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboard(int total, int approved, int ready, int actions) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1.8,
      children: [
        _metric('Total', total, Icons.fact_check, darkGreen),
        _metric('Approved', approved, Icons.verified, primaryGreen),
        _metric('Ready', ready, Icons.task_alt, Colors.orange.shade800),
        _metric('Actions / Overdue', actions, Icons.warning_amber, Colors.red),
      ],
    );
  }

  Widget _metric(String title, int value, IconData icon, Color color) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.10),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
                  Text(
                    '$value',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
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

  Widget _searchAndFilter() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search checklist / project / site',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _search.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () => setState(() => _search = ''),
                        icon: const Icon(Icons.clear),
                      ),
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _search = value),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _statusFilter,
              decoration: const InputDecoration(
                labelText: 'Status filter',
                border: OutlineInputBorder(),
              ),
              items: ['All', ..._statuses]
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _statusFilter = value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _recordCard(SiteHseReadinessRecord record) {
    final completed = _completedChecks(record);
    final total = _totalChecks(record);
    final color = _statusColor(record.status);
    final overdue = _isOverdue(record);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
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
                  Expanded(
                    child: Text(
                      record.checklistNo,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  _chip(record.status, color),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') _openForm(existing: record);
                      if (value == 'delete') _deleteRecord(record);
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: 'edit', child: Text('Edit')),
                      PopupMenuItem(value: 'delete', child: Text('Delete')),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                record.projectName.isEmpty ? 'Project not specified' : record.projectName,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              if (record.siteName.isNotEmpty)
                Text('${record.siteName} • ${record.location}'),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: total == 0 ? 0 : completed / total,
                minHeight: 7,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text('$completed / $total checks complete'),
                  const Spacer(),
                  Text(
                    '${record.score}%',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  _smallInfo('Readiness', record.overallReadiness),
                  if (record.inspectionDate.isNotEmpty)
                    _smallInfo('Review', _dateText(record.inspectionDate)),
                  if (overdue)
                    _smallInfo('OVERDUE', 'Action due date passed', Colors.red),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _smallInfo(String title, String value, [Color? color]) {
    final effectiveColor = color ?? darkGreen;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: effectiveColor.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$title: $value',
        style: TextStyle(color: effectiveColor, fontSize: 11),
      ),
    );
  }

  String _dateText(String value) {
    final date = DateTime.tryParse(value);
    if (date == null) return value;
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Widget _emptyState() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Icon(Icons.fact_check_outlined, size: 54, color: darkGreen.withValues(alpha: 0.55)),
            const SizedBox(height: 10),
            const Text(
              'No HSE readiness checklists found.',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create the first 5G readiness checklist to verify the site before mobilization closure.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ReadinessFormSheet extends StatefulWidget {
  final SiteHseReadinessRecord? existing;
  final List<String> sections;
  final List<String> statuses;

  const _ReadinessFormSheet({
    required this.existing,
    required this.sections,
    required this.statuses,
  });

  @override
  State<_ReadinessFormSheet> createState() => _ReadinessFormSheetState();
}

class _ReadinessFormSheetState extends State<_ReadinessFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  late Map<String, bool> _checks;
  late String _status;
  late String _overallReadiness;
  DateTime? _inspectionDate;
  DateTime? _targetReadyDate;
  DateTime? _actionDueDate;

  final List<String> _readinessOptions = const [
    'Not Ready',
    'Ready with Conditions',
    'Ready',
  ];

  @override
  void initState() {
    super.initState();
    final record = widget.existing;
    final values = {
      'checklistNo': record?.checklistNo ?? '',
      'projectName': record?.projectName ?? '',
      'siteName': record?.siteName ?? '',
      'location': record?.location ?? '',
      'contractor': record?.contractor ?? '',
      'projectManager': record?.projectManager ?? '',
      'hseManager': record?.hseManager ?? '',
      'reviewer': record?.reviewer ?? '',
      'approver': record?.approver ?? '',
      'mobilizationReference': record?.mobilizationReference ?? '',
      'findings': record?.findings ?? '',
      'correctiveActions': record?.correctiveActions ?? '',
      'actionOwner': record?.actionOwner ?? '',
      'verification': record?.verification ?? '',
      'approvalComments': record?.approvalComments ?? '',
      'supportingDocuments': record?.supportingDocuments ?? '',
      'remarks': record?.remarks ?? '',
    };
    values.forEach((key, value) {
      _controllers[key] = TextEditingController(text: value);
    });
    _checks = {
      for (final section in widget.sections)
        section: record?.checks[section] ?? false,
    };
    _status = record?.status ?? 'Draft';
    _overallReadiness = record?.overallReadiness ?? 'Not Ready';
    _inspectionDate = _parseDate(record?.inspectionDate);
    _targetReadyDate = _parseDate(record?.targetReadyDate);
    _actionDueDate = _parseDate(record?.actionDueDate);
  }

  DateTime? _parseDate(String? value) {
    if (value == null || value.isEmpty) return null;
    return DateTime.tryParse(value);
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  TextEditingController get _checklistNo => _controllers['checklistNo']!;
  TextEditingController get _projectName => _controllers['projectName']!;
  TextEditingController get _siteName => _controllers['siteName']!;
  TextEditingController get _location => _controllers['location']!;
  TextEditingController get _contractor => _controllers['contractor']!;
  TextEditingController get _projectManager => _controllers['projectManager']!;
  TextEditingController get _hseManager => _controllers['hseManager']!;
  TextEditingController get _reviewer => _controllers['reviewer']!;
  TextEditingController get _approver => _controllers['approver']!;
  TextEditingController get _mobilizationReference =>
      _controllers['mobilizationReference']!;
  TextEditingController get _findings => _controllers['findings']!;
  TextEditingController get _correctiveActions =>
      _controllers['correctiveActions']!;
  TextEditingController get _actionOwner => _controllers['actionOwner']!;
  TextEditingController get _verification => _controllers['verification']!;
  TextEditingController get _approvalComments =>
      _controllers['approvalComments']!;
  TextEditingController get _supportingDocuments =>
      _controllers['supportingDocuments']!;
  TextEditingController get _remarks => _controllers['remarks']!;

  int get _completed => _checks.values.where((value) => value).length;
  int get _total => _checks.length;
  int get _score => _total == 0 ? 0 : ((_completed / _total) * 100).round();

  Future<void> _pickDate({required String field}) async {
    DateTime initial;
    if (field == 'inspection') {
      initial = _inspectionDate ?? DateTime.now();
    } else if (field == 'target') {
      initial = _targetReadyDate ?? DateTime.now();
    } else {
      initial = _actionDueDate ?? DateTime.now();
    }
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: initial,
    );
    if (picked == null) return;
    setState(() {
      if (field == 'inspection') _inspectionDate = picked;
      if (field == 'target') _targetReadyDate = picked;
      if (field == 'action') _actionDueDate = picked;
    });
  }

  String _dateValue(DateTime? value) => value?.toIso8601String() ?? '';

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final now = DateTime.now().toIso8601String();
    final old = widget.existing;
    final record = SiteHseReadinessRecord(
      id: old?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
      checklistNo: _checklistNo.text.trim(),
      projectName: _projectName.text.trim(),
      siteName: _siteName.text.trim(),
      location: _location.text.trim(),
      contractor: _contractor.text.trim(),
      projectManager: _projectManager.text.trim(),
      hseManager: _hseManager.text.trim(),
      inspectionDate: _dateValue(_inspectionDate),
      targetReadyDate: _dateValue(_targetReadyDate),
      reviewer: _reviewer.text.trim(),
      approver: _approver.text.trim(),
      status: _status,
      overallReadiness: _overallReadiness,
      score: '$_score',
      mobilizationReference: _mobilizationReference.text.trim(),
      checks: Map<String, bool>.from(_checks),
      findings: _findings.text.trim(),
      correctiveActions: _correctiveActions.text.trim(),
      actionOwner: _actionOwner.text.trim(),
      actionDueDate: _dateValue(_actionDueDate),
      verification: _verification.text.trim(),
      approvalComments: _approvalComments.text.trim(),
      supportingDocuments: _supportingDocuments.text.trim(),
      remarks: _remarks.text.trim(),
      createdAt: old?.createdAt ?? now,
      updatedAt: now,
    );
    Navigator.pop(context, record);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: FractionallySizedBox(
        heightFactor: 0.96,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
              decoration: const BoxDecoration(
                color: primaryGreen,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.existing == null
                          ? 'New 5G Readiness Checklist'
                          : 'Edit 5G Readiness Checklist',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  IconButton(
                    color: Colors.white,
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
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 30),
                  children: [
                    _sectionTitle('1. Project & Mobilization Information'),
                    _field(_checklistNo, 'Checklist No.', required: true),
                    _field(_projectName, 'Project Name', required: true),
                    _field(_siteName, 'Site Name', required: true),
                    _field(_location, 'Site Location', required: true),
                    _field(_contractor, 'Main Contractor'),
                    _field(_projectManager, 'Project Manager'),
                    _field(_hseManager, 'HSE Manager'),
                    _field(_mobilizationReference, '5A Mobilization Reference'),
                    const SizedBox(height: 8),
                    _dateTile('Inspection / Readiness Review Date', _inspectionDate,
                        () => _pickDate(field: 'inspection')),
                    _dateTile('Target Ready Date', _targetReadyDate,
                        () => _pickDate(field: 'target')),
                    const SizedBox(height: 12),
                    _sectionTitle('2. Readiness Gate — 5A to 5F & HSE Controls'),
                    Card(
                      elevation: 0,
                      color: primaryGreen.withValues(alpha: 0.06),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.rule, color: darkGreen),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '$_completed / $_total completed  •  $_score% readiness',
                                    style: const TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: _score / 100,
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...widget.sections.map(_checkTile),
                    const SizedBox(height: 12),
                    _sectionTitle('3. Readiness Decision'),
                    DropdownButtonFormField<String>(
                      initialValue: _overallReadiness,
                      decoration: const InputDecoration(
                        labelText: 'Overall Readiness',
                        border: OutlineInputBorder(),
                      ),
                      items: _readinessOptions
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) setState(() => _overallReadiness = value);
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _status,
                      decoration: const InputDecoration(
                        labelText: 'Workflow Status',
                        border: OutlineInputBorder(),
                      ),
                      items: widget.statuses
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) setState(() => _status = value);
                      },
                    ),
                    const SizedBox(height: 12),
                    _sectionTitle('4. Findings & Corrective Actions'),
                    _field(_findings, 'Findings / Gaps', maxLines: 4),
                    _field(_correctiveActions, 'Corrective / Preventive Actions', maxLines: 4),
                    _field(_actionOwner, 'Action Owner'),
                    _dateTile('Action Due Date', _actionDueDate,
                        () => _pickDate(field: 'action')),
                    _field(_verification, 'Verification / Effectiveness', maxLines: 3),
                    const SizedBox(height: 12),
                    _sectionTitle('5. Review, Approval & Records'),
                    _field(_reviewer, 'HSE Reviewer'),
                    _field(_approver, 'Management Approver'),
                    _field(_approvalComments, 'Approval / Review Comments', maxLines: 3),
                    _field(_supportingDocuments, 'Supporting Documents / Evidence', maxLines: 3),
                    _field(_remarks, 'Remarks', maxLines: 3),
                    const SizedBox(height: 18),
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: primaryGreen,
                        minimumSize: const Size.fromHeight(52),
                      ),
                      onPressed: _save,
                      icon: const Icon(Icons.save),
                      label: Text(widget.existing == null ? 'Save Checklist' : 'Update Checklist'),
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

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 4),
      child: Text(
        title,
        style: const TextStyle(
          color: darkGreen,
          fontSize: 15,
          fontWeight: FontWeight.w800,
        ),
      ),
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
        validator: required
            ? (value) => value == null || value.trim().isEmpty
                ? '$label is required'
                : null
            : null,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          border: const OutlineInputBorder(),
          alignLabelWithHint: maxLines > 1,
        ),
      ),
    );
  }

  Widget _dateTile(String label, DateTime? value, VoidCallback onTap) {
    final text = value == null
        ? 'Not selected'
        : '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year}';
    return Card(
      elevation: 0,
      color: Colors.grey.shade100,
      child: ListTile(
        leading: const Icon(Icons.calendar_month, color: darkGreen),
        title: Text(label),
        subtitle: Text(text),
        trailing: const Icon(Icons.edit_calendar),
        onTap: onTap,
      ),
    );
  }

  Widget _checkTile(String section) {
    final value = _checks[section] ?? false;
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 6),
      child: CheckboxListTile(
        value: value,
        activeColor: primaryGreen,
        title: Text(section, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        subtitle: Text(value ? 'Verified / Ready' : 'Pending verification'),
        onChanged: (checked) {
          setState(() => _checks[section] = checked ?? false);
        },
      ),
    );
  }
}

class _DetailsSheet extends StatelessWidget {
  final SiteHseReadinessRecord record;
  final int completed;
  final int total;
  final bool overdue;

  const _DetailsSheet({
    required this.record,
    required this.completed,
    required this.total,
    required this.overdue,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  @override
  Widget build(BuildContext context) {
    final checked = record.checks.entries.where((entry) => entry.value).toList();
    final pending = record.checks.entries.where((entry) => !entry.value).toList();
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: FractionallySizedBox(
        heightFactor: 0.92,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 8, 12),
              decoration: const BoxDecoration(
                color: primaryGreen,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      record.checklistNo,
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                  ),
                  IconButton(
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _info('Project', record.projectName),
                  _info('Site', record.siteName),
                  _info('Location', record.location),
                  _info('Contractor', record.contractor),
                  _info('HSE Manager', record.hseManager),
                  _info('Inspection Date', _dateText(record.inspectionDate)),
                  _info('Target Ready Date', _dateText(record.targetReadyDate)),
                  _info('Status', record.status),
                  _info('Overall Readiness', record.overallReadiness),
                  _info('Readiness Score', '${record.score}% ($completed/$total)'),
                  if (overdue) _warning('Action is overdue.'),
                  const SizedBox(height: 10),
                  const Text('Verified Readiness Items', style: TextStyle(color: darkGreen, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  ...checked.map((item) => ListTile(
                        dense: true,
                        leading: const Icon(Icons.check_circle, color: primaryGreen),
                        title: Text(item.key),
                      )),
                  if (pending.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    const Text('Pending / Not Verified', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    ...pending.map((item) => ListTile(
                          dense: true,
                          leading: const Icon(Icons.radio_button_unchecked, color: Colors.red),
                          title: Text(item.key),
                        )),
                  ],
                  _longInfo('Findings / Gaps', record.findings),
                  _longInfo('Corrective Actions', record.correctiveActions),
                  _info('Action Owner', record.actionOwner),
                  _info('Action Due Date', _dateText(record.actionDueDate)),
                  _longInfo('Verification', record.verification),
                  _info('HSE Reviewer', record.reviewer),
                  _info('Approver', record.approver),
                  _longInfo('Approval Comments', record.approvalComments),
                  _longInfo('Supporting Documents', record.supportingDocuments),
                  _longInfo('Remarks', record.remarks),
                  const SizedBox(height: 12),
                  Text('Created: ${_dateTimeText(record.createdAt)}'),
                  Text('Updated: ${_dateTimeText(record.updatedAt)}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(String label, String value) {
    if (value.trim().isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 125, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700))),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _longInfo(String label, String value) {
    if (value.trim().isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Card(
        elevation: 0,
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w800, color: darkGreen)),
              const SizedBox(height: 5),
              Text(value),
            ],
          ),
        ),
      ),
    );
  }

  Widget _warning(String text) {
    return Card(
      elevation: 0,
      color: Colors.red.withValues(alpha: 0.08),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.warning_amber, color: Colors.red),
            const SizedBox(width: 8),
            Expanded(child: Text(text, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w700))),
          ],
        ),
      ),
    );
  }

  String _dateText(String value) {
    if (value.isEmpty) return '';
    final date = DateTime.tryParse(value);
    if (date == null) return value;
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _dateTimeText(String value) {
    if (value.isEmpty) return '';
    final date = DateTime.tryParse(value);
    if (date == null) return value;
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
