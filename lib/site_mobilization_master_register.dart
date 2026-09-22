import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SiteMobilizationRecord {
  final String id;
  final String mobilizationNo;
  final String projectName;
  final String projectCode;
  final String siteLocation;
  final String client;
  final String mainContractor;
  final String subcontractor;
  final String projectManager;
  final String hseManager;
  final String mobilizationType;
  final String status;
  final DateTime plannedStartDate;
  final DateTime? actualStartDate;
  final DateTime? targetReadinessDate;
  final DateTime? readinessDate;
  final String siteDescription;
  final String scopeOfMobilization;
  final String workforcePlan;
  final String siteOfficeStatus;
  final String welfareStatus;
  final String accessStatus;
  final String trafficStatus;
  final String temporaryUtilitiesStatus;
  final String emergencyStatus;
  final String fireSafetyStatus;
  final String securityStatus;
  final String firstAidStatus;
  final String environmentalStatus;
  final String requiredDocuments;
  final String readinessFindings;
  final String correctiveActions;
  final String actionOwner;
  final DateTime? actionDueDate;
  final String approvalRemarks;
  final String approvedBy;
  final DateTime? approvalDate;
  final String remarks;
  final DateTime createdAt;
  final DateTime updatedAt;

  SiteMobilizationRecord({
    required this.id,
    required this.mobilizationNo,
    required this.projectName,
    required this.projectCode,
    required this.siteLocation,
    required this.client,
    required this.mainContractor,
    required this.subcontractor,
    required this.projectManager,
    required this.hseManager,
    required this.mobilizationType,
    required this.status,
    required this.plannedStartDate,
    this.actualStartDate,
    this.targetReadinessDate,
    this.readinessDate,
    required this.siteDescription,
    required this.scopeOfMobilization,
    required this.workforcePlan,
    required this.siteOfficeStatus,
    required this.welfareStatus,
    required this.accessStatus,
    required this.trafficStatus,
    required this.temporaryUtilitiesStatus,
    required this.emergencyStatus,
    required this.fireSafetyStatus,
    required this.securityStatus,
    required this.firstAidStatus,
    required this.environmentalStatus,
    required this.requiredDocuments,
    required this.readinessFindings,
    required this.correctiveActions,
    required this.actionOwner,
    this.actionDueDate,
    required this.approvalRemarks,
    required this.approvedBy,
    this.approvalDate,
    required this.remarks,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'mobilizationNo': mobilizationNo,
        'projectName': projectName,
        'projectCode': projectCode,
        'siteLocation': siteLocation,
        'client': client,
        'mainContractor': mainContractor,
        'subcontractor': subcontractor,
        'projectManager': projectManager,
        'hseManager': hseManager,
        'mobilizationType': mobilizationType,
        'status': status,
        'plannedStartDate': plannedStartDate.toIso8601String(),
        'actualStartDate': actualStartDate?.toIso8601String(),
        'targetReadinessDate': targetReadinessDate?.toIso8601String(),
        'readinessDate': readinessDate?.toIso8601String(),
        'siteDescription': siteDescription,
        'scopeOfMobilization': scopeOfMobilization,
        'workforcePlan': workforcePlan,
        'siteOfficeStatus': siteOfficeStatus,
        'welfareStatus': welfareStatus,
        'accessStatus': accessStatus,
        'trafficStatus': trafficStatus,
        'temporaryUtilitiesStatus': temporaryUtilitiesStatus,
        'emergencyStatus': emergencyStatus,
        'fireSafetyStatus': fireSafetyStatus,
        'securityStatus': securityStatus,
        'firstAidStatus': firstAidStatus,
        'environmentalStatus': environmentalStatus,
        'requiredDocuments': requiredDocuments,
        'readinessFindings': readinessFindings,
        'correctiveActions': correctiveActions,
        'actionOwner': actionOwner,
        'actionDueDate': actionDueDate?.toIso8601String(),
        'approvalRemarks': approvalRemarks,
        'approvedBy': approvedBy,
        'approvalDate': approvalDate?.toIso8601String(),
        'remarks': remarks,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory SiteMobilizationRecord.fromJson(Map<String, dynamic> json) {
    return SiteMobilizationRecord(
      id: json['id'] as String? ?? '',
      mobilizationNo: json['mobilizationNo'] as String? ?? '',
      projectName: json['projectName'] as String? ?? '',
      projectCode: json['projectCode'] as String? ?? '',
      siteLocation: json['siteLocation'] as String? ?? '',
      client: json['client'] as String? ?? '',
      mainContractor: json['mainContractor'] as String? ?? '',
      subcontractor: json['subcontractor'] as String? ?? '',
      projectManager: json['projectManager'] as String? ?? '',
      hseManager: json['hseManager'] as String? ?? '',
      mobilizationType: json['mobilizationType'] as String? ?? '',
      status: json['status'] as String? ?? 'Draft',
      plannedStartDate: DateTime.tryParse(
            json['plannedStartDate'] as String? ?? '',
          ) ??
          DateTime.now(),
      actualStartDate: _parseDate(json['actualStartDate']),
      targetReadinessDate: _parseDate(json['targetReadinessDate']),
      readinessDate: _parseDate(json['readinessDate']),
      siteDescription: json['siteDescription'] as String? ?? '',
      scopeOfMobilization: json['scopeOfMobilization'] as String? ?? '',
      workforcePlan: json['workforcePlan'] as String? ?? '',
      siteOfficeStatus: json['siteOfficeStatus'] as String? ?? 'Not Started',
      welfareStatus: json['welfareStatus'] as String? ?? 'Not Started',
      accessStatus: json['accessStatus'] as String? ?? 'Not Started',
      trafficStatus: json['trafficStatus'] as String? ?? 'Not Started',
      temporaryUtilitiesStatus:
          json['temporaryUtilitiesStatus'] as String? ?? 'Not Started',
      emergencyStatus:
          json['emergencyStatus'] as String? ?? 'Not Started',
      fireSafetyStatus:
          json['fireSafetyStatus'] as String? ?? 'Not Started',
      securityStatus:
          json['securityStatus'] as String? ?? 'Not Started',
      firstAidStatus:
          json['firstAidStatus'] as String? ?? 'Not Started',
      environmentalStatus:
          json['environmentalStatus'] as String? ?? 'Not Started',
      requiredDocuments: json['requiredDocuments'] as String? ?? '',
      readinessFindings: json['readinessFindings'] as String? ?? '',
      correctiveActions: json['correctiveActions'] as String? ?? '',
      actionOwner: json['actionOwner'] as String? ?? '',
      actionDueDate: _parseDate(json['actionDueDate']),
      approvalRemarks: json['approvalRemarks'] as String? ?? '',
      approvedBy: json['approvedBy'] as String? ?? '',
      approvalDate: _parseDate(json['approvalDate']),
      remarks: json['remarks'] as String? ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }
    return null;
  }
}

class SiteMobilizationPage extends StatefulWidget {
  const SiteMobilizationPage({super.key});

  @override
  State<SiteMobilizationPage> createState() => _SiteMobilizationPageState();
}

class _SiteMobilizationPageState extends State<SiteMobilizationPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_site_mobilization_master_register';

  List<SiteMobilizationRecord> _records = [];
  String _search = '';
  String _statusFilter = 'All';

  final List<String> _statuses = const [
    'Draft',
    'Mobilization Planned',
    'In Progress',
    'Readiness Review',
    'HSE Verification',
    'Ready for Mobilization',
    'Mobilized',
    'Action Required',
    'On Hold',
    'Closed',
    'Cancelled',
  ];

  final List<String> _mobilizationTypes = const [
    'New Project Mobilization',
    'Phase Mobilization',
    'Remobilization',
    'Major Site Expansion',
    'Temporary Site Setup',
    'Demobilization / Closeout',
    'Other',
  ];

  final List<String> _readinessStatuses = const [
    'Not Started',
    'In Progress',
    'Ready',
    'Action Required',
    'Not Applicable',
  ];

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);
    if (raw == null || raw.isEmpty) {
      return;
    }

    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      final loaded = decoded
          .whereType<Map<String, dynamic>>()
          .map(SiteMobilizationRecord.fromJson)
          .toList();

      if (mounted) {
        setState(() => _records = loaded);
      }
    } catch (_) {
      // Keep the screen usable if an older/corrupt local record exists.
    }
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      storageKey,
      jsonEncode(_records.map((record) => record.toJson()).toList()),
    );
  }

  List<SiteMobilizationRecord> get _filteredRecords {
    final query = _search.trim().toLowerCase();

    return _records.where((record) {
      final matchesStatus =
          _statusFilter == 'All' || record.status == _statusFilter;

      if (query.isEmpty) {
        return matchesStatus;
      }

      final haystack = [
        record.mobilizationNo,
        record.projectName,
        record.projectCode,
        record.siteLocation,
        record.client,
        record.mainContractor,
        record.hseManager,
        record.mobilizationType,
        record.status,
        record.actionOwner,
      ].join(' ').toLowerCase();

      return matchesStatus && haystack.contains(query);
    }).toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  int _countStatus(String status) {
    return _records.where((record) => record.status == status).length;
  }

  int get _overdueCount {
    final now = DateTime.now();
    return _records.where((record) {
      final due = record.actionDueDate;
      if (due == null) return false;
      if (record.status == 'Closed' || record.status == 'Cancelled') {
        return false;
      }
      return due.isBefore(now);
    }).length;
  }

  int get _readyCount => _records.where((record) {
        return record.status == 'Ready for Mobilization' ||
            record.status == 'Mobilized';
      }).length;

  Future<void> _openForm({SiteMobilizationRecord? existing}) async {
    final result = await showModalBottomSheet<SiteMobilizationRecord>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _SiteMobilizationFormSheet(
        existing: existing,
        statuses: _statuses,
        mobilizationTypes: _mobilizationTypes,
        readinessStatuses: _readinessStatuses,
      ),
    );

    if (result == null) return;

    setState(() {
      final index = _records.indexWhere((item) => item.id == result.id);
      if (index == -1) {
        _records.add(result);
      } else {
        _records[index] = result;
      }
    });

    await _saveRecords();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          existing == null
              ? 'Mobilization record saved.'
              : 'Mobilization record updated.',
        ),
      ),
    );
  }

  Future<void> _deleteRecord(SiteMobilizationRecord record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Record'),
        content: Text(
          'Delete mobilization record ${record.mobilizationNo}?',
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
      _records.removeWhere((item) => item.id == record.id);
    });
    await _saveRecords();
  }

  void _showDetails(SiteMobilizationRecord record) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _DetailsSheet(record: record),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('5A Site Mobilization'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Add mobilization record',
            onPressed: () => _openForm(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add),
        label: const Text('Add Record'),
      ),
      body: RefreshIndicator(
        onRefresh: _loadRecords,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 96),
          children: [
            _buildDashboard(),
            const SizedBox(height: 12),
            _buildSearchAndFilters(),
            const SizedBox(height: 12),
            if (_filteredRecords.isEmpty)
              _buildEmptyState()
            else
              ..._filteredRecords.map(_buildRecordCard),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboard() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _statCard(
                'Total',
                _records.length.toString(),
                Icons.folder_open,
                primaryGreen,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _statCard(
                'In Progress',
                _countStatus('In Progress').toString(),
                Icons.sync,
                Colors.orange,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _statCard(
                'Ready',
                _readyCount.toString(),
                Icons.verified,
                Colors.blue,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _statCard(
                'Overdue',
                _overdueCount.toString(),
                Icons.warning_amber_rounded,
                Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _statCard(
    String title,
    String value,
    IconData icon,
    Color accent,
  ) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Column(
          children: [
            Icon(icon, color: accent, size: 22),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => setState(() => _search = value),
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'No., project, location, contractor...',
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
            DropdownButtonFormField<String>(
              initialValue: _statusFilter,
              decoration: const InputDecoration(
                labelText: 'Status Filter',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(
                  value: 'All',
                  child: Text('All'),
                ),
                ..._statuses.map(
                  (status) => DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  ),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _statusFilter = value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Icon(
              Icons.construction_outlined,
              size: 56,
              color: Colors.grey.shade500,
            ),
            const SizedBox(height: 12),
            const Text(
              'No site mobilization records found.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create the first mobilization record to begin site readiness tracking.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordCard(SiteMobilizationRecord record) {
    final overdue = record.actionDueDate != null &&
        record.actionDueDate!.isBefore(DateTime.now()) &&
        record.status != 'Closed' &&
        record.status != 'Cancelled';

    return Card(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      record.mobilizationNo,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  _statusChip(record.status),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                record.projectName,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              if (record.siteLocation.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text('Location: ${record.siteLocation}'),
              ],
              if (record.mobilizationType.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text('Type: ${record.mobilizationType}'),
              ],
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _miniStatus('Office', record.siteOfficeStatus),
                  _miniStatus('Welfare', record.welfareStatus),
                  _miniStatus('Access', record.accessStatus),
                  _miniStatus('Emergency', record.emergencyStatus),
                ],
              ),
              if (overdue) ...[
                const SizedBox(height: 8),
                const Text(
                  '• OVERDUE ACTION',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Updated ${_formatDate(record.updatedAt)}',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: 'Edit',
                    onPressed: () => _openForm(existing: record),
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  IconButton(
                    tooltip: 'Delete',
                    onPressed: () => _deleteRecord(record),
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusChip(String status) {
    Color color = Colors.grey;
    if (status == 'Mobilized' || status == 'Ready for Mobilization') {
      color = primaryGreen;
    } else if (status == 'In Progress' ||
        status == 'Readiness Review' ||
        status == 'HSE Verification') {
      color = Colors.orange;
    } else if (status == 'Action Required' || status == 'On Hold') {
      color = Colors.red;
    } else if (status == 'Closed') {
      color = Colors.blueGrey;
    }

    return Chip(
      label: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
      backgroundColor: color.withValues(alpha: 0.10),
      side: BorderSide.none,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _miniStatus(String label, String status) {
    final ready = status == 'Ready';
    final action = status == 'Action Required';

    final color = ready
        ? primaryGreen
        : action
            ? Colors.red
            : Colors.grey.shade700;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$label: $status',
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static String _formatDate(DateTime? date) {
    if (date == null) return '-';
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}

class _SiteMobilizationFormSheet extends StatefulWidget {
  final SiteMobilizationRecord? existing;
  final List<String> statuses;
  final List<String> mobilizationTypes;
  final List<String> readinessStatuses;

  const _SiteMobilizationFormSheet({
    required this.existing,
    required this.statuses,
    required this.mobilizationTypes,
    required this.readinessStatuses,
  });

  @override
  State<_SiteMobilizationFormSheet> createState() =>
      _SiteMobilizationFormSheetState();
}

class _SiteMobilizationFormSheetState
    extends State<_SiteMobilizationFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final Map<String, TextEditingController> _controllers = {};

  late String _status;
  late String _mobilizationType;
  late String _siteOfficeStatus;
  late String _welfareStatus;
  late String _accessStatus;
  late String _trafficStatus;
  late String _temporaryUtilitiesStatus;
  late String _emergencyStatus;
  late String _fireSafetyStatus;
  late String _securityStatus;
  late String _firstAidStatus;
  late String _environmentalStatus;

  late DateTime _plannedStartDate;
  DateTime? _actualStartDate;
  DateTime? _targetReadinessDate;
  DateTime? _readinessDate;
  DateTime? _actionDueDate;
  DateTime? _approvalDate;

  bool _saving = false;

  final List<String> _textFields = const [
    'mobilizationNo',
    'projectName',
    'projectCode',
    'siteLocation',
    'client',
    'mainContractor',
    'subcontractor',
    'projectManager',
    'hseManager',
    'siteDescription',
    'scopeOfMobilization',
    'workforcePlan',
    'requiredDocuments',
    'readinessFindings',
    'correctiveActions',
    'actionOwner',
    'approvalRemarks',
    'approvedBy',
    'remarks',
  ];

  @override
  void initState() {
    super.initState();

    for (final field in _textFields) {
      _controllers[field] = TextEditingController();
    }

    final record = widget.existing;

    if (record == null) {
      _status = 'Draft';
      _mobilizationType = widget.mobilizationTypes.first;
      _siteOfficeStatus = 'Not Started';
      _welfareStatus = 'Not Started';
      _accessStatus = 'Not Started';
      _trafficStatus = 'Not Started';
      _temporaryUtilitiesStatus = 'Not Started';
      _emergencyStatus = 'Not Started';
      _fireSafetyStatus = 'Not Started';
      _securityStatus = 'Not Started';
      _firstAidStatus = 'Not Started';
      _environmentalStatus = 'Not Started';
      _plannedStartDate = DateTime.now();
    } else {
      _setText('mobilizationNo', record.mobilizationNo);
      _setText('projectName', record.projectName);
      _setText('projectCode', record.projectCode);
      _setText('siteLocation', record.siteLocation);
      _setText('client', record.client);
      _setText('mainContractor', record.mainContractor);
      _setText('subcontractor', record.subcontractor);
      _setText('projectManager', record.projectManager);
      _setText('hseManager', record.hseManager);
      _setText('siteDescription', record.siteDescription);
      _setText('scopeOfMobilization', record.scopeOfMobilization);
      _setText('workforcePlan', record.workforcePlan);
      _setText('requiredDocuments', record.requiredDocuments);
      _setText('readinessFindings', record.readinessFindings);
      _setText('correctiveActions', record.correctiveActions);
      _setText('actionOwner', record.actionOwner);
      _setText('approvalRemarks', record.approvalRemarks);
      _setText('approvedBy', record.approvedBy);
      _setText('remarks', record.remarks);

      _status = widget.statuses.contains(record.status)
          ? record.status
          : widget.statuses.first;
      _mobilizationType =
          widget.mobilizationTypes.contains(record.mobilizationType)
              ? record.mobilizationType
              : widget.mobilizationTypes.first;

      _siteOfficeStatus = _safeReadiness(record.siteOfficeStatus);
      _welfareStatus = _safeReadiness(record.welfareStatus);
      _accessStatus = _safeReadiness(record.accessStatus);
      _trafficStatus = _safeReadiness(record.trafficStatus);
      _temporaryUtilitiesStatus =
          _safeReadiness(record.temporaryUtilitiesStatus);
      _emergencyStatus = _safeReadiness(record.emergencyStatus);
      _fireSafetyStatus = _safeReadiness(record.fireSafetyStatus);
      _securityStatus = _safeReadiness(record.securityStatus);
      _firstAidStatus = _safeReadiness(record.firstAidStatus);
      _environmentalStatus = _safeReadiness(record.environmentalStatus);

      _plannedStartDate = record.plannedStartDate;
      _actualStartDate = record.actualStartDate;
      _targetReadinessDate = record.targetReadinessDate;
      _readinessDate = record.readinessDate;
      _actionDueDate = record.actionDueDate;
      _approvalDate = record.approvalDate;
    }
  }

  String _safeReadiness(String value) {
    return widget.readinessStatuses.contains(value)
        ? value
        : widget.readinessStatuses.first;
  }

  void _setText(String key, String value) {
    _controllers[key]?.text = value;
  }

  String _text(String key) => _controllers[key]?.text.trim() ?? '';

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDate({
    required DateTime? current,
    required ValueChanged<DateTime> onPicked,
    DateTime? firstDate,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: current ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      onPicked(picked);
    }
  }

  void _save() {
    if (_saving) return;

    final no = _text('mobilizationNo');
    final project = _text('projectName');
    final location = _text('siteLocation');
    final hseManager = _text('hseManager');

    if (no.isEmpty || project.isEmpty || location.isEmpty) {
      _showError('Mobilization No., Project Name and Site Location are required.');
      return;
    }

    if (hseManager.isEmpty) {
      _showError('HSE Manager / Responsible HSE Person is required.');
      return;
    }

    if (_actualStartDate != null &&
        _actualStartDate!.isBefore(_plannedStartDate)) {
      _showError('Actual start date cannot be before planned start date.');
      return;
    }

    if (_readinessDate != null &&
        _targetReadinessDate != null &&
        _readinessDate!.isBefore(_targetReadinessDate!)) {
      _showError('Readiness date cannot be before target readiness date.');
      return;
    }

    if (_actionDueDate != null &&
        _actionDueDate!.isBefore(_plannedStartDate)) {
      _showError('Action due date cannot be before planned start date.');
      return;
    }

    if ((_status == 'Ready for Mobilization' || _status == 'Mobilized') &&
        !_allReadinessReady()) {
      _showError(
        'All applicable site readiness checks should be Ready before this status.',
      );
      return;
    }

    if (_status == 'HSE Verification' &&
        _text('readinessFindings').isEmpty &&
        !_allReadinessReady()) {
      _showError(
        'Complete readiness findings or mark all readiness checks Ready.',
      );
      return;
    }

    if (_status == 'Action Required' &&
        _text('correctiveActions').isEmpty) {
      _showError('Corrective Action is required for Action Required status.');
      return;
    }

    if (_status == 'Closed' && _text('approvedBy').isEmpty) {
      _showError('Approved By is required before closing the record.');
      return;
    }

    setState(() => _saving = true);

    final now = DateTime.now();
    final existing = widget.existing;

    final record = SiteMobilizationRecord(
      id: existing?.id ?? now.microsecondsSinceEpoch.toString(),
      mobilizationNo: no,
      projectName: project,
      projectCode: _text('projectCode'),
      siteLocation: location,
      client: _text('client'),
      mainContractor: _text('mainContractor'),
      subcontractor: _text('subcontractor'),
      projectManager: _text('projectManager'),
      hseManager: hseManager,
      mobilizationType: _mobilizationType,
      status: _status,
      plannedStartDate: _plannedStartDate,
      actualStartDate: _actualStartDate,
      targetReadinessDate: _targetReadinessDate,
      readinessDate: _readinessDate,
      siteDescription: _text('siteDescription'),
      scopeOfMobilization: _text('scopeOfMobilization'),
      workforcePlan: _text('workforcePlan'),
      siteOfficeStatus: _siteOfficeStatus,
      welfareStatus: _welfareStatus,
      accessStatus: _accessStatus,
      trafficStatus: _trafficStatus,
      temporaryUtilitiesStatus: _temporaryUtilitiesStatus,
      emergencyStatus: _emergencyStatus,
      fireSafetyStatus: _fireSafetyStatus,
      securityStatus: _securityStatus,
      firstAidStatus: _firstAidStatus,
      environmentalStatus: _environmentalStatus,
      requiredDocuments: _text('requiredDocuments'),
      readinessFindings: _text('readinessFindings'),
      correctiveActions: _text('correctiveActions'),
      actionOwner: _text('actionOwner'),
      actionDueDate: _actionDueDate,
      approvalRemarks: _text('approvalRemarks'),
      approvedBy: _text('approvedBy'),
      approvalDate: _approvalDate,
      remarks: _text('remarks'),
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );

    Navigator.pop(context, record);
  }

  bool _allReadinessReady() {
    final values = [
      _siteOfficeStatus,
      _welfareStatus,
      _accessStatus,
      _trafficStatus,
      _temporaryUtilitiesStatus,
      _emergencyStatus,
      _fireSafetyStatus,
      _securityStatus,
      _firstAidStatus,
      _environmentalStatus,
    ];

    return values.every((value) => value == 'Ready' || value == 'Not Applicable');
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _sectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: primaryGreen, size: 21),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: darkGreen,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(
    String key,
    String label, {
    bool required = false,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: _controllers[key],
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _dropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _dateField(
    String label,
    DateTime? value,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            suffixIcon: const Icon(Icons.calendar_today_outlined),
          ),
          child: Text(
            _formatDate(value),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  static String _formatDate(DateTime? date) {
    if (date == null) return 'Select date';
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  Widget _readinessDropdown(
    String label,
    String value,
    ValueChanged<String?> onChanged,
  ) {
    return _dropdown(
      label: label,
      value: value,
      items: widget.readinessStatuses,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewInsetsOf(context).bottom;

    return SafeArea(
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.94,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 42,
              height: 5,
              margin: const EdgeInsets.only(top: 10, bottom: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 10, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Site Mobilization Master Register',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
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
              child: ListView(
                padding: EdgeInsets.fromLTRB(16, 0, 16, bottom + 20),
                children: [
                  _sectionTitle('Project & Mobilization', Icons.apartment),
                  _field('mobilizationNo', 'Mobilization No.', required: true),
                  _field('projectName', 'Project Name', required: true),
                  _field('projectCode', 'Project Code'),
                  _field('siteLocation', 'Site Location', required: true),
                  _field('client', 'Client'),
                  _field('mainContractor', 'Main Contractor'),
                  _field('subcontractor', 'Subcontractor'),
                  _field('projectManager', 'Project Manager'),
                  _field('hseManager', 'HSE Manager / Responsible HSE Person',
                      required: true),
                  _dropdown(
                    label: 'Mobilization Type',
                    value: _mobilizationType,
                    items: widget.mobilizationTypes,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _mobilizationType = value);
                      }
                    },
                  ),
                  _dropdown(
                    label: 'Status',
                    value: _status,
                    items: widget.statuses,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _status = value);
                      }
                    },
                  ),
                  _dateField(
                    'Planned Mobilization Start',
                    _plannedStartDate,
                    () => _pickDate(
                      current: _plannedStartDate,
                      onPicked: (date) =>
                          setState(() => _plannedStartDate = date),
                    ),
                  ),
                  _dateField(
                    'Actual Mobilization Start',
                    _actualStartDate,
                    () => _pickDate(
                      current: _actualStartDate,
                      onPicked: (date) =>
                          setState(() => _actualStartDate = date),
                    ),
                  ),
                  _dateField(
                    'Target Readiness Date',
                    _targetReadinessDate,
                    () => _pickDate(
                      current: _targetReadinessDate,
                      onPicked: (date) =>
                          setState(() => _targetReadinessDate = date),
                    ),
                  ),
                  _dateField(
                    'Readiness Verification Date',
                    _readinessDate,
                    () => _pickDate(
                      current: _readinessDate,
                      onPicked: (date) =>
                          setState(() => _readinessDate = date),
                    ),
                  ),
                  _field(
                    'siteDescription',
                    'Site Description',
                    maxLines: 3,
                  ),
                  _field(
                    'scopeOfMobilization',
                    'Scope of Mobilization',
                    maxLines: 4,
                  ),
                  _field(
                    'workforcePlan',
                    'Initial Workforce / Manpower Plan',
                    maxLines: 3,
                  ),
                  _field(
                    'requiredDocuments',
                    'Required HSE / Site Documents',
                    maxLines: 4,
                  ),
                  _sectionTitle(
                    'Site Readiness',
                    Icons.checklist_rtl,
                  ),
                  _readinessDropdown(
                    'Site Office / Administration',
                    _siteOfficeStatus,
                    (value) {
                      if (value != null) {
                        setState(() => _siteOfficeStatus = value);
                      }
                    },
                  ),
                  _readinessDropdown(
                    'Welfare Facilities',
                    _welfareStatus,
                    (value) {
                      if (value != null) {
                        setState(() => _welfareStatus = value);
                      }
                    },
                  ),
                  _readinessDropdown(
                    'Site Access / Entry',
                    _accessStatus,
                    (value) {
                      if (value != null) {
                        setState(() => _accessStatus = value);
                      }
                    },
                  ),
                  _readinessDropdown(
                    'Traffic Management',
                    _trafficStatus,
                    (value) {
                      if (value != null) {
                        setState(() => _trafficStatus = value);
                      }
                    },
                  ),
                  _readinessDropdown(
                    'Temporary Utilities',
                    _temporaryUtilitiesStatus,
                    (value) {
                      if (value != null) {
                        setState(
                          () => _temporaryUtilitiesStatus = value,
                        );
                      }
                    },
                  ),
                  _readinessDropdown(
                    'Emergency Preparedness',
                    _emergencyStatus,
                    (value) {
                      if (value != null) {
                        setState(() => _emergencyStatus = value);
                      }
                    },
                  ),
                  _readinessDropdown(
                    'Fire Safety',
                    _fireSafetyStatus,
                    (value) {
                      if (value != null) {
                        setState(() => _fireSafetyStatus = value);
                      }
                    },
                  ),
                  _readinessDropdown(
                    'Site Security',
                    _securityStatus,
                    (value) {
                      if (value != null) {
                        setState(() => _securityStatus = value);
                      }
                    },
                  ),
                  _readinessDropdown(
                    'First Aid / Medical',
                    _firstAidStatus,
                    (value) {
                      if (value != null) {
                        setState(() => _firstAidStatus = value);
                      }
                    },
                  ),
                  _readinessDropdown(
                    'Environmental Controls',
                    _environmentalStatus,
                    (value) {
                      if (value != null) {
                        setState(() => _environmentalStatus = value);
                      }
                    },
                  ),
                  _sectionTitle(
                    'Readiness Findings & Actions',
                    Icons.fact_check_outlined,
                  ),
                  _field(
                    'readinessFindings',
                    'Readiness Findings',
                    maxLines: 4,
                  ),
                  _field(
                    'correctiveActions',
                    'Corrective Actions',
                    maxLines: 4,
                  ),
                  _field('actionOwner', 'Action Owner'),
                  _dateField(
                    'Action Due Date',
                    _actionDueDate,
                    () => _pickDate(
                      current: _actionDueDate,
                      onPicked: (date) =>
                          setState(() => _actionDueDate = date),
                    ),
                  ),
                  _sectionTitle(
                    'Approval & Handover',
                    Icons.verified_outlined,
                  ),
                  _field('approvedBy', 'Approved / Verified By'),
                  _dateField(
                    'Approval / Verification Date',
                    _approvalDate,
                    () => _pickDate(
                      current: _approvalDate,
                      onPicked: (date) =>
                          setState(() => _approvalDate = date),
                    ),
                  ),
                  _field(
                    'approvalRemarks',
                    'Approval / Handover Remarks',
                    maxLines: 3,
                  ),
                  _field('remarks', 'Additional Remarks', maxLines: 4),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 50,
                    child: FilledButton.icon(
                      onPressed: _saving ? null : _save,
                      icon: const Icon(Icons.save_outlined),
                      label: Text(
                        _saving ? 'Saving...' : 'Save Mobilization Record',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailsSheet extends StatelessWidget {
  final SiteMobilizationRecord record;

  const _DetailsSheet({required this.record});

  static const Color darkGreen = Color(0xFF0B5D4B);

  @override
  Widget build(BuildContext context) {
    final items = <String, String>{
      'Mobilization No.': record.mobilizationNo,
      'Project': record.projectName,
      'Project Code': record.projectCode,
      'Location': record.siteLocation,
      'Client': record.client,
      'Main Contractor': record.mainContractor,
      'Subcontractor': record.subcontractor,
      'Project Manager': record.projectManager,
      'HSE Manager': record.hseManager,
      'Mobilization Type': record.mobilizationType,
      'Status': record.status,
      'Planned Start': _formatDate(record.plannedStartDate),
      'Actual Start': _formatDate(record.actualStartDate),
      'Target Readiness': _formatDate(record.targetReadinessDate),
      'Readiness Date': _formatDate(record.readinessDate),
      'Site Office': record.siteOfficeStatus,
      'Welfare': record.welfareStatus,
      'Access': record.accessStatus,
      'Traffic': record.trafficStatus,
      'Temporary Utilities': record.temporaryUtilitiesStatus,
      'Emergency': record.emergencyStatus,
      'Fire Safety': record.fireSafetyStatus,
      'Security': record.securityStatus,
      'First Aid / Medical': record.firstAidStatus,
      'Environmental': record.environmentalStatus,
      'Readiness Findings': record.readinessFindings,
      'Corrective Actions': record.correctiveActions,
      'Action Owner': record.actionOwner,
      'Action Due': _formatDate(record.actionDueDate),
      'Approved / Verified By': record.approvedBy,
      'Approval Date': _formatDate(record.approvalDate),
      'Approval Remarks': record.approvalRemarks,
      'Remarks': record.remarks,
      'Created': _formatDateTime(record.createdAt),
      'Updated': _formatDateTime(record.updatedAt),
    };

    return SafeArea(
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.88,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Mobilization Details',
                      style: const TextStyle(
                        color: darkGreen,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                itemCount: items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, index) {
                  final entry = items.entries.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 145,
                          child: Text(
                            entry.key,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            entry.value.isEmpty ? '-' : entry.value,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _formatDate(DateTime? date) {
    if (date == null) return '-';
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  static String _formatDateTime(DateTime date) {
    return '${_formatDate(date)} ${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }
}
