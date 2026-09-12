import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkforceMasterRegisterPage extends StatefulWidget {
  const WorkforceMasterRegisterPage({super.key});

  @override
  State<WorkforceMasterRegisterPage> createState() =>
      _WorkforceMasterRegisterPageState();
}

class _WorkforceMasterRegisterPageState
    extends State<WorkforceMasterRegisterPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_workforce_master_register';

  final List<WorkforceRecord> _records = [];

  String _search = '';
  String _statusFilter = 'All';
  String _employmentFilter = 'All';
  String _categoryFilter = 'All';

  final List<String> _statuses = const [
    'Active',
    'Pending Induction',
    'Training Required',
    'Competency Review',
    'Medical Clearance Required',
    'Suspended',
    'Inactive',
    'Demobilized',
  ];

  final List<String> _employmentTypes = const [
    'Direct Employee',
    'Subcontractor',
    'Agency / Manpower',
    'Temporary Worker',
    'Visitor / Short-Term',
    'Intern / Trainee',
    'Other',
  ];

  final List<String> _workerCategories = const [
    'Management',
    'HSE',
    'Supervisor',
    'Engineer',
    'Skilled Worker',
    'Semi-Skilled Worker',
    'Unskilled Worker',
    'Operator',
    'Driver',
    'Technician',
    'Security',
    'First Aider',
    'Fire Warden',
    'Other',
  ];

  final List<String> _genders = const [
    'Male',
    'Female',
    'Other',
    'Not Specified',
  ];

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(storageKey) ?? [];
    final loaded = <WorkforceRecord>[];

    for (final item in raw) {
      try {
        loaded.add(
          WorkforceRecord.fromJson(
            jsonDecode(item) as Map<String, dynamic>,
          ),
        );
      } catch (_) {
        // Ignore malformed legacy records.
      }
    }

    if (!mounted) return;

    setState(() {
      _records
        ..clear()
        ..addAll(loaded);
    });
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      storageKey,
      _records.map((record) => jsonEncode(record.toJson())).toList(),
    );
  }

  List<WorkforceRecord> get _filteredRecords {
    final query = _search.trim().toLowerCase();

    final filtered = _records.where((record) {
      final searchable = [
        record.workerNo,
        record.employeeId,
        record.fullName,
        record.jobTitle,
        record.trade,
        record.department,
        record.company,
        record.projectName,
        record.siteName,
        record.nationality,
        record.contactNumber,
        record.employmentType,
        record.workerCategory,
        record.status,
        record.supervisor,
      ].join(' ').toLowerCase();

      final matchesSearch =
          query.isEmpty || searchable.contains(query);
      final matchesStatus =
          _statusFilter == 'All' || record.status == _statusFilter;
      final matchesEmployment = _employmentFilter == 'All' ||
          record.employmentType == _employmentFilter;
      final matchesCategory = _categoryFilter == 'All' ||
          record.workerCategory == _categoryFilter;

      return matchesSearch &&
          matchesStatus &&
          matchesEmployment &&
          matchesCategory;
    }).toList();

    filtered.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return filtered;
  }

  int _countStatus(String status) =>
      _records.where((record) => record.status == status).length;

  int get _activeCount => _countStatus('Active');

  int get _pendingCount =>
      _countStatus('Pending Induction') +
      _countStatus('Training Required') +
      _countStatus('Medical Clearance Required');

  int get _suspendedCount => _countStatus('Suspended');

  int get _expiringSoonCount =>
      _records.where((record) => record.hasExpiryWithin(30)).length;

  int get _overdueCount => _records.where((record) => record.isOverdue).length;

  Color _statusColor(String status) {
    switch (status) {
      case 'Active':
        return primaryGreen;
      case 'Pending Induction':
      case 'Training Required':
      case 'Competency Review':
        return Colors.orange;
      case 'Medical Clearance Required':
        return Colors.deepOrange;
      case 'Suspended':
        return Colors.red;
      case 'Inactive':
      case 'Demobilized':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  Future<void> _openForm([WorkforceRecord? existing]) async {
    final result = await showModalBottomSheet<WorkforceRecord>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _WorkforceFormSheet(
        existing: existing,
        statuses: _statuses,
        employmentTypes: _employmentTypes,
        workerCategories: _workerCategories,
        genders: _genders,
      ),
    );

    if (result == null) return;

    setState(() {
      final index =
          _records.indexWhere((record) => record.id == result.id);

      if (index >= 0) {
        _records[index] = result;
      } else {
        _records.add(result);
      }
    });

    await _saveRecords();
  }

  Future<void> _deleteRecord(WorkforceRecord record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete workforce record?'),
        content: Text(
          'Delete ${record.fullName.isEmpty ? record.workerNo : record.fullName}? '
          'This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
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

  void _showDetails(WorkforceRecord record) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _WorkforceDetailsSheet(record: record),
    );
  }

  @override
  Widget build(BuildContext context) {
    final records = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('6A Workforce Master Register'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _openForm(),
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Add Worker'),
      ),
      body: RefreshIndicator(
        onRefresh: _loadRecords,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildDashboard(),
            const SizedBox(height: 12),
            _buildFilters(),
            const SizedBox(height: 12),
            if (records.isEmpty)
              _buildEmptyState()
            else
              ...records.map(_buildRecordCard),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: primaryGreen.withValues(alpha: 0.12),
              child: const Icon(
                Icons.groups_outlined,
                color: primaryGreen,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Workforce Master Register',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Central workforce register for worker identity, '
                    'deployment, company, role and HSE readiness tracking.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboard() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.8,
      children: [
        _metric(
          'Total Workforce',
          '${_records.length}',
          Icons.groups_outlined,
        ),
        _metric(
          'Active',
          '$_activeCount',
          Icons.check_circle_outline,
        ),
        _metric(
          'Pending HSE',
          '$_pendingCount',
          Icons.pending_actions_outlined,
          alert: _pendingCount > 0,
        ),
        _metric(
          'Suspended',
          '$_suspendedCount',
          Icons.block_outlined,
          alert: _suspendedCount > 0,
        ),
        _metric(
          'Expiry ≤ 30 Days',
          '$_expiringSoonCount',
          Icons.event_available_outlined,
          alert: _expiringSoonCount > 0,
        ),
        _metric(
          'Overdue',
          '$_overdueCount',
          Icons.schedule_outlined,
          alert: _overdueCount > 0,
        ),
      ],
    );
  }

  Widget _metric(
    String title,
    String value,
    IconData icon, {
    bool alert = false,
  }) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(
              icon,
              color: alert ? Colors.red : primaryGreen,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 3),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: alert ? Colors.red : darkGreen,
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

  Widget _buildFilters() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => setState(() => _search = value),
              decoration: InputDecoration(
                labelText: 'Search workforce',
                hintText:
                    'Name, ID, company, trade, role, project...',
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
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
              items: ['All', ..._statuses]
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              onChanged: (value) =>
                  setState(() => _statusFilter = value ?? 'All'),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _employmentFilter,
                    decoration: const InputDecoration(
                      labelText: 'Employment',
                      border: OutlineInputBorder(),
                    ),
                    items: ['All', ..._employmentTypes]
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ),
                        )
                        .toList(),
                    onChanged: (value) => setState(
                      () => _employmentFilter = value ?? 'All',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _categoryFilter,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    items: ['All', ..._workerCategories]
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ),
                        )
                        .toList(),
                    onChanged: (value) => setState(
                      () => _categoryFilter = value ?? 'All',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Icon(
              Icons.groups_outlined,
              size: 52,
              color: Colors.grey,
            ),
            const SizedBox(height: 12),
            const Text(
              'No workforce records found',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Add workers to start the Workforce Master Register.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => _openForm(),
              icon: const Icon(Icons.person_add_alt_1),
              label: const Text('Add Worker'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordCard(WorkforceRecord record) {
    final statusColor = _statusColor(record.status);

    return Card(
      elevation: 0,
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
                children: [
                  CircleAvatar(
                    backgroundColor:
                        primaryGreen.withValues(alpha: 0.10),
                    child: const Icon(
                      Icons.person_outline,
                      color: primaryGreen,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          record.fullName.isEmpty
                              ? 'Unnamed Worker'
                              : record.fullName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          record.employeeId.isEmpty
                              ? record.workerNo
                              : '${record.workerNo} • ${record.employeeId}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') _openForm(record);
                      if (value == 'delete') _deleteRecord(record);
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
                ],
              ),
              const SizedBox(height: 10),
              if (record.jobTitle.isNotEmpty)
                Text(
                  record.jobTitle,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              if (record.trade.isNotEmpty) Text(record.trade),
              if (record.company.isNotEmpty)
                Text('Company: ${record.company}'),
              if (record.projectName.isNotEmpty)
                Text('Project: ${record.projectName}'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _chip(record.workerCategory, Colors.blue),
                  _chip(record.employmentType, Colors.indigo),
                  _chip(record.status, statusColor),
                  if (record.isOverdue)
                    _chip('• OVERDUE', Colors.red),
                  if (record.hasExpiryWithin(30))
                    _chip('EXPIRY ≤ 30D', Colors.orange),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Joining: ${_formatDate(record.joiningDate)}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  Text(
                    'Updated ${_formatDateTime(record.updatedAt)}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
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

  Widget _chip(String label, Color color) {
    if (label.trim().isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatDate(DateTime? value) {
    if (value == null) return '-';
    return '${value.day.toString().padLeft(2, '0')}/'
        '${value.month.toString().padLeft(2, '0')}/${value.year}';
  }

  String _formatDateTime(DateTime value) {
    return '${value.day.toString().padLeft(2, '0')}/'
        '${value.month.toString().padLeft(2, '0')}/${value.year} '
        '${value.hour.toString().padLeft(2, '0')}:'
        '${value.minute.toString().padLeft(2, '0')}';
  }
}

class WorkforceRecord {
  final String id;
  final String workerNo;
  final String employeeId;
  final String fullName;
  final String gender;
  final String nationality;
  final String dateOfBirth;
  final String contactNumber;
  final String emergencyContact;
  final String emergencyContactNumber;

  final String company;
  final String projectName;
  final String siteName;
  final String department;
  final String jobTitle;
  final String trade;
  final String workerCategory;
  final String employmentType;
  final String supervisor;

  final DateTime? joiningDate;
  final DateTime? mobilizationDate;
  final DateTime? demobilizationDate;

  final String accommodation;
  final String campLocation;
  final String IDCardNumber;
  final DateTime? IDCardExpiry;

  final String passportNumber;
  final DateTime? passportExpiry;
  final String visaNumber;
  final DateTime? visaExpiry;
  final String workPermitNumber;
  final DateTime? workPermitExpiry;

  final String inductionStatus;
  final DateTime? inductionDate;
  final DateTime? inductionExpiry;

  final String medicalStatus;
  final DateTime? medicalDate;
  final DateTime? medicalExpiry;

  final String competencyStatus;
  final String authorizationStatus;

  final String PPEStatus;
  final String deploymentStatus;
  final String status;

  final String remarks;
  final String supportingDocuments;

  final DateTime createdAt;
  final DateTime updatedAt;

  const WorkforceRecord({
    required this.id,
    required this.workerNo,
    required this.employeeId,
    required this.fullName,
    required this.gender,
    required this.nationality,
    required this.dateOfBirth,
    required this.contactNumber,
    required this.emergencyContact,
    required this.emergencyContactNumber,
    required this.company,
    required this.projectName,
    required this.siteName,
    required this.department,
    required this.jobTitle,
    required this.trade,
    required this.workerCategory,
    required this.employmentType,
    required this.supervisor,
    required this.joiningDate,
    required this.mobilizationDate,
    required this.demobilizationDate,
    required this.accommodation,
    required this.campLocation,
    required this.IDCardNumber,
    required this.IDCardExpiry,
    required this.passportNumber,
    required this.passportExpiry,
    required this.visaNumber,
    required this.visaExpiry,
    required this.workPermitNumber,
    required this.workPermitExpiry,
    required this.inductionStatus,
    required this.inductionDate,
    required this.inductionExpiry,
    required this.medicalStatus,
    required this.medicalDate,
    required this.medicalExpiry,
    required this.competencyStatus,
    required this.authorizationStatus,
    required this.PPEStatus,
    required this.deploymentStatus,
    required this.status,
    required this.remarks,
    required this.supportingDocuments,
    required this.createdAt,
    required this.updatedAt,
  });

  List<DateTime> get _expiryDates => [
        if (IDCardExpiry != null) IDCardExpiry!,
        if (passportExpiry != null) passportExpiry!,
        if (visaExpiry != null) visaExpiry!,
        if (workPermitExpiry != null) workPermitExpiry!,
        if (inductionExpiry != null) inductionExpiry!,
        if (medicalExpiry != null) medicalExpiry!,
      ];

  bool hasExpiryWithin(int days) {
    if (_expiryDates.isEmpty) return false;
    final today = _dateOnly(DateTime.now());
    final limit = today.add(Duration(days: days));

    return _expiryDates.any((date) {
      final expiry = _dateOnly(date);
      return !expiry.isBefore(today) && !expiry.isAfter(limit);
    });
  }

  bool get isOverdue {
    if (status == 'Inactive' || status == 'Demobilized') return false;

    final today = _dateOnly(DateTime.now());

    final expired = _expiryDates.any(
      (date) => _dateOnly(date).isBefore(today),
    );

    return expired;
  }

  static DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workerNo': workerNo,
      'employeeId': employeeId,
      'fullName': fullName,
      'gender': gender,
      'nationality': nationality,
      'dateOfBirth': dateOfBirth,
      'contactNumber': contactNumber,
      'emergencyContact': emergencyContact,
      'emergencyContactNumber': emergencyContactNumber,
      'company': company,
      'projectName': projectName,
      'siteName': siteName,
      'department': department,
      'jobTitle': jobTitle,
      'trade': trade,
      'workerCategory': workerCategory,
      'employmentType': employmentType,
      'supervisor': supervisor,
      'joiningDate': joiningDate?.toIso8601String(),
      'mobilizationDate': mobilizationDate?.toIso8601String(),
      'demobilizationDate': demobilizationDate?.toIso8601String(),
      'accommodation': accommodation,
      'campLocation': campLocation,
      'IDCardNumber': IDCardNumber,
      'IDCardExpiry': IDCardExpiry?.toIso8601String(),
      'passportNumber': passportNumber,
      'passportExpiry': passportExpiry?.toIso8601String(),
      'visaNumber': visaNumber,
      'visaExpiry': visaExpiry?.toIso8601String(),
      'workPermitNumber': workPermitNumber,
      'workPermitExpiry': workPermitExpiry?.toIso8601String(),
      'inductionStatus': inductionStatus,
      'inductionDate': inductionDate?.toIso8601String(),
      'inductionExpiry': inductionExpiry?.toIso8601String(),
      'medicalStatus': medicalStatus,
      'medicalDate': medicalDate?.toIso8601String(),
      'medicalExpiry': medicalExpiry?.toIso8601String(),
      'competencyStatus': competencyStatus,
      'authorizationStatus': authorizationStatus,
      'PPEStatus': PPEStatus,
      'deploymentStatus': deploymentStatus,
      'status': status,
      'remarks': remarks,
      'supportingDocuments': supportingDocuments,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory WorkforceRecord.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic value) {
      if (value == null || value.toString().isEmpty) return null;
      return DateTime.tryParse(value.toString());
    }

    return WorkforceRecord(
      id: json['id']?.toString() ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      workerNo: json['workerNo']?.toString() ?? '',
      employeeId: json['employeeId']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? '',
      gender: json['gender']?.toString() ?? 'Not Specified',
      nationality: json['nationality']?.toString() ?? '',
      dateOfBirth: json['dateOfBirth']?.toString() ?? '',
      contactNumber: json['contactNumber']?.toString() ?? '',
      emergencyContact: json['emergencyContact']?.toString() ?? '',
      emergencyContactNumber:
          json['emergencyContactNumber']?.toString() ?? '',
      company: json['company']?.toString() ?? '',
      projectName: json['projectName']?.toString() ?? '',
      siteName: json['siteName']?.toString() ?? '',
      department: json['department']?.toString() ?? '',
      jobTitle: json['jobTitle']?.toString() ?? '',
      trade: json['trade']?.toString() ?? '',
      workerCategory: json['workerCategory']?.toString() ??
          'Unskilled Worker',
      employmentType:
          json['employmentType']?.toString() ?? 'Direct Employee',
      supervisor: json['supervisor']?.toString() ?? '',
      joiningDate: parseDate(json['joiningDate']),
      mobilizationDate: parseDate(json['mobilizationDate']),
      demobilizationDate: parseDate(json['demobilizationDate']),
      accommodation: json['accommodation']?.toString() ?? '',
      campLocation: json['campLocation']?.toString() ?? '',
      IDCardNumber: json['IDCardNumber']?.toString() ?? '',
      IDCardExpiry: parseDate(json['IDCardExpiry']),
      passportNumber: json['passportNumber']?.toString() ?? '',
      passportExpiry: parseDate(json['passportExpiry']),
      visaNumber: json['visaNumber']?.toString() ?? '',
      visaExpiry: parseDate(json['visaExpiry']),
      workPermitNumber: json['workPermitNumber']?.toString() ?? '',
      workPermitExpiry: parseDate(json['workPermitExpiry']),
      inductionStatus:
          json['inductionStatus']?.toString() ?? 'Not Started',
      inductionDate: parseDate(json['inductionDate']),
      inductionExpiry: parseDate(json['inductionExpiry']),
      medicalStatus:
          json['medicalStatus']?.toString() ?? 'Not Verified',
      medicalDate: parseDate(json['medicalDate']),
      medicalExpiry: parseDate(json['medicalExpiry']),
      competencyStatus:
          json['competencyStatus']?.toString() ?? 'Not Assessed',
      authorizationStatus:
          json['authorizationStatus']?.toString() ?? 'Not Authorized',
      PPEStatus: json['PPEStatus']?.toString() ?? 'Not Issued',
      deploymentStatus:
          json['deploymentStatus']?.toString() ?? 'Not Cleared',
      status: json['status']?.toString() ?? 'Active',
      remarks: json['remarks']?.toString() ?? '',
      supportingDocuments:
          json['supportingDocuments']?.toString() ?? '',
      createdAt: parseDate(json['createdAt']) ?? DateTime.now(),
      updatedAt: parseDate(json['updatedAt']) ?? DateTime.now(),
    );
  }
}

class _WorkforceFormSheet extends StatefulWidget {
  final WorkforceRecord? existing;
  final List<String> statuses;
  final List<String> employmentTypes;
  final List<String> workerCategories;
  final List<String> genders;

  const _WorkforceFormSheet({
    required this.existing,
    required this.statuses,
    required this.employmentTypes,
    required this.workerCategories,
    required this.genders,
  });

  @override
  State<_WorkforceFormSheet> createState() => _WorkforceFormSheetState();
}

class _WorkforceFormSheetState extends State<_WorkforceFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController workerNo;
  late final TextEditingController employeeId;
  late final TextEditingController fullName;
  late final TextEditingController nationality;
  late final TextEditingController dateOfBirth;
  late final TextEditingController contactNumber;
  late final TextEditingController emergencyContact;
  late final TextEditingController emergencyContactNumber;
  late final TextEditingController company;
  late final TextEditingController projectName;
  late final TextEditingController siteName;
  late final TextEditingController department;
  late final TextEditingController jobTitle;
  late final TextEditingController trade;
  late final TextEditingController supervisor;
  late final TextEditingController accommodation;
  late final TextEditingController campLocation;
  late final TextEditingController IDCardNumber;
  late final TextEditingController passportNumber;
  late final TextEditingController visaNumber;
  late final TextEditingController workPermitNumber;
  late final TextEditingController inductionStatus;
  late final TextEditingController medicalStatus;
  late final TextEditingController competencyStatus;
  late final TextEditingController authorizationStatus;
  late final TextEditingController PPEStatus;
  late final TextEditingController deploymentStatus;
  late final TextEditingController remarks;
  late final TextEditingController supportingDocuments;

  String gender = 'Not Specified';
  String employmentType = 'Direct Employee';
  String workerCategory = 'Unskilled Worker';
  String status = 'Active';

  DateTime? joiningDate;
  DateTime? mobilizationDate;
  DateTime? demobilizationDate;
  DateTime? IDCardExpiry;
  DateTime? passportExpiry;
  DateTime? visaExpiry;
  DateTime? workPermitExpiry;
  DateTime? inductionDate;
  DateTime? inductionExpiry;
  DateTime? medicalDate;
  DateTime? medicalExpiry;

  @override
  void initState() {
    super.initState();

    final r = widget.existing;

    workerNo = _controller(r?.workerNo ?? '');
    employeeId = _controller(r?.employeeId ?? '');
    fullName = _controller(r?.fullName ?? '');
    nationality = _controller(r?.nationality ?? '');
    dateOfBirth = _controller(r?.dateOfBirth ?? '');
    contactNumber = _controller(r?.contactNumber ?? '');
    emergencyContact = _controller(r?.emergencyContact ?? '');
    emergencyContactNumber =
        _controller(r?.emergencyContactNumber ?? '');
    company = _controller(r?.company ?? '');
    projectName = _controller(r?.projectName ?? '');
    siteName = _controller(r?.siteName ?? '');
    department = _controller(r?.department ?? '');
    jobTitle = _controller(r?.jobTitle ?? '');
    trade = _controller(r?.trade ?? '');
    supervisor = _controller(r?.supervisor ?? '');
    accommodation = _controller(r?.accommodation ?? '');
    campLocation = _controller(r?.campLocation ?? '');
    IDCardNumber = _controller(r?.IDCardNumber ?? '');
    passportNumber = _controller(r?.passportNumber ?? '');
    visaNumber = _controller(r?.visaNumber ?? '');
    workPermitNumber = _controller(r?.workPermitNumber ?? '');
    inductionStatus =
        _controller(r?.inductionStatus ?? 'Not Started');
    medicalStatus =
        _controller(r?.medicalStatus ?? 'Not Verified');
    competencyStatus =
        _controller(r?.competencyStatus ?? 'Not Assessed');
    authorizationStatus =
        _controller(r?.authorizationStatus ?? 'Not Authorized');
    PPEStatus = _controller(r?.PPEStatus ?? 'Not Issued');
    deploymentStatus =
        _controller(r?.deploymentStatus ?? 'Not Cleared');
    remarks = _controller(r?.remarks ?? '');
    supportingDocuments =
        _controller(r?.supportingDocuments ?? '');

    gender = r?.gender ?? 'Not Specified';
    employmentType =
        r?.employmentType ?? 'Direct Employee';
    workerCategory =
        r?.workerCategory ?? 'Unskilled Worker';
    status = r?.status ?? 'Active';

    joiningDate = r?.joiningDate;
    mobilizationDate = r?.mobilizationDate;
    demobilizationDate = r?.demobilizationDate;
    IDCardExpiry = r?.IDCardExpiry;
    passportExpiry = r?.passportExpiry;
    visaExpiry = r?.visaExpiry;
    workPermitExpiry = r?.workPermitExpiry;
    inductionDate = r?.inductionDate;
    inductionExpiry = r?.inductionExpiry;
    medicalDate = r?.medicalDate;
    medicalExpiry = r?.medicalExpiry;
  }

  TextEditingController _controller(String value) =>
      TextEditingController(text: value);

  @override
  void dispose() {
    for (final controller in [
      workerNo,
      employeeId,
      fullName,
      nationality,
      dateOfBirth,
      contactNumber,
      emergencyContact,
      emergencyContactNumber,
      company,
      projectName,
      siteName,
      department,
      jobTitle,
      trade,
      supervisor,
      accommodation,
      campLocation,
      IDCardNumber,
      passportNumber,
      visaNumber,
      workPermitNumber,
      inductionStatus,
      medicalStatus,
      competencyStatus,
      authorizationStatus,
      PPEStatus,
      deploymentStatus,
      remarks,
      supportingDocuments,
    ]) {
      controller.dispose();
    }

    super.dispose();
  }

  Future<void> _pickDate(
    ValueChanged<DateTime?> setter,
    DateTime? current,
  ) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
      initialDate: current ?? DateTime.now(),
    );

    if (picked != null) setter(picked);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (status == 'Active' &&
        deploymentStatus.text.trim() == 'Not Cleared') {
      _showError(
        'Active status should not be used while deployment is Not Cleared.',
      );
      return;
    }

    if (status == 'Active' &&
        (inductionStatus.text.trim() != 'Completed' ||
            medicalStatus.text.trim() != 'Fit')) {
      _showError(
        'Active workforce requires completed induction and medical fitness.',
      );
      return;
    }

    final now = DateTime.now();
    final existing = widget.existing;

    final record = WorkforceRecord(
      id: existing?.id ??
          now.microsecondsSinceEpoch.toString(),
      workerNo: workerNo.text.trim(),
      employeeId: employeeId.text.trim(),
      fullName: fullName.text.trim(),
      gender: gender,
      nationality: nationality.text.trim(),
      dateOfBirth: dateOfBirth.text.trim(),
      contactNumber: contactNumber.text.trim(),
      emergencyContact: emergencyContact.text.trim(),
      emergencyContactNumber:
          emergencyContactNumber.text.trim(),
      company: company.text.trim(),
      projectName: projectName.text.trim(),
      siteName: siteName.text.trim(),
      department: department.text.trim(),
      jobTitle: jobTitle.text.trim(),
      trade: trade.text.trim(),
      workerCategory: workerCategory,
      employmentType: employmentType,
      supervisor: supervisor.text.trim(),
      joiningDate: joiningDate,
      mobilizationDate: mobilizationDate,
      demobilizationDate: demobilizationDate,
      accommodation: accommodation.text.trim(),
      campLocation: campLocation.text.trim(),
      IDCardNumber: IDCardNumber.text.trim(),
      IDCardExpiry: IDCardExpiry,
      passportNumber: passportNumber.text.trim(),
      passportExpiry: passportExpiry,
      visaNumber: visaNumber.text.trim(),
      visaExpiry: visaExpiry,
      workPermitNumber: workPermitNumber.text.trim(),
      workPermitExpiry: workPermitExpiry,
      inductionStatus: inductionStatus.text.trim(),
      inductionDate: inductionDate,
      inductionExpiry: inductionExpiry,
      medicalStatus: medicalStatus.text.trim(),
      medicalDate: medicalDate,
      medicalExpiry: medicalExpiry,
      competencyStatus: competencyStatus.text.trim(),
      authorizationStatus: authorizationStatus.text.trim(),
      PPEStatus: PPEStatus.text.trim(),
      deploymentStatus: deploymentStatus.text.trim(),
      status: status,
      remarks: remarks.text.trim(),
      supportingDocuments: supportingDocuments.text.trim(),
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );

    Navigator.pop(context, record);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.94,
          minChildSize: 0.55,
          maxChildSize: 0.98,
          builder: (_, controller) => Form(
            key: _formKey,
            child: ListView(
              controller: controller,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.existing == null
                      ? 'New Workforce Record'
                      : 'Edit Workforce Record',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 12),
                _section(
                  '1. Worker Identity',
                  [
                    _field(
                      workerNo,
                      'Worker No.',
                      required: true,
                    ),
                    _field(
                      employeeId,
                      'Employee / ID No.',
                      required: true,
                    ),
                    _field(
                      fullName,
                      'Full Name',
                      required: true,
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: gender,
                      decoration: const InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(),
                      ),
                      items: widget.genders
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(
                        () => gender = value ?? gender,
                      ),
                    ),
                    _field(nationality, 'Nationality'),
                    _field(
                      dateOfBirth,
                      'Date of Birth / DOB Reference',
                    ),
                    _field(contactNumber, 'Contact Number'),
                    _field(
                      emergencyContact,
                      'Emergency Contact Name',
                    ),
                    _field(
                      emergencyContactNumber,
                      'Emergency Contact Number',
                    ),
                  ],
                ),
                _section(
                  '2. Employment & Deployment',
                  [
                    _field(company, 'Company / Contractor'),
                    _field(projectName, 'Project'),
                    _field(siteName, 'Site / Location'),
                    _field(department, 'Department'),
                    _field(jobTitle, 'Job Title'),
                    _field(trade, 'Trade / Skill'),
                    DropdownButtonFormField<String>(
                      initialValue: workerCategory,
                      decoration: const InputDecoration(
                        labelText: 'Worker Category',
                        border: OutlineInputBorder(),
                      ),
                      items: widget.workerCategories
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(
                        () => workerCategory =
                            value ?? workerCategory,
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: employmentType,
                      decoration: const InputDecoration(
                        labelText: 'Employment Type',
                        border: OutlineInputBorder(),
                      ),
                      items: widget.employmentTypes
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(
                        () => employmentType =
                            value ?? employmentType,
                      ),
                    ),
                    _field(supervisor, 'Supervisor / Reporting To'),
                    _dateTile(
                      'Joining Date',
                      joiningDate,
                      (value) =>
                          setState(() => joiningDate = value),
                    ),
                    _dateTile(
                      'Mobilization Date',
                      mobilizationDate,
                      (value) =>
                          setState(() => mobilizationDate = value),
                    ),
                    _dateTile(
                      'Demobilization Date',
                      demobilizationDate,
                      (value) => setState(
                        () => demobilizationDate = value,
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: status,
                      decoration: const InputDecoration(
                        labelText: 'Workforce Status',
                        border: OutlineInputBorder(),
                      ),
                      items: widget.statuses
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(
                        () => status = value ?? status,
                      ),
                    ),
                  ],
                ),
                _section(
                  '3. Accommodation & Site Access',
                  [
                    _field(
                      accommodation,
                      'Accommodation / Camp Status',
                    ),
                    _field(
                      campLocation,
                      'Camp Location',
                    ),
                    _field(
                      IDCardNumber,
                      'Site ID / Access Card No.',
                    ),
                    _dateTile(
                      'Site ID / Access Card Expiry',
                      IDCardExpiry,
                      (value) =>
                          setState(() => IDCardExpiry = value),
                    ),
                  ],
                ),
                _section(
                  '4. Legal / Employment Documents',
                  [
                    _field(
                      passportNumber,
                      'Passport No.',
                    ),
                    _dateTile(
                      'Passport Expiry',
                      passportExpiry,
                      (value) =>
                          setState(() => passportExpiry = value),
                    ),
                    _field(
                      visaNumber,
                      'Visa No.',
                    ),
                    _dateTile(
                      'Visa Expiry',
                      visaExpiry,
                      (value) =>
                          setState(() => visaExpiry = value),
                    ),
                    _field(
                      workPermitNumber,
                      'Work Permit / Labour Card No.',
                    ),
                    _dateTile(
                      'Work Permit Expiry',
                      workPermitExpiry,
                      (value) =>
                          setState(() => workPermitExpiry = value),
                    ),
                  ],
                ),
                _section(
                  '5. HSE Readiness Snapshot',
                  [
                    _field(
                      inductionStatus,
                      'Induction Status',
                    ),
                    _dateTile(
                      'Induction Date',
                      inductionDate,
                      (value) =>
                          setState(() => inductionDate = value),
                    ),
                    _dateTile(
                      'Induction Expiry / Refresher Due',
                      inductionExpiry,
                      (value) =>
                          setState(() => inductionExpiry = value),
                    ),
                    _field(
                      medicalStatus,
                      'Medical Fitness Status',
                    ),
                    _dateTile(
                      'Medical Date',
                      medicalDate,
                      (value) =>
                          setState(() => medicalDate = value),
                    ),
                    _dateTile(
                      'Medical Fitness Expiry',
                      medicalExpiry,
                      (value) =>
                          setState(() => medicalExpiry = value),
                    ),
                    _field(
                      competencyStatus,
                      'Competency Status',
                    ),
                    _field(
                      authorizationStatus,
                      'Authorization Status',
                    ),
                    _field(
                      PPEStatus,
                      'PPE Status',
                    ),
                    _field(
                      deploymentStatus,
                      'Deployment Clearance',
                    ),
                    Card(
                      color: primaryGreen.withValues(alpha: 0.08),
                      elevation: 0,
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: primaryGreen,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Use this snapshot as the worker master record. '
                                'Detailed induction, training, competency and '
                                'authorization records will be maintained in '
                                'the dedicated Phase 6 modules.',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                _section(
                  '6. Records & Remarks',
                  [
                    _field(
                      remarks,
                      'Remarks / Restrictions',
                      maxLines: 4,
                    ),
                    _field(
                      supportingDocuments,
                      'Supporting Documents / References',
                      maxLines: 3,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                FilledButton.icon(
                  onPressed: _submit,
                  style: FilledButton.styleFrom(
                    backgroundColor: primaryGreen,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                  ),
                  icon: const Icon(Icons.save_outlined),
                  label: Text(
                    widget.existing == null
                        ? 'Save Workforce Record'
                        : 'Update Workforce Record',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 12),
            ...children.expand(
              (item) => [
                item,
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    bool required = false,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: required
          ? (value) {
              if (value == null || value.trim().isEmpty) {
                return '$label is required';
              }
              return null;
            }
          : null,
    );
  }

  Widget _dateTile(
    String title,
    DateTime? value,
    ValueChanged<DateTime?> setter,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(
        value == null
            ? 'Not selected'
            : '${value.day.toString().padLeft(2, '0')}/'
                '${value.month.toString().padLeft(2, '0')}/'
                '${value.year}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null)
            IconButton(
              tooltip: 'Clear',
              onPressed: () => setter(null),
              icon: const Icon(Icons.clear),
            ),
          IconButton(
            tooltip: 'Select date',
            onPressed: () => _pickDate(setter, value),
            icon: const Icon(Icons.calendar_month),
          ),
        ],
      ),
    );
  }
}

class _WorkforceDetailsSheet extends StatelessWidget {
  final WorkforceRecord record;

  const _WorkforceDetailsSheet({required this.record});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.92,
        minChildSize: 0.55,
        maxChildSize: 0.98,
        builder: (_, controller) => ListView(
          controller: controller,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
          children: [
            Text(
              record.fullName.isEmpty
                  ? record.workerNo
                  : record.fullName,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0B5D4B),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${record.workerNo}'
              '${record.employeeId.isEmpty ? '' : ' • ${record.employeeId}'}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 14),
            _detail('Status', record.status),
            _detail('Worker Category', record.workerCategory),
            _detail('Employment Type', record.employmentType),
            _detail('Company', record.company),
            _detail('Project', record.projectName),
            _detail('Site', record.siteName),
            _detail('Department', record.department),
            _detail('Job Title', record.jobTitle),
            _detail('Trade / Skill', record.trade),
            _detail('Supervisor', record.supervisor),
            _detail('Gender', record.gender),
            _detail('Nationality', record.nationality),
            _detail('Contact', record.contactNumber),
            _detail(
              'Emergency Contact',
              record.emergencyContact,
            ),
            _detail(
              'Emergency Contact No.',
              record.emergencyContactNumber,
            ),
            _detail('Joining Date', _date(record.joiningDate)),
            _detail(
              'Mobilization Date',
              _date(record.mobilizationDate),
            ),
            _detail(
              'Demobilization Date',
              _date(record.demobilizationDate),
            ),
            _detail(
              'Accommodation',
              record.accommodation,
            ),
            _detail(
              'Camp Location',
              record.campLocation,
            ),
            _detail(
              'Site ID / Access Card',
              record.IDCardNumber,
            ),
            _detail(
              'ID Card Expiry',
              _date(record.IDCardExpiry),
            ),
            _detail(
              'Passport No.',
              record.passportNumber,
            ),
            _detail(
              'Passport Expiry',
              _date(record.passportExpiry),
            ),
            _detail('Visa No.', record.visaNumber),
            _detail(
              'Visa Expiry',
              _date(record.visaExpiry),
            ),
            _detail(
              'Work Permit No.',
              record.workPermitNumber,
            ),
            _detail(
              'Work Permit Expiry',
              _date(record.workPermitExpiry),
            ),
            const SizedBox(height: 8),
            const Text(
              'HSE Readiness Snapshot',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _detail(
              'Induction Status',
              record.inductionStatus,
            ),
            _detail(
              'Induction Date',
              _date(record.inductionDate),
            ),
            _detail(
              'Induction Expiry',
              _date(record.inductionExpiry),
            ),
            _detail(
              'Medical Status',
              record.medicalStatus,
            ),
            _detail(
              'Medical Date',
              _date(record.medicalDate),
            ),
            _detail(
              'Medical Expiry',
              _date(record.medicalExpiry),
            ),
            _detail(
              'Competency Status',
              record.competencyStatus,
            ),
            _detail(
              'Authorization Status',
              record.authorizationStatus,
            ),
            _detail('PPE Status', record.PPEStatus),
            _detail(
              'Deployment Clearance',
              record.deploymentStatus,
            ),
            _detail('Remarks', record.remarks),
            _detail(
              'Supporting Documents',
              record.supportingDocuments,
            ),
            const SizedBox(height: 12),
            if (record.isOverdue)
              Card(
                color: Colors.red.withValues(alpha: 0.08),
                elevation: 0,
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning_amber_outlined,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'One or more workforce documents have expired.',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
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

  Widget _detail(String title, String value) {
    if (value.trim().isEmpty || value == '-') {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
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

  String _date(DateTime? value) {
    if (value == null) return '-';
    return '${value.day.toString().padLeft(2, '0')}/'
        '${value.month.toString().padLeft(2, '0')}/'
        '${value.year}';
  }
}
