import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SiteAccessTrafficRecord {
  final String id;
  final String recordNo;
  final String projectName;
  final String projectCode;
  final String siteLocation;
  final String accessType;
  final String routeName;
  final String status;
  final String trafficManagementType;
  final String responsiblePerson;
  final String trafficMarshal;
  final String securityContact;
  final String emergencyContact;
  final String vehicleRoute;
  final String pedestrianRoute;
  final String entryPoint;
  final String exitPoint;
  final String speedLimit;
  final String roadCondition;
  final String visibility;
  final String lighting;
  final String signage;
  final String barricading;
  final String pedestrianProtection;
  final String vehicleSegregation;
  final String parkingArea;
  final String loadingArea;
  final String reversingControls;
  final String banksmanControl;
  final String deliveryControl;
  final String visitorControl;
  final String emergencyAccess;
  final String fireAccess;
  final String disabledAccess;
  final String vehicleInspection;
  final String trafficPlanReference;
  final String riskAssessmentReference;
  final String methodStatementReference;
  final DateTime? plannedInspectionDate;
  final DateTime? lastInspectionDate;
  final DateTime? nextInspectionDate;
  final DateTime? readinessDate;
  final String inspectionFindings;
  final String hazards;
  final String correctiveActions;
  final String actionOwner;
  final DateTime? actionDueDate;
  final String verificationRemarks;
  final String verifiedBy;
  final DateTime? verificationDate;
  final String approvalRemarks;
  final String approvedBy;
  final DateTime? approvalDate;
  final String supportingDocuments;
  final String remarks;
  final DateTime createdAt;
  final DateTime updatedAt;

  SiteAccessTrafficRecord({
    required this.id,
    required this.recordNo,
    required this.projectName,
    required this.projectCode,
    required this.siteLocation,
    required this.accessType,
    required this.routeName,
    required this.status,
    required this.trafficManagementType,
    required this.responsiblePerson,
    required this.trafficMarshal,
    required this.securityContact,
    required this.emergencyContact,
    required this.vehicleRoute,
    required this.pedestrianRoute,
    required this.entryPoint,
    required this.exitPoint,
    required this.speedLimit,
    required this.roadCondition,
    required this.visibility,
    required this.lighting,
    required this.signage,
    required this.barricading,
    required this.pedestrianProtection,
    required this.vehicleSegregation,
    required this.parkingArea,
    required this.loadingArea,
    required this.reversingControls,
    required this.banksmanControl,
    required this.deliveryControl,
    required this.visitorControl,
    required this.emergencyAccess,
    required this.fireAccess,
    required this.disabledAccess,
    required this.vehicleInspection,
    required this.trafficPlanReference,
    required this.riskAssessmentReference,
    required this.methodStatementReference,
    this.plannedInspectionDate,
    this.lastInspectionDate,
    this.nextInspectionDate,
    this.readinessDate,
    required this.inspectionFindings,
    required this.hazards,
    required this.correctiveActions,
    required this.actionOwner,
    this.actionDueDate,
    required this.verificationRemarks,
    required this.verifiedBy,
    this.verificationDate,
    required this.approvalRemarks,
    required this.approvedBy,
    this.approvalDate,
    required this.supportingDocuments,
    required this.remarks,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'recordNo': recordNo,
        'projectName': projectName,
        'projectCode': projectCode,
        'siteLocation': siteLocation,
        'accessType': accessType,
        'routeName': routeName,
        'status': status,
        'trafficManagementType': trafficManagementType,
        'responsiblePerson': responsiblePerson,
        'trafficMarshal': trafficMarshal,
        'securityContact': securityContact,
        'emergencyContact': emergencyContact,
        'vehicleRoute': vehicleRoute,
        'pedestrianRoute': pedestrianRoute,
        'entryPoint': entryPoint,
        'exitPoint': exitPoint,
        'speedLimit': speedLimit,
        'roadCondition': roadCondition,
        'visibility': visibility,
        'lighting': lighting,
        'signage': signage,
        'barricading': barricading,
        'pedestrianProtection': pedestrianProtection,
        'vehicleSegregation': vehicleSegregation,
        'parkingArea': parkingArea,
        'loadingArea': loadingArea,
        'reversingControls': reversingControls,
        'banksmanControl': banksmanControl,
        'deliveryControl': deliveryControl,
        'visitorControl': visitorControl,
        'emergencyAccess': emergencyAccess,
        'fireAccess': fireAccess,
        'disabledAccess': disabledAccess,
        'vehicleInspection': vehicleInspection,
        'trafficPlanReference': trafficPlanReference,
        'riskAssessmentReference': riskAssessmentReference,
        'methodStatementReference': methodStatementReference,
        'plannedInspectionDate': plannedInspectionDate?.toIso8601String(),
        'lastInspectionDate': lastInspectionDate?.toIso8601String(),
        'nextInspectionDate': nextInspectionDate?.toIso8601String(),
        'readinessDate': readinessDate?.toIso8601String(),
        'inspectionFindings': inspectionFindings,
        'hazards': hazards,
        'correctiveActions': correctiveActions,
        'actionOwner': actionOwner,
        'actionDueDate': actionDueDate?.toIso8601String(),
        'verificationRemarks': verificationRemarks,
        'verifiedBy': verifiedBy,
        'verificationDate': verificationDate?.toIso8601String(),
        'approvalRemarks': approvalRemarks,
        'approvedBy': approvedBy,
        'approvalDate': approvalDate?.toIso8601String(),
        'supportingDocuments': supportingDocuments,
        'remarks': remarks,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory SiteAccessTrafficRecord.fromJson(Map<String, dynamic> json) {
    return SiteAccessTrafficRecord(
      id: json['id'] as String? ?? '',
      recordNo: json['recordNo'] as String? ?? '',
      projectName: json['projectName'] as String? ?? '',
      projectCode: json['projectCode'] as String? ?? '',
      siteLocation: json['siteLocation'] as String? ?? '',
      accessType: json['accessType'] as String? ?? 'Site Access',
      routeName: json['routeName'] as String? ?? '',
      status: json['status'] as String? ?? 'Draft',
      trafficManagementType:
          json['trafficManagementType'] as String? ?? 'General Site Traffic',
      responsiblePerson: json['responsiblePerson'] as String? ?? '',
      trafficMarshal: json['trafficMarshal'] as String? ?? '',
      securityContact: json['securityContact'] as String? ?? '',
      emergencyContact: json['emergencyContact'] as String? ?? '',
      vehicleRoute: json['vehicleRoute'] as String? ?? '',
      pedestrianRoute: json['pedestrianRoute'] as String? ?? '',
      entryPoint: json['entryPoint'] as String? ?? '',
      exitPoint: json['exitPoint'] as String? ?? '',
      speedLimit: json['speedLimit'] as String? ?? '',
      roadCondition: json['roadCondition'] as String? ?? 'Not Inspected',
      visibility: json['visibility'] as String? ?? 'Not Inspected',
      lighting: json['lighting'] as String? ?? 'Not Applicable',
      signage: json['signage'] as String? ?? 'Not Inspected',
      barricading: json['barricading'] as String? ?? 'Not Applicable',
      pedestrianProtection:
          json['pedestrianProtection'] as String? ?? 'Not Applicable',
      vehicleSegregation:
          json['vehicleSegregation'] as String? ?? 'Not Applicable',
      parkingArea: json['parkingArea'] as String? ?? 'Not Applicable',
      loadingArea: json['loadingArea'] as String? ?? 'Not Applicable',
      reversingControls:
          json['reversingControls'] as String? ?? 'Not Applicable',
      banksmanControl:
          json['banksmanControl'] as String? ?? 'Not Applicable',
      deliveryControl:
          json['deliveryControl'] as String? ?? 'Not Applicable',
      visitorControl:
          json['visitorControl'] as String? ?? 'Not Applicable',
      emergencyAccess:
          json['emergencyAccess'] as String? ?? 'Not Applicable',
      fireAccess: json['fireAccess'] as String? ?? 'Not Applicable',
      disabledAccess:
          json['disabledAccess'] as String? ?? 'Not Applicable',
      vehicleInspection:
          json['vehicleInspection'] as String? ?? 'Not Applicable',
      trafficPlanReference:
          json['trafficPlanReference'] as String? ?? '',
      riskAssessmentReference:
          json['riskAssessmentReference'] as String? ?? '',
      methodStatementReference:
          json['methodStatementReference'] as String? ?? '',
      plannedInspectionDate:
          _parseDate(json['plannedInspectionDate']),
      lastInspectionDate: _parseDate(json['lastInspectionDate']),
      nextInspectionDate: _parseDate(json['nextInspectionDate']),
      readinessDate: _parseDate(json['readinessDate']),
      inspectionFindings:
          json['inspectionFindings'] as String? ?? '',
      hazards: json['hazards'] as String? ?? '',
      correctiveActions:
          json['correctiveActions'] as String? ?? '',
      actionOwner: json['actionOwner'] as String? ?? '',
      actionDueDate: _parseDate(json['actionDueDate']),
      verificationRemarks:
          json['verificationRemarks'] as String? ?? '',
      verifiedBy: json['verifiedBy'] as String? ?? '',
      verificationDate: _parseDate(json['verificationDate']),
      approvalRemarks: json['approvalRemarks'] as String? ?? '',
      approvedBy: json['approvedBy'] as String? ?? '',
      approvalDate: _parseDate(json['approvalDate']),
      supportingDocuments:
          json['supportingDocuments'] as String? ?? '',
      remarks: json['remarks'] as String? ?? '',
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updatedAt'] as String? ?? '') ??
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

class SiteAccessTrafficPage extends StatefulWidget {
  const SiteAccessTrafficPage({super.key});

  @override
  State<SiteAccessTrafficPage> createState() => _SiteAccessTrafficPageState();
}

class _SiteAccessTrafficPageState extends State<SiteAccessTrafficPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_site_access_traffic_management';

  final List<String> _statuses = const [
    'Draft',
    'Plan Required',
    'Setup In Progress',
    'Inspection Required',
    'Action Required',
    'HSE Verification',
    'Ready',
    'Approved',
    'Operational',
    'On Hold',
    'Closed',
    'Cancelled',
  ];

  final List<String> _accessTypes = const [
    'Main Site Access',
    'Secondary Access',
    'Emergency Access',
    'Vehicle Access',
    'Pedestrian Access',
    'Delivery Access',
    'Construction Access',
    'Temporary Access',
    'Restricted Access',
    'Other',
  ];

  final List<String> _trafficTypes = const [
    'General Site Traffic',
    'Construction Traffic',
    'Heavy Vehicle Traffic',
    'Delivery / Logistics',
    'Pedestrian & Vehicle Segregation',
    'Public Interface',
    'Emergency Route',
    'Temporary Traffic Management',
    'Other',
  ];

  final List<String> _conditionOptions = const [
    'Not Inspected',
    'Good',
    'Acceptable',
    'Needs Improvement',
    'Unsatisfactory',
    'Not Applicable',
  ];

  final List<String> _readinessOptions = const [
    'Ready',
    'Partially Ready',
    'Not Ready',
    'Not Applicable',
  ];

  final List<String> _speedLimits = const [
    '10 km/h',
    '15 km/h',
    '20 km/h',
    '25 km/h',
    '30 km/h',
    '40 km/h',
    '50 km/h',
    'Other',
  ];

  final List<String> _frequencies = const [
    'Daily',
    'Weekly',
    'Biweekly',
    'Monthly',
    'As Required',
    'Not Applicable',
  ];

  List<SiteAccessTrafficRecord> _records = [];
  String _search = '';
  String _statusFilter = 'All';

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);
    if (raw == null || raw.isEmpty) return;

    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      final loaded = decoded
          .whereType<Map<String, dynamic>>()
          .map(SiteAccessTrafficRecord.fromJson)
          .toList();

      if (mounted) {
        setState(() => _records = loaded);
      }
    } catch (_) {
      // Keep the page usable if local data is invalid.
    }
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      storageKey,
      jsonEncode(_records.map((item) => item.toJson()).toList()),
    );
  }

  List<SiteAccessTrafficRecord> get _filteredRecords {
    final query = _search.trim().toLowerCase();

    final filtered = _records.where((record) {
      if (_statusFilter != 'All' &&
          record.status != _statusFilter) {
        return false;
      }

      if (query.isEmpty) return true;

      final haystack = [
        record.recordNo,
        record.projectName,
        record.projectCode,
        record.siteLocation,
        record.accessType,
        record.routeName,
        record.trafficManagementType,
        record.responsiblePerson,
        record.trafficMarshal,
        record.status,
      ].join(' ').toLowerCase();

      return haystack.contains(query);
    }).toList();

    filtered.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return filtered;
  }

  int get _readyCount => _records.where((record) {
        return record.status == 'Ready' ||
            record.status == 'Approved' ||
            record.status == 'Operational';
      }).length;

  int get _actionCount =>
      _records.where((record) => record.status == 'Action Required').length;

  int get _inspectionCount => _records.where((record) {
        return record.status == 'Inspection Required' ||
            record.status == 'HSE Verification';
      }).length;

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

  Future<void> _openForm({
    SiteAccessTrafficRecord? existing,
  }) async {
    final result = await showModalBottomSheet<SiteAccessTrafficRecord>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AccessTrafficFormSheet(
        existing: existing,
        statuses: _statuses,
        accessTypes: _accessTypes,
        trafficTypes: _trafficTypes,
        conditionOptions: _conditionOptions,
        readinessOptions: _readinessOptions,
        speedLimits: _speedLimits,
        frequencies: _frequencies,
      ),
    );

    if (result == null) return;

    setState(() {
      final index =
          _records.indexWhere((item) => item.id == result.id);
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
              ? 'Access and traffic record saved.'
              : 'Access and traffic record updated.',
        ),
      ),
    );
  }

  Future<void> _deleteRecord(
    SiteAccessTrafficRecord record,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Record'),
        content: Text(
          'Delete access/traffic record ${record.recordNo}?',
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(dialogContext, true),
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

  void _showDetails(SiteAccessTrafficRecord record) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          _AccessTrafficDetailsSheet(record: record),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('5C Site Access & Traffic'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Add record',
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
            _dashboard(),
            const SizedBox(height: 12),
            _searchAndFilter(),
            const SizedBox(height: 12),
            if (_filteredRecords.isEmpty)
              _emptyState()
            else
              ..._filteredRecords.map(_recordCard),
          ],
        ),
      ),
    );
  }

  Widget _dashboard() {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            'Total',
            _records.length.toString(),
            Icons.alt_route,
            primaryGreen,
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
            'Inspection',
            _inspectionCount.toString(),
            Icons.search,
            Colors.orange,
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
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 11,
        ),
        child: Column(
          children: [
            Icon(icon, color: accent, size: 21),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchAndFilter() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              onChanged: (value) =>
                  setState(() => _search = value),
              decoration: InputDecoration(
                labelText: 'Search',
                hintText:
                    'No., project, route, location, person...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _search.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () =>
                            setState(() => _search = ''),
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

  Widget _emptyState() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Icon(
              Icons.traffic_outlined,
              size: 56,
              color: Colors.grey.shade500,
            ),
            const SizedBox(height: 12),
            const Text(
              'No access or traffic records found.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create a record to manage site access, vehicle routes and pedestrian safety.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _recordCard(SiteAccessTrafficRecord record) {
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
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      record.recordNo,
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
                record.routeName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(record.accessType),
              const SizedBox(height: 4),
              Text('Project: ${record.projectName}'),
              if (record.siteLocation.isNotEmpty)
                Text('Location: ${record.siteLocation}'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _miniStatus(
                    'Road',
                    record.roadCondition,
                  ),
                  _miniStatus(
                    'Signage',
                    record.signage,
                  ),
                  _miniStatus(
                    'Pedestrian',
                    record.pedestrianProtection,
                  ),
                  _miniStatus(
                    'Segregation',
                    record.vehicleSegregation,
                  ),
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
              const SizedBox(height: 8),
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
                    onPressed: () =>
                        _openForm(existing: record),
                    icon: const Icon(
                      Icons.edit_outlined,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Delete',
                    onPressed: () =>
                        _deleteRecord(record),
                    icon: const Icon(
                      Icons.delete_outline,
                    ),
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

    if (status == 'Ready' ||
        status == 'Approved' ||
        status == 'Operational') {
      color = primaryGreen;
    } else if (status == 'Inspection Required' ||
        status == 'HSE Verification' ||
        status == 'Setup In Progress') {
      color = Colors.orange;
    } else if (status == 'Action Required' ||
        status == 'On Hold') {
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
          fontSize: 10.5,
        ),
      ),
      backgroundColor:
          color.withValues(alpha: 0.10),
      side: BorderSide.none,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _miniStatus(String label, String status) {
    final positive = status == 'Ready' ||
        status == 'Good' ||
        status == 'Acceptable';
    final negative = status == 'Not Ready' ||
        status == 'Unsatisfactory' ||
        status == 'Needs Improvement';

    final color = positive
        ? primaryGreen
        : negative
            ? Colors.red
            : Colors.grey.shade700;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$label: $status',
        style: TextStyle(
          color: color,
          fontSize: 10.5,
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

class _AccessTrafficFormSheet extends StatefulWidget {
  final SiteAccessTrafficRecord? existing;
  final List<String> statuses;
  final List<String> accessTypes;
  final List<String> trafficTypes;
  final List<String> conditionOptions;
  final List<String> readinessOptions;
  final List<String> speedLimits;
  final List<String> frequencies;

  const _AccessTrafficFormSheet({
    required this.existing,
    required this.statuses,
    required this.accessTypes,
    required this.trafficTypes,
    required this.conditionOptions,
    required this.readinessOptions,
    required this.speedLimits,
    required this.frequencies,
  });

  @override
  State<_AccessTrafficFormSheet> createState() =>
      _AccessTrafficFormSheetState();
}

class _AccessTrafficFormSheetState
    extends State<_AccessTrafficFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final Map<String, TextEditingController> _controllers =
      {};

  late String _status;
  late String _accessType;
  late String _trafficManagementType;
  late String _speedLimit;
  late String _roadCondition;
  late String _visibility;
  late String _lighting;
  late String _signage;
  late String _barricading;
  late String _pedestrianProtection;
  late String _vehicleSegregation;
  late String _parkingArea;
  late String _loadingArea;
  late String _reversingControls;
  late String _banksmanControl;
  late String _deliveryControl;
  late String _visitorControl;
  late String _emergencyAccess;
  late String _fireAccess;
  late String _disabledAccess;
  late String _vehicleInspection;
  late String _inspectionFrequency;

  DateTime? _plannedInspectionDate;
  DateTime? _lastInspectionDate;
  DateTime? _nextInspectionDate;
  DateTime? _readinessDate;
  DateTime? _actionDueDate;
  DateTime? _verificationDate;
  DateTime? _approvalDate;

  bool _saving = false;

  final List<String> _textFields = const [
    'recordNo',
    'projectName',
    'projectCode',
    'siteLocation',
    'routeName',
    'responsiblePerson',
    'trafficMarshal',
    'securityContact',
    'emergencyContact',
    'vehicleRoute',
    'pedestrianRoute',
    'entryPoint',
    'exitPoint',
    'parkingArea',
    'loadingArea',
    'trafficPlanReference',
    'riskAssessmentReference',
    'methodStatementReference',
    'inspectionFindings',
    'hazards',
    'correctiveActions',
    'actionOwner',
    'verificationRemarks',
    'verifiedBy',
    'approvalRemarks',
    'approvedBy',
    'supportingDocuments',
    'remarks',
  ];

  @override
  void initState() {
    super.initState();

    for (final field in _textFields) {
      _controllers[field] =
          TextEditingController();
    }

    final record = widget.existing;

    if (record == null) {
      _status = 'Draft';
      _accessType = widget.accessTypes.first;
      _trafficManagementType =
          widget.trafficTypes.first;
      _speedLimit = widget.speedLimits[2];
      _roadCondition = 'Not Inspected';
      _visibility = 'Not Inspected';
      _lighting = 'Not Applicable';
      _signage = 'Not Inspected';
      _barricading = 'Not Applicable';
      _pedestrianProtection = 'Not Applicable';
      _vehicleSegregation = 'Not Applicable';
      _parkingArea = 'Not Applicable';
      _loadingArea = 'Not Applicable';
      _reversingControls = 'Not Applicable';
      _banksmanControl = 'Not Applicable';
      _deliveryControl = 'Not Applicable';
      _visitorControl = 'Not Applicable';
      _emergencyAccess = 'Not Applicable';
      _fireAccess = 'Not Applicable';
      _disabledAccess = 'Not Applicable';
      _vehicleInspection = 'Not Applicable';
      _inspectionFrequency = 'Daily';
    } else {
      _setText('recordNo', record.recordNo);
      _setText('projectName', record.projectName);
      _setText('projectCode', record.projectCode);
      _setText('siteLocation', record.siteLocation);
      _setText('routeName', record.routeName);
      _setText(
        'responsiblePerson',
        record.responsiblePerson,
      );
      _setText(
        'trafficMarshal',
        record.trafficMarshal,
      );
      _setText(
        'securityContact',
        record.securityContact,
      );
      _setText(
        'emergencyContact',
        record.emergencyContact,
      );
      _setText(
        'vehicleRoute',
        record.vehicleRoute,
      );
      _setText(
        'pedestrianRoute',
        record.pedestrianRoute,
      );
      _setText('entryPoint', record.entryPoint);
      _setText('exitPoint', record.exitPoint);
      _setText('parkingArea', record.parkingArea);
      _setText('loadingArea', record.loadingArea);
      _setText(
        'trafficPlanReference',
        record.trafficPlanReference,
      );
      _setText(
        'riskAssessmentReference',
        record.riskAssessmentReference,
      );
      _setText(
        'methodStatementReference',
        record.methodStatementReference,
      );
      _setText(
        'inspectionFindings',
        record.inspectionFindings,
      );
      _setText('hazards', record.hazards);
      _setText(
        'correctiveActions',
        record.correctiveActions,
      );
      _setText('actionOwner', record.actionOwner);
      _setText(
        'verificationRemarks',
        record.verificationRemarks,
      );
      _setText('verifiedBy', record.verifiedBy);
      _setText(
        'approvalRemarks',
        record.approvalRemarks,
      );
      _setText('approvedBy', record.approvedBy);
      _setText(
        'supportingDocuments',
        record.supportingDocuments,
      );
      _setText('remarks', record.remarks);

      _status = _safe(
        widget.statuses,
        record.status,
      );
      _accessType = _safe(
        widget.accessTypes,
        record.accessType,
      );
      _trafficManagementType = _safe(
        widget.trafficTypes,
        record.trafficManagementType,
      );
      _speedLimit = _safe(
        widget.speedLimits,
        record.speedLimit,
      );
      _roadCondition = _safe(
        widget.conditionOptions,
        record.roadCondition,
      );
      _visibility = _safe(
        widget.conditionOptions,
        record.visibility,
      );
      _lighting = _safe(
        widget.readinessOptions,
        record.lighting,
      );
      _signage = _safe(
        widget.readinessOptions,
        record.signage,
      );
      _barricading = _safe(
        widget.readinessOptions,
        record.barricading,
      );
      _pedestrianProtection = _safe(
        widget.readinessOptions,
        record.pedestrianProtection,
      );
      _vehicleSegregation = _safe(
        widget.readinessOptions,
        record.vehicleSegregation,
      );
      _parkingArea = _safe(
        widget.readinessOptions,
        record.parkingArea,
      );
      _loadingArea = _safe(
        widget.readinessOptions,
        record.loadingArea,
      );
      _reversingControls = _safe(
        widget.readinessOptions,
        record.reversingControls,
      );
      _banksmanControl = _safe(
        widget.readinessOptions,
        record.banksmanControl,
      );
      _deliveryControl = _safe(
        widget.readinessOptions,
        record.deliveryControl,
      );
      _visitorControl = _safe(
        widget.readinessOptions,
        record.visitorControl,
      );
      _emergencyAccess = _safe(
        widget.readinessOptions,
        record.emergencyAccess,
      );
      _fireAccess = _safe(
        widget.readinessOptions,
        record.fireAccess,
      );
      _disabledAccess = _safe(
        widget.readinessOptions,
        record.disabledAccess,
      );
      _vehicleInspection = _safe(
        widget.readinessOptions,
        record.vehicleInspection,
      );
      _inspectionFrequency = _safe(
        widget.frequencies,
        record.inspectionFrequency,
      );

      _plannedInspectionDate =
          record.plannedInspectionDate;
      _lastInspectionDate =
          record.lastInspectionDate;
      _nextInspectionDate =
          record.nextInspectionDate;
      _readinessDate = record.readinessDate;
      _actionDueDate = record.actionDueDate;
      _verificationDate = record.verificationDate;
      _approvalDate = record.approvalDate;
    }
  }

  String _safe(List<String> values, String value) {
    return values.contains(value)
        ? value
        : values.first;
  }

  void _setText(String key, String value) {
    _controllers[key]?.text = value;
  }

  String _text(String key) =>
      _controllers[key]?.text.trim() ?? '';

  @override
  void dispose() {
    for (final controller
        in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDate({
    required DateTime? current,
    required ValueChanged<DateTime> onPicked,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate:
          current ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      onPicked(picked);
    }
  }

  void _save() {
    if (_saving) return;

    final recordNo = _text('recordNo');
    final projectName = _text('projectName');
    final location = _text('siteLocation');
    final routeName = _text('routeName');
    final responsiblePerson =
        _text('responsiblePerson');

    if (recordNo.isEmpty ||
        projectName.isEmpty ||
        location.isEmpty ||
        routeName.isEmpty) {
      _showError(
        'Record No., Project Name, Site Location and Route Name are required.',
      );
      return;
    }

    if (responsiblePerson.isEmpty) {
      _showError('Responsible Person is required.');
      return;
    }

    if (_nextInspectionDate != null &&
        _lastInspectionDate != null &&
        _nextInspectionDate!
            .isBefore(_lastInspectionDate!)) {
      _showError(
        'Next inspection date cannot be before last inspection date.',
      );
      return;
    }

    if (_actionDueDate != null &&
        _readinessDate != null &&
        _actionDueDate!
            .isBefore(_readinessDate!)) {
      _showError(
        'Action due date cannot be before readiness date.',
      );
      return;
    }

    if ((_status == 'Ready' ||
            _status == 'Approved' ||
            _status == 'Operational') &&
        !_allApplicableControlsReady()) {
      _showError(
        'All applicable access and traffic controls should be Ready.',
      );
      return;
    }

    if (_status == 'Action Required' &&
        _text('correctiveActions').isEmpty) {
      _showError(
        'Corrective Actions are required for Action Required status.',
      );
      return;
    }

    if (_status == 'HSE Verification' &&
        _text('verifiedBy').isEmpty) {
      _showError(
        'Verified By is required for HSE Verification status.',
      );
      return;
    }

    if (_status == 'Approved' &&
        _text('approvedBy').isEmpty) {
      _showError(
        'Approved By is required before approval.',
      );
      return;
    }

    setState(() => _saving = true);

    final now = DateTime.now();
    final existing = widget.existing;

    final record = SiteAccessTrafficRecord(
      id: existing?.id ??
          now.microsecondsSinceEpoch.toString(),
      recordNo: recordNo,
      projectName: projectName,
      projectCode: _text('projectCode'),
      siteLocation: location,
      accessType: _accessType,
      routeName: routeName,
      status: _status,
      trafficManagementType:
          _trafficManagementType,
      responsiblePerson: responsiblePerson,
      trafficMarshal: _text('trafficMarshal'),
      securityContact: _text('securityContact'),
      emergencyContact:
          _text('emergencyContact'),
      vehicleRoute: _text('vehicleRoute'),
      pedestrianRoute:
          _text('pedestrianRoute'),
      entryPoint: _text('entryPoint'),
      exitPoint: _text('exitPoint'),
      speedLimit: _speedLimit,
      roadCondition: _roadCondition,
      visibility: _visibility,
      lighting: _lighting,
      signage: _signage,
      barricading: _barricading,
      pedestrianProtection:
          _pedestrianProtection,
      vehicleSegregation:
          _vehicleSegregation,
      parkingArea: _text('parkingArea'),
      loadingArea: _text('loadingArea'),
      reversingControls:
          _reversingControls,
      banksmanControl:
          _banksmanControl,
      deliveryControl:
          _deliveryControl,
      visitorControl:
          _visitorControl,
      emergencyAccess:
          _emergencyAccess,
      fireAccess: _fireAccess,
      disabledAccess: _disabledAccess,
      vehicleInspection:
          _vehicleInspection,
      trafficPlanReference:
          _text('trafficPlanReference'),
      riskAssessmentReference:
          _text('riskAssessmentReference'),
      methodStatementReference:
          _text('methodStatementReference'),
      plannedInspectionDate:
          _plannedInspectionDate,
      lastInspectionDate:
          _lastInspectionDate,
      nextInspectionDate:
          _nextInspectionDate,
      readinessDate: _readinessDate,
      inspectionFindings:
          _text('inspectionFindings'),
      hazards: _text('hazards'),
      correctiveActions:
          _text('correctiveActions'),
      actionOwner: _text('actionOwner'),
      actionDueDate: _actionDueDate,
      verificationRemarks:
          _text('verificationRemarks'),
      verifiedBy: _text('verifiedBy'),
      verificationDate: _verificationDate,
      approvalRemarks:
          _text('approvalRemarks'),
      approvedBy: _text('approvedBy'),
      approvalDate: _approvalDate,
      supportingDocuments:
          _text('supportingDocuments'),
      remarks: _text('remarks'),
      createdAt:
          existing?.createdAt ?? now,
      updatedAt: now,
    );

    Navigator.pop(context, record);
  }

  bool _allApplicableControlsReady() {
    final values = [
      _lighting,
      _signage,
      _barricading,
      _pedestrianProtection,
      _vehicleSegregation,
      _parkingArea,
      _loadingArea,
      _reversingControls,
      _banksmanControl,
      _deliveryControl,
      _visitorControl,
      _emergencyAccess,
      _fireAccess,
      _disabledAccess,
      _vehicleInspection,
    ];

    return values.every(
      (value) =>
          value == 'Ready' ||
          value == 'Not Applicable',
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _sectionTitle(
    String title,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 8,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryGreen,
            size: 21,
          ),
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
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: TextField(
        controller: _controllers[key],
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText:
              required ? '$label *' : label,
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
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
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
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: InkWell(
        onTap: onTap,
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            suffixIcon: const Icon(
              Icons.calendar_today_outlined,
            ),
          ),
          child: Text(_formatDate(value)),
        ),
      ),
    );
  }

  Widget _readiness(
    String label,
    String value,
    ValueChanged<String?> onChanged,
  ) {
    return _dropdown(
      label: label,
      value: value,
      items: widget.readinessOptions,
      onChanged: onChanged,
    );
  }

  static String _formatDate(DateTime? date) {
    if (date == null) return 'Select date';
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final bottom =
        MediaQuery.viewInsetsOf(context).bottom;

    return SafeArea(
      child: Container(
        height:
            MediaQuery.sizeOf(context).height * 0.95,
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
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius:
                    BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                6,
                10,
                8,
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Site Access & Traffic Management',
                      style: TextStyle(
                        color: darkGreen,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                  16,
                  0,
                  16,
                  bottom + 20,
                ),
                children: [
                  _sectionTitle(
                    'Access & Project',
                    Icons.alt_route,
                  ),
                  _field(
                    'recordNo',
                    'Record No.',
                    required: true,
                  ),
                  _field(
                    'projectName',
                    'Project Name',
                    required: true,
                  ),
                  _field(
                    'projectCode',
                    'Project Code',
                  ),
                  _field(
                    'siteLocation',
                    'Site Location',
                    required: true,
                  ),
                  _dropdown(
                    label: 'Access Type',
                    value: _accessType,
                    items: widget.accessTypes,
                    onChanged: (value) {
                      if (value != null) {
                        setState(
                          () => _accessType = value,
                        );
                      }
                    },
                  ),
                  _field(
                    'routeName',
                    'Route / Access Name',
                    required: true,
                  ),
                  _dropdown(
                    label: 'Traffic Management Type',
                    value:
                        _trafficManagementType,
                    items: widget.trafficTypes,
                    onChanged: (value) {
                      if (value != null) {
                        setState(
                          () => _trafficManagementType =
                              value,
                        );
                      }
                    },
                  ),
                  _dropdown(
                    label: 'Status',
                    value: _status,
                    items: widget.statuses,
                    onChanged: (value) {
                      if (value != null) {
                        setState(
                          () => _status = value,
                        );
                      }
                    },
                  ),
                  _field(
                    'responsiblePerson',
                    'Responsible Person',
                    required: true,
                  ),
                  _field(
                    'trafficMarshal',
                    'Traffic Marshal / Banksman',
                  ),
                  _field(
                    'securityContact',
                    'Security / Gate Contact',
                  ),
                  _field(
                    'emergencyContact',
                    'Emergency Contact',
                  ),
                  _sectionTitle(
                    'Route & Traffic Layout',
                    Icons.directions_car_outlined,
                  ),
                  _field(
                    'vehicleRoute',
                    'Vehicle Route / Description',
                    maxLines: 3,
                  ),
                  _field(
                    'pedestrianRoute',
                    'Pedestrian Route / Description',
                    maxLines: 3,
                  ),
                  _field(
                    'entryPoint',
                    'Entry Point / Gate',
                  ),
                  _field(
                    'exitPoint',
                    'Exit Point / Gate',
                  ),
                  _dropdown(
                    label: 'Site Speed Limit',
                    value: _speedLimit,
                    items: widget.speedLimits,
                    onChanged: (value) {
                      if (value != null) {
                        setState(
                          () => _speedLimit = value,
                        );
                      }
                    },
                  ),
                  _sectionTitle(
                    'Inspection & Physical Controls',
                    Icons.checklist_rtl,
                  ),
                  _dropdown(
                    label: 'Road Condition',
                    value: _roadCondition,
                    items: widget.conditionOptions,
                    onChanged: (value) {
                      if (value != null) {
                        setState(
                          () => _roadCondition = value,
                        );
                      }
                    },
                  ),
                  _dropdown(
                    label: 'Visibility',
                    value: _visibility,
                    items: widget.conditionOptions,
                    onChanged: (value) {
                      if (value != null) {
                        setState(
                          () => _visibility = value,
                        );
                      }
                    },
                  ),
                  _readiness(
                    'Lighting',
                    _lighting,
                    (value) {
                      if (value != null) {
                        setState(
                          () => _lighting = value,
                        );
                      }
                    },
                  ),
                  _readiness(
                    'Signage',
                    _signage,
                    (value) {
                      if (value != null) {
                        setState(
                          () => _signage = value,
                        );
                      }
                    },
                  ),
                  _readiness(
                    'Barricading',
                    _barricading,
                    (value) {
                      if (value != null) {
                        setState(
                          () => _barricading = value,
                        );
                      }
                    },
                  ),
                  _readiness(
                    'Pedestrian Protection',
                    _pedestrianProtection,
                    (value) {
                      if (value != null) {
                        setState(
                          () =>
                              _pedestrianProtection =
                                  value,
                        );
                      }
                    },
                  ),
                  _readiness(
                    'Vehicle / Pedestrian Segregation',
                    _vehicleSegregation,
                    (value) {
                      if (value != null) {
                        setState(
                          () => _vehicleSegregation =
                              value,
                        );
                      }
                    },
                  ),
                  _field(
                    'parkingArea',
                    'Parking Area / Arrangement',
                    maxLines: 2,
                  ),
                  _field(
                    'loadingArea',
                    'Loading / Unloading Area',
                    maxLines: 2,
                  ),
                  _readiness(
                    'Reversing Controls',
                    _reversingControls,
                    (value) {
                      if (value != null) {
                        setState(
                          () => _reversingControls =
                              value,
                        );
                      }
                    },
                  ),
                  _readiness(
                    'Banksman / Traffic Marshal Control',
                    _banksmanControl,
                    (value) {
                      if (value != null) {
                        setState(
                          () => _banksmanControl =
                              value,
                        );
                      }
                    },
                  ),
                  _readiness(
                    'Delivery / Logistics Control',
                    _deliveryControl,
                    (value) {
                      if (value != null) {
                        setState(
                          () => _deliveryControl =
                              value,
                        );
                      }
                    },
                  ),
                  _readiness(
                    'Visitor Access Control',
                    _visitorControl,
                    (value) {
                      if (value != null) {
                        setState(
                          () => _visitorControl =
                              value,
                        );
                      }
                    },
                  ),
                  _readiness(
                    'Emergency Access',
                    _emergencyAccess,
                    (value) {
                      if (value != null) {
                        setState(
                          () => _emergencyAccess =
                              value,
                        );
                      }
                    },
                  ),
                  _readiness(
                    'Fire Service Access',
                    _fireAccess,
                    (value) {
                      if (value != null) {
                        setState(
                          () => _fireAccess =
                              value,
                        );
                      }
                    },
                  ),
                  _readiness(
                    'Accessible / Disabled Access',
                    _disabledAccess,
                    (value) {
                      if (value != null) {
                        setState(
                          () => _disabledAccess =
                              value,
                        );
                      }
                    },
                  ),
                  _readiness(
                    'Vehicle Pre-Entry Inspection',
                    _vehicleInspection,
                    (value) {
                      if (value != null) {
                        setState(
                          () => _vehicleInspection =
                              value,
                        );
                      }
                    },
                  ),
                  _sectionTitle(
                    'Plans & References',
                    Icons.description_outlined,
                  ),
                  _field(
                    'trafficPlanReference',
                    'Traffic Management Plan Reference',
                  ),
                  _field(
                    'riskAssessmentReference',
                    'Risk Assessment / HIRA Reference',
                  ),
                  _field(
                    'methodStatementReference',
                    'Method Statement / RAMS Reference',
                  ),
                  _sectionTitle(
                    'Inspection & Dates',
                    Icons.event_available_outlined,
                  ),
                  _dropdown(
                    label: 'Inspection Frequency',
                    value: _inspectionFrequency,
                    items: widget.frequencies,
                    onChanged: (value) {
                      if (value != null) {
                        setState(
                          () =>
                              _inspectionFrequency =
                                  value,
                        );
                      }
                    },
                  ),
                  _dateField(
                    'Planned Inspection Date',
                    _plannedInspectionDate,
                    () => _pickDate(
                      current:
                          _plannedInspectionDate,
                      onPicked: (date) =>
                          setState(
                        () =>
                            _plannedInspectionDate =
                                date,
                      ),
                    ),
                  ),
                  _dateField(
                    'Last Inspection Date',
                    _lastInspectionDate,
                    () => _pickDate(
                      current: _lastInspectionDate,
                      onPicked: (date) =>
                          setState(
                        () =>
                            _lastInspectionDate =
                                date,
                      ),
                    ),
                  ),
                  _dateField(
                    'Next Inspection Date',
                    _nextInspectionDate,
                    () => _pickDate(
                      current: _nextInspectionDate,
                      onPicked: (date) =>
                          setState(
                        () =>
                            _nextInspectionDate =
                                date,
                      ),
                    ),
                  ),
                  _dateField(
                    'Readiness Date',
                    _readinessDate,
                    () => _pickDate(
                      current: _readinessDate,
                      onPicked: (date) =>
                          setState(
                        () => _readinessDate = date,
                      ),
                    ),
                  ),
                  _field(
                    'inspectionFindings',
                    'Inspection Findings',
                    maxLines: 4,
                  ),
                  _field(
                    'hazards',
                    'Traffic / Access Hazards',
                    maxLines: 4,
                  ),
                  _sectionTitle(
                    'Corrective Actions',
                    Icons.assignment_late_outlined,
                  ),
                  _field(
                    'correctiveActions',
                    'Corrective Actions',
                    maxLines: 4,
                  ),
                  _field(
                    'actionOwner',
                    'Action Owner',
                  ),
                  _dateField(
                    'Action Due Date',
                    _actionDueDate,
                    () => _pickDate(
                      current: _actionDueDate,
                      onPicked: (date) =>
                          setState(
                        () => _actionDueDate = date,
                      ),
                    ),
                  ),
                  _sectionTitle(
                    'Verification & Approval',
                    Icons.verified_outlined,
                  ),
                  _field(
                    'verifiedBy',
                    'Verified By',
                  ),
                  _dateField(
                    'Verification Date',
                    _verificationDate,
                    () => _pickDate(
                      current: _verificationDate,
                      onPicked: (date) =>
                          setState(
                        () =>
                            _verificationDate =
                                date,
                      ),
                    ),
                  ),
                  _field(
                    'verificationRemarks',
                    'Verification Remarks',
                    maxLines: 3,
                  ),
                  _field(
                    'approvedBy',
                    'Approved By',
                  ),
                  _dateField(
                    'Approval Date',
                    _approvalDate,
                    () => _pickDate(
                      current: _approvalDate,
                      onPicked: (date) =>
                          setState(
                        () => _approvalDate = date,
                      ),
                    ),
                  ),
                  _field(
                    'approvalRemarks',
                    'Approval Remarks',
                    maxLines: 3,
                  ),
                  _sectionTitle(
                    'Documents & Remarks',
                    Icons.folder_copy_outlined,
                  ),
                  _field(
                    'supportingDocuments',
                    'Supporting Documents / References',
                    maxLines: 3,
                  ),
                  _field(
                    'remarks',
                    'Additional Remarks',
                    maxLines: 4,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 50,
                    child: FilledButton.icon(
                      onPressed:
                          _saving ? null : _save,
                      icon: const Icon(
                        Icons.save_outlined,
                      ),
                      label: Text(
                        _saving
                            ? 'Saving...'
                            : 'Save Access & Traffic Record',
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

class _AccessTrafficDetailsSheet extends StatelessWidget {
  final SiteAccessTrafficRecord record;

  const _AccessTrafficDetailsSheet({
    required this.record,
  });

  static const Color darkGreen = Color(0xFF0B5D4B);

  @override
  Widget build(BuildContext context) {
    final items = <String, String>{
      'Record No.': record.recordNo,
      'Project': record.projectName,
      'Project Code': record.projectCode,
      'Site Location': record.siteLocation,
      'Access Type': record.accessType,
      'Route': record.routeName,
      'Status': record.status,
      'Traffic Type':
          record.trafficManagementType,
      'Responsible Person':
          record.responsiblePerson,
      'Traffic Marshal':
          record.trafficMarshal,
      'Security Contact':
          record.securityContact,
      'Emergency Contact':
          record.emergencyContact,
      'Vehicle Route':
          record.vehicleRoute,
      'Pedestrian Route':
          record.pedestrianRoute,
      'Entry Point': record.entryPoint,
      'Exit Point': record.exitPoint,
      'Speed Limit': record.speedLimit,
      'Road Condition':
          record.roadCondition,
      'Visibility': record.visibility,
      'Lighting': record.lighting,
      'Signage': record.signage,
      'Barricading': record.barricading,
      'Pedestrian Protection':
          record.pedestrianProtection,
      'Vehicle Segregation':
          record.vehicleSegregation,
      'Parking Area': record.parkingArea,
      'Loading Area': record.loadingArea,
      'Reversing Controls':
          record.reversingControls,
      'Banksman Control':
          record.banksmanControl,
      'Delivery Control':
          record.deliveryControl,
      'Visitor Control':
          record.visitorControl,
      'Emergency Access':
          record.emergencyAccess,
      'Fire Access': record.fireAccess,
      'Disabled Access':
          record.disabledAccess,
      'Vehicle Inspection':
          record.vehicleInspection,
      'Traffic Plan':
          record.trafficPlanReference,
      'Risk Assessment':
          record.riskAssessmentReference,
      'Method Statement':
          record.methodStatementReference,
      'Inspection Frequency':
          record.inspectionFrequency,
      'Planned Inspection':
          _formatDate(record.plannedInspectionDate),
      'Last Inspection':
          _formatDate(record.lastInspectionDate),
      'Next Inspection':
          _formatDate(record.nextInspectionDate),
      'Readiness Date':
          _formatDate(record.readinessDate),
      'Inspection Findings':
          record.inspectionFindings,
      'Hazards': record.hazards,
      'Corrective Actions':
          record.correctiveActions,
      'Action Owner': record.actionOwner,
      'Action Due':
          _formatDate(record.actionDueDate),
      'Verified By': record.verifiedBy,
      'Verification Date':
          _formatDate(record.verificationDate),
      'Verification Remarks':
          record.verificationRemarks,
      'Approved By': record.approvedBy,
      'Approval Date':
          _formatDate(record.approvalDate),
      'Approval Remarks':
          record.approvalRemarks,
      'Supporting Documents':
          record.supportingDocuments,
      'Remarks': record.remarks,
      'Created':
          _formatDateTime(record.createdAt),
      'Updated':
          _formatDateTime(record.updatedAt),
    };

    return SafeArea(
      child: Container(
        height:
            MediaQuery.sizeOf(context).height * 0.90,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                16,
                8,
                8,
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Access & Traffic Details',
                      style: TextStyle(
                        color: darkGreen,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  4,
                  16,
                  24,
                ),
                itemCount: items.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1),
                itemBuilder: (_, index) {
                  final entry =
                      items.entries.elementAt(index);
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 145,
                          child: Text(
                            entry.key,
                            style: const TextStyle(
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            entry.value.isEmpty
                                ? '-'
                                : entry.value,
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
    return '${_formatDate(date)} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }
}
