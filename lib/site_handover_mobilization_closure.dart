import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SiteHandoverMobilizationClosurePage extends StatefulWidget {
  const SiteHandoverMobilizationClosurePage({super.key});

  @override
  State<SiteHandoverMobilizationClosurePage> createState() =>
      _SiteHandoverMobilizationClosurePageState();
}

class _SiteHandoverMobilizationClosurePageState
    extends State<SiteHandoverMobilizationClosurePage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_site_handover_mobilization_closure';

  final List<SiteHandoverRecord> _records = [];
  String _search = '';
  String _statusFilter = 'All';
  String _handoverFilter = 'All';

  final List<String> _statuses = const [
    'Draft',
    'Handover Requested',
    'Under Verification',
    'Actions Required',
    'Ready for Handover',
    'Handover Completed',
    'Closed',
    'Reopened',
    'Cancelled',
  ];

  final List<String> _handoverTypes = const [
    'Normal Mobilization Handover',
    'Phase / Area Handover',
    'Shift Handover',
    'Temporary Facilities Handover',
    'Emergency Handover',
    'Final Mobilization Closure',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(storageKey) ?? [];
    final loaded = <SiteHandoverRecord>[];
    for (final item in raw) {
      try {
        loaded.add(
          SiteHandoverRecord.fromJson(
            jsonDecode(item) as Map<String, dynamic>,
          ),
        );
      } catch (_) {
        // Ignore malformed legacy records.
      }
    }
    if (!mounted) return;
    setState(() {
      _records
        ..clear()
        ..addAll(loaded);
    });
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      storageKey,
      _records.map((record) => jsonEncode(record.toJson())).toList(),
    );
  }

  List<SiteHandoverRecord> get _filteredRecords {
    final query = _search.trim().toLowerCase();
    return _records.where((record) {
      final matchesSearch = query.isEmpty ||
          [
            record.recordNo,
            record.projectName,
            record.siteName,
            record.location,
            record.activity,
            record.handoverType,
            record.status,
            record.hseReviewer,
            record.projectManager,
          ].join(' ').toLowerCase().contains(query);

      final matchesStatus =
          _statusFilter == 'All' || record.status == _statusFilter;
      final matchesType =
          _handoverFilter == 'All' || record.handoverType == _handoverFilter;

      return matchesSearch && matchesStatus && matchesType;
    }).toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  int _countStatus(String status) =>
      _records.where((record) => record.status == status).length;

  int get _overdueCount => _records.where((record) => record.isOverdue).length;

  double get _averageReadiness {
    if (_records.isEmpty) return 0;
    final total =
        _records.fold<int>(0, (sum, record) => sum + record.readinessScore);
    return total / _records.length;
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Closed':
      case 'Handover Completed':
        return primaryGreen;
      case 'Ready for Handover':
        return Colors.teal;
      case 'Actions Required':
      case 'Reopened':
        return Colors.orange;
      case 'Cancelled':
        return Colors.red;
      case 'Under Verification':
      case 'Handover Requested':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Future<void> _openForm([SiteHandoverRecord? existing]) async {
    final result = await showModalBottomSheet<SiteHandoverRecord>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _SiteHandoverFormSheet(
        existing: existing,
        statuses: _statuses,
        handoverTypes: _handoverTypes,
      ),
    );

    if (result == null) return;
    setState(() {
      final index = _records.indexWhere((item) => item.id == result.id);
      if (index >= 0) {
        _records[index] = result;
      } else {
        _records.add(result);
      }
    });
    await _saveRecords();
  }

  Future<void> _deleteRecord(SiteHandoverRecord record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete record?'),
        content: Text('Delete ${record.recordNo}? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    setState(() => _records.removeWhere((item) => item.id == record.id));
    await _saveRecords();
  }

  void _showDetails(SiteHandoverRecord record) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _DetailsSheet(record: record),
    );
  }

  @override
  Widget build(BuildContext context) {
    final records = _filteredRecords;
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('5H Site Handover & Closure'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add),
        label: const Text('New Handover'),
      ),
      body: RefreshIndicator(
        onRefresh: _loadRecords,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildDashboard(),
            const SizedBox(height: 12),
            _buildFilters(),
            const SizedBox(height: 12),
            if (records.isEmpty)
              _buildEmptyState()
            else
              ...records.map(_buildRecordCard),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: primaryGreen.withValues(alpha: 0.12),
              child: const Icon(Icons.handshake_outlined,
                  color: primaryGreen, size: 28),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Site Handover & Mobilization Closure',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Final verification, handover, approval, closure and archive control for Phase 5.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboard() {
    final total = _records.length;
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.8,
      children: [
        _metric('Total', '$total', Icons.folder_open),
        _metric(
          'Completed',
          '${_countStatus('Handover Completed')}',
          Icons.check_circle_outline,
        ),
        _metric(
          'Closed',
          '${_countStatus('Closed')}',
          Icons.lock_outline,
        ),
        _metric(
          'Actions',
          '${_countStatus('Actions Required')}',
          Icons.warning_amber_outlined,
        ),
        _metric(
          'Ready',
          '${_countStatus('Ready for Handover')}',
          Icons.task_alt,
        ),
        _metric(
          'Overdue',
          '$_overdueCount',
          Icons.schedule,
          alert: _overdueCount > 0,
        ),
        _metric(
          'Avg. Readiness',
          '${_averageReadiness.toStringAsFixed(0)}%',
          Icons.analytics_outlined,
        ),
        _metric(
          'Verification',
          '${_countStatus('Under Verification')}',
          Icons.verified_outlined,
        ),
      ],
    );
  }

  Widget _metric(
    String title,
    String value,
    IconData icon, {
    bool alert = false,
  }) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(icon, color: alert ? Colors.red : primaryGreen),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 3),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: alert ? Colors.red : darkGreen,
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

  Widget _buildFilters() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => setState(() => _search = value),
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Record no, project, site, location...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _search.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () => setState(() => _search = ''),
                        icon: const Icon(Icons.clear),
                      ),
                border: const OutlineInputBorder(),
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
                    items: ['All', ..._statuses]
                        .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _statusFilter = value ?? 'All'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _handoverFilter,
                    decoration: const InputDecoration(
                      labelText: 'Handover Type',
                      border: OutlineInputBorder(),
                    ),
                    items: ['All', ..._handoverTypes]
                        .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _handoverFilter = value ?? 'All'),
                  ),
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
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Icon(Icons.handshake_outlined, size: 52, color: Colors.grey),
            const SizedBox(height: 12),
            const Text(
              'No handover records found',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create a 5H record after the 5G readiness review is complete.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => _openForm(),
              icon: const Icon(Icons.add),
              label: const Text('Create Record'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordCard(SiteHandoverRecord record) {
    final color = _statusColor(record.status);
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () => _showDetails(record),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      record.recordNo,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') _openForm(record);
                      if (value == 'delete') _deleteRecord(record);
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(value: 'edit', child: Text('Edit')),
                      PopupMenuItem(value: 'delete', child: Text('Delete')),
                    ],
                  ),
                ],
              ),
              Text(
                record.projectName.isEmpty ? 'Project not specified' : record.projectName,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              if (record.siteName.isNotEmpty) Text(record.siteName),
              if (record.location.isNotEmpty) Text(record.location),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _chip(record.handoverType, Colors.blue),
                  _chip(record.status, color),
                  _chip(
                    '${record.readinessScore}% ready',
                    record.readinessScore >= 90
                        ? primaryGreen
                        : record.readinessScore >= 70
                            ? Colors.orange
                            : Colors.red,
                  ),
                  if (record.isOverdue) _chip('• OVERDUE', Colors.red),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Handover: ${_formatDate(record.handoverDate)}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  Text(
                    'Updated ${_formatDateTime(record.updatedAt)}',
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatDate(DateTime? value) {
    if (value == null) return '-';
    return '${value.day.toString().padLeft(2, '0')}/'
        '${value.month.toString().padLeft(2, '0')}/${value.year}';
  }

  String _formatDateTime(DateTime value) {
    return '${value.day.toString().padLeft(2, '0')}/'
        '${value.month.toString().padLeft(2, '0')}/${value.year} '
        '${value.hour.toString().padLeft(2, '0')}:'
        '${value.minute.toString().padLeft(2, '0')}';
  }
}

class SiteHandoverRecord {
  final String id;
  final String recordNo;
  final String projectName;
  final String siteName;
  final String location;
  final String department;
  final String activity;
  final String mobilizationRef;
  final String readinessRef;
  final String handoverType;
  final String status;

  final DateTime? mobilizationStartDate;
  final DateTime? finalInspectionDate;
  final DateTime? handoverDate;
  final DateTime? closureDueDate;
  final DateTime? closureDate;

  final String hseManager;
  final String projectManager;
  final String hseReviewer;
  final String receivingAuthority;
  final String approvingManager;

  final bool siteSetupVerified;
  final bool facilitiesVerified;
  final bool trafficAccessVerified;
  final bool utilitiesVerified;
  final bool emergencyFireVerified;
  final bool securityVerified;
  final bool hseDocumentsVerified;
  final bool riskRamsPtwVerified;
  final bool trainingCompetencyVerified;
  final bool ppeWelfareVerified;
  final bool environmentalVerified;
  final bool inspectionsCertificatesVerified;

  final String finalInspectionFindings;
  final String readinessFindings;
  final String outstandingActions;
  final String correctiveActions;
  final String actionOwner;
  final DateTime? actionDueDate;
  final String verificationFindings;
  final String effectiveness;
  final String hseAcceptance;
  final String projectManagerAcceptance;
  final String managementApproval;
  final String handoverRemarks;
  final String supportingDocuments;
  final String archiveReference;
  final String lessonsLearned;

  final DateTime createdAt;
  final DateTime updatedAt;

  const SiteHandoverRecord({
    required this.id,
    required this.recordNo,
    required this.projectName,
    required this.siteName,
    required this.location,
    required this.department,
    required this.activity,
    required this.mobilizationRef,
    required this.readinessRef,
    required this.handoverType,
    required this.status,
    required this.mobilizationStartDate,
    required this.finalInspectionDate,
    required this.handoverDate,
    required this.closureDueDate,
    required this.closureDate,
    required this.hseManager,
    required this.projectManager,
    required this.hseReviewer,
    required this.receivingAuthority,
    required this.approvingManager,
    required this.siteSetupVerified,
    required this.facilitiesVerified,
    required this.trafficAccessVerified,
    required this.utilitiesVerified,
    required this.emergencyFireVerified,
    required this.securityVerified,
    required this.hseDocumentsVerified,
    required this.riskRamsPtwVerified,
    required this.trainingCompetencyVerified,
    required this.ppeWelfareVerified,
    required this.environmentalVerified,
    required this.inspectionsCertificatesVerified,
    required this.finalInspectionFindings,
    required this.readinessFindings,
    required this.outstandingActions,
    required this.correctiveActions,
    required this.actionOwner,
    required this.actionDueDate,
    required this.verificationFindings,
    required this.effectiveness,
    required this.hseAcceptance,
    required this.projectManagerAcceptance,
    required this.managementApproval,
    required this.handoverRemarks,
    required this.supportingDocuments,
    required this.archiveReference,
    required this.lessonsLearned,
    required this.createdAt,
    required this.updatedAt,
  });

  int get readinessScore {
    final checks = [
      siteSetupVerified,
      facilitiesVerified,
      trafficAccessVerified,
      utilitiesVerified,
      emergencyFireVerified,
      securityVerified,
      hseDocumentsVerified,
      riskRamsPtwVerified,
      trainingCompetencyVerified,
      ppeWelfareVerified,
      environmentalVerified,
      inspectionsCertificatesVerified,
    ];
    final passed = checks.where((item) => item).length;
    return ((passed / checks.length) * 100).round();
  }

  bool get isOverdue {
    if (actionDueDate == null || correctiveActions.trim().isEmpty) return false;
    if (status == 'Closed' || status == 'Cancelled') return false;
    return actionDueDate!.isBefore(_today());
  }

  DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recordNo': recordNo,
      'projectName': projectName,
      'siteName': siteName,
      'location': location,
      'department': department,
      'activity': activity,
      'mobilizationRef': mobilizationRef,
      'readinessRef': readinessRef,
      'handoverType': handoverType,
      'status': status,
      'mobilizationStartDate': mobilizationStartDate?.toIso8601String(),
      'finalInspectionDate': finalInspectionDate?.toIso8601String(),
      'handoverDate': handoverDate?.toIso8601String(),
      'closureDueDate': closureDueDate?.toIso8601String(),
      'closureDate': closureDate?.toIso8601String(),
      'hseManager': hseManager,
      'projectManager': projectManager,
      'hseReviewer': hseReviewer,
      'receivingAuthority': receivingAuthority,
      'approvingManager': approvingManager,
      'siteSetupVerified': siteSetupVerified,
      'facilitiesVerified': facilitiesVerified,
      'trafficAccessVerified': trafficAccessVerified,
      'utilitiesVerified': utilitiesVerified,
      'emergencyFireVerified': emergencyFireVerified,
      'securityVerified': securityVerified,
      'hseDocumentsVerified': hseDocumentsVerified,
      'riskRamsPtwVerified': riskRamsPtwVerified,
      'trainingCompetencyVerified': trainingCompetencyVerified,
      'ppeWelfareVerified': ppeWelfareVerified,
      'environmentalVerified': environmentalVerified,
      'inspectionsCertificatesVerified': inspectionsCertificatesVerified,
      'finalInspectionFindings': finalInspectionFindings,
      'readinessFindings': readinessFindings,
      'outstandingActions': outstandingActions,
      'correctiveActions': correctiveActions,
      'actionOwner': actionOwner,
      'actionDueDate': actionDueDate?.toIso8601String(),
      'verificationFindings': verificationFindings,
      'effectiveness': effectiveness,
      'hseAcceptance': hseAcceptance,
      'projectManagerAcceptance': projectManagerAcceptance,
      'managementApproval': managementApproval,
      'handoverRemarks': handoverRemarks,
      'supportingDocuments': supportingDocuments,
      'archiveReference': archiveReference,
      'lessonsLearned': lessonsLearned,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory SiteHandoverRecord.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic value) =>
        value == null || value.toString().isEmpty
            ? null
            : DateTime.tryParse(value.toString());

    return SiteHandoverRecord(
      id: json['id']?.toString() ?? DateTime.now().microsecondsSinceEpoch.toString(),
      recordNo: json['recordNo']?.toString() ?? '',
      projectName: json['projectName']?.toString() ?? '',
      siteName: json['siteName']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      department: json['department']?.toString() ?? '',
      activity: json['activity']?.toString() ?? '',
      mobilizationRef: json['mobilizationRef']?.toString() ?? '',
      readinessRef: json['readinessRef']?.toString() ?? '',
      handoverType: json['handoverType']?.toString() ??
          'Normal Mobilization Handover',
      status: json['status']?.toString() ?? 'Draft',
      mobilizationStartDate: parseDate(json['mobilizationStartDate']),
      finalInspectionDate: parseDate(json['finalInspectionDate']),
      handoverDate: parseDate(json['handoverDate']),
      closureDueDate: parseDate(json['closureDueDate']),
      closureDate: parseDate(json['closureDate']),
      hseManager: json['hseManager']?.toString() ?? '',
      projectManager: json['projectManager']?.toString() ?? '',
      hseReviewer: json['hseReviewer']?.toString() ?? '',
      receivingAuthority: json['receivingAuthority']?.toString() ?? '',
      approvingManager: json['approvingManager']?.toString() ?? '',
      siteSetupVerified: json['siteSetupVerified'] == true,
      facilitiesVerified: json['facilitiesVerified'] == true,
      trafficAccessVerified: json['trafficAccessVerified'] == true,
      utilitiesVerified: json['utilitiesVerified'] == true,
      emergencyFireVerified: json['emergencyFireVerified'] == true,
      securityVerified: json['securityVerified'] == true,
      hseDocumentsVerified: json['hseDocumentsVerified'] == true,
      riskRamsPtwVerified: json['riskRamsPtwVerified'] == true,
      trainingCompetencyVerified: json['trainingCompetencyVerified'] == true,
      ppeWelfareVerified: json['ppeWelfareVerified'] == true,
      environmentalVerified: json['environmentalVerified'] == true,
      inspectionsCertificatesVerified:
          json['inspectionsCertificatesVerified'] == true,
      finalInspectionFindings:
          json['finalInspectionFindings']?.toString() ?? '',
      readinessFindings: json['readinessFindings']?.toString() ?? '',
      outstandingActions: json['outstandingActions']?.toString() ?? '',
      correctiveActions: json['correctiveActions']?.toString() ?? '',
      actionOwner: json['actionOwner']?.toString() ?? '',
      actionDueDate: parseDate(json['actionDueDate']),
      verificationFindings: json['verificationFindings']?.toString() ?? '',
      effectiveness: json['effectiveness']?.toString() ?? '',
      hseAcceptance: json['hseAcceptance']?.toString() ?? '',
      projectManagerAcceptance:
          json['projectManagerAcceptance']?.toString() ?? '',
      managementApproval: json['managementApproval']?.toString() ?? '',
      handoverRemarks: json['handoverRemarks']?.toString() ?? '',
      supportingDocuments: json['supportingDocuments']?.toString() ?? '',
      archiveReference: json['archiveReference']?.toString() ?? '',
      lessonsLearned: json['lessonsLearned']?.toString() ?? '',
      createdAt:
          parseDate(json['createdAt']) ?? DateTime.now(),
      updatedAt:
          parseDate(json['updatedAt']) ?? DateTime.now(),
    );
  }
}

