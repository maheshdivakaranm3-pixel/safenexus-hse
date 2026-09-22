import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemporaryFacilitiesUtilitiesPage extends StatefulWidget {
  const TemporaryFacilitiesUtilitiesPage({super.key});

  @override
  State<TemporaryFacilitiesUtilitiesPage> createState() =>
      _TemporaryFacilitiesUtilitiesPageState();
}

class _TemporaryFacilitiesUtilitiesPageState
    extends State<TemporaryFacilitiesUtilitiesPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_temporary_facilities_utilities';

  final List<TemporaryUtilityRecord> _records = [];
  String _search = '';
  String _statusFilter = 'All';
  String _utilityFilter = 'All';

  static const List<String> statuses = [
    'Draft',
    'Planned',
    'Installation',
    'Inspection Required',
    'Approved',
    'Operational',
    'Maintenance Required',
    'Non-Compliant',
    'Closed',
    'Cancelled',
  ];

  static const List<String> utilityTypes = [
    'Temporary Power',
    'Generator',
    'Temporary Electrical Distribution',
    'Temporary Water Supply',
    'Temporary Lighting',
    'Fuel Storage',
    'Temporary Drainage',
    'Sewage / Wastewater',
    'Communication / Internet',
    'Emergency Backup Power',
    'Compressed Air',
    'Temporary Gas',
    'Other',
  ];

  static const List<String> facilityAreas = [
    'Site Office',
    'Welfare Area',
    'Accommodation',
    'Workshop',
    'Warehouse / Storage',
    'Canteen',
    'Medical / First Aid',
    'Security Gate',
    'Construction Area',
    'Plant Area',
    'Entire Site',
    'Other',
  ];

  static const List<String> supplyMethods = [
    'Grid Supply',
    'Generator',
    'Water Tanker',
    'Water Tank',
    'Bore / Well',
    'Temporary Connection',
    'Municipal Connection',
    'Contractor Supply',
    'Other',
  ];

  static const List<String> inspectionFrequencies = [
    'Daily',
    'Weekly',
    'Monthly',
    'Before Use',
    'After Maintenance',
    'As Required',
  ];

  static const List<String> conditionOptions = [
    'Good',
    'Satisfactory',
    'Needs Attention',
    'Poor',
    'Not Applicable',
  ];

  static const List<String> isolationOptions = [
    'Not Required',
    'LOTO Required',
    'Electrical Isolation',
    'Mechanical Isolation',
    'Valve Isolation',
    'Multiple Isolation',
  ];

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(storageKey) ?? [];
    _records
      ..clear()
      ..addAll(
        raw.map((item) {
          try {
            return TemporaryUtilityRecord.fromJson(
              jsonDecode(item) as Map<String, dynamic>,
            );
          } catch (_) {
            return null;
          }
        }).whereType<TemporaryUtilityRecord>(),
      );
    if (mounted) setState(() {});
  }

  Future<void> _saveAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      storageKey,
      _records.map((record) => jsonEncode(record.toJson())).toList(),
    );
  }

  List<TemporaryUtilityRecord> get _filteredRecords {
    final query = _search.trim().toLowerCase();
    return _records.where((record) {
      final matchesSearch = query.isEmpty ||
          record.utilityNo.toLowerCase().contains(query) ||
          record.project.toLowerCase().contains(query) ||
          record.location.toLowerCase().contains(query) ||
          record.utilityType.toLowerCase().contains(query) ||
          record.responsiblePerson.toLowerCase().contains(query);

      final matchesStatus =
          _statusFilter == 'All' || record.status == _statusFilter;
      final matchesUtility =
          _utilityFilter == 'All' || record.utilityType == _utilityFilter;

      return matchesSearch && matchesStatus && matchesUtility;
    }).toList();
  }

  int _countStatus(String status) =>
      _records.where((record) => record.status == status).length;

  int get _overdueCount => _records.where((record) {
        final due = _tryDate(record.nextInspectionDate);
        if (due == null) return false;
        return due.isBefore(_today) &&
            record.status != 'Closed' &&
            record.status != 'Cancelled';
      }).length;

  DateTime get _today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  DateTime? _tryDate(String value) {
    if (value.trim().isEmpty) return null;
    return DateTime.tryParse(value);
  }

  String _displayDate(String value) {
    final date = _tryDate(value);
    if (date == null) return '-';
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _openForm({TemporaryUtilityRecord? existing}) async {
    final result = await showModalBottomSheet<TemporaryUtilityRecord>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _TemporaryUtilityFormSheet(
        existing: existing,
        utilityTypes: utilityTypes,
        facilityAreas: facilityAreas,
        supplyMethods: supplyMethods,
        inspectionFrequencies: inspectionFrequencies,
        conditionOptions: conditionOptions,
        isolationOptions: isolationOptions,
        statuses: statuses,
      ),
    );

    if (result == null) return;

    final index = existing == null ? -1 : _records.indexOf(existing);
    setState(() {
      if (index >= 0) {
        _records[index] = result.copyWith(
          createdAt: existing!.createdAt,
          updatedAt: DateTime.now().toIso8601String(),
        );
      } else {
        _records.insert(0, result);
      }
    });
    await _saveAll();
  }

  Future<void> _deleteRecord(TemporaryUtilityRecord record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Record'),
        content: Text('Delete ${record.utilityNo}? This cannot be undone.'),
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
    setState(() => _records.remove(record));
    await _saveAll();
  }

  void _showDetails(TemporaryUtilityRecord record) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _DetailsSheet(
        record: record,
        displayDate: _displayDate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final records = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('5D Temporary Facilities & Utilities'),
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
        label: const Text('Add Utility'),
      ),
      body: Column(
        children: [
          _buildSummary(),
          _buildFilters(),
          Expanded(
            child: records.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 90),
                    itemCount: records.length,
                    itemBuilder: (_, index) => _buildCard(records[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    final operational = _countStatus('Operational');
    final approved = _countStatus('Approved');
    final maintenance = _countStatus('Maintenance Required');
    final nonCompliant = _countStatus('Non-Compliant');

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _metric('Total', _records.length, Icons.dashboard_outlined),
          _metric('Operational', operational, Icons.power),
          _metric('Approved', approved, Icons.verified_outlined),
          _metric('Maintenance', maintenance, Icons.build_outlined),
          _metric('Non-Compliant', nonCompliant, Icons.warning_amber),
          _metric('Overdue', _overdueCount, Icons.event_busy),
        ],
      ),
    );
  }

  Widget _metric(String title, int value, IconData icon) {
    return Container(
      width: 112,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 19, color: darkGreen),
          const SizedBox(height: 6),
          Text(
            '$value',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search utility no., project, location...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _search.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () => setState(() => _search = ''),
                      icon: const Icon(Icons.clear),
                    ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) => setState(() => _search = value),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _statusFilter,
                  decoration: _compactDecoration('Status'),
                  items: ['All', ...statuses]
                      .map((value) =>
                          DropdownMenuItem(value: value, child: Text(value)))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _statusFilter = value ?? 'All'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _utilityFilter,
                  decoration: _compactDecoration('Utility Type'),
                  items: ['All', ...utilityTypes]
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text(value, overflow: TextOverflow.ellipsis),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _utilityFilter = value ?? 'All'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _compactDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.electrical_services_outlined,
                size: 64, color: darkGreen.withValues(alpha: 0.45)),
            const SizedBox(height: 12),
            const Text(
              'No temporary facility or utility records',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add temporary power, water, lighting, drainage, fuel, '
              'communication and other site utilities.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(TemporaryUtilityRecord record) {
    final due = _tryDate(record.nextInspectionDate);
    final overdue = due != null &&
        due.isBefore(_today) &&
        record.status != 'Closed' &&
        record.status != 'Cancelled';

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0.8,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showDetails(record),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      record.utilityNo,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  _statusChip(record.status),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') _openForm(existing: record);
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
                record.utilityType,
                style: const TextStyle(
                  color: darkGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 7),
              _infoLine(Icons.location_on_outlined, record.location),
              _infoLine(Icons.business_outlined, record.project),
              _infoLine(Icons.person_outline, record.responsiblePerson),
              _infoLine(Icons.calendar_month_outlined,
                  'Next inspection: ${_displayDate(record.nextInspectionDate)}'),
              if (overdue)
                const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    '• OVERDUE INSPECTION',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (record.correctiveAction.trim().isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    'Action: ${record.correctiveAction}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoLine(IconData icon, String text) {
    if (text.trim().isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade700),
          const SizedBox(width: 6),
          Expanded(
            child: Text(text, maxLines: 2, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(String status) {
    Color color;
    if (status == 'Operational' || status == 'Approved') {
      color = Colors.green;
    } else if (status == 'Non-Compliant' ||
        status == 'Maintenance Required') {
      color = Colors.orange.shade800;
    } else if (status == 'Closed' || status == 'Cancelled') {
      color = Colors.grey.shade700;
    } else {
      color = darkGreen;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class TemporaryUtilityRecord {
  final String id;
  final String utilityNo;
  final String project;
  final String location;
  final String department;
  final String utilityType;
  final String facilityArea;
  final String description;
  final String supplyMethod;
  final String capacity;
  final String quantity;
  final String responsiblePerson;
  final String contractor;
  final String installationDate;
  final String commissioningDate;
  final String inspectionFrequency;
  final String lastInspectionDate;
  final String nextInspectionDate;
  final String condition;
  final String electricalProtection;
  final String grounding;
  final String isolationMethod;
  final String emergencyBackup;
  final String fireProtection;
  final String environmentalControls;
  final String accessProtection;
  final String signage;
  final String maintenancePlan;
  final String inspectionFindings;
  final String hazards;
  final String correctiveAction;
  final String actionOwner;
  final String actionDueDate;
  final String verification;
  final String approval;
  final String supportingDocuments;
  final String status;
  final String remarks;
  final String createdAt;
  final String updatedAt;

  const TemporaryUtilityRecord({
    required this.id,
    required this.utilityNo,
    required this.project,
    required this.location,
    required this.department,
    required this.utilityType,
    required this.facilityArea,
    required this.description,
    required this.supplyMethod,
    required this.capacity,
    required this.quantity,
    required this.responsiblePerson,
    required this.contractor,
    required this.installationDate,
    required this.commissioningDate,
    required this.inspectionFrequency,
    required this.lastInspectionDate,
    required this.nextInspectionDate,
    required this.condition,
    required this.electricalProtection,
    required this.grounding,
    required this.isolationMethod,
    required this.emergencyBackup,
    required this.fireProtection,
    required this.environmentalControls,
    required this.accessProtection,
    required this.signage,
    required this.maintenancePlan,
    required this.inspectionFindings,
    required this.hazards,
    required this.correctiveAction,
    required this.actionOwner,
    required this.actionDueDate,
    required this.verification,
    required this.approval,
    required this.supportingDocuments,
    required this.status,
    required this.remarks,
    required this.createdAt,
    required this.updatedAt,
  });

  TemporaryUtilityRecord copyWith({
    String? createdAt,
    String? updatedAt,
  }) {
    return TemporaryUtilityRecord(
      id: id,
      utilityNo: utilityNo,
      project: project,
      location: location,
      department: department,
      utilityType: utilityType,
      facilityArea: facilityArea,
      description: description,
      supplyMethod: supplyMethod,
      capacity: capacity,
      quantity: quantity,
      responsiblePerson: responsiblePerson,
      contractor: contractor,
      installationDate: installationDate,
      commissioningDate: commissioningDate,
      inspectionFrequency: inspectionFrequency,
      lastInspectionDate: lastInspectionDate,
      nextInspectionDate: nextInspectionDate,
      condition: condition,
      electricalProtection: electricalProtection,
      grounding: grounding,
      isolationMethod: isolationMethod,
      emergencyBackup: emergencyBackup,
      fireProtection: fireProtection,
      environmentalControls: environmentalControls,
      accessProtection: accessProtection,
      signage: signage,
      maintenancePlan: maintenancePlan,
      inspectionFindings: inspectionFindings,
      hazards: hazards,
      correctiveAction: correctiveAction,
      actionOwner: actionOwner,
      actionDueDate: actionDueDate,
      verification: verification,
      approval: approval,
      supportingDocuments: supportingDocuments,
      status: status,
      remarks: remarks,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'utilityNo': utilityNo,
        'project': project,
        'location': location,
        'department': department,
        'utilityType': utilityType,
        'facilityArea': facilityArea,
        'description': description,
        'supplyMethod': supplyMethod,
        'capacity': capacity,
        'quantity': quantity,
        'responsiblePerson': responsiblePerson,
        'contractor': contractor,
        'installationDate': installationDate,
        'commissioningDate': commissioningDate,
        'inspectionFrequency': inspectionFrequency,
        'lastInspectionDate': lastInspectionDate,
        'nextInspectionDate': nextInspectionDate,
        'condition': condition,
        'electricalProtection': electricalProtection,
        'grounding': grounding,
        'isolationMethod': isolationMethod,
        'emergencyBackup': emergencyBackup,
        'fireProtection': fireProtection,
        'environmentalControls': environmentalControls,
        'accessProtection': accessProtection,
        'signage': signage,
        'maintenancePlan': maintenancePlan,
        'inspectionFindings': inspectionFindings,
        'hazards': hazards,
        'correctiveAction': correctiveAction,
        'actionOwner': actionOwner,
        'actionDueDate': actionDueDate,
        'verification': verification,
        'approval': approval,
        'supportingDocuments': supportingDocuments,
        'status': status,
        'remarks': remarks,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  factory TemporaryUtilityRecord.fromJson(Map<String, dynamic> json) {
    String read(String key) => json[key]?.toString() ?? '';
    return TemporaryUtilityRecord(
      id: read('id'),
      utilityNo: read('utilityNo'),
      project: read('project'),
      location: read('location'),
      department: read('department'),
      utilityType: read('utilityType'),
      facilityArea: read('facilityArea'),
      description: read('description'),
      supplyMethod: read('supplyMethod'),
      capacity: read('capacity'),
      quantity: read('quantity'),
      responsiblePerson: read('responsiblePerson'),
      contractor: read('contractor'),
      installationDate: read('installationDate'),
      commissioningDate: read('commissioningDate'),
      inspectionFrequency: read('inspectionFrequency'),
      lastInspectionDate: read('lastInspectionDate'),
      nextInspectionDate: read('nextInspectionDate'),
      condition: read('condition'),
      electricalProtection: read('electricalProtection'),
      grounding: read('grounding'),
      isolationMethod: read('isolationMethod'),
      emergencyBackup: read('emergencyBackup'),
      fireProtection: read('fireProtection'),
      environmentalControls: read('environmentalControls'),
      accessProtection: read('accessProtection'),
      signage: read('signage'),
      maintenancePlan: read('maintenancePlan'),
      inspectionFindings: read('inspectionFindings'),
      hazards: read('hazards'),
      correctiveAction: read('correctiveAction'),
      actionOwner: read('actionOwner'),
      actionDueDate: read('actionDueDate'),
      verification: read('verification'),
      approval: read('approval'),
      supportingDocuments: read('supportingDocuments'),
      status: read('status'),
      remarks: read('remarks'),
      createdAt: read('createdAt'),
      updatedAt: read('updatedAt'),
    );
  }
}

class _TemporaryUtilityFormSheet extends StatefulWidget {
  final TemporaryUtilityRecord? existing;
  final List<String> utilityTypes;
  final List<String> facilityAreas;
  final List<String> supplyMethods;
  final List<String> inspectionFrequencies;
  final List<String> conditionOptions;
  final List<String> isolationOptions;
  final List<String> statuses;

  const _TemporaryUtilityFormSheet({
    required this.existing,
    required this.utilityTypes,
    required this.facilityAreas,
    required this.supplyMethods,
    required this.inspectionFrequencies,
    required this.conditionOptions,
    required this.isolationOptions,
    required this.statuses,
  });

  @override
  State<_TemporaryUtilityFormSheet> createState() =>
      _TemporaryUtilityFormSheetState();
}

class _TemporaryUtilityFormSheetState
    extends State<_TemporaryUtilityFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController utilityNo;
  late final TextEditingController project;
  late final TextEditingController location;
  late final TextEditingController department;
  late final TextEditingController description;
  late final TextEditingController capacity;
  late final TextEditingController quantity;
  late final TextEditingController responsiblePerson;
  late final TextEditingController contractor;
  late final TextEditingController installationDate;
  late final TextEditingController commissioningDate;
  late final TextEditingController lastInspectionDate;
  late final TextEditingController nextInspectionDate;
  late final TextEditingController electricalProtection;
  late final TextEditingController grounding;
  late final TextEditingController emergencyBackup;
  late final TextEditingController fireProtection;
  late final TextEditingController environmentalControls;
  late final TextEditingController accessProtection;
  late final TextEditingController signage;
  late final TextEditingController maintenancePlan;
  late final TextEditingController inspectionFindings;
  late final TextEditingController hazards;
  late final TextEditingController correctiveAction;
  late final TextEditingController actionOwner;
  late final TextEditingController actionDueDate;
  late final TextEditingController verification;
  late final TextEditingController approval;
  late final TextEditingController supportingDocuments;
  late final TextEditingController remarks;

  String? utilityType;
  String? facilityArea;
  String? supplyMethod;
  String? inspectionFrequency;
  String? condition;
  String? isolationMethod;
  String? status;

  @override
  void initState() {
    super.initState();
    final r = widget.existing;
    utilityNo = TextEditingController(text: r?.utilityNo ?? '');
    project = TextEditingController(text: r?.project ?? '');
    location = TextEditingController(text: r?.location ?? '');
    department = TextEditingController(text: r?.department ?? '');
    description = TextEditingController(text: r?.description ?? '');
    capacity = TextEditingController(text: r?.capacity ?? '');
    quantity = TextEditingController(text: r?.quantity ?? '');
    responsiblePerson =
        TextEditingController(text: r?.responsiblePerson ?? '');
    contractor = TextEditingController(text: r?.contractor ?? '');
    installationDate =
        TextEditingController(text: r?.installationDate ?? '');
    commissioningDate =
        TextEditingController(text: r?.commissioningDate ?? '');
    lastInspectionDate =
        TextEditingController(text: r?.lastInspectionDate ?? '');
    nextInspectionDate =
        TextEditingController(text: r?.nextInspectionDate ?? '');
    electricalProtection =
        TextEditingController(text: r?.electricalProtection ?? '');
    grounding = TextEditingController(text: r?.grounding ?? '');
    emergencyBackup = TextEditingController(text: r?.emergencyBackup ?? '');
    fireProtection = TextEditingController(text: r?.fireProtection ?? '');
    environmentalControls =
        TextEditingController(text: r?.environmentalControls ?? '');
    accessProtection =
        TextEditingController(text: r?.accessProtection ?? '');
    signage = TextEditingController(text: r?.signage ?? '');
    maintenancePlan = TextEditingController(text: r?.maintenancePlan ?? '');
    inspectionFindings =
        TextEditingController(text: r?.inspectionFindings ?? '');
    hazards = TextEditingController(text: r?.hazards ?? '');
    correctiveAction = TextEditingController(text: r?.correctiveAction ?? '');
    actionOwner = TextEditingController(text: r?.actionOwner ?? '');
    actionDueDate = TextEditingController(text: r?.actionDueDate ?? '');
    verification = TextEditingController(text: r?.verification ?? '');
    approval = TextEditingController(text: r?.approval ?? '');
    supportingDocuments =
        TextEditingController(text: r?.supportingDocuments ?? '');
    remarks = TextEditingController(text: r?.remarks ?? '');

    utilityType = r?.utilityType.isNotEmpty == true
        ? r!.utilityType
        : widget.utilityTypes.first;
    facilityArea = r?.facilityArea.isNotEmpty == true
        ? r!.facilityArea
        : widget.facilityAreas.first;
    supplyMethod = r?.supplyMethod.isNotEmpty == true
        ? r!.supplyMethod
        : widget.supplyMethods.first;
    inspectionFrequency = r?.inspectionFrequency.isNotEmpty == true
        ? r!.inspectionFrequency
        : widget.inspectionFrequencies.first;
    condition = r?.condition.isNotEmpty == true
        ? r!.condition
        : widget.conditionOptions.first;
    isolationMethod = r?.isolationMethod.isNotEmpty == true
        ? r!.isolationMethod
        : widget.isolationOptions.first;
    status = r?.status.isNotEmpty == true ? r!.status : 'Draft';
  }

  @override
  void dispose() {
    for (final controller in [
      utilityNo,
      project,
      location,
      department,
      description,
      capacity,
      quantity,
      responsiblePerson,
      contractor,
      installationDate,
      commissioningDate,
      lastInspectionDate,
      nextInspectionDate,
      electricalProtection,
      grounding,
      emergencyBackup,
      fireProtection,
      environmentalControls,
      accessProtection,
      signage,
      maintenancePlan,
      inspectionFindings,
      hazards,
      correctiveAction,
      actionOwner,
      actionDueDate,
      verification,
      approval,
      supportingDocuments,
      remarks,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    bool required = false,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: _decoration(label),
        validator: required
            ? (value) => value == null || value.trim().isEmpty
                ? '$label is required'
                : null
            : null,
      ),
    );
  }

  Widget _dropdown(
    String label,
    String? value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: _decoration(label),
        items: items
            .map((item) =>
                DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _section(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: darkGreen),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate(TextEditingController controller) async {
    final initial = DateTime.tryParse(controller.text) ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: initial,
    );
    if (picked == null) return;
    controller.text =
        '${picked.year.toString().padLeft(4, '0')}-'
        '${picked.month.toString().padLeft(2, '0')}-'
        '${picked.day.toString().padLeft(2, '0')}';
    setState(() {});
  }

  Widget _dateField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: _decoration(label).copyWith(
          suffixIcon: const Icon(Icons.calendar_month),
        ),
        onTap: () => _pickDate(controller),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now().toIso8601String();
    final record = TemporaryUtilityRecord(
      id: widget.existing?.id ?? now,
      utilityNo: utilityNo.text.trim(),
      project: project.text.trim(),
      location: location.text.trim(),
      department: department.text.trim(),
      utilityType: utilityType ?? widget.utilityTypes.first,
      facilityArea: facilityArea ?? widget.facilityAreas.first,
      description: description.text.trim(),
      supplyMethod: supplyMethod ?? widget.supplyMethods.first,
      capacity: capacity.text.trim(),
      quantity: quantity.text.trim(),
      responsiblePerson: responsiblePerson.text.trim(),
      contractor: contractor.text.trim(),
      installationDate: installationDate.text.trim(),
      commissioningDate: commissioningDate.text.trim(),
      inspectionFrequency:
          inspectionFrequency ?? widget.inspectionFrequencies.first,
      lastInspectionDate: lastInspectionDate.text.trim(),
      nextInspectionDate: nextInspectionDate.text.trim(),
      condition: condition ?? widget.conditionOptions.first,
      electricalProtection: electricalProtection.text.trim(),
      grounding: grounding.text.trim(),
      isolationMethod: isolationMethod ?? widget.isolationOptions.first,
      emergencyBackup: emergencyBackup.text.trim(),
      fireProtection: fireProtection.text.trim(),
      environmentalControls: environmentalControls.text.trim(),
      accessProtection: accessProtection.text.trim(),
      signage: signage.text.trim(),
      maintenancePlan: maintenancePlan.text.trim(),
      inspectionFindings: inspectionFindings.text.trim(),
      hazards: hazards.text.trim(),
      correctiveAction: correctiveAction.text.trim(),
      actionOwner: actionOwner.text.trim(),
      actionDueDate: actionDueDate.text.trim(),
      verification: verification.text.trim(),
      approval: approval.text.trim(),
      supportingDocuments: supportingDocuments.text.trim(),
      status: status ?? 'Draft',
      remarks: remarks.text.trim(),
      createdAt: widget.existing?.createdAt ?? now,
      updatedAt: now,
    );

    Navigator.pop(context, record);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.94,
        decoration: const BoxDecoration(
          color: Color(0xFFF6F8F7),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 8, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.existing == null
                          ? 'Add Temporary Facility / Utility'
                          : 'Edit Temporary Facility / Utility',
                      style: const TextStyle(
                        fontSize: 19,
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
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.fromLTRB(16, 4, 16, 30 + bottom),
                  children: [
                    _section('1. Record & Site Information',
                        Icons.assignment_outlined),
                    _field(utilityNo, 'Utility / Facility Record No.',
                        required: true),
                    _field(project, 'Project', required: true),
                    _field(location, 'Location / Area', required: true),
                    _field(department, 'Department / Contractor'),
                    _dropdown('Utility Type', utilityType,
                        widget.utilityTypes, (v) => setState(() => utilityType = v)),
                    _dropdown('Facility Area', facilityArea,
                        widget.facilityAreas, (v) => setState(() => facilityArea = v)),
                    _field(description, 'Description / Purpose', maxLines: 3),

                    _section('2. Supply & Capacity', Icons.electrical_services),
                    _dropdown('Supply Method', supplyMethod,
                        widget.supplyMethods, (v) => setState(() => supplyMethod = v)),
                    _field(capacity, 'Capacity / Rating'),
                    _field(quantity, 'Quantity'),
                    _field(responsiblePerson, 'Responsible Person', required: true),
                    _field(contractor, 'Installation / Maintenance Contractor'),

                    _section('3. Installation & Inspection',
                        Icons.fact_check_outlined),
                    _dateField(installationDate, 'Installation Date'),
                    _dateField(commissioningDate, 'Commissioning / Energization Date'),
                    _dropdown('Inspection Frequency', inspectionFrequency,
                        widget.inspectionFrequencies,
                        (v) => setState(() => inspectionFrequency = v)),
                    _dateField(lastInspectionDate, 'Last Inspection Date'),
                    _dateField(nextInspectionDate, 'Next Inspection Date'),
                    _dropdown('Condition / Readiness', condition,
                        widget.conditionOptions,
                        (v) => setState(() => condition = v)),

                    _section('4. HSE Controls', Icons.health_and_safety_outlined),
                    _field(electricalProtection,
                        'Electrical Protection / Distribution Controls',
                        maxLines: 3),
                    _field(grounding, 'Grounding / Earthing Arrangement',
                        maxLines: 2),
                    _dropdown('Isolation / LOTO', isolationMethod,
                        widget.isolationOptions,
                        (v) => setState(() => isolationMethod = v)),
                    _field(emergencyBackup, 'Emergency Backup Arrangement',
                        maxLines: 2),
                    _field(fireProtection, 'Fire Protection / Extinguishers',
                        maxLines: 2),
                    _field(environmentalControls,
                        'Environmental Controls / Spill / Waste / Drainage',
                        maxLines: 3),
                    _field(accessProtection,
                        'Access Protection / Guards / Barricades',
                        maxLines: 2),
                    _field(signage, 'Warning Signs / Identification',
                        maxLines: 2),
                    _field(maintenancePlan, 'Maintenance Plan / Preventive Controls',
                        maxLines: 3),

                    _section('5. Findings & Corrective Action',
                        Icons.rule_folder_outlined),
                    _field(inspectionFindings, 'Inspection Findings',
                        maxLines: 4),
                    _field(hazards, 'Hazards / Deficiencies',
                        maxLines: 4),
                    _field(correctiveAction, 'Corrective / Preventive Action',
                        maxLines: 4),
                    _field(actionOwner, 'Action Owner'),
                    _dateField(actionDueDate, 'Action Due Date'),
                    _field(verification, 'Verification / Effectiveness',
                        maxLines: 3),

                    _section('6. Approval & Record Control',
                        Icons.verified_user_outlined),
                    _dropdown('Status', status, widget.statuses,
                        (v) => setState(() => status = v)),
                    _field(approval, 'Approval / Authorization',
                        maxLines: 3),
                    _field(supportingDocuments,
                        'Supporting Documents / Certificates',
                        maxLines: 3),
                    _field(remarks, 'Remarks', maxLines: 4),

                    const SizedBox(height: 8),
                    SizedBox(
                      height: 50,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: primaryGreen,
                        ),
                        onPressed: _submit,
                        icon: const Icon(Icons.save_outlined),
                        label: Text(
                          widget.existing == null
                              ? 'Save Record'
                              : 'Update Record',
                        ),
                      ),
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

class _DetailsSheet extends StatelessWidget {
  final TemporaryUtilityRecord record;
  final String Function(String) displayDate;

  const _DetailsSheet({
    required this.record,
    required this.displayDate,
  });

  Widget _row(String label, String value) {
    if (value.trim().isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 2),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.86,
        child: Material(
          color: const Color(0xFFF6F8F7),
          child: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Utility Record Details',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              _row('Record No.', record.utilityNo),
              _row('Utility Type', record.utilityType),
              _row('Project', record.project),
              _row('Location', record.location),
              _row('Department / Contractor', record.department),
              _row('Facility Area', record.facilityArea),
              _row('Description', record.description),
              _row('Supply Method', record.supplyMethod),
              _row('Capacity', record.capacity),
              _row('Quantity', record.quantity),
              _row('Responsible Person', record.responsiblePerson),
              _row('Contractor', record.contractor),
              _row('Installation Date', displayDate(record.installationDate)),
              _row('Commissioning Date', displayDate(record.commissioningDate)),
              _row('Inspection Frequency', record.inspectionFrequency),
              _row('Last Inspection', displayDate(record.lastInspectionDate)),
              _row('Next Inspection', displayDate(record.nextInspectionDate)),
              _row('Condition', record.condition),
              _row('Electrical Protection', record.electricalProtection),
              _row('Grounding / Earthing', record.grounding),
              _row('Isolation / LOTO', record.isolationMethod),
              _row('Emergency Backup', record.emergencyBackup),
              _row('Fire Protection', record.fireProtection),
              _row('Environmental Controls', record.environmentalControls),
              _row('Access Protection', record.accessProtection),
              _row('Signage', record.signage),
              _row('Maintenance Plan', record.maintenancePlan),
              _row('Inspection Findings', record.inspectionFindings),
              _row('Hazards / Deficiencies', record.hazards),
              _row('Corrective Action', record.correctiveAction),
              _row('Action Owner', record.actionOwner),
              _row('Action Due Date', displayDate(record.actionDueDate)),
              _row('Verification', record.verification),
              _row('Approval', record.approval),
              _row('Supporting Documents', record.supportingDocuments),
              _row('Status', record.status),
              _row('Remarks', record.remarks),
              _row('Created', record.createdAt),
              _row('Last Updated', record.updatedAt),
            ],
          ),
        ),
      ),
    );
  }
}
