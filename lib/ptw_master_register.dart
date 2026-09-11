import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PtwMasterRegisterPage extends StatefulWidget {
  const PtwMasterRegisterPage({super.key});

  @override
  State<PtwMasterRegisterPage> createState() => _PtwMasterRegisterPageState();
}

class _PtwMasterRegisterPageState extends State<PtwMasterRegisterPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey = 'safenexus_hse_ptw_master_register';

  static const List<String> permitTypes = [
    'General Work Permit',
    'Hot Work Permit',
    'Confined Space Entry Permit',
    'Work at Height Permit',
    'Excavation / Trenching Permit',
    'Electrical / LOTO Permit',
    'Lifting / Critical Lift Permit',
    'Line Breaking / Breaking Containment Permit',
    'Cold Work Permit',
    'Other',
  ];

  static const List<String> statuses = [
    'Draft',
    'Requested',
    'Under Review',
    'Changes Required',
    'Approved',
    'Issued',
    'Active',
    'Suspended',
    'Extended / Revalidated',
    'Closure Pending',
    'Closed',
    'Cancelled',
  ];

  List<Map<String, dynamic>> records = [];
  String searchQuery = '';
  String statusFilter = 'All';
  String typeFilter = 'All';
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);
    if (raw != null && raw.isNotEmpty) {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        records = decoded
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
      }
    }
    if (mounted) setState(() => loading = false);
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(records));
  }

  List<Map<String, dynamic>> get filteredRecords {
    final q = searchQuery.trim().toLowerCase();
    return records.where((r) {
      final matchesStatus = statusFilter == 'All' || r['status'] == statusFilter;
      final matchesType = typeFilter == 'All' || r['permitType'] == typeFilter;
      if (!matchesStatus || !matchesType) return false;
      if (q.isEmpty) return true;
      final text = [
        r['permitNo'],
        r['project'],
        r['location'],
        r['activity'],
        r['permitType'],
        r['requester'],
        r['performingAuthority'],
      ].join(' ').toLowerCase();
      return text.contains(q);
    }).toList();
  }

  int get pendingCount => records.where((r) =>
      ['Requested', 'Under Review', 'Changes Required', 'Approved'].contains(r['status'])).length;

  int get activeCount => records.where((r) =>
      ['Issued', 'Active', 'Extended / Revalidated', 'Suspended', 'Closure Pending'].contains(r['status'])).length;

  int get overdueCount => records.where(_isOverdue).length;

  bool _isOverdue(Map<String, dynamic> r) {
    final end = DateTime.tryParse(r['workEnd']?.toString() ?? '');
    if (end == null) return false;
    final status = r['status']?.toString() ?? '';
    return end.isBefore(DateTime.now()) &&
        !['Closed', 'Cancelled'].contains(status);
  }

  Future<void> _addRecord() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _PtwFormSheet(),
    );
    if (result == null) return;
    records.insert(0, result);
    await _saveRecords();
    if (mounted) setState(() {});
  }

  Future<void> _editRecord(int index) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _PtwFormSheet(existing: records[index]),
    );
    if (result == null) return;
    records[index] = result;
    await _saveRecords();
    if (mounted) setState(() {});
  }

  Future<void> _deleteRecord(int index) async {
    final yes = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Permit Record?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (yes != true) return;
    records.removeAt(index);
    await _saveRecords();
    if (mounted) setState(() {});
  }

  void _showDetails(Map<String, dynamic> r) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _PtwDetailsSheet(record: r),
    );
  }

  void _showHistory(Map<String, dynamic> r) {
    final history = (r['history'] is List) ? List.from(r['history'] as List) : <dynamic>[];
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('History • ${r['permitNo']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              if (history.isEmpty) const Text('No history available.'),
              ...history.reversed.map((item) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.history, color: primaryGreen),
                    title: Text(item['event']?.toString() ?? 'Updated'),
                    subtitle: Text(item['date']?.toString() ?? ''),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Active':
      case 'Issued':
      case 'Approved':
      case 'Closed':
      case 'Effective':
        return primaryGreen;
      case 'Suspended':
      case 'Changes Required':
      case 'Closure Pending':
        return Colors.orange.shade800;
      case 'Cancelled':
        return Colors.red.shade700;
      default:
        return darkGreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Permit to Work (PTW)'),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadRecords,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                children: [
                  _workflowCard(),
                  const SizedBox(height: 14),
                  _dashboard(),
                  const SizedBox(height: 14),
                  _filters(),
                  const SizedBox(height: 12),
                  if (filteredRecords.isEmpty)
                    _emptyState()
                  else
                    ...filteredRecords.map((r) {
                      final index = records.indexOf(r);
                      return _permitCard(r, index);
                    }),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: _addRecord,
        icon: const Icon(Icons.add),
        label: const Text('New Permit'),
      ),
    );
  }

  Widget _workflowCard() {
    const steps = [
      'Work Identified',
      'Risk Assessment',
      'RAMS / JSA',
      'Permit Request',
      'Review',
      'Approval',
      'Issue',
      'Work',
      'Monitor',
      'Close',
    ];
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('PTW Workflow', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < steps.length; i++) ...[
                  CircleAvatar(radius: 15, backgroundColor: primaryGreen, child: Text('${i + 1}', style: const TextStyle(color: Colors.white, fontSize: 12))),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 6), child: Text(steps[i], style: const TextStyle(fontSize: 12))),
                  if (i < steps.length - 1) const Icon(Icons.arrow_forward, size: 14),
                ],
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _dashboard() {
    return Row(
      children: [
        Expanded(child: _metric('Total', records.length.toString(), Icons.assignment_outlined, primaryGreen)),
        const SizedBox(width: 8),
        Expanded(child: _metric('Pending', pendingCount.toString(), Icons.pending_actions, Colors.orange)),
        const SizedBox(width: 8),
        Expanded(child: _metric('Active', activeCount.toString(), Icons.play_circle_outline, darkGreen)),
        const SizedBox(width: 8),
        Expanded(child: _metric('Overdue', overdueCount.toString(), Icons.warning_amber_outlined, Colors.red)),
      ],
    );
  }

  Widget _metric(String label, String value, IconData icon, Color color) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        child: Column(children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
        ]),
      ),
    );
  }

  Widget _filters() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          TextField(
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search), labelText: 'Search permit, project, location, activity...', border: OutlineInputBorder()),
            onChanged: (value) => setState(() => searchQuery = value),
          ),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: _filterDropdown('Status', statusFilter, ['All', ...statuses], (v) => setState(() => statusFilter = v ?? 'All'))),
            const SizedBox(width: 10),
            Expanded(child: _filterDropdown('Permit Type', typeFilter, ['All', ...permitTypes], (v) => setState(() => typeFilter = v ?? 'All'))),
          ]),
        ]),
      ),
    );
  }

  Widget _filterDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item, overflow: TextOverflow.ellipsis))).toList(),
      onChanged: onChanged,
    );
  }

  Widget _emptyState() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(36),
        child: Column(children: [
          Icon(Icons.fact_check_outlined, size: 54, color: primaryGreen.withValues(alpha: 0.55)),
          const SizedBox(height: 12),
          const Text('No PTW records found', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          const SizedBox(height: 6),
          const Text('Create the first Permit to Work record using the button below.', textAlign: TextAlign.center),
        ]),
      ),
    );
  }

  Widget _permitCard(Map<String, dynamic> r, int index) {
    final status = r['status']?.toString() ?? 'Draft';
    final overdue = _isOverdue(r);
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () => _showDetails(r),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(child: Text(r['permitNo']?.toString() ?? '-', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(color: _statusColor(status).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
                child: Text(status, style: TextStyle(color: _statusColor(status), fontSize: 11, fontWeight: FontWeight.w700)),
              ),
            ]),
            const SizedBox(height: 8),
            Text(r['permitType']?.toString() ?? '-', style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            _infoLine(Icons.work_outline, r['activity']?.toString() ?? '-'),
            _infoLine(Icons.location_on_outlined, r['location']?.toString() ?? '-'),
            _infoLine(Icons.calendar_month_outlined, '${r['workStart'] ?? '-'} → ${r['workEnd'] ?? '-'}'),
            if (overdue) Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text('• OVERDUE: work end date has passed', style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            const Divider(height: 18),
            Row(children: [
              IconButton(tooltip: 'History', onPressed: () => _showHistory(r), icon: const Icon(Icons.history)),
              IconButton(tooltip: 'Edit', onPressed: () => _editRecord(index), icon: const Icon(Icons.edit_outlined)),
              IconButton(tooltip: 'Delete', onPressed: () => _deleteRecord(index), icon: const Icon(Icons.delete_outline, color: Colors.red)),
              const Spacer(),
              TextButton.icon(onPressed: () => _showDetails(r), icon: const Icon(Icons.visibility_outlined), label: const Text('Details')),
            ]),
          ]),
        ),
      ),
    );
  }

  Widget _infoLine(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(children: [Icon(icon, size: 17, color: darkGreen), const SizedBox(width: 7), Expanded(child: Text(text, maxLines: 2, overflow: TextOverflow.ellipsis))]),
    );
  }
}