class _SiteHandoverFormSheet extends StatefulWidget {
  final SiteHandoverRecord? existing;
  final List<String> statuses;
  final List<String> handoverTypes;

  const _SiteHandoverFormSheet({
    required this.existing,
    required this.statuses,
    required this.handoverTypes,
  });

  @override
  State<_SiteHandoverFormSheet> createState() => _SiteHandoverFormSheetState();
}

class _SiteHandoverFormSheetState extends State<_SiteHandoverFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController recordNo;
  late final TextEditingController projectName;
  late final TextEditingController siteName;
  late final TextEditingController location;
  late final TextEditingController department;
  late final TextEditingController activity;
  late final TextEditingController mobilizationRef;
  late final TextEditingController readinessRef;
  late final TextEditingController hseManager;
  late final TextEditingController projectManager;
  late final TextEditingController hseReviewer;
  late final TextEditingController receivingAuthority;
  late final TextEditingController approvingManager;
  late final TextEditingController finalInspectionFindings;
  late final TextEditingController readinessFindings;
  late final TextEditingController outstandingActions;
  late final TextEditingController correctiveActions;
  late final TextEditingController actionOwner;
  late final TextEditingController verificationFindings;
  late final TextEditingController effectiveness;
  late final TextEditingController hseAcceptance;
  late final TextEditingController projectManagerAcceptance;
  late final TextEditingController managementApproval;
  late final TextEditingController handoverRemarks;
  late final TextEditingController supportingDocuments;
  late final TextEditingController archiveReference;
  late final TextEditingController lessonsLearned;

  String status = 'Draft';
  String handoverType = 'Normal Mobilization Handover';

  DateTime? mobilizationStartDate;
  DateTime? finalInspectionDate;
  DateTime? handoverDate;
  DateTime? closureDueDate;
  DateTime? closureDate;
  DateTime? actionDueDate;

  bool siteSetupVerified = false;
  bool facilitiesVerified = false;
  bool trafficAccessVerified = false;
  bool utilitiesVerified = false;
  bool emergencyFireVerified = false;
  bool securityVerified = false;
  bool hseDocumentsVerified = false;
  bool riskRamsPtwVerified = false;
  bool trainingCompetencyVerified = false;
  bool ppeWelfareVerified = false;
  bool environmentalVerified = false;
  bool inspectionsCertificatesVerified = false;

  @override
  void initState() {
    super.initState();
    final r = widget.existing;
    recordNo = _controller(r?.recordNo ?? '');
    projectName = _controller(r?.projectName ?? '');
    siteName = _controller(r?.siteName ?? '');
    location = _controller(r?.location ?? '');
    department = _controller(r?.department ?? '');
    activity = _controller(r?.activity ?? '');
    mobilizationRef = _controller(r?.mobilizationRef ?? '');
    readinessRef = _controller(r?.readinessRef ?? '');
    hseManager = _controller(r?.hseManager ?? '');
    projectManager = _controller(r?.projectManager ?? '');
    hseReviewer = _controller(r?.hseReviewer ?? '');
    receivingAuthority = _controller(r?.receivingAuthority ?? '');
    approvingManager = _controller(r?.approvingManager ?? '');
    finalInspectionFindings = _controller(r?.finalInspectionFindings ?? '');
    readinessFindings = _controller(r?.readinessFindings ?? '');
    outstandingActions = _controller(r?.outstandingActions ?? '');
    correctiveActions = _controller(r?.correctiveActions ?? '');
    actionOwner = _controller(r?.actionOwner ?? '');
    verificationFindings = _controller(r?.verificationFindings ?? '');
    effectiveness = _controller(r?.effectiveness ?? '');
    hseAcceptance = _controller(r?.hseAcceptance ?? '');
    projectManagerAcceptance =
        _controller(r?.projectManagerAcceptance ?? '');
    managementApproval = _controller(r?.managementApproval ?? '');
    handoverRemarks = _controller(r?.handoverRemarks ?? '');
    supportingDocuments = _controller(r?.supportingDocuments ?? '');
    archiveReference = _controller(r?.archiveReference ?? '');
    lessonsLearned = _controller(r?.lessonsLearned ?? '');

    status = r?.status ?? 'Draft';
    handoverType = r?.handoverType ?? 'Normal Mobilization Handover';
    mobilizationStartDate = r?.mobilizationStartDate;
    finalInspectionDate = r?.finalInspectionDate;
    handoverDate = r?.handoverDate;
    closureDueDate = r?.closureDueDate;
    closureDate = r?.closureDate;
    actionDueDate = r?.actionDueDate;

    siteSetupVerified = r?.siteSetupVerified ?? false;
    facilitiesVerified = r?.facilitiesVerified ?? false;
    trafficAccessVerified = r?.trafficAccessVerified ?? false;
    utilitiesVerified = r?.utilitiesVerified ?? false;
    emergencyFireVerified = r?.emergencyFireVerified ?? false;
    securityVerified = r?.securityVerified ?? false;
    hseDocumentsVerified = r?.hseDocumentsVerified ?? false;
    riskRamsPtwVerified = r?.riskRamsPtwVerified ?? false;
    trainingCompetencyVerified = r?.trainingCompetencyVerified ?? false;
    ppeWelfareVerified = r?.ppeWelfareVerified ?? false;
    environmentalVerified = r?.environmentalVerified ?? false;
    inspectionsCertificatesVerified =
        r?.inspectionsCertificatesVerified ?? false;
  }

  TextEditingController _controller(String value) =>
      TextEditingController(text: value);

  @override
  void dispose() {
    for (final controller in [
      recordNo,
      projectName,
      siteName,
      location,
      department,
      activity,
      mobilizationRef,
      readinessRef,
      hseManager,
      projectManager,
      hseReviewer,
      receivingAuthority,
      approvingManager,
      finalInspectionFindings,
      readinessFindings,
      outstandingActions,
      correctiveActions,
      actionOwner,
      verificationFindings,
      effectiveness,
      hseAcceptance,
      projectManagerAcceptance,
      managementApproval,
      handoverRemarks,
      supportingDocuments,
      archiveReference,
      lessonsLearned,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDate(ValueChanged<DateTime?> setter, DateTime? current) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: current ?? DateTime.now(),
    );
    if (picked != null) setter(picked);
  }

  int get _readinessScore {
    final checks = [
      siteSetupVerified,
      facilitiesVerified,
      trafficAccessVerified,
      utilitiesVerified,
      emergencyFireVerified,
      securityVerified,
      hseDocumentsVerified,
      riskRamsPtwVerified,
      trainingCompetencyVerified,
      ppeWelfareVerified,
      environmentalVerified,
      inspectionsCertificatesVerified,
    ];
    return ((checks.where((item) => item).length / checks.length) * 100).round();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (status == 'Ready for Handover' && _readinessScore < 90) {
      _showError('Readiness must be at least 90% before Ready for Handover.');
      return;
    }

    if (status == 'Closed' &&
        (closureDate == null ||
            hseAcceptance.text.trim().isEmpty ||
            managementApproval.text.trim().isEmpty)) {
      _showError(
        'Closed status requires closure date, HSE acceptance and management approval.',
      );
      return;
    }

    if (actionDueDate != null &&
        correctiveActions.text.trim().isNotEmpty &&
        actionOwner.text.trim().isEmpty) {
      _showError('Action owner is required when a corrective action has a due date.');
      return;
    }

    final now = DateTime.now();
    final existing = widget.existing;

    final record = SiteHandoverRecord(
      id: existing?.id ?? now.microsecondsSinceEpoch.toString(),
      recordNo: recordNo.text.trim(),
      projectName: projectName.text.trim(),
      siteName: siteName.text.trim(),
      location: location.text.trim(),
      department: department.text.trim(),
      activity: activity.text.trim(),
      mobilizationRef: mobilizationRef.text.trim(),
      readinessRef: readinessRef.text.trim(),
      handoverType: handoverType,
      status: status,
      mobilizationStartDate: mobilizationStartDate,
      finalInspectionDate: finalInspectionDate,
      handoverDate: handoverDate,
      closureDueDate: closureDueDate,
      closureDate: closureDate,
      hseManager: hseManager.text.trim(),
      projectManager: projectManager.text.trim(),
      hseReviewer: hseReviewer.text.trim(),
      receivingAuthority: receivingAuthority.text.trim(),
      approvingManager: approvingManager.text.trim(),
      siteSetupVerified: siteSetupVerified,
      facilitiesVerified: facilitiesVerified,
      trafficAccessVerified: trafficAccessVerified,
      utilitiesVerified: utilitiesVerified,
      emergencyFireVerified: emergencyFireVerified,
      securityVerified: securityVerified,
      hseDocumentsVerified: hseDocumentsVerified,
      riskRamsPtwVerified: riskRamsPtwVerified,
      trainingCompetencyVerified: trainingCompetencyVerified,
      ppeWelfareVerified: ppeWelfareVerified,
      environmentalVerified: environmentalVerified,
      inspectionsCertificatesVerified:
          inspectionsCertificatesVerified,
      finalInspectionFindings: finalInspectionFindings.text.trim(),
      readinessFindings: readinessFindings.text.trim(),
      outstandingActions: outstandingActions.text.trim(),
      correctiveActions: correctiveActions.text.trim(),
      actionOwner: actionOwner.text.trim(),
      actionDueDate: actionDueDate,
      verificationFindings: verificationFindings.text.trim(),
      effectiveness: effectiveness.text.trim(),
      hseAcceptance: hseAcceptance.text.trim(),
      projectManagerAcceptance: projectManagerAcceptance.text.trim(),
      managementApproval: managementApproval.text.trim(),
      handoverRemarks: handoverRemarks.text.trim(),
      supportingDocuments: supportingDocuments.text.trim(),
      archiveReference: archiveReference.text.trim(),
      lessonsLearned: lessonsLearned.text.trim(),
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );

    Navigator.pop(context, record);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.92,
          minChildSize: 0.55,
          maxChildSize: 0.98,
          builder: (_, controller) => Form(
            key: _formKey,
            child: ListView(
              controller: controller,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.existing == null
                      ? 'New Site Handover Record'
                      : 'Edit Site Handover Record',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 12),
                _section('1. Record & Project Information', [
                  _field(recordNo, 'Record No.', required: true),
                  _field(projectName, 'Project Name', required: true),
                  _field(siteName, 'Site Name', required: true),
                  _field(location, 'Location'),
                  _field(department, 'Department'),
                  _field(activity, 'Activity / Area'),
                  _field(mobilizationRef, 'Mobilization Master Ref.'),
                  _field(readinessRef, '5G Readiness Ref.'),
                  DropdownButtonFormField<String>(
                    initialValue: handoverType,
                    decoration: const InputDecoration(
                      labelText: 'Handover Type',
                      border: OutlineInputBorder(),
                    ),
                    items: widget.handoverTypes
                        .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => handoverType = value ?? handoverType),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    initialValue: status,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(),
                    ),
                    items: widget.statuses
                        .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => status = value ?? status),
                  ),
                ]),
                _section('2. Dates & Responsibilities', [
                  _dateTile(
                    'Mobilization Start Date',
                    mobilizationStartDate,
                    (value) => setState(() => mobilizationStartDate = value),
                  ),
                  _dateTile(
                    'Final Inspection Date',
                    finalInspectionDate,
                    (value) => setState(() => finalInspectionDate = value),
                  ),
                  _dateTile(
                    'Handover Date',
                    handoverDate,
                    (value) => setState(() => handoverDate = value),
                  ),
                  _dateTile(
                    'Closure Due Date',
                    closureDueDate,
                    (value) => setState(() => closureDueDate = value),
                  ),
                  _dateTile(
                    'Closure Date',
                    closureDate,
                    (value) => setState(() => closureDate = value),
                  ),
                  _field(hseManager, 'HSE Manager'),
                  _field(projectManager, 'Project Manager'),
                  _field(hseReviewer, 'HSE Reviewer'),
                  _field(receivingAuthority, 'Receiving Authority'),
                  _field(approvingManager, 'Approving Manager'),
                ]),
                _section('3. Final HSE Readiness Verification', [
                  _verificationSwitch(
                    '5A Site Setup / Mobilization Master',
                    siteSetupVerified,
                    (value) => setState(() => siteSetupVerified = value),
                  ),
                  _verificationSwitch(
                    '5B Site Facilities & Welfare',
                    facilitiesVerified,
                    (value) => setState(() => facilitiesVerified = value),
                  ),
                  _verificationSwitch(
                    '5C Access & Traffic Management',
                    trafficAccessVerified,
                    (value) => setState(() => trafficAccessVerified = value),
                  ),
                  _verificationSwitch(
                    '5D Temporary Facilities & Utilities',
                    utilitiesVerified,
                    (value) => setState(() => utilitiesVerified = value),
                  ),
                  _verificationSwitch(
                    '5E Emergency & Fire Readiness',
                    emergencyFireVerified,
                    (value) => setState(() => emergencyFireVerified = value),
                  ),
                  _verificationSwitch(
                    '5F Security & Access Control',
                    securityVerified,
                    (value) => setState(() => securityVerified = value),
                  ),
                  _verificationSwitch(
                    'HSE Documents / Records',
                    hseDocumentsVerified,
                    (value) => setState(() => hseDocumentsVerified = value),
                  ),
                  _verificationSwitch(
                    'Risk / RAMS / PTW Readiness',
                    riskRamsPtwVerified,
                    (value) => setState(() => riskRamsPtwVerified = value),
                  ),
                  _verificationSwitch(
                    'Training / Competency Readiness',
                    trainingCompetencyVerified,
                    (value) => setState(() => trainingCompetencyVerified = value),
                  ),
                  _verificationSwitch(
                    'PPE / Welfare Readiness',
                    ppeWelfareVerified,
                    (value) => setState(() => ppeWelfareVerified = value),
                  ),
                  _verificationSwitch(
                    'Environmental Readiness',
                    environmentalVerified,
                    (value) => setState(() => environmentalVerified = value),
                  ),
                  _verificationSwitch(
                    'Inspection / Certificate Readiness',
                    inspectionsCertificatesVerified,
                    (value) =>
                        setState(() => inspectionsCertificatesVerified = value),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    color: primaryGreen.withValues(alpha: 0.08),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          const Icon(Icons.analytics_outlined,
                              color: primaryGreen),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'Overall readiness score',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            '$_readinessScore%',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: darkGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
                _section('4. Findings & Corrective Actions', [
                  _field(
                    finalInspectionFindings,
                    'Final Inspection Findings',
                    maxLines: 4,
                  ),
                  _field(
                    readinessFindings,
                    'Readiness Findings / Gaps',
                    maxLines: 4,
                  ),
                  _field(
                    outstandingActions,
                    'Outstanding Actions',
                    maxLines: 4,
                  ),
                  _field(
                    correctiveActions,
                    'Corrective / Preventive Actions',
                    maxLines: 4,
                  ),
                  _field(actionOwner, 'Action Owner'),
                  _dateTile(
                    'Action Due Date',
                    actionDueDate,
                    (value) => setState(() => actionDueDate = value),
                  ),
                  _field(
                    verificationFindings,
                    'Final Verification Findings',
                    maxLines: 4,
                  ),
                  _field(
                    effectiveness,
                    'Action Effectiveness / Verification',
                    maxLines: 4,
                  ),
                ]),
                _section('5. Acceptance, Approval & Closure', [
                  _field(
                    hseAcceptance,
                    'HSE Acceptance',
                    maxLines: 3,
                  ),
                  _field(
                    projectManagerAcceptance,
                    'Project Manager Acceptance',
                    maxLines: 3,
                  ),
                  _field(
                    managementApproval,
                    'Management Approval',
                    maxLines: 3,
                  ),
                  _field(
                    handoverRemarks,
                    'Handover Remarks',
                    maxLines: 4,
                  ),
                  _field(
                    supportingDocuments,
                    'Supporting Documents / References',
                    maxLines: 3,
                  ),
                  _field(
                    archiveReference,
                    'Archive / Record Reference',
                    maxLines: 2,
                  ),
                  _field(
                    lessonsLearned,
                    'Lessons Learned',
                    maxLines: 4,
                  ),
                ]),
                const SizedBox(height: 8),
                FilledButton.icon(
                  onPressed: _submit,
                  style: FilledButton.styleFrom(
                    backgroundColor: primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  icon: const Icon(Icons.save_outlined),
                  label: Text(
                    widget.existing == null ? 'Save Handover' : 'Update Handover',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 12),
            ...children.expand(
              (widget) => [widget, const SizedBox(height: 10)],
            ),
          ],
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
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: required
          ? (value) {
              if (value == null || value.trim().isEmpty) {
                return '$label is required';
              }
              return null;
            }
          : null,
    );
  }

  Widget _verificationSwitch(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      value: value,
      activeThumbColor: primaryGreen,
      onChanged: onChanged,
    );
  }

  Widget _dateTile(
    String title,
    DateTime? value,
    ValueChanged<DateTime?> setter,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(
        value == null
            ? 'Not selected'
            : '${value.day.toString().padLeft(2, '0')}/'
                '${value.month.toString().padLeft(2, '0')}/${value.year}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null)
            IconButton(
              tooltip: 'Clear',
              onPressed: () => setter(null),
              icon: const Icon(Icons.clear),
            ),
          IconButton(
            tooltip: 'Select date',
            onPressed: () => _pickDate(setter, value),
            icon: const Icon(Icons.calendar_month),
          ),
        ],
      ),
    );
  }
}

