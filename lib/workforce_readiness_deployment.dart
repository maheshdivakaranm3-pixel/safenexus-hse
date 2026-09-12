import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkforceReadinessDeploymentPage extends StatefulWidget {
  const WorkforceReadinessDeploymentPage({super.key});

  @override
  State<WorkforceReadinessDeploymentPage> createState() =>
      _WorkforceReadinessDeploymentPageState();
}

class _WorkforceReadinessDeploymentPageState
    extends State<WorkforceReadinessDeploymentPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const String storageKey =
      'safenexus_hse_workforce_readiness_deployment';

  List<Map<String, dynamic>> records = [];
  String searchText = '';
  String statusFilter = 'All';
  String eligibilityFilter = 'All';

  final List<String> statuses = const [
    'Draft',
    'Under HSE Review',
    'Action Required',
    'Pending Approval',
    'Cleared for Deployment',
    'Cleared with Conditions',
    'Not Cleared',
    'Suspended',
    'Expired',
    'Closed',
  ];

  final List<String> eligibilityOptions = const [
    'Eligible',
    'Eligible with Conditions',
    'Not Eligible',
    'Pending Verification',
  ];

  final List<String> verificationOptions = const [
    'Verified',
    'Not Verified',
    'Not Applicable',
    'Pending',
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
    final parts = item.split('|');

    String getValue(int index) =>
        index < parts.length ? parts[index] : '';

    return {
      'id': getValue(0),
      'workerId': getValue(1),
      'workerName': getValue(2),
      'company': getValue(3),
      'project': getValue(4),
      'site': getValue(5),
      'department': getValue(6),
      'jobRole': getValue(7),
      'supervisor': getValue(8),
      'deploymentArea': getValue(9),
      'inductionVerification': getValue(10),
      'trainingVerification': getValue(11),
      'competencyVerification': getValue(12),
      'authorizationVerification': getValue(13),
      'medicalFitnessVerification': getValue(14),
      'ppeVerification': getValue(15),
      'documentVerification': getValue(16),
      'openActions': getValue(17),
      'restrictions': getValue(18),
      'eligibility': getValue(19).isEmpty
          ? 'Pending Verification'
          : getValue(19),
      'hseOfficer': getValue(20),
      'hseVerificationDate': getValue(21),
      'supervisorVerification': getValue(22),
      'supervisorVerificationDate': getValue(23),
      'approvedBy': getValue(24),
      'approvalDate': getValue(25),
      'clearanceDate': getValue(26),
      'validUntil': getValue(27),
      'reviewDate': getValue(28),
      'clearanceReference': getValue(29),
      'deploymentConditions': getValue(30),
      'requiredActions': getValue(31),
      'status': getValue(32).isEmpty
          ? 'Draft'
          : getValue(32),
      'remarks': getValue(33),
      'createdAt': getValue(34),
      'updatedAt': getValue(35),
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
      'supervisor',
      'deploymentArea',
      'inductionVerification',
      'trainingVerification',
      'competencyVerification',
      'authorizationVerification',
      'medicalFitnessVerification',
      'ppeVerification',
      'documentVerification',
      'openActions',
      'restrictions',
      'eligibility',
      'hseOfficer',
      'hseVerificationDate',
      'supervisorVerification',
      'supervisorVerificationDate',
      'approvedBy',
      'approvalDate',
      'clearanceDate',
      'validUntil',
      'reviewDate',
      'clearanceReference',
      'deploymentConditions',
      'requiredActions',
      'status',
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
          statusFilter == 'All' ||
          record['status'] == statusFilter;

      final matchesEligibility =
          eligibilityFilter == 'All' ||
          record['eligibility'] == eligibilityFilter;

      return matchesSearch &&
          matchesStatus &&
          matchesEligibility;
    }).toList();
  }

  int _countStatus(String status) =>
      records.where((r) => r['status'] == status).length;

  int _countEligibility(String eligibility) =>
      records.where((r) => r['eligibility'] == eligibility).length;

  int get _clearedCount =>
      _countStatus('Cleared for Deployment');

  int get _conditionalCount =>
      _countStatus('Cleared with Conditions');

  int get _actionRequiredCount =>
      _countStatus('Action Required');

  int get _notClearedCount =>
      _countStatus('Not Cleared');

  int get _expiringSoonCount =>
      records.where(_isExpiringSoon).length;

  int get _overdueCount =>
      records.where(_isOverdue).length;

  bool _isOverdue(Map<String, dynamic> record) {
    final date = DateTime.tryParse(
      record['validUntil']?.toString() ?? '',
    );

    if (date == null) return false;

    return date.isBefore(DateTime.now()) &&
        record['status'] != 'Expired' &&
        record['status'] != 'Closed' &&
        record['status'] != 'Suspended';
  }

  bool _isExpiringSoon(Map<String, dynamic> record) {
    final date = DateTime.tryParse(
      record['validUntil']?.toString() ?? '',
    );

    if (date == null || _isOverdue(record)) return false;

    final days = date.difference(DateTime.now()).inDays;
    return days >= 0 && days <= 30;
  }

  Future<void> _openForm({
    Map<String, dynamic>? existing,
  }) async {
    final result =
        await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ReadinessFormSheet(
        existing: existing,
        statuses: statuses,
        eligibilityOptions: eligibilityOptions,
        verificationOptions: verificationOptions,
      ),
    );

    if (result == null) return;

    final now = DateTime.now().toIso8601String();

    if (existing == null) {
      result['id'] =
          'CLR-${DateTime.now().millisecondsSinceEpoch}';
      result['createdAt'] = now;
      result['updatedAt'] = now;
      records.add(result);
    } else {
      result['id'] = existing['id'];
      result['createdAt'] = existing['createdAt'];
      result['updatedAt'] = now;

      final index = records.indexOf(existing);
      if (index >= 0) {
        records[index] = result;
      }
    }

    await _saveRecords();

    if (mounted) setState(() {});
  }

  Future<void> _deleteRecord(
    Map<String, dynamic> record,
  ) async {
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
              : 'Deployment Clearance Details',
        ),
        content: SizedBox(
          width: 540,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: record.entries
                  .where((entry) =>
                      entry.key != 'id' &&
                      entry.key != 'createdAt' &&
                      entry.key != 'updatedAt')
                  .map(
                    (entry) => Padding(
                      padding:
                          const EdgeInsets.only(bottom: 8),
                      child: Text(
                        '${_label(entry.key)}: ${entry.value}',
                        style:
                            const TextStyle(fontSize: 13),
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
        title:
            const Text('Workforce HSE Readiness & Clearance'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Add Clearance',
            onPressed: () => _openForm(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          _dashboard(),
          Padding(
            padding:
                const EdgeInsets.fromLTRB(12, 4, 12, 8),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText:
                        'Search worker, ID, site, job role...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => setState(
                    () => searchText = value,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child:
                          DropdownButtonFormField<String>(
                        initialValue: statusFilter,
                        decoration:
                            const InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          'All',
                          ...statuses,
                        ]
                            .map(
                              (value) =>
                                  DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => setState(
                          () => statusFilter =
                              value ?? 'All',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child:
                          DropdownButtonFormField<String>(
                        initialValue:
                            eligibilityFilter,
                        decoration:
                            const InputDecoration(
                          labelText: 'Eligibility',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          'All',
                          ...eligibilityOptions,
                        ]
                            .map(
                              (value) =>
                                  DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => setState(
                          () => eligibilityFilter =
                              value ?? 'All',
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
                    child: Text(
                      'No workforce readiness records found.',
                    ),
                  )
                : ListView.builder(
                    padding:
                        const EdgeInsets.all(12),
                    itemCount:
                        filteredRecords.length,
                    itemBuilder: (_, index) {
                      final record =
                          filteredRecords[index];

                      final overdue =
                          _isOverdue(record);
                      final expiring =
                          _isExpiringSoon(record);

                      return Card(
                        margin:
                            const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                overdue
                                    ? Colors.red
                                    : primaryGreen,
                            child: const Icon(
                              Icons.verified_user,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            record['workerName']
                                    ?.toString() ??
                                '',
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${record['workerId']} • '
                            '${record['jobRole']}\n'
                            '${record['eligibility']} • '
                            '${record['status']}'
                            '${overdue ? ' • OVERDUE' : ''}'
                            '${expiring ? ' • EXPIRING ≤30 DAYS' : ''}',
                          ),
                          isThreeLine: true,
                          onTap: () =>
                              _showDetails(record),
                          trailing:
                              PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                _openForm(
                                  existing: record,
                                );
                              } else if (value ==
                                  'delete') {
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
      floatingActionButton:
          FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add),
        label: const Text('Add Clearance'),
      ),
    );
  }

  Widget _dashboard() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          _stat(
            'TOTAL',
            records.length,
            Icons.people,
          ),
          _stat(
            'CLEARED',
            _clearedCount,
            Icons.verified,
          ),
          _stat(
            'CONDITIONAL',
            _conditionalCount,
            Icons.rule,
          ),
          _stat(
            'ACTION',
            _actionRequiredCount,
            Icons.assignment_late,
          ),
          _stat(
            'NOT CLEARED',
            _notClearedCount,
            Icons.block,
          ),
          _stat(
            'EXPIRING',
            _expiringSoonCount,
            Icons.schedule,
          ),
          _stat(
            'OVERDUE',
            _overdueCount,
            Icons.warning,
          ),
        ],
      ),
    );
  }

  Widget _stat(
    String title,
    int value,
    IconData icon,
  ) {
    return SizedBox(
      width: 96,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 5,
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: primaryGreen,
                size: 20,
              ),
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
                style:
                    const TextStyle(fontSize: 9),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReadinessFormSheet extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> statuses;
  final List<String> eligibilityOptions;
  final List<String> verificationOptions;

  const _ReadinessFormSheet({
    required this.existing,
    required this.statuses,
    required this.eligibilityOptions,
    required this.verificationOptions,
  });

  @override
  State<_ReadinessFormSheet> createState() =>
      _ReadinessFormSheetState();
}

class _ReadinessFormSheetState
    extends State<_ReadinessFormSheet> {
  static const Color primaryGreen =
      Color(0xFF159447);
  static const Color darkGreen =
      Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController>
      controllers = {};

  String inductionVerification = 'Pending';
  String trainingVerification = 'Pending';
  String competencyVerification = 'Pending';
  String authorizationVerification = 'Pending';
  String medicalFitnessVerification = 'Pending';
  String ppeVerification = 'Pending';
  String documentVerification = 'Pending';
  String eligibility = 'Pending Verification';
  String supervisorVerification = 'Pending';
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
      'supervisor',
      'deploymentArea',
      'openActions',
      'restrictions',
      'hseOfficer',
      'hseVerificationDate',
      'supervisorVerificationDate',
      'approvedBy',
      'approvalDate',
      'clearanceDate',
      'validUntil',
      'reviewDate',
      'clearanceReference',
      'deploymentConditions',
      'requiredActions',
      'remarks',
    ];

    for (final field in fields) {
      controllers[field] =
          TextEditingController(
        text:
            widget.existing?[field]?.toString() ??
                '',
      );
    }

    inductionVerification =
        _existingVerification(
      'inductionVerification',
    );
    trainingVerification =
        _existingVerification(
      'trainingVerification',
    );
    competencyVerification =
        _existingVerification(
      'competencyVerification',
    );
    authorizationVerification =
        _existingVerification(
      'authorizationVerification',
    );
    medicalFitnessVerification =
        _existingVerification(
      'medicalFitnessVerification',
    );
    ppeVerification =
        _existingVerification(
      'ppeVerification',
    );
    documentVerification =
        _existingVerification(
      'documentVerification',
    );
    supervisorVerification =
        _existingVerification(
      'supervisorVerification',
    );

    final existingEligibility =
        widget.existing?['eligibility']?.toString();

    if (existingEligibility != null &&
        widget.eligibilityOptions
            .contains(existingEligibility)) {
      eligibility = existingEligibility;
    }

    final existingStatus =
        widget.existing?['status']?.toString();

    if (existingStatus != null &&
        widget.statuses.contains(existingStatus)) {
      status = existingStatus;
    }
  }

  String _existingVerification(String key) {
    final value =
        widget.existing?[key]?.toString();

    if (value != null &&
        widget.verificationOptions
            .contains(value)) {
      return value;
    }

    return 'Pending';
  }

  @override
  void dispose() {
    for (final controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  TextEditingController _controller(
    String key,
  ) =>
      controllers[key]!;

  String? _required(String? value) {
    if (value == null ||
        value.trim().isEmpty) {
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
      padding:
          const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: _controller(key),
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border:
              const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _section(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 6,
        bottom: 10,
      ),
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

  Widget _verificationDropdown(
    String label,
    String value,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 10),
      child:
          DropdownButtonFormField<String>(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          border:
              const OutlineInputBorder(),
        ),
        items: widget.verificationOptions
            .map(
              (option) =>
                  DropdownMenuItem(
                value: option,
                child: Text(option),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height:
            MediaQuery.of(context).size.height *
                0.95,
        decoration:
            const BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.all(14),
                color: darkGreen,
                child: const Row(
                  children: [
                    Icon(
                      Icons.verified_user,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Workforce HSE Readiness & Deployment Clearance',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets.all(16),
                  children: [
                    _section(
                      'WORKER & DEPLOYMENT',
                    ),
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
                    _field(
                      'project',
                      'Project',
                    ),
                    _field(
                      'site',
                      'Site',
                    ),
                    _field(
                      'department',
                      'Department',
                    ),
                    _field(
                      'jobRole',
                      'Job Role / Trade',
                    ),
                    _field(
                      'supervisor',
                      'Supervisor',
                    ),
                    _field(
                      'deploymentArea',
                      'Deployment Area / Work Front',
                    ),
                    _section(
                      'HSE READINESS VERIFICATION',
                    ),
                    _verificationDropdown(
                      'Induction Verification',
                      inductionVerification,
                      (value) => setState(
                        () => inductionVerification =
                            value ?? 'Pending',
                      ),
                    ),
                    _verificationDropdown(
                      'Training & Certification Verification',
                      trainingVerification,
                      (value) => setState(
                        () => trainingVerification =
                            value ?? 'Pending',
                      ),
                    ),
                    _verificationDropdown(
                      'Competency Verification',
                      competencyVerification,
                      (value) => setState(
                        () => competencyVerification =
                            value ?? 'Pending',
                      ),
                    ),
                    _verificationDropdown(
                      'Authorization / Appointment Verification',
                      authorizationVerification,
                      (value) => setState(
                        () => authorizationVerification =
                            value ?? 'Pending',
                      ),
                    ),
                    _verificationDropdown(
                      'Medical Fitness Verification',
                      medicalFitnessVerification,
                      (value) => setState(
                        () => medicalFitnessVerification =
                            value ?? 'Pending',
                      ),
                    ),
                    _verificationDropdown(
                      'PPE Readiness Verification',
                      ppeVerification,
                      (value) => setState(
                        () => ppeVerification =
                            value ?? 'Pending',
                      ),
                    ),
                    _verificationDropdown(
                      'Required Documents Verification',
                      documentVerification,
                      (value) => setState(
                        () => documentVerification =
                            value ?? 'Pending',
                      ),
                    ),
                    _section(
                      'ACTIONS & RESTRICTIONS',
                    ),
                    _field(
                      'openActions',
                      'Open HSE Actions / Outstanding Items',
                      maxLines: 3,
                    ),
                    _field(
                      'restrictions',
                      'Worker Restrictions / Limitations',
                      maxLines: 3,
                    ),
                    _field(
                      'requiredActions',
                      'Required Actions Before Deployment',
                      maxLines: 3,
                    ),
                    _section(
                      'ELIGIBILITY & VERIFICATION',
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: eligibility,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'Deployment Eligibility',
                        border:
                            OutlineInputBorder(),
                      ),
                      items: widget.eligibilityOptions
                          .map(
                            (value) =>
                                DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(
                        () => eligibility =
                            value ??
                                'Pending Verification',
                      ),
                    ),
                    const SizedBox(height: 10),
                    _field(
                      'hseOfficer',
                      'HSE Officer / Verifier',
                    ),
                    _field(
                      'hseVerificationDate',
                      'HSE Verification Date (YYYY-MM-DD)',
                    ),
                    _verificationDropdown(
                      'Supervisor Verification',
                      supervisorVerification,
                      (value) => setState(
                        () => supervisorVerification =
                            value ?? 'Pending',
                      ),
                    ),
                    _field(
                      'supervisorVerificationDate',
                      'Supervisor Verification Date (YYYY-MM-DD)',
                    ),
                    _section(
                      'APPROVAL & CLEARANCE',
                    ),
                    _field(
                      'approvedBy',
                      'Approved By',
                    ),
                    _field(
                      'approvalDate',
                      'Approval Date (YYYY-MM-DD)',
                    ),
                    _field(
                      'clearanceDate',
                      'Clearance Date (YYYY-MM-DD)',
                    ),
                    _field(
                      'validUntil',
                      'Clearance Valid Until (YYYY-MM-DD)',
                    ),
                    _field(
                      'reviewDate',
                      'Next Review Date (YYYY-MM-DD)',
                    ),
                    _field(
                      'clearanceReference',
                      'Clearance Reference Number',
                    ),
                    _field(
                      'deploymentConditions',
                      'Deployment Conditions',
                      maxLines: 3,
                    ),
                    _section(
                      'STATUS & RECORD',
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: status,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'Clearance Status',
                        border:
                            OutlineInputBorder(),
                      ),
                      items: widget.statuses
                          .map(
                            (value) =>
                                DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(
                        () => status =
                            value ?? 'Draft',
                      ),
                    ),
                    const SizedBox(height: 10),
                    _field(
                      'remarks',
                      'Remarks',
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Expanded(
                      child:
                          OutlinedButton(
                        onPressed: () =>
                            Navigator.pop(
                          context,
                        ),
                        child:
                            const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child:
                          ElevatedButton.icon(
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              primaryGreen,
                          foregroundColor:
                              Colors.white,
                        ),
                        onPressed: _save,
                        icon: const Icon(
                          Icons.save,
                        ),
                        label: const Text(
                          'Save Clearance',
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

  void _save() {
    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    final data =
        <String, dynamic>{};

    for (final entry
        in controllers.entries) {
      data[entry.key] =
          entry.value.text.trim();
    }

    data['inductionVerification'] =
        inductionVerification;
    data['trainingVerification'] =
        trainingVerification;
    data['competencyVerification'] =
        competencyVerification;
    data['authorizationVerification'] =
        authorizationVerification;
    data['medicalFitnessVerification'] =
        medicalFitnessVerification;
    data['ppeVerification'] =
        ppeVerification;
    data['documentVerification'] =
        documentVerification;
    data['eligibility'] = eligibility;
    data['supervisorVerification'] =
        supervisorVerification;
    data['status'] = status;

    Navigator.pop(context, data);
  }
}
