import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SiteFacilityRecord {
  final String id;
  final String facilityNo;
  final String projectName;
  final String projectCode;
  final String siteLocation;
  final String facilityType;
  final String facilityName;
  final String area;
  final String responsiblePerson;
  final String contractor;
  final String status;
  final String capacity;
  final String quantity;
  final String condition;
  final String waterSupply;
  final String sanitation;
  final String cleaningFrequency;
  final String lighting;
  final String ventilation;
  final String accessibility;
  final String privacy;
  final String fireSafety;
  final String firstAid;
  final String emergencyAccess;
  final String wasteManagement;
  final String pestControl;
  final String temperatureControl;
  final String heatStressControl;
  final String inspectionFrequency;
  final DateTime? lastInspectionDate;
  final DateTime? nextInspectionDate;
  final DateTime? readinessDate;
  final String inspectionFindings;
  final String deficiencies;
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

  SiteFacilityRecord({
    required this.id,
    required this.facilityNo,
    required this.projectName,
    required this.projectCode,
    required this.siteLocation,
    required this.facilityType,
    required this.facilityName,
    required this.area,
    required this.responsiblePerson,
    required this.contractor,
    required this.status,
    required this.capacity,
    required this.quantity,
    required this.condition,
    required this.waterSupply,
    required this.sanitation,
    required this.cleaningFrequency,
    required this.lighting,
    required this.ventilation,
    required this.accessibility,
    required this.privacy,
    required this.fireSafety,
    required this.firstAid,
    required this.emergencyAccess,
    required this.wasteManagement,
    required this.pestControl,
    required this.temperatureControl,
    required this.heatStressControl,
    required this.inspectionFrequency,
    this.lastInspectionDate,
    this.nextInspectionDate,
    this.readinessDate,
    required this.inspectionFindings,
    required this.deficiencies,
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
        'facilityNo': facilityNo,
        'projectName': projectName,
        'projectCode': projectCode,
        'siteLocation': siteLocation,
        'facilityType': facilityType,
        'facilityName': facilityName,
        'area': area,
        'responsiblePerson': responsiblePerson,
        'contractor': contractor,
        'status': status,
        'capacity': capacity,
        'quantity': quantity,
        'condition': condition,
        'waterSupply': waterSupply,
        'sanitation': sanitation,
        'cleaningFrequency': cleaningFrequency,
        'lighting': lighting,
        'ventilation': ventilation,
        'accessibility': accessibility,
        'privacy': privacy,
        'fireSafety': fireSafety,
        'firstAid': firstAid,
        'emergencyAccess': emergencyAccess,
        'wasteManagement': wasteManagement,
        'pestControl': pestControl,
        'temperatureControl': temperatureControl,
        'heatStressControl': heatStressControl,
        'inspectionFrequency': inspectionFrequency,
        'lastInspectionDate': lastInspectionDate?.toIso8601String(),
        'nextInspectionDate': nextInspectionDate?.toIso8601String(),
        'readinessDate': readinessDate?.toIso8601String(),
        'inspectionFindings': inspectionFindings,
        'deficiencies': deficiencies,
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

  factory SiteFacilityRecord.fromJson(Map<String, dynamic> json) {
    return SiteFacilityRecord(
      id: json['id'] as String? ?? '',
      facilityNo: json['facilityNo'] as String? ?? '',
      projectName: json['projectName'] as String? ?? '',
      projectCode: json['projectCode'] as String? ?? '',
      siteLocation: json['siteLocation'] as String? ?? '',
      facilityType: json['facilityType'] as String? ?? '',
      facilityName: json['facilityName'] as String? ?? '',
      area: json['area'] as String? ?? '',
      responsiblePerson: json['responsiblePerson'] as String? ?? '',
      contractor: json['contractor'] as String? ?? '',
      status: json['status'] as String? ?? 'Draft',
      capacity: json['capacity'] as String? ?? '',
      quantity: json['quantity'] as String? ?? '',
      condition: json['condition'] as String? ?? 'Not Inspected',
      waterSupply: json['waterSupply'] as String? ?? 'Not Applicable',
      sanitation: json['sanitation'] as String? ?? 'Not Applicable',
      cleaningFrequency: json['cleaningFrequency'] as String? ?? '',
      lighting: json['lighting'] as String? ?? 'Not Applicable',
      ventilation: json['ventilation'] as String? ?? 'Not Applicable',
      accessibility: json['accessibility'] as String? ?? 'Not Applicable',
      privacy: json['privacy'] as String? ?? 'Not Applicable',
      fireSafety: json['fireSafety'] as String? ?? 'Not Applicable',
      firstAid: json['firstAid'] as String? ?? 'Not Applicable',
      emergencyAccess: json['emergencyAccess'] as String? ?? 'Not Applicable',
      wasteManagement: json['wasteManagement'] as String? ?? 'Not Applicable',
      pestControl: json['pestControl'] as String? ?? 'Not Applicable',
      temperatureControl:
          json['temperatureControl'] as String? ?? 'Not Applicable',
      heatStressControl:
          json['heatStressControl'] as String? ?? 'Not Applicable',
      inspectionFrequency: json['inspectionFrequency'] as String? ?? '',
      lastInspectionDate: _parseDate(json['lastInspectionDate']),
      nextInspectionDate: _parseDate(json['nextInspectionDate']),
      readinessDate: _parseDate(json['readinessDate']),
      inspectionFindings: json['inspectionFindings'] as String? ?? '',
      deficiencies: json['deficiencies'] as String? ?? '',
      correctiveActions: json['correctiveActions'] as String? ?? '',
      actionOwner: json['actionOwner'] as String? ?? '',
      actionDueDate: _parseDate(json['actionDueDate']),
      verificationRemarks: json['verificationRemarks'] as String? ?? '',
      verifiedBy: json['verifiedBy'] as String? ?? '',
      verificationDate: _parseDate(json['verificationDate']),
      approvalRemarks: json['approvalRemarks'] as String? ?? '',
      approvedBy: json['approvedBy'] as String? ?? '',
      approvalDate: _parseDate(json['approvalDate']),
      supportingDocuments: json['supportingDocuments'] as String? ?? '',
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

class SiteEstablishmentFacilitiesPage extends StatefulWidget {
  const SiteEstablishmentFacilitiesPage({super.key});

  @override
  State<SiteEstablishmentFacilitiesPage> createState() =>
      _SiteEstablishmentFacilitiesPageState();
}

class _SiteEstablishmentFacilitiesPageState
    extends State<SiteEstablishmentFacilitiesPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_site_establishment_facilities';

  final List<String> _statuses = const [
    'Draft',
    'Setup Planned',
    'Installation In Progress',
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

  final List<String> _facilityTypes = const [
    'Site Office',
    'Welfare Area',
    'Toilet / Sanitation',
    'Shower / Washing Facility',
    'Drinking Water Station',
    'Canteen / Food Facility',
    'Rest Area',
    'Prayer Facility',
    'First Aid / Medical Room',
    'Changing Room',
    'Waste Collection Area',
    'Emergency Assembly Area',
    'Fire Point',
    'Security / Gate Facility',
    'Lighting Facility',
    'Temporary Accommodation',
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

  final List<String> _frequencies = const [
    'Daily',
    'Weekly',
    'Biweekly',
    'Monthly',
    'As Required',
    'Not Applicable',
  ];

  List<SiteFacilityRecord> _records = [];
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
          .map(SiteFacilityRecord.fromJson)
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

  List<SiteFacilityRecord> get _filteredRecords {
    final query = _search.trim().toLowerCase();

    final filtered = _records.where((record) {
      final statusMatches =
          _statusFilter == 'All' || record.status == _statusFilter;

      if (!statusMatches) return false;
      if (query.isEmpty) return true;

      final haystack = [
        record.facilityNo,
        record.projectName,
        record.projectCode,
        record.siteLocation,
        record.facilityType,
        record.facilityName,
        record.responsiblePerson,
        record.contractor,
        record.status,
      ].join(' ').toLowerCase();

      return haystack.contains(query);
    }).toList();

    filtered.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return filtered;
  }

  int _countStatus(String status) {
    return _records.where((item) => item.status == status).length;
  }

  int get _readyCount => _records.where((item) {
        return item.status == 'Ready' ||
            item.status == 'Approved' ||
            item.status == 'Operational';
      }).length;

  int get _actionCount => _records.where((item) {
        return item.status == 'Action Required';
      }).length;

  int get _overdueCount {
    final now = DateTime.now();
    return _records.where((item) {
      final due = item.actionDueDate;
      if (due == null) return false;
      if (item.status == 'Closed' || item.status == 'Cancelled') {
        return false;
      }
      return due.isBefore(now);
    }).length;
  }

  Future<void> _openForm({SiteFacilityRecord? existing}) async {
    final result = await showModalBottomSheet<SiteFacilityRecord>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _FacilityFormSheet(
        existing: existing,
        statuses: _statuses,
        facilityTypes: _facilityTypes,
        conditionOptions: _conditionOptions,
        readinessOptions: _readinessOptions,
        frequencies: _frequencies,
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
              ? 'Facility record saved.'
              : 'Facility record updated.',
        ),
      ),
    );
  }

  Future<void> _deleteRecord(SiteFacilityRecord record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Facility Record'),
        content: Text(
          'Delete facility record ${record.facilityNo}?',
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

  void _showDetails(SiteFacilityRecord record) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _FacilityDetailsSheet(record: record),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('5B Site Establishment & Facilities'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Add facility',
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
        label: const Text('Add Facility'),
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
            Icons.apartment,
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
            'Actions',
            _actionCount.toString(),
            Icons.assignment_late_outlined,
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
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 11),
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
              onChanged: (value) => setState(() => _search = value),
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'No., project, facility, location...',
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

  Widget _emptyState() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Icon(
              Icons.home_work_outlined,
              size: 56,
              color: Colors.grey.shade500,
            ),
            const SizedBox(height: 12),
            const Text(
              'No facility records found.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Add site facilities and track their readiness, inspection and corrective actions.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _recordCard(SiteFacilityRecord record) {
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
                      record.facilityNo,
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
                record.facilityName,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(record.facilityType),
              const SizedBox(height: 4),
              Text('Project: ${record.projectName}'),
              if (record.siteLocation.isNotEmpty)
                Text('Location: ${record.siteLocation}'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _miniStatus('Condition', record.condition),
                  _miniStatus('Water', record.waterSupply),
                  _miniStatus('Sanitation', record.sanitation),
                  _miniStatus('Fire', record.fireSafety),
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

    if (status == 'Ready' ||
        status == 'Approved' ||
        status == 'Operational') {
      color = primaryGreen;
    } else if (status == 'Inspection Required' ||
        status == 'HSE Verification' ||
        status == 'Installation In Progress') {
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
          fontSize: 10.5,
        ),
      ),
      backgroundColor: color.withValues(alpha: 0.10),
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
        status == 'Needs Improvement' ||
        status == 'Action Required';

    final color = positive
        ? primaryGreen
        : negative
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

class _FacilityFormSheet extends StatefulWidget {
  final SiteFacilityRecord? existing;
  final List<String> statuses;
  final List<String> facilityTypes;
  final List<String> conditionOptions;
  final List<String> readinessOptions;
  final List<String> frequencies;

  const _FacilityFormSheet({
    required this.existing,
    required this.statuses,
    required this.facilityTypes,
    required this.conditionOptions,
    required this.readinessOptions,
    required this.frequencies,
  });

  @override
  State<_FacilityFormSheet> createState() => _FacilityFormSheetState();
}

class _FacilityFormSheetState extends State<_FacilityFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final Map<String, TextEditingController> _controllers = {};

  late String _status;
  late String _facilityType;
  late String _condition;
  late String _waterSupply;
  late String _sanitation;
  late String _lighting;
  late String _ventilation;
  late String _accessibility;
  late String _privacy;
  late String _fireSafety;
  late String _firstAid;
  late String _emergencyAccess;
  late String _wasteManagement;
  late String _pestControl;
  late String _temperatureControl;
  late String _heatStressControl;
  late String _inspectionFrequency;

  DateTime? _lastInspectionDate;
  DateTime? _nextInspectionDate;
  DateTime? _readinessDate;
  DateTime? _actionDueDate;
  DateTime? _verificationDate;
  DateTime? _approvalDate;

  bool _saving = false;

  final List<String> _textFields = const [
    'facilityNo',
    'projectName',
    'projectCode',
    'siteLocation',
    'facilityName',
    'area',
    'responsiblePerson',
    'contractor',
    'capacity',
    'quantity',
    'cleaningFrequency',
    'inspectionFindings',
    'deficiencies',
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
      _controllers[field] = TextEditingController();
    }

    final record = widget.existing;

    if (record == null) {
      _status = 'Draft';
      _facilityType = widget.facilityTypes.first;
      _condition = 'Not Inspected';
      _waterSupply = 'Not Applicable';
      _sanitation = 'Not Applicable';
      _lighting = 'Not Applicable';
      _ventilation = 'Not Applicable';
      _accessibility = 'Not Applicable';
      _privacy = 'Not Applicable';
      _fireSafety = 'Not Applicable';
      _firstAid = 'Not Applicable';
      _emergencyAccess = 'Not Applicable';
      _wasteManagement = 'Not Applicable';
      _pestControl = 'Not Applicable';
      _temperatureControl = 'Not Applicable';
      _heatStressControl = 'Not Applicable';
      _inspectionFrequency = 'As Required';
    } else {
      _setText('facilityNo', record.facilityNo);
      _setText('projectName', record.projectName);
      _setText('projectCode', record.projectCode);
      _setText('siteLocation', record.siteLocation);
      _setText('facilityName', record.facilityName);
      _setText('area', record.area);
      _setText('responsiblePerson', record.responsiblePerson);
      _setText('contractor', record.contractor);
      _setText('capacity', record.capacity);
      _setText('quantity', record.quantity);
      _setText('cleaningFrequency', record.cleaningFrequency);
      _setText('inspectionFindings', record.inspectionFindings);
      _setText('deficiencies', record.deficiencies);
      _setText('correctiveActions', record.correctiveActions);
      _setText('actionOwner', record.actionOwner);
      _setText('verificationRemarks', record.verificationRemarks);
      _setText('verifiedBy', record.verifiedBy);
      _setText('approvalRemarks', record.approvalRemarks);
      _setText('approvedBy', record.approvedBy);
      _setText('supportingDocuments', record.supportingDocuments);
      _setText('remarks', record.remarks);

      _status = _safe(widget.statuses, record.status);
      _facilityType = _safe(widget.facilityTypes, record.facilityType);
      _condition = _safe(widget.conditionOptions, record.condition);
      _waterSupply = _safe(widget.readinessOptions, record.waterSupply);
      _sanitation = _safe(widget.readinessOptions, record.sanitation);
      _lighting = _safe(widget.readinessOptions, record.lighting);
      _ventilation = _safe(widget.readinessOptions, record.ventilation);
      _accessibility = _safe(widget.readinessOptions, record.accessibility);
      _privacy = _safe(widget.readinessOptions, record.privacy);
      _fireSafety = _safe(widget.readinessOptions, record.fireSafety);
      _firstAid = _safe(widget.readinessOptions, record.firstAid);
      _emergencyAccess = _safe(widget.readinessOptions, record.emergencyAccess);
      _wasteManagement = _safe(widget.readinessOptions, record.wasteManagement);
      _pestControl = _safe(widget.readinessOptions, record.pestControl);
      _temperatureControl =
          _safe(widget.readinessOptions, record.temperatureControl);
      _heatStressControl =
          _safe(widget.readinessOptions, record.heatStressControl);
      _inspectionFrequency = _safe(widget.frequencies, record.inspectionFrequency);

      _lastInspectionDate = record.lastInspectionDate;
      _nextInspectionDate = record.nextInspectionDate;
      _readinessDate = record.readinessDate;
      _actionDueDate = record.actionDueDate;
      _verificationDate = record.verificationDate;
      _approvalDate = record.approvalDate;
    }
  }

  String _safe(List<String> values, String value) {
    return values.contains(value) ? value : values.first;
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
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: current ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) onPicked(picked);
  }

  void _save() {
    if (_saving) return;

    final facilityNo = _text('facilityNo');
    final projectName = _text('projectName');
    final location = _text('siteLocation');
    final facilityName = _text('facilityName');
    final responsiblePerson = _text('responsiblePerson');

    if (facilityNo.isEmpty ||
        projectName.isEmpty ||
        location.isEmpty ||
        facilityName.isEmpty) {
      _showError(
        'Facility No., Project Name, Site Location and Facility Name are required.',
      );
      return;
    }

    if (responsiblePerson.isEmpty) {
      _showError('Responsible Person is required.');
      return;
    }

    if (_nextInspectionDate != null &&
        _lastInspectionDate != null &&
        _nextInspectionDate!.isBefore(_lastInspectionDate!)) {
      _showError('Next inspection date cannot be before last inspection date.');
      return;
    }

    if (_readinessDate != null &&
        _nextInspectionDate != null &&
        _status == 'Ready' &&
        _readinessDate!.isBefore(_nextInspectionDate!)) {
      _showError(
        'Readiness date should not be before the next inspection date.',
      );
      return;
    }

    if (_actionDueDate != null &&
        _readinessDate != null &&
        _actionDueDate!.isBefore(_readinessDate!)) {
      _showError('Action due date cannot be before readiness date.');
      return;
    }

    if ((_status == 'Ready' ||
            _status == 'Approved' ||
            _status == 'Operational') &&
        !_allApplicableItemsReady()) {
      _showError(
        'All applicable facility readiness checks should be Ready.',
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
      _showError('Verified By is required for HSE Verification status.');
      return;
    }

    if (_status == 'Approved' && _text('approvedBy').isEmpty) {
      _showError('Approved By is required before approval.');
      return;
    }

    setState(() => _saving = true);

    final now = DateTime.now();
    final existing = widget.existing;

    final record = SiteFacilityRecord(
      id: existing?.id ?? now.microsecondsSinceEpoch.toString(),
      facilityNo: facilityNo,
      projectName: projectName,
      projectCode: _text('projectCode'),
      siteLocation: location,
      facilityType: _facilityType,
      facilityName: facilityName,
      area: _text('area'),
      responsiblePerson: responsiblePerson,
      contractor: _text('contractor'),
      status: _status,
      capacity: _text('capacity'),
      quantity: _text('quantity'),
      condition: _condition,
      waterSupply: _waterSupply,
      sanitation: _sanitation,
      cleaningFrequency: _text('cleaningFrequency'),
      lighting: _lighting,
      ventilation: _ventilation,
      accessibility: _accessibility,
      privacy: _privacy,
      fireSafety: _fireSafety,
      firstAid: _firstAid,
      emergencyAccess: _emergencyAccess,
      wasteManagement: _wasteManagement,
      pestControl: _pestControl,
      temperatureControl: _temperatureControl,
      heatStressControl: _heatStressControl,
      inspectionFrequency: _inspectionFrequency,
      lastInspectionDate: _lastInspectionDate,
      nextInspectionDate: _nextInspectionDate,
      readinessDate: _readinessDate,
      inspectionFindings: _text('inspectionFindings'),
      deficiencies: _text('deficiencies'),
      correctiveActions: _text('correctiveActions'),
      actionOwner: _text('actionOwner'),
      actionDueDate: _actionDueDate,
      verificationRemarks: _text('verificationRemarks'),
      verifiedBy: _text('verifiedBy'),
      verificationDate: _verificationDate,
      approvalRemarks: _text('approvalRemarks'),
      approvedBy: _text('approvedBy'),
      approvalDate: _approvalDate,
      supportingDocuments: _text('supportingDocuments'),
      remarks: _text('remarks'),
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );

    Navigator.pop(context, record);
  }

  bool _allApplicableItemsReady() {
    final values = [
      _waterSupply,
      _sanitation,
      _lighting,
      _ventilation,
      _accessibility,
      _privacy,
      _fireSafety,
      _firstAid,
      _emergencyAccess,
      _wasteManagement,
      _pestControl,
      _temperatureControl,
      _heatStressControl,
    ];

    return values.every((value) =>
        value == 'Ready' || value == 'Not Applicable');
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
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            suffixIcon: const Icon(Icons.calendar_today_outlined),
          ),
          child: Text(_formatDate(value)),
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

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewInsetsOf(context).bottom;

    return SafeArea(
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.95,
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
                      'Site Establishment & Facilities',
                      style: TextStyle(
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
              child: ListView(
                padding: EdgeInsets.fromLTRB(16, 0, 16, bottom + 20),
                children: [
                  _sectionTitle('Facility & Project', Icons.home_work_outlined),
                  _field('facilityNo', 'Facility No.', required: true),
                  _field('projectName', 'Project Name', required: true),
                  _field('projectCode', 'Project Code'),
                  _field('siteLocation', 'Site Location', required: true),
                  _dropdown(
                    label: 'Facility Type',
                    value: _facilityType,
                    items: widget.facilityTypes,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _facilityType = value);
                      }
                    },
                  ),
                  _field('facilityName', 'Facility Name / Identifier',
                      required: true),
                  _field('area', 'Area / Location Within Site'),
                  _field('responsiblePerson', 'Responsible Person',
                      required: true),
                  _field('contractor', 'Facility Contractor / Supplier'),
                  _field('capacity', 'Capacity'),
                  _field('quantity', 'Quantity', keyboardType: TextInputType.number),
                  _dropdown(
                    label: 'Record Status',
                    value: _status,
                    items: widget.statuses,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _status = value);
                      }
                    },
                  ),
                  _dropdown(
                    label: 'Overall Condition',
                    value: _condition,
                    items: widget.conditionOptions,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _condition = value);
                      }
                    },
                  ),
                  _sectionTitle(
                    'Facility Readiness',
                    Icons.checklist_rtl,
                  ),
                  _readiness('Water Supply', _waterSupply, (value) {
                    if (value != null) {
                      setState(() => _waterSupply = value);
                    }
                  }),
                  _readiness('Sanitation / Toilets', _sanitation, (value) {
                    if (value != null) {
                      setState(() => _sanitation = value);
                    }
                  }),
                  _field('cleaningFrequency', 'Cleaning Frequency'),
                  _readiness('Lighting', _lighting, (value) {
                    if (value != null) {
                      setState(() => _lighting = value);
                    }
                  }),
                  _readiness('Ventilation', _ventilation, (value) {
                    if (value != null) {
                      setState(() => _ventilation = value);
                    }
                  }),
                  _readiness('Accessibility', _accessibility, (value) {
                    if (value != null) {
                      setState(() => _accessibility = value);
                    }
                  }),
                  _readiness('Privacy', _privacy, (value) {
                    if (value != null) {
                      setState(() => _privacy = value);
                    }
                  }),
                  _readiness('Fire Safety', _fireSafety, (value) {
                    if (value != null) {
                      setState(() => _fireSafety = value);
                    }
                  }),
                  _readiness('First Aid / Medical', _firstAid, (value) {
                    if (value != null) {
                      setState(() => _firstAid = value);
                    }
                  }),
                  _readiness(
                    'Emergency Access',
                    _emergencyAccess,
                    (value) {
                      if (value != null) {
                        setState(() => _emergencyAccess = value);
                      }
                    },
                  ),
                  _readiness(
                    'Waste Management',
                    _wasteManagement,
                    (value) {
                      if (value != null) {
                        setState(() => _wasteManagement = value);
                      }
                    },
                  ),
                  _readiness('Pest Control', _pestControl, (value) {
                    if (value != null) {
                      setState(() => _pestControl = value);
                    }
                  }),
                  _readiness(
                    'Temperature / Cooling Control',
                    _temperatureControl,
                    (value) {
                      if (value != null) {
                        setState(() => _temperatureControl = value);
                      }
                    },
                  ),
                  _readiness(
                    'Heat Stress Welfare Control',
                    _heatStressControl,
                    (value) {
                      if (value != null) {
                        setState(() => _heatStressControl = value);
                      }
                    },
                  ),
                  _sectionTitle(
                    'Inspection & Readiness Dates',
                    Icons.event_available_outlined,
                  ),
                  _dropdown(
                    label: 'Inspection Frequency',
                    value: _inspectionFrequency,
                    items: widget.frequencies,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _inspectionFrequency = value);
                      }
                    },
                  ),
                  _dateField(
                    'Last Inspection Date',
                    _lastInspectionDate,
                    () => _pickDate(
                      current: _lastInspectionDate,
                      onPicked: (date) =>
                          setState(() => _lastInspectionDate = date),
                    ),
                  ),
                  _dateField(
                    'Next Inspection Date',
                    _nextInspectionDate,
                    () => _pickDate(
                      current: _nextInspectionDate,
                      onPicked: (date) =>
                          setState(() => _nextInspectionDate = date),
                    ),
                  ),
                  _dateField(
                    'Readiness Date',
                    _readinessDate,
                    () => _pickDate(
                      current: _readinessDate,
                      onPicked: (date) =>
                          setState(() => _readinessDate = date),
                    ),
                  ),
                  _field(
                    'inspectionFindings',
                    'Inspection Findings',
                    maxLines: 4,
                  ),
                  _field(
                    'deficiencies',
                    'Deficiencies / Non-Conformities',
                    maxLines: 4,
                  ),
                  _sectionTitle(
                    'Corrective Action',
                    Icons.assignment_late_outlined,
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
                    'HSE Verification & Approval',
                    Icons.verified_outlined,
                  ),
                  _field('verifiedBy', 'Verified By'),
                  _dateField(
                    'Verification Date',
                    _verificationDate,
                    () => _pickDate(
                      current: _verificationDate,
                      onPicked: (date) =>
                          setState(() => _verificationDate = date),
                    ),
                  ),
                  _field(
                    'verificationRemarks',
                    'Verification Remarks',
                    maxLines: 3,
                  ),
                  _field('approvedBy', 'Approved By'),
                  _dateField(
                    'Approval Date',
                    _approvalDate,
                    () => _pickDate(
                      current: _approvalDate,
                      onPicked: (date) =>
                          setState(() => _approvalDate = date),
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
                      onPressed: _saving ? null : _save,
                      icon: const Icon(Icons.save_outlined),
                      label: Text(
                        _saving
                            ? 'Saving...'
                            : 'Save Facility Record',
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

class _FacilityDetailsSheet extends StatelessWidget {
  final SiteFacilityRecord record;

  const _FacilityDetailsSheet({required this.record});

  static const Color darkGreen = Color(0xFF0B5D4B);

  @override
  Widget build(BuildContext context) {
    final items = <String, String>{
      'Facility No.': record.facilityNo,
      'Project': record.projectName,
      'Project Code': record.projectCode,
      'Site Location': record.siteLocation,
      'Facility Type': record.facilityType,
      'Facility Name': record.facilityName,
      'Area': record.area,
      'Responsible Person': record.responsiblePerson,
      'Contractor / Supplier': record.contractor,
      'Status': record.status,
      'Capacity': record.capacity,
      'Quantity': record.quantity,
      'Condition': record.condition,
      'Water Supply': record.waterSupply,
      'Sanitation': record.sanitation,
      'Cleaning Frequency': record.cleaningFrequency,
      'Lighting': record.lighting,
      'Ventilation': record.ventilation,
      'Accessibility': record.accessibility,
      'Privacy': record.privacy,
      'Fire Safety': record.fireSafety,
      'First Aid / Medical': record.firstAid,
      'Emergency Access': record.emergencyAccess,
      'Waste Management': record.wasteManagement,
      'Pest Control': record.pestControl,
      'Temperature / Cooling': record.temperatureControl,
      'Heat Stress Welfare': record.heatStressControl,
      'Inspection Frequency': record.inspectionFrequency,
      'Last Inspection': _formatDate(record.lastInspectionDate),
      'Next Inspection': _formatDate(record.nextInspectionDate),
      'Readiness Date': _formatDate(record.readinessDate),
      'Inspection Findings': record.inspectionFindings,
      'Deficiencies': record.deficiencies,
      'Corrective Actions': record.correctiveActions,
      'Action Owner': record.actionOwner,
      'Action Due': _formatDate(record.actionDueDate),
      'Verified By': record.verifiedBy,
      'Verification Date': _formatDate(record.verificationDate),
      'Verification Remarks': record.verificationRemarks,
      'Approved By': record.approvedBy,
      'Approval Date': _formatDate(record.approvalDate),
      'Approval Remarks': record.approvalRemarks,
      'Supporting Documents': record.supportingDocuments,
      'Remarks': record.remarks,
      'Created': _formatDateTime(record.createdAt),
      'Updated': _formatDateTime(record.updatedAt),
    };

    return SafeArea(
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.90,
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
                  const Expanded(
                    child: Text(
                      'Facility Details',
                      style: TextStyle(
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