class _PtwFormSheet extends StatefulWidget {
  const _PtwFormSheet({this.existing});

  final Map<String, dynamic>? existing;

  @override
  State<_PtwFormSheet> createState() => _PtwFormSheetState();
}

class _PtwFormSheetState extends State<_PtwFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  static const List<String> permitTypes = _PtwMasterRegisterPageState.permitTypes;
  static const List<String> statuses = _PtwMasterRegisterPageState.statuses;

  final formKey = GlobalKey<FormState>();
  final permitNo = TextEditingController();
  final project = TextEditingController();
  final location = TextEditingController();
  final department = TextEditingController();
  final activity = TextEditingController();
  final workDescription = TextEditingController();
  final riskAssessmentRef = TextEditingController();
  final jsaJhaRef = TextEditingController();
  final ramsRef = TextEditingController();
  final requester = TextEditingController();
  final performingAuthority = TextEditingController();
  final issuingAuthority = TextEditingController();
  final hseReviewer = TextEditingController();
  final permitConditions = TextEditingController();
  final requiredPpe = TextEditingController();
  final isolationLoto = TextEditingController();
  final gasTestRequirement = TextEditingController();
  final emergencyRescue = TextEditingController();
  final supportingDocuments = TextEditingController();
  final approvedBy = TextEditingController();
  final approvalComments = TextEditingController();
  final closedBy = TextEditingController();
  final remarks = TextEditingController();

  String permitType = permitTypes.first;
  String status = statuses.first;
  DateTime? workStart;
  DateTime? workEnd;
  DateTime? approvalDate;
  DateTime? issueDate;
  DateTime? suspensionDate;
  DateTime? extensionDate;
  DateTime? closureDate;
  bool gasTestRequired = false;
  bool isolationRequired = false;
  bool emergencyRescueRequired = false;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    if (e == null) {
      permitNo.text = 'PTW-${DateTime.now().millisecondsSinceEpoch}';
      return;
    }
    _load(e);
  }

  void _load(Map<String, dynamic> e) {
    permitNo.text = e['permitNo']?.toString() ?? '';
    project.text = e['project']?.toString() ?? '';
    location.text = e['location']?.toString() ?? '';
    department.text = e['department']?.toString() ?? '';
    activity.text = e['activity']?.toString() ?? '';
    workDescription.text = e['workDescription']?.toString() ?? '';
    riskAssessmentRef.text = e['riskAssessmentRef']?.toString() ?? '';
    jsaJhaRef.text = e['jsaJhaRef']?.toString() ?? '';
    ramsRef.text = e['ramsRef']?.toString() ?? '';
    requester.text = e['requester']?.toString() ?? '';
    performingAuthority.text = e['performingAuthority']?.toString() ?? '';
    issuingAuthority.text = e['issuingAuthority']?.toString() ?? '';
    hseReviewer.text = e['hseReviewer']?.toString() ?? '';
    permitConditions.text = e['permitConditions']?.toString() ?? '';
    requiredPpe.text = e['requiredPpe']?.toString() ?? '';
    isolationLoto.text = e['isolationLoto']?.toString() ?? '';
    gasTestRequirement.text = e['gasTestRequirement']?.toString() ?? '';
    emergencyRescue.text = e['emergencyRescue']?.toString() ?? '';
    supportingDocuments.text = e['supportingDocuments']?.toString() ?? '';
    approvedBy.text = e['approvedBy']?.toString() ?? '';
    approvalComments.text = e['approvalComments']?.toString() ?? '';
    closedBy.text = e['closedBy']?.toString() ?? '';
    remarks.text = e['remarks']?.toString() ?? '';
    permitType = permitTypes.contains(e['permitType']) ? e['permitType'].toString() : permitTypes.first;
    status = statuses.contains(e['status']) ? e['status'].toString() : statuses.first;
    workStart = _date(e['workStart']);
    workEnd = _date(e['workEnd']);
    approvalDate = _date(e['approvalDate']);
    issueDate = _date(e['issueDate']);
    suspensionDate = _date(e['suspensionDate']);
    extensionDate = _date(e['extensionDate']);
    closureDate = _date(e['closureDate']);
    gasTestRequired = e['gasTestRequired'] == true;
    isolationRequired = e['isolationRequired'] == true;
    emergencyRescueRequired = e['emergencyRescueRequired'] == true;
  }

  DateTime? _date(dynamic value) => value == null ? null : DateTime.tryParse(value.toString());

  @override
  void dispose() {
    for (final c in [
      permitNo, project, location, department, activity, workDescription,
      riskAssessmentRef, jsaJhaRef, ramsRef, requester, performingAuthority,
      issuingAuthority, hseReviewer, permitConditions, requiredPpe, isolationLoto,
      gasTestRequirement, emergencyRescue, supportingDocuments, approvedBy,
      approvalComments, closedBy, remarks,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDate(String title, DateTime? current, ValueChanged<DateTime> onSelected) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: current ?? DateTime.now(),
      helpText: title,
    );
    if (picked != null) onSelected(picked);
  }

  String _dateText(DateTime? d) => d == null ? 'Not selected' : '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  String? _required(String? value) => value == null || value.trim().isEmpty ? 'Required' : null;

  String? _validate() {
    if (!formKey.currentState!.validate()) return 'Please complete the required fields.';
    if (riskAssessmentRef.text.trim().isEmpty) return 'Risk Assessment Reference is required.';
    if (workStart == null || workEnd == null) return 'Work Start and Work End dates are required.';
    if (!workEnd!.isAfter(workStart!)) return 'Work End must be after Work Start.';
    if (['Under Review', 'Approved', 'Issued', 'Active'].contains(status) && hseReviewer.text.trim().isEmpty) return 'HSE Reviewer is required for this status.';
    if (['Approved', 'Issued', 'Active'].contains(status)) {
      if (approvedBy.text.trim().isEmpty) return 'Approved By is required.';
      if (approvalDate == null) return 'Approval Date is required.';
    }
    if (['Issued', 'Active', 'Extended / Revalidated', 'Closure Pending'].contains(status) && issueDate == null) return 'Issue Date is required.';
    if (status == 'Suspended' && suspensionDate == null) return 'Suspension Date is required.';
    if (status == 'Extended / Revalidated' && extensionDate == null) return 'Extension / Revalidation Date is required.';
    if (status == 'Closed' && (closedBy.text.trim().isEmpty || closureDate == null)) return 'Closed By and Closure Date are required.';
    if (gasTestRequired && gasTestRequirement.text.trim().isEmpty) return 'Gas Test requirement/details are required.';
    if (isolationRequired && isolationLoto.text.trim().isEmpty) return 'Isolation / LOTO details are required.';
    if (emergencyRescueRequired && emergencyRescue.text.trim().isEmpty) return 'Emergency / Rescue requirements are required.';
    return null;
  }

  void _submit() {
    final error = _validate();
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    final now = DateTime.now().toIso8601String();
    final created = widget.existing?['createdAt']?.toString() ?? now;
    final oldHistory = widget.existing?['history'];
    final history = oldHistory is List
        ? oldHistory.map((item) => Map<String, dynamic>.from(item as Map)).toList()
        : <Map<String, dynamic>>[];
    history.add({
      'event': widget.existing == null ? 'Created' : 'Updated',
      'date': now,
    });

    final record = <String, dynamic>{
      'id': widget.existing?['id']?.toString() ?? DateTime.now().microsecondsSinceEpoch.toString(),
      'permitNo': permitNo.text.trim(),
      'project': project.text.trim(),
      'location': location.text.trim(),
      'department': department.text.trim(),
      'activity': activity.text.trim(),
      'workDescription': workDescription.text.trim(),
      'permitType': permitType,
      'riskAssessmentRef': riskAssessmentRef.text.trim(),
      'jsaJhaRef': jsaJhaRef.text.trim(),
      'ramsRef': ramsRef.text.trim(),
      'requester': requester.text.trim(),
      'performingAuthority': performingAuthority.text.trim(),
      'issuingAuthority': issuingAuthority.text.trim(),
      'hseReviewer': hseReviewer.text.trim(),
      'workStart': workStart?.toIso8601String(),
      'workEnd': workEnd?.toIso8601String(),
      'permitConditions': permitConditions.text.trim(),
      'requiredPpe': requiredPpe.text.trim(),
      'isolationRequired': isolationRequired,
      'isolationLoto': isolationLoto.text.trim(),
      'gasTestRequired': gasTestRequired,
      'gasTestRequirement': gasTestRequirement.text.trim(),
      'emergencyRescueRequired': emergencyRescueRequired,
      'emergencyRescue': emergencyRescue.text.trim(),
      'supportingDocuments': supportingDocuments.text.trim(),
      'approvedBy': approvedBy.text.trim(),
      'approvalDate': approvalDate?.toIso8601String(),
      'approvalComments': approvalComments.text.trim(),
      'issueDate': issueDate?.toIso8601String(),
      'suspensionDate': suspensionDate?.toIso8601String(),
      'extensionDate': extensionDate?.toIso8601String(),
      'closureDate': closureDate?.toIso8601String(),
      'closedBy': closedBy.text.trim(),
      'status': status,
      'remarks': remarks.text.trim(),
      'createdAt': created,
      'updatedAt': now,
      'history': history,
    };
    Navigator.pop(context, record);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    return Container(
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 10, 16, bottom + 20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(child: Container(width: 45, height: 5, decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(10)))),
              const SizedBox(height: 12),
              Text(widget.existing == null ? 'New PTW Master Record' : 'Edit PTW Master Record', style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: darkGreen)),
              const SizedBox(height: 16),
              _section('1. Permit Identification', Icons.assignment_outlined),
              _field(permitNo, 'Permit No.', required: true),
              _dropdown('Permit Type', permitType, permitTypes, (v) => setState(() => permitType = v!)),
              _dropdown('Status', status, statuses, (v) => setState(() => status = v!)),
              _field(project, 'Project', required: true),
              _field(location, 'Location / Area', required: true),
              _field(department, 'Department'),
              _field(activity, 'Work Activity', required: true),
              _field(workDescription, 'Work Description', maxLines: 3),
              _section('2. Risk & Planning References', Icons.warning_amber_outlined),
              _field(riskAssessmentRef, 'Risk Assessment / HIRA Reference', required: true),
              _field(jsaJhaRef, 'JSA / JHA Reference'),
              _field(ramsRef, 'RAMS / Method Statement Reference'),
              _section('3. Permit Authorities', Icons.groups_outlined),
              _field(requester, 'Permit Requester', required: true),
              _field(performingAuthority, 'Performing Authority', required: true),
              _field(issuingAuthority, 'Issuing Authority', required: true),
              _field(hseReviewer, 'HSE Reviewer'),
              _section('4. Work Schedule', Icons.schedule_outlined),
              _dateButton('Work Start Date', workStart, (d) => setState(() => workStart = d)),
              _dateButton('Work End Date', workEnd, (d) => setState(() => workEnd = d)),
              _section('5. Permit Conditions & Controls', Icons.shield_outlined),
              _field(permitConditions, 'Permit Conditions / Precautions', maxLines: 4),
              _field(requiredPpe, 'Required PPE', maxLines: 3),
              SwitchListTile.adaptive(contentPadding: EdgeInsets.zero, title: const Text('Isolation / LOTO Required'), value: isolationRequired, activeThumbColor: primaryGreen, onChanged: (v) => setState(() => isolationRequired = v)),
              if (isolationRequired) _field(isolationLoto, 'Isolation / LOTO Details', maxLines: 3),
              SwitchListTile.adaptive(contentPadding: EdgeInsets.zero, title: const Text('Gas Test Required'), value: gasTestRequired, activeThumbColor: primaryGreen, onChanged: (v) => setState(() => gasTestRequired = v)),
              if (gasTestRequired) _field(gasTestRequirement, 'Gas Test Requirement / Details', maxLines: 3),
              SwitchListTile.adaptive(contentPadding: EdgeInsets.zero, title: const Text('Emergency / Rescue Requirements'), value: emergencyRescueRequired, activeThumbColor: primaryGreen, onChanged: (v) => setState(() => emergencyRescueRequired = v)),
              if (emergencyRescueRequired) _field(emergencyRescue, 'Emergency / Rescue Requirements', maxLines: 3),
              _field(supportingDocuments, 'Supporting Documents / Attachments', maxLines: 3),
              _section('6. Approval & Issue', Icons.verified_outlined),
              _field(approvedBy, 'Approved By'),
              _dateButton('Approval Date', approvalDate, (d) => setState(() => approvalDate = d)),
              _field(approvalComments, 'Approval Comments', maxLines: 3),
              _dateButton('Issue Date', issueDate, (d) => setState(() => issueDate = d)),
              _section('7. Suspension / Extension / Closure', Icons.update_outlined),
              _dateButton('Suspension Date', suspensionDate, (d) => setState(() => suspensionDate = d)),
              _dateButton('Extension / Revalidation Date', extensionDate, (d) => setState(() => extensionDate = d)),
              _field(closedBy, 'Closed By'),
              _dateButton('Closure Date', closureDate, (d) => setState(() => closureDate = d)),
              _field(remarks, 'Remarks', maxLines: 3),
              const SizedBox(height: 20),
              SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: _submit, icon: const Icon(Icons.save_outlined), label: const Text('Save PTW Record'), style: FilledButton.styleFrom(backgroundColor: primaryGreen, padding: const EdgeInsets.symmetric(vertical: 15)))),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _section(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 10),
      child: Row(children: [Icon(icon, color: primaryGreen), const SizedBox(width: 8), Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkGreen)))]),
    );
  }

  Widget _field(TextEditingController controller, String label, {bool required = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(controller: controller, maxLines: maxLines, validator: required ? _required : null, decoration: InputDecoration(labelText: label, border: const OutlineInputBorder(), alignLabelWithHint: maxLines > 1)),
    );
  }

  Widget _dropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(initialValue: value, isExpanded: true, decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()), items: items.map((item) => DropdownMenuItem(value: item, child: Text(item, overflow: TextOverflow.ellipsis))).toList(), onChanged: onChanged),
    );
  }

  Widget _dateButton(String label, DateTime? date, ValueChanged<DateTime> onSelected) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () => _pickDate(label, date, onSelected),
        borderRadius: BorderRadius.circular(4),
        child: InputDecorator(
          decoration: InputDecoration(labelText: label, border: const OutlineInputBorder(), suffixIcon: const Icon(Icons.calendar_month_outlined)),
          child: Text(_dateText(date)),
        ),
      ),
    );
  }
}

