import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OccupationalHealthPage extends StatefulWidget {
  const OccupationalHealthPage({super.key});

  @override
  State<OccupationalHealthPage> createState() => _OccupationalHealthPageState();
}

class _OccupationalHealthPageState extends State<OccupationalHealthPage> {
  static const storageKey = 'safenexus_hse_occupational_health';
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
    'Scheduled',
    'Open',
    'Under Review',
    'Action Required',
    'Fit',
    'Fit with Restrictions',
    'Unfit',
    'Completed',
    'Closed',
    'Cancelled',
  ];

  final recordTypes = const [
    'Occupational Health Master',
    'Medical Fitness',
    'Pre-Employment Medical',
    'Periodic Medical',
    'Return to Work',
    'Fitness for Task',
    'Heat Stress',
    'Heat Stress Monitoring',
    'Welfare Inspection',
    'First Aid',
    'Health Surveillance',
    'Occupational Hygiene',
    'Ergonomics',
    'Fatigue Management',
    'PPE / Respiratory Health',
    'Health Awareness',
    'Medical Emergency Follow-up',
    'Other',
  ];

  final fitnessStatuses = const [
    'Not Assessed',
    'Fit',
    'Fit with Restrictions',
    'Temporarily Unfit',
    'Unfit',
    'Pending Review',
  ];

  final priorities = const ['Low', 'Medium', 'High', 'Critical'];

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
    final expiry = DateTime.tryParse(text(r['validUntil']));
    if (expiry == null) return false;
    final now = DateTime.now();
    final limit = now.add(const Duration(days: 30));
    final status = text(r['status']);
    return !expiry.isBefore(now) &&
        !expiry.isAfter(limit) &&
        status != 'Closed' &&
        status != 'Cancelled';
  }

  List<Map<String, dynamic>> get filtered {
    final q = search.trim().toLowerCase();
    final result = records.where((r) {
      final matchesSearch = q.isEmpty ||
          text(r['recordNo']).toLowerCase().contains(q) ||
          text(r['recordType']).toLowerCase().contains(q) ||
          text(r['workerName']).toLowerCase().contains(q) ||
          text(r['workerId']).toLowerCase().contains(q) ||
          text(r['project']).toLowerCase().contains(q) ||
          text(r['site']).toLowerCase().contains(q) ||
          text(r['department']).toLowerCase().contains(q) ||
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

  int countStatus(String value) =>
      records.where((r) => text(r['status']) == value).length;

  int countType(String value) =>
      records.where((r) => text(r['recordType']) == value).length;

  Future<void> openForm({Map<String, dynamic>? existing}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => OccupationalHealthFormSheet(
        existing: existing,
        statuses: statuses,
        recordTypes: recordTypes,
        fitnessStatuses: fitnessStatuses,
        priorities: priorities,
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
        content: const Text('Delete this occupational health record?'),
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
      builder: (_) => OccupationalHealthDetailsSheet(record: record),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = records.length;
    final fit = countStatus('Fit');
    final restricted = countStatus('Fit with Restrictions');
    final unfit = countStatus('Unfit');
    final actions = countStatus('Action Required');
    final expiring = records.where(isExpiringSoon).length;
    final overdue = records.where(isOverdue).length;
    final heatStress = countType('Heat Stress') +
        countType('Heat Stress Monitoring') +
        countType('Fatigue Management');
    final welfare = countType('Welfare Inspection');

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Occupational Health'),
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
                  fit,
                  restricted,
                  unfit,
                  actions,
                  expiring,
                  overdue,
                  heatStress,
                  welfare,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                  child: TextField(
                    onChanged: (v) => setState(() => search = v),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search worker, medical record, project...',
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
    int fit,
    int restricted,
    int unfit,
    int actions,
    int expiring,
    int overdue,
    int heatStress,
    int welfare,
  ) {
    final data = [
      ('Total', total, Icons.health_and_safety),
      ('Fit', fit, Icons.check_circle),
      ('Restricted', restricted, Icons.warning_amber),
      ('Unfit', unfit, Icons.cancel),
      ('Actions', actions, Icons.task_alt),
      ('Expiring', expiring, Icons.event),
      ('Overdue', overdue, Icons.error_outline),
      ('Heat / Fatigue', heatStress, Icons.wb_sunny),
      ('Welfare', welfare, Icons.people),
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
      return const Center(child: Text('No occupational health records found.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
      itemCount: data.length,
      itemBuilder: (_, index) {
        final r = data[index];
        final status = text(r['status']);
        final overdue = isOverdue(r);
        final expiring = isExpiringSoon(r);

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
                        ? text(r['workerName']).isEmpty
                            ? 'Occupational health record'
                            : text(r['workerName'])
                        : text(r['subject']),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${text(r['workerName'])} • ${text(r['workerId'])}',
                    style: const TextStyle(color: Colors.black87),
                  ),
                  Text('${text(r['project'])} • ${text(r['site'])}'),
                  Text(
                    '${text(r['department'])} • ${text(r['date'])}',
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 7),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      chip(status, statusColor(status)),
                      if (text(r['fitnessStatus']).isNotEmpty)
                        chip(
                          text(r['fitnessStatus']),
                          fitnessColor(text(r['fitnessStatus'])),
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
      case 'Fit':
      case 'Completed':
      case 'Closed':
        return Colors.green;
      case 'Fit with Restrictions':
      case 'Action Required':
        return Colors.orange.shade800;
      case 'Unfit':
        return Colors.red;
      case 'Cancelled':
        return Colors.grey;
      default:
        return darkGreen;
    }
  }

  Color fitnessColor(String value) {
    switch (value) {
      case 'Fit':
        return Colors.green;
      case 'Fit with Restrictions':
        return Colors.orange.shade800;
      case 'Unfit':
      case 'Temporarily Unfit':
        return Colors.red;
      default:
        return Colors.blueGrey;
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

class OccupationalHealthFormSheet extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> statuses;
  final List<String> recordTypes;
  final List<String> fitnessStatuses;
  final List<String> priorities;

  const OccupationalHealthFormSheet({
    super.key,
    required this.existing,
    required this.statuses,
    required this.recordTypes,
    required this.fitnessStatuses,
    required this.priorities,
  });

  @override
  State<OccupationalHealthFormSheet> createState() =>
      _OccupationalHealthFormSheetState();
}

class _OccupationalHealthFormSheetState
    extends State<OccupationalHealthFormSheet> {
  static const primaryGreen = Color(0xFF159447);
  static const darkGreen = Color(0xFF0B5D4B);

  final formKey = GlobalKey<FormState>();
  final c = <String, TextEditingController>{};

  String recordType = 'Occupational Health Master';
  String status = 'Draft';
  String fitnessStatus = 'Not Assessed';
  String riskLevel = 'Medium';
  String actionPriority = 'Medium';

  bool medicalCertificateVerified = false;
  bool restrictionsCommunicated = false;
  bool healthSurveillanceRequired = false;
  bool heatStressControls = false;
  bool hydrationAvailable = false;
  bool shadedRestAvailable = false;
  bool workRestScheduleImplemented = false;
  bool firstAidReady = false;
  bool emergencyReferralReady = false;
  bool welfareFacilitiesAdequate = false;
  bool hygieneAdequate = false;
  bool ergonomicsReviewed = false;
  bool fatigueControls = false;
  bool respiratoryProtectionReviewed = false;
  bool workerBriefed = false;
  bool confidentialityProtected = true;
  bool correctiveActionsClosed = false;

  final riskLevels = const ['Low', 'Medium', 'High', 'Critical'];

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
      'workerName',
      'workerId',
      'company',
      'jobRole',
      'supervisor',
      'subject',
      'examinationType',
      'medicalProvider',
      'medicalReference',
      'certificateNo',
      'examinationDate',
      'validFrom',
      'validUntil',
      'fitnessRestrictions',
      'workLimitations',
      'medicalRecommendations',
      'followUpDate',
      'healthSurveillanceType',
      'healthHazards',
      'exposureGroup',
      'occupationalHygieneFindings',
      'heatStressAssessment',
      'temperatureCondition',
      'hydrationPlan',
      'restArea',
      'heatStressSymptoms',
      'firstAidFindings',
      'welfareFindings',
      'hygieneFindings',
      'ergonomicFindings',
      'fatigueFindings',
      'respiratoryFindings',
      'awarenessTopic',
      'awarenessDate',
      'emergencyReferral',
      'hospitalClinic',
      'correctiveAction',
      'actionOwner',
      'actionDue',
      'verificationBy',
      'verificationDate',
      'closureEvidence',
      'reviewDate',
      'documentRef',
      'confidentialRecordRef',
      'lessonsLearned',
      'remarks',
    ];

    for (final key in keys) {
      c[key] = TextEditingController();
    }

    final r = widget.existing;
    if (r == null) {
      final now = DateTime.now();
      c['recordNo']!.text = 'OH-${now.millisecondsSinceEpoch}';
      c['date']!.text = date(now);
      c['time']!.text = time(now);
      c['examinationDate']!.text = date(now);
      c['reviewDate']!.text = date(now.add(const Duration(days: 365)));
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
      fitnessStatus = valid(
        text(r['fitnessStatus']),
        widget.fitnessStatuses,
        widget.fitnessStatuses.first,
      );
      riskLevel = valid(text(r['riskLevel']), riskLevels, 'Medium');
      actionPriority = valid(
        text(r['actionPriority']),
        widget.priorities,
        'Medium',
      );

      medicalCertificateVerified = r['medicalCertificateVerified'] == true;
      restrictionsCommunicated = r['restrictionsCommunicated'] == true;
      healthSurveillanceRequired = r['healthSurveillanceRequired'] == true;
      heatStressControls = r['heatStressControls'] == true;
      hydrationAvailable = r['hydrationAvailable'] == true;
      shadedRestAvailable = r['shadedRestAvailable'] == true;
      workRestScheduleImplemented = r['workRestScheduleImplemented'] == true;
      firstAidReady = r['firstAidReady'] == true;
      emergencyReferralReady = r['emergencyReferralReady'] == true;
      welfareFacilitiesAdequate = r['welfareFacilitiesAdequate'] == true;
      hygieneAdequate = r['hygieneAdequate'] == true;
      ergonomicsReviewed = r['ergonomicsReviewed'] == true;
      fatigueControls = r['fatigueControls'] == true;
      respiratoryProtectionReviewed =
          r['respiratoryProtectionReviewed'] == true;
      workerBriefed = r['workerBriefed'] == true;
      confidentialityProtected = r['confidentialityProtected'] != false;
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
      'fitnessStatus': fitnessStatus,
      'riskLevel': riskLevel,
      'date': c['date']!.text.trim(),
      'time': c['time']!.text.trim(),
      'project': c['project']!.text.trim(),
      'site': c['site']!.text.trim(),
      'location': c['location']!.text.trim(),
      'department': c['department']!.text.trim(),
      'workerName': c['workerName']!.text.trim(),
      'workerId': c['workerId']!.text.trim(),
      'company': c['company']!.text.trim(),
      'jobRole': c['jobRole']!.text.trim(),
      'supervisor': c['supervisor']!.text.trim(),
      'subject': c['subject']!.text.trim(),
      'examinationType': c['examinationType']!.text.trim(),
      'medicalProvider': c['medicalProvider']!.text.trim(),
      'medicalReference': c['medicalReference']!.text.trim(),
      'certificateNo': c['certificateNo']!.text.trim(),
      'examinationDate': c['examinationDate']!.text.trim(),
      'validFrom': c['validFrom']!.text.trim(),
      'validUntil': c['validUntil']!.text.trim(),
      'fitnessRestrictions': c['fitnessRestrictions']!.text.trim(),
      'workLimitations': c['workLimitations']!.text.trim(),
      'medicalRecommendations': c['medicalRecommendations']!.text.trim(),
      'followUpDate': c['followUpDate']!.text.trim(),
      'healthSurveillanceType': c['healthSurveillanceType']!.text.trim(),
      'healthHazards': c['healthHazards']!.text.trim(),
      'exposureGroup': c['exposureGroup']!.text.trim(),
      'occupationalHygieneFindings':
          c['occupationalHygieneFindings']!.text.trim(),
      'heatStressAssessment': c['heatStressAssessment']!.text.trim(),
      'temperatureCondition': c['temperatureCondition']!.text.trim(),
      'hydrationPlan': c['hydrationPlan']!.text.trim(),
      'restArea': c['restArea']!.text.trim(),
      'heatStressSymptoms': c['heatStressSymptoms']!.text.trim(),
      'firstAidFindings': c['firstAidFindings']!.text.trim(),
      'welfareFindings': c['welfareFindings']!.text.trim(),
      'hygieneFindings': c['hygieneFindings']!.text.trim(),
      'ergonomicFindings': c['ergonomicFindings']!.text.trim(),
      'fatigueFindings': c['fatigueFindings']!.text.trim(),
      'respiratoryFindings': c['respiratoryFindings']!.text.trim(),
      'awarenessTopic': c['awarenessTopic']!.text.trim(),
      'awarenessDate': c['awarenessDate']!.text.trim(),
      'emergencyReferral': c['emergencyReferral']!.text.trim(),
      'hospitalClinic': c['hospitalClinic']!.text.trim(),
      'correctiveAction': c['correctiveAction']!.text.trim(),
      'actionOwner': c['actionOwner']!.text.trim(),
      'actionDue': c['actionDue']!.text.trim(),
      'actionPriority': actionPriority,
      'verificationBy': c['verificationBy']!.text.trim(),
      'verificationDate': c['verificationDate']!.text.trim(),
      'closureEvidence': c['closureEvidence']!.text.trim(),
      'reviewDate': c['reviewDate']!.text.trim(),
      'documentRef': c['documentRef']!.text.trim(),
      'confidentialRecordRef': c['confidentialRecordRef']!.text.trim(),
      'lessonsLearned': c['lessonsLearned']!.text.trim(),
      'remarks': c['remarks']!.text.trim(),
      'medicalCertificateVerified': medicalCertificateVerified,
      'restrictionsCommunicated': restrictionsCommunicated,
      'healthSurveillanceRequired': healthSurveillanceRequired,
      'heatStressControls': heatStressControls,
      'hydrationAvailable': hydrationAvailable,
      'shadedRestAvailable': shadedRestAvailable,
      'workRestScheduleImplemented': workRestScheduleImplemented,
      'firstAidReady': firstAidReady,
      'emergencyReferralReady': emergencyReferralReady,
      'welfareFacilitiesAdequate': welfareFacilitiesAdequate,
      'hygieneAdequate': hygieneAdequate,
      'ergonomicsReviewed': ergonomicsReviewed,
      'fatigueControls': fatigueControls,
      'respiratoryProtectionReviewed': respiratoryProtectionReviewed,
      'workerBriefed': workerBriefed,
      'confidentialityProtected': confidentialityProtected,
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
                            ? 'Add Occupational Health Record'
                            : 'Edit Occupational Health Record',
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
                    section('11A • Occupational Health Master'),
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
                    field('location', 'Location'),
                    field('department', 'Department'),
                    field('workerName', 'Worker Name'),
                    field('workerId', 'Worker ID'),
                    field('company', 'Company / Contractor'),
                    field('jobRole', 'Job Role / Trade'),
                    field('supervisor', 'Supervisor'),
                    field('subject', 'Subject / Health Activity', required: true),
                    dropdown(
                      'Fitness Status',
                      fitnessStatus,
                      widget.fitnessStatuses,
                      (v) => setState(() => fitnessStatus = v!),
                    ),
                    dropdown(
                      'Risk Level',
                      riskLevel,
                      riskLevels,
                      (v) => setState(() => riskLevel = v!),
                    ),
                    dropdown(
                      'Record Status',
                      status,
                      widget.statuses,
                      (v) => setState(() => status = v!),
                    ),

                    section('11B • Medical Fitness & Examination'),
                    field('examinationType', 'Examination Type'),
                    field('medicalProvider', 'Medical Provider / Clinic'),
                    field('medicalReference', 'Medical Reference'),
                    field('certificateNo', 'Certificate No'),
                    field(
                      'examinationDate',
                      'Examination Date',
                      readOnly: true,
                      onTap: () => pickDate('examinationDate'),
                    ),
                    field(
                      'validFrom',
                      'Valid From',
                      readOnly: true,
                      onTap: () => pickDate('validFrom'),
                    ),
                    field(
                      'validUntil',
                      'Valid Until / Fitness Expiry',
                      readOnly: true,
                      onTap: () => pickDate('validUntil'),
                    ),
                    field('fitnessRestrictions', 'Fitness Restrictions', maxLines: 3),
                    field('workLimitations', 'Work Limitations', maxLines: 3),
                    field(
                      'medicalRecommendations',
                      'Medical Recommendations',
                      maxLines: 3,
                    ),
                    field(
                      'followUpDate',
                      'Follow-up Date',
                      readOnly: true,
                      onTap: () => pickDate('followUpDate'),
                    ),
                    switchTile(
                      'Medical Certificate Verified',
                      medicalCertificateVerified,
                      (v) =>
                          setState(() => medicalCertificateVerified = v),
                    ),
                    switchTile(
                      'Restrictions Communicated to Supervisor',
                      restrictionsCommunicated,
                      (v) => setState(() => restrictionsCommunicated = v),
                    ),

                    section('11C • Health Surveillance & Occupational Hygiene'),
                    field('healthSurveillanceType', 'Health Surveillance Type'),
                    field('healthHazards', 'Health Hazards / Exposure', maxLines: 3),
                    field('exposureGroup', 'Exposure Group / Worker Category'),
                    field(
                      'occupationalHygieneFindings',
                      'Occupational Hygiene Findings',
                      maxLines: 4,
                    ),
                    switchTile(
                      'Health Surveillance Required',
                      healthSurveillanceRequired,
                      (v) =>
                          setState(() => healthSurveillanceRequired = v),
                    ),
                    switchTile(
                      'Respiratory Protection Reviewed',
                      respiratoryProtectionReviewed,
                      (v) => setState(
                        () => respiratoryProtectionReviewed = v,
                      ),
                    ),

                    section('11D • Heat Stress & Fatigue Management'),
                    field(
                      'heatStressAssessment',
                      'Heat Stress Assessment / WBGT Reference',
                      maxLines: 3,
                    ),
                    field(
                      'temperatureCondition',
                      'Temperature / Weather Condition',
                    ),
                    field('hydrationPlan', 'Hydration Plan', maxLines: 3),
                    field('restArea', 'Rest / Shade Area'),
                    field(
                      'heatStressSymptoms',
                      'Heat Stress Symptoms / Observations',
                      maxLines: 3,
                    ),
                    field('fatigueFindings', 'Fatigue / Alertness Findings', maxLines: 3),
                    switchTile(
                      'Heat Stress Controls in Place',
                      heatStressControls,
                      (v) => setState(() => heatStressControls = v),
                    ),
                    switchTile(
                      'Hydration Available',
                      hydrationAvailable,
                      (v) => setState(() => hydrationAvailable = v),
                    ),
                    switchTile(
                      'Shaded Rest Available',
                      shadedRestAvailable,
                      (v) => setState(() => shadedRestAvailable = v),
                    ),
                    switchTile(
                      'Work / Rest Schedule Implemented',
                      workRestScheduleImplemented,
                      (v) =>
                          setState(() => workRestScheduleImplemented = v),
                    ),
                    switchTile(
                      'Fatigue Controls Implemented',
                      fatigueControls,
                      (v) => setState(() => fatigueControls = v),
                    ),

                    section('11E • Welfare, First Aid & Health Facilities'),
                    field('firstAidFindings', 'First Aid Findings', maxLines: 3),
                    field('welfareFindings', 'Welfare Facilities Findings', maxLines: 3),
                    field('hygieneFindings', 'Hygiene / Sanitation Findings', maxLines: 3),
                    field('emergencyReferral', 'Emergency Referral / Follow-up', maxLines: 3),
                    field('hospitalClinic', 'Hospital / Clinic Reference'),
                    switchTile(
                      'First Aid Ready',
                      firstAidReady,
                      (v) => setState(() => firstAidReady = v),
                    ),
                    switchTile(
                      'Emergency Referral Ready',
                      emergencyReferralReady,
                      (v) => setState(() => emergencyReferralReady = v),
                    ),
                    switchTile(
                      'Welfare Facilities Adequate',
                      welfareFacilitiesAdequate,
                      (v) =>
                          setState(() => welfareFacilitiesAdequate = v),
                    ),
                    switchTile(
                      'Hygiene / Sanitation Adequate',
                      hygieneAdequate,
                      (v) => setState(() => hygieneAdequate = v),
                    ),

                    section('11F • Ergonomics, PPE & Health Awareness'),
                    field('ergonomicFindings', 'Ergonomic Findings', maxLines: 3),
                    field(
                      'respiratoryFindings',
                      'Respiratory / PPE Health Findings',
                      maxLines: 3,
                    ),
                    field('awarenessTopic', 'Health Awareness Topic'),
                    field(
                      'awarenessDate',
                      'Awareness Date',
                      readOnly: true,
                      onTap: () => pickDate('awarenessDate'),
                    ),
                    switchTile(
                      'Ergonomics Reviewed',
                      ergonomicsReviewed,
                      (v) => setState(() => ergonomicsReviewed = v),
                    ),
                    switchTile(
                      'Worker Health Briefing Completed',
                      workerBriefed,
                      (v) => setState(() => workerBriefed = v),
                    ),
                    switchTile(
                      'Confidentiality Protected',
                      confidentialityProtected,
                      (v) =>
                          setState(() => confidentialityProtected = v),
                    ),

                    section('11G • Corrective Action & Closure'),
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
                      widget.priorities,
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

                    section('11H • Integration, Review & Records'),
                    field('documentRef', 'HSE / Medical Document Reference'),
                    field(
                      'confidentialRecordRef',
                      'Confidential Medical Record Reference',
                    ),
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
                              ? 'Save Health Record'
                              : 'Update Health Record',
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

class OccupationalHealthDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> record;

  const OccupationalHealthDetailsSheet({
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
      MapEntry('Worker', '${text(record['workerName'])} (${text(record['workerId'])})'),
      MapEntry('Company', text(record['company'])),
      MapEntry('Job Role', text(record['jobRole'])),
      MapEntry('Subject', text(record['subject'])),
      MapEntry('Fitness Status', text(record['fitnessStatus'])),
      MapEntry('Risk Level', text(record['riskLevel'])),
      MapEntry('Examination', text(record['examinationType'])),
      MapEntry('Medical Provider', text(record['medicalProvider'])),
      MapEntry('Certificate', text(record['certificateNo'])),
      MapEntry('Examination Date', text(record['examinationDate'])),
      MapEntry('Valid Until', text(record['validUntil'])),
      MapEntry('Restrictions', text(record['fitnessRestrictions'])),
      MapEntry('Work Limitations', text(record['workLimitations'])),
      MapEntry('Medical Recommendations', text(record['medicalRecommendations'])),
      MapEntry('Health Hazards', text(record['healthHazards'])),
      MapEntry('Hygiene Findings', text(record['occupationalHygieneFindings'])),
      MapEntry('Heat Stress Assessment', text(record['heatStressAssessment'])),
      MapEntry('Fatigue Findings', text(record['fatigueFindings'])),
      MapEntry('Welfare Findings', text(record['welfareFindings'])),
      MapEntry('First Aid Findings', text(record['firstAidFindings'])),
      MapEntry('Ergonomic Findings', text(record['ergonomicFindings'])),
      MapEntry('Corrective Action', text(record['correctiveAction'])),
      MapEntry('Action Owner', text(record['actionOwner'])),
      MapEntry('Action Due', text(record['actionDue'])),
      MapEntry('Verification', text(record['verificationDate'])),
      MapEntry('Next Review', text(record['reviewDate'])),
      MapEntry('Lessons Learned', text(record['lessonsLearned'])),
      MapEntry('Status', text(record['status'])),
      MapEntry('Remarks', text(record['remarks'])),
    ];

    final checks = <String, bool>{
      'Medical Certificate Verified':
          record['medicalCertificateVerified'] == true,
      'Restrictions Communicated':
          record['restrictionsCommunicated'] == true,
      'Health Surveillance Required':
          record['healthSurveillanceRequired'] == true,
      'Heat Stress Controls': record['heatStressControls'] == true,
      'Hydration Available': record['hydrationAvailable'] == true,
      'Shaded Rest Available': record['shadedRestAvailable'] == true,
      'Work / Rest Schedule': record['workRestScheduleImplemented'] == true,
      'First Aid Ready': record['firstAidReady'] == true,
      'Emergency Referral Ready': record['emergencyReferralReady'] == true,
      'Welfare Adequate': record['welfareFacilitiesAdequate'] == true,
      'Hygiene Adequate': record['hygieneAdequate'] == true,
      'Ergonomics Reviewed': record['ergonomicsReviewed'] == true,
      'Fatigue Controls': record['fatigueControls'] == true,
      'Respiratory Protection Reviewed':
          record['respiratoryProtectionReviewed'] == true,
      'Worker Briefed': record['workerBriefed'] == true,
      'Confidentiality Protected':
          record['confidentialityProtected'] != false,
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
                    'Occupational Health Details',
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
                    'Health & Welfare Readiness Checks',
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
