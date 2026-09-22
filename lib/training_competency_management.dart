import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrainingCompetencyManagementPage extends StatefulWidget {
  const TrainingCompetencyManagementPage({super.key});

  @override
  State<TrainingCompetencyManagementPage> createState() =>
      _TrainingCompetencyManagementPageState();
}

class _TrainingCompetencyManagementPageState
    extends State<TrainingCompetencyManagementPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const String storageKey =
      'safenexus_hse_training_competency_management';

  List<Map<String, dynamic>> records = [];
  String searchText = '';
  String statusFilter = 'All';
  String categoryFilter = 'All';

  final List<String> statuses = const [
    'Planned',
    'Scheduled',
    'In Progress',
    'Completed',
    'Competent',
    'Not Yet Competent',
    'Expired',
    'Refresher Required',
    'Cancelled',
  ];

  final List<String> categories = const [
    'HSE Induction',
    'Mandatory HSE',
    'Job Specific',
    'High-Risk Work',
    'Emergency',
    'Equipment',
    'Environmental',
    'Occupational Health',
    'Leadership',
    'Refresher',
    'Other',
  ];

  final List<String> competencyLevels = const [
    'Not Assessed',
    'Awareness',
    'Basic',
    'Intermediate',
    'Advanced',
    'Competent',
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
      'courseCode': get(8),
      'courseTitle': get(9),
      'category': get(10).isEmpty ? 'Mandatory HSE' : get(10),
      'provider': get(11),
      'trainer': get(12),
      'trainingDate': get(13),
      'expiryDate': get(14),
      'certificateNo': get(15),
      'competencyLevel': get(16).isEmpty ? 'Not Assessed' : get(16),
      'assessmentDate': get(17),
      'assessmentMethod': get(18),
      'assessmentScore': get(19),
      'status': get(20).isEmpty ? 'Planned' : get(20),
      'evidence': get(21),
      'renewalRequired': get(22).isEmpty ? 'No' : get(22),
      'renewalPlan': get(23),
      'remarks': get(24),
      'createdAt': get(25),
      'updatedAt': get(26),
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
      'courseCode',
      'courseTitle',
      'category',
      'provider',
      'trainer',
      'trainingDate',
      'expiryDate',
      'certificateNo',
      'competencyLevel',
      'assessmentDate',
      'assessmentMethod',
      'assessmentScore',
      'status',
      'evidence',
      'renewalRequired',
      'renewalPlan',
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
      final matchesCategory =
          categoryFilter == 'All' || record['category'] == categoryFilter;
      return matchesSearch && matchesStatus && matchesCategory;
    }).toList();
  }

  int _count(String status) =>
      records.where((r) => r['status'] == status).length;

  int get _overdueCount => records.where(_isOverdue).length;

  int get _expiringSoonCount =>
      records.where(_isExpiringSoon).length;

  bool _isOverdue(Map<String, dynamic> record) {
    final expiry =
        DateTime.tryParse(record['expiryDate']?.toString() ?? '');
    if (expiry == null) return false;
    return expiry.isBefore(DateTime.now()) &&
        record['status'] != 'Cancelled';
  }

  bool _isExpiringSoon(Map<String, dynamic> record) {
    final expiry =
        DateTime.tryParse(record['expiryDate']?.toString() ?? '');
    if (expiry == null || _isOverdue(record)) return false;
    final days = expiry.difference(DateTime.now()).inDays;
    return days >= 0 && days <= 30;
  }

  Future<void> _openForm({Map<String, dynamic>? existing}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _TrainingFormSheet(
        existing: existing,
        statuses: statuses,
        categories: categories,
        competencyLevels: competencyLevels,
      ),
    );

    if (result == null) return;

    final now = DateTime.now().toIso8601String();
    if (existing == null) {
      result['id'] = 'TRN-${DateTime.now().millisecondsSinceEpoch}';
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
          record['courseTitle']?.toString().isNotEmpty == true
              ? record['courseTitle'].toString()
              : 'Training Details',
        ),
        content: SizedBox(
          width: 520,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: record.entries
                  .where((e) =>
                      e.key != 'id' &&
                      e.key != 'createdAt' &&
                      e.key != 'updatedAt')
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        '${_label(e.key)}: ${e.value}',
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
        title: const Text('Training & Competency Management'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Add Training',
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
                        'Search worker, course, certificate, provider...',
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
                        initialValue: categoryFilter,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                        ),
                        items: ['All', ...categories]
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => setState(
                          () => categoryFilter = value ?? 'All',
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
                    child: Text('No training records found.'),
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
                            backgroundColor: overdue
                                ? Colors.red
                                : primaryGreen,
                            child: const Icon(
                              Icons.school,
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
                            '${record['courseTitle']} • '
                            '${record['category']}\n'
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
        label: const Text('Add Training'),
      ),
    );
  }

  Widget _dashboard() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          _stat('TOTAL', records.length, Icons.school),
          _stat('COMPLETED', _count('Completed'), Icons.verified),
          _stat('COMPETENT', _count('Competent'), Icons.workspace_premium),
          _stat(
            'REFRESHER',
            _count('Refresher Required'),
            Icons.refresh,
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

class _TrainingFormSheet extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> statuses;
  final List<String> categories;
  final List<String> competencyLevels;

  const _TrainingFormSheet({
    required this.existing,
    required this.statuses,
    required this.categories,
    required this.competencyLevels,
  });

  @override
  State<_TrainingFormSheet> createState() => _TrainingFormSheetState();
}

