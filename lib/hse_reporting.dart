import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HseReportingPage extends StatefulWidget {
  const HseReportingPage({super.key});

  @override
  State<HseReportingPage> createState() => _HseReportingPageState();
}

class _HseReportingPageState extends State<HseReportingPage> {
  static const String storageKey = 'safenexus_hse_reporting';
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  List<Map<String, dynamic>> records = [];
  String search = '';
  String statusFilter = 'All';
  String reportTypeFilter = 'All';
  String periodFilter = 'All';

  final reportTypes = const [
    'Daily HSE Report',
    'Weekly HSE Report',
    'Monthly HSE Report',
    'KPI Report',
    'HSE Statistics',
    'Inspection Report',
    'Audit Report',
    'Incident Report',
    'Training Report',
    'Environmental Report',
    'Emergency / Drill Report',
    'Management Report',
    'Client HSE Report',
    'Authority Report',
    'Other',
  ];

  final statuses = const [
    'Draft',
    'Prepared',
    'Under Review',
    'Approved',
    'Submitted',
    'Returned for Revision',
    'Closed',
    'Cancelled',
  ];

  final periods = const [
    'Daily',
    'Weekly',
    'Monthly',
    'Quarterly',
    'Annual',
    'Ad Hoc',
  ];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);
    if (raw == null || raw.isEmpty) return;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        setState(() {
          records = decoded
              .whereType<Map>()
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        });
      }
    } catch (_) {}
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(records));
  }

  List<Map<String, dynamic>> get filtered {
    final q = search.trim().toLowerCase();
    return records.where((r) {
      final text = r.values.join(' ').toLowerCase();
      return (q.isEmpty || text.contains(q)) &&
          (statusFilter == 'All' || r['status'] == statusFilter) &&
          (reportTypeFilter == 'All' || r['reportType'] == reportTypeFilter) &&
          (periodFilter == 'All' || r['period'] == periodFilter);
    }).toList();
  }

  int _count(String status) =>
      records.where((r) => r['status'] == status).length;

  int _periodCount(String period) =>
      records.where((r) => r['period'] == period).length;

  bool _isOverdue(Map<String, dynamic> r) {
    final due = DateTime.tryParse('${r['submissionDue'] ?? ''}');
    final status = '${r['status'] ?? ''}';
    return due != null &&
        due.isBefore(DateTime.now()) &&
        status != 'Approved' &&
        status != 'Submitted' &&
        status != 'Closed' &&
        status != 'Cancelled';
  }

  int get overdueCount => records.where(_isOverdue).length;

  Future<void> _openForm({Map<String, dynamic>? existing, int? index}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _ReportForm(
        reportTypes: reportTypes,
        statuses: statuses,
        periods: periods,
        existing: existing,
      ),
    );
    if (result == null) return;

    final now = DateTime.now().toIso8601String();
    result['updatedAt'] = now;
    if (index == null) {
      result['id'] = now;
      result['createdAt'] = now;
      records.insert(0, result);
    } else {
      result['id'] = records[index]['id'] ?? now;
      result['createdAt'] = records[index]['createdAt'] ?? now;
      records[index] = result;
    }
    await _save();
    if (mounted) setState(() {});
  }

  Future<void> _delete(int index) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Report?'),
        content: const Text('This HSE report record will be deleted.'),
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
    records.removeAt(index);
    await _save();
    if (mounted) setState(() {});
  }

  void _details(Map<String, dynamic> record) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _DetailsSheet(record: record),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visible = filtered;
    return Scaffold(
      appBar: AppBar(
        title: const Text('15. HSE Reporting'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_chart),
        label: const Text('Add Report'),
      ),
      body: Column(
        children: [
          _Dashboard(
            total: records.length,
            draft: _count('Draft'),
            review: _count('Under Review'),
            approved: _count('Approved'),
            submitted: _count('Submitted'),
            monthly: _periodCount('Monthly'),
            overdue: overdueCount,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
            child: Column(
              children: [
                TextField(
                  onChanged: (v) => setState(() => search = v),
                  decoration: const InputDecoration(
                    labelText: 'Search HSE reports / KPI / statistics',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: statusFilter,
                        decoration: const InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder(),
                        ),
                        items: ['All', ...statuses]
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => statusFilter = v ?? 'All'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: periodFilter,
                        decoration: const InputDecoration(
                          labelText: 'Period',
                          border: OutlineInputBorder(),
                        ),
                        items: ['All', ...periods]
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => periodFilter = v ?? 'All'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: reportTypeFilter,
                  decoration: const InputDecoration(
                    labelText: 'Report Type',
                    border: OutlineInputBorder(),
                  ),
                  items: ['All', ...reportTypes]
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (v) =>
                      setState(() => reportTypeFilter = v ?? 'All'),
                ),
              ],
            ),
          ),
          Expanded(
            child: visible.isEmpty
                ? const Center(child: Text('No HSE report records found.'))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
                    itemCount: visible.length,
                    itemBuilder: (_, i) {
                      final record = visible[i];
                      final realIndex = records.indexOf(record);
                      final overdue = _isOverdue(record);
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                overdue ? Colors.red : primaryGreen,
                            child: Icon(
                              overdue ? Icons.warning : Icons.assessment,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            '${record['reportNo'] ?? ''} • ${record['title'] ?? ''}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            '${record['reportType'] ?? ''} • ${record['period'] ?? ''}\n'
                            '${record['project'] ?? ''} • ${record['site'] ?? ''}\n'
                            'Status: ${record['status'] ?? ''}'
                            '${overdue ? ' • OVERDUE' : ''}',
                          ),
                          isThreeLine: true,
                          onTap: () => _details(record),
                          trailing: PopupMenuButton<String>(
                            onSelected: (v) {
                              if (v == 'edit') {
                                _openForm(
                                  existing:
                                      Map<String, dynamic>.from(record),
                                  index: realIndex,
                                );
                              } else if (v == 'delete') {
                                _delete(realIndex);
                              }
                            },
                            itemBuilder: (_) => const [
                              PopupMenuItem(
                                value: 'edit',
                                child: Text('Edit'),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _Dashboard extends StatelessWidget {
  final int total;
  final int draft;
  final int review;
  final int approved;
  final int submitted;
  final int monthly;
  final int overdue;

  const _Dashboard({
    required this.total,
    required this.draft,
    required this.review,
    required this.approved,
    required this.submitted,
    required this.monthly,
    required this.overdue,
  });

  @override
  Widget build(BuildContext context) {
    final data = [
      ('Total', total, Icons.list_alt),
      ('Draft', draft, Icons.edit_note),
      ('Review', review, Icons.rate_review),
      ('Approved', approved, Icons.verified),
      ('Submitted', submitted, Icons.send),
      ('Monthly', monthly, Icons.calendar_month),
      ('Overdue', overdue, Icons.warning),
    ];
    return SizedBox(
      height: 106,
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final item = data[i];
          return Card(
            child: SizedBox(
              width: 104,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item.$3),
                    const SizedBox(height: 3),
                    Text(
                      '${item.$2}',
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(item.$1, style: const TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ReportForm extends StatefulWidget {
  final List<String> reportTypes;
  final List<String> statuses;
  final List<String> periods;
  final Map<String, dynamic>? existing;

  const _ReportForm({
    required this.reportTypes,
    required this.statuses,
    required this.periods,
    this.existing,
  });

  @override
  State<_ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<_ReportForm> {
  final formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> c;
  late String reportType;
  late String status;
  late String period;

  @override
  void initState() {
    super.initState();
    final r = widget.existing ?? {};
    c = {
      'reportNo': TextEditingController(text: '${r['reportNo'] ?? ''}'),
      'title': TextEditingController(text: '${r['title'] ?? ''}'),
      'project': TextEditingController(text: '${r['project'] ?? ''}'),
      'site': TextEditingController(text: '${r['site'] ?? ''}'),
      'location': TextEditingController(text: '${r['location'] ?? ''}'),
      'department': TextEditingController(text: '${r['department'] ?? ''}'),
      'reportDate': TextEditingController(text: '${r['reportDate'] ?? ''}'),
      'periodStart': TextEditingController(text: '${r['periodStart'] ?? ''}'),
      'periodEnd': TextEditingController(text: '${r['periodEnd'] ?? ''}'),
      'submissionDue':
          TextEditingController(text: '${r['submissionDue'] ?? ''}'),
      'preparedBy': TextEditingController(text: '${r['preparedBy'] ?? ''}'),
      'reviewedBy': TextEditingController(text: '${r['reviewedBy'] ?? ''}'),
      'approvedBy': TextEditingController(text: '${r['approvedBy'] ?? ''}'),
      'submittedTo': TextEditingController(text: '${r['submittedTo'] ?? ''}'),
      'reportSummary':
          TextEditingController(text: '${r['reportSummary'] ?? ''}'),
      'manhours': TextEditingController(text: '${r['manhours'] ?? ''}'),
      'headcount': TextEditingController(text: '${r['headcount'] ?? ''}'),
      'inductionCount':
          TextEditingController(text: '${r['inductionCount'] ?? ''}'),
      'trainingCount':
          TextEditingController(text: '${r['trainingCount'] ?? ''}'),
      'toolboxTalks':
          TextEditingController(text: '${r['toolboxTalks'] ?? ''}'),
      'inspections':
          TextEditingController(text: '${r['inspections'] ?? ''}'),
      'observations':
          TextEditingController(text: '${r['observations'] ?? ''}'),
      'nearMisses':
          TextEditingController(text: '${r['nearMisses'] ?? ''}'),
      'incidents': TextEditingController(text: '${r['incidents'] ?? ''}'),
      'lostTimeInjuries':
          TextEditingController(text: '${r['lostTimeInjuries'] ?? ''}'),
      'firstAidCases':
          TextEditingController(text: '${r['firstAidCases'] ?? ''}'),
      'medicalCases':
          TextEditingController(text: '${r['medicalCases'] ?? ''}'),
      'daysLost': TextEditingController(text: '${r['daysLost'] ?? ''}'),
      'unsafeActs':
          TextEditingController(text: '${r['unsafeActs'] ?? ''}'),
      'unsafeConditions':
          TextEditingController(text: '${r['unsafeConditions'] ?? ''}'),
      'actionsRaised':
          TextEditingController(text: '${r['actionsRaised'] ?? ''}'),
      'actionsClosed':
          TextEditingController(text: '${r['actionsClosed'] ?? ''}'),
      'actionsOverdue':
          TextEditingController(text: '${r['actionsOverdue'] ?? ''}'),
      'audits': TextEditingController(text: '${r['audits'] ?? ''}'),
      'auditFindings':
          TextEditingController(text: '${r['auditFindings'] ?? ''}'),
      'environmentalEvents':
          TextEditingController(text: '${r['environmentalEvents'] ?? ''}'),
      'emergencyDrills':
          TextEditingController(text: '${r['emergencyDrills'] ?? ''}'),
      'kpiSummary':
          TextEditingController(text: '${r['kpiSummary'] ?? ''}'),
      'kpiTarget':
          TextEditingController(text: '${r['kpiTarget'] ?? ''}'),
      'kpiActual':
          TextEditingController(text: '${r['kpiActual'] ?? ''}'),
      'kpiStatus':
          TextEditingController(text: '${r['kpiStatus'] ?? ''}'),
      'keyRisks':
          TextEditingController(text: '${r['keyRisks'] ?? ''}'),
      'keyActions':
          TextEditingController(text: '${r['keyActions'] ?? ''}'),
      'managementComments':
          TextEditingController(text: '${r['managementComments'] ?? ''}'),
      'evidence':
          TextEditingController(text: '${r['evidence'] ?? ''}'),
      'references':
          TextEditingController(text: '${r['references'] ?? ''}'),
      'remarks': TextEditingController(text: '${r['remarks'] ?? ''}'),
    };
    reportType = widget.reportTypes.contains(r['reportType'])
        ? r['reportType'] as String
        : widget.reportTypes.first;
    status = widget.statuses.contains(r['status'])
        ? r['status'] as String
        : widget.statuses.first;
    period = widget.periods.contains(r['period'])
        ? r['period'] as String
        : widget.periods.first;
  }

  @override
  void dispose() {
    for (final controller in c.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDate(String key) async {
    final initial = DateTime.tryParse(c[key]!.text) ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: initial,
    );
    if (picked != null) {
      c[key]!.text = picked.toIso8601String().split('T').first;
    }
  }

  Widget field(
    String key,
    String label, {
    int maxLines = 1,
    bool required = false,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: c[key],
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          border: const OutlineInputBorder(),
        ),
        validator: required
            ? (v) => v == null || v.trim().isEmpty ? 'Required' : null
            : null,
      ),
    );
  }

  Widget dateField(String key, String label) {
    return Row(
      children: [
        Expanded(child: field(key, label)),
        IconButton(
          onPressed: () => _pickDate(key),
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.94,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  'HSE Report / KPI Record',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView(
                    children: [
                      field('reportNo', 'Report No.', required: true),
                      field('title', 'Report Title', required: true),
                      DropdownButtonFormField<String>(
                        initialValue: reportType,
                        decoration: const InputDecoration(
                          labelText: 'Report Type',
                          border: OutlineInputBorder(),
                        ),
                        items: widget.reportTypes
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => reportType = v ?? reportType),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: period,
                        decoration: const InputDecoration(
                          labelText: 'Reporting Period',
                          border: OutlineInputBorder(),
                        ),
                        items: widget.periods
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) => setState(() => period = v ?? period),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: status,
                        decoration: const InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder(),
                        ),
                        items: widget.statuses
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) => setState(() => status = v ?? status),
                      ),
                      const SizedBox(height: 10),
                      field('project', 'Project'),
                      field('site', 'Site'),
                      field('location', 'Location'),
                      field('department', 'Department'),
                      dateField('reportDate', 'Report Date'),
                      dateField('periodStart', 'Period Start'),
                      dateField('periodEnd', 'Period End'),
                      dateField('submissionDue', 'Submission Due Date'),
                      field('preparedBy', 'Prepared By'),
                      field('reviewedBy', 'Reviewed By'),
                      field('approvedBy', 'Approved By'),
                      field('submittedTo', 'Submitted To / Client / Authority'),
                      field('reportSummary', 'Executive / HSE Summary', maxLines: 4),
                      field('manhours', 'Man-Hours', keyboardType: TextInputType.number),
                      field('headcount', 'Average / Total Workforce', keyboardType: TextInputType.number),
                      field('inductionCount', 'Inductions', keyboardType: TextInputType.number),
                      field('trainingCount', 'Training Sessions', keyboardType: TextInputType.number),
                      field('toolboxTalks', 'Toolbox Talks', keyboardType: TextInputType.number),
                      field('inspections', 'Inspections', keyboardType: TextInputType.number),
                      field('observations', 'Safety Observations', keyboardType: TextInputType.number),
                      field('nearMisses', 'Near Misses', keyboardType: TextInputType.number),
                      field('incidents', 'Total Incidents', keyboardType: TextInputType.number),
                      field('lostTimeInjuries', 'Lost Time Injuries', keyboardType: TextInputType.number),
                      field('firstAidCases', 'First Aid Cases', keyboardType: TextInputType.number),
                      field('medicalCases', 'Medical Treatment Cases', keyboardType: TextInputType.number),
                      field('daysLost', 'Days Lost', keyboardType: TextInputType.number),
                      field('unsafeActs', 'Unsafe Acts', keyboardType: TextInputType.number),
                      field('unsafeConditions', 'Unsafe Conditions', keyboardType: TextInputType.number),
                      field('actionsRaised', 'Actions Raised', keyboardType: TextInputType.number),
                      field('actionsClosed', 'Actions Closed', keyboardType: TextInputType.number),
                      field('actionsOverdue', 'Actions Overdue', keyboardType: TextInputType.number),
                      field('audits', 'Audits', keyboardType: TextInputType.number),
                      field('auditFindings', 'Audit Findings', keyboardType: TextInputType.number),
                      field('environmentalEvents', 'Environmental Events', keyboardType: TextInputType.number),
                      field('emergencyDrills', 'Emergency Drills', keyboardType: TextInputType.number),
                      field('kpiSummary', 'KPI Summary', maxLines: 3),
                      field('kpiTarget', 'KPI Target'),
                      field('kpiActual', 'KPI Actual'),
                      field('kpiStatus', 'KPI Status'),
                      field('keyRisks', 'Key HSE Risks / Trends', maxLines: 4),
                      field('keyActions', 'Key Actions / Priorities', maxLines: 4),
                      field('managementComments', 'Management / Client Comments', maxLines: 4),
                      field('evidence', 'Evidence / Attachment Reference', maxLines: 3),
                      field('references', 'Related Records / References', maxLines: 3),
                      field('remarks', 'Remarks', maxLines: 3),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      final result = <String, dynamic>{};
                      for (final entry in c.entries) {
                        result[entry.key] = entry.value.text.trim();
                      }
                      result['reportType'] = reportType;
                      result['period'] = period;
                      result['status'] = status;
                      Navigator.pop(context, result);
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Save Report'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailsSheet extends StatelessWidget {
  final Map<String, dynamic> record;

  const _DetailsSheet({required this.record});

  @override
  Widget build(BuildContext context) {
    final entries = record.entries
        .where((e) => e.value != null && '${e.value}'.trim().isNotEmpty)
        .toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.86,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${record['reportNo'] ?? ''} • ${record['title'] ?? ''}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${record['reportType'] ?? ''} • ${record['period'] ?? ''} • ${record['status'] ?? ''}',
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: entries.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, i) {
                    final entry = entries[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 135,
                            child: Text(
                              _label(entry.key),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(child: Text('${entry.value}')),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _label(String key) {
    return key
        .replaceAllMapped(
          RegExp(r'([a-z])([A-Z])'),
          (m) => '${m.group(1)} ${m.group(2)}',
        )
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (e) => e.isEmpty
              ? e
              : '${e[0].toUpperCase()}${e.substring(1)}',
        )
        .join(' ');
  }
}
