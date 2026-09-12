import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerMedicalFitnessPage extends StatefulWidget {
  const WorkerMedicalFitnessPage({super.key});

  @override
  State<WorkerMedicalFitnessPage> createState() =>
      _WorkerMedicalFitnessPageState();
}

class _WorkerMedicalFitnessPageState
    extends State<WorkerMedicalFitnessPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const String storageKey =
      'safenexus_hse_worker_medical_fitness';

  List<Map<String, dynamic>> records = [];
  String searchText = '';
  String statusFilter = 'All';
  String fitnessFilter = 'All';

  final List<String> statuses = const [
    'Scheduled',
    'Under Examination',
    'Fit',
    'Fit with Restrictions',
    'Temporarily Unfit',
    'Unfit',
    'Follow-up Required',
    'Expired',
    'Cancelled',
    'Closed',
  ];

  final List<String> fitnessStatuses = const [
    'Fit',
    'Fit with Restrictions',
    'Temporarily Unfit',
    'Unfit',
    'Pending',
  ];

  final List<String> examinationTypes = const [
    'Pre-Employment Medical',
    'Pre-Deployment Medical',
    'Periodic Medical Examination',
    'Annual Medical Examination',
    'Return-to-Work Medical',
    'Post-Illness Medical',
    'Post-Incident Medical',
    'Fitness for High-Risk Work',
    'Heat Stress / Occupational Health Assessment',
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
    String get(int i) => i < p.length ? p[i] : '';

    return {
      'id': get(0),
      'workerId': get(1),
      'workerName': get(2),
      'company': get(3),
      'project': get(4),
      'site': get(5),
      'department': get(6),
      'jobRole': get(7),
      'examinationType': get(8),
      'examinationDate': get(9),
      'medicalReference': get(10),
      'medicalAuthority': get(11),
      'fitnessStatus': get(12).isEmpty ? 'Pending' : get(12),
      'certificateNo': get(13),
      'validFrom': get(14),
      'validUntil': get(15),
      'restrictions': get(16),
      'workLimitations': get(17),
      'followUpRequired': get(18),
      'followUpDate': get(19),
      'recommendations': get(20),
      'evidence': get(21),
      'status': get(22).isEmpty ? 'Scheduled' : get(22),
      'remarks': get(23),
      'createdAt': get(24),
      'updatedAt': get(25),
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
      'examinationType',
      'examinationDate',
      'medicalReference',
      'medicalAuthority',
      'fitnessStatus',
      'certificateNo',
      'validFrom',
      'validUntil',
      'restrictions',
      'workLimitations',
      'followUpRequired',
      'followUpDate',
      'recommendations',
      'evidence',
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
          statusFilter == 'All' || record['status'] == statusFilter;
      final matchesFitness = fitnessFilter == 'All' ||
          record['fitnessStatus'] == fitnessFilter;

      return matchesSearch && matchesStatus && matchesFitness;
    }).toList();
  }

  int _count(String status) =>
      records.where((r) => r['status'] == status).length;

  int get _fitCount => records.where((r) =>
      r['fitnessStatus'] == 'Fit').length;

  int get _restrictedCount => records.where((r) =>
      r['fitnessStatus'] == 'Fit with Restrictions').length;

  int get _overdueCount =>
      records.where(_isOverdue).length;

  int get _expiringSoonCount =>
      records.where(_isExpiringSoon).length;

  bool _isOverdue(Map<String, dynamic> record) {
    final date =
        DateTime.tryParse(record['validUntil']?.toString() ?? '');

    if (date == null) return false;

    return date.isBefore(DateTime.now()) &&
        record['status'] != 'Expired' &&
        record['status'] != 'Cancelled' &&
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
      builder: (_) => _MedicalFitnessFormSheet(
        existing: existing,
        statuses: statuses,
        fitnessStatuses: fitnessStatuses,
        examinationTypes: examinationTypes,
      ),
    );

    if (result == null) return;

    final now = DateTime.now().toIso8601String();

    if (existing == null) {
      result['id'] = 'MED-${DateTime.now().millisecondsSinceEpoch}';
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
              : 'Medical & Fitness Details',
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
        title: const Text('Worker Medical & Fitness'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Add Medical Record',
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
                        'Search worker, certificate, doctor, site...',
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
                        initialValue: fitnessFilter,
                        decoration: const InputDecoration(
                          labelText: 'Fitness Status',
                          border: OutlineInputBorder(),
                        ),
                        items: ['All', ...fitnessStatuses]
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => setState(
                          () => fitnessFilter = value ?? 'All',
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
                    child: Text('No medical fitness records found.'),
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
                              Icons.health_and_safety,
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
                            '${record['examinationType']} • '
                            '${record['fitnessStatus']}\n'
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
        label: const Text('Add Medical Record'),
      ),
    );
  }

  Widget _dashboard() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          _stat('TOTAL', records.length, Icons.people),
          _stat('FIT', _fitCount, Icons.verified),
          _stat('RESTRICTED', _restrictedCount, Icons.rule),
          _stat(
            'FOLLOW-UP',
            _count('Follow-up Required'),
            Icons.medical_services,
          ),
          _stat('EXPIRING', _expiringSoonCount, Icons.schedule),
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