class _TrainingFormSheetState extends State<_TrainingFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {};

  String category = 'Mandatory HSE';
  String competencyLevel = 'Not Assessed';
  String status = 'Planned';
  String renewalRequired = 'No';

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
      'courseCode',
      'courseTitle',
      'provider',
      'trainer',
      'trainingDate',
      'expiryDate',
      'certificateNo',
      'assessmentDate',
      'assessmentMethod',
      'assessmentScore',
      'evidence',
      'renewalPlan',
      'remarks',
    ];

    for (final field in fields) {
      controllers[field] = TextEditingController(
        text: widget.existing?[field]?.toString() ?? '',
      );
    }

    final existingCategory =
        widget.existing?['category']?.toString();
    if (existingCategory != null &&
        widget.categories.contains(existingCategory)) {
      category = existingCategory;
    }

    final existingLevel =
        widget.existing?['competencyLevel']?.toString();
    if (existingLevel != null &&
        widget.competencyLevels.contains(existingLevel)) {
      competencyLevel = existingLevel;
    }

    final existingStatus =
        widget.existing?['status']?.toString();
    if (existingStatus != null &&
        widget.statuses.contains(existingStatus)) {
      status = existingStatus;
    }

    renewalRequired =
        widget.existing?['renewalRequired']?.toString() ?? 'No';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.94,
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
                    Icon(Icons.school, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Training & Competency Record',
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
                    _section('TRAINING'),
                    _field('courseCode', 'Course / Training Code'),
                    _field(
                      'courseTitle',
                      'Course / Training Title',
                      validator: _required,
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: category,
                      decoration: const InputDecoration(
                        labelText: 'Training Category',
                        border: OutlineInputBorder(),
                      ),
                      items: widget.categories
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(
                        () => category =
                            value ?? widget.categories.first,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _field('provider', 'Training Provider / Organization'),
                    _field('trainer', 'Trainer / Instructor'),
                    _field(
                      'trainingDate',
                      'Training Date (YYYY-MM-DD)',
                      validator: _required,
                    ),
                    _field(
                      'expiryDate',
                      'Certificate / Training Expiry (YYYY-MM-DD)',
                    ),
                    _field('certificateNo', 'Certificate Number'),
                    _section('COMPETENCY'),
                    DropdownButtonFormField<String>(
                      initialValue: competencyLevel,
                      decoration: const InputDecoration(
                        labelText: 'Competency Level',
                        border: OutlineInputBorder(),
                      ),
                      items: widget.competencyLevels
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(
                        () => competencyLevel =
                            value ?? widget.competencyLevels.first,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _field(
                      'assessmentDate',
                      'Competency Assessment Date (YYYY-MM-DD)',
                    ),
                    _field(
                      'assessmentMethod',
                      'Assessment Method / Practical Test',
                      maxLines: 2,
                    ),
                    _field('assessmentScore', 'Assessment Score / Result'),
                    _field(
                      'evidence',
                      'Evidence / Certificate File Reference',
                      maxLines: 2,
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: renewalRequired,
                      decoration: const InputDecoration(
                        labelText: 'Renewal / Refresher Required',
                        border: OutlineInputBorder(),
                      ),
                      items: const ['Yes', 'No']
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(
                        () => renewalRequired = value ?? 'No',
                      ),
                    ),
                    const SizedBox(height: 10),
                    _field(
                      'renewalPlan',
                      'Renewal / Refresher Plan',
                      maxLines: 2,
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: status,
                      decoration: const InputDecoration(
                        labelText: 'Training / Competency Status',
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
                        () => status = value ?? 'Planned',
                      ),
                    ),
                    const SizedBox(height: 10),
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
                        label: const Text('Save Record'),
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

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final data = <String, dynamic>{};
    for (final entry in controllers.entries) {
      data[entry.key] = entry.value.text.trim();
    }

    data['category'] = category;
    data['competencyLevel'] = competencyLevel;
    data['status'] = status;
    data['renewalRequired'] = renewalRequired;

    Navigator.pop(context, data);
  }
}
