import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthorizationAppointmentPage extends StatefulWidget {
  const AuthorizationAppointmentPage({super.key});

  @override
  State<AuthorizationAppointmentPage> createState() =>
      _AuthorizationAppointmentPageState();
}

class _AuthorizationAppointmentPageState
    extends State<AuthorizationAppointmentPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const String storageKey =
      'safenexus_hse_authorization_appointment';

  List<Map<String, dynamic>> records = [];
  String searchText = '';
  String statusFilter = 'All';
  String typeFilter = 'All';

  final List<String> statuses = const [
    'Draft',
    'Pending Assessment',
    'Pending Approval',
    'Active',
    'Active with Conditions',
    'Expiring Soon',
    'Expired',
    'Suspended',
    'Revoked',
    'Closed',
  ];

  final List<String> authorizationTypes = const [
    'HSE Appointment',
    'Competent Person',
    'Authorized Person',
    'Permit Issuer',
    'Permit Receiver',
    'Fire Warden',
    'First Aider',
    'Emergency Response Team',
    'Lifting Supervisor',
    'Banksman / Slinger',
    'Scaffolding Inspector',
    'Work at Height Competent Person',
    'Confined Space Attendant',
    'Confined Space Entry Supervisor',
    'Electrical Authorized Person',
    'LOTO Authorized Person',
    'Excavation Competent Person',
    'Gas Tester',
    'Other',
  ];

  final List<String> approvalLevels = const [
    'HSE Officer',
    'HSE Manager',
    'Project Manager',
    'Site Manager',
    'Construction Manager',
    'Client Representative',
    'Authority / Regulator',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(storageKey) ?? [];
    final loaded = raw.map(_decode).toList();
    if (!mounted) return;
    setState(() => records = loaded);
  }

  Map<String, dynamic> _decode(String item) {
    final p = item.split('|');
    String get(int index) => index < p.length ? p[index] : '';

    return {
      'id': get(0),
      'workerId': get(1),
      'workerName': get(2),
      'company': get(3),
      'project': get(4),
      'site': get(5),
      'department': get(6),
      'jobRole': get(7),
      'authorizationType': get(8),
      'authorizationNo': get(9),
      'competencyReference': get(10),
      'qualificationReference': get(11),
      'appointmentRole': get(12),
      'scope': get(13),
      'restrictions': get(14),
      'issuedDate': get(15),
      'validFrom': get(16),
      'validUntil': get(17),
      'appointedBy': get(18),
      'approvedBy': get(19),
      'approvalLevel': get(20),
      'assessmentReference': get(21),
      'conditions': get(22),
      'status': get(23).isEmpty ? 'Draft' : get(23),
      'suspensionReason': get(24),
      'revocationReason': get(25),
      'evidence': get(26),
      'remarks': get(27),
      'createdAt': get(28),
      'updatedAt': get(29),
    };
  }

  String _safe(Object? value) =>
      (value?.toString() ?? '').replaceAll('|', '/').trim();

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    const keys = [
      'id',
      'workerId',
      'workerName',
      'company',
      'project',
      'site',
      'department',
      'jobRole',
      'authorizationType',
      'authorizationNo',
      'competencyReference',
      'qualificationReference',
      'appointmentRole',
      'scope',
      'restrictions',
      'issuedDate',
      'validFrom',
      'validUntil',
      'appointedBy',
      'approvedBy',
      'approvalLevel',
      'assessmentReference',
      'conditions',
      'status',
      'suspensionReason',
      'revocationReason',
      'evidence',
      'remarks',
      'createdAt',
      'updatedAt',
    ];

    final raw = records.map((record) {
      return keys.map((key) => _safe(record[key])).join('|');
    }).toList();

    await prefs.setStringList(storageKey, raw);
  }

  List<Map<String, dynamic>> get filteredRecords {
    final query = searchText.trim().toLowerCase();

    return records.where((record) {
      final searchable = record.values.join(' ').toLowerCase();
      final matchesSearch =
          query.isEmpty || searchable.contains(query);
      final matchesStatus =
          statusFilter == 'All' || record['status'] == statusFilter;
      final matchesType = typeFilter == 'All' ||
          record['authorizationType'] == typeFilter;

      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  int _count(String status) =>
      records.where((record) => record['status'] == status).length;

  int get _overdueCount =>
      records.where(_isOverdue).length;

  int get _expiringSoonCount =>
      records.where(_isExpiringSoon).length;

  int get _activeCount =>
      records.where((record) =>
          record['status'] == 'Active' ||
          record['status'] == 'Active with Conditions').length;

  bool _isOverdue(Map<String, dynamic> record) {
    final date =
        DateTime.tryParse(record['validUntil']?.toString() ?? '');
    if (date == null) return false;

    return date.isBefore(DateTime.now()) &&
        record['status'] != 'Expired' &&
        record['status'] != 'Revoked' &&
        record['status'] != 'Closed';
  }

  bool _isExpiringSoon(Map<String, dynamic> record) {
    final date =
        DateTime.tryParse(record['validUntil']?.toString() ?? '');
    if (date == null || _isOverdue(record)) return false;

    final days = date.difference(DateTime.now()).inDays;
    return days >= 0 && days <= 30;
  }

  Future<void> _openForm({Map<String, dynamic>? existing}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AuthorizationFormSheet(
        existing: existing,
        statuses: statuses,
        authorizationTypes: authorizationTypes,
        approvalLevels: approvalLevels,
      ),
    );

    if (result == null) return;

    final now = DateTime.now().toIso8601String();

    if (existing == null) {
      result['id'] = 'AUTH-${DateTime.now().millisecondsSinceEpoch}';
      result['createdAt'] = now;
      result['updatedAt'] = now;
      records.add(result);
    } else {
      result['id'] = existing['id'];
      result['createdAt'] = existing['createdAt'];
      result['updatedAt'] = now;

      final index = records.indexOf(existing);
      if (index >= 0) records[index] = result;
    }

    await _saveRecords();
    if (mounted) setState(() {});
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    records.remove(record);
    await _saveRecords();
    if (mounted) setState(() {});
  }

  void _showDetails(Map<String, dynamic> record) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          record['workerName']?.toString().isNotEmpty == true
              ? record['workerName'].toString()
              : 'Authorization Details',
        ),
        content: SizedBox(
          width: 520,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: record.entries
                  .where((entry) =>
                      entry.key != 'id' &&
                      entry.key != 'createdAt' &&
                      entry.key != 'updatedAt')
                  .map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        '${_label(entry.key)}: ${entry.value}',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  String _label(String key) {
    final spaced = key.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => ' ${match.group(1)}',
    );

    return spaced.isEmpty
        ? key
        : '${spaced[0].toUpperCase()}${spaced.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authorization & Appointment'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Add Authorization',
            onPressed: () => _openForm(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          _dashboard(),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText:
                        'Search worker, authorization, role, reference...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) =>
                      setState(() => searchText = value),
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
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => setState(
                          () => statusFilter = value ?? 'All',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: typeFilter,
                        decoration: const InputDecoration(
                          labelText: 'Authorization Type',
                          border: OutlineInputBorder(),
                        ),
                        items: ['All', ...authorizationTypes]
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => setState(
                          () => typeFilter = value ?? 'All',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredRecords.isEmpty
                ? const Center(
                    child: Text('No authorization records found.'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredRecords.length,
                    itemBuilder: (_, index) {
                      final record = filteredRecords[index];
                      final overdue = _isOverdue(record);
                      final expiring = _isExpiringSoon(record);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                overdue ? Colors.red : primaryGreen,
                            child: const Icon(
                              Icons.verified_user,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            record['workerName']?.toString() ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${record['authorizationType']} • '
                            '${record['authorizationNo']}\n'
                            '${record['status']}'
                            '${overdue ? ' • OVERDUE' : ''}'
                            '${expiring ? ' • EXPIRING ≤30 DAYS' : ''}',
                          ),
                          isThreeLine: true,
                          onTap: () => _showDetails(record),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                _openForm(existing: record);
                              } else if (value == 'delete') {
                                _deleteRecord(record);
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add),
        label: const Text('Add Authorization'),
      ),
    );
  }

  Widget _dashboard() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          _stat('TOTAL', records.length, Icons.badge),
          _stat('ACTIVE', _activeCount, Icons.verified),
          _stat(
            'PENDING',
            _count('Pending Approval'),
            Icons.pending_actions,
          ),
          _stat(
            'EXPIRING',
            _expiringSoonCount,
            Icons.schedule,
          ),
          _stat('EXPIRED', _count('Expired'), Icons.event_busy),
          _stat('OVERDUE', _overdueCount, Icons.warning),
        ],
      ),
    );
  }

  Widget _stat(String title, int value, IconData icon) {
    return SizedBox(
      width: 105,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 5,
          ),
          child: Column(
            children: [
              Icon(icon, color: primaryGreen, size: 20),
              const SizedBox(height: 3),
              Text(
                '$value',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 9),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthorizationFormSheet extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> statuses;
  final List<String> authorizationTypes;
  final List<String> approvalLevels;

  const _AuthorizationFormSheet({
    required this.existing,
    required this.statuses,
    required this.authorizationTypes,
    required this.approvalLevels,
  });

  @override
  State<_AuthorizationFormSheet> createState() =>
      _AuthorizationFormSheetState();
}

class _AuthorizationFormSheetState
    extends State<_AuthorizationFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {};

  String authorizationType = 'HSE Appointment';
  String approvalLevel = 'HSE Officer';
  String status = 'Draft';

  @override
  void initState() {
    super.initState();

    const fields = [
      'workerId',
      'workerName',
      'company',
      'project',
      'site',
      'department',
      'jobRole',
      'authorizationNo',
      'competencyReference',
      'qualificationReference',
      'appointmentRole',
      'scope',
      'restrictions',
      'issuedDate',
      'validFrom',
      'validUntil',
      'appointedBy',
      'approvedBy',
      'assessmentReference',
      'conditions',
      'suspensionReason',
      'revocationReason',
      'evidence',
      'remarks',
    ];

    for (final field in fields) {
      controllers[field] = TextEditingController(
        text: widget.existing?[field]?.toString() ?? '',
      );
    }

    final existingType =
        widget.existing?['authorizationType']?.toString();
    if (existingType != null &&
        widget.authorizationTypes.contains(existingType)) {
      authorizationType = existingType;
    }

    final existingApproval =
        widget.existing?['approvalLevel']?.toString();
    if (existingApproval != null &&
        widget.approvalLevels.contains(existingApproval)) {
      approvalLevel = existingApproval;
    }

    final existingStatus =
        widget.existing?['status']?.toString();
    if (existingStatus != null &&
        widget.statuses.contains(existingStatus)) {
      status = existingStatus;
    }
  }

  @override
  void dispose() {
    for (final controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  TextEditingController _controller(String key) =>
      controllers[key]!;

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    return null;
  }

  Widget _field(
    String key,
    String label, {
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: _controller(key),
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _section(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: darkGreen,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                color: darkGreen,
                child: const Row(
                  children: [
                    Icon(Icons.verified_user, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Authorization & Appointment Record',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _section('PERSON & DEPLOYMENT'),
                    _field(
                      'workerId',
                      'Worker / Employee ID',
                      validator: _required,
                    ),
                    _field(
                      'workerName',
                      'Worker Name',
                      validator: _required,
                    ),
                    _field(
                      'company',
                      'Company / Contractor',
                      validator: _required,
                    ),
                    _field('project', 'Project'),
                    _field('site', 'Site / Location'),
                    _field('department', 'Department'),
                    _field('jobRole', 'Job Role / Trade'),
                    _section('AUTHORIZATION'),
                    DropdownButtonFormField<String>(
                      initialValue: authorizationType,
                      decoration: const InputDecoration(
                        labelText: 'Authorization / Appointment Type',
                        border: OutlineInputBorder(),
                      ),
                      items: widget.authorizationTypes
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(
                        () => authorizationType =
                            value ?? widget.authorizationTypes.first,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _field(
                      'authorizationNo',
                      'Authorization / Appointment No.',
                      validator: _required,
                    ),
                    _field(
                      'appointmentRole',
                      'Appointed Role / Position',
                      validator: _required,
                    ),
                    _field(
                      'scope',
                      'Scope of Authorization / Duties',
                      maxLines: 3,
                    ),
                    _field(
                      'restrictions',
                      'Restrictions / Limitations',
                      maxLines: 3,
                    ),
                    _section('COMPETENCY & QUALIFICATION'),
                    _field(
                      'competencyReference',
                      'Competency Assessment Reference',
                    ),
                    _field(
                      'qualificationReference',
                      'Training / Qualification Reference',
                    ),
                    _field(
                      'assessmentReference',
                      'Assessment / Verification Reference',
                    ),
                    _section('APPROVAL & VALIDITY'),
                    _field(
                      'issuedDate',
                      'Issue Date (YYYY-MM-DD)',
                      validator: _required,
                    ),
                    _field(
                      'validFrom',
                      'Valid From (YYYY-MM-DD)',
                      validator: _required,
                    ),
                    _field(
                      'validUntil',
                      'Valid Until (YYYY-MM-DD)',
                      validator: _required,
                    ),
                    _field(
                      'appointedBy',
                      'Appointed By',
                      validator: _required,
                    ),
                    _field('approvedBy', 'Approved By'),
                    DropdownButtonFormField<String>(
                      initialValue: approvalLevel,
                      decoration: const InputDecoration(
                        labelText: 'Approval Level',
                        border: OutlineInputBorder(),
                      ),
                      items: widget.approvalLevels
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(
                        () => approvalLevel =
                            value ?? widget.approvalLevels.first,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _field(
                      'conditions',
                      'Conditions of Authorization',
                      maxLines: 3,
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: status,
                      decoration: const InputDecoration(
                        labelText: 'Authorization Status',
                        border: OutlineInputBorder(),
                      ),
                      items: widget.statuses
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(
                        () => status = value ?? 'Draft',
                      ),
                    ),
                    const SizedBox(height: 10),
                    _section('SUSPENSION / REVOCATION'),
                    _field(
                      'suspensionReason',
                      'Suspension Reason',
                      maxLines: 2,
                    ),
                    _field(
                      'revocationReason',
                      'Revocation Reason',
                      maxLines: 2,
                    ),
                    _field(
                      'evidence',
                      'Evidence / Certificate / Document Reference',
                      maxLines: 2,
                    ),
                    _field(
                      'remarks',
                      'Remarks / Follow-up Actions',
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _save,
                        icon: const Icon(Icons.save),
                        label: const Text('Save Authorization'),
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

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final data = <String, dynamic>{};
    for (final entry in controllers.entries) {
      data[entry.key] = entry.value.text.trim();
    }

    data['authorizationType'] = authorizationType;
    data['approvalLevel'] = approvalLevel;
    data['status'] = status;

    Navigator.pop(context, data);
  }
}
