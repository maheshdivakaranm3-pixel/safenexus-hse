import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChemicalEnvironmentPage extends StatefulWidget {
  const ChemicalEnvironmentPage({super.key});

  @override
  State<ChemicalEnvironmentPage> createState() =>
      _ChemicalEnvironmentPageState();
}

class _ChemicalEnvironmentPageState extends State<ChemicalEnvironmentPage> {
  static const storageKey = 'safenexus_hse_chemical_environment';
  static const primaryGreen = Color(0xFF159447);
  static const darkGreen = Color(0xFF0B5D4B);
  static const pageBackground = Color(0xFFF6F8F7);

  final records = <Map<String, dynamic>>[];
  bool loading = true;
  String search = '';
  String statusFilter = 'All';
  String typeFilter = 'All';

  final statuses = const [
    'Draft',
    'Planned',
    'Open',
    'Under Review',
    'Compliant',
    'Action Required',
    'Monitoring',
    'Completed',
    'Closed',
    'Cancelled',
  ];

  final recordTypes = const [
    'Chemical & Environment Master',
    'Chemical Register',
    'SDS / MSDS Register',
    'Chemical Storage Inspection',
    'Chemical Handling Assessment',
    'Hazardous Substance Assessment',
    'Waste Register',
    'Hazardous Waste',
    'Non-Hazardous Waste',
    'Waste Transfer / Disposal',
    'Spill / Leak',
    'Environmental Inspection',
    'Environmental Aspect & Impact',
    'Air / Dust / Emission',
    'Noise / Vibration',
    'Water / Wastewater',
    'Soil / Ground Protection',
    'Pollution Prevention',
    'Environmental Monitoring',
    'Other',
  ];

  final wasteTypes = const [
    'Not Applicable',
    'General Waste',
    'Recyclable Waste',
    'Food Waste',
    'Construction Waste',
    'Hazardous Waste',
    'Chemical Waste',
    'Oily Waste',
    'Contaminated Material',
    'E-Waste',
    'Medical Waste',
    'Used Batteries',
    'Other',
  ];

  final riskLevels = const ['Low', 'Medium', 'High', 'Critical'];

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

  bool isExpiringSoon(Map<String, dynamic> r) {
    final expiry = DateTime.tryParse(text(r['expiryDate']));
    if (expiry == null) return false;
    final now = DateTime.now();
    final limit = now.add(const Duration(days: 30));
    return !expiry.isBefore(now) &&
        !expiry.isAfter(limit) &&
        text(r['status']) != 'Closed' &&
        text(r['status']) != 'Cancelled';
  }