class _MedicalFitnessFormSheet extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> statuses;
  final List<String> fitnessStatuses;
  final List<String> examinationTypes;

  const _MedicalFitnessFormSheet({
    required this.existing,
    required this.statuses,
    required this.fitnessStatuses,
    required this.examinationTypes,
  });

  @override
  State<_MedicalFitnessFormSheet> createState() =>
      _MedicalFitnessFormSheetState();
}

class _MedicalFitnessFormSheetState
    extends State<_MedicalFitnessFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {};

  String examinationType = 'Pre-Deployment Medical';
  String fitnessStatus = 'Pending';
  String status = 'Scheduled';

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
      'examinationDate',
      'medicalReference',
      'medicalAuthority',
      'certificateNo',
      'validFrom',
      'validUntil',
      'restrictions',
      'workLimitations',
      'followUpRequired',
      'followUpDate',
      'recommendations',
      'evidence',
      'remarks',
    ];

    for (final field in fields) {
      controllers[field] = TextEditingController(
        text: widget.existing?[field]?.toString() ?? '',
      );
    }

    final existingType =
        widget.existing?['examinationType']?.toString();
    if (existingType != null &&
        widget.examinationTypes.contains(existingType)) {
      examinationType = existingType;
    }

    final existingFitness =
        widget.existing?['fitnessStatus']?.toString();
    if (existingFitness != null &&
        widget.fitnessStatuses.contains(existingFitness)) {
      fitnessStatus = existingFitness;
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
                    Icon(
                      Icons.health_and_safety,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Worker Medical & Fitness Record',
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
                    _section('WORKER & DEPLOYMENT'),
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
                    _section('MEDICAL EXAMINATION'),
                    DropdownButtonFormField<String>(
                      initialValue: examinationType,
                      decoration: const InputDecoration(
                        labelText: 'Medical Examination Type',
                        border: OutlineInputBorder(),
                      ),
                      items: widget.examinationTypes
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(
                        () => examinationType =
                            value ?? widget.examinationTypes.first,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _field(
                      'examinationDate',
                      'Examination Date (YYYY-MM-DD)',
                      validator: _required,
                    ),
                    _field(
                      'medicalReference',
                      'Medical Examination Reference',
                    ),
                    _field(
                      'medicalAuthority',
                      'Medical Authority / Occupational Health Provider',
                    ),
                    _section('FITNESS & CERTIFICATE'),
                    DropdownButtonFormField<String>(
                      initialValue: fitnessStatus,
                      decoration: const InputDecoration(
                        labelText: 'Fitness Status',
                        border: OutlineInputBorder(),
                      ),
                      items: widget.fitnessStatuses
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(
                        () => fitnessStatus =
                            value ?? widget.fitnessStatuses.first,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _field('certificateNo', 'Fitness Certificate Number'),
                    _field(
                      'validFrom',
                      'Fitness Valid From (YYYY-MM-DD)',
                    ),
                    _field(
                      'validUntil',
                      'Fitness Valid Until (YYYY-MM-DD)',
                    ),
                    _section('RESTRICTIONS & FOLLOW-UP'),
                    _field(
                      'restrictions',
                      'Medical Restrictions',
                      maxLines: 3,
                    ),
                    _field(
                      'workLimitations',
                      'Work Limitations / Deployment Restrictions',
                      maxLines: 3,
                    ),
                    _field(
                      'followUpRequired',
                      'Follow-up Required / Medical Review',
                    ),
                    _field(
                      'followUpDate',
                      'Follow-up Date (YYYY-MM-DD)',
                    ),
                    _field(
                      'recommendations',
                      'Medical / Occupational Health Recommendations',
                      maxLines: 3,
                    ),
                    _section('STATUS & RECORD'),
                    DropdownButtonFormField<String>(
                      initialValue: status,
                      decoration: const InputDecoration(
                        labelText: 'Record Status',
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
                        () => status = value ?? 'Scheduled',
                      ),
                    ),
                    const SizedBox(height: 10),
                    _field(
                      'evidence',
                      'Evidence / Certificate File Reference',
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
                        label: const Text('Save Medical Record'),
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

    data['examinationType'] = examinationType;
    data['fitnessStatus'] = fitnessStatus;
    data['status'] = status;

    Navigator.pop(context, data);
  }
}