class _DetailsSheet extends StatelessWidget {
  final SiteHandoverRecord record;

  const _DetailsSheet({required this.record});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        builder: (_, controller) => ListView(
          controller: controller,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
          children: [
            Text(
              record.recordNo,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0B5D4B),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${record.projectName} • ${record.siteName}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 14),
            _detail('Status', record.status),
            _detail('Handover Type', record.handoverType),
            _detail('Readiness Score', '${record.readinessScore}%'),
            _detail('Location', record.location),
            _detail('Department', record.department),
            _detail('Activity / Area', record.activity),
            _detail('Mobilization Ref.', record.mobilizationRef),
            _detail('5G Readiness Ref.', record.readinessRef),
            _detail('Mobilization Start', _date(record.mobilizationStartDate)),
            _detail('Final Inspection', _date(record.finalInspectionDate)),
            _detail('Handover Date', _date(record.handoverDate)),
            _detail('Closure Due', _date(record.closureDueDate)),
            _detail('Closure Date', _date(record.closureDate)),
            _detail('HSE Manager', record.hseManager),
            _detail('Project Manager', record.projectManager),
            _detail('HSE Reviewer', record.hseReviewer),
            _detail('Receiving Authority', record.receivingAuthority),
            _detail('Approving Manager', record.approvingManager),
            const SizedBox(height: 8),
            const Text(
              'Readiness Verification',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _check('5A Site Setup', record.siteSetupVerified),
            _check('5B Facilities & Welfare', record.facilitiesVerified),
            _check('5C Traffic & Access', record.trafficAccessVerified),
            _check('5D Utilities', record.utilitiesVerified),
            _check('5E Emergency & Fire', record.emergencyFireVerified),
            _check('5F Security', record.securityVerified),
            _check('HSE Documents', record.hseDocumentsVerified),
            _check('Risk / RAMS / PTW', record.riskRamsPtwVerified),
            _check('Training / Competency', record.trainingCompetencyVerified),
            _check('PPE / Welfare', record.ppeWelfareVerified),
            _check('Environmental', record.environmentalVerified),
            _check('Inspections / Certificates',
                record.inspectionsCertificatesVerified),
            const SizedBox(height: 12),
            _detail('Final Inspection Findings', record.finalInspectionFindings),
            _detail('Readiness Findings', record.readinessFindings),
            _detail('Outstanding Actions', record.outstandingActions),
            _detail('Corrective Actions', record.correctiveActions),
            _detail('Action Owner', record.actionOwner),
            _detail('Action Due', _date(record.actionDueDate)),
            _detail('Verification Findings', record.verificationFindings),
            _detail('Effectiveness', record.effectiveness),
            _detail('HSE Acceptance', record.hseAcceptance),
            _detail('Project Manager Acceptance',
                record.projectManagerAcceptance),
            _detail('Management Approval', record.managementApproval),
            _detail('Handover Remarks', record.handoverRemarks),
            _detail('Supporting Documents', record.supportingDocuments),
            _detail('Archive Reference', record.archiveReference),
            _detail('Lessons Learned', record.lessonsLearned),
          ],
        ),
      ),
    );
  }

  Widget _detail(String title, String value) {
    if (value.trim().isEmpty || value == '-') return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 2),
          Text(value),
        ],
      ),
    );
  }

  Widget _check(String title, bool value) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        value ? Icons.check_circle : Icons.cancel_outlined,
        color: value ? const Color(0xFF159447) : Colors.red,
      ),
      title: Text(title),
      trailing: Text(value ? 'Verified' : 'Pending'),
    );
  }

  String _date(DateTime? value) {
    if (value == null) return '-';
    return '${value.day.toString().padLeft(2, '0')}/'
        '${value.month.toString().padLeft(2, '0')}/${value.year}';
  }
}