  List<Map<String, dynamic>> get filtered {
    final q = search.trim().toLowerCase();
    final result = records.where((r) {
      final matchesSearch = q.isEmpty ||
          text(r['recordNo']).toLowerCase().contains(q) ||
          text(r['recordType']).toLowerCase().contains(q) ||
          text(r['chemicalName']).toLowerCase().contains(q) ||
          text(r['project']).toLowerCase().contains(q) ||
          text(r['site']).toLowerCase().contains(q) ||
          text(r['location']).toLowerCase().contains(q) ||
          text(r['wasteType']).toLowerCase().contains(q) ||
          text(r['subject']).toLowerCase().contains(q);
      final matchesStatus =
          statusFilter == 'All' || text(r['status']) == statusFilter;
      final matchesType =
          typeFilter == 'All' || text(r['recordType']) == typeFilter;
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
    result.sort((a, b) => dateValue(b['date']).compareTo(dateValue(a['date'])));
    return result;
  }

  int countType(String type) =>
      records.where((r) => text(r['recordType']) == type).length;

  int countStatus(String status) =>
      records.where((r) => text(r['status']) == status).length;

  Future<void> openForm({Map<String, dynamic>? existing}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ChemicalEnvironmentFormSheet(
        existing: existing,
        statuses: statuses,
        recordTypes: recordTypes,
        wasteTypes: wasteTypes,
        riskLevels: riskLevels,
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
        content: const Text('Delete this chemical/environment record?'),
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

  void showDetails(Map<String, dynamic> record) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ChemicalEnvironmentDetailsSheet(record: record),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = records.length;
    final compliant = countStatus('Compliant');
    final actions = countStatus('Action Required');
    final monitoring = countStatus('Monitoring');
    final overdue = records.where(isOverdue).length;
    final expiring = records.where(isExpiringSoon).length;
    final chemicals = countType('Chemical Register') +
        countType('SDS / MSDS Register') +
        countType('Chemical Storage Inspection');
    final waste = records.where((r) {
      final type = text(r['recordType']);
      return type.contains('Waste') || type == 'Waste Transfer / Disposal';
    }).length;
    final spills = countType('Spill / Leak');

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Chemical & Environment'),
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
                dashboard(
                  total,
                  compliant,
                  actions,
                  monitoring,
                  overdue,
                  expiring,
                  chemicals,
                  waste,
                  spills,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                  child: TextField(
                    onChanged: (v) => setState(() => search = v),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText:
                          'Search chemical, waste, project, site...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                filters(),
                Expanded(child: buildList()),
              ],
            ),
    );
  }

  Widget dashboard(
    int total,
    int compliant,
    int actions,
    int monitoring,
    int overdue,
    int expiring,
    int chemicals,
    int waste,
    int spills,
  ) {
    final data = [
      ('Total', total, Icons.list_alt),
      ('Compliant', compliant, Icons.check_circle),
      ('Actions', actions, Icons.task_alt),
      ('Monitoring', monitoring, Icons.monitor),
      ('Overdue', overdue, Icons.warning_amber),
      ('Expiring', expiring, Icons.event),
      ('Chemicals', chemicals, Icons.science),
      ('Waste', waste, Icons.delete_outline),
      ('Spills', spills, Icons.water_drop),
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
                Text(
                  item.$1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget filters() {
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
            'Record Type',
            typeFilter,
            ['All', ...recordTypes],
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
      width: 210,
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
      return const Center(
        child: Text('No chemical/environment records found.'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
      itemCount: data.length,
      itemBuilder: (_, index) {
        final r = data[index];
        final overdue = isOverdue(r);
        final expiring = isExpiringSoon(r);
        final status = text(r['status']);

        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          elevation: 0.5,
          child: InkWell(
            onTap: () => showDetails(r),
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
                          '${text(r['recordNo'])} • ${text(r['recordType'])}',
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
                        ? text(r['chemicalName']).isEmpty
                            ? text(r['wasteType']).isEmpty
                                ? 'Chemical & environmental record'
                                : text(r['wasteType'])
                            : text(r['chemicalName'])
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
                      if (text(r['riskLevel']).isNotEmpty)
                        chip(
                          'Risk: ${text(r['riskLevel'])}',
                          riskColor(text(r['riskLevel'])),
                        ),
                      if (expiring) chip('EXPIRING <=30D', Colors.orange),
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

  Color statusColor(String value) {
    switch (value) {
      case 'Compliant':
      case 'Completed':
      case 'Closed':
        return Colors.green;
      case 'Action Required':
        return Colors.orange.shade800;
      case 'Under Review':
      case 'Monitoring':
        return Colors.blue;
      case 'Cancelled':
        return Colors.grey;
      default:
        return darkGreen;
    }
  }

  Color riskColor(String value) {
    switch (value) {
      case 'Critical':
        return Colors.red;
      case 'High':
        return Colors.deepOrange;
      case 'Medium':
        return Colors.orange.shade800;
      default:
        return Colors.green;
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

class ChemicalEnvironmentFormSheet extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> statuses;
  final List<String> recordTypes;
  final List<String> wasteTypes;
  final List<String> riskLevels;

  const ChemicalEnvironmentFormSheet({
    super.key,
    required this.existing,
    required this.statuses,
    required this.recordTypes,
    required this.wasteTypes,
    required this.riskLevels,
  });

  @override
  State<ChemicalEnvironmentFormSheet> createState() =>
      _ChemicalEnvironmentFormSheetState();
}

class _ChemicalEnvironmentFormSheetState
    extends State<ChemicalEnvironmentFormSheet> {
  static const primaryGreen = Color(0xFF159447);
  static const darkGreen = Color(0xFF0B5D4B);

  final formKey = GlobalKey<FormState>();
  final c = <String, TextEditingController>{};

  String recordType = 'Chemical & Environment Master';
  String status = 'Draft';
  String riskLevel = 'Medium';
  String wasteType = 'Not Applicable';
  String actionPriority = 'Medium';

  bool sdsAvailable = false;
  bool sdsReviewed = false;
  bool chemicalApproved = false;
  bool storageCompliant = false;
  bool labelsCompliant = false;
  bool segregationCompliant = false;
  bool spillKitAvailable = false;
  bool emergencyEquipmentReady = false;
  bool trainedWorkers = false;
  bool wasteAreaReady = false;
  bool wasteSegregated = false;
  bool licensedDisposal = false;
  bool manifestAvailable = false;
  bool pollutionControls = false;
  bool dustControls = false;
  bool noiseControls = false;
  bool waterControls = false;
  bool soilProtection = false;
  bool monitoringCompleted = false;
  bool correctiveActionsClosed = false;

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
      'subject',
      'chemicalName',
      'chemicalCode',
      'casNumber',
      'manufacturer',
      'supplier',
      'quantity',
      'unit',
      'storageLocation',
      'storageCondition',
      'compatibility',
      'sdsReference',
      'sdsIssueDate',
      'sdsExpiryDate',
      'hazardClassification',
      'hazards',
      'exposureRoutes',
      'requiredPpe',
      'handlingMethod',
      'spillResponse',
      'emergencyResponse',
      'trainedPersonnel',
      'wasteType',
      'wasteCode',
      'wasteQuantity',
      'wasteUnit',
      'wasteSource',
      'wasteStorageLocation',
      'wasteContainer',
      'wasteSegregation',
      'disposalMethod',
      'disposalCompany',
      'disposalLicense',
      'manifestReference',
      'disposalDate',
      'environmentalAspect',
      'environmentalImpact',
      'environmentalControls',
      'dustFindings',
      'emissionFindings',
      'noiseFindings',
      'waterFindings',
      'soilFindings',
      'spillDetails',
      'spillQuantity',
      'spillCause',
      'spillContainment',
      'spillCleanup',
      'monitoringParameter',
      'monitoringMethod',
      'monitoringResult',
      'monitoringUnit',
      'monitoringLimit',
      'monitoringDate',
      'correctiveAction',
      'actionOwner',
      'actionDue',
      'verificationBy',
      'verificationDate',
      'closureEvidence',
      'reviewDate',
      'legalReference',
      'permitReference',
      'documentReference',
      'lessonsLearned',
      'remarks',
    ];

    for (final key in keys) {
      c[key] = TextEditingController();
    }

    final r = widget.existing;
    if (r == null) {
      final now = DateTime.now();
      c['recordNo']!.text = 'CE-${now.millisecondsSinceEpoch}';
      c['date']!.text = date(now);
      c['time']!.text = time(now);
      c['reviewDate']!.text =
          date(now.add(const Duration(days: 365)));
    } else {
      for (final key in c.keys) {
        c[key]!.text = text(r[key]);
      }
      recordType = valid(
        text(r['recordType']),
        widget.recordTypes,
        widget.recordTypes.first,
      );
      status = valid(
        text(r['status']),
        widget.statuses,
        widget.statuses.first,
      );
      riskLevel = valid(text(r['riskLevel']), widget.riskLevels, 'Medium');
      wasteType = valid(text(r['wasteType']), widget.wasteTypes, 'Not Applicable');
      actionPriority =
          valid(text(r['actionPriority']), const ['Low', 'Medium', 'High', 'Critical'], 'Medium');

      sdsAvailable = r['sdsAvailable'] == true;
      sdsReviewed = r['sdsReviewed'] == true;
      chemicalApproved = r['chemicalApproved'] == true;
      storageCompliant = r['storageCompliant'] == true;
      labelsCompliant = r['labelsCompliant'] == true;
      segregationCompliant = r['segregationCompliant'] == true;
      spillKitAvailable = r['spillKitAvailable'] == true;
      emergencyEquipmentReady = r['emergencyEquipmentReady'] == true;
      trainedWorkers = r['trainedWorkers'] == true;
      wasteAreaReady = r['wasteAreaReady'] == true;
      wasteSegregated = r['wasteSegregated'] == true;
      licensedDisposal = r['licensedDisposal'] == true;
      manifestAvailable = r['manifestAvailable'] == true;
      pollutionControls = r['pollutionControls'] == true;
      dustControls = r['dustControls'] == true;
      noiseControls = r['noiseControls'] == true;
      waterControls = r['waterControls'] == true;
      soilProtection = r['soilProtection'] == true;
      monitoringCompleted = r['monitoringCompleted'] == true;
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
    for (final controller in c.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> pickDate(String key) async {
    final initial = DateTime.tryParse(c[key]!.text) ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) c[key]!.text = date(picked);
  }

  Future<void> pickTime(String key) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) c[key]!.text = picked.format(context);
  }

  void submit() {
    if (!formKey.currentState!.validate()) return;

    final now = DateTime.now().toIso8601String();
    final record = <String, dynamic>{
      'id': widget.existing?['id']?.toString() ?? now,
      'recordNo': c['recordNo']!.text.trim(),
      'recordType': recordType,
      'status': status,
      'riskLevel': riskLevel,
      'wasteType': wasteType,
      'date': c['date']!.text.trim(),
      'time': c['time']!.text.trim(),
      'project': c['project']!.text.trim(),
      'site': c['site']!.text.trim(),
      'location': c['location']!.text.trim(),
      'department': c['department']!.text.trim(),
      'subject': c['subject']!.text.trim(),
      'chemicalName': c['chemicalName']!.text.trim(),
      'chemicalCode': c['chemicalCode']!.text.trim(),
      'casNumber': c['casNumber']!.text.trim(),
      'manufacturer': c['manufacturer']!.text.trim(),
      'supplier': c['supplier']!.text.trim(),
      'quantity': c['quantity']!.text.trim(),
      'unit': c['unit']!.text.trim(),
      'storageLocation': c['storageLocation']!.text.trim(),
      'storageCondition': c['storageCondition']!.text.trim(),
      'compatibility': c['compatibility']!.text.trim(),
      'sdsReference': c['sdsReference']!.text.trim(),
      'sdsIssueDate': c['sdsIssueDate']!.text.trim(),
      'sdsExpiryDate': c['sdsExpiryDate']!.text.trim(),
      'expiryDate': c['sdsExpiryDate']!.text.trim(),
      'hazardClassification': c['hazardClassification']!.text.trim(),
      'hazards': c['hazards']!.text.trim(),
      'exposureRoutes': c['exposureRoutes']!.text.trim(),
      'requiredPpe': c['requiredPpe']!.text.trim(),
      'handlingMethod': c['handlingMethod']!.text.trim(),
      'spillResponse': c['spillResponse']!.text.trim(),
      'emergencyResponse': c['emergencyResponse']!.text.trim(),
      'trainedPersonnel': c['trainedPersonnel']!.text.trim(),
      'wasteCode': c['wasteCode']!.text.trim(),
      'wasteQuantity': c['wasteQuantity']!.text.trim(),
      'wasteUnit': c['wasteUnit']!.text.trim(),
      'wasteSource': c['wasteSource']!.text.trim(),
      'wasteStorageLocation': c['wasteStorageLocation']!.text.trim(),
      'wasteContainer': c['wasteContainer']!.text.trim(),
      'wasteSegregation': c['wasteSegregation']!.text.trim(),
      'disposalMethod': c['disposalMethod']!.text.trim(),
      'disposalCompany': c['disposalCompany']!.text.trim(),
      'disposalLicense': c['disposalLicense']!.text.trim(),
      'manifestReference': c['manifestReference']!.text.trim(),
      'disposalDate': c['disposalDate']!.text.trim(),
      'environmentalAspect': c['environmentalAspect']!.text.trim(),
      'environmentalImpact': c['environmentalImpact']!.text.trim(),
      'environmentalControls': c['environmentalControls']!.text.trim(),
      'dustFindings': c['dustFindings']!.text.trim(),
      'emissionFindings': c['emissionFindings']!.text.trim(),
      'noiseFindings': c['noiseFindings']!.text.trim(),
      'waterFindings': c['waterFindings']!.text.trim(),
      'soilFindings': c['soilFindings']!.text.trim(),
      'spillDetails': c['spillDetails']!.text.trim(),
      'spillQuantity': c['spillQuantity']!.text.trim(),
      'spillCause': c['spillCause']!.text.trim(),
      'spillContainment': c['spillContainment']!.text.trim(),
      'spillCleanup': c['spillCleanup']!.text.trim(),
      'monitoringParameter': c['monitoringParameter']!.text.trim(),
      'monitoringMethod': c['monitoringMethod']!.text.trim(),
      'monitoringResult': c['monitoringResult']!.text.trim(),
      'monitoringUnit': c['monitoringUnit']!.text.trim(),
      'monitoringLimit': c['monitoringLimit']!.text.trim(),
      'monitoringDate': c['monitoringDate']!.text.trim(),
      'correctiveAction': c['correctiveAction']!.text.trim(),
      'actionOwner': c['actionOwner']!.text.trim(),
      'actionDue': c['actionDue']!.text.trim(),
      'actionPriority': actionPriority,
      'verificationBy': c['verificationBy']!.text.trim(),
      'verificationDate': c['verificationDate']!.text.trim(),
      'closureEvidence': c['closureEvidence']!.text.trim(),
      'reviewDate': c['reviewDate']!.text.trim(),
      'legalReference': c['legalReference']!.text.trim(),
      'permitReference': c['permitReference']!.text.trim(),
      'documentReference': c['documentReference']!.text.trim(),
      'lessonsLearned': c['lessonsLearned']!.text.trim(),
      'remarks': c['remarks']!.text.trim(),
      'sdsAvailable': sdsAvailable,
      'sdsReviewed': sdsReviewed,
      'chemicalApproved': chemicalApproved,
      'storageCompliant': storageCompliant,
      'labelsCompliant': labelsCompliant,
      'segregationCompliant': segregationCompliant,
      'spillKitAvailable': spillKitAvailable,
      'emergencyEquipmentReady': emergencyEquipmentReady,
      'trainedWorkers': trainedWorkers,
      'wasteAreaReady': wasteAreaReady,
      'wasteSegregated': wasteSegregated,
      'licensedDisposal': licensedDisposal,
      'manifestAvailable': manifestAvailable,
      'pollutionControls': pollutionControls,
      'dustControls': dustControls,
      'noiseControls': noiseControls,
      'waterControls': waterControls,
      'soilProtection': soilProtection,
      'monitoringCompleted': monitoringCompleted,
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
        controller: c[key],
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
                            ? 'Add Chemical / Environment Record'
                            : 'Edit Chemical / Environment Record',
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
                    section('12A • Chemical & Environment Master'),
                    field('recordNo', 'Record No', required: true),
                    dropdown(
                      'Record Type',
                      recordType,
                      widget.recordTypes,
                      (v) => setState(() => recordType = v!),
                    ),
                    field(
                      'date',
                      'Record Date',
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
                    field('location', 'Location / Area'),
                    field('department', 'Department'),
                    field('subject', 'Subject / Activity', required: true),
                    dropdown(
                      'Risk Level',
                      riskLevel,
                      widget.riskLevels,
                      (v) => setState(() => riskLevel = v!),
                    ),
                    dropdown(
                      'Status',
                      status,
                      widget.statuses,
                      (v) => setState(() => status = v!),
                    ),

                    section('12B • Chemical Register & SDS / MSDS'),
                    field('chemicalName', 'Chemical / Substance Name'),
                    field('chemicalCode', 'Chemical Code / Product ID'),
                    field('casNumber', 'CAS Number'),
                    field('manufacturer', 'Manufacturer'),
                    field('supplier', 'Supplier'),
                    field('quantity', 'Quantity'),
                    field('unit', 'Unit'),
                    field('storageLocation', 'Storage Location'),
                    field('storageCondition', 'Storage Condition', maxLines: 2),
                    field('compatibility', 'Compatibility / Segregation Requirements', maxLines: 3),
                    field('sdsReference', 'SDS / MSDS Reference'),
                    field(
                      'sdsIssueDate',
                      'SDS Expiry / Review Date',
                      readOnly: true,
                      onTap: () => pickDate('sdsIssueDate'),
                    ),
                    field(
                      'sdsExpiryDate',
                      'Certificate / SDS Valid Until',
                      readOnly: true,
                      onTap: () => pickDate('sdsExpiryDate'),
                    ),
                    field('hazardClassification', 'Hazard Classification'),
                    field('hazards', 'Chemical Hazards', maxLines: 3),
                    field('exposureRoutes', 'Exposure Routes', maxLines: 2),
                    field('requiredPpe', 'Required PPE', maxLines: 2),
                    field('handlingMethod', 'Safe Handling Method', maxLines: 3),
                    field('spillResponse', 'Spill Response', maxLines: 3),
                    field('emergencyResponse', 'Emergency Response', maxLines: 3),
                    field('trainedPersonnel', 'Trained / Authorized Personnel'),
                    switchTile(
                      'SDS Available',
                      sdsAvailable,
                      (v) => setState(() => sdsAvailable = v),
                    ),
                    switchTile(
                      'SDS Reviewed',
                      sdsReviewed,
                      (v) => setState(() => sdsReviewed = v),
                    ),
                    switchTile(
                      'Chemical Approved for Use',
                      chemicalApproved,
                      (v) => setState(() => chemicalApproved = v),
                    ),
                    switchTile(
                      'Storage Compliant',
                      storageCompliant,
                      (v) => setState(() => storageCompliant = v),
                    ),
                    switchTile(
                      'Labels / Containers Compliant',
                      labelsCompliant,
                      (v) => setState(() => labelsCompliant = v),
                    ),
                    switchTile(
                      'Segregation Compliant',
                      segregationCompliant,
                      (v) => setState(() => segregationCompliant = v),
                    ),
                    switchTile(
                      'Spill Kit Available',
                      spillKitAvailable,
                      (v) => setState(() => spillKitAvailable = v),
                    ),
                    switchTile(
                      'Emergency Equipment Ready',
                      emergencyEquipmentReady,
                      (v) => setState(() => emergencyEquipmentReady = v),
                    ),
                    switchTile(
                      'Workers Trained',
                      trainedWorkers,
                      (v) => setState(() => trainedWorkers = v),
                    ),

                    section('12C • Waste Management'),
                    dropdown(
                      'Waste Type',
                      wasteType,
                      widget.wasteTypes,
                      (v) => setState(() => wasteType = v!),
                    ),
                    field('wasteCode', 'Waste Code / Classification'),
                    field('wasteQuantity', 'Waste Quantity'),
                    field('wasteUnit', 'Waste Unit'),
                    field('wasteSource', 'Waste Source / Activity'),
                    field('wasteStorageLocation', 'Waste Storage Area'),
                    field('wasteContainer', 'Container / Label Details'),
                    field('wasteSegregation', 'Waste Segregation Details', maxLines: 3),
                    field('disposalMethod', 'Disposal / Treatment Method', maxLines: 2),
                    field('disposalCompany', 'Licensed Waste Contractor'),
                    field('disposalLicense', 'Waste Contractor License / Permit'),
                    field('manifestReference', 'Waste Transfer / Manifest Reference'),
                    field(
                      'disposalDate',
                      'Disposal / Transfer Date',
                      readOnly: true,
                      onTap: () => pickDate('disposalDate'),
                    ),
                    switchTile(
                      'Waste Area Ready',
                      wasteAreaReady,
                      (v) => setState(() => wasteAreaReady = v),
                    ),
                    switchTile(
                      'Waste Segregation Verified',
                      wasteSegregated,
                      (v) => setState(() => wasteSegregated = v),
                    ),
                    switchTile(
                      'Licensed Disposal Confirmed',
                      licensedDisposal,
                      (v) => setState(() => licensedDisposal = v),
                    ),
                    switchTile(
                      'Manifest / Transfer Record Available',
                      manifestAvailable,
                      (v) => setState(() => manifestAvailable = v),
                    ),

                    section('12D • Environmental Aspects & Pollution Control'),
                    field('environmentalAspect', 'Environmental Aspect', maxLines: 3),
                    field('environmentalImpact', 'Environmental Impact', maxLines: 3),
                    field('environmentalControls', 'Environmental Controls', maxLines: 4),
                    field('dustFindings', 'Dust / Air Quality Findings', maxLines: 3),
                    field('emissionFindings', 'Emission Findings', maxLines: 3),
                    field('noiseFindings', 'Noise / Vibration Findings', maxLines: 3),
                    field('waterFindings', 'Water / Wastewater Findings', maxLines: 3),
                    field('soilFindings', 'Soil / Ground Protection Findings', maxLines: 3),
                    switchTile(
                      'Pollution Prevention Controls',
                      pollutionControls,
                      (v) => setState(() => pollutionControls = v),
                    ),
                    switchTile(
                      'Dust Controls in Place',
                      dustControls,
                      (v) => setState(() => dustControls = v),
                    ),
                    switchTile(
                      'Noise Controls in Place',
                      noiseControls,
                      (v) => setState(() => noiseControls = v),
                    ),
                    switchTile(
                      'Water Controls in Place',
                      waterControls,
                      (v) => setState(() => waterControls = v),
                    ),
                    switchTile(
                      'Soil / Ground Protection',
                      soilProtection,
                      (v) => setState(() => soilProtection = v),
                    ),

                    section('12E • Spill / Leak & Environmental Incident'),
                    field('spillDetails', 'Spill / Leak Details', maxLines: 4),
                    field('spillQuantity', 'Estimated Quantity'),
                    field('spillCause', 'Cause / Source', maxLines: 3),
                    field('spillContainment', 'Containment Measures', maxLines: 3),
                    field('spillCleanup', 'Cleanup / Disposal Actions', maxLines: 3),

                    section('12F • Environmental Monitoring'),
                    field('monitoringParameter', 'Monitoring Parameter'),
                    field('monitoringMethod', 'Monitoring Method / Instrument'),
                    field('monitoringResult', 'Monitoring Result'),
                    field('monitoringUnit', 'Unit'),
                    field('monitoringLimit', 'Applicable Limit / Criterion'),
                    field(
                      'monitoringDate',
                      'Monitoring Date',
                      readOnly: true,
                      onTap: () => pickDate('monitoringDate'),
                    ),
                    switchTile(
                      'Monitoring Completed',
                      monitoringCompleted,
                      (v) => setState(() => monitoringCompleted = v),
                    ),

                    section('12G • Corrective Action & Verification'),
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
                      const ['Low', 'Medium', 'High', 'Critical'],
                      (v) => setState(() => actionPriority = v!),
                    ),
                    field('verificationBy', 'Verified By'),
                    field(
                      'verificationDate',
                      'Verification Date',
                      readOnly: true,
                      onTap: () => pickDate('verificationDate'),
                    ),
                    field('closureEvidence', 'Closure Evidence / Reference', maxLines: 2),
                    switchTile(
                      'Corrective Actions Closed',
                      correctiveActionsClosed,
                      (v) => setState(() => correctiveActionsClosed = v),
                    ),

                    section('12H • Legal, Permit & Review Integration'),
                    field('legalReference', 'Legal / Regulatory Reference'),
                    field('permitReference', 'Environmental / Waste Permit Reference'),
                    field('documentReference', 'HSE / Environmental Document Reference'),
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
                              ? 'Save Chemical / Environment Record'
                              : 'Update Chemical / Environment Record',
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

class ChemicalEnvironmentDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> record;

  const ChemicalEnvironmentDetailsSheet({
    super.key,
    required this.record,
  });

  static const darkGreen = Color(0xFF0B5D4B);

  String text(dynamic value) => value?.toString() ?? '';

  @override
  Widget build(BuildContext context) {
    final details = <MapEntry<String, String>>[
      MapEntry('Record No', text(record['recordNo'])),
      MapEntry('Record Type', text(record['recordType'])),
      MapEntry('Date / Time', '${text(record['date'])} ${text(record['time'])}'),
      MapEntry('Project', text(record['project'])),
      MapEntry('Site', text(record['site'])),
      MapEntry('Location', text(record['location'])),
      MapEntry('Department', text(record['department'])),
      MapEntry('Subject', text(record['subject'])),
      MapEntry('Chemical', text(record['chemicalName'])),
      MapEntry('CAS Number', text(record['casNumber'])),
      MapEntry('Manufacturer', text(record['manufacturer'])),
      MapEntry('Supplier', text(record['supplier'])),
      MapEntry('Quantity', '${text(record['quantity'])} ${text(record['unit'])}'),
      MapEntry('Storage', text(record['storageLocation'])),
      MapEntry('SDS Reference', text(record['sdsReference'])),
      MapEntry('Hazard Classification', text(record['hazardClassification'])),
      MapEntry('Hazards', text(record['hazards'])),
      MapEntry('Required PPE', text(record['requiredPpe'])),
      MapEntry('Waste Type', text(record['wasteType'])),
      MapEntry('Waste Quantity',
          '${text(record['wasteQuantity'])} ${text(record['wasteUnit'])}'),
      MapEntry('Waste Source', text(record['wasteSource'])),
      MapEntry('Disposal Method', text(record['disposalMethod'])),
      MapEntry('Disposal Company', text(record['disposalCompany'])),
      MapEntry('Manifest', text(record['manifestReference'])),
      MapEntry('Environmental Aspect', text(record['environmentalAspect'])),
      MapEntry('Environmental Impact', text(record['environmentalImpact'])),
      MapEntry('Environmental Controls', text(record['environmentalControls'])),
      MapEntry('Dust Findings', text(record['dustFindings'])),
      MapEntry('Noise Findings', text(record['noiseFindings'])),
      MapEntry('Water Findings', text(record['waterFindings'])),
      MapEntry('Soil Findings', text(record['soilFindings'])),
      MapEntry('Spill Details', text(record['spillDetails'])),
      MapEntry('Monitoring Parameter', text(record['monitoringParameter'])),
      MapEntry('Monitoring Result', text(record['monitoringResult'])),
      MapEntry('Corrective Action', text(record['correctiveAction'])),
      MapEntry('Action Owner', text(record['actionOwner'])),
      MapEntry('Action Due', text(record['actionDue'])),
      MapEntry('Verification Date', text(record['verificationDate'])),
      MapEntry('Legal Reference', text(record['legalReference'])),
      MapEntry('Permit Reference', text(record['permitReference'])),
      MapEntry('Next Review', text(record['reviewDate'])),
      MapEntry('Status', text(record['status'])),
      MapEntry('Lessons Learned', text(record['lessonsLearned'])),
      MapEntry('Remarks', text(record['remarks'])),
    ];

    final checks = <String, bool>{
      'SDS Available': record['sdsAvailable'] == true,
      'SDS Reviewed': record['sdsReviewed'] == true,
      'Chemical Approved': record['chemicalApproved'] == true,
      'Storage Compliant': record['storageCompliant'] == true,
      'Labels Compliant': record['labelsCompliant'] == true,
      'Segregation Compliant': record['segregationCompliant'] == true,
      'Spill Kit Available': record['spillKitAvailable'] == true,
      'Emergency Equipment Ready':
          record['emergencyEquipmentReady'] == true,
      'Workers Trained': record['trainedWorkers'] == true,
      'Waste Area Ready': record['wasteAreaReady'] == true,
      'Waste Segregated': record['wasteSegregated'] == true,
      'Licensed Disposal': record['licensedDisposal'] == true,
      'Manifest Available': record['manifestAvailable'] == true,
      'Pollution Controls': record['pollutionControls'] == true,
      'Dust Controls': record['dustControls'] == true,
      'Noise Controls': record['noiseControls'] == true,
      'Water Controls': record['waterControls'] == true,
      'Soil Protection': record['soilProtection'] == true,
      'Monitoring Completed': record['monitoringCompleted'] == true,
      'Corrective Actions Closed':
          record['correctiveActionsClosed'] == true,
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
                    'Chemical & Environment Details',
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
                    'Chemical & Environmental Readiness Checks',
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
