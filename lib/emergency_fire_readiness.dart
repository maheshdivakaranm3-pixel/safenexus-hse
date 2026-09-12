import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyFireReadinessPage extends StatefulWidget {
  const EmergencyFireReadinessPage({super.key});

  @override
  State<EmergencyFireReadinessPage> createState() =>
      _EmergencyFireReadinessPageState();
}

class _EmergencyFireReadinessPageState
    extends State<EmergencyFireReadinessPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_emergency_fire_readiness';

  final List<EmergencyFireRecord> _records = [];
  String _search = '';
  String _statusFilter = 'All';
  String _typeFilter = 'All';

  static const List<String> emergencyTypes = [
    'Emergency & Fire Readiness',
    'Fire Protection System',
    'Emergency Evacuation',
    'Fire Alarm & Detection',
    'Emergency Communication',
    'First Aid / Medical Response',
    'Emergency Access & Assembly',
    'Rescue Equipment',
    'Emergency Lighting',
    'Fire Water / Hydrant',
    'Emergency Drill',
    'Other',
  ];

  static const List<String> statuses = [
    'Draft',
    'Planned',
    'Inspection Required',
    'Action Required',
    'Ready',
    'Partially Ready',
    'Not Ready',
    'Drill Scheduled',
    'Drill Completed',
    'Approved',
    'Closed',
    'Cancelled',
  ];

  static const List<String> readinessOptions = [
    'Ready',
    'Partially Ready',
    'Not Ready',
    'Not Applicable',
  ];

  static const List<String> fireSystemOptions = [
    'Fire Extinguishers',
    'Fire Hydrant',
    'Hose Reel',
    'Fire Alarm',
    'Smoke / Heat Detector',
    'Fire Pump',
    'Sprinkler',
    'Emergency Lighting',
    'Fire Water Tank',
    'Fire Blanket',
    'Gas Detection',
    'None',
    'Other',
  ];

  static const List<String> drillTypes = [
    'Fire Drill',
    'Evacuation Drill',
    'Medical Emergency Drill',
    'Rescue Drill',
    'Emergency Communication Drill',
    'Combined Emergency Drill',
    'Not Applicable',
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
      ..addAll(raw.map((item) {
        try {
          return EmergencyFireRecord.fromJson(
            jsonDecode(item) as Map<String, dynamic>,
          );
        } catch (_) {
          return null;
        }
      }).whereType<EmergencyFireRecord>());
    if (mounted) setState(() {});
  }

  Future<void> _saveAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      storageKey,
      _records.map((record) => jsonEncode(record.toJson())).toList(),
    );
  }

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

  int _countStatus(String status) =>
      _records.where((record) => record.status == status).length;

  int get _overdueCount => _records.where((record) {
        final due = _tryDate(record.nextInspectionDate);
        if (due == null) return false;
        return due.isBefore(_today) &&
            record.status != 'Closed' &&
            record.status != 'Cancelled';
      }).length;

  List<EmergencyFireRecord> get _filteredRecords {
    final query = _search.trim().toLowerCase();
    return _records.where((record) {
      final matchesSearch = query.isEmpty ||
          record.recordNo.toLowerCase().contains(query) ||
          record.project.toLowerCase().contains(query) ||
          record.location.toLowerCase().contains(query) ||
          record.emergencyType.toLowerCase().contains(query) ||
          record.responsiblePerson.toLowerCase().contains(query);

      final matchesStatus =
          _statusFilter == 'All' || record.status == _statusFilter;
      final matchesType =
          _typeFilter == 'All' || record.emergencyType == _typeFilter;

      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  Future<void> _openForm({EmergencyFireRecord? existing}) async {
    final result = await showModalBottomSheet<EmergencyFireRecord>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _EmergencyFireForm(
        existing: existing,
        emergencyTypes: emergencyTypes,
        statuses: statuses,
        readinessOptions: readinessOptions,
        fireSystemOptions: fireSystemOptions,
        drillTypes: drillTypes,
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

  Future<void> _deleteRecord(EmergencyFireRecord record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Record'),
        content: Text('Delete ${record.recordNo}? This cannot be undone.'),
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

  void _showDetails(EmergencyFireRecord record) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _EmergencyFireDetails(
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
        title: const Text('5E Emergency & Fire Readiness'),
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
        label: const Text('Add Readiness'),
      ),
      body: Column(
        children: [
          _buildSummary(),
          _buildFilters(),
          Expanded(
            child: records.isEmpty
                ? _buildEmpty()
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _metric('Total', _records.length, Icons.dashboard_outlined),
          _metric('Ready', _countStatus('Ready'), Icons.verified_outlined),
          _metric(
            'Action Required',
            _countStatus('Action Required'),
            Icons.warning_amber_outlined,
          ),
          _metric(
            'Not Ready',
            _countStatus('Not Ready'),
            Icons.error_outline,
          ),
          _metric(
            'Drills',
            _countStatus('Drill Completed'),
            Icons.local_fire_department_outlined,
          ),
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
              hintText: 'Search record no., project, location...',
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
                  decoration: _decoration('Status'),
                  items: ['All', ...statuses]
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _statusFilter = value ?? 'All'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _typeFilter,
                  decoration: _decoration('Type'),
                  items: ['All', ...emergencyTypes]
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _typeFilter = value ?? 'All'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _decoration(String label) {
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

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_fire_department_outlined,
              size: 64,
              color: darkGreen.withValues(alpha: 0.45),
            ),
            const SizedBox(height: 12),
            const Text(
              'No emergency or fire readiness records',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Record emergency systems, evacuation readiness, drills, '
              'fire protection and corrective actions.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(EmergencyFireRecord record) {
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
                      record.recordNo,
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
                record.emergencyType,
                style: const TextStyle(
                  color: darkGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 7),
              _info(Icons.location_on_outlined, record.location),
              _info(Icons.business_outlined, record.project),
              _info(Icons.person_outline, record.responsiblePerson),
              _info(
                Icons.calendar_month_outlined,
                'Next inspection: ${_displayDate(record.nextInspectionDate)}',
              ),
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

  Widget _info(IconData icon, String text) {
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
    if (status == 'Ready' || status == 'Approved' || status == 'Drill Completed') {
      color = Colors.green;
    } else if (status == 'Not Ready' || status == 'Action Required') {
      color = Colors.red.shade700;
    } else if (status == 'Partially Ready' ||
        status == 'Inspection Required' ||
        status == 'Drill Scheduled') {
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
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class EmergencyFireRecord {
  final String id;
  final String recordNo;
  final String project;
  final String location;
  final String department;
  final String emergencyType;
  final String responsiblePerson;
  final String emergencyCoordinator;
  final String emergencyContacts;
  final String emergencyPlanReference;
  final String emergencyScenario;
  final String responseProcedure;
  final String evacuationRoute;
  final String assemblyPoint;
  final String emergencyAccess;
  final String fireSystem;
  final String fireExtinguishers;
  final String fireWater;
  final String fireAlarm;
  final String emergencyLighting;
  final String firstAid;
  final String rescueEquipment;
  final String emergencyCommunication;
  final String musterRoll;
  final String trainedResponders;
  final String fireWardens;
  final String ambulanceAccess;
  final String fireServiceAccess;
  final String utilityIsolation;
  final String gasIsolation;
  final String weatherHazards;
  final String environmentalEmergency;
  final String drillType;
  final String lastDrillDate;
  final String nextDrillDate;
  final String drillFindings;
  final String inspectionFrequency;
  final String lastInspectionDate;
  final String nextInspectionDate;
  final String readiness;
  final String findings;
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

  const EmergencyFireRecord({
    required this.id,
    required this.recordNo,
    required this.project,
    required this.location,
    required this.department,
    required this.emergencyType,
    required this.responsiblePerson,
    required this.emergencyCoordinator,
    required this.emergencyContacts,
    required this.emergencyPlanReference,
    required this.emergencyScenario,
    required this.responseProcedure,
    required this.evacuationRoute,
    required this.assemblyPoint,
    required this.emergencyAccess,
    required this.fireSystem,
    required this.fireExtinguishers,
    required this.fireWater,
    required this.fireAlarm,
    required this.emergencyLighting,
    required this.firstAid,
    required this.rescueEquipment,
    required this.emergencyCommunication,
    required this.musterRoll,
    required this.trainedResponders,
    required this.fireWardens,
    required this.ambulanceAccess,
    required this.fireServiceAccess,
    required this.utilityIsolation,
    required this.gasIsolation,
    required this.weatherHazards,
    required this.environmentalEmergency,
    required this.drillType,
    required this.lastDrillDate,
    required this.nextDrillDate,
    required this.drillFindings,
    required this.inspectionFrequency,
    required this.lastInspectionDate,
    required this.nextInspectionDate,
    required this.readiness,
    required this.findings,
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

  EmergencyFireRecord copyWith({
    String? createdAt,
    String? updatedAt,
  }) {
    return EmergencyFireRecord(
      id: id,
      recordNo: recordNo,
      project: project,
      location: location,
      department: department,
      emergencyType: emergencyType,
      responsiblePerson: responsiblePerson,
      emergencyCoordinator: emergencyCoordinator,
      emergencyContacts: emergencyContacts,
      emergencyPlanReference: emergencyPlanReference,
      emergencyScenario: emergencyScenario,
      responseProcedure: responseProcedure,
      evacuationRoute: evacuationRoute,
      assemblyPoint: assemblyPoint,
      emergencyAccess: emergencyAccess,
      fireSystem: fireSystem,
      fireExtinguishers: fireExtinguishers,
      fireWater: fireWater,
      fireAlarm: fireAlarm,
      emergencyLighting: emergencyLighting,
      firstAid: firstAid,
      rescueEquipment: rescueEquipment,
      emergencyCommunication: emergencyCommunication,
      musterRoll: musterRoll,
      trainedResponders: trainedResponders,
      fireWardens: fireWardens,
      ambulanceAccess: ambulanceAccess,
      fireServiceAccess: fireServiceAccess,
      utilityIsolation: utilityIsolation,
      gasIsolation: gasIsolation,
      weatherHazards: weatherHazards,
      environmentalEmergency: environmentalEmergency,
      drillType: drillType,
      lastDrillDate: lastDrillDate,
      nextDrillDate: nextDrillDate,
      drillFindings: drillFindings,
      inspectionFrequency: inspectionFrequency,
      lastInspectionDate: lastInspectionDate,
      nextInspectionDate: nextInspectionDate,
      readiness: readiness,
      findings: findings,
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
        'recordNo': recordNo,
        'project': project,
        'location': location,
        'department': department,
        'emergencyType': emergencyType,
        'responsiblePerson': responsiblePerson,
        'emergencyCoordinator': emergencyCoordinator,
        'emergencyContacts': emergencyContacts,
        'emergencyPlanReference': emergencyPlanReference,
        'emergencyScenario': emergencyScenario,
        'responseProcedure': responseProcedure,
        'evacuationRoute': evacuationRoute,
        'assemblyPoint': assemblyPoint,
        'emergencyAccess': emergencyAccess,
        'fireSystem': fireSystem,
        'fireExtinguishers': fireExtinguishers,
        'fireWater': fireWater,
        'fireAlarm': fireAlarm,
        'emergencyLighting': emergencyLighting,
        'firstAid': firstAid,
        'rescueEquipment': rescueEquipment,
        'emergencyCommunication': emergencyCommunication,
        'musterRoll': musterRoll,
        'trainedResponders': trainedResponders,
        'fireWardens': fireWardens,
        'ambulanceAccess': ambulanceAccess,
        'fireServiceAccess': fireServiceAccess,
        'utilityIsolation': utilityIsolation,
        'gasIsolation': gasIsolation,
        'weatherHazards': weatherHazards,
        'environmentalEmergency': environmentalEmergency,
        'drillType': drillType,
        'lastDrillDate': lastDrillDate,
        'nextDrillDate': nextDrillDate,
        'drillFindings': drillFindings,
        'inspectionFrequency': inspectionFrequency,
        'lastInspectionDate': lastInspectionDate,
        'nextInspectionDate': nextInspectionDate,
        'readiness': readiness,
        'findings': findings,
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

  factory EmergencyFireRecord.fromJson(Map<String, dynamic> json) {
    String read(String key) => json[key]?.toString() ?? '';
    return EmergencyFireRecord(
      id: read('id'),
      recordNo: read('recordNo'),
      project: read('project'),
      location: read('location'),
      department: read('department'),
      emergencyType: read('emergencyType'),
      responsiblePerson: read('responsiblePerson'),
      emergencyCoordinator: read('emergencyCoordinator'),
      emergencyContacts: read('emergencyContacts'),
      emergencyPlanReference: read('emergencyPlanReference'),
      emergencyScenario: read('emergencyScenario'),
      responseProcedure: read('responseProcedure'),
      evacuationRoute: read('evacuationRoute'),
      assemblyPoint: read('assemblyPoint'),
      emergencyAccess: read('emergencyAccess'),
      fireSystem: read('fireSystem'),
      fireExtinguishers: read('fireExtinguishers'),
      fireWater: read('fireWater'),
      fireAlarm: read('fireAlarm'),
      emergencyLighting: read('emergencyLighting'),
      firstAid: read('firstAid'),
      rescueEquipment: read('rescueEquipment'),
      emergencyCommunication: read('emergencyCommunication'),
      musterRoll: read('musterRoll'),
      trainedResponders: read('trainedResponders'),
      fireWardens: read('fireWardens'),
      ambulanceAccess: read('ambulanceAccess'),
      fireServiceAccess: read('fireServiceAccess'),
      utilityIsolation: read('utilityIsolation'),
      gasIsolation: read('gasIsolation'),
      weatherHazards: read('weatherHazards'),
      environmentalEmergency: read('environmentalEmergency'),
      drillType: read('drillType'),
      lastDrillDate: read('lastDrillDate'),
      nextDrillDate: read('nextDrillDate'),
      drillFindings: read('drillFindings'),
      inspectionFrequency: read('inspectionFrequency'),
      lastInspectionDate: read('lastInspectionDate'),
      nextInspectionDate: read('nextInspectionDate'),
      readiness: read('readiness'),
      findings: read('findings'),
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

class _EmergencyFireForm extends StatefulWidget {
  final EmergencyFireRecord? existing;
  final List<String> emergencyTypes;
  final List<String> statuses;
  final List<String> readinessOptions;
  final List<String> fireSystemOptions;
  final List<String> drillTypes;

  const _EmergencyFireForm({
    required this.existing,
    required this.emergencyTypes,
    required this.statuses,
    required this.readinessOptions,
    required this.fireSystemOptions,
    required this.drillTypes,
  });

  @override
  State<_EmergencyFireForm> createState() => _EmergencyFireFormState();
}

class _EmergencyFireFormState extends State<_EmergencyFireForm> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController recordNo;
  late final TextEditingController project;
  late final TextEditingController location;
  late final TextEditingController department;
  late final TextEditingController responsiblePerson;
  late final TextEditingController emergencyCoordinator;
  late final TextEditingController emergencyContacts;
  late final TextEditingController emergencyPlanReference;
  late final TextEditingController emergencyScenario;
  late final TextEditingController responseProcedure;
  late final TextEditingController evacuationRoute;
  late final TextEditingController assemblyPoint;
  late final TextEditingController emergencyAccess;
  late final TextEditingController fireExtinguishers;
  late final TextEditingController fireWater;
  late final TextEditingController fireAlarm;
  late final TextEditingController emergencyLighting;
  late final TextEditingController firstAid;
  late final TextEditingController rescueEquipment;
  late final TextEditingController emergencyCommunication;
  late final TextEditingController musterRoll;
  late final TextEditingController trainedResponders;
  late final TextEditingController fireWardens;
  late final TextEditingController ambulanceAccess;
  late final TextEditingController fireServiceAccess;
  late final TextEditingController utilityIsolation;
  late final TextEditingController gasIsolation;
  late final TextEditingController weatherHazards;
  late final TextEditingController environmentalEmergency;
  late final TextEditingController lastDrillDate;
  late final TextEditingController nextDrillDate;
  late final TextEditingController drillFindings;
  late final TextEditingController inspectionFrequency;
  late final TextEditingController lastInspectionDate;
  late final TextEditingController nextInspectionDate;
  late final TextEditingController findings;
  late final TextEditingController hazards;
  late final TextEditingController correctiveAction;
  late final TextEditingController actionOwner;
  late final TextEditingController actionDueDate;
  late final TextEditingController verification;
  late final TextEditingController approval;
  late final TextEditingController supportingDocuments;
  late final TextEditingController remarks;

  String? emergencyType;
  String? fireSystem;
  String? drillType;
  String? readiness;
  String? status;

  @override
  void initState() {
    super.initState();
    final r = widget.existing;

    recordNo = TextEditingController(text: r?.recordNo ?? '');
    project = TextEditingController(text: r?.project ?? '');
    location = TextEditingController(text: r?.location ?? '');
    department = TextEditingController(text: r?.department ?? '');
    responsiblePerson =
        TextEditingController(text: r?.responsiblePerson ?? '');
    emergencyCoordinator =
        TextEditingController(text: r?.emergencyCoordinator ?? '');
    emergencyContacts =
        TextEditingController(text: r?.emergencyContacts ?? '');
    emergencyPlanReference =
        TextEditingController(text: r?.emergencyPlanReference ?? '');
    emergencyScenario =
        TextEditingController(text: r?.emergencyScenario ?? '');
    responseProcedure =
        TextEditingController(text: r?.responseProcedure ?? '');
    evacuationRoute =
        TextEditingController(text: r?.evacuationRoute ?? '');
    assemblyPoint = TextEditingController(text: r?.assemblyPoint ?? '');
    emergencyAccess =
        TextEditingController(text: r?.emergencyAccess ?? '');
    fireExtinguishers =
        TextEditingController(text: r?.fireExtinguishers ?? '');
    fireWater = TextEditingController(text: r?.fireWater ?? '');
    fireAlarm = TextEditingController(text: r?.fireAlarm ?? '');
    emergencyLighting =
        TextEditingController(text: r?.emergencyLighting ?? '');
    firstAid = TextEditingController(text: r?.firstAid ?? '');
    rescueEquipment =
        TextEditingController(text: r?.rescueEquipment ?? '');
    emergencyCommunication =
        TextEditingController(text: r?.emergencyCommunication ?? '');
    musterRoll = TextEditingController(text: r?.musterRoll ?? '');
    trainedResponders =
        TextEditingController(text: r?.trainedResponders ?? '');
    fireWardens = TextEditingController(text: r?.fireWardens ?? '');
    ambulanceAccess =
        TextEditingController(text: r?.ambulanceAccess ?? '');
    fireServiceAccess =
        TextEditingController(text: r?.fireServiceAccess ?? '');
    utilityIsolation =
        TextEditingController(text: r?.utilityIsolation ?? '');
    gasIsolation = TextEditingController(text: r?.gasIsolation ?? '');
    weatherHazards =
        TextEditingController(text: r?.weatherHazards ?? '');
    environmentalEmergency =
        TextEditingController(text: r?.environmentalEmergency ?? '');
    lastDrillDate = TextEditingController(text: r?.lastDrillDate ?? '');
    nextDrillDate = TextEditingController(text: r?.nextDrillDate ?? '');
    drillFindings = TextEditingController(text: r?.drillFindings ?? '');
    inspectionFrequency =
        TextEditingController(text: r?.inspectionFrequency ?? '');
    lastInspectionDate =
        TextEditingController(text: r?.lastInspectionDate ?? '');
    nextInspectionDate =
        TextEditingController(text: r?.nextInspectionDate ?? '');
    findings = TextEditingController(text: r?.findings ?? '');
    hazards = TextEditingController(text: r?.hazards ?? '');
    correctiveAction =
        TextEditingController(text: r?.correctiveAction ?? '');
    actionOwner = TextEditingController(text: r?.actionOwner ?? '');
    actionDueDate = TextEditingController(text: r?.actionDueDate ?? '');
    verification = TextEditingController(text: r?.verification ?? '');
    approval = TextEditingController(text: r?.approval ?? '');
    supportingDocuments =
        TextEditingController(text: r?.supportingDocuments ?? '');
    remarks = TextEditingController(text: r?.remarks ?? '');

    emergencyType = r?.emergencyType.isNotEmpty == true
        ? r!.emergencyType
        : widget.emergencyTypes.first;
    fireSystem = r?.fireSystem.isNotEmpty == true
        ? r!.fireSystem
        : widget.fireSystemOptions.first;
    drillType = r?.drillType.isNotEmpty == true
        ? r!.drillType
        : widget.drillTypes.first;
    readiness = r?.readiness.isNotEmpty == true
        ? r!.readiness
        : widget.readinessOptions.first;
    status = r?.status.isNotEmpty == true ? r!.status : 'Draft';
  }

  @override
  void dispose() {
    for (final controller in [
      recordNo,
      project,
      location,
      department,
      responsiblePerson,
      emergencyCoordinator,
      emergencyContacts,
      emergencyPlanReference,
      emergencyScenario,
      responseProcedure,
      evacuationRoute,
      assemblyPoint,
      emergencyAccess,
      fireExtinguishers,
      fireWater,
      fireAlarm,
      emergencyLighting,
      firstAid,
      rescueEquipment,
      emergencyCommunication,
      musterRoll,
      trainedResponders,
      fireWardens,
      ambulanceAccess,
      fireServiceAccess,
      utilityIsolation,
      gasIsolation,
      weatherHazards,
      environmentalEmergency,
      lastDrillDate,
      nextDrillDate,
      drillFindings,
      inspectionFrequency,
      lastInspectionDate,
      nextInspectionDate,
      findings,
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
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
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
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ))
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
    final record = EmergencyFireRecord(
      id: widget.existing?.id ?? now,
      recordNo: recordNo.text.trim(),
      project: project.text.trim(),
      location: location.text.trim(),
      department: department.text.trim(),
      emergencyType: emergencyType ?? widget.emergencyTypes.first,
      responsiblePerson: responsiblePerson.text.trim(),
      emergencyCoordinator: emergencyCoordinator.text.trim(),
      emergencyContacts: emergencyContacts.text.trim(),
      emergencyPlanReference: emergencyPlanReference.text.trim(),
      emergencyScenario: emergencyScenario.text.trim(),
      responseProcedure: responseProcedure.text.trim(),
      evacuationRoute: evacuationRoute.text.trim(),
      assemblyPoint: assemblyPoint.text.trim(),
      emergencyAccess: emergencyAccess.text.trim(),
      fireSystem: fireSystem ?? widget.fireSystemOptions.first,
      fireExtinguishers: fireExtinguishers.text.trim(),
      fireWater: fireWater.text.trim(),
      fireAlarm: fireAlarm.text.trim(),
      emergencyLighting: emergencyLighting.text.trim(),
      firstAid: firstAid.text.trim(),
      rescueEquipment: rescueEquipment.text.trim(),
      emergencyCommunication: emergencyCommunication.text.trim(),
      musterRoll: musterRoll.text.trim(),
      trainedResponders: trainedResponders.text.trim(),
      fireWardens: fireWardens.text.trim(),
      ambulanceAccess: ambulanceAccess.text.trim(),
      fireServiceAccess: fireServiceAccess.text.trim(),
      utilityIsolation: utilityIsolation.text.trim(),
      gasIsolation: gasIsolation.text.trim(),
      weatherHazards: weatherHazards.text.trim(),
      environmentalEmergency: environmentalEmergency.text.trim(),
      drillType: drillType ?? widget.drillTypes.first,
      lastDrillDate: lastDrillDate.text.trim(),
      nextDrillDate: nextDrillDate.text.trim(),
      drillFindings: drillFindings.text.trim(),
      inspectionFrequency: inspectionFrequency.text.trim(),
      lastInspectionDate: lastInspectionDate.text.trim(),
      nextInspectionDate: nextInspectionDate.text.trim(),
      readiness: readiness ?? widget.readinessOptions.first,
      findings: findings.text.trim(),
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
                          ? 'Add Emergency / Fire Readiness'
                          : 'Edit Emergency / Fire Readiness',
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
                  padding: EdgeInsets.fromLTRB(
                    16,
                    4,
                    16,
                    30 + bottom,
                  ),
                  children: [
                    _section(
                      '1. Record & Emergency Planning',
                      Icons.assignment_outlined,
                    ),
                    _field(recordNo, 'Readiness Record No.', required: true),
                    _field(project, 'Project', required: true),
                    _field(location, 'Location / Area', required: true),
                    _field(department, 'Department / Contractor'),
                    _dropdown(
                      'Emergency Type',
                      emergencyType,
                      widget.emergencyTypes,
                      (value) => setState(() => emergencyType = value),
                    ),
                    _field(
                      responsiblePerson,
                      'Responsible Person',
                      required: true,
                    ),
                    _field(
                      emergencyCoordinator,
                      'Emergency Coordinator / Controller',
                    ),
                    _field(
                      emergencyContacts,
                      'Emergency Contacts',
                      maxLines: 3,
                    ),
                    _field(
                      emergencyPlanReference,
                      'Emergency Plan / ERP Reference',
                    ),
                    _field(
                      emergencyScenario,
                      'Emergency Scenarios Covered',
                      maxLines: 4,
                    ),
                    _field(
                      responseProcedure,
                      'Emergency Response Procedure',
                      maxLines: 5,
                    ),

                    _section(
                      '2. Evacuation & Emergency Access',
                      Icons.exit_to_app_outlined,
                    ),
                    _field(
                      evacuationRoute,
                      'Evacuation Routes / Exit Paths',
                      maxLines: 4,
                    ),
                    _field(
                      assemblyPoint,
                      'Emergency Assembly / Muster Point',
                      maxLines: 3,
                    ),
                    _field(
                      emergencyAccess,
                      'Emergency Vehicle / Rescue Access',
                      maxLines: 3,
                    ),
                    _field(
                      ambulanceAccess,
                      'Ambulance Access & Route',
                      maxLines: 2,
                    ),
                    _field(
                      fireServiceAccess,
                      'Fire Service / Civil Defence Access',
                      maxLines: 2,
                    ),
                    _field(
                      musterRoll,
                      'Muster Roll / Personnel Accountability',
                      maxLines: 3,
                    ),

                    _section(
                      '3. Fire Protection & Emergency Systems',
                      Icons.local_fire_department_outlined,
                    ),
                    _dropdown(
                      'Primary Fire System',
                      fireSystem,
                      widget.fireSystemOptions,
                      (value) => setState(() => fireSystem = value),
                    ),
                    _field(
                      fireExtinguishers,
                      'Fire Extinguishers / Fire Points',
                      maxLines: 4,
                    ),
                    _field(
                      fireWater,
                      'Fire Water / Hydrant / Hose Reel',
                      maxLines: 4,
                    ),
                    _field(
                      fireAlarm,
                      'Fire Alarm / Detection System',
                      maxLines: 4,
                    ),
                    _field(
                      emergencyLighting,
                      'Emergency Lighting / Exit Signs',
                      maxLines: 3,
                    ),
                    _field(
                      firstAid,
                      'First Aid / Medical Facilities',
                      maxLines: 3,
                    ),
                    _field(
                      rescueEquipment,
                      'Rescue / Retrieval Equipment',
                      maxLines: 3,
                    ),
                    _field(
                      emergencyCommunication,
                      'Emergency Communication / Alarm Method',
                      maxLines: 3,
                    ),

                    _section(
                      '4. Response Team & Isolation',
                      Icons.groups_outlined,
                    ),
                    _field(
                      trainedResponders,
                      'Trained Emergency Responders',
                      maxLines: 3,
                    ),
                    _field(
                      fireWardens,
                      'Fire Wardens / Marshals',
                      maxLines: 3,
                    ),
                    _field(
                      utilityIsolation,
                      'Electrical / Utility Isolation Procedure',
                      maxLines: 3,
                    ),
                    _field(
                      gasIsolation,
                      'Gas / Fuel Isolation Procedure',
                      maxLines: 3,
                    ),
                    _field(
                      weatherHazards,
                      'Weather / External Emergency Hazards',
                      maxLines: 3,
                    ),
                    _field(
                      environmentalEmergency,
                      'Environmental Emergency Response',
                      maxLines: 3,
                    ),

                    _section(
                      '5. Emergency Drill & Inspection',
                      Icons.fire_extinguisher_outlined,
                    ),
                    _dropdown(
                      'Drill Type',
                      drillType,
                      widget.drillTypes,
                      (value) => setState(() => drillType = value),
                    ),
                    _dateField(lastDrillDate, 'Last Drill Date'),
                    _dateField(nextDrillDate, 'Next Drill Date'),
                    _field(
                      drillFindings,
                      'Drill Findings / Performance',
                      maxLines: 4,
                    ),
                    _field(
                      inspectionFrequency,
                      'Inspection Frequency',
                    ),
                    _dateField(
                      lastInspectionDate,
                      'Last Inspection Date',
                    ),
                    _dateField(
                      nextInspectionDate,
                      'Next Inspection Date',
                    ),

                    _section(
                      '6. Readiness & Corrective Action',
                      Icons.fact_check_outlined,
                    ),
                    _dropdown(
                      'Readiness',
                      readiness,
                      widget.readinessOptions,
                      (value) => setState(() => readiness = value),
                    ),
                    _field(findings, 'Inspection / Readiness Findings',
                        maxLines: 4),
                    _field(hazards, 'Hazards / Deficiencies', maxLines: 4),
                    _field(
                      correctiveAction,
                      'Corrective / Preventive Action',
                      maxLines: 4,
                    ),
                    _field(actionOwner, 'Action Owner'),
                    _dateField(actionDueDate, 'Action Due Date'),
                    _field(
                      verification,
                      'Verification / Effectiveness',
                      maxLines: 3,
                    ),

                    _section(
                      '7. Approval & Record Control',
                      Icons.verified_user_outlined,
                    ),
                    _dropdown(
                      'Status',
                      status,
                      widget.statuses,
                      (value) => setState(() => status = value),
                    ),
                    _field(approval, 'Approval / Authorization', maxLines: 3),
                    _field(
                      supportingDocuments,
                      'Supporting Documents / Certificates',
                      maxLines: 3,
                    ),
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

class _EmergencyFireDetails extends StatelessWidget {
  final EmergencyFireRecord record;
  final String Function(String) displayDate;

  const _EmergencyFireDetails({
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
          Text(
            label,
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.88,
        child: Material(
          color: const Color(0xFFF6F8F7),
          child: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Emergency & Fire Readiness Details',
                      style: TextStyle(
                        fontSize: 20,
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
              _row('Record No.', record.recordNo),
              _row('Emergency Type', record.emergencyType),
              _row('Project', record.project),
              _row('Location', record.location),
              _row('Department / Contractor', record.department),
              _row('Responsible Person', record.responsiblePerson),
              _row('Emergency Coordinator', record.emergencyCoordinator),
              _row('Emergency Contacts', record.emergencyContacts),
              _row('ERP Reference', record.emergencyPlanReference),
              _row('Emergency Scenarios', record.emergencyScenario),
              _row('Response Procedure', record.responseProcedure),
              _row('Evacuation Routes', record.evacuationRoute),
              _row('Assembly Point', record.assemblyPoint),
              _row('Emergency Access', record.emergencyAccess),
              _row('Primary Fire System', record.fireSystem),
              _row('Fire Extinguishers', record.fireExtinguishers),
              _row('Fire Water / Hydrant', record.fireWater),
              _row('Fire Alarm / Detection', record.fireAlarm),
              _row('Emergency Lighting', record.emergencyLighting),
              _row('First Aid / Medical', record.firstAid),
              _row('Rescue Equipment', record.rescueEquipment),
              _row('Emergency Communication', record.emergencyCommunication),
              _row('Muster Roll', record.musterRoll),
              _row('Trained Responders', record.trainedResponders),
              _row('Fire Wardens', record.fireWardens),
              _row('Ambulance Access', record.ambulanceAccess),
              _row('Fire Service Access', record.fireServiceAccess),
              _row('Utility Isolation', record.utilityIsolation),
              _row('Gas / Fuel Isolation', record.gasIsolation),
              _row('Weather Hazards', record.weatherHazards),
              _row('Environmental Emergency', record.environmentalEmergency),
              _row('Drill Type', record.drillType),
              _row('Last Drill', displayDate(record.lastDrillDate)),
              _row('Next Drill', displayDate(record.nextDrillDate)),
              _row('Drill Findings', record.drillFindings),
              _row('Inspection Frequency', record.inspectionFrequency),
              _row(
                'Last Inspection',
                displayDate(record.lastInspectionDate),
              ),
              _row(
                'Next Inspection',
                displayDate(record.nextInspectionDate),
              ),
              _row('Readiness', record.readiness),
              _row('Findings', record.findings),
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
