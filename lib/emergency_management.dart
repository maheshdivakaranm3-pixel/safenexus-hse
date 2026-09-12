import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyManagementPage extends StatefulWidget {
  const EmergencyManagementPage({super.key});

  @override
  State<EmergencyManagementPage> createState() =>
      _EmergencyManagementPageState();
}

class _EmergencyManagementPageState extends State<EmergencyManagementPage> {
  static const storageKey = 'safenexus_hse_emergency_management';
  static const primaryGreen = Color(0xFF159447);
  static const darkGreen = Color(0xFF0B5D4B);
  static const pageBackground = Color(0xFFF6F8F7);

  final records = <Map<String, dynamic>>[];
  String search = '';
  String statusFilter = 'All';
  String typeFilter = 'All';
  bool loading = true;

  final statuses = const [
    'Draft',
    'Planned',
    'Approved',
    'Ready',
    'Active',
    'In Progress',
    'Action Required',
    'Completed',
    'Closed',
    'Cancelled',
  ];

  final emergencyTypes = const [
    'Emergency Master Plan',
    'Emergency Response Plan',
    'Fire Emergency',
    'Medical Emergency',
    'Rescue',
    'Evacuation',
    'Confined Space Rescue',
    'Work at Height Rescue',
    'Electrical Emergency',
    'Chemical Spill',
    'Gas Release',
    'Environmental Emergency',
    'Vehicle / Traffic Emergency',
    'Severe Weather',
    'Heat Stress Emergency',
    'Security Emergency',
    'Drill / Exercise',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    loadRecords();
  }