class _PtwDetailsSheet extends StatelessWidget {
  const _PtwDetailsSheet({required this.record});

  final Map<String, dynamic> record;
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  String _display(dynamic value) {
    if (value == null || value.toString().isEmpty) return '-';
    final parsed = DateTime.tryParse(value.toString());
    if (parsed != null && value.toString().contains('T')) {
      return '${parsed.year.toString().padLeft(4, '0')}-${parsed.month.toString().padLeft(2, '0')}-${parsed.day.toString().padLeft(2, '0')}';
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    final sections = <String, List<List<String>>>{
      'Permit Identification': [
        ['Permit No.', _display(record['permitNo'])],
        ['Permit Type', _display(record['permitType'])],
        ['Status', _display(record['status'])],
        ['Project', _display(record['project'])],
        ['Location', _display(record['location'])],
        ['Department', _display(record['department'])],
        ['Work Activity', _display(record['activity'])],
        ['Work Description', _display(record['workDescription'])],
      ],
      'Risk & Planning': [
        ['Risk Assessment', _display(record['riskAssessmentRef'])],
        ['JSA / JHA', _display(record['jsaJhaRef'])],
        ['RAMS', _display(record['ramsRef'])],
      ],
      'Authorities': [
        ['Requester', _display(record['requester'])],
        ['Performing Authority', _display(record['performingAuthority'])],
        ['Issuing Authority', _display(record['issuingAuthority'])],
        ['HSE Reviewer', _display(record['hseReviewer'])],
      ],
      'Schedule': [
        ['Work Start', _display(record['workStart'])],
        ['Work End', _display(record['workEnd'])],
      ],
      'Controls': [
        ['Permit Conditions', _display(record['permitConditions'])],
        ['Required PPE', _display(record['requiredPpe'])],
        ['Isolation / LOTO', '${record['isolationRequired'] == true ? 'Required' : 'Not Required'} • ${_display(record['isolationLoto'])}'],
        ['Gas Test', '${record['gasTestRequired'] == true ? 'Required' : 'Not Required'} • ${_display(record['gasTestRequirement'])}'],
        ['Emergency / Rescue', '${record['emergencyRescueRequired'] == true ? 'Required' : 'Not Required'} • ${_display(record['emergencyRescue'])}'],
        ['Supporting Documents', _display(record['supportingDocuments'])],
      ],
      'Approval & Closure': [
        ['Approved By', _display(record['approvedBy'])],
        ['Approval Date', _display(record['approvalDate'])],
        ['Approval Comments', _display(record['approvalComments'])],
        ['Issue Date', _display(record['issueDate'])],
        ['Suspension Date', _display(record['suspensionDate'])],
        ['Extension / Revalidation', _display(record['extensionDate'])],
        ['Closed By', _display(record['closedBy'])],
        ['Closure Date', _display(record['closureDate'])],
        ['Remarks', _display(record['remarks'])],
      ],
    };

    return Scaffold(
      appBar: AppBar(title: Text('PTW • ${record['permitNo'] ?? '-'}'), backgroundColor: primaryGreen, foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: sections.entries.map((section) => Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(section.key, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: darkGreen)),
              const Divider(),
              ...section.value.map((row) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      SizedBox(width: 145, child: Text(row[0], style: const TextStyle(fontWeight: FontWeight.w600))),
                      Expanded(child: Text(row[1])),
                    ]),
                  )),
            ]),
          ),
        )).toList(),
      ),
    );
  }
}