  Future<void> loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);
    if (raw != null && raw.isNotEmpty) {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        records
          ..clear()
          ..addAll(decoded.map((e) => Map<String, dynamic>.from(e as Map)));
      }
    }
    if (mounted) setState(() => loading = false);
  }

  Future<void> saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(records));
  }

  String text(dynamic value) => value?.toString() ?? '';

  DateTime dateValue(dynamic value) =>
      DateTime.tryParse(text(value)) ?? DateTime(1900);

  bool isOverdue(Map<String, dynamic> r) {
    final due = DateTime.tryParse(text(r['actionDue']));
    if (due == null) return false;
    final status = text(r['status']);
    return due.isBefore(DateTime.now()) &&
        status != 'Completed' &&
        status != 'Closed' &&
        status != 'Cancelled';
  }

  List<Map<String, dynamic>> get filtered {
    final q = search.trim().toLowerCase();
    final list = records.where((r) {
      final matchesSearch = q.isEmpty ||
          text(r['recordNo']).toLowerCase().contains(q) ||
          text(r['emergencyType']).toLowerCase().contains(q) ||
          text(r['subject']).toLowerCase().contains(q) ||
          text(r['project']).toLowerCase().contains(q) ||
          text(r['site']).toLowerCase().contains(q) ||
          text(r['location']).toLowerCase().contains(q);
      final matchesStatus =
          statusFilter == 'All' || text(r['status']) == statusFilter;
      final matchesType =
          typeFilter == 'All' || text(r['emergencyType']) == typeFilter;
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
    list.sort((a, b) => dateValue(b['date']).compareTo(dateValue(a['date'])));
    return list;
  }

  int count(String status) =>
      records.where((r) => text(r['status']) == status).length;

  int countType(String type) =>
      records.where((r) => text(r['emergencyType']) == type).length;

  Future<void> openForm({Map<String, dynamic>? existing}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EmergencyFormSheet(
        existing: existing,
        statuses: statuses,
        emergencyTypes: emergencyTypes,
      ),
    );
    if (result == null) return;
    setState(() {
      final index = existing == null ? -1 : records.indexOf(existing);
      if (index >= 0) {
        records[index] = result;
      } else {
        records.add(result);
      }
    });
    await saveRecords();
  }

  Future<void> deleteRecord(Map<String, dynamic> record) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Record'),
        content: const Text('Delete this emergency management record?'),
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
    if (ok != true) return;
    setState(() => records.remove(record));
    await saveRecords();
  }

  void details(Map<String, dynamic> record) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => EmergencyDetailsSheet(record: record),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = records.length;
    final active = records.where((r) {
      final s = text(r['status']);
      return s == 'Active' || s == 'In Progress';
    }).length;
    final drills = countType('Drill / Exercise');
    final actions = records.where((r) {
      final s = text(r['status']);
      return s == 'Action Required' || s == 'In Progress';
    }).length;
    final overdue = records.where(isOverdue).length;
    final ready = count('Ready');
    final closed = count('Closed');

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Emergency Management'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => openForm(),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Record'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                buildDashboard(
                  total,
                  active,
                  drills,
                  actions,
                  overdue,
                  ready,
                  closed,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                  child: TextField(
                    onChanged: (v) => setState(() => search = v),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search emergency record, project, site...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                buildFilters(),
                Expanded(child: buildList()),
              ],
            ),
    );
  }

  Widget buildDashboard(
    int total,
    int active,
    int drills,
    int actions,
    int overdue,
    int ready,
    int closed,
  ) {
    final data = [
      ('Total', total, Icons.list_alt),
      ('Active', active, Icons.emergency),
      ('Drills', drills, Icons.health_and_safety),
      ('Actions', actions, Icons.task_alt),
      ('Overdue', overdue, Icons.warning_amber),
      ('Ready', ready, Icons.check_circle),
      ('Closed', closed, Icons.lock),
    ];

    return SizedBox(
      height: 116,
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final item = data[i];
          return Container(
            width: 112,
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: primaryGreen.withValues(alpha: 0.15),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.$3, color: darkGreen, size: 23),
                const SizedBox(height: 4),
                Text(
                  '${item.$2}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                Text(item.$1, style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      child: Row(
        children: [
          filterDropdown(
            'Status',
            statusFilter,
            ['All', ...statuses],
            (v) => setState(() => statusFilter = v ?? 'All'),
          ),
          const SizedBox(width: 8),
          filterDropdown(
            'Emergency Type',
            typeFilter,
            ['All', ...emergencyTypes],
            (v) => setState(() => typeFilter = v ?? 'All'),
          ),
        ],
      ),
    );
  }

  Widget filterDropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      width: 205,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget buildList() {
    final data = filtered;
    if (data.isEmpty) {
      return const Center(child: Text('No emergency records found.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
      itemCount: data.length,
      itemBuilder: (_, index) {
        final r = data[index];
        final status = text(r['status']);
        final overdue = isOverdue(r);
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          elevation: 0.5,
          child: InkWell(
            onTap: () => details(r),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${text(r['recordNo'])} • ${text(r['emergencyType'])}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: darkGreen,
                          ),
                        ),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (v) {
                          if (v == 'edit') openForm(existing: r);
                          if (v == 'delete') deleteRecord(r);
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(value: 'edit', child: Text('Edit')),
                          PopupMenuItem(value: 'delete', child: Text('Delete')),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    text(r['subject']).isEmpty
                        ? 'Emergency management record'
                        : text(r['subject']),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text('${text(r['project'])} • ${text(r['site'])}'),
                  Text(
                    '${text(r['location'])} • ${text(r['date'])}',
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 7),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      chip(status, statusColor(status)),
                      if (r['drillCompleted'] == true)
                        chip('DRILL DONE', Colors.green),
                      if (overdue) chip('OVERDUE', Colors.red),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color statusColor(String status) {
    switch (status) {
      case 'Completed':
      case 'Closed':
      case 'Ready':
        return Colors.green;
      case 'Action Required':
        return Colors.orange.shade800;
      case 'In Progress':
      case 'Active':
        return Colors.blue;
      case 'Cancelled':
        return Colors.grey;
      default:
        return darkGreen;
    }
  }

  Widget chip(String label, Color color) {
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
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class EmergencyFormSheet extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> statuses;
  final List<String> emergencyTypes;

  const EmergencyFormSheet({
    super.key,
    required this.existing,
    required this.statuses,
    required this.emergencyTypes,
  });

  @override
  State<EmergencyFormSheet> createState() => _EmergencyFormSheetState();
}

class _EmergencyFormSheetState extends State<EmergencyFormSheet> {
  static const primaryGreen = Color(0xFF159447);
  static const darkGreen = Color(0xFF0B5D4B);

  final formKey = GlobalKey<FormState>();
  final controllers = <String, TextEditingController>{};

  String emergencyType = 'Emergency Master Plan';
  String status = 'Draft';
  String riskLevel = 'Medium';
  String drillType = 'Tabletop Exercise';
  String drillResult = 'Not Conducted';
  String actionPriority = 'Medium';
  String verificationStatus = 'Not Verified';

  bool emergencyPlanApproved = false;
  bool emergencyContactsVerified = false;
  bool alarmTested = false;
  bool musterPointsReady = false;
  bool fireEquipmentReady = false;
  bool firstAidReady = false;
  bool rescueEquipmentReady = false;
  bool emergencyLightingReady = false;
  bool communicationReady = false;
  bool accessRoutesClear = false;
  bool ambulanceAccessReady = false;
  bool workersBriefed = false;
  bool drillCompleted = false;
  bool correctiveActionsClosed = false;

  final riskLevels = const ['Low', 'Medium', 'High', 'Critical'];
  final drillTypes = const [
    'Tabletop Exercise',
    'Fire Drill',
    'Evacuation Drill',
    'Rescue Drill',
    'Confined Space Rescue Drill',
    'Work at Height Rescue Drill',
    'Medical Drill',
    'Spill Response Drill',
    'Emergency Communication Drill',
    'Combined Drill',
  ];
  final drillResults = const [
    'Not Conducted',
    'Satisfactory',
    'Satisfactory with Actions',
    'Unsatisfactory',
  ];
  final priorities = const ['Low', 'Medium', 'High', 'Critical'];
  final verificationStatuses = const [
    'Not Verified',
    'Pending',
    'Verified Effective',
    'Verified Ineffective',
  ];

  @override
  void initState() {
    super.initState();
    const keys = [
      'recordNo',
      'date',
      'time',
      'project',
      'site',
      'location',
      'department',
      'emergencyScenario',
      'subject',
      'scope',
      'potentialImpact',
      'responsiblePerson',
      'hseOfficer',
      'emergencyCoordinator',
      'incidentCommander',
      'responseTeam',
      'firstAider',
      'fireWarden',
      'securityContact',
      'emergencyNumbers',
      'authorityContacts',
      'alarmMethod',
      'communicationMethod',
      'musterPoint',
      'evacuationRoute',
      'alternativeRoute',
      'accessRestrictions',
      'fireEquipment',
      'firstAidEquipment',
      'rescueEquipment',
      'spillEquipment',
      'ppe',
      'emergencyLighting',
      'generatorBackup',
      'ambulanceAccess',
      'nearestHospital',
      'rescuePlan',
      'medicalResponse',
      'fireResponse',
      'evacuationPlan',
      'spillResponse',
      'securityResponse',
      'drillDate',
      'drillScenario',
      'drillParticipants',
      'drillFindings',
      'drillLessons',
      'correctiveAction',
      'actionOwner',
      'actionDue',
      'verificationBy',
      'verificationDate',
      'closureEvidence',
      'reviewDate',
      'documentRef',
      'ramssJsaRef',
      'ptwRef',
      'riskRef',
      'trainingRef',
      'lessonsLearned',
      'remarks',
    ];
    for (final key in keys) {
      controllers[key] = TextEditingController();
    }

    final r = widget.existing;
    if (r == null) {
      final now = DateTime.now();
      controllers['recordNo']!.text = 'EM-${now.millisecondsSinceEpoch}';
      controllers['date']!.text = date(now);
      controllers['time']!.text = time(now);
      controllers['reviewDate']!.text =
          date(now.add(const Duration(days: 365)));
    } else {
      for (final key in controllers.keys) {
        controllers[key]!.text = text(r[key]);
      }
      emergencyType = valid(
        text(r['emergencyType']),
        widget.emergencyTypes,
        widget.emergencyTypes.first,
      );
      status = valid(text(r['status']), widget.statuses, widget.statuses.first);
      riskLevel = valid(text(r['riskLevel']), riskLevels, 'Medium');
      drillType = valid(text(r['drillType']), drillTypes, drillTypes.first);
      drillResult = valid(
        text(r['drillResult']),
        drillResults,
        drillResults.first,
      );
      actionPriority = valid(
        text(r['actionPriority']),
        priorities,
        'Medium',
      );
      verificationStatus = valid(
        text(r['verificationStatus']),
        verificationStatuses,
        verificationStatuses.first,
      );
      emergencyPlanApproved = r['emergencyPlanApproved'] == true;
      emergencyContactsVerified = r['emergencyContactsVerified'] == true;
      alarmTested = r['alarmTested'] == true;
      musterPointsReady = r['musterPointsReady'] == true;
      fireEquipmentReady = r['fireEquipmentReady'] == true;
      firstAidReady = r['firstAidReady'] == true;
      rescueEquipmentReady = r['rescueEquipmentReady'] == true;
      emergencyLightingReady = r['emergencyLightingReady'] == true;
      communicationReady = r['communicationReady'] == true;
      accessRoutesClear = r['accessRoutesClear'] == true;
      ambulanceAccessReady = r['ambulanceAccessReady'] == true;
      workersBriefed = r['workersBriefed'] == true;
      drillCompleted = r['drillCompleted'] == true;
      correctiveActionsClosed = r['correctiveActionsClosed'] == true;
    }
  }

  String text(dynamic value) => value?.toString() ?? '';

  String valid(String value, List<String> options, String fallback) =>
      options.contains(value) ? value : fallback;

  String date(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  String time(DateTime d) =>
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  @override
  void dispose() {
    for (final c in controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> pickDate(String key) async {
    final initial = DateTime.tryParse(controllers[key]!.text) ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) controllers[key]!.text = date(picked);
  }

  Future<void> pickTime(String key) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      controllers[key]!.text = picked.format(context);
    }
  }

  void submit() {
    if (!formKey.currentState!.validate()) return;

    final now = DateTime.now().toIso8601String();
    final record = <String, dynamic>{
      'id': widget.existing?['id']?.toString() ?? now,
      'recordNo': controllers['recordNo']!.text.trim(),
      'emergencyType': emergencyType,
      'status': status,
      'riskLevel': riskLevel,
      'date': controllers['date']!.text.trim(),
      'time': controllers['time']!.text.trim(),
      'project': controllers['project']!.text.trim(),
      'site': controllers['site']!.text.trim(),
      'location': controllers['location']!.text.trim(),
      'department': controllers['department']!.text.trim(),
      'emergencyScenario': controllers['emergencyScenario']!.text.trim(),
      'subject': controllers['subject']!.text.trim(),
      'scope': controllers['scope']!.text.trim(),
      'potentialImpact': controllers['potentialImpact']!.text.trim(),
      'responsiblePerson': controllers['responsiblePerson']!.text.trim(),
      'hseOfficer': controllers['hseOfficer']!.text.trim(),
      'emergencyCoordinator': controllers['emergencyCoordinator']!.text.trim(),
      'incidentCommander': controllers['incidentCommander']!.text.trim(),
      'responseTeam': controllers['responseTeam']!.text.trim(),
      'firstAider': controllers['firstAider']!.text.trim(),
      'fireWarden': controllers['fireWarden']!.text.trim(),
      'securityContact': controllers['securityContact']!.text.trim(),
      'emergencyNumbers': controllers['emergencyNumbers']!.text.trim(),
      'authorityContacts': controllers['authorityContacts']!.text.trim(),
      'alarmMethod': controllers['alarmMethod']!.text.trim(),
      'communicationMethod': controllers['communicationMethod']!.text.trim(),
      'musterPoint': controllers['musterPoint']!.text.trim(),
      'evacuationRoute': controllers['evacuationRoute']!.text.trim(),
      'alternativeRoute': controllers['alternativeRoute']!.text.trim(),
      'accessRestrictions': controllers['accessRestrictions']!.text.trim(),
      'fireEquipment': controllers['fireEquipment']!.text.trim(),
      'firstAidEquipment': controllers['firstAidEquipment']!.text.trim(),
      'rescueEquipment': controllers['rescueEquipment']!.text.trim(),
      'spillEquipment': controllers['spillEquipment']!.text.trim(),
      'ppe': controllers['ppe']!.text.trim(),
      'emergencyLighting': controllers['emergencyLighting']!.text.trim(),
      'generatorBackup': controllers['generatorBackup']!.text.trim(),
      'ambulanceAccess': controllers['ambulanceAccess']!.text.trim(),
      'nearestHospital': controllers['nearestHospital']!.text.trim(),
      'rescuePlan': controllers['rescuePlan']!.text.trim(),
      'medicalResponse': controllers['medicalResponse']!.text.trim(),
      'fireResponse': controllers['fireResponse']!.text.trim(),
      'evacuationPlan': controllers['evacuationPlan']!.text.trim(),
      'spillResponse': controllers['spillResponse']!.text.trim(),
      'securityResponse': controllers['securityResponse']!.text.trim(),
      'drillType': drillType,
      'drillDate': controllers['drillDate']!.text.trim(),
      'drillScenario': controllers['drillScenario']!.text.trim(),
      'drillParticipants': controllers['drillParticipants']!.text.trim(),
      'drillResult': drillResult,
      'drillFindings': controllers['drillFindings']!.text.trim(),
      'drillLessons': controllers['drillLessons']!.text.trim(),
      'correctiveAction': controllers['correctiveAction']!.text.trim(),
      'actionOwner': controllers['actionOwner']!.text.trim(),
      'actionDue': controllers['actionDue']!.text.trim(),
      'actionPriority': actionPriority,
      'verificationBy': controllers['verificationBy']!.text.trim(),
      'verificationDate': controllers['verificationDate']!.text.trim(),
      'verificationStatus': verificationStatus,
      'closureEvidence': controllers['closureEvidence']!.text.trim(),
      'reviewDate': controllers['reviewDate']!.text.trim(),
      'documentRef': controllers['documentRef']!.text.trim(),
      'ramssJsaRef': controllers['ramssJsaRef']!.text.trim(),
      'ptwRef': controllers['ptwRef']!.text.trim(),
      'riskRef': controllers['riskRef']!.text.trim(),
      'trainingRef': controllers['trainingRef']!.text.trim(),
      'lessonsLearned': controllers['lessonsLearned']!.text.trim(),
      'remarks': controllers['remarks']!.text.trim(),
      'emergencyPlanApproved': emergencyPlanApproved,
      'emergencyContactsVerified': emergencyContactsVerified,
      'alarmTested': alarmTested,
      'musterPointsReady': musterPointsReady,
      'fireEquipmentReady': fireEquipmentReady,
      'firstAidReady': firstAidReady,
      'rescueEquipmentReady': rescueEquipmentReady,
      'emergencyLightingReady': emergencyLightingReady,
      'communicationReady': communicationReady,
      'accessRoutesClear': accessRoutesClear,
      'ambulanceAccessReady': ambulanceAccessReady,
      'workersBriefed': workersBriefed,
      'drillCompleted': drillCompleted,
      'correctiveActionsClosed': correctiveActionsClosed,
      'createdAt': widget.existing?['createdAt']?.toString() ?? now,
      'updatedAt': now,
    };

    Navigator.pop(context, record);
  }

  Widget field(
    String key,
    String label, {
    int maxLines = 1,
    bool required = false,
    TextInputType? keyboardType,
    VoidCallback? onTap,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controllers[key],
        maxLines: maxLines,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: required
            ? (v) => v == null || v.trim().isEmpty ? 'Required' : null
            : null,
      ),
    );
  }

  Widget dropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget switchTile(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      value: value,
      activeTrackColor: primaryGreen.withValues(alpha: 0.35),
      activeThumbColor: primaryGreen,
      onChanged: onChanged,
    );
  }

  Widget section(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 22,
            decoration: BoxDecoration(
              color: primaryGreen,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.94,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 8, 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.existing == null
                            ? 'Add Emergency Record'
                            : 'Edit Emergency Record',
                        style: const TextStyle(
                          fontSize: 19,
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
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  children: [
                    section('10A • Emergency Management Master'),
                    field('recordNo', 'Record No', required: true),
                    dropdown(
                      'Emergency Type',
                      emergencyType,
                      widget.emergencyTypes,
                      (v) => setState(() => emergencyType = v!),
                    ),
                    field(
                      'date',
                      'Date',
                      readOnly: true,
                      onTap: () => pickDate('date'),
                    ),
                    field(
                      'time',
                      'Time',
                      readOnly: true,
                      onTap: () => pickTime('time'),
                    ),
                    field('project', 'Project', required: true),
                    field('site', 'Site', required: true),
                    field('location', 'Location / Work Front'),
                    field('department', 'Department'),
                    field('emergencyScenario', 'Emergency Scenario', maxLines: 3),
                    field('subject', 'Subject / Event', required: true),
                    field('scope', 'Scope / Area Covered', maxLines: 3),
                    field('potentialImpact', 'Potential Impact', maxLines: 3),
                    dropdown(
                      'Risk Level',
                      riskLevel,
                      riskLevels,
                      (v) => setState(() => riskLevel = v!),
                    ),
                    dropdown(
                      'Status',
                      status,
                      widget.statuses,
                      (v) => setState(() => status = v!),
                    ),

                    section('10B • Emergency Organization & Contacts'),
                    field('responsiblePerson', 'Responsible Person'),
                    field('hseOfficer', 'HSE Officer'),
                    field('emergencyCoordinator', 'Emergency Coordinator'),
                    field('incidentCommander', 'Incident Commander'),
                    field('responseTeam', 'Emergency Response Team'),
                    field('firstAider', 'First Aider / Medical Team'),
                    field('fireWarden', 'Fire Warden'),
                    field('securityContact', 'Security Contact'),
                    field('emergencyNumbers', 'Emergency Numbers', maxLines: 2),
                    field('authorityContacts', 'Authority / External Contacts', maxLines: 2),

                    section('10C • Alarm, Evacuation & Communication'),
                    field('alarmMethod', 'Alarm / Notification Method'),
                    field('communicationMethod', 'Emergency Communication Method'),
                    field('musterPoint', 'Muster / Assembly Point'),
                    field('evacuationRoute', 'Primary Evacuation Route', maxLines: 2),
                    field('alternativeRoute', 'Alternative Route', maxLines: 2),
                    field('accessRestrictions', 'Access Restrictions / Controls', maxLines: 2),
                    switchTile(
                      'Emergency Plan Approved',
                      emergencyPlanApproved,
                      (v) => setState(() => emergencyPlanApproved = v),
                    ),
                    switchTile(
                      'Emergency Contacts Verified',
                      emergencyContactsVerified,
                      (v) => setState(() => emergencyContactsVerified = v),
                    ),
                    switchTile(
                      'Alarm / Notification Tested',
                      alarmTested,
                      (v) => setState(() => alarmTested = v),
                    ),
                    switchTile(
                      'Muster Points Ready',
                      musterPointsReady,
                      (v) => setState(() => musterPointsReady = v),
                    ),
                    switchTile(
                      'Workers Briefed',
                      workersBriefed,
                      (v) => setState(() => workersBriefed = v),
                    ),

                    section('10D • Fire, Medical & Rescue Readiness'),
                    field('fireEquipment', 'Fire Fighting Equipment', maxLines: 2),
                    field('firstAidEquipment', 'First Aid / Medical Equipment', maxLines: 2),
                    field('rescueEquipment', 'Rescue Equipment', maxLines: 2),
                    field('spillEquipment', 'Spill Response Equipment', maxLines: 2),
                    field('ppe', 'Emergency PPE', maxLines: 2),
                    field('emergencyLighting', 'Emergency Lighting'),
                    field('generatorBackup', 'Generator / Backup Power'),
                    field('ambulanceAccess', 'Ambulance / Emergency Vehicle Access'),
                    field('nearestHospital', 'Nearest Hospital / Medical Facility'),
                    switchTile(
                      'Fire Equipment Ready',
                      fireEquipmentReady,
                      (v) => setState(() => fireEquipmentReady = v),
                    ),
                    switchTile(
                      'First Aid Ready',
                      firstAidReady,
                      (v) => setState(() => firstAidReady = v),
                    ),
                    switchTile(
                      'Rescue Equipment Ready',
                      rescueEquipmentReady,
                      (v) => setState(() => rescueEquipmentReady = v),
                    ),
                    switchTile(
                      'Emergency Lighting Ready',
                      emergencyLightingReady,
                      (v) => setState(() => emergencyLightingReady = v),
                    ),
                    switchTile(
                      'Emergency Communication Ready',
                      communicationReady,
                      (v) => setState(() => communicationReady = v),
                    ),
                    switchTile(
                      'Access Routes Clear',
                      accessRoutesClear,
                      (v) => setState(() => accessRoutesClear = v),
                    ),
                    switchTile(
                      'Ambulance Access Ready',
                      ambulanceAccessReady,
                      (v) => setState(() => ambulanceAccessReady = v),
                    ),

                    section('10E • Emergency Response Plans'),
                    field('rescuePlan', 'Rescue Plan / Rescue Sequence', maxLines: 4),
                    field('medicalResponse', 'Medical Emergency Response', maxLines: 3),
                    field('fireResponse', 'Fire Emergency Response', maxLines: 3),
                    field('evacuationPlan', 'Evacuation Response', maxLines: 3),
                    field('spillResponse', 'Spill / Environmental Response', maxLines: 3),
                    field('securityResponse', 'Security Emergency Response', maxLines: 3),

                    section('10F • Emergency Drill / Exercise'),
                    dropdown(
                      'Drill Type',
                      drillType,
                      drillTypes,
                      (v) => setState(() => drillType = v!),
                    ),
                    field(
                      'drillDate',
                      'Drill Date',
                      readOnly: true,
                      onTap: () => pickDate('drillDate'),
                    ),
                    field('drillScenario', 'Drill Scenario', maxLines: 3),
                    field('drillParticipants', 'Participants / Attendance'),
                    dropdown(
                      'Drill Result',
                      drillResult,
                      drillResults,
                      (v) => setState(() => drillResult = v!),
                    ),
                    field('drillFindings', 'Drill Findings', maxLines: 4),
                    field('drillLessons', 'Drill Lessons Learned', maxLines: 3),
                    switchTile(
                      'Drill Completed',
                      drillCompleted,
                      (v) => setState(() => drillCompleted = v),
                    ),

                    section('10G • Corrective Action & Verification'),
                    field('correctiveAction', 'Corrective Action', maxLines: 4),
                    field('actionOwner', 'Action Owner'),
                    field(
                      'actionDue',
                      'Action Due Date',
                      readOnly: true,
                      onTap: () => pickDate('actionDue'),
                    ),
                    dropdown(
                      'Action Priority',
                      actionPriority,
                      priorities,
                      (v) => setState(() => actionPriority = v!),
                    ),
                    field('verificationBy', 'Verified By'),
                    field(
                      'verificationDate',
                      'Verification Date',
                      readOnly: true,
                      onTap: () => pickDate('verificationDate'),
                    ),
                    dropdown(
                      'Verification Status',
                      verificationStatus,
                      verificationStatuses,
                      (v) => setState(() => verificationStatus = v!),
                    ),
                    field('closureEvidence', 'Closure Evidence / Reference', maxLines: 2),
                    switchTile(
                      'Corrective Actions Closed',
                      correctiveActionsClosed,
                      (v) => setState(() => correctiveActionsClosed = v),
                    ),

                    section('10H • Integration & Review'),
                    field('documentRef', 'ERP / Emergency Document Reference'),
                    field('ramssJsaRef', 'RAMS / JSA / Risk Reference'),
                    field('ptwRef', 'PTW Reference'),
                    field('riskRef', 'Risk / HIRA Reference'),
                    field('trainingRef', 'Training / Competency Reference'),
                    field(
                      'reviewDate',
                      'Next Review Date',
                      readOnly: true,
                      onTap: () => pickDate('reviewDate'),
                    ),
                    field('lessonsLearned', 'Lessons Learned', maxLines: 3),
                    field('remarks', 'Remarks', maxLines: 3),

                    const SizedBox(height: 12),
                    SizedBox(
                      height: 50,
                      child: FilledButton.icon(
                        onPressed: submit,
                        style: FilledButton.styleFrom(
                          backgroundColor: primaryGreen,
                        ),
                        icon: const Icon(Icons.save),
                        label: Text(
                          widget.existing == null
                              ? 'Save Emergency Record'
                              : 'Update Emergency Record',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmergencyDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> record;

  const EmergencyDetailsSheet({super.key, required this.record});

  static const darkGreen = Color(0xFF0B5D4B);

  String text(dynamic value) => value?.toString() ?? '';

  @override
  Widget build(BuildContext context) {
    final details = <MapEntry<String, String>>[
      MapEntry('Record No', text(record['recordNo'])),
      MapEntry('Emergency Type', text(record['emergencyType'])),
      MapEntry('Date / Time', '${text(record['date'])} ${text(record['time'])}'),
      MapEntry('Project', text(record['project'])),
      MapEntry('Site', text(record['site'])),
      MapEntry('Location', text(record['location'])),
      MapEntry('Department', text(record['department'])),
      MapEntry('Emergency Scenario', text(record['emergencyScenario'])),
      MapEntry('Subject', text(record['subject'])),
      MapEntry('Risk Level', text(record['riskLevel'])),
      MapEntry('Responsible Person', text(record['responsiblePerson'])),
      MapEntry('Emergency Coordinator', text(record['emergencyCoordinator'])),
      MapEntry('Incident Commander', text(record['incidentCommander'])),
      MapEntry('Response Team', text(record['responseTeam'])),
      MapEntry('First Aider', text(record['firstAider'])),
      MapEntry('Fire Warden', text(record['fireWarden'])),
      MapEntry('Emergency Numbers', text(record['emergencyNumbers'])),
      MapEntry('Muster Point', text(record['musterPoint'])),
      MapEntry('Evacuation Route', text(record['evacuationRoute'])),
      MapEntry('Fire Equipment', text(record['fireEquipment'])),
      MapEntry('First Aid Equipment', text(record['firstAidEquipment'])),
      MapEntry('Rescue Equipment', text(record['rescueEquipment'])),
      MapEntry('Nearest Hospital', text(record['nearestHospital'])),
      MapEntry('Rescue Plan', text(record['rescuePlan'])),
      MapEntry('Medical Response', text(record['medicalResponse'])),
      MapEntry('Fire Response', text(record['fireResponse'])),
      MapEntry('Evacuation Plan', text(record['evacuationPlan'])),
      MapEntry('Drill Type', text(record['drillType'])),
      MapEntry('Drill Date', text(record['drillDate'])),
      MapEntry('Drill Result', text(record['drillResult'])),
      MapEntry('Drill Findings', text(record['drillFindings'])),
      MapEntry('Corrective Action', text(record['correctiveAction'])),
      MapEntry('Action Owner', text(record['actionOwner'])),
      MapEntry('Action Due', text(record['actionDue'])),
      MapEntry('Verification Status', text(record['verificationStatus'])),
      MapEntry('Closure Evidence', text(record['closureEvidence'])),
      MapEntry('Next Review', text(record['reviewDate'])),
      MapEntry('Status', text(record['status'])),
      MapEntry('Lessons Learned', text(record['lessonsLearned'])),
      MapEntry('Remarks', text(record['remarks'])),
    ];

    final checks = <String, bool>{
      'Emergency Plan Approved': record['emergencyPlanApproved'] == true,
      'Contacts Verified': record['emergencyContactsVerified'] == true,
      'Alarm Tested': record['alarmTested'] == true,
      'Muster Points Ready': record['musterPointsReady'] == true,
      'Fire Equipment Ready': record['fireEquipmentReady'] == true,
      'First Aid Ready': record['firstAidReady'] == true,
      'Rescue Equipment Ready': record['rescueEquipmentReady'] == true,
      'Emergency Lighting Ready': record['emergencyLightingReady'] == true,
      'Communication Ready': record['communicationReady'] == true,
      'Access Routes Clear': record['accessRoutesClear'] == true,
      'Ambulance Access Ready': record['ambulanceAccessReady'] == true,
      'Workers Briefed': record['workersBriefed'] == true,
      'Drill Completed': record['drillCompleted'] == true,
      'Corrective Actions Closed': record['correctiveActionsClosed'] == true,
    };

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Emergency Record Details',
                    style: TextStyle(
                      fontSize: 19,
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
            Expanded(
              child: ListView(
                children: [
                  ...details.where((e) => e.value.isNotEmpty).map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.key,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(e.value),
                            ],
                          ),
                        ),
                      ),
                  const Divider(height: 24),
                  const Text(
                    'Emergency Readiness Checks',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...checks.entries.map(
                    (e) => ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        e.value ? Icons.check_circle : Icons.cancel,
                        color: e.value ? Colors.green : Colors.red,
                      ),
                      title: Text(e.key),
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
}
